Return-Path: <linux-kernel+bounces-221279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013F90F13B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FE8B2679A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE3157A7C;
	Wed, 19 Jun 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zRizFSzI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB06156C5F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808433; cv=none; b=k5OQPyorcwd32QARX21Y62ctQWIxrj0p+Ggj61xXM8bBSy3AszgNWARIo0C7DaZ72I9UgwvlOeEPODtfRgfErHoSvxS66HWnd3wQn/HEAQ2sRJp0WIy8HVb6pZonz2NJPoJmq+1LY/MKOtrdJqenSXAODi4WuJGLYBqxPa8R4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808433; c=relaxed/simple;
	bh=cO45G3J6A2HCrNyifwgmbquTtW1hXtTIuXDjiQ9kiyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZw/Ch2LdUTTAkYsAZX25U6AVox00OLVqsfpUd0ua6XiplhfXjqyGI6ChaQLF26xl3ObNfJKLAH4I374EErthcFm1Ocu0125G7Pm/mJKyUxyw2zFSGNNxUUGxm+3mzMw565BI8ZYx9nWnUWM55JPVdMMh/Ye3R1GgiFtGvGo3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zRizFSzI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so118951531fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718808429; x=1719413229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOYHy0wGdKj7gYao1Bs3zuE6VV+046rxXLiuWBbG9as=;
        b=zRizFSzIkYbQVGHPtoXwUYPn4+GzQT4Z5T/C+BJ8ARc7/ZgQkfo6N+DJF4PisTI9N5
         GFNLUU1foCjZaxrS39UhCJA4JVpcdCRo5UEE1odX1XKxAnhLM7TwAa/BkWUx8g1qa9qy
         WAw8slZoFVn5DBxsFtEn4dMGHlr51L8+YEav8V6zLwZN7vEhAiOmQYOs9gJadSaxlHoG
         TYN5XjsHZzbjLkocserP/Pu4VfT8gpoqsYjPwElBaxC7nU99LlA0zzgOiOpKy5MfDmlc
         ciJ6m9mqw98WFsLbjP0ii3aSBdjW+vHOqMYhuuIwENpeanU5jFUqbRir8ZLGi6G1v3kQ
         2w9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718808429; x=1719413229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOYHy0wGdKj7gYao1Bs3zuE6VV+046rxXLiuWBbG9as=;
        b=BpHGaEhQqsK5IWISGAVgDl8cTe01OJHmumErC9NG9giU4kC/XHxWBfvHBbd4Rz9J2g
         MSMyi5d14f1DZb1CW6XzTCiSsFTcS0H1ZCt4EesF4vPPC/5zrE2gBoI8ZK2d6y29XgNK
         aLLN8iqTZkJuZbLYHtBqMlEgzizGoJ9IUAMPBUlnWS6uQI0mW97zrm5lh2XANLnIOTJ0
         9zSXQHqHhckjqpvSoF34EPvvcFJ/LB4n4oS28xO6SWBCb2GZULCH/g/aGHle+wgK1orS
         hiykCXTLP0fdkdLhxf9R+H/5O9jNgaeRnilIjxm4Z5Cydiefi+LcGT5KbOpt9HpSlNZX
         6Isw==
X-Forwarded-Encrypted: i=1; AJvYcCVi9Dp18zS2ywp7C+OF92FG/hy9hyUoH/+dFGhvorURDRiIW2sxxOGDrLbx7qA+AHSXlY2RUN4Kp2pcKrcRL+b1gIkV32BzL0HkRB7a
X-Gm-Message-State: AOJu0YxBj9zefFWb/HjXi528yPJJT4vYfpQALQA1MO+nMqut2Utuyqzd
	AdTcF16SAbCX6LsZ4Lc7+hZdExKFlt2EPdomj+yJxTyosMV5luBHwBcEA2Td9ow=
X-Google-Smtp-Source: AGHT+IHZjLCp6uoXlXfqQ0RKu5pWr8gxWPkxcPzzjLNo0AhaIUbrnCYVVlqUcTfIBz485mlGmWKOGQ==
X-Received: by 2002:a2e:2e0c:0:b0:2ea:e2d2:6231 with SMTP id 38308e7fff4ca-2ec3cfe9213mr23132561fa.33.1718808429743;
        Wed, 19 Jun 2024 07:47:09 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6f56da32c3sm679787566b.13.2024.06.19.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:47:09 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Wed, 19 Jun 2024 16:46:50 +0200
Subject: [PATCH v6 14/16] arm64: defconfig: enable mt8365 sound
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v6-14-f754ec1a7634@baylibre.com>
References: <20240226-audio-i350-v6-0-f754ec1a7634@baylibre.com>
In-Reply-To: <20240226-audio-i350-v6-0-f754ec1a7634@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=cO45G3J6A2HCrNyifwgmbquTtW1hXtTIuXDjiQ9kiyk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmcu9Rr31FcrlNuhRLXo8LEdu75PcCTBqW0u596FYF
 k5UOpl+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZnLvUQAKCRArRkmdfjHURSe5EA
 DBeGdSSHpPMzGpeI7wNiG5y2VIzwe/IbVqGnCja84KdFBZP60REsnzx06exUV1LY0J0aEVp+sMhom1
 YR0dWD9pSUFYaJ1MieeF+nhaXBAnabOgoVj0YbdL+QP9oLoGBXPYGkxHH5OQE7ARC88nziL+5IjPpg
 F1eCcUCVDfNzlUqAzVZW0mKPDwsqepJWsZc4IwPyPn+AMdNwCcGi95SWV3ZloRUZMsPNCPo62v3dEj
 TluHhrArRuR0DM4rHGp/+FVGYnzvwzYYmTDkAtEKAtUVTXrTUbnmAgTm8iBONqSjmNxyigDMZqOW/G
 xhWA2aObi+dPX5iBDnzzhvSg94lJhQqs4qkE0D/6i4eDZsxw1AjWtpg7w1TXANsbwIon8nZwf2I5eo
 KaqTTsXIyO3eM3s/m5RIscP0UxdM9uV3c0OVe+FhN9QmpUzKs1f9Ncsx10WXBM4f0XNlPfH4V4Czab
 GhH9t9ehABinDvKvUULzLJM7o3OQ1VStF2S1FRkM7piYcYNhscWQsgwyE/0UbNC7YTIEw50G8IX9Wj
 Achaw7Dp8flH8t/Q0+auOQOjQPszi7eCZtAK8CxXrX2ur5u+7O4O8jUAyfITPt/sIogKMEGF94EW71
 cPBz2Spj7AJZW4378p6XZDWDoziFyqixN6TaLC1d/20pIrKQl6S+zpxGRGgQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Enable the MediaTek MT8365-EVK sound support.

The audio feature is handled by the MT8365 SoC and
the MT6357 PMIC codec audio.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 57a9abe78ee4..24b4d1a4992f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -950,6 +950,8 @@ CONFIG_SND_SOC_MT8192=m
 CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
 CONFIG_SND_SOC_MT8195=m
 CONFIG_SND_SOC_MT8195_MT6359=m
+CONFIG_SND_SOC_MT8365=m
+CONFIG_SND_SOC_MT8365_MT6357=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m

-- 
2.25.1


