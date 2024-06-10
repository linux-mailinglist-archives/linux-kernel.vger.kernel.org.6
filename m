Return-Path: <linux-kernel+bounces-208695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 476EA902834
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66AE1F23569
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2475714B963;
	Mon, 10 Jun 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBXx+zid"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0E1DFFB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042615; cv=none; b=GfeurbBDWvWU3uFDZsjANXFVgFBEKGqkD42R+KvL/yJTKwfYJ0mThcY1VwT3WprvnprVHbmpqHj41KvP+uoHBEVlwW00ICfHPnhZLuDcfIdgda6466heyPfAQDOcHK+etuUCFbO9w2pZslcjLo2MLWsIRDX8pFVBcHq3k/3dxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042615; c=relaxed/simple;
	bh=X0OsUVU4whKgMI8Hzd5DwWsl+jAnlQPOwOL7uMZTJgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlLiX9MwMye13XybHM4ydAoqiBCp6dTWTSkMbUmLampQsSC+LIiMd+34p/PNEhda+xUpEA+NU8qvPZNNjpsLYLd5QPkJU3N6QwpDN0qUzXimWJrVvsailvRBqS9wEJ4mYPt7Wg2Har71Ba0WPQcGHEAVe5wiKKG4gAlFe0YTjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBXx+zid; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718042612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOH7HuTCUNOIi1ypXRDBz2Sa8rCOYzURRQsh29Kh5U0=;
	b=NBXx+zid5e1MxtJHSpE+8LjFuJTsB4WLUpBNcrUf3KqSnB3FWBgpizpUi5WmjcAYDtQC61
	7zBb4AorH21sxO42Ozclh4Ti76AIX8z5ZjFNyeGYdDUUugADDmaZDuxmTmiqlUXk7ZL44+
	e06k3jyHtUQEQRvWmGIToPwStBq/BxY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-xh2yZ0tpOa-KGVmwmFfb1A-1; Mon, 10 Jun 2024 14:03:31 -0400
X-MC-Unique: xh2yZ0tpOa-KGVmwmFfb1A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52baa7fb26dso173544e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042610; x=1718647410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOH7HuTCUNOIi1ypXRDBz2Sa8rCOYzURRQsh29Kh5U0=;
        b=VPVGhrqbcaPXxWMBiuoaosTlY74yDrhSoFvslHb4WzcFigJqQLua0JDosshO9DkG1j
         AnrH+SDg2/TghcNGvn8UKDZNwOyk9vJvViUvodsk0ZAaG8qVzvbtij/A25hgPl2ZauPl
         s08MbG4g6127v1Pn4oM2DIYEKUhUb19bLJlj70y4L58xLs2QJQmV39IkOM59HnPF+LP6
         68S+midCRuFH1txgf8n8quchg2d3HejVi54E8NOI1y+pqnqz5w1qvyqRbeOsGGqe3bqq
         21E+hLAJ1gEVlxePER6Thz9wChlTTlP5cp7yrhCYUYlDwqm7HaU2C3HuEbq1QVxvPlfw
         p1mA==
X-Forwarded-Encrypted: i=1; AJvYcCU/0jBMpBDr+gmAIbeRaAQ6DWWLv4A9pAsGQAtdzceY7JzhViBgaqdoj4bxFSWpfGWtz9j8Y29gRZuwOpdd7W0ZD6d2m+JYup7RW/DJ
X-Gm-Message-State: AOJu0YwcEybfNAbnuS3mo40VsAlZe26TxNYeJikVxpLYAMlabgKVlgyK
	fFF5jR0F/JT5oUnt2SWWJ2uvn1Sh8IfsvHs08z/7n4eWYrZC1AjzUhk1mRGAqAgkd9c9w8XWpmk
	UkmrtKF8a8lNV3zx8fGVcPCO9KgbPa9qqoTQo+DKUj+eH7Nxdgea8PCKtMct2Lg==
X-Received: by 2002:a05:6512:31cd:b0:52c:8440:1d7b with SMTP id 2adb3069b0e04-52c84401e02mr4936356e87.36.1718042609775;
        Mon, 10 Jun 2024 11:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcM8nXvZdQsYEWpW5FBxipSy3B12hC7zjzhSY8QswERWu5NWPzpSC0A2gHP8gwLTF9QrMgXQ==
X-Received: by 2002:a05:6512:31cd:b0:52c:8440:1d7b with SMTP id 2adb3069b0e04-52c84401e02mr4936329e87.36.1718042609299;
        Mon, 10 Jun 2024 11:03:29 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f24c7a9c8sm3266475f8f.78.2024.06.10.11.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:03:27 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mcgrof@kernel.org,
	russell.h.weight@intel.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 1/2] rust: add abstraction for struct device
Date: Mon, 10 Jun 2024 20:02:27 +0200
Message-ID: <20240610180318.72152-2-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240610180318.72152-1-dakr@redhat.com>
References: <20240610180318.72152-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an (always) reference-counted abstraction for a generic C `struct
device`. This abstraction encapsulates existing `struct device` instances
and manages its reference count.

Subsystems may use this abstraction as a base to abstract subsystem
specific device instances based on a generic `struct device`, such as
`struct pci_dev`.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/helpers.c        |  1 +
 rust/kernel/device.rs | 97 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |  1 +
 3 files changed, 99 insertions(+)
 create mode 100644 rust/kernel/device.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 2c37a0f5d7a8..0e02b2c64c72 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/mutex.h>
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
new file mode 100644
index 000000000000..6e22b0b97928
--- /dev/null
+++ b/rust/kernel/device.rs
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic devices that are part of the kernel's driver model.
+//!
+//! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
+
+use crate::{
+    bindings,
+    types::{ARef, Opaque},
+};
+use core::ptr;
+
+/// A reference-counted device.
+///
+/// This structure represents the Rust abstraction for a C `struct device`. This implementation
+/// abstracts the usage of an already existing C `struct device` within Rust code that we get
+/// passed from the C side.
+///
+/// An instance of this abstraction can be obtained temporarily or permanent.
+///
+/// A temporary one is bound to the lifetime of the C `struct device` pointer used for creation.
+/// A permanent instance is always reference-counted and hence not restricted by any lifetime
+/// boundaries.
+///
+/// For subsystems it is recommended to create a permanent instance to wrap into a subsystem
+/// specifc device structure (e.g. `pci::Device`). This is useful for passing it to drivers in
+/// `T::probe()`, such that a driver can store the `ARef<Device>` (equivalent to storing a
+/// `struct device` pointer in a C driver) for arbitrary purposes, e.g. allocating DMA coherent
+/// memory.
+///
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the `ARef` instance. In
+/// particular, the `ARef` instance owns an increment on the underlying object’s reference count.
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::device>);
+
+impl Device {
+    /// Creates a new reference-counted abstraction instance of an existing `struct device` pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count,
+    /// i.e. it must be ensured that the reference count of the C `struct device` `ptr` points to
+    /// can't drop to zero, for the duration of this function call.
+    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
+        // SAFETY: By the safety requirements, ptr is valid.
+        // Initially increase the reference count by one to compensate for the final decrement once
+        // this newly created `ARef<Device>` instance is dropped.
+        unsafe { bindings::get_device(ptr) };
+
+        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
+        let ptr = ptr.cast::<Self>();
+
+        // SAFETY: By the safety requirements, ptr is valid.
+        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
+    }
+
+    /// Obtain the raw `struct device *`.
+    pub(crate) fn as_raw(&self) -> *mut bindings::device {
+        self.0.get()
+    }
+
+    /// Convert a raw C `struct device` pointer to a `&'a Device`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count,
+    /// i.e. it must be ensured that the reference count of the C `struct device` `ptr` points to
+    /// can't drop to zero, for the duration of this function call and the entire duration when the
+    /// returned reference exists.
+    pub unsafe fn as_ref<'a>(ptr: *mut bindings::device) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        unsafe { &*ptr.cast() }
+    }
+}
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl crate::types::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::get_device(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::put_device(obj.cast().as_ptr()) }
+    }
+}
+
+// SAFETY: `Device` only holds a pointer to a C `struct device`, which is safe to be used from any
+// thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` only holds a pointer to a C `struct device`, references to which are safe to be
+// used from any thread.
+unsafe impl Sync for Device {}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..dd1207f1a873 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -28,6 +28,7 @@
 
 pub mod alloc;
 mod build_assert;
+pub mod device;
 pub mod error;
 pub mod init;
 pub mod ioctl;
-- 
2.45.1


