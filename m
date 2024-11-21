Return-Path: <linux-kernel+bounces-416560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B29D46DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC580282618
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA6F1C9B8C;
	Thu, 21 Nov 2024 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyTqLPAT"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFC1C75F9;
	Thu, 21 Nov 2024 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163791; cv=none; b=rdlkllvlp0aK3xFe2F7R4xhf/ErjEltrgigcr2HlMDxPm4FuoF8PUsWkkYB32ekl75E2EOl7SH5brCUVJExZtSUaAkywRVG6gbECVVQ0wXlk6X9JJtoiVgXB1rN63Qudk0F5rdl2o8mpU7C30VJYrAWR7SoS6bRjWnn3Zjxdmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163791; c=relaxed/simple;
	bh=I2TP3r7v3bLpFaASEk3sitwyGaaE/KErFzQTxqzcCSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bK5fc1uDERRNftXTWi54llg+iChd4J1uDcJdGYJKT/72EgkCKC/0SBZRBbnwj0YaZY2pYoRzd3mc/29O0eFQ0TTFgjg9X6QOsaSqeKdBcACDotXkTlTJxoWi4IEYAcBDN0EHNSGXGA6egVgvUA70NMA/d6Bn+tpZo7CI3XZcva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyTqLPAT; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7181caa08a3so231352a34.0;
        Wed, 20 Nov 2024 20:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732163789; x=1732768589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UevInCocN2jLKEDjfdowPnnjzWJX7MTz3LcpvW+drFw=;
        b=kyTqLPATGawKi4/qvicQH0ni84s+NBfMzfXwD1IPKg9m/LQRMIGQagUEP3gTqgW9fU
         0Ka5MyWXI9tWu9Dt2ylaPnkAQnwUS2fyixFyGWXC7W5K3tlOR0u+Qn3syS+5mI6wEfmO
         xzSDZ0QEAPOYc8ifY0ntBnLk+Lr0Wd10pHSLDpxq+SRiUhNb3H2JROyz3kozdNcAA98m
         hcf7zU9Fv3NUqK3TvPdozy+dDophGXG4lPrWTz20W3ygMth3753Fmwv3cCj2Wl7Eco+i
         a/ol25A1ZZ1kCOYpZpBvwn/LxTMkIRQ6BIibkCY8fqANg8BZOWWgFz0LW61kiT+febf5
         +emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163789; x=1732768589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UevInCocN2jLKEDjfdowPnnjzWJX7MTz3LcpvW+drFw=;
        b=qolomaOvcySKo12iXLFVxK1KO8Q5xThw6gxR5uuZnSG6xlm2z+lXbf/TSGWWOTW/pu
         +lxY30E2SaMvynC16OO4+jnEt8fJUe5e0680gwZJ80aCgdi8FVcNX921JQZMyGub4iWC
         lYOjWwbYckn0zJaoug0TVfxkSb6YMEv4N7unu77bs7Zc8z7q6TyjcVd8GAESJaQ2Xbi0
         chBkxOFNBv/qgSX21BV+T18ZzxRNLIAaMOKPiSwgWZMroAlNQrgyCm/Y40GF8dxlT9EX
         KF9n1XeJbq+RbZB4XzUrC7PUpdHesCBmOo49PCnJxlLK7gDbgj8rYLywuIK1WS+ZOPCd
         qXOw==
X-Forwarded-Encrypted: i=1; AJvYcCWfTlhpFNwrP8gcaot5ss5GaNbPvCC1MIWuQU1a8RmWuabajna7mPUfmbcxQ5vvPQhqFYlYzhAeJgWfQxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9GlTycZ9OHD08nSLLOoZIXUXNhblNtl0Z/ZFtwTTIZrgi7jD7
	AF0Bb4czIIISxSKgoBGxMFv55rHKklmIfB2YPRF3FC1snUdVphge
X-Gm-Gg: ASbGnctP+0CTgAqZIOH3tJMwAKXyxzvJwPZB2cN2B5QWs/voatqutsEfXw+HIsOIFA3
	Bq3Kzimd1Mk02HlD5dICM8SVSWjieQWrQcF4u4eTyl/vlyDGjO2D80Qcsga88EctS8ZZEodVTe9
	gXRGzasokbOf+4KeMxTf2gMwCulPE5up/tSlN73pMHKzBp/UHjvIh/7cIZ5/ZqtJOIVH6RWVE/x
	4MVEov4Es9AJjoj2Ylst7eJXZtKUk2lvx/OXdcPulFP4M9ZZi2m/ZUwQqR1TBAYsbb6URlK7sQn
	mVRpD+BISSK0CvTPRZp/BDaBhmY=
X-Google-Smtp-Source: AGHT+IFYTyomNdCSLziTz63F7jtI4CB0+d1D5UH4XVfUDTPgCy5dwnmNsWJzd0JPw6TAiKDObmCxpw==
X-Received: by 2002:a05:6830:1d9b:b0:718:9cc8:21db with SMTP id 46e09a7af769-71ab30c4f0amr5652274a34.2.1732163789165;
        Wed, 20 Nov 2024 20:36:29 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64e11fcsm402013a12.15.2024.11.20.20.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 20:36:28 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 21 Nov 2024 12:34:05 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: remove interrupt of GPIOB4
 form all IOEXP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-catalina-dts-20241120-v1-2-e4212502624b@gmail.com>
References: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
In-Reply-To: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732163781; l=1368;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=I2TP3r7v3bLpFaASEk3sitwyGaaE/KErFzQTxqzcCSo=;
 b=1yz+R+1F2tRf1pVQwB6b7UeGDBov/eQD2XeNyCVW4Aclu7N2Co//7rjd8jIyruIhsTFPDzw8z
 z76ouhV+ffXA2njqam7obRW7ftWNKN7mOYdL3UeH1CCZx0L1vuDxXCO
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

We notice this interrupt pin always keep low, it cause BMC stuck at boot
up until kernel disabling IRQ of this GPIO pin.

Remove the interrupt of GPIOB4 pin from all IOEXP for now to avoid BMC
get stuck.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 417c0d12635c..3822bb3c9243 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -593,8 +593,6 @@ io_expander0: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	// Module 1 IOEXP
@@ -603,8 +601,6 @@ io_expander1: gpio@21 {
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	// HMC IOEXP
@@ -613,8 +609,6 @@ io_expander2: gpio@27 {
 		reg = <0x27>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(B, 4) IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	// Module 0 EEPROM

-- 
2.31.1


