Return-Path: <linux-kernel+bounces-379861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641EC9AE4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C9B1C23F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114E81DD0E6;
	Thu, 24 Oct 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2OCOXA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C41D63CE;
	Thu, 24 Oct 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773290; cv=none; b=GknSqhDweZH+1cKKtWXY6jk3zoq2NYLuljz3nCGfCitgSSNTPBmHknlVrCb8tPGgk/AL2Sh3vt8ru8snXxdw6YyIUbe+JHoqo7pjbp9TPDc7S8PezTQqoGzrcpBSTyL9Ye1FuaEhH3ZCTJqhuAvU07rhFZmow0YLhi8V/a8LJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773290; c=relaxed/simple;
	bh=K3gXF6XbnmUL4vxccwBpDJwpWrMAwTUAMTHCmMZNmhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtzlr8Py0XDk5WAciFIhB3fwT30tiXnvYQidFCvxFCfAs0l30JYxDre9iP8cexgPMHacQkxYvCagnqunU8gsZ1z7tObKeAyYyTu0ZRpe2jb++SyRjF/J/IXnZwt+nosL3mrwKJpvt1KH4DWxcyqFltR0f+UFZiA43sKTkRSgiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2OCOXA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCE2C4CEC7;
	Thu, 24 Oct 2024 12:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773290;
	bh=K3gXF6XbnmUL4vxccwBpDJwpWrMAwTUAMTHCmMZNmhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2OCOXA1DSNsWokyzFT/mLl5SxryxKZX+3uEFZQikGCaaPIBuqawl6DMXGiXvLUAA
	 nuqpD+M4WL6rs5QZnaRH5R45WA2EM5M7L+44oDQ/AtqvIzLPji6QNDVFJqv4yoVQbi
	 G/BZVS3T7GhoCcLBTJLwBlVVHeo+nReL0wEXLfBNloyz2c4Ox9Slr1VPJCEebXan+L
	 dTc/8m54UOThkT5CrsY16Eyj/yeWy66zIwBkD+1qPvwGuCEvFlweX1Ul5N64E6Dq4M
	 srpEbt7N6AyG/yjLAd4VzAz/BkcrYwc+/Z9XKdk7ySHhG1ViO5IVOjfEIuy83lMtVy
	 4a/EtsGZcGeqg==
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
Subject: [PATCH v2 5/5] dt-bindings: riscv: document vector crypto requirements
Date: Thu, 24 Oct 2024 13:34:33 +0100
Message-ID: <20241024-pungent-lasso-42dd3512a3c8@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024-fanning-enrage-bcc39f8ed47d@spud>
References: <20241024-fanning-enrage-bcc39f8ed47d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=VOy2t1F9TKOOPNx3M+MXPHgxN3iDgl3UPDedDE/djSQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlSdtes2OevZCwRtevndV7gEHIv9262WM9tzomNe3Z+K //45+DdjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkzndGhn7rDdXb5CRP8WyW 3XL2n4Tnfl2WpeH5b3qLH0+d83Jl71VGholrOFib/4X9zJPsnjjzvdihro2/X8bKyoXfuv7+8hn bbQwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Section 35.2. Extensions Overview of [1] says:
| The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the composite extensions Zvkn and
| Zvks-- (sic) require a Zve64x base, or application ("V") base Vector Extension.
| All of the other Vector Crypto Extensions can be built on any embedded (Zve*) or application ("V") base
| Vector Extension

Apply these rules in the binding, so that invalid combinations can be
avoided.

Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-698e64a-2024-09-09 [1]
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 20cead7d8af71..38d77043552a3 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -658,6 +658,38 @@ properties:
             - contains:
                 const: zve64f
 
+      - if:
+          contains:
+            anyOf:
+              - const: zvbc
+              - const: zvkn
+              - const: zvknhb
+              - const: zvks
+        then:
+          contains:
+            anyOf:
+              - const: v
+              - const: zve64x
+
+      - if:
+          contains:
+            anyOf:
+              - const: zvbb
+              - const: zvkb
+              - const: zvkg
+              - const: zvkned
+              - const: zvknha
+              - const: zvksed
+              - const: zvksh
+              - const: zvknc
+              - const: zvkng
+              - const: zvkt
+        then:
+          contains:
+            anyOf:
+              - const: v
+              - const: zve32x
+
 allOf:
   # Zcf extension does not exist on rv64
   - if:
-- 
2.45.2


