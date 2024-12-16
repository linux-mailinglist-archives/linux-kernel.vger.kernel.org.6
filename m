Return-Path: <linux-kernel+bounces-446923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4B9F2AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642151639BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334391CEE8C;
	Mon, 16 Dec 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b="aUo9Q1Y6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636D3B19A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334525; cv=none; b=Je77N4UXnz/kh+nCnCqL8Q1Q5bcNGneHU6zbGnbFCDuC9mhyD99q8uOnUsueHqJjvSiHG7+hgP5OMQggsJPxjnXqx161f/snAKGclLWwHfjcP1+gOaMeilMZqF/l+LPni+ZsaJfyPmDAKKYjdEyXaN6d6cgYTpWDMuMmGTOtzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334525; c=relaxed/simple;
	bh=tzaOt2BnX2MCQK+1QpzW9jTGoy3s0LwZzuPUxYu++Go=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eDkF22zUG/w7MnhRb6lScmVTYl46wOPoRNOINnotqRpQXGPZaaPwikLazI6o//MGf7oE0yq7ZbZbglSJWiJPd50fBJoggMixCh5ojhr8m1Dd/4oWlfk6arhBKSQlNrmLcV32U9CdJlPmfnai4zwTDraoEqbugxX1tpI2B6QneLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com; dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b=aUo9Q1Y6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21670dce0a7so41055445ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pegatron-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1734334522; x=1734939322; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ghfXEzNC0LKCgXVnuy0foatupNP0hXk60L3nylPjlwQ=;
        b=aUo9Q1Y6l64R7xjLgPPrizBobnBV/XZ/YZ7a8eZVfGgAUia+DACyaCEyKgHkdwaH0A
         azQ4FS0StjBku4f9NyxyMdppgiTZzwucsMfn7MdbAQmzptde3oV61N7yM/RxvfwG8M6i
         j5T4F2V5z7ZylExvNbsVlLupea0vG4Dw1tV5BAwUSHyo8fTprm3TvjJe+lJkXzBSqRC7
         r+eEEaz8V7haac0/GwfZS1woMU2DBGbNeO4+MB/nt6asPoqQHvq25bozWw5r00sWi6dd
         kUZukj+CZZkqQ/m7u0M/p8otBTrh2bHIi2GTShED4vvPVbl3hdvesPKS9RzywQwFL+92
         FfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734334522; x=1734939322;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghfXEzNC0LKCgXVnuy0foatupNP0hXk60L3nylPjlwQ=;
        b=j2xwUJtuUOIPxL9tuSRpdr40NvQ58QB41oOthu0v1uB+94rRMyjyjIpYjx6mtx+/oO
         Eowfq9J1llEKIhWdOW53c58eFLGjXghx1EMjq2OIAiEMJQBn0mAoDJvNEYYGKdsTu51J
         JRP8tqy13/Ud4pXi0yKWVvzsg8BT/qmb1CAnbKylonkGfyrJEo+kwmu6xfAZx66Qys1u
         6MTIEgzEfDaXf06WYisC6AOsYDbZkGXTwtPuNRkweRRmUhpc6z8cViimjhr8aGAE9EoM
         nnU/E+oH4mYJQtfSmKLeHQB+OYIZX9BE87k0ZgedAAFT2C/I0sYTOoq2bZSOKHF07QhQ
         ZeTg==
X-Forwarded-Encrypted: i=1; AJvYcCVtrlO4lvV7B2cdaFC/HY7KLaK8UxBkUehwHKJ1398EyFhdqsNy9KWE+fk3oBl2u4Ft0juCMyZt3X8/KDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRE54M0FPotyrFySjpImTlrfQMsAVPdUwMAxFt/SPYtTNcA9E5
	gG3NlkmxNDpknKAxPdKoUJZjdDZYh/w72o03nZNCP8SSkR7R6n/FUM8/GdYsxJk=
X-Gm-Gg: ASbGncum0a59eo5avxFHuUfMctgTjHnEIXzXMOPy9F4Uw26M7eXQdn+1Cq/bQzPp318
	ZYYpiRzZL7tmIkKw6ty3CLyjPqewbPazJOau/Yix5gEpuFgETeXHYw/IYwWkwFsn4UnKD/RJhaX
	XH8y5q3bdHdG3balrovAvBM3QI1gBQeRJzG1CDZ3Glp1rE5JwI3JENHZLvHV8k5CgBF05pxSdUS
	eV9BtsSwYJO6vWtIgG7f67FiwCidTtGCkDg2NTkR2dwtG/uf4NiaHtWgEhv71fOyczNa3IpA5qi
	sBLbmSitQ0bqgIL1liev1NJs1f80Apeq/ZxoNaZkwuXafgORd4wbWAzehjyouokX+KhKdR85KPw
	ysSNrzbxc1Q+/gFY=
X-Google-Smtp-Source: AGHT+IGOIU+hg5lbLXSrdiLWIfIj0Z6VBovKrVeJsa1AYwz5Jfx+BVUrmpZ/19GgPgtdamSh98AS4Q==
X-Received: by 2002:a17:902:ea0e:b0:216:5e6e:68cb with SMTP id d9443c01a7336-218929a1ec5mr134535545ad.16.1734334522021;
        Sun, 15 Dec 2024 23:35:22 -0800 (PST)
Received: from [127.0.1.1] (2001-b400-e261-f376-b358-4574-ae63-0466.emome-ip6.hinet.net. [2001:b400:e261:f376:b358:4574:ae63:466])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5ce3esm36716575ad.195.2024.12.15.23.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:35:21 -0800 (PST)
From: Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>
Date: Mon, 16 Dec 2024 15:35:12 +0800
Subject: [PATCH] arm64: dts: mt8186: Add mt8186-skitty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-skitty_kernel-v1-1-bc75dcdfeb57@pegatron.corp-partner.google.com>
X-B4-Tracking: v=1; b=H4sIAC/YX2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Mz3eLszJKSyvjs1KK81Bxds1RjY4NEE0vjFFNDJaCegqLUtMwKsHn
 RsbW1AIxqyDxfAAAA
X-Change-ID: 20241216-skitty_kernel-6e330a493d51
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 herbert1_wu@pegatron.corp-partner.google.com, 
 Thomas_Hsieh@pegatron.corp-partner.google.com, 
 Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734334517; l=9093;
 i=geoffrey_chien@pegatron.corp-partner.google.com; s=20241216;
 h=from:subject:message-id; bh=tzaOt2BnX2MCQK+1QpzW9jTGoy3s0LwZzuPUxYu++Go=;
 b=nvHpO/GngrjjlY6vJkhlBhJb03k5ZRSwMHlFOHjP3Us6maM9PL6CDpoS5wW//qXEvEaW2iYs7
 gqOnuwEfvsMCiYUf6HUGb1ROVXh9z+OH6AdlCLPSjPyhnzqJ2rM6YPp
X-Developer-Key: i=geoffrey_chien@pegatron.corp-partner.google.com; a=ed25519;
 pk=P8X+ifKsuR9w8T8cIa35nudXKmZX6qk0iS+5EcuwtrU=

Add Skitty initial device tree.
Support second source Synaptics trackpad
Support US2 keyboard.
Enhance touch screen timing for ELAN
Based on experiment, set drive-strength to 6mA (default = 8mA)
Modify sbs battery reg to 0x0f

Signed-off-by: Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>
---
 .../devicetree/bindings/arm/mediatek.yaml          |  8 +++
 arch/arm64/boot/dts/mediatek/Makefile              |  4 ++
 .../dts/mediatek/mt8186-corsola-skitty-sku1.dts    | 23 +++++++
 .../dts/mediatek/mt8186-corsola-skitty-sku2.dts    | 13 ++++
 .../dts/mediatek/mt8186-corsola-skitty-sku3.dts    | 40 ++++++++++++
 .../dts/mediatek/mt8186-corsola-skitty-sku4.dts    | 30 +++++++++
 .../boot/dts/mediatek/mt8186-corsola-skitty.dtsi   | 76 ++++++++++++++++++++++
 7 files changed, 194 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d9aadb7b77e144a474b79da005056..29e7555569a772ba042e29af01ea98fdd3be1525 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -224,6 +224,14 @@ properties:
               - google,pico-sku2
           - const: google,pico
           - const: mediatek,mt8183
+      - description: Google Skitty (HP Chromebook G1m 11 inch)
+        items:
+          - const: google,skitty-sku1
+          - const: google,skitty-sku2
+          - const: google,skitty-sku3
+          - const: google,skitty-sku4
+          - const: google,skitty
+          - const: mediatek,mt8186
       - description: Google Willow (Acer Chromebook 311 C722/C722T)
         items:
           - enum:
diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 8fd7b2bb7a1590341e7bb4ea1ecf039ae3e8eb0d..328e1ee444bd81b5a2aa3d21acb7a5c5a3318a87 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -59,6 +59,10 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-skitty-sku1.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-skitty-sku2.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-skitty-sku3.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-skitty-sku4.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku1.dts
new file mode 100644
index 0000000000000000000000000000000000000000..a0e7b10445333d6f83fc4c461ce8f8d75ffaa697
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku1.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-skitty.dtsi"
+
+/ {
+	model = "Google Skitty sku1 board";
+	compatible = "google,skitty-sku1",
+		"google,skitty", "google,corsola", "mediatek,mt8186";
+};
+
+&i2c1 {
+	/delete-node/ touchscreen@10;
+	touchscreen: touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku2.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku2.dts
new file mode 100644
index 0000000000000000000000000000000000000000..c071c1b8952b50eacfc2d48dbb9450e9b358ef0e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku2.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-skitty.dtsi"
+
+/ {
+	model = "Google Skitty sku2 board";
+	compatible = "google,skitty-sku2",
+		"google,skitty", "google,corsola", "mediatek,mt8186";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku3.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku3.dts
new file mode 100644
index 0000000000000000000000000000000000000000..09b4b26aba93c0e65b5fbef6eb81edbe414daa0b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku3.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-skitty.dtsi"
+
+/ {
+	model = "Google Skitty sku3 board";
+	compatible = "google,skitty-sku3",
+		"google,skitty", "google,corsola", "mediatek,mt8186";
+};
+
+&i2c1 {
+	/delete-node/ touchscreen@10;
+	touchscreen: touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+	};
+};
+
+&keyboard_controller {
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+		MATRIX_KEY(0x04, 0x00, KEY_102ND)
+	>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku4.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku4.dts
new file mode 100644
index 0000000000000000000000000000000000000000..c3e2dbd0120f32062dba6a2f6f9e8ee31db02588
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty-sku4.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-skitty.dtsi"
+
+/ {
+	model = "Google Skitty sku4 board";
+	compatible = "google,skitty-sku4",
+		"google,skitty", "google,corsola", "mediatek,mt8186";
+};
+
+&keyboard_controller {
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+		MATRIX_KEY(0x04, 0x00, KEY_102ND)
+	>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..51a05f96191b4e40ad1f77e6a8ea23c99af3b279
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-krabby.dtsi"
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+	>;
+
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+&usb_c1 {
+	status = "disabled";
+};
+
+&target {
+	temperature = <76000>;
+};
+
+&i2c2 {
+	touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		hid-descr-addr = <0x20>;
+		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+
+	pins-cmd-dat {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
+
+&i2c_tunnel {
+	/delete-node/ sbs-battery@b;
+
+	battery: sbs-battery@f {
+		compatible = "sbs,sbs-battery";
+		reg = <0xf>;
+		sbs,i2c-retry-count = <2>;
+		sbs,poll-retry-count = <1>;
+	};
+};

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241216-skitty_kernel-6e330a493d51

Best regards,
-- 
Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>


