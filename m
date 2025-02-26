Return-Path: <linux-kernel+bounces-533423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F61A459E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BE23AC4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A722423B;
	Wed, 26 Feb 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzajmSa0"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB21DC997
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561825; cv=none; b=NK9+PKM3oT8+zI3sN1j8AiQlbs5qh/jYvp6R0BLRFemKmEto8e1VMbixGOtUmqjMd8h7/R3AIBkAzFDeH4WSEJZf2/tWhqAYN/XJHOqTez8uxUrli/4WRk5LFjj0YIecMORRbbQ8p1DPJNlUljy7JvAeCvSrEUIhc/hesKm3mBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561825; c=relaxed/simple;
	bh=p4Ym6uFd+a4HjnTUB8RZrVFMgrTyDhnkWn9RtsDN2XE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ru1B9AzLddskT4XaZQFR1zllbXdQTGUxicFd1xC4HnToKTBV2t1u5WaB8k68UyaPFBFlbs3KZBrnpx5nCewlCsIa+2faMtsYxeakZZhBgLLHb0t2/zeIFyddHK9TYFY5zQdCO6fPQrISQAdadSKrFbzvI2TOANzGDLmdzqssdjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzajmSa0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so27869415e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740561822; x=1741166622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk8dgs27jijazmvA8B3vaETW0/po24foxSj9cCzDqsU=;
        b=EzajmSa0x/KKEQVBx8YeJ8bErOEjzK3Eeccmw4bKl8/vFZCB441pIrCzzNco/cP2Dw
         SmNaD/rge7oyyPPeFlqlbf6rWy9pXVQ25Q6eLrincHOFgBu213IevXEeHs7IGGpWgX0n
         +2Kjo0GmheIxqXgeZL2iAOHDtx7he8ZszGG+pAl18s8q8JyKxNDJlrfvM6ZysqDSVdzj
         5JXl2nZLtMuzPuk9UimGHzX03poOOH/PEWXJ5Lj6hFnJ/4Bva6qRmaHAC/JF2yh2IKwM
         q6RUO/LbsIMS8RhfaCtrNRc2xgsKG5d3vRV/1oHW/YcT8DnSsNn/NWl06O0dQufAmpMQ
         5QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740561822; x=1741166622;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pk8dgs27jijazmvA8B3vaETW0/po24foxSj9cCzDqsU=;
        b=LJYaiGnaJ9VkJLTDz2aKFGyvzvjP/51CeeE4IhU8DptMOB7B9NydUpAOJOEXxOm5QV
         8MwJ5h94Qxww++laJocMj8xWx7PsofvPlDYNTda5Nr6v/lErZ0NdQY0MYuKwbQhv4i39
         s4l9+vNinYHmT4ytdHa9ykojXk3tbuo+jJLal9MNjSDB7HbNIibvQABJCROXwa2fRqOD
         em9QD2rqeIgbn9jbzmCdbJdZlTHMJVfe1GSWog0aAASRuLPybr+6sp0o25o/lkmStL91
         7zrR38Aph+ghXGb7ncaEkZveS+1UrVtq1AHeivuQ4m2I/o1Saq+H2xAlIAzlTBQMFG+4
         3qNg==
X-Forwarded-Encrypted: i=1; AJvYcCW1J9lrG6XnUpLmCI1GieAMRa8tfLYj+lhEaQlDpU0YrTVs5kXRUfcaq6UdQsBuNPAK+tdSahPFHG2U20k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6VMcmq7C0OPWZvyfWOCjY16WZvUO4fLMwX2M5t67g/PGGH3e
	iLTOmyQ1FrIslOBPChpjSzTbYsAIKaRQpEzNUFBYo2ROxp3GsTIXPclDM5nxN9f2pU+JACInJt0
	H19QqFVydtSziSw==
X-Google-Smtp-Source: AGHT+IEs8HO5Ml6nZnQ6KRY5UHYewnhQ67q+wlvUIYAlBU5XFYac8t8uvtmNF73ubLQpqxPWbCQNxWONvTz7wYM=
X-Received: from wmbfm22.prod.google.com ([2002:a05:600c:c16:b0:439:98a4:d14])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f93:b0:439:9c0e:3692 with SMTP id 5b1f17b1804b1-439b75b6417mr142482775e9.28.1740561821904;
 Wed, 26 Feb 2025 01:23:41 -0800 (PST)
Date: Wed, 26 Feb 2025 09:23:39 +0000
In-Reply-To: <ea2466c4d250ff953b3be9602a3671fb@dakr.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ea2466c4d250ff953b3be9602a3671fb@dakr.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226092339.989767-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to Registration::new()
From: Alice Ryhl <aliceryhl@google.com>
To: kernel@dakr.org
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, gary@garyguo.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, lyude@redhat.com, mairacanal@riseup.net, 
	ojeda@kernel.org, rafael@kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:06=E2=80=AFAM <kernel@dakr.org> wrote:
>
> On 2025-02-26 09:38, Alice Ryhl wrote:
> > On Tue, Feb 25, 2025 at 10:31=E2=80=AFPM Lyude Paul <lyude@redhat.com> =
wrote:
> >>
> >> A little late in the review of the faux device interface, we added the
> >> ability to specify a parent device when creating new faux devices -
> >> but
> >> this never got ported over to the rust bindings. So, let's add the
> >> missing
> >> argument now so we don't have to convert other users later down the
> >> line.
> >>
> >> Signed-off-by: Lyude Paul <lyude@redhat.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> >>  rust/kernel/faux.rs              | 10 ++++++++--
> >>  samples/rust/rust_driver_faux.rs |  2 +-
> >>  2 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> >> index 41751403cd868..ae99ea3d114ef 100644
> >> --- a/rust/kernel/faux.rs
> >> +++ b/rust/kernel/faux.rs
> >> @@ -23,11 +23,17 @@
> >>
> >>  impl Registration {
> >>      /// Create and register a new faux device with the given name.
> >> -    pub fn new(name: &CStr) -> Result<Self> {
> >> +    pub fn new(name: &CStr, parent: Option<&device::Device>) ->
> >> Result<Self> {
> >>          // SAFETY:
> >>          // - `name` is copied by this function into its own storage
> >>          // - `faux_ops` is safe to leave NULL according to the C API
> >> -        let dev =3D unsafe {
> >> bindings::faux_device_create(name.as_char_ptr(), null_mut(), null())
> >> };
> >> +        let dev =3D unsafe {
> >> +            bindings::faux_device_create(
> >> +                name.as_char_ptr(),
> >> +                parent.map_or(null_mut(), |p| p.as_raw()),
> >> +                null(),
> >
> > This function signature only requires that `parent` is valid for the
> > duration of this call to `new`, but `faux_device_create` stashes a
> > pointer without touching the refcount. How do you ensure that the
> > `parent` pointer does not become dangling?
>
> I was wondering the same, but it seems that the subsequent device_add()
> call takes care of that:
>
> https://elixir.bootlin.com/linux/v6.14-rc3/source/drivers/base/core.c#L35=
88
>
> device_del() drops the reference.
>
> This makes device->parent only valid for the duration between
> faux_device_create() and faux_device_remove().
>
> But this detail shouldn=E2=80=99t be relevant for this API.

I think this could use a few more comments to explain it. E.g.:

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 531e9d789ee0..674db8863d96 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -131,6 +131,7 @@ struct faux_device *faux_device_create_with_groups(cons=
t char *name,
=20
        device_initialize(dev);
        dev->release =3D faux_device_release;
+       /* The refcount of dev->parent is incremented in device_add. */
        if (parent)
                dev->parent =3D parent;
        else
diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 7673501ebe37..713ee6842e3f 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -28,6 +28,7 @@ pub fn new(name: &CStr, parent: Option<&device::Device>) =
-> Result<Self> {
         // SAFETY:
         // - `name` is copied by this function into its own storage
         // - `faux_ops` is safe to leave NULL according to the C API
+        // - `faux_device_create` ensures that `parent` stays alive until =
`faux_device_destroy`.
         let dev =3D unsafe {
             bindings::faux_device_create(
                 name.as_char_ptr(),


