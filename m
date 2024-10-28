Return-Path: <linux-kernel+bounces-385286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3E9B350A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54B11C2208A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B701DE3DD;
	Mon, 28 Oct 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uInJCZN6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1911DE2C1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129870; cv=none; b=ZrPVI6Bm01wPKExJMPu2xdTl9r5COSzJhhCLYgV+9LVHVpDJWk1kdnKWGwWpkAt6Fl3PLXjAx5zBMM5ub+Gc664H5GVI7QcFu7Wm3wUmUCVLyUOTs0tTbzUy389AhbvUnZ2te7Z3yN6mQNNRmdR4ik32FdE0IELLXpgKRkyHdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129870; c=relaxed/simple;
	bh=gp8p/E1q3QQ/XXeXEyke9fsBfZ7qUUK/syY9+dE8gpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErwQn782cQlOrJr8DZLYkHhqsKQQcKYeLa+dWr9U0DeG7QVpkp/rBUDkO7m/N41gx2t4oqsPVYLlPqHS8MUrN0LGhWE6GZZYFSdGyyD7DsNMExNvdP+0NhJmOxgI+3Np+BpgpMAYInijIjpvJQnBPRrwWIWuRb7t3gmfo8G1lgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uInJCZN6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43161c0068bso43226465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730129866; x=1730734666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v9gt9mdtE62qh7vOT25ST+W1xRqFPgaFplsaFpnNXc=;
        b=uInJCZN6Ask/pHED/dgYFGTd5xozVpJnQS23ogsfMx++9oHik5jSsk0V9aZXHtDgFP
         w6ZRjqHaXSOO4PdyoLJGupNXBBMB/kvYCt/ztGfRe9kDiXmkWM3JlQ+V1jPGSNMr6LOv
         +EkIQfZBJhOWWzVnVf+zFhSf46hmo8pfFvgyDh7UqFKK4g51y76OpR6l6Wnb9VjgyMpe
         Tfg7+BAtn4BhNaFR1wV8u/loJc0lGavTwET6OzLUZaBeiiaLdecMNU/0JrhvHY0JBmWL
         g5OF38wak2iO2OZQ6K8h9QqLSePOvQ5arHnLiOzYqGnsH2HnuTlHrOhqntNvkU/XgdBq
         h2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129866; x=1730734666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9v9gt9mdtE62qh7vOT25ST+W1xRqFPgaFplsaFpnNXc=;
        b=fzt0T037FB5tVcKTK/1eiGbFYxRudD1zexJ/G8N/HLupIbjOk3XnelXoEmPNhM56Y/
         BcHa3fP4jVXFP+bNABuQLfgDBuoeg17zNImo347nqcab/8k6epByKYcNOLJ6M8Jwapp2
         hmO4OYIuN5b28aXPwp8IeXJDgHuYyiHFb9Ak4OOCl3RLxmsjWbhvzuF+BUOt9Gr0+FHU
         7RlHS53PVKZ1fkIzpRf/PEdawTvBNU89QIc+JmUs8IMfOmxgg600Q5evufgr/3gBE5Ps
         yNyB/CG6p6vYUnfZcuzLTDU3pt+RfPgqYJ+YyMiEJHBTK/5jP/22ijRWKgqzMobbugYM
         zFug==
X-Forwarded-Encrypted: i=1; AJvYcCWwf15hx/RhuMM+Ewn10QzAfrvgrFPUYURZ8vUmRiznTVofBgr8oy8/51y2yR9mWCGQr+vZyD6QdFdSZmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xq5PC6VdKQkH5QaO3MCbiGTRi+R8nhaSh4PbGAt1RJnIr0Wg
	ORHhK2l8f+xRTp/M19UjdJcFJ/6OMtmRi4DRZPJUr4KVg4z450LIkJ5ZztiShoF3dIC6k6LtVEl
	asxrNcFn2qDFbRoEaOWiGqMDyDWPlNCXal66p
X-Google-Smtp-Source: AGHT+IHdXxCqivLg1AMP20KyLUFcWdCGltzU98sJrvvVOc0F1VKX/KSTjqzISciewTHBwZekL2Kk9qdenhe6f6nJYoM=
X-Received: by 2002:a05:600c:35d3:b0:42c:c401:6d8b with SMTP id
 5b1f17b1804b1-4319ac7832dmr76422435e9.7.1730129866191; Mon, 28 Oct 2024
 08:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
In-Reply-To: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 28 Oct 2024 16:37:34 +0100
Message-ID: <CAH5fLgjdDm3nNvR8g-a6Z8UsSnEDygLJ8i3u63aCrpG5ambQ3A@mail.gmail.com>
Subject: Re: [PATCH] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> The IoMem is backed by ioremap_resource()
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
> The PCI/Platform abstractions are in-flight and can be found at:
>
> https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/io.c               | 11 ++++++
>  rust/kernel/platform.rs         | 88 +++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 100 insertions(+)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 217c776615b9593a2fa921dee130c357dbd96761..90b2d29e7b99f33ceb313b4cc=
7f8232fef5eed17 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -13,6 +13,7 @@
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
>  #include <linux/firmware.h>
> +#include <linux/ioport.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/of_device.h>
> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
> index f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..f708c09c4c87634c56af29ef2=
2ebaa2bf51d82a9 100644
> --- a/rust/helpers/io.c
> +++ b/rust/helpers/io.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <linux/io.h>
> +#include <linux/ioport.h>
>
>  u8 rust_helper_readb(const volatile void __iomem *addr)
>  {
> @@ -89,3 +90,13 @@ void rust_helper_writeq_relaxed(u64 value, volatile vo=
id __iomem *addr)
>         writeq_relaxed(value, addr);
>  }
>  #endif
> +
> +resource_size_t rust_helper_resource_size(struct resource *res)
> +{
> +       return resource_size(res);
> +}
> +
> +void __iomem *rust_helper_ioremap(resource_size_t addr, unsigned long si=
ze)
> +{
> +       return ioremap(addr, size);
> +}
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index addf5356f44f3cf233503aed97f1aa0d32f4f062..d152432c80a4499ead30ddaeb=
e8d87a9679bfa97 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -4,11 +4,15 @@
>  //!
>  //! C header: [`include/linux/platform_device.h`](srctree/include/linux/=
platform_device.h)
>
> +use core::ops::Deref;
> +
>  use crate::{
>      bindings, container_of, device,
>      device_id::RawDeviceId,
> +    devres::Devres,
>      driver,
>      error::{to_result, Result},
> +    io::Io,
>      of,
>      prelude::*,
>      str::CStr,
> @@ -208,6 +212,49 @@ fn as_raw(&self) -> *mut bindings::platform_device {
>          // embedded in `struct platform_device`.
>          unsafe { container_of!(self.0.as_raw(), bindings::platform_devic=
e, dev) }.cast_mut()
>      }
> +
> +    /// Maps a platform resource through ioremap() where the size is kno=
wn at
> +    /// compile time.
> +    pub fn ioremap_resource_sized<const SIZE: usize>(
> +        &self,
> +        resource: u32,
> +    ) -> Result<Devres<IoMem<SIZE>>> {
> +        let res =3D self.resource(resource)?;
> +        let size =3D self.resource_len(resource)? as usize;

You're calling platform_get_resource twice here? Can you be sure that
it returns the same pointer each time?

> +        // SAFETY: `res` is guaranteed to be a valid MMIO address and th=
e size
> +        // is given by the kernel as per `self.resource_len()`.
> +        let io =3D unsafe { IoMem::new(res as _, size) }?;

Why do we know that `res` is a valid MMIO address? Is it because
platform_get_resource always does so?

> +        let devres =3D Devres::new(self.as_ref(), io, GFP_KERNEL)?;
> +
> +        Ok(devres)
> +    }
> +
> +    /// Maps a platform resource through ioremap().
> +    pub fn ioremap_resource(&self, resource: u32) -> Result<Devres<IoMem=
>> {
> +        self.ioremap_resource_sized::<0>(resource)
> +    }

I guess size zero is special?

> +    /// Returns the resource len for `resource`, if it exists.
> +    pub fn resource_len(&self, resource: u32) -> Result<bindings::resour=
ce_size_t> {

Should this just return usize? Should we have a type alias for this size ty=
pe?

> +        match self.resource(resource) {
> +            // SAFETY: if a struct resource* is returned by the kernel, =
it is valid.
> +            Ok(resource) =3D> Ok(unsafe { bindings::resource_size(resour=
ce) }),
> +            Err(e) =3D> Err(e),
> +        }
> +    }
> +
> +    fn resource(&self, resource: u32) -> Result<*mut bindings::resource>=
 {
> +        // SAFETY: By the type invariants, we know that `self.ptr` is no=
n-null and valid.
> +        let resource =3D unsafe {
> +            bindings::platform_get_resource(self.as_raw(), bindings::IOR=
ESOURCE_MEM, resource)
> +        };
> +        if !resource.is_null() {
> +            Ok(resource)
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
>  }
>
>  impl AsRef<device::Device> for Device {
> @@ -215,3 +262,44 @@ fn as_ref(&self) -> &device::Device {
>          &self.0
>      }
>  }
> +
> +/// A I/O-mapped memory region for platform devices.
> +///
> +/// See also [`kernel::pci::Bar`].
> +pub struct IoMem<const SIZE: usize =3D 0>(Io<SIZE>);
> +
> +impl<const SIZE: usize> IoMem<SIZE> {
> +    /// Creates a new `IoMem` instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must make sure that `paddr` is a valid MMIO address.
> +    unsafe fn new(paddr: usize, size: usize) -> Result<Self> {

What happens if `size !=3D SIZE`?

> +        // SAFETY: the safety requirements assert that `paddr` is a vali=
d MMIO address.
> +        let addr =3D unsafe { bindings::ioremap(paddr as _, size as u64)=
 };
> +        if addr.is_null() {
> +            return Err(ENOMEM);
> +        }
> +
> +        // SAFETY: `addr` is guaranteed to be the start of a valid I/O m=
apped memory region of
> +        // size `size`.
> +        let io =3D unsafe { Io::new(addr as _, size)? };
> +
> +        Ok(IoMem(io))
> +    }
> +}
> +
> +impl<const SIZE: usize> Drop for IoMem<SIZE> {
> +    fn drop(&mut self) {
> +        // SAFETY: Safe as by the invariant of `Io`.
> +        unsafe { bindings::iounmap(self.0.base_addr() as _) };
> +    }
> +}
> +
> +impl<const SIZE: usize> Deref for IoMem<SIZE> {
> +    type Target =3D Io<SIZE>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0
> +    }
> +}
>
> ---
> base-commit: 2a5c159f49a5801603af03510c7cef89ff4c9850
> change-id: 20241023-topic-panthor-rs-platform_io_support-f97aeb2ea887
>
> Best regards,
> --
> Daniel Almeida <daniel.almeida@collabora.com>
>

