Return-Path: <linux-kernel+bounces-370897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29F19A3368
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0902D1C235C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D160C160884;
	Fri, 18 Oct 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVUM3yYV"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C920E31F;
	Fri, 18 Oct 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222627; cv=fail; b=TvuTtz6ASxW/CXnXZjAvRC271EAjxiw+HwpqpY/6yst8Q9aC1geUzQxxCk/YQD3WN4hPxoYb1VdGQ8XkAYWlG+qhVTOUjunodZvJU5sW3BZBtjg/1Y3c/FwMnUDHU3oYGrambxsD9HtBePo7UIChPs+cu7OhWQBMMLJXM1NB5zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222627; c=relaxed/simple;
	bh=lqS4sjre8zEfOpJrew+LqGpI0XT+YcZJYoW0GWMZS/M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ibRxCp7g/cTbtAsOqXL8tRr59UlVfPTxBGOJGVrPyzYyKFfSeeQzrlVFMgyBwyJClWDp4qW42gjcOWNwl8t5AZglFuRCx8Jqrriz3HyoxjFkLDFv6C+bSArKBGmcHZyheVtVEFxgU/AoI8gpWJN8biDjDwABMKtEG+ltLlPwoJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PVUM3yYV; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTTme1c3CevH6Ww4XgUCA5KOH5n02l7/3A1hmBobU11RPTpBl7zZ6jzJ/pw5gjW1Tm2i64O6hgl9YvcgvNvS2ijzk/AH0mF3k/gHxyTVr1gwRzNV/kDWJvHuDx8Mweedp56xLJ7uTseMy32HEEwjJ355eAzGbI2akMtD2v+BhzQLjVrOjLLvtc7aRAWyFYN9ZNf9GMuyNjnRreAuGjR1HnvmM9VUoQrqzwRDpitj+HeA6pnk/wnBqGydZp6f9Ekq+cr1XY17yqhhnMO3wDy/SWPesw0AzOGWC6w0tgYBz+90jRWx9BblsWVHR9vTfo7Dm/ub4Q++etwEhABeuiwDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy43nKwTHiXOjDw15yMl8tTJdF/l4Ci3EOYCKW3mVo8=;
 b=izB9TSpoOwviVLhSA8GOIQ+wtzXFRLuSG0H69zXm2XRC4756rw7SI51+bX723lV09cNqi6f2TGapNuLl1n4JzfffzusGe4ksfg7cG05U14JC/Tpi8XPsdVIMFtjw4iYvksFiLgXeliH+wpjMJpVowI8N+CYffViVd3cEH9gj4/6+M6AsdQ50+AyzlUXpUtwTyR/mVO6dG+MAAs45qBFWEDOkJqYvO9fyid+NntJLNH991pK6o7HlbQ5RBTNdTSetMVxJuhm5qGDFVFnt+TL5j5GuI2QO5fYutnobXOIt2fp5FWIjD3M9fc5dHa7szGJ5lv87izJIs61aw6p6eOz/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy43nKwTHiXOjDw15yMl8tTJdF/l4Ci3EOYCKW3mVo8=;
 b=PVUM3yYVxSaGQOmTlBgfcbCV0Vldros5vCWK555MoATGAgiHLnIFnaD7HcpYcutRfA60G1yeCZvO3kFCtPWhZ5W90DXhgnlRPwgH1OxghNlHol9Zf8naW58B+I6aCMIJAR2hDSC6xGs39OqK23DMNJ3vYcl/Ibqc5d9A6hp6H8IgkXqOPXRhIHqqD1f2ptkQwYxmvEUfxGfeLOzTIBSA/XqZsHvgs6ZdLyV1qHOXWzZIbdEjlP54/Ub0qcVfp9fIjbDwkHLbDCETcDWkeyAMItrW8Xf8KmMuplvAtmZhyox1ItXh2yP13s/D0qFwT9lhP0au9wr+2KEP5LnVvtY+AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
 by PAXPR04MB8110.eurprd04.prod.outlook.com (2603:10a6:102:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 03:37:02 +0000
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0]) by AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0%4]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 03:37:01 +0000
From: carlos.song@nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	frank.li@nxp.com
Subject: [PATCH 0/5] arm64: dts: imx: Add LPSPI alias for I.MX8ULP/8QXP/8QM/8DXL/93
Date: Fri, 18 Oct 2024 11:45:27 +0800
Message-Id: <20241018034532.2552325-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3937:EE_|PAXPR04MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1f9d66-de05-4c0d-0316-08dcef261433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RoTkow9XOgKZAHF7qmxvy7ONliyBFbqpvsr/5Kmy+504GMST3utKK/bpOfXG?=
 =?us-ascii?Q?63KgmXAH9f48WEdh4K+vWKNoKSna1s3GgwmUsZ+0DH0GRoFEzI9mfuogR6j7?=
 =?us-ascii?Q?XGNFImngzSn0v9vnVbBBQSzYZYEdQNoeUwyo7EUx9fsdLl0oM4P8aY63DeFl?=
 =?us-ascii?Q?czXw1j050guiEeF6lmNaD6en4XXp6joAQXSvZykvGXzCNXfWHqbSIpaqoDIp?=
 =?us-ascii?Q?eH+8i32uWf1JyqpMu0k6xlnLItGNnGBWep8IYPqDrXhOhgE68vSwj2hk1NHy?=
 =?us-ascii?Q?4qwCiAUqY/kgf1vGzm90m4LLLdnm/6Kidkele0GvlmouciTf4Jnh67WaL8QC?=
 =?us-ascii?Q?IHqIn+MnqGIfZYpGJK38xvSEpmmCSvPY1CzIViXMoidWBzFIdFXlqla9W3MG?=
 =?us-ascii?Q?/r8JBxDuMpclrNL1IDqxtkFtYmnrTTizxheFqeilh2kiiqcx9AxOukFA06pW?=
 =?us-ascii?Q?Ljy5DGUIAezdwIq5M8ZYypYUkhAmMFxMGnj9KdTnARwHmXFMipzoIgObFBx5?=
 =?us-ascii?Q?knUKKjtibgDDwiv7LaFBe85A8xKy7mwyj0jttM0lEvjJ6OufMjBmMs29f6xz?=
 =?us-ascii?Q?kPaOfT2zNIH8MYnUgTUxXpngaD3p508wKYizw9JkzlcoFvxBFUKI59GHfNEO?=
 =?us-ascii?Q?0xzL+MbolqtboDzk5yKqDfr8EZMP9TSBnU7G0I/XRTXANINPp59gy5gUMWJ/?=
 =?us-ascii?Q?UzM+3JwKoNpJBBAIFx0qorDrB3L9ElARZD0WQqI0EeHij6Ba6adJqoP87WHu?=
 =?us-ascii?Q?y3bA1QLVuwLqlc6t5XH1iiyEyBbGhGbFQJEvU65VxdGDgDk+R0xPEsyHTXI1?=
 =?us-ascii?Q?+P0gfPcEeFBnjKhAHE93DzIj09AgPTH9q9OQGKk7/Aw+WKlNPD6tRC6AHFqn?=
 =?us-ascii?Q?Zfqm169+SNCbi9K9gsW3n9sZxoQ7qKNQQI5rPO7xXCLvSsrX6OhZWNb48Ng+?=
 =?us-ascii?Q?knBG4L2WmI3RHNNWMYlF1TBTqH3ToahNZqwNfrq+Fgjws1oLoy32BjSJW0f6?=
 =?us-ascii?Q?XZyh46UnYw41wWI35U28tWjm4nHeS2d2cC9DzI1PxJ7lTiDjC6alcabnMbWS?=
 =?us-ascii?Q?nCX11IJkKn6SuLXHl06IUMYGXk5e16aPkYA6s+3YLS6dnauO3BMLM3luKmjS?=
 =?us-ascii?Q?DYtkgt1gw2ZSS8vQekq3PzdOCSYIrhHh3iNJ6FEUkc2xqDBrEul4wW2wOsIt?=
 =?us-ascii?Q?qRWH8D5uBmqQ+f3RUDY4BxYQ/qAYzXGD0H6c1OpQELF/e7tDm4HiH34n27mb?=
 =?us-ascii?Q?ogDrcF/qbedrIO441k21ma9WlnNnia3Uj6oSAcgZBquTU7/KYaYBiBJHZotw?=
 =?us-ascii?Q?qpi2QjGWh2W2tOvtbmxzWrOZc08BauCLCq9ES1kl++JhXiarLSvHmavkEDDG?=
 =?us-ascii?Q?7uoNJws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2f/zcJHOIcUmYcKyCF+GbFuEzliwxX488tyCZAt+Jlbb584G2oczCPJSsszQ?=
 =?us-ascii?Q?1P74kSnVLTL9gaC94eaVahpIO9hU4rnoNqUa93HReT6dUXp8pucZSgarOEyj?=
 =?us-ascii?Q?FmRzbTOflYcofLUz7hWkTsiVy3VoWVy7DgxdiYTUVC37YxqmXVEupvFCc974?=
 =?us-ascii?Q?4kYTKYgiv9PfwZmh08r1i+EPRIKqJKMjW7Tu2OxK7x920iNK6KudE2d4Hpt+?=
 =?us-ascii?Q?1yf02hkrSAWhHMpSe+co7pakiFHODZDxyjb7pIVjYhlNjAg337SpcslsFwRf?=
 =?us-ascii?Q?CqQhyA9TxmfIWiTGJXVLKMmzmK+jiqgtkL9HnqaNl8B2+3xbXIrSum5e8uqM?=
 =?us-ascii?Q?0+LMdXnnSkH9T1/DOpZi5sQPI3sCT3kF1epywUNX0NIzIM16XazJckI8mLGp?=
 =?us-ascii?Q?0mg1fNkQ6/4o3viyL2yZN3TfpuKUB43mshkWvvoopQlJ2jJq3g1tWi1DIzw3?=
 =?us-ascii?Q?H0Ji9p8TAg2PJ6o2oVpcLMYSz7Vc3+LFs6301RsEl3x/ukhmOz9IJY5fSVoK?=
 =?us-ascii?Q?WLe0iTy2JFRSK7DFZe/9eZIsTeTcJUo63YfBrIUMw/rQgu0JnswKxmbdbgdm?=
 =?us-ascii?Q?/8l95XvmKmZQA1qKfkjcAdD9OIz1b30qEYz8tY/8sq/GOwtX+Fahr3HiXDPK?=
 =?us-ascii?Q?rQMj8yXglAJvX3xQXkj6TDS8p6tiR9LFgJim1BjiRVwRQ3TyJeMndMaFRwwG?=
 =?us-ascii?Q?8fCcu2Isp8whh7aZcIXa80gUNGRx/UPd3FFTB/b+6wgWi3F4XmJigBrzI1d8?=
 =?us-ascii?Q?u/YMX2nuljQHR72HNlaHwtxpOnOwkgH2SDGSMJ4orv09TIKwrqs7GiEIoxfI?=
 =?us-ascii?Q?NgIKMPXnaKdIT/OeJiLm82X0q3CdUwBdG6tLzC8zgIBrOcHWifE4eTmXJC8L?=
 =?us-ascii?Q?t0k9aPsDCiVqmcVSjNLm3+6ifUVuxQuQ4BgV0Eoj9fI26rVrTPOpdakKaBWx?=
 =?us-ascii?Q?CwV1JrPT06Vi0wSwftLtYIWQ1Q+4N3E84gFAnoJV9QIrkGltLsemFrssSHto?=
 =?us-ascii?Q?rKrJTWxbaWxegypzIF2QV4cLdSJA5GkJCursdnx7KMVArVKwk26RLMBL4pDT?=
 =?us-ascii?Q?sAPVHLhnKVWYW9W2vV/dcrCtY2h8MkGeuYISEv9dOTCk6BTxKACoR4TdQxyR?=
 =?us-ascii?Q?o4k1ZjEgERePZVQFFy8ZCq0NKMzZ8gTwQ7I1aAmg7KdOGJFBrhLK1xpp2viB?=
 =?us-ascii?Q?FDsMW+o6jsaim1+PH5Zd9eC6J66OG1D02GF5r99Vc3CY2qsmaYszHCGaIH6a?=
 =?us-ascii?Q?+1NpGcchwID0X5ws7rLvTVmKFBVPWfjgOsMaARj29zHcYAc41eE0fv0dXDk6?=
 =?us-ascii?Q?wroSWu8KuUkpyQ0g3AD2sdwY2Cbvav2SFOik5HrjOAVLR+vjTq2oaD9+uikD?=
 =?us-ascii?Q?S9jZHHwLUwBkL1lpTq5blLPSmZpCEnSakc+KZzOQ1gqVrBJkqa7obGD6tD06?=
 =?us-ascii?Q?wNvIYF2dHIC2qmS04dg+9u9bi7SC8oszyox152acBH+6RUXG4kKuJMgT9/Pk?=
 =?us-ascii?Q?Ez/3XT2rnE0ZWQMMfkuxcMXixF/LIsXHsXL54HqwTUa3ftnXhUSmtLX2gxnb?=
 =?us-ascii?Q?iPX6dgxmMe5nCUXYKkNh9nPjShNrHQetJrBYXcC8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1f9d66-de05-4c0d-0316-08dcef261433
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 03:36:40.8104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SQbckNfwqrdg0GES8/sXag3Yn87ojd+xIhN6FIFg9jaut+ZcRMcXjSnxybuFROIAm1up2vxZnlXipbSdy8eZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110

From: Carlos Song <carlos.song@nxp.com>

Now there is no alias for LPSPI on I.MX8ULP/8QXP/8QM/8DXL/93.
So spidevB.C index B will be automatically allocated by kernel
incrementally from zero according to the order of registering
spi controller. In this case, it is hard to determine spidevB.C
is spi interface of device C on which LPSPI bus. It will cause
confusion when operate spi devices in userspace.

For example, in I.MX93, When LPSPI3 and LPSPI5 are enabled
without alais:

:~# ls /dev/spidev*
/dev/spidev0.0  /dev/spidev1.0

After LPSPI alais is applied, fixedly B is the LPSPI index and
C is the spi device index in spidevB.C. They are the pleasant
spidev names. Directly spidev2.0 is the device0 at LPSPI3 bus
and spidev4.0 is the device0 at LPSPI5 bus:

:~# ls /dev/spidev*
/dev/spidev2.0  /dev/spidev4.0

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Carlos Song (5):
  arm64: dts: imx8qxp: Add LPSPI alias
  arm64: dts: imx8qm: Add LPSPI alias
  arm64: dts: imx8dxl: Add LPSPI alias
  arm64: dts: imx8ulp: Add LPSPI alias
  arm64: dts: imx93: Add LPSPI alias

 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi  | 4 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 2 ++
 arch/arm64/boot/dts/freescale/imx93.dtsi   | 8 ++++++++
 5 files changed, 22 insertions(+)

-- 
2.34.1


