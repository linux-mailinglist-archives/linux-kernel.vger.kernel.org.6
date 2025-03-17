Return-Path: <linux-kernel+bounces-565023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03CEA65F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1387189ED46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698E01F5842;
	Mon, 17 Mar 2025 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=@dugarreau.fr header.b="rJnAN5nw";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="xu4kjjd3"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B5372
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244271; cv=none; b=RCPL7P2LrtiKhZ2JqMWcZzj9yXyxZxeKmlW7orzTmV3mD671Roh3Dbx5dTaF9GiKq4ir4X0kkSklE58YVOw/+cGQqm60GDokSVR/YUIipvD9EnW4+XXfTyDmHO6L9OjYfHxQseEM6wR/w3R6ykZok4k5vzi/U78Ty9mWUA76XtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244271; c=relaxed/simple;
	bh=2VIpzAjl68o0p8S7mcQrVUB6sZdPkNnlEre8HW9VFu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yy4vIV1yMtV8grJ9IYi5RdSEW6TdwY+wWRg9B+wr0p2NqZtPQ2Fjza1a6jImoP3In/l8KB2tgdBx+0XI3z7R0/0gvZz/ozyKwBBZEWROPuo4lgPuxMFnRFgE6d4OpXbpgp63O6FWhNXljkF+FPz3pc/Rg2Gzgl6pGXuu5DySRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dugarreau.fr; spf=pass smtp.mailfrom=dugarreau.fr; dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=@dugarreau.fr header.b=rJnAN5nw; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=xu4kjjd3; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dugarreau.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dugarreau.fr
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=rJnAN5nwqzkXkjawByJfXT8rurLJRNkv2H/v/mHAxVx1SxkFUGIkOKiFg7N47SzkPCq32fwYzjISkZ2rWBh2UVgFALj1v3npNRKdXVPlvrkqGxiDnA1iB7hRLrS4LmNcQRehlMzIujUbOsv2SNd6Emujwnfvaq3d/rcVnwRaz9gzrMJj/exEhzcjASpKKbCeZOjixYlDBqlcpKGSWOE6w5yBtn/t2xYjZTz41opnKDpmIHqsSF4DApdzGgvX3WeCRv4IZjIlENEZ7j8DIfPjooZtAuavNtj2nrmcNElNeSAf2uFDdIbU5FQm+GVOoT1WWFO4p7MfUNFfj56jvJo4tQ==; s=purelymail1; d=dugarreau.fr; v=1; bh=2VIpzAjl68o0p8S7mcQrVUB6sZdPkNnlEre8HW9VFu0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=xu4kjjd3t6IK+m79KOAGa8cnHwHn5zWf9aYbU7FWp9spwh3BBKCJcUWNlQ3mSDsG+3prxGZqJX1iwmZpMxCT6uen5KrXL3PJ1OY6jQgZqvunsWGhnp69Evb0GqY9AUT0xPz6AgLSSgf09aHdZitckgg+jfMsu4UmU5m8DTB+j92r+EEDis40HyaJI9tCj3nnJ3wegGlmMwMijnMaGq8SPccZhmJ9sZd59s4OzAx6aLcWVeZHAYuaEcMPTecbUYTxam/VoNjPpBypzM2U1awJmWTjFtEcB8D81G/tKG1scl1AbBgPnQbhORBW69owbh74gALlZVy7Aehwj3QdYWLGyw==; s=purelymail1; d=purelymail.com; v=1; bh=2VIpzAjl68o0p8S7mcQrVUB6sZdPkNnlEre8HW9VFu0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 78338:10797:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 274540095;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Mar 2025 20:43:52 +0000 (UTC)
From: =?UTF-8?q?Beno=C3=AEt=20du=20Garreau?= <benoit@dugarreau.fr>
To: Danilo Krummrich <dakr@kernel.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20du=20Garreau?= <benoit@dugarreau.fr>,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	airlied@gmail.com,
	acourbot@nvidia.com,
	jhubbard@nvidia.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: auxiliary: add auxiliary registration
Date: Mon, 17 Mar 2025 21:42:51 +0100
Message-ID: <20250317204310.7804-1-benoit@dugarreau.fr>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313022454.147118-4-dakr@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On Thu, 13 Mar 2025 03:23:52 +0100 Danilo Krummrich <dakr@kernel.org> wrote=
:

> Implement the `auxiliary::Registration` type, which provides an API to
> create and register new auxiliary devices in the system.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/auxiliary.rs | 80 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index e453f821f7cb..fc4bb5388a9b 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -5,7 +5,7 @@
>  //! C header: [`include/linux/auxiliary_bus.h`](srctree/include/linux/au=
xiliary_bus.h)
> =20
>  use crate::{
> -    bindings, device,
> +    bindings, container_of, device,
>      device_id::RawDeviceId,
>      driver,
>      error::{to_result, Result},
> @@ -219,6 +219,16 @@ pub fn id(&self) -> u32 {
>          // `struct auxiliary_device`.
>          unsafe { (*self.as_raw()).id }
>      }
> +
> +    extern "C" fn release(dev: *mut bindings::device) {
> +        // SAFETY: By the type invariant `self.0.as_raw` is a pointer to=
 the `struct device`
> +        // embedded in `struct auxiliary_device`.
> +        let adev =3D unsafe { container_of!(dev, bindings::auxiliary_dev=
ice, dev) }.cast_mut();
> +
> +        // SAFETY: `adev` points to the memory that has been allocated i=
n `Registration::new`, via
> +        // `KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GF=
P_KERNEL)`.
> +        let _ =3D unsafe { KBox::<Opaque<bindings::auxiliary_device>>::f=
rom_raw(adev.cast()) };
> +    }
>  }
> =20
>  impl Deref for Device<device::Core> {
> @@ -265,3 +275,71 @@ fn as_ref(&self) -> &device::Device {
>          unsafe { device::Device::as_ref(dev) }
>      }
>  }
> +
> +/// The registration of an auxiliary device.
> +///
> +/// This type represents the registration of a [`struct auxiliary_device=
`]. When an instance of this
> +/// type is dropped, its respective auxiliary device will be unregistere=
d from the system.
> +///
> +/// # Invariants
> +///
> +/// `self.0` always holds a valid pointer to an initialized and register=
ed
> +/// [`struct auxiliary_device`].
> +pub struct Registration(NonNull<bindings::auxiliary_device>);
> +
> +impl Registration {
> +    /// Create and register a new auxiliary device.
> +    pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: &=
CStr) -> Result<Self> {
> +        let boxed =3D KBox::new(Opaque::<bindings::auxiliary_device>::ze=
roed(), GFP_KERNEL)?;

You can use `KBox::init(kernel::init::zeroed(), GFP_KERNEL)` here. It avoid=
s
the need for the first patch.

> +        let adev =3D boxed.get();
> +
> +        // SAFETY: It's safe to set the fields of `struct auxiliary_devi=
ce` on initialization.
> +        unsafe {
> +            (*adev).dev.parent =3D parent.as_raw();
> +            (*adev).dev.release =3D Some(Device::release);
> +            (*adev).name =3D name.as_char_ptr();
> +            (*adev).id =3D id;
> +        }
> +
> +        // SAFETY: `adev` is guaranteed to be a valid pointer to a `stru=
ct auxiliary_device`,
> +        // which has not been initialized yet.
> +        unsafe { bindings::auxiliary_device_init(adev) };
> +
> +        // Now that `adev` is initialized, leak the `Box`; the correspon=
ding memory will be freed
> +        // by `Device::release` when the last reference to the `struct a=
uxiliary_device` is dropped.
> +        let _ =3D KBox::into_raw(boxed);
> +
> +        // SAFETY:
> +        // - `adev` is guaranteed to be a valid pointer to a `struct aux=
iliary_device`, which has
> +        //   been initialialized,
> +        // - `modname.as_char_ptr()` is a NULL terminated string.
> +        let ret =3D unsafe { bindings::__auxiliary_device_add(adev, modn=
ame.as_char_ptr()) };
> +        if ret !=3D 0 {
> +            // SAFETY: `adev` is guaranteed to be a valid pointer to a `=
struct auxiliary_device`,
> +            // which has been initialialized.
> +            unsafe { bindings::auxiliary_device_uninit(adev) };
> +
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        // SAFETY: `adev` is guaranteed to be non-null, since the `KBox`=
 was allocated successfully.
> +        //
> +        // INVARIANT: The device will remain registered until `auxiliary=
_device_delete()` is called,
> +        // which happens in `Self::drop()`.
> +        Ok(Self(unsafe { NonNull::new_unchecked(adev) }))
> +    }
> +}
> +
> +impl Drop for Registration {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariant of `Self`, `self.0.as_ptr()` is=
 a valid registered
> +        // `struct auxiliary_device`.
> +        unsafe { bindings::auxiliary_device_delete(self.0.as_ptr()) };
> +
> +        // This drops the reference we acquired through `auxiliary_devic=
e_init()`.
> +        //
> +        // SAFETY: By the type invariant of `Self`, `self.0.as_ptr()` is=
 a valid registered
> +        // `struct auxiliary_device`.
> +        unsafe { bindings::auxiliary_device_uninit(self.0.as_ptr()) };
> +    }
> +}
> --=20
> 2.48.1
>=20
>=20

Beno=C3=AEt du Garreau

