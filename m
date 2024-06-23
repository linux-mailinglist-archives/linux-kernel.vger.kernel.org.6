Return-Path: <linux-kernel+bounces-225924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA5913793
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA241C2120F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 03:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C942125CC;
	Sun, 23 Jun 2024 03:41:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EF2F3E;
	Sun, 23 Jun 2024 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719114082; cv=none; b=QkP4755NZxqfbqFPfQE9AT1lmPwfOlSfT/AvGgSkRPwig6HX8XMXQlhTDxPxKLyewNNkEEJlV8lB3dZzCQ1Sk1SpPoWQgifzUaCseVLvK9k8nlhofc2Sbo1iB9S5QH5ATokG/5uktTaj2d9x7/9tFJocsg7i0kR3SMIEMRJm4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719114082; c=relaxed/simple;
	bh=wwxbHMTslLNaJbTC0v2mbU96VpNhAPZTzN9K/je0QQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJbM+aVPb9qcCEibUQai94T5lXxOUYhz+ZlN0VSkB2SVpDJ8dDL+XX9uCbTn+g8wPhJkIa3PMjs2TMQ9rdoiLRQRZU7bp1fGny4a28qMMj0ItXoT0UYb1htZDGXcuP5MTfPiKuiFFv84fHjAAYfbDe64H1nTKMTKixrXH47+EbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE8AC2BD10;
	Sun, 23 Jun 2024 03:41:20 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4] irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()
Date: Sun, 23 Jun 2024 11:41:13 +0800
Message-ID: <20240623034113.1808727-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we use "nr_cpus=n" to hard limit the CPU number, cpu_to_node() is
not usable for CPUs exceeding the limit. Because cpu_to_node() depends
on the per-cpu area, and the per-cpu area is only applied on "possible"
CPUs. On the other hand, early_cpu_to_node() is always usable because it
uses plain arrays to record the cpu-node mapping, and the architectural
code ensures those arrays are correctly initialized. So here we can use
early_cpu_to_node() instead.

This change is mainly needed on multi-bridge machines. On these machines
there are multiple eiointc instances, each instance should get its NUMA
node correctly.

Note: we make this change for kdump and some other special usages where
"nr_cpus=n" is needed. However, if CONFIG_NR_CPUS is not big enough to
map all the nodes connect I/O bridges, then the machine can't boot still.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Fix build for !NUMA.
V3: Adjust header file order and update commit messages.
V4: Update commit messages again.

 drivers/irqchip/irq-loongson-eiointc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index c7ddebf312ad..b1f2080be2be 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -15,6 +15,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/kernel.h>
 #include <linux/syscore_ops.h>
+#include <asm/numa.h>
 
 #define EIOINTC_REG_NODEMAP	0x14a0
 #define EIOINTC_REG_IPMAP	0x14c0
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


