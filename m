Return-Path: <linux-kernel+bounces-548110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1EAA54018
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A1918870BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3918DB34;
	Thu,  6 Mar 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fUeAuUK8"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F9EEA9;
	Thu,  6 Mar 2025 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225368; cv=none; b=m0zfBjyWwJe/uwViGelzbfbzX3ThMs+hVf0V0BjeNzkRwmgMUTuFdYUw+LI2GUxflF/In8tH0FWYMaYxfbjke/pNbkDxPre1RRg7HuCEb5KCI63N4xDwnHORro/fy3Vp61aB/b7bQzWTEadpiFrB3QBETW6AL8rESk/Zpw1bArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225368; c=relaxed/simple;
	bh=rYgMDAH5nCCXIqosdgoXUJ8vWWm75Pq1UHp9JPPvPQk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tn/K0g6tCkO5g6rMkuOJOD2BSXB5slA85ZwZTLw+oPXGU4YBRorrZp9Ew58bq/y+P35BwmlRCK6e9vEwSe4PHm3P/4VGwMsWQzjfgLH8+In8LngiELYkvok1hmZU5ptjFgUZVTvD4VY4Aln/ImzCPtIJWQNEm4r4pSMNWrBSx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fUeAuUK8; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741225363; x=1741484563;
	bh=zLAhGikI9OQ7l6Nb3S58CqrDpZ/7yBEMUaeGn554uPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fUeAuUK8+bL+N03w5z8JwfxekjYrDbWfBbPfvtBjBtZY8C7ItqBN8WrRgi8dcc4xk
	 zDbo8O2ngikPqLldpGRa+27xLAU4ZK5YAdJMMKYR/UHSXjLtCyYzLQMGMFqa/H6g1R
	 TC5E4AHk0OJDYQ1gkEtGQ6kthn2sWkcgyy37Nhe1BAyIVDJ6Z/e8j8cxxyJhf4qYx5
	 wt+TyurSZ8GgtF0RYYSzc+ko9gl1ezZenfBLM22uLy+MnvlncCZF4Ztr2wvP5HzbHG
	 HF425rCpDGXo153bFkgsNrq6KOMwbUbow33DhmDH3ZVyEpQikj9qWjEXYWLTOcTlQ+
	 peCoK77RTQJGg==
Date: Thu, 06 Mar 2025 01:42:38 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 3/5] rust: firmware: add `module_firmware!` macro
Message-ID: <D88SVF4SV464.1WALI436PKCDB@proton.me>
In-Reply-To: <Z8j8gwvnmKF9ZymM@pollux>
References: <20250304173555.2496-1-dakr@kernel.org> <20250304173555.2496-4-dakr@kernel.org> <D88RCQTNVD7B.3RIN253F8LODY@proton.me> <Z8j0otfkVtnMXIRQ@pollux> <D88SJOTH9GN4.3OVO4JFYAF9R2@proton.me> <Z8j8gwvnmKF9ZymM@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4858ce176deb9419af4eaf1a034e80329ae63e6f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 6, 2025 at 2:38 AM CET, Danilo Krummrich wrote:
> On Thu, Mar 06, 2025 at 01:27:19AM +0000, Benno Lossin wrote:
>> On Thu Mar 6, 2025 at 2:04 AM CET, Danilo Krummrich wrote:
>> > On Thu, Mar 06, 2025 at 12:31:14AM +0000, Benno Lossin wrote:
>> >> On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
>> >>
>> >> > +#[macro_export]
>> >> > +macro_rules! module_firmware {
>> >> > +    ($($builder:tt)*) =3D> {
>> >>
>> >> This should probably be `$builder:expr` instead.
>> >
>> > That doesn't work, the compiler then complains, since it's not an expr=
ession:
>> >
>> > 193  |         static __MODULE_FIRMWARE: [u8; $builder::create(__modul=
e_name()).build_length()] =3D
>> >      |                                                ^^ expected one =
of `.`, `?`, `]`, or an operator
>>
>> Does `<$builder>::create` work (with the `expr` fragment)?
>
> No, the compiler then explicitly complains that it expects a type.

Aw well, can't have em all... Probably would be useful if you add a
comment saying that `expr` and `ty` can't be used.

>> > `ty` doesn't work either, since then the compiler expects the caller t=
o add the
>> > const generic, which we want the macro to figure out instead.
>> >
>> >>
>> >> > +
>> >> > +        #[cfg(not(MODULE))]
>> >> > +        const fn __module_name() -> &'static kernel::str::CStr {
>> >> > +            <LocalModule as kernel::ModuleMetadata>::NAME
>> >>
>> >> Please either use `::kernel::` or `$crate::` instead of `kernel::`.
>> >
>> > Good catch, thanks.
>> >
>> >>
>> >> Hmm, I am not 100% comfortable with the `LocalModule` way of accessin=
g
>> >> the current module for some reason, no idea if there is a rational
>> >> argument behind that, but it just doesn't sit right with me.
>> >>
>> >> Essentially you're doing this for convenience, right? So you don't wa=
nt
>> >> to have to repeat the name of the module type every time?
>> >
>> > No, it's really that I can't know the type name here, please see the p=
revious
>> > patch commit message that introduces `LocalModule` for explanation.
>>
>> Gotcha.
>>
>> >> > +        }
>> >> > +
>> >> > +        #[cfg(MODULE)]
>> >> > +        const fn __module_name() -> &'static kernel::str::CStr {
>> >> > +            kernel::c_str!("")
>> >>
>> >> Ditto.
>> >>
>> >> > +        }
>> >>
>> >> Are these two functions used outside of the `static` below? If no, th=
en
>> >> you can just move them into the static? You can also probably use a
>> >> `const` instead of a function, that way you only have 4 lines instead
>> >> of 8.
>> >
>> > Is this what you're proposing?
>> >
>> > =09#[macro_export]
>> > =09macro_rules! module_firmware {
>> > =09    ($($builder:tt)*) =3D> {
>> > =09        const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr =
=3D if cfg!(MODULE) {
>> > =09            $crate::c_str!("")
>> > =09        } else {
>> > =09            <LocalModule as $crate::ModuleMetadata>::NAME
>> > =09        };
>> >
>> > =09        #[link_section =3D ".modinfo"]
>> > =09        #[used]
>> > =09        static __MODULE_FIRMWARE: [u8; $($builder)*::create(__MODUL=
E_FIRMWARE_PREFIX)
>> > =09            .build_length()] =3D $($builder)*::create(__MODULE_FIRM=
WARE_PREFIX).build();
>>
>> I meant to also move the `const` into the expression, but I guess that
>> leads to duplication:
>>
>>     #[link_section =3D ".modinfo"]
>>     #[used]
>>     static __MODULE_FIRMWARE: [u8; {
>>         const PREFIX: &'static $crate::str::CStr =3D if cfg!(MODULE) {
>>             $crate::c_str!("")
>>         } else {
>>             <LocalModule as $crate::ModuleMetadata>::NAME
>>         };
>>         <$builder>::create(PREFIX).build_length()
>>     }] =3D {
>>         const PREFIX: &'static $crate::str::CStr =3D if cfg!(MODULE) {
>>             $crate::c_str!("")
>>         } else {
>>             <LocalModule as $crate::ModuleMetadata>::NAME
>>         };
>>         <$builder>::create(PREFIX)
>>     };
>>
>> But then the advantage is that only the `__MODULE_FIRMWARE` static will
>> be in-scope.
>>
>> Do you think that its useful to have the static be accessible? I.e. do
>> users need to access it (I would think they don't)? If they don't, then
>> we could put all of those things into a `const _: () =3D { /* ... */ };`=
.
>> But then people can invoke `module_firmware!` multiple times in the same
>> module, is that a problem?
>
> Didn't know that's possible (const _; () =3D { ... };). That's pretty nic=
e, I will
> go with my above proposal wrapped into the anonymous const. Thanks.

Sounds good.

---
Cheers,
Benno


