Return-Path: <linux-kernel+bounces-168567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643878BBA41
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A35E1F222AE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814E1804A;
	Sat,  4 May 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzy6H4hR"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115CC171AB;
	Sat,  4 May 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714814736; cv=none; b=SEHQyAjE0QTU3MgBCuZToWWHiEIqNo1qt1DbDiKZgViBqPi6tdp0dHzet/mDf5Iws55AIQCYcm5WP2m2SoI/w/OHqMzK64XDVP4UEUP0FNze3j1D+rQYZF8YVqjr8tCeUHqk5c/Zz+KzLgHZHHQIsEIbf++c97LDuuiLNQKU/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714814736; c=relaxed/simple;
	bh=lgWGaO6LzlXcstlxO7ac8VqYmC+yW7DzTwsyoRKraBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQvjchf+UjejEJbmmSn3rH3rKmQ7EK/GExK3MA7kVywvrh77mp77Ym5Tw+gqiLoNjQiEXn1eXI3peYujcGKv5JqYVFsbEaU1kE9FaXa4COUqVJ8QQAcyKZxZAg36mce1MOI9WmpFvR4Q8COxpKjIA/vfvpLRLqU569RfvJUlY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzy6H4hR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599a298990so85788166b.2;
        Sat, 04 May 2024 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714814732; x=1715419532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVm0kTAiGaEirihJCdLOzEWROOpujxuN0/MjBFggZ0I=;
        b=Mzy6H4hRGV5+1zzsHQ/Lrqxw9DSr/Kyj4ktC0iqIPEi9zEpzzY1sFXYGLFJT63Ypyq
         e4CZeKjp+b6mAdMYBW3O2Q1dSGdDnjX6bcMXoSm1zqZld7/0Q3z4CX1YGcvyZjcXetuv
         JwKlTkzWeHDpogB6sORSpXJ37+wEJ+qQ3FJ+jTN0Phnx3UBOWuPWY4uQUZxixl9kyOLU
         CqGBmAzCSTGWiS91stfo67roAEttcrnsF3UumF7xoZ3kC3GuKfwJ5gbccHib48w58PrP
         geVFtqTfDpkOKMS5HB/PwWzr891rU55DyWov3NNkhtrYze0XJCvRnNZhLs1PpkpiU0oX
         l1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714814732; x=1715419532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVm0kTAiGaEirihJCdLOzEWROOpujxuN0/MjBFggZ0I=;
        b=Vtsh8IPqwRW2vZW9mA/mM8RpsiZZwr4hwe8w+hIWl7UtGOa45dhxv3tZjqYy1zE8d6
         UQzR9Pwwbk3B7I4lbhOr0DSGV3ahwDoUcDj+ImktXg+etg+DSVZpUrIZDLCCIthj/YST
         Tl36JYbZHZV53gbTDxLntMjDk12lI1GDBNmfs6NzeK+ecQ1LV66yhPE8DchwT6hDzWA5
         huz047IM9aC9acMuX4TLRoJz+uDNKmK1AVpVLI1ubgelSWGo2AdSRzMmUmNqgeoxz8+u
         8iherks/HEDE8Rt+Bl3DQH7YejFv1+Sww0EcfaURGqQy7UkO1p4qsQHKBXnKtWPoPoO8
         oRqg==
X-Forwarded-Encrypted: i=1; AJvYcCXlHT/3uv6CfxGXIUDBblBMd6mAPs4aUDjs0sd3cCBNFZJoc1S7bkLY4EVSPUX5l+uQVO4o2mtWKEZ33UfJqMJSHfCiASQTgSj2nBoa
X-Gm-Message-State: AOJu0Yy6nQRe8EL04o++xjpQ3ycJkt5dPqNSq/R9Q0WdU21mYbOguHEI
	hWobTN9wkB72bGPFJHz5CklXsIxVUbt2YP0az3jElu4zqobdrYJlxBo7MfPWNGM=
X-Google-Smtp-Source: AGHT+IFbOC91SBKTGN1oeeVamJxzS6WsH2BACjEdDuCbveB+0eGoZho1TMdWA2zGr5BY2LNigDYz6g==
X-Received: by 2002:a17:906:a145:b0:a58:832d:c3e8 with SMTP id bu5-20020a170906a14500b00a58832dc3e8mr3248087ejb.58.1714814732249;
        Sat, 04 May 2024 02:25:32 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id ce3-20020a170906b24300b00a587831c09fsm2740231ejb.186.2024.05.04.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 02:25:31 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Jonas Malaco <jonas@protocubo.io>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Marius Zachmann <mail@mariuszachmann.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (corsair-cpro) Use a separate buffer for sending commands
Date: Sat,  4 May 2024 11:25:01 +0200
Message-ID: <20240504092504.24158-2-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504092504.24158-1-savicaleksa83@gmail.com>
References: <20240504092504.24158-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce cmd_buffer, a separate buffer for storing only
the command that is sent to the device. Before this separation,
the existing buffer was shared for both the command and the
report received in ccp_raw_event(), which was copied into it.

However, because of hidraw, the raw event parsing may be triggered
in the middle of sending a command, resulting in outputting gibberish
to the device. Using a separate buffer resolves this.

Fixes: 40c3a4454225 ("hwmon: add Corsair Commander Pro driver")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/corsair-cpro.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index a284a02839fb..8d85f66f8143 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -79,6 +79,7 @@ struct ccp_device {
 	struct device *hwmon_dev;
 	struct completion wait_input_report;
 	struct mutex mutex; /* whenever buffer is used, lock before send_usb_cmd */
+	u8 *cmd_buffer;
 	u8 *buffer;
 	int target[6];
 	DECLARE_BITMAP(temp_cnct, NUM_TEMP_SENSORS);
@@ -111,15 +112,15 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
 	unsigned long t;
 	int ret;
 
-	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
-	ccp->buffer[0] = command;
-	ccp->buffer[1] = byte1;
-	ccp->buffer[2] = byte2;
-	ccp->buffer[3] = byte3;
+	memset(ccp->cmd_buffer, 0x00, OUT_BUFFER_SIZE);
+	ccp->cmd_buffer[0] = command;
+	ccp->cmd_buffer[1] = byte1;
+	ccp->cmd_buffer[2] = byte2;
+	ccp->cmd_buffer[3] = byte3;
 
 	reinit_completion(&ccp->wait_input_report);
 
-	ret = hid_hw_output_report(ccp->hdev, ccp->buffer, OUT_BUFFER_SIZE);
+	ret = hid_hw_output_report(ccp->hdev, ccp->cmd_buffer, OUT_BUFFER_SIZE);
 	if (ret < 0)
 		return ret;
 
@@ -492,7 +493,11 @@ static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!ccp)
 		return -ENOMEM;
 
-	ccp->buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
+	ccp->cmd_buffer = devm_kmalloc(&hdev->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
+	if (!ccp->cmd_buffer)
+		return -ENOMEM;
+
+	ccp->buffer = devm_kmalloc(&hdev->dev, IN_BUFFER_SIZE, GFP_KERNEL);
 	if (!ccp->buffer)
 		return -ENOMEM;
 
-- 
2.44.0


