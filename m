Return-Path: <linux-kernel+bounces-421607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6709D8D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA0AB23CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3E01C460B;
	Mon, 25 Nov 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLHsLoQU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18056F06D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567317; cv=none; b=f7QUyfsk6zHcp7d2vLrWr744ajknInW32qeVomPf4z00DyBXWmxisgi49xDzqHVvlUgGztuep7qxTksW1vbx6zfyyXeWBNs9ApumXcsprkOB/ZIvVbIvIc2OWQ9IpwoNlVMo7zy1I77hHBlOG5koJaxqiYd/AUtZdAzygtgdCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567317; c=relaxed/simple;
	bh=gaI7LRUQpliJ1ENPDb52CUTcHUG66GlG8fJhEgiDNmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNlA39tYEKt5Uu/ZapMwmUCQCc7SWV3l3Kt0RrZpcuIcNE01p+kKkY0f7qxSKS0h7pLABroSOQr6mMdNxAzLTTVtsJ2AnQ/FAvZeWS1mH05CqWEBGW/zOZEHwErse6aXLWKUxu7k2TwtL19kzVMkIa0MgHNAnKNEaxVrZQnI9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLHsLoQU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732567314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dKCTP+dIRRtx5bTeGKJmafF2Ct2C1e+/eURUZICNr8k=;
	b=SLHsLoQUB+SQOH8WDrKOOfRuEUjp8oB9s1H1vH/FC0gpAkhZGr+2iYT5dQNdyp7+WqEUhV
	TSYsey6rN0o3PcZokhUUU9HnTn9An2GzxZR6yExrRzlY94/EoffPL6UHlEutWv+5w9d6nr
	rp2gfU5Jf1pg8SCErX6/giNKgf1tjEA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-eVRbeHr9NQiCPuad6i0RDA-1; Mon,
 25 Nov 2024 15:41:50 -0500
X-MC-Unique: eVRbeHr9NQiCPuad6i0RDA-1
X-Mimecast-MFC-AGG-ID: eVRbeHr9NQiCPuad6i0RDA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FF121956095;
	Mon, 25 Nov 2024 20:41:47 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.81.155])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3754F1956086;
	Mon, 25 Nov 2024 20:41:43 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Filipe Xavier <felipe_life@live.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2] rust: sync: Add lock::Backend::assert_is_held()
Date: Mon, 25 Nov 2024 15:40:58 -0500
Message-ID: <20241125204139.656801-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Since we've exposed Lock::from_raw() and Guard::new() publically, we want
to be able to make sure that we assert that a lock is actually held when
constructing a Guard for it to handle instances of unsafe Guard::new()
calls outside of our lock module.

So, let's do this by adding a new method assert_is_held to Backend, which
uses lockdep to check whether or not a lock has been acquired. When lockdep
is disabled, this has no overhead.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V2
* Use lockdep instead of is_locked() functions
* Drop is_locked, replace with assert_is_held()
---
 rust/helpers/mutex.c              |  5 +++++
 rust/helpers/spinlock.c           |  5 +++++
 rust/kernel/sync/lock.rs          | 10 ++++++++++
 rust/kernel/sync/lock/mutex.rs    |  7 +++++++
 rust/kernel/sync/lock/spinlock.rs |  7 +++++++
 5 files changed, 34 insertions(+)

diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
index 7e00680958ef1..06575553eda5c 100644
--- a/rust/helpers/mutex.c
+++ b/rust/helpers/mutex.c
@@ -12,3 +12,8 @@ void rust_helper___mutex_init(struct mutex *mutex, const char *name,
 {
 	__mutex_init(mutex, name, key);
 }
+
+void rust_helper_mutex_assert_is_held(struct mutex *mutex)
+{
+	lockdep_assert_held(mutex);
+}
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index b7b0945e8b3cb..b26953d0d65b5 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -26,3 +26,8 @@ int rust_helper_spin_trylock(spinlock_t *lock)
 {
 	return spin_trylock(lock);
 }
+
+void rust_helper_spin_assert_is_held(spinlock_t *lock)
+{
+	lockdep_assert_held(lock);
+}
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 6d3c8874eb26a..bc71fda87b104 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -85,6 +85,13 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
         // SAFETY: The safety requirements ensure that the lock is initialised.
         *guard_state = unsafe { Self::lock(ptr) };
     }
+
+    /// Asserts that the lock is held using lockdep.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that [`Backend::init`] has been previously called.
+    unsafe fn assert_is_held(ptr: *mut Self::State);
 }
 
 /// A mutual exclusion primitive.
@@ -207,6 +214,9 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     ///
     /// The caller must ensure that it owns the lock.
     pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
+        // SAFETY: The caller can only hold the lock if `Backend::init` has already been called.
+        unsafe { B::assert_is_held(lock.state.get()) };
+
         Self {
             lock,
             state,
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 0e946ebefce12..8ee079f6ae0ac 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -126,4 +126,11 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
             None
         }
     }
+
+    unsafe fn assert_is_held(ptr: *mut Self::State) {
+        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
+        unsafe {
+            bindings::mutex_assert_is_held(ptr);
+        }
+    }
 }
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 9f4d128bed983..b2c1343aabee3 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -125,4 +125,11 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
             None
         }
     }
+
+    unsafe fn assert_is_held(ptr: *mut Self::State) {
+        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
+        unsafe {
+            bindings::spin_assert_is_held(ptr);
+        }
+    }
 }

base-commit: b7ed2b6f4e8d7f64649795e76ee9db67300de8eb
-- 
2.47.0


