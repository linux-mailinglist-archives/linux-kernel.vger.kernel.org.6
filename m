Return-Path: <linux-kernel+bounces-203706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04188FDF4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7B71C235AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541CB13AD06;
	Thu,  6 Jun 2024 07:07:26 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4324224FD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657645; cv=none; b=sXhdifER1l3A2/UCja8Mq+Vpq6M9U6NbHp+nYOg80ERRkkQHENHkLIaH4PRXkV3uVQPlnZNlOXMVM64glN5cA8Y30uQuvtwzAMOTCrukThML0/rQHUPh9c+Q1HqWNslzWcSpTFkPBwzh+f4ADw3X21f1be3Bnu+cdfYTlpltI04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657645; c=relaxed/simple;
	bh=mBO2HmtvK2fIJMU1J8Uq1NGuDdwV+rRBvjv7za6eKVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3oZPU35aVnpEP5EH2zCehRa80qT1wvdgWtPugx9Z15SxLkQaX68Cua4QqchRyydkV/SOjAZgl0DVzzte82NlJcBJ1595EMka/kVA4rCTLk24OiUmfL5MLhnIKubqLnhmqZsAjmz54nfZFlj0pDoIemif6Z1aIx0GpjYgPKch9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45676xmS037336;
	Thu, 6 Jun 2024 15:06:59 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VvwJd1Vznz2RCt7x;
	Thu,  6 Jun 2024 15:02:57 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 6 Jun 2024 15:06:57 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>
CC: <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <vincent.donnefort@arm.com>, <qyousef@layalina.io>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
Date: Thu, 6 Jun 2024 15:06:45 +0800
Message-ID: <20240606070645.3295-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 45676xmS037336

Because the effective_cpu_util() would return a util which
maybe bigger than the actual_cpu_capacity, this could cause
the pd_busy_time calculation errors.
So clamp the cpu_busy_time with the eenv->cpu_cap, which is
the actual_cpu_capacity.

Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..8939d725023a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7870,7 +7870,9 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
 	for_each_cpu(cpu, pd_cpus) {
 		unsigned long util = cpu_util(cpu, p, -1, 0);
 
-		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
+		util = effective_cpu_util(cpu, util, NULL, NULL);
+		util = min(eenv->cpu_cap, util);
+		busy_time += util;
 	}
 
 	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
-- 
2.25.1


