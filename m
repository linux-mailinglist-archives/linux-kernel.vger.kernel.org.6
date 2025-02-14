Return-Path: <linux-kernel+bounces-514876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFA7A35CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972EB3AE271
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69882066D8;
	Fri, 14 Feb 2025 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZXIEqHb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1B263C83
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533660; cv=none; b=eVi80Jy4kbyvuAcahH+6G/PRMDS1VKFc4x/VZW32H8qHAum8DEFdccv8De9/jqauYC2AVtmnD2u0HE8e5xbwkVgTVfGhXnksTr8jvUM7rnKANVSZRd20SknGlKg3JOQRw6+I9VHtO0n0lHKijWbwYXp4E4uiW7hImteQlZBe5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533660; c=relaxed/simple;
	bh=X+nJhhbvM7TnzxSU0DL7DSyPTH6mocEcz+Fkw0E2sKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF1tR6imVMUhXKv5JOUbFKFubg16EFLZLjUZRsfupaN96RBMn2mYdcmIDLjMKj65I1srVPRe5OQjIhfx07YODndmoDZI+93jD8QNSPM9VarmQouaTcgDXVdgci2Q7PTndWq/KGKskOCWxtvTRbHJALaFUOHeLneiP0Ud7zJTioM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZXIEqHb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43690d4605dso12618855e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533656; x=1740138456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a7gByrXb25kpqHP6rNbVvJB6IRS3q8+97gsHt/ID/M=;
        b=WZXIEqHbewyZolapbisTWuqbOXbVr4qEYzGIoJ8zCPyLJLwOSKDShdK56VY12UgIO6
         dG3lwkhM77Uukr8F5+eQkqKaLi3iaQIipl0vFfVpEbmQUkmfgofBMVllgMD/8ddKU9g2
         WeN5I8lJngrsGDI+HXTAiQ2N4eREelv+N8zYLuNRKejzEWdkTiOcfTs1s11nXOQO6FIq
         cUSsOHbKqTAw77QgX+l27yKxemu7QrbqaQM6cv29LQQ1lLTxMqSaW2EhA0SpSXF3oyAY
         dtos/qzWK1RISJiR7IDk9PLOsG2efl8pWbWkMWKpNXywJeMTLhie5y8kTOC/jULtu6fH
         GkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533656; x=1740138456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4a7gByrXb25kpqHP6rNbVvJB6IRS3q8+97gsHt/ID/M=;
        b=v5SGxq5m1hNh8MxsSHMIiyKLoCP5POUFbIVRDHzE0J8tnj285MD5lfkgUX6jsnrGgU
         BnR1be4mvwNr0ZtKeNQPkKGA14x8Uk1tHz3zUG77JUuxj0tYOdJZXEbA1qsVzEthWzEP
         xpT4pn0qfZnwEcD1drrue5B+1mFavRJ4cnvKaabEy6X9/2PEMNmVsQU9ZIMTQeduJ4K0
         lEsewmchJsNo0eBgmxtAizOK4pG95+L4gIITPT3IxwgmpQFBRbvva5cymyLIyQQSI2ao
         dS3c+Fen99luAvm/nQb3g+PQGQ0AvmMnNaT/4AyGKlAVM5xJWYWzbK3AACVHt/u8XM2p
         MBsA==
X-Forwarded-Encrypted: i=1; AJvYcCXV/4kbvzi5a7hQeBOt2lmMLwMRnDHRdf/mrL7z8fx7luYM/MEoexSgeiHbHYns91LWOO4K87KafsPxQ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEjrblj5a3w4ZUjrJWZ970o0F0r5sQOalQltyUj+0nRgfVN7P
	E2wmz2BWLTZKWxscoY0cnyRleYxF8typfKFfBXw+Pt8QLPnkLFeT
X-Gm-Gg: ASbGncse5EwJfhwD8y72bnEeumHK6Zvn9Mb6q9CKmdH0ZgQbrq1gxD2Ic/VvV1BdpZG
	nfjJixOsgT+WM94M+zFfPmwInnTILvaB2xoBQAZoEwMmxZqi7ct99VBmz2M498pocONyrMd4CsA
	Q3JhjBzIbO1RDVXCoz5akBt/HfgAcMgQLkBmr8sIbwTV5SyDdKPLe2XkcBUADezJdfuDAYffrwR
	MYZWPM4VP/K/pcRRSnrCAY5/Am0N9Uq2zkCJxc47Q5/V4xkeaJJJYcoGPzY4xlXv0R64AIQz4os
	57AnugVLxoSUYG+CE65RTOVGQHMcANoeXjpQTkmWkE6KATFyl+E=
X-Google-Smtp-Source: AGHT+IE1AeZVoiLEXdqP4+VloGplXVda2AU8DFuNHD7oIH58wW4sEZXJ6ziiXtNQ7i7ywiZ4PpFKaA==
X-Received: by 2002:a05:600c:34cc:b0:439:4376:cc0 with SMTP id 5b1f17b1804b1-439601a9011mr77141425e9.25.1739533656221;
        Fri, 14 Feb 2025 03:47:36 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:35 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 03/17] staging: gpib: cb7210 console messaging cleanup
Date: Fri, 14 Feb 2025 12:46:54 +0100
Message-ID: <20250214114708.28947-4-dpenkler@gmail.com>
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
string "cb7210" everywhere.

Remove "cb7210:" string prefix in messages since module name
printing is enabled.

Change pr_err to dev_err where possible.

Remove interrupt warnings.

Return consistent error codes with error messages:
  -EBUSY when resources are busy
  -ENODEV when device is not present
  -EIO for others.

Return -ENOMEM for failed kmalloc (no message in driver)

Remove PCMCIA debug comments, PCMCIA_DEBUG conditional compilation
symbol, the DEBUG macro definition and its uses.

Change pr_warn to dev_warn and pr_err to dev_err where possible.

Remove commented printk.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/cb7210/cb7210.c | 133 +++++++++++----------------
 1 file changed, 52 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index cb0d8a721687..f2afd851682e 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -5,6 +5,10 @@
  *    copyright            : (C) 2001, 2002 by Frank Mori Hess
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include "cb7210.h"
 #include <linux/ioport.h>
 #include <linux/sched.h>
@@ -83,12 +87,12 @@ static int fifo_read(gpib_board_t *board, struct cb7210_priv *cb_priv, uint8_t *
 
 	*bytes_read = 0;
 	if (cb_priv->fifo_iobase == 0)	{
-		pr_err("cb7210: fifo iobase is zero!\n");
+		dev_err(board->gpib_dev, "fifo iobase is zero!\n");
 		return -EIO;
 	}
 	*end = 0;
 	if (length <= cb7210_fifo_size)	{
-		pr_err("cb7210: bug! %s with length < fifo size\n", __func__);
+		dev_err(board->gpib_dev, " bug! fifo read length < fifo size\n");
 		return -EINVAL;
 	}
 
@@ -103,7 +107,6 @@ static int fifo_read(gpib_board_t *board, struct cb7210_priv *cb_priv, uint8_t *
 					     test_bit(RECEIVED_END_BN, &nec_priv->state) ||
 					     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 					     test_bit(TIMO_NUM, &board->status))) {
-			pr_warn("cb7210: fifo half full wait interrupted\n");
 			retval = -ERESTARTSYS;
 			nec7210_set_reg_bits(nec_priv, IMR2, HR_DMAI, 0);
 			break;
@@ -153,7 +156,6 @@ static int fifo_read(gpib_board_t *board, struct cb7210_priv *cb_priv, uint8_t *
 				     test_bit(RECEIVED_END_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		pr_warn("cb7210: fifo half full wait interrupted\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -188,7 +190,6 @@ static int cb7210_accel_read(gpib_board_t *board, uint8_t *buffer,
 				     test_bit(READ_READY_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		pr_warn("cb7210: read ready wait interrupted\n");
 		return -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -274,7 +275,7 @@ static int fifo_write(gpib_board_t *board, uint8_t *buffer, size_t length, size_
 
 	*bytes_written = 0;
 	if (cb_priv->fifo_iobase == 0) {
-		pr_err("cb7210: fifo iobase is zero!\n");
+		dev_err(board->gpib_dev, "fifo iobase is zero!\n");
 		return -EINVAL;
 	}
 	if (length == 0)
@@ -293,7 +294,6 @@ static int fifo_write(gpib_board_t *board, uint8_t *buffer, size_t length, size_
 					     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 					     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 					     test_bit(TIMO_NUM, &board->status))) {
-			pr_warn("cb7210: fifo wait interrupted\n");
 			retval = -ERESTARTSYS;
 			break;
 		}
@@ -309,7 +309,7 @@ static int fifo_write(gpib_board_t *board, uint8_t *buffer, size_t length, size_
 		if (num_bytes + count > length)
 			num_bytes = length - count;
 		if (num_bytes % cb7210_fifo_width) {
-			pr_err("cb7210: bug! %s with odd number of bytes\n", __func__);
+			dev_err(board->gpib_dev, " bug! fifo write with odd number of bytes\n");
 			retval = -EINVAL;
 			break;
 		}
@@ -334,7 +334,6 @@ static int fifo_write(gpib_board_t *board, uint8_t *buffer, size_t length, size_
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		pr_err("cb7210: wait for last byte interrupted\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -482,7 +481,7 @@ static irqreturn_t cb7210_internal_interrupt(gpib_board_t *board)
 	status2 = read_byte(nec_priv, ISR2);
 	nec7210_interrupt_have_status(board, nec_priv, status1, status2);
 
-	dev_dbg(board->gpib_dev, "cb7210: status 0x%x, mode 0x%x\n", hs_status, priv->hs_mode_bits);
+	dev_dbg(board->gpib_dev, "status 0x%x, mode 0x%x\n", hs_status, priv->hs_mode_bits);
 
 	clear_bits = 0;
 
@@ -860,7 +859,7 @@ static int cb7210_allocate_private(gpib_board_t *board)
 
 	board->private_data = kmalloc(sizeof(struct cb7210_priv), GFP_KERNEL);
 	if (!board->private_data)
-		return -1;
+		return -ENOMEM;
 	priv = board->private_data;
 	memset(priv, 0, sizeof(struct cb7210_priv));
 	init_nec7210_private(&priv->nec7210_priv);
@@ -922,7 +921,7 @@ static int cb7210_init(struct cb7210_priv *cb_priv, gpib_board_t *board)
 
 	/* poll so we can detect assertion of ATN */
 	if (gpib_request_pseudo_irq(board, cb_pci_interrupt)) {
-		pr_err("pc2_gpib: failed to allocate pseudo_irq\n");
+		pr_err("failed to allocate pseudo_irq\n");
 		return -1;
 	}
 	return 0;
@@ -962,17 +961,17 @@ static int cb_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		}
 	}
 	if (!cb_priv->pci_device) {
-		pr_warn("cb7210: no supported boards found.\n");
-		return -1;
+		dev_err(board->gpib_dev, "no supported boards found.\n");
+		return -ENODEV;
 	}
 
 	if (pci_enable_device(cb_priv->pci_device)) {
-		pr_err("cb7210: error enabling pci device\n");
-		return -1;
+		dev_err(board->gpib_dev, "error enabling pci device\n");
+		return -EIO;
 	}
 
-	if (pci_request_regions(cb_priv->pci_device, "cb7210"))
-		return -1;
+	if (pci_request_regions(cb_priv->pci_device, DRV_NAME))
+		return -EBUSY;
 	switch (cb_priv->pci_chip) {
 	case PCI_CHIP_AMCC_S5933:
 		cb_priv->amcc_iobase = pci_resource_start(cb_priv->pci_device, 0);
@@ -984,13 +983,14 @@ static int cb_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		cb_priv->fifo_iobase = nec_priv->iobase;
 		break;
 	default:
-		pr_err("cb7210: bug! unhandled pci_chip=%i\n", cb_priv->pci_chip);
+		dev_err(board->gpib_dev, "bug! unhandled pci_chip=%i\n", cb_priv->pci_chip);
 		return -EIO;
 	}
 	isr_flags |= IRQF_SHARED;
-	if (request_irq(cb_priv->pci_device->irq, cb_pci_interrupt, isr_flags, "cb7210", board)) {
-		pr_err("cb7210: can't request IRQ %d\n", cb_priv->pci_device->irq);
-		return -1;
+	if (request_irq(cb_priv->pci_device->irq, cb_pci_interrupt, isr_flags, DRV_NAME, board)) {
+		dev_err(board->gpib_dev, "can't request IRQ %d\n",
+			cb_priv->pci_device->irq);
+		return -EBUSY;
 	}
 	cb_priv->irq = cb_priv->pci_device->irq;
 
@@ -1045,20 +1045,22 @@ static int cb_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		return retval;
 	cb_priv = board->private_data;
 	nec_priv = &cb_priv->nec7210_priv;
-	if (!request_region(config->ibbase, cb7210_iosize, "cb7210")) {
-		pr_err("gpib: ioports starting at 0x%x are already in use\n", config->ibbase);
-		return -EIO;
+	if (!request_region(config->ibbase, cb7210_iosize, DRV_NAME)) {
+		dev_err(board->gpib_dev, "ioports starting at 0x%x are already in use\n",
+			config->ibbase);
+		return -EBUSY;
 	}
 	nec_priv->iobase = config->ibbase;
 	cb_priv->fifo_iobase = nec7210_iobase(cb_priv);
 
 	bits = irq_bits(config->ibirq);
 	if (bits == 0)
-		pr_err("board incapable of using irq %i, try 2-5, 7, 10, or 11\n", config->ibirq);
+		dev_err(board->gpib_dev, "board incapable of using irq %i, try 2-5, 7, 10, or 11\n",
+			config->ibirq);
 
 	// install interrupt handler
-	if (request_irq(config->ibirq, cb7210_interrupt, isr_flags, "cb7210", board)) {
-		pr_err("gpib: can't request IRQ %d\n", config->ibirq);
+	if (request_irq(config->ibirq, cb7210_interrupt, isr_flags, DRV_NAME, board)) {
+		dev_err(board->gpib_dev, "failed to obtain IRQ %d\n", config->ibirq);
 		return -EBUSY;
 	}
 	cb_priv->irq = config->ibirq;
@@ -1098,7 +1100,7 @@ static const struct pci_device_id cb7210_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, cb7210_pci_table);
 
 static struct pci_driver cb7210_pci_driver = {
-	.name = "cb7210",
+	.name = DRV_NAME,
 	.id_table = cb7210_pci_table,
 	.probe = &cb7210_pci_probe
 };
@@ -1121,23 +1123,6 @@ static struct pci_driver cb7210_pci_driver = {
 #include <pcmcia/cistpl.h>
 #include <pcmcia/ds.h>
 
-/*
- * All the PCMCIA modules use PCMCIA_DEBUG to control debugging.  If
- * you do not define PCMCIA_DEBUG at all, all the debug code will be
- * left out.  If you compile with PCMCIA_DEBUG=0, the debug code will
- * be present but disabled -- but it can then be enabled for specific
- * modules at load time with a 'pc_debug=#' option to insmod.
- */
-
-#define PCMCIA_DEBUG 1
-
-#ifdef PCMCIA_DEBUG
-static int pc_debug = PCMCIA_DEBUG;
-#define DEBUG(n, args...) do {if (pc_debug > (n)) pr_debug(args); } while (0)
-#else
-#define DEBUG(args...)
-#endif
-
 /*
  * The event() function is this driver's Card Services event handler.
  * It will be called by Card Services when an appropriate card status
@@ -1202,8 +1187,6 @@ static int cb_gpib_probe(struct pcmcia_device *link)
 
 //	int ret, i;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
-
 	/* Allocate space for private device-specific data */
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1243,8 +1226,6 @@ static void cb_gpib_remove(struct pcmcia_device *link)
 	struct local_info *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
-
 	if (info->dev)
 		cb_pcmcia_detach(info->dev);
 	cb_gpib_release(link);
@@ -1272,7 +1253,6 @@ static int cb_gpib_config(struct pcmcia_device  *link)
 
 	handle = link;
 	dev = link->priv;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	retval = pcmcia_loop_config(link, &cb_gpib_config_iteration, NULL);
 	if (retval) {
@@ -1281,8 +1261,6 @@ static int cb_gpib_config(struct pcmcia_device  *link)
 		return -ENODEV;
 	}
 
-	DEBUG(0, "gpib_cs: manufacturer: 0x%x card: 0x%x\n", link->manf_id, link->card_id);
-
 	/*
 	 *  This actually configures the PCMCIA socket -- setting up
 	 *  the I/O windows and the interrupt mapping.
@@ -1294,7 +1272,6 @@ static int cb_gpib_config(struct pcmcia_device  *link)
 		return -ENODEV;
 	}
 
-	pr_info("gpib device loaded\n");
 	return 0;
 } /* gpib_config */
 
@@ -1306,7 +1283,6 @@ static int cb_gpib_config(struct pcmcia_device  *link)
 
 static void cb_gpib_release(struct pcmcia_device *link)
 {
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 	pcmcia_disable_device(link);
 }
 
@@ -1314,10 +1290,9 @@ static int cb_gpib_suspend(struct pcmcia_device *link)
 {
 	//struct local_info *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	if (link->open)
-		pr_warn("Device still open ???\n");
+		dev_warn(&link->dev, "Device still open\n");
 	//netif_device_detach(dev);
 
 	return 0;
@@ -1327,11 +1302,9 @@ static int cb_gpib_resume(struct pcmcia_device *link)
 {
 	//struct local_info *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	/*if (link->open) {
 	 *	ni_gpib_probe(dev);	/ really?
-	 *	printk("Gpib resumed ???\n");
 	 *	//netif_device_attach(dev);
 	 *
 	 */
@@ -1358,7 +1331,6 @@ static struct pcmcia_driver cb_gpib_cs_driver = {
 
 static void cb_pcmcia_cleanup_module(void)
 {
-	DEBUG(0, "cb_gpib_cs: unloading\n");
 	pcmcia_unregister_driver(&cb_gpib_cs_driver);
 }
 
@@ -1453,8 +1425,8 @@ static int cb_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
 	int retval;
 
 	if (!curr_dev) {
-		pr_err("no cb pcmcia cards found\n");
-		return -1;
+		dev_err(board->gpib_dev, "no cb pcmcia cards found\n");
+		return -ENODEV;
 	}
 
 	retval = cb7210_generic_attach(board);
@@ -1465,18 +1437,17 @@ static int cb_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
 	nec_priv = &cb_priv->nec7210_priv;
 
 	if (!request_region(curr_dev->resource[0]->start, resource_size(curr_dev->resource[0]),
-			    "cb7210"))	{
-		pr_err("gpib: ioports starting at 0x%lx are already in use\n",
-		       (unsigned long)curr_dev->resource[0]->start);
-		return -EIO;
+			    DRV_NAME))	{
+		dev_err(board->gpib_dev, "ioports starting at 0x%lx are already in use\n",
+			(unsigned long)curr_dev->resource[0]->start);
+		return -EBUSY;
 	}
 	nec_priv->iobase = curr_dev->resource[0]->start;
 	cb_priv->fifo_iobase = curr_dev->resource[0]->start;
 
-	if (request_irq(curr_dev->irq, cb7210_interrupt, IRQF_SHARED,
-			"cb7210", board)) {
-		pr_err("cb7210: failed to request IRQ %d\n", curr_dev->irq);
-		return -1;
+	if (request_irq(curr_dev->irq, cb7210_interrupt, IRQF_SHARED, DRV_NAME, board)) {
+		dev_err(board->gpib_dev, "failed to request IRQ %d\n", curr_dev->irq);
+		return -EBUSY;
 	}
 	cb_priv->irq = curr_dev->irq;
 
@@ -1509,68 +1480,68 @@ static int __init cb7210_init_module(void)
 
 	ret = pci_register_driver(&cb7210_pci_driver);
 	if (ret) {
-		pr_err("cb7210: pci_register_driver failed: error = %d\n", ret);
+		pr_err("pci_register_driver failed: error = %d\n", ret);
 		return ret;
 	}
 
 	ret = gpib_register_driver(&cb_pci_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pci;
 	}
 
 	ret = gpib_register_driver(&cb_isa_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_isa;
 	}
 
 	ret = gpib_register_driver(&cb_pci_accel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pci_accel;
 	}
 
 	ret = gpib_register_driver(&cb_pci_unaccel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pci_unaccel;
 	}
 
 	ret = gpib_register_driver(&cb_isa_accel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_isa_accel;
 	}
 
 	ret = gpib_register_driver(&cb_isa_unaccel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_isa_unaccel;
 	}
 
 #ifdef CONFIG_GPIB_PCMCIA
 	ret = gpib_register_driver(&cb_pcmcia_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pcmcia;
 	}
 
 	ret = gpib_register_driver(&cb_pcmcia_accel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pcmcia_accel;
 	}
 
 	ret = gpib_register_driver(&cb_pcmcia_unaccel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("cb7210: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		goto err_pcmcia_unaccel;
 	}
 
 	ret = pcmcia_register_driver(&cb_gpib_cs_driver);
 	if (ret) {
-		pr_err("cb7210: pcmcia_register_driver failed: error = %d\n", ret);
+		pr_err("pcmcia_register_driver failed: error = %d\n", ret);
 		goto err_pcmcia_driver;
 	}
 #endif
-- 
2.48.1


