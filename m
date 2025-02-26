Return-Path: <linux-kernel+bounces-533032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD675A45505
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20993A7A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6869E267AF2;
	Wed, 26 Feb 2025 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl/h3NGz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90DC192B9D;
	Wed, 26 Feb 2025 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548893; cv=none; b=thWvK0zA7B6zTRfoRT9X6XSMpP2Qo+STlfJUSgSUYAWO06DgpDop/AGVuADIygzTUQN3+5tjMpeDOYzbawYd/D/PEwpMe4nwfNvPPmS/uOH0iChaj9mIEFQOWyqMpFqCEqDEhBQ+oCCFRVxG93VOfm2ae/0N3podYxeECSUcJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548893; c=relaxed/simple;
	bh=YTxbX1SMFkLdHdgjkg6WxDuNfCvkz1KnuWwEm3xpV2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lIIAQFInltR4SgLm9qN3dNx2+SUiKnsRNSkOygik464KFammhkBB5IZz4A1yhh/D9OvOcPdOcddSjV+sofqsaRsUaMaU6lgS2XLPRUcRYWOCjJ4hWbbFIglpX7h+PXLDaGiWFTUrH08Ndqn6dL/k51+LUkF5HuCif+L1LSw5pVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl/h3NGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 522B3C4CEE2;
	Wed, 26 Feb 2025 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740548893;
	bh=YTxbX1SMFkLdHdgjkg6WxDuNfCvkz1KnuWwEm3xpV2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nl/h3NGzrKmEpmw9o6+dWiz1wIIakggxjRRYaWBQnnTIMrE8pSw1fkQZUMhFj/vI8
	 gc5bghXqaCOZA+WwYWDAm194rwEQ/YYrLgwOQjiYDtpXVDmnPSobvO63hHDj+AHlFT
	 XcS46/FN7aoGkdDqV/b++B3VcGJv+k+HcHmRI8/ND9W0reUyv0a1O1N9Gl6RucispA
	 epw/6yXyDCtq13PL/zF4fUahQ5gLjLlS49LLdJsFR7xcx4fDdwIt5K+NYCeIF6PsGh
	 IjXg4zn3XfYkYpbtPxuE0Km7qnYEaiJncr8xynWx3wTNjjjVP+voDk+iWOS+VoTKTM
	 LZbYFpDr7G3ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B087C021BC;
	Wed, 26 Feb 2025 05:48:13 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 26 Feb 2025 13:47:52 +0800
Subject: [PATCH v2 1/4] dt-bindings: interrupt-controller: Add support for
 Amlogic A4 and A5 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-irqchip-gpio-a4-a5-v2-1-c55b1050cb55@amlogic.com>
References: <20250226-irqchip-gpio-a4-a5-v2-0-c55b1050cb55@amlogic.com>
In-Reply-To: <20250226-irqchip-gpio-a4-a5-v2-0-c55b1050cb55@amlogic.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740548891; l=1414;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=dTNRfdsA0Oz62Y/8dKTOWQTma5Yw707SFzuW8wJM278=;
 b=wum+/0VoVVxzdMJaWSVjZnlXMAoByA44plvy4Ip2dSTsPLGWZWq1Ez/JPN7RCUpdvyxTJPmhU
 h7dQe/c1TKQBLZZp3t5C5yuW4Skj9pb8kWa0/sfU0/xHvvDIlsXQ2dx
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Update dt-binding document for GPIO interrupt controller
of Amlogic A4 and A5 SoCs

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../interrupt-controller/amlogic,meson-gpio-intc.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index a93744763787..4decf1262a6f 100644
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
@@ -60,6 +63,16 @@ required:
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
+      minItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.37.1



