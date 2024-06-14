Return-Path: <linux-kernel+bounces-215180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE4B908F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CF9284887
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509D146A7D;
	Fri, 14 Jun 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gErbsjQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957314A90
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380122; cv=none; b=asUc4wpWhNwNAjqwWqrKX5U+gZ0Ea9BFvhSFMCRAutHdnomPrH+fltCtVM389xKWN/O11HTFABEcsupzOMNl+V2wwEWkKsqmufmPt6ko/S54mti6IEWJJ1NgAlUlanSk7NLLEjiS6+QSkxUt/o1CoyprmnNcnj7noNJM8sz/jHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380122; c=relaxed/simple;
	bh=jO7Dzw5P4v+LVE4NQ3h4pjMq0kf48JMKykV7530/mdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zs7z1LXRTJh2RYG89jXAWMtM09Wj9NX9whkrkazMy82XQBDgFVewPy2jLXe27iS6WfIjC+p2KSqkGkS4QcgsXkRpiEj91nvXuCF7GESQCI3MpW/2ycSiizmfxklJYyrMhwRewLMa9cHUMYSFKHbl0HNH+FhJOOWlNNEdTz64IyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gErbsjQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EF0C2BD10;
	Fri, 14 Jun 2024 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718380121;
	bh=jO7Dzw5P4v+LVE4NQ3h4pjMq0kf48JMKykV7530/mdk=;
	h=From:To:Cc:Subject:Date:From;
	b=gErbsjQXHDwJOe8wCzAChDDl0ZuO/k8RfNsD1cODyzEJKV2xE1QFWNBBnKdDlNmSr
	 SiuXFB4w7G0v1KVfZ/yhiXJP+eKTjfR8xqnZJQMZiffWcsepQc6zHdeseXNFDOQlXw
	 qsZvF6iKuWEPWIsXmVW3ANQ/sSllcFRAdY0oudiKu/JDAuHpic1Eil3dmzhRGM0fKw
	 cUPrushCS6DNBd7omHy/d81U0PjLZbeXLw7JEWOcMB7FzB1HYnJkHEUGs8G4Z+bad7
	 dZ+1TRbBw7OrgKJRJIJc5hkJffYgj3Lit9DczbG3so8hwL/2sZnFwHqtxCLNtWDGe/
	 V9B0X01H9rHNA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip/dw-apb-ictl: Support building as module
Date: Fri, 14 Jun 2024 23:34:49 +0800
Message-ID: <20240614153449.2083-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the user selection and building of this interrupt controller
driver as a module, for example, in some synaptics arm64 SoCs it is
used as a second level interrupt controller hanging off the ARM GIC
and is therefore loadable during boot.

However, this interrupt controller can also be used as the main
interrupt controller by other platforms, so we must keep this kind
of support by checking whether DW_APB_ICTL is builtin or not.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/irqchip/Kconfig           |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 14464716bacb..cfd1102eb273 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -145,7 +145,7 @@ config DAVINCI_CP_INTC
 	select IRQ_DOMAIN
 
 config DW_APB_ICTL
-	bool
+	tristate "DesignWare APB Interrupt Controller"
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN_HIERARCHY
 
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index d5c1c750c8d2..5eda6c4689cf 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -122,7 +122,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	int ret, nrirqs, parent_irq, i;
 	u32 reg;
 
-	if (!parent) {
+	if (!parent && IS_BUILTIN(CONFIG_DW_APB_ICTL)) {
 		/* Used as the primary interrupt controller */
 		parent_irq = 0;
 		domain_ops = &dw_apb_ictl_irq_domain_ops;
@@ -214,5 +214,12 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	release_mem_region(r.start, resource_size(&r));
 	return ret;
 }
-IRQCHIP_DECLARE(dw_apb_ictl,
-		"snps,dw-apb-ictl", dw_apb_ictl_init);
+#if IS_BUILTIN(CONFIG_DW_APB_ICTL)
+IRQCHIP_DECLARE(dw_apb_ictl, "snps,dw-apb-ictl", dw_apb_ictl_init);
+#else
+IRQCHIP_PLATFORM_DRIVER_BEGIN(dw_apb_ictl)
+IRQCHIP_MATCH("snps,dw-apb-ictl", dw_apb_ictl_init)
+IRQCHIP_PLATFORM_DRIVER_END(dw_apb_ictl)
+MODULE_DESCRIPTION("DesignWare APB Interrupt Controller");
+MODULE_LICENSE("GPL v2");
+#endif
-- 
2.43.0


