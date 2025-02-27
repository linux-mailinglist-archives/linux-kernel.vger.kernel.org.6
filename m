Return-Path: <linux-kernel+bounces-537186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DDA488FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D626B188FED7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA10B26FA59;
	Thu, 27 Feb 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VnIeBX4w"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DD26E951;
	Thu, 27 Feb 2025 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684365; cv=none; b=YvdUj2u9U1Eo5H7bwd1LdkD718cebHWGBQhqI678VrMe/xJb+BLy6EJRE7JAkXcI5EA2csUxv/fmpIuTX5U3pWH3yAl0WHRLSh/AdY2OkHIYrXHM3sgh42n7cKY3FILOlIpOGCkV0BGfRqYyG2S4/vK5wRV8FwiBdZ+wuxxS4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684365; c=relaxed/simple;
	bh=jfhyCIT1u2l4MOfw5bZcxLsXuzvMXXJhDxKZOGfQBgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4ioKsr8ErMkzajAff7FjcKVygTfwijcNfbQmMPNix66m/i1WLnjY5vA2LHmus79FaGhVzuW/Ke9/w0Uroco1YfdefSYEcoMDapwxFGNmRVQqHyaIqMUNLrpAzsiCUg/uQfnCznkM76vRaRKt44JZ6CIvzvJQX4ve/C+XwMEIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VnIeBX4w; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFdiZ8015307;
	Thu, 27 Feb 2025 11:25:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	YPf7pOW+Hj9D8sJ8EeNXB6OJG/17TDHY4ejPKDvTh8=; b=VnIeBX4whSckZyxXO
	cw7vWLHgxdRIvUD32YI3HhQAABY0MrYuFr9EQuHvZnUCB6PVIRs3IhMuUxKvZkOu
	VAPm/OiK+vERfnNA22BHMcWObW4faBWHgB1RIwwhQYEtRmF2l7YcKzWTiXBOVqzi
	E5mZ14GqfbVTWxe97HxyP2plimYYHpqf+1VThD5NaXo5BuRrwtqT7M1qDdr8YKyM
	qNKOpb9V00gZRYO5jIfMujlIintq4Vt63AKNFKGxtGZhwpCCIm6IsGLRi7ALvT95
	Z40magpFpbLip4KHGbQaELg/VamJ3ROjbtB8V+b2j4s6+up1rZRzTyBMG6XHdZoF
	o/ZlA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452tvrrhfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:25:39 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 11:25:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 11:25:38 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 3D28B3F707B;
	Thu, 27 Feb 2025 11:25:38 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K reset controller
Date: Thu, 27 Feb 2025 11:25:34 -0800
Message-ID: <20250227192536.2426490-2-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227192536.2426490-1-dingwei@marvell.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Y680ExBWjBukpnyqiqhf4B8U9NOTk1FL
X-Authority-Analysis: v=2.4 cv=COHQXQrD c=1 sm=1 tr=0 ts=67c0bc33 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=T2h4t0Lz3GQA:10 a=gEfo2CItAAAA:8 a=M5GUcnROAAAA:8 a=Xx2rH3x8VMMp6ogthC8A:9 a=RVmHIydaz68A:10 a=sptkURWiP4Gy88Gu7hUp:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Y680ExBWjBukpnyqiqhf4B8U9NOTk1FL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01

Add device-tree binding documentation for the Armada8K reset driver and
create the new head file for the reset line index definitions.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 .../reset/marvell,armada8k-reset.yaml         | 48 +++++++++++++++++++
 .../reset/marvell,armada8k-reset.h            | 27 +++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
 create mode 100644 include/dt-bindings/reset/marvell,armada8k-reset.h

diff --git a/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
new file mode 100644
index 000000000000..9af352f528de
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Wilson Ding <dingwei@marvell.com>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/marvell,armada8k-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada8K reset controller
+
+maintainers:
+  - Wilson Ding <dingwei@marvell.com>
+
+description: The reset controller node must be a sub-node of the system
+  controller node on Armada7K/8K or CN913x SoCs.
+
+properties:
+  compatible:
+    const: marvell,armada8k-reset
+
+  reg:
+    description:
+      The register offset (to syscon register address) and size
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
+    syscon0: system-controller@440000 {
+        compatible = "syscon", "simple-mfd";
+        reg = <0x440000 0x2000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        swrst: reset-controller@268 {
+            compatible = "marvell,armada8k-reset";
+            reg = <0x268 0x4>;
+            #reset-cells = <1>;
+        };
+    };
diff --git a/include/dt-bindings/reset/marvell,armada8k-reset.h b/include/dt-bindings/reset/marvell,armada8k-reset.h
new file mode 100644
index 000000000000..18c6f4f761e2
--- /dev/null
+++ b/include/dt-bindings/reset/marvell,armada8k-reset.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Marvell. All Rights Reserved.
+ */
+
+#ifndef _DT_BINDINGS_MARVELL_ARMADA8K_RESET_H_
+#define _DT_BINDINGS_MARVELL_ARMADA8K_RESET_H_
+
+#define CP110_RESET_AUDIO		0
+#define CP110_RESET_TDM			1
+#define CP110_RESET_ICU			2
+#define CP110_RESET_PP2			3
+#define CP110_RESET_SDIO		4
+#define CP110_RESET_XOR1		7
+#define CP110_RESET_XOR0		8
+#define CP110_RESET_PCIE0_X1		11
+#define CP110_RESET_PCIE1_X1		12
+#define CP110_RESET_PCIE_X4		13
+#define CP110_RESET_SATA		15
+#define CP110_RESET_USB3_HOST0		22
+#define CP110_RESET_USB3_HOST1		23
+#define CP110_RESET_USB3_DEV		24
+#define CP110_RESET_EIP150F		25
+#define CP110_RESET_EIP197		26
+#define CP110_RESET_MSS			29
+
+#endif /* _DT_BINDINGS_MARVELL_ARMADA8K_RESET_H_ */
-- 
2.43.0


