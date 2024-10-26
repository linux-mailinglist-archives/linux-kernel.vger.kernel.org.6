Return-Path: <linux-kernel+bounces-383036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B39B1668
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A18B21B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64151D0E24;
	Sat, 26 Oct 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsazYOB3"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6821CEABB;
	Sat, 26 Oct 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933735; cv=none; b=hk4vNDU2Zij35kWwOW6vIyhIivcpv/ynEJC2hRy8MfPnyPBvM0hO5X66RGQvOG/JmTo0MyGFGcPJ3jnSEeVDuOeyB0cDL4PGEqNw+1exNGYBKfCqRVqjpDBxOnMN9dJmMtEpvWunDHHhywY9wuAU+tQ4myKKPST66px0Qmc0m8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933735; c=relaxed/simple;
	bh=4OVBt8wnXP50xgTMepwv7cYjQmKdc5mCthcB3vOxSk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f6z+vvX52vuq5liKPHZR4iwOoH4YoNLC9B47pwEuW56aGwJi/geKlF7N9+PXH4amUoIee3kwva9mqo1bu9nFy0A8TZUWeKfxIn36svkZR5DEgRztIMrCVdUGURfo5M26bWXlOrK6GrnTJtue7Cgr5sMBcZhKDaI6b7z7oQyfE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsazYOB3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a850270e2so453688666b.0;
        Sat, 26 Oct 2024 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729933731; x=1730538531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni/HnzY70yB7kHY6oWLFE4EpUl5voblzfr2uw5cGLqQ=;
        b=nsazYOB3/tKY+raaGjTl1UFZ5IBiaV68fDXCvr+F4JH3REJmPvgSrrB9AWGTx/V8RA
         ei9F8+DPlv7vlI8CU6exbVn1g2vF9nNfP9dS00aVG/2q7bynDnuHLpPSlPvE9WUTvBPJ
         5aBGics9iNCpZtuXIC1ISMD9gOJACM9mDDq1EGvqbORerM6V1yge27PVElpnXwW5EJIo
         oqPHsygDKJ96x5kRntMywnwt1WHId5qJw9iE3jS8f1ytH0vCUAVMjRaeNWVJbiS9CnD1
         31IOCuez1ZYvPQwA0UhnBZO2s2LxCGGePheVO5EDK9zs/LWEYdDm5zvEapTgq3Kn3pF+
         BMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729933731; x=1730538531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ni/HnzY70yB7kHY6oWLFE4EpUl5voblzfr2uw5cGLqQ=;
        b=cH4I5wNebKYwKAjN5FE2pwljSOivU56u7fWm2N7mE+m5HjsPDUy4rt65ePwFEWILW8
         W5ks3g+XK+MOZXAN6A761ksai6HBTgOBjTFeHmK8ngeYVoblF88n7g4uXqI/KpxLZboL
         0lBSRbh2ckfJrT6ppY8aThE9ZFADXVuZSFp6h7RG8mfIm5N1b1fLCNsiW/gNfFW4rXad
         DH6lFamL5UUSWPgUEwSnSEXjiODlxwzSLM6Gmf+gjWfi66L3lk508q2Vcs4IPwHu2PzH
         o3+Gc7EZCLRhugcTMlHez4BKWn1eatdX25OvqVNj4HReBPvLQKMhxCFtLisodfqa3+7w
         2ZgA==
X-Forwarded-Encrypted: i=1; AJvYcCUjUAvX71226JI61Y9Wc5Uot2tYKwmDcMNnKmKtMiarsVvvEg4TIGLJ4x3sch/Vk8CgJPZBpKw9wUrh@vger.kernel.org, AJvYcCUsSSZu483VgHsyfPds3cPDplxgyGTujoB12QI5yBl35AMQLLjwyXT+2xQ8BgKRJiDlfIO9TnwxSAIg3EFU@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlNIKzifWiv09HAIv8Z4Q1Fp5Gqv5tdsJ7WSkVQXY0KPSMc50
	Kq1iLgYnkwtHq4owTUW0DACsQRqQaFD+SR7WFIYtLfoLnlNkCGyT
X-Google-Smtp-Source: AGHT+IG4M4YISS0t+p7quekVGsz/hhXSRWWMENG+qPz2dk3TkVUxtLBZYHSxl8UZJWDjsOU03DFShg==
X-Received: by 2002:a17:906:c105:b0:a99:6791:5449 with SMTP id a640c23a62f3a-a9de615ad79mr163427166b.52.1729933731101;
        Sat, 26 Oct 2024 02:08:51 -0700 (PDT)
Received: from localhost (89-73-120-30.dynamic.chello.pl. [89.73.120.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-a9b1f068c51sm155089966b.92.2024.10.26.02.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 02:08:49 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
Date: Sat, 26 Oct 2024 11:08:44 +0200
Subject: [PATCH 1/2] hwmon: pmbus: Add support for ltc2971
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-add-ltc2971-v1-1-109ec21687bc@gmail.com>
References: <20241026-add-ltc2971-v1-0-109ec21687bc@gmail.com>
In-Reply-To: <20241026-add-ltc2971-v1-0-109ec21687bc@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Patryk Biel <pbiel7@gmail.com>
X-Mailer: b4 0.14.2

LTC2971 is a power manager similar to already supported LTC2972,
it uses the same register set but supports a different voltage range.

Signed-off-by: Patryk Biel <pbiel7@gmail.com>
---
 drivers/hwmon/pmbus/ltc2978.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 73a86f4d647288be97615f19a5c6314e4036e6a3..681e7b811dbcc263fe8f5e4f9da30fcbc7e019ad 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -21,7 +21,8 @@
 
 enum chips {
 	/* Managers */
-	ltc2972, ltc2974, ltc2975, ltc2977, ltc2978, ltc2979, ltc2980,
+	ltc2971, ltc2972, ltc2974, ltc2975, ltc2977, ltc2978,
+	ltc2979, ltc2980,
 	/* Controllers */
 	ltc3880, ltc3882, ltc3883, ltc3884, ltc3886, ltc3887, ltc3889, ltc7132, ltc7880,
 	/* Modules */
@@ -61,6 +62,7 @@ enum chips {
 
 #define LTC2978_ID_MASK			0xfff0
 
+#define LTC2971_ID			0x0320
 #define LTC2972_ID			0x0310
 #define LTC2974_ID			0x0210
 #define LTC2975_ID			0x0220
@@ -533,6 +535,7 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 }
 
 static const struct i2c_device_id ltc2978_id[] = {
+	{"ltc2971", ltc2971},
 	{"ltc2972", ltc2972},
 	{"ltc2974", ltc2974},
 	{"ltc2975", ltc2975},
@@ -564,11 +567,19 @@ MODULE_DEVICE_TABLE(i2c, ltc2978_id);
 
 #if IS_ENABLED(CONFIG_SENSORS_LTC2978_REGULATOR)
 #define LTC2978_ADC_RES	0xFFFF
+#define LTC2978_UV_STEP	1000
+
+/* Common for most chips */
 #define LTC2978_N_ADC	122
 #define LTC2978_MAX_UV	(LTC2978_ADC_RES * LTC2978_N_ADC)
-#define LTC2978_UV_STEP	1000
 #define LTC2978_N_VOLTAGES	((LTC2978_MAX_UV / LTC2978_UV_STEP) + 1)
 
+/* LTC2971 */
+#define LTC2971_N_ADC	4500
+#define LTC2971_MAX_UV	(LTC2978_ADC_RES * LTC2971_N_ADC)
+#define LTC2971_N_VOLTAGES	((LTC2971_MAX_UV / LTC2978_UV_STEP) + 1)
+
+/* Common for most chips */
 static const struct regulator_desc ltc2978_reg_desc[] = {
 	PMBUS_REGULATOR_STEP("vout", 0, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
 	PMBUS_REGULATOR_STEP("vout", 1, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
@@ -580,6 +591,12 @@ static const struct regulator_desc ltc2978_reg_desc[] = {
 	PMBUS_REGULATOR_STEP("vout", 7, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
 };
 
+/* LTC2971 */
+static const struct regulator_desc ltc2971_reg_desc[] = {
+	PMBUS_REGULATOR_STEP("vout", 0, LTC2971_N_VOLTAGES, LTC2978_UV_STEP, 0),
+	PMBUS_REGULATOR_STEP("vout", 1, LTC2971_N_VOLTAGES, LTC2978_UV_STEP, 0),
+};
+
 static const struct regulator_desc ltc2978_reg_desc_default[] = {
 	PMBUS_REGULATOR("vout", 0),
 	PMBUS_REGULATOR("vout", 1),
@@ -624,7 +641,9 @@ static int ltc2978_get_id(struct i2c_client *client)
 
 	chip_id &= LTC2978_ID_MASK;
 
-	if (chip_id == LTC2972_ID)
+	if (chip_id == LTC2971_ID)
+		return ltc2971;
+	else if (chip_id == LTC2972_ID)
 		return ltc2972;
 	else if (chip_id == LTC2974_ID)
 		return ltc2974;
@@ -731,6 +750,7 @@ static int ltc2978_probe(struct i2c_client *client)
 	data->temp2_max = 0x7c00;
 
 	switch (data->id) {
+	case ltc2971:
 	case ltc2972:
 		info->read_word_data = ltc2975_read_word_data;
 		info->pages = LTC2972_NUM_PAGES;
@@ -861,6 +881,13 @@ static int ltc2978_probe(struct i2c_client *client)
 #if IS_ENABLED(CONFIG_SENSORS_LTC2978_REGULATOR)
 	info->num_regulators = info->pages;
 	switch (data->id) {
+	case ltc2971:
+		info->reg_desc = ltc2971_reg_desc;
+		if (info->num_regulators > ARRAY_SIZE(ltc2971_reg_desc)) {
+			dev_warn(&client->dev, "num_regulators too large!");
+			info->num_regulators = ARRAY_SIZE(ltc2971_reg_desc);
+		}
+		break;
 	case ltc2972:
 	case ltc2974:
 	case ltc2975:
@@ -892,6 +919,7 @@ static int ltc2978_probe(struct i2c_client *client)
 
 #ifdef CONFIG_OF
 static const struct of_device_id ltc2978_of_match[] = {
+	{ .compatible = "lltc,ltc2971" },
 	{ .compatible = "lltc,ltc2972" },
 	{ .compatible = "lltc,ltc2974" },
 	{ .compatible = "lltc,ltc2975" },

-- 
2.43.0


