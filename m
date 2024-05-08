Return-Path: <linux-kernel+bounces-173113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3B8BFBAF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849D41C21731
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCF82890;
	Wed,  8 May 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PyklEU2B"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84D81ABF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166974; cv=none; b=eO0nAPPPonUoenbHlsLnK4KgmlE/BztksRft02rDo9ye2DKYXzqdyiB42LCmOJx3NOPm3n0nJiqQDYXBkx++RNbdT9VCDsfcNknHxq2GnS04CPKNgwbXkdy3yNdGdl+O1H0tr5ZzqZQuZA/uwK7NGpjTe+NTBNdL2RXhuAODF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166974; c=relaxed/simple;
	bh=RPie27IklaRFn+/JiKJQkM0UDLWbdd1RvmETEowVFe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuWGcFdqWEph4yv8tYoZN6FWApOZ1uJyHZvu22VOu2N0lFTMIMhnjAuhzd3PW2L/A6MEQNIyTmA6+bO3+sMd2JUeevcdzNff3Tr10dTzUNbRLyL+Yvci9N8pyXU0ouU4aaxcXHnkEkQYEbvte+9J1KO+A8zdVCrYNlp9ZRpfcSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PyklEU2B; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C00B54155E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715166968;
	bh=/V1XrjVIykV/6kKtO7hT6IY0af9h2AXu+LfSqihAnro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=PyklEU2Bvqn/MWrQjPyGVPOXkqC0k4bdPS3TQtKQ5tFwEjOBoE7ACM3bijbJ/5iYu
	 mQKKigRx5vHb9OfcSJQ+58KJ0pRLH/clknRIZCegsahyS/Wy6s5RB2Og7lJi8xzI0O
	 FtyV2+WwdCUzHGUViC2knyXn1Tfs1WS3pynp/nu3nTcUhMD4458kKc15LdFCe/9Azi
	 Hl0Kck9dRzeHUUjbmvgpwsiZp7x+UN+4GCLDBPljH5GuY7mJszMth9/di35JcU8A4O
	 vA/ioTYEr6PDHUp3DZj7mZ68IPkH3bFliIfyG/8Im5jKJ33JgeY98xMTHytw4UjaV/
	 6lRs+NZZhu+bQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59c7586f7cso218874266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715166968; x=1715771768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V1XrjVIykV/6kKtO7hT6IY0af9h2AXu+LfSqihAnro=;
        b=A64/sscH6zq/BO3faWM4QGtS8uKtAVII/wygEQmlH/I3FstoPIkLbymuCVJDBu1sR/
         1TJX3R8/YSiw5+zZUAOVweKOG8u/lHskGjyX2yZiYQES1mOSOcl5Xrz1Zczv4faCpfIQ
         O6ResWiWrH13X1LnwCs5xuCDTsma0far6PSAPiL2uCa0CTGMynorc+xVHEEdoVHCYX25
         8BPSkLr/q270X7IB0L8hB4Rx29uyrzh/JOnEXorft3Qx+zDLeITlwqhAjvyzCWmfPyd3
         K/nAH2Z4rScjckLNhGLLxx3gwChSG0h7coTLExHOO5dWLzGTHVxlpD0KmmEA4JduoCSb
         Lq8g==
X-Forwarded-Encrypted: i=1; AJvYcCWblj9CV2W9P7JwKBjzc7xkEMPnjsfj9KHza+mDIZErfuQ6PoUzkdOl9Zj9RBJsZPdrz9SpafTcQx+6Qjv10qUYZOAFckcjLShAnmZn
X-Gm-Message-State: AOJu0YwD1IslQq1ecT3HnaGt8BztQRUQB4TFKnvHwG6emYU8vBiLmeU9
	7AAVdN6SFCuQbprOGeYixfuKF5iH14pEWrM6IwI3rJnVsglU7sTIe1iesUXeOhXdNNtDK/46bm/
	j7tVVk4bqYfgPv+y5yMIuBhRG4bHWCe9CzcdMTDP+wM8zKYmZMXAMP/yIqS9cWxUJwDrFkT3Csq
	Yw8A==
X-Received: by 2002:a50:8750:0:b0:571:cb02:418a with SMTP id 4fb4d7f45d1cf-5731daa2c96mr1402047a12.40.1715166968340;
        Wed, 08 May 2024 04:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6TPvf3Ivj5W/nYnn3IO32jmZvtFJ0qUyRLDwfBkqqGUcetVJihJg5ZpM/8Zui9NrEJ+6fzg==
X-Received: by 2002:a50:8750:0:b0:571:cb02:418a with SMTP id 4fb4d7f45d1cf-5731daa2c96mr1402037a12.40.1715166968077;
        Wed, 08 May 2024 04:16:08 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:8ce6:9eb:cd7b:fcdd])
        by smtp.gmail.com with ESMTPSA id co22-20020a0564020c1600b00572a865af10sm7513556edb.44.2024.05.08.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:16:07 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 2/2] riscv: dts: starfive: Enable Bluetooth on JH7100 boards
Date: Wed,  8 May 2024 13:15:55 +0200
Message-ID: <20240508111604.887466-3-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Renner Berthing <kernel@esmil.dk>

Add pinctrl and UART nodes for the Broadcom Wifi/Bluetooth module on the
BeagleV Starlight and StarFive VisionFive V1 boards.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index ae1a6aeb0aea..1f79481bfd96 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -289,6 +289,41 @@ GPO_SDIO1_PAD_CDATA_OEN_BIT3,
 		};
 	};
 
+	uart0_pins: uart0-0 {
+		rx-pins {
+			pinmux = <GPIOMUX(40, GPO_LOW, GPO_DISABLE,
+				  GPI_UART0_PAD_SIN)>;
+			bias-pull-up;
+			drive-strength = <14>;
+			input-enable;
+			input-schmitt-enable;
+		};
+		tx-pins {
+			pinmux = <GPIOMUX(41, GPO_UART0_PAD_SOUT,
+				  GPO_ENABLE, GPI_NONE)>;
+			bias-disable;
+			drive-strength = <35>;
+			input-disable;
+			input-schmitt-disable;
+		};
+		cts-pins {
+			pinmux = <GPIOMUX(39, GPO_LOW, GPO_DISABLE,
+				  GPI_UART0_PAD_CTSN)>;
+			bias-pull-down;
+			drive-strength = <14>;
+			input-enable;
+			input-schmitt-enable;
+		};
+		rts-pins {
+			pinmux = <GPIOMUX(42, GPO_UART0_PAD_RTSN,
+				  GPO_ENABLE, GPI_NONE)>;
+			bias-disable;
+			drive-strength = <35>;
+			input-disable;
+			input-schmitt-disable;
+		};
+	};
+
 	uart3_pins: uart3-0 {
 		rx-pins {
 			pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
@@ -393,6 +428,20 @@ wifi@1 {
 	};
 };
 
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		max-speed = <4000000>;
+		device-wakeup-gpios = <&gpio 38 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 35 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
-- 
2.43.0


