Return-Path: <linux-kernel+bounces-568892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1D7A69BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E23BE829
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C22236FA;
	Wed, 19 Mar 2025 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="Y30+Pem0"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C901B221F3A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421601; cv=none; b=ncEA0BBEutW5ck36zf6kmcFiL+Bq87zQVJjT0284WHPTDpYuvxwO7QYK5ZLmw5olb4b0YCmX+cBKWHxB8VpggjRVhJcgZj8KmR/uJxogWskhkj7C0EaBjZS76lERgy/5pzbcPToUNUT8t03RWT6rT8Rha+t98qgKyLv7sfE5ALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421601; c=relaxed/simple;
	bh=1RRg6qzGSb0YpVqltZE3Qn9x6p/LJwN2y0RuzoUDpF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJbCG3RalruynGWqq2QJyApuNb5wcBS84gutSybC4Wsv6aU6IONNg/u+E1eQHBuSskqwdQrF4wnfY9OqFvvv080w8jafyNWFnX1/JrQwycAGOxseq3crGsDGGjov/94EZS5XPWxQ0LIwDHEeq+O0+q1BsLdQ3ELIIRXquazo1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=Y30+Pem0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-301cda78d48so242735a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421598; x=1743026398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaWeBMilM3QY+XIg7AXsmdsftbfaiK01uF9SVEKysGQ=;
        b=Y30+Pem0hdTQ7o/lz69vnBN8LL3F/SSofqJ/U/P6C0dhgCOoP+xcL2S+B0k1wLPsjU
         +B6sNBhitsUHeLg9PHMzoYVuFMKYiWiPXM47Ny3dyIWMUTuZuTjiKAFAhkeAits6TwO0
         fQNTcsBHo2JwcOzdFLa9rjoykwcx0kO0LS779rRmfd1Tcxcxe5LNFMdZNUB996c2nccQ
         xlT1Z8+Pw03TCVo9MxjmQfrM79to6h66Vc8YtLn6TNNh+B6qjxMzYC1WyrOkStR1tvkN
         7PddhgNqoWuZ6MZHLa4qV92X8HMyZ+KTLsHSRUpXnp2c9/5TLZKjEClJX1fEJZ0tKTxg
         IqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421598; x=1743026398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaWeBMilM3QY+XIg7AXsmdsftbfaiK01uF9SVEKysGQ=;
        b=JOrVw7Ciam/nrFKyzcOCYS/z8YwHxhFIwc06EbsA2qBqpcEWEy9MgO39CZiS18tv1m
         hN9QjWcYCwdT4yPeETkYxovUHxSIHv1/QxtSy6u2XiDfQ99eyJKObuNM23mHEz7yGfpU
         UZhN08d6nbN3JmokOiiSAn0z4llizu+GqM72Z+0quH4L9aUPFulXZphA/hZZkQxV6uNT
         LgM7VWcNJ5uIe6nooH3P2pmf5Zq6NLtq4UQWzYgGA6DAdz+5c9ifNHexIJC42Sl8GfQX
         SFpbHaMaue779md+0Fz5IZocokR9bMsqgb4L3GhvflI7ZxJ2TZY0RR2Ah0y4ExBY0nMH
         6eWA==
X-Forwarded-Encrypted: i=1; AJvYcCUylnGEWHsY+3vNPWhY/UjJqnLJd0WsndNxjoxk6nY1m8JVvKgPC6tWxdsk+JAUXlpUw/R7S4Y5i2LuGJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hKzjbd2dO9lmxG1YE6phDkmZIY+uySbpbSU8jgJkhh1MFP7b
	JEhObPakZPuAHsCOi2t2TTfgZNQ5s/vYqJVEgaODF8K1b/sCyBxr0H521uxQSQ==
X-Gm-Gg: ASbGncsLKAdCyl12UpbZTAqlU9gKntzeCRMvd4gvnRRBedb3w9fPW8rcvzHanMmY6G0
	8vcKkb0VN04KaZPLcGs+WR+gS0jyhN/HHdHIT3lcHMRSD2x28zx0Vpm5flcb+d3756Pqx8nfhQR
	zJ576NaUKnGvVBXc1yjeBFLBPyibhziPA7KzzwVzB5mwxZKlltn+QvT2GeyshzgPlCn+EJ2nhjF
	0j8oAPM5CBl63F5jovX5Ji+zfYHperOSishak6ztdZqD1iuK2she4Wuw7Ra/4yh5wZhH2VrVU70
	rYV3ZkvTqDlFLSkH02U+Lv9OOg5RiYB283eYj6asqCJQLhildv565snP9LcZZBZSc5JvKuv/gVC
	OAwcVsUN3Ww==
X-Google-Smtp-Source: AGHT+IHFLQ+Jd8/iP/8NaD7eyVGRJwo2XoEopxKYcEZQpwjV2Kr8LF9qcLhUhr/mf7zCEMta6D4gqw==
X-Received: by 2002:a17:90b:3b42:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-301d5349fe8mr1011997a91.29.1742421598185;
        Wed, 19 Mar 2025 14:59:58 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5a1591sm2213539a91.21.2025.03.19.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:57 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 17/20] staging: gpib: tms9914: struct gpib_board
Date: Wed, 19 Mar 2025 21:59:21 +0000
Message-ID: <20250319215924.19387-18-matchstick@neverthere.org>
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
 drivers/staging/gpib/include/tms9914.h | 52 ++++++++++----------
 drivers/staging/gpib/tms9914/tms9914.c | 66 +++++++++++++-------------
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/gpib/include/tms9914.h b/drivers/staging/gpib/include/tms9914.h
index d8c8d1c9b131..424c95ad85c6 100644
--- a/drivers/staging/gpib/include/tms9914.h
+++ b/drivers/staging/gpib/include/tms9914.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+//* SPDX-License-Identifier: GPL-2.0 */
 
 /***************************************************************************
  *    copyright            : (C) 2002 by Frank Mori Hess
@@ -79,47 +79,47 @@ enum {
 };
 
 // interface functions
-int tms9914_read(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffer,
+int tms9914_read(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *buffer,
 		 size_t length, int *end, size_t *bytes_read);
-int tms9914_write(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffer,
+int tms9914_write(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *buffer,
 		  size_t length, int send_eoi, size_t *bytes_written);
-int tms9914_command(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffer,
+int tms9914_command(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *buffer,
 		    size_t length, size_t *bytes_written);
-int tms9914_take_control(gpib_board_t *board, struct tms9914_priv *priv, int syncronous);
+int tms9914_take_control(struct gpib_board *board, struct tms9914_priv *priv, int syncronous);
 /* alternate version of tms9914_take_control which works around buggy tcs
  * implementation.
  */
-int tms9914_take_control_workaround(gpib_board_t *board, struct tms9914_priv *priv,
+int tms9914_take_control_workaround(struct gpib_board *board, struct tms9914_priv *priv,
 				    int syncronous);
-int tms9914_go_to_standby(gpib_board_t *board, struct tms9914_priv *priv);
-void tms9914_request_system_control(gpib_board_t *board, struct tms9914_priv *priv,
+int tms9914_go_to_standby(struct gpib_board *board, struct tms9914_priv *priv);
+void tms9914_request_system_control(struct gpib_board *board, struct tms9914_priv *priv,
 				    int request_control);
-void tms9914_interface_clear(gpib_board_t *board, struct tms9914_priv *priv, int assert);
-void tms9914_remote_enable(gpib_board_t *board, struct tms9914_priv *priv, int enable);
-int tms9914_enable_eos(gpib_board_t *board, struct tms9914_priv *priv, uint8_t eos_bytes,
+void tms9914_interface_clear(struct gpib_board *board, struct tms9914_priv *priv, int assert);
+void tms9914_remote_enable(struct gpib_board *board, struct tms9914_priv *priv, int enable);
+int tms9914_enable_eos(struct gpib_board *board, struct tms9914_priv *priv, uint8_t eos_bytes,
 		       int compare_8_bits);
-void tms9914_disable_eos(gpib_board_t *board, struct tms9914_priv *priv);
-unsigned int tms9914_update_status(gpib_board_t *board, struct tms9914_priv *priv,
+void tms9914_disable_eos(struct gpib_board *board, struct tms9914_priv *priv);
+unsigned int tms9914_update_status(struct gpib_board *board, struct tms9914_priv *priv,
 				   unsigned int clear_mask);
-int tms9914_primary_address(gpib_board_t *board,
+int tms9914_primary_address(struct gpib_board *board,
 			    struct tms9914_priv *priv, unsigned int address);
-int tms9914_secondary_address(gpib_board_t *board, struct tms9914_priv *priv,
+int tms9914_secondary_address(struct gpib_board *board, struct tms9914_priv *priv,
 			      unsigned int address, int enable);
-int tms9914_parallel_poll(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *result);
-void tms9914_parallel_poll_configure(gpib_board_t *board,
+int tms9914_parallel_poll(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *result);
+void tms9914_parallel_poll_configure(struct gpib_board *board,
 				     struct tms9914_priv *priv, uint8_t config);
-void tms9914_parallel_poll_response(gpib_board_t *board,
+void tms9914_parallel_poll_response(struct gpib_board *board,
 				    struct tms9914_priv *priv, int ist);
-void tms9914_serial_poll_response(gpib_board_t *board, struct tms9914_priv *priv, uint8_t status);
-uint8_t tms9914_serial_poll_status(gpib_board_t *board, struct tms9914_priv *priv);
-int tms9914_line_status(const gpib_board_t *board, struct tms9914_priv *priv);
-unsigned int tms9914_t1_delay(gpib_board_t *board, struct tms9914_priv *priv,
+void tms9914_serial_poll_response(struct gpib_board *board, struct tms9914_priv *priv, uint8_t status);
+uint8_t tms9914_serial_poll_status(struct gpib_board *board, struct tms9914_priv *priv);
+int tms9914_line_status(const struct gpib_board *board, struct tms9914_priv *priv);
+unsigned int tms9914_t1_delay(struct gpib_board *board, struct tms9914_priv *priv,
 			      unsigned int nano_sec);
-void tms9914_return_to_local(const gpib_board_t *board, struct tms9914_priv *priv);
+void tms9914_return_to_local(const struct gpib_board *board, struct tms9914_priv *priv);
 
 // utility functions
 void tms9914_board_reset(struct tms9914_priv *priv);
-void tms9914_online(gpib_board_t *board, struct tms9914_priv *priv);
+void tms9914_online(struct gpib_board *board, struct tms9914_priv *priv);
 void tms9914_release_holdoff(struct tms9914_priv *priv);
 void tms9914_set_holdoff_mode(struct tms9914_priv *priv, enum tms9914_holdoff_mode mode);
 
@@ -130,8 +130,8 @@ uint8_t tms9914_iomem_read_byte(struct tms9914_priv *priv, unsigned int register
 void tms9914_iomem_write_byte(struct tms9914_priv *priv, uint8_t data, unsigned int register_num);
 
 // interrupt service routine
-irqreturn_t tms9914_interrupt(gpib_board_t *board, struct tms9914_priv *priv);
-irqreturn_t tms9914_interrupt_have_status(gpib_board_t *board, struct tms9914_priv *priv,
+irqreturn_t tms9914_interrupt(struct gpib_board *board, struct tms9914_priv *priv);
+irqreturn_t tms9914_interrupt_have_status(struct gpib_board *board, struct tms9914_priv *priv,
 					  int status1,	int status2);
 
 // tms9914 has 8 registers
diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index c563fcab44fc..2abda9d7dfcb 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -27,9 +27,9 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("GPIB library for tms9914");
 
-static unsigned int update_status_nolock(gpib_board_t *board, struct tms9914_priv *priv);
+static unsigned int update_status_nolock(struct gpib_board *board, struct tms9914_priv *priv);
 
-int tms9914_take_control(gpib_board_t *board, struct tms9914_priv *priv, int synchronous)
+int tms9914_take_control(struct gpib_board *board, struct tms9914_priv *priv, int synchronous)
 {
 	int i;
 	const int timeout = 100;
@@ -66,7 +66,7 @@ EXPORT_SYMBOL_GPL(tms9914_take_control);
  * The rest of the tms9914 based drivers still use tms9914_take_control
  * directly (which does issue tcs).
  */
-int tms9914_take_control_workaround(gpib_board_t *board, struct tms9914_priv *priv, int synchronous)
+int tms9914_take_control_workaround(struct gpib_board *board, struct tms9914_priv *priv, int synchronous)
 {
 	if (synchronous)
 		return -ETIMEDOUT;
@@ -74,7 +74,7 @@ int tms9914_take_control_workaround(gpib_board_t *board, struct tms9914_priv *pr
 }
 EXPORT_SYMBOL_GPL(tms9914_take_control_workaround);
 
-int tms9914_go_to_standby(gpib_board_t *board, struct tms9914_priv *priv)
+int tms9914_go_to_standby(struct gpib_board *board, struct tms9914_priv *priv)
 {
 	int i;
 	const int timeout = 1000;
@@ -95,7 +95,7 @@ int tms9914_go_to_standby(gpib_board_t *board, struct tms9914_priv *priv)
 }
 EXPORT_SYMBOL_GPL(tms9914_go_to_standby);
 
-void tms9914_interface_clear(gpib_board_t *board, struct tms9914_priv *priv, int assert)
+void tms9914_interface_clear(struct gpib_board *board, struct tms9914_priv *priv, int assert)
 {
 	if (assert) {
 		write_byte(priv, AUX_SIC | AUX_CS, AUXCR);
@@ -107,7 +107,7 @@ void tms9914_interface_clear(gpib_board_t *board, struct tms9914_priv *priv, int
 }
 EXPORT_SYMBOL_GPL(tms9914_interface_clear);
 
-void tms9914_remote_enable(gpib_board_t *board, struct tms9914_priv *priv, int enable)
+void tms9914_remote_enable(struct gpib_board *board, struct tms9914_priv *priv, int enable)
 {
 	if (enable)
 		write_byte(priv, AUX_SRE | AUX_CS, AUXCR);
@@ -116,7 +116,7 @@ void tms9914_remote_enable(gpib_board_t *board, struct tms9914_priv *priv, int e
 }
 EXPORT_SYMBOL_GPL(tms9914_remote_enable);
 
-void tms9914_request_system_control(gpib_board_t *board, struct tms9914_priv *priv,
+void tms9914_request_system_control(struct gpib_board *board, struct tms9914_priv *priv,
 				    int request_control)
 {
 	if (request_control) {
@@ -128,7 +128,7 @@ void tms9914_request_system_control(gpib_board_t *board, struct tms9914_priv *pr
 }
 EXPORT_SYMBOL_GPL(tms9914_request_system_control);
 
-unsigned int tms9914_t1_delay(gpib_board_t *board, struct tms9914_priv *priv,
+unsigned int tms9914_t1_delay(struct gpib_board *board, struct tms9914_priv *priv,
 			      unsigned int nano_sec)
 {
 	static const int clock_period = 200;	// assuming 5Mhz input clock
@@ -154,7 +154,7 @@ unsigned int tms9914_t1_delay(gpib_board_t *board, struct tms9914_priv *priv,
 }
 EXPORT_SYMBOL_GPL(tms9914_t1_delay);
 
-void tms9914_return_to_local(const gpib_board_t *board, struct tms9914_priv *priv)
+void tms9914_return_to_local(const struct gpib_board *board, struct tms9914_priv *priv)
 {
 	write_byte(priv, AUX_RTL, AUXCR);
 }
@@ -192,7 +192,7 @@ void tms9914_release_holdoff(struct tms9914_priv *priv)
 }
 EXPORT_SYMBOL_GPL(tms9914_release_holdoff);
 
-int tms9914_enable_eos(gpib_board_t *board, struct tms9914_priv *priv, uint8_t eos_byte,
+int tms9914_enable_eos(struct gpib_board *board, struct tms9914_priv *priv, uint8_t eos_byte,
 		       int compare_8_bits)
 {
 	priv->eos = eos_byte;
@@ -203,13 +203,13 @@ int tms9914_enable_eos(gpib_board_t *board, struct tms9914_priv *priv, uint8_t e
 }
 EXPORT_SYMBOL(tms9914_enable_eos);
 
-void tms9914_disable_eos(gpib_board_t *board, struct tms9914_priv *priv)
+void tms9914_disable_eos(struct gpib_board *board, struct tms9914_priv *priv)
 {
 	priv->eos_flags &= ~REOS;
 }
 EXPORT_SYMBOL(tms9914_disable_eos);
 
-int tms9914_parallel_poll(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *result)
+int tms9914_parallel_poll(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *result)
 {
 	// execute parallel poll
 	write_byte(priv, AUX_CS | AUX_RPP, AUXCR);
@@ -234,7 +234,7 @@ static void set_ppoll_reg(struct tms9914_priv *priv, int enable,
 	}
 }
 
-void tms9914_parallel_poll_configure(gpib_board_t *board,
+void tms9914_parallel_poll_configure(struct gpib_board *board,
 				     struct tms9914_priv *priv, uint8_t config)
 {
 	priv->ppoll_enable = (config & PPC_DISABLE) == 0;
@@ -244,14 +244,14 @@ void tms9914_parallel_poll_configure(gpib_board_t *board,
 }
 EXPORT_SYMBOL(tms9914_parallel_poll_configure);
 
-void tms9914_parallel_poll_response(gpib_board_t *board,
+void tms9914_parallel_poll_response(struct gpib_board *board,
 				    struct tms9914_priv *priv, int ist)
 {
 	set_ppoll_reg(priv, priv->ppoll_enable, priv->ppoll_line, priv->ppoll_sense, ist);
 }
 EXPORT_SYMBOL(tms9914_parallel_poll_response);
 
-void tms9914_serial_poll_response(gpib_board_t *board, struct tms9914_priv *priv, uint8_t status)
+void tms9914_serial_poll_response(struct gpib_board *board, struct tms9914_priv *priv, uint8_t status)
 {
 	unsigned long flags;
 
@@ -266,7 +266,7 @@ void tms9914_serial_poll_response(gpib_board_t *board, struct tms9914_priv *priv
 }
 EXPORT_SYMBOL(tms9914_serial_poll_response);
 
-uint8_t tms9914_serial_poll_status(gpib_board_t *board, struct tms9914_priv *priv)
+uint8_t tms9914_serial_poll_status(struct gpib_board *board, struct tms9914_priv *priv)
 {
 	u8 status;
 	unsigned long flags;
@@ -279,7 +279,7 @@ uint8_t tms9914_serial_poll_status(gpib_board_t *board, struct tms9914_priv *pri
 }
 EXPORT_SYMBOL(tms9914_serial_poll_status);
 
-int tms9914_primary_address(gpib_board_t *board, struct tms9914_priv *priv, unsigned int address)
+int tms9914_primary_address(struct gpib_board *board, struct tms9914_priv *priv, unsigned int address)
 {
 	// put primary address in address0
 	write_byte(priv, address & ADDRESS_MASK, ADR);
@@ -287,7 +287,7 @@ int tms9914_primary_address(gpib_board_t *board, struct tms9914_priv *priv, unsi
 }
 EXPORT_SYMBOL(tms9914_primary_address);
 
-int tms9914_secondary_address(gpib_board_t *board, struct tms9914_priv *priv,
+int tms9914_secondary_address(struct gpib_board *board, struct tms9914_priv *priv,
 			      unsigned int address, int enable)
 {
 	if (enable)
@@ -300,7 +300,7 @@ int tms9914_secondary_address(gpib_board_t *board, struct tms9914_priv *priv,
 }
 EXPORT_SYMBOL(tms9914_secondary_address);
 
-unsigned int tms9914_update_status(gpib_board_t *board, struct tms9914_priv *priv,
+unsigned int tms9914_update_status(struct gpib_board *board, struct tms9914_priv *priv,
 				   unsigned int clear_mask)
 {
 	unsigned long flags;
@@ -342,7 +342,7 @@ static void update_listener_state(struct tms9914_priv *priv, unsigned int addres
 	}
 }
 
-static unsigned int update_status_nolock(gpib_board_t *board, struct tms9914_priv *priv)
+static unsigned int update_status_nolock(struct gpib_board *board, struct tms9914_priv *priv)
 {
 	int address_status;
 	int bsr_bits;
@@ -388,7 +388,7 @@ static unsigned int update_status_nolock(gpib_board_t *board, struct tms9914_pri
 	return board->status;
 }
 
-int tms9914_line_status(const gpib_board_t *board, struct tms9914_priv *priv)
+int tms9914_line_status(const struct gpib_board *board, struct tms9914_priv *priv)
 {
 	int bsr_bits;
 	int status = VALID_ALL;
@@ -433,7 +433,7 @@ static int check_for_eos(struct tms9914_priv *priv, uint8_t byte)
 	return 0;
 }
 
-static int wait_for_read_byte(gpib_board_t *board, struct tms9914_priv *priv)
+static int wait_for_read_byte(struct gpib_board *board, struct tms9914_priv *priv)
 {
 	if (wait_event_interruptible(board->wait,
 				     test_bit(READ_READY_BN, &priv->state) ||
@@ -449,7 +449,7 @@ static int wait_for_read_byte(gpib_board_t *board, struct tms9914_priv *priv)
 	return 0;
 }
 
-static inline uint8_t tms9914_read_data_in(gpib_board_t *board, struct tms9914_priv *priv, int *end)
+static inline uint8_t tms9914_read_data_in(struct gpib_board *board, struct tms9914_priv *priv, int *end)
 {
 	unsigned long flags;
 	u8 data;
@@ -480,7 +480,7 @@ static inline uint8_t tms9914_read_data_in(gpib_board_t *board, struct tms9914_p
 	return data;
 }
 
-static int pio_read(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffer,
+static int pio_read(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *buffer,
 		    size_t length, int *end, size_t *bytes_read)
 {
 	ssize_t retval = 0;
@@ -501,7 +501,7 @@ static int pio_read(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buf
 	return retval;
 }
 
-int tms9914_read(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffer,
+int tms9914_read(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *buffer,
 		 size_t length, int *end, size_t *bytes_read)
 {
 	ssize_t retval = 0;
@@ -541,7 +541,7 @@ int tms9914_read(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffer
 }
 EXPORT_SYMBOL(tms9914_read);
 
-static int pio_write_wait(gpib_board_t *board, struct tms9914_priv *priv)
+static int pio_write_wait(struct gpib_board *board, struct tms9914_priv *priv)
 {
 	// wait until next byte is ready to be sent
 	if (wait_event_interruptible(board->wait,
@@ -561,7 +561,7 @@ static int pio_write_wait(gpib_board_t *board, struct tms9914_priv *priv)
 	return 0;
 }
 
-static int pio_write(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffer,
+static int pio_write(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *buffer,
 		     size_t length, size_t *bytes_written)
 {
 	ssize_t retval = 0;
@@ -585,7 +585,7 @@ static int pio_write(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *bu
 	return length;
 }
 
-int tms9914_write(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffer, size_t length,
+int tms9914_write(struct gpib_board *board, struct tms9914_priv *priv, uint8_t *buffer, size_t length,
 		  int send_eoi, size_t *bytes_written)
 {
 	ssize_t retval = 0;
@@ -620,7 +620,7 @@ int tms9914_write(gpib_board_t *board, struct tms9914_priv *priv, uint8_t *buffe
 }
 EXPORT_SYMBOL(tms9914_write);
 
-static void check_my_address_state(gpib_board_t *board, struct tms9914_priv *priv, int cmd_byte)
+static void check_my_address_state(struct gpib_board *board, struct tms9914_priv *priv, int cmd_byte)
 {
 	if (cmd_byte == MLA(board->pad)) {
 		priv->primary_listen_addressed = 1;
@@ -655,7 +655,7 @@ static void check_my_address_state(gpib_board_t *board, struct tms9914_priv *pri
 	}
 }
 
-int tms9914_command(gpib_board_t *board, struct tms9914_priv *priv,  uint8_t *buffer,
+int tms9914_command(struct gpib_board *board, struct tms9914_priv *priv,  uint8_t *buffer,
 		    size_t length, size_t *bytes_written)
 {
 	int retval = 0;
@@ -692,7 +692,7 @@ int tms9914_command(gpib_board_t *board, struct tms9914_priv *priv,  uint8_t *bu
 }
 EXPORT_SYMBOL(tms9914_command);
 
-irqreturn_t tms9914_interrupt(gpib_board_t *board, struct tms9914_priv *priv)
+irqreturn_t tms9914_interrupt(struct gpib_board *board, struct tms9914_priv *priv)
 {
 	int status0, status1;
 
@@ -703,7 +703,7 @@ irqreturn_t tms9914_interrupt(gpib_board_t *board, struct tms9914_priv *priv)
 }
 EXPORT_SYMBOL(tms9914_interrupt);
 
-irqreturn_t tms9914_interrupt_have_status(gpib_board_t *board, struct tms9914_priv *priv,
+irqreturn_t tms9914_interrupt_have_status(struct gpib_board *board, struct tms9914_priv *priv,
 					  int status0, int status1)
 {
 	// record reception of END
@@ -837,7 +837,7 @@ void tms9914_board_reset(struct tms9914_priv *priv)
 }
 EXPORT_SYMBOL_GPL(tms9914_board_reset);
 
-void tms9914_online(gpib_board_t *board, struct tms9914_priv *priv)
+void tms9914_online(struct gpib_board *board, struct tms9914_priv *priv)
 {
 	/* set GPIB address */
 	tms9914_primary_address(board, priv, board->pad);
-- 
2.43.0


