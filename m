Return-Path: <linux-kernel+bounces-331135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E5497A8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE276B2A808
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC36188A16;
	Mon, 16 Sep 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq8HVv43"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BC188584
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522273; cv=none; b=HNzSh5nOGRUSPM0ix2yNG83g0iFmpFnljcBODZzi1gjps2aLd6986hZhVGOUgCdusAn5dwTzjxZGPsBmAAfh8AO+yNoUZjgvZdGoYR+e1dOA58EQBlDb8M/PfK0tIclDGFs0j1ackcW6tlqf2K+wJ4hUgytogI0QWDdWqriPYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522273; c=relaxed/simple;
	bh=J+Kj5kWHLs8eu489PKMmCyDBzk9cLXe8MqLBnhAzMxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7XbPtYTmxIwIwadD1QcNnWwHe7VzeyDqUK+5iuCUAz0GrdV64j4QZLCbSDmMqf7dHQqjH0DoW3qPM+la0tUf0TjlrFDcFnA2bQ9TeDZ+Z2I+fjVNfXfGMcKPkJbI8ZhGY7Ef37wmuQ3o1Y+3Xx4dZx8ltp7IEaKF0bXSs9FiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nq8HVv43; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726522270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oIvdAsWFPJzZrabfZBBzhpeBee144e8PLeqisrxPnQ=;
	b=Nq8HVv43RBaWeJkSvbfWJeNWf+jZdW9aLgIQjuU0+JU2sIQJYqy1dMgzAztvj/atNxVkux
	un10OprsTpccay3VHAI+KyoXwFoKayqgXfVprLFB9d0Vo+PcSYbTmAyJyxSZLtomF1jQ4Y
	NrG2os9tZB8+xOqFkQnMU+XY8IswRFY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-ZueokHCwNm2jw6RfDptEbA-1; Mon,
 16 Sep 2024 17:31:05 -0400
X-MC-Unique: ZueokHCwNm2jw6RfDptEbA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9AAC1955DCC;
	Mon, 16 Sep 2024 21:31:02 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.33.131])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8484619560AF;
	Mon, 16 Sep 2024 21:30:58 +0000 (UTC)
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
Subject: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
Date: Mon, 16 Sep 2024 17:28:06 -0400
Message-ID: <20240916213025.477225-4-lyude@redhat.com>
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

A variant of SpinLock that is expected to be used in noirq contexts, and
thus requires that the user provide an kernel::irq::IrqDisabled to prove
they are in such a context upon lock acquisition. This is the rust
equivalent of spin_lock_irqsave()/spin_lock_irqrestore().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>

---

V2:
* s/IrqSpinLock/SpinLockIrq/
* Implement `lock::Backend` now that we have `Context`
* Add missing periods
* Make sure rustdoc examples compile correctly
* Add documentation suggestions

---
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock/spinlock.rs | 104 ++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

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
index 97d85a5576615..47c71d779062a 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -3,6 +3,7 @@
 //! A kernel spinlock.
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
+use kernel::irq::*;
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -116,3 +117,106 @@ unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         unsafe { bindings::spin_unlock(ptr) }
     }
 }
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
+/// that contains an inner struct (`Inner`) that is protected by a spinlock.
+///
+/// ```
+/// use kernel::{
+///     sync::{new_spinlock_irq, SpinLockIrq},
+///     irq::{with_irqs_disabled, IrqDisabled}
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
+///     d: SpinLockIrq<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             c: 10,
+///             d <- new_spinlock_irq!(Inner { a: 20, b: 30 }),
+///         })
+///     }
+/// }
+///
+/// // Accessing an `Example` from a function that can only be called in no-irq contexts
+/// fn noirq_work(e: &Example, irq: IrqDisabled<'_>) {
+///     assert_eq!(e.c, 10);
+///     assert_eq!(e.d.lock_with(irq).a, 20);
+/// }
+///
+/// // Allocate a boxed `Example`
+/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
+///
+/// // Accessing an `Example` from a context where IRQs may not be disabled already.
+/// let b = with_irqs_disabled(|irq| {
+///     noirq_work(&e, irq);
+///     e.d.lock_with(irq).b
+/// });
+/// assert_eq!(b, 30);
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
+}
-- 
2.46.0


