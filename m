Return-Path: <linux-kernel+bounces-258065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58469382E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 23:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E191F22213
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0CA14A0AD;
	Sat, 20 Jul 2024 21:09:12 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4314882D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721509752; cv=none; b=qlkKxxE83vpG5A2ANGU73MyFShft4LcCur1jTvfX3qBrHtYXDUy60aihxBdKXRg9unN/ZXwlsG1uouj7Le3sfBOtwwRT4t+I3p97Yy0+Y9IH3btb8hKIstff2a+RGqxHYQgqHJ2OSZ92yxJVNv89/mF5/1aZ08pQ8SFKMdHTgk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721509752; c=relaxed/simple;
	bh=k2xwrQmpLI0Hzih9FDsmGvU/ZBxT4sS3QPudM+IxFkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2Y77LVUBgG9ikOucw64b4yv49pE6eRC12TXdLqh5gwSkSQ4fkHkNH/Gg09jm8vm6TlcRo+pFCihP9lfmSkUMRY3UNzPqHKWYPjOtkSx6E4dOkl9JBsrTrfF6vwGHkolHDjwCXJoueyzmNd9NLS5AMTQjvPkY7tNsB2j7SVOEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVHKD-00061D-Ha; Sat, 20 Jul 2024 23:09:05 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
Date: Sat, 20 Jul 2024 23:08:54 +0200
Message-Id: <20240720210856.778014-9-heiko@sntech.de>
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

The TS433 has 4 bays. The last two are accessed via a pci-connected
sata controller, while the first two are accessed via the rk3568's
sata controllers. Enable these two now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 4fbbdb735eb58..69bed01cbe4ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -80,6 +80,16 @@ &combphy0 {
 	status = "okay";
 };
 
+/* connected to sata1 */
+&combphy1 {
+	status = "okay";
+};
+
+/* connected to sata2 */
+&combphy2 {
+	status = "okay";
+};
+
 &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
@@ -154,6 +164,14 @@ vcc5v0_otg_en: vcc5v0-otg-en {
 	};
 };
 
+&sata1 {
+	status = "okay";
+};
+
+&sata2 {
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.39.2


