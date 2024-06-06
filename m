Return-Path: <linux-kernel+bounces-203844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0118FE11F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A3C1F270C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E513DDCE;
	Thu,  6 Jun 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3SBD04A"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E313A418;
	Thu,  6 Jun 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662996; cv=none; b=IxIb0Jg/rFwCo7Gto9BdvI6AzPwYbnjHC9UU1DS9cL4V1csfnzuC0G726K3BtXX6wxfTqC/EbVTiXUDxo8RIjj3zRqWuYvad8ZdBDKNachyL20D0Ewlj7EKc1RYdvyavD2DUsy5oqPITWFUUESYsWQobWSH7S+Rb0Om0MKuATjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662996; c=relaxed/simple;
	bh=epuSjPaOnZBTy0eZREg1ERtEbtPRRgAf/3MDZ+G7/RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQYJ7WRp6OSrXGGkQgOgnZgdJXcjGvrS/2MVxG7tIFiQxaOrHQYrhUWh4Q2h+Acn7y8p2S5eBVUS9ZJNcK14lPwIxQ9XModwhnWhs/lThYmncma14X4m4ZUFl1BoLPY/1NtGfFqIBSrtxP2gwooi9a9sZYScooKgAEi8GNXLJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3SBD04A; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d20b201179so261525b6e.3;
        Thu, 06 Jun 2024 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717662994; x=1718267794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN8Ys2aOQntChQ4GtaoxJ/3s2pQju6kNm6fRZuDzLwA=;
        b=R3SBD04A+Td676MwNw8FdHm4bQbC4mxPvynCcB7I9+1aI/V080B/PDskk/fPTCxnF2
         sykzieS/g3w5RY1OUGwv7TAFh7oE+GBM759FPMQhOV/tYI8MTpLgjTI6qvva9e7tXMAO
         sV+gD6WmvAyRn8NwFeOersc+Btm0qojYvfpC3QMuAZFA5nDKn0+wnrII6MFe830qZe7b
         g4nE1CrKL5nST/OEBMtnyeaU5lokn0UHuAG3YtON/pVHN/ZUBGY8wquEWGrPjNMLO3sY
         9bcsoFmEr0SJ+attYd6Sa8P4aQFkjH3b1pKpVGE/Pgznn257wl7b93qHvcfOgsAfNsU3
         v3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662994; x=1718267794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN8Ys2aOQntChQ4GtaoxJ/3s2pQju6kNm6fRZuDzLwA=;
        b=HPx8Lh9PmLoDzry9ownlnCV5syZSyI8e94i/b96d59VCva9FpJvWXzR9uCQwFUn0ja
         r2RefDJs5ItIvemnHjUPni0EfAn9sqlNNIxt+voi4rqCAFHp6wqiICf4ZJX7Ggt++yqj
         zIPlgejp1msF5CvHy/1Sa+oPsyA/QelOqR04q9zP0O2ZyI1AGXEO09bvgfNUVujJhorb
         lUGhujQJqyni79r3has7rpvfxzbcCr3lsoSzga96RMTdO4kGoanNZrQhfW5zBTHA8gor
         NHgGFirBHSoH5nlfSEBEEYvgyNMIGEusTl5D6PzRpGlXyUHodEcjn9dvai3uGsDvIFeq
         LuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Z0icu5og2zNwsyWfiUOqaYs/0ONP/C+pCohSB1dRjVLri3CxbvwmW+qr7eGdbgrFGa0BfUTof4YPqenGQZ6Q2v1QXxVaLCIwYCHrCyhN2dgkDMGwSAJmtBOOB8xQH64TgKo9emsNrJ45ZpjN6FNR/ZjziYrI/sUDQXPeiTYZri76Uw==
X-Gm-Message-State: AOJu0YxAF0ODBtcrfRmCkUPsMWQtu4SSwM07Ui0VLiwiUbf9ph+QzM03
	3INbuteWaOMVLQpfNtyyU9CQF8T0ho8CBTTNdD8ecj+vnTXU/kQ/
X-Google-Smtp-Source: AGHT+IEaazn1S9xkUFvVPViARh9f1/5t9GAN6zXJn8QWYaTd+YShk3b8NZdU/b53z9QJI/KR+p61mA==
X-Received: by 2002:a05:6808:484:b0:3d1:fdf5:a88e with SMTP id 5614622812f47-3d20429bfb1mr4902099b6e.21.1717662994256;
        Thu, 06 Jun 2024 01:36:34 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b69f240sm176572b6e.31.2024.06.06.01.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:36:33 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com,
	samuel.holland@sifive.com
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v16 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
Date: Thu,  6 Jun 2024 16:36:25 +0800
Message-Id: <a8da4870e3a966df01e1ac78d76005e42dd45ef2.1717661798.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717661798.git.unicorn_wang@outlook.com>
References: <cover.1717661798.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the pll clocks for Sophgo SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 .../bindings/clock/sophgo,sg2042-pll.yaml     | 53 +++++++++++++++++++
 include/dt-bindings/clock/sophgo,sg2042-pll.h | 14 +++++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
new file mode 100644
index 000000000000..1a417a627dd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,sg2042-pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PLL Clock Generator
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-pll
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Oscillator(Clock Generation IC) for Main/Fixed PLL (25 MHz)
+      - description: Oscillator(Clock Generation IC) for DDR PLL 0 (25 MHz)
+      - description: Oscillator(Clock Generation IC) for DDR PLL 1 (25 MHz)
+
+  clock-names:
+    items:
+      - const: cgi_main
+      - const: cgi_dpll0
+      - const: cgi_dpll1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2042-pll.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@10000000 {
+      compatible = "sophgo,sg2042-pll";
+      reg = <0x10000000 0x10000>;
+      clocks = <&cgi_main>, <&cgi_dpll0>, <&cgi_dpll1>;
+      clock-names = "cgi_main", "cgi_dpll0", "cgi_dpll1";
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2042-pll.h b/include/dt-bindings/clock/sophgo,sg2042-pll.h
new file mode 100644
index 000000000000..2d519b3bf51c
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2042-pll.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Technology Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2042_PLL_H__
+#define __DT_BINDINGS_SOPHGO_SG2042_PLL_H__
+
+#define MPLL_CLK			0
+#define FPLL_CLK			1
+#define DPLL0_CLK			2
+#define DPLL1_CLK			3
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2042_PLL_H__ */
-- 
2.25.1


