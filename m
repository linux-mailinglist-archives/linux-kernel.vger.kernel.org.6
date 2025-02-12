Return-Path: <linux-kernel+bounces-511877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9BA330F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EA43A894B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E620126C;
	Wed, 12 Feb 2025 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqgXU07x"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F9201017
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392985; cv=none; b=WM6x8M75jKYkLoyslS01/KVmC5jo27dF9PBlpUXr7d3lRjYsgmYG8a1vIWYKPdMGfZFy3os5ac7fjktcvjA9ygZ6haa892Ke06utSJ6zsdtbHUdv5Qqlo05vCtMzfa6kDnpLaVKmjBb9f2BMU+US4IApFewR6xW91uzHq2qvFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392985; c=relaxed/simple;
	bh=XgqP6D3slvW2XhE3IfH2Ry6mr+8u/wmiLlSz/P2+k1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXMgsSDh1yNnY2kXyPTnOC19XFzAf4udOA4WpwY0mipy6fqB6il6bij2GHNxEKRX1ms6/HV/tVz1R1J1BNWmxTOJ84ilguDseyFBpvOIyKjgrtHQXaPQ4bb8IRwCQ4oOQKJC/Bmo78cuC3IWzXZr8BDOqnUzIUbCMScv0o5Cy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqgXU07x; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dc9fc48fdso18029f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739392982; x=1739997782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PEaEtl2laaTtSXlR7EepykbACdsERKpfJRZ5RMDW/s=;
        b=nqgXU07xMtgs8hRtlcjtowFRHM2x2eib96XXIygzdzwJGjykGi2psXY1Xe7DNPJQ9M
         qq54lacXPxOCno0/m9A92dbhdTllcdHm6ZB2Pzu7v9aQiyOPpXhZW8YJjWusR1C99cSg
         4xlsfeXp0Q2NxU0tvGABKs3vDmw3BL9zfW4Dfpw/RqYgw6Hf7jlNV4WeEjfnoh+lkhV4
         S8i3oKg5U6j665N7v06KeZH+4M+f3ufAqFzxgU12NBz02FnBHnQQHcITcDUlQBXIzBvY
         +BATtrpiUsALI7/ChtXxPoGVsw7QFM8mobPAHyO5XOM+Bk+Vsglv/JFoMKj5hWfzgnt5
         GDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739392982; x=1739997782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PEaEtl2laaTtSXlR7EepykbACdsERKpfJRZ5RMDW/s=;
        b=FDHaP85Rq2UrQ/cTkgOYz1Y6LiQiWxePwyYQK6l1KNedMq3PO/Qx73SRWXCamO7s8C
         puJhFoxXqDDMsaLtue0MB/RxLavr+WqUtB3CotyE7fdL0p7XMOeIXG792fuO/IW71jFc
         TSLr923YstVz7u1e0auhsJ1nHAz+NvsyvdGQXXjybD1nwLeNh2SkleqsX2ipF90MMEQW
         +4Ow680ZtWy+efn/ELJNOxJZZbQHegYAq+R8c6AzsU/ug1ZmXccJ26F1kEHdTFHdA1/w
         287Kvf3XtkmLjo75MO5iaIumxmNeNtOuqro/3qO+XezC5ICT/CDyXypLzH7JB0SeRkce
         I3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVsnkN73MXZARji31sr8wxjudkq3gUeeth7RFpRuIOQk3ZvsKLAzaQI/E58BOFu/quDkKATVEb2ExVINW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyq+DJitOiedyatN/P9oLlbqQ00Lvw/D9PROhsanv06PxCkSF
	LS8sSfBiGstVYVMs9sDtPwgBiWpC4ouT9J63vvl+BNW2/pKLCVx8VYOaBN3e6lQ=
X-Gm-Gg: ASbGnctcL3AhXXQw34QA6QoTuPRDEfrzTdqqLVsJMU+XTtErWLilsNHoKx8tfIe3GvB
	wjInwoPj01Qz16KZWZjPnhkqkEWS1lqNkWYCyN44YoTsnfp0qBwFgXymhsOFc/cSLgxX6SO5acr
	qx8Csp3kSTnTPdpqAHU02DjQVPQhESfCtdKG8q0CjyX8+rqgqx5mZqrZdXzLPLHwF4Gu/QwEXs+
	uIJn4UpAFov8Qh3/ZthIy1Gm6XhlL/RvJ/vTyHonVwyQafM9ItuXKXZdCvSelPV7h7rNXGXWbzr
	R/EHKp6UwCz9dyZdcPQdQmHAdTwMDg==
X-Google-Smtp-Source: AGHT+IFFs77Lk2FDJk54yPret+BrCBmHkbbfJgHImDbky3pssPs28syG1zh4mSnU8lo0JUZp/V9gVw==
X-Received: by 2002:a5d:648a:0:b0:38f:2113:fb66 with SMTP id ffacd0b85a97d-38f21144679mr1179580f8f.9.1739392982175;
        Wed, 12 Feb 2025 12:43:02 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcfd7d153sm14237664f8f.84.2025.02.12.12.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:43:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ARM: dts: marvell: armada: Align GPIO hog name with bindings
Date: Wed, 12 Feb 2025 21:42:58 +0100
Message-ID: <20250212204258.57514-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
to fix dtbs_check warnings like:

  armada-385-clearfog-gtr-s4.dtb: wifi-disable: $nodename:0: 'wifi-disable' does not match '^.+-hog(-[0-9]+)?$'

Reviewed-by: Andrew Lunn <andrew@lunn.ch
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add forgotten Rb tag.
---
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi | 8 ++++----
 arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
index 8208c6a9627a..7aa71a9aa1bb 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
@@ -453,7 +453,7 @@ &gpio0 {
 	pinctrl-0 = <&cf_gtr_fan_pwm &cf_gtr_wifi_disable_pins>;
 	pinctrl-names = "default";
 
-	wifi-disable {
+	wifi-disable-hog {
 		gpio-hog;
 		gpios = <30 GPIO_ACTIVE_LOW>, <31 GPIO_ACTIVE_LOW>;
 		output-low;
@@ -465,7 +465,7 @@ &gpio1 {
 	pinctrl-0 = <&cf_gtr_isolation_pins &cf_gtr_poe_reset_pins &cf_gtr_lte_disable_pins>;
 	pinctrl-names = "default";
 
-	lte-disable {
+	lte-disable-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_LOW>;
 		output-low;
@@ -476,14 +476,14 @@ lte-disable {
 	 * This signal, when asserted, isolates Armada 38x sample at reset pins
 	 * from control of external devices. Should be de-asserted after reset.
 	 */
-	sar-isolation {
+	sar-isolation-hog {
 		gpio-hog;
 		gpios = <15 GPIO_ACTIVE_LOW>;
 		output-low;
 		line-name = "sar-isolation";
 	};
 
-	poe-reset {
+	poe-reset-hog {
 		gpio-hog;
 		gpios = <16 GPIO_ACTIVE_LOW>;
 		output-low;
diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
index f7daa3bc707e..cf32ba9b4e8e 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
@@ -34,7 +34,7 @@ &eth1 {
 };
 
 &gpio0 {
-	phy1_reset {
+	phy1-reset-hog {
 		gpio-hog;
 		gpios = <19 GPIO_ACTIVE_LOW>;
 		output-low;
-- 
2.43.0


