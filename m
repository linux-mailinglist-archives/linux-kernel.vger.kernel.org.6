Return-Path: <linux-kernel+bounces-218293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DBB90BC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5361F214E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6624F1990C4;
	Mon, 17 Jun 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQV4JxS2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA6C8E1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656228; cv=none; b=MXw1rNkNRNwNg67MrcFCzCXLt/NTCFPIcQ5LIezpxXznqlOXG/QLTdu/eNc6OCVfuVYqnz+i9Sjz1rktw5BM4KH7Aiwg40m5kRmT+Q0Cz2/m1hF3j++rRca7S8P1fL6bXKqqk1Vbi4Qgp73HOzDfufyV2T+pojE9SMfZtpWGdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656228; c=relaxed/simple;
	bh=A8M6FF7htEPo5boFGolkHiGeAc6qKIiKNMl16i3X2mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0f3+tnFYXPUs42Y0BiOV2+XLtrBhU42snjGcz2x3SIfrV6Gjj3BJGKUteTE5X45t/rpB0E9MtowGOB8LyhRhZ4mF7WAvuWF4jrcrIp898t7gMZRKzgtfIBrrEes2Z55waLlDPDeHk91atHS7W5WgCFBnpcHQ5YE7N6+Be3TmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQV4JxS2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718656224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI+z2ALaUfW3Qgvh6spulMhk7FV84f8kGNKB6ILw4nc=;
	b=GQV4JxS2ybAXnS9rL8ekpcU4u5ieYquJIJXuMLEo9BrRVc6DikDD87yYUF/cg5qOdwvJuE
	fbmYqQvAdQdJ8wvPUtL1pX+BV8bHnZSJsG51NHtOdxA37X+zKvPQQGMNuFZG5joc52tkom
	2aktG4t6wmGpGukoiUAvooFhSfsL+4o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-YPBhcbmxMo2dex7bHl_JmA-1; Mon, 17 Jun 2024 16:30:23 -0400
X-MC-Unique: YPBhcbmxMo2dex7bHl_JmA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4246e5fd996so3196505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718656222; x=1719261022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI+z2ALaUfW3Qgvh6spulMhk7FV84f8kGNKB6ILw4nc=;
        b=VzMCxkuFFvllsr53HpItyXpaf/p1CvChhFNb8WRfG5FtIy8ZpqNfvEXMfkjVd3bmpT
         zErmKNiaBEyY6h9lyv5GvwSo/XTtSvUBzm+T6Fh6a/LhOV8M/RvFDhl9G7VNn3X4us/5
         aEVGE9uPO6wgyeDa6ZMqEJ4iliGDvk5PMFNq+qNyNj64Kz5rr7ZMmBMfo7mNEjvPxMQG
         DrZEE20RELaLj/+dDONCDSdJwRITxyK/hZ7j6JJUTcxUNGr4HT089BssszIIj7OSg7Ho
         lxaUbXzeJhMSgi3i00w2cI885ZeHRxoKHOxDbWT22D2dckbC9PNgpR/owkenC/0WzkzV
         Rmmg==
X-Forwarded-Encrypted: i=1; AJvYcCUgeK6+UJrdpQkm2VvsugBXX3WODZrgsBVvsiluXjZMrXDNXsn5hakUbHt4AS3rVNLttE828zTrtXSeMvxFgDarv0E09HW775qaKGXN
X-Gm-Message-State: AOJu0YztvEYtB/yLfF//A73gFhHY32dcMKRosEqHLUu+VkKXHX+3mZOU
	vAge8ZpYM7ALaKDMqmSwGuplgzIaenEX+80LoxwF1wfmvL78HIvxZDRP9KckQT2LD/+u+XhC1rR
	utqmzP0MWkxfUsEXRdDAGkAECffQl2HskUPJszFLG4MO9nTC/DccNQxJvCq/59Q==
X-Received: by 2002:a05:600c:1d82:b0:420:ffe3:8536 with SMTP id 5b1f17b1804b1-42304854ecdmr88725985e9.37.1718656222031;
        Mon, 17 Jun 2024 13:30:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmp0ZVVmRphzqmYQn2Ly27dG0tqw083L13j4r8JcE0pxXR+Ka+RQpWXbiA8+YnOYH4G8hKeg==
X-Received: by 2002:a05:600c:1d82:b0:420:ffe3:8536 with SMTP id 5b1f17b1804b1-42304854ecdmr88725825e9.37.1718656221727;
        Mon, 17 Jun 2024 13:30:21 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422a1e68d04sm185142205e9.36.2024.06.17.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:30:20 -0700 (PDT)
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
Subject: [PATCH v3 1/2] rust: add abstraction for struct device
Date: Mon, 17 Jun 2024 22:29:40 +0200
Message-ID: <20240617203010.101452-2-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617203010.101452-1-dakr@redhat.com>
References: <20240617203010.101452-1-dakr@redhat.com>
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


