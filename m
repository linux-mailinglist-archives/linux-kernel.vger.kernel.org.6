Return-Path: <linux-kernel+bounces-419384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58E9D6D29
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD6EB21577
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E4183CBE;
	Sun, 24 Nov 2024 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LEL7ueS1"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599E18787A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732438767; cv=none; b=h2FsxSsAXBuCmzDBfjjx0q2+JQAOVuYFlOKkn5GqANFK6EAZw1wEW8PcpNxUssaY1YMpMEuDd3DuwUt9Llj2zZ4ia//o+X5DORQeFONIjNQuBG/jyPGe+YgLuYcKb+exVeZsllgsDiAR8hzSfeavU+1YdDTVPlQ1YrWDJ2wJClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732438767; c=relaxed/simple;
	bh=M5hMtGE2VEOHXAMKY/GKI1/D7DMS+Zzq+E39PxdCdyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fb8y/5Am+hZWCy2n9hdh6v56dsihuFA8OPlJLS2NIBH1fc0E90l8Po2KYGXmjq26uo1HGy8L0M7irMde1vRzNnowEosRVpYSArNrg3wf4S5GvDazFUGicrfVSbrOX4TLw6fXF84Aw6hXuRg9J8o5u7G/mb/pe64EREw2KVjNwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LEL7ueS1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so3052181a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 00:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732438763; x=1733043563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXyEIyDY1hF5Sxw4KDNeK3S+KYS5aJqD4Q0mu6/VgqY=;
        b=LEL7ueS1vuI5YG/LhRzVoZXfs5wZ9vyjxIrOE7QPZBhqOpYE2T/wuUCNPmF6BKaSjf
         7vvxocKmY8HJrplS+S4BucLjD4dmRYVl4s0YcjLGBkXUTDGk290vh6uxaX946Hy4+pL7
         glbudPIBKG0EOI9iERHNq/O4C8y8nG21YQaqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732438763; x=1733043563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXyEIyDY1hF5Sxw4KDNeK3S+KYS5aJqD4Q0mu6/VgqY=;
        b=vn9jqViOYS4P/Eb/KfRY874JDKosqLLxKV2YqnQKkYDtyUSwCXFcN2yP2yKXlAU2LP
         an4ZxUSSro+72Y6nP4hbNVt4IXUY3UPe2qJmrprog43SWj1nKpM3T7utE2TWQKF3Yb4T
         HfaJbK9vM/F40hNk9Bj/+PcKj3OfXleW5GBcC2hA7fJGIEh3zz491TJA6UFXhkrDALdK
         dzA0TDZTIZZHmjgI+aK4opxcXENVN6XH+Vf6/DEHHSuEunL/XXlDR5J2eis+RkreznDK
         n+N4/uCe6uANBxpl5QhO17U5nXUiMxGIJ5Sl4mEn4HqXZcqAIjyWWz9lcOzu/4RyTbyw
         VOcw==
X-Forwarded-Encrypted: i=1; AJvYcCVByf9ueH3xeFEc3nk0Iacbf9cGTRRDkxKbPdhe3QtuByBliX463OnictO8VE7ItEtSFf9CWn5aj4XJioE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFKBrD1EgojqGfeEHrVSGQH9FBWt/myP8IjpK5Cp+vaHTLusbf
	df9myVKbM819Gwxsectul3Eu08XK/zswXVOrCJHyXxx+c05BW8Tlo39HQy+LYw==
X-Gm-Gg: ASbGnctQBQvefJ8FWZtlEzuGYpSpkOjseV00JcFydgyW00vUTcTD8JKykkuk3GkuIaP
	wCxqo0c8WXSOBsm85qWgalqzygXir4O5lWKbyu5BlRfhYKFdAneQ0uFT0CxgA9HzZpQttmDdm/P
	0zKdAxDIFXRGZUUOKHB8WOoES7LcJGril6CrmROglus5tYey6bHN6ttybpSrz7bwogfQiLhToCw
	4IcLI2gskGcYLlCbrpYHRWbkggxZos+hZJoZO/c4ml9fKz56xST0YLgokUI9/vLVHAEwg==
X-Google-Smtp-Source: AGHT+IEgVYNSvE8r3Qxv3LmrnhzRj4+7OoucbqI9pUxA3mjrYHFN9m9GBcuv67cM5yxhlwgEZhnUyw==
X-Received: by 2002:a05:6a20:7291:b0:1db:dfc7:d86e with SMTP id adf61e73a8af0-1e09e60ef3amr12190022637.45.1732438762978;
        Sun, 24 Nov 2024 00:59:22 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:f699:9cb9:f928:9a14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc4c28sm4465890a12.3.2024.11.24.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:59:22 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt platform based Ciri
Date: Sun, 24 Nov 2024 16:52:38 +0800
Message-ID: <20241124085739.290556-3-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241124085739.290556-1-fshao@chromium.org>
References: <20241124085739.290556-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce MT8188-based Chromebook Ciri, also known commercially as
Lenovo Chromebook Duet (11", 9).

Ciri is a detachable device based on the Geralt design, where Geralt is
the codename for the MT8188 platform. Ciri offers 8 SKUs to accommodate
different combinations of second-source components, including:
- audio codecs (RT5682S and ES8326)
- speaker amps (TAS2563 and MAX98390)
- MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)

Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v3:
- drop scp_mem, scp_pins and SCP declaration per discussion in v2
- drop unused (for now) dual-SCP reserved memory range
- drop unused touchscreen pinctrl
- drop unused HID-I2C touchscreen node in I2C-2
- drop unused AP-SAR sensor node in I2C-3
- drop trackpad node in I2C-4 (only work with downstream CBAS)
- drop mmc1 (unused in public product)
- drop eDP panel path (unused in public product)
- declare DSI panel compatibles in individual board .dts files
- declare CPU TDP target in -geralt.dtsi instead
- move spi1 default and sleep pinctrl to -geralt.dtsi
- leave memory@40000000 size empty (filled by bootloader)
- consolidate audio codec/amplifier, DAI link declaration and
  audio-routing property
- stop sourcing `arm/cros-ec-sbs.dtsi` in -geralt.dtsi, because all that
  does is to declare sbs-battery at address 0xb, which doesn't align
  with the final design at 0xf. This saves us a /delete-node/.
- minor format fix

Changes in v2:
- remove invalid or undocumented properties
    e.g. mediatek,dai-link, maxim,dsm_param_name etc.
- remove touchscreen as the driver is not yet accepted in upstream
- update sound DAI link node name to match the binding
- add missing pinctrls in audio codec nodes

 arch/arm64/boot/dts/mediatek/Makefile         |    8 +
 .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   32 +
 .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   59 +
 .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   59 +
 .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   32 +
 .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   48 +
 .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   72 +
 .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   72 +
 .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   48 +
 .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  316 +++++
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1156 +++++++++++++++++
 11 files changed, 1902 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 8fd7b2bb7a15..c6c34d99316b 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -69,6 +69,14 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589824.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589825.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku1.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku2.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku3.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku4.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku5.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku6.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku7.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
new file mode 100644
index 000000000000..79d6d12394b9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt-ciri.dtsi"
+
+/ {
+	model = "Google Ciri sku0 board";
+	compatible = "google,ciri-sku0", "google,ciri", "mediatek,mt8188";
+};
+
+&dsi_panel {
+	compatible = "boe,nv110wum-l60", "himax,hx83102";
+};
+
+&sound {
+	compatible = "mediatek,mt8188-rt5682s";
+	model = "mt8188_m98390_5682";
+
+	audio-routing =
+		"ETDM1_OUT", "ETDM_SPK_PIN",
+		"ETDM2_OUT", "ETDM_HP_PIN",
+		"ETDM1_IN", "ETDM_SPK_PIN",
+		"ETDM2_IN", "ETDM_HP_PIN",
+		"ADDA Capture", "MTKAIF_PIN",
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR",
+		"IN1P", "Headset Mic",
+		"Left Spk", "Front Left BE_OUT",
+		"Right Spk", "Front Right BE_OUT";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
new file mode 100644
index 000000000000..ef5ea9d12b1d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt-ciri.dtsi"
+
+/ {
+	model = "Google Ciri sku1 board";
+	compatible = "google,ciri-sku1", "google,ciri", "mediatek,mt8188";
+};
+
+&dsi_panel {
+	compatible = "ivo,t109nw41", "himax,hx83102";
+};
+
+&i2c0 {
+	/delete-node/ audio-codec@1a;
+
+	es8326: audio-codec@19 {
+		compatible = "everest,es8326";
+		reg = <0x19>;
+		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_codec_pins>;
+		#sound-dai-cells = <0>;
+		everest,jack-pol = [0e];
+		everest,interrupt-clk = [00];
+	};
+};
+
+&sound {
+	compatible = "mediatek,mt8188-es8326";
+	model = "mt8188_m98390_8326";
+
+	audio-routing =
+		"ETDM1_OUT", "ETDM_SPK_PIN",
+		"ETDM2_OUT", "ETDM_HP_PIN",
+		"ETDM1_IN", "ETDM_SPK_PIN",
+		"ETDM2_IN", "ETDM_HP_PIN",
+		"ADDA Capture", "MTKAIF_PIN",
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR",
+		"MIC1", "Headset Mic",
+		"Left Spk", "Front Left BE_OUT",
+		"Right Spk", "Front Right BE_OUT";
+
+	dai-link-2 {
+		codec {
+			sound-dai = <&es8326>;
+		};
+	};
+
+	dai-link-3 {
+		codec {
+			sound-dai = <&es8326>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
new file mode 100644
index 000000000000..ef56786fc2be
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt-ciri.dtsi"
+
+/ {
+	model = "Google Ciri sku2 board";
+	compatible = "google,ciri-sku2", "google,ciri", "mediatek,mt8188";
+};
+
+&dsi_panel {
+	compatible = "boe,nv110wum-l60", "himax,hx83102";
+};
+
+&i2c0 {
+	/delete-node/ audio-codec@1a;
+
+	es8326: audio-codec@19 {
+		compatible = "everest,es8326";
+		reg = <0x19>;
+		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_codec_pins>;
+		#sound-dai-cells = <0>;
+		everest,jack-pol = [0e];
+		everest,interrupt-clk = [00];
+	};
+};
+
+&sound {
+	compatible = "mediatek,mt8188-es8326";
+	model = "mt8188_m98390_8326";
+
+	audio-routing =
+		"ETDM1_OUT", "ETDM_SPK_PIN",
+		"ETDM2_OUT", "ETDM_HP_PIN",
+		"ETDM1_IN", "ETDM_SPK_PIN",
+		"ETDM2_IN", "ETDM_HP_PIN",
+		"ADDA Capture", "MTKAIF_PIN",
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR",
+		"MIC1", "Headset Mic",
+		"Left Spk", "Front Left BE_OUT",
+		"Right Spk", "Front Right BE_OUT";
+
+	dai-link-2 {
+		codec {
+			sound-dai = <&es8326>;
+		};
+	};
+
+	dai-link-3 {
+		codec {
+			sound-dai = <&es8326>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
new file mode 100644
index 000000000000..524f7f0064c1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt-ciri.dtsi"
+
+/ {
+	model = "Google Ciri sku3 board";
+	compatible = "google,ciri-sku3", "google,ciri", "mediatek,mt8188";
+};
+
+&dsi_panel {
+	compatible = "ivo,t109nw41", "himax,hx83102";
+};
+
+&sound {
+	compatible = "mediatek,mt8188-rt5682s";
+	model = "mt8188_m98390_5682";
+
+	audio-routing =
+		"ETDM1_OUT", "ETDM_SPK_PIN",
+		"ETDM2_OUT", "ETDM_HP_PIN",
+		"ETDM1_IN", "ETDM_SPK_PIN",
+		"ETDM2_IN", "ETDM_HP_PIN",
+		"ADDA Capture", "MTKAIF_PIN",
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR",
+		"IN1P", "Headset Mic",
+		"Left Spk", "Front Left BE_OUT",
+		"Right Spk", "Front Right BE_OUT";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
new file mode 100644
index 000000000000..ea953d7e1543
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt-ciri.dtsi"
+
+/ {
+	model = "Google Ciri sku4 board (rev4)";
+	compatible = "google,ciri-sku4", "google,ciri", "mediatek,mt8188";
+};
+
+&dsi_panel {
+	compatible = "boe,nv110wum-l60", "himax,hx83102";
+};
+
+&i2c0 {
+	/delete-node/ amplifier@38;
+	/delete-node/ amplifier@39;
+
+	tas2563: amplifier@4f {
+		compatible = "ti,tas2563", "ti,tas2781";
+		reg = <0x4f>, <0x4c>; /* left / right channel */
+		reset-gpios = <&pio 118 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&sound {
+	compatible = "mediatek,mt8188-rt5682s";
+	model = "mt8188_tas2563_5682";
+
+	audio-routing =
+		"ETDM1_OUT", "ETDM_SPK_PIN",
+		"ETDM2_OUT", "ETDM_HP_PIN",
+		"ETDM1_IN", "ETDM_SPK_PIN",
+		"ETDM2_IN", "ETDM_HP_PIN",
+		"ADDA Capture", "MTKAIF_PIN",
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR",
+		"IN1P", "Headset Mic";
+
+	dai-link-1 {
+		codec {
+			sound-dai = <&tas2563>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
new file mode 100644
index 000000000000..bf87201ccf27
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt-ciri.dtsi"
+
+/ {
+	model = "Google Ciri sku5 board (rev4)";
+	compatible = "google,ciri-sku5", "google,ciri", "mediatek,mt8188";
+};
+
+&dsi_panel {
+	compatible = "ivo,t109nw41", "himax,hx83102";
+};
+
+&i2c0 {
+	/delete-node/ audio-codec@1a;
+	/delete-node/ amplifier@38;
+	/delete-node/ amplifier@39;
+
+	es8326: audio-codec@19 {
+		compatible = "everest,es8326";
+		reg = <0x19>;
+		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_codec_pins>;
+		#sound-dai-cells = <0>;
+		everest,jack-pol = [0e];
+		everest,interrupt-clk = [00];
+	};
+
+	tas2563: amplifier@4f {
+		compatible = "ti,tas2563", "ti,tas2781";
+		reg = <0x4f>, <0x4c>; /* left / right channel */
+		reset-gpios = <&pio 118 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&sound {
+	compatible = "mediatek,mt8188-es8326";
+	model = "mt8188_tas2563_8326";
+
+	audio-routing =
+		"ETDM1_OUT", "ETDM_SPK_PIN",
+		"ETDM2_OUT", "ETDM_HP_PIN",
+		"ETDM1_IN", "ETDM_SPK_PIN",
+		"ETDM2_IN", "ETDM_HP_PIN",
+		"ADDA Capture", "MTKAIF_PIN",
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR",
+		"MIC1", "Headset Mic";
+
+	dai-link-1 {
+		codec {
+			sound-dai = <&tas2563>;
+		};
+	};
+
+	dai-link-2 {
+		codec {
+			sound-dai = <&es8326>;
+		};
+	};
+
+	dai-link-3 {
+		codec {
+			sound-dai = <&es8326>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
new file mode 100644
index 000000000000..17d7359dfb6a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt-ciri.dtsi"
+
+/ {
+	model = "Google Ciri sku6 board (rev4)";
+	compatible = "google,ciri-sku6", "google,ciri", "mediatek,mt8188";
+};
+
+&dsi_panel {
+	compatible = "boe,nv110wum-l60", "himax,hx83102";
+};
+
+&i2c0 {
+	/delete-node/ audio-codec@1a;
+	/delete-node/ amplifier@38;
+	/delete-node/ amplifier@39;
+
+	es8326: audio-codec@19 {
+		compatible = "everest,es8326";
+		reg = <0x19>;
+		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_codec_pins>;
+		#sound-dai-cells = <0>;
+		everest,jack-pol = [0e];
+		everest,interrupt-clk = [00];
+	};
+
+	tas2563: amplifier@4f {
+		compatible = "ti,tas2563", "ti,tas2781";
+		reg = <0x4f>, <0x4c>; /* left / right channel */
+		reset-gpios = <&pio 118 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&sound {
+	compatible = "mediatek,mt8188-es8326";
+	model = "mt8188_tas2563_8326";
+
+	audio-routing =
+		"ETDM1_OUT", "ETDM_SPK_PIN",
+		"ETDM2_OUT", "ETDM_HP_PIN",
+		"ETDM1_IN", "ETDM_SPK_PIN",
+		"ETDM2_IN", "ETDM_HP_PIN",
+		"ADDA Capture", "MTKAIF_PIN",
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR",
+		"MIC1", "Headset Mic";
+
+	dai-link-1 {
+		codec {
+			sound-dai = <&tas2563>;
+		};
+	};
+
+	dai-link-2 {
+		codec {
+			sound-dai = <&es8326>;
+		};
+	};
+
+	dai-link-3 {
+		codec {
+			sound-dai = <&es8326>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
new file mode 100644
index 000000000000..825015b452d5
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt-ciri.dtsi"
+
+/ {
+	model = "Google Ciri sku7 board (rev4)";
+	compatible = "google,ciri-sku7", "google,ciri", "mediatek,mt8188";
+};
+
+&dsi_panel {
+	compatible = "ivo,t109nw41", "himax,hx83102";
+};
+
+&i2c0 {
+	/delete-node/ amplifier@38;
+	/delete-node/ amplifier@39;
+
+	tas2563: amplifier@4f {
+		compatible = "ti,tas2563", "ti,tas2781";
+		reg = <0x4f>, <0x4c>; /* left / right channel */
+		reset-gpios = <&pio 118 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&sound {
+	compatible = "mediatek,mt8188-rt5682s";
+	model = "mt8188_tas2563_5682";
+
+	audio-routing =
+		"ETDM1_OUT", "ETDM_SPK_PIN",
+		"ETDM2_OUT", "ETDM_HP_PIN",
+		"ETDM1_IN", "ETDM_SPK_PIN",
+		"ETDM2_IN", "ETDM_HP_PIN",
+		"ADDA Capture", "MTKAIF_PIN",
+		"Headphone Jack", "HPOL",
+		"Headphone Jack", "HPOR",
+		"IN1P", "Headset Mic";
+
+	dai-link-1 {
+		codec {
+			sound-dai = <&tas2563>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
new file mode 100644
index 000000000000..6815c435a57e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2023 Google LLC
+ */
+/dts-v1/;
+#include "mt8188-geralt.dtsi"
+
+&aud_etdm_hp_on {
+	pins-mclk {
+		pinmux = <PINMUX_GPIO114__FUNC_O_I2SO2_MCK>;
+	};
+};
+
+&aud_etdm_hp_off {
+	pins-mclk {
+		pinmux = <PINMUX_GPIO114__FUNC_B_GPIO114>;
+		bias-pull-down;
+		input-enable;
+	};
+};
+
+&i2c0 {
+	rt5682s: audio-codec@1a {
+		compatible = "realtek,rt5682s";
+		reg = <0x1a>;
+		interrupts-extended = <&pio 108 IRQ_TYPE_EDGE_BOTH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_codec_pins>;
+		#sound-dai-cells = <1>;
+
+		AVDD-supply = <&mt6359_vio18_ldo_reg>;
+		DBVDD-supply = <&mt6359_vio18_ldo_reg>;
+		LDO1-IN-supply = <&mt6359_vio18_ldo_reg>;
+		MICVDD-supply = <&pp3300_s3>;
+		realtek,jd-src = <1>;
+	};
+
+	max98390_38: amplifier@38 {
+		compatible = "maxim,max98390";
+		reg = <0x38>;
+		sound-name-prefix = "Front Right";
+		reset-gpios = <&pio 118 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&speaker_en>;
+		#sound-dai-cells = <0>;
+	};
+
+	max98390_39: amplifier@39 {
+		compatible = "maxim,max98390";
+		reg = <0x39>;
+		sound-name-prefix = "Front Left";
+		#sound-dai-cells = <0>;
+	};
+};
+
+&i2c_tunnel {
+	/*
+	 * The virtual battery I2C addr is 0xf on Ciri, so we describe it
+	 * manually instead of including 'arm/cros-ec-sbs.dtsi'.
+	 **/
+	battery: sbs-battery@f {
+		compatible = "sbs,sbs-battery";
+		reg = <0xf>;
+		sbs,i2c-retry-count = <2>;
+		sbs,poll-retry-count = <1>;
+	};
+};
+
+&mipi_tx_config0 {
+	drive-strength-microamp = <5200>;
+};
+
+&mt6359_vm18_ldo_reg {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1900000>;
+	regulator-microvolt-offset = <100000>;
+};
+
+&sound {
+	dai-link-0 {
+		link-name = "ETDM1_IN_BE";
+		dai-format = "i2s";
+		mediatek,clk-provider = "cpu";
+	};
+
+	dai-link-1 {
+		link-name = "ETDM1_OUT_BE";
+		dai-format = "i2s";
+		mediatek,clk-provider = "cpu";
+
+		codec {
+			sound-dai = <&max98390_38>,
+				    <&max98390_39>;
+		};
+	};
+
+	dai-link-2 {
+		link-name = "ETDM2_IN_BE";
+		mediatek,clk-provider = "cpu";
+
+		codec {
+			sound-dai = <&rt5682s 0>;
+		};
+	};
+
+	dai-link-3 {
+		link-name = "ETDM2_OUT_BE";
+		mediatek,clk-provider = "cpu";
+
+		codec {
+			sound-dai = <&rt5682s 0>;
+		};
+	};
+
+	dai-link-4 {
+		link-name = "DPTX_BE";
+
+		codec {
+			sound-dai = <&dp_tx>;
+		};
+	};
+};
+
+&pio {
+	gpio-line-names =
+		"GSC_AP_INT_ODL",
+		"AP_DISP_BKLTEN",
+		"",
+		"EN_PPVAR_MIPI_DISP",
+		"EN_PPVAR_MIPI_DISP_150MA",
+		"TCHSCR_RST_1V8_L",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"I2S_SPKR_DATAOUT",
+		"EN_PP3300_WLAN_X",
+		"WIFI_KILL_1V8_L",
+		"BT_KILL_1V8_L",
+		"AP_FLASH_WP_L", /* ... is crossystem ABI. Rev1 schematics call it AP_WP_ODL. */
+		"",
+		"",
+		"WCAM_PWDN_L",
+		"WCAM_RST_L",
+		"UCAM_PWDM_L",
+		"UCAM_RST_L",
+		"WCAM_24M_CLK",
+		"UCAM_24M_CLK",
+		"MT6319_INT",
+		"DISP_RST_1V8_L",
+		"DSIO_DSI_TE",
+		"",
+		"TP",
+		"MIPI_BL_PWM_1V8",
+		"",
+		"UART_AP_TX_GSC_RX",
+		"UART_GSC_TX_AP_RX",
+		"UART_SSPM_TX_DBGCON_RX",
+		"UART_DBGCON_TX_SSPM_RX",
+		"UART_ADSP_TX_DBGCON_RX",
+		"UART_DBGCON_TX_ADSP_RX",
+		"JTAG_AP_TMS",
+		"JTAG_AP_TCK",
+		"JTAG_AP_TDI",
+		"JTAG_AP_TDO",
+		"JTAG_AP_TRST",
+		"AP_KPCOL0",
+		"TP",
+		"",
+		"TP",
+		"EC_AP_HPD_OD",
+		"PCIE_WAKE_1V8_ODL",
+		"PCIE_RST_1V8_L",
+		"PCIE_CLKREQ_1V8_ODL",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"AP_I2C_AUD_SCL_1V8",
+		"AP_I2C_AUD_SDA_1V8",
+		"AP_I2C_TPM_SCL_1V8",
+		"AP_I2C_TPM_SDA_1V8",
+		"AP_I2C_TCHSCR_SCL_1V8",
+		"AP_I2C_TCHSCR_SDA_1V8",
+		"AP_I2C_PMIC_SAR_SCL_1V8",
+		"AP_I2C_PMIC_SAR_SDA_1V8",
+		"AP_I2C_EC_HID_KB_SCL_1V8",
+		"AP_I2C_EC_HID_KB_SDA_1V8",
+		"AP_I2C_UCAM_SCL_1V8",
+		"AP_I2C_UCAM_SDA_1V8",
+		"AP_I2C_WCAM_SCL_1V8",
+		"AP_I2C_WCAM_SDA_1V8",
+		"SPI_AP_CS_EC_L",
+		"SPI_AP_CLK_EC",
+		"SPI_AP_DO_EC_DI",
+		"SPI_AP_DI_EC_DO",
+		"TP",
+		"TP",
+		"SPI_AP_CS_TCHSCR_L",
+		"SPI_AP_CLK_TCHSCR",
+		"SPI_AP_DO_TCHSCR_DI",
+		"SPI_AP_DI_TCHSCR_DO",
+		"TP",
+		"TP",
+		"TP",
+		"TP",
+		"",
+		"",
+		"",
+		"TP",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"PWRAP_SPI_CS_L",
+		"PWRAP_SPI_CK",
+		"PWRAP_SPI_MOSI",
+		"PWRAP_SPI_MISO",
+		"SRCLKENA0",
+		"SRCLKENA1",
+		"SCP_VREQ_VAO",
+		"AP_RTC_CLK32K",
+		"AP_PMIC_WDTRST_L",
+		"AUD_CLK_MOSI",
+		"AUD_SYNC_MOSI",
+		"AUD_DAT_MOSI0",
+		"AUD_DAT_MOSI1",
+		"AUD_DAT_MISO0",
+		"AUD_DAT_MISO1",
+		"",
+		"HP_INT_ODL",
+		"SPKR_INT_ODL",
+		"I2S_HP_DATAIN",
+		"EN_SPKR",
+		"I2S_SPKR_MCLK",
+		"I2S_SPKR_BCLK",
+		"I2S_HP_MCLK",
+		"I2S_HP_BCLK",
+		"I2S_HP_LRCK",
+		"I2S_HP_DATAOUT",
+		"RST_SPKR_L",
+		"I2S_SPKR_LRCK",
+		"I2S_SPKR_DATAIN",
+		"",
+		"",
+		"",
+		"",
+		"SPI_AP_CLK_ROM",
+		"SPI_AP_CS_ROM_L",
+		"SPI_AP_DO_ROM_DI",
+		"SPI_AP_DI_ROM_DO",
+		"TP",
+		"TP",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"EN_PP2800A_UCAM_X",
+		"EN_PP1200_UCAM_X",
+		"EN_PP2800A_WCAM_X",
+		"EN_PP1100_WCAM_X",
+		"TCHSCR_INT_1V8_L",
+		"",
+		"MT7921_PMU_EN_1V8",
+		"",
+		"AP_EC_WARM_RST_REQ",
+		"EC_AP_HID_INT_ODL",
+		"EC_AP_INT_ODL",
+		"AP_XHCI_INIT_DONE",
+		"EMMC_DAT7",
+		"EMMC_DAT6",
+		"EMMC_DAT5",
+		"EMMC_DAT4",
+		"EMMC_RST_L",
+		"EMMC_CMD",
+		"EMMC_CLK",
+		"EMMC_DAT3",
+		"EMMC_DAT2",
+		"EMMC_DAT1",
+		"EMMC_DAT0",
+		"EMMC_DSL",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"USB3_HUB_RST_L",
+		"EC_AP_RSVD0_ODL",
+		"",
+		"",
+		"SPMI_SCL",
+		"SPMI_SDA";
+
+	audio_codec_pins: audio-codec-pins {
+		pins-hp-int-odl {
+			pinmux = <PINMUX_GPIO108__FUNC_B_GPIO108>;
+			input-enable;
+		};
+	};
+
+	speaker_en: speaker-en-pins {
+		pins-en-spkr {
+			pinmux = <PINMUX_GPIO111__FUNC_B_GPIO111>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
new file mode 100644
index 000000000000..b6abecbcfa81
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -0,0 +1,1156 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include "mt8188.dtsi"
+#include "mt6359.dtsi"
+
+/ {
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		mmc0 = &mmc0;
+		serial0 = &uart0;
+	};
+
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 1023>;
+		default-brightness-level = <576>;
+		enable-gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
+		num-interpolated-steps = <1023>;
+		power-supply = <&ppvar_sys>;
+		pwms = <&disp_pwm0 0 500000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		wakeup-delay-ms = <100>;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* The size will be filled in by the bootloader */
+		reg = <0 0x40000000 0 0>;
+	};
+
+	/* system wide LDO 1.8V power rail */
+	pp1800_ldo_z1: regulator-pp1800-ldo-z1 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_ldo_z1";
+		/* controlled by PP3300_Z1 */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&pp3300_z1>;
+	};
+
+	/* separately switched 3.3V power rail */
+	pp3300_s3: regulator-pp3300-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_s3";
+		/* controlled by PMIC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&pp3300_z1>;
+	};
+
+	/* system wide 3.3V power rail */
+	pp3300_z1: regulator-pp3300-z1 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_z1";
+		/* controlled by PP3300_LDO_Z5 & EN_PWR_Z1 */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	pp3300_wlan: regulator-pp3300-wlan {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_wlan";
+		regulator-always-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&wlan_en>;
+		pinctrl-names = "default";
+		vin-supply = <&pp3300_z1>;
+	};
+
+	/* system wide 4.2V power rail */
+	pp4200_s5: regulator-pp4200-s5 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp4200_s5";
+		/* controlled by EC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide 5.0V power rail */
+	pp5000_z1: regulator-pp5000-z1 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp5000_z1";
+		/* controlled by EC */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	pp5000_usb_vbus: regulator-pp5000-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "pp5000_usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 150 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&pp5000_z1>;
+	};
+
+	/* system wide semi-regulated power rail from battery or USB */
+	ppvar_sys: regulator-ppvar-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	ppvar_mipi_disp_avdd: regulator-ppvar-mipi-disp-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_mipi_disp_avdd";
+		enable-active-high;
+		gpio = <&pio 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mipi_disp_avdd_en>;
+		vin-supply = <&pp5000_z1>;
+	};
+
+	ppvar_mipi_disp_avee: regulator-ppvar-mipi-disp-avee {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_mipi_disp_avee";
+		regulator-enable-ramp-delay = <10000>;
+		enable-active-high;
+		gpio = <&pio 4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mipi_disp_avee_en>;
+		vin-supply = <&pp5000_z1>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		apu_mem: memory@55000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x55000000 0 0x1400000>;
+		};
+
+		adsp_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0xf00000>;
+			no-map;
+		};
+
+		afe_dma_mem: memory@60f00000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60f00000 0 0x100000>;
+			no-map;
+		};
+
+		adsp_dma_mem: memory@61000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x61000000 0 0x100000>;
+			no-map;
+		};
+	};
+};
+
+&adsp {
+	memory-region = <&adsp_dma_mem>, <&adsp_mem>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&adsp_uart_pins>;
+	status = "okay";
+};
+
+&afe {
+	memory-region = <&afe_dma_mem>;
+	mediatek,etdm-out1-cowork-source = <0>; /* in1 */
+	mediatek,etdm-in2-cowork-source = <3>; /* out2 */
+	status = "okay";
+};
+
+&auxadc {
+	status = "okay";
+};
+
+&cam_vcore {
+	domain-supply = <&mt6359_vproc1_buck_reg>;
+};
+
+/*
+ * Geralt is the reference design and doesn't have target TDP.
+ * Ciri is (currently) the only device following Geralt, and its
+ * TDP target is 90 degrees.
+ **/
+&cpu_little0_alert0 {
+	temperature = <90000>;
+	hysteresis = <2000>;
+	type = "passive";
+};
+
+&cpu_little1_alert0 {
+	temperature = <90000>;
+	hysteresis = <2000>;
+	type = "passive";
+};
+
+&cpu_little2_alert0 {
+	temperature = <90000>;
+	hysteresis = <2000>;
+	type = "passive";
+};
+
+&cpu_little3_alert0 {
+	temperature = <90000>;
+	hysteresis = <2000>;
+	type = "passive";
+};
+
+&cpu_big0_alert0 {
+	temperature = <90000>;
+	hysteresis = <2000>;
+	type = "passive";
+};
+
+&cpu_big1_alert0 {
+	temperature = <90000>;
+	hysteresis = <2000>;
+	type = "passive";
+};
+
+&disp_dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	dsi_panel: panel@0 {
+		/* Compatible string for different panels can be found in each device dts */
+		reg = <0>;
+		enable-gpios = <&pio 25 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mipi_dsi_pins>;
+
+		backlight = <&backlight_lcd0>;
+		avdd-supply = <&ppvar_mipi_disp_avdd>;
+		avee-supply = <&ppvar_mipi_disp_avee>;
+		pp1800-supply = <&mt6359_vm18_ldo_reg>;
+		rotation = <270>;
+
+		status = "okay";
+
+		port {
+			dsi_panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+
+	port {
+		dsi_out: endpoint {
+			remote-endpoint = <&dsi_panel_in>;
+		};
+	};
+};
+
+&disp_pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm0_pins>;
+	status = "okay";
+};
+
+&disp_pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm1_pins>;
+};
+
+&dp_intf1 {
+	status = "okay";
+
+	port {
+		dp_intf1_out: endpoint {
+			remote-endpoint = <&dptx_in>;
+		};
+	};
+};
+
+&dp_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp_tx_hpd>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			dptx_in: endpoint {
+				remote-endpoint = <&dp_intf1_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			dptx_out: endpoint {
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+};
+
+&gpu {
+	mali-supply = <&mt6359_vproc2_buck_reg>;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tpm@50 {
+		compatible = "google,cr50";
+		reg = <0x50>;
+		interrupts-extended = <&pio 0 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gsc_int>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&mfg0 {
+	domain-supply = <&mt6359_vproc2_buck_reg>;
+};
+
+&mfg1 {
+	domain-supply = <&mt6359_vsram_others_ldo_reg>;
+};
+
+&mipi_tx_config0 {
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	hs400-ds-delay = <0x1481b>;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	supports-cqe;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+	status = "okay";
+};
+
+&mt6359codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+	mediatek,mic-type-0 = <2>; /* DMIC */
+	mediatek,mic-type-2 = <2>; /* DMIC */
+};
+
+&mt6359_vcore_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_sshub_buck_reg {
+	regulator-min-microvolt = <550000>;
+	regulator-max-microvolt = <550000>;
+	regulator-always-on;
+};
+
+&mt6359_vio28_ldo_reg {
+	/delete-property/ regulator-always-on;
+};
+
+&mt6359_vm18_ldo_reg {
+	/delete-property/ regulator-always-on;
+};
+
+&mt6359_vmodem_buck_reg {
+	regulator-min-microvolt = <775000>;
+	regulator-max-microvolt = <775000>;
+};
+
+&mt6359_vpa_buck_reg {
+	regulator-max-microvolt = <3100000>;
+};
+
+&mt6359_vproc2_buck_reg {
+	/*
+	 * Called "ppvar_dvdd_gpu" in the schematic. Renamed to
+	 * "ppvar_dvdd_vgpu" here to match mtk-regulator-coupler requirements.
+	 */
+	regulator-name = "ppvar_dvdd_vgpu";
+	regulator-min-microvolt = <550000>;
+	regulator-max-microvolt = <800000>;
+	regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
+	regulator-coupled-max-spread = <6250>;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_md_ldo_reg {
+	regulator-min-microvolt = <800000>;
+	regulator-max-microvolt = <800000>;
+};
+
+&mt6359_vsram_others_ldo_reg {
+	regulator-name = "pp0850_dvdd_sram_gpu";
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <800000>;
+	regulator-coupled-with = <&mt6359_vproc2_buck_reg>;
+	regulator-coupled-max-spread = <6250>;
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-always-on;
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+};
+
+&pciephy {
+	status = "okay";
+};
+
+&pio {
+	gpio-line-names =
+		"gsc_int",
+		"AP_DISP_BKLTEN",
+		"",
+		"EN_PPVAR_MIPI_DISP",
+		"EN_PPVAR_MIPI_DISP_150MA",
+		"TCHSCR_RST_1V8_L",
+		"TCHSRC_REPORT_DISABLE",
+		"",
+		"",
+		"",
+		"",
+		"I2S_SPKR_DATAOUT",
+		"EN_PP3300_WLAN_X",
+		"WIFI_KILL_1V8_L",
+		"BT_KILL_1V8_L",
+		"AP_FLASH_WP_L", /* ... is crossystem ABI. Rev1 schematics call it AP_WP_ODL. */
+		"",
+		"EDP_HPD_1V8",
+		"WCAM_PWDN_L",
+		"WCAM_RST_L",
+		"UCAM_PWDM_L",
+		"UCAM_RST_L",
+		"WCAM_24M_CLK",
+		"UCAM_24M_CLK",
+		"MT6319_INT",
+		"DISP_RST_1V8_L",
+		"DSIO_DSI_TE",
+		"EN_PP3300_EDP_DISP_X",
+		"TP",
+		"MIPI_BL_PWM_1V8",
+		"EDP_BL_PWM_1V8",
+		"UART_AP_TX_GSC_RX",
+		"UART_GSC_TX_AP_RX",
+		"UART_SSPM_TX_DBGCON_RX",
+		"UART_DBGCON_TX_SSPM_RX",
+		"UART_ADSP_TX_DBGCON_RX",
+		"UART_DBGCON_TX_ADSP_RX",
+		"JTAG_AP_TMS",
+		"JTAG_AP_TCK",
+		"JTAG_AP_TDI",
+		"JTAG_AP_TDO",
+		"JTAG_AP_TRST",
+		"AP_KPCOL0",
+		"TP",
+		"BEEP_ON_OD",
+		"TP",
+		"EC_AP_HPD_OD",
+		"PCIE_WAKE_1V8_ODL",
+		"PCIE_RST_1V8_L",
+		"PCIE_CLKREQ_1V8_ODL",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"AP_I2C_AUD_SCL_1V8",
+		"AP_I2C_AUD_SDA_1V8",
+		"AP_I2C_TPM_SCL_1V8",
+		"AP_I2C_TPM_SDA_1V8",
+		"AP_I2C_TCHSCR_SCL_1V8",
+		"AP_I2C_TCHSCR_SDA_1V8",
+		"AP_I2C_PMIC_SAR_SCL_1V8",
+		"AP_I2C_PMIC_SAR_SDA_1V8",
+		"AP_I2C_EC_HID_KB_SCL_1V8",
+		"AP_I2C_EC_HID_KB_SDA_1V8",
+		"AP_I2C_UCAM_SCL_1V8",
+		"AP_I2C_UCAM_SDA_1V8",
+		"AP_I2C_WCAM_SCL_1V8",
+		"AP_I2C_WCAM_SDA_1V8",
+		"SPI_AP_CS_EC_L",
+		"SPI_AP_CLK_EC",
+		"SPI_AP_DO_EC_DI",
+		"SPI_AP_DI_EC_DO",
+		"TP",
+		"TP",
+		"SPI_AP_CS_TCHSCR_L",
+		"SPI_AP_CLK_TCHSCR",
+		"SPI_AP_DO_TCHSCR_DI",
+		"SPI_AP_DI_TCHSCR_DO",
+		"TP",
+		"TP",
+		"TP",
+		"TP",
+		"",
+		"",
+		"",
+		"TP",
+		"",
+		"SAR_INT_ODL",
+		"",
+		"",
+		"",
+		"PWRAP_SPI_CS_L",
+		"PWRAP_SPI_CK",
+		"PWRAP_SPI_MOSI",
+		"PWRAP_SPI_MISO",
+		"SRCLKENA0",
+		"SRCLKENA1",
+		"SCP_VREQ_VAO",
+		"AP_RTC_CLK32K",
+		"AP_PMIC_WDTRST_L",
+		"AUD_CLK_MOSI",
+		"AUD_SYNC_MOSI",
+		"AUD_DAT_MOSI0",
+		"AUD_DAT_MOSI1",
+		"AUD_DAT_MISO0",
+		"AUD_DAT_MISO1",
+		"SD_CD_ODL",
+		"HP_INT_ODL",
+		"SPKR_INT_ODL",
+		"I2S_HP_DATAIN",
+		"EN_SPKR",
+		"I2S_SPKR_MCLK",
+		"I2S_SPKR_BCLK",
+		"I2S_HP_MCLK",
+		"I2S_HP_BCLK",
+		"I2S_HP_LRCK",
+		"I2S_HP_DATAOUT",
+		"RST_SPKR_L",
+		"I2S_SPKR_LRCK",
+		"I2S_SPKR_DATAIN",
+		"",
+		"",
+		"",
+		"",
+		"SPI_AP_CLK_ROM",
+		"SPI_AP_CS_ROM_L",
+		"SPI_AP_DO_ROM_DI",
+		"SPI_AP_DI_ROM_DO",
+		"TP",
+		"TP",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"EN_PP2800A_UCAM_X",
+		"EN_PP1200_UCAM_X",
+		"EN_PP2800A_WCAM_X",
+		"EN_PP1100_WCAM_X",
+		"TCHSCR_INT_1V8_L",
+		"EN_PP3300_MIPI_TCHSCR_X",
+		"MT7921_PMU_EN_1V8",
+		"EN_PP3300_EDP_TCHSCR_X",
+		"AP_EC_WARM_RST_REQ",
+		"EC_AP_HID_INT_ODL",
+		"EC_AP_INT_ODL",
+		"AP_XHCI_INIT_DONE",
+		"EMMC_DAT7",
+		"EMMC_DAT6",
+		"EMMC_DAT5",
+		"EMMC_DAT4",
+		"EMMC_RST_L",
+		"EMMC_CMD",
+		"EMMC_CLK",
+		"EMMC_DAT3",
+		"EMMC_DAT2",
+		"EMMC_DAT1",
+		"EMMC_DAT0",
+		"EMMC_DSL",
+		"SD_CMD",
+		"SD_CLK",
+		"SD_DAT0",
+		"SD_DAT1",
+		"SD_DAT2",
+		"SD_DAT3",
+		"",
+		"",
+		"USB3_HUB_RST_L",
+		"EC_AP_RSVD0_ODL",
+		"",
+		"",
+		"SPMI_SCL",
+		"SPMI_SDA";
+
+	adsp_uart_pins: adsp-uart-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO35__FUNC_O_ADSP_UTXD0>,
+				 <PINMUX_GPIO36__FUNC_I1_ADSP_URXD0>;
+		};
+	};
+
+	aud_etdm_hp_on: aud-etdm-hp-on-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO110__FUNC_I0_I2SIN_D0>,
+				 <PINMUX_GPIO115__FUNC_B0_I2SO2_BCK>,
+				 <PINMUX_GPIO116__FUNC_B0_I2SO2_WS>,
+				 <PINMUX_GPIO117__FUNC_O_I2SO2_D0>;
+		};
+	};
+
+	aud_etdm_hp_off: aud-etdm-hp-off-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO110__FUNC_B_GPIO110>,
+				 <PINMUX_GPIO115__FUNC_B_GPIO115>,
+				 <PINMUX_GPIO116__FUNC_B_GPIO116>,
+				 <PINMUX_GPIO117__FUNC_B_GPIO117>;
+			bias-pull-down;
+			input-enable;
+		};
+	};
+
+	aud_etdm_spk_on: aud-etdm-spk-on-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO11__FUNC_O_I2SO1_D0>,
+				 <PINMUX_GPIO113__FUNC_B0_TDMIN_BCK>,
+				 <PINMUX_GPIO119__FUNC_B0_TDMIN_LRCK>,
+				 <PINMUX_GPIO120__FUNC_I0_TDMIN_DI>;
+			drive-strength = <8>;
+		};
+	};
+
+	aud_etdm_spk_off: aud-etdm-spk-off-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO11__FUNC_B_GPIO11>,
+				 <PINMUX_GPIO113__FUNC_B_GPIO113>,
+				 <PINMUX_GPIO119__FUNC_B_GPIO119>,
+				 <PINMUX_GPIO120__FUNC_B_GPIO120>;
+			bias-pull-down;
+			input-enable;
+		};
+	};
+
+	aud_mtkaif_on: aud-mtkaif-on-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO101__FUNC_O_AUD_CLK_MOSI>,
+				 <PINMUX_GPIO102__FUNC_O_AUD_SYNC_MOSI>,
+				 <PINMUX_GPIO103__FUNC_O_AUD_DAT_MOSI0>,
+				 <PINMUX_GPIO104__FUNC_O_AUD_DAT_MOSI1>,
+				 <PINMUX_GPIO105__FUNC_I0_AUD_DAT_MISO0>,
+				 <PINMUX_GPIO106__FUNC_I0_AUD_DAT_MISO1>;
+		};
+	};
+
+	aud_mtkaif_off: aud-mtkaif-off-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO101__FUNC_B_GPIO101>,
+				 <PINMUX_GPIO102__FUNC_B_GPIO102>,
+				 <PINMUX_GPIO103__FUNC_B_GPIO103>,
+				 <PINMUX_GPIO104__FUNC_B_GPIO104>,
+				 <PINMUX_GPIO105__FUNC_B_GPIO105>,
+				 <PINMUX_GPIO106__FUNC_B_GPIO106>;
+			bias-pull-down;
+			input-enable;
+		};
+	};
+
+	cros_ec_int: cros-ec-int-pins {
+		pins-ec-ap-int-odl {
+			pinmux = <PINMUX_GPIO149__FUNC_B_GPIO149>;
+			input-enable;
+		};
+	};
+
+	disp_pwm0_pins: disp-pwm0-pins {
+		pins-disp-pwm0 {
+			pinmux = <PINMUX_GPIO29__FUNC_O_DISP_PWM0>;
+			output-high;
+		};
+	};
+
+	disp_pwm1_pins: disp-pwm1-pins {
+		pins-disp-pwm1 {
+			pinmux = <PINMUX_GPIO30__FUNC_O_DISP_PWM1>;
+			output-high;
+		};
+	};
+
+	dp_tx_hpd: dp-tx-hpd-pins {
+		pins-dp-tx-hpd {
+			pinmux = <PINMUX_GPIO46__FUNC_I0_DP_TX_HPD>;
+		};
+	};
+
+	gsc_int: gsc-int-pins {
+		pins-gsc-ap-int-odl {
+			pinmux = <PINMUX_GPIO0__FUNC_B_GPIO0>;
+			input-enable;
+		};
+	};
+
+	i2c0_pins: i2c0-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>,
+				 <PINMUX_GPIO55__FUNC_B1_SCL0>;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO58__FUNC_B1_SDA1>,
+				 <PINMUX_GPIO57__FUNC_B1_SCL1>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO60__FUNC_B1_SDA2>,
+				 <PINMUX_GPIO59__FUNC_B1_SCL2>;
+			bias-disable;
+			drive-strength = <12>;
+		};
+	};
+
+	i2c3_pins: i2c3-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO62__FUNC_B1_SDA3>,
+				 <PINMUX_GPIO61__FUNC_B1_SCL3>;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO64__FUNC_B1_SDA4>,
+				 <PINMUX_GPIO63__FUNC_B1_SCL4>;
+		};
+	};
+
+	i2c5_pins: i2c5-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO66__FUNC_B1_SDA5>,
+				 <PINMUX_GPIO65__FUNC_B1_SCL5>;
+		};
+	};
+
+	i2c6_pins: i2c6-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO68__FUNC_B1_SDA6>,
+				 <PINMUX_GPIO67__FUNC_B1_SCL6>;
+		};
+	};
+
+	mipi_disp_avdd_en: mipi-disp-avdd-en-pins {
+		pins-en-ppvar-mipi-disp {
+			pinmux = <PINMUX_GPIO3__FUNC_B_GPIO3>;
+			output-low;
+		};
+	};
+
+	mipi_disp_avee_en: mipi-disp-avee-en-pins {
+		pins-en-ppvar-mipi-disp-150ma {
+			pinmux = <PINMUX_GPIO4__FUNC_B_GPIO4>;
+			output-low;
+		};
+	};
+
+	mipi_dsi_pins: mipi-dsi-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO1__FUNC_B_GPIO1>,
+				 <PINMUX_GPIO25__FUNC_B_GPIO25>;
+			output-low;
+		};
+	};
+
+	mmc0_pins_default: mmc0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
+				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
+				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
+				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
+				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
+				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
+				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
+				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
+				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
+				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
+				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
+				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
+				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
+				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
+				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
+				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
+				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	nor_pins: nor-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO127__FUNC_B0_SPINOR_IO0>,
+				 <PINMUX_GPIO125__FUNC_O_SPINOR_CK>,
+				 <PINMUX_GPIO128__FUNC_B0_SPINOR_IO1>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO126__FUNC_O_SPINOR_CS>;
+			bias-pull-up;
+		};
+	};
+
+	pcie_pins: pcie-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO47__FUNC_I1_WAKEN>,
+				 <PINMUX_GPIO48__FUNC_O_PERSTN>,
+				 <PINMUX_GPIO49__FUNC_B1_CLKREQN>;
+		};
+	};
+
+	spi0_pins: spi0-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
+				 <PINMUX_GPIO70__FUNC_O_SPIM0_CLK>,
+				 <PINMUX_GPIO71__FUNC_B0_SPIM0_MOSI>,
+				 <PINMUX_GPIO72__FUNC_B0_SPIM0_MISO>;
+			bias-disable;
+		};
+	};
+
+	spi1_pins_default: spi1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
+				 <PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
+				 <PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>,
+				 <PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
+			bias-disable;
+		};
+	};
+
+	spi1_pins_sleep: spi1-sleep-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO75__FUNC_B_GPIO75>,
+				 <PINMUX_GPIO76__FUNC_B_GPIO76>,
+				 <PINMUX_GPIO77__FUNC_B_GPIO77>,
+				 <PINMUX_GPIO78__FUNC_B_GPIO78>;
+			bias-pull-down;
+			input-enable;
+		};
+	};
+
+	spi2_pins: spi2-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO79__FUNC_O_SPIM2_CSB>,
+				 <PINMUX_GPIO80__FUNC_O_SPIM2_CLK>,
+				 <PINMUX_GPIO81__FUNC_B0_SPIM2_MOSI>,
+				 <PINMUX_GPIO82__FUNC_B0_SPIM2_MISO>;
+			bias-disable;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO31__FUNC_O_UTXD0>,
+				 <PINMUX_GPIO32__FUNC_I1_URXD0>;
+			bias-pull-up;
+		};
+	};
+
+	wlan_en: wlan-en-pins {
+		pins-en-pp3300-wlan {
+			pinmux = <PINMUX_GPIO12__FUNC_B_GPIO12>;
+			output-low;
+		};
+	};
+};
+
+&pmic {
+	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&sound {
+	pinctrl-names = "aud_etdm_hp_on", "aud_etdm_hp_off",
+			"aud_etdm_spk_on", "aud_etdm_spk_off",
+			"aud_mtkaif_on", "aud_mtkaif_off";
+	pinctrl-0 = <&aud_etdm_hp_on>;
+	pinctrl-1 = <&aud_etdm_hp_off>;
+	pinctrl-2 = <&aud_etdm_spk_on>;
+	pinctrl-3 = <&aud_etdm_spk_off>;
+	pinctrl-4 = <&aud_mtkaif_on>;
+	pinctrl-5 = <&aud_mtkaif_off>;
+	mediatek,adsp = <&adsp>;
+	/* The audio-routing is defined in each board dts */
+
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	status = "okay";
+
+	cros_ec: ec@0 {
+		compatible = "google,cros-ec-spi";
+		reg = <0>;
+		interrupts-extended = <&pio 149 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cros_ec_int>;
+		spi-max-frequency = <3000000>;
+
+		i2c_tunnel: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			google,remote-bus = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		cbas {
+			compatible = "google,cros-cbas";
+		};
+	};
+};
+
+&spi1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&spi1_pins_default>;
+	pinctrl-1 = <&spi1_pins_sleep>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
+/* USB detachable base */
+&xhci0 {
+	/* controlled by EC */
+	vbus-supply = <&pp3300_z1>;
+	status = "okay";
+};
+
+/* USB3 hub */
+&xhci1 {
+	vusb33-supply = <&pp3300_s3>;
+	vbus-supply = <&pp5000_usb_vbus>;
+	status = "okay";
+};
+
+/* USB BT */
+&xhci2 {
+	/* no power supply since MT7921's power is controlled by PCIe */
+	/* MT7921's USB BT has issues with USB2 LPM */
+	usb2-lpm-disable;
+	status = "okay";
+};
+
+#include <arm/cros-ec-keyboard.dtsi>
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
+		MATRIX_KEY(0x03, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x01, 0x04, KEY_MICMUTE)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
-- 
2.47.0.371.ga323438b13-goog


