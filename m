Return-Path: <linux-kernel+bounces-230778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0E19181D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C030C285BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8918757A;
	Wed, 26 Jun 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHNAa4Pw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8113187546;
	Wed, 26 Jun 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407160; cv=none; b=IqeHQrOqnrWzzywvUZU9/s3svfkuscrZRvmlnvSv/0QpzkHcd9s9ZURYyBNNzyn1HChRADeYcHZ7wSsxo81y07rBXXvhfOtyyl/JZCtvcrlgPQ1WicoWTIJ7sCkdEhnS3YtzxBmmvENtx5u2f407NOQ7Xrvy0CIhY+q/JkTOjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407160; c=relaxed/simple;
	bh=7qXUjqpPU5R+Vq0buV6eE9zzYkFveU735owUmzBozZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGxeXMbz7hqK7Fg8W2pWkTY6nULL2wFIPnwDEJt4cH5IMEngiSkB8/SPIs/8I7FJqWHt2Gr7m9eZpJIVo34/glrGeaT5d5feAkvqLSPF6Cw8l4GjHFILCP6uYNoFCe6j3Z3++DFab97ak/jJ9V1ZtOcxiysez6tXkoEMyJuUvfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHNAa4Pw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso30500555ad.3;
        Wed, 26 Jun 2024 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407158; x=1720011958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdGXb9xaxS+at5MNG5psiNQJLwy+4zAvvWhthDyzcbA=;
        b=nHNAa4PwuWfM6/TABPhVBbc+1SVXawiL3JoUkpYvZ6Kuzzy25lCupu504zcz3EdhYh
         NyV8Fe56RsLEZIWz4quT2zis8x596BT4xgWcUorZqmh/T9z+0oUOKbM9FwXPGacSrb8A
         Qvg1aMI8mDTjW+IW7jOlooRhhBPxS8u0rw6TjWWsTtAvSQLDAYnCID7PuDS17PmeBk7y
         IRpFS9WQLHdW76fV42vEbT+dQUEFsDk2U/jvUaWDdrtASG5JZC5EGbysWPw2L0i4zZ60
         fzTJ2z0NOOYe5tFmVl1jqbUM3ClPvKg/gmeHtLilJGytUzL8ezwaN9TIt+EZTGnas8zF
         9xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407158; x=1720011958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdGXb9xaxS+at5MNG5psiNQJLwy+4zAvvWhthDyzcbA=;
        b=msHFvPA0hEz1KvAW2JKeh1OMdyt3Cs/sXtBwyw1kTfUSqGpDPM+VIKhYa03iz1uU9U
         3ygvm/EQeA9bpYcdBzD1HxN1OHEF96SvGt8CDOR+KvuX1QHdY6q06gPKccwzQSTB7q4s
         MSWMMUAe9zEubX/0iZ1F3QFRE+0R40zFiChn3SxLs0YX5gQs6kAgCdUu9FEpfxrc6yTv
         rjWLXJneCPXrfbHD9C34BYbUhlMK3WyKkdrfMF/TLQHpCj5ub9nhFwnUhCOsObKooWaE
         BTp3js+M3rf8QVOWJ+uEa+6YdkhsY96C3NjdbDGNsP0aJcihLv5k/PhGr7OmSvoISqnJ
         RYNw==
X-Forwarded-Encrypted: i=1; AJvYcCX2yrW2WCvVRR8FPSD10Inzcer4lNupbmdgW75fg8ZL5bDCdagDULVYQ1ASgh3FFRciigm2Vsw9ik+4e3hBG6KpsqGs5wazY/JvPcs7yxxQnC5n/ax2lnuXMM+NgGXnIsi4zijH2PWyZw==
X-Gm-Message-State: AOJu0Yz2dG409AKe25w9IrtpaEC/zrI48K55LwILeTFPFRYoANgzpknO
	2vUWwEDtUNb/N56PlB/7Y/A0f9KxqI/CzfXt9ZJamc1mMzfHxZAX
X-Google-Smtp-Source: AGHT+IEaWb9bMQzZFOYWTqIbH1czxKQEGH++hJttO+WxTvjO0VFAW9LCdcw7pQbK9MTllDpAV0DpYQ==
X-Received: by 2002:a17:902:ea08:b0:1f9:d551:c848 with SMTP id d9443c01a7336-1fa240e74a8mr105800835ad.53.1719407157649;
        Wed, 26 Jun 2024 06:05:57 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:57 -0700 (PDT)
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
Subject: [PATCH v1 08/17] ARM: dts: aspeed: minerva: Add adc sensors for fan board
Date: Wed, 26 Jun 2024 21:03:23 +0800
Message-Id: <20240626130332.929534-9-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
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
index dfea0025e6ce..86d319d7edcd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -207,6 +207,30 @@ pwm@5e{
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
@@ -225,6 +249,30 @@ pwm@5e{
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
@@ -243,6 +291,30 @@ pwm@5e{
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
@@ -261,6 +333,30 @@ pwm@5e{
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
@@ -279,6 +375,30 @@ pwm@5e{
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
@@ -297,6 +417,30 @@ pwm@5e{
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


