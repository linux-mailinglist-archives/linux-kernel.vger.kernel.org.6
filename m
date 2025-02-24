Return-Path: <linux-kernel+bounces-530185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC645A43040
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5F73B0874
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06270208962;
	Mon, 24 Feb 2025 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EpMhakMt"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE61DF73D;
	Mon, 24 Feb 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437453; cv=none; b=DqDXgi0ImT3xoNO5ONzP7ZCW2f+vOzi7wOvJfjCudR9IawJ4ntpMtm1dLmX4CbBa3RSiRhpGDF0KrIXN7GrdF9ykLZXP4HIf7TihWICSqEhfzltqFuTq9fZs8FMoJnbU+EIr3+JXhO3YqG1eHgJouKE2B3x2UA1tk7vJg81L/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437453; c=relaxed/simple;
	bh=JjSeIZn3Tl9arL130X2XuGh1fuwhuZw06qHF7VDxXy0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOWsTCH4K5YSOGmE4MTbLFSoprkpn8mjEJq3mxTPDb9Zr8GDai0/HndIqaEut05+CrxDQWibKV+JsWyDDFfkPTxQxz2VBidrcLgahdH29NIEP/4bZZFno7NIiVdjOKkwh5I4FYj3irQgbp/WRKCURfos4JJjZTG1y+xUOh08Nlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EpMhakMt; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=pmao5xsvivachg434437b6glrm.protonmail; t=1740437448; x=1740696648;
	bh=SWT1E+FxSOhMjfUbqdRk62nYCu2aUsyvX/tzao+XenA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=EpMhakMtQ6hQpOr5d0e4XIPEj+DdTuu7vD23MEv4qtOJt9PKfn3qbBp377DB37GhA
	 NbmESAubI746u4ff4rJIfkFuOFPWIfqCOY/71MEmhVxJyRlBpl4+C504fpbQWFSGLZ
	 AE+tSd9uEyVQO8FyhKuwYlB8ClANyfjXPxUYlweuFO+u0Ro6PRJoyndMUZf7zv6WK6
	 mT0tGqqXywxkImmboezuReiWNh7KpH6dsnkNXdZBBMFdkhFsZkgqtQGe1j8XO0RiPT
	 MUMBuiCiP5siql0WjVqDqXHHlcjb45M2d+rReSieTkiu6TdcS64CcMTfDhyKzrvaHI
	 L4G29v236pfww==
Date: Mon, 24 Feb 2025 22:50:44 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
Message-ID: <e3fc00dd-144a-4885-b8c7-76cd9322211a@proton.me>
In-Reply-To: <87r03n1tmd.fsf@kernel.org>
References: <20250223072114.3715-1-boqun.feng@gmail.com> <87wmdf22ae.fsf@kernel.org> <abHXLME4gEkYx7XkPVjZGIFs7Uuur8t0PkXDscTQPCvJCRsEfxM7gUS3K4MqegDt_nBDQJQDjLf5utZREFhDzA==@protonmail.internalid> <304505cb-9f68-4d34-b4f1-7d703baba012@proton.me> <87r03n1tmd.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 491b7f34fa77b5ea96d496a7a34fdf529b8ea894
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.02.25 12:15, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>> On 24.02.25 09:08, Andreas Hindborg wrote:
>>> Boqun Feng <boqun.feng@gmail.com> writes:
>>>
>>>> To provide examples on usage of `Guard::lock_ref()` along with the uni=
t
>>>> test, an "assert a lock is held by a guard" example is added.
>>>>
>>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>>> ---
>>>> This depends on Alice's patch:
>>>>
>>>> =09https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed8789992=
0a@google.com/
>>>>
>>>> I'm also OK to fold this in if Alice thinks it's fine.
>>>>
>>>>  rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
>>>> index 3701fac6ebf6..6d868e35b0a3 100644
>>>> --- a/rust/kernel/sync/lock.rs
>>>> +++ b/rust/kernel/sync/lock.rs
>>>> @@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync fo=
r Guard<'_, T, B> {}
>>>>
>>>>  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>>>>      /// Returns the lock that this guard originates from.
>>>> +    ///
>>>> +    /// # Examples
>>>> +    ///
>>>> +    /// The following example shows how to use [`Guard::lock_ref()`] =
to assert the corresponding
>>>> +    /// lock is held.
>>>> +    ///
>>>> +    /// ```
>>>> +    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Bac=
kend, Guard, Lock}};
>>>> +    ///
>>>> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: =
&Lock<T, B>) {
>>>> +    ///     // Address-equal means the same lock.
>>>> +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
>>>> +    /// }
>>>
>>> This seems super useful. Perhaps add this method as part of the lock ap=
i
>>> instead of just having it in the example?
>>
>> I don't think it should be an assert. Instead make it return a
>> `Result<(), ()>`. (or create better named unit error types)
>=20
> No, this should not be part of usual control flow, and developers should
> not make control flow decisions based on this. It would always be an
> assertion. But you are right that `assert!` is probably not what we
> want. `debug_assert!` might be fine though.

I agree, that it shouldn't be used for driver logic, but you still might
want to warn/warn_once instead of panic (or debug_assert).

---
Cheers,
Benno


