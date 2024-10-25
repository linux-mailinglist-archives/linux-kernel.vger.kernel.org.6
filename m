Return-Path: <linux-kernel+bounces-381242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF249AFC62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2551F2403F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A91D1E6A;
	Fri, 25 Oct 2024 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B6Or6kqb"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F71C6F6D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844516; cv=none; b=H5YAtrK672zag50kGJ/Q83T1GguCD9GuivXFPQa4hM+QUhlNloX4gQ+7d0nvLqc6Twf/WdPgSVK8Oa7ddLQX5ByiA5+xAF+LUGeeVOHrr88K048uflrR9YMOajpW/bw8L0pU06z+0oSGJctZxAkpx8CT8Kg1PSXXrz3c1zo1sMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844516; c=relaxed/simple;
	bh=PwzgpTG+PaxdwSATsrDTazYQ87yj2J1Hml989U8uQxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IHtdTQUe5HjdMc2+AIuBaMUhnl13YfpJPw2h//SJ2ZYLeeh1QVCfWP04PonXSRFG4NrBTYRvefUkjOJFmfAaoa5NMxUnLR60mpfF5etnu9hEjvLsMSOlbKfQ1kxXE5Zxt12a9/ZnVcgqJO29o325nBr1Uaz0dNL9loZw+mCTy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B6Or6kqb; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QD8zX
	HPCEF4+orgrczGB6XW+4ypsI0QCmkj2dHGrLAM=; b=B6Or6kqbZGltOsFE1VgW4
	eLcx6Bj5q1oHGanohqGrxNJTjG/JqhrlyucpS7yh0AV1rRp1vIs6Gi6tr+Ch/27J
	chz8Fakq6TOeXhG1OHsx4xQT4KsK2HzRilAc2WZaNMT/hCbcMD/mk4Zwn3cs3pqF
	m5I8CDONOBQWH1jVhcYQ4Q=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHbwYXVRtniEkiDQ--.6094S3;
	Fri, 25 Oct 2024 16:21:47 +0800 (CST)
From: 412574090@163.com
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH 2/4] parport: change struct parport member to iobase
Date: Fri, 25 Oct 2024 16:21:26 +0800
Message-Id: <20241025082128.60034-2-412574090@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025082128.60034-1-412574090@163.com>
References: <20241025082128.60034-1-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHbwYXVRtniEkiDQ--.6094S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfAF4fXF4rWFyrJryrGry8Krg_yoW5Jw4fto
	Z3GryfZasYyrn3JF48Grn7tFWxX34ku3ZxCF4fGrs8Za42qw4fGF1xGr47Ka1agw13Gr93
	Xa40qw15AF18ZrW8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxSoGUUUUU
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBFQyDAGcbUDlaoQAAs0

From: weiyufeng <weiyufeng@kylinos.cn>

change struct parport member base and base_hi to iobase and iobase_hi
for ioport. because iomem type will be added, in that case,mapbase,
mapbase_hi will be added in struct parport. this can distinguish between
these two types.

Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
---
 drivers/auxdisplay/ks0108.c       |  4 +--
 drivers/net/hamradio/baycom_epp.c | 10 ++++----
 drivers/net/hamradio/baycom_par.c |  6 ++---
 drivers/net/plip/plip.c           |  2 +-
 drivers/parport/daisy.c           |  2 +-
 drivers/parport/parport_gsc.c     |  8 +++---
 drivers/parport/parport_ip32.c    |  8 +++---
 drivers/parport/parport_pc.c      | 42 +++++++++++++++----------------
 drivers/parport/parport_sunbpp.c  | 24 +++++++++---------
 drivers/parport/procfs.c          |  2 +-
 drivers/parport/share.c           |  6 ++---
 drivers/scsi/imm.c                |  8 +++---
 drivers/scsi/ppa.c                | 10 ++++----
 include/linux/parport.h           |  4 +--
 include/linux/parport_pc.h        | 18 ++++++-------
 sound/drivers/mts64.c             |  6 ++---
 sound/drivers/portman2x4.c        |  6 ++---
 17 files changed, 82 insertions(+), 84 deletions(-)

diff --git a/drivers/auxdisplay/ks0108.c b/drivers/auxdisplay/ks0108.c
index 51587f0fdaae..ee046955ac2d 100644
--- a/drivers/auxdisplay/ks0108.c
+++ b/drivers/auxdisplay/ks0108.c
@@ -112,7 +112,7 @@ static void ks0108_parport_attach(struct parport *port)
 {
 	struct pardev_cb ks0108_cb;
 
-	if (port->base != ks0108_port)
+	if (port->iobase != ks0108_port)
 		return;
 
 	memset(&ks0108_cb, 0, sizeof(ks0108_cb));
@@ -140,7 +140,7 @@ static void ks0108_parport_attach(struct parport *port)
 
 static void ks0108_parport_detach(struct parport *port)
 {
-	if (port->base != ks0108_port)
+	if (port->iobase != ks0108_port)
 		return;
 
 	if (!ks0108_pardevice) {
diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index 1b7fd6d49a96..0b070ee7016a 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -306,7 +306,7 @@ static int eppconfig(struct baycom_state *bc)
 		bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
 		(bc->cfg.fclk + 8 * bc->cfg.bps) / (16 * bc->cfg.bps),
 		bc->cfg.loopback ? ",loopback" : "");
-	sprintf(portarg, "%ld", bc->pdev->port->base);
+	sprintf(portarg, "%ld", bc->pdev->port->iobase);
 	printk(KERN_DEBUG "%s: %s -s -p %s -m %s\n", bc_drvname, eppconfig_path, portarg, modearg);
 
 	return call_usermodehelper(eppconfig_path, argv, envp, UMH_WAIT_PROC);
@@ -828,14 +828,14 @@ static int epp_open(struct net_device *dev)
         }
 #if 0
         if (pp->irq < 0) {
-		pr_err("%s: parport at 0x%lx has no irq\n", bc_drvname, pp->base);
+		pr_err("%s: parport at 0x%lx has no irq\n", bc_drvname, pp->iobase);
 		parport_put_port(pp);
                 return -ENXIO;
         }
 #endif
 	if ((~pp->modes) & (PARPORT_MODE_TRISTATE | PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT)) {
 		pr_err("%s: parport at 0x%lx cannot be used\n",
-		       bc_drvname, pp->base);
+		       bc_drvname, pp->iobase);
 		parport_put_port(pp);
                 return -EIO;
 	}
@@ -857,11 +857,11 @@ static int epp_open(struct net_device *dev)
 	bc->pdev = parport_register_dev_model(pp, dev->name, &par_cb, i);
 	parport_put_port(pp);
         if (!bc->pdev) {
-		pr_err("%s: cannot register parport at 0x%lx\n", bc_drvname, pp->base);
+		pr_err("%s: cannot register parport at 0x%lx\n", bc_drvname, pp->iobase);
                 return -ENXIO;
         }
         if (parport_claim(bc->pdev)) {
-		pr_err("%s: parport at 0x%lx busy\n", bc_drvname, pp->base);
+		pr_err("%s: parport at 0x%lx busy\n", bc_drvname, pp->iobase);
                 parport_unregister_device(bc->pdev);
                 return -EBUSY;
         }
diff --git a/drivers/net/hamradio/baycom_par.c b/drivers/net/hamradio/baycom_par.c
index 4b57874c2463..4fc324a28c86 100644
--- a/drivers/net/hamradio/baycom_par.c
+++ b/drivers/net/hamradio/baycom_par.c
@@ -307,12 +307,12 @@ static int par96_open(struct net_device *dev)
 		return -ENXIO;
 	}
 	if (pp->irq < 0) {
-		pr_err("baycom_par: parport at 0x%lx has no irq\n", pp->base);
+		pr_err("baycom_par: parport at 0x%lx has no irq\n", pp->iobase);
 		parport_put_port(pp);
 		return -ENXIO;
 	}
 	if ((~pp->modes) & (PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT)) {
-		pr_err("baycom_par: parport at 0x%lx cannot be used\n", pp->base);
+		pr_err("baycom_par: parport at 0x%lx cannot be used\n", pp->iobase);
 		parport_put_port(pp);
 		return -ENXIO;
 	}
@@ -339,7 +339,7 @@ static int par96_open(struct net_device *dev)
 		return -ENXIO;
 	}
 	if (parport_claim(bc->pdev)) {
-		pr_err("baycom_par: parport at 0x%lx busy\n", pp->base);
+		pr_err("baycom_par: parport at 0x%lx busy\n", pp->iobase);
 		parport_unregister_device(bc->pdev);
 		return -EBUSY;
 	}
diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index e39bfaefe8c5..80ac7ca816b9 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -1286,7 +1286,7 @@ static void plip_attach (struct parport *port)
 		strcpy(dev->name, name);
 
 		dev->irq = port->irq;
-		dev->base_addr = port->base;
+		dev->base_addr = port->iobase;
 		if (port->irq == -1) {
 			printk(KERN_INFO "plip: %s has no IRQ. Using IRQ-less mode,"
 		                 "which is fairly inefficient!\n", port->name);
diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index 2231dbfd870d..83502170a6ba 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -68,7 +68,7 @@ static void add_dev(int devnum, struct parport *port, int daisy)
 /* Clone a parport (actually, make an alias). */
 static struct parport *clone_parport(struct parport *real, int muxport)
 {
-	struct parport *extra = parport_register_port(real->base,
+	struct parport *extra = parport_register_port(real->iobase,
 						       real->irq,
 						       real->dma,
 						       real->ops);
diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index c7e18382dc01..9490c431bd6c 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -249,8 +249,8 @@ static struct parport *parport_gsc_probe_port(unsigned long base,
 	}
 	priv->ctr = 0xc;
 	priv->ctr_writable = 0xff;
-	p->base = base;
-	p->base_hi = base_hi;
+	p->iobase = base;
+	p->iobase_hi = base_hi;
 	p->irq = irq;
 	p->modes = PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT;
 	p->ops = ops;
@@ -272,12 +272,12 @@ static struct parport *parport_gsc_probe_port(unsigned long base,
 	}
 
 	p->dev = &padev->dev;
-	p->base_hi = base_hi;
+	p->iobase_hi = base_hi;
 	p->modes = tmp.modes;
 	p->size = (p->modes & PARPORT_MODE_EPP)?8:3;
 	p->private_data = priv;
 
-	pr_info("%s: PC-style at 0x%lx", p->name, p->base);
+	pr_info("%s: PC-style at 0x%lx", p->name, p->iobase);
 	p->irq = irq;
 	if (p->irq == PARPORT_IRQ_AUTO) {
 		p->irq = PARPORT_IRQ_NONE;
diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 0919ed99ba94..44150fe2d0ed 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -301,7 +301,7 @@ struct parport_ip32_private {
 #define __pr_probe(...)							\
 	do { if (verbose_probing) printk(__VA_ARGS__); } while (0)
 #define pr_probe(p, fmt, ...)						\
-	__pr_probe(KERN_INFO PPIP32 "0x%lx: " fmt, (p)->base , ##__VA_ARGS__)
+	__pr_probe(KERN_INFO PPIP32 "0x%lx: " fmt, (p)->iobase, ##__VA_ARGS__)
 
 /*
  * parport_ip32_dump_state - print register status of parport
@@ -2038,8 +2038,8 @@ static __init struct parport *parport_ip32_probe_port(void)
 		err = -ENOMEM;
 		goto fail;
 	}
-	p->base = MACE_BASE + offsetof(struct sgi_mace, isa.parallel);
-	p->base_hi = MACE_BASE + offsetof(struct sgi_mace, isa.ecp1284);
+	p->iobase = MACE_BASE + offsetof(struct sgi_mace, isa.parallel);
+	p->iobase_hi = MACE_BASE + offsetof(struct sgi_mace, isa.ecp1284);
 	p->private_data = priv;
 
 	*ops = parport_ip32_ops;
@@ -2131,7 +2131,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	parport_ip32_dump_state(p, "end init", 0);
 
 	/* Print out what we found */
-	pr_info("%s: SGI IP32 at 0x%lx (0x%lx)", p->name, p->base, p->base_hi);
+	pr_info("%s: SGI IP32 at 0x%lx (0x%lx)", p->name, p->iobase, p->iobase_hi);
 	if (p->irq != PARPORT_IRQ_NONE)
 		pr_cont(", irq %d", p->irq);
 	pr_cont(" [");
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 609c10d4bc31..160d87449913 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -1380,7 +1380,7 @@ static struct superio_struct *find_superio(struct parport *p)
 {
 	int i;
 	for (i = 0; i < NR_SUPERIOS; i++)
-		if (superios[i].io == p->base)
+		if (superios[i].io == p->iobase)
 			return &superios[i];
 	return NULL;
 }
@@ -1448,7 +1448,7 @@ static int parport_SPP_supported(struct parport *pb)
 		/* That didn't work, but the user thinks there's a
 		 * port here. */
 		pr_info("parport 0x%lx (WARNING): CTR: wrote 0x%02x, read 0x%02x\n",
-			pb->base, w, r);
+			pb->iobase, w, r);
 
 	/* Try the data register.  The data lines aren't tri-stated at
 	 * this stage, so we expect back what we wrote. */
@@ -1467,9 +1467,9 @@ static int parport_SPP_supported(struct parport *pb)
 		/* Didn't work, but the user is convinced this is the
 		 * place. */
 		pr_info("parport 0x%lx (WARNING): DATA: wrote 0x%02x, read 0x%02x\n",
-			pb->base, w, r);
+			pb->iobase, w, r);
 		pr_info("parport 0x%lx: You gave this address, but there is probably no parallel port there!\n",
-			pb->base);
+			pb->iobase);
 	}
 
 	/* It's possible that we can't read the control register or
@@ -1609,7 +1609,7 @@ static int parport_ECP_supported(struct parport *pb)
 
 	priv->fifo_depth = i;
 	if (verbose_probing)
-		pr_debug("0x%lx: FIFO is %d bytes\n", pb->base, i);
+		pr_debug("0x%lx: FIFO is %d bytes\n", pb->iobase, i);
 
 	/* Find out writeIntrThreshold */
 	frob_econtrol(pb, 1<<2, 1<<2);
@@ -1624,7 +1624,7 @@ static int parport_ECP_supported(struct parport *pb)
 	if (i <= priv->fifo_depth) {
 		if (verbose_probing)
 			pr_debug("0x%lx: writeIntrThreshold is %d\n",
-			       pb->base, i);
+			       pb->iobase, i);
 	} else
 		/* Number of bytes we know we can write if we get an
 		   interrupt. */
@@ -1647,7 +1647,7 @@ static int parport_ECP_supported(struct parport *pb)
 	if (i <= priv->fifo_depth) {
 		if (verbose_probing)
 			pr_info("0x%lx: readIntrThreshold is %d\n",
-				pb->base, i);
+				pb->iobase, i);
 	} else
 		/* Number of bytes we can read if we get an interrupt. */
 		i = 0;
@@ -1661,14 +1661,14 @@ static int parport_ECP_supported(struct parport *pb)
 	switch (pword) {
 	case 0:
 		pword = 2;
-		pr_warn("0x%lx: Unsupported pword size!\n", pb->base);
+		pr_warn("0x%lx: Unsupported pword size!\n", pb->iobase);
 		break;
 	case 2:
 		pword = 4;
-		pr_warn("0x%lx: Unsupported pword size!\n", pb->base);
+		pr_warn("0x%lx: Unsupported pword size!\n", pb->iobase);
 		break;
 	default:
-		pr_warn("0x%lx: Unknown implementation ID\n", pb->base);
+		pr_warn("0x%lx: Unknown implementation ID\n", pb->iobase);
 		fallthrough;	/* Assume 1 */
 	case 1:
 		pword = 1;
@@ -1677,15 +1677,15 @@ static int parport_ECP_supported(struct parport *pb)
 
 	if (verbose_probing) {
 		pr_debug("0x%lx: PWord is %d bits\n",
-		       pb->base, 8 * pword);
+		       pb->iobase, 8 * pword);
 
 		pr_debug("0x%lx: Interrupts are ISA-%s\n",
-		       pb->base, config & 0x80 ? "Level" : "Pulses");
+		       pb->iobase, config & 0x80 ? "Level" : "Pulses");
 
 		configb = inb(CONFIGB(pb));
 		pr_debug("0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
-		       pb->base, config, configb);
-		pr_debug("0x%lx: ECP settings irq=", pb->base);
+		       pb->iobase, config, configb);
+		pr_debug("0x%lx: ECP settings irq=", pb->iobase);
 		if ((configb >> 3) & 0x07)
 			pr_cont("%d", intrline[(configb >> 3) & 0x07]);
 		else
@@ -2085,7 +2085,7 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
 	priv->port = p;
 
 	p->dev = dev;
-	p->base_hi = base_hi;
+	p->iobase_hi = base_hi;
 	p->modes = PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT;
 	p->private_data = priv;
 
@@ -2111,9 +2111,9 @@ static struct parport *__parport_pc_probe_port(unsigned long int base,
 
 	p->size = (p->modes & PARPORT_MODE_EPP) ? 8 : 3;
 
-	pr_info("%s: PC-style at 0x%lx", p->name, p->base);
-	if (p->base_hi && priv->ecr)
-		pr_cont(" (0x%lx)", p->base_hi);
+	pr_info("%s: PC-style at 0x%lx", p->name, p->iobase);
+	if (p->iobase_hi && priv->ecr)
+		pr_cont(" (0x%lx)", p->iobase_hi);
 	if (p->irq == PARPORT_IRQ_AUTO) {
 		p->irq = PARPORT_IRQ_NONE;
 		parport_irq_probe(p);
@@ -2299,11 +2299,11 @@ void parport_pc_unregister_port(struct parport *p)
 #endif
 	if (p->irq != PARPORT_IRQ_NONE)
 		free_irq(p->irq, p);
-	release_region(p->base, 3);
+	release_region(p->iobase, 3);
 	if (p->size > 3)
-		release_region(p->base + 3, p->size - 3);
+		release_region(p->iobase + 3, p->size - 3);
 	if (p->modes & PARPORT_MODE_ECP)
-		release_region(p->base_hi, 3);
+		release_region(p->iobase_hi, 3);
 #if defined(CONFIG_PARPORT_PC_FIFO) && defined(HAS_DMA)
 	if (priv->dma_buf)
 		dma_free_coherent(p->physport->dev, PAGE_SIZE,
diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 949236a7a27c..c7a56a0b04a0 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -50,7 +50,7 @@
 
 static void parport_sunbpp_disable_irq(struct parport *p)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 	u32 tmp;
 
 	tmp = sbus_readl(&regs->p_csr);
@@ -60,7 +60,7 @@ static void parport_sunbpp_disable_irq(struct parport *p)
 
 static void parport_sunbpp_enable_irq(struct parport *p)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 	u32 tmp;
 
 	tmp = sbus_readl(&regs->p_csr);
@@ -70,7 +70,7 @@ static void parport_sunbpp_enable_irq(struct parport *p)
 
 static void parport_sunbpp_write_data(struct parport *p, unsigned char d)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 
 	sbus_writeb(d, &regs->p_dr);
 	dprintk((KERN_DEBUG "wrote 0x%x\n", d));
@@ -78,14 +78,14 @@ static void parport_sunbpp_write_data(struct parport *p, unsigned char d)
 
 static unsigned char parport_sunbpp_read_data(struct parport *p)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 
 	return sbus_readb(&regs->p_dr);
 }
 
 static unsigned char status_sunbpp_to_pc(struct parport *p)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 	unsigned char bits = 0;
 	unsigned char value_tcr = sbus_readb(&regs->p_tcr);
 	unsigned char value_ir = sbus_readb(&regs->p_ir);
@@ -108,7 +108,7 @@ static unsigned char status_sunbpp_to_pc(struct parport *p)
 
 static unsigned char control_sunbpp_to_pc(struct parport *p)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 	unsigned char bits = 0;
 	unsigned char value_tcr = sbus_readb(&regs->p_tcr);
 	unsigned char value_or = sbus_readb(&regs->p_or);
@@ -136,7 +136,7 @@ static unsigned char parport_sunbpp_frob_control(struct parport *p,
 						 unsigned char mask,
 						 unsigned char val)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 	unsigned char value_tcr = sbus_readb(&regs->p_tcr);
 	unsigned char value_or = sbus_readb(&regs->p_or);
 
@@ -195,7 +195,7 @@ static unsigned char parport_sunbpp_read_status(struct parport *p)
 
 static void parport_sunbpp_data_forward (struct parport *p)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 	unsigned char value_tcr = sbus_readb(&regs->p_tcr);
 
 	dprintk((KERN_DEBUG "forward\n"));
@@ -205,7 +205,7 @@ static void parport_sunbpp_data_forward (struct parport *p)
 
 static void parport_sunbpp_data_reverse (struct parport *p)
 {
-	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->base;
+	struct bpp_regs __iomem *regs = (struct bpp_regs __iomem *)p->iobase;
 	u8 val = sbus_readb(&regs->p_tcr);
 
 	dprintk((KERN_DEBUG "reverse\n"));
@@ -308,13 +308,13 @@ static int bpp_probe(struct platform_device *op)
 
 	parport_sunbpp_enable_irq(p);
 
-	regs = (struct bpp_regs __iomem *)p->base;
+	regs = (struct bpp_regs __iomem *)p->iobase;
 
 	value_tcr = sbus_readb(&regs->p_tcr);
 	value_tcr &= ~P_TCR_DIR;
 	sbus_writeb(value_tcr, &regs->p_tcr);
 
-	pr_info("%s: sunbpp at 0x%lx\n", p->name, p->base);
+	pr_info("%s: sunbpp at 0x%lx\n", p->name, p->iobase);
 
 	dev_set_drvdata(&op->dev, p);
 
@@ -346,7 +346,7 @@ static void bpp_remove(struct platform_device *op)
 		free_irq(p->irq, p);
 	}
 
-	of_iounmap(&op->resource[0], (void __iomem *) p->base, p->size);
+	of_iounmap(&op->resource[0], (void __iomem *) p->iobase, p->size);
 	parport_put_port(p);
 	kfree(ops);
 
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 3f809fff317b..5505aba51c3c 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -128,7 +128,7 @@ static int do_hardware_base_addr(const struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += scnprintf(buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
+	len += scnprintf(buffer, sizeof(buffer), "%lu\t%lu\n", port->iobase, port->iobase_hi);
 
 	if (len > *lenp)
 		len = *lenp;
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 427abdf3c4c4..0d44d7a9c88f 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -7,8 +7,6 @@
  *          Philip Blundell <philb@gnu.org>
  *	    Andrea Arcangeli
  *
- * based on work by Grant Guenther <grant@torque.net>
- *          and Philip Blundell
  *
  * Any part of this program may be used in documents licensed under
  * the GNU Free Documentation License, Version 1.1 or any later version
@@ -435,7 +433,7 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 		return NULL;
 
 	/* Init our structure */
-	tmp->base = base;
+	tmp->iobase = base;
 	tmp->irq = irq;
 	tmp->dma = dma;
 	tmp->muxport = tmp->daisy = tmp->muxsel = -1;
@@ -931,7 +929,7 @@ struct parport *parport_find_base(unsigned long base)
 
 	spin_lock(&parportlist_lock);
 	list_for_each_entry(port, &portlist, list) {
-		if (port->base == base) {
+		if (port->iobase == base) {
 			result = parport_get_port(port);
 			break;
 		}
diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index 1d4c7310f1a6..e1f4c4916e18 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -69,7 +69,7 @@ static DEFINE_SPINLOCK(arbitration_lock);
 
 static void got_it(imm_struct *dev)
 {
-	dev->base = dev->dev->port->base;
+	dev->base = dev->dev->port->iobase;
 	if (dev->cur_cmd)
 		imm_scsi_pointer(dev->cur_cmd)->phase = 1;
 	else
@@ -1199,8 +1199,8 @@ static int __imm_attach(struct parport *pb)
 	}
 	dev->waiting = NULL;
 	finish_wait(&waiting, &wait);
-	dev->base = dev->dev->port->base;
-	dev->base_hi = dev->dev->port->base_hi;
+	dev->base = dev->dev->port->iobase;
+	dev->base_hi = dev->dev->port->iobase_hi;
 	w_ctr(dev->base, 0x0c);
 
 	/* Done configuration */
@@ -1225,7 +1225,7 @@ static int __imm_attach(struct parport *pb)
 	if (!host)
 		goto out1;
 	host->no_highmem = true;
-	host->io_port = pb->base;
+	host->io_port = pb->iobase;
 	host->n_io_port = ports;
 	host->dma_channel = -1;
 	host->unique_id = pb->number;
diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index a06329b47851..6ce4fe9fc5d0 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -64,7 +64,7 @@ static DEFINE_SPINLOCK(arbitration_lock);
 
 static void got_it(ppa_struct *dev)
 {
-	dev->base = dev->dev->port->base;
+	dev->base = dev->dev->port->iobase;
 	if (dev->cur_cmd)
 		ppa_scsi_pointer(dev->cur_cmd)->phase = 1;
 	else
@@ -232,7 +232,7 @@ static inline void epp_reset(unsigned short ppb)
  */
 static inline void ecp_sync(ppa_struct *dev)
 {
-	int i, ppb_hi = dev->dev->port->base_hi;
+	int i, ppb_hi = dev->dev->port->iobase_hi;
 
 	if (ppb_hi == 0)
 		return;
@@ -472,7 +472,7 @@ static int ppa_init(ppa_struct *dev)
 
 	if (autodetect) {
 		int modes = dev->dev->port->modes;
-		int ppb_hi = dev->dev->port->base_hi;
+		int ppb_hi = dev->dev->port->iobase_hi;
 
 		/* Mode detection works up the chain of speed
 		 * This avoids a nasty if-then-else-if-... tree
@@ -1081,7 +1081,7 @@ static int __ppa_attach(struct parport *pb)
 	}
 	dev->waiting = NULL;
 	finish_wait(&waiting, &wait);
-	dev->base = dev->dev->port->base;
+	dev->base = dev->dev->port->iobase;
 	w_ctr(dev->base, 0x0c);
 
 	/* Done configuration */
@@ -1105,7 +1105,7 @@ static int __ppa_attach(struct parport *pb)
 	if (!host)
 		goto out1;
 	host->no_highmem = true;
-	host->io_port = pb->base;
+	host->io_port = pb->iobase;
 	host->n_io_port = ports;
 	host->dma_channel = -1;
 	host->unique_id = pb->number;
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 464c2ad28039..4e39c400d002 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -182,8 +182,8 @@ struct ieee1284_info {
 
 /* A parallel port */
 struct parport {
-	unsigned long base;	/* base address */
-	unsigned long base_hi;  /* base address (hi - ECR) */
+	unsigned long iobase;	/* base address for ioport */
+	unsigned long iobase_hi;  /* base address (hi - ECR) */
 	unsigned int size;	/* IO extent */
 	const char *name;
 	unsigned int modes;
diff --git a/include/linux/parport_pc.h b/include/linux/parport_pc.h
index f1ec5c10c3b3..4d92c831d06a 100644
--- a/include/linux/parport_pc.h
+++ b/include/linux/parport_pc.h
@@ -6,15 +6,15 @@
 
 /* --- register definitions ------------------------------- */
 
-#define ECONTROL(p) ((p)->base_hi + 0x2)
-#define CONFIGB(p)  ((p)->base_hi + 0x1)
-#define CONFIGA(p)  ((p)->base_hi + 0x0)
-#define FIFO(p)     ((p)->base_hi + 0x0)
-#define EPPDATA(p)  ((p)->base    + 0x4)
-#define EPPADDR(p)  ((p)->base    + 0x3)
-#define CONTROL(p)  ((p)->base    + 0x2)
-#define STATUS(p)   ((p)->base    + 0x1)
-#define DATA(p)     ((p)->base    + 0x0)
+#define ECONTROL(p) ((p)->iobase_hi + 0x2)
+#define CONFIGB(p)  ((p)->iobase_hi + 0x1)
+#define CONFIGA(p)  ((p)->iobase_hi + 0x0)
+#define FIFO(p)     ((p)->iobase_hi + 0x0)
+#define EPPDATA(p)  ((p)->iobase    + 0x4)
+#define EPPADDR(p)  ((p)->iobase    + 0x3)
+#define CONTROL(p)  ((p)->iobase    + 0x2)
+#define STATUS(p)   ((p)->iobase    + 0x1)
+#define DATA(p)     ((p)->iobase    + 0x0)
 
 struct parport_pc_private {
 	/* Contents of CTR. */
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 6fc255a6754d..fc6033b7118b 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -932,7 +932,7 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	strcpy(card->driver, DRIVER_NAME);
 	strcpy(card->shortname, "ESI " CARD_NAME);
 	sprintf(card->longname,  "%s at 0x%lx, irq %i", 
-		card->shortname, p->base, p->irq);
+		card->shortname, p->iobase, p->irq);
 
 	mts64_cb.private = card;			 /* private */
 	pardev = parport_register_dev_model(p,		 /* port */
@@ -947,7 +947,7 @@ static int snd_mts64_probe(struct platform_device *pdev)
 
 	/* claim parport */
 	if (parport_claim(pardev)) {
-		dev_dbg(card->dev, "Cannot claim parport 0x%lx\n", pardev->port->base);
+		dev_dbg(card->dev, "Cannot claim parport 0x%lx\n", pardev->port->iobase);
 		err = -EIO;
 		goto free_pardev;
 	}
@@ -986,7 +986,7 @@ static int snd_mts64_probe(struct platform_device *pdev)
 		goto __err;
 	}
 
-	dev_info(card->dev, "ESI Miditerminal 4140 on 0x%lx\n", p->base);
+	dev_info(card->dev, "ESI Miditerminal 4140 on 0x%lx\n", p->iobase);
 	return 0;
 
 release_pardev:
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 54d818d2f53d..1e833feb7907 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -717,7 +717,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 	strcpy(card->driver, DRIVER_NAME);
 	strcpy(card->shortname, CARD_NAME);
 	sprintf(card->longname,  "%s at 0x%lx, irq %i", 
-		card->shortname, p->base, p->irq);
+		card->shortname, p->iobase, p->irq);
 
 	portman_cb.private = card;			   /* private */
 	pardev = parport_register_dev_model(p,		   /* port */
@@ -732,7 +732,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 
 	/* claim parport */
 	if (parport_claim(pardev)) {
-		dev_dbg(card->dev, "Cannot claim parport 0x%lx\n", pardev->port->base);
+		dev_dbg(card->dev, "Cannot claim parport 0x%lx\n", pardev->port->iobase);
 		err = -EIO;
 		goto free_pardev;
 	}
@@ -771,7 +771,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 		goto __err;
 	}
 
-	dev_info(card->dev, "Portman 2x4 on 0x%lx\n", p->base);
+	dev_info(card->dev, "Portman 2x4 on 0x%lx\n", p->iobase);
 	return 0;
 
 release_pardev:
-- 
2.25.1


