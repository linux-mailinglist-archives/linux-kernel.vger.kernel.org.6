Return-Path: <linux-kernel+bounces-262688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77C93CADC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF541C20D29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5991494D7;
	Thu, 25 Jul 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaFWYzcT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B213D8A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946540; cv=none; b=KlMMCcm9EsaSEdPgOt4xP+MwwI9xlmMNP+CjjHo9nqqxvrdVzeCEdS784nEl8gVTFNk29JiO3o/HZbF/qMDHx6EprDiReWs4G12u5FXb7xuKZpqmxpWUe7R5kphiBMazyidSGyWdUI/bbGCBbFI5JT6nYAYTqtRD8qMQb7//vjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946540; c=relaxed/simple;
	bh=7MSXSmUANPVaspw7dOeRLBaOBv37xQug755Bsrb2eeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtRK3rCloBV9d5ZTmQLPiPgv3WX59j5ZWdhxhe2Nz2RIn/UuadOnK5yEO9uKT0pQJJerVhieUrtCyRb9pF1hm8p7bKw3WpNuBXcpO/JhzFwsaxafmMAr1jXSm+9Wh/aR7XOupFtVx5NuTXgMj4tgWynsjOIdsbGNdcaw+2+dcqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaFWYzcT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721946538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbB/aR2P1eCflkX9dx0AY52Ld+huVPvblRgm+pgM0mM=;
	b=LaFWYzcTfUlJUhWMD1NvQEKOhKBXNSSggtD8CBSOJX1t2eeZAmvQFkuwsdiuHr25jKeTGD
	vRRnteo8q/mvnwDz2KPYaONutv7T1s9/zkp9VPTvGdT6eKkcYNegnesjXhyeX/crCx+fCt
	Wd06FodePi+dKRqheiS5wiUlxtotEZo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-DPSzaDyEMdei_5NDC8qukQ-1; Thu,
 25 Jul 2024 18:28:53 -0400
X-MC-Unique: DPSzaDyEMdei_5NDC8qukQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1194619560B3;
	Thu, 25 Jul 2024 22:28:51 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.33.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1816C3000194;
	Thu, 25 Jul 2024 22:28:46 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Trevor Gross <tmgross@umich.edu>,
	Ben Gooding <ben.gooding.dev@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] rust: sync: Introduce LockContainer trait
Date: Thu, 25 Jul 2024 18:27:51 -0400
Message-ID: <20240725222822.1784931-3-lyude@redhat.com>
In-Reply-To: <20240725222822.1784931-1-lyude@redhat.com>
References: <20240725222822.1784931-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We want to be able to use spinlocks in no-interrupt contexts, but our
current `Lock` infrastructure doesn't allow for the ability to pass
arguments when acquiring a lock - meaning that there would be no way for us
to verify interrupts are disabled before granting a lock since we have
nowhere to pass an `IrqGuard`.

It doesn't particularly made sense for us to add the ability to pass such
an argument either: this would technically work, but then we would have to
pass empty units as arguments on all of the many locks that are not grabbed
under interrupts. As a result, we go with a slightly nicer solution:
introducing a trait for types which can contain a lock of a specific type:
LockContainer. This means we can still use locks implemented on top of
other lock types in types such as `LockedBy` - as we convert `LockedBy` to
begin using `LockContainer` internally and implement the trait for all
existing lock types.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync.rs           |  1 +
 rust/kernel/sync/lock.rs      | 20 ++++++++++++++++++++
 rust/kernel/sync/locked_by.rs | 11 +++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5d..14a79ebbb42d5 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -16,6 +16,7 @@
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::mutex::{new_mutex, Mutex};
 pub use lock::spinlock::{new_spinlock, SpinLock};
+pub use lock::LockContainer;
 pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819f..bbd0a7465cae3 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -195,3 +195,23 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         }
     }
 }
+
+/// A trait implemented by any type which contains a [`Lock`] with a specific [`Backend`].
+pub trait LockContainer<T: ?Sized, B: Backend> {
+    /// Returns an immutable reference to the lock
+    ///
+    /// # Safety
+    ///
+    /// Since this returns a reference to the contained [`Lock`] without going through the
+    /// [`LockContainer`] implementor, it cannot be guaranteed that it is safe to acquire
+    /// this lock. Thus the caller must promise not to attempt to use the returned immutable
+    /// reference to attempt to grab the underlying lock without ensuring whatever guarantees the
+    /// [`LockContainer`] implementor's interface enforces.
+    unsafe fn get_lock_ref(&self) -> &Lock<T, B>;
+}
+
+impl<T: ?Sized, B: Backend> LockContainer<T, B> for Lock<T, B> {
+    unsafe fn get_lock_ref(&self) -> &Lock<T, B> {
+        &self
+    }
+}
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index babc731bd5f62..d16d89fe74e0b 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -95,13 +95,20 @@ impl<T, U> LockedBy<T, U> {
     /// data becomes inaccessible; if another instance of the owner is allocated *on the same
     /// memory location*, the data becomes accessible again: none of this affects memory safety
     /// because in any case at most one thread (or CPU) can access the protected data at a time.
-    pub fn new<B: Backend>(owner: &Lock<U, B>, data: T) -> Self {
+    pub fn new<B, L>(owner: &L, data: T) -> Self
+    where
+        B: Backend,
+        L: super::LockContainer<U, B>,
+    {
         build_assert!(
             size_of::<Lock<U, B>>() > 0,
             "The lock type cannot be a ZST because it may be impossible to distinguish instances"
         );
         Self {
-            owner: owner.data.get(),
+            // SAFETY: We never directly acquire the lock through this reference, we simply use it
+            // to ensure that a `Guard` the user provides us to access this container's contents
+            // belongs to the same lock that owns this data
+            owner: unsafe { owner.get_lock_ref() }.data.get(),
             data: UnsafeCell::new(data),
         }
     }
-- 
2.45.2


