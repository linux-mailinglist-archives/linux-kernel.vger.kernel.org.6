Return-Path: <linux-kernel+bounces-552392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C2A57981
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0745D18939E4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE461AF0C9;
	Sat,  8 Mar 2025 09:30:25 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7341B0F0B;
	Sat,  8 Mar 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426225; cv=none; b=bJOtN9WFru2WBkXCp3s1+Zbgg3dV+pZEnFQ0pH7jbToRCkhCnhKio35MbxxdcoAqKuikFZW1mZP/q8W+kL/V7M9sX95oL+JUAPq5ETtgGvLT8L91h2b/JeBMgMFYyPOaey0EuwnVU7X4DujUq/ooY4We/5Ey9hzvXNw/wSus3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426225; c=relaxed/simple;
	bh=qjtEVgKg7aSCTEEErT7DmK5qkUcB+t4P66ofDG9ntqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPGN1jwtc+4U2EySA3KEBtL30J1g8KnJBJnom1SZlNta1gRwgxQsuYmmALAVA3CKmQUePjWpnocNz/mQsZpPMQ149imOyy+6U7UFPAm+hRYjlRBJl++oZ2iJyAgYZFLl3mcaaIk5ovUlArkT3pix7XsHFQCCWihNKZ+R4q3XRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3300:217:f42e:f419:35e])
	by smtp.qiye.163.com (Hmail) with ESMTP id d88bc5ea;
	Sat, 8 Mar 2025 17:30:13 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] arm64: dts: rockchip: rk3568: Move PCIe3 MSI to use GIC ITS
Date: Sat,  8 Mar 2025 17:30:08 +0800
Message-Id: <20250308093008.568437-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250308093008.568437-1-amadeus@jmu.edu.cn>
References: <20250308093008.568437-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB5JVkIeGUIYGEhCGUlKQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUhIS0tBSUpMQR1PSR5BHU9KQkFITh5ZV1kWGg8SFR
	0UWUFZT0tIVUpLSU9PT0tVSktLVUtZBg++
X-HM-Tid: 0a95751741d903a2kunmd88bc5ea
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTY6Gjo5DzJJFCksLyE5MT8f
	LUwaCgpVSlVKTE9KT0lNSUpIQk5IVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSEhLS0FJSkxBHU9JHkEdT0pCQUhOHllXWQgBWUFKQ0xPNwY+

Following commit b956c9de9175 ("arm64: dts: rockchip: rk356x: Move
PCIe MSI to use GIC ITS instead of MBI"), change the PCIe3 controller's
MSI on rk3568 to use ITS, so that all MSI-X can work properly.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 695cccbdab0f..e719a3df126c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -152,7 +152,7 @@ pcie3x1: pcie@fe270000 {
 		compatible = "rockchip,rk3568-pcie";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x10 0x1f>;
 		clocks = <&cru ACLK_PCIE30X1_MST>, <&cru ACLK_PCIE30X1_SLV>,
 			 <&cru ACLK_PCIE30X1_DBI>, <&cru PCLK_PCIE30X1>,
 			 <&cru CLK_PCIE30X1_AUX_NDFT>;
@@ -175,7 +175,7 @@ pcie3x1: pcie@fe270000 {
 		num-ib-windows = <6>;
 		num-ob-windows = <2>;
 		max-link-speed = <3>;
-		msi-map = <0x0 &gic 0x1000 0x1000>;
+		msi-map = <0x1000 &its 0x1000 0x1000>;
 		num-lanes = <1>;
 		phys = <&pcie30phy>;
 		phy-names = "pcie-phy";
@@ -205,7 +205,7 @@ pcie3x2: pcie@fe280000 {
 		compatible = "rockchip,rk3568-pcie";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x20 0x2f>;
 		clocks = <&cru ACLK_PCIE30X2_MST>, <&cru ACLK_PCIE30X2_SLV>,
 			 <&cru ACLK_PCIE30X2_DBI>, <&cru PCLK_PCIE30X2>,
 			 <&cru CLK_PCIE30X2_AUX_NDFT>;
@@ -228,7 +228,7 @@ pcie3x2: pcie@fe280000 {
 		num-ib-windows = <6>;
 		num-ob-windows = <2>;
 		max-link-speed = <3>;
-		msi-map = <0x0 &gic 0x2000 0x1000>;
+		msi-map = <0x2000 &its 0x2000 0x1000>;
 		num-lanes = <2>;
 		phys = <&pcie30phy>;
 		phy-names = "pcie-phy";
-- 
2.25.1


