Return-Path: <linux-kernel+bounces-278381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9894AF84
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094761F22155
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FFE13F43E;
	Wed,  7 Aug 2024 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAVHaSug"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514BF78C7E;
	Wed,  7 Aug 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054778; cv=none; b=jcwqhYcNBxgzbQBnYGiQS3VEWP84rzzyqqsw4i8AaQcTlpa5EPjBC5bQjC1RNZYhMr8KT9rJ0dBMoODhcKajZDzoGinQaUFI/Tnlc8Lw+ao4eqHFFHVclOELs5Sx+xet5dSUeftb2gdzZmigErrSURA/Jg2tOKxTyxCytv4NDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054778; c=relaxed/simple;
	bh=P+T4BKP1YW+rpCuUoCu3NP8xYBTKn2cfdYb5TO1WseY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iV/21QZd2eVBK/KB6MNFKg6hbGXq/qr+oIfXRgT1kvujejFdzE+ZxBSU0hwMVmCgRP0PYHlxgEo2DV+SXvK1fzpaFrU0ivyQ3EkpazwQEFz5IoGIx36Q8DpEQsbMfSsn2HI5EUt/5OiEQOau+niYyGXRkijCkeFsxCy9AXtnZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAVHaSug; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a115c427f1so110721a12.0;
        Wed, 07 Aug 2024 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054776; x=1723659576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLh/tGSnf4KVpltLnZCFCEYBN1Sy0qgXLUyy8qKyWvY=;
        b=WAVHaSugDcz6c/yoLVp98Wfv5+cuGbzA1MuD/vdWriEqVymI5AaUa07TcKef6u9uXC
         GF1M7SL591BNjk5Va60l87cbm+m2v1k43ganEGHzYCgnXC9JCdoIaf6k1RixzcOA3ULG
         DLooDLJpUFvsVv+gdfXh3aUu2h4WSa5pqzrkI4O9R596uHf7w0BzCuqJSKjea99BiJTq
         eB+0IqUx58KpZCaz0v/Ju6+Q9+ml/q2lKxEZXCP+BQwLMh7zZ5rB6HEaJzsMoFvQ8bkD
         5VsLxGRblRDJyXBF3gqXyRpZO2ND028jSQwderQYZ3kFAP76H8UD7kHfS9EezZx2SwKm
         wGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054776; x=1723659576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLh/tGSnf4KVpltLnZCFCEYBN1Sy0qgXLUyy8qKyWvY=;
        b=V7Niwff0JtFqD8qdS3T0eW2JLtl1k1B/uqNKXxcGSfLW77UV5TAoxCs3vb+j6Lx0tJ
         7Gl1ZMJ0gNy6t553Afyb+sAQW3LbZZ5/Q31ov8Q5bBr+fwPgGUxQH8HpoOe/07jEclrM
         NCA+HRpWmlG1C0onYgzW9AM1RT1igxRzmTx142+wyK1tlae92T4dy0rHX6LevnNo1hxk
         NxU5qiTM7stTtrtakELlLAfHLS8n/EN/0gWW9InaDH1iYRa8jE2b0xzt2/2UijGbEs6h
         Biuo8x8imOkhMXW4azE/SUskz/dSV5kF2MtwypJrU5NR8KXhypgD0Dpvhgex506X8n8n
         bDNg==
X-Forwarded-Encrypted: i=1; AJvYcCV68lR1GuCTBvcOCWWxn9RKukzDWMlEpqovqd7ffxmcGsVDzC+Yq3I3cursatqeCOFQkIyv5hDaGMyV9NIZkujcPyGhWwQ8mOKpPidHS+jiMeFZ15DP+DCS1nCsPj351oBLw1TvQaLTjTQ=
X-Gm-Message-State: AOJu0YwLssjYoeSX2nH57J4NrAC7t1nVzkJKw6UlAJru2SpnZiS+h16l
	vIc9/Q92FBuKTvPEVqS0X2JnjoNppy2m5BajVAU06njtdKeN7Z/b
X-Google-Smtp-Source: AGHT+IEa6XbSxxD+9mFxIUaBupGjgBWy+l5Fv4hGRQwAlhZkls51VFy+7Rfm128EkQxaLmeVuiW+VQ==
X-Received: by 2002:a17:90b:d94:b0:2c9:5f1e:1a62 with SMTP id 98e67ed59e1d1-2cff95401f4mr18063745a91.36.1723054776380;
        Wed, 07 Aug 2024 11:19:36 -0700 (PDT)
Received: from embed-PC.. ([110.225.178.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b374b3cesm1913041a91.48.2024.08.07.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:19:36 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (lm93) Return error values on read failure
Date: Wed,  7 Aug 2024 23:47:46 +0530
Message-Id: <20240807181746.508972-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issue of lm93_read_byte() and lm93_read_word() return 0 on
read failure after retries, which could be confused with valid data.

Address the TODO: what to return in case of error?

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/hwmon/lm93.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index be4853fad80f..b76f3c1c6297 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -798,6 +798,7 @@ static unsigned LM93_ALARMS_FROM_REG(struct block1_t b1)
 static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
 {
 	int value, i;
+	int ret;
 
 	/* retry in case of read errors */
 	for (i = 1; i <= MAX_RETRIES; i++) {
@@ -808,14 +809,14 @@ static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
 			dev_warn(&client->dev,
 				 "lm93: read byte data failed, address 0x%02x.\n",
 				 reg);
+			ret = value;
 			mdelay(i + 3);
 		}
 
 	}
 
-	/* <TODO> what to return in case of error? */
 	dev_err(&client->dev, "lm93: All read byte retries failed!!\n");
-	return 0;
+	return ret;
 }
 
 static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
@@ -836,6 +837,7 @@ static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
 static u16 lm93_read_word(struct i2c_client *client, u8 reg)
 {
 	int value, i;
+	int ret;
 
 	/* retry in case of read errors */
 	for (i = 1; i <= MAX_RETRIES; i++) {
@@ -846,14 +848,14 @@ static u16 lm93_read_word(struct i2c_client *client, u8 reg)
 			dev_warn(&client->dev,
 				 "lm93: read word data failed, address 0x%02x.\n",
 				 reg);
+			ret = value;
 			mdelay(i + 3);
 		}
 
 	}
 
-	/* <TODO> what to return in case of error? */
 	dev_err(&client->dev, "lm93: All read word retries failed!!\n");
-	return 0;
+	return ret;
 }
 
 static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
-- 
2.34.1


