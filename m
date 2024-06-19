Return-Path: <linux-kernel+bounces-220734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA190E668
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B369E1C21A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BAD7E776;
	Wed, 19 Jun 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WbQG+LYQ"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28557D07E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787494; cv=none; b=dnKhJPLMot9tGynNmy37rr59gW0Dx+CUP8O2/e8b7K8wfbGaBd49t310/jDvVle/S0uXW1zDI+t8SBC2EjRAw7p+1rgBDethB59/AXt1VG9TvtZ+OssggIbhRlpfETmNVY9NZPjm7pikh7nrQFpreAesPSLnsEBqmzpizmoDs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787494; c=relaxed/simple;
	bh=rv2HbQXJ+ZNOdIcmtLJ/tLCPs/V13RHkfTLZowlsMyM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHjtEZKh3wbZM2XgpTsw5x4ttOMrKrcirF2Y3MggnUpOw8O8U373bIDT4Kk6tmmhgNsw74m0CRYso1eKAZOw5gqKxeaA3bN5UTZVLrKUSZeUC8kxnnbb+iT5opjz5c+nHL/A00sHGcEYxspTRlSqsNbor++15C0viAruvh90+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WbQG+LYQ; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=u5dtot3z6vh7vccjkdu25dkrbe.protonmail; t=1718787488; x=1719046688;
	bh=HJEykIBQeAFrRfaX3nx6pvcdSxMvWpR/+b2SbLtreiU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WbQG+LYQV4puXDcd0PP7gSq5EPjVsxcZ1kL8/Q+mZQm23LBa6AwH+qbkWgHnm34oX
	 I6/t538tExx3qzzIoJx7lZf84T2/9Hc1nbH7wSGnL96n4REk5xMmNvIzTE8B05ieSp
	 PeucHvhB8R0tNJgK1ZUJuplRUoyp5+NcErKnwf0De7Fg9ZkKfvpBx1O9NAESzU6Z9+
	 4jLh7pkN28tRPWZtFgwGCK7S+JC3DvZahtQ+btD/J0IPB4mJjCMZVEkWb9/+rd7+xo
	 BJfgC6S1bNyhQKlLMEIk25948/Ueurly2H8UN7YTjnvOPoCJUyDKMs+7yyrwp4ktlm
	 miQEfed4r14pg==
Date: Wed, 19 Jun 2024 08:58:02 +0000
To: Danilo Krummrich <dakr@redhat.com>, gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org, russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rust: add firmware abstractions
Message-ID: <8d6f98c2-afe2-4e94-b630-96a8fa0b39cf@proton.me>
In-Reply-To: <20240618154841.6716-3-dakr@redhat.com>
References: <20240618154841.6716-1-dakr@redhat.com> <20240618154841.6716-3-dakr@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5591b58e96b9dc2c505922c5bd6d1cfc55f59249
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.06.24 17:48, Danilo Krummrich wrote:
> Add an abstraction around the kernels firmware API to request firmware
> images. The abstraction provides functions to access the firmware's size
> and backing buffer.
>=20
> The firmware is released once the abstraction instance is dropped.
>=20
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  drivers/base/firmware_loader/Kconfig |   7 ++
>  rust/bindings/bindings_helper.h      |   1 +
>  rust/kernel/firmware.rs              | 101 +++++++++++++++++++++++++++
>  rust/kernel/lib.rs                   |   2 +
>  4 files changed, 111 insertions(+)
>  create mode 100644 rust/kernel/firmware.rs
>=20
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware=
_loader/Kconfig
> index 5ca00e02fe82..a03701674265 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -37,6 +37,13 @@ config FW_LOADER_DEBUG
>  =09  SHA256 checksums to the kernel log for each firmware file that is
>  =09  loaded.
>=20
> +config RUST_FW_LOADER_ABSTRACTIONS
> +=09bool "Rust Firmware Loader abstractions"
> +=09depends on RUST
> +=09depends on FW_LOADER=3Dy
> +=09help
> +=09  This enables the Rust abstractions for the firmware loader API.
> +
>  if FW_LOADER
>=20
>  config FW_LOADER_PAGED_BUF
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index ddb5644d4fd9..18a3f05115cb 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
>  #include <kunit/test.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> +#include <linux/firmware.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> new file mode 100644
> index 000000000000..b55ea1b45368
> --- /dev/null
> +++ b/rust/kernel/firmware.rs
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Firmware abstraction
> +//!
> +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmwar=
e.h")
> +
> +use crate::{bindings, device::Device, error::Error, error::Result, str::=
CStr};
> +use core::ptr::NonNull;
> +
> +// One of the following: `bindings::request_firmware`, `bindings::firmwa=
re_request_nowarn`,
> +// `firmware_request_platform`, `bindings::request_firmware_direct`
> +type FwFunc =3D
> +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut=
 bindings::device) -> i32;
> +
> +/// Abstraction around a C `struct firmware`.
> +///
> +/// This is a simple abstraction around the C firmware API. Just like wi=
th the C API, firmware can
> +/// be requested. Once requested the abstraction provides direct access =
to the firmware buffer as
> +/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
> +///
> +/// # Invariants
> +///
> +/// The pointer is valid, and has ownership over the instance of `struct=
 firmware`.
> +///
> +/// Once requested, the `Firmware` backing buffer is not modified until =
it is freed when `Firmware`
> +/// is dropped.

This can simply be "The `firmware`'s backing buffer is not modified."
Since I interpret "Once requested" as "Once created" and you are allowed
to break invariants as long as nobody can observe that.

> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{c_str, device::Device, firmware::Firmware};
> +///
> +/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device=
>` instance
> +/// # let dev =3D unsafe { Device::from_raw(core::ptr::null_mut()) };
> +///
> +/// let fw =3D Firmware::request(c_str!("path/to/firmware.bin"), &dev).u=
nwrap();
> +/// let blob =3D fw.data();
> +/// ```
> +pub struct Firmware(NonNull<bindings::firmware>);
> +
> +impl Firmware {
> +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Resu=
lt<Self> {
> +        let mut fw: *mut bindings::firmware =3D core::ptr::null_mut();
> +        let pfw: *mut *mut bindings::firmware =3D &mut fw;
> +
> +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindi=
ngs::firmware` pointer.
> +        // `name` and `dev` are valid as by their type invariants.
> +        let ret =3D unsafe { func(pfw as _, name.as_char_ptr(), dev.as_r=
aw()) };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        // SAFETY: `func` not bailing out with a non-zero error code, gu=
arantees that `fw` is a
> +        // valid pointer to `bindings::firmware`.
> +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> +    }
> +
> +    /// Send a firmware request and wait for it. See also `bindings::req=
uest_firmware`.
> +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::request_firmware)
> +    }
> +
> +    /// Send a request for an optional firmware module. See also
> +    /// `bindings::firmware_request_nowarn`.
> +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::firmware_request_now=
arn)
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::firmware {
> +        self.0.as_ptr()
> +    }
> +
> +    /// Returns the size of the requested firmware in bytes.
> +    pub fn size(&self) -> usize {
> +        // SAFETY: Safe by the type invariant.
> +        unsafe { (*self.as_raw()).size }
> +    }
> +
> +    /// Returns the requested firmware as `&[u8]`.
> +    pub fn data(&self) -> &[u8] {
> +        // SAFETY: Safe by the type invariant. Additionally, `bindings::=
firmware` guarantees, if

I would not write "Safe by ...", since it is important to know what is
guaranteed by what. Instead I would write "self.as_raw() is valid by the
type invariant.".

> +        // successfully requested, that `bindings::firmware::data` has a=
 size of
> +        // `bindings::firmware::size` bytes.
> +        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self=
.size()) }
> +    }
> +}
> +
> +impl Drop for Firmware {
> +    fn drop(&mut self) {
> +        // SAFETY: Safe by the type invariant.

Ditto.

---
Cheers,
Benno

> +        unsafe { bindings::release_firmware(self.as_raw()) };
> +    }
> +}
> +
> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, whi=
ch is safe to be used from
> +// any thread.
> +unsafe impl Send for Firmware {}
> +
> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, ref=
erences to which are safe to
> +// be used from any thread.
> +unsafe impl Sync for Firmware {}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index dd1207f1a873..7707cb013ce9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -30,6 +30,8 @@
>  mod build_assert;
>  pub mod device;
>  pub mod error;
> +#[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> +pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]
> --
> 2.45.1
>=20


