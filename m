Return-Path: <linux-kernel+bounces-321048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1909713C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3214C285004
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D41B81AB;
	Mon,  9 Sep 2024 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7TzRFwa"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458F1B78FB;
	Mon,  9 Sep 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874238; cv=none; b=En08b5fFupVpGP9jqZAg/q6ZA6M7xbfYoPn5dtKAzvZu/+y1m7BqFePU19VJtr1euLEvDFDfD3/v53JE4gazV/laJH9XoO5HjWDQT2lsilyMc0mPBzhi/WcBQuAwY90VMR8mXJzi6qEdOyGVUJyBSJA40bgfHsSWuCo7Pjpm6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874238; c=relaxed/simple;
	bh=J94kJzZ8E42k12Z+YhHnbi9azY+Almhby4JZF/3alTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cWQosraB10X1jfi9HuYW0AKa3bgM4nxkOIJSuyiUD8pQpJXB9sDK2o7sQ4qoVrBfPXI07cIA+802P3yySjBfFTfWn2xbKC1Z3ZfwGPi7mI45XvBDU+edrFXjLFP17KzgZJ7tSFL2kf6Q1hLvY7wz6abxfdkLspQSNTFG5kuUbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7TzRFwa; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so28631241fa.3;
        Mon, 09 Sep 2024 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874235; x=1726479035; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ2eI4KsB/nkJtqPX6qlu7odSncURe2VJXt3h6n1Reo=;
        b=V7TzRFwaOyckuZMj0LLY2pwpyAz+AbMO/tDwsXEeQ0dD1/eRNFsqEmY9J6pp7Wyh1g
         CeT9x+AjiB1WumUXSu1rzsVwoWEsTFG4eANXmWba9r0YQCQD1B1bGRfzbqobN2i/ggsU
         1ha/P/Bq7o7jLV4751Jll1Nz56m0oW3jb5/JCbJDh2WieZJbaRMEgcBw3Ja2OxUaBz/U
         pHpfPcC9VaNzsU8r68FUdzusJlUuTPrLclhSrY0SdJcN5eIxmcQil+Ka5n6az5RYmobj
         I9dPm8Zo/2evdmAK+uGsrV0M/oq2jaKHNTVHpJPd0XYEcPfC+jLvwijlRQG6xuqcW15d
         Tywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874235; x=1726479035;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ2eI4KsB/nkJtqPX6qlu7odSncURe2VJXt3h6n1Reo=;
        b=LfSpXOGmRq7Ua8+AuijEAkRTtYxue9a4YwX9WtLodULhhjYZL6wSQZsSV+b6XWvgmJ
         N5ICK9kkuQHexVr4BGVLiYm/Ff0UOiPwNW3blq1AJNY4WxnxZidML04aNExo8MirDjYQ
         V8d6oBl8uwx9CG1KfI2ZlOhd8Frjy+27eWOP9mBmQxFYnStR105WxrCSHL5VZC3NbCET
         ZoO++vMaZwelrtnXhDvvmdxTXIYyaal4cXLsGbOV+lsihPRcozcQmzybbQWpQy4/WwJB
         2DXf7jlMHL/QGRU+M2xe5btd01Nl0tZfR24502vs2lgkBURIfcE2uDjpxVI0bSlAnLHJ
         rqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPGOxmLoF2DXD/IT4xG34tQ96gNzJIQh5gnfJ9gYMJ3J63zemaSc+Ju0hwVgms2hEDkEc/h32zx5Itwns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCn49IpaRSn/SB/qHL1ot8XZREn4+uoGLpMv7p0b/38MMHW3kZ
	+/4X+U65X5UadCkYBs8pKo7qhsAe1Lbib4sTTsi5m2NxhywETg25zR83/Msz
X-Google-Smtp-Source: AGHT+IHcnXUQnUdoUdukMDLLVxf/MuLoflA+Fa4uqh+5TL4/r9kwh12u2meoYQjDl8FTMR8/ruwbsg==
X-Received: by 2002:a2e:bc12:0:b0:2f0:1f06:2b43 with SMTP id 38308e7fff4ca-2f751fa9403mr41166311fa.41.1725874234049;
        Mon, 09 Sep 2024 02:30:34 -0700 (PDT)
Received: from localhost (89-73-120-30.dynamic.chello.pl. [89.73.120.30])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-2f75c098e9esm7586441fa.116.2024.09.09.02.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 02:30:33 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
Date: Mon, 09 Sep 2024 11:30:28 +0200
Subject: [PATCH] hwmon: Conditionally clear individual status bits for
 pmbus rev >= 1.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-pmbus-status-reg-clearing-v1-1-f1c0d68c6408@gmail.com>
X-B4-Tracking: v=1; b=H4sIADPA3mYC/x2MywqEMAwAf0Vy3kB9ge6vyB7aGGvArZK4iyD+u
 8XTMIeZE4xV2OBdnKD8F5M1ZSlfBdDsU2SUMTtUrmpc71rcvuFnaLvfM5Qj0sJeJUX0gXpyZdd
 QHSD3m/Ikx/MePtd1A45R/axrAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Patryk Biel <pbiel7@gmail.com>
X-Mailer: b4 0.14.1

This change adds fetching PMBus revision and using it to conditionally
clear individual status bits while calling pmbus_show_boolean, only if
the device is compliant with PMBus specs >= 1.2.

Signed-off-by: Patryk Biel <pbiel7@gmail.com>
---
Current implementation of pmbus_show_boolean assumes that all devices
support write-back operation of status register so as to clear pending
warning or faults. Since clearing individual bits in the status registers
was introduced in PMBus specification 1.2, this operation may not be 
supported by some older devices, thus resulting in error while reading 
boolean attributes like e.g. temp1_max_alarm. 

This change adds fetching PMBus revision supported by device and
modifies pmbus_show_boolean so that it only tries to clear individual
status bits if the device is compilant with PMBus specs >= 1.2.

Tested on: LTC2971, LTC2971-1, LTC2974, LTC2977.
---
 drivers/hwmon/pmbus/pmbus.h      |  6 ++++++
 drivers/hwmon/pmbus/pmbus_core.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index fb442fae7b3e..0bea603994e7 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -418,6 +418,12 @@ enum pmbus_sensor_classes {
 enum pmbus_data_format { linear = 0, ieee754, direct, vid };
 enum vrm_version { vr11 = 0, vr12, vr13, imvp9, amd625mv };
 
+/* PMBus revision identifiers */
+#define PMBUS_REV_10 0x00	/* PMBus revision 1.0 */
+#define PMBUS_REV_11 0x11	/* PMBus revision 1.1 */
+#define PMBUS_REV_12 0x22	/* PMBus revision 1.2 */
+#define PMBUS_REV_13 0x33	/* PMBus revision 1.3 */
+
 struct pmbus_driver_info {
 	int pages;		/* Total number of pages */
 	u8 phases[PMBUS_PAGES];	/* Number of phases per page */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cb4c65a7f288..50ba093a38e8 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -108,6 +108,8 @@ struct pmbus_data {
 
 	int vout_low[PMBUS_PAGES];	/* voltage low margin */
 	int vout_high[PMBUS_PAGES];	/* voltage high margin */
+
+	u8 revision;	/* The PMBus revision the device is compliant with */
 };
 
 struct pmbus_debugfs_entry {
@@ -1095,7 +1097,11 @@ static int pmbus_get_boolean(struct i2c_client *client, struct pmbus_boolean *b,
 
 	regval = status & mask;
 	if (regval) {
-		ret = _pmbus_write_byte_data(client, page, reg, regval);
+		if (data->revision >= PMBUS_REV_12)
+			ret = _pmbus_write_byte_data(client, page, reg, regval);
+		else
+			pmbus_clear_fault_page(client, page);
+
 		if (ret)
 			goto unlock;
 	}
@@ -2653,6 +2659,10 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 		}
 	}
 
+	ret = i2c_smbus_read_byte_data(client, PMBUS_REVISION);
+	if (ret > 0)
+		data->revision = ret;
+
 	if (info->pages <= 0 || info->pages > PMBUS_PAGES) {
 		dev_err(dev, "Bad number of PMBus pages: %d\n", info->pages);
 		return -ENODEV;

---
base-commit: c763c43396883456ef57e5e78b64d3c259c4babc
change-id: 20240905-pmbus-status-reg-clearing-abc9c0184c3b

Best regards,
-- 
Patryk Biel <pbiel7@gmail.com>


