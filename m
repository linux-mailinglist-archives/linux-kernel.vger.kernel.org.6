Return-Path: <linux-kernel+bounces-435183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DB9E73CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6308B280EF2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA93207DFA;
	Fri,  6 Dec 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4qkzuzc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC81FC7CB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498651; cv=none; b=kcVVlZSFSG/FjbvI44Ymt581knGSsZEO/4QmRvNNWEp/1CVt/CsEqXq3TolZ4YXKkhkjGtsYeJzE57SCR2FrVMet0NmqpBQzAbXe+1ihZ1jli2jEJXB9ASX9Y8v6TJ9Ib3yRSdGNVx6qgFWrJgmw+kzAN7OcmlZFCre3h6FQaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498651; c=relaxed/simple;
	bh=nrVg9jhH7v3k5ywiBFHiUPNfGNFJCUPg1+sz+1Y7P4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aestRRrlYyyXD5jCuUiv7q2+PO4HHZU91olnmwSOz/eXqd2cv4VCGRRVjJrRvKFskHfTy6Rclb3evKKH6YbMhaUHcsSHk7Ks8MbSwfxCMuJYGjwNl+eZb2QI3rvoanwPIa1+qESccycPxY7ZyptRGDV7a53ZuufAGO77KQMGBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4qkzuzc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a45f05feso24927965e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498646; x=1734103446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vG1vcXp4dhdOl8UNewQPNqXqH+J9+EwbKs1DoZeLbA=;
        b=i4qkzuzccGFaPvQFXoHI1MEn4BCutetAVbx0QcVKqjn4Hijtr0/RuGc0CSckI2wXvE
         aoq2rADoNlLr5n35jclHyCXQbLMBauduntJQ3lDjvtvcm1BQ6buzu80gW8Rxn2/e2bll
         e1zQZR3p0/9him5cw9S65o2i0anxZTD6rx/zagzjKYf401xR24XeDDJ4Djdae+pdpnhl
         h6hPppPYqPtusDLlLyJCNFSGaCOk0cq0Nk3Q12Hmu5SDADVGN3lE2oqjPlS/AWbhK5NO
         UcPw3P6t2obWeVk8Bg5Co3fApbFK6Alo0wUyQltjlot4Ucw1XkzXZZLnQUtyjHTGtzCZ
         sCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498646; x=1734103446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vG1vcXp4dhdOl8UNewQPNqXqH+J9+EwbKs1DoZeLbA=;
        b=iuroyek/Q6IviEPqlbKWiCG4m31DgQ2pp1Yo+Gb/zfYCvZzko/s/nWUhSMJqoXquJu
         gwN5QnvR3AMUIah1QZ3TcN7TjUvUqfUQaHHY8KkmiZHQvGxO/gPtvAmmLDzaBx656Opj
         Om7o2x6zYyDaO72HiH5ICCAaWjiru/YusgDFhBxe2IM4zFmOBjogQ3wdDqQXwy4eEWSZ
         EvqROmWEUmtGs1xZlUqlo6dU1aql88kuR9QIL47+e5SMrZl9EsYTAEcwqJfBIUDYjWOq
         WUxsnUglB0KbFEvGxehMLWN/c6MqEVI9W1KpUfuFI8AWhXee2ACi6+W32cLARjqiiAtM
         HlOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9kgioJRVL424zdT1Tq6WwinEJtKHb5jha/3d3Rnf2QNqFIOkxts7I5ETHrPgVR3FRGD1oQ1H5JUtEVzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGkvdTf0ocYpW4TmErlRH5ugFo7nEiA6o5Ha/ZBCD4jO2gXjY
	twa8MiSjomgrZ4iGQHRSNB0ihfST1EVCJ1yHbUljXXrYkqg0pKC7SG+dOx++xwEuzn2XtjE8XgV
	2xb5vjLomY/cBsshht7YMDYxjD5SGcwvMI/T/
X-Gm-Gg: ASbGncvkim3vICvU0e+3IWrd7CPtUnE0h6W43RXUMSTduVKq75++Zo5YIc2jz32VyE0
	IrBUXVB1pSFav4QRIHNhaOyJ12eMTLP3P
X-Google-Smtp-Source: AGHT+IFhlYxImC8iGxHsowwIo8v7JsY2PS0LScpEHYoIr2Ldib6jctvlX+fk8wlCikVdEERWQF8scgN/DVvgThRUn6U=
X-Received: by 2002:a05:6000:471b:b0:385:f6f4:f8e with SMTP id
 ffacd0b85a97d-3862b3db59amr2473108f8f.50.1733498645966; Fri, 06 Dec 2024
 07:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930233257.1189730-1-lyude@redhat.com> <20240930233257.1189730-3-lyude@redhat.com>
In-Reply-To: <20240930233257.1189730-3-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 16:23:54 +0100
Message-ID: <CAH5fLgg6OnKLPiXXF9skpq4g7jVqgw5rJjJsLschYX5E072m2Q@mail.gmail.com>
Subject: Re: [WIP RFC v2 02/35] WIP: rust: drm: Add traits for registering KMS devices
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@kernel.org>, mcanal@igalia.com, 
	airlied@redhat.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@redhat.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:37=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrote:
>
> This commit adds some traits for registering DRM devices with KMS support=
,
> implemented through the kernel::drm::kms::Kms trait. Devices which don't
> have KMS support can simply use PhantomData<Self>.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---
>
> TODO:
> * Generate feature flags automatically, these shouldn't need to be
>   specified by the user
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/bindings/bindings_helper.h |   4 +
>  rust/kernel/drm/device.rs       |  18 ++-
>  rust/kernel/drm/drv.rs          |  45 ++++++-
>  rust/kernel/drm/kms.rs          | 230 ++++++++++++++++++++++++++++++++
>  rust/kernel/drm/kms/fbdev.rs    |  45 +++++++
>  rust/kernel/drm/mod.rs          |   1 +
>  6 files changed, 335 insertions(+), 8 deletions(-)
>  create mode 100644 rust/kernel/drm/kms.rs
>  create mode 100644 rust/kernel/drm/kms/fbdev.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 04898f70ef1b8..4a8e44e11c96a 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,11 +6,15 @@
>   * Sorted alphabetically.
>   */
>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_fourcc.h>
> +#include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/drm_ioctl.h>
>  #include <kunit/test.h>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 2b687033caa2d..d4d6b1185f6a6 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -5,14 +5,22 @@
>  //! C header: [`include/linux/drm/drm_device.h`](srctree/include/linux/d=
rm/drm_device.h)
>
>  use crate::{
> -    bindings, device, drm,
> -    drm::drv::AllocImpl,
> +    bindings, device,
> +    drm::{
> +        drv::AllocImpl,
> +        self,
> +        kms::{KmsImpl, private::KmsImpl as KmsImplPrivate}
> +    },
>      error::code::*,
>      error::from_err_ptr,
>      error::Result,
>      types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
>  };
> -use core::{ffi::c_void, marker::PhantomData, ptr::NonNull};
> +use core::{
> +    ffi::c_void,
> +    marker::PhantomData,
> +    ptr::NonNull
> +};
>
>  #[cfg(CONFIG_DRM_LEGACY)]
>  macro_rules! drm_legacy_fields {
> @@ -150,6 +158,10 @@ pub fn data(&self) -> <T::Data as ForeignOwnable>::B=
orrowed<'_> {
>          // SAFETY: `Self::data` is always converted and set on device cr=
eation.
>          unsafe { <T::Data as ForeignOwnable>::from_foreign(drm.raw_data(=
)) };
>      }
> +
> +    pub(crate) const fn has_kms() -> bool {
> +        <T::Kms as KmsImplPrivate>::MODE_CONFIG_OPS.is_some()
> +    }
>  }
>
>  // SAFETY: DRM device objects are always reference counted and the get/p=
ut functions
> diff --git a/rust/kernel/drm/drv.rs b/rust/kernel/drm/drv.rs
> index 0cf3fb1cea53c..6b61f2755ba79 100644
> --- a/rust/kernel/drm/drv.rs
> +++ b/rust/kernel/drm/drv.rs
> @@ -8,7 +8,15 @@
>      alloc::flags::*,
>      bindings,
>      devres::Devres,
> -    drm,
> +    drm::{
> +        self,
> +        kms::{
> +            KmsImpl,
> +            private::KmsImpl as KmsImplPrivate,
> +            Kms
> +        }
> +    },
> +    device,
>      error::{Error, Result},
>      private::Sealed,
>      str::CStr,
> @@ -142,6 +150,12 @@ pub trait Driver {
>      /// The type used to represent a DRM File (client)
>      type File: drm::file::DriverFile;
>
> +    /// The KMS implementation for this driver.
> +    ///
> +    /// Drivers that wish to support KMS should pass their implementatio=
n of `drm::kms::KmsDriver`
> +    /// here. Drivers which do not have KMS support can simply pass `drm=
::kms::NoKms` here.
> +    type Kms: drm::kms::KmsImpl<Driver =3D Self> where Self: Sized;

Associated types are not really intended for optional behavior. Can't
you move this to a separate trait instead of using an associated type?

>      /// Driver metadata
>      const INFO: DriverInfo;
>
> @@ -159,21 +173,36 @@ pub trait Driver {
>
>  impl<T: Driver> Registration<T> {
>      /// Creates a new [`Registration`] and registers it.
> -    pub fn new(drm: ARef<drm::device::Device<T>>, flags: usize) -> Resul=
t<Self> {
> +    pub fn new(dev: &device::Device, data: T::Data, flags: usize) -> Res=
ult<Self> {
> +        let drm =3D drm::device::Device::<T>::new(dev, data)?;
> +        let has_kms =3D drm::device::Device::<T>::has_kms();
> +
> +        let mode_config_info =3D if has_kms {
> +            // SAFETY: We have yet to register this device
> +            Some(unsafe { T::Kms::setup_kms(&drm)? })
> +        } else {
> +            None
> +        };
> +
>          // SAFETY: Safe by the invariants of `drm::device::Device`.
>          let ret =3D unsafe { bindings::drm_dev_register(drm.as_raw(), fl=
ags as u64) };
>          if ret < 0 {
>              return Err(Error::from_errno(ret));
>          }
>
> +        if let Some(ref info) =3D mode_config_info {
> +            // SAFETY: We just registered the device above
> +            unsafe { T::Kms::setup_fbdev(&drm, info) };
> +        }
> +
>          Ok(Self(drm))
>      }
>
>      /// Same as [`Registration::new`}, but transfers ownership of the [`=
Registration`] to `Devres`.
> -    pub fn new_foreign_owned(drm: ARef<drm::device::Device<T>>, flags: u=
size) -> Result {
> -        let reg =3D Registration::<T>::new(drm.clone(), flags)?;
> +    pub fn new_foreign_owned(dev: &device::Device, data: T::Data, flags:=
 usize) -> Result {
> +        let reg =3D Registration::<T>::new(dev, data, flags)?;
>
> -        Devres::new_foreign_owned(drm.as_ref(), reg, GFP_KERNEL)
> +        Devres::new_foreign_owned(dev, reg, GFP_KERNEL)
>      }
>
>      /// Returns a reference to the `Device` instance for this registrati=
on.
> @@ -195,5 +224,11 @@ fn drop(&mut self) {
>          // SAFETY: Safe by the invariant of `ARef<drm::device::Device<T>=
>`. The existance of this
>          // `Registration` also guarantees the this `drm::device::Device`=
 is actually registered.
>          unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
> +
> +        if drm::device::Device::<T>::has_kms() {
> +            // SAFETY: We just checked above that KMS was setup for this=
 device, so this is safe to
> +            // call
> +            unsafe { bindings::drm_atomic_helper_shutdown(self.0.as_raw(=
)) }
> +        }
>      }
>  }
> diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
> new file mode 100644
> index 0000000000000..d3558a5eccc54
> --- /dev/null
> +++ b/rust/kernel/drm/kms.rs
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! KMS driver abstractions for rust.
> +
> +pub mod fbdev;
> +
> +use crate::{
> +    drm::{
> +        drv::Driver,
> +        device::Device
> +    },
> +    device,
> +    prelude::*,
> +    types::*,
> +    error::to_result,
> +    private::Sealed,
> +};
> +use core::{
> +    ops::Deref,
> +    ptr::{self, NonNull},
> +    mem::{self, ManuallyDrop},
> +    marker::PhantomData,
> +};
> +use bindings;
> +
> +/// The C vtable for a [`Device`].
> +///
> +/// This is created internally by DRM.
> +pub(crate) struct ModeConfigOps {
> +    pub(crate) kms_vtable: bindings::drm_mode_config_funcs,
> +    pub(crate) kms_helper_vtable: bindings::drm_mode_config_helper_funcs
> +}
> +
> +/// A trait representing a type that can be used for setting up KMS, or =
a stub.
> +///
> +/// For drivers which don't have KMS support, the methods provided by th=
is trait may be stubs. It is
> +/// implemented internally by DRM.
> +pub trait KmsImpl: private::KmsImpl {}
> +
> +pub(crate) mod private {
> +    use super::*;
> +
> +    /// Private callback implemented internally by DRM for setting up KM=
S on a device, or stubbing
> +    /// the KMS setup for devices which don't have KMS support can just =
use [`PhantomData`].
> +    pub trait KmsImpl {

I noticed you use sealing a lot. Why?

> +        /// The parent driver for this KMS implementation
> +        type Driver: Driver;
> +
> +        /// The optional KMS callback operations for this driver.
> +        const MODE_CONFIG_OPS: Option<ModeConfigOps>;
> +
> +        /// The callback for setting up KMS on a device
> +        ///
> +        /// # Safety
> +        ///
> +        /// `drm` must be unregistered.
> +        unsafe fn setup_kms(drm: &Device<Self::Driver>) -> Result<ModeCo=
nfigInfo> {
> +            build_error::build_error("This should never be reachable")

This pattern makes sense for #[vtable] users, but I don't think it
makes sense here. You always override these methods, so you can leave
them without a body here.

> +        }
> +
> +        /// The callback for setting up fbdev emulation on a KMS device.
> +        ///
> +        /// # Safety
> +        ///
> +        /// `drm` must be registered.
> +        unsafe fn setup_fbdev(drm: &Device<Self::Driver>, mode_config_in=
fo: &ModeConfigInfo) {
> +            build_error::build_error("This should never be reachable")
> +        }
> +    }
> +}
> +
> +/// A [`Device`] with KMS initialized that has not been registered with =
userspace.
> +///
> +/// This type is identical to [`Device`], except that it is able to crea=
te new static KMS resources.
> +/// It represents a KMS device that is not yet visible to userspace, and=
 also contains miscellaneous
> +/// state required during the initialization process of a [`Device`].
> +pub struct UnregisteredKmsDevice<'a, T: Driver> {
> +    drm: &'a Device<T>,
> +}
> +
> +impl<'a, T: Driver> Deref for UnregisteredKmsDevice<'a, T> {
> +    type Target =3D Device<T>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.drm
> +    }
> +}
> +
> +impl<'a, T: Driver> UnregisteredKmsDevice<'a, T> {
> +    /// Construct a new [`UnregisteredKmsDevice`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller promises that `drm` is an unregistered [`Device`].
> +    pub(crate) unsafe fn new(drm: &'a Device<T>) -> Self {
> +        Self {
> +            drm,
> +        }
> +    }
> +}
> +
> +/// A trait which must be implemented by drivers that wish to support KM=
S
> +///
> +/// It should be implemented for the same type that implements [`Driver`=
]. Drivers which don't
> +/// support KMS should use [`PhantomData<Self>`].
> +///
> +/// [`PhantomData<Self>`]: PhantomData
> +#[vtable]
> +pub trait Kms {
> +    /// The parent [`Driver`] for this [`Device`].
> +    type Driver: KmsDriver;
> +
> +    /// The fbdev implementation to use for this [`Device`].
> +    ///
> +    /// Which implementation may be used here depends on the GEM impleme=
ntation specified in
> +    /// [`Driver::Object`]. See [`fbdev`] for more information.
> +    type Fbdev: fbdev::FbdevImpl;
> +
> +    /// Return a [`ModeConfigInfo`] structure for this [`device::Device`=
].
> +    fn mode_config_info(
> +        dev: &device::Device,
> +        drm_data: <<Self::Driver as Driver>::Data as ForeignOwnable>::Bo=
rrowed<'_>,
> +    ) -> Result<ModeConfigInfo>;
> +
> +    /// Create mode objects like [`crtc::Crtc`], [`plane::Plane`], etc. =
for this device
> +    fn create_objects(drm: &UnregisteredKmsDevice<'_, Self::Driver>) -> =
Result;
> +}
> +
> +impl<T: Kms> private::KmsImpl for T {
> +    type Driver =3D T::Driver;
> +
> +    const MODE_CONFIG_OPS: Option<ModeConfigOps> =3D Some(ModeConfigOps =
{
> +        kms_vtable: bindings::drm_mode_config_funcs {
> +            atomic_check: Some(bindings::drm_atomic_helper_check),
> +            // TODO TODO: There are other possibilities then this functi=
on, but we need
> +            // to write up more bindings before we can support those
> +            fb_create: Some(bindings::drm_gem_fb_create),
> +            mode_valid: None, // TODO
> +            atomic_commit: Some(bindings::drm_atomic_helper_commit),
> +            get_format_info: None,
> +            atomic_state_free: None,
> +            atomic_state_alloc: None,
> +            atomic_state_clear: None,
> +            output_poll_changed: None,
> +        },
> +
> +        kms_helper_vtable: bindings::drm_mode_config_helper_funcs {
> +            atomic_commit_setup: None, // TODO
> +            atomic_commit_tail: None, // TODO
> +        },
> +    });
> +
> +    unsafe fn setup_kms(drm: &Device<Self::Driver>) -> Result<ModeConfig=
Info> {
> +        let mode_config_info =3D T::mode_config_info(drm.as_ref(), drm.d=
ata())?;
> +
> +        // SAFETY: `MODE_CONFIG_OPS` is always Some() in this implementa=
tion
> +        let ops =3D unsafe { T::MODE_CONFIG_OPS.as_ref().unwrap_unchecke=
d() };
> +
> +        // SAFETY:
> +        // - This function can only be called before registration via ou=
r safety contract.
> +        // - Before registration, we are the only ones with access to th=
is device.
> +        unsafe {
> +            (*drm.as_raw()).mode_config =3D bindings::drm_mode_config {
> +                funcs: &ops.kms_vtable,
> +                helper_private: &ops.kms_helper_vtable,
> +                min_width: mode_config_info.min_resolution.0,
> +                min_height: mode_config_info.min_resolution.1,
> +                max_width: mode_config_info.max_resolution.0,
> +                max_height: mode_config_info.max_resolution.1,
> +                cursor_width: mode_config_info.max_cursor.0,
> +                cursor_height: mode_config_info.max_cursor.1,
> +                preferred_depth: mode_config_info.preferred_depth,
> +                ..Default::default()
> +            };
> +        }
> +
> +        // SAFETY: We just setup all of the required info this function =
needs in `drm_device`
> +        to_result(unsafe { bindings::drmm_mode_config_init(drm.as_raw())=
 })?;
> +
> +        // SAFETY: `drm` is guaranteed to be unregistered via our safety=
 contract.
> +        let drm =3D unsafe { UnregisteredKmsDevice::new(drm) };
> +
> +        T::create_objects(&drm)?;
> +
> +        // TODO: Eventually add a hook to customize how state readback h=
appens, for now just reset
> +        // SAFETY: Since all static modesetting objects were created in =
`T::create_objects()`, and
> +        // that is the only place they can be created, this fulfills the=
 C API requirements.
> +        unsafe { bindings::drm_mode_config_reset(drm.as_raw()) };
> +
> +        Ok(mode_config_info)
> +    }
> +
> +    unsafe fn setup_fbdev(drm: &Device<Self::Driver>, mode_config_info: =
&ModeConfigInfo) {
> +        <<T as Kms>::Fbdev as fbdev::private::FbdevImpl>::setup_fbdev(dr=
m, mode_config_info)
> +    }
> +}
> +
> +impl<T: Kms> KmsImpl for T {}
> +
> +impl<T: Driver> private::KmsImpl for PhantomData<T> {
> +    type Driver =3D T;
> +
> +    const MODE_CONFIG_OPS: Option<ModeConfigOps> =3D None;
> +}
> +
> +impl<T: Driver> KmsImpl for PhantomData<T> {}
> +
> +/// Various device-wide information for a [`Device`] that is provided du=
ring initialization.
> +#[derive(Copy, Clone)]
> +pub struct ModeConfigInfo {
> +    /// The minimum (w, h) resolution this driver can support
> +    pub min_resolution: (i32, i32),
> +    /// The maximum (w, h) resolution this driver can support
> +    pub max_resolution: (i32, i32),
> +    /// The maximum (w, h) cursor size this driver can support
> +    pub max_cursor: (u32, u32),
> +    /// The preferred depth for dumb ioctls
> +    pub preferred_depth: u32,
> +}
> +
> +/// A [`Driver`] with [`Kms`] implemented.
> +///
> +/// This is implemented internally by DRM for any [`Device`] whose [`Dri=
ver`] type implements
> +/// [`Kms`], and provides access to methods which are only safe to use w=
ith KMS devices.
> +pub trait KmsDriver: Driver {}
> +
> +impl<T, K> KmsDriver for T
> +where
> +    T: Driver<Kms =3D K>,
> +    K: Kms<Driver =3D T> {}
> diff --git a/rust/kernel/drm/kms/fbdev.rs b/rust/kernel/drm/kms/fbdev.rs
> new file mode 100644
> index 0000000000000..bdf97500137d8
> --- /dev/null
> +++ b/rust/kernel/drm/kms/fbdev.rs
> @@ -0,0 +1,45 @@
> +//! Fbdev helper implementations for rust.
> +//!
> +//! This module provides the various Fbdev implementations that can be u=
sed by Rust KMS drivers.
> +use core::marker::*;
> +use crate::{private::Sealed, drm::{kms::*, device::Device, gem}};
> +use bindings;
> +
> +pub(crate) mod private {
> +    use super::*;
> +
> +    pub trait FbdevImpl {
> +        /// Setup the fbdev implementation for this KMS driver.
> +        fn setup_fbdev<T: Driver>(drm: &Device<T>, mode_config_info: &Mo=
deConfigInfo);
> +    }
> +}
> +
> +/// The main trait for a driver's DRM implementation.
> +///
> +/// Drivers are expected not to implement this directly, and to instead =
use one of the objects
> +/// provided by this module such as [`FbdevDma`].
> +pub trait FbdevImpl: private::FbdevImpl {}
> +
> +/// The fbdev implementation for drivers using the gem DMA helpers.
> +///
> +/// Drivers which use the gem DMA helpers ([`gem::Object`]) should use t=
his for their [`Kms::Fbdev`]
> +/// type.
> +pub struct FbdevDma<T: Driver>(PhantomData<T>);
> +
> +impl<T, G> private::FbdevImpl for FbdevDma<T>
> +where
> +    T: Driver<Object =3D gem::Object<G>>,
> +    G: gem::DriverObject
> +{
> +    #[inline]
> +    fn setup_fbdev<D: Driver>(drm: &Device<D>, mode_config_info: &ModeCo=
nfigInfo) {
> +        // SAFETY: Our implementation bounds re proof that this driver i=
s using the gem dma helpers
> +        unsafe { bindings::drm_fbdev_dma_setup(drm.as_raw(), mode_config=
_info.preferred_depth) };
> +    }
> +}
> +
> +impl<T, G> FbdevImpl for FbdevDma<T>
> +where
> +    T: Driver<Object =3D gem::Object<G>>,
> +    G: gem::DriverObject
> +{}
> diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> index 2c12dbd181997..049ae675cb9b1 100644
> --- a/rust/kernel/drm/mod.rs
> +++ b/rust/kernel/drm/mod.rs
> @@ -8,3 +8,4 @@
>  pub mod fourcc;
>  pub mod gem;
>  pub mod ioctl;
> +pub mod kms;
> --
> 2.46.1
>

