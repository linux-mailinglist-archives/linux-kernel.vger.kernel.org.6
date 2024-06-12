Return-Path: <linux-kernel+bounces-211894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3FF905876
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A57E1F21506
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166B1862A0;
	Wed, 12 Jun 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yV7bjPy5"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45E186298
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208966; cv=none; b=EseI7hqjO7l/dHwnFqnShsDljcO3e6TSCNHMDlh0vd7duXEFyD0VHwY8a017yJAGa9oHYs0M6N9kPlNnHIkpnM5ienveybJsm9W0hqOQEi2BlsT+0IsC6mdofcXThKh6hr5973kgosZPe56SyeMlmTVPZy9akYXnab6YvMXxyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208966; c=relaxed/simple;
	bh=DfQrCy7EPdHobgPyU9Z15QMCzkozExD4qQYmVl1720A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5uVPxrASxNUqQoHiz/xkLxr2e/DWuHeSIIprjcw/2r3QFXf/pVH5MpzV5+uTbLe5sWjzJK4EEXwEfnTgUBJ23vdxwHzue8qELzBsT0R27Tsy6UIW5lGvDX2Q4J329gQylfu47PGV5K8swfVMMtdnOwDZHCllbw8ZHBmgdlnDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yV7bjPy5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f3efa1cc7so197182666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208963; x=1718813763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2qLhgW8KCLNLm5E9+T5V7rINfGXJY8In7L0xJk0yrk=;
        b=yV7bjPy5N+YVuJaKhFOHeGIRmJRVgaj2LgilyAjmLpaI1zf0n3iaWafZyA9Eu+vV58
         BElwBdkzhYSW6LhJZwzn3qs+4crcP8T+BHaIylJv+SDubsN8D1qRd6buda28CH/bV2HL
         yBmEq/uQbtu2d65ET7uL4rceErwPbvaNMPYxZQEVoAFaLjsp0xg2wxISyakws6Al++8e
         1dgOB71s0REsoqdRAuWa8w65rJl9fZ+ZT0P1rTZEeluuchN1Od3c37CtzRl4KP/VbM8m
         Atbvg2V6EG4oQtrCG9VaBd+JmFvht7l59XPE0Lpf5Rify+9QR7PVTLkZH3RbV2Kq2qwi
         0e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208963; x=1718813763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2qLhgW8KCLNLm5E9+T5V7rINfGXJY8In7L0xJk0yrk=;
        b=Lo/Ptzfbo4ulCsWVLLBu3UcmHZylZM/jcvQDpHtBgpWUnzJK31JTT70yYSv6l0J0aw
         cDu2VBGJX8s5tLZbYxlCz4Um5IOyYwEEWU0y1crLnOhsItc6yidcLDHdxl07H0ywbfy7
         nVWuZCemzcErCH3teHxDlCyMfxNo6wzm9K9DwO+SuT7CfACCD6P+B0eD8Vg2brvOoyYw
         1YTxXiQ70nf/vAMQJpR7k9edQ7mdaQlhG6jA8Y0MiHgXI+WA9QGzzhUtrdaPXGZKtxPJ
         i6MaUw5t2OtBsd+liAKkXugSbtrqonTkoa0cNx4fgFJZeyJBgb7z65jQ7Z1PMkAFMtPs
         lvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgEmSJA59gzxeVzcyXfDihF8OpvGyOjQwEU6T4AmG33l7BrBWhxABbNX+HFcF1SNgRLKxNl8RWUeQTnLqVNGPzsXGpoTnKYr0utRSe
X-Gm-Message-State: AOJu0YzsTQ9i2aOVFPaqME+xJtDO7Juv+yzbU7V09Tb/vGxNgrOOM7M+
	9XNM/UB0JI81UXyNkc73nXdDpwdbsX/7+Dd0Mp1Bomo7XSfIunWaNttxT+Fya3k=
X-Google-Smtp-Source: AGHT+IEaxDscDTCz98NySxu5kWNh8RbOVnW92/hmTae69P40NS2kQrWhez3Q7lBBRuGgxN9hl/EswQ==
X-Received: by 2002:a17:906:27d6:b0:a6f:4232:4370 with SMTP id a640c23a62f3a-a6f523ed34cmr9882066b.5.1718208963267;
        Wed, 12 Jun 2024 09:16:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:16:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:28 +0200
Subject: [PATCH 15/23] ASoC: codecs: wcd937x: Drop unused chipid member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-15-0d15885b2a06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DfQrCy7EPdHobgPyU9Z15QMCzkozExD4qQYmVl1720A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmke3u0kf8lnyb0s0QfPL8aI/2dH2R1t684n
 kmKyhh8/siJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJpAAKCRDBN2bmhouD
 1x8cD/9qfnVnoulRcTk6aU0YK+dtSPJsmk9BsXwzTqwP6Ehddbn+CarFRP2bjWywEuweaxNGAl+
 QaGdzy8AFkLtQzgtJFZr3nf/CShN+mvfOIH2zK7VmnhYihL4+AW6RS+Y8Bm21xvFFGbZejrOKQa
 9l3kfbRn5+8s5ZIxIQ+zba/V+sZsG9fAYIAO560YoCCejowEl60W7uJ3+yntEBo2ADlE1xsdnCw
 OH9NOL0L+V24troQbqXV2v+tN6txvfka2NGDrIDNfVoFfipZlijd/8I14YSnoZwFgBARcyqCFyg
 CoZX8HVQLxLFfo1ljtLJAahgmZQ/XRDZj13hM/TF52MaYuV/zaSW1Jyw63Qn2lAn+0zvojZobnG
 7RXw8KUbnOBc+tecVdA441Nz68RKgnx0M9r4EOl0j9rb2TwsfeT3vjGJHU3sxxbwnzamMTqK3m3
 JVSrInxoo4VVwvrCbRTNk7WA+a20B4A/jhRwUq8//Gtusg7D4jt9ahU9OOy/aTo7fEECG1ZYF61
 ysCZxeUFm2vdapjO40MtZC+DJjmeuCCaN7p0jYl+UTgiKPR4bJHo/qy/zXr67r/0bkl1BF9LzAs
 DEVKCINiuMNGwbtL//wTaiUlfmVwvC5RxShzuz32ycPERp750AWQkqX4ZBNGAJq6kL5/W8+Cts7
 TSWOUyWEsbCbCRg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The driver stores the read chipid in 'struct wcd937x_priv' but never
needs it after.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 96e2989f9722..4beb70bc4d8c 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -99,7 +99,6 @@ struct wcd937x_priv {
 	s32 pullup_ref[WCD937X_MAX_MICBIAS];
 	u32 hph_mode;
 	int ear_rx_path;
-	u32 chipid;
 	u32 micb1_mv;
 	u32 micb2_mv;
 	u32 micb3_mv;
@@ -2539,6 +2538,7 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 	struct device *dev = component->dev;
 	unsigned long time_left;
 	int i, ret;
+	u32 chipid;
 
 	time_left = wait_for_completion_timeout(&tx_sdw_dev->initialization_complete,
 						msecs_to_jiffies(5000));
@@ -2552,11 +2552,10 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
-	wcd937x->chipid = (snd_soc_component_read(component,
-				WCD937X_DIGITAL_EFUSE_REG_0) & 0x1e) >> 1;
-	if (wcd937x->chipid != CHIPID_WCD9370 &&
-	    wcd937x->chipid != CHIPID_WCD9375) {
-		dev_err(dev, "Got unknown chip id: 0x%x\n", wcd937x->chipid);
+	chipid = (snd_soc_component_read(component,
+					 WCD937X_DIGITAL_EFUSE_REG_0) & 0x1e) >> 1;
+	if (chipid != CHIPID_WCD9370 && chipid != CHIPID_WCD9375) {
+		dev_err(dev, "Got unknown chip id: 0x%x\n", chipid);
 		pm_runtime_put(dev);
 		return -EINVAL;
 	}
@@ -2605,7 +2604,7 @@ static int wcd937x_soc_codec_probe(struct snd_soc_component *component)
 	disable_irq_nosync(wcd937x->hphl_pdm_wd_int);
 	disable_irq_nosync(wcd937x->aux_pdm_wd_int);
 
-	if (wcd937x->chipid == CHIPID_WCD9375) {
+	if (chipid == CHIPID_WCD9375) {
 		ret = snd_soc_dapm_new_controls(dapm, wcd9375_dapm_widgets,
 						ARRAY_SIZE(wcd9375_dapm_widgets));
 		if (ret < 0) {

-- 
2.43.0


