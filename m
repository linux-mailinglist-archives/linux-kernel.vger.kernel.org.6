Return-Path: <linux-kernel+bounces-415812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E880C9D3CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEC01F23A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922A71ABEA2;
	Wed, 20 Nov 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DVrCyIKm"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911131AB6FC;
	Wed, 20 Nov 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111081; cv=fail; b=huh3cvpXTY40E81LhhUfZm0IqAcTZv83H+TVLXSLc75LoVAfLIExFOPzLiEWClgEBahycdkipPVTeX8DMKnIl8/54SCbD8qrIKNkxGPZu4EZL9njb83vqTTzlWzL68SvurOTICKCMvLKkJ3ggL1w3DET2Wr6Jf0pihjEYgUAU6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111081; c=relaxed/simple;
	bh=Oh54RUOPQFPLE0IYARmvHEctrdQuX9DB+beE3iCKArE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mb2avpBzcUFYf+j0JVCyNnoLQQl5TetJXwLbeivmXbaJwSJ9oZzZ+4cCnRI66g1sYf4jmawgZdarmNMlI5qXqXoK2jOhHLjailxfuqNV9OnYx/g7Gg028gDMxHWAK/qwJkLttTCx6cBrv4Bj2ILirTTx7TowlIEMk7EFSGNTOyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DVrCyIKm; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdxJhLSCL5eiEpsBNct1sfmPdp5QOLsfroG8gr8HSmI4azDmb3Yi72QPNJ9pJSZZOwTfOQN7iLM9f2jLZ/a51a3uF+bSJqOPSNKyZ0MLcxhdyQAGae9vb/tlG2ZEYdzIjcoqmm0da/YOoduKZoQOJqfD3aNeNwqELBXYjhgVTUIYONd5ecDHhn0A8Np2ewbZQIF0kgnSDgf/yI9fnCCvWKoX9bUMJaIdDrxvvDQAhiYtKfKvW02C5RPwEFli9m9TO+Psp3nwotq9QaO6Jgf2+RF51xkkzdXXlq/EwYfGqLaONZGMY+94ea/cqcfaJwtG3qL+ByMvfn2ojWDfds4TsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dXZUIP/423XuxeOFQB90YScfnXBOfZSQWHFaXvoVGA=;
 b=T5MttDWRdmSZAVkmn7WeAxxt3833V3bCtE5AGfZUfMekTRM/2LTDBMCHlLz+awBDbcE1q2Yh7sQt7g/djSIsSqODDGrgVqEcsmhYS/gdcDmDq4HSR+OxKaXB/RyIw0Y37kcK0jOB2s6t051rHiwaJr9DT9nBVOvXHufPrnJiC1iyXntR/1ZvZ6foT2F4YwEsM+0g6KmmaUvHhoFZp7jD7yHRrO46HLvY64Z/WEVRP9zfyeR9i7/Q5zaP3O2ykSO6ZUCld/Z0Xw9T7/qGuSBJWp5kzXnNpfQNlNqqPhkuLrgO4FZmuuaZtEnha9VWYXQjEvRujYYfeYdXCNqnSHavLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dXZUIP/423XuxeOFQB90YScfnXBOfZSQWHFaXvoVGA=;
 b=DVrCyIKmj7ajVJWUh3G+M9uBF723fuZn2pU8z1P3Pa+4ZpUr8QkbVnMdjLiZ8hl6ai0svVOh8z98CbLBVPPH+eCbTVH77nOeB8rnhA3kF1cs2VMmLUf59GwXkgUKwHTQRaBUj0er8iSYP9qXUaYctfz322y0ofAQOtZ6by9xd89aZz5kRU0ZdEshYtsAmQDTSmZhHFTK+6hxsRpB3Bbdd2++niWVtsIrOFNmUsAvLmEJ2NLitL37IdHIhePb4KnRtiqAPHZH7zBEqh1ykQ9le90vtsWHZ20kFtVaT8Vo1CcVEv+GDZsR+SeLUml22mQRQe2pJG0RadBx70gd65sZNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:57:56 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:57:56 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/5] Configure imx8mp dsp node for rproc usage
Date: Wed, 20 Nov 2024 15:58:53 +0200
Message-ID: <20241120135859.3133984-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::7) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c5a9f4-63dd-4636-22ba-08dd096b55e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKbIMv2WhNjifBWMmdg1NLYH28v9rtV0mn09+Z5TmI32W6OsJW6mnuOqFI6O?=
 =?us-ascii?Q?XGU0yBcqE5wYL3SPsKty2Fx3ml0Np1K9/Hvl8cPaQcqVH6oSbuYr2eaOjVZc?=
 =?us-ascii?Q?zNh17pfdUIREuVvUh1GQ5qy5FQSrhgmDRYT/CIXQma8gbOdHCkjAfCAqSZRH?=
 =?us-ascii?Q?3iLrj/XUsq8ZW8DZVL1kBbuy/U/kgZVYa4zv5P4aCc2elUJb3+l+kZTuG48f?=
 =?us-ascii?Q?4sPxTAM3m3lL9dt4xWdtjsvZW3mbi1m2IjbYMH1AJ2MFSySk7qJF9jOhxsG8?=
 =?us-ascii?Q?VRfMSbq9C6j0o+n5J2Z+d06e5rR5iKwaBV+2Us1O6zN7XuSWSt3fwCnrNk8S?=
 =?us-ascii?Q?EJLSvL4b+UMoMUBl0eHAyyiwvRAtOm50PEZPNO7/RsVJDyxI2rVqhAV2m416?=
 =?us-ascii?Q?mpwJ5bXbU4vTj+nXL2dxSlf8Adr7FilH3i1nVbKC8jGizOvK5DO931IdsyZR?=
 =?us-ascii?Q?dAnV1V0C0ceb5gG0AkZwLKHIPa0izTGS7Inh1ZQPTlisu0QIwtc7th3vhKw0?=
 =?us-ascii?Q?gMVXYb7scnr2dfG51JizsRpTPuJo/tV5/zksH/dHKAKo+lONSYpjN3We2rTa?=
 =?us-ascii?Q?DNBmSceEcJ6HbqIluvgWtd0xXkY+xiqNOCoBo9d4cata+DPez/EBse2N8eBD?=
 =?us-ascii?Q?gi99TXjRhvfT4CoCnllIAO8mrrMxFrePupTr1tZHmR3ZU3dRVf5oAVh9ntdO?=
 =?us-ascii?Q?wUzWNRjRXPYPBgzsC6HebRe7ih2MXFWn5yFQmUy9LVUgDW4vHdlnbwUVmv4l?=
 =?us-ascii?Q?z9zDPKI1wv3b0S/NdWOiIAleGjer94cY/6gsUDB4PIo2X5WK7WA4CSfMb3yp?=
 =?us-ascii?Q?NkcWQ1vNJXI+fP5rt4PyJgmqjMc4ZC1Cu0mXAqP3oyDsswJkijvM2pC10mDB?=
 =?us-ascii?Q?pxLQW7uivvZLxp5upxPZvEAXXgCkn4pi7czIY+tVZBLBooh3KU7/GdOiZnJY?=
 =?us-ascii?Q?APr9Q2rHiFCTHfgjFh7e1D9bNnnVDx+j7i50jvcsZsrWMT+4Ms7e//dped+N?=
 =?us-ascii?Q?zrTQM9atsQhMmOOaZboiyRX+mFhbaW9zn5CusCER/5sA1tUs2tJa03M3CvFS?=
 =?us-ascii?Q?zVTqcglH+YSmVaDDyI5yxGdVGtTD/R8Eoc36XoHYIb6W+kBtJAlXZ9sofLDH?=
 =?us-ascii?Q?UJbPPC1liM+cbX7JLHzzX0N/lFr7Y0GEPQplw/pVzVKv9CNXhqeh05CMlwE7?=
 =?us-ascii?Q?5hdUtBheDB0FkV46I7YDSrK/vOVP6vzzxWrr7rKOaTteDDPQXOD1dpN/ba+Z?=
 =?us-ascii?Q?cKSvHClG/tsSLsTOiF+MaE1F/UH1n4GIo26nddPSuUZ5iR2MgHEn3xyLYzlH?=
 =?us-ascii?Q?QBruvmy+tct6tqlAy6zS7e7jRC4aRrQReDH5MntS8VL0ja5c2JSNjmiHX0cd?=
 =?us-ascii?Q?4fQ40FE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dlFTD+W24d2Wh/YkXHBxvRUIQSDayWc7YLpedi0u5rDp+JaN2MhESkwy1OZ+?=
 =?us-ascii?Q?iyI7cAg9zJYPvE+htl7SUQilJwgrmnrziChXfrJf0ipLTnQQRr6NkqWLOnoI?=
 =?us-ascii?Q?RkonF/eKSbtrJGtBtBsSSaHds0y09IPe/W4mPHF2HJfW9TEltwViRQU+itJ6?=
 =?us-ascii?Q?PVM7tKur+FWOcgfyX5cKa1EHA31T8UY+pr9127nI5Eo86S9bwVAWVHD5N96w?=
 =?us-ascii?Q?vPpJZvLHBYOjK9kwqSL+83k0AY/KMvqIWAw8+yKuFf/dcT3w+6XqdxvVg7AF?=
 =?us-ascii?Q?9FqzuxzYZoOMuZd+7ddf75gs+9qddu8LAoFdB+l4CASPkBe6KhC+3QBuwR4Y?=
 =?us-ascii?Q?LObFN3StUDlquda18Ca6SsQAZcDkZHuetODs6PAHFtdC+2epbLciSI4F63iG?=
 =?us-ascii?Q?mUXx0VrOnN0C4dMlg6zwJVsC3TCy+i/90xkUV3vOpPOYEPQpiKS4SV59mXoD?=
 =?us-ascii?Q?J4PntbFQJbL7hW5Kt97Wh5qxneqH/TFn40CVImx6UQ94+TKJrJomSgCA5l6w?=
 =?us-ascii?Q?H1OLjriUTBc2HQxK0htpJSOnjD+fBIHwWmQJQG1F4XAzMlO6TmM82aBYvpjO?=
 =?us-ascii?Q?tVIdpdnuOB+sSePKcGoPLDDCX5U7xFMOYFPJy/i8tObL+Mv4B4Gqda8GqFlh?=
 =?us-ascii?Q?5IKx/l9KQ1vyrlrhWIW2LOHCNgvhHfTD5iK9xtqKp7q2suyhmxDCQ9zw4JIY?=
 =?us-ascii?Q?kcw76SSYp3jVj1aAS2qR0KwAoHS8hUKl2ds9V3MVBYSXruWy7aZH2IuItaMg?=
 =?us-ascii?Q?IFHn/+TXRUPl25C4UPYEgcsR1TrVtac5utBuchF0+Z+SHBpUmMWjiHyiJu0S?=
 =?us-ascii?Q?FwdH+2RBlgV5Q2F+AwM/XdeJH/ooQc6HJTDmRRj5AQCZvZrQ35P+SMZNw5Qe?=
 =?us-ascii?Q?S0C22NYo/evdybBm+8ZFERDVM8Sqcm0LrFdOyMZUCx5F8yrhpxtZh/luNreE?=
 =?us-ascii?Q?kUzClIgkyuFdMKm16LskeKi+dwNfiqCo0EA3il8HhyFKWG6aXjQXlQcZmrTO?=
 =?us-ascii?Q?eFqQVxWPfj5X5cJLTEVtIzyKNTUOBaq9QpTR6GhkOfRH7Mp4INZgTT64Dhme?=
 =?us-ascii?Q?YQ8ZIKg6ygyMUFRztWEtwIzgJn0Tln2WV7WdO3XEpoHzByCgMU0Y9/L3DpcP?=
 =?us-ascii?Q?V4zcQ3hbspNiusIpS2blJo3GGMu26R3YSXE+q+wSBu7gYLRkMYU4KiO3NA3U?=
 =?us-ascii?Q?XNBEVy2yT57hWRMjdSHiROSwBK1Doryk+/1VoPbZxdxctdf6nv0rxiVQytv+?=
 =?us-ascii?Q?oqSStW/zNVWTYEBgSFZa4q2zvXhGHTIgxhxnSYS0y10BJ7GX9aCJfP3y/ghw?=
 =?us-ascii?Q?psJcqk4KFnFgCnUTMGkdUWDnWdTqJOg6IGXd0eoN2xvPU3FOpX6X1BbzZCqt?=
 =?us-ascii?Q?eK9hCCP78iOYv/ZncHPLcjsAxD8tv3xP8dXWxh8mPl2DYw3oVPz6ocInOmZ4?=
 =?us-ascii?Q?ZaqGyCfuSPdYBh72vREeH1RbMDAoikJKoL+2KObX+IOoLCTjwXte1O8e1j/R?=
 =?us-ascii?Q?wtQdFL7LczpXVEz+Cij1T9AL8i4RpaFHcCz37KCjS3BDhS7uF+p/tSBcr3Rq?=
 =?us-ascii?Q?9uzJw0AyQNpAd4RgcDiXcpLFxP0fqVygCE1qlQvF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c5a9f4-63dd-4636-22ba-08dd096b55e3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:57:56.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc0V7fCUBwXlAJIIvYd687G0x53od+lQY9WHFdI8y8UUpTAGGl+pI6Cv7jYsvRUbNf9RhG0mc6C3NPttuC0hsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825

DSP found in i.MX8MP SOC can be used by multiple frameworks in order to
enable various applications:
	- rproc/rpmsg framework, used to load for example Zephyr samples
	- Sound Open Firmware, used to enable various audio processing
	  pipelines.

Current dsp node was configured with SOF in mind but it doesn't work
well with imx8mp-evk dts. SOF controls audio IPs from firmware side
while imx8mp-evk preffers to control audio IPs from Linux side.

So, configure 'dsp' node to be used with rproc scenario and later will
add a separate dts or an overlay to configure the node for SOF.

This patch series configures and enables dsp node to be used with rproc.

Daniel Baluta (5):
  arm64: dts: imx8mp: Add mu2 root clock
  arm64: dts: imx8mp: Configure dsp node for rproc usage
  arm64: dts: imx8mp: Add DSP clocks
  arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
  arm64: dts: Add dsp rproc related mem regions

 arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  6 +++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 23 ++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.43.0


