Return-Path: <linux-kernel+bounces-408740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDDD9C82F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23E1284B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBB21B6CF0;
	Thu, 14 Nov 2024 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Agm4rf4d"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0F15A848;
	Thu, 14 Nov 2024 06:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731564655; cv=fail; b=RyR21MSl/XIFcr0GpJySsfuuF9ii3g9/tgtm29DrRmIT+ZtQEtPe4AUar67O8x4wjOe6mylqinSPT/1qmqAJEr5wteGVdjmengz5TQ1P9eUTD9en9lp90X4Wg5xIw+uK3l0eCMEZmu4v6xMsch7WOpMzODYtJzfMzZsotXjVlFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731564655; c=relaxed/simple;
	bh=YcMZR5FqctT10gDJOHawywRqBaZyq4zyxaGcseUQx8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sr3tAQ0tJRujkgJF9rf0nFZU23ltHKxr4vTAqrXveTyUdgL9fvKbVILQrUZU4cABKiegFEN+kNGUUygckJEjWLsv9ePyIHcroL6wmzZfZFQKUWMBvFZm5z8q7dAtucQIqiHM/4MFfmOxvtlAfJhkf5t/3tKrLJCEDNorZzQHYr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Agm4rf4d; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtpu0bGbNLNmNKwc+z27iW+kFixC1WRCpBxMs7f5WOz6PsJ/+Tdte6iDLFaK4b0mtjmE7gQzwMer7uyl1q0GqyBbFYcEBqPvC8mWiWJSwE+Iki7tvQ4NYyfsdRRQc1XhsZDGNSxcPxbvRW3Tv+VMZUr9gi7W5OONzMeIoYe5REn8wU5H5irpoEVHSZdGxz/baGrz3hMbEIzAwQ1Wb5FoBuTGp9D4nkyBtYVo5cB+MQCXVlnJ+FZ0xEJq4j1ldyXIwHUzqPVGA/X8pqyaad5+lyGzqRL+A1GApj8XPQ2o+2fvCqPerJ+kilp+FXZRHh7CWDipWCGlQi19pi+fd34PPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9twButjjIyZO6V6SYWcoTNHs2+dVmdvEM4sKzA+Gn6s=;
 b=robdjQQn1zNodjYQBpGCTmHun53Izhzn4n0Xyk4A8GMx23vpRhTHPuudxQVEWLb9f72R5AkSPxRP7BlzL5krbNqB3XxiaTZaoJiFwIqC0XjzEl++8FxZv0RCv4SsnBXMD2ZbwkKdXW5v7EsDLmGjAj4/hkeFP4eTZrqQB6Mt7VMVmF8X7gEX7mfgvUi6KWDUq8mN92QVi6mXIC5PLonvOTSML6UQrmeUUAERvH3EgljDwVYRMK3j5D1tk3DEwssJfoXsw7R0wZIVu2MQ0xXGxCtjyQHL20U2Ry38SESjGxeFaZOdtKLfD63sOvVFc4SBwWv30J/1bS6uWXXmcc1vBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9twButjjIyZO6V6SYWcoTNHs2+dVmdvEM4sKzA+Gn6s=;
 b=Agm4rf4dw+1MYHFpKp6lG4aC48fjc9BPlO/SFdAx3HhXzrXWSiJwfty68yqOZB9yToeQXeKO498WgxiNBJPIz6jyeDt71LzLs/6IEQpSpzZxT+Hlfjqu2pebij5aexhCk+pVL9qSHYR55V+uGyzUCGPBmaTCW3qj2jYTuKql3SkLRkzfXO9eVU4FCwH2pTehEwWcCaXkT4Y+TLvFDzak0oxAWZbgzv3N5SzPKvyplS20Je1twQKAz7eq4yIqD6MMHxaWW05avzPmSWu7SkfCNZHRIuEFcEqLB9wo8ujux1Xl5zLV5TtoOZNBTBYAA50Dc7IB6A8wYiJ/9hDXl3N+tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBBPR04MB7692.eurprd04.prod.outlook.com (2603:10a6:10:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 06:10:50 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 06:10:50 +0000
Date: Thu, 14 Nov 2024 14:09:57 +0800
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Frank Li <Frank.li@nxp.com>
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
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add i.MX91 11x11 EVK basic
 support
Message-ID: <ZzWUNbihmwAgRGLO@pengfei-OptiPlex-Tower-Plus-7010>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <20241108022703.1877171-4-pengfei.li_1@nxp.com>
 <ZyzYUkBH8rH4bTZN@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzYUkBH8rH4bTZN@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DBBPR04MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: d566749b-1ef8-4de7-d849-08dd04731673
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?9BJ7+km3o4XMjccJz0bFsmpG+/i0Ll7uNjUKIZFh+eHzgdYdWV78MW/WhIQu?=
 =?us-ascii?Q?EjaULnNl92SvuD2Oit4xOSTy4cNyWtaP4ch7+eON2FFY69p+Wp/2fCoQCcrW?=
 =?us-ascii?Q?En8Tvx5F690OkqAwAJFogiuB9tNzN16YO5rmA5xQgTo6QiKAaTFlSi9QgzaV?=
 =?us-ascii?Q?hoyi7vxv0bPe/0Yz0Jyb9thqVz4oTedety5R/ePgbvwYghT2oh+MfAjBUDFi?=
 =?us-ascii?Q?W85A0mfx5iJG0Br6Pjzp2hogKZvYPcOYNdiKVxllMW0K2oLEdQmxH6W4aGME?=
 =?us-ascii?Q?gPn8tWqkbACqPPVUNxowmPLHKuI5lVFOT36ovNl4YE2b6qFlbwZgksXcJG2e?=
 =?us-ascii?Q?4Xns/zOPF+9DfgF1Wy5f3AGLgw+owuWTOp94cL3Br/2uoEFtJ10nNJ2MECfO?=
 =?us-ascii?Q?TzptvkDaBZdlL7LAkMzLxRUVoXoT2WjWybtwe/r8yt3poKNKUmOnn8Mt3DQR?=
 =?us-ascii?Q?6FsHubutn/UL4TckRu+p+imRl0KnmhBMhPNncNXyiy5OMDxX321nQH3GB2uC?=
 =?us-ascii?Q?ZBZDUj+wugQd7d5lZLkkem0I34Lf/lVDporLpCO1YDvVr0i2v6I1jYAN+/kn?=
 =?us-ascii?Q?n5LZiqtwL1vjRWrPmKXv9p65pemuQ+WlxBwlk09mXc3xizZunSChVZ9hriCD?=
 =?us-ascii?Q?eUqmIvRHHZEzmqoInbueWgUcL1dPO7CF2W7y+dPDkDfpxQACT9n8mqD7XKgy?=
 =?us-ascii?Q?6hpIMWoaz/oRciDTcWsPKFKJje72jToSi2L+/CUYNaRW+u1wkUgBuXlXBlr7?=
 =?us-ascii?Q?7gny9WVA/9ck8pkysGM1h0lwHhVkwJOGawxI/AZ/3oIqZbfDFXk8MKHSEpam?=
 =?us-ascii?Q?V7G2krW+qjYPlHxJjZcspApndxh4pRaEf4VFyACia55u9bXv6p985wZtJ3V1?=
 =?us-ascii?Q?/cK2fcPM1fuVyRtvlOyaUQbhkfXdkV+Knq8WgnKXJoUIzto30sPYVo4sjoWc?=
 =?us-ascii?Q?fx3mjqfPpgSSjg1zESqCQWrhX+tUM6Uut6hY52IYuXyyygcel7mdV9wx+bYK?=
 =?us-ascii?Q?10dM14Yp6Wu/bhL4uIQZ18mgfUpRjSQshpbylluOGe5Obbikjr2UVKTBOEtJ?=
 =?us-ascii?Q?mCGE4DJZKJZoUQkhHx5MF5/mul4BJrg3ruR+TAIMNAUlDQJLWn+44rC5VPVG?=
 =?us-ascii?Q?FaCqkxLvd3Nk2RiHCGtwxjO+oXU15FCXvp/xfTktaFomlhhAtYjHQmvpSXUF?=
 =?us-ascii?Q?DfA9wwE7XGkzBsPYamCH3qs3PpNkkdrvbKStjP2ke+yDtDKYm5BWuTKr336P?=
 =?us-ascii?Q?TNlGpsaky8XbipP1hfNoKq7FOx3zWo24KM0FFSXVw6n9hVKJaMTPXgJOFsd7?=
 =?us-ascii?Q?A7TRp+AEsAN9t9mHCiOnzzBlmIZPCuUsCRxrn4tMtlb0tT2VWxrpwEscK/fh?=
 =?us-ascii?Q?QPkmTMA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?hL9eo1xoj7+MOlVW0QRTvfv2STqsy+IBW5KPQ5x7aumXpidfd0e7DFDryYLR?=
 =?us-ascii?Q?iLcXFtKcn5MKgYsZZMnt0gDjcVYFN/fdL4G3QKw6MfQ24N8jmRaSvbCccv82?=
 =?us-ascii?Q?5azYW0yZuQcY67DYBPnaP5pjk4U3DgDEY4vBdBZUsoH7NqiCat02f7p8B56s?=
 =?us-ascii?Q?VnhWaSGIQgLo5BOEJAFQCBL4Z757/dwrtBmxm0AYeplEfZ+Q9FX17yLJ2vS+?=
 =?us-ascii?Q?xnvcQMNTfvQVQr+zbebHjlTfIS9Tzc3yZIEqQojbgbhh2G/4aB74Or06HLKr?=
 =?us-ascii?Q?EWDA6JiLIomsfvPwz3CLoPV/FfZXfftf9V6Xocsq617vEUHcdncpDnosNU6W?=
 =?us-ascii?Q?wuvD2OOkKnw51wWtqLA9B1MmRuBgbPi5mXQEfuqSOFq1qn3dpkxvbkPY6U5q?=
 =?us-ascii?Q?QgHd/mOi7qE2/kKKTn5qK4TVbMJQlbtxCsDGdSH+C4oOtZsflAVekb/TAIks?=
 =?us-ascii?Q?6sXT+XwUBVoTHPfrKxOb1R93RUDND33FEzTXdCc+d1YQTpSZXr9rnOjUJfG7?=
 =?us-ascii?Q?71Yc2po3bPIJjYlAIdvrGRpgXT+PH8W2gvGRAUlOEv0XYxHe5U8y1SpRx8Og?=
 =?us-ascii?Q?QaN06HTvVtgpuT9qBQfkBPjQVEUUaz76Duhl2/rdCe3QoyPaoNgjc871Y/s2?=
 =?us-ascii?Q?hcSMVBVzUTdXAASG4XrGsbu65Zy86+vQVwgIcFyIF43KZEuIKKKXVtsxz4GX?=
 =?us-ascii?Q?5R7VT1WSUFPjPIMbM/vox2cydvrTXQ5HRlVZX0roudjsi4S5IcDOiL8LQF+Z?=
 =?us-ascii?Q?f3lvRIr1zloZvDal1iRsvgR4XtOBVGmpOAjDf77b6sCPfdIWOdfbdAuSaPz6?=
 =?us-ascii?Q?Z4u3YWge/S/VTAh55ZPZ62VJ3s1WpkAugQGfmtTtHwB9ms2aJw1+RuA1aCHK?=
 =?us-ascii?Q?DK8I7S8W+gKJUWgYVSESPPl5dayQnCkWpMfFui2qqVHjCDeItHbAxVi8aVPT?=
 =?us-ascii?Q?kO7iEn7EYb7s+2XlytacM7q1PfZRxFuYVkFLt16xOx9ma9w1lwDj7jEOxypz?=
 =?us-ascii?Q?47zyYsk5GaZo0UzloW9yK588SgCpkfVlVUSjUFgNGJpyJbKUuLwZ5YyPn6/O?=
 =?us-ascii?Q?FxXJYnrBiaukgG3XMoiXJZHZvwxGHapyzyestUHv6oEGHlmeuleLG4R80q5n?=
 =?us-ascii?Q?4HdAnypCEqsmO1PymPpEwLnzFqfPMDn5Bx5LL+tOI0qdD0gDurHDYRqU2ExY?=
 =?us-ascii?Q?qmg+NKd5aK6zOA9ka60C6IK6fIWAXP5F1BR4erJFmS4pOkosqQlxYLPkgsvi?=
 =?us-ascii?Q?j72Cxbkd6oBb7rTS1zO4+zT5IJiCkwTH9dZKYP2RA1BOKVWDsblscq+TkIOQ?=
 =?us-ascii?Q?tgX12pN5FlwvDxMNwnuEgotiK7vUMQAYf/mpnW9ZUMyW7JZ3UMpbIBKGPSCp?=
 =?us-ascii?Q?r4mOFAdXQu3+2XnblK/bSp51LUg8xYGRo4jzQGmiDCovl5nvyxX3bikWhwvw?=
 =?us-ascii?Q?F8V/WJ6oKYRXULXFLQ5ebKnQ4BnTVfOVb3jMZ440yAW8wmH5qt0eezGRHGOs?=
 =?us-ascii?Q?V2LLuVdd/G9D1QXoq8u091sirpEhwDgZznoMxX+4eY4m6tXM8cTWQKs6z17z?=
 =?us-ascii?Q?f6Mt4cjng0eI6H9Nd4kinfbrjOHbE+WPTsr6WOux?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d566749b-1ef8-4de7-d849-08dd04731673
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 06:10:50.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MQIqKicQtIYtPCZdBkeHuK3+5jkFeoP5CiPPpG6CLSDS/MEsE5gPWz4jwylTdF6NIQeEkKGEq59cTLlOg8hGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7692

On Thu, Nov 07, 2024 at 10:10:10AM -0500, Frank Li wrote:
> On Thu, Nov 07, 2024 at 06:27:03PM -0800, Pengfei Li wrote:
> > Add i.MX91 11x11 EVK board support.
> > - Enable ADC1.
> > - Enable lpuart1 and lpuart5.
> > - Enable network eqos and fec.
> > - Enable I2C bus and children nodes under I2C bus.
> > - Enable USB and related nodes.
> > - Enable uSDHC1 and uSDHC2.
> > - Enable MU1 and MU2.
> > - Enable Watchdog3.
> >
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> Most part is the same as imx93-11x11-evk.dts, is possible to base on it
> or use overlay file to overwrite iommux settings.
> 
> Frank

Hi Frank,

However, /delete-node/ cannot be used in overlay file. And imx93-11x11-evk.dts
also includes imx93.dtsi, which would then include imx93.dtsi twice, which
could cause problems and difficult to maintain. So I prefer to use a separate
new 91 dts.

BR,
Pengfei Li

