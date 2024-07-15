Return-Path: <linux-kernel+bounces-252231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED651931056
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678E8B21E35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793618E77E;
	Mon, 15 Jul 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgXHsAQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06241862A1;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032805; cv=none; b=Vx2YRo6z7Z3pjoVLXLfF7tFmLOYfXVX0Xn2j7IuqZYbytnhhzXjX6LvaQTQ1rSPy1VGFX5QDL/lD2EYMcFYjL93ijTh0Eh5RDK7YVc2S5TtAxQbr61buevXu8KhS4QLoSx9UoqL5YqWE3dIADnDIpzOrEQuR6dGOk8F5dEjVcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032805; c=relaxed/simple;
	bh=xnkrIHWz0C+Ukid8QKlf5IsbUMUDj0jNbjFGkqdX5YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUBBMnf67oHw6oeaemVgbEE30FhvcrQIS0AD1D72FDOMA/jP3xogCnsuXgjImQq4KvrL2Ljj63i0fy2+XrSFf7h16q+BTnmrLI9Fzldym+6A3hOAUu1/7YgHJRuFlSP7wxjL41eDCpQqXsJAqrVxb5dp2LjuhpwYnpjq7+SyGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgXHsAQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E1BEC4AF16;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032804;
	bh=xnkrIHWz0C+Ukid8QKlf5IsbUMUDj0jNbjFGkqdX5YE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rgXHsAQdUAcqldQWyqQr18rju4XO2zKGawfWbLZeejzZFrrGwrFmpbkvpV7g28Xcw
	 CP54jJ8j2zsrlf57dtb2We8XzQNBTH9orHIzT+VM6hOqB9kyavqnnhmKQ/bJVutAxp
	 AxVupCozP0ZNx9qczRZ/JwS1jsF/BSpUbVqxlRMMT8l8HhLLqCSRfd/Z5fvHI1gb+w
	 qUbJcqf5voLjwCub3UBhNeLmrhTOXtDht/S3BAhryWip4gdWVzYyMyvPvnc1h4PZEt
	 KtX6gux+7OnDC2f/Pwa+/CJiYdUNAlQdl7fAc/bSVvAH6rj1duTcQSuYMAohc0xoD2
	 r6HgaZ/jL+KOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517FC3DA59;
	Mon, 15 Jul 2024 08:40:04 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:30 +0300
Subject: [PATCH v11 26/38] ASoC: dt-bindings: ep93xx: Document DMA support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-ep93xx-v11-26-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=1224;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=IYgRqPiUpJda2whx2paj9O35GPXheF0lc1rCPFeTg9o=;
 b=sg8u1hWMo9O0MlNoZBTN8U0p95VkegyQUzMza/YXfLuxZJ2bHcLjAeX93obhGl9sFDKXUzCcttwQ
 UCYGU2DNDrO1VJ/W6/bBstBRAipPe7ceLiOMC3F1dyeguHiWIzeq
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Document DMA support in binding document.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cirrus,ep9301-i2s.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
index 453d493c941f..36a320ddf534 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
@@ -40,6 +40,16 @@ properties:
       - const: sclk
       - const: lrclk
 
+  dmas:
+    items:
+      - description: out DMA channel
+      - description: in DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
 required:
   - compatible
   - '#sound-dai-cells'
@@ -61,6 +71,8 @@ examples:
                  <&syscon 30>,
                  <&syscon 31>;
         clock-names = "mclk", "sclk", "lrclk";
+        dmas = <&dma0 0 1>, <&dma0 0 2>;
+        dma-names = "tx", "rx";
     };
 
 ...

-- 
2.43.2



