Return-Path: <linux-kernel+bounces-405045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A05C9C4C55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2AF281046
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9D8205E37;
	Tue, 12 Nov 2024 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oy/O1LNI"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00496207A05
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377664; cv=none; b=PH+1iQXj8PNAaxAmA86dhzR72bQTJJL6+TBxH8aoRBuA6SAPtphb5dFHLUiin1uyoRhOLUHOm0g2AtHngRxW5IqLJFDgtzYMQOBI0sn8uSB+9uTxq1W+NdJLENpQVmvX/oCMkxWgAJZwSzbnmMiIbCApm5y/aMjofA8w0zs6ZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377664; c=relaxed/simple;
	bh=a8CS+4iKVPZwY4yDJAqIRsUFGHkrtaKod/CTxjvQQ+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NW55UgMNFF/DxjONJXpf+7dqzE1E5KtUObgCIDUe9W4WA0ai8QzJ9ApBQotUW7sacM52IHffRNWui3UuRrlSogkMWtPV22kp0YalWa1wUJ5k3yANnL7gn5dVJ2QYRV5rZWo1pHsOgKCoJxnkrut19XDrYavU/jTAE05wXu+POew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oy/O1LNI; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KEMYe
	TraOJWQraShFMIDQvggJgEr8cplFBUz4DywtUs=; b=oy/O1LNIaqU7tTdOsRuPO
	Np1e7T1QC+5HwHsa04KvsxoUEZPSJUyPSvADhfR8cDElhz0sj28aVJuAA8fvDZZh
	+1kseRiMqSR9qnT58qsdc4BHOz54GAVseRKGR8IHj2DDSHKJ6eVZEkzh9vnKdzZw
	F+qzoQUrrNd5X4MBs7Tc3Q=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_4hwuTJnfZjdGw--.189S3;
	Tue, 12 Nov 2024 10:12:04 +0800 (CST)
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
Subject: [PATCH v2 1/4] parport: use standard kernel printing functions
Date: Tue, 12 Nov 2024 10:11:50 +0800
Message-Id: <20241112021153.18146-2-412574090@163.com>
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
X-CM-TRANSID:_____wD3_4hwuTJnfZjdGw--.189S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF1fGw4UtFWUZFyfWrWUCFg_yoW7XrW8pa
	17uFZ3Z39rta17Ar18Aan8uFW5t3W2ka48CFy8K34FvFnrJrWDAw4jkFyvyF15GFy8Xay5
	tFs8JFy3Ar47Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVfOwUUUUU=
X-CM-SenderInfo: yursklauqziqqrwthudrp/1tbizQuVAGcyuTAGXQAAsU

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


