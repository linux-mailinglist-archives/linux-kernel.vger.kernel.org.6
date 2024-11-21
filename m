Return-Path: <linux-kernel+bounces-416725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE29D4940
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749CB282DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5A1CFEDC;
	Thu, 21 Nov 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="twSSky7P"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F71CACEB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179205; cv=none; b=Nsf1fm1Kwm787lLV86+OKPigKqeD0oPDlUYr+viuKFq7dWMgcSdB2de/Rx/q+Yz9JDeodxr173OZ/wiVEb7w+CNH2JQVkZ5a8XVMQV4Td/3GxnyNM8o84G2WyyCfAtG5BKWTx/tKZN+p0hgOc8weSnd3jYH2iIOLcZo9DprfE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179205; c=relaxed/simple;
	bh=vO0NUTf39JA9CFefBGrsZh8fB/IWZjp1lI/XOU0bfnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvToG3DgHxI4hVK5BZjRU3nw9T16dtXg4fgWmNiKsbf6iJWNTbUsoJiIf5J3pHiKGfWus2wHrD9n0jtG4lqwnbb8+HDgUDseebXXqiKRYiS1hkjXNzjS1pZIEW1Vhu5tV0RGiKQXm4A7RMv4bj7hSE+hVyH4EAfqMBaLSZnEQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=twSSky7P; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so374576f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732179201; x=1732784001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA8zIvCeVehOTON6gWSJevS8rNPym+2I4qMSEQq/Vfs=;
        b=twSSky7P+R5J1YPy9le5oMqF7TWKJ9mw9tmmc+3BiF2+PeuHbOSihsXL3KhIC6tcEt
         YE1WGhebPEfQMJdY+hYtAo7X3zcNkOR38QFzT8k6d2VfcT/8EXG/qUpieVmQj8iPxplQ
         wyMD6j4IaTT4sdzMNpoDhUmzoQevgNVB+mcMiVjGmoZ91UCh8FPofGJktbNIovdgDauA
         XukG3Xz9w7680erWwYr/xUQ8HtlydhAu6I0xjx7fx2L72hu5cyDiRi3mkLKdkvKOa+sr
         mzjQJx+dOS1dRFb6xYw9c4cKaXP5mD+CP3vNj28rTr7cPBEdQVBvgCbUAj9gdc3V9WkT
         SGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179201; x=1732784001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA8zIvCeVehOTON6gWSJevS8rNPym+2I4qMSEQq/Vfs=;
        b=FoR93Z2FqHzxoaMAL9YZ51BaRC+YUT+bM32Ptg590F8lo1NmW23O9XJA7yrbYzh5cg
         g0YZXU4hwZtxcG5kUy+2eqraNW+Nc0kCN688f6tkYhcGELdBeFLHJYTQTNYs5UPuvR09
         jNjeI9swjNLJ07RHwiXH7D3wQag+gcm4ldPTd6as1HJxhjvmCgsLroHQVd7H5qoPXNr6
         +9l1dH5DbU83MGhX9Ber9sTjqlglKlQao3UdtD9uG+JOonUQJBv3Ksh0xXrJqxEDsd/q
         d59/O7QKcMuscoEj4KJVHcb/6iI5p9XQTv4IPjiBWYCsfflDjHfO2LG6jkfhc1JOryNi
         +5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCmuPXqz7u3ltvGuFfA8TJ37XgW/rL2m0iAC1BhoQt8uK+3MaAtOwtreLv4YkMHT8Qg4QX1e/0bxAJxT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkk7zvZ11auPzkBPlvxGCNckE595A483ybYCkVCCtW+wjQ2xz
	IZmxsDOwA0dqRotrST0z0vulrYqx/dhKOtEHrwW2SonyC8g33jqqCteorEwIXCQ=
X-Gm-Gg: ASbGncs27AenKSET4GFvKNoQbKoIFvJcO+IZb1TwFH2g9+K/p3KAcbPVNeapYAf10mo
	h/sJ556z4ljOop49bn3TD1dqPAYnwXqMmh3DsCMPkdUZZ6ys4qsJMhbwj/3ssJ1ou/a1DfVlI4f
	LAtakUML3PXrOGlvCmgrdKt5FHWS8R2sON5epgTIAH3oGCt/u2rxdHDX842S2GKoiYSptqOurOo
	q0PQsMVT++vxYLXyIhH5YVAGoA5yr6wnIJDuqx9UnDrmdiyLXwL2bkfD4lHGUF4S412HjHYBxWU
	fWH3RmCgb/lPoOQ9VNMIy6u4TkyDoxCt5pOzlpqmTV8=
X-Google-Smtp-Source: AGHT+IEb1ziv6SCjdyDQL96zzjg5G/z4Gi8F8wOiJmIAV34djYMshwdbu/LEIi6CkwPFG6A8w8/SPQ==
X-Received: by 2002:a5d:584a:0:b0:382:5492:4670 with SMTP id ffacd0b85a97d-38254b163c4mr4639144f8f.40.1732179201134;
        Thu, 21 Nov 2024 00:53:21 -0800 (PST)
Received: from [192.168.42.0] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549111fdsm4219900f8f.58.2024.11.21.00.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:53:20 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 21 Nov 2024 09:53:19 +0100
Subject: [PATCH v7 5/5] arm64: dts: mediatek: mt8365: Add support for
 camera
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-add-mtk-isp-3-0-support-v7-5-b04dc9610619@baylibre.com>
References: <20241121-add-mtk-isp-3-0-support-v7-0-b04dc9610619@baylibre.com>
In-Reply-To: <20241121-add-mtk-isp-3-0-support-v7-0-b04dc9610619@baylibre.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Andy Hsieh <andy.hsieh@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Add base support for cameras for mt8365 platforms. This requires nodes
for the sensor interface, camsv, and CSI receivers.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 125 +++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 9c91fe8ea0f969770a611f90b593683f93ff3e22..f3aae8d76cbece5779fe0b23139d594c0ea52579 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mediatek,mt8365-power.h>
+#include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
 
 / {
 	compatible = "mediatek,mt8365";
@@ -704,6 +705,23 @@ ethernet: ethernet@112a0000 {
 			status = "disabled";
 		};
 
+		mipi_csi0: mipi-csi0@11c10000 {
+			compatible = "mediatek,mt8365-csi-rx";
+			reg = <0 0x11c10000 0 0x2000>;
+			status = "disabled";
+			num-lanes = <4>;
+			#phy-cells = <1>;
+		};
+
+		mipi_csi1: mipi-csi1@11c12000 {
+			compatible = "mediatek,mt8365-csi-rx";
+			reg = <0 0x11c12000 0 0x2000>;
+			phy-type = <PHY_TYPE_DPHY>;
+			status = "disabled";
+			num-lanes = <4>;
+			#phy-cells = <0>;
+		};
+
 		u3phy: t-phy@11cc0000 {
 			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
 			#address-cells = <1>;
@@ -774,6 +792,113 @@ larb2: larb@15001000 {
 			mediatek,larb-id = <2>;
 		};
 
+		seninf: seninf@15040000 {
+			compatible = "mediatek,mt8365-seninf";
+			reg = <0 0x15040000 0 0x6000>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&camsys CLK_CAM_SENIF>,
+				 <&topckgen CLK_TOP_SENIF_SEL>;
+			clock-names = "camsys", "top_mux";
+
+			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+
+			phys = <&mipi_csi0 PHY_TYPE_DPHY>, <&mipi_csi1>;
+			phy-names = "csi0", "csi1";
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+
+				port@2 {
+					reg = <2>;
+				};
+
+				port@3 {
+					reg = <3>;
+				};
+
+				port@4 {
+					reg = <4>;
+					seninf_camsv1_endpoint: endpoint {
+						remote-endpoint =
+							<&camsv1_endpoint>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					seninf_camsv2_endpoint: endpoint {
+						remote-endpoint =
+							<&camsv2_endpoint>;
+					};
+				};
+			};
+		};
+
+		camsv1: camsv@15050000 {
+			compatible = "mediatek,mt8365-camsv";
+			reg = <0 0x15050000 0 0x0040>,
+			      <0 0x15050208 0 0x0020>,
+			      <0 0x15050400 0 0x0100>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&camsys CLK_CAM>,
+				 <&camsys CLK_CAMTG>,
+				 <&camsys CLK_CAMSV0>;
+			clock-names = "cam", "camtg", "camsv";
+			iommus = <&iommu M4U_PORT_CAM_IMGO>;
+			mediatek,larb = <&larb2>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					camsv1_endpoint: endpoint {
+						remote-endpoint = <&seninf_camsv1_endpoint>;
+					};
+				};
+			};
+		};
+
+		camsv2: camsv@15050800 {
+			compatible = "mediatek,mt8365-camsv";
+			reg = <0 0x15050800 0 0x0040>,
+			      <0 0x15050228 0 0x0020>,
+			      <0 0x15050c00 0 0x0100>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&camsys CLK_CAM>,
+				 <&camsys CLK_CAMTG>,
+				 <&camsys CLK_CAMSV1>;
+			clock-names = "cam", "camtg", "camsv";
+			iommus = <&iommu M4U_PORT_CAM_IMGO>;
+			mediatek,larb = <&larb2>;
+			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					camsv2_endpoint: endpoint {
+						remote-endpoint = <&seninf_camsv2_endpoint>;
+					};
+				};
+			};
+		};
+
 		vdecsys: syscon@16000000 {
 			compatible = "mediatek,mt8365-vdecsys", "syscon";
 			reg = <0 0x16000000 0 0x1000>;

-- 
2.47.0


