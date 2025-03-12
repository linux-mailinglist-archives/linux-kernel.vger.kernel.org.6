Return-Path: <linux-kernel+bounces-557555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BFBA5DABF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52B73B3C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EF824167E;
	Wed, 12 Mar 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b6LqZD8D"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E324292B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776246; cv=none; b=Noy8xxuE4XVDR/A1b87jHsrJeFkcQkShkCWG9j4/FHjs9y9XeG9eEohd9F9ElZh58x3gznLBQekWgCVPhAwFC5ECek0E/4/RqfmINV1mvk4oVl7jQ3sq0Z2V/c5G+VSDkzMJEWCC9rpa9ALD8zSEC23S/laBbRtuzQCwfs9GA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776246; c=relaxed/simple;
	bh=005DS8QRrzpQdoXyb+W7Av4A9bD2sm0mlAHOBLREaMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPgEGydRmIf6k2fqDq+Jj9uL5WXwQ5X68F5yEFKPQjekwusmPpUsxpKkiRX8H6wNzw9inwG5P+scX+W0j8RAKxBB/jKLDWB+M3fEen/kleAIWI3jfBhETK3Wy3GxS+p9cz2Ymf436/OfsdAZ5NqHJ4CWU6LZgZuGvfdSe2LCHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b6LqZD8D; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so10153805a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741776244; x=1742381044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9Hi6z01W79t89Yzzjz+Av4u/k4zBkYFE5hgZtEL7TA=;
        b=b6LqZD8DvadWFUJlOWAOej3+1XbCeMGfUyE5AsPIR2S7QAXi4tPz8aC4CpDCkAc9Xp
         miVYZdP7xjh/QD806xK37FO5bP77Ur+tepOuv/wX0R7YaqZMxOPBFauf1Kaoy+uNeqqg
         x+z/vOf2joRXDzhMP0yHyyfAbaUe2BREKEyJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776244; x=1742381044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9Hi6z01W79t89Yzzjz+Av4u/k4zBkYFE5hgZtEL7TA=;
        b=XzbWmu0nqYqxeE6VwFX6N3Icvi/RQ/eYRfqcsCwrp5w+hII2q/ObkSAbAzjzRVDdLi
         msZZPkoq8Jrv+RPOUkyMK82LVAznPeSuyrCbAABn2gr/1nh5BuzqzpI26HLQwkM1eifc
         bj0xshP2OLwknwifVWl+aU+SnSFYphCT+rLcAq6npmUi04K3hkAqqYNT9uP+ldJPxFUq
         qHDH97PCWLN62fz0BrUbrRAOALvBXBVW4VVzn2jWIMpPdHcoImoOYL8zB3rtiSNNDcX4
         V12xPHAewVk169JZtRngvwScTjLVk/8pGobkfdT54hCJQMFxcBlftDIYn0IMahWIqa6l
         p44g==
X-Forwarded-Encrypted: i=1; AJvYcCWbab3ybByr1bLKJvJOIAqyttImzKHRDWMeSBErXxd66ZpJiAGlQfJDizr7pxm+DG7Oet4HzQYFguHvmgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUk7yy/SLHjp/qqbTedmWtjWY/IaMJN/nVTX4dzwqmfwzDNIM
	KKy0jyPHRCyzMSVafAWDSDv89wqxnnRzeTYP3sYWvN8hLH3m50il0BF1QsdSnQ==
X-Gm-Gg: ASbGncvGnpFK2znEW6Kqhyse6YrOn+V847HYlK/FZFJyVsWX5N4RMDMQRp6L0Qb+id2
	ZWDlYlgVI/KkEzZTHSpe4al50/0XaaXZ5M/F9rz+ncPWL7166Okc/Cbj7wC4E43zdID+KmFCsTn
	1LaK1bAwkXbKcW107+09YjPPEO6JzY6wNweJpytIr3lNYP6LOxgSauVZuclFEjkyWYSK2V2FlaY
	PTV28pqQ1oIrT5S3SgL+3xjTsZaxVqi8Y6UaZWHy6szHirx545N4RqBLTdUomQfnGJvjoAZURS8
	1jIRgj7ztU0FZWw82rlhfIBzHFU1Rpe7EK7xIr8tRs1DA9QgG8urfwSfoHwpDhI=
X-Google-Smtp-Source: AGHT+IHJj3ClCl0G4w7uRfbh34yNw6y58jNADTnvGcCG6MJZbH+QLxVptAl9mfKjSGMGz6TiuUUEtA==
X-Received: by 2002:a17:90a:d88d:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-300ff368043mr8303305a91.34.1741776244552;
        Wed, 12 Mar 2025 03:44:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:b5ed:b71c:fb14:a696])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3011926599csm1405675a91.35.2025.03.12.03.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:44:04 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	stable+noautosel@kernel.org
Subject: [PATCH 4/8] arm64: dts: mediatek: mt8186-steelix: Mark second source components for probing
Date: Wed, 12 Mar 2025 18:43:38 +0800
Message-ID: <20250312104344.3084425-5-wenst@chromium.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312104344.3084425-1-wenst@chromium.org>
References: <20250312104344.3084425-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steelix design has two possible trackpad component sources. Currently
they are all marked as available, along with having workarounds for
shared pinctrl muxing and GPIOs.

Instead, mark them all as "fail-needs-probe" and have the implementation
try to probe which one is present.

Also remove the shared resource workaround by moving the pinctrl entry
for the trackpad interrupt line back into the individual trackpad nodes.

Cc: <stable+noautosel@kernel.org> # Needs accompanying new driver to work
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8186-corsola-steelix.dtsi      |  7 +++++++
 .../mediatek/mt8186-corsola-tentacool-sku327683.dts    |  2 ++
 .../mediatek/mt8186-corsola-tentacruel-sku262148.dts   |  2 ++
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi       | 10 ++++------
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
index e74e886a00cb..822a177e7c19 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
@@ -123,8 +123,11 @@ trackpad@2c {
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pin>;
 		vdd-supply = <&pp3300_s3>;
 		wakeup-source;
+		status = "fail-needs-probe";
 	};
 };
 
@@ -197,3 +200,7 @@ pins-vreg-en {
 		};
 	};
 };
+
+&trackpad {
+	status = "fail-needs-probe";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
index c3ae6f9616c8..4dbf2cb73a81 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
@@ -17,6 +17,8 @@ trackpad@15 {
 		compatible = "hid-over-i2c";
 		reg = <0x15>;
 		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pin>;
 		hid-descr-addr = <0x0001>;
 		vdd-supply = <&pp3300_s3>;
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
index 447b57b12b41..ee5bc2cd9e9f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
@@ -19,6 +19,8 @@ trackpad@15 {
 		compatible = "hid-over-i2c";
 		reg = <0x15>;
 		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pin>;
 		hid-descr-addr = <0x0001>;
 		vdd-supply = <&pp3300_s3>;
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index cebb134331fb..918f17385ba5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -390,19 +390,17 @@ &i2c1 {
 
 &i2c2 {
 	pinctrl-names = "default";
-	/*
-	 * Trackpad pin put here to work around second source components
-	 * sharing the pinmux in steelix designs.
-	 */
-	pinctrl-0 = <&i2c2_pins>, <&trackpad_pin>;
+	pinctrl-0 = <&i2c2_pins>;
 	clock-frequency = <400000>;
 	i2c-scl-internal-delay-ns = <10000>;
 	status = "okay";
 
-	trackpad@15 {
+	trackpad: trackpad@15 {
 		compatible = "elan,ekth3000";
 		reg = <0x15>;
 		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pin>;
 		vcc-supply = <&pp3300_s3>;
 		wakeup-source;
 	};
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


