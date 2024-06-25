Return-Path: <linux-kernel+bounces-228823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE1791677F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E561C21002
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CF15887F;
	Tue, 25 Jun 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBZzj4ew"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B721156899;
	Tue, 25 Jun 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318045; cv=none; b=Ii5XHLvXKJN9VG1qCk6zpcvM8MJrfY1KU3yj7bIkYn/Rc04rRYwUPavRIzqC6nvookit8A1TOnDlsCKhaVk77gcVAmxK8P6ONNb2hrJlFm+r3HzU5gf3iyfnVMo++Q4PW4Us2kiyRrwPnq65qVJc9SECJaSWZynC2B7/y8wZPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318045; c=relaxed/simple;
	bh=F6d7xSAQs2XmXHReYlt8hExXZWwoGmxnzLNt+VS9Hz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2FjPnQ2xT/Rs6lGAazSSpdQHiqTTAA0y8MGANGVL7f88toW4N4WCAdcNbBna+W4yDzg7ZOyyZECVecXgBaMxx1jWL6bnVfCaayVbd1ncJg9m+4CjEQ/8jDP57vhr1+RU9oSETgEgH/6LDXkmUxA0qyHRLNYUXthGVU27qnG2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBZzj4ew; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375858224adso19504055ab.0;
        Tue, 25 Jun 2024 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318043; x=1719922843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCdx3Zv6jgcLya0FbLGdFMlbTjbR1RWCyV9Cn/rMIPA=;
        b=VBZzj4ewMm/DJgL5LF1SQzcZxykYLI6aDB0LFXp4PNMZxzMwaNJMXXhMA4Bwo2ysaE
         AHY8mayw4hiV6V52LwwWE94hjfYuFFOH29iO49sA3/UpV9dy9jNdMp4I8Tpc4ntiNWIt
         ++pCh4J1ez3WPU51GJ9HZKTOfY2iHUtpEvQ6imH/qiJ0hPegk3v2t111538O3hJJHvpY
         oiZKvVRiMZ6+lqWJ4sOPGbI3mIWCJQoEzmdhal650+BNUZzfazQkJ1DVPcJplOJ0aR2K
         J5tSp46mDY8H5ttZnmdsOzsq34WyowJ44Z/a/OcFwyOqHLr9RRyCl2pyRwu4sXlX9lVO
         6Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318043; x=1719922843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCdx3Zv6jgcLya0FbLGdFMlbTjbR1RWCyV9Cn/rMIPA=;
        b=AJxgjwLnys7GPijOYfpdmZseTiyJGkNXillAeKUG9X9HzyKMtCKOb0IhFOSrnv4gZb
         y/IDhVnL+J5Xp1i/WiOKBJNyQVT4qUD2Qav7JyMeF9cPDzpt0K6x8X2dJarjxv8J6QMa
         dCYQY5ucG0tu2Klnh2zdwIUfFTleAly8JqM2RAaqGmgqmYezAG/DTYgbSNdWqt/Vf/Yl
         /YCEdEdKfjUe4tkh5mSeQSetQ3IpL5C83vhzYA5JM63OsXph+K2Sb4keQ1OjIV9e1HUF
         +QwnhoXz0iknHVSFSlLwsTGKNSWJS6Jil8XSzFPurhJwzrb+L8czjKD0BmbBWfOlX15o
         B/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvi+KO/NYOdxLgk5v6heI99y3a+1mU1gE8xYqqQuLIUDvc8zlJQ3Js30E9oxdbh9q7EBkSu+duACuCYX4ToUFAH7EiwDBjcyAIZ6rS9Nu8AHCP52bLDnOqqT61gcKS+4hk/3asgtcOYg==
X-Gm-Message-State: AOJu0YyvzAlIipar1i69fxa2trzQTDf2hemwVUr2CN3rJCYvfejAwQhn
	JIgPQEPA3Btla38gZNM7+aQvQAMkzRK0p+EziVoHhYWRppTnB4Ji
X-Google-Smtp-Source: AGHT+IEgWnQT8rOifzr8yavYSciazbSQFQ+ty+csNXNN7UfUlGZBVvmhX1LpNwnqHUTUFuAHvpbHkg==
X-Received: by 2002:a05:6e02:138f:b0:375:b4a3:9bc4 with SMTP id e9e14a558f8ab-3763f708ca7mr80967275ab.28.1719318043562;
        Tue, 25 Jun 2024 05:20:43 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:43 -0700 (PDT)
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
Subject: [PATCH 02/17] ARM: dts: aspeed: minerva: Add spi-gpio
Date: Tue, 25 Jun 2024 20:18:20 +0800
Message-Id: <20240625121835.751013-3-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
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
index e20e31917d6c..7d96a3638448 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -22,6 +22,8 @@ aliases {
 		i2c19 = &imux19;
 		i2c20 = &imux20;
 		i2c21 = &imux21;
+
+		spi1 = &spi_gpio;
 	};
 
 	chosen {
@@ -49,6 +51,25 @@ led-fan-fault {
 			default-state = "off";
 		};
 	};
+
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart6 {
-- 
2.34.1


