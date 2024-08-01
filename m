Return-Path: <linux-kernel+bounces-271554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52867944FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2528B26C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B471B9B3C;
	Thu,  1 Aug 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzrKC4lh"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC21B9B2C;
	Thu,  1 Aug 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528233; cv=none; b=Q92TFaI4pZxVWF5ApuIsnt3FVWilTce9cb9YacmTXwhxAo8jvrdWPWn6/HQCrR/gQdkPODhprdd+M326afOu9K0KK2Pxfl6O6YUy7XCuwPXqVT8xxik/PPwxKBfYL6lTLRu22qxWadmHZ/dJGDWxn00C8j0FpMNF6haHAKtjXxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528233; c=relaxed/simple;
	bh=Cydcsv2ltnf0LJ2LpgXPQ7O0U2J+6JErIHN6q9qdqvQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGGYJdDyH79mppLVkZku/0glHnml2GWa0IrOLQLE4Yq7/17H/j1K6w+SF6CNzqMBoKk+8jafZm2nPc9BR3rti3VJwnrAykmzYLP1S2qZtlf7jng+T9JiWf8V8YgouMUHVx13AOg/VPnDJIxqV9XZ0WAwZLsrnzuBhiF5rU86/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzrKC4lh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ab09739287so4324261a12.3;
        Thu, 01 Aug 2024 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528232; x=1723133032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gix3DBO+oHGmr+N4AH/BAu7/Kk6dQdl46Hkauc/qyS8=;
        b=GzrKC4lhEtZYNH9V/yda5cJuRC1KxNUdmj991DK21FuXeJpSf52tyY/MmNlcOROA8M
         JE4fmjm99et8uCBaMQvLhRqu2mcnpMumYkDE3++lQ8PG/QZDrKCAgc6WuMlAhlm0b0fd
         jS1vYf2W/H8GZCkauO7qkYS/ELuS5GqoFrSiu4GyaQlnDI96SGtmO0H7Ig/aaHrNVWAo
         y5pGo5/XpvJcqck7ea/ZtnVsdrWnddpA3xjV/jIBC1NmQzaOb8c8MOPS0LpzkJEYgWr/
         c6CMcaZXWmJvHkXzy7niwyBTjxD3bT3arvLqwY6yT/oVk+lLyPNlyT2CHwPd96G2I7eX
         +amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528232; x=1723133032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gix3DBO+oHGmr+N4AH/BAu7/Kk6dQdl46Hkauc/qyS8=;
        b=cMtOHUYK3WHLCe2wQSBWCl87mOTkCPO38yn8TvZ4z0+Uv13QWJvBLQK1lHLiuTvN7C
         ZnDoMJUg/73vPE6fipPhP54a3MyWD4zjum4hSJNkW+iLz+nqKUYjSbqJnMCdCbXsC1Z/
         QRNlpVOHAAxjHZcLF7GgYDP0ICr2Tr4tH+Sdd+HQox8ixXL8dXsh0YjR4beqg8iP47bI
         xg9b0AetmK8y5HAPsAFnVtg2a9/0Nw+2tteq8XdUxuWp/7/vy3WagR2NLyHct7DdLmPq
         54iQFKO94yULqgFpBygbUyinHh+EQ3pvP7IltprvQKRmQwqvlP11fiZt6pFTiRtoFpVc
         hTPw==
X-Forwarded-Encrypted: i=1; AJvYcCUTl6bJ1NYddZ3gFSwU1K72jP+KZLU9G/erQ2zR4gOxFb/Xoo4t0hoFRheGZ9Cfj6i4WycAdtX4Vcrpm52W+UIQLhDOrQZyc85hEbffX3ZWYYeqZ1+hA9hCeUlVFFC+rwJwbsjU70/+CA==
X-Gm-Message-State: AOJu0Yy+AcWNpwXYjNqHjMzNq/FO/g8eVjOgtHNPK0Swu4e1CeoUeI0t
	MqWQnzrQP6qhbUuM/8Qwt3pQjcPznMMlFXVm1HRdKl0mABnDhpfx
X-Google-Smtp-Source: AGHT+IFG5G7AxA+RzvVGzDQ4AyH7OEXpR+B2oXS5vzJ/MDsP30IZ6t28E1tgeg6dwW701rf3IQ9e3g==
X-Received: by 2002:a17:90a:6b45:b0:2c9:a3ca:cc98 with SMTP id 98e67ed59e1d1-2cff93d5a16mr919401a91.7.1722528231525;
        Thu, 01 Aug 2024 09:03:51 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:03:50 -0700 (PDT)
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
Subject: [PATCH v3 04/11] ARM: dts: aspeed: Harma: add ina238
Date: Fri,  2 Aug 2024 00:01:28 +0800
Message-Id: <20240801160136.1281291-5-peteryin.openbmc@gmail.com>
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

Add INA238 power monitor for Harma fan board.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 0c4bf165d0b0..7d809f1636d6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -198,6 +198,30 @@ pwm@5e{
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	power-sensor@40 {
+		compatible = "ti,ina238";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina238";
+		reg = <0x41>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina238";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
 };
 
 &i2c1 {
@@ -224,6 +248,30 @@ pwm@5e{
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+	power-sensor@40 {
+		compatible = "ti,ina238";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina238";
+		reg = <0x41>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina238";
+		reg = <0x44>;
+		shunt-resistor = <1000>;
+	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <1000>;
+	};
 };
 
 &i2c3 {
-- 
2.25.1


