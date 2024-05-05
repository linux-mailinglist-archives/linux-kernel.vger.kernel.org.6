Return-Path: <linux-kernel+bounces-168985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F88BC097
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736911F2195D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60B522F0A;
	Sun,  5 May 2024 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="bQUUXQG8"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E801E869
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714916509; cv=none; b=huAPqPVtfy/DkhfbH7zBTGHySjy9fXb8ZJhqgT0SRqbxaRWmyTAMpv0sOVlUUwxSI00hq7wmtCr2H53+dLk5zlz3L2uGSa//ZmTA+sU/IJLlVhZ3K+5cPOWoU+FxxMZNuGqPHMN6RmNR2dJsX4vsJJVq6nV6VWLZfzho+O8bu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714916509; c=relaxed/simple;
	bh=CIgCjTXeZyu3DH0MqyAjHmzeAO/Nace6NJnBAsiQM0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cATeRYVSpz2MvbJSpHB2JUqk3Co3IcPuXNLCbrcXK0ipdOeF7kCr8r1xGDtPhZq0vGoU3qIFSw2ven0Gy366IojBrc+0QEIEjg9x0TwHxH/GROvawWdLF1bUAG7ZGT+Lmc4sigMgBJ1Ux/UytUVo9pyybvY3XozKt3vcmFE4WfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=bQUUXQG8; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714916495; bh=W8GUtXzj3Rp0251QTwW9fbnt8zTzF5kn1FBpfBkBZXA=;
 b=bQUUXQG8BJMidveyOUWZaBStb1q0pTzIDkIWN5pibpOBp2DJiRIG0HvHSnKyIp/4WF9PolzYp
 anuxkBg4CHuKRvzoZBPi3lNMle2ZCn+1HiBvWVpXx4FqCoX3As1Ze63YtP9PpoXjWXOmtmY2qUN
 2UVwqfGSvN3fvgRazpw9/luwgaLeM91fyi7B6pICUN/wiXkDwJRcjmg4UraKI1hdIesM7j+rsP9
 Yl1M9X8UB/8ezDqcwsFbksnxxZ3JdLkToPKamsXhQmYH0GiaamEXB13F+bXKYXy4Se66FXOlIGC
 bBdNuWFxijG1U/mtrxgQiNcGF7M57zlcdpyl31tFEbaQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Chris Zhong
 <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] dt-bindings: mfd: rk809: Add audio codec properties
Date: Sun,  5 May 2024 13:41:12 +0000
Message-ID: <20240505134120.2828885-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240505134120.2828885-1-jonas@kwiboo.se>
References: <20240505134120.2828885-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66378c8e57f92010457d6890

Similar to RK817 the RK809 also integrates a complete audio system.

Add audio codec properties to binding to reflect this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../bindings/mfd/rockchip,rk809.yaml          | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index c951056b8b4d..b78e1b090105 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 description: |
   Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
-  that includes regulators, an RTC, and power button.
+  that includes regulators, an RTC, a power button and an audio codec.
 
 properties:
   compatible:
@@ -93,6 +93,34 @@ properties:
         unevaluatedProperties: false
     unevaluatedProperties: false
 
+  clocks:
+    description:
+      The input clock for the audio codec.
+
+  clock-names:
+    description:
+      The clock name for the codec clock.
+    items:
+      - const: mclk
+
+  '#sound-dai-cells':
+    description:
+      Needed for the interpretation of sound dais.
+    const: 0
+
+  codec:
+    description: |
+      The child node for the codec to hold additional properties. If no
+      additional properties are required for the codec, this node can be
+      omitted.
+    type: object
+    additionalProperties: false
+    properties:
+      rockchip,mic-in-differential:
+        type: boolean
+        description:
+          Describes if the microphone uses differential mode.
+
 allOf:
   - if:
       properties:
@@ -284,5 +312,9 @@ examples:
                     };
                 };
             };
+
+            rk809_codec: codec {
+                rockchip,mic-in-differential;
+            };
         };
     };
-- 
2.43.2


