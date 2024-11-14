Return-Path: <linux-kernel+bounces-409300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E2E9C8B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F1F1F220AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A9D1FAEE3;
	Thu, 14 Nov 2024 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HvHqLv2s"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F61F8900
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588685; cv=none; b=RKSnORUJvlrJlEnx/7wI4e0EhaLhiohcLJzf1AyD5kE7unYR/xGw+GnA+HCuAZDULiDYR1C2qPD/2ox7inYF1fwInSOkwN0eWbTXNjal/xavUNmq9OD3g6oW5M+uZxD/otGLJ0f9e1oC7q7yq5pENi6F+rheFFnuJqKXuwnKB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588685; c=relaxed/simple;
	bh=SxG5TdYCE15ZPxOi9YG3PFXWrv+0+/FkURCaAk5cS9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaVLikJUH6W4UdOZx+uJ//qQYQB/xdAxYR5toS0/aMlNk9pCztInXo2rdv7WADKwyS9wOmYHuHvclFeHumS4lgHplG3UsvheuIdE/NBwMo5jUCsLOq3KQKf4CMc/1Exjun0OYi4DFKrpBc0U4n5PJLkASGSU+ThYhH3gfMUExMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=HvHqLv2s; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588678;
	bh=nIDTNg0/wpMBXxSLFWFsRWRp9EMw+4e2Gw2pkD5xRsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvHqLv2sjBHMNLLbhq745meUC/9GgDIpiSeJ5WkyCBuF3fOb/OxmhZUgnCkbvWlM5
	 +V8nrGu4yfVBqqC75nZJXs0zToznb2Di1xrrvCxQ5And1hwdRY0kGmy7rGl/FdLTln
	 BgJhhrsZI7yEeg7zjuMehTsfK5WQFR7RWKKUu+ix5L9QCEkDLZVu6nr303FRit1q7o
	 iN1OFf6Y0U7aZaTy4yC+4XYEmo9a/lXoKcCdzhpas5spDO9NGv9kKSMglN238FNBjK
	 7miiR1Nm6MG16ZtZTzxwJ2J8JhPBM1GAJelNeI4D45pFIxpyaXnc1MpmlHUrj3Z/cp
	 iRwkVPGevJSgw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QG1RT0z4x6k;
	Thu, 14 Nov 2024 23:51:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 03/20] powerpc: Remove PPC_PMI and driver
Date: Thu, 14 Nov 2024 23:50:52 +1100
Message-ID: <20241114125111.599093-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_PPC_PMI is no longer selectable now that PPC_IBM_CELL_BLADE has
been removed, via the dependency on PPC_IBM_CELL_POWERBUTTON.

So remove it and the driver, and the pmi.h header which it was the only
user of.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/pmi.h      |  53 ------
 arch/powerpc/platforms/cell/Kconfig |   9 -
 arch/powerpc/sysdev/Makefile        |   1 -
 arch/powerpc/sysdev/pmi.c           | 267 ----------------------------
 4 files changed, 330 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/pmi.h
 delete mode 100644 arch/powerpc/sysdev/pmi.c

diff --git a/arch/powerpc/include/asm/pmi.h b/arch/powerpc/include/asm/pmi.h
deleted file mode 100644
index 478f0a2fe7f4..000000000000
--- a/arch/powerpc/include/asm/pmi.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _POWERPC_PMI_H
-#define _POWERPC_PMI_H
-
-/*
- * Definitions for talking with PMI device on PowerPC
- *
- * PMI (Platform Management Interrupt) is a way to communicate
- * with the BMC (Baseboard Management Controller) via interrupts.
- * Unlike IPMI it is bidirectional and has a low latency.
- *
- * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
- *
- * Author: Christian Krafft <krafft@de.ibm.com>
- */
-
-#ifdef __KERNEL__
-
-#define PMI_TYPE_FREQ_CHANGE	0x01
-#define PMI_TYPE_POWER_BUTTON	0x02
-#define PMI_READ_TYPE		0
-#define PMI_READ_DATA0		1
-#define PMI_READ_DATA1		2
-#define PMI_READ_DATA2		3
-#define PMI_WRITE_TYPE		4
-#define PMI_WRITE_DATA0		5
-#define PMI_WRITE_DATA1		6
-#define PMI_WRITE_DATA2		7
-
-#define PMI_ACK			0x80
-
-#define PMI_TIMEOUT		100
-
-typedef struct {
-	u8	type;
-	u8	data0;
-	u8	data1;
-	u8	data2;
-} pmi_message_t;
-
-struct pmi_handler {
-	struct list_head node;
-	u8 type;
-	void (*handle_pmi_message) (pmi_message_t);
-};
-
-int pmi_register_handler(struct pmi_handler *);
-void pmi_unregister_handler(struct pmi_handler *);
-
-int pmi_send_message(pmi_message_t);
-
-#endif /* __KERNEL__ */
-#endif /* _POWERPC_PMI_H */
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index ee43d6092e31..758dc08a6dde 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -21,15 +21,6 @@ config SPU_BASE
 	bool
 	select PPC_COPRO_BASE
 
-config PPC_PMI
-	tristate
-	default y
-	depends on CPU_FREQ_CBE_PMI || PPC_IBM_CELL_POWERBUTTON
-	help
-	  PMI (Platform Management Interrupt) is a way to
-	  communicate with the BMC (Baseboard Management Controller).
-	  It is used in some IBM Cell blades.
-
 config CBE_CPUFREQ_SPU_GOVERNOR
 	tristate "CBE frequency scaling based on SPU usage"
 	depends on SPU_FS && CPU_FREQ
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 24a177d164f1..0834a9a12600 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_PPC_MSI_BITMAP)	+= msi_bitmap.o
 
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
-obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o fsl_mpic_err.o
diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
deleted file mode 100644
index 2511e586fe31..000000000000
--- a/arch/powerpc/sysdev/pmi.c
+++ /dev/null
@@ -1,267 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * pmi driver
- *
- * (C) Copyright IBM Deutschland Entwicklung GmbH 2005
- *
- * PMI (Platform Management Interrupt) is a way to communicate
- * with the BMC (Baseboard Management Controller) via interrupts.
- * Unlike IPMI it is bidirectional and has a low latency.
- *
- * Author: Christian Krafft <krafft@de.ibm.com>
- */
-
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/completion.h>
-#include <linux/spinlock.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/workqueue.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/platform_device.h>
-
-#include <asm/io.h>
-#include <asm/pmi.h>
-
-struct pmi_data {
-	struct list_head	handler;
-	spinlock_t		handler_spinlock;
-	spinlock_t		pmi_spinlock;
-	struct mutex		msg_mutex;
-	pmi_message_t		msg;
-	struct completion	*completion;
-	struct platform_device	*dev;
-	int			irq;
-	u8 __iomem		*pmi_reg;
-	struct work_struct	work;
-};
-
-static struct pmi_data *data;
-
-static irqreturn_t pmi_irq_handler(int irq, void *dev_id)
-{
-	u8 type;
-	int rc;
-
-	spin_lock(&data->pmi_spinlock);
-
-	type = ioread8(data->pmi_reg + PMI_READ_TYPE);
-	pr_debug("pmi: got message of type %d\n", type);
-
-	if (type & PMI_ACK && !data->completion) {
-		printk(KERN_WARNING "pmi: got unexpected ACK message.\n");
-		rc = -EIO;
-		goto unlock;
-	}
-
-	if (data->completion && !(type & PMI_ACK)) {
-		printk(KERN_WARNING "pmi: expected ACK, but got %d\n", type);
-		rc = -EIO;
-		goto unlock;
-	}
-
-	data->msg.type = type;
-	data->msg.data0 = ioread8(data->pmi_reg + PMI_READ_DATA0);
-	data->msg.data1 = ioread8(data->pmi_reg + PMI_READ_DATA1);
-	data->msg.data2 = ioread8(data->pmi_reg + PMI_READ_DATA2);
-	rc = 0;
-unlock:
-	spin_unlock(&data->pmi_spinlock);
-
-	if (rc == -EIO) {
-		rc = IRQ_HANDLED;
-		goto out;
-	}
-
-	if (data->msg.type & PMI_ACK) {
-		complete(data->completion);
-		rc = IRQ_HANDLED;
-		goto out;
-	}
-
-	schedule_work(&data->work);
-
-	rc = IRQ_HANDLED;
-out:
-	return rc;
-}
-
-
-static const struct of_device_id pmi_match[] = {
-	{ .type = "ibm,pmi", .name = "ibm,pmi" },
-	{ .type = "ibm,pmi" },
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, pmi_match);
-
-static void pmi_notify_handlers(struct work_struct *work)
-{
-	struct pmi_handler *handler;
-
-	spin_lock(&data->handler_spinlock);
-	list_for_each_entry(handler, &data->handler, node) {
-		pr_debug("pmi: notifying handler %p\n", handler);
-		if (handler->type == data->msg.type)
-			handler->handle_pmi_message(data->msg);
-	}
-	spin_unlock(&data->handler_spinlock);
-}
-
-static int pmi_of_probe(struct platform_device *dev)
-{
-	struct device_node *np = dev->dev.of_node;
-	int rc;
-
-	if (data) {
-		printk(KERN_ERR "pmi: driver has already been initialized.\n");
-		rc = -EBUSY;
-		goto out;
-	}
-
-	data = kzalloc(sizeof(struct pmi_data), GFP_KERNEL);
-	if (!data) {
-		printk(KERN_ERR "pmi: could not allocate memory.\n");
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	data->pmi_reg = of_iomap(np, 0);
-	if (!data->pmi_reg) {
-		printk(KERN_ERR "pmi: invalid register address.\n");
-		rc = -EFAULT;
-		goto error_cleanup_data;
-	}
-
-	INIT_LIST_HEAD(&data->handler);
-
-	mutex_init(&data->msg_mutex);
-	spin_lock_init(&data->pmi_spinlock);
-	spin_lock_init(&data->handler_spinlock);
-
-	INIT_WORK(&data->work, pmi_notify_handlers);
-
-	data->dev = dev;
-
-	data->irq = irq_of_parse_and_map(np, 0);
-	if (!data->irq) {
-		printk(KERN_ERR "pmi: invalid interrupt.\n");
-		rc = -EFAULT;
-		goto error_cleanup_iomap;
-	}
-
-	rc = request_irq(data->irq, pmi_irq_handler, 0, "pmi", NULL);
-	if (rc) {
-		printk(KERN_ERR "pmi: can't request IRQ %d: returned %d\n",
-				data->irq, rc);
-		goto error_cleanup_iomap;
-	}
-
-	printk(KERN_INFO "pmi: found pmi device at addr %p.\n", data->pmi_reg);
-
-	goto out;
-
-error_cleanup_iomap:
-	iounmap(data->pmi_reg);
-
-error_cleanup_data:
-	kfree(data);
-
-out:
-	return rc;
-}
-
-static void pmi_of_remove(struct platform_device *dev)
-{
-	struct pmi_handler *handler, *tmp;
-
-	free_irq(data->irq, NULL);
-	iounmap(data->pmi_reg);
-
-	spin_lock(&data->handler_spinlock);
-
-	list_for_each_entry_safe(handler, tmp, &data->handler, node)
-		list_del(&handler->node);
-
-	spin_unlock(&data->handler_spinlock);
-
-	kfree(data);
-	data = NULL;
-}
-
-static struct platform_driver pmi_of_platform_driver = {
-	.probe		= pmi_of_probe,
-	.remove		= pmi_of_remove,
-	.driver = {
-		.name = "pmi",
-		.of_match_table = pmi_match,
-	},
-};
-module_platform_driver(pmi_of_platform_driver);
-
-int pmi_send_message(pmi_message_t msg)
-{
-	unsigned long flags;
-	DECLARE_COMPLETION_ONSTACK(completion);
-
-	if (!data)
-		return -ENODEV;
-
-	mutex_lock(&data->msg_mutex);
-
-	data->msg = msg;
-	pr_debug("pmi_send_message: msg is %08x\n", *(u32*)&msg);
-
-	data->completion = &completion;
-
-	spin_lock_irqsave(&data->pmi_spinlock, flags);
-	iowrite8(msg.data0, data->pmi_reg + PMI_WRITE_DATA0);
-	iowrite8(msg.data1, data->pmi_reg + PMI_WRITE_DATA1);
-	iowrite8(msg.data2, data->pmi_reg + PMI_WRITE_DATA2);
-	iowrite8(msg.type, data->pmi_reg + PMI_WRITE_TYPE);
-	spin_unlock_irqrestore(&data->pmi_spinlock, flags);
-
-	pr_debug("pmi_send_message: wait for completion\n");
-
-	wait_for_completion_interruptible_timeout(data->completion,
-						  PMI_TIMEOUT);
-
-	data->completion = NULL;
-
-	mutex_unlock(&data->msg_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pmi_send_message);
-
-int pmi_register_handler(struct pmi_handler *handler)
-{
-	if (!data)
-		return -ENODEV;
-
-	spin_lock(&data->handler_spinlock);
-	list_add_tail(&handler->node, &data->handler);
-	spin_unlock(&data->handler_spinlock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pmi_register_handler);
-
-void pmi_unregister_handler(struct pmi_handler *handler)
-{
-	if (!data)
-		return;
-
-	pr_debug("pmi: unregistering handler %p\n", handler);
-
-	spin_lock(&data->handler_spinlock);
-	list_del(&handler->node);
-	spin_unlock(&data->handler_spinlock);
-}
-EXPORT_SYMBOL_GPL(pmi_unregister_handler);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");
-MODULE_DESCRIPTION("IBM Platform Management Interrupt driver");
-- 
2.47.0


