Return-Path: <linux-kernel+bounces-527814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE3A40FCB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9A11895700
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E00132111;
	Sun, 23 Feb 2025 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U04tkOHC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D439FD9;
	Sun, 23 Feb 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328928; cv=none; b=qWytpZSo9sAZxCn5Wm96AFDFi9Pf6dNjPae4b9E55OOVNuyfg2gOzXFHUfDwPxihZu84O2sbWQ0hRz7KIdV7XsdvKl1LM4u173HIvsspoCfO8I+13jpQggfdd2q4xnPVZ6yb2jPnW+gQlbjV835QKxTtzbQWsbFq4JnOEtAbaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328928; c=relaxed/simple;
	bh=iH0RTEfYSIc65pUhd2cqJOtJ4XewpQvlxlkaoIEIQWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5qlIvCHBTqYKA9yG2xiOxJqoGIdPeK5DPr939V0IHIk3slJdV7qRxyxCBDy+23ub5RsAXLtsJTzocQEdmy+oJBOSvn3mxDHwjIC9EwkXpsC3H3BOOb33Ckri05rOlLD7vq9TRtCQSWvspuMfEYl152c/NMfUn2o8RjhX8GHxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U04tkOHC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43937cf2131so24359875e9.2;
        Sun, 23 Feb 2025 08:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740328925; x=1740933725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxNewYB9W7yZGVWnL7Rq8e0t5q3ZmDQjfdFwbmexFXk=;
        b=U04tkOHCbAZWkc/jNVkDnRSWVx3Y/6wcbo3kPiVAizBZLQtX2sWvXj6cIupM6MKyp1
         piWNv224De/jyOUTNICBvqN3XGoRm+2ZfNERGe8EF366grWlN7kyjVRXiTCeBxKRS1G0
         fedIuPhDSOw7nKIIEGArpzqN8Z2j/NtqlKngHF5ZFdYbJnvWQk13ujHb6SpXxHsaWnAf
         O0Soqe0Rh3Q5b1NUo9JQDeKzcoaq4ztobyBGDSjmZ+XFh+wxL1/I8te9tUa1NhJiWARk
         SwslaPt2oZgxvuLPq/hH1GJqNzW1dEvFJMKPWN9iIucvOpp2nWdF37q/TKE2/n5MMrYc
         HI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740328925; x=1740933725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxNewYB9W7yZGVWnL7Rq8e0t5q3ZmDQjfdFwbmexFXk=;
        b=NZ0QUJBF5B1TZvCume0iFPc11UPxsryKF0v7gsJ3kBSMs9njiDvVtq8s7UpycO+eUR
         lbYLbj1P5fZppqtNztCuPv37H31/g0iS/vX5E9V5RstAdVbfnJe7LbHeqHhREwZOBAaw
         1pJI2iDPeFiuzu//WsHNeqshgvSmeFwZrYa1ujDe1HstgEkqDaJ0k0/R3zHJr44HSQjP
         ltFTFkJff3DQ6pSS7TIBvaMPfoM968UthnBOV2QVspnrBgXeHhXyIW/33tMKOj7sOmsZ
         9VuEEDZeZWFBZJ89U3GOMruZp/DQVTY9tKSfL25eUrP7QHbZsfD8iZrHx3lUnzQ+ALHX
         4ISA==
X-Forwarded-Encrypted: i=1; AJvYcCVhk/CTm9AxSvrFiNByjf1UpP3XtxAkpFcT6R7Njq1f4qeiTNp/aiPR//5ErjcSdwg20VoIlAnPxiE1I+vQAm8=@vger.kernel.org, AJvYcCViG1gy61SrwmTk1p3fLG3o6iVs+Jb0Ww9lURkbRozGiX0X7qnEYADHeZjOIy+QKQt8nqLgxBUDgPpixWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybkb0bW3gmoD8zgMEYXL0BqblfWzbS6BauSuzwXB+8VI38VjNo
	U/l6bMSZDhrpHAKSQOU/ml7S39/HukmlXp7uBIh96EMRfQo7phZ2
X-Gm-Gg: ASbGncsLtC17HN/BJYLHAJD5AJp6Bs2rA69kQXuR3KTkeGUZOWKtqmz+0fdjyX1p3yO
	d3c9mekNDpEDXjLa66TGy0ecz2mYf59sTAbcq4DE2JheDoCNboF5QkkFat7gwls8EgtespiERKu
	dgcaq62yiLemF2znPsTDtzrmlKVK61/jw4NHryfMEw3LfeeIibFC2T3twuuQHTDj9ZPXu9FR3g6
	0HmeJhu/BrHynkF8iAwHtCSRrcK/PPrIb29KF5AFtk55vmi7LwVXIgeQh5sMkwrGcqafG3K+3ur
	1OPJa977I7Yd0mZn4fabW6uNnen1iRfB+LKd6JddCns5GajVNKATM8jdy9m4Rzt5
X-Google-Smtp-Source: AGHT+IHlXssYkIn+lrJDIexDFsyeWa8LiuwhIroMlUkUAi1TMAGlcv900iJiIwa30ux44Scu/nsQuQ==
X-Received: by 2002:a05:600c:1c13:b0:439:98b0:f911 with SMTP id 5b1f17b1804b1-439ae1e9aa8mr95801595e9.10.1740328924524;
        Sun, 23 Feb 2025 08:42:04 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0367507sm82737345e9.28.2025.02.23.08.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 08:42:03 -0800 (PST)
Date: Sun, 23 Feb 2025 16:42:02 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Martin Uecker <uecker@tugraz.at>,
 Dan Carpenter <dan.carpenter@linaro.org>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250223164202.550f14b8@pumpkin>
In-Reply-To: <CAHk-=wjQ94GipftbNo0PbfuUxFMXFyp2bWGJJPNUngyf17Ai8A@mail.gmail.com>
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
	<CAHk-=wjQ94GipftbNo0PbfuUxFMXFyp2bWGJJPNUngyf17Ai8A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 15:04:04 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 21 Feb 2025 at 14:23, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > If I could just get a warning for this stupid mistake:
> >
> >         size_t ret;
> >
> >         ret = func();
> >         if (ret < 0)
> >                 error();  
> 
> Note that my main beef with the crazy compiler warning is that it
> literally triggers for *RANGE CHECKS*.
> 
> IOW, it's literally the "if (a < 0 || a > XYZ)" thing that absolutely
> MUST NOT WARN. EVER.  If it does, the compiler is broken.

The other one is where it already knows the code is being discarded.
I suspect it even warns for:
	unsigned int x;
	if (1 || x < 0) ...
You can't even escape with Generic (a switch statement based on the type
of a variable). All the options have to compile with all the types.

	David

