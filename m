Return-Path: <linux-kernel+bounces-557779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0507DA5DD99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2829B176F28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF8824DFFE;
	Wed, 12 Mar 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL0QnZF/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424A2459C3;
	Wed, 12 Mar 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785167; cv=none; b=HF1T6bODGIJW32y2q7BkIzZShaYAZjHjmWTrty0N7dpoL3AlInqhuVl4PCZinl8FZgC9C7iFTVB+OBvBlfnHyc3Cyjp9cJ+il1jRV0RwFSuopE7wr6NXjoOv4vsdNkFPA6KpS6loAGUZG7UHV3bwbuE8z+ci4p9V5RwTHuAQcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785167; c=relaxed/simple;
	bh=Hx6D1rRpddICfBXk7BrrDIlZsj2WNmHzrd9slgJOb4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMQNhf223xGCJxiNmJQScLW2eoWyrZ264ot6mftKZI6vUC5MZmOMurZhLqcRc73Y584Y+XHnsS17eMoTiKBmRCMUWm31SZEEeQ6nOuZI2Ou7Su8BStYPWu8/3iTC6o6oIdwLg6542X0GkZ5Py+U7ZsbNsxSfh+w9AxMLDK0U33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL0QnZF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A19C4CEE3;
	Wed, 12 Mar 2025 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785166;
	bh=Hx6D1rRpddICfBXk7BrrDIlZsj2WNmHzrd9slgJOb4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uL0QnZF/AmCr1lTHvC3CGU4eIfndJpktr0hFVYpE4lTFegFmXuMwkkzNhSmsPUx7h
	 0YTwIKbgL1xZmzJ6nmd7J266JQ/H0HphOdEcyqg2u/DubrO8ZOm0Lz9YCCnxhHw4Wi
	 BbrlYDO56pP9dgFbqVoL9JSE3yoUgxmZDPZtzNSxRzDuqsL//fd3Pr92/koG3HHtvY
	 VA47GMEMMLKmaS+Bof2Ufgg6Vj8OVAR8XcfRE3g395LHFc5gjz8Y6rsUpGDaMzabp1
	 c3vhxuoO2djfzi7zMNhMqyd20eQac1W7iKPVP/jwUfUflT81RZCBXoQekzUxPuF26J
	 yWRl6Mg4t6AOQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/6] dt-bindings: riscv: add vector sub-extension dependencies
Date: Wed, 12 Mar 2025 13:11:48 +0000
Message-ID: <20250312-banking-crestless-58f3259a5018@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312-abide-pancreas-3576b8c44d2c@spud>
References: <20250312-abide-pancreas-3576b8c44d2c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=GdLuIc5EAIS3gpLTxrlq7jFgE0FxstD07lH/xrh31/s=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkXO0SKZZOqWNj/rFdM6zO18+vQaz2QOT13+dtc/oyui pDVN0Q7SlkYxDgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMBHl04wMmy4E/XA6pp0nMH2r /3WThrjC3LNem/0qLpeZNYj17Jx+gJHhKJfKo3jl8ykNqwtYP8xSKT82e9GBt48cLJdWzwvatsm SFwA=
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
index ebb252275ddd..02065664f819 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -680,6 +680,52 @@ properties:
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


