Return-Path: <linux-kernel+bounces-184004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693AE8CA154
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718AF1C216C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBB213959B;
	Mon, 20 May 2024 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAoVHpZS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAD13959F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226034; cv=none; b=TbMrT2sHzwoXBWHTsT3vkCJrMRwNOaU/PRuLn7HmCpLiJwq8H6ymSc7wLywDd2AVL0PPOWvmpeP3kPvnev2LsW+6VM2IgOIXJzLSzxOdOSz8gCFS1NDRlTbiEsMEKKSf/MhFl25xtVIpymtcda/w0yWGMwG8dd+MTu/ABCibCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226034; c=relaxed/simple;
	bh=N85iMowovDf/JhZ/dLh0R6pfZHYB+vOre1zGRULPwYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xlg1bZvVCvWe4AAjkA50IRRJMsX7t9tV+1/BDf2BbEjHRi7r61bqtLYDVuReUHvEsMaQhxaiYGxnWr+BCLXISGUOuGjH4K3mYn79ih9ECWoznWT3ZZswUpcYjFPAmsqxgHm8vNGuLQWvgaWY6qep4pxoJqKyJF2qdzEDeAGVwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAoVHpZS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716226031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fu/toNLVWWyRq23aezf3ytH43dbJ0WC5O1SCuEo+dyc=;
	b=dAoVHpZSv1PnPnETiNC7pnXDbLbGlT9ExDnAAxaweoqiXWgts8mJ5T7wPvFDATaz86aJhp
	ZDXiIdHaAI+lGfpLqOWu7afpsJQYU00rZz8k/v6TlBXn8ySirf170fIf6WfJwZf9GeosZf
	8G2xAB+yRTVDgY5lUs9tR2Nl9FrI6zw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-8nF8dQO4OEGYm-53TJY2LA-1; Mon, 20 May 2024 13:27:10 -0400
X-MC-Unique: 8nF8dQO4OEGYm-53TJY2LA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-351bf7f7f73so4851015f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226029; x=1716830829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fu/toNLVWWyRq23aezf3ytH43dbJ0WC5O1SCuEo+dyc=;
        b=OJQ0NFqCSuZzrgQCIKJwgbXHz6vz2GG3NWffhoIWWXBaAnLj8FNNbXpX5t23j43KkJ
         MRhXH0ve+lYT8e5jWkIuLx7gXFX7NsOtDS9UwvkfGRA043JyRvk6rUVmILOE9skjZkNK
         Uz+hJDvDAKT7Yw6VzLw6t64j0YneLMmarOwTpGkVtWGnBB3mBP4q4KU7j4G7wb55N5uv
         cDtEMbJDAVDMzxSCkAvcczODSKlfM8k1eTHeiabRUeGhCEG/eiF/0jpI2dH/SwOjsmel
         z1P/EbPpoU0KQfuNFC21d/Bj8FBmzFmXkq4zsX9i0TE+7znJXEXY/lJqVDwtRS+21iu0
         jFwg==
X-Forwarded-Encrypted: i=1; AJvYcCW+X8utODWx+pHSOxazz9Er1gKjxLuEKGcq/WEbjN9F8CsQVo9TWoXd6cPkuWRNAHaRVthyPIUMyQZ2ydhTQTGBFxYVzmS48A5bmvc3
X-Gm-Message-State: AOJu0YyIcEo4iP8EQsEYAGZ3yKXPBDVbCuqqriKdK6gdH07DPSbkyfnw
	LiR5Sf/Hz1vUSTFNS5uc8h3MB9eS4ekIydqw8m31yxUIhlID5bMhTB/xTWSFWKmZYq/P3O4WpJ6
	bXh/D/CwFrl3aXA5Swz5yCHYCriSUFj3/AnL5o2KCouOElTAvj6ld/07wzBfcTQ==
X-Received: by 2002:adf:ef4c:0:b0:349:bccc:a1e7 with SMTP id ffacd0b85a97d-3504a6310c6mr30303194f8f.19.1716226028925;
        Mon, 20 May 2024 10:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBsX478+NUBs509kzcMbzIJbFh4JBLi9OQ2gqKGhis3wbf55/L1xrKM6Shc/S0VsZJL65/uw==
X-Received: by 2002:adf:ef4c:0:b0:349:bccc:a1e7 with SMTP id ffacd0b85a97d-3504a6310c6mr30303156f8f.19.1716226028289;
        Mon, 20 May 2024 10:27:08 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354ccd66865sm784772f8f.89.2024.05.20.10.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:27:07 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
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
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 04/11] rust: add revocable mutex
Date: Mon, 20 May 2024 19:25:41 +0200
Message-ID: <20240520172554.182094-5-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <wedsonaf@gmail.com>

This is a mutex where access to its contents can be revoked at runtime.

This is different from `Revocable` in a few ways:
  1. The caller may sleep while holding a guard.
  2. Accessors are all serialised.
  3. Accessing is not as cheap (because it involves acquiring the mutex).
  4. The size of the object is larger (because it involves a mutex +
     flag).

An example of where this a good fit to be used in device state that
holds registrations to other subsystems.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Co-developed-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/sync.rs           |   2 +
 rust/kernel/sync/revocable.rs | 148 ++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 rust/kernel/sync/revocable.rs

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 1806767359fe..13257a4bcff6 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -12,12 +12,14 @@
 pub mod lock;
 mod locked_by;
 pub mod rcu;
+mod revocable;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::mutex::{new_mutex, Mutex};
 pub use lock::spinlock::{new_spinlock, SpinLock};
 pub use locked_by::LockedBy;
+pub use revocable::{RevocableMutex, RevocableMutexGuard};
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/revocable.rs b/rust/kernel/sync/revocable.rs
new file mode 100644
index 000000000000..4632bb838180
--- /dev/null
+++ b/rust/kernel/sync/revocable.rs
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Synchronisation primitives where access to their contents can be revoked at runtime.
+
+use macros::pin_data;
+
+use crate::{
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    sync::{lock, lock::Lock, LockClassKey},
+};
+use core::{
+    mem::MaybeUninit,
+    ops::{Deref, DerefMut},
+    pin::Pin,
+};
+
+use super::lock::Guard;
+
+/// The state within the revocable synchronisation primitive.
+///
+/// We don't use simply `Option<T>` because we need to drop in-place because the contents are
+/// implicitly pinned.
+///
+/// # Invariants
+///
+/// The `is_available` field determines if `data` is initialised.
+struct Inner<T> {
+    is_available: bool,
+    data: MaybeUninit<T>,
+}
+
+impl<T> Inner<T> {
+    fn new(data: T) -> Self {
+        // INVARIANT: `data` is initialised and `is_available` is `true`, so the state matches.
+        Self {
+            is_available: true,
+            data: MaybeUninit::new(data),
+        }
+    }
+
+    fn drop_in_place(&mut self) {
+        if !self.is_available {
+            // Already dropped.
+            return;
+        }
+
+        // INVARIANT: `data` is being dropped and `is_available` is set to `false`, so the state
+        // matches.
+        self.is_available = false;
+
+        // SAFETY: By the type invariants, `data` is valid because `is_available` was true.
+        unsafe { self.data.assume_init_drop() };
+    }
+}
+
+impl<T> Drop for Inner<T> {
+    fn drop(&mut self) {
+        self.drop_in_place();
+    }
+}
+
+#[pin_data]
+pub struct Revocable<T, B: lock::Backend> {
+    #[pin]
+    inner: Lock<Inner<T>, B>,
+}
+
+/// Safely initialises a [`Revocable`] instance with the given name, generating a new lock class.
+// #[macro_export]
+// macro_rules! revocable_init {
+//     ($mutex:expr, $name:literal) => {
+//         $crate::init_with_lockdep!($mutex, $name)
+//     };
+// }
+
+impl<T, B> Revocable<T, B>
+where
+    B: lock::Backend,
+{
+    /// Creates a new revocable instance of the given lock.
+    pub fn new(data: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+        pin_init!(Self {
+            inner <- Lock::new(Inner::new(data), name, key) ,
+        })
+    }
+
+    /// Revokes access to and drops the wrapped object.
+    ///
+    /// Revocation and dropping happen after ongoing accessors complete.
+    pub fn revoke(&self) {
+        self.lock().drop_in_place();
+    }
+
+    pub fn try_write(&self) -> Option<RevocableGuard<'_, T, B>> {
+        let inner = self.lock();
+
+        if !inner.is_available {
+            return None;
+        }
+
+        Some(RevocableGuard::new(inner))
+    }
+
+    fn lock(&self) -> Guard<'_, Inner<T>, B> {
+        self.inner.lock()
+    }
+}
+
+pub struct RevocableGuard<'a, T, B>
+where
+    B: lock::Backend,
+{
+    guard: Guard<'a, Inner<T>, B>,
+}
+
+impl<'a, T, B: lock::Backend> RevocableGuard<'a, T, B> {
+    fn new(guard: Guard<'a, Inner<T>, B>) -> Self {
+        Self { guard }
+    }
+}
+
+impl<T, B: lock::Backend> RevocableGuard<'_, T, B> {
+    pub fn as_pinned_mut(&mut self) -> Pin<&mut T> {
+        unsafe { Pin::new_unchecked(&mut *self) }
+    }
+}
+
+impl<T, B: lock::Backend> Deref for RevocableGuard<'_, T, B> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        unsafe { &*self.guard.data.as_ptr() }
+    }
+}
+
+impl<T, B: lock::Backend> DerefMut for RevocableGuard<'_, T, B> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        unsafe { &mut *self.guard.data.as_mut_ptr() }
+    }
+}
+
+/// Type alias for a `Revocable` with a `MutexBackend`.
+pub type RevocableMutex<T> = Revocable<T, super::lock::mutex::MutexBackend>;
+
+/// Type alias for a `RevocableGuard` with a `MutexBackend`.
+pub type RevocableMutexGuard<'a, T> = RevocableGuard<'a, T, super::lock::mutex::MutexBackend>;
-- 
2.45.1


