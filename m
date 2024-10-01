Return-Path: <linux-kernel+bounces-346371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FEC98C3FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA875284A95
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B11CB510;
	Tue,  1 Oct 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jeZXpBh1"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010069.outbound.protection.outlook.com [52.101.69.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4C1C9B81
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801661; cv=fail; b=TdCJ7YTEkcxtab8MBTPKXbSlZ9OHJNYXkyxs2V1yVVCXNghIJVh385rgeeIX47K5b2UeB2IoHkw/chetZqPFKXT+dUDj3keF2K2+LIh7BzrN1+A1mFEzh/jfQFDs+PaaaAiTzxntcX9/gfjfVVixOOTCgSxzwx6pgqYhi/ChovY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801661; c=relaxed/simple;
	bh=6I9U6drdn5YG/UIKpF1FCwdreBrS77T0PzNHqTU6d0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PvIiP+dPw+z6Irf1wHx1vjsi8Xz8Vs9dBaoxdv7j5wvbDseahjBPOvrz8veE+a7WcIknKb19VCP+ZZZEYnuNT9Bkwa8moKmXhNf8csnSmO70xQ8ANPUIvMb2orWNWvQlKcIuas2+NkMfy/SkznhSBnAQSujOFV9oJ8+fZA5zJl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jeZXpBh1; arc=fail smtp.client-ip=52.101.69.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEnRfiJTTxdbc4Vpo+xM3sPEC/2rvr0VOsMWT/7KPimONFQmRG8wNtyC8wgAdk5csMYrxhMtmtcAKW7MYVy4dkVM5jqiJhG64AVOmjXYsuIrUMGm8sEnI9wVCzo/GnUBVsga7pe88YO1fL66LqsWgJyVYHgSS680I+QORFvkUwxuml0dOZDUraCIosF+OJlXp84+Oe+rn8uQdHmL3hqy331onYB6FLhM28oTIyhHlWCfGZGpFNxoKmswCMwpEPb/ZFn0oACTCkAYDs34SnPEa8y1uVLPdoKynpxfFq0dPztIZqqqgGZyvF/jt2wZIVmRmQVSTgqQkpd/uNSpr7N69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K4QbwZ61MYXdgy8JUm5f/EG9FUHXDghTTJZfCe0nkA=;
 b=T3ThCVBkoRgLeOpsazAcTLWPZDJ0n1GvUVzIWVvRiOOR2cIHMF0W5pKuVdzm7nFCuTjFLLIxBdBDdDas9PPEWp/6oT6P8wxB5AA5BGosnsytYN78//8PuUUGE42Oo8koRTCgeHb5641K2CjmufD/uT98DsbbiGD3hHpmRIz++vdrQBRj/5zZlPaOL8BMn7aLqQjgoYc3gtIsWveLyozy5APLqN4MRpEfV7GH+7yVS+yD7MGyi8XO40rpkZTp/YME68oeISaQupSZp+tCSNc8pwQzeLjclpH3d4ReCAmt5ifkGls8ENa6KLNxh4BlQXDwIvyNUKACnqs+7le/51g/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K4QbwZ61MYXdgy8JUm5f/EG9FUHXDghTTJZfCe0nkA=;
 b=jeZXpBh1j8TSBNBeEpItDf1+ARdOUDI9PgRvr2+BKyxofS9/jx7op974q9am4kXLlpUxb/TxZC88yx5d/CUvrcIBA6eLFehsnwerCWhE6XsSzQA3AU0SU0/CXjUylyuxyIxEhu3qLddrkq07puTT38Y0u0fn5yeaqvq+cAU0kDf1C1bx9VPEh8VfVsLdZamyuJFn23oSpGWiv2uPyHrnoYN5Nmu0g2xm+DNsfNWjY7mgExw1vK+PFvZdpBjtIJwBLjWxThgI7c6guLObvWne0WdZbHdztrnaYsarA6wWxTEqFSNyYdSS8bK9Tru2nDKI8XuZjdJuBYsnJDVp7+KgFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 1 Oct
 2024 16:54:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:54:15 +0000
Date: Tue, 1 Oct 2024 12:54:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, stable@kernel.org
Subject: Re: [PATCH v5 0/6] I3C: master: svc: collect all patches to improve
 hotjoin stability
Message-ID: <ZvwpMBWzNjTXpPZF@lizhi-Precision-Tower-5810>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: 18740d29-7f46-4c3d-429c-08dce239aeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dwT46TGVqUsDxQCyWdL1jybhy1GIQa6AR1jmmQobuoAC/wgtYe1Nff64oUKJ?=
 =?us-ascii?Q?g/i62t3M/U5a1Uen2WIJB362CfVD52jRyF4ECOlB1hT2jfQjhMAm2szgp9h8?=
 =?us-ascii?Q?2P+Ds3DEQkUxa7LA07Gn3drPv3B+qeRzMUbPQhxrVtcYZDq6UF8Ot9sFMnw/?=
 =?us-ascii?Q?dQUFHPBniohUWoMAz7IxdSfmYkT1z9i83mWtoGmvReuVQxfuvOyqJmxjtmB9?=
 =?us-ascii?Q?8KO6TrxHXmxuSq9SeN+EBmdc/8fRptD1JU/EJnWgPTSWuQk6f+XQTm+Jg1lE?=
 =?us-ascii?Q?O3a9ffS0QyjGJQicv2P4UWoWznmYytk33QtfciLbwWMGlQHJK5cH5A430dEm?=
 =?us-ascii?Q?7UO5WBBPMgbeKS/ZKJyDsn3U8kYP4xxzZqCN+PFlftzC5HIClfOXYEKHj24b?=
 =?us-ascii?Q?u9EK+QEKmCgycVrhsyDgeWDNNGqdWzZUFBUWzJ+Uv6ENl4h2k47wanj4W3Mn?=
 =?us-ascii?Q?8ljqgC5VPGWB9W6k/nqJGTNaA3XtsSefuBRomTNcKr1XTQ2HazPyHwkG79xR?=
 =?us-ascii?Q?rzDYzkNebI+Y9A6ep4d146LijSMaXWIburDF9cS+ioSxixXPnEGqzcSUhLPV?=
 =?us-ascii?Q?8+E1fZAlA1dLjGrBdcLVWQsyGRFSy3T2E+OmRB9Ca49nS+fwnqofNEIvci3z?=
 =?us-ascii?Q?VJkp+S+SjOpUbCRzBCWNdidKDFU60GaqvqsDe8Lainmoo3t8ZD9pLP8Ey7cr?=
 =?us-ascii?Q?fcLSn7ouGgEH+BuGD4hBf1fl8ljea8aeKHk03GQ2RukqXY0JXbcD4atlvn6v?=
 =?us-ascii?Q?roUGGSlaM2LLOvGYQCrYjnYcUZwvufQfVtQitpzEHyxNpxBCcfZ/Ey/DqkGF?=
 =?us-ascii?Q?mSmqMpggobHpd1lBWLYNGeMzgEsKQ2la48nnK//1zRRTSZAyy/r52Oa3DHsj?=
 =?us-ascii?Q?l8BW/bN43Pu4mwiDDivplmOLiDfGWKbDLI3W+nqrxue3o7B7MDjFNMkjbRjB?=
 =?us-ascii?Q?ZxCWJQ9LtVBRKo8r4YgJYkUDO/64LLciBYW1a5zfDxEzdRkClAI69/SNpita?=
 =?us-ascii?Q?bo/vVCS+EOk3Z/Nour4wtzlZVzMIf4zfVbpnQ83rjEUftHa21Ywa4Hbhm8G8?=
 =?us-ascii?Q?ERXkaRs1hlWGxvExGo2xVEITOtrkq67LfoFOJmo4820vdij6hfHoH8tuaQkt?=
 =?us-ascii?Q?QmlSxAzrHsFE0UGNQWqpmANKTZxVtr6fif88TgEfVWsu/JVguKQnSExFJQoh?=
 =?us-ascii?Q?M8OMySsXQDm3kApH8uPB5oQgYeZizX2MEE1WZKMhVz4QlBRRwVvK83V7UdBf?=
 =?us-ascii?Q?JEO8XonhriqcGyztxChZ/nrjmltXfg+P2xzLKAnPuQBiIXOFD/KReQAxkU+X?=
 =?us-ascii?Q?Bh0q5HP+lfDVhFp5/pH9frZ3Awz3oQp7X7twDZY72+d+uv0Nt7ixembDnkLV?=
 =?us-ascii?Q?BFgaQXoo7pAE7LMvZxZHq6kF0QQLZPoaFADaRqTIscN3GDfk7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NRopPvmljVH5mBuyvnjcjaJTb0lZbQCBhzBIuxFdUBShVb/rx7OHXZ/o8jsa?=
 =?us-ascii?Q?+FdrTDI3MGYFpLCeslON+Vl44+PZrENXxxzzljln40tw/5KGqPs42Otu/9H6?=
 =?us-ascii?Q?P99S/LKBwffjlrPW6b/WO4gH+H2p9yzcf4DI5u0VfoXmjqvBNKtzFmX3SIub?=
 =?us-ascii?Q?4//RP4ItwejOfd8qtZX6vNk6rkXG+21ysKuWuokSrDLHrR0WUOfNkdyS/sNP?=
 =?us-ascii?Q?kRv2Z+IBg1eujC8mpaehQwXWXke+0K/hffrDmmOlfbWqqAJhGy5D1hF+NCL/?=
 =?us-ascii?Q?sudaMEuO9d+kdL38bXWFjsfER4ZyIad9K1Fqs7WFqurKhoaB1mKRb7VsGcOM?=
 =?us-ascii?Q?2WIUiAinyJuCxlzLulqO+RlCOX5aFk45YxLxyE6oRv8wP7na2oCP/8sPbWLt?=
 =?us-ascii?Q?fWdcC5fE9Wj1LI5Li1YlxhD7nDnRvaupQWBNiZRFZfFoRl8fS3HQhbY7jQw3?=
 =?us-ascii?Q?aZKbXGT2M2bzal95CyvZvk7S3il93jtzONzES0vS22xkGBexWMTxAUz64yTS?=
 =?us-ascii?Q?PYKMOEg+Y6JorejxPshNoBmcWjQf8+gvFsg/I4w/Dk6EGFIK0xLz07vInAEX?=
 =?us-ascii?Q?EsbniRwDC1LFrN6a8OF31du5q/hA9mIdiywgJcaSDJqMM8dq3ZvBFQZia8Hx?=
 =?us-ascii?Q?xa0RtNElLlPmW6d2NI1vctkyWDOxnAc+1qhn2FQ8QmSn2rjRWZ/7nM7kOp4+?=
 =?us-ascii?Q?Q16uZ13M+PdDO5RHhqMYaDPrDzazWGmkZtWnUE5wuvPDXVylABaE6xv7yvYZ?=
 =?us-ascii?Q?gKMmKdRF6lhtQ60O3EzjZ/H4O3JLN1O5/0XrgaLhm1tcYI+hU3ALQB9eOCBe?=
 =?us-ascii?Q?GOMQU7oizIsH/TgEzBdRoORK8w/fg9uGT91g+WVE6TP9CRWCHiyYXyBoWjUa?=
 =?us-ascii?Q?GMliYSZ5oHcE35oskfyTt+LqkzQB52u89is+5g6tl1mfnxecemHEAWoMWyfb?=
 =?us-ascii?Q?q/V/mssmCMMnDgsgo48cIODdWBUsba1MG0u9Y3/7AV8CRMClF5UbImxe6u1F?=
 =?us-ascii?Q?mnInKneXxwec6u4hjCeRnxQbuBhNmwQvqPyXrW2UoCCZKWDPlJWGdemtDfTu?=
 =?us-ascii?Q?jfus9Vxt0isC92TETCPF3R6fcp9YLSARYhiHdy+I0IVnmxCgLZZZ2QeIuAff?=
 =?us-ascii?Q?dsQfJsQxRc3AzIuWAAa8kaLowqCH5cyaevERlGeAY99AiocMkZGBbHl3MaAA?=
 =?us-ascii?Q?gp3fqkKW+OEiQoe2H/6T/r96ff796jJHAVtDLm/AaKS9oFMjieXL8T3KHIFu?=
 =?us-ascii?Q?PW2lWa8kqkxDZencLVVWqMi51iIEodGgGPUD7FFnXECc81nHhr/2l+lH/uYg?=
 =?us-ascii?Q?GdJPC973HC7KCw2UfvzWTEw/aJtNrGnN57OCYC8G4MPSOf2bRalNuWco758q?=
 =?us-ascii?Q?j8ODe5sX4lWmXXiy1Buwww41BGvGkjFsBCx7p7cs+Va+WFd8GEVuboWwCziE?=
 =?us-ascii?Q?5lsQY2nzWA3SeQWxh38KdpbLcnQJcDjCo+pVWt3SBdzdHAiiA53DYZ9mx/Cg?=
 =?us-ascii?Q?nwiyKazEPeV5txmO3wd4Qpl968GoY1WQi2f4OuUDEX2VkOPSOjfAfZ/3RWEO?=
 =?us-ascii?Q?S4UHOI5aO7ROBbdXhxflix0jPrzgr5qx+KaSVxkN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18740d29-7f46-4c3d-429c-08dce239aeea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:54:15.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: harq8gxUPRqBK2JNrfvJnFTCywllgCxIf86QUTtxIg5LxdKzOQNUZoBKKFdvgffMWe7iCcOh2Tz3MZ5DyQBpCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8630

On Tue, Oct 01, 2024 at 12:02:49PM -0400, Frank Li wrote:
> This patches is splited from
> https://lore.kernel.org/linux-i3c/ZvrAuOBLgi+HtrPD@lizhi-Precision-Tower-5810/T/#t
>
> It needs more discussion about dt assign address issue about i3c framework.
>
> This series is svc driver improvement and bug fixes for hotjoin. It fixes
> all kinds hotjoin problem when 2 devices random hotjoin and A normal data
> transfer is on going.
>
> This patch version start from v5, which exact the same as old series's v4.
>
> See each patches for detail issue.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (6):
>       i3c: master: svc: use repeat start when IBI WIN happens
>       i3c: master: svc: manually emit NACK/ACK for hotjoin
>       i3c: master: svc: need check IBIWON for dynamtica address assign

Alex:
	I am not sure why linux-i3c mail list truncate above 3 patches
https://lore.kernel.org/linux-i3c/
	but other mail list include all patches.
https://lore.kernel.org/imx/20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com/T/#t

Frank

>       i3c: master: svc: use spin_lock_irqsave at svc_i3c_master_ibi_work()
>       i3c: master: svc: wait for Manual ACK/NACK Done before next step
>       i3c: master: svc: fix possible assignment of the same address to two devices
>
>  drivers/i3c/master/svc-i3c-master.c | 122 +++++++++++++++++++++++++++---------
>  1 file changed, 93 insertions(+), 29 deletions(-)
> ---
> base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
> change-id: 20241001-svc-i3c-hj-bbaba68cf1ea
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

