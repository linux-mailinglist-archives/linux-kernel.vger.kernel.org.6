Return-Path: <linux-kernel+bounces-325787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A372975E40
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6171F23BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2521DA4E;
	Thu, 12 Sep 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ct4JHUu4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E7364A0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102566; cv=none; b=fzxug+LAjxlOjUaBxfyQofW9WRjtyR1H0QVqC+8an1Qnh5lE3zKL0Y5GETacJrEvw9Q9+iwpYPKzPcz+qaNdqxKL3K63we2H5nvm7OnWuM+4cCVsT/iCElOdjD6P7APHdpsb76DiYLnRDvmvFsjDtBGC7Wm7wRC2Vbazu156dM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102566; c=relaxed/simple;
	bh=IHo0uSOltaBJr8UuIMcTYV2YjKv8jDMpUcJssUlPw4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdkYGHe7JK/f0CU+w8p59d5oS2ueno2k2sXsLB5SyUBXjIiBH7fp2e3JP6xWSj3HzyOmm0rVQQWpCvLPIMtaPtxy2lRBYWJPvpKEVyxZA1eWE3FihkZ7dSL1/szEmXtvpqrXdwNXFMlYoT/GhVfeO5W2LOMbKbiC6Y7ytDnKUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ct4JHUu4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726102563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV6uZZ7VY4Zuc/RL2EhDsFfqQYGyvlgMpNedl52eFGE=;
	b=Ct4JHUu4Jup4sSEPslE9RsmDd1LyqDtXkFnsCg6EbccbgahYXGo2txoio8FBaTImp0jmwj
	3dw0nAWyaPdaSRY40YvX6Ur/ttD32oAnFMCVMCnZGgU4MwRvE1j9bLHSf9jTDxan2QuNn5
	UbgrEinc+kSbQuH2iJY7teZl3uZxwso=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-2Z2G1uMZNz-c1_FnmgycGw-1; Wed,
 11 Sep 2024 20:55:58 -0400
X-MC-Unique: 2Z2G1uMZNz-c1_FnmgycGw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B00621956077;
	Thu, 12 Sep 2024 00:55:55 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.32.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2054119560B1;
	Thu, 12 Sep 2024 00:55:48 +0000 (UTC)
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
	Asahi Lina <lina@asahilina.net>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH v4 1/3] rust: Introduce irq module
Date: Wed, 11 Sep 2024 20:55:32 -0400
Message-ID: <20240912005539.175428-2-lyude@redhat.com>
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

V4:
* Use the actual unsafe constructor for IrqDisabled in
  with_irqs_disabled()
* Fix comment style in with_irqs_disabled example
* Check before calling local_irq_restore() in with_irqs_disabled that
  interrupts are still disabled. It would have been nice to do this from a
  Drop implementation like I hoped, but I realized rust doesn't allow that
  for types that implement Copy.
* Document that interrupts can't be re-enabled within the `cb` provided to
  `with_irqs_disabled`, and link to the github issue I just filed about
  this that describes the solution for this.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/helpers.c     | 23 ++++++++++++
 rust/kernel/irq.rs | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |  1 +
 3 files changed, 114 insertions(+)
 create mode 100644 rust/kernel/irq.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 92d3c03ae1bd5..c6109358675ae 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -26,6 +26,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/irqflags.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
@@ -85,6 +86,28 @@ void rust_helper_spin_unlock(spinlock_t *lock)
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
index 0000000000000..8dd153ba10bde
--- /dev/null
+++ b/rust/kernel/irq.rs
@@ -0,0 +1,90 @@
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
+/// without interrupts. Note that interrupts must be disabled for the entire duration of `cb`, they
+/// cannot be re-enabled. In the future, this may be expanded on
+/// [as documented here](https://github.com/Rust-for-Linux/linux/issues/1115).
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
+///     // When this token is available, IRQs are known to be disabled. Actions that rely on this
+///     // can be safely performed
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
+    // SAFETY: We just disabled IRQs using `local_irq_save()`
+    let ret = cb(unsafe { IrqDisabled::new() });
+
+    // Confirm that IRQs are still enabled now that the callback has finished
+    // SAFETY: FFI call with no special requirements
+    debug_assert!(unsafe { bindings::irqs_disabled() });
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
2.46.0


