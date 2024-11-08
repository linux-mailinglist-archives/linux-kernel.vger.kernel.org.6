Return-Path: <linux-kernel+bounces-401462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF289C1AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A793F280CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E171E47AF;
	Fri,  8 Nov 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OXaOhNKM"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2072.outbound.protection.outlook.com [40.107.249.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3371E47B0;
	Fri,  8 Nov 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061969; cv=fail; b=i0rWgN4+63gScRVUJDEWBkZhoi/ToR+eMICsivezut7hF1h1nqMx1LeMTIOX3K5/F0KaCYnE7ay6tEV24HDx6S1/5sBIoGv8BiGtqbBDAMc9r7vxXde19HraQORrTjkbrE0C9fuxhbcTKxxytqo6sMDsxvFFrQ7rbbbXoUQw6N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061969; c=relaxed/simple;
	bh=KOFF2nFtnuHXsiZoJRu9sfm7cP5kCm10dY8CE8ltdmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xkoj4uZiAWGxcuJFs6Hy0ZPJs1bbEEImZ18OIQSyiPBee2XD6awGv0qJW+SzBsJsGPhi2NKbOIyu2u2KwV+cpYjjVXmJgAcupAv5y10LuXko0gD+Qxa0VDl5Y5DwI838RRLNIVD42g6DQVKobfvFwjyUov4qDiLYweFZIKb1r10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OXaOhNKM; arc=fail smtp.client-ip=40.107.249.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf8GJc/7ZoCw69RRTJc/o5dxiYyjJOOuznACN+vek5+2PZdS2OSyHZXwGiAR6xxzbWg6FVsvbeIlNPSTA6RlBJzcYXE/YfBgYX+BpZMMsBIlhPTI6EuzFLTURFmrSpQXokRFpRdr5k3SwVje1x/aanSUpoWzvGNwmxyQTwHiP9Dcpg10sXo8lxhtuJWv/Xg8s+gq6zmrE6H8D3r9gkQ7iP1827py8n5aG1EGXEHI6J5IlsxME3HqYuy0zXgGNILc4cTPfBu67B4Do8LYHr1d1WCLo9Z+zLeYCQqjeTlvDIOrfpihcaOU0MzKOx3I8QfnBp90v4jSq5juJ3FJ2leP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ka7VCInlw63WQzY3Scgr1/cWzgN4t6tnscN22ApTBo=;
 b=ngOqa/673xMw3pgvH3wrhqnlxnTEKvnmvCAhaSOKufFf6MQ0guXdQd904AviMG3gMrIZKaotillvosiAljCkdgK6LFm0PPOkE3IjC4/j/KQV/WuxZpbK55UFCpP9pCmKZ88lR0vo5MXcPByZZSUC59MejtzTKVgbMPM5z1SnH+sBUDpqsmeSU6ydraCKfpRbDFXOgrwcpsLiLOZQDLYbI4bRFpjHNEc+9XYFSPsuHN/R83D3GAv1uN/0y5Cvzydu8izguZEYX9B5iRLuXsDSWLDWbE89Z+brGIY+S4aFpdqjd59E7QVvXiCLmphgVws7FmFGhyOzuEussKwsmddLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ka7VCInlw63WQzY3Scgr1/cWzgN4t6tnscN22ApTBo=;
 b=OXaOhNKM68g1bTmcrIsHLaVpK0Hz6Vz6zcczimG4ddIzJCLonR+L4hYs7ff+2twMeOnLuvhv0Ov1jYvyYp4kiyO0PUfC23NNCukbzniZZoNyhCxX0ruFo3q3ybpiTLtpsYDueTb2Tsc0zyrWkM1A3HR17BmX24Fa8pwjrbDEqJF69UBCeNx27wyEAEy3pNiTNKsja8vJkqTMh2S2TgwB/b5XOxgICurS0GvgCoVWae5toRUkZQNMArOW4lDwMDaQpMJr1Lit9botTNDLkiekW/g+OwqsPimYrzFdZV7nx5vILaLQMUw7g+Q5z8isralCXZThJYHwb+N2z7gzSZYg/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 10:32:40 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 10:32:40 +0000
Date: Fri, 8 Nov 2024 18:31:48 +0800
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de, marex@denx.de,
	hvilleneuve@dimonoff.com, peng.fan@nxp.com,
	alexander.stein@ew.tq-group.com, m.othacehe@gmail.com,
	mwalle@kernel.org, Max.Merchel@ew.tq-group.com,
	hiago.franco@toradex.com, tharvey@gateworks.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Message-ID: <Zy3olDIp2PIBt9yr@pengfei-OptiPlex-Tower-Plus-7010>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <20241108022703.1877171-3-pengfei.li_1@nxp.com>
 <20241108030532.r7akgybtg5fmwvsu@hippo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108030532.r7akgybtg5fmwvsu@hippo>
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DBBPR04MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d70a69-d5fd-42d3-e7b2-08dcffe0ab8e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?7ulKIPOhMu7c4Ev5LzfZmBVh1uXNsbiQPeWPZBCsftuWNXz1+C/Uy4WgVO3u?=
 =?us-ascii?Q?xzkj49fSDl431XEaxe+ZPN/5hPjapfzQSlAfdlXOwj4THlUfgxwCKv7ZyOP1?=
 =?us-ascii?Q?eduBLHR22XVrTcG0r8cVbdYB/Y2LGD+Tgp/agLAOLpjnZy2oM9WRekYhGsqS?=
 =?us-ascii?Q?ckZQoauOfOEjSG8tyq7f3dMf79glcLS/NbCQyUcC+/svrtd1GwfNl0nJzYGK?=
 =?us-ascii?Q?1JP9eBMhnvyek8BWy5rZ7zAs7Gy95iL1E93SkpXZk/LeFOCTnNN9FxaWD7Xd?=
 =?us-ascii?Q?wb1zobsmCbb5koK7QuJgQIf/y/q6yiwBr/3Cms7I5MrKiJWPq4x8fzpv74h2?=
 =?us-ascii?Q?cUURez/u0XWi6omSn87IE1IbPHLabmIYwGqXCJBgSs1cKSqVXMn+v5r6u2I1?=
 =?us-ascii?Q?iJhE78TEmPsVwIcNhdz2o+GSkQouv5jijk8hOYFSC+akr6yGnAx1PAEhPu5M?=
 =?us-ascii?Q?B2dA4XdNVErZJ+fgMY6YTarejV0EQ8AAgwFq5dsKznZMIUth0wOtPPkI8Cr4?=
 =?us-ascii?Q?r1fVXKssf7cvnqC4vgLny7BSfZlFcC5a6zhcoMelr3Sx+hH866UChIiAGDpp?=
 =?us-ascii?Q?D9xZ8STXRfCXXc6PaasKWX8aYVHD7Km2soHQd6fyAOtyDB1N+cFB+UYz11ep?=
 =?us-ascii?Q?2sLUyJkdf6/gDnx5jG3YdCZS+Ee2aQLHcVRXnxJC/Sf8vFw4t9Z3hQzIm2YC?=
 =?us-ascii?Q?AcbVLBiqPHsXQIguSKO8hnMq1DQjInBGjhGByuQjVVa0mv0VU0XsK68Ggp05?=
 =?us-ascii?Q?KnoFn5nT3J6lKWwDUo5bm6CnzHVUDl+scEPx6bk6fr78gwm0vdHxKW73JOC4?=
 =?us-ascii?Q?SgYKGkxHMskKOHVAPQBvHfCIE65IZtWalCH1u6iBvG9RCCsBh6AF7fE6DRSu?=
 =?us-ascii?Q?lTiw2OXXzOLGVfdWiigYpA1T2IqC8o9tlezRva+BVRkRefelUtLBM79xDaV/?=
 =?us-ascii?Q?ZR77R8m5Cs1cV4lm9Qkv8QO+cDJdWR7dUAYVgEbQzWczDaeRMq1O4FzC142R?=
 =?us-ascii?Q?f+NLHMcR/XqCdHaI9dp+SwMvFgbRcwWyFTqq0r+wHUJ9TcRvEr0GU8lINkdp?=
 =?us-ascii?Q?QUjQ9V6al3q4pEqBsiwcMZFfFn7RkUCFI11yy1NaknRTZa0UMFs9rseuaQn0?=
 =?us-ascii?Q?j4ikrsQ1WxsxDvOTa2RB3EZKQDiZlUW77wvE9NXOXV7HSQ8biXUIJTIaIbWx?=
 =?us-ascii?Q?xw1rPk+N5EHZpzj5GyrKTF6VvuP17K0BJSnTSUnujmYK6tVY+Hbu5dT+m2EO?=
 =?us-ascii?Q?tOWTkP1+yLc5Erj0pSpRj6INuXmXjyVXXEZHyvxtbpPp8U113fbLBc5u/jBk?=
 =?us-ascii?Q?vhMGGudUAGXNIOs5K99xYMzH?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?OA0HJAjcH34kkI+2z2jfBN7vAi4kLE+MuCRZBmqmbTemcCtEWVwCA962osVU?=
 =?us-ascii?Q?foFCS/jxLuCEFBYF1wNkH9WahlQQeIwLd9JdXdLjhin8BS3BQTuD2Mpsnhr7?=
 =?us-ascii?Q?RMiafNORf93PwgSuU+mwq5fD2XWeAdp1uPROImq2Zl/ltxTfkgr7EBOYZ4FN?=
 =?us-ascii?Q?tfirdMNndNT9lD1lQgCTfvCZ9/DY+Caz87RrmTXOtBAnuj7wihyoNqSOsWim?=
 =?us-ascii?Q?cE3/ERDzs3d3pG2N37LAhGQq00PdxpF0/OK9Vj1z55+MlTyXtEXU5u+eyuQm?=
 =?us-ascii?Q?1aSJOfSWEUGknfmCAA2WTM9NMKg0SFPiyn4dEfeWUfTFjWrtj5WqkCe07pya?=
 =?us-ascii?Q?c4oS9qEyOwcBDjUM9UCOgIEfrH/XMCx+wHl1UMuZLtv51BeyIyt8/aSqIZq+?=
 =?us-ascii?Q?RoSbWfOXPr93ZW9lchDD5zMGa9W7eWY3pjgR9wq57+YstMhsY8M+TNknF2Gg?=
 =?us-ascii?Q?d/y3MvKIYjvdFxsKKl0t2EJsB4AnRSTxzbqr+07TMdzRX29Qadxd1XIIqW4i?=
 =?us-ascii?Q?xywpp9z7ktpYOXo4bAIU13S1XeWr+ekEQ7hjs8rm81UnfC99GRL1R9R1egl5?=
 =?us-ascii?Q?naxGckzzof8fX7JW1SfTqk0pm04kMYIlDeIznY81i8l83jTO47WcBUN0XLNR?=
 =?us-ascii?Q?XVOzH6/pPHzHBcle+SGd7XeC3O89Uh0G/l/RSOnDRJyIeWUSUwkWM8ZkHtJ2?=
 =?us-ascii?Q?ZobnJYPlYFWG2dG1u7LHOdYjvXOh6yXk3OlYxhOxpWDOc+iVCsnUrYbMeROB?=
 =?us-ascii?Q?G6vKAZZaDKB6HIIUidoxv6MSpze0wsYGNckGfQEww+ziB56aCXM3g7PkBs1X?=
 =?us-ascii?Q?54BH8c/v2iyPq1VkDl6rao3Wg6nqMU5JIg8vbR8WtjiOsRBhfXcld7GYEmp4?=
 =?us-ascii?Q?wcOeGx/3cimC3qPIzBHo5ybGywf63rv7hET0xA3CkKwO1OQqpIvRt1Zge4t8?=
 =?us-ascii?Q?ETZJXGnO0MV0taHDwY9ivnahNOno5DAENUffFIWO18vNnSo0UPecHlVcv2Ot?=
 =?us-ascii?Q?BDdM1jLoJlDIKQU40dJC29a+r3NlylKI9e25ptmHDTctglTqKUvAgAy4sGEV?=
 =?us-ascii?Q?j8JqAHmvBBME2/aqJMQASNNoe26HPDf6JUSpTxbugcTRsRyJUpIyQqQt+Gki?=
 =?us-ascii?Q?A2adJGHzpTYuQYC1/gCXgceEAbmWDha6orNlcisqvXWDelNSpvoc7EoMCBJB?=
 =?us-ascii?Q?O0uYnK+fXpslkKWB932EF+DY0aJ+R9EJdRaCCHWOU4jODV/mQBN+dFNcRi1N?=
 =?us-ascii?Q?qttGiR40PIwsGaMTCDljEnubkawgiIc/JdfxTYKufc6qysBuJbilxMptxr8i?=
 =?us-ascii?Q?tRsjyv56Nq5joTIHRMTXifyrxbxaTIX+WKu+iRHPPGjvHvynbF8qpkfgaWhB?=
 =?us-ascii?Q?eQd6Rv1fUK+j8x+CaN+l4Wue93FNUS0NCltQpO7fz7fhYyeR7j0CUep7Ko4E?=
 =?us-ascii?Q?+OsSr+d2SP+8y9VP0nAa2Q1p+Re91kmk0hppEw/CHYExd2bKdYBntexnHKro?=
 =?us-ascii?Q?Z+EOotG+6USa6oSYaKOAQzEd+ISm+Sd2lEZJdeghbCYv19+x2VUDQ0HCgTyU?=
 =?us-ascii?Q?u4SX2E0EkzMC9dNTqoGfsKZdg4HLpOm4kpTAOMqi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d70a69-d5fd-42d3-e7b2-08dcffe0ab8e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 10:32:40.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msC+xppv3IvdrZxrC8R9qGM938u7tcsNQZQMuJCq/U8pZzHcN6j6ZD0yQj0/9cWp+WHOgjcxnzs0j1FVHzACMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913

On Fri, Nov 08, 2024 at 11:05:32AM +0800, Xu Yang wrote:
> On Thu, Nov 07, 2024 at 06:27:02PM -0800, Pengfei Li wrote:
> > The i.MX 91 family features an Arm Cortex-A55 running at up to
> > 1.4GHz, support for modern LPDDR4 memory to enable platform longevity,
> > along with a rich set of peripherals targeting medical, industrial
> > and consumer IoT market segments.
> > 
> > The design of the i.MX91 platform is very similar to i.MX93.
> > The mainly difference between i.MX91 and i.MX93 is as follows:
> > - i.MX91 removed some clocks and modified the names of some clocks.
> > - i.MX91 only has one A core
> > 
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
> >  2 files changed, 836 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx91-pinfunc.h b/arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> > new file mode 100644
> > index 000000000000..bc58ce2102b2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> > @@ -0,0 +1,770 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#ifndef __DTS_IMX91_PINFUNC_H
> > +#define __DTS_IMX91_PINFUNC_H
> > +
> > +/*
> > + * The pin function ID is a tuple of
> > + * <mux_reg conf_reg input_reg mux_mode input_val>
> > + */
> > +#define MX91_PAD_DAP_TDI__JTAG_MUX_TDI                                           0x0000 0x01B0 0x03D8 0x00 0x00
> > +#define MX91_PAD_DAP_TDI__MQS2_LEFT                                              0x0000 0x01B0 0x0000 0x01 0x00
> > +#define MX91_PAD_DAP_TDI__CAN2_TX                                                0x0000 0x01B0 0x0000 0x03 0x00
> > +#define MX91_PAD_DAP_TDI__FLEXIO2_FLEXIO30                                       0x0000 0x01B0 0x0000 0x04 0x00
> > +#define MX91_PAD_DAP_TDI__GPIO3_IO28                                             0x0000 0x01B0 0x0000 0x05 0x00
> > +#define MX91_PAD_DAP_TDI__LPUART5_RX                                             0x0000 0x01B0 0x0488 0x06 0x00
> > +
> > +#define MX91_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS                                     0x0004 0x01B4 0x03DC 0x00 0x00
> > +#define MX91_PAD_DAP_TMS_SWDIO__FLEXIO2_FLEXIO31                                 0x0004 0x01B4 0x0000 0x04 0x00
> > +#define MX91_PAD_DAP_TMS_SWDIO__GPIO3_IO29                                       0x0004 0x01B4 0x0000 0x05 0x00
> > +#define MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                                    0x0004 0x01B4 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK                                    0x0008 0x01B8 0x03D4 0x00 0x00
> > +#define MX91_PAD_DAP_TCLK_SWCLK__FLEXIO1_FLEXIO30                                0x0008 0x01B8 0x0000 0x04 0x00
> > +#define MX91_PAD_DAP_TCLK_SWCLK__GPIO3_IO30                                      0x0008 0x01B8 0x0000 0x05 0x00
> > +#define MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                                   0x0008 0x01B8 0x0484 0x06 0x00
> > +
> > +#define MX91_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO                                  0x000C 0x01BC 0x0000 0x00 0x00
> > +#define MX91_PAD_DAP_TDO_TRACESWO__MQS2_RIGHT                                    0x000C 0x01BC 0x0000 0x01 0x00
> > +#define MX91_PAD_DAP_TDO_TRACESWO__CAN2_RX                                       0x000C 0x01BC 0x0364 0x03 0x00
> > +#define MX91_PAD_DAP_TDO_TRACESWO__FLEXIO1_FLEXIO31                              0x000C 0x01BC 0x0000 0x04 0x00
> > +#define MX91_PAD_DAP_TDO_TRACESWO__GPIO3_IO31                                    0x000C 0x01BC 0x0000 0x05 0x00
> > +#define MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX                                    0x000C 0x01BC 0x048C 0x06 0x00
> > +
> > +#define MX91_PAD_GPIO_IO00__GPIO2_IO0                                            0x0010 0x01C0 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO00__LPI2C3_SDA                                           0x0010 0x01C0 0x03F4 0x01 0x00
> > +#define MX91_PAD_GPIO_IO00__MEDIAMIX_CAM_CLK                                     0x0010 0x01C0 0x04BC 0x02 0x00
> > +#define MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK                                    0x0010 0x01C0 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO00__LPSPI6_PCS0                                          0x0010 0x01C0 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO00__LPUART5_TX                                           0x0010 0x01C0 0x048C 0x05 0x01
> > +#define MX91_PAD_GPIO_IO00__LPI2C5_SDA                                           0x0010 0x01C0 0x0404 0x06 0x00
> > +#define MX91_PAD_GPIO_IO00__FLEXIO1_FLEXIO0                                      0x0010 0x01C0 0x036C 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO01__GPIO2_IO1                                            0x0014 0x01C4 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO01__LPI2C3_SCL                                           0x0014 0x01C4 0x03F0 0x01 0x00
> > +#define MX91_PAD_GPIO_IO01__MEDIAMIX_CAM_DATA0                                   0x0014 0x01C4 0x0490 0x02 0x00
> > +#define MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE                                     0x0014 0x01C4 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO01__LPSPI6_SIN                                           0x0014 0x01C4 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO01__LPUART5_RX                                           0x0014 0x01C4 0x0488 0x05 0x01
> > +#define MX91_PAD_GPIO_IO01__LPI2C5_SCL                                           0x0014 0x01C4 0x0400 0x06 0x00
> > +#define MX91_PAD_GPIO_IO01__FLEXIO1_FLEXIO1                                      0x0014 0x01C4 0x0370 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO02__GPIO2_IO2                                            0x0018 0x01C8 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO02__LPI2C4_SDA                                           0x0018 0x01C8 0x03FC 0x01 0x00
> > +#define MX91_PAD_GPIO_IO02__MEDIAMIX_CAM_VSYNC                                   0x0018 0x01C8 0x04C0 0x02 0x00
> > +#define MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC                                  0x0018 0x01C8 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO02__LPSPI6_SOUT                                          0x0018 0x01C8 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO02__LPUART5_CTS_B                                        0x0018 0x01C8 0x0484 0x05 0x01
> > +#define MX91_PAD_GPIO_IO02__LPI2C6_SDA                                           0x0018 0x01C8 0x040C 0x06 0x00
> > +#define MX91_PAD_GPIO_IO02__FLEXIO1_FLEXIO2                                      0x0018 0x01C8 0x0374 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO03__GPIO2_IO3                                            0x001C 0x01CC 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO03__LPI2C4_SCL                                           0x001C 0x01CC 0x03F8 0x01 0x00
> > +#define MX91_PAD_GPIO_IO03__MEDIAMIX_CAM_HSYNC                                   0x001C 0x01CC 0x04B8 0x02 0x00
> > +#define MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC                                  0x001C 0x01CC 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO03__LPSPI6_SCK                                           0x001C 0x01CC 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO03__LPUART5_RTS_B                                        0x001C 0x01CC 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO03__LPI2C6_SCL                                           0x001C 0x01CC 0x0408 0x06 0x00
> > +#define MX91_PAD_GPIO_IO03__FLEXIO1_FLEXIO3                                      0x001C 0x01CC 0x0378 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO04__GPIO2_IO4                                            0x0020 0x01D0 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO04__TPM3_CH0                                             0x0020 0x01D0 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO04__PDM_CLK                                              0x0020 0x01D0 0x0000 0x02 0x00
> > +#define MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0                                  0x0020 0x01D0 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO04__LPSPI7_PCS0                                          0x0020 0x01D0 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO04__LPUART6_TX                                           0x0020 0x01D0 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO04__LPI2C6_SDA                                           0x0020 0x01D0 0x040C 0x06 0x01
> > +#define MX91_PAD_GPIO_IO04__FLEXIO1_FLEXIO4                                      0x0020 0x01D0 0x037C 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO05__GPIO2_IO5                                            0x0024 0x01D4 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO05__TPM4_CH0                                             0x0024 0x01D4 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO05__PDM_BIT_STREAM0                                      0x0024 0x01D4 0x04C4 0x02 0x00
> > +#define MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1                                  0x0024 0x01D4 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO05__LPSPI7_SIN                                           0x0024 0x01D4 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO05__LPUART6_RX                                           0x0024 0x01D4 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO05__LPI2C6_SCL                                           0x0024 0x01D4 0x0408 0x06 0x01
> > +#define MX91_PAD_GPIO_IO05__FLEXIO1_FLEXIO5                                      0x0024 0x01D4 0x0380 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO06__GPIO2_IO6                                            0x0028 0x01D8 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO06__TPM5_CH0                                             0x0028 0x01D8 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO06__PDM_BIT_STREAM1                                      0x0028 0x01D8 0x04C8 0x02 0x00
> > +#define MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2                                  0x0028 0x01D8 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO06__LPSPI7_SOUT                                          0x0028 0x01D8 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO06__LPUART6_CTS_B                                        0x0028 0x01D8 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO06__LPI2C7_SDA                                           0x0028 0x01D8 0x0414 0x06 0x00
> > +#define MX91_PAD_GPIO_IO06__FLEXIO1_FLEXIO6                                      0x0028 0x01D8 0x0384 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO07__GPIO2_IO7                                            0x002C 0x01DC 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO07__LPSPI3_PCS1                                          0x002C 0x01DC 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO07__MEDIAMIX_CAM_DATA1                                   0x002C 0x01DC 0x0494 0x02 0x00
> > +#define MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3                                  0x002C 0x01DC 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO07__LPSPI7_SCK                                           0x002C 0x01DC 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO07__LPUART6_RTS_B                                        0x002C 0x01DC 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO07__LPI2C7_SCL                                           0x002C 0x01DC 0x0410 0x06 0x00
> > +#define MX91_PAD_GPIO_IO07__FLEXIO1_FLEXIO7                                      0x002C 0x01DC 0x0388 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO08__GPIO2_IO8                                            0x0030 0x01E0 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO08__LPSPI3_PCS0                                          0x0030 0x01E0 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO08__MEDIAMIX_CAM_DATA2                                   0x0030 0x01E0 0x0498 0x02 0x00
> > +#define MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4                                  0x0030 0x01E0 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO08__TPM6_CH0                                             0x0030 0x01E0 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO08__LPUART7_TX                                           0x0030 0x01E0 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO08__LPI2C7_SDA                                           0x0030 0x01E0 0x0414 0x06 0x01
> > +#define MX91_PAD_GPIO_IO08__FLEXIO1_FLEXIO8                                      0x0030 0x01E0 0x038C 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO09__GPIO2_IO9                                            0x0034 0x01E4 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO09__LPSPI3_SIN                                           0x0034 0x01E4 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO09__MEDIAMIX_CAM_DATA3                                   0x0034 0x01E4 0x049C 0x02 0x00
> > +#define MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5                                  0x0034 0x01E4 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO09__TPM3_EXTCLK                                          0x0034 0x01E4 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO09__LPUART7_RX                                           0x0034 0x01E4 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO09__LPI2C7_SCL                                           0x0034 0x01E4 0x0410 0x06 0x01
> > +#define MX91_PAD_GPIO_IO09__FLEXIO1_FLEXIO9                                      0x0034 0x01E4 0x0390 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO10__GPIO2_IO10                                           0x0038 0x01E8 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO10__LPSPI3_SOUT                                          0x0038 0x01E8 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO10__MEDIAMIX_CAM_DATA4                                   0x0038 0x01E8 0x04A0 0x02 0x00
> > +#define MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6                                  0x0038 0x01E8 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO10__TPM4_EXTCLK                                          0x0038 0x01E8 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO10__LPUART7_CTS_B                                        0x0038 0x01E8 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO10__LPI2C8_SDA                                           0x0038 0x01E8 0x041C 0x06 0x00
> > +#define MX91_PAD_GPIO_IO10__FLEXIO1_FLEXIO10                                     0x0038 0x01E8 0x0394 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO11__GPIO2_IO11                                           0x003C 0x01EC 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO11__LPSPI3_SCK                                           0x003C 0x01EC 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO11__MEDIAMIX_CAM_DATA5                                   0x003C 0x01EC 0x04A4 0x02 0x00
> > +#define MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7                                  0x003C 0x01EC 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO11__TPM5_EXTCLK                                          0x003C 0x01EC 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO11__LPUART7_RTS_B                                        0x003C 0x01EC 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO11__LPI2C8_SCL                                           0x003C 0x01EC 0x0418 0x06 0x00
> > +#define MX91_PAD_GPIO_IO11__FLEXIO1_FLEXIO11                                     0x003C 0x01EC 0x0398 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO12__GPIO2_IO12                                           0x0040 0x01F0 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO12__TPM3_CH2                                             0x0040 0x01F0 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO12__PDM_BIT_STREAM2                                      0x0040 0x01F0 0x04CC 0x02 0x00
> > +#define MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8                                  0x0040 0x01F0 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO12__LPSPI8_PCS0                                          0x0040 0x01F0 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO12__LPUART8_TX                                           0x0040 0x01F0 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO12__LPI2C8_SDA                                           0x0040 0x01F0 0x041C 0x06 0x01
> > +#define MX91_PAD_GPIO_IO12__SAI3_RX_SYNC                                         0x0040 0x01F0 0x04DC 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO13__GPIO2_IO13                                           0x0044 0x01F4 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO13__TPM4_CH2                                             0x0044 0x01F4 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO13__PDM_BIT_STREAM3                                      0x0044 0x01F4 0x04D0 0x02 0x00
> > +#define MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9                                  0x0044 0x01F4 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO13__LPSPI8_SIN                                           0x0044 0x01F4 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO13__LPUART8_RX                                           0x0044 0x01F4 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO13__LPI2C8_SCL                                           0x0044 0x01F4 0x0418 0x06 0x01
> > +#define MX91_PAD_GPIO_IO13__FLEXIO1_FLEXIO13                                     0x0044 0x01F4 0x039C 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO14__GPIO2_IO14                                           0x0048 0x01F8 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO14__LPUART3_TX                                           0x0048 0x01F8 0x0474 0x01 0x00
> > +#define MX91_PAD_GPIO_IO14__MEDIAMIX_CAM_DATA6                                   0x0048 0x01F8 0x04A8 0x02 0x00
> > +#define MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10                                 0x0048 0x01F8 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO14__LPSPI8_SOUT                                          0x0048 0x01F8 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO14__LPUART8_CTS_B                                        0x0048 0x01F8 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO14__LPUART4_TX                                           0x0048 0x01F8 0x0480 0x06 0x00
> > +#define MX91_PAD_GPIO_IO14__FLEXIO1_FLEXIO14                                     0x0048 0x01F8 0x03A0 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO15__GPIO2_IO15                                           0x004C 0x01FC 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO15__LPUART3_RX                                           0x004C 0x01FC 0x0470 0x01 0x00
> > +#define MX91_PAD_GPIO_IO15__MEDIAMIX_CAM_DATA7                                   0x004C 0x01FC 0x04AC 0x02 0x00
> > +#define MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11                                 0x004C 0x01FC 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO15__LPSPI8_SCK                                           0x004C 0x01FC 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO15__LPUART8_RTS_B                                        0x004C 0x01FC 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO15__LPUART4_RX                                           0x004C 0x01FC 0x047C 0x06 0x00
> > +#define MX91_PAD_GPIO_IO15__FLEXIO1_FLEXIO15                                     0x004C 0x01FC 0x03A4 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO16__GPIO2_IO16                                           0x0050 0x0200 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO16__SAI3_TX_BCLK                                         0x0050 0x0200 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO16__PDM_BIT_STREAM2                                      0x0050 0x0200 0x04CC 0x02 0x01
> > +#define MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12                                 0x0050 0x0200 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO16__LPUART3_CTS_B                                        0x0050 0x0200 0x046C 0x04 0x00
> > +#define MX91_PAD_GPIO_IO16__LPSPI4_PCS2                                          0x0050 0x0200 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO16__LPUART4_CTS_B                                        0x0050 0x0200 0x0478 0x06 0x00
> > +#define MX91_PAD_GPIO_IO16__FLEXIO1_FLEXIO16                                     0x0050 0x0200 0x03A8 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO17__GPIO2_IO17                                           0x0054 0x0204 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO17__SAI3_MCLK                                            0x0054 0x0204 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO17__MEDIAMIX_CAM_DATA8                                   0x0054 0x0204 0x04B0 0x02 0x00
> > +#define MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13                                 0x0054 0x0204 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO17__LPUART3_RTS_B                                        0x0054 0x0204 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO17__LPSPI4_PCS1                                          0x0054 0x0204 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO17__LPUART4_RTS_B                                        0x0054 0x0204 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO17__FLEXIO1_FLEXIO17                                     0x0054 0x0204 0x03AC 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO18__GPIO2_IO18                                           0x0058 0x0208 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO18__SAI3_RX_BCLK                                         0x0058 0x0208 0x04D8 0x01 0x00
> > +#define MX91_PAD_GPIO_IO18__MEDIAMIX_CAM_DATA9                                   0x0058 0x0208 0x04B4 0x02 0x00
> > +#define MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14                                 0x0058 0x0208 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO18__LPSPI5_PCS0                                          0x0058 0x0208 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO18__LPSPI4_PCS0                                          0x0058 0x0208 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO18__TPM5_CH2                                             0x0058 0x0208 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO18__FLEXIO1_FLEXIO18                                     0x0058 0x0208 0x03B0 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO19__GPIO2_IO19                                           0x005C 0x020C 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO19__SAI3_RX_SYNC                                         0x005C 0x020C 0x04DC 0x01 0x01
> > +#define MX91_PAD_GPIO_IO19__PDM_BIT_STREAM3                                      0x005C 0x020C 0x04D0 0x02 0x01
> > +#define MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15                                 0x005C 0x020C 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO19__LPSPI5_SIN                                           0x005C 0x020C 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO19__LPSPI4_SIN                                           0x005C 0x020C 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO19__TPM6_CH2                                             0x005C 0x020C 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO19__SAI3_TX_DATA0                                        0x005C 0x020C 0x0000 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO20__GPIO2_IO20                                           0x0060 0x0210 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO20__SAI3_RX_DATA0                                        0x0060 0x0210 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO20__PDM_BIT_STREAM0                                      0x0060 0x0210 0x04C4 0x02 0x01
> > +#define MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16                                 0x0060 0x0210 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO20__LPSPI5_SOUT                                          0x0060 0x0210 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO20__LPSPI4_SOUT                                          0x0060 0x0210 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO20__TPM3_CH1                                             0x0060 0x0210 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO20__FLEXIO1_FLEXIO20                                     0x0060 0x0210 0x03B4 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO21__GPIO2_IO21                                           0x0064 0x0214 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO21__SAI3_TX_DATA0                                        0x0064 0x0214 0x0000 0x01 0x00
> > +#define MX91_PAD_GPIO_IO21__PDM_CLK                                              0x0064 0x0214 0x0000 0x02 0x00
> > +#define MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17                                 0x0064 0x0214 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO21__LPSPI5_SCK                                           0x0064 0x0214 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO21__LPSPI4_SCK                                           0x0064 0x0214 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO21__TPM4_CH1                                             0x0064 0x0214 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO21__SAI3_RX_BCLK                                         0x0064 0x0214 0x04D8 0x07 0x01
> > +
> > +#define MX91_PAD_GPIO_IO22__GPIO2_IO22                                           0x0068 0x0218 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO22__USDHC3_CLK                                           0x0068 0x0218 0x04E8 0x01 0x00
> > +#define MX91_PAD_GPIO_IO22__SPDIF_IN                                             0x0068 0x0218 0x04E4 0x02 0x00
> > +#define MX91_PAD_GPIO_IO22__MEDIAMIX_DISP_DATA18                                 0x0068 0x0218 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO22__TPM5_CH1                                             0x0068 0x0218 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO22__TPM6_EXTCLK                                          0x0068 0x0218 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO22__LPI2C5_SDA                                           0x0068 0x0218 0x0404 0x06 0x01
> > +#define MX91_PAD_GPIO_IO22__FLEXIO1_FLEXIO22                                     0x0068 0x0218 0x03B8 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO23__GPIO2_IO23                                           0x006C 0x021C 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO23__USDHC3_CMD                                           0x006C 0x021C 0x04EC 0x01 0x00
> > +#define MX91_PAD_GPIO_IO23__SPDIF_OUT                                            0x006C 0x021C 0x0000 0x02 0x00
> > +#define MX91_PAD_GPIO_IO23__MEDIAMIX_DISP_DATA19                                 0x006C 0x021C 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO23__TPM6_CH1                                             0x006C 0x021C 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO23__LPI2C5_SCL                                           0x006C 0x021C 0x0400 0x06 0x01
> > +#define MX91_PAD_GPIO_IO23__FLEXIO1_FLEXIO23                                     0x006C 0x021C 0x03BC 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO24__GPIO2_IO24                                           0x0070 0x0220 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO24__USDHC3_DATA0                                         0x0070 0x0220 0x04F0 0x01 0x00
> > +#define MX91_PAD_GPIO_IO24__MEDIAMIX_DISP_DATA20                                 0x0070 0x0220 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO24__TPM3_CH3                                             0x0070 0x0220 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO24__JTAG_MUX_TDO                                         0x0070 0x0220 0x0000 0x05 0x00
> > +#define MX91_PAD_GPIO_IO24__LPSPI6_PCS1                                          0x0070 0x0220 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO24__FLEXIO1_FLEXIO24                                     0x0070 0x0220 0x03C0 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO25__GPIO2_IO25                                           0x0074 0x0224 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO25__USDHC3_DATA1                                         0x0074 0x0224 0x04F4 0x01 0x00
> > +#define MX91_PAD_GPIO_IO25__CAN2_TX                                              0x0074 0x0224 0x0000 0x02 0x00
> > +#define MX91_PAD_GPIO_IO25__MEDIAMIX_DISP_DATA21                                 0x0074 0x0224 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO25__TPM4_CH3                                             0x0074 0x0224 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO25__JTAG_MUX_TCK                                         0x0074 0x0224 0x03D4 0x05 0x01
> > +#define MX91_PAD_GPIO_IO25__LPSPI7_PCS1                                          0x0074 0x0224 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO25__FLEXIO1_FLEXIO25                                     0x0074 0x0224 0x03C4 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO26__GPIO2_IO26                                           0x0078 0x0228 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO26__USDHC3_DATA2                                         0x0078 0x0228 0x04F8 0x01 0x00
> > +#define MX91_PAD_GPIO_IO26__PDM_BIT_STREAM1                                      0x0078 0x0228 0x04C8 0x02 0x01
> > +#define MX91_PAD_GPIO_IO26__MEDIAMIX_DISP_DATA22                                 0x0078 0x0228 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO26__TPM5_CH3                                             0x0078 0x0228 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO26__JTAG_MUX_TDI                                         0x0078 0x0228 0x03D8 0x05 0x01
> > +#define MX91_PAD_GPIO_IO26__LPSPI8_PCS1                                          0x0078 0x0228 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO26__SAI3_TX_SYNC                                         0x0078 0x0228 0x04E0 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO27__GPIO2_IO27                                           0x007C 0x022C 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO27__USDHC3_DATA3                                         0x007C 0x022C 0x04FC 0x01 0x00
> > +#define MX91_PAD_GPIO_IO27__CAN2_RX                                              0x007C 0x022C 0x0364 0x02 0x01
> > +#define MX91_PAD_GPIO_IO27__MEDIAMIX_DISP_DATA23                                 0x007C 0x022C 0x0000 0x03 0x00
> > +#define MX91_PAD_GPIO_IO27__TPM6_CH3                                             0x007C 0x022C 0x0000 0x04 0x00
> > +#define MX91_PAD_GPIO_IO27__JTAG_MUX_TMS                                         0x007C 0x022C 0x03DC 0x05 0x01
> > +#define MX91_PAD_GPIO_IO27__LPSPI5_PCS1                                          0x007C 0x022C 0x0000 0x06 0x00
> > +#define MX91_PAD_GPIO_IO27__FLEXIO1_FLEXIO27                                     0x007C 0x022C 0x03C8 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO28__GPIO2_IO28                                           0x0080 0x0230 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO28__LPI2C3_SDA                                           0x0080 0x0230 0x03F4 0x01 0x01
> > +#define MX91_PAD_GPIO_IO28__CAN1_TX                                              0x0080 0x0230 0x0000 0x02 0x00
> > +#define MX91_PAD_GPIO_IO28__FLEXIO1_FLEXIO28                                     0x0080 0x0230 0x0000 0x07 0x00
> > +
> > +#define MX91_PAD_GPIO_IO29__GPIO2_IO29                                           0x0084 0x0234 0x0000 0x00 0x00
> > +#define MX91_PAD_GPIO_IO29__LPI2C3_SCL                                           0x0084 0x0234 0x03F0 0x01 0x01
> > +#define MX91_PAD_GPIO_IO29__CAN1_RX                                              0x0084 0x0234 0x0360 0x02 0x00
> > +#define MX91_PAD_GPIO_IO29__FLEXIO1_FLEXIO29                                     0x0084 0x0234 0x0000 0x07 0x00
> > +
> > +#define MX91_PAD_CCM_CLKO1__CCMSRCGPCMIX_CLKO1                                   0x0088 0x0238 0x0000 0x00 0x00
> > +#define MX91_PAD_CCM_CLKO1__FLEXIO1_FLEXIO26                                     0x0088 0x0238 0x0000 0x04 0x00
> > +#define MX91_PAD_CCM_CLKO1__GPIO3_IO26                                           0x0088 0x0238 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_CCM_CLKO2__GPIO3_IO27                                           0x008C 0x023C 0x0000 0x05 0x00
> > +#define MX91_PAD_CCM_CLKO2__CCMSRCGPCMIX_CLKO2                                   0x008C 0x023C 0x0000 0x00 0x00
> > +#define MX91_PAD_CCM_CLKO2__FLEXIO1_FLEXIO27                                     0x008C 0x023C 0x03C8 0x04 0x01
> > +
> > +#define MX91_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3                                   0x0090 0x0240 0x0000 0x00 0x00
> > +#define MX91_PAD_CCM_CLKO3__FLEXIO2_FLEXIO28                                     0x0090 0x0240 0x0000 0x04 0x00
> > +#define MX91_PAD_CCM_CLKO3__GPIO4_IO28                                           0x0090 0x0240 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_CCM_CLKO4__CCMSRCGPCMIX_CLKO4                                   0x0094 0x0244 0x0000 0x00 0x00
> > +#define MX91_PAD_CCM_CLKO4__FLEXIO2_FLEXIO29                                     0x0094 0x0244 0x0000 0x04 0x00
> > +#define MX91_PAD_CCM_CLKO4__GPIO4_IO29                                           0x0094 0x0244 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_ENET1_MDC__ENET1_MDC                                            0x0098 0x0248 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_MDC__LPUART3_DCB_B                                        0x0098 0x0248 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET1_MDC__I3C2_SCL                                             0x0098 0x0248 0x03CC 0x02 0x00
> > +#define MX91_PAD_ENET1_MDC__HSIOMIX_OTG_ID1                                      0x0098 0x0248 0x0000 0x03 0x00
> > +#define MX91_PAD_ENET1_MDC__FLEXIO2_FLEXIO0                                      0x0098 0x0248 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_MDC__GPIO4_IO0                                            0x0098 0x0248 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_MDC__LPI2C1_SCL                                           0x0098 0x0248 0x03E0 0x06 0x00
> > +
> > +#define MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                                       0x009C 0x024C 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_MDIO__LPUART3_RIN_B                                       0x009C 0x024C 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET1_MDIO__I3C2_SDA                                            0x009C 0x024C 0x03D0 0x02 0x00
> > +#define MX91_PAD_ENET1_MDIO__HSIOMIX_OTG_PWR1                                    0x009C 0x024C 0x0000 0x03 0x00
> > +#define MX91_PAD_ENET1_MDIO__FLEXIO2_FLEXIO1                                     0x009C 0x024C 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_MDIO__GPIO4_IO1                                           0x009C 0x024C 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_MDIO__LPI2C1_SDA                                          0x009C 0x024C 0x03E4 0x06 0x00
> > +
> > +#define MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                                   0x00A0 0x0250 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_TD3__CAN2_TX                                              0x00A0 0x0250 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                                      0x00A0 0x0250 0x0000 0x03 0x00
> > +#define MX91_PAD_ENET1_TD3__FLEXIO2_FLEXIO2                                      0x00A0 0x0250 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_TD3__GPIO4_IO3                                            0x00A0 0x0250 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_TD3__LPI2C2_SCL                                           0x00A0 0x0250 0x03E8 0x06 0x00
> > +
> > +#define MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                                   0x00A4 0x0254 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_TD2__ENET_QOS_CLOCK_GENERATE_CLK                          0x00A4 0x0254 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET1_TD2__CAN2_RX                                              0x00A4 0x0254 0x0364 0x02 0x02
> > +#define MX91_PAD_ENET1_TD2__HSIOMIX_OTG_OC2                                      0x00A4 0x0254 0x0000 0x03 0x00
> > +#define MX91_PAD_ENET1_TD2__FLEXIO2_FLEXIO3                                      0x00A4 0x0254 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_TD2__GPIO4_IO3                                            0x00A4 0x0254 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_TD2__LPI2C2_SDA                                           0x00A4 0x0254 0x03EC 0x06 0x00
> > +
> > +#define MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                                      0x00A8 0x0258 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_TD1__LPUART3_RTS_B                                        0x00A8 0x0258 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET1_TD1__I3C2_PUR                                             0x00A8 0x0258 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET1_TD1__HSIOMIX_OTG_OC1                                      0x00A8 0x0258 0x0000 0x03 0x00
> > +#define MX91_PAD_ENET1_TD1__FLEXIO2_FLEXIO4                                      0x00A8 0x0258 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_TD1__GPIO4_IO4                                            0x00A8 0x0258 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_TD1__I3C2_PUR_B                                           0x00A8 0x0258 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                                   0x00AC 0x025C 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_TD0__LPUART3_TX                                           0x00AC 0x025C 0x0474 0x01 0x01
> > +#define MX91_PAD_ENET1_TD0__FLEXIO2_FLEXIO5                                      0x00AC 0x025C 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_TD0__GPIO4_IO5                                            0x00AC 0x025C 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL                             0x00B0 0x0260 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_TX_CTL__LPUART3_DTR_B                                     0x00B0 0x0260 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET1_TX_CTL__FLEXIO2_FLEXIO6                                   0x00B0 0x0260 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                                         0x00B0 0x0260 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_TX_CTL__LPSPI2_SCK                                        0x00B0 0x0260 0x043C 0x02 0x00
> > +
> > +#define MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK                   0x00B4 0x0264 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_TXC__ENET_QOS_TX_ER                                       0x00B4 0x0264 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET1_TXC__FLEXIO2_FLEXIO7                                      0x00B4 0x0264 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_TXC__GPIO4_IO7                                            0x00B4 0x0264 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_TXC__LPSPI2_SIN                                           0x00B4 0x0264 0x0440 0x02 0x00
> > +
> > +#define MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL                             0x00B8 0x0268 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_RX_CTL__LPUART3_DSR_B                                     0x00B8 0x0268 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET1_RX_CTL__HSIOMIX_OTG_PWR2                                  0x00B8 0x0268 0x0000 0x03 0x00
> > +#define MX91_PAD_ENET1_RX_CTL__FLEXIO2_FLEXIO8                                   0x00B8 0x0268 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                                         0x00B8 0x0268 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_RX_CTL__LPSPI2_PCS0                                       0x00B8 0x0268 0x0434 0x02 0x00
> > +
> > +#define MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                                   0x00BC 0x026C 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_RXC__ENET_QOS_RX_ER                                       0x00BC 0x026C 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET1_RXC__FLEXIO2_FLEXIO9                                      0x00BC 0x026C 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_RXC__GPIO4_IO9                                            0x00BC 0x026C 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET1_RXC__LPSPI2_SOUT                                          0x00BC 0x026C 0x0444 0x02 0x00
> > +
> > +#define MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                                   0x00C0 0x0270 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_RD0__LPUART3_RX                                           0x00C0 0x0270 0x0470 0x01 0x01
> > +#define MX91_PAD_ENET1_RD0__FLEXIO2_FLEXIO10                                     0x00C0 0x0270 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_RD0__GPIO4_IO10                                           0x00C0 0x0270 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                                   0x00C4 0x0274 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_RD1__LPUART3_CTS_B                                        0x00C4 0x0274 0x046C 0x01 0x01
> > +#define MX91_PAD_ENET1_RD1__LPTMR2_ALT1                                          0x00C4 0x0274 0x0448 0x03 0x00
> > +#define MX91_PAD_ENET1_RD1__FLEXIO2_FLEXIO11                                     0x00C4 0x0274 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_RD1__GPIO4_IO11                                           0x00C4 0x0274 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                                   0x00C8 0x0278 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_RD2__LPTMR2_ALT2                                          0x00C8 0x0278 0x044C 0x03 0x00
> > +#define MX91_PAD_ENET1_RD2__FLEXIO2_FLEXIO12                                     0x00C8 0x0278 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_RD2__GPIO4_IO12                                           0x00C8 0x0278 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                                   0x00CC 0x027C 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET1_RD3__FLEXSPI1_TESTER_TRIGGER                              0x00CC 0x027C 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET1_RD3__LPTMR2_ALT3                                          0x00CC 0x027C 0x0450 0x03 0x00
> > +#define MX91_PAD_ENET1_RD3__FLEXIO2_FLEXIO13                                     0x00CC 0x027C 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET1_RD3__GPIO4_IO13                                           0x00CC 0x027C 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_ENET2_MDC__ENET2_MDC                                            0x00D0 0x0280 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_MDC__LPUART4_DCB_B                                        0x00D0 0x0280 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_MDC__SAI2_RX_SYNC                                         0x00D0 0x0280 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET2_MDC__FLEXIO2_FLEXIO14                                     0x00D0 0x0280 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_MDC__GPIO4_IO14                                           0x00D0 0x0280 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_MDC__MEDIAMIX_CAM_CLK                                     0x00D0 0x0280 0x04BC 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_MDIO__ENET2_MDIO                                          0x00D4 0x0284 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_MDIO__LPUART4_RIN_B                                       0x00D4 0x0284 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_MDIO__SAI2_RX_BCLK                                        0x00D4 0x0284 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET2_MDIO__FLEXIO2_FLEXIO15                                    0x00D4 0x0284 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_MDIO__GPIO4_IO15                                          0x00D4 0x0284 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_MDIO__MEDIAMIX_CAM_DATA0                                  0x00D4 0x0284 0x0490 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_TD3__SAI2_RX_DATA0                                        0x00D8 0x0288 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET2_TD3__FLEXIO2_FLEXIO16                                     0x00D8 0x0288 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_TD3__GPIO4_IO16                                           0x00D8 0x0288 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_TD3__MEDIAMIX_CAM_VSYNC                                   0x00D8 0x0288 0x04C0 0x06 0x01
> > +#define MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3                                      0x00D8 0x0288 0x0000 0x00 0x00
> > +
> > +#define MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2                                      0x00DC 0x028C 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_TD2__ENET2_TX_CLK2                                        0x00DC 0x028C 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_TD2__FLEXIO2_FLEXIO17                                     0x00DC 0x028C 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_TD2__GPIO4_IO17                                           0x00DC 0x028C 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_TD2__MEDIAMIX_CAM_HSYNC                                   0x00DC 0x028C 0x04B8 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1                                      0x00E0 0x0290 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_TD1__LPUART4_RTS_B                                        0x00E0 0x0290 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_TD1__FLEXIO2_FLEXIO18                                     0x00E0 0x0290 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_TD1__GPIO4_IO18                                           0x00E0 0x0290 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_TD1__MEDIAMIX_CAM_DATA1                                   0x00E0 0x0290 0x0494 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0                                      0x00E4 0x0294 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_TD0__LPUART4_TX                                           0x00E4 0x0294 0x0480 0x01 0x01
> > +#define MX91_PAD_ENET2_TD0__FLEXIO2_FLEXIO19                                     0x00E4 0x0294 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_TD0__GPIO4_IO19                                           0x00E4 0x0294 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_TD0__MEDIAMIX_CAM_DATA2                                   0x00E4 0x0294 0x0498 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL                                0x00E8 0x0298 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_TX_CTL__LPUART4_DTR_B                                     0x00E8 0x0298 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_TX_CTL__SAI2_TX_SYNC                                      0x00E8 0x0298 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET2_TX_CTL__FLEXIO2_FLEXIO20                                  0x00E8 0x0298 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_TX_CTL__GPIO4_IO20                                        0x00E8 0x0298 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_TX_CTL__MEDIAMIX_CAM_DATA3                                0x00E8 0x0298 0x049C 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC                                      0x00EC 0x029C 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_TXC__ENET2_TX_ER                                          0x00EC 0x029C 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_TXC__SAI2_TX_BCLK                                         0x00EC 0x029C 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET2_TXC__FLEXIO2_FLEXIO21                                     0x00EC 0x029C 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_TXC__GPIO4_IO21                                           0x00EC 0x029C 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_TXC__MEDIAMIX_CAM_DATA4                                   0x00EC 0x029C 0x04A0 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL                                0x00F0 0x02A0 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_RX_CTL__LPUART4_DSR_B                                     0x00F0 0x02A0 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_RX_CTL__SAI2_TX_DATA0                                     0x00F0 0x02A0 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET2_RX_CTL__FLEXIO2_FLEXIO22                                  0x00F0 0x02A0 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_RX_CTL__GPIO4_IO22                                        0x00F0 0x02A0 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_RX_CTL__MEDIAMIX_CAM_DATA5                                0x00F0 0x02A0 0x04A4 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC                                      0x00F4 0x02A4 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_RXC__ENET2_RX_ER                                          0x00F4 0x02A4 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_RXC__FLEXIO2_FLEXIO23                                     0x00F4 0x02A4 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_RXC__GPIO4_IO23                                           0x00F4 0x02A4 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_RXC__MEDIAMIX_CAM_DATA6                                   0x00F4 0x02A4 0x04A8 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0                                      0x00F8 0x02A8 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_RD0__LPUART4_RX                                           0x00F8 0x02A8 0x047C 0x01 0x01
> > +#define MX91_PAD_ENET2_RD0__FLEXIO2_FLEXIO24                                     0x00F8 0x02A8 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_RD0__GPIO4_IO24                                           0x00F8 0x02A8 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_RD0__MEDIAMIX_CAM_DATA7                                   0x00F8 0x02A8 0x04AC 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1                                      0x00FC 0x02AC 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_RD1__SPDIF_IN                                             0x00FC 0x02AC 0x04E4 0x01 0x01
> > +#define MX91_PAD_ENET2_RD1__FLEXIO2_FLEXIO25                                     0x00FC 0x02AC 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_RD1__GPIO4_IO25                                           0x00FC 0x02AC 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_RD1__MEDIAMIX_CAM_DATA8                                   0x00FC 0x02AC 0x04B0 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2                                      0x0100 0x02B0 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_RD2__LPUART4_CTS_B                                        0x0100 0x02B0 0x0478 0x01 0x01
> > +#define MX91_PAD_ENET2_RD2__SAI2_MCLK                                            0x0100 0x02B0 0x0000 0x02 0x00
> > +#define MX91_PAD_ENET2_RD2__MQS2_RIGHT                                           0x0100 0x02B0 0x0000 0x03 0x00
> > +#define MX91_PAD_ENET2_RD2__FLEXIO2_FLEXIO26                                     0x0100 0x02B0 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_RD2__GPIO4_IO26                                           0x0100 0x02B0 0x0000 0x05 0x00
> > +#define MX91_PAD_ENET2_RD2__MEDIAMIX_CAM_DATA9                                   0x0100 0x02B0 0x04B4 0x06 0x01
> > +
> > +#define MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3                                      0x0104 0x02B4 0x0000 0x00 0x00
> > +#define MX91_PAD_ENET2_RD3__SPDIF_OUT                                            0x0104 0x02B4 0x0000 0x01 0x00
> > +#define MX91_PAD_ENET2_RD3__SPDIF_IN                                             0x0104 0x02B4 0x04E4 0x02 0x02
> > +#define MX91_PAD_ENET2_RD3__MQS2_LEFT                                            0x0104 0x02B4 0x0000 0x03 0x00
> > +#define MX91_PAD_ENET2_RD3__FLEXIO2_FLEXIO27                                     0x0104 0x02B4 0x0000 0x04 0x00
> > +#define MX91_PAD_ENET2_RD3__GPIO4_IO27                                           0x0104 0x02B4 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SD1_CLK__FLEXIO1_FLEXIO8                                        0x0108 0x02B8 0x038C 0x04 0x01
> > +#define MX91_PAD_SD1_CLK__GPIO3_IO8                                              0x0108 0x02B8 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_CLK__USDHC1_CLK                                             0x0108 0x02B8 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_CLK__LPSPI2_SCK                                             0x0108 0x02B8 0x043C 0x03 0x01
> > +
> > +#define MX91_PAD_SD1_CMD__USDHC1_CMD                                             0x010C 0x02BC 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_CMD__FLEXIO1_FLEXIO9                                        0x010C 0x02BC 0x0390 0x04 0x01
> > +#define MX91_PAD_SD1_CMD__GPIO3_IO9                                              0x010C 0x02BC 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_CMD__LPSPI2_SIN                                             0x010C 0x02BC 0x0440 0x03 0x01
> > +
> > +#define MX91_PAD_SD1_DATA0__USDHC1_DATA0                                         0x0110 0x02C0 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_DATA0__FLEXIO1_FLEXIO10                                     0x0110 0x02C0 0x0394 0x04 0x01
> > +#define MX91_PAD_SD1_DATA0__GPIO3_IO10                                           0x0110 0x02C0 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_DATA0__LPSPI2_PCS0                                          0x0110 0x02C0 0x0434 0x03 0x01
> > +
> > +#define MX91_PAD_SD1_DATA1__USDHC1_DATA1                                         0x0114 0x02C4 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_DATA1__FLEXIO1_FLEXIO11                                     0x0114 0x02C4 0x0398 0x04 0x01
> > +#define MX91_PAD_SD1_DATA1__GPIO3_IO11                                           0x0114 0x02C4 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_DATA1__CCMSRCGPCMIX_INT_BOOT                                0x0114 0x02C4 0x0000 0x06 0x00
> > +#define MX91_PAD_SD1_DATA1__LPSPI2_SOUT                                          0x0114 0x02C4 0x0444 0x03 0x01
> > +
> > +#define MX91_PAD_SD1_DATA2__USDHC1_DATA2                                         0x0118 0x02C8 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_DATA2__FLEXIO1_FLEXIO12                                     0x0118 0x02C8 0x0000 0x04 0x00
> > +#define MX91_PAD_SD1_DATA2__GPIO3_IO12                                           0x0118 0x02C8 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_DATA2__CCMSRCGPCMIX_PMIC_READY                              0x0118 0x02C8 0x0000 0x06 0x00
> > +#define MX91_PAD_SD1_DATA2__LPSPI2_PCS1                                          0x0118 0x02C8 0x0438 0x03 0x00
> > +
> > +#define MX91_PAD_SD1_DATA3__USDHC1_DATA3                                         0x011C 0x02CC 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_DATA3__FLEXSPI1_A_SS1_B                                     0x011C 0x02CC 0x0000 0x01 0x00
> > +#define MX91_PAD_SD1_DATA3__FLEXIO1_FLEXIO13                                     0x011C 0x02CC 0x039C 0x04 0x01
> > +#define MX91_PAD_SD1_DATA3__GPIO3_IO13                                           0x011C 0x02CC 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_DATA3__LPSPI1_PCS1                                          0x011C 0x02CC 0x0424 0x03 0x00
> > +
> > +#define MX91_PAD_SD1_DATA4__USDHC1_DATA4                                         0x0120 0x02D0 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_DATA4__FLEXSPI1_A_DATA4                                     0x0120 0x02D0 0x0000 0x01 0x00
> > +#define MX91_PAD_SD1_DATA4__FLEXIO1_FLEXIO14                                     0x0120 0x02D0 0x03A0 0x04 0x01
> > +#define MX91_PAD_SD1_DATA4__GPIO3_IO14                                           0x0120 0x02D0 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_DATA4__LPSPI1_PCS0                                          0x0120 0x02D0 0x0420 0x03 0x00
> > +
> > +#define MX91_PAD_SD1_DATA5__USDHC1_DATA5                                         0x0124 0x02D4 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_DATA5__FLEXSPI1_A_DATA5                                     0x0124 0x02D4 0x0000 0x01 0x00
> > +#define MX91_PAD_SD1_DATA5__USDHC1_RESET_B                                       0x0124 0x02D4 0x0000 0x02 0x00
> > +#define MX91_PAD_SD1_DATA5__FLEXIO1_FLEXIO15                                     0x0124 0x02D4 0x03A4 0x04 0x01
> > +#define MX91_PAD_SD1_DATA5__GPIO3_IO15                                           0x0124 0x02D4 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_DATA5__LPSPI1_SIN                                           0x0124 0x02D4 0x042C 0x03 0x00
> > +
> > +#define MX91_PAD_SD1_DATA6__USDHC1_DATA6                                         0x0128 0x02D8 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_DATA6__FLEXSPI1_A_DATA6                                     0x0128 0x02D8 0x0000 0x01 0x00
> > +#define MX91_PAD_SD1_DATA6__USDHC1_CD_B                                          0x0128 0x02D8 0x0000 0x02 0x00
> > +#define MX91_PAD_SD1_DATA6__FLEXIO1_FLEXIO16                                     0x0128 0x02D8 0x03A8 0x04 0x01
> > +#define MX91_PAD_SD1_DATA6__GPIO3_IO16                                           0x0128 0x02D8 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_DATA6__LPSPI1_SCK                                           0x0128 0x02D8 0x0428 0x03 0x00
> > +
> > +#define MX91_PAD_SD1_DATA7__USDHC1_DATA7                                         0x012C 0x02DC 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_DATA7__FLEXSPI1_A_DATA7                                     0x012C 0x02DC 0x0000 0x01 0x00
> > +#define MX91_PAD_SD1_DATA7__USDHC1_WP                                            0x012C 0x02DC 0x0000 0x02 0x00
> > +#define MX91_PAD_SD1_DATA7__FLEXIO1_FLEXIO17                                     0x012C 0x02DC 0x03AC 0x04 0x01
> > +#define MX91_PAD_SD1_DATA7__GPIO3_IO17                                           0x012C 0x02DC 0x0000 0x05 0x00
> > +#define MX91_PAD_SD1_DATA7__LPSPI1_SOUT                                          0x012C 0x02DC 0x0430 0x03 0x00
> > +
> > +#define MX91_PAD_SD1_STROBE__USDHC1_STROBE                                       0x0130 0x02E0 0x0000 0x00 0x00
> > +#define MX91_PAD_SD1_STROBE__FLEXSPI1_A_DQS                                      0x0130 0x02E0 0x0000 0x01 0x00
> > +#define MX91_PAD_SD1_STROBE__FLEXIO1_FLEXIO18                                    0x0130 0x02E0 0x03B0 0x04 0x01
> > +#define MX91_PAD_SD1_STROBE__GPIO3_IO18                                          0x0130 0x02E0 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                                     0x0134 0x02E4 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_VSELECT__USDHC2_WP                                          0x0134 0x02E4 0x0000 0x01 0x00
> > +#define MX91_PAD_SD2_VSELECT__LPTMR2_ALT3                                        0x0134 0x02E4 0x0450 0x02 0x01
> > +#define MX91_PAD_SD2_VSELECT__FLEXIO1_FLEXIO19                                   0x0134 0x02E4 0x0000 0x04 0x00
> > +#define MX91_PAD_SD2_VSELECT__GPIO3_IO19                                         0x0134 0x02E4 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_VSELECT__CCMSRCGPCMIX_EXT_CLK1                              0x0134 0x02E4 0x0368 0x06 0x00
> > +
> > +#define MX91_PAD_SD3_CLK__USDHC3_CLK                                             0x0138 0x02E8 0x04E8 0x00 0x01
> > +#define MX91_PAD_SD3_CLK__FLEXSPI1_A_SCLK                                        0x0138 0x02E8 0x0000 0x01 0x00
> > +#define MX91_PAD_SD3_CLK__LPUART1_CTS_B                                          0x0138 0x02E8 0x0454 0x02 0x00
> > +#define MX91_PAD_SD3_CLK__FLEXIO1_FLEXIO20                                       0x0138 0x02E8 0x03B4 0x04 0x01
> > +#define MX91_PAD_SD3_CLK__GPIO3_IO20                                             0x0138 0x02E8 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SD3_CMD__USDHC3_CMD                                             0x013C 0x02EC 0x04EC 0x00 0x01
> > +#define MX91_PAD_SD3_CMD__FLEXSPI1_A_SS0_B                                       0x013C 0x02EC 0x0000 0x01 0x00
> > +#define MX91_PAD_SD3_CMD__LPUART1_RTS_B                                          0x013C 0x02EC 0x0000 0x02 0x00
> > +#define MX91_PAD_SD3_CMD__FLEXIO1_FLEXIO21                                       0x013C 0x02EC 0x0000 0x04 0x00
> > +#define MX91_PAD_SD3_CMD__GPIO3_IO21                                             0x013C 0x02EC 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SD3_DATA0__USDHC3_DATA0                                         0x0140 0x02F0 0x04F0 0x00 0x01
> > +#define MX91_PAD_SD3_DATA0__FLEXSPI1_A_DATA0                                     0x0140 0x02F0 0x0000 0x01 0x00
> > +#define MX91_PAD_SD3_DATA0__LPUART2_CTS_B                                        0x0140 0x02F0 0x0460 0x02 0x00
> > +#define MX91_PAD_SD3_DATA0__FLEXIO1_FLEXIO22                                     0x0140 0x02F0 0x03B8 0x04 0x01
> > +#define MX91_PAD_SD3_DATA0__GPIO3_IO22                                           0x0140 0x02F0 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SD3_DATA1__USDHC3_DATA1                                         0x0144 0x02F4 0x04F4 0x00 0x01
> > +#define MX91_PAD_SD3_DATA1__FLEXSPI1_A_DATA1                                     0x0144 0x02F4 0x0000 0x01 0x00
> > +#define MX91_PAD_SD3_DATA1__LPUART2_RTS_B                                        0x0144 0x02F4 0x0000 0x02 0x00
> > +#define MX91_PAD_SD3_DATA1__FLEXIO1_FLEXIO23                                     0x0144 0x02F4 0x03BC 0x04 0x01
> > +#define MX91_PAD_SD3_DATA1__GPIO3_IO23                                           0x0144 0x02F4 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SD3_DATA2__USDHC3_DATA2                                         0x0148 0x02F8 0x04F8 0x00 0x01
> > +#define MX91_PAD_SD3_DATA2__LPI2C4_SDA                                           0x0148 0x02F8 0x03FC 0x02 0x01
> > +#define MX91_PAD_SD3_DATA2__FLEXSPI1_A_DATA2                                     0x0148 0x02F8 0x0000 0x01 0x00
> > +#define MX91_PAD_SD3_DATA2__FLEXIO1_FLEXIO24                                     0x0148 0x02F8 0x03C0 0x04 0x01
> > +#define MX91_PAD_SD3_DATA2__GPIO3_IO24                                           0x0148 0x02F8 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SD3_DATA3__USDHC3_DATA3                                         0x014C 0x02FC 0x04FC 0x00 0x01
> > +#define MX91_PAD_SD3_DATA3__FLEXSPI1_A_DATA3                                     0x014C 0x02FC 0x0000 0x01 0x00
> > +#define MX91_PAD_SD3_DATA3__LPI2C4_SCL                                           0x014C 0x02FC 0x03F8 0x02 0x01
> > +#define MX91_PAD_SD3_DATA3__FLEXIO1_FLEXIO25                                     0x014C 0x02FC 0x03C4 0x04 0x01
> > +#define MX91_PAD_SD3_DATA3__GPIO3_IO25                                           0x014C 0x02FC 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SD2_CD_B__USDHC2_CD_B                                           0x0150 0x0300 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_CD_B__ENET_QOS_1588_EVENT0_IN                               0x0150 0x0300 0x0000 0x01 0x00
> > +#define MX91_PAD_SD2_CD_B__I3C2_SCL                                              0x0150 0x0300 0x03CC 0x02 0x01
> > +#define MX91_PAD_SD2_CD_B__FLEXIO1_FLEXIO0                                       0x0150 0x0300 0x036C 0x04 0x01
> > +#define MX91_PAD_SD2_CD_B__GPIO3_IO0                                             0x0150 0x0300 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_CD_B__LPI2C1_SCL                                            0x0150 0x0300 0x03E0 0x03 0x01
> > +
> > +#define MX91_PAD_SD2_CLK__USDHC2_CLK                                             0x0154 0x0304 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_CLK__ENET_QOS_1588_EVENT0_OUT                               0x0154 0x0304 0x0000 0x01 0x00
> > +#define MX91_PAD_SD2_CLK__I2C1_SDA                                               0x0154 0x0304 0x0000 0x03 0x00
> > +#define MX91_PAD_SD2_CLK__I3C2_SDA                                               0x0154 0x0304 0x03D0 0x02 0x01
> > +#define MX91_PAD_SD2_CLK__FLEXIO1_FLEXIO1                                        0x0154 0x0304 0x0370 0x04 0x01
> > +#define MX91_PAD_SD2_CLK__GPIO3_IO1                                              0x0154 0x0304 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_CLK__CCMSRCGPCMIX_OBSERVE0                                  0x0154 0x0304 0x0000 0x06 0x00
> > +#define MX91_PAD_SD2_CLK__LPI2C1_SDA                                             0x0154 0x0304 0x03E4 0x03 0x01
> > +
> > +#define MX91_PAD_SD2_CMD__USDHC2_CMD                                             0x0158 0x0308 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_CMD__ENET2_1588_EVENT0_IN                                   0x0158 0x0308 0x0000 0x01 0x00
> > +#define MX91_PAD_SD2_CMD__I3C2_PUR                                               0x0158 0x0308 0x0000 0x02 0x00
> > +#define MX91_PAD_SD2_CMD__I3C2_PUR_B                                             0x0158 0x0308 0x0000 0x03 0x00
> > +#define MX91_PAD_SD2_CMD__FLEXIO1_FLEXIO2                                        0x0158 0x0308 0x0374 0x04 0x01
> > +#define MX91_PAD_SD2_CMD__GPIO3_IO2                                              0x0158 0x0308 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_CMD__CCMSRCGPCMIX_OBSERVE1                                  0x0158 0x0308 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_SD2_DATA0__USDHC2_DATA0                                         0x015C 0x030C 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_DATA0__ENET2_1588_EVENT0_OUT                                0x015C 0x030C 0x0000 0x01 0x00
> > +#define MX91_PAD_SD2_DATA0__CAN2_TX                                              0x015C 0x030C 0x0000 0x02 0x00
> > +#define MX91_PAD_SD2_DATA0__FLEXIO1_FLEXIO3                                      0x015C 0x030C 0x0378 0x04 0x01
> > +#define MX91_PAD_SD2_DATA0__GPIO3_IO3                                            0x015C 0x030C 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_DATA0__LPUART1_TX                                           0x015C 0x030C 0x045C 0x03 0x00
> > +#define MX91_PAD_SD2_DATA0__CCMSRCGPCMIX_OBSERVE2                                0x015C 0x030C 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_SD2_DATA1__USDHC2_DATA1                                         0x0160 0x0310 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_DATA1__ENET2_1588_EVENT1_IN                                 0x0160 0x0310 0x0000 0x01 0x00
> > +#define MX91_PAD_SD2_DATA1__CAN2_RX                                              0x0160 0x0310 0x0364 0x02 0x03
> > +#define MX91_PAD_SD2_DATA1__FLEXIO1_FLEXIO4                                      0x0160 0x0310 0x037C 0x04 0x01
> > +#define MX91_PAD_SD2_DATA1__GPIO3_IO4                                            0x0160 0x0310 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_DATA1__LPUART1_RX                                           0x0160 0x0310 0x0458 0x03 0x00
> > +#define MX91_PAD_SD2_DATA1__CCMSRCGPCMIX_WAIT                                    0x0160 0x0310 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_SD2_DATA2__USDHC2_DATA2                                         0x0164 0x0314 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_DATA2__ENET2_1588_EVENT1_OUT                                0x0164 0x0314 0x0000 0x01 0x00
> > +#define MX91_PAD_SD2_DATA2__MQS2_RIGHT                                           0x0164 0x0314 0x0000 0x02 0x00
> > +#define MX91_PAD_SD2_DATA2__FLEXIO1_FLEXIO5                                      0x0164 0x0314 0x0380 0x04 0x01
> > +#define MX91_PAD_SD2_DATA2__GPIO3_IO5                                            0x0164 0x0314 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_DATA2__LPUART2_TX                                           0x0164 0x0314 0x0468 0x03 0x00
> > +#define MX91_PAD_SD2_DATA2__CCMSRCGPCMIX_STOP                                    0x0164 0x0314 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_SD2_DATA3__USDHC2_DATA3                                         0x0168 0x0318 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_DATA3__LPTMR2_ALT1                                          0x0168 0x0318 0x0448 0x01 0x01
> > +#define MX91_PAD_SD2_DATA3__MQS2_LEFT                                            0x0168 0x0318 0x0000 0x02 0x00
> > +#define MX91_PAD_SD2_DATA3__FLEXIO1_FLEXIO6                                      0x0168 0x0318 0x0384 0x04 0x01
> > +#define MX91_PAD_SD2_DATA3__GPIO3_IO6                                            0x0168 0x0318 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_DATA3__LPUART2_RX                                           0x0168 0x0318 0x0464 0x03 0x00
> > +#define MX91_PAD_SD2_DATA3__CCMSRCGPCMIX_EARLY_RESET                             0x0168 0x0318 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_SD2_RESET_B__USDHC2_RESET_B                                     0x016C 0x031C 0x0000 0x00 0x00
> > +#define MX91_PAD_SD2_RESET_B__LPTMR2_ALT2                                        0x016C 0x031C 0x044C 0x01 0x01
> > +#define MX91_PAD_SD2_RESET_B__FLEXIO1_FLEXIO7                                    0x016C 0x031C 0x0388 0x04 0x01
> > +#define MX91_PAD_SD2_RESET_B__GPIO3_IO7                                          0x016C 0x031C 0x0000 0x05 0x00
> > +#define MX91_PAD_SD2_RESET_B__CCMSRCGPCMIX_SYSTEM_RESET                          0x016C 0x031C 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_I2C1_SCL__LPI2C1_SCL                                            0x0170 0x0320 0x03E0 0x00 0x02
> > +#define MX91_PAD_I2C1_SCL__I3C1_SCL                                              0x0170 0x0320 0x0000 0x01 0x00
> > +#define MX91_PAD_I2C1_SCL__LPUART1_DCB_B                                         0x0170 0x0320 0x0000 0x02 0x00
> > +#define MX91_PAD_I2C1_SCL__TPM2_CH0                                              0x0170 0x0320 0x0000 0x03 0x00
> > +#define MX91_PAD_I2C1_SCL__GPIO1_IO0                                             0x0170 0x0320 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_I2C1_SDA__LPI2C1_SDA                                            0x0174 0x0324 0x03E4 0x00 0x02
> > +#define MX91_PAD_I2C1_SDA__I3C1_SDA                                              0x0174 0x0324 0x0000 0x01 0x00
> > +#define MX91_PAD_I2C1_SDA__LPUART1_RIN_B                                         0x0174 0x0324 0x0000 0x02 0x00
> > +#define MX91_PAD_I2C1_SDA__TPM2_CH1                                              0x0174 0x0324 0x0000 0x03 0x00
> > +#define MX91_PAD_I2C1_SDA__GPIO1_IO1                                             0x0174 0x0324 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_I2C2_SCL__LPI2C2_SCL                                            0x0178 0x0328 0x03E8 0x00 0x01
> > +#define MX91_PAD_I2C2_SCL__I3C1_PUR                                              0x0178 0x0328 0x0000 0x01 0x00
> > +#define MX91_PAD_I2C2_SCL__LPUART2_DCB_B                                         0x0178 0x0328 0x0000 0x02 0x00
> > +#define MX91_PAD_I2C2_SCL__TPM2_CH2                                              0x0178 0x0328 0x0000 0x03 0x00
> > +#define MX91_PAD_I2C2_SCL__SAI1_RX_SYNC                                          0x0178 0x0328 0x0000 0x04 0x00
> > +#define MX91_PAD_I2C2_SCL__GPIO1_IO3                                             0x0178 0x0328 0x0000 0x05 0x00
> > +#define MX91_PAD_I2C2_SCL__I3C1_PUR_B                                            0x0178 0x0328 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_I2C2_SDA__LPI2C2_SDA                                            0x017C 0x032C 0x03EC 0x00 0x01
> > +#define MX91_PAD_I2C2_SDA__LPUART2_RIN_B                                         0x017C 0x032C 0x0000 0x02 0x00
> > +#define MX91_PAD_I2C2_SDA__TPM2_CH3                                              0x017C 0x032C 0x0000 0x03 0x00
> > +#define MX91_PAD_I2C2_SDA__SAI1_RX_BCLK                                          0x017C 0x032C 0x0000 0x04 0x00
> > +#define MX91_PAD_I2C2_SDA__GPIO1_IO3                                             0x017C 0x032C 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_UART1_RXD__LPUART1_RX                                           0x0180 0x0330 0x0458 0x00 0x01
> > +#define MX91_PAD_UART1_RXD__ELE_UART_RX                                          0x0180 0x0330 0x0000 0x01 0x00
> > +#define MX91_PAD_UART1_RXD__LPSPI2_SIN                                           0x0180 0x0330 0x0440 0x02 0x02
> > +#define MX91_PAD_UART1_RXD__TPM1_CH0                                             0x0180 0x0330 0x0000 0x03 0x00
> > +#define MX91_PAD_UART1_RXD__GPIO1_IO4                                            0x0180 0x0330 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_UART1_TXD__LPUART1_TX                                           0x0184 0x0334 0x045C 0x00 0x01
> > +#define MX91_PAD_UART1_TXD__ELE_UART_TX                                          0x0184 0x0334 0x0000 0x01 0x00
> > +#define MX91_PAD_UART1_TXD__LPSPI2_PCS0                                          0x0184 0x0334 0x0434 0x02 0x02
> > +#define MX91_PAD_UART1_TXD__TPM1_CH1                                             0x0184 0x0334 0x0000 0x03 0x00
> > +#define MX91_PAD_UART1_TXD__GPIO1_IO5                                            0x0184 0x0334 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_UART2_RXD__LPUART2_RX                                           0x0188 0x0338 0x0464 0x00 0x01
> > +#define MX91_PAD_UART2_RXD__LPUART1_CTS_B                                        0x0188 0x0338 0x0454 0x01 0x01
> > +#define MX91_PAD_UART2_RXD__LPSPI2_SOUT                                          0x0188 0x0338 0x0444 0x02 0x02
> > +#define MX91_PAD_UART2_RXD__TPM1_CH2                                             0x0188 0x0338 0x0000 0x03 0x00
> > +#define MX91_PAD_UART2_RXD__SAI1_MCLK                                            0x0188 0x0338 0x04D4 0x04 0x00
> > +#define MX91_PAD_UART2_RXD__GPIO1_IO6                                            0x0188 0x0338 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_UART2_TXD__LPUART2_TX                                           0x018C 0x033C 0x0468 0x00 0x01
> > +#define MX91_PAD_UART2_TXD__LPUART1_RTS_B                                        0x018C 0x033C 0x0000 0x01 0x00
> > +#define MX91_PAD_UART2_TXD__LPSPI2_SCK                                           0x018C 0x033C 0x043C 0x02 0x02
> > +#define MX91_PAD_UART2_TXD__TPM1_CH3                                             0x018C 0x033C 0x0000 0x03 0x00
> > +#define MX91_PAD_UART2_TXD__GPIO1_IO7                                            0x018C 0x033C 0x0000 0x05 0x00
> > +#define MX91_PAD_UART2_TXD__SAI3_TX_SYNC                                         0x018C 0x033C 0x04E0 0x07 0x02
> > +
> > +#define MX91_PAD_PDM_CLK__PDM_CLK                                                0x0190 0x0340 0x0000 0x00 0x00
> > +#define MX91_PAD_PDM_CLK__MQS1_LEFT                                              0x0190 0x0340 0x0000 0x01 0x00
> > +#define MX91_PAD_PDM_CLK__LPTMR1_ALT1                                            0x0190 0x0340 0x0000 0x04 0x00
> > +#define MX91_PAD_PDM_CLK__GPIO1_IO8                                              0x0190 0x0340 0x0000 0x05 0x00
> > +#define MX91_PAD_PDM_CLK__CAN1_TX                                                0x0190 0x0340 0x0000 0x06 0x00
> > +
> > +#define MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0                                0x0194 0x0344 0x04C4 0x00 0x02
> > +#define MX91_PAD_PDM_BIT_STREAM0__MQS1_RIGHT                                     0x0194 0x0344 0x0000 0x01 0x00
> > +#define MX91_PAD_PDM_BIT_STREAM0__LPSPI1_PCS1                                    0x0194 0x0344 0x0424 0x02 0x01
> > +#define MX91_PAD_PDM_BIT_STREAM0__TPM1_EXTCLK                                    0x0194 0x0344 0x0000 0x03 0x00
> > +#define MX91_PAD_PDM_BIT_STREAM0__LPTMR1_ALT2                                    0x0194 0x0344 0x0000 0x04 0x00
> > +#define MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9                                      0x0194 0x0344 0x0000 0x05 0x00
> > +#define MX91_PAD_PDM_BIT_STREAM0__CAN1_RX                                        0x0194 0x0344 0x0360 0x06 0x01
> > +
> > +#define MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1                                0x0198 0x0348 0x04C8 0x00 0x02
> > +#define MX91_PAD_PDM_BIT_STREAM1__LPSPI2_PCS1                                    0x0198 0x0348 0x0438 0x02 0x01
> > +#define MX91_PAD_PDM_BIT_STREAM1__TPM2_EXTCLK                                    0x0198 0x0348 0x0000 0x03 0x00
> > +#define MX91_PAD_PDM_BIT_STREAM1__LPTMR1_ALT3                                    0x0198 0x0348 0x0000 0x04 0x00
> > +#define MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10                                     0x0198 0x0348 0x0000 0x05 0x00
> > +#define MX91_PAD_PDM_BIT_STREAM1__CCMSRCGPCMIX_EXT_CLK1                          0x0198 0x0348 0x0368 0x06 0x01
> > +
> > +#define MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC                                         0x019C 0x034C 0x0000 0x00 0x00
> > +#define MX91_PAD_SAI1_TXFS__SAI1_TX_DATA1                                        0x019C 0x034C 0x0000 0x01 0x00
> > +#define MX91_PAD_SAI1_TXFS__LPSPI1_PCS0                                          0x019C 0x034C 0x0420 0x02 0x01
> > +#define MX91_PAD_SAI1_TXFS__LPUART2_DTR_B                                        0x019C 0x034C 0x0000 0x03 0x00
> > +#define MX91_PAD_SAI1_TXFS__MQS1_LEFT                                            0x019C 0x034C 0x0000 0x04 0x00
> > +#define MX91_PAD_SAI1_TXFS__GPIO1_IO11                                           0x019C 0x034C 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SAI1_TXC__SAI1_TX_BCLK                                          0x01A0 0x0350 0x0000 0x00 0x00
> > +#define MX91_PAD_SAI1_TXC__LPUART2_CTS_B                                         0x01A0 0x0350 0x0460 0x01 0x01
> > +#define MX91_PAD_SAI1_TXC__LPSPI1_SIN                                            0x01A0 0x0350 0x042C 0x02 0x01
> > +#define MX91_PAD_SAI1_TXC__LPUART1_DSR_B                                         0x01A0 0x0350 0x0000 0x03 0x00
> > +#define MX91_PAD_SAI1_TXC__CAN1_RX                                               0x01A0 0x0350 0x0360 0x04 0x02
> > +#define MX91_PAD_SAI1_TXC__GPIO1_IO12                                            0x01A0 0x0350 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0                                        0x01A4 0x0354 0x0000 0x00 0x00
> > +#define MX91_PAD_SAI1_TXD0__LPUART2_RTS_B                                        0x01A4 0x0354 0x0000 0x01 0x00
> > +#define MX91_PAD_SAI1_TXD0__LPSPI1_SCK                                           0x01A4 0x0354 0x0428 0x02 0x01
> > +#define MX91_PAD_SAI1_TXD0__LPUART1_DTR_B                                        0x01A4 0x0354 0x0000 0x03 0x00
> > +#define MX91_PAD_SAI1_TXD0__CAN1_TX                                              0x01A4 0x0354 0x0000 0x04 0x00
> > +#define MX91_PAD_SAI1_TXD0__GPIO1_IO13                                           0x01A4 0x0354 0x0000 0x05 0x00
> > +#define MX91_PAD_SAI1_TXD0__SAI1_MCLK                                            0x01A4 0x0354 0x04D4 0x06 0x01
> > +
> > +#define MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0                                        0x01A8 0x0358 0x0000 0x00 0x00
> > +#define MX91_PAD_SAI1_RXD0__SAI1_MCLK                                            0x01A8 0x0358 0x04D4 0x01 0x02
> > +#define MX91_PAD_SAI1_RXD0__LPSPI1_SOUT                                          0x01A8 0x0358 0x0430 0x02 0x01
> > +#define MX91_PAD_SAI1_RXD0__LPUART2_DSR_B                                        0x01A8 0x0358 0x0000 0x03 0x00
> > +#define MX91_PAD_SAI1_RXD0__MQS1_RIGHT                                           0x01A8 0x0358 0x0000 0x04 0x00
> > +#define MX91_PAD_SAI1_RXD0__GPIO1_IO14                                           0x01A8 0x0358 0x0000 0x05 0x00
> > +
> > +#define MX91_PAD_WDOG_ANY__WDOG1_WDOG_ANY                                        0x01AC 0x035C 0x0000 0x00 0x00
> > +#define MX91_PAD_WDOG_ANY__GPIO1_IO15                                            0x01AC 0x035C 0x0000 0x05 0x00
> > +#endif /* __DTS_IMX91_PINFUNC_H */
> > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > new file mode 100644
> > index 000000000000..a9f4c1fe61cc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include "imx91-pinfunc.h"
> > +#include "imx93.dtsi"
> 
> Since i.MX91 DDR PMU is compatible with i.MX93's:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml#n35
> 
> Could you please modify ddr-pmu node compatilbe to:
> 
> 	compatible = "fsl,imx91-ddr-pmu", "fsl,imx93-ddr-pmu";
> 
> Thanks,
> Xu Yang

Okay, it will be changed in the next version

BR,
Pengfei Li

> 
> > +
> > +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> > +	cooling-device =
> > +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +};
> > +
> > +&clk {
> > +	compatible = "fsl,imx91-ccm";
> > +};
> > +
> > +&eqos {
> > +	clocks = <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > +			<&clk IMX91_CLK_ENET_TIMER>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > +};
> > +
> > +&fec {
> > +	clocks = <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > +			<&clk IMX91_CLK_ENET_TIMER>,
> > +			<&clk IMX91_CLK_ENET2_REGULAR>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +	assigned-clocks = <&clk IMX91_CLK_ENET_TIMER>,
> > +				<&clk IMX91_CLK_ENET2_REGULAR>;
> > +	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > +	assigned-clock-rates = <100000000>, <250000000>;
> > +};
> > +
> > +&i3c1 {
> > +	clocks = <&clk IMX93_CLK_BUS_AON>,
> > +			<&clk IMX93_CLK_I3C1_GATE>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +};
> > +
> > +&i3c2 {
> > +	clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
> > +			<&clk IMX93_CLK_I3C2_GATE>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +};
> > +
> > +&tmu {
> > +	status = "disabled";
> > +};
> > +
> > +/* i.MX91 only has one A core */
> > +/delete-node/ &A55_1;
> > +
> > +/* i.MX91 not has cm33 */
> > +/delete-node/ &cm33;
> > +
> > +/* i.MX91 not has power-domain@44461800 */
> > +/delete-node/ &mlmix;
> > -- 
> > 2.34.1
> > 
> 

