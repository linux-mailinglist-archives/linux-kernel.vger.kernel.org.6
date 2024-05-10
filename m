Return-Path: <linux-kernel+bounces-176077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263F8C299F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D8A1F213E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4B538DD3;
	Fri, 10 May 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0lf/byc"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32901B285
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363922; cv=none; b=TIZsSOCWBzXIIdQVBs1HnOVMUqEss4xOO5lgRxWyARQgQ97Sr9OTfK7uWiyd1uapzUC0xjKHxlFoqp/QUiqfzyz6I3DiyP0IdYTCgNuMHw/YpJUWwmWWXGaCm7v58eAbELm6CwuJGskPk6pg4ElYsGb7q2XqhEQIJN1cBT+2udM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363922; c=relaxed/simple;
	bh=pnDcDTmwduPk+3gSuJLvXtZneABMTN2FxzqqHxNrUd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KlSqXeYH1maxPVgalGrQwh+DjZplNa6KV+tL9Ps64MIToLZ9IBVcwcH/Bm6VmMSAmAEROLgh4mOKcg41dfI3YrLZm6qFBOQjssHlwK76JxD7iALEPdlFEnFcJVp5OMe96/2XP6iIcqMI1rYsp4Xp2afMsDRbWbjwmspxCbtsDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0lf/byc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso13016505e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715363919; x=1715968719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chW8k3/UFKxLYywJHYuhDfax5Lmwls70ctPbfNY8aTk=;
        b=X0lf/byc3BvWN24zMDeHvt8OwFJKFQzgw6mZQoUVxlObdFkLqxcNTv8NiAqW4X5Wjf
         CrK8AIdSqLRZhzQqVRgDROMRt8B+yPIoyGz+SgqVhPqLizUuhl7p+8ea9Ho3XkP0BeeQ
         r1WOnnRcE1rLMYlI+iGgqJpj+M3KL48lGNPAq9Nm0IEhgRcfitLq5zTAODqGPHidBIoD
         SX4Rh+AdrBnpNZ4uONzp6uCEpfEAgZkOdEZto/6dJpiyJCoZSfbc/0pZBt74jDbrnd+E
         sVka+M6wU9ckrlsCxBWS0lT9Ods2ElqhEaija6zFAGTSd6iu4OczilNlfP4BUPUPPCRB
         0Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363919; x=1715968719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chW8k3/UFKxLYywJHYuhDfax5Lmwls70ctPbfNY8aTk=;
        b=ag3uKSE2gZvwMMOMLERDqAs9JRX0c9AiEczQ+Pf8U3kKRzSWcyu5Yj757BgjP/xrKp
         HSc1x5xHSthJf9o3FuyGwa51ztSQO/lPgz47Mimfe4yfvlmxP1j9yUz0sq6NcNsiDmBq
         c8/I4Yi7OQyvb0RQVw4EaMivPFLvfJlzBktAWGKTzS9OV9pSsabBoJXFsGqqHcnAMbKf
         aGvzLYDYn8zoj0/az0yESj2U/O4cWihu7LUMHDqhE5ol93UmYF4mzFfhcUS1K+W/JNqF
         tCKoBIhLaMY2img6iEEsgqYzez87QiVMZ5GIGi2qyLkMv14DxDj8M+tGkojXOPBG1VHH
         DDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw9wUC2drlhH16D4gmUP7IGpZFoiZMNalvQd0qbiqnlp84KAnUy/LYUnj39Y2GQycFtsvl3DxMlaCoz25bWysGax4aD+nIwx71Er//
X-Gm-Message-State: AOJu0YxOlpZutDseYGAqVKblK0RrXjW7PwLffxpxxJoZChOU0z1pGpmg
	fjxLKRtvlvplfNXr3sqHGDUl4xNUKMAyV35JVXq82vJb4XIkuguyR9jfk+MB5bk=
X-Google-Smtp-Source: AGHT+IGE6bbbjDSU3mmoZE2LM1xADxiiNXknFfC0dYuVXQiruME24SMVBRxrz9HhVsBKYYWngC7qYg==
X-Received: by 2002:a05:600c:3b04:b0:418:f5a:580b with SMTP id 5b1f17b1804b1-41fbcfb8113mr57250545e9.18.1715363919122;
        Fri, 10 May 2024 10:58:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4200a8e6846sm11046755e9.15.2024.05.10.10.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:58:38 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	neil.armstrong@linaro.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: lpass-macro: add helpers to get codec version
Date: Fri, 10 May 2024 18:58:34 +0100
Message-Id: <20240510175835.286775-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510175835.286775-1-srinivas.kandagatla@linaro.org>
References: <20240510175835.286775-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

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
---
 sound/soc/codecs/lpass-macro-common.c | 14 +++++++++++
 sound/soc/codecs/lpass-macro-common.h | 35 +++++++++++++++++++++++++++
 sound/soc/codecs/lpass-va-macro.c     | 29 ++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
index da1b422250b8..a640bf88a6cd 100644
--- a/sound/soc/codecs/lpass-macro-common.c
+++ b/sound/soc/codecs/lpass-macro-common.c
@@ -11,6 +11,8 @@
 
 #include "lpass-macro-common.h"
 
+static int lpass_codec_version;
+
 struct lpass_macro *lpass_macro_pds_init(struct device *dev)
 {
 	struct lpass_macro *l_pds;
@@ -66,5 +68,17 @@ void lpass_macro_pds_exit(struct lpass_macro *pds)
 }
 EXPORT_SYMBOL_GPL(lpass_macro_pds_exit);
 
+void lpass_macro_set_codec_version(int version)
+{
+	lpass_codec_version = version;
+}
+EXPORT_SYMBOL_GPL(lpass_macro_set_codec_version);
+
+int lpass_macro_get_codec_version(void)
+{
+	return lpass_codec_version;
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
index db6272ee2df5..a94a1d93c19d 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1462,6 +1462,33 @@ static int va_macro_validate_dmic_sample_rate(u32 dmic_sample_rate,
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
+	dev_info(va->dev, "LPASS Codec Version %s\n",
+			lpass_macro_get_codec_version_string(version));
+}
+
 static int va_macro_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1555,6 +1582,8 @@ static int va_macro_probe(struct platform_device *pdev)
 			goto err_npl;
 	}
 
+	va_macro_set_lpass_codec_version(va);
+
 	if (va->has_swr_master) {
 		/* Set default CLK div to 1 */
 		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,
-- 
2.25.1


