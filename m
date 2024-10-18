Return-Path: <linux-kernel+bounces-372533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9229B9A49E3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BEAB2291E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99124190661;
	Fri, 18 Oct 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b27pB7KK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBD191F95
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293458; cv=none; b=Xs75IT31NqTsL+8egO2D0bDb0ili8SpEpP5mL1xy+1m3bXsY7xGFG77FUOqgDvfynSlOLqacs4ItrbIQuHvdW+sPZpppXZrHR3FcelHduIqv6e7iJg5+Eqx24UGm45z1jiGq6VG4QNH3UyWFiim0bTbxjh9vCFGk1RBUPyftFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293458; c=relaxed/simple;
	bh=lWcEJkw3hYPr1RLVom/NteB4xsniQTSQzqNrhkGI44k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm3nbSbgYEJ+iI20QVoWROlO1/EVyif8eBmhZ6VCTIzg4R9Smo2TfqAwFRAkhZOz1n+174AydMXEVaE8H+rsUb6paKHZv9ojwYTvIijnAt4xm2q8aCr47Y7QyRYzpDIEPMZ1eRUcTkU7G8l/4QJXD61NYYqkjU8bT8LBwtYsiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b27pB7KK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729293455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=biPTK0BtXdZICEumRgw4TKdq/ZVJHlmpmUBbIKP0l5E=;
	b=b27pB7KKDIBh/BpL/Mmup52t47DSTT5A/Rjth7X32LsXHg3yN2gdXYU1XJl2wbptIvGH7A
	hhLZS0QzKcNIZG/1DnS3ggYACZYexZwLgzpJAbAdDtXBdDmafTQPt5rxUacDxpoIf3Bb+D
	git+QfwvZLTS3hHDa0RHizpYgrQWKhI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-R0nWbruwP-yZA8dz8FOtHQ-1; Fri,
 18 Oct 2024 19:17:30 -0400
X-MC-Unique: R0nWbruwP-yZA8dz8FOtHQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 851571956088;
	Fri, 18 Oct 2024 23:17:27 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6341F1956086;
	Fri, 18 Oct 2024 23:17:23 +0000 (UTC)
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
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Filipe Xavier <felipe_life@live.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v7 3/3] rust: sync: Add SpinLockIrq
Date: Fri, 18 Oct 2024 19:13:52 -0400
Message-ID: <20241018231621.474601-5-lyude@redhat.com>
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

A variant of SpinLock that is expected to be used in noirq contexts, and
thus requires that the user provide an kernel::irq::IrqDisabled to prove
they are in such a context upon lock acquisition. This is the rust
equivalent of spin_lock_irqsave()/spin_lock_irqrestore().

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V2:
* s/IrqSpinLock/SpinLockIrq/
* Implement `lock::Backend` now that we have `Context`
* Add missing periods
* Make sure rustdoc examples compile correctly
* Add documentation suggestions

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/helpers/spinlock.c           |  14 +++
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock/spinlock.rs | 145 ++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 775ed4d549aef..f4108d2d78648 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -27,3 +27,17 @@ int rust_helper_spin_trylock(spinlock_t *lock)
 {
 	return spin_trylock(lock);
 }
+
+size_t rust_helper_spin_lock_irqsave(spinlock_t *lock)
+{
+	size_t flags = 0;
+
+	spin_lock_irqsave(lock, flags);
+
+	return flags;
+}
+
+void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, size_t flags)
+{
+	spin_unlock_irqrestore(lock, flags);
+}
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5d..b028ee325f2a6 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -15,7 +15,7 @@
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::mutex::{new_mutex, Mutex};
-pub use lock::spinlock::{new_spinlock, SpinLock};
+pub use lock::spinlock::{new_spinlock, new_spinlock_irq, SpinLock, SpinLockIrq};
 pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 9fbfd96ffba3e..d342ee954f6a8 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -3,6 +3,7 @@
 //! A kernel spinlock.
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
+use kernel::local_irq::*;
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -116,6 +117,123 @@ unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         unsafe { bindings::spin_unlock(ptr) }
     }
 
+    unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
+        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
+        let result = unsafe { bindings::spin_trylock(ptr) };
+
+        (result != 0).then_some(())
+    }
+}
+
+/// Creates a [`SpinLockIrq`] initialiser with the given name and a newly-created lock class.
+///
+/// It uses the name if one is given, otherwise it generates one based on the file name and line
+/// number.
+#[macro_export]
+macro_rules! new_spinlock_irq {
+    ($inner:expr $(, $name:literal)? $(,)?) => {
+        $crate::sync::SpinLockIrq::new(
+            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+pub use new_spinlock_irq;
+
+/// A spinlock that may be acquired when interrupts are disabled.
+///
+/// A version of [`SpinLock`] that can only be used in contexts where interrupts for the local CPU
+/// are disabled. It requires that the user acquiring the lock provide proof that interrupts are
+/// disabled through [`IrqDisabled`].
+///
+/// For more info, see [`SpinLock`].
+///
+/// # Examples
+///
+/// The following example shows how to declare, allocate initialise and access a struct (`Example`)
+/// that contains two inner structs of type `Inner` that are protected by separate spinlocks.
+///
+/// ```
+/// use kernel::{
+///     sync::{new_spinlock_irq, SpinLockIrq},
+///     local_irq::IrqDisabled
+/// };
+///
+/// struct Inner {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     c: u32,
+///     #[pin]
+///     first: SpinLockIrq<Inner>,
+///     #[pin]
+///     second: SpinLockIrq<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             c: 10,
+///             first <- new_spinlock_irq!(Inner { a: 20, b: 30 }),
+///             second <- new_spinlock_irq!(Inner { a: 10, b: 20 }),
+///         })
+///     }
+/// }
+///
+/// // Allocate a boxed `Example`
+/// let example = KBox::pin_init(Example::new(), GFP_KERNEL)?;
+///
+/// // Accessing an `Inner` from a context where we don't have a `LocalInterruptsDisabled` token
+/// // already.
+/// let bb = example.first.lock_with_new(|first, irq| {
+///     assert_eq!(example.c, 10);
+///     assert_eq!(first.a, 20);
+///
+///     // Since we already have a `LocalInterruptsDisabled` token, we can reuse it to acquire the
+///     // second lock. This allows us to skip changing the local interrupt state unnecessarily on
+///     // non-PREEMPT_RT kernels.
+///     let second = example.second.lock_with(irq);
+///     assert_eq!(second.a, 10);
+///
+///     (first.b, second.b)
+/// });
+///
+/// assert_eq!(bb, (30, 20));
+/// # Ok::<(), Error>(())
+/// ```
+pub type SpinLockIrq<T> = super::Lock<T, SpinLockIrqBackend>;
+
+/// A kernel `spinlock_t` lock backend that is acquired in no-irq contexts.
+pub struct SpinLockIrqBackend;
+
+unsafe impl super::Backend for SpinLockIrqBackend {
+    type State = bindings::spinlock_t;
+    type GuardState = ();
+    type Context<'a> = IrqDisabled<'a>;
+
+    unsafe fn init(
+        ptr: *mut Self::State,
+        name: *const core::ffi::c_char,
+        key: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
+        // `key` are valid for read indefinitely.
+        unsafe { bindings::__spin_lock_init(ptr, name, key) }
+    }
+
+    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        unsafe { bindings::spin_lock(ptr) }
+    }
+
+    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
+        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
+        // caller is the owner of the spinlock.
+        unsafe { bindings::spin_unlock(ptr) }
+    }
+
     unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
         let result = unsafe { bindings::spin_trylock(ptr) };
@@ -127,3 +245,30 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
         }
     }
 }
+
+impl super::BackendWithContext for SpinLockIrqBackend {
+    type ContextState = usize;
+
+    unsafe fn lock_with_context_saved<'a>(
+        ptr: *mut Self::State,
+    ) -> (Self::Context<'a>, Self::ContextState, Self::GuardState) {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        let flags = unsafe { bindings::spin_lock_irqsave(ptr) };
+
+        // SAFETY: We just disabled interrupts above
+        let context = unsafe { IrqDisabled::new() };
+
+        (context, flags, ())
+    }
+
+    unsafe fn unlock_with_context_restored(
+        ptr: *mut Self::State,
+        _guard_state: &Self::GuardState,
+        context_state: Self::ContextState,
+    ) {
+        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
+        // caller is the owner of the spinlock.
+        unsafe { bindings::spin_unlock_irqrestore(ptr, context_state) }
+    }
+}
-- 
2.47.0


