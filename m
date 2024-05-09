Return-Path: <linux-kernel+bounces-174418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8E8C0E71
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25224281442
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63640131195;
	Thu,  9 May 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nT0TXTna"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0D130493
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251700; cv=none; b=edoD9hHNFC1LpusINuOE77j8iDuTZJCl4etTxUN3oBEaWqOIQHjriHqqZoZPwqimintgLw+zXE6kvuxpZ9Pm0P/LPVSZF5TU4VdX6WwtdJwd2jD0B9wRqOdJtO0GEC+CepXa8sKsC30Y+1l7tcyuLILnw6cH4Zx8CHF3gpZ02lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251700; c=relaxed/simple;
	bh=AhGKHotUOundbhN4X2YTDc462SsKg+3ZxBuT3oDaWHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cd+9jEpDB+XenX47lbhzRObZia5YwMRG/JZ5eWjYFDnWscRDwxUj7yDVusSOrOhlgo2ptnri2oIUk9I4z4iET3o39w7C1ZXxwOl+PXmkUmDqHb2at2B0UvKt6PONmfe9ZM03fYXsTudLJ8ibJSiFjXoXQCiL/PKSYBBbaxCkBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nT0TXTna; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a64db066so173234766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251697; x=1715856497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhk3/XajbYjebewXinPE0P/6g6ueIG9AsQRxMr6tmNE=;
        b=nT0TXTnaL7FfAtbP7LrDzrvRKwzajzdgiNqJQqFfwCS86vqGJczlvppfzFE3o8cUdC
         vWpSWvYDMGnoKd5oUFJMbYs64XWNBUqhhGS8lBqolhHPTUTL13wbiz/r4L6RS7hz3sSK
         A6h5OGPcV2i/KTkWuy3IDnhrXzrUfSsD96CfS/TOFQtrYLqtT8jFnwIkksCIJUoahRt6
         tjgLL+lNWJcc/blGeK2ksvzVzVHKaGqjEbTVM+X4o9xsioiimqEF2PwVEtDlBQFBplFv
         2pqCAStUW1VV91/Yt5Mttyz+h61/OSA5TdRl3875TvYGSJuKibpJXgt9jrvKCysCDYY5
         yX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251697; x=1715856497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nhk3/XajbYjebewXinPE0P/6g6ueIG9AsQRxMr6tmNE=;
        b=eox2d+MGWTGhlmB5hgAc6oHnONGsotmrr3I/SkH/7MMP4ixkIaACimUkGfQoxtqVfJ
         LeVrCUlztdXmb9yCae3BiKcpdcUVD1OF90Hp5hwEfzA/QZ0mqGd0Si9Kbu6ID4yq6wbL
         T0ppxvRDIPr/irEXHrwWCywd2m9vmWB+aGrpNdw9vjglH9puDDhO4abPowtigxg4DJjM
         zvsxdCifhwpnLKHcrKW5i0gdhVZR9U2/5JCfaZhnuLRCOLIhaJgHbQWoQ/YHGFkBCIBE
         fBCKpbbmUER1qahpKsAWH/i62+V6hJc/f3nA8IolIgtlk5GDafNBjI7zVAOnPclp4+LS
         yzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwDMv+ywHw0RmTad4+AbGjv2/YKVqDhJ8AaQAZsUEeHCg9DpaaBYnmc++0bxAVs5FX1PEUpYrahup3E0sHvlE5FuAOxcAfYbsCaYI0
X-Gm-Message-State: AOJu0YwsVwFelTlHH5DG2/B73v0UXXhD/+g93TTMCel21aG0KbTWWMgJ
	rk1Pbkz2/KLVfeUmOBbQ9foUFtfyczcd8okuLeZaEZuWX6WmEQVdaS4ibMFEoQg=
X-Google-Smtp-Source: AGHT+IHQyuhaOFCWDh8Y20z92N/LrJzqyIZFbrRKifXgh0S2UhxNL1L6D0CsxhO9kqq9QHRTuJH7rw==
X-Received: by 2002:a17:906:db03:b0:a59:b590:5d71 with SMTP id a640c23a62f3a-a59fb6ed704mr459961166b.0.1715251697256;
        Thu, 09 May 2024 03:48:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b014f6sm60466866b.145.2024.05.09.03.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ti: align panel timings node name with dtschema
Date: Thu,  9 May 2024 12:48:13 +0200
Message-ID: <20240509104813.216655-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DT schema expects panel timings node to follow certain pattern,
dtbs_check warnings:

  am335x-pdu001.dtb: display-timings: '240x320p16' does not match any of the regexes: '^timing', 'pinctrl-[0-9]+'

Linux drivers do not care about node name, so this should not have
effect on Linux.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ti/davinci/da850-evm.dts    | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-pdu001.dts   | 2 +-
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/davinci/da850-evm.dts b/arch/arm/boot/dts/ti/davinci/da850-evm.dts
index 6c5936278e75..1f5cd35f8b74 100644
--- a/arch/arm/boot/dts/ti/davinci/da850-evm.dts
+++ b/arch/arm/boot/dts/ti/davinci/da850-evm.dts
@@ -65,7 +65,7 @@ panel-info {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 480x272 {
+			timing0: timing-480x272 {
 				clock-frequency = <9000000>;
 				hactive = <480>;
 				vactive = <272>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
index 56e5d954a490..4b070e634b28 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
@@ -74,7 +74,7 @@ panel {
 		pinctrl-1 = <&lcd_pins_sleep>;
 
 		display-timings {
-			320x240 {
+			timing-320x240 {
 				hactive         = <320>;
 				vactive         = <240>;
 				hback-porch     = <68>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts b/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
index f38f5bff2b96..17574d0d0525 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pdu001.dts
@@ -67,7 +67,7 @@ panel-info {
 		};
 
 		display-timings {
-			240x320p16 {
+			timing-240x320p16 {
 				clock-frequency = <6500000>;
 				hactive = <240>;
 				vactive = <320>;
diff --git a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
index d5a4a21889d1..e7d561a527fd 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pepper.dts
@@ -202,7 +202,7 @@ panel-info {
 	};
 	display-timings {
 		native-mode = <&timing0>;
-		timing0: 480x272 {
+		timing0: timing-480x272 {
 			clock-frequency = <18400000>;
 			hactive = <480>;
 			vactive = <272>;
-- 
2.43.0


