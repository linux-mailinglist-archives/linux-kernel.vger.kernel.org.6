Return-Path: <linux-kernel+bounces-364670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8207199D7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEDF28438C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1271CFEA9;
	Mon, 14 Oct 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MxNGJpE5"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FF1C2DB0;
	Mon, 14 Oct 2024 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728935252; cv=none; b=MeokCGs2f1AUAFXUGAqRmk0NV3JzBHuTM5SBVkRj37TdyS46NMm48KbRJLBbQUuhJvlfcNVg6rohZ4jjgEw3M5Tz5mIkWQR1fd29SgdHHA9jILWXQze6yLAMWZ0FZbIQJHPXOI2XpCT4N451o5slVujW/K0EPJC6qGg7FkX75+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728935252; c=relaxed/simple;
	bh=fgP3lC8Cue3uRjcsaZ58dxyULkfZK4nH32kxg7ZAOsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+Wkvi1qEjgf0QTR6mp9l7IhgjN1GjiKVcYRmafCQYz2z2Ix0l4/LVwI0zE29cZTSTzFasuhe73EK/HBeMFJiWrCi+juoWrwPXqDMjFl9D0QPUHxx/YaskUuMNtsdsnf9MW1O0iyH8KV9J4376xvE5neGScLE4ufGaML/BJC0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MxNGJpE5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EJlN1O022644;
	Mon, 14 Oct 2024 14:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728935243;
	bh=XFYix9QSnw7P9Q2WomFqXPBRxSQ9YH8/tWQ1pxHZynU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MxNGJpE5YBTuNqkc9nE0B3prSvd+69Bl34+nQ2S6HgaDW3NsykzDWYEJe75AFEZp2
	 ZbEJ/L9+YpLTqrMO6SwH7NyHFshXWOV9gksNTiSdLRdMc2jmmsKiPv+byBqbwThvgA
	 d59j6JR08qy3VJdf2DBBoRIE61T0O765mtBVlv0s=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49EJlNNK016776
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 14:47:23 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 14:47:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 14:47:22 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EJlM9Y002469;
	Mon, 14 Oct 2024 14:47:22 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Judith
 Mendez <jm@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am6*: Remove disable-wp for eMMC
Date: Mon, 14 Oct 2024 14:47:20 -0500
Message-ID: <20241014194722.358444-2-jm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014194722.358444-1-jm@ti.com>
References: <20241014194722.358444-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Remove disable-wp flag for eMMC nodes since this flag is
only applicable to SD.

For eMMC, this flag should be ignored but lets remove
anyways to cleanup sdhci nodes.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 1 -
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 1 -
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 1 -
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 1 -
 arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 1 -
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 70de288d728e4..092d7713e6209 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -820,7 +820,6 @@ &sdhci0 {
 	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
-	disable-wp;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 67faf46d7a35a..748cd7ac2646e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -602,7 +602,6 @@ &sdhci0 {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 };
 
 &sdhci1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 3efa12bb72546..efedf226addcb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -445,7 +445,6 @@ &main_i2c2 {
 &sdhci0 {
 	status = "okay";
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 44ff67b6bf1e4..e903382c0caba 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -418,7 +418,6 @@ &sdhci0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 };
 
 &sdhci1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 97ca16f00cd26..95c20e39342cc 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -584,7 +584,6 @@ &sdhci0 {
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index aa7139cc8a92b..c30425960398e 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -456,7 +456,6 @@ &sdhci0 {
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 /*
-- 
2.47.0


