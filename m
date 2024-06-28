Return-Path: <linux-kernel+bounces-233737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08BF91BC68
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AD61C2255A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CAF156887;
	Fri, 28 Jun 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pd7Zbhmb"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92115155351
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569498; cv=none; b=bMYjIn4aVjO01xzNNQoVVLO8mZpP7OgR2YPumB5tga041RPwENIR5q39iJV2/E/m+FVoXC2zpFWkUvftLKQCs8Kbaskav4ao2+//H41NcEFOsf3eSXsRyKb1pWUiCzQ33ICr8mmoW5KSnlKSn9fdGLFa9VxyjH0SMvPPk5h2cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569498; c=relaxed/simple;
	bh=ycHPrSfshLbhaVlOmSrBNFLaE6akGY9mtxIkStrGvh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W3SZjGPA9JShsvgYJU7pSDjz97uJPIuGd4kdxs/aPcsJ0rl+rWcAsxriFuKFOKBhwrHs+G9XDyYLOjRok4RE60npbgghJzCSUVF6iTbbYtxFeslhk9rPKN61rX3s9Y2mUawpf1Cs9y2k5QN44ffYTL+yZcmdfY18NEOu3KQ8l0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pd7Zbhmb; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so4105481fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719569494; x=1720174294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrC0oanY/xXM5tNplzJFb5TLPsl7ab1mW6qPRTKsSC8=;
        b=pd7ZbhmbHWGhpEdY4t22PR5RaAN0bKwhfpH2DKMrAxccXD5WGm6LXIXBCr0CEAMiCy
         xuBiQAm5ldcgaYmoI7cnIraod2IqFB9kcuhgggRDVAz+cXmPmYgtHDAr2SQ7xfDAZx/x
         au82rdLAv9T25tAWSZCWSYcegrC/8a02ae610qiVkV5NXJbLOKXlJOGBF35tpb2r9MOE
         rdECP+O2py3dF5rWod6DFXlrods9QP+7pL7n0ZzNYPMp/wd6TBcz5gByv9iPFczbx87g
         cQc+MLUjJ+EAL00xTxQ3FTTn38p4rjbqdL2BnYetVGFZ2y4R34VLxTqRkpRyayykMkKU
         v8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719569494; x=1720174294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrC0oanY/xXM5tNplzJFb5TLPsl7ab1mW6qPRTKsSC8=;
        b=eIbo/Rz0MKYlXTZAPI9jBmpnmbcBKOAFdP4Fp/xdD4cIwyfWA4q4U+2cQXLhXaIWSX
         oKpihoDXjv2SCIYutM9qwIa0HSgWiNuoA7S5RG7H1RlK4EJgo2QPsruaOBlTU/t2p8TF
         hL7GHM8lqfgzqNMCqtZb/ZzsgcGNBJ+kMvkcFCZrEZPCZ9sJq0HJiwkp0L1shIsa+HQM
         iDjbzQqBpn842ggJgOakZNgcIbSnf7rQ3yoaIZ/RRUJSVHiuJS0R3sDYU9hqGJsFyfHG
         +tc2AJ2xeo8uyhaL18if7um/1F7oYpzNzao5nXwCVS9cTIsSlN5+/2cPWV8kiylV59Te
         Ya6w==
X-Forwarded-Encrypted: i=1; AJvYcCXTDjoVk7LEZh0IbXtoy8X0d15etmDf5ziKt5ysmjebFS4gXI0Z/DJVdueOnyhmrARj52J6RNNQ4+Cylto3EV2vrEnMLg2iSz/splSN
X-Gm-Message-State: AOJu0YynmOqakrpj+nWWO6iRVZoDXdVmNLONHLQufbpOuV1lwuvVnhyA
	w+NbtUUkI49YznzDSnpugL5iVgKLQzvT7MdACw89al0xHsGjwoY38Yu+aE5l+CI=
X-Google-Smtp-Source: AGHT+IFKhIJpRNXOaeJJ2eW2v9e+5Ei4zrnP5FIL9QTBjvfsw4tDY8rG0xk7rsZ1cWCftr3DLKVXYg==
X-Received: by 2002:a05:651c:10a2:b0:2ec:5cfe:2e99 with SMTP id 38308e7fff4ca-2ec5cfe2efcmr86889161fa.6.1719569493806;
        Fri, 28 Jun 2024 03:11:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c15f8sm27024605e9.47.2024.06.28.03.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:11:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 28 Jun 2024 12:10:56 +0200
Subject: [PATCH v2 2/5] ASoC: codecs: lpass-rx-macro: Keep static
 regmap_config as const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-2-e9741143e485@linaro.org>
References: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
In-Reply-To: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ycHPrSfshLbhaVlOmSrBNFLaE6akGY9mtxIkStrGvh4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfow+5/Q8/abTSGqS3WeeJmNN/eGY2CApICxtv
 1RpQy+alaiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn6MPgAKCRDBN2bmhouD
 1z1SD/977JGgYit9iIszAbc1+SmnkFG1Z8kCb/Hm66RsrpD3PCec7xncGbzpllIJD25/MWPHp3s
 KeYM25mJNwmtrsXQ2yAc1Mje5nEN6Oouc0m7Wt4UQUNvKGJ38kDZ7/zhj1H8bQ81swJyEFnDBT4
 +0ibiITHjvLRXNi/1kQ1e2PxR9s9P20Uwxc0PD65gCXuIjDT9wsl0fpk3kH9t2C8w5TR+TwAkpw
 Mm2vgKQoLVlLyNE7h45yUka8PXhaDFqZ+7oOt1EYcYTv+h9nrk+YaAx9lkjxhZ3PgvuD7JccnKu
 ldQy3ghq9c0MgtN/S+JwHESNLt+OTx0IaKy9W/IohMVioYPFqVYXJVUyBBK8oXmbEjgv1bEI7do
 3WQGEdEseFyaVbxm2uTD4gSEu7RER7FK9TtLTV/nxIZYxxy+QB7+DJaZRm5ib5Uv8ncmz07NMtF
 Jd+CWFUp3UZQKvCgc/Po6aTyAQajsF44iSbqV8XwLhC1m5WXe9loIEJqGkgI+iLWCL2Mqju8E5Q
 NK1VsC+W8KlfYce5yJoV7D7ohAJfGxoti96qi0H/FWbTGYZstQDvKbUICAVcRImPV7DXbKST2rI
 A4Ba+TyOP1XmyZrzMxoqKNasLw8KlgceFqahbL7BiX+7IdW/yn2LiMW5gkA3XC4nh0wg4LM5Ohn
 1cPt/M88ksZ2LIA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The driver has static 'struct regmap_config', which is then customized
depending on device version.  This works fine, because there should not
be two devices in a system simultaneously and even less likely that such
two devices would have different versions, thus different regmap config.
However code is cleaner and more obvious when static data in the driver
is also const - it serves as a template.

Mark the 'struct regmap_config' as const and duplicate it in the probe()
with kmemdup to allow customizing per detected device variant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not adding Dmitry's Rb tag, because of major change devm->cleanup.h.
---
 sound/soc/codecs/lpass-rx-macro.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 4cf030760d74..1d2dce1f600c 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -1663,7 +1663,7 @@ static bool rx_is_readable_register(struct device *dev, unsigned int reg)
 	return rx_is_rw_register(dev, reg);
 }
 
-static struct regmap_config rx_regmap_config = {
+static const struct regmap_config rx_regmap_config = {
 	.name = "rx_macro",
 	.reg_bits = 16,
 	.val_bits = 32, /* 8 but with 32 bit read/write */
@@ -3849,10 +3849,18 @@ static int rx_macro_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	rx_regmap_config.reg_defaults = reg_defaults;
-	rx_regmap_config.num_reg_defaults = def_count;
+	struct regmap_config *reg_config __free(kfree) = kmemdup(&rx_regmap_config,
+								 sizeof(*reg_config),
+								 GFP_KERNEL);
+	if (!reg_config) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
-	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
+	reg_config->reg_defaults = reg_defaults;
+	reg_config->num_reg_defaults = def_count;
+
+	rx->regmap = devm_regmap_init_mmio(dev, base, reg_config);
 	if (IS_ERR(rx->regmap)) {
 		ret = PTR_ERR(rx->regmap);
 		goto err;

-- 
2.43.0


