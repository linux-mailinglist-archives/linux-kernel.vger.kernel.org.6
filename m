Return-Path: <linux-kernel+bounces-235010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7721B91CE4D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233D21F21BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7278627D;
	Sat, 29 Jun 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Id+27TI/"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346D22EED
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682645; cv=none; b=fVCu9bR0Sta9JtPSX6zHNUtxsR9dKWt+0E1GktZGSKDVB7Z5kebD1ivwOQEF/l6cey/rQB9Y7Mf88muY0hSPMwpSdFqxyHBCYKFibcka/NLsTVcrMMpB9C6NH0i1nK34I3lkldQYQiaMeRb/kRyPpeF8W/tufVz5mjOuoArHHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682645; c=relaxed/simple;
	bh=po9rzpls163ObvGrC011mX3OBNZRvpOHh5ExtFcEFpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M45OcAgpMWqIuvhBN71Mc/pAUw0OWyJbUNcveogwWt7X6X+tp2VUIJRqtKwIwrkslfmajoOR6YIsGEjh/UKqlqW5Gk/HTr8RABKYxlMqIEMakQkJm+WXhyASUNIjhHOGBuFFyQ1jMkfaY+OYyocJ993G0nDsv0vxMUc2OLnP3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Id+27TI/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7065a2f4573so1216519b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719682642; x=1720287442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jep97BOa7VJh+Xmd++JB1zeDfCRLQSC0lDTuX05moXw=;
        b=Id+27TI/cY9H0mIhh4oZhlRGK6xNaZiZ3UcUT1Cz6vM9u6TjqKYtW97Mh6CGafDurz
         U0/gWDj5KW2rHat/yPunicayAeal6vyRlxtE/HN+7vlFMGbcKjGSWhk4BWwxKlt5I/yD
         ptkLlNJ4SRWJgilCEOkW90/s1j/UyC4fYbDPudeHAKvelVPtL0SGQWKUmS9aBFk/R/gK
         kRUTJcmIuMv9sTykNq43DUQNIhI23qaGhnpOYSoRUsugax2bvHdvHprAtwiWLi2rFfx6
         nEwtszaaeiGENK5TnC4n5rgkakxOFOHdQsED/y4pkXcwS4/8AATsvYmTtm14GNEIAH3F
         2ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719682642; x=1720287442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jep97BOa7VJh+Xmd++JB1zeDfCRLQSC0lDTuX05moXw=;
        b=AX71EWPzrW+nJDaTMP2dq3Sx0VSsBdb2CBN8o54MLVhK4htjmlFm2LZn7dnIi6HH9O
         AkNwOztMhSJ03EEgjxW7lYJ6khAA5wrLTx4v5IuPyyQBnTH+3R541OrsG3PBk6Otsilq
         6rVWvwvtzwfTKthWgHteiDQL8DoTpxnL8a2ptAG5HVLxrSciJvQspDdVegKfb/cObMh0
         hGts7bgv4x5l92DvOqzJYHhwQhxVJD2WPSkthIuF9wNtLgSujGJ1z8lRe5LM/6EDR3+O
         PCHqfQcuZgtCPbhfzXar6kHSMh97fQ7usWPzNeCA+BIoorjLwLxxr6Nx/6Yhp9k/c0Fb
         +9jw==
X-Gm-Message-State: AOJu0YxSs8IWV+uPV2hTtZUt4xZn7JCEWvwEzUMVMoqza9Y/LXoKIgWX
	uTTCyiVrZfqfg1lYLxcSt/Fgs6GY5aKZiAiMf/tbJL9mgGQCM0K6lUmw7w==
X-Google-Smtp-Source: AGHT+IGJDk5SHzDSfvNBPiJ4gdD1SqvDzkyi+r5kb53fe/rfshYtf7r6rbvZSBQK9YuOBxbmqfLS1Q==
X-Received: by 2002:a05:6a20:3d89:b0:1be:bf70:4143 with SMTP id adf61e73a8af0-1bef60e3ec8mr1627456637.3.1719682642065;
        Sat, 29 Jun 2024 10:37:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d970esm34738285ad.115.2024.06.29.10.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 10:37:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 1/2] eeprom: ee1004: Call i2c_new_scanned_device to instantiate thermal sensor
Date: Sat, 29 Jun 2024 10:37:15 -0700
Message-Id: <20240629173716.20389-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instantiating a device by calling i2c_new_client_device() assumes that the
device is not already instantiated. If that is not the case, it will return
an error and generate a misleading kernel log message.

i2c i2c-0: Failed to register i2c client jc42 at 0x18 (-16)

This can be reproduced by unloading the ee1004 driver and loading it again.

Avoid this by calling i2c_new_scanned_device() instead, which returns
silently if a device is already instantiated or does not exist.

Fixes: 393bd1000f81 ("eeprom: ee1004: add support for temperature sensor")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/misc/eeprom/ee1004.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 21feebc3044c..71ca66d1df82 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -185,6 +185,8 @@ BIN_ATTRIBUTE_GROUPS(ee1004);
 static void ee1004_probe_temp_sensor(struct i2c_client *client)
 {
 	struct i2c_board_info info = { .type = "jc42" };
+	unsigned short addr = 0x18 | (client->addr & 7);
+	unsigned short addr_list[] = { addr, I2C_CLIENT_END };
 	u8 byte14;
 	int ret;
 
@@ -193,9 +195,7 @@ static void ee1004_probe_temp_sensor(struct i2c_client *client)
 	if (ret != 1 || !(byte14 & BIT(7)))
 		return;
 
-	info.addr = 0x18 | (client->addr & 7);
-
-	i2c_new_client_device(client->adapter, &info);
+	i2c_new_scanned_device(client->adapter, &info, addr_list, NULL);
 }
 
 static void ee1004_cleanup(int idx, struct ee1004_bus_data *bd)
-- 
2.39.2


