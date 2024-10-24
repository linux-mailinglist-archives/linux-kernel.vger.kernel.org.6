Return-Path: <linux-kernel+bounces-380484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB159AEF5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FFD1F21B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7252038B8;
	Thu, 24 Oct 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3d1/eljZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E05201102
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793471; cv=none; b=g8LyFaIjW6ZJYLJQLeYtaqzhzKV9KRCoW90YO6cn6itis90xiKf+EOVOypufKAciWlBcvARvPOUe6pJPACiWk5ZE1h5a4KFEr+tQY6cz5nd7aaNxZWBOkdnf9dxCvx14/ksF6Wlw8ogHYvkplMMWG46PqcKgkYn5jB/SylxTieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793471; c=relaxed/simple;
	bh=bdFRv2raH+KCLJmgZO4a4Ytf5JCh6ZuWY7zPZdWyxiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vgk3NgBcOJx1pOm8ilE2wBNu5z/s47304mAKMTFxAauz2G1jNaO/B2PvYG5foYNfa2tn1vOJEyLqY08uHsBNTGZzxbDsuNJm4+hpxE1t2ZkIvSVXbpGyJvoH3GhvMwl2DzRIYI8kIEK9ilIxRm6YA33kz/vGBQB199frz1cNSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3d1/eljZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso12780275e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729793465; x=1730398265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ug2lBpzs8RWHKP1Np79oVEQzEMuZF46YKLSwDulWpE0=;
        b=3d1/eljZXrj6wPFwy7D0wvEvRg6X923rpGeBScBfBb8ss2BHmnPuD4NZzXs411INLq
         /TG/HNhJ9b/jMNZWHM06jWot0P+QjZxLfHH0lBSsQHPHlJPNU5T7fsrf5O3cqoTwsN2O
         lCr/hykXcZLRkC+XjDYrstnzXDRUAOqptzDzt40mSR3/eziXeW5YUuC/QSZcDlb5Sgcu
         lpRDcp+n9kFy0VuYPwR595wPEgrAiLVszrBr0xSciHp4YRov4KLBPwsT8+y+wqiv3hFL
         NDApex5Z8PthXRmLIdquqbvLR4hYhadwTacPMVwntjOYPy8b8fssh2U56oOV9Q7tOiDf
         PZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793465; x=1730398265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug2lBpzs8RWHKP1Np79oVEQzEMuZF46YKLSwDulWpE0=;
        b=kvAgKSFZ2PNm+U8F3raQp6nHdZbYn/gwU/g0IlMP55jqMEnL3VIjIhk1SwxFU10shL
         yZjeX3CpSMtFfrIy2lGZk/oOnp8T1nDYKaEaJ582SgFKTZaLmI6TSpczahrmXdv/EowL
         H1I1SH6ukwMj9MQDuJ6pi+03VN0Onukk4mXkME76VT0X8jhwIoYEH82F+iqGG1m7BX4K
         +vCroTHfBIsOk8N8HMGSic8nCUzmJvNqxRs0es6rcT3RmHNcbGSmcPui3y3QzxVAT6x+
         cI0kMQQO02PlJHpJUzRGU31EVnmD0YP8nf0lHkutgYp5lkMJapZ+xeoe0ly6SVpt8ry6
         w2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7kyJ6rlU2UZwjqSx/iquJbST72A8hDeZY/OZVZZ3lUH8F8vOaUQ9jONJnQjif4Os0SUTY+1CtZQ49M5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcqje41CWyY4y7gq/nSTBSuUpmbNHbJSZvQoHZSev261LofFuP
	EsAMjDyon6qP4LYemh/zXrdAD1QkZKSfItEBPRLdJJ+IOVB04/cAJiQH7D0yxz0=
X-Google-Smtp-Source: AGHT+IH2DW0bDE1/m2APidQKI5jd3nr0T6/JPFV0f0xHmO/7+Qb9aouj4Olh0pGuMpVMSjAz4q8gZw==
X-Received: by 2002:a05:600c:4588:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-4318421772amr67743925e9.16.1729793465498;
        Thu, 24 Oct 2024 11:11:05 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:c04c:f30a:b45c:dbb])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c0f248sm52551275e9.37.2024.10.24.11.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:11:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 24 Oct 2024 20:10:36 +0200
Subject: [PATCH v3 2/6] hwmon: (pmbus/core) improve handling of write
 protected regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-tps25990-v3-2-b6a6e9d4b506@baylibre.com>
References: <20241024-tps25990-v3-0-b6a6e9d4b506@baylibre.com>
In-Reply-To: <20241024-tps25990-v3-0-b6a6e9d4b506@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4955; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=bdFRv2raH+KCLJmgZO4a4Ytf5JCh6ZuWY7zPZdWyxiU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnGo2wepJ2C+wcHQZHkZzvWl0mO2OX7kbggqvKW
 lSzVrLSGRWJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZxqNsAAKCRDm/A8cN/La
 hUQgEACaADc1xFNa9skN679kKhR7WLIYoMP8t/ytGLV0zzoMaizPENecCl2SVF2oCwci5H7VN23
 P2Z0fN4p2fvXl7E25PpUpcdaR7/Vvn1SGqbHNIpd1Migi9rhlQ1zSpuWlYDi0eYOuunSg5VFOqS
 /iHON8ahTyc5MPtYDuYuU9ufmDMWJ8Q3CDHfnPYWXhW8uk/GvwcjydW6MroP0p81JMslbZTwoeG
 kYabXb5HzFBduMD9AEhfzzegTrTukW5aYitViK531Ouf+s+Ri+11O21w4EqBYKr7zAH6j/pbfs4
 jJcfrobQY5NMQ40XEhaltUHkP8N5cAP9j2LMm/QG8/GsLNgx+ikv1bWXzTvWaJ7wMj2D23SgpOP
 ttZ573Pakl6WpyUoXluLHBAK7W4EAAMaGGkFXoJWRXTP2ILfFQhV+KxnBBHF/yK3kPuO3r6mnVk
 YNES/6eujPDbSrSKcUedM2hY5be8bCjizDLuC3lsRpCiQXO0qStpWn7iuKUi7IviE2bMhg1K4k0
 Irb/63kCtdyGQOsCzWeR5S9f3fUwoUmWC+6mErJ7XWEMMOAjAckXcZ7wD6G6G2OHoiuva6Bjv2Z
 I0DFKxGoOnCY6OjwRneSGW1ZyHGDt5tkgh15x3qlnxIqiLrncc1gtEFvoyEXnpUKI/9/S1fnWrB
 wML5mn5K3Kt+N2w==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Writing PMBus protected registers does succeed from the smbus perspective,
even if the write is ignored by the device and a communication fault is
raised. This fault will silently be caught and cleared by pmbus irq if one
has been registered.

This means that the regulator call may return succeed although the
operation was ignored.

With this change, the operation which are not supported will be properly
flagged as such and the regulator framework won't even try to execute them.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/hwmon/pmbus/pmbus.h      |  4 ++++
 drivers/hwmon/pmbus/pmbus_core.c | 35 ++++++++++++++++++++++++++++++++++-
 include/linux/pmbus.h            | 14 ++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index d605412a3173b95041524285ad1fde52fb64ce5a..ddb19c9726d62416244f83603b92d81d82e64891 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -487,6 +487,8 @@ struct pmbus_driver_info {
 /* Regulator ops */
 
 extern const struct regulator_ops pmbus_regulator_ops;
+int pmbus_regulator_init_cb(struct regulator_dev *rdev,
+			    struct regulator_config *config);
 
 /* Macros for filling in array of struct regulator_desc */
 #define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step, _min_uV)  \
@@ -501,6 +503,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
 		.n_voltages = _voltages,			\
 		.uV_step = _step,				\
 		.min_uV = _min_uV,				\
+		.init_cb = pmbus_regulator_init_cb,		\
 	}
 
 #define PMBUS_REGULATOR(_name, _id)   PMBUS_REGULATOR_STEP(_name, _id, 0, 0, 0)
@@ -516,6 +519,7 @@ extern const struct regulator_ops pmbus_regulator_ops;
 		.n_voltages = _voltages,			\
 		.uV_step = _step,				\
 		.min_uV = _min_uV,				\
+		.init_cb = pmbus_regulator_init_cb,		\
 	}
 
 #define PMBUS_REGULATOR_ONE(_name)   PMBUS_REGULATOR_STEP_ONE(_name, 0, 0, 0)
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 085a4dc91d9bad3d2aacdd946b74a094ea9ae458..7bdd8f2ffcabc51500437182f411e9826cd7a55d 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2721,8 +2721,21 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
 		ret = _pmbus_read_byte_data(client, 0xff, PMBUS_WRITE_PROTECT);
 
-		if (ret > 0 && (ret & PB_WP_ANY))
+		switch (ret) {
+		case PB_WP_ALL:
+			data->flags |= PMBUS_OP_PROTECTED;
+			fallthrough;
+		case PB_WP_OP:
+			data->flags |= PMBUS_VOUT_PROTECTED;
+			fallthrough;
+		case PB_WP_VOUT:
 			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
+			break;
+
+		default:
+			/* Ignore manufacturer specific and invalid as well as errors */
+			break;
+		}
 	}
 
 	ret = i2c_smbus_read_byte_data(client, PMBUS_REVISION);
@@ -3183,8 +3196,12 @@ static int pmbus_regulator_list_voltage(struct regulator_dev *rdev,
 {
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
 	int val, low, high;
 
+	if (data->flags & PMBUS_VOUT_PROTECTED)
+		return 0;
+
 	if (selector >= rdev->desc->n_voltages ||
 	    selector < rdev->desc->linear_min_sel)
 		return -EINVAL;
@@ -3219,6 +3236,22 @@ const struct regulator_ops pmbus_regulator_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(pmbus_regulator_ops, PMBUS);
 
+int pmbus_regulator_init_cb(struct regulator_dev *rdev,
+			    struct regulator_config *config)
+{
+	struct pmbus_data *data = config->driver_data;
+	struct regulation_constraints *constraints = rdev->constraints;
+
+	if (data->flags & PMBUS_OP_PROTECTED)
+		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_STATUS;
+
+	if (data->flags & PMBUS_VOUT_PROTECTED)
+		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_VOLTAGE;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_regulator_init_cb, PMBUS);
+
 static int pmbus_regulator_register(struct pmbus_data *data)
 {
 	struct device *dev = data->dev;
diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
index fa9f08164c365a541ee1c6480bafd8c3a8f98138..884040e1383bf41d2eb3b6de72c40e2650178dc6 100644
--- a/include/linux/pmbus.h
+++ b/include/linux/pmbus.h
@@ -73,6 +73,20 @@
  */
 #define PMBUS_USE_COEFFICIENTS_CMD		BIT(5)
 
+/*
+ * PMBUS_OP_PROTECTED
+ * Set if the chip OPERATION command is protected and protection is not
+ * determined by the standard WRITE_PROTECT command.
+ */
+#define PMBUS_OP_PROTECTED			BIT(6)
+
+/*
+ * PMBUS_VOUT_PROTECTED
+ * Set if the chip VOUT_COMMAND command is protected and protection is not
+ * determined by the standard WRITE_PROTECT command.
+ */
+#define PMBUS_VOUT_PROTECTED			BIT(7)
+
 struct pmbus_platform_data {
 	u32 flags;		/* Device specific flags */
 

-- 
2.45.2


