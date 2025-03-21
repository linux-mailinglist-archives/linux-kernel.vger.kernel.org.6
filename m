Return-Path: <linux-kernel+bounces-570881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA7A6B5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5A21899410
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5ED1F03F4;
	Fri, 21 Mar 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxSbvNNc"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0391F03D8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544140; cv=none; b=l9QZXCQjPY1b1SE01MiwkHRCDK50zpboYvpJ6aaf/XWnK534qo/SYcIzXCG7XFD7Hy5f3h8lwUe5Hbpas4TGhRfjL7Zwu6m622k0KE4xF0kiECOcIwC5sCWpbTOqksdinLi6HI6zp9oa8/iq0/+YzjatynDAlV/2b5USlZdMwt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544140; c=relaxed/simple;
	bh=RrnSN/CN2kZxgvV22FlvT89WAQGZ7oBHakES/ZqzmVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRnHtMtQvrXSulvnM64kh+M3SvivogMV89WgAzqPQSVQZAd0BaEWCzBv+l+4qbFIf22nXeW5e327ZXq9gtHupuFZKPMpMXtvEtwzGEEm6/xd1cLE4/lWdvfEq5jap39F5EZ1osYlxP88zSQQfCOmmryVMtx4dee6r3VgnhmRUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxSbvNNc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43938828d02so2444025e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742544137; x=1743148937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/paNAb4b5evHCNjWAz+ZF/7zT+ALWwpQj48R9FGXL6o=;
        b=sxSbvNNc9jFwWIk8FRxAD+tz/GquRwB0LYjgk+5y9R67Ii1OXHz9hSxsiDcH9NG69f
         tnDaZlyyavzbNK2WJiaIC8N1evf3PhA0wQLlrm7vYXQjyE8tWj/lX+1YWILdpxvSlBrE
         5goSlp53pUImzaud5ZAH+aheqfbdW4D9KbmbPdKEPs0rt+rLXsU7Y1J0UAx30vXu+vGd
         9OvqWEhXtVFVOW9zaKFqO56RrLLZ6Pff/vRzCujDkXFEAJ8y5n0KveCDu7GakHBb73Y0
         RlvWxcrY/5HtmNeO6dX7I39poRqOZsrXHrKA0V2gg3mn/pqvIk05tiis61fxaA1JEaSC
         mzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742544137; x=1743148937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/paNAb4b5evHCNjWAz+ZF/7zT+ALWwpQj48R9FGXL6o=;
        b=rEFVOhoHsdSpwZvBLy7tBVeb6agPtWTu7xAmG1Mj1VKSue1zI/HO6HTzY8VQAQXA38
         PhATl0pFwKBkD/5ZFOZ+SCAzcxTmXguPn1QAWfooDQF1caBGjQzZs5CnLrwGgKxXsust
         giL3dBsFW8D/5X4LPiPHzQD061TgciTTr6wBzdIEJWW9ltjAxb7o2jBOcuOM2/d9ikMs
         z5TPJ+hjp7yLpvWwmZywusHssqSAv8eYrw+lp+i4/ZAYdiLSrSZBxr897JL+IckzBKav
         6M6p40WbK2umlmkerxWKAwR6Nyyto6aW1rEvmi4kAhU7eVEVgPtH92EWKJSqug6Ols6Q
         yA4A==
X-Forwarded-Encrypted: i=1; AJvYcCW1gZg0/YQFSKY0ei5Aoe6WE8t1a2h1BvLYM5jyf1Y3mgGU8edgiB4p+6E9MKDpgRQwnXB9EzZeI/RRMnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEOgUaMXnnai21byajywoNXFi3PJr/kbpujj+fUq8jQyw9nlK
	hTBovqqVoL63zYQC/R20mcoAG0ntb3gBQhnMS7ndR9pjWoBpbptWN2jrOoIlHOM=
X-Gm-Gg: ASbGnctkrgmTdL39lmKB8L9u3lVDQzDdUVuNff4EFUVfVOdAsrUlKY3WwtdU3Td+gKr
	17LF1AFop1Ypep3Tsc5jtdzgvWqznY52LhWOIwNLpr/zs7W1cPsdS5MB2lGOwI7rGcmMCLdHbY2
	otG/NNTARuFSKQEc5qwWaLUVYR5YSz17XDU6gZm0VO+o98v6CdlYxewoQjyElesRrGz0ZLEVNU0
	gOBBnvzYxL5mRsrHeyCYHBb2hm30gKIJqdHjdZsSDCIVNihSxZZ3xsD8fchoVqC5DgMHFfbj7Xz
	oeSak4js8NGlNhLzSv8HbXCFo7TN4GFxORJ5xD8AnKqeRu/3TeGGgzo1CQ==
X-Google-Smtp-Source: AGHT+IF2AHef/qkj99JoiBNbLQIBcqaey9hWmPacciUSVdx3y1EUY5tMwczXWozBM2SM6z3OiVGoQQ==
X-Received: by 2002:a05:6000:2a4:b0:391:2acc:aadf with SMTP id ffacd0b85a97d-3997f904f52mr755069f8f.6.1742544136598;
        Fri, 21 Mar 2025 01:02:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f81sm1697775f8f.35.2025.03.21.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:02:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Zev Weiss <zev@bewilderbeest.net>,
	Ban Feng <kcfeng0@nuvoton.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Eric Tremblay <etremblay@distech-controls.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Florin Leotescu <florin.leotescu@oss.nxp.com>
Subject: [PATCH] dt-bindings: hwmon: Drop stray blank line in the header
Date: Fri, 21 Mar 2025 09:02:12 +0100
Message-ID: <20250321080212.18013-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There should be no blank line between the YAML opening header and the
schema '$id'.

Reported-by: Florin Leotescu (OSS) <florin.leotescu@oss.nxp.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml      | 1 -
 Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml     | 1 -
 Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml     | 1 -
 Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml  | 1 -
 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml   | 1 -
 Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml   | 1 -
 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml | 1 -
 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml | 1 -
 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml | 1 -
 Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml   | 1 -
 Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml      | 1 -
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml       | 1 -
 Documentation/devicetree/bindings/hwmon/ti,lm87.yaml         | 1 -
 Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml       | 1 -
 Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml     | 1 -
 Documentation/devicetree/bindings/hwmon/winbond,w83781d.yaml | 1 -
 16 files changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml b/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
index ce7f8ce9da0a..236d8b52ef85 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,ad741x.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/adi,ad741x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
index fd79bf2e0d16..ddb72857c846 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/adi,adm1275.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
index 011e5b65c79c..1ff44cb22ef4 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/adi,ltc2991.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
index 93e86e3b4602..8af0d7458e62 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max20730.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/maxim,max20730.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
index 4f5837a30773..139a95e00fe5 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
index 2c26104a5e16..24c7697fdc1a 100644
--- a/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6650.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/maxim,max6650.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
index e3db642878d4..244470282890 100644
--- a/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/nuvoton,nct6775.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
index c1e5dedc2f6a..625fcf5d3b54 100644
--- a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
index cd8dcd797031..c16a33227e94 100644
--- a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7802.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml b/Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml
index a32035409cee..78e3d97e2ae5 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,adc128d818.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/ti,adc128d818.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
index 926be9a29044..fb80456120e1 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/ti,ads7828.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index 05a9cb36cd82..afcb3dbf90dd 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/ti,ina2xx.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
index f553235a7321..63d8cf467806 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/ti,lm87.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
index 227858e76058..cba5b4a1b81f 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/ti,tmp513.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
index f58248c29e22..ee7de53e1918 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/ti,tps23861.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
diff --git a/Documentation/devicetree/bindings/hwmon/winbond,w83781d.yaml b/Documentation/devicetree/bindings/hwmon/winbond,w83781d.yaml
index 31ce77a4b087..6971ecb314eb 100644
--- a/Documentation/devicetree/bindings/hwmon/winbond,w83781d.yaml
+++ b/Documentation/devicetree/bindings/hwmon/winbond,w83781d.yaml
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-
 $id: http://devicetree.org/schemas/hwmon/winbond,w83781d.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-- 
2.43.0


