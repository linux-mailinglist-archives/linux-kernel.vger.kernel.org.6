Return-Path: <linux-kernel+bounces-381240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623559AFC60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7351F23ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B81CC159;
	Fri, 25 Oct 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R9BuJxf9"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0818A94C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844511; cv=none; b=Hwz9dmnroiyQhaeDwl5tbXeq7/SNtVZ5RJxapwkjHjpoi4OvWDdpVHu+9p9ITl0W4Z8Qb3LksbUGHL2L+hxg9U4dAlksRjf2Fo1DrNilCwusnYNTnAutwLzEHxCWH0gKfLCD/W7opX9TU7613BADa5AtR/rABvVHgU+xVfDjfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844511; c=relaxed/simple;
	bh=a8CS+4iKVPZwY4yDJAqIRsUFGHkrtaKod/CTxjvQQ+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l96AIYc/kdbVXSSO7Zjz/IcogsLiqOqs9kv+alUQ6Kh7Rt89oEHOV/cILQMBsG3TBg++DUfwWwtizJfygGh3zav6bbQfMI3usAfHnXvp5/1Lf7jRlvDJ9KA2xvsnNEDHgnObCPBahou/hQHow5m+99R/AjGfPCLBPUiFop/KmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R9BuJxf9; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KEMYe
	TraOJWQraShFMIDQvggJgEr8cplFBUz4DywtUs=; b=R9BuJxf9PzF7PyJif9j3A
	JWhrnADrEuZLu/JA01UaQY9sa6mXCAaSUBp1hTVTs+YrIGgGvC9LQkzbp5mUumlF
	tvt3KWq7y6vjJMdbGqS9Ir4S8zQTSOCe/s8+F5Ix31u0HJ/qtk2K+QBi+2Z80Iie
	59JlBivGh31174vPb5WJLs=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHbwYXVRtniEkiDQ--.6094S2;
	Fri, 25 Oct 2024 16:21:44 +0800 (CST)
From: 412574090@163.com
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH 1/4] parport: use standard kernel printing functions
Date: Fri, 25 Oct 2024 16:21:25 +0800
Message-Id: <20241025082128.60034-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHbwYXVRtniEkiDQ--.6094S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF1fGw4UtFWUZFyfWrWUCFg_yoW7XrW8pa
	17uFZ3Z39rta17Ar18Aan8uFW5t3W2ka48CFy8K34FvFnrJrWDAw4jkFyvyF15GFy8Xay5
	tFs8JFy3Ar47Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBXx2DAGcbR8HyPAAAs1

From: weiyufeng <weiyufeng@kylinos.cn>

change printk to standard kernel printing functions.

Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
---
 drivers/net/hamradio/baycom_epp.c |  8 ++++----
 drivers/net/hamradio/baycom_par.c |  6 +++---
 drivers/parport/parport_pc.c      | 12 ++++++------
 drivers/parport/procfs.c          |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/hamradio/baycom_epp.c b/drivers/net/hamradio/baycom_epp.c
index 9e366f275406..1b7fd6d49a96 100644
--- a/drivers/net/hamradio/baycom_epp.c
+++ b/drivers/net/hamradio/baycom_epp.c
@@ -828,13 +828,13 @@ static int epp_open(struct net_device *dev)
         }
 #if 0
         if (pp->irq < 0) {
-                printk(KERN_ERR "%s: parport at 0x%lx has no irq\n", bc_drvname, pp->base);
+		pr_err("%s: parport at 0x%lx has no irq\n", bc_drvname, pp->base);
 		parport_put_port(pp);
                 return -ENXIO;
         }
 #endif
 	if ((~pp->modes) & (PARPORT_MODE_TRISTATE | PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT)) {
-                printk(KERN_ERR "%s: parport at 0x%lx cannot be used\n",
+		pr_err("%s: parport at 0x%lx cannot be used\n",
 		       bc_drvname, pp->base);
 		parport_put_port(pp);
                 return -EIO;
@@ -857,11 +857,11 @@ static int epp_open(struct net_device *dev)
 	bc->pdev = parport_register_dev_model(pp, dev->name, &par_cb, i);
 	parport_put_port(pp);
         if (!bc->pdev) {
-                printk(KERN_ERR "%s: cannot register parport at 0x%lx\n", bc_drvname, pp->base);
+		pr_err("%s: cannot register parport at 0x%lx\n", bc_drvname, pp->base);
                 return -ENXIO;
         }
         if (parport_claim(bc->pdev)) {
-                printk(KERN_ERR "%s: parport at 0x%lx busy\n", bc_drvname, pp->base);
+		pr_err("%s: parport at 0x%lx busy\n", bc_drvname, pp->base);
                 parport_unregister_device(bc->pdev);
                 return -EBUSY;
         }
diff --git a/drivers/net/hamradio/baycom_par.c b/drivers/net/hamradio/baycom_par.c
index 00ebc25d0b22..4b57874c2463 100644
--- a/drivers/net/hamradio/baycom_par.c
+++ b/drivers/net/hamradio/baycom_par.c
@@ -307,12 +307,12 @@ static int par96_open(struct net_device *dev)
 		return -ENXIO;
 	}
 	if (pp->irq < 0) {
-		printk(KERN_ERR "baycom_par: parport at 0x%lx has no irq\n", pp->base);
+		pr_err("baycom_par: parport at 0x%lx has no irq\n", pp->base);
 		parport_put_port(pp);
 		return -ENXIO;
 	}
 	if ((~pp->modes) & (PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT)) {
-		printk(KERN_ERR "baycom_par: parport at 0x%lx cannot be used\n", pp->base);
+		pr_err("baycom_par: parport at 0x%lx cannot be used\n", pp->base);
 		parport_put_port(pp);
 		return -ENXIO;
 	}
@@ -339,7 +339,7 @@ static int par96_open(struct net_device *dev)
 		return -ENXIO;
 	}
 	if (parport_claim(bc->pdev)) {
-		printk(KERN_ERR "baycom_par: parport at 0x%lx busy\n", pp->base);
+		pr_err("baycom_par: parport at 0x%lx busy\n", pp->base);
 		parport_unregister_device(bc->pdev);
 		return -EBUSY;
 	}
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index f33b5d1ddfc1..609c10d4bc31 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -1609,7 +1609,7 @@ static int parport_ECP_supported(struct parport *pb)
 
 	priv->fifo_depth = i;
 	if (verbose_probing)
-		printk(KERN_DEBUG "0x%lx: FIFO is %d bytes\n", pb->base, i);
+		pr_debug("0x%lx: FIFO is %d bytes\n", pb->base, i);
 
 	/* Find out writeIntrThreshold */
 	frob_econtrol(pb, 1<<2, 1<<2);
@@ -1623,7 +1623,7 @@ static int parport_ECP_supported(struct parport *pb)
 
 	if (i <= priv->fifo_depth) {
 		if (verbose_probing)
-			printk(KERN_DEBUG "0x%lx: writeIntrThreshold is %d\n",
+			pr_debug("0x%lx: writeIntrThreshold is %d\n",
 			       pb->base, i);
 	} else
 		/* Number of bytes we know we can write if we get an
@@ -1676,16 +1676,16 @@ static int parport_ECP_supported(struct parport *pb)
 	priv->pword = pword;
 
 	if (verbose_probing) {
-		printk(KERN_DEBUG "0x%lx: PWord is %d bits\n",
+		pr_debug("0x%lx: PWord is %d bits\n",
 		       pb->base, 8 * pword);
 
-		printk(KERN_DEBUG "0x%lx: Interrupts are ISA-%s\n",
+		pr_debug("0x%lx: Interrupts are ISA-%s\n",
 		       pb->base, config & 0x80 ? "Level" : "Pulses");
 
 		configb = inb(CONFIGB(pb));
-		printk(KERN_DEBUG "0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
+		pr_debug("0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
 		       pb->base, config, configb);
-		printk(KERN_DEBUG "0x%lx: ECP settings irq=", pb->base);
+		pr_debug("0x%lx: ECP settings irq=", pb->base);
 		if ((configb >> 3) & 0x07)
 			pr_cont("%d", intrline[(configb >> 3) & 0x07]);
 		else
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 3880460e67f2..3f809fff317b 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -128,7 +128,7 @@ static int do_hardware_base_addr(const struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += scnprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
+	len += scnprintf(buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
 
 	if (len > *lenp)
 		len = *lenp;
-- 
2.25.1


