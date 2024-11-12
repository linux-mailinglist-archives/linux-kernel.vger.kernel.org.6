Return-Path: <linux-kernel+bounces-405046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 435FC9C4C56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08221F21660
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52820896D;
	Tue, 12 Nov 2024 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dJlh9xHr"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7B207A03
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377666; cv=none; b=uKleofr4LP8XQZ5bdzyqPxyZ93Z7SavhadItWTPuwsEo1IuqGI8b34dZfnOpMT3GeCIkRwAKzvQrujF5phnqSfmHekb/xLJtEIn972L9/NPhPWbOobGi8rWPRAigfEQq6nobcfeBbnZjclzh6JXEvt0m6ZcJ1TItkHMfAtcKzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377666; c=relaxed/simple;
	bh=c/ggBBy5qW4OHtVIVj5HjwltHtONKCZ0Tgxa5rv/5Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jinW+lwHxCJwO5YMHvMzep39HrjpZwKfm1XLdAAC5hLuhi0QRRN0zqA6upmN1ZHdZoh4XkGq2YY8eXrCxFBR0aPfku/eqkTno+c4ZcYB9H/JbflcrBVvRjIcs8WnL4U2VW8sin2hA3VttQtvbwpOGkl9/IQ2enJNaN74GGIKLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dJlh9xHr; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ybCwY
	niFqIxg2ErBCXc/L0acp6AgpExP+ha5GSVO8A0=; b=dJlh9xHr/D56qfttB4BjY
	dC0aTBklQCwrDG/uRXHdgWJJd/dmHjyeyimJBULCbkz3rqKCSRjtF7R+3gIITyA6
	2jgnNlXO0ORlChwrudXCVDPR1MXIYHQNo3YT/ZmqXuuuknWfODmhnXvuc0Ck+8/w
	+TEDcF4ZMZBEaGjy15Lqd0=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_4hwuTJnfZjdGw--.189S6;
	Tue, 12 Nov 2024 10:12:13 +0800 (CST)
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
Subject: [PATCH v2 4/4] parport: add iomem type for parport
Date: Tue, 12 Nov 2024 10:11:53 +0800
Message-Id: <20241112021153.18146-5-412574090@163.com>
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
X-CM-TRANSID:_____wD3_4hwuTJnfZjdGw--.189S6
X-Coremail-Antispam: 1Uf129KBjvAXoWDAFyxCFWfJF4rXr4UCFWxWFg_yoWrAw1xGo
	Z7trWfJ34rKws3JFy8Kr4DW3ykXw17W3WDCrWSyr4Yv3srAa1vqF1fAFWayw4ftrs8Kr1f
	X34kWw4YyF18tF1xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIpnQUUUUU
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBFROVAGcyrpPz6QAAsh

From: weiyufeng <weiyufeng@kylinos.cn>

Solve the problem of not being able to use LPC and PCIE parallel
ports simultaneously on the phytium platform.Optimize lpc and
pci parallel port program. add iomem type for parport.
In DSDT,LPT recommends the following description:
Device (LPT)
{
    Name (_HID, EisaId ("PNP0400") /* Standard LPT Parallel Port */)
    Name (_UID, Zero)  // _UID: Unique ID
    Name (_DDN, "LPT1")  // _DDN: DOS Device Name
    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {
      Memory32Fixed (ReadWrite,
          0x20000378,  // Address Base
          0x00000008,  // Address Length
          )
          IRQNoFlags ()
             {7}
    })
}

Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
---
 drivers/parport/parport_pc.c | 550 +++++++++++++++++++++--------------
 include/linux/parport.h      |  18 ++
 include/linux/parport_pc.h   | 101 +++++--
 3 files changed, 428 insertions(+), 241 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index b4e959a2d8a1..39925c1bb75b 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -112,7 +112,7 @@ static void frob_econtrol(struct parport *pb, unsigned char m,
 	unsigned char new;
 
 	if (m != 0xff)
-		ectr = inb(ECONTROL(pb));
+		ectr = parport_pc_readb(pb, ECONTROL(pb));
 
 	new = (ectr & ~m) ^ v;
 	if (ecr_writable)
@@ -121,7 +121,7 @@ static void frob_econtrol(struct parport *pb, unsigned char m,
 
 	pr_debug("frob_econtrol(%02x,%02x): %02x -> %02x\n", m, v, ectr, new);
 
-	outb(new, ECONTROL(pb));
+	parport_pc_writeb(pb, new, ECONTROL(pb));
 }
 
 static inline void frob_set_mode(struct parport *p, int mode)
@@ -150,7 +150,7 @@ static int change_mode(struct parport *p, int m)
 	}
 
 	/* Bits <7:5> contain the mode. */
-	oecr = inb(ECONTROL(p));
+	oecr = parport_pc_readb(p, ECONTROL(p));
 	mode = (oecr >> 5) & 0x7;
 	if (mode == m)
 		return 0;
@@ -165,7 +165,7 @@ static int change_mode(struct parport *p, int m)
 		case ECR_ECP: /* ECP Parallel Port mode */
 			/* Busy wait for 200us */
 			for (counter = 0; counter < 40; counter++) {
-				if (inb(ECONTROL(p)) & 0x01)
+				if (parport_pc_readb(p, ECONTROL(p)) & 0x01)
 					break;
 				if (signal_pending(current))
 					break;
@@ -173,7 +173,7 @@ static int change_mode(struct parport *p, int m)
 			}
 
 			/* Poll slowly. */
-			while (!(inb(ECONTROL(p)) & 0x01)) {
+			while (!(parport_pc_readb(p, ECONTROL(p)) & 0x01)) {
 				if (time_after_eq(jiffies, expire))
 					/* The FIFO is stuck. */
 					return -EBUSY;
@@ -215,8 +215,9 @@ static int clear_epp_timeout(struct parport *pb)
 	/* To clear timeout some chips require double read */
 	parport_pc_read_status(pb);
 	r = parport_pc_read_status(pb);
-	outb(r | 0x01, STATUS(pb)); /* Some reset by writing 1 */
-	outb(r & 0xfe, STATUS(pb)); /* Others by writing 0 */
+	parport_pc_writeb(pb, r | 0x01,
+				STATUS(pb)); /* Some reset by writing 1 */
+	parport_pc_writeb(pb, r & 0xfe, STATUS(pb)); /* Others by writing 0 */
 	r = parport_pc_read_status(pb);
 
 	return !(r & 0x01);
@@ -248,7 +249,7 @@ static void parport_pc_save_state(struct parport *p, struct parport_state *s)
 	const struct parport_pc_private *priv = p->physport->private_data;
 	s->u.pc.ctr = priv->ctr;
 	if (priv->ecr)
-		s->u.pc.ecr = inb(ECONTROL(p));
+		s->u.pc.ecr = parport_pc_readb(p, ECONTROL(p));
 }
 
 static void parport_pc_restore_state(struct parport *p,
@@ -256,7 +257,7 @@ static void parport_pc_restore_state(struct parport *p,
 {
 	struct parport_pc_private *priv = p->physport->private_data;
 	register unsigned char c = s->u.pc.ctr & priv->ctr_writable;
-	outb(c, CONTROL(p));
+	parport_pc_writeb(p, c, CONTROL(p));
 	priv->ctr = c;
 	if (priv->ecr)
 		ECR_WRITE(p, s->u.pc.ecr);
@@ -276,26 +277,29 @@ static size_t parport_pc_epp_read_data(struct parport *port, void *buf,
 		 *  nFault is 0 if there is at least 1 byte in the Warp's FIFO
 		 *  pError is 1 if there are 16 bytes in the Warp's FIFO
 		 */
-		status = inb(STATUS(port));
+		status = parport_pc_readb(port, STATUS(port));
 
 		while (!(status & 0x08) && got < length) {
 			if (left >= 16 && (status & 0x20) && !(status & 0x08)) {
 				/* can grab 16 bytes from warp fifo */
 				if (!((long)buf & 0x03))
-					insl(EPPDATA(port), buf, 4);
+					parport_pc_readsl(port, EPPDATA(port),
+							buf, 4);
 				else
-					insb(EPPDATA(port), buf, 16);
+					parport_pc_readsb(port, EPPDATA(port),
+							buf, 16);
 				buf += 16;
 				got += 16;
 				left -= 16;
 			} else {
 				/* grab single byte from the warp fifo */
-				*((char *)buf) = inb(EPPDATA(port));
+				*((char *)buf) = parport_pc_readb(port,
+						EPPDATA(port));
 				buf++;
 				got++;
 				left--;
 			}
-			status = inb(STATUS(port));
+			status = parport_pc_readb(port, STATUS(port));
 			if (status & 0x01) {
 				/* EPP timeout should never occur... */
 				printk(KERN_DEBUG "%s: EPP timeout occurred while talking to w91284pic (should not have done)\n",
@@ -310,22 +314,24 @@ static size_t parport_pc_epp_read_data(struct parport *port, void *buf,
 			   || flags & PARPORT_EPP_FAST_8)) {
 		if ((flags & PARPORT_EPP_FAST_32)
 		    && !(((long)buf | length) & 0x03))
-			insl(EPPDATA(port), buf, (length >> 2));
+			parport_pc_readsl(port, EPPDATA(port), buf,
+					(length >> 2));
 		else if ((flags & PARPORT_EPP_FAST_16)
 			 && !(((long)buf | length) & 0x01))
-			insw(EPPDATA(port), buf, length >> 1);
+			parport_pc_readsw(port, EPPDATA(port), buf,
+					length >> 1);
 		else
-			insb(EPPDATA(port), buf, length);
-		if (inb(STATUS(port)) & 0x01) {
+			parport_pc_readsb(port, EPPDATA(port), buf, length);
+		if (parport_pc_readb(port, STATUS(port)) & 0x01) {
 			clear_epp_timeout(port);
 			return -EIO;
 		}
 		return length;
 	}
 	for (; got < length; got++) {
-		*((char *)buf) = inb(EPPDATA(port));
+		*((char *)buf) = parport_pc_readb(port, EPPDATA(port));
 		buf++;
-		if (inb(STATUS(port)) & 0x01) {
+		if (parport_pc_readb(port, STATUS(port)) & 0x01) {
 			/* EPP timeout */
 			clear_epp_timeout(port);
 			break;
@@ -345,22 +351,24 @@ static size_t parport_pc_epp_write_data(struct parport *port, const void *buf,
 			   || flags & PARPORT_EPP_FAST_8)) {
 		if ((flags & PARPORT_EPP_FAST_32)
 		    && !(((long)buf | length) & 0x03))
-			outsl(EPPDATA(port), buf, (length >> 2));
+			parport_pc_writesl(port, EPPDATA(port), buf,
+					(length >> 2));
 		else if ((flags & PARPORT_EPP_FAST_16)
 			 && !(((long)buf | length) & 0x01))
-			outsw(EPPDATA(port), buf, length >> 1);
+			parport_pc_writesw(port, EPPDATA(port), buf,
+					length >> 1);
 		else
-			outsb(EPPDATA(port), buf, length);
-		if (inb(STATUS(port)) & 0x01) {
+			parport_pc_writesb(port, EPPDATA(port), buf, length);
+		if (parport_pc_readb(port, STATUS(port)) & 0x01) {
 			clear_epp_timeout(port);
 			return -EIO;
 		}
 		return length;
 	}
 	for (; written < length; written++) {
-		outb(*((char *)buf), EPPDATA(port));
+		parport_pc_writeb(port, *((char *)buf), EPPDATA(port));
 		buf++;
-		if (inb(STATUS(port)) & 0x01) {
+		if (parport_pc_readb(port, STATUS(port)) & 0x01) {
 			clear_epp_timeout(port);
 			break;
 		}
@@ -375,17 +383,17 @@ static size_t parport_pc_epp_read_addr(struct parport *port, void *buf,
 	size_t got = 0;
 
 	if ((flags & PARPORT_EPP_FAST) && (length > 1)) {
-		insb(EPPADDR(port), buf, length);
-		if (inb(STATUS(port)) & 0x01) {
+		parport_pc_readsb(port, EPPADDR(port), buf, length);
+		if (parport_pc_readb(port, STATUS(port)) & 0x01) {
 			clear_epp_timeout(port);
 			return -EIO;
 		}
 		return length;
 	}
 	for (; got < length; got++) {
-		*((char *)buf) = inb(EPPADDR(port));
+		*((char *)buf) = parport_pc_readb(port, EPPADDR(port));
 		buf++;
-		if (inb(STATUS(port)) & 0x01) {
+		if (parport_pc_readb(port, STATUS(port)) & 0x01) {
 			clear_epp_timeout(port);
 			break;
 		}
@@ -401,17 +409,17 @@ static size_t parport_pc_epp_write_addr(struct parport *port,
 	size_t written = 0;
 
 	if ((flags & PARPORT_EPP_FAST) && (length > 1)) {
-		outsb(EPPADDR(port), buf, length);
-		if (inb(STATUS(port)) & 0x01) {
+		parport_pc_writesb(port, EPPADDR(port), buf, length);
+		if (parport_pc_readb(port, STATUS(port)) & 0x01) {
 			clear_epp_timeout(port);
 			return -EIO;
 		}
 		return length;
 	}
 	for (; written < length; written++) {
-		outb(*((char *)buf), EPPADDR(port));
+		parport_pc_writeb(port, *((char *)buf), EPPADDR(port));
 		buf++;
-		if (inb(STATUS(port)) & 0x01) {
+		if (parport_pc_readb(port, STATUS(port)) & 0x01) {
 			clear_epp_timeout(port);
 			break;
 		}
@@ -504,7 +512,7 @@ static size_t parport_pc_fifo_write_block_pio(struct parport *port,
 
 	while (left) {
 		unsigned char byte;
-		unsigned char ecrval = inb(ECONTROL(port));
+		unsigned char ecrval = parport_pc_readb(port, ECONTROL(port));
 		int i = 0;
 
 		if (need_resched() && time_before(jiffies, expire))
@@ -532,7 +540,7 @@ static size_t parport_pc_fifo_write_block_pio(struct parport *port,
 				printk(KERN_DEBUG "FIFO write timed out\n");
 				break;
 			}
-			ecrval = inb(ECONTROL(port));
+			ecrval = parport_pc_readb(port, ECONTROL(port));
 			if (!(ecrval & (1<<2))) {
 				if (need_resched() &&
 				    time_before(jiffies, expire))
@@ -554,7 +562,7 @@ static size_t parport_pc_fifo_write_block_pio(struct parport *port,
 		if (ecrval & 0x01) {
 			/* FIFO is empty. Blast it full. */
 			const int n = left < fifo_depth ? left : fifo_depth;
-			outsb(fifo, bufp, n);
+			parport_pc_writesb(port, fifo, bufp, n);
 			bufp += n;
 			left -= n;
 
@@ -564,13 +572,13 @@ static size_t parport_pc_fifo_write_block_pio(struct parport *port,
 			continue;
 		} else if (i++ < poll_for) {
 			udelay(10);
-			ecrval = inb(ECONTROL(port));
+			ecrval = parport_pc_readb(port, ECONTROL(port));
 			goto poll;
 		}
 
 		/* Half-full(call me an optimist) */
 		byte = *bufp++;
-		outb(byte, fifo);
+		parport_pc_writeb(port, byte, fifo);
 		left--;
 	}
 	dump_parport_state("leave fifo_write_block_pio", port);
@@ -662,7 +670,7 @@ static size_t parport_pc_fifo_write_block_dma(struct parport *port,
 			break;
 		}
 		/* Is serviceIntr set? */
-		if (!(inb(ECONTROL(port)) & (1<<2))) {
+		if (!(parport_pc_readb(port, ECONTROL(port)) & (1<<2))) {
 			cond_resched();
 
 			goto false_alarm;
@@ -767,11 +775,11 @@ static size_t parport_pc_compat_write_block_pio(struct parport *port,
 
 		/* Adjust for the contents of the FIFO. */
 		for (written -= priv->fifo_depth; ; written++) {
-			if (inb(ECONTROL(port)) & 0x2) {
+			if (parport_pc_readb(port, ECONTROL(port)) & 0x2) {
 				/* Full up. */
 				break;
 			}
-			outb(0, FIFO(port));
+			parport_pc_writeb(port, 0, FIFO(port));
 		}
 
 		/* Reset the FIFO and return to PS2 mode. */
@@ -862,11 +870,11 @@ static size_t parport_pc_ecp_write_block_pio(struct parport *port,
 
 		/* Adjust for the contents of the FIFO. */
 		for (written -= priv->fifo_depth; ; written++) {
-			if (inb(ECONTROL(port)) & 0x2) {
+			if (parport_pc_readb(port, ECONTROL(port)) & 0x2) {
 				/* Full up. */
 				break;
 			}
-			outb(0, FIFO(port));
+			parport_pc_writeb(port, 0, FIFO(port));
 		}
 
 		/* Reset the FIFO and return to PS2 mode. */
@@ -975,21 +983,21 @@ static void show_parconfig_smsc37c669(int io, int key)
 		"ECP",
 		"ECP and EPP" };
 
-	outb(key, io);
-	outb(key, io);
-	outb(1, io);
-	cr1 = inb(io + 1);
-	outb(4, io);
-	cr4 = inb(io + 1);
-	outb(0x0a, io);
-	cra = inb(io + 1);
-	outb(0x23, io);
-	cr23 = inb(io + 1);
-	outb(0x26, io);
-	cr26 = inb(io + 1);
-	outb(0x27, io);
-	cr27 = inb(io + 1);
-	outb(0xaa, io);
+	parport_pc_writeb(NULL, key, io);
+	parport_pc_writeb(NULL, key, io);
+	parport_pc_writeb(NULL, 1, io);
+	cr1 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 4, io);
+	cr4 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x0a, io);
+	cra = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x23, io);
+	cr23 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x26, io);
+	cr26 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x27, io);
+	cr27 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0xaa, io);
 
 	if (verbose_probing) {
 		pr_info("SMSC 37c669 LPT Config: cr_1=0x%02x, 4=0x%02x, A=0x%2x, 23=0x%02x, 26=0x%02x, 27=0x%02x\n",
@@ -1065,23 +1073,25 @@ static void show_parconfig_winbond(int io, int key)
 	/* The registers are called compatible-PnP because the
 	   register layout is modelled after ISA-PnP, the access
 	   method is just another ... */
-	outb(key, io);
-	outb(key, io);
-	outb(0x07, io);   /* Register 7: Select Logical Device */
-	outb(0x01, io + 1); /* LD1 is Parallel Port */
-	outb(0x30, io);
-	cr30 = inb(io + 1);
-	outb(0x60, io);
-	cr60 = inb(io + 1);
-	outb(0x61, io);
-	cr61 = inb(io + 1);
-	outb(0x70, io);
-	cr70 = inb(io + 1);
-	outb(0x74, io);
-	cr74 = inb(io + 1);
-	outb(0xf0, io);
-	crf0 = inb(io + 1);
-	outb(0xaa, io);
+	parport_pc_writeb(NULL, key, io);
+	parport_pc_writeb(NULL, key, io);
+	parport_pc_writeb(NULL, 0x07, io); /* Register 7:
+					    * Select Logical Device
+					    */
+	parport_pc_writeb(NULL, 0x01, io + 1); /* LD1 is Parallel Port */
+	parport_pc_writeb(NULL, 0x30, io);
+	cr30 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x60, io);
+	cr60 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x61, io);
+	cr61 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x70, io);
+	cr70 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x74, io);
+	cr74 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0xf0, io);
+	crf0 = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0xaa, io);
 
 	if (verbose_probing) {
 		pr_info("Winbond LPT Config: cr_30=%02x 60,61=%02x%02x 70=%02x 74=%02x, f0=%02x\n",
@@ -1202,28 +1212,36 @@ static void winbond_check(int io, int key)
 	if (!request_region(io, 3, __func__))
 		return;
 
-	origval = inb(io); /* Save original value */
+	origval = parport_pc_readb(NULL, io); /* Save original value */
 
 	/* First probe without key */
-	outb(0x20, io);
-	x_devid = inb(io + 1);
-	outb(0x21, io);
-	x_devrev = inb(io + 1);
-	outb(0x09, io);
-	x_oldid = inb(io + 1);
-
-	outb(key, io);
-	outb(key, io);     /* Write Magic Sequence to EFER, extended
-			      function enable register */
-	outb(0x20, io);    /* Write EFIR, extended function index register */
-	devid = inb(io + 1);  /* Read EFDR, extended function data register */
-	outb(0x21, io);
-	devrev = inb(io + 1);
-	outb(0x09, io);
-	oldid = inb(io + 1);
-	outb(0xaa, io);    /* Magic Seal */
-
-	outb(origval, io); /* in case we poked some entirely different hardware */
+	parport_pc_writeb(NULL, 0x20, io);
+	x_devid = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x21, io);
+	x_devrev = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x09, io);
+	x_oldid = parport_pc_readb(NULL, io + 1);
+
+	parport_pc_writeb(NULL, key, io);
+	parport_pc_writeb(NULL, key, io);     /* Write Magic Sequence to EFER,
+					       * extended function
+					       * enable register
+					       */
+	parport_pc_writeb(NULL, 0x20, io);    /* Write EFIR, extended function
+					       * index register
+					       */
+	devid = parport_pc_readb(NULL, io + 1);  /* Read EFDR, extended
+						  * function data register
+						  */
+	parport_pc_writeb(NULL, 0x21, io);
+	devrev = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x09, io);
+	oldid = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0xaa, io);    /* Magic Seal */
+
+	parport_pc_writeb(NULL, origval, io); /* in case we poked some
+					       * entirely different hardware
+					       */
 
 	if ((x_devid == devid) && (x_devrev == devrev) && (x_oldid == oldid))
 		goto out; /* protection against false positives */
@@ -1240,31 +1258,38 @@ static void winbond_check2(int io, int key)
 	if (!request_region(io, 3, __func__))
 		return;
 
-	origval[0] = inb(io); /* Save original values */
-	origval[1] = inb(io + 1);
-	origval[2] = inb(io + 2);
+	origval[0] = parport_pc_readb(NULL, io); /* Save original values */
+	origval[1] = parport_pc_readb(NULL, io + 1);
+	origval[2] = parport_pc_readb(NULL, io + 2);
 
 	/* First probe without the key */
-	outb(0x20, io + 2);
-	x_devid = inb(io + 2);
-	outb(0x21, io + 1);
-	x_devrev = inb(io + 2);
-	outb(0x09, io + 1);
-	x_oldid = inb(io + 2);
-
-	outb(key, io);     /* Write Magic Byte to EFER, extended
-			      function enable register */
-	outb(0x20, io + 2);  /* Write EFIR, extended function index register */
-	devid = inb(io + 2);  /* Read EFDR, extended function data register */
-	outb(0x21, io + 1);
-	devrev = inb(io + 2);
-	outb(0x09, io + 1);
-	oldid = inb(io + 2);
-	outb(0xaa, io);    /* Magic Seal */
-
-	outb(origval[0], io); /* in case we poked some entirely different hardware */
-	outb(origval[1], io + 1);
-	outb(origval[2], io + 2);
+	parport_pc_writeb(NULL, 0x20, io + 2);
+	x_devid = parport_pc_readb(NULL, io + 2);
+	parport_pc_writeb(NULL, 0x21, io + 1);
+	x_devrev = parport_pc_readb(NULL, io + 2);
+	parport_pc_writeb(NULL, 0x09, io + 1);
+	x_oldid = parport_pc_readb(NULL, io + 2);
+
+	parport_pc_writeb(NULL, key, io); /* Write Magic Byte to EFER, extended
+					   * function enable register
+					   */
+	parport_pc_writeb(NULL, 0x20, io + 2); /* Write EFIR, extended function
+						*  index register
+						*/
+	devid = parport_pc_readb(NULL, io + 2);  /* Read EFDR, extended
+						  * function data register
+						  */
+	parport_pc_writeb(NULL, 0x21, io + 1);
+	devrev = parport_pc_readb(NULL, io + 2);
+	parport_pc_writeb(NULL, 0x09, io + 1);
+	oldid = parport_pc_readb(NULL, io + 2);
+	parport_pc_writeb(NULL, 0xaa, io);    /* Magic Seal */
+
+	parport_pc_writeb(NULL, origval[0], io); /* in case we poked some
+						  * entirely different hardware
+						  */
+	parport_pc_writeb(NULL, origval[1], io + 1);
+	parport_pc_writeb(NULL, origval[2], io + 2);
 
 	if (x_devid == devid && x_devrev == devrev && x_oldid == oldid)
 		goto out; /* protection against false positives */
@@ -1281,32 +1306,40 @@ static void smsc_check(int io, int key)
 	if (!request_region(io, 3, __func__))
 		return;
 
-	origval = inb(io); /* Save original value */
+	origval = parport_pc_readb(NULL, io); /* Save original value */
 
 	/* First probe without the key */
-	outb(0x0d, io);
-	x_oldid = inb(io + 1);
-	outb(0x0e, io);
-	x_oldrev = inb(io + 1);
-	outb(0x20, io);
-	x_id = inb(io + 1);
-	outb(0x21, io);
-	x_rev = inb(io + 1);
-
-	outb(key, io);
-	outb(key, io);     /* Write Magic Sequence to EFER, extended
-			      function enable register */
-	outb(0x0d, io);    /* Write EFIR, extended function index register */
-	oldid = inb(io + 1);  /* Read EFDR, extended function data register */
-	outb(0x0e, io);
-	oldrev = inb(io + 1);
-	outb(0x20, io);
-	id = inb(io + 1);
-	outb(0x21, io);
-	rev = inb(io + 1);
-	outb(0xaa, io);    /* Magic Seal */
-
-	outb(origval, io); /* in case we poked some entirely different hardware */
+	parport_pc_writeb(NULL, 0x0d, io);
+	x_oldid = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x0e, io);
+	x_oldrev = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x20, io);
+	x_id = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x21, io);
+	x_rev = parport_pc_readb(NULL, io + 1);
+
+	parport_pc_writeb(NULL, key, io);
+	parport_pc_writeb(NULL, key, io); /* Write Magic Sequence to EFER,
+					   * extended function
+					   * enable register
+					   */
+	parport_pc_writeb(NULL, 0x0d, io);  /* Write EFIR, extended function
+					     * index register
+					     */
+	oldid = parport_pc_readb(NULL, io + 1);  /* Read EFDR, extended
+						  * function data register
+						  */
+	parport_pc_writeb(NULL, 0x0e, io);
+	oldrev = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x20, io);
+	id = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0x21, io);
+	rev = parport_pc_readb(NULL, io + 1);
+	parport_pc_writeb(NULL, 0xaa, io);    /* Magic Seal */
+
+	parport_pc_writeb(NULL, origval, io); /* in case we poked some entirely
+					       * different hardware
+					       */
 
 	if (x_id == id && x_oldrev == oldrev &&
 	    x_oldid == oldid && x_rev == rev)
@@ -1349,28 +1382,28 @@ static void detect_and_report_it87(void)
 		printk(KERN_DEBUG "IT8705 Super-IO detection, now testing port 2E ...\n");
 	if (!request_muxed_region(0x2e, 2, __func__))
 		return;
-	origval = inb(0x2e);		/* Save original value */
-	outb(0x87, 0x2e);
-	outb(0x01, 0x2e);
-	outb(0x55, 0x2e);
-	outb(0x55, 0x2e);
-	outb(0x20, 0x2e);
-	dev = inb(0x2f) << 8;
-	outb(0x21, 0x2e);
-	dev |= inb(0x2f);
+	origval = parport_pc_readb(NULL, 0x2e); /* Save original value */
+	parport_pc_writeb(NULL, 0x87, 0x2e);
+	parport_pc_writeb(NULL, 0x01, 0x2e);
+	parport_pc_writeb(NULL, 0x55, 0x2e);
+	parport_pc_writeb(NULL, 0x55, 0x2e);
+	parport_pc_writeb(NULL, 0x20, 0x2e);
+	dev = parport_pc_readb(NULL, 0x2f) << 8;
+	parport_pc_writeb(NULL, 0x21, 0x2e);
+	dev |= parport_pc_readb(NULL, 0x2f);
 	if (dev == 0x8712 || dev == 0x8705 || dev == 0x8715 ||
 	    dev == 0x8716 || dev == 0x8718 || dev == 0x8726) {
 		pr_info("IT%04X SuperIO detected\n", dev);
-		outb(0x07, 0x2E);	/* Parallel Port */
-		outb(0x03, 0x2F);
-		outb(0xF0, 0x2E);	/* BOOT 0x80 off */
-		r = inb(0x2f);
-		outb(0xF0, 0x2E);
-		outb(r | 8, 0x2F);
-		outb(0x02, 0x2E);	/* Lock */
-		outb(0x02, 0x2F);
+		parport_pc_writeb(NULL, 0x07, 0x2E);    /* Parallel Port */
+		parport_pc_writeb(NULL, 0x03, 0x2F);
+		parport_pc_writeb(NULL, 0xF0, 0x2E);    /* BOOT 0x80 off */
+		r = parport_pc_readb(NULL, 0x2f);
+		parport_pc_writeb(NULL, 0xF0, 0x2E);
+		parport_pc_writeb(NULL, r | 8, 0x2F);
+		parport_pc_writeb(NULL, 0x02, 0x2E);    /* Lock */
+		parport_pc_writeb(NULL, 0x02, 0x2F);
 	} else {
-		outb(origval, 0x2e);	/* Oops, sorry to disturb */
+		parport_pc_writeb(NULL, origval, 0x2e);
 	}
 	release_region(0x2e, 2);
 }
@@ -1427,19 +1460,19 @@ static int parport_SPP_supported(struct parport *pb)
 
 	/* Do a simple read-write test to make sure the port exists. */
 	w = 0xc;
-	outb(w, CONTROL(pb));
+	parport_pc_writeb(pb, w, CONTROL(pb));
 
 	/* Is there a control register that we can read from?  Some
 	 * ports don't allow reads, so read_control just returns a
 	 * software copy. Some ports _do_ allow reads, so bypass the
 	 * software copy here.  In addition, some bits aren't
 	 * writable. */
-	r = inb(CONTROL(pb));
+	r = parport_pc_readb(pb, CONTROL(pb));
 	if ((r & 0xf) == w) {
 		w = 0xe;
-		outb(w, CONTROL(pb));
-		r = inb(CONTROL(pb));
-		outb(0xc, CONTROL(pb));
+		parport_pc_writeb(pb, w, CONTROL(pb));
+		r = parport_pc_readb(pb, CONTROL(pb));
+		parport_pc_writeb(pb, 0xc, CONTROL(pb));
 		if ((r & 0xf) == w)
 			return PARPORT_MODE_PCSPP;
 	}
@@ -1499,26 +1532,26 @@ static int parport_ECR_present(struct parport *pb)
 	unsigned char r = 0xc;
 
 	if (!priv->ecr_writable) {
-		outb(r, CONTROL(pb));
-		if ((inb(ECONTROL(pb)) & 0x3) == (r & 0x3)) {
-			outb(r ^ 0x2, CONTROL(pb)); /* Toggle bit 1 */
+		parport_pc_writeb(pb, r, CONTROL(pb));
+		if ((parport_pc_readb(pb, ECONTROL(pb)) & 0x3) == (r & 0x3)) {
+			parport_pc_writeb(pb, r ^ 0x2, CONTROL(pb)); /* Toggle bit 1 */
 
-			r = inb(CONTROL(pb));
-			if ((inb(ECONTROL(pb)) & 0x2) == (r & 0x2))
+			r = parport_pc_readb(pb, CONTROL(pb));
+			if ((parport_pc_readb(pb, ECONTROL(pb)) & 0x2) == (r & 0x2))
 				/* Sure that no ECR register exists */
 				goto no_reg;
 		}
 
-		if ((inb(ECONTROL(pb)) & 0x3) != 0x1)
+		if ((parport_pc_readb(pb, ECONTROL(pb)) & 0x3) != 0x1)
 			goto no_reg;
 
 		ECR_WRITE(pb, 0x34);
-		if (inb(ECONTROL(pb)) != 0x35)
+		if (parport_pc_readb(pb, ECONTROL(pb)) != 0x35)
 			goto no_reg;
 	}
 
 	priv->ecr = 1;
-	outb(0xc, CONTROL(pb));
+	parport_pc_writeb(pb, 0xc, CONTROL(pb));
 
 	/* Go to mode 000 */
 	frob_set_mode(pb, ECR_SPP);
@@ -1526,7 +1559,7 @@ static int parport_ECR_present(struct parport *pb)
 	return 1;
 
  no_reg:
-	outb(0xc, CONTROL(pb));
+	parport_pc_writeb(pb, 0xc, CONTROL(pb));
 	return 0;
 }
 
@@ -1595,8 +1628,9 @@ static int parport_ECP_supported(struct parport *pb)
 	/* Find out FIFO depth */
 	ECR_WRITE(pb, ECR_SPP << 5); /* Reset FIFO */
 	ECR_WRITE(pb, ECR_TST << 5); /* TEST FIFO */
-	for (i = 0; i < 1024 && !(inb(ECONTROL(pb)) & 0x02); i++)
-		outb(0xaa, FIFO(pb));
+	for (i = 0; i < 1024 && !(parport_pc_readb(pb, ECONTROL(pb))
+		& 0x02); i++)
+		parport_pc_writeb(pb, 0xaa, FIFO(pb));
 
 	/*
 	 * Using LGS chipset it uses ECR register, but
@@ -1615,9 +1649,9 @@ static int parport_ECP_supported(struct parport *pb)
 	frob_econtrol(pb, 1<<2, 1<<2);
 	frob_econtrol(pb, 1<<2, 0);
 	for (i = 1; i <= priv->fifo_depth; i++) {
-		inb(FIFO(pb));
+		parport_pc_readb(pb, FIFO(pb));
 		udelay(50);
-		if (inb(ECONTROL(pb)) & (1<<2))
+		if (parport_pc_readb(pb, ECONTROL(pb)) & (1<<2))
 			break;
 	}
 
@@ -1639,8 +1673,8 @@ static int parport_ECP_supported(struct parport *pb)
 	frob_econtrol(pb, 1<<2, 1<<2);
 	frob_econtrol(pb, 1<<2, 0);
 	for (i = 1; i <= priv->fifo_depth; i++) {
-		outb(0xaa, FIFO(pb));
-		if (inb(ECONTROL(pb)) & (1<<2))
+		parport_pc_writeb(pb, 0xaa, FIFO(pb));
+		if (parport_pc_readb(pb, ECONTROL(pb)) & (1<<2))
 			break;
 	}
 
@@ -1656,7 +1690,7 @@ static int parport_ECP_supported(struct parport *pb)
 
 	ECR_WRITE(pb, ECR_SPP << 5); /* Reset FIFO */
 	ECR_WRITE(pb, 0xf4); /* Configuration mode */
-	config = inb(CONFIGA(pb));
+	config = parport_pc_readb(pb, CONFIGA(pb));
 	pword = (config >> 4) & 0x7;
 	switch (pword) {
 	case 0:
@@ -1682,7 +1716,7 @@ static int parport_ECP_supported(struct parport *pb)
 		pr_debug("0x%lx: Interrupts are ISA-%s\n",
 		       pb->iobase, config & 0x80 ? "Level" : "Pulses");
 
-		configb = inb(CONFIGB(pb));
+		configb = parport_pc_readb(pb, CONFIGB(pb));
 		pr_debug("0x%lx: ECP port cfgA=0x%02x cfgB=0x%02x\n",
 		       pb->iobase, config, configb);
 		pr_debug("0x%lx: ECP settings irq=", pb->iobase);
@@ -1712,7 +1746,7 @@ static int intel_bug_present_check_epp(struct parport *pb)
 
 	if (priv->ecr) {
 		/* store value of ECR */
-		unsigned char ecr = inb(ECONTROL(pb));
+		unsigned char ecr = parport_pc_readb(pb, ECONTROL(pb));
 		unsigned char i;
 		for (i = 0x00; i < 0x80; i += 0x20) {
 			ECR_WRITE(pb, i);
@@ -1753,7 +1787,7 @@ static int parport_ECPPS2_supported(struct parport *pb)
 	if (!priv->ecr)
 		return 0;
 
-	oecr = inb(ECONTROL(pb));
+	oecr = parport_pc_readb(pb, ECONTROL(pb));
 	ECR_WRITE(pb, ECR_PS2 << 5);
 	result = parport_PS2_supported(pb);
 	ECR_WRITE(pb, oecr);
@@ -1805,10 +1839,10 @@ static int parport_ECPEPP_supported(struct parport *pb)
 	if (!priv->ecr)
 		return 0;
 
-	oecr = inb(ECONTROL(pb));
+	oecr = parport_pc_readb(pb, ECONTROL(pb));
 	/* Search for SMC style EPP+ECP mode */
 	ECR_WRITE(pb, 0x80);
-	outb(0x04, CONTROL(pb));
+	parport_pc_writeb(pb, 0x04, CONTROL(pb));
 	result = parport_EPP_supported(pb);
 
 	ECR_WRITE(pb, oecr);
@@ -1857,14 +1891,14 @@ static int parport_ECPPS2_supported(struct parport *pb)
 static int programmable_irq_support(struct parport *pb)
 {
 	int irq, intrLine;
-	unsigned char oecr = inb(ECONTROL(pb));
+	unsigned char oecr = parport_pc_readb(pb, ECONTROL(pb));
 	static const int lookup[8] = {
 		PARPORT_IRQ_NONE, 7, 9, 10, 11, 14, 15, 5
 	};
 
 	ECR_WRITE(pb, ECR_CNF << 5); /* Configuration MODE */
 
-	intrLine = (inb(CONFIGB(pb)) >> 3) & 0x07;
+	intrLine = (parport_pc_readb(pb, CONFIGB(pb)) >> 3) & 0x07;
 	irq = lookup[intrLine];
 
 	ECR_WRITE(pb, oecr);
@@ -1883,8 +1917,9 @@ static int irq_probe_ECP(struct parport *pb)
 	ECR_WRITE(pb, ECR_TST << 5);
 
 	/* If Full FIFO sure that writeIntrThreshold is generated */
-	for (i = 0; i < 1024 && !(inb(ECONTROL(pb)) & 0x02) ; i++)
-		outb(0xaa, FIFO(pb));
+	for (i = 0; i < 1024 && !(parport_pc_readb(pb, ECONTROL(pb)) & 0x02);
+		i++)
+		parport_pc_writeb(pb, 0xaa, FIFO(pb));
 
 	pb->irq = probe_irq_off(irqs);
 	ECR_WRITE(pb, ECR_SPP << 5);
@@ -1908,7 +1943,7 @@ static int irq_probe_EPP(struct parport *pb)
 	unsigned char oecr;
 
 	if (pb->modes & PARPORT_MODE_PCECR)
-		oecr = inb(ECONTROL(pb));
+		oecr = parport_pc_readb(pb, ECONTROL(pb));
 
 	irqs = probe_irq_on();
 
@@ -1987,12 +2022,12 @@ static int parport_irq_probe(struct parport *pb)
 /* Only if chipset conforms to ECP ISA Interface Standard */
 static int programmable_dma_support(struct parport *p)
 {
-	unsigned char oecr = inb(ECONTROL(p));
+	unsigned char oecr = parport_pc_readb(p, ECONTROL(p));
 	int dma;
 
 	frob_set_mode(p, ECR_CNF);
 
-	dma = inb(CONFIGB(p)) & 0x07;
+	dma = parport_pc_readb(p, CONFIGB(p)) & 0x07;
 	/* 000: Indicates jumpered 8-bit DMA if read-only.
 	   100: Indicates jumpered 16-bit DMA if read-only. */
 	if ((dma & 0x03) == 0)
@@ -2067,10 +2102,25 @@ static struct parport *__parport_pc_probe_port(struct parport_data data,
 	if (!p)
 		goto out3;
 
+	p->mapbase = data.mapbase;
+	p->mapsize = data.mapsize;
+
 	if (p->iobase) {
-		base_res = request_region(data.iobase, 3, p->name);
+		base_res = request_region(p->iobase, 3, p->name);
 		if (!base_res)
 			goto out4;
+		p->iotype = PARPORT_IOPORT;
+	} else if (p->mapbase && p->mapsize >= 3) {
+		if (!request_mem_region(p->mapbase, p->mapsize,
+			"parport")) {
+			goto out4;
+		}
+		p->membase = ioremap(p->mapbase, p->mapsize);
+		if (!p->membase) {
+			release_mem_region(p->mapbase, p->mapsize);
+			goto out4;
+		}
+		p->iotype = PARPORT_IOMEM;
 	} else {
 		goto out4;
 	}
@@ -2087,22 +2137,35 @@ static struct parport *__parport_pc_probe_port(struct parport_data data,
 	priv->port = p;
 
 	p->dev = dev;
+	p->mapbase_hi = data.mapbase_hi;
+	p->mapsize_hi = data.mapsize_hi;
 	p->iobase_hi = data.iobase_hi;
 	p->modes = PARPORT_MODE_PCSPP | PARPORT_MODE_SAFEININT;
 	p->private_data = priv;
 
 	if (p->iobase_hi) {
-		ECR_res = request_region(data.iobase_hi, 3, p->name);
+		ECR_res = request_region(p->iobase_hi, 3, p->name);
 		if (ECR_res)
 			parport_ECR_present(p);
+	} else if (p->mapbase_hi && (p->mapsize_hi >= 3)) {
+		if (request_mem_region(p->mapbase_hi, p->mapsize_hi,
+			"parport")) {
+			p->membase_hi = ioremap(p->mapbase_hi,
+							p->mapsize_hi);
+			if (!p->membase_hi)
+				release_mem_region(p->mapbase_hi,
+							p->mapsize_hi);
+			else
+				parport_ECR_present(p);
+		}
 	}
 
-	if (p->iobase != 0x3bc) {
-		EPP_res = request_region(data.iobase + 0x3, 5, p->name);
-		if (EPP_res)
-			if (!parport_EPP_supported(p))
-				parport_ECPEPP_supported(p);
-	}
+	if (p->iobase && (p->iobase != 0x3bc))
+		EPP_res = request_region(p->iobase + 0x3, 5, p->name);
+
+	if (EPP_res || p->mapsize >= 8)
+		if (!parport_EPP_supported(p))
+			parport_ECPEPP_supported(p);
 	if (!parport_SPP_supported(p))
 		/* No port. */
 		goto out5;
@@ -2113,9 +2176,12 @@ static struct parport *__parport_pc_probe_port(struct parport_data data,
 
 	p->size = (p->modes & PARPORT_MODE_EPP) ? 8 : 3;
 
-	pr_info("%s: PC-style at 0x%lx", p->name, p->iobase);
-	if (p->iobase_hi && priv->ecr)
-		pr_cont(" (0x%lx)", p->iobase_hi);
+	pr_info("%s: PC-style at 0x%lx", p->name,
+		is_ioport(p) ? p->iobase : (unsigned long)p->mapbase);
+	if ((p->iobase_hi || p->membase_hi) && priv->ecr)
+		pr_cont(" (0x%lx)",
+			is_ioport(p) ? p->iobase_hi :
+			(unsigned long)p->mapbase_hi);
 	if (p->irq == PARPORT_IRQ_AUTO) {
 		p->irq = PARPORT_IRQ_NONE;
 		parport_irq_probe(p);
@@ -2197,6 +2263,11 @@ do {									\
 		if (p->iobase_hi && ECR_res) {
 			release_region(p->iobase_hi, 3);
 			ECR_res = NULL;
+		} else if (p->membase_hi) {
+			iounmap(p->membase_hi);
+			release_mem_region(p->mapbase_hi,
+						p->mapsize_hi);
+			p->membase_hi = NULL;
 		}
 	}
 
@@ -2206,6 +2277,8 @@ do {									\
 		EPP_res = NULL;
 	}
 	if (p->irq != PARPORT_IRQ_NONE) {
+		if (!is_ioport(p))
+			irqflags |= IRQF_SHARED;
 		if (request_irq(p->irq, parport_irq_handler,
 				 irqflags, p->name, p)) {
 			pr_warn("%s: irq %d in use, resorting to polled operation\n",
@@ -2265,7 +2338,22 @@ do {									\
 		release_region(p->iobase_hi, 3);
 	if (EPP_res)
 		release_region(p->iobase + 0x3, 5);
-	release_region(p->iobase, 3);
+	if (is_ioport(p))
+		release_region(p->iobase, 3);
+	else {
+		iounmap(p->membase);
+		release_mem_region(p->mapbase, p->mapsize);
+		p->membase = NULL;
+		if (p->mapbase_hi && p->mapsize_hi >= 3) {
+			if (p->membase_hi) {
+				iounmap(p->membase_hi);
+				release_mem_region(p->mapbase_hi,
+							p->mapsize_hi);
+				p->membase_hi = NULL;
+			}
+		}
+	}
+
 out4:
 	parport_del_port(p);
 out3:
@@ -2314,10 +2402,16 @@ void parport_pc_unregister_port(struct parport *p)
 #endif
 	if (p->irq != PARPORT_IRQ_NONE)
 		free_irq(p->irq, p);
-	release_region(p->iobase, 3);
-	if (p->size > 3)
+	if (is_ioport(p)) {
+		release_region(p->iobase, 3);
+	} else {
+		iounmap(p->membase);
+		release_mem_region(p->mapbase, p->mapsize);
+		p->membase = NULL;
+	}
+	if (is_ioport(p) && p->size > 3)
 		release_region(p->iobase + 3, p->size - 3);
-	if (p->modes & PARPORT_MODE_ECP)
+	if (is_ioport(p) && (p->modes & PARPORT_MODE_ECP))
 		release_region(p->iobase_hi, 3);
 #if defined(CONFIG_PARPORT_PC_FIFO) && defined(HAS_DMA)
 	if (priv->dma_buf)
@@ -2355,7 +2449,7 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 						0xe5000000 | inta_addr[i]);
 			pci_write_config_dword(pdev, 0x78,
 						0x00000000 | inta_addr[i]);
-			test = inb(inta_addr[i]);
+			test = parport_pc_readb(NULL, inta_addr[i]);
 			if (test != 0xff)
 				break;
 			release_region(inta_addr[i], 32);
@@ -2366,7 +2460,7 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 		return 0;
 	}
 
-	type = inb(inta_addr[i] + 0x18);
+	type = parport_pc_readb(NULL, inta_addr[i] + 0x18);
 	type &= 0x0f;
 
 	switch (type) {
@@ -2513,34 +2607,36 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	pci_write_config_byte(pdev, via->via_pci_superio_config_reg, tmp);
 
 	/* Bits 1-0: Parallel Port Mode / Enable */
-	outb(via->viacfg_function, VIA_CONFIG_INDEX);
-	tmp = inb(VIA_CONFIG_DATA);
+	parport_pc_writeb(NULL, via->viacfg_function, VIA_CONFIG_INDEX);
+	tmp = parport_pc_readb(NULL, VIA_CONFIG_DATA);
 	/* Bit 5: EPP+ECP enable; bit 7: PS/2 bidirectional port enable */
-	outb(via->viacfg_parport_control, VIA_CONFIG_INDEX);
-	tmp2 = inb(VIA_CONFIG_DATA);
+	parport_pc_writeb(NULL, via->viacfg_parport_control, VIA_CONFIG_INDEX);
+	tmp2 = parport_pc_readb(NULL, VIA_CONFIG_DATA);
 	if (siofunc == VIA_FUNCTION_PROBE) {
 		siofunc = tmp & VIA_FUNCTION_PARPORT_DISABLE;
 		ppcontrol = tmp2;
 	} else {
 		tmp &= ~VIA_FUNCTION_PARPORT_DISABLE;
 		tmp |= siofunc;
-		outb(via->viacfg_function, VIA_CONFIG_INDEX);
-		outb(tmp, VIA_CONFIG_DATA);
+		parport_pc_writeb(NULL, via->viacfg_function, VIA_CONFIG_INDEX);
+		parport_pc_writeb(NULL, tmp, VIA_CONFIG_DATA);
 		tmp2 &= ~(VIA_PARPORT_BIDIR|VIA_PARPORT_ECPEPP);
 		tmp2 |= ppcontrol;
-		outb(via->viacfg_parport_control, VIA_CONFIG_INDEX);
-		outb(tmp2, VIA_CONFIG_DATA);
+		parport_pc_writeb(NULL, via->viacfg_parport_control,
+				VIA_CONFIG_INDEX);
+		parport_pc_writeb(NULL, tmp2, VIA_CONFIG_DATA);
 	}
 
 	/* Parallel Port I/O Base Address, bits 9-2 */
-	outb(via->viacfg_parport_base, VIA_CONFIG_INDEX);
-	port1 = inb(VIA_CONFIG_DATA) << 2;
+	parport_pc_writeb(NULL, via->viacfg_parport_base, VIA_CONFIG_INDEX);
+	port1 = parport_pc_readb(NULL, VIA_CONFIG_DATA) << 2;
 
 	printk(KERN_DEBUG "parport_pc: Current parallel port base: 0x%X\n",
 	       port1);
 	if (port1 == 0x3BC && have_epp) {
-		outb(via->viacfg_parport_base, VIA_CONFIG_INDEX);
-		outb((0x378 >> 2), VIA_CONFIG_DATA);
+		parport_pc_writeb(NULL, via->viacfg_parport_base,
+				VIA_CONFIG_INDEX);
+		parport_pc_writeb(NULL, (0x378 >> 2), VIA_CONFIG_DATA);
 		printk(KERN_DEBUG "parport_pc: Parallel port base changed to 0x378\n");
 		port1 = 0x378;
 	}
@@ -3029,12 +3125,20 @@ static int parport_pc_pnp_probe(struct pnp_dev *dev,
 	if (pnp_port_valid(dev, 0) &&
 		!(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
 		tmp_pdata.iobase = pnp_port_start(dev, 0);
+	} else if (pnp_mem_valid(dev, 0) &&
+		!(pnp_mem_flags(dev, 0) & IORESOURCE_DISABLED)) {
+		tmp_pdata.mapbase = pnp_mem_start(dev, 0);
+		tmp_pdata.mapsize = pnp_mem_len(dev, 0);
 	} else
 		return -EINVAL;
 
 	if (pnp_port_valid(dev, 1) &&
 		!(pnp_port_flags(dev, 1) & IORESOURCE_DISABLED)) {
 		tmp_pdata.iobase_hi = pnp_port_start(dev, 1);
+	} else if (pnp_mem_valid(dev, 1) &&
+		!(pnp_mem_flags(dev, 1) & IORESOURCE_DISABLED)) {
+		tmp_pdata.mapbase_hi = pnp_mem_start(dev, 1);
+		tmp_pdata.mapsize_hi = pnp_mem_len(dev, 1);
 	} else
 		tmp_pdata.iobase_hi = 0;
 
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 308eadce42dd..fe034eb68514 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -180,19 +180,37 @@ struct ieee1284_info {
 	struct semaphore irq;
 };
 
+#define PARPORT_IOPORT 1
+#define PARPORT_IOMEM  2
+
 struct parport_data {
+	unsigned char iotype;   /* io access style */
 	/* for ioport */
 	unsigned long iobase;   /* base address for ioport */
 	unsigned long iobase_hi;        /* base address (hi - ECR) */
+	/* for iomem */
+	resource_size_t mapbase;        /* base address for iomem */
+	resource_size_t mapsize;
+	resource_size_t mapbase_hi;     /* base address (hi - ECR) */
+	resource_size_t mapsize_hi;
 	int irq;
 	int dma;
 };
 
 /* A parallel port */
 struct parport {
+	unsigned char iotype;   /* io access style */
+	/* for ioport */
 	unsigned long iobase;	/* base address for ioport */
 	unsigned long iobase_hi;  /* base address (hi - ECR) */
 	unsigned int size;	/* IO extent */
+	/* for iomem */
+	resource_size_t mapbase;        /* base address for iomem */
+	resource_size_t mapsize;
+	resource_size_t mapbase_hi;     /* base address for iomem */
+	resource_size_t mapsize_hi;
+	unsigned char __iomem   *membase;       /* read/write[bwl] */
+	unsigned char __iomem   *membase_hi;    /* read/write[bwl] */
 	const char *name;
 	unsigned int modes;
 	int irq;		/* interrupt (or -1 for none) */
diff --git a/include/linux/parport_pc.h b/include/linux/parport_pc.h
index d6c3f323caa1..b7acf35a5f91 100644
--- a/include/linux/parport_pc.h
+++ b/include/linux/parport_pc.h
@@ -5,16 +5,20 @@
 #include <asm/io.h>
 
 /* --- register definitions ------------------------------- */
-
-#define ECONTROL(p) ((p)->iobase_hi + 0x2)
-#define CONFIGB(p)  ((p)->iobase_hi + 0x1)
-#define CONFIGA(p)  ((p)->iobase_hi + 0x0)
-#define FIFO(p)     ((p)->iobase_hi + 0x0)
-#define EPPDATA(p)  ((p)->iobase    + 0x4)
-#define EPPADDR(p)  ((p)->iobase    + 0x3)
-#define CONTROL(p)  ((p)->iobase    + 0x2)
-#define STATUS(p)   ((p)->iobase    + 0x1)
-#define DATA(p)     ((p)->iobase    + 0x0)
+#define is_ioport(p)   (p == NULL || (p)->iotype == PARPORT_IOPORT)
+#define get_base(p)    (is_ioport(p) ? (p)->iobase :\
+				(unsigned long)(p)->membase)
+#define get_base_hi(p) (is_ioport(p) ? (p)->iobase_hi :\
+				(unsigned long)(p)->membase_hi)
+#define ECONTROL(p)    (get_base_hi(p) + 0x2)
+#define CONFIGB(p)     (get_base_hi(p) + 0x1)
+#define CONFIGA(p)     (get_base_hi(p) + 0x0)
+#define FIFO(p)                (get_base_hi(p) + 0x0)
+#define EPPDATA(p)     (get_base(p) + 0x4)
+#define EPPADDR(p)     (get_base(p) + 0x3)
+#define CONTROL(p)     (get_base(p) + 0x2)
+#define STATUS(p)      (get_base(p) + 0x1)
+#define DATA(p)                (get_base(p) + 0x0)
 
 struct parport_pc_private {
 	/* Contents of CTR. */
@@ -63,17 +67,78 @@ struct parport_pc_via_data
 	u8 viacfg_parport_base;
 };
 
+static inline void parport_pc_writeb(struct parport *p,
+					unsigned char d,
+					unsigned long addr)
+{
+	is_ioport(p) ? outb(d, addr) : writeb(d, (void __iomem *)addr);
+}
+
+static inline void parport_pc_writesb(struct parport *p,
+					unsigned long addr, const void *buf,
+					unsigned int count)
+{
+	is_ioport(p) ? outsb(addr, buf, count) :
+			writesb((void __iomem *)addr, buf, count);
+}
+
+static inline void parport_pc_writesl(struct parport *p,
+					unsigned long addr, const void *buf,
+					unsigned int count)
+{
+	is_ioport(p) ? outsl(addr, buf, count) :
+			writesl((void __iomem *)addr, buf, count);
+}
+
+static inline void parport_pc_writesw(struct parport *p,
+					unsigned long addr, const void *buf,
+					unsigned int count)
+{
+	is_ioport(p) ? outsw(addr, buf, count) :
+	writesw((void __iomem *)addr, buf, count);
+}
+
+static inline unsigned char parport_pc_readb(struct parport *p,
+						unsigned long addr)
+{
+	return is_ioport(p) ? inb(addr) : readb((void __iomem *)addr);
+}
+
+static inline void parport_pc_readsb(struct parport *p,
+					unsigned long addr, void *buf,
+					unsigned int count)
+{
+	is_ioport(p) ? insb(addr, buf, count) :
+			readsb((void __iomem *)addr, buf, count);
+}
+
+static inline void parport_pc_readsl(struct parport *p,
+					unsigned long addr, void *buf,
+					unsigned int count)
+{
+	is_ioport(p) ? insl(addr, buf, count) :
+			readsl((void __iomem *)addr, buf, count);
+}
+
+static inline void parport_pc_readsw(struct parport *p,
+					unsigned long addr, void *buf,
+					unsigned int count)
+{
+	is_ioport(p) ? insw(addr, buf, count) :
+			readsw((void __iomem *)addr, buf, count);
+}
+
 static __inline__ void parport_pc_write_data(struct parport *p, unsigned char d)
 {
 #ifdef DEBUG_PARPORT
 	printk (KERN_DEBUG "parport_pc_write_data(%p,0x%02x)\n", p, d);
 #endif
-	outb(d, DATA(p));
+	parport_pc_writeb(p, d, DATA(p));
 }
 
 static __inline__ unsigned char parport_pc_read_data(struct parport *p)
 {
-	unsigned char val = inb (DATA (p));
+	unsigned char val = parport_pc_readb(p, DATA(p));
 #ifdef DEBUG_PARPORT
 	printk (KERN_DEBUG "parport_pc_read_data(%p) = 0x%02x\n",
 		p, val);
@@ -85,9 +150,9 @@ static __inline__ unsigned char parport_pc_read_data(struct parport *p)
 static inline void dump_parport_state (char *str, struct parport *p)
 {
 	/* here's hoping that reading these ports won't side-effect anything underneath */
-	unsigned char ecr = inb (ECONTROL (p));
-	unsigned char dcr = inb (CONTROL (p));
-	unsigned char dsr = inb (STATUS (p));
+	unsigned char ecr = parport_pc_readb(p, ECONTROL(p));
+	unsigned char dcr = parport_pc_readb(p, CONTROL(p));
+	unsigned char dsr = parport_pc_readb(p, STATUS(p));
 	static const char *const ecr_modes[] = {"SPP", "PS2", "PPFIFO", "ECP", "xXx", "yYy", "TST", "CFG"};
 	const struct parport_pc_private *priv = p->physport->private_data;
 	int i;
@@ -100,7 +165,7 @@ static inline void dump_parport_state (char *str, struct parport *p)
 	if (ecr & 0x01) printk (",f_empty");
 	for (i=0; i<2; i++) {
 		printk ("]  dcr(%s)=[", i ? "soft" : "hard");
-		dcr = i ? priv->ctr : inb (CONTROL (p));
+		dcr = i ? priv->ctr : parport_pc_readb(p, CONTROL(p));
 	
 		if (dcr & 0x20) {
 			printk ("rev");
@@ -141,7 +206,7 @@ static __inline__ unsigned char __parport_pc_frob_control (struct parport *p,
 #endif
 	ctr = (ctr & ~mask) ^ val;
 	ctr &= priv->ctr_writable; /* only write writable bits. */
-	outb (ctr, CONTROL (p));
+	parport_pc_writeb(p, ctr, CONTROL(p));
 	priv->ctr = ctr;	/* Update soft copy */
 	return ctr;
 }
@@ -213,7 +278,7 @@ static __inline__ unsigned char parport_pc_frob_control (struct parport *p,
 
 static __inline__ unsigned char parport_pc_read_status(struct parport *p)
 {
-	return inb(STATUS(p));
+	return parport_pc_readb(p, STATUS(p));
 }
 
 
-- 
2.25.1


