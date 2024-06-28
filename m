Return-Path: <linux-kernel+bounces-234105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F180491C245
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E32F1C221B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D97C1CB328;
	Fri, 28 Jun 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWN+KvVW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D451CB303;
	Fri, 28 Jun 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587648; cv=none; b=dh0Sc8Yguhpt2sGDDsO463tJlDc/HlFyVDvp+JwfgA7/UKHnih++HcMmcrfdxL/ed0sxbwG2P7KFoWYnGvMMuQQ02IsinMoBiKsusYdL6AISlXT6GwRj7Lk1ZH3SRba+rKjcCxOfB3j+hrVcZkXOuxgUsNUGS2BNh5IIjNV0rvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587648; c=relaxed/simple;
	bh=S1GqPUeD62e+cLY6wRun1LgVGPMovWQtBrE+LAucsdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NgIIgDJYe2/VyP/zZHst396ittQdScaFJ6e+4aFbwEk7lpeYWbgeHhZcZ5Efho5QohN93eOH1ZI4SKso2rGRPyAQ3+4raJz8upAeGR8Jnuek3KjvkqRJSxiUS8VFH0YWQYkRAQMAU9TocvNkXBSPV58A4b2duC+QBMwjTqmOcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWN+KvVW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9ffd24262so4689235ad.0;
        Fri, 28 Jun 2024 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587646; x=1720192446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YheIpGNRGqJ0fUYQU2ae3gFEDlB9LZEMJcvfRhzF7CQ=;
        b=jWN+KvVWArul2g/nJL6xsS8kbZeUFbzRb6vQZyrojlqh/cRq32Zq5A58YihAWOyVZQ
         +cn7fXQ36WOhfrb7H8ZPdcWdtkZj6sU8MrjxiqhbIv/2K8h6OOMH8Ufko2wOx7zHEWvc
         MF2dPow2UDONfVeCkUEDzF0Rt43x+/0/uzkVeePLRj4nhOa3ds1SVGNOmcWCRhKLBTQJ
         EXBzD1uwyBLwTv1Tb4g7SX1HQ55kXIc9Q/bBF96QKM7T3mI1jysLzBT1Pxy4bIo71A86
         Xw8iDZF1OKJojdf5e78Ltw2whkKGBOpw5RCYG485wTkIv3/1dz4Mb9pxNKyj19JHX0d3
         6m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587646; x=1720192446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YheIpGNRGqJ0fUYQU2ae3gFEDlB9LZEMJcvfRhzF7CQ=;
        b=Bwf1zpKT58EJe0eIY/lWk0uESTJlzNxL1jsGGCTuBguLSPvKLx+0vjC8ABbKyfDDHH
         16K0T08N8y5ch2ak/2ti/+gN0khQn1IxsLhQBGXZWQ37rmCOmq+aSmj9CMvoho6YUxKh
         Q1MC1uk1Eqgu04cM2LoCrph9NirlC0b8/PtgqG7w8YnQuWcAXRHzye5rAxw/vgXze4HL
         bOONXPBA63UQ+9+HshVQfvnoIRHEId7lSuD92SNiJQSk+y42PBprzaU4es5Z3sOzqLaF
         4jKm4Im1I71/xhnlOv0usq03SGfBNzm8b1W0ZqOJ2aniGCwMxcIAzSoSkfwr03oGvXf8
         YVWg==
X-Gm-Message-State: AOJu0Yw8UM9Ky1eX91SL96lCPVv+TlFIeTy9066iaH2DKJsrTihOpxeE
	T4HgVTq/JmzqLHRqm0lw2LPjJR+6kcCvd1tNzNimqtSVxkBewHJpdyTmNQ==
X-Google-Smtp-Source: AGHT+IEVxF0VQbhf4Ltareoctw6e4hLu1XIBgtCDncl2XYgMAydhYgvi0JQ6RgzCGo6tnDilQzXQcg==
X-Received: by 2002:a17:902:ce82:b0:1f9:9c40:edff with SMTP id d9443c01a7336-1fa2413d3b1mr176875685ad.61.1719587645973;
        Fri, 28 Jun 2024 08:14:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15966b1sm16447705ad.262.2024.06.28.08.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:14:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/10] hwmon: (amc6821) Drop unnecessary enum chips
Date: Fri, 28 Jun 2024 08:13:44 -0700
Message-Id: <20240628151346.1152838-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628151346.1152838-1-linux@roeck-us.net>
References: <20240628151346.1152838-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver only supports a single chip, so an enum
to determine the chip type is unnecessary. Drop it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amc6821.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 042e2044de7b..ebffc9393c3d 100644
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
@@ -943,7 +941,7 @@ static int amc6821_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id amc6821_id[] = {
-	{ "amc6821", amc6821 },
+	{ "amc6821", 0 },
 	{ }
 };
 
@@ -952,7 +950,6 @@ MODULE_DEVICE_TABLE(i2c, amc6821_id);
 static const struct of_device_id __maybe_unused amc6821_of_match[] = {
 	{
 		.compatible = "ti,amc6821",
-		.data = (void *)amc6821,
 	},
 	{ }
 };
-- 
2.39.2


