Return-Path: <linux-kernel+bounces-214319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5449082C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B42FB231D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0D1487EC;
	Fri, 14 Jun 2024 03:52:39 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E7148829
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337159; cv=none; b=OteiEvPRxUQa8xh9mNsCUezYitMu6bbKTBItIjRbXe5SxqIgBgYxx7S/U4X/y41oTqQhADAJWSPZrLIlVqHJQq37nKYiyUNKYrSRtBFu8sCRWqMYpjrkQ3cmfWZX6HqekGy2T48hAdoAjPDHyw3F3A+CQxHcY50QOXkA9lxIGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337159; c=relaxed/simple;
	bh=OhwiZRce6tWl7BpdQMEmKpSkAJzoD+j4i+VDs26B1Vk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQTFDb122d5jZfhD90i55e3jWP84hsvDMoeF+ns/DT9ij2Tc9iQl5xEn9RnSdzNpbe6OX+l9VEwE0daIrWSszArDyX3504CTbao2eY6WvmQStaa015CcJ4qQpjJPfrUyvaxNGzYQgWv9q2caOqlXM40EUYELqGJfJXVB0X00MRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W0lcW34nwzwSNG;
	Fri, 14 Jun 2024 11:48:27 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C5681402C8;
	Fri, 14 Jun 2024 11:52:35 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 14 Jun
 2024 11:52:33 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ryabinin.a.a@gmail.com>,
	<glider@google.com>, <andreyknvl@gmail.com>, <dvyukov@google.com>,
	<vincenzo.frascino@arm.com>, <maz@kernel.org>, <oliver.upton@linux.dev>,
	<james.morse@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<mark.rutland@arm.com>, <lpieralisi@kernel.org>, <tglx@linutronix.de>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<steven.price@arm.com>, <ryan.roberts@arm.com>, <pcc@google.com>,
	<anshuman.khandual@arm.com>, <eric.auger@redhat.com>,
	<miguel.luis@oracle.com>, <shiqiliu@hust.edu.cn>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <sudeep.holla@arm.com>, <dwmw@amazon.co.uk>,
	<joey.gouly@arm.com>, <jeremy.linton@arm.com>, <robh@kernel.org>,
	<scott@os.amperecomputing.com>, <songshuaishuai@tinylab.org>,
	<swboyd@chromium.org>, <dianders@chromium.org>,
	<shijie@os.amperecomputing.com>, <bhe@redhat.com>,
	<akpm@linux-foundation.org>, <rppt@kernel.org>, <mhiramat@kernel.org>,
	<mcgrof@kernel.org>, <rmk+kernel@armlinux.org.uk>,
	<Jonathan.Cameron@huawei.com>, <takakura@valinux.co.jp>,
	<sumit.garg@linaro.org>, <frederic@kernel.org>, <tabba@google.com>,
	<kristina.martsenko@arm.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>, <kvmarm@lists.linux.dev>
Subject: [PATCH v4 07/10] irqchip/gic-v3: Improve the maintainability of NMI masking in GIC driver
Date: Fri, 14 Jun 2024 03:44:30 +0000
Message-ID: <20240614034433.602622-8-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614034433.602622-1-liaochang1@huawei.com>
References: <20240614034433.602622-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)

It has a better maintainability to use the local_nmi_enable() in GIC
driver to unmask NMI and keep regular IRQ and FIQ maskable, instead of
writing raw value into DAIF, PMR and ALLINT directly.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/daifflags.h | 14 ++++++++++++++
 drivers/irqchip/irq-gic-v3.c       |  6 ++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index b19dfd948704..4eb97241a58f 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -332,4 +332,18 @@ static inline void local_nmi_serror_enable(void)
 	irqflags.fields.allint = 0;
 	local_allint_restore_notrace(irqflags);
 }
+
+/*
+ * local_nmi_enable - Enable NMI with or without superpriority.
+ */
+static inline void local_nmi_enable(void)
+{
+	if (system_uses_irq_prio_masking()) {
+		gic_pmr_mask_irqs();
+		asm volatile ("msr daifclr, #3" : : : "memory");
+	} else if (system_uses_nmi()) {
+		asm volatile ("msr daifset, #3" : : : "memory");
+		msr_pstate_allint(0);
+	}
+}
 #endif
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc..ed7d8d87768f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -33,6 +33,7 @@
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
 #include <asm/virt.h>
+#include <asm/daifflags.h>
 
 #include "irq-gic-common.h"
 
@@ -813,10 +814,7 @@ static void __gic_handle_irq_from_irqson(struct pt_regs *regs)
 		nmi_exit();
 	}
 
-	if (gic_prio_masking_enabled()) {
-		gic_pmr_mask_irqs();
-		gic_arch_enable_irqs();
-	}
+	local_nmi_enable();
 
 	if (!is_nmi)
 		__gic_handle_irq(irqnr, regs);
-- 
2.34.1


