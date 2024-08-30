Return-Path: <linux-kernel+bounces-308072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E369656E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C022859BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11821150989;
	Fri, 30 Aug 2024 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEbGyFmd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3D14A0B6;
	Fri, 30 Aug 2024 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724995571; cv=none; b=lJU6yCDH7F8e7gkl0v7lVIOW/6Y8qirA+3WsC9IJfnxAF0UwOcJ7yRtnlSlqHIpFsC9EBHkflkwTWky7WFppwtLpkB39qef5UsMqJZYeY/wMFq7trQNZN0ZlbOPg5K2kt01ldITv9eYU9a7AZWUOQZD0FYgnHL5iQtE5fVnaUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724995571; c=relaxed/simple;
	bh=6QAYYF6aaar5pzIHYRxtO4F/Jfa/IlFus/mckSJRuB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEgcEnXYq7rFEGYp50jbbrDUnTrqtss7cONN7YT17b/gQuLl+nmO/C8YCuDCMzJQxrwbpO7tPBop5qEqF9a4vDa2aGnOXv6p8FRIxlc0YPM8i84521MW1Py6XxdK2x+1/JJvJf0h8TQ5YZwK1p1LGHDfZakYekqPecRBxSLDOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEbGyFmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3521C4CEC6;
	Fri, 30 Aug 2024 05:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724995570;
	bh=6QAYYF6aaar5pzIHYRxtO4F/Jfa/IlFus/mckSJRuB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GEbGyFmdkrqhYiMXPMDDMskWpYLYIECMj+qBU31MQP03ka3mCekicJp0Kfyck+pXn
	 j98Wt/xXjM4TNrpF0nOvl4kE4HLthmdbx9mmO959LQhfH7lo9TbjZCc54zoQrXi6JR
	 i6TiEM0WSVMFjcSQCuKKpNH2PJ+WvOmrjBuQMOt/RK7OP3nqb7DeIWmwDIwjO23/t1
	 zau18mxjZp7SiHQSU0KBego2c5ytOhevsedZDKhY2U5lhBjxSuWYy6WJEGaXcUbkhF
	 nSloA5R2w9O5Qz8BMBnaItPNOmUl6njrgcfg+FNUeb0UjyaRf1/j0QLiQ12QUubttB
	 zEnu6i27iMTJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9537CA0EE0;
	Fri, 30 Aug 2024 05:26:10 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 30 Aug 2024 13:26:08 +0800
Subject: [PATCH v4 1/3] dt-bindings: clock: fix C3 PLL input parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-c3_add_node-v4-1-b56c0511e9dc@amlogic.com>
References: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
In-Reply-To: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724995568; l=2021;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=WQR1UBxGONQHyor5r4Vdf/Olja7ABIla1YIY56QfC4k=;
 b=8px0text+zQI58RVTiqzPiJZVkV8OcmuahfJ7ecX1bkgQS/cJUvDitRkKfKS4vHbikCn7tThL
 6CQ/UrHGzwlAEtGJwoNrcHK01Gix2f6ublNvP3K7YzYZEW0SOrD+5NQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add C3 PLL controller input clock parameters "fix".

The clock named "fix" was initially implemented in PLL clock controller
driver. However, some registers required secure zone access, so we moved
it to the secure zone (BL31) and accessed it through SCMI. Since the PLL
clock driver needs to use this clock, the "fix" clock is used as an input
source. We updated the driver but forgot to modify the binding accordingly,
so we are adding it here.

It is an ABI break but on a new and immature platform. Noboby could really
use that platform at this stage, so nothing is going to break on anyone
really.

Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock controller")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
index 43de3c6fc1cf..700865cc9792 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
@@ -24,11 +24,13 @@ properties:
     items:
       - description: input top pll
       - description: input mclk pll
+      - description: input fix pll
 
   clock-names:
     items:
       - const: top
       - const: mclk
+      - const: fix
 
   "#clock-cells":
     const: 1
@@ -52,8 +54,9 @@ examples:
             compatible = "amlogic,c3-pll-clkc";
             reg = <0x0 0x8000 0x0 0x1a4>;
             clocks = <&scmi_clk 2>,
-                     <&scmi_clk 5>;
-            clock-names = "top", "mclk";
+                     <&scmi_clk 5>,
+                     <&scmi_clk 12>;
+            clock-names = "top", "mclk", "fix";
             #clock-cells = <1>;
         };
     };

-- 
2.37.1



