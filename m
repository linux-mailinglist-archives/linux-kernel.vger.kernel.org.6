Return-Path: <linux-kernel+bounces-568879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780EDA69BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C0B7AA58E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B2621CA05;
	Wed, 19 Mar 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="kJJFXC1N"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF9210192
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421585; cv=none; b=k0U2BrNYkN56SE77Lo0GAFZ41Wmj8NkcQyLX+gQLyQfTk6S+8mIQ282MKl/eSbzOg+kuTbjfJMN4I+Uat8O6Lt27WTa21ouQbue9m0cEsePULf+kS3qrWxrCWEFgRXSqOaaeAWYMWhQpfKvqsSDnOlNGUMBnGkvxsqU6IthtNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421585; c=relaxed/simple;
	bh=vD6quqeCzKlpnY7dOUwCk16YlEJO6p4KoywYWJNFZPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkCHgiyksygHyREt+i4cKoQnn+lRQl1k56qh1MR6Lybjk0st1bYCw1PlGkga55wdD/fJ/N6Jcye5agfedhTYM7XXdfwixOnLfQ7HnaBXPjzcXm1vT4f37G7C26ovDddUpL0n6vZCDAi/viP0DwkwnvTLfI6HwE8NoHqYNi8wcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=kJJFXC1N; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c915749so464195ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421583; x=1743026383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUNOx6AMS3SHRYHpYYpQh3DOz0o7uDzbGPhBpeav/x8=;
        b=kJJFXC1N7W4C1mSK1mIiWQUhaGKpBfax3oGSzac4U6DFzUv5hDP9sSPdPmOEyKY32j
         Xq6Rhgd+wupkrFWWfVQPZ5cAg0Lp3uRZYMBD0/fVVvznsfcdfO9ytLNCCqayB0A63EO4
         66f3ERXBrzPeev9qcgMcMsggI1i10+TzqlxT/oYHSzVA+vq7jhktsRsa0zd2PuiMvKgc
         60mETw+v7belj8fCsUtxwK0PtmF893FH9RbQUAS0UMuMCw53qhP2ORvgLcH3lwwatGtu
         flITtbtCO0RCJ+RX6mN3KW1uG4kDVXIXFGDZfSwKbTc7U4s3P4PBXGPWt+AGiy8GN1ax
         u/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421583; x=1743026383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUNOx6AMS3SHRYHpYYpQh3DOz0o7uDzbGPhBpeav/x8=;
        b=F4zGrclKyx+ivAc/SnsOEfPfuTbw5BNQdni234G2l0Mpal05k7sa/4KKEpcY9gFtWl
         TOHwVsFLV8zCFx0WzTJuLFSQQjR5+giYCG1MJtC7npUjN7B+0q/RKwie+hD/4GChWLxL
         J7PncOxsTCIfF9VuAwyWh2cXAVQ45TruAPwmuZkYpMndIVe4Fy7kYZIMVEFY9KPgDU7B
         z/xTPDE0LJpxpJIGGfY2464IpXGUJe+LGJJPa2/y0w/TO94ZL9BMOwAH2wLOobYRNQWb
         M9aIlF0+28TpCJAX0qFPzSZYydcr2BfpFcsR8Vy29O2A02Nvx6JZlGw8dcSmcHNi8nOe
         8Rsg==
X-Forwarded-Encrypted: i=1; AJvYcCV3NacHWoSZgF7LcpuXVj2ygbXMO7YZDBeCznHUu8xX+IT4vZAismbnMG6ngPjvMvV6id/t2VR77/PGJZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YywL7yB8JyNjjJ03bcMEzJ0rcHzJvljhsPvLZ2KDdWH+pnflFGD
	1aBG7LgC5pgb6ADtpC1yfsygZaNTD0cxNDg2qeWHxwldj6T9WZkg+dIoK9Q5QQ==
X-Gm-Gg: ASbGnctjRZ3phMB3xebdRPGtGPclJ6XoqxrFHu/+DTvp7p30D6bWfytyPI8a3KgVXIf
	b4smCLdbqrZ3w58MLYNf80RKJSvziXEKZkAr1a5ZH9/nyGpDCYl9+kMllba7gOZhlWG8hrjh76P
	IoRNIH7wNTJPNxW9RA/TxtxoDqv7mntcQN2ZRyBTcPRqhXV4QyYibuR6+kpTw99hfHCQJWDMMoj
	AckIeVVHFWCbuQNfK7qttqhdgnYf0XJyw/QOY0JosC0iharKFp9tbWdn8pl+kz5z/E7Z2JNgK6r
	8Nii+LSZh3UheExo95YmUpcoNgBgOqDHFuObzlUBQu1EDvM3tMSxWQQCERb6BiPVxVnoU7dXhCZ
	VPF0qhptr+g==
X-Google-Smtp-Source: AGHT+IHLf1ezARTJkSh0ZQFiWLFXkKppFFH7GG+XwSuM6etYQCdBrwI9LnCcqVJt1FzhpXaNPQKvbQ==
X-Received: by 2002:a17:902:e5ce:b0:224:23ab:b88b with SMTP id d9443c01a7336-2265ed81a4emr11237995ad.8.1742421583017;
        Wed, 19 Mar 2025 14:59:43 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7ccsm120016755ad.174.2025.03.19.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:42 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 05/20] staging: gpib: cec_gpib: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:09 +0000
Message-ID: <20250319215924.19387-6-matchstick@neverthere.org>
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
 drivers/staging/gpib/cec/cec_gpib.c | 59 +++++++++++++++--------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 8f2b4b46a446..abe5b1b8bc5b 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -25,7 +25,7 @@ MODULE_DESCRIPTION("GPIB driver for CEC PCI and PCMCIA boards");
 
 static irqreturn_t cec_interrupt(int irq, void *arg)
 {
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct cec_priv *priv = board->private_data;
 	unsigned long flags;
 	irqreturn_t retval;
@@ -40,12 +40,12 @@ static irqreturn_t cec_interrupt(int irq, void *arg)
 #define CEC_DEV_ID    0x5cec
 #define CEC_SUBID 0x9050
 
-static int cec_pci_attach(gpib_board_t *board, const gpib_board_config_t *config);
+static int cec_pci_attach(struct gpib_board *board, const gpib_board_config_t *config);
 
-static void cec_pci_detach(gpib_board_t *board);
+static void cec_pci_detach(struct gpib_board *board);
 
 // wrappers for interface functions
-static int cec_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
+static int cec_read(struct gpib_board *board, uint8_t *buffer, size_t length, int *end,
 		    size_t *bytes_read)
 {
 	struct cec_priv *priv = board->private_data;
@@ -53,7 +53,7 @@ static int cec_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *en
 	return nec7210_read(board, &priv->nec7210_priv, buffer, length, end, bytes_read);
 }
 
-static int cec_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
+static int cec_write(struct gpib_board *board, uint8_t *buffer, size_t length, int send_eoi,
 		     size_t *bytes_written)
 {
 	struct cec_priv *priv = board->private_data;
@@ -61,126 +61,127 @@ static int cec_write(gpib_board_t *board, uint8_t *buffer, size_t length, int se
 	return nec7210_write(board, &priv->nec7210_priv, buffer, length, send_eoi, bytes_written);
 }
 
-static int cec_command(gpib_board_t *board, uint8_t *buffer, size_t length, size_t *bytes_written)
+static int cec_command(struct gpib_board *board, uint8_t *buffer,
+		       size_t length, size_t *bytes_written)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_command(board, &priv->nec7210_priv, buffer, length, bytes_written);
 }
 
-static int cec_take_control(gpib_board_t *board, int synchronous)
+static int cec_take_control(struct gpib_board *board, int synchronous)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_take_control(board, &priv->nec7210_priv, synchronous);
 }
 
-static int cec_go_to_standby(gpib_board_t *board)
+static int cec_go_to_standby(struct gpib_board *board)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_go_to_standby(board, &priv->nec7210_priv);
 }
 
-static void cec_request_system_control(gpib_board_t *board, int request_control)
+static void cec_request_system_control(struct gpib_board *board, int request_control)
 {
 	struct cec_priv *priv = board->private_data;
 
 	nec7210_request_system_control(board, &priv->nec7210_priv, request_control);
 }
 
-static void cec_interface_clear(gpib_board_t *board, int assert)
+static void cec_interface_clear(struct gpib_board *board, int assert)
 {
 	struct cec_priv *priv = board->private_data;
 
 	nec7210_interface_clear(board, &priv->nec7210_priv, assert);
 }
 
-static void cec_remote_enable(gpib_board_t *board, int enable)
+static void cec_remote_enable(struct gpib_board *board, int enable)
 {
 	struct cec_priv *priv = board->private_data;
 
 	nec7210_remote_enable(board, &priv->nec7210_priv, enable);
 }
 
-static int cec_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int cec_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_enable_eos(board, &priv->nec7210_priv, eos_byte, compare_8_bits);
 }
 
-static void cec_disable_eos(gpib_board_t *board)
+static void cec_disable_eos(struct gpib_board *board)
 {
 	struct cec_priv *priv = board->private_data;
 
 	nec7210_disable_eos(board, &priv->nec7210_priv);
 }
 
-static unsigned int cec_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int cec_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_update_status(board, &priv->nec7210_priv, clear_mask);
 }
 
-static int cec_primary_address(gpib_board_t *board, unsigned int address)
+static int cec_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_primary_address(board, &priv->nec7210_priv, address);
 }
 
-static int cec_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int cec_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_secondary_address(board, &priv->nec7210_priv, address, enable);
 }
 
-static int cec_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int cec_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_parallel_poll(board, &priv->nec7210_priv, result);
 }
 
-static void cec_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+static void cec_parallel_poll_configure(struct gpib_board *board, uint8_t config)
 {
 	struct cec_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_configure(board, &priv->nec7210_priv, config);
 }
 
-static void cec_parallel_poll_response(gpib_board_t *board, int ist)
+static void cec_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct cec_priv *priv = board->private_data;
 
 	nec7210_parallel_poll_response(board, &priv->nec7210_priv, ist);
 }
 
-static void cec_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void cec_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	struct cec_priv *priv = board->private_data;
 
 	nec7210_serial_poll_response(board, &priv->nec7210_priv, status);
 }
 
-static uint8_t cec_serial_poll_status(gpib_board_t *board)
+static uint8_t cec_serial_poll_status(struct gpib_board *board)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static unsigned int cec_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int cec_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	struct cec_priv *priv = board->private_data;
 
 	return nec7210_t1_delay(board, &priv->nec7210_priv, nano_sec);
 }
 
-static void cec_return_to_local(gpib_board_t *board)
+static void cec_return_to_local(struct gpib_board *board)
 {
 	struct cec_priv *priv = board->private_data;
 
@@ -215,7 +216,7 @@ static gpib_interface_t cec_pci_interface = {
 	.return_to_local = cec_return_to_local,
 };
 
-static int cec_allocate_private(gpib_board_t *board)
+static int cec_allocate_private(struct gpib_board *board)
 {
 	struct cec_priv *priv;
 
@@ -228,13 +229,13 @@ static int cec_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void cec_free_private(gpib_board_t *board)
+static void cec_free_private(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
 }
 
-static int cec_generic_attach(gpib_board_t *board)
+static int cec_generic_attach(struct gpib_board *board)
 {
 	struct cec_priv *cec_priv;
 	struct nec7210_priv *nec_priv;
@@ -252,7 +253,7 @@ static int cec_generic_attach(gpib_board_t *board)
 	return 0;
 }
 
-static void cec_init(struct cec_priv *cec_priv, const gpib_board_t *board)
+static void cec_init(struct cec_priv *cec_priv, const struct gpib_board *board)
 {
 	struct nec7210_priv *nec_priv = &cec_priv->nec7210_priv;
 
@@ -264,7 +265,7 @@ static void cec_init(struct cec_priv *cec_priv, const gpib_board_t *board)
 	nec7210_board_online(nec_priv, board);
 }
 
-static int cec_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int cec_pci_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct cec_priv *cec_priv;
 	struct nec7210_priv *nec_priv;
@@ -322,7 +323,7 @@ static int cec_pci_attach(gpib_board_t *board, const gpib_board_config_t *config
 	return 0;
 }
 
-static void cec_pci_detach(gpib_board_t *board)
+static void cec_pci_detach(struct gpib_board *board)
 {
 	struct cec_priv *cec_priv = board->private_data;
 	struct nec7210_priv *nec_priv;
-- 
2.43.0


