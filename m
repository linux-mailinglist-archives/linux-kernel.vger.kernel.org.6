Return-Path: <linux-kernel+bounces-340316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0998717A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB891C20CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F731AD3E8;
	Thu, 26 Sep 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a81soMie"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDD17BB30;
	Thu, 26 Sep 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346382; cv=none; b=e8UNTnGsgCt0xr+zYSkygdvJFxXzzihDWiAsW2RxxrlDMj9hobuOTu9aIG7uiMGAyDln3+NYbmgkahqGnwfyZGAfzhhybtjkgI7gOgLRV+VgHNOTXBpVhqqTfhNrXiqKuF6J+vyTRIPyWmC+zVIHPODIj/HA6CH28uCrpUZIqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346382; c=relaxed/simple;
	bh=n/OnCOMQpH7yJoun9cx3L1qSfqtkSEskvdDm3Mlu0DA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdv61PKWyq39o+pIQeohyYGRHTM8h+QGNu8pxbmDCcxhoRJHVAof/6SyDswKdlNUbEAjTRu94jj/ULvqMKAG9nz69QAh+i7TvlpZq7aXQRwM5u9MZahg9h3JcMTbm64HPmxtEhPB8GttBnQu9fQ05uEKIHtXbpwO8JH+1L0hE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a81soMie; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48QAQAKR001304;
	Thu, 26 Sep 2024 05:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727346370;
	bh=93SVfvx8unRQzfXSqspJM+q3lBL9z0dAs26DFmVqSeo=;
	h=From:To:CC:Subject:Date;
	b=a81soMie7a0VNvz+4DpZHXrbSK8pB9rnsqIDip1/AclOnkPdE0X3VVZtDNxKIBFlZ
	 buxMt8lIZfkoitW/CBoGXVnfq/5dpomx6dqzWoF0Q0uwpRavRSbUSbbiYcrKrcyGHa
	 rq2QtcNHe39s7c3pwAOUS06IOuvjbgiVJjjdKV4o=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48QAQARN124558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 05:26:10 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 05:26:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 05:26:09 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48QAQ5rr057254;
	Thu, 26 Sep 2024 05:26:06 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mranostay@ti.com>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j7200: Fix register map for main domain pmx
Date: Thu, 26 Sep 2024 15:55:33 +0530
Message-ID: <20240926102533.398139-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Jared McArthur <j-mcarthur@ti.com>

Commit 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux
range") split the main_pmx0 into two nodes: main_pmx0 and main_pmx1
due to a non-addressable region, but incorrectly represented the
ranges. As a result, the memory map for the pinctrl is incorrect. Fix
this by introducing the correct ranges.

The ranges are taken from the J7200 TRM [1] (Table 5-695. CTRL_MMR0
Registers).

Padconfig starting addresses and ranges:
-  0 to 66: 0x11c000, 0x10c
-       68: 0x11c110, 0x004
- 71 to 73: 0x11c11c, 0x00c
- 89 to 90: 0x11c164, 0x008

The datasheet [2] doesn't contain PADCONFIG63 (Table 6-106. Pin
Multiplexing), but the pin is necessary for enabling the MMC1 CLKLP
pad loopback and should be included in the pinmux register map.

Due to the change in pinmux node addresses, change the pinmux node for
the USB0_DRVVBUS pin to main_pmx2. The offset has not changed since the
new main_pmx2 node has the same base address and range as the original
main_pmx1 node. All other pinmuxing done within J7200 dts or dtso files
only uses main_pmx0 which has not changed.

[1] https://www.ti.com/lit/pdf/spruiu1
[2] https://www.ti.com/lit/gpn/dra821u

Fixes: 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux range")
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
---
Changes in v2:
- Explains why PADCONFIG63 is included in the pinmux ranges when it
  doesn't appear in the datasheet.

* Nishanth
- Use cannonical links in commit msg for the TRM and Datasheet
- Explains the reason for the offset not changing for the USB0_DRVVBUS
  pin and why there are no changes to other pins.

- Link to v1: https://lore.kernel.org/all/20240829071208.2172825-1-a-limaye@ti.com/
---
 .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 22 +++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 6593c5da82c06..df39f2b1ff6ba 100644
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
index 9386bf3ef9f68..41adfa64418d0 100644
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


