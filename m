Return-Path: <linux-kernel+bounces-172951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842948BF936
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F191F22557
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63526745C0;
	Wed,  8 May 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN1VOhdC"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A3E46453;
	Wed,  8 May 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159014; cv=none; b=CS4JFjQDrF+yFnMNogpShxqdcugOylNIyA+D16VwnA6rwJ5+6KIlpn/12TrKvp06QN3CSv+bE2MCdWKfyCxcl8D4G7jH5xk9vm4r6OJy7MBgan81tjTOIu+P/x378LQqAAOeJoidpSxp/0D9A7tZGEygfGTHEmt+wpyjcwnh20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159014; c=relaxed/simple;
	bh=s731HBITi0RYZOcqe9figMR0m7ZcUNj0pHu97s8h1gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o6YsVWbiSk0y8y6Lze055jXzJS3YHit4Sb9NKcYuhQaGF0Fc1QG8wZzcjjSKTysj3uepH9PF6IbIQ7mQke6w5+P0/TCunGzeO3lIeiywc9dWtqrrzlvZnX1CNm4vxmxYZd3mZDIfK5TR3p2m3DZicyyB1Kjpfxf0EdnuGxEhVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN1VOhdC; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b25cee6b7bso43433eaf.3;
        Wed, 08 May 2024 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715159012; x=1715763812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGwO4RbZLufvPKiLWMMe9REjnYA+cENSyvJV7q1Xfe4=;
        b=hN1VOhdCTUTRO41MMemf6UjFwDi53oU7dkFTxoWSfomDlwUS9wbZ7hkYQUAFqu+skN
         NYhBh9DdX65zltd0sMZK0c5lWLxvZQ49oIXffjVp29bYIZecYrm6/JY7fO8YBZn1CZeR
         y7ca0/ekB3btVQ3sfaM+mOTkRsrkul+oV+GA8axVqnP6kNS7UVONBvrPGsPXSFpLfFDU
         VBKBKOlzJ7bXwvPs4xzArWdYQghudFFj3eiqWtQ2Yzsqjx7eS8pDXCJQkkB5R4neKIkS
         XHKUo3mtZR1Nqo/Dq8j/62PZ+27jQ6Zwu3fsgEtjsUBkxW9AJOQcNE/ta2ua1PYlJTn3
         entw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715159012; x=1715763812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGwO4RbZLufvPKiLWMMe9REjnYA+cENSyvJV7q1Xfe4=;
        b=KWdkfkp1o86hFYP2iY1TEujsOjOSqgaZB++7aNwfQtLLpI2eFuCyEy0K1iJKGAhXeD
         Sib3Ef3QE0E2bZjNFELJBE4xjyZeYYkih+R/7G7X0rxHBJehhskDxFu9jg35U9CnurZF
         +c9JmfI4BwhtH8JnRjpHtHdoNAB2OyzBZa1I4R5+SAFBzwAZ/+voie6tAI0HsiNNEUH3
         3yGkHtar1+LbpFcgRmkw+NcF2Scvo/qddzi1aSJRvu0Ky3fapNFY801C1NidoucWR5ff
         qoFQxHv5B3u7FJC6nwSoEv7x0kjZuaRUyp4L4FY+b4T86cuvR38oZM6+eGLdl2kbvCUE
         3HRw==
X-Forwarded-Encrypted: i=1; AJvYcCVsOcNy0Mzhf1OuPtVOSoSLBsPBS0tmdMQEMmipDldEigYV4khX05ZAQ9Ym4FdE9ro+P8q3Sd2dvzLWo0v3q30Ka8BQaUi5pxZtP/Ry+s36YxuFDJv+C0p89HkLaaaHtI30tIIAXSu4Ub4=
X-Gm-Message-State: AOJu0YylVj3N+IWy0m9zpQpW+CpHXZXIiSKGjqbiNiweK7Hm84VcuY7D
	aJHQBK0q/kAnVsrIrONEO1bWikcXWeoypa/EkeH6/hj1rSG4/uH1
X-Google-Smtp-Source: AGHT+IHLL688krszvkStk4yQf4dQ9TFpItgwhUvpktcU1LzDUKJ4gHENdV3+E/yzrr2Np+1XhNjjig==
X-Received: by 2002:a4a:5143:0:b0:5b2:f7c:a711 with SMTP id 006d021491bc7-5b24d68b2d0mr1722571eaf.7.1715159012349;
        Wed, 08 May 2024 02:03:32 -0700 (PDT)
Received: from localhost.localdomain ([75.40.203.101])
        by smtp.gmail.com with ESMTPSA id l23-20020a4ad9d7000000b005b20b55d996sm1371373oou.1.2024.05.08.02.03.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 May 2024 02:03:31 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Aldea <andrei1998@gmail.com>
Subject: [PATCH] HWMon: LM80: Add "support" for Texas Instruments AMC80
Date: Wed,  8 May 2024 04:02:44 -0500
Message-Id: <20240508090244.18070-1-andrei1998@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for AMC80 which is register compatible with LM96080 and a result of TI's acquisition of National Semiconductor

https://www.ti.com/lit/ds/symlink/amc80.pdf

Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hwmon/Kconfig | 4 ++--
 drivers/hwmon/lm80.c  | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83945397b6eb..f901ece2ff43 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1446,11 +1446,11 @@ config SENSORS_LM78
 	  will be called lm78.
 
 config SENSORS_LM80
-	tristate "National Semiconductor LM80 and LM96080"
+	tristate "National Semiconductor LM80, LM96080 and compatibles"
 	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor
-	  LM80 and LM96080 sensor chips.
+	  LM80, LM96080 and Texas Instruments AMC80 sensor chips.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called lm80.
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 63c7831bd3e1..0355b9d849be 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -573,6 +573,11 @@ static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
 			return -ENODEV;
 
 		name = "lm96080";
+
+	/* Check for  AMC80 version which is register compatible with lm96080 */
+	} else if (man_id == 0x80 && dev_id == 0x08) {
+		name = "amc80";
+
 	} else {
 		/* Check 6-bit addressing */
 		for (i = 0x2a; i <= 0x3d; i++) {
@@ -624,6 +629,7 @@ static int lm80_probe(struct i2c_client *client)
 static const struct i2c_device_id lm80_id[] = {
 	{ "lm80", 0 },
 	{ "lm96080", 1 },
+	{ "amc80", 2},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm80_id);
-- 
2.39.3 (Apple Git-146)


