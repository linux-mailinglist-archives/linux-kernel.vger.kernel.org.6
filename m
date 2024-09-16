Return-Path: <linux-kernel+bounces-331133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2797A8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F3B28B83A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47106166F23;
	Mon, 16 Sep 2024 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cryZY1Ao"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004C161901
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522260; cv=none; b=NFnGzRjqHNx3a8f1NJfBAfr5YYNIH9C/DL+6Tcw82osXB9v3vjCiAgVcjxeCntdSDH5jQm+DTi4Jm0ldkdRD6F43TQ8siCJk1gKQDTIPE7z03hj44vgyvh00wezHSYXCw54zANlDFIfsrE4OsGps2rJ717HiLud6NGwEIeIhhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522260; c=relaxed/simple;
	bh=DxfwT1900XZXuYGlBv1oxtMMt5z2k8aI1dGfwNKmF/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERmdgKQZNR1p8IZYunEuISEKWeghjhLZI6MjaKFwm0L0ry9bGmytOKX0T1jaMoS1Yzn+KIikgxKCv1TwiFDw2AchHb9hpO6Vw3TtWK8ZeF7GQ/vmWbjPxQLXe5URYeZKH5LVYbQwYnCSxXxUO66p3s6kgE4jslXGB7Gu0zIz598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cryZY1Ao; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726522257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8JtzXJd3Q6A2pTo2LhqKWBKCG8VcunU698ubws6Z9E=;
	b=cryZY1AoumzI2JnV+PiNchKIotRB4pGAM6T+nKshtzsRQEuOygZP04tZQC787NJEUdqyR2
	o6mU+avx5qolCzR2jperPe46/PiDIImau3iU5W9Uuj4HSUt21FyzNduNVC5bF/7s3Y66rq
	+ftvY3ivll/sEKnhihPpQ1OXR5dL2Eo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-VXhoRwXlPiKHNzlzJRhKIA-1; Mon,
 16 Sep 2024 17:30:54 -0400
X-MC-Unique: VXhoRwXlPiKHNzlzJRhKIA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BDE419560B5;
	Mon, 16 Sep 2024 21:30:51 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.33.131])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4A7019560AF;
	Mon, 16 Sep 2024 21:30:46 +0000 (UTC)
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH v6 1/3] rust: Introduce irq module
Date: Mon, 16 Sep 2024 17:28:04 -0400
Message-ID: <20240916213025.477225-2-lyude@redhat.com>
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

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts
(with_irqs_disabled()) - along with the ability to annotate functions as
expecting that IRQs are already disabled on the local CPU.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>

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

This patch depends on
https://lore.kernel.org/rust-for-linux/ZuKNszXSw-LbgW1e@boqun-archlinux/

---
 rust/helpers/helpers.c |  1 +
 rust/helpers/irq.c     | 22 ++++++++++
 rust/kernel/irq.rs     | 96 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |  1 +
 4 files changed, 120 insertions(+)
 create mode 100644 rust/helpers/irq.c
 create mode 100644 rust/kernel/irq.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a96..0bb48df454bd8 100644
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
index 0000000000000..ec1e8d700a220
--- /dev/null
+++ b/rust/helpers/irq.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/irqflags.h>
+
+unsigned long rust_helper_local_irq_save(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	return flags;
+}
+
+void rust_helper_local_irq_restore(unsigned long flags)
+{
+	local_irq_restore(flags);
+}
+
+bool rust_helper_irqs_disabled(void)
+{
+	return irqs_disabled();
+}
diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
new file mode 100644
index 0000000000000..ee3a4549aa389
--- /dev/null
+++ b/rust/kernel/irq.rs
@@ -0,0 +1,96 @@
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
+use crate::types::NotThreadSafe;
+
+/// A token that is only available in contexts where IRQs are disabled.
+///
+/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
+/// an [`IrqDisabled`] in order to require that they may only be run in IRQ-free contexts.
+///
+/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
+/// interrupts are disabled where required.
+///
+/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
+/// further information.
+///
+/// # Invariants
+///
+/// IRQs are disabled when an object of this type exists.
+#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
+pub struct IrqDisabled<'a>(PhantomData<(&'a (), NotThreadSafe)>);
+
+impl IrqDisabled<'_> {
+    /// Create a new [`IrqDisabled`] token in an interrupt disabled context.
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
+    /// been disabled for the current CPU, and the user is making a promise that they will remain
+    /// disabled at least until this [`IrqDisabled`] is dropped.
+    pub unsafe fn new() -> Self {
+        // SAFETY: FFI call with no special requirements
+        debug_assert!(unsafe { bindings::irqs_disabled() });
+
+        // INVARIANT: The safety requirements of this function ensure that IRQs are disabled.
+        Self(PhantomData)
+    }
+}
+
+/// Run the closure `cb` with interrupts disabled on the local CPU.
+///
+/// This disables interrupts, creates an [`IrqDisabled`] token and passes it to `cb`. The previous
+/// interrupt state will be restored once the closure completes. Note that interrupts must be
+/// disabled for the entire duration of `cb`, they cannot be re-enabled. In the future, this may be
+/// expanded on [as documented here](https://github.com/Rust-for-Linux/linux/issues/1115).
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
+/// // Disables interrupts, their previous state will be restored once the closure completes.
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
+    // Confirm that IRQs are still disabled now that the callback has finished
+    // SAFETY: FFI call with no special requirements
+    debug_assert!(unsafe { bindings::irqs_disabled() });
+
+    // SAFETY: `flags` comes from our previous call to local_irq_save
+    unsafe { bindings::local_irq_restore(flags) };
+
+    ret
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f10b06a78b9d5..df10c58e95c19 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub mod firmware;
 pub mod init;
 pub mod ioctl;
+pub mod irq;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;
-- 
2.46.0


