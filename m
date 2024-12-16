Return-Path: <linux-kernel+bounces-447527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155EF9F33C3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A07A24C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC32C14B94C;
	Mon, 16 Dec 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtgtOEt6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B67207A1D;
	Mon, 16 Dec 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360688; cv=none; b=QGQsPlrbMDkBsgeZAAX91lAlHc5sSMZD32POISSjWnYgI19tkr88i6Ayo9fw17ns0HlvvQVyqUMtEIG9MZJhGL9ud+fWThSxtnZz16HKUXobrigrwUcIv5B97LXVWZzm5pjgtqftYfZ2y66BIwIGQQv4ah4a3i026jmOYyOiXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360688; c=relaxed/simple;
	bh=AkMTmkKlrQ8VFXVorPrHhF449gun9/lsauN+Wej1SvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cu20Jre5gKYE5CTSC0UAhN00s18E+q+nfnXdO7BkAC7Hn6Xw/M1niwrFYN84YbtIMRjBSM3/KL4oovM0+0rHd7ahUdHH7tb78o1VGdxDyCCEEF5Bj1Uh0gHI+PdxOunildb3QOIZpxNXl2Iljomt0Zadz4ZH8Jb5hPQ1jU7iJcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtgtOEt6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4362f61757fso30056925e9.2;
        Mon, 16 Dec 2024 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734360684; x=1734965484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAAKa/iJbcg0hE8bXqvcJeWPfM0/EwIS0mrbbFrulwU=;
        b=JtgtOEt6eSbfTqAjyslnwMKAHDjhx7IXBmhC4Z5tAfd9+2/s8xLsKn9+BMimHuChHI
         vHJbIe/iSrbdKY7Hh+pktleVNq9te/mLgbPy1w9HQsteLAyMQWwwYt5+8sYds3zuIqN/
         A3iUutayo4x28BxqUNVx1jw3TGIsSphIewsHi0Ni9XH0SjwweWvyjm4mFRQ4j8OGHsBO
         hEU8rmxR6twT1AQo4mZ92xWapkxVm/G3KDaxblYwKjodjtdGH7JJTGx0+kV8WRAhF8ey
         gC0ATWXzUC1obzQLAaJDyTGH7IY6YAyJ2v7P3SvHPaeQfnHdSRGzi0kXymlTr8q3CueK
         RYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360684; x=1734965484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAAKa/iJbcg0hE8bXqvcJeWPfM0/EwIS0mrbbFrulwU=;
        b=pJ9EtJy3E1p+Ri4TKK79+GFXKMrohAkfKI+YqQrnqfu5AM9igWBWHjkpO8r5i8+Icp
         IqtDam1KedjCBmdDv1aZDtm8Wx2xMad52Pou3sFVp4T0mLbCHcwHzM+XjevhyrDJMNWR
         GppTFkGN9PzFPkldCK8GevuUkqkYeNX6qIhFO4rMfG64yltZbGdWQ9c7k/JSCKM0vWK7
         8Sji8cgbK3zZyMl9kmaLg0nxZQb6jlhmnVW+OpAupWa+MVtetZ3y27ZEjl6lRMOnelYX
         VabYAsE6rOjZSBi91YBgLhVgrpDNpapsgl0XYssCOGt60HwVNiqih1ZZyHZVEexmA8Bd
         jNRA==
X-Forwarded-Encrypted: i=1; AJvYcCU7ElhV8kE6tuNPF8v54W2DgyZWg8x2mUhivM1ag84fyahqmigib9DLmG/j2V9EYmFEGsC4arlI7Dpb5ZI=@vger.kernel.org, AJvYcCWg+WsBdo5y46QAs8s0BDESoBiUXUFilKr/2hhvGgUcF9YVwBOtHgON7TWvFAvEckihtDMYXc8IZ963@vger.kernel.org, AJvYcCXgdDOB1HSSf3M93PN3x6TkdcQFX7ZNT0lhw1z1PGEqPvW+pZWMnif18tJ0loZ9Ysl1VUZcra3PC7SG60sz@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1NaMoP83pi/rj8NWMRp5iNtMo+WSOYHyDDSAwfHCdLdfhTWS
	Trt3EWBzlbS3i4fV/pKnYALV1z13ZhEsUTAfbOTMqwjZvVCUDGwaS/AlGHEb
X-Gm-Gg: ASbGncvNgCjotCRwbYviOMTsQIDyx71dsveDa68WVgFNF42d3BY7XHdjXVtFD2CqAmm
	D0o7i29t2SUv7ny0bwbn4iPn0wlCPqb4pJdcOV7WP9LUTR8sd9VWt6SvAbXBcg1EzR+zIrEdMqP
	JgrzLI6nfl3obwc9hoLqNDSt0MkTnSufzRqSPwkktT+Wg5o1I5xUJ+GDxy9VJsmJJVMnNZ6Uryv
	UvaawIT3kMlxxVfudtklUX2n4iN9jlRat8M4QiAhXEM24L3yozmIPa+ymz2qpXnAWOEAvouLH74
	GNEOLDkpDTpGH9yt
X-Google-Smtp-Source: AGHT+IF6mGQ66zqt23wxmdgyvCpFmx39WbIi+8c7emJk9Jb285zsFEtWpp62qxObMAzNXGOH9H4hJg==
X-Received: by 2002:a05:600c:a011:b0:434:f819:251a with SMTP id 5b1f17b1804b1-4362aa3a029mr127042805e9.9.1734360684343;
        Mon, 16 Dec 2024 06:51:24 -0800 (PST)
Received: from playground.localdomain ([92.120.5.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ed6csm141616455e9.24.2024.12.16.06.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:51:23 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: imx: add imx95 dts for sof
Date: Mon, 16 Dec 2024 09:50:39 -0500
Message-Id: <20241216145039.3074-6-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
References: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
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
 .../dts/freescale/imx95-19x19-evk-sof.dts     | 75 +++++++++++++++++++
 2 files changed, 76 insertions(+)
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
index 000000000000..8eef83d7bdd7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
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
+		memory-region = <&adma_res>;
+		mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
+		mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
+		cpu: port {
+			cpu_ep: endpoint { remote-endpoint = <&codec_ep>; };
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
+	port {
+		codec_ep: endpoint { remote-endpoint = <&cpu_ep>; };
+	};
+};
-- 
2.34.1


