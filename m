Return-Path: <linux-kernel+bounces-446924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03079F2AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AACF163A94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F01F708E;
	Mon, 16 Dec 2024 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUYyaUQj"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D61F4E4F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334614; cv=fail; b=BqvLKGtWxCG0Racav5dgICgglWrBBg0vDRw6Uv8l4BAzAY6+JrpzYZGluCfqdjSTcSC76kzn5AGx44bknYA2cIidp2ysJiDiLlSTuVzvwKgF9pKTa89PfTDjuIq7spyK4hfVmud1+jKp7WDcivT2xKiZ4iHyx36SCV1QVk86fOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334614; c=relaxed/simple;
	bh=SyXpAYxglMUxOv9H/S89fRMu4W6QqGnGMadXkw5hEoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3KOeqPMPag20swmjqm8GD1/+1d35EoTWLmE0JBvjH8m7F2PffXeGW8p7xdZ+dv2Rmu6TtK0c3CpLCCOLeg17hIL+cEiLaU6jnLhePdX2dWlvJClLdLwoNMUyw0MlxJjGwqB9QEDT6bUkOBmrt4G/x0EA1L/jjfxdJ0GOeyedE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUYyaUQj; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNsw6StjLSvsJsqEsCyxRXbgatNrrioW5FW0IkUdJACw5GbkO1vlgGmJi0K6SbdjXT5OxhN5u6/waeTnWwcJ3P1oYh2YoYOTj/E87JEcoA8R5BIsyllX3peW3yyBdBPZTzLCxLJNRjZHW6zZSG5xxGX5HFf78pGq+zzpkvTCidZwMWuGvJJeOFwY6jcBYRrW1Qw9R/UBxunhMEqYqPUHXv/Tl8cwgQ9WI4gIfcrz9eMr5/LRWvOemF2CizGd0xNtUgQEVT5dh4vO+yMpPKoOUSb0fMJfy5CHB3BhesYKIKD9YYVHj8PxnvbHC59fRRmyUuigmyqvChtfhc4165ZDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+e/HcUlrq6dp4JFF4sIGGYAC1JOmfwwpY5VZJ35UuM=;
 b=HOTGwuFnrJlbAUc0iFHub+MFNqIQbtQ5aj7+/FijTCjzxB8fDsF4DUdhqmh6rwCgm1FVprruaeuVdmIa6mYdSU3l4OTibSCuMefq3B4m8jogP2e22n4xnxJ0wepYTdq/YhQP0P0Gwtv9oHKxM1ORGQ8fZF5c19NCpYaMwG0IVuumPgbJFj1m6fMkxYCvaze+4Nw8vKrmxui6/BE7x9iG1C+q2sMfMFO6YtyMYFtJY5I2X5tsA3632lE9Z7BRoPeIBcjglvdOEhLcy7RM/wgVw5LDdyMzw6fO4EFMxofBHJd4SHRz3gnAw3cFRQznGiO379HHPEeOhwOTIBmvHPdp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+e/HcUlrq6dp4JFF4sIGGYAC1JOmfwwpY5VZJ35UuM=;
 b=YUYyaUQjDNbWuSe7Q0z81tSIIqvjor3ExYypbafEarkbhLcxXBRlTTDuaxBrn5JrWcInCBKmGCJzThzmOBdTZCEnVBbxvVV9AZ0mCz77u4RsI4O58u0G9L0QSew25EMwldMLJHrk+WdAjS9LbJR+ha+yVYYS1MVGGm8tD0z4l5UW16bHiNcnEXwEFTM+gdAKJsd+YgCguU3hVD4N1oQIcM+9knMaPnFxHcQ99Ip+lHH9HkpLW809tJYFXZbyeE0gYBlhQClIknat5hy9oghNkoFFni6NXmneQKehtZb6vm+Lwq9GuDpiI18fL+ozrK17Bmw/SiQfQ3C7cIOuSkEMwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:36:49 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:36:48 +0000
Date: Mon, 16 Dec 2024 08:36:39 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	peterz@infradead.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH v5 4/6] sched_ext: Add time helpers for BPF schedulers
Message-ID: <Z1_Yh7V_4EEXswkY@gpd3>
References: <20241216031144.98097-1-changwoo@igalia.com>
 <20241216031144.98097-5-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216031144.98097-5-changwoo@igalia.com>
X-ClientProxiedBy: FR3P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::10) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 809ca376-3bbb-40eb-efe9-08dd1da46629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0H2bdzKM019V5O0EsoPVpoOjI+qN4xVN+KShXOqPpLXjOd5P1pko0y2UBeIZ?=
 =?us-ascii?Q?p+CW641ffSYbyon23zFMgoCreNva+8q3ySSG1kQ3oqtQizLcEEDznkHwzvOP?=
 =?us-ascii?Q?mDVpDXiyGiOZd7M1XBz7Hpk4id31FE4QsyGTtHpq9OOBm3Soun90bzUuPmQI?=
 =?us-ascii?Q?A7rHWGNiGEi9Ao9JgnbBfx7uiXzGogQNb0z6YxxlwbGIOCN+ouHwvKdrJHF3?=
 =?us-ascii?Q?8xMmmXO5FprX8LBR+NhR1lvb9hsYH7dM8J4KcK1Fj6gUxpFU/coyhvcLHfnb?=
 =?us-ascii?Q?iJNAh4trfE4me0ISCNhtXkKwQJ45N8sZ/4G0GzHV65jJpiH/xbyPQeCxB4dz?=
 =?us-ascii?Q?NaJ215QFXonN9GaCAO3qJQibHJDkxBGfDNQi5SnCmBGcPkZJhheLq5A70i9s?=
 =?us-ascii?Q?WMTDM4ng9UKgQj6DWbNig4HJMs//Nu2Cvk7qeGapliA6qtfDyN8HeDZDoBGL?=
 =?us-ascii?Q?pF+2i8QCS7YoJI3B/eKLl6pcXusY+grofLPWRlL7r7IQ10WnkQjXQIYHsjzR?=
 =?us-ascii?Q?mvpj47L6TgE/h3K7fDIRzhp2roTB3QdZ1b0+F6Pipnx+G1kWz8OjSxLdpOcf?=
 =?us-ascii?Q?99FfXZKFcEN1xtJQmfnkUxVL7u03eRzxhLCjaLiLW7fQlXFw3Imo6lb9tE54?=
 =?us-ascii?Q?cgkm0UZLUNFKQTy2+wCicWX+4q7lXLHJBC7JLtVuJGgapAzeBVdq/AUHAuMd?=
 =?us-ascii?Q?rRyilOEngdTtbRjF5ErjnMFBUSA5tfgRdEoZnLpXqUMEsVdDu3YLiQA0l8wK?=
 =?us-ascii?Q?eWHLj84ccSKqVNFG/Odfk5Vk4wjf7NT5mF+aOT1Hg4xBg/0k2v7HpJ06rc6k?=
 =?us-ascii?Q?BhGePYF7XJ4A73SUxH8toXflTLDU1GwKZj2p+5W1jJPQkM/AHEeHu4skwj73?=
 =?us-ascii?Q?1o7plvnrUNLlI6qsW4rBniG8Y0Lcpbwobo69sGMsG//7nxpSJTquK/Tv/yXf?=
 =?us-ascii?Q?AU/Pu6JcPMU7Hx7soP9dKz0tSe6Fy93e8HjLLFVp1kOx3v8Z4uUXM4EOAygs?=
 =?us-ascii?Q?DI94e2FLkOBGbqQAcaWq/abnNzqZfNwjAPvddSrx9+3FW2Qe1O2CkVWQtFHb?=
 =?us-ascii?Q?SXcxAG7ZEGM0M/Ykkee8jXH7MYbVJAWhDDEJ6xRaC9WWdgMhKf2RZcvK6OUC?=
 =?us-ascii?Q?08jYfNrjN9cHsJhYkPksRo4MQ4iRSBWTucmeHf/UTw7PN3ighKQgE8feNKb1?=
 =?us-ascii?Q?6vOMIwEyxCOFwPtjiOEs0m8JhsXWpWmHY62Zysoalz1eSReeIl8mrzuDbvc2?=
 =?us-ascii?Q?PpCekiNd3qHckPjxvdPRHA4f5F1ezNNqc74iGTBs9Qg9dFQdlGKHx+ORj3eL?=
 =?us-ascii?Q?Q3JaSyhxYJ/oFLHy+d8Bbr0thFPlUokAwG4PLB7Z9gHI30xN8LI1leVQQU/1?=
 =?us-ascii?Q?VLlF2tzJ9r5Vv1vA93E5iKEcltju?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?icJgTnGIh2e7wF+Ybh8ps8jtikLvpYOjeGhEaG1sjDueYbuBpeb7fWIn5XnK?=
 =?us-ascii?Q?nLqEcipo7iaGWe8TtYbms5yOf2MEyte6zx2BZaLo5vI9fg7mTCPzj28ewJaq?=
 =?us-ascii?Q?RwK76DOKbjHgS7+KrYktFmvHdtiZxEe89MVRXbk5d9BEPxf+RjZC8Oxjgq5n?=
 =?us-ascii?Q?o2Z/cjJN4BZWsk2uZNnZ7aLyH8VMeIa0S4mexyOm/4hIH7P3ZKSP9fP0z7rB?=
 =?us-ascii?Q?g9XfFHg9xXR0Wj4ISumUgKqeclu2Do4mUWkdLdl+doICddB/+bm6DvGmvemB?=
 =?us-ascii?Q?ZjBtZ/e+HsU2xPBJPiKEyl3OqUAGNq+mr5WY1a9nzjWbyTk/KTwojsCUgdZm?=
 =?us-ascii?Q?0Ps9iCJuses0ZDtfs+HZ3KJ/dQzTh8+DN+IIQIKaKQKk+nZlPoo/nexvmRtP?=
 =?us-ascii?Q?1rxSUDD5VjOOK3aaX65wq2/jsu/1cUcu24DxyoAagK3YQRSmLBOzzaoMGqkl?=
 =?us-ascii?Q?cXKUCcw1tf1hWbJSIQxxH5J8X5FVC3hvhS6BOnCjSZhUXa7liwP0GQMBIz+5?=
 =?us-ascii?Q?HK9O+uDdwhn38xcN2rIS1FiKDfKUdaOCasuODX0BI+AkUgYyr+3Z/sUcC5pZ?=
 =?us-ascii?Q?hoGSn0r45JAcXBUrIX/bDB6THFF0QITfR0BrEi1NyKc7B+ElxJcdACikQpf9?=
 =?us-ascii?Q?2mIUUhsk+Pxti1378bwCX5oMhwyTYFZlL/7loLF8Tq4Y4H4bCZFFnQGerTjP?=
 =?us-ascii?Q?4rZEE5G/BJzjhACXjhqdReFdf+kNhi/M79KqRGlXrJAAwUUkVvy8QzGzsev7?=
 =?us-ascii?Q?jktQpkFIpy/gfyR1FM/jFerd2S9Mqn0sdOzr20vE6hWDZv69XGE66k4Tt+8M?=
 =?us-ascii?Q?TPWyM3j5G9z+yo7ZGSyx5P9Bzxd17u/CFh90uLPlGv6TEMQZIElhil1pTmwS?=
 =?us-ascii?Q?hLujzw1HLDrhwAppYbhs1H47e7Cc3fh6KoF2mOOFo7Cm0UEmZtbUP6VtPHM/?=
 =?us-ascii?Q?w9/4fkKq1+G/MxQ3dTBtmAgi2Y0s/crB24f70GBLoaBKv1USnARbYY3TmqSU?=
 =?us-ascii?Q?ptKox16P5rygPr9vseFm2LdA9tJOPYidBoiEAuLyKDU9+guaImKnH/nNiGTI?=
 =?us-ascii?Q?k1F85/SIdv8O6XS54SeLd05mz2efhaZKZDN1P4qTXXktoohb/xgdy5XN6cxz?=
 =?us-ascii?Q?Ch2NMhV83Id7lsY6NXmMTbS7Eo/o85ULxewS0xALrOSrh0j2NkXDB1s25iJM?=
 =?us-ascii?Q?iCjel/Fj7VyRfm/5OF2QfPBYfTlpIhAHrLvmxVVfAK0Eug5KcsgxdLRChwiW?=
 =?us-ascii?Q?IHobtvS1rgelb5vEHVedZspV11El/3x/FzH0L5HW8Zv5yxZXMgQId8Lc8+7O?=
 =?us-ascii?Q?5MB5ekYNTVw2EoXF9naM7zt7BWhaRgVECyPQum8OZis7BlU2/xKgKekbiDea?=
 =?us-ascii?Q?LUDsSOecizx8e6N0FUlTq08BuCtz6qaMuvU/kXxRurbEIY3JCbI0nh1Lh7Qz?=
 =?us-ascii?Q?7Kf1hPJfyH9XSSHVYAFVdK4QQdECwNoTpiSd56xAe7JJy21PutqGVTL7S8CZ?=
 =?us-ascii?Q?gfb1qHMIGWHJn/pHd7AneC0ioQFocbve7kEWvT6U4d+ha00s0ggsxj4NFl6r?=
 =?us-ascii?Q?lqRX9Spc2HVr3i/m+boeL4o/LKi/LnGV74UKTt2v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809ca376-3bbb-40eb-efe9-08dd1da46629
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:36:48.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4RYVfuYrKo5/R26RLnzb6myCPqDS8ZjuiGF+P8z+gp0xllIXLIhb1MiqXTprAnz72mNWjeH6l41K1WDgLpmFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

Hi Changwoo,

On Mon, Dec 16, 2024 at 12:11:42PM +0900, Changwoo Min wrote:
> The following functions are added for BPF schedulers:
> - vtime_delta(after, before)
> - vtime_after(a, b)
> - vtime_before(a, b)
> - vtime_after_eq(a, b)
> - vtime_before_eq(a, b)
> - vtime_in_range(a, b, c)
> - vtime_in_range_open(a, b, c)

Considering that we sync these headers and sched examples from the scx repo
(see https://github.com/sched-ext/scx/blob/main/scheds/sync-to-kernel.sh),
maybe we could have a corresponding change there as well and include a link
to the PR here (as "Link: ...").

Moreover, tis particular change doesn't require to have the rest of the
patch set applied to the kernel, so a PR can be created even now. In this
way we don't risk to get out of sync.

What do you think?

Thanks,
-Andrea

> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  tools/sched_ext/include/scx/common.bpf.h | 94 ++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 79f0798a5350..923bbf57e4f1 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -408,6 +408,100 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
>  void bpf_rcu_read_lock(void) __ksym;
>  void bpf_rcu_read_unlock(void) __ksym;
>  
> +/*
> + * Time helpers, most of which are from jiffies.h.
> + */
> +
> +/**
> + * vtime_delta - Calculate the delta between new and old time stamp
> + * @after: first comparable as u64
> + * @before: second comparable as u64
> + *
> + * Return: the time difference, which is >= 0
> + */
> +static inline s64 vtime_delta(u64 after, u64 before)
> +{
> +	return (s64)(after - before) > 0 ? : 0;
> +}
> +
> +/**
> + * vtime_after - returns true if the time a is after time b.
> + * @a: first comparable as u64
> + * @b: second comparable as u64
> + *
> + * Do this with "<0" and ">=0" to only test the sign of the result. A
> + * good compiler would generate better code (and a really good compiler
> + * wouldn't care). Gcc is currently neither.
> + *
> + * Return: %true is time a is after time b, otherwise %false.
> + */
> +static inline bool vtime_after(u64 a, u64 b)
> +{
> +	 return (s64)(b - a) < 0;
> +}
> +
> +/**
> + * vtime_before - returns true if the time a is before time b.
> + * @a: first comparable as u64
> + * @b: second comparable as u64
> + *
> + * Return: %true is time a is before time b, otherwise %false.
> + */
> +static inline bool vtime_before(u64 a, u64 b)
> +{
> +	return vtime_after(b, a);
> +}
> +
> +/**
> + * vtime_after_eq - returns true if the time a is after or the same as time b.
> + * @a: first comparable as u64
> + * @b: second comparable as u64
> + *
> + * Return: %true is time a is after or the same as time b, otherwise %false.
> + */
> +static inline bool vtime_after_eq(u64 a, u64 b)
> +{
> +	 return (s64)(a - b) >= 0;
> +}
> +
> +/**
> + * vtime_before_eq - returns true if the time a is before or the same as time b.
> + * @a: first comparable as u64
> + * @b: second comparable as u64
> + *
> + * Return: %true is time a is before or the same as time b, otherwise %false.
> + */
> +static inline bool vtime_before_eq(u64 a, u64 b)
> +{
> +	return vtime_after_eq(b, a);
> +}
> +
> +/**
> + * vtime_in_range - Calculate whether a is in the range of [b, c].
> + * @a: time to test
> + * @b: beginning of the range
> + * @c: end of the range
> + *
> + * Return: %true is time a is in the range [b, c], otherwise %false.
> + */
> +static inline bool vtime_in_range(u64 a, u64 b, u64 c)
> +{
> +	return vtime_after_eq(a, b) && vtime_before_eq(a, c);
> +}
> +
> +/**
> + * vtime_in_range_open - Calculate whether a is in the range of [b, c).
> + * @a: time to test
> + * @b: beginning of the range
> + * @c: end of the range
> + *
> + * Return: %true is time a is in the range [b, c), otherwise %false.
> + */
> +static inline bool vtime_in_range_open(u64 a, u64 b, u64 c)
> +{
> +	return vtime_after_eq(a, b) && vtime_before(a, c);
> +}
> +
>  
>  /*
>   * Other helpers
> -- 
> 2.47.1
> 

