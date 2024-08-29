Return-Path: <linux-kernel+bounces-306268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE82963C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D261F22FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA611662F1;
	Thu, 29 Aug 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NTztu0zm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF1E16B753;
	Thu, 29 Aug 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915547; cv=none; b=h5+1NHYramkLjz7+jSA/MgGwk23SKKYz3r4eyRMkfu62q1BkJcO1sQ+5SbsUdDh9Ly/q9i5+s9FYAar95DQbExERBoZm5KZBlfa2mFomdP+eTrH21FBRdkPidFm3Ku8/6VaQv36dDTYIWx3sF3ISGWX4EvJiB3FK8WzdQRrWfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915547; c=relaxed/simple;
	bh=aBWRtbSZT4s73kk5nl2+Zz32BWbRNLEpbcZkj21tZYo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n6eWV8j4DMweHDRG4Leqdl55fDCEpHwDN8TaxJOEZce80XLMi09S56pFmFK16QN15/K60KkWM6UH9GzllYCSEyOGBOI1u4rFH1c4sNsDSPU9tR1q7ATd6EAbiO3InJj2XbxHT0MFlQL46VQ6nCaq8SU3IQbVAljVjUNW0t/3r6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NTztu0zm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T7CF7x112857;
	Thu, 29 Aug 2024 02:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724915535;
	bh=2tFfZD/rbw4xrd8AyGCjpUB0HEr6qWkNdgnQvWl+Ls8=;
	h=From:To:CC:Subject:Date;
	b=NTztu0zmdwRKyp45Y0Ap+gms5vQg/9iPWPt3sr4UVb2eXytyQTWNfftLHvRwOkd+7
	 +aRZkkeu8uulVl1lP6S9AB7uJ7YyqgsAokKKAW/GCSYXGqu68QE459kLBCJ9YdFtWq
	 HPY53hx/qCquDhi/CJkf7CWFKLdXt9S4sCxzzeyg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T7CFbl021642
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 02:12:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 02:12:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 02:12:15 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T7CBei064345;
	Thu, 29 Aug 2024 02:12:11 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mranostay@ti.com>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j7200: Fix register map for main domain pmx
Date: Thu, 29 Aug 2024 12:42:08 +0530
Message-ID: <20240829071208.2172825-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Jared McArthur <j-mcarthur@ti.com>

Commit 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux
range") split the main_pmx0 into two nodes: main_pmx0 and main_pmx1
due to a non-addressable region, but incorrectly represented the
ranges. As a result, the memory map for the pinctrl is incorrect. Fix
this by introducing the correct ranges.

The ranges are taken from the J7200 TRM (Table 5-695. CTRL_MMR0
Registers). Padconfig registers stretch from 0x11c000 to 0x11c168
with non-addressable portions from 0x11c10c to 0x11c10f, 0x11x114 to
0x11c11b, and 0x11c128 to 0x11c163.

Link: https://www.ti.com/lit/ug/spruiu1c/spruiu1c.pdf (TRM)
Fixes: 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux range")
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 22 +++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 6593c5da82c0..df39f2b1ff6b 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -254,7 +254,7 @@ J721E_IOPAD(0x38, PIN_OUTPUT, 0) /* (Y21) MCAN3_TX */
 	};
 };
 
-&main_pmx1 {
+&main_pmx2 {
 	main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 9386bf3ef9f6..41adfa64418d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -426,10 +426,28 @@ main_pmx0: pinctrl@11c000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	main_pmx1: pinctrl@11c11c {
+	main_pmx1: pinctrl@11c110 {
 		compatible = "ti,j7200-padconf", "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x11c11c 0x00 0xc>;
+		reg = <0x00 0x11c110 0x00 0x004>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_pmx2: pinctrl@11c11c {
+		compatible = "ti,j7200-padconf", "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x11c11c 0x00 0x00c>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_pmx3: pinctrl@11c164 {
+		compatible = "ti,j7200-padconf", "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x11c164 0x00 0x008>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.34.1


