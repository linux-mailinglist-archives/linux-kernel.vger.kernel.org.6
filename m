Return-Path: <linux-kernel+bounces-396902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA409BD3F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BE61C21641
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC81EBA0B;
	Tue,  5 Nov 2024 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qD96r/mu"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB91E767B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829553; cv=none; b=I1K3OuBn+3db/8VFeqRWM1C4SeKDDVIBOs0iGaPxZ+AAHzMqbNBHtXVDXjSC5fg14yFUS4gWaYYFWNZJ1vKFJ6HDet9jWvsbTT8HXzIQu7ybCqvfehlZkNdIWs6YZKRRqiqPGU7SHTEkzM6HSqIL9RzUppsONRm2/MnX6wuQ2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829553; c=relaxed/simple;
	bh=blkxgaw3FfNXe5qFy6oCyV+Ises7jYWEDEIlip0Y28k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXGFSj5N0ifIcxI0Rv3t2qufpv0DPzfR6hxRrXQ+ZBWes5wabLRAMYq6IZA5uI4dd5yrGaOmjB0KXOpwqqT85gWvxyiqZEoNJPbAjK9Vxy4fVH8vXET2mO44oFolc51mHkb+RElNtgEWpuGipVtwi7xDd3xH3PbEjptnQTB8d1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qD96r/mu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d50fad249so4221462f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730829549; x=1731434349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRZTein2iejLD0jO7Feumj0yibShIZCILBcsFIBeWTA=;
        b=qD96r/muzgjeydydqvomogu5659hGtYqgYtM1R6h5xGGNuE4DagIVQB+ypaVqjnQ3v
         U++b12wTuHODtBcZ6Hx0lbVNmGFctQeKaeUNRyEXAKSxc2LeIG4wVcsCRe7Aj7fIOqtl
         q7aEMvNlSZ1XaD0Him+kx8i0psNgtJlgcNi4SrDhuI5tBQYXzH+K+LBnWzmqbkTzQ4B/
         wp26SgkAyxuM25a4LG8g54VEfdT3yNLn8w4c2b21w/tu2ZUv1JxIn3MmI9WA7vmG/wee
         5mWP/IYjLKEIJXS9RWlC1t6dvl+2N/IhqTroNXYbI0wOmfof5KH3GRZeYuaXD3jKM6Ob
         6zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829549; x=1731434349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRZTein2iejLD0jO7Feumj0yibShIZCILBcsFIBeWTA=;
        b=i1DsZKkgsEaSJpvLDqVFdVTQGWHD2uMgCLGtl16+fY1mxPo4PcZVfF9JZVeTl6sqw1
         9SHi+Sn+mSBamHoecZAai8reneLgWA4Fj0OT6gC48ghz3ztCSOIb0z49Oj2YCLoU7jJI
         SUnRv4VNS/UM+p8250anTnFi+3/vlZdiM3fXAqu7qEhiDY8gHEnopzFkcH1JAK3mWqeU
         IeQJQHJpVupGqReBDEHxxbUGjb7ZAoq138oqfcmDHuobRjVuFWGJGsg+zlkyVxLoBo6P
         e9bd2l9HZBWigNe3FCEt4CjBi7bZ2LbvgRxA4Y/D5/416hxfYDwGnjBTCBQ9esxTFCBC
         JVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhWmG5e0+TvBqjG5R6M3YO6kQISJFNReAMj8WvHQynLIYKQAckRCBCHJCWqHNuPiMQ4sFWWoF623AzqoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4I5celwGneEI+oWL+ioyl+Gzl/zMfxdIGxncPG95a1s5U8vNP
	XAHY01uSLOU7JbzuQi8Y2lplAOMFHyYfXu4tpzIkqbdBVxGPv8KEoLh0eUUBl+I=
X-Google-Smtp-Source: AGHT+IEY2h4jc1Zm1Rk5wnyV/YIKmL7H5V/VsmYC4s+Yx8ZJ44tJtgazn3z35+0xJ382Dlxcx3VEoQ==
X-Received: by 2002:a5d:614f:0:b0:37d:398f:44f9 with SMTP id ffacd0b85a97d-3806115ae92mr25370869f8f.32.1730829548819;
        Tue, 05 Nov 2024 09:59:08 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5b9b:df02:2761:7a57])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113dd7fsm16959481f8f.70.2024.11.05.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:59:08 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 05 Nov 2024 18:58:41 +0100
Subject: [PATCH v4 4/7] hwmon: (pmbus/core) add wp module param
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-tps25990-v4-4-0e312ac70b62@baylibre.com>
References: <20241105-tps25990-v4-0-0e312ac70b62@baylibre.com>
In-Reply-To: <20241105-tps25990-v4-0-0e312ac70b62@baylibre.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Naresh Solanki <naresh.solanki@9elements.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-i2c@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3519; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=blkxgaw3FfNXe5qFy6oCyV+Ises7jYWEDEIlip0Y28k=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnKlzk4/DtTeS4s8rp8GQKXWv0M84dnNVRYXywc
 KLscGYjrhCJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZypc5AAKCRDm/A8cN/La
 hfXmEACEPl8edKV+/0eR/02ln3esdCYcQDCTc89WOyOdLH6YYYq798/VooLFgkEV3oSfi+4lVjA
 htUoaE7BeWCT+E5iNFlooJIimzgl37h1B3QvrfR8o6O6uwJf8CsgPZNUsvotVk+U5rCr3OR8T++
 Hz6KoGk+Pgj0dO3qLzOnvy4S+6LxAiJ/tD7wQkR+VbZvuMIzG4xXkkLGtB4Zv4yLi4Ye0DNNIoA
 drB0QTmhxzyw+9DE0JZq1f2FRfMKL/zOuOS2erKmUf/VkI+yEvmsn98UA5n5MjE7v4BpwdtHA0M
 eXmDSv3/BdeoBK+4q7dH+SO3ClTg3MQvygqMzjdIx1BH+9AYfUtVllv68GEmuSsMNAhuMMDhHf6
 19qSX/AcUwe9hEacLvpvF36T+mek5me7d0U03DXADcwLwAsBNe5az+ImSqjVhurRYkLEkx2xRCv
 WEElq3z1dw8qFoiDBH3TGDmetgUvBmtHpRl7k5ltTBdVlv1bUBzHNQrHsVHwKgC+9O9TsQc+3yt
 RA18Av1r14j+at5dxW4e5BAdK+pDZZO304z2iWPrxkZBsATnkN3qZC+jFxqrLqocHFJmM1f9lJy
 Hwvz0fN9vezfyAHuunSAFhcSX3g/xzfAu13qWcSp5a7x7sbQQn0XkOsilVETuuFo/P2Ekw8qIIy
 qUCcPAqMJWqsDQg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add a module parameter to force the write protection mode of pmbus chips.

4 protections modes are provided to start with:
* 0: Remove the write protection
* 1: Disable all writes except to the WRITE_PROTECT, OPERATION,
     PAGE, ON_OFF_CONFIG and VOUT_COMMAND commands
* 2: Disable all writes except to the WRITE_PROTECT, OPERATION and
     PAGE commands
* 3: Disable all writes except to the WRITE_PROTECT command

Of course, if the parameter is not provided, the default write protection
status of the pmbus chips is left untouched.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/hwmon/pmbus-core.rst | 21 +++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
index 0a251960f8910ffb121d82b45e729d06f98424ef..fdfb237731486ce9977b337586333d28f7419d1d 100644
--- a/Documentation/hwmon/pmbus-core.rst
+++ b/Documentation/hwmon/pmbus-core.rst
@@ -387,3 +387,24 @@ PMBUS_VOUT_PROTECTED
 
 Set if the chip VOUT_COMMAND command is protected and protection is not
 determined by the standard WRITE_PROTECT command.
+
+Module parameter
+----------------
+
+pmbus_core.wp: PMBus write protect forced mode
+
+PMBus may come up with a variety of write protection configuration.
+'pmbus_core.wp' may be used if a particular write protection is necessary.
+The ability to actually alter the protection may also depend on the chip
+so the actual runtime write protection configuration may differ from
+the requested one. pmbus_core currently support the following value:
+
+* 0: write protection removed.
+* 1: Disable all writes except to the WRITE_PROTECT, OPERATION,
+  PAGE, ON_OFF_CONFIG and VOUT_COMMAND commands.
+* 2: Disable all writes except to the WRITE_PROTECT, OPERATION and
+  PAGE commands.
+* 3: Disable all writes except to the WRITE_PROTECT command. Note that
+  protection should include the PAGE register. This may be problematic
+  for multi-page chips, if the chips strictly follows the PMBus
+  specification, preventing the chip from changing the active page.
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 51348803ff842c442c711338bab928a54b4d0d9a..d355e3fb0d6b7bea392c7dd5551a1c904a05f21b 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -31,6 +31,9 @@
 #define PMBUS_ATTR_ALLOC_SIZE	32
 #define PMBUS_NAME_SIZE		24
 
+static int wp = -1;
+module_param(wp, int, 0444);
+
 struct pmbus_sensor {
 	struct pmbus_sensor *next;
 	char name[PMBUS_NAME_SIZE];	/* sysfs sensor name */
@@ -2669,6 +2672,32 @@ static void pmbus_init_wp(struct i2c_client *client, struct pmbus_data *data)
 {
 	int ret;
 
+	switch (wp) {
+	case 0:
+		_pmbus_write_byte_data(client, 0xff,
+				       PMBUS_WRITE_PROTECT, 0);
+		break;
+
+	case 1:
+		_pmbus_write_byte_data(client, 0xff,
+				       PMBUS_WRITE_PROTECT, PB_WP_VOUT);
+		break;
+
+	case 2:
+		_pmbus_write_byte_data(client, 0xff,
+				       PMBUS_WRITE_PROTECT, PB_WP_OP);
+		break;
+
+	case 3:
+		_pmbus_write_byte_data(client, 0xff,
+				       PMBUS_WRITE_PROTECT, PB_WP_ALL);
+		break;
+
+	default:
+		/* Ignore the other values */
+		break;
+	}
+
 	ret = _pmbus_read_byte_data(client, 0xff, PMBUS_WRITE_PROTECT);
 	if (ret < 0)
 		return;

-- 
2.45.2


