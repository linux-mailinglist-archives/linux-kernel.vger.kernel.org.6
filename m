Return-Path: <linux-kernel+bounces-339814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1F986AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6351F22CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C2A171E49;
	Thu, 26 Sep 2024 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ARtCYk/B"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9214120B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727317123; cv=none; b=hf76l+LyLpsM7R9GY0EPAelbsDxx/ZnbzBNCfjVD8WpWn1DcXq4yNmg3W9mq7pnqp6ut5vqLP8ox7KlVQs33PZy20ceoGA0LYIbgfqz4iiFyYD7fETiTBeAbPa/N9d+9XU1eq+qKm5YRDGj6jBrFf23018R5OlOK5BuM+vLFjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727317123; c=relaxed/simple;
	bh=DGxeJgemhoDo5JKQYPlnG86DMJLcCfAUQs0cO+BoAK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xbq/RHkwcY+etpNcw/4C9FwMeILQIo2vMUoTGiaTes7NHuv7amMTSdUhzLeYVDMNAadgo+BIWAcCIHeuBNzlw+4CNfc28tLqtq7ePirF1Ke2OrY64kAsi2vgeqt7jRHPLaecMC/+1hiMjCAoFOUXUNDRBwBzhyOQSmiAX8s4uVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ARtCYk/B; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727317089;
	bh=SgCHUiz82lndKjTeNsmeInw+/PdasPiFZ+8EYbiHHVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ARtCYk/BvJ0ONQLgRgevRcpB6qNCLxx9TsJH456Srvr8KJtsghjHuKpiSRTtqAlqZ
	 5kCEfZciP5FtvD8Xho3kCKxA63XxHe/4yDp4ppNidD1ECVfm+lAnF/hLMlYVoHs+m0
	 AkRnsXUn/8aiL1iGFs4FhRbN7fnhLqfPm4CKzhjM=
X-QQ-mid: bizesmtp89t1727317049t27s5x5e
X-QQ-Originating-IP: RWncql2tgzXbdZQHdtoltutKeRWhDKw8fLlZUTgT37s=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Sep 2024 10:17:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5024891882931544061
From: WangYuli <wangyuli@uniontech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	conor.dooley@microchip.com,
	charlie@rivosinc.com,
	macro@orcam.me.uk,
	palmer@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	atish.patra@wdc.com,
	anup@brainfault.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	mikelley@microsoft.com,
	oleksandr@natalenko.name,
	deller@gmx.de,
	gpiccoli@igalia.com,
	apatel@ventanamicro.com,
	maz@kernel.org,
	kernelfans@gmail.com,
	jszhang@kernel.org,
	daniel.lezcano@linaro.org,
	Alistair.Francis@wdc.com,
	atishp@atishpatra.org,
	dwmw2@infradead.org,
	mark.rutland@arm.com,
	sabrapan@amazon.com,
	ross.philipson@oracle.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH v2] riscv: Use '%u' to format the output of 'cpu'
Date: Thu, 26 Sep 2024 10:17:22 +0800
Message-ID: <DE320FC8D88E057F+20240926021722.1007313-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

'cpu' is an unsigned integer, so its conversion specifier should
be %u, not %d.

Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/all/alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/cpu-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 28b58fc5ad19..a1e38ecfc8be 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -58,7 +58,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 	if (cpu_ops->cpu_is_stopped)
 		ret = cpu_ops->cpu_is_stopped(cpu);
 	if (ret)
-		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
+		pr_warn("CPU%u may not have stopped: %d\n", cpu, ret);
 }
 
 /*
-- 
2.45.2


