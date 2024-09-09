Return-Path: <linux-kernel+bounces-320878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E099711A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE151F2313D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A261B81A8;
	Mon,  9 Sep 2024 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmzOXc3r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004461B29B8;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869537; cv=none; b=QLxHzSM5uF15oTlnq3TRSBGOr4BWYTp9A1rlRSkF+Rvs293bSIVeyOqUXdTmpMt8AF4ALWVigLBc4hHqpJG9Lh7mbxiEUY/aKQd+211Gh9mTpij8OU2pGA6rQoO876MT4sm3yPEXMJegqTFdrNRuCTNGFWuSqHEAjgwTQTW7F28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869537; c=relaxed/simple;
	bh=xnkrIHWz0C+Ukid8QKlf5IsbUMUDj0jNbjFGkqdX5YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwOPipdm7Q0Ze2e1hsPT8C+rLRpoATciEnL+tX3zdqYMNkYomj81fDGmUxkcgtD4fTEDYM8wiSDDn+ryjZFvd2V2rwQbczZBNHNIwb6RVuu7/MZ5tXx9VmWkOxFs8gdNgGdqvcdiUlYAipBNqsMtcmqrCtvNWeAkGWyMQSNRuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmzOXc3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE7E9C4DE0B;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725869536;
	bh=xnkrIHWz0C+Ukid8QKlf5IsbUMUDj0jNbjFGkqdX5YE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NmzOXc3rNOBmPQ28EIOsd9LCK3m7eI+hxvr9odr+JHcUd7p/4ujs3n544ze2C2xc6
	 CJcv2NSM1SnNaTH3nSc8sD7KOT2/XV9oiwyDCyKusjwwRkb7F6HS2t09jLxHqQVVmQ
	 jNxZZL+Z7Dx2DH05QXaRvJbM1UtQ2coLa5f8EIv2J52IE54saCoK++SqLhaVawnG9p
	 jjXcMqRtbdFBnMBNxTsnI1hd5ju87WrI1fPDY7TUN18H5W/nITlx7V82+zmL4iYvDY
	 dW3e2vJmg55UCypCKGllJKg6tZm96/WUlAm1BQsFQ3tEUiv8eQv6Ig91N1ZrRGUgtR
	 VeUyf0a9uWxqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7708ECE57B;
	Mon,  9 Sep 2024 08:12:16 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 09 Sep 2024 11:10:51 +0300
Subject: [PATCH v12 26/38] ASoC: dt-bindings: ep93xx: Document DMA support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-ep93xx-v12-26-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
In-Reply-To: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
To: Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725869532; l=1224;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=IYgRqPiUpJda2whx2paj9O35GPXheF0lc1rCPFeTg9o=;
 b=hiOE3FKypH7rjUviLJZys8O3EV8AT1xBVVJkdnIkIKXMnzS/gemZ5cS3wS05uVJAkhfPSW8TvOlk
 aDXgYEQ5B529koRy1gR8p1/U+cgptIk8auXz+xgaqXwhL9ehjllZ
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



