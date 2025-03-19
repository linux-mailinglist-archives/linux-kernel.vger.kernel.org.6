Return-Path: <linux-kernel+bounces-568876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743E7A69BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F064E7A8CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E0821C17B;
	Wed, 19 Mar 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="SFlEsfsQ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D42165E9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421581; cv=none; b=RMHK+BLxPpPpZ5Di1sNoe9Jtf6SHVWwpHWbFAerOmcEcLiKxx/M8T9USUWntwH+d2CJbAYyg/QsB0Qa7/Ib3PEH3PAWXyzsE3JP3ZCoZt3T3/3WLXGWUfOJu5xTATSJ0QTkUmXewO0YyWrBCPou5IVahshjUKVZjaFUpzhAboJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421581; c=relaxed/simple;
	bh=GvYMUi/WMdyjCVqwHV7+4gp6hpfc2LY6Iy29RCoZFVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0rk1vg+pSqLMcW5Jze0yL3VZi1zZKy0rcpxMono0a6CoeLUnEsryPA6gzOmQru1+SHViyDPJ0DS4t3/ZUejfgUTkjsq6AtRmEyYbkYO6qFfQKfbW2GvVk/F6NLDTSSNTmF0sHezVhD4RWWtBwOdWuHsb1hu3NqtGhLcElvnNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=SFlEsfsQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235189adaeso2437625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421579; x=1743026379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh9H79q8RgOXoC1LKOVoZppx+POUhL+mHZSn1kSXCPM=;
        b=SFlEsfsQfTJNuE2g5jf2lq/GrfdTMcRdwxEHc+UY00OpOCiQxrMqpn/oJMF00u7y/C
         OR1cPnKqF1ygRjAOAc9CsQAc91Yhy9y4cmvSqGwrPFfEeEHWWMXTB5RbTbapC5mO+rMI
         2EfFpECzYqHMJj68VoaIISTzpSYJB26lIcfSkZ0fO0mzQAnD2ZgaurMmQI4jw95pvayw
         R/eE4D79HyYgQlJc4ZfKj+cPk/8YRw+yGY8DNUWhX9WV35dL4RpEDRI0ZM9gts9ZV8yk
         bJsrbu2eBkAEvnNcVts+ElDyHpPbhPVc27OoC3KbJVrWgujz0sFFdBbhaUVWWX2jcAqW
         khDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421579; x=1743026379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nh9H79q8RgOXoC1LKOVoZppx+POUhL+mHZSn1kSXCPM=;
        b=gbKqeMmUsrL9x7EXMBMbzwDMCiUwlu9JXJt26L8kc/tg29A/+6PmQ7N1dL+h1UrpXx
         ybuPbdk6uxxyfWmRbxEBNjrx+qjaasOxqlise9Mv7h+mwIamWl2Eoarg4yN9PGFtSEXu
         UaDg5TJUJ/nI+C1zSPaHm3EEOcwzV2M986gzdkeTPcXxl2ALrTAOadddA3nkz+uXM/9+
         dJaIuCFTwLSL0NQdQVLJenabgvDpXyBo4OwAq2BKUcr0sWABqQKGdHf2iuggUSb9rr4E
         JNsDe+s9hmkJAx9uats6w2puJaZn0iUkM6AQD2iPP3lk0yIIFvVH+ZlSeqoeU+8JX8if
         /6Og==
X-Forwarded-Encrypted: i=1; AJvYcCVXRMwEuq52UiMiLCPsABCVWQs0pQL6P2JRfBWSPEqqAMF6JIzzdwPDDKchGQXqVi7Os3ESCsgdQqTqe6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfr7s03xjsN1rI/Gi5vTC0etpdOspEF3nZMJRpL5IJEuQYTUei
	mwzucVV0vlLCNZmPXdmyUnvcrbYcI4Ydr6sGfkJE3Fmbg774zdXMwlgr+PfwkdilNucG6AGVgZU
	=
X-Gm-Gg: ASbGnctNDdyMGblJsF6/hrEAJFNqiEgBWAehBToUJixYhrMQKAI1N+vFd9E8xe4zQNJ
	P0ae23eTMLjzO7MvMqlxTNMArMlyAdc8U0mG4nzG/BT1qiH4hmWrBWKAcRRHCrudd8wdcas0ml2
	oqvZ8WLCyd2t0iSkvzObd+L6ctshy5pTPNydGLVEHQ5hF7fC3KQWqJZAK18w5PZmiHLecoxS3Y0
	giyLtTT92A7CS1dCPQo3BKRa8hPqlo2+h8DmuBuiVevIl/ye4GZDryICvifeQUM65B+2y9ryZvN
	noUTmEHp9glboVrAGz0AUCdKVbYyPRMjR0/qoe0mD3RR3wZc93p0TN6djYXRLoW6mS8ETZgjaVy
	A/C0EBqyY3g==
X-Google-Smtp-Source: AGHT+IH36U87CyLy7MyHotv12JNc0MNjEHl/5uTWkWfgilG0uE2PIMoQUh4iTe4MoLuXwAu+CG0dnA==
X-Received: by 2002:a17:902:e543:b0:224:3994:8a8c with SMTP id d9443c01a7336-2265e69d92dmr14733935ad.8.1742421579382;
        Wed, 19 Mar 2025 14:59:39 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167d88fsm12664720b3a.96.2025.03.19.14.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:39 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 02/20] staging: gpib: agilent_82350b: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:06 +0000
Message-ID: <20250319215924.19387-3-matchstick@neverthere.org>
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
 .../gpib/agilent_82350b/agilent_82350b.c      | 99 ++++++++++---------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index f83e1f321561..15a9c4ab77ba 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -25,13 +25,13 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB driver for Agilent 82350b");
 
 static int read_transfer_counter(struct agilent_82350b_priv *a_priv);
-static unsigned short read_and_clear_event_status(gpib_board_t *board);
+static unsigned short read_and_clear_event_status(struct gpib_board *board);
 static void set_transfer_counter(struct agilent_82350b_priv *a_priv, int count);
-static int agilent_82350b_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
-				size_t *bytes_written);
+static int agilent_82350b_write(struct gpib_board *board, uint8_t *buffer,
+				size_t length, int send_eoi, size_t *bytes_written);
 
-static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
-				     size_t *bytes_read)
+static int agilent_82350b_accel_read(struct gpib_board *board, uint8_t *buffer,
+				     size_t length, int *end, size_t *bytes_read)
 
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
@@ -130,7 +130,7 @@ static int agilent_82350b_accel_read(gpib_board_t *board, uint8_t *buffer, size_
 	return 0;
 }
 
-static int translate_wait_return_value(gpib_board_t *board, int retval)
+static int translate_wait_return_value(struct gpib_board *board, int retval)
 
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
@@ -145,8 +145,9 @@ static int translate_wait_return_value(gpib_board_t *board, int retval)
 	return 0;
 }
 
-static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size_t length,
-				      int send_eoi, size_t *bytes_written)
+static int agilent_82350b_accel_write(struct gpib_board *board, uint8_t *buffer,
+				      size_t length, int send_eoi,
+				      size_t *bytes_written)
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	struct tms9914_priv *tms_priv = &a_priv->tms9914_priv;
@@ -227,7 +228,7 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
 	return 0;
 }
 
-static unsigned short read_and_clear_event_status(gpib_board_t *board)
+static unsigned short read_and_clear_event_status(struct gpib_board *board)
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	unsigned long flags;
@@ -245,7 +246,7 @@ static irqreturn_t agilent_82350b_interrupt(int irq, void *arg)
 {
 	int tms9914_status1 = 0, tms9914_status2 = 0;
 	int event_status;
-	gpib_board_t *board = arg;
+	struct gpib_board *board = arg;
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	unsigned long flags;
 	irqreturn_t retval = IRQ_NONE;
@@ -272,7 +273,7 @@ static irqreturn_t agilent_82350b_interrupt(int irq, void *arg)
 	return retval;
 }
 
-static void agilent_82350b_detach(gpib_board_t *board);
+static void agilent_82350b_detach(struct gpib_board *board);
 
 static int read_transfer_counter(struct agilent_82350b_priv *a_priv)
 {
@@ -296,17 +297,16 @@ static void set_transfer_counter(struct agilent_82350b_priv *a_priv, int count)
 }
 
 // wrappers for interface functions
-static int agilent_82350b_read(gpib_board_t *board, uint8_t *buffer, size_t length, int *end,
-			       size_t *bytes_read)
-
+static int agilent_82350b_read(struct gpib_board *board, uint8_t *buffer,
+			       size_t length, int *end, size_t *bytes_read)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	return tms9914_read(board, &priv->tms9914_priv, buffer, length, end, bytes_read);
 }
 
-static int agilent_82350b_write(gpib_board_t *board, uint8_t *buffer, size_t length, int send_eoi,
-				size_t *bytes_written)
+static int agilent_82350b_write(struct gpib_board *board, uint8_t *buffer,
+				size_t length, int send_eoi, size_t *bytes_written)
 
 {
 	struct agilent_82350b_priv *priv = board->private_data;
@@ -314,8 +314,8 @@ static int agilent_82350b_write(gpib_board_t *board, uint8_t *buffer, size_t len
 	return tms9914_write(board, &priv->tms9914_priv, buffer, length, send_eoi, bytes_written);
 }
 
-static int agilent_82350b_command(gpib_board_t *board, uint8_t *buffer, size_t length,
-				  size_t *bytes_written)
+static int agilent_82350b_command(struct gpib_board *board, uint8_t *buffer,
+				  size_t length, size_t *bytes_written)
 
 {
 	struct agilent_82350b_priv *priv = board->private_data;
@@ -323,7 +323,7 @@ static int agilent_82350b_command(gpib_board_t *board, uint8_t *buffer, size_t l
 	return tms9914_command(board, &priv->tms9914_priv, buffer, length, bytes_written);
 }
 
-static int agilent_82350b_take_control(gpib_board_t *board, int synchronous)
+static int agilent_82350b_take_control(struct gpib_board *board, int synchronous)
 
 {
 	struct agilent_82350b_priv *priv = board->private_data;
@@ -331,7 +331,7 @@ static int agilent_82350b_take_control(gpib_board_t *board, int synchronous)
 	return tms9914_take_control_workaround(board, &priv->tms9914_priv, synchronous);
 }
 
-static int agilent_82350b_go_to_standby(gpib_board_t *board)
+static int agilent_82350b_go_to_standby(struct gpib_board *board)
 
 {
 	struct agilent_82350b_priv *priv = board->private_data;
@@ -339,7 +339,8 @@ static int agilent_82350b_go_to_standby(gpib_board_t *board)
 	return tms9914_go_to_standby(board, &priv->tms9914_priv);
 }
 
-static void agilent_82350b_request_system_control(gpib_board_t *board, int request_control)
+static void agilent_82350b_request_system_control(struct gpib_board *board,
+						  int request_control)
 
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
@@ -357,7 +358,7 @@ static void agilent_82350b_request_system_control(gpib_board_t *board, int reque
 	tms9914_request_system_control(board, &a_priv->tms9914_priv, request_control);
 }
 
-static void agilent_82350b_interface_clear(gpib_board_t *board, int assert)
+static void agilent_82350b_interface_clear(struct gpib_board *board, int assert)
 
 {
 	struct agilent_82350b_priv *priv = board->private_data;
@@ -365,91 +366,97 @@ static void agilent_82350b_interface_clear(gpib_board_t *board, int assert)
 	tms9914_interface_clear(board, &priv->tms9914_priv, assert);
 }
 
-static void agilent_82350b_remote_enable(gpib_board_t *board, int enable)
+static void agilent_82350b_remote_enable(struct gpib_board *board, int enable)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	tms9914_remote_enable(board, &priv->tms9914_priv, enable);
 }
 
-static int agilent_82350b_enable_eos(gpib_board_t *board, uint8_t eos_byte, int compare_8_bits)
+static int agilent_82350b_enable_eos(struct gpib_board *board, uint8_t eos_byte,
+				     int compare_8_bits)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	return tms9914_enable_eos(board, &priv->tms9914_priv, eos_byte, compare_8_bits);
 }
 
-static void agilent_82350b_disable_eos(gpib_board_t *board)
+static void agilent_82350b_disable_eos(struct gpib_board *board)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	tms9914_disable_eos(board, &priv->tms9914_priv);
 }
 
-static unsigned int agilent_82350b_update_status(gpib_board_t *board, unsigned int clear_mask)
+static unsigned int agilent_82350b_update_status(struct gpib_board *board,
+						 unsigned int clear_mask)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	return tms9914_update_status(board, &priv->tms9914_priv, clear_mask);
 }
 
-static int agilent_82350b_primary_address(gpib_board_t *board, unsigned int address)
+static int agilent_82350b_primary_address(struct gpib_board *board,
+					  unsigned int address)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	return tms9914_primary_address(board, &priv->tms9914_priv, address);
 }
 
-static int agilent_82350b_secondary_address(gpib_board_t *board, unsigned int address, int enable)
+static int agilent_82350b_secondary_address(struct gpib_board *board,
+					    unsigned int address, int enable)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	return tms9914_secondary_address(board, &priv->tms9914_priv, address, enable);
 }
 
-static int agilent_82350b_parallel_poll(gpib_board_t *board, uint8_t *result)
+static int agilent_82350b_parallel_poll(struct gpib_board *board, uint8_t *result)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	return tms9914_parallel_poll(board, &priv->tms9914_priv, result);
 }
 
-static void agilent_82350b_parallel_poll_configure(gpib_board_t *board, uint8_t config)
+static void agilent_82350b_parallel_poll_configure(struct gpib_board *board,
+						   uint8_t config)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	tms9914_parallel_poll_configure(board, &priv->tms9914_priv, config);
 }
 
-static void agilent_82350b_parallel_poll_response(gpib_board_t *board, int ist)
+static void agilent_82350b_parallel_poll_response(struct gpib_board *board, int ist)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	tms9914_parallel_poll_response(board, &priv->tms9914_priv, ist);
 }
 
-static void agilent_82350b_serial_poll_response(gpib_board_t *board, uint8_t status)
+static void agilent_82350b_serial_poll_response(struct gpib_board *board, uint8_t status)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	tms9914_serial_poll_response(board, &priv->tms9914_priv, status);
 }
 
-static uint8_t agilent_82350b_serial_poll_status(gpib_board_t *board)
+static uint8_t agilent_82350b_serial_poll_status(struct gpib_board *board)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	return tms9914_serial_poll_status(board, &priv->tms9914_priv);
 }
 
-static int agilent_82350b_line_status(const gpib_board_t *board)
+static int agilent_82350b_line_status(const struct gpib_board *board)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int agilent_82350b_t1_delay(gpib_board_t *board, unsigned int nanosec)
+static unsigned int agilent_82350b_t1_delay(struct gpib_board *board,
+					    unsigned int nanosec)
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	static const int nanosec_per_clock = 30;
@@ -464,14 +471,14 @@ static unsigned int agilent_82350b_t1_delay(gpib_board_t *board, unsigned int na
 	return value * nanosec_per_clock;
 }
 
-static void agilent_82350b_return_to_local(gpib_board_t *board)
+static void agilent_82350b_return_to_local(struct gpib_board *board)
 {
 	struct agilent_82350b_priv *priv = board->private_data;
 
 	tms9914_return_to_local(board, &priv->tms9914_priv);
 }
 
-static int agilent_82350b_allocate_private(gpib_board_t *board)
+static int agilent_82350b_allocate_private(struct gpib_board *board)
 {
 	board->private_data = kzalloc(sizeof(struct agilent_82350b_priv), GFP_KERNEL);
 	if (!board->private_data)
@@ -479,13 +486,14 @@ static int agilent_82350b_allocate_private(gpib_board_t *board)
 	return 0;
 }
 
-static void agilent_82350b_free_private(gpib_board_t *board)
+static void agilent_82350b_free_private(struct gpib_board *board)
 {
 	kfree(board->private_data);
 	board->private_data = NULL;
 }
 
-static int init_82350a_hardware(gpib_board_t *board, const gpib_board_config_t *config)
+static int init_82350a_hardware(struct gpib_board *board,
+				const gpib_board_config_t *config)
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	static const unsigned int firmware_length = 5302;
@@ -550,7 +558,7 @@ static int init_82350a_hardware(gpib_board_t *board, const gpib_board_config_t *
 	return 0;
 }
 
-static int test_sram(gpib_board_t *board)
+static int test_sram(struct gpib_board *board)
 
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
@@ -579,7 +587,8 @@ static int test_sram(gpib_board_t *board)
 	return 0;
 }
 
-static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_config_t *config,
+static int agilent_82350b_generic_attach(struct gpib_board *board,
+					 const gpib_board_config_t *config,
 					 int use_fifos)
 
 {
@@ -721,17 +730,19 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 	return 0;
 }
 
-static int agilent_82350b_unaccel_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int agilent_82350b_unaccel_attach(struct gpib_board *board,
+					 const gpib_board_config_t *config)
 {
 	return agilent_82350b_generic_attach(board, config, 0);
 }
 
-static int agilent_82350b_accel_attach(gpib_board_t *board, const gpib_board_config_t *config)
+static int agilent_82350b_accel_attach(struct gpib_board *board,
+				       const gpib_board_config_t *config)
 {
 	return agilent_82350b_generic_attach(board, config, 1);
 }
 
-static void agilent_82350b_detach(gpib_board_t *board)
+static void agilent_82350b_detach(struct gpib_board *board)
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	struct tms9914_priv *tms_priv;
-- 
2.43.0


