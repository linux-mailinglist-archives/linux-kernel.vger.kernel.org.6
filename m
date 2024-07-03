Return-Path: <linux-kernel+bounces-240011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E19267E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908231F21292
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB41190469;
	Wed,  3 Jul 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X1KNbFCU"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7218FC82
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030315; cv=none; b=uOx4YOOg5mxthr1ivkozRjdz+oCracAOTyQojH966Z3hp6G+wwjxmDWsAJXjrfSZyrFnNvbpdJBqd3VH2qE6Gfi1ZaUql7RsmCqWVIBq6xYVOkIZ8lgPDrPY8QiDn5xHRZwoXu9DT2YBz+OjPVbBsDT2O9Rt6XVDFxjvcAaODH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030315; c=relaxed/simple;
	bh=aWRGwjNl141O0N2eu4pMGXstKpSbZTAZRRlvToIsLls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhn0LHAgRWUWp7TqUemeiVtaF7u73ML7+ozh8c04Q6FlfNNA8jC9wOUnhI9UEqi3Tyosfst3NgnNUjvaYSLZCvq7W5s5QjurqTorn6OtSaH+3Ja1VtPjN7IS6NSLG+HGNXzQ64sPV99+XXEWX5C8fAdivDVdbNhVwe+SFFglOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X1KNbFCU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee7885ac1cso22827631fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030312; x=1720635112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqzfRYx/eBkp9k5OzF2pgC0wEOIaJNu82fson6xrplE=;
        b=X1KNbFCU1gDc5vccHTUiVy9mhdC2JJSI1+PvfxFU6QWmIjERx1Z//lROvGq8jgEKFx
         fZu496Dly1Fc16UIJ86sDkoFO3n642n+h0v/DodzrmK50ueV13DPbfyxQvpsPuKkV1fF
         vRlwj0ecX4wWTSC5vCb7sa+Wk6i2faz0Xij7A0+IdK03zYkmqVxnULDPfCNtSU3RegJk
         be5ArIv+5ROzTQreEXRcbzRfct+Wet4lrBt9j+TT+yuEJ2F1EZiPqoy4BGjsfzMaW/ht
         k0kAFCjhCoTOILP274s0JQ6+1R0omP4ViwEYtIcnxVfAjeR575DK6y5Wd4IiJi7nLr7r
         olDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030312; x=1720635112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqzfRYx/eBkp9k5OzF2pgC0wEOIaJNu82fson6xrplE=;
        b=qHHj0NmhFy5Y1w8005nJsUIz5DZv7eJC4gbbC2QdvyvMCywnEqNVQmTSqn6BDrZWdR
         BEnB/GlehdCQ6YkEM9M3zB4C5Rua268OXce5W/VK4ITrXGRWYem5Vlnxf57lynhMwvW2
         0pfpp33Pc8lKi4yiZFriS5gDQLd01VXVsl+yWqZiG3FPWllDaZH9yPmhD/G7ugP1uUnQ
         m4/RmE6ktQitK2iq4nIsY15B794/TCLcqLu99Hhx3N+dmLnHw8dfaSGW1XDZp+7qIcqt
         EeLPUn/ynBFabzmmw9SNF09QOovzVGb/V+Q3/ch+3a7e1wlAvl3/MYcw5wiqqpvastgP
         W6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUPpbvqhNW/GesYGUKA2Hj2J6SjroSh/GuIBU0Y+xS8B2GDl4pBEzYplepAMdbFtuNCq2re4B1qfu2/44+LSl/nyghy5s1pIWoFhY2m
X-Gm-Message-State: AOJu0YxspPRbUJ3Us3XuoRMfvaH+cgwPWeZ+OUz46yQpizEE0GLDT4iE
	646b+qP9hXXmg3BxJcbVF4uiKifEwlJI930nmx2pJ3ekXvxzdDKSmTO0F4ks99g=
X-Google-Smtp-Source: AGHT+IGJ92MJnvwayKor/szhFQMSnyPVZIaE+W1/4fVR28fkPdYSuQi6QNltMsxfShBRYqDRjb91IQ==
X-Received: by 2002:a05:6512:114c:b0:52c:de7b:586f with SMTP id 2adb3069b0e04-52e8273656amr7958556e87.67.1720030311256;
        Wed, 03 Jul 2024 11:11:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm255295965e9.9.2024.07.03.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:11:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 4/4] net: phy: aquantia: add support for aqr115c
Date: Wed,  3 Jul 2024 20:11:31 +0200
Message-ID: <20240703181132.28374-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703181132.28374-1-brgl@bgdev.pl>
References: <20240703181132.28374-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add support for a new model to the Aquantia driver. This PHY supports
2.5 gigabit speeds. The PHY mode is referred to by the manufacturer as
Overclocked SGMII (OCSGMII) but this actually is just 2500BASEX without
in-band signalling so reuse the existing mode to avoid changing the
uAPI.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 2c8ba2725a91..d12e35374231 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -29,6 +29,7 @@
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
 #define PHY_ID_AQR114C	0x31c31c22
+#define PHY_ID_AQR115C	0x31c31c33
 #define PHY_ID_AQR813	0x31c31cb2
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
@@ -1005,6 +1006,30 @@ static struct phy_driver aqr_driver[] = {
 	.led_hw_control_get = aqr_phy_led_hw_control_get,
 	.led_polarity_set = aqr_phy_led_polarity_set,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR115C),
+	.name           = "Aquantia AQR115C",
+	.probe          = aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init    = aqr113c_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr    = aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.read_status    = aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend        = aqr107_suspend,
+	.resume         = aqr107_resume,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings    = aqr107_get_strings,
+	.get_stats      = aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+	.led_brightness_set = aqr_phy_led_brightness_set,
+	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
+	.led_hw_control_set = aqr_phy_led_hw_control_set,
+	.led_hw_control_get = aqr_phy_led_hw_control_get,
+	.led_polarity_set = aqr_phy_led_polarity_set,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
 	.name		= "Aquantia AQR813",
@@ -1048,6 +1073,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR115C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
 	{ }
 };
-- 
2.43.0


