Return-Path: <linux-kernel+bounces-533459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E4A45ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ADB166F14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340326FD80;
	Wed, 26 Feb 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sqBm7Bs"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81D2459F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563505; cv=none; b=GJaxOboNQq5lgSd9XI71kNX+FIj9SB8nKGaVaSOED00BtgeHndyRD7rWpkwZf3eW0IhlqfMZc9ImFZb/G0FreSTx39Cuf4jkTm0ub5yhVM/MgVIEv92p+h1nDqfeZpLF8hdaA7/mjv3InSv7T9M5Q1KKaZHsiDKKYqO4RZF7FcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563505; c=relaxed/simple;
	bh=S0lf+4lpRcgKLyFrQA4J4yGE3pMr3w4x+Dy8wCIY3K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMssBb2agFCSgyPMdGI1mcO5kA535FHR9ToJk9eVPtesMfziQOBxdTdneQ5XaSzZMG6vslmIIPaPup4NjxzrCnNNtHIwImRJCCjHVw4SgcPSzDzWR8wE4j3f4DiAVkqrnZ9b5dCZhWRuuXJty5Sz5H1GRI+m323LAAOlanr9Iz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sqBm7Bs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso66134345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740563502; x=1741168302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs3KHXpUNRxMmVWzA96rGcxfnFDlH+HIbmMfpIXANCA=;
        b=2sqBm7BsTzQGnNSTrk1rWkHtMkBkvRJjxLjMqk7gR1qn4Sxy3H8m7HDlIyNMmnx+1d
         Thl3DqDx68uCuC5rmRqTIYyMDN8JRkaR2Lbw+uu1A+OznweHgsgI2UmZZX2VIn9VFlbH
         c4g8Jk6MeoQ1JQaCsJCE5EPUcONKVQHrPWtFBBQhRSQl1EEviG389ai+lGMiA1/w4mFc
         IT4fjuobrtBzAGjHIuw2yttUscUrAtYCyeqJy8PUieAk1D2yzMAWOu/LqoV0e6sLqhmO
         aSCGsWOJ32GwjIsNEnCCKMNn2hMEczEgEYtvhA0ju3NtFGI9bwarzugeXK8QmvQYt1Ib
         Mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740563502; x=1741168302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fs3KHXpUNRxMmVWzA96rGcxfnFDlH+HIbmMfpIXANCA=;
        b=pHOHNhJ+6KQp6Cr5FQYEjoBqfWhybi/RJQxfKC1fC5N6NiNnEUBq2mZ36QnIPUW8F/
         gjW9fGUJkJhWjBjPeDetEK6fYhypGA7AUz9qr0ueQPpUfIgciUOrrFyEKx/pNG8bCldU
         81m4IvzaXLnej4ktY0QN8Sh4Ni+9c104UQc6CMAn5Y1p/wk5a+tHmFOSTMiG5kc6Wh9r
         1kactftywG6E17ARP8sO46pFnbbfacZSZSNMBeSVTvdUxp/K6/+yrFsX026nsiPL3Y/M
         z6gA86vy0b/5AuSULkhJy1wRmZkoZvWbnT2jFDmXaGbNwnlXHzepz22mBTRYEUnrARyB
         9IJw==
X-Forwarded-Encrypted: i=1; AJvYcCXPvU4buOI4/UIJN7/yPjRfZuWhcz9Tr2ALwkOx4UW0DM3GiXHTYS4l1LPidQuHT9rf7hNICqobe3UUmcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpLvZYRuOxWC/Ss+byqrzGoB/ttAlFz/5N2S0dN4uunky7WFD
	zT6PJB1MmntGFIHrcCcNMOOrS6NRebafXQlnMoMhHBxs3n5g5isxNalpPnFkJ1Z+QWqhwslOttI
	7FkNQAb2nPp6MrgoQuUFbk28txigL7UYDS3Z3
X-Gm-Gg: ASbGncv4WNkduz3TsfR6UgSjHZRedMIW2h0OnOjiFlMWqf7MU0G5Yw9km9vLAK76Mqm
	pU1HWKLmgYDckHkWpZJhZ+YGIm9U+D3Jx0QOk4q5rhtxN1sTz2CH45JYzhCdmgwOow2C2WzKZ4C
	fSCEgBUDFaL3ux8w3xPkMJttAoN3/BhhJVW76ABg==
X-Google-Smtp-Source: AGHT+IFzkzJ5/4WNBf/eUvAla7YnSGL8/zujS1ENNCn/0BVBUdNATnqHxqboRA/r8AMv7ru+zuk+H/oh43/NlTYn2r4=
X-Received: by 2002:a5d:5887:0:b0:38f:2f0e:9813 with SMTP id
 ffacd0b85a97d-390cc3b0eabmr6802995f8f.0.1740563501628; Wed, 26 Feb 2025
 01:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea2466c4d250ff953b3be9602a3671fb@dakr.org> <20250226092339.989767-1-aliceryhl@google.com>
 <Z77iHj56551mDybd@pollux>
In-Reply-To: <Z77iHj56551mDybd@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 26 Feb 2025 10:51:29 +0100
X-Gm-Features: AQ5f1JpdXtqu7VfocuWmKcaKp_qdfUhQx-EMFBcwwtZWxteqzCABmqL2DsXyZP0
Message-ID: <CAH5fLggcAPgaQRrpcTd-+bzrarO=fUaQjg=rXTjZNS7DyfPhjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to Registration::new()
To: Danilo Krummrich <dakr@kernel.org>
Cc: kernel@dakr.org, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	lyude@redhat.com, mairacanal@riseup.net, ojeda@kernel.org, rafael@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:43=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Wed, Feb 26, 2025 at 09:23:39AM +0000, Alice Ryhl wrote:
> > On Wed, Feb 26, 2025 at 10:06=E2=80=AFAM <kernel@dakr.org> wrote:
> > >
> > > On 2025-02-26 09:38, Alice Ryhl wrote:
> > > > On Tue, Feb 25, 2025 at 10:31=E2=80=AFPM Lyude Paul <lyude@redhat.c=
om> wrote:
> > > >>
> > > >> A little late in the review of the faux device interface, we added=
 the
> > > >> ability to specify a parent device when creating new faux devices =
-
> > > >> but
> > > >> this never got ported over to the rust bindings. So, let's add the
> > > >> missing
> > > >> argument now so we don't have to convert other users later down th=
e
> > > >> line.
> > > >>
> > > >> Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >> ---
> > > >>  rust/kernel/faux.rs              | 10 ++++++++--
> > > >>  samples/rust/rust_driver_faux.rs |  2 +-
> > > >>  2 files changed, 9 insertions(+), 3 deletions(-)
> > > >>
> > > >> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> > > >> index 41751403cd868..ae99ea3d114ef 100644
> > > >> --- a/rust/kernel/faux.rs
> > > >> +++ b/rust/kernel/faux.rs
> > > >> @@ -23,11 +23,17 @@
> > > >>
> > > >>  impl Registration {
> > > >>      /// Create and register a new faux device with the given name=
.
> > > >> -    pub fn new(name: &CStr) -> Result<Self> {
> > > >> +    pub fn new(name: &CStr, parent: Option<&device::Device>) ->
> > > >> Result<Self> {
> > > >>          // SAFETY:
> > > >>          // - `name` is copied by this function into its own stora=
ge
> > > >>          // - `faux_ops` is safe to leave NULL according to the C =
API
> > > >> -        let dev =3D unsafe {
> > > >> bindings::faux_device_create(name.as_char_ptr(), null_mut(), null(=
))
> > > >> };
> > > >> +        let dev =3D unsafe {
> > > >> +            bindings::faux_device_create(
> > > >> +                name.as_char_ptr(),
> > > >> +                parent.map_or(null_mut(), |p| p.as_raw()),
> > > >> +                null(),
> > > >
> > > > This function signature only requires that `parent` is valid for th=
e
> > > > duration of this call to `new`, but `faux_device_create` stashes a
> > > > pointer without touching the refcount. How do you ensure that the
> > > > `parent` pointer does not become dangling?
> > >
> > > I was wondering the same, but it seems that the subsequent device_add=
()
> > > call takes care of that:
> > >
> > > https://elixir.bootlin.com/linux/v6.14-rc3/source/drivers/base/core.c=
#L3588
> > >
> > > device_del() drops the reference.
> > >
> > > This makes device->parent only valid for the duration between
> > > faux_device_create() and faux_device_remove().
> > >
> > > But this detail shouldn=E2=80=99t be relevant for this API.
> >
> > I think this could use a few more comments to explain it. E.g.:
> >
> > diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> > index 531e9d789ee0..674db8863d96 100644
> > --- a/drivers/base/faux.c
> > +++ b/drivers/base/faux.c
> > @@ -131,6 +131,7 @@ struct faux_device *faux_device_create_with_groups(=
const char *name,
> >
> >         device_initialize(dev);
> >         dev->release =3D faux_device_release;
> > +       /* The refcount of dev->parent is incremented in device_add. */
>
> Yeah, this one is a bit odd to rely on a subsequent device_add() call, it
> clearly deserves a comment.
>
> >         if (parent)
> >                 dev->parent =3D parent;
> >         else
> > diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> > index 7673501ebe37..713ee6842e3f 100644
> > --- a/rust/kernel/faux.rs
> > +++ b/rust/kernel/faux.rs
> > @@ -28,6 +28,7 @@ pub fn new(name: &CStr, parent: Option<&device::Devic=
e>) -> Result<Self> {
> >          // SAFETY:
> >          // - `name` is copied by this function into its own storage
> >          // - `faux_ops` is safe to leave NULL according to the C API
> > +        // - `faux_device_create` ensures that `parent` stays alive un=
til `faux_device_destroy`.
>
> Not sure that's a safety requirement for faux_device_create().
>
> The typical convention is that a caller must hold a reference to the obje=
ct
> behind the pointer when passing it to another function. If the callee dec=
ides
> to store the pointer elsewhere, it's on the callee to take an additional
> reference.
>
> I think if we want to add something to the safety comment, it should be s=
omthing
> along the line of "the type of `parent` implies that for the duration of =
this
> call `parent` is a valid device with a non-zero reference count".

True, we can move it above the safety comment:

// Note that `faux_device_create` ensures that `parent` stays alive
// until `faux_device_destroy`.
// SAFETY: ...


Alice

