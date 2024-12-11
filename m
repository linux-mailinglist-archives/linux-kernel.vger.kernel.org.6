Return-Path: <linux-kernel+bounces-441789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B809ED418
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786CE28427F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49411FF61A;
	Wed, 11 Dec 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="G+8oGjR8"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A21D9A6F;
	Wed, 11 Dec 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939564; cv=pass; b=q8icCjqNMQA2FxDgreWghJdqU8fLNKLCcoE+ujzG64ctTCu6Re3NxgkVN+6d9yZY8zhasV5azOXtKwCPnZbrgVwO5wrnY7Bwra6/N946AgBGMWi0dPWdtkNvq/GJ1f+S+KvGupP+jAuema0pIrZwRqTvOWW0Vz0J3IxAvuASaB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939564; c=relaxed/simple;
	bh=R9aUNd0GSDSNlH98yw+jGo92aMKr8vePeehE0VgPbk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mw/s+3XMu1W6ftSxsQwuU/62TIAVxxtLvFflyboSOM89AzCSlg2TtdTNPQ/7fRY8KqUBvn+6zgii70g30YGafeU5Mb4CQGXbdOmpc19Igcbq+RYV6cBRvExZV+kDIEpWaGwWGt+WCcPxe16N3Lh10I1zEfFc0LgIXLz1nYULo60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=G+8oGjR8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733939537; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aQCcyQm5J2GkU0VxVxs+HYnb+W97B++99VNDHdeC0tz9mG8oQbWI+S7vQqekHBc6lgGyBmP5K/N/bvb+IS+NYrGjjDSO6/m1xldbic88jv7kyPaOYWWegjcRVN9hWyf6mJvjud8geG3gp4OIh1O0tXrMegBc/QeuDtL9a2r1Who=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733939537; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zhxAe+gI2FNfQGvD8Pf48z98YhtHwz8j1Ol5xfgTFrQ=; 
	b=HcTlZFmcd1XIQQndr9NM4ianQhkWNNA1AG+/KI6wyU+tsWs3milX9RQuGl5GZ7CdrzW26sHaVorFUwaNd82pxQp5RqE7YnuHimDAZSixoeFESAEdCd2BoqgjuHyUUaDBCHuBoLKqGT4VFCFvk1L02DR/SwKwfMCOiqwSlHIzNHo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733939537;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=zhxAe+gI2FNfQGvD8Pf48z98YhtHwz8j1Ol5xfgTFrQ=;
	b=G+8oGjR8Hp8s5htBtRnQpa6eSkU1680ZFI7d11dYsNrnYjwI8SWAKM5ifWGskW1W
	/g0MKAyx5BtipdQRYdE7haFVBRHl60g+5b7rvEns8BOKkbCLPOdyCjrH2WpC9Jmpmru
	FCoEgs9UaLxSTYue2aY4/Qgbz5PVjwL+dqOXE6Fw=
Received: by mx.zohomail.com with SMTPS id 1733939534899566.8869122459076;
	Wed, 11 Dec 2024 09:52:14 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 11 Dec 2024 14:51:56 -0300
Subject: [PATCH v3] rust: platform: add Io support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com>
X-B4-Tracking: v=1; b=H4sIADvRWWcC/y3NQQqDMBCF4atI1h0x0aKVUnqPIhLiqEFN0kksB
 fHuDdrl/xbv25hH0uhZnWyM8KO9tiZGfkmYGqUZEHQXm4lMFFxwDsE6rcBJE0ZLQB7cLENvaWm
 1bf3qnKUAEiupyh6VvHYsXjnCXn8P5tWcTfheoxbOkS3ovTy0Orn/sUyI4laUqcirrAAOnZzoO
 SEZnFNLw4M1+/4Dl1FBTcEAAAA=
X-Change-ID: 20241211-topic-panthor-rs-platform_io_support-ae8ac7feca5d
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Add support for iomem regions by providing a struct IoMem abstraction
for the platform bus. This will request a memory region and remap it
into a kernel virtual address using ioremap(). The underlying reads and
writes are performed by struct Io, which can be derived from the IoRaw
embedded in platform::IoMem.

This is the equivalent of pci::Bar for the platform bus.

Memory-mapped I/O devices are common, and this patch offers a way to
program them in Rust, usually by reading and writing to their
memory-mapped register set.

Both sized and unsized versions are exposed. Sized allocations use
`ioremap_resource_sized` and specify their size at compile time. Reading
and writing to IoMem is infallible in this case and no extra runtime
checks are performed. Unsized allocations have to check the offset
against the regions's max length at runtime and so return Result.

Lastly, like pci::Bar, platform::IoMem uses the Devres abstraction to
revoke access to the region if the device is unbound or the underlying
resource goes out of scope.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
The PCI/Platform abstractions are in-flight and can be found at:

https://lore.kernel.org/rust-for-linux/20241210224947.23804-1-dakr@kernel.org/
---
Changes in v3:
- Rebased on top of v5 for the PCI/Platform abstractions
- platform_get_resource is now called only once when calling ioremap
- Introduced a platform::Resource type, which is bound to the lifetime of the
  platform Device 
- Allow retrieving resources from the platform device either by index or
  name
- Make request_mem_region() optional
- Use resource.name() in request_mem_region
- Reword the example to remove an unaligned, out-of-bounds offset
- Update the safety requirements of platform::IoMem

Changes in v2:
- reworked the commit message
- added missing request_mem_region call (Thanks Alice, Danilo)
- IoMem::new() now takes the platform::Device, the resource number and
  the name, instead of an address and a size (thanks, Danilo)
- Added a new example for both sized and unsized versions of IoMem.
- Compiled the examples using kunit.py (thanks for the tip, Alice!)
- Removed instances of `foo as _`. All `as` casts now spell out the actual
  type.
- Now compiling with CLIPPY=1 (I realized I had forgotten, sorry)
- Rebased on top of rust-next to check for any warnings given the new
  unsafe lints.
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/io.c               |  17 ++++
 rust/kernel/platform.rs         | 209 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 226 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 43f5c381aab0e71051402188ee001aac087dbbca..dd272a8e940a72036b0bf0602e090b3ff9c6baf1 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 1dde6374c0e24f87a73de7b9543bbea8082e22a7..776c71439998119d8c9d14652d070b71a902151f 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/io.h>
+#include <linux/ioport.h>
 
 void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
 {
@@ -99,3 +100,19 @@ void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
 	writeq_relaxed(value, addr);
 }
 #endif
+
+resource_size_t rust_helper_resource_size(struct resource *res)
+{
+	return resource_size(res);
+}
+
+struct resource *rust_helper_request_mem_region(resource_size_t start, resource_size_t n,
+				    const char *name)
+{
+	return request_mem_region(start, n, name);
+}
+
+void rust_helper_release_mem_region(resource_size_t start, resource_size_t n)
+{
+	release_mem_region(start, n);
+}
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index a9b7e52591171309c4177bed830fdf2ecf16e518..8fd0a47f097c5822c4e6c40ef75b22c8c60db9c4 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -4,9 +4,14 @@
 //!
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
+use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
+
 use crate::{
-    bindings, container_of, device, driver,
+    bindings, container_of, device,
+    devres::Devres,
+    driver,
     error::{to_result, Result},
+    io::{Io, IoRaw},
     of,
     prelude::*,
     str::CStr,
@@ -184,6 +189,60 @@ fn as_raw(&self) -> *mut bindings::platform_device {
         // embedded in `struct platform_device`.
         unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
     }
+
+    /// Maps a platform resource through ioremap() where the size is known at
+    /// compile time.
+    pub fn ioremap_resource_sized<const SIZE: usize>(
+        &self,
+        resource: &Resource<'_>,
+        exclusive: bool,
+    ) -> Result<Devres<IoMem<SIZE>>> {
+        // SAFETY: We wrap the resulting `IoMem` in a `Devres`.
+        let io = unsafe { IoMem::new(resource, exclusive) }?;
+        let devres = Devres::new(self.as_ref(), io, GFP_KERNEL)?;
+
+        Ok(devres)
+    }
+
+    /// Maps a platform resource through ioremap().
+    pub fn ioremap_resource(
+        &self,
+        resource: &Resource<'_>,
+        exclusive: bool,
+    ) -> Result<Devres<IoMem>> {
+        self.ioremap_resource_sized::<0>(resource, exclusive)
+    }
+
+    /// Returns the resource at `index`, if any.
+    pub fn resource(&self, index: u32) -> Option<Resource<'_>> {
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct platform_device`.
+        let resource = unsafe {
+            bindings::platform_get_resource(self.as_raw(), bindings::IORESOURCE_MEM, index)
+        };
+
+        Some(Resource {
+            inner: NonNull::new(resource)?,
+            _phantom: PhantomData,
+        })
+    }
+
+    /// Returns the resource with a given `name`, if any.
+    pub fn resource_by_name(&self, name: &CStr) -> Option<Resource<'_>> {
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct
+        // platform_device` and `name` points to a valid C string.
+        let resource = unsafe {
+            bindings::platform_get_resource_byname(
+                self.as_raw(),
+                bindings::IORESOURCE_MEM,
+                name.as_char_ptr(),
+            )
+        };
+
+        Some(Resource {
+            inner: NonNull::new(resource)?,
+            _phantom: PhantomData,
+        })
+    }
 }
 
 impl AsRef<device::Device> for Device {
@@ -191,3 +250,151 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+/// A resource associated to a given platform device.
+///
+/// # Invariants
+///
+/// `inner` is a valid pointer to a `struct resource` retrieved from a `struct
+/// platform_device`.
+pub struct Resource<'a> {
+    inner: NonNull<bindings::resource>,
+    _phantom: PhantomData<&'a bindings::resource>,
+}
+
+impl<'a> Resource<'a> {
+    /// Returns the size of the resource.
+    pub fn size(&self) -> bindings::resource_size_t {
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { bindings::resource_size(self.inner.as_ptr()) }
+    }
+
+    /// Returns the start address of the resource.
+    pub fn start(&self) -> u64 {
+        let inner = self.inner.as_ptr();
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { *inner }.start
+    }
+
+    /// Returns the name of the resource.
+    pub fn name(&self) -> &CStr {
+        let inner = self.inner.as_ptr();
+        // SAFETY: safe as per the invariants of `Resource`
+        unsafe { CStr::from_char_ptr((*inner).name) }
+    }
+}
+
+/// A I/O-mapped memory region for platform devices.
+///
+/// See also [`kernel::pci::Bar`].
+///
+/// # Examples
+///
+/// ```no_run
+/// # use kernel::{bindings, c_str, platform};
+///
+/// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
+///     let offset = 0; // Some offset.
+///
+///     // If the size is known at compile time, use `ioremap_resource_sized`.
+///     // No runtime checks will apply when reading and writing.
+///     let iomem = pdev.ioremap_resource_sized::<42>(0, None)?;
+///
+///     // Read and write a 32-bit value at `offset`. Calling `try_access()` on
+///     // the `Devres` makes sure that the resource is still valid.
+///     let data = iomem.try_access().ok_or(ENODEV)?.readl(offset);
+///
+///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
+///
+///     // Unlike `ioremap_resource_sized`, here the size of the memory region
+///     // is not known at compile time, so only the `try_read*` and `try_write*`
+///     // family of functions are exposed, leading to runtime checks on every
+///     // access.
+///     let iomem = pdev.ioremap_resource(0, None)?;
+///
+///     let data = iomem.try_access().ok_or(ENODEV)?.try_readl(offset)?;
+///
+///     iomem.try_access().ok_or(ENODEV)?.try_writel(data, offset)?;
+///
+///     # Ok::<(), Error>(())
+/// }
+/// ```
+///
+pub struct IoMem<const SIZE: usize = 0> {
+    io: IoRaw<SIZE>,
+    res_start: u64,
+    exclusive: bool,
+}
+
+impl<const SIZE: usize> IoMem<SIZE> {
+    /// Creates a new `IoMem` instance.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `IoMem` does not outlive the device it is
+    /// associated with, usually by wrapping the `IoMem` in a `Devres`.
+    unsafe fn new(resource: &Resource<'_>, exclusive: bool) -> Result<Self> {
+        let size = resource.size();
+        if size == 0 {
+            return Err(ENOMEM);
+        }
+
+        let res_start = resource.start();
+
+        // SAFETY:
+        // - `res_start` and `size` are read from a presumably valid `struct resource`.
+        // - `size` is known not to be zero at this point.
+        // - `resource.name()` returns a valid C string.
+        let mem_region =
+            unsafe { bindings::request_mem_region(res_start, size, resource.name().as_char_ptr()) };
+
+        if mem_region.is_null() {
+            return Err(EBUSY);
+        }
+
+        // SAFETY:
+        // - `res_start` and `size` are read from a presumably valid `struct resource`.
+        // - `size` is known not to be zero at this point.
+        let addr = unsafe { bindings::ioremap(res_start, size as usize) };
+        if addr.is_null() {
+            if exclusive {
+                // SAFETY:
+                // - `res_start` and `size` are read from a presumably valid `struct resource`.
+                // - `size` is the same as the one passed to `request_mem_region`.
+                unsafe { bindings::release_mem_region(res_start, size) };
+            }
+            return Err(ENOMEM);
+        }
+
+        let io = IoRaw::new(addr as usize, size as usize)?;
+
+        Ok(IoMem {
+            io,
+            res_start,
+            exclusive,
+        })
+    }
+}
+
+impl<const SIZE: usize> Drop for IoMem<SIZE> {
+    fn drop(&mut self) {
+        if self.exclusive {
+            // SAFETY: `res_start` and `io.maxsize()` were the values passed to
+            // `request_mem_region`.
+            unsafe { bindings::release_mem_region(self.res_start, self.io.maxsize() as u64) }
+        }
+
+        // SAFETY: Safe as by the invariant of `Io`.
+        unsafe { bindings::iounmap(self.io.addr() as *mut core::ffi::c_void) }
+    }
+}
+
+impl<const SIZE: usize> Deref for IoMem<SIZE> {
+    type Target = Io<SIZE>;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
+        // size `maxsize` given the initialization in `Self::new`.
+        unsafe { Io::from_raw(&self.io) }
+    }
+}

---
base-commit: 1a4ce3837e321b94db1ac4274160e449c462610b
change-id: 20241211-topic-panthor-rs-platform_io_support-ae8ac7feca5d
prerequisite-message-id: <20241210224947.23804-1-dakr@kernel.org>
prerequisite-patch-id: 9721d6d91aaa327a64db90153ac973c39d328fcf
prerequisite-patch-id: 678dbd0e4ef70c658ad7d6def3e1fad82ded9657
prerequisite-patch-id: ea80287941ef43f59fa75a28e6798ff10c8e90c1
prerequisite-patch-id: e922cfa34c5e15c904fd12a08de5a5897915dc96
prerequisite-patch-id: cd9756c9586f394e5b39198497979aa1384ad2b8
prerequisite-patch-id: 313083700e67eab809a6b673d1fd835a6bd18625
prerequisite-patch-id: d0c7198d84ffa229221bbe06541136c97e8aae4e
prerequisite-patch-id: 0c4e157879b92f366feca2e89b5719e0a9bfa36a
prerequisite-patch-id: 515464a50ad216e2e9811043db8ca341262db288
prerequisite-patch-id: c50da45a4d7e62930f78b854f9afc636120dc255
prerequisite-patch-id: 5e32316afbfed41fe68cc096bf5a93201d0c65f9
prerequisite-patch-id: 15b08041af5e8f50619e3098b01ac0c0c0357751
prerequisite-patch-id: d680798b48f799b02f2a514675133911af7b4228
prerequisite-patch-id: 833f8f6310401cec79343ad55376e2f00b5105da
prerequisite-patch-id: c7825a4527d051ac9929fa8e8856ec454cc3f703
prerequisite-patch-id: ea5c28331c595ad00929291b483c8848f3ff84cf

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


