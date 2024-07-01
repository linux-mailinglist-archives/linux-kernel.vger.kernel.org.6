Return-Path: <linux-kernel+bounces-236681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F84091E5BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A855C1F2408B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248716DC15;
	Mon,  1 Jul 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnXtAKHz"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70505157E88
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852564; cv=none; b=llvFE+PpK5oidJORxCnuGP7YeMOfLh5xjZZicKCKhfHvrahoB5c+fRpTbaCO+0weJAmj8bR29GT3ht+BlrguGN8uVnNDm13AIPi/YwsLGngqeg2ZmXneKCD2YSUR6yjm3o63j3TQSyRMCLcIwpvVr7Z0HzEbgtUwLkt8wdVPWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852564; c=relaxed/simple;
	bh=ogY8eksTgOJEzLHcJSsQlFUjVUlsR7AprxV7ks4rpY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEDrd7KJD2pbbfB+yUoUHJVIA9iyTIjgUmdVFu1+zUv/z0kXshTjXrkqYrgK4qCw59Uo3ql3cupsWrXFsEIE+QlKb9e70dQ615FCX4/f1TkvLcW/OAC2IlP6ZHUGVnNka9q93edlHcdcgfuMUB85p2BodDsMkSteFg9w2kuHSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GnXtAKHz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so36269571fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719852560; x=1720457360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmslyL3Yn8FM3/FwJClSS40SS89bOK/NcyYZfwBo1Ic=;
        b=GnXtAKHzPTyZUfjaN9jIdCOaqgkLLjiWwpomv12iuzkd6qY6MZLA3wGymbIvwCUoW5
         LrbSWByb76TQEDy9aZRH9JG+EbcnNPtsQODfJgoavp0bUqYm3ZRb8+5w2eU386lwa9D6
         RS32SX9kCebSqWcIXzibR16F2JsHJG0xzq2+HjFzqOaNHwnzOxW07FhuYtaD8pYWVIz7
         ed+t1aVJMfHoIqyT+d8L5GTQxw5JVJOAIN5wHhFIO8qc7Ext9B3hoJ+XurcUSkqN+OTI
         Om8v6s9iYOZ28leERN9zPffRbHfTWJBBWZ0Ha2FHfLxNAFFVHwTlgVds6fex4UT6TFSg
         8X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719852560; x=1720457360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmslyL3Yn8FM3/FwJClSS40SS89bOK/NcyYZfwBo1Ic=;
        b=Fcg/c/seHESBDrg4IRryE8G+BdVsdZSjrH8V/aKCHLgmvQ98JPvoVVCHU6i8bAtMkO
         gVon1oiLJublQXiY31VIqDLqr152TRgLZUA2pR4S4PQz6Le1llT2nVo6dHJAQdWHZkwU
         w41dQmRzk9HEuRPTr6bMOnBAvX603dkmNxqsubAs28DRSPGGoqS+MG3miHo+r4/TfvbU
         ge2M6jLyErZ4TvEmEiKuNux5Ckw9rLTzGw/6RjsfJ6h+IhEzPFY3DClMH0OLPPr0M1/c
         XBXzERGKq+B4VpV3w/CbVVslVM4EVR4SYWavmDMDOd7OgE71qLubkdzzJ6X5hcwRynAP
         43jA==
X-Forwarded-Encrypted: i=1; AJvYcCWj11Q80hALf6FNgeGBpfI49qkZyuRr194CNof4m6WKJQZx/1t3sRn+5bOxwqMuTJ1vlVIEhTmg5FPVtOGaGklGLtGsT/mC8rqVMSbb
X-Gm-Message-State: AOJu0YxURxCGMoiQrDmcl/zWUedcs66LICA2099uio3Jxup5OBGI0Sas
	sPih/GLTNiybRvbQS+zR4z6UuTp1o0nrigV/i9zIP0E37dafdzZNnymPeCVRAQQ=
X-Google-Smtp-Source: AGHT+IGj4DUhd8pV8+1mduRvo0vDVwumXm4bICtrXZb7XCpM/RKei3IVsk5mGhfTZVB0zL0SL0HWtw==
X-Received: by 2002:a2e:9e15:0:b0:2ee:5a38:751a with SMTP id 38308e7fff4ca-2ee5e3759d8mr38050791fa.28.1719852559568;
        Mon, 01 Jul 2024 09:49:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b8e2sm161211505e9.16.2024.07.01.09.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:49:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: nuvoton: wpcm450: align LED and GPIO keys node name with bindings
Date: Mon,  1 Jul 2024 18:49:15 +0200
Message-ID: <20240701164915.577068-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings expect the LED and GPIO keys node names to follow certain
pattern, see dtbs_check warnings:

  nuvoton-wpcm450-supermicro-x9sci-ln4f.dtb: gpio-keys: 'uid' does not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)...

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
index b78c116cbc18..edb907f740bf 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
@@ -34,7 +34,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&key_pins>;
 
-		uid {
+		button-uid {
 			label = "UID button";
 			linux,code = <KEY_HOME>;
 			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
@@ -46,12 +46,12 @@ gpio-leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
 
-		uid {
+		led-uid {
 			label = "UID";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
 
-		heartbeat {
+		led-heartbeat {
 			label = "heartbeat";
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
-- 
2.43.0


