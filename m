Return-Path: <linux-kernel+bounces-514874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E26A35CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84172188E4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09C263F20;
	Fri, 14 Feb 2025 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqumuPNc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05025A623
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533657; cv=none; b=IdSw9g9lM++JPDuSu42Q9GekpmMdJUXpJoZ+jOyItSU8vdPPRVe0sl/vrYsEjAfHLPTYSMa3xLy2Z/sILlOCQLky2ppk00wCP490hruJetWKHTuY0opqB6z4SE3kFBzSJ2XxIpjfhC5G9OdVQOtib4h2qSmjmG6uOxewPdpBy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533657; c=relaxed/simple;
	bh=N/ZFeWdku78CWtKPgOIYb8+yg57duuPjSE+bpdnW1C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIQ+AwRGaznawXXWCo3JE+oru4bIQzeAjHnAK30eDa0AIpaIZ2X4m0kRYtBTGOgjZ/KIzDsOWojw6hAZkXwfMBXkKOghFVNwtWiufVF72nG5Sbvd+sF9VnevpSl2pKd2b1IjDEe7DrKrrySmDWgwsk+CYlv3qMbpH1BGq0rhWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqumuPNc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43937cf2131so13332485e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533654; x=1740138454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mJPDiBCYTfw1Nxw+ZwfMQF/cs7coOz1izSBM1/bSuM=;
        b=VqumuPNcMWDn9g+ddegDwQY6+Jufo/Adow6sepSWI+kCkWtgxJ8DBbYAFdBgydmBgn
         g26SNJImRiKaRSYwo2MOjXFkkXM/sl2x8FVP7ipNjdp2wvDIGqzZwKfUVOZdfYrTQ0qI
         uymqsKDi5u3hWG1l+EbZ0hqm4Qj2gkH4Qn0WYcCip3vQKqywC0gW/l8EV8+jKu8ZlFzy
         TpABYujsA1R2Roz0d0ubK5t3sgR0loVfAGo0vDwQXTi10qrR0zT03PoPyJCJ1EqNauvn
         1ghk2ouKyECK48FTkJ8JoX9No2wDd3pgbH5x6TxobOZTsyP6fWklGyLBWxq3GAOtkM8r
         4sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533654; x=1740138454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mJPDiBCYTfw1Nxw+ZwfMQF/cs7coOz1izSBM1/bSuM=;
        b=gthPrM/h/zFT5zR2m/ZrBDgmPAjj6vxL8OecSnxZcVdW5Tff5P7E4DynIRjuucYQB9
         0SAHeO8t9YPbLPn0bcOw1qXaJwqlicNZ0XfG7Oc+r4T82/LKraFiMENygdVN31A1OUo1
         cQCJX5w9EEiWY4DNzJENE0mJqBg7qnJMIgoi0SA65p4dabgijWXY4H0wKJrSe2sZn5T0
         HGIqPMWqfCx/aAGlPPFeKrP4MKZD8LK2FJk9DjFz2VKRJMpjfy2WJ6doo4xpzL3Rk0y/
         tqxVZIVM4jq0PoLX4VA6dVZ+WpWY45tq+YNvMhe2yRbxRswt/0Woc1Mnq8cfRi5ZYyX1
         d+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsB9wjtJnf8PZrhH/X+5c/UWfDUH8AnRO364uqKz9990VSCx/WJxYBBOzcjol/VZ5FycuCoTH43vFM5rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUy84zVWlhcMTxovjVGZXAesYEbNpACqWKZUonNKljRj6HfIUs
	wELq1WsX6J1Cs8h5tC15kMbOdQ7HbLoQwSJIABu5CHCh74Mbx0fG
X-Gm-Gg: ASbGnctGoxOMfyQ+caC+/eruGo5NVNoHakAmwwxBE5HZKFH4Fsdit+G2Iaa/VK/p8iY
	Y+p9U6CO+lUVLf+82uKthTqA+PqghFOYrf0tMxGQe08Kml2ClpSpivDstK+puQVtCkVJbGaj67S
	aG34fHG7pwvex8owO5RUWVPmr/8pB0VysSkrN7CSndpIaOLDjU13CCdwS+kNONyI2bcfh4Jcw1i
	/1DXLKRdWxA+oKMT7pyWWKB7StdRJWecpTFPUWa65/1ztdk6T37Ud3IXM0I05cGbeF6Xsza1XHL
	E6lUtwTzZtVf2dbpSL4Ev9RRix9IbmNWUD8avHW0Vxax/RoqTu4=
X-Google-Smtp-Source: AGHT+IFk0SrgrmYCZzT6YR28RWd1wrtGIfzMFpBXUt7XzMxRZ05+DRTzZZsq9UFAn3i8S1GBWsXh9Q==
X-Received: by 2002:a05:600c:511c:b0:439:441a:3d7e with SMTP id 5b1f17b1804b1-43959a859cdmr111910115e9.20.1739533653330;
        Fri, 14 Feb 2025 03:47:33 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:32 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 01/17] staging: gpib: agilent pci console messaging cleanup
Date: Fri, 14 Feb 2025 12:46:52 +0100
Message-ID: <20250214114708.28947-2-dpenkler@gmail.com>
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

Remove dev_err messages on interrupted or timed-out
reads and writes.  User land code can figure out what
went wrong with the errno return.

Return -ENODEV instead of -1 on attach failure when
no board is found.

Delete commented out console messages.

Use module name in pr_xxx and dev_xxx messages.
Remove const char * definition of driver_name and
extern definition in .h file.
Use DRV_NAME defined as KBUILD_MODNAME instead.
Remove driver_name parameter and agilent_82350b string prefix
in dev_xxx messages.
Use DRV_NAME instead of driver_name in pci_request_regions.
Use DRV_NAME instead of hard coded string in the pci_driver struct.

Change select dev_info's to dev_dbg.

Change pr_err to dev_err where possible.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 .../gpib/agilent_82350b/agilent_82350b.c      | 118 ++++++------------
 .../gpib/agilent_82350b/agilent_82350b.h      |   3 -
 2 files changed, 40 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 5c62ec24fced..f83e1f321561 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -4,6 +4,10 @@
  *   copyright            : (C) 2002, 2004 by Frank Mori Hess              *
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include "agilent_82350b.h"
 #include <linux/delay.h>
 #include <linux/ioport.h>
@@ -54,9 +58,6 @@ static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_
 
 		retval = tms9914_read(board, tms_priv, buffer, 1, end, &num_bytes);
 		*bytes_read += num_bytes;
-		if (retval < 0)
-			dev_err(board->gpib_dev, "%s: tms9914_read failed retval=%i\n",
-				driver_name, retval);
 		if (retval < 0 || *end)
 			return retval;
 		++buffer;
@@ -89,7 +90,6 @@ static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_
 						  test_bit(DEV_CLEAR_BN, &tms_priv->state) ||
 						  test_bit(TIMO_NUM, &board->status));
 		if (retval) {
-			dev_dbg(board->gpib_dev, "%s: read wait interrupted\n", driver_name);
 			retval = -ERESTARTSYS;
 			break;
 		}
@@ -103,13 +103,10 @@ static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_
 			*end = 1;
 		}
 		if (test_bit(TIMO_NUM, &board->status)) {
-			dev_err(board->gpib_dev, "%s: read timed out\n", driver_name);
 			retval = -ETIMEDOUT;
 			break;
 		}
 		if (test_bit(DEV_CLEAR_BN, &tms_priv->state)) {
-			dev_err(board->gpib_dev, "%s: device clear interrupted read\n",
-				driver_name);
 			retval = -EINTR;
 			break;
 		}
@@ -139,18 +136,12 @@ static int translate_wait_return_value(gpib_board_t *board, int retval)
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	struct tms9914_priv *tms_priv = &a_priv->tms9914_priv;
 
-	if (retval) {
-		dev_err(board->gpib_dev, "%s: write wait interrupted\n", driver_name);
+	if (retval)
 		return -ERESTARTSYS;
-	}
-	if (test_bit(TIMO_NUM, &board->status)) {
-		dev_err(board->gpib_dev, "%s: write timed out\n", driver_name);
+	if (test_bit(TIMO_NUM, &board->status))
 		return -ETIMEDOUT;
-	}
-	if (test_bit(DEV_CLEAR_BN, &tms_priv->state)) {
-		dev_err(board->gpib_dev, "%s: device clear interrupted write\n", driver_name);
+	if (test_bit(DEV_CLEAR_BN, &tms_priv->state))
 		return -EINTR;
-	}
 	return 0;
 }
 
@@ -176,10 +167,8 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 
 	event_status = read_and_clear_event_status(board);
 
-	//pr_info("ag_ac_wr: event status 0x%x tms state 0x%lx\n", event_status, tms_priv->state);
-
 #ifdef EXPERIMENTAL
-	pr_info("ag_ac_wr: wait for previous BO to complete if any\n");
+	// wait for previous BO to complete if any
 	retval = wait_event_interruptible(board->wait,
 					  test_bit(DEV_CLEAR_BN, &tms_priv->state) ||
 					  test_bit(WRITE_READY_BN, &tms_priv->state) ||
@@ -190,14 +179,11 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		return retval;
 #endif
 
-	//pr_info("ag_ac_wr: sending first byte\n");
 	retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
 	*bytes_written += num_bytes;
 	if (retval < 0)
 		return retval;
 
-	//pr_info("ag_ac_wr: %ld bytes eoi %d tms state 0x%lx\n",length, send_eoi, tms_priv->state);
-
 	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
 	for (i = 1; i < fifotransferlength;) {
 		clear_bit(WRITE_READY_BN, &tms_priv->state);
@@ -210,13 +196,8 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		}
 		writeb(ENABLE_TI_TO_SRAM, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 
-		//pr_info("ag_ac_wr: send block: %d bytes tms 0x%lx\n", block_size,
-		// tms_priv->state);
-
-		if (agilent_82350b_fifo_is_halted(a_priv)) {
+		if (agilent_82350b_fifo_is_halted(a_priv))
 			writeb(RESTART_STREAM_BIT, a_priv->gpib_base + STREAM_STATUS_REG);
-			//	pr_info("ag_ac_wr: needed restart\n");
-		}
 
 		retval = wait_event_interruptible(board->wait,
 						  ((event_status =
@@ -226,7 +207,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 						  test_bit(TIMO_NUM, &board->status));
 		writeb(0, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 		num_bytes = block_size - read_transfer_counter(a_priv);
-		//pr_info("ag_ac_wr: sent  %ld bytes tms 0x%lx\n", num_bytes, tms_priv->state);
 
 		*bytes_written += num_bytes;
 		retval = translate_wait_return_value(board, retval);
@@ -238,9 +218,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 		return retval;
 
 	if (send_eoi) {
-		//pr_info("ag_ac_wr: sending last byte with eoi byte no:   %d\n",
-		// fifotransferlength+1);
-
 		retval = agilent_82350b_write(board, buffer + fifotransferlength, 1, send_eoi,
 					      &num_bytes);
 		*bytes_written += num_bytes;
@@ -284,7 +261,6 @@ static irqreturn_t agilent_82350b_interrupt(int irq, void *arg)
 		tms9914_interrupt_have_status(board, &a_priv->tms9914_priv, tms9914_status1,
 					      tms9914_status2);
 	}
-//pr_info("event_status=0x%x s1 %x s2 %x\n", event_status,tms9914_status1,tms9914_status2);
 //write-clear status bits
 	if (event_status & (BUFFER_END_STATUS_BIT | TERM_COUNT_STATUS_BIT)) {
 		writeb(event_status & (BUFFER_END_STATUS_BIT | TERM_COUNT_STATUS_BIT),
@@ -298,8 +274,6 @@ static irqreturn_t agilent_82350b_interrupt(int irq, void *arg)
 
 static void agilent_82350b_detach(gpib_board_t *board);
 
-const char *driver_name = "agilent_82350b";
-
 static int read_transfer_counter(struct agilent_82350b_priv *a_priv)
 {
 	int lo, mid, value;
@@ -536,11 +510,10 @@ static int init_82350a_hardware(gpib_board_t *board, const gpib_board_config_t *
 		return 0;
 	// need to programme borg
 	if (!config->init_data || config->init_data_length != firmware_length) {
-		dev_err(board->gpib_dev, "%s: the 82350A board requires firmware after powering on.\n",
-			driver_name);
+		dev_err(board->gpib_dev, "the 82350A board requires firmware after powering on.\n");
 		return -EIO;
 	}
-	dev_info(board->gpib_dev, "%s: Loading firmware...\n", driver_name);
+	dev_dbg(board->gpib_dev, "Loading firmware...\n");
 
 	// tickle the borg
 	writel(plx_cntrl_static_bits | PLX9050_USER3_DATA_BIT,
@@ -559,7 +532,7 @@ static int init_82350a_hardware(gpib_board_t *board, const gpib_board_config_t *
 			usleep_range(10, 20);
 		}
 		if (j == timeout) {
-			dev_err(board->gpib_dev, "%s: timed out loading firmware.\n", driver_name);
+			dev_err(board->gpib_dev, "timed out loading firmware.\n");
 			return -ETIMEDOUT;
 		}
 		writeb(firmware_data[i], a_priv->gpib_base + CONFIG_DATA_REG);
@@ -570,11 +543,10 @@ static int init_82350a_hardware(gpib_board_t *board, const gpib_board_config_t *
 		usleep_range(10, 20);
 	}
 	if (j == timeout) {
-		dev_err(board->gpib_dev, "%s: timed out waiting for firmware load to complete.\n",
-			driver_name);
+		dev_err(board->gpib_dev, "timed out waiting for firmware load to complete.\n");
 		return -ETIMEDOUT;
 	}
-	dev_info(board->gpib_dev, "%s: ...done.\n", driver_name);
+	dev_dbg(board->gpib_dev, " ...done.\n");
 	return 0;
 }
 
@@ -596,15 +568,14 @@ static int test_sram(gpib_board_t *board)
 		unsigned int read_value = readb(a_priv->sram_base + i);
 
 		if ((i & byte_mask) != read_value) {
-			dev_err(board->gpib_dev, "%s: SRAM test failed at %d wanted %d got %d\n",
-				driver_name, i, (i & byte_mask), read_value);
+			dev_err(board->gpib_dev, "SRAM test failed at %d wanted %d got %d\n",
+				i, (i & byte_mask), read_value);
 			return -EIO;
 		}
 		if (need_resched())
 			schedule();
 	}
-	dev_info(board->gpib_dev, "%s: SRAM test passed 0x%x bytes checked\n",
-		 driver_name, sram_length);
+	dev_dbg(board->gpib_dev, "SRAM test passed 0x%x bytes checked\n", sram_length);
 	return 0;
 }
 
@@ -632,14 +603,14 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 						 PCI_DEVICE_ID_82350B, NULL);
 	if (a_priv->pci_device) {
 		a_priv->model = MODEL_82350B;
-		dev_info(board->gpib_dev, "%s: Agilent 82350B board found\n", driver_name);
+		dev_dbg(board->gpib_dev, "Agilent 82350B board found\n");
 
 	} else	{
 		a_priv->pci_device = gpib_pci_get_device(config, PCI_VENDOR_ID_AGILENT,
 							 PCI_DEVICE_ID_82351A, NULL);
 		if (a_priv->pci_device)	{
 			a_priv->model = MODEL_82351A;
-			dev_info(board->gpib_dev, "%s: Agilent 82351B board found\n", driver_name);
+			dev_dbg(board->gpib_dev, "Agilent 82351B board found\n");
 
 		} else {
 			a_priv->pci_device = gpib_pci_get_subsys(config, PCI_VENDOR_ID_PLX,
@@ -649,46 +620,40 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 								 a_priv->pci_device);
 			if (a_priv->pci_device) {
 				a_priv->model = MODEL_82350A;
-				dev_info(board->gpib_dev, "%s: HP/Agilent 82350A board found\n",
-					 driver_name);
+				dev_dbg(board->gpib_dev, "HP/Agilent 82350A board found\n");
 			} else {
-				dev_err(board->gpib_dev, "%s: no 82350/82351 board found\n",
-					driver_name);
+				dev_err(board->gpib_dev, "no 82350/82351 board found\n");
 				return -ENODEV;
 			}
 		}
 	}
 	if (pci_enable_device(a_priv->pci_device)) {
-		dev_err(board->gpib_dev, "%s: error enabling pci device\n", driver_name);
+		dev_err(board->gpib_dev, "error enabling pci device\n");
 		return -EIO;
 	}
-	if (pci_request_regions(a_priv->pci_device, driver_name))
-		return -EIO;
+	if (pci_request_regions(a_priv->pci_device, DRV_NAME))
+		return -ENOMEM;
 	switch (a_priv->model) {
 	case MODEL_82350A:
 		a_priv->plx_base = ioremap(pci_resource_start(a_priv->pci_device, PLX_MEM_REGION),
 					   pci_resource_len(a_priv->pci_device, PLX_MEM_REGION));
-		dev_dbg(board->gpib_dev, "%s: plx base address remapped to 0x%p\n",
-			driver_name, a_priv->plx_base);
+		dev_dbg(board->gpib_dev, "plx base address remapped to 0x%p\n", a_priv->plx_base);
 		a_priv->gpib_base = ioremap(pci_resource_start(a_priv->pci_device,
 							       GPIB_82350A_REGION),
 					    pci_resource_len(a_priv->pci_device,
 							     GPIB_82350A_REGION));
-		dev_dbg(board->gpib_dev, "%s: gpib base address remapped to 0x%p\n",
-			driver_name, a_priv->gpib_base);
+		dev_dbg(board->gpib_dev, "chip base address remapped to 0x%p\n", a_priv->gpib_base);
 		tms_priv->mmiobase = a_priv->gpib_base + TMS9914_BASE_REG;
 		a_priv->sram_base = ioremap(pci_resource_start(a_priv->pci_device,
 							       SRAM_82350A_REGION),
 					    pci_resource_len(a_priv->pci_device,
 							     SRAM_82350A_REGION));
-		dev_dbg(board->gpib_dev, "%s: sram base address remapped to 0x%p\n",
-			driver_name, a_priv->sram_base);
+		dev_dbg(board->gpib_dev, "sram base address remapped to 0x%p\n", a_priv->sram_base);
 		a_priv->borg_base = ioremap(pci_resource_start(a_priv->pci_device,
 							       BORG_82350A_REGION),
 					    pci_resource_len(a_priv->pci_device,
 							     BORG_82350A_REGION));
-		dev_dbg(board->gpib_dev, "%s: borg base address remapped to 0x%p\n",
-			driver_name, a_priv->borg_base);
+		dev_dbg(board->gpib_dev, "borg base address remapped to 0x%p\n", a_priv->borg_base);
 
 		retval = init_82350a_hardware(board, config);
 		if (retval < 0)
@@ -698,21 +663,18 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 	case MODEL_82351A:
 		a_priv->gpib_base = ioremap(pci_resource_start(a_priv->pci_device, GPIB_REGION),
 					    pci_resource_len(a_priv->pci_device, GPIB_REGION));
-		dev_dbg(board->gpib_dev, "%s: gpib base address remapped to 0x%p\n",
-			driver_name, a_priv->gpib_base);
+		dev_dbg(board->gpib_dev, "chip base address remapped to 0x%p\n", a_priv->gpib_base);
 		tms_priv->mmiobase = a_priv->gpib_base + TMS9914_BASE_REG;
 		a_priv->sram_base = ioremap(pci_resource_start(a_priv->pci_device, SRAM_REGION),
 					    pci_resource_len(a_priv->pci_device, SRAM_REGION));
-		dev_dbg(board->gpib_dev, "%s: sram base address remapped to 0x%p\n",
-			driver_name, a_priv->sram_base);
+		dev_dbg(board->gpib_dev, "sram base address remapped to 0x%p\n", a_priv->sram_base);
 		a_priv->misc_base = ioremap(pci_resource_start(a_priv->pci_device, MISC_REGION),
 					    pci_resource_len(a_priv->pci_device, MISC_REGION));
-		dev_dbg(board->gpib_dev, "%s: misc base address remapped to 0x%p\n",
-			driver_name, a_priv->misc_base);
+		dev_dbg(board->gpib_dev, "misc base address remapped to 0x%p\n", a_priv->misc_base);
 		break;
 	default:
-		pr_err("%s: invalid board\n", driver_name);
-		return -1;
+		dev_err(board->gpib_dev, "invalid board\n");
+		return -ENODEV;
 	}
 
 	retval = test_sram(board);
@@ -720,12 +682,12 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 		return retval;
 
 	if (request_irq(a_priv->pci_device->irq, agilent_82350b_interrupt,
-			IRQF_SHARED, driver_name, board)) {
-		pr_err("%s: can't request IRQ %d\n", driver_name, a_priv->pci_device->irq);
+			IRQF_SHARED, DRV_NAME, board)) {
+		dev_err(board->gpib_dev, "failed to obtain irq %d\n", a_priv->pci_device->irq);
 		return -EIO;
 	}
 	a_priv->irq = a_priv->pci_device->irq;
-	dev_dbg(board->gpib_dev, "%s: IRQ %d\n", driver_name, a_priv->irq);
+	dev_dbg(board->gpib_dev, " IRQ %d\n", a_priv->irq);
 
 	writeb(0, a_priv->gpib_base + SRAM_ACCESS_CONTROL_REG);
 	a_priv->card_mode_bits = ENABLE_PCI_IRQ_BIT;
@@ -873,7 +835,7 @@ static const struct pci_device_id agilent_82350b_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, agilent_82350b_pci_table);
 
 static struct pci_driver agilent_82350b_pci_driver = {
-	.name = "agilent_82350b",
+	.name = DRV_NAME,
 	.id_table = agilent_82350b_pci_table,
 	.probe = &agilent_82350b_pci_probe
 };
@@ -884,19 +846,19 @@ static int __init agilent_82350b_init_module(void)
 
 	result = pci_register_driver(&agilent_82350b_pci_driver);
 	if (result) {
-		pr_err("agilent_82350b: pci_register_driver failed: error = %d\n", result);
+		pr_err("pci_register_driver failed: error = %d\n", result);
 		return result;
 	}
 
 	result = gpib_register_driver(&agilent_82350b_unaccel_interface, THIS_MODULE);
 	if (result) {
-		pr_err("agilent_82350b: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_unaccel;
 	}
 
 	result = gpib_register_driver(&agilent_82350b_interface, THIS_MODULE);
 	if (result) {
-		pr_err("agilent_82350b: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		goto err_interface;
 	}
 
diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.h b/drivers/staging/gpib/agilent_82350b/agilent_82350b.h
index 8b96ad12647e..1573230c619d 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.h
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.h
@@ -57,9 +57,6 @@ struct agilent_82350b_priv {
 	bool using_fifos;
 };
 
-// driver name
-extern const char *driver_name;
-
 //registers
 enum agilent_82350b_gpib_registers
 
-- 
2.48.1


