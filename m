Return-Path: <linux-kernel+bounces-575501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01AA70348
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262941666AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0602025A2BA;
	Tue, 25 Mar 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JSvOyZAF"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A5259CA6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912002; cv=none; b=scstMgqQFYg5F6BbP65fscEIC5P+yFC9lA/iYOCvgYyFybOzi7Qgj4/638ST/1hH3j26KEWWw5c4EvgJsfk8dEMfA8GH7Yq8XDWXAdhkzyeSPakVXIzYKXCGFKYgSuSnk3XQYXytWpeZEobgDWV1VOR69iGNSvGqsi2VZu5qVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912002; c=relaxed/simple;
	bh=nJ76qnpAiA1hIrK3TfkbYTYfWRCX/J8sNAMB6mmLa10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJRHf8tu68bjW7R0Wn3+q3K/PM7HlVaPHMALPVPASuhqnxDSoJl3UuLFytxWZFLtmSYeWd9sHTWU+9AllyC52PxKMFZteYjJHXVQ2P5Asr3tnzvMKjA95qm1o+07iF7553UDkJ2Z52TcwZ9I2hUuYVjt0H0F8Pp4CGZqto9z3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JSvOyZAF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2FB14017F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742911998;
	bh=ruY4mx+ycuBPq+bKcBygbtDAkYa1zJT+mxxboy0e/q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=JSvOyZAFwiK1TO17Bmqawt5J6WLj+ESA6TLodVIFNqtdZD2Sl7PkBSnQEzb5KjHBL
	 sf3abF6lnrgTKG55dOLtDf5walwwLYfSKIKezZC5Xg414GnoC0mF7Zm3vE+4BcmJid
	 3GEm3KDTfxiaAzI0v3XdFRnEDtRwQiqCMbsvK2yJQia61CR7CXhjmgVK1Iz1sBLPN4
	 MVWctQuzkJ1FFLTc2HZkWm70V6uSq47qcy/zEpPx2t+NMkkyx+LV2Yo2BS1GStP3Lz
	 p0907vfpiO0iekTbI5dB1MdDyLh8cGrIcSNMZIm2YjlFNnqnmSrPLNYb/KXnrBRYhn
	 aCCPwiDoR/BmQ==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912d5f6689so2963549f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911998; x=1743516798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruY4mx+ycuBPq+bKcBygbtDAkYa1zJT+mxxboy0e/q8=;
        b=UCOzBqAoCnJCexHcOlztEjW5l2A388CF9fzEYjomy50RqqQ6nukAO+GBv2a/62JOp3
         k1scNP3nxixLR154nm2M0kLQzURbTdytWkToBVUySyQQv0w6YdYPn88PKtVsLSm5wXuY
         BM3X3TINp9+lv43Qaubd4O7+uZxPEOJMhrRmdIRUASz0CyjOBx86DzAubo/8l4iJg8OU
         YjfpP+TutkWZYqDjuboVFbRKA3HmWCM/IsZVmUw9hUnCgkdnvY9D2HgsXKIMdkDQ6PjE
         /A27FoC59Pnl5zb6IJa9pYIXERSMP64tv89dbQ4Aar7n/hk5Oq0L5SZZLt5gfC+PeCpH
         hyYw==
X-Forwarded-Encrypted: i=1; AJvYcCW6TjZl77wBLVtlJhFNKfQTHZzhmeC9vqim3se7aaZRBxAGKDewMwi1vVIf/9PBuSBPJfB32O4UJDWw4VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpbcwehZQ5r7y8gLa0/BofB00kRDJ6VGBPzbkjSkSe6Wugf8o
	ycoDw91YTPkxc8kAT0flMsx/fOJelWFV3y2TjZFcfLpl2IBHzDqeGFA2Ku1p3gRWO6WpN0b+lSl
	lykvyIXgEOOSrX8pSgDIvELDgltNa4l2vmftNXnWFfL92UMGsT2cgefy8glq8v5MsIxi9AsGnNW
	EqQQ==
X-Gm-Gg: ASbGncvWvHxDVKHW40bUJXoCU65m6l8L3+lGx+h/1UwSCXa+Ft3dGft+zLPSqIt8d0b
	yJsn6YVcazQFlwe/IvMfFUoW1VvTG7MyKMXPpWoBW4VIP1DLnXACa6SOhmp3kMRJfjXlxPLakKr
	7cjaONMsh4dvtlmy1/zro8k8pfdK7e8uXg82mHBpWNULtTm89SnmAJOtkqY69luVRBLbCng2knk
	lf1LAWBw5PKyPhcjuNQ1M5+c5O+f7iO0jCtRegKiQ8v3i2iFUlgFCPGN/8MTeLr+50+0gEZ6fIR
	cSa4ypm+StW2/oT/2/xJqky3EuWJ6Q==
X-Received: by 2002:a05:6000:1a8d:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-3997f8f9d54mr13315769f8f.4.1742911997519;
        Tue, 25 Mar 2025 07:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIxyJ37OZghcxQ+a/pWrQYrdFkF1ltdT3GNn4+fygXg02/lhRChSV9UcnQAQLd+3Joudp+Ag==
X-Received: by 2002:a05:6000:1a8d:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-3997f8f9d54mr13315703f8f.4.1742911997011;
        Tue, 25 Mar 2025 07:13:17 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13532091f8f.29.2025.03.25.07.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:13:16 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Min Lin <linmin@eswincomputing.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [RFC PATCH 3/4] riscv: dts: Add EIC7700 pin controller node
Date: Tue, 25 Mar 2025 15:13:05 +0100
Message-ID: <20250325141311.758787-4-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
References: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add node for the pin controller on the ESWIN EIC7700 SoC and gpio-ranges
properties mapping GPIOs to pins.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/boot/dts/eswin/eic7700.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index 9cef940f07e4..7226647919b7 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -312,6 +312,13 @@ porta: gpio-port@0 {
 					<324>, <325>, <326>, <327>, <328>, <329>, <330>,
 					<331>, <332>, <333>, <334>;
 				gpio-controller;
+				gpio-ranges = <&pinctrl  0 12  1>,
+					      <&pinctrl  1 14 12>,
+					      <&pinctrl 13  1  4>,
+					      <&pinctrl 17 32  1>,
+					      <&pinctrl 18 40  5>,
+					      <&pinctrl 23 51  7>,
+					      <&pinctrl 30 68  2>;
 				ngpios = <32>;
 				#gpio-cells = <2>;
 			};
@@ -320,6 +327,9 @@ portb: gpio-port@1 {
 				compatible = "snps,dw-apb-gpio-port";
 				reg = <1>;
 				gpio-controller;
+				gpio-ranges = <&pinctrl  0 70  3>,
+					      <&pinctrl  3 79  7>,
+					      <&pinctrl 10 89 22>;
 				ngpios = <32>;
 				#gpio-cells = <2>;
 			};
@@ -328,6 +338,7 @@ portc: gpio-port@2 {
 				compatible = "snps,dw-apb-gpio-port";
 				reg = <2>;
 				gpio-controller;
+				gpio-ranges = <&pinctrl 0 111 32>;
 				ngpios = <32>;
 				#gpio-cells = <2>;
 			};
@@ -336,9 +347,15 @@ portd: gpio-port@3 {
 				compatible = "snps,dw-apb-gpio-port";
 				reg = <3>;
 				gpio-controller;
+				gpio-ranges = <&pinctrl 0 143 16>;
 				ngpios = <16>;
 				#gpio-cells = <2>;
 			};
 		};
+
+		pinctrl: pinctrl@51600080 {
+			compatible = "eswin,eic7700-pinctrl";
+			reg = <0x0 0x51600080 0x0 0xff80>;
+		};
 	};
 };
-- 
2.43.0


