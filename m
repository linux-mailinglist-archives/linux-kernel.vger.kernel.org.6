Return-Path: <linux-kernel+bounces-568886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9281BA69BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A7E98223E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48D221738;
	Wed, 19 Mar 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="EV8CwBhz"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701321E0A6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421595; cv=none; b=msla10i4JL67jkfi3iBtbNIMKNSZyfnKRJTTJ5zUBL42jAbNLPU2rVMICVLcwTwOmR5ypIg6dUdZEnSm4M4d3NlvTVk8CwYbaLxik4ayvuYrv0X9WHWn+NWLaVqzU3sCokZ4Q11pup563Qs+zun9qAouZQqxTJurqERM78gbndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421595; c=relaxed/simple;
	bh=6SFwaD3VXeajob+zXsjPJdnfDCKu68LZeFZCb/1qp40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSxAPMegVGj+I+2meMBL2MfrW5+K9c6s69XELVUOEXqFQ0Jmlba8TyoTb5tQOss/mIW1GQYC0bZjGwxHVS+TrXGBeMAQss/gWQgIbnCrZEw/lA+VPdJP8vwr28hPbOu+WpILRyic5fA+veo1gspiGomtw7MkkRPWXS47AieB76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=EV8CwBhz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22548a28d0cso1161705ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421592; x=1743026392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaaCH6MBSo5YdbXkpTr1qkIrj3X76/oKWszsy2HvHAI=;
        b=EV8CwBhzrYh14taWC9CCsOt/dP5wmrxEQBcMNUCQcib4mOVeQp2m7NSTcYMyYrDcDY
         xcQ5dsW0gFcePQVTdQNsWYNBFDY5C7+JyqjxuJyV5HgPU/gm34sJ51KBL1n430r/hLge
         rJ8q3uY8qCxmhnJ2EsE3oT1SM7j+Sy4azwsDHG+hy0EWAC/8EiVXNEL2gLzy0TZc7quR
         mHpbHFR99/0Ip6xAbhStQsCARdIG7OSL0LRdF9KaFeL0oo6vT4LEMLUwORpIJp1x3BBb
         uvgyRuRfiyWTyXj5KCfW+dIxgydVewFSl4ldIDJsFuBwyuSW/vTxEHmhcI3nt6AO5W+G
         7JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421592; x=1743026392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaaCH6MBSo5YdbXkpTr1qkIrj3X76/oKWszsy2HvHAI=;
        b=f0rFCbMDp1njapAP9bYC8Lz1aIHh23AESM7PXIYfFPRUtV4RqgF21zED8pkryAuaoq
         91dJmW291oWcNg2eT/IV2QWmRxWtoxPc8RkbiJy8TbBbvLwoKKhdgxeqliM3jaHw81Rz
         flAa+PV/L/kA6lgG3Lvz1uf6WFVux8uBEbcWspDacPB42YD2bytF24ATVhs1LmYTEkLC
         78FTi3ynpjX2TcvURIFbsgTMgO+oHs+Lq0QkAre/7gXtwCCJSF8SmP+UpHriehBI19Ww
         WB4wUelzFXgf+kxlIOsp/F0fka8u+mJ0HKCBalIWfkh7M7t1uFzKiSsZJkNtjeC02wXk
         E4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFmnJ36oRr1u3N+TJdONGi69JaxRvNZ+AP1gpOBuj2YpHuOQc3qaCloVt4CeCeT+06AmDwV4n30WRShCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylYu6VxJATeugCI7w9Kf9qmeUgii+eWqWiRdsU1VqbzG2cAwBM
	3g1/BW9bgvN0CzGJYVbecD+5T6aLGBnqEMomdsM6NjOab5IDxwUrr3iMkhcWrA==
X-Gm-Gg: ASbGncteMKXwUDOZ3HLkB1yd26miJX10fQbDHE2oQjdI8Vb/W+QMcNccBt7LAlMOqY6
	iYNolrhw+n1iDG3yB8Kx8U2HqUolzqLoLZF5otUGqLKdPgpO0a/Q8mEOVHnFUpRF+I8Xhop3VN2
	yGiqWx46BHMgxKe3Nl9TyQ47G2WE1HDrfo+UykAoEic6mUMWJg8zLyFEYsYFqQy8Lk5dKFuLeY1
	AE/XW4Uj+CJX+kUtZe24D8dhUpStwddH0Pa9IhgVqxDz1GHpDqux6MomuuGKz45QaHBU+AWOFYO
	8zxI287aAdRJQ7rasxy5qGXswpcTSvGHkHpLPO9NnBcj72K/ML4DhGApElxnxeCszkmfmtD5t+c
	xW85u43dZU90BQ7o6XL7V
X-Google-Smtp-Source: AGHT+IFq8TurdVYIPBHrecz1HX/ktXdqL1rALa29iGZXxOFSxa3sI9tZ58g5nbjf6vFwFNXnEg7f4Q==
X-Received: by 2002:a05:6a20:7f90:b0:1f5:67e2:7790 with SMTP id adf61e73a8af0-1fd118010abmr1316116637.17.1742421591991;
        Wed, 19 Mar 2025 14:59:51 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167dfa2sm12656414b3a.107.2025.03.19.14.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:51 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 12/20] staging: gpib: ines: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:16 +0000
Message-ID: <20250319215924.19387-13-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319215924.19387-1-matchstick@neverthere.org>
References: <20250319215924.19387-1-matchstick@neverthere.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using Linux code style for struct gpib_board.

Adhering to Linux code style.

In general, a pointer, or a struct that has elements that can reasonably be
directly accessed should never be a typedef.

Signed-off-by: Michael Rubin <matchstick@neverthere.org>
---
 drivers/staging/gpib/ines/ines.h      |  54 ++++++-------
 drivers/staging/gpib/ines/ines_gpib.c | 111 +++++++++++++-------------
 2 files changed, 83 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/gpib/ines/ines.h b/drivers/staging/gpib/ines/ines.h
index 3918737fa21a..b17475aed046 100644
--- a/drivers/staging/gpib/ines/ines.h
+++ b/drivers/staging/gpib/ines/ines.h
@@ -36,41 +36,41 @@ struct ines_priv {
 };
 
 // interface functions
-int ines_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end, size_t *bytes_read);
-int ines_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+int ines_read(struct gpib_board *board, uint8_t *buffer, size_t length, int *end, size_t *bytes_read);
+int ines_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 	       int send_eoi, size_t *bytes_written);
-int ines_accel_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+int ines_accel_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 		    int *end, size_t *bytes_read);
-int ines_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+int ines_accel_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 		     int send_eoi, size_t *bytes_written);
-int ines_command(gpib_board_t *board, uint8_t *buffer, size_t length, size_t *bytes_written);
-int ines_take_control(gpib_board_t *board, int synchronous);
-int ines_go_to_standby(gpib_board_t *board);
-void ines_request_system_control(gpib_board_t *board, int request_control);
-void ines_interface_clear(gpib_board_t *board, int assert);
-void ines_remote_enable(gpib_board_t *board, int enable);
-int ines_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits);
-void ines_disable_eos(gpib_board_t *board);
-unsigned int ines_update_status(gpib_board_t *board, unsigned int clear_mask);
-int ines_primary_address(gpib_board_t *board, unsigned int address);
-int ines_secondary_address(gpib_board_t *board, unsigned int address, int enable);
-int ines_parallel_poll(gpib_board_t *board, uint8_t *result);
-void ines_parallel_poll_configure(gpib_board_t *board, uint8_t config);
-void ines_parallel_poll_response(gpib_board_t *board, int ist);
-void ines_serial_poll_response(gpib_board_t *board, uint8_t status);
-uint8_t ines_serial_poll_status(gpib_board_t *board);
-int ines_line_status(const gpib_board_t *board);
-unsigned int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec);
-void ines_return_to_local(gpib_board_t *board);
+int ines_command(struct gpib_board *board, uint8_t *buffer, size_t length, size_t *bytes_written);
+int ines_take_control(struct gpib_board *board, int synchronous);
+int ines_go_to_standby(struct gpib_board *board);
+void ines_request_system_control(struct gpib_board *board, int request_control);
+void ines_interface_clear(struct gpib_board *board, int assert);
+void ines_remote_enable(struct gpib_board *board, int enable);
+int ines_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits);
+void ines_disable_eos(struct gpib_board *board);
+unsigned int ines_update_status(struct gpib_board *board, unsigned int clear_mask);
+int ines_primary_address(struct gpib_board *board, unsigned int address);
+int ines_secondary_address(struct gpib_board *board, unsigned int address, int enable);
+int ines_parallel_poll(struct gpib_board *board, uint8_t *result);
+void ines_parallel_poll_configure(struct gpib_board *board, uint8_t config);
+void ines_parallel_poll_response(struct gpib_board *board, int ist);
+void ines_serial_poll_response(struct gpib_board *board, uint8_t status);
+uint8_t ines_serial_poll_status(struct gpib_board *board);
+int ines_line_status(const struct gpib_board *board);
+unsigned int ines_t1_delay(struct gpib_board *board, unsigned int nano_sec);
+void ines_return_to_local(struct gpib_board *board);
 
 // interrupt service routines
 irqreturn_t ines_pci_interrupt(int irq, void *arg);
-irqreturn_t ines_interrupt(gpib_board_t *board);
+irqreturn_t ines_interrupt(struct gpib_board *board);
 
 // utility functions
-void ines_free_private(gpib_board_t *board);
-int ines_generic_attach(gpib_board_t *board);
-void ines_online(struct ines_priv *priv, const gpib_board_t *board, int use_accel);
+void ines_free_private(struct gpib_board *board);
+int ines_generic_attach(struct gpib_board *board);
+void ines_online(struct ines_priv *priv, const struct gpib_board *board, int use_accel);
 void ines_set_xfer_counter(struct ines_priv *priv, unsigned int count);
 
 /* inb/outb wrappers */
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index d31eab1a05e4..983bb88a4376 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -25,7 +25,7 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB driver for Ines iGPIB 72010");
 
-int ines_line_status(const gpib_board_t *board)
+int ines_line_status(const struct gpib_board *board)
 {
 	int status = VALID_ALL;
 	int bcm_bits;
@@ -65,7 +65,7 @@ void ines_set_xfer_counter(struct ines_priv *priv, unsigned int count)
 	ines_outb(priv, count & 0xff, XFER_COUNT_LOWER);
 }
 
-unsigned int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+unsigned int ines_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	struct ines_priv *ines_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &ines_priv->nec7210_priv;
@@ -95,7 +95,7 @@ static inline unsigned short num_in_fifo_bytes(struct ines_priv *ines_priv)
 	return ines_inb(ines_priv, IN_FIFO_COUNT);
 }
 
-static ssize_t pio_read(gpib_board_t *board, struct ines_priv *ines_priv, uint8_t *buffer,
+static ssize_t pio_read(struct gpib_board *board, struct ines_priv *ines_priv, uint8_t *buffer,
 			size_t length, size_t *nbytes)
 {
 	ssize_t retval = 0;
@@ -133,7 +133,7 @@ static ssize_t pio_read(gpib_board_t *board, struct ines_priv *ines_priv, uint8_
 	return retval;
 }
 
-int ines_accel_read(gpib_board_t *board, uint8_t *buffer,
+int ines_accel_read(struct gpib_board *board, uint8_t *buffer,
 		    size_t length, int *end, size_t *bytes_read)
 {
 	ssize_t retval = 0;
@@ -190,7 +190,7 @@ static inline unsigned short num_out_fifo_bytes(struct ines_priv *ines_priv)
 	return ines_inb(ines_priv, OUT_FIFO_COUNT);
 }
 
-static int ines_write_wait(gpib_board_t *board, struct ines_priv *ines_priv,
+static int ines_write_wait(struct gpib_board *board, struct ines_priv *ines_priv,
 			   unsigned int fifo_threshold)
 {
 	struct nec7210_priv *nec_priv = &ines_priv->nec7210_priv;
@@ -213,7 +213,7 @@ static int ines_write_wait(gpib_board_t *board, struct ines_priv *ines_priv,
 	return 0;
 }
 
-int ines_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+int ines_accel_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 		     int send_eoi, size_t *bytes_written)
 {
 	size_t count = 0;
@@ -266,7 +266,7 @@ int ines_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 
 irqreturn_t ines_pci_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct ines_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
 
@@ -281,7 +281,7 @@ irqreturn_t ines_pci_interrupt(int irq, void *arg)
 	return ines_interrupt(board);
 }
 
-irqreturn_t ines_interrupt(gpib_board_t *board)
+irqreturn_t ines_interrupt(struct gpib_board *board)
 {
 	struct ines_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -313,12 +313,12 @@ irqreturn_t ines_interrupt(gpib_board_t *board)
 	return IRQ_HANDLED;
 }
 
-static int ines_pci_attach(gpib_board_t *board, const gpib_board_config_t *config);
-static int ines_pci_accel_attach(gpib_board_t *board, const gpib_board_config_t *config);
-static int ines_isa_attach(gpib_board_t *board, const gpib_board_config_t *config);
+static int ines_pci_attach(struct gpib_board *board, const gpib_board_config_t *config);
+static int ines_pci_accel_attach(struct gpib_board *board, const gpib_board_config_t *config);
+static int ines_isa_attach(struct gpib_board *board, const gpib_board_config_t *config);
 
-static void ines_pci_detach(gpib_board_t *board);
-static void ines_isa_detach(gpib_board_t *board);
+static void ines_pci_detach(struct gpib_board *board);
+static void ines_isa_detach(struct gpib_board *board);
 
 enum ines_pci_vendor_ids {
 	PCI_VENDOR_ID_INES_QUICKLOGIC = 0x16da
@@ -393,7 +393,8 @@ static struct ines_pci_id pci_ids[] = {
 static const int num_pci_chips = ARRAY_SIZE(pci_ids);
 
 // wrappers for interface functions
-int ines_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end, size_t *bytes_read)
+int ines_read(struct gpib_board *board, uint8_t *buffer, size_t length,
+	      int *end, size_t *bytes_read)
 {
 	struct ines_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -411,7 +412,7 @@ int ines_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end, siz
 	return retval;
 }
 
-int ines_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
+int ines_write(struct gpib_board *board, uint8_t *buffer, size_t length, int send_eoi,
 	       size_t *bytes_written)
 {
 	struct ines_priv *priv = board->private_data;
@@ -419,119 +420,119 @@ int ines_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi
 	return nec7210_write(board, &priv->nec7210_priv, buffer, length, send_eoi, bytes_written);
 }
 
-int ines_command(gpib_board_t *board, uint8_t *buffer, size_t length, size_t *bytes_written)
+int ines_command(struct gpib_board *board, uint8_t *buffer, size_t length, size_t *bytes_written)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_command(board, &priv->nec7210_priv, buffer, length, bytes_written);
 }
 
-int ines_take_control(gpib_board_t *board, int synchronous)
+int ines_take_control(struct gpib_board *board, int synchronous)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_take_control(board, &priv->nec7210_priv, synchronous);
 }
 
-int ines_go_to_standby(gpib_board_t *board)
+int ines_go_to_standby(struct gpib_board *board)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-void ines_request_system_control(gpib_board_t *board, int request_control)
+void ines_request_system_control(struct gpib_board *board, int request_control)
 {
 	struct ines_priv *priv = board->private_data;
 
 	nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
 }
 
-void ines_interface_clear(gpib_board_t *board, int assert)
+void ines_interface_clear(struct gpib_board *board, int assert)
 {
 	struct ines_priv *priv = board->private_data;
 
 	nec7210_interface_clear(board, &priv->nec7210_priv, assert);
 }
 
-void ines_remote_enable(gpib_board_t *board, int enable)
+void ines_remote_enable(struct gpib_board *board, int enable)
 {
 	struct ines_priv *priv = board->private_data;
 
 	nec7210_remote_enable(board, &priv->nec7210_priv, enable);
 }
 
-int ines_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+int ines_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_enable_eos(board, &priv->nec7210_priv, eos_byte, compare_8_bits);
 }
 
-void ines_disable_eos(gpib_board_t *board)
+void ines_disable_eos(struct gpib_board *board)
 {
 	struct ines_priv *priv = board->private_data;
 
 	nec7210_disable_eos(board, &priv->nec7210_priv);
 }
 
-unsigned int ines_update_status(gpib_board_t *board, unsigned int clear_mask)
+unsigned int ines_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_update_status(board, &priv->nec7210_priv, clear_mask);
 }
 
-int ines_primary_address(gpib_board_t *board, unsigned int address)
+int ines_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_primary_address(board, &priv->nec7210_priv, address);
 }
 
-int ines_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+int ines_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_secondary_address(board, &priv->nec7210_priv, address, enable);
 }
 
-int ines_parallel_poll(gpib_board_t *board, uint8_t *result)
+int ines_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_parallel_poll(board, &priv->nec7210_priv, result);
 }
 
-void ines_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+void ines_parallel_poll_configure(struct gpib_board *board, uint8_t config)
 {
 	struct ines_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_configure(board, &priv->nec7210_priv, config);
 }
 
-void ines_parallel_poll_response(gpib_board_t *board, int ist)
+void ines_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct ines_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_response(board, &priv->nec7210_priv, ist);
 }
 
-void ines_serial_poll_response(gpib_board_t *board, uint8_t status)
+void ines_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	struct ines_priv *priv = board->private_data;
 
 	nec7210_serial_poll_response(board, &priv->nec7210_priv, status);
 }
 
-uint8_t ines_serial_poll_status(gpib_board_t *board)
+uint8_t ines_serial_poll_status(struct gpib_board *board)
 {
 	struct ines_priv *priv = board->private_data;
 
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-void ines_return_to_local(gpib_board_t *board)
+void ines_return_to_local(struct gpib_board *board)
 {
 	struct ines_priv *priv = board->private_data;
 
@@ -650,7 +651,7 @@ static gpib_interface_t ines_isa_interface = {
 	.return_to_local = ines_return_to_local,
 };
 
-static int ines_allocate_private(gpib_board_t *board)
+static int ines_allocate_private(struct gpib_board *board)
 {
 	struct ines_priv *priv;
 
@@ -663,13 +664,13 @@ static int ines_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-void ines_free_private(gpib_board_t *board)
+void ines_free_private(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
 }
 
-int ines_generic_attach(gpib_board_t *board)
+int ines_generic_attach(struct gpib_board *board)
 {
 	struct ines_priv *ines_priv;
 	struct nec7210_priv *nec_priv;
@@ -689,7 +690,7 @@ int ines_generic_attach(gpib_board_t *board)
 	return 0;
 }
 
-void ines_online(struct ines_priv *ines_priv, const gpib_board_t *board, int use_accel)
+void ines_online(struct ines_priv *ines_priv, const struct gpib_board *board, int use_accel)
 {
 	struct nec7210_priv *nec_priv = &ines_priv->nec7210_priv;
 
@@ -723,7 +724,7 @@ void ines_online(struct ines_priv *ines_priv, const gpib_board_t *board, int use
 		nec7210_set_reg_bits(nec_priv, IMR1, HR_DOIE | HR_DIIE, 0);
 }
 
-static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int ines_common_pci_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct ines_priv *ines_priv;
 	struct nec7210_priv *nec_priv;
@@ -851,7 +852,7 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 	return 0;
 }
 
-int ines_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
+int ines_pci_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct ines_priv *ines_priv;
 	int retval;
@@ -866,7 +867,7 @@ int ines_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	return 0;
 }
 
-int ines_pci_accel_attach(gpib_board_t *board, const gpib_board_config_t *config)
+int ines_pci_accel_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct ines_priv *ines_priv;
 	int retval;
@@ -883,7 +884,7 @@ int ines_pci_accel_attach(gpib_board_t *board, const gpib_board_config_t *config
 
 static const int ines_isa_iosize = 0x20;
 
-int ines_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
+int ines_isa_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct ines_priv *ines_priv;
 	struct nec7210_priv *nec_priv;
@@ -914,7 +915,7 @@ int ines_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	return 0;
 }
 
-void ines_pci_detach(gpib_board_t *board)
+void ines_pci_detach(struct gpib_board *board)
 {
 	struct ines_priv *ines_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
@@ -948,7 +949,7 @@ void ines_pci_detach(gpib_board_t *board)
 	ines_free_private(board);
 }
 
-void ines_isa_detach(gpib_board_t *board)
+void ines_isa_detach(struct gpib_board *board)
 {
 	struct ines_priv *ines_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
@@ -999,11 +1000,11 @@ static const int ines_pcmcia_iosize = 0x20;
 
 static int ines_gpib_config(struct pcmcia_device  *link);
 static void ines_gpib_release(struct pcmcia_device  *link);
-static int ines_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config);
-static int ines_pcmcia_accel_attach(gpib_board_t *board, const gpib_board_config_t *config);
-static void ines_pcmcia_detach(gpib_board_t *board);
+static int ines_pcmcia_attach(struct gpib_board *board, const gpib_board_config_t *config);
+static int ines_pcmcia_accel_attach(struct gpib_board *board, const gpib_board_config_t *config);
+static void ines_pcmcia_detach(struct gpib_board *board);
 static irqreturn_t ines_pcmcia_interrupt(int irq, void *arg);
-static int ines_common_pcmcia_attach(gpib_board_t *board);
+static int ines_common_pcmcia_attach(struct gpib_board *board);
 /*
  * A linked list of "instances" of the gpib device.  Each actual
  *  PCMCIA card corresponds to one device instance, and is described
@@ -1035,7 +1036,7 @@ static struct pcmcia_device *curr_dev;
 
 struct local_info {
 	struct pcmcia_device	*p_dev;
-	gpib_board_t		*dev;
+	struct gpib_board		*dev;
 	u_short manfid;
 	u_short cardid;
 };
@@ -1086,7 +1087,7 @@ static int ines_gpib_probe(struct pcmcia_device *link)
 static void ines_gpib_remove(struct pcmcia_device *link)
 {
 	struct local_info *info = link->priv;
-	//struct gpib_board_t *dev = info->dev;
+	//struct struct gpib_board *dev = info->dev;
 
 	if (info->dev)
 		ines_pcmcia_detach(info->dev);
@@ -1171,7 +1172,7 @@ static void ines_gpib_release(struct pcmcia_device *link)
 static int ines_gpib_suspend(struct pcmcia_device *link)
 {
 	//struct local_info *info = link->priv;
-	//struct gpib_board_t *dev = info->dev;
+	//struct struct gpib_board *dev = info->dev;
 
 	if (link->open)
 		dev_err(&link->dev, "Device still open\n");
@@ -1183,7 +1184,7 @@ static int ines_gpib_suspend(struct pcmcia_device *link)
 static int ines_gpib_resume(struct pcmcia_device *link)
 {
 	//struct local_info_t *info = link->priv;
-	//struct gpib_board_t *dev = info->dev;
+	//struct struct gpib_board *dev = info->dev;
 
 	/*if (link->open) {
 	 *	ni_gpib_probe(dev);	/ really?
@@ -1300,12 +1301,12 @@ static gpib_interface_t ines_pcmcia_interface = {
 
 irqreturn_t ines_pcmcia_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 
 	return ines_interrupt(board);
 }
 
-int ines_common_pcmcia_attach(gpib_board_t *board)
+int ines_common_pcmcia_attach(struct gpib_board *board)
 {
 	struct ines_priv *ines_priv;
 	struct nec7210_priv *nec_priv;
@@ -1344,7 +1345,7 @@ int ines_common_pcmcia_attach(gpib_board_t *board)
 	return 0;
 }
 
-int ines_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config)
+int ines_pcmcia_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct ines_priv *ines_priv;
 	int retval;
@@ -1359,7 +1360,7 @@ int ines_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	return 0;
 }
 
-int ines_pcmcia_accel_attach(gpib_board_t *board, const gpib_board_config_t *config)
+int ines_pcmcia_accel_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct ines_priv *ines_priv;
 	int retval;
@@ -1374,7 +1375,7 @@ int ines_pcmcia_accel_attach(gpib_board_t *board, const gpib_board_config_t *con
 	return 0;
 }
 
-void ines_pcmcia_detach(gpib_board_t *board)
+void ines_pcmcia_detach(struct gpib_board *board)
 {
 	struct ines_priv *ines_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
-- 
2.43.0


