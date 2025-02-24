Return-Path: <linux-kernel+bounces-529320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BCBA4231F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BC51630AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE016F0FE;
	Mon, 24 Feb 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YrVCLYDY"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD447CF16;
	Mon, 24 Feb 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407037; cv=none; b=EW4olFgj2zokSor4Nw4f6qBUtlQVMJH0aX6Ob5EE7F+6/bbOrSk1X2/XEqEHgakbl1+IYYuoHSB9Mnk449Rrfp197VMMIbFCOIAz1gHhG+HNCsYXtmRWhF2soEglFcFdmIZlmaOjIFy7C0sKXyZFeWTFyhYl8kCbqtbu4v3QbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407037; c=relaxed/simple;
	bh=E2lAPAZ2LYqRrh+gSq4+glJVFwMQxQGVoWqwBtpJP1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R46SYFWpQ1n5T+ww+Ky0Wqe/tkS8fyVNUAO4q/hfx1SoGzy8SgOmiHLp2SDtjYBj1dtsuluQ4veGrCxjSsRVoDA6Z5qfuOnmJX+GP6Tzr6wwVYe+uvKWa8yg792IKR/nt6E6d9lNWveYGvyXtSLusb66QATsmvSO2gNxXC2Nixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YrVCLYDY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.lan (unknown [142.114.216.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 34285203CDDE;
	Mon, 24 Feb 2025 06:23:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34285203CDDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740407029;
	bh=s6W1mOT343rnBx7peL+teMTPd68LRu36Duj+5rUo2os=;
	h=From:To:Cc:Subject:Date:From;
	b=YrVCLYDYjeN2WKG5EXpSQvQGwBsDFvl+phqCiXab0dXi6QJbv9Eo7k2TFRix06b9c
	 3usHzj0UShjcXVe5tL9iwR+YfCY11TXrwkJ/owHCu8D++eENcBT11Ad4FcrKtu7vuW
	 oWPKIs1hQYCiAd/MW3LcitkhjhbSkpRnFeeSAaIU=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: rust-for-linux@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
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
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: workqueue: define built-in bh queues
Date: Mon, 24 Feb 2025 09:23:23 -0500
Message-ID: <20250224142326.38396-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide safe getters to the system bh work queues. They will be used
to reimplement the Hyper-V VMBus in rust.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
v2: make the commit message suck less.
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


