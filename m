Return-Path: <linux-kernel+bounces-267537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385FD941291
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634391C22F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26061A2578;
	Tue, 30 Jul 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wzYStVC/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6A1A0B0F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343845; cv=none; b=dYG8s8V0MzHxqUN6ssQbJ7DP3zatlUJT4U+XrmaKXtw76tdVzIFq8Szi8/yJxNPNPVbeYoWPZ7ASiorD4tfeTGa3hcMaEz/rHen7r43Du6J6BW28U75M3L6TwPN6Bk8EhDJSSpIGyZV4tk70h0/bwsh5VUNYR43e9UEZVSe5NA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343845; c=relaxed/simple;
	bh=kubTE9AC2Pg/AoZHReC/ZgfxbiXThkvnXAzcCh6wvOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzpNArwVDZ4YKPtigUwbq2aqe7uUyxctvkj4IXANCzZ+CVyktxdOWoxoBMKhlJGjudan3p+vMekPYpf2y22+C++5yzsFSagAgNLGKMOC9n0LJaqddigUC9QTz3E9wt3n7oIQsdzv5j/1SS5VVJWrsXEno+5e3usNeA9YiKQOS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wzYStVC/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso22433795e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343841; x=1722948641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3moEF5UgUPlJrvGfGCZqAdn43td07ni9TXGHevs5IwU=;
        b=wzYStVC/gub9dZ+rlu+alhO/6jyO6d2fkWHmf+HZPOD92TXQVvHnYDpDz+3mula+zn
         oRmexO38dsvL2InEuYo5xQAHxycMZI3aNAWIOktAlq8OOu8f5c/+Jf8CpkBL35Ct0Rm+
         kXG7GvUwV73hqBInUx1P6nE3hJxO96AupMuKRnv0AISkjlcX+EHj88hOTCazG7rHSvJg
         5EnVYAHY/m/CjrJ3Vc13T8lsyyVyjJo7PomrwtbwYQC74uCA96wIniJznF14RAQP/OKG
         QHTo+IZz59dFsFxhww5fFDcF53MtwMcpYEoBLtccy0xYwNAGEt7pOLK0FTT1jcBcFa7r
         r4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343841; x=1722948641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3moEF5UgUPlJrvGfGCZqAdn43td07ni9TXGHevs5IwU=;
        b=uf+bR6OAxW5lwwTA2ki+Bs0jT458gKJVsZTQzJGpJe5Y1zZzMDwKtHdMLON4FnEMmH
         TWXfM9d878RDKEAcb+qcc0SJ2x4c155xWVs9eDy2FyqRLFNIzUztpQNvYCegcvQTph+w
         jH/cEm0CfHgOwSvaiqLO+jqbNjLSmGgQwMHtdgutrmcJi+13Xc3QZXndMlJVag1Sbo2j
         E1642v1O0VV7Z4f/Gv2CKX0HFRd1Te6zy69mj+pM3GkR2OZv/Mf5panVigm5vR90SimA
         HfilMbVjPoWBC8ZZAiyaRhZLDLpXvi8A6fW8Xi977alnWV3u50T9kGuAivbW4qTWDdJ0
         EPyg==
X-Forwarded-Encrypted: i=1; AJvYcCWUug+ZBNgT7c8RpU6UGEtw9opn/QGVXez6FwzrsiawrQMQzMLv2TRUEUeqMqYSzyp4ZGxk2TqQOzLvIYf1M77sssww3GpeF8A/n6+w
X-Gm-Message-State: AOJu0Yzj5Z1HrfzmKU/Zuq/yazbsbgeM7BDxw8d8IOVzR2rw5XihJv/e
	eGkM0ErB7si8hOAsEdJ8F7mDj7BLSUA6u+nazTKU458zFK+8CjKUxD4ViagnN78=
X-Google-Smtp-Source: AGHT+IE4w+wikVhp2vCBwTP2wSRMRyso4c+p6a52Ji4CPU43wbv4hy3g2InI/NLX3kHSQY2Kj2YIpA==
X-Received: by 2002:a05:600c:4ec6:b0:428:1eff:78ec with SMTP id 5b1f17b1804b1-4281eff7a44mr41585485e9.18.1722343841397;
        Tue, 30 Jul 2024 05:50:41 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:41 -0700 (PDT)
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
Subject: [PATCH LATER 8/9] drm/meson: dw-hdmi: don't write power controller registers
Date: Tue, 30 Jul 2024 14:50:18 +0200
Message-ID: <20240730125023.710237-9-jbrunet@baylibre.com>
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

The HDMI phy has a power domain properly set in DT.

Writing the power controller register directly from the hdmi driver is
incorrect. The power domain framework should be used for that.

HHI is a collection of Amlogic devices, such as clocks, reset,
power domains and phys.

This is another step to get rid of HHI access in Amlogic display drivers
and possibly stop using the component API.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 This change depends on:
 * f1ab099d6591 ("arm64: dts: amlogic: add power domain to hdmitx")

Time is needed for these changes to sink in u-boot and distros,
making this change safe to apply.

 drivers/gpu/drm/meson/meson_dw_hdmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index ef059c5ef520..6c18d97b8b16 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -111,7 +111,6 @@
 #define HDMITX_TOP_G12A_OFFSET	0x8000
 
 /* HHI Registers */
-#define HHI_MEM_PD_REG0		0x100 /* 0x40 */
 #define HHI_HDMI_CLK_CNTL	0x1cc /* 0x73 */
 #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 */
 #define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
@@ -423,9 +422,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 	/* Enable clocks */
 	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
 
-	/* Bring HDMITX MEM output of power down */
-	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
-
 	/* Bring out of reset */
 	regmap_write(meson_dw_hdmi->top, HDMITX_TOP_SW_RESET, 0);
 	msleep(20);
-- 
2.43.0


