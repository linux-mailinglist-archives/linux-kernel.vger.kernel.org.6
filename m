Return-Path: <linux-kernel+bounces-285601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D5951033
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6158B260BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0421AD3F2;
	Tue, 13 Aug 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AbV3OSDa"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4816DEA9;
	Tue, 13 Aug 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590209; cv=none; b=Vqrlx8ZKjw6DHYZRiHFStyNoLaqQOigrE5+M9/IiU0lZOuNx0lfssWj3MgYY+FdqmGKpR20X/izJY441L38F8V7j2MbQvvoqISpVlag0d4z78oTU7f/LA1FlnuVYRju+M7BhYqr/AMtDrYCzv88RCqzby4Vyho4QKY4r8ZR/mL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590209; c=relaxed/simple;
	bh=c9atz1oVyaKQqGu9LyFP6Irr7fN60a3IRcLA7/QU9qY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9JBqg9sbvtOKZZ6dkuIQqHCqxSlyz7NldnmO7lSwDlbIWsZ3mdMGbjeYT9UQTeuWIRBuLbL4tjCCtj4o9Y0rPO+6Xlw7E9TG2mIZd9zzSVztIypkiYR2jBkazQgTxJhedOHJaXQ+7D8NAwh/oE+h2uDtpsX76xatAP0MEppWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AbV3OSDa; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Lwn099211;
	Tue, 13 Aug 2024 18:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723590201;
	bh=PVOe6aH9/bfKo9BOInR25L5zNVD08picT0YatODE5rM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AbV3OSDakivMurob+f+IZMB2/vJ5F7Jct/SD7XTP1/YwoIb0HkLoHrkt2sqzm7zXi
	 t+zN80vJfw8tKaqLZFNgenDovRZZoMzubt0m2qJNq0/MgAeFTDemYwDpnVd4UySwfM
	 NKIhcObT8ccmeAfIVrEZ+kd43eLLkE4lwrwcaBg8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DN3Lol087055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 18:03:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 18:03:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 18:03:21 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Khm026425;
	Tue, 13 Aug 2024 18:03:21 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        Judith
 Mendez <jm@ti.com>
Subject: [PATCH v2 1/6] arm64: dts: ti: k3-am62a: Add ESM nodes
Date: Tue, 13 Aug 2024 18:03:07 -0500
Message-ID: <20240813230312.3289428-2-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813230312.3289428-1-jm@ti.com>
References: <20240813230312.3289428-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add Error Signaling Module (ESM) instances in MCU and MAIN
domains, set ESM interrupt sources for rti as per TRM [0] 10.4
Interrupt Sources.

Add comments to describe what interrupt sources are routed to
ESM modules.

[0] https://www.ti.com/lit/ug/spruj16b/spruj16b.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Add bootph flag
- Add comment to ESM nodes
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 916fcf3cc57d1..8c35293c3d2b0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -265,6 +265,14 @@ main_pmx0: pinctrl@f4000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	main_esm: esm@420000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x420000 0x0 0x1000>;
+		/* Interrupt sources: rti0, rti1, wrti0, rti4, rti2, rti3 */
+		ti,esm-pins = <192>, <193>, <195>, <204>, <209>, <210>;
+		bootph-pre-ram;
+	};
+
 	main_timer0: timer@2400000 {
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 8c36e56f41388..a5ca4ce523a46 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -15,6 +15,14 @@ mcu_pmx0: pinctrl@4084000 {
 		status = "disabled";
 	};
 
+	mcu_esm: esm@4100000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x4100000 0x0 0x1000>;
+		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0 */
+		ti,esm-pins = <0>, <1>, <2>, <85>;
+		bootph-pre-ram;
+	};
+
 	/*
 	 * The MCU domain timer interrupts are routed only to the ESM module,
 	 * and not currently available for Linux. The MCU domain timers are
-- 
2.46.0


