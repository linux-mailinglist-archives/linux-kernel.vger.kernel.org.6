Return-Path: <linux-kernel+bounces-213275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15505907361
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E0B1F21FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2F144D00;
	Thu, 13 Jun 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRpaWOVp"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45422144D0C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284580; cv=none; b=PvAl2MLrwTU02w0rm78/5Fbi0+O+wUCBusvdsTIxj0JKe2JD4K1ck3qG/lweoTpXLB4HvCbBAXqtjvLlTlxWVgkK/j83vlRMBMfT5RwclcI7qjCfTHBLMCV+XvZGo6PJ/bhGt9AowvW3QadSSQgqaeBtc1ms3Eh2+JlI0juxViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284580; c=relaxed/simple;
	bh=IstfidUEVQ9wbdWX1alK/7Z+F5FxlF9bkhh13Vx6gYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PtxjG+qcJS1iEVBZMTj30Gd9C4sgWM7uE2k/wHNOlA4AYibvm+t/P+oumsecyT4xNGoGOu00qaoD5dUfOK9jsdxuGYxZzzX9BCX0U5l/9BMa0BMsVfqNXEDTy0wSQcSnNlqJEX5JDq06niv9w7kZYUU0KAKYIbtWuMCjS1gzis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRpaWOVp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-704090c11easo829768b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718284578; x=1718889378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqEYDO9oGj42N7TM61C5n8gEfRqnJL+KvEJ0e/f8bkA=;
        b=lRpaWOVpiJXl/Yrnzu9UHAJASMej2HE023vrCDOJHa+arpt+jysC8YrdiWymexQyB6
         emfe5Q4MzkqxvKq+37TSNTZdByh5sLU3G9wbPXTIZfBk+TzPdk1j44dtTAdlwKF4GauF
         MioXP4xQ6bKb0Xp5sP0Xs340uBERp3qfkdD74i596NCl8enSeKt20bIqjmT219qzvN9T
         BlaWD1lVaCkB02O0LgBuz7hUdlIh+/A0YCVwC9KoBMU7KUsJEKkzVONffv7Yie6mmtiP
         kTaahGxT+s88FkHQ33h+t3SAYpSB9GdJZq22J0FrV8xAULP+CEvwEDjR0AHJKuP4iUsa
         8IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718284578; x=1718889378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqEYDO9oGj42N7TM61C5n8gEfRqnJL+KvEJ0e/f8bkA=;
        b=thUbQv3fHZZdxOYftL6tmuKSZF9Dt3VZv/e0jWb/33Dv3lHSNE9s3uH+2WFhVSUaKA
         PYmKC5Pj39JxDN+w63/I3wlVw4MBp01xYg/wkBzp1pGWdjjmW4L2Vm1yx6gEPlRFCnza
         ItfksM7sNGxOjmXMX92fUorEZzd/cym90M66mqsN2iTVnUEvrx654kvBbibTLm2iPCxE
         XltN+lD+mrvpUn5j/IrqkOOLVuD35urazILwc/eIJLi2VY4LYTzU4vfuCxQwXELaWEEF
         mDmoebAJidP+ojSQbVWzLOnF7cFz1Mllsp0vZ6onve1Srmh9xNWn9NMbuppNY/T97VBh
         anLg==
X-Forwarded-Encrypted: i=1; AJvYcCX7vZH9m/EgrX+Pz77h3ZaUyhABF8hUZjDWbjKIf9IKG3Hq9iRBPkILsUwRzzWTEBpj0dRieK8VaLPzsJJLJWik7tgyrQkmr2JKecr+
X-Gm-Message-State: AOJu0Yw3gl/opJJlzpAPKCD3gHcmXbaIPU2FNFOPZKCZSTssuY2oIXYf
	Q2K29x+KBCrh58+c7Vx+MHodRknVAFiWih0ZawKAyl0krC4z6FBq
X-Google-Smtp-Source: AGHT+IGoT23zO6XN5G405lGCR0shNqkjhJQ+rRH9EKRpZY1JDmwkL3NxTFZDsudoeL7RfNpstZTLFQ==
X-Received: by 2002:a05:6a21:999a:b0:1b7:577c:7180 with SMTP id adf61e73a8af0-1b8a9b6c908mr5301980637.12.1718284578197;
        Thu, 13 Jun 2024 06:16:18 -0700 (PDT)
Received: from PC-YLX4GJ2P.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6c1c7sm1287606b3a.167.2024.06.13.06.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:16:17 -0700 (PDT)
From: Chunxin Zang <spring.cxz@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	yu.c.chen@intel.com
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	efault@gmx.de,
	kprateek.nayak@amd.com,
	jameshongleiwang@126.com,
	yangchen11@lixiang.com,
	zangchunxin@lixiang.com,
	Chunxin Zang <spring.cxz@gmail.com>
Subject: [PATCH v3] sched/fair: Preempt if the current process is ineligible
Date: Thu, 13 Jun 2024 21:14:37 +0800
Message-Id: <20240613131437.9555-1-spring.cxz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found that some tasks have been running for a long enough time and
have become illegal, but they are still not releasing the CPU. This
will increase the scheduling delay of other processes. Therefore, we
can check the ineligible of the current process in update_curr, and if
it is ineligible, trigger preemption. This modification only takes effect
when RUN_TO_PARITY is disabled, so as not to break the original
intention of RUN_TO_PARITY.

I have pasted some test results below.
I isolated four cores for testing and ran hackbench in the background,
and observed the test results of cyclictest.

hackbench -g 4 -l 100000000 &
cyclictest --mlockall -D 5m -q

                                 EEVDF  EEVDF-NO_PARITY  PATCH-NO_PARITY

                # Min Latencies: 00006      00006      00006
  LNICE(-19)    # Avg Latencies: 00191      00089      00065
                # Max Latencies: 15442      14133      11893

                # Min Latencies: 00006      00006      00005
  LNICE(0)      # Avg Latencies: 00466      00289      00245
                # Max Latencies: 38917      32665      20238

                # Min Latencies: 00019      00010      00008
  LNICE(19)     # Avg Latencies: 37151      18293      23177
                # Max Latencies: 2688299    426196     1953298

Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
Reviewed-by: Chen Yang <yangchen11@lixiang.com>

------
Changes in v3:
- Place the evaluation of the current process's ineligible in
  update_curr.
- Update the commit message

Changes in v2:
- Make the logic that determines the current process as ineligible and
  triggers preemption effective only when NO_RUN_TO_PARITY is enabled.
- Update the commit message
---
 kernel/sched/fair.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..21ef610ddb14 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -745,6 +745,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
+static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
+	    entity_eligible(cfs_rq, se))
+		return false;
+
+	return true;
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
@@ -974,11 +983,13 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 /*
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
+ *
+ * return true if se need preempt
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if ((s64)(se->vruntime - se->deadline) < 0)
-		return;
+		return false;
 
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -995,10 +1006,7 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	/*
 	 * The task has consumed its request, reschedule.
 	 */
-	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
-		clear_buddies(cfs_rq, se);
-	}
+	return true;
 }
 
 #include "pelt.h"
@@ -1157,6 +1165,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	s64 delta_exec;
+	bool need_preempt;
 
 	if (unlikely(!curr))
 		return;
@@ -1166,12 +1175,17 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		return;
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	need_preempt = update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr))
 		update_curr_task(task_of(curr), delta_exec);
 
+	if (need_preempt || check_entity_need_preempt(cfs_rq, curr)) {
+		resched_curr(rq_of(cfs_rq));
+		clear_buddies(cfs_rq, curr);
+	}
+
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
 
-- 
2.34.1


