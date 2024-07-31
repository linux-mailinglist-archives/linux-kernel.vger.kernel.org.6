Return-Path: <linux-kernel+bounces-269943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C9943918
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE5D2859C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C516D9D2;
	Wed, 31 Jul 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sn6uXY6Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE816DEA5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465665; cv=none; b=MUDEhkf6iuDNjcEtx1tDs/6MfPDb5+GJtvlCdi/sotn1/1lm9iFhmpVK2VrtyvfCdzyAZ85NHh1/AHWgP6ZU8dVUBgjUbT2F+1lboR1QYezI3vaD7RgKSd5UI0tGof6YpoqzJCU0Jo+Lg/Af3UENXi5YwCOKKcUVY3Afo8xjicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465665; c=relaxed/simple;
	bh=rI9isKyV6iocP/wQhqiAf6L6MKq5bEnDPTAOCOq5HTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxO0jz2gM00tfn0JXxvvSa4NQlilJK4JW/vnrXp6ycIlDc3+pK+9W0DPvx0249WpcuP729EQpMrJzuqUIYLNUG5rwa5WKZDaN6k/93EyzQkqYQoXdo1E3XGQrIUBTOqqQOu33wQrBegxZaeF8ZK99K5DQdVtxrsxYi7NMLn62ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sn6uXY6Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722465662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ssQgQMnQaWmKnNrKbbGUWz8mRCvKROzX3DA2kHgDsHM=;
	b=Sn6uXY6Y4i176y4RkvhczwPEnLZaKlleWf0hzHz1Qb+twDdpxw7Rn8rpEFUlo0AWZI7vPq
	Zxi0FFpQZatKo7wcWmiMMx/tFwNqDfo3iAzNp4051ROBOXSqx5+G+TosRuVxVzPQbJcoa1
	uVyuKRhmxjCqYpLyeuM7L3PaSEf93yE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-8PDcrROiN3yYEs7isEzVPw-1; Wed,
 31 Jul 2024 18:40:57 -0400
X-MC-Unique: 8PDcrROiN3yYEs7isEzVPw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A066B19560AA;
	Wed, 31 Jul 2024 22:40:54 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.16.173])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38926300018D;
	Wed, 31 Jul 2024 22:40:50 +0000 (UTC)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] rust: sync: Add SpinLockIrq
Date: Wed, 31 Jul 2024 18:35:41 -0400
Message-ID: <20240731224027.232642-4-lyude@redhat.com>
In-Reply-To: <20240731224027.232642-1-lyude@redhat.com>
References: <20240731224027.232642-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A variant of SpinLock that is expected to be used in noirq contexts, and
thus requires that the user provide an kernel::irq::IrqDisabled to prove
they are in such a context upon lock acquisition. This is the rust
equivalent of spin_lock_irqsave()/spin_lock_irqrestore().

V2:
* s/IrqSpinLock/SpinLockIrq/
* Implement `lock::Backend` now that we have `Context`
* Add missing periods
* Make sure rustdoc examples compile correctly
* Add documentation suggestions

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock/spinlock.rs | 105 ++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletion(-)

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
index 8503d6e8e3de3..c31ea0458efbe 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -3,6 +3,8 @@
 //! A kernel spinlock.
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
+use core::marker::*;
+use kernel::irq::*;
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -116,3 +118,106 @@ unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
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
2.45.2


