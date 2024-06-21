Return-Path: <linux-kernel+bounces-224745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0C4912661
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BE91F2516F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDFD154C17;
	Fri, 21 Jun 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOlczclO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4715218A;
	Fri, 21 Jun 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975376; cv=none; b=n4luH53q9f4y9zOkhN/M70nkWj0XM2TmspkD1KrvT5yu2ohPnd4MJT2/ph9L89wJZTCHxYT0Dw/7Aw25WZY9b3osfP9TaLvpg/7bNJ4/v1Z3vglGeBKsw5n4qzlceWHmj1bL3g4AdwB+YUHpIGEfWbBp9P18NroRDEOLWKrq60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975376; c=relaxed/simple;
	bh=2GQcfwCebqSZNUzOCii6L6o/niaGvDwp9ykm3pssOME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3eCmCypMeISbWpOeF4hgSqSo8v0kwTWaWylrwL8CmZHieIFbhe2juJZ1hzBaBcHfNvu1uxW7l1hXpZf5lhAAl8n8r3Z0XydA6D/JZLSKU8H7ERUufK2Ba/mHz6zsZ7CL6rpYvtK+klzw3PGk7WjrY1JvEII8J8DjZwMruxv2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOlczclO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7046211e455so1382323b3a.3;
        Fri, 21 Jun 2024 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718975375; x=1719580175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSRyH1ekCqW+EOMwB2OxYp1hmPOFI4J/Sw1gHh2C4Kk=;
        b=KOlczclOex43cZNsu8vxx2/6ZPLHuzgO8+RSiGRlleMfBGDuOdJYYpU/k55ET5Y0Tg
         rj9qlPlDGBumBmxz20XIakKYmkVgeI99nhNlpwxIIHFC0hJm+JjZ3d2lET10oDl3iiwn
         a4Y6ncHcwQFgNZlJaRzSOwo/+Uto2y5dBIFJplycO/T/OmVRHcX93Qp3TbXm1kDrvfo2
         vpJigNYYKHpuhwZCWfGZLtyYTW+41qwhu4ZgzssE/iI8FzZsZ68ChgCXC3WtP4gBnKe+
         bA4Eg6vF7b4j6FdQhf4+mmwHIXsOO0n5gmZTM6Kebx+t3onXI71WpdTr6O3y1SMWwaAs
         p8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718975375; x=1719580175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSRyH1ekCqW+EOMwB2OxYp1hmPOFI4J/Sw1gHh2C4Kk=;
        b=lKJZD8PuL3WGYYxiuA15SfrSDVJblmljHNjXFqklNetfe13bypIiv8lSzq2eobZ4n1
         sP7CIDjQ9Z/o5stGE0lzipOq6pFN5h1bRWs2PK0JQtwrmt4+eFQ17wTS8OYERIlMdqM2
         fsRLE4fUlNNMmrHFeW+asjRRtRe2/D999bBAKFRi17ZWRlPP4rMBgKbWudPdfB4t4ewJ
         xjlFfQqjaQzb165fx8FJ4Y1qXKYE6mPW3GNvDUHuOSqmh15AMhnFXDrfsxis4aab8mb2
         x/stPcklL4tw2pRZShR0gzQeWhNU9M7xjGRvloMGW2Ui2PTSa666AJiyc6ixpW2lxR1y
         2OLw==
X-Forwarded-Encrypted: i=1; AJvYcCWbJwe4JasTT3iQ8ZsZsM79i1cpE5tflwKBwhXfW+/n3wINdh5z8+0ciRqefXTK+cq6ueH70G9UMLgEJKOeoKO+Fwg42nnHdaTV43csLDx9ZusALGazvjU8bkQxIiWKIyJYDBhY6yd9Aw==
X-Gm-Message-State: AOJu0YymY3JbeIrvw7Ek4RinUIDEs33tuH+jnZTA5JDE10f3cy7Ltd4t
	bxMuKUNLLttzJSq2iv38J1WxIsAas9jLhMNATwutZI9rTuaf9RjW
X-Google-Smtp-Source: AGHT+IGLYWf8Lnm8V+aScxyqtWskuRogAGHiKVVoYmczB8UGJ+V6wEFazjIXslXnU7KGCIsbqFvOkw==
X-Received: by 2002:a05:6a20:12d4:b0:1b4:c499:788d with SMTP id adf61e73a8af0-1bcbb422be8mr9766233637.15.1718975374526;
        Fri, 21 Jun 2024 06:09:34 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716baf4bedbsm1104611a12.76.2024.06.21.06.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:09:33 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Jonathan Liu <net147@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK 4C+
Date: Fri, 21 Jun 2024 23:09:03 +1000
Message-ID: <20240621130903.2572986-1-net147@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the necessary device tree changes to enable analog audio
output for the 3.5 mm TRS headphone jack on the Radxa ROCK 4C+ with
its RK809 audio codec.

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 .../boot/dts/rockchip/rk3399-rock-4c-plus.dts | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
index 972aea843afd..aafcce0f01e9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
@@ -53,6 +53,21 @@ led-1 {
 		};
 	};
 
+	rk809-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK809";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rk809 1>;
@@ -201,10 +216,13 @@ rk809: pmic@20 {
 		interrupt-parent = <&gpio1>;
 		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <1>;
+		clock-names = "mclk";
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
 		clock-output-names = "rk808-clkout1", "rk808-clkout2";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int_l>;
+		pinctrl-0 = <&pmic_int_l>, <&i2s_8ch_mclk>;
 		rockchip,system-power-controller;
+		#sound-dai-cells = <0>;
 		wakeup-source;
 
 		vcc1-supply = <&vcc5v0_sys>;
@@ -446,6 +464,10 @@ &i2c3 {
 	status = "okay";
 };
 
+&i2s0 {
+	status = "okay";
+};
+
 &i2s2 {
 	status = "okay";
 };
@@ -473,6 +495,28 @@ bt_wake_l: bt-wake-l {
 		};
 	};
 
+	i2s0 {
+		i2s0_8ch_bus: i2s0-8ch-bus {
+			rockchip,pins =
+				<3 RK_PD0 1 &pcfg_pull_none>,
+				<3 RK_PD2 1 &pcfg_pull_none>,
+				<3 RK_PD3 1 &pcfg_pull_none>,
+				<3 RK_PD7 1 &pcfg_pull_none>;
+		};
+
+		i2s0_8ch_bus_bclk_off: i2s0-8ch-bus-bclk-off {
+			rockchip,pins =
+				<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+				<3 RK_PD2 1 &pcfg_pull_none>,
+				<3 RK_PD3 1 &pcfg_pull_none>,
+				<3 RK_PD7 1 &pcfg_pull_none>;
+		};
+
+		i2s_8ch_mclk: i2s-8ch-mclk {
+			rockchip,pins = <4 RK_PA0 1 &pcfg_pull_none>;
+		};
+	};
+
 	leds {
 		user_led1: user-led1 {
 			rockchip,pins = <3 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.45.2


