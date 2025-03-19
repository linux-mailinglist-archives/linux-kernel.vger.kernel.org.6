Return-Path: <linux-kernel+bounces-568891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647DAA69BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8263B77C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2D0223320;
	Wed, 19 Mar 2025 22:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="YkNKSKLs"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E4221DA0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421599; cv=none; b=M7ivIVyQAxEyE7qWVODMQqIkIh8Ps9NhNu4KgRVFcit0Qe5VH0WRZSOdBgYHePBZreO0/h6L9ws1dE5g22IVTFLztPAhplz7IAOzkuhhn0dj9DhRcESPo3Z88DLAqXxeZnUWknExggSJZqEo61tYW7fizl4Yk64XWmJBQdgcrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421599; c=relaxed/simple;
	bh=e4dbAKaOnBk95nGbq3xaWlhEEnq7lytyehXJ34fFCcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikXxTtFmmNUwz3TR7O7ZfSUcnI3npACvoUlOBNuWB2jBMkGIa1ZtWS7muS4UOwBfg3fi8sbl2qMzY2VUPtHM9FQOauzR4+nsMZ39jZowU4Swtn1QLMNSN1HQn8CAk5Nw5xouJL5SWyZ1bvFh5NBXcxzx+Oqf13Ots8xYKls1M/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=YkNKSKLs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3015001f862so165205a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421597; x=1743026397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdrlZfOcjEPmyLhxrYOcoDg7rx+YwK3dt8M5HQJ7Vxc=;
        b=YkNKSKLs/cSIZrM28f6j9g7Q7v5h5xrlRpIleaZYXD+432dIaxyPLuhe5tNOWPOI6p
         4kYhrl9hFixLhYbJHMCrEHO8ulR/2aI5SNLzBH0Uzgdxm+PWPF58PzvyQuVKEfjspDHG
         LqoEPtsrKhokA0U66pRwnyAp8S74msS+DY2YCzW954TYMiC8maKHnZ5jyYgjauiJdtpf
         KrvhxTjDPvVj1sMJdmL/j5HC31H1wg414JPo5BsXDg4Vs3npxdq9x7nMdzDykqx5F25t
         3VPL4VMm8/S/6ODCxaP+g8SGpmav0ChYAYpJoS85rrCczK7z5vPgEMNc0xQ/ENPrqGUT
         /VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421597; x=1743026397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdrlZfOcjEPmyLhxrYOcoDg7rx+YwK3dt8M5HQJ7Vxc=;
        b=AThdIHTNgEN2EMbuCoJORKvzqM842aTBL8hWY8+bq3l3ldbutvWztQHGt4xPOYWpS6
         8YNHiWJ/M3i1Vq0TAWGnZQNMQHhiFO66+uIe/AhhQ6Sq1pfpOP7lXwowvx/+OugX66x/
         cvjJRUA2w73tBeY6NXpK3Bj64vLQAAl0AtYTPIkPT8jUd/EB7nlFHm9To8uSAEkWudQI
         0CFlx2IxKqIgEHzKGVuFa//R3N0Qe5GwSFnq2JYVj4zvHmqpCQCNJx/AiM1Q2fF0E5JV
         VqpKeZlgBM0htfYrkZAZK9T/Y86SLyugDRvu8UCuX5UqlcL6JL1yq8EaAOP0Bu3kxmwj
         lfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWphVN3YbRhJ2Y2bBXL5dlO/M53op6DsMlUKG0jm/2bg/BSxVKf/GnBm1NacQS/tgK9tD+V28AshOh6ocs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAW2tETJWWJj09OlzdLdAwl618SWdPVeu21M015HjKqM3TiUSR
	aGOdgytm3p446tGiQoX2lwvDMoZF52QxaQN0w7hotOLbghF4/Pqknsk7zub7YA==
X-Gm-Gg: ASbGnctmVbjQbm/1i+QXy1VP1gGRCy9egp8hNmzMmN5tCNt5GaDk6ZgvNh9FI0zXQdT
	i0sKD2EQZ6Lu9D+TsfHZLJN+0ke8Jk2p5YjEqPnMD9U30tMVqOlv1sPraPE5oQunHWZ+J9tl0Ch
	R0oFz6OuSl5RvaA+9MDDIi6IoyiVYdIGlH4UTO+VJsiVtpWkyKzYmHfZ5hwF1zVM8Z+fPf8/eur
	FZG2b/AeHy1OFUjNx/hgCm0iaKRJcbQ9TCV3qq4uJYeTJjyUK4ZMhD49VXr4cH+EEUHn8io105V
	dl3oDWYZj1tmCk9jMxTXTfInbCEQitqJ00lLNrsIUuqziqOLZKCNI41Iny3cLPMb4kRmeIJGqHC
	FN/E9RjyEcA==
X-Google-Smtp-Source: AGHT+IFqtfzZcIJzqrMS8fVLbpZe4AfElC5e1G6eMy+1t8WREOI4FS/mYUqR+pMxpIN+BBHuiCJhVg==
X-Received: by 2002:a17:90b:3c11:b0:2ff:5a9d:937f with SMTP id 98e67ed59e1d1-301be200718mr7480776a91.24.1742421596915;
        Wed, 19 Mar 2025 14:59:56 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf635929sm2426373a91.40.2025.03.19.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:56 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 16/20] staging: gpib: pc2: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:20 +0000
Message-ID: <20250319215924.19387-17-matchstick@neverthere.org>
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
 drivers/staging/gpib/pc2/pc2_gpib.c | 68 ++++++++++++++---------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 6711851301ec..d8e0733d8ab0 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -58,7 +58,7 @@ MODULE_DESCRIPTION("GPIB driver for PC2/PC2a and compatible devices");
 
 irqreturn_t pc2_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct pc2_priv *priv = board->private_data;
 	unsigned long flags;
 	irqreturn_t retval;
@@ -71,7 +71,7 @@ irqreturn_t pc2_interrupt(int irq, void *arg)
 
 irqreturn_t pc2a_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct pc2_priv *priv = board->private_data;
 	int status1, status2;
 	unsigned long flags;
@@ -90,7 +90,7 @@ irqreturn_t pc2a_interrupt(int irq, void *arg)
 }
 
 // wrappers for interface functions
-static int pc2_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
+static int pc2_read(struct gpib_board *board, uint8_t *buffer, size_t length, int *end,
 		    size_t *bytes_read)
 {
 	struct pc2_priv *priv = board->private_data;
@@ -98,7 +98,7 @@ static int pc2_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *en
 	return nec7210_read(board, &priv->nec7210_priv, buffer, length, end, bytes_read);
 }
 
-static int pc2_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
+static int pc2_write(struct gpib_board *board, uint8_t *buffer, size_t length, int send_eoi,
 		     size_t *bytes_written)
 {
 	struct pc2_priv *priv = board->private_data;
@@ -106,133 +106,133 @@ static int pc2_write(gpib_board_t *board, uint8_t *buffer, size_t length, int se
 	return nec7210_write(board, &priv->nec7210_priv, buffer, length, send_eoi, bytes_written);
 }
 
-static int pc2_command(gpib_board_t *board, uint8_t *buffer, size_t length, size_t *bytes_written)
+static int pc2_command(struct gpib_board *board, uint8_t *buffer, size_t length, size_t *bytes_written)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_command(board, &priv->nec7210_priv, buffer, length, bytes_written);
 }
 
-static int pc2_take_control(gpib_board_t *board, int synchronous)
+static int pc2_take_control(struct gpib_board *board, int synchronous)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_take_control(board, &priv->nec7210_priv, synchronous);
 }
 
-static int pc2_go_to_standby(gpib_board_t *board)
+static int pc2_go_to_standby(struct gpib_board *board)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void pc2_request_system_control(gpib_board_t *board, int request_control)
+static void pc2_request_system_control(struct gpib_board *board, int request_control)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
 }
 
-static void pc2_interface_clear(gpib_board_t *board, int assert)
+static void pc2_interface_clear(struct gpib_board *board, int assert)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	nec7210_interface_clear(board, &priv->nec7210_priv, assert);
 }
 
-static void pc2_remote_enable(gpib_board_t *board, int enable)
+static void pc2_remote_enable(struct gpib_board *board, int enable)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	nec7210_remote_enable(board, &priv->nec7210_priv, enable);
 }
 
-static int pc2_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int pc2_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_enable_eos(board, &priv->nec7210_priv, eos_byte, compare_8_bits);
 }
 
-static void pc2_disable_eos(gpib_board_t *board)
+static void pc2_disable_eos(struct gpib_board *board)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	nec7210_disable_eos(board, &priv->nec7210_priv);
 }
 
-static unsigned int pc2_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int pc2_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_update_status(board, &priv->nec7210_priv, clear_mask);
 }
 
-static int pc2_primary_address(gpib_board_t *board, unsigned int address)
+static int pc2_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_primary_address(board, &priv->nec7210_priv, address);
 }
 
-static int pc2_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int pc2_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_secondary_address(board, &priv->nec7210_priv, address, enable);
 }
 
-static int pc2_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int pc2_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_parallel_poll(board, &priv->nec7210_priv, result);
 }
 
-static void pc2_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+static void pc2_parallel_poll_configure(struct gpib_board *board, uint8_t config)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_configure(board, &priv->nec7210_priv, config);
 }
 
-static void pc2_parallel_poll_response(gpib_board_t *board, int ist)
+static void pc2_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_response(board, &priv->nec7210_priv, ist);
 }
 
-static void pc2_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void pc2_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	nec7210_serial_poll_response(board, &priv->nec7210_priv, status);
 }
 
-static uint8_t pc2_serial_poll_status(gpib_board_t *board)
+static uint8_t pc2_serial_poll_status(struct gpib_board *board)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static unsigned int pc2_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int pc2_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	return nec7210_t1_delay(board, &priv->nec7210_priv, nano_sec);
 }
 
-static void pc2_return_to_local(gpib_board_t *board)
+static void pc2_return_to_local(struct gpib_board *board)
 {
 	struct pc2_priv *priv = board->private_data;
 
 	nec7210_return_to_local(board, &priv->nec7210_priv);
 }
 
-static int allocate_private(gpib_board_t *board)
+static int allocate_private(struct gpib_board *board)
 {
 	struct pc2_priv *priv;
 
@@ -245,13 +245,13 @@ static int allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void free_private(gpib_board_t *board)
+static void free_private(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
 }
 
-static int pc2_generic_attach(gpib_board_t *board, const gpib_board_config_t *config,
+static int pc2_generic_attach(struct gpib_board *board, const gpib_board_config_t *config,
 			      enum nec7210_chipset chipset)
 {
 	struct pc2_priv *pc2_priv;
@@ -294,7 +294,7 @@ static int pc2_generic_attach(gpib_board_t *board, const gpib_board_config_t *co
 	return 0;
 }
 
-static int pc2_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int pc2_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	int isr_flags = 0;
 	struct pc2_priv *pc2_priv;
@@ -338,7 +338,7 @@ static int pc2_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	return 0;
 }
 
-static void pc2_detach(gpib_board_t *board)
+static void pc2_detach(struct gpib_board *board)
 {
 	struct pc2_priv *pc2_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
@@ -365,7 +365,7 @@ static void pc2_detach(gpib_board_t *board)
 	free_private(board);
 }
 
-static int pc2a_common_attach(gpib_board_t *board, const gpib_board_config_t *config,
+static int pc2a_common_attach(struct gpib_board *board, const gpib_board_config_t *config,
 			      unsigned int num_registers, enum nec7210_chipset chipset)
 {
 	unsigned int i, j;
@@ -459,22 +459,22 @@ static int pc2a_common_attach(gpib_board_t *board, const gpib_board_config_t *co
 	return 0;
 }
 
-static int pc2a_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int pc2a_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	return pc2a_common_attach(board, config, pc2a_iosize, NEC7210);
 }
 
-static int pc2a_cb7210_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int pc2a_cb7210_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	return pc2a_common_attach(board, config, pc2a_iosize, CB7210);
 }
 
-static int pc2_2a_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int pc2_2a_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	return pc2a_common_attach(board, config, pc2_2a_iosize, NAT4882);
 }
 
-static void pc2a_common_detach(gpib_board_t *board, unsigned int num_registers)
+static void pc2a_common_detach(struct gpib_board *board, unsigned int num_registers)
 {
 	int i;
 	struct pc2_priv *pc2_priv = board->private_data;
@@ -507,12 +507,12 @@ static void pc2a_common_detach(gpib_board_t *board, unsigned int num_registers)
 	free_private(board);
 }
 
-static void pc2a_detach(gpib_board_t *board)
+static void pc2a_detach(struct gpib_board *board)
 {
 	pc2a_common_detach(board, pc2a_iosize);
 }
 
-static void pc2_2a_detach(gpib_board_t *board)
+static void pc2_2a_detach(struct gpib_board *board)
 {
 	pc2a_common_detach(board, pc2_2a_iosize);
 }
-- 
2.43.0


