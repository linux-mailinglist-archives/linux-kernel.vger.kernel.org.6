Return-Path: <linux-kernel+bounces-514884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D3AA35CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337653AFE27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFE526560F;
	Fri, 14 Feb 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUt/RxNE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7049264A9E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533672; cv=none; b=u13pLPr+GA1JiUKKCc/zzhSDOJgJL0XoCVMBS+g6KXFfRW3zSfFzaf0U53QCwYJpB2fhOSK7c5IrvLuRHClDmUTemEqJzgnEMg3PNOZOahglIbjbkNeGX+lmUuwH7h+er+zIfcxP4plGUKaeVfgjcnlUqnjfC4jfFS9v2ST//+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533672; c=relaxed/simple;
	bh=O1bn/1BvZjgyqpcx895AnBWA2zAgV1uG/BJY6OxiQxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ttxj1nAp//lPsADs2u8WTNLOjY9b7kSY6uvr+lvMeOGhWSefRTU3kvuI67Y8JJXhnWnxqGBKdsaPFhNpIX/r/uVGvQGiLYZGEd48EgYQIlU07IuThgmLXeAHuvxLJVUQ6VgnSeYlRlCnzPHY9u8ANsBOcN98+l8ZskInuFm347Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUt/RxNE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43964e79314so13995045e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533668; x=1740138468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OV+mCEvNJudQflI2QhDp7yyUUWwi2LGNvBg4pxJAkQ=;
        b=XUt/RxNE00a/g7RW46TyULDjnZex+JDurs5sq8yigntouNPtFdADrPuYtT2t3KHCVO
         KcU8dqa6Qi6liQcx2Exr4T23Duu7XdH/wGZHQ7hOS2E0m39mQbgkRlq4O0+BmbBEQ5DD
         arxrUtpPNzQ1iPkBMQ4dPdNJt+bXSHOqB7OSxPo8FDxwUEkwPm1Jx5+LYJC5Uim2zIfo
         UIHVurASuJu2BIXOFJge/jvkcngI7esRrnjYFYzKd+CjOCNIOMG1AYF8oL4l2UZj+QDC
         /N6CbrbSXZ75R4Jbu8f/VQYR6LJr2S9Sa6gAqEaQbEoBcgkuAcZXDkm0uDvc93/whgaG
         CdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533668; x=1740138468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OV+mCEvNJudQflI2QhDp7yyUUWwi2LGNvBg4pxJAkQ=;
        b=AVZpayM5A3x/aW1CDt/vA/jMg4sD4vYGT/v4+hc5ncnUUceAQjFhP8tI3+nq8hCepX
         uT+ggbL7m01x2Xy/jd+nVTGvVyYkZJbI1ybyJVxUJw1lXkwE7bF+IPmuK16VR1InObgJ
         +qsKRERu4Brmo0Nm/w+IkfsEfUvL9oixfjaqX93k6jgWL7SeAmRApUXLe+HQabgS3PtB
         gaiMcnq75PfruaHjETSivT4ieZdLCxXI/eFaDaLOZ1XaY182JJYYzr4Reh8i/lGuDsUc
         BA/hRgg3kWyWKEyGTCoWUOqxb2uSDl9KGVRnYWB5DO31UxdAzz2YbrYftShQ/g17QHSB
         KHHw==
X-Forwarded-Encrypted: i=1; AJvYcCWLb5J9zYGJ7xi2ohsnkWzInO05tNlEgoM3cto3nrb0N/TxFBp+omdxid+c4H/EfNJEp8cMxCF1wXCpOi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDS0Ilm67X/TF2yqSVGC/8E9820lN9SD3P1mXk7wBn5lQykrK9
	+2KwAcSoKlTIG4dS5Q30neYtAf/SqOAfSEw9RVLXD4nhGwmojuiA8FZmPA==
X-Gm-Gg: ASbGncsR6kC2hbGqKXl+GnAeEKlGMC+KOHinYUHMVL1GfExNotkzv9DvANddaOnNbtp
	5oTfUFVUfixtaf1BSrvJxa5muM+deUHy99Bhx91XNvxffFbCAhU7O8eQwdX0tZRlb5bQkxf7H9a
	2j/HPtT2MxTlYP1tDzCRjdJFsmi7OuNn5svXdZn41H8SBrHb4FzOS7mM0YpO8iLLFMsVl6o8HKk
	ivcX3HWgvQMOR4aB1AznS6A29sB6qOgitCVdhBrlU2eU0bhM40M4sOwnLZ0YeCmryWnX0Ief2CB
	u9vF7ubP3QKWwB+fYEP/uVDngc4+tycFNix8rIGWjlMmkEFoA6U=
X-Google-Smtp-Source: AGHT+IEdZouX4H3Wr2448+BGz52nT6alNmtKfh/sTN9TTpAKLYm7MbbGwFi6Lur6dFYNbUrO0WMNBQ==
X-Received: by 2002:a05:600c:4fd1:b0:439:35d2:ed6 with SMTP id 5b1f17b1804b1-4395816077amr120572785e9.3.1739533667779;
        Fri, 14 Feb 2025 03:47:47 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:46 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 11/17] staging: gpib: ines console messaging cleanup
Date: Fri, 14 Feb 2025 12:47:02 +0100
Message-ID: <20250214114708.28947-12-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214114708.28947-1-dpenkler@gmail.com>
References: <20250214114708.28947-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable module name to be printed in pr_xxx and dev_xxx
Use DRV_NAME defined as KBUILD_MODNAME instead of hard coded
string "ines_gpib" in pci_request_regions, request_irq and
request_region.

Remove "ines:" and "ines_gpib:" string prefixes in messages
since module name printing is enabled.

Change pr_err to dev_err where possible.

Remove interrupt warnings.

Remove PCMCIA debug comments, PCMCIA_DEBUG conditional compilation
symbol, the DEBUG macro definition and its uses.

Change pr_debug to dev_dbg.

Remove pr_info

Remove commented printk.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ines/ines_gpib.c | 101 +++++++++++---------------
 1 file changed, 42 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 73dafbe68acb..0f70438513df 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -5,6 +5,10 @@
  *			    (C) 2002 by Frank Mori Hess
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include "ines.h"
 
 #include <linux/pci.h>
@@ -56,7 +60,7 @@ int ines_line_status(const gpib_board_t *board)
 void ines_set_xfer_counter(struct ines_priv *priv, unsigned int count)
 {
 	if (count > 0xffff) {
-		pr_err("ines: bug! tried to set xfer counter > 0xffff\n");
+		pr_err("bug! tried to set xfer counter > 0xffff\n");
 		return;
 	}
 	ines_outb(priv, (count >> 8) & 0xff, XFER_COUNT_UPPER);
@@ -106,21 +110,18 @@ static ssize_t pio_read(gpib_board_t *board, struct ines_priv *ines_priv, uint8_
 					     num_in_fifo_bytes(ines_priv) ||
 					     test_bit(RECEIVED_END_BN, &nec_priv->state) ||
 					     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
-					     test_bit(TIMO_NUM, &board->status))) {
-			pr_warn("gpib: pio read wait interrupted\n");
+					     test_bit(TIMO_NUM, &board->status)))
 			return -ERESTARTSYS;
-		}
+
 		if (test_bit(TIMO_NUM, &board->status))
 			return -ETIMEDOUT;
 		if (test_bit(DEV_CLEAR_BN, &nec_priv->state))
 			return -EINTR;
 
 		num_fifo_bytes = num_in_fifo_bytes(ines_priv);
-		if (num_fifo_bytes + *nbytes > length)	{
-			pr_warn("ines: counter allowed %li extra byte(s)\n",
-				(long)(num_fifo_bytes - (length - *nbytes)));
+		if (num_fifo_bytes + *nbytes > length)
 			num_fifo_bytes = length - *nbytes;
-		}
+
 		for (i = 0; i < num_fifo_bytes; i++)
 			buffer[(*nbytes)++] = read_byte(nec_priv, DIR);
 		if (test_bit(RECEIVED_END_BN, &nec_priv->state) &&
@@ -201,10 +202,9 @@ static int ines_write_wait(gpib_board_t *board, struct ines_priv *ines_priv,
 				     num_out_fifo_bytes(ines_priv) < fifo_threshold ||
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib write interrupted\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		return -ERESTARTSYS;
-	}
+
 	if (test_bit(BUS_ERROR_BN, &nec_priv->state))
 		return -EIO;
 	if (test_bit(DEV_CLEAR_BN, &nec_priv->state))
@@ -301,7 +301,7 @@ irqreturn_t ines_interrupt(gpib_board_t *board)
 		wake++;
 	}
 	if (isr3_bits & FIFO_ERROR_BIT)
-		pr_err("ines gpib: fifo error\n");
+		dev_err(board->gpib_dev, "fifo error\n");
 	if (isr3_bits & XFER_COUNT_BIT)
 		wake++;
 
@@ -769,16 +769,16 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 		} while (1);
 	}
 	if (!ines_priv->pci_device) {
-		pr_err("gpib: could not find ines PCI board\n");
+		dev_err(board->gpib_dev, "could not find ines PCI board\n");
 		return -1;
 	}
 
 	if (pci_enable_device(ines_priv->pci_device)) {
-		pr_err("error enabling pci device\n");
+		dev_err(board->gpib_dev, "error enabling pci device\n");
 		return -1;
 	}
 
-	if (pci_request_regions(ines_priv->pci_device, "ines-gpib"))
+	if (pci_request_regions(ines_priv->pci_device, DRV_NAME))
 		return -1;
 	nec_priv->iobase = pci_resource_start(ines_priv->pci_device,
 					      found_id.gpib_region);
@@ -797,7 +797,7 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 	case PCI_CHIP_QUICKLOGIC5030:
 		break;
 	default:
-		pr_err("gpib: unspecified chip type? (bug)\n");
+		dev_err(board->gpib_dev, "unspecified chip type? (bug)\n");
 		nec_priv->iobase = 0;
 		pci_release_regions(ines_priv->pci_device);
 		return -1;
@@ -813,8 +813,8 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 #endif
 	isr_flags |= IRQF_SHARED;
 	if (request_irq(ines_priv->pci_device->irq, ines_pci_interrupt, isr_flags,
-			"pci-gpib", board)) {
-		pr_err("gpib: can't request IRQ %d\n", ines_priv->pci_device->irq);
+			DRV_NAME, board)) {
+		dev_err(board->gpib_dev, "can't request IRQ %d\n", ines_priv->pci_device->irq);
 		return -1;
 	}
 	ines_priv->irq = ines_priv->pci_device->irq;
@@ -846,7 +846,7 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 	case PCI_CHIP_QUICKLOGIC5030:
 		break;
 	default:
-		pr_err("gpib: unspecified chip type? (bug)\n");
+		dev_err(board->gpib_dev, "unspecified chip type? (bug)\n");
 		return -1;
 	}
 
@@ -899,15 +899,16 @@ int ines_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	ines_priv = board->private_data;
 	nec_priv = &ines_priv->nec7210_priv;
 
-	if (!request_region(config->ibbase, ines_isa_iosize, "ines_gpib")) {
-		pr_err("ines_gpib: ioports at 0x%x already in use\n", config->ibbase);
-		return -1;
+	if (!request_region(config->ibbase, ines_isa_iosize, DRV_NAME)) {
+		dev_err(board->gpib_dev, "ioports at 0x%x already in use\n",
+			config->ibbase);
+		return -EBUSY;
 	}
 	nec_priv->iobase = config->ibbase;
 	nec_priv->offset = 1;
 	nec7210_board_reset(nec_priv, board);
-	if (request_irq(config->ibirq, ines_pci_interrupt, isr_flags, "ines_gpib", board)) {
-		pr_err("ines_gpib: failed to allocate IRQ %d\n", config->ibirq);
+	if (request_irq(config->ibirq, ines_pci_interrupt, isr_flags, DRV_NAME, board)) {
+		dev_err(board->gpib_dev, "failed to allocate IRQ %d\n", config->ibirq);
 		return -1;
 	}
 	ines_priv->irq = config->ibirq;
@@ -988,13 +989,6 @@ static struct pci_driver ines_pci_driver = {
 #include <pcmcia/ds.h>
 #include <pcmcia/cisreg.h>
 
-#ifdef PCMCIA_DEBUG
-static int pc_debug = PCMCIA_DEBUG;
-#define DEBUG(n, args...) do {if (pc_debug > (n)) pr_debug(args)} while (0)
-#else
-#define DEBUG(args...)
-#endif
-
 static const int ines_pcmcia_iosize = 0x20;
 
 /*    The event() function is this driver's Card Services event handler.
@@ -1063,8 +1057,6 @@ static int ines_gpib_probe(struct pcmcia_device *link)
 
 //	int ret, i;
 
-	DEBUG(0, "%s(0x%p)\n", __func__ link);
-
 	/* Allocate space for private device-specific data */
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1098,8 +1090,6 @@ static void ines_gpib_remove(struct pcmcia_device *link)
 	struct local_info *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
-
 	if (info->dev)
 		ines_pcmcia_detach(info->dev);
 	ines_gpib_release(link);
@@ -1125,7 +1115,6 @@ static int ines_gpib_config(struct pcmcia_device *link)
 	void __iomem *virt;
 
 	dev = link->priv;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	retval = pcmcia_loop_config(link, &ines_gpib_config_iteration, NULL);
 	if (retval) {
@@ -1134,8 +1123,8 @@ static int ines_gpib_config(struct pcmcia_device *link)
 		return -ENODEV;
 	}
 
-	pr_debug("ines_cs: manufacturer: 0x%x card: 0x%x\n",
-		 link->manf_id, link->card_id);
+	dev_dbg(&link->dev, "ines_cs: manufacturer: 0x%x card: 0x%x\n",
+		link->manf_id, link->card_id);
 
 	/*  for the ines card we have to setup the configuration registers in
 	 *	attribute memory here
@@ -1167,7 +1156,6 @@ static int ines_gpib_config(struct pcmcia_device *link)
 		ines_gpib_release(link);
 		return -ENODEV;
 	}
-	pr_info("ines gpib device loaded\n");
 	return 0;
 } /* gpib_config */
 
@@ -1179,7 +1167,6 @@ static int ines_gpib_config(struct pcmcia_device *link)
 
 static void ines_gpib_release(struct pcmcia_device *link)
 {
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 	pcmcia_disable_device(link);
 } /* gpib_release */
 
@@ -1187,10 +1174,9 @@ static int ines_gpib_suspend(struct pcmcia_device *link)
 {
 	//struct local_info *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	if (link->open)
-		pr_err("Device still open ???\n");
+		dev_err(&link->dev, "Device still open\n");
 	//netif_device_detach(dev);
 
 	return 0;
@@ -1200,11 +1186,9 @@ static int ines_gpib_resume(struct pcmcia_device *link)
 {
 	//struct local_info_t *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	/*if (link->open) {
 	 *	ni_gpib_probe(dev);	/ really?
-	 *		printk("Gpib resumed ???\n");
 	 *	//netif_device_attach(dev);
 	 *}
 	 */
@@ -1229,7 +1213,6 @@ static struct pcmcia_driver ines_gpib_cs_driver = {
 
 void ines_pcmcia_cleanup_module(void)
 {
-	DEBUG(0, "ines_cs: unloading\n");
 	pcmcia_unregister_driver(&ines_gpib_cs_driver);
 }
 
@@ -1331,7 +1314,7 @@ int ines_common_pcmcia_attach(gpib_board_t *board)
 	int retval;
 
 	if (!curr_dev) {
-		pr_err("no ines pcmcia cards found\n");
+		dev_err(board->gpib_dev, "no ines pcmcia cards found\n");
 		return -1;
 	}
 
@@ -1343,9 +1326,9 @@ int ines_common_pcmcia_attach(gpib_board_t *board)
 	nec_priv = &ines_priv->nec7210_priv;
 
 	if (!request_region(curr_dev->resource[0]->start,
-			    resource_size(curr_dev->resource[0]), "ines_gpib")) {
-		pr_err("ines_gpib: ioports at 0x%lx already in use\n",
-		       (unsigned long)(curr_dev->resource[0]->start));
+			    resource_size(curr_dev->resource[0]), DRV_NAME)) {
+		dev_err(board->gpib_dev, "ioports at 0x%lx already in use\n",
+			(unsigned long)(curr_dev->resource[0]->start));
 		return -1;
 	}
 
@@ -1355,7 +1338,7 @@ int ines_common_pcmcia_attach(gpib_board_t *board)
 
 	if (request_irq(curr_dev->irq, ines_pcmcia_interrupt, IRQF_SHARED,
 			"pcmcia-gpib", board))	{
-		pr_err("gpib: can't request IRQ %d\n", curr_dev->irq);
+		dev_err(board->gpib_dev, "can't request IRQ %d\n", curr_dev->irq);
 		return -1;
 	}
 	ines_priv->irq = curr_dev->irq;
@@ -1418,56 +1401,56 @@ static int __init ines_init_module(void)
 
 	ret = pci_register_driver(&ines_pci_driver);
 	if (ret) {
-		pr_err("ines_gpib: pci_register_driver failed: error = %d\n", ret);
+		pr_err("pci_register_driver failed: error = %d\n", ret);
 		return ret;
 	}
 
 	ret = gpib_register_driver(&ines_pci_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("ines_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pci;
 	}
 
 	ret = gpib_register_driver(&ines_pci_unaccel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("ines_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pci_unaccel;
 	}
 
 	ret = gpib_register_driver(&ines_pci_accel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("ines_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pci_accel;
 	}
 
 	ret = gpib_register_driver(&ines_isa_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("ines_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_isa;
 	}
 
 #ifdef CONFIG_GPIB_PCMCIA
 	ret = gpib_register_driver(&ines_pcmcia_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("ines_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pcmcia;
 	}
 
 	ret = gpib_register_driver(&ines_pcmcia_unaccel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("ines_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pcmcia_unaccel;
 	}
 
 	ret = gpib_register_driver(&ines_pcmcia_accel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("ines_gpib: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pcmcia_accel;
 	}
 
 	ret = pcmcia_register_driver(&ines_gpib_cs_driver);
 	if (ret) {
-		pr_err("ines_gpib: pcmcia_register_driver failed: error = %d\n", ret);
+		pr_err("pcmcia_register_driver failed: error = %d\n", ret);
 		goto err_pcmcia_driver;
 	}
 #endif
-- 
2.48.1


