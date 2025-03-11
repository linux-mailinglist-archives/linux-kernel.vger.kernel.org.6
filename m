Return-Path: <linux-kernel+bounces-556635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A05A5CCB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571A73B996B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7661EDA27;
	Tue, 11 Mar 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPDJtrVe"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2F262D11;
	Tue, 11 Mar 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715391; cv=none; b=tQjc9ESPAPny/qOgN0h6iae7I5xYI08wUBnXJp8GFsjCFierp6m2lORwYzuR83v037A3u0nWC4Xhefl6H3yIVHQWuEm2/1FNtmtMEzEoSwcFFXtpa+f2oU2YoM+MTbF6wvc/Sci49jFEukSyIDDImZW7bUwSrM50kTSK8+57Sfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715391; c=relaxed/simple;
	bh=jd3pjpbP3u0XG/zQ4FkolYGa8M3aLwzwOJdwsZPxFh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcToMNEvE1eWZMLZtZLQOiX9fof1ENWAZLHxAjtFXHHOgS5vPEFMJ+WX/eTZSwC9FNOjkQcX/JwLxvLVH8sUXjv99F7QWdF/O9Aj1QydmePfDrD4QsM1SoczGcz40oRN0+xltCWxtVPLdiSyXo8U9LOtkviEW3l7KA0+SqCSFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPDJtrVe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54954fa61c9so6647078e87.1;
        Tue, 11 Mar 2025 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715387; x=1742320187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26ftVVDMFL7fcXox6xAbGSeaOBehXNbtEaGLInHmYME=;
        b=WPDJtrVeUuNwwmjqPoQth3bTig28Q0wkWZA4vSHEH9UIUu2eZVgKE5JU8S6ZAzWaPV
         8NHj4W+CZ/5TLAVWmfWZ46hm7M6WY5rDzFUQrCMKFZYsfZqkNBg/lxKjYShyKWRptnCm
         t6av4U3C4HVrHPqsJUkbopTnP9Cd/3+BUipDC6JAleBHyRqOq3n89YmrcJ2/hRTfyKC5
         tvsbwi1wTqy1wng4LVPNJmvRnQ9QyiZ8wZQgt5g3tS7L+ERHEIRBlG6ARLfb17eBVvPS
         ot+Kp64mnPU7gVxV44FmJfV60lSuaPebtdFAug+jX48o1H0lU6Cn6M13oJDpEOt93afG
         wl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715387; x=1742320187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26ftVVDMFL7fcXox6xAbGSeaOBehXNbtEaGLInHmYME=;
        b=By2evI0VlnW/TJsJOiye0EsTyrc5XY2t9Q93g7F74e8rvODDOJ6qGOCt/iVRLIsm5F
         XD1U3Dow/cniWBWqjhY+WiN8N66x99v0gRi0vel0K2IZHJ90ndn7CjI3e8u9V3kdYcDF
         ByEVo1r57EbV+Tj7Hyx0m1+iZVEpx8/jpvXcBiVI+To3JXyVslfxzqQqZWXY565hClum
         lB5nTSSE7rrDkvZZH78rgnIfP5jGI9bRxHoGhC16KDHf3EtEsUSDIfAOqRXpE3egC4lK
         ULO6ylIhbk2444e6MtjnnOJfvfoo6ZgTrH2VCLQg/uAfNfHvkXapTy6jdf30ENP0jAgX
         owAw==
X-Forwarded-Encrypted: i=1; AJvYcCXel/MZwSnXtgUwAqdKeIIvaOQ0SQKpOnrXpeeE8C+ST97qXf8sVq9Adid91e7bEF0272rHQZrneuF2RYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5V9+CR8/MHHBOt3oepmD0RSn4BK9mhXodZ+lRyT4vY1aa5Hv
	pWGxCBLwnkU7tNxDvO+haNEqpaMXFpO9WQdSOOifXsK/njzspLZ7vVTBEw==
X-Gm-Gg: ASbGnctY0b54pOrW76y95cLCq76tc/aqa0IzPlZd+kOHmVplkhG+p0aiVHPQVV4WQbd
	OCn74JbY+24UYcwnv6Fnt/dfrvsQyzAu74KwTdsG3c+5MOf+4PvTt/8PKgT73mcryoq/62eJy+o
	RHhkG0PdvI/oCTq72LQ5la665eFNOUetH/Vv5YnPRkQnAKmj5P05JMHy7iYVwrj0pY226GkDGSG
	2YbuZvhXb0t5TWFBSLzTk/s7i0PeyuTVstR1tF9/gd27FxkGAl1Y2yJcE7iYOUarpy4U8+IuIE0
	gBgHQjmUqLrWIMWws9r5BzqQwTwNRCI+ZS5B/jzJiMS/u+/Wc2g5OYiLFqolgq06N6yMujA8BOg
	VXzERcr9h3K8r9QZBzt5QQQ==
X-Google-Smtp-Source: AGHT+IHqacWmh9GZ5CrLIUXFLsz7r4MoxfnCF7V5Kr8h01h0vocdacx2/ekktKa08qJT/2OUlLaXdA==
X-Received: by 2002:a05:6512:1598:b0:549:8d67:c48e with SMTP id 2adb3069b0e04-54990e673a2mr5712430e87.29.1741715387053;
        Tue, 11 Mar 2025 10:49:47 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:45 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
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
Subject: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
Date: Tue, 11 Mar 2025 19:47:58 +0200
Message-ID: <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 369 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 371 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae39fc18a8bf..ccb988340df6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
+#include <linux/dma-mapping.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..325b00fe7871
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,369 @@
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
+/// Possible attributes associated with a DMA mapping.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`attrs`] module.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::device::Device;
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// # fn test(dev: &Device) -> Result {
+/// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
+/// let c: CoherentAllocation<u64> =
+///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
+/// # Ok::<(), Error>(()) }
+/// ```
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
+/// DMA mapping attributes.
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
+/// For the lifetime of an instance of [`CoherentAllocation`], the `cpu_addr` is a valid pointer
+/// to an allocated region of consistent memory and `dma_handle` is the DMA address base of
+/// the region.
+// TODO
+//
+// DMA allocations potentially carry device resources (e.g.IOMMU mappings), hence for soundness
+// reasons DMA allocation would need to be embedded in a `Devres` container, in order to ensure
+// that device resources can never survive device unbind.
+//
+// However, it is neither desirable nor necessary to protect the allocated memory of the DMA
+// allocation from surviving device unbind; it would require RCU read side critical sections to
+// access the memory, which may require subsequent unnecessary copies.
+//
+// Hence, find a way to revoke the device resources of a `CoherentAllocation`, but not the
+// entire `CoherentAllocation` including the allocated memory itself.
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
+    /// let c: CoherentAllocation<u64> =
+    ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn alloc_attrs(
+        dev: &Device,
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
+        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
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
+            dev: dev.into(),
+            dma_handle,
+            count,
+            cpu_addr: ret as *mut T,
+            dma_attrs,
+        })
+    }
+
+    /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
+    /// `dma_attrs` is 0 by default.
+    pub fn alloc_coherent(
+        dev: &Device,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
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
+    /// Returns a pointer to an element from the region with bounds checking. `offset` is in
+    /// units of `T`, not the number of bytes.
+    ///
+    /// Public but hidden since it should only be used from [`dma_read`] and [`dma_write`] macros.
+    #[doc(hidden)]
+    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
+        if offset >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`
+        // and we've just checked that the range and index is within bounds.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { self.cpu_addr.add(offset) })
+    }
+
+    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
+    ///
+    /// # Safety
+    ///
+    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
+    /// validated beforehand.
+    ///
+    /// Public but hidden since it should only be used from [`dma_read`] macro.
+    #[doc(hidden)]
+    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
+        // SAFETY: By the safety requirements field is valid.
+        unsafe { field.read_volatile() }
+    }
+
+    /// Writes a value to `field` and ensures that its type is [`AsBytes`].
+    ///
+    /// # Safety
+    ///
+    /// This must be called from the [`dma_write`] macro which ensures that the `field` pointer is
+    /// validated beforehand.
+    ///
+    /// Public but hidden since it should only be used from [`dma_write`] macro.
+    #[doc(hidden)]
+    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
+        // SAFETY: By the safety requirements field is valid.
+        unsafe { field.write_volatile(val) }
+    }
+}
+
+/// Note that the device configured to do DMA must be halted before this object is dropped.
+impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
+        // The cpu address, and the dma handle are valid due to the type invariants on
+        // `CoherentAllocation`.
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
+
+/// Reads a field of an item from an allocated region of structs.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::device::Device;
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// struct MyStruct { field: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Result {
+/// let whole = kernel::dma_read!(alloc[2]);
+/// let field = kernel::dma_read!(alloc[1].field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+macro_rules! dma_read {
+    ($dma:expr, $idx: expr, $($field:tt)*) => {{
+        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+        // dereferenced. The compiler also further validates the expression on whether `field`
+        // is a member of `item` when expanded by the macro.
+        unsafe {
+            let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
+            $crate::dma::CoherentAllocation::field_read(&$dma, ptr_field)
+        }
+    }};
+    ($dma:ident [ $idx:expr ] $($field:tt)* ) => {
+        $crate::dma_read!($dma, $idx, $($field)*);
+    };
+    ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {
+        $crate::dma_read!($($dma).*, $idx, $($field)*);
+    };
+}
+
+/// Writes to a field of an item from an allocated region of structs.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::device::Device;
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// struct MyStruct { member: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Result {
+/// kernel::dma_write!(alloc[2].member = 0xf);
+/// kernel::dma_write!(alloc[1] = MyStruct { member: 0xf });
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+macro_rules! dma_write {
+    ($dma:ident [ $idx:expr ] $($field:tt)*) => {{
+        $crate::dma_write!($dma, $idx, $($field)*);
+    }};
+    ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {{
+        $crate::dma_write!($($dma).*, $idx, $($field)*);
+    }};
+    ($dma:expr, $idx: expr, = $val:expr) => {
+        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid item.
+        unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+    };
+    ($dma:expr, $idx: expr, $(.$field:ident)* = $val:expr) => {
+        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+        // dereferenced. The compiler also further validates the expression on whether `field`
+        // is a member of `item` when expanded by the macro.
+        unsafe {
+            let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
+            $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
+        }
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..8e76ef9b4346 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@
 pub mod device;
 pub mod device_id;
 pub mod devres;
+pub mod dma;
 pub mod driver;
 pub mod error;
 pub mod faux;
-- 
2.43.0


