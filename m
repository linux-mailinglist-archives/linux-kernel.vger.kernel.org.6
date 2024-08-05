Return-Path: <linux-kernel+bounces-274105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32BD947374
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FC2281083
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E641C73;
	Mon,  5 Aug 2024 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTx8cEr8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBAA21
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826220; cv=none; b=Wtt/4Y61J521rNaSD6X1gs9xJgvSu5rwSrbtTHJWcKvNocMGcTCsNfGGIM010Yy5JXttUKAHgbuZoFZK3rBW1vMti7G//S0EfSZONVkMBNUYkK6ryxvxgP2Ip0UlHwNy02Dr9CqTG/urt5b/5gsSMwNNDTCD4TTAd9i8gEHAwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826220; c=relaxed/simple;
	bh=/jkq8k0MwPdN/L1EEsXpcanYLl+aHAmz40LWcbau/O8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bLbvpGMWrOH3HuJaASISH6dSph9tmtfehe2UxZllgDyxUhaNPfW1t5+jbPbNiYqT0Y07p1qQlIhUo3wfQxNCzXpbGIQqQaOVMLsERqzUD3AFzwWHoJ0ldi10IgBqJ99o5UWQ9B1yfrHl7vohnLoJWbLqS3f5F+nqDZPzdTjaW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTx8cEr8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722826219; x=1754362219;
  h=from:to:cc:subject:date:message-id;
  bh=/jkq8k0MwPdN/L1EEsXpcanYLl+aHAmz40LWcbau/O8=;
  b=XTx8cEr8DZIdvR6ZdHhnZO+f5JVCsFQFa4Zsaazhhx4YSrshMgF80ZVV
   XuG6xY5YxT1AZB0qVWkvv8w8oBpzj7+iZ8eObdRQnl8u0OTf+BTPQH9Sx
   eBmK15RRbBKrU5Lu5Lw9LQktHSEm+7OluQ2/fyVD/AKqeh0hMdrPXT1D1
   LMNDwhsVySAe8UtOcDddT3Y9s/63z16+lA1BATzoUOw7Ob97hdpH4CtSW
   W2OMmvH4AH8m7cKFJ0KDWge76EvIQgGNV8FgPRJ30Z206CZ1zDjBL3tif
   yE1L/JrXYQIEgA5iv+wpgvGCd1ArHKXy2+zZQESvzStbE+OYrzKs/pzJ0
   Q==;
X-CSE-ConnectionGUID: FiSfQ5coTbm6W0FL87LTLw==
X-CSE-MsgGUID: k7oZHOOwTYOLoM84xaBSXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="23683255"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="23683255"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 19:50:18 -0700
X-CSE-ConnectionGUID: B3N2zKfURoif/qhqc4YuWQ==
X-CSE-MsgGUID: 1FTdvdAVS5aKkuFO6ZwawQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="79287144"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 19:50:16 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org
Cc: longman@redhat.com,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH 1/1] locking/pvqspinlock: Convert fields of 'enum vcpu_state' to uppercase
Date: Mon,  5 Aug 2024 10:38:16 +0800
Message-Id: <20240805023816.28003-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Convert the fields of 'enum vcpu_state' to uppercase for better
readability. No functional changes intended.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
This change builds on top of the commit '224fa3552029' from git:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git origin/locking/urgent

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

base-commit: 224fa3552029a3d14bec7acf72ded8171d551b88
-- 
2.17.1


