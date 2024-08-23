Return-Path: <linux-kernel+bounces-298162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687D295C347
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203A4284C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AF0381DF;
	Fri, 23 Aug 2024 02:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuyefCcx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A406224E8;
	Fri, 23 Aug 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380160; cv=none; b=T270EOcixXx+2oSSkAQ7PjTR+OT46XTS6UXREAnpVMjjTLEeK2kkSsKVPHezPtDKF7ZFQ1MdUx2X9RiSHI8ooYPLH5RkDhZApT1EEuMWVYNUValvjssVLHnJWYcEQFnfVix2MNcZQPP/lIJV4bcl38W1ywgXlg2SqXKeCr9l6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380160; c=relaxed/simple;
	bh=j0bfX7RwioxZel71Y7a7ItvYplwaW9cdPPAEsz+h/o4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNgX2OSZWS1cUQlu7jIIg5DqkpleYF46+crvG5HPcSJnaaz7PQOqtsZHtdrg6LVGXNJBAiWgvBWI03tyAuYM0Ah1za0AFnORMocHRoQt9K08ioVQrwijevnHKJAgCjnGaIxZiRu724zlzgntNA0zPARRfCl5PZ9l7zK+XBM0Mgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuyefCcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FE1CC32782;
	Fri, 23 Aug 2024 02:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724380160;
	bh=j0bfX7RwioxZel71Y7a7ItvYplwaW9cdPPAEsz+h/o4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HuyefCcxv8nRuagOUejt7Jb/i+NuVRF06X+W1VV0nG1fCE/krTmPqYxqNv5MPt9jc
	 r9yir9VOerBW6qGaLgkMZaMNJqt6zQe2Ssjf0Ea/DHSsGPzRplSBVfvoAXwWq1PIoV
	 0lQmE5xWP6O9TyJhyRfbr47H7OMEFUsvnwyt2ihAQErH1w7Wf3i9QMfVbigKvGzzve
	 +Xj7AELqgLtU8IAGqDkwqXyRQKUgxj8F1VgLKEhB+4v4gBLXlXVCgmdLNGslViRFyy
	 I8EOMv9IAiJfktCyTg+VderPOjN/j7ksSNFJ3x0103oE6//miuhBEurW4EoviyAd55
	 d1Jz+FAgVfUpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A0DC5320E;
	Fri, 23 Aug 2024 02:29:19 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 23 Aug 2024 10:29:17 +0800
Subject: [PATCH v3 1/3] dt-bindings: clock: fix C3 PLL input parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-c3_add_node-v3-1-3648376037f4@amlogic.com>
References: <20240823-c3_add_node-v3-0-3648376037f4@amlogic.com>
In-Reply-To: <20240823-c3_add_node-v3-0-3648376037f4@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724380157; l=2021;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=EZulQ5wpUmaV7Lvp/UM+s8rjmGBRsUnekPSl5hxqIH4=;
 b=FOnaCsVmFwP8l5psqP1H2cZPbDXq0jdUvEUdjL9j5DJUURUcRcy8Y2qd2a3skK7/OJNh6+MoY
 lLPcgN1Pwu3Bi6FkCe54El0cDTX5XloX/aY/FZLe2wChfrtFW/DlY3R
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



