Return-Path: <linux-kernel+bounces-422800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334119D9E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C74B26A14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40591DEFE1;
	Tue, 26 Nov 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+9aP1L7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32041DE8AC;
	Tue, 26 Nov 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652006; cv=none; b=Od95X+yll5aaSxRNwsqQPiHL+JscpWKsSSyOAE052UmNUwYlDAhcI5JoHXI1Nrg/dloKq03JVKkuHDy8L7Y9efEzEV7qiNKXEZW/JZgw+IQ7ps90L03UPB6LxWIgcV0SQa6BVBpZi2XbS7+vR3TsXB++A1HT6XvpeuhqIiwIRGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652006; c=relaxed/simple;
	bh=hBCAGSh/GTO7YPJZesmSdKePWh/p6hZ+RR31auNoFak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHb7Rt7e9fqNEKTVBqG4ePBi/f+GjdHiOhYJqkwRrzgxrTmu03y45Cb01OLrENesKIChFY4A7jruQBxXeJ+XM6+M/Clv42WuA+1BKXzO9/efraOtPRnpfu1GAjcoRTMAee4N37kDjy01zgFqvruNd7HCjNSjvJrb3CzRxnT24hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+9aP1L7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E4AC4CED2;
	Tue, 26 Nov 2024 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732652005;
	bh=hBCAGSh/GTO7YPJZesmSdKePWh/p6hZ+RR31auNoFak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t+9aP1L7+iXyMxoz9sybZsDysh2l5BFT8YQ6/AnL7A1TXP/jFFmXI0YrKWygkQX40
	 FBBt4PuxdwwT7zqq8KZuR/N8S4gd3h4490YxYivJXY1u4XHFEIwQZtGHw6OX9nzoTT
	 CaLS//XUCqGvx/lqOCOXNekwzMo6DYAVI+us8W2KbPOgMiUJsCwDPmf2RUBrA1341M
	 l04m5gwJJ89JzoxHkYcUANxvCE4AVnMxSTgWhcjHAUmTbw24FnSzNrAiIbkvECaX2h
	 Mt49UdlvBAbU3VlfJ5otj5e3H5XZf/Np3JWwAvgujGDPVJi8GDKf5ac0/sXoJJjN6d
	 5SI4YMaknju6Q==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee7a48377cso56853297b3.3;
        Tue, 26 Nov 2024 12:13:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpTogkdiaNZGXe6Sb71KW/BrRaN5Dfc7cpNBQ5krn4w/+OsI0UWZBlqIlZHZdq/9yBSKciDEltlS/GqSE=@vger.kernel.org, AJvYcCW/brJtPGyD5rhrIw/LMjLhReAUR6gyTk57Bd52CRMrc34G4oRTrTUeZ9WIqm9tsXHdgojVj1rP1r5itURZBJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34B8sah/pnjdRYgTg2fXSydXRwYYxvFRZFq5CHSoPHrRA8wiV
	KMnzeVYpDGD3ryxRr3G6DDtVUlkLRcMgx0ejGPsEFbNUcmxyafa7uA/HHhQrVcbQudqiYswQahP
	w6y545Wk3cNMyTnuH4CnfDpxvpg==
X-Google-Smtp-Source: AGHT+IGzBKF2OeO+QM96FPK5/GlaZG0EN18KlbXk1B1dltQNNb7sfQQy60c63CNZxh85odVARWYVwGNbzggkVIaSFg4=
X-Received: by 2002:a05:690c:9b13:b0:6ee:be5d:1a33 with SMTP id
 00721157ae682-6ef3728bca1mr6565397b3.39.1732652004389; Tue, 26 Nov 2024
 12:13:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-topic-panthor-rs-platform_io_support-v2-1-0dea1edc3a49@collabora.com>
In-Reply-To: <20241113-topic-panthor-rs-platform_io_support-v2-1-0dea1edc3a49@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Nov 2024 14:13:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfUNdS+iPMfb6is9hA-U-CD+4iG2LYuk7=p8eVH5CoMw@mail.gmail.com>
Message-ID: <CAL_JsqKfUNdS+iPMfb6is9hA-U-CD+4iG2LYuk7=p8eVH5CoMw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:32=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Add support for iomem regions by providing a struct IoMem abstraction
> for the platform bus. This will request a memory region and remap it
> into a kernel virtual address using ioremap(). The underlying reads and
> writes are performed by struct Io, which is itself embedded in Iomem.
> This is the equivalent of pci::Bar for the platform bus.
>
> Memory-mapped I/O devices are common, and this patch offers a way to
> program them in Rust, usually by reading and writing to their
> memory-mapped register set.
>
> Both sized and unsized versions are exposed. Sized allocations use
> `ioremap_resource_sized` and specify their size at compile time. Reading
> and writing to IoMem is infallible in this case and no extra runtime
> checks are performed. Unsized allocations have to check the offset
> against the regions's max length at runtime and so return Result.
>
> Lastly, like pci::Bar, platform::IoMem uses the Devres abstraction to
> revoke access to the region if the device is unbound or the underlying
> resource goes out of scope.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
> This series depend on the v3 of PCI/Platform abstractions
>
> The PCI/Platform abstractions are in-flight and can be found at:
>
> https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
> ---
> Changes in v2:
> - reworked the commit message
> - added missing request_mem_region call (Thanks Alice, Danilo)
> - IoMem::new() now takes the platform::Device, the resource number and
>   the name, instead of an address and a size (thanks, Danilo)
> - Added a new example for both sized and unsized versions of IoMem.
> - Compiled the examples using kunit.py (thanks for the tip, Alice!)
> - Removed instances of `foo as _`. All `as` casts now spell out the actua=
l
>   type.
> - Now compiling with CLIPPY=3D1 (I realized I had forgotten, sorry)
> - Rebased on top of rust-next to check for any warnings given the new
>   unsafe lints.
> - Link to v1: https://lore.kernel.org/r/20241024-topic-panthor-rs-platfor=
m_io_support-v1-1-3d1addd96e30@collabora.com
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/io.c               |  22 ++++++
>  rust/kernel/platform.rs         | 149 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 172 insertions(+)
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
> index f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..0d31552d5f90e69b8132725a9=
58813d4ab8bd9fa 100644
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
> @@ -89,3 +90,24 @@ void rust_helper_writeq_relaxed(u64 value, volatile vo=
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
> +
> +struct resource *rust_helper_request_mem_region(resource_size_t start, r=
esource_size_t n,
> +                                   const char *name)
> +{
> +       return request_mem_region(start, n, name);
> +}
> +
> +void rust_helper_release_mem_region(resource_size_t start, resource_size=
_t n)
> +{
> +       release_mem_region(start, n);
> +}
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index addf5356f44f3cf233503aed97f1aa0d32f4f062..a6e676e0b983fea2dc2090563=
a138b1cc365a97d 100644
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
> @@ -208,6 +212,47 @@ fn as_raw(&self) -> *mut bindings::platform_device {
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
> +        num: u32,
> +        name: &CStr,
> +    ) -> Result<Devres<IoMem<SIZE>>> {
> +        // SAFETY: `res` is guaranteed to be a valid MMIO address and th=
e size
> +        // is given by the kernel as per `self.resource_len()`.
> +        let io =3D unsafe { IoMem::new(self, num, name) }?;
> +        let devres =3D Devres::new(self.as_ref(), io, GFP_KERNEL)?;
> +
> +        Ok(devres)
> +    }
> +
> +    /// Maps a platform resource through ioremap().
> +    pub fn ioremap_resource(&self, resource: u32, name: &CStr) -> Result=
<Devres<IoMem>> {

For DT, a resource is retrieved by index or name (matching
'reg-names'). Both ways are equally used. That's not how you are using
name here, but I think you should. I think both name and resource
should be optional (but one must be present).

> +        self.ioremap_resource_sized::<0>(resource, name)
> +    }
> +
> +    /// Returns the resource len for `resource`, if it exists.
> +    pub fn resource_len(&self, resource: u32) -> Result<bindings::resour=
ce_size_t> {
> +        match self.resource(resource) {
> +            // SAFETY: if a struct resource* is returned by the kernel, =
it is valid.
> +            Ok(resource) =3D> Ok(unsafe { bindings::resource_size(resour=
ce) }),
> +            Err(e) =3D> Err(e),
> +        }
> +    }
> +
> +    pub(crate) fn resource(&self, resource: u32) -> Result<*mut bindings=
::resource> {
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
> @@ -215,3 +260,107 @@ fn as_ref(&self) -> &device::Device {
>          &self.0
>      }
>  }
> +
> +/// A I/O-mapped memory region for platform devices.
> +///
> +/// See also [`kernel::pci::Bar`].
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{bindings, c_str, platform};
> +///
> +/// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
> +///     let offset =3D 42; // Some offset.
> +///
> +///     // If the size is known at compile time, use `ioremap_resource_s=
ized`.
> +///     // No runtime checks will apply when reading and writing.
> +///     let iomem =3D pdev.ioremap_resource_sized::<42>(0, c_str!("my-de=
vice"))?;

"my-device" is just some made up name. I think we want this to be
either a firmware defined name or nothing. We don't need driver
authors making up more names (they already make up the firmware names
when they are present).

> +///
> +///     // Read and write a 32-bit value at `offset`. Calling `try_acces=
s()` on
> +///     // the `Devres` makes sure that the resource is still valid.
> +///     let data =3D iomem.try_access().ok_or(ENODEV)?.readl(offset);

Shouldn't this fail? If the size is 42 bytes, then reading from offset
42 is out of bounds. It is also unaligned which wouldn't work on some
architectures (Arm).

> +///
> +///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
> +///
> +///     // Unlike `ioremap_resource_sized`, here the size of the memory =
region
> +///     // is not known at compile time, so only the `try_read*` and `tr=
y_write*`
> +///     // family of functions are exposed, leading to runtime checks on=
 every
> +///     // access.
> +///     let iomem =3D pdev.ioremap_resource(0, c_str!("my-device"))?;
> +///
> +///     let data =3D iomem.try_access().ok_or(ENODEV)?.try_readl(offset)=
?;
> +///
> +///     iomem.try_access().ok_or(ENODEV)?.try_writel(data, offset)?;
> +///
> +///     # Ok::<(), Error>(())
> +/// }
> +/// ```
> +///
> +pub struct IoMem<const SIZE: usize =3D 0>(Io<SIZE>);
> +
> +impl<const SIZE: usize> IoMem<SIZE> {
> +    /// Creates a new `IoMem` instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must make sure that `paddr` is a valid MMIO address.

How is that possible? The address comes from firmware and could be
complete garbage.

> +    unsafe fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> =
{
> +        let size =3D pdev.resource_len(num)?;
> +        if size =3D=3D 0 {
> +            return Err(ENOMEM);
> +        }
> +
> +        let res =3D pdev.resource(num)?;
> +
> +        // SAFETY: `res` is guaranteed to be a valid pointer to a `struc=
t
> +        // resource` as per the semantics of `bindings::platform_get_res=
ource()`
> +        let res_start =3D unsafe { *res }.start;
> +
> +        // SAFETY:
> +        // - `res_start` is guaranteed to be a valid MMIO address.
> +        // - `size` is known not to be zero at this point.
> +        // - `name` is a valid C string.
> +        let mem_region =3D
> +            unsafe { bindings::request_mem_region(res_start, size, name.=
as_char_ptr()) };

This will fail on some DT systems. I can't tell you which ones though
as that information was passed down to me on stone tablets. The
problem is there can be 2 nodes with the same addresses and the 2nd
request will fail. That is discouraged, but there are no tools to find
and detect this. That said, the combination of nodes with duplicate
addresses and a rust driver may be rare enough we can just ignore that
problem. OTOH, many, many drivers just don't ever call
request_mem_region().

I would just use res->name for the name here. For DT, that's either
the 'reg-names' value or the node name.

Rob

