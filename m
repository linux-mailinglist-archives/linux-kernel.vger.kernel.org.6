Return-Path: <linux-kernel+bounces-537761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB0A4904C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421533AFC6D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9F71A4F1F;
	Fri, 28 Feb 2025 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWss6K5R"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C6E1ADC67;
	Fri, 28 Feb 2025 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716768; cv=none; b=D3uHl9qCg2a7I+JCj/E+kNQMkLUAC89w+noFUR1nHzsqxBp+BKrDxF6KjSX7K0gNkMLM7VIZXQv2ci8+jc52X5VIXmYlo1ECaLOOCfW/v4KqJowpCbeFJFTX9AfrGTZVbNJwXGdOJku/YysI2e3q4iDqLI9x+bhhCdgIxDpy5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716768; c=relaxed/simple;
	bh=oCtYD6WrFTqNAI1VrGeNu5viopS22BzTCxA/dheRKnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzsAEb2eBAwz6lxcK4r/nbAcJRMfmH56gi4e9gbuhL1dCOwwp5rg607CABjI/1580X28QvhLLs/8IfT7jzEEQut8/DVYI93fayzuj60gAqeWjwU9k+EShsiLeu/XhJAGP99k/1RMKfSK/nSQ4pEbz2c4Uk6YHzB83m+xUXQApzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWss6K5R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2211acda7f6so39055845ad.3;
        Thu, 27 Feb 2025 20:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740716766; x=1741321566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xF0/ITvO5WMYcIVP2X8KXWndD7+120RKVLBcHZ5P1k=;
        b=kWss6K5RzmfcVPazTGgoQnu6XbS3GBjI9xnmAFtCAK7kT0364JPzWZ0Cul/sxhbhDX
         S27C5JerD8HJcQegXX1t4p/6eYJswRW0LVuLsthrxnewBBzWLshS9m3gRRxh58Tvxlf5
         zMdf2mm4ib5Ry6gGmI4qNc709nRIti98YVAOn687Cefhwvyan2872J94nuJkUD9ova7I
         T/+V+prV4bB1fHneiwxkOBFsSF48nWtIgXdOPppJ/c3nxJKzoVgqs8WCyO1n6Jr83z7f
         du5asy+kFpgpqUNxQbDxbu0+WNsysPJ4nl6SgjuFd0hzf5dym8zixpgJGlVN1oJLhyQH
         xVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716766; x=1741321566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xF0/ITvO5WMYcIVP2X8KXWndD7+120RKVLBcHZ5P1k=;
        b=bRnHoRDFlDxeLH4VZBlvrl8BNC9aHGpJS0+KiPIABy4voeOYxXviPWI4kZCfCx6Hou
         Zpvsa2iT/dcruKhLX5HYFLIT4rzOwep0LQ90WGqY+R2evox45KHURsqnLfWnyc4jB/aF
         5B1bQOYp9M3VaeG5zWH6teq6/ZRL8w5Hp7uN92MHNJEQOWzhU10bbqMPMAg7sw54H0HZ
         XWb28KBj5+jHaskrzdb+m+4oc3rN8akWpSCZZbJKjt7sgJSO0lm4w0pTzPYrU9HQno4a
         2qUz/kSCp7cszKGujUK4hEakrkr+E5XVb49jKfS9IbYxHeXNlHJQS1AjiyuBz5dR3a9c
         uP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnnyyAlUa0Lu9lWG+z33nYqMd9289xrk6ZcQ3h8mcHGRKfexPCnBt1Dr8zvYG4TFkZGIGJh8c68J21@vger.kernel.org, AJvYcCXgxzR8BTWvc8iMF8soIoztnnjLLY6hh2+RC24Jn+euTdmKoIk/WVM0jAHQVUgll25ZQUAQjwDzA6fJPgky@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmINUpW4OffGDTMEUO3fz1sbeJJ+G/gYqk0LcsJSUrz+F14em
	Q8Pz5qMj7CBskK6WZEJEHoTJUoGrIeKLthJdW6SjWwGD7ONbnSfA
X-Gm-Gg: ASbGncsRdNqPLbBJJGV8E9tJsb/jw7GU7//VXR3BSyqJ7VTWENm8N3U1/rCZsRuiGK4
	VdcuVDvYOyZ/lsA8Cffn6H84RJtJ0uPTerE4V8KWBZmuoDkrCSvELswMGSMnyy8aN+OZLNPPaL0
	1rJmX93CBpR9IJDtRkOgcEQPDHPkF+mCOF5+v9+WIeUsqvNme5fexclufOROE1DGtM3P5CLd2Hv
	zWZu6oHgTrlpnHV+SeuncRPkDPrzFCSsUOLKm5Q1reJOC6WI3UJxsvbr52tacgI8Rr3tOYsOsH2
	vXEU4udSWzBMIYEIIZstWr3p7w==
X-Google-Smtp-Source: AGHT+IGcN/7ZdnUnViL3/CiY09K67zXvs2OcKFnG2mtSFgj254Meo+xHdGmJBGbEey5mF0hsG5ucHg==
X-Received: by 2002:a05:6a00:a8d:b0:732:6248:8f5f with SMTP id d2e1a72fcca58-734ac36272fmr3094637b3a.5.1740716766478;
        Thu, 27 Feb 2025 20:26:06 -0800 (PST)
Received: from [127.0.1.1] ([49.130.82.63])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dd19sm2738318b3a.131.2025.02.27.20.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:26:06 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:25:33 +0800
Subject: [PATCH v2 2/5] arm64: dts: apple: t7000: Add backlight nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dwi-dt-v2-2-4243fe8647a4@gmail.com>
References: <20250228-dwi-dt-v2-0-4243fe8647a4@gmail.com>
In-Reply-To: <20250228-dwi-dt-v2-0-4243fe8647a4@gmail.com>
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=oCtYD6WrFTqNAI1VrGeNu5viopS22BzTCxA/dheRKnA=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTrQccRqi/70AGCvdLF+ZLysUS8fqDbEUVGi0
 47EJSfrLx6JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E60AAKCRABygi3psUI
 JEVOD/9WIFodfJZl/qM5omn6+3fHjahLg0o8Rm4NIX+Fn6unL8EopVkKG1bxI4jXzxsdL8veKi2
 d4wCK7UiKE9Bc0+fp05IZthkRoxaftKtSUIgmHETLZrRuz0NLwjvKd+Vd5aXkjcspVC34dsNNwH
 oNaXD1u483R2VzY2hniobTUo3NO83/H5iQBWQYzgltpzJzsJ0zjoWpeUDrL8OHNM+Li6CLoKfj7
 JDEDAwRHuQonGDbQJ1/3AuFCryQxnaHjHd2YPGqdnuwZCnpgM0qT695t28ieq2KMemmNWpUEwJg
 3MSOIDQ3NTxlCNPdgKPGLfwNrbCqGnMA35WMjaU2pv0p+A9+wArPkTykjXcyH6Fbvaj3B9JZP7z
 Cv6HtjJ3cSYspFitiMJeQL53FmX8BB8JyOw2upuOOQVb1NE9LLWdqSqtoOA/1dDRNpydzvqb57h
 HuVnbkLyGrxuC7QYryfbOlEWTNMlf2jx2a0J9fVwb7Z/YMybfuRyiFZV+Zw6dLTA5mJLPM4E1LR
 5GtCcC9w9fhzNVTY5jGFWSU+qCa4rRqglMBCS6exBQYGOiSiqc7kNRN2UQx2RlGADSW9IJGGWp3
 qWkr7WdyGri74LaBfuwXm1S+ukhcr6GZUrKwe4lmhZOrlVqe8+Fub1WWYPZka2Jo4+rxGpgtelB
 iE/pMuaMymqNWdQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add DWI backlight controller nodes for Apple A8 SoC, and enable it for:

- iPhone 6
- iPhone 6 Plus
- iPad mini 4
- iPod touch 6

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/t7000.dtsi          | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000-handheld.dtsi b/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
index 8984c9ec6cc8e3c86281a3da719edb56c5bb7f5a..7b58aa648b53dadafb3a01d9ae1e01afa6cd5869 100644
--- a/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
@@ -22,6 +22,10 @@ framebuffer0: framebuffer@0 {
 	};
 };
 
+&dwi_bl {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 32cac8c30e62d657079dbf32aece8af0fd9cef38..85a34dc7bc01088167d33d7b7e1cdb78161c46d8 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -155,6 +155,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200010 {
+			compatible = "apple,t7000-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0x0e200010 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@20e300000 {
 			compatible = "apple,t7000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0e300000 0x0 0x100000>;

-- 
2.48.1


