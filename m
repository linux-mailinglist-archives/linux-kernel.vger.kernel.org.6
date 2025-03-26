Return-Path: <linux-kernel+bounces-577208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A8A719DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111AA16B3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542471DD539;
	Wed, 26 Mar 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="eoAYedic"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC5A48;
	Wed, 26 Mar 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001530; cv=pass; b=IDvexhI58/HwhXAa9YazZ/99y/grEW/CSiqthxLCS9Wz/+oMQSgSDnOQI00EdFo4KQuafWSYjtIQvrrgO8i7OnKxFYOmLy4Lrauzbw32XvtJvQbvXa9kyb/KHgdVH1rZiQ7ZDArElojVrDMGSd6zNsI7qmpZ+DmSw6kLcK+CZ54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001530; c=relaxed/simple;
	bh=2q4JxDjiy3Ujqz3lguxq7IciseIAcirPjJ3BzlBYIOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qZ2WNO9RDgY+HcobPMAFqzpfZyUy2uAXsnCxPITecLZDrGyBqwRS68M0WCasOYgy1byWykU18qPZOB1QazmgFyAy7VlJZThbcBdANMu/lbERebr4fcCQV7VpBlMKTWuc/zAamifcSmhhZuVJU9Gbox0BFxAa4/KI5C/bjx1+YeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=eoAYedic; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743001504; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ht7yDB54IGQnIE+QxPz9BJ8kiUOVNqD+B51G1XFhZOmy2XbDAF2IncPinEp6QCMRUhA0T/VX+eTdDSyB1qPVRmT57qTd7Jm+DaZZk88giOp9mjCGxls5cx8opNpgCpwWtLB/qnMrZg+OYG4Dl4nFkinKpDALJmMdZ1tFRErO5Qg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743001504; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SuLDdNhVzVOYH6s7k7fTXiNz1dkVfxbFdqrAOowim8E=; 
	b=SI4E6dzvtt+f7P9AbBWdOn5O6VfhFAq15plRMgmaCHhrPBJMgV++/eaAVPNpTgEOz67fT6jNq8R8jUltR1+oboCRckS/QVklxxlbgwPtMZLpkxURnZWULYfDdD5qgLRAag4YEmgZOP03heL2akVepvlXK0SwXiS4/f8GyHlmIpA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743001504;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=SuLDdNhVzVOYH6s7k7fTXiNz1dkVfxbFdqrAOowim8E=;
	b=eoAYedicRfqjqqHQ+L9yT2WKGZdSMpFDD81+/W6MQ6/zvyUHhT+nz2LNIo7uoFEb
	UIIJ3zkuNylXF/zKSfSBq9f/1PARRZvImDkPsIFXORVnJN/9DiK8cD6O+XhAfK2Yo6m
	alOqeKkTAhQTk87lWKnWUrYXw+E68YCRQ35+41xI=
Received: by mx.zohomail.com with SMTPS id 1743001502485597.4863341988857;
	Wed, 26 Mar 2025 08:05:02 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 26 Mar 2025 12:04:42 -0300
Subject: [PATCH] rust: io_pgtable: Add io_pgtable abstraction
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-io_pgtable-v1-1-f137601987f4@collabora.com>
X-B4-Tracking: v=1; b=H4sIAIkX5GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMT3cz8+IL0ksSknFTd1JQUI9Nkw9RkAzMjJaCGgqLUtMwKsGHRsbW
 1ALqJSG5cAAAA
X-Change-ID: 20250324-io_pgtable-edd25c1ec062
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Asahi Lina <lina@asahilina.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

From: Asahi Lina <lina@asahilina.net>

The io_pgtable subsystem implements page table management for various
IOMMU page table formats. This abstraction allows Rust drivers for
devices with an embedded MMU to use this shared code.

Signed-off-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
This patch picks up the work carried out by the Asahi project for the
io_pgtable abstraction. This initial version is meant to kickstart the
discussion on this topic, as this code will also be needed by Tyr.

It's been tested on both AGX and Tyr, so the code is known to be
working.

Note that my changes so far were pretty minor:

I basically changed the format a little bit by adding a few line breaks
here and there. I also changed the docs slightly where applicable,
besides adding a few safety comments, as the previous version did not
have any. The safety comments definitely need some scrutiny, though.
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/io_pgtable.rs       | 378 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 380 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e6020ba5b00237a08402fbd609c7fba27b970dd9..c915c2d3f555eefd5411af42658c1c55a0961c08 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -23,6 +23,7 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/io-pgtable.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
 #include <linux/mdio.h>
diff --git a/rust/kernel/io_pgtable.rs b/rust/kernel/io_pgtable.rs
new file mode 100644
index 0000000000000000000000000000000000000000..a4eea5f3b9d41141044f903e21af03a15271b991
--- /dev/null
+++ b/rust/kernel/io_pgtable.rs
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IOMMU page table management.
+//!
+//! C header: [`include/io-pgtable.h`](srctree/include/linux/io-pgtable.h)
+
+use crate::bindings;
+use core::marker::PhantomData;
+use core::mem;
+use core::num::NonZeroU64;
+
+use crate::device;
+use crate::error::code::*;
+use crate::error::to_result;
+use crate::error::Result;
+use crate::types::ForeignOwnable;
+use crate::types::ScopeGuard;
+
+/// Protection flags used with IOMMU mappings.
+pub mod prot {
+    /// Read access.
+    pub const READ: u32 = bindings::IOMMU_READ;
+    /// Write access.
+    pub const WRITE: u32 = bindings::IOMMU_WRITE;
+    /// Request cache coherency.
+    pub const CACHE: u32 = bindings::IOMMU_CACHE;
+    /// Request no-execute permission.
+    pub const NOEXEC: u32 = bindings::IOMMU_NOEXEC;
+    /// MMIO peripheral mapping.
+    pub const MMIO: u32 = bindings::IOMMU_MMIO;
+    /// Privileged mapping.
+    pub const PRIV: u32 = bindings::IOMMU_PRIV;
+}
+
+/// Represents a requested io_pgtable configuration.
+pub struct Config {
+    /// Quirk bitmask (type-specific).
+    pub quirks: usize,
+    /// Valid page sizes, as a bitmask of powers of two.
+    pub pgsize_bitmap: usize,
+    /// Input address space size in bits.
+    pub ias: usize,
+    /// Output address space size in bits.
+    pub oas: usize,
+    /// IOMMU uses coherent accesses for page table walks.
+    pub coherent_walk: bool,
+}
+
+/// IOMMU callbacks for TLB and page table management.
+///
+/// Users must implement this trait to perform the TLB flush actions for this
+/// IOMMU, if required.
+pub trait FlushOps {
+    /// User-specified type owned by the IOPagetable that will be passed to TLB
+    /// operations.
+    type Data: ForeignOwnable + Send + Sync;
+
+    /// Synchronously invalidate the entire TLB context.
+    fn tlb_flush_all(data: <Self::Data as ForeignOwnable>::Borrowed<'_>);
+
+    /// Synchronously invalidate all intermediate TLB state (sometimes referred
+    /// to as the "walk cache") for a virtual address range.
+    fn tlb_flush_walk(
+        data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
+        iova: usize,
+        size: usize,
+        granule: usize,
+    );
+
+    /// Optional callback to queue up leaf TLB invalidation for a single page.
+    ///
+    /// IOMMUs that cannot batch TLB invalidation operations efficiently will
+    /// typically issue them here, but others may decide to update the
+    /// `iommu_iotlb_gather` structure and defer the invalidation until
+    /// iommu_iotlb_sync() instead.
+    ///
+    // TODO: Implement the gather argument for batching.
+    fn tlb_add_page(
+        data: <Self::Data as ForeignOwnable>::Borrowed<'_>,
+        iova: usize,
+        granule: usize,
+    );
+}
+
+/// Inner page table information that is shared across all table types.
+///
+/// # Invariants
+///
+/// - [`self.ops`] is valid and non-null.
+/// - [`self.cfg`] is valid and non-null.
+#[doc(hidden)]
+pub struct IoPageTableInner {
+    ops: *mut bindings::io_pgtable_ops,
+    cfg: bindings::io_pgtable_cfg,
+    data: *mut core::ffi::c_void,
+}
+
+/// Helper trait to get the config type for a single page table type from the union.
+pub trait GetConfig {
+    /// Returns the specific output configuration for this page table type.
+    fn cfg(iopt: &impl IoPageTable) -> &Self
+    where
+        Self: Sized;
+}
+
+/// A generic IOMMU page table
+pub trait IoPageTable: crate::private::Sealed {
+    #[doc(hidden)]
+    const FLUSH_OPS: bindings::iommu_flush_ops;
+
+    #[doc(hidden)]
+    fn new_fmt<T: FlushOps>(
+        dev: &device::Device,
+        format: u32,
+        config: Config,
+        data: T::Data,
+    ) -> Result<IoPageTableInner> {
+        let ptr = data.into_foreign() as *mut _;
+
+        let guard = ScopeGuard::new(|| {
+            // SAFETY: `ptr` came from a previous call to `into_foreign`.
+            unsafe { T::Data::from_foreign(ptr) };
+        });
+
+        // SAFETY: this type was manually checked to be valid to zero-initialize.
+        let __bindgen_anon_1 = unsafe { mem::zeroed() };
+
+        let mut raw_cfg = bindings::io_pgtable_cfg {
+            quirks: config.quirks,
+            pgsize_bitmap: config.pgsize_bitmap,
+            ias: config.ias.try_into()?,
+            oas: config.oas.try_into()?,
+            coherent_walk: config.coherent_walk,
+            tlb: &Self::FLUSH_OPS,
+            iommu_dev: dev.as_raw(),
+            alloc: None,
+            free: None,
+            __bindgen_anon_1,
+        };
+
+        // SAFETY: there are no specific safety requirements for this call. We
+        // simply make sure that all the arguments are valid.
+        let ops = unsafe {
+            bindings::alloc_io_pgtable_ops(format as bindings::io_pgtable_fmt, &mut raw_cfg, ptr)
+        };
+
+        if ops.is_null() {
+            return Err(EINVAL);
+        }
+
+        guard.dismiss();
+
+        Ok(IoPageTableInner {
+            ops,
+            cfg: raw_cfg,
+            data: ptr,
+        })
+    }
+
+    /// Map a range of pages.
+    fn map_pages(
+        &mut self,
+        iova: usize,
+        paddr: usize,
+        pgsize: usize,
+        pgcount: usize,
+        prot: u32,
+    ) -> Result<usize> {
+        let mut mapped: usize = 0;
+
+        // SAFETY: Just a FFI call with no particular safety requirements.
+        // Additionally, we know that `self.ops` is valid as per the invariant.
+        to_result(unsafe {
+            (*self.inner_mut().ops).map_pages.unwrap()(
+                self.inner_mut().ops,
+                iova,
+                paddr as u64,
+                pgsize,
+                pgcount,
+                prot as i32,
+                bindings::GFP_KERNEL,
+                &mut mapped,
+            )
+        })?;
+
+        Ok(mapped)
+    }
+
+    /// Unmap a range of pages.
+    fn unmap_pages(
+        &mut self,
+        iova: usize,
+        pgsize: usize,
+        pgcount: usize,
+        // TODO: gather: *mut iommu_iotlb_gather,
+    ) -> usize {
+        // SAFETY: Just a FFI call with no particular safety requirements.
+        // Additionally, we know that `self.ops` is valid as per the invariant.
+        unsafe {
+            (*self.inner_mut().ops).unmap_pages.unwrap()(
+                self.inner_mut().ops,
+                iova,
+                pgsize,
+                pgcount,
+                core::ptr::null_mut(),
+            )
+        }
+    }
+
+    /// Translate an IOVA to the corresponding physical address, if mapped.
+    fn iova_to_phys(&mut self, iova: usize) -> Option<NonZeroU64> {
+        // SAFETY: Just a FFI call with no particular safety requirements.
+        // Additionally, we know that `self.ops` is valid as per the invariant.
+        let iova_to_phys =
+            unsafe { (*self.inner_mut().ops).iova_to_phys.unwrap()(self.inner_mut().ops, iova) };
+
+        NonZeroU64::new(iova_to_phys)
+    }
+
+    #[doc(hidden)]
+    fn inner_mut(&mut self) -> &mut IoPageTableInner;
+
+    #[doc(hidden)]
+    fn inner(&self) -> &IoPageTableInner;
+
+    #[doc(hidden)]
+    fn raw_cfg(&self) -> &bindings::io_pgtable_cfg {
+        &self.inner().cfg
+    }
+}
+
+/// # Safety
+///
+/// This function is only safe to be called by the IOMMU C code.
+unsafe extern "C" fn tlb_flush_all_callback<T: FlushOps>(cookie: *mut core::ffi::c_void) {
+    // SAFETY:
+    //
+    // - `cookie` was passed to `into_foreign()` in `IoPageTable::new_fmt`.
+    // - We do not overlap with any call to borrow() or borrow_mut().
+    T::tlb_flush_all(unsafe { T::Data::borrow(cookie) });
+}
+
+/// # Safety
+///
+/// This function is only safe to be called by the IOMMU C code.
+unsafe extern "C" fn tlb_flush_walk_callback<T: FlushOps>(
+    iova: usize,
+    size: usize,
+    granule: usize,
+    cookie: *mut core::ffi::c_void,
+) {
+    // SAFETY:
+    //
+    // - `cookie` was passed to `into_foreign()` in `IoPageTable::new_fmt`.
+    // - We do not overlap with any call to borrow() or borrow_mut().
+    T::tlb_flush_walk(unsafe { T::Data::borrow(cookie) }, iova, size, granule);
+}
+
+/// # Safety
+///
+/// This function is only safe to be called by the IOMMU C code.
+unsafe extern "C" fn tlb_add_page_callback<T: FlushOps>(
+    _gather: *mut bindings::iommu_iotlb_gather,
+    iova: usize,
+    granule: usize,
+    cookie: *mut core::ffi::c_void,
+) {
+    // SAFETY:
+    //
+    // - `cookie` was passed to `into_foreign()` in `IoPageTable::new_fmt`.
+    // - We do not overlap with any call to borrow() or borrow_mut().
+    T::tlb_add_page(unsafe { T::Data::borrow(cookie) }, iova, granule);
+}
+
+macro_rules! iopt_cfg {
+    ($name:ident, $field:ident, $type:ident) => {
+        /// An IOMMU page table configuration for a specific kind of pagetable.
+        pub type $name = bindings::$type;
+
+        impl GetConfig for $name {
+            fn cfg(iopt: &impl IoPageTable) -> &$name {
+                // SAFETY: The very purpose of this macro is to provide a safe
+                // way to access the field by implementing GetConfig for a
+                // particular type.
+                unsafe { &iopt.raw_cfg().__bindgen_anon_1.$field }
+            }
+        }
+    };
+}
+
+macro_rules! iopt_type {
+    ($type:ident, $cfg:ty, $fmt:ident) => {
+        /// Represents an IOPagetable of this type.
+        pub struct $type<T: FlushOps>(IoPageTableInner, PhantomData<T>);
+
+        impl<T: FlushOps> $type<T> {
+            /// Creates a new IOPagetable implementation of this type.
+            pub fn new(dev: &device::Device, config: Config, data: T::Data) -> Result<Self> {
+                Ok(Self(
+                    <Self as IoPageTable>::new_fmt::<T>(dev, bindings::$fmt, config, data)?,
+                    PhantomData,
+                ))
+            }
+
+            /// Get the configuration for this IOPagetable.
+            pub fn cfg(&self) -> &$cfg {
+                <$cfg as GetConfig>::cfg(self)
+            }
+        }
+
+        impl<T: FlushOps> crate::private::Sealed for $type<T> {}
+
+        impl<T: FlushOps> IoPageTable for $type<T> {
+            const FLUSH_OPS: bindings::iommu_flush_ops = bindings::iommu_flush_ops {
+                tlb_flush_all: Some(tlb_flush_all_callback::<T>),
+                tlb_flush_walk: Some(tlb_flush_walk_callback::<T>),
+                tlb_add_page: Some(tlb_add_page_callback::<T>),
+            };
+
+            fn inner(&self) -> &IoPageTableInner {
+                &self.0
+            }
+
+            fn inner_mut(&mut self) -> &mut IoPageTableInner {
+                &mut self.0
+            }
+        }
+
+        impl<T: FlushOps> Drop for $type<T> {
+            fn drop(&mut self) {
+                // SAFETY: The pointer is valid by the type invariant.
+                unsafe { bindings::free_io_pgtable_ops(self.0.ops) };
+
+                // Free context data.
+                //
+                // SAFETY: This matches the call to `into_foreign` from `new` in the success case.
+                unsafe { T::Data::from_foreign(self.0.data) };
+            }
+        }
+    };
+}
+
+iopt_cfg!(
+    ARMLPAES1Cfg,
+    arm_lpae_s1_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_1
+);
+iopt_cfg!(
+    ARMLPAES2Cfg,
+    arm_lpae_s2_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_2
+);
+iopt_cfg!(
+    ARMv7SCfg,
+    arm_v7s_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_3
+);
+iopt_cfg!(
+    ARMMaliLPAECfg,
+    arm_mali_lpae_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_4
+);
+iopt_cfg!(
+    AppleDARTCfg,
+    apple_dart_cfg,
+    io_pgtable_cfg__bindgen_ty_1__bindgen_ty_5
+);
+iopt_cfg!(AmdCfg, amd, io_pgtable_cfg__bindgen_ty_1__bindgen_ty_6);
+
+iopt_type!(ARM32LPAES1, ARMLPAES1Cfg, io_pgtable_fmt_ARM_32_LPAE_S1);
+iopt_type!(ARM32LPAES2, ARMLPAES2Cfg, io_pgtable_fmt_ARM_32_LPAE_S2);
+iopt_type!(ARM64LPAES1, ARMLPAES1Cfg, io_pgtable_fmt_ARM_64_LPAE_S1);
+iopt_type!(ARM64LPAES2, ARMLPAES2Cfg, io_pgtable_fmt_ARM_64_LPAE_S2);
+iopt_type!(ARMv7S, ARMv7SCfg, io_pgtable_fmt_ARM_V7S);
+iopt_type!(ARMMaliLPAE, ARMMaliLPAECfg, io_pgtable_fmt_ARM_MALI_LPAE);
+iopt_type!(AMDIOMMUV1, AmdCfg, io_pgtable_fmt_AMD_IOMMU_V1);
+iopt_type!(AppleDART, AppleDARTCfg, io_pgtable_fmt_APPLE_DART);
+iopt_type!(AppleDART2, AppleDARTCfg, io_pgtable_fmt_APPLE_DART2);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b820a06f7d47517b5f02691cf3f3c357c703bb58..2e199e70efff467d8fce534d7345e853fbf5278a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -56,6 +56,7 @@
 pub mod fs;
 pub mod init;
 pub mod io;
+pub mod io_pgtable;
 pub mod ioctl;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]

---
base-commit: 10f0d552100e48972251a2d081104c8f437ab54e
change-id: 20250324-io_pgtable-edd25c1ec062

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


