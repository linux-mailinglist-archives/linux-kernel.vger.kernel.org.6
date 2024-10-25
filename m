Return-Path: <linux-kernel+bounces-380993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D69AF8C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB837282FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E89218C01F;
	Fri, 25 Oct 2024 04:06:37 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489C18B49F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729829197; cv=none; b=JfkjvMahjrkrpxRX5qSPiWlwwq0Z4k9SNb11eM2JLl08yQ6rWTAFAIv98ctnXTzg5hKBQJEgr3qbtULO9W4rCTi99bFa4rkH7YiCEAiiFn/GILqErRPfzGOv5HLiWhgvI6k74UUWS0DV+dbDmxzgNm6f2D/7rw48xRX/8IrIPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729829197; c=relaxed/simple;
	bh=Dy3a75mbMFh1VPSqT6Qk52Xix/OR67VZZOyApTITY6k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dVxbCLdycalYxOAbelDTNVWKEHCeQuBD8GQP+sP4cC1bLcxI99n1zMsVWdafLDDVvWJqosu4gyrkIgegf5Mntd0aLKwym9UebYNkzTUpzcpwI1364Lmp97OujyedxPSrjzDNHCI7C3Cn3W2shJTZKWJFhxGGtFphXQWhtzEXCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XZTFX6HDzz1SDDD;
	Fri, 25 Oct 2024 11:45:20 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id C9FB9140158;
	Fri, 25 Oct 2024 11:46:46 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 11:46:45 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <vschneid@redhat.com>, <bsegall@google.com>, <juri.lelli@redhat.com>,
	<peterz@infradead.org>, <changhuaixin@linux.alibaba.com>, <mgorman@suse.de>,
	<rostedt@goodmis.org>, <mingo@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/rt: Fix not used variable 'max_rt_runtime'
Date: Fri, 25 Oct 2024 12:00:26 +0800
Message-ID: <20241025040026.1683576-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Fix the following compilation warning:

kernel/sched/rt.c:9:18: warning: ‘max_rt_runtime’ defined but not used
[-Wunused-const-variable=]
    9 | static const u64 max_rt_runtime = MAX_BW;

Only define the const variables when the CONFIG_SYSCTL or
CONFIG_RT_GROUP_SCHED is enabled.

Fixes: d505b8af5891 ("sched: Defend cfs and rt bandwidth quota against overflow")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 172c588de542..0957f44b2eda 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,8 +5,10 @@
  */
 
 int sched_rr_timeslice = RR_TIMESLICE;
+#if defined(CONFIG_SYSCTL) || defined(CONFIG_RT_GROUP_SCHED)
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
+#endif
 
 /*
  * period over which we measure -rt task CPU usage in us.
-- 
2.25.1


