Return-Path: <linux-kernel+bounces-374053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684339A612F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D21A1C23CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260621E9095;
	Mon, 21 Oct 2024 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OY/Cdub3"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527071E884E;
	Mon, 21 Oct 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504982; cv=none; b=FW25dHqfxwzz4JEWCsGvnzr7qx9AxHT45Oi4ZOQS21BW1ULl2MI+AqBe5Pt8NOLDahaQ7DvvDThJcwdC1DDgDix54vKePA1l+wYTWqe7W7fcSSxu1TwciZNdvW+pbjA2ZBo9ljlL4l9bISXZ8TSXjXVJoVolBJ9hPm067uRs7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504982; c=relaxed/simple;
	bh=6GUTLhMxADC2p7D4IaQb2D1OfDYEOadNM0bWrkEZ3CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLMkAC9ZIplTvMh+D9vDzX7O9VUzYPfXelAqsWT//cuOs5/A9PhcB+Pkdtg5AdXNAO+VrZc2Ra42NSQZoIODFqTreiwNX2QtV6Rf5xeiOU7esTcgW/bSeIafEqxQ9ygI5iCuhAXX9KcJgtHMgoukC59yyjuDa8nxbAmSNTxeJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OY/Cdub3; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AAD9B88E61;
	Mon, 21 Oct 2024 12:02:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729504972;
	bh=L9t1eLCCSP1DToTmoQEkq5og456j4kSOQ7rvbEPgzzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OY/Cdub3llZbGCtguEur0MhT00i0/cuJCL92aifJYo8qVWCSIkyRl9OvfDpd5jZz4
	 ALbh+zhm4YLBYAgEgtVJFsOJe/G3+TwuUgVrBc12n/LYWaTMKM/qHERz/XOvlJEz5Y
	 x4QR0xPrNClyVfWj/3L7Mnghj3N0O0c59iFs2xL0RQtU2gUYx5mefQXE9Rr0XR36lC
	 Lh6Oq80dAHQQdfvBf0TxAA4zH7n2Iseehv/S2aj531/G6fEsNoz7mO9F4Xg+x6SADg
	 U90vHzbQS/cRsJou+g+TLjoIAqypyOdfinukWWVGiZNl9f8S1TKXzIZsBZ/zqCtsjY
	 T90z9+CBkBgmQ==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v9 2/4] dt-bindings: display: Add powertip,hx8238a as DT Schema description
Date: Mon, 21 Oct 2024 12:02:22 +0200
Message-Id: <20241021100224.116129-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241021100224.116129-1-lukma@denx.de>
References: <20241021100224.116129-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch provides the DT Schema description of powertip,hx8238a
320 x 240 LCD display.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

Changes for v9:
- New patch
---
 .../display/panel/powertip,hx8238a.yaml       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml b/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
new file mode 100644
index 000000000000..7b4557ef6b74
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/powertip,hx8238a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Powertip Electronic Technology Co."320 x 240 LCD panel"
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+allOf:
+  - $ref: panel-dpi.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: powertip,hx8238a
+      - {} # panel-dpi, but not listed here to avoid false select
+
+  height-mm: true
+  panel-timing: true
+  port: true
+  power-supply: true
+  width-mm: true
+
+additionalProperties: false
+
+...
-- 
2.39.5


