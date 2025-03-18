Return-Path: <linux-kernel+bounces-567046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6CFA68059
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E1C178FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60F2147FE;
	Tue, 18 Mar 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z1AgQk3M"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153312144C0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338864; cv=none; b=KH6F+O6bUd7e6DIsxCZ7160qcw4qxiMVlGDZh+Jyn8bFkerGAxx6Se5TcLbTLh+2OhY3YEhJMMZN664eCKHgZ+EQ1F5Ja/sck21CzSYnl8+8N4QfScCB14l5bE+ZaTJU2XBjlJY4wH1OQCEScrKz4zOPNUprkweu2+tQgqR1MLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338864; c=relaxed/simple;
	bh=/uzA/KJrTOFFakH+TO1IPmQV5uCsNGlZTZ/BRQx9ipo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2TwaPmmsO6C9ohDWkGJQK0QQao6sa3LJ5OAONENXnKlptVkD+wHkzwxy2AJ5SUxxmWxNt2fGhhoJqA452zaxrlj9t/oGTvDG1l+Wn/LOcUcblAapbTEgKMD0Sc0j+EhGW5ZFCNCurudYdxd3RUBr2oyF61D35NR2P1wll5cD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z1AgQk3M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22580c9ee0aso108172205ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338862; x=1742943662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMDUDwI/ykvsmvKBODi6azon2DC/c4gZowN4BruVYoU=;
        b=Z1AgQk3MvsOV1TC4Zfxl/FpKRG3Gm29LQDXUPhgYLz9TjFQIwqBDpUokYXqkFyvPT2
         q7iHRPRIFZvTqPLfl2evfJ+tV6kcMMgxQF5dRTibjDg0AdpNfJSGtCzE45+bao00y4pT
         XMU1vL5NHoBKcCDpYARCDubQJYEr+F2bgYB+wBvr+VU7bIhT1Q/An5LihGf5uVOWTblU
         b5fOdwRmhxuCHRfzcHN1ZNOxpfXzei+dounf33Is+ZcqLMFrZsTSRmRIGMvwD1xJVUMq
         zomibMFLhhmSXGSXWdcegwXzXnR+NoTUHHDKeoTVHR+7ZbOLPDsguAfToZYkfMiPH06M
         nbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338862; x=1742943662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMDUDwI/ykvsmvKBODi6azon2DC/c4gZowN4BruVYoU=;
        b=fRb0WYOFN1wxlOL1FhMJT9N5hYUtNOtfOmY8K4C8wKYCC5XXZ4Anmd/58IWaJdmvy5
         TxScpuSmAkaQUgs3l90nc7lftVliLNS+jcaYroXcKT6ZynDvd6JhkKDpCKv5XG2iz2AO
         rRkfg+eOC6nTBWM4357joSDuPnlfs8wG041wvDnPKbgd8qdA5KKSm3n7yoFtPXXhknAy
         Pk3Uwyj7NMdxoLjtLZ3TWtK3ZsxH3Z68i1q/QEzusw3ePayjlinxJBzpI/rD6p92EMsj
         t4FQFfUkuJAbJjs+jVWc2dfnllRkUxCqt/VVnq34ppsw18qly28gUxgWjPd8uW23B5vR
         dv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkcPVaRCoPHTmPEqNmhpuSUO7stfkCXPxzqBX7E7XxrhEE/hzV8yL9IHt7C3UiIRYIBR6QRMoN4I/glog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63zKIffq0ujKu6ct0Bjz+cJ34m1B9Gh8tmuMPk8+mZd5URLPF
	VN5szz9fw8+H4eN3U64GeKMiGZmiKo4HWAdjN5pjRB78pJH6IGCmthPnXOLXe0I=
X-Gm-Gg: ASbGncvhoDCa6AEP6n/EjnRJx0zJwvD+SsvjOdvAk/n/7/t42ereZ93e2IaJsteqWfp
	iS8q9KNcfDY1dPGoh3AKcm8vwSCQcDhWXHN0rZxLcpy3sVoIs5WzoPWdg2kK/UJz7wmLJfm8Q8G
	EaCoXOo8k8fiFNE0jHU7KUAj5FVpN+EQfxuvne0kwt/wXQvN1k8wD3dcnjGe1m84CR2UNXrXDyZ
	oaOtWblKFvjAdzEK+cv9ErFCVtOGrKisHvoScyx9+57TEKaznRfI2jq51mcY8iFshVE5S1sUl0/
	SZ4eLwy0y6cYRNSDK8CJZJxrD6A4aZPrFBFgM0Tmv8Kq2+BvnngILJj/x/8XKYPwHqF/+hz3y4V
	9yaZbRAQ=
X-Google-Smtp-Source: AGHT+IET8hPlzYxJjNAKwUxaX04oJy+bl8g7nOQMt8+vAfkRPrb30J30Y6geQFPYgmWuAJsrOk+VLA==
X-Received: by 2002:a17:902:d2c6:b0:215:acb3:3786 with SMTP id d9443c01a7336-2264993661fmr6704785ad.19.1742338862423;
        Tue, 18 Mar 2025 16:01:02 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f14sm100739465ad.111.2025.03.18.16.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:01:01 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>,
	Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Bajjuri Praneeth <praneeth@ti.com>,
	Raghavendra Vignesh <vigneshr@ti.com>,
	Bin Liu <b-liu@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Enable am335x PM configs
Date: Tue, 18 Mar 2025 16:00:42 -0700
Message-Id: <20250318230042.3138542-5-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318230042.3138542-1-sbellary@baylibre.com>
References: <20250318230042.3138542-1-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Power management related defconfigs for TI AM335x[1].

[1] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf

Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 37e3baa33b67..1d2600b5f975 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -985,6 +985,7 @@ CONFIG_EDAC=y
 CONFIG_EDAC_LAYERSCAPE=y
 CONFIG_EDAC_HIGHBANK_MC=y
 CONFIG_EDAC_HIGHBANK_L2=y
+CONFIG_RTC_DRV_OMAP=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AC100=y
 CONFIG_RTC_DRV_AS3722=y
@@ -1095,6 +1096,7 @@ CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
+CONFIG_WKUP_M3_RPROC=m
 CONFIG_OMAP_REMOTEPROC=m
 CONFIG_OMAP_REMOTEPROC_WATCHDOG=y
 CONFIG_KEYSTONE_REMOTEPROC=m
@@ -1146,6 +1148,8 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
 CONFIG_SOC_TI=y
+CONFIG_AMX3_PM=m
+CONFIG_WKUP_M3_IPC=m
 CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
 CONFIG_KEYSTONE_NAVIGATOR_DMA=y
 CONFIG_RASPBERRYPI_POWER=y
@@ -1162,6 +1166,7 @@ CONFIG_EXTCON_MAX77693=m
 CONFIG_EXTCON_MAX8997=m
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_TI_AEMIF=y
+CONFIG_TI_EMIF_SRAM=m
 CONFIG_STM32_FMC2_EBI=y
 CONFIG_EXYNOS5422_DMC=m
 CONFIG_IIO=y
-- 
2.34.1


