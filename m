Return-Path: <linux-kernel+bounces-219788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7226F90D7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C381F23D42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105E524B4;
	Tue, 18 Jun 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWHLc05B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF347A76
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725733; cv=none; b=HQENhVtkQFpmgu0b7IltE3k+OTmLXhFeWb0uUXxIxheC6YRumqds7Mx6aIevgs1dxSevV63ZHiKgp/IhplUUs8X/UZYaG6QjhhuzDLPl496D/ydznuJNLKA6goyPzZAb748y5vHi1DraGURPuXP6BHr7eT4DzHWqW8z3xjvDmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725733; c=relaxed/simple;
	bh=A8M6FF7htEPo5boFGolkHiGeAc6qKIiKNMl16i3X2mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeihJoKq2mfLHWV7G1uhCpwKeiGZ1zKONwJ9qxCMSOUjx0jL6/bIJtHu1Hp42dOZCJiVVguR3MzIpfZloW0TPEFAPS1OM7ngJS07m3FaOUfQK6y8Q0rRr27LPgP7f6NveZmRESoAPbh4nO61G6Q+Fuhk3iiHc/rmTl/rxNeRTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWHLc05B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718725731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI+z2ALaUfW3Qgvh6spulMhk7FV84f8kGNKB6ILw4nc=;
	b=cWHLc05BxQlGnr/d5N+GJGP+dLGkitG4hOzsOvWpbZ7pnkRhrZPI/zfuVpQBBYTesIR4rA
	/UB7c+9J7v8Eqlo1JVXnsV4NtA2iy2Es96sQxbUe+INKiN6hmLB/NeIX6XxEozAf2v6lhQ
	lt9pkZXQdzq5Ar3hHhqLdjJ6GP3g+mM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-Whv6pJHfP6GISNZgmjvPYA-1; Tue, 18 Jun 2024 11:48:49 -0400
X-MC-Unique: Whv6pJHfP6GISNZgmjvPYA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4246ed3f877so9166515e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725728; x=1719330528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI+z2ALaUfW3Qgvh6spulMhk7FV84f8kGNKB6ILw4nc=;
        b=Z586cF4yq9ZzQ73KK/E2nhiKTvkNhrvuZn8+oZS3v8Ep+minb5IJlKaX5pgsSf3cCb
         oubbgO28xQm8ZAk+WtuC/sW/bfz7DbQ3HHIC5C20/f0Q9XllMyVTNZcYxRguYJvJiqmE
         Utw1jqTWlq8KRuOglE3dQ6n6izXSCZKVzHkY6SSS04XmucAT8d+s7ER9lR5dNFEzsKqi
         X4AJWefyATCAgiZd2mF9CxvbVAKnZGqaKR0niLMR5/7WXCoXpTTOuCURJkc9lnHt4p+E
         bvG/vCb7qJouiJnESFLawPCuvzVL4d0xzCREc651OBAnN11f7SD1sZDn6pAQgiJNabC9
         LoJA==
X-Forwarded-Encrypted: i=1; AJvYcCXnaWbZDLEk4JFl4W8357JA+Z2/cH3tbn4f7UnBUw4Oa5sLDpCn4dTSjO46jUoLZ2f2WgnDVBhakTm6Q8RWvRBAKvi0CS4l3ljcgLAG
X-Gm-Message-State: AOJu0YwVUuc1zsarynSi3gr/j472yv67G0LxRhvSWMmKgXAtYFJK4Bai
	DWwFYuQQ19SbpjeNJLmizvuCQB9k1E6pmXUis4104SGGwWKFC34ZqGdQXZKTBLPlr3q+p20AYAj
	YCn6HSYpQOILBbEqvlVhfPB0RW2/tjFZt+ghMVbp6bS81jX9/AmQqCmn4oTEybQ==
X-Received: by 2002:a05:600c:4689:b0:423:366:ad3d with SMTP id 5b1f17b1804b1-42304827295mr116544475e9.13.1718725728562;
        Tue, 18 Jun 2024 08:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJRfslaNzO0MT9naZttnfdrE59e+FdUbIWj9i48YWC3rqAh7vph7/cJ7kamA2KST40N2lgYQ==
X-Received: by 2002:a05:600c:4689:b0:423:366:ad3d with SMTP id 5b1f17b1804b1-42304827295mr116544285e9.13.1718725728147;
        Tue, 18 Jun 2024 08:48:48 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33bcfsm189385045e9.1.2024.06.18.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:48:47 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
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
Subject: [PATCH v4 1/2] rust: add abstraction for struct device
Date: Tue, 18 Jun 2024 17:48:34 +0200
Message-ID: <20240618154841.6716-2-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618154841.6716-1-dakr@redhat.com>
References: <20240618154841.6716-1-dakr@redhat.com>
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
 rust/helpers.c        |   1 +
 rust/kernel/device.rs | 102 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |   1 +
 3 files changed, 104 insertions(+)
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
index 000000000000..e445e87fb7d7
--- /dev/null
+++ b/rust/kernel/device.rs
@@ -0,0 +1,102 @@
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
+/// specific device structure (e.g. `pci::Device`). This is useful for passing it to drivers in
+/// `T::probe()`, such that a driver can store the `ARef<Device>` (equivalent to storing a
+/// `struct device` pointer in a C driver) for arbitrary purposes, e.g. allocating DMA coherent
+/// memory.
+///
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the `ARef` instance. In
+/// particular, the `ARef` instance owns an increment on the underlying object’s reference count.
+///
+/// `bindings::device::release` is valid to be called from any thread, hence `ARef<Device>` can be
+/// dropped from any thread.
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
+    ///
+    /// It must also be ensured that `bindings::device::release` can be called from any thread.
+    /// While not officially documented, this should be the case for any `struct device`.
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
+// SAFETY: As by the type invariant `Device` can be sent to any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all immutable methods are protected by the
+// synchronization in `struct device`.
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


