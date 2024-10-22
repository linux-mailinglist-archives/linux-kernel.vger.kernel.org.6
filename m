Return-Path: <linux-kernel+bounces-376320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD29AA326
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5411283FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B619D898;
	Tue, 22 Oct 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="G8oU/LcQ"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB598D2FB;
	Tue, 22 Oct 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603859; cv=none; b=T9M5jj9lJW2lM4w2KBG0OccE0KEDkqY+RAssK0JneFRCnS0gqlBt3qgBCJqVPB46v5Ceu6v1cifUP2q8RGh3kA2Gl4MEGV2Ep8KzOEJbIjELk8UpnT3wQwAJyn+Xi36Qfuz+WLUoZhlnJGREsEcBfC5JZJadExmPEkvJa54WUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603859; c=relaxed/simple;
	bh=UBYWg/P38ggldnAitd4Wh6uQZdkGVVp0Kscv3ChErLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tkAKwG78skOTHi23BPF1UMyNeQusHatNyUIj2VAIZwszoYuvCoPIX8YnH/o5L9nJwLYzxue4aRWQK6aHDooQAuvZB7uN6JILHPgvSdUIOF323yTZ+0H1xhqPMQkWnh+XWAxhbVjl1OFdvWxc4g+s4Qg3xcEvDlWnhydTP0qtEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=G8oU/LcQ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 325BE88DFD;
	Tue, 22 Oct 2024 15:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729603856;
	bh=VaH7happnKXdf7oo35GO2g1xolgMuGQVULSYYPmeZLg=;
	h=From:To:Cc:Subject:Date:From;
	b=G8oU/LcQFZR1RALjySKuAkLGDbXlEv4tjyKuz21Pa7t8Y8gFj7kaJUUVbKdLq6Myk
	 g/cLsdxkFGuOrdTTBMh3tx0V7Xwzgih4HLx/xcTI0AkMiiy98NkTKbjmKI+MpIfx5Z
	 4Hti02u1rxdlN0DtjIDpP7wQJ752aoQmSYQ8T69dHOcc+qX9QH9BCFnsu3o+/aPZRl
	 GdaZ5JNIvZP4TrJVzSXl8t8eHPkVn8GKgNnTBXsyXVn6nr8BYxa6vtOAsBoXY1xxMK
	 dGLSPV/zQfu7g/dv2uqUPF2oQJPDknTpmc6UEbKoC0Jqm14Q8ZUg6B2hpin+oWVedq
	 9/ZcowI70evOQ==
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
Subject: [PATCH v10 1/4] dt-bindings: display: Add powertip,st7272 as DT Schema description
Date: Tue, 22 Oct 2024 15:30:37 +0200
Message-Id: <20241022133040.686562-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch provides the DT Schema description of powertip,st7272 320 x
240 LCD display.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

Changes for v9:
- New patch

Changes for v10:
- None
---
 .../display/panel/powertip,st7272.yaml        | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml b/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
new file mode 100644
index 000000000000..f09450da44a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/powertip,st7272.yaml#
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
+      - const: powertip,st7272
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


