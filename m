Return-Path: <linux-kernel+bounces-220346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86290E00C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDC4B2258C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF7918A930;
	Tue, 18 Jun 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7IYW/BO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EEB18A953
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754064; cv=none; b=YUAJcTv1n6F2xuLZrOx47plNx2fxFtg4WA5UgxwtW6G/6ocsfAPT3cBHW8p1dhGL+N+UEADtTI6fhrtN8IIRUselAnEmau4jlLWAxuRbZysawtKBe+HVBOnXrctgfXT8339A7+kcYcjp4lrptxZUYSC70kFA58mcK1mPRM0CReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754064; c=relaxed/simple;
	bh=8xOJgvmgRDc6UuoCbIh+OUfNqsEyrLgJDPK4zjjIFpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFmVg+GB7AGBEi5kooEFLEobw+SKiBgojGTvKrbTtJYNMD95ORCrgaE7sevLHLM1LSfxIQtbobiRbv1rmEU39oNCkJUcH3a3eT+awdqtlDQd6ssliXlTNGsH1icGQ7KkV5JmNuvbVV9b5kkLyX8Cw18kbceYhu+2vT/oUlwAb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7IYW/BO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jprPy2R3mhSfiLsY0D8Ey4z3vVsEHFqMm7nzo3vj3ew=;
	b=g7IYW/BOvWpucwg/anAiASqqkTffFI96yKlrt7+oQA25FIkDlpK+Si3DUP/6gH22eOk2WO
	wW/a5+aUruWIeMERDVPV2kn4buonurPyPckPEtP/HOr57NGfUs95r4YTyO/ZyRkMIdVKk0
	EEqLtPb3emqCeujhcnQKNijr3GVxj6c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-4qqf85HaOYGCxBwo8GMVBA-1; Tue, 18 Jun 2024 19:40:59 -0400
X-MC-Unique: 4qqf85HaOYGCxBwo8GMVBA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52bc0027a29so3753845e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754058; x=1719358858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jprPy2R3mhSfiLsY0D8Ey4z3vVsEHFqMm7nzo3vj3ew=;
        b=aNfSEF//+NxYSwpD6+N5lKfGx/sezXAXVHnKOYUELAGo8vyPhmzsg9QzADApRpl+wf
         Yg9KvTmckUxwJdUGYiBZs9zSUlQFcBxlxBrV/a4//mAdAKqVIqfi1nsGMPTtfiXtr8yx
         tTDK9qHBJlLRHZGpHJvFKRkeD/JVeyqU6qfGMsp+W+totWk/D02FYLej+7GK8iM/OwqG
         jjX4kU/DomRPApQE4hqOobxJeMsPAYwEDlrmI/S2SIZUMIClxooFGF4NeSwDZDV9qGs7
         70x+u/SaP8fORnad7UGLjthYcQN11jpbRDy/tOUArovusaaSfSR9QxW7rRONHsg2uOpV
         MS3g==
X-Forwarded-Encrypted: i=1; AJvYcCUpjuGeInF5e7DrvhPJQJnhYWajGhamJzeuFIds+bAiXmEgEbnUdgMayEzwS40lozPo7hngWT1qsg2iruAYbMD2CsO9XKaY5vNResns
X-Gm-Message-State: AOJu0YzubJ5gkrwRndxv32kIvaXKhq0fIN/iETp0S9NdJnyS2MqbTSXN
	qn2mffSAfqJupkwEv4WU+jX+SPel4wllpPW3aFwM8O60tBNNqnXGgGAN0GL10OTAwANhZcZp0eg
	fHpwl+Mands4RqqqY2pifPeJHmNX0bglNa+p/1oKmt1mdsQiYNCNFDhAw+gCH+Q==
X-Received: by 2002:a05:6512:3992:b0:52c:cc38:592c with SMTP id 2adb3069b0e04-52ccc385978mr111665e87.0.1718754058295;
        Tue, 18 Jun 2024 16:40:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6PRwRcXm8oRvxKpZbUxJQyrNH1GdkYsyClgqCZ2yzVNat84h8w9f3Fio+1+mz3vgR3u+6fg==
X-Received: by 2002:a05:6512:3992:b0:52c:cc38:592c with SMTP id 2adb3069b0e04-52ccc385978mr111652e87.0.1718754057790;
        Tue, 18 Jun 2024 16:40:57 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de623sm244364595e9.31.2024.06.18.16.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:40:57 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 04/10] rust: add rcu abstraction
Date: Wed, 19 Jun 2024 01:39:50 +0200
Message-ID: <20240618234025.15036-5-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618234025.15036-1-dakr@redhat.com>
References: <20240618234025.15036-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a simple abstraction to guard critical code sections with an rcu
read lock.

Co-developed-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/helpers.c          | 15 ++++++++++++
 rust/kernel/sync.rs     |  1 +
 rust/kernel/sync/rcu.rs | 52 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 rust/kernel/sync/rcu.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index 0e02b2c64c72..0ce40ccb978b 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
@@ -166,6 +167,20 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_krealloc);
 
+/* rcu */
+void rust_helper_rcu_read_lock(void)
+{
+	rcu_read_lock();
+}
+EXPORT_SYMBOL_GPL(rust_helper_rcu_read_lock);
+
+void rust_helper_rcu_read_unlock(void)
+{
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(rust_helper_rcu_read_unlock);
+/* end rcu */
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..1806767359fe 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 mod condvar;
 pub mod lock;
 mod locked_by;
+pub mod rcu;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
new file mode 100644
index 000000000000..5a35495f69a4
--- /dev/null
+++ b/rust/kernel/sync/rcu.rs
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! RCU support.
+//!
+//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
+
+use crate::bindings;
+use core::marker::PhantomData;
+
+/// Evidence that the RCU read side lock is held on the current thread/CPU.
+///
+/// The type is explicitly not `Send` because this property is per-thread/CPU.
+///
+/// # Invariants
+///
+/// The RCU read side lock is actually held while instances of this guard exist.
+pub struct Guard {
+    _not_send: PhantomData<*mut ()>,
+}
+
+impl Guard {
+    /// Acquires the RCU read side lock and returns a guard.
+    pub fn new() -> Self {
+        // SAFETY: An FFI call with no additional requirements.
+        unsafe { bindings::rcu_read_lock() };
+        // INVARIANT: The RCU read side lock was just acquired above.
+        Self {
+            _not_send: PhantomData,
+        }
+    }
+
+    /// Explicitly releases the RCU read side lock.
+    pub fn unlock(self) {}
+}
+
+impl Default for Guard {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl Drop for Guard {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, the rcu read side is locked, so it is ok to unlock it.
+        unsafe { bindings::rcu_read_unlock() };
+    }
+}
+
+/// Acquires the RCU read side lock.
+pub fn read_lock() -> Guard {
+    Guard::new()
+}
-- 
2.45.1


