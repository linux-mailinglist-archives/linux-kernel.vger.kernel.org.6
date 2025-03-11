Return-Path: <linux-kernel+bounces-555416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B7AA5B71B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56FF1892099
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7CD1EA7FD;
	Tue, 11 Mar 2025 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtjE3WsA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CE1E7C1C;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662510; cv=none; b=XVvLiT4H+B0kRM567VoeaprlLYOmCNPoEytxzaL3Rb7rahIb5sl1M1olEOWupF45xp8HWS48Ifb2SBAn+gZ17+JRMrBoKM8UcOkdTpaZoBoKAvL/sANOYkm/CW5K1G/F1JLgnZe2be97SU3HI/QD6/80EvKQdW54wz1G/9Ji2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662510; c=relaxed/simple;
	bh=qXZhNxUy9y5s5LhZ9M7FyoFK7Zgj7Uh6fOjZphxmzps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOIhGuxw6nVQzvA7JGCV3AHjmdKe3xwjaGQYD15AZPhgRFCIPf/vWuUIPtMYS4vpzmfQPVaxhMer58DYdqStF5YDI/fUsMF5QzyGAntpsBxLjrWZLBwJHBf0PnCTwid0/t/RsJtV4mIsCP9UyZYLW9roWfQkwn543DRwV2Z5O5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtjE3WsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D2A0C4AF0B;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741662510;
	bh=qXZhNxUy9y5s5LhZ9M7FyoFK7Zgj7Uh6fOjZphxmzps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OtjE3WsAVX93Kfi+2HoCjHhOcJ27AmcZwt3ppnX7OdBdiKINw0kvkAWxX3hjiKQ80
	 Rf6SydKIgqvgJykjLDe9wPNzruejDxMSR3HX3Byn8bzEUDX7qc2Q4tjUhTjcuMd3CC
	 20cFVRBbXZINoWaN+CbOuVjtBo8sPd40iWWnS/EJ8wag4SV3yO5KMIDU+WZsGjRqsq
	 ac+LuxbApCVBJI0j1uepMYZhlWPg+oljRRGX07Vlld9Sin7fxLuywK6nbYD36fMJlx
	 C7IFeoKd90lAzTBIMDTJtMisZHKNXsX14hJxch/BXKtm9ouDu9TlqP7pyGIZdcwK8i
	 i/UvkPb0bW9Cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D99BC28B2E;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 11 Mar 2025 11:08:30 +0800
Subject: [PATCH v5 4/4] arm64: dts: Add gpio_intc node for Amlogic A5 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-irqchip-gpio-a4-a5-v5-4-ca4cc276c18c@amlogic.com>
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
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741662508; l=835;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=+kt3Jevc/8KR/ZsMbFbD2TjHFreHkm3hzIePStnSOmI=;
 b=eLM/Fg5wgOWvIrSzv/pUKjogLQUlLKhAZf3PT9YVtWAK5FkKOLp0RACQSauS1ciE0UYl9a0Mz
 Ij0EYM0frGaBzdrNYdO1mOkwTSHZyLDePojzSAJbMs299zK8kH0EO2I
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



