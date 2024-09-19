Return-Path: <linux-kernel+bounces-333118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103697C41B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942351C22911
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63714A4C3;
	Thu, 19 Sep 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6+IMQEY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3F14A4D2;
	Thu, 19 Sep 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725700; cv=none; b=fOZGA0Qw/QBfre4hVwjAojMunVQudLoLFdmWANffil7hUpiqTeXHHr4kEryeNTcvCFBiKliuJ9fz1DBMQouNNwg4SKDBlzENCDJP/gBFBW61lg1dX8Q2j7Mxb0IxS81G4vfjVztU88twXTMe+sTtdPBOm1cJvfu9mAQa/p/k6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725700; c=relaxed/simple;
	bh=Tavix2DjYUpx/L6KLOj9yAdZF5jGIMZhgXaAgOdqhy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lm0CkcaKDCUyFCznvWAQeDukg0FTwS2nxsvPSScMuYOuISgcIyqTuoBpqFvQjDDBLol310yTs9ZIgxVqRe2DavINpB5V7phcdlY2QBQkPduEcYBBUKGzoJ1RrNjBIHdkkvW0Gpqa6Fow6so9Yn5lz22L6gqMAPGbeOPNnZ74mBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6+IMQEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC78C4CEC4;
	Thu, 19 Sep 2024 06:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726725699;
	bh=Tavix2DjYUpx/L6KLOj9yAdZF5jGIMZhgXaAgOdqhy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q6+IMQEYsIWaRUXZimA6J9n8+NQK6W5laZfVkHahJRlJMnBNn883iGbYWd4EksTwF
	 It3Ypy+hKFJ50K6k5mynJ1qmGnxzan+YIoFOeHnXHJW29xYdinDvjVgfy06PaHPw+q
	 N0S4gs1pk5t0mtaCdzEmMHsmYY4PgrfIYupOZVxOwx+bjanrbyy/ueifgvhLv1VROW
	 cfGTHvh9i544pDFXmb5UXMuJnlmNYlsb6ocla8gZPHN6aqZiuDrCI7UAHc5fmtgIey
	 tiwzdYKSr9/MGGUr6p8nZCB0kCTdJWxPd1B/j3nVBW1qsN1gBvLMVStmISncyDx9IO
	 3y2t41Uekc8lw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
  "Frederic Weisbecker" <frederic@kernel.org>,  "Thomas Gleixner"
 <tglx@linutronix.de>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <f502f6c6-40b7-4ec4-8d0c-09adb0df1a30@proton.me> (Benno Lossin's
	message of "Wed, 18 Sep 2024 18:13:11 +0000")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-3-a.hindborg@kernel.org>
	<Wohby8PLjQeZ47sXKGeWKOxdA2ShTjjvqOM6xWzhJY1aZ-SYk9TCDAnZN2EqiWuJUKwPKoFCsCofDHjtfeG--w==@protonmail.internalid>
	<f502f6c6-40b7-4ec4-8d0c-09adb0df1a30@proton.me>
Date: Thu, 19 Sep 2024 07:43:19 +0200
Message-ID: <878qvojj0o.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Benno,

Thanks for the feedback. I will incorporate all the whitespace
suggestions you have =F0=9F=91=8D

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.09.24 00:27, Andreas Hindborg wrote:
[...]
>> +
>> +impl<T> Timer<T> {
>> +    /// Return an initializer for a new timer instance.
>> +    pub fn new() -> impl PinInit<Self>
>> +    where
>> +        T: TimerCallback,
>> +    {
>> +        pin_init!( Self {
>
> I would remove the space after the `(`.
> Would be great if we had rustfmt support for custom macros.

Yes, that would be great!

>
>> +            // INVARIANTS: We initialize `timer` with `hrtimer_init` be=
low.
>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtim=
er| {
>> +                // SAFETY: By design of `pin_init!`, `place` is a point=
er live
>> +                // allocation. hrtimer_init will initialize `place` and=
 does not
>> +                // require `place` to be initialized prior to the call.
>> +                unsafe {
>> +                    bindings::hrtimer_init(
>> +                        place,
>> +                        bindings::CLOCK_MONOTONIC as i32,
>> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +                    );
>> +                }
>> +
>> +                // SAFETY: `place` is pointing to a live allocation, so=
 the deref
>> +                // is safe.
>> +                let function: *mut Option<_> =3D
>
> Do you really need this type hint?

Apparently not!

[...]
>> +pub trait TimerPointer: Sync + Sized {
>> +    /// A handle representing a scheduled timer.
>> +    ///
>> +    /// If the timer is armed or if the timer callback is running when =
the
>> +    /// handle is dropped, the drop method of `TimerHandle` should not =
return
>> +    /// until the timer is unarmed and the callback has completed.
>> +    ///
>> +    /// Note: It must be safe to leak the handle.
>> +    type TimerHandle: TimerHandle;
>
> Why does this need to be an associated type? Couldn't we have a
> `TimerHandle<T>` struct? The schedule function below could then return
> `TimerHandle<Self>`.

At one point, I had some cycles in trait resolution. Moving generics to
associated types solved that issue. Maybe this can be changed to a
generic. But are generics preferred over associated types for some
reason?


Best regards,
Andreas


