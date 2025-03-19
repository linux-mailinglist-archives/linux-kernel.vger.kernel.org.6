Return-Path: <linux-kernel+bounces-568882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A76A69BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F119C48B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438821D5A6;
	Wed, 19 Mar 2025 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="e4BSzAta"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C221CC5A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421590; cv=none; b=X07n3R0UzWjoE1w8GmuvARSpEnJpUdfU8PGqfTY7x95E5zyKhO2p0kA5mrgBA9VkNifev8HY/zWPgti1P+yaJ4xFSArUdr2ggBMDHn3IbwS4yYmoYaFeaZfRkMawJI24AEgfgJ1Okpp6VbKA9oeOJa0YIY0osDQxRAJBymBkd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421590; c=relaxed/simple;
	bh=H4tAdHGKRxmeP2+t6k9qL6m43FWvtV7f/v514CY/+00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW1Mb0kZ7/fl5GjwPHz/3KKaeYrAYJC3kg4yQTnaqD5vZYvh6low65DdRE28mv6CbfPBV2dyPRKcV17TbBzz/8a9031/urJFzCJiusGafFjxoVMM+W4W62UDZ4Ms0DRf8kvyWq0b+ARuUgMvHnAA1NygL2IiVcA0kNjPLuSFADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=e4BSzAta; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2241053582dso1174015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421587; x=1743026387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jvVAbWtCF4UFk7VFZydpOT77H5oUWGBA+2hIXnrdGo=;
        b=e4BSzAtaPj5jAkLOgWzHYbtUzdxxTI/+OvjK/w30iBWaxb1GruiCXG7pHG6Y7YgFuR
         8vCQ3o0fYnHbob4PV9370uvpVpU7bgct+5YDaTb/j+OvWhoVFuOkfDldVSEddumtvffm
         idD4aeQRMSUuoh8yIzgxY2/HeO4xulnAqnA/8nVdznMriBJU8qcFyQ6fapU/KqcBxgUE
         R9lkCKIBsVvzkZXcZ/XIziItmtctbSd2X1pHUHqzBDVfwtzbSNGIhaPQeDvXI/iCFn2Y
         4ySD9B/Zbo+KSB7CHFEaV0ukbVKYZLtmFj2RtoRQ5GZudB8U4+yD/H/TLEyrmCulBjjF
         S3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421587; x=1743026387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jvVAbWtCF4UFk7VFZydpOT77H5oUWGBA+2hIXnrdGo=;
        b=vwJLqHdvkNBl0L/DzqrAZszaehtNDJjrsnTkzAmRhWsXYfLjRNSdXS7nMwwfBuQZv6
         bse5Epy5zWP7L6iftyfv3P43LRxxj2ADbeRvXC2ydO48uRbXBFZGwi4Rir6LOETiFPBu
         U1qyiRLZA6ubL7z+vyvOFadGhVErUEIla5FgknzakCKcYS5IG1x4r98mGH6XfwcIa4MT
         mqe5nO/GOfZovNy+rgZ1H0ikd0E2wijVRdrOSGk//Kpj/keEOOTauKKCh4BSbEro77de
         27ihQfTqfBlUnVzT2U9Z1TX+xX2A+jYrA4ONjRHx5Hf/EsYSfDkjClGlkzebzGY/Y1FB
         fUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbg2d6aOK2kz5HHZj9VgrRH2EZCMJ49Mx+b5qsdeghar7laIHkObx2xhDivyPyf1xQXyCIAG0fXSvqgyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsUDJOokVkS1rdsbvuYIz22oQrpF7p8LfUNnsDl1xCpxRP9j0i
	lcaz/jjT/pegrtBIWhlvMi/YBKEgGw/WQf+qdXVEP1stgkpAatXkpBMAgDUU3w==
X-Gm-Gg: ASbGncskN26rR0U5UqnKxDa4ksFOk8QXgvL5MMqj4VASt8jHsyx57TrmWEgz1bE+09g
	huNxuMKz+fjNRtHaBg5T/Is9DtbieNLd69fZQxjbd1gnLWHAtO8c/hpXruzqHDNHYuwSkuZ4sv6
	R2gRoMjJnHkkedR/5HEZw62xmZPbZRpaD0yjgwgOU3dgFW0jo2cGlGfFM0949wtttXvZW3isjFl
	IbcMs/6BBGmaiJefhAl5GkqYOY0KJTqClzuSA39L1X9QiVL2RAOMDWpLHHWnOUtbbijLgjh82KR
	IeD8Ts++2/5YR2KFxWc2CwvFUII/MW3dIWZox8GZuU1UPVQeA6HMQyte5Zqhr/DITB1kHFNZT0r
	HE5Au5YAzsA==
X-Google-Smtp-Source: AGHT+IE/WxDPhpSJnUoHA5HSJMxQdaYFmPalzo1sj8bjoPh17FHSDlZv6vk5LD5jrwaB0CmQGdqyfA==
X-Received: by 2002:a05:6a20:7347:b0:1f5:679a:226c with SMTP id adf61e73a8af0-1fbeb3a00f3mr6582212637.5.1742421586908;
        Wed, 19 Mar 2025 14:59:46 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115781fesm12172738b3a.77.2025.03.19.14.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:46 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 08/20] staging: gpib: fmh_gpib: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:12 +0000
Message-ID: <20250319215924.19387-9-matchstick@neverthere.org>
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
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 122 ++++++++++++-----------
 1 file changed, 62 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 3e8ad8aa332f..f6bf127441f8 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -32,19 +32,21 @@ MODULE_DESCRIPTION("GPIB Driver for fmh_gpib_core");
 MODULE_AUTHOR("Frank Mori Hess <fmh6jj@gmail.com>");
 
 static irqreturn_t fmh_gpib_interrupt(int irq, void *arg);
-static int fmh_gpib_attach_holdoff_all(gpib_board_t *board, const gpib_board_config_t *config);
-static int fmh_gpib_attach_holdoff_end(gpib_board_t *board, const gpib_board_config_t *config);
-static void fmh_gpib_detach(gpib_board_t *board);
-static int fmh_gpib_pci_attach_holdoff_all(gpib_board_t *board, const gpib_board_config_t *config);
-static int fmh_gpib_pci_attach_holdoff_end(gpib_board_t *board, const gpib_board_config_t *config);
-static void fmh_gpib_pci_detach(gpib_board_t *board);
-static int fmh_gpib_config_dma(gpib_board_t *board, int output);
-static irqreturn_t fmh_gpib_internal_interrupt(gpib_board_t *board);
+static int fmh_gpib_attach_holdoff_all(struct gpib_board *board, const gpib_board_config_t *config);
+static int fmh_gpib_attach_holdoff_end(struct gpib_board *board, const gpib_board_config_t *config);
+static void fmh_gpib_detach(struct gpib_board *board);
+static int fmh_gpib_pci_attach_holdoff_all(struct gpib_board *board,
+					   const gpib_board_config_t *config);
+static int fmh_gpib_pci_attach_holdoff_end(struct gpib_board *board,
+					   const gpib_board_config_t *config);
+static void fmh_gpib_pci_detach(struct gpib_board *board);
+static int fmh_gpib_config_dma(struct gpib_board *board, int output);
+static irqreturn_t fmh_gpib_internal_interrupt(struct gpib_board *board);
 static struct platform_driver fmh_gpib_platform_driver;
 static struct pci_driver fmh_gpib_pci_driver;
 
 // wrappers for interface functions
-static int fmh_gpib_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fmh_gpib_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 			 int *end, size_t *bytes_read)
 {
 	struct fmh_priv *priv = board->private_data;
@@ -52,7 +54,7 @@ static int fmh_gpib_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return nec7210_read(board, &priv->nec7210_priv, buffer, length, end, bytes_read);
 }
 
-static int fmh_gpib_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fmh_gpib_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 			  int send_eoi, size_t *bytes_written)
 {
 	struct fmh_priv *priv = board->private_data;
@@ -60,7 +62,7 @@ static int fmh_gpib_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return nec7210_write(board, &priv->nec7210_priv, buffer, length, send_eoi, bytes_written);
 }
 
-static int fmh_gpib_command(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fmh_gpib_command(struct gpib_board *board, uint8_t *buffer, size_t length,
 			    size_t *bytes_written)
 {
 	struct fmh_priv *priv = board->private_data;
@@ -68,21 +70,21 @@ static int fmh_gpib_command(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return nec7210_command(board, &priv->nec7210_priv, buffer, length, bytes_written);
 }
 
-static int fmh_gpib_take_control(gpib_board_t *board, int synchronous)
+static int fmh_gpib_take_control(struct gpib_board *board, int synchronous)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	return nec7210_take_control(board, &priv->nec7210_priv, synchronous);
 }
 
-static int fmh_gpib_go_to_standby(gpib_board_t *board)
+static int fmh_gpib_go_to_standby(struct gpib_board *board)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void fmh_gpib_request_system_control(gpib_board_t *board, int request_control)
+static void fmh_gpib_request_system_control(struct gpib_board *board, int request_control)
 {
 	struct fmh_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -90,77 +92,77 @@ static void fmh_gpib_request_system_control(gpib_board_t *board, int request_con
 	nec7210_request_system_control(board, nec_priv, request_control);
 }
 
-static void fmh_gpib_interface_clear(gpib_board_t *board, int assert)
+static void fmh_gpib_interface_clear(struct gpib_board *board, int assert)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	nec7210_interface_clear(board, &priv->nec7210_priv, assert);
 }
 
-static void fmh_gpib_remote_enable(gpib_board_t *board, int enable)
+static void fmh_gpib_remote_enable(struct gpib_board *board, int enable)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	nec7210_remote_enable(board, &priv->nec7210_priv, enable);
 }
 
-static int fmh_gpib_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int fmh_gpib_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	return nec7210_enable_eos(board, &priv->nec7210_priv, eos_byte, compare_8_bits);
 }
 
-static void fmh_gpib_disable_eos(gpib_board_t *board)
+static void fmh_gpib_disable_eos(struct gpib_board *board)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	nec7210_disable_eos(board, &priv->nec7210_priv);
 }
 
-static unsigned int fmh_gpib_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int fmh_gpib_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	return nec7210_update_status(board, &priv->nec7210_priv, clear_mask);
 }
 
-static int fmh_gpib_primary_address(gpib_board_t *board, unsigned int address)
+static int fmh_gpib_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	return nec7210_primary_address(board, &priv->nec7210_priv, address);
 }
 
-static int fmh_gpib_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int fmh_gpib_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	return nec7210_secondary_address(board, &priv->nec7210_priv, address, enable);
 }
 
-static int fmh_gpib_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int fmh_gpib_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	return nec7210_parallel_poll(board, &priv->nec7210_priv, result);
 }
 
-static void fmh_gpib_parallel_poll_configure(gpib_board_t *board, uint8_t configuration)
+static void fmh_gpib_parallel_poll_configure(struct gpib_board *board, uint8_t configuration)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_configure(board, &priv->nec7210_priv, configuration);
 }
 
-static void fmh_gpib_parallel_poll_response(gpib_board_t *board, int ist)
+static void fmh_gpib_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_response(board, &priv->nec7210_priv, ist);
 }
 
-static void fmh_gpib_local_parallel_poll_mode(gpib_board_t *board, int local)
+static void fmh_gpib_local_parallel_poll_mode(struct gpib_board *board, int local)
 {
 	struct fmh_priv *priv = board->private_data;
 
@@ -175,7 +177,7 @@ static void fmh_gpib_local_parallel_poll_mode(gpib_board_t *board, int local)
 	}
 }
 
-static void fmh_gpib_serial_poll_response2(gpib_board_t *board, uint8_t status,
+static void fmh_gpib_serial_poll_response2(struct gpib_board *board, uint8_t status,
 					   int new_reason_for_service)
 {
 	struct fmh_priv *priv = board->private_data;
@@ -210,14 +212,14 @@ static void fmh_gpib_serial_poll_response2(gpib_board_t *board, uint8_t status,
 	spin_unlock_irqrestore(&board->spinlock, flags);
 }
 
-static uint8_t fmh_gpib_serial_poll_status(gpib_board_t *board)
+static uint8_t fmh_gpib_serial_poll_status(struct gpib_board *board)
 {
 	struct fmh_priv *priv = board->private_data;
 
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static void fmh_gpib_return_to_local(gpib_board_t *board)
+static void fmh_gpib_return_to_local(struct gpib_board *board)
 {
 	struct fmh_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -227,7 +229,7 @@ static void fmh_gpib_return_to_local(gpib_board_t *board)
 	write_byte(nec_priv, AUX_RTL, AUXMR);
 }
 
-static int fmh_gpib_line_status(const gpib_board_t *board)
+static int fmh_gpib_line_status(const struct gpib_board *board)
 {
 	int status = VALID_ALL;
 	int bsr_bits;
@@ -259,7 +261,7 @@ static int fmh_gpib_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int fmh_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int fmh_gpib_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -276,7 +278,7 @@ static unsigned int fmh_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec
 	return retval;
 }
 
-static int lacs_or_read_ready(gpib_board_t *board)
+static int lacs_or_read_ready(struct gpib_board *board)
 {
 	const struct fmh_priv *e_priv = board->private_data;
 	const struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -291,7 +293,7 @@ static int lacs_or_read_ready(gpib_board_t *board)
 	return retval;
 }
 
-static int wait_for_read(gpib_board_t *board)
+static int wait_for_read(struct gpib_board *board)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -310,7 +312,7 @@ static int wait_for_read(gpib_board_t *board)
 	return retval;
 }
 
-static int wait_for_rx_fifo_half_full_or_end(gpib_board_t *board)
+static int wait_for_rx_fifo_half_full_or_end(struct gpib_board *board)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -333,7 +335,7 @@ static int wait_for_rx_fifo_half_full_or_end(gpib_board_t *board)
 
 /* Wait until the gpib chip is ready to accept a data out byte.
  */
-static int wait_for_data_out_ready(gpib_board_t *board)
+static int wait_for_data_out_ready(struct gpib_board *board)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -357,7 +359,7 @@ static int wait_for_data_out_ready(gpib_board_t *board)
 
 static void fmh_gpib_dma_callback(void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	unsigned long flags;
@@ -389,7 +391,7 @@ static int fmh_gpib_all_bytes_are_sent(struct fmh_priv *e_priv)
 	return 1;
 }
 
-static int fmh_gpib_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fmh_gpib_dma_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 			      size_t *bytes_written)
 {
 	struct fmh_priv *e_priv = board->private_data;
@@ -467,7 +469,7 @@ static int fmh_gpib_dma_write(gpib_board_t *board, uint8_t *buffer, size_t lengt
 	return retval;
 }
 
-static int fmh_gpib_accel_write(gpib_board_t *board, uint8_t *buffer,
+static int fmh_gpib_accel_write(struct gpib_board *board, uint8_t *buffer,
 				size_t length, int send_eoi, size_t *bytes_written)
 {
 	struct fmh_priv *e_priv = board->private_data;
@@ -557,7 +559,7 @@ static int fmh_gpib_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
 	return state.residue;
 }
 
-static int wait_for_tx_fifo_half_empty(gpib_board_t *board)
+static int wait_for_tx_fifo_half_empty(struct gpib_board *board)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -582,7 +584,7 @@ static int wait_for_tx_fifo_half_empty(gpib_board_t *board)
 /* supports writing a chunk of data whose length must fit into the hardware'd xfer counter,
  * called in a loop by fmh_gpib_fifo_write()
  */
-static int fmh_gpib_fifo_write_countable(gpib_board_t *board, uint8_t *buffer,
+static int fmh_gpib_fifo_write_countable(struct gpib_board *board, uint8_t *buffer,
 					 size_t length, int send_eoi, size_t *bytes_written)
 {
 	struct fmh_priv *e_priv = board->private_data;
@@ -648,7 +650,7 @@ static int fmh_gpib_fifo_write_countable(gpib_board_t *board, uint8_t *buffer,
 	return retval;
 }
 
-static int fmh_gpib_fifo_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fmh_gpib_fifo_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 			       int send_eoi, size_t *bytes_written)
 {
 	struct fmh_priv *e_priv = board->private_data;
@@ -695,7 +697,7 @@ static int fmh_gpib_fifo_write(gpib_board_t *board, uint8_t *buffer, size_t leng
 	return retval;
 }
 
-static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
+static int fmh_gpib_dma_read(struct gpib_board *board, uint8_t *buffer,
 			     size_t length, int *end, size_t *bytes_read)
 {
 	struct fmh_priv *e_priv = board->private_data;
@@ -807,7 +809,7 @@ static int fmh_gpib_dma_read(gpib_board_t *board, uint8_t *buffer,
 	return retval;
 }
 
-static void fmh_gpib_release_rfd_holdoff(gpib_board_t *board, struct fmh_priv *e_priv)
+static void fmh_gpib_release_rfd_holdoff(struct gpib_board *board, struct fmh_priv *e_priv)
 {
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	unsigned int ext_status_1;
@@ -844,7 +846,7 @@ static void fmh_gpib_release_rfd_holdoff(gpib_board_t *board, struct fmh_priv *e
 	spin_unlock_irqrestore(&board->spinlock, flags);
 }
 
-static int fmh_gpib_accel_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fmh_gpib_accel_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 			       int *end, size_t *bytes_read)
 {
 	struct fmh_priv *e_priv = board->private_data;
@@ -894,7 +896,7 @@ static int fmh_gpib_accel_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 /* Read a chunk of data whose length is within the limits of the hardware's
  * xfer counter.  Called in a loop from fmh_gpib_fifo_read().
  */
-static int fmh_gpib_fifo_read_countable(gpib_board_t *board, uint8_t *buffer,
+static int fmh_gpib_fifo_read_countable(struct gpib_board *board, uint8_t *buffer,
 					size_t length, int *end, size_t *bytes_read)
 {
 	struct fmh_priv *e_priv = board->private_data;
@@ -952,7 +954,7 @@ static int fmh_gpib_fifo_read_countable(gpib_board_t *board, uint8_t *buffer,
 	return retval;
 }
 
-static int fmh_gpib_fifo_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fmh_gpib_fifo_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 			      int *end, size_t *bytes_read)
 {
 	struct fmh_priv *e_priv = board->private_data;
@@ -1121,7 +1123,7 @@ static gpib_interface_t fmh_gpib_pci_unaccel_interface = {
 	.return_to_local = fmh_gpib_return_to_local,
 };
 
-irqreturn_t fmh_gpib_internal_interrupt(gpib_board_t *board)
+irqreturn_t fmh_gpib_internal_interrupt(struct gpib_board *board)
 {
 	unsigned int status0, status1, status2, ext_status_1, fifo_status;
 	struct fmh_priv *priv = board->private_data;
@@ -1211,7 +1213,7 @@ irqreturn_t fmh_gpib_internal_interrupt(gpib_board_t *board)
 
 irqreturn_t fmh_gpib_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	unsigned long flags;
 	irqreturn_t retval;
 
@@ -1221,7 +1223,7 @@ irqreturn_t fmh_gpib_interrupt(int irq, void *arg)
 	return retval;
 }
 
-static int fmh_gpib_allocate_private(gpib_board_t *board)
+static int fmh_gpib_allocate_private(struct gpib_board *board)
 {
 	struct fmh_priv *priv;
 
@@ -1238,7 +1240,7 @@ static int fmh_gpib_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void fmh_gpib_generic_detach(gpib_board_t *board)
+static void fmh_gpib_generic_detach(struct gpib_board *board)
 {
 	if (board->private_data) {
 		struct fmh_priv *e_priv = board->private_data;
@@ -1252,7 +1254,7 @@ static void fmh_gpib_generic_detach(gpib_board_t *board)
 }
 
 // generic part of attach functions
-static int fmh_gpib_generic_attach(gpib_board_t *board)
+static int fmh_gpib_generic_attach(struct gpib_board *board)
 {
 	struct fmh_priv *e_priv;
 	struct nec7210_priv *nec_priv;
@@ -1272,7 +1274,7 @@ static int fmh_gpib_generic_attach(gpib_board_t *board)
 	return 0;
 }
 
-static int fmh_gpib_config_dma(gpib_board_t *board, int output)
+static int fmh_gpib_config_dma(struct gpib_board *board, int output)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct dma_slave_config config;
@@ -1302,7 +1304,7 @@ static int fmh_gpib_config_dma(gpib_board_t *board, int output)
 	return dmaengine_slave_config(e_priv->dma_channel, &config);
 }
 
-static int fmh_gpib_init(struct fmh_priv *e_priv, gpib_board_t *board, int handshake_mode)
+static int fmh_gpib_init(struct fmh_priv *e_priv, struct gpib_board *board, int handshake_mode)
 {
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	unsigned long flags;
@@ -1349,7 +1351,7 @@ static int fmh_gpib_device_match(struct device *dev, const void *data)
 	return 1;
 }
 
-static int fmh_gpib_attach_impl(gpib_board_t *board, const gpib_board_config_t *config,
+static int fmh_gpib_attach_impl(struct gpib_board *board, const gpib_board_config_t *config,
 				unsigned int handshake_mode, int acquire_dma)
 {
 	struct fmh_priv *e_priv;
@@ -1452,17 +1454,17 @@ static int fmh_gpib_attach_impl(gpib_board_t *board, const gpib_board_config_t *
 	return fmh_gpib_init(e_priv, board, handshake_mode);
 }
 
-int fmh_gpib_attach_holdoff_all(gpib_board_t *board, const gpib_board_config_t *config)
+int fmh_gpib_attach_holdoff_all(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	return fmh_gpib_attach_impl(board, config, HR_HLDA, 0);
 }
 
-int fmh_gpib_attach_holdoff_end(gpib_board_t *board, const gpib_board_config_t *config)
+int fmh_gpib_attach_holdoff_end(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	return fmh_gpib_attach_impl(board, config, HR_HLDE, 1);
 }
 
-void fmh_gpib_detach(gpib_board_t *board)
+void fmh_gpib_detach(struct gpib_board *board)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
@@ -1495,7 +1497,7 @@ void fmh_gpib_detach(gpib_board_t *board)
 	fmh_gpib_generic_detach(board);
 }
 
-static int fmh_gpib_pci_attach_impl(gpib_board_t *board, const gpib_board_config_t *config,
+static int fmh_gpib_pci_attach_impl(struct gpib_board *board, const gpib_board_config_t *config,
 				    unsigned int handshake_mode)
 {
 	struct fmh_priv *e_priv;
@@ -1568,12 +1570,12 @@ static int fmh_gpib_pci_attach_impl(gpib_board_t *board, const gpib_board_config
 	return fmh_gpib_init(e_priv, board, handshake_mode);
 }
 
-int fmh_gpib_pci_attach_holdoff_all(gpib_board_t *board, const gpib_board_config_t *config)
+int fmh_gpib_pci_attach_holdoff_all(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	return fmh_gpib_pci_attach_impl(board, config, HR_HLDA);
 }
 
-int fmh_gpib_pci_attach_holdoff_end(gpib_board_t *board, const gpib_board_config_t *config)
+int fmh_gpib_pci_attach_holdoff_end(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	int retval;
 	struct fmh_priv *e_priv;
@@ -1587,7 +1589,7 @@ int fmh_gpib_pci_attach_holdoff_end(gpib_board_t *board, const gpib_board_config
 	return retval;
 }
 
-void fmh_gpib_pci_detach(gpib_board_t *board)
+void fmh_gpib_pci_detach(struct gpib_board *board)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
-- 
2.43.0


