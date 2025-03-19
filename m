Return-Path: <linux-kernel+bounces-568878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEF9A69BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD90189323B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C021C9F5;
	Wed, 19 Mar 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="OQu/elGH"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065A21B9F1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421584; cv=none; b=QMWuJvDzavMdLMYutcLQUzv4eZhFtsyT5Bn4emAyB4YsAb7uuAx+Bun+gzbq7bKHkoOQQz8sj/9Fp1OfU5YaRXClupA9/m5i8U66jIO4pai6KuN7N1CIzGSei5dpJSNg/HPa3K5AmXmPFGAjWqG1BQlwZ1NbfwnMOrrgS++o/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421584; c=relaxed/simple;
	bh=nMiOYWnyWIgJqVZZLK8NhGgU5fP9ICLyNqQ9BS/rbug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5lWZnxxlyyCShCa6yJdGc/eoVxxAmfslJOyrlhac3U1dpmVi0PpA4wz/xoP8IyUnjK5c1SsSCi8F6VWkDKheEzjvQ78HjrprB12vHsK1wZj559CjHqeHu2n0lSZcxcHFa0HgbN2VL7+DX2QPMmyY9fHpEGbd0T5MwrnJVZGFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=OQu/elGH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223a7065ff8so1443235ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421582; x=1743026382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R74GxULIgBcQ77BKtt+ZheFRKnjYiWu/3C/3toyQPuY=;
        b=OQu/elGHyRzvfx+N7h7FGvO4rIcr2D8Q4JmY5HwgryG+E+Qu/azc63y2v52oSdTU+Y
         3SrcRFPAB1RHsoV06aw2oM4efpoq3zaB8O2SOeTc/gCHqSNQJzMEg4FNfCCFeYz2O3/4
         Oo6Q7MhjxfoJsO46hConhFDKBQqQKTUSzqKwXEa8zYlUr++ex6hni2wr1jHws8AsON/8
         LZtGb9wC1QvYh7P14SC8/vSplxyi86NX1jLc16gIWn7sSHOiKuQxmMjNXQeszvHDgA7s
         OmhnNFSyHnH5HDaaUjEoeWnE6d6QTSUbIhWTe1YS63uxb77kimIHXlmZXiNdpp8PtjwN
         OThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421582; x=1743026382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R74GxULIgBcQ77BKtt+ZheFRKnjYiWu/3C/3toyQPuY=;
        b=J87OML4T1JYhzOqVmz21bn5IS2CXAvNlq8qBmJIP+hmbrMS7xw9RAk8xU+aZ5YbPA6
         dPgI0bnC44C86aTA5xo95P6TqreKBy2rhr6tiNX319NDznWC42qMU2bBKE6CXDU4RMoN
         rjn8jE+MTV1VJNBS/lglMloZQTGNfHDbORlFTK9v1UPwSVOlLDuUpbbjReOO0oJIKdNo
         ELw4wl5vJyIbmCMcEjAlEGeaZlvLvm1jMw+FmD9RI8XfwZYF+4nnbF96kxXuVBcSGY61
         fKhTFqqXMFQLGICbOXTWZj26EUkkAeE7Nu9U45Cfn49deYPbZ0mbv3wLbWHAg1q1cIeK
         fM9g==
X-Forwarded-Encrypted: i=1; AJvYcCVUjnZmGj7FmePq9Yy1OvBOnCXiB6MtA6uW2rAvHfZpAlALP/r4cZ81IP5T5IbnMzNAWqhmCzI8AKvuKMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWR7cTWdtaZ+sYHif2XKhpT9KoOPL8m9YExmRPYw4q51k77NgE
	cCounVaDhbwtp2BkzdK4knhGtQ+2DtjaPYsbVkowLWqSkL6V2yBW+PrQSW8Wrri+CS51HT/jbU4
	=
X-Gm-Gg: ASbGncsSSyZW2wWAsFJ2FunGfEtOXwYjMNsxBbOBIXZuHM9C5wjzVHzs3t9gGuAbE5Y
	ODTnRjU16EwFmM3Jf8scSETdse4P5kQpCKKH4eLOeAjBTGATJZvwITqHabM3fhmLjKRpGMA9o1B
	ELv0TIedisv2rYqmJzCGmxsc8MjqOKX9/WqhiZFkLSriM7omaeToLc/kcnxyp76VvxseQEkQKEe
	j9gvDSuX2QKI+jL8LjxzqArFCui8TG1qkAdN5bAMFECjXCDNRsCTvpXi4nB8D6yaOZHX4WonvQW
	N+04xShm8YFzL0bmMH/H+ZtZ+S1BxfjKuWcCYF9kVejEPekYR/u+mGEqDx7h3tGN9gVLUB2HFrJ
	Mh25mrQHyxQ==
X-Google-Smtp-Source: AGHT+IEHKB83JWORDLqVWnA69Hqlc5qiM+x12zTZemAeViUz709pMq725MoDRiZWObzTMPH0TeWFyA==
X-Received: by 2002:a05:6a20:12d5:b0:1f5:8678:183d with SMTP id adf61e73a8af0-1fbeba8fdfcmr7554267637.14.1742421581747;
        Wed, 19 Mar 2025 14:59:41 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e02esm12576276b3a.95.2025.03.19.14.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:41 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 04/20] staging: gpib: cb7210: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:08 +0000
Message-ID: <20250319215924.19387-5-matchstick@neverthere.org>
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
 drivers/staging/gpib/cb7210/cb7210.c | 107 ++++++++++++++-------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 808e0a71dfd6..621aa8fda913 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -27,7 +27,7 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB driver Measurement Computing boards using cb7210.2 and cbi488.2");
 
-static int cb7210_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int cb7210_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 		       int *end, size_t *bytes_read);
 
 	static inline int have_fifo_word(const struct cb7210_priv *cb_priv)
@@ -40,7 +40,7 @@ static int cb7210_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 		return 0;
 }
 
-static inline void input_fifo_enable(gpib_board_t *board, int enable)
+static inline void input_fifo_enable(struct gpib_board *board, int enable)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &cb_priv->nec7210_priv;
@@ -76,7 +76,7 @@ static inline void input_fifo_enable(gpib_board_t *board, int enable)
 	spin_unlock_irqrestore(&board->spinlock, flags);
 }
 
-static int fifo_read(gpib_board_t *board, struct cb7210_priv *cb_priv, uint8_t *buffer,
+static int fifo_read(struct gpib_board *board, struct cb7210_priv *cb_priv, uint8_t *buffer,
 		     size_t length, int *end, size_t *bytes_read)
 {
 	ssize_t retval = 0;
@@ -170,7 +170,7 @@ static int fifo_read(gpib_board_t *board, struct cb7210_priv *cb_priv, uint8_t *
 	return retval;
 }
 
-static int cb7210_accel_read(gpib_board_t *board, uint8_t *buffer,
+static int cb7210_accel_read(struct gpib_board *board, uint8_t *buffer,
 			     size_t length, int *end, size_t *bytes_read)
 {
 	ssize_t retval;
@@ -229,7 +229,7 @@ static int output_fifo_empty(const struct cb7210_priv *cb_priv)
 		return 0;
 }
 
-static inline void output_fifo_enable(gpib_board_t *board, int enable)
+static inline void output_fifo_enable(struct gpib_board *board, int enable)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &cb_priv->nec7210_priv;
@@ -264,7 +264,8 @@ static inline void output_fifo_enable(gpib_board_t *board, int enable)
 	spin_unlock_irqrestore(&board->spinlock, flags);
 }
 
-static int fifo_write(gpib_board_t *board, uint8_t *buffer, size_t length, size_t *bytes_written)
+static int fifo_write(struct gpib_board *board, uint8_t *buffer, size_t length,
+		      size_t *bytes_written)
 {
 	size_t count = 0;
 	ssize_t retval = 0;
@@ -349,8 +350,8 @@ static int fifo_write(gpib_board_t *board, uint8_t *buffer, size_t length, size_
 	return retval;
 }
 
-static int cb7210_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
-			      size_t *bytes_written)
+static int cb7210_accel_write(struct gpib_board *board, uint8_t *buffer,
+			      size_t length, int send_eoi, size_t *bytes_written)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &cb_priv->nec7210_priv;
@@ -377,7 +378,7 @@ static int cb7210_accel_write(gpib_board_t *board, uint8_t *buffer, size_t lengt
 	return retval;
 }
 
-static int cb7210_line_status(const gpib_board_t *board)
+static int cb7210_line_status(const struct gpib_board *board)
 {
 	int status = VALID_ALL;
 	int bsr_bits;
@@ -407,7 +408,7 @@ static int cb7210_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int cb7210_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int cb7210_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &cb_priv->nec7210_priv;
@@ -424,7 +425,7 @@ static unsigned int cb7210_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 	return retval;
 }
 
-static irqreturn_t cb7210_locked_internal_interrupt(gpib_board_t *board);
+static irqreturn_t cb7210_locked_internal_interrupt(struct gpib_board *board);
 
 /*
  * GPIB interrupt service routines
@@ -433,7 +434,7 @@ static irqreturn_t cb7210_locked_internal_interrupt(gpib_board_t *board);
 static irqreturn_t cb_pci_interrupt(int irq, void *arg)
 {
 	int bits;
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct cb7210_priv *priv = board->private_data;
 
 	// first task check if this is really our interrupt in a shared irq environment
@@ -462,7 +463,7 @@ static irqreturn_t cb_pci_interrupt(int irq, void *arg)
 	return cb7210_locked_internal_interrupt(arg);
 }
 
-static irqreturn_t cb7210_internal_interrupt(gpib_board_t *board)
+static irqreturn_t cb7210_internal_interrupt(struct gpib_board *board)
 {
 	int hs_status, status1, status2;
 	struct cb7210_priv *priv = board->private_data;
@@ -516,7 +517,7 @@ static irqreturn_t cb7210_internal_interrupt(gpib_board_t *board)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t cb7210_locked_internal_interrupt(gpib_board_t *board)
+static irqreturn_t cb7210_locked_internal_interrupt(struct gpib_board *board)
 {
 	unsigned long flags;
 	irqreturn_t retval;
@@ -532,14 +533,14 @@ static irqreturn_t cb7210_interrupt(int irq, void *arg)
 	return cb7210_internal_interrupt(arg);
 }
 
-static int cb_pci_attach(gpib_board_t *board, const gpib_board_config_t *config);
-static int cb_isa_attach(gpib_board_t *board, const gpib_board_config_t *config);
+static int cb_pci_attach(struct gpib_board *board, const gpib_board_config_t *config);
+static int cb_isa_attach(struct gpib_board *board, const gpib_board_config_t *config);
 
-static void cb_pci_detach(gpib_board_t *board);
-static void cb_isa_detach(gpib_board_t *board);
+static void cb_pci_detach(struct gpib_board *board);
+static void cb_isa_detach(struct gpib_board *board);
 
 // wrappers for interface functions
-static int cb7210_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int cb7210_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 		       int *end, size_t *bytes_read)
 {
 	struct cb7210_priv *priv = board->private_data;
@@ -547,7 +548,7 @@ static int cb7210_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return nec7210_read(board, &priv->nec7210_priv, buffer, length, end, bytes_read);
 }
 
-static int cb7210_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int cb7210_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 			int send_eoi, size_t *bytes_written)
 {
 	struct cb7210_priv *priv = board->private_data;
@@ -555,7 +556,7 @@ static int cb7210_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return nec7210_write(board, &priv->nec7210_priv, buffer, length, send_eoi, bytes_written);
 }
 
-static int cb7210_command(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int cb7210_command(struct gpib_board *board, uint8_t *buffer, size_t length,
 			  size_t *bytes_written)
 {
 	struct cb7210_priv *priv = board->private_data;
@@ -563,21 +564,21 @@ static int cb7210_command(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return nec7210_command(board, &priv->nec7210_priv, buffer, length, bytes_written);
 }
 
-static int cb7210_take_control(gpib_board_t *board, int synchronous)
+static int cb7210_take_control(struct gpib_board *board, int synchronous)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	return nec7210_take_control(board, &priv->nec7210_priv, synchronous);
 }
 
-static int cb7210_go_to_standby(gpib_board_t *board)
+static int cb7210_go_to_standby(struct gpib_board *board)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void cb7210_request_system_control(gpib_board_t *board, int request_control)
+static void cb7210_request_system_control(struct gpib_board *board, int request_control)
 {
 	struct cb7210_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -591,91 +592,91 @@ static void cb7210_request_system_control(gpib_board_t *board, int request_contr
 	nec7210_request_system_control(board, nec_priv, request_control);
 }
 
-static void cb7210_interface_clear(gpib_board_t *board, int assert)
+static void cb7210_interface_clear(struct gpib_board *board, int assert)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	nec7210_interface_clear(board, &priv->nec7210_priv, assert);
 }
 
-static void cb7210_remote_enable(gpib_board_t *board, int enable)
+static void cb7210_remote_enable(struct gpib_board *board, int enable)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	nec7210_remote_enable(board, &priv->nec7210_priv, enable);
 }
 
-static int cb7210_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int cb7210_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	return nec7210_enable_eos(board, &priv->nec7210_priv, eos_byte, compare_8_bits);
 }
 
-static void cb7210_disable_eos(gpib_board_t *board)
+static void cb7210_disable_eos(struct gpib_board *board)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	nec7210_disable_eos(board, &priv->nec7210_priv);
 }
 
-static unsigned int cb7210_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int cb7210_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	return nec7210_update_status(board, &priv->nec7210_priv, clear_mask);
 }
 
-static int cb7210_primary_address(gpib_board_t *board, unsigned int address)
+static int cb7210_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	return nec7210_primary_address(board, &priv->nec7210_priv, address);
 }
 
-static int cb7210_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int cb7210_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	return nec7210_secondary_address(board, &priv->nec7210_priv, address, enable);
 }
 
-static int cb7210_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int cb7210_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	return nec7210_parallel_poll(board, &priv->nec7210_priv, result);
 }
 
-static void cb7210_parallel_poll_configure(gpib_board_t *board, uint8_t configuration)
+static void cb7210_parallel_poll_configure(struct gpib_board *board, uint8_t configuration)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_configure(board, &priv->nec7210_priv, configuration);
 }
 
-static void cb7210_parallel_poll_response(gpib_board_t *board, int ist)
+static void cb7210_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_response(board, &priv->nec7210_priv, ist);
 }
 
-static void cb7210_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void cb7210_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	nec7210_serial_poll_response(board, &priv->nec7210_priv, status);
 }
 
-static uint8_t cb7210_serial_poll_status(gpib_board_t *board)
+static uint8_t cb7210_serial_poll_status(struct gpib_board *board)
 {
 	struct cb7210_priv *priv = board->private_data;
 
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static void cb7210_return_to_local(gpib_board_t *board)
+static void cb7210_return_to_local(struct gpib_board *board)
 {
 	struct cb7210_priv *priv = board->private_data;
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
@@ -851,7 +852,7 @@ static gpib_interface_t cb_isa_accel_interface = {
 	.return_to_local = cb7210_return_to_local,
 };
 
-static int cb7210_allocate_private(gpib_board_t *board)
+static int cb7210_allocate_private(struct gpib_board *board)
 {
 	struct cb7210_priv *priv;
 
@@ -864,14 +865,14 @@ static int cb7210_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void cb7210_generic_detach(gpib_board_t *board)
+static void cb7210_generic_detach(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
 }
 
 // generic part of attach functions shared by all cb7210 boards
-static int cb7210_generic_attach(gpib_board_t *board)
+static int cb7210_generic_attach(struct gpib_board *board)
 {
 	struct cb7210_priv *cb_priv;
 	struct nec7210_priv *nec_priv;
@@ -889,7 +890,7 @@ static int cb7210_generic_attach(gpib_board_t *board)
 	return 0;
 }
 
-static int cb7210_init(struct cb7210_priv *cb_priv, gpib_board_t *board)
+static int cb7210_init(struct cb7210_priv *cb_priv, struct gpib_board *board)
 {
 	struct nec7210_priv *nec_priv = &cb_priv->nec7210_priv;
 
@@ -925,7 +926,7 @@ static int cb7210_init(struct cb7210_priv *cb_priv, gpib_board_t *board)
 	return 0;
 }
 
-static int cb_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int cb_pci_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct cb7210_priv *cb_priv;
 	struct nec7210_priv *nec_priv;
@@ -1007,7 +1008,7 @@ static int cb_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	return cb7210_init(cb_priv, board);
 }
 
-static void cb_pci_detach(gpib_board_t *board)
+static void cb_pci_detach(struct gpib_board *board)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
@@ -1030,7 +1031,7 @@ static void cb_pci_detach(gpib_board_t *board)
 	cb7210_generic_detach(board);
 }
 
-static int cb_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int cb_isa_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	int isr_flags = 0;
 	struct cb7210_priv *cb_priv;
@@ -1066,7 +1067,7 @@ static int cb_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	return cb7210_init(cb_priv, board);
 }
 
-static void cb_isa_detach(gpib_board_t *board)
+static void cb_isa_detach(struct gpib_board *board)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
@@ -1132,8 +1133,8 @@ static struct pci_driver cb7210_pci_driver = {
 
 static int cb_gpib_config(struct pcmcia_device	*link);
 static void cb_gpib_release(struct pcmcia_device  *link);
-static int cb_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config);
-static void cb_pcmcia_detach(gpib_board_t *board);
+static int cb_pcmcia_attach(struct gpib_board *board, const gpib_board_config_t *config);
+static void cb_pcmcia_detach(struct gpib_board *board);
 
 /*
  *  A linked list of "instances" of the gpib device.  Each actual
@@ -1166,7 +1167,7 @@ static	struct pcmcia_device  *curr_dev;
 
 struct local_info {
 	struct pcmcia_device	*p_dev;
-	gpib_board_t		*dev;
+	struct gpib_board		*dev;
 };
 
 /*
@@ -1222,7 +1223,7 @@ static int cb_gpib_probe(struct pcmcia_device *link)
 static void cb_gpib_remove(struct pcmcia_device *link)
 {
 	struct local_info *info = link->priv;
-	//struct gpib_board_t *dev = info->dev;
+	//struct struct gpib_board *dev = info->dev;
 
 	if (info->dev)
 		cb_pcmcia_detach(info->dev);
@@ -1287,7 +1288,7 @@ static void cb_gpib_release(struct pcmcia_device *link)
 static int cb_gpib_suspend(struct pcmcia_device *link)
 {
 	//struct local_info *info = link->priv;
-	//struct gpib_board_t *dev = info->dev;
+	//struct struct gpib_board *dev = info->dev;
 
 	if (link->open)
 		dev_warn(&link->dev, "Device still open\n");
@@ -1299,7 +1300,7 @@ static int cb_gpib_suspend(struct pcmcia_device *link)
 static int cb_gpib_resume(struct pcmcia_device *link)
 {
 	//struct local_info *info = link->priv;
-	//struct gpib_board_t *dev = info->dev;
+	//struct struct gpib_board *dev = info->dev;
 
 	/*if (link->open) {
 	 *	ni_gpib_probe(dev);	/ really?
@@ -1416,7 +1417,7 @@ static gpib_interface_t cb_pcmcia_accel_interface = {
 	.return_to_local = cb7210_return_to_local,
 };
 
-static int cb_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int cb_pcmcia_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct cb7210_priv *cb_priv;
 	struct nec7210_priv *nec_priv;
@@ -1452,7 +1453,7 @@ static int cb_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *conf
 	return cb7210_init(cb_priv, board);
 }
 
-static void cb_pcmcia_detach(gpib_board_t *board)
+static void cb_pcmcia_detach(struct gpib_board *board)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
-- 
2.43.0


