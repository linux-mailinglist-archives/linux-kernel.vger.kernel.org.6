Return-Path: <linux-kernel+bounces-570826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15669A6B50D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D144A0695
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6F1F12E4;
	Fri, 21 Mar 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJxneGWN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD161F150E;
	Fri, 21 Mar 2025 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542131; cv=none; b=IYJWXarb05HoOMj/ymNZsRCpqpoCppPqBCK/fqorICVgujFTvc9su0VBqaA+PA5MLM3kW9W/jeO7Rlcm+S0TKAlEgEkzh6gkAvli2SPjHAPw28fDMSQXhMJmCn1iSkthaYWXSu9BjDVWVI8NOXrMf7o2uI3DLWcvo3sZLQUkQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542131; c=relaxed/simple;
	bh=cwszt1VFQnP0f7obJVwFKJMah6f154vn4FcRq3Og9tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoLPrckJHUJNn3H4DxzTLdPhlM4An0TIEpbr62grYKcHk7aP0oVX/yjXJp2W/GbiUyK1sU4CElyj+vYo5eQKElKfrevoPpVEv+uy1roA2Z1wdgW0bj+1PD8e75vdU568vmrkjBz+BiY8l4wZ+9zLHRaMF+BRoZZdOV67R4UtZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJxneGWN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2235189adaeso31197875ad.0;
        Fri, 21 Mar 2025 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542129; x=1743146929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjCNidD1nDVnXFrMlTY1ibBRmDZZuKdhhSQi5Z6zBTI=;
        b=CJxneGWNBAUd4JRMJJ5EL4p02ETJQHstL75Rhbvb3gYzSXBGSWhZ0Q8DTYN4oux15b
         40LgGqo+OrvlAkWRY/a5ErWvC6T09hTR5x2vVN9kIsBTJscH7LxhdIrKWsIKb4xRGRmf
         OxnziDwMGrcOW73/bAjUi9QCWMx8mG0MwFYAd/87sDIrt4HhDXM0rPrpB4IcV3X5q6U1
         QRPSbBLT9KOauFg15cf1K42AMfgiZi6eIPNNq14X2KSrr5eWhjZK0wZudwrJZlpiJFHC
         wsR/fpgsRyBF/wIKqaAZikrZIjcMKme/SNQcnt0bE2R2/dWIUo+/QVxEl4Wi9YL43XtI
         WYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542129; x=1743146929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjCNidD1nDVnXFrMlTY1ibBRmDZZuKdhhSQi5Z6zBTI=;
        b=LddxnVVh1fLxfTgRfpYi/NPrp13QlnkiG22yoMqcCBynFKf+PuHjikLR/txX/pX5wh
         1WDB5wHfJ6OXZj/5PwDnAnQO/8NWN1KXPivLGY0Zumu2VmYpfDyl+gjb+DxedwTWwpaQ
         RY03s7YQ3hV940n/j65RvadcUxMQy+dP2gtHsKjhj+QAIeZtvm1RTtKsmxS1TIqOFxof
         Eib8HhGp/4m2/ql8p6a2LvuX9fCRdeWxFFQwylfrD238SbRQVXHR72nqUt7t4tbQn7am
         0XK7T27e2UHdkdTSZzzQhgKYd1B5TX70sTJs89D6k8iSRAZSJAQiN3buvUZK2VJQh7dF
         NmSg==
X-Forwarded-Encrypted: i=1; AJvYcCX+qJLOewtJpIRymXiW4ZTt/zz6xfXzo4+lCv/c0w0jTOXs9ytt24aKC+eXp1FU2APEvK2bOOBqvQFq+2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YymsPR3DuagVvhEyzMXGPw2H1egkteypWFJ3Ra3IyZJskO5n7Da
	SS2/eBM9Rf2bA7Sk7uowzb7RxOUdXC0+TO/NYOWMMBolYpVcRxES
X-Gm-Gg: ASbGncsHbzzVsr7GJJmz++zpcyWNVIrYzMHKiyl5G/N6s8bUNTDF4b1Zi49uZw1kzYR
	GNwaMrFfBytV67JC36kFTwbXEIjmtJbKR9bj5ap91ysZe5nuwMDvjJVYi1ZFCYZ+o6I/qosUeiS
	Md5LpgEmJ9K7wvOFYoUeXst/zL+MS6qWcp6Q7B262YwhfYjZ8arP5nwV/+hqukWs76W0K7zVx4c
	GOEldjEaxdrGF0IF/irPS/TmWL1exDQqHVsnX8tNh4ZOxy7iFI/gvhzimilq+kYTXVqI4wAyDVL
	mvheheYiP6VhI4lEF02yMwdcfvH2tEc1jc4AU1ZbVS4r1ws2i/VUHqtaaJ+HYZX2A18QRQFug+r
	PIRdFR8GnYVAY5tqCmyUyKA==
X-Google-Smtp-Source: AGHT+IEdlfdB78rjOGHfq1n06+OQDqD/5ZuI1NfpzlDEeEQ5t3Eg0NaxY/M0zpNx0tr+GcFTGiQYdQ==
X-Received: by 2002:a17:903:1c6:b0:221:8568:c00f with SMTP id d9443c01a7336-2265e24eddcmr97780925ad.0.1742542129526;
        Fri, 21 Mar 2025 00:28:49 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:49 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:10 +0800
Subject: [PATCH v6 09/10] ARM: dts: aspeed: catalina: Update CBC FRU EEPROM
 I2C bus and address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-9-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1195;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=cwszt1VFQnP0f7obJVwFKJMah6f154vn4FcRq3Og9tY=;
 b=PJ4/r/ExlbEASIzj9UpkcDwcf+n+oj5TVo2Q1L3mJAQismWdHDQBLOQI4WoHNFtfXbLtQp6uP
 xhND1kGpY+ECVHJ8UZIChY5h1TLViPhywg/CVC83hJq95l2mDtw16Dp
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Revise the I2C bus and address for the Cable Backplane Cartridge (CBC)
FRU EEPROM in the Catalina device tree.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 2dbb65db9250..a6a2dd725266 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -822,6 +822,12 @@ eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
+
+	// Secondary CBC FRU EEPROM
+	eeprom@54 {
+		compatible = "atmel,24c02";
+		reg = <0x54>;
+	};
 };
 
 &i2c13 {
@@ -834,18 +840,12 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
-	// Left CBC FRU EEPROM
+	// Primary CBC FRU EEPROM
 	eeprom@54 {
 		compatible = "atmel,24c02";
 		reg = <0x54>;
 	};
 
-	// Right CBC FRU EEPROM
-	eeprom@55 {
-		compatible = "atmel,24c02";
-		reg = <0x55>;
-	};
-
 	// HMC FRU EEPROM
 	eeprom@57 {
 		compatible = "atmel,24c02";

-- 
2.31.1


