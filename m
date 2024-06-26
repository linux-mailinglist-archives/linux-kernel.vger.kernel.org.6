Return-Path: <linux-kernel+bounces-230788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0209181E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBC11F224B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D4018C35F;
	Wed, 26 Jun 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzytENnx"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972918EFCA;
	Wed, 26 Jun 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407179; cv=none; b=B9qCGA3sYDDegDpvqb/GnnOcjxaaXS/rYYUDoG6BbVthlpRMOyI/fPk1FZ2+/EB/evb96zDgXPgdsoSxlahSxj5I5NB2z3x1zrr/e0+ZiwqC8ZPb8jovJd7lToN6E/ho9HP/3BHlbIq3TqOP65jZmqIsCoUZ0hr2Eb6r0SZLDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407179; c=relaxed/simple;
	bh=I5vbPWZ8FqO9qCj573QCzSkPpLCN85wczV8w52RXQ6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITBk3M+x/iIzsW3XXHWXk03mVAtKOcOABewcd9pV3gYk9oorZGwk+oswXd56H7jzUoMWsQdcFG43IMRuQ1fdXNj/aBHWl0tGNvgdvZ2GTRWVZvXBzUeK4y4uloRBt4DpLdGFJhGjBIZfn1lddjFYIm8kgMKq0WaQOjj+VTEn7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzytENnx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f8395a530dso52114265ad.0;
        Wed, 26 Jun 2024 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407178; x=1720011978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDIfl9HjVykS0hpfBMS083uA+ZwP9ghS/a+IaSxCQC8=;
        b=UzytENnxPjwwHeWd3ubN+7STexCByktlVSrBfQGkVu9adfOG7LIzVSDUt+S9NZtOVq
         z+VCsb6JHvhi4D/uoi7gKYXeTQgOd2ZU8yMLlgq0clmAfQSfAP6NvdTXlWIKB5ErOCXJ
         gvKjzROFrAq2X1efOrLH1m7H8x9zA3LDPZuxITkCing/7ulYblor3Rz98Mc31sqKwvz2
         JtFYKCVjBHtLaXI1+7CL/F+HUL9aNThzdML0Jsl/mA3iW4OLJmHY/x9uhLssBKP12Kwc
         fu2pk6cYOIc4U1mm8kpL8o87QCnQtn84wlojb760cSPTTqYAuYpPd2lXlSbBGJl0xyyb
         hzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407178; x=1720011978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDIfl9HjVykS0hpfBMS083uA+ZwP9ghS/a+IaSxCQC8=;
        b=v1b3KgQDp1A9UVqWIrx7/lkz/tEB4HFlkXUiXtTNBDfAbZLXmmav8XcF9k+uiJXa7z
         JOqthHWoIvyTnir/CA/3HI4r6EVNRPpzV2rtE87ciLQ4ue3VE7UHywpYdm8ijauh7jJv
         Qh2/ntpgqfrviI3u4Wkp+O3es5/Yi+uh0WHq/2NBOpbIzSmJXiFNB7bUyWjtTyh3DGij
         mZc8KKrM6NqiiF+ZJL8wAOpkVEfABkr0k0A8RDEgifkLVxmbWRpuu+BeLhgII9lXe6at
         qvaXZaDHoozfSTFzWeK5VUWvzBMIRM9LQ+UNXHEdDroZkr3zqvnG3jHbgb76q1HAs7AH
         GpYw==
X-Forwarded-Encrypted: i=1; AJvYcCU/aSu+u8p0t5yfKmpk791pAyq5XjhNC0csCgJzMgLPTQ6BfgZ+olJttqdzQiv4j/axDPujWmtL1Chb2N9Q+d1yxOYHF3oEFAib3Z2CGV1wSu/TVCj5ZH3NH/KG+j5wtKLjISCKWE+C8w==
X-Gm-Message-State: AOJu0YwmDcWYAkyI+s9jo+kfTAPOJKwJOg+SqbcpD4BhefpWiuWjjXAv
	AmhHzxsyXcYafX5fwhNx5pbRPxM6qgU0+OVUMTF4L1fbpxDxZdTN
X-Google-Smtp-Source: AGHT+IHthDBOZr+7elbb4+CJeS0BtO+9g/S/qAkS2jeCnmIU2XDj0g/LungcZqjqJ9JdKSYcUusrig==
X-Received: by 2002:a17:902:ce81:b0:1f6:ef5a:7740 with SMTP id d9443c01a7336-1fa23ee4f1dmr103650935ad.34.1719407177938;
        Wed, 26 Jun 2024 06:06:17 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:06:17 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 17/17] ARM: dts: aspeed: minerva: Add spi-gpio
Date: Wed, 26 Jun 2024 21:03:32 +0800
Message-Id: <20240626130332.929534-18-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Add spi-gpio for TPM device.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 8180fa5c1854..f5ac248097b4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -23,6 +23,8 @@ aliases {
 		i2c19 = &imux19;
 		i2c20 = &imux20;
 		i2c21 = &imux21;
+
+		spi1 = &spi_gpio;
 	};
 
 	chosen {
@@ -74,6 +76,25 @@ led-4 {
 			default-state = "off";
 		};
 	};
+
+	spi_gpio: spi {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart6 {
-- 
2.34.1


