Return-Path: <linux-kernel+bounces-258274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0089385B0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD561F21BF4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F0716C6AC;
	Sun, 21 Jul 2024 17:37:38 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFD1684AD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583457; cv=none; b=Hf95XgpUaK5T3vBNO7jvTOp7AkGdYVSmETrkQCj8w2np2/QaIHzPn70g181UUfV+hCOncRAozdCS7i2eAnrywJwjNXzeSBi+0Ao/96XulMVklAYkAGTb6S03TXLkwHpL8+roCXj6iCFKQwFNNi6bKLEov4Jp+7DBYVNBJV3aDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583457; c=relaxed/simple;
	bh=/Pr1VvO4TiEqywd+xj5UOg5mdJyTkmGos5iYdgrijwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nyBP3G5O5rRJFcaRB7Ew23AcHQg2T4UpCDzWCreUTTTm/5T6s4HB13rVgiG7X6tZl+fhQ8PH4eAD2DOyqjUmqfuqY19byb11K83DNM6iIpReYZKK29Gs0Tq8pH+yzPfGut15ZD7C5WgwQ3bFz2+Px4XxSZLvlyU9mKYUhJml3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVaUz-00075D-Qj; Sun, 21 Jul 2024 19:37:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/14] arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
Date: Sun, 21 Jul 2024 19:37:11 +0200
Message-Id: <20240721173723.919961-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240721173723.919961-1-heiko@sntech.de>
References: <20240721173723.919961-1-heiko@sntech.de>
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


