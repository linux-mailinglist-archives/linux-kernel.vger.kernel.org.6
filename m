Return-Path: <linux-kernel+bounces-429913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D419E28BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235A8286381
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D401FBE88;
	Tue,  3 Dec 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE692NiP"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68E1FAC49;
	Tue,  3 Dec 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245743; cv=none; b=UqycR+n6oW54S9WXYAmbDWbipIXfG27a/eb2KcNvGvZhHjrhuWBqGaFCl+GinTJw4Ig6yyBS5uI2WmSDqTxgDReR8v26EMGW820LMx66I2XyBPHtSeXFpqi9bzIkpLc7l3e8NGCUWa0AzP/Sr22G9S1Vu5mGigeBwR5kmeXGuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245743; c=relaxed/simple;
	bh=jDgoZVWs1EZ0BLsWSC/biSIEBFBgOOP/XfjuZPS8yO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMDTWQSWOQGV1368Jk+XPJr4pNEo7rAae4Jzl16a+TknnSPvepk09hQae1jzYnSBj8scSp4ZERL/c/TPunCuADGPcZqWEC5WWzdKaLLHveVqouvwL+b2YlTQGP5hIdeNdKdhRXH8NQnUVQuX68jmk033xX3kyVsGyOkqvqChJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE692NiP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so6662521e87.1;
        Tue, 03 Dec 2024 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245740; x=1733850540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTR6Ylpv3eNdxiaC7COAI2rMXOLAET8qmxvIBqqw6fM=;
        b=PE692NiPR2rmEqjy/LyPQyvIVGmZlgWY7AF2p3ojDFlH2IvI9EbN2RA/z2J5RU3J5k
         kQPLoejngnSwRRQiFrWWuaN3xHjeAI8ycG0lXrenU9/JzEaSd7KGeyCy6LL7L5XNfEW0
         cOSJGXRy9cTn+TDg4+3xClney1V0ggoOdzXZoHOMkBUrON+aIT624ZBWDkiu+/xAgt+A
         68C/DTQ22kMrqiTWjcBFM1Mr6Yu534tp4QoIxJOIw0JkiB2GulnOSJqgYL1H8KDkrnw4
         ypoGlBVaRiVY3sO4ovVxhOXAxFYDdVZ0P5vEpW7zavxpabpqbW2LBuyX5gEmoVAR/CRM
         /dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245740; x=1733850540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTR6Ylpv3eNdxiaC7COAI2rMXOLAET8qmxvIBqqw6fM=;
        b=UyxUsiLAAkoSDJ0DIFDmGlaf5r9d3uYA/hSoufLfMGDi7CK9i/iNtCAWpzfDchsjKA
         yuTF3cfJtKkuYdK4CGDZo9rNjjCdDGbQkmaQiuV5tY7U6JUnRabFIM4Ur4LN4RzmSr/P
         r5FFpPFYPqkNXoVtMkmCU7PwRl53ODGw9eYjd3wmGVSI2glUP4Ka2z4itNOayPhN2HSF
         L9Tt+3yPDnZZ8bjmJAWCUXl3rYaA/lgmU+tqiDNb5zNefogtRD5cNSQ9AKD4J6QeiK6m
         BvQImLFNYDdKp0xssDE/MgKXUqHczeMQK8mnZRv8zr4JGd1cO+X3HupGhjQ4yiDwTbBs
         sJmw==
X-Forwarded-Encrypted: i=1; AJvYcCWHZk3lyHT5cN+r/5XZ8EUjekysPyLp9tgemBBvEq/hUX4+dQrF8QW8WDzxTqC/gF47dKb9/reHl7cHCAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+KCMznxMJ2oISyvoV+/RxxwBMQoFhDKunRF5RouTHT3WyRJI
	sozF9sxCD8GSE81+w4T+H2TlaYW6pxK6J/3xbUKoT+kGiLyiSzk3yFUkIQ==
X-Gm-Gg: ASbGncsEmLGBc3yO3k1qj9HYXyYKed58FMXM5n+YtYLyp/21HK9/XQHf9HAm0pUbW1O
	Bz+1ekUU91lzb2r/Zr7FNKKz35EugbdnR1zbkZ7nRxna+DIcJYtWzsDTHnDOXgA2scHIDnGh+UH
	I4hStWZ3KLW8OPdRxcJRdQhNStEhrW6xe91DKHTZLtKyFAoG0bSbI0HG1dSto3+CZUyWtSKJOZ9
	9vR1AN6b4lyOSluA5SHylpuupCGHQHDW5IvNHsvmkX4jRsMwYTO67NXiEEZOwdni99gIRdk/CNZ
	4phm0J4oVWD5LLF4+qLP
X-Google-Smtp-Source: AGHT+IHk1IYP2NKFAmvEFFHZPc7mvlW5OfXCL9iqwuQ5vcHYn6pBy4IkJ3t9oeRJ73P75rqoJytFaw==
X-Received: by 2002:ac2:5b90:0:b0:53e:12d6:7853 with SMTP id 2adb3069b0e04-53e12d6786fmr1874749e87.4.1733245739714;
        Tue, 03 Dec 2024 09:08:59 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644336fsm1893394e87.80.2024.12.03.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:08:58 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@google.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v5 2/2] rust: add dma coherent allocator abstraction.
Date: Tue,  3 Dec 2024 19:07:44 +0200
Message-ID: <20241203170752.1834271-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
References: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple dma coherent allocator rust abstraction. Based on
Andreas Hindborg's dma abstractions from the rnvme driver, which
was also based on earlier work by Wedson Almeida Filho.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 136 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 138 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5c4dfe22f41a..49bf713b9bb6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/cred.h>
+#include <linux/dma-mapping.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..9279be235fcf
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct memory access (DMA).
+//!
+//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
+
+use crate::{
+    bindings,
+    build_assert,
+    device::Device,
+    error::code::*,
+    error::Result,
+    types::ARef,
+    transmute::{AsBytes, FromBytes},
+};
+
+/// An abstraction of the `dma_alloc_coherent` API.
+///
+/// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
+/// large consistent DMA regions.
+///
+/// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
+/// processor's virtual address space) and the device address which can be given to the device
+/// as the DMA address base of the region. The region is released once [`CoherentAllocation`]
+/// is dropped.
+///
+/// # Invariants
+///
+/// For the lifetime of an instance of [`CoherentAllocation`], the cpu address is a valid pointer
+/// to an allocated region of consistent memory and we hold a reference to the device.
+pub struct CoherentAllocation<T: AsBytes + FromBytes> {
+    dev: ARef<Device>,
+    dma_handle: bindings::dma_addr_t,
+    count: usize,
+    cpu_addr: *mut T,
+}
+
+impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
+    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::device::Device;
+    /// use kernel::dma::CoherentAllocation;
+    ///
+    /// # fn test(dev: &Device) -> Result {
+    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn alloc_coherent(
+        dev: &Device,
+        count: usize,
+        flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        build_assert!(core::mem::size_of::<T>() > 0,
+                      "It doesn't make sense for the allocated type to be a ZST");
+
+        let size = count.checked_mul(core::mem::size_of::<T>()).ok_or(EOVERFLOW)?;
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
+        // INVARIANT: We just successfully allocated a coherent region which is accessible for
+        // `count` elements, hence the cpu address is valid. We also hold a refcounted reference
+        // to the device.
+        Ok(Self {
+            dev: dev.into(),
+            dma_handle,
+            count,
+            cpu_addr: ret as *mut T,
+        })
+    }
+
+    /// Returns the base address to the allocated region and the dma handle. The caller takes
+    /// ownership of the returned resources.
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
+    /// Returns the CPU-addressable region as a slice.
+    pub fn cpu_buf<'a>(&self) -> &'a [T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
+    }
+
+    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
+    pub fn cpu_buf_mut<'a>(&mut self) -> &'a mut [T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
+    }
+}
+
+impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
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
index e1065a7551a3..6e90ebf5a130 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 mod build_assert;
 pub mod cred;
 pub mod device;
+pub mod dma;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.43.0


