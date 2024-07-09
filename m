Return-Path: <linux-kernel+bounces-246694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CCA92C53D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1024C1C2205B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A455189F21;
	Tue,  9 Jul 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQfcCji1"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B118785D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560108; cv=none; b=i2L3/5Ye/cRwSS9gD9jSG9RY1YYo4PYzgg/MgGSnxFdRvsYvZBqSUwAeH1Atcd/HnIVOxMuLNOg3nA8sWBUcnloBX6UVPRuCNkdA5FRCe09rxe4QSuEtnvf7GRtCctqqEWnzpxjrB7jmXnxi7xXHMQHvi8BduJoJBVkNUYw5kbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560108; c=relaxed/simple;
	bh=m5r0u+xubKm4QDF/DC9MBNY24TdFTDAmHRdrWjA2rSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3gIx4rmbYuFUvfGyFa3t3sommQa3+5PLULn9pfeJKyCE3L9D+G6Dl/ZaYEI3wSk3hwNmdTnu09sl7cI3r1BElArvJpB6ZZwhKHvYFeySbBiYSYlHK2tQGHUwwc9iDVeMCnb/E5gyhDVErysulN86s7uqrw1MUA4rJ01H7T7BcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQfcCji1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-70df2135426so2922112a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560106; x=1721164906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64jfIs2Pf63mBYDa4gzwPp8d06LCq36ZLK9er0RoiFQ=;
        b=RQfcCji1D+Rg/Ctgey+lDKzeESEqfG0uZLULGyct01BPAjHa5/uq8GWu6QIkGnURSp
         Zfoa4NNTU+4lItTh+O6QvBrCRl5IKUQR4fY8OPJw96c8Ef0BKQ5X3d3uB63BJgRRaMCF
         D9dd1Get80BM+VDeVc4CpbBKtGOtuqX+h53vIWOsksQ97cA4C2xptPcCEzymlP14WazW
         KfmSs+nf5kA3iCd5jnyJNHA0Ba3FaajiiaXzFPUwns38In6dY70MjR9tpowJV9s39LWs
         GxJsp1uPtNN+GrAkbgVMl8YwGoOvv60gIcpjdArOeJk9hhA4YSq/jItDXrnAMqxuqy3d
         eeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560106; x=1721164906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=64jfIs2Pf63mBYDa4gzwPp8d06LCq36ZLK9er0RoiFQ=;
        b=wCRB6g8gHHK6xpuCK3rkNwt5SrtI112LwLCbPE+z+wN8DDh/I2/JA71EpsT3dg22vk
         oK9+YMuig6uLVh9+50sjaNycRFxhbqTlu6jHF/ulGeYcp7QUj951Yx41DpcuRhxRBudK
         QG+9nLZyWN4hO3TGrc0HujL0ftjoeMhV9JcFS3FHZRDdtHyKmRkJAdU9ec700Dj9rdfV
         PTJSWkXiZBD738gWcVAGcB0vZAnCc2kv5SBpO9XU6+ENNSgkdU0iJRduNTl8JL9Mx6t/
         WNO5fhE0BCuI4GgEHVZc/UqD75Ce0+XkfxoEIKd5KX6F/an0JZjiSTEAdePkJRfa9aJV
         d6CA==
X-Gm-Message-State: AOJu0YzrAC0Y+B2tlnFsjnFms5LPXzmDbq0w81vsfCqjeCZoP9qKcVn5
	H9ClVBQ7ozLIvSjowlpPwslzudidxmTXr5pCeQ5aepxxmIJ8S0IF
X-Google-Smtp-Source: AGHT+IHqDfFAeeLzzuPL8SWJfzLdICWiyYudfBmHTh5qm7v/0wQxKPoVuG4Hti5tnetc8kw729q1RA==
X-Received: by 2002:a17:90b:238e:b0:2c7:f3de:27ef with SMTP id 98e67ed59e1d1-2ca35d58b08mr2960634a91.42.1720560106212;
        Tue, 09 Jul 2024 14:21:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a980b37sm10561056a91.24.2024.07.09.14.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:21:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] sched_ext: Make @rf optional for dispatch_to_local_dsq()
Date: Tue,  9 Jul 2024 11:21:09 -1000
Message-ID: <20240709212137.1199269-4-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709212137.1199269-1-tj@kernel.org>
References: <20240709212137.1199269-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dispatch_to_local_dsq() may unlock the current rq when dispatching to a
local DSQ on a different CPU. This function is currently called from the
balance path where the rq lock is pinned and the associated rq_flags is
available to unpin it.

dispatch_to_local_dsq() will be used to implement direct dispatch to a local
DSQ on a remote CPU from the enqueue path where it will be called with rq
locked but not pinned. Make @rf optional so that the function can be used
from a context which doesn't pin the rq lock.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 52340ac8038f..e96727460df2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2040,7 +2040,7 @@ static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
 /**
  * dispatch_to_local_dsq_lock - Ensure source and destination rq's are locked
  * @rq: current rq which is locked
- * @rf: rq_flags to use when unlocking @rq
+ * @rf: optional rq_flags to use when unlocking @rq if its lock is pinned
  * @src_rq: rq to move task from
  * @dst_rq: rq to move task to
  *
@@ -2052,17 +2052,20 @@ static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
 static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
 				       struct rq *src_rq, struct rq *dst_rq)
 {
-	rq_unpin_lock(rq, rf);
+	if (rf)
+		rq_unpin_lock(rq, rf);
 
 	if (src_rq == dst_rq) {
 		raw_spin_rq_unlock(rq);
 		raw_spin_rq_lock(dst_rq);
 	} else if (rq == src_rq) {
 		double_lock_balance(rq, dst_rq);
-		rq_repin_lock(rq, rf);
+		if (rf)
+			rq_repin_lock(rq, rf);
 	} else if (rq == dst_rq) {
 		double_lock_balance(rq, src_rq);
-		rq_repin_lock(rq, rf);
+		if (rf)
+			rq_repin_lock(rq, rf);
 	} else {
 		raw_spin_rq_unlock(rq);
 		double_rq_lock(src_rq, dst_rq);
@@ -2072,7 +2075,7 @@ static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
 /**
  * dispatch_to_local_dsq_unlock - Undo dispatch_to_local_dsq_lock()
  * @rq: current rq which is locked
- * @rf: rq_flags to use when unlocking @rq
+ * @rf: optional rq_flags to use when unlocking @rq if its lock is pinned
  * @src_rq: rq to move task from
  * @dst_rq: rq to move task to
  *
@@ -2084,7 +2087,8 @@ static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
 	if (src_rq == dst_rq) {
 		raw_spin_rq_unlock(dst_rq);
 		raw_spin_rq_lock(rq);
-		rq_repin_lock(rq, rf);
+		if (rf)
+			rq_repin_lock(rq, rf);
 	} else if (rq == src_rq) {
 		double_unlock_balance(rq, dst_rq);
 	} else if (rq == dst_rq) {
@@ -2092,7 +2096,8 @@ static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
 	} else {
 		double_rq_unlock(src_rq, dst_rq);
 		raw_spin_rq_lock(rq);
-		rq_repin_lock(rq, rf);
+		if (rf)
+			rq_repin_lock(rq, rf);
 	}
 }
 #endif	/* CONFIG_SMP */
@@ -2214,7 +2219,7 @@ enum dispatch_to_local_dsq_ret {
 /**
  * dispatch_to_local_dsq - Dispatch a task to a local dsq
  * @rq: current rq which is locked
- * @rf: rq_flags to use when unlocking @rq
+ * @rf: optional rq_flags to use when unlocking @rq if its lock is pinned
  * @dsq_id: destination dsq ID
  * @p: task to dispatch
  * @enq_flags: %SCX_ENQ_*
-- 
2.45.2


