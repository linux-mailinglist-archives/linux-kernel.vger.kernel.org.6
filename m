Return-Path: <linux-kernel+bounces-243187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33ED9292E6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A9A1C20F9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90B13D887;
	Sat,  6 Jul 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ipzTI/Pl"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCD13A86C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264908; cv=none; b=DMVnLGZHE8BgK6hI5mdCwgBMcJGcWCCoKy2dmlR5kGPKlDeecqi+lr7acc04SB7GnLj1yKovkCp5JaDY4CNropfFM2FIjKl4Ae++wNc3ZppabMfkhEei3/C6mX+rgpV2Un53UuYwrmjL0OuzGk48z0ATEpkh9pqP50qHOKM1Qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264908; c=relaxed/simple;
	bh=g8q1Tud1Xuimagm8NaVB4lsNz4s2Nu7CuhX2XQnallY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPo2FEU9FTuQwPCK+5GxcawhKXtBJkXFezBlwC3Dt2JiSr02AZQjKOiC7wK0BzBWj7lQAbdAMfX31pwcb+/ffasxpsTBo7c2C5nhkCgZvUMyPh9DgcCUJ6S1VAFDezc4XsMyHoiI9iWLe1PrjtRDpTsIzI4OrtsHfHF+UOIm2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ipzTI/Pl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=JrEULlm4gyDDgxEjqP3uJVh7L9gHtGAIiuGV0SotmWc=; b=ipzTI/
	PlQidifvbvkmI8Zm2hKzAH30/Ght/t7Kymfa3JKqgw3bLiyWxlrgCOjsRVfOIMRU
	gSYOTK/OtQCoBYr1v6ck1tb7vKcuRxN9xSGOeoA7LBX7uw2HlNPnra0+T8CSC+ZI
	gTSnlQ3JjRN7pwNc9sq08jij3LmkXD38mkLJw8LD8FF3m5rl0FFI7roOVBEw1/n1
	GjSztyl9WbUjCnRzGtDX+O8NDHtfofMCbZDQYJjAhbX+9JnrmUyMWLITyGJ9jLsP
	0fVy+aN/8FPIyIjFFD7UJ73L+39CSXgOUL4+S117T8DT+k2bKw8B0qoh55qAU5Um
	TUzREtVhze4R0s/Q==
Received: (qmail 3809642 invoked from network); 6 Jul 2024 13:21:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:28 +0200
X-UD-Smtp-Session: l3s3148p1@+8WXYZIcbJBQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/60] i2c: cp2615: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:09 +0200
Message-ID: <20240706112116.24543-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-cp2615.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index cf3747d87034..315a37155401 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -60,7 +60,7 @@ enum cp2615_i2c_status {
 	CP2615_CFG_LOCKED = -6,
 	/* read_len or write_len out of range */
 	CP2615_INVALID_PARAM = -4,
-	/* I2C slave did not ACK in time */
+	/* I2C target did not ACK in time */
 	CP2615_TIMEOUT,
 	/* I2C bus busy */
 	CP2615_BUS_BUSY,
@@ -211,7 +211,7 @@ static int cp2615_check_iop(struct usb_interface *usbif)
 }
 
 static int
-cp2615_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+cp2615_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct usb_interface *usbif = adap->algo_data;
 	int i = 0, ret = 0;
@@ -250,8 +250,8 @@ cp2615_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm cp2615_i2c_algo = {
-	.master_xfer	= cp2615_i2c_master_xfer,
-	.functionality	= cp2615_i2c_func,
+	.xfer = cp2615_i2c_xfer,
+	.functionality = cp2615_i2c_func,
 };
 
 /*
-- 
2.43.0


