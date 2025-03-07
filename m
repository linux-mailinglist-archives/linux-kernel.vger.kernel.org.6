Return-Path: <linux-kernel+bounces-550686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D802BA562F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E69F3AFF73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A41E1E0F;
	Fri,  7 Mar 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi7H9JPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAD1AF4C1;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337364; cv=none; b=Div8yYsgvykFcB0QsfzjZImDtuz5gu1lBavvzI7aRu/Acmv4QI2NgpwyCtTUq85IF832QpX1VfWw/cg3sMdWbwsGcf4M7kUdP3zDjt1ukc0Y1KIGMhMvK1D4OVvWYELqzQs40cX0NilqS9CSI5lS/ERoW1M6bBGUK2jWfb6Rh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337364; c=relaxed/simple;
	bh=qch7huQ3IX9eDJtDp+CrMjmAYNzCX1pjwyDdnZ1GCVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6aerFOUgExfuMoA9SQL77JbSIbvd71q07ssqoNUZmtZ14vi0Eggfoeyz44mG0JQxEzL+j8u6pUoyvcMjhlrORUVc3eI6Vf9nmDzQggNARIM/iNnldSBjh6M4R7Xgd1dlX22D6ATnxZcEpQ3MO7QmxfYfTQ6BBZ1exminVb3e0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi7H9JPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FDFDC4CEE5;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337364;
	bh=qch7huQ3IX9eDJtDp+CrMjmAYNzCX1pjwyDdnZ1GCVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zi7H9JPCDjJ5Ac5aAZKNKsImdQr2gdY5re8VfABBsgBG+/rPzmv6GMaxckMdHLai/
	 0xckpejhiDrIv5E0yvc6JFR1aJerkjvaXjdGSX6I+ZKmpEjOW8cheMVnX0eB9zEuVB
	 xatOyWXFZ6r5Da002XEDj/RlaJWdUzXNfrMh8othjN0MQ5oDpyxhIVe1ej1+AH4ozV
	 KZ/M8JsGXqnoPiSMRHWYnJr5cGx+B4sfzTV9MtKbCQfXcZLiDmlqInEeqv8HWiKk/w
	 9tpgyfvG/YJSqDKlYeyk7ZvusWrnzhpT4DkieNNg0GUNfQqsv+pPYCPzNoXhQmDL+5
	 XjWmk1L6isGwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3329EC19F32;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 07 Mar 2025 16:49:24 +0800
Subject: [PATCH v4 3/4] arm64: dts: Add gpio_intc node for Amlogic A4 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-irqchip-gpio-a4-a5-v4-3-d03a9424151b@amlogic.com>
References: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
In-Reply-To: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741337362; l=1190;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=QC+CPrCwcCU8cBlAO137f57knOzl0UVfLJyIMFfXkFY=;
 b=iPjGdLjBPkH/6V3/Ark9JaIDbrnouhnUzHlf3P/khl326TBP1cMImeMfbVuFXLjG1FO3yo+tj
 R5hR/xBNh4hBB8wxERLKMAwUWIJT0Zgkn8w/p3PdL6x/VlKSTCFb/UL
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
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index efba8565af3c..fa80fa365f13 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -51,6 +51,25 @@ pwrc: power-controller {
 };
 
 &apb {
+	gpio_intc: interrupt-controller@4080 {
+		compatible = "amlogic,a4-gpio-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x4080 0x0 0x20>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts =
+			<10 11 12 13 14 15 16 17 18 19 20 21>;
+	};
+
+	gpio_ao_intc: interrupt-controller@8e72c {
+		compatible = "amlogic,a4-gpio-ao-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x8e72c 0x0 0x0c>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts = <140 141>;
+	};
+
 	periphs_pinctrl: pinctrl {
 		compatible = "amlogic,pinctrl-a4";
 		#address-cells = <2>;

-- 
2.37.1



