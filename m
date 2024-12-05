Return-Path: <linux-kernel+bounces-433115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF6B9E5405
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A671882DED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC121F668E;
	Thu,  5 Dec 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNLC4cDf"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A0239185;
	Thu,  5 Dec 2024 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398374; cv=none; b=ZyN0Z1keQAd63DxxV/XA4D5uy9l4atzubqPZageBt5TvyH6t9/1i/VCNx85Fzkf4ZjwNYtf/uBSrk8mitIe+1HMZyVIEICaviLnaZDCQYz4lmteyfi1gGRcGWUbMY2njS0ROAwS9Q77DM3g8t3zWrzahcOBQDQIPKKWd2F2lK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398374; c=relaxed/simple;
	bh=v/VhgNzAUy5yfkyihuvK+jBGhawPzQRWRegqTl//ZtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/LoKT5bC/qsMqn6Eb7aFSqvr2ceIP/SS4wgQU8Li6Yy5sV7NHxUDFo/QPExceIlHGXNAqhdp83sY6PO73nzQZInu35C1hyhKSj2f8AG/M4ifA45QILVz7WGnIAaYkqGtYw+EL8yhwUtl9jGWFLU01LMJEUptDvZ4/MXapCC/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNLC4cDf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df1d1b6e8so785029e87.1;
        Thu, 05 Dec 2024 03:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733398371; x=1734003171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4w+FNnQU4Gd2oQswt6DB7Qgzf599gU2AT2+6YNQKrw=;
        b=fNLC4cDfudLfbCCZvaRdjrDwXg5p/0Uai1+3YV3Q/HuLBCzQmCLa44Is5erM+ZltuM
         2YGyzIrEo3+zYcVRNtPHsJC9aRgoFqzjXG2TbSWlgwFJ6ppGG+IOCrzvmENd7uiiT50e
         h2y6yjqvN2jJV73IAzWvMBCn6tUgd7t7nJekluyX7srMR7Pd/INyrqdbFDrBzwg5NQVI
         tmP0bxG22K+ms/vFQfxQZSf1ZsGmVHel5KfckyVp8LC7sP/SjODVAkTpggvB9H3Z1HCv
         CURiAvnuBmGsVwuB9h2odye+J6m12qANvJGQz32QKZH9na44fSt4ogky9CmNNfjGwPv9
         YA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398371; x=1734003171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4w+FNnQU4Gd2oQswt6DB7Qgzf599gU2AT2+6YNQKrw=;
        b=NeWP1ahgReqbE6PT+t6Katf1bAeKFAW1cly/BvDluIdf1LrKebUIctY3PLPfAPVy1E
         2IG+H4Fgqdh3cdi3sRUsO8IwePpqTFIsZEYq/dMCvfWpem2jvdbmwECiyjTCXWh52wi+
         9Q5H9xLUA03+x32FU3GB2gOeaGL6TVkTQP8Yo9Vb9L2XHrOpT0LKZ0c0aaUARpay0v4g
         B1Fj3O/Om/REHRHHkZrw2Ot89D9lErZRsIgn4wlTvajFM0OraJuoWQNMaVpcKC6FQ1dn
         kXwiKeWSOcW4fOmhHTkUtob5+gfZ/JTbH60i8r/3imPNpC1GGeIJ6XhmTZwEBTobZBEp
         g47Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKkWpH9LVA3qeBcAH4WExRFpBPjxhCBX7OOXKjqgIPXoySIpKPCn/ytfGECDtkpnv8bWUFn5OX7QuiqfA=@vger.kernel.org, AJvYcCW7nztny1z+TvM1v9rN1QMVKZH8xJLb4m8YSNEE4f6ghykmzkrH/B3+gE7Nqnuy7bs5qPEJHhqCzY1IadMAN/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHDTbnJApWLuD1p5CxWJmvyzrYXr5J+/kLfzzgFIeFUd+ugdb
	3oDG9Mh6Aad4U0bUhwWx4NZDVbHGXgKeOrMt120h93JTekZ7Ul3t
X-Gm-Gg: ASbGncvMPHWKKX50A50xIlYr1QN3xG0MpEdomvwGMIC9TYiXIWbXxkBvjvhy1j58iaz
	hjvq+k8Q78j+vjc+lxfNrKVh+sJXNrFEtCkeM+0D1QTZU2mJzhJWgU1eARCCb00gPb/rIFpQk7M
	QsALGn8YWg6nnW56ERoilp2uodPnWUw+389jz1R0Br4PMWEPSwJHrFlwLpZuYSSRqdqSCs5D6ow
	Z81qNgBELwHgGVZzdFqjuYtvs+iabgYhqUqyJP8fN+8jLm9pZz13MYzzghIYpcW9aqRCWK0sVCr
	4szYbsX4UwQmwImNpkpj
X-Google-Smtp-Source: AGHT+IHzbyGee5WIyxIDgwfUDjYSBmtTtthROTbvUuih4hQqRJxGEWMbCyELSJSBDvFxXHkoBFi+/Q==
X-Received: by 2002:a05:6512:3f22:b0:53e:12ea:f797 with SMTP id 2adb3069b0e04-53e1b8b731cmr2760098e87.42.1733398370489;
        Thu, 05 Dec 2024 03:32:50 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229744e3sm216136e87.66.2024.12.05.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:32:49 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: daniel.almeida@collabora.com
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
	Valentin Obst <kernel@valentinobst.de>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v6 2/2] rust: add dma coherent allocator abstraction.
Date: Thu,  5 Dec 2024 13:32:17 +0200
Message-ID: <20241205113234.2021442-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
References: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
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
index 000000000000..dd725c571ff7
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
+    pub fn cpu_buf(&self) -> &[T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
+    }
+
+    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
+    pub fn cpu_buf_mut(&mut self) -> &mut [T]
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


