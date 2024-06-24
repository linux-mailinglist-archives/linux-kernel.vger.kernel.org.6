Return-Path: <linux-kernel+bounces-226836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 363DE91448F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667351C210A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7321F629E4;
	Mon, 24 Jun 2024 08:21:24 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480C61FD0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217284; cv=none; b=K4pLG43AoX4nw630TPdnNViMFFTmUCoK11cdViqLP4KG+rGkrAYp8BZMyjC274BHswMyk31OOPBs5e05TSFhe2eLEUSjRnfikLXCjv62Emze0H8pQgJwZkz1aEBizEyPdkXGg30QBaQkky2u1tkcEQMZtWT2nzGEqdbJK+BI8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217284; c=relaxed/simple;
	bh=1Y4MD7O0Sn0caasI14iYSMxVj1Tw9koFFeMIeFBIh30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5AlTG1qRtKayqfZpygwgRZnDmZ5NCkevot/FFsTHTf/D0V++nMyXNu9yn3+BdFfhbvMGfelneKHIiwYkK0ceGr6gIsr8A7u5IZTd7J8H1hvNpox2k5XRokYBrEQ6kQXUAM2cnR4m1xrlDdLqlY6gF0ejLXmxunnXPCRveqT6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 45O8LHvj021702
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:21:17 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45O8KokQ018801;
	Mon, 24 Jun 2024 16:20:50 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W714q6z6qz2SwTfL;
	Mon, 24 Jun 2024 16:16:11 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 24 Jun 2024 16:20:47 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <qyousef@layalina.io>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <christian.loehle@arm.com>, <vincent.donnefort@arm.com>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/2] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
Date: Mon, 24 Jun 2024 16:20:10 +0800
Message-ID: <20240624082011.4990-2-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240624082011.4990-1-xuewen.yan@unisoc.com>
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 45O8KokQ018801

Commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
changed the PD's util from per-CPU to per-PD capping. But because
the effective_cpu_util() would return a util which maybe bigger
than the actual_cpu_capacity, this could cause the pd_busy_time
calculation errors.
So clamp the cpu_busy_time with the eenv->cpu_cap, which is
the actual_cpu_capacity.

Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
---
V2:
- change commit message.
- remove the eenv->pd_cap capping in eenv_pd_busy_time(). (Dietmar)
- add Tested-by.
---
 kernel/sched/fair.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..5ca6396ef0b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7864,16 +7864,17 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 				     struct cpumask *pd_cpus,
 				     struct task_struct *p)
 {
-	unsigned long busy_time = 0;
 	int cpu;
 
+	eenv->pd_busy_time = 0;
+
 	for_each_cpu(cpu, pd_cpus) {
 		unsigned long util = cpu_util(cpu, p, -1, 0);
 
-		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
+		util = effective_cpu_util(cpu, util, NULL, NULL);
+		util = min(eenv->cpu_cap, util);
+		eenv->pd_busy_time += util;
 	}
-
-	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
 }
 
 /*
-- 
2.25.1


