Return-Path: <linux-kernel+bounces-290650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688739556DD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B81283096
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B99148FF9;
	Sat, 17 Aug 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0QvydZZ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26313A250
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887972; cv=none; b=blxrfDpF+ZDZvEo0IHYkb79YnRVxta24jmFbLy4kDwhbWaOirZElhAbVpVK9MdoHFflPbbWiVvd3i8xLEpGk6M81ULVnV/Z/Cbjf8FKk5pJvr59sTSELRWfapsWCFE/XO33hgetRaoL4CE9CGPVU85UAwTtkU4rTVVfRuCl0njA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887972; c=relaxed/simple;
	bh=CWHFcYPRtRY+Qq7QGzuma85hGAjlXR6aFEhWCuiLKXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ug2TPTBGSuc8U8jhAWChme5Z1wsApGjhz+gdSvlH1DjbgH9vgtAzJdfAyW0Mh94OEhFVmKrAQp+x6O8FdQeLdqgNBNi6CWNq3H0zy24XHJ2MpvgmtIvfZM+YP9VBhcW0FDGZ7qefhJFj+EhQiJcnm7MfyoTfbpObGvs1The3Nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0QvydZZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f01b8738dso2507167e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 02:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723887969; x=1724492769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wog6RxrWQdPYSZMlgcH4rB8QP2t+UaAUqZpSk10hqww=;
        b=y0QvydZZyYEJmwRen460TbOhaTGX6Ajqn+cRjUu9IcwMNxirts+7W+XKZVjppPYPL/
         lXQtMtqaGi+FuGZJ0FyM1Y4Q30hMehvxH0Bfi74tOO/Z1Z1RdcGiJDTYb0aPhxuRZfgm
         dThgnP9f3SVrQZRm95mJKjyPCkNKzcQJ0MiWKvfIdf/xJouluGhwQqiWynqfA3OLtyHk
         rGUYbHdMwYbbyU66sXU8wWtCha+WAkP/6FcNKaT6JHV6mfniGrjl6ynqMiq2UO+IkK8L
         EMzPsZ16JGTrNzmtAlCA8tqT68zT9SxkF9iwe0jMIimDycoVRkt6m77WhyJvlS4PYLdk
         VzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723887969; x=1724492769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wog6RxrWQdPYSZMlgcH4rB8QP2t+UaAUqZpSk10hqww=;
        b=erhvkUBAUSN0VEz1/uUAr/vsNiakrafQ91M4k/3r7HJXF7EH80NcsUmGIEHXJ20UvS
         kGV2wPsn+aSAITYwHYlcQ9A883AXu3VwAA3EUJLT1mkzdkVu/IEEz9B7CnkvKYCLvWyq
         cJK34nVYqeoDP+8AVa5ztCAMODZX7UAObdI72798OoK0KG1qMQy4/y685jUfgfNMUAQM
         L2fC3fjsE/Y5gOfMKW5ZfMJcc0O4UVcTTntj83mfFobjiekaqBHRNZv8n8y8oO/bu6KU
         9VJLqIgcdGiLTFDJSgRs7eDhMzKRsAPorudf8y6OhyaX84/VP7Nd0fZ40QQ8Pkufu2ui
         2YGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCBUGbQ63nJkR8eWB8jQ8n990xjzk6O/V9aWfIbp+DF+Hhu1sTQaaPWq1S6DssXrLmkLE5W5OdMR1bHgdcjMLWzGywQpLzYD5Sc2H/
X-Gm-Message-State: AOJu0YxwB6/wJNMSjru9Z3PRRkAg9PNOcEOSSz/I8OaW2ofs+w5MzcQo
	+psbk4MYiSa/FZF+pWP6Dypvxrnp9r3noxQ9/ePMd3CFq9cSaRZgCLFr3Oi92K0=
X-Google-Smtp-Source: AGHT+IERuJuUpU+XHOnVB6Mjkl8vgEL7ssVayE3dityP1pBDzL5Rj6MmNxvhvWaQNNpOeGGcTqhoWw==
X-Received: by 2002:a05:6512:3188:b0:52d:259d:bd91 with SMTP id 2adb3069b0e04-5331c6a2764mr3473051e87.18.1723887968567;
        Sat, 17 Aug 2024 02:46:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded2931asm97641815e9.17.2024.08.17.02.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:46:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: clock: qcom,sc7280-lpasscorecc: order properties to match convention
Date: Sat, 17 Aug 2024 11:46:04 +0200
Message-ID: <20240817094605.27185-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By convention we expect first "compatible", then "reg" and then rest.
Order properties to match convention and what is in "required:" block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Taniya Das <quic_tdas@quicinc.com>
---
 .../clock/qcom,sc7280-lpasscorecc.yaml        | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
index deee5423d66e..5e6737c39897 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
@@ -18,12 +18,6 @@ description: |
     include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
 
 properties:
-  clocks: true
-
-  clock-names: true
-
-  reg: true
-
   compatible:
     enum:
       - qcom,sc7280-lpassaoncc
@@ -31,12 +25,18 @@ properties:
       - qcom,sc7280-lpasscorecc
       - qcom,sc7280-lpasshm
 
-  power-domains:
-    maxItems: 1
+  reg: true
+
+  clocks: true
+
+  clock-names: true
 
   '#clock-cells':
     const: 1
 
+  power-domains:
+    maxItems: 1
+
   '#power-domain-cells':
     const: 1
 
@@ -57,8 +57,6 @@ required:
   - '#clock-cells'
   - '#power-domain-cells'
 
-additionalProperties: false
-
 allOf:
   - if:
       properties:
@@ -125,6 +123,9 @@ allOf:
 
         reg:
           maxItems: 1
+
+additionalProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
-- 
2.43.0


