Return-Path: <linux-kernel+bounces-374935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F919A7232
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491D61F2618B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5C1F8EEC;
	Mon, 21 Oct 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fmiC8tYG"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B71C3F04;
	Mon, 21 Oct 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534830; cv=fail; b=Z6bjYC4Uc/s9sAlTJ6CWhweW3GzGmvtjzGMjRG0JxYANnQJwoaq3Zvr3450NOi5ApSkOuy340y1lV/AMAnwgMSqIxWLiVg/04O5UE2DKRu0RHFb7wrwbM5vFIPSsdn//80eqELiCQhQ0QK9oRioc6VIfjqZZGjW1nLonJ6tidTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534830; c=relaxed/simple;
	bh=geiIU/xvL9WbH5HnFqVRtawBUQEhTr3VQRuWRnK50nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uVXR4Pw4vbUm4Ff8sp9CDNKS1iiOik8SrnMTtNHuG9XhMYmXQi3E73RqBwyqExY9THndy8d4qo0P9C/M0ubwVcXKNr97JfssYDrkgtpVeJaMomeOdiUHdccWNwCPzHj+MsDVbPJyuvCmN0UDAhsQ93AcqrLEI8AJ7s+iRhUELeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fmiC8tYG; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyU2+tJYRQpT3rQmtS3JcYXz57tezrPfqI45jRD/5/6sV4k1Z3Oxf4milPgAbX+HR1kWIpMX+XSXB1wARl2Rx4Stjx4AlJ98yep1R9ZDtXwXdbdC1DNtFMbq7XDFJSqhsKQlmawQMYoV7srgiMwQKcqX13XbBXBXqoYRq5q9jiLQxYQL8D5M1me00lzun37AGOUWkGbvKL9qIzehi5+f3zySs4PH8bXGCcJ/SBHo/UAgUs1Y6qczvTlUsX/QexU3LsZeo/Fzra6tIbo35ecIP9ZwqipOtJBRsyIOfoBWgaB1ZhFtrRChdGZ4c+a7m2fYgmk1pPJ11oBjniQhT9W/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEJYcIwu3T6pbdp40tggaCFQPUCO9sRuAp87tUWUCBQ=;
 b=xveFROWUgxuFiN1VeAcFbLxdFp7uMngaff63xcKIfGo2WuZgLEko/nA4TFA5uLZKbHJXR5k+92dnlgLJPUdB+RsYL2UmlJfx7NsHpqkU9sC25BKGG2lE6f4LfhGlymWsbTVlFa3N9rFMz7TVHg0reQHyGb2/ZwaxaTiTbGsw8LSJjbO4KJyPV0SXA0l98h5m5TO5NxjcNJ76jVusn+Aomu5ShPGJGzFBoZCnEGMj4u1Ru0SdqXviIoj1e79J1T/AjD1ZwmE6CPOJfwlKg0CiN9iKPOgS8qXg8opnP1gOGvhuUHaO5PvLAnXgUFjgbrhynTRpebWZ9QLSiZz1UM51mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEJYcIwu3T6pbdp40tggaCFQPUCO9sRuAp87tUWUCBQ=;
 b=fmiC8tYG/ccLYijZLiJKVYlovTYWQ2mfvX+QcDoyhIdvu6BIFUY2nw04r4mJjrvaLOZDrBLVpzXpMdvIrQgZqowVYfYjWM6IA9GNqGqUGri5FnBygfpLfKYm+jw2SkJrmYeH7gX85zfj9j2WA16Af7JS1J9SkEkV/H4DLIL2hFTMQtBqxd5cn05AkEyD1Dlv4tQvw7GogVxPpOYnLwS15WYYXnEW47HMm0kjMofjzvmOJL0uPdfuvnliBZllY8K6guCvq2dz0aiBg8HFv80U12fvFf7bc0rSB1tJVlOpVzh7U2kH98PgCWprG92skWX4orJl294zCZU81gu8Ec8GHA==
Received: from CH0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:610:e6::35)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:20:21 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::2b) by CH0PR03CA0300.outlook.office365.com
 (2603:10b6:610:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 18:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:20:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:20:04 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:20:03 -0700
Message-ID: <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
Date: Mon, 21 Oct 2024 11:20:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>
CC: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	<linux-mm@kvack.org>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 35069f84-b063-4b53-4051-08dcf1fd0643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDdTNWcxb3A1RlpyUysyeWZENWQrd050VFNjWU1meDdOd2lNNENvMGtLSytP?=
 =?utf-8?B?UlYzWGt1Q1BHNzhseDVQdjV5bnpNRlpqSlB3YkI0NFpkYUNHZFVYbnlxV2dh?=
 =?utf-8?B?WHVzM21UbW82RmFUYjg1bnNwTkdXQmFYZmp2N2hWTzhqSjRnTFVhN09iL0Nr?=
 =?utf-8?B?Y3dzcEpUUHN0b0ZYWm5nbTNldE5KcHp6TXdLc3lHcEY0S0FRQ1pjOGowVDJq?=
 =?utf-8?B?ZFFsQzE4Q25yVEhCdi81OVk5NFVwalNQMzJQQ3ZraGJnVXBtcGxnUFd2WHJW?=
 =?utf-8?B?UUs0ZTB2Q2JJN1ZCQkR5NTBWZGlsNjhBVUJxRGFSTXF3NGZ2MXNESzd3RzIr?=
 =?utf-8?B?UUdsa3lnOUd1RjZXWDQvMGcrN0tnT3RnQ1FQU2V6dmhLaUcyaGpRMExQSnpM?=
 =?utf-8?B?dGU1UUhtc2RUUUwzMWxOQXhjNG5EVWczNFYxbk1uNGozUXRsQ2FDQnYyeS9i?=
 =?utf-8?B?WjBYdFpJdEJpTmZjME1qK29HWE9BOGtmSSs2RzRqbURRanU0QlVpMDNMODhI?=
 =?utf-8?B?TC82NGJpeUJLdnFXOVRDVTlJVlpqZndYazhzbDlWajRBTWc0STloVGFEeEgz?=
 =?utf-8?B?QnZHVjczbFJNMUxMdXh5amRWbHF5Q3VLNG9YQy9oaUNCWmZXRjZia3NnNCtQ?=
 =?utf-8?B?R3B2bnFEbXlzQnQ2T2JHQWxQRmM5a3FQaXh1UFErMmREM1VqSVdCWHZmNmhw?=
 =?utf-8?B?K3pMdTZvU09xeEhuTGtneGdoL3puNGY1M1JicmdjRzgrNXNBUklnVHVwdm0x?=
 =?utf-8?B?RC9FdW9JL2JmaDFLTUwyZXlDY0tiaWNkek04K0I3NmJoVUEyRmo0bTFKSzNZ?=
 =?utf-8?B?MkxNakxpQlZUczQvWXc4TTI0SmlHblVFZWFyQzhwdHNnQkw4Z2dwN1IrMWh1?=
 =?utf-8?B?bGFiaVl6dTRSSllwVGMwZWRPN1hoTGhLdlJwVDd5NTYrRlVBYXA2OWowS1Bl?=
 =?utf-8?B?VzQzWmY4S3lCREp3QVZETDRxaTVyTktwUVN6SzUwOXQ2Q2ZNaWdVemJhNUN0?=
 =?utf-8?B?eDRiZFhYZkJaNzg2bTEwSDlSYkVMZWFmajEvODZDd25Ca1ZLZGlqUXNNWW9u?=
 =?utf-8?B?MnVGQ2R3ZkxaOVd6YTVIQzNjY21CcllCZWwycDU2NDEwVU12cWdaM0ZqSWtF?=
 =?utf-8?B?THJzaFAxY1NIYWFXSDQyeHIvSzl4Skh1Vy9UOXcvdUsxaVZQMHRCdlJTak9J?=
 =?utf-8?B?cEJleHNIRW1Bb1phcllrZldJcklkQW80VllQekFnTGRFZHhyWWdVNlZiV293?=
 =?utf-8?B?K2RqSkJiRjR0ZmxVVjUyR2JwVTNETmV4Y2lLQkowbFQ0cXlHcUgwNnFlUEpK?=
 =?utf-8?B?aTVXUWozRWRqYS9zTzR0VThFTlE5ZnN2QW9CM0RZMFBjS3owU1psNENZYS9Y?=
 =?utf-8?B?TjJmVHRHMUt0WDVnc1NOeFRGWDRxUWN6RW8vbkVtZ0c2UVVreVJoQU0rbTY5?=
 =?utf-8?B?c241RTcrdWk1SlJXdWRsNjVSVzBZL3cyTnB6UVJyS2w1czhOMTBiMHJGWWdU?=
 =?utf-8?B?KzIxc04yRjg1N1RmN1JjSHYzQnVJWWdrOEMrVWRiQnRVZ2thaC9tZ2NnUkRx?=
 =?utf-8?B?WEJTcUYraENjOTUvc09rZG5LYmVRM3Nsa1FKeUg3TTBPVm1UQi9XT1pkYWVZ?=
 =?utf-8?B?Si9zcnBnaGl0elZkYVhhdjdhSmFjRzdsZm1lWTU2MFN0NXJuVGduS1BtZ3pp?=
 =?utf-8?B?VHV0b2dUQ0xkMmwvKzc5TWI4Q090V0RjU0tFeTRIU2pqUGpKWmYzWDg3SDA2?=
 =?utf-8?B?ZTQ1Ulk2YWdFS05TbTZhWkp6a2VwQWswMS9TeUVLUWFWaGJ3UitYNHc0VmhW?=
 =?utf-8?B?dldBNElNVHNGM0RkbG1pNk5lQ3F6WlFURUhxbWFYcWVGSkkwRzJqRmViWlh5?=
 =?utf-8?B?aDFvRi84V0dGaXF4bll3N0t2UTFBeGVoOWhIKzRKQnRUN1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:20:21.2295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35069f84-b063-4b53-4051-08dcf1fd0643
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

On 10/16/24 4:34 AM, Alice Ryhl wrote:
> This is a useful for helper for working with indices into buffers that
> consist of several pages. I forgot to include it when I added PAGE_SIZE
> and PAGE_MASK for the same purpose in commit fc6e66f4696b ("rust: add
> abstraction for `struct page`").
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v2:
> - Make the function const.
> - Address integer overflow in docs.
> - Link to v1: https://lore.kernel.org/r/20241015-page-align-v1-1-68fbd8b6d10c@google.com
> ---
>   rust/kernel/page.rs | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 208a006d587c..9ef01929e7d0 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -20,6 +20,15 @@
>   /// A bitmask that gives the page containing a given address.
>   pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
>   
> +/// Round up the given number to the next multiple of `PAGE_SIZE`.
> +///
> +/// It is incorrect to pass an address where the next multiple of `PAGE_SIZE` doesn't fit in a
> +/// `usize`.
> +pub const fn page_align(addr: usize) -> usize {
> +    // Brackets around PAGE_SIZE-1 to avoid triggering overflow sanitizers in the wrong cases.

Silly nit, but I did start looking for brackets that aren't there, so:

s/Brackets/parentheses/


> +    (addr + (PAGE_SIZE - 1)) & PAGE_MASK
> +}
> +
>   /// A pointer to a page that owns the page allocation.
>   ///
>   /// # Invariants
> 
> ---
> base-commit: 8d8f785ceb21b9a0de11e05b811cc52d6fa79318
> change-id: 20241015-page-align-7e5fa4c751be
> 
> Best regards,

thanks,
-- 
John Hubbard


