Return-Path: <linux-kernel+bounces-228830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE4C91679A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D301C20D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D395169AE6;
	Tue, 25 Jun 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2oyUlpl"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2B15687C;
	Tue, 25 Jun 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318061; cv=none; b=QfhyMLXSwYgjzSG/M8yYwIM9cuAbsT0/74OZZoxhI2zCxhhLxnqck7kqzGHs+bU9EylCnyA4V9E8Ap4+Z7dgt3F5e1KBr64GBHn+1IKYFosY5DE5FA8KcCzQKwaT645LwfkB9IMLAfh8b/8QJqTp7OT77et27Bz834A/YRPrRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318061; c=relaxed/simple;
	bh=r0Ibe6X3a2z3JIJAH1lD5bpI+HqgXs7so/KdP69y7LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A8QS8GQSPMPoFOqLdNxNSWFRu4hZTPZSrTIFR+D0GEM5S4G95X2Ua7Ez0KmlYQ0Q6vgeHxHcMAaET6PyrwxByJGf2D5XxDTPD6K7PJHLqT++TZqakXi+AD7GRCzYCzKEAo4IvqVD2KJHOhTeO1F/qnFU5YV8qkCaPxQ8CIobsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2oyUlpl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066c799382so2876902b3a.3;
        Tue, 25 Jun 2024 05:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318059; x=1719922859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn92Ddq0IvoImB657oaMQiSF86tgeTAhup9iBLRfd7s=;
        b=E2oyUlplJqUNp8+wNjtC5oafZXxx8bKk7BL070+9kls68XGBQ1GTOdMP7AUTVPajUT
         0DxmE3apfV1YNWw68BLHPOr7QmLKMDOGARgnl7psG4dwz3kss2LHsIUuQou7Su5wLvqe
         0FRIc6hOScKgfkCliwzizzdNnrrx0E39mJqh4t9U1ZjkhBVBHZ/jDkseAV5RdoyLWLzV
         3u5nVMQGWc0Z2H1H/q1a1cx2lp/fC0YbQxnAOFJWRd4JEFYicIuegJP9kylvdPVwJGri
         6XWxzaWJZOy+psy2icLeLj3Plnfx7ZY17crqs2OQeUF7Gq5Ttyv/RaKHVHHS7y8JztHE
         WDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318059; x=1719922859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn92Ddq0IvoImB657oaMQiSF86tgeTAhup9iBLRfd7s=;
        b=UGxZ6GtnG0CGBbV8hC68hRAknjQlMT8w6Dnnr5Ce/JSiJy/9VcYIUhdeHpH+C98l5m
         jNBNui0WfA5xa00HZ2O7bu/XCWdJBtpRBcHjm/IQo0WUQJxFREy3cErHqJhAsoTUU6O7
         BQB0j2KeMSqo8clUU59hR5ARfj70S5QgADrnT7A9plXF8WCulgQwb+wzW/H2KfN0wQvb
         uouwvyx6qll41EtbbgPR249IdsFgDGKFXmADEAgR44TjcfDIw7qeE9HjkqgJ6e51UJA4
         fXvMDVVJtYV2b1SwRwvGGczQzp1qEfoR/TzLQmQcabsxn1dyyiMenzgePcGiM9kAxu2n
         9cGw==
X-Forwarded-Encrypted: i=1; AJvYcCWnFCMmLQ0SKuUWHENDq/l3ttVHt+IWW2QVbU6h9HAbxklVBq3tOCAEWCLVU/KWHztOqKavMsQ9VPIjV794KfuzYvtbik+OnehMETxWMz5j2EBN3WsIh6iQIXdul6VoXZp3AqCF/f3IwA==
X-Gm-Message-State: AOJu0Yx2uNuqZwQQZxlnuxETUuPRs93FuYHcEcu+kucJ7pHwXwmhWoBc
	qHBEfX+2GMv5z91xF0/D4q9WJcm87h+vgxciZ0N0a8lIvB1NHepF
X-Google-Smtp-Source: AGHT+IEm2L4+wB8BjdmsEdQwOKUL69wYUftO7+oTnX3eqEeV5rpyfma1fPEq0sib2QsRvoiUGVKdIg==
X-Received: by 2002:a05:6a00:2da0:b0:706:1edc:79af with SMTP id d2e1a72fcca58-706746b8ff7mr7886885b3a.22.1719318058945;
        Tue, 25 Jun 2024 05:20:58 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:58 -0700 (PDT)
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
Subject: [PATCH 09/17] ARM: dts: aspeed: minerva: Add adc sensors for fan board
Date: Tue, 25 Jun 2024 20:18:27 +0800
Message-Id: <20240625121835.751013-10-yangchen.openbmc@gmail.com>
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

Add ina238 support to read the sensors in front of fans.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index bea389d1e90b..60beda2737a1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -228,6 +228,30 @@ pwm@5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux17: i2c@1 {
@@ -246,6 +270,30 @@ pwm@5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux18: i2c@2 {
@@ -264,6 +312,30 @@ pwm@5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux19: i2c@3 {
@@ -282,6 +354,30 @@ pwm@5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux20: i2c@4 {
@@ -300,6 +396,30 @@ pwm@5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 
 		imux21: i2c@5 {
@@ -318,6 +438,30 @@ pwm@5e{
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
+
+			power-sensor@40 {
+				compatible = "ti,ina238";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@41 {
+				compatible = "ti,ina238";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@44 {
+				compatible = "ti,ina238";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+
+			power-sensor@45 {
+				compatible = "ti,ina238";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 		};
 	};
 };
-- 
2.34.1


