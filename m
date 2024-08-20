Return-Path: <linux-kernel+bounces-293675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F13895830B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3532B1F217A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E718DF9E;
	Tue, 20 Aug 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvsc9HOu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D318A6CE;
	Tue, 20 Aug 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146918; cv=none; b=abI8lFSalvl/fcoFIxRP+29vc7j0R15sXB4XmKMG0qWjO4NkDL8myseiBT2ecbhweGjktG7WSiu1GXZgWZawln/DwCrwmkbGcOSenNZNJbeRPO0aMPDOze2p6p8ci4HrgkNgo5bxv2qs1TDWy1UP6oHfBTd6vOTI2cDxUwWdo0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146918; c=relaxed/simple;
	bh=4NWRl9yzCT32YrtzW/XVPpe8n5zmQJV6pKArhZCXMLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=umnxPfBt3jm6ecaP9Hg+rPdmwcxInMaT0HfHI+sIWc4o+uBDxDcv9FFlFqpFYCSx9V81C/CxwF8vkT1yQKuJLTdt3OILnEwxlJFxYt0mJ5310SMBq7jfurXUWLxSWZfxQPShCdm4UjdCqFIM6YoJ0FwwDGXdj9iymy4tWrc8KPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvsc9HOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39925C4AF0F;
	Tue, 20 Aug 2024 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724146918;
	bh=4NWRl9yzCT32YrtzW/XVPpe8n5zmQJV6pKArhZCXMLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nvsc9HOuSgbkNbCUOr+u3+ZIOkCxkyysjHqVKb3O6KDlFtZWeABBrjS7bnGbCfxlN
	 zRg3VBEIWY5mO0zFqCp3op4KMRt/yagT3oLhV1yYC8f7oAERdyi6WcTajGuPvl3Ctm
	 zawW4hrVQHdEXGk0EWXewklvlGcpi5WcjVa0M8SNfsXohw5n4+ZoTEXt4hdWTZ/CAc
	 RDikDwI1lrtfFintmsOGNETn6wzMcBE/U9mZ3RKr9Tl9V59bwR82JuuBs5JpJR4LVs
	 QUeHtBtb43q8kjLXelVV1JooRcbQKKR7Wo+lgYdGFcpVMXja8rvn7Pg4DC6O7ZRY8Q
	 0rzJcqu0eUgwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB9C5320E;
	Tue, 20 Aug 2024 09:41:58 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 20 Aug 2024 17:41:56 +0800
Subject: [PATCH v2 1/3] dt-bindings: clock: fix C3 PLL input parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-c3_add_node-v2-1-8fd3f06b7bce@amlogic.com>
References: <20240820-c3_add_node-v2-0-8fd3f06b7bce@amlogic.com>
In-Reply-To: <20240820-c3_add_node-v2-0-8fd3f06b7bce@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724146916; l=1954;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=tWCo8zkaON84A1jHHQrG7jHh+aa9S/NWJLB5MLMSFlc=;
 b=Yr1Xj3sKxwOql+uzY7pywqnt+m1oI8iI2hyFY1lkP5acgDWkoX4ox68BE5nEXQkIgx6DmvkUW
 0DLj1dPMSrXD/G+H5pEiq5UE8EvgAViajuEAGehmeC0cUskEdwEXqay
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add C3 PLL controller input clock parameters "fix".

The clock named "fix" was initially implemented in PLL clock controller driver.
However, some registers required secure zone access, so we moved it to
the secure zone (BL31) and accessed it through SCMI. Since the PLL clock
driver needs to use this clock, the "fix" clock is used as an input source.
We updated the driver but forgot to modify the binding accordingly,
so we are adding it here.

It is an ABI break but on a new and immature platform.
Noboby could really use that platform at this stage, so nothing is going
to break on anyone really.

Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock controller")
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



