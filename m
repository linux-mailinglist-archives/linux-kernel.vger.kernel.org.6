Return-Path: <linux-kernel+bounces-333348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9A97C736
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B061F29A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68BA199E91;
	Thu, 19 Sep 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OhpsqCep"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1319992E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738957; cv=none; b=SLuo4vqTx+qMX01LgMl/GuV+DzW1JJx5FxNZ7oAvfKTbUfhMyiwMqht7tjyDeJ72E/5wFZ1JTn+eZRV+MMQF8wF0sTWbPijAeaHCMBaQH4gOTyTETZz5Rg50BAjiqiS1riG+T/iPcfe66RGVXdA7ZBpW2zBUA99PYEhMOC9owNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738957; c=relaxed/simple;
	bh=Aww6E9VVs7qBpKc7Eu2iYyYzNGHVrM3Y0dvHyPkm2TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AMLgqH9e0F1QVX/uDUFBOy8X0LuHtYJ27SgYgqdBCCLjbSNjLZbf0cIFFdgR6FDOA9ZzaNEDoLJksmLxgQg+TvS1A2EFhefj/lTQfLFJObwInH4YNRupAeO3iFj5SSpMO3rFIKG1Ftw+TJtLww5xCgg9nMgyMdXfvkyuaMm0TgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OhpsqCep; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e2855479so452126b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726738942; x=1727343742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDumzV+jL/bjpzSzdfVGLcrQ8rzaUr73VYrD39mPLZs=;
        b=OhpsqCep6l8wBQ9Ld9G4roZgnpex6kj6EZ91L9h0Qr19a/8RsYWk7kLYbi8vjZz4ss
         SaXNTzsBZyUG8DdFY13NfSBL8SAQ6k1ETxMEj1qQhBIWkWlFl3PYsQYq6+vgLYyPT0zr
         d7bq6rNhNcLDgsolfrsQYHZrFmglqka2SrVcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738942; x=1727343742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDumzV+jL/bjpzSzdfVGLcrQ8rzaUr73VYrD39mPLZs=;
        b=bKvyWvt4SDHnGboTonFNZ/kCR7iCkVRG3wDy7vhf4etjhN8XJccKmdkwnuvuzjh4pe
         k/oymZMTgV3JXmXZ/bDGgyUeYuJe8gxm7v6YDUoIAhhvTe6kezTNkks2dj6iJnk/NPOp
         bvKK/RbTCE3IMyEBLgaonTQujCj3/7WUZNZ2440JfuO/1wuzqu2WuY5dX4ztq1sON+cR
         HuvYnh2rYZjD1i45pABsTz/h0WBokkilTIDrrW+5qi4d8W3CnRGWMfx9YDBC3vT6zuoo
         TXtc/hZtBGqKIUmthgLbAHrnYRnE/sJrwxtNiA9yuNzQW6WNc3DvtaHpOFlYbbRY0tw1
         GsAw==
X-Forwarded-Encrypted: i=1; AJvYcCWO1MLzJmyNHJ76vBwRiuU6MB+7lnepaVBhaXXZFg4TQABiuRuzjHisr0FTAhkVsjd8egOWK2JcvVsOiz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDFheavYEYl3dZC2vBHDdA56mpwKIpPtgnTTvuuqZOari5HMqd
	rUN86OYmf5BGL77dGIiCWAmXk40Au0N/Kv0ycjBFwtgh/SMxnHRJkd57FQS/aw==
X-Google-Smtp-Source: AGHT+IF2vMJ+2AOCj5R87zBh9VHuLayxTQFzkC/Vn/4crABU7xxMMc8HPnxxeHtzrF1F0wZet9xAAw==
X-Received: by 2002:a05:6a21:398b:b0:1cf:658e:50fe with SMTP id adf61e73a8af0-1cf75efe88dmr36657324637.29.1726738942615;
        Thu, 19 Sep 2024 02:42:22 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:457c:125e:bb1f:8cd1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7ad2dsm7913170b3a.101.2024.09.19.02.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:42:22 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabien Parent <fparent@baylibre.com>,
	Pin-yen Lin <treapking@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3] arm64: dts: mediatek: mt8183-pumpkin: add HDMI support
Date: Thu, 19 Sep 2024 17:41:49 +0800
Message-ID: <20240919094212.1902073-1-treapking@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fabien Parent <fparent@baylibre.com>

The MT8183 Pumpkin board has a micro-HDMI connector. HDMI support is
provided by an IT66121 DPI <-> HDMI bridge.

Enable the DPI and add the node for the IT66121 bridge.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Co-developed-by: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v3:
- Update commit message and fix formatting issues
- Fix the label name of vcn33 regulator

 .../boot/dts/mediatek/mt8183-pumpkin.dts      | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 1aa668c3ccf9..61a6f66914b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -63,6 +63,18 @@ thermistor {
 		pulldown-ohm = <0>;
 		io-channels = <&auxadc 0>;
 	};
+
+	connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "d";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_connector_out>;
+			};
+		};
+	};
 };
 
 &auxadc {
@@ -120,6 +132,43 @@ &i2c6 {
 	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
 	clock-frequency = <100000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	it66121hdmitx: hdmitx@4c {
+		compatible = "ite,it66121";
+		reg = <0x4c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ite_pins>;
+		reset-gpios = <&pio 160 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&pio>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		vcn33-supply = <&mt6358_vcn33_reg>;
+		vcn18-supply = <&mt6358_vcn18_reg>;
+		vrf12-supply = <&mt6358_vrf12_reg>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				it66121_in: endpoint {
+					bus-width = <12>;
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hdmi_connector_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &keyboard {
@@ -362,6 +411,67 @@ pins_clk {
 			input-enable;
 		};
 	};
+
+	ite_pins: ite-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_GPIO160>;
+			output-high;
+		};
+	};
+
+	dpi_func_pins: dpi-func-pins {
+		pins-dpi {
+			pinmux = <PINMUX_GPIO12__FUNC_I2S5_BCK>,
+				 <PINMUX_GPIO46__FUNC_I2S5_LRCK>,
+				 <PINMUX_GPIO47__FUNC_I2S5_DO>,
+				 <PINMUX_GPIO13__FUNC_DBPI_D0>,
+				 <PINMUX_GPIO14__FUNC_DBPI_D1>,
+				 <PINMUX_GPIO15__FUNC_DBPI_D2>,
+				 <PINMUX_GPIO16__FUNC_DBPI_D3>,
+				 <PINMUX_GPIO17__FUNC_DBPI_D4>,
+				 <PINMUX_GPIO18__FUNC_DBPI_D5>,
+				 <PINMUX_GPIO19__FUNC_DBPI_D6>,
+				 <PINMUX_GPIO20__FUNC_DBPI_D7>,
+				 <PINMUX_GPIO21__FUNC_DBPI_D8>,
+				 <PINMUX_GPIO22__FUNC_DBPI_D9>,
+				 <PINMUX_GPIO23__FUNC_DBPI_D10>,
+				 <PINMUX_GPIO24__FUNC_DBPI_D11>,
+				 <PINMUX_GPIO25__FUNC_DBPI_HSYNC>,
+				 <PINMUX_GPIO26__FUNC_DBPI_VSYNC>,
+				 <PINMUX_GPIO27__FUNC_DBPI_DE>,
+				 <PINMUX_GPIO28__FUNC_DBPI_CK>;
+		};
+	};
+
+	dpi_idle_pins: dpi-idle-pins {
+		pins-idle {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO46__FUNC_GPIO46>,
+				 <PINMUX_GPIO47__FUNC_GPIO47>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>,
+				 <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>,
+				 <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>,
+				 <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO28__FUNC_GPIO28>;
+		};
+	};
 };
 
 &pmic {
@@ -415,3 +525,16 @@ &scp {
 &dsi0 {
 	status = "disabled";
 };
+
+&dpi0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&dpi_func_pins>;
+	pinctrl-1 = <&dpi_idle_pins>;
+	status = "okay";
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&it66121_in>;
+		};
+	};
+};
-- 
2.46.0.662.g92d0881bb0-goog


