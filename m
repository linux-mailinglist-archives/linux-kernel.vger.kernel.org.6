Return-Path: <linux-kernel+bounces-523679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B0A3D9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771AF189F780
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA31FBEA7;
	Thu, 20 Feb 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtrK0iBM"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD161FA177;
	Thu, 20 Feb 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054167; cv=none; b=L74lGvZylPzr8aaSSuXgquPBzgHSmrHcDOKwL67Q8mEZayjg0rYE6wCsSJmMfD5ec0oBO5WseOyxK3dTn4wtP6l5lA3Y/NJqm1JKNE0t1r7sVFTIWGZ2donuCesgZYaRg1dlV4xsehTCGASuqNjuh6beERFzYo1BUSrWtSnMtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054167; c=relaxed/simple;
	bh=zI2mU3THGBI/qZwjr8HPXhOqtbnEjJ7My15CsvuB0w8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyFlKnNslIT1fHJjIztYwrAXCnpQTsNu+cr+Vo260qqfWPuWosyIP3JaR4Fz9/7GoGU9QXykTskRHkqUMrvoEN/O9yBq3n6k1peO7l2ZRQVV73FpFsnta6INxCu7DyqxjVzkKF20QfAWVTlr+Za+7OgBOQbr4uKpTpS01Dfos44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtrK0iBM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c8f38febso15629505ad.2;
        Thu, 20 Feb 2025 04:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054165; x=1740658965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06j6RtBWf/SB9XKP5erUkzRtmNKED/ygWJtIdZVtIY8=;
        b=KtrK0iBMEmFHVOZ9A/u+akMdMCDPnr72soJhr4uPvWXqyRFf4pKEXOeqzk2rJZ6T8L
         IsxAGPLJ42swTL+NqK0ZydPFgYY6Jc2OQJKRdgobBzavezWBlY1KBIOY77ObPmKYdScC
         toQwPuDxg9AFJma8cFOi5x5OBYftNjALL1hBdxoAHIUQ0qKXq3ChDuHopiqpn06SR9cu
         uBeD1llOEazDjtxsOHjdN6gSpn1Mjr3ZL0tLxtERyu3c7tZ5ZqkgHHsOm/uEW+CrBVCo
         UjLVPLAR7uZuxCcCAjevWeL+Ie7AIy/fB/LPcbbuHgIpSa9uMLmPxkf1yxpyfaRsDX9E
         VYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054165; x=1740658965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06j6RtBWf/SB9XKP5erUkzRtmNKED/ygWJtIdZVtIY8=;
        b=NU9D8lUqVzDhPmzh9v1bzmIMeJ5sn3njOJKoJyCxe3dpnCC6QfF+2lZgzo5s9b9TJB
         f8gMMaep+TYZ4VZ5ZYRxk2mga+JKqx1f4Hp1uLb/8D2bZd68WMvOD+qgvFXhwxSqGDV9
         CLPB4vGP5R1NZ9CK+ayXa4nyBEdTpzqFPFANGw/yh+R+AC1zCE8TWo505zebCZUPBPvZ
         iyglFFB7fxYhdhN/xBarVnFH5P6PQneGQyFhdY/o22DmXj8LVjHNXqxVpdacJEpULIbh
         PIv+FTSwcw8C2tEXWr6ldYle4EEuiHEi7wE3HVBBkQ8z4vdoa3Wh+evm0LHrMcmXLFAS
         T6qA==
X-Forwarded-Encrypted: i=1; AJvYcCVwTmdBcLWEV47gIia82ZyNG86w89IvNsAgh/pFCtMhiU9ljw/NUz+UiG7xBp9OmMvec/WOTSbrf6tw@vger.kernel.org, AJvYcCXK0XBqa/W38xNq48+RT8PulTScMxQ+fqIIGjR6nFfLIQQCMKOaFMA03QBuQoL+0347YOvAyaWhhIbfXbov@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4ZuTzXHIOZRM/eM9VwhQnxW7lybqgQvIUijahNP+vZPJYwBi
	qA/geUZsmrileq8XiuUqiRGXzODykOCF49nViusQ0Af9mtIv3hLM
X-Gm-Gg: ASbGncu4R/O1K7Acg6+oF2/bAUU+LRWjiaYX4yZrdUI3Q/ccKY/jBxE4VZfbXN9BKvB
	UPi9z7Fb4bip36Cdg/kTDHp7LWw+AjAhX16QLaoRQH6oE4yC2ye5HP4szGvz+juq0noZ7K5Oleq
	0KQ4E5ueddHrUI2fdxQmed9iMuyTXaDTciSpsBYyLbc4XaXhapu2PggW4VLFZg71Es3mSUaY2zW
	x+V3shoRSHU+uoX5GcnfImmLWgy7IZYkUMiMQdf8VcpIrbcqlOguR0c1czdl42ALDB3cqKQHrn2
	kBmhuK5og7bK2bs+Iw==
X-Google-Smtp-Source: AGHT+IHX6zQc8fZnaNaePdFLlfV/v0LorrLqzr3llooSCuG/RxxUTULc9mi7JINEeUMKLM90DGF+1w==
X-Received: by 2002:a05:6a00:190e:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-73417248c3emr3713491b3a.4.1740054165339;
        Thu, 20 Feb 2025 04:22:45 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:44 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 20:21:48 +0800
Subject: [PATCH 7/9] arm64: dts: apple: t8011: Add CPU caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-caches-v1-7-2c7011097768@gmail.com>
References: <20250220-caches-v1-0-2c7011097768@gmail.com>
In-Reply-To: <20250220-caches-v1-0-2c7011097768@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=zI2mU3THGBI/qZwjr8HPXhOqtbnEjJ7My15CsvuB0w8=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx5/AKj5vauHYhz3DfFfIX2pH9PD+H337k4Uk
 5uSEa5+wZqJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7cefwAKCRABygi3psUI
 JLuhD/wM4qvX5zEl3VWs0aFrwG2bhjCQ4fsHzRIbMX4t/QUJiSFPMj4aZzuijF356s9GNDgoDKn
 EZ5g9VoT8Dg+98rBT6uqeHXj2L6bHTcyTiy9t4xY/NhaGE4ypIyshyoNL7DiUsC6fy1YGWi5rcV
 McmYeWDyZo5ViKj7VYF30kYsHNSUTArkp7AdtInWMs5AKNbryuLtLsqDAQhDxVV7r5/IKlDHWB7
 7502iVR24IfrXOjvIhvCn07cvdTVFMXOtXWTkO8KwI7BagcMRBp+R5mSjvD5n3kadAe1KM5CoZk
 LdlYuMnzi2WEJ2SD8ITlgPNpmxbRMGtn6UDc7zAUn0WehYWBKImzKTbfha7a5140/utSUhgl9Zp
 ctahKcWyNgZcP2i15R6XNk+K98qnNc6Fq+QGlv0g4RsgLyQPPZt7WGdgMxTuNiRxkYvlkLt8r4m
 JiNtxJ2Tiy24xVvz00Av9kuXL5prj87h0s+4jqVB6ipQYpbyK/PlgfISQwBkZmxB1n1pYktm8Ck
 K1/1xOEE+YEDxlu/nDUXDQwjsi/KMePbGRLq31s8deKjKMxTm+zYyCyQbpFVj9DEh/2XoUXVo3k
 1xwujG1l5vIIYbNrqcVuuqRLTs0pBohjQbv0NPnsJad4wv/9+zN1NwWxsAZsfj4MeK1pF4xY6Ob
 Q7UxJoG4IhI/Q5Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add information about CPU caches in the P-cluster of Apple A10X SoC. Due to
"Apple Fusion Architecture" big.LITTLE switcher, only caches from one of
the clusters can be used at any given moment.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8011.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8011.dtsi b/arch/arm64/boot/dts/apple/t8011.dtsi
index 5b280c896b760dc8b759bf38dae79060e34dfc19..974f78cc77cfe28d3c26a52a292b643172d8f5bd 100644
--- a/arch/arm64/boot/dts/apple/t8011.dtsi
+++ b/arch/arm64/boot/dts/apple/t8011.dtsi
@@ -36,6 +36,9 @@ cpu0: cpu@0 {
 			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>; /* P-core */
+			d-cache-size = <0x10000>; /* P-core */
 		};
 
 		cpu1: cpu@1 {
@@ -46,6 +49,9 @@ cpu1: cpu@1 {
 			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>; /* P-core */
+			d-cache-size = <0x10000>; /* P-core */
 		};
 
 		cpu2: cpu@2 {
@@ -56,6 +62,16 @@ cpu2: cpu@2 {
 			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>; /* P-core */
+			d-cache-size = <0x10000>; /* P-core */
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x800000>; /* P-cluster */
 		};
 	};
 

-- 
2.48.1


