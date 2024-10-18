Return-Path: <linux-kernel+bounces-371726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66539A3F41
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C765B21AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED01D9A41;
	Fri, 18 Oct 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHUjVHVJ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF681D79B3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257236; cv=none; b=K8PXBD8Kr+CR8G1w8TAcLc+UDsW+Be3UF1ax2BhjF8YbWiBStUBHoda2Ey6lHLTUJV8J26gWXTZZAoZu0U83nqcurZMCO+i0Xhi2TZgYTLd8o4o1CxBrRLBOx3trX4PaB3Hu/JDA+Pdec8M6GT2l7oeg6/rugaiUbHmr3T9BVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257236; c=relaxed/simple;
	bh=8Klwv7FKRpCBVZDGms6vZqbLr10aymsVwSzujYvPBP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoT8mgu7uYBs88Ok6E8dFHk4dQvuWMuj5nZ9qJe4txEX9wLpdHBDKnh8/Tm+Nd4SLbUGIWsKIO4/0o3oCRskyy7ujlSZserRU6d71zd+2gYshMW1C0JGhgCcNpI8TCw31J+FMCAtfSKAdHuAkIEtKuasA7EVLUNWauopkS2Sw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CHUjVHVJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so1546040b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729257234; x=1729862034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKGlVab4i7DHl/ffkFGpIlho3hvAo5V5WFM3UhTHe/o=;
        b=CHUjVHVJKWyd79KWvq4h9vnTbgF+p7TLy9oKMz6fpqYBWF+Aidcml43bpWSXRAmhGx
         /52RJwxfC4fH1PLWXoQOEMkrh4JL1uOqxklMdhLl2yT3IT6Bw4jz3MM+Td2EeQ9Ndk2B
         C5Rs7jOiI2UgRuIlCXxvTAA6kshudUdN7GQe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257234; x=1729862034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKGlVab4i7DHl/ffkFGpIlho3hvAo5V5WFM3UhTHe/o=;
        b=crBFw9yL9CJtxgeZUNYt3VQfNznJO6xrguD+z6SdUDdZukpuX1wH69N+o6OT2KQqks
         LsrFvWmeL1UHfszxpyH0IK6AqHqKJo+wb3tBiCIzkP+rELDKJ5CkWysXLp7OtmIfwOxL
         D1R3Fim0tZnKWEKs5bBj8wQDCk5s2yBQoR9PstAitP1akGgOSzfT9aI7HigrQNe1kN0J
         HdfRNdbZ70BTyvvjAWo4k/QCqq1+/oFdOuSXkkWvW61y5028el5uo5pKwuBRrKhcSB7h
         mVSwfMMfIMOrI8QuVVARg0M9NFd0PALBxEBNlO36rj984x5ZXu9WkeKVPW7Or2abAwDd
         hpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5u9PC1gMJ8OoSsh0uIJWN7BJef4sZW1iVT5B44GgZ1JmrAMjUsLlqbeAxQkshFpTX2WbNZLx0HydBfP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2eTZIYUR6/8nm+ZN0WBpKK7xwlkk1krp9oQTk/ZtkNDp3Un+L
	5yHK8ajBFehZysJUHalCos3g8gXW2n1zAz5nLghwBBO0z/KkVBRcyIG4n/WMmw==
X-Google-Smtp-Source: AGHT+IERpLhih0BRRVXV4tS4aKvV7xvMczqjv51K9VBdHc8nUJD47v5CIh7delZjIDSg9jy5PpQR0Q==
X-Received: by 2002:a05:6a00:2d18:b0:71e:71ba:9056 with SMTP id d2e1a72fcca58-71ea425995dmr3282768b3a.10.1729257233739;
        Fri, 18 Oct 2024 06:13:53 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (176.220.194.35.bc.googleusercontent.com. [35.194.220.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc256cc8sm1120222a12.56.2024.10.18.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:13:53 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 18 Oct 2024 13:13:42 +0000
Subject: [PATCH v2 2/4] arm64: dts: mediatek: mt8183: Switch to Elan
 touchscreen driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-post-reset-v2-2-28d539d79e18@chromium.org>
References: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
In-Reply-To: <20241018-post-reset-v2-0-28d539d79e18@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

After commit 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to
i2c-hid-of"), the i2c-hid-of driver used by some mt8183 devices resets
the touchscreen without having enough post-reset delay. This makes those
touchscreen fail to get probed.

Switch to Elan touchscreen driver, which has enough post-reset delay.

Fixes: 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to i2c-hid-of")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts     | 10 +++-------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts     |  9 ++-------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts     |  9 ++-------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts     |  9 ++-------
 4 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
index ebe6e161354c414d91859494ec9295db75a3baf9..b98a3530511e576347a4ed291d37d45dd42fec97 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
@@ -14,14 +14,10 @@ / {
 };
 
 &touchscreen {
-	status = "okay";
+	compatible = "elan,ekth6a12nay";
 
-	compatible = "hid-over-i2c";
-	reg = <0x10>;
-	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-
-	post-power-on-delay-ms = <10>;
-	hid-descr-addr = <0x0001>;
+	vcc33-supply = <&pp3300_alw>;
+	vccio-supply = <&pp1800_alw>;
 };
 
 &qca_wifi {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
index 2dc64cc539f815b9848b8243e5b487f22d605a6d..9fb329626a82034e44fb5fbd2d0ad9675c0a5afa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts
@@ -27,14 +27,9 @@ &cros_ec_pwm {
 };
 
 &touchscreen {
-	status = "okay";
-
-	compatible = "hid-over-i2c";
-	reg = <0x10>;
-	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
+	compatible = "elan,ekth6a12nay";
 
-	post-power-on-delay-ms = <10>;
-	hid-descr-addr = <0x0001>;
+	vcc33-supply = <&pp3300_alw>;
 };
 
 &qca_wifi {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
index 53e996f9c605dc36df03d4b0051a91e19fefb38d..6d547361fc4f9d2ab1f9b048af443495c9bed323 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts
@@ -14,14 +14,9 @@ / {
 };
 
 &touchscreen {
-	status = "okay";
+	compatible = "elan,ekth6a12nay";
 
-	compatible = "hid-over-i2c";
-	reg = <0x10>;
-	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-
-	post-power-on-delay-ms = <10>;
-	hid-descr-addr = <0x0001>;
+	vcc33-supply = <&pp3300_alw>;
 };
 
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
index d7db621383c6b823af08ca07e0794758d062e211..39ab09ce28aa2ed4335d5279a965f23a8458688e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts
@@ -14,14 +14,9 @@ / {
 };
 
 &touchscreen {
-	status = "okay";
+	compatible = "elan,ekth6a12nay";
 
-	compatible = "hid-over-i2c";
-	reg = <0x10>;
-	interrupts-extended = <&pio 155 IRQ_TYPE_LEVEL_LOW>;
-
-	post-power-on-delay-ms = <10>;
-	hid-descr-addr = <0x0001>;
+	vcc33-supply = <&pp3300_alw>;
 };
 
 

-- 
2.47.0.rc1.288.g06298d1525-goog


