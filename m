Return-Path: <linux-kernel+bounces-380074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36489AE8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7233AB26B32
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1DC200B81;
	Thu, 24 Oct 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="K5V7dOD/"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48691F76AB;
	Thu, 24 Oct 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779660; cv=pass; b=KQ+V9CpLuSFJV96i9afH8WtYAx/5jokcCnId9SzniavIs57mfE4Nq9fbKCix1BE8hOhQdnBCy/Xl1TK6SoFB+RgH8AtiMGjPKiu3e8kHUAJV91hXtaF0FtJEQWNf3BISYvThmvG6f+rW9bg6DbU3zDcqkImLnjtsWQI1pQnCHL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779660; c=relaxed/simple;
	bh=66BVqCbKDn+jo5M0SReK+8cOh5WJOIPN3sNP15kwFE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GbWacBVpBPMB27cvoEn2MyQrdMbUKsCS7OpwJM9+J4+dxT6htm8cxzG3cWuWwIJOQQ8vBB1j/FYF8E1Jn5zr08Vzd7tRn73JWXG2skovnPwzc36GaD6c8BpulCz4EGwzV0nE8SPOzAC9vpOgAZHzK88kEdxJJTa3i+8NoR35RbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=K5V7dOD/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729779639; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jpxv9xpHSKQG0/oUpp6pw17MmUOsF2GlfYcRhVm16CifnTIca0UkppxoA763vZ0/pPHHANjd5TrQEY/gjytoevTqf8mnDLEw76KmSzT8KzetddUUy2KPpPsn5ZVi+QGOIe4WxCqL4laP3MwV6B5gdnHKL4KQ5vpHPIFao2q6jFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729779639; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1gj1j7WC9lXSj7Bgp1ra75ozAe1u8eahbjbU4P3MFUg=; 
	b=SZ3P+gTclNfIMUOLcxHGigA13GCftkwRO3Dd/62PRruOI381bmBC6j/6Dck0ez2jzqeDF28HSSNr0HJQ0eIvvDEw8KE+pD5RTXLNSoM/27AHRveWEhR6gdFZ/s92Zi2mXDrPVKvSWEO7EuB7vxnVWHUu1RtxmQ5QknJ3wG+r5AE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729779639;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=1gj1j7WC9lXSj7Bgp1ra75ozAe1u8eahbjbU4P3MFUg=;
	b=K5V7dOD/XkcfPEk3jkTrFnaCcBWf2Zp27BK6AI28se1E2woEifyZfRmYPQxpzfMY
	EegrVEyL92fVwB/JR6bs3Gk3RxiI0RJg1Cx3KzBAka+3HxENIUmi0qkiHZOlhVv8p2o
	uQ/F7BKrg7kQQUYQcNVVpA2VFDNefRQEanRIfFjQ=
Received: by mx.zohomail.com with SMTPS id 1729779638282351.789766608195;
	Thu, 24 Oct 2024 07:20:38 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 24 Oct 2024 11:20:28 -0300
Subject: [PATCH] rust: platform: add Io support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-topic-panthor-rs-platform_io_support-v1-1-3d1addd96e30@collabora.com>
X-B4-Tracking: v=1; b=H4sIAKtXGmcC/x3NQQrCQAxA0auUrA20o9DqVURKWjM2oJOQmUqh9
 O4OLt/m/x0yu3CGW7OD81eyaKroTg3MC6UXozyrIbTh0rXhjEVNZjRKZVFHz2hvKlH9M4qOeTV
 TLxivPfEUmIahh5oy5yjbf3N/HMcPfsyw33YAAAA=
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
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

The IoMem is backed by ioremap_resource()

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
The PCI/Platform abstractions are in-flight and can be found at:

https://lore.kernel.org/rust-for-linux/Zxili5yze1l5p5GN@pollux/T/#t
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/io.c               | 11 ++++++
 rust/kernel/platform.rs         | 88 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

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
index f9bb1bbf1fd5daedc970fc342eeacd8777a8d8ed..f708c09c4c87634c56af29ef22ebaa2bf51d82a9 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/io.h>
+#include <linux/ioport.h>
 
 u8 rust_helper_readb(const volatile void __iomem *addr)
 {
@@ -89,3 +90,13 @@ void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
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
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index addf5356f44f3cf233503aed97f1aa0d32f4f062..d152432c80a4499ead30ddaebe8d87a9679bfa97 100644
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
@@ -208,6 +212,49 @@ fn as_raw(&self) -> *mut bindings::platform_device {
         // embedded in `struct platform_device`.
         unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
     }
+
+    /// Maps a platform resource through ioremap() where the size is known at
+    /// compile time.
+    pub fn ioremap_resource_sized<const SIZE: usize>(
+        &self,
+        resource: u32,
+    ) -> Result<Devres<IoMem<SIZE>>> {
+        let res = self.resource(resource)?;
+        let size = self.resource_len(resource)? as usize;
+
+        // SAFETY: `res` is guaranteed to be a valid MMIO address and the size
+        // is given by the kernel as per `self.resource_len()`.
+        let io = unsafe { IoMem::new(res as _, size) }?;
+        let devres = Devres::new(self.as_ref(), io, GFP_KERNEL)?;
+
+        Ok(devres)
+    }
+
+    /// Maps a platform resource through ioremap().
+    pub fn ioremap_resource(&self, resource: u32) -> Result<Devres<IoMem>> {
+        self.ioremap_resource_sized::<0>(resource)
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
+    fn resource(&self, resource: u32) -> Result<*mut bindings::resource> {
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
@@ -215,3 +262,44 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+/// A I/O-mapped memory region for platform devices.
+///
+/// See also [`kernel::pci::Bar`].
+pub struct IoMem<const SIZE: usize = 0>(Io<SIZE>);
+
+impl<const SIZE: usize> IoMem<SIZE> {
+    /// Creates a new `IoMem` instance.
+    ///
+    /// # Safety
+    ///
+    /// The caller must make sure that `paddr` is a valid MMIO address.
+    unsafe fn new(paddr: usize, size: usize) -> Result<Self> {
+        // SAFETY: the safety requirements assert that `paddr` is a valid MMIO address.
+        let addr = unsafe { bindings::ioremap(paddr as _, size as u64) };
+        if addr.is_null() {
+            return Err(ENOMEM);
+        }
+
+        // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
+        // size `size`.
+        let io = unsafe { Io::new(addr as _, size)? };
+
+        Ok(IoMem(io))
+    }
+}
+
+impl<const SIZE: usize> Drop for IoMem<SIZE> {
+    fn drop(&mut self) {
+        // SAFETY: Safe as by the invariant of `Io`.
+        unsafe { bindings::iounmap(self.0.base_addr() as _) };
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


