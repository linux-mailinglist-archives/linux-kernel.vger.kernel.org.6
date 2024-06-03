Return-Path: <linux-kernel+bounces-198996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502618D8047
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AADFB22F25
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B884D06;
	Mon,  3 Jun 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fC1gwpvR"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974B83CD3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411865; cv=none; b=luS3NftboiAN5XBLKB/TEMAEtKiNY+4PnVuc17DlsAyGWgyPaqif0varJOJ+ysonb1b76OijNHIRPBGSOxGyLJlTSqOTJLcElO913H4aWeEPebCuQYlG9blSFU9Oh1X7VZpUajW22wax7pQdxgwCwCre1Y/YhYb9GEt5n0j+n+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411865; c=relaxed/simple;
	bh=ZqI2EmSTiCeQkIQ029juObOniGHTqqS9zskZ5qN+P1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rm0JHNcdlUBAouNCBMGxBa+wuaUtg2nSi2WkBAf3MQfIJui0pPqpj8MQprp8zlJO3b9mp7fU0fWMlPOeiyYTP4rR1+YjosfTNdofag5KHCnB73ExIEO7mh4VrBcJPEt5HcFE/lbfGlVmjyKZlDDJTTNCLFOSl7v44wTAb/2Cs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fC1gwpvR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so52140661fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717411862; x=1718016662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qji0UP0xUl/IquKfodaZRyE+GMoc8OcYwqb2/om3sxM=;
        b=fC1gwpvRDhB1hnVaJiXwgjSXQP0VZJh3eBNUyha9UAgkC5LQRyAzzVSmngQOrv6jD2
         mlxx5d5CS5zPl932ewo9Esb7sD1N+yOEfz4lSYGChoHVNt83Q88S/s2WbbJbYcb1+AwV
         Gn9yd4zucooZjsZs/IXGLDCGxbhwhGI0bYv6yqx3g2MbqLefEOUOgn6/Y1FQgIe2bx8E
         cXjG0802CENi8BuvNVE+o1Pkgja3Anh1zyFAPDLZdQi3XxIWc5E3XWCMp1nIf0nwBt+F
         tDhJQd+VihNK+bqVyn9RF//p+m6EJcPXi6H3eUAHlpNAm5TL6ByPv9KFb/jtE3NAGWiW
         zQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717411862; x=1718016662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qji0UP0xUl/IquKfodaZRyE+GMoc8OcYwqb2/om3sxM=;
        b=Hae6BX2hn5TcuOA+PutFcRm6swBoPMuidsiMxvI2RUivMq1hWJP+g+moUw25NC9NiO
         7SN2O358bbZ68BojEpd6i3J7ufoj79htNW9wIhXxkVoPhEuoynaKSoEEl8Q/q48sCXxo
         P3WcsRh2mcqr5DrsQsGuNilNIsSl2oZe+XZnhyZ+WTVtNomLncuH8LNtNiQ+fGnB+xyE
         g7RXSI5YQIGrDs7GhqiB58cOYsSiX9OfvdYp3ensub9YvwI8zC+w/Kqc/V7ugnEo8B77
         awwEqHOAA8ogVY6e0re+JNQiWKlaFc0jsxmwHzxhvBUuE9fX4RwsJSgMk3WQoxzjDM6u
         i0jw==
X-Forwarded-Encrypted: i=1; AJvYcCURszANK39Przd4NSRc6SnxUTUafAfylnDapjPARoxGBzFcEBhdD9A5k2YObFjKgE2Ndg2syWEJOr2H2/HkNg27viowLQ+eUJUR9cPJ
X-Gm-Message-State: AOJu0YxO3rR4ZIvTmNPc/QfV8uLFrjcuqzUayN2WF0iScKXmyZXsR4Ek
	G9oRNdG10XmZ+mlcBuKNxsvyLLm66MgtB9oBCuPZtt5cIym8g4HDK574YIEptik=
X-Google-Smtp-Source: AGHT+IGiTDLsLcSDxxJBfHYdR2L0V7tR+pJ49Omj8OpudBjroJButtWWzfsGSf103bQFR8ayRgCtIQ==
X-Received: by 2002:a2e:9903:0:b0:2e9:794c:19ae with SMTP id 38308e7fff4ca-2ea95122772mr59006141fa.23.1717411861734;
        Mon, 03 Jun 2024 03:51:01 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133227f8asm95372535e9.19.2024.06.03.03.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 03:51:01 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Mon, 03 Jun 2024 12:50:49 +0200
Subject: [PATCH v7 2/6] dt-bindings: thermal: mediatek: Fix thermal zone
 definitions for MT8188
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-mtk-thermal-mt818x-dtsi-v7-2-8c8e3c7a3643@baylibre.com>
References: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
In-Reply-To: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
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
 Julien Panis <jpanis@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717411855; l=2836;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=ZqI2EmSTiCeQkIQ029juObOniGHTqqS9zskZ5qN+P1Y=;
 b=Tw82fn/ZAXPeDohLJa8RKt2pEsOcZr9bdvgVK6hzP3QqxnhsrLDnsX2AgTmAaCXFSECZy0zTP
 oMSA7L28yq2DyzTWri20+vWMBaXVEEvLL9M55ZVVNtlWFMvGysf0qwK
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Fix thermal zone names for consistency with the other SoCs:
- GPU0 must be used as the first GPU item.
- SOCx deal with audio DSP, video, and infra subsystems.

The naming must be fixed "atomically" so compilation does not break.
As a result, the change is made in the dt-bindings and in the LVTS
driver within a single commit, despite the checkpatch warning.

The definitions can be safely modified here because they are used only
in the LVTS driver, which is modified accordingly, and have not yet
been included in a released kernel.

Fixes: 78c88534e5e1 ("dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8188")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


