Return-Path: <linux-kernel+bounces-280301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D9B94C859
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2782B22603
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F8A14A90;
	Fri,  9 Aug 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLVyVMOl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6104168B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168824; cv=none; b=dsU1WRSYcDYXReFuxdZDvTMV290WO0UsqZgu811uLqS5vSmTd7NrQ2qbJ/GG/p5scZV/LKTmLaKuMHq5nZTTFbb98gMTfmVvjkdysLTO5FMu41SKjwn0vByTC/IjRDenqVRg4vNKmcojH8f2qSTzuSROQCL5E0j/TfImCX3RRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168824; c=relaxed/simple;
	bh=cRwVS9eHk3IMaF26nCc5bTWt3ef9127cCLtshdgEgPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ijv3qzCTI55JimjZTr0tqUL9T6O4FrDmCYIHYhJ1vtlBSSmVnouinwXno4UlK6MIXb4f0ZGp/uzgnl0Ndpw4SSHoCSY+yOX70efl1U1xrBRB5R5El5salZXA5kJswYWi+au4BhaF86bpkOy7riMyv3mHmEkgx6Ihs4sebbUPC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLVyVMOl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723168824; x=1754704824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cRwVS9eHk3IMaF26nCc5bTWt3ef9127cCLtshdgEgPA=;
  b=KLVyVMOljdkA1XVVLlUxMn7IJ5/WptbbVLMnWXrAR4kku/ctgn+EbjcD
   pwQ0Du+RoMyxeugouxl+go8XyqDdHf6Qc2YTRxZCXpk2MOnsbuuQdbjhi
   qNKSsHQsiU7aomkfqpulRZbyuk19zW7yVusbjhqHTWUF/cqOgQX1JSc6b
   fx756i/UQP26LcYmvehn6y5Ozjdu2pOqrbfE/tIHDgM/4ah2+/SNdnZiR
   elb8HMT63Xass73L74MpZYGiLDK1kOoVlzhmhInJeg94cy6E4HHwwl1ow
   99NKjERSe2KI97mrujV5sKJuV2Q0X23ZgGjWmJBAmwlippq4JGDBAhu/R
   g==;
X-CSE-ConnectionGUID: an4WuuMqSTiuhFq3gjmbbA==
X-CSE-MsgGUID: SpwUPnkwR9+bV9NlMLFMqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25123218"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25123218"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:00:23 -0700
X-CSE-ConnectionGUID: rgjU4LmLRzme07w/ccVWvA==
X-CSE-MsgGUID: eln9WItJQCquGLxHTQGSAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="62256120"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:00:20 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org
Cc: longman@redhat.com,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v2 1/1] locking/pvqspinlock: Convert fields of 'enum vcpu_state' to uppercase
Date: Fri,  9 Aug 2024 09:48:02 +0800
Message-Id: <20240809014802.15320-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240805023816.28003-1-qiuxu.zhuo@intel.com>
References: <20240805023816.28003-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Convert the fields of 'enum vcpu_state' to uppercase for better
readability. No functional changes intended.

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v1->v2:
 - Collect an ACK from Waiman (thanks for the review).
 - Rebase on top of v6.11-rc2.

 kernel/locking/qspinlock_paravirt.h | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index ac2e22502741..dc1cb90e3644 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -38,13 +38,13 @@
 #define PV_PREV_CHECK_MASK	0xff
 
 /*
- * Queue node uses: vcpu_running & vcpu_halted.
- * Queue head uses: vcpu_running & vcpu_hashed.
+ * Queue node uses: VCPU_RUNNING & VCPU_HALTED.
+ * Queue head uses: VCPU_RUNNING & VCPU_HASHED.
  */
 enum vcpu_state {
-	vcpu_running = 0,
-	vcpu_halted,		/* Used only in pv_wait_node */
-	vcpu_hashed,		/* = pv_hash'ed + vcpu_halted */
+	VCPU_RUNNING = 0,
+	VCPU_HALTED,		/* Used only in pv_wait_node */
+	VCPU_HASHED,		/* = pv_hash'ed + VCPU_HALTED */
 };
 
 struct pv_node {
@@ -266,7 +266,7 @@ pv_wait_early(struct pv_node *prev, int loop)
 	if ((loop & PV_PREV_CHECK_MASK) != 0)
 		return false;
 
-	return READ_ONCE(prev->state) != vcpu_running;
+	return READ_ONCE(prev->state) != VCPU_RUNNING;
 }
 
 /*
@@ -279,7 +279,7 @@ static void pv_init_node(struct mcs_spinlock *node)
 	BUILD_BUG_ON(sizeof(struct pv_node) > sizeof(struct qnode));
 
 	pn->cpu = smp_processor_id();
-	pn->state = vcpu_running;
+	pn->state = VCPU_RUNNING;
 }
 
 /*
@@ -308,26 +308,26 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 		/*
 		 * Order pn->state vs pn->locked thusly:
 		 *
-		 * [S] pn->state = vcpu_halted	  [S] next->locked = 1
+		 * [S] pn->state = VCPU_HALTED	  [S] next->locked = 1
 		 *     MB			      MB
-		 * [L] pn->locked		[RmW] pn->state = vcpu_hashed
+		 * [L] pn->locked		[RmW] pn->state = VCPU_HASHED
 		 *
 		 * Matches the cmpxchg() from pv_kick_node().
 		 */
-		smp_store_mb(pn->state, vcpu_halted);
+		smp_store_mb(pn->state, VCPU_HALTED);
 
 		if (!READ_ONCE(node->locked)) {
 			lockevent_inc(pv_wait_node);
 			lockevent_cond_inc(pv_wait_early, wait_early);
-			pv_wait(&pn->state, vcpu_halted);
+			pv_wait(&pn->state, VCPU_HALTED);
 		}
 
 		/*
-		 * If pv_kick_node() changed us to vcpu_hashed, retain that
+		 * If pv_kick_node() changed us to VCPU_HASHED, retain that
 		 * value so that pv_wait_head_or_lock() knows to not also try
 		 * to hash this lock.
 		 */
-		cmpxchg(&pn->state, vcpu_halted, vcpu_running);
+		cmpxchg(&pn->state, VCPU_HALTED, VCPU_RUNNING);
 
 		/*
 		 * If the locked flag is still not set after wakeup, it is a
@@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
-	u8 old = vcpu_halted;
+	u8 old = VCPU_HALTED;
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
@@ -374,7 +374,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * subsequent writes.
 	 */
 	smp_mb__before_atomic();
-	if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))
+	if (!try_cmpxchg_relaxed(&pn->state, &old, VCPU_HASHED))
 		return;
 
 	/*
@@ -407,7 +407,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * If pv_kick_node() already advanced our state, we don't need to
 	 * insert ourselves into the hash table anymore.
 	 */
-	if (READ_ONCE(pn->state) == vcpu_hashed)
+	if (READ_ONCE(pn->state) == VCPU_HASHED)
 		lp = (struct qspinlock **)1;
 
 	/*
@@ -420,7 +420,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		 * Set correct vCPU state to be used by queue node wait-early
 		 * mechanism.
 		 */
-		WRITE_ONCE(pn->state, vcpu_running);
+		WRITE_ONCE(pn->state, VCPU_RUNNING);
 
 		/*
 		 * Set the pending bit in the active lock spinning loop to
@@ -460,7 +460,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 				goto gotlock;
 			}
 		}
-		WRITE_ONCE(pn->state, vcpu_hashed);
+		WRITE_ONCE(pn->state, VCPU_HASHED);
 		lockevent_inc(pv_wait_head);
 		lockevent_cond_inc(pv_wait_again, waitcnt);
 		pv_wait(&lock->locked, _Q_SLOW_VAL);

base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
-- 
2.17.1


