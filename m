Return-Path: <linux-kernel+bounces-333559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F25A97CAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DDA285AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE241A01C5;
	Thu, 19 Sep 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SBuIOvVo"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C901A00D1
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755008; cv=none; b=WqMcTvFeP1cHjvRTjwBKS2l6vfySqEtzzJ7g+YzkqO+2/oZkZevHs4NYfkok01UFXd29dNcFdCBCeJE0/AL8VLM6u3qCquyQOziGCHSXtiYHN1ALq/yZxSiYhTkKWspiEXpPPwwMaHpFH0/dR7MCfw/uBDU5HxglMxA0A6x3llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755008; c=relaxed/simple;
	bh=tDmLvz/Y7OenXYuiyXOW7bsxhHtOZJEYyrLX/MxP900=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaHaR+bxMWZPPDiccSItuNj45usS5zoqlKCSeornzFUktTE+1Mr+6nLPtlEMfYnbsbbjziXGDY9MqIbdZVqngSDdQvNEPk4UbsvZcvGn6sNzuuxZXVB0iQbU8PaHUePyzlKv1dc0Ntg2OBai2NKC7N9N0xthnR1IPFGgLWtnfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SBuIOvVo; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726755004; x=1727014204;
	bh=96ZYgEByMfbz6YW/0tUf2gqunHhdd5rTtOylGYwYymE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SBuIOvVokMrDdEne4qDvbt6MHDRROwv+VVKRZSdyJ3a9Fs7fwUbFQZygYNeAaw2XM
	 hMtjkepMV3p2pon/eqVkePmTlZZGhlrpsgtcNzQ7+m/FdlaIajNvkp7qBxJPabACEe
	 o73hZ1Ge3mB5I67dTslDaIB2WweFu5ghRqCynvmVUH+NwvwQLr6j9VO/4s+sBGIuMw
	 uQ84HoiBcMTICUtGPPoJm3IyLSg8dmLCnf7tgGQ3DfWrne2mUUp1t/3/H2IlI4up6I
	 YFk3CRNxKZoGias9vloXAzIImoO3IFGPAV1vzkniS/5YjBNq7Re17kExrMaoI0Ngme
	 CBkqWqgzfg/yg==
Date: Thu, 19 Sep 2024 14:09:58 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <33c65715-3af5-44f9-93c5-149d07a4c503@proton.me>
In-Reply-To: <878qvojj0o.fsf@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org> <20240917222739.1298275-3-a.hindborg@kernel.org> <Wohby8PLjQeZ47sXKGeWKOxdA2ShTjjvqOM6xWzhJY1aZ-SYk9TCDAnZN2EqiWuJUKwPKoFCsCofDHjtfeG--w==@protonmail.internalid> <f502f6c6-40b7-4ec4-8d0c-09adb0df1a30@proton.me> <878qvojj0o.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ca01b5eda54d01da0110fc778d9fccfa6d2c6792
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.24 07:43, Andreas Hindborg wrote:
> Hi Benno,
>=20
> Thanks for the feedback. I will incorporate all the whitespace
> suggestions you have =3DF0=3D9F=3D91=3D8D

There seems to be something wrong with the encoding in this email, is
that an issue on my side or yours?

> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>> On 18.09.24 00:27, Andreas Hindborg wrote:
> [...]
>>> +
>>> +impl<T> Timer<T> {
>>> +    /// Return an initializer for a new timer instance.
>>> +    pub fn new() -> impl PinInit<Self>
>>> +    where
>>> +        T: TimerCallback,
>>> +    {
>>> +        pin_init!( Self {
>>
>> I would remove the space after the `(`.
>> Would be great if we had rustfmt support for custom macros.
>=20
> Yes, that would be great!
>=20
>>
>>> +            // INVARIANTS: We initialize `timer` with `hrtimer_init` b=
e=3D
> low.
>>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrti=
m=3D
> er| {
>>> +                // SAFETY: By design of `pin_init!`, `place` is a poin=
t=3D
> er live
>>> +                // allocation. hrtimer_init will initialize `place` an=
d=3D
>  does not
>>> +                // require `place` to be initialized prior to the call=
.
>>> +                unsafe {
>>> +                    bindings::hrtimer_init(
>>> +                        place,
>>> +                        bindings::CLOCK_MONOTONIC as i32,
>>> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>>> +                    );
>>> +                }
>>> +
>>> +                // SAFETY: `place` is pointing to a live allocation, s=
o=3D
>  the deref
>>> +                // is safe.
>>> +                let function: *mut Option<_> =3D3D
>>
>> Do you really need this type hint?
>=20
> Apparently not!
>=20
> [...]
>>> +pub trait TimerPointer: Sync + Sized {
>>> +    /// A handle representing a scheduled timer.
>>> +    ///
>>> +    /// If the timer is armed or if the timer callback is running when=
 =3D
> the
>>> +    /// handle is dropped, the drop method of `TimerHandle` should not=
 =3D
> return
>>> +    /// until the timer is unarmed and the callback has completed.
>>> +    ///
>>> +    /// Note: It must be safe to leak the handle.
>>> +    type TimerHandle: TimerHandle;
>>
>> Why does this need to be an associated type? Couldn't we have a
>> `TimerHandle<T>` struct? The schedule function below could then return
>> `TimerHandle<Self>`.
>=20
> At one point, I had some cycles in trait resolution. Moving generics to
> associated types solved that issue. Maybe this can be changed to a
> generic. But are generics preferred over associated types for some
> reason?

The associated type is more complicated IMO, because then every
implementer of the trait needs to create one. If we can avoid that, I
would prefer a generic type.

---
Cheers,
Benno


