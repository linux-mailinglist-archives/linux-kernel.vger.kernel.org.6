Return-Path: <linux-kernel+bounces-401392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3544B9C19A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520551C2248C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53171E1C2F;
	Fri,  8 Nov 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PXGwbTUn"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72DB1E230B;
	Fri,  8 Nov 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059899; cv=fail; b=TKk3UUNfCLeXSGbEGYwQ9EiUtGJYM9+gaLu/7cOFfDOtkcWe/KrEMutHTTFY7/2xdQufC2YkBRlUuOyHqsE48Zb3QwCYa2/axPlEko48fhcz89w6/oYPF+Uy6GxJ+2ByKl7S3r+CYWYFoA09CXXBb0uc10MMMt6hTdQ3VxQHvLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059899; c=relaxed/simple;
	bh=I14xjz8WMCZZVEI+gnQ3tkgS8t41lbnlrQaJww6umTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZRAVxg8MZ39iFdcKwkV/hYTUWU1Aoeln21XfuEh3Ufi5gdjPbkONNJj8S56/y6wsdWcaINaS9ktiJzLKzaTu2BrW0EAcz9qPiBPCD/wBpGKK/4z5a8gxesrefvGaojFGiVibRTGvLRnaM4LKah/o1KP5rdYl8UveBZBnYo/Kic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PXGwbTUn; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APxhwnTiQadIGvDInD8lAJMkFZNShYIX4CHF0bsXiJ7Irf9Ob8sldwttG/nA/jEHOPilWhk88N/s8h9zNwDpqW3k2w/JVPWcyrCPKQ57LnQ3ShY9oZKI7U/odJ6px//wSmv9ymEQ1Er1ZUiVB2yIrZHdiv8IZHsGX4OxTozBxDIA1+o7v1M7UlvWcDUYccPbwskwKry7VxR9pIfB3h/FEtv78Nut08K/Rf+mKvg7fLUsIYF4e00AECpRDEWvu8iEAoSZC/4ZD5bHUs1DxVu52p0pVZ+di046//DmDy5Eb3eoOJSHz1cvvRy11wd7CCwiksXVfKUz7JtM5R33rz9+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CKOq99tMiwyPMxgyxrLGGQDkuAP7qc1CcH68gYRRrA=;
 b=NODTY1w0X3FQJewXDV7CGlOr1wnhhooDIVejHyD50RPG3XSYJLLBMffKON1Nz0YqfgrFhheCu7ElLm3xrTYiT+L07zfvbo6XwV9yy8ffZFv5y3uevdMvXV4kvzC3WBI/GN71lYXPjOpV8RIKh+k0j/xV4ZtfRldL3vdnNpRgK1+2SNipNMBo286czIdH2BzuqymwOhLnarqlfA4J3idLE0j2+kzSspAStobttf0m672arWPxsqgruFMy1WeghedrxSc6kv1m7NpMe4mwqKrb4U2DZZrmgZSJBd7/w6OPqid+oHLASFF/aVZ/mtdD9MGpjM/cFqz0OfvtFcUrBTgwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CKOq99tMiwyPMxgyxrLGGQDkuAP7qc1CcH68gYRRrA=;
 b=PXGwbTUnEg/K6V9EHFhDpvHsn8fQ7MT4SLNBUvgim/Eplr/EPg6zffrbwCC5mWSckEhVqrRvw+RVYzN9SzFIXyi3/etYr7CPm527/chjBaoEq7oEyo3bjJGQJBnKytvZc6k+H7VaDioElstG0sGWPIILBQ/MftFD9gBXjIQlkEe0yQz/5gcRFMvqWsMeETGwJFu9s0yXSvKRuCE/MOaqGPg/kFfyxiTvbiJ7u2WWbEm7ccaGbDkO+NoX2DUYKc03sZnIqzrLGqMVv0/gHLXZBoc3RRip+abIU6Rv4A4ra+3CzToWNqvcrwfcGeavA4B1pkq80OalxpG0DUHUt+ZIAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GVXPR04MB10538.eurprd04.prod.outlook.com (2603:10a6:150:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 09:58:14 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 09:58:14 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: clock: imx93: Add SPDIF IPG clk
Date: Fri,  8 Nov 2024 18:07:57 +0800
Message-Id: <20241108100759.682260-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241108100759.682260-1-shengjiu.wang@nxp.com>
References: <20241108100759.682260-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GVXPR04MB10538:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e79502f-4b0f-480a-96ad-08dcffdbdc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hBJ5rN4IR6iYKEl82qefwfqUhjjBd8jzEvmS4IIWLvEkXTKKkngtfh2CKvrI?=
 =?us-ascii?Q?6UmNWYVXSr0eKTdO4rdvBQuQGvLrdiygWSBEVV6zE1DZ113eeW+fZhxtHybT?=
 =?us-ascii?Q?tGIhkFtk4QcVzh8iK5VRZcH/lgytBHmOOzKh5UETrpgp/lWWQfAnVs0crswW?=
 =?us-ascii?Q?saemllOxj1GdD/A7uJvnBkPCUr0EFc84gm2hu+S6SlyPB0VFunPkqA/1vveA?=
 =?us-ascii?Q?sIon4iy2CvXQ7g6OGUnQVrwQ70XobUunzLCU9Ec08Ai9Y11p7MmpcpVib8hz?=
 =?us-ascii?Q?RqYbmsopBm4NNRH6kffjUQzRBSfTplvcMbx1A1RxTFbRicHEL3qMlstdKRE6?=
 =?us-ascii?Q?qRBIYFNn1Ypt2ukrRLvo0oYnEgWsPrCUb7DjKQCJCtqfU2NoecC2s1XVG1r0?=
 =?us-ascii?Q?8Ault4FOa+ccFD3MdbsSKzdADnJ8rTsLqT31or5iw6LWEMMfSnoDt8YoIq1E?=
 =?us-ascii?Q?mECxVPWWu69dqfGeEUUdYJiicTeP6dB8oox1efK5zsQEpXpsBh0VAP5CGd5I?=
 =?us-ascii?Q?o6cnvP1ivkKUcwLMopev9FdZytpEK6X8Ej7N1YV7xjROysz3ynU5ztjaEV+z?=
 =?us-ascii?Q?6sItgUjdXoJuR/tQCC3tPUGT1c37DS+Ntw970/oNdcIW6Wwn83B2kUCUhe0V?=
 =?us-ascii?Q?BA5WzxbdDIn8JuGALqmNCwDYj9LyisO8fopxzVLDP5Lo3tEtxLClBVYqum5I?=
 =?us-ascii?Q?dwAPzpKtJjPr51YfqFsqCR0fq+tlzbW9ptBx0z/YlVcKjOqZkRDJF3EByytP?=
 =?us-ascii?Q?GdCAUUIYqMTZkdqfZSybL4DViCpEP3nCiiqNz/0MDe2UU7xhoPZ65Q1UOkvv?=
 =?us-ascii?Q?oVoNS2rN2FlKJpH1Nf1pEoKPfuQwqtAskkZ6D6jcVS04DbIaHIx38L/CGgL8?=
 =?us-ascii?Q?DJ8mRf1IooyfWZUwKITvG3HrHVOcNoOUJt8ngRzI/YsGyVeaURe2jMID+7yn?=
 =?us-ascii?Q?fcXEP+egZ4K6GD02gYSsgHI/c/65EZWwCNkecHDZIJ34/pRb7oOO02kiqsr7?=
 =?us-ascii?Q?QVAOUScY7h9P8ln6i1klsy5W5R6R4UUCGNU8gXzEtWb9eXOuFdSJa9mDDNuy?=
 =?us-ascii?Q?tuC/zVGt2cHftVpE2qL71elncrTFmb+JB6Er957qjYZIWCZZiiWVeyVnVKUm?=
 =?us-ascii?Q?YsEEeZnLi96yisRPLOp3oL6GTeq9h/xNFku7VLmkBLjpJJqU0+JEULpsTY36?=
 =?us-ascii?Q?h5dVzAefRRWJeNymwRrDcZuDiJDGRhmakGSxU2dU3/mPb+xm1gbxEr6mzrDp?=
 =?us-ascii?Q?mmz2JRUuY1Lo+yttKPKfTxD3RZo8ZVRPsk7SujLrhSKe7FVlHbXc4SpVQM7T?=
 =?us-ascii?Q?hI66uBDqH6yfa4Zn1Sf2/sVyZnMA9uFUQgECu9b3qCe20iOOIfIn9puw6OOj?=
 =?us-ascii?Q?F/k0aoplGW15j5nuYw9ofkdM57WY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s7wIo4GG9TUsXqDozf33E/AF8Hf6HGTy4QeQj2jNi3AdgwqxM+0nRX93qaSe?=
 =?us-ascii?Q?4BrXYT0RKLyOCaBRhE2HXGhSU9zk1tmRU78UQTkYLO2l37HJqDb12x1LylJ7?=
 =?us-ascii?Q?zW4ibT5yhIYTVucAMvyowwlc9za0ONF2yvKBf4jF39FSg2VuXueBWxnU2AuQ?=
 =?us-ascii?Q?E7dCycxmhO2HoFwjrjeFnyPeKFeEZEn7jSusAD8RUSG+JDcZg2JoWijmdM0U?=
 =?us-ascii?Q?/UEgVMith8elC6tEIrC75VlWvFrE4CloT0qAcM6ueCnqVAnAA6FkG6dAhkM+?=
 =?us-ascii?Q?NMjWmEWAjL6lVrNnavC734BZQCVIBfr1A2K6AXtli+2PUX8GHEr7cgdBuoO0?=
 =?us-ascii?Q?unGdfmdM6h5cK53SIItf5Uu8rUFNnPRZgWNskWxKbDowFldeLziFLL02zyaR?=
 =?us-ascii?Q?1onuCEakcRpzaQBxUYrN3KBUS3/Sje3YMXdGhesuvNqTeWgm++HX47R+HW/r?=
 =?us-ascii?Q?+QxhfiPuQZFZghsQocvoGFWyBs+JXwot8+xfG48hEPkwnlAte5/ZQ/Ezh/1y?=
 =?us-ascii?Q?e/mv3AcL1xye554aV1HDR84heHKY13ujA2DhpSv8Om6lY5kGq4nWPFKx+JGG?=
 =?us-ascii?Q?mm4nAnUY3lBCbrTAivFLcXtaGODt1Q5bdIpEb5ktYuUkzVz/rdinegijR745?=
 =?us-ascii?Q?b3Hs0b3hOqlrJ3k6p7Q2NSp5mplOOBQvTH+7dAtLn16z+B/yMy5J7A4PRVtU?=
 =?us-ascii?Q?OUpp8mjCIFaLwVMQq5ePKPe+LU6V5iXfgxzAdibvNi+RZOYfWMUpcGXgLQt5?=
 =?us-ascii?Q?Qhy5k03OVE8uHVxh+mB2pS/2U7AxOty7q7XEQAKgQFw5mdNickbCBLjEQvk8?=
 =?us-ascii?Q?eJomUOydBuu+IRvu2YN3tA+cNcXMFGHvgqsH4agI2ySi0qoaWKtaB8xyxHfU?=
 =?us-ascii?Q?+gojbAfOP+RMM1GeWWmPZ5odzCCa06slg01VvhiOrwdlSLUvWt6V6DvyhOYo?=
 =?us-ascii?Q?ZEZDzxG3wUj17FOfaJHHPl4lb4lphhWGvf5pbuFPRXmnbcy/rOUMop5409yv?=
 =?us-ascii?Q?GlVldXPENdnFsdqHl97ljfnwJd2NQDFEBbSj+mguR4FeHGUKvHaIapuZapY/?=
 =?us-ascii?Q?n7pEFdVxf4GGkkF9LMaH6+QZNbmWCy0f6KIs4ZCNTBoAv4gNFxce+tV2Wzwe?=
 =?us-ascii?Q?ss0SW0P5lF4+z1eRrT91wx9hoCPgOoTMUWn3F1c3sYN08ccadntpyb2yBWk+?=
 =?us-ascii?Q?ohSdARr1A6Vty53EwUyyOQH3GEXsFJAQzlNLVCwQCfB9WPhTvSrlk9zeCqt2?=
 =?us-ascii?Q?PNYOXL4COjsCNdpAOluCECRBtC8vg9hKm3gHNu8mPR6HHbVa8rUHbgJZJGpN?=
 =?us-ascii?Q?SnXJT8rWAknXeLGQmlvNGkXUwEWa61rQ99SOnV1brJx1hRswIknZEkU29WSA?=
 =?us-ascii?Q?clDQVwQ2xePx3TPyKX9PP1sJm8Wp6b13vPB8c3pk7LYK/8PG1vfANGf+bf1G?=
 =?us-ascii?Q?4pjl5rXjfbVOAK2XYa23xhTM0gDh7eIRgy7WkAdEhfcYyhkCgHvOVEwH9SP0?=
 =?us-ascii?Q?xqABcyPkXYK0l2Uojf9iB1LcFq/0pKKe4wpZEILKM8urx02lA2nTfHwlHQJ1?=
 =?us-ascii?Q?YEdPnFESHuwzbjeYwfopU+CALBism+Y5FvI1Rs2A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e79502f-4b0f-480a-96ad-08dcffdbdc4e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:58:14.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oni7Fq4T9+5wdYBrTL0TeWXxp0+f2p70TfZtmGaabr6yoKIead9ZdG2/iJmwtFjqVRoLZieN7r9z4wPYJ5qvaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10538

Add SPDIF IPG clk. The SPDIF IPG clock and root clock
share same clock gate.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 6c685067288b..c393fad3a346 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -209,5 +209,6 @@
 #define IMX91_CLK_ENET2_REGULAR     204
 #define IMX91_CLK_ENET2_REGULAR_GATE		205
 #define IMX91_CLK_ENET1_QOS_TSN_GATE		206
+#define IMX93_CLK_SPDIF_IPG		207
 
 #endif
-- 
2.34.1


