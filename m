Return-Path: <linux-kernel+bounces-523673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF4A3D9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F0700079
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01E1F4632;
	Thu, 20 Feb 2025 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="komIrcut"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C61F540C;
	Thu, 20 Feb 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054152; cv=none; b=GME59joQYXeTf1gpU4ooVAelCcSKkDQH9at/aw4Pi0JzhEazXP/wBCnN8F4FKA9hckyKW+DCTzXgKicwrkl2e5UftXBmskjt7IvN5b4e0pVt9ylfNducWpHr3WDFPBrJPI8+5Ey18S9xHjI+XtBVZpuwxfrLBSauu1Zrh6J7KlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054152; c=relaxed/simple;
	bh=v1V3E5WkHVmqS/D472EV2ffRCymQYBLBb580WG2bKlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3jAy6UgeZf6tcTa0TlDryBMgbUjkygHM6joQM/sXdgJ+f1U1tVAK8IqbcWskur090g8uOU+xEebR9hvjPOwVJ6t0LuShZ3dqJCoZ0gcxWGy6iNFDSBdUThBRjutG2Tz3t9V+Ug4fI6OLMYrJRVqNSf0WWGYM0LKQLNBl/Pg56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=komIrcut; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22101839807so16762565ad.3;
        Thu, 20 Feb 2025 04:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054149; x=1740658949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+fH+M7M0QPKx2zeAS0ZDdKGKMrlScq5PHQ29ysgs4g=;
        b=komIrcutHegslfTHEaKXXfNUyv6gkG6OrMkEJWgpOcEAjDONV5oYgiSzy0LAfLSwsM
         ktdg1Wp544lP5txMg1fRJQCPfy6fqISNUUNUpWwSHa+MUZ7BgaaBs3SqOllFvYGpFeNd
         Gsdtgvj48Z7RfOYt7v92ybkVcxZTh1y8xvHRmjOLjWvIQuu7PZUG4ftgA0CCga8dkWXv
         wSdWUICv8PzxbM8Ytck5ByMp5DTsWpE4oz49ncq8T6lZgimSHMLmdkdixEZcjgjbK7+9
         YdUJ63XRS7nEgHelmet6agwdfiiv3Dv/nXK0kF1ut4WpMO1XD7E8sGWod+7zhwARsa6a
         Xe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054149; x=1740658949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+fH+M7M0QPKx2zeAS0ZDdKGKMrlScq5PHQ29ysgs4g=;
        b=o8H0KbMRpy7F1NDfHu3T4q34+VK9PXl2iBLptOepzTQs4cFc1GcnZn6mLuJ0K4Vj/5
         e3vjAb80CubifM9zOoz4vLY79X9TziBMol4BsA/e57dAwB7nXKgpLNrt9B4hYPoN0gJe
         0N/Rodvho/g+CaDpT+2Wma4+Sb/Uk48MeT2jXIwvJ/dD7aUmCzae0XJ5fTUFHoUKUBMY
         +Jxltl7R5p0irCP2V+4mPgeDj83R0sKbHhbqbEl6/w8aHooheWAeqONna/S11UKkGZfK
         7kWuYSpaj1KF/MU4p82zxP9/u/Hjg+aZA36JL+mW/JpUYg4JDG/SwGVzWGxKbiVTO7Ld
         JNZw==
X-Forwarded-Encrypted: i=1; AJvYcCUSTCPKlcd1q001uK7AZVwmHWpR5Q1n2pI4PvK1yEGYhQ5hF5xSk+zrKhbdJhFXrpbsC1/WemB1j5xd@vger.kernel.org, AJvYcCXPZ8C/V5eB4p9Jt5d0wJKXB+IkW+mV3R2kPV4CXjMXKmENd830NvBR8YJYX4nJKDU48ClBckLgyp2aSqm3@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKlOCRib7olprQYsw4lmYTVCU1xsndukfbyGNHtFHPkbj+x67
	LTl6VIYPUtJU16QgsXomxLaUV67TUctGGt6DkDWjQV+zompGgqZx
X-Gm-Gg: ASbGncvuTU65N23zAJJ+SE3VFrCdHVDJwdFws44nO7Ohce5X1uwn57bBbocWwUABnfl
	Wj+GgHjrc/UFUyBRp9uo5ohDnA//oRA6AgS99V9cWooh7et5K0jYYyJ42hihF64NPHgROUvQyPz
	z8P6bQzima0TkFPPIdLcC3i1hCXhIMTBfSevFWDrgvKiKUUiHaIMls698TqAxLeLGt8xUQPtAOB
	Cm2J5oKWY8YocP5RvoE/4D2S93Xuybu/mpSlurqo1W+B1hV65t99gRr2U/T0TmLVm1M2uM8SZwD
	sSSbJxNWKZLe9EXfPQ==
X-Google-Smtp-Source: AGHT+IF2PoDb3Kk94qSCiGVpPAbMGoiZGlMtDUf/oiV3gQAi27yF+wvBuQ9G/yPKmlllaTDzw98zZw==
X-Received: by 2002:a05:6a00:3a0a:b0:732:1840:8382 with SMTP id d2e1a72fcca58-7329dcb4d5bmr12388136b3a.0.1740054148987;
        Thu, 20 Feb 2025 04:22:28 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:28 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 20:21:42 +0800
Subject: [PATCH 1/9] arm64: dts: apple: s5l8960x: Add CPU caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-caches-v1-1-2c7011097768@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=v1V3E5WkHVmqS/D472EV2ffRCymQYBLBb580WG2bKlo=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx5+88E85lGcMv8Rj8CoWvDh/DXWVEM+KTtJu
 lJUXhUbSkWJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7cefgAKCRABygi3psUI
 JDxRD/4wYsk1/SWK2Ze/Ilh8czAZLIhE+GPx1uP9bjI6owuI8/GWARs6kAN5HV7P2kIug9O3TlK
 SGNQfpNtxf67htonZKRdu4kErrjtaCV5FoaGMA3x/cEtmjnDgykcmFBFvQHtbslefA58hO7ecHA
 TQLAb/Sk+O0V0IByofqAXToAuNED/5DOMi9TuNHGa9kEuRMpMkPb1X9YcDgkf7il832Ptc636ub
 lILaGQ4isJoWthOXCNIQa9wkbFvzKucQbZQegUEyMWp4xn73KbVIgpo1+ZyIZB7zkNbdTcedI2X
 otIBsmJalY7NaswnfVyKMSH0F+wpGjQgfZWKhZqsgmkSB5MXu5IsTA3hBVcEAw3QGfzf9wPQWf7
 h8MPZdmspfFdTT/ppimuWvjYfClFIpKq75rR3AnJD50wbi+BNRmMeqBXf2rKu28VW1bfLkijt+G
 PD74iwbKDli6QID3VebOC7qtKLIJ28RsJCWHi7TF5STxA9BMlhWxoJkwMvYiuTN/0zS88pDS5EH
 t8Z8dUEQPtPrpTWurpq3cuMGVceCUXIiDPM78PF8r7u7zAyUdBMDsC0kNos8D/psYlNAPWEAUBj
 4OPEPuP0XjX57aRUr6GGC2VZs6pRg7EexeAPvDtwKph2iP+Fex6DTQBOJn5K5AzDfpbK90HsRfj
 QwNU1bmoLp2Nsqw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add information about CPU caches in Apple A7 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s5l8960x.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s5l8960x.dtsi b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
index 64dbae5c73515bb6a1651b9b26d349d0cfd0408a..e58a3a280abf72c0a390cbefb4fdf89942d77512 100644
--- a/arch/arm64/boot/dts/apple/s5l8960x.dtsi
+++ b/arch/arm64/boot/dts/apple/s5l8960x.dtsi
@@ -37,6 +37,9 @@ cpu0: cpu@0 {
 			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu1: cpu@1 {
@@ -47,6 +50,16 @@ cpu1: cpu@1 {
 			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x100000>;
 		};
 	};
 

-- 
2.48.1


