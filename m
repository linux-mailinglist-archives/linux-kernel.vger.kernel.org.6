Return-Path: <linux-kernel+bounces-548099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A45AA53FEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC991893C7A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068181607B7;
	Thu,  6 Mar 2025 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NTwlkOkD"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11E224FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224458; cv=none; b=HtVO5cYpGGhF0CNQrY9y2bQoMhgYSRjKCNKJD80D/NELhBykR8FAmaPtj8IKcVLM3Lm7s/3MemkktyiE0Ot7QSJWr+hPeUaXDCMCWiCV+kwOO0NkZ1+ZACWTfaQyk+YULSmcY7BbC+ymSDKhzuCgPaMh8kT7RyjTlHSVZGYg7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224458; c=relaxed/simple;
	bh=hkt/EnK1T6OhXU/W0wLc5XfxbJo5SrDohfYNXjpLDuI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJVaF43bORGhZTByYiEHs9ZwegH8kcoUolbiv5IS/1oyWvChpOPEu+ReqWQgFpWWpHuS0OMVDSBfJa8TLOPkZGQ62236I6YJRfdm8cjkOCbAR07IHen+O4razBQ/mDjJD1YJ1lKyEyuGsAXPAQXzRn6rLbMdCBPpGFy6Z+IThkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NTwlkOkD; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=edku7nt35faorprsmlxm5ocgsm.protonmail; t=1741224448; x=1741483648;
	bh=Ws+c8tX/OnH0cVp71OPD005wzVChpRlLpSiShc1Bnaw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NTwlkOkDtaj4+D1c+spPsEqV1T2sz4jaTiFJWvG8esBMoZW6jAhHG2dFn8f4NNhjr
	 5T6yUSEcBAWhmDfhb6F5jiQm9Afkf1ygrUvOeYuV8AdzHGwJBzInppzxTCX77+ljZR
	 1mCeScRP+eist+ERR6eJ8wqFvWpUTpTxGaAW9yIZNj82JJLlNU1TEkFWs+XXdJ/mIT
	 DvN1zLqRWiPnr04V4OZwGlrtgvfFby54rwhkDnmOdZeHcEb34I31O3hLKFKoYl5eNU
	 ADi/4gs9y3iPY3qrvgafYQOksDS05rO1LVLM3SHhAYzb1BGYMXITj0NbRrxLb86dEl
	 KOQpj5Cdgwarw==
Date: Thu, 06 Mar 2025 01:27:19 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/5] rust: firmware: add `module_firmware!` macro
Message-ID: <D88SJOTH9GN4.3OVO4JFYAF9R2@proton.me>
In-Reply-To: <Z8j0otfkVtnMXIRQ@pollux>
References: <20250304173555.2496-1-dakr@kernel.org> <20250304173555.2496-4-dakr@kernel.org> <D88RCQTNVD7B.3RIN253F8LODY@proton.me> <Z8j0otfkVtnMXIRQ@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a23028189b279d338045c4e4876c48aa813105ba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 6, 2025 at 2:04 AM CET, Danilo Krummrich wrote:
> On Thu, Mar 06, 2025 at 12:31:14AM +0000, Benno Lossin wrote:
>> On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
>>
>> > +#[macro_export]
>> > +macro_rules! module_firmware {
>> > +    ($($builder:tt)*) =3D> {
>>
>> This should probably be `$builder:expr` instead.
>
> That doesn't work, the compiler then complains, since it's not an express=
ion:
>
> 193  |         static __MODULE_FIRMWARE: [u8; $builder::create(__module_n=
ame()).build_length()] =3D
>      |                                                ^^ expected one of =
`.`, `?`, `]`, or an operator

Does `<$builder>::create` work (with the `expr` fragment)?

> `ty` doesn't work either, since then the compiler expects the caller to a=
dd the
> const generic, which we want the macro to figure out instead.
>
>>
>> > +
>> > +        #[cfg(not(MODULE))]
>> > +        const fn __module_name() -> &'static kernel::str::CStr {
>> > +            <LocalModule as kernel::ModuleMetadata>::NAME
>>
>> Please either use `::kernel::` or `$crate::` instead of `kernel::`.
>
> Good catch, thanks.
>
>>
>> Hmm, I am not 100% comfortable with the `LocalModule` way of accessing
>> the current module for some reason, no idea if there is a rational
>> argument behind that, but it just doesn't sit right with me.
>>
>> Essentially you're doing this for convenience, right? So you don't want
>> to have to repeat the name of the module type every time?
>
> No, it's really that I can't know the type name here, please see the prev=
ious
> patch commit message that introduces `LocalModule` for explanation.

Gotcha.

>> > +        }
>> > +
>> > +        #[cfg(MODULE)]
>> > +        const fn __module_name() -> &'static kernel::str::CStr {
>> > +            kernel::c_str!("")
>>
>> Ditto.
>>
>> > +        }
>>
>> Are these two functions used outside of the `static` below? If no, then
>> you can just move them into the static? You can also probably use a
>> `const` instead of a function, that way you only have 4 lines instead
>> of 8.
>
> Is this what you're proposing?
>
> =09#[macro_export]
> =09macro_rules! module_firmware {
> =09    ($($builder:tt)*) =3D> {
> =09        const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr =3D=
 if cfg!(MODULE) {
> =09            $crate::c_str!("")
> =09        } else {
> =09            <LocalModule as $crate::ModuleMetadata>::NAME
> =09        };
>
> =09        #[link_section =3D ".modinfo"]
> =09        #[used]
> =09        static __MODULE_FIRMWARE: [u8; $($builder)*::create(__MODULE_F=
IRMWARE_PREFIX)
> =09            .build_length()] =3D $($builder)*::create(__MODULE_FIRMWAR=
E_PREFIX).build();

I meant to also move the `const` into the expression, but I guess that
leads to duplication:

    #[link_section =3D ".modinfo"]
    #[used]
    static __MODULE_FIRMWARE: [u8; {
        const PREFIX: &'static $crate::str::CStr =3D if cfg!(MODULE) {
            $crate::c_str!("")
        } else {
            <LocalModule as $crate::ModuleMetadata>::NAME
        };
        <$builder>::create(PREFIX).build_length()
    }] =3D {
        const PREFIX: &'static $crate::str::CStr =3D if cfg!(MODULE) {
            $crate::c_str!("")
        } else {
            <LocalModule as $crate::ModuleMetadata>::NAME
        };
        <$builder>::create(PREFIX)
    };

But then the advantage is that only the `__MODULE_FIRMWARE` static will
be in-scope.

Do you think that its useful to have the static be accessible? I.e. do
users need to access it (I would think they don't)? If they don't, then
we could put all of those things into a `const _: () =3D { /* ... */ };`.
But then people can invoke `module_firmware!` multiple times in the same
module, is that a problem?

---
Cheers,
Benno

> =09    };
> =09}



