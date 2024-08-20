Return-Path: <linux-kernel+bounces-294161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7758958A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5238B1F216FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7F1922D4;
	Tue, 20 Aug 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VCahOw/i"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FA18E37F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165366; cv=fail; b=HF1Gteo0MI4hz6xyL5B88KZP4rks6Fj1DeffOmhtMIVc2xT58wPHBcRqmDN9/pHpyqS/vXBYE+qFoozPs69jFq44kBTVwL/agW348e7xPDhB7AbroeTnSLy6Ble+MeZdA3xpWn1icgJKP4rrSrSucq7EQh1gXGEYgAXuXSKbd/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165366; c=relaxed/simple;
	bh=GjAnNYw5fj/jEWfisLUtPQQNwEtXVD80tuWl0cB2I5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OAp5/Q6hyYk5yKVGqm+9yikOrpNvXxzQnYqm4HMRZKFw12zQdyV+zYaTV0ITrcDeMral94BoSHcFc8zAZh1I9i6Ye0nS5VzrLhdiRnBinDRTawXcbhsW+IvGctmhLek82Zp702o3fz7VY5vXgJQMszjNMAfxR/G5dhYKarBuX8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VCahOw/i; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yp+lQ33gfZqwnknHR7L9k/Hi82nGjlcxeBuGm5G6EM9QEC5yRjG6HW5Qjv4s7AmLHsVyZeiyl3Yau7L+xR4a2l5vd+ZSiIfVrDLLHhzHJAbxiOsb/R4n/+MeZx4yIXe+tof0Nx7pr6pimS+DkN1rZqwHoeDWJjUIzUElOIjxhMCbfKxxx43IDLP8HnEFm9zazgTwBY7tuRYjG7dDCc1/xFvWMaVTL5heEJJAVKquIzDJjit1oPRAMkR6eH9Iu1vgBLPPOpDiceZlgwDGeGfc8+iiOO+gBz0cbkJf0wnZSFKIitWZV/WgwhSA94RKt2OL6sRDXe6Mujq4daV34ymBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AppruFVeDfXSEQdWcKgDdD7WONQpROMHKSyJh5FcqeE=;
 b=phz6OlEbGD8MReuWVWLeprwS5gkvauRfQDXYQtuUxFfaPRN0h+0S1h8rwS49BMlpXNFHWwswIDNPlmf/Ex+8FP2dUX/xU7ayqRJxVszH+nhWwEBqcSGl2s/AQpiMi55THA22dpxHBb/oGrJPKEdSnuLxHujVSTGP97jryeW5F+D0khBFD1X8qLPbpd+zIlWrnZKbfcPjEM1PkZlqyS2cz1yyuLizB4pN01fg9/HFxsXfsMRBaqEvTQXSYcbDGwKxHH6kf5YJ1CtLsa6nS/7GnpmUCDu3B1p0YYJhLnu7DDkK42DB9fAVEv/7zqINfCrzXq0hAuNEFou1m58XxA3iAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AppruFVeDfXSEQdWcKgDdD7WONQpROMHKSyJh5FcqeE=;
 b=VCahOw/ifgLx00AgMmUP7XeOXGeIBs89D+bZ4zTWitD4H9mIgvmLbnQTErvA3vut6qj77B6znEvOrCok0bp/0uwLoK72pXqGnziYB+RgMm0+d0DntR+jy7BUExjLE4uxx/AGVV3LDxso3RGpoyl4fHGyuS3L2dRNmsVdGs9dOj2xnK3Jte/h5t3BIzVyGyoTiy4gIgbZgupAcJQTpzbR9jhb1G0qxm2jGJ121VlZwfUb+/jQKziRK+P3Vyjh6fReHwLKbQ5dEMZH4hIxK2zqBCsojlPZ1ONq7QxTkrrvKLAjh5WBsx1KkpKxRhLBm1Azfc+IP7YedBoQR1Z8ej3oXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 14:49:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:49:20 +0000
Date: Tue, 20 Aug 2024 10:49:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: nxf24178 <ravindra.yashvant.shinde@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	"moderated list:I3C SUBSYSTEM" <linux-i3c@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH] i3c: master: Avoid sending DISEC command with old device
 address.
Message-ID: <ZsSs6W8ds67NZqRL@lizhi-Precision-Tower-5810>
References: <20240820043818.3352614-1-ravindra.yashvant.shinde@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820043818.3352614-1-ravindra.yashvant.shinde@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9298:EE_
X-MS-Office365-Filtering-Correlation-Id: f803db1c-6bfe-4052-37df-08dcc12745ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hi8UFKXQNJXKAdVLb9vvWp3sSwzd4vk9Vm1VWe8VWl8+flCeLKZuiVSc171/?=
 =?us-ascii?Q?zrpf9C6d3Bs5z4FLZDt19kvyhEEKsEqP5GA4Bjqb5I52sflHpcNx+x5rP1aD?=
 =?us-ascii?Q?e6LlmUQ5dEEDbVEuvPPfMZNSTR71r9YEXPK+w1OnN9+AAPoSEC2nu4d9pB8S?=
 =?us-ascii?Q?ygVO6A6yrRn9RuuyNbk7kvClRi5dSIm/7ITkMbhH4zRdvR+McB+Sq/fo3hWT?=
 =?us-ascii?Q?x+9LJNZX1/8VcC9ZDOTRCAzC3hq2fc1YaZTC6J1k89z5EIWr2PzUPDJy6mw0?=
 =?us-ascii?Q?iXUsW2NOrltosFvuGUeRFsbQriiRvAdENRU65Rfgyw7R0YTgDHEilPpnHTHd?=
 =?us-ascii?Q?nAyxhC8o/KFhGCBCGF0bl0d9eEXIpqQ90kg+w4mKU+lf7eUFQK2GrvKSwaXQ?=
 =?us-ascii?Q?aRN8LvFg8uRtlAi87wtZRI0lAzuQtZ3R07VmLtm6YshZAQxgOcGvIvrsdNYi?=
 =?us-ascii?Q?B2UNG62rb/2t3SQIFSwFIAKgso3iscEo2k1UzipwYG5GpDCO2fjQYtprTQlQ?=
 =?us-ascii?Q?3BGDNXB66A38fbo73xCiIUN+D1AgiAjIip1Px7ypXoLXtCaNJq/YmpWKX3uw?=
 =?us-ascii?Q?tBUniEpporq0nZPZOVBSgE/N+GeD+IEd6Ze51HP7RaSNnE2LBdr+X3a2D6qz?=
 =?us-ascii?Q?tX04gaZNNVLYON9ZjE/S0xe+2MMhiAuEWkrsHzRmA7UEl6s8IByhCJin3tS0?=
 =?us-ascii?Q?S0jm3NXx8smgvhoeVpukhySsIB3aWLwhC+UK5O47wQBcdhAwGigSvJdjGb17?=
 =?us-ascii?Q?M5HJF/pbJ0arnbV1L5Pfhjp4dMqJ0sp9JdC/C5QMatC86GBLuxu4AtH/fQUA?=
 =?us-ascii?Q?qOGHkvibeI78k6n9dUq73P5S//v0Ckkd4KQtvl5ZUJA2XvUUN4EG70ebp3Yl?=
 =?us-ascii?Q?Wy1MBQMgclgwZi3aRwNgn4Ua16Mbs4TklkGro15TCPrqxxv4Zm1p/ICcYqHO?=
 =?us-ascii?Q?DmiojKI6mqrR+XVBpDgk4lhoA1fNKQ3nyaEdj0J+NCIHT8HOLADlET/0imR2?=
 =?us-ascii?Q?25vwOGVkhyRyeBCQVAZZZ+za+6RRcyJgtrELbMNBKfMtH+z7HzBnAM3pXbhG?=
 =?us-ascii?Q?wCWRIb8q1NAYycaXUBeW61rrT8S2V60E4UtJzlE8QS6USS9p9nZG6k48xAJ6?=
 =?us-ascii?Q?a4ULOk978LtYISWZxSNt9UmI42xQTreCBgSiHqO8j2j0DKuq3Ccml44q1HGO?=
 =?us-ascii?Q?5mnOu/6vt5cfarok8CsROUHfdCmkUTEpOWtaV5+jFXAEgnZu47Tj226yHfWT?=
 =?us-ascii?Q?iGISI6CVLGm3xZ1Vf09z6JehmLXclIZSvoDfKRWrPRraXBtgLyET4TvDUYg9?=
 =?us-ascii?Q?pmaDqIv24YLvlGACpbQUQLOybDihKgPRScoEgSSE/AC/ZNAxm5deuWqYEPoC?=
 =?us-ascii?Q?7xNvVtEFUpSitV1rd5vncQQw+CnzQSNHrodNAcih/jmuD7qsIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AEA6o1p+9ZXo3f3SwLLJRAno5SbSkU8JoNx/csE8mfzXnjMH0rNKfs1Hxu9e?=
 =?us-ascii?Q?+B0OYicVqF22l1ejpFwd3uPKfdAMqEMYVKYT+ObFOGsV6ZOrS1SjPSR7an+H?=
 =?us-ascii?Q?IBhm0d9u1vQsE1BmwriUabtMNpCn67R2up4QMZdgMIU2zU71QHFhv+ZstcUB?=
 =?us-ascii?Q?oZ7kTY1xkZ1gfZDTCSim2kY7zHlxuDnen831lVIxHPEdAqJ8NhmQ43aERYSc?=
 =?us-ascii?Q?Qpiot1WxM7KOyJWTs+02+PdFAGR/3VUumLfFtRuqet0SmLOwAi+hX4eJ486e?=
 =?us-ascii?Q?no9uRSe+kTNn1zKcV+BMF9wGBiLCAcA3FOuKwkpWLg2c8iUv7Nwa4KmrC9iK?=
 =?us-ascii?Q?CfSjUiaXLT2J7OrgcIGpcLhDc0qpjzJBdcf/m9g4YJAuNfXGMsOle6Kzz4ox?=
 =?us-ascii?Q?Ep+syU/5pG8Mv/98zUQkp/wOT+5mgPNtlqRPIII/4j1mM4H5wpWpgrz71jQ1?=
 =?us-ascii?Q?IOecyBgcYaGdrgZHCIWvaC/zb7OOlVPvCB4Ycu3ciJokKhr1/ukMFFu+3zGN?=
 =?us-ascii?Q?dBDScUAnulkIXL20R1QrfEiSc6vsaieUjA3UEnUnHw/dAl/cKQVHL7velB0a?=
 =?us-ascii?Q?cYPxnpfsPUIEhXXHnuyhbsoe1RdVF3jNDp7UAxhRHhgD8U5HRJdgItu+PHV0?=
 =?us-ascii?Q?FfeD9BshEWFh+PXRXymkwXc/iXBeSIGb5VKOJ4QwGxtgpjXPeNbK62lBkXNU?=
 =?us-ascii?Q?bqcxBBSiEuThEt1ivUnkvSSclAdihbxFakTiYF3rwQAGyMhUYq0n+2fbE9NA?=
 =?us-ascii?Q?wmk/OQd+nv1sD12+lFg+iRZKsqQW+9gig9TTk4iB2jVb95e3AdIbCewKqelG?=
 =?us-ascii?Q?+oPHWWwiOvWQhWzM1Qu69rF32Mjqd3wWmOPD4sQ+aOj4E+dW3GW9KTYCXUvu?=
 =?us-ascii?Q?Sci74qs8/VOTnJJy0NIuU+6HrvuOHP7JtgvHY/7cjyDu5f8IP3TswAuueUWx?=
 =?us-ascii?Q?jKlXfdw8HB6Ahv25A84J2VmRf8bhqgnCa6x9Z2C4/5OXs7SeXs4g1HlsqUnp?=
 =?us-ascii?Q?MO5tM3+0CkaGcY0SpbOy45ZqU+keFpXLEBiyHj1trZqbcPCj5XzVXUaaKJYU?=
 =?us-ascii?Q?r8BnPIC66ala7IZIfq5oe+rr8oUe89DjRwtzkhE6T+fNPeTDiQubwbIMDO1e?=
 =?us-ascii?Q?sU8rX0KfG6ZMPpDYCbdDvMOL5rE1ibSU5rtXk3wt03IWSKWZasLUkI6XDu+g?=
 =?us-ascii?Q?sYoLO38zLGIVLNr8xD8kn2LSyKJ5kEITn1ELYIJFbm4+6eL5OIvNs5DShHp4?=
 =?us-ascii?Q?/e51YUlr2DD8lbucCUcZ9QmKwYuMGJqtQSCfy39oNl8883dRwgjgEaygh6Y3?=
 =?us-ascii?Q?XYqdKdtHoNKGvudQ+eIRS++9gRcCmnpZjIRHPZ5aL9htxKI9GJp1HVra6wqo?=
 =?us-ascii?Q?YpAhUETmVZlaowAeZNd+WyjiNqW35ZH081KvnqBs/CfE/U3IZ/95CSkUPZKw?=
 =?us-ascii?Q?C6dlCvAk8guoaSwUo++cMJHE4kyZ5odyUPk/PBrujP4X8amaisHIBMhDL5bb?=
 =?us-ascii?Q?LSvJIfx6uz9p8WvqsTk1TOL8phvxFDQf+SAvZG6ywlM40QiU+1OG2Lp7+qR2?=
 =?us-ascii?Q?uF0sm4qWwt7RQmFTchsZOYIJwy2Xu3zES9YWDQC/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f803db1c-6bfe-4052-37df-08dcc12745ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:49:20.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwRqh33GbaXbbpvywcl0iRNHHtb2gfXUnRW9aB4sFr3o72PttBCkPV+cBb4Fs18PA/zRPrCav2NaIQUZ1UG5vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298

On Tue, Aug 20, 2024 at 10:08:17AM +0530, nxf24178 wrote:

Avoid use nxp nxf24178 as your name, please update it with your real name.

> When a new device hotjoins, a new dynamic address is assigned.
> i3c_master_add_i3c_dev_locked() identifies that the device was previously
> attached to the bus and locates the olddev.
>
> i3c_master_add_i3c_dev_locked()
> {
>     ...
>     olddev = i3c_master_search_i3c_dev_duplicate(newdev);
>     ...
>     if (olddev) {
>         enable_ibi = true;
>         ...
>     }
>     i3c_dev_free_ibi_locked(olddev);
>     ^^^^^^^^
>     This function internally calls i3c_dev_disable_ibi_locked(addr)
>     function causing to send DISEC command with old Address.
>
>     The olddev should not receive any commands on the i3c bus as it
>     does not exist and has been assigned a new address. This will
>     result in NACK or timeout. So, update the olddev->ibi->enabled
>     flag to false to avoid DISEC with OldAddr.
>     ...
> }
>
> Signed-off-by: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
> ---
>  drivers/i3c/master.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 7028f03c2c42..07ccb2c00074 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2042,6 +2042,7 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
>  			if (olddev->ibi->enabled) {
>  				enable_ibi = true;
>  				i3c_dev_disable_ibi_locked(olddev);
> +				olddev->ibi->enabled = false;
>  			}

you can set olddev->ibi->enable = false unconditional. and add comments
about why set it to false here.

Frank

>
>  			i3c_dev_free_ibi_locked(olddev);
> --
> 2.46.0
>

