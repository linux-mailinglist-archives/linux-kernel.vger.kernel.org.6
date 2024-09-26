Return-Path: <linux-kernel+bounces-340320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4D987185
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2986D1F21A80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540CA1AD3E7;
	Thu, 26 Sep 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ta0WoAD9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C17171675;
	Thu, 26 Sep 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346567; cv=none; b=EXklc7sMS1Mj/ZOj1L8sIyIH5o7NF1GwBivi1hACW0cn9InfEGfhpsJyYhO+QcGZqeKeG/BJa2CdmgHVZcIO9dGQkWLfcUyQeyC/IRYLOIqEJ/r3yhJcp7kdd+4q4pibq/b/c+qr0PBIcMk2ofa3eMPSLiGS212gF4uSpdaMTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346567; c=relaxed/simple;
	bh=2MY3B56eOb1hPM9DrUHCDpYd4Gw2sDGUFf0Gnq3hnag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NdAAtz2dCEh5Eft0KJXbyOAj8bi5V5JH1F1skuFV5rUay0wBiqQ7SBC0Z1Bb0WrfMmkMZazEUzG7gevd/f/WPNgcQyE+7aRwsJArABqisvxUSbxXWKvY2GyP255uvZUOwG+cTghMkw9oXVSvw37VpActMoYXG24ZKZtGd4GNH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ta0WoAD9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727346563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J/F/BWtIgPoFAzYVwIzm5Lu7wG59Hvzk3WZJccbkqXw=;
	b=ta0WoAD9Fu40CndxyRcJmvjEFGDADzRsqMlFOSc0kMfuBK3PCnEMoBApTXuEQZkBvv9e83
	Mdh29pDRShfAw36+tw/Ta26i8POHCA6hqUL015kz5gUiJA/Qq/stTxDsuC1lUzXP3Y4Q1K
	uNLMNQBsOaFg8hY+lZ0Vs2oF36R8CQt9S/eGxu20moqXsjh1HEzPM9dJAq5bRXaJ/EhU6Y
	XDVpsLUxu4iXYZpQdCDjq9NZGrbmNAbQ75uBEbVLeyiMQut5FPhByWKezxC9G2RuIPqT89
	zv39XrECl3UkHnW0Ir9fKw6H4CjSrweXkcY5NkFOf0d8+VUg7px/46RvF2A4ZA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] arm64: dts: rockchip: Move L3 cache outside CPUs in RK3588(S) SoC dtsi
Date: Thu, 26 Sep 2024 12:29:13 +0200
Message-Id: <84264d0713fb51ae2b9b731e28fc14681beea853.1727345965.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move the "l3_cache" node outside the "cpus" node in the base dtsi file for
Rockchip RK3588(S) SoCs.  The A55 and A76 CPU cores in these SoCs belong to
the ARM DynamIQ IP core lineup, which places the L3 cache outside the CPUs
and into the DynamIQ Shared Unit (DSU). [1]  Thus, moving the L3 cache DT
node one level higher in the DT improves the way the physical topology of
the RK3588(S) SoCs is represented in the SoC dtsi files.

While there, add a comment that explains it briefly, to save curious readers
from the need to reference the repository log for a clarification.

[1] ARM DynamIQ Shared Unit revision r4p0 TRM, version 0400-02

Fixes: c9211fa2602b ("arm64: dts: rockchip: Add base DT for rk3588 SoC")
Helped-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    See also a related discussion [2] that initiated this patch.
    
    [2] https://lore.kernel.org/linux-rockchip/2aa03ce3-1cca-4b3a-935d-6b1b68ebbb6e@arm.com/T/#u

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index b6e4df180f0b..48a79b4b1b6e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -337,15 +337,19 @@ l2_cache_b3: l2-cache-b3 {
 			cache-unified;
 			next-level-cache = <&l3_cache>;
 		};
+	};
 
-		l3_cache: l3-cache {
-			compatible = "cache";
-			cache-size = <3145728>;
-			cache-line-size = <64>;
-			cache-sets = <4096>;
-			cache-level = <3>;
-			cache-unified;
-		};
+	/*
+	 * The L3 cache belongs to the DynamIQ Shared Unit (DSU),
+	 * so it's represented here, outside the "cpus" node
+	 */
+	l3_cache: l3-cache {
+		compatible = "cache";
+		cache-size = <3145728>;
+		cache-line-size = <64>;
+		cache-sets = <4096>;
+		cache-level = <3>;
+		cache-unified;
 	};
 
 	display_subsystem: display-subsystem {

