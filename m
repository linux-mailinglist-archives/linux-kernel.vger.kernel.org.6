Return-Path: <linux-kernel+bounces-442105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7CE9ED80D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36B2188B917
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30820B20A;
	Wed, 11 Dec 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="D5Vi2q56"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B81C4A1B;
	Wed, 11 Dec 2024 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950872; cv=pass; b=JjIbsXExoPCmAs3o+0mtlYqo7lbW+NSupT/N4KxwXPtvB2EoJWxsZEreRmaugxnIMxalEqYYjW4kD8TuW4H3EYzl2PBCYMqc3PFa8GtRJMtNniXAF0FYFHSWcJtOtzHMpdfG3GaPHT/J6tfTgiaKxGQ4jldcCSZHzRiWiq2JKOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950872; c=relaxed/simple;
	bh=tCmbrHLs6U6Trc0VtAPJxYbBPYPC2G7PQuZXZMYUiiU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GpiPWXniLwdJJHrJuilRr8mDXFuEYQRYkEdxGZN4z02jvt9v/DlWB0z/1J+IZY/MHLIeT2vPek/3Qi8ijjEym+W2ICN7/ZPCa7rA2j0V4a3JlvH7GbUCk6qWUVeqYi4dwFcOHDKu87b62FwlH5pG2lkvxrvB8Nipy+JjBs1hNqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=D5Vi2q56; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733950850; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cZl6YVqAqsPfXUL9xhvrCXniBMIdugVsIO3tMieAjVciAxKzsAcBya/qLingaWBtL8NlV8cGlNJdvnslbqAkth2sWItb0avo0OdextLF/YGrX3YqlOdYqBjfbDEbiAB59bp30QVVkjTS+EmRES4bQZOy1HwoTEC9N3hXpKvEj0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733950850; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RD0JAeo5poJFnTelNRhCFHmC8/M2ro2IwQ0m+Pnvcus=; 
	b=V7yoUkB2L2V1FXnch1Z1BQHOL3LhI80ke2JW/7Sq5pPpH8R/Yc7cfRuxKuJ7FfMtEfh3AkemyAiY2pjpbEdgx4JbByl7abYCB/eB4kVNXe5CTyacjD4zfM7i/m7C28R9WrtDnkpM1ax8Ei3hfew0L3qHio9IXZo0KL3b9Io01MY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733950850;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=RD0JAeo5poJFnTelNRhCFHmC8/M2ro2IwQ0m+Pnvcus=;
	b=D5Vi2q56q1sE3CwjxoDz4VLaIx8kVYYZzOO0OHef2njr0+1U/t7NqSWXPGLzyw1a
	n4QKl0mVudU+C92HYbvFAhS7P40o42nAmdO7RjNq4hT7PjYedYoKKPvh9dCNMRU5C4Z
	HbzturOdPKIMrFs0wyNNlCC26Hh5WlfuWfY2Xyag=
Received: by mx.zohomail.com with SMTPS id 1733950847553911.3060257849828;
	Wed, 11 Dec 2024 13:00:47 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3] rust: platform: add Io support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <Z1nbsNyOBvFTL1-6@pollux.localdomain>
Date: Wed, 11 Dec 2024 18:00:31 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3F6B6C6-33B3-4522-8240-15421F240D3A@collabora.com>
References: <20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com>
 <Z1nbsNyOBvFTL1-6@pollux.localdomain>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Danilo,

> On 11 Dec 2024, at 15:36, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Wed, Dec 11, 2024 at 02:51:56PM -0300, Daniel Almeida wrote:
>> Add support for iomem regions by providing a struct IoMem abstraction
>> for the platform bus. This will request a memory region and remap it
>> into a kernel virtual address using ioremap(). The underlying reads =
and
>> writes are performed by struct Io, which can be derived from the =
IoRaw
>> embedded in platform::IoMem.
>>=20
>> This is the equivalent of pci::Bar for the platform bus.
>>=20
>> Memory-mapped I/O devices are common, and this patch offers a way to
>> program them in Rust, usually by reading and writing to their
>> memory-mapped register set.
>>=20
>> Both sized and unsized versions are exposed. Sized allocations use
>> `ioremap_resource_sized` and specify their size at compile time. =
Reading
>> and writing to IoMem is infallible in this case and no extra runtime
>> checks are performed. Unsized allocations have to check the offset
>> against the regions's max length at runtime and so return Result.
>>=20
>> Lastly, like pci::Bar, platform::IoMem uses the Devres abstraction to
>> revoke access to the region if the device is unbound or the =
underlying
>> resource goes out of scope.
>>=20
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> ---
>> The PCI/Platform abstractions are in-flight and can be found at:
>>=20
>> =
https://lore.kernel.org/rust-for-linux/20241210224947.23804-1-dakr@kernel.=
org/
>> ---
>> Changes in v3:
>> - Rebased on top of v5 for the PCI/Platform abstractions
>> - platform_get_resource is now called only once when calling ioremap
>> - Introduced a platform::Resource type, which is bound to the =
lifetime of the
>>  platform Device=20
>> - Allow retrieving resources from the platform device either by index =
or
>>  name
>> - Make request_mem_region() optional
>> - Use resource.name() in request_mem_region
>> - Reword the example to remove an unaligned, out-of-bounds offset
>> - Update the safety requirements of platform::IoMem
>>=20
>> Changes in v2:
>> - reworked the commit message
>> - added missing request_mem_region call (Thanks Alice, Danilo)
>> - IoMem::new() now takes the platform::Device, the resource number =
and
>>  the name, instead of an address and a size (thanks, Danilo)
>> - Added a new example for both sized and unsized versions of IoMem.
>> - Compiled the examples using kunit.py (thanks for the tip, Alice!)
>> - Removed instances of `foo as _`. All `as` casts now spell out the =
actual
>>  type.
>> - Now compiling with CLIPPY=3D1 (I realized I had forgotten, sorry)
>> - Rebased on top of rust-next to check for any warnings given the new
>>  unsafe lints.
>> ---
>> rust/bindings/bindings_helper.h |   1 +
>> rust/helpers/io.c               |  17 ++++
>> rust/kernel/platform.rs         | 209 =
+++++++++++++++++++++++++++++++++++++++-
>> 3 files changed, 226 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
>> index =
43f5c381aab0e71051402188ee001aac087dbbca..dd272a8e940a72036b0bf0602e090b3f=
f9c6baf1 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -21,6 +21,7 @@
>> #include <linux/file.h>
>> #include <linux/firmware.h>
>> #include <linux/fs.h>
>> +#include <linux/ioport.h>
>> #include <linux/jiffies.h>
>> #include <linux/jump_label.h>
>> #include <linux/mdio.h>
>> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
>> index =
1dde6374c0e24f87a73de7b9543bbea8082e22a7..776c71439998119d8c9d14652d070b71=
a902151f 100644
>> --- a/rust/helpers/io.c
>> +++ b/rust/helpers/io.c
>> @@ -1,6 +1,7 @@
>> // SPDX-License-Identifier: GPL-2.0
>>=20
>> #include <linux/io.h>
>> +#include <linux/ioport.h>
>>=20
>> void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
>> {
>> @@ -99,3 +100,19 @@ void rust_helper_writeq_relaxed(u64 value, =
volatile void __iomem *addr)
>> writeq_relaxed(value, addr);
>> }
>> #endif
>> +
>> +resource_size_t rust_helper_resource_size(struct resource *res)
>> +{
>> + return resource_size(res);
>> +}
>> +
>> +struct resource *rust_helper_request_mem_region(resource_size_t =
start, resource_size_t n,
>> +     const char *name)
>> +{
>> + return request_mem_region(start, n, name);
>> +}
>> +
>> +void rust_helper_release_mem_region(resource_size_t start, =
resource_size_t n)
>> +{
>> + release_mem_region(start, n);
>> +}
>> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
>> index =
a9b7e52591171309c4177bed830fdf2ecf16e518..8fd0a47f097c5822c4e6c40ef75b22c8=
c60db9c4 100644
>> --- a/rust/kernel/platform.rs
>> +++ b/rust/kernel/platform.rs
>> @@ -4,9 +4,14 @@
>> //!
>> //! C header: =
[`include/linux/platform_device.h`](srctree/include/linux/platform_device.=
h)
>>=20
>> +use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
>> +
>> use crate::{
>> -    bindings, container_of, device, driver,
>> +    bindings, container_of, device,
>> +    devres::Devres,
>> +    driver,
>>     error::{to_result, Result},
>> +    io::{Io, IoRaw},
>>     of,
>>     prelude::*,
>>     str::CStr,
>> @@ -184,6 +189,60 @@ fn as_raw(&self) -> *mut =
bindings::platform_device {
>>         // embedded in `struct platform_device`.
>>         unsafe { container_of!(self.0.as_raw(), =
bindings::platform_device, dev) }.cast_mut()
>>     }
>> +
>> +    /// Maps a platform resource through ioremap() where the size is =
known at
>> +    /// compile time.
>> +    pub fn ioremap_resource_sized<const SIZE: usize>(
>> +        &self,
>> +        resource: &Resource<'_>,
>> +        exclusive: bool,
>> +    ) -> Result<Devres<IoMem<SIZE>>> {
>> +        // SAFETY: We wrap the resulting `IoMem` in a `Devres`.
>> +        let io =3D unsafe { IoMem::new(resource, exclusive) }?;
>> +        let devres =3D Devres::new(self.as_ref(), io, GFP_KERNEL)?;
>> +
>> +        Ok(devres)
>> +    }
>> +
>> +    /// Maps a platform resource through ioremap().
>> +    pub fn ioremap_resource(
>> +        &self,
>> +        resource: &Resource<'_>,
>> +        exclusive: bool,
>> +    ) -> Result<Devres<IoMem>> {
>> +        self.ioremap_resource_sized::<0>(resource, exclusive)
>> +    }
>> +
>> +    /// Returns the resource at `index`, if any.
>> +    pub fn resource(&self, index: u32) -> Option<Resource<'_>> {
>> +        // SAFETY: `self.as_raw()` returns a valid pointer to a =
`struct platform_device`.
>> +        let resource =3D unsafe {
>> +            bindings::platform_get_resource(self.as_raw(), =
bindings::IORESOURCE_MEM, index)
>> +        };
>> +
>> +        Some(Resource {
>> +            inner: NonNull::new(resource)?,
>> +            _phantom: PhantomData,
>> +        })
>> +    }
>> +
>> +    /// Returns the resource with a given `name`, if any.
>> +    pub fn resource_by_name(&self, name: &CStr) -> =
Option<Resource<'_>> {
>> +        // SAFETY: `self.as_raw()` returns a valid pointer to a =
`struct
>> +        // platform_device` and `name` points to a valid C string.
>> +        let resource =3D unsafe {
>> +            bindings::platform_get_resource_byname(
>> +                self.as_raw(),
>> +                bindings::IORESOURCE_MEM,
>> +                name.as_char_ptr(),
>> +            )
>> +        };
>> +
>> +        Some(Resource {
>> +            inner: NonNull::new(resource)?,
>> +            _phantom: PhantomData,
>> +        })
>> +    }
>> }
>>=20
>> impl AsRef<device::Device> for Device {
>> @@ -191,3 +250,151 @@ fn as_ref(&self) -> &device::Device {
>>         &self.0
>>     }
>> }
>> +
>> +/// A resource associated to a given platform device.
>> +///
>> +/// # Invariants
>> +///
>> +/// `inner` is a valid pointer to a `struct resource` retrieved from =
a `struct
>> +/// platform_device`.
>> +pub struct Resource<'a> {
>> +    inner: NonNull<bindings::resource>,
>> +    _phantom: PhantomData<&'a bindings::resource>,
>> +}
>> +
>> +impl<'a> Resource<'a> {
>> +    /// Returns the size of the resource.
>> +    pub fn size(&self) -> bindings::resource_size_t {
>> +        // SAFETY: safe as per the invariants of `Resource`
>> +        unsafe { bindings::resource_size(self.inner.as_ptr()) }
>> +    }
>> +
>> +    /// Returns the start address of the resource.
>> +    pub fn start(&self) -> u64 {
>> +        let inner =3D self.inner.as_ptr();
>> +        // SAFETY: safe as per the invariants of `Resource`
>> +        unsafe { *inner }.start
>> +    }
>> +
>> +    /// Returns the name of the resource.
>> +    pub fn name(&self) -> &CStr {
>> +        let inner =3D self.inner.as_ptr();
>> +        // SAFETY: safe as per the invariants of `Resource`
>> +        unsafe { CStr::from_char_ptr((*inner).name) }
>> +    }
>> +}
>> +
>> +/// A I/O-mapped memory region for platform devices.
>> +///
>> +/// See also [`kernel::pci::Bar`].
>> +///
>> +/// # Examples
>> +///
>> +/// ```no_run
>> +/// # use kernel::{bindings, c_str, platform};
>> +///
>> +/// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
>> +///     let offset =3D 0; // Some offset.
>> +///
>> +///     // If the size is known at compile time, use =
`ioremap_resource_sized`.
>> +///     // No runtime checks will apply when reading and writing.
>> +///     let iomem =3D pdev.ioremap_resource_sized::<42>(0, None)?;
>=20
> This doesn't seem to match the API introduced by this patch. I assume =
you forgot
> to update the example code?

Yes.

>=20
>> +///
>> +///     // Read and write a 32-bit value at `offset`. Calling =
`try_access()` on
>> +///     // the `Devres` makes sure that the resource is still valid.
>> +///     let data =3D =
iomem.try_access().ok_or(ENODEV)?.readl(offset);
>> +///
>> +///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
>> +///
>> +///     // Unlike `ioremap_resource_sized`, here the size of the =
memory region
>> +///     // is not known at compile time, so only the `try_read*` and =
`try_write*`
>> +///     // family of functions are exposed, leading to runtime =
checks on every
>> +///     // access.
>> +///     let iomem =3D pdev.ioremap_resource(0, None)?;
>> +///
>> +///     let data =3D =
iomem.try_access().ok_or(ENODEV)?.try_readl(offset)?;
>> +///
>> +///     iomem.try_access().ok_or(ENODEV)?.try_writel(data, offset)?;
>> +///
>> +///     # Ok::<(), Error>(())
>> +/// }
>> +/// ```
>> +///
>> +pub struct IoMem<const SIZE: usize =3D 0> {
>> +    io: IoRaw<SIZE>,
>> +    res_start: u64,
>> +    exclusive: bool,
>> +}
>=20
> I think both the `Resource` and `IoMem` implementation do not belong =
into
> platform.rs. Neither of those depends on any platform bus structures. =
They're
> only used by platform structures.
>=20
> I think we should move this into files under rust/kernel/io/ and =
create separate
> commits out of this one.

Just to be clear, one commit with the boilerplate to create =
rust/kernel/io, and another one with
kernel::io::Resource and kernel::io::IoMem?

>=20
>> +
>> +impl<const SIZE: usize> IoMem<SIZE> {
>> +    /// Creates a new `IoMem` instance.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `IoMem` does not outlive the =
device it is
>> +    /// associated with, usually by wrapping the `IoMem` in a =
`Devres`.
>=20
> More precisely, `Devres` revokes when the device is unbound from the =
matched
> driver, i.e. the driver should not be able to control the device =
anymore. This
> may be much earlier than when the device disappears.
>=20
>> +    unsafe fn new(resource: &Resource<'_>, exclusive: bool) -> =
Result<Self> {
>> +        let size =3D resource.size();
>> +        if size =3D=3D 0 {
>> +            return Err(ENOMEM);
>> +        }
>> +
>> +        let res_start =3D resource.start();
>> +
>> +        // SAFETY:
>> +        // - `res_start` and `size` are read from a presumably valid =
`struct resource`.
>> +        // - `size` is known not to be zero at this point.
>> +        // - `resource.name()` returns a valid C string.
>> +        let mem_region =3D
>> +            unsafe { bindings::request_mem_region(res_start, size, =
resource.name().as_char_ptr()) };
>=20
> This should only be called if exclusive =3D=3D true, right?

Yes (oops)

>=20
> Btw. what's the use-case for non-exclusive access? Shouldn't we rather =
support
> partial exclusive mappings?

Rob pointed out that lots of drivers do not call `request_mem_region` in =
his review for v2, which
Is why I added support for non-exclusive access.

What do you mean by `partial exclusive mappings` ?

>=20
>> +
>> +        if mem_region.is_null() {
>> +            return Err(EBUSY);
>> +        }
>> +
>> +        // SAFETY:
>> +        // - `res_start` and `size` are read from a presumably valid =
`struct resource`.
>> +        // - `size` is known not to be zero at this point.
>> +        let addr =3D unsafe { bindings::ioremap(res_start, size as =
usize) };
>> +        if addr.is_null() {
>> +            if exclusive {
>> +                // SAFETY:
>> +                // - `res_start` and `size` are read from a =
presumably valid `struct resource`.
>> +                // - `size` is the same as the one passed to =
`request_mem_region`.
>> +                unsafe { bindings::release_mem_region(res_start, =
size) };
>> +            }
>> +            return Err(ENOMEM);
>> +        }
>> +
>> +        let io =3D IoRaw::new(addr as usize, size as usize)?;
>> +
>> +        Ok(IoMem {
>> +            io,
>> +            res_start,
>> +            exclusive,
>> +        })
>> +    }
>> +}
>> +
>> +impl<const SIZE: usize> Drop for IoMem<SIZE> {
>> +    fn drop(&mut self) {
>> +        if self.exclusive {
>> +            // SAFETY: `res_start` and `io.maxsize()` were the =
values passed to
>> +            // `request_mem_region`.
>> +            unsafe { bindings::release_mem_region(self.res_start, =
self.io.maxsize() as u64) }
>> +        }
>> +
>> +        // SAFETY: Safe as by the invariant of `Io`.
>> +        unsafe { bindings::iounmap(self.io.addr() as *mut =
core::ffi::c_void) }
>> +    }
>> +}
>> +
>> +impl<const SIZE: usize> Deref for IoMem<SIZE> {
>> +    type Target =3D Io<SIZE>;
>> +
>> +    fn deref(&self) -> &Self::Target {
>> +        // SAFETY: `addr` is guaranteed to be the start of a valid =
I/O mapped memory region of
>> +        // size `maxsize` given the initialization in `Self::new`.
>=20
> I think it'd be cleaner to have this as an invariant section in the
> documentation of `IoMem` and then refer to that.
>=20
>> +        unsafe { Io::from_raw(&self.io) }
>> +    }
>> +}
>>=20
>> ---
>> base-commit: 1a4ce3837e321b94db1ac4274160e449c462610b
>> change-id: 20241211-topic-panthor-rs-platform_io_support-ae8ac7feca5d
>> prerequisite-message-id: <20241210224947.23804-1-dakr@kernel.org>
>> prerequisite-patch-id: 9721d6d91aaa327a64db90153ac973c39d328fcf
>> prerequisite-patch-id: 678dbd0e4ef70c658ad7d6def3e1fad82ded9657
>> prerequisite-patch-id: ea80287941ef43f59fa75a28e6798ff10c8e90c1
>> prerequisite-patch-id: e922cfa34c5e15c904fd12a08de5a5897915dc96
>> prerequisite-patch-id: cd9756c9586f394e5b39198497979aa1384ad2b8
>> prerequisite-patch-id: 313083700e67eab809a6b673d1fd835a6bd18625
>> prerequisite-patch-id: d0c7198d84ffa229221bbe06541136c97e8aae4e
>> prerequisite-patch-id: 0c4e157879b92f366feca2e89b5719e0a9bfa36a
>> prerequisite-patch-id: 515464a50ad216e2e9811043db8ca341262db288
>> prerequisite-patch-id: c50da45a4d7e62930f78b854f9afc636120dc255
>> prerequisite-patch-id: 5e32316afbfed41fe68cc096bf5a93201d0c65f9
>> prerequisite-patch-id: 15b08041af5e8f50619e3098b01ac0c0c0357751
>> prerequisite-patch-id: d680798b48f799b02f2a514675133911af7b4228
>> prerequisite-patch-id: 833f8f6310401cec79343ad55376e2f00b5105da
>> prerequisite-patch-id: c7825a4527d051ac9929fa8e8856ec454cc3f703
>> prerequisite-patch-id: ea5c28331c595ad00929291b483c8848f3ff84cf
>>=20
>> Best regards,
>> --=20
>> Daniel Almeida <daniel.almeida@collabora.com>



