Return-Path: <linux-kernel+bounces-535097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB07A46ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63E3188B2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21F25E839;
	Wed, 26 Feb 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRSvzFfz"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6F25E800;
	Wed, 26 Feb 2025 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610460; cv=none; b=cPi0raZzwIOK6L+jI6GBhPOw8w2qrtxfxAv4IX+HNL16Xphl2+uNw7HKqOJfz3p292W90/kGnGk3VdffbYaHXQshK/cuKVCsxBryq9Qx1AuoPiNeCdBJAR24Jy784WL8NiWTg2jys3yH7Sjmu5MrR/yHaBSYs3+XMDte53BXna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610460; c=relaxed/simple;
	bh=1sPPljet3ACTgKI4+mgP1c5oGZKB8Hf8G8BN7ZnjVIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0icqHbCAuxMwauNgLxsJD6UNUDxOXm/8oIWbRr+glOxA/5C2yERLDSxYfuGxlz74IIb2VULKf3501ISWLMbHrEtcZYmn7S+OnqVRW98Yd16Eb4IEiK5oHbKjcclQV/Ju1C2zQE40mWx6MOYL+4tDH5Rs/gg1PdjGoTM8bEBPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRSvzFfz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f31f7732dso224668f8f.1;
        Wed, 26 Feb 2025 14:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740610454; x=1741215254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SLvO084dN+2d+/gLjub5lI3vWtdzNWw7Y3/rBNHH74=;
        b=TRSvzFfzKnjx46pzkPDgkDZGeWWejeA067W26Gm+iuFGTMdpqvg52S+7015Uudj2JY
         SwVjJ+Bs8y2O9TbLHBP14u1vwNIb91ERYER1FThG+q5Jn/JiNiv7NarKd7tIfT6U8f+Y
         uRZQ7OevivgVRpBNzFNaQCaw6e8pvXOShdGfYgDHxG79o72cr94TV9aNbvOLBZioSx/M
         hp2vqnO1akPZ5f7IPz5jJtKk1oydUZlz7GM6xWYcP7I+Wx5mECHgZaX+LEbPCIVJSO+O
         4pJ3p/MjdZ3cud8uu70Uzj0OCuMM821wHAqvtRyvbZiQk//Cp0VoTkiyN1LF2We/YKZp
         rFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740610454; x=1741215254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SLvO084dN+2d+/gLjub5lI3vWtdzNWw7Y3/rBNHH74=;
        b=IId2oPjG4448j4kOZ6WnONVlNTP585kzQPUE7XXDrgeBJkLKa05pu2l5hnJB9LSLZM
         9GR8rskM1oXHESxYsgBOmPFgJY28BMnPWXVj9+yEJk7KMbzfoDxVJbUKfOT4eNHxzfCh
         dor3Vcw6mHH7lGVupsHio+/VuEym4HxAKm9xzy4PDYAcJNkPDE1u/v9Pioh+aXFsmSEr
         Z36Jw0wv5pQexvoKqLSUpvCYqWo0iusDnOdCQhLnr0Sns39MXjlvs3R+KZMqaeOmfdLD
         K8MsE+C4XfC5d0P3Nh4jpstPcFtbmM97p+FxdU4voFSRFdAK2deczeOgS+H2Lt9+8yFD
         JJdA==
X-Forwarded-Encrypted: i=1; AJvYcCUOMXkN9M+Akiulbs94PSoejgKXdryx85aW50K6SUNzo8gvVLk/3IPsdr/ahJItTFAlqmkBCzwVJ6zm6xDD0vw=@vger.kernel.org, AJvYcCW2hvMv7fJ4kJ0+78d2bt0C/f/S/dgtP47lddqeS1CuWrBt5vowlpNALAnIdhQsgF1jpRJGxdeMYtRYsR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PQ78oiLUKmyOGxJk5YITzoKRyZnNzNFYUE3gNh1QFSRawvIm
	LOm8meVsDLKRmP4xlg+3vO+MCXQxctxnBadnzXlN9hlN12oZrsR4
X-Gm-Gg: ASbGncvrTHcAGdVhdeS6QaWxjuQPcAMR9fPuy8szw42N2DP+NH7+pcIDRUPsZXXOjQT
	f9Bx7qAKN0Hgx4JWGFUmqfWCdcozSQi9Ak8eArl5gsga9SppO0XF0Ph5Crb61BP8zt6Rejokzo+
	32byvrxOMXaPSc4bslf8eaais7dpK/omtZacoA57bNbKsX40f1kwATX0elXpz1ltAGPjVInxxUA
	jjFmqV0aaEzze2+apWI5rIiT5qdZFjai/NUmT8DNSxmkFHADEs/uypJeLkTXjFwaEi0MbXGTrFN
	LCNE2/x+DcT34f3VSLfAZDiBbysCf9z4Q9UR6Ao3VPEiGVOjm+n39vJS8tg8MxeV
X-Google-Smtp-Source: AGHT+IHC+KkP1LTJHqKHVvWCgThNFJjKkJxpW6IERDcsLbEjELPz4ud+GHuN+VTB6Z2Q7/ZHjZSbAQ==
X-Received: by 2002:a05:6000:188f:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-390e169981emr1006277f8f.21.1740610453752;
        Wed, 26 Feb 2025 14:54:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484452asm184751f8f.61.2025.02.26.14.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:54:13 -0800 (PST)
Date: Wed, 26 Feb 2025 22:54:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, "Paul E.
 McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Ventura
 Jack <venturajack85@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, ej@inai.de,
 gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226225412.35133185@pumpkin>
In-Reply-To: <CAHk-=wj3C7Gc7pB0BD+5dvrFWh8xNJLYgupq6parOCFk94VyoA@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
	<20250222141521.1fe24871@eugeo>
	<CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	<6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	<CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	<CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
	<5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
	<CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
	<ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
	<CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
	<CAHk-=wj3C7Gc7pB0BD+5dvrFWh8xNJLYgupq6parOCFk94VyoA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 13:21:41 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 26 Feb 2025 at 13:14, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That "single read done as multiple reads" is sadly still accepted by
> > the C standard, as far as I can tell. Because the standard still
> > considers it "unobservable" unless I've missed some update.  
> 
> I want to clarify that I'm talking about perfectly normal and entirely
> unannotated variable accesses.
> 
> Don't say "programmers should annotate their special accesses with
> volatile if they want to avoid compiler-introduced TOCTOU issues".
> 
> Having humans have to work around failures in the language is not the way to go.
> 
> Particularly when there isn't even any advantage to it. I'm pretty
> sure neither clang nor gcc actually rematerialize reads from memory,

I thought some of the very early READ_ONCE() were added because there
was an actual problem with the generated code.
But it has got entirely silly.
In many cases gcc will generate an extra register-register transfer
for a volatile read - I've seen it do a byte read, register move and
then and with 0xff.
I think adding a separate memory barrier would stop the read being
rematerialized - but you also need to stop it doing (for example)
two byte accesses for a 16bit variable - arm32 has a limited offset
for 16bit memory accesses, so the compiler might be tempted to do
two byte writes.

	David


