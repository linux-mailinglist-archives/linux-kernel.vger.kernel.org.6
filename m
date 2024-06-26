Return-Path: <linux-kernel+bounces-230928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47D79183E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BE21F23667
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CF1862A6;
	Wed, 26 Jun 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XUvU6t14"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E41850A5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411756; cv=none; b=WhbNGAx0PJrGonCmNnJGZ7NWFXkIgpIcfqOEf9PPmVlHeyG8NTmpdNHDpH9dO1+ufxRIWkyX10LhQUCHlfcyfI9IOzY7wzpRwBW8A8K2WI1eAgu3PAMYM5kKK9xxBhqjI1RWkzaPPGqKWdaZ7cdauh68hJMFci4xV9I11KumdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411756; c=relaxed/simple;
	bh=fmmEZQRa427ZeOpTPM8v5KdYuz7uZ82dzZaE4wNfZhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoVlQFadNAT4w0RfFx9pUNTLdGL34H8CoUKraEDrG6QlxtsKJy5DFdDLMJMcaL10s4GYYS1G9J07RU1GSMqV566Vu2dA3wkBHBTOR2fXLi5QfjTKq2jryN300+JvWW5jOPSYAufbPES4/T15ImhxBSIqhj/8TL8uhK7/tSnBOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XUvU6t14; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so29530381fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719411752; x=1720016552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSOqd6xFtwNmB6/la0EhwilFZVmFb3e1mPm8GFnYuuc=;
        b=XUvU6t14U7PnQW0WdLNPfm+P0zHB+gOJKWAUcqwqYOG1abOd+kN27KObgQOMnjVVWg
         nDNkVdLgVVQ5SyVdqTiN6XXs78EIaGfuwb1BOgNaZOZCcIPqoXMfExbsfYJ6fLEwiuoT
         /kB4ppGC84vmZo8bE/gRMDorrNhq7JxryOfW2n2Su9Gj6q6C1V+TXg6Lh0YBZx5W0b8B
         kKx+jBGyepRl2+xcaQirXyGs2y5Zevdpk/tg8Vv2tMAoSnFKxKZiwgayc7oPiD8h9rM1
         hSRr6sZgj93+BsvAyNFa/uT0noO9tEHdF8YEpGZjv6RXxL1CdFgxvvltBCyG/n08yjkA
         dLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411752; x=1720016552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSOqd6xFtwNmB6/la0EhwilFZVmFb3e1mPm8GFnYuuc=;
        b=MQmf+MoiYCMmz/lA1//RRUabY79U0/ZqfygOWYJvUozD5a113ChtLhv+C02LW17y/w
         VLJiRS2vbikdELYIDyyfkA/aF8iEkcwFM92WURB/dgZdnfXU8aMSmj/vEvtsqvEdaJB2
         6wwpEL4zUlRLa9xVk2C6teM15Wqg4HS3q9InDi+1CyP7Ut5ch8HhOdzPHH6shGcRnDeY
         bE2+26Vjvo3dIkUJIADY2e5qOLk3gN913XbkXqRL5sF7LbkwuT5rqz874RLWWX5335Ps
         1MqkSQW9ZtZ5mdYQFEMbugg5YYvIgiGBOFxaH+QkybSTsluyfTllyh5IRaL+QMoTm+RJ
         Co0g==
X-Forwarded-Encrypted: i=1; AJvYcCVl4QDWh51NVt+2kjOXe9in918n4k90vGhBWaf4rOIIGhu0L1huyP2ng7RJVekKeTFbK+bl/0T5lYGFzhI8tutTnC8RY73JjMrXCvTo
X-Gm-Message-State: AOJu0YyGoVG1oOMdGJscwCvqpn3XcTTdYgybD4X+L9JKitwhtKtJjM1x
	YBR2w97eqh/+RN/IGQDf8Ny5bS8s8dXVLj2wJL7HjLDjbnlyYilOPFqaibKP7QU=
X-Google-Smtp-Source: AGHT+IG5doh7ICzMm/NrOTR59CEuv2r+Q5IA9UA8wl9i2JaEBBV0vUoMwj/zrNmZXpgh5C2T/Pl7CA==
X-Received: by 2002:a2e:9b12:0:b0:2ec:559d:991 with SMTP id 38308e7fff4ca-2ec579ffb28mr70805581fa.50.1719411752241;
        Wed, 26 Jun 2024 07:22:32 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:7be7:aef1:af9e:fff6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424c823c28asm27141105e9.5.2024.06.26.07.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:22:31 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 2/3] drm/mipi-dsi: add mipi_dsi_usleep_range helper
Date: Wed, 26 Jun 2024 16:22:08 +0200
Message-ID: <20240626142212.1341556-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626142212.1341556-1-jbrunet@baylibre.com>
References: <20240626142212.1341556-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Like for mipi_dsi_msleep(), usleep_range() may often be called
in between mipi_dsi_dcs_*() functions and needs a multi compatible
counter part.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/drm/drm_mipi_dsi.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 71d121aeef24..0f520eeeaa8e 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -10,6 +10,7 @@
 #define __DRM_MIPI_DSI_H__
 
 #include <linux/device.h>
+#include <linux/delay.h>
 
 struct mipi_dsi_host;
 struct mipi_dsi_device;
@@ -297,6 +298,12 @@ ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			msleep(delay);	\
 	} while (0)
 
+#define mipi_dsi_usleep_range(ctx, min, max)	\
+	do {					\
+		if (!(ctx)->accum_err)		\
+			usleep_range(min, max);	\
+	} while (0)
+
 /**
  * enum mipi_dsi_dcs_tear_mode - Tearing Effect Output Line mode
  * @MIPI_DSI_DCS_TEAR_MODE_VBLANK: the TE output line consists of V-Blanking
-- 
2.43.0


