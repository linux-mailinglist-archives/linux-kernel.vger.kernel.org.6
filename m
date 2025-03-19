Return-Path: <linux-kernel+bounces-568885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A9DA69BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663A619C4C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8BA221555;
	Wed, 19 Mar 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="RGPUBWRB"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3421D3FB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421593; cv=none; b=lwGImBgpRPYe4kUu43U+aZxxQTglM9chmq/cktNAp4snsscam72HAI98RrHJqGhfsicVEnIxpzm2WGwAisEurGITuVz+bpH24vjFtFTX4vW53P/T8BWild+NBQCUDyFUSCl6E32+u8eTHlkgdKpTwb1iBTYP1x7BJ/DK/yKhaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421593; c=relaxed/simple;
	bh=5g6Sf9NfdjsJXmBKh3KyKHB2SZ0lFQ4s2X27bBr8Nf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ73fxKNj5/rEoINgRWrnFJ0Ze4xJT7zXkEVZBDsragMAmJbhitozgk6GxbV81gdb6JOZbcJMRZ8i/2cBqZde/jPUYFTRQJlau8NYrrV72hxqGlgfpFoMv0+CHOtHLVCeoCaZLsMVMvXr/ZREr1Yrw0nLiCugmYvE//g5tSydP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=RGPUBWRB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224100e9a5cso813635ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421591; x=1743026391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCKQI0r92oVQIbs5KyOZNss6g7qyyut7zIXJ7n3pDuY=;
        b=RGPUBWRBEm16GSUokoJPv3SpdhwFenOGzeUntjA2ed+CAq5Toyn6RNhHgV+ixkrSRX
         0ot2wykU2G/1jqRZczO+aLFk182geMm5g+zf6w3MxITBQjGkENL7yM7+fLNL2Ff4ZNLe
         zcACLTFnzT2vDARi0fuAMc66yhlYMpPxzvJ/m3IPRv0l8tsgwFMzlx07aXQt798/mMAp
         gWWN0uQ0C+NZiDJoNrjPNqAj4ugGvr8rxGgZyjtpw2L+yC0iS0u9qVAMxMor8rHHjkQn
         QcPupmgD0biyDhs5CrNbRQMCCq8LRjMbLx/PVCtb/1pZc7ByclU9xTymnBigzFrj6AWe
         tmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421591; x=1743026391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCKQI0r92oVQIbs5KyOZNss6g7qyyut7zIXJ7n3pDuY=;
        b=u6zHRc9t7A7Ls+9OkwCe+lgtKJpM2TxNzcH5pnjeZLYW3sb0f/WGLCBFomMxk6IR74
         bRE23Dj9qNj6/rE3k20AOrFYiwDd7QLZGKyQL62kQcrLH1TfDB9nXCDoFzAeaj63Pd3i
         WrP3DD1D3yV5Xwu+cEha7ylQOFLNDqy0VFUHjqjRHnzcGq7+Oh/q/ZIxb55BbhQK1E3V
         PV12FSmiNYLibxDnONcBsT6+dCQlcEbbSqTU/rjGPT9Mx6ei3RC9BIAKYAzmTL0ERnSz
         sd8Lktj+g/+1du4mAgxPdaBseXvHaM2mUtyCSSrU9/pzQ2PYh/wLGGlCkQwNxcjvKMj9
         uMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqcruOI/g+9yNXglD0kjpQKRoMc5OHQOCQy3FYz8XxE0xYIMgeRIVSR+VfbfBx0CkhuQwFi5uwzgphivI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFuwz2QEgNxccajMn4bCwOsfBwIWJecUQhDJ0Fb35qI0d2Jd2
	nO4ZOvd4xpaTB8+k8Kr3IO8RGuRFmFpTx7rKjENXV95jVbQLakTqpjEC8MalwQ==
X-Gm-Gg: ASbGnctR9Z1s9KWPeZJOCZYvzKDR7JMBj9xjERJXbWeuTzFibpXoFYNQNAKH2YccSbs
	fIZKlWyL2P9fJ0+4pnwMmGC8EbppGvZLc+Y9Z8qhPyM7E1AVJZ5Gr5grzdMD8Je+WWzOk5e1WhH
	CRfE4eel6mC5Wtp0IiH1s9N19LlTGM9Ay0Fj5Z/zUlD47qTAZ2y4+Jm5zUWwIUInTbKUtuTHYwe
	2SDDmuwS7NrcCgPHKtCgPVJJXOrhqvMibHGChd9usxme1QM01e012RmMmy4ftoTMOkzKUYg6c9v
	LkW6EtAGja1utPQUnDpYu6yfwK//iJBv6S8El893wLJ242kNPRc+RO/dYbmXCUx13byQ0ZpT9MK
	HdXKXGSSo0A==
X-Google-Smtp-Source: AGHT+IFTiK8x2fcvrZXLg62+gdhgLJz5U20mtxdUaGkDEbQpSHldyrbVZlFFWhyEut4dlmT+Y/VOWw==
X-Received: by 2002:a17:902:fc4e:b0:223:f9a4:3f9c with SMTP id d9443c01a7336-2265ed68d2emr13999275ad.9.1742421590710;
        Wed, 19 Mar 2025 14:59:50 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbcdd2sm120315285ad.172.2025.03.19.14.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:50 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 11/20] staging: gpib: hp_82341: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:15 +0000
Message-ID: <20250319215924.19387-12-matchstick@neverthere.org>
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
 drivers/staging/gpib/hp_82341/hp_82341.c | 68 ++++++++++++------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index b5d79ae519e7..5d76d01f6b32 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -22,14 +22,14 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB driver for hp 82341a/b/c/d boards");
 
-static unsigned short read_and_clear_event_status(gpib_board_t *board);
+static unsigned short read_and_clear_event_status(struct gpib_board *board);
 static void set_transfer_counter(struct hp_82341_priv *hp_priv, int count);
 static int read_transfer_counter(struct hp_82341_priv *hp_priv);
-static int hp_82341_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
+static int hp_82341_write(struct gpib_board *board, uint8_t *buffer, size_t length, int send_eoi,
 			  size_t *bytes_written);
 static irqreturn_t hp_82341_interrupt(int irq, void *arg);
 
-static int hp_82341_accel_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
+static int hp_82341_accel_read(struct gpib_board *board, uint8_t *buffer, size_t length, int *end,
 			       size_t *bytes_read)
 {
 	struct hp_82341_priv *hp_priv = board->private_data;
@@ -147,7 +147,7 @@ static int hp_82341_accel_read(gpib_board_t *board, uint8_t *buffer, size_t leng
 	return 0;
 }
 
-static int restart_write_fifo(gpib_board_t *board, struct hp_82341_priv *hp_priv)
+static int restart_write_fifo(struct gpib_board *board, struct hp_82341_priv *hp_priv)
 {
 	struct tms9914_priv *tms_priv = &hp_priv->tms9914_priv;
 
@@ -172,7 +172,7 @@ static int restart_write_fifo(gpib_board_t *board, struct hp_82341_priv *hp_priv
 	return 0;
 }
 
-static int hp_82341_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int hp_82341_accel_write(struct gpib_board *board, uint8_t *buffer, size_t length,
 				int send_eoi, size_t *bytes_written)
 {
 	struct hp_82341_priv *hp_priv = board->private_data;
@@ -250,12 +250,12 @@ static int hp_82341_accel_write(gpib_board_t *board, uint8_t *buffer, size_t len
 	return 0;
 }
 
-static int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *config);
+static int hp_82341_attach(struct gpib_board *board, const gpib_board_config_t *config);
 
-static void hp_82341_detach(gpib_board_t *board);
+static void hp_82341_detach(struct gpib_board *board);
 
 // wrappers for interface functions
-static int hp_82341_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
+static int hp_82341_read(struct gpib_board *board, uint8_t *buffer, size_t length, int *end,
 			 size_t *bytes_read)
 {
 	struct hp_82341_priv *priv = board->private_data;
@@ -263,7 +263,7 @@ static int hp_82341_read(gpib_board_t *board, uint8_t *buffer, size_t length, in
 	return tms9914_read(board, &priv->tms9914_priv, buffer, length, end, bytes_read);
 }
 
-static int hp_82341_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
+static int hp_82341_write(struct gpib_board *board, uint8_t *buffer, size_t length, int send_eoi,
 			  size_t *bytes_written)
 {
 	struct hp_82341_priv *priv = board->private_data;
@@ -271,7 +271,7 @@ static int hp_82341_write(gpib_board_t *board, uint8_t *buffer, size_t length, i
 	return tms9914_write(board, &priv->tms9914_priv, buffer, length, send_eoi, bytes_written);
 }
 
-static int hp_82341_command(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int hp_82341_command(struct gpib_board *board, uint8_t *buffer, size_t length,
 			    size_t *bytes_written)
 {
 	struct hp_82341_priv *priv = board->private_data;
@@ -279,21 +279,21 @@ static int hp_82341_command(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return tms9914_command(board, &priv->tms9914_priv, buffer, length, bytes_written);
 }
 
-static int hp_82341_take_control(gpib_board_t *board, int synchronous)
+static int hp_82341_take_control(struct gpib_board *board, int synchronous)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_take_control(board, &priv->tms9914_priv, synchronous);
 }
 
-static int hp_82341_go_to_standby(gpib_board_t *board)
+static int hp_82341_go_to_standby(struct gpib_board *board)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_go_to_standby(board, &priv->tms9914_priv);
 }
 
-static void hp_82341_request_system_control(gpib_board_t *board, int request_control)
+static void hp_82341_request_system_control(struct gpib_board *board, int request_control)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
@@ -305,105 +305,105 @@ static void hp_82341_request_system_control(gpib_board_t *board, int request_con
 	tms9914_request_system_control(board, &priv->tms9914_priv, request_control);
 }
 
-static void hp_82341_interface_clear(gpib_board_t *board, int assert)
+static void hp_82341_interface_clear(struct gpib_board *board, int assert)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	tms9914_interface_clear(board, &priv->tms9914_priv, assert);
 }
 
-static void hp_82341_remote_enable(gpib_board_t *board, int enable)
+static void hp_82341_remote_enable(struct gpib_board *board, int enable)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	tms9914_remote_enable(board, &priv->tms9914_priv, enable);
 }
 
-static int hp_82341_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int hp_82341_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_enable_eos(board, &priv->tms9914_priv, eos_byte, compare_8_bits);
 }
 
-static void hp_82341_disable_eos(gpib_board_t *board)
+static void hp_82341_disable_eos(struct gpib_board *board)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	tms9914_disable_eos(board, &priv->tms9914_priv);
 }
 
-static unsigned int hp_82341_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int hp_82341_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_update_status(board, &priv->tms9914_priv, clear_mask);
 }
 
-static int hp_82341_primary_address(gpib_board_t *board, unsigned int address)
+static int hp_82341_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_primary_address(board, &priv->tms9914_priv, address);
 }
 
-static int hp_82341_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int hp_82341_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_secondary_address(board, &priv->tms9914_priv, address, enable);
 }
 
-static int hp_82341_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int hp_82341_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_parallel_poll(board, &priv->tms9914_priv, result);
 }
 
-static void hp_82341_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+static void hp_82341_parallel_poll_configure(struct gpib_board *board, uint8_t config)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	tms9914_parallel_poll_configure(board, &priv->tms9914_priv, config);
 }
 
-static void hp_82341_parallel_poll_response(gpib_board_t *board, int ist)
+static void hp_82341_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	tms9914_parallel_poll_response(board, &priv->tms9914_priv, ist);
 }
 
-static void hp_82341_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void hp_82341_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	tms9914_serial_poll_response(board, &priv->tms9914_priv, status);
 }
 
-static uint8_t hp_82341_serial_poll_status(gpib_board_t *board)
+static uint8_t hp_82341_serial_poll_status(struct gpib_board *board)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_serial_poll_status(board, &priv->tms9914_priv);
 }
 
-static int hp_82341_line_status(const gpib_board_t *board)
+static int hp_82341_line_status(const struct gpib_board *board)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int hp_82341_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int hp_82341_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
 	return tms9914_t1_delay(board, &priv->tms9914_priv, nano_sec);
 }
 
-static void hp_82341_return_to_local(gpib_board_t *board)
+static void hp_82341_return_to_local(struct gpib_board *board)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
@@ -465,7 +465,7 @@ static gpib_interface_t hp_82341_interface = {
 	.return_to_local = hp_82341_return_to_local,
 };
 
-static int hp_82341_allocate_private(gpib_board_t *board)
+static int hp_82341_allocate_private(struct gpib_board *board)
 {
 	board->private_data = kzalloc(sizeof(struct hp_82341_priv), GFP_KERNEL);
 	if (!board->private_data)
@@ -473,7 +473,7 @@ static int hp_82341_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void hp_82341_free_private(gpib_board_t *board)
+static void hp_82341_free_private(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
@@ -686,7 +686,7 @@ static int clear_xilinx(struct hp_82341_priv *hp_priv)
 	return 0;
 }
 
-static int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int hp_82341_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct hp_82341_priv *hp_priv;
 	struct tms9914_priv *tms_priv;
@@ -778,7 +778,7 @@ static int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *confi
 	return 0;
 }
 
-static void hp_82341_detach(gpib_board_t *board)
+static void hp_82341_detach(struct gpib_board *board)
 {
 	struct hp_82341_priv *hp_priv = board->private_data;
 	struct tms9914_priv *tms_priv;
@@ -844,7 +844,7 @@ module_exit(hp_82341_exit_module);
 /*
  * GPIB interrupt service routines
  */
-static unsigned short read_and_clear_event_status(gpib_board_t *board)
+static unsigned short read_and_clear_event_status(struct gpib_board *board)
 {
 	struct hp_82341_priv *hp_priv = board->private_data;
 	unsigned long flags;
@@ -860,7 +860,7 @@ static unsigned short read_and_clear_event_status(gpib_board_t *board)
 static irqreturn_t hp_82341_interrupt(int irq, void *arg)
 {
 	int status1, status2;
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct hp_82341_priv *hp_priv = board->private_data;
 	struct tms9914_priv *tms_priv = &hp_priv->tms9914_priv;
 	unsigned long flags;
-- 
2.43.0


