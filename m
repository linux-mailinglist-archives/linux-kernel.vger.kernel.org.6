Return-Path: <linux-kernel+bounces-374995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539889A72ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9B7282DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F61FCC57;
	Mon, 21 Oct 2024 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bBorn2mg"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A81FBF49;
	Mon, 21 Oct 2024 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537593; cv=fail; b=Se8Kal8yCi7BxaZ3bLKgo2/zqcPOMHuoB6E6MYKeRY16PlIXbZUBxgvwyXVtDNrnnrY2vRWQ1Jj0S8S7li8o2LkHBDwsJxponel6LswVuuFUrUX2joFJHNZIy/zt5LJvyMCQqjsLd+h7fzCGvDA/20CyK/yW2OBa00qelj19RuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537593; c=relaxed/simple;
	bh=quBOy9F1+t23iLBF1D8OT/ZmdCfUR7ECkZPSRNZTg2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKxYSlz5lNOMl3s2U9aEMe+gvnVyU7VYkL0smSj39gSuu0kHCEXJcjZGMDONUpM0lLfYooRktC1CAdxHQxWR9FMs4NObfGstM6sTBX0l5Tw+6/0EPqu3JbhHKptj84mIdqwby3sSa85JCNcgegpgJxOTaSY/asUrgYJcN511hR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bBorn2mg; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIiQcmRq0m+xEZDKDcRoCTuJbGh8CkuArqwotjtWuiTaD8ZqiepBfyUgM14Qp21vFGqBZDVELjfuer8s42GefMYg0MUNNBdVWhAfztLZUcfPhdjZFDYigHe3Uki1j5r69FRVRAUjUSqNgYzmR8k+ePe8Yom/JlfrdG9+8EaNlejFkDVHJb9j2qjRpa0TLzmOF5sa1R+TuEKP0eCXqe+JvZX3w2gfai9+RS+07vr7mzwl+47DkHgfjQrXIuOSwbRzNh4BCCtdBqRV+iUeu23q3rbU7c6Xye1jL3RLdh4QCxggc/EN6Q2D2qDJKbSLs5eYrJ11qvinAYWBzgOjM4WXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvtZqmvTygKX/T0ISYo4nCq7DwwBNtMMqw9KymU91e0=;
 b=kclj2z5SdVI5xb+6LrBOd2EXK0K3eP5+VdFDrC28Sv86nvocGTC941GSZmFBnzm8gY2vu2zwW71x2bzYP4x7mS3lOCkuZY4f6S02LIMQluXxC+jqobUcOLWdMSOzTVoWIaMlqeCVS0r1/HdxfwlHWu8W4G+L4sK0tMUSK9etXhpDron0crFzWLwCmQq80fS8fXn053HTdjJshtyi8dBaOJfO4naHIzO0ZiM95GnnPO7Qeey6P9skovWzSbTrNfl00ua2FUtCj8cZt9BVJ4j3ZZWArXu5Ltb8MwmINolu/Aljgt61zW0zLLt47dQiNtVdPl8DaSrbmgyGJqv5PqLjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvtZqmvTygKX/T0ISYo4nCq7DwwBNtMMqw9KymU91e0=;
 b=bBorn2mgdseD/VKbV8cjtDsCifroH0Tyu2PPtXVRttHxEENEGdwObLxqVDkizAdrKGjYS13W/By9vk0Duid52V4YWxKP7Pnj6QGB4tz/vsDsaYaXwmm3mmj4tpU7XBQjIl8sFASB21MGQAXg1JbA0u6K0p/MNSHd6foVPk+YZ7TZAgxfA/6Gf2jtuogXtV2xzenAczUu/rFU/6S8XUapVxQPzBIe6sfm1nKkDBIdrHgDInmU50WWUDqU6Ffiyo1Xm4nqTx7WjZeRrJfVF4TlkZi8y4ytIdYmmV3Xhx8UkfzUe6BBhEbqMI6WHumysmF9cdTiRHVDD8ti1glHLylffA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:06:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:06:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v3 4/4] arm64: dts: imx8qm-mek: Add PCIe and SATA
Date: Mon, 21 Oct 2024 15:06:02 -0400
Message-Id: <20241021190602.1056492-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021190602.1056492-1-Frank.Li@nxp.com>
References: <20241021190602.1056492-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 5464f933-6662-4725-29cb-08dcf20377f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUfA2e90nN8gsXIbzzKhFHWeaoe+FK3l7wT3K2td+sHVmcM9VlaGRF7q+Nd/?=
 =?us-ascii?Q?NzcVlbgq2PiOeIJDVShYSQAWmcBcPWjlLdjelicp4Vn8S3j6jJ2+O5w+nIqj?=
 =?us-ascii?Q?lAsMdIwtIiw/p5pjPmquq++QNtFILswNNVM9+3xFpHxDGECCaqDqTyrgn7ix?=
 =?us-ascii?Q?uOSpHuc2ZAYwvsUzIUboMykMjhAy9f3Qc/gViqt83DRfKmFzY7BqOVPgAqQP?=
 =?us-ascii?Q?YBbz3qxuaPaagph3/LbHuBLwk3p4j1QW3TorAhP5bQQ3psfK+PChUl6UEcb2?=
 =?us-ascii?Q?k2xKye7nNYxTfL0ytECrGvSCM2HoxkjiMLXJmKtj9yEgZKqELcU5+SkeNG1E?=
 =?us-ascii?Q?csQNYjnwKAHTq7ba4DJpw2Ck0KfwxZ3RBtaQ6G4K4GHq6pmUhgl3BelFoz7t?=
 =?us-ascii?Q?jXjrGyoN1jqUAlmyctxi3F89AyBZ4I8dibIynTOLPPTPSgaETKGy0u7p0OjL?=
 =?us-ascii?Q?tyb0cIRNZO21+H/w4HWK3dD9sizUwkZMW8uPH/xBqJQY6zH4z9fdiGYUoMlB?=
 =?us-ascii?Q?nLO9ZV2tv8GL+QqCNiW7J8ON2CaNfrtlpyAzYvIjK7MSxe+EPjz7Q5Ia3LcU?=
 =?us-ascii?Q?/ahiuvmrN/MOJY6pEvGLgFZZ0KSav0rvwA+m7rWaat08TzMm77kZdTgQZCB0?=
 =?us-ascii?Q?9dlQQ6KuaNFgTWP3M02UIBnMHZXw/B16rawH7LMJ4yVgreW+vOSTCmPzEVje?=
 =?us-ascii?Q?8XiNBIfXz5Dh5zulwLZoOMdToqaenAXB1nAYRxKQCosvnd3MvczkkcRuHIlN?=
 =?us-ascii?Q?Tr7MVG4klBI5NAJe9N1/S/UYEXkx+bhfzwMsbYchMHP/w1/Sbjwv27/XeGx/?=
 =?us-ascii?Q?p5iPrax+HDByFcfL0Uxe0BbKK2gvHWPJfCF9kYYFb9FwvfGvwNSyRu3sXGM+?=
 =?us-ascii?Q?E+7NE0Vii1I0z4UHRsCMHPYBcpO1im84XCgUp18vSmL0wEpQwNvmaVHKGtNI?=
 =?us-ascii?Q?svrc2rxXNkaBiEF3eZsSeseMZHd4bFkhV7lsmF1Mst5Nq7UOPsGDbZEW3eYY?=
 =?us-ascii?Q?J0kfiVfoI4k2onojR4GIVpzDCD/xEtV3yJ3+ETa3qGTABVM+1APR3Obs0XFh?=
 =?us-ascii?Q?985BYrSchbwwyfap7+6okCFWyvKdhagCmkQoyv6TkBlFjnwV6hVY9EsDIlZJ?=
 =?us-ascii?Q?jmCqJJSQQiz+Zoitz1cvcyNLzgCm6elmFbkDNcwiBPH6gsWaGl3pMJF6RgcS?=
 =?us-ascii?Q?tiAlfN0ysnZQlOTM1vqaT+7pxWokmt0mDYB1QCwxlNCWtnhZX3PchnPuRLnd?=
 =?us-ascii?Q?HCyEJPV7QGCAcfY8cqZA+IdaQt3EFlJUjQogTLlCQq8LEdA09673TLKj4Uxb?=
 =?us-ascii?Q?DaaqfPtBqoeQbfoKmh9bfw2TGMdlG1wC5Dt6CZkjN/5zHWJNKxXa8DpRvWIE?=
 =?us-ascii?Q?t/JM/uw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qccQRkHLYlow2/lkgiwKRtyGYmPabwmmKu7eZDB63YhNzegfL4ffB4zuKgS7?=
 =?us-ascii?Q?qKdoUOgDStaDwEaTtE3M0NI/bY4/ExLXq0njBD1mJPGG787cC57Q7mtUwzBU?=
 =?us-ascii?Q?93uIgksFI02U4PHt7TeS3dBJezxuak0tTVJzmQXNjKhGRUSQU/kMbd+JjMpL?=
 =?us-ascii?Q?UXNmJmBDsWbn8U+zL/UJ7iFeB9DlqNZ4U3j1H6rGV48WimO8Pfo391Ed2ttO?=
 =?us-ascii?Q?drVADElMlh8sdAJBRwXew37VmEi5tOdpwnFPuYvZSPVVJ6XOFvRpC7dlrKge?=
 =?us-ascii?Q?zCdipq4iD9aQRcSwnluHPRqspjAJoMWz3FHFPfDc87h0nzzb2r0gm2gS5TCR?=
 =?us-ascii?Q?v2Ofccgc65OgbZKf3AVkOVAx6wLGzSEljf/ur3jlKTVeq6aE/K6Yrn7++yBV?=
 =?us-ascii?Q?5KcU+F3qqGKQMXmVL3ooiZaCFRdYOYnv8RoIgjTBg+TlXqKgOgFeLD1StNqv?=
 =?us-ascii?Q?IB7WCH41zyTBZaQQ+84RJWgyKBvXV2rbaMSXi9j85o0Aeff/XA9Goa3Os77a?=
 =?us-ascii?Q?SXX5K0256RcChvG3Yz1f30fNOltUFxeHdZqwWJLhdG6mdfKZgx9vOjGtEiq3?=
 =?us-ascii?Q?0TMafk54OXQIX353xr/lemF5//dG6ADwSlL4jIGJTqLlYfKjarMPrepfYFT+?=
 =?us-ascii?Q?t3sRMdWzWhgWAxuSx9gSD7V76wXjNz5EymJ88h5sQzGRzM34678TnpnkgzRl?=
 =?us-ascii?Q?2goRBX8kQwMrZDBTdbJTrrEjvbPfFjAy79QnAOBrGZnyz6Mi3tiXi2T56EZT?=
 =?us-ascii?Q?3ZUXD9XlzqunQIo0CBtEP3uPXSmpkxiugAK6OR3dbcyA9e89usXUNFhjb5jv?=
 =?us-ascii?Q?fbQG+FKiiwGV/xDHhcy4N242u0QO5pixmb/ZaDSUW7D4u1inxvU7YxtpOMrQ?=
 =?us-ascii?Q?8syyD36Lw//n/1IsKIqCNz31x361AN1E8KN2uvWBf8k4vD5aY8Y4+/8+wUMc?=
 =?us-ascii?Q?SH6Fx6Jgp2Xq/ZMiv3xD+YvUeEoyyJHY2Lo8hddEQyMZQuvZHeHNFO9IFiJJ?=
 =?us-ascii?Q?EU86VQwpCAu8ZcNkWgIfMND0P2MZmjMiJfIWl6cXovws/DiQboyV/1r4hKbl?=
 =?us-ascii?Q?07lCGOHw+yEfvJRlklI1KOhnTp0bHigfExz2wveVHRwG8C7fX8jAHVbsD4vF?=
 =?us-ascii?Q?Yy9bQXnaPi4z3VrM9EZSetVUXgm3vXkT/G6atEQOmHDDOYEZ87hxN2hescTi?=
 =?us-ascii?Q?P6y51QWo4yYpCMo6NjjRk3nDFG4N5aO46VxILf36wFHSdnVcktrr9yZl5jz/?=
 =?us-ascii?Q?5P6xCI2D8LyOvlZaEaiz1wI1EySpvK0GaRxAZFRpvkNBAKR5c9eqM0B4hEfh?=
 =?us-ascii?Q?vkQSVicK0MOQhKQ//8kbieeUWG9iQloicRhG9EsLSA4qTcEiMldBVViBNscL?=
 =?us-ascii?Q?ifMloSY20CD/W3ABGz5sY76SmrmBtbRoX8ODSOnS72Wzs2+vZj7Gcb4ydDWy?=
 =?us-ascii?Q?cTDUmnJBQuJoM3ie33o4uMiBX6thzHkDqnBL5g7uirtmFoYHtB2LrUMasWnj?=
 =?us-ascii?Q?+wJPBfmsYMzG7LMkXKCgJgP+5K1W9qgd8B8mZJAYRqiAW2ycMKDpxHoruaxm?=
 =?us-ascii?Q?cwqD9b4FcnTc93dnG3spGQK9ywFADxdfFahaqC5V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5464f933-6662-4725-29cb-08dcf20377f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:06:29.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KVh/Wgbmf2b6kSNp3zTb+vlSDDxdP8tSlyN/CD7xEXKbuytptDEXuFpjCcCTEuaWsY3thTB94GogenZgViswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Add PCIe[a,b] and SATA support for i.MX8QM-MEK board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- sata -. SATA in commit message
change from v1 to v2
- add space before {
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 62 ++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 62203eed6a6cb..e983633a4bb31 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -181,6 +181,17 @@ reg_can2_stby: regulator-can2-stby {
 		vin-supply = <&reg_can2_en>;
 	};
 
+	reg_pciea: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_pciea_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "mpcie_3v3";
+		gpio = <&lsio_gpio1 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
@@ -296,6 +307,12 @@ &cm41_intmux {
 	status = "okay";
 };
 
+&hsio_phy {
+	fsl,hsio-cfg = "pciea-pcieb-sata";
+	fsl,refclk-pad-mode = "input";
+	status = "okay";
+};
+
 &i2c0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -541,6 +558,25 @@ &fec2 {
 	status = "okay";
 };
 
+&pciea {
+	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pciea>;
+	pinctrl-names = "default";
+	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pciea>;
+	status = "okay";
+};
+
+&pcieb {
+	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pcieb>;
+	pinctrl-names = "default";
+	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
@@ -640,6 +676,10 @@ &sai7 {
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -829,6 +869,28 @@ IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA	0xc600004c
 		>;
 	};
 
+	pinctrl_pciea: pcieagrp {
+		fsl,pins = <
+			IMX8QM_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO28		0x04000021
+			IMX8QM_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO29		0x06000021
+			IMX8QM_SCU_GPIO0_07_SCU_DSC_RTC_CLOCK_OUTPUT_32K	0x20
+		>;
+	};
+
+	pinctrl_pciea_reg: pcieareggrp {
+		fsl,pins = <
+			IMX8QM_LVDS1_I2C0_SDA_LSIO_GPIO1_IO13			0x06000021
+		>;
+	};
+
+	pinctrl_pcieb: pciebgrp {
+		fsl,pins = <
+			IMX8QM_PCIE_CTRL1_CLKREQ_B_HSIO_PCIE1_CLKREQ_B		0x06000021
+			IMX8QM_PCIE_CTRL1_WAKE_B_LSIO_GPIO4_IO31		0x04000021
+			IMX8QM_PCIE_CTRL1_PERST_B_LSIO_GPIO5_IO00		0x06000021
+		>;
+	};
+
 	pinctrl_pwm_lvds0: pwmlvds0grp {
 		fsl,pins = <
 			IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT		0x00000020
-- 
2.34.1


