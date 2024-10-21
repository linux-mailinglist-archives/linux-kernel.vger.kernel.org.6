Return-Path: <linux-kernel+bounces-375046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CD9A9036
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DA81F236C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217DD1CF7C3;
	Mon, 21 Oct 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i08p+7mE"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E21CC152;
	Mon, 21 Oct 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540337; cv=fail; b=fQfzUuHK0zjmzOhRC/1Jo79bDhuT8f0FtPqKxoDUac3oqFJtOU3Gg8SsVNogYy6Hjn3QPKQZNaAv99ZBgcmYplXhxuiWR6o5JNQJZ6NhL1z3ylRuulMx5C77KIuii5QICbfDcwaTrzxF6nB6RszhmI4wX/ig1mtQ06MaIruA0og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540337; c=relaxed/simple;
	bh=Mmvloji4JwPp15ilrivbp+uXBtbWq6dJd+yqo24uh/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FeMHQJMuqFT0M8Z+60xsG1V0atSMM+WGswWyt05COLZNPD+yG4alhTuY5rbfr0I9K9SscyhoFOYDrnlHmgOvD1e0SeoI+CXwxwoOYXfs2nGwil2gZrqDVEaLuIj7ZbVePInhmq0WrdgMZg2MoCv4k6ewWp7Edw6UsV4zaaAgPaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i08p+7mE; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJMeDrNBf7InvFHxdQqQSG3/gJxEv+WMkIfjC3ZEnivmhnyghpOX07Y6wRxCDfzTB1GHJfUpqop2GdPZlcBqfVzZ+rK1ZWCcAUAAEYfsIvIinqjdcgjlIug+9379cTvNzHh6m8EaK5Tmjc8qJiBQsQ4IGH2I+dYAOPR23V54TjfcxB62aKV+6WFZpYLHE1QsDKQ7mioIE36h+RuaohhdV9eW/SGRGzeTXwJNi+a1J7rTczoGcfOsid9obSV9VEm3enSgQgzMFmdQxvRvSOBNInsRBo/bauwxGY6Pufptf5ULo/GccyqDGtEDhQaJ/wX5P7idUbmpQefMTTMThe7eJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+AligqO/KjBVIYzXyITw53MPFiEmYDFy35nqilTkKk=;
 b=D8Sj1VPcg1ULcXjnklltkh5NNoeMLcrUVDFYxRjLv5JPq/7P087mmvfHcMCSi8q3mHaEnqleqKQM6ZnblpkLBXdxEtiat7+OezG/QChsEfo9+wSpkxiwoAtFwx0Ogj36AzGM0+E9Xo7ZZuwvZbXRisdyQx1QCBh1bfW9ESHKjVrUVmccyH7/Wd0m8ZJG6ymr5+VTnTouLsAFETMcNX3QeCngHq9CAiYP7MAdCkEpsslVYughnzAUbK7QMygQET2U8K/8z4/leC/9WEmZX5SfbGCmMNVN8ooFX2UgRbMt/lVR/wCYB1HnwuKukqrhJ4lmVbR3ds/S2RPvHYZdA5njDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ryhl.io smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+AligqO/KjBVIYzXyITw53MPFiEmYDFy35nqilTkKk=;
 b=i08p+7mE6U3Aexdyfi0WbmCRtc1stHJ91uXgg/IPv0v6XZJ5UeTBlrMQPYcvkL1MbHQ3mFAKf8ml8UwZTm3TUBs3hJ5m2Tjb6I8PUzPgzs0xu5hWr0qFH7DDTExZF4GPNxcTRu3/trd7CyeLzCbgraU4elDGLjWnodvfEUsoxs+WqKa5wnkDFwpUogWaoS5Twp9+Tc1mtob143OSUdEirNIllB0O5mg6mJerVxF6e6TX+xtBpe/UmHi46nNZgTw8wGkB2MUMIkgV+RzbgG537bf6etK8fSkggI/2tvPbfaNRLR0TyGgmADXtMW/lgdr+5ozJ3yi8vXa8VOnww8NxuA==
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:52:05 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::18) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 19:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Mon, 21 Oct 2024 19:52:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 12:51:45 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 12:51:45 -0700
Message-ID: <41f8b0d0-0ef6-4883-bbad-52e77b13700b@nvidia.com>
Date: Mon, 21 Oct 2024 12:51:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: Alice Ryhl <alice@ryhl.io>, Alice Ryhl <aliceryhl@google.com>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda
	<ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
 <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
 <CANiq72mW8seB=938XZM7bwdSU43z0eePXinE5QPYyybvNfbUeA@mail.gmail.com>
 <dc5e7653-8d6d-4822-9c29-702ece830717@nvidia.com>
 <CANiq72kuQ-fNTYw33czgN3_DYjixzk01+hahFhR4QSkENeDBkw@mail.gmail.com>
 <b93805c1-28a6-4ad9-b0d2-5116ef4b0d83@nvidia.com>
 <afc139fe-ac03-43e7-a5c0-22410f1acea3@ryhl.io>
 <682c97a0-9877-4e31-b180-c1e38d3bc883@nvidia.com>
 <CAH5fLghMiNbyD-As40Rz+eRzxMVdX9TXwesxN7cbu-iW2bZJpQ@mail.gmail.com>
 <7d708e79-1a94-499e-a0e8-c3431aeaea3d@nvidia.com>
 <d9b79f25-ae52-4cda-86d0-d4cde9338644@ryhl.io>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <d9b79f25-ae52-4cda-86d0-d4cde9338644@ryhl.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a34323-0053-4272-2692-08dcf209d689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXAxMTF3aDRNVTY4M2VreXJFQnV1b1lDNVhaQUlkTHhJTGZQbGs5NldPblF3?=
 =?utf-8?B?WG5ieWd2Wktwb1Fua3NEbG16NldrM1VabUc3cEJNUEhuT2s3VVorQmZOQngw?=
 =?utf-8?B?RFdYN2xuamU3MGJFbEdWeEkxaWZXVHJsZjhhT2o4T2gveG5HaG5GZVEyQ3U5?=
 =?utf-8?B?Ly9IUUU4b1pCbWhwMlZpbURuN1ovU0FqdnBKb1JLRXA0aXBSeXBpYXRteEly?=
 =?utf-8?B?ak1iS2xDZzVVbUpEZkVtdG5jbTM3WlZ4VFBqTmtWTkZDWXpYaktiaTEyTDcy?=
 =?utf-8?B?ZVF4MXl1NW95R0hXNVU3WllMcFdyOVNXM3BpRjZTSVc2dDhkeFV1bWs4enBR?=
 =?utf-8?B?RUUvMjc2VTFJY3dJMTRjR2NiRGRVcVJwVERQSnpzbklaZS9iSklQZGhxeWRs?=
 =?utf-8?B?cEZPSVBhYTdMeFNzcmtxaFZTenkyUDI0VENHL2l0R2FHVU5EVU8wcXZxQUlK?=
 =?utf-8?B?T2ZXcHVBSkQyMlNaWlViZjF0Y0M1UzlVd0ZWSUdHUEZOM3piQ0pBbG5RSi9l?=
 =?utf-8?B?NmE4eFJyeURDNXpaVnFuQlVBKzlObzBmcXlPbTU4c2VLcng5ekY1RkZnd3l6?=
 =?utf-8?B?eUc4MU0xejlCMWh0ZE04UkJuRENGcFBPSG5VTDRHZDN1ZnpocktrMzJibGdx?=
 =?utf-8?B?eGY5cXpKaUtGb0UzU2NuT3kzMWhNV0Z4UDNwR1JWUE1aOWl1SFk4ODYrejZB?=
 =?utf-8?B?UElhRXZVMWpMUis1TzhUNThaUUNZbkZQQndUU3BDbmJ3cDI4Q1pmV1JRMnJZ?=
 =?utf-8?B?NXJnOE5FNGlDTGhXL3Rqd1FnRThCV2RxTEJmMjVaakJITUt4VnMza0JsSjc2?=
 =?utf-8?B?eHVUcG13UnlnSEtRZFpDSHRwQndXcS82ejJVMUt6UlluY1FHeWR6cGwrZFBD?=
 =?utf-8?B?UHhwUjZSREJHWVYvOXNTWHJqTlpkVFJSdkRtWERxMTl0R25xdCtEcGYxNTkv?=
 =?utf-8?B?TlgzY0NSSGxJZkx2cE9FUVB3YTA5dHN3SWNEdGl3cXNOZFZkbkNXTG1OeHFY?=
 =?utf-8?B?aGNPQjVoWHV1ZG84c3l1bFNNNHBESk9tbWtjUCtFSEtLd3o3TWhPZUk2WERp?=
 =?utf-8?B?WFNLU3h0OHNCU2tNTCtDMVJISGVRQXgvK2MyWGRualJSZnIzNU9tVExjY0Y3?=
 =?utf-8?B?bG92OXMwVnJMU2RBK1FzbFZKK2dzMStSYWIweS9Cdkx2MzNjNndOTDF1cDhn?=
 =?utf-8?B?M0VDOG1ZZnNRYVdmYjAzc21NemxtbEdiTVh6bmd1Z0twVlhyMWttRitVakR5?=
 =?utf-8?B?SWFubVo1OGd5MTFlQm04VFFXUy94NWZJWHVLSHkwSUE5RGtvaUx0T1ZFb1NB?=
 =?utf-8?B?SFZxc2NXUGdOVXB4TCs5Y1VzNmExanV1UFg4cGNleVVWTi9IMGkyK0puMXpQ?=
 =?utf-8?B?ck53Y1YwaXkxSzJMUEt0cTVOd2N1clRHTE9KdkoxRnhvMnV1MFlzVi9zaWZr?=
 =?utf-8?B?TlBZeWpXa0tLQjNFWmJqUmJ5TG8xbWsxZDh4eVRjRzRrYlF1MzVFRUFTYy92?=
 =?utf-8?B?UzY2dXkvVW0rUTMxV29zbnUzV1F2bzBPMlUwNjNsbVR0WDVtU1JyTGZYdVo5?=
 =?utf-8?B?TDJmT2NKS0hPaENXcGtoSVJrbVV3elk4dTAxZTZ0ekV5Z1AvZWJjL2g1Z3o0?=
 =?utf-8?B?emF4eXJpZ0lpRkx6RFFEQ0kreHI2cnNRTWtSNVIwS2hrMXNzWmJzbnFIYVJV?=
 =?utf-8?B?czhSNkxwMTNlTVJLa0ZibXk2ZElaRDZqRjlrR2JlOWtwSGQxcXM4Sis1ZU1q?=
 =?utf-8?B?MmpnTHBaSlprSktFN211bXFnZTVaR3NvcmUvbDA3STVHQW4zUnY2QXFiZW9J?=
 =?utf-8?B?ZExSQXZGZURqVnNEa0NnMGtJMFZFYWhrblJWTkVsK2oxMEpGVWQ5TFVJaDdS?=
 =?utf-8?B?WkFkWVhOVk5rakUxRGNlR0lla0NZb0RXcEw4VTNJc3R5WEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:52:04.7395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a34323-0053-4272-2692-08dcf209d689
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

On 10/21/24 12:49 PM, Alice Ryhl wrote:
> On 10/21/24 9:34 PM, John Hubbard wrote:
>> On 10/21/24 12:26 PM, Alice Ryhl wrote:
>>> On Mon, Oct 21, 2024 at 9:09 PM John Hubbard <jhubbard@nvidia.com> wrote:
...
>>> Rust macros can use different types of brackets. For example, the
>>> `assert!(1 < 2)` macro uses round parenthesises, the `vec![1,2,3]`
>>> macro uses square parenthesises, and the `thread_local! { ... }` macro
>>> uses curly parenthesies. The round and square brackets are used for
>>> expression-like things, and the curlies are used for things that
>>> expand to top-level items such as global variables or functions.
>>>
>>> Macros cannot use any other delimiter than those three. So e.g. <>
>>> wouldn't work.
>>
>> That answers my implicit "are there any cases in which you would
>> want to collectively refer to all three types of...bracket?", yes.
>>
>> For the original point, though, we are not in a Rust macro. Is it
>> actually allowable to use [] or {} here:
>>
>> +    // Brackets around PAGE_SIZE-1 to avoid triggering overflow sanitizers in the wrong cases.
>> +    (addr + (PAGE_SIZE - 1)) & PAGE_MASK
>>
>> ? Is that why you were not seeing a difference between saying "brackets"
>> vs. "parentheses" there? If so, this would be yet another case of my
>> Rust newbie-ness being inflicted on you. :)
> You can use both () and {}, but you can only use brackets if you're European. ;)

I *knew* I was missing out! hahaha

> 
> Using {} to create a block works because a block evaluates to the value of the last expression in the block. It would be super weird to define a block here, though.
> 

No argument there. :)

thanks,
-- 
John Hubbard


