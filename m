Return-Path: <linux-kernel+bounces-514880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED25A35CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5997516E7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D1F264A7F;
	Fri, 14 Feb 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qhf4pyJT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D83263F59
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533666; cv=none; b=V9iTBgW7ZJaFTFJu39Ox3JP+0QAevhM54feXOZ7n342+WYzD/pO6seUVS62lbibhMKlrEmlWxs2Y6BZtGI0UWos8lCu81qwvffKdwWDhOXrukN5A/9gj8aRSNGxNMfUYKAiTUaxQXPUeJXC6XBjBC4jhz31d8gXZ9i7RbuXAdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533666; c=relaxed/simple;
	bh=X2V/AscPrGN6rCLa9CXchKbt2yvYLR/HTYJSnSh8nH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa0O349O4rKMTkd28NAc+c/YxY5YCOHPcsakTb9EsRoWbL8828wfy44mtpAu6NNugpZvs/4mshZJREFFCozYKLIqzdCSeEhOJL7xcALaBO2X3O19LNfu86aix449x3l0QNYy/QOkEXYl+DDBIATvLzcxtTBi2SRMbRGn8RhmEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qhf4pyJT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so14035955e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533662; x=1740138462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPXYyRRrUg3eqcwUnNZ+3WfzPF/LnMYiUnRdR/lD1n0=;
        b=Qhf4pyJTre0LFLNZiR3X7NAZLbCNGIWnPs3fdtfbzk2WhIsR3knnqwyQgnppJ7/R3n
         K/JxmeEdmcClyDeg9N7Z4vw+ncvDOrJtSZkpSSleV2b9+X7CyMdVApZob05Fbf1YpvDS
         gCnGB0WDylB0suKnMxi0JBpNEcZ8bMgCn3lNWFaFd7cUYSr15twZKrpe7iAlkbyV7WJM
         yVo1ulHpnSF7r2zeXO3RggQIf1IJDIooyb/YbFNoCa351HwUF8wm71VGieZdr5FMoOXT
         /FMbITlnx4kNsEVjP+Uq45BWY9eBjhxtH12ovrUkPHp6zFYngDIXwKAUaYKQWYPzz7Ty
         7/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533662; x=1740138462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPXYyRRrUg3eqcwUnNZ+3WfzPF/LnMYiUnRdR/lD1n0=;
        b=vELwyx1+F0rltbr0VaEpU7sKlzFoRUdcxOdh9sZHtpgIUZGYpc29QzWYsrMfB7Ru5e
         giUdsPKpSf68zCZ4qco8S+PTsvJXaBcNNJzljtXZ3be9qHwIrdn09YdwqrhcukQnyJiN
         WnZ5FLcsoyJ3hilAm3gNAIfys+hesXpIShyl+l3gPFBlXYFOhMy+VaOksSeypqHZ1UJI
         b5xejC5iZWhdDvckcTnIp/8FMGLlxQ3gSc0dfwqigEHOdLF6JT4lty6QbjUUzRziofHR
         j9ZJMaIaSsQTiLKiwn9fohYRwUmh9XQddaeve1fVnnklcKNw7BtRIlyyoJmsLjxILlma
         RZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2KhmlO1+atH47SMKL5qDYxp6pXGRgLpIV8YRME2Pg5hU78YWaO7fEdKL3SpV9TnGomSxCH3veDYbdNyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTaV7rHYU16UyPvIkHIy8+FKLN3QwLy+NuJQJ7ApHZkRNCMtv
	8b7aT6FIxzl/UjzQVuPEOMQmPbkJleAlQWYmJrm2e91BuRJnST6O
X-Gm-Gg: ASbGnctfh1fAbpiKLTitEgl5C96U30G/CAYgDWhbM8VQ+ADd8wSZ/sgEW2oJtZsuhHq
	y5L29ipmYWYhQbZrnh4gu1oaCk33ItZSiXnl/Lwz5AtDvSZVL4WE652U8h0iccjqFBEupxRBj1/
	Bq+X82qwn0xvt++GEFcNtUsMwSd5XTcfDUwkr3RtB91qtFLT2fFkrrlzyJ5x1mzUW0+WWuGMwMU
	omCaeT7tbpHh7adDX19v4pNIRrXPl1Qhw2cp9IdeNovCWNka4ywE41DQdGbRtfIbi2ceOTyB7LU
	kOHUrX3Br/EoEeB8gxdwigp/xsV0DhQv+F39ILM0cMvEA1cnbzs=
X-Google-Smtp-Source: AGHT+IEWxbyp3feU463+AAXB3ggjhTJ0O4AkpwqK/PV7cnYXMcJfQCZBLfA+j+fBuOF1MEAGuiBJdQ==
X-Received: by 2002:a05:600c:4e02:b0:439:65ce:4044 with SMTP id 5b1f17b1804b1-43965ce41camr55833245e9.10.1739533661764;
        Fri, 14 Feb 2025 03:47:41 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:41 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 07/17] staging: gpib: fmh console messaging cleanup
Date: Fri, 14 Feb 2025 12:46:58 +0100
Message-ID: <20250214114708.28947-8-dpenkler@gmail.com>
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
string "fmh_gpib" in platform_driver and pci_driver structs.

Remove commented printk's.

Change pr_err to dev_err wherever possible

Remove "fmh_gpib_gpib:" prefix in messages since this is
printed with the module name.

Remove write interrupted dev_dbg messages.

Remove read wait interrupted pr_warn.

Change dev_notice attach to dev_dbg

Change dev_info to dev_dbg.

Correct dev_err message erroneously containing cb7210 identifier.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 140 +++++++++--------------
 1 file changed, 53 insertions(+), 87 deletions(-)

diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index f950e7cdd8f8..d62c83368518 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -12,6 +12,10 @@
  *	(C) 2017 Frank Mori Hess
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include "fmh_gpib.h"
 
 #include "gpibP.h"
@@ -334,7 +338,6 @@ static int wait_for_data_out_ready(gpib_board_t *board)
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	int retval = 0;
-//	printk("%s: enter\n", __FUNCTION__);
 
 	if (wait_event_interruptible(board->wait,
 				     (test_bit(TACS_NUM, &board->status) &&
@@ -348,7 +351,7 @@ static int wait_for_data_out_ready(gpib_board_t *board)
 		retval = -ETIMEDOUT;
 	if (test_and_clear_bit(DEV_CLEAR_BN, &nec_priv->state))
 		retval = -EINTR;
-//	printk("%s: exit, retval=%i\n", __FUNCTION__, retval);
+
 	return retval;
 }
 
@@ -360,7 +363,6 @@ static void fmh_gpib_dma_callback(void *arg)
 	unsigned long flags;
 
 	spin_lock_irqsave(&board->spinlock, flags);
-//	printk("%s: enter\n", __FUNCTION__);
 
 	nec7210_set_reg_bits(nec_priv, IMR1, HR_DOIE | HR_DIIE, HR_DOIE | HR_DIIE);
 	wake_up_interruptible(&board->wait);
@@ -370,7 +372,6 @@ static void fmh_gpib_dma_callback(void *arg)
 	clear_bit(DMA_WRITE_IN_PROGRESS_BN, &nec_priv->state);
 	clear_bit(DMA_READ_IN_PROGRESS_BN, &nec_priv->state);
 
-	//	printk("%s: exit\n", __FUNCTION__);
 	spin_unlock_irqrestore(&board->spinlock, flags);
 }
 
@@ -399,14 +400,13 @@ static int fmh_gpib_dma_write(gpib_board_t *board, uint8_t *buffer, size_t lengt
 	struct dma_async_tx_descriptor *tx_desc;
 
 	*bytes_written = 0;
-//	printk("%s: enter\n", __FUNCTION__);
 	if (WARN_ON_ONCE(length > e_priv->dma_buffer_size))
 		return -EFAULT;
 	dmaengine_terminate_all(e_priv->dma_channel);
 	memcpy(e_priv->dma_buffer, buffer, length);
 	address = dma_map_single(board->dev, e_priv->dma_buffer, length, DMA_TO_DEVICE);
 	if (dma_mapping_error(board->dev,  address))
-		pr_err("dma mapping error in dma write!\n");
+		dev_err(board->gpib_dev, "dma mapping error in dma write!\n");
 	/* program dma controller */
 	retval = fmh_gpib_config_dma(board, 1);
 	if (retval)
@@ -415,7 +415,7 @@ static int fmh_gpib_dma_write(gpib_board_t *board, uint8_t *buffer, size_t lengt
 	tx_desc = dmaengine_prep_slave_single(e_priv->dma_channel, address, length, DMA_MEM_TO_DEV,
 					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!tx_desc) {
-		pr_err("fmh_gpib_gpib: failed to allocate dma transmit descriptor\n");
+		dev_err(board->gpib_dev, "failed to allocate dma transmit descriptor\n");
 		retval = -ENOMEM;
 		goto cleanup;
 	}
@@ -432,19 +432,17 @@ static int fmh_gpib_dma_write(gpib_board_t *board, uint8_t *buffer, size_t lengt
 	dma_async_issue_pending(e_priv->dma_channel);
 	clear_bit(WRITE_READY_BN, &nec_priv->state);
 	set_bit(DMA_WRITE_IN_PROGRESS_BN, &nec_priv->state);
-//	printk("%s: in spin lock\n", __FUNCTION__);
+
 	spin_unlock_irqrestore(&board->spinlock, flags);
 
-//	printk("%s: waiting for write.\n", __FUNCTION__);
 	// suspend until message is sent
 	if (wait_event_interruptible(board->wait,
 				     fmh_gpib_all_bytes_are_sent(e_priv) ||
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		retval = -ERESTARTSYS;
-	}
+
 	if (test_bit(TIMO_NUM, &board->status))
 		retval = -ETIMEDOUT;
 	if (test_and_clear_bit(DEV_CLEAR_BN, &nec_priv->state))
@@ -464,12 +462,8 @@ static int fmh_gpib_dma_write(gpib_board_t *board, uint8_t *buffer, size_t lengt
 				   fifo_xfer_counter_mask);
 	if (WARN_ON_ONCE(*bytes_written > length))
 		return -EFAULT;
-	/*	printk("length=%i, *bytes_written=%i, residue=%i, retval=%i\n",
-	 *	length, *bytes_written, get_dma_residue(e_priv->dma_channel), retval);
-	 */
 cleanup:
 	dma_unmap_single(board->dev, address, length, DMA_TO_DEVICE);
-//	printk("%s: exit, retval=%d\n", __FUNCTION__, retval);
 	return retval;
 }
 
@@ -484,7 +478,7 @@ static int fmh_gpib_accel_write(gpib_board_t *board, uint8_t *buffer,
 	size_t dma_remainder = remainder;
 
 	if (!e_priv->dma_channel) {
-		pr_err("fmh_gpib_gpib: No dma channel available, cannot do accel write.");
+		dev_err(board->gpib_dev, "No dma channel available, cannot do accel write.");
 		return -ENXIO;
 	}
 
@@ -498,7 +492,6 @@ static int fmh_gpib_accel_write(gpib_board_t *board, uint8_t *buffer,
 
 	if (send_eoi)
 		--dma_remainder;
-//	printk("%s: entering while loop\n", __FUNCTION__);
 
 	while (dma_remainder > 0) {
 		size_t num_bytes;
@@ -524,7 +517,7 @@ static int fmh_gpib_accel_write(gpib_board_t *board, uint8_t *buffer,
 	//handle sending of last byte with eoi
 	if (send_eoi) {
 		size_t num_bytes;
-		//		printk("%s: handling last byte\n", __FUNCTION__);
+
 		if (WARN_ON_ONCE(remainder != 1))
 			return -EFAULT;
 
@@ -545,7 +538,6 @@ static int fmh_gpib_accel_write(gpib_board_t *board, uint8_t *buffer,
 			return retval;
 		remainder -= num_bytes;
 	}
-//	printk("%s: bytes send=%i\n", __FUNCTION__, (int)(length - remainder));
 	return 0;
 }
 
@@ -556,7 +548,7 @@ static int fmh_gpib_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
 
 	result = dmaengine_pause(chan);
 	if (result < 0)	{
-		pr_err("fmh_gpib_gpib: dma pause failed?\n");
+		pr_err("dma pause failed?\n");
 		return result;
 	}
 	dmaengine_tx_status(chan, cookie, &state);
@@ -570,7 +562,6 @@ static int wait_for_tx_fifo_half_empty(gpib_board_t *board)
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	int retval = 0;
-//	printk("%s: enter\n", __FUNCTION__);
 
 	if (wait_event_interruptible(board->wait,
 				     (test_bit(TACS_NUM, &board->status) &&
@@ -584,7 +575,7 @@ static int wait_for_tx_fifo_half_empty(gpib_board_t *board)
 		retval = -ETIMEDOUT;
 	if (test_and_clear_bit(DEV_CLEAR_BN, &nec_priv->state))
 		retval = -EINTR;
-//	printk("%s: exit, retval=%i\n", __FUNCTION__, retval);
+
 	return retval;
 }
 
@@ -600,7 +591,6 @@ static int fmh_gpib_fifo_write_countable(gpib_board_t *board, uint8_t *buffer,
 	unsigned int remainder;
 
 	*bytes_written = 0;
-//	printk("%s: enter\n", __FUNCTION__);
 	if (WARN_ON_ONCE(length > fifo_xfer_counter_mask))
 		return -EFAULT;
 
@@ -635,10 +625,9 @@ static int fmh_gpib_fifo_write_countable(gpib_board_t *board, uint8_t *buffer,
 				     fmh_gpib_all_bytes_are_sent(e_priv) ||
 				     test_bit(BUS_ERROR_BN, &nec_priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		retval = -ERESTARTSYS;
-	}
+
 	if (test_bit(TIMO_NUM, &board->status))
 		retval = -ETIMEDOUT;
 	if (test_and_clear_bit(DEV_CLEAR_BN, &nec_priv->state))
@@ -655,11 +644,7 @@ static int fmh_gpib_fifo_write_countable(gpib_board_t *board, uint8_t *buffer,
 				   fifo_xfer_counter_mask);
 	if (WARN_ON_ONCE(*bytes_written > length))
 		return -EFAULT;
-	/*	printk("length=%i, *bytes_written=%i, residue=%i, retval=%i\n",
-	 *	length, *bytes_written, get_dma_residue(e_priv->dma_channel), retval);
-	 */
 
-//	printk("%s: exit, retval=%d\n", __FUNCTION__, retval);
 	return retval;
 }
 
@@ -678,8 +663,6 @@ static int fmh_gpib_fifo_write(gpib_board_t *board, uint8_t *buffer, size_t leng
 
 	clear_bit(DEV_CLEAR_BN, &nec_priv->state); // XXX FIXME
 
-//	printk("%s: entering while loop\n", __FUNCTION__);
-
 	while (remainder > 0) {
 		size_t num_bytes;
 		int last_pass;
@@ -708,7 +691,7 @@ static int fmh_gpib_fifo_write(gpib_board_t *board, uint8_t *buffer, size_t leng
 		if (need_resched())
 			schedule();
 	}
-//	printk("%s: bytes send=%i\n", __FUNCTION__, (int)(length - remainder));
+
 	return retval;
 }
 
@@ -725,10 +708,6 @@ static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
 	struct dma_async_tx_descriptor *tx_desc;
 	dma_cookie_t dma_cookie;
 
-	//	printk("%s: enter, bus_address=0x%x, length=%i\n", __FUNCTION__,
-	//(unsigned)bus_address,
-//		   (int)length);
-
 	*bytes_read = 0;
 	*end = 0;
 	if (length == 0)
@@ -737,7 +716,7 @@ static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
 	bus_address = dma_map_single(board->dev, e_priv->dma_buffer,
 				     length, DMA_FROM_DEVICE);
 	if (dma_mapping_error(board->dev, bus_address))
-		pr_err("dma mapping error in dma read!");
+		dev_err(board->gpib_dev, "dma mapping error in dma read!");
 
 	/* program dma controller */
 	retval = fmh_gpib_config_dma(board, 0);
@@ -749,7 +728,7 @@ static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
 					      length, DMA_DEV_TO_MEM,
 					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!tx_desc)  {
-		pr_err("fmh_gpib_gpib: failed to allocate dma transmit descriptor\n");
+		dev_err(board->gpib_dev, "failed to allocate dma transmit descriptor\n");
 		dma_unmap_single(board->dev, bus_address, length, DMA_FROM_DEVICE);
 		return -EIO;
 	}
@@ -769,7 +748,7 @@ static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
 	set_bit(DMA_READ_IN_PROGRESS_BN, &nec_priv->state);
 
 	spin_unlock_irqrestore(&board->spinlock, flags);
-//	printk("waiting for data transfer.\n");
+
 	// wait for data to transfer
 	wait_retval = wait_event_interruptible(board->wait,
 					       test_bit(DMA_READ_IN_PROGRESS_BN, &nec_priv->state)
@@ -777,10 +756,9 @@ static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
 					       test_bit(RECEIVED_END_BN, &nec_priv->state) ||
 					       test_bit(DEV_CLEAR_BN, &nec_priv->state) ||
 					       test_bit(TIMO_NUM, &board->status));
-	if (wait_retval) {
-		pr_warn("fmh_gpib: dma read wait interrupted\n");
+	if (wait_retval)
 		retval = -ERESTARTSYS;
-	}
+
 	if (test_bit(TIMO_NUM, &board->status))
 		retval = -ETIMEDOUT;
 	if (test_bit(DEV_CLEAR_BN, &nec_priv->state))
@@ -825,8 +803,6 @@ static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
 			*end = 1;
 	}
 	spin_unlock_irqrestore(&board->spinlock, flags);
-//	printk("\tbytes_read=%i, residue=%i, end=%i, retval=%i, wait_retval=%i\n",
-//		   *bytes_read, residue, *end, retval, wait_retval);
 
 	return retval;
 }
@@ -925,10 +901,6 @@ static int fmh_gpib_fifo_read_countable(gpib_board_t *board, uint8_t *buffer,
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	int retval = 0;
 
-	//	printk("%s: enter, bus_address=0x%x, length=%i\n", __FUNCTION__,
-	// (unsigned)bus_address,
-//		   (int)length);
-
 	*bytes_read = 0;
 	*end = 0;
 	if (length == 0)
@@ -977,9 +949,6 @@ static int fmh_gpib_fifo_read_countable(gpib_board_t *board, uint8_t *buffer,
 			*end = 1;
 	}
 
-//	printk("\tbytes_read=%i, end=%i, retval=%i, wait_retval=%i\n",
-//		   *bytes_read, *end, retval, wait_retval);
-
 	return retval;
 }
 
@@ -1376,7 +1345,7 @@ static int fmh_gpib_device_match(struct device *dev, const void *data)
 	if (config->serial_number)
 		return 0;
 
-	dev_notice(dev, "matched: %s\n", of_node_full_name(dev_of_node((dev))));
+	dev_dbg(dev, "matched: %s\n", of_node_full_name(dev_of_node((dev))));
 	return 1;
 }
 
@@ -1393,7 +1362,7 @@ static int fmh_gpib_attach_impl(gpib_board_t *board, const gpib_board_config_t *
 	board->dev = driver_find_device(&fmh_gpib_platform_driver.driver,
 					NULL, (const void *)config, &fmh_gpib_device_match);
 	if (!board->dev)	{
-		pr_err("No matching fmh_gpib_core device was found, attach failed.");
+		dev_err(board->gpib_dev, "No matching fmh_gpib_core device was found, attach failed.");
 		return -ENODEV;
 	}
 	// currently only used to mark the device as already attached
@@ -1409,7 +1378,7 @@ static int fmh_gpib_attach_impl(gpib_board_t *board, const gpib_board_config_t *
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpib_control_status");
 	if (!res) {
-		dev_err(board->dev, "Unable to locate mmio resource for cb7210 gpib\n");
+		dev_err(board->dev, "Unable to locate mmio resource\n");
 		return -ENODEV;
 	}
 
@@ -1422,13 +1391,13 @@ static int fmh_gpib_attach_impl(gpib_board_t *board, const gpib_board_config_t *
 	e_priv->gpib_iomem_res = res;
 
 	nec_priv->mmiobase = ioremap(e_priv->gpib_iomem_res->start,
-				   resource_size(e_priv->gpib_iomem_res));
+				     resource_size(e_priv->gpib_iomem_res));
 	if (!nec_priv->mmiobase) {
-		dev_err(board->dev, "Could not map I/O memory for gpib\n");
+		dev_err(board->dev, "Could not map I/O memory\n");
 		return -ENOMEM;
 	}
-	dev_info(board->dev, "iobase %pr remapped to %p\n",
-		 e_priv->gpib_iomem_res, nec_priv->mmiobase);
+	dev_dbg(board->dev, "iobase %pr remapped to %p\n",
+		e_priv->gpib_iomem_res, nec_priv->mmiobase);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos");
 	if (!res) {
@@ -1448,14 +1417,13 @@ static int fmh_gpib_attach_impl(gpib_board_t *board, const gpib_board_config_t *
 		dev_err(board->dev, "Could not map I/O memory for fifos\n");
 		return -ENOMEM;
 	}
-	dev_info(board->dev, "dma fifos 0x%lx remapped to %p, length=%ld\n",
-		 (unsigned long)e_priv->dma_port_res->start, e_priv->fifo_base,
-		 (unsigned long)resource_size(e_priv->dma_port_res));
+	dev_dbg(board->dev, "dma fifos 0x%lx remapped to %p, length=%ld\n",
+		(unsigned long)e_priv->dma_port_res->start, e_priv->fifo_base,
+		(unsigned long)resource_size(e_priv->dma_port_res));
 
 	irq = platform_get_irq(pdev, 0);
-	pr_info("gpib: irq %d\n", irq);
 	if (irq < 0) {
-		dev_err(board->dev, "fmh_gpib_gpib: request for IRQ failed\n");
+		dev_err(board->dev, "request for IRQ failed\n");
 		return -EBUSY;
 	}
 	retval = request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev->name, board);
@@ -1546,7 +1514,7 @@ static int fmh_gpib_pci_attach_impl(gpib_board_t *board, const gpib_board_config
 	pci_device = gpib_pci_get_device(config, BOGUS_PCI_VENDOR_ID_FLUKE,
 					 BOGUS_PCI_DEVICE_ID_FLUKE_BLADERUNNER, NULL);
 	if (!pci_device)	{
-		pr_err("No matching fmh_gpib_core pci device was found, attach failed.");
+		dev_err(board->gpib_dev, "No matching fmh_gpib_core pci device was found, attach failed.");
 		return -ENODEV;
 	}
 	board->dev = &pci_device->dev;
@@ -1563,34 +1531,32 @@ static int fmh_gpib_pci_attach_impl(gpib_board_t *board, const gpib_board_config
 		return -EIO;
 	}
 	e_priv->gpib_iomem_res = &pci_device->resource[gpib_control_status_pci_resource_index];
-	e_priv->dma_port_res =  &pci_device->resource[gpib_fifo_pci_resource_index];
+	e_priv->dma_port_res =	&pci_device->resource[gpib_fifo_pci_resource_index];
 
 	nec_priv->mmiobase = ioremap(pci_resource_start(pci_device,
-						      gpib_control_status_pci_resource_index),
-				   pci_resource_len(pci_device,
-						    gpib_control_status_pci_resource_index));
-	dev_info(board->dev, "base address for gpib control/status registers remapped to 0x%p\n",
-		 nec_priv->mmiobase);
+							gpib_control_status_pci_resource_index),
+				     pci_resource_len(pci_device,
+						      gpib_control_status_pci_resource_index));
+	dev_dbg(board->dev, "base address for gpib control/status registers remapped to 0x%p\n",
+		nec_priv->mmiobase);
 
 	if (e_priv->dma_port_res->flags & IORESOURCE_MEM) {
 		e_priv->fifo_base = ioremap(pci_resource_start(pci_device,
 							       gpib_fifo_pci_resource_index),
 					    pci_resource_len(pci_device,
 							     gpib_fifo_pci_resource_index));
-		dev_info(board->dev, "base address for gpib fifo registers remapped to 0x%p\n",
-			 e_priv->fifo_base);
+		dev_dbg(board->dev, "base address for gpib fifo registers remapped to 0x%p\n",
+			e_priv->fifo_base);
 	} else {
 		e_priv->fifo_base = NULL;
-		dev_info(board->dev, "hardware has no gpib fifo registers.\n");
+		dev_dbg(board->dev, "hardware has no gpib fifo registers.\n");
 	}
 
 	if (pci_device->irq) {
 		retval = request_irq(pci_device->irq, fmh_gpib_interrupt, IRQF_SHARED,
 				     KBUILD_MODNAME, board);
 		if (retval) {
-			dev_err(board->dev,
-				"cannot register interrupt handler err=%d\n",
-				retval);
+			dev_err(board->dev, "cannot register interrupt handler err=%d\n", retval);
 			return retval;
 		}
 	}
@@ -1615,7 +1581,7 @@ int fmh_gpib_pci_attach_holdoff_end(gpib_board_t *board, const gpib_board_config
 	retval = fmh_gpib_pci_attach_impl(board, config, HR_HLDE);
 	e_priv = board->private_data;
 	if (retval == 0 && e_priv && e_priv->supports_fifo_interrupts == 0) {
-		pr_err("fmh_gpib: your fmh_gpib_core does not appear to support fifo interrupts.  Try the fmh_gpib_pci_unaccel board type instead.");
+		dev_err(board->gpib_dev, "your fmh_gpib_core does not appear to support fifo interrupts.  Try the fmh_gpib_pci_unaccel board type instead.");
 		return -EIO;
 	}
 	return retval;
@@ -1662,7 +1628,7 @@ MODULE_DEVICE_TABLE(of, fmh_gpib_of_match);
 
 static struct platform_driver fmh_gpib_platform_driver = {
 	.driver = {
-		.name = "fmh_gpib",
+		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 		.of_match_table = fmh_gpib_of_match,
 	},
@@ -1681,7 +1647,7 @@ static const struct pci_device_id fmh_gpib_pci_match[] = {
 MODULE_DEVICE_TABLE(pci, fmh_gpib_pci_match);
 
 static struct pci_driver fmh_gpib_pci_driver = {
-	.name = "fmh_gpib",
+	.name = DRV_NAME,
 	.id_table = fmh_gpib_pci_match,
 	.probe = &fmh_gpib_pci_probe
 };
@@ -1692,37 +1658,37 @@ static int __init fmh_gpib_init_module(void)
 
 	result = platform_driver_register(&fmh_gpib_platform_driver);
 	if (result) {
-		pr_err("fmh_gpib: platform_driver_register failed: error = %d\n", result);
+		pr_err("platform_driver_register failed: error = %d\n", result);
 		return result;
 	}
 
 	result = pci_register_driver(&fmh_gpib_pci_driver);
 	if (result) {
-		pr_err("fmh_gpib: pci_register_driver failed: error = %d\n", result);
+		pr_err("pci_register_driver failed: error = %d\n", result);
 		goto err_pci_driver;
 	}
 
 	result = gpib_register_driver(&fmh_gpib_unaccel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("fmh_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_unaccel;
 	}
 
 	result = gpib_register_driver(&fmh_gpib_interface, THIS_MODULE);
 	if (result) {
-		pr_err("fmh_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_interface;
 	}
 
 	result = gpib_register_driver(&fmh_gpib_pci_unaccel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("fmh_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_pci_unaccel;
 	}
 
 	result = gpib_register_driver(&fmh_gpib_pci_interface, THIS_MODULE);
 	if (result) {
-		pr_err("fmh_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_pci;
 	}
 
-- 
2.48.1


