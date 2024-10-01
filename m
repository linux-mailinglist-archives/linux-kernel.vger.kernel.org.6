Return-Path: <linux-kernel+bounces-345524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032ED98B73E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B735E280C23
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1319CCF4;
	Tue,  1 Oct 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="K8J+0qr6"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8D199FCD;
	Tue,  1 Oct 2024 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772020; cv=none; b=kU2ClZgMO2iWsv6ALVIKlakrOXxskaFahwuYHJFA3Ok2EGuKVpVp+3j/l1t4qt/Gdc+MLWnDehGz76RQs+yZQ93mOqIni4GnCW0C+kiQMCwuA83Zudi8aGsTmGVaPTX700NGDMME9R313Ptr72Bcq2A3Iu0YDWObSOyHrfY5reU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772020; c=relaxed/simple;
	bh=PLh/58ZlaBgCmlMftYu7qkzfOBM+fQmdj2Uc322yocI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3MYo2FdaF8VLel5jbmy7aMIl0qhPvlc/DuDG/FDHK9CRucbc0yq1ulhs0Xvqa54SQojqTuPzfwVbC2Vo9d7mGfMviRiBcFGrxZfYXcGt9UoQfsr8lPInoNf/w1C0sOz+pAtnwvH9JXQ9YfijO10dYtlXkNXpeVxRQo1/ptXSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=K8J+0qr6; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xnkze6t25vd55o2zobthg4llcy.protonmail; t=1727772001; x=1728031201;
	bh=XbuCavRCbycWjRl0/qLs0aDNm7AdcxhaXd2r4Slp+hY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K8J+0qr6LuWYLZFjIuEZILPh1bmUIDuuSE/V5GqUE8Dy6Iz+vbT92jcqdgR4dcBZ4
	 fis/lrxCkTvjikpfp/0QZyR5FfpnmYA6qD6oEmDrgGkOevTZby26SN7X1Gp26m9WH0
	 5m6t51rCnAOqqhRN9m8AR3luguuhQD7r//ypyKq6tzdIDqonmHFAbmBLdHtXp28Kex
	 ZLNH7tebDhTmVhjqqMxeXcXcWGDXgB9oiDhl/JiRNmchDOLig4ktySknsrJcb45w0z
	 85AS31rD0MKGpQdAEmeBwiDn3rafK4HPoNMh/GsfMxP5P/qgwoA02nV7MRN0Erfflf
	 2C8h2Gu+5f0qw==
Date: Tue, 01 Oct 2024 08:39:57 +0000
To: Dirk Behme <dirk.behme@de.bosch.com>, Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] rust: sync: add `Arc::as_ptr`
Message-ID: <1d699942-eba4-4cb9-8b97-ad747936a5a5@proton.me>
In-Reply-To: <ad3e4f4c-883b-49a5-ba4b-562c13eee08e@de.bosch.com>
References: <20240917222739.1298275-1-a.hindborg@kernel.org> <20240917222739.1298275-4-a.hindborg@kernel.org> <e7e42ff2-1543-48b3-9bd3-bdef5ce66348@proton.me> <ad3e4f4c-883b-49a5-ba4b-562c13eee08e@de.bosch.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 38218592fffca59a5328dcfe84276b3ae07daf21
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.24 06:56, Dirk Behme wrote:
> On 19.09.2024 16:03, Benno Lossin wrote:
>> On 18.09.24 00:27, Andreas Hindborg wrote:
>>> Add a method to get a pointer to the data contained in an `Arc`.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>   rust/kernel/sync/arc.rs | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>>> index 3673496c2363..a57ea3e2b44c 100644
>>> --- a/rust/kernel/sync/arc.rs
>>> +++ b/rust/kernel/sync/arc.rs
>>> @@ -258,6 +258,14 @@ pub fn into_raw(self) -> *const T {
>>>           unsafe { core::ptr::addr_of!((*ptr).data) }
>>>       }
>>>
>>> +    /// Return a raw pointer to the data in this arc.
>>> +    pub fn as_ptr(&self) -> *const T {
>>
>> I don't know if we have a convention for this, but shouldn't this be an
>> associated function? Because if `T` also has an `as_ptr` function, it
>> will be shadowed by this one.
>=20
> Yes. In Fabien's out of tree regmap we have an as_ptr() for Regmap [1]
> which operates on &Arc<Regmap> [2]. Once this patch is applied to arc.rs
> the compilation fails as then Arc.as_ptr() is used, not the
> Regmap.as_ptr() any more [3]. Switching this to something like [4] makes
> the compiler happy.

Yeah then we should switch to that.

> Thanks,
>=20
> Dirk
>=20
> P.S.: Just to learn something: For the unmodified, failing case: Is
> there a rule when which as_ptr() will be used? Is there an order rule
> for the shadowing? Any documentation link?

Yes, there is a page about the method call expression in the reference:
https://doc.rust-lang.org/reference/expressions/method-call-expr.html

---
Cheers,
Benno

> [1]
> https://github.com/Fabo/linux/blob/fparent/rust-ncv6336/rust/kernel/regma=
p.rs#L71
>=20
> [2]
> https://github.com/Fabo/linux/blob/fparent/rust-ncv6336/rust/kernel/regul=
ator/driver.rs#L418
>=20
> [3]
>=20
> error[E0308]: mismatched types
>     --> rust/kernel/regulator/driver.rs:420:33
>      |
> 420 |             config.cfg.regmap =3D regmap.as_ptr();
>      |                                 ^^^^^^^^^^^^^^^ types differ in
> mutability
>      |
>      =3D note: expected raw pointer `*mut bindings::regmap`
>                 found raw pointer `*const Regmap`
>=20
> error: aborting due to 1 previous error
>=20
> [4]
>=20
> diff --git a/rust/kernel/hrtimer/arc.rs b/rust/kernel/hrtimer/arc.rs
> index ff04b0b75bb39..7c39ab440e1c6 100644
> --- a/rust/kernel/hrtimer/arc.rs
> +++ b/rust/kernel/hrtimer/arc.rs
> @@ -25,7 +25,7 @@ unsafe impl<U> TimerHandle for ArcTimerHandle<U>
>       U: HasTimer<U>,
>   {
>       fn cancel(&mut self) -> bool {
> -        let self_ptr =3D self.inner.as_ptr();
> +        let self_ptr =3D Arc::as_ptr(&self.inner);
>=20
>           // SAFETY: As we obtained `self_ptr` from a valid reference
> above, it
>           // must point to a valid `U`.
> @@ -57,7 +57,7 @@ impl<U> TimerPointer for Arc<U>
>       fn schedule(self, expires: Ktime) -> ArcTimerHandle<U> {
>           // SAFETY: Since we generate the pointer passed to `schedule`
> from a
>           // valid reference, it is a valid pointer.
> -        unsafe { U::schedule(self.as_ptr(), expires) };
> +        unsafe { U::schedule(Arc::as_ptr(&self), expires) };
>=20
>           ArcTimerHandle { inner: self }
>       }
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 1466d9cd41652..0a314c2f4c5ea 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -259,8 +259,8 @@ pub fn into_raw(self) -> *const T {
>       }
>=20
>       /// Return a raw pointer to the data in this arc.
> -    pub fn as_ptr(&self) -> *const T {
> -        let ptr =3D self.ptr.as_ptr();
> +    pub fn as_ptr(arc: &Self) -> *const T {
> +        let ptr =3D arc.ptr.as_ptr();
>           // SAFETY: As we derive the pointer from a reference above,
> the pointer
>           // must be valid.
>           unsafe { core::ptr::addr_of!((*ptr).data) }
>=20
>=20


