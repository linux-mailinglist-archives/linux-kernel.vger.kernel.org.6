Return-Path: <linux-kernel+bounces-304549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D419621A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55C7284385
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E015AADE;
	Wed, 28 Aug 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA28siPs"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED43157A67;
	Wed, 28 Aug 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831282; cv=none; b=MstwrVXM6X41r9rYupRd7Z+q75T8aNhluuAlQq31VAcMVTjBMw6G6Pd/qT5B9yKySxv+iW+7DiEMP4s0O1SX61UTxcJzxTu72a3i/HVeTdGPWzcbWmQLhAk5eWZIC3yZpXBzAU7sJyFzpatPL4sjPU1/Dkz1v0jczmGHVsQzn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831282; c=relaxed/simple;
	bh=PySVlahkFHYtglZZ/v7pwWnhVdnK6CdMyrLZQviO5bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVNfFxJTTLdB3Pl6J0Llh4e3FjEnt7hQiG1l3mmGfouwTH+AjSYJX5BnmmwroU9+WOFCruYCdol0fnETV2Ra/7xWlq8V2Ae1KugnQ24AuMC9NWKmJ+VLpFIv4nI54iRa1c1aGTQwlyBujzPX5Bam8FtwiXlK2QNPaEE4Kk16O5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA28siPs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20227ba378eso58083815ad.0;
        Wed, 28 Aug 2024 00:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724831280; x=1725436080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OBjUgc9cFXkg83mO7IC2sZvH5LHYp7bAGQMEXhE0sI=;
        b=BA28siPsjduBI03zjI+a9rBWvEzIFMxeDWkLQnH6VpuNqqtx0o3gm8SsdVhtvOO5OH
         iqRjS73eGfRMK2MEps0JTWGHlw1LzYIMxYrOtv95Js+0f+u8sBtt5Bsza53BG6GurWOc
         mjzVjcyMJeuh8JjrIzc3ZtwAVAmS1gB7OMSIaupc68YrE3EOs5owraFd/ji24mynq7Jh
         ONqv43/5HAxk8CfuQQpNs3jrpxkq5WscCplzZDiv3M8MytwLeonyXMaklUoLmiS/hT0r
         nbyFQkMZFjz1g8IhVaD5qN23GGdXGqTYlaywtVRUAQWXkQ+fzHSnHC53V0iU6JQlb2Dp
         MD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831280; x=1725436080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OBjUgc9cFXkg83mO7IC2sZvH5LHYp7bAGQMEXhE0sI=;
        b=IwcgZuMX28JQgluzFg+G2j2xNEZ+g/W78d8o+XaM0IcZBKHAILhXU9Gc+5aYjSUgg4
         bUU0JN2/wWd6Z7i29D73T7VDEkEZnMbvGxtmHAQCIMoKHs24gemNMHRdsGGIldU4iCvH
         7WvjBU5drB/5dnhTzElhqkMKpIzeVn1ImVSbJkQ6d8dGrdWuKthGvy2BcSsLBC43MHTk
         0atRIUSo/O9CD6QajnaeXWh9yRj436FuqXfhgHT02nTTEtjnpb3R1KMiNVlkkmfJHsaJ
         sdZxxdt+dCV/j0mPcIsWCn3Xe46YC+qx0MyXclhqlwDzb4Jh4u1s74RI5GviAgRKalRZ
         MiXg==
X-Forwarded-Encrypted: i=1; AJvYcCUvR25GLGyiBm+iV3hx9XjprC0FJmauxNy2+eG4ppbU00f4bKXG9giSjPmMRfQCMbWszF55FNQ81vIg@vger.kernel.org, AJvYcCWs4hQ6BHkphX4+3TTW6qNzR+1zVy6B6pZAIu3fpPfq+wsCGngsuZX72bpZmBhRWhrIldUUD41PCsP72lGn@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsBtUO8cGne6fcW8IyUhbtEz3NAY9IBDPziC+pXhOK3AuIvnd
	DbimEN68eoIRrNKRbNaO7D0UIXavKYzOMWmbVP4NhsXRbWW/G8ae7a7lk/lF
X-Google-Smtp-Source: AGHT+IH4XeViWXkMvG8J+jECU/21Cp/grJ7rcyxe62j91h8/4LmdvTzWeJPBzN3n0Nxnqnd+vHgcvw==
X-Received: by 2002:a17:902:fac3:b0:201:e65b:500b with SMTP id d9443c01a7336-2039e534282mr140849695ad.63.1724831280169;
        Wed, 28 Aug 2024 00:48:00 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f59bsm94081575ad.97.2024.08.28.00.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:47:59 -0700 (PDT)
From: Jonathan Liu <net147@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
	Jonathan Liu <net147@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Enable RK809 audio codec for Radxa ROCK 4C+
Date: Wed, 28 Aug 2024 17:47:53 +1000
Message-ID: <20240828074755.1320692-1-net147@gmail.com>
X-Mailer: git-send-email 2.46.0
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
index d4b4dced3e39..14453b286446 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
@@ -52,6 +52,21 @@ led-1 {
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
@@ -200,10 +215,13 @@ rk809: pmic@20 {
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
@@ -445,6 +463,10 @@ &i2c3 {
 	status = "okay";
 };
 
+&i2s0 {
+	status = "okay";
+};
+
 &i2s2 {
 	status = "okay";
 };
@@ -472,6 +494,28 @@ bt_wake_l: bt-wake-l {
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
2.46.0


