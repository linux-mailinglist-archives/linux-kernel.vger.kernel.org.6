Return-Path: <linux-kernel+bounces-262687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCD093CADB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6F01C214DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57F145A0B;
	Thu, 25 Jul 2024 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erzXmusx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592613D8A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946533; cv=none; b=I8PAqu4du94w5KBwbnFNksNR9ArfDtFlaoPimL3DODvqRK/LMGnDLneKxuoSsHqabMZxLpZ/OdhZKpq2gVHG0Jhz2sm8lKQ2lw+bV9jxE5lWLMwg9dtM6zB18AmaEHrZWExR7mC9wok9H1sVQGfojIMQcIi1VNR2Tp5YpDSzJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946533; c=relaxed/simple;
	bh=6poooE4/Vj63Q++XdjL9Rrlv4VS/Q9OIkaJPfz+S9i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLoQucyT/HeMQoNIh+PB9quFNk6TU8dUuqj0k/r8Ec1MHds7GCzEvak7cjgbN8ZmdYB7p0aFrqifs9PEjiYk15I1lnABWaiB/9aAmjPFSY9r1Yb2Kba2r85F3GbI3eZVrQyR569bUsxEkSVOKSHJ7tFzhrN4HTD54WPAeeGuJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erzXmusx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721946531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvHSNNVvGvStasuVppfgiU1uxdltPfci54gfrkbDQh8=;
	b=erzXmusxOaPhndBtct7z425Bvc27fv1smoQpy6oGnXCfTQFaNDwVPdYvW3Rby98CGzzFsD
	qs5l3ybBxR4KK29qiCdTW0gmMOnGBLuUnIU/C9tszcyzqPmBFogXSVWydZBIL8cP0bt0kF
	X4PwaGHqhkbcAJOTuddkrQSgIQE3I8Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-yywUgwz_P8mgc4wboyZNaA-1; Thu,
 25 Jul 2024 18:28:47 -0400
X-MC-Unique: yywUgwz_P8mgc4wboyZNaA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CA4019560B6;
	Thu, 25 Jul 2024 22:28:45 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.33.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C09E03000194;
	Thu, 25 Jul 2024 22:28:39 +0000 (UTC)
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
Subject: [PATCH 1/3] rust: Introduce irq module
Date: Thu, 25 Jul 2024 18:27:50 -0400
Message-ID: <20240725222822.1784931-2-lyude@redhat.com>
In-Reply-To: <20240725222822.1784931-1-lyude@redhat.com>
References: <20240725222822.1784931-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts
(with_irqs_disabled()) - along with the ability to annotate functions as
expecting that IRQs are already disabled on the local CPU.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/helpers.c     | 14 +++++++++
 rust/kernel/irq.rs | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |  1 +
 3 files changed, 89 insertions(+)
 create mode 100644 rust/kernel/irq.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 87ed0a5b60990..12ac32de820b5 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -69,6 +69,20 @@ void rust_helper_spin_unlock(spinlock_t *lock)
 }
 EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
 
+unsigned long rust_helper_local_irq_save(void) {
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	return flags;
+}
+EXPORT_SYMBOL_GPL(rust_helper_local_irq_save);
+
+void rust_helper_local_irq_restore(unsigned long flags) {
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_local_irq_restore);
+
 void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
 {
 	init_wait(wq_entry);
diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
new file mode 100644
index 0000000000000..8a540bd6123f7
--- /dev/null
+++ b/rust/kernel/irq.rs
@@ -0,0 +1,74 @@
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
+/// A guarantee that IRQs are disabled on this CPU
+///
+/// An [`IrqDisabled`] represents a guarantee that interrupts will remain disabled on the current CPU
+/// until the lifetime of the object ends. However, it does not disable or enable interrupts on its
+/// own - see [`with_irqs_disabled()`] for that.
+///
+/// This object has no cost at runtime (TODO: …except if whatever kernel compile-time option that
+/// would assert IRQs are enabled or not is enabled - in which case we should actually verify that
+/// they're enabled).
+///
+/// # Examples
+///
+/// If you want to ensure that a function may only be invoked within contexts where interrupts are
+/// disabled, you can do so by requiring that a reference to this type be passed. You can also
+/// create this type using unsafe code in order to indicate that it's known that interrupts are
+/// already disabled on this CPU
+///
+/// ```
+/// use kernel::irq::{IrqDisabled, disable_irqs};
+///
+/// // Requiring interrupts be disabled to call a function
+/// fn dont_interrupt_me(_irq: &IrqDisabled<'_>) { }
+///
+/// // Disabling interrupts. They'll be re-enabled once this closure completes.
+/// disable_irqs(|irq| dont_interrupt_me(&irq));
+/// ```
+pub struct IrqDisabled<'a>(PhantomData<&'a ()>);
+
+impl<'a> IrqDisabled<'a> {
+    /// Create a new [`IrqDisabled`] without disabling interrupts
+    ///
+    /// If debug assertions are enabled, this function will check that interrupts are disabled.
+    /// Otherwise, it has no cost at runtime.
+    ///
+    /// # Safety
+    ///
+    /// This function must only be called in contexts where it is already known that interrupts have
+    /// been disabled for the current CPU, as the user is making a promise that they will remain
+    /// disabled at least until this [`IrqDisabled`] is dropped.
+    pub unsafe fn new() -> Self {
+        Self(PhantomData)
+    }
+}
+
+/// Run the closure `cb` with interrupts disabled on the local CPU.
+///
+/// Interrupts will be re-enabled once the closure returns. If interrupts were already disabled on
+/// this CPU, this is a no-op.
+#[inline]
+pub fn with_irqs_disabled<T, F>(cb: F) -> T
+where
+    F: FnOnce(IrqDisabled<'_>) -> T,
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


