Return-Path: <linux-kernel+bounces-170640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C553F8BDA15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8247B28501D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13525548FE;
	Tue,  7 May 2024 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+XCp7id"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D895491A;
	Tue,  7 May 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055231; cv=none; b=lIYdwwl3aLWjP+8u8H3Urkf3xLrnWSgAA3j8SNUhveUw9a8GQQxIJWeECa2ElagyRQiSf/v3s37hcZ9kL3v52QT1/yp2hROP5fTY9AYUceMkyGNa8Ya3lbbvRrbZC67AEuwP2+JlpDr93Vc5+63vhvTdnY+0FYVLKZIc0zMDvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055231; c=relaxed/simple;
	bh=Mk/kaGfo1nd9dUr4W4lbqu4SomACMK5r/e5cywhFtl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1vT74AwZybEC8sHh3ev/KIe/MLjHN+1ebYtg2Pv2boqgx39Yh22S+NJ2+3ACZRK/f7yaeYJr6Z9hFgs6j1oxJzq/ESfB/u2+vRkhndtL3cmJ58MSOyQuC57n8EX47QN9Q7kkSdmXa6AoLzz7V/thhPKaMKLxR2X3GLM1pUFWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+XCp7id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FB9C4AF63;
	Tue,  7 May 2024 04:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715055230;
	bh=Mk/kaGfo1nd9dUr4W4lbqu4SomACMK5r/e5cywhFtl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+XCp7idKyIjVMcsKA+oB+O2qyzftDDngJzIZxvQmEXSUwKsST0zsEanCp6cRHZtE
	 hGbX3Vh7oCrNjogrFU9Exq8+4bwyMW6CDyU/qooWEnhAGblj7NOfOeq7vMrIF5CDak
	 C7vHmcqE1zMCd/lVNP7dioy10PL+OBawKYdBRxgbeT6E1rdMuNURjwtWUyxL4AiWw1
	 FOny4W7GPANtuk27HUHnVbeiTe4KEN0C2rR/LfERkKlDff8MHO8+FKpJBjA2JlSgnG
	 W/bgcllCUzj/ryPEAhZFONPi201g87QERhy7DKMov4rrN6eDZ2d2fMDs4D5Q/WFDmb
	 WZB6NQZRge7zQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 46D695F834; Tue,  7 May 2024 12:13:48 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RESEND v5 1/2] regulator: dt-bindings: Add Allwinner D1 system LDOs
Date: Tue,  7 May 2024 12:13:42 +0800
Message-Id: <20240507041343.272569-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507041343.272569-1-wens@kernel.org>
References: <20240507041343.272569-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel@sholland.org>

The Allwinner D1 SoC contains two pairs of in-package LDOs. The pair of
"system" LDOs is for general purpose use. LDOA generally powers the
board's 1.8 V rail. LDOB powers the in-package DRAM, where applicable.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../allwinner,sun20i-d1-system-ldos.yaml      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml

diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
new file mode 100644
index 000000000000..ec6695c8d2e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1 System LDOs
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  Allwinner D1 contains a pair of general-purpose LDOs which are designed to
+  supply power inside and outside the SoC. They are controlled by a register
+  within the system control MMIO space.
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun20i-d1-system-ldos
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^ldo[ab]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+...
-- 
2.39.2


