Return-Path: <linux-kernel+bounces-291414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC592956242
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02041C2151A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76C1156991;
	Mon, 19 Aug 2024 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrUIkMPx"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D014A4DD;
	Mon, 19 Aug 2024 03:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039821; cv=none; b=tDKq3iisiXtuq84baNAlngcyvwNd7AbQL+L2TPYuP3mvXiBkUHT5+JTKt0INLCWDMhE9YYrmk02zOBELGHOE3lOZVoGq68oQtLP4lTpWsxnXSIVMjyL3lMov7zlR85YXiYGYvdXS8oxFzrM3OA2bcjO5hRitCH9Rs4K03jZuF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039821; c=relaxed/simple;
	bh=jwgD85nNHSFaNBZXixYkcZ+4S/lmIbA0NdwhpIoV4Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAzuPpVxZxMzplhPX8cL4DAOF0eDp6W2D6br8BY5DrHcADQyN9FJQAGlis2ylgFrEvNsd3wpw/1p+1Sv1s3jBD7AnHGyioEaH1TEhSzc3qOXvNrFIXtmWChwppUViXahGJ2I4cShmXXzZ8ugAS+uQnQY2Tqh0aybtk3tbC/OmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrUIkMPx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fec34f94abso32284535ad.2;
        Sun, 18 Aug 2024 20:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724039819; x=1724644619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMxiBVm1dCy/VMbf3k3ryTxM8vkKELICEPudxbPC0sY=;
        b=DrUIkMPxX9JKpkx+ySChwFO5RevGo5eQ4Zhcixq2AEkchivAp/XOPdJmRv9u4hAtA7
         2NWUNleA8Jnnls1qozii1Fwq6vpSmHNTijyok9Q4o3juuv86R8jCPbIke68qZXaLDf54
         ux3WX0xg21Wr8608ep8GXGK+kNX+7x0UhrYbW9xpB2Ur8OHnrxgSW4nBrxMrb8aJdwN7
         vR4wJa0q1GPYEdWAqytunXmaXduSrTp5tp3YjHm0g4CqX1OnQmioC24Z3nf4mWHZQz8J
         +eKxZoPyoeUfORczViTAUdA4vTaRKElFQc2c/LXhR9HmkZJ0UslnXOEpSS5aFF5m3nQ5
         HbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039819; x=1724644619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMxiBVm1dCy/VMbf3k3ryTxM8vkKELICEPudxbPC0sY=;
        b=VCdDGRwbWDvlFoxt07ihMsdQLWQt7bUKJ9GoQUXVGP113nHWjc7GLEBogTM8g4uYkf
         X+8v0UVNS3GYgvGt3RVQitgBLYfW5BZpgiJG2SGQo5fdylf3ydsGTsKVr9bb0SfAQDt1
         hCWEIivQCnOoWdQfxjZPoOHRGWE1hqAZs3wsO++KlWhKF+XRHewUB+CQrob9TOnHkRw4
         41HSnUVrrH2ca/lCdwXb5DFzq2aEpJv0f27XEdEHgpVoMxQlqaQYNHyVK3dgAYbYERsY
         crtm12r53A0ZBhZxy37e6o8dq+XUhnxWEP4LOFigUsqvMr/xlaOSAJdITAOsPEmEIcwr
         g5ag==
X-Forwarded-Encrypted: i=1; AJvYcCVK8l6A22huVXHRexIrNEbRzvYWbVQ/gNL4aDhs0NM9KfjeGbD/B2eqUc6/kr5KqebnT117NGgJ6FJp+mmGW4GfQjJXtlw/zSRPxRW8hKIk/1R+iSGjPe8SmnC+s8SkEG4oXkzR5KVfyg==
X-Gm-Message-State: AOJu0YzumbEo2INSSapB6+IDfwsel//H16RUpn3KjF994X51K/bIUXGj
	YpHzKIbRW6RX3nlb1fwPhgdTQclg9gQVdah7Qu5GE8OcsoimZXMO
X-Google-Smtp-Source: AGHT+IEtQA3Sp2nVh0hsGcQt+DqddhpLy0t+34/lJMSE8+lE689mWVXGMwN6DWTsoCCP0VOnd/l4lw==
X-Received: by 2002:a17:902:db07:b0:202:4724:b700 with SMTP id d9443c01a7336-2024724b8d6mr16176115ad.58.1724039818753;
        Sun, 18 Aug 2024 20:56:58 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375649sm55784435ad.124.2024.08.18.20.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 20:56:58 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	soc@kernel.org,
	schung@nuvoton.com,
	ychuang3@nuvoton.com
Subject: [PATCH 3/3] arm64: dts: nuvoton: ma35d1: Add uart pinctrl settings
Date: Mon, 19 Aug 2024 03:56:47 +0000
Message-Id: <20240819035647.306-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819035647.306-1-ychuang570808@gmail.com>
References: <20240819035647.306-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Enable all UART nodes presented on som and iot boards, and add pinctrl
function settings to these nodes.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 80 +++++++++++++++++-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 83 ++++++++++++++++++-
 2 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index b89e2be6abae..9482bec1aa57 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -14,6 +14,10 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		serial10 = &uart10;
+		serial12 = &uart12;
+		serial13 = &uart13;
+		serial14 = &uart14;
 	};
 
 	chosen {
@@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &clk {
 	assigned-clocks = <&clk CAPLL>,
 			  <&clk DDRPLL>,
@@ -54,3 +54,75 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart-grp {
+		pinctrl_uart0: uart0-pins {
+			nuvoton,pins = <4 14 1>,
+				       <4 15 1>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart10: uart10-pins {
+			nuvoton,pins = <7 4 2>,
+				       <7 5 2>,
+				       <7 6 2>,
+				       <7 7 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart12: uart12-pins {
+			nuvoton,pins = <2 13 2>,
+				       <2 14 2>,
+				       <2 15 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart13: uart13-pins {
+			nuvoton,pins = <7 12 3>,
+				       <7 13 3>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart14: uart14-pins {
+			nuvoton,pins = <7 14 2>,
+				       <7 15 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart10 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart10>;
+	status = "okay";
+};
+
+&uart12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart12>;
+	status = "okay";
+};
+
+&uart13 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart13>;
+	status = "okay";
+};
+
+&uart14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart14>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index a1ebddecb7f8..f6f20a17e501 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -14,6 +14,10 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		serial11 = &uart11;
+		serial12 = &uart12;
+		serial14 = &uart14;
+		serial16 = &uart16;
 	};
 
 	chosen {
@@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &clk {
 	assigned-clocks = <&clk CAPLL>,
 			  <&clk DDRPLL>,
@@ -54,3 +54,78 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart-grp {
+		pinctrl_uart0: uart0-pins {
+			nuvoton,pins = <4 14 1>,
+				       <4 15 1>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart11: uart11-pins {
+			nuvoton,pins = <11 0 2>,
+				       <11 1 2>,
+				       <11 2 2>,
+				       <11 3 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart12: uart12-pins {
+			nuvoton,pins = <8 1 2>,
+				       <8 2 2>,
+				       <8 3 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart14: uart14-pins {
+			nuvoton,pins = <8 5 2>,
+				       <8 6 2>,
+				       <8 7 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart16: uart16-pins {
+			nuvoton,pins = <10 0 2>,
+				       <10 1 2>,
+				       <10 2 2>,
+				       <10 3 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart11 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart11>;
+	status = "okay";
+};
+
+&uart12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart12>;
+	status = "okay";
+};
+
+&uart14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart14>;
+	status = "okay";
+};
+
+&uart16 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart16>;
+	status = "okay";
+};
-- 
2.34.1


