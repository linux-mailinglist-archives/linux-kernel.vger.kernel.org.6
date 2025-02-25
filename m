Return-Path: <linux-kernel+bounces-530929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50242A43A47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CCF170642
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB2266F1B;
	Tue, 25 Feb 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPpCwHwY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78113264A92
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476848; cv=none; b=lohkWlUl/3fjWoIAhzNvt4QqJ61nEQ2qBC9Hd3tU/wT05QPYlOqmGjkdLdeCRX8yRnXOdnn/hUR5bmuSsfJzxJmVgQnM6sOTMrkc+ShsGQ3fK1nvb5UOFA4i5tD9c6K2t6R9TBzCKyo4Vfq7V9PzLpi+Wdc2kDn+LNu1YXj+SQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476848; c=relaxed/simple;
	bh=w/w7+XqbJM363GS88ChRO6m42wpHOoqdaSX8I91x+6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBOzYwBBjN4uB6K0k8QRVD2ZMBLDtFVn7+JXBa2/dxFuRS0T3etoMB+IbngIGX+xZRnZpU4V5ng3Y1Ra4ND8i/7glL3jWqiIzZxGHJ/V+J0NymFvbQXj1IWhTdXV4oD4r5uZ/2E5ozCgeOx6kHl0XqOAjAu7AOLUB2LR8IpGhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qPpCwHwY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c665ef4cso93212885ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740476846; x=1741081646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBgFHzuwU9c2MmDgYbIXSZZ6rPSavRDlD3LXgFpJuuA=;
        b=qPpCwHwYMXmtcXQt3Y1ZuOKkuIIfXb5ulbGAts8hRvVaPFoxDqFy+LJuvfo0eQnDvB
         ABZjWbyf8u4fi/a+IGEUYYfwY20Kq97JiPvBhyMaU1STIPAyW/zp8AiJH233zIaXRMY3
         Hsk5+EN3yV/uwuBYXDH1NfYEF4RGR/8OBIg/Dkqs0uN0I30nD1fwQpW7i2o3y1jTuPiK
         tKTLhn5HchitFEpQKUXiWULIAEiajSbx2JTFBxvc3YWXf71Y7YV30r4sZebYkZHDC9u/
         HYmPKeKT8YcAh9WVaIwLlKsY7Acg+/tyQJOyccpyb7KQMck2E5T9+vGPCrfXzXy5boAG
         FDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476846; x=1741081646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBgFHzuwU9c2MmDgYbIXSZZ6rPSavRDlD3LXgFpJuuA=;
        b=fK71boFjlHnyrXDXccbqUXN7X45n3/vy+U6x/O0DFeibyNJxs1ei1pVTGq3bzxppkx
         E2bHf7bBv7inwbnVU2UqOq0nGHJXeiuVP263HRMq97pyjVqfzDiosnifCi8vwUCIT5zI
         t07oweaHdnsg+h7ZkuWRnVOF+aX+95rP7SkmVG/2TJkMpkOMtyPIqymn8JP6aLojDCc1
         bi0vvpId/mo8yXYBAILUjAs9lDiHmmeomKOWCD9nlMyd7yG93w2Q/Kpth0ofjXVVQDqh
         WOv73uofRSNW/F04a6POddFxW6Y8erFHZZP6HlLp+ZT6kYu+CdyazwpNCtYurJ5l6P9/
         ahUg==
X-Gm-Message-State: AOJu0YwybaV9YNqyRFbrzii6reaejvtRMDJJGs/ByHmgo5F0blis6OaN
	jw3EHyEvNbrJhJ4qM6ar8FJZPZ0p762+ExdC0jtWuUBNxv8N0sMMRRIigI8rLlY=
X-Gm-Gg: ASbGncumuCEfrFiZLUaqjlF5oggkYShRIXTc//ZKAmr6ggq9b3hqnS1ah8+4gwUwO23
	0I9y4346F6U45TOQ5QYoB0PQvb1imeT0cTOAlJObwh1q0i0g5EcPsKaSm+uz6fyTQglDXKNmnIy
	2XzoAV+3NUvkJsS2HVybkVFadb2jutkZwV22iFYrxu2ysZiEysZ3kd+DP5fzkqiG9fEnE2Oq0QP
	KeYbWgfLgilZX4Af7DF0H5pWs/GP9gOgDB7Xc5nbzo99/YceNNDtMUdHgtv9AVsF64U/llKNCRH
	yXDKj7EAlvSue8ln4tMx04Wz3d8=
X-Google-Smtp-Source: AGHT+IHQvVV2yfAGYGvrl3auNFetfeDoHyjHUhSN1ifv7FjxIj1JaEYuDCf4ZkwupeFaJMCPEfgPiQ==
X-Received: by 2002:a05:6a21:6d99:b0:1ee:5d05:a18f with SMTP id adf61e73a8af0-1eef3daaa38mr30245298637.35.1740476845688;
        Tue, 25 Feb 2025 01:47:25 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f5c07sm1050959b3a.38.2025.02.25.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:47:25 -0800 (PST)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] rust: Add initial cpumask abstractions
Date: Tue, 25 Feb 2025 15:17:14 +0530
Message-Id: <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1740475625.git.viresh.kumar@linaro.org>
References: <cover.1740475625.git.viresh.kumar@linaro.org>
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
 rust/kernel/cpumask.rs | 168 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 2 files changed, 169 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
new file mode 100644
index 000000000000..13864424420b
--- /dev/null
+++ b/rust/kernel/cpumask.rs
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU mask abstractions.
+//!
+//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
+
+use crate::{bindings, error::Result, prelude::ENOMEM};
+
+#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+use crate::prelude::{KBox, GFP_KERNEL};
+
+#[cfg(CONFIG_CPUMASK_OFFSTACK)]
+use core::ptr;
+
+/// A simple implementation of `struct cpumask` from the C code.
+pub struct Cpumask {
+    ptr: *mut bindings::cpumask,
+    owned: bool,
+}
+
+impl Cpumask {
+    /// Creates cpumask.
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    fn new_inner(empty: bool) -> Result<Self> {
+        let mut ptr: *mut bindings::cpumask = ptr::null_mut();
+
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        if !unsafe {
+            if empty {
+                bindings::zalloc_cpumask_var(&mut ptr, bindings::GFP_KERNEL)
+            } else {
+                bindings::alloc_cpumask_var(&mut ptr, bindings::GFP_KERNEL)
+            }
+        } {
+            return Err(ENOMEM);
+        }
+
+        Ok(Self { ptr, owned: true })
+    }
+
+    /// Creates cpumask.
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    fn new_inner(empty: bool) -> Result<Self> {
+        let ptr = KBox::into_raw(KBox::new([bindings::cpumask::default(); 1], GFP_KERNEL)?);
+
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        if !unsafe {
+            if empty {
+                bindings::zalloc_cpumask_var(ptr, bindings::GFP_KERNEL)
+            } else {
+                bindings::alloc_cpumask_var(ptr, bindings::GFP_KERNEL)
+            }
+        } {
+            return Err(ENOMEM);
+        }
+
+        Ok(Self {
+            ptr: ptr as *mut _,
+            owned: true,
+        })
+    }
+
+    /// Creates empty cpumask.
+    pub fn new() -> Result<Self> {
+        Self::new_inner(true)
+    }
+
+    /// Creates uninitialized cpumask.
+    fn new_uninit() -> Result<Self> {
+        Self::new_inner(false)
+    }
+
+    /// Clones cpumask.
+    pub fn try_clone(&self) -> Result<Self> {
+        let mut cpumask = Self::new_uninit()?;
+
+        self.copy(&mut cpumask);
+        Ok(cpumask)
+    }
+
+    /// Creates a new abstraction instance of an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, and non-null.
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    pub unsafe fn get_cpumask(ptr: &mut *mut bindings::cpumask) -> Self {
+        Self {
+            ptr: *ptr,
+            owned: false,
+        }
+    }
+
+    /// Creates a new abstraction instance of an existing `struct cpumask` pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, and non-null.
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    pub unsafe fn get_cpumask(ptr: &mut bindings::cpumask_var_t) -> Self {
+        Self {
+            ptr: ptr as *mut _,
+            owned: false,
+        }
+    }
+
+    /// Obtain the raw `struct cpumask *`.
+    pub fn as_raw(&mut self) -> *mut bindings::cpumask {
+        self.ptr
+    }
+
+    /// Sets CPU in the cpumask.
+    ///
+    /// Update the cpumask with a single CPU.
+    pub fn set(&mut self, cpu: u32) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_set_cpus()` for any CPU.
+        unsafe { bindings::cpumask_set_cpu(cpu, self.ptr) };
+    }
+
+    /// Clears CPU in the cpumask.
+    ///
+    /// Update the cpumask with a single CPU.
+    pub fn clear(&mut self, cpu: i32) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_clear_cpu()` for any CPU.
+        unsafe { bindings::cpumask_clear_cpu(cpu, self.ptr) };
+    }
+
+    /// Sets all CPUs in the cpumask.
+    pub fn set_all(&mut self) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_setall()`.
+        unsafe { bindings::cpumask_setall(self.ptr) };
+    }
+
+    /// Gets weight of a cpumask.
+    pub fn weight(&self) -> u32 {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_weight()`.
+        unsafe { bindings::cpumask_weight(self.ptr) }
+    }
+
+    /// Copies cpumask.
+    pub fn copy(&self, dstp: &mut Self) {
+        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe to
+        // call `cpumask_copy()`.
+        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.ptr) };
+    }
+}
+
+impl Drop for Cpumask {
+    fn drop(&mut self) {
+        if self.owned {
+            // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `self`. And it is safe
+            // to call `free_cpumask_var()`.
+            unsafe { bindings::free_cpumask_var(self.ptr) }
+
+            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+            // SAFETY: The pointer was earlier initialized from the result of `KBox::into_raw()`.
+            unsafe {
+                drop(KBox::from_raw(self.ptr))
+            };
+        }
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


