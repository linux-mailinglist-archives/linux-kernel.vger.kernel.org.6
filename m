Return-Path: <linux-kernel+bounces-218143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4490B9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ECF1F23D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B224198A03;
	Mon, 17 Jun 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr8jYaFi"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA04199E87;
	Mon, 17 Jun 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648997; cv=none; b=ayCc+7cerUH/Qh52+/zb2iW8DFR3KdC0wLr3xs+yYocm3FYps05Pu3sBYYiUtXTu18nGfy2sQD5aZmUQ75tvfRgQSPLJlqb34F1Ir7Ie6Ta2RMQjq/UGkflx/7uixXtGbWJgUxZQnziPDLNe+lBfij+uqAwkqj547otdcF2mQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648997; c=relaxed/simple;
	bh=cu+UhDK5oOLgPtUwnbvA8VAbLQ3CEl/qKKmthR966F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSaZOUnXjBDCfpbmP4SN1uFPRAvn6+rvU0A6NfqkPywx9lJF44VUbXs0/BtptQcA/ykaR3YL4tPUyeYX/6xttlO0hp63j1u5AHdEPa1I8A8MRFCMKV2deLDSZRo1/SdFD5pMC9Z15xuWlo/KcfQhqBYWbKbhRPfCmcKDivPS/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr8jYaFi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6269885572so972137766b.1;
        Mon, 17 Jun 2024 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648994; x=1719253794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi6aVHL3QaHHJ3tI7hDY8xFdrO8LAbtMSLI9IrukgKs=;
        b=Lr8jYaFiRZfQnTnZ+i8yg2IYMGPw7Bf8e9s1qUwC2HyVF7A7DjIgx9ZRR4ynJ68Fq1
         cxyGuGUEN8tKoJK3grwRwLo2vqvRf+hM/ntVb14nYyewbaVwiCSbQwhoigxXm51I6Ick
         dGN+kndJB2YnOglg1nyXsmgicWKszEwRKvy7I3BtjdAezsz5YzW7kX4reZ0ZvT06JRk2
         cU/Fg4MF+iW2RLxt9sMbI0rZ4P2UH95JkplBx92E1s+HwWklrE9bYvU1i0/boRok/oN9
         YT5Di3W6xFrGx9arp7ReJBeZ+0vvCHFyQU4sbghCrCDy1Y8V+UYrFWXFkeCp/PYEMiXS
         gsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648994; x=1719253794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi6aVHL3QaHHJ3tI7hDY8xFdrO8LAbtMSLI9IrukgKs=;
        b=OqqTnxceTlR61C9+BJ00akquOBs94lQDQ4XRaih+Z5LZhN7AiFaVDjZLG/A5Ke5Abv
         v8Y3hkGuiLbVYFrUrfRDKqwg4+S32ToQ4ar2bQEvBgLU58+v8pBLxaqWTMSukJ07IJWq
         oY6JfIh4HGmcuJK42bHDFBxv3rjs/UueKXJiHJAt2DYSLMmyHx99HRFOt0LZz5pcj3Y0
         /jDJ6oD20a6UTCW2k4SboBrllLUltaYQZruWWT3R1Kg1IqTyFsCnSJ5l2YDVhNyQwsfx
         KI1AwV6cebuJnjVCqJXzoV2XTf458lwA5v6wXDkTUXSM0PPHsg2L4XVlqz8ln1Njl6jt
         sMEA==
X-Forwarded-Encrypted: i=1; AJvYcCUWxwtvat83AwMJKepTPcfH3xpu7lxWTaB0uJe9Nub8phFaIle8ZDxKF2rLqWlotYrqxa/895tcARvtfeRh7Id6z7Dm8420vDXjgjKmPdnCtmZ2FzKCMcQNWWNRKpFzwvLo1cnPPU8fCA==
X-Gm-Message-State: AOJu0Yxwgwh4OnyPf8yCDo73EnE0B+/EwjEzaN+hGxnAToucV3Zzwpu6
	mK3DaW1jsCu9c4vM5+oj+R4byEolcplmc+3vCAqvjuNg/0b25brafyhIvtcuqlPA+g==
X-Google-Smtp-Source: AGHT+IFSSaODbqGau5beLtfxdks8DVDSeWiXWQ1UwtzXba87HIcD1jrRNMLASa7svvdJxgKgZlzToQ==
X-Received: by 2002:a17:906:1d0f:b0:a6f:1e1b:f9ea with SMTP id a640c23a62f3a-a6f95054920mr23742566b.31.1718648994301;
        Mon, 17 Jun 2024 11:29:54 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:53 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 22:28:58 +0400
Subject: [PATCH v5 8/8] arm64: dts: rockchip: Split GPU OPPs of RK3588 and
 RK3588j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk-dts-additions-v5-8-c1f5f3267f1e@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
In-Reply-To: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=5293;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=cu+UhDK5oOLgPtUwnbvA8VAbLQ3CEl/qKKmthR966F0=;
 b=Iq78YcGu6PRbj8M7jUOSV+GJvF6MJXQR89ZqGUZvfYky+6DBrijA5RY/wW0J84sIVnfWYtxCZ
 //IhTsdQgWkBA3n9buJjiMSdZhSv/EG5BXyaHQOAdqrE8yf/6UsUwqT
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

RK3588j uses a different set of OPPs for its GPU, both in terms of
allowed frequencies and in terms of voltages.

Move the GPU OPPs table into per-variant .dtsi files to accommodate
for this difference.

The table for RK3588j is adapted from Rockchip downstream sources [1],
while RK3588 one is moved verbatim into the per-variant .dtsi file.
The values provided for RK3588 in the downstream sources match those
in the original commit.

[1] https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi

Fixes: 6fca4edb93d3 ("arm64: dts: rockchip: Add rk3588 GPU node")
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 38 -------------------------
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi  | 41 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi     | 33 +++++++++++++++++++++
 3 files changed, 74 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 758aff5e040b..3d918874aa02 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -451,46 +451,8 @@ gpu: gpu@fb000000 {
 			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "job", "mmu", "gpu";
-		operating-points-v2 = <&gpu_opp_table>;
 		power-domains = <&power RK3588_PD_GPU>;
 		status = "disabled";
-
-		gpu_opp_table: opp-table {
-			compatible = "operating-points-v2";
-
-			opp-300000000 {
-				opp-hz = /bits/ 64 <300000000>;
-				opp-microvolt = <675000 675000 850000>;
-			};
-			opp-400000000 {
-				opp-hz = /bits/ 64 <400000000>;
-				opp-microvolt = <675000 675000 850000>;
-			};
-			opp-500000000 {
-				opp-hz = /bits/ 64 <500000000>;
-				opp-microvolt = <675000 675000 850000>;
-			};
-			opp-600000000 {
-				opp-hz = /bits/ 64 <600000000>;
-				opp-microvolt = <675000 675000 850000>;
-			};
-			opp-700000000 {
-				opp-hz = /bits/ 64 <700000000>;
-				opp-microvolt = <700000 700000 850000>;
-			};
-			opp-800000000 {
-				opp-hz = /bits/ 64 <800000000>;
-				opp-microvolt = <750000 750000 850000>;
-			};
-			opp-900000000 {
-				opp-hz = /bits/ 64 <900000000>;
-				opp-microvolt = <800000 800000 850000>;
-			};
-			opp-1000000000 {
-				opp-hz = /bits/ 64 <1000000000>;
-				opp-microvolt = <850000 850000 850000>;
-			};
-		};
 	};
 
 	usb_host0_xhci: usb@fc000000 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
index 35bbc3c2134f..0f1a77697351 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
@@ -114,6 +114,43 @@ opp-2400000000 {
 			clock-latency-ns = <40000>;
 		};
 	};
+
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <675000 675000 850000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <675000 675000 850000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <675000 675000 850000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <675000 675000 850000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <750000 750000 850000>;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <800000 800000 850000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <850000 850000 850000>;
+		};
+	};
 };
 
 &cpu_b0 {
@@ -147,3 +184,7 @@ &cpu_l2 {
 &cpu_l3 {
 	operating-points-v2 = <&cluster0_opp_table>;
 };
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
index b7e69553857b..bce72bac4503 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
@@ -80,6 +80,35 @@ opp-2016000000 {
 			clock-latency-ns = <40000>;
 		};
 	};
+
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <750000 750000 850000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <750000 750000 850000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <750000 750000 850000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <750000 750000 850000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <750000 750000 850000>;
+		};
+		opp-850000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <787500 787500 850000>;
+		};
+	};
 };
 
 &cpu_b0 {
@@ -113,3 +142,7 @@ &cpu_l2 {
 &cpu_l3 {
 	operating-points-v2 = <&cluster0_opp_table>;
 };
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};

-- 
2.45.2


