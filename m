Return-Path: <linux-kernel+bounces-193480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7D8D2CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6B91F28153
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1A915FCFC;
	Wed, 29 May 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KtA2/FgI"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD715D5A2
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962290; cv=none; b=Zd1d9gQsq/WpoXAHgaEuxseRcHYR7Svvzkl8e+adZinNV4UJ60+XmKxsmxOL1opPd2fNv42EfCa4Nkl1/0K5FL7+RVrBVcl+R7KR93surlokSfnmCaoessaFKwNvtpt2MjQTQItZ0TjQWU8WhhVNt12wak4qCDtVvjopSI/bA3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962290; c=relaxed/simple;
	bh=0zA4K5GlKKb8X4MA0dH7F7aTDharqePLUmZ645uCgXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOLiHJzkAK0B7T+40GtiZ11IaeAyQlwfmM4ovPvvUiN+yeqSBNWsdEQJlMoJr8p9XSoIpCcxaFPzm8tGcRBnQs0UEqnw8ISPmAi50Gvu/iuDb8xc6iMTU1yTdOa05f7y5uLOj3Bjwhs/QcOoVXdd/S9BaPdkRW4N0aorVr5rnxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KtA2/FgI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354de97586cso1964615f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716962286; x=1717567086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfScJpV1Lc9Qk+5AjcIRGjAhjeQSJWXXmZ+kw0+4hM8=;
        b=KtA2/FgICF5CZ86JLkuWBurfPfoBfYjcsSUJ7Ulm2w1Yj8lrSyqBc8h4BeTRRNLdkn
         iP52NT2phDsrYlVmM93Kdo5PiwstBXOp2WEisr6FFLA/qlcz2iQ0+WZEZwnW4N6cddd0
         e0U/i3pAOte/TMwncblHqoX85skJJnSKHQbbzufQdy77Acl7Tve8r9x3seNuiSI7u0M5
         9f3FycQc8fTiIRlQmb5UBAcbYnLGaeP4tR6GyyQ1XMDuLSvQwbs3u975UsHMcqBbBAnu
         YJxaoE4+LCvUl0AgV7t5UBk1z3mtzClxu561ploh4V9yrBelTd+5DHCDd5ArVzzrhZEq
         QuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716962286; x=1717567086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfScJpV1Lc9Qk+5AjcIRGjAhjeQSJWXXmZ+kw0+4hM8=;
        b=LYEQ0N69fdbMvlYDUo1XIL1fx2kgYv5mIloAfUyn8fDF6vKoedFjSDKuKLEKUCSGm/
         N5CdrIRW7noUN+8wdw3I5aBbJiSfffWBNO3FEN+rU39v6qko9O5Ts4h15+j7nGFab2jh
         jclJHkWW8S/QovVWte2Ty5mxwX+cpkbDM1/57AKjJEhlUysJwZf1i9NNADzQAyaq0Ml9
         aTBEeKalVUctRXTHZt5KJN/Vb/mtQ5umiX4DxNPd+ChPEv3RAEKe1lL2q6eEPzuQR/Se
         +cnQncKQgm06+1EaNmn/HKHZMhfj9GPol7xupTvHmKREdG0Izwu7szFcCoYLU2GQWlpM
         VEuA==
X-Forwarded-Encrypted: i=1; AJvYcCVol0AipOJ0z0nIcwFK/u0KifKav5ShzEidmuD8fh90dS5Jzn1Pn9gAFJF6XEui5+gfqlo0sho725pBcH5oJzI5OaDELFc4jZuW4UU7
X-Gm-Message-State: AOJu0YzJypKVONeuwpLyqv9gpzAVk7PO0ZWpcL7uttpjIVv4du8jqzeq
	br3UmMnMCUE4pwZvbLBuz07yNVyG6AWR4mJKmnJOm+UthjFeagAwWxjMrJDBy2Q=
X-Google-Smtp-Source: AGHT+IEhIghjCSz3JD+qRhMXK6k396BTyvSTpsRBU6N2qMRXuJS6yBtfu+BePUFIt0tLfkMWIyISmA==
X-Received: by 2002:a05:6000:1e84:b0:356:9078:cc9b with SMTP id ffacd0b85a97d-3569078cd49mr7723125f8f.16.1716962285680;
        Tue, 28 May 2024 22:58:05 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896676bsm169075435e9.4.2024.05.28.22.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 22:58:05 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Wed, 29 May 2024 07:57:57 +0200
Subject: [PATCH v6 2/6] dt-bindings: thermal: mediatek: Fix thermal zone
 definitions for MT8188
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-mtk-thermal-mt818x-dtsi-v6-2-0c71478a9c37@baylibre.com>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716962279; l=2646;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=0zA4K5GlKKb8X4MA0dH7F7aTDharqePLUmZ645uCgXs=;
 b=VpFSdaZV2QCLWhCBlT9NHY2sMDqmWzooPYogLUmvRpVxbKfVfoDy0RtLffVktFo/UV/nRLG9Q
 QmnS56V+dd+BYblBogVCdMLv5w82LxelJgXNlLFk5s4k5yWRFeNR4Ki
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Fix thermal zone names for consistency with the other SoCs:
- GPU0 must be used as the first GPU item.
- SOCx deal with audio DSP, video, and infra subsystems.

The naming must be fixed "atomically" so compilation does not break.
As a result, the change is made in the dt-bindings and in the LVTS
driver within a single commit, despite the checkpatch warning.

The definitions can be modified safely here because they are used only
in the LVTS driver, which is modified accordingly.

Fixes: 78c88534e5e1 ("dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8188")
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c             | 10 +++++-----
 include/dt-bindings/thermal/mediatek,lvts-thermal.h | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 506eed52db1e..89fb92666b81 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1487,11 +1487,11 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 	},
 	{
 		.lvts_sensor = {
-			{ .dt_id = MT8188_AP_GPU1,
+			{ .dt_id = MT8188_AP_GPU0,
 			  .cal_offsets = { 43, 44, 45 } },
-			{ .dt_id = MT8188_AP_GPU2,
+			{ .dt_id = MT8188_AP_GPU1,
 			  .cal_offsets = { 46, 47, 48 } },
-			{ .dt_id = MT8188_AP_SOC1,
+			{ .dt_id = MT8188_AP_ADSP,
 			  .cal_offsets = { 49, 50, 51 } },
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 0),
@@ -1500,9 +1500,9 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 	},
 	{
 		.lvts_sensor = {
-			{ .dt_id = MT8188_AP_SOC2,
+			{ .dt_id = MT8188_AP_VDO,
 			  .cal_offsets = { 52, 53, 54 } },
-			{ .dt_id = MT8188_AP_SOC3,
+			{ .dt_id = MT8188_AP_INFRA,
 			  .cal_offsets = { 55, 56, 57 } },
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index 85d25b4d726d..ddc7302a510a 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -34,11 +34,11 @@
 #define MT8188_MCU_BIG_CPU1	5
 
 #define MT8188_AP_APU		0
-#define MT8188_AP_GPU1		1
-#define MT8188_AP_GPU2		2
-#define MT8188_AP_SOC1		3
-#define MT8188_AP_SOC2		4
-#define MT8188_AP_SOC3		5
+#define MT8188_AP_GPU0		1
+#define MT8188_AP_GPU1		2
+#define MT8188_AP_ADSP		3
+#define MT8188_AP_VDO		4
+#define MT8188_AP_INFRA		5
 #define MT8188_AP_CAM1		6
 #define MT8188_AP_CAM2		7
 

-- 
2.37.3


