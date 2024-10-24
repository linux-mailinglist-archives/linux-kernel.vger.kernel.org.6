Return-Path: <linux-kernel+bounces-379860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABEE9AE4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D8AB23950
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC911DD0C7;
	Thu, 24 Oct 2024 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwlgVcWo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046041DBB24;
	Thu, 24 Oct 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773288; cv=none; b=OIIG26ZUG7CdtapaR7222/JtDdaON6agmQQ5YhY/l47M55gsJVqZuWiTeAIE2b/vaAhAUzprSFI2XD896QqGqT5ieY45zsyIOfQ5j7IBhyQScBZYg+PaNx5c+wRki+dumThiSJvIyBuPr5Nnh9lkPYm9/SaHALmgXzGT18HXjhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773288; c=relaxed/simple;
	bh=hcHQ85R98EralwanuOTJcKXBev45BYhijHl4CsbVU8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsI6qHm7wQfRCeVuZX2t/QP6+5NEyy/SEozM+d4Kp8+J1NW5r2iszsZ55jTZ9R9IqE4QnMSFmv4s+3sZ9MgpVKPkCSq7hc3tEbzdte6hIHAPfNCEpKhsGa/LyT+gxV6PDsYkzGyut+kdIYubzuMMBIH61TxP9KG9Ru7BXUi2sOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwlgVcWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31664C4CECC;
	Thu, 24 Oct 2024 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773287;
	bh=hcHQ85R98EralwanuOTJcKXBev45BYhijHl4CsbVU8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwlgVcWohf/PXX/NXbuf6IhjVQcE6oIeCiieIkydcuP/6t2WN6L8/5hjL3cV9j4Kn
	 pdisnl936vFNrkfznY3+tiFTMJ1+SibbZeAanZB28AyRHxBZgbkWitgdsSgF/32k6N
	 +a+mukmFxGSjMqij0th5tobFLDzMCiew3jTPGkHduQ3fV1AbhvjvLZNX1iYIFlImVB
	 OYzw5QroUsCKCLrV9p+S7UXFK9ndLg+vgfFw6YrN+UJOt2+QMiz+CRxN7sAR35Em17
	 d+HkphUY1goR++ttyX4JEb3vL7Rqeb0FmTQwwGRobco9wwJSpDcM+Pmy3M3LaLcV1/
	 9mF+no4iqgnXg==
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/5] dt-bindings: riscv: add vector sub-extension dependencies
Date: Thu, 24 Oct 2024 13:34:32 +0100
Message-ID: <20241024-shrink-eligibly-b5a4325fa286@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024-fanning-enrage-bcc39f8ed47d@spud>
References: <20241024-fanning-enrage-bcc39f8ed47d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=DCTAFUzYk9DPluUbp/0vltmkI6PevBaQollD7j8w0BM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlSdtfmT3FZzrp91XWh/0yTOp/lan56v6BUt1Vlys+eZ zM12WdO7ChlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEvsxjZJjrzNR/Y0HK+fdN 17Z4dIib2b0w6ym+zHnQfk1izLEnypUM/x3+rKtfvrr9842re49ELJM7kj5BZOeuvR7+bKn88SJ ywnwA
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
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index c697be64d3bfc..20cead7d8af71 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -612,6 +612,52 @@ properties:
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


