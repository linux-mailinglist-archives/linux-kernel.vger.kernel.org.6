Return-Path: <linux-kernel+bounces-220153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B699490DD97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B34B22FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C561779A9;
	Tue, 18 Jun 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkwesoYg"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C41741CE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743527; cv=none; b=ObspDOEShjC6GmHJKsBVlnvzPMHmCEkjREyqbwX5/wrKLB/LIRNefk+jzkEnnP/0X6izrr8IcVdTBycwIj7ImtmbB9tfwCOQfqhvTz9UxR4s6k8kOp8QhPG/z/1sO463ZolRnAujmDVbaj17nzC4k/yNTsP2+ExK0GqJoPaEIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743527; c=relaxed/simple;
	bh=jCr2PSyk+QzA3n1KIeezmKnsRWEIq76Xr/2/3wqo+Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTybADRZ67gj08CejrD1tSV0qJt7gEspg2L1bpXvoJeuPvNaBdx017A5IC2QKd4oGY1F7ej2FrmEHWY4ycceRVQDdn0LhtnFhfpMaLecIHHkenOERcNzXPZnVrn8MTAjCXerqTVgmiaPdbIFXzSmOdx1Tohxc6Qh3dGlBpCfafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SkwesoYg; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f361af4cb6so1985864a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718743525; x=1719348325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlbvvMZMqGqL9+iJm7HJUKaP51agxlDWROSsJ57jie8=;
        b=SkwesoYg7VwJrx3rP2Davq8TCBbyBLRbJ7Fgaac4j/4oN9bzcc6stGTcoxzkuJZu8y
         lLrw1vhOvW2hhSTG66fwsyk6jG206ziommkub0nqko6V2bN6Gf8ekxJi2rO/Ko7cQUa8
         eHb+TyTtQ6dNg95qrA1A79LoVXsP542WTD56cOqoJWCAFsfueRD62b879GkDE7iM4URQ
         tN4syU3DJQGUCjKzbIuXn3lhDoynNPxwfj+qxUCWDNPVweHsvhZJbmMFpO/2sc//Klc2
         ccbKrc5rXrUOShPnoK1+y6g8FnptpkHppq3PulPeH0wsN/uBa22NklYFfvvRv41U8YKC
         CHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718743525; x=1719348325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlbvvMZMqGqL9+iJm7HJUKaP51agxlDWROSsJ57jie8=;
        b=WZ75EtLnVvQKihK0G7oVKNY0eKKdXSUtudgg9HDmW3byMaLY1mK4VQy7XCEzWLy6Vh
         QQmLiG7GJs2sJaGChHm6CMbIxlcSKIt8Ct6ELxpWOyQg5uxw22+AvksZE+Yvjjd5W0yM
         nr2aojgFk+iKbBP46Nlxx/gxH8w4OJ+ZJhR19iH9s5GbOVrncGNwfKeDL6mnEnE0/JTy
         Dd3zUXAeNsahOc77OsgbHkjk9ARlx84KDthWkfbAHQ9BrgyP2K75WgixanYbFDJUfSdF
         QRCxCalnFRZYdRz5QTO/gD8znMVpH1TbI5vYEcZMrIwgbJmLsnwsPGd23tWLlFL2t4GP
         f7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUOLKliNF7Vz4W0T4TRhdQ49ATavGx1hNPMlc5EaOcEx3iM0AFa6MGqKke9umyf+gndZN28v4v38NODieusYlh09ldCWkKten1ljXaY
X-Gm-Message-State: AOJu0YzM0jdc3tT75WD9PbpNhZJGoTMkuICeyzqBjBa8tQeXqv3vDdwb
	pidPe5BFZzyaRXPFycT8HE3rmlvaQYpmM50qQnOfxBXRfhuPix0Hrxht6G2jGMQ=
X-Google-Smtp-Source: AGHT+IHtQ4jPiGwmE6Fqz4f+T054gfg7HjueTuRrzz7pHpWmzy4tU4cMlClLNNSm5wif6dmg4G42uA==
X-Received: by 2002:a9d:7841:0:b0:6fe:858a:8d4a with SMTP id 46e09a7af769-700771e7314mr874352a34.35.1718743525201;
        Tue, 18 Jun 2024 13:45:25 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5afab892sm1937125a34.7.2024.06.18.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:45:24 -0700 (PDT)
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
Subject: [PATCH v2 1/7] dt-bindings: rng: Add Exynos850 support to exynos-trng
Date: Tue, 18 Jun 2024 15:45:17 -0500
Message-Id: <20240618204523.9563-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618204523.9563-1-semen.protsenko@linaro.org>
References: <20240618204523.9563-1-semen.protsenko@linaro.org>
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
---
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


