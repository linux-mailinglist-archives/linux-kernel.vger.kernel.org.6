Return-Path: <linux-kernel+bounces-223667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6A911680
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50333B211DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCF14387C;
	Thu, 20 Jun 2024 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOd1sVAK"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6BA143746
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718925223; cv=none; b=doTRwgqu7CGMGSuYodew/IwuOw4AfTj4FYwjAgfk5AErjshD7vsUERtQbAMncgGS2jfUJQ7s8Oq5Hq6S/7VZN+J3yLuZ7SPVQIYqqDsGf/CZLc5F7rYEcrOgepkoqIIDVEwBVnS1X5KopeXuU5GhLCWAGEpH/30ZvIRJR6A7rV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718925223; c=relaxed/simple;
	bh=Whyoeq1D7SDxvcUKI5XVEFUK8fYb5jRbVCwFDw72hvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HkJHJ14/kPx35Ua50lo+V8y3ovL1JW5N+a5LKA4daRgYKBdAk4Iiwk9nV5eZ7vmjzQyC+mMYs3B0KN7UVfOwXnYUDhZXC4sZME+jOauFNbvbh/aWC76Na3JN1sBWhkM2l0/lDlofSJEwGfRkN44f0986A82ldEDCobX5JqM3ZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YOd1sVAK; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6fa0edb64bdso740141a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718925221; x=1719530021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgnmbN5MPz4u6HwtpTU4Zp3I0CSg6ni7gpmRecQhhsc=;
        b=YOd1sVAKkcjQTszfoc0vyasf1TmpK3wGhbTM5TIIKFTP/NSF3Azs+6R136sCQrO24X
         6Z8wtidK9T7bgdc8OcLs4jVua49ESNvXtrb+7R26+tA6FGDQfkEC+eBiWIfTdP8dvp0D
         rNfu8TK5j3VvKbNUGgwo1BR2pkf4CkT2cGviZ/yWJ78djxFzmJzUtsu0nt4DMLmRYjH1
         nMirQA7DrHCLaXGJa2cA9VIKwqCL5GwCTuw3eqF/tuI1ZmbmeeDdKl09BbPsoCLuI9a1
         aYm2Cchq4doGKrdqQ48P+wziQgvn2UZc4PBue+b5pbVeESBk9gdHXOXPDySqJlCiC1AU
         1TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718925221; x=1719530021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgnmbN5MPz4u6HwtpTU4Zp3I0CSg6ni7gpmRecQhhsc=;
        b=Cs18IkbYmC3L7qw0TnV8Kpvtrnk4sXrnq2Rm4C62h99JqJj57cdF7aaUinzb93iZFn
         JouXd8uPIbIiJfV00Tt9fhuMcdeToG8K21AXmz2NQxLR+7tcgio3+kNc1uELIcwBYegZ
         gOeeJVhMjQROTzzJA8H4YIIuK7VAsOCysJa0xN2R8iFkCaXujFRseJhEeXy21CSWRS2O
         /AE5rP4ATZp+ijCMiSAfDuqHQYdNl9/VH/5Yji/3tIHnq1RYMQg/0FuwkaHGozPqQJhL
         9oyDSBDQX3/JtLdopq3x15PWAN3gzEs4b6QMHlXtkuOdCzV26Uzn/g/Hmjv6uJpD8Z85
         1cWw==
X-Forwarded-Encrypted: i=1; AJvYcCXSuLf59PSMa5XpM8t8tvx//t6cpu6sqZ8A3KzFr1fmF77LeGj3oYa6RPiDWGNz2cOzHg/w7n9eq79HjLX/3X+yJ06cHRSkCTd4W3ON
X-Gm-Message-State: AOJu0YyHID4FI0Q2wpYG2lBIVKmETk+yFNpqZgACbhv2AqbgbHB9NCi2
	xdsAAkcHropJE58fmeVCFiDKvg8/v6UItN1wLCnKuP3zV68bhDxLlVtYAFIkdBU=
X-Google-Smtp-Source: AGHT+IGcflyEPj6w5naITQ8Pm+V6zs8OQmKJmr+51gTiWQ/prs82vRgY/sUN5+lTjL9xSd1p6OXsXA==
X-Received: by 2002:a05:6830:1018:b0:6f9:a5bc:fae9 with SMTP id 46e09a7af769-700748c96ccmr7378826a34.10.1718925220685;
        Thu, 20 Jun 2024 16:13:40 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7009c5df247sm89737a34.6.2024.06.20.16.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 16:13:40 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: rng: Add Exynos850 support to exynos-trng
Date: Thu, 20 Jun 2024 18:13:34 -0500
Message-Id: <20240620231339.1574-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620231339.1574-1-semen.protsenko@linaro.org>
References: <20240620231339.1574-1-semen.protsenko@linaro.org>
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

Document Exynos850 compatible and the related clock changes.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
  - Added R-b tag from Krzysztof

Changes in v2:
  - Removed example added in v1

 .../bindings/rng/samsung,exynos5250-trng.yaml | 40 +++++++++++++++++--
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
index 765d9f9edd6e..1a71935d8a19 100644
--- a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.yaml
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
-- 
2.39.2


