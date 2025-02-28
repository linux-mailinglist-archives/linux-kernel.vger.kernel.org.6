Return-Path: <linux-kernel+bounces-537926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE02A4928A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC773B7D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B901D6DDA;
	Fri, 28 Feb 2025 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lC3ZxU/X"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CF1D5142
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729423; cv=none; b=gNVi75bFbAlCmK/OK7lIiklTroVmO7aV9tJQBoSXth8Al8Idu+p3IA0o6N31+fKM7WP/pmBKBxmABgp3foGb31u896K4DhFV9KsEK1TDPwjPXHBzlsDQ4014YxLsqhUHwWUw+9Lw8AX5ovADZASIhKI2lffuB8HWJRo75lg7afQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729423; c=relaxed/simple;
	bh=qvK8BkIlayAY6sFfbEtehnI9fC2UnVXJpB1r8axuCaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N85greoFt+Ag/jSGjZH0M9SYQlFOT9hE13c+7oQN2NKCFclcPLMLWCfLtOIr7JnBe1Vuesp5/qmDlkRr+lHH0JqfFtEvTmoZHff6EssJwF4oBrzn3wwxG++K6chb8l1s9nh2/r4DY41t/nkBzPTV5xTwdOce4ic4FzMIEbEX1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lC3ZxU/X; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22339936bbfso28470705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740729421; x=1741334221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HA6Wf119PGC9oGEZOgYc8tQj/1OTKZ0Ld6gp+7XSOI=;
        b=lC3ZxU/XBiA/DTGDp6YmyFTlBRuadSENRMMFeBKAw4VjoqB3JqoVqZ2/55ZSAKy8wv
         tjFakVaBrVCv5WPsVY7Ojw/IStOdexyi4m8+MohIergT/g/MljX0iWlKVvcRaajfDtye
         s+C0zTqRpzByVG9VBqyXBfV0L0razwRhjd8AowHQYYKlfBmNOlUm46wpNYp0UkJkCsHK
         vvuBitM9ipGLNA6auWkiAwCJDhweWZAY2K16W8vrCMlJlxuBEEqys7L9KfjMsTRpFYdv
         4Ce0r6DgvM081BRdsgCgPOQ8rSQNuL0W0IbuVpluR0+NNVcHQIN/b5lhr5XiUa82BM3K
         dijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729421; x=1741334221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HA6Wf119PGC9oGEZOgYc8tQj/1OTKZ0Ld6gp+7XSOI=;
        b=SgjMe5CAl6nbOdqpWh/SNN3gz7hjmuddDDHt5q/IQYhyir0gOwY162Bu5twx3l/KSm
         RX0teunf3acaeaIDlTbElFY38TZiRgsfHSSzf8eCgNVgfmhdVoleLPCHbDxkNCC2DjM3
         K47mYhpYD7m1Jgw2d5aoT0MyftyRCUTl4+msl+tE4xgy0QZG7fsftsu00Fq+28t8JtmF
         noNc6uQ8FNMY0IivZ8uiW4YJ93OXq7E1G5K+vlslL/kHkd8he3gmF8IGR05G5IPUkcd4
         uquHfu5PVrnjnWiwwBHcVkFCWbMZ5jTAZFfL2BeyIwaqL2iwxrqC9Y4v2qTTgCHkQL85
         5GgQ==
X-Gm-Message-State: AOJu0YwBPfIAFBq6xDQE4kdpJCHK4cFNVvjepBuvbaXSkXiwpBMnL5SN
	GslgWDmGbb6l3gL29Fmdg1q/yHX7P+b0UiS5+nNKXgBiOObali+Glkhmf553PEU=
X-Gm-Gg: ASbGncubwYy04HqLaw+3ofWmvgqTHX+aNylKd2Sz5TC6/OcPIdwZvUXHl3DoOqKNTpU
	La0JAmsV8j0mCT2eQqlC8ygdiitZnJzc0tJDmDx/Jw63Rap2GjqnpxRA3ceEcJLwBytxyKKqr0v
	FLi7xvdEGjE32YpqZQQ/T8NGdwfrtQWyHKnaGQ38YM8OpF1myolLtbaNp78ScnOuivnjPEfFkI6
	HEEGrcmP0rMeRBmA9/D+qgawzkfeOQ0g/rvUmY1wm/5u5n0cw3/oQ/qFr2VI/8Z+DqdJq42FxGn
	JNZ6TN5Ao8M3fbS0XW5U7+57bmM=
X-Google-Smtp-Source: AGHT+IGpprCgOhUD9Vb85/YAPLmaifvPc0MlnlGSnjWete21B+hM66nFq7VYj9JcmdZx1nikCmSO7A==
X-Received: by 2002:a17:902:cec1:b0:223:5945:ffd5 with SMTP id d9443c01a7336-2236925558dmr40963415ad.32.1740729420764;
        Thu, 27 Feb 2025 23:57:00 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350534004sm27356675ad.252.2025.02.27.23.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:57:00 -0800 (PST)
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
Subject: [PATCH V2 1/2] rust: Add initial cpumask abstractions
Date: Fri, 28 Feb 2025 13:26:46 +0530
Message-Id: <d5a3b9b2838df8dcf4769841e7a21a647d7f6247.1740726226.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1740726226.git.viresh.kumar@linaro.org>
References: <cover.1740726226.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpumask.rs | 209 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 2 files changed, 210 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
new file mode 100644
index 000000000000..aa4919954c8c
--- /dev/null
+++ b/rust/kernel/cpumask.rs
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU mask abstractions.
+//!
+//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
+
+use crate::{
+    alloc::{AllocError, Flags},
+    bindings,
+    prelude::*,
+    types::Opaque,
+};
+#[cfg(CONFIG_CPUMASK_OFFSTACK)]
+use core::ptr::{self, NonNull};
+
+#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+use core::mem::MaybeUninit;
+
+use core::ops::{Deref, DerefMut};
+
+/// This corresponds to the C type `struct cpumask`.
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
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Obtain the raw `struct cpumask *`.
+    pub fn as_raw(&self) -> *mut bindings::cpumask {
+        self as *const Cpumask as *mut bindings::cpumask
+    }
+
+    /// Sets `cpu` in the cpumask.
+    pub fn set(&mut self, cpu: u32) {
+        // SAFETY: `mask` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_set_cpus()` for any CPU.
+        unsafe { bindings::cpumask_set_cpu(cpu, self.as_raw()) };
+    }
+
+    /// Clears `cpu` in the cpumask.
+    pub fn clear(&mut self, cpu: i32) {
+        // SAFETY: `mask` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_clear_cpu()` for any CPU.
+        unsafe { bindings::cpumask_clear_cpu(cpu, self.as_raw()) };
+    }
+
+    /// Sets all CPUs in the cpumask.
+    pub fn set_all(&mut self) {
+        // SAFETY: `mask` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_setall()`.
+        unsafe { bindings::cpumask_setall(self.as_raw()) };
+    }
+
+    /// Gets weight of the cpumask.
+    pub fn weight(&self) -> u32 {
+        // SAFETY: `mask` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_weight()`.
+        unsafe { bindings::cpumask_weight(self.as_raw()) }
+    }
+
+    /// Copies cpumask.
+    pub fn copy(&self, dstp: &mut Self) {
+        // SAFETY: `mask` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_copy()`.
+        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.as_raw()) };
+    }
+}
+
+/// This corresponds to the C type alias `cpumask_var_t`.
+pub struct CpumaskBox {
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    ptr: NonNull<Cpumask>,
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    mask: Cpumask,
+}
+
+impl CpumaskBox {
+    /// Creates an initialized instance of the `CpumaskBox`.
+    pub fn new(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
+                // that, it is always safe to call this method.
+                unsafe { bindings::zalloc_cpumask_var(&mut ptr, _flags.as_raw()) };
+                NonNull::new(ptr.cast()).ok_or(AllocError)?
+            },
+
+            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+            // SAFETY: FFI type is valid to be zero-initialized.
+            mask: unsafe { core::mem::zeroed() },
+        })
+    }
+
+    /// Creates an uninitialized instance of the `CpumaskBox`.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the returned `CpumaskBox` is properly initialized before
+    /// getting used.
+    unsafe fn new_uninit(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+                // SAFETY: Depending on the value of `_flags`, this call may sleep. Other than
+                // that, it is always safe to call this method.
+                unsafe { bindings::alloc_cpumask_var(&mut ptr, _flags.as_raw()) };
+                NonNull::new(ptr.cast()).ok_or(AllocError)?
+            },
+            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+            // SAFETY: Guaranteed by the safety requirements of the function.
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
+// Make CpumaskBox behave like a pointer to Cpumask.
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
+        // SAFETY: It is safe to free the cpumask.
+        unsafe {
+            bindings::free_cpumask_var(self.as_raw())
+        };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911..efbd7be98dab 100644
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


