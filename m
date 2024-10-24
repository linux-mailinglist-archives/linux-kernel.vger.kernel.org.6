Return-Path: <linux-kernel+bounces-379859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA2D9AE4EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A89B2356B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A4A1D5AB8;
	Thu, 24 Oct 2024 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5jjhn74"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB11D9A79;
	Thu, 24 Oct 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773285; cv=none; b=hn6WnvU/7qrGvPf9dksoQt8xJadHz6NV6m3neqSgOWhYCAUm7yaz+/SW4B9+AFQ6Z3mSoCJSrgoUJUkrYenCVOOND3TqdF8KLnhyB5Rkz+qxoVBLxq5Cff+HomQ5hpEbdfIE3JzX//EvwVKDa3s9r3t0hAZIexyGt2rmnWsCnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773285; c=relaxed/simple;
	bh=ptol331dzJMPhFm6aP6N4KOrUBpmiXlYM+nw8AjqcLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTeSl3RRTg6fmsx2sdFR9yVB10R+Zp7OuIMRpQp24z0rKuwCtJtPjm9PaFTBoV+c5Qt6Bqc0QwLsY81bVUruCfrCL4KpNGdb8vYj2BvERvfmCvuW0jjPYreI027WSl3m3EofXrbapxMeHDTPRnqbqyaXiV1dRqOjj3og/h9Hdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5jjhn74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A1AC4CEE8;
	Thu, 24 Oct 2024 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773284;
	bh=ptol331dzJMPhFm6aP6N4KOrUBpmiXlYM+nw8AjqcLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5jjhn74Pf0GY9BVrZdiAYRJo9/cLV8M09yXG0ZpNcUdHsJmpA+1YDL469lWm3NDy
	 /JhTza2W9T1+wR+bl/U9uQby7399mQq4kSjBVCDCnPfvtU5OafXj3pXJNZ44RhZebM
	 YCCU9LRCPO+qPPMMR3Vkx4QcJHoOdwgP/6v6GnQ39yXI2RYpbYr7f0SqCF+yWUYfTA
	 jeW9kk+T/49Sr2jbJyBSsILXpBqb13XZk9zxbGfFTgipdPUNEIC+Sw3SO55Zwhh1fJ
	 qGRFHT0QjPudq1IlURf+BJ+NEORpKgfaMj9OHmjZVFsyxicb7wkJCRSsM09atqbtLO
	 9JmgsGGelioNA==
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
Subject: [PATCH v2 3/5] dt-bindings: riscv: d requires f
Date: Thu, 24 Oct 2024 13:34:31 +0100
Message-ID: <20241024-petted-oasis-426993b07f75@spud>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=OXDrUW3asuNmjBXo7oSLxm76Z3KlXKOnfCj4qooySls=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlSdteubDlzaP9d1Ym6e+88iv5n+7hYuUKr//B+jy/1F xpelUef7ihlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBElrIxMmyYVxJZeyFk08JD EZ2ity3PBE84dXH75Zl/8mRmHLd/+/UFI8Pxvo0O8ZFWn1q6tfaVutvNk4jXO8sxv3jR04sx/xm EtPgB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Per the specifications, the d extension for double-precision floating
point operations depends on the f extension for single-precision floating
point. Add that requirement to the bindings. This differs from the
Linux implementation, where single-precious only is not supported.

Reviewed-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 2cf2026cff574..c697be64d3bfc 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -571,6 +571,12 @@ properties:
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
     allOf:
+      - if:
+          contains:
+            const: d
+        then:
+          contains:
+            const: f
       # Zcb depends on Zca
       - if:
           contains:
-- 
2.45.2


