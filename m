Return-Path: <linux-kernel+bounces-221966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5190FB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A1D1F2299D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A318EB1;
	Thu, 20 Jun 2024 02:06:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8D17545;
	Thu, 20 Jun 2024 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849209; cv=none; b=vBBZCe5WnSortgJETZVFVI98OQ/y79EaV/78iN/aY9Z3VK6o+jqQSW1JgnE4NYS4OeMqCBbwFJYYKlnJU6S1USF5DS2hMHdWnv9yoOJQXN+lTqcJxEecJl/TPZPJjXdH14mK06yQI5xa5+F8vbWtKQHKPXiblTTW6wKPCboPOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849209; c=relaxed/simple;
	bh=gjPfHHfLjQy9AwbXRDW2GB3BsjVAgrap36/ydCt4du0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=messSGOYMdTHm7a03684eIp59TGlVWy2O47gdVlQd6vpUN70f4C2brIjdFrj8Skki3xy90DHTRP+8r9OD2S2pY7qMQT5rZnyIgH2sxMW37q8/2JdirS1coEmPp5+piXwItQBOdNFLGOM6fIE4VGjUORCTVdrZ5Ns90WO79SXd4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F67EC2BBFC;
	Thu, 20 Jun 2024 02:06:47 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()
Date: Thu, 20 Jun 2024 10:06:25 +0800
Message-ID: <20240620020625.3851354-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we use "nr_cpus=n" to hard limit the CPU number, cpu_to_node() is
not usable because it can only applied on "possible" CPUs. On the other
hand, early_cpu_to_node() can be always used instead.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Fix build for !NUMA.

 drivers/irqchip/irq-loongson-eiointc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index c7ddebf312ad..0b486fe6dc57 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "eiointc: " fmt
 
+#include <asm/numa.h>
 #include <linux/cpuhotplug.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -339,7 +340,7 @@ static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 	int node;
 
 	if (cpu_has_flatmode)
-		node = cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
+		node = early_cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
 	else
 		node = eiointc_priv[nr_pics - 1]->node;
 
@@ -431,7 +432,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 		goto out_free_handle;
 
 	if (cpu_has_flatmode)
-		node = cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
+		node = early_cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
 	else
 		node = acpi_eiointc->node;
 	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
-- 
2.43.0


