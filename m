Return-Path: <linux-kernel+bounces-372532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227759A49E2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9301A1F23BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3298191F7B;
	Fri, 18 Oct 2024 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjOG37WX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48B1917C7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293451; cv=none; b=H0yGPci6BY9DuM0BR8gAcgz9tc6jv60xuz/Y1FMt5QIGobXI0JF1Ma2aXR67U+0FmN1WvarMDp6IVDggoJk2gzKyLxZMz9qxysqouSfXckeDsQC54t9n0fxwDC8b/HzKjOz2DTda1keyZNpfeqyzhKgtTBNrkWPF3IpGYg5cYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293451; c=relaxed/simple;
	bh=k5T5wTYTqgSy7/I+hbZvHYXemGzjiQgMfT6xYzXLZck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3PQLtCQXUHaC4w4regG/0Vrea5RO6P1cYTUMt8Jw618iI6IWIqsa5EzRMXv4aN9GrxN9yfN9igpt95i0w/gc5L/AcRN+4108QgU+55uFtXP6ZBTTzlXls+/s98GtJI0rj2dOSjzOgTpTW8Vfj5ScKtP72Glrbln6OWI8oUSCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjOG37WX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729293448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgUruadhckuS2hgU+skGXtFOZJytmmA5aqcmbk2gB3o=;
	b=YjOG37WXNHj0bOzeDeaSRxqxs+WpmmUuMyNTP52khUigs2hQFmUNymMbMzsGpaCqsl2r3u
	dwoGyWbaUQjrza7085SY2agHJdDzj9uK9G7V24nz2ur+4jNX5o1lgWPbGv277CENMF9Htk
	hqJPDFINwEGGwMMaHNbCqzqXli+23kg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-mWtCu5YfMeGDzG6MbOtB7A-1; Fri,
 18 Oct 2024 19:17:24 -0400
X-MC-Unique: mWtCu5YfMeGDzG6MbOtB7A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 183FF19560A5;
	Fri, 18 Oct 2024 23:17:21 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 537721956086;
	Fri, 18 Oct 2024 23:17:15 +0000 (UTC)
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
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Filipe Xavier <felipe_life@live.com>,
	Fiona Behrens <me@kloenk.dev>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v7 2/3] rust: sync: Introduce lock::Backend::Context and lock::BackendWithContext
Date: Fri, 18 Oct 2024 19:13:51 -0400
Message-ID: <20241018231621.474601-4-lyude@redhat.com>
In-Reply-To: <20241018231621.474601-2-lyude@redhat.com>
References: <20241018231621.474601-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

We additionally add a BackendWithContext trait, to handle calling the
various locking primatives necessary for these types - along with providing
a `lock_with_new()` function for using those primitives and creating the
relevant context tokens.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Suggested-by: Benno Lossin <benno.lossin@proton.me>

---

V3:
* Use explicit lifetimes in lock_with() to ensure self and _context have
  the same lifetime (Benno)
* Use () for locks that don't need a Context instead of PhantomData (Benno)
V4:
* Fix typo (Dirk)
V7:
* Introduce BackendWithContext and lock_with_new following tglx's feedback
* Name functions lock_with_context_saved and unlock_with_context_restored

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs          | 118 ++++++++++++++++++++++++++++--
 rust/kernel/sync/lock/mutex.rs    |   1 +
 rust/kernel/sync/lock/spinlock.rs |   1 +
 3 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 7b4859b05d3a7..8949a69dd53c5 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -12,7 +12,7 @@
     str::CStr,
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
-use core::{cell::UnsafeCell, marker::PhantomPinned};
+use core::{cell::UnsafeCell, marker::PhantomPinned, mem::ManuallyDrop};
 use macros::pin_data;
 
 pub mod mutex;
@@ -43,6 +43,11 @@ pub unsafe trait Backend {
     /// [`unlock`]: Backend::unlock
     type GuardState;
 
+    /// The context which must be provided to acquire the lock.
+    ///
+    /// Can be `()`, or another type if [`BackendWithContext`] is implemented.
+    type Context<'a>;
+
     /// Initialises the lock.
     ///
     /// # Safety
@@ -89,6 +94,54 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
     }
 }
 
+/// An additional trait for [`Backend`] implementations with a non-`()` [`Context`].
+///
+/// Restricts the context in which a [`Lock`] may be locked. It can initially be created using
+/// [`Lock::lock_with_new`], and can be reused to acquire additional [`Lock`] objects using
+/// [`Lock::lock_with`].
+///
+/// An example of a locking context would be a context in which local CPU interrupts are disabled,
+/// where we must restrict the ability to acquire the [`Lock`] so that it can only be acquired
+/// within that context.
+///
+/// [`Context`]: `Backend::Context`
+pub trait BackendWithContext: Backend {
+    /// The type that represents the state of this [`Context`].
+    ///
+    /// [`Context`]: Backend::Context
+    type ContextState;
+
+    /// Fulfills the invariants of [`State`] and acquires the lock, making the caller its owner.
+    ///
+    /// This returns any state data ([`Context::State`]) needed upon unlock.
+    ///
+    /// # Safety
+    ///
+    /// * Same as [`Backend::lock`].
+    ///
+    /// [`State`]: Context::State
+    unsafe fn lock_with_context_saved<'a>(
+        ptr: *mut Self::State,
+    ) -> (Self::Context<'a>, Self::ContextState, Self::GuardState);
+
+    /// Performs the final unlock within [`Context`].
+    ///
+    /// Passes the [`Context::State`] returned from [`first_lock`].
+    ///
+    /// # Safety
+    ///
+    /// * This function may only be called after [`first_lock`].
+    /// * `state` must be the value returned from [`first_lock`].
+    ///
+    /// [`first_lock`]: Backend::first_lock
+    /// [`Context`]: Backend::Context
+    unsafe fn unlock_with_context_restored(
+        ptr: *mut Self::State,
+        guard_state: &Self::GuardState,
+        context_state: Self::ContextState,
+    );
+}
+
 /// A mutual exclusion primitive.
 ///
 /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
@@ -132,8 +185,9 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
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
@@ -141,14 +195,68 @@ pub fn lock(&self) -> Guard<'_, T, B> {
         unsafe { Guard::new(self, state) }
     }
 
-    /// Tries to acquire the lock.
+    /// Acquires the lock and gives the caller access to the data protected by it.
+    #[inline]
+    pub fn lock<'a>(&'a self) -> Guard<'a, T, B>
+    where
+        B::Context<'a>: Default,
+    {
+        self.lock_with(Default::default())
+    }
+
+    /// Tries to acquire the lock with the given context.
     ///
     /// Returns a guard that can be used to access the data protected by the lock if successful.
-    pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
+    pub fn try_lock_with<'a>(&'a self, _context: B::Context<'a>) -> Option<Guard<'a, T, B>> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
         unsafe { B::try_lock(self.state.get()).map(|state| Guard::new(self, state)) }
     }
+
+    /// Tries to acquire the lock.
+    ///
+    /// Returns a guard that can be used to access the data protected by the lock if successful.
+    #[inline]
+    pub fn try_lock<'a>(&'a self) -> Option<Guard<'a, T, B>>
+    where
+        B::Context<'a>: Default,
+    {
+        self.try_lock_with(Default::default())
+    }
+}
+
+impl<T: ?Sized, B: BackendWithContext> Lock<T, B> {
+    /// Acquire the lock with a new [`Context`].
+    ///
+    /// Creates a new instance of [`Context`], and then calls `cb` with said [`Context`] and a
+    /// [`Guard`] for `self`. The [`Context`] will be dropped once `cb` finishes, and it may be used
+    /// within `cb` to acquire additional locks.
+    ///
+    /// [`Context`]: Backend::Context
+    pub fn lock_with_new<'a, R>(
+        &self,
+        cb: impl FnOnce(&mut Guard<'_, T, B>, B::Context<'a>) -> R,
+    ) -> R {
+        let ptr = self.state.get();
+
+        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
+        // that `init` was called.
+        let (context, context_state, guard_state) = unsafe { B::lock_with_context_saved(ptr) };
+
+        // We don't want Guard's destructor to get called, since we'll drop the lock manually with
+        // B::unlock_with_context_restored later. So we store it in a ManuallyDrop and pass it to cb
+        // via reference.
+        // SAFETY: We acquired the lock when we called [`B::lock_with_context_saved`] above.
+        let mut guard = ManuallyDrop::new(unsafe { Guard::new(self, guard_state) });
+
+        let result = cb(&mut guard, context);
+
+        // SAFETY: We called `B::lock_with_context_saved` above, `context_state` was returned from
+        // there.
+        unsafe { B::unlock_with_context_restored(ptr, &guard.state, context_state) };
+
+        result
+    }
 }
 
 /// A lock guard.
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 9ce43ccb45158..9a873cb5b438b 100644
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
index 040dc16975a68..9fbfd96ffba3e 100644
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
2.47.0


