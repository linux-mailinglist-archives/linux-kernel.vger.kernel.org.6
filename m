Return-Path: <linux-kernel+bounces-514885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E3A35CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F4A3AE315
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C6265CB9;
	Fri, 14 Feb 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXaUriyt"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC48265CA6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533674; cv=none; b=Ob0tyGSetm0TUx/tbg/3wf/zxH5vrhWXpmnMxGOT5izd5KihSljn88C3l8xhs+FYCVANTLh1sH5oQJopC0mqlmGI/Mc0ikxWL/lgKGCPSfXRUMreICl63fe3oVhmiQqQE43WRscfPhhWpJY5c6Tek/IkMST9pjKtZC++jVwHUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533674; c=relaxed/simple;
	bh=/2y5Ij85lRs8S+WSb/h3IT1jUUdBZOw2Ah/gzuPydDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOBQdFcz+Sz3/HZvLRhx94YVLHIbbAmigVQ6PvPhif8kE3pbX5rPBQyjlrq0E7NvikDiTaJFs3ca36E21tt36AIwp4VYyOkjOzzcT4IT6HwtbYNQ+PizcotprYaWlPKwgfrTH6N57sX5oZPYJJD1Dof4ClkXQTVUgiKtPZCSrlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXaUriyt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so11143835e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533670; x=1740138470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB4hOZFIewklpFdCH6VWD2g5IlL1m3xWkE0ZKXuUefA=;
        b=nXaUriytBDUaRDCBKFoVn+2cv3uxJDaqqOeqeggm732ip24gqo8B+KLWQOEqkhhBbB
         22euBzMWNBFXpzIdxmuiGs8SmO/LJbRreqoFjLzGSzGqW8yS38iyAW7QyPLp5MBbsjxE
         GpNfw68lIsT4p7wTqbsBDka8cF4NMIcNWK7U1Sz6iVph9Zzrs5tYkamtbx/vdE3LRlHn
         IInNPZ5Pq5nnqc2dNZi2krauDiSdGNIrzcTIwtlGIqfpK/tLEvZMRKjjGqxmamG9Ddvm
         iiROHjQNp2jGEIMXuRImOwmprU0ZrFbYeKECoDB1dhRa05/p5ULywucCdpY3W/mONJXt
         zu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533671; x=1740138471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB4hOZFIewklpFdCH6VWD2g5IlL1m3xWkE0ZKXuUefA=;
        b=my6qAjp+XScbHkvXIkzLmd6N4ytEGPi0zTLgIsGZ2llHQa7rRpDx+BlnNYX5RY3Uvd
         Sbj78+AamZfHRI3u9EvNAEgNzh2epg7L3Hxe50jZyl2Qk0A0mB8AMk6WadI8M4cDqrJy
         xwDCxC5jO/Hspx+8bDMKg/Z+qtroc04avjlTj8BjDA/vS7fQ3KyCsTyAePo4DGnS8KIc
         0iBYiJb9LlD0z7uZHk5hpn5Saly18hBoZXNuUj7FbDy1+oXxv13UxdVXvDCAt/bbAmJg
         HHBpbTe0OJMsaa8xuzExsVueXcG7nsyvNKb7pMoBiWmMK1PAvSGkEEfeXR/oNcI3oYEN
         WUig==
X-Forwarded-Encrypted: i=1; AJvYcCXKleTmJf9YK587JLjvPmgpiUHU2np59VLVQWzRbDysgdG5ar8npKcZbPR0Ij3Us9K2wx2g4FgX+itYnN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KvZZM6A+/tHyV6Q9YJgF6feHIq3qjUlh1wRCLPdE5AnV7VOr
	QlXqbdZ7/mkEfUTgYq+P0usvXD0T+3uoNaXKuvPa6/n7/XD1rCOt
X-Gm-Gg: ASbGncv9F/gM443WXTX38HMSqZCaM28ZqC4FH9rzVEqjFYHCbA61OBUymtjzCyT1wyz
	M9fZw89kf7V8TXfudTyhlyj7k2Z32wgX2G1AdRvPVDNz0mt4vl2g1HrJJ/tzc9dCmxmPfbFzoag
	CTYPMRzHzyrTVPvYRDTJ9YOgI76RnfO7wGurUbqwa3/hh9FgrK5KNg1Tg/PkZZEEl7U4TbSdWrV
	tdMxUFS/HRCqkWXO9IrfxlCy7kzLPYq7XvBW+tDs+X0Dz8UN9Sa4vMZF67oI5VQZrEQBT1sqVxU
	RpD+3mi8tHlQiGD5wf94rRnC6wcWyktZTnBAnSdlvAyFLYqvMVE=
X-Google-Smtp-Source: AGHT+IH9yD6xiYGyebswReZLqABY9aEdR4Sw+xMjIqJZPgV/z1rxOG/uQ0MApfISEwIcsNuRSGsQaA==
X-Received: by 2002:a05:600c:a4a:b0:439:57b5:f8a0 with SMTP id 5b1f17b1804b1-439601ab838mr87445935e9.24.1739533670410;
        Fri, 14 Feb 2025 03:47:50 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:49 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 13/17] staging: gpib: nec7210 console messaging cleanup
Date: Fri, 14 Feb 2025 12:47:04 +0100
Message-ID: <20250214114708.28947-14-dpenkler@gmail.com>
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

Enable module name to be printed by default in dev_dbg

Remove commented dev_dbg

Remove pr_err on timeout and gpib bus error.

Remove dev_dbg on wait interrupted, command timeout
also read / write timeout, gpib bus error and interrupt.

Remove commented printk and command variable initialization.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/nec7210/nec7210.c | 69 +++++++++-----------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/staging/gpib/nec7210/nec7210.c
index c9a837fad96e..85f1e79d658a 100644
--- a/drivers/staging/gpib/nec7210/nec7210.c
+++ b/drivers/staging/gpib/nec7210/nec7210.c
@@ -4,6 +4,8 @@
  *   copyright            : (C) 2001, 2002 by Frank Mori Hess
  ***************************************************************************/
 
+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "board.h"
 #include <linux/ioport.h>
 #include <linux/sched.h>
@@ -198,7 +200,6 @@ unsigned int nec7210_update_status_nolock(gpib_board_t *board, struct nec7210_pr
 		priv->srq_pending = 0;
 		set_bit(SPOLL_NUM, &board->status);
 	}
-//	dev_dbg(board->gpib_dev, "status 0x%x, state 0x%x\n", board->status, priv->state);
 
 	/* we rely on the interrupt handler to set the
 	 * rest of the status bits
@@ -319,10 +320,8 @@ int nec7210_go_to_standby(gpib_board_t *board, struct nec7210_priv *priv)
 			if (adsr_bits & HR_NATN)
 				break;
 		}
-		if (i == HZ) {
-			pr_err("nec7210: error waiting for NATN\n");
+		if (i == HZ)
 			return -ETIMEDOUT;
-		}
 	}
 
 	clear_bit(COMMAND_READY_BN, &priv->state);
@@ -430,17 +429,14 @@ int nec7210_command(gpib_board_t *board, struct nec7210_priv *priv, uint8_t
 					     test_bit(COMMAND_READY_BN, &priv->state) ||
 					     test_bit(BUS_ERROR_BN, &priv->state) ||
 					     test_bit(TIMO_NUM, &board->status))) {
-			dev_dbg(board->gpib_dev, "gpib command wait interrupted\n");
+			dev_dbg(board->gpib_dev, "command wait interrupted\n");
 			retval = -ERESTARTSYS;
 			break;
 		}
 		if (test_bit(TIMO_NUM, &board->status))
 			break;
-		if (test_and_clear_bit(BUS_ERROR_BN, &priv->state)) {
-			pr_err("nec7210: bus error on command byte\n");
+		if (test_and_clear_bit(BUS_ERROR_BN, &priv->state))
 			break;
-		}
-
 		spin_lock_irqsave(&board->spinlock, flags);
 		clear_bit(COMMAND_READY_BN, &priv->state);
 		write_byte(priv, buffer[*bytes_written], CDOR);
@@ -454,18 +450,14 @@ int nec7210_command(gpib_board_t *board, struct nec7210_priv *priv, uint8_t
 	// wait for last byte to get sent
 	if (wait_event_interruptible(board->wait, test_bit(COMMAND_READY_BN, &priv->state) ||
 				     test_bit(BUS_ERROR_BN, &priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib command wait interrupted\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		retval = -ERESTARTSYS;
-	}
-	if (test_bit(TIMO_NUM, &board->status))	{
-		dev_dbg(board->gpib_dev, "gpib command timed out\n");
+
+	if (test_bit(TIMO_NUM, &board->status))
 		retval = -ETIMEDOUT;
-	}
-	if (test_and_clear_bit(BUS_ERROR_BN, &priv->state)) {
-		pr_err("nec7210: bus error on command byte\n");
+
+	if (test_and_clear_bit(BUS_ERROR_BN, &priv->state))
 		retval = -EIO;
-	}
 
 	return retval;
 }
@@ -484,7 +476,6 @@ static int pio_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buf
 					     test_bit(READ_READY_BN, &priv->state) ||
 					     test_bit(DEV_CLEAR_BN, &priv->state) ||
 					     test_bit(TIMO_NUM, &board->status))) {
-			dev_dbg(board->gpib_dev, "nec7210: pio read wait interrupted\n");
 			retval = -ERESTARTSYS;
 			break;
 		}
@@ -503,12 +494,10 @@ static int pio_read(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *buf
 				break;
 		}
 		if (test_bit(TIMO_NUM, &board->status)) {
-			dev_dbg(board->gpib_dev, "interrupted by timeout\n");
 			retval = -ETIMEDOUT;
 			break;
 		}
 		if (test_bit(DEV_CLEAR_BN, &priv->state)) {
-			dev_dbg(board->gpib_dev, "interrupted by device clear\n");
 			retval = -EINTR;
 			break;
 		}
@@ -557,10 +546,9 @@ static ssize_t __dma_read(gpib_board_t *board, struct nec7210_priv *priv, size_t
 	if (wait_event_interruptible(board->wait,
 				     test_bit(DMA_READ_IN_PROGRESS_BN, &priv->state) == 0 ||
 				     test_bit(DEV_CLEAR_BN, &priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "nec7210: dma read wait interrupted\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		retval = -ERESTARTSYS;
-	}
+
 	if (test_bit(TIMO_NUM, &board->status))
 		retval = -ETIMEDOUT;
 	if (test_bit(DEV_CLEAR_BN, &priv->state))
@@ -638,22 +626,18 @@ static int pio_write_wait(gpib_board_t *board, struct nec7210_priv *priv,
 				     (wake_on_bus_error && test_bit(BUS_ERROR_BN, &priv->state)) ||
 				     (wake_on_lacs && test_bit(LACS_NUM, &board->status)) ||
 				     (wake_on_atn && test_bit(ATN_NUM, &board->status)) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib write interrupted\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		return -ERESTARTSYS;
-	}
-	if (test_bit(TIMO_NUM, &board->status))	{
-		dev_dbg(board->gpib_dev, "nec7210: write timed out\n");
+
+	if (test_bit(TIMO_NUM, &board->status))
 		return -ETIMEDOUT;
-	}
-	if (test_bit(DEV_CLEAR_BN, &priv->state)) {
-		dev_dbg(board->gpib_dev, "nec7210: write interrupted by clear\n");
+
+	if (test_bit(DEV_CLEAR_BN, &priv->state))
 		return -EINTR;
-	}
-	if (wake_on_bus_error && test_and_clear_bit(BUS_ERROR_BN, &priv->state)) {
-		dev_dbg(board->gpib_dev, "nec7210: bus error on write\n");
+
+	if (wake_on_bus_error && test_and_clear_bit(BUS_ERROR_BN, &priv->state))
 		return -EIO;
-	}
+
 	return 0;
 }
 
@@ -677,7 +661,6 @@ static int pio_write(gpib_board_t *board, struct nec7210_priv *priv, uint8_t *bu
 		if (retval == -EIO) {
 			/* resend last byte on bus error */
 			*bytes_written = last_count;
-			dev_dbg(board->gpib_dev, "resending %c\n", buffer[*bytes_written]);
 			/* we can get unrecoverable bus errors,
 			 * so give up after a while
 			 */
@@ -733,10 +716,9 @@ static ssize_t __dma_write(gpib_board_t *board, struct nec7210_priv *priv, dma_a
 				     test_bit(DMA_WRITE_IN_PROGRESS_BN, &priv->state) == 0 ||
 				     test_bit(BUS_ERROR_BN, &priv->state) ||
 				     test_bit(DEV_CLEAR_BN, &priv->state) ||
-				     test_bit(TIMO_NUM, &board->status))) {
-		dev_dbg(board->gpib_dev, "gpib write interrupted!\n");
+				     test_bit(TIMO_NUM, &board->status)))
 		retval = -ERESTARTSYS;
-	}
+
 	if (test_bit(TIMO_NUM, &board->status))
 		retval = -ETIMEDOUT;
 	if (test_and_clear_bit(DEV_CLEAR_BN, &priv->state))
@@ -937,13 +919,8 @@ irqreturn_t nec7210_interrupt_have_status(gpib_board_t *board,
 		set_bit(COMMAND_READY_BN, &priv->state);
 
 	// command pass through received
-	if (status1 & HR_CPT) {
-		unsigned int command;
-
-		command = read_byte(priv, CPTR) & gpib_command_mask;
+	if (status1 & HR_CPT)
 		write_byte(priv, AUX_NVAL, AUXMR);
-//		printk("gpib: command pass through 0x%x\n", command);
-	}
 
 	if (status1 & HR_ERR)
 		set_bit(BUS_ERROR_BN, &priv->state);
-- 
2.48.1


