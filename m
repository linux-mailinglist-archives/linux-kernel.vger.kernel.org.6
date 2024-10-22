Return-Path: <linux-kernel+bounces-376321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1C09AA328
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19BF1C22365
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C1D19E999;
	Tue, 22 Oct 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="mSE0IYx9"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07A10A3E;
	Tue, 22 Oct 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603860; cv=none; b=IZGqVpqGqn3XhTH08Pqs9BC8EFt7HBxr57HHGy1E5tB1QdIUvD+6izl58uHx775hCynjCfqootVbnUunF0WGaHuLPu+v+RhnLlmAzzgob7fFH735kgyGbPof64xiiq0qN4zckaGk9Hpx5WP5u58cEeIO3qIUR7gg84bduNMs5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603860; c=relaxed/simple;
	bh=CxMzTLwNEreVUwuYl3nsdWHIncFsQbNXm2cUyJR10xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NndqRvVaT3pJTq6TaPGqUVLVb1rGMKzGtDOKY0EbzZQDseK2+OR/fvqNMMN5NolvR5ZrmKlhCfPa6znISZaz4mdqOYQU+ugrnipxky/GG21/niCqJCro5ZLERcDRPHM7aLK42lJyVt3TTyO0eKS5XmhXvRZSLT72ytiTlw0CG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=mSE0IYx9; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 22D3D88F31;
	Tue, 22 Oct 2024 15:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729603856;
	bh=ADgS1btn5VB1rPhyycx+bV2RpkrIr6nyI4uIsfq95tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSE0IYx9zSW23As5d55GIc6lj9HI7ACG7XosuFahfAPnFOEPV5uqhJqCeVJWUQzRq
	 KfcN1zc8+t9SJVWNVrzc1pIEtXKo9IRjLJkhVBZMWqNULi25mG3fBBMLS6ectMxkN6
	 eL/TZHPiAPrHzsvG/OkKxqbvRQHfet5gCKuw6JH9Ftmu1M5MccmztFnvdhPyejjwtP
	 CzGXfkQi4ctSNsoYdoOMqfnola9ONclCCC0qfzrIIc+qNYxc7mm/fUgSmniRt4zAVs
	 r7dxSid34PDvhYARcEwbccs9KIzfNMZUcfLW8hurczzdhrbEKxHwZiwxxWjPLMkJTy
	 H+mxKEQvfT3Rw==
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
Subject: [PATCH v10 2/4] dt-bindings: display: Add powertip,hx8238a as DT Schema description
Date: Tue, 22 Oct 2024 15:30:38 +0200
Message-Id: <20241022133040.686562-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241022133040.686562-1-lukma@denx.de>
References: <20241022133040.686562-1-lukma@denx.de>
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

Changes for v10:
- None
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


