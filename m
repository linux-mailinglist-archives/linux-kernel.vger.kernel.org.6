Return-Path: <linux-kernel+bounces-341672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D2988361
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C73282060
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF57189F5C;
	Fri, 27 Sep 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="AML2FVtg"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FCE1898E6
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436877; cv=none; b=u4Uw5691IqbN62Suce1f6J88dmhQejK3vIp+ARxmrre5hZiedqvDG1xK82snbXQYLdyKbI6roa5stX7tpBtMApBgHi93GoRdj3d63l6jsStFVniH4kNxSczDN0ps4HrDRjoJrkA5PVCUtfaxz1nLI88UIvsb9kdKzZSof75g7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436877; c=relaxed/simple;
	bh=mLnVJ+RCBSll6397HDYIxG0p1+y9qDqy/rM7C01/DGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tQeYllXBsapHH9S5gQ0NXcH3GW2i0vKp6ulJTIeUVTyGzjGQXva7f4//U6y7vFEstgKAShqQsJc7XP5yXeQAccRNxHHHRG3prMP5ILjtJ5cFKyHBP9FRES2eZoctz5vPTXy+50pJrBtm9gd/jKy95jEPqK9QN0Ad/KMTjkQHvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=AML2FVtg; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727436863; x=1730028863;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mLnVJ+RCBSll6397HDYIxG0p1+y9qDqy/rM7C01/DGk=;
	b=AML2FVtgwwsUgjOAkwAR9yRqA3DYNfb1tiKPe50GkSo9yKARlEd+0SbtaLkqnPVs
	3PMMDKvQYgvnoJByMA3kTBYNHsnI470UEll1klIdRlRf7YnpHEOhkPMJNEi1uX8H
	tMnBtMWtuWVKyUJPKMAH+EB/yEY3vNmEYxq149OmBuc=;
X-AuditID: ac14000a-4577e70000004e2a-f4-66f6983f8091
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 04.AA.20010.F3896F66; Fri, 27 Sep 2024 13:34:23 +0200 (CEST)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 27 Sep
 2024 13:34:23 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 27 Sep 2024 13:34:16 +0200
Subject: [PATCH] arm64: dts: imx8mp-phyboard-pollux-rdk: update
 gpio-line-names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240927-wip-bhahn-update_gpio_lines-v1-1-49aca212e25a@phytec.de>
X-B4-Tracking: v=1; b=H4sIADeY9mYC/x3MSwqAIBAA0KvErBswK/pcJSIspxwIE+0H0d2Tl
 m/zHgjkmQK0yQOeTg682YgsTWAyyi6ErKNBClmIRpZ4scPRKGPxcFrtNCyOt2FlSwHzuprVJGr
 KdQVxcJ5mvv+969/3A1wcBuxtAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Teresa Remmet
	<t.remmet@phytec.de>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727436863; l=2230;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=mLnVJ+RCBSll6397HDYIxG0p1+y9qDqy/rM7C01/DGk=;
 b=1JTTL5w+Ysf2NDXnsTQKYgK8LBQoP7X4qcSWb2sYtvFIodHDs80v/KwDPMWdsS813e+dnUKsJ
 NiY9GUqJHFhCwy10VlZAoanmHqcC3rVog65kwplVFBB31aaE4LfxrMW
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42JZI8nAo2s/41uaweVnYhZr9p5jsph/5Byr
	xcOr/hYz77WyWayaupPF4uWse2wWmx5fY7W4vGsOm8X/PTvYLf5u38Ri8WKLuEX3O3UHHo+d
	s+6ye2xa1cnmsXlJvceLzTMZPfq7W1g9+v8aeHzeJBfAHsVlk5Kak1mWWqRvl8CVcWzXC8aC
	HYIVF1bPZ21gPMDXxcjJISFgIrF30mr2LkYuDiGBJUwST/7dZYVwHjJKrN06mQWkik1ATWLX
	m9esIDaLgKrExWtTmLoYOTiEBQIl9mzMAAnzCghKnJz5hAUkzCygKbF+lz5ImFlAXmL72znM
	ECV+Eg3rp7KAjJcQ2MEoceXLVUaQhIjADiaJx/2GIAlmgYOMEuvP72SGuE5Y4vPuNWwQHbuZ
	JKZNe8AKskFCIFFi52s5kBohAVmJm+e3sEHUy0tMO/caqjdUYuuX7UwTGIVnIblvFsJ9s5Dc
	t4CReRWjUG5mcnZqUWa2XkFGZUlqsl5K6iZGUIyJMHDtYOyb43GIkYmD8RCjBAezkgiv1bmv
	aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoYmb4fuiw4
	6WVHace6Pa/z2tTFlIyahIXm/3rb38/2pK650Jrtcg/jqX/y9YopR5zO/IvZWndWavHPy9PK
	TBTdK9fnMPyuebm2Pesdy/flnh/VHTPcnh+bcb82bd2jhb8WRVUuzKo4K+NyTebg52s3Luxq
	vGFwv/tZ5rmPQmfFYya6cwcyMV2xUWIpzkg01GIuKk4EAPY0g2yfAgAA

Update gpio-line-names. Add missing and remove unused.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 .../boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts      | 14 ++++++++++----
 arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi      |  4 +---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 50debe821c42..cd8645be7ffd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -322,15 +322,16 @@ &usdhc2 {
 
 &gpio1 {
 	gpio-line-names = "", "", "X_PMIC_WDOG_B", "",
-		"PMIC_SD_VSEL", "", "", "", "", "",
-		"", "", "USB1_OTG_PWR", "", "", "X_nETHPHY_INT";
+		"PMIC_SD_VSEL", "", "", "", "PCIe_nPERST", "LVDS1REG_EN",
+		"PCIe_nWAKE", "PCIe_nCLKREQ", "USB1_OTG_PWR", "",
+		"PCIe_nW_DISABLE";
 };
 
 &gpio2 {
 	gpio-line-names = "", "", "", "",
 		"", "", "", "", "", "",
 		"", "", "X_SD2_CD_B", "", "", "",
-		"", "", "", "SD2_RESET_B";
+		"", "", "", "SD2_RESET_B", "LVDS1_BL_EN";
 };
 
 &gpio3 {
@@ -344,7 +345,12 @@ &gpio4 {
 	gpio-line-names = "", "", "", "",
 		"", "", "", "", "", "",
 		"", "", "", "", "", "",
-		"", "", "X_PMIC_IRQ_B", "", "nENET0_INT_PWDN";
+		"", "", "X_PMIC_IRQ_B", "nRTC_INT", "nENET0_INT_PWDN";
+};
+
+&gpio5 {
+	gpio-line-names = "", "", "", "",
+		"", "", "", "", "", "X_ECSPI1_SSO";
 };
 
 &iomuxc {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
index a5ecdca8bc0e..04f724c6ec21 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
@@ -209,9 +209,7 @@ &wdog1 {
 };
 
 &gpio1 {
-	gpio-line-names = "", "", "X_PMIC_WDOG_B", "",
-		"", "", "", "", "", "",
-		"", "", "", "", "", "X_nETHPHY_INT";
+	gpio-line-names = "", "", "X_PMIC_WDOG_B";
 };
 
 &gpio4 {

---
base-commit: de5cb0dcb74c294ec527eddfe5094acfdb21ff21
change-id: 20240925-wip-bhahn-update_gpio_lines-387fac08e3d7

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>


