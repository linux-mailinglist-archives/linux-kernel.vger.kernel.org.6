Return-Path: <linux-kernel+bounces-392152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7069B905C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF351281CD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE719D060;
	Fri,  1 Nov 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMyCu3Qi"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DD19C54E;
	Fri,  1 Nov 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460941; cv=none; b=nk0VE4+xyukeQnMqxUb7Bf7HR86+NuRTgJS+fhx0sZbwGAHiePOqC+AQ4O0T0NqVPGi4RFgXg4RB1rwYmdpWzgrZxAxA8M9NCP4nr5ZqEewI+z7YfmB7YB1r9GCYmFz8VJe5Ni+Ka0AHk+AZonUgL2gZ8bzZua1//53ZBXCenfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460941; c=relaxed/simple;
	bh=1FD6T3hTkpYBZUhzGwN7bIesqnpWdKzlwr+Y6UT5m2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9l7ExDwusDzlc2GNrTFZ9lU/IfdTrARFdn0FbHbvVN5eT/aYSZpaifMCGtWu4bXpZPYI+SIrfqt4p+tIhUNkVMAZD2q+rWdBHH6IPStM10UJsIh6HFFd9xzhiQyHaiYsak3Yu/KSWOBI1kfimJVE0vDAIxZGiZHPb0XFqJAyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMyCu3Qi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso1974774e87.2;
        Fri, 01 Nov 2024 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730460937; x=1731065737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMGPKQZc0R1AZaXROeswbFRdAecV3A4DoVpVd3lG1To=;
        b=bMyCu3QiTDtMTrY6ijjX0vHhqj3lKv2FsA2pK+szs6lz1ziaLU40sNqVdiUVk0rrrl
         Jype+6lVVIbptfh+GSsV/+erQSava24u7dqVDRlYPaTSHHhYBLCIvX5p18jlqqMPuYr0
         yiU2890tqo5t7sjDgEub7NctCXDqNW08IQQFX5uM+6cLUTNnnWiO3s0NLO8ia8nlGQ3Z
         gzA7cwu4WAdfyMvkpk2oEXdmk4GKAzM2+ZI3Tkaryn+g9botVNTQpIUQ5Jxn2ANmzzTp
         ja1Z5jRQAqTBN3gIm/KMOnBUsVXz5xIP+PG2c+nVRZ2mAGGKkpE+qCo9907tTt9DM/+t
         gFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730460937; x=1731065737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMGPKQZc0R1AZaXROeswbFRdAecV3A4DoVpVd3lG1To=;
        b=K2fruGfUFiRnQ5Ef5N4jNwFRv1pIqGf9yCXDROMX0/iHkRBfDTGjzLgadVaswazEE/
         I4b2KfD+wGNH2blIjEMyW4OKccMvV0SaOSGNZdpLIy6dvKc4rdd64x7USWuXJBJwwXe7
         4VI/EpjRkjryy06dsH95M24Wxn0dx+3cT9acl0NQMws+Ysj7eH74BTqd5mS64e8GuXFY
         NRk2uvJxKzoMB0UFdUeha+QrGRwSZHK8VvlJLWvKKtry+VP/prYyQuR4Av4+3IG5OpES
         bBeJJ0LT1rMky8gM8d7+xOG5bEoUGH/3xGTX2/dVyELDpiPA+xUmuDw4cFAYT3nXXJQd
         FcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnitnEa4mPv+ze380HuyMEkscPZYD+9LCghtEFU67b8rPh+Arjnw5B/RNELBWAiQlJDrMiWkJLu6/M1Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UJNS+2dYDdhZdXgxghMxYKA5TZ04ydFxr1KrGzSkZF7ESFSQ
	hvOAzvWS0qzRv0oyVCphtMAZl9t/uhvMfc7a2ZwxOzx3MGgsxJCgJEpr3w==
X-Google-Smtp-Source: AGHT+IG2eoCvZAl2wEBN9z/avJxcIBELxtdUMs4LBYdKKLF/pzI83xNAPTdgvcAPDp5KaPpoyZdz9g==
X-Received: by 2002:a05:6512:1089:b0:539:959e:f0e8 with SMTP id 2adb3069b0e04-53d65de8ba0mr1897967e87.21.1730460936369;
        Fri, 01 Nov 2024 04:35:36 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdebf80sm525163e87.306.2024.11.01.04.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:35:35 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: daniel.almeida@collabora.com,
	a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v2 2/2] rust: add dma coherent allocator abstraction.
Date: Fri,  1 Nov 2024 13:33:24 +0200
Message-ID: <20241101113422.2615566-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101113422.2615566-1-abdiel.janulgue@gmail.com>
References: <20241101113422.2615566-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple dma coherent allocator rust abstraction. Based on
Andreas Hindborg's dma abstractions from the rnvme driver.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 165 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 2 files changed, 166 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..75a304d612f0
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct memory access (DMA).
+//!
+//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::code::*,
+    error::Result,
+    types::ARef,
+};
+use core::ops::Add;
+
+/// Abstraction of dma_alloc_coherent
+///
+/// # Invariants
+///
+/// For the lifetime of an instance of CoherentAllocation, the cpu address is a valid pointer
+/// to an allocated region of consistent memory and we hold a reference to the device.
+pub struct CoherentAllocation<T: Add> {
+    dev: ARef<Device>,
+    dma_handle: bindings::dma_addr_t,
+    count: usize,
+    cpu_addr: *mut T,
+}
+
+impl<T: Add> CoherentAllocation<T> {
+    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    ///
+    /// Returns a CoherentAllocation object which contains a pointer to the allocated region
+    /// (in the processor's virtual address space) and the device address which can be
+    /// given to the device as the DMA address base of the region. The region is released once
+    /// [`CoherentAllocation`] is dropped.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::device::Device;
+    /// use kernel::dma::CoherentAllocation;
+    ///
+    /// # fn dox(dev: &Device) -> Result<()> {
+    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL)?;
+    /// # Ok(()) }
+    /// ```
+    pub fn alloc_coherent(
+        dev: &Device,
+        count: usize,
+        flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        let t_size = core::mem::size_of::<T>();
+        let size = count.checked_mul(t_size).ok_or(EOVERFLOW)?;
+        let mut dma_handle = 0;
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        // We ensure that we catch the failure on this function and throw an ENOMEM
+        let ret = unsafe {
+            bindings::dma_alloc_attrs(
+                dev.as_raw(),
+                size,
+                &mut dma_handle, flags.as_raw(),
+                0,
+            )
+        };
+        if ret.is_null() {
+            return Err(ENOMEM)
+        }
+
+        Ok(Self {
+            dev: dev.into(),
+            dma_handle,
+            count,
+            cpu_addr: ret as _,
+        })
+    }
+
+    /// Reads a value on a location specified by index.
+    pub fn read(&self, index: usize) -> Result<T>
+    where
+        T: Copy
+    {
+        if let Some(val) = self.cpu_buf().get(index) {
+            Ok(*val)
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Write a value on the memory location specified by index.
+    pub fn write(&mut self, index: usize, value: &T) -> Result
+    where
+        T: Copy,
+    {
+        if let Some(elem) = self.cpu_buf_mut().get_mut(index) {
+            *elem = *value;
+            Ok(())
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Performs a read and then a write of a value on a location specified by index.
+    pub fn read_write(&mut self, index: usize, value: &T) -> Result<T>
+    where
+        T: Copy,
+    {
+        if let Some(elem) = self.cpu_buf_mut().get_mut(index) {
+            let val = *elem;
+            *elem = *value;
+            Ok(val)
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Returns the base address to the allocated region and the dma handle.
+    /// Caller takes ownership of returned resources.
+    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
+        let ret = (self.cpu_addr as _, self.dma_handle);
+        core::mem::forget(self);
+        ret
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space.
+    pub fn start_ptr(&self) -> *const T {
+        self.cpu_addr as _
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space as
+    /// a mutable pointer.
+    pub fn start_ptr_mut(&mut self) -> *mut T {
+        self.cpu_addr
+    }
+
+    /// Returns a DMA handle which may given to the device as the DMA address base of
+    /// the region.
+    pub fn dma_handle(&self) -> bindings::dma_addr_t {
+        self.dma_handle
+    }
+
+    fn cpu_buf(&self) -> &[T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
+    }
+
+    fn cpu_buf_mut(&mut self) -> &mut [T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
+    }
+}
+
+impl<T: Add> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+        // SAFETY: the device, cpu address, and the dma handle is valid due to the
+        // type invariants on `CoherentAllocation`.
+        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
+                                          self.cpu_addr as _,
+                                          self.dma_handle, 0) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b62451f64f6e..b713c92eb1ef 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -32,6 +32,7 @@
 pub mod block;
 mod build_assert;
 pub mod device;
+pub mod dma;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.43.0


