Return-Path: <linux-kernel+bounces-355099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FB8994749
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB261C23004
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159A1D31A0;
	Tue,  8 Oct 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="GEDW03eJ"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F41D8E1F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387269; cv=none; b=pW6/NF58czxjJX4s4Rd08Je/BAWUtezNZp+zMSlo8tsTitat0ZKSZ12oXRUD3jQbi7M1NXWJDC5DjwJdvfXbYy4tZtZ/J09UaQjBMunLZ3JXHRXKsY3yOIm0t/fS53/m7foDilH0Efve1R1GyBafXk9NYGN6UnOGeznW2U6BHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387269; c=relaxed/simple;
	bh=LlhEEJc2nRBOLpYcB4z4fC5JKOQ8ZpijXtD73XaXMlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpMfakEMKBhrj9T2JWVrsWpyXy9SZx3FenlfAChhaEPHWJaln4xrSrMKkoTKlNW7kPDZaguQ9KK07Wa1iGAdajXJd74Oq+RsS9M/fD5sh65eOrX9ZkHZaHZHCKFBDG4OORyz3JwYn1unoEJvhK4pIPGPOe7xffbHNMuduUxw+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=GEDW03eJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728387265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WyJ7Z5sCax3H+U1/xrEos8F1I+KiAxNN6XMVHBXY4YM=;
	b=GEDW03eJ3ggGaiWlnJZzvdHe2KnXWLCVhZE2Ly0QfRU60p6HxGcEy3sEz4zYCVsVYk6pkO
	/R8n4MlSnb76WoQKEvLP9xwV56S8m4VS99AYVRrNVFtYlh48IosF7o8CH3MYFOociduR0M
	nKuiqlzoCSvj8E61OY0eWKk59BS/sDAGg+cxFDoRJR4K5WoVWAdJEDTJV3sYdEb7FinaZ9
	IbCVmafzbuuz7c+ofPoOVTVtLoxeNqFBvlkg9BSTSjPTExL+BfV2XrsK0qi1Bq9X8xIkRu
	0yE5ztEWRZnD1dmGEtBrO5wxd5qhs8mKU5xl39PJqqdYfC7Zumw1NU03wbLeWA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
Date: Tue,  8 Oct 2024 13:15:37 +0200
Message-ID: <20241008113344.23957-3-didi.debian@cknow.org>
In-Reply-To: <20241008113344.23957-1-didi.debian@cknow.org>
References: <20241008113344.23957-1-didi.debian@cknow.org>
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
Fixes: 725e351c265a ("arm64: dts: rockchip: add rk3328 display nodes")
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
changes in v2:
- Added Fixes tag

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


