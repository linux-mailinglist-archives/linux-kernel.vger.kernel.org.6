Return-Path: <linux-kernel+bounces-434854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15B9E6C13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B2416D353
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932A2101B4;
	Fri,  6 Dec 2024 10:18:23 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6F203709
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480303; cv=none; b=DWdMp9I7/YC140eBj1qCRpAH2gSwWs0lVYIh8h97UJ/4/HNcLUHLonj46ZrcyS1L/efv1BvRAalDOpwv4a3UlTMh2r5Hm95gmahTX361c6qFwxfDsszYGhHN0LF6+rA3M6xxLN5AMULE853dOo7aXe7rfDx8AUU/9lLnw4cKfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480303; c=relaxed/simple;
	bh=4WskRhQGagi4FTzcq1gOuzQk5wCw0fW6eoTW77UW75g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCeMWfdJTUBAWIXxXg2ztAVebBAs/fbxBvTPQtc3ZTW0p13qiLK8pSI2unWZ3m8et0SInGoo5x/a09Cy3QTK/ovBzXgJWmtOhofjMqNpj+2MWrHR+APwdTA442tNumNkm/BxMdUDWFAH7Kjgq08UGCLFEOROCcv3QJqhE85fuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y4Rw20yXpz1V4WK;
	Fri,  6 Dec 2024 18:15:14 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 318F818009B;
	Fri,  6 Dec 2024 18:18:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:11 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kees@kernel.org>, <wad@chromium.org>,
	<akpm@linux-foundation.org>, <samitolvanen@google.com>,
	<masahiroy@kernel.org>, <hca@linux.ibm.com>, <aliceryhl@google.com>,
	<rppt@kernel.org>, <xur@google.com>, <paulmck@kernel.org>, <arnd@arndb.de>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <mark.rutland@arm.com>,
	<ruanjinjie@huawei.com>, <pcc@google.com>, <ardb@kernel.org>,
	<sudeep.holla@arm.com>, <guohanjun@huawei.com>, <rafael@kernel.org>,
	<liuwei09@cestc.cn>, <dwmw@amazon.co.uk>, <Jonathan.Cameron@huawei.com>,
	<liaochang1@huawei.com>, <kristina.martsenko@arm.com>, <ptosi@google.com>,
	<broonie@kernel.org>, <thiago.bauermann@linaro.org>, <kevin.brodsky@arm.com>,
	<joey.gouly@arm.com>, <liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH -next v5 05/22] arm64: entry: Use preempt_count() and need_resched() helper
Date: Fri, 6 Dec 2024 18:17:27 +0800
Message-ID: <20241206101744.4161990-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206101744.4161990-1-ruanjinjie@huawei.com>
References: <20241206101744.4161990-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)

The generic entry code uses preempt_count() and need_resched() helpers to
check if it is time to resched. Currently, arm64 use its own check logic,
that is "READ_ONCE(current_thread_info()->preempt_count == 0", which is
equivalent to "preempt_count() == 0 && need_resched()".

In preparation for moving arm64 over to the generic entry code, use
these helpers to replace arm64's own code and move it ahead.

No functional changes.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/entry-common.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index da68c089b74b..efd1a990d138 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -88,14 +88,6 @@ static inline bool arm64_need_resched(void)
 	if (!need_irq_preemption())
 		return false;
 
-	/*
-	 * Note: thread_info::preempt_count includes both thread_info::count
-	 * and thread_info::need_resched, and is not equivalent to
-	 * preempt_count().
-	 */
-	if (READ_ONCE(current_thread_info()->preempt_count) != 0)
-		return false;
-
 	/*
 	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
 	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
@@ -141,8 +133,10 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs,
 			return;
 		}
 
-		if (arm64_need_resched())
-			preempt_schedule_irq();
+		if (!preempt_count() && need_resched()) {
+			if (arm64_need_resched())
+				preempt_schedule_irq();
+		}
 
 		trace_hardirqs_on();
 	} else {
-- 
2.34.1


