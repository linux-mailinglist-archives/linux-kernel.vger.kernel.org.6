Return-Path: <linux-kernel+bounces-276966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2574949A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F162820CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70954176AA2;
	Tue,  6 Aug 2024 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eewlP5uu"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A613C677;
	Tue,  6 Aug 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980775; cv=none; b=bGaXWm7nSI2jvBm9IX+oTA7W3/mrTn9lgPxMq4GN1Ojs+D7jgWDwFwoJ7LXyQrNT8+jiQZ9waEu23QPsWr6PLM/yZoN5wWSHSSugPgCUXaL92wEqNQY6yjgUC+s4UvfZ3PfB+HsYuLBPpv6VPWS/nVzHHvFVCyWwd1CacbCMByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980775; c=relaxed/simple;
	bh=Bgv9wrcDqk8Ht+zL7TnCoxRLwpvfHu1TaMm7fJuLb5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tK/w+TBvS4/y52nWA4FYp/qTuq7BZBVJVEtuslFRjIPiZsfN8G0YKV+yeXnSWs5IeZHa1EE/1svrSFcwl4VEuDEAvG5uYIsIqO8rQv7M5YrDUjoKAI7pwuU8aPY60FC33R12kqcJU+cdHEsz8Q6aaE4VfvTpwtBE7ySB3dCB9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eewlP5uu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5qe124331;
	Tue, 6 Aug 2024 16:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980765;
	bh=Wgmvl+xMIznbzubj7GklurSrbNaRNYBnUCXrflEOXAs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eewlP5uuP/Gj6VUkuLx1RRy1zHnDWI6JR1ocKlxS0Oi+xoB4ME3tUpER5OeryD3zK
	 fZ6AhP+WnzpdmmIOyKUKH/Odo2zhpqHHeOHLfQ52UnFRe05jTybEQc+OnNpMt0c6k0
	 Cu2V5pENlkh8PmAzP7IEuUX8+1pUboV0p7DCW5TM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476Lk51g126304
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:46:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:46:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:46:05 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5Qq100327;
	Tue, 6 Aug 2024 16:46:05 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar <s-k6@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
Subject: [PATCH 1/5] arm64: dts: ti: k3-am62a: Add ESM support
Date: Tue, 6 Aug 2024 16:46:00 -0500
Message-ID: <20240806214605.3379881-2-jm@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806214605.3379881-1-jm@ti.com>
References: <20240806214605.3379881-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add Error Signaling Module (ESM) instances in MCU and MAIN domains.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 6 ++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 916fcf3cc57d1..fb5a3006e20ac 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -265,6 +265,12 @@ main_pmx0: pinctrl@f4000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	main_esm: esm@420000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x420000 0x0 0x1000>;
+		ti,esm-pins = <192>, <193>, <195>, <204>, <209>, <210>;
+	};
+
 	main_timer0: timer@2400000 {
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 8c36e56f41388..cea0e1d4caaa0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -15,6 +15,12 @@ mcu_pmx0: pinctrl@4084000 {
 		status = "disabled";
 	};
 
+	mcu_esm: esm@4100000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x4100000 0x0 0x1000>;
+		ti,esm-pins = <0>, <1>, <2>, <85>;
+	};
+
 	/*
 	 * The MCU domain timer interrupts are routed only to the ESM module,
 	 * and not currently available for Linux. The MCU domain timers are
-- 
2.45.2


