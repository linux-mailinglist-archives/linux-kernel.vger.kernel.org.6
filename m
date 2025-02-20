Return-Path: <linux-kernel+bounces-523678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821B4A3D9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015BF7017C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F221FAC34;
	Thu, 20 Feb 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIY/Gefm"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6341F473A;
	Thu, 20 Feb 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054164; cv=none; b=lYWbTyLNpw92kWXmJjAvaIRKkONZWRcR5T+ld9tN5F+mDvDmGU6jK4yPJxirj9rTVD40R/yaCJdexs7TjcpUG0QM4AMtXHfkac3af9FPtrLT8Wcame41VeuRv1N+YHBTv9NNAk0EGgxAspd6N3MoE3WR3+//p96T+FFFXGi150Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054164; c=relaxed/simple;
	bh=Dfmhksd4L1Rm6h/PJVjQgqmA7UT/Za+zMY19qrFBfHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWC2oXGcN+Q3URaF/dbc3yqgJim7JQ0EwKWEqozBHcVfAzi9u+WAOF4AyqBVPyjT574aYEXZbatyoffSzwjK07EeX+JrH/au/UNvQiyVFlEcZgxYyFsZMFVh/suBuKzTILVAnfPYVRfxJ2kF3jwjCytY1r7b1DUCOea60bNuCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIY/Gefm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220e83d65e5so14560805ad.1;
        Thu, 20 Feb 2025 04:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054163; x=1740658963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9SN5Eoig0xDKhvB9KRORQRZL5RX1Z+GyDwaupX8zwI=;
        b=LIY/GefmKM+TJ0lXakHPmkWALP0hehEQwFH/bqPkbvCIJsSXvsXBgoqk3T157AMr1s
         f1DQDK4JepwevmuGr3td4odaxHeuoIXyax6yLVJ1RDjEKao4ItdXi2oY52kpVfJdfWty
         eljE4uNeko2CNQTkMddQTUvqNH7uXnKfqiXQHqHUztbMrEKqXzjXsqxqjXlRAZMOh1//
         2HYHrf1+u4+IJQ3P2d47OTQZ2RGz/kaBpyZP/eBMETZquAM7xxfK5+FlfRbj8+//7KmC
         tXDYseQ9Dxukbk4ArUxUqJXpMhPO9ZUaCMQpYpP7MPnn3MLdrQ+VC/cPrT7iacoVpU1p
         tfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054163; x=1740658963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9SN5Eoig0xDKhvB9KRORQRZL5RX1Z+GyDwaupX8zwI=;
        b=u3yyxM6qVKcUfATS+TZcXmSbRGzEsRqHTfMBaeNT95t2wgzlH8HDYCjTc74AgvlYDC
         6bsi9iQpqhkAp287w00lMME/Fes7H72frbagoJZKe6beollJP0dGhAiMba2jmqnKvfOu
         Kv/B36e1Mn6tALEgiKo5f5jSY3uu+ApDi2ZkTwwuh3LZ+yWmpZDGhXCu8GXxULFU9J/d
         ZtZXqRSkMvJ+62mBrPvMWbH49MqqMFdY3dcVmuEuYPV3fHsnj+Dc2bk+DvJamRDvU3cR
         vkFXwv8w4Hc6Q4VE4HhrxBRRIFdHORP1xH0AZZKnRtMGwLFtGbAicbQsKH7TXrzihr+n
         PsLA==
X-Forwarded-Encrypted: i=1; AJvYcCU4sUeMZrdWPRdJonz/TRF5KL3ackRpFKme9YHY0vFf/5eUiRofHSZtmjxrj4u71YE/Ivqw3QAw5YxE9glb@vger.kernel.org, AJvYcCVtVGWGV3bDF6OGpHmd6k8aK29fY1okh6fa+G6tgC0ZV2H9DnlA6zuuiEGULOx4c6iQoP64e4EPpeKI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8u8SoEXWsZHbHdWYQcQFjIHIls+avbJfHV8fBSLPf45bAm8GE
	LC0yThTPS29tGTVehWKwDQ1CxBeNLVLhG8t6qIRqTwO/0riTsfNx
X-Gm-Gg: ASbGncswgFK6OWiij27ktx1p7YT7e46eA67wI4GD4r2Yf8Rb5gegZAkgeCKvFKNTPV/
	082Qa3u8ZyQpY872EKDtpiyHtKCPpil4UHhXd4KUs4iU7ts7b5H3CAiYjWei0qLy4hFEOkNs0Yw
	ThtAV1OM7eoS7x8o+Ky4OumXWG3YTKLgV0kDGD9BA1gag1OburF5o33aK/bmgzkYGUc1RTXb7Ew
	RpBg/SP8G11vi3YRxLiWMvDFRFi/VhGMyxPhA1CXEEtQE4DNS3LyriRvG+SqpzIc0m/Mbx1cz+m
	QDmfiMIpibx9p7VwXQ==
X-Google-Smtp-Source: AGHT+IFxQ4Ivq08K8LrxIkk5hOu/VGJU5dDZWvlSYladnojjeQ5WKVi4wfPpJBQPRW5j1JaNBUrmfw==
X-Received: by 2002:a05:6a00:1405:b0:72f:590f:2859 with SMTP id d2e1a72fcca58-7329de89652mr10240013b3a.13.1740054162588;
        Thu, 20 Feb 2025 04:22:42 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:42 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 20:21:47 +0800
Subject: [PATCH 6/9] arm64: dts: apple: t8010: Add CPU caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-caches-v1-6-2c7011097768@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Dfmhksd4L1Rm6h/PJVjQgqmA7UT/Za+zMY19qrFBfHE=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx5+wn0P0SXuQNu2JS2xVr8rjG8vCoLlcQzwi
 opsrQdgCAWJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7cefgAKCRABygi3psUI
 JEL4EACAPtlVi56MJnkSWjiiuqtsp4bsgyC2CktAZL/zOwsaKSd2Dn90xh3+V1FfNcE5TYiQAQF
 yiA+2GxSaYsRXwLtppeOcOy7c4kRz786SjO0P0IVCCvZdSH2M5v1p5E0qV2i/FYCjUFrKoEdu6p
 VqHZ7kyEkGYsP/kC3k8IjyTX/qGkbY9rADnqCTkbhsVXIPXxqh5g2H62JHzGBzre6Z+K4A2HwWX
 oDNeff1Ii1L/VKU6OUrWw3v0K7TLsTM5Y/4oEumBJIhQ52csRqK1RJRBVCQgOga1sU392gi8gJr
 CbqEOhJn6lJwWPEvfktgbcJZ0Gjl/CqokvZS5/1R2b6Q3MqWV8A26pX6L8sB0WqePolyLE10f+f
 brZvtDdDkpKWZjP5UiksQarH+u1XHUlOn0QHVsviZss08665e6Jro5RNqzwOJTgVKpbwcpGoJdu
 GEEJ4zH/MUWOWf6wt/iTN4aHb8Ut6T2cBwFA1ZB1JAxut6guaBAOou+KcjcB8FHw54ho9XvkPUQ
 a3WKAzu5ZuzLRu6kc8wOny/DtET/ytishoRxnhn9QuHqh1SRHkLWyTeJZAL6jgaSlQXCFr0xh9O
 6H7FrEKfXjcOVUbq+aKNPitMObxHRsG9GIIwnfpM50orSS7+WptaB6olYcmA+J5Pxn8YBofQY6h
 KMQ044wHohMUA/w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add information about CPU caches in the P-cluster of Apple A10 SoC. Due to
"Apple Fusion Architecture" big.LITTLE switcher, only caches from one of
the clusters can be used at any given moment.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index b355d443ee476e7c98b352470e3b1b5d0fae7652..5d24da52cf255b6ad211d2ac40aad75a6194d595 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -36,6 +36,9 @@ cpu0: cpu@0 {
 			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>; /* P-core */
+			d-cache-size = <0x10000>; /* P-core */
 		};
 
 		cpu1: cpu@1 {
@@ -46,6 +49,16 @@ cpu1: cpu@1 {
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
+			cache-size = <0x300000>; /* P-cluster */
 		};
 	};
 

-- 
2.48.1


