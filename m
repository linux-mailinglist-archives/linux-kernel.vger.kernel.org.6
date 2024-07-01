Return-Path: <linux-kernel+bounces-235743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D75791D925
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902A61C21A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB181AC3;
	Mon,  1 Jul 2024 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCLaSNe9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD71482D8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819590; cv=none; b=prYOoh98TdVWOR4I80ppDEruDnQ9ovpiBBAUu2iq96lWQN6Tj+WnF/2GtLs8nMKUKmQJ9cClgRIcojNPqBntzKpKbWS+pYL7FtD9iDvXCF4Yy4vOiBp/BgiNzAbIxEfYtuP+5n79upF15ihQZiixAGka2fBNwJp/42YB2C8hB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819590; c=relaxed/simple;
	bh=aNXS5oDU9Iznltvue5eW7LGccDPE1uOvOu0B8DutizM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmxwZ9Eem3XpipyCcFACarIMdlxV2G3uDH42lygEvEvEIXphG/LzsrUdXCFq7QgZtalyS5OWt+TOBLIen/odlX6CGk6ZD9rEJdSL/WVTfYpvVzC4XcOp1rCZfjcz8Ry66Qyb83ChJEHM5J5lK2iL91+vaot5ALwrTQYhmKZtG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCLaSNe9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42562a984d3so19050105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719819587; x=1720424387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JV+cRI0obrw7Gr1AmKeclFNXK4wRSUvRfIa7nX0CC5w=;
        b=pCLaSNe9M6hk754DsSMD7lfRpCk2cTPFix+h7jCORa1Dik0tb06nF43XJRGoQc3mB9
         3GgRwFdXQy/B126+lLFdSEi0ckyNQX8TQ5tCt8VmFbySIqMuiH9tkeev9QagagmoAkb6
         MztzVXAMjIiGTqEbSPYyvZAtu1+Iv8e378QPzvFeuut/Z0UkRMqACOoaR3rXlvOH0G/5
         dgQC9+xBC43cYgBXb1FuBjdDcaS/kffMHH+1aTKwHZiM6ZVI51eJB17VRUs4jlTnhJPO
         xuxGQSilSyWlD46tqU0Av9ZJq/306GSMrV9b4ORmHtt7VcB64szJv+Vm0MZpP5VsldW4
         dSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719819587; x=1720424387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV+cRI0obrw7Gr1AmKeclFNXK4wRSUvRfIa7nX0CC5w=;
        b=jIgzKlGzAlsL0YYhVe8BuPMd3+4ab9v49RbGRqihm8FXtQucjwQQtbFta6mwguqmCz
         ufepfp2tKpR+29Hogx6rBleWbMLVbdRK5PV6Xt4i9JsqIPB9s1Mbwli1zQHXcwL++EsQ
         Sixj5/klacC80F6QAIgV+KkHZM2QcEVukQsY3AYq/EO+A/Rz4HJ8dYFYwWrpVMwqOCr4
         RgHoyGa3NgCxtN2KVynljNm2JoOyq9pVu+ndqXnc5LetmDrGrm0cpDOuiwArSaKbGqYF
         BK7IgTOO7xcDOWpqUOg4JAOum33t06QnPWdpWrUZfPtMStRINWq8MxkmuOPNvw2xfkU3
         EhKg==
X-Forwarded-Encrypted: i=1; AJvYcCW1gB/cBCpOOuURLwMzQLZWbY+QPcADDq9knvpdW+/Byk0nVuMPXn4+/ssBQMfpfYFz6ocz74MqI0NcvFZ7bgbmce9qJA9qL2J1DmxM
X-Gm-Message-State: AOJu0YwqyNI4OGCR33n7fv0VbVjiTzwB0/TWl7WZVAHn90X1gaYPc5n5
	Vph2rgTwSSMxABlz3MHc3VQmZl2RmUvysTdrBA3JkR8xqbWeYyWL3lL6L9Ufrsk=
X-Google-Smtp-Source: AGHT+IG2h/MuEwnoTZQebFv4r/85gHz9u6yettb/wJx89L0LKVLKCmHMSB/zmGvvRwXSMwxJCfcw+A==
X-Received: by 2002:a5d:5702:0:b0:35f:1c34:adfc with SMTP id ffacd0b85a97d-36775729a52mr2645023f8f.67.1719819587542;
        Mon, 01 Jul 2024 00:39:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb9absm9279936f8f.80.2024.07.01.00.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:39:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 01 Jul 2024 09:39:33 +0200
Subject: [PATCH v3 1/6] ASoC: codecs: lpass-rx-macro: Simplify PDS cleanup
 with devm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-qcom-audio-lpass-codec-cleanups-v3-1-6d98d4dd1ef5@linaro.org>
References: <20240701-b4-qcom-audio-lpass-codec-cleanups-v3-0-6d98d4dd1ef5@linaro.org>
In-Reply-To: <20240701-b4-qcom-audio-lpass-codec-cleanups-v3-0-6d98d4dd1ef5@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3634;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aNXS5oDU9Iznltvue5eW7LGccDPE1uOvOu0B8DutizM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmgl07ZZ/P0X2KbPfUiKc26QrbS8ijbeuElhemc
 0YPAc1aqKWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoJdOwAKCRDBN2bmhouD
 15HHD/0ZHIWDX7+vSu+VVLfTCkXyU0PPIYh+vbTkyulS/CJ/ece8SI3bkYXj+QUATQJRxQjQGMY
 uboQLbCcXh2A7dhSgLPIJ85W7YyIl5GbUw934lXELcxrcs0RZVhQfDFND4+aRi3oNwOqXUqW2UM
 HvAdb8RhF2kEn0PW4TiE2IFbGcrs0k58KTPVwcaLrTNzIFt4aHr9UAXctUUZ9lONL8+BYwl8Z/2
 /hKdpuccDFw2np7hokPiG5SOG2I7b1uXB3rsIFciah9lq0pdgbnSpsu4sKCuOt2au3ZK1ORGpXl
 U1WlcEh9YP9PJhFCxkahWCL2LqSKqtf9be7/rFxARIM5PkMd/XtifW0d/Px5bMqgsXvyt3/8nLk
 Uc8z/ZP6BjfzypcJTTLcYWR8iYBkPFrdTlPYjEHTJlvX9RHixmueA1z24C0DjexE4VPBXY79Kfn
 HZVALa21R9PaaQZXXXcZNoNZku5ge/00pd/NXU/soo7OFGXqRAOLLLJQdaxPeiy756LJcoVHedF
 xQ5MwiEanqOu7o9NUXddzma2xU+t1DXHp5ccnWotr5J2z9UaAVczlSL+P2v7PKPi8r4BYPvlEAG
 MAaj9JeH6hU7XurMb+QfLtLQ+C3Q7vPTUdnr2e6NQG2U3FRerE7cq+gf2wHVuaV7D7veizXo5Oy
 r3PXljUj/+SxO/w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Eliminate PDS cleanup by using devm_add_action_or_reset() which results
in one less error path and smaller cleanup in remove().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. New patch
---
 sound/soc/codecs/lpass-macro-common.h |  5 +++++
 sound/soc/codecs/lpass-rx-macro.c     | 30 ++++++++++++------------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index 3aa9737f2737..21cb30ab706d 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -41,6 +41,11 @@ void lpass_macro_pds_exit(struct lpass_macro *pds);
 void lpass_macro_set_codec_version(enum lpass_codec_version version);
 enum lpass_codec_version lpass_macro_get_codec_version(void);
 
+static inline void lpass_macro_pds_exit_action(void *pds)
+{
+	lpass_macro_pds_exit(pds);
+}
+
 static inline const char *lpass_macro_get_codec_version_string(int version)
 {
 	switch (version) {
diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index d47c49c90de3..77e734ad1885 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3803,11 +3803,14 @@ static int rx_macro_probe(struct platform_device *pdev)
 	if (IS_ERR(rx->pds))
 		return PTR_ERR(rx->pds);
 
+	ret = devm_add_action_or_reset(dev, lpass_macro_pds_exit_action, rx->pds);
+	if (ret)
+		return ret;
+
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto err;
-	}
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
 	rx->codec_version = lpass_macro_get_codec_version();
 	switch (rx->codec_version) {
 	case LPASS_CODEC_VERSION_1_0:
@@ -3818,10 +3821,8 @@ static int rx_macro_probe(struct platform_device *pdev)
 		rx->rxn_reg_stride = 0x80;
 		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_pre_2_5_defaults);
 		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
-		if (!reg_defaults) {
-			ret = -ENOMEM;
-			goto err;
-		}
+		if (!reg_defaults)
+			return -ENOMEM;
 		memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
 		memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
 				rx_pre_2_5_defaults, sizeof(rx_pre_2_5_defaults));
@@ -3833,18 +3834,15 @@ static int rx_macro_probe(struct platform_device *pdev)
 		rx->rxn_reg_stride = 0xc0;
 		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_2_5_defaults);
 		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
-		if (!reg_defaults) {
-			ret = -ENOMEM;
-			goto err;
-		}
+		if (!reg_defaults)
+			return -ENOMEM;
 		memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
 		memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
 				rx_2_5_defaults, sizeof(rx_2_5_defaults));
 		break;
 	default:
 		dev_err(dev, "Unsupported Codec version (%d)\n", rx->codec_version);
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	rx_regmap_config.reg_defaults = reg_defaults;
@@ -3927,8 +3925,6 @@ static int rx_macro_probe(struct platform_device *pdev)
 	clk_disable_unprepare(rx->macro);
 err_ver:
 	kfree(reg_defaults);
-err:
-	lpass_macro_pds_exit(rx->pds);
 
 	return ret;
 }
@@ -3942,8 +3938,6 @@ static void rx_macro_remove(struct platform_device *pdev)
 	clk_disable_unprepare(rx->fsgen);
 	clk_disable_unprepare(rx->macro);
 	clk_disable_unprepare(rx->dcodec);
-
-	lpass_macro_pds_exit(rx->pds);
 }
 
 static const struct of_device_id rx_macro_dt_match[] = {

-- 
2.43.0


