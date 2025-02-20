Return-Path: <linux-kernel+bounces-524890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66112A3E86B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8543B4120
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B42A267F4E;
	Thu, 20 Feb 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FAEqlyfB"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823A1EA7ED;
	Thu, 20 Feb 2025 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093947; cv=none; b=piMhpYQRD2aP1Kl7qYFIcUvC6gZXPDntZD74ViGdxeP+SA+Lc39AO1FPuO/MdLhvs6q5o6CGn9C1JIPSH1A4/wNgQ7Wht8OMGxOFL2+UKJ8rXcaTpiUvGPdasO0UkjGu1cGtz6zLy47Jb2fvnutLzSrhMKYREBiu05tVrPqMSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093947; c=relaxed/simple;
	bh=7yZX71Bki90ZJ+6KlThDOfT1xQCtYSa5eTnXpR5m838=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upsVLu1/PLIZG+eNiQ5edLF1je8pKNEJyBFvKxpxxoCxLf+D4/AMBcr+lyPUlOxSuZeHwonMh18hpjxDhQpOTUItZip3VWSDIHW69I6vKIWG1H2GXNYLmFvt2ObmSYwAicmmsDd8W64m+5pGE2MlX21jodcVTBDg4hBtI+VMkTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FAEqlyfB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KL98lg029271;
	Thu, 20 Feb 2025 15:25:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	gI/JkITGmiVT6A6VUwLoEgtIIyCPMZwHp5YWFEWg+g=; b=FAEqlyfB4jvlPoTNM
	o9/kc5/YIjScGkck9aIy8P95tBN5AUy73qMuhuhlVCDawkED8Jjp6dWn60Ee9hJP
	55W9PQ8QFeh/p3/YVrtey1TWY4/j1zaKJy1YzDdVp5kMUBj4aIE+qFDnQxDW0Hl3
	BdnYbnBQFtcQrOtapRWDlDnZa6Od2HuXI7VoTmJ++w+Wti59HUuQWW/dAyfF9mK/
	9oAp6Hxa7SypWSLoTPzm4YqBZzXeHUpy/TNofRGYR2FxrLF+9wTpxwjttNiF8Jr7
	sSbwGbJur5+vFr1LtyDxfvJTuyZFgXW80rmibmLMoZc2W6i+c9HWeVgwmwxfyT1T
	bcd/A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xc24r915-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:25:31 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Feb 2025 15:25:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Feb 2025 15:25:29 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id C4E2D5B692F;
	Thu, 20 Feb 2025 15:25:29 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH v2 1/4] dt-bindings: reset: Add Armada8K reset controller
Date: Thu, 20 Feb 2025 15:25:24 -0800
Message-ID: <20250220232527.882888-2-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220232527.882888-1-dingwei@marvell.com>
References: <20250220232527.882888-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8ONWU7Zuw7aqAk6-fBizNeu7df81an_Q
X-Proofpoint-ORIG-GUID: 8ONWU7Zuw7aqAk6-fBizNeu7df81an_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01

Add device-tree binding documentation for the Armada8K reset driver.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 .../reset/marvell,armada8k-reset.yaml         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
new file mode 100644
index 000000000000..b9f7f3c24d3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
@@ -0,0 +1,45 @@
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
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the gpio registers (in bytes)
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - offset
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon0: system-controller@440000 {
+      compatible = "syscon", "simple-mfd";
+      reg = <0x440000 0x2000>;
+
+        unit_swrst: reset-controller@268 {
+            compatible = "marvell,armada8k-reset";
+            offset = <0x268>;
+            #reset-cells = <1>;
+        };
+    };
-- 
2.43.0


