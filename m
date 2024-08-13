Return-Path: <linux-kernel+bounces-285234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B396D950AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A82B284386
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF631A38CE;
	Tue, 13 Aug 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S3Ozvc/1"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1821A2574;
	Tue, 13 Aug 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568456; cv=fail; b=cCwSOseyQCvyaHjx+mKDSFxnGfusJeJF7e7NSo/KQZuUQfxeUlRk4dEAmhzrbVkw3r0YFLEoqvxHst67AP/HBp+NIT+QcVdzVsnr+eQ9L6EsngK1Rk/JiD22B43wEPaFEjHn1sC/q3PO6EmQcEOfgfVBOAyyO5Nxqg8PKg9b/zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568456; c=relaxed/simple;
	bh=yuVZeRY+DH/ASx6dNwASAhnNPyZjTgGFha9YVPMBwkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EaOa+LqZUEChUisyMvCeql/OuOWsOJzIb1wa0MHRk7KO4pp9IujuMSDJn5SRyYSlRsuaA5NtjEu1RkuQaHKos8Ndg4jL5FZieLuh4p1YGIYCM5Ybrr/M63PufS20uuLAmC1cjuvqS6WOxJS89p0z4XdzcGJkGvjJRfcafE3AMhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S3Ozvc/1 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eILfajVcTjKn7/ZaWzDSTWyQKgF0NTGiM2CSQVjpKSPRptxH8zB7FRtIyuqhhLpIMv+in8PYNbF+uRxglmFc8e8rtS0eIOHg9pBxfvHFDhvvj6RGMlxC/JKZIHx47duQWIZO+VFC23j3wlDmubpgWz2ZrjCr1zDlHay4ugTF/5FBtiljdZoNlkAYoNG+l13DHqavjoFEwyoUgg0c/Dxaa3olqpGqBDiqJdgGcHG5StH72mu/st5APhPjSSOyKGn/VdRy3TgrgCi7Ghlz4DHcmfUNApr2swbR1S1NvDcQwtBwnHeZ+RdKFzG42hxwMJ/86JjFoQ0z1MzlUuGQtnKs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3zwIxgol90uauLEwBajMLWb/zcjrH6uyYZHEhKpaq4=;
 b=EH7J1lEO/JyejmwWFPF54rbytT1Cq/sw9c3lzFmzxeN6k+unzcI5c/tUCCCdleTr3cdGmCG0UL+JXlV3FRkMt08qNat7V4tuvp41hCwWkXAKXlJnHkl+KkTj54jZu+cjoHgjHMe5E+F5ZVt7ruzQT9L6yYodeiukGm5cSav6D/PkJZ/uZehX0kkOv2nz5xgV9gcSotcxdC8eAvhMJdecq0iVhPKNzB/MLbL7exxIwwATXAgj5Q0ECeTMlxUWLaZq+r+hYk+CrgF7/COTl83DokiKWfNFWLNUnVdUI1qUJ5m5JU+Z8yjAF1SpftygpEnX4PaAy8lozPUGJxwcA42BWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3zwIxgol90uauLEwBajMLWb/zcjrH6uyYZHEhKpaq4=;
 b=S3Ozvc/1a7zF/HzhnolUyQTedgfnciVvN48qZ6mA4Q5Vt5DmpVTwoA9B455ADa/+XFD8Y2XDg8mWKKqhf/6XtTlr1N+g9UzNtrdxVQ9k3a3BWwpqQ++WlVsU0uOjL6A4nTfnu4Qrm7fQ4D5iRXpglHdVkZHe26K/gcirCrZ8kP2mGvJV0L9VBho+9F7LuG1nUiJA5CBH7OZSGfjdX0Au4OEDfqO8DqvJ3VNdvGQJIuB+DDNLSl0TXN4irziTZ0QhQHI82WSYqslPdxn0Xvi0HiJXBF5pbEaPV8j/tggw4WVv/n8M3XtsjTEiSPtZ31SFXvKsuR3xF/ZMpkIdFWf7lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8077.eurprd04.prod.outlook.com (2603:10a6:102:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 17:00:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 17:00:50 +0000
Date: Tue, 13 Aug 2024 13:00:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH 06/17] arm64: dts: layerscape: remove undocument
 big-endian in watchdog
Message-ID: <ZruROoTQeYWgcw1c@lizhi-Precision-Tower-5810>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
 <20240813-imx_warning-v1-6-3494426aea09@nxp.com>
 <7700102.EvYhyI6sBW@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7700102.EvYhyI6sBW@steina-w>
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: bd305ae9-a6bb-48e6-6d43-08dcbbb97c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?yQXYzgD/D1xi7JrzLuyr8GYkJ+/WT+bPAbwSg135KYzvM72YZP3x/ls46V?=
 =?iso-8859-1?Q?mSffk1ei/2bWrcqiPseX8+j72Mc8BpSoI1Ee5avCvw+HqaOhlxQo4loPMl?=
 =?iso-8859-1?Q?2GQHucMCp/IgL0QKN1MXYppqalIZuQAlDm80tb5NGSSWab4sUfYVNuzn3Z?=
 =?iso-8859-1?Q?/0cWuj6TfraLyXkhS0wWkoD4ebsrnTgPXCCx9dD51/wtdEUWOkDH/qbtom?=
 =?iso-8859-1?Q?co23Vrvp0JTh4agXOd5gP71/z4u+e7QtDRg1Xsb4ZiP9j3iH7e5toi/1Tp?=
 =?iso-8859-1?Q?GBD5PfJwGkKUJ0NVh9Tvhj7oRh9xQalFW6TtiV4yZUCFtK7ThHr4m+x3mW?=
 =?iso-8859-1?Q?VGdk20146MsGho2xh6yqtHF91TOQ3tAlb+ab9Gmh8y3mDUdKN2zUUcnIoc?=
 =?iso-8859-1?Q?e7GYSb853dkR4bTe3fEk8bnJZumBCqOvSffeuz2GYv6POKnsam+v2c0u66?=
 =?iso-8859-1?Q?AJan4o2ONY8hrGFDXTayj5VqkYLExe4dEnu2hsCVbm5bTZWCuPJlEupaRQ?=
 =?iso-8859-1?Q?JrWSWDY5AaPAoRVVQ/Fxr2HTnjPsD1kWrZMEEtjN4qd2zje/ctcbxEX/cq?=
 =?iso-8859-1?Q?LAeifuELPau3qUhpWsr5MD32r3pff0H3z9CRRUHt1cEveNz4OhAzaBxIZk?=
 =?iso-8859-1?Q?JYA/YHt0UnxuQzX96/6ipGlgIuvQaCg9XfdN+FyEGuTzNYmqGbLo5sApCn?=
 =?iso-8859-1?Q?9NSdKecalP/q1lrebtplscrOyAt3Wv0TUyJnl3HA1WyCs+x5tOMplTuiYI?=
 =?iso-8859-1?Q?o2psNtyK3pRAaAaJqUkmUwrzWlD76FZy2/PV1fw8Et5Q5wTk2M02srMqPU?=
 =?iso-8859-1?Q?XaGsOhYtio650T91o1wfy3xKd4dPBfJjohpW1Ybrv69BrL46nkC/JHaZ2J?=
 =?iso-8859-1?Q?ksYwQjrDpPEJjO1cCusz4C8TgNirez0L6T6nD9waq716dKbsAZLn4RJibv?=
 =?iso-8859-1?Q?hz21GHRncHw1enTnEQ1ySB3VjeDq5NTrk5RuLhgtB83nPrBi6OYeT+xZa0?=
 =?iso-8859-1?Q?0XSFPsSBFn6H/IRqIJySCMc1VA5UIhdIcVePKtudYpgufXfhPt7Pi4O+hV?=
 =?iso-8859-1?Q?NXG7sdgCpEkPdYEXVFCAJk4iOk7RTM0HRCIqb3Let6lBQVNx2i+RoM28k8?=
 =?iso-8859-1?Q?mwdclZ0F6MhwiiYKcieRY9lF3I6oFxtt0P4E0p/HhkZtNyk88fdRGwehvz?=
 =?iso-8859-1?Q?ADwhi5MFJ9FyWoORw7i03+GueWRKkZO3xbpHkkCpcUFNeoqsmuYmFqVK2p?=
 =?iso-8859-1?Q?H2/DE8QbNK9+1OzPty7Jo0ZigoIt8eYleeW6yLq8bOo7UOUUU6pSyOKMIu?=
 =?iso-8859-1?Q?/kjuWqnFaFj6GZnxwpKJ2hhecGaE27cXTOf2Sn3wN8tBgAnxhzkrVjqRUQ?=
 =?iso-8859-1?Q?Z4RCRUKnf5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/8H7Wsqv9H2i/lNO72MpmOmh8idzQ3kyDfh63X1toviZflyGVvW+cbjjHh?=
 =?iso-8859-1?Q?o1+PZuLo9cT4aEffLALLnNREdF11nr7WsEFvPGz6oLeGRbPPduaNR4msf9?=
 =?iso-8859-1?Q?aaKG562IZKJWWC7oYSPckKpVQB9zCyMX+Q63VNn6k7Hhbd5xle0pdn58PO?=
 =?iso-8859-1?Q?n95w51rxe6jSkp2fremchNyh9Tpo2/U1l6G8OXjUA9v9NqGPgrU4zqi1ob?=
 =?iso-8859-1?Q?lNLzxLyk6tTuu8rvq5A+rKylh+rikzmzzptBfMqZ08tkpqy+TLr+IUiLrG?=
 =?iso-8859-1?Q?GrPn9SpcMXMO16BJC1j8A+fWSnGrexMpUS7rrh4rC2RsjdfU1nGztCup5G?=
 =?iso-8859-1?Q?WAd70xhCsyFiDYvICuEjGOXHNi6kEw2RCAr4HdQ7uUwSvk/CNkGKRNGDie?=
 =?iso-8859-1?Q?0xMEg6PtGF05l28UZIgmvqSk5ti0vxjRcFxp8/iLNUYzzJmMlOqlHyqrgo?=
 =?iso-8859-1?Q?wsXt/7QwYYx/0RKWRsp7yOx7NLYFQMOQZwNOUfvXKKs8vMSCTalnJqdg0z?=
 =?iso-8859-1?Q?+Bfgd5WvjdFN7hk0KbEa60Hy5NKmSWRXBYGlGIxPBZLEHpLGT5Uanw3sus?=
 =?iso-8859-1?Q?CmtR7Y4HXU3Qt5kczPqBPZkzKnQAO4v2HXiRVxW+fWrN8gxbvU0u+yfaw4?=
 =?iso-8859-1?Q?Hws1SXjUVG005NjQUU0ADZ0+vAmc6JwpZy8QhV3+dRCeiBIRf1C8OgJXWX?=
 =?iso-8859-1?Q?/Dmmz6/74K/LDeTYgkBdXdDgC8wlLWf+ByYZAJ+VQ2spSoxov/0NDmASwL?=
 =?iso-8859-1?Q?AXDtsUX1WO0LeakfbLCab5Od/lu8i9/Hj4LdA0WbmAJfx1FIAPAmnTQ/v1?=
 =?iso-8859-1?Q?Mzn2cy8bWAsMMrmFVa7Vbnlcr+7WDnUDUZ0UcHQIP3DCiYEbRT1vdusvB9?=
 =?iso-8859-1?Q?VzMyaxo6jorawo3AzTFzCwL4LioX1Wn7dZw417HAN9pjhFOWIucXhSOhOt?=
 =?iso-8859-1?Q?drYSWSIn0RHgDIZhbIZajPUwoUJJG7FZmivBJUQ11q8ztrX+mSRSXTA7y1?=
 =?iso-8859-1?Q?2zInXmKH89XVrVaIv7t1PpKt3TphQ0I4niBCevwgnrZw8POaK6HLwIOW0t?=
 =?iso-8859-1?Q?y8JPwZOKuly8i01wOzXde3Tg32cBV7wBVYWjQE5S95siBHizFfOkwux6O5?=
 =?iso-8859-1?Q?5zObvfhH5qQb6vuQKbgNlWl6C5SDOOklS5q7TD30fc0KYgGpN0azebJMXn?=
 =?iso-8859-1?Q?NLps9TGWkLxFz2mJN6ocl6ryVi3yuuAgcenpRo0d/KHCAyhq11Gr6FVrQf?=
 =?iso-8859-1?Q?B9I+js9ugXUXY+gpMRDbZMt1FWRMdHYIhvGeKxCS0iRRBnBbPNLyWWAgar?=
 =?iso-8859-1?Q?5D5phoSJYrYdKyoMQ1hfiP/YLbecOaoiTp1D6h8U5Hvf+3LNxZo4kPjcpu?=
 =?iso-8859-1?Q?nGf2w7JoUVA2GKlEFpZ4IrNKj6ZEkPToFRkQaJ+togmapdOTRxsf5WUdzH?=
 =?iso-8859-1?Q?p4Ol0jXxC7w1bKj9Y/2sf3s3AZ+G1F5P6rtHbprUQYrJxaxzq+kl45M0xc?=
 =?iso-8859-1?Q?pT1E6jn3P+0/z1QBu3YYaWyqJibJqfXxGfZNJUEuT+uprQmN57O8rbF7VM?=
 =?iso-8859-1?Q?or4AtdugEGm2wwuwhMH4jhIEk6Zli3WxB22hi+JlNzLJg81dPrOSwGBlnN?=
 =?iso-8859-1?Q?WyxM358/ElQ9w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd305ae9-a6bb-48e6-6d43-08dcbbb97c22
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 17:00:50.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iUECwZcEgOguETpyJ+J64IDYW05Z1XVoJ2kQUizzZDoeq5EjJSTrwj4tc/Oj0J2uSRPIhr8iUdP2TszmADQmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8077

On Tue, Aug 13, 2024 at 10:31:23AM +0200, Alexander Stein wrote:
> Am Dienstag, 13. August 2024, 06:35:01 CEST schrieb Frank Li:
> > Remove undocument property big-endian in watchdog.
> > drivers/watchdog/imx2_wdt.c also never parser it.
> >
> > Fix below wanring:
> > arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: watchdog@2ad0000:
> > 	Unevaluated properties are not allowed ('big-endian' was unexpected)
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > index a3c57da63a01b..b84512bc4c881 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > @@ -430,7 +430,6 @@ wdog0: watchdog@2ad0000 {
> >  			reg = <0x0 0x2ad0000 0x0 0x10000>;
> >  			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(1)>;
> > -			big-endian;
>
> RM LS1012A Rev3 10/2020 lists WDOG1 (2ad_0000) as big-endian.

Thank you point this. I remember I run this last month, but not sure if
1012 platform. let me double check again.

Frank
>
> >  		};
> >
> >  		sai1: sai@2b50000 {
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > index c0e3e8fa1e794..5837f1b15dccb 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > @@ -776,7 +776,6 @@ wdog0: watchdog@2ad0000 {
> >  			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> >  					    QORIQ_CLK_PLL_DIV(1)>;
> > -			big-endian;
>
> RM LS1043A Rev6 07/2020 lists WDOG1 (2ad_0000) as big-endian.
>
> What about ls1021a? According to RM this is also big-endian.
> regmap_get_val_endian() parses this property and regmap is used
> by drivers/watchdog/imx2_wdt.c
>
> Best regards,
> Alexander
>
>
> >  		};
> >
> >  		edma0: dma-controller@2c00000 {
> >
> >
>
>
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>
>

