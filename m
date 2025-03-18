Return-Path: <linux-kernel+bounces-565360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F183A666AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449453BA9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7B187332;
	Tue, 18 Mar 2025 03:00:32 +0000 (UTC)
Received: from mailgw2.hygon.cn (mailgw.hygon.cn [110.188.70.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4937288DB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.188.70.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742266831; cv=none; b=E53XlrOSiz0otJf4TPPeJFHs21o8SI5dj9sZw1Tx7vy5ZwPk6kBXwC9w4VzkIQI8rDEyqfxwu4ElwrJHhr9qniMqFRWgAIaFfdDcjbjWAgmgrgRTe/Ch14bxYXw8NFi98khsGZT+9MXf/ZjxElb40mMLCB00jZjhGiokc7zBDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742266831; c=relaxed/simple;
	bh=sMuHI/5udK0bUmACHAo1M6NyFZ0i9E4D6J5zFj0uhpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pDKvlZc/k2zbqofIuDwZLhOJ73SP/awWrjBXwWRRWteWo1Io/cUftEKGeKDg4XROeCGGWe/ySEVZBBvv4rc5ubOIDL5J7dKcpbjI2Fz6/ICTGzOhYjA37ft9ED540znyTAFXiGicttNOA1hWDp/TUxlswKmeCYne/UgY9SWkrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=110.188.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 5DAFC3004C93;
	Tue, 18 Mar 2025 10:24:49 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 363DA16E7;
	Tue, 18 Mar 2025 10:27:30 +0800 (CST)
Received: from jianyong.hygon.cn (172.19.22.175) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Mar
 2025 10:27:33 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: <mingo@redhat.com>, <peterz@infradead.org>
CC: <vincent.guittot@linaro.org>, <wujianyong@hygon.cn>,
	<jianyong.wu@outlook.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCHED: scatter nohz idle balance target cpus
Date: Tue, 18 Mar 2025 02:23:58 +0000
Message-ID: <20250318022358.195154-1-wujianyong@hygon.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Currently, cpu selection logic for nohz idle balance lacks history info
that leads to cpu0 is always chosen if it's in nohz cpu mask. It's not
fair fot the tasks reside in numa node0. It's worse in the machine with
large cpu number, nohz idle balance may be very heavy.

To address this issue, adding a member to "nohz" to indicate who is
chosen last time and choose next for this round of nohz idle balance.

Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c798d2795243..ba6930c79e25 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7197,6 +7197,7 @@ static struct {
 	atomic_t nr_cpus;
 	int has_blocked;		/* Idle CPUS has blocked load */
 	int needs_update;		/* Newly idle CPUs need their next_balance collated */
+	int last_cpu;			/* Last cpu chosen to do nohz idle balance */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
@@ -12266,13 +12267,15 @@ static inline int find_new_ilb(void)
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
-	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
+	for_each_cpu_wrap(ilb_cpu, nohz.idle_cpus_mask, nohz.last_cpu + 1) {
 
-		if (ilb_cpu == smp_processor_id())
+		if (ilb_cpu == smp_processor_id() || !cpumask_test_cpu(ilb_cpu, hk_mask))
 			continue;
 
-		if (idle_cpu(ilb_cpu))
+		if (idle_cpu(ilb_cpu)) {
+			nohz.last_cpu = ilb_cpu;
 			return ilb_cpu;
+		}
 	}
 
 	return -1;
-- 
2.43.0


