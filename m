Return-Path: <linux-kernel+bounces-568883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB06A69BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAAC7AFC17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2018B21D5AB;
	Wed, 19 Mar 2025 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="hgA83e9Z"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138E21CFFD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421590; cv=none; b=jhwzxh3+bKPLL0C5sjLB/DlZoYPIbWRXGrvxQoM95zdJYzueYTX0XKi5x93eDc9s0xcI6ZU2j3YuylgwP1gJyCugC8fwyJuFmmvVqtySzvoUVXCpf0AT1nWHKSw2o8BKkfmm8Gzw+wDiuI/d2PUIxSt5XGwuXN22CLngPSTRimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421590; c=relaxed/simple;
	bh=L1k/19t8nOGN9eeO0Lyxg8wQ4e+VVpMLI+yb4PhnN0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNFNid4O7+3hR1mPshZI/j40QJMVWGgktpw3Z3Hxa7w8C88D2FboSM4Hm1QBfKaQWkxt7Ew02ci9+CFMwkT28U8PM3LSwa7EYJu8CQ2S9m4Ki6aRTzj9gflXBcoUWNsuisvcw91GXU/DnZ2Odd3DrCAC5iN1HwSDEFutE/ozox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=hgA83e9Z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so307228a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421588; x=1743026388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04dsU5r0BWGVu2eJZSpZaOZV/2vvvf2HMuy5ZIcz5Xc=;
        b=hgA83e9ZrGmDv37GYpIzAoI5/1lNEtf3iZLLl/zjYXAqtgMS8op96wahjxYvZ/xdCf
         A83R+P1LGGib92l1eS8VQqc8t96WuiOgtj0L4AUhs47iF2/8m/+spTNKg18SQEUj9kFg
         ZcQhAvKa7KfHft2pWk0e18TI1uKDgcr86metTXBLWlyBDS4qNIT1Hmtlq256tP2Q5uTz
         q9qucBlWNoyWVk3gU/BpCpgNj/fytYYP7tXxszHEYRwV+IQds6x5L0FtLbT5Q5l+nY1K
         CqL3yWgbvk7kGSnRDTCiZ1mkTZw9wMer36l/B5fhk5c3lXzKWRglYNzTvSewXOhJJPrF
         zTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421588; x=1743026388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04dsU5r0BWGVu2eJZSpZaOZV/2vvvf2HMuy5ZIcz5Xc=;
        b=fvK8zbGbCU/8U3fW3a4JheXrkDAdiunWUrpG0YsH0vepM6pqlM698f89xxv/VHogev
         MyUieMvVv0NQOi4St4VIsA9pQeFwwR/kLqJuqOhS4X9HIlDS5PewBE4TdsN2iDL/5TQz
         qMHLLQAeIQVoNSQUK8R6JZfItPs/vLGsHQNCE3gtQYneaNRQBKc8bA+vEWFG5KSwG8/C
         dTFOkbQbxKBY8BhP5h3tAhQtevwUwdrDKKyGt/zATM6vf6b7HIrDbxNAwHK/jRTLDZAY
         sQpo9iG0CqpguhfFuPKE57f0yU7RZ+SuxM6bpjk9lZOr+E1/GhUWv+2JP8WzrTpreiPP
         lQcw==
X-Forwarded-Encrypted: i=1; AJvYcCVrcRgTh3l92SvZybj5dHAbIEMwPKWU8EUuncw5QfqHN42KimfyIISyINQgSHGosYp3G5T8eUYdh1RN9Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqhIv5+wamY1NDmsg9r2XqPvv5qVFzCF68eFDzzBwYEq73Je00
	nt4+C4EbyfOpU1BcUca3Vf0JKJlkAggMKAkzwLWJ+F3Kghm8kC8OzcCC9W3fgA==
X-Gm-Gg: ASbGncuZnBkbZx93VO/sfG3Mb1yfm6zUeR5EA3anPmdY5LmJSYMPUcXh9TxbMA9COTF
	k49dfzxUtUaqepepnBr0tH8Pb2RIPW/dW088eKEwWsOj1/MQF9V+P57gkl/DW0wp9RbOqe4AQqJ
	9HKrHKvw6y5D/vm8lUZOW6i6mDS3Aiej3Y2dnkWE5EnkOgBcSNsQznc/NvbLOZ3gUGQzTrfhpBI
	jVS0FQOhwsBBSLDx78eiaX6I2tJ8zxy9OCSmTlhgyuN11WytlXQvjfDQ1dMvN/KLs0YRGTS3v9d
	5s5kGVSFs4GvFQ/6tlZB2bJIIS3+bWsF0GQ2eGNZhYB9+dkgQPNXT+wbl72c/7Qqs7fzwkVq75a
	gBAevFltaMg==
X-Google-Smtp-Source: AGHT+IHLofUZ1rdmRG30wTO7kU+S2DZQ8/Ihke9Nxn15kz1d/0kKljZkCgMGUa6bmwmbQ+PkGAdBQg==
X-Received: by 2002:a17:90b:1650:b0:2f6:dcc9:38e0 with SMTP id 98e67ed59e1d1-301bdca2101mr7427254a91.0.1742421588171;
        Wed, 19 Mar 2025 14:59:48 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576884sm2247505a91.1.2025.03.19.14.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:47 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 09/20] staging: gpib: gpio: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:13 +0000
Message-ID: <20250319215924.19387-10-matchstick@neverthere.org>
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
 drivers/staging/gpib/gpio/gpib_bitbang.c | 72 ++++++++++++------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 28c5fa9b81ab..611ff58b94ca 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -318,14 +318,14 @@ struct bb_priv {
 };
 
 static inline long usec_diff(struct timespec64 *a, struct timespec64 *b);
-static void bb_buffer_print(gpib_board_t *board, unsigned char *buffer, size_t length,
+static void bb_buffer_print(struct gpib_board *board, unsigned char *buffer, size_t length,
 			    int cmd, int eoi);
 static void set_data_lines(u8 byte);
 static u8 get_data_lines(void);
 static void set_data_lines_input(void);
 static void set_data_lines_output(void);
 static inline int check_for_eos(struct bb_priv *priv, uint8_t byte);
-static void set_atn(gpib_board_t *board, int atn_asserted);
+static void set_atn(struct gpib_board *board, int atn_asserted);
 
 static inline void SET_DIR_WRITE(struct bb_priv *priv);
 static inline void SET_DIR_READ(struct bb_priv *priv);
@@ -353,7 +353,7 @@ static char printable(char x)
  *									   *
  ***************************************************************************/
 
-static int bb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int bb_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 		   int *end, size_t *bytes_read)
 {
 	struct bb_priv *priv = board->private_data;
@@ -425,7 +425,7 @@ static int bb_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 
 static irqreturn_t bb_DAV_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct bb_priv *priv = board->private_data;
 	int val;
 	unsigned long flags;
@@ -491,7 +491,7 @@ static irqreturn_t bb_DAV_interrupt(int irq, void *arg)
  *									   *
  ***************************************************************************/
 
-static int bb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int bb_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 		    int send_eoi, size_t *bytes_written)
 {
 	unsigned long flags;
@@ -580,7 +580,7 @@ static int bb_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 
 static irqreturn_t bb_NRFD_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct bb_priv *priv = board->private_data;
 	unsigned long flags;
 	int nrfd;
@@ -653,7 +653,7 @@ static irqreturn_t bb_NRFD_interrupt(int irq, void *arg)
 
 static irqreturn_t bb_NDAC_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct bb_priv *priv = board->private_data;
 	unsigned long flags;
 	int ndac;
@@ -714,7 +714,7 @@ static irqreturn_t bb_NDAC_interrupt(int irq, void *arg)
 
 static irqreturn_t bb_SRQ_interrupt(int irq, void *arg)
 {
-	gpib_board_t  *board = arg;
+	struct gpib_board  *board = arg;
 
 	int val = gpiod_get_value(SRQ);
 
@@ -728,7 +728,7 @@ static irqreturn_t bb_SRQ_interrupt(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int bb_command(gpib_board_t *board, uint8_t *buffer,
+static int bb_command(struct gpib_board *board, uint8_t *buffer,
 		      size_t length, size_t *bytes_written)
 {
 	size_t ret;
@@ -809,7 +809,7 @@ static char *cmd_string[32] = {
 	"CFE"  // 0x1f
 };
 
-static void bb_buffer_print(gpib_board_t *board, unsigned char *buffer, size_t length,
+static void bb_buffer_print(struct gpib_board *board, unsigned char *buffer, size_t length,
 			    int cmd, int eoi)
 {
 	int i;
@@ -842,7 +842,7 @@ static void bb_buffer_print(gpib_board_t *board, unsigned char *buffer, size_t l
  * STATUS Management							   *
  *									   *
  ***************************************************************************/
-static void set_atn(gpib_board_t *board, int atn_asserted)
+static void set_atn(struct gpib_board *board, int atn_asserted)
 {
 	struct bb_priv *priv = board->private_data;
 
@@ -867,7 +867,7 @@ static void set_atn(gpib_board_t *board, int atn_asserted)
 	priv->atn_asserted = atn_asserted;
 }
 
-static int bb_take_control(gpib_board_t *board, int synchronous)
+static int bb_take_control(struct gpib_board *board, int synchronous)
 {
 	dbg_printk(2, "%d\n", synchronous);
 	set_atn(board, 1);
@@ -875,14 +875,14 @@ static int bb_take_control(gpib_board_t *board, int synchronous)
 	return 0;
 }
 
-static int bb_go_to_standby(gpib_board_t *board)
+static int bb_go_to_standby(struct gpib_board *board)
 {
 	dbg_printk(2, "\n");
 	set_atn(board, 0);
 	return 0;
 }
 
-static void bb_request_system_control(gpib_board_t *board, int request_control)
+static void bb_request_system_control(struct gpib_board *board, int request_control)
 {
 	dbg_printk(2, "%d\n", request_control);
 	if (request_control) {
@@ -894,7 +894,7 @@ static void bb_request_system_control(gpib_board_t *board, int request_control)
 	}
 }
 
-static void bb_interface_clear(gpib_board_t *board, int assert)
+static void bb_interface_clear(struct gpib_board *board, int assert)
 {
 	struct bb_priv *priv = board->private_data;
 
@@ -908,7 +908,7 @@ static void bb_interface_clear(gpib_board_t *board, int assert)
 	}
 }
 
-static void bb_remote_enable(gpib_board_t *board, int enable)
+static void bb_remote_enable(struct gpib_board *board, int enable)
 {
 	dbg_printk(2, "%d\n", enable);
 	if (enable) {
@@ -920,7 +920,7 @@ static void bb_remote_enable(gpib_board_t *board, int enable)
 	}
 }
 
-static int bb_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int bb_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct bb_priv *priv = board->private_data;
 
@@ -933,7 +933,7 @@ static int bb_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bi
 	return 0;
 }
 
-static void bb_disable_eos(gpib_board_t *board)
+static void bb_disable_eos(struct gpib_board *board)
 {
 	struct bb_priv *priv = board->private_data;
 
@@ -941,7 +941,7 @@ static void bb_disable_eos(gpib_board_t *board)
 	priv->eos_flags &= ~REOS;
 }
 
-static unsigned int bb_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int bb_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct bb_priv *priv = board->private_data;
 
@@ -972,14 +972,14 @@ static unsigned int bb_update_status(gpib_board_t *board, unsigned int clear_mas
 	return board->status;
 }
 
-static int bb_primary_address(gpib_board_t *board, unsigned int address)
+static int bb_primary_address(struct gpib_board *board, unsigned int address)
 {
 	dbg_printk(2, "%d\n", address);
 	board->pad = address;
 	return 0;
 }
 
-static int bb_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int bb_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	dbg_printk(2, "%d %d\n", address, enable);
 	if (enable)
@@ -987,29 +987,29 @@ static int bb_secondary_address(gpib_board_t *board, unsigned int address, int e
 	return 0;
 }
 
-static int bb_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int bb_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	return -ENOENT;
 }
 
-static void bb_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+static void bb_parallel_poll_configure(struct gpib_board *board, uint8_t config)
 {
 }
 
-static void bb_parallel_poll_response(gpib_board_t *board, int ist)
+static void bb_parallel_poll_response(struct gpib_board *board, int ist)
 {
 }
 
-static void bb_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void bb_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 }
 
-static uint8_t bb_serial_poll_status(gpib_board_t *board)
+static uint8_t bb_serial_poll_status(struct gpib_board *board)
 {
 	return 0; // -ENOENT;
 }
 
-static unsigned int bb_t1_delay(gpib_board_t *board,  unsigned int nano_sec)
+static unsigned int bb_t1_delay(struct gpib_board *board,  unsigned int nano_sec)
 {
 	struct bb_priv *priv = board->private_data;
 
@@ -1025,11 +1025,11 @@ static unsigned int bb_t1_delay(gpib_board_t *board,  unsigned int nano_sec)
 	return priv->t1_delay;
 }
 
-static void bb_return_to_local(gpib_board_t *board)
+static void bb_return_to_local(struct gpib_board *board)
 {
 }
 
-static int bb_line_status(const gpib_board_t *board)
+static int bb_line_status(const struct gpib_board *board)
 {
 	int line_status = VALID_ALL;
 
@@ -1061,7 +1061,7 @@ static int bb_line_status(const gpib_board_t *board)
  *									   *
  ***************************************************************************/
 
-static int allocate_private(gpib_board_t *board)
+static int allocate_private(struct gpib_board *board)
 {
 	board->private_data = kzalloc(sizeof(struct bb_priv), GFP_KERNEL);
 	if (!board->private_data)
@@ -1069,13 +1069,13 @@ static int allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void free_private(gpib_board_t *board)
+static void free_private(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
 }
 
-static int bb_get_irq(gpib_board_t *board, char *name,
+static int bb_get_irq(struct gpib_board *board, char *name,
 		      struct gpio_desc *gpio, int *irq,
 		      irq_handler_t handler, irq_handler_t thread_fn, unsigned long flags)
 {
@@ -1097,7 +1097,7 @@ static int bb_get_irq(gpib_board_t *board, char *name,
 	return 0;
 }
 
-static void bb_free_irq(gpib_board_t *board, int *irq, char *name)
+static void bb_free_irq(struct gpib_board *board, int *irq, char *name)
 {
 	if (*irq) {
 		free_irq(*irq, board);
@@ -1118,7 +1118,7 @@ static void release_gpios(void)
 	}
 }
 
-static int allocate_gpios(gpib_board_t *board)
+static int allocate_gpios(struct gpib_board *board)
 {
 	int j, retval = 0;
 	bool error = false;
@@ -1176,7 +1176,7 @@ static int allocate_gpios(gpib_board_t *board)
 	return retval;
 }
 
-static void bb_detach(gpib_board_t *board)
+static void bb_detach(struct gpib_board *board)
 {
 	struct bb_priv *priv = board->private_data;
 
@@ -1206,7 +1206,7 @@ static void bb_detach(gpib_board_t *board)
 	free_private(board);
 }
 
-static int bb_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int bb_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct bb_priv *priv;
 	int retval = 0;
-- 
2.43.0


