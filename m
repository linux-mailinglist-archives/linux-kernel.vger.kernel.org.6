Return-Path: <linux-kernel+bounces-241567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE2E927C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF051C22F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E01142E8E;
	Thu,  4 Jul 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sylltuyp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B11422CC;
	Thu,  4 Jul 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115548; cv=none; b=KEUWSzQuDKv05r2JnNpLGTUpAc5LDmnNNIQf7dsNg5HZ0g6xiQXLujTIjbaYmEnUerZoymgsvTwIRb11qcudwn4cXf65axcUPEJCbFfgB9ztOvi8gElCcQxjoxVXWrDeHXEz70FpbMwpwTWO2HOfTud27ytJm2GKE53blOt+xtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115548; c=relaxed/simple;
	bh=CR1zOm/exczNyHzgk4E5Oi3CLe82N5p4i5s//NrQGXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ENHageLVZ+nnRhqcLzLER5NJHUBwaonN6u0ZmPVRurkm6HYCZ5vSAYr9If9eK1jzE3acWDekIdvTS8ZDHvaKu4kC7DU0L3/LZOot+peJgD0aYpmZOp72OLo5Q5fgWQ1ry1LTenkJPCVh21bLcgQhYRSG+YqOQB0+oTXHtsf3toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sylltuyp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb05ac6b77so5029105ad.0;
        Thu, 04 Jul 2024 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115545; x=1720720345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biKypspJhRc/NdpEUQx9LpXQKXpcDSehAWD1+KpiL1U=;
        b=SylltuypkiRvQ6vQm6UsLnRzbqQubxIN19Wi6TumA5h+441cEQyUtRkZFY9sKlo6cM
         IE8DGQHkRa3iM+O2qvWoXiD+b+CPYsHQLK0ajcp3/Ei5cVP5IlMh1B6S4cKuFame2NEV
         h9Dne+8AMqMMnAZm9b/XYNqlfPdAOx6jAaD34CeOsULnjYXpesbkXnq8FzNsTsm/27aP
         9iAedPUuqNryskj7PGHJ55xWh8A0qxCqpuFzn2ZidWs5RFz9n2N3Cyn/9XyFE7UfdyzJ
         MoZsTF9Tye8P3g3ilrzlJt1NmyaBOGmDiDND4KN0u9qs7t047lByf6uTAhQWMfrTJsPv
         vDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115545; x=1720720345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=biKypspJhRc/NdpEUQx9LpXQKXpcDSehAWD1+KpiL1U=;
        b=d0x9GFHB8P/Lz9rcqWz9pd35anfBSdtJzYmrrN3M/xqJ6YAC8sGoCeA9IKVihterXW
         4bAqi7SjPunpFTJCbYMDJFl1zSswSPGv9U1ARwjxX7ae5XGzmY0Yb1iW9ioTbLR0/QS1
         mVrS0DnN1Ep7U6QLQ+xBTWV2l607/Wy62bhcVGbkneZ+xxVeYKKpNTMLz8AfA8nw6whs
         kqKcMgeEXKw5scsc18d7mbbjhto7wyayFe5Xec0N/33GglhpJ9ThaexOm4nzXdOWxYfl
         wCp247JO6QAMnGS+N7+L3/pPKyiHW1XYlW9uMwDdWrBIL6aLYPLOw9UIDXCXqpuHAEjb
         oYGA==
X-Gm-Message-State: AOJu0YxElrGgsE+0rStHBpza1P6EnzbVZQAOENgP1oErwK92wo78UKuN
	JKzKZVEuEAeg9/mvGdsjNlOMnBXTRpPUuW+MWXHgdmaSbBRqNAkMn1c9Lg==
X-Google-Smtp-Source: AGHT+IHQKwWRsQGn0IcCXXXjVs2BRx2EOvcjEy0qZjL33usOlWgL+XiMwGgc0YkYqz7wuzA4bkIpbg==
X-Received: by 2002:a17:902:724b:b0:1f7:124:b820 with SMTP id d9443c01a7336-1fb33f0a61amr14291265ad.50.1720115544687;
        Thu, 04 Jul 2024 10:52:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm125327905ad.285.2024.07.04.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 08/11] hwmon: (amc6821) Drop unnecessary enum chips
Date: Thu,  4 Jul 2024 10:52:04 -0700
Message-Id: <20240704175207.2684012-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704175207.2684012-1-linux@roeck-us.net>
References: <20240704175207.2684012-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver only supports a single chip, so an enum
to determine the chip type is unnecessary. Drop it.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No change

v2: Add Quentin's Reviewed-by: tag

 drivers/hwmon/amc6821.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 546e79ce93b9..295a9148779d 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -36,8 +36,6 @@ module_param(pwminv, int, 0444);
 static int init = 1; /*Power-on initialization.*/
 module_param(init, int, 0444);
 
-enum chips { amc6821 };
-
 #define AMC6821_REG_DEV_ID		0x3D
 #define AMC6821_REG_COMP_ID		0x3E
 #define AMC6821_REG_CONF1		0x00
@@ -944,7 +942,7 @@ static int amc6821_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id amc6821_id[] = {
-	{ "amc6821", amc6821 },
+	{ "amc6821", 0 },
 	{ }
 };
 
@@ -953,7 +951,6 @@ MODULE_DEVICE_TABLE(i2c, amc6821_id);
 static const struct of_device_id __maybe_unused amc6821_of_match[] = {
 	{
 		.compatible = "ti,amc6821",
-		.data = (void *)amc6821,
 	},
 	{ }
 };
-- 
2.39.2


