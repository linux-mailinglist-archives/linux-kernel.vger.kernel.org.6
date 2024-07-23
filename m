Return-Path: <linux-kernel+bounces-260365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13793A7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDAF1C22653
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD80143894;
	Tue, 23 Jul 2024 19:55:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421FA13D62B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764551; cv=none; b=tdSRAl14mrFam2jtgHHklUnycB4KyHWiBq5sDBK0fhegLt10l+6bWPPBFBw/ViVoVXeRrzxK9pa00nDse+kox32JN8xuORazjPavUHF/8pEO8YQU4mMtDJ076EB7k+cKXtDI7Sswaxdfy79tbW7sx8Ae+99Ygqk++SbhHvrGyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764551; c=relaxed/simple;
	bh=YVs+8aAqrE+NDiYPiMbXaVauajNFuoRuWlOsHReNkBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMeAhnYtryIT2P9mMoK92hKvu8vr2wNs9Oy9fBvYhtp8wschpetjAS7DnrwGYmiqUuqF2uoki/1QLvSk6sftFZs+94fzk6oJeplbTFwf8yP/AJ+S1AhtQ4hWX2g2smoxBhKJZQTetoI8Cp9wz2fWESrs2zhb80NCjmidad7wM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWLbs-0005iD-Co; Tue, 23 Jul 2024 21:55:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] arm64: dts: rockchip: enable second PCIe controller on the Qnap-TS433
Date: Tue, 23 Jul 2024 21:55:26 +0200
Message-Id: <20240723195538.1133436-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723195538.1133436-1-heiko@sntech.de>
References: <20240723195538.1133436-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The TS433 uses both pcie controllers for sata and the 2nd network
interface. Set the needed data-lanes in the pcie3 phy and enable
the second pcie controller, as well as remove the bifurcation comment.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 07b4f095d766a..9bf9c3b65ca31 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -78,17 +78,25 @@ rgmii_phy0: ethernet-phy@0 {
 };
 
 &pcie30phy {
+	data-lanes = <1 2>;
 	status = "okay";
 };
 
 /* Connected to a JMicron AHCI SATA controller */
 &pcie3x1 {
-	/* The downstream dts has: rockchip,bifurcation, XXX: find out what this is about */
 	reset-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";
 };
 
+/* Connected to the 2.5G NIC for the upper network jack */
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


