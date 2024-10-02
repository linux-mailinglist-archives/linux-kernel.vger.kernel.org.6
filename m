Return-Path: <linux-kernel+bounces-347926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8798E04F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430612814E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935801D172E;
	Wed,  2 Oct 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD8kvVnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCE1D1515;
	Wed,  2 Oct 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885539; cv=none; b=Rg3zpCLGIPewwAFtzDrfBYVkKRFcP18dqV8IOnFe63USHI8lsmVJlPfRwMuRknZgP1ohLJ0kiEd/T+boCfLINdUXXFunw0DcWnhctUkxIvCTqRUubaFsqTOGkHVCgMiCzy8GhSmaCkmgDkPF/a/VdLKCe0VMdLoCwQmVLBtfdfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885539; c=relaxed/simple;
	bh=UOs9fQ0Qb/dPq24ntgo5+/lHqCBltfzgg+ulESJu13k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYCP2P9KKQ4n5Am3wIBizdk3tK9z1mpJI5VGrhvsSyInuXnEzEsvEb212qn0mrZFxfY9vsQv1dZ4oy1A3q9gXljyo3/B+4I5X0X6u8KhjaLqWSht5xCnyr19mq6ydRRRKaW/jP2UgcxTs8qeelLiNqWqERHkqanGR0lfri3dS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD8kvVnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3042FC4CECD;
	Wed,  2 Oct 2024 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727885538;
	bh=UOs9fQ0Qb/dPq24ntgo5+/lHqCBltfzgg+ulESJu13k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SD8kvVnOSrKOvT28i1yXRDH8GlU0eANdP6Xef3VAzTlWfKRWouCVkzxZxV5xBs7xc
	 607vzEqP/iQBDEt8FftIeDWh3OtyyCaz9/Uh79IfOYB/3dt19TGsL8LtjrxdrPVlul
	 iMYVGxg81pTvITejQsP93VmEAxwfUjhn0sNhSHgE38bAllXRcQgZzASxHmFYbE610f
	 tdM+2C3RO040LAqjTtM+6OoCF82lrFRk6IJxnWTUVveHiGb5/TlUWQQoPb3jucKdn/
	 4mxAHcr6uqy0kdO2+svFn+QfMliNTgqBgRAws1DqOk2RfLbSovwvb95TaZX6943R3Z
	 XJMSfUvtwcOaw==
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
Subject: [RFC v1 5/5] dt-bindings: riscv: document vector crypto requirements
Date: Wed,  2 Oct 2024 17:10:58 +0100
Message-ID: <20241002-sincerity-urgent-acdb0e8d8a66@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-defeat-pavestone-73d712895f0b@spud>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=0csTQ3dN/Nqy674iSwkezo4Jzd5QbE3DDkc2MwbnXzc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/CybsehZ2KKB10qJJ7dWVbjMfLZnbNYHLxnGp+45jl 3PubTmR1lHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJCMcx/BVdpP3DzO/yA5ce LU/e32c2sz/TNOiz+7Qyf9LXo7+UJ21k+O+3UUv0FuMK36YJm82+5zgpB31xd1t2zuGfqXrYkle O0dwA
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
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index abf2579171c5b..02b822bbf341d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -651,6 +651,38 @@ properties:
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


