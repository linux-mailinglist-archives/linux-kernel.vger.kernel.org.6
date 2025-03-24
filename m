Return-Path: <linux-kernel+bounces-573542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1920BA6D8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB3C188C97D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817D25E804;
	Mon, 24 Mar 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OP0G0fud"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64125DAEE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814386; cv=none; b=QolM1OE3CyPLa1SiZGCKXKxfwfJkQHNmN5f294N1diwFAy7wHSB0oyi14P8gdEylEXscF9CbGbLzbL00TcAUDs21jiSol+fHKYVQhhKJO58e7r5iEwF1vGLjLlO+5ROXao1k8YL6jkSr+BRMgQTZqYjiKu1rK7urDEdHl04vMns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814386; c=relaxed/simple;
	bh=hJEhHBHgmcwkLGn7ADU+TBJtnvqkH4aaspjSeICJrEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bm8RNHTUvX63fW0OjqPJKZMHmLgDBPFxoXbmOw1l5pdJhd80I9c3r6R33qMhslL/4QhpkMvpQDSTM3vx7w0P9G3kIPxyi1xH9breu/tEvAzkQA08P4+fpYHi5TfP+CGT24i1ulDOBX3pIT4BVdFpHvw0I0MzM+eibf9iroqxJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OP0G0fud; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so42886025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742814383; x=1743419183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPKG26aBT6MGmMvi54w+dEW5MMoDzMUIu/y68UikHrA=;
        b=OP0G0fudBOMuDTYpQc+MYNOslX8nCOMxukLCrbaoFrjTTgnppeHyj68+1muif1hQJu
         PDmuix1MuSYufZ6Ca1zILayG8LZTGCKiSGJURxDjYI7s7QqncpciuvKKnT7oI/YsVsgL
         JdJKJLR8tz5wEgTM9OHxgQQMEIcXyx93BTWwWfJSbOJSG9QdU3/1i7KR2MK2wAH6zjtU
         ggAbA3LzruzN33xx+Y5McfexHOButjSNigNCQ9/JvrVx69qZCrKjFPjNgmDldv1XiTg3
         tK1ge8PJ96w/q0/VZW1gFWegyKuo5Btecb9cAtfKrK8lsvvghCEtqU7aSekdvZ8w6PAs
         zjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742814383; x=1743419183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPKG26aBT6MGmMvi54w+dEW5MMoDzMUIu/y68UikHrA=;
        b=Ws7gVB5cTOZDIGs6cHNs6iHeMrcEMjEMawh1ITQvfKISOwo1LcjuuQryOt8MBBc/ft
         m1UFZpu6MRsW6BuibVHsTQbL7+othx6KmhrSN8f2kjrats39P2L6Zv60BXELDov7MnDJ
         ylNYwk39k12da7wcM9ofhSr9k6P5/WCtTJkMK3ouH2+m7kNW2dq8jh7Jqu29t6Yd4Nbx
         o+5U9iuRl4dRsVAc3d2VlCJ3UdqjxCD8+suzS4ulct3wk0q9+RMD7zJzntwyN394kc89
         1lFJ0LaxP7O0yWqDF0Lj3yUf2CAqk1zB2Pp9bGBOJYcCPasWgQAjSDidGzXYtkXAAQVO
         iRrA==
X-Forwarded-Encrypted: i=1; AJvYcCVqI+BhA1XWJw9wPrsrV3idxQVkggMboLDnu9wTHPvm+sL996XSn2n8AFC6owlxI/tSzWanKgRiIc/3Rn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+cfGMQVG5zZUPtULeXQF8B1q+cEsOZFRkMHhhn/gmbGlYonBo
	eQfDFe32BL+a3LAgKHXaYSIVYubo9aj+8rcop99SH1xsjOlLMs7X0h4vfNtecvA=
X-Gm-Gg: ASbGncsnvHpXr0csxGZHWptj2aFjW977TDgHNgPP3lstl5a7wzaT7AAc+m0ux259Lw0
	cciylC8wWtNMB4gGRjGpgkbhGEFXuVrhS+k+2hib7CfYzQb9E5v0aP8/Zr5U+dTRcRiK6jMa02s
	R47EQskKbUoQbLCSAy0W+BrWyJ7aT9+2HEDNvjZH9Vs4nG8pHPPktmpp1MEGoVVJqxEQkkEGyIc
	hqEEr7z3xKOQpdCpFy1C2HrGNUdol1k62RJjO18/bHr04J8ktTjGFxKh3w/kfJLJcXLCdDkcwMB
	U6tYcDyawMBL0vrmML4zmn/SgYNDXnXvZdoXSkqkRMnaY/wQ6mAXd8lUDmPy+FoUAYCo/w==
X-Google-Smtp-Source: AGHT+IE1jZHrjOD2g8W4miciXLAyYGR2Tj9IVw9a5z+cfuvRrt3sxt3ObBT0ascVcQycuA++hMQs9A==
X-Received: by 2002:a05:6000:154a:b0:391:2ba9:4c51 with SMTP id ffacd0b85a97d-3997f939077mr11706700f8f.44.1742814382775;
        Mon, 24 Mar 2025 04:06:22 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd28a46sm117236055e9.24.2025.03.24.04.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 04:06:21 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 3/6] ASoC: codecs: wcd-mbhc: cleanup swap_gnd_mic api
Date: Mon, 24 Mar 2025 11:06:03 +0000
Message-Id: <20250324110606.32001-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
References: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Remove confusing and unused argument in swap_gnd_mic api, the second
argument active is not really used, and always set to true in the mbhc
drivers.

The callback itself is used to toggle the gnd_mic lines when a cross
connection is detected by mbhc circuits, so there is no need of this
argument.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 2 +-
 sound/soc/codecs/wcd-mbhc-v2.h | 2 +-
 sound/soc/codecs/wcd937x.c     | 2 +-
 sound/soc/codecs/wcd938x.c     | 2 +-
 sound/soc/codecs/wcd939x.c     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index d589a212b768..4b7c3d6080a1 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1260,7 +1260,7 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 			if (pt_gnd_mic_swap_cnt == mbhc->swap_thr) {
 				/* US_EU gpio present, flip switch */
 				if (mbhc->cfg->swap_gnd_mic) {
-					if (mbhc->cfg->swap_gnd_mic(component, true))
+					if (mbhc->cfg->swap_gnd_mic(component))
 						continue;
 				}
 			}
diff --git a/sound/soc/codecs/wcd-mbhc-v2.h b/sound/soc/codecs/wcd-mbhc-v2.h
index b977e8f87d7c..a5d52b9643f5 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.h
+++ b/sound/soc/codecs/wcd-mbhc-v2.h
@@ -194,7 +194,7 @@ struct wcd_mbhc_config {
 	int num_btn;
 	bool mono_stero_detection;
 	bool typec_analog_mux;
-	bool (*swap_gnd_mic)(struct snd_soc_component *component, bool active);
+	bool (*swap_gnd_mic)(struct snd_soc_component *component);
 	bool hs_ext_micbias;
 	bool gnd_det_en;
 	uint32_t linein_th;
diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index c9d5e67bf66e..b2fb8520c823 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2646,7 +2646,7 @@ static void wcd937x_dt_parse_micbias_info(struct device *dev, struct wcd937x_pri
 		dev_warn(dev, "Micbias3 DT property not found\n");
 }
 
-static bool wcd937x_swap_gnd_mic(struct snd_soc_component *component, bool active)
+static bool wcd937x_swap_gnd_mic(struct snd_soc_component *component)
 {
 	int value;
 	struct wcd937x_priv *wcd937x;
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index f2a4f3262bdb..dfaa3de31164 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3235,7 +3235,7 @@ static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_pri
 		dev_info(dev, "%s: Micbias4 DT property not found\n", __func__);
 }
 
-static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool active)
+static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
 {
 	int value;
 
diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 4a417a92514d..546aa88a398c 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -3215,7 +3215,7 @@ static void wcd939x_dt_parse_micbias_info(struct device *dev, struct wcd939x_pri
 }
 
 #if IS_ENABLED(CONFIG_TYPEC)
-static bool wcd939x_swap_gnd_mic(struct snd_soc_component *component, bool active)
+static bool wcd939x_swap_gnd_mic(struct snd_soc_component *component)
 {
 	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
 
-- 
2.39.5


