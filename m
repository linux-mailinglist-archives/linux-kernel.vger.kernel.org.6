Return-Path: <linux-kernel+bounces-347925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA1198E08E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6CFB2EAAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BFF1D1510;
	Wed,  2 Oct 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnq9ps47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E51D0F40;
	Wed,  2 Oct 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885534; cv=none; b=l3gxPb4/U9J8unps6tX74YGiGaLBml0F3nl9PkpNYdUDy5vgPPYnFd0ZG6Ev9TFw1IBr6uIURl6Hg+q81QSANDxQmE+bGEGGDZLdoKCpaZuBao4KXDEFMTIxusTh094KTbL3qBMVU9ueC/phi8x1+GgFxCpca2v4CV//89Bmw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885534; c=relaxed/simple;
	bh=eGNgKeEbgQZhlP5/rBYHyxG3CCVZQ0AAqZnzmPdtdiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYRIRUfHi7zZEKoEeWxor8OfheVrAS71kXWYN6ijwzpEnNsrkEoWYB65ABbck1qrwUfSMyRu+5ziuO5hsruRvGouay7PIs7DoCCOmU0BzUXtZOX5E/WZvtyHf5M2gVXglZyUmiOi172Vxs+C/5LYkqd4bFKR2qOKAvKQv46Hu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnq9ps47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6DEC4CED2;
	Wed,  2 Oct 2024 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727885534;
	bh=eGNgKeEbgQZhlP5/rBYHyxG3CCVZQ0AAqZnzmPdtdiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnq9ps474zl9kcOUnvAVfU2YsrJMrat4YjA1CUovrMQSb+AwqFZvWnKv+JXM4pCtO
	 j5ta39uX82oghC1IuFobvtRioh+AcU+ghBgZ8qg+YcKKJxhdRmx/jJKyu1SmPAcdrC
	 lPL6hW8TsEIDgHHC+lZhtf9qU+89jL2ckL5RUVjfn/91pDXNeUrkNIFVya2uuDa0zo
	 +jSniu8tZ2WZqtyTQiTP78+xJ1ASEhMcIhlBTwc6tJixqGiTlDV12gWrTQJtQJAcqt
	 DPjg8lQ9xeYoQtIzfEhPcnl1eEpuU5CKOc6213xce5xHfkzV+SUJTiNxsWj5AtqhGm
	 vxQeLaNWTpRZg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v1 4/5] dt-bindings: riscv: add vector sub-extension dependencies
Date: Wed,  2 Oct 2024 17:10:57 +0100
Message-ID: <20241002-eagle-fresh-4b2e259e45ee@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-defeat-pavestone-73d712895f0b@spud>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=YIm6fXkkXwfBUiAT+70BG7jJ6bMEmlZ2jL6v+Po7WK8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/CyY0Zoc48mS6G21S1XxefMrtmenFKQyKSqaFz+umR bh86WvvKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwES4XzIyrP+5KeX87tPv9z/s NjrFd/HKDu1jRsszzUO/FlbGFsl9OM3IsOU2T0wIr6gn16pkD1Pe468u85z7wHPEMkZx8lmB+9+ fsAIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Section 33.18.2. Zve*: Vector Extensions for Embedded Processors
in [1] says:
| The Zve32f and Zve64x extensions depend on the Zve32x extension. The Zve64f extension depends
| on the Zve32f and Zve64x extensions. The Zve64d extension depends on the Zve64f extension

| The Zve32x extension depends on the Zicsr extension. The Zve32f and Zve64f extensions depend
| upon the F extension

| The Zve64d extension depends upon the D extension

Apply these rules to the bindings to help prevent invalid combinations.

Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-698e64a-2024-09-09 [1]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 779f5cfab806e..abf2579171c5b 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -605,6 +605,52 @@ properties:
           contains:
             const: zca
 
+      - if:
+          contains:
+            const: zve32x
+        then:
+          contains:
+            const: zicsr
+
+      - if:
+          contains:
+            const: zve32f
+        then:
+          allOf:
+            - contains:
+                const: f
+            - contains:
+                const: zve32x
+
+      - if:
+          contains:
+            const: zve64x
+        then:
+          contains:
+            const: zve32x
+
+      - if:
+          contains:
+            const: zve64f
+        then:
+          allOf:
+            - contains:
+                const: f
+            - contains:
+                const: zve32f
+            - contains:
+                const: zve64x
+
+      - if:
+          contains:
+            const: zve64d
+        then:
+          allOf:
+            - contains:
+                const: d
+            - contains:
+                const: zve64f
+
 allOf:
   # Zcf extension does not exist on rv64
   - if:
-- 
2.45.2


