Return-Path: <linux-kernel+bounces-365205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635299DEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1557E1F22020
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469BC1D9675;
	Tue, 15 Oct 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCFsuZzK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269A1AB6FC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975538; cv=none; b=YlzYAcQUhESOYuI+s5iMEAff0Lntf5XZ/UuGqwo7beot6p/tGk1VyPhpUSEe0Zceh6wS7A5k4QG6GZi/LIMLX9ONiCDEVz41b8DkpLKe6vCwVQuS/EbP/L/YQ4DlQdHXasHcz388G2eS4IUyrciT3cnWhp2VqFVSau3HJ4q1eBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975538; c=relaxed/simple;
	bh=HHRjomsRYsJDwBzUt/stxykgtORGhKkWesiG8s2sUzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsPfHx5xbG/+G0ee4f9Yr2n+4EbweR5QJ0zZ1NJE5B6DiEfqfJ/KYL2GVbgDiIgLKsr3cwsuZRT22O8CAFVcX9L7FCpnmgGarGqS1twyrEu81fHYNZm+NvUkKUXv96Rm1tIBebbkzti75Yxw/mU2y5Yi8Hs8mrv7tK89q0IRpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PCFsuZzK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4311d4762daso4369075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728975534; x=1729580334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Rg9CafE1YGkVl9KvHL3hkpJVC1sI0hUFkBUJZbx7bE=;
        b=PCFsuZzKQAR9kOL6ni8Kn0H9p+6MTkmTF4D+Fp053Ojk/c0Du5nfr2xqGqiYwee+kB
         YOcC8WBKZQSMVX3hgMZL8vriWYVmNTdRp9piSGURLmPXoiZJB3E9HgQazfgc0g9AkYyz
         uPBDLHOtBgeWZFKvjP/tQ0+vTT987www5QA5+vPUq8BmE1O/uQwKOya/G9v7wQ5hmsfH
         7DYnA4kvWqz33GL9wvZi9wNEZH8i30eD4weWbViSxizGIPrKorkf+sywal49bRhzm5Gu
         crES1KWqZAqLsIUQFAQ1r/s0pJg2zcLNiBi+XqO3y4aG8vJMfIysFr0BXiU62JaFCPbv
         DkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975534; x=1729580334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Rg9CafE1YGkVl9KvHL3hkpJVC1sI0hUFkBUJZbx7bE=;
        b=MHxynsTqRTmMT/ZTdrxnRjYG9KWvtM7O9R8mwfk1fr+7RnT983nEiIAimN6K9PPQrZ
         almcA7leSbNs+CP1Mld+7E7px5wqp80zNzcpK9IKcCVr4MddQc7ZCU/s7XSIvrwS/+Ck
         va4Sa/DbkgW+rPWa5mlptIdZQ+jPa4+fH6y5YhbXOOY8V4YFkFbxIeumIDLjwksHCdgq
         OtZYG/tCbVIVA3y64OinU85KGUF/8vBiyDOnxdUpw03kz3/I9D1mb2c2WUFZP4tNxvU3
         vC0Ga8XnobVYaFxpLgcsYKMzVqfsPTVmDNzVi3v8IfU9uJ5cVZUSWch3DTcaL2CIkzUs
         PVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNzLbYUn2NoKyaqT2iABAHbmbqPd9zDroeFvQry7zqLIOz7uowKdizIMQgGtH6EjxqxFp9WXgLuAMgbZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BHf8f/lmfd9jiJaBTf1mCxm4A4LZTN5ZLXeVF5Qw6lYWQQyd
	zXP1jc3to8lWmgwj7e5pbqkKJK73TsXSqlOxwfhQQOmXIM42Yu1/AWCKKuBCtVI=
X-Google-Smtp-Source: AGHT+IGbPMxgc3DOJjQs7sGqlYcjADDsKE8cdCECGo3sJ7ddzUzXMkKiJhT5InhJZ4au28jZv0tx4A==
X-Received: by 2002:a05:600c:5122:b0:42c:b63d:df3 with SMTP id 5b1f17b1804b1-4311ddff73dmr55330175e9.0.1728975534141;
        Mon, 14 Oct 2024 23:58:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5d22sm8461645e9.40.2024.10.14.23.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:58:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Jaewon Kim <jaewon02.kim@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH 1/2] dt-bindings: pinctrl: samsung: Fix interrupt constraint for variants with fallbacks
Date: Tue, 15 Oct 2024 08:58:47 +0200
Message-ID: <20241015065848.29429-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 904140fa4553 ("dt-bindings: pinctrl: samsung: use Exynos7
fallbacks for newer wake-up controllers") added
samsung,exynos7-wakeup-eint fallback to some compatibles, so the
intention in the if:then: conditions was to handle the cases:

1. Single Exynos7 compatible or Exynos5433+Exynos7 or
   Exynos7885+Exynos7: only one interrupt

2. Exynos850+Exynos7: no interrupts

This was not implemented properly however and if:then: block matches
only single Exynos5433 or Exynos7885 compatibles, which do not exist in
DTS anymore, so basically is a no-op and no enforcement on number of
interrupts is made by the binding.

Fix the if:then: condition so interrupts in the Exynos5433 and
Exynos7885 wake-up pin controller will be properly constrained.

Fixes: 904140fa4553 ("dt-bindings: pinctrl: samsung: use Exynos7 fallbacks for newer wake-up controllers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 .../samsung,pinctrl-wakeup-interrupt.yaml     | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 91516fedc872..49cb2b1a3d28 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -92,14 +92,17 @@ allOf:
   - if:
       properties:
         compatible:
-          # Match without "contains", to skip newer variants which are still
-          # compatible with samsung,exynos7-wakeup-eint
-          enum:
-            - samsung,s5pv210-wakeup-eint
-            - samsung,exynos4210-wakeup-eint
-            - samsung,exynos5433-wakeup-eint
-            - samsung,exynos7-wakeup-eint
-            - samsung,exynos7885-wakeup-eint
+          oneOf:
+            # Match without "contains", to skip newer variants which are still
+            # compatible with samsung,exynos7-wakeup-eint
+            - enum:
+                - samsung,exynos4210-wakeup-eint
+                - samsung,exynos7-wakeup-eint
+                - samsung,s5pv210-wakeup-eint
+            - contains:
+                enum:
+                  - samsung,exynos5433-wakeup-eint
+                  - samsung,exynos7885-wakeup-eint
     then:
       properties:
         interrupts:
-- 
2.43.0


