Return-Path: <linux-kernel+bounces-171314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F678BE286
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6DD28C8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66DB15E5DD;
	Tue,  7 May 2024 12:51:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C469715E5C1
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086260; cv=none; b=OPTzfpoGLZgueAOsYmFVWnChOjf52Uz9gGe8G/khR6aFXATdlMgtb0cTrs9zgXK0ckJVFyJH4I2lnFLsPrGgpN0W97QnuWKAekHrd25eM5wmMlfBLZkux0cFFPNyfbslAjPD7KZ+paeJbUrPr2pFMTYyYqpXHpmkYfYKUaHx2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086260; c=relaxed/simple;
	bh=1Vmrp0e+RcUgD8RfroNk+xVONiQfiA5uYlYtIhT3sa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVo4wqbNUTKUA7FbGfqvYExEbR7lg4fJpL1Mp3qXqB18MgrQcCH8agMOQTkv+q5qtCCFmrv7G+GDTmuv6j0j5QfsTIsc81kdd4jbn/ar7wFRAqmWJey2FogzZktI9fApIQjcIxxBPnKOcPcJFEG46X0BKAdnuSJI5mmgKeA1vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1529E1063;
	Tue,  7 May 2024 05:51:24 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123F93F793;
	Tue,  7 May 2024 05:50:55 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: [RFC PATCH v3 5/6] sched/uclamp: Simplify uclamp_eff_value()
Date: Tue,  7 May 2024 13:50:28 +0100
Message-Id: <6209eda0b134ad7a0be8855ffdd7b4c747fb8048.1715082714.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715082714.git.hongyan.xia2@arm.com>
References: <cover.1715082714.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit

sched: Remove all uclamp bucket logic

removes uclamp_rq_{inc/dec}() functions, so now p->uclamp contains the
correct values all the time after a uclamp_update_active() call, and
there's no need to toggle the boolean `active` after an update. As a
result, this function is fairly simple now and can live as a static
inline function.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/core.c  | 13 ++++---------
 kernel/sched/sched.h | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 981ec9205fe8..876a4b05a3fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1500,21 +1500,15 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
-unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
-{
-	if (!uclamp_is_used() || !p->uclamp[clamp_id].active)
-		return uclamp_none(clamp_id);
-
-	return p->uclamp[clamp_id].value;
-}
-
 static inline void
 uclamp_update_active_nolock(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
-	for_each_clamp_id(clamp_id)
+	for_each_clamp_id(clamp_id) {
 		p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
+		p->uclamp[clamp_id].active = 1;
+	}
 }
 
 static inline void
@@ -1772,6 +1766,7 @@ static void uclamp_fork(struct task_struct *p)
 		for_each_clamp_id(clamp_id) {
 			uclamp_se_set(&p->uclamp_req[clamp_id],
 				      uclamp_none(clamp_id), false);
+			p->uclamp[clamp_id].active = 0;
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b99d176623e1..eb810cd9f3d9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2999,8 +2999,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
-unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
-
 static inline unsigned long root_cfs_util_uclamp(struct rq *rq)
 {
 	long ret = READ_ONCE(rq->cfs.avg.util_avg);
@@ -3023,6 +3021,18 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 
+static inline unsigned long uclamp_eff_value(struct task_struct *p,
+					     enum uclamp_id clamp_id)
+{
+	if (uclamp_is_used() && p->uclamp[clamp_id].active)
+		return p->uclamp[clamp_id].value;
+
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+
+	return SCHED_CAPACITY_SCALE;
+}
+
 static inline void util_bias_enqueue(struct sched_avg *avg,
 				     struct task_struct *p)
 {
-- 
2.34.1


