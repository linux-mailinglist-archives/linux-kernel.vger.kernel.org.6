Return-Path: <linux-kernel+bounces-235011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A01BB91CE4E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 19:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFD21F21DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E68132113;
	Sat, 29 Jun 2024 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmxwatKq"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5017F7C7
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682646; cv=none; b=qQRSL3zaXoOKaueJnTVXgr26XqtRWyszhMoFyy76nP08i6fne5GJFu9mvTnl0vfRJB2SkzpAi90dbir027tJ9VZX8s7SUEfsvt0GB8553zXtuv2n5JlTDVNHeJL/+ITJvIDKhe4nfNpPmIrV0oqINZU3keFozFhbjJDbOda1Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682646; c=relaxed/simple;
	bh=c8tEfkAtGF1gUqfv5kyTS9nMxkvSRaMoEFZ6Qw7uaJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqF6Bkr+dvlK4DvLTC3hYLvqLNVgpPAK1R6t86/Zp9PkjgiyUcHG5oKngpsFLGlJfCN/TYWQZA6ZEVtWWE5t/bMCIEwfW4KvCcwxeckk3DRC/PoDDyeW3DnbVJJKMPn68ZkLnN1KeRdwc00qYMw1F1CLYUAxLh3nV3+l1cMTtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmxwatKq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70671ecd334so1269155b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719682644; x=1720287444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmJdXtzsjpLKqTnFR8Zz+8rIPdRO0oZVDYbxd70MJsU=;
        b=hmxwatKqC8XbAhRP2N8ir+81nC8zJ49Hcb6gYJs8EcTPSJ9m5O5Kxap+t8XMWRF1hB
         iUq0PYRuUuZk3iLK6pWcIPxq+y1Qc3pNsrYZ+JSyf7Pl489VRA7pcIZGyksZdtCryvIM
         MwoJmxcPHhn0FYge1qMhNFVUje2hiXV3K7RFftck6HsoNpjpG4386MzG1A9SaiqL2x5Q
         ZLUnqpIyJf0ezK+IM+58Q6fz1A+LvUkvqwbLmUthAshReQQJOZGNzE3VMsfDbOO6qp9C
         ghhhz7dWL/YC1fcS4ocah8SdN7jxGKM5AYRpIXvXwvs3+GA0Wp5b5ktAZg6qJNLMhX9Z
         K5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719682644; x=1720287444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmJdXtzsjpLKqTnFR8Zz+8rIPdRO0oZVDYbxd70MJsU=;
        b=rU6vJvSgQ9/oz1WKaSlOl7zdji94oz6u2SXUEU4IiPCsgjtSnM41ym4EsFZOo37yHz
         YLY12CpHDotk/fgeCl+vrjmlDFLvTPUE7vIdaXzwUPjYsxuk1A/G7/eWzo6abrLSP6Q8
         3jeANZjmgCYJmwzPHGFPBaxXtewNd8q+gOfjLr5RBNu5mzfCwrXbud8lQjtPnV1o4OeU
         OGW0PXjafTo0c4WByo30gLdm6/tiixTPFWza13Hg3QFfhQ7J6VVsccRrBwqhERt4Q+17
         zYtEreYEpRddhhMqpojpq3CPnisOiukTB8N7kCPZvN04EHBemLVTb7LmNtsqkxqdfMk5
         GZiA==
X-Gm-Message-State: AOJu0YydXvm6CCcUxgszLq75sxDI7BbirmWcSg42hIpgHSj+bjqSWR9N
	schUx4fDROhgqyHSYFtkPhJPDsFClMFz41C+6ULT9Jx/bMo/sedyIvaBqA==
X-Google-Smtp-Source: AGHT+IFdq2zaTRrp3k3qyEZN5dvjzgZFcP+adrH5D0YYEpI2P38BH8A+jJFgJ2rGVZ15vxeUwkQ/dw==
X-Received: by 2002:a05:6a00:2308:b0:705:95ce:cfd3 with SMTP id d2e1a72fcca58-70aaaf1f6fdmr1597999b3a.31.1719682643775;
        Sat, 29 Jun 2024 10:37:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfae8sm3531233b3a.107.2024.06.29.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 10:37:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 2/2] eeprom: ee1004: Instantiate jc42 devices for DIMMS implementing Rev.1 SPD
Date: Sat, 29 Jun 2024 10:37:16 -0700
Message-Id: <20240629173716.20389-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240629173716.20389-1-linux@roeck-us.net>
References: <20240629173716.20389-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DDR4 DIMMS implementing SPD Annex L, Revision 1 do not implement SPD byte
14 (Module Temperature Sensor); this byte was only added in revision 2 of
the standard. This only applies to DDR4, not DDR4E or LPDDR4, since those
DDR types were only introduced in revision 3 of the standard.

Use this information to instantiate the jc42 device if the module is a DDR4
following SPD revision 1.0 and a device is detected at the expected thermal
sensor address, even if the Module Temperature Sensor byte suggests that
the thermal sensor is not supported.

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/misc/eeprom/ee1004.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 71ca66d1df82..a39fefb066cd 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -187,14 +187,31 @@ static void ee1004_probe_temp_sensor(struct i2c_client *client)
 	struct i2c_board_info info = { .type = "jc42" };
 	unsigned short addr = 0x18 | (client->addr & 7);
 	unsigned short addr_list[] = { addr, I2C_CLIENT_END };
-	u8 byte14;
+	u8 data[2];
 	int ret;
 
 	/* byte 14, bit 7 is set if temp sensor is present */
-	ret = ee1004_eeprom_read(client, &byte14, 14, 1);
-	if (ret != 1 || !(byte14 & BIT(7)))
+	ret = ee1004_eeprom_read(client, data, 14, 1);
+	if (ret != 1)
 		return;
 
+	if (!(data[0] & BIT(7))) {
+		/*
+		 * If the SPD data suggests that there is no temperature
+		 * sensor, it may still be there for SPD revision 1.0.
+		 * See SPD Annex L, Revision 1 and 2, for details.
+		 * Check DIMM type and SPD revision; if it is a DDR4
+		 * with SPD revision 1.0, check the thermal sensor address
+		 * and instantiate the jc42 driver if a chip is found at
+		 * that address.
+		 * It is not necessary to check if there is a chip at the
+		 * temperature sensor address since i2c_new_scanned_device()
+		 * will do that and return silently if no chip is found.
+		 */
+		ret = ee1004_eeprom_read(client, data, 1, 2);
+		if (ret != 2 || data[0] != 0x10 || data[1] != 0x0c)
+			return;
+	}
 	i2c_new_scanned_device(client->adapter, &info, addr_list, NULL);
 }
 
-- 
2.39.2


