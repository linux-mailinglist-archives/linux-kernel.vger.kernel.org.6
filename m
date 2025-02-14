Return-Path: <linux-kernel+bounces-514890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC54A35CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7863AFD9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C019C266B7B;
	Fri, 14 Feb 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh3FVwl8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED6266566
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533680; cv=none; b=s4d5GdmiX4qhqrsz6WoiVLTMvuf1H9UEGC8XQixIXtkyfrmEzfcd7OYPErcLNcj0pSY7FUUkDm1x0p2o5gTaL83Y2ZstP0Z+ZNNLu2EE2dGYOcgrM+KKflQPvcebnnLAu+DBcqEjf92/KNGQczzB6KhdTkd2lPnF0mn5wtOFvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533680; c=relaxed/simple;
	bh=oJGclg8ugMOnXh+x9a8uPraI1Lb09cPGaGm5NxC8nsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r68yieLmeOKrPzoBdL9KhtCuDapOql36/onTt3/u4ItHPkDe/uvhGgZ3i5gHlEAnGAtobkEmfOco91p1umkkq36+ewsLsVWjn8uWlDVQdOLuZ+AuA/UuyfboOwm8nMRr3EQaafwd8UG3bYNj44VP3U62RNQZ2ETMqQKsyEAeyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh3FVwl8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43948021a45so20426085e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533675; x=1740138475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK5RzhnItMDSuwsYxfF6Zub/vglMr5j5JrlwDlBoEUY=;
        b=Nh3FVwl8upEDdf0EBr1uDO4sfoykeRBvVn4djBluplpQz+EYoZhYI4ztNpuqMcNHWH
         31VlFObHNhoyDTuwdqp4Ud/+c+Lf59MalaWyFAfPSszTjwafsnPsW4Vbwr/cx1bB+UHB
         2/8RB4WhKm4EVua5dwwboMR+fSxpj5JXc4zT8XCOfuQ2Mlft2aJyyOEtT7iGCry+53Go
         CS3ZDVW717KJ81QErbPtNCKfCnFZPyoBDJDha7YQYftHyVG4X2XQgQCKVj9AqTFhzwEf
         q95fewYab78ttrBmDrN6or2acXQ8M+f3wdEXGb8BOPKY+bXGexSYbggOBplvnBexilad
         f0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533675; x=1740138475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK5RzhnItMDSuwsYxfF6Zub/vglMr5j5JrlwDlBoEUY=;
        b=G9ud8mAFoq6rskmLEJ/VAl7tBzj0Qn85L0pIuQnE2opT8vMSrzAV2eavjkNSMRai+S
         abd2N+Yi7cO6U7hzXs/9A9XH2qafw8eZMTwNdoMrxp60uSbEwNhDX36bWPMbQSQ6MJXH
         cVFoLqoExpZl8i9A+M6BrCF+LgDNv80T4JO0tOGgvkZmWv8NOi5fGwDyHv4uDvnBygWI
         QSmKvOI+ke8eRlPHlxAdfT7BfkROaJPrTh3jrEcGWoXa5VZhDNEhx9Am6pHSGkug1CHw
         UIg5+qevyyReOcwTCZg1FCnWr6vQOFF0mGBScb8wTud7DwUf3tH/pqQgxUCNwlVaZTYz
         6bsA==
X-Forwarded-Encrypted: i=1; AJvYcCV3WxQJ2jMzCt8fLyJXcV3ebXV2xRK8zTZAk9Vdly1lD+vzU+YXED4OgRQSDfibIvWVnYWqUSkCD/01wac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcs0EByfmV+/G1MKjcE5sCWUYr1dMjRDpgq9ZnehGNUnvWRzJY
	a4Pejw87iEhHacZA/NGSlFpTkul331JNUntwY0AkaM14bhAWJILD
X-Gm-Gg: ASbGncvuh06uxQARzhZUqdbKShkQHOmTlcJ/rEHLVT9PQ50PkJRV0mx1PGuRo1uuHrH
	b7KDxM9lkOUwrxZESWEC1eLlKJm77nzV+YCu5KXPiOOtf/E3SOSHPuepGqNucnPnAHnCZjojN7y
	fqIByIydNEk5TCMAwkB4TCu3WAt7Lu/QfJEhViaZMqvY6Mmow8Vo2Z4aKS4jAlr8FNQUP9er9b5
	178BVDvN1/sXgGRpcDMfelslxnysur2Zo3b2E7xBUg3bOW8bTDXxYOKmeMxpmTdqCzIMu01/KLq
	+ZsucCgud+/+xp1DfDNvyO8mD1TV2J/mXNwCQEEF5AiDsNCxihM=
X-Google-Smtp-Source: AGHT+IE1RZfnfDyeSpQ4oYcSV3M6SzBMvzBo5o/MmZUePTsqZgGVaMhg9UcGlN6oECAbkStOw5OTwQ==
X-Received: by 2002:a05:600c:5487:b0:438:a240:c63 with SMTP id 5b1f17b1804b1-43958157c4bmr120391945e9.2.1739533675269;
        Fri, 14 Feb 2025 03:47:55 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:54 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 17/17] staging: gpib: tnt4882 console messaging cleanup
Date: Fri, 14 Feb 2025 12:47:08 +0100
Message-ID: <20250214114708.28947-18-dpenkler@gmail.com>
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
string "tnt4882_gpib" in pci_driver struct, request_region and
request_irq.

Remove unsupported chipset pr_err's

Remove messages on interrupted or timed out reads and writes.

Remove board not found messages and return -ENODEV

Remove "tnt4882:" prefix in messages as it will be printed by
pr_fmt and dev_fmt.

Change pr_err to dev_err where possible.

Remove irq and chipset pr_info's.

Replace error messages with appropriate error returns.

Remove call to mite_list_devices() and the function in mite.c

Remove PCMCIA debug comments, PCMCIA_DEBUG conditional compilation
symbol, the DEBUG macro definition and its uses.

Remove pr_info's in mite.c

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/tnt4882/mite.c         |  17 --
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 186 +++++++-------------
 2 files changed, 60 insertions(+), 143 deletions(-)

diff --git a/drivers/staging/gpib/tnt4882/mite.c b/drivers/staging/gpib/tnt4882/mite.c
index ea64dde46bcb..847b96f411bd 100644
--- a/drivers/staging/gpib/tnt4882/mite.c
+++ b/drivers/staging/gpib/tnt4882/mite.c
@@ -88,7 +88,6 @@ int mite_setup(struct mite_struct *mite)
 		pr_err("mite: failed to remap mite io memory address.\n");
 		return -ENOMEM;
 	}
-	pr_info("mite: 0x%08lx mapped to %p\n", mite->mite_phys_addr, mite->mite_io_addr);
 	addr = pci_resource_start(mite->pcidev, 1);
 	mite->daq_phys_addr = addr;
 	mite->daq_io_addr = ioremap(mite->daq_phys_addr, pci_resource_len(mite->pcidev, 1));
@@ -96,7 +95,6 @@ int mite_setup(struct mite_struct *mite)
 		pr_err("mite: failed to remap daq io memory address.\n");
 		return -ENOMEM;
 	}
-	pr_info("mite: daq: 0x%08lx mapped to %p\n", mite->daq_phys_addr, mite->daq_io_addr);
 	writel(mite->daq_phys_addr | WENAB, mite->mite_io_addr + MITE_IODWBSR);
 	mite->used = 1;
 	return 0;
@@ -133,18 +131,3 @@ void mite_unsetup(struct mite_struct *mite)
 	}
 	mite->used = 0;
 }
-
-void mite_list_devices(void)
-{
-	struct mite_struct *mite, *next;
-
-	pr_info("Available NI PCI device IDs:");
-	if (mite_devices)
-		for (mite = mite_devices; mite; mite = next) {
-			next = mite->next;
-			pr_info(" 0x%04x", mite_device_id(mite));
-			if (mite->used)
-				pr_info("(used)");
-	}
-	pr_info("\n");
-}
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index 3118fe7613f6..aadff5b2c4de 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -5,6 +5,10 @@
  *    copyright            : (C) 2001, 2002 by Frank Mori Hess
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/module.h>
@@ -97,7 +101,6 @@ static inline unsigned short tnt_readb(struct tnt4882_priv *priv, unsigned long
 			retval = 0;
 			break;
 		default:
-			pr_err("tnt4882: bug! unsupported ni_chipset\n");
 			retval = 0;
 			break;
 		}
@@ -132,7 +135,6 @@ static inline void tnt_writeb(struct tnt4882_priv *priv, unsigned short value, u
 		case NEC7210:
 			break;
 		default:
-			pr_err("tnt4882: bug! unsupported ni_chipset\n");
 			break;
 		}
 		break;
@@ -326,22 +328,18 @@ static int tnt4882_accel_read(gpib_board_t *board, uint8_t *buffer, size_t lengt
 					     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 					     test_bit(ADR_CHANGE_BN, &nec_priv->state) ||
 					     test_bit(TIMO_NUM, &board->status))) {
-			pr_err("tnt4882: read interrupted\n");
 			retval = -ERESTARTSYS;
 			break;
 		}
 		if (test_bit(TIMO_NUM, &board->status))	{
-			//pr_info("tnt4882: minor %i read timed out\n", board->minor);
 			retval = -ETIMEDOUT;
 			break;
 		}
 		if (test_bit(DEV_CLEAR_BN, &nec_priv->state)) {
-			pr_err("tnt4882: device clear interrupted read\n");
 			retval = -EINTR;
 			break;
 		}
 		if (test_bit(ADR_CHANGE_BN, &nec_priv->state)) {
-			pr_err("tnt4882: address change interrupted read\n");
 			retval = -EINTR;
 			break;
 		}
@@ -368,20 +366,14 @@ static int tnt4882_accel_read(gpib_board_t *board, uint8_t *buffer, size_t lengt
 					     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 					     test_bit(ADR_CHANGE_BN, &nec_priv->state) ||
 					     test_bit(TIMO_NUM, &board->status))) {
-			pr_err("tnt4882: read interrupted\n");
 			retval = -ERESTARTSYS;
 		}
 		if (test_bit(TIMO_NUM, &board->status))
-			//pr_info("tnt4882: read timed out\n");
 			retval = -ETIMEDOUT;
-		if (test_bit(DEV_CLEAR_BN, &nec_priv->state)) {
-			pr_err("tnt4882: device clear interrupted read\n");
+		if (test_bit(DEV_CLEAR_BN, &nec_priv->state))
 			retval = -EINTR;
-		}
-		if (test_bit(ADR_CHANGE_BN, &nec_priv->state)) {
-			pr_err("tnt4882: address change interrupted read\n");
+		if (test_bit(ADR_CHANGE_BN, &nec_priv->state))
 			retval = -EINTR;
-		}
 		count += drain_fifo_words(tnt_priv, &buffer[count], length - count);
 		if (fifo_byte_available(tnt_priv) && count < length)
 			buffer[count++] = tnt_readb(tnt_priv, FIFOB);
@@ -444,22 +436,15 @@ static int write_wait(gpib_board_t *board, struct tnt4882_priv *tnt_priv,
 				     fifo_xfer_done(tnt_priv) ||
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib write interrupted\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		return -ERESTARTSYS;
-	}
-	if (test_bit(TIMO_NUM, &board->status))	{
-		pr_info("tnt4882: write timed out\n");
+
+	if (test_bit(TIMO_NUM, &board->status))
 		return -ETIMEDOUT;
-	}
-	if (test_and_clear_bit(BUS_ERROR_BN, &nec_priv->state))	{
-		pr_err("tnt4882: write bus error\n");
+	if (test_and_clear_bit(BUS_ERROR_BN, &nec_priv->state))
 		return (send_commands) ? -ENOTCONN : -ECOMM;
-	}
-	if (test_bit(DEV_CLEAR_BN, &nec_priv->state)) {
-		pr_err("tnt4882: device clear interrupted write\n");
+	if (test_bit(DEV_CLEAR_BN, &nec_priv->state))
 		return -EINTR;
-	}
 	return 0;
 }
 
@@ -592,7 +577,7 @@ static irqreturn_t tnt4882_internal_interrupt(gpib_board_t *board)
 	if (isr3_bits & HR_DONE)
 		priv->imr3_bits &= ~HR_DONE;
 	if (isr3_bits & (HR_INTR | HR_TLCI)) {
-		dev_dbg(board->gpib_dev, "tnt4882: minor %i isr0 0x%x imr0 0x%x isr3 0x%x imr3 0x%x\n",
+		dev_dbg(board->gpib_dev, "minor %i isr0 0x%x imr0 0x%x isr3 0x%x imr3 0x%x\n",
 			board->minor, isr0_bits, priv->imr0_bits, isr3_bits, imr3_bits);
 		tnt_writeb(priv, priv->imr3_bits, IMR3);
 		wake_up_interruptible(&board->wait);
@@ -933,10 +918,8 @@ static int ni_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	nec_priv->write_byte = nec7210_locking_iomem_write_byte;
 	nec_priv->offset = atgpib_reg_offset;
 
-	if (!mite_devices) {
-		pr_err("no National Instruments PCI boards found\n");
-		return -1;
-	}
+	if (!mite_devices)
+		return -ENODEV;
 
 	for (mite = mite_devices; mite; mite = mite->next) {
 		short found_board;
@@ -967,37 +950,32 @@ static int ni_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		if (found_board)
 			break;
 	}
-	if (!mite) {
-		pr_err("no NI PCI-GPIB boards found\n");
-		return -1;
-	}
+	if (!mite)
+		return -ENODEV;
+
 	tnt_priv->mite = mite;
 	retval = mite_setup(tnt_priv->mite);
-	if (retval < 0)	{
-		pr_err("tnt4882: error setting up mite.\n");
+	if (retval < 0)
 		return retval;
-	}
 
 	nec_priv->mmiobase = tnt_priv->mite->daq_io_addr;
 
 	// get irq
-	if (request_irq(mite_irq(tnt_priv->mite), tnt4882_interrupt, isr_flags,
-			"ni-pci-gpib", board)) {
-		pr_err("gpib: can't request IRQ %d\n", mite_irq(tnt_priv->mite));
-		return -1;
+	retval = request_irq(mite_irq(tnt_priv->mite), tnt4882_interrupt, isr_flags, "ni-pci-gpib",
+			     board);
+	if (retval) {
+		dev_err(board->gpib_dev, "failed to obtain pci irq %d\n", mite_irq(tnt_priv->mite));
+		return retval;
 	}
 	tnt_priv->irq = mite_irq(tnt_priv->mite);
-	pr_info("tnt4882: irq %i\n", tnt_priv->irq);
 
 	// TNT5004 detection
 	switch (tnt_readb(tnt_priv, CSR) & 0xf0) {
 	case 0x30:
 		nec_priv->type = TNT4882;
-		pr_info("tnt4882: TNT4882 chipset detected\n");
 		break;
 	case 0x40:
 		nec_priv->type = TNT5004;
-		pr_info("tnt4882: TNT5004 chipset detected\n");
 		break;
 	}
 	tnt4882_init(tnt_priv, board);
@@ -1027,23 +1005,17 @@ static int ni_isapnp_find(struct pnp_dev **dev)
 {
 	*dev = pnp_find_dev(NULL, ISAPNP_VENDOR_ID_NI,
 			    ISAPNP_FUNCTION(ISAPNP_ID_NI_ATGPIB_TNT), NULL);
-	if (!*dev || !(*dev)->card) {
-		pr_err("tnt4882: failed to find isapnp board\n");
+	if (!*dev || !(*dev)->card)
 		return -ENODEV;
-	}
-	if (pnp_device_attach(*dev) < 0) {
-		pr_err("tnt4882: atgpib/tnt board already active, skipping\n");
+	if (pnp_device_attach(*dev) < 0)
 		return -EBUSY;
-	}
 	if (pnp_activate_dev(*dev) < 0)	{
 		pnp_device_detach(*dev);
-		pr_err("tnt4882: failed to activate() atgpib/tnt, aborting\n");
 		return -EAGAIN;
 	}
 	if (!pnp_port_valid(*dev, 0) || !pnp_irq_valid(*dev, 0)) {
 		pnp_device_detach(*dev);
-		pr_err("tnt4882: invalid port or irq for atgpib/tnt, aborting\n");
-		return -ENOMEM;
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -1056,6 +1028,7 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 	int isr_flags = 0;
 	u32 iobase;
 	int irq;
+	int retval;
 
 	board->status = 0;
 
@@ -1071,7 +1044,6 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 	// look for plug-n-play board
 	if (config->ibbase == 0) {
 		struct pnp_dev *dev;
-		int retval;
 
 		retval = ni_isapnp_find(&dev);
 		if (retval < 0)
@@ -1084,18 +1056,18 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 		irq = config->ibirq;
 	}
 	// allocate ioports
-	if (!request_region(iobase, atgpib_iosize, "atgpib")) {
-		pr_err("tnt4882: failed to allocate ioports\n");
-		return -1;
-	}
+	if (!request_region(iobase, atgpib_iosize, "atgpib"))
+		return -EBUSY;
+
 	nec_priv->mmiobase = ioport_map(iobase, atgpib_iosize);
 	if (!nec_priv->mmiobase)
-		return -1;
+		return -EBUSY;
 
 	// get irq
-	if (request_irq(irq, tnt4882_interrupt, isr_flags, "atgpib", board)) {
-		pr_err("gpib: can't request IRQ %d\n", irq);
-		return -1;
+	retval = request_irq(irq, tnt4882_interrupt, isr_flags, "atgpib", board);
+	if (retval) {
+		dev_err(board->gpib_dev, "failed to request ISA irq %d\n", irq);
+		return retval;
 	}
 	tnt_priv->irq = irq;
 
@@ -1385,7 +1357,7 @@ static const struct pci_device_id tnt4882_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, tnt4882_pci_table);
 
 static struct pci_driver tnt4882_pci_driver = {
-	.name = "tnt4882",
+	.name = DRV_NAME,
 	.id_table = tnt4882_pci_table,
 	.probe = &tnt4882_pci_probe
 };
@@ -1409,80 +1381,79 @@ static int __init tnt4882_init_module(void)
 
 	result = pci_register_driver(&tnt4882_pci_driver);
 	if (result) {
-		pr_err("tnt4882_gpib: pci_register_driver failed: error = %d\n", result);
+		pr_err("pci_register_driver failed: error = %d\n", result);
 		return result;
 	}
 
 	result = gpib_register_driver(&ni_isa_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_isa;
 	}
 
 	result = gpib_register_driver(&ni_isa_accel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_isa_accel;
 	}
 
 	result = gpib_register_driver(&ni_nat4882_isa_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_nat4882_isa;
 	}
 
 	result = gpib_register_driver(&ni_nat4882_isa_accel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_nat4882_isa_accel;
 	}
 
 	result = gpib_register_driver(&ni_nec_isa_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_nec_isa;
 	}
 
 	result = gpib_register_driver(&ni_nec_isa_accel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_nec_isa_accel;
 	}
 
 	result = gpib_register_driver(&ni_pci_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_pci;
 	}
 
 	result = gpib_register_driver(&ni_pci_accel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_pci_accel;
 	}
 
 #ifdef CONFIG_GPIB_PCMCIA
 	result = gpib_register_driver(&ni_pcmcia_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_pcmcia;
 	}
 
 	result = gpib_register_driver(&ni_pcmcia_accel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("tnt4882_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_pcmcia_accel;
 	}
 
 	result = init_ni_gpib_cs();
 	if (result) {
-		pr_err("tnt4882_gpib: pcmcia_register_driver failed: error = %d\n", result);
+		pr_err("pcmcia_register_driver failed: error = %d\n", result);
 		goto err_pcmcia_driver;
 	}
 #endif
 
 	mite_init();
-	mite_list_devices();
 
 	return 0;
 
@@ -1548,25 +1519,6 @@ static void __exit tnt4882_exit_module(void)
 #include <pcmcia/cisreg.h>
 #include <pcmcia/ds.h>
 
-/*
- * All the PCMCIA modules use PCMCIA_DEBUG to control debugging.  If
- * you do not define PCMCIA_DEBUG at all, all the debug code will be
- * left out.  If you compile with PCMCIA_DEBUG=0, the debug code will
- * be present but disabled -- but it can then be enabled for specific
- * modules at load time with a 'pc_debug=#' option to insmod.
- */
-#define PCMCIA_DEBUG 1
-#ifdef PCMCIA_DEBUG
-static int pc_debug = PCMCIA_DEBUG;
-module_param(pc_debug, int, 0);
-#define DEBUG(n, args...)			\
-	do {if (pc_debug > (n))			\
-			pr_debug(args); }	\
-	while (0)
-#else
-#define DEBUG(args...)
-#endif
-
 static int ni_gpib_config(struct pcmcia_device  *link);
 static void ni_gpib_release(struct pcmcia_device *link);
 static void ni_pcmcia_detach(gpib_board_t *board);
@@ -1604,8 +1556,6 @@ static int ni_gpib_probe(struct pcmcia_device *link)
 	struct local_info_t *info;
 	//struct gpib_board_t *dev;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
-
 	/* Allocate space for private device-specific data */
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1639,8 +1589,6 @@ static void ni_gpib_remove(struct pcmcia_device *link)
 	struct local_info_t *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
 
-	DEBUG(0, "%s(%p)\n", __func__, link);
-
 	if (info->dev)
 		ni_pcmcia_detach(info->dev);
 	ni_gpib_release(link);
@@ -1671,8 +1619,6 @@ static int ni_gpib_config(struct pcmcia_device *link)
 	//gpib_board_t *dev = info->dev;
 	int last_ret;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
-
 	last_ret = pcmcia_loop_config(link, &ni_gpib_config_iteration, NULL);
 	if (last_ret) {
 		dev_warn(&link->dev, "no configuration found\n");
@@ -1695,7 +1641,6 @@ static int ni_gpib_config(struct pcmcia_device *link)
  */
 static void ni_gpib_release(struct pcmcia_device *link)
 {
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 	pcmcia_disable_device(link);
 } /* ni_gpib_release */
 
@@ -1703,10 +1648,9 @@ static int ni_gpib_suspend(struct pcmcia_device *link)
 {
 	//struct local_info_t *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	if (link->open)
-		pr_err("Device still open ???\n");
+		dev_warn(&link->dev, "Device still open\n");
 	//netif_device_detach(dev);
 
 	return 0;
@@ -1716,11 +1660,9 @@ static int ni_gpib_resume(struct pcmcia_device *link)
 {
 	//struct local_info_t *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	/*if (link->open) {
 	 *	ni_gpib_probe(dev);	/ really?
-	 *	printk("Gpib resumed ???\n");
 	 *	//netif_device_attach(dev);
 	 *}
 	 */
@@ -1753,7 +1695,6 @@ static int __init init_ni_gpib_cs(void)
 
 static void __exit exit_ni_gpib_cs(void)
 {
-	DEBUG(0, "ni_gpib_cs: unloading\n");
 	pcmcia_unregister_driver(&ni_gpib_cs_driver);
 }
 
@@ -1765,13 +1706,10 @@ static int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
 	struct tnt4882_priv *tnt_priv;
 	struct nec7210_priv *nec_priv;
 	int isr_flags = IRQF_SHARED;
+	int retval;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, board);
-
-	if (!curr_dev) {
-		pr_err("gpib: no NI PCMCIA board found\n");
-		return -1;
-	}
+	if (!curr_dev)
+		return -ENODEV;
 
 	info = curr_dev->priv;
 	info->dev = board;
@@ -1780,6 +1718,7 @@ static int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
 
 	if (tnt4882_allocate_private(board))
 		return -ENOMEM;
+
 	tnt_priv = board->private_data;
 	nec_priv = &tnt_priv->nec7210_priv;
 	nec_priv->type = TNT4882;
@@ -1787,23 +1726,20 @@ static int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
 	nec_priv->write_byte = nec7210_locking_ioport_write_byte;
 	nec_priv->offset = atgpib_reg_offset;
 
-	DEBUG(0, "ioport1 window attributes: 0x%lx\n", curr_dev->resource[0]->flags);
 	if (!request_region(curr_dev->resource[0]->start, resource_size(curr_dev->resource[0]),
-			    "tnt4882")) {
-		pr_err("gpib: ioports starting at 0x%lx are already in use\n",
-		       (unsigned long)curr_dev->resource[0]->start);
-		return -EIO;
-	}
+			    DRV_NAME))
+		return -ENOMEM;
 
 	nec_priv->mmiobase = ioport_map(curr_dev->resource[0]->start,
 					resource_size(curr_dev->resource[0]));
 	if (!nec_priv->mmiobase)
-		return -1;
+		return -ENOMEM;
 
 	// get irq
-	if (request_irq(curr_dev->irq, tnt4882_interrupt, isr_flags, "tnt4882", board))	{
-		pr_err("gpib: can't request IRQ %d\n", curr_dev->irq);
-		return -1;
+	retval = request_irq(curr_dev->irq, tnt4882_interrupt, isr_flags, DRV_NAME, board);
+	if (retval) {
+		dev_err(board->gpib_dev, "failed to obtain PCMCIA irq %d\n", curr_dev->irq);
+		return retval;
 	}
 	tnt_priv->irq = curr_dev->irq;
 
@@ -1817,8 +1753,6 @@ static void ni_pcmcia_detach(gpib_board_t *board)
 	struct tnt4882_priv *tnt_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, board);
-
 	if (tnt_priv) {
 		nec_priv = &tnt_priv->nec7210_priv;
 		if (tnt_priv->irq)
-- 
2.48.1


