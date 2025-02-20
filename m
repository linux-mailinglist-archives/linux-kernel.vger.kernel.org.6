Return-Path: <linux-kernel+bounces-523248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF0A3D432
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F9D177747
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260E1EE7A3;
	Thu, 20 Feb 2025 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1z4QWLx"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA511EBFE0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042582; cv=none; b=j9mLcEchoDgM1hh0f+tbZ/DvhS9f1vuLA8J+QC8kAupmmv0XG95zNSRAkW50jjOkdLZZJXNJQfnfFz/BbGLaoOgt7X5ruwyRaXYbRZhoDbkdvZ91KuJ74XSN7agGRO2JAZPwMwIMK2S9IZs8+tm1ovRqljodOTAWOcXhrLklrsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042582; c=relaxed/simple;
	bh=Ingmx9UkpyZcO6zEl2JEgf/8uGFshim3LzClAA//I00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igWN5+ZGDN5ddKQ3krGTF7fNbyX7aBch4cujNkT7SwZdFOHLz9e+xiwxyw/XjDKJExhPEK3uAifBqrA8H57dRFRHkDtkbYlFxKq1op9BXs0sVkviq7ZPZjDJpt03sEoDgqGR/eAfXbA2+00Szg4dryvvUeCLP95oTlhNfvpmh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1z4QWLx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f31f7731fso314639f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740042578; x=1740647378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhHlGQARJYA++P4KxnTTmkDcgFE57TC9TuEdK94riJ8=;
        b=i1z4QWLxErI32r0YwsVW+ChWwQchBLFod5NQxO8HghpylF4vrKCEVZHezgGrwXiooI
         LBOpkog2Za5LMJCtA/8MC9rM7lNcnryyICGaEKNhh7arVMaI9zUx5fK82UwfzsCaCoCq
         US16s7Har12SChibt7C6bVL2HPl8K/R+Dj1t3dl9krne6BBZDfYqAZDJiKALeFRl1al8
         5o1EpMRJcDhpezhqburP1iMSH9mcW11ddph4ALbM/Lm9LGeBiuL+cNURWPVYBLG7bfu/
         3OVXus8lOZdVpjgZzYgzd9vLdE5P7xkBj5xeoile33T8JpxzX1vBKc6gsz37pBX0q+CL
         0Uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740042578; x=1740647378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhHlGQARJYA++P4KxnTTmkDcgFE57TC9TuEdK94riJ8=;
        b=mjYTMVLscbCCbsmbjN5xsoqqbf0UiKMEGCRJAvjb6M6LItIQon3PvUxr5anvFDVdvw
         BAzG45IcwG289Qy/dUCnGZxKByvfuWQmlAyWynLG0y/uY2MVXk/iVXfmjue0relB0VeF
         ty6vVK07vGGt8S0eOMu23JmFkhm5yQo3ko/7E/fRPdCuX6VBB+uHU4DXohc9NvZ64JOK
         57aIIbSAlDRIGZxrzS4opZsMcUYN4BlUH6DSDGBxpBPyjPFMLp3ZJRnmCZIssa4ElAed
         eGfU3jKojy9UYF1gvOcATUpp3mpU8VUijR4SFPJ/Dn/8HjZP4cAcmzfjWk/MGtWH0Llj
         aSoA==
X-Forwarded-Encrypted: i=1; AJvYcCVHcADSW/W/Wj+KlcJCgCEUUw8/E1pcItNKHExFW5abLRlNo7rB+Sh8x0nQvezHFMNSeGseVJNGeemX0mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE65kgBHZu9nO1kxc82C/CyBO0E3/Ec/7piPyjpHoDUUHn50QN
	bnd7AcdVfTuuimOPwyAkM49j0gfW3vtLFWkvCItSVUh2Zsa2p5pS
X-Gm-Gg: ASbGncvHmW34Ey1a20Ya5hAcYrAnNvMKOtCLWKNuDWr5nLSyNtO3skJuVVlrzo/q+FQ
	wH3pbHTIe66vmrWgnEu4Dshok1IFHgEwqpHBiMsWh4oWLzXGASS02j+LRf/mnl70Ry1zBE2zEmc
	KXkVVx0HCkbpYdfjtCxlHK7opr//o5d/xRvDCM7z4K0yPUyBtrwHMTLHZCD6oxxnltcYKaHT5LU
	DpQdst48t4zbcg9ioxL7EPcMvobvGFZyOfoLR4uuFIunfCrdMX2+URxJ7QTEg54wq5UgFi0lZ1q
	fS7mYWOIvyjTU4m4ZGTVm8nMioS2y3ieTE7RH8QAqHuszQiQHNk=
X-Google-Smtp-Source: AGHT+IEPWnq36nhD+DXBeWK4votSVtDWYov9sPZBdU3AUMqEzAdvizHR/zo3ylwdGwyOT37upmhXWg==
X-Received: by 2002:a5d:64a3:0:b0:38f:4916:fc21 with SMTP id ffacd0b85a97d-38f587f3e7fmr6843519f8f.52.1740042578259;
        Thu, 20 Feb 2025 01:09:38 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa2dsm19807960f8f.101.2025.02.20.01.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:09:37 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 17/17 V2] staging: gpib: tnt4882 console messaging cleanup
Date: Thu, 20 Feb 2025 10:09:20 +0100
Message-ID: <20250220090920.32497-3-dpenkler@gmail.com>
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
V1->V2 Rebase to staging-testing
commit bedc7002f797 ("staging: gpib: ines: remove unused variable")

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
index e1840f16a326..d32420dee5e5 100644
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
@@ -932,10 +917,8 @@ static int ni_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
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
@@ -966,37 +949,32 @@ static int ni_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
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
@@ -1026,23 +1004,17 @@ static int ni_isapnp_find(struct pnp_dev **dev)
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
@@ -1055,6 +1027,7 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 	int isr_flags = 0;
 	u32 iobase;
 	int irq;
+	int retval;
 
 	board->status = 0;
 
@@ -1070,7 +1043,6 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 	// look for plug-n-play board
 	if (config->ibbase == 0) {
 		struct pnp_dev *dev;
-		int retval;
 
 		retval = ni_isapnp_find(&dev);
 		if (retval < 0)
@@ -1083,18 +1055,18 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
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
 
@@ -1384,7 +1356,7 @@ static const struct pci_device_id tnt4882_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, tnt4882_pci_table);
 
 static struct pci_driver tnt4882_pci_driver = {
-	.name = "tnt4882",
+	.name = DRV_NAME,
 	.id_table = tnt4882_pci_table,
 	.probe = &tnt4882_pci_probe
 };
@@ -1411,80 +1383,79 @@ static int __init tnt4882_init_module(void)
 
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
 
@@ -1550,25 +1521,6 @@ static void __exit tnt4882_exit_module(void)
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
@@ -1606,8 +1558,6 @@ static int ni_gpib_probe(struct pcmcia_device *link)
 	struct local_info_t *info;
 	//struct gpib_board_t *dev;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
-
 	/* Allocate space for private device-specific data */
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -1641,8 +1591,6 @@ static void ni_gpib_remove(struct pcmcia_device *link)
 	struct local_info_t *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
 
-	DEBUG(0, "%s(%p)\n", __func__, link);
-
 	if (info->dev)
 		ni_pcmcia_detach(info->dev);
 	ni_gpib_release(link);
@@ -1673,8 +1621,6 @@ static int ni_gpib_config(struct pcmcia_device *link)
 	//gpib_board_t *dev = info->dev;
 	int last_ret;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
-
 	last_ret = pcmcia_loop_config(link, &ni_gpib_config_iteration, NULL);
 	if (last_ret) {
 		dev_warn(&link->dev, "no configuration found\n");
@@ -1697,7 +1643,6 @@ static int ni_gpib_config(struct pcmcia_device *link)
  */
 static void ni_gpib_release(struct pcmcia_device *link)
 {
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 	pcmcia_disable_device(link);
 } /* ni_gpib_release */
 
@@ -1705,10 +1650,9 @@ static int ni_gpib_suspend(struct pcmcia_device *link)
 {
 	//struct local_info_t *info = link->priv;
 	//struct gpib_board_t *dev = info->dev;
-	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	if (link->open)
-		pr_err("Device still open ???\n");
+		dev_warn(&link->dev, "Device still open\n");
 	//netif_device_detach(dev);
 
 	return 0;
@@ -1718,11 +1662,9 @@ static int ni_gpib_resume(struct pcmcia_device *link)
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
@@ -1755,7 +1697,6 @@ static int __init init_ni_gpib_cs(void)
 
 static void __exit exit_ni_gpib_cs(void)
 {
-	DEBUG(0, "ni_gpib_cs: unloading\n");
 	pcmcia_unregister_driver(&ni_gpib_cs_driver);
 }
 
@@ -1767,13 +1708,10 @@ static int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
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
@@ -1782,6 +1720,7 @@ static int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
 
 	if (tnt4882_allocate_private(board))
 		return -ENOMEM;
+
 	tnt_priv = board->private_data;
 	nec_priv = &tnt_priv->nec7210_priv;
 	nec_priv->type = TNT4882;
@@ -1789,23 +1728,20 @@ static int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
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
 
@@ -1819,8 +1755,6 @@ static void ni_pcmcia_detach(gpib_board_t *board)
 	struct tnt4882_priv *tnt_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
 
-	DEBUG(0, "%s(0x%p)\n", __func__, board);
-
 	if (tnt_priv) {
 		nec_priv = &tnt_priv->nec7210_priv;
 		if (tnt_priv->irq)
-- 
2.48.1


