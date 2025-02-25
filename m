Return-Path: <linux-kernel+bounces-532665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2462BA4507D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814D01897DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1F1C84C8;
	Tue, 25 Feb 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLYeWzf7"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3002309AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523799; cv=none; b=BSY1UWOQDvMdm/6e3fOyFcnhrQv9mCR3sRYqTVsXkI4a3qpbmzApolMtAyXtTCk0HCGVtXiku4UVq7ALzxAi9guqb108v7zeHVLwunYivVWfpfOleLuHXqcp+gZmPqQfqWOfvnMTNA61qsJXSCB8mbJ02M/OU9S5xZWC7jFg+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523799; c=relaxed/simple;
	bh=ZPDs8LNZsJnYQ9iypBZFXD84ihEHpoj8WDp6I7n5MoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbRz8oPPOPZxZhMBQvUn83mSAfyLKTH9XFikqHLgdHkxXVQqU0mE6ob4wJlap3hjDYrRB3oh11vj9VN+1trzum/NXaL/0z0R3F0Hdj4gvo4hCvoFXQ4/6sIcJUVQY/i1EO2oTFN2RHSTBUcQgI2nypCFgsHCE1KehSYKEB3Dius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLYeWzf7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f403edb4eso3666360f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740523796; x=1741128596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLb9xdr33jY7x/utSZ7Yba2eaqmn62xwf00HqA96Qdg=;
        b=TLYeWzf750XJ8CL9kukGUzmKTvy0MwQ4Lwz8LM3D4SpK+uiELcWOHe+A+Exk+7KIW2
         xRl/GU4XS8o8pMAFdpvH1fSd5BrBGSj7LZmiUl5EkoQyuiNBjUQGU7Ry0i6IgsAQ77fC
         F8FmzrCHXgFA9G1i5dYF8wLymo4x86QzHPEzODoI/Gm0s89N3cGk9xAs+VPiyXZQsXXs
         Mg3CdMKM6fR3J4CTsRhf/KZq2vwnFm8q8VTkOFTgATo9iDWx0o5g6OHwIulswpxvaLPC
         3ocQ7wEH/ZmnQ26CzCZmOa1gPh0Wtl85ltXYTaRbtVUsrugjYCR/hAFS+aKiiEZv7XGd
         ESZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523796; x=1741128596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLb9xdr33jY7x/utSZ7Yba2eaqmn62xwf00HqA96Qdg=;
        b=jnwRoyoTxcQTihGzYlzQ9juwBg+uIzwKSgv62Qp5F3yDDbF70a9u3AeLxB45O3OWbq
         7ueeBYw07yUtm6UJaT4PGrtdxkwEFnIB3JzzbUukVsn3sADQP0Hj0tHBwRMjv/BMY5h0
         OCdnBSdOwa5zjFdVGKOrsh2d7iFiVS13x2eWL+BKtUPV6vnCKTx8PBEbeUtCoI1MacCR
         UrdlANKPEhv5D+iVS+CR4578S14M8pVQet46NwSX4HOeMOOR4tFFIrQsI3ubGOJpwYBb
         xPdeti9LJ4T2Y1jVdaid1MMFua48dSIVjp4siiruiHYTZPSBjSb69eCYB339Szhyzlqj
         cjQw==
X-Forwarded-Encrypted: i=1; AJvYcCUz4845AykThUWw2P9nedf5KDgLU/Jpcn274ScaBvl6tzkbeIm+jdnUD3elBM6HXdjK6Ac4o+dpf3AN2FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBka0MTBPguVEUdlOKF65gMh/KkYY8B5RKlJXLqlSZddV/FNr+
	pDsuZ5VWJShCapicqUMnCQlun8CqkSaEsXbvz6zFXO/4l1S6L0Z8
X-Gm-Gg: ASbGncu9E1e2iqk9fzsmYM5n86CzBi961P7lzXJD8IwKB+7uf8n3aQuFCZjfx6ZYwQp
	p9BFoag1HuYFaZXu7fqL5T+QY5nwGQw8u0teZvv3H5RROGA6cH7cDqxFvMCjtv1LNRpjQx0xjNG
	Pb+vy7xk1GxCbMkqMhzU5eRdCn0b1feRCbFzUEjlqfP7W7Mu0tQmmGtxxw5glfGvvsnaKaGojvZ
	+pNtdXNGEI8jrEaw3Kw9lkXLp1nE4RftkKkT+9pOjUIwhlFYAs5a5nQM0CjzDoy2dDsjMuCpHfz
	yScSsShV8dYn6qBbKkWB31Lm8OUZwydfJFyePS8iACCZIwYxMGO6rz9R99FPpMC1
X-Google-Smtp-Source: AGHT+IEwtF38qaeTV7BlN284dLspJxz9Zu1Bz3VFTTaz7FUxJjMXShkv4nJrcPh6zoVhoNxEIB80bA==
X-Received: by 2002:a05:6000:1447:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-390cc5f20e0mr4597676f8f.3.1740523795819;
        Tue, 25 Feb 2025 14:49:55 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fbb5dsm3592424f8f.84.2025.02.25.14.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:49:55 -0800 (PST)
Date: Tue, 25 Feb 2025 22:49:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Martin Uecker <uecker@tugraz.at>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds 
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250225224954.4766e018@pumpkin>
In-Reply-To: <fd053f18e3856d070d695ea969b3fd635272e8e0.camel@tugraz.at>
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	<CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	<a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	<Z7VKW3eul-kGaIT2@Mac.home>
	<2025021954-flaccid-pucker-f7d9@gregkh>
	<4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	<2025022024-blooper-rippling-2667@gregkh>
	<1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	<2025022042-jot-favored-e755@gregkh>
	<b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
	<caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
	<61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
	<20250221124304.5dec31b2@gandalf.local.home>
	<CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
	<6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
	<CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com>
	<20250221172415.5b632ae6@gandalf.local.home>
	<fd053f18e3856d070d695ea969b3fd635272e8e0.camel@tugraz.at>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 00:37:01 +0100
Martin Uecker <uecker@tugraz.at> wrote:

> Am Freitag, dem 21.02.2025 um 17:24 -0500 schrieb Steven Rostedt:
> > On Fri, 21 Feb 2025 11:30:41 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >   
> > > And yes, it's wrong in general. The problems with "x < 0" warning for
> > > an unsigned 'x' are deep and fundamental, and macros that take various
> > > types is only one (perhaps more obvious) example of how brokent that
> > > garbage is.  
> > 
> > The bug I recently fixed, and I still constantly make, where this does
> > help, is the difference between size_t vs ssize_t. I keep forgetting that
> > size_t is unsigned, and I'll check a return of a function that returns
> > negative on error with it.
> > 
> > If I could just get a warning for this stupid mistake:
> > 
> > 	size_t ret;
> > 
> > 	ret = func();
> > 	if (ret < 0)
> > 		error();
> > 
> > 
> > I'd be very happy.
> >   
> 
> GCC has this warning, it is called -Wtype-limits

That bleats about all sorts of stuff that is reasonable code.

> 
> https://godbolt.org/z/M787vjhfo
> 
> It is activated by -Wextra.
> 
> (anyway, not at all related to my proposal)
> 
> Martin
> 
> 
> 
> 
> 
> 


