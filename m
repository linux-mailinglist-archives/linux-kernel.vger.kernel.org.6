Return-Path: <linux-kernel+bounces-351406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E321C991079
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1292F1C22E92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C41ADFFA;
	Fri,  4 Oct 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QNjQSd9s"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A6D1ADFEE;
	Fri,  4 Oct 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073232; cv=fail; b=jcvQiJoy2mzgz7koV0rLLfpdEF9QlKlXwTUo16mZk+P5xsf4eP9qDfjW9QjnXL66h9xYF7MBCK1xuRjoRHa5GFk8XSx5b3Xc2NXOFAsarQrzjKdAlkJTGwHYt+dRHHtUYRrxkwjfu9lHvm5iQAQ0/I0aa4dsygbZVGQu9CdgkN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073232; c=relaxed/simple;
	bh=TP6aYtmw0pFz+4JEqesQKyOvv6Ty/voH+QTepNENYRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eCzlysNuOtzT/H+YSTkype/fqZoiBeNGlBE7mmxtLYp0Q8OFviWZp2JH0cInBfKqkACLvcC/mPflTA90iE7hRGrNEz7HYXJ8FXeHOQ7BmCqztrvViwySp4IE/91TibU41T9UZAib7yEDD+CC4rbhi3VXP7tq2HnbfniiXh7UgZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QNjQSd9s; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVgOVzfhnTJyoGT4HUA3VXm3xAt2pE46jPGTEKsvTOqqvlFpc+EG27Oe+seA2SyTOpcc0+LnoMuIEs2QjwRrtljR1eESuES/1KRA7uqvW+6t7GmxHg9VFnnC813M2WsF7k10GvCNI5St2KZrEuWo6olv+nir2vMSb5TbltKDH0gz6NxPxmZk/EPgeRNwEryxHjwB6zuUIQMs6FBnwqMD84OYDnEbyEOdcjgcmbzJ5MK64ERN41croKDFAa0C+KqpdT2WZMcWcDue5MKDyEYK0w5l+//CpJWBPIQ/gTKYCwsYFbnlnhMMWaYwqVnstdoK26gxNvVGu9MDKwF0gNsdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIZwXCUwxN0JcNEIpW+bD/p2wF7FXXQYNi/yw0CvqR0=;
 b=rMrjmNJL2ICmJsEGkpYbVQQjMAKjzwcvQYH1KohY6zFqTtfmeeH2cjrB10qOsIHxVX0WzpRVfM8/YaGL+wlxoCZt46oxUxg5RFkNJmOVRNuPfvsLtCk4w/Br9ZKRBysH3lpDEhmmjCdoQ6VHFeyXter+Nzqhk6ciJSfx5eTDU4cClVVICRxyQ/cCve7I4qKCtEoyM9F5ZqRnQBqSjV+O3pM8LLTZ2HJMNorHbwWrbheVoZ/GPhienQ0XYTkZeGfK6UShiyGV0z1mdsyXvE40qbLSvHZPUW4jqUO6s6INILu5/LYCnsSu0XzaHNNp/6jLgFUo8Ij5uZVMnkHin7E1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIZwXCUwxN0JcNEIpW+bD/p2wF7FXXQYNi/yw0CvqR0=;
 b=QNjQSd9sEILD7T6MW1zQThwL6tCUge1d4sDkAug3kSl/FNiJDBb3nC1Qlpdj76LEMjGgf7/yMiRZw2IhqEKmM0KHxsns+U7tWfX3UfyQuQiYbNtPcV/dGo6DXLt898bgfm8drqubXveXqI2FIR5sCVZ4elduf6gg0JH9tg0a6K1mMejhAV6FeJDrNow8nwwZ+QLhrlflR05atSGPoCvCVvQX7fAVeq/FDSYjy8CRF02gM/lFnO9ro54R4gh3xmT0lkZ8vSvKgvFjqyx3SwHdgH/cofu6oKmeWAIIdvDxKvqHGERKoYV6zhs0opk5Gq16nIghP4OApBK4E7fQ8+mLPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8581.eurprd04.prod.outlook.com (2603:10a6:10:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 20:20:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 20:20:28 +0000
Date: Fri, 4 Oct 2024 16:20:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: robh@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
	krzk+dt@kernel.org, laurentiu.tudor@nxp.com,
	linux-kernel@vger.kernel.org, stuyoder@gmail.com
Subject: Re: [PATCH 1/1] MAINTAINERS: misc: update fsl,qoriq-mc.txt to
 fsl,qoriq-mc.yaml
Message-ID: <ZwBOB8naX81JPoph@lizhi-Precision-Tower-5810>
References: <20240820190015.499641-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820190015.499641-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SA0PR11CA0161.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2ffa65-b1f4-452b-b5d7-08dce4b1fca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ur/k2Zhc7C6AYeRtAFiabHWiZOXwfLSx87ioT/TM3wErBLURVaPurX4P7Nmc?=
 =?us-ascii?Q?0CmvQV4QvXNkq8SVI9IkYnhOuxS7fCJB0q8ikh4wcYXZ6OW+N8MMSFaVLngK?=
 =?us-ascii?Q?da/PftcqFxulT96dyZaQatzVtrJ67TkkdXFrsJAWw/xKW+Ofz8RCxL4YMvPx?=
 =?us-ascii?Q?4SMLed1e+bB3r3up6XDQOe96TI6omypqmS3Ms0ztQZsfc1GdI4JGweCQEiBF?=
 =?us-ascii?Q?LQJhv1accWZMrEkZLzVrqrbyJEPGKK4omJ4faTwwA3ANulRqZuIR3EvX67zr?=
 =?us-ascii?Q?SywbP+LpEKV2F4ocTVtG0ugoIg84du99aE7bhAS6NHBh+RkEjQ8Cp7I9Ok9G?=
 =?us-ascii?Q?8SDtSdgiKDY+TZLBvZL7S63neVA51+8tL3YiwXSZkM4CJnJgBkYld4vyVIs5?=
 =?us-ascii?Q?B31qb5Yfv8ElvS8CD2wPL4NnlQkwoKJs6icgem36PB6zSjuZgqaDBhif+DMB?=
 =?us-ascii?Q?guCldffuEnIQvFgHrzglIlr9h+gkC2/jrRa5IY9kT8rmss7bWBPNeuHy/zhb?=
 =?us-ascii?Q?RWqKosM5VUTNmACQ4yX1fkbJv9OB+XinK4Rq2RVwfRxfXU5lc5sermsPxW/c?=
 =?us-ascii?Q?LUZPSAIPF6+exHDLXPWjI/KAsbd5ajGRyf4MVHQ4EdBs3qaAmlzzk4miK/Pk?=
 =?us-ascii?Q?49UP51H3rdJXLn5jSwhKHiUqhvL1kDfZBbv3KJHFToe629k3ItqnJGAyYBK2?=
 =?us-ascii?Q?nHUR8lOP7nY6cCJIrPo2LH6aUSIuAHlcACh+rTmUeuhdTFCV/1TUCCyh3QQO?=
 =?us-ascii?Q?DmRVRff6OP3/44pbFvlo3fhriob/UP/Gh6kN5crqpChZ5u103Qp3Z5m79L5i?=
 =?us-ascii?Q?XBILm0rjkI+ct0WCk3+MckjXLR72CL6kRmrk8M8m+ZSJIwwX+0K9/cTFgsxH?=
 =?us-ascii?Q?dlM9WmprL3u0SZZ0lsmwezFz2+b2o7dOTXiLI0CFeae/ve038it9i5dR+kp4?=
 =?us-ascii?Q?ey9g1zxP/9rBqvV/lsyXBnypGPJNuu3UIjnRUqNb/jt3dWM1kEDHJzBabCmd?=
 =?us-ascii?Q?FeMti1WIlitDArbJELWxZTcuiu27WLqTeeUCD7xgeEmAGjRtA/l8Bw9bF5lV?=
 =?us-ascii?Q?P8M2dH0img+GdfgRMWPUZAs26wKS2mXCUx6yWobnUdVm56+wU88KLFJypWsX?=
 =?us-ascii?Q?NgIH7ot+uERFYW4J87U1CJuXa71whQK7J5men48F0MqMkhzOxFf6xjSpiacT?=
 =?us-ascii?Q?oBrw+Rpcs80sbPFbHkwnY0iDI6UZYwTv7HI/8qPaIt8h6aPDTbhzWfnMPgRW?=
 =?us-ascii?Q?vOPIsNnC04Gdi+JcdulV8B5xiKHrV/NkrqC4bAOMyLetYm2JcC54EkKptU2d?=
 =?us-ascii?Q?AIMd4j1SYT38g7NtwyoLpUrnWef1efeTvdR2xyHwjZXj2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zAyoey0Cb58/8EMrKTaQ8sudKpFw2h2lBX1OKwC1whVnyBgQaygiQfiYYCpa?=
 =?us-ascii?Q?wFLFwULAFMDYHL8lZUxpOzp7T25jOJ6sidwADKLwtwHHHvI6b9wJG1tRof7l?=
 =?us-ascii?Q?ssZc4V4qgH/DGCmAQ6eZUza96ZM+6gm4yKk/TZObGTJUf4E2C230HDlbMhdH?=
 =?us-ascii?Q?YLqB8YOZG8aSvHaWeXYLyFkxv78zXT2KmonIWA3U9Hu7LFzBLcLk2ya7vPUk?=
 =?us-ascii?Q?OaU+MRsTzMiWEiIlTIr7bEbSTH41p5qZf0yj+6XP5LA+ULc7TNl6SA8hsJmN?=
 =?us-ascii?Q?NTcDuaYMzjcroUHauRWNliWOgVm+zdWAdygPcT7eMH58FxJCZKd8qoavVkDp?=
 =?us-ascii?Q?YNYsBpk2ByV5lTy6f0Ujy9fbohB4/yiEP1TcxEwARKfwf21dPErAtfQ3B2Nq?=
 =?us-ascii?Q?InIz/JA4Tl6zDw/hVH76//pcjMQllrYtU6zi1Xg3AK5DOdxlhgHUYbwo0aTR?=
 =?us-ascii?Q?PDh3j62K6j2xuvAxhybLgkOugDxsMUFyPtVNmgrHARzGmJPj/oHDA/WgOnnk?=
 =?us-ascii?Q?zVf3xrLeE01ZEh2PWaDNbF+l98UQ9yy15VDFRORgLBf9PN16PpPyv/U0euhY?=
 =?us-ascii?Q?yNw/v4Ib/7kskNYFu99wuicN8RdntYBScL2RTNAAo8hesyw9sTpRAcB6pWZA?=
 =?us-ascii?Q?coaRqPwRZ6kwqmUuOBuZtG+6LwyMPGRHIu9/pfamYfqHkee0QXk6F9G+vsEb?=
 =?us-ascii?Q?pyevyLqxOI2v+1AyB03N7H5rPH1bIs8mZulUE6uD0enqirl9ARQBGG5zH+CZ?=
 =?us-ascii?Q?KTMwYvwPlSd2hn3wBYHGv4dofVHfn6pBlEPo0nNuz5sh0DQ2E+ZSPMiZH8vL?=
 =?us-ascii?Q?YDmwSmrEwWUGFCKpgtHDLo35AV5iUyk1gd9wqbVCDIKHPkmOfiKm0lfWlLT6?=
 =?us-ascii?Q?3ukMJEE9hv0faguwLfYb8ZpBTtC42PHdS/jc8czhvg2dzMbUov1u5osGxH7/?=
 =?us-ascii?Q?psqMDJsmO/MJN80uxEgGfKdsOzH7Qj8luAeGRRJPmr2NDtPXxYGxRueOjqzF?=
 =?us-ascii?Q?nCugxQHqBC/PkDiRqkxZ62fudClBhPU0GuZh28c9wGNRCFdRIf/yUqvKHz9P?=
 =?us-ascii?Q?3f0gAmaG/J09tWRQgLA0pPMi5TlxZObPhdbpUUp6/GP12FWBy/+63CSxuTdj?=
 =?us-ascii?Q?UDCEGXjpTt33V5Cn0dC9st0/N0/O/tU6RIA1hU9Ffqj7CQ7gOW+mbZ0MSpQa?=
 =?us-ascii?Q?JDbpPuy8OmZnG2iC3Nk2BCp5dnBvm5R9ZvXQoA19J3Iyfb98WA4I5hDv6UD6?=
 =?us-ascii?Q?UPrPrR0MvnrsW4sSxhg8ZXmUarXbxIs8DDXKU/T1ArZ6VBS3u7bA4SvV1R4B?=
 =?us-ascii?Q?3csF3f6NkhJX0t/140d15IgLKm89w781ekhOrOSDjUx5STmbJtEi1EIwW1f6?=
 =?us-ascii?Q?TBI7QiQrgmzFqle0ZJSoAO6PmLHoqaWc3iExNSlR2WL7+9B32qgSPgv64+sZ?=
 =?us-ascii?Q?/UoHKPjm2qvhgoDlILX9YV/UT/TaWrk4N1FZ9J0hmT8LuvUSQ7yV1JRlRHjp?=
 =?us-ascii?Q?c53aGyZVODlwljoJzsvHIx/efNnRntAysGx50vSNMWrLEWrJHTbYV+9uZj4U?=
 =?us-ascii?Q?VyNas9PWPUFtcCkl69Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2ffa65-b1f4-452b-b5d7-08dce4b1fca7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:20:28.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ADAp3C/nhXYUSovoR/6F+WG+QOqx+pyePryQZSoiUqbb/kYIP+PpY2HijuwbnK+LVew+qG9FOhMMzsFQvG72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8581

On Tue, Aug 20, 2024 at 03:00:15PM -0400, Frank Li wrote:
> Fix below refcheckdocs check error
>   MAINTAINERS: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>
> Add nxp mailist: imx@lists.linux.dev.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Any check this patch? just small fixes.

Frank

>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fbee89eaecf6..d174cc3ae4347 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18765,9 +18765,10 @@ QORIQ DPAA2 FSL-MC BUS DRIVER
>  M:	Stuart Yoder <stuyoder@gmail.com>
>  M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
>  L:	linux-kernel@vger.kernel.org
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
> -F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
>  F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
>  F:	drivers/bus/fsl-mc/
>  F:	include/uapi/linux/fsl_mc.h
> --
> 2.34.1
>

