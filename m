Return-Path: <linux-kernel+bounces-533664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EEEA45D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6BA18924B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4ED2153FD;
	Wed, 26 Feb 2025 11:43:57 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F120CCEB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570237; cv=none; b=pKbrkw8+0zcUV3+1n7AlP3sxphXRS5MeJRcaus7Q5qkKkjvGzVCzjEt6/wXztj/dBpwpO4ySLFi5RjHcGO/zGEjC/fQm3wn+QMCG7qTYck8YVfxEV2hyc/ks9j5a09+dgzQa+fohSqn8NnHWgqiXmmZqonrDOu0xcvpjdI5Wqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570237; c=relaxed/simple;
	bh=sniYNrvNUWro087KyCuTDWcHiLJf2phQ6kPrOWDLdgo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cm4qfMUaZ4RLgykfKFcxEM4LtM4MRyYpBfSoHBbnqWUc2zIAwqe02H6igX42aQTAwU5P+TzQoASFEEgpXPn3uWi0Cyo8+QlC0p5tUVDDvkroIECp7Fyv6EkcKlccMMcvlBtaG+58FTlEYx6YRpfKWWenY41iwaFz0YEaOjxSA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51QBheXL091362;
	Wed, 26 Feb 2025 19:43:40 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z2stx2SXHz2PqL3B;
	Wed, 26 Feb 2025 19:39:05 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 26 Feb 2025 19:43:38 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] sched/fair: Prevent from cpufreq not being updated when delayed-task is iowait
Date: Wed, 26 Feb 2025 19:43:01 +0800
Message-ID: <20250226114301.4900-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 51QBheXL091362

Because the sched-delayed task maybe in io-wait state,
so we should place the requeue_delayed_entity() after the
cpufreq_update_util(), to prevent not boosting iowait cpufreq
before return.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d6d5582c3e9..040674734128 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6931,11 +6931,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
 		util_est_enqueue(&rq->cfs, p);
 
-	if (flags & ENQUEUE_DELAYED) {
-		requeue_delayed_entity(se);
-		return;
-	}
-
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6944,6 +6939,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (flags & ENQUEUE_DELAYED) {
+		requeue_delayed_entity(se);
+		return;
+	}
+
 	if (task_new && se->sched_delayed)
 		h_nr_runnable = 0;
 
-- 
2.25.1


