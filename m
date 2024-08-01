Return-Path: <linux-kernel+bounces-271560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB3945008
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49856B27BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50BA1BBBF2;
	Thu,  1 Aug 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0diu1Gi"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF71BB6B6;
	Thu,  1 Aug 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528250; cv=none; b=lBJMoEqcu102uUX/4D+NNeXIdIJdyir4QeoE9p77ToPcpAUp/9PFCJx60YM1NMq0LAYCCEjjD6HSRQGynHIqTPSjA3gCn41sh7KsiW0DOYH44IUybyt7pqMCIHGUW1KBU3AM868jcY2KDMgyfivnspKQn/EL0CIlPpd/l/+Y8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528250; c=relaxed/simple;
	bh=UcB/Fm7sswzjShlEvH/qTJ87ZiCFuC5Ko8/U4jCBPww=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KESsH984JGlU+vV2h094V+ZPPGLcX0nbOQNi7UprpYPT20rH6WbWi0pqKuN2K/Dl6rMT56IOXwEjA2ufAfNtFM1JILmOwT0a1O+gRfUhg/NaHlctSXpxwEpVIsTHArLTtm5azd9xsKxDlRUbvUd4EgqQQqKKexycwwSODV8p8ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0diu1Gi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7b396521ff6so2383044a12.1;
        Thu, 01 Aug 2024 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528248; x=1723133048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dzaqkiR2ify4Vskwae+HmUaR4MwIa3K/TPMIOUHQcw=;
        b=E0diu1Gigpehpxt//YTzd/86hDKd0Em1HKrIUDV7k7cVZNSdWTrXhqWHIooCaNq04Q
         K4wIodihacmg5m6DCkXr4PcxYbkaloiJRHSj0TbnQE4j/SWzhTJ36FRbTr/xuTcPg/0X
         MIo8DIPQFwbNKNBCCFBVGARH+QTs+CJ7fKoN01fR1TfExsAZfSHNIgox/fSB6s8t8lR1
         5hoUYl+MzV6gk/EFrwyuPT63MgENo0nomBMKgQrtmH0x6Bkh82OGsdj7vbwdIlhdRP+k
         Su38AMPnYq96nvyFFZrPbdxcWo0sc46OWYDKPhFr7ZdHJ+AdWQvpjsHCzmqFxanVWBVT
         428A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528248; x=1723133048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dzaqkiR2ify4Vskwae+HmUaR4MwIa3K/TPMIOUHQcw=;
        b=ugoKXUAmuiB0Yz8S+G7nne75RwnDT+QrvnP0mntdaEAw2mSseZggw+GIqBrmRLyoSY
         LM0y7eeu3M8289jcsJhPWxBKriycPU3VwlbpPk1zN3ymCmTDJaEd/sZiHdIbhavF7vPW
         d4UF6XWI81nflNC6ilJJhHehlXIT+pwMi/Dp54I8sq1uBbCDPuI2vkK7twLvIwIXx6EI
         BxI3aSkJBE8NdCh/g+JQosEQ5FQ7Z/5/vBXxktCthIvnY1lKoJBH6m4GrqI9E67h/2Q3
         Gm5LkLaApY98Q5+dD9MYfzhSSNO0OATi2slKI+1CGfp6Y170mdF9dCYstWlJK8RkUNwa
         mBMw==
X-Forwarded-Encrypted: i=1; AJvYcCWiC/sD9UL+6oYI39l4Mcpj6JeqenPN6zek/JmEg7ZWs2fqwLDCCPyzyAsdBbyWa8VDHGM6RgeX1fNKaJYbJPDCe2uwMJdq7eqeCnpy4gm63cW7gCkz/AUrxnbr3JsSWvzosw0MkvV/OQ==
X-Gm-Message-State: AOJu0YzGyaqCAsv1T//dApQBZOabYLICj80IQ94EoLI+EHrz8Xljg4U2
	5xCz/V1c29ez6hXeBlY7I0jNJYpQI+sAqFIv4ssQz2ZGvO9No3vBwToXNw==
X-Google-Smtp-Source: AGHT+IGZRKqfnu6C1bL7fmLXc0sB0d/soJJoNHZHBvLfRySEEQSR37WC2HqKtNNgef4+UmDFfkXHcQ==
X-Received: by 2002:a17:90a:6387:b0:2c9:9c25:7581 with SMTP id 98e67ed59e1d1-2cff9419cdcmr831272a91.16.1722528248036;
        Thu, 01 Aug 2024 09:04:08 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:04:07 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] ARM: dts: aspeed: Harma: fixed dtb_check warning
Date: Fri,  2 Aug 2024 00:01:34 +0800
Message-Id: <20240801160136.1281291-11-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. revise spi-gpio node and property name.
2. revise tpm node name
3. remove max-ngpios

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 0dd0566bbf27..4421822eb134 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -70,19 +70,19 @@ led-2 {
 		};
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		status = "okay";
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
-		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
-		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 
-		tpmdev@0 {
+		tpm@0 {
 			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
 			spi-max-frequency = <33000000>;
 			reg = <0>;
@@ -640,7 +640,6 @@ &gpio1 {
 
 &sgpiom0 {
 	status = "okay";
-	max-ngpios = <128>;
 	ngpios = <128>;
 	bus-frequency = <2000000>;
 	gpio-line-names =
-- 
2.25.1


