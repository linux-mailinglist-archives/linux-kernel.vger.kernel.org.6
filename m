Return-Path: <linux-kernel+bounces-530370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED6A43297
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E7B3B0A12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E597DA67;
	Tue, 25 Feb 2025 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey7AwS5k"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B65101F2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448102; cv=none; b=SOnUkmmmlYnPs2Upxo1SaVFoGLRoSWe4vCnRDv4nRIaGPxKFPD9BPyGkmfQVwEW0tmC9UMjFtjobdSe7KHvzleuouRfAvR7GN89OfpakO+B5hdehc2bqpNnY4K622kLdkcMPQK5y2Fdy7QIyg2zgH8iX2VY9l+zMeLBAYa3MJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448102; c=relaxed/simple;
	bh=5SkSprA1RphIny48AOoHxKU8cOIRTq6kUV4wPvC0vPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYG81ldgZCQcZSceU8OjR9DaCzY+vh9Lg/ewan+4yY1Lsy0Xnm5rtwihEHqQs+xhYX6mhtj8mRq01iceGqSEYvL9ykPDk1I7pFRGkeXDnGd6ddcS+BWNrGgO4CqtlfcSJb4m7E6e/qY1EV687rcMsIK5JdAnAz4j4CEj4tbgIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey7AwS5k; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d132f16dso78051205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740448100; x=1741052900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxdzEX4STWW6xh8zJzWBmPNpAISQD7HDOStU27JCglE=;
        b=Ey7AwS5kQlOBW3TG7DnwUBtSAXXX8MSzu1CnO4uhGjwa57Bp9RXZ7AerPKsi+bt3mw
         UWScQAkC+uyFgnpUY4THSS++82rawMunyt/OUQ8VU7LjODDs9wnIs/jajNyGqMsNxp1t
         BTiF9K6x5GjwcEPbupfTEY0+5Qfwxqdq4ipRjv33Q7eoG/T570dlNDG0f5pIDi7tTFD2
         7lBdD8cOcx4YK+IgPEV1f8/wisGBteMYrFwchiTsrrbTGevV87REU+s8Wazi+NbzIWdQ
         /+8NgQeBoW+D0xpXnJAMzMr4iKWIBnBPGv9p8XSZUjEkg7S2XXx7xKD48OhKmi4rtglm
         R1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448100; x=1741052900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxdzEX4STWW6xh8zJzWBmPNpAISQD7HDOStU27JCglE=;
        b=A8LZxNBIGZjerTiEnlQo1Gt0MScZBPhcuzfJN7t+k9K2sww0OrMfSMyA4q1PluGEMA
         wBmCu5VGmmRs1GpevxKtZD/bgL+lyg7F2+tHFkcK4qD4IS2+6gmy4jVSYpPO+y34pkTw
         Lc1Fyr445EA2TAhi+IqWpEAMU/17Txp5eYmd+xZ7nErYNKZp0RchUysngGbI7lGaY/zd
         Nk+73fHFoUlgmndC1tLIGnzFQ7O3BapHJcUfVA994jPkhe+F0ZJq1qdVA473Ti4gSccs
         +zJWdJ/k3JSuLz+qIilMm2jMOagK172Em1y1tZntOW/bMUhC3wHU1PrJlvod24FzZFuC
         q+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWZqlSTswETuaTLeip8LlMzEY4uHSUQxLARY7yjSOjG8aGI9yvLhL0LQC/lDg4RBW72F3GfL5rRxlvygXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DYWvO94lEO3pPjYitsrJaXKQklkryi7N/fyAdK/pZqLZJqAo
	i/65deQr19SRWkxSTOZBRSOA8rQU82wNPQ/27MUDs75Nzn2Ljjh4
X-Gm-Gg: ASbGnctdWHaSgTJhOzfk52XZBACkjGuTybrs8YwKEXsUE2hBDzS3rFksq030skuHx+W
	G3cx9N8/T2vHPbRmfxZ3vdJBMSRTgeHRxk7dWJyPBHIcz4GHclEN10zZMuooADvkgILUyAEga25
	zbMGVey7Tgq4IV4scNxlKxEX6YHne8AJFdSUAfC4icmo28tnRp0uPkmEs6L6hivGPJivRuZsDt3
	IohzoCXw9JJw1YC0TljjjoHdzZf2foikoOHlCSWy/9782Fvx8jFmsN+V6cSLdiuT6OmaEtaxf+9
	b0cBgmq+S5l0kfoXikWxqt0nr4/csIaHnB4g8Mn7mZcyqbGi
X-Google-Smtp-Source: AGHT+IESTMHAOgPb1YR41BifyAGUjEikm9Uip7SYrBWHLMEahUjmMqqKeJFlMOu72zjzrSimfzC85Q==
X-Received: by 2002:a05:6a00:190c:b0:730:9204:f0c6 with SMTP id d2e1a72fcca58-73426d77955mr24117514b3a.16.1740448099556;
        Mon, 24 Feb 2025 17:48:19 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4ff:1626:32b1:712a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6fa12esm322399b3a.66.2025.02.24.17.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 17:48:19 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	dpenkler@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: gpib: change return type of t1_delay function to report errors
Date: Mon, 24 Feb 2025 22:44:05 -0300
Message-ID: <20250225014811.77995-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code returns "unsigned int" and it doesn't handle errors
correctly if it happens during ioctl call for t1 delay configuration.

The ni_usb_t1_delay(), from NI, is the only function returning -1
at this point. The caller, t1_delay_ioctl(), doesn't check for errors
and sets board->t1_nano_sec to -1 and returns success.
The board->t1_nano_sec value is also used in ni_usb_setup_t1_delay()
besides the ioctl call and a value of -1 is treated as being above 1100ns.
It may or may not have a noticeable effect, but it's obviously not right
considering the content of ni_usb_setup_t1_delay().

Typical delays are in the 200-2000 range, but definitely not more
than INT_MAX so we can fix this code by changing the return type to int
and adding a check for errors. While we're at it, lets change the error
code in ni_usb_t1_delay() from -1 and instead propagate the error from
ni_usb_write_registers().

Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Changelog:
v3: rebase;
v2: https://lore.kernel.org/linux-staging/20250218021804.29016-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/linux-staging/20250212024247.176572-1-rodrigo.gobbi.7@gmail.com/
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 2 +-
 drivers/staging/gpib/agilent_82357a/agilent_82357a.c | 2 +-
 drivers/staging/gpib/cb7210/cb7210.c                 | 2 +-
 drivers/staging/gpib/cec/cec_gpib.c                  | 2 +-
 drivers/staging/gpib/common/gpib_os.c                | 5 ++++-
 drivers/staging/gpib/eastwood/fluke_gpib.c           | 2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c             | 2 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c             | 2 +-
 drivers/staging/gpib/hp_82335/hp82335.c              | 2 +-
 drivers/staging/gpib/hp_82341/hp_82341.c             | 2 +-
 drivers/staging/gpib/include/gpib_types.h            | 2 +-
 drivers/staging/gpib/include/nec7210.h               | 4 ++--
 drivers/staging/gpib/ines/ines.h                     | 2 +-
 drivers/staging/gpib/ines/ines_gpib.c                | 2 +-
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c   | 2 +-
 drivers/staging/gpib/nec7210/nec7210.c               | 4 ++--
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c            | 4 ++--
 drivers/staging/gpib/pc2/pc2_gpib.c                  | 2 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c          | 2 +-
 19 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index f83e1f321561..063ab0407a25 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -449,7 +449,7 @@ static int agilent_82350b_line_status(const gpib_board_t *board)
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int agilent_82350b_t1_delay(gpib_board_t *board, unsigned int nanosec)
+static int agilent_82350b_t1_delay(gpib_board_t *board, unsigned int nanosec)
 {
 	struct agilent_82350b_priv *a_priv = board->private_data;
 	static const int nanosec_per_clock = 30;
diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 7ebebe00dc48..0b0575e29fe4 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -1022,7 +1022,7 @@ static unsigned short nanosec_to_fast_talker_bits(unsigned int *nanosec)
 	return bits;
 }
 
-static unsigned int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int nanosec)
+static int agilent_82357a_t1_delay(gpib_board_t *board, unsigned int nanosec)
 {
 	struct agilent_82357a_priv *a_priv = board->private_data;
 	struct usb_device *usb_dev = interface_to_usbdev(a_priv->bus_interface);
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 19dfd8b4a8e7..8ed995241865 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -407,7 +407,7 @@ static int cb7210_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int cb7210_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int cb7210_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct cb7210_priv *cb_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &cb_priv->nec7210_priv;
diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 8f2b4b46a446..faf0216ea302 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -173,7 +173,7 @@ static uint8_t cec_serial_poll_status(gpib_board_t *board)
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static unsigned int cec_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int cec_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct cec_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 301c8a1a62c2..634763b570e8 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -1990,8 +1990,11 @@ static int t1_delay_ioctl(gpib_board_t *board, unsigned long arg)
 
 	delay = cmd;
 
-	board->t1_nano_sec = board->interface->t1_delay(board, delay);
+	retval = board->interface->t1_delay(board, delay);
+	if (retval < 0)
+		return retval;
 
+	board->t1_nano_sec = retval;
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index 731732bd8301..479787f868a0 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -223,7 +223,7 @@ static int fluke_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int fluke_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int fluke_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct fluke_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index d62c83368518..2f49db10df09 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -259,7 +259,7 @@ static int fmh_gpib_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int fmh_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int fmh_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct fmh_priv *e_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &e_priv->nec7210_priv;
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 2012db188f58..99e67d788100 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -1009,7 +1009,7 @@ static uint8_t bb_serial_poll_status(gpib_board_t *board)
 	return 0; // -ENOENT;
 }
 
-static unsigned int bb_t1_delay(gpib_board_t *board,  unsigned int nano_sec)
+static int bb_t1_delay(gpib_board_t *board,  unsigned int nano_sec)
 {
 	struct bb_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 982544d1b382..c2dc4405ed0b 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -165,7 +165,7 @@ static int hp82335_line_status(const gpib_board_t *board)
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int hp82335_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int hp82335_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct hp82335_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index 91fbaf953bcd..7ac4c0234055 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -396,7 +396,7 @@ static int hp_82341_line_status(const gpib_board_t *board)
 	return tms9914_line_status(board, &priv->tms9914_priv);
 }
 
-static unsigned int hp_82341_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int hp_82341_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct hp_82341_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index b41781a55a60..5ee72683b2e0 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -170,7 +170,7 @@ struct gpib_interface_struct {
 	 */
 	uint8_t (*serial_poll_status)(gpib_board_t *board);
 	/* adjust T1 delay */
-	unsigned int (*t1_delay)(gpib_board_t *board, unsigned int nano_sec);
+	int (*t1_delay)(gpib_board_t *board, unsigned int nano_sec);
 	/* go to local mode */
 	void (*return_to_local)(gpib_board_t *board);
 	/* board does not support 7 bit eos comparisons */
diff --git a/drivers/staging/gpib/include/nec7210.h b/drivers/staging/gpib/include/nec7210.h
index ca998c4a84bf..a9c6d1b3cb6a 100644
--- a/drivers/staging/gpib/include/nec7210.h
+++ b/drivers/staging/gpib/include/nec7210.h
@@ -108,8 +108,8 @@ void nec7210_parallel_poll_response(gpib_board_t *board,
 				    struct nec7210_priv *priv, int ist);
 uint8_t nec7210_serial_poll_status(gpib_board_t *board,
 				   struct nec7210_priv *priv);
-unsigned int nec7210_t1_delay(gpib_board_t *board,
-			      struct nec7210_priv *priv, unsigned int nano_sec);
+int nec7210_t1_delay(gpib_board_t *board,
+		     struct nec7210_priv *priv, unsigned int nano_sec);
 void nec7210_return_to_local(const gpib_board_t *board, struct nec7210_priv *priv);
 
 // utility functions
diff --git a/drivers/staging/gpib/ines/ines.h b/drivers/staging/gpib/ines/ines.h
index 3918737fa21a..57c3a4f8a546 100644
--- a/drivers/staging/gpib/ines/ines.h
+++ b/drivers/staging/gpib/ines/ines.h
@@ -60,7 +60,7 @@ void ines_parallel_poll_response(gpib_board_t *board, int ist);
 void ines_serial_poll_response(gpib_board_t *board, uint8_t status);
 uint8_t ines_serial_poll_status(gpib_board_t *board);
 int ines_line_status(const gpib_board_t *board);
-unsigned int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec);
+int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec);
 void ines_return_to_local(gpib_board_t *board);
 
 // interrupt service routines
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 56da6cd91188..57d57a577ca7 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -65,7 +65,7 @@ void ines_set_xfer_counter(struct ines_priv *priv, unsigned int count)
 	ines_outb(priv, count & 0xff, XFER_COUNT_LOWER);
 }
 
-unsigned int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+int ines_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct ines_priv *ines_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &ines_priv->nec7210_priv;
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 50faa0c17617..8e049c265819 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -1056,7 +1056,7 @@ static uint8_t usb_gpib_serial_poll_status(gpib_board_t *board)
 
 /* t1_delay */
 
-static unsigned int usb_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int usb_gpib_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	return 0;
 }
diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/staging/gpib/nec7210/nec7210.c
index 85f1e79d658a..f94a8553a6a7 100644
--- a/drivers/staging/gpib/nec7210/nec7210.c
+++ b/drivers/staging/gpib/nec7210/nec7210.c
@@ -372,8 +372,8 @@ void nec7210_release_rfd_holdoff(gpib_board_t *board, struct nec7210_priv *priv)
 }
 EXPORT_SYMBOL(nec7210_release_rfd_holdoff);
 
-unsigned int nec7210_t1_delay(gpib_board_t *board, struct nec7210_priv *priv,
-			      unsigned int nano_sec)
+int nec7210_t1_delay(gpib_board_t *board, struct nec7210_priv *priv,
+		     unsigned int nano_sec)
 {
 	unsigned int retval;
 
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 61b15b19e134..eee3ae694d95 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -1566,7 +1566,7 @@ static int ni_usb_setup_t1_delay(struct ni_usb_register *reg, unsigned int nano_
 	return i;
 }
 
-static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
@@ -1580,7 +1580,7 @@ static unsigned int ni_usb_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 	retval = ni_usb_write_registers(ni_priv, writes, i, &ibsta);
 	if (retval < 0) {
 		dev_err(&usb_dev->dev, "register write failed, retval=%i\n", retval);
-		return -1;	//FIXME should change return type to int for error reporting
+		return retval;
 	}
 	board->t1_nano_sec = actual_ns;
 	ni_usb_soft_update_status(board, ibsta, 0);
diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 6711851301ec..b4aa2a4b3f49 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -218,7 +218,7 @@ static uint8_t pc2_serial_poll_status(gpib_board_t *board)
 	return nec7210_serial_poll_status(board, &priv->nec7210_priv);
 }
 
-static unsigned int pc2_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int pc2_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct pc2_priv *priv = board->private_data;
 
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index d32420dee5e5..ffa4959e2bfc 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -178,7 +178,7 @@ static int tnt4882_line_status(const gpib_board_t *board)
 	return status;
 }
 
-static unsigned int tnt4882_t1_delay(gpib_board_t *board, unsigned int nano_sec)
+static int tnt4882_t1_delay(gpib_board_t *board, unsigned int nano_sec)
 {
 	struct tnt4882_priv *tnt_priv = board->private_data;
 	struct nec7210_priv *nec_priv = &tnt_priv->nec7210_priv;
-- 
2.47.0


