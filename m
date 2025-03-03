Return-Path: <linux-kernel+bounces-542070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3196EA4C52A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05FC18919C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E3423E35E;
	Mon,  3 Mar 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l4RuxHhV"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0B217F54
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015526; cv=none; b=Cuo0vXApHZ5eAB33SVGTAcPISlgkcJYPVdRWZIFlAT3DePLMYuyyAohybNQPAjjqAsvUxqp+ir25K+jPEP2d1yNyNwrWfI3Ya0iko4/qpSSKwBJRJ34KLN2e21YDDAuxE085vVVa8ttd056sVdVFJxgNNg5b2HtJQbLDi0GukHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015526; c=relaxed/simple;
	bh=jL/ZOxKyvdqpOrclFp17pKr6a7qXhVpu9FIi2TROBG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=p0642TWYcmwhF7AVxTBxL3N4fb7HPtYCjiIgWZiBSwxH+FYxKrWfzJkqGUiJPS216H8zlQX98vnP/EeWOJV1DnN6iHbsaop6GF7uymgII7xbZZGDy3t4YrH6h0Krq0PptwypdkLHa338nvUhrg+fQ6LqmjFaIFX9dT7XwfBHmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l4RuxHhV; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250303152522euoutp0184b77ed4fbf2f4f070ed6c8ec776dc8d~pVGSnBM9E3089530895euoutp016
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:25:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250303152522euoutp0184b77ed4fbf2f4f070ed6c8ec776dc8d~pVGSnBM9E3089530895euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741015522;
	bh=jVZ5nqMUcHkMSF5q4NF0ZDob3npe9EZcPVY0lveTg7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4RuxHhVjTXMp0j2jvZWDvUadTXJ+ViOvhpiLmcgjMZtvr8Gz/Zje6U88OrlDChHn
	 3AdyWcKfDo1L/ZOGTMr38Yv9iar1iGP3TiKT5dchayyt8GYgP8Ao04/FpFoa6hqwOJ
	 84LFrEh9QHTJF5AZTNnnYsjedqINhmYG7BSEDg6k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303152521eucas1p2f92030379e8cd9f51ef57b96ee6cb76a~pVGSU3aEx2155721557eucas1p26;
	Mon,  3 Mar 2025 15:25:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 48.36.20821.1E9C5C76; Mon,  3
	Mar 2025 15:25:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250303152521eucas1p26c54c5b15c024d749cf004b66345d2e0~pVGRsBRTE0643406434eucas1p2O;
	Mon,  3 Mar 2025 15:25:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303152521eusmtrp1eb5a81ce83872562a3d2cf596a237284~pVGRrVhT30903609036eusmtrp1L;
	Mon,  3 Mar 2025 15:25:21 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-63-67c5c9e1004d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2C.E0.19654.1E9C5C76; Mon,  3
	Mar 2025 15:25:21 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250303152520eusmtip1f98e75370d2129a10a90094783353ada~pVGRAmQWx0673706737eusmtip1j;
	Mon,  3 Mar 2025 15:25:20 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michal
	Wilczynski <m.wilczynski@samsung.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v1 1/2] dt-bindings: reset: Add T-HEAD TH1520 SoC Reset
 Controller
Date: Mon,  3 Mar 2025 16:25:10 +0100
Message-Id: <20250303152511.494405-2-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303152511.494405-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7oPTx5NN2h9Z2SxZu85Jov5R86x
	Wty7tIXJ4sXeRhaLl7PusVnsfb2V3eLyrjlsFmuP3GW3WP91PpPF3XsnWCz+79nBbtGyfwqL
	A4/HplWdbB53ru1h82hZe4zJo/+vgcf7fVfZPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSuj
	ZeY55oL5MhX7js5ibGB8Ld7FyMkhIWAisXrya8YuRi4OIYEVjBKP7jyAcr4wSuxf/pQVwvnM
	KDFhwnU2mJaZj64zQySWM0pMP7mZHSQhJPCGUeLONw8Qm03ASOLB8vlg3SICSxkl7nf+Autg
	FljCKNHcuQ+sQ1ggRKLx20swm0VAVeLlxltgK3gF7CRenWxlhlgnL7H/4Fkwm1PAXmLrs/9Q
	NYISJ2c+YQGxmYFqmrfOBlsgIfCBQ+LSihuMEM0uEq2dP6AGCUu8Or6FHcKWkTg9uYcFws6X
	eLD1E1RNjcTOnuNQtrXEnXO/gJZxAC3QlFi/Sx8i7CixbP9pJpCwhACfxI23ghAn8ElM2jad
	GSLMK9HRJgRRrSYxtacXbum5FduYIGwPifkvXrJOYFScheSZWUiemYWwdwEj8ypG8dTS4tz0
	1GLDvNRyveLE3OLSvHS95PzcTYzAhHX63/FPOxjnvvqod4iRiYPxEKMEB7OSCO+t9qPpQrwp
	iZVVqUX58UWlOanFhxilOViUxHkX7W9NFxJITyxJzU5NLUgtgskycXBKNTClX66pSDt8aMdF
	/42si91v9b6Lu/9z989Ft2/rJPM1r4qMCBXObL7W5n77xezsXfIZL5baxf36aJOdtSDp26zn
	/Q81N/94uFrx85/nH1/buTNM22cyvWDe3dAv0iXqDlYL2UU2TUqaNqfcjf3Q9IdcqdpK7O/V
	brnfSztXOG33/2kTFj/YPSta2CJWYuVzj2+TQ/ffEe+Yc2Ha8X1WtuGfTinO8fescArltLFU
	/FO2KvB+x0/tNLGHwt+ZL9W+Oqbsv0WykHPaxO0Mdksvh05bYH7gKLe4+H7moNSJR5gFX01d
	9axn0xz2hxy3HxYIZOX8KdI/Xtt605ln+uuNs821PHeePrHGWmf1/R+bP/hkmCqxFGckGmox
	FxUnAgD12ngOxwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7oPTx5NN1jSyW6xZu85Jov5R86x
	Wty7tIXJ4sXeRhaLl7PusVnsfb2V3eLyrjlsFmuP3GW3WP91PpPF3XsnWCz+79nBbtGyfwqL
	A4/HplWdbB53ru1h82hZe4zJo/+vgcf7fVfZPPq2rGL0+LxJLoA9Ss+mKL+0JFUhI7+4xFYp
	2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS+jZeY55oL5MhX7js5ibGB8Ld7F
	yMkhIWAiMfPRdeYuRi4OIYGljBJXej6yQCRkJK51v4SyhSX+XOtigyh6xSixcdoyNpAEm4CR
	xIPl81lBEiIC6xklOq9uYgJxmAWWMUocfPqAsYuRg0NYIEhi211WkAYWAVWJlxtvgTXzCthJ
	vDrZygyxQV5i/8GzYDangL3E1mf/wWqEgGrunZ7BClEvKHFy5hOwi5iB6pu3zmaewCgwC0lq
	FpLUAkamVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGxte3Yzy07GFe++qh3iJGJg/EQowQH
	s5II7632o+lCvCmJlVWpRfnxRaU5qcWHGE2B7p7ILCWanA+M7rySeEMzA1NDEzNLA1NLM2Ml
	cV62K+fThATSE0tSs1NTC1KLYPqYODilGpismWTmi4U8mDFh+jHpgqwVLuvuJwSnhZ5Rlnoz
	RWzKsuvbLsmsdTtd+1/0o+RkG+vXp4Qjtk41Fz/3+qhhlM2EZkO2xbnXS8IX789OTpm1t4d9
	Ks/a0Hn9/p8rpxXMff+8K27HCnXlpeYq5XW7Ld3XLzj5tfrlnF9LEip8RNi/Pj8lpvljvtWR
	/tdcsf927jwiVBT9SvWpoSzvw5rjZguNviyY81tj/q+4sICIkgzdfSnPq07FxfpPnvZt0SGe
	jWa7HV/EHLN+u+mO16fF5ZWH/r7bmdmoFVckKywfHs4UFWPd/C9xkdzNbeavOlbuc1r5N/bM
	V7/faZl2N3pkg4P6LeZHM37Zma4ZPuXh9DBBJZbijERDLeai4kQAT2fr8TYDAAA=
X-CMS-MailID: 20250303152521eucas1p26c54c5b15c024d749cf004b66345d2e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303152521eucas1p26c54c5b15c024d749cf004b66345d2e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303152521eucas1p26c54c5b15c024d749cf004b66345d2e0
References: <20250303152511.494405-1-m.wilczynski@samsung.com>
	<CGME20250303152521eucas1p26c54c5b15c024d749cf004b66345d2e0@eucas1p2.samsung.com>

Add a YAML schema for the T-HEAD TH1520 SoC reset controller. This
controller manages resets for subsystems such as the GPU within the
TH1520 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../bindings/reset/thead,th1520-reset.yaml    | 44 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 .../dt-bindings/reset/thead,th1520-reset.h    | 16 +++++++
 3 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 create mode 100644 include/dt-bindings/reset/thead,th1520-reset.h

diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
new file mode 100644
index 000000000000..f2e91d0add7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/thead,th1520-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 SoC Reset Controller
+
+description:
+  The T-HEAD TH1520 reset controller is a hardware block that asserts/deasserts
+  resets for SoC subsystems.
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - thead,th1520-reset
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      rst: reset-controller@ffef528000 {
+        compatible = "thead,th1520-reset";
+        reg = <0xff 0xef528000 0x0 0x1000>;
+        #reset-cells = <1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 18f0eb293519..819686e98214 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20417,6 +20417,7 @@ F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
+F:	Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
 F:	drivers/firmware/thead,th1520-aon.c
@@ -20426,6 +20427,7 @@ F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
+F:	include/dt-bindings/reset/thead,th1520-reset.h
 F:	include/linux/firmware/thead/thead,th1520-aon.h
 
 RNBD BLOCK DRIVERS
diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
new file mode 100644
index 000000000000..00459f160489
--- /dev/null
+++ b/include/dt-bindings/reset/thead,th1520-reset.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ */
+
+#ifndef _DT_BINDINGS_TH1520_RESET_H
+#define _DT_BINDINGS_TH1520_RESET_H
+
+#define TH1520_RESET_ID_GPU		0
+#define TH1520_RESET_ID_GPU_CLKGEN	1
+#define TH1520_RESET_ID_NPU		2
+#define TH1520_RESET_ID_WDT0		3
+#define TH1520_RESET_ID_WDT1		4
+
+#endif /* _DT_BINDINGS_TH1520_RESET_H */
-- 
2.34.1


