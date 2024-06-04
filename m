Return-Path: <linux-kernel+bounces-200535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF508FB165
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28792810B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11AA145B0D;
	Tue,  4 Jun 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vr598juU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FE145A0E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501809; cv=none; b=uVX7+on7+PVSgtAITU/4iNYQezJoPZMFLTFGZefXq/jGIHK2KZP1qskOpjYl3WJDaZYq2C3UJdTOCX38z55SPprJxqDdfqVrXokCM3nU2rgg/6hE4dtkNE+yGjvqqUOC/YT08uWDHhDe42ZOJgq+94ERkjf6j7yzZJWSn48GNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501809; c=relaxed/simple;
	bh=fkTnZ9utSu3RpZjpTFA3KtX0kGbMOvSiWEWH/lnpAC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQgawcPYvVgr0/GhGtOmU3g7gm8DpeowempCoNAyWlaTRNNffJnlJXT4asC3Gru/Nju3I9S54+uOZ9huLKodGNVpwfKI93YEhZmUJaiU5btAGld2qUj7PfJlTrMmPoy0ZSbkxKOMCfApw0S+HBmsVemHlj7mLM8fHnN3sYCa4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vr598juU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so20551175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717501806; x=1718106606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpkE0aoUE1IXbX8I6HLJkpLAh+G2e+4zrxJDLYQ7ckM=;
        b=vr598juUFJIKS8p+3fAmrFLin6fAGVbvsY8/AYN1SsltRLbfb8eN+D2H+49Jz9RWlx
         uFH7OVTaUgNtyIbHnPINLbIab9MyQGZNIkbfOoQbQ52TLhSp+qUNNh4kYsmy5STcmaZT
         TL3+/lTJNRCfg+dQk4c+q94dSOWhJyUYKSwUihM7fh6FId8ohPqcw0s+Y7bGS0izz84i
         VFP8dlUvJxUitWMFeLbE7dOgEQJc9vP7U1WJKfGJzUsYNy2YxnO3MW2SOW+3GM/Zo0K3
         qmEsJIRlXeHzsR0j9VuGrVZ+wmFfGHOE0hurYLmXydb/JwnNrGObRjGD4hB9bvvX8K60
         s5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717501806; x=1718106606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpkE0aoUE1IXbX8I6HLJkpLAh+G2e+4zrxJDLYQ7ckM=;
        b=OEr/LcWnk8hkLzoNMjws7n48LWc3SGB7KLnNyx4IxzolOq9tNUCBRFps55sp3deNFh
         5+M3Ir51fmiCPJ0iDriuARujmnznA2F/ZxaUXqtF9w4sPnWJ/ipDHkPbfNOhDQbQkCIk
         72rXAfretcXynJUXBi6SXwqvmoWuPwEbb+xhnd7oIZon7MXXK+HCXea5hUCYqC5mFKNT
         E3sEqGzUzx5pI8BNyeZ+KBYipj/kP+Iq64LFwrejMTPyHOR98Ev+4n7pMFIkF9GBSFh5
         hqCQxu3my1vNERuOAJeKvJozFQeDOlahat7hIYGyjiG+o7cFJE5LbpA0KEWsPzFykE1u
         75Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUBrEzv74Y+qbMWl3AhtxOWBLp3qFVgkdVvnw5efArXVpbrTixe7IDzRztv1xgTrPvbcGMGEx27lBbEaMlMZgSBwrQpXYFI6LYrSqSL
X-Gm-Message-State: AOJu0Yz8xFRHTfNvJ4sCNTPbOv1LHJdBibe//lfg12xxm5xprQSReGSn
	a1IFbOotxzHWDoDUmbGbi+gITeniBSMy2TizPNPv03bGWpTLSE8any0h9SruK2s=
X-Google-Smtp-Source: AGHT+IFp86vnBYSC7x98t1T9ZYJ9jdMan1oKa49xowP4VBC4PIr/20ZGyhKUU3gmgNBp3Qk7geKtTQ==
X-Received: by 2002:a05:600c:4fc9:b0:416:7470:45ad with SMTP id 5b1f17b1804b1-4212e07630emr112810035e9.17.1717501804096;
        Tue, 04 Jun 2024 04:50:04 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e5bb909d1sm5107822f8f.88.2024.06.04.04.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 04:50:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: microchip: sparx5_pcb135: move non-MMIO nodes out of axi
Date: Tue,  4 Jun 2024 13:49:49 +0200
Message-ID: <20240604114949.165223-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604114949.165223-1-krzysztof.kozlowski@linaro.org>
References: <20240604114949.165223-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

simple-bus nodes, so the "axi" node, should not have non-MMIO children
as pointed out by simple-bus schema dtbs_check:

  sparx5_pcb135_emmc.dtb: axi@600000000: sfp-eth60: {'compatible': ... should not be valid under {'type': 'object'}
    from schema $id: http://devicetree.org/schemas/simple-bus.yaml#

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/all/CAL_Jsq+PtL3HTKkA_gwTjb_i1mFZ+wW+qwin34HMYmwW7oNDFw@mail.gmail.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/microchip/sparx5_pcb135_board.dtsi    | 95 +++++++++----------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index af2f1831f07f..196868898f49 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -13,6 +13,13 @@ gpio-restart {
 		priority = <200>;
 	};
 
+	i2c0_imux: i2c-mux {
+		compatible = "i2c-mux-pinctrl";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-parent = <&i2c0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led-0 {
@@ -56,6 +63,46 @@ led-7 {
 			default-state = "off";
 		};
 	};
+
+	sfp_eth60: sfp-eth60 {
+		compatible	 = "sff,sfp";
+		i2c-bus = <&i2c_sfp1>;
+		tx-disable-gpios = <&sgpio_out2 28 0 GPIO_ACTIVE_LOW>;
+		rate-select0-gpios = <&sgpio_out2 28 1 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&sgpio_in2 28 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in2 28 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in2 28 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp_eth61: sfp-eth61 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp2>;
+		tx-disable-gpios = <&sgpio_out2 29 0 GPIO_ACTIVE_LOW>;
+		rate-select0-gpios = <&sgpio_out2 29 1 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&sgpio_in2 29 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in2 29 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in2 29 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp_eth62: sfp-eth62 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp3>;
+		tx-disable-gpios = <&sgpio_out2 30 0 GPIO_ACTIVE_LOW>;
+		rate-select0-gpios = <&sgpio_out2 30 1 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&sgpio_in2 30 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in2 30 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in2 30 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp_eth63: sfp-eth63 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c_sfp4>;
+		tx-disable-gpios = <&sgpio_out2 31 0 GPIO_ACTIVE_LOW>;
+		rate-select0-gpios = <&sgpio_out2 31 1 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&sgpio_in2 31 0 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&sgpio_in2 31 1 GPIO_ACTIVE_LOW>;
+		tx-fault-gpios = <&sgpio_in2 31 2 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &gpio {
@@ -119,15 +166,6 @@ &sgpio2 {
 	microchip,sgpio-port-ranges = <0 0>, <16 18>, <28 31>;
 };
 
-&axi {
-	i2c0_imux: i2c-mux {
-		compatible = "i2c-mux-pinctrl";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		i2c-parent = <&i2c0>;
-	};
-};
-
 &i2c0_imux {
 	pinctrl-names =
 		"i2c_sfp1", "i2c_sfp2", "i2c_sfp3", "i2c_sfp4",
@@ -159,45 +197,6 @@ i2c_sfp4: i2c@3 {
 	};
 };
 
-&axi {
-	sfp_eth60: sfp-eth60 {
-		compatible	 = "sff,sfp";
-		i2c-bus = <&i2c_sfp1>;
-		tx-disable-gpios = <&sgpio_out2 28 0 GPIO_ACTIVE_LOW>;
-		rate-select0-gpios = <&sgpio_out2 28 1 GPIO_ACTIVE_HIGH>;
-		los-gpios = <&sgpio_in2 28 0 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpios = <&sgpio_in2 28 1 GPIO_ACTIVE_LOW>;
-		tx-fault-gpios = <&sgpio_in2 28 2 GPIO_ACTIVE_HIGH>;
-	};
-	sfp_eth61: sfp-eth61 {
-		compatible = "sff,sfp";
-		i2c-bus = <&i2c_sfp2>;
-		tx-disable-gpios = <&sgpio_out2 29 0 GPIO_ACTIVE_LOW>;
-		rate-select0-gpios = <&sgpio_out2 29 1 GPIO_ACTIVE_HIGH>;
-		los-gpios = <&sgpio_in2 29 0 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpios = <&sgpio_in2 29 1 GPIO_ACTIVE_LOW>;
-		tx-fault-gpios = <&sgpio_in2 29 2 GPIO_ACTIVE_HIGH>;
-	};
-	sfp_eth62: sfp-eth62 {
-		compatible = "sff,sfp";
-		i2c-bus = <&i2c_sfp3>;
-		tx-disable-gpios = <&sgpio_out2 30 0 GPIO_ACTIVE_LOW>;
-		rate-select0-gpios = <&sgpio_out2 30 1 GPIO_ACTIVE_HIGH>;
-		los-gpios = <&sgpio_in2 30 0 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpios = <&sgpio_in2 30 1 GPIO_ACTIVE_LOW>;
-		tx-fault-gpios = <&sgpio_in2 30 2 GPIO_ACTIVE_HIGH>;
-	};
-	sfp_eth63: sfp-eth63 {
-		compatible = "sff,sfp";
-		i2c-bus = <&i2c_sfp4>;
-		tx-disable-gpios = <&sgpio_out2 31 0 GPIO_ACTIVE_LOW>;
-		rate-select0-gpios = <&sgpio_out2 31 1 GPIO_ACTIVE_HIGH>;
-		los-gpios = <&sgpio_in2 31 0 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpios = <&sgpio_in2 31 1 GPIO_ACTIVE_LOW>;
-		tx-fault-gpios = <&sgpio_in2 31 2 GPIO_ACTIVE_HIGH>;
-	};
-};
-
 &mdio0 {
 	status = "okay";
 	phy0: ethernet-phy@0 {
-- 
2.43.0


