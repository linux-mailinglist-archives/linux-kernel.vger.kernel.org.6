Return-Path: <linux-kernel+bounces-372538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB9D9A4A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A491C21774
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C11917D6;
	Fri, 18 Oct 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmTlJZ1Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87819046E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293812; cv=none; b=CdRl5DNdencLcgJ2olBurbbYpwhzJf3YwTtkEoYiXiJIqfMSuCCze9/VyvF0hiVrnPtXiTfnaapsk+VnXHB4CzHRdishrr+hxnsRd/INfEPowXqErMnpCdrWLjAwNKDT/bhNNdR2FuZ9rDbnERZqmmThqqc7aXjbE1LtgrjWP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293812; c=relaxed/simple;
	bh=VrbmIuO/RIhlXdFNhariGcGO4aTnceCtMQqUUGRgUgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjaC4jx1d/1ZmEYGzrGoXVSCvh3gVorA8btrn2V/oc5rzm6aCl4ng8CfrDq59Fp6CmvTokOdHL5oNBhBv1ltEcPTFlzj5xU0JAj3skW1nv6Uso8gzTSQrD10Ujn2TuDaAeKUC8xEb1tzetOgvGIWYG5/hb2IO74wm/eYSKXJAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmTlJZ1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729293809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpCf4GnRsBzVG5NDqyR9YwYCDPi3z83zps8lDdRr5FA=;
	b=WmTlJZ1Qg85V6E1Yg+uzZbkBsTWFx3NzvTSuMiWQJN9OBqBEz6megQO7vt5da+MgQgNkNr
	nHK0u8ZY9tNw0Gvklmui2r9qpIL2yuTS4Lno4D/JA46Um1Vzpm1HxaNCkiHR2doBL8EBhL
	XU10XAVU+mfEEQA/Csm9p789VmAtbTs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-7JMYh_gDNjSMqgT6wa62oQ-1; Fri,
 18 Oct 2024 19:23:26 -0400
X-MC-Unique: 7JMYh_gDNjSMqgT6wa62oQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9237019560B1;
	Fri, 18 Oct 2024 23:23:23 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D388B19560A2;
	Fri, 18 Oct 2024 23:23:18 +0000 (UTC)
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
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH v8 1/3] rust: Introduce local_irq module
Date: Fri, 18 Oct 2024 19:22:25 -0400
Message-ID: <20241018232306.476664-2-lyude@redhat.com>
In-Reply-To: <20241018232306.476664-1-lyude@redhat.com>
References: <20241018232306.476664-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This introduces a module for adding marker types to indicate the type of
interrupt context a function is called in. Note that nothing here enables
or disables interrupts on its own, this is simply for verifying correctness
at compile-time.

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

V5:
* Rebase against rust-next for the helpers split
* Fix typo (enabled -> disabled) - Dirk

V6:
* s/indicate/require/ in IrqDisabled docs
* Reword comment above with_irqs_disabled in code example requested by
  Benno
* Add paragraph to with_irqs_disabled docs requested by Benno
* Apply the comments from Boqun's review for V4 that I missed
* Document type invariants of `IrqDisabled`

V7:
* Change name of module to local_irq.rs
* Remove with_interrupts_disabled()
* Update documentation wording a bit to make mention of PREEMPT_RT

This patch depends on
https://lore.kernel.org/rust-for-linux/20240808-alice-file-v9-1-2cb7b934e0e1@google.com/

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/helpers/helpers.c   |  1 +
 rust/helpers/irq.c       |  8 ++++++
 rust/kernel/lib.rs       |  1 +
 rust/kernel/local_irq.rs | 56 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)
 create mode 100644 rust/helpers/irq.c
 create mode 100644 rust/kernel/local_irq.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 20a0c69d5cc7b..fd70afe5069ca 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "err.c"
+#include "irq.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
new file mode 100644
index 0000000000000..d129094cc1940
--- /dev/null
+++ b/rust/helpers/irq.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/irqflags.h>
+
+bool rust_helper_irqs_disabled(void)
+{
+	return irqs_disabled();
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 620de74d128f9..b7e604bc968ce 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;
+pub mod local_irq;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
diff --git a/rust/kernel/local_irq.rs b/rust/kernel/local_irq.rs
new file mode 100644
index 0000000000000..e9e82347392c7
--- /dev/null
+++ b/rust/kernel/local_irq.rs
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Interrupt controls
+//!
+//! This module allows Rust code to annotate functions which can only be called in contexts where
+//! local interrupts on the CPU may be disabled.
+
+use crate::types::NotThreadSafe;
+use bindings;
+use core::marker::*;
+
+/// A token that is only available in contexts where interrupts are disabled on non-PREEMPT_RT
+/// kernels.
+///
+/// [`IrqDisabled`] is marker made available when local processor interrupts are disabled on
+/// non-PREEMPT_RT kernels. A function may require a [`IrqDisabled`] to ensure that functions may
+/// only be run with processor interrupts disabled on such kernels.
+///
+/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
+/// interrupts are disabled where required.
+///
+/// # Invariants
+///
+/// On kernels where `CONFIG_PREEMPT_RT=n` is set in the kernel config, local processor interrupts
+/// are disabled whenever an object of this type exists.
+#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
+pub struct IrqDisabled<'a>(PhantomData<(&'a (), NotThreadSafe)>);
+
+impl IrqDisabled<'_> {
+    /// Create a new [`IrqDisabled`] token in an interrupt disabled context.
+    ///
+    /// This creates a [`IrqDisabled`] token, which can be passed to functions that must
+    /// be run without interrupts on kernels where `CONFIG_PREEMPT_RT=n`. If debug assertions are
+    /// enabled, this function will assert that interrupts match the expected state. Otherwise, it
+    /// has no size or cost at runtime.
+    ///
+    /// # Panics
+    ///
+    /// If debug assertions are enabled, then this function will assert on non-PREEMPT_RT kernels
+    /// that local processor interrupts are disabled upon creation.
+    ///
+    /// # Safety
+    ///
+    /// This function must only be called in contexts where it is known that on a non-PREEMPT_RT
+    /// kernel, local interrupts have been disabled for the current CPU. The user is making a
+    /// promise that they will remain disabled at least until this [`IrqDisabled`] is
+    /// dropped.
+    pub unsafe fn new() -> Self {
+        // SAFETY: FFI call with no special requirements
+        debug_assert!(unsafe { bindings::irqs_disabled() });
+
+        // INVARIANT: The safety requirements of this function ensure that IRQs are disabled on
+        // non-PREEMPT_RT kernels.
+        Self(PhantomData)
+    }
+}
-- 
2.47.0


