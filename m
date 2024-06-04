Return-Path: <linux-kernel+bounces-200454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ED78FB041
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3907281502
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1C146581;
	Tue,  4 Jun 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fZ928gOv"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA61448EE;
	Tue,  4 Jun 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497879; cv=none; b=GsCjaBhJBCmGvsQp8qJ9AalMlirBfepSLBnKJrliXKeY9W0YTjEsp+Vzatl4zYTyN2rKQXwHtvsVHegKsfZ+nKs/SE+Cnws86UZYCrAMlxwsDwkVIXVQAnKmtQrcZYGvgNOupX+1fjll+H+myijoYCzND8KTVknzwwtJJqJVKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497879; c=relaxed/simple;
	bh=WC72mgdBPuGdNcigkmv9eIIV8NhQG9m2XoiBYTPjcyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+G26byNVDY6bVqH3BwvXSztcj2Aq4drrxdDLoEVRMNbcy0J3GqnxcHqHkEPQyVoBI22xJfI8tCSHfLZNWtvWcfoiR4EuqNNBiThlofie7Nd/JcuA7Us3g2yasy8kH7D9BxshlAKS8u+egWvEtWwsj1Jc8wJxNV9Q1/5g/Ez5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fZ928gOv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 454AiTmR103007;
	Tue, 4 Jun 2024 05:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717497869;
	bh=nezdJ3Z2zPJTiy12m4C6hmB+BU4Dij+DiP2Sa9MiMTo=;
	h=From:To:CC:Subject:Date;
	b=fZ928gOvYz7rbriJkTPNGmJ6XarluOPVdKMahhCPVsyi8oyl4LKw7rC14xA18VT2s
	 9j2Rhu5DXqZmBcrQkkozVxEMb7Op+40kCjoFOCpZD48OQK8fH15T6RyC0hPS2bClW+
	 3SCINR2Ph+2eTkant7M5NaZzFVrRepEtgWoij+MQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 454AiTL0027856
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 05:44:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 05:44:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 05:44:29 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 454AiPOa108836;
	Tue, 4 Jun 2024 05:44:26 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4] arm64: dts: ti: k3-am62p: use eFuse MAC Address for CPSW3G Port 1
Date: Tue, 4 Jun 2024 16:14:25 +0530
Message-ID: <20240604104425.3770037-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the "ethernet-mac-syscon" node within "wkup_conf" node corresponding to
the CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the
compatible "ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations
on these registers. The MAC Address programmed in the eFuse is accessible
through the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree
property points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver
to fetch the MAC Address and assign it to the network interface associated
with CPSW3G MAC Port 1.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Hello,

This patch is based on linux-next tagged next-20240604.
v3 of this patch is at:
https://lore.kernel.org/r/20240404124614.891416-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on next-20240604.
- Collected Acked-by tag.

This patch no longer has any dependencies since the dependent patch
mentioned in v3 which is:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
has been merged.

Test Logs on AM62p:
https://gist.github.com/Siddharth-Vadapalli-at-TI/d804e1b1cbd0a32bc8d563923f3211c0

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 1 +
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 900d1f9530a2..22f8f1359bc5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -749,6 +749,7 @@ cpsw_port1: port@1 {
 				label = "port1";
 				phys = <&phy_gmii_sel 1>;
 				mac-address = [00 00 00 00 00 00];
+				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index c71d9624ea27..71784e10b4f1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -19,6 +19,11 @@ chipid: chipid@14 {
 			bootph-all;
 		};
 
+		cpsw_mac_syscon: ethernet-mac-syscon@200 {
+			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+			reg = <0x200 0x8>;
+		};
+
 		usb0_phy_ctrl: syscon@4008 {
 			compatible = "ti,am62-usb-phy-ctrl", "syscon";
 			reg = <0x4008 0x4>;
-- 
2.40.1


