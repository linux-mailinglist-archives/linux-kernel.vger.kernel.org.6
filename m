Return-Path: <linux-kernel+bounces-344901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8C98AF6E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F011F23F87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3418873D;
	Mon, 30 Sep 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yqSuyKJl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAB183CD1;
	Mon, 30 Sep 2024 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733010; cv=none; b=Fcp3X1VMVzDYtH29vSgv+YO5ECwMC9NFNtGFPwdFoBkiSGd6oyRXWqlwkzmENFfOrjOkhjY5jipMM5nLwozYF13fYAOSlfndNRBGJ54fPN1IPGKwhLLze4m/6/6W/Sa+kyg+bN3f5Fc2pw9bJB+Vnd1X0bsbczwHAIAgQvvWguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733010; c=relaxed/simple;
	bh=77thQejIj2seuyPObLi0fp30+zVU5/UZ5IUX2RN4Y4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf8y61v5zVpnGpuQHFqAYoSTn847KQ3bBi5Hg3RBJe4xa2XMT3hw7a+CyuVnb/xvQml0WtQnWPHf0l1ybkZ7j/dldhvMGOrNsB/kbSMZjqFeqTMLqerU6kEthyv7Lj82hofdVtdAHZi294IE2m5YqQUOjqoDhDWShdnzklmWyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yqSuyKJl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=67sg7Ye9a21J/nowWZO0/sx465l3e+f9MizgGd/B0fE=; b=yqSuyKJlzVat96wNbj32y+LQxs
	UIKUA29+XkVyLasf0wKmuEV2ofh4wP3SlCiFW2bCOnRzfzI6X4zBJOvEbqMEg15P3sJ4IfeDUNo9q
	qdiOX1r8Kt6xrNvdzxYWOmPwpo0PjExER2VQvw5tbkX7QQQNf7DYnDrU5B0UyHnhF38Kqi2idCpbp
	/7h+ayJOOdeiup2nYk+bj6Cfc1+hzAupdUY6KxCdMLmPO1e04eoNcTyurJkyPgrqgM1Rosi+DxehM
	cyM2K0HRLFrx7ae/q6aqdjaArm8a8uNO2+hBMACrf0aeXjCs/6HXRclruuv0u0pb0tFBE2yBjGv0M
	Y0z33w8A==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svOHM-0008So-45; Mon, 30 Sep 2024 23:50:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jbx6244@gmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: rockchip: fix compatible string rk3328 cru node
Date: Mon, 30 Sep 2024 23:50:00 +0200
Message-ID: <20240930215001.1999212-3-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930215001.1999212-1-heiko@sntech.de>
References: <20240930215001.1999212-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

The cru node references undocumented compatibles of "rockchip,cru" and also
marks it as syscon.

A general rockchip,cru is way too generic to ever be used anywhere, so
needs to go away, similarly the cru should not be written to from other
places, instead regular clock routines should be used.

Both mainline Linux as well as the vendor-kernel up to their 6.1 branch
only reference the cru via the normal assigned-clocks, clocks and resets
properties and do not get a syscon from the node.

Similarly, there is no syscon access by compatible both in mainline
nor the vendor-kernel up to their 6.1 branch, through either the
rockchip,rk3328-cru nor rockchip,cru compatibles.

So these two really are unused in all publically visible places.

Sidenote: the vendor-kernel does pretty crazy stuff in the camera interface
and tdm driver, where they map the cru separately and set clock muxes and
gates directly. This should of course never reach mainline anyway.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
[update commit message, to explain the unused compatibles]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 16b4faa22e4f..cf98f1af659e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -813,7 +813,7 @@ hdmiphy: phy@ff430000 {
 	};
 
 	cru: clock-controller@ff440000 {
-		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
+		compatible = "rockchip,rk3328-cru";
 		reg = <0x0 0xff440000 0x0 0x1000>;
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
-- 
2.43.0


