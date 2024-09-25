Return-Path: <linux-kernel+bounces-339716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB05E986968
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2421F2424E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181F51A3A8A;
	Wed, 25 Sep 2024 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5hHAgqY"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2961A3BDA;
	Wed, 25 Sep 2024 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727306471; cv=none; b=MtNBU/4riUcSySEKzjzEA801mrlqm71wkGaFGXS6nCj52xLilljajqfe4IG8iDYN/CCqecBVM8k5ofvPqcN5VeMMhOmutyqXc1Y3JY/kmSEkjxtEWegEnSr2H/Cl09z31nc/tlpXa5J/GKXPx/O7rqC0Jqz7H2jf8n2y7ghZJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727306471; c=relaxed/simple;
	bh=+XN7JVyQjwitoz17emtEGN97FIhTSCOO/FA3S/viHjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0xuqD0M5gkWNDoJc4ZrDajNTSqByAXde67CzLhKbv9TIxkUnRUZwgQeMEoJO/umAaWqwM1yqOtnkqo2Be0zhqY7XrYVuJtwXrTr74CZSb8fV1T4xe4vQ23HAWjUGZ0xgTuzJcWnJbb4zR9y1YqlKNQ7fnCn34sjZ7kKRcQCuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5hHAgqY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso313631a12.3;
        Wed, 25 Sep 2024 16:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727306468; x=1727911268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVFuXuwQq4F0ZLDIr2tAnGQIQ63Zn3MBCQOz7VF/F8g=;
        b=W5hHAgqYgG1IwYFTE2iDVzE0yKA5kUuCiDCPaewlB4ccft+A55OvsCDodDeqy19F96
         scs+sO5DbPx/dyXe2/9k9HdppW6jib6KERFM1cidn99Woyt08BC4uYbvcD7yjD9doBqN
         Z65bnY+IJBPYAOcoNTiUtBMQ7Pw3392GN1vz+al5U65NVdDbYHkm3q0zPYhhcQkpdXzt
         462ynuJRyHiHSbt+fHTns+jRochAKmzgBeBIUbWg5z5SCxi9WwTAcJusVuSclxWh3p9B
         /jP13y8gCa1Y5IBYJFFEK3UY+KLXpQED+itjhpq90C8+jocXc9WOzo0i950kCzx1uDrz
         hrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727306468; x=1727911268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVFuXuwQq4F0ZLDIr2tAnGQIQ63Zn3MBCQOz7VF/F8g=;
        b=htgQoIZac/hOXPzKZhMFtRMJSdE95n9UkT09GLatimdnTuXIof7K/nHsw6H6/egQtN
         3DKh4ATilERkLXicH2gBH7HH8r6Ui9fU2hRPwZoJHJ9yhMiHiNMl8JeB99ad74VPYKTx
         InKdrR4RFr5S1ukHA+h2WCKzYn+SidCnxyaaVbFTAmNE5/QUKxRfRjhkt39SJcSbT9oa
         RFR3Gs418OFdR4j69v/eWYr3Z/aHm5O33H31sXpvVWV1HHVzUWWKTIUxr87vusAl9KQh
         BAXxk7aQOrc7imrl9cG1RsRd1FDcCha/oFbyIQG/PtHXV9/e78Go7BqsrzUYh6HjXQEQ
         aQjw==
X-Forwarded-Encrypted: i=1; AJvYcCU4kO9tdKLNgvR46JMTviZ/m0qnmt9DCD+mQfeCnzWdQUeV68skjiNNKvZP/4Xrn2VlqqZcxK4266cwR3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2hQqpCnNDBIQ3oDgOkqN4NicRVVMXTbWE3ZOUDzxEgLPrJZjy
	3xWFxIaQ5CDAyujq0jsfjo02zRgQqSvBjz2cral3UyrT1duCeMBR
X-Google-Smtp-Source: AGHT+IELRInJpxqZYi8CTCZwkwth1Bg0Cn73M4nS4KTBgLzsol54vPnsO/e6qWGAoQS7rVrkDGEtfw==
X-Received: by 2002:a05:6402:40c5:b0:5c0:ad76:f703 with SMTP id 4fb4d7f45d1cf-5c72063feecmr3058720a12.24.1727306467778;
        Wed, 25 Sep 2024 16:21:07 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c315sm2481026a12.15.2024.09.25.16.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 16:21:06 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/6] arm64: dts: imx8qxp: configure dsp node for rproc usage
Date: Wed, 25 Sep 2024 19:20:05 -0400
Message-Id: <20240925232008.205802-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Currently, the dsp node is configured for SOF usage, which is not the
"default" case and should be done in a separate SOF DTS. As such,
configure the dsp node for rproc usage, which is the "default" case.

This also includes the addition of the 2 optional power domains which
may be required by some applications.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 20 +++++++++----------
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 15 +++++++++++++-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 19 ++++++++++++++++++
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index ff5df0fed9e9..28970211dd67 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -431,22 +431,20 @@ dsp_ram_lpcg: clock-controller@59590000 {
 	};
 
 	dsp: dsp@596e8000 {
-		compatible = "fsl,imx8qxp-dsp";
+		compatible = "fsl,imx8qxp-hifi4";
 		reg = <0x596e8000 0x88000>;
 		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
 			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
 			 <&dsp_lpcg IMX_LPCG_CLK_7>;
 		clock-names = "ipg", "ocram", "core";
-		power-domains = <&pd IMX_SC_R_MU_13A>,
-			<&pd IMX_SC_R_MU_13B>,
-			<&pd IMX_SC_R_DSP>,
-			<&pd IMX_SC_R_DSP_RAM>;
-		mbox-names = "txdb0", "txdb1",
-			"rxdb0", "rxdb1";
-		mboxes = <&lsio_mu13 2 0>,
-			<&lsio_mu13 2 1>,
-			<&lsio_mu13 3 0>,
-			<&lsio_mu13 3 1>;
+		power-domains = <&pd IMX_SC_R_MU_13B>,
+				<&pd IMX_SC_R_IRQSTR_DSP>,
+				<&pd IMX_SC_R_MU_2A>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu13 0 0>,
+			 <&lsio_mu13 1 0>,
+			 <&lsio_mu13 3 0>;
+		firmware-name = "imx/dsp/hifi4.bin";
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 936ba5ecdcac..527933a3eb5c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -63,7 +63,8 @@ sound-wm8960 {
 };
 
 &dsp {
-	memory-region = <&dsp_reserved>;
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
 	status = "okay";
 };
 
@@ -71,6 +72,18 @@ &dsp_reserved {
 	status = "okay";
 };
 
+&dsp_vdev0buffer {
+	status = "okay";
+};
+
+&dsp_vdev0vring0 {
+	status = "okay";
+};
+
+&dsp_vdev0vring1 {
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 0313f295de2e..9522a65b3e22 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -186,6 +186,25 @@ dsp_reserved: dsp@92400000 {
 			status = "disabled";
 		};
 
+		dsp_vdev0vring0: vdev0vring0@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+			status = "disabled";
+		};
+
+		dsp_vdev0vring1: vdev0vring1@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+			status = "disabled";
+		};
+
+		dsp_vdev0buffer: vdev0buffer@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+			status = "disabled";
+		};
+
 		encoder_rpc: encoder-rpc@94400000 {
 			reg = <0 0x94400000 0 0x700000>;
 			no-map;
-- 
2.34.1


