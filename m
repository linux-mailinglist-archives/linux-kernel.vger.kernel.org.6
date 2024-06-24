Return-Path: <linux-kernel+bounces-227028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59C914766
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE5A1C232B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678013A3E3;
	Mon, 24 Jun 2024 10:24:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234E13A240
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224664; cv=none; b=hXTKNQXtbceIrlfb3EYXgDyf2q49z2cQL2MlozgpUhDdIGTKqmOFoKTjzBgykDMxkG3ABEOuM5bHG+enpwagiTqHgV73gTF5bgZIM0MSjU41DGua7YUKlxlmWpZH2AgQUYFoyThBljAvOO13Muf5xdjvwjn01i7sER9AJoGSW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224664; c=relaxed/simple;
	bh=GVrexOSXchRwkLEcqMASpbL2gufR/zoy5FB93APaTvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6sxTy5We6WGklYW3l+UCJez47jIOwkD7kQqXmZBHGXumF11ExGa4oGu8B6TindW76swITXor70CeaKX7xqaE4Aa2U7kg5m4kAd7P+QED35VH5hMt6/c4gABGLg6jAAg2vZ6cSKndX9emPHt/5di1Ql7rDgC3haVnFyiMGsoBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625D5FEC;
	Mon, 24 Jun 2024 03:24:47 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83B663F766;
	Mon, 24 Jun 2024 03:24:20 -0700 (PDT)
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
	Pierre Gondois <pierre.gondois@arm.com>,
	Youssef Esmat <youssefesmat@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] sched/uclamp: Simplify uclamp_eff_value()
Date: Mon, 24 Jun 2024 11:23:55 +0100
Message-Id: <ff87e9e8fd5a40444bf4fd683bfc6eb3728f9250.1719223916.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719223916.git.hongyan.xia2@arm.com>
References: <cover.1719223916.git.hongyan.xia2@arm.com>
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
index 767894fc1562..6dc8aa730eb6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1484,20 +1484,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
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
@@ -1652,6 +1646,7 @@ static void uclamp_fork(struct task_struct *p)
 		for_each_clamp_id(clamp_id) {
 			uclamp_se_set(&p->uclamp_req[clamp_id],
 				      uclamp_none(clamp_id), false);
+			p->uclamp[clamp_id].active = 0;
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e01e42d2703d..59e5ea421a4c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3052,7 +3052,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 
 #ifdef CONFIG_UCLAMP_TASK
 
-unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 void uclamp_update_active_nolock(struct task_struct *p);
 
 /*
@@ -3081,6 +3080,15 @@ static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
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


