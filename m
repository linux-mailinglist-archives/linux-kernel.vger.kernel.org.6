Return-Path: <linux-kernel+bounces-275978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB3948CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48C6B2226F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BAF1BF325;
	Tue,  6 Aug 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ5Lf2rh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D041BE23A;
	Tue,  6 Aug 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722940037; cv=none; b=D3kGitJjAvS6w+bscf3dJg8VePbFSBz9nTFa0mLmG3+ewBelGzCdu7LfR4JQuEFMnX8fjizQo2JcFeC+qP1pdNaqBsb64PZatwX43jt/hbZr4gTG9AP4rNV/Basi/Oujit8OjBewiKhyC/6nFoZFyUfzZqFyJtdUcbfynPQ1iUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722940037; c=relaxed/simple;
	bh=zqTybWWUQeRq3GacCvo2lFGX/liI3cNROhF61Gx3J7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDTnn1vjDE9VLeBogZex5TIHPikAqI0N3vPbGZX1XLlHW8Esqnp8RhI8fVuzYrJarWhCSceS5kld50X17P6ufeMB1q6n8YL1XmbSdW84qZg0/jQRBt8dEwVnM/lVt45mqrbiEk6KifSDar3benrn0tfhofEhHB5ouMLu4/VlJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ5Lf2rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A54C9C4AF0F;
	Tue,  6 Aug 2024 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722940036;
	bh=zqTybWWUQeRq3GacCvo2lFGX/liI3cNROhF61Gx3J7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iQ5Lf2rhH5LCe8sYEBHr99sBX/VDP1a56pYSF/mQVXbysnzJRCX9lM5yFvmh0u4qC
	 7ITXX8nZB2n7yKDNnPOvsk3OddGORKBUYLtIc6U/iRzzqGlKGlJE+aPLMer4liCuVw
	 tMKTlmUHwdELk/+rN8DdBqVuHK0z3nyOTEmwO+MlMcxAevj3IlWDP0P6CxBXz+Qb5W
	 DoVjLeLts4El5aq8Nv7ZCC2PsWF3CabJgJL//6uW0U/1qHWYftS+Olt52hRwNkKb6T
	 R+mikFiujd34Q7j9zqrM4gBofY6t/Z9L8Omvl/zJqBeqvz1qfq8lpgkJLNnlqi6z9H
	 2WJXe/Lz965Tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D225C52D70;
	Tue,  6 Aug 2024 10:27:16 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 06 Aug 2024 18:27:14 +0800
Subject: [PATCH 1/3] dt-bindings: clock: fix C3 PLL input parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-c3_add_node-v1-1-c0de41341632@amlogic.com>
References: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
In-Reply-To: <20240806-c3_add_node-v1-0-c0de41341632@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722940034; l=1392;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=nOBPKUlDvxHHPW4LjnDlQ83HxUGqGNULEJwk23wSGII=;
 b=wJEXJtfDkx4Zaq3zaoUj1mqfl8KL/DhH/a/4rT0nQrjuMtW2rVxyxv9aaJ0z/7nyYP+dHL3a9
 vPYcwvGuVOkCHu4YcDg6BH4lOKe5kESpLj5mf/4Ctv+ytQFa5LnNnER
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add C3 PLL controller input clock parameters "fix".

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



