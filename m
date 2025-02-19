Return-Path: <linux-kernel+bounces-520994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D1A3B25F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC9E7A5BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE971C3C0F;
	Wed, 19 Feb 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwAQRb47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71591C2325;
	Wed, 19 Feb 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950147; cv=none; b=YzuYJlVN5sve77F3ep+z7JieiMuyOsfFgMTjS4QMyL5ImXme7uW0t9zjhl6AC1T1f3KeSlzNr5TvcyVYNkkxEvgkmwul1Gd55ydTRv8sj1VAMG9yDt095pSg3PINFh/7LwRqt7CX1q64WNx7ib8yNWEYM+8KlCYu9GVtdeMQldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950147; c=relaxed/simple;
	bh=qXZhNxUy9y5s5LhZ9M7FyoFK7Zgj7Uh6fOjZphxmzps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imTz7YM4JmJQLWiRBGXa884hXL7VzG64JjntXDfhKsClB2RsWigy1vDRfMVe/wUkbkQKf4JCgaWD1JwjswNv3iYiln5jfoHQPU06sGuzKZZQ6+b5pEYQRUkWiVFRuFQ7XEaHSmQEFEX1xfc71gZVXlovg6g+yb9wWuJyppXtxsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwAQRb47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 477A6C4CEEF;
	Wed, 19 Feb 2025 07:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739950147;
	bh=qXZhNxUy9y5s5LhZ9M7FyoFK7Zgj7Uh6fOjZphxmzps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IwAQRb47TVbE89/CUVHMa/H2/v7L79qjxgOKjsv5/kMtp4N0LsuWpUKSCSiVRinW7
	 xOdYmFy4PlxXAWQ3b9d+ikANpcAuvpSMsiu0sdvvjEKUR7LSPn/STA8u/3GqIaihBN
	 q1cmKP4sv85SeLCVEkZRqITObNjEvyIDubQsOiPmvd2pQvl3VWlcFR20HDkl+SlZ95
	 YsXGkhnEQotPrul+5zfC9LDthPIlJgcQGHU7up2yW8UgU5pjhF3OhHKJA61WMBp+91
	 24iN36OSSn35tfN5jqDxNtimZFpJ2EpMak8f4eX7euw8B0B90ejW/R/bz5YWJF5Zq5
	 lGFQbfUst3XmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38589C021AB;
	Wed, 19 Feb 2025 07:29:07 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 19 Feb 2025 15:29:06 +0800
Subject: [PATCH 4/4] arm64: dts: Add gpio_intc node for Amlogic-A5 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-irqchip-gpio-a4-a5-v1-4-3c8e44ae42df@amlogic.com>
References: <20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com>
In-Reply-To: <20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739950145; l=835;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=+kt3Jevc/8KR/ZsMbFbD2TjHFreHkm3hzIePStnSOmI=;
 b=Gz9eY74qdMAmL/N5DpslVabeRg+4GyurES08b0DsfIFa/n5AEP23l0Kun+CdM1YiQ5gwEEne8
 U8l3Dzz6wOUCDOuZjeaqIvSavN0786zN6rka1xBcyneQwByrsSmIsFX
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add GPIO interrupt controller device.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index 17a6316de891..32ed1776891b 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -48,3 +48,15 @@ pwrc: power-controller {
 		};
 	};
 };
+
+&apb {
+	gpio_intc: interrupt-controller@4080 {
+		compatible = "amlogic,a5-gpio-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x4080 0x0 0x20>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts =
+			<10 11 12 13 14 15 16 17 18 19 20 21>;
+	};
+};

-- 
2.37.1



