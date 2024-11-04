Return-Path: <linux-kernel+bounces-395324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD149BBC5D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27D21C21BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABFE1CCED8;
	Mon,  4 Nov 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6dajg1I"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58531CBA1C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742636; cv=none; b=obsQanFdb7ZWR9ClQDvANz+IRXvn/HP2HVhgrACGAIuTqguJ3rmCE/6+nqEIq7FAIWotoW+LbX82ptQLy6T4kLV9UZPSLRPWPS4NeOA9wpg6TfZgLYIMFZNgDHIq4fuuyp272rbccCrslafRbv03NvyTeiqifBv8qkcy+Lq3Dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742636; c=relaxed/simple;
	bh=lVjBIPmAWAxvwFpAqjKCBvNzEMuvfZvqfx6EZrhXWBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTDdlzCtv91HjcHKBGuDLRxAVeQyAVvxJMMby8ux5Q8+bnmBk4BJxu2LAj3QCo+k8tiXea5A0Dd4W0m8jQrN60vclkQjncQCJgyZDMdiKir0eTDHJixl5c8fSEDjwwHE+dBmyaS78K0HRg0YA3JYZZyiEsjZFzShdPcPr4gb8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6dajg1I; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2812422f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742632; x=1731347432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMiOenlcN+NEHEm2VnBri2kDf2u06cLWkpnyRcrJPNU=;
        b=Q6dajg1IPD8kPAKtSLutXkiKW/+T5BrSiZXLIQsh1sl9AGB6m+EAheJb31fmH5A4ut
         vlsi//Viuu1/7mM+Vk4ttAXbLM7oD/S5zYJHQxxNekDJjZhgvS7uSgafjo9sx+L5y+s+
         0MjRM4t/a7FrNuVl9yyNUQ0drU1wTotmgYwXLE0CaBlsWWLcj2sLk159Dy+c/ffudBX+
         02Z70JPE5gTo0/WeyW6L9ubEWGJiw5ZbaQ7gfPrvYSkb9nbOTagTBHfdnNzDvk5Gs6AC
         w9KSdka4zLsXFK9EzwP7cZq1OceOhF/5wFe0c9oG5JdBdfRu/degn4LkfPmWN9QbrC+g
         hqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742632; x=1731347432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMiOenlcN+NEHEm2VnBri2kDf2u06cLWkpnyRcrJPNU=;
        b=tPGPCTyT4sdXg7DtWyRxVUnAosSAZOFhZdDbTCsfEFN9QT9MZHgsbkjBeh7tIXZuoo
         /ECIkz93kKsFZQLauZ+knIF3rjeVLFLIOc+DHVdXb23zVRTssFO1iYEL4tAhsRE20YfB
         bwdRZJIg8+ZGUKKxkzQ2w/pOk6G9bblAQf6HJRmq+k0KFXKl/g3EFtqu1holuEF44eBD
         kvrqkkLxZINhHkYom0tma7ciJBPgieR9dubOJP1Ky/RIM07TCsSVWm0i+oqJvYcTjdy0
         Oop2mzu11MaC0owrkMj5X5IbXMOmI45Lm2h1Y6Z1TrdeNJdq5MJvuo5w2BfXuft2Bw+p
         u3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Fq0408FcIrIGSwtpNiBb7DKcgROkBHe2/lMO1hRmKfleIBxuXAH59J2o6mYvnjIyDz5PcyKlnF1o9jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcyxOLFRaOFp20sDJI7Pw/iwqfI4Jk6228jHTCRsLLKCjnrNW
	lo4LJ4qL9zBxBa+Kz+n4BDtAR10W5FFzGFD5QTzQsbVNt5nsu0pgNagN4Dpm
X-Google-Smtp-Source: AGHT+IEYu0O/zRYXlo0EjgHgU8xNPVMv4v+PIe4NGMmPO3QQGiwv0qNR55PjL+lBtuFIicgA/BlU3g==
X-Received: by 2002:adf:f6d1:0:b0:37d:4332:e91d with SMTP id ffacd0b85a97d-381b710f7f1mr15130516f8f.52.1730742631823;
        Mon, 04 Nov 2024 09:50:31 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:31 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 07/12] staging: gpib: Use dev_xxx for messaging
Date: Mon,  4 Nov 2024 18:50:08 +0100
Message-ID: <20241104175014.12317-8-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change pr_xxx to dev_xxx

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 .../gpib/agilent_82350b/agilent_82350b.c      | 70 +++++++++++--------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 3aa624486c0f..53006d0cc79c 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -52,7 +52,8 @@ int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_t lengt
 		retval = tms9914_read(board, tms_priv, buffer, 1, end, &num_bytes);
 		*bytes_read += num_bytes;
 		if (retval < 0)
-			pr_err("%s: tms9914_read failed retval=%i\n", driver_name, retval);
+			dev_err(board->gpib_dev, "%s: tms9914_read failed retval=%i\n",
+				driver_name, retval);
 		if (retval < 0 || *end)
 			return retval;
 		++buffer;
@@ -88,7 +89,7 @@ int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_t lengt
 						  test_bit(DEV_CLEAR_BN, &tms_priv->state) ||
 						  test_bit(TIMO_NUM, &board->status));
 		if (retval) {
-			pr_err("%s: read wait interrupted\n", driver_name);
+			dev_dbg(board->gpib_dev, "%s: read wait interrupted\n", driver_name);
 			retval = -ERESTARTSYS;
 			break;
 		}
@@ -102,12 +103,13 @@ int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_t lengt
 			*end = 1;
 		}
 		if (test_bit(TIMO_NUM, &board->status)) {
-			pr_err("%s: minor %i: read timed out\n", driver_name, board->minor);
+			dev_err(board->gpib_dev, "%s: read timed out\n", driver_name);
 			retval = -ETIMEDOUT;
 			break;
 		}
 		if (test_bit(DEV_CLEAR_BN, &tms_priv->state)) {
-			pr_err("%s: device clear interrupted read\n", driver_name);
+			dev_err(board->gpib_dev, "%s: device clear interrupted read\n",
+				driver_name);
 			retval = -EINTR;
 			break;
 		}
@@ -138,15 +140,15 @@ static int translate_wait_return_value(gpib_board_t *board, int retval)
 	struct tms9914_priv *tms_priv = &a_priv->tms9914_priv;
 
 	if (retval) {
-		pr_err("%s: write wait interrupted\n", driver_name);
+		dev_err(board->gpib_dev, "%s: write wait interrupted\n", driver_name);
 		return -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status)) {
-		pr_err("%s: minor %i: write timed out\n", driver_name, board->minor);
+		dev_err(board->gpib_dev, "%s: write timed out\n", driver_name);
 		return -ETIMEDOUT;
 	}
 	if (test_bit(DEV_CLEAR_BN, &tms_priv->state)) {
-		pr_err("%s: device clear interrupted write\n", driver_name);
+		dev_err(board->gpib_dev, "%s: device clear interrupted write\n", driver_name);
 		return -EINTR;
 	}
 	return 0;
@@ -558,10 +560,11 @@ static int init_82350a_hardware(gpib_board_t *board, const gpib_board_config_t *
 		return 0;
 	// need to programme borg
 	if (!config->init_data || config->init_data_length != firmware_length) {
-		pr_err("%s: the 82350A board requires firmware after powering on.\n", driver_name);
+		dev_err(board->gpib_dev, "%s: the 82350A board requires firmware after powering on.\n",
+			driver_name);
 		return -EIO;
 	}
-	pr_info("%s: Loading firmware...\n", driver_name);
+	dev_info(board->gpib_dev, "%s: Loading firmware...\n", driver_name);
 
 	// tickle the borg
 	writel(plx_cntrl_static_bits | PLX9050_USER3_DATA_BIT,
@@ -580,7 +583,7 @@ static int init_82350a_hardware(gpib_board_t *board, const gpib_board_config_t *
 			usleep_range(10, 20);
 		}
 		if (j == timeout) {
-			pr_err("%s: timed out loading firmware.\n", driver_name);
+			dev_err(board->gpib_dev, "%s: timed out loading firmware.\n", driver_name);
 			return -ETIMEDOUT;
 		}
 		writeb(firmware_data[i], a_priv->gpib_base + CONFIG_DATA_REG);
@@ -591,10 +594,11 @@ static int init_82350a_hardware(gpib_board_t *board, const gpib_board_config_t *
 		usleep_range(10, 20);
 	}
 	if (j == timeout) {
-		pr_err("%s: timed out waiting for firmware load to complete.\n", driver_name);
+		dev_err(board->gpib_dev, "%s: timed out waiting for firmware load to complete.\n",
+			driver_name);
 		return -ETIMEDOUT;
 	}
-	pr_info("%s: ...done.\n", driver_name);
+	dev_info(board->gpib_dev, "%s: ...done.\n", driver_name);
 	return 0;
 }
 
@@ -616,14 +620,15 @@ static int test_sram(gpib_board_t *board)
 		unsigned int read_value = readb(a_priv->sram_base + i);
 
 		if ((i & byte_mask) != read_value) {
-			pr_err("%s: SRAM test failed at %d wanted %d got %d\n",
-			       driver_name, i, (i & byte_mask), read_value);
+			dev_err(board->gpib_dev, "%s: SRAM test failed at %d wanted %d got %d\n",
+				driver_name, i, (i & byte_mask), read_value);
 			return -EIO;
 		}
 		if (need_resched())
 			schedule();
 	}
-	pr_info("%s: SRAM test passed 0x%x bytes checked\n", driver_name, sram_length);
+	dev_info(board->gpib_dev, "%s: SRAM test passed 0x%x bytes checked\n",
+		 driver_name, sram_length);
 	return 0;
 }
 
@@ -651,14 +656,14 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 						 PCI_DEVICE_ID_82350B, NULL);
 	if (a_priv->pci_device) {
 		a_priv->model = MODEL_82350B;
-		pr_info("%s: Agilent 82350B board found\n", driver_name);
+		dev_info(board->gpib_dev, "%s: Agilent 82350B board found\n", driver_name);
 
 	} else	{
 		a_priv->pci_device = gpib_pci_get_device(config, PCI_VENDOR_ID_AGILENT,
 							 PCI_DEVICE_ID_82351A, NULL);
 		if (a_priv->pci_device)	{
 			a_priv->model = MODEL_82351A;
-			pr_info("%s: Agilent 82351B board found\n", driver_name);
+			dev_info(board->gpib_dev, "%s: Agilent 82351B board found\n", driver_name);
 
 		} else {
 			a_priv->pci_device = gpib_pci_get_subsys(config, PCI_VENDOR_ID_PLX,
@@ -668,15 +673,17 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 								 a_priv->pci_device);
 			if (a_priv->pci_device) {
 				a_priv->model = MODEL_82350A;
-				pr_info("%s: HP/Agilent 82350A board found\n", driver_name);
+				dev_info(board->gpib_dev, "%s: HP/Agilent 82350A board found\n",
+					 driver_name);
 			} else {
-				pr_err("%s: no 82350/82351 board found\n", driver_name);
+				dev_err(board->gpib_dev, "%s: no 82350/82351 board found\n",
+					driver_name);
 				return -ENODEV;
 			}
 		}
 	}
 	if (pci_enable_device(a_priv->pci_device)) {
-		pr_err("%s: error enabling pci device\n", driver_name);
+		dev_err(board->gpib_dev, "%s: error enabling pci device\n", driver_name);
 		return -EIO;
 	}
 	if (pci_request_regions(a_priv->pci_device, driver_name))
@@ -685,23 +692,27 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 	case MODEL_82350A:
 		a_priv->plx_base = ioremap(pci_resource_start(a_priv->pci_device, PLX_MEM_REGION),
 					   pci_resource_len(a_priv->pci_device, PLX_MEM_REGION));
-		pr_info("%s: plx base address remapped to 0x%p\n", driver_name, a_priv->plx_base);
+		dev_dbg(board->gpib_dev, "%s: plx base address remapped to 0x%p\n",
+			driver_name, a_priv->plx_base);
 		a_priv->gpib_base = ioremap(pci_resource_start(a_priv->pci_device,
 							       GPIB_82350A_REGION),
 					    pci_resource_len(a_priv->pci_device,
 							     GPIB_82350A_REGION));
-		pr_info("%s: gpib base address remapped to 0x%p\n", driver_name, a_priv->gpib_base);
+		dev_dbg(board->gpib_dev, "%s: gpib base address remapped to 0x%p\n",
+			driver_name, a_priv->gpib_base);
 		tms_priv->iobase = a_priv->gpib_base + TMS9914_BASE_REG;
 		a_priv->sram_base = ioremap(pci_resource_start(a_priv->pci_device,
 							       SRAM_82350A_REGION),
 					    pci_resource_len(a_priv->pci_device,
 							     SRAM_82350A_REGION));
-		pr_info("%s: sram base address remapped to 0x%p\n", driver_name, a_priv->sram_base);
+		dev_dbg(board->gpib_dev, "%s: sram base address remapped to 0x%p\n",
+			driver_name, a_priv->sram_base);
 		a_priv->borg_base = ioremap(pci_resource_start(a_priv->pci_device,
 							       BORG_82350A_REGION),
 					    pci_resource_len(a_priv->pci_device,
 							     BORG_82350A_REGION));
-		pr_info("%s: borg base address remapped to 0x%p\n", driver_name, a_priv->borg_base);
+		dev_dbg(board->gpib_dev, "%s: borg base address remapped to 0x%p\n",
+			driver_name, a_priv->borg_base);
 
 		retval = init_82350a_hardware(board, config);
 		if (retval < 0)
@@ -711,14 +722,17 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 	case MODEL_82351A:
 		a_priv->gpib_base = ioremap(pci_resource_start(a_priv->pci_device, GPIB_REGION),
 					    pci_resource_len(a_priv->pci_device, GPIB_REGION));
-		pr_info("%s: gpib base address remapped to 0x%p\n", driver_name, a_priv->gpib_base);
+		dev_dbg(board->gpib_dev, "%s: gpib base address remapped to 0x%p\n",
+			driver_name, a_priv->gpib_base);
 		tms_priv->iobase = a_priv->gpib_base + TMS9914_BASE_REG;
 		a_priv->sram_base = ioremap(pci_resource_start(a_priv->pci_device, SRAM_REGION),
 					    pci_resource_len(a_priv->pci_device, SRAM_REGION));
-		pr_info("%s: sram base address remapped to 0x%p\n", driver_name, a_priv->sram_base);
+		dev_dbg(board->gpib_dev, "%s: sram base address remapped to 0x%p\n",
+			driver_name, a_priv->sram_base);
 		a_priv->misc_base = ioremap(pci_resource_start(a_priv->pci_device, MISC_REGION),
 					    pci_resource_len(a_priv->pci_device, MISC_REGION));
-		pr_info("%s: misc base address remapped to 0x%p\n", driver_name, a_priv->misc_base);
+		dev_dbg(board->gpib_dev, "%s: misc base address remapped to 0x%p\n",
+			driver_name, a_priv->misc_base);
 		break;
 	default:
 		pr_err("%s: invalid board\n", driver_name);
@@ -735,7 +749,7 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 		return -EIO;
 	}
 	a_priv->irq = a_priv->pci_device->irq;
-	pr_info("%s: IRQ %d\n", driver_name, a_priv->irq);
+	dev_dbg(board->gpib_dev, "%s: IRQ %d\n", driver_name, a_priv->irq);
 
 	writeb(0, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 	a_priv->card_mode_bits = ENABLE_PCI_IRQ_BIT;
-- 
2.46.2


