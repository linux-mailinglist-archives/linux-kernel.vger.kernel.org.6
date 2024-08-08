Return-Path: <linux-kernel+bounces-279561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB1894BEF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927BC285E33
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4A18E756;
	Thu,  8 Aug 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqo0o6uy"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013063.outbound.protection.outlook.com [52.101.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C118E04A;
	Thu,  8 Aug 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125460; cv=fail; b=tZkVcQ2Lsnm0nH0MKH7UXY1RSQTEOZjphdzfKt4bIzBz8Kac7dxy08ZetAgtdcfdf/8fdSRVRNvIZsBsK3H0EKpQPmPU2uxxhqaPC89XnPfUd5xhvWCsmyqGpdJ1jR3s1sNBWqWb0hJzO7h5OlREx+7PWbdYISzSSBjh4n2kgJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125460; c=relaxed/simple;
	bh=M3oQxtYbstu/L/DNa+3AfUCScSj+Vha/85hX4b+CWxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z6grmQxOBzJAo9v67AF3AlkbllRsQD728CMWqdJTuxpIYQWdTnUKD41VM+jqGYRzICJuCQZ7JvDt6/V00s/E/o8lSCqdfb0wwil2m+GdqrQH3sur+RQgKuedmz1QvvVWyFgw144UmncAFiadpB5mC0fqlPH8PazdOUIVRyfXRpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hqo0o6uy; arc=fail smtp.client-ip=52.101.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEZZY3XY6pmLvUT75nc3sb0hBdk4n/heEyLDS1SYNjXjbUyq1V037LJv/2G4IQ8MPmuLzwiZ5sqx+1kT5IV6asN0mG6v8zC6S8OcptcwqNsdMWjlrSFuhrFWPs00x1+rIIY7eSx9GyBp84IjW1t4rlTqYao3PO8Ms8+oMVv5Rkj2soBJn+bJjka/YFGM3xrIwMLaGevexDUni8AAyY5m6cYbPNHPX61ZwIvjjeuxnh7VmNrakACqI9mj8JBmWLOeA/ViODBXqaS4GI7+/nYM2iZNDq34hxgfUCu2AtID6zSpMJ0GNGEVk0hPCXbqQYeJhJ5WoOSVpDksaflhSHeBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx/rT/z8JTUGox05D3zzZI7HXXzgYiapX2ELtmeFHeA=;
 b=cec7cHHwLnVEt7otccr5y5yiHLaGu64+0QsRg7sryRon/Q5Zy4pX7/MU3CY0ACCSaQt1ZfUPTDFcxacnExG9ZG7oeRh161SMNrJZXHzeiKKkcWYXvFOIChPCxTbCVqFBhG1a/EyIVd0s423CekKOfOL/P1238VSyVNxIn9Wx+dhvfGG34i4QpeXgdOF7GoEGOnhaSKElYt3kQ0E8DCpI37yS4U9FmFBgW6fti152+rICYYh3tduHqMGS3S1Pp1I/XzZmKP8YXDiUCTwUtPoTuyhpXST1WpX/0pIgdxh9wWZ0LC7moBJVWzjYde3ATscrrH+QCcAa30d5ouQo2FVJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx/rT/z8JTUGox05D3zzZI7HXXzgYiapX2ELtmeFHeA=;
 b=hqo0o6uyiryZWZ3h8FLUpAam+ldw5//brh1AAe5CgV4qY0Lf1HI7KNkIl+pJdamm/cFnXGR0kIq1QXMZxg60C1r+iWZ48GRspy5UQEt3s4Fj9xRpk+59BF+XjMV7QtdDkBV9CcMEYaymp0ELk/+yuuZzOz9948aL122mKCvZrvpGx3Z7IIVfbMuYp1k1ftO9AMwpZBsuYW9QfolemTeNmVXt5X622BF/55GxPw47bVYqgkRWPO+A/BgAbAYoEsnxOEpkWcHWCbiasny6JsWS3HMkL66QHhQbO0MylUs4o6VGzoWCcqYoE2zlnORFsuq0usWnVTThe+0MKzEQ+Po6vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 13:57:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 13:57:35 +0000
Date: Thu, 8 Aug 2024 09:57:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 5/6] arm64: dts: imx8mp-venice-gw74xx-imx219: remove
 compatible in overlay file
Message-ID: <ZrTOxCe2heOuzlD+@lizhi-Precision-Tower-5810>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
 <20240807-fsl_dts_warning-v2-5-89e08c38831a@nxp.com>
 <PAXPR04MB8459249991934356CA4CDFEB88B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459249991934356CA4CDFEB88B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b46d63-3289-480a-6347-08dcb7b20e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ldxvvBOgFMUqhqzv0ZnEDvWWWILjjnp/vu9zyB66ndNhbtXHM9mbQMttMITR?=
 =?us-ascii?Q?nRD3A18FmZVFX9z36kGyFuqJsk5bS3vrK7K1yfW55UjyPyx+kEZ+CuqaQ5v6?=
 =?us-ascii?Q?5IFEYnuYJ+wRLiWl1zMdhzD1iy3MfUd1sQzROgqDhM/263/Yj9xk7ErnOjhz?=
 =?us-ascii?Q?hl5FnZ4Q365QHm3dDBL/nxE7SN2oAPwK2zudABPtsG3tfXfp3Kxduz5VIikN?=
 =?us-ascii?Q?KKpXkvca5YFGi49obH0TXO1ISgvWV+D4itJzXCGwNFVBaAuz0yhBe1dx+S7J?=
 =?us-ascii?Q?DHUuQgGDwmo3+r0g1EkEXaG8IccqGihIok+rpMY8OuKhRtEnP35AsLNYoqQo?=
 =?us-ascii?Q?DpXn2/c42YRmfgJxf7OvgCaZPcI+QRCqaiu8FeDZZoKhzEWlMJmME9fMqA/a?=
 =?us-ascii?Q?uoTarPgdygZeWvjE8UAPQ6cI6Fg6J/SEXQEFuDKmPJWfVG/LEUFnEY+ozcsl?=
 =?us-ascii?Q?11p8Ab2vdpVNWvTZTZk5yUpTv0m5LacTk7bPag24D7ai5aJFzIFTp3i0GB7I?=
 =?us-ascii?Q?4dsvuJgpOkscryVGowOKoqPqWz1gpR2UfGnh7jBL+I0a1dNs7Nn7n975uVbf?=
 =?us-ascii?Q?Dw/+boiyH3QhWbJMMHTTk1bDu0776nq+melm+++QFhpJS4TcLc2XqVWKl2iV?=
 =?us-ascii?Q?fOWFivq73rjsZloslLSF3hnW0uYKgOTul/qhidn10wVzN9MZ89vq/2EtK9Ha?=
 =?us-ascii?Q?xePrwHmMUNlMCK1e7oWVWhQuqp/jqmTfMMjPJGe8cI6lpU7hSf40Y4GVCO7w?=
 =?us-ascii?Q?GTcNSvz1LkNq3S//m+NZN5A84FHVdZVH5tTPM0t3cbiW2JGDLHRDNo14ukIB?=
 =?us-ascii?Q?X/JWu0D9lV9mRkZxz3Rlc1XjuN9gDWm73Nundf6xGDGDES8IifsJu9iugRPC?=
 =?us-ascii?Q?ecp6iUUP0awm+ZJ+KblTFctAH5GZ3HnQl3LcxTsYRKFo9bkpKP8+LQ4HJbYA?=
 =?us-ascii?Q?dN2PoZFVI+CL4AzdLf9zwIArRmJ6LfOh1on4WanGV5w/D6xVeuB8HI8y7MKu?=
 =?us-ascii?Q?4agWzyTil3Fd+0PaX2aJ6EwUZvBwghFWHKSFvhZnnK6qBlgIubZt58wubrJj?=
 =?us-ascii?Q?uKiVy99HkTK9zpGs/hKz2FZhA3bApH7JBpIE5ZsBkZiWinRK+N92EYotVr7/?=
 =?us-ascii?Q?8YjnpHSMOiwVByZlJTclRShpj5NXq3QDTlSicY9MoiftN8CnHQWBrP8R7rm+?=
 =?us-ascii?Q?AlUZu1hGHdEdq5spbu6rZY1zgwPBbez9hRyC2H7ArXFY176NIQ6UI1SxYl+v?=
 =?us-ascii?Q?bkwxiuLoNfghNr07iLUlhY+tDcxG/lpG2ByaUC87I+e+btH7vhm5EERhYzEl?=
 =?us-ascii?Q?CMtWYOHMvNXnOjphZwpEffhFAM3FQ126+7sqv3PsiFwZuRJ5kBKCrfrcBtYj?=
 =?us-ascii?Q?VftalLmAUMK/yTTdL9EaJ30mSLq8ogh+R7k/P6R3HYROVVQCIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QA0Vh2uU2yntk/0VpkywtH9cGdfp6Hk/9QSS7ZbIV4CbiQspKzTIXV3vzrFD?=
 =?us-ascii?Q?O3nkOwVvvGV5ZXLvImtvYUev2Tuf9TNtTaYwN1hrIc5ScerICwBMKGxSJb+V?=
 =?us-ascii?Q?/Nk9LaTKIs/0+fRtXGSGcC33NNlQVozDPFuhb+AHetqygrQeu8ZadmVRIDfs?=
 =?us-ascii?Q?dWN/akYGgPlzhtfwkg9ekAsVBZDYktT1tZZZe3AWKB1YQ7XVWxY1cieUAUYZ?=
 =?us-ascii?Q?yF9E849+E1Mam5B4ww2IzoGNxPeziL77xamVPpMKu78VtxZQxxsKf+7dB+yI?=
 =?us-ascii?Q?nW6NBGAtyLldq7dM681GXB1c4ugdv4joXDDYbiHywH6r/PCB7txDUbqy1eMc?=
 =?us-ascii?Q?/TtJuEAO4sYT9mpufyQTvYTjaSxRN1ZYcRybgKJn9f3SnWnWaN1y4tEFscVe?=
 =?us-ascii?Q?bM6Lvhx+SJVD5/sXlpJXjz/vO00adCDN1NMQpO9ym1/yfLKWD0EEkYJADkOK?=
 =?us-ascii?Q?pG6qaNwMngeWYvAyLC4Um5q/Ltqtljgrj+3RO9X9AeXxuOTLJ+gbCrV7GCWv?=
 =?us-ascii?Q?zyHLGwgzs+JX0AG4VboLKeLfyuKzvrOFrRoqRFDUrHEd6Td8CTdE3jcx5aFc?=
 =?us-ascii?Q?6kgY8U3EcQJF2VHYtGUj2XOIElJWHnFfCHSPst2FtjhFou6YwrjN+Q722LO2?=
 =?us-ascii?Q?tL7a2Im/8LSZDuw5QDzCeYMIZlAQWIiPvGZ7mdDOSdUSQbunsLulUgAKDLKJ?=
 =?us-ascii?Q?ZeXTXrcLEQd8yC+7Epm8G517bb7tY4a33LWkQRSMMm2cd3KsWLMAVD5xWZXH?=
 =?us-ascii?Q?NSeN+Ht4glQndJ7vmd1yv25b0tV/JBtZCubEakJ/RnakpcXyFax5WGq2DVeg?=
 =?us-ascii?Q?Q0zgQSuEWPbo8eC7rw7YMojIONcJKE+iSrlGf+biNSGxrCjhLj0yLCbQdn9R?=
 =?us-ascii?Q?F0zCEjIyqYPUPEtWa46bSVks1pmcW8UcgmnIkIQn7U5R1r+QmH/CCKE7dZX3?=
 =?us-ascii?Q?39rYN2fUy4Rimrjq0LOQjPrTLXRkAq3X3FgGM08gLhrNCKjij5GWHHaqZ5aC?=
 =?us-ascii?Q?/muPVN8ueBtxthOtJfvxr1L2nCOg1kovCN38U0VgUVKqmihX+ld404B1F3EO?=
 =?us-ascii?Q?vejLBAxamedBbW0XBqHeV31FV5h3iBPaT/PGWMpqsbaJNDABLmJwUBNHVBr5?=
 =?us-ascii?Q?8CrZ4f/fRskgxed0Qg44PkbVFHThGTIanLDL8deQljA+DGDl8PzjjM/NPEKE?=
 =?us-ascii?Q?ZJS2aW48M06HUESRCu5fRNuU8hSQ4gxl68rkpbiRJ0t9e61gaaFnDuXsnptb?=
 =?us-ascii?Q?MDSx1d+9tfhTjKhI9V+khXNQOuY1qtN2xOLftnhDU8P/0bzApiHYQhBz00iu?=
 =?us-ascii?Q?XjKNtsBjKg//ljOY0MMHbBuGLNErkIYvvW/odM4rDeZtU9UiuqeSsBItf4ke?=
 =?us-ascii?Q?neot88YJJsT+RpKxUNUWyeXvGHx+yVQzIn/YuTvg2vu6pW3VnmrDZ7J8DWpd?=
 =?us-ascii?Q?owmkAO7mqQQGNudEG74EysNF1naeKK+pil6aQRcR5CKObhGR+t148Bgp7Ki2?=
 =?us-ascii?Q?pOT0TyWw88gEzJUIgNDHyTMvKtBroJhkljVyWxNSFQL4hBlpqRYN1SrVwjLL?=
 =?us-ascii?Q?HMb9PwETaHvw71wopAY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b46d63-3289-480a-6347-08dcb7b20e17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 13:57:34.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h03gYLogKU/r2QDj9bOt5R4A7yIrK8Cb/gnL+8bw+UbAbp77GKKXPCfLchX5CwzYaEY1A7VA4tla9mvMJJJ0AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499

On Thu, Aug 08, 2024 at 02:39:19AM +0000, Peng Fan wrote:
> > Subject: [PATCH v2 5/6] arm64: dts: imx8mp-venice-gw74xx-imx219:
> > remove compatible in overlay file
> >
> > Remove compatible string in overlay file to fix below warning:
> > gw,imx8mp-gw74xx' is not one of ['fsl,ls1043a-rdb', 'fsl,ls1043a-qds']
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - remove compatible string totally
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso |
> > 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-
> > imx219.dtso b/arch/arm64/boot/dts/freescale/imx8mp-venice-
> > gw74xx-imx219.dtso
> > index edf22ff549a47..eb673a947484a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-
> > imx219.dtso
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-
> > imx219.dtso
> > @@ -11,8 +11,6 @@
> >  /plugin/;
> >
> >  &{/} {
> > -	compatible = "gw,imx8mp-gw74xx", "fsl,imx8mp";
>
>
> This machine string should be added to device tree, but not just delete.

This overlay file, this compatible string should already in major dts file.

Frank

>
> Regards,
> Peng.
>
> > -
> >  	reg_cam: regulator-cam {
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&pinctrl_reg_cam>;
> >
> > --
> > 2.34.1
> >
>

