Return-Path: <linux-kernel+bounces-405043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36C9C4C53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D83E28A721
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043D205AAD;
	Tue, 12 Nov 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l9ljt9vU"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE61204020
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377659; cv=none; b=ltRt6YzxMJNryBzH4su4zA9QPOCWtFZBKD85VMWwjcHuacansd7Tsy8r4LRRll123Q7qSYLJhCSUeNTQpm+544vX3tvQv3AJmk476BeCz0dfVyB6ek+xgiKBGRvdgLO4RKmQP6Y0VjQXEsZlEds1mweIwVv6zn2zI6Fg/yrnWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377659; c=relaxed/simple;
	bh=mB6YChzRNUb89kEXrNUMFwEfd1nO9KA8x9mgACv5raA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwgTstnIJlUTZyvPUiRhGRD6sSIxPEULDYpuMRKKkHPrf2ItHd0l+80B0HJTn4QQKzIebQABSDF3N4oCXdC4T5H3qDXZr1ecO5migLtEnAh0YBBlrF/Gk6w37KjgY6ZE0hiokoKIvIPZXEpCDTqjP+RJCVeekIgLb4eZE8Bb93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l9ljt9vU; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=65pDS
	qkez0ViZ6AbD2cPQF2JYryGHDJ0TXhKb02lB20=; b=l9ljt9vUf2ed+vxSHP1Z6
	iolQ9agaBiaSIboW3E/c11vRooqUjl4TYCCDDgciHhkRVZcbuAAvDwytOHr7JLXB
	nT3jAFe7M6kfGP++voSoiv7C2K0BasP3e3ezSSyLciAV0DRbrMH0wXYITVxtKodz
	3wgLUyTdMx7K0WPY2kmVCU=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_4hwuTJnfZjdGw--.189S5;
	Tue, 12 Nov 2024 10:12:09 +0800 (CST)
From: 412574090@163.com
To: sudipm.mukherjee@gmail.com,
	mpe@ellerman.id.au,
	davem@davemloft.net,
	andreas@gaisler.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	ojeda@kernel.org,
	edumazet@google.com,
	martin.petersen@oracle.co,
	perex@perex.cz,
	t.sailer@alumni.ethz.ch,
	andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH v2 3/4] parport: add parport_data struct
Date: Tue, 12 Nov 2024 10:11:52 +0800
Message-Id: <20241112021153.18146-4-412574090@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241112021153.18146-1-412574090@163.com>
References: <20241112021153.18146-1-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_4hwuTJnfZjdGw--.189S5
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZF47KF4DWFyUKF43WFyfWFg_yoW8AFWfKo
	ZxKrWSy34rtw1fJFWrtr1qqFWkZF1xJas8C34fArn8A3srJw4ruFy8Ga1jka17WF4rKr1f
	Z34UJw4FqFy8try8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVpBTDUUUU
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBXwSVAGcysvCbkQAAsT

From: weiyufeng <weiyufeng@kylinos.cn>

add parport_data struct,save iobase,iobase_hi,irq,dma for parport.

Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
---
 arch/powerpc/include/asm/parport.h  |   5 +-
 arch/sparc/include/asm/parport_64.h |  13 +--
 drivers/parisc/superio.c            |   9 ++-
 drivers/parport/parport_cs.c        |  73 ++++++++---------
 drivers/parport/parport_pc.c        | 119 +++++++++++++++++-----------
 drivers/parport/parport_serial.c    |   7 +-
 include/linux/parport.h             |   8 ++
 include/linux/parport_pc.h          |   8 +-
 8 files changed, 143 insertions(+), 99 deletions(-)

diff --git a/arch/powerpc/include/asm/parport.h b/arch/powerpc/include/asm/parport.h
index 42cc321ed754..9acfa608c531 100644
--- a/arch/powerpc/include/asm/parport.h
+++ b/arch/powerpc/include/asm/parport.h
@@ -21,6 +21,7 @@ static int parport_pc_find_nonpci_ports (int autoirq, int autodma)
 	int propsize;
 	int count = 0;
 	int virq;
+	struct parport_data tmp_pdata;
 
 	for_each_compatible_node(np, "parallel", "pnpPNP,400") {
 		prop = of_get_property(np, "reg", &propsize);
@@ -32,8 +33,8 @@ static int parport_pc_find_nonpci_ports (int autoirq, int autodma)
 		if (!virq)
 			continue;
 
-		if (parport_pc_probe_port(io1, io2, virq, autodma, NULL, 0)
-				!= NULL)
+		parport_data_ioport_init(&tmp_pdata, io1, io2, virq, autodma);
+		if (parport_pc_probe_port(tmp_pdata, NULL, 0) != NULL)
 			count++;
 	}
 	return count;
diff --git a/arch/sparc/include/asm/parport_64.h b/arch/sparc/include/asm/parport_64.h
index 4f530a270760..ff2b7855fbb7 100644
--- a/arch/sparc/include/asm/parport_64.h
+++ b/arch/sparc/include/asm/parport_64.h
@@ -115,13 +115,14 @@ static int ecpp_probe(struct platform_device *op)
 	unsigned long d_len;
 	struct device_node *parent;
 	struct parport *p;
+	struct parport_data tmp_pdata;
 	int slot, err;
 
 	parent = op->dev.of_node->parent;
 	if (of_node_name_eq(parent, "dma")) {
-		p = parport_pc_probe_port(base, base + 0x400,
-					  op->archdata.irqs[0], PARPORT_DMA_NOFIFO,
-					  op->dev.parent->parent, 0);
+		parport_data_ioport_init(&tmp_pdata, base, base + 0x400,
+					op->archdata.irqs[0], PARPORT_DMA_NOFIFO);
+		p = parport_pc_probe_port(tmp_pdata, op->dev.parent->parent, 0);
 		if (!p)
 			return -ENOMEM;
 		dev_set_drvdata(&op->dev, p);
@@ -169,9 +170,9 @@ static int ecpp_probe(struct platform_device *op)
 	ns87303_modify(config, PTR,
 		       0, PTR_LPT_REG_DIR);
 
-	p = parport_pc_probe_port(base, base + 0x400,
-				  op->archdata.irqs[0],
-				  slot,
+	parport_data_ioport_init(&tmp_pdata, base, base + 0x400,
+				op->archdata.irqs[0], slot);
+	p = parport_pc_probe_port(tmp_pdata,
 				  op->dev.parent,
 				  0);
 	err = -ENOMEM;
diff --git a/drivers/parisc/superio.c b/drivers/parisc/superio.c
index e973c6893203..ca162c3bbe09 100644
--- a/drivers/parisc/superio.c
+++ b/drivers/parisc/superio.c
@@ -418,10 +418,11 @@ static void __init superio_serial_init(void)
 static void __init superio_parport_init(void)
 {
 #ifdef CONFIG_PARPORT_PC
-	if (!parport_pc_probe_port(sio_dev.pp_base,
-			0 /*base_hi*/,
-			PAR_IRQ, 
-			PARPORT_DMA_NONE /* dma */,
+	struct parport_data tmp_pdata;
+
+	parport_data_ioport_init(&tmp_pdata, sio_dev.pp_base, 0,
+				PAR_IRQ, PARPORT_DMA_NONE);
+	if (!parport_pc_probe_port(tmp_pdata,
 			NULL /*struct pci_dev* */,
 			0 /* shared irq flags */))
 
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index 8e7e3ac4bb87..5b2437f710cc 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -118,42 +118,43 @@ static int parport_config_check(struct pcmcia_device *p_dev, void *priv_data)
 
 static int parport_config(struct pcmcia_device *link)
 {
-    parport_info_t *info = link->priv;
-    struct parport *p;
-    int ret;
-
-    dev_dbg(&link->dev, "parport_config\n");
-
-    if (epp_mode)
-	    link->config_index |= FORCE_EPP_MODE;
-
-    ret = pcmcia_loop_config(link, parport_config_check, NULL);
-    if (ret)
-	    goto failed;
-
-    if (!link->irq)
-	    goto failed;
-    ret = pcmcia_enable_device(link);
-    if (ret)
-	    goto failed;
-
-    p = parport_pc_probe_port(link->resource[0]->start,
-			      link->resource[1]->start,
-			      link->irq, PARPORT_DMA_NONE,
-			      &link->dev, IRQF_SHARED);
-    if (p == NULL) {
-	    pr_notice("parport_cs: parport_pc_probe_port() at 0x%3x, irq %u failed\n",
-		      (unsigned int)link->resource[0]->start, link->irq);
-	goto failed;
-    }
-
-    p->modes |= PARPORT_MODE_PCSPP;
-    if (epp_mode)
-	p->modes |= PARPORT_MODE_TRISTATE | PARPORT_MODE_EPP;
-    info->ndev = 1;
-    info->port = p;
-
-    return 0;
+	parport_info_t *info = link->priv;
+	struct parport *p;
+	struct parport_data tmp_pdata;
+	int ret;
+
+	dev_dbg(&link->dev, "parport_config\n");
+
+	if (epp_mode)
+		link->config_index |= FORCE_EPP_MODE;
+
+	ret = pcmcia_loop_config(link, parport_config_check, NULL);
+	if (ret)
+		goto failed;
+
+	if (!link->irq)
+		goto failed;
+	ret = pcmcia_enable_device(link);
+	if (ret)
+		goto failed;
+
+	parport_data_ioport_init(&tmp_pdata, link->resource[0]->start,
+				link->resource[1]->start,
+				link->irq, PARPORT_DMA_NONE);
+	p = parport_pc_probe_port(tmp_pdata, &link->dev, IRQF_SHARED);
+	if (p == NULL) {
+		pr_notice("parport_cs: parport_pc_probe_port() at 0x%3x, irq %u failed\n",
+				(unsigned int)link->resource[0]->start, link->irq);
+		goto failed;
+	}
+
+	p->modes |= PARPORT_MODE_PCSPP;
+	if (epp_mode)
+		p->modes |= PARPORT_MODE_TRISTATE | PARPORT_MODE_EPP;
+	info->ndev = 1;
+	info->port = p;
+
+	return 0;
 
 failed:
 	parport_cs_release(link);
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 160d87449913..b4e959a2d8a1 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2022,9 +2022,7 @@ static int parport_dma_probe(struct parport *p)
 static LIST_HEAD(ports_list);
 static DEFINE_SPINLOCK(ports_lock);
 
-static struct parport *__parport_pc_probe_port(unsigned long int base,
-					       unsigned long int base_hi,
-					       int irq, int dma,
+static struct parport *__parport_pc_probe_port(struct parport_data data,
 					       struct device *dev,
 					       int irqflags,
 					       unsigned int mode_mask,
@@ -2044,7 +2042,7 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
 		/* We need a physical device to attach to, but none was
 		 * provided. Create our own. */
 		pdev = platform_device_register_simple("parport_pc",
-						       base, NULL, 0);
+						       data.iobase, NULL, 0);
 		if (IS_ERR(pdev))
 			return NULL;
 		dev = &pdev->dev;
@@ -2052,7 +2050,7 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
 		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(24));
 		if (ret) {
 			dev_err(dev, "Unable to set coherent dma mask: disabling DMA\n");
-			dma = PARPORT_DMA_NONE;
+			data.dma = PARPORT_DMA_NONE;
 		}
 	}
 
@@ -2065,13 +2063,17 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
 		goto out2;
 
 	/* a misnomer, actually - it's allocate and reserve parport number */
-	p = parport_register_port(base, irq, dma, ops);
+	p = parport_register_port(data.iobase, data.irq, data.dma, ops);
 	if (!p)
 		goto out3;
 
-	base_res = request_region(base, 3, p->name);
-	if (!base_res)
+	if (p->iobase) {
+		base_res = request_region(data.iobase, 3, p->name);
+		if (!base_res)
+			goto out4;
+	} else {
 		goto out4;
+	}
 
 	memcpy(ops, &parport_pc_ops, sizeof(struct parport_operations));
 	priv->ctr = 0xc;
@@ -2085,18 +2087,18 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
 	priv->port = p;
 
 	p->dev = dev;
-	p->iobase_hi = base_hi;
+	p->iobase_hi = data.iobase_hi;
 	p->modes = PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT;
 	p->private_data = priv;
 
-	if (base_hi) {
-		ECR_res = request_region(base_hi, 3, p->name);
+	if (p->iobase_hi) {
+		ECR_res = request_region(data.iobase_hi, 3, p->name);
 		if (ECR_res)
 			parport_ECR_present(p);
 	}
 
-	if (base != 0x3bc) {
-		EPP_res = request_region(base+0x3, 5, p->name);
+	if (p->iobase != 0x3bc) {
+		EPP_res = request_region(data.iobase + 0x3, 5, p->name);
 		if (EPP_res)
 			if (!parport_EPP_supported(p))
 				parport_ECPEPP_supported(p);
@@ -2191,13 +2193,16 @@ do {									\
 		pr_info("%s: irq %d detected\n", p->name, probedirq);
 
 	/* If No ECP release the ports grabbed above. */
-	if (ECR_res && (p->modes & PARPORT_MODE_ECP) == 0) {
-		release_region(base_hi, 3);
-		ECR_res = NULL;
+	if ((p->modes & PARPORT_MODE_ECP) == 0) {
+		if (p->iobase_hi && ECR_res) {
+			release_region(p->iobase_hi, 3);
+			ECR_res = NULL;
+		}
 	}
+
 	/* Likewise for EEP ports */
-	if (EPP_res && (p->modes & PARPORT_MODE_EPP) == 0) {
-		release_region(base+3, 5);
+	if (p->iobase && EPP_res && (p->modes & PARPORT_MODE_EPP) == 0) {
+		release_region(p->iobase + 3, 5);
 		EPP_res = NULL;
 	}
 	if (p->irq != PARPORT_IRQ_NONE) {
@@ -2257,10 +2262,10 @@ do {									\
 
 out5:
 	if (ECR_res)
-		release_region(base_hi, 3);
+		release_region(p->iobase_hi, 3);
 	if (EPP_res)
-		release_region(base+0x3, 5);
-	release_region(base, 3);
+		release_region(p->iobase + 0x3, 5);
+	release_region(p->iobase, 3);
 out4:
 	parport_del_port(p);
 out3:
@@ -2273,14 +2278,24 @@ do {									\
 	return NULL;
 }
 
-struct parport *parport_pc_probe_port(unsigned long int base,
-				      unsigned long int base_hi,
-				      int irq, int dma,
+void parport_data_ioport_init(struct parport_data *tmp_pdata,
+			      unsigned long iobase,
+			      unsigned long iobase_hi,
+			      int irq, int dma)
+{
+	memset(tmp_pdata, 0, sizeof(struct parport_data));
+	tmp_pdata->iobase = iobase;
+	tmp_pdata->iobase_hi = iobase_hi;
+	tmp_pdata->irq = irq;
+	tmp_pdata->dma = dma;
+}
+EXPORT_SYMBOL(parport_data_ioport_init);
+
+struct parport *parport_pc_probe_port(struct parport_data data,
 				      struct device *dev,
 				      int irqflags)
 {
-	return __parport_pc_probe_port(base, base_hi, irq, dma,
-				       dev, irqflags, 0, 0);
+	return __parport_pc_probe_port(data, dev, irqflags, 0, 0);
 }
 EXPORT_SYMBOL(parport_pc_probe_port);
 
@@ -2325,6 +2340,7 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	short inta_addr[6] = { 0x2A0, 0x2C0, 0x220, 0x240, 0x1E0 };
 	u32 ite8872set;
 	u32 ite8872_lpt, ite8872_lpthi;
+	struct parport_data tmp_pdata;
 	u8 ite8872_irq, type;
 	int irq;
 	int i;
@@ -2407,8 +2423,9 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	 * Release the resource so that parport_pc_probe_port can get it.
 	 */
 	release_region(inta_addr[i], 32);
-	if (parport_pc_probe_port(ite8872_lpt, ite8872_lpthi,
-				   irq, PARPORT_DMA_NONE, &pdev->dev, 0)) {
+	parport_data_ioport_init(&tmp_pdata, ite8872_lpt, ite8872_lpthi, irq,
+				PARPORT_DMA_NONE);
+	if (parport_pc_probe_port(tmp_pdata, &pdev->dev, 0)) {
 		pr_info("parport_pc: ITE 8872 parallel port: io=0x%X",
 			ite8872_lpt);
 		if (irq != PARPORT_IRQ_NONE)
@@ -2447,6 +2464,7 @@ static struct parport_pc_via_data via_8231_data = {
 static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 			 const struct parport_pc_via_data *via)
 {
+	struct parport_data tmp_pdata;
 	u8 tmp, tmp2, siofunc;
 	u8 ppcontrol = 0;
 	int dma, irq;
@@ -2587,7 +2605,8 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	}
 
 	/* finally, do the probe with values obtained */
-	if (parport_pc_probe_port(port1, port2, irq, dma, &pdev->dev, 0)) {
+	parport_data_ioport_init(&tmp_pdata, port1, port2, irq, dma);
+	if (parport_pc_probe_port(tmp_pdata, &pdev->dev, 0)) {
 		pr_info("parport_pc: VIA parallel port: io=0x%X", port1);
 		if (irq != PARPORT_IRQ_NONE)
 			pr_cont(", irq=%d", irq);
@@ -2868,6 +2887,7 @@ static int parport_pc_pci_probe(struct pci_dev *dev,
 {
 	int err, count, n, i = id->driver_data;
 	struct pci_parport_data *data;
+	struct parport_data tmp_pdata;
 
 	if (i < last_sio)
 		/* This is an onboard Super-IO and has already been probed */
@@ -2913,9 +2933,10 @@ static int parport_pc_pci_probe(struct pci_dev *dev,
 			printk(KERN_DEBUG "PCI parallel port detected: %04x:%04x, I/O at %#lx(%#lx), IRQ %d\n",
 			       id->vendor, id->device, io_lo, io_hi, irq);
 		}
+		parport_data_ioport_init(&tmp_pdata, io_lo, io_hi,
+					irq, PARPORT_DMA_NONE);
 		data->ports[count] =
-			__parport_pc_probe_port(io_lo, io_hi, irq,
-						PARPORT_DMA_NONE, &dev->dev,
+			__parport_pc_probe_port(tmp_pdata, &dev->dev,
 						IRQF_SHARED,
 						cards[i].mode_mask,
 						cards[i].ecr_writable);
@@ -3002,35 +3023,35 @@ static int parport_pc_pnp_probe(struct pnp_dev *dev,
 						const struct pnp_device_id *id)
 {
 	struct parport *pdata;
-	unsigned long io_lo, io_hi;
-	int dma, irq;
+	struct parport_data tmp_pdata;
 
+	memset(&tmp_pdata, 0, sizeof(struct parport_data));
 	if (pnp_port_valid(dev, 0) &&
 		!(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
-		io_lo = pnp_port_start(dev, 0);
+		tmp_pdata.iobase = pnp_port_start(dev, 0);
 	} else
 		return -EINVAL;
 
 	if (pnp_port_valid(dev, 1) &&
 		!(pnp_port_flags(dev, 1) & IORESOURCE_DISABLED)) {
-		io_hi = pnp_port_start(dev, 1);
+		tmp_pdata.iobase_hi = pnp_port_start(dev, 1);
 	} else
-		io_hi = 0;
+		tmp_pdata.iobase_hi = 0;
 
 	if (pnp_irq_valid(dev, 0) &&
 		!(pnp_irq_flags(dev, 0) & IORESOURCE_DISABLED)) {
-		irq = pnp_irq(dev, 0);
+		tmp_pdata.irq = pnp_irq(dev, 0);
 	} else
-		irq = PARPORT_IRQ_NONE;
+		tmp_pdata.irq = PARPORT_IRQ_NONE;
 
 	if (pnp_dma_valid(dev, 0) &&
 		!(pnp_dma_flags(dev, 0) & IORESOURCE_DISABLED)) {
-		dma = pnp_dma(dev, 0);
+		tmp_pdata.dma = pnp_dma(dev, 0);
 	} else
-		dma = PARPORT_DMA_NONE;
+		tmp_pdata.dma = PARPORT_DMA_NONE;
 
 	dev_info(&dev->dev, "reported by %s\n", dev->protocol->name);
-	pdata = parport_pc_probe_port(io_lo, io_hi, irq, dma, &dev->dev, 0);
+	pdata = parport_pc_probe_port(tmp_pdata, &dev->dev, 0);
 	if (pdata == NULL)
 		return -ENODEV;
 
@@ -3077,13 +3098,17 @@ static struct platform_driver parport_pc_platform_driver = {
 static int __attribute__((unused))
 parport_pc_find_isa_ports(int autoirq, int autodma)
 {
+	struct parport_data tmp_pdata;
 	int count = 0;
 
-	if (parport_pc_probe_port(0x3bc, 0x7bc, autoirq, autodma, NULL, 0))
+	parport_data_ioport_init(&tmp_pdata, 0x3bc, 0x7bc, autoirq, autodma);
+	if (parport_pc_probe_port(tmp_pdata, NULL, 0))
 		count++;
-	if (parport_pc_probe_port(0x378, 0x778, autoirq, autodma, NULL, 0))
+	parport_data_ioport_init(&tmp_pdata, 0x378, 0x778, autoirq, autodma);
+	if (parport_pc_probe_port(tmp_pdata, NULL, 0))
 		count++;
-	if (parport_pc_probe_port(0x278, 0x678, autoirq, autodma, NULL, 0))
+	parport_data_ioport_init(&tmp_pdata, 0x278, 0x678, autoirq, autodma);
+	if (parport_pc_probe_port(tmp_pdata, NULL, 0))
 		count++;
 
 	return count;
@@ -3352,6 +3377,7 @@ __setup("parport_init_mode=", parport_init_mode_setup);
 
 static int __init parport_pc_init(void)
 {
+	struct parport_data tmp_pdata;
 	int err;
 
 	if (parse_parport_params())
@@ -3370,8 +3396,9 @@ static int __init parport_pc_init(void)
 				break;
 			if (io_hi[i] == PARPORT_IOHI_AUTO)
 				io_hi[i] = 0x400 + io[i];
-			parport_pc_probe_port(io[i], io_hi[i],
-					irqval[i], dmaval[i], NULL, 0);
+			parport_data_ioport_init(&tmp_pdata, io[i], io_hi[i],
+						irqval[i], dmaval[i]);
+			parport_pc_probe_port(tmp_pdata, NULL, 0);
 		}
 	} else
 		parport_pc_find_ports(irqval[0], dmaval[0]);
diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 3644997a8342..cc6ee3f0ab3e 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -648,6 +648,7 @@ static int parport_register(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENODEV;
 
 	for (n = 0; n < card->numports; n++) {
+		struct parport_data tmp_pdata;
 		struct parport *port;
 		int lo = card->addr[n].lo;
 		int hi = card->addr[n].hi;
@@ -684,8 +685,10 @@ static int parport_register(struct pci_dev *dev, const struct pci_device_id *id)
 				"PCI parallel port detected: I/O at %#lx(%#lx), IRQ %d\n",
 				io_lo, io_hi, irq);
 		}
-		port = parport_pc_probe_port (io_lo, io_hi, irq,
-			      PARPORT_DMA_NONE, &dev->dev, IRQF_SHARED);
+		parport_data_ioport_init(&tmp_pdata, io_lo, io_hi,
+					irq, PARPORT_DMA_NONE);
+		port = parport_pc_probe_port(tmp_pdata, &dev->dev,
+						IRQF_SHARED);
 		if (port) {
 			priv->port[priv->num_par++] = port;
 			success = 1;
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 4e39c400d002..308eadce42dd 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -180,6 +180,14 @@ struct ieee1284_info {
 	struct semaphore irq;
 };
 
+struct parport_data {
+	/* for ioport */
+	unsigned long iobase;   /* base address for ioport */
+	unsigned long iobase_hi;        /* base address (hi - ECR) */
+	int irq;
+	int dma;
+};
+
 /* A parallel port */
 struct parport {
 	unsigned long iobase;	/* base address for ioport */
diff --git a/include/linux/parport_pc.h b/include/linux/parport_pc.h
index 4d92c831d06a..d6c3f323caa1 100644
--- a/include/linux/parport_pc.h
+++ b/include/linux/parport_pc.h
@@ -230,11 +230,13 @@ static __inline__ void parport_pc_enable_irq(struct parport *p)
 extern void parport_pc_release_resources(struct parport *p);
 
 extern int parport_pc_claim_resources(struct parport *p);
+extern void parport_data_ioport_init(struct parport_data *tmp_pdata,
+				     unsigned long iobase,
+				     unsigned long iobase_hi,
+				     int irq, int dma);
 
 /* PCMCIA code will want to get us to look at a port.  Provide a mechanism. */
-extern struct parport *parport_pc_probe_port(unsigned long base,
-					     unsigned long base_hi,
-					     int irq, int dma,
+extern struct parport *parport_pc_probe_port(struct parport_data data,
 					     struct device *dev,
 					     int irqflags);
 extern void parport_pc_unregister_port(struct parport *p);
-- 
2.25.1


