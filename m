Return-Path: <linux-kernel+bounces-569930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A2A6A9C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0F28A853B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E71E1E9B01;
	Thu, 20 Mar 2025 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFX7T2SA"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E281E834E;
	Thu, 20 Mar 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484274; cv=none; b=EyZK+dQ80x0xyQfbmDRW4NNSOUAuxtxAooow21cLkpKskWyMPBAMzLwzg6WxRFqRsLxPXQe5jfOH3EZYR40zsLwdVJaaVnLp9a3GEssAiFFBP9XjQmvApIrgNTha/oakosdfIYSVwvhtuyrA4D4wMqLSTXQLgdWtBZ+m5znlSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484274; c=relaxed/simple;
	bh=ZE8DMnDtK6GtXz/R29k12joihlo+gxEvbFhaGKQky3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEmVq2j06Rhgbgmh4jDIwR77vBofNy15YT07G52t2LqKw1QakeGJitSZb2QZeNLeJX+pfIqugFqAa/kNc7xM4ZZ+JUMlHivzXZArnZEeHX7vY8IoLxJZgVsAy4dEOUEfd/FUeckCj56TPL7QILPb8MUZnUHa1+r9QKJzKVr60UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFX7T2SA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225df540edcso44427005ad.0;
        Thu, 20 Mar 2025 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484271; x=1743089071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
        b=WFX7T2SAh04upOKSc4Xdn2eSzPs3jcdYVR43yI8EQ3V8hll/JuIbl1O/ua71uidjiB
         TedrJSyhQuWlbQ5l9ooMI4rwDMKryPfdGiTIbEvGaR7Ugee0A01YW88054wN2q7W4ZPj
         PpzRJkIKPV3+admX2iU3V2oD4ztHw7po4FXJW+YWfw/TwcoieihmZjuFuU4qIalqcLPZ
         hgZublTosT4faB6gWW9VP7M7HPWLw6ZSPJn2xH0x58B7KoxhvZo4wmlawIdV/qNv9dvX
         OA4DOzsrAUngaIBjAgPwdSOJTW02kuJTE6T0VkpwJMgK6Q006lnekiMTcHo5qZQurPh2
         yITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484271; x=1743089071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
        b=j7ScehFZPppUQJ+P4R27cUb2w1bCOwjQ5QqCuweEPlohxXyBTPvXK5Ij9r302b1+iU
         wYwAnh+7sK3XWmHFPgSOwP8JN15EYEDx1a6HV0qoUcmiDbhD4UQ0rMab/GW0k2+CRcLH
         DSP8VV8Rjv4BQEi71OHvHKm6y59YUE8rFcoLdIFDGkEi6qVaxCkUNSn7dlP5U0ipmuDs
         sdFSydC73lzKlVfhm9zzYHYT9adtLdo0+hE6/nYVvySDCKHC2wRVZTt1zoO6MEUqAa3x
         nx+ecC4fGltWMbyICUkFquXiSr/UXTya5F1zv9u8j7IcKzJVGLlj/JJPiKu4RfozZI+i
         BpOg==
X-Forwarded-Encrypted: i=1; AJvYcCVy163qmgsWSiN6xGqPpZYGr69ncYQiZbqhx/S0OG84oo9qhtXi7SkzXetbhJ74ktE4inocXbrT74y2rC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlECDK8pJVBVYo6pjxMcQqDUbTUP9/5SSxxH2AyeQ2Q66ikf0v
	oZAOB33N++1Itm8D8GuwkUI6M74OilsI5a1Xb2gK9qPak3AfCABg
X-Gm-Gg: ASbGncvobj/Ni0u7bXgN3LrtBeREweZe+SQyaoDqEqvy69LWYFGtTnCvgBkYGcsxvLd
	r6VHwEwKZYPtsGWg7OuVWrJjRhaIVT36C03JmFwjsMA5Iz2UDF5OD5H2CZJATTUi3np+223Vmd7
	aVnGlzkZzDItR3ve674nWrnUsYPeRHopEtf8J+9W0G/YVVhpNnVSV2zctZUIMdHekBHSqy2P9Md
	yctwCv0DO5+ojla9BWxjy0FN/2AIvbNL0rsLBMlu9T7N+iHHnnLnWHHA3qL/S8Igj2NsIdMGe9d
	CJ7yIKddmv7UVMy0Ms7o/OmZj96s7LfUB8app6AI1gjRRU903LfgEFNbvoYSx3Le9NIBfJ9EN4t
	iiQZ4IeSg0LF9SNVgRQdBkg==
X-Google-Smtp-Source: AGHT+IHybFC0zN/Rzgp2ZChfKI2Jk8hE5XOcGV4Y15RoIluk7IS4EwemASEKGtRKwRtujb5+46zkqw==
X-Received: by 2002:a17:903:187:b0:223:3394:3a2e with SMTP id d9443c01a7336-2265e7184aamr45865045ad.18.1742484271343;
        Thu, 20 Mar 2025 08:24:31 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:30 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:51 +0800
Subject: [PATCH v5 01/10] ARM: dts: aspeed: catalina: Add IO Mezz board
 thermal sensor nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-1-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1855;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=ZE8DMnDtK6GtXz/R29k12joihlo+gxEvbFhaGKQky3s=;
 b=Pwk8Uh+93j9LYHavxQFQIFiCHCzIOTgKNDNj8/fEYsR7crev46E2mLJvCsTSj93JoySx9CQyj
 71O0JM47JzTC8DBcfN6GeGIo64SJdL0YhGdfdK5V451j7FQ9RYGGpZD
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add thermal sensor nodes for the IO Mezzanine (IO Mezz) board in the
Catalina platform device tree. These nodes enable temperature monitoring
for the backend NIC, improving thermal management and monitoring
capabilities.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index c151984289bc..d5d99a945ee4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -198,6 +198,12 @@ i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB0 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch1: i2c@1 {
 			#address-cells = <1>;
@@ -208,6 +214,12 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB0 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch3: i2c@3 {
 			#address-cells = <1>;
@@ -299,6 +311,12 @@ i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB1 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch1: i2c@1 {
 			#address-cells = <1>;
@@ -309,6 +327,12 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB1 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


