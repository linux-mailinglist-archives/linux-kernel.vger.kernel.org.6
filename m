Return-Path: <linux-kernel+bounces-331134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F265197A8D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55329B2A55A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB551684A3;
	Mon, 16 Sep 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqKIMF1U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F9188584
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522267; cv=none; b=uwjpKw9YFQS8EEypqYF10Fy6HBkM9XG+F0QVPjTq23MI5diS5H8Fp3/7F3qxdqe/j1NBhRTWdEmcVrFJ9+CD1RXdgJCRRSFQEg0HCwnpHr5yBdMXWVEibdwEJd00VQPyKLDnkTbPZQULAi4UNMXyN1lwAiMr+DHlr78xL6f7Va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522267; c=relaxed/simple;
	bh=TfZJbpp9zXEoa+e6StsgG5WDca0qXx/l5uqKk5O50pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLkIRyCgc2Zwd7vSLR/m4l/z9JkrfVHbN0XvwatVTyl2w4XSd8zNsPlBXkhyKjBMnkdQpHIexd1v6pmnl7YCUzk+vYUKjeC8PSVBJhs5pxnnNCZ/GQqahO5HGk4FXAQC3hLJUj0UyB7jCxr9NeME11IpWaiGk6+XSfQayYSk9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqKIMF1U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726522263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecVEOyaTeumZAX2Umi7O9C03HHNMLFdbxAe12DFyqkw=;
	b=bqKIMF1UIeCP1hfZbMys+wcbS7d6Z+qpfyE6Ox8W7B62h/udwcCyD/P3oxh8wWpAQrXORf
	+5PHGTH53tOKsyj5ftiqNDB+b/PTODAgrf/ZUeSo1XzF9xwVFllv8jHLo0Uf1JmyawbYDf
	c58tXqTiB5Kl4AMUYHEenz3V4RhNDHU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-wA-_0SKgO32ivfU7vDK4CQ-1; Mon,
 16 Sep 2024 17:31:00 -0400
X-MC-Unique: wA-_0SKgO32ivfU7vDK4CQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F5AA195608C;
	Mon, 16 Sep 2024 21:30:57 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.33.131])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C723F19560AA;
	Mon, 16 Sep 2024 21:30:52 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH v6 2/3] rust: sync: Introduce lock::Backend::Context
Date: Mon, 16 Sep 2024 17:28:05 -0400
Message-ID: <20240916213025.477225-3-lyude@redhat.com>
In-Reply-To: <20240916213025.477225-1-lyude@redhat.com>
References: <20240916213025.477225-1-lyude@redhat.com>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>

---

V3:
* Use explicit lifetimes in lock_with() to ensure self and _context have
  the same lifetime (Benno)
* Use () for locks that don't need a Context instead of PhantomData (Benno)
V4:
* Fix typo (Dirk)

---
 rust/kernel/sync/lock.rs          | 17 +++++++++++++++--
 rust/kernel/sync/lock/mutex.rs    |  1 +
 rust/kernel/sync/lock/spinlock.rs |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index d6e9bab114b87..cc39a3dc3f20b 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -43,6 +43,9 @@ pub unsafe trait Backend {
     /// [`unlock`]: Backend::unlock
     type GuardState;
 
+    /// The context which must be provided to acquire the lock.
+    type Context<'a>;
+
     /// Initialises the lock.
     ///
     /// # Safety
@@ -125,14 +128,24 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
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


