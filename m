Return-Path: <linux-kernel+bounces-174635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FD78C1202
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E12283277
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDC216F827;
	Thu,  9 May 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADaZwSgZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6E3BBE3;
	Thu,  9 May 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268676; cv=none; b=CgFOnfIo+Xiq4KKKVf/zjFVJYo3lHLW96XuZfag6yypV3GTnhv4vFA//pCngYEf3hpmq0CBZC1Nl4B+V6NDc88Nn7ytTu2ayZBGdYpMk17SDRNeVJk6Cesy2WzNOOs7A+WbllOdz8PcrxhBI4k53w9Jyp1ZMMYoGw2Hxtdyvipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268676; c=relaxed/simple;
	bh=Mk/kaGfo1nd9dUr4W4lbqu4SomACMK5r/e5cywhFtl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlcZhiLzSIcaXgqcplZNcjZKXQCPdle3xBv+3w+bkJmUiBXNnVouex3cK9snKlP20Po9ryAAzrfRhyaHr9mz+6GTjf3y93/YF4xWnWZqpey7K6lfdf5ukilBbHT/qRDaQMjdcP20Y86QZjeLnzAuWAT3T/koZNAQoBKLwXrc/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADaZwSgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14375C116B1;
	Thu,  9 May 2024 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715268676;
	bh=Mk/kaGfo1nd9dUr4W4lbqu4SomACMK5r/e5cywhFtl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADaZwSgZJu7O+aKWRjHMGcfG9AvFhTn6OAghl0gAx0X3BNJ2bRiqEBawS3yHds1RA
	 ubwlqC3kioPCC3+bmJkNnBG2CNytIRRM8aCxjhcCAFdsJUxV2GNnujGAPBiGBtWDSt
	 8XTXp1Yc5J3XXn/hPeUnKp4AJpj0e+Oa6AgE0iBdzjvGxIxyQRB6olbqYI/HrJnuVl
	 JZdnE5/nSxjOuBpKQ2BCMu/M+HSryBK9NGuRyIRklgB0O3s8YoJFzGKP8fYncPQgvh
	 txjHINbkPy7x5AyhS6K1qmQ9AszIaJx+2VoUINt/yEFlF89mngXSEfq1Dj1C53Ugvy
	 mnmS4sYZcRdLw==
Received: by wens.tw (Postfix, from userid 1000)
	id AD61C5F9B4; Thu,  9 May 2024 23:31:13 +0800 (CST)
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
Subject: [PATCH v6 1/2] regulator: dt-bindings: Add Allwinner D1 system LDOs
Date: Thu,  9 May 2024 23:31:06 +0800
Message-Id: <20240509153107.438220-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509153107.438220-1-wens@kernel.org>
References: <20240509153107.438220-1-wens@kernel.org>
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


