Return-Path: <linux-kernel+bounces-568884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A8A69BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D819C4B13
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED98220683;
	Wed, 19 Mar 2025 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="XEYVTidn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D0219A7E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421592; cv=none; b=AR2pX60Ud9mnWcip7Y+YoFOtXtQ4SphidM54tOVqLAnSxFikII3YDbEFb9L8LKgWI/D/kQb2P6fulkJRG6cLBJu41mBEAcRRRsMkXW0ZP/T9v8UeooIqocxatezARWqJI9FEgirprq2fbjTSbhp7kr2lrYsMMmX3SQ1fsao8kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421592; c=relaxed/simple;
	bh=Fw4a9mlnKOTNcdiM0fswp36qHY5x+EfCvi/48WgyqWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhIytUu0k1nlyewb+OR7YUIHrr+FB60lkM5N9r3z1Leg/gu8hliIHmpAwUfNYLr8JbXTJQAdtf0LDAvsNa17J+3ZJf3usPu+ergzbM15GQM8c9b7IqE7HOIBzan/j4giiJ5CwqnbnRnF1iThrdovwJaLNoneCeTcaf79N5MD9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=XEYVTidn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22548a28d0cso1160955ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421589; x=1743026389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy7IplSbVwpQnJVRuVqNjgdWMp+XadaNyfeEyd6Aua4=;
        b=XEYVTidn/zxmNRnDySYNqmJNZtmRb7PCHaEgH8APCVbZ2vSpJxqDMq5vzYc18zA5uT
         1v9WmuCxXYmpRQd7Pfk/g3L+WeWEePw6yKPf/iJotm3hvzLP5YgM9VFeZ+RtcGUUwNQI
         OBc518oM8GEbdkTr/ny348Puugp2Ln5pGKv43a+GBGIoNriOZfHFXTFkEAB6hmEiS9Zh
         U80dLMOUaQjzTUiU/dA0coX9rKZuKycyWZzs2XwygXBiLl+on6D5GRvzxhONoB7aokpF
         Khe6NoxkYtMOf81Frfp5oEwvgaqUzNYPLgGVEU4kSf8E5m6iEcanKgGjG3E7TmM6drMM
         bxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421589; x=1743026389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uy7IplSbVwpQnJVRuVqNjgdWMp+XadaNyfeEyd6Aua4=;
        b=qAkfURvlBp8EouU1JgBDxPxnQxBFc4p4+EFaEwKEDXFgmf1EIFZQg5vDTEH1AIKred
         0b0XXxUtwQuCEsu4MWhXeGQdKdFMjh3SJThB/qTi1rWrivBuxCDmIE4a0PW+D5xaEdGu
         Y4A1RLgcZblCybu5xsEFCWsMfT8lZ+8ZZJHDpJtULSSSfAa8zIWfI1lOM2S9RkGNcR0j
         DrphFvIU5q9e+cXn4lDfvaYilgXBc0ZYJTqHxa4ByxJ6DBGRo7Z/UxtjBjN73D3JAmO+
         K4ZMeyDvCR6xu1zMtb1CoVKklyGEKmfKW0AvzIDkR2N1JuE3KobZnDrKdtroGa0jYKq9
         Dreg==
X-Forwarded-Encrypted: i=1; AJvYcCUrjFXcvX2oT5IT9+UxP3jiQ3vIrAUvb3g3XIE91v25FKMAC1mccqOiNd9qNYsG58W0XQu/o6XB4ZzjspA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7xcRPZ6xmSgAlLPXbxK2g8Y+wcogZYZiaI5HxGmw44Vgilfj
	Mydkdi4hOu2eV7AsREDLbXmJZ2BfQcgXiTRnv/L/YjFAiBTUuF7BMgRLZ51ltA==
X-Gm-Gg: ASbGncsEB3jy45k88xuJAn+nRFhzUIopLbRSfPgdrQsliKqyKPg90ZcBrSO4IvroqeR
	YpBrhc1k+ysSh63dYIFqzflfUZsnB5SwVCeezFdGyQgFjVz4prx8xRU6Sa02MYShjL+mrste9n9
	LF1ZJ6227gkHqoNxTNlVOUuERXUj4odALiLleo8v2GbDTGM5B/Fc9ITe2UJocyp76JVt+ZlhKlu
	Oe0K3sW7sI4R4axh5F1+/euiSe4LMXklLIYL6rewjhGSw84miZ/NOwH8us99X8HKvW3N+mXIvN0
	YhSUip3R2Ov36hYPGn8F8Og7IvNa7pS4o0m4GK7qTE9U473k9ShBIkmvNTJylpRbmCmy2aLBm7K
	ETQ3WhibDiA==
X-Google-Smtp-Source: AGHT+IGlGp+Tgp4LzxeXuHM5RYUmkEn3xQFe8FyDBR/GUioIdO+tPqN9bQ5tM2rVodSFNkYenoFTDA==
X-Received: by 2002:a05:6a20:914b:b0:1f5:8eb1:d5d2 with SMTP id adf61e73a8af0-1fd117fd115mr1298491637.13.1742421589459;
        Wed, 19 Mar 2025 14:59:49 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea93c84sm11463587a12.64.2025.03.19.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:49 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 10/20] staging: gpib: hp2335: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:14 +0000
Message-ID: <20250319215924.19387-11-matchstick@neverthere.org>
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
 drivers/staging/gpib/hp_82335/hp82335.c | 56 ++++++++++++-------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 982544d1b382..368e60c6ecd2 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -24,12 +24,12 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB driver for HP 82335 interface cards");
 
-static int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config);
-static void hp82335_detach(gpib_board_t *board);
+static int hp82335_attach(struct gpib_board *board, const gpib_board_config_t *config);
+static void hp82335_detach(struct gpib_board *board);
 static irqreturn_t hp82335_interrupt(int irq, void *arg);
 
 // wrappers for interface functions
-static int hp82335_read(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int hp82335_read(struct gpib_board *board, uint8_t *buffer, size_t length,
 			int *end, size_t *bytes_read)
 {
 	struct hp82335_priv *priv = board->private_data;
@@ -37,7 +37,7 @@ static int hp82335_read(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return tms9914_read(board, &priv->tms9914_priv, buffer, length, end, bytes_read);
 }
 
-static int hp82335_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
+static int hp82335_write(struct gpib_board *board, uint8_t *buffer, size_t length, int send_eoi,
 			 size_t *bytes_written)
 {
 	struct hp82335_priv *priv = board->private_data;
@@ -45,7 +45,7 @@ static int hp82335_write(gpib_board_t *board, uint8_t *buffer, size_t length, in
 	return tms9914_write(board, &priv->tms9914_priv, buffer, length, send_eoi, bytes_written);
 }
 
-static int hp82335_command(gpib_board_t *board, uint8_t *buffer, size_t length,
+static int hp82335_command(struct gpib_board *board, uint8_t *buffer, size_t length,
 			   size_t *bytes_written)
 {
 	struct hp82335_priv *priv = board->private_data;
@@ -53,126 +53,126 @@ static int hp82335_command(gpib_board_t *board, uint8_t *buffer, size_t length,
 	return tms9914_command(board, &priv->tms9914_priv, buffer, length, bytes_written);
 }
 
-static int hp82335_take_control(gpib_board_t *board, int synchronous)
+static int hp82335_take_control(struct gpib_board *board, int synchronous)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_take_control(board, &priv->tms9914_priv, synchronous);
 }
 
-static int hp82335_go_to_standby(gpib_board_t *board)
+static int hp82335_go_to_standby(struct gpib_board *board)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_go_to_standby(board, &priv->tms9914_priv);
 }
 
-static void hp82335_request_system_control(gpib_board_t *board, int request_control)
+static void hp82335_request_system_control(struct gpib_board *board, int request_control)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	tms9914_request_system_control(board, &priv->tms9914_priv, request_control);
 }
 
-static void hp82335_interface_clear(gpib_board_t *board, int assert)
+static void hp82335_interface_clear(struct gpib_board *board, int assert)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	tms9914_interface_clear(board, &priv->tms9914_priv, assert);
 }
 
-static void hp82335_remote_enable(gpib_board_t *board, int enable)
+static void hp82335_remote_enable(struct gpib_board *board, int enable)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	tms9914_remote_enable(board, &priv->tms9914_priv, enable);
 }
 
-static int hp82335_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int hp82335_enable_eos(struct gpib_board *board, uint8_t eos_byte, int compare_8_bits)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_enable_eos(board, &priv->tms9914_priv, eos_byte, compare_8_bits);
 }
 
-static void hp82335_disable_eos(gpib_board_t *board)
+static void hp82335_disable_eos(struct gpib_board *board)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	tms9914_disable_eos(board, &priv->tms9914_priv);
 }
 
-static unsigned int hp82335_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int hp82335_update_status(struct gpib_board *board, unsigned int clear_mask)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_update_status(board, &priv->tms9914_priv, clear_mask);
 }
 
-static int hp82335_primary_address(gpib_board_t *board, unsigned int address)
+static int hp82335_primary_address(struct gpib_board *board, unsigned int address)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_primary_address(board, &priv->tms9914_priv, address);
 }
 
-static int hp82335_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int hp82335_secondary_address(struct gpib_board *board, unsigned int address, int enable)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_secondary_address(board, &priv->tms9914_priv, address, enable);
 }
 
-static int hp82335_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int hp82335_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_parallel_poll(board, &priv->tms9914_priv, result);
 }
 
-static void hp82335_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+static void hp82335_parallel_poll_configure(struct gpib_board *board, uint8_t config)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	tms9914_parallel_poll_configure(board, &priv->tms9914_priv, config);
 }
 
-static void hp82335_parallel_poll_response(gpib_board_t *board, int ist)
+static void hp82335_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	tms9914_parallel_poll_response(board, &priv->tms9914_priv, ist);
 }
 
-static void hp82335_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void hp82335_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	tms9914_serial_poll_response(board, &priv->tms9914_priv, status);
 }
 
-static uint8_t hp82335_serial_poll_status(gpib_board_t *board)
+static uint8_t hp82335_serial_poll_status(struct gpib_board *board)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_serial_poll_status(board, &priv->tms9914_priv);
 }
 
-static int hp82335_line_status(const gpib_board_t *board)
+static int hp82335_line_status(const struct gpib_board *board)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int hp82335_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static unsigned int hp82335_t1_delay(struct gpib_board *board, unsigned int nano_sec)
 {
 	struct hp82335_priv *priv = board->private_data;
 
 	return tms9914_t1_delay(board, &priv->tms9914_priv, nano_sec);
 }
 
-static void hp82335_return_to_local(gpib_board_t *board)
+static void hp82335_return_to_local(struct gpib_board *board)
 {
 	struct hp82335_priv *priv = board->private_data;
 
@@ -207,7 +207,7 @@ static gpib_interface_t hp82335_interface = {
 	.return_to_local = hp82335_return_to_local,
 };
 
-static int hp82335_allocate_private(gpib_board_t *board)
+static int hp82335_allocate_private(struct gpib_board *board)
 {
 	board->private_data = kzalloc(sizeof(struct hp82335_priv), GFP_KERNEL);
 	if (!board->private_data)
@@ -215,7 +215,7 @@ static int hp82335_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void hp82335_free_private(gpib_board_t *board)
+static void hp82335_free_private(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
@@ -243,7 +243,7 @@ static void hp82335_clear_interrupt(struct hp82335_priv *hp_priv)
 	writeb(0, tms_priv->mmiobase + HPREG_INTR_CLEAR);
 }
 
-static int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int hp82335_attach(struct gpib_board *board, const gpib_board_config_t *config)
 {
 	struct hp82335_priv *hp_priv;
 	struct tms9914_priv *tms_priv;
@@ -307,7 +307,7 @@ static int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config
 	return 0;
 }
 
-static void hp82335_detach(gpib_board_t *board)
+static void hp82335_detach(struct gpib_board *board)
 {
 	struct hp82335_priv *hp_priv = board->private_data;
 	struct tms9914_priv *tms_priv;
@@ -354,7 +354,7 @@ module_exit(hp82335_exit_module);
 static irqreturn_t hp82335_interrupt(int irq, void *arg)
 {
 	int status1, status2;
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct hp82335_priv *priv = board->private_data;
 	unsigned long flags;
 	irqreturn_t retval;
-- 
2.43.0


