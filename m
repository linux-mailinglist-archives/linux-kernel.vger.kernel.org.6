Return-Path: <linux-kernel+bounces-225544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E67D9131F5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 06:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AE92866EC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 04:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9FC6EB7C;
	Sat, 22 Jun 2024 04:34:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179164CEC;
	Sat, 22 Jun 2024 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719030867; cv=none; b=I7X6smjY9/qT1h6Bd/4SmxbfK0Uo3j02Kq+2FBDwDA81HoXD6iVpbqY8xndD0aPs8mYIRGM2DyUkkL8xlZmeh3ITsiOwyupu9PqfWz8aZFmHTJ4gbRbuk+qkf2ieien+1OCBlCGHExoUhb67PwTLZFAvQEtTj6008yKiN4DwA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719030867; c=relaxed/simple;
	bh=SmTspE6e4VhfOgZRsYEM2sKteIrHadp3gNzjnvShjWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmXZHsqtEtSrfwLF2WiPD3BtDn9hYV6s9961toLJnditZ9dkm9FS9Nbkw5Ods9MCmmmWKjDzpXZaRjsp5kT6XhGZ8p3TxsqndJDZDvC3Mgdm/kPY0lHUyN/eUieV1HnVOICzsPSAlvf/Tq/spZsNyeCzXTblTj64dB2EXgzvQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF45FC32781;
	Sat, 22 Jun 2024 04:34:24 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3] irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()
Date: Sat, 22 Jun 2024 12:34:08 +0800
Message-ID: <20240622043408.1566962-1-chenhuacai@loongson.cn>
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

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Fix build for !NUMA.
V3: Adjust header file order and update commit messages.

 1 file changed, 3 insertions(+), 2 deletions(-)
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


