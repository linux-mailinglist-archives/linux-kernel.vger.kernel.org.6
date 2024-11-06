Return-Path: <linux-kernel+bounces-397318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E609BDA5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2644B1C22B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123428DA1;
	Wed,  6 Nov 2024 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CFiQqXcD"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5FECA5A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853230; cv=fail; b=MnTE8X5SZXm5QgTaqvON9PnA9PCvdYHzAD+kMByfydPSawKQBVCf4EHN1ZyuFZ8X53DjhbVkheyCye2XlJRVsSxvnOMDV/XQuwfdvGK5+kbN1bVPXkF+5oc4VgjN2SXJ1GdK6DgoLdqzCxSXlw+rbeqwr2CuRlosPR1ZwNVdl58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853230; c=relaxed/simple;
	bh=CJOcCAHlxPKaf/8Uph5t+lzMKSMHyLW4xyiXihTGxdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q+483dw3EcNksglwbPrs66fSwoKBH/ZQwyPt6zY+QZxHfZKN6bk23p9/6dc0qnmviU1JVtyNiCkHTNEwD4hP9xsCAfXVyAnL5FAEAZl11jsR9XXgyTS2xMFd7VSeZXGZQLXCpeFfq0lTB6sWqBnrsn4uFEBwCdEtKJOWbtYRdNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CFiQqXcD; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulGrpPmPiKBAGCJDYgNjByuhNYeXrMbg5O1ttADXGByRJke5rYwLJbJYzOK1yPbf4PlfX8FjgNOcDW6ngMWtF1R0Fdt7YEu/T6ZXOkjqv0xvx0FI0aNA8mz+koKoML+tH9boQHkIUlRXsexE7zRJEYUjqnywMqCk8s9WoUx+3LtvajAnhBtUubHxAJpDI3RdIzDeNTn95NqFA88MAAhN9YkYs/5dfRDPXPi+kXl/yP1UMskEYFZBzHBKWHfQBwdSEo0IkGXzR79Z2Tz4xET3LM5FpUEzX8yVtTjfC+pRBYnhEF6cv4NOb+3FMscKrLNrs75xxrRr2nBjezvAIVScTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyI/nWM9QAoK5kqH2k8s3pRm9a9+BYFslY74fsOvIxk=;
 b=fsxI7jtiXb/VPaFvu460JavAu1QjAI1a9Kaf8ChQv0BvqigPnBR7xFMr8BPEDWpf5psWDshapCaUs7qJ303QDZAt75U8UBNn5DA+8fw4iRMed9HyvR1GxiX7BcglqMJBqDJAFL2+A3/V2hRTb3J69tK2q4cVQH4lHUP27hZgMfCRkdj2lr40gdkL1KhzSXur/mzEORQZ0RwhtPZr799Mps8yaORbq/JnMqVw/KG+Eja2qSihAizp1YhtggR2mnZWuC4JZeriuk35OU6KrYHBPJO85nwXKWDfcme6bzalpTDOyHKqoQZ1z94DqMnwyIvwXMu16eHd5sAYqADblJ/roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyI/nWM9QAoK5kqH2k8s3pRm9a9+BYFslY74fsOvIxk=;
 b=CFiQqXcD0GtDinGPaZXeFNbKX/6JXjLXCsXjqI8dZDACyyxxQRTh2W0hnc8qH/S+EsrSM6zmdJAdjYGAR8/RwKjcLheLT7rI96j4oSASiayeM7hWbHE4u29wmnxFESgHybnUHiOE1HeSWUTZiMoluwSL9K84e6A2PkyUQNWZdYYHp+M28W1fhxU/HtSNjJtwMxgbWOJWGqWP2VflgsZkXTRzweFexLytXF078EnVpt9NvzWgerTEhJ9xcmIItTDraKjCnCoLaMN6+1M8j+h6tm87G4kvhy6yOtXeWzRpRLhfWrt8LNgG/W8FkrlPo4fhUV04QOWIwTf/X50awI31Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 00:33:45 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 00:33:45 +0000
Date: Wed, 6 Nov 2024 01:33:40 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com,
	Changwoo Min <multics69@gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Avoid live-locking
 bypass mode switching
Message-ID: <Zyq5ZELbPjqIQ-Pc@gpd3>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
 <Zyqw9rI-hbxhMqv_@gpd3>
 <Zyq3vmLP4R2WjnmB@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyq3vmLP4R2WjnmB@slm.duckdns.org>
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 92033ac6-5daf-419d-0114-08dcfdfaac1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?azQAczv5fFdNXEYDyCJzX5GLAeRkL7k1W3fs+2n+AL/zLxMPYpX8t08KoLHN?=
 =?us-ascii?Q?+846fAoYAh0FGvrejUHj8ungjGy5p42560lHPhPocdVPfceCGXA/og+00D/s?=
 =?us-ascii?Q?f9CAYe3fFnhN7qIfscVmNwnqd84Ajm0JCBvA4nOywXGdvOMDIdLE0mjKR5PI?=
 =?us-ascii?Q?AsCfT6M2UxrZzwqbho71o/brJQiojUBdH403oAWGFS7WeMgkL+ibQhzrLwui?=
 =?us-ascii?Q?yRTE1dRnahCZycpuastpep7/sGZg0TyElTlxX6wgs/LSPsU0K9jlkw7D6mcV?=
 =?us-ascii?Q?pb6kQiceFa9eophi11msn/vRFpjSwBHNnBBYtoRinaZPqtrm2G5viHKUs4lV?=
 =?us-ascii?Q?zGxxsCKT0AdEYWDdOTjpSyTEJHHj2entALcP8WwgxY0d8T6Tt+Z1LJk1OaNV?=
 =?us-ascii?Q?CGCY9fGA9Ue8DjKIQzSCZ39Abos0urMTn6ihAEOLFu86yoPRuyqQz8hpjiAw?=
 =?us-ascii?Q?DW7Ir37WD17Gs0oHXpSD/rite2PkDhZlIW5/EHxRF5RQLETM9p2FrYiOgf4h?=
 =?us-ascii?Q?z+ewJ7dFcVqC5clhk7X+XyJ1M1hz8eHyoFWIRviEdciCay2efg612cnNG0XA?=
 =?us-ascii?Q?TDqnVgExit61CQPoOK13THoz/0WEB3VAd4+ydm/2spI4vSu4GiKMqEwsrUEp?=
 =?us-ascii?Q?YMxS2ZLbB+NwRJ1XJ6elEx+x1HDIrNSpm1Ft7TV9/gCLvyo68DW3VEe/6gHg?=
 =?us-ascii?Q?+XiuiJmH/fR70Ag59sVYxyPsxVqIX4oTztJbOfwawqp4EDHgB1aBh0Rhm2Tf?=
 =?us-ascii?Q?lrAzb6FMQPztp2S2U2TBNzXMHrW14CZPk8p3yle2hMxoxSf3pbmZrMdWK6Pe?=
 =?us-ascii?Q?OFHMtG81sS32/DJ4QbsEv87ojmMU4KU5dHaIs20Epx01nu7j3eY/eHxHqv2e?=
 =?us-ascii?Q?/qWH6VkTuDHDN/w2LyQe5ELn5669bT7gTBMKUcVDoXKKWWVSBCKEEQLg7/9N?=
 =?us-ascii?Q?KvDwUA1N8gGruu+jhY0C+GQ4htmvBRve2Gva44PVvAvcqKZ85e1RPxtY5+5B?=
 =?us-ascii?Q?erl96PwO0fPQ3tbAkNr7GZSezigEK1jenmKV7nQ3VKOko/nk0Em/gDr0+2Wd?=
 =?us-ascii?Q?tTP5LYl3IECNJ4YmrODiwQPDBPb/HpWvXPrZ1OnPHlORV+64FO/986zaPbpZ?=
 =?us-ascii?Q?C+Mm7e7I8922W0YOKHWyKjMB5/eCFvp6R5laT0GoUTNaeak9vbYlsShR7c08?=
 =?us-ascii?Q?fdtimiaVUFnGuXSJaWUiy/ysHAFcOdKwqrqXgaCCi6aM7k4x3C8qslLWkiyA?=
 =?us-ascii?Q?31oV+x0nxW3hElTGfm9FSG2cJC5dH18rPgD/H0QZvn3LKEC89kugf587CD1A?=
 =?us-ascii?Q?CoOBsoU0mUQ92b+PDlqPwZcH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4X3dVv1tSUoD20dFPwQoUEkgR5mNmmQDM3oe5HonoUvMDnN66LCGsfPMl0R1?=
 =?us-ascii?Q?b3wHT9UXGNEBLs2Fbip16udVt0GmoJGkGoQWJuy1Y0ifLVMB5foSc6aczGq/?=
 =?us-ascii?Q?AHpPyTAPxq+VSGXKkmnWq/nKEOq3cte3XtFanuiFE34SlNR6egO4SWdY5zN0?=
 =?us-ascii?Q?qWMMZRRu6R1xgm0NkprwvC7BVAGERK+vK58WZ4K8WyPFNhsovFAQNFdqymdT?=
 =?us-ascii?Q?D4i0qpLnrrrnzaTW0sEb1USwvNeVr95iZzlk/RCEnOqILddxdW+cRVeRgCTK?=
 =?us-ascii?Q?pRbol1NONIoMlyv9wWj9sy6LwrKjNzynaaFkjphHngCxACDZemVmjWX6qqe5?=
 =?us-ascii?Q?VXoHt/F5w057nJ0CLd/8zJ9dRI5piOom3bqzeUVk4IxVxzJ+YklKQ+8PxdHN?=
 =?us-ascii?Q?uL88Sd+PICDrxZq4dOOdJJKnmJwSXsa+hE9a84NhfCcLFGHlRu3nONgJCwfo?=
 =?us-ascii?Q?s/RGs80x0wKeCmcVzwMf6r5LDkCmgj/s386iy4mTPEjw7snbAp87rYdzgfZ/?=
 =?us-ascii?Q?1AtGZaHtNUjG8sgpSXXuCOMinQmbyAKMK+n+dd11hhpYimEghu9DHclcIj6y?=
 =?us-ascii?Q?6CnzEG1ww+TT74lvj8bJGSLlfeOj9QUPzzFB5sjaoAQFEO//NIHH/Djas5QH?=
 =?us-ascii?Q?dzQfeW9FhRrMWM6JqFo4hFMjKO8oIGN4oIpg7B/ptN54RUoyj38mrSJq7KFJ?=
 =?us-ascii?Q?bgn4dR7p3tyi/BNI8bC5mVeotifJVwjo1+MeYMRT+qRkFdYqfEWHcXBUE9/6?=
 =?us-ascii?Q?YM5bZeUc961dFXOJkSuwD+qfMpc16zKmRml+4zUbHznfv87hsaPEu2WTAxh0?=
 =?us-ascii?Q?Azmi6819nDDt0GxcLN4AiRB62fhfsRWgP4E5OpOJgBcN7bghC1nVfNj2u58i?=
 =?us-ascii?Q?W/HvjM71KuUwiTeambOMERCAN+DWVc/kCJuMrIkCf/Cl4TCvbnsf4W+f8q2r?=
 =?us-ascii?Q?X33ylZurWRX6ewhusDInC2zDeBQdvAgjql0dKnPHlEdFN/u31WXSmx4BQRLP?=
 =?us-ascii?Q?/FgeEGA1Wh2N29TUcHFELgff0RId6syLMANN+qK6aUcxmu2j6beoghEgDIu2?=
 =?us-ascii?Q?/kralIU8E8RPG4+YARbyoB0Y9dPejXAaPTgYxaZ4U5j4esPXs6iLd6jX1p2+?=
 =?us-ascii?Q?pcRJ09ahUKnI+q+x0k9oybdfevqw/tM0jrlb2e61utUhTDdvSAbp5urcwFi2?=
 =?us-ascii?Q?w0iuDFltfz1Shi3dPyaUnIEqpRnhbqfNqN1gQd177xl7aPbgHC1Ty5OE+4H9?=
 =?us-ascii?Q?yolYXCxbXUM9iuXvBXCalZqLgfRNNWurZZj84ukRh7ePLAi4shJwicvZFJ17?=
 =?us-ascii?Q?h3tL95q0ieY4SXHq5fVJ32JbMMpsctAqiql6GxKjSnNSN6JjKJoqI0Z5Qkzf?=
 =?us-ascii?Q?/MS+F2e8oiDrrzIcFoWRsctsSKfi7CI6l1e7XvQbiUvh38+W8TLf5J9TepE9?=
 =?us-ascii?Q?M9+khbYb6L7zW//34g7BBNEcpxQ2CRkgu8nPnFvd2pTZyPq9FOV2vQvTwRiO?=
 =?us-ascii?Q?fFI5YGMVxAljvSF34EzVgMX8LqkoYUX9KSwb0aJdQrlZ/V2cD+uw0S62Ojbs?=
 =?us-ascii?Q?QcbGuzL7TbluXyoHJIQ0HbqGDjFdvsVwxCVbq7Q1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92033ac6-5daf-419d-0114-08dcfdfaac1d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 00:33:45.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvLFZAzmEc+KiewtLiUazsu1kMXv9LJ1t0Xeb28FqmT8iaBarK51sfMKHe7LXNz7M1LYTHeFZlPah0Ll+6KReg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

On Tue, Nov 05, 2024 at 02:26:38PM -1000, Tejun Heo wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> On Wed, Nov 06, 2024 at 12:57:42AM +0100, Andrea Righi wrote:
> ...
> > Do you think there's any benefit using the idle injection framework here
> > instead of this cpu_relax() loop? At the end we're trying to throttle
> > the scx scheduler from hammering a DSQ until the scheduler is kicked
> > out, so we may just inject real idle cycles?
> 
> That involves switching to the dedicated task and so on, right? When this is
> needed, we can't even trust whether the system is going to make forward
> progress within the scheduler. I don't think it'd be a good idea to call out
> to something more complicated. Also, from forward-progress-guaranteeing
> point of view, cpu_relax() is as good as anything else and this shouldn't be
> active long enough for power consumption to be a factor.

Ok, I see, we want to keep it simple, because the CPUs might be
congested (like even from a hardware perspective), so in that case
cpu_relax() makes more sense probably.

Thanks,
-Andrea

