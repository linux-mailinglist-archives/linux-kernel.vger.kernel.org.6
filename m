Return-Path: <linux-kernel+bounces-555417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F5FA5B71E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605FF1722F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9661E1EB180;
	Tue, 11 Mar 2025 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1bmCMR0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87231E7C38;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662510; cv=none; b=Ft6MclUhZy5BB1r/2gQiMwehe0f4i2jfA8fkKwqJNDv0vfXNmoKZeucQoYe+GLe5w5j+0Muya/BGuZmVILuSYpHLZYI38O9rgGCFk6KTujgawCP9t/ka4558Qv2eUiQjKEiTXA8lOdis0E17MJvjC85gkb3zPOWEUJCrkpyAa4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662510; c=relaxed/simple;
	bh=par3qu1dv9Zw4UCxcBo6S18Zh0aWFYrWJBkvOV23iK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDjrPO7Nv1z7P1gzZFDzmD3DfISOIr90zGq98PCXS4acZSOGS1muKR9DT72CZq6NrYw2gJ9su1RXeUE/jQUqYlDiFDB833qzqe60B+VPkoPG3qvsYZ0dlZ+OidCkTO84nINP7e57ERwzirTOnRIKUNel7QZjVw9zlp8g7gniisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1bmCMR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6792DC4CEE5;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741662510;
	bh=par3qu1dv9Zw4UCxcBo6S18Zh0aWFYrWJBkvOV23iK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D1bmCMR0PuRu4iD7DrvFHHXSFeXT0UxAt+gcZnx32KkXiRXnaDRu0g6BkzMxqzNbZ
	 o4/MXxDYVLXsqMJ+UrBncr9Ihj/BI0d4Gd7AOY+eFyVDFiQGNPZhu/IjwiWJwL0fga
	 ylaU8KghWXyuPyXlZid2OLey+O4Ny/xGe7R7Mywms51UHu1N/LxDNglXC13JdnuiFP
	 1neTD2CALL1IFa85FxCUipb1KNv5gnILjgRz/utl7P8rPlhFQS+7hvlfHLqfckCq1g
	 xkeKlWgrY+yQ7sObdaoEvU5zm3lq6XycAoHI+uTYqtn2zJ/bOdRcRtHAZivGOuko9l
	 nBnUs8jwpKMeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54224C2BA1B;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 11 Mar 2025 11:08:27 +0800
Subject: [PATCH v5 1/4] dt-bindings: interrupt-controller: Add support for
 Amlogic A4 and A5 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-irqchip-gpio-a4-a5-v5-1-ca4cc276c18c@amlogic.com>
References: <20250311-irqchip-gpio-a4-a5-v5-0-ca4cc276c18c@amlogic.com>
In-Reply-To: <20250311-irqchip-gpio-a4-a5-v5-0-ca4cc276c18c@amlogic.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741662508; l=1799;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=fjbxGdq7kon/f2bPEXT1/XjxHPpGuBnxVJQe/5OSgX0=;
 b=A8Z0IMKvUx4BuCPhe2tK+AUJQUh2m+5mdPfe5RM8p3xReYGa0bspT9eplSjqXhH/nFWlxwuJr
 VdHnUZcfSOHDBTHQGGwJ6gtf3VsBQM42Eqr50eQGmy9tqAx/NiEdYf3
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Update dt-binding document for GPIO interrupt controller
of Amlogic A4 and A5 SoCs

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../interrupt-controller/amlogic,meson-gpio-intc.yaml | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index a93744763787..3d60d9e9e208 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
@@ -35,6 +35,9 @@ properties:
               - amlogic,meson-sm1-gpio-intc
               - amlogic,meson-a1-gpio-intc
               - amlogic,meson-s4-gpio-intc
+              - amlogic,a4-gpio-intc
+              - amlogic,a4-gpio-ao-intc
+              - amlogic,a5-gpio-intc
               - amlogic,c3-gpio-intc
               - amlogic,t7-gpio-intc
           - const: amlogic,meson-gpio-intc
@@ -49,7 +52,7 @@ properties:
 
   amlogic,channel-interrupts:
     description: Array with the upstream hwirq numbers
-    minItems: 8
+    minItems: 2
     maxItems: 12
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
@@ -60,6 +63,20 @@ required:
   - "#interrupt-cells"
   - amlogic,channel-interrupts
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: amlogic,a4-gpio-ao-intc
+then:
+  properties:
+    amlogic,channel-interrupts:
+      maxItems: 2
+else:
+  properties:
+    amlogic,channel-interrupts:
+      minItems: 8
+
 additionalProperties: false
 
 examples:

-- 
2.37.1



