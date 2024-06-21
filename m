Return-Path: <linux-kernel+bounces-225374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C2912FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C303B2819BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF84F17C7B5;
	Fri, 21 Jun 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sUZlvApw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC004155310;
	Fri, 21 Jun 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007104; cv=none; b=ZUgaIIAwofSTmQYZKvfldPJguALvB3lz1rDiA3Bt1R2R+FQsMKrS85+2bvBjEVEXN+rgdJGGkLd5swWxnhgSCvElP5Sy8xBP8x6yRYXV0OJEBU9JstUpQRE1neRnZRCxHn4vfPy1qYYcS0sZyUjZ+N9fHXZc/mSBCuO7ho4lXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007104; c=relaxed/simple;
	bh=1WIyV8ksTIHhhQ2eCcN+ywnSOJBkt4yK0goDj6avryI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCcX7tfDaQ+OGLCsAcH9VDZBr/R+LnLom6mDyjZUU9YM8sPINIltlL9I+7jyXrf3RmwdxDidm/91vKXCMhAneoFrsAWnNj27xDkmgY5UUQRMiMVKp8rWEuDNS6k25dJ+tNHYhpbA+IMjESdWIRd7ha3ke5eC1h3Kj45DL+cAv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sUZlvApw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719007094;
	bh=1WIyV8ksTIHhhQ2eCcN+ywnSOJBkt4yK0goDj6avryI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sUZlvApwjrOTmFwpqqRI/Zn5eOFa1BRtMxAhxobit3m/gzQNS1ZWExKZlpSDakZUZ
	 qXhf6Rx5N76nLYpy4AIovrVTlixsnVPurfi4LZMKdSeh/j0k2/PAgfFKsH94vibwJQ
	 +TNRxCF89B62aZFDcnCC5SHzAz/LfnR/zitlSVfqN52nE2n0p5WtYTNbqUZ0jXl10l
	 U6/Eu5XRvBU3Q08UMFBeiA462bd1cL+DhrcjcfyhT71LakkWJWMSUVYdvH8V1s3nlT
	 cfSPZdsqhe9R09R0dBZwLrNDDwkYoAhr6gU96H3XOVPfNuPDq7X8OMAnnp0sQFy6F1
	 rECHgOS1+3s/g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 88AF937821DC;
	Fri, 21 Jun 2024 21:58:14 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 22 Jun 2024 00:57:18 +0300
Subject: [PATCH v2 1/5] dt-bindings: mfd: rk817: Fixup clocks and reference
 dai-common
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-rk809-fixes-v2-1-c0db420d3639@collabora.com>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
In-Reply-To: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

Ensure 'clocks' property does not allow more than one item and add the
missing reference to dai-common schema.

While at it, move 'clocks*' and '#sound-dai-cells' properties to keep
the list ordered alphabetically.

Additionally, drop all useless/redundant descriptions.

Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    | 33 ++++++++--------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index 8c2fd0fabb92..d70b4307ac77 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -32,6 +32,13 @@ properties:
     minimum: 0
     maximum: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mclk
+
   clock-output-names:
     description:
       From common clock binding to override the default output clock name.
@@ -42,6 +49,9 @@ properties:
     description:
       Telling whether or not this PMIC is controlling the system power.
 
+  '#sound-dai-cells':
+    const: 0
+
   system-power-controller: true
 
   wakeup-source:
@@ -94,26 +104,7 @@ properties:
         $ref: /schemas/regulator/regulator.yaml#
     unevaluatedProperties: false
 
-  clocks:
-    description:
-      The input clock for the audio codec.
-
-  clock-names:
-    description:
-      The clock name for the codec clock.
-    items:
-      - const: mclk
-
-  '#sound-dai-cells':
-    description:
-      Needed for the interpretation of sound dais.
-    const: 0
-
   codec:
-    description: |
-      The child node for the codec to hold additional properties. If no
-      additional properties are required for the codec, this node can be
-      omitted.
     type: object
     additionalProperties: false
     properties:
@@ -123,9 +114,6 @@ properties:
           Describes if the microphone uses differential mode.
 
   charger:
-    description: |
-      The child node for the charger to hold additional properties. If a
-      battery is not in use, this node can be omitted.
     type: object
     $ref: /schemas/power/supply/power-supply.yaml
 
@@ -168,6 +156,7 @@ properties:
     additionalProperties: false
 
 allOf:
+  - $ref: /schemas/sound/dai-common.yaml#
   - if:
       properties:
         '#clock-cells':

-- 
2.45.2


