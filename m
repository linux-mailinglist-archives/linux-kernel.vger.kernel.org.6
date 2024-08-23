Return-Path: <linux-kernel+bounces-299759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981B595D9C0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0142B24274
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97841C86EE;
	Fri, 23 Aug 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VQ91Xmcw"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020132.outbound.protection.outlook.com [52.101.61.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AA18786C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456333; cv=fail; b=jPCZFuGi2oG44YRJo3o/RgxN5hxWZuJ/ZJnKu+fWD+X2lPPmWmrPpwooQlIOTMMEWi7bz/NxQ3c0Co6gHu1+EUTveODxnri3aM4r0zPbYwdR+0s8aWoW+2EJNxC7r43pHqf5WoTI2FE7ngvH9/hNM94HWZ5c+nhlZVmtOkZG+4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456333; c=relaxed/simple;
	bh=f2afB9uaQ9FcroXTX9LNZfLhOnDrQYmlyM3eadURx1w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=dUzRtGm/veG5sRpv1z+oiieB+Gol/Gl1mfHM3Q5tV4u9xrwGZOziEIPpXmrzXgquViDPshLh7nWafWbbxfmDzxzXC35HGM4fzk05gyuL4gzfoS5InXnWhfY7/MRG7Y2TpQq+8MqEsF1gxyHUuBXIK74Hgljru7zrdhDqx+ymiIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VQ91Xmcw; arc=fail smtp.client-ip=52.101.61.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPL5O02A+cqIrm9cdLeDu/UCtYLlJUuoSh9USGGgV9DZSSFK90GDtUoBwQfqqBkFUU7IAL6M6QajYoUCHBo3i9eGjGfXBGScmZzWl88OYS23FnGCqMfA8YGRko2NP7+SdOEiWXBtsQAz6leCQkSlHBnpS8TQk7AXHxNQgE+lxkQqEkWZM4HokxQlojQ6AXCYIWu0Dquio836Q4gzUUUxFhROvqtRbAHfkaUZWDHIW4jPW3a0fviG6A9n3+FPDQBK9VnSKENlHaofzMPcG6V3e1piNCJ8mzNjAw9PDjTeQkEHC4dlLEQZ4ZqU6RqqMf52UW7LZXcxT57E3l6TIKoR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATIw6VRnKMGFDyp6Tdm9byI9E4J8bdgVNeHq/rGDrkM=;
 b=DxNvhjW5t36nBi2L2I/uLS7Xwzztbv2YzWWZzEf7pPGbUXxgKebU/GNokQnj9DcFDxhb/v6/+A+tkJU82T7YUSDMsvdNppAU2tcGXUybkdnpXC82S+LBkr5vVf8oKDFNoSf/UVdcZhZjRVV5llqEytrBWH0HOUAuAnhQ1smwwNk6di0SgDG+w0f81A29alsuPVhOFj2ZZ1lKaEbu2ly8+/2BUEpjw4oln8bqKfMptzMmnmv+cZjjHhPCkIUN/XLGba7hV95S+/Pd068Q4X/DdNro6T6YPgS+I/Wz9gY1zmQNFsbpFiulMVlguqvsmQs/dmAb1kUxX3y8iomXP/Yx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATIw6VRnKMGFDyp6Tdm9byI9E4J8bdgVNeHq/rGDrkM=;
 b=VQ91XmcwXHeudHSmJiBd4iMrDkAv9+kkec0VSDy+KVZTbatM4cjyjLhfG2uRBWkEp1SLo4s80I7F3rTaymvn5BG0ZpNJJX3bc12b1wJ4RmykFyBDX88zw7UhXpe6cA//YOURel7goRdDmhVaHJwtYrQFjaOqT3neHzVBQQhF/l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 DS1PR01MB8822.prod.exchangelabs.com (2603:10b6:8:21f::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Fri, 23 Aug 2024 23:38:47 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 23:38:47 +0000
Date: Fri, 23 Aug 2024 16:38:40 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH 8/8] perf/arm-cmn: Support CMN S3
In-Reply-To: <2e376143a442a3fa5e68e769358b4c808ac63388.1723229941.git.robin.murphy@arm.com>
Message-ID: <62ba4735-37b5-e82-6180-54807f86dd@os.amperecomputing.com>
References: <cover.1723229941.git.robin.murphy@arm.com> <2e376143a442a3fa5e68e769358b4c808ac63388.1723229941.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MN0P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::7) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|DS1PR01MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: e92f5121-2233-41c1-e7f9-08dcc3ccbbbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YBd1DxhwYkXOrQKbo13f7D+ND1MTVVAqFsuN+L0r7DRf14BuikSQNdMpBBbC?=
 =?us-ascii?Q?zsklYqKYI47vldzg5ERRDXE7ujnp7TairjT5LYUM+5eo2fST3M96nymRwRnO?=
 =?us-ascii?Q?uxsMyg1oJWXe2aAumvb5WuA/79AtVaVs6EETLHUMzvXu2Z1r9KQzp0m06YDx?=
 =?us-ascii?Q?/fqtLkzvRy4mFOmF0ZiNJECqQI9jC9+sR/i1wCUGZa1G29nOm721I1TMY0DV?=
 =?us-ascii?Q?eOiWwYnUpFrVo4zrFgkfcLVy/l31EweOZeODeU/ZO1ca3BvLLOtmx3T5/aE1?=
 =?us-ascii?Q?9VlJkeUBSvwORbDR0wnxDaBTPSgSSFr/d4iqNcysFbOfOXnY9sfEwmKNZJJP?=
 =?us-ascii?Q?xyHBdiZKcup8/b02tUPftiIBVAuHPRNaPmJwhrZOhak4i5chkXnETvcI5ABv?=
 =?us-ascii?Q?N/uopFckPEsenfkUDGytY6TVdofsNezBJYInP3PNrvodXgT9o9jK12mKLaor?=
 =?us-ascii?Q?C3TFwl/HWDaeQLq9D5OmUPE1P/BBVDsOIgvrOQpHU3ydxR28EhhQTjz643Ua?=
 =?us-ascii?Q?R9lw+e4SW1eevL9ZEYxYv4jGCpmdD9CkSlNdCEEpe/asZnmH3+okVqCXxaOj?=
 =?us-ascii?Q?+UsOIgY/fFXRLt74ZeGYpoV0pYJCb0iGYaD38eaSYGTbN9/ILyN36OsPuwoE?=
 =?us-ascii?Q?rJcHPhcVOrGw5wxvTblzSwkUaFc4FQYjkcgrDh47HpN2shRyPtZAjnKotzd+?=
 =?us-ascii?Q?VOD+iY3llQ0KDZQOih/lx+k0ZU5+wC0GT6FVUA8H7tmebP74gpIrWQzSrwm0?=
 =?us-ascii?Q?xpLRaqRwRKqUjLZT+LNdew3+QooGExsGgMs5uiW/j8s8fAO9eW/siAI7nfYO?=
 =?us-ascii?Q?WI48MkoOx/5nbVfmbrsgrbiyybdFSmLSyCyIqI8AUeW+hSnR+DQdY960Ovkj?=
 =?us-ascii?Q?Zdb0thw/Tx06lfy1xewSDiriUmz2O0dk/b68wMUEGufxrhwkMdGK7XhI3+Cb?=
 =?us-ascii?Q?628IK/mU4xYaMjm8f1Xm/rL1AOYDNyc44ZvRQLAMEobHHShAJb1SIKT1eEn7?=
 =?us-ascii?Q?eTbwj+hAxrKyuwWvklDQYfh6XMQ5j9p2Hb5eVam7Uoc/IS4qLKbjVOvfT1gb?=
 =?us-ascii?Q?8IWrqkOPabO61BVXAaua9N+hP6nZqc8BmCQMVz4eFr2QNjlcgyEEPB1TXyk4?=
 =?us-ascii?Q?F0xh+DE5s8+uizqs3R/0FpOqDxzoilHamg2/GiXFMLCjfhxS2W5ZaTjd153K?=
 =?us-ascii?Q?EBU7pEp7g0MXN3ZBkcH4Dj1/cMV7t1KEJrPfVRdyDi8I12y9KTiMRpxzwFBC?=
 =?us-ascii?Q?KFvku7eUH6ZnPlJw1aUC4u0ycgJspzf2tTTR5JiUrXaqF0q7zSq74gcDYjXv?=
 =?us-ascii?Q?DH3BsLTWok+gs7arvSg7ivGFWN/RahdunKCjqPiKglE7R7YL03qRebJQ9pJT?=
 =?us-ascii?Q?nOCDX8crKypjrsF0oCuPtzkmprYpbuJ9bypmCYgkPLXm0wMUYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgkOyFbWzn+FCr9muj3zys1Cfaae/ttvCLzkmutM+wdZzmYNXqyEt/z0xhkf?=
 =?us-ascii?Q?556a6ICAJSxThf9Jlw+HlHA0Nf+l7JKzQdpAf1XBpNqt7h/hGY+Wg9ybRFii?=
 =?us-ascii?Q?qPu8i7DYaI9f1xNkxggfTCQPjx8s2NPCWoj2LLw4PIxc+TYKgX8oRJ9ptKL+?=
 =?us-ascii?Q?zyLOHMDviSV4j8WsFKjiLNd5dlCO5vtur4+DMA0cfBB/NxJBg4TTUpbMTDEI?=
 =?us-ascii?Q?kEZXSSVLcjJucXNTvCB21NEI+lCeTZzAkGNS2DKTJilsx/p1tEj3qJEgXsRY?=
 =?us-ascii?Q?1OOtq8qEndbdatYH9T/+HY+/ZUCxR6eC98kEjxX2vZObNy0V7bA8wCGLCV5V?=
 =?us-ascii?Q?t8SZC808ksZOC+ZsZjEKvlssOQyQSqKND45hQcwGJb6jK77Vh/GnPyurg2cl?=
 =?us-ascii?Q?3lPXeph/ulSa5rsVwujkyjukt6DqIOkKnWk+giA/XacQymjUeE3VktYjXoVF?=
 =?us-ascii?Q?VnNydc4DByoCtZE4cujExL3Y7pOFcvzp9O3dqhVm2QQ1GeUIa6DQyWsw8+DE?=
 =?us-ascii?Q?qmI6Uh+iBpx8mVV71RZee4Go5Z4Ase+5aA1Swhrs13wzDcHz/kHMACIKkxre?=
 =?us-ascii?Q?47etB7avGEW3EU3z307Xymw1l0HJtvS05gMEzB0rQo/FBrvfn9YuGkVowQxb?=
 =?us-ascii?Q?FTCUD+3BxWnel/JLXhbGGFOQpymfbyC95gkAtxYjW9ESk4mV9/Q87t3bP0rA?=
 =?us-ascii?Q?wGx2DIY667USppvbl+2+8g1vT0g9H60tA6bKWuMmMMDkucUHFtXC8eb+yQl1?=
 =?us-ascii?Q?K2vWsRVl7cn4GYqTFYmFRycwBXbPpOL/PJxBp0Wz3favr8BTSLT8mcTuDIcM?=
 =?us-ascii?Q?EkFMZodQMZ7fsyYndb1DGJAaPjmGvrJCYogxbgervMwJ0G79nu9kSg2Uwulg?=
 =?us-ascii?Q?GrMoaR91SGA4XmDjP0WPAe1WSuqqNespK8TFNpYLfjq2dpArg/dg7Phu4zkh?=
 =?us-ascii?Q?nIMlDnxfJy2Nk0j9/cDGFM1J+9KzZoUWR2Hwb9OnoTQ7QWoigwYIW4ttIyE1?=
 =?us-ascii?Q?1Nxc6ZdgxMPt9lEPld9kDPx9wcsQcxZnkFH3JbdDQN0Mi9RsxGLJERoOO/oe?=
 =?us-ascii?Q?Uk04e2nvFP7Ca+T0CPU0w+IArx4XGVt6jXXttO9qPm6wrEpa0chLUflz1QOn?=
 =?us-ascii?Q?/ajmkks94A+3tLuHyi/r7VPBq9OYT2tx2J3y98ZcJB7rIKyk75LF5ZyIp8wX?=
 =?us-ascii?Q?4iMHMXt0eXK2UpaT0TVGZMEV0AkPVUNy6wuAqy1G91YQPEChDteT//n4LKzE?=
 =?us-ascii?Q?ClN+lBrPgjxTehKggjbhkz5PVXroY9C7YX3JYkuwS00EfpjbRgUl8GUGzExQ?=
 =?us-ascii?Q?Rbx0sm2cHgcpUqm1b/vE7bIXwjbhXdniR/N3h/zCzjCa9k5PMdq02Bhvxldc?=
 =?us-ascii?Q?C0V8UEi6wwRYzSGJ4brfoUMe6p7i2E9zSOyhPQDVxeqPY1VRX7fbUTnhCzdP?=
 =?us-ascii?Q?lxUG+PYnu+02TkcL3mouuU0CA/nVMHxlVmhgO2R78Blub7nuemqfabo8RKLX?=
 =?us-ascii?Q?Uwmpoy2E5/0kA1vLGygSkWI6NJA2Xg4q00FGQZPd6V3Eq3PbuAfdzOOge+M0?=
 =?us-ascii?Q?QFdyKJgTGtIn3rrBcUk8q20wBsNo1gLzko/Rx1BbhsWIRSAH2hAgBCuVHNpV?=
 =?us-ascii?Q?sh5DO0s/7g79X2Sl7CbWKxk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92f5121-2233-41c1-e7f9-08dcc3ccbbbb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 23:38:47.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfa+yxBYsG5XStPk8rCPlau+qWzY1iC26Y/c/jP7oDX3p1G7NXznJCcnH3ysSIX0soxqFPUsZoRVhV9jqS67UOepMOMWjjBUGdUMEBP2scBnGJ56xUIa/s7CdeUztfXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8822


Hi Robin,

On Fri, 9 Aug 2024, Robin Murphy wrote:
> CMN S3 is the latest and greatest evolution for 2024, although most of
> the new features don't impact the PMU, so from our point of view it ends
> up looking a lot like CMN-700 r3 still. We have some new device types to
> ignore, a mildly irritating rearrangement of the register layouts, and a
> scary new configuration option that makes it potentially unsafe to even
> walk the full discovery tree, let alone attempt to use the PMU.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I didn't look at CMN S3 spec but the patch looks good to me.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


Cheers, Ilkka

> ---
> drivers/perf/arm-cmn.c | 117 ++++++++++++++++++++++++++---------------
> 1 file changed, 74 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 12bbb689a1af..0d19163fba5a 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -42,24 +42,28 @@
> #define CMN_CFGM_PERIPH_ID_23		0x0010
> #define CMN_CFGM_PID2_REVISION		GENMASK_ULL(7, 4)
>
> -#define CMN_CFGM_INFO_GLOBAL		0x900
> +#define CMN_CFGM_INFO_GLOBAL		0x0900
> #define CMN_INFO_MULTIPLE_DTM_EN	BIT_ULL(63)
> #define CMN_INFO_RSP_VC_NUM		GENMASK_ULL(53, 52)
> #define CMN_INFO_DAT_VC_NUM		GENMASK_ULL(51, 50)
> +#define CMN_INFO_DEVICE_ISO_ENABLE	BIT_ULL(44)
>
> -#define CMN_CFGM_INFO_GLOBAL_1		0x908
> +#define CMN_CFGM_INFO_GLOBAL_1		0x0908
> #define CMN_INFO_SNP_VC_NUM		GENMASK_ULL(3, 2)
> #define CMN_INFO_REQ_VC_NUM		GENMASK_ULL(1, 0)
>
> /* XPs also have some local topology info which has uses too */
> #define CMN_MXP__CONNECT_INFO(p)	(0x0008 + 8 * (p))
> -#define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(4, 0)
> +#define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(5, 0)
>
> #define CMN_MAX_PORTS			6
> #define CI700_CONNECT_INFO_P2_5_OFFSET	0x10
>
> /* PMU registers occupy the 3rd 4KB page of each node's region */
> #define CMN_PMU_OFFSET			0x2000
> +/* ...except when they don't :( */
> +#define CMN_S3_DTM_OFFSET		0xa000
> +#define CMN_S3_PMU_OFFSET		0xd900
>
> /* For most nodes, this is all there is */
> #define CMN_PMU_EVENT_SEL		0x000
> @@ -191,10 +195,11 @@ enum cmn_model {
> 	CMN650 = 2,
> 	CMN700 = 4,
> 	CI700 = 8,
> +	CMNS3 = 16,
> 	/* ...and then we can use bitmap tricks for commonality */
> 	CMN_ANY = -1,
> 	NOT_CMN600 = -2,
> -	CMN_650ON = CMN650 | CMN700,
> +	CMN_650ON = CMN650 | CMN700 | CMNS3,
> };
>
> /* Actual part numbers and revision IDs defined by the hardware */
> @@ -203,6 +208,7 @@ enum cmn_part {
> 	PART_CMN650 = 0x436,
> 	PART_CMN700 = 0x43c,
> 	PART_CI700 = 0x43a,
> +	PART_CMN_S3 = 0x43e,
> };
>
> /* CMN-600 r0px shouldn't exist in silicon, thankfully */
> @@ -254,6 +260,7 @@ enum cmn_node_type {
> 	CMN_TYPE_HNS = 0x200,
> 	CMN_TYPE_HNS_MPAM_S,
> 	CMN_TYPE_HNS_MPAM_NS,
> +	CMN_TYPE_APB = 0x1000,
> 	/* Not a real node type */
> 	CMN_TYPE_WP = 0x7770
> };
> @@ -404,6 +411,8 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
> 		return CMN700;
> 	case PART_CI700:
> 		return CI700;
> +	case PART_CMN_S3:
> +		return CMNS3;
> 	default:
> 		return 0;
> 	};
> @@ -411,6 +420,11 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
>
> static int arm_cmn_pmu_offset(const struct arm_cmn *cmn, const struct arm_cmn_node *dn)
> {
> +	if (cmn->part == PART_CMN_S3) {
> +		if (dn->type == CMN_TYPE_XP)
> +			return CMN_S3_DTM_OFFSET;
> +		return CMN_S3_PMU_OFFSET;
> +	}
> 	return CMN_PMU_OFFSET;
> }
>
> @@ -467,6 +481,9 @@ static const char *arm_cmn_device_type(u8 type)
> 		case 0x1c: return "  MTSX  |";
> 		case 0x1d: return "  HN-V  |";
> 		case 0x1e: return "  CCG   |";
> +		case 0x20: return " RN-F_F |";
> +		case 0x21: return "RN-F_F_E|";
> +		case 0x22: return " SN-F_F |";
> 		default:   return "  ????  |";
> 	}
> }
> @@ -777,8 +794,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 	CMN_EVENT_ATTR(CMN_ANY, cxha_##_name, CMN_TYPE_CXHA, _event)
> #define CMN_EVENT_CCRA(_name, _event)				\
> 	CMN_EVENT_ATTR(CMN_ANY, ccra_##_name, CMN_TYPE_CCRA, _event)
> -#define CMN_EVENT_CCHA(_name, _event)				\
> -	CMN_EVENT_ATTR(CMN_ANY, ccha_##_name, CMN_TYPE_CCHA, _event)
> +#define CMN_EVENT_CCHA(_model, _name, _event)				\
> +	CMN_EVENT_ATTR(_model, ccha_##_name, CMN_TYPE_CCHA, _event)
> #define CMN_EVENT_CCLA(_name, _event)				\
> 	CMN_EVENT_ATTR(CMN_ANY, ccla_##_name, CMN_TYPE_CCLA, _event)
> #define CMN_EVENT_CCLA_RNI(_name, _event)				\
> @@ -1136,42 +1153,43 @@ static struct attribute *arm_cmn_event_attrs[] = {
> 	CMN_EVENT_CCRA(wdb_alloc,			0x59),
> 	CMN_EVENT_CCRA(ssb_alloc,			0x5a),
>
> -	CMN_EVENT_CCHA(rddatbyp,			0x61),
> -	CMN_EVENT_CCHA(chirsp_up_stall,			0x62),
> -	CMN_EVENT_CCHA(chidat_up_stall,			0x63),
> -	CMN_EVENT_CCHA(snppcrd_link0_stall,		0x64),
> -	CMN_EVENT_CCHA(snppcrd_link1_stall,		0x65),
> -	CMN_EVENT_CCHA(snppcrd_link2_stall,		0x66),
> -	CMN_EVENT_CCHA(reqtrk_occ,			0x67),
> -	CMN_EVENT_CCHA(rdb_occ,				0x68),
> -	CMN_EVENT_CCHA(rdbyp_occ,			0x69),
> -	CMN_EVENT_CCHA(wdb_occ,				0x6a),
> -	CMN_EVENT_CCHA(snptrk_occ,			0x6b),
> -	CMN_EVENT_CCHA(sdb_occ,				0x6c),
> -	CMN_EVENT_CCHA(snphaz_occ,			0x6d),
> -	CMN_EVENT_CCHA(reqtrk_alloc,			0x6e),
> -	CMN_EVENT_CCHA(rdb_alloc,			0x6f),
> -	CMN_EVENT_CCHA(rdbyp_alloc,			0x70),
> -	CMN_EVENT_CCHA(wdb_alloc,			0x71),
> -	CMN_EVENT_CCHA(snptrk_alloc,			0x72),
> -	CMN_EVENT_CCHA(sdb_alloc,			0x73),
> -	CMN_EVENT_CCHA(snphaz_alloc,			0x74),
> -	CMN_EVENT_CCHA(pb_rhu_req_occ,			0x75),
> -	CMN_EVENT_CCHA(pb_rhu_req_alloc,		0x76),
> -	CMN_EVENT_CCHA(pb_rhu_pcie_req_occ,		0x77),
> -	CMN_EVENT_CCHA(pb_rhu_pcie_req_alloc,		0x78),
> -	CMN_EVENT_CCHA(pb_pcie_wr_req_occ,		0x79),
> -	CMN_EVENT_CCHA(pb_pcie_wr_req_alloc,		0x7a),
> -	CMN_EVENT_CCHA(pb_pcie_reg_req_occ,		0x7b),
> -	CMN_EVENT_CCHA(pb_pcie_reg_req_alloc,		0x7c),
> -	CMN_EVENT_CCHA(pb_pcie_rsvd_req_occ,		0x7d),
> -	CMN_EVENT_CCHA(pb_pcie_rsvd_req_alloc,		0x7e),
> -	CMN_EVENT_CCHA(pb_rhu_dat_occ,			0x7f),
> -	CMN_EVENT_CCHA(pb_rhu_dat_alloc,		0x80),
> -	CMN_EVENT_CCHA(pb_rhu_pcie_dat_occ,		0x81),
> -	CMN_EVENT_CCHA(pb_rhu_pcie_dat_alloc,		0x82),
> -	CMN_EVENT_CCHA(pb_pcie_wr_dat_occ,		0x83),
> -	CMN_EVENT_CCHA(pb_pcie_wr_dat_alloc,		0x84),
> +	CMN_EVENT_CCHA(CMN_ANY, rddatbyp,		0x61),
> +	CMN_EVENT_CCHA(CMN_ANY, chirsp_up_stall,	0x62),
> +	CMN_EVENT_CCHA(CMN_ANY, chidat_up_stall,	0x63),
> +	CMN_EVENT_CCHA(CMN_ANY, snppcrd_link0_stall,	0x64),
> +	CMN_EVENT_CCHA(CMN_ANY, snppcrd_link1_stall,	0x65),
> +	CMN_EVENT_CCHA(CMN_ANY, snppcrd_link2_stall,	0x66),
> +	CMN_EVENT_CCHA(CMN_ANY, reqtrk_occ,		0x67),
> +	CMN_EVENT_CCHA(CMN_ANY, rdb_occ,		0x68),
> +	CMN_EVENT_CCHA(CMN_ANY, rdbyp_occ,		0x69),
> +	CMN_EVENT_CCHA(CMN_ANY, wdb_occ,		0x6a),
> +	CMN_EVENT_CCHA(CMN_ANY, snptrk_occ,		0x6b),
> +	CMN_EVENT_CCHA(CMN_ANY, sdb_occ,		0x6c),
> +	CMN_EVENT_CCHA(CMN_ANY, snphaz_occ,		0x6d),
> +	CMN_EVENT_CCHA(CMN_ANY, reqtrk_alloc,		0x6e),
> +	CMN_EVENT_CCHA(CMN_ANY, rdb_alloc,		0x6f),
> +	CMN_EVENT_CCHA(CMN_ANY, rdbyp_alloc,		0x70),
> +	CMN_EVENT_CCHA(CMN_ANY, wdb_alloc,		0x71),
> +	CMN_EVENT_CCHA(CMN_ANY, snptrk_alloc,		0x72),
> +	CMN_EVENT_CCHA(CMN_ANY, db_alloc,		0x73),
> +	CMN_EVENT_CCHA(CMN_ANY, snphaz_alloc,		0x74),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_req_occ,		0x75),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_req_alloc,	0x76),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_pcie_req_occ,	0x77),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_pcie_req_alloc,	0x78),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_wr_req_occ,	0x79),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_wr_req_alloc,	0x7a),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_reg_req_occ,	0x7b),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_reg_req_alloc,	0x7c),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_rsvd_req_occ,	0x7d),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_rsvd_req_alloc,	0x7e),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_dat_occ,		0x7f),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_dat_alloc,	0x80),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_pcie_dat_occ,	0x81),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_rhu_pcie_dat_alloc,	0x82),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_wr_dat_occ,	0x83),
> +	CMN_EVENT_CCHA(CMN_ANY, pb_pcie_wr_dat_alloc,	0x84),
> +	CMN_EVENT_CCHA(CMNS3, chirsp1_up_stall,		0x85),
>
> 	CMN_EVENT_CCLA(rx_cxs,				0x21),
> 	CMN_EVENT_CCLA(tx_cxs,				0x22),
> @@ -1777,7 +1795,8 @@ static int arm_cmn_event_init(struct perf_event *event)
> 		/* ...but the DTM may depend on which port we're watching */
> 		if (cmn->multi_dtm)
> 			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;
> -	} else if (type == CMN_TYPE_XP && cmn->part == PART_CMN700) {
> +	} else if (type == CMN_TYPE_XP &&
> +		   (cmn->part == PART_CMN700 || cmn->part == PART_CMN_S3)) {
> 		hw->wide_sel = true;
> 	}
>
> @@ -2264,7 +2283,17 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	reg = readl_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_23);
> 	cmn->rev = FIELD_GET(CMN_CFGM_PID2_REVISION, reg);
>
> +	/*
> +	 * With the device isolation feature, if firmware has neglected to enable
> +	 * an XP port then we risk locking up if we try to access anything behind
> +	 * it; however we also have no way to tell from Non-Secure whether any
> +	 * given port is disabled or not, so the only way to win is not to play...
> +	 */
> 	reg = readq_relaxed(cfg_region + CMN_CFGM_INFO_GLOBAL);
> +	if (reg & CMN_INFO_DEVICE_ISO_ENABLE) {
> +		dev_err(cmn->dev, "Device isolation enabled, not continuing due to risk of lockup\n");
> +		return -ENODEV;
> +	}
> 	cmn->multi_dtm = reg & CMN_INFO_MULTIPLE_DTM_EN;
> 	cmn->rsp_vc_num = FIELD_GET(CMN_INFO_RSP_VC_NUM, reg);
> 	cmn->dat_vc_num = FIELD_GET(CMN_INFO_DAT_VC_NUM, reg);
> @@ -2423,6 +2452,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 			case CMN_TYPE_CXLA:
> 			case CMN_TYPE_HNS_MPAM_S:
> 			case CMN_TYPE_HNS_MPAM_NS:
> +			case CMN_TYPE_APB:
> 				break;
> 			/*
> 			 * Split "optimised" combination nodes into separate
> @@ -2608,6 +2638,7 @@ static const struct of_device_id arm_cmn_of_match[] = {
> 	{ .compatible = "arm,cmn-600", .data = (void *)PART_CMN600 },
> 	{ .compatible = "arm,cmn-650" },
> 	{ .compatible = "arm,cmn-700" },
> +	{ .compatible = "arm,cmn-s3" },
> 	{ .compatible = "arm,ci-700" },
> 	{}
> };
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>

