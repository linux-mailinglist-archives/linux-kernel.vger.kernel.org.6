Return-Path: <linux-kernel+bounces-523247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F6A3D431
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E64189A8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A71A1EDA11;
	Thu, 20 Feb 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKwwN7Yd"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471821E9B30
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042580; cv=none; b=E/0kXI5Q2Y5NwFkCZxQrqwFmjn/aRC/vXQgsNjXGnvdkBT7z+MtM8dm+rnDrfiUH8I/keh1/R2Ligzmo3Hwda6nJh89KoPuWHglw7JcH9ihPRmUIVktX3PaRlxn0YCUfMsZvZqfQi7nvcPx8H+WMVPORj7IQB2864OnOdUydwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042580; c=relaxed/simple;
	bh=3mw368AGXqTIch42iSje3cBo5seDZ2HRoDXj8WZN6Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3qSw3gvjUyALhlCt2/kIlaB9iHsPf1BeXkfoI4A94yxwQfmmBySIgSx6OXfrYbNRhsF7f83LaoachqstLu6l2mhmJwl8UPYhNmowD8oPnEu5is2sqM/eFEJ+hcpSx9RnY9XR1sm/4xUST2Itun+ZeV+iPoM5T+YTDLeotfCRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKwwN7Yd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso3822425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740042576; x=1740647376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZEonrFTWZC0/wzk+mguJHa9QjuXrPOV/acUCVXwfDA=;
        b=JKwwN7YdAWloFJEVSYm9ak0ry2YzUE4+l+blfDk+2k7ARqSCQIBfX8zF6hTZPqFi3C
         5rh1ZKPAPxaUmyBE/CFy6KZ3QY4B6IPmo+uLMte8S7AYGFoPGVKL1D9y1IoaJpPVCgWa
         8xg9VJQ7TtRBBP19Q0jPDAa7w++tjd1W3s54YfurbKkvSQFyNFozxzZL9bJCdmEs6Fp5
         a7rdUIdNLveB4ThvusghF1lcHXcArpA5dXT55pdgpZsJmOjs0Way/Pc0vkMdp6TXXbP5
         NuQnMewd2Zfs/vePhd+o+nCpstET2MmZ6uqJTnjy6c1B6kt0bGMnDCoeREtlCVyU1LNy
         V3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740042576; x=1740647376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZEonrFTWZC0/wzk+mguJHa9QjuXrPOV/acUCVXwfDA=;
        b=ERcW89Vr3HsQ2axnQnnntm8jQyyUHAO2DLbzcawvqjcuEO0+WXNuoPCnAk0rYpFEJS
         F5AESTcOxTq2go3Su+BZs7XqDfvWhPz3iPgGeMAbMoFkq7+T17t6UIIOgx4xx/HHFjfD
         vZpfrgsl/GEiG1PxmYnhM2TLZAZDJTATYoKHPINS2mlMujpi6rZHS9zT/s00NhKmVEFO
         xWZa5mMOexLbJzWgr2nVD3bXrj4/n9O8vcRG9mXUObnh0tjGeB2tSw0v/ixAwC/PakXy
         7QMFG71lCUN8FzdUNwxQrknWvosEk1er9q2q7rIGEhwZ4MY9AwkmQuXmimKL9XkSgew1
         h1jw==
X-Forwarded-Encrypted: i=1; AJvYcCXEDBe5iyEl22BHgkfuXJjr9JjHm3mpe7lP/9vYOalgPXAXCaIw9ScIKGRWZaBUagVRxU5rqrN+MrdzHwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnA7TmJTrtegwjUStAayQ8axUKjGTboPBBFQMvRyMYVvr/yg8
	C0Vs+L+BJYtZvW9R+P1UfRG/H9N2lYgWCD417QgV7+7X2uirOz4p
X-Gm-Gg: ASbGncs5+jwZbYc2uZRrVJSRsNlOoeBGXOQJN/BuK7rENTMxCBYcMI0qB/CogYP+rqO
	jqBeVgS0xUCBF7c1y1F5biBVgkw7GLuQE+7Wrj6BikVs2Qed3C5vdmmjR2g9gdbJDlrwFnEg5Fz
	6jSfFj5xDyVKSY9/Y4pNf6hIQmxfvs1nBJ5kfpS+1r4cuu+uQa4qxKhBlnEF+6wgj+IFwqv8oZJ
	3TRyPZDViwnprMEWb75T4ghNCaBefvz2edpt+AkUh9PSE2YFSug92T1ffOpNWbJxzph3Ar0YPFF
	m+k63I2qoDd86KFGEUTC9IznApQBI9cGqajVZMZv+6MV4tPQZTs=
X-Google-Smtp-Source: AGHT+IFemaY6KW5kqAH8qxsDWz7jPHuK4AaSqRKmljLKaqd+DR0sOPh+xFT4T8/hkx8EZ+o+Zb2nSA==
X-Received: by 2002:a5d:5885:0:b0:38d:d99d:d221 with SMTP id ffacd0b85a97d-38f33f3750fmr18352374f8f.1.1740042576341;
        Thu, 20 Feb 2025 01:09:36 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa2dsm19807960f8f.101.2025.02.20.01.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:09:35 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 11/17 V2] staging: gpib: ines console messaging cleanup
Date: Thu, 20 Feb 2025 10:09:19 +0100
Message-ID: <20250220090920.32497-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220090920.32497-1-dpenkler@gmail.com>
References: <20250220090920.32497-1-dpenkler@gmail.com>
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
V1->V2 Rebase to staging-testing
commit bedc7002f797 ("staging: gpib: ines: remove unused variable")

 drivers/staging/gpib/ines/ines_gpib.c | 101 +++++++++++---------------
 1 file changed, 42 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index b9abb2dfa4f3..56da6cd91188 100644
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
@@ -54,7 +58,7 @@ int ines_line_status(const gpib_board_t *board)
 void ines_set_xfer_counter(struct ines_priv *priv, unsigned int count)
 {
 	if (count > 0xffff) {
-		pr_err("ines: bug! tried to set xfer counter > 0xffff\n");
+		pr_err("bug! tried to set xfer counter > 0xffff\n");
 		return;
 	}
 	ines_outb(priv, (count >> 8) & 0xff, XFER_COUNT_UPPER);
@@ -104,21 +108,18 @@ static ssize_t pio_read(gpib_board_t *board, struct ines_priv *ines_priv, uint8_
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
@@ -199,10 +200,9 @@ static int ines_write_wait(gpib_board_t *board, struct ines_priv *ines_priv,
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
@@ -299,7 +299,7 @@ irqreturn_t ines_interrupt(gpib_board_t *board)
 		wake++;
 	}
 	if (isr3_bits & FIFO_ERROR_BIT)
-		pr_err("ines gpib: fifo error\n");
+		dev_err(board->gpib_dev, "fifo error\n");
 	if (isr3_bits & XFER_COUNT_BIT)
 		wake++;
 
@@ -767,16 +767,16 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
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
@@ -795,7 +795,7 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 	case PCI_CHIP_QUICKLOGIC5030:
 		break;
 	default:
-		pr_err("gpib: unspecified chip type? (bug)\n");
+		dev_err(board->gpib_dev, "unspecified chip type? (bug)\n");
 		nec_priv->iobase = 0;
 		pci_release_regions(ines_priv->pci_device);
 		return -1;
@@ -811,8 +811,8 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
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
@@ -844,7 +844,7 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 	case PCI_CHIP_QUICKLOGIC5030:
 		break;
 	default:
-		pr_err("gpib: unspecified chip type? (bug)\n");
+		dev_err(board->gpib_dev, "unspecified chip type? (bug)\n");
 		return -1;
 	}
 
@@ -897,15 +897,16 @@ int ines_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
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
@@ -986,13 +987,6 @@ static struct pci_driver ines_pci_driver = {
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
@@ -1061,8 +1055,6 @@ static int ines_gpib_probe(struct pcmcia_device *link)
 
 //	int ret, i;
 
-	DEBUG(0, "%s(0x%p)\n", __func__ link);
-
 	/* Allocate space for private device-specific data */
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1096,8 +1088,6 @@ static void ines_gpib_remove(struct pcmcia_device *link)
 	struct local_info *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
-
 	if (info->dev)
 		ines_pcmcia_detach(info->dev);
 	ines_gpib_release(link);
@@ -1123,7 +1113,6 @@ static int ines_gpib_config(struct pcmcia_device *link)
 	void __iomem *virt;
 
 	dev = link->priv;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	retval = pcmcia_loop_config(link, &ines_gpib_config_iteration, NULL);
 	if (retval) {
@@ -1132,8 +1121,8 @@ static int ines_gpib_config(struct pcmcia_device *link)
 		return -ENODEV;
 	}
 
-	pr_debug("ines_cs: manufacturer: 0x%x card: 0x%x\n",
-		 link->manf_id, link->card_id);
+	dev_dbg(&link->dev, "ines_cs: manufacturer: 0x%x card: 0x%x\n",
+		link->manf_id, link->card_id);
 
 	/*  for the ines card we have to setup the configuration registers in
 	 *	attribute memory here
@@ -1165,7 +1154,6 @@ static int ines_gpib_config(struct pcmcia_device *link)
 		ines_gpib_release(link);
 		return -ENODEV;
 	}
-	pr_info("ines gpib device loaded\n");
 	return 0;
 } /* gpib_config */
 
@@ -1177,7 +1165,6 @@ static int ines_gpib_config(struct pcmcia_device *link)
 
 static void ines_gpib_release(struct pcmcia_device *link)
 {
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 	pcmcia_disable_device(link);
 } /* gpib_release */
 
@@ -1185,10 +1172,9 @@ static int ines_gpib_suspend(struct pcmcia_device *link)
 {
 	//struct local_info *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	if (link->open)
-		pr_err("Device still open ???\n");
+		dev_err(&link->dev, "Device still open\n");
 	//netif_device_detach(dev);
 
 	return 0;
@@ -1198,11 +1184,9 @@ static int ines_gpib_resume(struct pcmcia_device *link)
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
@@ -1227,7 +1211,6 @@ static struct pcmcia_driver ines_gpib_cs_driver = {
 
 void ines_pcmcia_cleanup_module(void)
 {
-	DEBUG(0, "ines_cs: unloading\n");
 	pcmcia_unregister_driver(&ines_gpib_cs_driver);
 }
 
@@ -1329,7 +1312,7 @@ int ines_common_pcmcia_attach(gpib_board_t *board)
 	int retval;
 
 	if (!curr_dev) {
-		pr_err("no ines pcmcia cards found\n");
+		dev_err(board->gpib_dev, "no ines pcmcia cards found\n");
 		return -1;
 	}
 
@@ -1341,9 +1324,9 @@ int ines_common_pcmcia_attach(gpib_board_t *board)
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
 
@@ -1353,7 +1336,7 @@ int ines_common_pcmcia_attach(gpib_board_t *board)
 
 	if (request_irq(curr_dev->irq, ines_pcmcia_interrupt, IRQF_SHARED,
 			"pcmcia-gpib", board))	{
-		pr_err("gpib: can't request IRQ %d\n", curr_dev->irq);
+		dev_err(board->gpib_dev, "can't request IRQ %d\n", curr_dev->irq);
 		return -1;
 	}
 	ines_priv->irq = curr_dev->irq;
@@ -1416,56 +1399,56 @@ static int __init ines_init_module(void)
 
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


