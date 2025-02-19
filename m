Return-Path: <linux-kernel+bounces-520917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D55A3B11B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE50A167AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00BC1AF0DC;
	Wed, 19 Feb 2025 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAh5ldSt"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCA1B4154;
	Wed, 19 Feb 2025 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944428; cv=none; b=aLSh8ccCdQGCo4EBSqi0U2UoKy2rYgdpz2V/JaI4lbTIRrVZO7MSwrKu2KHggvAVFdCM/dyaaXrSO76aHrpmFlEDIPD5n6udGL4xARBhz7p96ONMbuKJXEZfmK2EqP3ZxSGw2sSSADdXvP80h0GXYDi1AFllF2lld3zcrKQ46Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944428; c=relaxed/simple;
	bh=8w9lDl6R8vzWwfEIaXGD9eQE08gjr+XxPDBnLJ7uMSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANyiPkH6KiLVcDH5sgjdIkZE5Q49SrZTt0V4ibOLKDpqtF0oQy+38OXYwrjDlHmkiVsNyQECy119BdXrmgqiDNXJxl4B3jN2+9p0NGMjvi0NL7z28oJ9srk2yP5tvek5Qhii7vZ3610pkQvvU/jJwAKKKUVXT2/YKI7fg/p/D7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAh5ldSt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbb12bea54so377743666b.0;
        Tue, 18 Feb 2025 21:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739944425; x=1740549225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hoYubNUM/g2rCAi4UMr65fRF8j4p6OJUT/42WzZwWKc=;
        b=mAh5ldStRmUs9TxM3gDfJY7TtdYRmxzS/QxcgX1930HvJgIBiUu6LsO3yQ8mq81HLZ
         74MGJrVXpGADJecVJyju+EmrbEET4cnlSyiJ085d+NyXh6WzaB2Sib85+tGOltI+wNUE
         7cXu2WWaH6CsjlrN5jhp4APyH8eDyvVSLvF6Yi2LU1tH/NgynHEOald28vVvwkcCdzmB
         ittxHOzrrYKCpAoBpVZlBx0ChxhDPpDuX9HZoIyp701Z79XULlME69xeZ5EmxYkkp92b
         Cv4sJQ1Yd2keStd8+pveVXvUbzJ6c+MUr0U7MpWajUK72trAXcXyHeLSJP42GZPKkZCe
         sYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739944425; x=1740549225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoYubNUM/g2rCAi4UMr65fRF8j4p6OJUT/42WzZwWKc=;
        b=GIN+Eajn+v0j7glhbQhvFJAroM4WlHPKw1UXXMiPLOLH9a4gduuWG+BIO8m81OUqiA
         yF2QVvO0UF5WRViRiOSbDqqYCAwLLYhMCFERuyG4SJavVAYTvibLqKFmCmjlJOWi1azi
         0T4wSoKx3qjCIPiaosZnRq9sBdh92CeQ63+m5Sswahnb54nfU+UBAmZu7BmA2isa+vbe
         4FXmEzsiZGDAijFrMYWpHNuEbJY29M2YcK/fwp7HXRsLirEqxnSMQ//cx4ZZkjfKIlKT
         Ir9q2QD+435gadqUDArsJ78jPxfZw9QH9uUvco3TrCCMdpIogxCcyyNl34QLiuwS+DqS
         xboA==
X-Forwarded-Encrypted: i=1; AJvYcCVSV2MiH35JfDvVwyC5OC06gOTgjIL4iLkEOnWODtWK4/sXlVLzJKL558uSqrS0jcnDoSPhA9i+t+LDIT4vFnM=@vger.kernel.org, AJvYcCWlYzX9JYNDyH816a5oHs/CQbpDCzVOmQcRj7PJCdsQOwi6S0FWwu7txjUFBIq8FeUYEzOnI5dog260N0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrsT5Xxkumo5a98uulqby0fr4w/KfbLD5LMvOCg+DQsAVFqNz
	UuKepDQ0MrfJN/WsQIS4zMhAe4XrA4YN8FFHjDZ5GKjjQF8+h9NNbTlV
X-Gm-Gg: ASbGncszXGeAnHXboi9/bwOpfrpodLpYIQGwHHos4Q4Rm5TiMdHerompUH6yxEHsyuE
	6kpQoCIsfUJLAmjZkI6Zik5nJzi54jg+uch/xhyF5uTsEb1PpcpitaN8m+UIAsNoe345HSkpWsP
	zeAEBxUKFGspQv/aWE46Crv8ell1CVo56uCaL2E+z3sXcU6v1bzvfSWN/MMFAajdKJYZSt3nruH
	gHYV+XI7BG/6P2yW5+g73ldj5+WcbhWXSTl1Do/TbLnuSAd/hjjqaojdQTlfqSpO+dx09pg2/A7
	ZeNOxEbBBB5k6clJnUm73jZ+BcU3hPGZdF6OGt0YAG0UncyKrViz/ENFog==
X-Google-Smtp-Source: AGHT+IELbGf/jgctoWR5SBQOWdjIhRQbBm1V/RRwJ/UxCtMTP7qhBsZEyQgnBj6aaSRi9z2h2/QvQw==
X-Received: by 2002:a17:906:eb04:b0:abb:b092:dad9 with SMTP id a640c23a62f3a-abbb092de7fmr698590066b.37.1739944424725;
        Tue, 18 Feb 2025 21:53:44 -0800 (PST)
Received: from p183 (dynamic-vpdn-brest-46-53-133-68.brest.telecom.by. [46.53.133.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532802a1sm1192544766b.76.2025.02.18.21.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:53:44 -0800 (PST)
Date: Wed, 19 Feb 2025 08:53:42 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <c0798016-b0e9-4af0-b6aa-48903b4718b3@p183>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7VKW3eul-kGaIT2@Mac.home>

On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> [...]
> > > > David Howells did a patch set in 2018 (I believe) to clean up the C code in the kernel so it could be compiled with either C or C++; the patchset wasn't particularly big and mostly mechanical in nature, something that would be impossible with Rust. Even without moving away from the common subset of C and C++ we would immediately gain things like type safe linkage.
> > > 
> > > That is great, but that does not give you memory safety and everyone
> > > would still need to learn C++.
> > 
> > The point is that C++ is a superset of C, and we would use a subset of C++
> > that is more "C+"-style. That is, most changes would occur in header files,
> > especially early on. Since the kernel uses a *lot* of inlines and macros,
> > the improvements would still affect most of the *existing* kernel code,
> > something you simply can't do with Rust.
> > 
> 
> I don't think that's the point of introducing a new language, the
> problem we are trying to resolve is when writing a driver or some kernel
> component, due to the complexity, memory safety issues (and other
> issues) are likely to happen. So using a language providing type safety
> can help that. Replacing inlines and macros with neat template tricks is
> not the point,

In fact, this is the point.

> at least from what I can tell, inlines and macros are not
> the main source of bugs (or are they any source of bugs in production?).
> Maybe you have an example?

C's weak type system forces people to use preprocessor which is much weaker
language.

So instead of solving problems with more capable language people are forced
to solve it will less capable one.

This is not how it should be.

