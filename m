Return-Path: <linux-kernel+bounces-524119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2EA3DF74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4E189E41F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED5B20B81D;
	Thu, 20 Feb 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6/OR8Qj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C681FFC75;
	Thu, 20 Feb 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066711; cv=none; b=M9FQMFsmyNKYul3P46csFivlX3R1yGCKZ+CmGWD6JmGcT0Go2dpI+EKcfKS0W4xExWHkhSLsFBWgsoe+bzjC5Dc6p/Wa1ACxosfwLT5qixwXleuHqaZGoRchMVIJT6oOV//34KrjFnUZusfHvSunsHHIs3zQTW6LAWjB1YWzw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066711; c=relaxed/simple;
	bh=luAsDSB6foc9kXkHd+Wi1yTbVUxTP0P63sH7ctTXbEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCIMnKAS9yRCuToNc2Q0b9hOZPjyabhw9z0oqYHWY36RupYdpy1bCfwAFMoRPsTt+YM9apIee5BSJRDSJn2bfI7xzsUDvJI+cXJbfa4z5mAxum4Ap+joISLPvGiDlC1AMKG5DJr3ppJqY4H/1ESyKppD4atfXbjAckWMP+TzswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6/OR8Qj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22185cddbffso31641875ad.1;
        Thu, 20 Feb 2025 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066709; x=1740671509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4aQgk3OaAz+HW++uMuDv22SLEQxIAOkffPV23e8MfM=;
        b=L6/OR8Qj1XoVSeY/ryKBEgyayV+3830Qcm+tYlTwECip3eh1aHOHO9KuL3ihS+zknX
         VcRzRw2TKzj78X89xv5gob3lP+tRQponQjeJ7+4vLKiL0O2XGb9DURnGSQpHE/86aivT
         mTnD6l7pCUEXZc3exXOZ/J541KoExH7EXsL3ICvap4y+7mOfpFLm/MMCnuzYeLDQ6b56
         4BsUJ3NB7Qr15JvNbqBkwTDK7CCwbtZS22HoAvNJqv4PcpZxrAi7Iou0P1z+Ms0xZYHY
         Cq8o9w4HDIzjV5IAHxZiYt2YIttKccHeeE9+rNn6bB/QrzqwgTvafHBgEST5G2kbxxwG
         A1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066709; x=1740671509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4aQgk3OaAz+HW++uMuDv22SLEQxIAOkffPV23e8MfM=;
        b=cUTVkjPXflXnppKtKqrQjsylRzmb7JjwHQ53KJC8Fe9WJrYboN8wXo542wuX/miWZC
         RAEbbBu1sbnqwTkqKksKqaBuPpw9sT0EjoLP1AJc+aXal0kAnI4r07vqEpMns79JYhJR
         6iWpIjt7SouJInXptAOmxvr4hwBt3fVyf0u/CXraoDB0ypZhxGnziXKCj2+tWHxDc4g9
         3l3LJJAfZGNxCVTTiNbqME2ie3ArxVpYiWnJau/GSEkpRlrjvjPXYRJqqbeT5JeUIyGr
         16MXotgBzKKAMdZHpGyhG4q9tOoSICnVnvvxkie0amQZh4XtQ1FGs1ld0EH4ipxmX61Q
         7EJA==
X-Forwarded-Encrypted: i=1; AJvYcCUyYosTKOWR2aa37KZRuX/oa1V4um/pqiOCBmhY/n4bWHTXRRPvWg5S4hIMDm//yS/eVqX8xN2BCRTqDMKv@vger.kernel.org, AJvYcCVWAbpr6EPYnQFAkXYQwfnw314ntbDze+WkWWLyLPi6c3w/8B+TQZVFdeUXFchFkHxKfmU6V9Mjb7rF@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfJd6uQSbjbaB9DfUZYx1cjT0j5KiBm9zAB1j466XBCSf5Jnq
	nPIhFDhGwWgVxEQhVu4AT9gOjko1mDcq1smm6Jngv0ZG7gKU56ij
X-Gm-Gg: ASbGnctESwd4gey0S7E0bk+1JDEKCRSqk1DPywYHzARp44qvSfIntqUgRPbqni/NgJq
	1FmRjmL469jB8xmL5jQAgNnLkBgY6DaAjl7l+Kp1GiP/eU5rPwDGjUIDuiBYJ0yfgaeSLPI1R0t
	wOBodbRzMTTdE0Y3oEqkAIXRsD4vYg/NdCrVPKlIIutuVIU+8Syx4HWmM9YsE2lyUrt+INmT3Uv
	yq4D11xzcpqmB8xwIlaITB0KeaaCRPV1x+XO1HbFUIR4cPVU9FEvu7vfUvcZXLduuwRK2IoS76J
	J3DvOVIMe6egfWKJxQ==
X-Google-Smtp-Source: AGHT+IG8+tySuiPwp6e1P8g9EupJn2/5mZidEyqnFWhQeW8NtqM+gsjp8A0ihVyYanOl68AklBppTA==
X-Received: by 2002:a17:903:32c5:b0:220:fe36:650c with SMTP id d9443c01a7336-2218c541d8dmr65265325ad.23.1740066709139;
        Thu, 20 Feb 2025 07:51:49 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d5349019sm123694345ad.36.2025.02.20.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:51:48 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 23:51:04 +0800
Subject: [PATCH 2/5] arm64: dts: apple: t7000: Add backlight nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dwi-dt-v1-2-d742431c7373@gmail.com>
References: <20250220-dwi-dt-v1-0-d742431c7373@gmail.com>
In-Reply-To: <20250220-dwi-dt-v1-0-d742431c7373@gmail.com>
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=luAsDSB6foc9kXkHd+Wi1yTbVUxTP0P63sH7ctTXbEU=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnt0+MtrP+HahF4Ws+El6cSLJedb12Xm/j/cLRD
 c8h5+KlHauJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7dPjAAKCRABygi3psUI
 JD80D/9KdUg76YCKbS0mSsA3J7LKv1mLTD6o4hPFbRG9wm4HfANcy+GEfQ7inaMUAtml5SCsk52
 dtyoiPt+It9mjEzAHpL4Xu8BZpw3IJpHsDmrYUsRrtg7M41drnQSd+5M9DwUV4htDnOw4/0yFde
 Lai5NyA1NBuBJiO12jeTfLI0EfDhjFxuNSjYC+zRWdxPcbJt3mC9LJI4y0rzm6/nts79yiM89oP
 8cJMkPS3ocfFdpwFrThvSYVH8dvG/EmMYutIdgQ9EgvdvcmI/k8/RpLsK/WYy/c8xTTWqah+YDV
 WhZ1fSSVAagxQZpiyFPWQOnhRuZodpKWPK5GjOfOEXCNqqAjV7S/pl4qToTJZiSBZ9YI8tUMSIa
 rhurXE00I91EtQhPyvOsej8etIiDLfF+7NORGfHY9+ydNtuaHtXT+FkdAMgqnN5F84S2YYADaOa
 SCr3GMHHGR4oynxaMqqLgESA4W3AQj78txtNCbOnd+izrdjhUVWC0G310q8ul4yGkWRYc5rSbYw
 WDmsoZD2KU5UvT4Mt1GLGgGQ5HcebnpTZCUm4XZnS7ecuNK90doy1+lw8EC6u1Dc2eyJ1wTgYE9
 vFUTz+79CGowyTiTlWjuvj3i/xdqup9TglEBwoxS9TwpulHQFoJqT934Q2o1zBoPKjW6NhyC1Ba
 qJ+a5JHbK0RvOYQ==
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
index 32cac8c30e62d657079dbf32aece8af0fd9cef38..98e510b81e26154c258e3359f37a7964484f034f 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -155,6 +155,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200010 {
+			compatible = "apple,t7000-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0xe200010 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@20e300000 {
 			compatible = "apple,t7000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0e300000 0x0 0x100000>;

-- 
2.48.1


