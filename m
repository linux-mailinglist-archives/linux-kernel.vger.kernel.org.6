Return-Path: <linux-kernel+bounces-269941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4742943916
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D391F22365
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145316D9A8;
	Wed, 31 Jul 2024 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdhAALxr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49A16C68F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465654; cv=none; b=gFj53PTVHI3QKdG9tjuJEei+sHpU95DQcnpKEP9lW63UL4WtTHd4djkvRcitY1+k9jiuLVLMnxrwvdXEEsGtO2y6bgggCPUkzJp6hRbNjPE/H1FnLw57I0fmDznYy9ZLyPKDzzcKjc68xuLdOzx1Uykhv5vzrvCrIXHjwqO0h4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465654; c=relaxed/simple;
	bh=D+xqB7QZ+U41MAtuu8qP7YpEJJ9ccNhbDn+BUdimlug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEH+wJo4GzEON0zkxmjjX/Jjw6nGMp3EY4lJDJpY6XFTFhZvo58qb+48+C81QGYe2e5pDe7W/cDKjDx7UD13SQVErQZAXeHmgJs4zcHUP71zA9ByhZjM1vB6D6DUHbCQiMViZxMXHLNULa4w3UOhkMrw6KIcKslsPtme/SfjyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdhAALxr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722465651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQ69meUnXF981oBqKVYehrvEv7xZ1o51stokMqwXltk=;
	b=hdhAALxrHPHsuLv4wGC20uhjZ7hK2TwilwdwinBbuihbc07sct4apautAxM+Y498JvQcHd
	D6DV7kVwgcNR7ctL0ePwbl1LdqHCsMH//em67ujW5PygLesImMvNtDfR1B0BGljj6hbOyq
	yoiTi2rLBji7ZkORFpD2wThtfr7PVgs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-HFV50Z_ONoaDG2Bk6xK6QQ-1; Wed,
 31 Jul 2024 18:40:45 -0400
X-MC-Unique: HFV50Z_ONoaDG2Bk6xK6QQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 992FA19560B3;
	Wed, 31 Jul 2024 22:40:42 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.16.173])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CDEA300019A;
	Wed, 31 Jul 2024 22:40:37 +0000 (UTC)
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] rust: Introduce irq module
Date: Wed, 31 Jul 2024 18:35:39 -0400
Message-ID: <20240731224027.232642-2-lyude@redhat.com>
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

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts
(with_irqs_disabled()) - along with the ability to annotate functions as
expecting that IRQs are already disabled on the local CPU.

V2:
* Actually make it so that we check whether or not we have interrupts
  disabled with debug assertions
* Fix issues in the documentation (added suggestions, missing periods, made
  sure that all rustdoc examples compile properly)
* Pass IrqDisabled by value, not reference
* Ensure that IrqDisabled is !Send and !Sync using
  PhantomData<(&'a (), *mut ())>
* Add all of the suggested derives from Benno Lossin

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/helpers.c     | 22 ++++++++++++
 rust/kernel/irq.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |  1 +
 3 files changed, 110 insertions(+)
 create mode 100644 rust/kernel/irq.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 87ed0a5b60990..b0afe14372ae3 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -69,6 +69,28 @@ void rust_helper_spin_unlock(spinlock_t *lock)
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
index 0000000000000..e50110f92f3fa
--- /dev/null
+++ b/rust/kernel/irq.rs
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Interrupt controls
+//!
+//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
+//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
+//! that requires that interrupts already be disabled.
+
+use bindings;
+use core::marker::*;
+
+/// A token that is only available in contexts where IRQs are disabled.
+///
+/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
+/// an `IrqDisabled` in order to indicate that they may only be run in IRQ-free contexts.
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
+pub fn with_irqs_disabled<'a, T, F>(cb: F) -> T
+where
+    F: FnOnce(IrqDisabled<'a>) -> T,
+{
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
index e6b7d3a80bbce..37835ccd51087 100644
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


