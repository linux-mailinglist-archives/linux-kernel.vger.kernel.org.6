Return-Path: <linux-kernel+bounces-514883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DDAA35CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FE13B002A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0C265CAD;
	Fri, 14 Feb 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEPJm+Xe"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FD264A84
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533671; cv=none; b=aRnCFEh8op00ZZsESDXinr18P+tgEqB6qJ+eOhjyln8MwKeUNd1iAaw4+/cJr+oS1jmskkY/vmHjDOOsSkMPfe4HZYfATj0idPUj86jDwadtWVvg/Yshebt2gyKJdfdFZUSm5K/ypdLHCYER3zgMMU5rp6x+tjXO3q8+2WpjZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533671; c=relaxed/simple;
	bh=ijyH4DVGB8FNQ0gY42wKtBKYVu7WhC3PPIBdhg4FeIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML7/XxQrbTFnwpu66BJHv8zRzf15If/lr58EYs44gwy+T5LeFtIi1ojUhupGq05hwwRKADaDEu1RI5sRnAyNU2//A+ObB8SZ5wQOO+AZVBKLl4lUlhNbKLVdzIUijf2gy41rSUVQmMwqa5u/5+yPgVa0XQ03tc7okK4HiOMhPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEPJm+Xe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4396a24118dso3713555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533667; x=1740138467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgvV/67S4yU4G2qIKWOT0FF3EvbLiZzOC/0UnfzPRlU=;
        b=mEPJm+XeTzp9zroZbiJSoblexbvQKF2x1A69uoe1TEgKikQs2P6h+SLXdIQs+QhIWH
         6lWwq3axUJdnkbSXutz0TfEpXFHPVmctB75n+yBK78f/Bx+ndpeQ1WQPgMfqlXltla7x
         Ov2xJJLgM1/sv5HmifcV0rsx018iOphCX+CrQXKSsPkXrR5A4jBcSmN4f6VshfZPc7uw
         J/Wyw+s+YzXZOrDHEMB7vRA2RzJBSALPFbKuBQHnaERmVNnQWBK8EbTog4HVxkjgGbXZ
         UygOmdSDCONzNxJPsx+Jvb/FEFleExzIiZDmb+aQIyBOO6wn5N+BxJ2exRo357tnyr5Y
         oYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533667; x=1740138467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgvV/67S4yU4G2qIKWOT0FF3EvbLiZzOC/0UnfzPRlU=;
        b=DtPIagdCwwhD+P5YZjVH7DcQQVlV5k2oYKPrcNEyk9ayJKC1BIsC5Q6plV1l742YkM
         xftZ0l7zuuaIyD/QnyyyNQQSxh+5Lk4XBDe47pp28T13f2Sg8eWX4ClkT/csgcl+kUhE
         zPXfo3dHgGftU8gX5dSy0sH9ugynuqHRBFU3kXlvim6Y2JudaiP6tacZDB3IlpQfG8fC
         48AWMh3k28IGU7ILWLAEKO2GCoeQ9ArBVlpWmSqCPYYxGle+mgSHMnweIpSggYfUnv2o
         0iwhV3ubjhuEbjDcEhqtzQ1tpZEl6HtuLumhEMBk4DwVH3rnkb7rUppqpf5YkIsGie4r
         KB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8GG8capcHd8TGfxMN7eoH8xyB+RXFMFR5qQCfrG8mElW3XHZYYEFCXhG13/JFizFX/zCjs7Bu4tGfs+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysNkNPlCb2fwHaFiGzF9Hes1rUdJpYQ+XogIpsBrNjjDfdM7/b
	iYEX9/w5qfG9A/XWpq4WcdNx0olayAxg3Ed9KcpbTtWoOs+pCnUn
X-Gm-Gg: ASbGncsoQY+/AIfEqwFr5JZrgAoNUSHCuncslefDYk9GLy5ai5KchLyz03GkZ9IjRZZ
	+nrysczrxHIobO419NoHYPbrWCV2uk0bHFf/Bb7ou2enKGs6s8LHtipf6eLM/3FAPO0jWgh7bhZ
	TMstboIkYoHEyMFK/TCNlJWW6s4aT4TRIIrKeQGkDA+fHezA9Fp3IgEdo/uoE7BCvk98gftMHwr
	v96X5NrydxuNUpP/4ndspjugOWR4PzyYu/sdNbm3Xw2RJBEa/9xOG1ImviUNNgCGTL8Rsdt9Wc2
	fdIisCLmWuCcKPekFO+dk8Z44G36z3ipXBlJPqeGVCNdK7bjrI4=
X-Google-Smtp-Source: AGHT+IEHR4rOwR3AojbDga7TpmFjdPf9C2oBcw7THoky/+/GclhGxBbaPuDFPPXE01+4RGtdv/O2Cw==
X-Received: by 2002:a05:600c:4e4f:b0:439:6304:e28a with SMTP id 5b1f17b1804b1-4396304e556mr90090845e9.0.1739533666396;
        Fri, 14 Feb 2025 03:47:46 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:44 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 10/17] staging: gpib: hp82341 console messaging cleanup
Date: Fri, 14 Feb 2025 12:47:01 +0100
Message-ID: <20250214114708.28947-11-dpenkler@gmail.com>
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
string "hp82341" in request_region and request_irq

Change pr_err to dev_err wherever possible

Remove pr_warn and pr_debug for timed out or interrupted
reads and writes.

Remove "hp_82341:" prefix in messages since this is
printed with the module name.

Remove __func__ parameter in pr_err.

Remove pr_info's.

Remove cpmmented printk's.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/hp_82341/hp_82341.c | 70 ++++++++++--------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index 800f99c05566..3ac87d1a1fab 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -6,6 +6,10 @@
  *   copyright            : (C) 2002, 2005 by Frank Mori Hess              *
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include "hp_82341.h"
 #include <linux/delay.h>
 #include <linux/ioport.h>
@@ -57,7 +61,7 @@ static int hp_82341_accel_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 		retval = tms9914_read(board, tms_priv, buffer, 1, end, &num_bytes);
 		*bytes_read += num_bytes;
 		if (retval < 0)
-			pr_err("tms9914_read failed retval=%i\n", retval);
+			dev_err(board->gpib_dev, "tms9914_read failed retval=%i\n", retval);
 		if (retval < 0 || *end)
 			return retval;
 		++buffer;
@@ -93,7 +97,6 @@ static int hp_82341_accel_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 						  test_bit(DEV_CLEAR_BN, &tms_priv->state) ||
 						  test_bit(TIMO_NUM, &board->status));
 		if (retval)  {
-			pr_warn("%s: read wait interrupted\n", __func__);
 			retval = -ERESTARTSYS;
 			break;
 		}
@@ -118,12 +121,10 @@ static int hp_82341_accel_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 			tms_priv->holdoff_active = 1;
 		}
 		if (test_bit(TIMO_NUM, &board->status))	{
-			pr_debug("%s: minor %i: read timed out\n", __FILE__, board->minor);
 			retval = -ETIMEDOUT;
 			break;
 		}
 		if (test_bit(DEV_CLEAR_BN, &tms_priv->state)) {
-			pr_warn("%s: device clear interrupted read\n", __FILE__);
 			retval = -EINTR;
 			break;
 		}
@@ -211,7 +212,7 @@ static int hp_82341_accel_write(gpib_board_t *board, uint8_t *buffer, size_t len
 		outb(ENABLE_TI_BUFFER_BIT, hp_priv->iobase[3] + BUFFER_CONTROL_REG);
 		retval = restart_write_fifo(board, hp_priv);
 		if (retval < 0)	{
-			pr_err("hp82341: failed to restart write stream\n");
+			dev_err(board->gpib_dev, "failed to restart write stream\n");
 			break;
 		}
 		retval = wait_event_interruptible(board->wait,
@@ -223,17 +224,14 @@ static int hp_82341_accel_write(gpib_board_t *board, uint8_t *buffer, size_t len
 		outb(0, hp_priv->iobase[3] + BUFFER_CONTROL_REG);
 		*bytes_written += block_size - read_transfer_counter(hp_priv);
 		if (retval) {
-			pr_warn("%s: write wait interrupted\n", __FILE__);
 			retval = -ERESTARTSYS;
 			break;
 		}
 		if (test_bit(TIMO_NUM, &board->status))	{
-			pr_debug("%s: minor %i: write timed out\n", __FILE__, board->minor);
 			retval = -ETIMEDOUT;
 			break;
 		}
 		if (test_bit(DEV_CLEAR_BN, &tms_priv->state)) {
-			pr_warn("%s: device clear interrupted write\n", __FILE__);
 			retval = -EINTR;
 			break;
 		}
@@ -495,21 +493,21 @@ static int hp_82341_find_isapnp_board(struct pnp_dev **dev)
 	*dev = pnp_find_dev(NULL, ISAPNP_VENDOR('H', 'W', 'P'),
 			    ISAPNP_FUNCTION(0x1411), NULL);
 	if (!*dev || !(*dev)->card) {
-		pr_err("hp_82341: failed to find isapnp board\n");
+		pr_err("failed to find isapnp board\n");
 		return -ENODEV;
 	}
 	if (pnp_device_attach(*dev) < 0) {
-		pr_err("hp_82341: board already active, skipping\n");
+		pr_err("board already active, skipping\n");
 		return -EBUSY;
 	}
 	if (pnp_activate_dev(*dev) < 0) {
 		pnp_device_detach(*dev);
-		pr_err("hp_82341: failed to activate() atgpib/tnt, aborting\n");
+		pr_err("failed to activate(), aborting\n");
 		return -EAGAIN;
 	}
 	if (!pnp_port_valid(*dev, 0) || !pnp_irq_valid(*dev, 0)) {
 		pnp_device_detach(*dev);
-		pr_err("hp_82341: invalid port or irq for atgpib/tnt, aborting\n");
+		pr_err("invalid port or irq, aborting\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -530,7 +528,7 @@ static int xilinx_ready(struct hp_82341_priv *hp_priv)
 		else
 			return 0;
 	default:
-		pr_err("hp_82341: %s: bug! unknown hw_version\n", __func__);
+		pr_err("bug! unknown hw_version\n");
 		break;
 	}
 	return 0;
@@ -550,7 +548,7 @@ static int xilinx_done(struct hp_82341_priv *hp_priv)
 		else
 			return 0;
 	default:
-		pr_err("hp_82341: %s: bug! unknown hw_version\n", __func__);
+		pr_err("bug! unknown hw_version\n");
 		break;
 	}
 	return 0;
@@ -571,7 +569,7 @@ static int irq_valid(struct hp_82341_priv *hp_priv, int irq)
 		case 15:
 			return 1;
 		default:
-			pr_err("hp_82341: invalid irq=%i for 82341C, irq must be 3, 5, 7, 9, 10, 11, 12, or 15.\n",
+			pr_err("invalid irq=%i for 82341C, irq must be 3, 5, 7, 9, 10, 11, 12, or 15.\n",
 			       irq);
 			return 0;
 		}
@@ -579,7 +577,7 @@ static int irq_valid(struct hp_82341_priv *hp_priv, int irq)
 	case HW_VERSION_82341D:
 		return 1;
 	default:
-		pr_err("hp_82341: %s: bug! unknown hw_version\n", __func__);
+		pr_err("bug! unknown hw_version\n");
 		break;
 	}
 	return 0;
@@ -601,7 +599,7 @@ static int hp_82341_load_firmware_array(struct hp_82341_priv *hp_priv,
 			usleep_range(10, 15);
 		}
 		if (j == timeout) {
-			pr_err("hp_82341: timed out waiting for Xilinx ready.\n");
+			pr_err("timed out waiting for Xilinx ready.\n");
 			return -ETIMEDOUT;
 		}
 		outb(firmware_data[i], hp_priv->iobase[0] + XILINX_DATA_REG);
@@ -614,7 +612,7 @@ static int hp_82341_load_firmware_array(struct hp_82341_priv *hp_priv,
 		usleep_range(10, 15);
 	}
 	if (j == timeout) {
-		pr_err("hp_82341: timed out waiting for Xilinx done.\n");
+		pr_err("timed out waiting for Xilinx done.\n");
 		return -ETIMEDOUT;
 	}
 	return 0;
@@ -625,27 +623,27 @@ static int hp_82341_load_firmware(struct hp_82341_priv *hp_priv, const gpib_boar
 	if (config->init_data_length == 0) {
 		if (xilinx_done(hp_priv))
 			return 0;
-		pr_err("hp_82341: board needs be initialized with firmware upload.\n"
+		pr_err("board needs be initialized with firmware upload.\n"
 		       "\tUse the --init-data option of gpib_config.\n");
 		return -EINVAL;
 	}
 	switch (hp_priv->hw_version) {
 	case HW_VERSION_82341C:
 		if (config->init_data_length != hp_82341c_firmware_length) {
-			pr_err("hp_82341: bad firmware length=%i for 82341c (expected %i).\n",
+			pr_err("bad firmware length=%i for 82341c (expected %i).\n",
 			       config->init_data_length, hp_82341c_firmware_length);
 			return -EINVAL;
 		}
 		break;
 	case HW_VERSION_82341D:
 		if (config->init_data_length != hp_82341d_firmware_length) {
-			pr_err("hp_82341: bad firmware length=%i for 82341d (expected %i).\n",
+			pr_err("bad firmware length=%i for 82341d (expected %i).\n",
 			       config->init_data_length, hp_82341d_firmware_length);
 			return -EINVAL;
 		}
 		break;
 	default:
-		pr_err("hp_82341: %s: bug! unknown hw_version\n", __func__);
+		pr_err("bug! unknown hw_version\n");
 		break;
 	}
 	return hp_82341_load_firmware_array(hp_priv, config->init_data, config->init_data_length);
@@ -723,13 +721,12 @@ static int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *confi
 		hp_priv->hw_version = HW_VERSION_82341C;
 		hp_priv->io_region_offset = 0x400;
 	}
-	pr_info("hp_82341: base io 0x%u\n", iobase);
 	for (i = 0; i < hp_82341_num_io_regions; ++i) {
 		start_addr = iobase + i * hp_priv->io_region_offset;
-		if (!request_region(start_addr, hp_82341_region_iosize, "hp_82341")) {
-			pr_err("hp_82341: failed to allocate io ports 0x%x-0x%x\n",
-			       start_addr,
-			       start_addr + hp_82341_region_iosize - 1);
+		if (!request_region(start_addr, hp_82341_region_iosize, DRV_NAME)) {
+			dev_err(board->gpib_dev, "failed to allocate io ports 0x%x-0x%x\n",
+				start_addr,
+				start_addr + hp_82341_region_iosize - 1);
 			return -EIO;
 		}
 		hp_priv->iobase[i] = start_addr;
@@ -739,7 +736,7 @@ static int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *confi
 		retval = isapnp_cfg_begin(hp_priv->pnp_dev->card->number,
 					  hp_priv->pnp_dev->number);
 		if (retval < 0)	{
-			pr_err("hp_82341: isapnp_cfg_begin returned error\n");
+			dev_err(board->gpib_dev, "isapnp_cfg_begin returned error\n");
 			return retval;
 		}
 		isapnp_write_byte(PIO_DIRECTION_REG, HP_82341D_XILINX_READY_BIT |
@@ -755,12 +752,11 @@ static int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *confi
 		return retval;
 	if (irq_valid(hp_priv, irq) == 0)
 		return -EINVAL;
-	if (request_irq(irq, hp_82341_interrupt, 0, "hp_82341", board))	{
-		pr_err("hp_82341: failed to allocate IRQ %d\n", irq);
+	if (request_irq(irq, hp_82341_interrupt, 0, DRV_NAME, board))	{
+		dev_err(board->gpib_dev, "failed to allocate IRQ %d\n", irq);
 		return -EIO;
 	}
 	hp_priv->irq = irq;
-	pr_info("hp_82341: IRQ %d\n", irq);
 	hp_priv->config_control_bits &= ~IRQ_SELECT_MASK;
 	hp_priv->config_control_bits |= IRQ_SELECT_BITS(irq);
 	outb(hp_priv->config_control_bits, hp_priv->iobase[0] + CONFIG_CONTROL_STATUS_REG);
@@ -777,9 +773,7 @@ static int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *confi
 	     hp_priv->iobase[0] + EVENT_STATUS_REG);
 
 	tms9914_online(board, tms_priv);
-	pr_info("hp_82341: board id %x %x %x %x\n", inb(hp_priv->iobase[1] + ID0_REG),
-		inb(hp_priv->iobase[1] + ID1_REG), inb(hp_priv->iobase[2] + ID2_REG),
-		inb(hp_priv->iobase[2] + ID3_REG));
+
 	return 0;
 }
 
@@ -820,13 +814,13 @@ static int __init hp_82341_init_module(void)
 
 	ret = gpib_register_driver(&hp_82341_unaccel_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("hp_82341: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		return ret;
 	}
 
 	ret = gpib_register_driver(&hp_82341_interface, THIS_MODULE);
 	if (ret) {
-		pr_err("hp_82341: gpib_register_driver failed: error = %d\n", ret);
+		pr_err("gpib_register_driver failed: error = %d\n", ret);
 		gpib_unregister_driver(&hp_82341_unaccel_interface);
 		return ret;
 	}
@@ -871,7 +865,6 @@ static irqreturn_t hp_82341_interrupt(int irq, void *arg)
 
 	spin_lock_irqsave(&board->spinlock, flags);
 	event_status = inb(hp_priv->iobase[0] + EVENT_STATUS_REG);
-//	printk("hp_82341: interrupt event_status=0x%x\n", event_status);
 	if (event_status & INTERRUPT_PENDING_EVENT_BIT)
 		retval = IRQ_HANDLED;
 	//write-clear status bits
@@ -886,9 +879,6 @@ static irqreturn_t hp_82341_interrupt(int irq, void *arg)
 		status1 = read_byte(tms_priv, ISR0);
 		status2 = read_byte(tms_priv, ISR1);
 		tms9914_interrupt_have_status(board, tms_priv, status1, status2);
-/*		printk("hp_82341: interrupt status1=0x%x status2=0x%x\n",
- *			status1, status2);
- */
 	}
 	spin_unlock_irqrestore(&board->spinlock, flags);
 	return retval;
-- 
2.48.1


