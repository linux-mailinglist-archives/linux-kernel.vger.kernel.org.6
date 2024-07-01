Return-Path: <linux-kernel+bounces-236492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122391E2FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283ED28378E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1358416D4F3;
	Mon,  1 Jul 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGQWCVA5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E416C6AA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845812; cv=none; b=NmX6r3bcXWqoTs+bIdDxzLIzhAtFYTyx84ApN57IG0txXvpYDxCjSgGahk4IlC21N+MWQXZLhQnDPSaUs4ThEMorpfHdo5Db0eOd7XZ+K5BtYlxEdO7lVgvkIlg7OHbOMppBMpkHe+rDWCGVWRTOXCpNsoPLr2oyZT/AY7iY+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845812; c=relaxed/simple;
	bh=Q1NUZUtC4GG3C6QOvJgf4AOWOBQMLmgY6uYJKF+rfe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KeuJf6nrhWVFtvWKYyXW10ZxZiDrHYVHTYcfvhibllDgRUGgVLOEikqKYgE2y9GwKh52szog3K1fAzw5HSv7C93My3gXj/o7ePXXvaw1BnJbsaG4OtPONlgSYx6cEb8wAvVjHvq90ixRndR8LqHf3UxEuCmtNJPabQlC737Y0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JGQWCVA5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso24442865e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719845808; x=1720450608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQ0c+IOKkUe0E3OrCRXiJ8eeG27mFVJAKR5cx71uFwg=;
        b=JGQWCVA5CJweO5WkvD7xGU9o0Vi76QNq75705Qdy2FeBx1fKEGBm2ymdRKlBpBlfpW
         IRnkTvNBokNBkNIRyagMAecdDIc+mM4zOLoanJJotGP0shHZSQGoXueZfbWNnW03VyaE
         kNqUHlJNUz19voUmSj+3N7X1bJNaxXgxhpSf9ap+gJqtv0/8IdUg3Lyf59J2YA46+0rp
         9jn3DknqsqM3ThHuogoVwweJ0Fp280vmaShaigwTru4c/feIniqOqukoHtuMzrs31Vuv
         5QD+bBvNnB0yhIPB9MHVcYzy3AUygVj3Mnef42T1UPkdA0w2VkbBFTJbJfG3sHoPq+iJ
         mJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845808; x=1720450608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ0c+IOKkUe0E3OrCRXiJ8eeG27mFVJAKR5cx71uFwg=;
        b=iChBVSC3bcc7Q60iRJJTpGHez1Jky6iLn8rstI7rktRTEPlo/b8vMMx31zmqy4h9yn
         KlyXL8sj0wKU+sBP/kqWHn0J9Oba7lNdGZzGoZuaeLPTBcfYSxE9ceeBAaoXWt2CdI2N
         izCfMmNxjyMJkoYofksJkpS5nKpGLykgSbGJVgBDMig0b6PE1HOB8PZ+5EwRGxhq0/je
         tPnWZnmqPagFJyX/yU0Ko5y3TzUHPJXH0h4Cqw8r7CN9pOY/stimk+lYxOW2R6OVUwUA
         0+eWNt0ZU6oOETcrPKLF7XaUM1FatE+F1F0zyzq1bRkztxq1ZAxT4zNxAGOJQM7sEaj9
         MeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt7bNXNLHKL/vI/AM3hnrDQfTGlFt/1P2lQ0mBMOHgFzeH8JVGnVnc3G7mHTWoi/QuS/k/qqzEnkEIS2QFfTuAfc42WbESCbCP8yN/
X-Gm-Message-State: AOJu0YzmQPvWsbO3CY1UpeO8p2FbZ30siSXUm2sZGwxcT+tjwQMzkOCP
	SNvHOjB6wdK/tLgwnNEmJ1V4L6kVq8TwJFnUIxGSzRwWZ3Z9JsOMbu7w9hg47HPnKugggyVRVjv
	2
X-Google-Smtp-Source: AGHT+IEqgPzDRjbCsJB/7GrlivE3MAxrFEqYxvomzupSXQraXO65qTSvx8t6+a3i44nvsYyUkG3sEg==
X-Received: by 2002:a7b:ca4a:0:b0:423:b756:cdaf with SMTP id 5b1f17b1804b1-4257a02f3b2mr38614135e9.23.1719845807277;
        Mon, 01 Jul 2024 07:56:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm160062915e9.41.2024.07.01.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:56:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 01 Jul 2024 16:56:36 +0200
Subject: [PATCH 3/7] ARM: dts: marvell: kirkwood: align LED node name with
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-dts-marvell-cleanup-v1-3-4773bd20691a@linaro.org>
References: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
In-Reply-To: <20240701-dts-marvell-cleanup-v1-0-4773bd20691a@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=33749;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Q1NUZUtC4GG3C6QOvJgf4AOWOBQMLmgY6uYJKF+rfe4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmgsOljOJ5Lnn9VbFjhoyoybYNhM57XfPS6W8lx
 GzbaCZixbeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoLDpQAKCRDBN2bmhouD
 14YqD/9Zemi6xlrATyH2lb95bAAooYZdus4yuJ4KdUwI/K/7DVoU3OU6FLXdeE3FFE246BVZpjb
 u7V1wHP39KOpuq2iIMKpO661GpSQC5hRmvhROMaDBac1j2P7qdQQVdoZHDgIw46mKH6jC9lo5Do
 AmumZnojuQlsORELMnYql8PYTikkn01qsOO+WAUO69GagBKiUdgLmfhZIEW6Ft0FLFWNn7Hcn+7
 kckBRdQ60DYn+MJWc5pgpn0XOszflcH3EMjQL7jT++h4sBKLvUHLkAZ2m+mbD3RFVDaxq78KwNm
 2Uh5hi40HMWrbsJmBhuX48bQqN1XeVoDRAmoZ4XPsiANJ8wWMRWF2LIad6gmpXY29BA0qBcMT/G
 4l2lazV/j+0o8na1CKS2rTgRylvEY+zgWMuaqPVc+6P/8HX0AtmPO18iGxUR45v/libJcL/LxCH
 I7h1WI9Nj926/68wutM2KR3OYDabhrHTxu0DqtnHvc4W8hmYkXKojGL6/ULNfey0MlYi3Cr/sC3
 mGUrTzhnCPcqJO3Pz6PboIJ3eGqQDafw55iy4kR0KicWo9Wc5KiRiNHg8MaXqcYynkr1w804oCW
 lffp8CIGgcOtr1PJYNpeaAOwNY0vP7Z7vB+pBlktjOuzZ5TIaIaglJgDrKk2DY8uUECmQQyiHXA
 /ElLOyzmcoF72OA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Bindings expect the LED node names to follow certain pattern, see
dtbs_check warnings:

  kirkwood-ds409slim.dtb: gpio-leds-alarm-12: 'hdd1-green' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/marvell/kirkwood-blackarmor-nas220.dts     |  2 +-
 arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts    |  4 +-
 arch/arm/boot/dts/marvell/kirkwood-d2net.dts       |  2 +-
 arch/arm/boot/dts/marvell/kirkwood-dir665.dts      | 16 +++---
 arch/arm/boot/dts/marvell/kirkwood-dns320.dts      | 10 ++--
 arch/arm/boot/dts/marvell/kirkwood-dns325.dts      | 10 ++--
 arch/arm/boot/dts/marvell/kirkwood-dockstar.dts    |  4 +-
 arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts   |  6 +--
 arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts   | 20 ++++----
 .../dts/marvell/kirkwood-guruplug-server-plus.dts  |  8 +--
 arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts      |  6 +--
 arch/arm/boot/dts/marvell/kirkwood-iconnect.dts    | 14 +++---
 .../boot/dts/marvell/kirkwood-iomega_ix2_200.dts   |  8 +--
 arch/arm/boot/dts/marvell/kirkwood-l-50.dts        | 18 +++----
 arch/arm/boot/dts/marvell/kirkwood-laplug.dts      |  4 +-
 .../boot/dts/marvell/kirkwood-linksys-viper.dts    |  4 +-
 arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi       | 10 ++--
 arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts     | 12 ++---
 .../boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts  |  6 +--
 arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi |  2 +-
 arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts     |  2 +-
 arch/arm/boot/dts/marvell/kirkwood-nsa310.dts      | 20 ++++----
 arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts     | 18 +++----
 arch/arm/boot/dts/marvell/kirkwood-nsa320.dts      | 18 +++----
 arch/arm/boot/dts/marvell/kirkwood-nsa325.dts      | 18 +++----
 arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts    |  4 +-
 .../dts/marvell/kirkwood-pogoplug-series-4.dts     |  4 +-
 .../boot/dts/marvell/kirkwood-sheevaplug-esata.dts |  2 +-
 arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts  |  4 +-
 arch/arm/boot/dts/marvell/kirkwood-synology.dtsi   | 58 +++++++++++-----------
 30 files changed, 157 insertions(+), 157 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts b/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts
index f34c3897ff48..36b90c632fd6 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-blackarmor-nas220.dts
@@ -51,7 +51,7 @@ button-power {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		blue-power {
+		led-blue-power {
 			label = "nas220:blue:power";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts b/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
index 92897f8b637b..151edcd140a0 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-cloudbox.dts
@@ -69,11 +69,11 @@ key-power {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		red-fail {
+		led-red-fail {
 			label = "cloudbox:red:fail";
 			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
 		};
-		blue-sata {
+		led-blue-sata {
 			label = "cloudbox:blue:sata";
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-d2net.dts b/arch/arm/boot/dts/marvell/kirkwood-d2net.dts
index bd3b266dd766..fcce8730d3e3 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-d2net.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-d2net.dts
@@ -37,7 +37,7 @@ NS_V2_LED_ON   1 1
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		red-fail {
+		led-red-fail {
 			label = "d2net_v2:red:fail";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dir665.dts b/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
index 1d1f4cdedab2..2f6793f794cd 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-dir665.dts
@@ -137,38 +137,38 @@ ehci@50000 {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		blue-usb {
+		led-blue-usb {
 			label = "dir665:blue:usb";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
-		blue-internet {
+		led-blue-internet {
 			/* Can only be turned on if the Internet
 			 * Ethernet port has Link
 			 */
 			label = "dir665:blue:internet";
 			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 		};
-		amber-internet {
+		led-amber-internet {
 			label = "dir665:amber:internet";
 			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		};
-		blue-wifi5g {
+		led-blue-wifi5g {
 			label = "dir665:blue:5g";
 			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 		};
-		blue-status {
+		led-blue-status {
 			label = "dir665:blue:status";
 			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		};
-		blue-wps {
+		led-blue-wps {
 			label = "dir665:blue:wps";
 			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		};
-		amber-status {
+		led-amber-status {
 			label = "dir665:amber:status";
 			gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 		};
-		blue-24g {
+		led-blue-24g {
 			label = "dir665:blue:24g";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dns320.dts b/arch/arm/boot/dts/marvell/kirkwood-dns320.dts
index d6b0f418fd01..d8279e0c4c4f 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-dns320.dts
@@ -24,24 +24,24 @@ &pmx_led_red_left_hdd &pmx_led_red_right_hdd
 			     &pmx_led_white_usb>;
 		pinctrl-names = "default";
 
-		blue-power {
+		led-blue-power {
 			label = "dns320:blue:power";
 			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
-		blue-usb {
+		led-blue-usb {
 			label = "dns320:blue:usb";
 			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
-		orange-l_hdd {
+		led-orange-l_hdd {
 			label = "dns320:orange:l_hdd";
 			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
 		};
-		orange-r_hdd {
+		led-orange-r_hdd {
 			label = "dns320:orange:r_hdd";
 			gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
 		};
-		orange-usb {
+		led-orange-usb {
 			label = "dns320:orange:usb";
 			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>; /* GPIO 35 */
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dns325.dts b/arch/arm/boot/dts/marvell/kirkwood-dns325.dts
index 94d9c06cbbf5..7f396195e977 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dns325.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-dns325.dts
@@ -24,24 +24,24 @@ &pmx_led_red_left_hdd &pmx_led_red_right_hdd
 			     &pmx_led_white_usb>;
 		pinctrl-names = "default";
 
-		white-power {
+		led-white-power {
 			label = "dns325:white:power";
 			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
-		white-usb {
+		led-white-usb {
 			label = "dns325:white:usb";
 			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>; /* GPIO 43 */
 		};
-		red-l_hdd {
+		led-red-l_hdd {
 			label = "dns325:red:l_hdd";
 			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
 		};
-		red-r_hdd {
+		led-red-r_hdd {
 			label = "dns325:red:r_hdd";
 			gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
 		};
-		red-usb {
+		led-red-usb {
 			label = "dns325:red:usb";
 			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dockstar.dts b/arch/arm/boot/dts/marvell/kirkwood-dockstar.dts
index 264938dfa4d9..090f1e2e5bb6 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-dockstar.dts
@@ -42,12 +42,12 @@ gpio-leds {
 		pinctrl-0 = <&pmx_led_green &pmx_led_orange>;
 		pinctrl-names = "default";
 
-		health {
+		led-health {
 			label = "status:green:health";
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
-		fault {
+		led-fault {
 			label = "status:orange:fault";
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts b/arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts
index 328516351e84..590bee3c561c 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-dreamplug.dts
@@ -85,15 +85,15 @@ gpio-leds {
 			     &pmx_led_wifi_ap >;
 		pinctrl-names = "default";
 
-		bluetooth {
+		led-bluetooth {
 			label = "dreamplug:blue:bluetooth";
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		wifi {
+		led-wifi {
 			label = "dreamplug:green:wifi";
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
-		wifi-ap {
+		led-wifi-ap {
 			label = "dreamplug:green:wifi_ap";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts b/arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts
index d4cb3cd3e2a2..d5ac4e3974da 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-goflexnet.dts
@@ -85,44 +85,44 @@ &pmx_led_right_cap_2 &pmx_led_right_cap_3
 			    >;
 		pinctrl-names = "default";
 
-		health {
+		led-health {
 			label = "status:green:health";
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
-		fault {
+		led-fault {
 			label = "status:orange:fault";
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		left0 {
+		led-left0 {
 			label = "status:white:left0";
 			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
-		left1 {
+		led-left1 {
 			label = "status:white:left1";
 			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		};
-		left2 {
+		led-left2 {
 			label = "status:white:left2";
 			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 		};
-		left3 {
+		led-left3 {
 			label = "status:white:left3";
 			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		};
-		right0 {
+		led-right0 {
 			label = "status:white:right0";
 			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 		};
-		right1 {
+		led-right1 {
 			label = "status:white:right1";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
-		right2 {
+		led-right2 {
 			label = "status:white:right2";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
-		right3 {
+		led-right3 {
 			label = "status:white:right3";
 			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/marvell/kirkwood-guruplug-server-plus.dts
index dfb41393941d..d5aa8b505cc0 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-guruplug-server-plus.dts
@@ -59,19 +59,19 @@ gpio-leds {
 			      &pmx_led_wmode_r &pmx_led_wmode_g >;
 		pinctrl-names = "default";
 
-		health-r {
+		led-health-r {
 			label = "guruplug:red:health";
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
-		health-g {
+		led-health-g {
 			label = "guruplug:green:health";
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		wmode-r {
+		led-wmode-r {
 			label = "guruplug:red:wmode";
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
-		wmode-g {
+		led-wmode-g {
 			label = "guruplug:green:wmode";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts b/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
index 0f50eb2d5931..018c6b8f3e8a 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ib62x0.dts
@@ -79,16 +79,16 @@ gpio-leds {
 			     &pmx_led_usb_transfer>;
 		pinctrl-names = "default";
 
-		green-os {
+		led-green-os {
 			label = "ib62x0:green:os";
 			gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
 		};
-		red-os {
+		led-red-os {
 			label = "ib62x0:red:os";
 			gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>;
 		};
-		usb-copy {
+		led-usb-copy {
 			label = "ib62x0:red:usb_copy";
 			gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts b/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
index a2782fe3d379..91b46e77e0b6 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-iconnect.dts
@@ -89,32 +89,32 @@ led-level {
 			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
-		power-blue {
+		led-power-blue {
 			label = "power:blue";
 			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
 		};
-		power-red {
+		led-power-red {
 			label = "power:red";
 			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 		};
-		usb1 {
+		led-usb1 {
 			label = "usb1:blue";
 			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
 		};
-		usb2 {
+		led-usb2 {
 			label = "usb2:blue";
 			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		};
-		usb3 {
+		led-usb3 {
 			label = "usb3:blue";
 			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		};
-		usb4 {
+		led-usb4 {
 			label = "usb4:blue";
 			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		};
-		otb {
+		led-otb {
 			label = "otb:blue";
 			gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
index 91409ae949c4..039362152650 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-iomega_ix2_200.dts
@@ -127,20 +127,20 @@ gpio-leds {
 			      &pmx_led_rebuild &pmx_led_health >;
 		pinctrl-names = "default";
 
-		power_led {
+		led-power-led {
 			label = "status:white:power_led";
 			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
 		};
-		rebuild_led {
+		led-rebuild-led {
 			label = "status:white:rebuild_led";
 			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 		};
-		health_led {
+		led-health-led {
 			label = "status:red:health_led";
 			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		};
-		backup_led {
+		led-backup-led {
 			label = "status:blue:backup_led";
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-l-50.dts b/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
index 094854743dde..974bc9de4702 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
@@ -97,52 +97,52 @@ rtc@30 {
 	leds {
 		compatible = "gpio-leds";
 
-		status_green {
+		led-status-green {
 			label = "l-50:green:status";
 			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
 
-		status_red {
+		led-status-red {
 			label = "l-50:red:status";
 			gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
 		};
 
-		wifi {
+		led-wifi {
 			label = "l-50:green:wifi";
 			gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "phy0tpt";
 		};
 
-		internet_green {
+		led-internet-green {
 			label = "l-50:green:internet";
 			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
 		};
 
-		internet_red {
+		led-internet-red {
 			label = "l-50:red:internet";
 			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 		};
 
-		usb1_green {
+		led-usb1-green {
 			label = "l-50:green:usb1";
 			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "usbport";
 			trigger-sources = <&hub_port3>;
 		};
 
-		usb1_red {
+		led-usb1-red {
 			label = "l-50:red:usb1";
 			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2_green {
+		led-usb2-green {
 			label = "l-50:green:usb2";
 			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "usbport";
 			trigger-sources = <&hub_port1>;
 		};
 
-		usb2_red {
+		led-usb2-red {
 			label = "l-50:red:usb2";
 			gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-laplug.dts b/arch/arm/boot/dts/marvell/kirkwood-laplug.dts
index 8296486a5931..90ea6cdee8e0 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-laplug.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-laplug.dts
@@ -61,11 +61,11 @@ button-power {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		red-fail {
+		led-red-fail {
 			label = "laplug_v2:red:power";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
-		blue-power {
+		led-blue-power {
 			label = "laplug_v2:blue:power";
 			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts b/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
index ddefaf628501..8a1c38ab6111 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-linksys-viper.dts
@@ -54,12 +54,12 @@ gpio-leds {
 		pinctrl-0 = < &pmx_led_white_health &pmx_led_white_pulse >;
 		pinctrl-names = "default";
 
-		white-health {
+		led-white-health {
 			label = "viper:white:health";
 			gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
 		};
 
-		white-pulse {
+		led-white-pulse {
 			label = "viper:white:pulse";
 			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
index c0f80146706d..5e0b139dd4fb 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-lsxl.dtsi
@@ -137,28 +137,28 @@ &pmx_led_info &pmx_led_power
 			     &pmx_led_function_blue>;
 		pinctrl-names = "default";
 
-		func_blue {
+		led-func-blue {
 			label = "lsxl:blue:func";
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 
-		alarm {
+		led-alarm {
 			label = "lsxl:red:alarm";
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 
-		info {
+		led-info {
 			label = "lsxl:amber:info";
 			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
 
-		power {
+		led-power {
 			label = "lsxl:blue:power";
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
 
-		func_red {
+		led-func-red {
 			label = "lsxl:red:func";
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts b/arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts
index e87ea7146546..6533b49a15b2 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-mplcec4.dts
@@ -114,36 +114,36 @@ &pmx_led_user0g &pmx_led_misc
 			    >;
 		pinctrl-names = "default";
 
-		health {
+		led-health {
 			label = "status:green:health";
 			gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
 		};
 
-		user1o {
+		led-user1o {
 			label = "user1:orange";
 			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		user1g {
+		led-user1g {
 			label = "user1:green";
 			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		user0o {
+		led-user0o {
 			label = "user0:orange";
 			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		user0g {
+		led-user0g {
 			label = "user0:green";
 			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		misc {
+		led-misc {
 			label = "status:orange:misc";
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
index fd3813ace0c1..e3b41784c876 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-mv88f6281gtw-ge.dts
@@ -73,17 +73,17 @@ gpio-leds {
 		pinctrl-0 = <&pmx_leds &pmx_usb_led>;
 		pinctrl-names = "default";
 
-		green-status {
+		led-green-status {
 			label = "gtw:green:Status";
 			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
 		};
 
-		red-status {
+		led-red-status {
 			label = "gtw:red:Status";
 			gpios = <&gpio0 21 GPIO_ACTIVE_HIGH>;
 		};
 
-		green-usb {
+		led-green-usb {
 			label = "gtw:green:USB";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
index 28f09f71b24d..d6b615cf6390 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-ns2-common.dtsi
@@ -66,7 +66,7 @@ button-power {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		red-fail {
+		led-red-fail {
 			label = "ns2:red:fail";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts b/arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts
index b0cb5907ed63..686bcd6f0f3c 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-ns2lite.dts
@@ -24,7 +24,7 @@ sata@80000 {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		blue-sata {
+		led-blue-sata {
 			label = "ns2:blue:sata";
 			gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "disk-activity";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-nsa310.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa310.dts
index c1799a07816e..3555ac1c3b15 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-nsa310.dts
@@ -87,43 +87,43 @@ &pmx_led_copy_green &pmx_led_copy_red
 			     &pmx_led_hdd_green &pmx_led_hdd_red>;
 		pinctrl-names = "default";
 
-		green-sys {
+		led-green-sys {
 			label = "nsa310:green:sys";
 			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 		};
-		red-sys {
+		led-red-sys {
 			label = "nsa310:red:sys";
 			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
-		green-hdd {
+		led-green-hdd {
 			label = "nsa310:green:hdd";
 			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
-		red-hdd {
+		led-red-hdd {
 			label = "nsa310:red:hdd";
 			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
-		green-esata {
+		led-green-esata {
 			label = "nsa310:green:esata";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
-		red-esata {
+		led-red-esata {
 			label = "nsa310:red:esata";
 			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
 		};
-		green-usb {
+		led-green-usb {
 			label = "nsa310:green:usb";
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
-		red-usb {
+		led-red-usb {
 			label = "nsa310:red:usb";
 			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
 		};
-		green-copy {
+		led-green-copy {
 			label = "nsa310:green:copy";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
-		red-copy {
+		led-red-copy {
 			label = "nsa310:red:copy";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts
index b85e314f045a..ddf84092aade 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-nsa310a.dts
@@ -75,39 +75,39 @@ lm85: lm85@2e {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		green-sys {
+		led-green-sys {
 			label = "nsa310:green:sys";
 			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 		};
-		red-sys {
+		led-red-sys {
 			label = "nsa310:red:sys";
 			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
-		green-hdd {
+		led-green-hdd {
 			label = "nsa310:green:hdd";
 			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
-		red-hdd {
+		led-red-hdd {
 			label = "nsa310:red:hdd";
 			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
-		green-esata {
+		led-green-esata {
 			label = "nsa310:green:esata";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
-		red-esata {
+		led-red-esata {
 			label = "nsa310:red:esata";
 			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
 		};
-		green-usb {
+		led-green-usb {
 			label = "nsa310:green:usb";
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
-		green-copy {
+		led-green-copy {
 			label = "nsa310:green:copy";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
-		red-copy {
+		led-red-copy {
 			label = "nsa310:red:copy";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-nsa320.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa320.dts
index 652405e65006..dd5c8ffc8781 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-nsa320.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-nsa320.dts
@@ -142,39 +142,39 @@ &pmx_led_copy_green &pmx_led_copy_red
 			     &pmx_led_hdd1_green &pmx_led_hdd1_red>;
 		pinctrl-names = "default";
 
-		green-sys {
+		led-green-sys {
 			label = "nsa320:green:sys";
 			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 		};
-		orange-sys {
+		led-orange-sys {
 			label = "nsa320:orange:sys";
 			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
-		green-hdd1 {
+		led-green-hdd1 {
 			label = "nsa320:green:hdd1";
 			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
-		red-hdd1 {
+		led-red-hdd1 {
 			label = "nsa320:red:hdd1";
 			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
-		green-hdd2 {
+		led-green-hdd2 {
 			label = "nsa320:green:hdd2";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
-		red-hdd2 {
+		led-red-hdd2 {
 			label = "nsa320:red:hdd2";
 			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
 		};
-		green-usb {
+		led-green-usb {
 			label = "nsa320:green:usb";
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
-		green-copy {
+		led-green-copy {
 			label = "nsa320:green:copy";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
-		red-copy {
+		led-red-copy {
 			label = "nsa320:red:copy";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-nsa325.dts b/arch/arm/boot/dts/marvell/kirkwood-nsa325.dts
index 371456de34b2..f0786a5f2ce6 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-nsa325.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-nsa325.dts
@@ -162,39 +162,39 @@ &pmx_led_copy_green &pmx_led_copy_red
 			     &pmx_led_hdd1_green &pmx_led_hdd1_red>;
 		pinctrl-names = "default";
 
-		green-sys {
+		led-green-sys {
 			label = "nsa325:green:sys";
 			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
 		};
-		orange-sys {
+		led-orange-sys {
 			label = "nsa325:orange:sys";
 			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
 		};
-		green-hdd1 {
+		led-green-hdd1 {
 			label = "nsa325:green:hdd1";
 			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		};
-		red-hdd1 {
+		led-red-hdd1 {
 			label = "nsa325:red:hdd1";
 			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
 		};
-		green-hdd2 {
+		led-green-hdd2 {
 			label = "nsa325:green:hdd2";
 			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
 		};
-		red-hdd2 {
+		led-red-hdd2 {
 			label = "nsa325:red:hdd2";
 			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
 		};
-		green-usb {
+		led-green-usb {
 			label = "nsa325:green:usb";
 			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
 		};
-		green-copy {
+		led-green-copy {
 			label = "nsa325:green:copy";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
-		red-copy {
+		led-red-copy {
 			label = "nsa325:red:copy";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts b/arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts
index f9e95e55f36d..39a5345332da 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-pogo_e02.dts
@@ -33,12 +33,12 @@ chosen {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		health {
+		led-health {
 			label = "pogo_e02:green:health";
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
-		fault {
+		led-fault {
 			label = "pogo_e02:orange:fault";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
index b66fc4d57410..0e9c4cf79822 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-pogoplug-series-4.dts
@@ -46,12 +46,12 @@ gpio-leds {
 		pinctrl-0 = <&pmx_led_green &pmx_led_red>;
 		pinctrl-names = "default";
 
-		health {
+		led-health {
 			label = "pogoplugv4:green:health";
 			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
-		fault {
+		led-fault {
 			label = "pogoplugv4:red:fault";
 			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-sheevaplug-esata.dts b/arch/arm/boot/dts/marvell/kirkwood-sheevaplug-esata.dts
index ae8f493c9a0f..eb185273376e 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-sheevaplug-esata.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-sheevaplug-esata.dts
@@ -33,7 +33,7 @@ gpio-leds {
 		pinctrl-0 = <&pmx_led_blue>;
 		pinctrl-names = "default";
 
-		health {
+		led-health {
 			label = "sheevaplug:blue:health";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts
index c73cc904e5c4..ce73fcf2255f 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-sheevaplug.dts
@@ -28,13 +28,13 @@ gpio-leds {
 		pinctrl-0 = <&pmx_led_blue &pmx_led_red>;
 		pinctrl-names = "default";
 
-		health {
+		led-health {
 			label = "sheevaplug:blue:health";
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
 
-		misc {
+		led-misc {
 			label = "sheevaplug:red:misc";
 			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi b/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
index 20964eb48fd7..6b7c5218b1fb 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/marvell/kirkwood-synology.dtsi
@@ -410,7 +410,7 @@ gpio-leds-alarm-12 {
 		pinctrl-0 = <&pmx_alarmled_12>;
 		pinctrl-names = "default";
 
-		hdd1-green {
+		led-hdd1-green {
 			label = "synology:alarm";
 			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
 		};
@@ -424,42 +424,42 @@ &pmx_hddled_23 &pmx_hddled_24 &pmx_hddled_25
 			     &pmx_hddled_26 &pmx_hddled_27>;
 		pinctrl-names = "default";
 
-		hdd1-green {
+		led-hdd1-green {
 			label = "synology:green:hdd1";
 			gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd1-amber {
+		led-hdd1-amber {
 			label = "synology:amber:hdd1";
 			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd2-green {
+		led-hdd2-green {
 			label = "synology:green:hdd2";
 			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd2-amber {
+		led-hdd2-amber {
 			label = "synology:amber:hdd2";
 			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd3-green {
+		led-hdd3-green {
 			label = "synology:green:hdd3";
 			gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd3-amber {
+		led-hdd3-amber {
 			label = "synology:amber:hdd3";
 			gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd4-green {
+		led-hdd4-green {
 			label = "synology:green:hdd4";
 			gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd4-amber {
+		led-hdd4-amber {
 			label = "synology:amber:hdd4";
 			gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
 		};
@@ -471,12 +471,12 @@ gpio-leds-hdd-21-1 {
 		pinctrl-0 = <&pmx_hddled_21 &pmx_hddled_23>;
 		pinctrl-names = "default";
 
-		hdd1-green {
+		led-hdd1-green {
 			label = "synology:green:hdd1";
 			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd1-amber {
+		led-hdd1-amber {
 			label = "synology:amber:hdd1";
 			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
 		};
@@ -488,22 +488,22 @@ gpio-leds-hdd-21-2 {
 		pinctrl-0 = <&pmx_hddled_21 &pmx_hddled_23 &pmx_hddled_20 &pmx_hddled_22>;
 		pinctrl-names = "default";
 
-		hdd1-green {
+		led-hdd1-green {
 			label = "synology:green:hdd1";
 			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd1-amber {
+		led-hdd1-amber {
 			label = "synology:amber:hdd1";
 			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd2-green {
+		led-hdd2-green {
 			label = "synology:green:hdd2";
 			gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd2-amber {
+		led-hdd2-amber {
 			label = "synology:amber:hdd2";
 			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
 		};
@@ -518,52 +518,52 @@ &pmx_hddled_42 &pmx_hddled_43 &pmx_hddled_44
 			     &pmx_hddled_45>;
 		pinctrl-names = "default";
 
-		hdd1-green {
+		led-hdd1-green {
 			label = "synology:green:hdd1";
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd1-amber {
+		led-hdd1-amber {
 			label = "synology:amber:hdd1";
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd2-green {
+		led-hdd2-green {
 			label = "synology:green:hdd2";
 			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd2-amber {
+		led-hdd2-amber {
 			label = "synology:amber:hdd2";
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd3-green {
+		led-hdd3-green {
 			label = "synology:green:hdd3";
 			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd3-amber {
+		led-hdd3-amber {
 			label = "synology:amber:hdd3";
 			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd4-green {
+		led-hdd4-green {
 			label = "synology:green:hdd4";
 			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd4-amber {
+		led-hdd4-amber {
 			label = "synology:amber:hdd4";
 			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd5-green {
+		led-hdd5-green {
 			label = "synology:green:hdd5";
 			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd5-amber {
+		led-hdd5-amber {
 			label = "synology:amber:hdd5";
 			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 		};
@@ -575,22 +575,22 @@ gpio-leds-hdd-38 {
 		pinctrl-0 = <&pmx_hddled_38 &pmx_hddled_39 &pmx_hddled_36 &pmx_hddled_37>;
 		pinctrl-names = "default";
 
-		hdd1-green {
+		led-hdd1-green {
 			label = "synology:green:hdd1";
 			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd1-amber {
+		led-hdd1-amber {
 			label = "synology:amber:hdd1";
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd2-green {
+		led-hdd2-green {
 			label = "synology:green:hdd2";
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 
-		hdd2-amber {
+		led-hdd2-amber {
 			label = "synology:amber:hdd2";
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};

-- 
2.43.0


