Return-Path: <linux-kernel+bounces-243178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE999292CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C621F21DFD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD677101;
	Sat,  6 Jul 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FJixzpFY"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DAF6A33F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264899; cv=none; b=B1xETczmC+1ZSkQZrxg2ue22dyTL4h2MOpqpu858D2JJGtxcYP9gGeUU42PMDJY62n2MrTCzgXxn/X1zjE+4Bq9S7asX6LsyzopWcTK8GWHCA0+1XURO51pTr3qXayput7lP6wqHhmGcPEQitOga3FtRCPek2m3VYHk1fykz0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264899; c=relaxed/simple;
	bh=sWoU++v9Gc2dEBG7BvUyollpPzX0E36KZU276jD4GrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Muk4dZlG5vCgm8jLgzy5gLR7LUkP0TAl0ipncVHjmaeyIYug1q7bLPM6h+cdvaVjczpbdumTlAWPwGpBo+GiApqs6YpsXsKN2oJLwiAFeH5f1QH3aTtuCQQcaoARBhbkW2S6uiFu+3ujj0wCEyW1XGVE7/Beb18P0Q/weZ5+ZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FJixzpFY; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=UjHQHh6n+8mUVCxVPcEkDo35gh9CZBnM7AGM4eQcL7c=; b=FJixzp
	FYytWbBblVzHg2D/qLGwWYiGO7SGFD7o9ncvJVaR0qb3ammBPtzUJHCB2vgZA15A
	CKtQ2524iFOUqzff4ZBrLS/Qttw56mQBPyw+DpCBri495lmSV/+SGN0FuMeCc8xh
	Oa+QxbZ8337kLuMh0Yh6W8M1YPDyVfBUdd6ess6O5DF2YIigwS6F60f3A9HkLvWY
	Q9PUGHW0AuoeJrA4k9ct0dg+FSJAH2yJg2xdRdubR0tRmZ7wbALVbI3aPIYTNyRy
	BDo9ewuDf/2xsG7y9dbXQNCBLWRsuldZAvLEAraj6DRhAgm8X1uJFLDQVKRJLCaG
	pG+R85diz1aq7wDg==
Received: (qmail 3809445 invoked from network); 6 Jul 2024 13:21:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:22 +0200
X-UD-Smtp-Session: l3s3148p1@tQA9YZIcrNJQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/60] i2c: reword i2c_algorithm according to newest specification
Date: Sat,  6 Jul 2024 13:20:01 +0200
Message-ID: <20240706112116.24543-2-wsa+renesas@sang-engineering.com>
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

Start changing the wording of the I2C main header wrt. the newest I2C
v7 and SMBus 3.2 specifications and replace "master/slave" with more
appropriate terms. The first step renames the members of struct
i2c_algorithm. Once all in-tree users are converted, the anonymous union
will go away again. All this work will also pave the way for finally
seperating the monolithic header into more fine-grained headers like
"i2c/clients.h" etc.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 include/linux/i2c.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 424acb98c7c2..9d45b7b912dd 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -548,10 +548,18 @@ struct i2c_algorithm {
 	 * master_xfer should return the number of messages successfully
 	 * processed, or a negative value on error
 	 */
-	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
-			   int num);
-	int (*master_xfer_atomic)(struct i2c_adapter *adap,
+	union {
+		int (*xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			    int num);
+		int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
+				   int num);
+	};
+	union {
+		int (*xfer_atomic)(struct i2c_adapter *adap,
 				   struct i2c_msg *msgs, int num);
+		int (*master_xfer_atomic)(struct i2c_adapter *adap,
+					   struct i2c_msg *msgs, int num);
+	};
 	int (*smbus_xfer)(struct i2c_adapter *adap, u16 addr,
 			  unsigned short flags, char read_write,
 			  u8 command, int size, union i2c_smbus_data *data);
@@ -563,8 +571,14 @@ struct i2c_algorithm {
 	u32 (*functionality)(struct i2c_adapter *adap);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	int (*reg_slave)(struct i2c_client *client);
-	int (*unreg_slave)(struct i2c_client *client);
+	union {
+		int (*reg_target)(struct i2c_client *client);
+		int (*reg_slave)(struct i2c_client *client);
+	};
+	union {
+		int (*unreg_target)(struct i2c_client *client);
+		int (*unreg_slave)(struct i2c_client *client);
+	};
 #endif
 };
 
-- 
2.43.0


