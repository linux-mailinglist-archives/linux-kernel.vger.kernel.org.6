Return-Path: <linux-kernel+bounces-243185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CCA9292DF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2E6283098
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28A13B286;
	Sat,  6 Jul 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AxRKST6o"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9D139CFC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264905; cv=none; b=sCwIxqXCmU0lqQ1Ls5ExR00HyRq2zt56xYz/cWFCJGcRtfWmB1IQqQ0UAk+4wUquB7BupVCiQoa37Wq7VGGuN4823TIWcpCluEj9H4Qn1JGFjFZvxt0vKpEP54ZABNBSNreHXepoia0xz1a3+bs5i0s1V8UH41IMl4I2EAuehLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264905; c=relaxed/simple;
	bh=cwNpm6cmcedvTmgJYIYI4r4UZQAz03n1V0IomcLiY0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnF3t2YPT6R+6rhXnR1g34AYlJSVyDJXoqU4VVTBfaD9JD7E/SEG5+VR29x72b49xjKSnRdpmlat7bJXd8F8MMdpZHwP5ElfK/kVCluVQadyurFFypnsWj38Ozqm3PDfcIZu1M3bnzvASEmbo+RoY4xXs45NijQshPP7X786Nt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AxRKST6o; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=TMNlMppsr5FIbxubOxKOX/t6YvbAqQy3FZPHU9s/HeA=; b=AxRKST
	6owM2BX3j5eLjdDlGHoMEOhwE5BhUBUadV7GyyxLy7JTrKsANLs3WpOj4ZFfOgWN
	Iv/y3hC3tKDpigZ4NC1qBPuIGMed4h898yWEHrd6kGqbPLkfwVgHp5Dny6YB637i
	sOIX9uhchew+25pmsQANwxbIRF7wfT43w6Eo0ya3zj+GwxTKiU738rsNv2M9DCel
	qkHB63gTaHuNOv48CnO8MoniEPWNimWwr68dsz+jQpUathyHK6ES8lEoKABn8EdZ
	KrPrDAhCB9lbjaMkXBbmYOHNvsUCx6IQXYqgU4NoW1yELZHpTpj7LwzphIFj4t++
	ZiAMow8yXOJLRO9Q==
Received: (qmail 3809622 invoked from network); 6 Jul 2024 13:21:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:27 +0200
X-UD-Smtp-Session: l3s3148p1@BaGMYZIcZJBQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/60] i2c: cht-wc: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:08 +0200
Message-ID: <20240706112116.24543-9-wsa+renesas@sang-engineering.com>
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
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/busses/i2c-cht-wc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 0209933b9a84..52e3000626c5 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Intel CHT Whiskey Cove PMIC I2C Master driver
+ * Intel CHT Whiskey Cove PMIC I2C controller driver
  * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
  *
  * Based on various non upstream patches to support the CHT Whiskey Cove PMIC:
@@ -106,7 +106,7 @@ static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
 	return IRQ_HANDLED;
 }
 
-static u32 cht_wc_i2c_adap_master_func(struct i2c_adapter *adap)
+static u32 cht_wc_i2c_adap_func(struct i2c_adapter *adap)
 {
 	/* This i2c adapter only supports SMBUS byte transfers */
 	return I2C_FUNC_SMBUS_BYTE_DATA;
@@ -168,7 +168,7 @@ static int cht_wc_i2c_adap_smbus_xfer(struct i2c_adapter *_adap, u16 addr,
 }
 
 static const struct i2c_algorithm cht_wc_i2c_adap_algo = {
-	.functionality = cht_wc_i2c_adap_master_func,
+	.functionality = cht_wc_i2c_adap_func,
 	.smbus_xfer = cht_wc_i2c_adap_smbus_xfer,
 };
 
@@ -554,6 +554,6 @@ static struct platform_driver cht_wc_i2c_adap_driver = {
 };
 module_platform_driver(cht_wc_i2c_adap_driver);
 
-MODULE_DESCRIPTION("Intel CHT Whiskey Cove PMIC I2C Master driver");
+MODULE_DESCRIPTION("Intel CHT Whiskey Cove PMIC I2C controller driver");
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_LICENSE("GPL");
-- 
2.43.0


