Return-Path: <linux-kernel+bounces-523681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B0CA3D9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7B942136F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50A41FCF60;
	Thu, 20 Feb 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHS9/tda"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AB1FCF6D;
	Thu, 20 Feb 2025 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054173; cv=none; b=Kg6OjI5+SOplvaquWt75AIKTsnGQdoUPSVZLjbSgxM4gEev681fL29UnEvD+P2pET4akizad6e5UuAffp6WAMqO8MPkyCHOSAlusqbYdZzO7g5WLjQNZzSfIScN1ZoMy8LGVyJqxh9Z0YarZpV10adq/fq/D3yFb0id7QZ84bpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054173; c=relaxed/simple;
	bh=6VGsP5C1mUSlactoow//Nl59ChZ/SauVCkyBSv3d3Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8kxbcGzBaUoe+CZ1QVnt6ru149wWas2YgKMC5PdcKv1hP69Hii4RiKRmZb2GPNMephfnHuSzaNpymzahLc7ACIfn++YOEOcoTubwaibjREiepjVs1qwmgkK8psJzvJIVf/EdYkAWHYb/kQ7nIiUcUe+E/a1dcRFEI1B82J7ayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHS9/tda; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212a930001so21229375ad.0;
        Thu, 20 Feb 2025 04:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054171; x=1740658971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12zqbyR053JAU8mkDwPrvzWGvMGsApTV6DX35umkTV0=;
        b=FHS9/tdamhCJpF8ymzVeq4v9SjTg1/KkdvqHz4TEkScCiQhqBPvbNdheDRYmsonvkk
         OG7Erzt/6zweLASB2IzElJJlHpzrkKm+Oh83pDCgrW5d+S4FVXpjdG1nFZ9KXleqkbhf
         JjY6phRT6LmYrHL3vBUAsY7UYF2Atnldi/AuoRWPkKy0VIhryYUaS8LIo2DqqsTnqvxb
         g2KI1SZ+wjQddZewQnTFzGwhwl0VDe+qsnPQpOyncbBMV8QASqAGHf+k+NB1EJ4bpvlp
         jeyth3+NPQQt7N2zbZePIp1GJqSYc+ncL0+uFu9l5PIYNmDumzrf56d6nG7NluautL76
         z92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054171; x=1740658971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12zqbyR053JAU8mkDwPrvzWGvMGsApTV6DX35umkTV0=;
        b=S4LGKH1d3qDfy/7Y4OGUulpwCG3gLxiSxxXxnGh3Ne7uCLcQIpoUaG92J9t0NoJ44W
         815ep2uWmmbQTHUMk4JC1ph7AfqflyErHbdf1VMMkelsjdwS6qvQmE0Orow7iWWmw6wQ
         YSSDejE18b7PJ8vqhfOWi+nxlJ6MU+gq7tBejFpIUIbongVETE4kaBQhjaR3LDWnjjZk
         3wf0pmkVM5+L0HXUcJfdBfXQElOCooL3CuSUKFfc19WapEHfACbfoGaU9O3NITocGGC7
         ORQgZJOMVReymEI3ImMlOZBl9ZWE1fl9zRh7AenyZ6kGhRLi2laUx4HUGbvK9jQN8m0l
         3JTg==
X-Forwarded-Encrypted: i=1; AJvYcCVgRyha+HCnZRfHeXTXSlg67xkisF+PJOMHOiEye6BLVesKWmnObS4sis3RhS3BTxQ1c+BJRzV1rCQ2SklB@vger.kernel.org, AJvYcCXekom/xm74cANvFeZPu6fGueJZTlkCRfR0l+Lj3COSEXuFJ3ZsYkpFjEyiTLlfTUpyx6ku1uwJVB8E@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7sBMOF7LBDUJhn5k+/fvscJl8DJsxI2iuBFDH2nFjjruKDpVu
	e3LUT38rMysBzDB7EmUFjb6z8FINw5KMU6rUkgRCf+4v29zGDoC5
X-Gm-Gg: ASbGncuC5nOcQAJI1SwY2n8VTNLH8otsIl5m3Hao/G10X0c1gZktZC5OyMWPdkXZOtu
	N1jj9093QOtRGUK07JdOy0eDNL0LdxWs/u0DAAn5nS6KXE7l213CG9SpC7KJCxMZO7X0SPnDcuu
	FqMPJw7HcNzis/Hn7JC/YjnvlYylEZfC5+HGO2rDMii1Zap+VNgOzhmwVrXm8rlFe0CgkA1entf
	9G2z9qsOAlJ5RnKmlC5IOMWQFTuLxbSGUcgIdlssZlOt2e0FvakY+TmSYS8uQfwBH9qiR/Virux
	H1yiDEGVrPHeTtmT5w==
X-Google-Smtp-Source: AGHT+IHecW5Y8kLOhZQX6jvzcxU97SSW2l2zlY2HIPmfrm2xzYaS1crMHnLcc7ZONqRqQQAfBj/B6Q==
X-Received: by 2002:a05:6a00:2195:b0:730:8f7a:27f4 with SMTP id d2e1a72fcca58-732617a4a79mr30414248b3a.9.1740054170797;
        Thu, 20 Feb 2025 04:22:50 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:50 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 20:21:50 +0800
Subject: [PATCH 9/9] arm64: dts: apple: t8015: Add CPU caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-caches-v1-9-2c7011097768@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=6VGsP5C1mUSlactoow//Nl59ChZ/SauVCkyBSv3d3Es=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx5/a+YVG+deJ0Nr2fwotL1kKLBzPkzU5tQy/
 qTpx6SuLeiJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7cefwAKCRABygi3psUI
 JJ4HD/90gXqkkbacSqy5KnE+w1N1e31n0JOSxIazQ6ex4qCut08tkl4/4KKfQDTqLWx1bRmC6Ro
 BmJ72nqMXNsP6M12MwndhaKXtHVKtcsIWpufScOZGpnV7BK4MvF/fM1E+EomxRJJ95oDr705j3v
 JSsQCHYKgbBOoZnFdvrwIOLAZPgnEsGptOFsYmC1cqvi5OiLLs1woYnHJxahOGmEFZzXvTUBxby
 /PrxQp1Hbu0gW6U9zfU5a6QXh89b0uhBcZ5zeHN7jv3ndXBZzLYsyhGk8Ic0+qXtJ95VxPuZ4u1
 1rJPybeizYGSW+ST6G2QZ2hV/5bExjrdN/nBMlqX0oU+xpLNyzXiGJEvgtR0UzmIq37wYsk9MWn
 3s3N1AP6X7EDFTHNzyB2ighs9yEbCw/eLU0bMnD1xBZmE2OhDPETVqR7bqRRXuSPdLaOMRA6pgf
 HXT5FXDhki0kb2nNMQ84RNR2sBzxpkmWz4uHGC/uoHN/49fVrNU6x3f41xvxD6Gy38vbVZNkEQN
 ocUA/F3Ij1urqV8xYarinY23Z6KMcUjrAn8WYHP/GkoXI8j0fCUBalljbFeRg7tVdrgeXokUbRp
 3BJpcctT9Pv3GSoINdIB6YMreZMtr/3S1Svw+v3/a9y5CtF+IOViydTL+qlyZwgu1AB4RXYUNJJ
 tnjIMwLFCCG3Zgg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add information about CPU caches in Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index b68647bebd20782ba7a125e670b3264c184b62cd..138073dbac3c5a3ec495b078b3714cf800b471dd 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -63,6 +63,9 @@ cpu_e0: cpu@0 {
 			capacity-dmips-mhz = <633>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x8000>;
+			d-cache-size = <0x8000>;
 		};
 
 		cpu_e1: cpu@1 {
@@ -74,6 +77,9 @@ cpu_e1: cpu@1 {
 			capacity-dmips-mhz = <633>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x8000>;
+			d-cache-size = <0x8000>;
 		};
 
 		cpu_e2: cpu@2 {
@@ -85,6 +91,9 @@ cpu_e2: cpu@2 {
 			capacity-dmips-mhz = <633>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x8000>;
+			d-cache-size = <0x8000>;
 		};
 
 		cpu_e3: cpu@3 {
@@ -96,6 +105,9 @@ cpu_e3: cpu@3 {
 			capacity-dmips-mhz = <633>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache_0>;
+			i-cache-size = <0x8000>;
+			d-cache-size = <0x8000>;
 		};
 
 		cpu_p0: cpu@10004 {
@@ -107,6 +119,9 @@ cpu_p0: cpu@10004 {
 			capacity-dmips-mhz = <1024>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu_p1: cpu@10005 {
@@ -118,6 +133,23 @@ cpu_p1: cpu@10005 {
 			capacity-dmips-mhz = <1024>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache_1>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
+		};
+
+		l2_cache_0: l2-cache-0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x100000>;
+		};
+
+		l2_cache_1: l2-cache-1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x800000>;
 		};
 	};
 

-- 
2.48.1


