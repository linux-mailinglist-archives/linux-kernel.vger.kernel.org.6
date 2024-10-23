Return-Path: <linux-kernel+bounces-377483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F49ABF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B512D28588E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF8B15098E;
	Wed, 23 Oct 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hJ9JO7j3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC215530B;
	Wed, 23 Oct 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666678; cv=none; b=pBygmHJ7ipwM4IU3L3hSkYPpEc3eLxY/xkqF9N1GDbUOA0onFPGCy74DuH02BRpwKe5L5OYsjCy4T3F/U/ypqAN5nMWWCqA3z42X3naXHkx/mEXxarvGymXGli8qQqCeaeHyn2jVwqAgdJTMIiKxVd8VCdPn1/cQ18dHWtxdAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666678; c=relaxed/simple;
	bh=TWueD0JQPwhx4GLWqtuVNGZP+TyqKya0NYgWWgv5uEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DpirJoxxaFhv396JRN25ky9ptu3IuCvKH9UDUGqf0AAlq5qc0jEahBEHbeEhAJ7XGXByVVsc3FCY2PX+F9apdD4ibDcRtBBzJgA5ejFF1mXn6JtNpYabJhnUFE1qLnkmVtX/+qB7XbHrppRUwPIHaAMwWf+/0aCruTebkH4er2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hJ9JO7j3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vjMP062291;
	Wed, 23 Oct 2024 01:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666665;
	bh=u0YMg5Kwoeu8GHVQONXQkthar1mQkIH/GxLbGfQwGyg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=hJ9JO7j3RSS+EAknVhumwYH+2DtyVhtT0/uecSNRBIky/ePkiy4mEOARfiN3uMadm
	 tojK1iP4FFb1NQOjVwe5X9/IETOVJvWfxgit4RCrIsZQHiJvQgsibESdzSHm/E6xQT
	 nUgXk1gUwezYg8fG+rWid7xKxsyOq7MT8sTn1Y+A=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6vjr2068571
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:57:45 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:57:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:57:45 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUP129058;
	Wed, 23 Oct 2024 01:57:41 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:16 +0530
Subject: [PATCH v5 02/12] arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup:
 Remove parent nodes bootph-*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-2-a974d06370ab@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=1466;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=TWueD0JQPwhx4GLWqtuVNGZP+TyqKya0NYgWWgv5uEo=;
 b=MvoJOBYMw3QCS3GhxQBsc5yC/tGDJAyrCFFrNRnSQ/hGoACep+R+dWy9e+zuSAfsWiCMCMnBq
 wQk/th6tpM0BQsDge1xH/8o5YSDGxoWz0FAvxMQaG9G5puAm/kPRaVG
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adding bootph properties on leaf nodes imply that they are applicable to
the parent nodes as well. Bootloaders can derive the parent nodes when
bootph is available in the leaf nodes.

Remove the bootph-* properties from parent nodes as they are redundant.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    It wasn't existing previously in U-boot but the following patch fixes it [0]
    
    [0]: https://lore.kernel.org/u-boot/20231217163627.2339802-10-sjg@chromium.org/

 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
index 9899da73a905..46bc2a3e4aea 100644
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


