Return-Path: <linux-kernel+bounces-526763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2167A402C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077CD188A6F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64F20766D;
	Fri, 21 Feb 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X+qgijfs"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377091FFC6A;
	Fri, 21 Feb 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177374; cv=none; b=Xw1Bg/Z/Xo/q5SuUiv3rey28a9U/SubG7yXJQGeJngOeP446nsZsCw1rMvMGe8AyjA0NbWMSYw+qCzO2UTTGLwkWOPVyTowm3o56apXVTVbelGh/uIMWabkkPEjni691hzPIZVbfTwiqVcqls+RZvUlQhE8xteajAwkGAVRiGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177374; c=relaxed/simple;
	bh=Df/G3F66VFOOMEBPuY0a6bwDc8reB4bv6DCHqqRUiiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2V/jbS/GdpvrHb+B2IJ0ihJ+9Kw2viU+5EK4v41yX4MEApe0qoqUO+A4RYZhpI7sqr5bYgCCSdNJFKkPgfEqPrOudFbpAdr/hlHbvDZOOAUuBl9SyC2CMEhHxWyFeHkVanrajJ7TblwqEEDx9tBUwh7Ri7YfDuDL3kXSbBLayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X+qgijfs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (bras-base-toroon4332w-grc-32-142-114-216-132.dsl.bell.ca [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 768DB205367B;
	Fri, 21 Feb 2025 14:36:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 768DB205367B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740177372;
	bh=QTP8p/YkwjP9gnklyqmthyBoYuNs/td42uSQ7HlcEOs=;
	h=From:To:Cc:Subject:Date:From;
	b=X+qgijfsLtfYqQcRGCQIQsObPy/ZqDfKpL/fOLRWSHCI42u6XsimtNtMFq+knyWKh
	 pKxna2quG+D2/rKVDPYtFhQJKP4cBF6upILOCEdwl5WFVp+rSFqiGWgDN9wWif1PBX
	 e9c+x68b5I3pXPohD7km8IeqjGSrJxSR9kJo/1v0=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: rust-for-linux@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Nell Shamrell-Harrington <nells@linux.microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: workqueue: define built-in bh queues
Date: Fri, 21 Feb 2025 17:35:31 -0500
Message-ID: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We provide these methods because it lets us access these queues from
Rust without using unsafe code.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 rust/kernel/workqueue.rs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 0cd100d2aefb..68ce70d94f2d 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -703,3 +703,21 @@ pub fn system_freezable_power_efficient() -> &'static Queue {
     // SAFETY: `system_freezable_power_efficient_wq` is a C global, always available.
     unsafe { Queue::from_raw(bindings::system_freezable_power_efficient_wq) }
 }
+
+/// Returns the system bottom halves work queue (`system_bh_wq`).
+///
+/// It is similar to the one returned by [`system`] but for work items which
+/// need to run from a softirq context.
+pub fn system_bh() -> &'static Queue {
+    // SAFETY: `system_bh_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_bh_wq) }
+}
+
+/// Returns the system bottom halves high-priority work queue (`system_bh_highpri_wq`).
+///
+/// It is similar to the one returned by [`system_bh`] but for work items which
+/// require higher scheduling priority.
+pub fn system_bh_highpri() -> &'static Queue {
+    // SAFETY: `system_bh_highpri_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_bh_highpri_wq) }
+}
-- 
2.47.1


