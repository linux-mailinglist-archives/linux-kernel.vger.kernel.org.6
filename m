Return-Path: <linux-kernel+bounces-194254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B240C8D38FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA3CB2377C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E51015699E;
	Wed, 29 May 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ/bqYya"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46974156C4B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992379; cv=none; b=lHwsHX99OV1HYrgza5J3/2t8rIc6qZO+V3ZyRxcu3TW7GW4ibJXdMITlQqnX7LRxZym/qrSK//c0viECOI2pb2LL983pS1FkUt45LmWtID/aW6RV+X5NmjC6A3Qn1d75HdXTj/GJT4HdUiUsm/WaMWAY+YCdtkFWY8cp3ftupWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992379; c=relaxed/simple;
	bh=atLCXb1lowM0Gxz4/SsMfutX4H4TdZ0u4UO0rZusugQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eF85rowGT+acStXeorKOt38+aAflvClU/4vT1J9+LpN3xHRAmaZOIonBQCwwCdi4LULhfAZrwh+KyCH/MnXruyFRKalF5rtiksLJxDI2ih5M7lwGErefsytFMWZey2ffcUnluyzcz2wEoqGTJOl7xB09rrxQN6K1oJ7JJK3ZmzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ/bqYya; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8e9878514so1614209b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716992377; x=1717597177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWneT2+sVSjPlu0PEk4XA0bMEHQHqavo7oRmtF/HDks=;
        b=dJ/bqYyaM2HIGfSwwOpFQbg+0Jwtwd3sBMRMlAHZgAUS2QPwyIg+kBK5ejEcb1ZORv
         6HHwjz8ICJo490rOvNSjG4wNC0uex0xmApCJDC1DDzMTeDuRCdyjtqL+UsmlZ0xh1BJF
         wHifTeEEbtIkTRH/Z4/R7w9G5CQm4t5z9k5j+3WIHwaLMHs+cGql/W9XlkUr23SggAsC
         SDLIajfh5vJDSBxIbdgTAxBUotrKjVjdmArFfx/vQ0QL9SwMrs/5SrcBBfHMbbHlmYMw
         kRzn8u97AqZOjwdRgLRTTHRKPOdKmTLTI/78Eoo8ebcaxO/16ADyykUF9M+OgzcDXwz9
         2eTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992377; x=1717597177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWneT2+sVSjPlu0PEk4XA0bMEHQHqavo7oRmtF/HDks=;
        b=kNg7UTEUbxbgp3wtzUuRvvJOvm/OHVYXGLaks0V4ilKU4mon9X905vdpr/eDFGVKDk
         EQXDBBSMQMbGg4AuRBm+f+34TZC7h5eb9HAxUoi8McM3bdHNMRoir5hF2eIEWu0ojQ26
         vnOcWADvVwibZnZ+wIn0SaBT4Vslj+dRxZn8VNtGpU7iySRjmbbV9Y6/eJKfMbBM7Gro
         GdiRDr0lW5wdsS3Rco4u0hq6en0sl7euwTQUwrHdov7LmpFQmzQt0m9IwnEkkM57Jcu2
         SB4KdGyCSlF5I6WSwehIDcqWDga1fwsATHdWNYvPs0IDmL77Mm6o+uXYRepQvrLwpGpL
         wYBg==
X-Forwarded-Encrypted: i=1; AJvYcCXLI3cVuNVzh3D4GLVa4hCc6KGqV6fLpkbw36hBiCDLTTT0mJQCb3oY5gUeOPtCnj21vs2kNgccm4CDE92GZKMC3W+dVKY4HSjZmS7W
X-Gm-Message-State: AOJu0Ywqv9SSdMPwA+pMQ4NFkxk7098gaFb/JWDiB2GrlmO6+0ekweqr
	8cVAHZszPLgw6xERJ+aJHhMPsbcTKMUU8f74HBPORP4UZXk0F3dlf/nCkmmv
X-Google-Smtp-Source: AGHT+IGH+F9MgFzXTRhdeF+Ynm03TpsS6G5/sSgJUOoDneut7Z4RF4mDHqs0CiHzfQc5tlS2tG+31w==
X-Received: by 2002:a05:6a00:330d:b0:6f8:d499:2d41 with SMTP id d2e1a72fcca58-6f8f3f8ba84mr18631576b3a.24.1716992377262;
        Wed, 29 May 2024 07:19:37 -0700 (PDT)
Received: from PC-YLX4GJ2P.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d58d2sm8101631b3a.196.2024.05.29.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:19:36 -0700 (PDT)
From: Chunxin Zang <spring.cxz@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	yu.c.chen@intel.com,
	jameshongleiwang@126.com,
	efault@gmx.de,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	yangchen11@lixiang.com,
	zhouchunhua@lixiang.com,
	zangchunxin@lixiang.com,
	Chunxin Zang <spring.cxz@gmail.com>
Subject: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is ineligible
Date: Wed, 29 May 2024 22:18:06 +0800
Message-Id: <20240529141806.16029-1-spring.cxz@gmail.com>
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
will increase the scheduling delay of other processes. Therefore, I
tried checking the current process in wakeup_preempt and entity_tick,
and if it is illegal, reschedule that cfs queue.

When RUN_TO_PARITY is enabled, its behavior essentially remains
consistent with the original process. When NO_RUN_TO_PARITY is enabled,
some additional preemptions will be introduced, but not too many.

I have pasted some test results below.
I isolated four cores for testing and ran hackbench in the background,
and observed the test results of cyclictest.

hackbench -g 4 -l 100000000 &
cyclictest --mlockall -D 5m -q

                                 EEVDF      PATCH  EEVDF-NO_PARITY  PATCH-NO_PARITY

                # Min Latencies: 00006      00006      00006      00006
  LNICE(-19)    # Avg Latencies: 00191      00133      00089      00066
                # Max Latencies: 15442      08466      14133      07713

                # Min Latencies: 00006      00010      00006      00006
  LNICE(0)      # Avg Latencies: 00466      00326      00289      00257
                # Max Latencies: 38917      13945      32665      17710

                # Min Latencies: 00019      00053      00010      00013
  LNICE(19)     # Avg Latencies: 37151      25852      18293      23035
                # Max Latencies: 2688299    4643635    426196     425708

I captured and compared the number of preempt occurrences in wakeup_preempt
to see if it introduced any additional overhead.

Similarly, hackbench is used to stress the utilization of four cores to
100%, and the method for capturing the number of PREEMPT occurrences is
referenced from [1].

schedstats                          EEVDF       PATCH   EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
stats.check_preempt_count          5053054     5045388    5018589    5029585
stats.patch_preempt_count          -------     0020495    -------    0700670    -------
stats.need_preempt_count           0570520     0458947    3380513    3116966    1140821

From the above test results, there is a slight increase in the number of
preempt occurrences in wakeup_preempt. However, the results vary with each
test, and sometimes the difference is not that significant.

[1]: https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kicks-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb

Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
Reviewed-by: Chen Yang <yangchen11@lixiang.com>

------
Changes in v2:
- Make the logic that determines the current process as ineligible and
  triggers preemption effective only when NO_RUN_TO_PARITY is enabled.
- Update the commit message
---
 kernel/sched/fair.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..fa2c512139e5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -745,6 +745,17 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
+static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (sched_feat(RUN_TO_PARITY) && se->vlag != se->deadline)
+		return true;
+
+	if (!sched_feat(RUN_TO_PARITY) && !entity_eligible(cfs_rq, se))
+		return true;
+
+	return false;
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
@@ -5523,6 +5534,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
+
+	if (check_entity_need_preempt(cfs_rq, curr))
+		resched_curr(rq_of(cfs_rq));
 }
 
 
@@ -8343,6 +8357,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
+	if (check_entity_need_preempt(cfs_rq, se))
+		goto preempt;
+
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */
-- 
2.34.1


