Return-Path: <linux-kernel+bounces-443125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499839EE7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E5B18877D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33B12101A0;
	Thu, 12 Dec 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhWp60YW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4D2147E2;
	Thu, 12 Dec 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010477; cv=none; b=ALc9z9PcSZ1seAhQZKUeN+uuqeNt6O7YBc3beahrJ/P6pFqboO+9E9QXT5bPEZE31Hxs1xKWO/w2y+MyBf9NqE64opsyj4axTtJbUe2B6tZ1ClA5/8h55vXgB9Ok8MLyffRfUjdRNP0BQ5yWkHjSJQ/cbHNJRuAd7jW6JSJ0Ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010477; c=relaxed/simple;
	bh=6MEyK6anjoqQVrBVYnr6rWIiMbU/Jn+uvbK5HCwPwPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ga5BJOcRPyhCLqIIWCMckgK4gPMLRbGiZBpjNFnYcxyLacvs1HjjQzVb/9/s3JO0rZx9e9H4DhwREuNcWKUl6CXhYm2m0tHVEBP/MPZtp3DX+kTHVqeBMrI3hCG7TxacVPePtER/EW8heTkk7872szcFftIyOkteOKH2hWG4GcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhWp60YW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216401de828so5452635ad.3;
        Thu, 12 Dec 2024 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010475; x=1734615275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWMAc4zmfYhsrt0DV+vmCYXKX/GHYBxniAba73eEZ6c=;
        b=bhWp60YWk36ob2LF70Mk2/wKGACpFQhxfM3/9Ef+led+EnH7eNPsbh+NmxihMgem23
         CHWJrokIIXP67IR808niQp7gkA2laF8MhsR9qLj5IA7SKgB+l7oefI6l5GluH/Xp3LIf
         Vz3w3I8wT/SUBcJ9WK2z2OoeVPHJ1A9tscE6VfFDzmcaZGQ7soGCCe2aVxRvAfzjvxXW
         EZ9VlVeBrxD6703+LqxAcQ1KBNH4c4JCDRn8dNlMSWK3mEJ6BFFvB6zLwGWqfB8do6P/
         I5TcYJN8RZ2U5df0OzSAIVA8bC9Hd/2daaB8z2wNGJkjhx22y1+wdPIdPSLG+onKj6yu
         MjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010475; x=1734615275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWMAc4zmfYhsrt0DV+vmCYXKX/GHYBxniAba73eEZ6c=;
        b=iy4mZk9EBBzdhBqLsGMk9WKUWmeuT4ffeMN4KYm07eo5YV3Hqp775yRCYPascufYOV
         V8G3toJJ4i3lmW98A6T5KrzIIDNZzpUZoo6qj+m5/vuLErjuuBKdNd79grWKYyXOqtD6
         JKuLldMc531EFoLW7HbExCV403w/+c/Li/xaDgdiipQjR6eOpJecZHoW/KfEKQSjpJ7J
         QtRRuks8djY/LwahMHpb9ZRgR+Z0B1pi/PmBz1ThMk/Co4FWAo6b7+d9wIoaxcZpZ2wV
         lk9FwSWQ2vfwfpZUJkIBwa3Z8FCENAUOs+RnlguwhZXSSBJYiHnirEPaxc7SB02ji2Le
         aUNw==
X-Forwarded-Encrypted: i=1; AJvYcCVx+jWveaVZPutbOlixbUScVGDPrbVfMQr+xTzDKLFoq7eAf1gkSU9PyCRGC1II1PnIeV2K1YWz6lli@vger.kernel.org, AJvYcCXoiutsx1QkDe4FgwBcqCvcYOuA50FWMj3U1MrMYQwgGPJxk1cYdV4yoYhhL7zPLCPAeI0lSUKb2/5aDrzI@vger.kernel.org
X-Gm-Message-State: AOJu0YwfsEWO9Vjd7d4XFlcW8BqlaUYYL1rp+aFoQmCfxVd5oiYpgVmF
	uF6Hg1vaeag9UF92qrGEtudjn9FGtUG6Ge+dcPalJsiofW/gCTcM
X-Gm-Gg: ASbGncuU3rx6AMCMY0uQsUnlj6LwpUx/LICMamThOZ5o7QFMaAoA6gaeaX9Hc7PHpgC
	nbbVfCiMLYm+7Chv9Mt0nTFtIxfQKGSZi/qMZO6zEoPapb1K5zAqR2vooVqSoQVHaZncXNfVOOc
	07fgGt8khjDYUXly2gPUDY98jnG2KNJitfehA9fdXBt0YBoctBW3y2a900gXhH5JKPVShVwwzpR
	0AQSLG3+YrZw0hv1smHpz76DdCc4iOui4vipIYQIFEAB4lHqtdmutkvHej5RthJOlQ3rvjjEq/z
	m2ZWL4TGy74jXIZf/F0aQjxBHGMNd5U17j2Bgts2wXnY7BjWoslIrAy/FwHmz6N1+YUn6eTCvI2
	6L2AU
X-Google-Smtp-Source: AGHT+IEkAjpA5aepVMZDNkc8vUvUYOwLibC5GFvwj+RJ/gySt8BuEg8jjIp5XHCBFQBsOmxVfSqR1g==
X-Received: by 2002:a17:902:ce86:b0:215:7cde:7fa3 with SMTP id d9443c01a7336-21778509fa3mr108167325ad.25.1734010473524;
        Thu, 12 Dec 2024 05:34:33 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:33 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 1/4] ARM: dts: aspeed: minerva: add i/o expanders on bus 0
Date: Thu, 12 Dec 2024 21:32:23 +0800
Message-Id: <20241212133226.342937-2-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three I/O expanders on i2c bus 0, assign the GPIO line name to each
GPIO in use, and specify the interrupt GPIO that has been used on it and
give the interrupt gpio number.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 468a33f50ef2..426e249c3326 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -208,6 +208,63 @@ leds_gpio: gpio@19 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	gpio@11 {
+		compatible = "nxp,pca9555";
+		reg = <0x11>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <238 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"PWRGD_P24V_SMPWROK", "P1V5_PWROK",
+		"P3V3_PWROK", "P5V_PWROK",
+		"P12V_SCM_PWROK", "P12V_PWROK",
+		"P24V_PWROK", "P48V_HSC_PWROK",
+		"ERR_GPIO_IRQ", "TMP75_ALERT_N",
+		"BMC_PWROK", "P12V_INA230_ALERT_N",
+		"P24V_INA230_ALERT_N","",
+		"P48V_HSC_ALERT_N", "P1V05_PWROK";
+	};
+
+	gpio@12 {
+		compatible = "nxp,pca9555";
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <240 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"P1V05_PWR_FAIL", "P1V5_PWR_FAIL",
+		"P24V_PWR_FAIL", "P24V_SM_PWR_FAIL",
+		"IRQ_NW0/1/2_N", "IRQ_NW3/4/5_N",
+		"RTC_INT_N_R", "ERR_GPIO_IRQ",
+		"", "",
+		"", "",
+		"", "",
+		"", "";
+	};
+
+	gpio@13 {
+		compatible = "nxp,pca9555";
+		reg = <0x13>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <242 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"RACKMON_A_1", "RACKMON_A_2",
+		"RACKMON_B_1", "RACKMON_B_2",
+		"", "",
+		"", "";
+	};
 };
 
 &i2c1 {
-- 
2.34.1


