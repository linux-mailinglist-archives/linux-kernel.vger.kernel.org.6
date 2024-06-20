Return-Path: <linux-kernel+bounces-222092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA4E90FCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F47285FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BF92E620;
	Thu, 20 Jun 2024 06:31:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2F13AF9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865101; cv=none; b=pLW0E5AHojUgVr6Xz+klim8bnJR54cxNrniKXf60ygks10PF0YlIxrPViuxw+LRrvByub7CsTnhAr6FfDmyyR8pnGhZ8EXCB57uvYOkvJxYnC/T3V28LgUVRt7IndWMEGpBrlYWCalBaSZs5fRyIS2aJcd80AhErhZCF9gMD0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865101; c=relaxed/simple;
	bh=djDtqmKbWE43ZmKEyGgUp90Vv60j3Wv2QasU7cUbGM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t1SSPLOB6KOzHuCR8m+N2A1VCaincsGK1I+fROnicvybYP/oXbfClzKtY0N+8u3rb+EqkP+bXUX79OxGEmZPUBBLNSKrl+8nt1LhH3P62L8SQgzhpKauxesF6IltGbY8tkr+qkFRtohqKQClz7Iu+FwOKsXbcD2DtRXtSY3THos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W4Vs63g7szxSww;
	Thu, 20 Jun 2024 14:27:22 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 82DB8140120;
	Thu, 20 Jun 2024 14:31:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 14:31:34 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<dianders@chromium.org>, <swboyd@chromium.org>, <sumit.garg@linaro.org>,
	<frederic@kernel.org>, <scott@os.amperecomputing.com>,
	<misono.tomohiro@fujitsu.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] arm64: smp: Fix missing IPI statistics
Date: Thu, 20 Jun 2024 14:34:17 +0800
Message-ID: <20240620063417.573467-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
/proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
is missing in display.

Before this patch, CPU_BACKTRACE and KGDB_ROUNDUP IPIs are missing:
	/ # cat /proc/interrupts
	           CPU0       CPU1       CPU2       CPU3
	 11:        466        600        309        332     GICv3  27 Level     arch_timer
	 13:         24          0          0          0     GICv3  33 Level     uart-pl011
	 15:         64          0          0          0     GICv3  78 Edge      virtio0
	 16:          0          0          0          0     GICv3  79 Edge      virtio1
	 17:          0          0          0          0     GICv3  34 Level     rtc-pl031
	 18:          3          3          3          3     GICv3  23 Level     arm-pmu
	 19:          0          0          0          0 9030000.pl061   3 Edge      GPIO Key Poweroff
	IPI0:         7         14          9         26       Rescheduling interrupts
	IPI1:       354         93        233        255       Function call interrupts
	IPI2:         0          0          0          0       CPU stop interrupts
	IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
	IPI4:         0          0          0          0       Timer broadcast interrupts
	IPI5:         1          0          0          0       IRQ work interrupts
	Err:          0

After this pacth, CPU_BACKTRACE and KGDB_ROUNDUP IPIs are displayed:
	/ # cat /proc/interrupts
	           CPU0       CPU1       CPU2       CPU3
	 11:        393        281        532        449     GICv3  27 Level     arch_timer
	 13:         15          0          0          0     GICv3  33 Level     uart-pl011
	 15:         64          0          0          0     GICv3  78 Edge      virtio0
	 16:          0          0          0          0     GICv3  79 Edge      virtio1
	 17:          0          0          0          0     GICv3  34 Level     rtc-pl031
	 18:          2          2          2          2     GICv3  23 Level     arm-pmu
	 19:          0          0          0          0 9030000.pl061   3 Edge      GPIO Key Poweroff
	IPI0:        11         19          4         23       Rescheduling interrupts
	IPI1:       279        347        222         72       Function call interrupts
	IPI2:         0          0          0          0       CPU stop interrupts
	IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
	IPI4:         0          0          0          0       Timer broadcast interrupts
	IPI5:         1          0          0          1       IRQ work interrupts
	IPI6:         0          0          0          0       CPU backtrace interrupts
	IPI7:         0          0          0          0       KGDB roundup interrupts
	Err:          0

Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Doug Anderson <dianders@chromium.org>
---
v2:
- Report them in arch_show_interrupts().
- Add suggested-by.
- Update the commit message.
---
 arch/arm64/kernel/smp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 31c8b3094dd7..5de85dccc09c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -767,13 +767,15 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static const char *ipi_types[NR_IPI] __tracepoint_string = {
+static const char *ipi_types[MAX_IPI] __tracepoint_string = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
 	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
+	[IPI_CPU_BACKTRACE]	= "CPU backtrace interrupts",
+	[IPI_KGDB_ROUNDUP]	= "KGDB roundup interrupts",
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
@@ -784,7 +786,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
 
-	for (i = 0; i < NR_IPI; i++) {
+	for (i = 0; i < MAX_IPI; i++) {
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-- 
2.34.1


