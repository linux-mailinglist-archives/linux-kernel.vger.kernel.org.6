Return-Path: <linux-kernel+bounces-359051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8AC9986D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CF62882C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7441C9ED8;
	Thu, 10 Oct 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZX92vztp"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A991C9EA8;
	Thu, 10 Oct 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564960; cv=fail; b=NiTteWo/2F0rA8GK89cMTLVmFyp0nHRay6hkNTgt4S1vPMyRapuYSW2LaNrP7bOob1GG+ACQaogG/6iTTf9Q6QqC+kPqVLFt50rA9PMonoelqGTRsvNgMl43UgLnYfo7hA5rrWgeqGDGMcH3yRRcpYbs72rtPNnK2mZP/MaDFcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564960; c=relaxed/simple;
	bh=eczrn5Oi3Li2/ug+E0wkJjjd8kKvBTd/s17pHXAkt/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/eh8j6IwvTHIETGj3V80ABNz7SdjWZrpv5qNT81TYP0B0YPG7KIDMQkULPZEkY5dRfu7342Q2vg7adBn4SoErcKcX4nr3Bl67xZQ9aLKX5DJpCRISGAE/MD0KrAXZkLSNfcnTvSW9yZdg3sLOM1K6hjnCo2ZU9Mh4Og2+LkFwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZX92vztp; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbKyGo4kZCz1LhBmMBYasO8cdNadJ5Fpjd4ohfQf/zg4PAG16pi1Wfc7ZmqO5DGGqTW0uinMNknM/nSSN+yXZ5Hub1e5JxQXoM+ipvzvkFt6UnNf5Ts9J+weJor5XhK1+W9pUl+H+9l4oD+nWvQK+/yJNfqTJWDLR8HqFJEy0V74LWT7fapg/VsvowU3fSJ1SHjSaeL5BR0Nm3LaI8+05pmSHpEfNnHuBK1u/q7qGGDVx1959WvwAwXcvJ99V+3D85/6Y+0zM8d1mr3ePSRw03iOh6+BrWtLW/dELMrC86cHMVKXJXaTbOZzHKBRKwpZIW6I8Qw/vf3OkZCTrmkqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfT0j5kmYPfCyfzikvPfKE7P4wrW3653Ancgo4185BY=;
 b=S37WHNG68ra5JXowWOYzinLIosmJkjycCtyLCd4CGROFj0pVklYZht+YMOM7/U7kiiCeSPpPudK0KjfEZ1Sm9Dl4oUMhdKBSL+T2Sere+IcLdvTZ/b8bRHkYhBlGi+JRJ6BSRvYhEwBIhhrPaTTvB4H5IyeUsYMTdOe8F8RNRi7k3xRKEPHVDJ80jt1AYCr+NDy/sUg9KrgrNk0w0BpaNCI84t5Ew8PxxbHlOHHv1t3HNi0usf8KgvG4Upx1YXlppkMvCOUbPlYPzvQeXhPjR7Dveg3XQYwZB29PoxBFIeVcUrOyHVahC8jx2fgCSTM48BR9NKnW7GmdnEBtCXg+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfT0j5kmYPfCyfzikvPfKE7P4wrW3653Ancgo4185BY=;
 b=ZX92vztpgVNZxtckevCiw7Y5KJC/j1IpNjNVKIQqGHC1ePDjF7DvPtciW2XdIBN+dPmOGhIcNMLk4R1dFBiGF3H4bG3Kw2R7vcv0EpjnY5CXEYF+3coBg50UoiP13+gXM4EVbzvOiwfBq7i1QRKbKv0hjsksL8C3TpJ2KwDZWKE1RQ/q4iL+DHVeX+vdhgxhmyOvCD/gIfKYZ0qCnnTXKryHEz3Zjsh+ZKRpnkXrNIV63YgoiSMYQBFerq8PA1bc+kB/ZejUq2LXHveF8TSKsSMu5fQfyHwTuepISHP/qQb9dtE1eVEHnPn6Rzo0RE+pufK9c5mHDAdQ5eWpYgRKbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 12:55:57 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 12:55:57 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: clock: Add i.MX91 clock definition
Date: Thu, 10 Oct 2024 21:57:35 -0700
Message-Id: <20241011045736.308338-3-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011045736.308338-1-pengfei.li_1@nxp.com>
References: <20241011045736.308338-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bcb5ec-7ef4-4fee-0efd-08dce92ae20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3gOLgMsueA++InlZsjBRHXW+0exvl/WpeAUR4NXpH0RgK5VPwwLjaj7yFC/8?=
 =?us-ascii?Q?mp/hjNnX5OeF3v5XavFjzyIoX2aLaKhIufs4lwcZ4UKz0Padbdrgi2rMvRzd?=
 =?us-ascii?Q?aTkV+Kq6WDw72Vk+pxItSpWvNFM6++FAUf996xS8EGbV4ST5ausvU6TKSbxL?=
 =?us-ascii?Q?SnWGT7HdPdQQ1zTvAUmhK9eKqGMXvnzS8su7jP2VcVSj+Y5FW+H8KWpxBfRj?=
 =?us-ascii?Q?HQrz75pvwPZsi5K2tQgTbqwyZLC5RygpgGaQunCBFG/gWq8rpgpJWPRqCxw5?=
 =?us-ascii?Q?cyov8WRJE3bjvGjGnyZWG4JF5ZvhewXQSrjlF9yn9ctVJGOq/mSTIECXB9If?=
 =?us-ascii?Q?XhIeh/lrd1SFxKBQ/4v6F57zIGlPYd5jYpBtK/kaSW7emybqAk9zRY139ZJZ?=
 =?us-ascii?Q?UFjz09eGvoQF3rLxdip6gbUQ0heMbzs9Nd0jT8+5iUWZmt8OZr/e73qYxjbj?=
 =?us-ascii?Q?ME6/0hKOeoCN+RPv3V6y2ZvbV42Xn4AvOg9UuOMjid1Gx4OS3E6/PCcbZv3J?=
 =?us-ascii?Q?c+kJ0hGzBDmlDDY0u2/aXGxOg6Vj3JcomZpOJmzE5fLvLuRm4JSRB89KL7ph?=
 =?us-ascii?Q?f2lgQbKO8qabuHNYKpcXQBRjXyFn95z2h7wLAjaN2vWo9bUAGPXOwW4D1q9C?=
 =?us-ascii?Q?jgrq1HwtrnpzDihvLJIhdwIHXUmZslB6JyzFwG2p/4vZ+aXBvFKuz/MfITvV?=
 =?us-ascii?Q?HvhRX0Wxr85TWyDv3iTHlci61zo9F7Q3b+rqpxGdFwerCYbKEvWm5cVvEdx9?=
 =?us-ascii?Q?1jt19P4a718scUCQiBCLvf2CaspHw915AaSBR1eABxlarSYnEolNz+J46oEi?=
 =?us-ascii?Q?GNEmImcPI/FD3Qj3SjH/S1NczS4OyakL0GpCTIQ/KTq+aOxmJ4iBpPCfP97N?=
 =?us-ascii?Q?VlHZ8CE8g4HgUtBc4rTNfxoPjgqJ/rMYbwLAR+acQUOns3JBjXjwYt1/CdKi?=
 =?us-ascii?Q?wSff7Am/u8Odwyi/oV2Jmg1zzVN10lZsSsdu5UqU0PVyFfRuELeNEqjL78BP?=
 =?us-ascii?Q?7OrUGvLLW+QylKrkkmUqQ2uDOMPOUfRTOot6o8tGZ7B53gKxIm3KiN6aTMm2?=
 =?us-ascii?Q?GwyyKc93iBz1c9PHrstJsytUW4gCQNSQDeJT028OBxJKUKL6NO0dsyiyfr/p?=
 =?us-ascii?Q?CRCU/CnmVgNq41H/NlMzVOWiXzJyIngGhxE8jTAVHmRBRXOuNwdgqRfRN89M?=
 =?us-ascii?Q?z28BvdP1nOXKhTnv4ZC+P/+8/t8QeSQalwDiB4x3XCOQs+sJi+H9f3CALzQs?=
 =?us-ascii?Q?jriGMWwc970oCwdzC2BkxGwP0TeVaax6eoXMoesuSByx6BG3JSLr/VSmcJbe?=
 =?us-ascii?Q?4PzYZjck5tp8TTSq+GLg1qLc3hVWBOghsEe07qJgCLcq5/eX/tWibxylND4l?=
 =?us-ascii?Q?AfpKolE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qiObIa21sWeOgsEzU4WbAAuMemlHAtLG3qXvWMwVds859Jc5OfoLPEoU5tj3?=
 =?us-ascii?Q?Nyy1SJuXOsI2iXiqyWv5MiNchbTc3xPnP7hs4zHjRn4eD9VQzqK5xtChfavb?=
 =?us-ascii?Q?u+GKI2/R+jarP25/ITSkeb89D7eDkr5nI9xN59tNwqE3mK2FtdSPTYvixF8F?=
 =?us-ascii?Q?3nKTQc+kXI4YlVQ9k0bifsorcOPMzP15FvTZrHNCTSmaYWLTOkrwwcM6XIzL?=
 =?us-ascii?Q?lHQFgbnYjKJ4jmO4Ll3p6EsDiUFGTDpwsVzO30kAmtTQyHn2mLFmadJv54Et?=
 =?us-ascii?Q?7lZPlEZVtrZqhq87po2cudoUWverxfw5hsFQLnYUjRc/FE3Dq4LZvqPo8djR?=
 =?us-ascii?Q?GkBfIL77Mwoz2WkG2OZRWaDxubpJ0qeHElmxy0Cgo7rFADnZkIse0EUp2itu?=
 =?us-ascii?Q?WVmw5Tlq/lSsmrVRonp+7xjb+YluSuEVFqRDGFKtrSE+1ezM2qdVOeNE7TR+?=
 =?us-ascii?Q?XdDk5uFtoY/YzjsVM3vpCWuvYsWj5hVzP2KqB2/fF9dareZQUEGSlXea6ZOp?=
 =?us-ascii?Q?TDa+kgHt9QZIdPXFoi7GUrVJipj2RBenZbFxDMKaNavPnkAB5YOzhxzWkajo?=
 =?us-ascii?Q?gYQBlXKTJXjj59XsfSB9ZqltwEsjjoJzovT4svZiQArZ9CUwemyHLCNOGVrv?=
 =?us-ascii?Q?Zdb3r1hqQ0pt2TWbp+R8Y2KAvGY1Ra7j3kzyPu0Fz+RwGs1FcdLEwFz2J3hZ?=
 =?us-ascii?Q?1I/GViP95N6lbAmn1FdP/H2rwSEud6W1zITxEUsMX7YrBVVsjgCedRbQU0gt?=
 =?us-ascii?Q?4eXq12lAL6jWzuhZL3cImJKOvATAskoJ8Wiw3fhxxovdXmX3+cw4d3n3KlSq?=
 =?us-ascii?Q?vs/WOG2TH3E4Tmlnu7gUEbaw1isj0VxyHH/rpnlWkdOHGryrcOKdeA6UYCUM?=
 =?us-ascii?Q?Bwa7lssZ66BgOj3mt66isqVBrvc+iOOXLg16yPtMuMmSMx1/P7BMD7/XXvYa?=
 =?us-ascii?Q?hm0sD7bWTtX7SPvQ3ESnqbNXbx6St51cnR3cX+AKGBnFkXGOYX/67OUrJXcu?=
 =?us-ascii?Q?DpCUXxjRXuC60KbMi10vY2AcdFRHTF51ZkZLwmLU/nCcv5HxSiThdJqd+E6C?=
 =?us-ascii?Q?cJ6j0kEz34pnVgysH1/73YvtVyh57UfW70pjNN5azmm7QOixuf5OY2OWDIzm?=
 =?us-ascii?Q?rdHs+JiylJCoE/+H+b0iuo7zBIEbEo438yucxTC5i2lOj3OrHQFBpBAybvyO?=
 =?us-ascii?Q?wCE9gJvWoJJ4UXiWJY9DX00tkOiSq8DzvcxtzNFrGSmk0lgVm3xQXuX6FMZ8?=
 =?us-ascii?Q?z8BTEjD+dFw3x/mQlRwXnoZcQqg+ajFMtKh7WCYuhOzxlYQdE69XSHjpXzfs?=
 =?us-ascii?Q?sGOI28L+v4689HL18Ls5YXhxyYagziuhztayVHbbRkonSxiaa9bltSPTTRrJ?=
 =?us-ascii?Q?/gnQ3LxPMXWCVLe611x0InB+PxaD++/KtImn6DPGsazRvgKgSMCCgTIRd0Ah?=
 =?us-ascii?Q?3BSm4O5UDycOKKgem2GfzWt09HNwS6Ym3u9nxVxuZ9ZScv5/1OHFInXLiI5I?=
 =?us-ascii?Q?KM70vfIAlMVpqoP1XMyTLR2zvxwVj36pXMTD1mL/7Ow9lH5563CFVJx9AjVs?=
 =?us-ascii?Q?/Z1dj29JA5nN8IlaWbcSOzb2c9tGyuPgGLsvVV2V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bcb5ec-7ef4-4fee-0efd-08dce92ae20d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:55:57.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARrAfaxu4zUU3AwSQgwCM+GxR8h9Ji+xn/2ElEijxj7vogh57LctC7KaDwf6xTv1TMIrzM7sypxDJ+qn3mqO/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
Add i.MX91 related clock definition.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 787c9e74dc96..6c685067288b 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -204,6 +204,10 @@
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
 #define IMX93_CLK_PDM_IPG		201
-#define IMX93_CLK_END			202
+#define IMX91_CLK_ENET1_QOS_TSN     202
+#define IMX91_CLK_ENET_TIMER        203
+#define IMX91_CLK_ENET2_REGULAR     204
+#define IMX91_CLK_ENET2_REGULAR_GATE		205
+#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
 
 #endif
-- 
2.34.1


