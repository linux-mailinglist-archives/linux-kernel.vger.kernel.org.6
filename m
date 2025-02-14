Return-Path: <linux-kernel+bounces-514879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A81FA35CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76DE16D2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D35264A63;
	Fri, 14 Feb 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0UK8xbe"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA858263F46
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533665; cv=none; b=Y/xFnKP6FLv/fa4TeuEiP35sIuX2BJTnrlSEMde01S1zUtrCskufQRlApL2QE/sXa/PF0sPussrIwNHE2ej2Cdyh1JshTVt9dYTIzGy6p6JdUK/4vpr+0V1ZHhuShHZXkxTZJydp9XngGpIV6xI24OA5BN6dRalyH12n7u2OTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533665; c=relaxed/simple;
	bh=V6W9bEnZKDxzkckFLC5A1x2JWYHjHbuBEOadpITQ0jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InRIiJisw7gm/qa0AW/B5ZjRHPeMiFHJJKsT/VUXY80oj+VUgmlJYZXF92Yj3c3QL+NwBWodJgh1epjMg8v7ihWzWx1dmM8ypx6kIS9QjiYK8pD9X6dSii6hB+sull3l2mQ/GKDC6258voa5ZjHl7++dJVuMSakrfNTWymw0dgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0UK8xbe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso12047945e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533661; x=1740138461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1d8ytn1sN3HFgOXuhxGigoThdZCA5Wo4+9KBTULduPI=;
        b=b0UK8xbePN86yulHG0WnpNy8ACThWa/+DUDJ2mm9d894kW6R4wXw+rytkcOI6OXEex
         gvqtbYZwcfH+2s23GvUIAY3eB9MR7E7LMoejBKw2QW/6+DN/PbcBJCuRebCbrhlT4Gll
         llek0aE662vGUuQ0SUKAHJsNMn1pVllk0vijm2/+bNGq8ufJtLDWmwk4NvLsyKxYk+eP
         dvFqfQ2cYfN2CkNyv1Pqfh+ZA9T/d0Ey+Gy1R2jFv548EWmFIhCWxZE9dX8f7bPEZDJ5
         DNM5P26bktcvL+LxcPL+X7puuOcZKE3Nd2DmMIJFInKyvPihpba6FBblkhtNRLqk/Y8N
         5f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533661; x=1740138461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1d8ytn1sN3HFgOXuhxGigoThdZCA5Wo4+9KBTULduPI=;
        b=dVgLu36ezNaM35iP5NvAV10sDXo2oynhEPbBy9mhDgW4D1v345e8LzZRy2qLo+giQS
         Ze0U9lAvKxxUAed+jh6kuUFf2D44JiYK0VIgMvu950/vYwqWf4FtvzNxLigljTx6CD+3
         xZS/8DyZEFP+KQVpGibbXWyS7ezqokDVo6GqX6nWrpHvKmt3AMLiun1vbVSOXiAymlVm
         jY5kPkLC63eV6nc4pKTZF5uHwMh1y71XpXxXI+FoiysKuEfckwaKEqwoxXeQqITR1aXo
         5DzGeNTxlOMQhNJtvidx5kpUlEbTrVSQnaouksY/r8ybcF7NMqF+pRFleVu2B4XeWHw1
         PcCA==
X-Forwarded-Encrypted: i=1; AJvYcCU11y88dz4Kmzjt/4/zUDEyE5tB1ZAnJdRGCRL+Fn5lv2zKQzrs0fXyFlcgskpDhW64ZcpwntbUn0q/EBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm2/NT1NWA3hHvKPiHv0HCQdztWb/8gLQrt0T7dPpdFCrSQ2fk
	kkAIZNhs0oknzc8hq9bbJt8Gcm6trJGzaXNmggZfuGrYTpBZMKEANafxtw==
X-Gm-Gg: ASbGnctxJM+52QmNFgb/Z8zdbFOvwRuB4hkSWqprn3/a6QhnYGWSY1SHi66yMzOeBHS
	91viKfPy2hFtZLgDW5gO0gnTnFNQFYtOdNBsw/xgAM4OKiGzVwKrZdkAl6a8f31I6HnRDg359Ff
	jvN7Qr/6MochVfvc5G7vstH8qwtR6O3nj/+RWQY8Z4Qp3DUC8rVh0eiOUR3vqjOJgkLLwItrr7v
	zuIpKJPbGLwPrczkEPBkX1D6gCwoR9L+vTzFqfq8hDa0t8F4UjCk1Hyc4QMybbtukxvoSmZF0mf
	/lmvvKJ5xhzB2HY2Z5bYTp0suSBJpwC/6rWrRorUxcKtK8uuzQQ=
X-Google-Smtp-Source: AGHT+IF8FNELQILeKnXkaoYyKgX5j1AV5slhoBBsRzfDYVxVDrcKb8VfMpgJzmJF+NGBZiVwPpv2iQ==
X-Received: by 2002:a05:600c:4587:b0:434:ffb2:f9cf with SMTP id 5b1f17b1804b1-43960ecb02cmr77864185e9.14.1739533660649;
        Fri, 14 Feb 2025 03:47:40 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:39 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 06/17] staging: gpib: fluke console messaging cleanup
Date: Fri, 14 Feb 2025 12:46:57 +0100
Message-ID: <20250214114708.28947-7-dpenkler@gmail.com>
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
string "fluke_gpib" in platform_driver struct.

Remove commented printk's.

Change pr_err to dev_err wherever possible

Remove "fluke_gpib:" prefix in messages since this is
printed with the module name.

Correct dev_err message erroneously containing cb7210 identifier.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/eastwood/fluke_gpib.c | 90 +++++++---------------
 1 file changed, 27 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index d5b1a03abf11..012ce9cb8999 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -7,6 +7,10 @@
  *   copyright: (C) 2006, 2010, 2015 Fluke Corporation
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include "fluke_gpib.h"
 
 #include "gpibP.h"
@@ -263,9 +267,9 @@ static int wait_for_read(gpib_board_t *board)
 	if (wait_event_interruptible(board->wait,
 				     lacs_or_read_ready(board) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
+				     test_bit(TIMO_NUM, &board->status)))
 		retval = -ERESTARTSYS;
-	}
+
 	if (test_bit(TIMO_NUM, &board->status))
 		retval = -ETIMEDOUT;
 	if (test_and_clear_bit(DEV_CLEAR_BN, &nec_priv->state))
@@ -316,20 +320,17 @@ static int wait_for_data_out_ready(gpib_board_t *board)
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	int retval = 0;
-//	printk("%s: enter\n", __FUNCTION__);
 
 	if (wait_event_interruptible(board->wait,
 				     (test_bit(TACS_NUM, &board->status) &&
 				      source_handshake_is_sgns(e_priv)) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
+				     test_bit(TIMO_NUM, &board->status)))
 		retval = -ERESTARTSYS;
-	}
 	if (test_bit(TIMO_NUM, &board->status))
 		retval = -ETIMEDOUT;
 	if (test_and_clear_bit(DEV_CLEAR_BN, &nec_priv->state))
 		retval = -EINTR;
-//	printk("%s: exit, retval=%i\n", __FUNCTION__, retval);
 	return retval;
 }
 
@@ -338,7 +339,6 @@ static int wait_for_sids_or_sgns(gpib_board_t *board)
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	int retval = 0;
-//	printk("%s: enter\n", __FUNCTION__);
 
 	if (wait_event_interruptible(board->wait,
 				     source_handshake_is_sids_or_sgns(e_priv) ||
@@ -350,7 +350,6 @@ static int wait_for_sids_or_sgns(gpib_board_t *board)
 		retval = -ETIMEDOUT;
 	if (test_and_clear_bit(DEV_CLEAR_BN, &nec_priv->state))
 		retval = -EINTR;
-//	printk("%s: exit, retval=%i\n", __FUNCTION__, retval);
 	return retval;
 }
 
@@ -362,7 +361,6 @@ static void fluke_dma_callback(void *arg)
 	unsigned long flags;
 
 	spin_lock_irqsave(&board->spinlock, flags);
-//	printk("%s: enter\n", __FUNCTION__);
 
 	nec7210_set_reg_bits(nec_priv, IMR1, HR_DOIE | HR_DIIE, HR_DOIE | HR_DIIE);
 	wake_up_interruptible(&board->wait);
@@ -370,7 +368,7 @@ static void fluke_dma_callback(void *arg)
 	fluke_gpib_internal_interrupt(board);
 	clear_bit(DMA_WRITE_IN_PROGRESS_BN, &nec_priv->state);
 	clear_bit(DMA_READ_IN_PROGRESS_BN, &nec_priv->state);
-//	printk("%s: exit\n", __FUNCTION__);
+
 	spin_unlock_irqrestore(&board->spinlock, flags);
 }
 
@@ -385,7 +383,7 @@ static int fluke_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	struct dma_async_tx_descriptor *tx_desc;
 
 	*bytes_written = 0;
-//	printk("%s: enter\n", __FUNCTION__);
+
 	if (WARN_ON_ONCE(length > e_priv->dma_buffer_size))
 		return -EFAULT;
 	dmaengine_terminate_all(e_priv->dma_channel);
@@ -403,7 +401,7 @@ static int fluke_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	tx_desc = dmaengine_prep_slave_single(e_priv->dma_channel, address, length, DMA_MEM_TO_DEV,
 					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!tx_desc) {
-		pr_err("fluke_gpib: failed to allocate dma transmit descriptor\n");
+		dev_err(board->gpib_dev, "failed to allocate dma transmit descriptor\n");
 		retval = -ENOMEM;
 		goto cleanup;
 	}
@@ -419,10 +417,8 @@ static int fluke_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	clear_bit(WRITE_READY_BN, &nec_priv->state);
 	set_bit(DMA_WRITE_IN_PROGRESS_BN, &nec_priv->state);
 
-	//	printk("%s: in spin lock\n", __FUNCTION__);
 	spin_unlock_irqrestore(&board->spinlock, flags);
 
-//	printk("%s: waiting for write.\n", __FUNCTION__);
 	// suspend until message is sent
 	if (wait_event_interruptible(board->wait,
 				     ((readl(e_priv->write_transfer_counter) &
@@ -430,7 +426,6 @@ static int fluke_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -459,7 +454,6 @@ static int fluke_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 
 cleanup:
 	dma_unmap_single(board->dev, address, length, DMA_TO_DEVICE);
-//	printk("%s: exit, retval=%d\n", __FUNCTION__, retval);
 	return retval;
 }
 
@@ -474,7 +468,7 @@ static int fluke_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length
 	size_t dma_remainder = remainder;
 
 	if (!e_priv->dma_channel) {
-		pr_err("fluke_gpib: No dma channel available, cannot do accel write.");
+		dev_err(board->gpib_dev, "No dma channel available, cannot do accel write.");
 		return -ENXIO;
 	}
 
@@ -486,7 +480,6 @@ static int fluke_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length
 
 	if (send_eoi)
 		--dma_remainder;
-//	printk("%s: entering while loop\n", __FUNCTION__);
 
 	while (dma_remainder > 0) {
 		size_t num_bytes;
@@ -512,7 +505,7 @@ static int fluke_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length
 	//handle sending of last byte with eoi
 	if (send_eoi) {
 		size_t num_bytes;
-		//		printk("%s: handling last byte\n", __FUNCTION__);
+
 		if (WARN_ON_ONCE(remainder != 1))
 			return -EFAULT;
 
@@ -533,7 +526,6 @@ static int fluke_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length
 			return retval;
 		remainder -= num_bytes;
 	}
-//	printk("%s: bytes send=%i\n", __FUNCTION__, (int)(length - remainder));
 	return 0;
 }
 
@@ -544,7 +536,7 @@ static int fluke_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
 
 	result = dmaengine_pause(chan);
 	if (result < 0) {
-		pr_err("fluke_gpib: dma pause failed?\n");
+		pr_err("dma pause failed?\n");
 		return result;
 	}
 	dmaengine_tx_status(chan, cookie, &state);
@@ -567,10 +559,6 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
 	int i;
 	static const int timeout = 10;
 
-	//	printk("%s: enter, bus_address=0x%x, length=%i\n", __FUNCTION__,
-	//	       (unsigned)bus_address,
-	//	       (int)length);
-
 	*bytes_read = 0;
 	*end = 0;
 	if (length == 0)
@@ -589,7 +577,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
 					      bus_address, length, DMA_DEV_TO_MEM,
 					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!tx_desc) {
-		pr_err("fluke_gpib: failed to allocate dma transmit descriptor\n");
+		dev_err(board->gpib_dev, "failed to allocate dma transmit descriptor\n");
 		dma_unmap_single(NULL, bus_address, length, DMA_FROM_DEVICE);
 		return -EIO;
 	}
@@ -608,14 +596,12 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
 	clear_bit(READ_READY_BN, &nec_priv->state);
 
 	spin_unlock_irqrestore(&board->spinlock, flags);
-//	printk("waiting for data transfer.\n");
 	// wait for data to transfer
 	if (wait_event_interruptible(board->wait,
 				     test_bit(DMA_READ_IN_PROGRESS_BN, &nec_priv->state) == 0 ||
 				     test_bit(RECEIVED_END_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 				     test_bit(TIMO_NUM, &board->status))) {
-		pr_warn("fluke: dma read wait interrupted\n");
 		retval = -ERESTARTSYS;
 	}
 	if (test_bit(TIMO_NUM, &board->status))
@@ -682,10 +668,6 @@ static int fluke_accel_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	int retval = 0;
 	size_t dma_nbytes;
 
-/*	printk("%s: enter, buffer=0x%p, length=%i\n", __FUNCTION__,
- *		   buffer, (int)length);
- *	printk("\t dma_buffer=0x%p\n", e_priv->dma_buffer);
- */
 	*end = 0;
 	*bytes_read = 0;
 
@@ -699,7 +681,6 @@ static int fluke_accel_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 
 	nec7210_release_rfd_holdoff(board, nec_priv);
 
-//	printk("%s: entering while loop\n", __FUNCTION__);
 	while (remain > 0) {
 		transfer_size = (e_priv->dma_buffer_size < remain) ?
 			e_priv->dma_buffer_size : remain;
@@ -709,14 +690,12 @@ static int fluke_accel_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 		*bytes_read += dma_nbytes;
 		if (*end)
 			break;
-		if (retval < 0)	{
-//			printk("%s: early exit, retval=%i\n", __FUNCTION__, (int)retval);
+		if (retval < 0)
 			return retval;
-		}
 		if (need_resched())
 			schedule();
 	}
-//	printk("%s: exit, retval=%i\n", __FUNCTION__, (int)retval);
+
 	return retval;
 }
 
@@ -830,13 +809,6 @@ irqreturn_t fluke_gpib_internal_interrupt(gpib_board_t *board)
 
 	if (nec7210_interrupt_have_status(board, nec_priv, status1, status2) == IRQ_HANDLED)
 		retval = IRQ_HANDLED;
-/*
- *	if((status1 & nec_priv->reg_bits[IMR1]) ||
- *		(status2 & (nec_priv->reg_bits[IMR2] & IMR2_ENABLE_INTR_MASK)))
- *	{
- *		printk("fluke: status1 0x%x, status2 0x%x\n", status1, status2);
- *	}
- */
 
 	if (read_byte(nec_priv, ADR0) & DATA_IN_STATUS)	{
 		if (test_bit(RFD_HOLDOFF_BN, &nec_priv->state))
@@ -954,7 +926,7 @@ static int fluke_init(struct fluke_priv *e_priv, gpib_board_t *board, int handsh
 
 	/* poll so we can detect ATN changes */
 	if (gpib_request_pseudo_irq(board, fluke_gpib_interrupt)) {
-		pr_err("fluke_gpib: failed to allocate pseudo_irq\n");
+		dev_err(board->gpib_dev, "failed to allocate pseudo_irq\n");
 		return -EINVAL;
 	}
 
@@ -984,7 +956,7 @@ static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *con
 	dma_cap_mask_t dma_cap;
 
 	if (!fluke_gpib_pdev) {
-		pr_err("No gpib platform device was found, attach failed.\n");
+		dev_err(board->gpib_dev, "No fluke device was found, attach failed.\n");
 		return -ENODEV;
 	}
 
@@ -999,7 +971,7 @@ static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *con
 
 	res = platform_get_resource(fluke_gpib_pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_err(&fluke_gpib_pdev->dev, "Unable to locate mmio resource for cb7210 gpib\n");
+		dev_err(&fluke_gpib_pdev->dev, "Unable to locate mmio resource\n");
 		return -ENODEV;
 	}
 
@@ -1012,10 +984,7 @@ static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *con
 	e_priv->gpib_iomem_res = res;
 
 	nec_priv->mmiobase = ioremap(e_priv->gpib_iomem_res->start,
-				   resource_size(e_priv->gpib_iomem_res));
-	pr_info("gpib: mmiobase %llx remapped to %p, length=%d\n",
-		(u64)e_priv->gpib_iomem_res->start,
-		nec_priv->mmiobase, (int)resource_size(e_priv->gpib_iomem_res));
+				     resource_size(e_priv->gpib_iomem_res));
 	if (!nec_priv->mmiobase) {
 		dev_err(&fluke_gpib_pdev->dev, "Could not map I/O memory\n");
 		return -ENOMEM;
@@ -1050,19 +1019,14 @@ static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *con
 
 	e_priv->write_transfer_counter = ioremap(e_priv->write_transfer_counter_res->start,
 						 resource_size(e_priv->write_transfer_counter_res));
-	pr_info("gpib: write transfer counter %lx remapped to %p, length=%d\n",
-		(unsigned long)e_priv->write_transfer_counter_res->start,
-		e_priv->write_transfer_counter,
-		(int)resource_size(e_priv->write_transfer_counter_res));
 	if (!e_priv->write_transfer_counter) {
 		dev_err(&fluke_gpib_pdev->dev, "Could not map I/O memory\n");
 		return -ENOMEM;
 	}
 
 	irq = platform_get_irq(fluke_gpib_pdev, 0);
-	pr_info("gpib: irq %d\n", irq);
 	if (irq < 0) {
-		dev_err(&fluke_gpib_pdev->dev, "fluke_gpib: request for IRQ failed\n");
+		dev_err(&fluke_gpib_pdev->dev, "failed to obtain IRQ\n");
 		return -EBUSY;
 	}
 	retval = request_irq(irq, fluke_gpib_interrupt, isr_flags, fluke_gpib_pdev->name, board);
@@ -1078,7 +1042,7 @@ static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *con
 	dma_cap_set(DMA_SLAVE, dma_cap);
 	e_priv->dma_channel = dma_request_channel(dma_cap, gpib_dma_channel_filter, NULL);
 	if (!e_priv->dma_channel) {
-		pr_err("fluke_gpib: failed to allocate a dma channel.\n");
+		dev_err(board->gpib_dev, "failed to allocate a dma channel.\n");
 		// we don't error out here because unaccel interface will still
 		// work without dma
 	}
@@ -1142,7 +1106,7 @@ MODULE_DEVICE_TABLE(of, fluke_gpib_of_match);
 
 static struct platform_driver fluke_gpib_platform_driver = {
 	.driver = {
-		.name = "fluke_gpib",
+		.name = DRV_NAME,
 		.of_match_table = fluke_gpib_of_match,
 	},
 	.probe = &fluke_gpib_probe
@@ -1154,25 +1118,25 @@ static int __init fluke_init_module(void)
 
 	result = platform_driver_register(&fluke_gpib_platform_driver);
 	if (result) {
-		pr_err("fluke_gpib: platform_driver_register failed: error = %d\n", result);
+		pr_err("platform_driver_register failed: error = %d\n", result);
 		return result;
 	}
 
 	result = gpib_register_driver(&fluke_unaccel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("fluke_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_unaccel;
 	}
 
 	result = gpib_register_driver(&fluke_hybrid_interface, THIS_MODULE);
 	if (result) {
-		pr_err("fluke_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_hybrid;
 	}
 
 	result = gpib_register_driver(&fluke_interface, THIS_MODULE);
 	if (result) {
-		pr_err("fluke_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_interface;
 	}
 
-- 
2.48.1


