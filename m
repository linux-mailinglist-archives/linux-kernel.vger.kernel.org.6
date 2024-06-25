Return-Path: <linux-kernel+bounces-228833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33BC9167A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426C61F21EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0A16D9DA;
	Tue, 25 Jun 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfhcBB0f"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9316D4CC;
	Tue, 25 Jun 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318068; cv=none; b=QNb9wrGX8XQwFolfjiqc47oq6N/5Qj2KfiNVEejojydOZDd+d2vciS9ruLtjMVnHT5PDtus/6k68DYPbanQT61pD5noy0LxJFhs0x/0tfKw8Ej+T7XFA2pXeVA0umvGrmK9Kz0vWRTJDGZD6QqJQj5mKa5aTvoYjwBLvXJxvVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318068; c=relaxed/simple;
	bh=rkNsjZWSpjdD4PsYl77Z4TmGFgE4qJA71UbTS5Rdtb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjqXzjriuv64DkmO3lkeKpJLRAodmvsMgJmuVeK7jlNkAXSIrPSHclxZM8heWsBsliXy8aTt9qtGV5ZVn+R50skGIqaXV2/+w6knClJMiTuA03BK8hwY6zoZrLwvpqQxWxyxJ9BkeUAO0+qvbPGRX6nGEsWmb3Q/tKljshUGpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfhcBB0f; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d55c28cd0dso137304b6e.3;
        Tue, 25 Jun 2024 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318065; x=1719922865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWdNsyhmh0vXBB+FB8HVJv+VLwSHu6Zd+4+7Sq4/Gys=;
        b=JfhcBB0f2CvDspjlFQqHM7/tdxXwYM/Fxwmar/0Xc2IpYYQkLkGR7OQRLVt2gXSfcz
         JNtlwQ/cwZQ2FL4Edh8SJTCoEQ0nwcRxAr/n0JDWc8nEtb4dkrl2BK3tj/awnJXKJbeY
         2oIAky3hMN7/c9AUkWwMafsbhl6+tUMmiqScKXSrIdVbazIA9FOrVsxkgCT7E3CRuO+1
         zUU4sB6yrdvwS3YACLLi/DKYxiO4lpH8ZoqGrQfsiZ3q+vAnJdx4qu0Q4M6jzAO7G9fH
         gpWUqMVbL+a3TXm4148ykRqUrK3M/GdM8JAZHL04yo4Ebo8vlnKZk3P7cx3SW08pP7pk
         3YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318065; x=1719922865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWdNsyhmh0vXBB+FB8HVJv+VLwSHu6Zd+4+7Sq4/Gys=;
        b=Z9UexfkI5V20VRbb3Ieyw1mBLJ082xG83BE4udVyue/3r0QEbLrvsdWnIQAe/okO5X
         MI8QsQIsMKU25XO+wxTk0R1VUXodkmnmlz4ER3l5KhRsUnS6vDzeLk+O6YvRLileHi10
         B4a0HOz36ha5HngRv/y3Vrr9ZlrMQM8ljBA3lVoO+UIQ06ySFAVaI73mKNCTk8Fq18uF
         fG2GFKgHk28DE+mZuzV4cEKHSmWhY1K9hpYoDIShi91w6TOdMNFm8ZOGTHFIGdwpFPXY
         JWoLAN5euPDxwKcw+3kIVha0PwUdzrp3CRgv/up2Sg549ZUEkClvvaRSV4UonhokJUvG
         zP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVezMMbpmylrYMCZFq0zdRlUcSNolfm7GECOryMSz/NT1l1eCPYfKjGdFXDiSHX++qdJ7vOzbeevptxXi02l/sk0uA4qWvlwlLWtdYV4GMA+pTsU7tp69jH1hTq9L7ChfklE8qRWiSuPw==
X-Gm-Message-State: AOJu0YwQZzCeR/KuP/tT/jg8T1ho0CoBZMNifEMMXmFBoiJ8wxCqDch/
	1lTTtQ8Y0X2uMBcW9ACjiMbxpBYMv+Dm9LsodP3m2IawWGZDpP5S
X-Google-Smtp-Source: AGHT+IGEFlDZVv53UK/DWcjhJ5G3xA9To81EmBORmmF3gelkm71OH5zcWSvbKLKm5WYPYDqrvKMvbQ==
X-Received: by 2002:a05:6870:4208:b0:25a:6d14:f84a with SMTP id 586e51a60fabf-25d06e37917mr7520760fac.42.1719318065571;
        Tue, 25 Jun 2024 05:21:05 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:21:05 -0700 (PDT)
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
Subject: [PATCH 12/17] ARM: dts: aspeed: minerva: add tmp75 sensor
Date: Tue, 25 Jun 2024 20:18:30 +0800
Message-Id: <20240625121835.751013-13-yangchen.openbmc@gmail.com>
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

Add tmp75 sensor on the i2c bus connect to each fan board.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 830616663387..7f6df8750953 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -252,6 +252,11 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux17: i2c@1 {
@@ -294,6 +299,11 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux18: i2c@2 {
@@ -336,6 +346,11 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux19: i2c@3 {
@@ -378,6 +393,11 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux20: i2c@4 {
@@ -420,6 +440,10 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 
 		imux21: i2c@5 {
@@ -462,6 +486,10 @@ power-sensor@45 {
 				reg = <0x45>;
 				shunt-resistor = <1000>;
 			};
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
 		};
 	};
 };
-- 
2.34.1


