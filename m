Return-Path: <linux-kernel+bounces-523677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4AA3D9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE55417EEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44001FA164;
	Thu, 20 Feb 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl5KHWaC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB821F9A89;
	Thu, 20 Feb 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054163; cv=none; b=dHzQ+wT1y3CRCfJJ9oJTSMPi67YGIb5H1u6l7zgdy655B4YsGgTBbseYXabVhamXwuBHHfJBW2s7LnOy25GQAjKVjjaPU2XWQB86wFrYBqAmKoN0eykgXK/MMEF86thv3luE7OXhmlbw5TB9QJg3u8mGpeviawElMVL46Ab7CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054163; c=relaxed/simple;
	bh=iKAQVbN6H8LNJ4L0t5TJAQywaYEBuG3C40azpKpmjE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzUgdtSNZwy0G8TrTYFz84wy42sXYYM7r63Z0LnG/csIU3hE2T+9e8y6Qwfp0Z+Z+QJeJBSnqEcNZnPKvi8olMrsyMO/61U6oO8r9d3TD8aahLNi3DitsmL1Tu+vk8tlKTRUznKDHywuQGUwYoO5fXtcGxbRYLN81LBQNEnPOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sl5KHWaC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e6028214so16604705ad.0;
        Thu, 20 Feb 2025 04:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054160; x=1740658960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7chlsLty0Lpa7lAJqauh8CHAEbBBaJTQJHxpJ2xXoRo=;
        b=Sl5KHWaCgNszjefVYci5YhDS9IBAd5FT8rTRLNY8qfEx+PqIEJC0ybbmh4vqihKjk4
         xPztJAUjpVjE947o+iWwpuIGPfvgJVZH4rOjjbWjH9ogYClupReSABOWzeRL7Iov5tYO
         +zhSGGcjRZo2rV9ILhUw4b3ThMGPHhS8ywm4OjUfqiow2Hs2zNxBV6BC9cxMrGPj4TV0
         F64mEBfDeC6VwIn0y1vdnXTMWWNIudiSqNj2AkDTXpkMMTOw5c2qKL/TWrRCrykgaKP/
         KWrUeoD3YV0q1z9Di5VhtrRzcA/aMts44K9G6fb/qUs0spiKN1eJuSooLCB/aGiWeqgN
         LLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054160; x=1740658960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7chlsLty0Lpa7lAJqauh8CHAEbBBaJTQJHxpJ2xXoRo=;
        b=IqGOa0JHhZOrtYAEsXovvigbHqwfqOd7fSpDxGGHBe1wU7ah8bktCJ7uTWiIMkmsTd
         nNIjliWsCHW1Cxit9vFZno1Z/AYVrjri/OJQ2jojMuvJtCb6phhcb0veVso/MXtXwzDN
         wxqiURP0QfIKUMIvBgPiZv6oNL9Hpia8l6uAOLsj0REn8CTU1qOofEm7ehbjPyi4cFvl
         pb7M124lVvklbzgdLEzQ+MBL5COA6eLiEtJHTuNUumjAEQF/Q2NRNuFIKxeOoXzl8UWK
         l6/L2FKk0PXlaaQtHpOgvH3Mfi4uXDbBoZZdc9vDGIJY//gaMQYRPFBlw0Ub0n2Yrcxr
         F/WA==
X-Forwarded-Encrypted: i=1; AJvYcCUO1TB3hrIw3LJ11tCloIXjHJBf+APzh9rMh1q3KSEIc2hXXaeVNdvQV+boLH6fkPuyXtFEnWsnEukj@vger.kernel.org, AJvYcCUd8Cj/3uku2RKGOP+oJfNQmC1FK0CkjkHsigyMste0n1MQ7bsZ1TIt7glArx8zRfpI3V2EnwGvl78mhUMR@vger.kernel.org
X-Gm-Message-State: AOJu0YxalPbREM5rG8B477q5OrU1x/eEGWNCJeIuNRSaSH7WdasZnXHd
	qfgFt27KhBUlyXydKl9fWcYa+o/GWnae2ueVkkzbBk1CiFA6tbx+
X-Gm-Gg: ASbGncsGZSsInN8QYa4Gex48QQaOwGu5i2qpqcH7ObLgpBycbcHgcINWqyKsIKNnUBz
	Qik4U5+sLuy11jOfCMa/nvNiJg0LTSMvcq6RvlpY/7Gqf7cUPHePjXNGkpilZ8ikW1hg+HUoPVc
	YK2cWyOc+cVqjoJTBUG7jfnzTclypj4/75CxN6wtUfJhNmwRKLghRG/+qlVLEC2Ivb1JYh9wLMm
	aVEXvqsaDyW+pUu2kt9ewpvXwROZ+98HUmMqhYW7ZR0pf3Z1JU+DFXNL7Fx8isx2PHp2Yss8Vif
	alU111tuWCq+p43f8g==
X-Google-Smtp-Source: AGHT+IGn28HCvIx9WJAp2s2tdPFeSijrFvqwGRpoloAKTjGl2JNSmwjJVADce8Yn4bnaEnt7kaxqTg==
X-Received: by 2002:a05:6a21:7011:b0:1e1:b60c:5bcf with SMTP id adf61e73a8af0-1eee5d68ba3mr5323432637.32.1740054159908;
        Thu, 20 Feb 2025 04:22:39 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:39 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 20:21:46 +0800
Subject: [PATCH 5/9] arm64: dts: apple: s8001: Add CPU caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-caches-v1-5-2c7011097768@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iKAQVbN6H8LNJ4L0t5TJAQywaYEBuG3C40azpKpmjE4=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx5+NPjeURwiNzAzZwx+4KYBipsYXVdqfZo8J
 bphtR8GE3eJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7cefgAKCRABygi3psUI
 JO22D/49OTwRyfjXN0ZLwJOwuqVuNXrhFrd/9B7/xmgUAgstIWuD72YkGK6u+jBzquNjMxCCBaa
 rofULIp28eH/iRTKp/KwVLZLPR1QvbgMR3wHzb7k+mCfM03uwH8+0Z0cWkoBsEonT5gNI378NWG
 EoNCrFK/318jyMX7qDJm+zAFiQYeQOcMs13xcXvROY4o3kXajsPlBO1o4PklMsatD50v6Zpq5G3
 MpqKprgUxia7SGQZw4N/6B6cTBf7eoPQ1ZYeKJmtL3r6nIxTNMU+S35wQG3rUcXzVGzKaF7rhNi
 TpztKyGuVIvvlRRPLP+MRzptCCKujaLGWFqA3QHsA6bnKjWWCQQJrhVVAq6E/o9UORfe2bY2JiP
 amz4gpRMhLt8YU6qJJAntdHZj+tpeEwDKpN6IUTmuTyck+nlZKJD4GfDBTD5up5/Pfp04CDv7ox
 /bMRH1mX0duXQVtPVWaV9jGfATYfB/mvqSftktheaOm2l+vEJW+1ELqPU6cUkoR6n4Pqi8AT+Yi
 Uo8d3oK6YSMIBX/ykn3+wdQXLGiaROOm1TJrtM1i1tWR5c5j7F7Uyeo2yHsrFKwF/Q6oaED2xZW
 r88pwbxAvHO5/1dUchprQRWGQJWbfmlo8OwuFVOwUyFJFikZOQe2w/zh3VuChlOf/TdgxrKS1AM
 P3eyhYJrjvKfpzw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add information about CPU caches in Apple A9X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index d56d49c048bbf55e5f2edf40f6fd1fcff6342a9f..fee3507658948a9b4db6a185665fdff9f5acc446 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -36,6 +36,9 @@ cpu0: cpu@0 {
 			performance-domains = <&cpufreq>;
 			enable-method = "spin-table";
 			device_type = "cpu";
+			next-level-cache = <&l2_cache>;
+			i-cache-size = <0x10000>;
+			d-cache-size = <0x10000>;
 		};
 
 		cpu1: cpu@1 {
@@ -46,6 +49,16 @@ cpu1: cpu@1 {
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
+			cache-size = <0x300000>;
 		};
 	};
 

-- 
2.48.1


