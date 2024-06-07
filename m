Return-Path: <linux-kernel+bounces-205921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD290022E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41539285CA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9851527A4;
	Fri,  7 Jun 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bn+P8KJD"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AC188CAD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759850; cv=none; b=rvYax9VFM7DksrNaGldim3I7SwwXxIWLNaZU+P2/MLHJjZ7fp6RjwUkIzly2QTY6rTmYSzMolFBm2S3TA7HpmZdQkNAG0AwW89EWmNetwHU1Ug/F2ZUHsk8E9eT/YndQ0+7le2SCrvf9WPXfh1OK76cZQ/NKwh/6Zf0BxGNim+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759850; c=relaxed/simple;
	bh=syc8lfkdqAhYqqUgiwY19a01afo/wfTXbmwvaqeiYic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcSIkJvXVEfYVUknVNwMKtRavtnkWlNxbJBAYhr5XlY0FIaTXC36mmR9IPO2hFLp7TgAeJkWVezgXh93JDfczxms9sE9FO+6mzoSym7iYNI0PThG/YSWH9rvW9hhkJ7a1oD91CL3fWpIaGng6T/zTBqeRwS7f0lvs2w70xJQa7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bn+P8KJD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so18580635e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717759847; x=1718364647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEVTt2IK3Vh17CDV3iJIHzc4vLOeEHZQVEzUE5ODCe4=;
        b=bn+P8KJD3Dmp0O1z0RbSRhAGSEFUF2CPJ+L+R9r9x3NWZTFQgZTmv+mU2JhxYoV/BU
         IKPGw1CVAjJZecPeDPMbFUOlk2PJnUQFo3ei45EOoF84Obrk99EAm9TTHIkkNsM9IfiS
         OaesgOcqoMPID8eDynN0Fvgq639IYR7sxEUBubKxGUghoHPyuFnWp1JFLAJP4XrXO13C
         3Tr4piQwSszcD/Tdp/cYtxLhlEGbnrq/utVrr0gp5NDbAfLj5rjpv4sYbjxQ0ZQDDXCG
         K1jmy2PLXVKVxAuhK41EIGq1PXBh8XWhvtaM2E5laNFKsHnWV3w5lJ9N9EcqvFWA3CVC
         o9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759847; x=1718364647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEVTt2IK3Vh17CDV3iJIHzc4vLOeEHZQVEzUE5ODCe4=;
        b=qqda4Y8IlLCOxUbxXqVvQDOcOLlAAY3zaxvUjmOfy4uzwfDXu/YdZMtrTy2+vXoDac
         ZtKVyB4DYzw/G3QIiZTc6gQdrzY4Mz10ZznJYC7XfEab7LmjPFyO3EbJs6JxeGNT0h7w
         pRmQXB/eVZqL/vk6iXfCC7RZpfFRM2I0pOcNJ4aDCOHvGFLrH4ucXupV8eNo2ttUhChc
         68/cvRDrEYKzCo6zO1mAOAu+Nw6CtKFfTKnOhvq5hlReWbnBPO9HsDrJKn8ifSrrfIkc
         aYpIUp26P8x3nuX1za1p7c0zBtsuMdkfvGUXOBu09Gg3rcCQ3UnWIHhgv6uxxIv32Aru
         o6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUCVc1yMgWOOJjVO4COkjo5khARBO9eEBZvTfEMK64heOC4/zrPQqkUAmQKcKs2nY/PY9yOAEGR4I4Ptkcq6SCU9sfUJRLFKEXKsSGb
X-Gm-Message-State: AOJu0YyM9z40QPGe7RIifBm/HlR5U1Xf9gvIFsy21+w4JpiXZyY8Y2QB
	uskcEpHZexhXvqmma7pEwOWtju7hkb4KYCXMB/kqSsDtN9R3RIcz2oeCs9nHhp8KLcGVWwIVBq0
	kxulWcjMMrIB2yD8lBg3p68U2IAatPMUEhe+t
X-Google-Smtp-Source: AGHT+IFC4Hhzv/8OF1cQ+vRRaRNypcOJ9/rvpzK9bT/WNnoycgKnSO8e4XShXiTTlnm9DYCE8cpj99u/yWLDFpL6ubk=
X-Received: by 2002:a05:600c:4449:b0:420:2a22:bd3e with SMTP id
 5b1f17b1804b1-42164a02b6bmr17113535e9.18.1717759846480; Fri, 07 Jun 2024
 04:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717750631.git.viresh.kumar@linaro.org> <e74e3a14e6da3f920cee90d32a023ba4805328a0.1717750631.git.viresh.kumar@linaro.org>
 <CAH5fLgjChZCtTUnHVHJat-sXFyLVE+MgDXrNDiUD0LNsUndpBQ@mail.gmail.com> <epjoz.s6l4l8qrt331@linaro.org>
In-Reply-To: <epjoz.s6l4l8qrt331@linaro.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 7 Jun 2024 13:30:33 +0200
Message-ID: <CAH5fLgiBtUkCfTt198mEkZD=-OqC7cdNY-hgBWPBE310ti0V+w@mail.gmail.com>
Subject: Re: [RFC PATCH V2 1/8] rust: Add initial bindings for OPP framework
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6_rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Erik Schilling <erik.schilling@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 1:24=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Fri, 07 Jun 2024 13:51, Alice Ryhl <aliceryhl@google.com> wrote:
> >On Fri, Jun 7, 2024 at 11:12=E2=80=AFAM Viresh Kumar <viresh.kumar@linar=
o.org> wrote:
> >>
> >> This commit adds initial Rust bindings for the Operating performance
> >> points (OPP) core. This adds bindings for `struct dev_pm_opp` and
> >> `struct dev_pm_opp_data` to begin with.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> >> +//! Operating performance points.
> >> +//!
> >> +//! This module provides bindings for interacting with the OPP subsys=
tem.
> >> +//!
> >> +//! C header: [`include/linux/pm_opp.h`](../../../../../../include/li=
nux/pm_opp.h)
> >
> >Please use srctree links instead.
> >
> >C header: [`include/linux/pm_opp.h`](srctree/include/linux/pm_opp.h)
> >
> >> +impl OPP {
> >> +    /// Creates a reference to a [`OPP`] from a valid pointer.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// The caller must ensure that `ptr` is valid and remains valid =
for the lifetime of the
> >> +    /// returned [`OPP`] reference.
> >> +    pub unsafe fn from_ptr_owned(ptr: *mut bindings::dev_pm_opp) -> R=
esult<ARef<Self>> {
> >> +        let ptr =3D ptr::NonNull::new(ptr).ok_or(ENODEV)?;
> >> +
> >> +        // SAFETY: The safety requirements guarantee the validity of =
the pointer.
> >> +        //
> >> +        // INVARIANT: The refcount is already incremented by the C AP=
I that returned the pointer,
> >> +        // and we pass ownership of the refcount to the new `ARef<OPP=
>`.
> >> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> >> +    }
> >> +
> >> +    /// Creates a reference to a [`OPP`] from a valid pointer.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// The caller must ensure that `ptr` is valid and remains valid =
for the lifetime of the
> >> +    /// returned [`OPP`] reference.
> >> +    pub unsafe fn from_ptr(ptr: *mut bindings::dev_pm_opp) -> Result<=
ARef<Self>> {
> >> +        let opp =3D unsafe { Self::from_ptr_owned(ptr) }?;
> >> +
> >> +        // Take an extra reference to the OPP since the caller didn't=
 take it.
> >> +        opp.inc_ref();
> >> +
> >> +        Ok(opp)
> >> +    }
> >
> >I would recommend a slightly different approach here. You can provide
> >a method called `from_raw_opp` that takes a *mut bindings::dev_pm_opp
> >and returns a &Self. The ARef type provides a method that converts
> >&Self to ARef<Self> by taking a refcount. This way, users would also
> >be able to call OPP methods without giving Rust any refcounts. You can
>
> Wouldn't this allow for use-after-free? What if the refcount drops to 0
> before the method is called?

The method would be unsafe and require the caller to avoid that.

/// Creates a reference to a [`File`] from a valid pointer.
///
/// # Safety
///
/// The caller must ensure that `ptr` points at a valid file and that
/// the file's refcount is positive for the duration of 'a.
pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a File {
    // SAFETY: The caller guarantees that the pointer is not dangling
    // and stays valid for the duration of 'a. The cast is okay because
    // `File` is `repr(transparent)`.
    unsafe { &*ptr.cast() }
}

> >As for `from_ptr_owned`, I would probably rename it to
> >`from_raw_opp_owned` or similar. It's often nice to use a more
> >descriptive name than just "ptr".
> >I think most existing examples call this `as_raw` and mark it
> >`#[inline]`.
>
> I think `ptr` is more idiomatic to Rust users, not that your suggestion
> is wrong. from_ptr_owned also implies the function signature.
>
>
> >
> >> +    /// Adds an OPP dynamically.
> >> +    pub fn add(dev: ARef<Device>, mut data: Data) -> Result<()> {
> >> +        // SAFETY: The requirements are satisfied by the existence of=
 `Device` and its safety
> >> +        // requirements.
> >> +        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.as_ra=
w(), &mut data.0) })
> >> +    }
> >> +
> >> +    /// Removes a dynamically added OPP.
> >> +    pub fn remove(dev: ARef<Device>, freq: u64) {
> >> +        // SAFETY: The requirements are satisfied by the existence of=
 `Device` and its safety
> >> +        // requirements.
> >> +        unsafe { bindings::dev_pm_opp_remove(dev.as_raw(), freq) };
> >> +    }
> >
> >Is it intentional that these methods take ownership of a refcount to
> >the device that it then drops after calling the C function?
>
> use-after-free again? Though I'm suggesting this without actually
> examining if it can happen.

Rust references are required to not be dangling, so if you take a
&Device, then the caller promises that they will keep the device alive
for the duration of the call.

Alice

