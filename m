Return-Path: <linux-kernel+bounces-544401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643BA4E0CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E0417AC37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1D207A0A;
	Tue,  4 Mar 2025 14:23:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96E7207676
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098226; cv=none; b=ol5v7KIcvsYXoGwdXizbT7Y4URvaEcPOzie4mQ0i6Q4y7ZHS4X/xq/kvtj2dVZStsECMMFy681N3eGBzqJq3/G+2XtzmRPPcWIOCj7fHMT0XdkGes9xJZ3zSj7Djj9NGjNUZmz97b8rj9oVKyZV8aTgWrKTsZ6oZMxV3SZYDibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098226; c=relaxed/simple;
	bh=QCUb/jDI9q9/yfiSHSxl4Y+RGwLh55vL7LgIc3xr40Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsN+ENP/kYGyrqZXWXKFh0FrIMIJwMK4R3QwcPZ1s6cYx76AV+cGcl7f0kEaedKMW3T3ihKicuNvmSWTT8LZ8FzDZ3YuJbPTlkN4/E94Y1L8cnxkImJ8bzT7xyjuI9U28OUG6hESXJSfkdHP2o7E6e0lbljIbAQXHSMtMKchAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 065531007;
	Tue,  4 Mar 2025 06:23:58 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B2A3F66E;
	Tue,  4 Mar 2025 06:23:42 -0800 (PST)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] sched/uclamp: Simplify uclamp_eff_value()
Date: Tue,  4 Mar 2025 14:23:13 +0000
Message-Id: <d97467f531aac07116ecad4e5be44693d07d26af.1741091349.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741091349.git.hongyan.xia2@arm.com>
References: <cover.1741091349.git.hongyan.xia2@arm.com>
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
 kernel/sched/sched.h | 10 +++++++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 85c69ca7abaa..f3825e36ae85 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1569,20 +1569,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
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
 void uclamp_update_active_nolock(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
-	for_each_clamp_id(clamp_id)
+	for_each_clamp_id(clamp_id) {
 		p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
+		p->uclamp[clamp_id].active = 1;
+	}
 }
 
 static inline void
@@ -1737,6 +1731,7 @@ static void uclamp_fork(struct task_struct *p)
 		for_each_clamp_id(clamp_id) {
 			uclamp_se_set(&p->uclamp_req[clamp_id],
 				      uclamp_none(clamp_id), false);
+			p->uclamp[clamp_id].active = 0;
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cfeaefcec8b6..f4a82e6cc029 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3343,7 +3343,6 @@ static inline bool update_other_load_avgs(struct rq *rq) { return false; }
 
 #ifdef CONFIG_UCLAMP_TASK
 
-unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 void uclamp_update_active_nolock(struct task_struct *p);
 
 /*
@@ -3372,6 +3371,15 @@ static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
+static inline unsigned long
+uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
+{
+	if (uclamp_is_used() && p->uclamp[clamp_id].active)
+		return p->uclamp[clamp_id].value;
+
+	return uclamp_none(clamp_id);
+}
+
 static inline void
 uclamp_se_set(struct uclamp_se *uc_se, unsigned int value, bool user_defined)
 {
-- 
2.34.1


