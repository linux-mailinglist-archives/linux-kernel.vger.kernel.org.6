Return-Path: <linux-kernel+bounces-289704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B5D954AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A851C235D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7712F1B8E8A;
	Fri, 16 Aug 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IehBWnw/"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A11B86C7;
	Fri, 16 Aug 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813719; cv=none; b=ewUytqagUel3MaDOitMFwSwQUsEH5FpNUjaHVzZe5oxlsPTbgAi6Rv1ptXBLMwkHgcMxJJ3DHXcGMTecWnPk1xEqbv7p2QV4G3prqHsCQOY8V3CKAIX751F55yDFh47mLtrYDlpXiq5+rsR7DkPRXweQE9uXRcicMEZJG7SLh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813719; c=relaxed/simple;
	bh=uLZRSEKvV+sYwD5VMfcEH45Ip8gLy4Lvpolp9iUOzDA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzjbyucbsLM5EY8GjfWoGyQ7f8WKqiNqojeKS1ba4g5WZPKL4SVBq6PsOXvs4wJacI34jqfTBZSiw3Q3WVDWda8EcvX9bwptCLCEYvGo+fALzpoi2GBjoRva5EmojP5D9Qphbrakvj1LCvHu4aT9oUq1ZMOvHM7YoutQSed3T7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IehBWnw/; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723813715; x=1724072915;
	bh=62zRic87JxqPmj05J36bTPKEn8/CdP3vVB4/nw0/CTU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IehBWnw/g7yU1gMhY6AuaUfxXHqS5k9KGX9wjWLHdQcd2DTHryxyIqpvL/eE3BWLU
	 laDCiUJ6FKXyyQdw06pX/jh9l0kk1ulv5JvQ6fsw/xfGOqdIwB/g8uuIdDKPn4DmYB
	 2TstslElKcciKLBDmYD9F/Uxt7I3akIC0G5lS9Ze3KXRTW2t8ZcpJlQC/TY9lNdgyK
	 75iM92e/SohGRKdIYpGJtO/cx/ystzGz3FLSkDHIfyebd2oHV/yoAFZJFO2wAafmXN
	 pT+dSfMwawEqSZRi9w8nNzdLaAIKSb8rIhihcCZ+GNpdrlMa5TvegmQbkITJqxI+7y
	 rV8cPaz+90EgA==
Date: Fri, 16 Aug 2024 13:08:29 +0000
To: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <2e3bc20e-ca91-45bb-9e35-586620e56d96@proton.me>
In-Reply-To: <20240815224234.561de1b5.gary@garyguo.net>
References: <20240815074519.2684107-1-nmi@metaspace.dk> <20240815074519.2684107-3-nmi@metaspace.dk> <CAH5fLgih1QtO-ACyoifNsgqd=VtJimoGV+aD=3iHG0wb+iDGyw@mail.gmail.com> <20240815200738.096dca4a.gary@garyguo.net> <Zr5z7N2JCMBbQ_YK@boqun-archlinux> <20240815224234.561de1b5.gary@garyguo.net>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4f98ced78d52e0365dbab01ea38cf10610a2e445
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 23:42, Gary Guo wrote:
> On Thu, 15 Aug 2024 14:32:28 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>> On Thu, Aug 15, 2024 at 08:07:38PM +0100, Gary Guo wrote:
>>> On Thu, 15 Aug 2024 10:04:56 +0200
>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>> On Thu, Aug 15, 2024 at 9:49=E2=80=AFAM Andreas Hindborg <nmi@metaspac=
e.dk> wrote:
>>>>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>>>>
>>>>> When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic=
 lock
>>>>> class key without registering the key. This is incorrect use of the A=
PI,
>>>>> which causes a `WARN` trace. This patch fixes the issue by using a st=
atic
>>>>> lock class key, which is more appropriate for the situation anyway.
>>>>>
>>>>> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` modu=
le")
>>>>> Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
>>>>> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Ge=
neral/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctes=
t.20lock.20warning
>>>>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>>>>
>>>> LGTM. This makes me wonder if there's some design mistake in how we
>>>> handle lock classes in Rust.
>>>>
>>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>>
>>> I agree. The API that we current have is designed without much
>>> consideration into dynamically allocated keys, and we use `&'static
>>> LockClassKey` in a lot of kernel crate APIs.
>>>
>>> This arguably is wrong, because presence of `&'static LockClassKey`
>>> doesn't mean the key is static. If we do a
>>> `Box::leak(Box::new(LockClassKey::new()))`, then this is a `&'static
>>> LockClassKey`, but lockdep wouldn't consider this as a static object.
>>>
>>> Maybe we should make the `new` function unsafe.
>>>
>>
>> I think a more proper fix is to make LockClassKey pin-init, for
>> dynamically allocated LockClassKey, we just use lockdep_register_key()
>> as the initializer and lockdep_unregister_key() as the desconstructor.
>> And instead of a `&'static LockClassKey`, we should use `Pin<&'static
>> LockClassKey>` to pass a lock class key. Of course we will need some
>> special treatment on static allocated keys (e.g. assume they are
>> initialized since lockdep doesn't require initialization for them).
>>
>>
>> Pin initializer:
>>
>> =09impl LockClassKey {
>> =09    pub fn new() -> impl PinInit<Self> {
>> =09=09pin_init!(Self {
>> =09=09    inner <- Opaque::ffi_init(|slot| { lockdep_register_key(slot) =
})
>> =09=09})
>> =09    }
>> =09}
>>
>> LockClassKey::new_uninit() for `static_lock_class!`:
>>
>>
>> =09impl LockClassKey {
>> =09    pub const fn new_uninit() -> MaybeUninit<Self> {

We don't need to wrap it in `MaybeUninit`, since it already is
containing an `Opaque`. But I think we don't need to expose this
function at all, see below.

>> =09        ....
>> =09    }
>> =09}
>>
>> and the new `static_lock_class!`:
>>
>> =09macro_rules! static_lock_class {
>> =09    () =3D> {{
>> =09=09static CLASS: MaybeUninit<$crate::sync::LockClassKey> =3D $crate::=
sync::LockClassKey::new_uninit();

    () =3D> {{
        // SAFETY: `LockClassKey` contains a single field of type `Opaque` =
and thus an uninitialized
        // value is valid.
        static CLASS: $crate::sync::LockClassKey =3D unsafe {
            ::core::mem::MaybeUninit::uninit().assume_init()
        };
        Pin::from_static(&CLASS)
    }};

That way users can either create a static class, or a dynamic one via
`new_dynmaic` (I think we should rename it while we're at it), which is
always registered.

> nit: this could just be `MaybeUninit::uninit()`
>=20
>>
>> =09        // SAFETY: `CLASS` is pinned because it's static
>> =09=09// allocated. And it's OK to assume it's initialized
>> =09=09// because lockdep support uninitialized static
>> =09=09// allocated key.
>> =09=09unsafe { Pin::new_unchecked(CLASS.assume_init_ref()) }
>=20
> nit: this could be `Pin::from_static(unsafe { CLASS.assume_init_ref() })`
>=20
>> =09    }};
>> =09}
>>
>> Thoughts?
>=20
> I think this design looks good. I suggested adding unsafe as a quick
> way to address the pontential misuse, when we have no user for
> dynamically allocated keys.

I think we should do it properly, since the solution seems easy.

---
Cheers,
Benno


