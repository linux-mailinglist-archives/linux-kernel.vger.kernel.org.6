Return-Path: <linux-kernel+bounces-569352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00337A6A1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D936466EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F57721ADCC;
	Thu, 20 Mar 2025 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iKdIO1XF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C8205E1C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460558; cv=none; b=m/5Zdj6JqAezc0/sZZDnXt+70SR5qg7T+VY3SMlIYn2dmILKuGYAIpqsIA2Dj2t4gS8BghyjOc98d3zmmu17DaZVT7Fj47F9r4wxNRQbsFXraSmoulYTEzrxIzR7NnW+HJNSnm13joPASPMpd+yO4/FzPO4+bO2dgtaP4VZYkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460558; c=relaxed/simple;
	bh=ZusPf2YtjBEtNve2Icxs25V5Tl/ibrpsGhWI+A0KSgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNV124P5cTuru/AivjTa/4Jb8iKPCf7G1Fqernzh5W/8fLyNIz+XhegkxqKE+MJNhR3bjiukqUkF4B93d0ZNgmuVsZWEidfBiMM1ukR4YCV7h20ZRzAlNA52okumJY0XfNvkJnikjprntRSS15HhjZAu+2gjdSa8nUIGejQ6/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iKdIO1XF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so5349545e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742460554; x=1743065354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQeXTV1LA9vLFyUSPTOWos3fw/hNZwIQ/slXSCfXZO8=;
        b=iKdIO1XFjRvxltGSjtjx9gEGbEoFRRabreLH6m57b3po8Ck6K+oi0IRZwyeg/vc52A
         eYHnmExA7fY80RuIbOfZBw8WPkV3kEK6lVwLYGSMjfO709GOtLQ5yvZtJIrb5QXqfhKk
         ga6eWDJCaiUQe6BJlR0kNMHRg6MPDYNfWPzOZz6hPxxSJS0jxB23/cKri77+GqUrOV+N
         rycbVGjeyQLxnwxZDekccndrL5KRPVX4dJJqT2x4iXrQtpU0taO3E+o21yesQU7+6Yt0
         XDbTzTz0RJE278r/ohJ4M/mLMBa0r09GUGMCqR+G9yT+r5ubTrlakJSeOpsdeNL3jD5U
         asfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460554; x=1743065354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQeXTV1LA9vLFyUSPTOWos3fw/hNZwIQ/slXSCfXZO8=;
        b=OepSbrvcYE7ikHoZ48Pr6A0cIRm8Re4VNET4WuOKCSFGINNsoHM/Ly0Bf2hwJEwyHI
         bGCs68+v6KBF23xwQQZnmj+pkTtzWulRSfh9sbxE9Z/wkP4OB/Vyb9RzScqqItMtN5vB
         eyJ5MxwG4f0d/XLZgE3mZ24d7ErhmgNydLXc1IwaoDPCzTMOMPCJMz995YyS9Uowpt1R
         x6GfFwSu8qHuLSva3IG228DPFkQe+ALNnFoReVgCWboUx2mMdmOaU0Opv/KNP1h85sYB
         /fRnAkEg/hEGGWW/RiFXCfPZcRp/btn7DnZrG0MXOuM6UBdXxahqtf8m4nHJt2olyrc1
         VBIA==
X-Forwarded-Encrypted: i=1; AJvYcCUHY8t0XFGUAwwQJKpnAfcqhpAoejx04OWd3FyZ9Z3/RT29gvvfyEUNdNRstw8/2QJOm4GBRFouvDarcdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkoV6YMhFAJ3B6w5CaD7YqIcuFL4Qb8vNqS1EK72CC8EXfaKN5
	eW3LfkBhlRKSPc/Hi4Qp8QsrVx6vnJLQ4Y5A5nkVTbLJtLvhTXCuw0Ri3EsJPH0=
X-Gm-Gg: ASbGncuDiKLW4WCOeV78jNRsKBVplx+aL/Uh8v/E6wwCEIHg0u9uYbvG5ZvfOoQdwaJ
	Kvr3VEiX5Y3KFUAIeNjfULtnVdyfKqhzPyy/5/vrM/V9Fod0HDo2tkzyuv9yGUSmoXin9I29VE6
	t8fLraxVPZFo+NzA8tn3MZEEz6aMtqZa2wxZ0ewZGu24EOHZV1WiXz34PcskXmgPpAuDohBOdim
	KlC78qkdsGVidWkbAIZq7+JcHcv2c5VkhPw+3nxHWTOkRlvV+0hUE4/PlRYZTHS/5Eflo0qjUO5
	iT+BbTJBvxO8J8e14rKk+UTxGaWE32b6cfZcoGe2KdWnL1xh
X-Google-Smtp-Source: AGHT+IH58YmM+Ar3OIBnrYDz72JB09Ne3XzaCC0yavAlSFgbWvLySke1g9L5Z6waa+wCIlyWCNTAWg==
X-Received: by 2002:a05:600c:5248:b0:43d:aed:f7d0 with SMTP id 5b1f17b1804b1-43d495aba92mr15463345e9.28.1742460554194;
        Thu, 20 Mar 2025 01:49:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:5ee:79d0:c11c:487d:c821:54a0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d43fdac9dsm41381655e9.30.2025.03.20.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:49:13 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 20 Mar 2025 09:48:45 +0100
Subject: [PATCH v8 1/3] arm64: defconfig: enable display support for
 mt8365-evk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v8-1-c2dd7b0fb2bd@baylibre.com>
References: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
In-Reply-To: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=ZusPf2YtjBEtNve2Icxs25V5Tl/ibrpsGhWI+A0KSgU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBn29aH6usGfN2/1gaTh9wKj+TSHgkhwQ2e617HVo3A
 T2nrw+uJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZ9vWhwAKCRArRkmdfjHURarMD/
 kBEjarCQjoLriCSN2ub60j2k/Jqp4G5LTX4M3crHIEvT/AJ1/D0ShmhMqlAGFJqzIuOD/uTzvBCH4C
 bvY4jxUtPHFP/4FqhTFtCiB4ieeiipBTC4gDQ3iDwnQtJ3egvFXIU+TYQICa3/lds2dwg3LPfI8lYW
 kTmBMlwM/FxFnUZA//Onw6iJsbRzaKrvCZaHfmhIkKN8cXdO73g41J5uiws/LV9OioWmTwxioi3sfT
 yeQC0vJB+q0EmE5vnp499CedQpZWTJvw5dAGVOr6zP8fJIYS/LyWObKhn5t+mJCHol1lJ+Ty3dDXoD
 5tfUCbkzfXmiZK8Y+pzH2Yl+YSxgeZUyF5g4yS3gNaLO4/LHIsyfFPzqrN8Nu2/T+Vu8xf57gtRiTN
 yvlzEAOgC2gFD6lEdCls5eBIHksYK0ntvzYD7ykbnM9YJ9zI1amHZHpVw3tJ9lJn/Ko1hm9sgXLuKn
 OvS7nxXk6ABvpHrHXIHTttwaqOrMN2+kAxT8Si3Tr+A//FpFpOx+BNJs6CBZ1kaB9CuFFvYHJtvNwA
 GLfDzh1Kdf659ylFdqcCdiT0kjaEmujM+W2KwrWgohbdkT8f5pSvPl2HTVwIrxStU8MXgya8H0ksA3
 Rrn6wVEmTr6rmJmD3UfNG4LkSVcvwzH8JGPe3ChKA7ZNLm2ZbW0s1XUAoDZg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Enable the DRM HDMI connector support and the MIPI-DSI display
Startek KD070FHFID015 panel to have HDMI and DSI display working
on the mt8365-evk board.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e615863..1e2963a13500b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -897,9 +897,11 @@ CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
+CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_FSL_LDB=m
+CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m

-- 
2.25.1


