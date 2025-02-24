Return-Path: <linux-kernel+bounces-528946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415F2A41E49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30AD1721C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB4261387;
	Mon, 24 Feb 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mntCTaO6"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2125E450;
	Mon, 24 Feb 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397842; cv=none; b=YRK2+IdWlDiu9mRIEVedDbQCb4lLRBprs1rDUkjwxbMA4xJpq4kSpExZXKLkOm//NXCc3MlSdREbavB3oI0OTd2IhsCWMsirULEN7FXbcLNcgWCDb4zcZZegYa1TlMChFvWiD5VSK/7KQxdf4sO2Nyy6utCHTNyXpN9aft4U6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397842; c=relaxed/simple;
	bh=yQBJFD+cvLESYRJ+VvO4DjPb5h6sEvnk5ByVPePnChI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/A3ugLPu4kuA4h3SNFTXEe6WR1eDwCvchRWHUcRWXNMrOwt0l5YYGdukccLq/e5QFNhO5qC7+zQfP6fUpSWMUSopfIGENLm5BzOFc3d0I2j/BsPgdDOQhn/ipGhPpnm3wrfk8XDxozx/vAwPnX5coKMvLtV3W3RTNtM2lQBTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mntCTaO6; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a6bso44572671fa.1;
        Mon, 24 Feb 2025 03:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397837; x=1741002637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPCkP3EPbmr72ZSSpdQ8KCZwbUbHv8MIfV/ElE4yPeU=;
        b=mntCTaO66FVcHPyzHx4X41GLLOu6ABQTIE31/UMxyDXfslT6KtpnzpK+TSCs4L1Qom
         Iu5Xf/oD5oIlLJLen2+YQjoc9HR48xuDBK5NJZJs5aepbKoN8lG8faRfGFnyoKimw+54
         bhMLPyzBvPFZGOkUIrIz8wYOENnKclo3oG+AcGvVeOeStTkX/MlYYpk3TLY8pSMqceVj
         MnzSptSaxRct9E2qMNDV/ldcWFPlFFGEkIOZb1GgqqvzES8+QP594AiWjIwJWT0cpPTB
         Oi2VdRvQ6z1EdkdPZcoyyTEckBIPq0jlyiUU+EPBGsMBk97QTTrJMWsyPNlCrVTLcrnn
         w/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397837; x=1741002637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPCkP3EPbmr72ZSSpdQ8KCZwbUbHv8MIfV/ElE4yPeU=;
        b=NbFUiZ6riLo5iCepe6eYbDMb5zjvSdLEr+IYT/GCwxDgT0JzRW80OHNn+Z7RZA/Obe
         K5oZNl8CP+Ee/TCtuZzc50PHlHfgYvi58F6zuUnvd1XMLIqyd05Dr96lCtgvGm9sxGMY
         ZJW5P/FBL3KNWkRq/S6kAv4kB9uoUPuhhyfl9xPKo58RKwzTEmpR94QATLzZP/m1DAcG
         uHCfVPuaI87eQr5B7LXp1xe0KQRBASvpxG9LqpsaY/GxHTrw9F0ix12LP94XDyaWo4LV
         ZBXQpnlw7aCrY2Lwae9HDitgXkNu7trMyw3folb6Uj27we7L2uL8uG+L5B2ZtKHieWXF
         70tg==
X-Forwarded-Encrypted: i=1; AJvYcCVn1VzXkdzchF2MCwrEAOLaeJDtfJZEJ7N8QhKXHjf8/FcxywHfIIF1LZy+6Gdq9ysplBWWzWv4vxJPuSpt+Bk=@vger.kernel.org, AJvYcCWs1HJYzSv+zSuVWez2RgiSR8whdZV7+vMlWNGnT4cChV0pX4wzcbl0D9sC18KLISyREeQqSrNy43kX3qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+0l3QO59W9l/tLc1nqngb+GVU4IrGTpFcjTDjyfxkYi50tGV
	/AArGfMwrTlX20Oqk6fRfthFdaJFslJ/zV7+rS1kY4s9OYgDSHmY
X-Gm-Gg: ASbGncvxV+sgq5pP6mdB2Dmz9qyUGSKTnUMal848B7AnXXXIs7knndKz0GTGlMRz+mM
	9Q2effVttqOckPfVUjgvCTHE9beHf+6rE+n3vM8+/BpeuYdWr3VufXGuS7LBJVpAKuevKKWXD6y
	BoUmW04NfOL3w7/ntkI3OK2rlDTLiigKYa44jhMkW0aWPEfY2xuRI9LXnKR99C20xNOnEKpbMg6
	qOenMatb/wNWe3BN3xEq+rWep9bU9MTSRMhqcCA4D0gGD+oBdn7k7qBXkb47YlKh5oEZCqEcRLs
	5venLBa68TWVsL6HwtDZYaOQ7bV6I8f/biITUjPN06mRxPY0pTc7FAsL0OBbTdZqHexa7UN8
X-Google-Smtp-Source: AGHT+IEvbJIYH7A1fz30yfJ2zMRihzdf98bH+/b20sEKjpsjmbx/T7hx9Fl/EgTBYukhPbUZKqW5oA==
X-Received: by 2002:a2e:740c:0:b0:308:e8d3:7571 with SMTP id 38308e7fff4ca-30a599ce8c7mr38477091fa.31.1740397837043;
        Mon, 24 Feb 2025 03:50:37 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091f26cd5bsm33174541fa.18.2025.02.24.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:50:35 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: aliceryhl@google.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Date: Mon, 24 Feb 2025 13:49:06 +0200
Message-ID: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
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

Nacked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/dma.c              |  13 +
 rust/helpers/helpers.c          |   1 +
 rust/kernel/dma.rs              | 421 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 5 files changed, 437 insertions(+)
 create mode 100644 rust/helpers/dma.c
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 55354e4dec14..f69b05025e52 100644
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
diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
new file mode 100644
index 000000000000..30da079d366c
--- /dev/null
+++ b/rust/helpers/dma.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-mapping.h>
+
+int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
+{
+	return dma_set_mask_and_coherent(dev, mask);
+}
+
+int rust_helper_dma_set_mask(struct device *dev, u64 mask)
+{
+	return dma_set_mask(dev, mask);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..8f3808c8b7fe 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,6 +13,7 @@
 #include "build_bug.c"
 #include "cred.c"
 #include "device.c"
+#include "dma.c"
 #include "err.c"
 #include "fs.c"
 #include "io.c"
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..b4dd5d411711
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct memory access (DMA).
+//!
+//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
+
+use crate::{
+    bindings, build_assert,
+    device::Device,
+    error::code::*,
+    error::Result,
+    transmute::{AsBytes, FromBytes},
+    types::ARef,
+};
+
+/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
+/// both streaming and coherent APIs together.
+pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
+    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
+}
+
+/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
+pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
+    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
+}
+
+/// Possible attributes associated with a DMA mapping.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`attrs`] module.
+#[derive(Clone, Copy, PartialEq)]
+#[repr(transparent)]
+pub struct Attrs(u32);
+
+impl Attrs {
+    /// Get the raw representation of this attribute.
+    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
+        self.0 as _
+    }
+
+    /// Check whether `flags` is contained in `self`.
+    pub fn contains(self, flags: Attrs) -> bool {
+        (self & flags) == flags
+    }
+}
+
+impl core::ops::BitOr for Attrs {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Attrs {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Attrs {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// DMA mapping attrributes.
+pub mod attrs {
+    use super::Attrs;
+
+    /// Specifies that reads and writes to the mapping may be weakly ordered, that is that reads
+    /// and writes may pass each other.
+    pub const DMA_ATTR_WEAK_ORDERING: Attrs = Attrs(bindings::DMA_ATTR_WEAK_ORDERING);
+
+    /// Specifies that writes to the mapping may be buffered to improve performance.
+    pub const DMA_ATTR_WRITE_COMBINE: Attrs = Attrs(bindings::DMA_ATTR_WRITE_COMBINE);
+
+    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
+    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs = Attrs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
+
+    /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
+    /// that it has been already transferred to 'device' domain.
+    pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs = Attrs(bindings::DMA_ATTR_SKIP_CPU_SYNC);
+
+    /// Forces contiguous allocation of the buffer in physical memory.
+    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
+
+    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
+    /// to allocate memory to in a way that gives better TLB efficiency.
+    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs = Attrs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
+
+    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
+    /// __GFP_NOWARN).
+    pub const DMA_ATTR_NO_WARN: Attrs = Attrs(bindings::DMA_ATTR_NO_WARN);
+
+    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
+    /// ideally inaccessible or at least read-only at lesser-privileged levels).
+    pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
+}
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
+    dma_attrs: Attrs,
+}
+
+impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
+    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::device::Device;
+    /// use kernel::dma::{attrs::*, CoherentAllocation};
+    ///
+    /// # fn test(dev: &Device) -> Result {
+    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_attrs(dev.into(), 4, GFP_KERNEL,
+    ///                                                                  DMA_ATTR_NO_WARN)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn alloc_attrs(
+        dev: ARef<Device>,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+        dma_attrs: Attrs,
+    ) -> Result<CoherentAllocation<T>> {
+        build_assert!(
+            core::mem::size_of::<T>() > 0,
+            "It doesn't make sense for the allocated type to be a ZST"
+        );
+
+        let size = count
+            .checked_mul(core::mem::size_of::<T>())
+            .ok_or(EOVERFLOW)?;
+        let mut dma_handle = 0;
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        // We ensure that we catch the failure on this function and throw an ENOMEM
+        let ret = unsafe {
+            bindings::dma_alloc_attrs(
+                dev.as_raw(),
+                size,
+                &mut dma_handle,
+                gfp_flags.as_raw(),
+                dma_attrs.as_raw(),
+            )
+        };
+        if ret.is_null() {
+            return Err(ENOMEM);
+        }
+        // INVARIANT: We just successfully allocated a coherent region which is accessible for
+        // `count` elements, hence the cpu address is valid. We also hold a refcounted reference
+        // to the device.
+        Ok(Self {
+            dev,
+            dma_handle,
+            count,
+            cpu_addr: ret as *mut T,
+            dma_attrs,
+        })
+    }
+
+    /// Performs the same functionality as `alloc_attrs`, except the `dma_attrs` is 0 by default.
+    pub fn alloc_coherent(
+        dev: ARef<Device>,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
+    }
+
+    /// Create a duplicate of the `CoherentAllocation` object but prevent it from being dropped.
+    pub fn skip_drop(self) -> CoherentAllocation<T> {
+        let me = core::mem::ManuallyDrop::new(self);
+        Self {
+            // SAFETY: The refcount of `dev` will not be decremented because this doesn't actually
+            // duplicafe `ARef` and the use of `ManuallyDrop` forgets the originals.
+            dev: unsafe { core::ptr::read(&me.dev) },
+            dma_handle: me.dma_handle,
+            count: me.count,
+            cpu_addr: me.cpu_addr,
+            dma_attrs: me.dma_attrs,
+        }
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space.
+    pub fn start_ptr(&self) -> *const T {
+        self.cpu_addr
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
+    /// Returns the data from the region starting from `offset` as a slice.
+    /// `offset` and `count` are in units of `T`, not the number of bytes.
+    ///
+    /// Due to the safety requirements of slice, the caller should consider that the region could
+    /// be modified by the device at anytime (see the safety block below). For ringbuffer type of
+    /// r/w access or use-cases where the pointer to the live data is needed, `start_ptr()` or
+    /// `start_ptr_mut()` could be used instead.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that no hardware operations that involve the buffer are currently
+    /// taking place while the returned slice is live.
+    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
+        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        // we've just checked that the range and index is within bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Performs the same functionality as `as_slice`, except that a mutable slice is returned.
+    /// See that method for documentation and safety requirements.
+    ///
+    /// # Safety
+    ///
+    /// It is the callers responsibility to avoid separate read and write accesses to the region
+    /// while the returned slice is live.
+    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Result<&mut [T]> {
+        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        // we've just checked that the range and index is within bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts_mut(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
+    /// number of bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Result {
+    /// let somedata: [u8; 4] = [0xf; 4];
+    /// let buf: &[u8] = &somedata;
+    /// alloc.write(buf, 0)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn write(&self, src: &[T], offset: usize) -> Result {
+        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`
+        // and we've just checked that the range and index is within bounds.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        unsafe {
+            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
+        };
+        Ok(())
+    }
+
+    /// Retrieve a single entry from the region with bounds checking. `offset` is in units of `T`,
+    /// not the number of bytes.
+    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
+        if offset >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`
+        // and we've just checked that the range and index is within bounds.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { &mut *self.cpu_addr.add(offset) })
+    }
+
+    /// Reads the value of `field` and ensures that its type is `FromBytes`
+    ///
+    /// # Safety:
+    ///
+    /// This must be called from the `dma_read` macro which ensures that the `field` pointer is
+    /// validated beforehand.
+    ///
+    /// Public but hidden since it should only be used from `dma_read` macro.
+    #[doc(hidden)]
+    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
+        // SAFETY: By the safety requirements field is valid
+        unsafe { field.read() }
+    }
+
+    /// Writes a value to `field` and ensures that its type is `AsBytes`
+    ///
+    /// # Safety:
+    ///
+    /// This must be called from the `dma_write` macro which ensures that the `field` pointer is
+    /// validated beforehand.
+    ///
+    /// Public but hidden since it should only be used from `dma_write` macro.
+    #[doc(hidden)]
+    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
+        // SAFETY: By the safety requirements field is valid
+        unsafe { field.write(val) }
+    }
+}
+
+/// Reads a field of an item from an allocated region of structs.
+/// # Examples
+///
+/// ```
+/// struct MyStruct { field: u32, }
+/// // SAFETY: All bit patterns are acceptable values for MyStruct.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of MyStruct have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Result {
+/// let whole = kernel::dma_read!(alloc[2]);
+/// let field = kernel::dma_read!(alloc[1].field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+macro_rules! dma_read {
+    ($dma:ident [ $idx:expr ] $($field:tt)* ) => {{
+        let item = $dma.item_from_index($idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+        // dereferenced. The compiler also further validates the expression on whether `field`
+        // is a member of `item` when expanded by the macro.
+        unsafe {
+            let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
+            $dma.field_read(ptr_field)
+        }
+    }};
+}
+
+/// Writes to a field of an item from an allocated region of structs.
+/// # Examples
+///
+/// ```
+/// struct MyStruct { member: u32, }
+/// // SAFETY: All bit patterns are acceptable values for MyStruct.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of MyStruct have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(alloc: &mut kernel::dma::CoherentAllocation<MyStruct>) -> Result {
+/// kernel::dma_write!(alloc[2].member = 0xf);
+/// kernel::dma_write!(alloc[1] = MyStruct { member: 0xf });
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+macro_rules! dma_write {
+    ($dma:ident [ $idx:expr ] $($field:tt)*) => {{
+        kernel::dma_write!($dma, $idx, $($field)*);
+    }};
+    ($dma:ident, $idx: expr, = $val:expr) => {
+        let item = $dma.item_from_index($idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid item.
+        unsafe { $dma.field_write(item, $val) }
+    };
+    ($dma:ident, $idx: expr, $(.$field:ident)* = $val:expr) => {
+        let item = $dma.item_from_index($idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+        // dereferenced. The compiler also further validates the expression on whether `field`
+        // is a member of `item` when expanded by the macro.
+        unsafe {
+            let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
+            $dma.field_write(ptr_field, $val)
+        }
+    };
+}
+
+impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+        // SAFETY: the device, cpu address, and the dma handle is valid due to the
+        // type invariants on `CoherentAllocation`.
+        unsafe {
+            bindings::dma_free_attrs(
+                self.dev.as_raw(),
+                size,
+                self.cpu_addr as _,
+                self.dma_handle,
+                self.dma_attrs.as_raw(),
+            )
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911..5081cb66b2f9 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@
 pub mod device;
 pub mod device_id;
 pub mod devres;
+pub mod dma;
 pub mod driver;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
-- 
2.43.0


