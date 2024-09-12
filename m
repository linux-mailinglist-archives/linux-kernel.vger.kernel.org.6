Return-Path: <linux-kernel+bounces-325788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82281975E41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78BC1C20CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61F3C466;
	Thu, 12 Sep 2024 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tlm5FBFw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8C35894
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102570; cv=none; b=R68JhTmmBKhMIlabyfUSa5owH9EnQSCqzYSW3MpE1DUBv3mXX7O/04O5PY2HiE9hvjAVrqEbUYS7a3ocqhvsA20nVEwSNFNiQOG3xVxEKDMG1sZeQafC3dPNN7Cn6JqgiU4gzu9ggaBRhw8RAnSwW02R+AMI/YcyfR6s+Zx7iM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102570; c=relaxed/simple;
	bh=/rdYGX7UjvkB2gk5fsyYiBzOkcUaojbBXtAJ5ZK88U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQijQbtrkPHirou9AVz5L2YHXUzGAM3H9twIPq4phTGHsYGxmO0+MZhnEJn0HSQBk00woBWUkq9rdvn1rYqOxButMg+PCrJTnNvpbG03vrsrpNM8GhN03+H3/oY9mBzJPTAIfKqFEH0nNZP2HiaecKDwcUE2Pg/EJXoKS3jDW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tlm5FBFw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726102567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKQklmomFwAhOEFxjHGrCGOmakddEyukxyf0Xx3I0gQ=;
	b=Tlm5FBFw3YO6V5DCicPvNPeipfOrTaqC1u20aNptz1gVE80hJmi9ao+9qR9F2sitokpPbt
	850yidTXRupVHiQQincn4HrPIcxE7wFA38NoVg9QuH3c9+Y+aXR06ghrkHm7tjE9C/VZhq
	DzLPI3WUJCamvyhHi1/9yleZKoTihx4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-19-rzwAgPqS3xubmbziTbA-1; Wed,
 11 Sep 2024 20:56:04 -0400
X-MC-Unique: 19-rzwAgPqS3xubmbziTbA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 645151953943;
	Thu, 12 Sep 2024 00:56:02 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.32.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F89119560B1;
	Thu, 12 Sep 2024 00:55:57 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
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
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v4 2/3] rust: sync: Introduce lock::Backend::Context
Date: Wed, 11 Sep 2024 20:55:33 -0400
Message-ID: <20240912005539.175428-3-lyude@redhat.com>
In-Reply-To: <20240912005539.175428-1-lyude@redhat.com>
References: <20240912005539.175428-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Now that we've introduced an `IrqDisabled` token for marking contexts in
which IRQs are disabled, we need a way to be able to pass it to locks that
require that IRQs are disabled. In order to continue using the
`lock::Backend` type instead of inventing our own thing, we accomplish this
by adding the associated Context type, along with a `lock_with()` function
that can accept a Context when acquiring a lock. To allow current users of
context-less locks to keep using the normal `lock()` method, we take an
example from Wedson Almeida Filho's work and add a `where T<'a>: Default`
bound to `lock()` so that it can only be called on lock types where the
context is simply a placeholder value, then re-implement it through the new
`lock_with()` function.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V3:
* Use explicit lifetimes in lock_with() to ensure self and _context have
  the same lifetime (Benno)
* Use () for locks that don't need a Context instead of PhantomData (Benno)
V4:
* Fix typo (Dirk)

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs          | 17 +++++++++++++++--
 rust/kernel/sync/lock/mutex.rs    |  1 +
 rust/kernel/sync/lock/spinlock.rs |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819f..7429bda852173 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -38,6 +38,9 @@ pub unsafe trait Backend {
     /// [`unlock`]: Backend::unlock
     type GuardState;
 
+    /// The context which must be provided to acquire the lock.
+    type Context<'a>;
+
     /// Initialises the lock.
     ///
     /// # Safety
@@ -120,14 +123,24 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
-    /// Acquires the lock and gives the caller access to the data protected by it.
-    pub fn lock(&self) -> Guard<'_, T, B> {
+    /// Acquires the lock with the given context and gives the caller access to the data protected
+    /// by it.
+    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
         let state = unsafe { B::lock(self.state.get()) };
         // SAFETY: The lock was just acquired.
         unsafe { Guard::new(self, state) }
     }
+
+    /// Acquires the lock and gives the caller access to the data protected by it.
+    #[inline]
+    pub fn lock<'a>(&'a self) -> Guard<'a, T, B>
+    where
+        B::Context<'a>: Default,
+    {
+        self.lock_with(B::Context::default())
+    }
 }
 
 /// A lock guard.
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 30632070ee670..7c2c239944931 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -93,6 +93,7 @@ macro_rules! new_mutex {
 unsafe impl super::Backend for MutexBackend {
     type State = bindings::mutex;
     type GuardState = ();
+    type Context<'a> = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index ea5c5bc1ce12e..97d85a5576615 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -92,6 +92,7 @@ macro_rules! new_spinlock {
 unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
+    type Context<'a> = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
-- 
2.46.0


