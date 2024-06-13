Return-Path: <linux-kernel+bounces-213541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DBF9076A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07631C22C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5014AD3D;
	Thu, 13 Jun 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6TUEAbs"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBC14AD02;
	Thu, 13 Jun 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292411; cv=none; b=cd7bcLhmEbcmm4wnivZ//jt5lTGN+TB/d5wdZmbcLG7kq5laXGdHdwkR/xTvGfuk6BWthX7K8pnwDPXUJ8CSjvG1omJFylaAFuNLiYkZFKSkxHCWVhuNRuQkxHeJI6f5T7V786/eajJhxZwJRIz9rFeuQT/7AP+K8XnhyY7pOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292411; c=relaxed/simple;
	bh=Wiw4nxajC1kyJl2gW5+gpnIjAk15gII+VvjhLb5ZXnY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdET81YjiUZYeS0t3fawoT5P11Y2MDdE1+XLZHJ5QVdUiV3bzVbAUVzp7UiZtI2ECNWKQ6aKfFpVn6eWIxPY9SgB5cSd8tavPw1wDmKT833v81WlaKoRYMnTvSH4kkx0v2paCoWLJyjUKwzKkN3jEj51L5FEJBRh15O6MEeC0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6TUEAbs; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b96a95c5e8so665432eaf.3;
        Thu, 13 Jun 2024 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292409; x=1718897209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwI/HNhW+KLaFfAR0mDxuIlHrsRtZCH23dDOp06Pu+Q=;
        b=I6TUEAbsiyQs9tSpS8DeWsEnwGqjlPeulMKIiuphZh+pXz6Ld62y9pShs2r1LHIn2L
         fl1T4aLNiwALDo15NaDSjKtHa7xE1+6UJzBR67VJhkndJw00Ty4YF1WCrR0lx4PU1IVm
         nHvx2fPfNFR9OdNJf7j+nlQF+9tvMWTcoOv4VZG6PsYMVAG026QS84CQUGax3QG+EyeQ
         Q6NHu3ApcIG1Wj/tmtaVCtz0QFbWZEDywO++ORcayzubqO5XmQWZYOGY2z2vJqynaJcd
         w1pySRRn8BSgSO52mgV1hO/prvY17xXe4RnTNeMMH/zlpLBIfcN+ptsW6o2z6ZpHc2tb
         LYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292409; x=1718897209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwI/HNhW+KLaFfAR0mDxuIlHrsRtZCH23dDOp06Pu+Q=;
        b=jvlIVA0og/LOSLD7b5vNkb5wdeCPuO56SIDvDvlapmWH/0K1VqdD/qFu86mkXuJWm1
         U535Mtg6Q5KjYCxhTd+Rz2X+FrepwL/htUkpjeNoH4I6sgh9tWQx0geIQ+RQz9DI97gd
         vNEt2djZ5T4+qQZJ4hYLofR3vMXOxL4x+A1E7mwEynnss/4iEBO21Ieddt3ZSSweRrHH
         ocsnyHXlLc/jqcM7CZ9TujdjfnZAb1olOnXLSQcRVJlB5cQyBMBFJZoUQXjegUQfkZYb
         0WkFW0ZRFaUfUfTzUO7scSm2TPT71bXwywqGqR/AUQIXKWYW0IsyYZ3qe6usomUYQ06w
         nZlw==
X-Forwarded-Encrypted: i=1; AJvYcCUtplbbtwB1BwL5PQ0sGMZgOcuq/b9ieUiHaLwSYGC17TIhCUKqnV8xVzvC24PwGhvJhQScDNo4EvFk+H/dYmceHss1vweBhB7AHIYeYBfxHwCDNTjQZvL3yEPYM4KV/YAY27VhORaLlw==
X-Gm-Message-State: AOJu0Yxr+zelej5mDkM1T4B08iMq9NDkAZghZfcCXkc6N9bbIAjRXgyQ
	HNPr+xj8luEo6fAZG49M7CBR9AzIFr/2yGdlvAjyQSdGLzGpLUhU
X-Google-Smtp-Source: AGHT+IEb6jZiHrXtDO8lryaRnm7jdVVTAkWt5alb7bZewa05Z+A7qVZBuRcEhv6XaHOnlahOVxqFlA==
X-Received: by 2002:a05:6359:4c82:b0:19f:4fda:4163 with SMTP id e5c5f4694b2df-19fa9ddf24fmr11457155d.1.1718292409110;
        Thu, 13 Jun 2024 08:26:49 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee41663d2sm1198183a12.92.2024.06.13.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:26:48 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/7] ARM: dts: aspeed: Harma: remove pca9546
Date: Thu, 13 Jun 2024 23:24:25 +0800
Message-Id: <20240613152425.1582059-8-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove pca9546 and add Aegis fru device

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 56 +++++++++----------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index d892e646fced..4ff9e0104bbe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -20,10 +20,6 @@ aliases {
 		i2c21 = &imux21;
 		i2c22 = &imux22;
 		i2c23 = &imux23;
-		i2c24 = &imux24;
-		i2c25 = &imux25;
-		i2c26 = &imux26;
-		i2c27 = &imux27;
 		i2c28 = &imux28;
 		i2c29 = &imux29;
 		i2c30 = &imux30;
@@ -391,33 +387,6 @@ gpio@31 {
 		"","","","";
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9546";
-		reg = <0x71>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		imux24: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-		imux25: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-		imux26: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-		imux27: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-	};
 	// PTTV FRU
 	eeprom@52 {
 		compatible = "atmel,24c64";
@@ -427,6 +396,31 @@ eeprom@52 {
 
 &i2c11 {
 	status = "okay";
+
+	gpio@30 {
+		compatible = "nxp,pca9555";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+	gpio@31 {
+		compatible = "nxp,pca9555";
+		reg = <0x31>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","","","",
+		"","","presence-cmm","",
+		"","","","",
+		"","","","";
+	};
+
+	// Aegis FRU
+	eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


