Return-Path: <linux-kernel+bounces-259859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ADA939E55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF6228313D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2F14D45E;
	Tue, 23 Jul 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lMOyT6Sh"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AC14D2B2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728636; cv=none; b=Oe//53iETyOCPDQuwQTrRk8NBgEtvH8s9wIeH4oNcaz2CiXwr/JRcRMEESVK+zHMO+nze38JUKqzo7xDZhlN5soZsuDpWx1vvykHFpAAn38z2J5MSEzP0/1RUQPwEj3wttbcGM06+Y1wLqHvJO3tsBCxyzwvqwWHg8RnS5qRpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728636; c=relaxed/simple;
	bh=3hT7wdmOcOTNeFewjPFZrs1nK0GheTEQ/ofYbsvh8eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xh0J4A1yaX9tV7OR+NfHPmXBx4AgQJjkKsC9T6HJXGHnvD2RyHOXDaoSALKCq1qq9Euk3e0e/Gd8DkprGPOmtq5o5utJgsTcCBKwYfjCZm8sq9zBWJTgJ0Dsr9rOkyy58L3HPXoTaXD+817pNZmU0NC81sMKn8dAkQtTeH7tre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lMOyT6Sh; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ca9835db95so2771526eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721728632; x=1722333432; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OzyMEsbjxgELLAU9H3JVgtxZaYvLlmk6+peydwG5PAI=;
        b=lMOyT6ShKA47tJT7xOmaoStkNX2P6wc6evD7WdT4eR6ii2xXpVit84oXNapP651Jb0
         5INRHK1On7k9wb1TuMa4tPAXNJrJxTX4eQWND0CNh/pDXx/w+LC3gxfpeB2EQMCKE1NT
         yPmYOLKSiltS2p83zvyyEOYUXFQsNLqiBZWtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721728632; x=1722333432;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzyMEsbjxgELLAU9H3JVgtxZaYvLlmk6+peydwG5PAI=;
        b=JctPM+qwODnOvz0Vx1EBxs+hZ6Otn24mAyqirlyp3Kg6eQ4Az4/mXHo79WTptqfWsV
         CexN5u3iFcC5VvCgUk6XfWXXjcAw+VsopGExsAdMjnmCAPjUvPCbuBdEi7vVsAXRd1ZC
         AB84+Y+0uy2Y+JpSMzdPOiy7nDYzi32bMs79R3THGRIitattTCKqHrUmgdNXG9bEIO/8
         dPlnYK7OJ/wTwQqeRxACrch1iYMyDMkdW7+jlg+Kpg7Y9pzNNun54C4IKy6R2mNX+kkh
         Q7yOexOV3oUfXpbfQ8Facv3ZBMH1tPbYtiBPfDgQULLkSSllfzXKaSH4aNrKCyKLiaRp
         Y3mw==
X-Forwarded-Encrypted: i=1; AJvYcCUeKUJsUDs4rR67JEA7ib23/5BgAXfSaNI0ORAahwmdVzaCI9N/kFiQfcdh5IjP2KEOsKMe7JJabkCMmDCQAY6aPPGO37Ue9B/BFcZN
X-Gm-Message-State: AOJu0YwRGQYqZKiJ39ffb+spx8ttLyWtzmJ2WUNWnv9XWdC4MUSZ7y5c
	PE06wt7KaZE/kxgbll3jel36Sc8xUwAMIjAea0JO1zYTOKr7P9QVVBgZcftliw==
X-Google-Smtp-Source: AGHT+IHDnnxHuI9E06J5YQVs42SxY8MGajBowmzWGUirw5K4mNGoo+X6VpjzSBMPCAM4HXho8gKsfg==
X-Received: by 2002:a05:6358:3392:b0:1aa:a01a:23dc with SMTP id e5c5f4694b2df-1acc5b1f268mr1130147855d.15.1721728632189;
        Tue, 23 Jul 2024 02:57:12 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (46.165.189.35.bc.googleusercontent.com. [35.189.165.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0f546147sm5999975a12.82.2024.07.23.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 02:57:11 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 23 Jul 2024 09:56:50 +0000
Subject: [PATCH] arm64: dts: mt8183: Add kukui-jacuzzi-cerise series boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-jacuzzi_dt-v1-1-3e994a2b5e24@chromium.org>
X-B4-Tracking: v=1; b=H4sIAGF+n2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3azE5NKqqsz4lBJdA7PkFIOktBRTEyMjJaCGgqLUtMwKsGHRsbW
 1AJmNJk1cAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-a9570

Cerise is known as ASUS Chromebook CZ1.
Stern is known as ASUS Chromebook Flip CZ1.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 .../dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts   | 25 ++++++++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi  | 21 +++++++++++++
 .../dts/mediatek/mt8183-kukui-jacuzzi-stern.dts    | 35 ++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts
new file mode 100644
index 000000000000..b4f4ed701253
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-cerise.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
+
+/ {
+	model = "Google cerise board";
+	compatible = "google,cerise-sku0", "google,cerise", "mediatek,mt8183";
+};
+
+&mt6358codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+};
+
+&touchscreen {
+	status = "disabled";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_CERISE";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi
new file mode 100644
index 000000000000..087a0ef33e13
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi.dtsi"
+
+&cpu_thermal {
+	sustainable-power = <4500>; /* milliwatts */
+};
+
+&mmc1_pins_uhs {
+	pins-clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
+
+&i2c2 {
+	i2c-scl-internal-delay-ns = <13200>;
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-stern.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-stern.dts
new file mode 100644
index 000000000000..15e00feae3a9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-stern.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-cerise.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
+
+/ {
+	model = "Google stern board";
+	compatible = "google,cerise-sku1", "google,cerise", "mediatek,mt8183";
+};
+
+&mt6358codec {
+	mediatek,dmic-mode = <0>; /* two-wire */
+};
+
+&touchscreen {
+	status = "okay";
+
+	compatible = "hid-over-i2c";
+	reg = <0x10>;
+	interrupt-parent = <&pio>;
+	interrupts = <155 IRQ_TYPE_LEVEL_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&touchscreen_pins>;
+
+	post-power-on-delay-ms = <10>;
+	hid-descr-addr = <0x0001>;
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_STERN";
+};

---
base-commit: 66ebbdfdeb093e097399b1883390079cd4c3022b
change-id: 20240723-jacuzzi_dt-06cd0bfd5422

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


