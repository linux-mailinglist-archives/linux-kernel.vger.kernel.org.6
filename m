Return-Path: <linux-kernel+bounces-532275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A47A44AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6122B3ABF52
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB401A7262;
	Tue, 25 Feb 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ELaoWmCq"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743E1A23A9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509708; cv=none; b=qBvR9MDRlUqLVAJ6Iak/W2MQMD8OQvG9n115tUkxSF/P8qVSe/ULmikKVbGCp17KPrk/VvWq8CjAb8qnjHX8kFuwsueopVZQwqfl+3CQs9e+pFTLvI2l/NU3Tr9CXYn2QxgGrgcGNMgulSw6+3WNPva9AxxaegCaStcCzMUpoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509708; c=relaxed/simple;
	bh=PYHSgLO7lQsS8Kx+B9mtZoE1y7zDRkButLc9RwemdLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REBE6RHYw05zKbp5dYlQbLW0tsiWQlqKt4y1fkT+cn222oVACpG9iqTNC1kTlPzFp59L9XjMkJnRpS8radWJz/xjEZuGwQOWVuJeoBmozPI5Q0YrWGOwvXwZ5/+iPv1KgEh5jIfhsJerklXJGqnpQoF7JDhsy/hyA3om2PWfJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ELaoWmCq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbda4349e9so871926366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740509705; x=1741114505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+rWhtD5x8D6XUhYZf1P7I+awMTvGfoNgd9n4DqDTvI=;
        b=ELaoWmCqO4eg5spGLL2TEeE9Crn7uH81+THRp8z29jMY+Jd3nucMxsQMYSwAQ0pQep
         gkB+xak+oQ5KVIEKmLj7D8kZgKAa/yBqqaFzyIovCYY7l+0KKSwweNDI2nM6+/vDmb1e
         MAtY3ugPb7VM5sx3nfxmvN6GqRwR88/xbLG/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509705; x=1741114505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+rWhtD5x8D6XUhYZf1P7I+awMTvGfoNgd9n4DqDTvI=;
        b=Bc0fY09KywX2nPLfk00wIHxYdite7hRT+tRePAZUEbYUPxZK7XBuupuEzD+BnQx2XP
         DpLHeUoUq9nhCO5KCTPe7/jWV+z2/UHrmKtaNUNEIlVuO3oUDYEOwCMZnNQeY7mWsYFY
         nP4QqDetV8HZ4aYFznf+Wpps3Rk94oUyiwWuOqKL0LWJ9k7rVRB4S5EMHxrdauVG3QPX
         rVJePs0jmodXGj8a4qkURMhXkhHRVSv66LEKSa/tBAWR16vUgeKfvm8szmNbSzeAsEOY
         oZZrITEhfL5qSaGtEB0qIjwyxU4YeIec7cGwYWifdI619N1tFyy2u4VwiFGLovZYgRJ3
         pWTg==
X-Forwarded-Encrypted: i=1; AJvYcCVFbki36WXJZAV8VJXDCaNHj6JiAlivZNpU/7KNGRG0za3zvtmUdvADRMS0lQAyoTFBOtjslA0X3mrBgIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+4rGY7X7d6v7dJmBxq36b2my4YwLrc2jXrIyRm7uoeEn61Gm
	8arNT1oEKDBwUusQfb9ZHrw9UNibROqJ+PrzvjFn6xe4lyB4EWZ/qt1KHUfiFEODMQgcsItrbEC
	oeCU=
X-Gm-Gg: ASbGncsLD6ZpEeHT3GACsGXtENBRHfrNdISPVonOuV4hS3+9XObxa/MIWBJQwzm08qo
	cwwDEpFn7efuyFePTdMOj34mSZuPb3fQ7FlsWBo+DQFOt9aw0lBmUArS3u0MCFZHzMbnhD5qMfM
	65ieI3I0GR2vb+rxBCuVPyrhQ5nsolBJEL57d0HjNG9wdimMrhvYNJ9AdGhEhg6lmQ+Ktzzx6o5
	ZNh++I0n+3VQrpW1375i6UWaJtBBzqi7OO/LgFAxz8tIlrvVcPo5HxnP4FB6DSKChDxr5R97JK+
	FeUnr/n8ewYpioCOUzjXoPze8frMxZtWpCiNg3lJEdSXZfAfF5Tt52Z0JPPzYF3OHSOiSf2bPyi
	c
X-Google-Smtp-Source: AGHT+IEyilJbscHJ1rg4gw7JaDIMymrEUAMTJGr6021Bbkq1AISN6tyzfJlADh1b6i5j0Z4395yZVQ==
X-Received: by 2002:a17:906:310b:b0:ab7:da56:af95 with SMTP id a640c23a62f3a-abc0d97c68cmr1718407266b.2.1740509704759;
        Tue, 25 Feb 2025 10:55:04 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbf06sm184589466b.23.2025.02.25.10.55.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:55:03 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso8040010a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:55:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAhgP+9Mpu3KzJMDKjA8vcKB4CUDlAy42hC0t6Xv6xgDu7NcdPUu67ADy/IlBj8BtGbaIrKTKeMPrEEkA=@vger.kernel.org
X-Received: by 2002:a05:6402:2b86:b0:5d9:a54:f8b4 with SMTP id
 4fb4d7f45d1cf-5e0b70dc05emr16845178a12.11.1740509703150; Tue, 25 Feb 2025
 10:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
In-Reply-To: <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Feb 2025 10:54:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
X-Gm-Features: AWEUYZk0cXay_isXRx72KKy4FfsgUiBHKihS09o_3cl8pFnpf_e0Ez6oe_KpUXU
Message-ID: <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Alice Ryhl <aliceryhl@google.com>
Cc: Ventura Jack <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 08:12, Alice Ryhl <aliceryhl@google.com> wrote:
>
> I think all of this worrying about Rust not having defined its
> aliasing model is way overblown. Ultimately, the status quo is that
> each unsafe operation that has to do with aliasing falls into one of
> three categories:
>
> * This is definitely allowed.
> * This is definitely UB.
> * We don't know whether we want to allow this yet.

Side note: can I please ask that the Rust people avoid the "UD" model
as much as humanly possible?

In particular, if there is something that is undefined behavior - even
if it's in some "unsafe" mode, please please please make the rule be
that

 (a) either the compiler ends up being constrained to doing things in
some "naive" code generation

or it's a clear UB situation, and

 (b) the compiler will warn about it

IOW, *please* avoid the C model of "Oh, I'll generate code that
silently takes advantage of the fact that if I'm wrong, this case is
undefined".

And BTW, I think this is _particularly_ true for unsafe rust. Yes,
it's "unsafe", but at the same time, the unsafe parts are the fragile
parts and hopefully not _so_ hugely performance-critical that you need
to do wild optimizations.

So the cases I'm talking about is literally re-ordering accesses past
each other ("Hey, I don't know if these alias or not, but based on
some paper standard - rather than the source code - I will assume they
do not"), and things like integer overflow behavior ("Oh, maybe this
overflows and gives a different answer than the naive case that the
source code implies, but overflow is undefined so I can screw it up").

I'd just like to point to one case where the C standards body seems to
have actually at least consider improving on undefined behavior (so
credit where credit is due, since I often complain about the C
standards body):

   https://www9.open-std.org/JTC1/SC22/WG14/www/docs/n3203.htm

where the original "this is undefined" came from the fact that
compilers were simple and restricting things like evaluation order
caused lots of problems. These days, a weak ordering definition causes
*many* more problems, and compilers are much smarter, and just saying
that the code has to act as if there was a strict ordering of
operations still allows almost all the normal optimizations in
practice.

This is just a general "please avoid the idiocies of the past". The
potential code generation improvements are not worth the pain.

              Linus

