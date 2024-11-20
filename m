Return-Path: <linux-kernel+bounces-415821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5AE9D3CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86593B2836F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A501BC068;
	Wed, 20 Nov 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R6ZPoPLR"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2F1AB6CD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111184; cv=fail; b=a0+2LSLwivk2l3O4YCVadsLDvONTQUfYeLI18p2yhhAhcFmBpktHdROitQB6k1hjCxy09PgeP9u4bQjgmgWtbFDqsHuHx7TNxZgozFb5yHI+ATQGjlbUT6zEqfoQL6mtT3Ccqu53RfwGR45DkpowWqVotQxHgQDdqH4n29zXmm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111184; c=relaxed/simple;
	bh=eOYVzM0nVmjI5ofThSe+DkfL3aSvGeGvYrQ2ESPBIgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sGukofeeXHadedWC41kwklAnjSQRvxOr0qxDTvFAsjdMT/pMVk5xGX8Wk1mivXEDJ4fzZf05GnM8TJfsEMrit8mgig8EqA0lgDPP8cKbiz2wRykjn9PeNysmy4iI9dkeBLyJAGDJHnpjw0xYq4+6/scHhhT9FfKBK95/lAkUMyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R6ZPoPLR; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrIW5jy1Zf/toSKScapyIPov+Oevi+1vVzFUPLm/IUPxClt3N7ASi+AaifEr6rkyEkNnvzQP+Mt6KK8eK5pqURwYLE0ggEtcSesgsCpzFchPDqa+HmaaFVobUc03q2oKIHUogdGK7TMKE805djYn8IxT+VCRN8mwlM6hpUF92FMtWYr4vHPvZ2jJbqAbj6UZMhS/kvYLgV1kZEqLnqalp0tY+Nww275yiSmb495z1eSg6Tir9neh2OKRHiAY8vWv0v4oyZR5qsJo0EXe453pI15H9jgPfGa2DecUMRizLHqhB2q5ROHvtBlbyhCeq0ts3hh+AV/BLSuEZKgkyhgZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXPcspAiPOp/DT1zt3HiqzscEFGcUepsGZQ8bKR4jiI=;
 b=qhAxzs5mqKLoDuZ0XAsmuenuwhjAWmFbgZRdzfYmXrVwQpt1Ju+rSvte/963YPU9hjSSRjj4GIcQR9KZh4vQyrdxRlJrf0B3AhqcWvjwvp16lY5lunYw4QLHmsWnRpnke2fdcGuHMNOCzhMukCZ3G2aMiyAXecSx6z8LFIATUvw7w9V6LdictkXJyU4mmFJkr+mZbrnDMVRlycm//coLwuInFVVLJvsVHSDD4kzaBOxxjC1J/ZM1wKYn2PLhdg/PUlJBH1pwVcSxAHGep1qaGaUp0euLDe0eNZ/YEt8249EWIN/42mqnXMKCarnXbvs21Lcv1sx9T9+jgVarIu45pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXPcspAiPOp/DT1zt3HiqzscEFGcUepsGZQ8bKR4jiI=;
 b=R6ZPoPLRKxeuQ5pnHYUFE3IeAIFgNXp3Wo2IpAPv35o5REq54cKuMbwkS4+5f3YQq3WKE42kb/G8FMmHdhWjbcrTuToBk/aqN9xl2ne2QeVlOxzxNMeSqprz2P/8zaEudX0ak7KC/N18PHDAscEcsjJ98gTyL3PJvfefUUDRJgWIIP8LbXFf1HeF6fA9hkBDjz4sDNqCGVDYQJ3SuxEeJ3gG/xHJhvYZsOuZIvq2SeAhBExJXvSSw9D2gMJxdNRJRi5b8rjSrjuM/hfDjO8p1Gyid1YsZtgx5ulaOQMWJwMHWuHC+9/qUtqVFO2sJtpVg/Xl4M/dLZWP1w8C0RgMZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:59:37 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 13:59:36 +0000
Date: Wed, 20 Nov 2024 14:59:31 +0100
From: Andrea Righi <arighi@nvidia.com>
To: guanjing <guanjing@cmss.chinamobile.com>
Cc: tj@kernel.org, void@manifault.com, joshdon@google.com,
	haoluo@google.com, brho@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: fix application of sizeof to pointer
Message-ID: <Zz3rQ3SoxPr4h_vV@gpd3>
References: <20241117025129.159014-1-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117025129.159014-1-guanjing@cmss.chinamobile.com>
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b43523-3e0c-468d-9101-08dd096b919c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6oiLilSDZhFBmYMVAzp/CGmA1bE5oLEb0WIKxWLhaqcMCekJ+23TIqKDJPI?=
 =?us-ascii?Q?5DSQLszPvGuUfDoVNsh1QzESsDPIc3vV8lEXH6w3xoz4TUXwcuCKsT8nIu88?=
 =?us-ascii?Q?jfIl3M6TsIwx4CkUz9lWoJU3QGV22TZqN8FbuC9tDWA6andmCH0m9llbx5hJ?=
 =?us-ascii?Q?vKkPAvonMyQuAfJEKx5bhSbYBZ9TxSx7xZNBdhgFeE5Q+i0Q/5HaHGdyg6+O?=
 =?us-ascii?Q?5C4SeZwOL31+5hqeOh50TJM8QQ/pShsIbNbDceqcVkARzBE342GR0QrPCCgZ?=
 =?us-ascii?Q?w12mG9KVIP8jfCgFAcBzY4auYLR9nIMvG2CH6DTZuuH2pRkFU3VjIh8MQWkx?=
 =?us-ascii?Q?286xlcFdEWaEL6GmgxE/bOb8rRucwtEpBXU9Z7didDpEB30mWTfkJi5VjeNN?=
 =?us-ascii?Q?KjXbMhrRMHADCDhjXUMZg4clKF79wd7IWgNa8aKzl1CroazE0CV2XGithp7I?=
 =?us-ascii?Q?pxACzmEuQWGnhWoP+RNyNNfjAB4RV30oRDBkT4zVckHAZuYRVizQY36fo8Zl?=
 =?us-ascii?Q?zgkUWI6ZyajFq9JVniH87OUNnaHdFHz2W3kmKKXgpbODQPbUQLafHy+jms08?=
 =?us-ascii?Q?7HfEIPcYnJ8uzFPuZqt+DrSbVnP5B37cIjBhUhsyO06tAFGNzeWZliOzZmKD?=
 =?us-ascii?Q?EX2hhiBk3dNJyZFfYTCTN0WAOIVNTbGGqytvEqEsFvbj4ULlTLLERnvu+r3+?=
 =?us-ascii?Q?syYcVlpQpnUNnkDkZ+MFKLKtdWv8jNKOpVEyapE4ZviC/RYZoQ/DIM9gfSUl?=
 =?us-ascii?Q?AAeZ76++a6IQI3KpXjpDu7CTvxDKrEG8v0rSBhy7UOZD45Xc9Wg+ekQgOjAk?=
 =?us-ascii?Q?JWfd1EDOnj1+yUQR2+gzlteQ2UYSYOvRhiJfojZ+1yqkierBEtL7rVYQeohj?=
 =?us-ascii?Q?MuY7Mwup8Lohyk0fgHB4noH0/61vkyQ1zyRDL7E9pGddK/5jrDuGjmC2Hd+M?=
 =?us-ascii?Q?bzBa1gjW8eOD/SWMjj2nwdADVao7qiciVAUWNC1ViztJf5TnxNTPz9ftmuI1?=
 =?us-ascii?Q?Z/V2CbN1umKd1n/yZZRP1u5G2cBaTLT1SFlKfnh/03N6s7ZOqqjkreZS7w0Z?=
 =?us-ascii?Q?i7Pm/z/uTK/JcEVV1vIw6Bw0DAiOz3UA+2bYly5k7VTqq9hDTZ7yA8lXLEVj?=
 =?us-ascii?Q?khxA7Yg5umP7M6vJf/+2r4Ysn4w3nsHtGwQOk5DcLBg/1BFkyHVICvgMILqQ?=
 =?us-ascii?Q?Q7lt6Wk8dIAthfkauQHLtWnO3+KnK7Uf/3PNZxCYpdjnfTXZw7H73s9RKa/E?=
 =?us-ascii?Q?/VTj8F+R2i80kq3q/Nc47I0X4D8rCrMnIdKheMLqvqmswl+JQzKUbcU2p5uG?=
 =?us-ascii?Q?POceuntl0GSjt68xRXHt4WbH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJpHo/QNRaijs5VP/DiyWepk8TZPqtOQp5w5GY0eBcdUP3Bq+gbOQFHwSAd6?=
 =?us-ascii?Q?CDHFlNG2cHk5ER0yfsqvVAdszHOrZmHmOGr4i03zgSPDjlARpcFBxZU/WqH6?=
 =?us-ascii?Q?sIMm1gVpPIt6QSa9dViTiPGZExKYOYC/fGv1Moyz+EGtS5B1HVoL5YxkoEsM?=
 =?us-ascii?Q?inWWRGRqZsn84YS/nKDTWTwQLdCNJggF3kE6IujkeLjv2fF084axWLZZ8cgB?=
 =?us-ascii?Q?OQ4x04/iCiRvvXGZBc/wfSSlH79aIpsEza/bbfiZrAooCeTgXjewLkGiE7wp?=
 =?us-ascii?Q?b1Mb+jH6QY1Xe2/mSnTJsu+6yp+NSH0o++sRED5SqH4vs5uzPMytdWCHo04T?=
 =?us-ascii?Q?dghOzkcvVSD4Et7SfILpNs1BgKDsNNYZgxF5DUyClCxiV9zVv/Izoj03Bqef?=
 =?us-ascii?Q?uQkR3qdGiwLBeAx/o7DYL1UrOJDQoMw5gEGoBA8HmK4OPZoxtpn5KdIuorvI?=
 =?us-ascii?Q?nqRPaYs2Hygu7P9tcoNkWabkSZhTHX3d+FDamzvDSocOxenL+inGM85o3g6k?=
 =?us-ascii?Q?IQ+bb5I47rkfkNOEGFNql7FH92OJxqMOI7CmIK7pwTSmazVJK3yIwotZ44Tc?=
 =?us-ascii?Q?7VMcFt+vJeW0T5Co/w1xpmi0PEBRuiOIxmjAIhLVV5ZVUKAvVUy5RnrZ4QP3?=
 =?us-ascii?Q?zbljQHH/QKcmc9rqmx/n3ZxtmsU7NcaMQxZ0d3ofo+3kDSFl+tGzAtKlvoAv?=
 =?us-ascii?Q?G8Q0hrkgzElcO7XkoQob+zAdBBEfz0MnLrLy3CcmUcvLDE2RwtQhLN5RffdE?=
 =?us-ascii?Q?LJdF4YL/Vgsimytb6Jg5wHn8pSSXc/YKFWbQCP7PY3s7a5Q8aLHGtZpKeDbn?=
 =?us-ascii?Q?ns9FwFJ740rEoOlL/sL5BoLdm2ycYNh1x0kUAtBjReLnN6WkWtIqpc59E5CW?=
 =?us-ascii?Q?mu7iGxY6kDIJ7/TA+BeVB0I8A8NOlhXH7kWA1XSY6r1oerYTN/vstqtwtEMt?=
 =?us-ascii?Q?TTRpyO1JOJ6Ok/T5QIohqaTizWAzLtCg5gm7B1+Aqz3duQ76AepDax/lhVRU?=
 =?us-ascii?Q?O7i/SHXAysHdxsmqqcMnmpvGwkwnwvDhvGA/rfWSnpd6bARtjNuSeLOeQG4N?=
 =?us-ascii?Q?lKjsNgfKzNGXTQ5iyme93767eAWr2/74njAKnbESn4/cGT8BHkrf8qDQ8Mod?=
 =?us-ascii?Q?V3/AUjWj3SRAJu2YfoWhV4lPjFPXXIAexi5/r9LQZqRpK4dw5VEI3WSxFYJh?=
 =?us-ascii?Q?lk9NbQYilx+TfxkEU/0gNxoc2mSYftzyl6a58Nrtoyl2KscnlesOSjLEax6y?=
 =?us-ascii?Q?vMfc47U2GV+QLjfngoJkCrKtk/TdVJWRZ8D84wYnb5iN6YiQXqsjIpr+AxPj?=
 =?us-ascii?Q?Ri9j4RQI7SDOJv0zOR7pPewL2WyOVDr25ooDf4d2zaypw8KYp4G4vm3HCCz9?=
 =?us-ascii?Q?640uLCAhrlguM3wm11wWoMHiWm06JnGb4JajIz/0cF69rW0u/dsASqOgHVVU?=
 =?us-ascii?Q?MIv3D/U5ZirsWyjxuG1hFXe5DMJlfr9ez5C2Hr64ZZ2ptJ1JUgl52V1Nz1gJ?=
 =?us-ascii?Q?3XworbEuSgBYMiT2H8AxiphdPPn9pmHyXq/2v+2Ok706Uw7P7YbgqDUDr0Ko?=
 =?us-ascii?Q?5eQ+beoW1lFArryqYvBdavnPUr6eUIrQyqZFUg26?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b43523-3e0c-468d-9101-08dd096b919c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:59:36.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oS1m6OI+5BNjL2aZkf7RWLOq5EVs8kZNt+l2txeXNWZHBWSfXwavJJ9JfIm0Y14IsCPSsI1WXpT2YAX6uI25A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917

On Sun, Nov 17, 2024 at 10:51:29AM +0800, guanjing wrote:
> sizeof when applied to a pointer typed expression gives the size of
> the pointer.
> 
> The proper fix in this particular case is to code sizeof(*cpuset)
> instead of sizeof(cpuset).
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 22a920209ab6 ("sched_ext: Implement tickless support")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Thanks for catching this, it looks good to me.

Could you send a PR for https://github.com/sched-ext/scx? We usually
sync the C schedulers from this repository into the kernel.

If you want you can add my:

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_central.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
> index 21deea320bd7..e938156ed0a0 100644
> --- a/tools/sched_ext/scx_central.c
> +++ b/tools/sched_ext/scx_central.c
> @@ -97,7 +97,7 @@ int main(int argc, char **argv)
>  	SCX_BUG_ON(!cpuset, "Failed to allocate cpuset");
>  	CPU_ZERO(cpuset);
>  	CPU_SET(skel->rodata->central_cpu, cpuset);
> -	SCX_BUG_ON(sched_setaffinity(0, sizeof(cpuset), cpuset),
> +	SCX_BUG_ON(sched_setaffinity(0, sizeof(*cpuset), cpuset),
>  		   "Failed to affinitize to central CPU %d (max %d)",
>  		   skel->rodata->central_cpu, skel->rodata->nr_cpu_ids - 1);
>  	CPU_FREE(cpuset);
> -- 
> 2.33.0
> 
> 
> 

