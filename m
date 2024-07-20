Return-Path: <linux-kernel+bounces-258059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A229382DB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 23:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4101C20D26
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2791494A0;
	Sat, 20 Jul 2024 21:09:10 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2371448E4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721509750; cv=none; b=KRPnTXfH0Jj5yP44kZYo5mEMCCBe44d8/lovehGpnul/CyBkktcUi+Tb7LCg7hFhnPmE18MuVgLe8BJhcWJrYjWRuXP8MF0bHPuRTHbbigoD/KA9Sn5M4UVovwqiTVWhMrg62aQ328VvMYY8Q8KYhGqJfW/KLLPZTlkeDZGvX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721509750; c=relaxed/simple;
	bh=/Pr1VvO4TiEqywd+xj5UOg5mdJyTkmGos5iYdgrijwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6L1M9dZ9AN+cJlrUrQnrPywPMh45RLPImNlwkj3bOXe95WUgKneAaRaMBNE7JNH2YcbAuiasDDfTG5g0kZwke1qaPw/SbMjMsL6B1k8q26nYboKlzSry2TiGbasboWEzESeRWndnhfodepfOcNENyLs+Q0Q3xN4mGIKWnVCJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVHKB-00061D-QE; Sat, 20 Jul 2024 23:09:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
Date: Sat, 20 Jul 2024 23:08:48 +0200
Message-Id: <20240720210856.778014-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240720210856.778014-1-heiko@sntech.de>
References: <20240720210856.778014-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TS433 uses both pcie controllers for sata and the 2nd network
interface. Set the needed data-lanes in the pcie3 phy and enable
the second pcie controller, as well as remove the bifurcation comment.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 889838b4079ae..0636a08986572 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -78,16 +78,23 @@ rgmii_phy0: ethernet-phy@0 {
 };
 
 &pcie30phy {
+	data-lanes = <1 2>;
 	status = "okay";
 };
 
 &pcie3x1 {
-	/* The downstream dts has: rockchip,bifurcation, XXX: find out what this is about */
 	reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";
 };
 
+&pcie3x2 {
+	num-lanes = <1>;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.39.2


