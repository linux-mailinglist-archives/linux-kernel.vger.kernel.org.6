Return-Path: <linux-kernel+bounces-568881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A438DA69BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7317AEF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A957521D3D6;
	Wed, 19 Mar 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="Og1DPyT6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1C21CA03
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421588; cv=none; b=IVh7Ub+h2MSbeI0iM5TqiK2zoGso88NXeJ1nsZ30hrn7jr36BO2tjm+Sf8SJ+/qLdq9eCQm9TF5fixuwWNcJg6yhOwx/HbynT3V4iFt+eKjXpUT+6FEs792kBzdFiQoQwtGEqQ4CFJpsyDgQr9Ydq0Gwm+MrSSTOL40VaHgweRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421588; c=relaxed/simple;
	bh=P/5ykYZI10RLWyKwkmYwJcya+qVgmSlheP+M6T2keQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2LZxDjpozFFlc5uVo6d8t8I/rFaIUu7iKhXLNWC0U/rlfxoSV4EwgztgHzVCKNk5a+/xg0Y4HQpqjty9ehbSNL1ofux8jiEqPg9iWs6paqOndJ+pn/5EpvvF8WWdz6r5kqMWOdulK0w9YyXqNJu1mEFTcPDv9pqS9RVj+5z7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=Og1DPyT6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225fbdfc17dso591185ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421586; x=1743026386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elxSKl7AGO+ZSNzT6IOEbe4Fdz4wwlKYMK78WvS7mAw=;
        b=Og1DPyT6cMwvUS1do7BG2YR444fJVoPLSRvVZYbOg4ocGfYALiwR+S08xfGgFEgzpH
         9vVwVPo1LnFkiVSq1uy4K/1uYG5kNV0vJIA51vqNalqE7xe45vUa4vlR4grXTNa33Mxa
         9e1NK2n3TNMGeIxzgCJIlHFVv8UwWbofWWGRuxIXridBesSU3p+kvF5sUZfKrhC92AuX
         zWzdx3AOYzxiNlrdl4FOYklzfcsTeRzRncF4WmbnZOo9E1S+sU9m72B+59KpKaMlVNFf
         vUcht/AM4mZ1zJqjxEsjUuz1D0ZNxFQWrzL2FhtO6TnjHU4UD7qGqWmjP19uwPBwvesr
         ucDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421586; x=1743026386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elxSKl7AGO+ZSNzT6IOEbe4Fdz4wwlKYMK78WvS7mAw=;
        b=QcSqvUmgsOqOH8wkzF3S7Rk9PQAvkKepVDfR6sjFpkFbSDXw4yzbcbxMcpdYE65n0J
         wdvOHTglOpHZHEBcj1l2PGxgLFSBqVQEgNibL4r9DjHBs+m+mPRKTF7jvQVbLLgI0sHB
         qfXibtdJ83dX01WqIoOLPWinRftwyg+CHmi7MODcCPHiGpLkkJWfa0uY0wdMbiM2xWv3
         KNvOHdOsIk90YCb4yF5TtoeAs29XVOWhHOWwvdQ/iqi+LTJxXSnaV6am3F/eFOvb1zfL
         GX9pc5c5gw806sDoigC7IheoXtG51jytMqSOKz94Ysq5VQOM+l1HWJmU3/1j1SiYTjA8
         Mwag==
X-Forwarded-Encrypted: i=1; AJvYcCUqezuRSbsk5x85vN99UhvKtJDQuhO+O6kAIdJQ5IswDr8p3F0kpnHKwxo4gzGV3kzSIKqG+4Plm2y3BqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqM9eC2qlTadqKs0i0s4mB0bX7RpM7zvvmgD04sOnSIOo3jA/
	9mw52/u8ZEEoVEJL8/63/1PrHGKBp6ANQrmmmstlPy9d+J0PQ2sBYu22UzyZFkIwL8nYIhi6rGc
	=
X-Gm-Gg: ASbGncs5qqRiT4iyIc6DOb9TZ6+jDu/Wx0uit9Ndc8tkdX1DImxxE01GnWBzhLwrqoc
	ItcPx4YR1H+tiR7Ije+F+VThwIytwz//Kb4XeLN+4JZ0y9fH8N26SXxRtBKrLrYR2Ay7ymSyDjf
	LGJ8sCMBQpEzrzkEGzBpcRPVUtqyPPdYFtk0yq5+NZXjxGdqQ3ljvYd4sGZq7q9Rua5S2LygCh1
	CFuQDXd3I8BSF/KSGlZEghROwTkohVxHPzD7Tsc/WVIsRCf8sT9mYAYCFeLjgN6OfiUEfzDyu2B
	3ceuo81nWNJCYQfJsOc/5u6dEUYZlJT0BYj0ta5XbnsNjKNJSsk00/wji6I5W6lMfwlHU0v3fct
	BDe0CTRmU3Q==
X-Google-Smtp-Source: AGHT+IFYbsQ1m57VdkJpKBY3iiNXPXlGziicMAq7oKaC/qg+0o6Iw376vNVx3icGfiQlopRRUceOTQ==
X-Received: by 2002:a05:6a20:a126:b0:1f5:77bd:ecbc with SMTP id adf61e73a8af0-1fbeb9991e4mr6690469637.16.1742421585682;
        Wed, 19 Mar 2025 14:59:45 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7c718sm11529841a12.62.2025.03.19.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:45 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 07/20] staging: gpib: eastwood: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:11 +0000
Message-ID: <20250319215924.19387-8-matchstick@neverthere.org>
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
 drivers/staging/gpib/eastwood/fluke_gpib.c | 93 +++++++++++-----------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index bcddf3125b8c..b3b629c892e2 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -24,11 +24,11 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB Driver for Fluke cda devices");
 
-static int fluke_attach_holdoff_all(gpib_board_t *board, const gpib_board_config_t *config);
-static int fluke_attach_holdoff_end(gpib_board_t *board, const gpib_board_config_t *config);
-static void fluke_detach(gpib_board_t *board);
-static int fluke_config_dma(gpib_board_t *board, int output);
-static irqreturn_t fluke_gpib_internal_interrupt(gpib_board_t *board);
+static int fluke_attach_holdoff_all(struct gpib_board *board, const gpib_board_config_t *config);
+static int fluke_attach_holdoff_end(struct gpib_board *board, const gpib_board_config_t *config);
+static void fluke_detach(struct gpib_board *board);
+static int fluke_config_dma(struct gpib_board *board, int output);
+static irqreturn_t fluke_gpib_internal_interrupt(struct gpib_board *board);
 
 static struct platform_device *fluke_gpib_pdev;
 
@@ -54,7 +54,7 @@ static void fluke_locking_write_byte(struct nec7210_priv *nec_priv, uint8_t byte
 }
 
 // wrappers for interface functions
-static int fluke_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
+static int fluke_read(struct gpib_board *board, uint8_t *buffer, size_t length, int *end,
 		      size_t *bytes_read)
 {
 	struct fluke_priv *priv = board->private_data;
@@ -62,7 +62,7 @@ static int fluke_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *
 	return nec7210_read(board, &priv->nec7210_priv, buffer, length, end, bytes_read);
 }
 
-static int fluke_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fluke_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 		       int send_eoi, size_t *bytes_written)
 {
 	struct fluke_priv *priv = board->private_data;
@@ -70,28 +70,29 @@ static int fluke_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return nec7210_write(board, &priv->nec7210_priv, buffer, length, send_eoi, bytes_written);
 }
 
-static int fluke_command(gpib_board_t *board, uint8_t *buffer, size_t length, size_t *bytes_written)
+static int fluke_command(struct gpib_board *board, uint8_t *buffer,
+			 size_t length, size_t *bytes_written)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_command(board, &priv->nec7210_priv, buffer, length, bytes_written);
 }
 
-static int fluke_take_control(gpib_board_t *board, int synchronous)
+static int fluke_take_control(struct gpib_board *board, int synchronous)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_take_control(board, &priv->nec7210_priv, synchronous);
 }
 
-static int fluke_go_to_standby(gpib_board_t *board)
+static int fluke_go_to_standby(struct gpib_board *board)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void fluke_request_system_control(gpib_board_t *board, int request_control)
+static void fluke_request_system_control(struct gpib_board *board, int request_control)
 {
 	struct fluke_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -99,91 +100,91 @@ static void fluke_request_system_control(gpib_board_t *board, int request_contro
 	nec7210_request_system_control(board, nec_priv, request_control);
 }
 
-static void fluke_interface_clear(gpib_board_t *board, int assert)
+static void fluke_interface_clear(struct gpib_board *board, int assert)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	nec7210_interface_clear(board, &priv->nec7210_priv, assert);
 }
 
-static void fluke_remote_enable(gpib_board_t *board, int enable)
+static void fluke_remote_enable(struct gpib_board *board, int enable)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	nec7210_remote_enable(board, &priv->nec7210_priv, enable);
 }
 
-static int fluke_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int fluke_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_enable_eos(board, &priv->nec7210_priv, eos_byte, compare_8_bits);
 }
 
-static void fluke_disable_eos(gpib_board_t *board)
+static void fluke_disable_eos(struct gpib_board *board)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	nec7210_disable_eos(board, &priv->nec7210_priv);
 }
 
-static unsigned int fluke_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int fluke_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_update_status(board, &priv->nec7210_priv, clear_mask);
 }
 
-static int fluke_primary_address(gpib_board_t *board, unsigned int address)
+static int fluke_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_primary_address(board, &priv->nec7210_priv, address);
 }
 
-static int fluke_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int fluke_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_secondary_address(board, &priv->nec7210_priv, address, enable);
 }
 
-static int fluke_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int fluke_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_parallel_poll(board, &priv->nec7210_priv, result);
 }
 
-static void fluke_parallel_poll_configure(gpib_board_t *board, uint8_t configuration)
+static void fluke_parallel_poll_configure(struct gpib_board *board, uint8_t configuration)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_configure(board, &priv->nec7210_priv, configuration);
 }
 
-static void fluke_parallel_poll_response(gpib_board_t *board, int ist)
+static void fluke_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_response(board, &priv->nec7210_priv, ist);
 }
 
-static void fluke_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void fluke_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	nec7210_serial_poll_response(board, &priv->nec7210_priv, status);
 }
 
-static uint8_t fluke_serial_poll_status(gpib_board_t *board)
+static uint8_t fluke_serial_poll_status(struct gpib_board *board)
 {
 	struct fluke_priv *priv = board->private_data;
 
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static void fluke_return_to_local(gpib_board_t *board)
+static void fluke_return_to_local(struct gpib_board *board)
 {
 	struct fluke_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -193,7 +194,7 @@ static void fluke_return_to_local(gpib_board_t *board)
 	write_byte(nec_priv, AUX_RTL, AUXMR);
 }
 
-static int fluke_line_status(const gpib_board_t *board)
+static int fluke_line_status(const struct gpib_board *board)
 {
 	int status = VALID_ALL;
 	int bsr_bits;
@@ -223,7 +224,7 @@ static int fluke_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int fluke_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int fluke_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -240,7 +241,7 @@ static unsigned int fluke_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 	return retval;
 }
 
-static int lacs_or_read_ready(gpib_board_t *board)
+static int lacs_or_read_ready(struct gpib_board *board)
 {
 	const struct fluke_priv *e_priv = board->private_data;
 	const struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -256,7 +257,7 @@ static int lacs_or_read_ready(gpib_board_t *board)
 /* Wait until it is possible for a read to do something useful.  This
  * is not essential, it only exists to prevent RFD holdoff from being released pointlessly.
  */
-static int wait_for_read(gpib_board_t *board)
+static int wait_for_read(struct gpib_board *board)
 {
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -313,7 +314,7 @@ static int source_handshake_is_sids_or_sgns(struct fluke_priv *e_priv)
  * If the chip is SGNS it is probably waiting for a a byte to
  * be written to it.
  */
-static int wait_for_data_out_ready(gpib_board_t *board)
+static int wait_for_data_out_ready(struct gpib_board *board)
 {
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -332,7 +333,7 @@ static int wait_for_data_out_ready(gpib_board_t *board)
 	return retval;
 }
 
-static int wait_for_sids_or_sgns(gpib_board_t *board)
+static int wait_for_sids_or_sgns(struct gpib_board *board)
 {
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
@@ -353,7 +354,7 @@ static int wait_for_sids_or_sgns(gpib_board_t *board)
 
 static void fluke_dma_callback(void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 	unsigned long flags;
@@ -370,7 +371,7 @@ static void fluke_dma_callback(void *arg)
 	spin_unlock_irqrestore(&board->spinlock, flags);
 }
 
-static int fluke_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fluke_dma_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 			   size_t *bytes_written)
 {
 	struct fluke_priv *e_priv = board->private_data;
@@ -455,7 +456,7 @@ static int fluke_dma_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return retval;
 }
 
-static int fluke_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fluke_accel_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 			     int send_eoi, size_t *bytes_written)
 {
 	struct fluke_priv *e_priv = board->private_data;
@@ -543,7 +544,7 @@ static int fluke_get_dma_residue(struct dma_chan *chan, dma_cookie_t cookie)
 	return state.residue;
 }
 
-static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
+static int fluke_dma_read(struct gpib_board *board, uint8_t *buffer,
 			  size_t length, int *end, size_t *bytes_read)
 {
 	struct fluke_priv *e_priv = board->private_data;
@@ -656,7 +657,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
 	return retval;
 }
 
-static int fluke_accel_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int fluke_accel_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 			    int *end, size_t *bytes_read)
 {
 	struct fluke_priv *e_priv = board->private_data;
@@ -786,7 +787,7 @@ static gpib_interface_t fluke_interface = {
 	.return_to_local = fluke_return_to_local,
 };
 
-irqreturn_t fluke_gpib_internal_interrupt(gpib_board_t *board)
+irqreturn_t fluke_gpib_internal_interrupt(struct gpib_board *board)
 {
 	int status0, status1, status2;
 	struct fluke_priv *priv = board->private_data;
@@ -823,7 +824,7 @@ irqreturn_t fluke_gpib_internal_interrupt(gpib_board_t *board)
 
 static irqreturn_t fluke_gpib_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	unsigned long flags;
 	irqreturn_t retval;
 
@@ -833,7 +834,7 @@ static irqreturn_t fluke_gpib_interrupt(int irq, void *arg)
 	return retval;
 }
 
-static int fluke_allocate_private(gpib_board_t *board)
+static int fluke_allocate_private(struct gpib_board *board)
 {
 	struct fluke_priv *priv;
 
@@ -850,7 +851,7 @@ static int fluke_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void fluke_generic_detach(gpib_board_t *board)
+static void fluke_generic_detach(struct gpib_board *board)
 {
 	if (board->private_data) {
 		struct fluke_priv *e_priv = board->private_data;
@@ -862,7 +863,7 @@ static void fluke_generic_detach(gpib_board_t *board)
 }
 
 // generic part of attach functions shared by all cb7210 boards
-static int fluke_generic_attach(gpib_board_t *board)
+static int fluke_generic_attach(struct gpib_board *board)
 {
 	struct fluke_priv *e_priv;
 	struct nec7210_priv *nec_priv;
@@ -882,7 +883,7 @@ static int fluke_generic_attach(gpib_board_t *board)
 	return 0;
 }
 
-static int fluke_config_dma(gpib_board_t *board, int output)
+static int fluke_config_dma(struct gpib_board *board, int output)
 {
 	struct fluke_priv *e_priv = board->private_data;
 	struct dma_slave_config config;
@@ -907,7 +908,7 @@ static int fluke_config_dma(gpib_board_t *board, int output)
 	return dmaengine_slave_config(e_priv->dma_channel, &config);
 }
 
-static int fluke_init(struct fluke_priv *e_priv, gpib_board_t *board, int handshake_mode)
+static int fluke_init(struct fluke_priv *e_priv, struct gpib_board *board, int handshake_mode)
 {
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
 
@@ -942,7 +943,7 @@ static bool gpib_dma_channel_filter(struct dma_chan *chan, void *filter_param)
 	return chan->chan_id == 0;
 }
 
-static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *config,
+static int fluke_attach_impl(struct gpib_board *board, const gpib_board_config_t *config,
 			     unsigned int handshake_mode)
 {
 	struct fluke_priv *e_priv;
@@ -1048,17 +1049,17 @@ static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *con
 	return fluke_init(e_priv, board, handshake_mode);
 }
 
-int fluke_attach_holdoff_all(gpib_board_t *board, const gpib_board_config_t *config)
+int fluke_attach_holdoff_all(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	return fluke_attach_impl(board, config, HR_HLDA);
 }
 
-int fluke_attach_holdoff_end(gpib_board_t *board, const gpib_board_config_t *config)
+int fluke_attach_holdoff_end(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	return fluke_attach_impl(board, config, HR_HLDE);
 }
 
-void fluke_detach(gpib_board_t *board)
+void fluke_detach(struct gpib_board *board)
 {
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
-- 
2.43.0


