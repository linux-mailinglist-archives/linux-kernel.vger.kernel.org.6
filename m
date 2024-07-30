Return-Path: <linux-kernel+bounces-267532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA294128C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846E71C228AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDE19E7D1;
	Tue, 30 Jul 2024 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l9/2Iqy5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03615442C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343840; cv=none; b=hgHvabKojcVSUy62WOEVOroLzoxybN+3ZH1w+uT8Ef/TWbkasAx1GayxfvHaByXiVeSvpT9C7HecjESThb1CNg4HXHrAHmFXmdUrHsrKyTD+gDg/MtalO804AoDtWvuCCPlGlJBvYSJVBxrgV11J3Dfe90NQ3XVhmQaEK60gkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343840; c=relaxed/simple;
	bh=EOBREdtes+QiAPi/N5g47QXxoOnbCws46rYVSwBQ6jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tySXDuHGXbvBRLlzjXTDx5FhNM2GlBcTgrMmMHAipaT07kOzuy+qpqvO8S+lHR5rv1WFF0EfF07pMeL9t2rN3DtbSRppZYXDWItKIXkIvBO6KOfQTOtVurb8o/EFioZeko8Ra2yoO8zTZUy8umUnR+061ALwyGWZD6vLMcRywtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l9/2Iqy5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428163f7635so25210435e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343836; x=1722948636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCAbjMiMPWRMzpCKATzPFm7RQ4gOtOLIXraRazPtH00=;
        b=l9/2Iqy5iXPtNT+5G1so5Y1bJxXtF+2xNjEAiiE/weFBUrEWF2MAW+ivFcuBiKyeCC
         yB0KRQ61o3wMTPJt/VLIl74pN1H0HugQeJL4nmDysMfEme5to+x51Mev549l9YVz6D4V
         1fI9yjvPoYOrpfLbxPg6Cs6t9ubgtecj6ZlhV783GCfF2A9HlzAVIx1wqDe3p6MRBXY1
         8Xtf/26VYlIUuFgQ4J9zwGmKSqp/YTBA4yjUiKg0Rt5DMsP9vDDiclq0oGHLsw1n2M0X
         f2OXiVa6cT0AOhxc9t+BoNOH0FLsvN56RkgNi0vH9dvyGPqWuVGMZJqdYdnGmrZLVTni
         liRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343836; x=1722948636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCAbjMiMPWRMzpCKATzPFm7RQ4gOtOLIXraRazPtH00=;
        b=cAUXqxt9xK000HrTuq8eblBSRv9GyvCjBsoqhC97aT/vqjysiM8gOsqM6qOEt9O7ER
         xtQMlyA4gDy7dLGCU5FpR3dRL3Czm74BaVoxVly88T4y+twog5F4euCE7D8HEXAX7E0q
         gci23Hq3+kleJjTuB3jgQ81EDZWiQ6icDzdZdu+sXMG8i/HIzxF8hQqCgb++c3hrKrd6
         mDS492tUiItV4vsY80vS4Wbb2k++ft+D/+1tSO02Y5fV1wgaf4MGsSzedxRBzUj0Xjax
         J/ChpXkPettDKD3nRCupLvtfVaXR4aW7v8acjtX49PJV4nb+g54faqWKWbCZ2rx7JS01
         bRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+2aVLdz+0j1EkBQkQAZ7jtzTvadIJ5XC8+4SqYqj0MVG83ha6FmfGI8vTqo7+CqOhQE4MqTVIsFVuihA7LbcfIyRSjeKW2mqHrtN4
X-Gm-Message-State: AOJu0Yz0If+JGQHjBT/r1GxkMCDMJr4oDyFvGooXD+dJC36dfoqivONM
	KO1lZXZK0emFAFq65uv+qe7rgm7FDe4xtCAnn7Z6gOOpNevnz8Or2Kp7QzJSiJM=
X-Google-Smtp-Source: AGHT+IFrBziZT/58Vb7K/FmVwcAvFVRM7tFnePkyMs/HqsXtRR+PlZ++CrVSk74QOczD1bWAn9/67Q==
X-Received: by 2002:a05:6000:11c7:b0:367:8a9e:6bed with SMTP id ffacd0b85a97d-36b5d0baf47mr7921610f8f.61.1722343836141;
        Tue, 30 Jul 2024 05:50:36 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] drm/meson: vclk: drop hdmi system clock setup
Date: Tue, 30 Jul 2024 14:50:12 +0200
Message-ID: <20240730125023.710237-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125023.710237-1-jbrunet@baylibre.com>
References: <20240730125023.710237-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Poking the HHI syscon is a way to setup clocks behind CCF's back.
Also, 2 drm code paths, the encoder and the hdmi-phy, are racing to do the
same setup of the HDMI system clock.

This clock is used is used by the HDMI phy and should not be set by the
encoder, so drop those HHI pokes from vclk.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a942dc6a6dc..bf5cc5d92346 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -813,14 +813,6 @@ static void meson_vclk_set(struct meson_drm *priv, unsigned int pll_base_freq,
 {
 	unsigned int m = 0, frac = 0;
 
-	/* Set HDMI-TX sys clock */
-	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL,
-			   CTS_HDMI_SYS_SEL_MASK, 0);
-	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL,
-			   CTS_HDMI_SYS_DIV_MASK, 0);
-	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL,
-			   CTS_HDMI_SYS_EN, CTS_HDMI_SYS_EN);
-
 	/* Set HDMI PLL rate */
 	if (!od1 && !od2 && !od3) {
 		meson_hdmi_pll_generic_set(priv, pll_base_freq);
-- 
2.43.0


