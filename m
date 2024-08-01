Return-Path: <linux-kernel+bounces-271022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E694488C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C4C2866F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA284183CD8;
	Thu,  1 Aug 2024 09:34:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D38170A14
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504873; cv=none; b=iyiVEPgyWiY8gNNBWeGIaxNZ0hkJJ9Zv339rAdjnuQcty0oN+W/N9TRvuPnrgl6eeEq5kGmlIBJwm2n17SuqQcmQM5kLkuR0MBdrDvBpmnQ/S7oD/eOMGdMtQU5XD2Oip5VadM2dIgBoJds8dFDk5X72VTAEw4cQTlOL3FBPw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504873; c=relaxed/simple;
	bh=8yzCb93TuGtK+6B7TxSx3zh57RFbaWRvc8mJ+LFybbI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNBlBMc607TN8sPg3ZmgmiRXSwFg5IQGBT/Mlo08gyYAmNZHVNdJzVsToiYiYDgGFsPO3/EfC2kEOYIQOYHMS5n/D9m4I90peCw1/UzrLdfltl6C53EonuCYeOCdBlwciLZdLS268vWTS/fNW43QsVA6wHddDjaAr53/XKJ4xsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZNvr3TNKzyPSr;
	Thu,  1 Aug 2024 17:29:28 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D504018006C;
	Thu,  1 Aug 2024 17:34:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 17:34:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <dianders@chromium.org>, <mhocko@suse.com>,
	<akpm@linux-foundation.org>, <maz@kernel.org>, <vschneid@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] ARM: smp: Fix missing backtrace IPI statics
Date: Thu, 1 Aug 2024 17:40:22 +0800
Message-ID: <20240801094022.1402616-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)

It is similar to ARM64 commit 916b93f4e865 ("arm64: smp: Fix missing IPI
statistics"), commit 56afcd3dbd19 ("ARM: Allow IPIs to be handled as normal
interrupts") set CPU_BACKTRACE IPI "IRQ_HIDDEN" flag but not show it in
show_ipi_list(), which cause the interrupt kstat_irqs accounting
is missing in display.

Before this patch, CPU_BACKTRACE IPI is missing (QEMU vexpress-a9):
	 # cat /proc/interrupts
	           CPU0
	 24:          6 GIC-0  34 Level     timer
	 25:        455 GIC-0  29 Level     twd
	 26:         42 GIC-0  75 Edge      virtio0
	 29:          8 GIC-0  44 Level     kmi-pl050
	 30:        118 GIC-0  45 Level     kmi-pl050
	 31:          0 GIC-0  36 Level     rtc-pl031
	 32:          0 GIC-0  41 Level     mmci-pl18x (cmd)
	 33:          0 GIC-0  42 Level     mmci-pl18x (pio)
	 34:          0 GIC-0  92 Level     arm-pmu
	 35:          0 GIC-0  93 Level     arm-pmu
	 36:          0 GIC-0  94 Level     arm-pmu
	 37:          0 GIC-0  95 Level     arm-pmu
	 39:         15 GIC-0  37 Level     uart-pl011
	IPI0:          0  CPU wakeup interrupts
	IPI1:          0  Timer broadcast interrupts
	IPI2:          0  Rescheduling interrupts
	IPI3:          0  Function call interrupts
	IPI4:          0  CPU stop interrupts
	IPI5:          0  IRQ work interrupts
	IPI6:          0  completion interrupts
	Err:          0

After this pacth, CPU_BACKTRACE IPI is displayed:
	 # cat /proc/interrupts
	           CPU0
	 24:          6 GIC-0  34 Level     timer
	 25:        687 GIC-0  29 Level     twd
	 26:         42 GIC-0  75 Edge      virtio0
	 29:          8 GIC-0  44 Level     kmi-pl050
	 30:        134 GIC-0  45 Level     kmi-pl050
	 31:          0 GIC-0  36 Level     rtc-pl031
	 32:          0 GIC-0  41 Level     mmci-pl18x (cmd)
	 33:          0 GIC-0  42 Level     mmci-pl18x (pio)
	 34:          0 GIC-0  92 Level     arm-pmu
	 35:          0 GIC-0  93 Level     arm-pmu
	 36:          0 GIC-0  94 Level     arm-pmu
	 37:          0 GIC-0  95 Level     arm-pmu
	 39:         29 GIC-0  37 Level     uart-pl011
	IPI0:          0  CPU wakeup interrupts
	IPI1:          0  Timer broadcast interrupts
	IPI2:          0  Rescheduling interrupts
	IPI3:          0  Function call interrupts
	IPI4:          0  CPU stop interrupts
	IPI5:          0  IRQ work interrupts
	IPI6:          0  completion interrupts
	IPI7:          0  CPU backtrace interrupts
	Err:          0

Fixes: 56afcd3dbd19 ("ARM: Allow IPIs to be handled as normal interrupts")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3431c0553f45..be15cca7f8d7 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -531,7 +531,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static const char *ipi_types[NR_IPI] __tracepoint_string = {
+static const char *ipi_types[MAX_IPI] __tracepoint_string = {
 	[IPI_WAKEUP]		= "CPU wakeup interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
@@ -539,6 +539,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 	[IPI_COMPLETION]	= "completion interrupts",
+	[IPI_CPU_BACKTRACE]	= "CPU backtrace interrupts"
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
@@ -547,7 +548,7 @@ void show_ipi_list(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
 
-	for (i = 0; i < NR_IPI; i++) {
+	for (i = 0; i < MAX_IPI; i++) {
 		if (!ipi_desc[i])
 			continue;
 
-- 
2.34.1


