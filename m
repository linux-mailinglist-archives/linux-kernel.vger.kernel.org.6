Return-Path: <linux-kernel+bounces-510168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACAAA31928
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B123A2301
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B6B268FC4;
	Tue, 11 Feb 2025 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAHF4yZl"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379426A0B3;
	Tue, 11 Feb 2025 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314735; cv=none; b=PZt9v+CX4Mp1Ov5OUU9iYRW4jrD4nKH7Jk0oLk/ckhwYc6dU5pmvn4uGU9oql7958PwUgs+w9wV4iEmt0KM0pRR4aX6LUTjlwyUH0jBAjqoCKippKHpnSqfx3RejyXpNZ6X5YyVwOOpsweNvFfFoZUjZv0JnJaPg4R2HDmH13z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314735; c=relaxed/simple;
	bh=ZYKjylCz6U/0L/L3Gbbqd3HrsBe1+tDd+PVvTCCII9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZttOUJDHx1voV33lFWRVMNXNIHtJx38ekzN5hs0XJhI2CvSvqXuFWVQVJIpRnCUSiMXyTxARx5zChyvKOJSjWealnI8WpDS3dvlsrIJQ6FwoBuVv+TWssacyATmr9453MbJbg20/USm6vJ1D9wrAwr+/ziY8QN/8yQRBmnlMbDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAHF4yZl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5deb1b8e1bcso21040a12.0;
        Tue, 11 Feb 2025 14:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739314731; x=1739919531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qEcHnFbnJv5rEQMaO2HHhljugT3IlHPIHIMW9SmVWI=;
        b=nAHF4yZlVZyWiXIDfDyEw11QeWrCeeVD8r1TkETI8Zk+vAWNbJufmLTwQrc4lQ0hDg
         EUWZQC/MPW3KqB0+brGaUDQfh6XSY8PbyHRmFZ5PIhqFnhHjmNspmZE5lXLBnIJTxnqG
         Q1UohFsZpUgXd1wkC6X4AyY+7k9DOGuIl0vC/Un4gOXYXWcoCsHVLHkD745Kw3v8mzGx
         bgOjCkRti0FbPBJPsOB/cvERO1CfVHrPaTy7R3ch6QwLuhC+qD9UcKmeDlMpn0cuaz0p
         5jGtQSOZgnglnXCyts6D6b53Y360a32HQCaZ95o8hVof/XmmEpHeEoxMWGNvyJv03BQQ
         Z6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739314731; x=1739919531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qEcHnFbnJv5rEQMaO2HHhljugT3IlHPIHIMW9SmVWI=;
        b=htqlRRZRkGJhGNpIh9IInf9l8LBWbi7kdpZMZA5rz4O554S76p7OGGcqJIXUfAMUev
         hfCU2YqgjhREUKcDBf5LiggdJjKoUlaiA6DmJD1Trpzp5cnKspcvo0uGT1sytasG2HrX
         ziTcoSAlhpAsICyjM+PnoKaYdcza2VK/L6VkdXjbX1omwwJkR5N0W7l3lH9Tn2NUTaJj
         gGOF2g7MpkpcEKbe7QL8Os2seFUKPiFaWE4j2g1eGkd2npWiQzUq6WDtR8U2nNTY9t22
         VMJbV/AMgiYIni1tgKfwU42IjAfG76m8n/upe/hF04AJ/GtQkcKC5h6T3pPsZjxqILFp
         J3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU5No6uu0EOFHhNHDXPe717Kc5J37BPSGST4jDy59f4z3OHKrHCWF1qxNTwvVgZd8f18b57D3RMWwAJ1oQH@vger.kernel.org, AJvYcCVJu75jANncz1LXczEGJT+7vy4+dXGNqkcCGFoetBf/l0z/HOn/bnifCBiawRmmjaPDHJKIFS4OQeK/@vger.kernel.org, AJvYcCWozy3TPQTrBAuy8dG20A38gGMEldRR3xX8v/NMkLZ5ywJSaAjfYCEdwoO7jcJPQV4wK27GTnymXzmqQj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyviAQWJgfh0+BnsjNXUc2aO/Oqc0kdAZJyoFG9IlBQ9dhw1An5
	KuL+ISNaJ8Mvmt9GyUgJhdszNLKHwCcaz9fEw7L04CcsIXhc/Sfp
X-Gm-Gg: ASbGncufTF7x/FDtP0vTLW/uN5jCLakEK76LK8WzzCbTVTp1mbvAEBLP/UTuf9R9FUQ
	dQdKa0xoOQgLD2/MCC5RDwFBBynwUqLJScxDVpl9QLWIio0R3znIZ1vIm1IgQmvFfI+O1RzzcIp
	ETtNn9cQw0rwP25VsLrnoKq+HHVLyCqANE5MNF7NO+pynSeon0Ve4ereYfOsHkHNE1YxSmJWvpw
	iqcnmYoaoRvGArSBhj2yS8SdDKdzM0h0hzEMdDbB+Rpz5rPR+Pd5O7dcWWWrzONFKQeCUTe/Hzx
	Z9hjLmEZfn5y4w1iFCYhmQABnfpy5rnPLu1+wLdcjZGH0vEttVZvcw==
X-Google-Smtp-Source: AGHT+IHyuiaJRoN+GdUxbeu3lRwZ7O6QbyCCZjzjPJTrp3NnmoIIq3WEcO3F8K15XX7Gr6EziTEjNw==
X-Received: by 2002:a17:907:3f21:b0:ab7:e47c:b54a with SMTP id a640c23a62f3a-ab7f347c15dmr55101866b.37.1739314731047;
        Tue, 11 Feb 2025 14:58:51 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e9fcd99csm131525166b.89.2025.02.11.14.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:58:50 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] arm64: dts: imx: add imx95 dts for sof
Date: Tue, 11 Feb 2025 17:58:08 -0500
Message-Id: <20250211225808.3050-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add imx95 DTS for SOF usage.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../dts/freescale/imx95-19x19-evk-sof.dts     | 85 +++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 839432153cc7..27f64e333e4b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -282,6 +282,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
 
 imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
 
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
new file mode 100644
index 000000000000..ce7b2384e459
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 NXP
+ */
+
+/dts-v1/;
+
+#include "imx95-19x19-evk.dts"
+
+/ {
+	sof_cpu: cm7-cpu@80000000 {
+		compatible = "fsl,imx95-cm7-sof";
+		reg = <0x0 0x80000000 0x0 0x6100000>;
+		reg-names = "sram";
+		memory-region = <&adma_res>;
+		memory-region-names = "dma";
+		mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
+		mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+
+		cpu: port {
+			cpu_ep: endpoint {
+				remote-endpoint = <&codec_ep>;
+			};
+		};
+	};
+
+	reserved-memory {
+		adma_res: memory@86100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x86100000 0x0 0x100000>;
+			no-map;
+		};
+	};
+
+	sof-sound-wm8962 {
+		compatible = "audio-graph-card2";
+		links = <&cpu>;
+		label = "wm8962-audio";
+		hp-det-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hp>;
+		widgets =
+			"Headphone", "Headphones",
+			"Microphone", "Headset Mic";
+		routing =
+			"Headphones", "HPOUTL",
+			"Headphones", "HPOUTR",
+			"Headset Mic", "MICBIAS",
+			"IN3R", "Headset Mic",
+			"IN1R", "Headset Mic";
+	};
+
+	sound-wm8962 {
+		status = "disabled";
+	};
+
+};
+
+&edma2 {
+	dma-channel-mask = <0xc0000000>, <0x0>;
+};
+
+&sai3 {
+	status = "disabled";
+};
+
+&wm8962 {
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>, <3612672000>,
+			       <393216000>, <361267200>,
+			       <12288000>;
+
+	port {
+		codec_ep: endpoint {
+			bitclock-master;
+			frame-master;
+			remote-endpoint = <&cpu_ep>;
+		};
+	};
+};
-- 
2.34.1


