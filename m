Return-Path: <linux-kernel+bounces-242923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A1928EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4F51F221FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C617839C;
	Fri,  5 Jul 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPmutUTi"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9C178362;
	Fri,  5 Jul 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215366; cv=none; b=Fv3tIoSvOTQyymZY4L2xT+fwFkRz3wEnDf0Qxn8zR64VvdHSmQ/R/vG7WvHAK3hTQHwu0FHDGcWpCJUjq/iLU29FLx/dSjNbQOxF9+7wyQah9mASxoUH4TWzITg/CoEDIlBK+wiY0dqlrODltvEdtJzyCaABLa1VIS+PpwuNAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215366; c=relaxed/simple;
	bh=/RCAUbefpYKE/b8H1Gyrl9DlI9VbcqWbYyYJ3luPzm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8uOszQGCI6E4k4CeHva97JgEA+VW/5D1PT4NFLxjBhJgUhB9LLpHX64J5qHp71utQ5Qst7PAqMHfK383NqyvQOUf+ak/CaDZIlhNmRYckz24fMXP3MikTMzS49RnDDTGmctCuqWaCrW/LiPhdGeXvgpHFeqEX9VG5uXyQhuyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPmutUTi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4a5344ec7so14898305ad.1;
        Fri, 05 Jul 2024 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215364; x=1720820164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoi1PhkWWlISEqPnYs4kDHO26DAH2dENmkm3aJvpzr8=;
        b=mPmutUTiI9fp+WNxLwBQAIq7N4PTAqsICWF/coEeT5QwxFffbBlxijujizfdgFQ48e
         S7n0zouFE0iGyTog63bXcjZDrrki+7//uGjCf4mo+CDnX/93H+wASO9mRfwZDgvPh2gY
         vhcjySxYYgLecRji+IauqkPUnkTqedNKDLkK67Y3Tjr9A2MT2YZrYgRURixBD4ECN0LR
         P4u1A8N3NYSRewRmrCFb6k0I96J1E1XuatjkxzeXiIajj/N/1XPkBqJleRk/axtWJ6Rt
         41hLpHyVhZXPd78z1YZVrlQJkEz5wn+EIC6BWNFnbuUROIoVBYctLONW5KImxMz5LkOO
         24sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215364; x=1720820164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xoi1PhkWWlISEqPnYs4kDHO26DAH2dENmkm3aJvpzr8=;
        b=Y4Ml7jKvyx2Sy5LuyoMii027YGZbcbYqnlk/4FI+2FBZm3pWSoiEuRfWMy4BaZwuwG
         EWx1UpjPpVtYLH2R4n5pmdFscTjnaqCsOxl7nYb0b50YrfhC4PN1blOO1z0OIJ4O2NWc
         7VGz2R9RScMP2pkmnIy9/TicnTTSOLMhBajjiEtNrp8r/nYAXWU1aRNeCZsVhSzqZ42y
         RoX2F98roTOWQt6OwWfMFsvXrhiGAt1XoBW2elYOegBYf99hOhfB/yObhkzFgYPH7oou
         uM7Iwrb0yuHe1f09kSpZwkgH/KgDYnEp3xAj0ENsq4urZlC0bQvGZD0UZcpOSZVIXizo
         2qjA==
X-Gm-Message-State: AOJu0Yytw6btGbUYLfE7ooMpuDD9oX0zoRUJ63VDV4hoUYVq1LsOKq+d
	3P5MuzGI8jap5vEW6GtoQ5hHcaQBbypNxdkB70hk7AIeXSnxapatbWtdgg==
X-Google-Smtp-Source: AGHT+IFTNAa+Lh4CNPsBYrsH/T85fKPSC0c4HWnYYq9D7QtjM5BD8ARohEjCm+EW3pG/KN9YTE1slw==
X-Received: by 2002:a17:902:ec90:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1fb3701641cmr92193925ad.6.1720215364499;
        Fri, 05 Jul 2024 14:36:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb29e29881sm42485595ad.299.2024.07.05.14.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:36:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 08/11] hwmon: (amc6821) Drop unnecessary enum chips
Date: Fri,  5 Jul 2024 14:35:44 -0700
Message-Id: <20240705213547.1155690-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705213547.1155690-1-linux@roeck-us.net>
References: <20240705213547.1155690-1-linux@roeck-us.net>
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
v4: No change

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


