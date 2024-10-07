Return-Path: <linux-kernel+bounces-353168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46A99299C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F481C229EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0715F1D26E3;
	Mon,  7 Oct 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Zm6I7VlQ"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BD1D1E9C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298698; cv=none; b=RyNuR4u1sdDPnkYuflxiLTw8bkRHyd9bnk6RkxnBiWKNQI6kzHU5QtZBFIBVklyxS3XX0ne3a0GsQHI7LaCzmnsVFBn8FMI/vsFxmz31UgamD9RAthfqoNzLIPnFmp3+a/YF0IdAO4BGTLNFNIeCJ2rcF+b/n/BbnDNH4aTKEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298698; c=relaxed/simple;
	bh=kffpwyYW1A2MRW4V27wqpYISOP+zPXXsnNUffNU5Jcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+/WL8cKql1tUKPBNJzxQCMN31jlnvFvBZZ/FR9WrxHh2zjLpq/9z353I1OiL2hsoktfom2h2VaVM+66rfnouQEq7wuwVgR2U05qBjg8VHtcnhWKpoeRiOIMehcQVBlJ5v585vi2+DU3ux5FaDm9rwo3ex5SBcAOcGZHe2Lab5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Zm6I7VlQ; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728298692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVypFZndkb1hDBUGAh8t09mRCyK4drfE9GWmDKb6pno=;
	b=Zm6I7VlQmDUwlKb/YjknRT4RT1FEJSf4kD6G4DBU0o/l4mOu6cy8i8YOP5jp3PAlwsijoY
	EaS0x+Zgn9pIrvsDuAzZA3YPS+WNzksjS9H+bGO3FOZ3gigogjel+8/EYPtzOla+ke1VnH
	ikJ597MLpohaKorPEkdUCGooDcGHCUaIv1+ABVaYKOUttLsDauIAkxJh0BUDqo9f3oIwHA
	lM8pu+sMPWcHm4+enw/3K4eCBdc9IZjUed5gU6lcSVavpvMOr9m5xb8s61RRygQHXgoH5b
	0b2kOz7urxloIK5XGrzRtH8hYKpHbOL8M2tF4IlL/W6Sm/mfij30z46h7D4x4A==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
Date: Mon,  7 Oct 2024 12:28:17 +0200
Message-ID: <20241007105657.6203-4-didi.debian@cknow.org>
In-Reply-To: <20241007105657.6203-2-didi.debian@cknow.org>
References: <20241007105657.6203-2-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "synopsys,dw-hdmi.yaml" binding specifies that the interrupts
property of the hdmi node has 'maxItems: 1', so the hdmi node in
rk3328.dtsi having 2 is incorrect.

Paragraph 1.3 ("System Interrupt connection") of the RK3328 TRM v1.1
page 16 and 17 define the following hdmi related interrupts:
-  67 hdmi_intr
- 103 hdmi_intr_wakeup

The difference of 32 is due to a different base used in the TRM.

The RK3399 (which uses the same binding) has '23: hdmi_irq' and
'24: hdmi_wakeup_irq' according to its TRM (page 19).
The RK3568 (also same binding) has '76: hdmi_wakeup' and '77: hdmi'
according to page 17 of its TRM.
In both cases the non-wakeup IRQ was used, so use that too for rk3328.

Helped-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b5cbe7cab10b..0597de415fe0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -754,8 +754,7 @@ hdmi: hdmi@ff3c0000 {
 		compatible = "rockchip,rk3328-dw-hdmi";
 		reg = <0x0 0xff3c0000 0x0 0x20000>;
 		reg-io-width = <4>;
-		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_HDMI>,
 			 <&cru SCLK_HDMI_SFC>,
 			 <&cru SCLK_RTC32K>;
-- 
2.45.2


