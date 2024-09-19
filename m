Return-Path: <linux-kernel+bounces-333117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09D397C41A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8682D283F72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83C15FD01;
	Thu, 19 Sep 2024 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onnrizpC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E801547E1;
	Thu, 19 Sep 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725695; cv=none; b=T8PaFWxm72GmXk4JoD9GWQIxo8mqBBS2+iTLjUKd0ILxFn5m3IVjsJkl426ImO98kRUgi4ijGiFYUhqc65u/wPJwvDnR9vhbnIfJTezwsGLnZksCxyo3scKwdFctZg9bXzmbw0CVbjJZwYYQa8ZtqvOjcF8yGMfvS74LWman9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725695; c=relaxed/simple;
	bh=FEwqmty87AeplhzrOpyi9co2ptoh4xmuGz8Qe//jGtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y6taP9ZSwfgnAT9FqvQ4V3EdZe/bAaR95vd2LE3Ej2JWNXqTw4JPo/wXlbBe5F/5o2jHOVM8gBgpU0jZrlPTmiVDxXH3hFIFvgg7uHF6iq5EbA6vZ91t1kMM5jZ6xpKkioA10j2skHpvpmiRQ92Sn5IBt9j86mu/d10vFbThwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onnrizpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B07C4CEC7;
	Thu, 19 Sep 2024 06:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726725694;
	bh=FEwqmty87AeplhzrOpyi9co2ptoh4xmuGz8Qe//jGtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=onnrizpCPqPyRfASi1JTk3Fueg1cm6KJyArh/e3hpyFAVvFZqUF5NOmnZ8TK4oX02
	 kHLmt9/aAAvdWBLXOVQdA+PaYHxdaVGy6CFwZk2Aem5WnbaXxGqnlBP0vdBpRQQwgJ
	 eo07EsTmv6rkL93BwS8O/8+8ju7yLmoZWhXYY8J0sw7utG5zfsP/qxXYU+O9Ao1/dm
	 tyOO7s6xfP0Pw7vbj21xAwcWTBXAm0kS4t+eI5YUpf247VUSoMgz2AD1yTsleNzZ/c
	 VUOI0oY+GPKQvfXGBiYRSI9p2oe9afvasxHu3INfn15K48DWnuKygfMBrNK4RpB8Dg
	 0Dfwb4EnIyRVw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Benno Lossin" <benno.lossin@proton.me>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>,  "Frederic Weisbecker"
 <frederic@kernel.org>,  "Thomas Gleixner" <tglx@linutronix.de>,  "Boqun
 Feng" <boqun.feng@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Alice Ryhl" <aliceryhl@google.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
In-Reply-To: <20240918211211.73b1324e.gary@garyguo.net> (Gary Guo's message of
	"Wed, 18 Sep 2024 21:12:11 +0100")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-5-a.hindborg@kernel.org>
	<43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me>
	<6J_M8_wAnE5epFRUo8RBkYFL5p36woueX8MHQleKVFw_WOitLFZNQ6808RjS7RmizhQ07qDQpze2G3UDLZgHDA==@protonmail.internalid>
	<20240918211211.73b1324e.gary@garyguo.net>
Date: Thu, 19 Sep 2024 08:00:39 +0200
Message-ID: <87zfo4i3nc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Wed, 18 Sep 2024 18:19:20 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>
>> On 18.09.24 00:27, Andreas Hindborg wrote:
[...]
>> > +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
>> > +        // SAFETY: The caller promises that this pointer points to data
>> > +        // contained in an `Arc` that is still valid.
>> > +        let inner = unsafe { ArcInner::container_of(ptr).as_ref() };
>> > +
>> > +        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot
>> > +        // overflow to zero. SAFETY: By the function safety requirement, there
>> > +        // is necessarily a reference to the object, so it is safe to increment
>> > +        // the refcount.
>> > +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
>> > +
>> > +        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
>> > +        unsafe { Self::from_inner(inner.into()) }
>>
>> The implementation of this function looks a bit strange to me, how about
>> this?:
>>
>>     // SAFETY: this function has the same safety requirements as `from_raw`.
>>     let arc = unsafe { Self::from_raw(ptr) };
>>     let clone = arc.clone();
>>     // Prevent decrementing the refcount.
>>     mem::forget(arc);
>>     clone
>>
>> (of course you would need to change the safety requirements of
>> `clone_from_raw` to point to `from_raw`)
>
> Wouldn't this function simply be
>
> 	// SAFETY: ...
> 	let borrow = unsafe { ArcBorrow::from_raw(ptr) }
>   	borrow.into()
>
> ?
>
> Maybe this function doesn't even need to exist...

Maybe that could work. But my use case does not satisfy the safety
requirements on `ArcBorrow::from_raw`. The`Arc::into_raw` was not
called. Perhaps we can update the requirements for that function?

Best regards,
Andreas


