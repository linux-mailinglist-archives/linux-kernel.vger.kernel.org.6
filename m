Return-Path: <linux-kernel+bounces-408218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC69C7C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57D11F23198
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEA205AAC;
	Wed, 13 Nov 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="AOkkifRg"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8D180021;
	Wed, 13 Nov 2024 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526331; cv=pass; b=LKriEMnJin5poAa/U1OGfHwi30HGu3tMHvYzF2XaWKf3r1rYIdnD8ZBzFNuAEtmIGTFpH/6Vz+SeQirx2bh59/tQ+P1kR2zil5jbaBwdZ+MWBracT2qpbFjvmPhnv9kJZj3gWoRDZefb3EYUCmdbna1Q0vL7XmQ1jCLvXtd/mJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526331; c=relaxed/simple;
	bh=l8nA+m6xIMYsTJT81nGtcHv7jj7AbNN7ag1S+g8Phq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A4hKFnnbUG/5vQR1O0pKqfsGNJH2ub4J3nWIG50Jhakia5I2hv99iC5nEKQpZHSL00T5hzHPyYu4QFj38DU649ai4G2t4Bcyu2nCvLeHkSQn9Gb8WEzyrNgc/6riWaovLsP603YxRuR7sGjYpi+D/RK5cWO4jvl3WtZrGn710wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=AOkkifRg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731526310; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ixP/wm+BVtxrTdxBjgyiGaUKaac42svixnfrt61gTllbAsO4Jzg0TotSYb6tsDPoOKQZIdtrt1Zz3uPy6oCVpIrrd7BSZqlnxfxyNM/O6v9eokxyW8i+YBXauD3OagF9la+omEdZqrE2p89+WdX1tbg6TtdfO8gsNBh5l2M8IMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731526310; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4eQyGLu4WE//oZaW24rPhPdiPpWXO7ENikiZw8lDlQA=; 
	b=jV04bKLZtCG76wtzGcUUblfytRu5j//XPgeI4dM9da1A087edInDKZ8rxYFwwdwCHrZhIMTSZwgQQ7729bqksa5mVoEPmvF+4boxBNZ+H/k4WynNnurLC6DgHaSNYePV9DKhh57GiEqgx4vxMLY5kBBaEyxlYr47lPngp/5TQZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731526310;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=4eQyGLu4WE//oZaW24rPhPdiPpWXO7ENikiZw8lDlQA=;
	b=AOkkifRgX51iRVTCmtiiTII/zKg9BoF+rnoPypw3b+txxUaPMiuzfO7UoAIAbtQy
	hhpz1OGN7vrl2VdZ+YrOhMsEXbQ2w3LY8ZepUKSNL0FoEnW2xIyPDO17n+tnz7fhJZw
	HOz4TpEErj6d/qrSx70TSs+EUt6FcrlEGhAvXVdk=
Received: by mx.zohomail.com with SMTPS id 173152630836597.63303501095197;
	Wed, 13 Nov 2024 11:31:48 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 13 Nov 2024 16:30:54 -0300
Subject: [PATCH v2] rust: platform: add Io support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-topic-panthor-rs-platform_io_support-v2-1-0dea1edc3a49@collabora.com>
X-B4-Tracking: v=1; b=H4sIAG3+NGcC/43NQQ6CMBCF4auQrq2hhQi48h6GkKEtMgkwzbQSD
 eHuVhL3Lv+3eN8mgmN0QVyzTbBbMSAtKfQpE2aE5eEk2tRC57pUuS5kJI9GeljiSCw5SD9BHIj
 nDqkLT++JoxyaClyvHdR1JdKVZzfg62DubeoRQyR+H+qqvusPKP8DViWVLKwCa21zcUV+MzRN0
 BPD2dAs2n3fPxbZB+LcAAAA
X-Change-ID: 20241023-topic-panthor-rs-platform_io_support-f97aeb2ea887
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Daniel Stone <daniels@collabora.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Add support for iomem regions by providing a struct IoMem abstraction
for the platform bus. This will request a memory region and remap it
into a kernel virtual address using ioremap(). The underlying reads and
writes are performed by struct Io, which is itself embedded in Iomem.
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
This series depend on the v3 of PCI/Platform abstractions

The PCI/Platform abstractions are in-flight and can be found at:

https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
---
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
- Link to v1: https://lore.kernel.org/r/20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/io.c               |  22 ++++++
 rust/kernel/platform.rs         | 149 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 217c776615b9593a2fa921dee130c357dbd96761..90b2d29e7b99f33ceb313b4cc7f8232fef5eed17 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
+#include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/of_device.h>
diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..0d31552d5f90e69b8132725a958813d4ab8bd9fa 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/io.h>
+#include <linux/ioport.h>
 
 u8 rust_helper_readb(const volatile void __iomem *addr)
 {
@@ -89,3 +90,24 @@ void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
 	writeq_relaxed(value, addr);
 }
 #endif
+
+resource_size_t rust_helper_resource_size(struct resource *res)
+{
+	return resource_size(res);
+}
+
+void __iomem *rust_helper_ioremap(resource_size_t addr, unsigned long size)
+{
+	return ioremap(addr, size);
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
index addf5356f44f3cf233503aed97f1aa0d32f4f062..a6e676e0b983fea2dc2090563a138b1cc365a97d 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -4,11 +4,15 @@
 //!
 //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
 
+use core::ops::Deref;
+
 use crate::{
     bindings, container_of, device,
     device_id::RawDeviceId,
+    devres::Devres,
     driver,
     error::{to_result, Result},
+    io::Io,
     of,
     prelude::*,
     str::CStr,
@@ -208,6 +212,47 @@ fn as_raw(&self) -> *mut bindings::platform_device {
         // embedded in `struct platform_device`.
         unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
     }
+
+    /// Maps a platform resource through ioremap() where the size is known at
+    /// compile time.
+    pub fn ioremap_resource_sized<const SIZE: usize>(
+        &self,
+        num: u32,
+        name: &CStr,
+    ) -> Result<Devres<IoMem<SIZE>>> {
+        // SAFETY: `res` is guaranteed to be a valid MMIO address and the size
+        // is given by the kernel as per `self.resource_len()`.
+        let io = unsafe { IoMem::new(self, num, name) }?;
+        let devres = Devres::new(self.as_ref(), io, GFP_KERNEL)?;
+
+        Ok(devres)
+    }
+
+    /// Maps a platform resource through ioremap().
+    pub fn ioremap_resource(&self, resource: u32, name: &CStr) -> Result<Devres<IoMem>> {
+        self.ioremap_resource_sized::<0>(resource, name)
+    }
+
+    /// Returns the resource len for `resource`, if it exists.
+    pub fn resource_len(&self, resource: u32) -> Result<bindings::resource_size_t> {
+        match self.resource(resource) {
+            // SAFETY: if a struct resource* is returned by the kernel, it is valid.
+            Ok(resource) => Ok(unsafe { bindings::resource_size(resource) }),
+            Err(e) => Err(e),
+        }
+    }
+
+    pub(crate) fn resource(&self, resource: u32) -> Result<*mut bindings::resource> {
+        // SAFETY: By the type invariants, we know that `self.ptr` is non-null and valid.
+        let resource = unsafe {
+            bindings::platform_get_resource(self.as_raw(), bindings::IORESOURCE_MEM, resource)
+        };
+        if !resource.is_null() {
+            Ok(resource)
+        } else {
+            Err(EINVAL)
+        }
+    }
 }
 
 impl AsRef<device::Device> for Device {
@@ -215,3 +260,107 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+/// A I/O-mapped memory region for platform devices.
+///
+/// See also [`kernel::pci::Bar`].
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{bindings, c_str, platform};
+///
+/// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
+///     let offset = 42; // Some offset.
+///
+///     // If the size is known at compile time, use `ioremap_resource_sized`.
+///     // No runtime checks will apply when reading and writing.
+///     let iomem = pdev.ioremap_resource_sized::<42>(0, c_str!("my-device"))?;
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
+///     let iomem = pdev.ioremap_resource(0, c_str!("my-device"))?;
+///
+///     let data = iomem.try_access().ok_or(ENODEV)?.try_readl(offset)?;
+///
+///     iomem.try_access().ok_or(ENODEV)?.try_writel(data, offset)?;
+///
+///     # Ok::<(), Error>(())
+/// }
+/// ```
+///
+pub struct IoMem<const SIZE: usize = 0>(Io<SIZE>);
+
+impl<const SIZE: usize> IoMem<SIZE> {
+    /// Creates a new `IoMem` instance.
+    ///
+    /// # Safety
+    ///
+    /// The caller must make sure that `paddr` is a valid MMIO address.
+    unsafe fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
+        let size = pdev.resource_len(num)?;
+        if size == 0 {
+            return Err(ENOMEM);
+        }
+
+        let res = pdev.resource(num)?;
+
+        // SAFETY: `res` is guaranteed to be a valid pointer to a `struct
+        // resource` as per the semantics of `bindings::platform_get_resource()`
+        let res_start = unsafe { *res }.start;
+
+        // SAFETY:
+        // - `res_start` is guaranteed to be a valid MMIO address.
+        // - `size` is known not to be zero at this point.
+        // - `name` is a valid C string.
+        let mem_region =
+            unsafe { bindings::request_mem_region(res_start, size, name.as_char_ptr()) };
+        if mem_region.is_null() {
+            return Err(EBUSY);
+        }
+
+        // SAFETY:
+        // - `res_start` is guaranteed to be a valid MMIO address.
+        // - `size` is known not to be zero at this point.
+        let addr = unsafe { bindings::ioremap(res_start, size) };
+        if addr.is_null() {
+            // SAFETY:
+            // - `res_start` is guaranteed to be a valid MMIO address.
+            // - `size` is the same as the one passed to `request_mem_region`.
+            unsafe { bindings::release_mem_region(res_start, size) };
+            return Err(ENOMEM);
+        }
+
+        // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
+        // size `size`.
+        let io = unsafe { Io::new(addr as usize, size.try_into()?)? };
+
+        Ok(IoMem(io))
+    }
+}
+
+impl<const SIZE: usize> Drop for IoMem<SIZE> {
+    fn drop(&mut self) {
+        // SAFETY: Safe as by the invariant of `Io`.
+        unsafe { bindings::release_mem_region(self.0.base_addr() as u64, self.0.maxsize() as u64) }
+
+        // SAFETY: Safe as by the invariant of `Io`.
+        unsafe { bindings::iounmap(self.0.base_addr() as *mut core::ffi::c_void) }
+    }
+}
+
+impl<const SIZE: usize> Deref for IoMem<SIZE> {
+    type Target = Io<SIZE>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}

---
base-commit: 2a5c159f49a5801603af03510c7cef89ff4c9850
change-id: 20241023-topic-panthor-rs-platform_io_support-f97aeb2ea887

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


