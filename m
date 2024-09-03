Return-Path: <linux-kernel+bounces-312194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3F96935C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9286282134
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615311CEABE;
	Tue,  3 Sep 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sgqih19M"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A113D52F;
	Tue,  3 Sep 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725343067; cv=none; b=crSh12t+OTiYCbHYMdpfStIXtAbJg+70wUbKQtp2UGV4xVqbvmhJfbmso/0S/382qZRWvzRMCdqzpNVhRWyZ6jwbR7W+/d4M6nuAEgPe929obSOOwy3s+qjJ3Vnv8RFjSd39NwF1f7wXN+S9dqdnIr8F4XSNDvyJVlieUb1/xN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725343067; c=relaxed/simple;
	bh=CK3l+CFCVFOKNCXEs/9xULmuz12/QOuK8IRh5AapJRU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yp49gxrBCaam+VoNJVQYmWzkHrR7DIZXiOXcMZPqtEMdSmzxnRUBaG+vjDVubTJit/Gn+QrGR6Ojh5EE92ZecCFgNROlX27xHbBqz03aphE1c7ArLlOndguDfzWs5MC2x5l2eFip+NkRQjKzkHuDGsRQ1rTCvJvinaW84rJxXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sgqih19M; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4835vbxN010841;
	Tue, 3 Sep 2024 00:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725343057;
	bh=wVA6uwihsdJgJxG4Hswmxz0Cf/vNlzUVXBJeRz9FCHo=;
	h=From:To:CC:Subject:Date;
	b=Sgqih19M2oQ5olB3ZvyeQMpaoGH4gdOmK7dO0EHTbTZt231+r1xOy4QR7Z3xI78Hy
	 +OPgHhn/Qb0bPXbogQHE+qE0su58YQQkE3kI9/NidmrOHk9+tl8CmOSplP6iqc6ghI
	 ttpHYLaH3wgfokNCL5K8InbRU1MeZoC7Fq0wtHC0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4835vbgx111125
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 00:57:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 00:57:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 00:57:36 -0500
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4835vXLi050437;
	Tue, 3 Sep 2024 00:57:34 -0500
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-*: Add GPIO INTR region in ranges
Date: Tue, 3 Sep 2024 11:27:33 +0530
Message-ID: <20240903055733.3483840-1-vaishnav.a@ti.com>
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

Add GPIO Interrupt Router regions in ranges. Although not currently used
by the Linux TI-SCI INTR driver, these regions should be included in the
ranges mapping.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

This was observed while trying to boot Xen hypervisor on these platforms
and the mapping failed due to missing GPIO INTR region.

Keeping all platforms changes in single patch as it is identical and trivial.

 arch/arm64/boot/dts/ti/k3-am62.dtsi   | 1 +
 arch/arm64/boot/dts/ti/k3-am62a.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-am62p.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-am64.dtsi   | 1 +
 arch/arm64/boot/dts/ti/k3-j7200.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-j722s.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi | 1 +
 9 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index bfb55ca11323..656f748bd1f6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -57,6 +57,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
 			 <0x00 0x0070c000 0x00 0x0070c000 0x00 0x00000200>, /* USB1 debug trace */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
index 4d79b3e9486a..e98af438f57e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
@@ -56,6 +56,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
 			 <0x00 0x0070c000 0x00 0x0070c000 0x00 0x00000200>, /* USB1 debug trace */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11..7bd941233b66 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -55,6 +55,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
 			 <0x00 0x0070c000 0x00 0x0070c000 0x00 0x00000200>, /* USB1 debug trace */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 74e56cc68d46..48eb1ab72d5c 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -54,6 +54,7 @@ cbass_main: bus@f4000 {
 		ranges = <0x00 0x000f4000 0x00 0x000f4000 0x00 0x000002d0>, /* PINCTRL */
 			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
 			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index d411911fdf71..2a981557ff71 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -113,6 +113,7 @@ cbass_main: bus@100000 {
 		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
 			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index a7f2f52f42f7..e32067f60433 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -115,6 +115,7 @@ cbass_main: bus@100000 {
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
 			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
 			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
 			 <0x00 0x06000000 0x00 0x06000000 0x00 0x00400000>, /* USBSS0 */
 			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
index ea16f82822ae..bb8f1e547537 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -118,6 +118,7 @@ cbass_main: bus@100000 {
 		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
 			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
 			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe Core*/
 			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index 14c6c6a332ef..94bc73d92a90 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -148,6 +148,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
 			 <0x00 0x0070c000 0x00 0x0070c000 0x00 0x00000200>, /* USB1 debug trace */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 5e84c6b4f5ad..7c744311cc5e 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -235,6 +235,7 @@ cbass_main: bus@100000 {
 		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
 			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
+			 <0x00 0x00a00000 0x00 0x00a00000 0x00 0x00000800>, /* GPIO INTR */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
 			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
 			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
-- 
2.34.1


