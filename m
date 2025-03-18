Return-Path: <linux-kernel+bounces-566099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D75A6732B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E351892040
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2013D20B813;
	Tue, 18 Mar 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pL5cjBGx"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035920B804
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298722; cv=none; b=pZk/wde3dxDcBy+LlG/JodLvwx10y+81KWlsHnf7jrK0ZOOsv32Kuf22zYjMTFWgiP26u7AN1ZWlsMtOkM4FOWQUODiCoS7KQ83ep1mpt+ZnNX3WnHCxcZ4a3oOtKaG8iV/Rp3SH5kAD38JIn27l6kgrvtlgIC5I21kLFdIxczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298722; c=relaxed/simple;
	bh=ttLg1HcNgivrHUeqtU7AhquQvYl8brGHnJxkRRBE7Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdK15WbimmRkZFWcDgWiRzIY1T2sxtdBICl6WEgRIQ5NNzGJ5GR4t1bHvvNw9yUQJlORlfkmC+nHGMmmdSR836U8jGGxm7Yc56BBg7ANbLPHRpF69c5H9ZaM51df8TWQjLiNIsnchckk4ApiQfFDDCEdYnoQ40Lh+IUCvRZY/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pL5cjBGx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so7172367a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742298719; x=1742903519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNOUGdwWfStaer+R9sgUtj4YnrPxUBt4w24A0vjSOrs=;
        b=pL5cjBGx1iLBSKjG8oGcSY6ckhLfbJxD16CO/n8NpLzfddayEfUJbLVd8BvN6FIkB6
         8ps802mydXwRpF0yGbdaRXthjt/tuX2lE6HyebAyrzGV60cNsch65azOIIdBdRQY7jSO
         6XHtub6A5DA8k5FQesAhukN04K9GHqwzyiup+r9milPjRVFCZww6uVYBv+UreE06dHV/
         1TzCgjTMRzsoy7fcMLufd/1sCqCITkYrDSDRwp6s8/JBJvFoBQvbmpoAJoI3BIVTxhfr
         KUzKBiKAwT4Hka2gQPDCCivPv64iodjs+C0zfQf+/NnBlIUFyk8uTsR4aXhOVEngFZb/
         EEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742298719; x=1742903519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNOUGdwWfStaer+R9sgUtj4YnrPxUBt4w24A0vjSOrs=;
        b=t9Z6DHlp7IMd62qCd4iVBE04flEcyTISUAwnIC3jsqY4+VnwUbs0ykFoeP78+rmDm7
         bVIVTeKxDSZ1wt6OevdiEYs8ySDXw6tPAJZRpwZQcojwl7D+8Tp96lnq+TxJ4eipTHLX
         FwDIRSD4+w1vzZWyO9UpkJVS7hYOzzS4DC6nfTHXsx0LuDK/c/oOAkDn+zyjgATNYTVO
         UCHQJ1lEEiB68gy1pTDxVOV0whyOhyGJ84JFeeZaIJIq9saPfHOstNGEXYCdxXBrfk8s
         mdlN8iWg4Asn6UK59RehF36JzzaLdOSZ1iWx+3b5Nn025OX9L8t4IH991wp2vgPk1fDG
         iBGQ==
X-Gm-Message-State: AOJu0YwraVJ+b5M6vUbPuzjZTVEY0aCsB0oAJE3Yxxb6MEn1++j+45e5
	tve+60WJXAw+iFg/EJOj6ZwqO/WnVvtTVB8b5h0FJg8stsscHM9TtAwuEJlgsCQ=
X-Gm-Gg: ASbGncuK69ujiSC1yIUgRPlRC+XbSurFcLYSAIlJ0jxe9FMWH4a2SMuJ1LTzNmDDa+B
	CQ/OWuvqDQ7Xorg7FIZU3sqmz4NCeOujbZp6ztfHP5jsMfjyZ3CUBKNMDGiiV/VlsggpOzgL2Tf
	hczr3tOOZocCWG3rykLgUXlLwHvPTf82jD6l/YAEKDScoNXFpr3fD1nKe9zHbc2zzugMOgic5ue
	nf0HYaxChj6TNUIdXISDNwHLFdwiFI+5ue43Hz0YCd8uiyPszIUIDfxT5u1Resv65lBwYDh6rGU
	dwnhB2wjtJkohPRWgalCe25+HuxL3tyy+jWLE3t5AzWnzA==
X-Google-Smtp-Source: AGHT+IEV6HtbHKCtLxYsB3S8bmj6xLyKom5g9WwzQ3kEhzrx3eWV1nUIew8PIeczWHCb2oWHCEbWgg==
X-Received: by 2002:a17:90b:38c3:b0:2fe:a515:4a98 with SMTP id 98e67ed59e1d1-301a5b9a996mr2170402a91.31.1742298719487;
        Tue, 18 Mar 2025 04:51:59 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3d45sm92296075ad.220.2025.03.18.04.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:51:59 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Burak Emir <bqe@google.com>
Subject: [PATCH V3 1/2] rust: Add initial cpumask abstractions
Date: Tue, 18 Mar 2025 17:21:49 +0530
Message-Id: <f8571484dde65e93247e51e41556aeb765c5cf6e.1742296835.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1742296835.git.viresh.kumar@linaro.org>
References: <cover.1742296835.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial Rust abstractions for struct cpumask, covering a subset of
its APIs. Additional APIs can be added as needed.

These abstractions will be used in upcoming Rust support for cpufreq and
OPP frameworks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpumask.rs | 301 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 2 files changed, 302 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
new file mode 100644
index 000000000000..792210a77770
--- /dev/null
+++ b/rust/kernel/cpumask.rs
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU Mask abstractions.
+//!
+//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
+
+use crate::{
+    alloc::{AllocError, Flags},
+    bindings,
+    prelude::*,
+    types::Opaque,
+};
+
+#[cfg(CONFIG_CPUMASK_OFFSTACK)]
+use core::ptr::{self, NonNull};
+
+#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+use core::mem::MaybeUninit;
+
+use core::ops::{Deref, DerefMut};
+
+/// A CPU Mask.
+///
+/// This represents the Rust abstraction for the C `struct cpumask`.
+///
+/// # Invariants
+///
+/// A [`Cpumask`] instance always corresponds to a valid C `struct cpumask`.
+///
+/// The callers must ensure that the `struct cpumask` is valid for access and remains valid for the
+/// lifetime of the returned reference.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to update a [`Cpumask`].
+///
+/// ```
+/// use kernel::bindings;
+/// use kernel::cpumask::Cpumask;
+///
+/// fn set_clear_cpu(ptr: *mut bindings::cpumask, set_cpu: u32, clear_cpu: i32) {
+///     // SAFETY: The `ptr` is valid for writing and remains valid for the lifetime of the
+///     // returned reference.
+///     let mask = unsafe { Cpumask::from_raw_mut(ptr) };
+///     mask.set(set_cpu);
+///     mask.clear(clear_cpu);
+/// }
+/// ```
+#[repr(transparent)]
+pub struct Cpumask(Opaque<bindings::cpumask>);
+
+impl Cpumask {
+    /// Creates a mutable reference to an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask) -> &'a mut Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Creates a reference to an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Obtain the raw `struct cpumask` pointer.
+    pub fn as_raw(&self) -> *mut bindings::cpumask {
+        self as *const Cpumask as *mut bindings::cpumask
+    }
+
+    /// Set `cpu` in the cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_set_cpu` API.
+    #[inline]
+    pub fn set(&mut self, cpu: u32) {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_set_cpus`.
+        unsafe { bindings::cpumask_set_cpu(cpu, self.as_raw()) };
+    }
+
+    /// Clear `cpu` in the cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_clear_cpu` API.
+    #[inline]
+    pub fn clear(&mut self, cpu: i32) {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_clear_cpu`.
+        unsafe { bindings::cpumask_clear_cpu(cpu, self.as_raw()) };
+    }
+
+    /// Set all CPUs in the cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_setall` API.
+    #[inline]
+    pub fn set_all(&mut self) {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_setall`.
+        unsafe { bindings::cpumask_setall(self.as_raw()) };
+    }
+
+    /// Get weight of the cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_weight` API.
+    #[inline]
+    pub fn weight(&self) -> u32 {
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_weight`.
+        unsafe { bindings::cpumask_weight(self.as_raw()) }
+    }
+
+    /// Copy cpumask.
+    ///
+    /// Equivalent to the kernel's `cpumask_copy` API.
+    #[inline]
+    pub fn copy(&self, dstp: &mut Self) {
+        // SAFETY: By the type invariant, `Self::as_raw` is a valid argument to `cpumask_copy`.
+        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.as_raw()) };
+    }
+}
+
+/// A CPU Mask pointer.
+///
+/// This represents the Rust abstraction for the C `struct cpumask_var_t`.
+///
+/// # Invariants
+///
+/// A [`CpumaskBox`] instance always corresponds to a valid C `struct cpumask_var_t`.
+///
+/// The callers must ensure that the `struct cpumask_var_t` is valid for access and remains valid
+/// for the lifetime of [`CpumaskBox`].
+///
+/// ## Examples
+///
+/// The following example demonstrates how to create and update a [`CpumaskBox`].
+///
+/// ```
+/// use kernel::cpumask::CpumaskBox;
+/// use kernel::error::Result;
+///
+/// fn cpumask_foo() -> Result {
+///     let mut mask = CpumaskBox::new(GFP_KERNEL)?;
+///
+///     assert_eq!(mask.weight(), 0);
+///     mask.set(2);
+///     assert_eq!(mask.weight(), 1);
+///     mask.set(3);
+///     assert_eq!(mask.weight(), 2);
+///
+///     let mask2 = CpumaskBox::try_clone(&mask)?;
+///     assert_eq!(mask2.weight(), 2);
+///
+///     Ok(())
+/// }
+/// ```
+pub struct CpumaskBox {
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    ptr: NonNull<Cpumask>,
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    mask: Cpumask,
+}
+
+impl CpumaskBox {
+    /// Creates an initialized instance of the [`CpumaskBox`].
+    pub fn new(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
+                // that, it is always safe to call this method.
+                //
+                // INVARIANT: The associated memory is freed when the `CpumaskBox` goes out of
+                // scope.
+                unsafe { bindings::zalloc_cpumask_var(&mut ptr, _flags.as_raw()) };
+                NonNull::new(ptr.cast()).ok_or(AllocError)?
+            },
+
+            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+            // SAFETY: FFI type is valid to be zero-initialized.
+            //
+            // INVARIANT: The associated memory is freed when the `CpumaskBox` goes out of scope.
+            mask: unsafe { core::mem::zeroed() },
+        })
+    }
+
+    /// Creates an uninitialized instance of the [`CpumaskBox`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the returned [`CpumaskBox`] is properly initialized before
+    /// getting used.
+    unsafe fn new_uninit(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
+                // that, it is always safe to call this method.
+                //
+                // INVARIANT: The associated memory is freed when the `CpumaskBox` goes out of
+                // scope.
+                unsafe { bindings::alloc_cpumask_var(&mut ptr, _flags.as_raw()) };
+                NonNull::new(ptr.cast()).ok_or(AllocError)?
+            },
+            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+            // SAFETY: Guaranteed by the safety requirements of the function.
+            //
+            // INVARIANT: The associated memory is freed when the `CpumaskBox` goes out of scope.
+            mask: unsafe { MaybeUninit::uninit().assume_init() },
+        })
+    }
+
+    /// Creates a mutable reference to an existing `struct cpumask_var_t` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Creates a reference to an existing `struct cpumask_var_t` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Clones cpumask.
+    pub fn try_clone(cpumask: &Cpumask) -> Result<Self> {
+        // SAFETY: The returned cpumask_box is initialized right after this call.
+        let mut cpumask_box = unsafe { Self::new_uninit(GFP_KERNEL) }?;
+
+        cpumask.copy(&mut cpumask_box);
+        Ok(cpumask_box)
+    }
+}
+
+// Make [`CpumaskBox`] behave like a pointer to [`Cpumask`].
+impl Deref for CpumaskBox {
+    type Target = Cpumask;
+
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    fn deref(&self) -> &Cpumask {
+        // SAFETY: The caller owns CpumaskBox, so it is safe to deref the cpumask.
+        unsafe { &*self.ptr.as_ptr() }
+    }
+
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    fn deref(&self) -> &Cpumask {
+        &self.mask
+    }
+}
+
+impl DerefMut for CpumaskBox {
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    fn deref_mut(&mut self) -> &mut Cpumask {
+        // SAFETY: The caller owns CpumaskBox, so it is safe to deref the cpumask.
+        unsafe { self.ptr.as_mut() }
+    }
+
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    fn deref_mut(&mut self) -> &mut Cpumask {
+        &mut self.mask
+    }
+}
+
+impl Drop for CpumaskBox {
+    fn drop(&mut self) {
+        #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+        // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `free_cpumask_var`.
+        unsafe {
+            bindings::free_cpumask_var(self.as_raw())
+        };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..dbed774ea9f7 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+pub mod cpumask;
 pub mod cred;
 pub mod device;
 pub mod device_id;
-- 
2.31.1.272.g89b43f80a514


