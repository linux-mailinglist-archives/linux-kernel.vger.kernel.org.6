Return-Path: <linux-kernel+bounces-211900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9567905883
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5672863AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A852194C6D;
	Wed, 12 Jun 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRrLYX/3"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861619309B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208978; cv=none; b=YzcYDg5bjSa65MAaJqFe5Tf89nUlkBXPy/nqwjSrk0hu0NWqGoWrz2KApEmTtMgV1znWW6ivUV5dCwQug1oaWAGmBo+EzA7aDu6aF/oFCGcU8dkm4oNJiggeVkk7mao1QYCMT3GleYPPW2VCMfsO06RTtbbajjsdhOCCDfAhXek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208978; c=relaxed/simple;
	bh=AqGJEeLHu58vzcaPVEiybipjhiSIkfgmXeCqrJqGrnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhZIoznjfm+ocREMvrRDvCdDulmDj0mmoUe8f85uXBM5Si1SnIYGgsY4SKrp8wor95Lsk2Q/4YtMNHaPc2aHkoqzadEqRMOKvYShIZ5cvOrAammmf+sSwAbt/Jx4NGeviN5PO3C7xioU3HHZEwUQUgr4ob7VzZrPOpL89Bz1kVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xRrLYX/3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f09b457fdso4775566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208975; x=1718813775; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPjxtHHdxxnis6XGqFgLr48z/PZZvjJ4q9YoUmBEYG0=;
        b=xRrLYX/3KYWeUlXwvEaTPLvLOytH+cnDZeAkoRc2emOLLW+IhoAmsb34w/GX+m706v
         1Xb9th0GH62abjIXAyRaf/5JEq2+e6Te/ETAILudwv3DCcMK/Qa6C/ZVpaBtIWoH2R5U
         oFJHOJvucz5FMj8cyYSxnVc8CSv/8ZYegdKy4R/mNT38jeSfI80bIuSgf6vk6q2lBr0p
         7/ViucDdwKtSLyHTXVDNivsv91MAtVCZ5doWQhaPyJ89dCDfOjSjVxnLpooJb7wJ9DaR
         rxK1AS0xsvBIG+k530fwyZTODcV0m+ysJ8oU4TP/eh6JnacsOIc+WPmyKbxG2oO3716+
         KTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208975; x=1718813775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPjxtHHdxxnis6XGqFgLr48z/PZZvjJ4q9YoUmBEYG0=;
        b=PjdjfVnjwB/VGKEJuUjM98bX/n4yD+CjGiDMvjiSTbFaY3OjCzJev4OEHF+hArzMbe
         Jgk4zxUramoD8vhmLs2MyKbsRl2SeJ4wZ/upceyoTzog3CcqLMkXOTfyNowOdNo69wqf
         hfKRsj1yQv2/urdAHbt4wOx7qekh8YXa4AwBEHYzmLBYNxfXtvvHjPeRD5b2Jw/XIa5W
         wn0Xx9Fyc+PhfCpU2VhajhCF184BYJLhvKLEujUmm3TVIdh7y2ynPnAnI4xvTuBGJJgh
         CpdFBO6f0zoJTiN7B2v9fbxrq9GM0DNvRJg/Y0gQwkrnJNqYoudtqtq342/2yRYb8oKS
         f2bw==
X-Forwarded-Encrypted: i=1; AJvYcCWXHYjosiq1/K1kJCD7p3uPcTONtwsIt/J6C3m5kaeLhDBiL3dBCgr5ADDk2m4nsOweQyZjqdcMhmXXRcCmtTiCmSSqM+LtkcHxdUli
X-Gm-Message-State: AOJu0YwVQaaLIjJzCq+IPPtc4q83PQD5ZKeBpadRdLmrQE/3PqhodCaq
	oac3A0FHBKmEx/k9sgdDMXGn58qjM8yAPHlGrFAIytrX65gcx4rSWQUNun7mfIQ=
X-Google-Smtp-Source: AGHT+IE9yWBR/V1EKyUJEqTgvztyKXOF8S1AWCeYdztPcdcZitZUuETPOkxcpZ9R31ob9kdpEriv5w==
X-Received: by 2002:a17:906:48c7:b0:a6f:4b5b:4ba7 with SMTP id a640c23a62f3a-a6f4b5b4c43mr123244466b.67.1718208975296;
        Wed, 12 Jun 2024 09:16:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:16:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:34 +0200
Subject: [PATCH 21/23] ASoC: codecs: wcd939x: Constify wcd939x_sdw_ch_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-21-0d15885b2a06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=AqGJEeLHu58vzcaPVEiybipjhiSIkfgmXeCqrJqGrnA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmpxeuRkJc7UskyAuH3KS6z1/56YQ47Nrud3
 89R9FiDZdiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJqQAKCRDBN2bmhouD
 1x9cD/43TrxRdQE1DLNeZsA2ZfnfnJ1pH9+KHD03KLq4jRMaNGc0vOD6gAW8YiXcfQpY5mnxwij
 gPatOixM/87wwVVpUFEl1mR6zyYy9gLekbU3XcgEcEFBzWfvZaG54dMfhIs1RZQD9CJaU1OeefJ
 MKzFWzjeeRToXCmy8z4uBl7VwPZnXc/HmdwUIQ7hizF/nconAkhnEsDRE5KQkv1EHnJ/J5ycXCm
 fkyVv4tTZt3GSxG9HzSSMjUPVtHFiVN7R9O3nN5SRe7VLlJfnn9qT3C7s1a2RAfWFWPpD8Im0vy
 slzrMvYV9fmZtjsKBTAvU+SkWOQaqL6mQ5kBZA7+ZalF/K+XWaNtNO0VQJrGPDDjr+qM5NW4aRh
 XFlYpJC89EFLVdpg+cquAYm/NF9tf/nfopHSgLxye0KILe0Su3ocAVO7t50OQWKhCcaPZB5vZ2Z
 ujcsM136t3E5JG1QbBwDr7f6hwfOe0mBLgHhwxFM2Jm8M7dyqPVwkI9Or52zkfWE7o/6lxmdfaY
 VA/v/HjLqDWm/GdJpRXGJyWbEpee6+qEytMnCzxEKZEPwplo8cFED3M77+uT2uQgi0lJf8Ww3tC
 f+7V03XArBf47xBwzv4g00GjANSYmhUFPpjNYbyjvTMnNzdJBR3fmqBKmDjLKnr2yiI9ur5ZRXx
 hNciNnxUGFGKUdQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify static wcd939x_sdw_ch_info array, so it can be
made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd939x-sdw.c | 4 ++--
 sound/soc/codecs/wcd939x.c     | 2 +-
 sound/soc/codecs/wcd939x.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
index 8acb5651c5bc..94b1e99a3ca0 100644
--- a/sound/soc/codecs/wcd939x-sdw.c
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -23,7 +23,7 @@
 
 #define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
 
-static struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
+static const struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_HPH_L, WCD939X_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(WCD939X_HPH_R, WCD939X_HPH_PORT, BIT(1)),
 	WCD_SDW_CH(WCD939X_CLSH, WCD939X_CLSH_PORT, BIT(0)),
@@ -36,7 +36,7 @@ static struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_HIFI_PCM_R, WCD939X_HIFI_PCM_PORT, BIT(1)),
 };
 
-static struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
+static const struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(WCD939X_ADC1, WCD939X_ADC_1_4_PORT, BIT(0)),
 	WCD_SDW_CH(WCD939X_ADC2, WCD939X_ADC_1_4_PORT, BIT(1)),
 	WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_1_4_PORT, BIT(2)),
diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 1f94f49f9829..66af035bd0e5 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -414,7 +414,7 @@ static int wcd939x_io_init(struct snd_soc_component *component)
 	return 0;
 }
 
-static int wcd939x_sdw_connect_port(struct wcd939x_sdw_ch_info *ch_info,
+static int wcd939x_sdw_connect_port(const struct wcd939x_sdw_ch_info *ch_info,
 				    struct sdw_port_config *port_config,
 				    u8 enable)
 {
diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index 756f497a337c..a6c9c6cee056 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -914,7 +914,7 @@ struct wcd939x_sdw_priv {
 	struct sdw_stream_config sconfig;
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WCD939X_MAX_SWR_PORTS];
-	struct wcd939x_sdw_ch_info *ch_info;
+	const struct wcd939x_sdw_ch_info *ch_info;
 	bool port_enable[WCD939X_MAX_SWR_CH_IDS];
 	int active_ports;
 	int num_ports;

-- 
2.43.0


