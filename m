Return-Path: <linux-kernel+bounces-537398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C12A48B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB813188E8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC7827561C;
	Thu, 27 Feb 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqFU+Ues"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A6274275
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694909; cv=none; b=S6Du7T+6/a6qjTtoRU/hnQehDukA/rNcLo45C9sCdjyfSmoa8xenVAyqih87jUnhnTdb8rIUKJ783Zc1eeUPDPJThrdp0xN/UUuqaGeOhB4tmyOe+pr/WXeOM+q4+hkZuNbBXYe14aYS7xPXzeFcH7Juz+pGcvhHdfn940gPah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694909; c=relaxed/simple;
	bh=Gn053GM2Abjd+PYYXKPIhOxoTjWxmwIsrAFVaoI8P7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7c4FRMoxIDdlSjeQMXObeuxts+MegQIo1/qeCCkE/lyKWgcrCIf/76iC8dPWAFbb6VovzCks4RYritBP+L0kyESTfSzOXjI8uWR+Qzg/bSU/PGlFIckkX5gGMuWiWl8qerwRso0O9qcs1QZpm97yI99Ekh4gR2ETRw+3xzjAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqFU+Ues; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740694906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNfuVRXbdV3QSs7L7dZ5xaq3013JiOtfh5vtoOmlaG0=;
	b=hqFU+UesNWXuxaZLV6b+7vq7GdMJzg3VC2A5Fa3jtWp/NDv2DRptj3HTJ/my452Ef4g6m8
	Ll23YMcE+XcYy+faqwmGeCDrCsQirZIJcyTw95cgB3Yee4CMIpRRJhyuB6VG8zjxUjXm0t
	ZUBwE/BPqkaP/caOkncHYqFgAsjsazI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-t0s8vf8mMB6C4EQ1kvz7Hg-1; Thu,
 27 Feb 2025 17:21:43 -0500
X-MC-Unique: t0s8vf8mMB6C4EQ1kvz7Hg-1
X-Mimecast-MFC-AGG-ID: t0s8vf8mMB6C4EQ1kvz7Hg_1740694901
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D03F81800984;
	Thu, 27 Feb 2025 22:21:40 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.89.128])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40F8D1944D02;
	Thu, 27 Feb 2025 22:21:37 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 4/9] rust: Introduce interrupt module
Date: Thu, 27 Feb 2025 17:10:15 -0500
Message-ID: <20250227221924.265259-5-lyude@redhat.com>
In-Reply-To: <20250227221924.265259-1-lyude@redhat.com>
References: <20250227221924.265259-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts along with the
ability to annotate functions as expecting that IRQs are already
disabled on the local CPU.

[Boqun: This is based on Lyude's work on interrupt disable abstraction,
I port to the new local_interrupt_disable() mechanism to make it work
as a guard type. I cannot even take the credit of this design, since
Lyude also brought up the same idea in zulip. Anyway, this is only for
POC purpose, and of course all bugs are mine]

Signed-off-by: Lyude Paul <lyude@redhat.com>
Co-Developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/helpers.c   |  1 +
 rust/helpers/interrupt.c | 18 +++++++++
 rust/kernel/interrupt.rs | 83 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |  1 +
 4 files changed, 103 insertions(+)
 create mode 100644 rust/helpers/interrupt.c
 create mode 100644 rust/kernel/interrupt.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be1..14e85c1a37bb2 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -15,6 +15,7 @@
 #include "device.c"
 #include "err.c"
 #include "fs.c"
+#include "interrupt.c"
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
diff --git a/rust/helpers/interrupt.c b/rust/helpers/interrupt.c
new file mode 100644
index 0000000000000..f2380dd461ca5
--- /dev/null
+++ b/rust/helpers/interrupt.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/spinlock.h>
+
+void rust_helper_local_interrupt_disable(void)
+{
+	local_interrupt_disable();
+}
+
+void rust_helper_local_interrupt_enable(void)
+{
+	local_interrupt_enable();
+}
+
+bool rust_helper_irqs_disabled(void)
+{
+	return irqs_disabled();
+}
diff --git a/rust/kernel/interrupt.rs b/rust/kernel/interrupt.rs
new file mode 100644
index 0000000000000..c0a4b182fd9e7
--- /dev/null
+++ b/rust/kernel/interrupt.rs
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Interrupt controls
+//!
+//! This module allows Rust code to annotate areas of code where local processor interrupts should
+//! be disabled, along with actually disabling local processor interrupts.
+//!
+//! # ⚠️ Warning! ⚠️
+//!
+//! The usage of this module can be more complicated then meets the eye, especially surrounding
+//! [preemptible kernels]. It's recommended to take care when using the functions and types defined
+//! here and familiarize yourself with the various documentation we have before using them, along
+//! with the various documents we link to here.
+//!
+//! # Reading material
+//!
+//! - [Software interrupts and realtime (LWN)](https://lwn.net/Articles/520076)
+//!
+//! [preemptible kernels]: https://www.kernel.org/doc/html/latest/locking/preempt-locking.html
+
+use bindings;
+use kernel::types::NotThreadSafe;
+
+/// A guard that represents local processor interrupt disablement on preemptible kernels.
+///
+/// [`LocalInterruptDisabled`] is a guard type that represents that local processor interrupts have
+/// been disabled on a preemptible kernel.
+///
+/// Certain functions take an immutable reference of [`LocalInterruptDisabled`] in order to require
+/// that they may only be run in local-interrupt-disabled contexts on preemptible kernels.
+///
+/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that local
+/// processor interrupts interrupts are disabled on preemptible kernels. Note that no guarantees
+/// about the state of interrupts are made by this type on non-preemptible kernels.
+///
+/// # Invariants
+///
+/// Local processor interrupts are disabled on preemptible kernels for as long as an object of this
+/// type exists.
+pub struct LocalInterruptDisabled(NotThreadSafe);
+
+/// Disable local processor interrupts on a preemptible kernel.
+///
+/// This function disables local processor interrupts on a preemptible kernel, and returns a
+/// [`LocalInterruptDisabled`] token as proof of this. On non-preemptible kernels, this function is
+/// a no-op.
+///
+/// **Usage of this function is discouraged** unless you are absolutely sure you know what you are
+/// doing, as kernel interfaces for rust that deal with interrupt state will typically handle local
+/// processor interrupt state management on their own and managing this by hand is quite error
+/// prone.
+pub fn local_interrupt_disable() -> LocalInterruptDisabled {
+    // SAFETY: It's always safe to call `local_interrupt_disable()`.
+    unsafe { bindings::local_interrupt_disable() };
+
+    LocalInterruptDisabled(NotThreadSafe)
+}
+
+impl Drop for LocalInterruptDisabled {
+    fn drop(&mut self) {
+        // SAFETY: Per type invariants, a `local_interrupt_disable()` must be called to create this
+        // object, hence call the corresponding `local_interrupt_enable()` is safe.
+        unsafe { bindings::local_interrupt_enable() };
+    }
+}
+
+impl LocalInterruptDisabled {
+    const ASSUME_DISABLED: &'static LocalInterruptDisabled = &LocalInterruptDisabled(NotThreadSafe);
+
+    /// Assume that local processor interrupts are disabled on preemptible kernels.
+    ///
+    /// This can be used for annotating code that is known to be run in contexts where local
+    /// processor interrupts are disabled on preemptible kernels. It makes no changes to the local
+    /// interrupt state on its own.
+    ///
+    /// # Safety
+    ///
+    /// For the whole life `'a`, local interrupts must be disabled on preemptible kernels. This
+    /// could be a context like for example, an interrupt handler.
+    pub unsafe fn assume_disabled<'a>() -> &'a LocalInterruptDisabled {
+        Self::ASSUME_DISABLED
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911a..2b02c1f67fdd2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -50,6 +50,7 @@
 pub mod firmware;
 pub mod fs;
 pub mod init;
+pub mod interrupt;
 pub mod io;
 pub mod ioctl;
 pub mod jump_label;
-- 
2.48.1


