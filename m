Return-Path: <linux-kernel+bounces-535153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D150DA46F99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB59516AD46
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7E026E976;
	Wed, 26 Feb 2025 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrfxNgXm"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4226E95F;
	Wed, 26 Feb 2025 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613394; cv=none; b=n95bvQtxoSLHxJmkg0ZWhw0Su3bnVn6xPCONUVABO7QHJnnwARywtpJyFotFN6xJ3cb9Afy0AeLNOy6krkvysXw3+shn27U6r4g6t4ouKEOpd08hrwgWamP+M+hk6GmnIWNpSwZL+b1rG4fmQe6ciVDZcnsjYIC8mPrrbBd7TJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613394; c=relaxed/simple;
	bh=5nbeFijLVWrUw6n6eqsPUa2kdXZ1lvYEM/TXnSUP7jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQCIt3sTivvM8mbKnuPhnPteEy3yGIAwPomku16q158a0/RUQPySIyrX9hXVrEU1mT/flPfnO4lE4MLWTbOaw8pWIZLCi9Uu7QavdbgccJpoZ0t5xsDnBngnC25vtIZBnU4DvWA4Gp17/tvwy40+fsUf/j8iJlglbiwZVxk7deI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrfxNgXm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4721bfdb565so4584811cf.1;
        Wed, 26 Feb 2025 15:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740613392; x=1741218192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3n4HDnuj7FUu1RXcHOZBNiyA5B87LpLpCZ3UB1bnbY=;
        b=RrfxNgXmUu2kjrnkDkM8MrkLoNy5JH/RbHQGpkhulUp5VvEIz1yJEnzjEzCLAhtwOj
         qcjZnT58VfSRNDaBg7xX+qLr3FYzLSruphoef+favF5tb4ozkLZjR2hhIQpLbh+PrKcW
         rQJ0T0p3uf95H5H/viV5qkzOyRAt0fDusrUPirqt/b+PiGJdXqGcdv4K7QdDWlNuzPuQ
         ZGStF5xPddNeJ1o0hxtnmNgt4F4N8FoV+5e/zAckDJ52/2rTY9ZPhdBbK2tc5AU4+xpk
         VSjV/cXrij2/S0wqERiRQcWc9/XKKriuYgGpBFsTNLZTtzt80FHhemUwz3ujmHYqns6j
         j0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613392; x=1741218192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3n4HDnuj7FUu1RXcHOZBNiyA5B87LpLpCZ3UB1bnbY=;
        b=wldoQW94b9AU+d4CvXPqgNLryqiJKyNW3gUTi8u2twTh5cvsfO69IUIyWjNYhk7jua
         VhGjGUVn6A69f3f2HxxKShv45HWJMjvfrw55C0OCeXLHSbpeDN5oA/QzkMQ/W5ZSHCkB
         2AIXbG1ePwqjYpbEs6qSwB9ExKtCh79JQOWJ5Taumm8Ps1PPSwx5dP4b+wh5cB+pknCt
         140UHGO4LCkkhi3b9KYyGWsFPeDEhgmEd3+G7FRJ/XXieDqFUs6IbaBoO0xh9AQ9wHPH
         TGqUNsJCYJumw7mss53/alUoAshWyIGheWVtE6KjL3Su5K36MRaaup8IA7Z0Ii79sJxg
         f9oA==
X-Forwarded-Encrypted: i=1; AJvYcCUkq/o2HAKPK9XKa9Ov5457BKbLQ+o7PAC2G02IZnKtxGOjG+XD5w5ZOQhg5XCMWFIG5r75euHWYdXwuM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3Dn3Cu8zRhJ3ltPuXmnq672+VUUEk7w99oVnf5r58+EeHvzH
	Cav+spN0J0HW7uCSuL+RuPtlyRV3yf6VD5K1JqVGb5UBiBXLEeAO
X-Gm-Gg: ASbGncsJSDnINPWY1rW67SOfLTd+jwdPAWXOiF6nYPDEvyrD1DWKruDlB8tu/qKK3Yo
	J0LfxHkkOVCDa8T0WYjxUkEM1qUrOER/CUehQVdScXY5HkApYxT7woz1R+AHad0/qCJi0VQo/Qz
	Vp8Pt4GmpFx+ZUP1p1BTeKyjFNfWBM0Jh06ipdCarqvMrsNu3PeWvUpZdnt+XI2KFS2VbGFypnL
	TW2I0pfMZ4Do/TN6OLKkIm+DwEx8MvajdSG4TyaVLO9X9hoeBGN+nPUabzOzSptjZJAWvZu5qpg
	og==
X-Google-Smtp-Source: AGHT+IFeqficLsjiBxpez3bq2ZeY469OujQH1LvDOLIZDbUA8CBYXJPaq31DTHUVw5/VEbpfwo/VkQ==
X-Received: by 2002:ac8:7d55:0:b0:472:182d:8b4e with SMTP id d75a77b69052e-47377118710mr156337051cf.1.1740613391750;
        Wed, 26 Feb 2025 15:43:11 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474691a1f78sm2822421cf.14.2025.02.26.15.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:43:11 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Guo Ren <guoren@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 4/5] dt-bindings: reset: simple: migrate sophgo sg2042 reset controller
Date: Thu, 27 Feb 2025 07:42:32 +0800
Message-ID: <20250226234234.125305-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226234234.125305-1-inochiama@gmail.com>
References: <20250226234234.125305-1-inochiama@gmail.com>
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
 .../bindings/reset/reset-simple.yaml          |  7 +++-
 .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 -------------------
 2 files changed, 6 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/reset-simple.yaml b/Documentation/devicetree/bindings/reset/reset-simple.yaml
index 86c33a608148..644884206ee4 100644
--- a/Documentation/devicetree/bindings/reset/reset-simple.yaml
+++ b/Documentation/devicetree/bindings/reset/reset-simple.yaml
@@ -30,7 +30,12 @@ description: |
 
 properties:
   compatible:
-    const: reset-simple
+    oneOf:
+      - items:
+          - enum:
+              - sophgo,sg2042-reset
+          - const: reset-simple
+      - const: reset-simple
 
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


