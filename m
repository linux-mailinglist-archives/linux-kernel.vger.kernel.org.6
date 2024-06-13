Return-Path: <linux-kernel+bounces-213054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB6906A69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C899B225A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D4142649;
	Thu, 13 Jun 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAlowQkN"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812C14262B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275786; cv=none; b=N5Kj822VP9Bc979y4BStIW4MUaz+qzh3oxDDuzLnGvLzi2HruUQqed3Z7BqOAp2z3kA10JGHwLCxx7z1Ni1KNGgF0oL5mlY1IFt4O6FfshaFlZCLBQ6kHI9OKEJ5HovmA13fqXm0gDS+yl6f1hJDDl37q70iXgzNzBQVyTvbnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275786; c=relaxed/simple;
	bh=PgNLZik2/9wkjqoeRVNR87TCWAib9EUc20HbSUideJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFWq2vETS9TT3JDrvrgDKN+ZWGgYWWRpucjIPhPk+AXnDGrpQCy7bX3edx9ncAy5iwXTjpJeFLqNORH86wfZRXJfQwrWBupxUMtYxyKEwWZDLIKcKyk36zAhJ13BTBRc9cfgkaF6g+b/vTGpcjl+AnYzXpwFUKjlA4RAWPqaCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mAlowQkN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57ca578ce8dso842002a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718275782; x=1718880582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcFNYVwCT4edf08hn0wtemVgpKp4KmFtiLch+NSN3FY=;
        b=mAlowQkNDgv5Q+CS6GtZg/JD9k7Wb7LnqyIKpm9mXGtVObK982xiWYZSPGeHGyYWrb
         xKjTFWtZkkhz6y6Bg4KYuC0/SmrnvoynlV4URnzRPKMfZjL5R6rlazt1FJ8BVlfKadkI
         sudtUbe3HSAulRcABaD0RqPhEq8tVDlgZedrS3WwjPEuAorHx5uBhO5BBY+917sHMfmZ
         jK/lOFVbylmSAhPP0cO4RwuXYlvQFZz+pkQ5cWX1/VpxW+XK9F2GU25VNgUZcE8XDvyT
         8nj4cgZ9qAPOm3ChSUaJPwftxHQYRXWhJR4fMv0We8SzKoMkwlC7xQQa0SD9Z6ZsNuKb
         OcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718275782; x=1718880582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcFNYVwCT4edf08hn0wtemVgpKp4KmFtiLch+NSN3FY=;
        b=NtS6DTwWgOIvZm9OUhPQieS2I6uinB92ZcrKO8cJThugwFcyQ/IlgNdn8E6DVmAkqu
         meG1MYjdZwAe0A+LJi5PBQIDLB4l9MfaK99R/EbqTfOPk3kEMOpqLOt7v0z0XOMHUk54
         zFnwO0WV6RBtELwcgn4L+Ja3oSaCgmJUlA9qgJRSCL9YCV9YutkJu7zlONbo0JYssSt3
         xQzNPhvd5DJzBAqt8ylTJuA9YsXC4HvXrxeVRz371Bv3BKgOPI8WX69zhVN7NReiW5Pl
         ZUspdenVrYjVN5veKwbCo+j5be/thv8PyHkv4ItBC6pqrt7nOWzF9nhbQxWZ7/LXeNvo
         bZkg==
X-Forwarded-Encrypted: i=1; AJvYcCUMsQ43PDfb3BpLZmm934H9jhIYByzYWIDLbwrDBg/53LnJoeM7BuUdQYW0x/XUbB8EcMu9nsxapPA27f2CbYfUkWzpcXTDd+Du7QM3
X-Gm-Message-State: AOJu0YyNVMtGhxWxnqg0t0llrhNcH/9gvLr/y9prZgSrSvBS6NbnZg7/
	3k7mY6JZwPZXoQ1jKemgPd8uvJXpF/okXBz7h/YR7YSwbNWeKowUKAuq9O1/JWw=
X-Google-Smtp-Source: AGHT+IFKzLuPEWkbGqQk+dBt+3yOu7WlU49DD9ThzsaA4PBLn2bNwKRKNuVL0SoB/eyVF60AqsTcfQ==
X-Received: by 2002:a50:d654:0:b0:57c:6bd6:d8e5 with SMTP id 4fb4d7f45d1cf-57ca9756c4dmr2854608a12.8.1718275782417;
        Thu, 13 Jun 2024 03:49:42 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdf2bsm762618a12.17.2024.06.13.03.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:49:41 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 13 Jun 2024 11:49:31 +0100
Subject: [PATCH v4 1/3] ASoC: codecs: lpass-macro: add helpers to get codec
 version
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-lpass-codec-v25-v4-1-f63d3676dbc4@linaro.org>
References: <20240612-lpass-codec-v25-v4-0-f63d3676dbc4@linaro.org>
In-Reply-To: <20240612-lpass-codec-v25-v4-0-f63d3676dbc4@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
 krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5630;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=PgNLZik2/9wkjqoeRVNR87TCWAib9EUc20HbSUideJ4=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmas7D4WJzYEkvV+HMxnKTCmx8TblRv5xGiPIoZ
 YO0D4L3e6GJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZmrOwwAKCRB6of1ZxzRV
 N9zlB/4iB3ZfIpHfzMJunK24LsZ8s3Re5S2AC420Eg2nxEq3QaQqZZE57U+1lWNdlwb/L0S68D5
 xBFDRXs+vElK8W2/JZ5nmzmakRJwXeePLrTdfKF1oqKgrjPns8y7BDEUNwQx6vQqsFCFwQY9RoH
 NbmPcuh9DsGGT2RKulakz0QVNBsIYv7zKmkjXSSt3z9IZswYlSfNAfegtN0fmlZP7F2CTNo5RZ4
 hVaCGoaK1gg4Upyp3dYVmwEywMWIQVijiLp36C4TLS56SZlVzxBxBS4mooM3fPy8w5spJD7emHD
 7Q+myNvXRUSrJFngsykug8UPTI5h2YEEIQILHKZmaaTEeuCb
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

LPASS Digital codec have changes in register layout across multiple
versions. Add a proper way read the codec version allowint all the lpass
macro drivers (tx, rx, wsa, va) to configure the registers correctly.

LPASS VA macro has the required registers to read the codec version.
Read the the version and make it available to other lpass codec macros
using the common helper functions.

Existing method of using LPASS IP version is not accurate as the same
the codec versioning is totally independent of LPASS IP block versions.

These helper functions should be able to provide a convient way to get
the codec version, and will help scale the drivers in right direction.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
---
 sound/soc/codecs/lpass-macro-common.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/lpass-macro-common.h | 35 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/lpass-va-macro.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
index da1b422250b8..8b038a99a8f9 100644
--- a/sound/soc/codecs/lpass-macro-common.c
+++ b/sound/soc/codecs/lpass-macro-common.c
@@ -11,6 +11,9 @@
 
 #include "lpass-macro-common.h"
 
+static DEFINE_MUTEX(lpass_codec_mutex);
+static int lpass_codec_version;
+
 struct lpass_macro *lpass_macro_pds_init(struct device *dev)
 {
 	struct lpass_macro *l_pds;
@@ -66,5 +69,25 @@ void lpass_macro_pds_exit(struct lpass_macro *pds)
 }
 EXPORT_SYMBOL_GPL(lpass_macro_pds_exit);
 
+void lpass_macro_set_codec_version(int version)
+{
+	mutex_lock(&lpass_codec_mutex);
+	lpass_codec_version = version;
+	mutex_unlock(&lpass_codec_mutex);
+}
+EXPORT_SYMBOL_GPL(lpass_macro_set_codec_version);
+
+int lpass_macro_get_codec_version(void)
+{
+	int ver;
+
+	mutex_lock(&lpass_codec_mutex);
+	ver = lpass_codec_version;
+	mutex_unlock(&lpass_codec_mutex);
+
+	return ver;
+}
+EXPORT_SYMBOL_GPL(lpass_macro_get_codec_version);
+
 MODULE_DESCRIPTION("Common macro driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index d98718b3dc4b..f6f1bfe8eb77 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -18,6 +18,18 @@ enum lpass_version {
 	LPASS_VER_11_0_0,
 };
 
+enum lpass_codec_version {
+	LPASS_CODEC_VERSION_1_0 = 1,
+	LPASS_CODEC_VERSION_1_1,
+	LPASS_CODEC_VERSION_1_2,
+	LPASS_CODEC_VERSION_2_0,
+	LPASS_CODEC_VERSION_2_1,
+	LPASS_CODEC_VERSION_2_5,
+	LPASS_CODEC_VERSION_2_6,
+	LPASS_CODEC_VERSION_2_7,
+	LPASS_CODEC_VERSION_2_8,
+};
+
 struct lpass_macro {
 	struct device *macro_pd;
 	struct device *dcodec_pd;
@@ -25,5 +37,28 @@ struct lpass_macro {
 
 struct lpass_macro *lpass_macro_pds_init(struct device *dev);
 void lpass_macro_pds_exit(struct lpass_macro *pds);
+void lpass_macro_set_codec_version(int version);
+int lpass_macro_get_codec_version(void);
+
+static inline const char *lpass_macro_get_codec_version_string(int version)
+{
+	switch (version) {
+	case LPASS_CODEC_VERSION_2_0:
+		return "v2.0";
+	case LPASS_CODEC_VERSION_2_1:
+		return "v2.1";
+	case LPASS_CODEC_VERSION_2_5:
+		return "v2.5";
+	case LPASS_CODEC_VERSION_2_6:
+		return "v2.6";
+	case LPASS_CODEC_VERSION_2_7:
+		return "v2.7";
+	case LPASS_CODEC_VERSION_2_8:
+		return "v2.8";
+	default:
+		break;
+	}
+	return "NA";
+}
 
 #endif /* __LPASS_MACRO_COMMON_H__ */
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 6eceeff10bf6..a555e1e078eb 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1461,6 +1461,32 @@ static int va_macro_validate_dmic_sample_rate(u32 dmic_sample_rate,
 	return dmic_sample_rate;
 }
 
+static void va_macro_set_lpass_codec_version(struct va_macro *va)
+{
+	int core_id_0 = 0, core_id_1 = 0, core_id_2 = 0, version;
+
+	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_0, &core_id_0);
+	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_1, &core_id_1);
+	regmap_read(va->regmap, CDC_VA_TOP_CSR_CORE_ID_2, &core_id_2);
+
+	if ((core_id_0 == 0x01) && (core_id_1 == 0x0F))
+		version = LPASS_CODEC_VERSION_2_0;
+	if ((core_id_0 == 0x02) && (core_id_1 == 0x0E))
+		version = LPASS_CODEC_VERSION_2_1;
+	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x50 || core_id_2 == 0x51))
+		version = LPASS_CODEC_VERSION_2_5;
+	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x60 || core_id_2 == 0x61))
+		version = LPASS_CODEC_VERSION_2_6;
+	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x70 || core_id_2 == 0x71))
+		version = LPASS_CODEC_VERSION_2_7;
+	if ((core_id_0 == 0x02) && (core_id_1 == 0x0F) && (core_id_2 == 0x80 || core_id_2 == 0x81))
+		version = LPASS_CODEC_VERSION_2_8;
+
+	lpass_macro_set_codec_version(version);
+
+	dev_dbg(va->dev, "LPASS Codec Version %s\n", lpass_macro_get_codec_version_string(version));
+}
+
 static int va_macro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1554,6 +1580,8 @@ static int va_macro_probe(struct platform_device *pdev)
 			goto err_npl;
 	}
 
+	va_macro_set_lpass_codec_version(va);
+
 	if (va->has_swr_master) {
 		/* Set default CLK div to 1 */
 		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,

-- 
2.25.1


