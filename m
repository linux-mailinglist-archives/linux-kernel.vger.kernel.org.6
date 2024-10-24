Return-Path: <linux-kernel+bounces-379202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54C9ADB61
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429B4B2079B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE126175D29;
	Thu, 24 Oct 2024 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b44EKNdR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF721714CA;
	Thu, 24 Oct 2024 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747283; cv=none; b=Q1DO8ZmOuL/tVWps6GSsn6+d4vmR5/5Pmz9tNYtQxfAM64Neb91xwLxL68eGb9vt5Zfv5liha/A1Kwu8yTZt3Dv3trRnU4E/5cLNa2+BYcPWQ+z9Da9Y0bKXqi7iBSWLT3ylbYg5sJ4sZTQJ4Ub30zyRITCVTPw5m5XsRI5jM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747283; c=relaxed/simple;
	bh=lZozQbcJQiO0UVvbYFS2yPXzr225GkFC5cXg4SjJYwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jMfJ/uhMzoz4XXYJa9ml4IFqVXN4d13xhx/6ol5vGYYX3ZyGz0m3TF530u64vy8loh0slA9gkfAA1dBariZrPsKxJe68m/uISNIQn1nlCJiEqTmwbd7rSHxhBjnw4s0qvGHx+gZtOK4TYpEU1MkGxfBAlao2lF7Nw2KH8QXLYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b44EKNdR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LEk8113211;
	Thu, 24 Oct 2024 00:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729747274;
	bh=5dO0N4/DHTKW60UDyN1pIloN2hD9MUs3qLYywdtCfZw=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=b44EKNdRp+tINAZxTSNQtv/ky7KR/smyM8KjS9T7OSo3KeiPZFa1FHefIj5f9musT
	 8VGK+/xIlgPfUSEI5/SodoOOhrx9j1f6rVAmMsc3yxqDWH3glNECcBswhB+rOzodlQ
	 DTRyK/f17vddGg4m6a1w8um/PqgXclgv/IpBXfmM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49O5LDiY084936
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Oct 2024 00:21:14 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 00:21:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 00:21:13 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5L4l9090467;
	Thu, 24 Oct 2024 00:21:09 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 24 Oct 2024 10:50:58 +0530
Subject: [PATCH v6 01/12] arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Move
 bootph from mcu_timer1 to mcu_timer0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-b4-upstream-bootph-all-v6-1-2af90e3a4fe7@ti.com>
References: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
In-Reply-To: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729747264; l=1149;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=lZozQbcJQiO0UVvbYFS2yPXzr225GkFC5cXg4SjJYwk=;
 b=GoFXTJrmeQkvnkh1CwrZikFkFxZE3PBwL7BiMQP+b/LnZHJhpaP5KEoC5+Jus12cLvlfiN9y5
 mrA2QBGFwTNDdKPHekUeQuIc9GIxMFlJOtZ66IAZZ2g/Qy0TSxT3V8O
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Bootloader are using mcu_timer0 instead of mcu_timer1. Adds bootph to
mcu_timer0 instead of mcu_timer1.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
index cba8d0e64f2e6336cfb6f356c879aecc6d49880a..9899da73a905a517a8561f09515aa8303f8d6b5d 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
@@ -172,13 +172,13 @@ mcu_timer0: timer@40400000 {
 		assigned-clocks = <&k3_clks 35 2>;
 		assigned-clock-parents = <&k3_clks 35 3>;
 		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		bootph-all;
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
 	};
 
 	mcu_timer1: timer@40410000 {
-		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x40410000 0x00 0x400>;
 		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.46.0


