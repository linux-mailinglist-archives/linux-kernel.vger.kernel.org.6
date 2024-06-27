Return-Path: <linux-kernel+bounces-231887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F9919FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E952883CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC6139D12;
	Thu, 27 Jun 2024 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzjt2mDT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97FC137923;
	Thu, 27 Jun 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471653; cv=none; b=oSQcy5XQG0Kp5K4esjRPRUKlJmPdYsghJ6lkxsrnhnmanKzfaty4EMX6ejVo6x117fnsXvZ6Jv1p+wg8k25kJzlAD24+3AB5T9hv7MuLsvEJVDWUuS3M/z0hM2hu4QFs6VT+VIUeRJnfVlVs7JB7SJh8IRlGt8HpvpNlRUOh+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471653; c=relaxed/simple;
	bh=UcB/Fm7sswzjShlEvH/qTJ87ZiCFuC5Ko8/U4jCBPww=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCS0CuBxCrgzY1+Y6U1op1D8auKv9ulud6wcWCuYN7w5DaRgmZcqPhTtllW0N0eP9YCdI4aF8Z4jkq3gFv2ZhtBJRzeJh7QJSPzzQpXH5U5ygYgiRs1Gz/RgkcS8Sigbd6RvSUdlURx0MpQU6fJblMsh3GDeynriszKpiNO8zig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hzjt2mDT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9c6e59d34so61903365ad.2;
        Thu, 27 Jun 2024 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471651; x=1720076451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dzaqkiR2ify4Vskwae+HmUaR4MwIa3K/TPMIOUHQcw=;
        b=Hzjt2mDT9cCB1SERqMzTGzx9Cfv5asW6yGdKqqh2HvFO/Mbk0bTgfK28bTPmAGvKkk
         HXo2bA4Jk+Dlo9t3UGPPAu1TULJ+0O6i2FTvlppIhRhwwOCX8ewyg0Wxkmbb9nqdcTM/
         Qq5lvhD4herZnGrEDB7++2bN36f4S0Dm8mSZPKD0EuAxKHbeUMmurKjh7LekWswyccnY
         UHpnpTb0u0mNaRQAhmCCTJiN7+hH/m4LDY1uBgdQODmChaiFzjFny/X2PK7MRrrRjQ9a
         HJFU2Wr3RPDOmJ4ogvYa4ms1KKR9pDp72MDrmzy5a27AOvJp9834XdR+9Q55W8aVt6aQ
         sLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471651; x=1720076451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dzaqkiR2ify4Vskwae+HmUaR4MwIa3K/TPMIOUHQcw=;
        b=v6zPzn9h8S8dxZsmZpKnA3Je5yhPbdOqMngf1yyXl3WmXjaodNqJQUpY+UraKwrqpd
         8MvOSOl+qS0i2emI5Yfw2/TzNaBhEC1sfH7FvuQzhjPTFvuSzO5qtQIiKwV52/9DYazx
         b1BtRIbA9ULcV1BEAW7JuVx3zSEe98Pdb0Q5qCbLJv5mLDpXDNenITh2gcqwMKRz3NZQ
         iYz2du5o2unP50XvLMCZZ+y4vO2xlXU5pw8UXlqNnZpOI4NEQ2LyVShMQMI+6nVzyBKZ
         OwzrSPtId2Lx7LPHAh6xUJNNmNcsMMZwyoKMhp3KnoB1dFq3A9RlJhLC4+wFy038WfmG
         nC0A==
X-Forwarded-Encrypted: i=1; AJvYcCX/qnLm6FHQ7Ye42/gJhsEwVlT8Gkbhw4S8gGoFDATL52lJktaWAllQIE0sXSEOM9xsDj1gOm7CLWtz8kPHUGxvpHkXGpe4Unp1i65FkOCrR3fXmKgiE+/6LiLHEkXyVwssXLASgDttuw==
X-Gm-Message-State: AOJu0YwR7Ec489CMQn+8tepk3+evds8DFIEJ5tPmXvJes+zHDKfTGlfN
	9yDRJisSvBOzC26yjMphQVFAqEZ4GK6QHxu5vseN7Ex6M5Bt2la6
X-Google-Smtp-Source: AGHT+IEC7Ygr0pioIKKRbqWm3kRv8g7wmdoUnBAyVJDURMtcNT/d33EnEqVuDE4hLtrf3M80ksmcwA==
X-Received: by 2002:a17:902:e812:b0:1f7:1ba3:b91c with SMTP id d9443c01a7336-1fa1d3de7cbmr155406425ad.1.1719471651197;
        Thu, 27 Jun 2024 00:00:51 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:50 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] ARM: dts: aspeed: Harma: fixed dtb_check warning
Date: Thu, 27 Jun 2024 15:00:12 +0800
Message-Id: <20240627070013.2509150-11-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
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


