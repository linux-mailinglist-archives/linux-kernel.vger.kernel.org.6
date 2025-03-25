Return-Path: <linux-kernel+bounces-575220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E38A6F481
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A5216BF32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122ED2571B1;
	Tue, 25 Mar 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flRyaYqp"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3FF256C64
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902871; cv=none; b=WlOF8Aa/mmqK33TDDnKJDTgtpM54axvEIiCa3RPi8izeyDaMRFRXYNrjHz0UM0ok8npT2vPP8gmqCwwVgp7hNovKGePEghxyUpi8seyU3WLZcVWwNE/YE0FwbpZy4LoPHq1SZ0GLjvbpRMJFgjfu8WkpMbHnkxrFY7I750RWk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902871; c=relaxed/simple;
	bh=hJEhHBHgmcwkLGn7ADU+TBJtnvqkH4aaspjSeICJrEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfME0H2XizjmbKMpRw+Lifd6htOu+QapH4559mowiOw2vo5IRPc+6Buv47oFJs8sMLLdx5IluYmvnsbedWaXvLs5kU8WtU3XDQbokHxyMy5v7y8l4EISncjnuF6f9lmdjE/XUOR7WTno0m3w98SlfsZ2/JfKtp3/DceoBJ5gBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flRyaYqp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913d129c1aso3915867f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742902867; x=1743507667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPKG26aBT6MGmMvi54w+dEW5MMoDzMUIu/y68UikHrA=;
        b=flRyaYqpIoHDWb/GhPNgMRLoc0AvD/ObTBvINIpHY09sagiCxJdWtkqYkMyUp8P5Xp
         ktvCxaAPQJzafUDmnsGdzElQoMZNtaHrR6v9KM1tw8K5PZlKlmwD0FdN1hqjltA1Usit
         NVP1p+Kl5wB3u+9Q/Kwh24rMloQIMbnOmv0RqeadXLU35wqL5uR6HwbFTFf9relFvVHB
         6QZ1PsreiTD4hbOxyluudh+p8l0Rs1vpDDqOlHtIVIVBw0Qz/Tz94oBYM3+08d62fYCP
         vVLSJMnqks3lI5/RYa8Rb+7BZO88TGFpVp/TNDN0Q2ut74bWeCst17MMQppyUVl6zZAl
         67vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902867; x=1743507667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPKG26aBT6MGmMvi54w+dEW5MMoDzMUIu/y68UikHrA=;
        b=r82t0MefD5uNU69/oQy/P+d6P+f0OlogCijaqLPqNgTGDSMeu8vwT8SxUUJYeuYb1n
         inwoHkXsAjskvwir6YWpc+xfiQphXl436L0X/1Ms60iWxuMn9bx/7DWQKqQjFO40CJaf
         JjDIjcPObwR+UF7uEcR8G4PUncZpKFcDtOG2V0aRgDM2Si0WPERWEAIDoQgmK0rpGCvi
         4jLDag5BTjY+14Os4T+Rk3Tw4CDWKAClE55HzlYXhLwv6fr0zoJiDKiS24WCQEoEYY8p
         sKrgrx4CD8ybQfJ5ntE3eBtp1p4eqo9yIJzMRWi39zQG0UmWS8grMVLvgw11vPXFoyr2
         aebw==
X-Forwarded-Encrypted: i=1; AJvYcCXW/UWK1J4z7sQSQ2JJWDbTrA0oto+p88Cg3lTCnOs4NZ90LcJ9DSnR8Zdx0U35XqYgXBkmMeGvAJgzhKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPmCAZLPb/yJGzln6iB9fTuWYqBD4aYpMavQh8HRZinajIUU0
	JYdjsySQce4xjn5f2Fi2fveo54gDcAgpdwCqlnuFs0JNIoIf3oyA4pOP0ter5PM=
X-Gm-Gg: ASbGnct68mWGzVOXvVQOk+CtRT9Z6kh4eNyKdT1XXrXKRzpGXQLcjJIDe6eHHHeK72w
	7Z5hPOtVPuAKIjxuJneR+ryb6jdE2HHe09s4vpISIpHt1Ocnj3aKdD4BWOuHmEiCb3L9MdZfT/P
	bDutC6umAAkJCGuQLDk7E+PVgvJP65h4vqGhIDO/l+ocGVBhd9IS9srivmDzvuDebREer6gR9SQ
	JBMUUv79gI7gTEYjLe8ryb8eyyys7CcUv9qcfR9azQGwb+fvMeGjpQ4mhnoTdNzRTgdDJMahTR+
	ktYSbcThfhgL48mtjiDtNGpBeDJRMxZ0DpWr8KvRxW3rD4/1Z23MyMUAtbabQ9Mdvew97Q==
X-Google-Smtp-Source: AGHT+IFqEVrx5mCJtplG7+w7CWWWndtmmBeTngl+nxKo8qHTXdRc7GMle1DFI7FxDeYhfsG7z+7Agw==
X-Received: by 2002:adf:9dce:0:b0:39a:c9ae:9eea with SMTP id ffacd0b85a97d-39ac9aea552mr1090347f8f.10.1742902867202;
        Tue, 25 Mar 2025 04:41:07 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13213330f8f.29.2025.03.25.04.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:41:06 -0700 (PDT)
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
Subject: [PATCH v5 3/6] ASoC: codecs: wcd-mbhc: cleanup swap_gnd_mic api
Date: Tue, 25 Mar 2025 11:40:55 +0000
Message-Id: <20250325114058.12083-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
References: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
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


