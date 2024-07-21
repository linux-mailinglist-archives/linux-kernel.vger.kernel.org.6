Return-Path: <linux-kernel+bounces-258269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB69385AB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23491F210BC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5C16A95F;
	Sun, 21 Jul 2024 17:37:36 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92C166317
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721583456; cv=none; b=jxOAEFSdRwqEAlARp8gl6Iv6o+v0XdcaSM7+N1WWZTYzlExo4hTkM7WjOokeVCI1s+ayII0YSMNc7fCC7Bh4C931mVJjJdiGrNHK4tSk1luJEJCjUnRCa/amvVlyNE/r03W19ESOqlEL9lsHYZzJUdv2yyr8CjF05RfCSMwxjdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721583456; c=relaxed/simple;
	bh=k2xwrQmpLI0Hzih9FDsmGvU/ZBxT4sS3QPudM+IxFkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UA7aiycd7uT6xv0YlH46f8E8UuFLv6FZb+cXVQv5y6VvHaNzdF+/vXLM8uzFR21nOa3JWWuX1cdA9ZXCXt3TACBpBx3OLoKwlIKNmdvg8Ay9sCJFZrJX9MEKpWIM4zKd293Zac6LWU0bot7RWAy+qjQah2kxxBpZTCOYBF+MAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVaV0-00075D-W0; Sun, 21 Jul 2024 19:37:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] arm64: dts: rockchip: enable sata1+2 on Qnap-TS433
Date: Sun, 21 Jul 2024 19:37:15 +0200
Message-Id: <20240721173723.919961-7-heiko@sntech.de>
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


