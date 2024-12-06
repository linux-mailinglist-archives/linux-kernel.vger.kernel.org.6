Return-Path: <linux-kernel+bounces-434851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D759E6C06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE118842D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22CA1FAC5F;
	Fri,  6 Dec 2024 10:18:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E182036FB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480301; cv=none; b=dUcvLbjqkcp9ISKs/0ARvNMxace3+t2XSDnMc1lvIeQtMDBwtiwCXYiaquSesSBZLA0uARVoBW8Cyvik0B667i0hIbu5qo/ic9Xw0+P6TxWn7w++1+lpYmHo8GNX91qEAjf3CUkOuE+7WO3G7GSGhT7RP74/hesFLhm5Jm/yTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480301; c=relaxed/simple;
	bh=rqurVqkZRfW7oZulKQzLpzbxWMwBVcnf1qx2ZqnnqlI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1O78Mfr53wMW8kq07VatPGCX03Qri5qv11MSiM0dh9ZTJ70dHaVqlJGcs6TNj1ln88r3K9OzwdojVDgrGKWrnRJHz0xczzLthZnTp2caU+R/iPp4DTdApu9oG31YS2k15U3e822fajwZ1j+xg862RfapcHB3Ecuq+ZkjgeK5gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y4Rwr30x4z11Pg9;
	Fri,  6 Dec 2024 18:15:56 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 95893140360;
	Fri,  6 Dec 2024 18:18:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Dec
 2024 18:18:14 +0800
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
Subject: [PATCH -next v5 07/22] arm64: entry: preempt_schedule_irq() only if PREEMPTION enabled
Date: Fri, 6 Dec 2024 18:17:29 +0800
Message-ID: <20241206101744.4161990-8-ruanjinjie@huawei.com>
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

The generic entry check PREEMPTION for both PREEMPT_DYNAMIC
enabled and PREEMPT_DYNAMIC disabled.

Whether PREEMPT_DYNAMIC enabled or not, PREEMPTION should
be enabled to allow reschedule before EL1 exception return, so
move PREEMPTION check ahead in preparation for moving arm64 over
to the generic entry code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/entry-common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 80b47ca02db2..029f8bd72f8a 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -109,9 +109,6 @@ void raw_irqentry_exit_cond_resched(void)
 #ifdef CONFIG_PREEMPT_DYNAMIC
 	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
 		return;
-#else
-	if (!IS_ENABLED(CONFIG_PREEMPTION))
-		return;
 #endif
 
 	if (!preempt_count()) {
@@ -142,7 +139,8 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs,
 			return;
 		}
 
-		raw_irqentry_exit_cond_resched();
+		if (IS_ENABLED(CONFIG_PREEMPTION))
+			raw_irqentry_exit_cond_resched();
 
 		trace_hardirqs_on();
 	} else {
-- 
2.34.1


