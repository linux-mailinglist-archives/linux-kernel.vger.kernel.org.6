Return-Path: <linux-kernel+bounces-211880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A3B9058B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED38DB2C60D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB657181B84;
	Wed, 12 Jun 2024 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWbcJHlV"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37722180A8C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208947; cv=none; b=QS9c1rs92NPfEVpyB6lrcJpIJcLW2k+whi0Zq9j3/ZU4xSLk6CzZdx4moAOkLXj4MCERPlPLRu7TQop5U71AaT9hahHmkUXYUqwsgOvj/+hPOp7/eMQTSeLPCkCVRYIo4T1cKdLsZ5U7F0Mt/L4XQl+TSbeTLeKyOaU0+03ndS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208947; c=relaxed/simple;
	bh=lGtoXBpE7BDm5Q/i2Wcu8KAtimyFq3GJwH5lkJgYlCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvyx3cJDXA6N6Tm7gG+4qqIkcM1oMuB2cBvhCEjIqu9o8yFwOrSA8dixHKdazYvmxuuhesw8eQrL9fEAF7q7z84krEBquRESaCPtXUP/UaCKGlpuxy09+FXGVE/sip8TBj4UXFD38NoCZeOQX531WcM8nbnovc2ltdYB3T4J1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aWbcJHlV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6efe62f583so6243566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208943; x=1718813743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9YTFDAJLldVwDTE+9nejuBs9to0bqe8LPxJleVEXTI=;
        b=aWbcJHlVbgl0H2rdqUKikshzlmBXR69FIFzTv69awUB1vR/oLZrK7RMn4n4Q8mqJXZ
         4uzYUOWCO4edG9s6VBNOWCDIHqsEXZsS6Ee37XZsCk04jR+82ARrgSt5tHYsMj7HnRcc
         ovJUBUPynrPEeAyq+EonliKKS96TmAnCGSrvYpgbA/StyCG1XDfBy2fLdy2dhKAypv4f
         WQ5+dz0s8OmX169+1MPtBI9mLzGiYl4N9w7gP7xSE3JRMINT7MH3ZR1Zo8BWPg1Yv1BM
         tF5j9Y4ygfoxn12Svf5YbwFqug1W8vlh583ywnvrf6MdLhKgU74w4G81omr3ojHVNFx2
         6pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208943; x=1718813743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9YTFDAJLldVwDTE+9nejuBs9to0bqe8LPxJleVEXTI=;
        b=OsPHxVZ+XWEIYzRCQ90D2JI1lsnVhYOt6nuZDULaQ9FJ+y+vIW3Wf/ex4JzNSgnPpC
         Oj9mOBLhA63lV8i1JherrUe0m7I8IJmXfp79gkbO78GCvSu85twkPHAdZIg4TyCZCOMA
         Ph2Zaa5JSykUfTYTLQAxveDnxxScVTjf1zv6S4p0YuYyC77oshWl2PcwMtbekRQ/lMSD
         SuAkSZZSzqxdC8JzTVToBDJoEipfQGXUe2L8UP+Gfo2Xm3mmtOMWHaU6/1Cw3VGBKmU7
         m4N+7IuTLHqLDuaazWqQQXTEgkzrLdiXU8fCUV2avEEXRoUfUST3Vh8DP67J41d4uIul
         3/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzlDL8iBJ0AbOglq3q5sPujMCtPGPlsO+tVsggmfbRzGkMJ8N1j8OlVNA4EhqrZH2DTg7J14e8hhkNpTRVOOmCG1Uxe4EU+Cg5lPc2
X-Gm-Message-State: AOJu0YzHKYyjYfVU+n1cEN6gXu2IYLf0+MjybxUKkwGLpGibTDph4kc9
	eLnYLjIzQqlu+B0gvD41QnkQxFJ226kffsH0if7rxhtlw/SYOyv3BPR9v9kOKNQ=
X-Google-Smtp-Source: AGHT+IHyqUxUeWkSg1n1U8oNvkVbbey8z/8Bqdaq6epsNoTgDYD0JfIM/ekgt7b5n0xo20G2rwmO0Q==
X-Received: by 2002:a17:906:55cf:b0:a6f:1f67:9815 with SMTP id a640c23a62f3a-a6f47cbf200mr132578466b.33.1718208943604;
        Wed, 12 Jun 2024 09:15:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:14 +0200
Subject: [PATCH 01/23] ASoC: codecs: wcd-mbhc: Constify passed MBHC reg
 fields
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-1-0d15885b2a06@linaro.org>
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2446;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lGtoXBpE7BDm5Q/i2Wcu8KAtimyFq3GJwH5lkJgYlCk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmXbkCdl7gUWmJ4PrYh5YY44RWpc/Hr1isIl
 6mOhW2URX+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJlwAKCRDBN2bmhouD
 1/0oD/wK37LUGMcsFyd0V3lhgpczQVaknnrVNkiMiWdEt+e6xIeZe0DXhnbdD3WQcNCxP4iPBtS
 luPHSRAve/nIvjamz/2Uvpj/AYXmdkuZnUDyy/uPlLCBwDgUoX/bJbgyqxFsb416+mjQEVrd9Fc
 LjeyEv3KG+T2JB7strwvK8jmmKcNUW0ia7cHWHV68EfSNuvALNeHZqeaE93j6jGqq1vpZiRqkXL
 9ayNhupSwpG/f00+Ivuwfr28cgxgGlf0dYV2zDz2GH+7dMn+egsbMl1lzhc7/syObHRHyqj4eoK
 VWevQEnDQFdQ7YUeIJAsfMXcc87flB+HqFsl+it1C262Oe9QI9ljEzPiaEagD20VtuNvfQOh5Mg
 0wL3LJ1wf5MfORQW8I87h3lIvLR8/rnSmNzaZ43TVK/r11Pa9VomoJ8WTsCQGunN5taUrQcu6vC
 I90MzIUGiOC8K0OZ97mu0l8GXIAzLGbYZ11XSnxvsCSEvoJFamQPiD3r9aP/Kn65aEdZvJ8BDTO
 B+GUksYmNyQgMkzUod7U+h+UIDeF6/jCjD6Up4R8ZyU6kczLsvysNjs3S7ytDp4RqFLKFq/6v7s
 +0DB6AyHkM8xhrKZOV55+Yb+kVD9NG6Pkx8cnRfxTMQd4OZkF4G8nTNno/ckGclPOSufkUPyCnk
 JohcYRKSVGUSygg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The wcd-mbhc-v2 helper code/module does not modify passed array of
registry fields, thus it can be made const for code safety.  It will
also allow individual drivers to allocate the array in rodata.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 4 ++--
 sound/soc/codecs/wcd-mbhc-v2.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 0e6218ed0e5e..d589a212b768 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -50,7 +50,7 @@ struct wcd_mbhc {
 	struct wcd_mbhc_config *cfg;
 	const struct wcd_mbhc_cb *mbhc_cb;
 	const struct wcd_mbhc_intr *intr_ids;
-	struct wcd_mbhc_field *fields;
+	const struct wcd_mbhc_field *fields;
 	/* Delayed work to report long button press */
 	struct delayed_work mbhc_btn_dwork;
 	/* Work to handle plug report */
@@ -1505,7 +1505,7 @@ EXPORT_SYMBOL(wcd_dt_parse_mbhc_data);
 struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 			       const struct wcd_mbhc_cb *mbhc_cb,
 			       const struct wcd_mbhc_intr *intr_ids,
-			       struct wcd_mbhc_field *fields,
+			       const struct wcd_mbhc_field *fields,
 			       bool impedance_det_en)
 {
 	struct device *dev = component->dev;
diff --git a/sound/soc/codecs/wcd-mbhc-v2.h b/sound/soc/codecs/wcd-mbhc-v2.h
index df68e99c81a3..b977e8f87d7c 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.h
+++ b/sound/soc/codecs/wcd-mbhc-v2.h
@@ -279,7 +279,7 @@ int wcd_mbhc_typec_report_unplug(struct wcd_mbhc *mbhc);
 struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 		      const struct wcd_mbhc_cb *mbhc_cb,
 		      const struct wcd_mbhc_intr *mbhc_cdc_intr_ids,
-		      struct wcd_mbhc_field *fields,
+		      const struct wcd_mbhc_field *fields,
 		      bool impedance_det_en);
 int wcd_mbhc_get_impedance(struct wcd_mbhc *mbhc, uint32_t *zl,
 			   uint32_t *zr);
@@ -300,7 +300,7 @@ static inline void wcd_mbhc_stop(struct wcd_mbhc *mbhc)
 static inline struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 		      const struct wcd_mbhc_cb *mbhc_cb,
 		      const struct wcd_mbhc_intr *mbhc_cdc_intr_ids,
-		      struct wcd_mbhc_field *fields,
+		      const struct wcd_mbhc_field *fields,
 		      bool impedance_det_en)
 {
 	return ERR_PTR(-ENOTSUPP);

-- 
2.43.0


