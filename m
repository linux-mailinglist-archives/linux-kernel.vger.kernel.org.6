Return-Path: <linux-kernel+bounces-271935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69D5945527
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051ACB22810
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FBA79F3;
	Fri,  2 Aug 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XM3yKz4r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609C4C66
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557732; cv=none; b=DlgQDuqnWCvmqmQV8Y2LYIaoy/3YeuvBZ0/HDXA8yTVrPUhAwj3vuJWSerf8nqLwwQxJtE0tReOqIvDw0UC2gvVizZ8J6SC0EgvnRwdnnu4zsFxt5+9nS+8M5Ggp4EP1sAoNJgtY0V1SuQAIstkhqCDVLwJ+719o0pJFcqQDGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557732; c=relaxed/simple;
	bh=FTz/aSBk7vexNZ03yIVX4daWAg9rzW+O5qMtGXgbBPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfuMC6Opg8NGXGT1eiCoRVe4wD+qmwTdTpW+kEVlDRDMwyzZBFXVgRImwmW6HKgiCkyvCydqvVTV7+4wYzykYAMXFD36UUyvSwmXdLQZSXQKdlg1rXuGKKCdzic5ttSYZb29bEe2pcDyt0vU4n7ft50BjvQWW07XLIUP2tfLvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XM3yKz4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722557726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omjHxRL7Hd+aU8/rh9B4XM+SjNaLDALYjHJsTluRD/0=;
	b=XM3yKz4rYQN28pH/+IKizPT21V0IhyxOi4FJzqLYcxv+c47hESNnczL0TMslfXx4Qx4bn6
	bifbVpGtfIvFOztpkJdhvDiTz/6VLAmAWsWV8MTz5g4ftVj97DqY4OVdlORGs3LUQmuYXR
	oDu7rTRGFNufe9x2tHbl8gG6kel4Fb0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-02hIiOtuPMWKDSmfJBg9iw-1; Thu,
 01 Aug 2024 20:15:22 -0400
X-MC-Unique: 02hIiOtuPMWKDSmfJBg9iw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 847921955D4A;
	Fri,  2 Aug 2024 00:15:18 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.9.60])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C95EA1955D42;
	Fri,  2 Aug 2024 00:15:13 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH v3 1/3] rust: Introduce irq module
Date: Thu,  1 Aug 2024 20:10:00 -0400
Message-ID: <20240802001452.464985-2-lyude@redhat.com>
In-Reply-To: <20240802001452.464985-1-lyude@redhat.com>
References: <20240802001452.464985-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts
(with_irqs_disabled()) - along with the ability to annotate functions as
expecting that IRQs are already disabled on the local CPU.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V2:
* Actually make it so that we check whether or not we have interrupts
  disabled with debug assertions
* Fix issues in the documentation (added suggestions, missing periods, made
  sure that all rustdoc examples compile properly)
* Pass IrqDisabled by value, not reference
* Ensure that IrqDisabled is !Send and !Sync using
  PhantomData<(&'a (), *mut ())>
* Add all of the suggested derives from Benno Lossin

V3:
* Use `impl` for FnOnce bounds in with_irqs_disabled()
* Use higher-ranked trait bounds for the lifetime of with_irqs_disabled()
* Wording changes in the documentation for the module itself
---
 rust/helpers.c     | 22 ++++++++++++
 rust/kernel/irq.rs | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |  1 +
 3 files changed, 107 insertions(+)
 create mode 100644 rust/kernel/irq.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 92d3c03ae1bd5..42de410f92d63 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -85,6 +85,28 @@ void rust_helper_spin_unlock(spinlock_t *lock)
 }
 EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
 
+unsigned long rust_helper_local_irq_save(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	return flags;
+}
+EXPORT_SYMBOL_GPL(rust_helper_local_irq_save);
+
+void rust_helper_local_irq_restore(unsigned long flags)
+{
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_local_irq_restore);
+
+bool rust_helper_irqs_disabled(void)
+{
+	return irqs_disabled();
+}
+EXPORT_SYMBOL_GPL(rust_helper_irqs_disabled);
+
 void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
 {
 	init_wait(wq_entry);
diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
new file mode 100644
index 0000000000000..b52f8073e5cd0
--- /dev/null
+++ b/rust/kernel/irq.rs
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Interrupt controls
+//!
+//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
+//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
+//! that requires interrupts to be disabled.
+
+use bindings;
+use core::marker::*;
+
+/// A token that is only available in contexts where IRQs are disabled.
+///
+/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
+/// an [`IrqDisabled`] in order to indicate that they may only be run in IRQ-free contexts.
+///
+/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
+/// interrupts are disabled where required.
+///
+/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
+/// further information.
+#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
+pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
+
+impl IrqDisabled<'_> {
+    /// Create a new [`IrqDisabled`] without disabling interrupts.
+    ///
+    /// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
+    /// without interrupts. If debug assertions are enabled, this function will assert that
+    /// interrupts are disabled upon creation. Otherwise, it has no size or cost at runtime.
+    ///
+    /// # Panics
+    ///
+    /// If debug assertions are enabled, this function will panic if interrupts are not disabled
+    /// upon creation.
+    ///
+    /// # Safety
+    ///
+    /// This function must only be called in contexts where it is already known that interrupts have
+    /// been disabled for the current CPU, as the user is making a promise that they will remain
+    /// disabled at least until this [`IrqDisabled`] is dropped.
+    pub unsafe fn new() -> Self {
+        // SAFETY: FFI call with no special requirements
+        debug_assert!(unsafe { bindings::irqs_disabled() });
+
+        Self(PhantomData)
+    }
+}
+
+/// Run the closure `cb` with interrupts disabled on the local CPU.
+///
+/// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
+/// without interrupts.
+///
+/// # Examples
+///
+/// Using [`with_irqs_disabled`] to call a function that can only be called with interrupts
+/// disabled:
+///
+/// ```
+/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
+///
+/// // Requiring interrupts be disabled to call a function
+/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
+///     /* When this token is available, IRQs are known to be disabled. Actions that rely on this
+///      * can be safely performed
+///      */
+/// }
+///
+/// // Disabling interrupts. They'll be re-enabled once this closure completes.
+/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
+/// ```
+#[inline]
+pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {
+    // SAFETY: FFI call with no special requirements
+    let flags = unsafe { bindings::local_irq_save() };
+
+    let ret = cb(IrqDisabled(PhantomData));
+
+    // SAFETY: `flags` comes from our previous call to local_irq_save
+    unsafe { bindings::local_irq_restore(flags) };
+
+    ret
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 274bdc1b0a824..ead3a7ca5ba11 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub mod firmware;
 pub mod init;
 pub mod ioctl;
+pub mod irq;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 #[cfg(CONFIG_NET)]
-- 
2.45.2


