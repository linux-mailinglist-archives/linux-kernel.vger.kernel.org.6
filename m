Return-Path: <linux-kernel+bounces-356406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048C9960B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8511C2335F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB217E010;
	Wed,  9 Oct 2024 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EgxDKkdW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640A178CC5;
	Wed,  9 Oct 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458472; cv=none; b=hKz3lxjPCjRQFLvGa9+RKOkOabt/NueSa10709GVZvWXQCG4C/YygZJ5Wfz0Jo9if1uDpo89I/kvJ2DwLjWrZZBsbkC6HT76qTJALPtlKDANglNfDTeA3+qL2fx1Qu4pQSK+tN4pLgSVVPPh0j3foM2F/WvubtUv9F6y8JQu5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458472; c=relaxed/simple;
	bh=XelgteOQmlhm3vlLsvDGsuACRZkgpPlT4YLubA26rrw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VfquMFHzkGeif/lrx/DPqnM/V9Fxq8lKXKBHfLRj51ADpcIkmQJI1AiOV4bGd7I+DHH+e5kzbvLuHnW3z8vUy1ibNeeDT/T3bDsTnnI/bjXKTMoGgt3zBAHltMA9toWxNPokA44S06qqjqUzG42INhC1Q2r3RHjZIQWQsJja4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EgxDKkdW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4997KwnV074036;
	Wed, 9 Oct 2024 02:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728458458;
	bh=nnEc/O1OscdbKaKa4xXCWhizY6Sx8RbpzLP6SeIVCBs=;
	h=From:To:CC:Subject:Date;
	b=EgxDKkdWLfoCQ4BgqWt6Aj6MV7PhHVPEYm2cQAZFClELBwNvTdgJnS3Y+QsJHCmey
	 bPqOt2HwuNfT4JgbwNJZxvKF3uw5OpdzOJPIOxR46HS5UuPUpxoSA5oev8T6WZWDrg
	 LQ97B9V8aLNBN82itBq9lIkvGUiN4dW2vFsv/KtU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4997KwiI001703
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Oct 2024 02:20:58 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Oct 2024 02:20:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Oct 2024 02:20:57 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4997KuSs117426;
	Wed, 9 Oct 2024 02:20:57 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <b-kapoor@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-mcu-wakeup: Configure wkup_uart0 with clock settings
Date: Wed, 9 Oct 2024 12:50:56 +0530
Message-ID: <20241009072056.3511346-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This commit adds the assigned-clocks and assigned-clock-parents
properties for wkup_uart0 in J784S4. Specifically, the assigned-clocks
property is set to reference the clock identified by
"wkup_usart_mcupll_bypass_out0", ensuring the UART operates with the
correct clock source.

The assigned-clock-parents property specifies "wkup_usart_clksel_out0"
as the parent clock. This configuration is critical for establishing
the proper clocking hierarchy, enabling the UART device to function
reliably across different baud rates.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

Rebased to next-20241008

 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index f603380fc91c..c2aa858c37c2 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -310,6 +310,8 @@ wkup_uart0: serial@42300000 {
 		interrupts = <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&k3_clks 397 0>;
 		clock-names = "fclk";
+		assigned-clocks = <&k3_clks 397 0>;
+		assigned-clock-parents = <&k3_clks 397 1>;
 		power-domains = <&k3_pds 397 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
-- 
2.34.1


