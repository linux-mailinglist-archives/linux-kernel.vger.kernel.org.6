Return-Path: <linux-kernel+bounces-374768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C89A6FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F47285F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4591EF920;
	Mon, 21 Oct 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UlqYGZCK"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046631EBA1E;
	Mon, 21 Oct 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528513; cv=fail; b=gBRQGtg/RuRUBc4hghLLVI8T+VwSVCnBWPUghypJIF0oHb/wbNoEJ0WfbXIgPZ6NjZd7qkERoppcy9N7NLyAHr/9J/yqvpMnSOih/FAogssgLb95QUQnlaf5bTmW9TyrBHFs6XCyC8Eurk9TxCHCJ5UkNs7Nch+y3SLFTCC7bps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528513; c=relaxed/simple;
	bh=diZXzJGF1b9947hGTstFoxV8A/fz2x2d3AxZVOphCM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APOT7XGpgFzUBTh08ZwtTjKB6+aE1MRU/Rhv11csgwF9teFqhC3r3d98Kr/LBcCkqFgwXzE9rNcmo0rGif+Rfb1/wsAYM/oS0sBmT04L+lCBUePP4CY94YulbfceyYzRgHcAN8TSwkW2pcWUCS0veOwEMMymd12p/IH5l8h+3fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UlqYGZCK; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tylD+NJohNkujynb3pzUTCqUSaYuax2v9/eQcpIR5jlxTBTvR0ZfI1AGz/MLxxSj7AeBksEcKEY33OKu1rvM6KNFda3NG+bd6wyvrPCed2LD8b4NJu3KucMImrnEFBJXEXhvzmnxNdlvkOp8i8RvtU6evVFLObCjKyURndtjSDSI+0HqdqUd9HA7kpNY1fthknEKRC/RdRtYriZ56upyu7OIZUwYfZvctRVuBNipmpwhQjdWbzrDrkiuEoDKOl8sn6N3pYp1udUF2crJkiJdp4/muYIp4Cg7RlmOr6kn0L04IsarHXqftD/1oYgtEwm2sXamBSIuMYQjkAmlSeEzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYnts/+5dO17cmk1WiqOP8a+krr6zKojdPsKxPjanDQ=;
 b=uDf8ByJ5coD2oVUj6A7X42uf2HbQK9o6kxzrGee36LzGliCKZPzr0onVGTu/bg3pdb9nIqADxcs3I6jGOrfKb7SypZwM/SnvW4ezs3NXmYsMs+QPmq1WgQrF0my3qWF5ivjF8nAgMon8cgvYv7j4uGyz25FhIGPbRGRWS2JNjStpulTQQkuNeIzag3vzl4Mn2DRf6oP6HunT3T2v7GQ87IX6Z3WrP7Kzw/V8tQJrHXN8fK99gLhpaRPWWXZv8ENnuroD5UzRQgMZVWrnT7ByRtE/DH5mGrxg7N5hTUCYK8jHXYb9YrSAJzoiw9kLehBmdkMOYY7aTtolhMpA/G9row==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYnts/+5dO17cmk1WiqOP8a+krr6zKojdPsKxPjanDQ=;
 b=UlqYGZCKP1jeeE7KMHcIkm9TiPhhc3/gK99McchoALUjl+Y8kiWbxdKr8509zSHV/f3w7ndrN83qKgozKM0RCVgLeFJt4boz+N+hzO6XFQuzHw6wQWQ/SaMKmE91GmvbKtkJ9tV5eM0omQkVl7W/OcRDc7f4wsrabJFpmA8wvzA5XKvwkFFKKCZ/5f6Emq6YuoPV7uSr1iUY8XqNTGZ7lYivFE2JzAAT6G514BeqhtBrQgD0MgrMQVe4Dw2ijydP9b3Zqi/0slS4qHg90p1Rn3Tu36P81dNgnoikt5hV4GPv2IWnHzdguHtnFpbh029s5hUnkWwbbDKkh6Y6WKV1wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:35:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:35:09 +0000
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
Subject: [PATCH v2 5/6] arm64: dts: imx8qxp-mek: add usbotg1 and related node
Date: Mon, 21 Oct 2024 12:34:36 -0400
Message-Id: <20241021163437.1007507-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021163437.1007507-1-Frank.Li@nxp.com>
References: <20241021163437.1007507-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: dd37533c-236c-4c79-1adc-08dcf1ee53cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vI3xC7mP9Rpnfb7IxFtd9yn1j/2Ea8bhkxBH++kL+LY7WFXfMt72IJrleGXZ?=
 =?us-ascii?Q?CSS5H/UH7ZHa1srfMwHCMhwDGw8nR0oDNz2hwLYnDgnDa0LnFISdW+OVJGea?=
 =?us-ascii?Q?PcoQI8C9II32zU+cIVMWPznDWq5RAkJynqqmlahMJwdZE8o+gzvtVUYZnXOO?=
 =?us-ascii?Q?liTkQPF4A41BVMpyV+NBeGRiKszKlWXF9xee1tsn4UWOkRA8oI34wYG6aZe5?=
 =?us-ascii?Q?5CVBCY3kxnwBdEmvGqagSyUzVLMZkXkUF87S5T0vMC6f5imGxoiszTctcj/Z?=
 =?us-ascii?Q?KywZe+7+bUfubKoaqCJZXbVOrX0AEv3D0Epl+P9dxN/J12EdpWJAkSIuOi7j?=
 =?us-ascii?Q?xmpFgu4vCEWqsZivPSXbW1KTsaB6VrxHv8iBuiAovlUWsLL18c/HPx37dYD9?=
 =?us-ascii?Q?GmSki8RKpcRcINYJnw1DnxfI/tczR2qnerXAOsb8mCrZWy5cxRbWDaBKZjHF?=
 =?us-ascii?Q?/MEKH3Uv2kdU5fKlIMzI+OfPe+rmtrfxwbpy/WxLkrXymDGFJk1+qSiQHzfq?=
 =?us-ascii?Q?Aty5qc5aXZ2tXzqQ3zQ62ZZJwsJSlzOMtp4TN1sZITcmidXXZBesQNUDtC9h?=
 =?us-ascii?Q?AnakpBaYyCUT7McI58j3NKXbQQGaUsELif0KX2FRrTlwW8Sc+BaselVb0DRr?=
 =?us-ascii?Q?rNLU4RBgI/sIFETSNc4CVxiY/FAqSKLFXFQcbNzwCHDNzSF8hjmvfKzJ3TLt?=
 =?us-ascii?Q?0lg1h8SSc4oaY/2Jo8IfPj4pDRjduCRQzj8OU5j9R6/lTe5DITPiMAufPcIb?=
 =?us-ascii?Q?nZr+f65SIfe7dQQ9D17lY296QopftRk0SUkJDXyrpsx+OlsoyZk8s5yDRs6b?=
 =?us-ascii?Q?40BEl60TLbmTXT7l1zdvga7/HP2PM15ro2aHbYqjIKy7GBdN+HMHxxMUePdc?=
 =?us-ascii?Q?iu9HciqJX/TdbRE1+n3toaG1sH73rgHVwZN/GCfQN43LyQqx8l+C1gyIWnNR?=
 =?us-ascii?Q?528mkosgzPjaEF5v4KXouOl4/Rh8M28CS9/ExYPCKgN4grhCnuQzM6jn7ghY?=
 =?us-ascii?Q?ZmcfBvAilDCw9Hj/8K5PlNOvOzz6aN0gzvcxZvHAjtGjC9J+WRXN4IahUjOp?=
 =?us-ascii?Q?BUDlCagNFk+4ZusPIjIoTPmbjkAw1fxa0Uo+0acqHwR8VWOuPk/QvrsWfpWv?=
 =?us-ascii?Q?H6FI0LW553KZmgMNisbcBsFc2xzLCYmR4LBUe8MV/zIFEHcvWpqc+KH/3d1m?=
 =?us-ascii?Q?T8a3n9KBXUe0eEeuK/X7lycf2Z+M2GAziOfYgFV8/2Y2dyCeScZh/RZCf4Lx?=
 =?us-ascii?Q?Wm7Bhsy4e8h8dDQ1cBM5lv/eqDchtrQerGNRjTz7+Kwlggy+zJvXFDv0hhBp?=
 =?us-ascii?Q?X4YbAdoOgPMpoKvR1yJj0YGBr+D61GoESR4HtM0B/7f61IwPf9qIZRG1/9dA?=
 =?us-ascii?Q?P9+8hqE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CKfzgwnTgcSgxI1rr/eucgYj9omMaoZN1mgWf+BN4wamTNTCl+roI48ASTN+?=
 =?us-ascii?Q?z/ZN5hIjbcKzeccZc4tLrfJgjAqLayOIxSw2FJ5/Y47Foevy5xTiGg0h6EGz?=
 =?us-ascii?Q?4XDL0VLVrXTp+1nh9nv0vnVtOsjiPmgjnReujcESZXE7vmPsY0lT0vkS93r7?=
 =?us-ascii?Q?/bUmmyZ5KomybPa1w+5ig32iBsZ7E/Fnj+n+kdCp5Hs9hwOcvp2o4snMfJZ6?=
 =?us-ascii?Q?JpYHhGf/eVo0QECOvRxarG/uAFw9ZVPasbd+b2K9wcPOKdlMYO6Cz5xpl817?=
 =?us-ascii?Q?HOm4cYDv6UyNL0PB/iKxNrUL3bXezwUA8kIaKKJ+WcT1OuwXVXduXTxHa9Po?=
 =?us-ascii?Q?E196QNJw/fdPUnQfwbYgaXIJBgkVF70nbh/R3aPnBNXWB4s8N2FnHz1YZaVY?=
 =?us-ascii?Q?Q9Q0ltYt5nu2MJfCgSrIw7l3Xw78pEEhMf0fEqM2aTm5puqYw8ZUzkk/wtdJ?=
 =?us-ascii?Q?8im07BCa9mRl9ZnU8ZrSWst4IgqhRwSgpkKyAXDwg+8FlqBpG4/m63bqE3Je?=
 =?us-ascii?Q?NJGHfRojFNeT+9+iy5CSmsoDBMLw/fcc1R1WAnNJvlBBsQslEBggzbhDVXty?=
 =?us-ascii?Q?ZoPxhcgKRNC4c5obXQuIhEHVZY3JqfdJxScfo4FGJ2BVZBUhuzDQgr0Dw5QK?=
 =?us-ascii?Q?JVePpQoHWPafqtDiCaqC4tAf0OzvM019F+n94XjcUp2KgtFzx5BXT/DXH4yQ?=
 =?us-ascii?Q?O7B8mGA+kPguEB/jtOjuF32MDubXhLgeeRdBHeTStT0skc7FTT/MnG/rVfRB?=
 =?us-ascii?Q?O+9CY2nOzgQf0RlS8/08ST2gZ/L+5RldS2GMfs200iN/XEbdzoBfS5Q8tJ09?=
 =?us-ascii?Q?itY1h/bpyYU5OhLOpsEcJP6p8w9w6XQaVHM6TlVFuN72odQvB0cfYfkq3Qfd?=
 =?us-ascii?Q?diEuyyeUR3TfPJ7tCK62jmlLAVqYhDnm5LFicY1hIwr9dzqm56m9E9hRj5A5?=
 =?us-ascii?Q?8c4a5s1gOkPS84UuQC0Bo5SPIUR8Cp5/kOFnJAM1EnOBf2vYP2eMZe1/JxSS?=
 =?us-ascii?Q?081cwm5+m9FfiqjBAi2/od4xTRDjThWtxZ9gikysAUdOVjrS2QCbsrJqs2M2?=
 =?us-ascii?Q?+hOfvvpWoT5pG52VCPLKfsUb74xVOuZKsuRIty7tuVBgpzg+I3R0jayB+75O?=
 =?us-ascii?Q?4WHDqRZpsq0U4AKyr3I1R5+UcFz6l0vFDQt4UqEURk7ZtXdYo+bCaia+wXZ1?=
 =?us-ascii?Q?0/4tAvt67BFAc8NQSnMBWcfHgEPb9kV+n3uDpgwFdtLQHKiyu0SUzUWOe7+Y?=
 =?us-ascii?Q?7avAycyt44OE28uhqLOGMBGLzmMrrbr30K2TTEYCHyEQ4RJpfvbGAK30XF9Y?=
 =?us-ascii?Q?0hXyjswMs57h/UG67GIPBxMR+hAQmu/Y52H5ODciNuSBf9U6TR9SjD4PkJ36?=
 =?us-ascii?Q?AkdEY+4NBRg//rDWdrlhiGqpPQ57JwYRi/iNxqJc62Op8bwGX4npco/Xx8ep?=
 =?us-ascii?Q?hyU1WNmTa4ZVzx7vK27O803YjKetUPiTpK+7BoN5fgPvEKm8gQXCRAB9pykT?=
 =?us-ascii?Q?dqWvQginlnIb9JiCAKIJAKb54QlnPa2YEb3eZijZLTJJMaV4VHS8dlH+kKp7?=
 =?us-ascii?Q?5C1I5JEhCKCYgdHpeo00zpKuEnxjJm2RA2z1uwGX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd37533c-236c-4c79-1adc-08dcf1ee53cb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:35:09.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+eP2G3wI7aROGVJNIejW4pn3PkBpLEwN/MimST3CMpqShBZTDKD98zjcOA0yIJEsoNa0yTc7TaaPqHkTm3qIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

Add usbotg1, usbphy1 and related regulator nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- none
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index e9342bf158489..6fb454fdc5b5e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -76,6 +76,15 @@ reg_can_stby: regulator-can-stby {
 		vin-supply = <&reg_can_en>;
 	};
 
+	reg_usb_otg1_vbus: regulator-usbotg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb_otg1_vbus";
+		gpio = <&pca9557_b 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	sound-bt-sco {
 		compatible = "simple-audio-card";
 		simple-audio-card,bitclock-inversion;
@@ -516,6 +525,20 @@ &usb3_phy {
 	status = "okay";
 };
 
+&usbphy1 {
+	status = "okay";
+};
+
+&usbotg1 {
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+	disable-over-current;
+	power-active-high;
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
 &usbotg3 {
 	status = "okay";
 };
-- 
2.34.1


