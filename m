Return-Path: <linux-kernel+bounces-523680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82DFA3D9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB1180054E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E51F542E;
	Thu, 20 Feb 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ3dM2nm"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303C1FBEAB;
	Thu, 20 Feb 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054170; cv=none; b=YV/DzKUoFeECz0EBvl4eLZss7PK9pfA6NrQ8PZxKJwxyZb/zXM/WMASDMr7yZn0fXNfb0+9DTNGbK+DxqqI28QmUv+sW97Sk8w2SMgVOEwdQJrPrfdBwNHfiKT42WZMPYJULGyluFfKzOQIIxNKYVqXbTjBlTqjzDHf3pmpiYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054170; c=relaxed/simple;
	bh=G+mx3kaje+P3ZyUO/ditIxszcN7HViLpZE3JAiY3KS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqkqZsQJH842oeG8N1SLr+sJvq4P+hElIxnMhf4xAStQucYie8Ly8+lsffqppi2M4i5PRKLJfb3fCyW8Vs71lNb0W67Ehsp2X6/iznHtu8uFGu19DZWhxBNMFTplA2vZ3ecaWrNieUx9mdz7uNK5r75eNeIkqd+WMTlcX6ujVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ3dM2nm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c8f38febso15630535ad.2;
        Thu, 20 Feb 2025 04:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054168; x=1740658968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pPkPkgzwh7OR3QLmRpEkbwB8adYmbJspMBYICok07c=;
        b=PQ3dM2nm0wSZDUqXU5wFKxtNMRlMYe9R/sriQBKanurEUOQs3O+cHPqA+PA4uHzrl+
         EadSvHn8EpyemMhnhGdD4CjLPWQEP+KymVmKySKsrIfmIbwxTbM5xszaV9CXvwN6OIsW
         KriscQz3wNSK+5BUR6t9wrFEJb1Vx1YyG7RvVK7UalM39TNc8ay5x45EVfMOSL5kTQo2
         zQMKSxDaZ56L6nIHXIeMJzuIQf7dbiShSYlQbqiZQRPK+LLHDpth3wpJNcc5bnek7Zsj
         kkiO3UGf8uHvEak/ca4d4Z2uKLEb4BfAqwZS3oII7vh1B4zCn+SoNqCK5tCo1CogFz+K
         Nv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054168; x=1740658968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pPkPkgzwh7OR3QLmRpEkbwB8adYmbJspMBYICok07c=;
        b=Q/N1xHmUQM7zIlb7bjM9L0JjAOnRyEpZHfD4Yd2wd8a0da6SCqi0EQjUvhoF9zZO6K
         /5I2fl23m77D/F6Wm8yCCUstOULTWgVGeGhrJ4lD4IxTxW9AS4D3aRZnreuEQODdYhMa
         HmV4Azbf3KBiTN/qdMYm4XKJCxtz5kNXvh9qSK2FeeFGadfMAXp8tw/vAngf4uNdi/Ph
         nqDopvKqvK6oO+yt4ekWrC0rwayV2FLAMlT9lEpfUoZQRsnBOEql33zp3Z7vtCq1l4FT
         9W4Ehj9cgnUDK8pBAE4FQm7b4SAM+vj7khx7tk8mCel17WU9cBXbeJUYyRfrB+WpqA5p
         vGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXohqn4dJLnuZpguxjenluRecGe5bhnjQT5uZ6z2/XXc5z0IPH1uh4WJgll1dj8nPu8vvDBQ0isMGSkOj8@vger.kernel.org, AJvYcCXkWnmJbrJ6UOA5X9cLDZ3J8MjLRovJ4dFci8gVIWRyWrrJxFd4BobgIcinrlgaop7gcv4lRUgClv3g@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtsCSFxVTe1fuhGiiLiIEal/PGbThPf++eKFZoEbalz+t7CKt
	ed5OdzBe6KdNelQy8DQ8syDV3InVX1G2W5A+jytJQXSVFkjRmoio
X-Gm-Gg: ASbGnctHxCMOG6w6B5+a68NDw+a35YgNWWT84kEPey6lm628lTd4a8KVyuMnQgvX720
	d3ToyMslBHL9Yo4Hl3fwm2BcyItv38Bx7kDlOdnJ6UgJSoFjzIkdsYC9eeUCoXyU9jwpdX5BGjd
	2r0ez/S0eqkACK+2f064dnv5QxSRxyZYWlAHjLCEFtV/OVTAuEFcG1ReiQJKe4MtLZs1BIk69ko
	F0peNtc4B28LqK15FnqXTj7asuYn5tvSXBQl1gEGor9ypA9RAbSMD5hblnU6rJ+0dPKgvh3De20
	V+KDrrHWrPO70SOD8w==
X-Google-Smtp-Source: AGHT+IG85l5eWD/ehvahhU8yOCbGoLnCSNPdVSu3+J6g3K5WKnhM9iZZ/yg1bN3TtK4C9Qa6bRevFQ==
X-Received: by 2002:a05:6a20:2d23:b0:1ee:e439:1929 with SMTP id adf61e73a8af0-1eee5d68e2amr4689789637.30.1740054168046;
        Thu, 20 Feb 2025 04:22:48 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:47 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 20:21:49 +0800
Subject: [PATCH 8/9] arm64: dts: apple: t8012: Add CPU caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-caches-v1-8-2c7011097768@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=G+mx3kaje+P3ZyUO/ditIxszcN7HViLpZE3JAiY3KS8=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx5/L3429r7pYcCYbI4Ok83LdV+FbS1dAwtua
 kdgMttCz3+JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7cefwAKCRABygi3psUI
 JPnTD/99BMzSdUN1zSDmpMt9J6sLssoVIIAofLDDFZqY3AmmImgCPmW7/4gTCH+RCSjCoA1unC/
 DqcO8Lnz0OgD26lYrPdJeRc6O6lUVNP+YQSD1P9HN6VLxf5X5sP2F4mCKCG5HOCmcziKY8VeuHh
 oPT/rwbRPyLePLHNW2jmRFlIIq8c1o23oYqeyONp8lGuorFuR8ePgu+hZfnEh+mBM1LazZXZbVE
 uR7mJURz+Lf0DS+EjKq08ORExS+L5PBtDq5OpSzhiPAB/A2iOTHBeDqfYBhDHz17WIU8IvjNj9O
 siP8Gjd9U3HyM6r2268VUNM1KrXIh+HCXi2LjCLdLrBLQfTTKRg1PBGY5JthVAP9W047OGdVc9X
 SIotScz2fOpfG9KFcAwnHzVnTtO5gHClX/afXr0VVceter2NR7O0vuMsGcgHGYbPKdeJUAmr/ZD
 wCKG0+RtsFRIy3Voil3yojqW6mAsamyzGLvS9h/FYwy+B9fANXJ0/vQW2kvZesQ8AZqiuRvQnJD
 pV6p3042PGur6NR4zljlyXgnPXJOI511rlsZTYRgP9ZCzghQnV60fJ1TIY8r91EErCrLtjBfIE6
 xoaqB9RrVcULQ9AgtHxxIgo6Du6gjBHBcsq1quAwEWei9SNEE2KB+ttkBl0ChRhuKmrMhBd9uTW
 FBcsHjWvsE5DOVQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add information about CPU caches in the P-cluster of Apple T2 SoC. Due to
"Apple Fusion Architecture" big.LITTLE switcher, only caches from one of
the clusters can be used at any given moment.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index 42df2f51ad7be4c4533e76d18e49a9a747b6b7a8..a259e5735d938cfa5b29cee6c754c7a3c0aaae08 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -36,6 +36,9 @@ cpu0: cpu@10000 {
 			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>; /* P-core */
+			d-cache-size = <0x10000>; /* P-core */
 		};
 
 		cpu1: cpu@10001 {
@@ -46,6 +49,16 @@ cpu1: cpu@10001 {
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


