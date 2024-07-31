Return-Path: <linux-kernel+bounces-268484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D758094252D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA3AB249EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B918AF9;
	Wed, 31 Jul 2024 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A3WuqnrO"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3B224FD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397473; cv=none; b=mvQTQfm3DIJ7yqs1Ir/OFhb2Pj0D3uzog4qjDF+g9UVEuOu0lMTPKH3BQzAsD53iCYH0nQ1YWOA3+Mn+VZVyK1U95KC8/SndSIkfeqOr9JmTCzXWaqXhmY2+UgJXhQCpnuRcASQUIY6lfMvsSReQjCELOq/cYwFrqjvT/qnSToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397473; c=relaxed/simple;
	bh=gPolkV+EX7nmy7kNMGgP7tD89yoOsnJDPteKeh8TDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQtQ4i/LXGvBHvts3pdX9nuuKnRh6891T3wx7MDNhp10+GEx40mpwscjuon3CfmjChko7u6XfNjQn0D07idBYpR45JmvguGqd3JtOO1tOgZyE1c3VQI49aaTnW6RQPQAUZ/2gX/q/aVIyZEm3j/7BaVW/gshDt6mjkl6lTSljS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A3WuqnrO; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-250ca14422aso3289479fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722397470; x=1723002270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11m/HeUZui+l9rC09B4iar2D4HclxMkveTVuMFSiXTE=;
        b=A3WuqnrO8mRF3nKdq1wLIWEjECWYQdRBi+Z9u3TFGgbmyiMxCVaK3O5H/gnc622Yhl
         yYmIm782u8+op9XDlQP4zhHjwsvT2HktC5IKja+AIRbV86DQSanJKSQw0LbZpyhMI1bF
         17LIzE3ZgwrN4nhIv8NUz+DqO1FkgzMgvfTNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722397470; x=1723002270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11m/HeUZui+l9rC09B4iar2D4HclxMkveTVuMFSiXTE=;
        b=M4o3MS/AvGYnYVrr+yTO9R/NtMCzBZWel6eVwao5V2Af3quQ55VUtWlBGlxo2AEXET
         gmneW3uc0WJ9xBscAZlHPc2Ygwm7OyaJhqX+M8P3eSXh6QHvYTvTWnh00dxRMq5oMNW9
         FbQ8pJSFT/giTJ/mXoxWgmXIyxQro/woD5/TndAE9CPp7lRZGPEpgU1OYjET+GZ8CVTN
         8q7uYlcVNabSJAapnM1RTpi6ulnLvBkPFThE1+r/SV5/nrV09FGwOyvEoz8kmFWXqXkN
         wJErACq0917Tdl3k/y0DFKquv5ZrbG7vyp+WKiw6T+19Zk0WsfM+4gjHU6fQFblAMCLt
         eDDg==
X-Forwarded-Encrypted: i=1; AJvYcCW46MR1eICpY7OuNk4FzYmR+2LUGlFzb0+4XEhMN5nQz5RvzF3R23rg/6rZb/5LS1xsGAyDWEU/rJ6dE+mmCKphxgrRojO9CGZKphEQ
X-Gm-Message-State: AOJu0Yyoafos3iWDm1AA/knCGWCxYtfFovbST6S8j/ieX/MKltlVbYpr
	EuQdBJjh+f9jOFBtGMgLFzjn5S8FWZ7PMbu1WohJFSzzyuYIgj1f7rCqrgrdFw==
X-Google-Smtp-Source: AGHT+IEy47mf3dU8J89PBwPURHRmTajXHBhlXBEf4nsrJgQUp+s+hvQeYpO0EE6KZSG0treE+Z4MAg==
X-Received: by 2002:a05:6870:2cc:b0:261:113c:1507 with SMTP id 586e51a60fabf-267d4d5b51amr15027926fac.20.1722397470604;
        Tue, 30 Jul 2024 20:44:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1cfb:e012:babc:3f68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead81230bsm9093008b3a.120.2024.07.30.20.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 20:44:30 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH 3/3] arm64: dts: mediatek: mt8195: Assign USB 3.0 PHY to xhci1 by default
Date: Wed, 31 Jul 2024 11:44:10 +0800
Message-ID: <20240731034411.371178-4-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240731034411.371178-1-wenst@chromium.org>
References: <20240731034411.371178-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xhci1 has both USB 2.0 and USB 3.0 host capabilities. By default both
are assumed to be enabled when the controller is enabled. To disable
either one, an extra property is used.

Since the default has both enabled, both PHYs should also be assigned
to the host controller. If a specific design uses only either one,
the board specific dts file can override the PHY assignment together
with adding the "mediatek,u[23]p-dis-msk" property. This keeps both
changes together.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi               | 1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                      | 2 +-
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts        | 2 --
 arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts | 1 +
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts         | 1 +
 5 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index d3a52acbe48a..c98fe9a39b90 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1401,6 +1401,7 @@ &xhci0 {
 &xhci1 {
 	status = "okay";
 
+	phys = <&u2port1 PHY_TYPE_USB2>;
 	rx-fifo-depth = <3072>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2ee45752583c..61b3c202a8cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1444,7 +1444,7 @@ xhci1: usb@11290000 {
 			      <0 0x11293e00 0 0x0100>;
 			reg-names = "mac", "ippc";
 			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
-			phys = <&u2port1 PHY_TYPE_USB2>;
+			phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
 			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
 					  <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
 			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index a06610fff8ad..1ef6262b65c9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -904,8 +904,6 @@ &xhci0 {
 };
 
 &xhci1 {
-	phys = <&u2port1 PHY_TYPE_USB2>,
-	       <&u3port1 PHY_TYPE_USB3>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
index e4b2af9489a8..e2e75b8ff918 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
@@ -1111,6 +1111,7 @@ &xhci0 {
 
 /* USB2.0 M.2 Key-B */
 &xhci1 {
+	phys = <&u2port1 PHY_TYPE_USB2>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	mediatek,u3p-dis-msk = <0x01>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 096fa999aa59..14ec970c4e49 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -894,6 +894,7 @@ &xhci0 {
 };
 
 &xhci1 {
+	phys = <&u2port1 PHY_TYPE_USB2>;
 	/* MT7921's USB Bluetooth has issues with USB2 LPM */
 	usb2-lpm-disable;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
-- 
2.46.0.rc1.232.g9752f9e123-goog


