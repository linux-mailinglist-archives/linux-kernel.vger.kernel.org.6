Return-Path: <linux-kernel+bounces-218489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9E90C080
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C05283CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A81CD13;
	Tue, 18 Jun 2024 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjmu609N"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D5B4C6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671068; cv=none; b=H4NnFvXhYr0t3ZR6KADTDwKbwpZr4O9PPSd/kuMPW5lGi9qr/ose47yxCHaW2D6vKJ1ze+sLQ8vxupYS/Q01wCrGCSUr+aNmETue8RRLWDjWw2F3hoLIF5O1u1C3Rh2H5QyjgxTzfrn8CJqoyrjvt+iXnMtzNGT4pkqHvabpBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671068; c=relaxed/simple;
	bh=FPECna8QubWZJWyI17d+5QqMeSrVSngVEd37TbVrJY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcY9p26Q8CvZYUZlHDMRuxWLDb1/jDm9mAssvwg7mA9kGi14OYVNA0SSk1JsNHKRcgSYywD8ArpBxjjz0g6HfNOgGmOTRYQF5EPBEs90M18h5kBHAUKh6E5oS6MCGuG7Y5qvs5xIx61MMhmnpjFtHn3rF4CaGBKSeVuE7YvtbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bjmu609N; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b97a9a9b4bso2384226eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718671065; x=1719275865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ++MWratnfX3umvtaDdV/3AZjItAbPo3zx0EZywnGo=;
        b=bjmu609NqRv2L4oqh1Xkunfp6nAsjqQpmjr/ey7aFBMEIrDCIJGs+jh9zEz+QHopjI
         +ZKbjYNR/dY3KI84v3A9SokmLRgxbmjOCJ66ECiwU5hrGQmz+Htp8gx+bsOMq4yQLRKM
         rsMgC0z13xT/5D7xBtWQQsKWUhp5V791J4ejNltPij8KY22NHoVVxQBr5q/+0CEPu7ho
         KIZDvQMvqKUQzOxakoH2x3D1djnHLQdzHP/1niUePtBCo2eGrbs3botTSCeUcHy4yLSD
         je78RJbCkBVjaM4etU9mNvsMjJgU/JyRLULZQqXnQOXMRgYP8t94Yw5y8kPOQ55XCAsL
         4wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718671065; x=1719275865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ++MWratnfX3umvtaDdV/3AZjItAbPo3zx0EZywnGo=;
        b=A3dQ6Ue3KBk/PnqAd9V6mUdzRLkTLAB5dZPmhurUV1nuMYawaph5tYoRTI0eAPlMBC
         SOmOgcUoCAHm87xlP5GYPEhdztUwkZ8if7WDABDzg1Y6slBVmGzH1pZ3El75zfSa1guZ
         FU7H6y5EeUaayx93Il05GF6S0/aj9HASeUKByVfJVwkZMl8fxc5uPS99mG5ZjCFmo/Eu
         L59o4JtLMQB6S4QvgU+99Zi3A+XX1z9JSFptYJi+DMEWv2jpRrhzOI3bBRaiEI+Tb4Ae
         ICLdUgFHX2x1EK0UHN27Tc9SteCUIlb+Q4dMAB0hyjB8fUDGWxJt98UZUwcs3MvhOJeP
         O8yw==
X-Forwarded-Encrypted: i=1; AJvYcCVdW/qL3LTWSqUdA1unSStxASURBtxfM3K+8brZdHB8Az3PllN3VraIN3/r3AjyLVPIo+E0n1QK8lK3POBhA5RYPVMkAaTYIDiohSr0
X-Gm-Message-State: AOJu0YxYAg/lREbddBZ0O1bX4i9H+iXRNwHfKyb3PZ5KUZ5Cg1M7gszd
	QsdV73hifk8Fcjbu7BjPvZyAdZzIx30Dq34kjFP7tp3aA6a+PQ5HzCIYxiDX7fI=
X-Google-Smtp-Source: AGHT+IFuFpjdFpuLvIdaYw3w/WCr1/gHlrImp8DoWkXpIxzm220GdkXoQwm/XTk+jxZ+CH+KzmX0Xg==
X-Received: by 2002:a05:6820:161e:b0:5bb:2d23:8aeb with SMTP id 006d021491bc7-5bdadb68eb5mr13265376eaf.2.1718671065156;
        Mon, 17 Jun 2024 17:37:45 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd5e19e943sm1229935eaf.23.2024.06.17.17.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:37:44 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: rng: Add Exynos850 support to exynos-trng
Date: Mon, 17 Jun 2024 19:37:38 -0500
Message-Id: <20240618003743.2975-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618003743.2975-1-semen.protsenko@linaro.org>
References: <20240618003743.2975-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TRNG block in Exynos850 is pretty much the same as in Exynos5250,
but there are two clocks that has to be controlled to make it work:
  1. Functional (operating) clock: called ACLK in Exynos850, the same as
     "secss" clock in Exynos5250
  2. Interface (bus) clock: called PCLK in Exynos850. It has to be
     enabled in order to access TRNG registers

Document Exynos850 compatible and the related clock changes, and provide
a corresponding example for Exynos850 TRNG node with ACLK and PCLK
clocks.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../bindings/rng/samsung,exynos-trng.yaml     | 49 +++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/samsung,exynos-trng.yaml b/Documentation/devicetree/bindings/rng/samsung,exynos-trng.yaml
index 99c382d25c11..e57310fa89c7 100644
--- a/Documentation/devicetree/bindings/rng/samsung,exynos-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/samsung,exynos-trng.yaml
@@ -12,14 +12,17 @@ maintainers:
 
 properties:
   compatible:
-    const: samsung,exynos5250-trng
+    enum:
+      - samsung,exynos5250-trng
+      - samsung,exynos850-trng
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clock-names:
-    items:
-      - const: secss
+    minItems: 1
+    maxItems: 2
 
   reg:
     maxItems: 1
@@ -30,6 +33,35 @@ required:
   - clock-names
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-trng
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SSS (Security Sub System) operating clock
+            - description: SSS (Security Sub System) bus clock
+
+        clock-names:
+          items:
+            - const: secss
+            - const: pclk
+
+    else:
+      properties:
+        clocks:
+          items:
+            - description: SSS (Security Sub System) operating clock
+
+        clock-names:
+          items:
+            - const: secss
+
 additionalProperties: false
 
 examples:
@@ -42,3 +74,12 @@ examples:
         clocks = <&clock CLK_SSS>;
         clock-names = "secss";
     };
+  - |
+    #include <dt-bindings/clock/exynos850.h>
+
+    rng@12081400 {
+        compatible = "samsung,exynos850-trng";
+        reg = <0x12081400 0x100>;
+        clocks = <&cmu_core CLK_GOUT_SSS_ACLK>, <&cmu_core CLK_GOUT_SSS_PCLK>;
+        clock-names = "secss", "pclk";
+    };
-- 
2.39.2


