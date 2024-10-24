Return-Path: <linux-kernel+bounces-379203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739C9ADB63
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E03283B14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF6173347;
	Thu, 24 Oct 2024 05:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vM1LOYxw"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80861714CA;
	Thu, 24 Oct 2024 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747291; cv=none; b=uHXJkJoeHbd/InidO9aGWzNJuJu9F8YrUTUpuZYKnw/AL5COCyXidaWcJiHnvI7HQvCz38413rVsiUKSpLTLYYYpz0oa5JdpnPINnYOjkgljbr+ZJ9179xW7WcnctHfVuo84MvlrkAIEL29mz0tbQQl3EqLoUlfPlZDAdYKER+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747291; c=relaxed/simple;
	bh=R0/Qn0zB/Tf81iMF9clZeZqadZUyQ3qlZvNn3CLr8js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PHWvvcQVQ+sNbVKBF8ABlhjpmagnlwoWyCFpACa/ljp6Mns2D8BF3KUg0xnCbOK3zrB6+3ZFIPTH+GaPbun0HkiZj+6jax5SRdL+pAtoYe/GTMWCodzO+nAr8I++qhwMCj1tib/l/gdU5iGH6zarcydtE4mSZemt2sjF005NpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vM1LOYxw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LI2T015332;
	Thu, 24 Oct 2024 00:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729747278;
	bh=De3P7gfjLN5T5chbulrTosl40nd8jPG0zt2xWBDK+f8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=vM1LOYxwOyAIqZBHIWy3n3dxXIIdpHBn6Eax4MvPhohTxw3liDB3d8DOjsU3j+q1u
	 c/vNdmSjPBzP81y4KeA3Y3T6ng34PnSvZa5UN/0Cil55rk51U2LStJHBySHlJt1qkD
	 o+bW3PUh+1bMZC115nZxLhUSRSN9a4iBSTc0f1oY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LImN024996;
	Thu, 24 Oct 2024 00:21:18 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 00:21:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 00:21:17 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5L4lA090467;
	Thu, 24 Oct 2024 00:21:13 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 24 Oct 2024 10:50:59 +0530
Subject: [PATCH v6 02/12] arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup:
 Remove parent nodes bootph-*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-b4-upstream-bootph-all-v6-2-2af90e3a4fe7@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729747264; l=1611;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=R0/Qn0zB/Tf81iMF9clZeZqadZUyQ3qlZvNn3CLr8js=;
 b=AWQ5iqxoc/vy/yGqFpanz1at/4o97xaO0tR/7G5Z9y0xZU5Ag3ERuxv8DAe9s7mr0PetspdhI
 kNWd+t/hGyBC0apW4TR+kuZm8WOJ7yDodSVqqJHouevZv0QOmEMO0Xm
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adding bootph properties on leaf nodes imply that they are applicable to
the parent nodes as well. Bootloaders can derive the parent nodes when
bootph is available in the leaf nodes.

Remove the bootph-* properties from parent nodes as they are redundant.

Reviewed-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    It wasn't existing previously in U-boot but the following patch fixes it [0]
    
    [0]: https://lore.kernel.org/u-boot/20231217163627.2339802-10-sjg@chromium.org/
    
    R-by picked up in v5 ( Aniket )

 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
index 9899da73a905a517a8561f09515aa8303f8d6b5d..46bc2a3e4aea68415f7bb54f401b81e81d45134f 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
@@ -7,7 +7,6 @@
 
 &cbass_mcu_wakeup {
 	sms: system-controller@44083000 {
-		bootph-all;
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 
@@ -39,7 +38,6 @@ k3_reset: reset-controller {
 	};
 
 	wkup_conf: bus@43000000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -458,7 +456,6 @@ mcu_spi2: spi@40320000 {
 	};
 
 	mcu_navss: bus@28380000 {
-		bootph-all;
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;

-- 
2.46.0


