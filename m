Return-Path: <linux-kernel+bounces-370980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E849A3496
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE2B1C2353F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF891865E6;
	Fri, 18 Oct 2024 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJETTRBP"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43221181334;
	Fri, 18 Oct 2024 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230723; cv=none; b=LSWxQSvb/HXY6aFzEhn0AUM/rya9PU3gS4XigkaKl3a9zOfDfCIv84f5esgedxFMgSx6cN23xc/84nPkw3M4DIQMtIKd27LOamIPdy6SCsNBl92o6Mqz5umaVUZtBR63ws6gjq5ibkXJ33ZWgq2QvBiA3phrRud8wcWdUs0NHM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230723; c=relaxed/simple;
	bh=DN+57LIYkfMqYE05e0XVimoLNUjef/QEJKEggD7glyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrKs+dsEp4LJtbv7RDlzetYZF4/qwTUeFPLFUoM/BeZXtLn93MglW7x/UDiOq5qqS6Ka1+/driWGNMVIePCRN+stC1nb5eJYb0OonkhfF/8haSrIkPdYIvXjrs0UZnWoSsvjPJnxS8nBH2xH1DVfVLoEwciMgGBf02R6bc4hu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJETTRBP; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbd550b648so12941836d6.0;
        Thu, 17 Oct 2024 22:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230721; x=1729835521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QchuT/lR++8UPbNj4oEBDAwX/3RB/ZO33V1EX16IN5o=;
        b=UJETTRBPsImh33IcOMXgU0HD87VFCRpkK3C8QC+X+Gv5UNRDrHIwF02SPmy/BtSuG/
         jgyXx0Fry+Npin4F9cjfQL23O6D8ZoWqZpN4H+xWXYYPkgvXkImxN1DzvJAbTxquXmvt
         MHJxuN8bJ/sx1Ms05k9+iDGhNc1e5JJWoi/4O/8Y9beaPuesvSrrB0dDzQjBsAU00EC3
         ynvwNqgZGMsfjzH39x0TNnzv0nDdq05YsjQ7+o+27LBpOMb6Osmf4JDp6lUvL7K1FCln
         FTWNKOL37P55RFJ9wmmIGg6dzeSl+92tDA1OLUTcpyOMw+Xe+cvZtniGH0rE1rcAkFF2
         WxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230721; x=1729835521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QchuT/lR++8UPbNj4oEBDAwX/3RB/ZO33V1EX16IN5o=;
        b=L46ZqBKNzmlaEUACNl23XGtwXDqy9Jm6DYllYnDdifjgEVqEONTe/VQndL74wO1AQS
         PfQPGcPHI2er1Uxej262ncmeOXnJNgMWZDmHq3ceE5aLru1lwtmxhTCeiQbCwLZczNro
         HPL85arY4+I2cZl3PHAV/NvyzvJ25tgaVRtlTZMix3L+0YyLusIOdbV0Rp+xr2vWYqKg
         S2pk0qGzZHUCmjcSID7oMxb+Rz4iGLFLV5ljXtgDZyLDFAeRDIjdAG2B52Ykl62eUEeE
         5f3TCtUzDFqMxqdY5qlaK/hAdSkP/vCMbRaGqT1Ap2qRBhAA533xo8FKIo0+B8+n0I+j
         OjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSleU3AnFIHrdvYiqdUdqdDLp14ihAmmJMueKNTSSwWwOE6UNz3WZrkV9abVAra6shlXrEBUbviR7FKlz1Bw8=@vger.kernel.org, AJvYcCXlYm9gl4nDSGMZDfIgOfYM7syRaZnswF3+QeTHEV3xyf2QZJKED+37CdtTa80iY+1vKkLlgcuftgrh6T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBN+cFEILNz85dL0RtME/oPqe/9mOrOtZNQ+HIIvZodJYCnvAw
	3yXdCe4GcQrj1UtBU5HyVR6X5V33asiUX5GK5pURylpmbGhZABZ4
X-Google-Smtp-Source: AGHT+IGEJRJbnUwC2varYnTCZY5Ax/RNNDnrbQ6FJH44lwQk5RS/h12JEd/gNWvr3mj/kOn4LIxLeA==
X-Received: by 2002:a05:6214:328e:b0:6cb:ea53:9c5f with SMTP id 6a1803df08f44-6cde162e841mr16687946d6.45.1729230721071;
        Thu, 17 Oct 2024 22:52:01 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114d782sm3903866d6.46.2024.10.17.22.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:52:00 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id F14DE1200071;
	Fri, 18 Oct 2024 01:51:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 18 Oct 2024 01:51:59 -0400
X-ME-Sender: <xms:f_cRZ2zn19n4nOFCFednAonMjfaAYnbpPjT5I4BeezW_lnuumHIE6g>
    <xme:f_cRZyStXgJYsmjvuRHRul0_KFU4Tw1CPHnAA089mVLW-OZNvUfTGdGTsJvOMmMEX
    I-W3IxynyOnbUhT_w>
X-ME-Received: <xmr:f_cRZ4Vobt74-TfGy2070a54ln_RkOt7_4SWAXhKblY72vNDIx97axLp_kkksQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gvpdhrtghpthhtohepughirhhkrdgsvghhmhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqd
    hlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivggusehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhl
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrd
    gtohhm
X-ME-Proxy: <xmx:f_cRZ8hqadywWIXeKVu-7t54PhVy1Ck-VGtKNlrGM3t_M_p9k0LXuw>
    <xmx:f_cRZ4DrdavvKfqyqErudyN0_8jTsVwFI3RI46IN8p19mMa5YFdhKQ>
    <xmx:f_cRZ9LhsI31UwBmxZh2pIiDtsYLs9sQmE88Vj-logWR7EgS4-MFrA>
    <xmx:f_cRZ_BjaPvPSCoCf5mnWFok8pLhLMYsaxZ2BlP6v3z85YHoRvGhcA>
    <xmx:f_cRZwz6LB9jOqu6eIayq81on2lwPIjVITCyI_wGuI_dp7gEzcW3xenI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:51:59 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	will@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [POC 2/6] rust: Introduce interrupt module
Date: Thu, 17 Oct 2024 22:51:21 -0700
Message-ID: <20241018055125.2784186-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018055125.2784186-1-boqun.feng@gmail.com>
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
 <20241018055125.2784186-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lyude Paul <lyude@redhat.com>

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts along with the
ability to annotate functions as expecting that IRQs are already
disabled on the local CPU.

[Boqun: This is based on Lyude's work on interrupt disable abstraction,
I port to the new local_interrupt_disable() mechanism to make it work
as a guard type. I cannot even take the credit of this design, since
Lyude also brought up the same idea in zulip. Anyway, this is only for
POC purpose, and of course all bugs are mine]

Co-Developed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/helpers.c   |  1 +
 rust/helpers/interrupt.c | 18 +++++++++++
 rust/kernel/interrupt.rs | 64 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |  1 +
 4 files changed, 84 insertions(+)
 create mode 100644 rust/helpers/interrupt.c
 create mode 100644 rust/kernel/interrupt.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..f6e5b33eaff8 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "err.c"
+#include "interrupt.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
diff --git a/rust/helpers/interrupt.c b/rust/helpers/interrupt.c
new file mode 100644
index 000000000000..e58da42916da
--- /dev/null
+++ b/rust/helpers/interrupt.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/irqflags.h>
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
index 000000000000..fe5a36877538
--- /dev/null
+++ b/rust/kernel/interrupt.rs
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Interrupt controls
+//!
+//! This module allows Rust code to control processor interrupts. [`with_interrupt_disabled()`] may be
+//! used for nested disables of interrupts, whereas [`InterruptDisabled`] can be used for annotating code
+//! that requires interrupts to be disabled.
+
+use bindings;
+use core::marker::*;
+
+/// XXX: Temporarily definition for NotThreadSafe
+pub type NotThreadSafe = PhantomData<*mut ()>;
+
+/// XXX: Temporarily const for NotThreadSafe
+#[allow(non_upper_case_globals)]
+pub const NotThreadSafe: NotThreadSafe = PhantomData;
+
+/// A guard that represent interrupt disable protection.
+///
+/// [`InterruptDisabled`] is a guard type that represent interrupts have been disabled. Certain
+/// functions take an immutable reference of [`InterruptDisabled`] in order to require that they may
+/// only be run in interrupt-disabled contexts.
+///
+/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
+/// interrupts are disabled where required.
+///
+/// This token can be created by [`with_interrupt_disabled`]. See [`with_interrupt_disabled`] for examples and
+/// further information.
+///
+/// # Invariants
+///
+/// Interrupts are disabled with `local_interrupt_disable()` when an object of this type exists.
+pub struct InterruptDisabled(NotThreadSafe);
+
+/// Disable interrupts.
+pub fn interrupt_disable() -> InterruptDisabled {
+    // SAFETY: It's always safe to call `local_interrupt_disable()`.
+    unsafe { bindings::local_interrupt_disable() };
+
+    InterruptDisabled(NotThreadSafe)
+}
+
+impl Drop for InterruptDisabled {
+    fn drop(&mut self) {
+        // SAFETY: Per type invariants, a `local_interrupt_disable()` must be called to create this
+        // object, hence call the corresponding `local_interrupt_enable()` is safe.
+        unsafe { bindings::local_interrupt_enable() };
+    }
+}
+
+impl InterruptDisabled {
+    const ASSUME_INTERRUPT_DISABLED: &'static InterruptDisabled = &InterruptDisabled(NotThreadSafe);
+
+    /// Assume that interrupts are disabled.
+    ///
+    /// # Safety
+    ///
+    /// For the whole life `'a`, interrupts must be considered disabled, for example an interrupt
+    /// handler.
+    pub unsafe fn assume_interrupt_disabled<'a>() -> &'a InterruptDisabled {
+        Self::ASSUME_INTERRUPT_DISABLED
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b5f4b3ce6b48..56ff464b7905 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod init;
+pub mod interrupt;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
-- 
2.45.2


