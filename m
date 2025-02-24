Return-Path: <linux-kernel+bounces-529967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710FA42D13
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FE13A81B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D820765F;
	Mon, 24 Feb 2025 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQk8jn0g"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969520550F;
	Mon, 24 Feb 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426712; cv=fail; b=OMhF3kduZiv5EtbAAqRMI/qzSv+qzQkgPglMtYaILvPzrYl58zQR0kPc/dseVkYTjbjG6Zf1iF7i2TsWFLV+Opu3NlXfcP6sbAsWMsAERnWGtpNqxi5LuXODACc/SXFyTFmzTwbvi/b8S34wLTxTXh79ozy7/+1dIFlou2SkVq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426712; c=relaxed/simple;
	bh=zHcW/l1obYWrIyyAY4LQnZc7zOgW9/gRCrPMWL+lFw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nqtcRrzMlnpzGqCS5c6u26fX2zbXSyEBEEF0qH64D6ld8Jjp2P2mN/NH1Vh6TPs10EsUKU1YoCU3Fo2vSj2lcWV8cPjiXb2lnMw3hVDYWyKIie2ExfZJTgh5dn2tia8IJPxtoAq/Ot+M+Fj8No2VALGRLzHQZoOVreRosgv0lFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bQk8jn0g; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAnGJjIwdXoL9s57RF6jx8JL81XKwCrehIlnDvvVQtv5+4sYRwABpNexGUpSz6C/OX+1oRS/m6iRJ5v6Z3WhwGgzJdvNxPb7wUzOgWvwaaucqWLG2lR+4DAhD4aPzWy8X9myzi/9U5MZ6XGu7As2qtJEH97loDyrD2rjm4KzxAg3M+bg7KUPtzpjRc7E+gzg29jHgK1QOrWYIK+IE8dSTShzWGhCZA1TFy4eC3wgckG6aZSc/brdIxEgldtTtoiht2lU83JKFwax9JCn/6Mcvua5BuHu0tCWrQav0d8y69lg/o9tv8Op7WYNfBd2Ptr4LaTVr4DjwgZm9kIzHokNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txWpIhHIPTiPy1KE/Yga9qd2isT5p5xWtJOv6nRNVpw=;
 b=u+z5tPL9qpxFaaJwRUzraV+Rg8ktrFQt9Kgj78Oi81pv9E8hP4gl62ZfyW7MCJc/RiEJXFI8j0QsgZ/Y1lauZOnHruExIZEZdTVnHg7sdmA2VZUyZxwbKTmA7ICIA1H3wssyukUBn0qB/dCW09myVir7mY0EYww7M2QhszWcClSfIo59lwWAEFlR3x+OxcKfT0aqLbPppLFOsU2xrZ+3RIGDHQl5Fu13mvqhRQMYaEjOFpmy4DIqRbLB2UJA7uCmM5kj4a12frhepyYXcdOD580/uUl9jeykOmg0DSfGDd5cOKWwTyEeP5IdNQFEn9KT8lfS7njlAhMxIO8WUOti8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txWpIhHIPTiPy1KE/Yga9qd2isT5p5xWtJOv6nRNVpw=;
 b=bQk8jn0gEGEEzejGGra4OYvoimJri/EOASXyEBoAQet4C9PULZolohwbLM8At2OyPFIKi+1WXwWmPsLYZNECc9FKT6/oLOS/ds9BRmL5bqcI4ED5yNhh67siNBCF2ZYTtRPuKsBAr1HVNjtx7WCYLiuVXrrbxh0PARsoEHncZFvboI+6CLAwUjAYmJzIfVf9/oBlOr++senuyB4+4EJv+rke/QzAr9tyf7r/ZYawd63k+Qdi8GeKRxVpqnlO9FK++TurBpC9KCUjS+C2tkUdMW8tzC1Gaw7upo7PzYIiv12eRwVoXbJW8rov5RbRx1felX6cSLukJUz/yvWOgMWzoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7401.eurprd04.prod.outlook.com (2603:10a6:102:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 19:51:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:51:46 +0000
Date: Mon, 24 Feb 2025 14:51:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx: add imx95 dts for sof
Message-ID: <Z7zNymSs5qeHp9wL@lizhi-Precision-Tower-5810>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-4-laurentiumihalcea111@gmail.com>
 <Z6vcBvs4xGQ+pGCJ@lizhi-Precision-Tower-5810>
 <36ca7549-aee7-4f14-9311-77978a42362a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36ca7549-aee7-4f14-9311-77978a42362a@gmail.com>
X-ClientProxiedBy: BYAPR01CA0064.prod.exchangelabs.com (2603:10b6:a03:94::41)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e1e3e0-5006-429b-0403-08dd550cabcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1Nrjo7G/yPKF1dpb1uTlWkmyVW7WMrL8ES4FqgDbSEDpbQa+0Yv55Bm5SAw?=
 =?us-ascii?Q?VyC6kAUNBhvuMn4q3Rl9HrDc+Vs6WoQj+pcxaxdyAzd3gxXydi4QBuf4jvTA?=
 =?us-ascii?Q?0bZCRfBTK5yY5xqLBLD38G68KhMZkWMvLPZLhOSYOOdZOksoRkzBLH5AQ7B9?=
 =?us-ascii?Q?EypstEihYR+veNFZLvGHzXhSBxx2gXrUnmgVnOiNKyLoNIx7acAgAwr55OiU?=
 =?us-ascii?Q?8DQKGPbkh2zjezTvvnCozMjaLYF30NNAougEnGVr3pPtNN2qFZFCbeCOzQZB?=
 =?us-ascii?Q?kk1w4J84tBYxvbYG6DBP3DfNDsJoF/xoEQQgNXpvu/vBp81uGeuXvoo30Vml?=
 =?us-ascii?Q?fQYCXOrdn6YOsID4YYBM9UrSowL919LMZD243+Hc3hyyp7RKZVF/ZCTDYPMB?=
 =?us-ascii?Q?sE5fP0ffYdyRxggQoBLjT0ogefltACYORG6zVeH5baRoYEnwxTLMohCn9MHT?=
 =?us-ascii?Q?9rrboQ9B9PmlMtLOQfIESQuPHqnbFtxML2MLsJK1Ay+TREi7y7yyTGqYCjJv?=
 =?us-ascii?Q?pweqKeCt9N4p1vVDJjX3M1zu4/o2BusLKRdCaOzskr0sninFUmRv0b/oiE1D?=
 =?us-ascii?Q?+nVg9vrAfKNrnQDhJLX7iDoI/tsXkZE6Xc5HIlo9XQjlVUVwaSF7INbqLZXG?=
 =?us-ascii?Q?BOs119wj78JoA51D6bl2+/qIu9sIweyFiv8AmhpD9QVHKplM9+7iZ0q52hfc?=
 =?us-ascii?Q?WKUBFOoiUjws1FuLanRpDbDj4Q62x17t1dpRa6nliDCrpWpa25SpD48MFmDj?=
 =?us-ascii?Q?RzZuSjGYH0+ch3wdqZ1yNzr5oZwElrMxzqu+3XwMsUled8pIM6sUiwppZ/9S?=
 =?us-ascii?Q?WNL0WJ3nddZl3g0xD4T2WgrK6L1/814dT1pP1+VJolbBXZgfVKTn/bX6c4SW?=
 =?us-ascii?Q?/92G+0Qtv4UzKlKi+hheFYiDDX2VCV+mhKY7E8JMQ/EoRBWZPY0hCXXSooqF?=
 =?us-ascii?Q?ZT2maJVXqK0TslInXGDrm0imZ6LBiYY7oonOgBc/bFP26ZWRvAFS0f/CfgGh?=
 =?us-ascii?Q?6iuPpkTMHqU6Et8RYZ5muOzGCrec/tfzKaiUnEoSJzlK8+g0KVu1XeOo2kv6?=
 =?us-ascii?Q?P+VDmGgs9cEzrh6GFvzVS4v+Ukh/BOe5b2MpQ9Y3VlsfXF2Sr0TI6+PIazNK?=
 =?us-ascii?Q?rBq+HDzqMxQDYW/UeiCKGK6WTkLYT+GkQJGfRNh+86q8Esr8WEO+yatkKarg?=
 =?us-ascii?Q?weA6ht2OFRaA/8LQmT+2rDbRLVf6Jp7FDGvyAw41FPhl6rAfjI1j87zGyqoF?=
 =?us-ascii?Q?8jnhEMQxM7bWiJu9B08eOOyTbZ8b4s75VnLgrkGVgSSAheLfS7wzHv3A820i?=
 =?us-ascii?Q?y09nt4viIxVFjCJP4KEWMAn1o0VOM4Fl379XrocKULmcEnO/ink8hxXbFF62?=
 =?us-ascii?Q?42SoMC/RXvYB38mC7Q1Ui/oj0FasfChvuRXvcayNL6++maFhzmw1wbmfQMiU?=
 =?us-ascii?Q?IR/CYwwgiWf/BBFB2JicXUMruMJmzBAE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YZrbQUfGHlVoqoAot6xNMlbtRjgTIB3Nlnf9B93yTCYq2ZiShiHCDoCYCaFh?=
 =?us-ascii?Q?ukBFD9F7v1ydyw8yV9hSHe9UsNkAjTXnCMgg1d8z76vyPXP7qPoMNKTZLpmu?=
 =?us-ascii?Q?TPG+JyA+lH22seUc185ptzKgHm8x8oTEEUGAMleM2fRmrYNbEPo8FTMiIJhJ?=
 =?us-ascii?Q?60Jvw7J5gODghJWM/xRoPCA3PSHnh0FYVR9MpwXhavApAYgAoww/3NRNWK7V?=
 =?us-ascii?Q?PNStYj0CAmKQ634rBIYarXI7Y8sFjxE1hBI1Mfg7wPt8uBUk6qUJ0FRXREfl?=
 =?us-ascii?Q?rDy5EqgZBtQmL2P3+2TiAanltfTee59FA+xPGTxRNjLnz1xm9M5mZjnmnhT7?=
 =?us-ascii?Q?5mY1f8HaOtr8e3fFmYXmU4Vlm+AeUpk7steE6eEK993KZF73v0XpnqJbbm7t?=
 =?us-ascii?Q?HqQmpaBF5wjJq7bkngk5d77tG0ENO5MBXg3ELZqMgHuSujZURFjzQaD1cCAb?=
 =?us-ascii?Q?m7nMvlRsQ4RvEUdMUbotcN37MK8lQMLdvZC59pRxgnEG6pUT8KQDY3qomZjD?=
 =?us-ascii?Q?0676nEFI8rkbnV03WCKxULV8SyD6WAeiO6hnLpUnWMh1x1/0D+1a687aC2jl?=
 =?us-ascii?Q?yJ2DGg4sY4Rdn1AH4j5vzN/rOOLXcnbIJ/BsBVRyxIpS6tHKqH5EzlSJIsRm?=
 =?us-ascii?Q?U0l3MRr/Cj7NTUlHonc1PUPMfNpwwmK9eI9OP1RBbIWvSXsHKgskOnZZGw1Y?=
 =?us-ascii?Q?lUDZgv3JQbvwvwzR1OI/XEOUosieccUg6PIBjHu04uBuMOJ9iB0nkvlmoXTL?=
 =?us-ascii?Q?H6Z6zfLVSSuliu1KrSfuPbyJ3E3a9+tglv2kDK++lUc7nGWh1oObIs2u2lb3?=
 =?us-ascii?Q?Q8Q47B3oRQ12oAodi0zIFXDzUDsg84A91O7YuvQtlgURnF7LL3MPRo4Iq8a8?=
 =?us-ascii?Q?eyGVCw2WfeipX4sicYMKjW7IYH2aifdP4A50dzFCMGiu+f+lWaiXH1NUfBvX?=
 =?us-ascii?Q?kyijhPSbU4Npv60kCE62pfc9r3Cq/WzdZDL0a7rdfNPFtoaAuXdAsYrXERuB?=
 =?us-ascii?Q?eHRKTPR1SL3zrra0RA/DOkkWn+ONKoZdt8d6gmLPqqxy1QKmvMCWqI6mxMas?=
 =?us-ascii?Q?SnuAvAS2rXqF1+9O9+lH6d/iNHXL1JacQZwdYEs0kCSa8t32M4JO87WD9F6y?=
 =?us-ascii?Q?8CWtp36/3N5eArtMY2uxBbuY3gNFixAtxvHs2+F9mD6jjjUkxd002KAE5mtE?=
 =?us-ascii?Q?CPya0cxpBnaCW1WWiN3cVCODU2oDKvV4S+bS+efCPODD4bVgPYKpOnYRkr9e?=
 =?us-ascii?Q?ln/Ri9Wcz4hPEeO2Adnzl/hxt/HkUi2UnuXvpkM0J/0XYOoyBAE2YYmiNxKE?=
 =?us-ascii?Q?OIsw1TxVyz8/IzRe/mzzlDs733azmwlmUtLxfjm+bJC1O60iHlsrfGIccOV5?=
 =?us-ascii?Q?axn42SZiVJY7ONtZMXVpLkzv1Uhh2oGjaFhZKzwJ6AUfDbcOvwS/yOVFOs7N?=
 =?us-ascii?Q?HzcW84JiAaLgVX+9q8Qrh8jEm6XpuDMWF6j3Bq/zQyFG9ysfh+wr2kbJb5jS?=
 =?us-ascii?Q?XaBVRbB9gJ9qUL/slzooWb6xMX93Scuc1wOsUVbC6SFIqI7taSOY16j8P+gH?=
 =?us-ascii?Q?CeA/z+ein090Hbk0CvvorjxrL9hJxihZzx7TFR8U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e1e3e0-5006-429b-0403-08dd550cabcd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 19:51:46.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eDuqNmb51jIrOkT/7IScH+qbX33K8jgiNqExZfyNTtFlL7lzktp9R5SXJ7yQyVw36Gh1ful7Z0aTytNICwU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7401

On Mon, Feb 24, 2025 at 09:17:03PM +0200, Mihalcea Laurentiu wrote:
>
> On 12.02.2025 01:23, Frank Li wrote:
> > On Tue, Feb 11, 2025 at 05:58:08PM -0500, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> Add imx95 DTS for SOF usage.
> >>
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> >>  .../dts/freescale/imx95-19x19-evk-sof.dts     | 85 +++++++++++++++++++
> >>  2 files changed, 86 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> >> index 839432153cc7..27f64e333e4b 100644
> >> --- a/arch/arm64/boot/dts/freescale/Makefile
> >> +++ b/arch/arm64/boot/dts/freescale/Makefile
> >> @@ -282,6 +282,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
> >>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
> >>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
> >>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
> >> +dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
> > look like should use dt overlay ?
>
>
> can you pls explain why you'd see this as an overlay?

It is addtional option, which base on imx95-19x19-evk.dtb. Default wm8962
is used for built-in dai, this provide option to move it dsp.

Ideally this option should work for all boards, which use wm8962.

We try to move MxN problem to M + N. otherwise, there are huge numbers of
dtb files.

Frank

>
> (snip)
>
> >> +
> >> +	sof-sound-wm8962 {
> >> +		compatible = "audio-graph-card2";
> >> +		links = <&cpu>;
> >> +		label = "wm8962-audio";
> >> +		hp-det-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&pinctrl_hp>;
> >> +		widgets =
> >> +			"Headphone", "Headphones",
> >> +			"Microphone", "Headset Mic";
> > Generally, align to  =
> > 	widgets = "Headphone", "Headphones",
> > 		  "Microphone", "Headset Mic";
>
>
> sure
>
>
> >> +		routing =
> >> +			"Headphones", "HPOUTL",
> >> +			"Headphones", "HPOUTR",
> >> +			"Headset Mic", "MICBIAS",
> >> +			"IN3R", "Headset Mic",
> >> +			"IN1R", "Headset Mic";
> >> +	};
> >> +
> >> +	sound-wm8962 {
> >> +		status = "disabled";
> >> +	};
> >> +
> >> +};
> >> +
> >> +&edma2 {
> >> +	dma-channel-mask = <0xc0000000>, <0x0>;
> >> +};
> > Not sure why need mask edma2's some channel, can you add comments for it
> >
> > Frank
>
>
> sure, can add comment in commit msg
>

