Return-Path: <linux-kernel+bounces-557780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941CA5DD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C519017A956
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF224E4A4;
	Wed, 12 Mar 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD/EBmb5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9AE24E018;
	Wed, 12 Mar 2025 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785170; cv=none; b=m8liulbe68kbpaO9bc3wdAfxN4Reoi0MPIdn2lGxi3J2uChtTHGJOz8PJomuZhAi9/1TXa8UMkz8Bc9aFCGJJifzmZmUE4PRxS0sg0nVbPAygTKmzink+/QSP/pgwPQNLHIVjmdxEjfAt5p3Ic6Uu4qZYb1HsMk+A3ALpVfPsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785170; c=relaxed/simple;
	bh=rrda/qNO/FX0NEOGEwVQni3WrerJhMgnNGT11F7foGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOhc2+gP2IAMSiIA+QBdL6ysqOYRjsvLu1xzUV78idh2j2MqFA/6eFOmvFJWdeIz49A9k/kSNmOixGtDr8fmwZ+Sty4qJyfSpdxWmCEO3tuJIAUJLXGZarQVBQoL1oUGh8UEPK4L2esBbZ5StZUMXI6p2q5jl/3o1kydEE/NN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD/EBmb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26759C4CEF2;
	Wed, 12 Mar 2025 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785169;
	bh=rrda/qNO/FX0NEOGEwVQni3WrerJhMgnNGT11F7foGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GD/EBmb5gnr6SOA3E/3LWJyjKvxyk+9CFbBTMioEXRzJ+LnPgcOpjc5r4TAt7LrTf
	 xq1SCOi2429Q4lc/NfBUqEVIZQHdNSWZ6KR0xJ8+h+inUXJid1N9dtSK7g+a46XHAP
	 XZmrN3iapfmUAFeqqNyOSZBk2c0LRnIdAJTIFilPOrTEn2tSLfwEsYnE5R+sZnr2y1
	 3KcuqJow295OipQa2MmsYNgDu79Fe8cMCFxv1tNnainDR/eOjJ/4iyNAS16aM0xIN/
	 WU3PTQKorc8/t7sMFOtweAjDCdQkTGB9Bn6imXdfvZaAQJE6uQkW5kI6OxXm3sogGd
	 uSbMPuuOWAzxQ==
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
Subject: [PATCH v4 6/6] dt-bindings: riscv: document vector crypto requirements
Date: Wed, 12 Mar 2025 13:11:49 +0000
Message-ID: <20250312-flask-relay-b36ee622b2c8@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312-abide-pancreas-3576b8c44d2c@spud>
References: <20250312-abide-pancreas-3576b8c44d2c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=29e7Oy/RM1PW3iHddZaBGqbUZzx7/laHEWpEfD6BsPg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOkXO0R0CluX7jLdZ2nS96w8dKJJc66Rv3VzXrK5cvY/+ 5fnkuZ1lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCLv2Rn+ii5/M1ecbb3l5465 553WrLJZweLS8Zt1gg1r7VcmlSjDLIZ/tiedV8p2NKYFpuQv+BbqM1/VQ19q5v+Wnm6/mfd53zr wAAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The Unpriv spec states:
| The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the
| composite extensions Zvkn, Zvknc, Zvkng, and Zvksc-- require a Zve64x
| base, or application ("V") base Vector Extension. All of the other
| Vector Crypto Extensions can be built on any embedded (Zve*) or
| application ("V") base Vector Extension.

Enforce the minimum requirement via schema.

Link: https://github.com/riscv/riscv-isa-manual/blob/main/src/vector-crypto.adoc#extensions-overview
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 02065664f819..9aeb9d4731ca 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -726,6 +726,39 @@ properties:
             - contains:
                 const: zve64f
 
+      - if:
+          contains:
+            anyOf:
+              - const: zvbc
+              - const: zvkn
+              - const: zvknc
+              - const: zvkng
+              - const: zvknhb
+              - const: zvksc
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
+              - const: zvks
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


