Return-Path: <linux-kernel+bounces-215963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB6909961
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DF6B21681
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DFB50A63;
	Sat, 15 Jun 2024 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQrcO3lP"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438A1EA90
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473750; cv=none; b=CyGlQFo8G8FC2QxUigsEbPl20h9nUddLgwKY4iQlCz3j4YbloPAiDYrikdro93mBVlazp+fbmoVoSTAxxRt692bSMBakIb6NiTC0yHJNUkpkr2ilbN6qN0miZXvNzDIGSQu89ZKbfYvPGnHWmSBceOQo2OX9wG9vqNc9o584qL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473750; c=relaxed/simple;
	bh=oGBKPT1M0XiRJNpVabQalPfRMu14bYm1uul2tPOLwKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWERs45SQ3/27N0k7n1+1SrLEaLRnIazfAeM9/Z+cC/oyKzSXlCzITEY/Xid8qwSitv0trMO0RpotHMUy7Huyqin0+//KQ9L9Vwr1rZWlg9HHsHT6LZy2pbQkBxZK3BZle1iNWyjt3M1cxgNAzVc2DVWgP1D3q+RCCySFUs52fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQrcO3lP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso3457231a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718473747; x=1719078547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQTdAZk+xkTaWcpSjHpauNVsk4RuoZYN9xg1Bzump2k=;
        b=gQrcO3lPZ1BSKptChDDOMB4LLap3KNy5uchXwU6iJx7aiuThMLthLDA1oJAcn+uTEd
         XBn26wARdb5U6cnuXTiq28zRGDWpW9B4PAXQOLdyIoWvidy59C0H82RFWk9fT94kJ4nf
         4DGB4/qE8LJZn0Re+Z8+hxIbJcX1z4q7Idfs/pb9N32RhbBIBdoqZ5Cb9ibo2gqVQioX
         HPYPkHXIpoRJyUroB4DwaOhNJb7uyGFqiqiQ5E911dte5aIUsiYpTWNDGUFT7SwwFEvO
         BcARFRcVUQVH+LiWGv8rq01QLYkZR/6OFh9uYieEaLcq5jKnLajrbtO8D4UXUq7dxHIw
         iBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718473747; x=1719078547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQTdAZk+xkTaWcpSjHpauNVsk4RuoZYN9xg1Bzump2k=;
        b=IL9C3qOyrXoPahtTOV+Oq1xu7NdG0oeepBZFXAlyoUHvuEBibFyL9VP90iDpvlmP7v
         cJiijsMG+g4v7CpbogsXsnSKw1Ri7rntuxZK3bZ781UApRCt6SsbO3NhXM7TuKSRjmDr
         7zmXY6YY0jr7SFB14ns5KVRdvl0PGMt3giGjm1GLW39+gkv9+kbh6PTwH4oz5d2N04uI
         5Y4RtRLdjDzJZiS4m3YYAWmCL4V0Uv0GXIDPypcAlO9Dul3PQhhRc0cGqoYSCMYkqsTO
         mWgRVMr1Lgru1DJ9KSb81E1NHP0PKSiR3U03VL5XFcjJAqvXIcq+YZKMfWbAcXbD1mWm
         HIIA==
X-Forwarded-Encrypted: i=1; AJvYcCVfrE58P6peiUl8lbUm17Cr0A6msS+09Anl/GxPL7zHbeBJnpMlZMjA2vmYI3yvcB84QGJDQrC3V4fGYWjcHkJ40lHwoaddqMTdtiP3
X-Gm-Message-State: AOJu0YzdYa5nk7/prhYrY8ApYCT9N6P/bjoQnEpzp+V4mlvOE5Qeuvzq
	uxgzfQdDKQoZ2pvrmHmxySU6gKSrU4joIMK4npm22/0W61u/ydpDS4VJeru7gq4=
X-Google-Smtp-Source: AGHT+IHI9wdR5yttuPe5CPAFwyWHcSWXRKDzT5MKecRnY8k+A4gMwRIgI941SC35XAKMmBHxxAe/6A==
X-Received: by 2002:a50:cd91:0:b0:57c:8c45:74ff with SMTP id 4fb4d7f45d1cf-57cbd8e8182mr2812346a12.41.1718473746710;
        Sat, 15 Jun 2024 10:49:06 -0700 (PDT)
Received: from krzk-bin.. ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e992dsm3942946a12.48.2024.06.15.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 10:49:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ARM: dts: omap am5729-beagleboneai: drop unneeded ti,enable-id-detection
Date: Sat, 15 Jun 2024 19:49:04 +0200
Message-ID: <20240615174904.39012-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a ti,enable-id-detection property in the Extcon Palmas
(extcon-palmas), but not in the Extcon USB GPIO binding and driver.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406152004.F2fNnorG-lkp@intel.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index eb1ec85aba28..e6a18954e449 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -196,7 +196,6 @@ brcmf_pwrseq: brcmf_pwrseq {
 
 	extcon_usb1: extcon_usb1 {
 		compatible = "linux,extcon-usb-gpio";
-		ti,enable-id-detection;
 		id-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 	};
 };
-- 
2.43.0


