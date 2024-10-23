Return-Path: <linux-kernel+bounces-377955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11219AC904
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A568B21355
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3E1ABEBF;
	Wed, 23 Oct 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1NXnt7N"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D031AB6D8;
	Wed, 23 Oct 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683252; cv=none; b=MyUIQwLrNhJgYC/3ImRjyAQm2/E5GEdGgnR+10MRAiG8wcHiiWrL7gNs8skafNGmQfbK5on+NKpa5NUOguai3hLeUaLa82v//zpgTXHz02i2R6jg/a/ycVi/0F/k0eMqOty/jHpRcgmIL3ybgPjBJ6ldKxvpep/Uw6QmHJX5rII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683252; c=relaxed/simple;
	bh=MBcEZJOKl/xD9cyg5INiQqlfZv9ROWZCEzPutOzhX3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+yRba1JOcZC9bKaaI6gXieMo+SJcyx7dvwERGOCiIwsaBBK6e3bjNdCpaWdCcFfcawV6AQTJgxF+3OScY4bpbMEMln5NQNjF93AebgNnZdkzfAkNOJojiT4tZkUQX8uDyIQhOeORpxJ3mnedx+mHG6Q0C5n+upRayL4lBSqw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1NXnt7N; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e7e73740so5981751e87.3;
        Wed, 23 Oct 2024 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729683248; x=1730288048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qN+0Px+0s97YMRw2HZ13JqDkvk6B8AYRTapG2Bysg0=;
        b=h1NXnt7Ng18JiIV7Amf23mY6gm5ZCZYN8QOab3ZWyocEWeKslEa8Td7HzyGhH4Sxca
         8QfBdbdmBpdp9h8J+5rSQJkF+lRV8vpZrBd6Uq+y0GYoglg/oFBTfdLSr3wktQ0TS5us
         F2VSiWoGv8CYRtI6xl76InOPCV69R0SAT5GfczUN6Q9b1gpW7MqmsvO0zjcI9Obmp1eU
         ek6S9KEHNp0FzS/sJK57QF1z5DkwxYdKmVVoHK20h+23xrqkiLKq0d8HSRru9nGKZeHy
         4APIF+wDh2JTrAb3maAM/zTuB3FFsADYe/XWwZ4ET1SKgz2FLg3pRoIeq3YyAWSJm2ll
         txnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729683248; x=1730288048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qN+0Px+0s97YMRw2HZ13JqDkvk6B8AYRTapG2Bysg0=;
        b=rdbX25In4sEHi/Zs2wsVfcB2+qORekspOTNQcmRRutYM7+5QknsQMV79y9Ayp1je8A
         qi+H3/uXypVxrfuC6cNYbeYVFo7J5GaDTVSvjEj6SmwOmZ23yfKpE+XXid8o5Nz6bctE
         h+RmOGOAiWFUvAk+t2nk9kmljebow+n+KV16NYjqT+qUVTeNRKnVxZAF2LMrLgPQTheG
         BnjQFQ9stK/8D7rNOV8PF1QBoUA6VWN9/mI00OBqsaT9Mx2Dwrzz7l8omwbRWrniqNr+
         5P3gmXT7GNdasG/QN/W6pevkG+RMUHLYD+KBRVkyOCblgwkZIZ6f+w+l/r0n1i/cmGGg
         M+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqPtTIfELYaGz0f8l9rrKAXhwAY8yqwFqk8JJ/CEexmiVz7PFZ+/yeT7c9ko4OGr/NbgUuL/sYposPksM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zw6ILgc39YZ120urAk4MPdkEAW0NnbiP30VXJcyAN2SILBSQ
	Azkg5Ep5mzRpZY8l5RP8RAkVkGqULqaKS8q9G6VmngOA5fvP6GUiJ4y3uA==
X-Google-Smtp-Source: AGHT+IEyPYUOubhUp8k0I3EXOEynv0hF7A9hQt9CpQtmW4W+c2mOTas2YJpehJbfQM7/nZo14MismQ==
X-Received: by 2002:a05:6512:398c:b0:539:eb82:d453 with SMTP id 2adb3069b0e04-53b1a36c455mr1065075e87.39.1729683247545;
        Wed, 23 Oct 2024 04:34:07 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243ed31sm1029769e87.254.2024.10.23.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:34:07 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH 2/2] rust: add dma coherent allocator abstraction.
Date: Wed, 23 Oct 2024 14:32:51 +0300
Message-ID: <20241023113309.1724992-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
References: <20241023113309.1724992-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple dma coherent allocator rust abstraction which was based on
Andreas Hindborg's dma abstractions from the rnvme driver.

This version:
- Does not introduce the unused dma pool functionality for now.
- Represents the internal CPU buffer as a slice instead of using raw
  pointer reads and writes.
- Ensures both 32 and 64-bit DMA addressing works.
- Make use of Result error-handling instead of Some.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 153 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 2 files changed, 154 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..8390b3a4e8aa
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,153 @@
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
+
+/// Abstraction of dma_alloc_coherent
+///
+/// # Invariants
+///
+/// For the lifetime of an instance of CoherentAllocation:
+/// 1. The cpu address pointer is valid and is accessed with an index bounded within count.
+/// 2. We hold a reference to the device.
+pub struct CoherentAllocation<T: 'static> {
+    dev: ARef<Device>,
+    dma_handle: bindings::dma_addr_t,
+    count: usize,
+    cpu_addr: &'static mut [T],
+}
+
+impl<T> CoherentAllocation<T> {
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
+            // SAFETY: The raw buffer and size is valid from the checks we've made above.
+            cpu_addr: unsafe { core::slice::from_raw_parts_mut(ret as _, size) },
+        })
+    }
+
+    /// Reads a value on a location specified by index.
+    pub fn read(&self, index: usize) -> Result<T>
+    where
+        T: Copy
+    {
+        if let Some(val) = self.cpu_addr.get(index) {
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
+        if let Some(elem) = self.cpu_addr.get_mut(index) {
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
+        if let Some(elem) = self.cpu_addr.get_mut(index) {
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
+        let ret = (self.cpu_addr.as_mut_ptr() as _, self.dma_handle);
+        core::mem::forget(self);
+        ret
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space.
+    pub fn start_ptr(&self) -> *const T {
+        self.cpu_addr.as_ptr() as _
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space as
+    /// a mutable pointer.
+    pub fn start_ptr_mut(&mut self) -> *mut T {
+        self.cpu_addr.as_mut_ptr() as _
+    }
+
+    /// Returns a DMA handle which may given to the device as the DMA address base of
+    /// the region.
+    pub fn dma_handle(&self) -> bindings::dma_addr_t {
+        self.dma_handle
+    }
+}
+
+impl<T> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+
+        // SAFETY: the device, cpu address, and the dma handle is valid due to the
+        // type invariants on `CoherentAllocation`.
+        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
+                                          self.cpu_addr.as_mut_ptr() as _,
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


