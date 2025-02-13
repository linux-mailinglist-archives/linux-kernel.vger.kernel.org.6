Return-Path: <linux-kernel+bounces-512178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15E0A33529
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E075167E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE2176AA1;
	Thu, 13 Feb 2025 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMsyZ5L+"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1415B0EF;
	Thu, 13 Feb 2025 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412564; cv=none; b=DyMwEUPyNua6RVdWbOHrr7zuo7uDPVKRzZxrN0cnCqvolfnNViNWlOhVXsU2hHPuq2+sBfnLu4JRdcDQQg6yD97wfd6N/WZnFuVTtRpeLrBwGm2LAmONPjSnXUUMsc7JUZy+WHpr9/1Sqz6SZ6Nh3hWJAbSTSsBfYuBldNNEeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412564; c=relaxed/simple;
	bh=qIy1cDnQXvi+9+0BBCLDI5rv7uu/H5O44c+G8u1SoVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbkGhGbWGCSe3IdNsQFmK4/4/lv4egLDTA4Uc50FVIoiZWZLDI9j4tqpR7sxa3xMt4LTD56Q/cfvjRiO7IXlgyQVGbublSnZoC64DUqTGfHTTYi5We5zcowGjKU7kPpXfUj5qhvgWmAJQI4/u+/iCgetRaCwnXIYF8RUQGws2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMsyZ5L+; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c07b15ad6bso11642085a.0;
        Wed, 12 Feb 2025 18:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739412562; x=1740017362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXFO5ZwHUw8wT3cUYBSdFuMkicgvLRpCU0vV1fZ6GT4=;
        b=DMsyZ5L+R6vhTrGNGVcd1e6Ai+OlCRmAgTfU5kvulnlN3jTUcEhG6j5A0+dEGfpNiz
         oACSgPaVvoNENAEJHcoFV/6A8+Wzw+kaAdRCsjR1p6GHDAe+bnMTITN7WY6R8ABj9KcX
         x6qfTwNkfT5QnjLCfv0oCJAGNM0oa7GjNDLk6uglpG6JPbsRaJTQ1hQyqH19w27uSUbc
         jDkwdxrTDSOD2KNR9zy0+8WCihll9ylOcdjQo3beHUyxixDEp5R5c0SsXpJMVqBsDrMM
         LQOkKLWRUb14HZR2XnGy/oydIhg45VhmhIvEK1CTtGKPdVwcTqaB1mj8CYmoiLfAm3Cx
         ghuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412562; x=1740017362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXFO5ZwHUw8wT3cUYBSdFuMkicgvLRpCU0vV1fZ6GT4=;
        b=lXYA5YPupWgNFuc5J+7Bb36xuI+o9/KCFJzc6a+9RnUC56qIexlj/NjybS9oB2O0L9
         79p0Fo1/sFD3QKQvox67hMkAbXKrmz/e+Nk8eaj5/6pZEA4MKoH5MrpARt+0axCFZ0hP
         Xq3tNmus/VPXAOjQw2rkgHjqcj1vJHElTMnrrzL5wzTFyuESj8lr9rkzso3zFnaN1Nc4
         N/n3ZSIzaV1tEJ1T72IMneD/xjrxDGTdVYIDcpylxM9Y0AJFuyRmJLb+yKlw3Uk2ddM9
         ss1OvBJjm/+v6WWKWDq8fiFpsCTF3J8GCPwMZlJeSe2LMteN1Nzai1ckG9Ypn1TqM0LS
         q4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmpOUOGuhOKS0Hi7S7G6ymyaPO7fUzfOCeo7+t1AIHFGfSMwWQQME4LKfR8asFJKZBuGi9eAMrT1XvIuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0liC4PpZuCkHQmtnJOCXUdK6SpTWlKIAp4CuU0/C59lOjD3pl
	AASCZ25gdpBw+H/B5FLdjjnBIRrtwKWuCIROOi5EK5CJgictXdmd
X-Gm-Gg: ASbGncvDCqvD95Iy1RABz7f5tAtg8Ql7M6JqcrfiULrbzOjiIVm0SjnA9lMn3x2cKLl
	NAb/NEv/zZSJRAocdTAjg6wLQa/G+Cnk2jZidhiEXILkX09pj5jUfuCjPRq1LCKgy8bci/68QfM
	YOpDGfMB/1061uTwNu4BAb6QtjBtKNKeHzdaMBsU5Oc3TJucjtwCDKaVmf7PdeNWPT9xqDCNIO+
	5LSVM69JY53N4Nt7JP0OpgbAhHQhNYqH6ZtPrKzPLWg6mqZTTrjwAWKw9fE+gaScDo=
X-Google-Smtp-Source: AGHT+IGffmi8fZ+IosqTR1SjXnCtscNOZQQHfesnJihozSoHKlGaGPOVdWX9TagyMdQaTU4+9bkRdQ==
X-Received: by 2002:a05:6214:4013:b0:6d8:850a:4d77 with SMTP id 6a1803df08f44-6e46ed77f20mr108840476d6.7.1739412561911;
        Wed, 12 Feb 2025 18:09:21 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65dcece5esm2389976d6.115.2025.02.12.18.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:09:21 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 3/4] dt-bindings: reset: simple: migrate sophgo sg2042 reset controller
Date: Thu, 13 Feb 2025 10:08:56 +0800
Message-ID: <20250213020900.745551-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213020900.745551-1-inochiama@gmail.com>
References: <20250213020900.745551-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate SG2042 reset controller to reuse the simple device binding.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/reset/reset-simple.yaml          | 10 ++++--
 .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 -------------------
 2 files changed, 7 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/reset-simple.yaml b/Documentation/devicetree/bindings/reset/reset-simple.yaml
index 77584e23e8e8..1c86b67ae190 100644
--- a/Documentation/devicetree/bindings/reset/reset-simple.yaml
+++ b/Documentation/devicetree/bindings/reset/reset-simple.yaml
@@ -16,9 +16,13 @@ description:
 
 properties:
   compatible:
-    enum:
-      - reset-simple-high
-      - reset-simple-low
+    oneOf:
+      - items:
+          - enum:
+              - sophgo,sg2042-reset
+          - const: reset-simple-low
+      - const: reset-simple-high
+      - const: reset-simple-low
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml b/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
deleted file mode 100644
index 76e1931f0908..000000000000
--- a/Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml
+++ /dev/null
@@ -1,35 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/reset/sophgo,sg2042-reset.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Sophgo SG2042 SoC Reset Controller
-
-maintainers:
-  - Chen Wang <unicorn_wang@outlook.com>
-
-properties:
-  compatible:
-    const: sophgo,sg2042-reset
-
-  reg:
-    maxItems: 1
-
-  "#reset-cells":
-    const: 1
-
-required:
-  - compatible
-  - reg
-  - "#reset-cells"
-
-additionalProperties: false
-
-examples:
-  - |
-    rstgen: reset-controller@c00 {
-        compatible = "sophgo,sg2042-reset";
-        reg = <0xc00 0xc>;
-        #reset-cells = <1>;
-    };
-- 
2.48.1


