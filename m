Return-Path: <linux-kernel+bounces-427270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F375E9DFEEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FC31621AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695DE1FC7E1;
	Mon,  2 Dec 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fY/P+cne"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3211FC7C6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135304; cv=none; b=iRO3DZSumcysjquKm7ucXzZighhCQBAtyA3iQNzbgo8OYiLNmjQoZ5CoK2shzgbzlFYXkKn9yZOdprHyKJirOT7EkARYedSWSRZ0z2IFGg/18faNNcQhhkiLUwsJXn81Oq+0dkRMNAq+tC9P8QO8csr73N1U9hUV5XlwyE2nRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135304; c=relaxed/simple;
	bh=yz66sYraGJiZqu2qZJ/3WAnzyWuW1S1L5f4P+rm54nU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJSVCPY5X98aipY6r/4+so3+W3tnf0o9OnS0aM3kJbBEk1S5iJ31CoUWsdGuVxywwQClFLFD07KC/O42wN0HS+apjLYaD/PdfafZXaIgII2w3WUgHpPhxkZ8chdiwDiBeWtod1DcivKuATv9yfqYWtb7Ae6nPlGwiJ4BO+LMwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fY/P+cne; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso566753f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733135299; x=1733740099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRvqS+cxdz+2aYEHdWqks8Xo1SolLTxNaReMoEcROZE=;
        b=fY/P+cnefiMNXaiYnA9Vf2efgMEWkbyrH0v1dr4MAok/bwNjrna3CGsNKKlcrpW+C6
         kwr46YFo/UAqQG779Aeo5NhAI0iQ9yCG3ppP/0FDJsfPET82SH+ZS9LNBgP/VGgAtQgA
         tl93RuX8XNuIojEJc0pq8KIhfp/OKPNp8ySkxqeQBOdHZzU8GR899BBJVOh657yJGySp
         fPRtPMyL1h24tEmvMgO3TBHvtPDwDEFANhPCg0iy50AkszgKzP7jhtaG5dscmBV7gi2w
         KzYrnWls9gqYAnzLSqdShn6PgmToa6aPfx88av0ASAIPsbYY+Hjn6qc7zbF2GRhhuxCj
         c9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733135299; x=1733740099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRvqS+cxdz+2aYEHdWqks8Xo1SolLTxNaReMoEcROZE=;
        b=Vwbxjeu/6sj/gA9YYCA5jeBNGUL5bMirRUJ0BrN4liZ8PThNaTzp6TcEU2BYyqq0Yc
         KyBTEtfAbMbr1Gli1W9VPmanIMns+05L7n2MlQ1BA7aQL7k2qKGW5Bh+nBPmW/TvylB4
         pWbqPoJ4GmRFmTFVElFtT7/48TtJXr0DWVF0QmK5+EDGS4J6oCubWI6Cs/kll+CBIbQa
         HPZgF26Fja/6dSMNuXHeHdZWE55rVf/LNEA4PYdLQtL4T/KhTbdJyDCw3ui9Pmrz2+lM
         e9XlRj2SxZ0XxhTCjA3cVL/DK6zrncQaPX+P6rMKVabZc2ACXOEvnaGQsnlCD1h+iCJE
         qIpw==
X-Forwarded-Encrypted: i=1; AJvYcCXpPfJxged7rpyQ8EMP+mtMXcyI1t+XogyOORn5J3PTrIHyRHc7LarWCMSkfnFqgH5fwdjRZinoMsNHfKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZsCcggm8AxOM7UbCkpn28nEdN2UVoFyk4bEVQLfLBiFdY7Jb0
	yx9DSinTdYGSqP8IihJW9zCi1gJ76qM1DX0n+IlcsL98RYlkMMEv9hzq1vi8P6I=
X-Gm-Gg: ASbGnctVac6Xm3npvLhosmgk9b5FiYWpnIwkaAuT0SqmDvo4IIzS2ewcy8A2hGtm00y
	QaxSOBuB9r1lkhMaVbW7NR2ZY7d76eKR7h+Odz/bITdbZZgQu032M/wdKgQvKyED9on7ddHfTo4
	qWVClOUPM0xgVDsL4+OCAGw0u6MduKMv+NJPGDA2BbI1JbBO/RF7KwwDLtoPEFcAgvBSvLLh6Dq
	QN1bSNHJTsckSOMvPLt66la9KXOKt97S3umOBugaKOmHhWF79dAAdOPxHTHSw==
X-Google-Smtp-Source: AGHT+IHsSx3gs1sZha/rYDLkNYukVwt8XSspxOLea4PEJWonWzfJ1JHlAKJNbBSxy8X+vrAcoXO0yQ==
X-Received: by 2002:a05:6000:1fad:b0:385:dc45:ea06 with SMTP id ffacd0b85a97d-385dc45f2cbmr11884719f8f.13.1733135299407;
        Mon, 02 Dec 2024 02:28:19 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:2380:13:b62c:611c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385e940fef3sm5757614f8f.42.2024.12.02.02.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:28:18 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 02 Dec 2024 11:28:00 +0100
Subject: [PATCH v4 1/3] hwmon: (pmbus/core) improve handling of write
 protected regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-tps25990-v4-1-bb50a99e0a03@baylibre.com>
References: <20241202-tps25990-v4-0-bb50a99e0a03@baylibre.com>
In-Reply-To: <20241202-tps25990-v4-0-bb50a99e0a03@baylibre.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, Jerome Brunet <jbrunet@baylibre.com>, 
 Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6746; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=yz66sYraGJiZqu2qZJ/3WAnzyWuW1S1L5f4P+rm54nU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnTYu+w067LtutAt7V0wzL053QA36cXty+3RBeF
 /scAAyP83mJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ02LvgAKCRDm/A8cN/La
 hWduD/4oM5uREsdTxSEflsgsvfoAr+OHVpis/8xy5V2A3rS4vINxfMdL/var0t1CU2xeWDVUlXd
 8+e0cFAVrEWnER4kphX7ZuLXAXDjVHrerXAFPSbAsBuYBJnybQO5Vy9iBMxp84o+MIo3nVboAA0
 RMN9PLnyxmSqY0Z3t6pauCtlL3m59I0MDvifrFX37+PQ/NcfatE9Cglk7bUnE0Rrrrdwey+Xtqt
 GC28TWwyAXttBjm1sdF0ZLUnW71b2iOaK361ep/0HC0WqlflQ9F968Xw8x3obLdTu1XnYyu7ENh
 UJIY/BW9WzSb2rCeAsYwttfYW3/oHIHBxWwzrxDDmP8nKKYpqh36od48QlCZB7yH966RBv1Z9K+
 +Dslt1tLWlVPoN9TeNgjwExfl6LNnMh1RuSuIl6c2ffQzqTtSEq4Mca7fbnX1HCi1rmlZXmW27m
 lyJzPpXQ8SvPlkmXUbEXMVDQ4u6wMCYa2RCZJWPdT7/jnLLgYWP2F3eZRToLbVsKgWdk2BpXnId
 P96RE3l78lHQtIP5JinpZLAx+5WAvDembClU1R7bCGcJjA68mRJCRtZvrXzpw/XE1XOnltiEXbw
 N7vK52sR1AxpE0ksnOxyfWEqnrH220o7uJjPGiyfLy6AmKInlOv8Aiw4YP01177QUW3VZqd2a03
 MZ0wkdTV+Q2OtAQ==
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
 Documentation/hwmon/pmbus-core.rst | 14 ++++++++++
 drivers/hwmon/pmbus/pmbus.h        |  4 +++
 drivers/hwmon/pmbus/pmbus_core.c   | 52 +++++++++++++++++++++++++++++++++-----
 include/linux/pmbus.h              | 14 ++++++++++
 4 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
index 686a00265bf71231c684afad6df41d6266303919..0a251960f8910ffb121d82b45e729d06f98424ef 100644
--- a/Documentation/hwmon/pmbus-core.rst
+++ b/Documentation/hwmon/pmbus-core.rst
@@ -312,6 +312,10 @@ currently provides a flags field with four bits used::
 
 	#define PMBUS_USE_COEFFICIENTS_CMD		BIT(5)
 
+	#define PMBUS_OP_PROTECTED			BIT(6)
+
+	#define PMBUS_VOUT_PROTECTED			BIT(7)
+
 	struct pmbus_platform_data {
 		u32 flags;              /* Device specific flags */
 
@@ -373,3 +377,13 @@ PMBUS_USE_COEFFICIENTS_CMD
 
 When this flag is set the PMBus core driver will use the COEFFICIENTS
 register to initialize the coefficients for the direct mode format.
+
+PMBUS_OP_PROTECTED
+
+Set if the chip OPERATION command is protected and protection is not
+determined by the standard WRITE_PROTECT command.
+
+PMBUS_VOUT_PROTECTED
+
+Set if the chip VOUT_COMMAND command is protected and protection is not
+determined by the standard WRITE_PROTECT command.
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
index a0109296a9949bfe3a351cbb13787011ed54254b..94252e420ad79fd3e932c0f1df9e1c9a5d8a13d0 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2665,6 +2665,30 @@ static void pmbus_remove_pec(void *dev)
 	device_remove_file(dev, &dev_attr_pec);
 }
 
+static void pmbus_init_wp(struct i2c_client *client, struct pmbus_data *data)
+{
+	int ret;
+
+	ret = _pmbus_read_byte_data(client, -1, PMBUS_WRITE_PROTECT);
+	if (ret < 0)
+		return;
+
+	switch (ret & PB_WP_ANY) {
+	case PB_WP_ALL:
+		data->flags |= PMBUS_OP_PROTECTED;
+		fallthrough;
+	case PB_WP_OP:
+		data->flags |= PMBUS_VOUT_PROTECTED;
+		fallthrough;
+	case PB_WP_VOUT:
+		data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
+		break;
+
+	default:
+		break;
+	}
+}
+
 static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 			     struct pmbus_driver_info *info)
 {
@@ -2718,12 +2742,8 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	 * faults, and we should not try it. Also, in that case, writes into
 	 * limit registers need to be disabled.
 	 */
-	if (!(data->flags & PMBUS_NO_WRITE_PROTECT)) {
-		ret = _pmbus_read_byte_data(client, -1, PMBUS_WRITE_PROTECT);
-
-		if (ret > 0 && (ret & PB_WP_ANY))
-			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
-	}
+	if (!(data->flags & PMBUS_NO_WRITE_PROTECT))
+		pmbus_init_wp(client, data);
 
 	ret = i2c_smbus_read_byte_data(client, PMBUS_REVISION);
 	if (ret >= 0)
@@ -3183,8 +3203,12 @@ static int pmbus_regulator_list_voltage(struct regulator_dev *rdev,
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
@@ -3219,6 +3243,22 @@ const struct regulator_ops pmbus_regulator_ops = {
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


