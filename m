Return-Path: <linux-kernel+bounces-231885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D0919FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B06B20F43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FFB482EE;
	Thu, 27 Jun 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgGxoG4Y"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC2481D7;
	Thu, 27 Jun 2024 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471648; cv=none; b=GxBxPlCu3sValbVEaftLoJsvEKKiFN8QobTmeY3wWqXk7Oi9pl2cRyK/p+05L+zofvD6waR1yEmB4Cw+NgnQMJeqmjAtB8VE8s1YZlR3KNmGXzQzDY42/0vwmLWDe0Cfg4e+b2wkS41AvXOCDBY+MwsdpyOGlatL+C88S2Y45Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471648; c=relaxed/simple;
	bh=XVOpdeV6CRQwS3cUnfTnIgJDQsEPBmE0H1hjYjSE0OM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRzbab9Nc2CW0Vy2XKIGsozFGg0joR61PPS7g2Q1MZnvd7m04i4vH1AsrqGcQXK/F6CxCkUMi0bup/758FEvk0ES834qa1on/mK6DhMHi9pdLJjHvLzE3Mj4M7K+N6eis4n1RJJdpM2gO6NIs4PskeCmzVcEBNzTOAqEh4bjN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgGxoG4Y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706683e5249so4018786b3a.2;
        Thu, 27 Jun 2024 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471646; x=1720076446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmQLM6kfiLLNztCoNImQmMNq24bv1cMMrdxlIFr9qpY=;
        b=TgGxoG4YCm2mWgcaEsR3WOueZKdN/2f8mp8mhPSQGLUO6O/SZpeX1pDdO/K5clV7wb
         YNR8KriaKc+V+BsUFhn7CFusrXphcjBmrh8tiB3l6bCTBzR/rblJul1naDldm0kJ1dw4
         U8YL0nIIvemrAekw4UjNHMfLSJdDRGvG7b9CuLEeHN8UPPkr6xlvWQMzKrveAFotp7z7
         dYU7H4c0i/rDmHOBjOONf4OwTptokg6OBRSbRHFoKGGFd5bwOx8fq2da0XkXyAmGXg4w
         S2IqnZ3okcy4FLR6hGgTQ3v/zHf3cnAE3CSYDQkWzDOqGpbLt5R+5bgC+uhl3l1C1rWg
         7NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471646; x=1720076446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmQLM6kfiLLNztCoNImQmMNq24bv1cMMrdxlIFr9qpY=;
        b=Kh9tQFtbgY3BvRIGvlMEwRLmpGBRohVTo/3KymSvgwuEZCZnpeOXnqtfTWspKNWthK
         WYApX5vvV73IfznciRjhPtESjIRyHgPEN/3Twj2BFaAdnWieTxOEaSTNLcwCqs915CIy
         NXk6dDcee+5dZVuozHLfXRYbqHI96mjLUgpAprRrYP1GHxo1doUchnW8vUEskcsvCFr0
         ExQGMj6tW+zCFVeIMoW7URYG89VReMt/sDa53/x9wWjhBwz3Fcqw4w+22SGlYkJ4SP59
         7SxAyR7MbTRp6eIVxC2HWfXj2Ag4N24EK15fm3d3WZKuTg5mwbiZcslBMTwIe422Xscb
         +x9g==
X-Forwarded-Encrypted: i=1; AJvYcCV9EWRdZTTf0iZwBVAlgNH9ySTxtJTxayW9r7IRbBAUV9LTC3Rnc5227RP5hSUSPHuQBH4ACR8cRA6rYK7IJc5t+7RdbGNGsysXhAtrIhvLadDDJuKG+svGO96cg92wJNUH3i0lH8wfqQ==
X-Gm-Message-State: AOJu0YydtGKz9FLJ/pwqHGHGLImDKFK+gRB9BgFEqLOVyhgNU+RR87/N
	CXqP2gBOpzuO56dWU9EH1sVLP5uDakYRazzySasp7sWjXihW8F77
X-Google-Smtp-Source: AGHT+IHb1g8XlOrBodiQethHKfUA/vsxZD3xX+AlO38V4lMaCSQImQ/hYmUviYtZFWQWT05xDKMsvA==
X-Received: by 2002:a05:6a20:9790:b0:1b8:a226:9a8 with SMTP id adf61e73a8af0-1bcf7e6f5damr10865467637.13.1719471644475;
        Thu, 27 Jun 2024 00:00:44 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:44 -0700 (PDT)
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
Subject: [PATCH v2 08/10] ARM: dts: aspeed: Harma: add temperature device
Date: Thu, 27 Jun 2024 15:00:10 +0800
Message-Id: <20240627070013.2509150-9-peteryin.openbmc@gmail.com>
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

Add temperature deivce in i2c0 and i2c2

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index f55ffe9c4d89..0455475fbcff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -221,6 +221,11 @@ power-sensor@45 {
 		reg = <0x45>;
 		shunt-resistor = <1000>;
 	};
+
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
 };
 
 &i2c1 {
@@ -271,6 +276,11 @@ power-sensor@45 {
 		reg = <0x45>;
 		shunt-resistor = <1000>;
 	};
+
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
 };
 
 &i2c3 {
-- 
2.25.1


