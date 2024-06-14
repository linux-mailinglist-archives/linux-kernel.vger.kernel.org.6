Return-Path: <linux-kernel+bounces-214737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802B90895C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5CFDB276A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7B193067;
	Fri, 14 Jun 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t3VEdbr3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6741922C1;
	Fri, 14 Jun 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359721; cv=none; b=WCzEiAUZyyD5g3G3IH4gd//7gqEhyLmj1GSjBl0CUUI8gXhJwDnT/i8998Ipt3NzGTW4OufppXKre+chRZv4WUlCeB3QEQM/wCYkS/tgJOwzCVVkB1JaWBh7vDl5xhfxQxutRqnPSUCWLnmOunKQoaLfZy2nFIxLEHXnrmRacuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359721; c=relaxed/simple;
	bh=S/hpGyn4lFIqS8EHZaqN9dHTsqZrGpxpJCnMzM6Vqus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aQOWmY8Escaxjl2CqwfbreF5lETKqVi3Rr1cdpoBLoOVc1vAE8/oA5PIEQv86XuR4LhnUCeWlo3pmOVKzdPYu1pKXbWCX8HYV5o62kuRZv7OreFQYeFfwxyLhMbjQD8PRER+d5qNhRedkYgrQM1LXsX99nOaBpcsvTeFTKjMF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t3VEdbr3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EA8Ws6033929;
	Fri, 14 Jun 2024 05:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718359712;
	bh=IP0z3kHt1G5/yL2GFWgp2MLJU8Bl094BxSC7eP3B0R0=;
	h=From:To:CC:Subject:Date;
	b=t3VEdbr3Z9sAm6bd7OmMMFmgsur7zvNjZ59ut34h7yUrlW1AZ4cJfAqrFe/8XxHIg
	 j2N9At8x0FT0QhIoPVi37WdtbMWxYSjFba02AQJ5QUro+XexFtm4LUmls+SG5siyTY
	 ICujj4XxLnWUhofXk0wq7JqEMJa1JUzBHS55tXVU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EA8WdK013531
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 05:08:32 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 05:08:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 05:08:31 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EA8Wm5027356;
	Fri, 14 Jun 2024 05:08:32 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 45EA8Vnr010156;
	Fri, 14 Jun 2024 05:08:31 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-evm: Enable "SYNC_OUT0" output
Date: Fri, 14 Jun 2024 15:38:29 +0530
Message-ID: <20240614100829.3919008-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The IEP0 SYNC_OUT0 pins are used for PPS out on AM64 EVM.
Configure its PINMUX here.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index e20e4ffd0f1f..3256f5305a8f 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -466,6 +466,12 @@ AM64X_IOPAD(0x00f8, PIN_INPUT, 2) /* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
 			AM64X_IOPAD(0x00f4, PIN_INPUT, 2) /* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
 		>;
 	};
+
+	icssg1_iep0_pins_default: icssg1-iep0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0104, PIN_OUTPUT, 2) /* (W7) PRG1_PRU0_GPO19.PRG1_IEP0_EDC_SYNC_OUT0 */
+		>;
+	};
 };
 
 &main_uart0 {
@@ -817,3 +823,8 @@ icssg1_phy1: ethernet-phy@f {
 		rx-internal-delay-ps = <2000>;
 	};
 };
+
+&icssg1_iep0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg1_iep0_pins_default>;
+};

base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
-- 
2.34.1


