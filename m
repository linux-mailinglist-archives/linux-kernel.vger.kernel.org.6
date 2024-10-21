Return-Path: <linux-kernel+bounces-375027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF29A8FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A341F233BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9851FB3F2;
	Mon, 21 Oct 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTQ67TuX"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3C1D0E20;
	Mon, 21 Oct 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539273; cv=fail; b=GN7hm0Dy4XYY2FrQ8rDMf5QC41p5bFG0QkACZoBgg/m/TPVUQJ12yJGC2V/ciR4K8tMRs9aqVkkNbhR/J57A2pPxhbbw8fUvh6v5RiFf1It/iaoctm6ww6kpPh2KYWykQCnrDe+sE1DT5CzNuKMUeBggUOwr9iF14dFxRcUZw5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539273; c=relaxed/simple;
	bh=5VaEUUzMq50L6xb2NQENx15wlpowtnw3i2aqfY/2T5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BuJN8RMX59Asa4j03Is00ZLi7j2/tnaWLJzm8tlTc15ne4zthcyC2ErLNUfyTg31KBVxRftf4uhNfO9/IyXuIlBqGhRQrVF2d2T+zhsQvS5gAasDMcUpvVHMHvZdKTveiS8LAUXt9B1HeTtTSH3fp+9OkT8vBpHEHz10eqTkzRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTQ67TuX; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5qGue3Ctixs5lxa64ZesLnTGy+PEGndE9RgSxGe35z3WvUB6zzSB4cAHnp4qmVvT0Qc0HwZ5z6tOf1YyVimCwgsf9JY3pt6qLWdve1tqUU1Jsqcs5zTmw0nCGMLLcnNNkoXfmsv5pNWEdXakkty5a8CZkMC9T7G//OxQHUvHNkqwPvgskpsKV+zobGDXEdcopgQyt3K2iFUMc0cWWVOk4osl9b9MKzTx8J5L/r+BOjmCYA7QoU406oakdeI9iZyA2VI5voo5omdJxL1Dc5M5jjP1zc34d9MlthZUVw40PTUQAg21/5i1MlRCbpT2uM2mdAkJdhxaL3kbaJ7r61duA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WGeS/ehnQscmayCytXrHn1UPJ4ItTFCyuw7t92Pmwg=;
 b=DrKcUuWFkj10diboQgMQrsES4D4BOwKs2sCDlqbyo+qaC1POIjW04u+9yBHlQzUxugmwC5VAU7OL4KaQdsdE//ECdlWVNM7Cev/rCFUvONOXdkT1Xp07fK9lYWAaB+xknDm3vB18EhCuYRAOEF8GXB4cWO+NxxJ6/RvGG71LAOZYIzl6xzS+LVEED4xvKdobzfO10tDmcvAKtVoZo5nhdqnK5POwPELQ+ZIzxoJEMMl8SnW1Vhs/a4TXavVpggyfn0aDkdeIOeVnoiKul10+//muAyhc2R90ySabQdyrGjIzL5rh5XZzWOUUumbViUy10x+vQzlQi29QKbhSS3IoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WGeS/ehnQscmayCytXrHn1UPJ4ItTFCyuw7t92Pmwg=;
 b=WTQ67TuX8xD81xh5UAOx0Tb18PS2wJLqLrzhMePd5ix5/APk2x0Z7nrNFHfvcjB+M9iay9ueVJx3GOj898pg5iykG6tGhCerdTFtIkbMIt+jdz794tfYkgtCYv5IMfvw0mh68euAxlk9O1SdjvH3Q3ZPaK44btTBl3me0wBoEMH1tfd7Sr7ZRVnqcnlGcP59tipKFPv+2kY2ar6oMAnJk4DW2dErd9/hkTGc1/Tm0/oUGjKh7oYDpXMfSaQJoImgW9q9pDx4kjE+MXAvSHE2SE0gUDk4Rv1mVyfx0eaAM1rPNiMS76aSoCOIk/VVtyFqHqL3kn/6vq8C9sXX64dhmA==
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:34:26 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::45) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 19:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 19:34:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 12:34:06 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 12:34:05 -0700
Message-ID: <7d708e79-1a94-499e-a0e8-c3431aeaea3d@nvidia.com>
Date: Mon, 21 Oct 2024 12:34:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: Alice Ryhl <aliceryhl@google.com>
CC: Alice Ryhl <alice@ryhl.io>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAH5fLghMiNbyD-As40Rz+eRzxMVdX9TXwesxN7cbu-iW2bZJpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 22410313-bb84-4386-6a61-08dcf2075fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE5uUktBcGJuc0pHQ3hmaDBRTE83OUtlNkl1MjEyUjd2ejhqVXdnK2UycWVR?=
 =?utf-8?B?Y0lsVjhuVTc0TytvOTd2YWJiVFZlUXpNY1BtOEJFd3Nua1RnMCtSdkE5U0tk?=
 =?utf-8?B?bWRsSm12MEkyNGI3TVB3dUErc3A3S2hXUWMyZkdBZUE1ODcwMFNQODJFdWlw?=
 =?utf-8?B?Nnk3SmJPR0dZbG0rNzcvT25IM2xJZnltc3l1V2ExOXdSRmxBTGxMR1lIcjhL?=
 =?utf-8?B?dU84aEEyWnJodUN6YUZDTXlIL2QzaFQvMGhnWVpXTkpQWDFRSWExU2owbnV0?=
 =?utf-8?B?dW8rNEkvOHBEUjVNVDRQbmxOM2w4cUloTDh5dVVZODRFRm1malFFWlE4ZzB6?=
 =?utf-8?B?WnVaMElSSTA1NEV5bmpQOG1tdkJBM0ExRENNdlZjTUdiV2E4a0RURlZSUkNa?=
 =?utf-8?B?RXhjalpva1kxVmV4MCtQK1FDOUFqVUpIbXhCLy9OU0dkTW1abnA5VjhGLzVm?=
 =?utf-8?B?TkNSNmZWSEhSNUtLVUhPTmRaUnZNc2tzYjdaVGx3cUdwVWxmQkxtanF1MWpL?=
 =?utf-8?B?bzE1eG8xWVpzT0JmU1RQeUZPWVlEQXRVeVNURTJwYlNvRnZDRzBMb1RWUnZE?=
 =?utf-8?B?ZXJqMk4vMWN4R1NHNUQ1bndRN1pQeXpVOUludmZtU3FFdjB0NEJBd1lkdzVX?=
 =?utf-8?B?SjVSVDBzZDJ3cFFJKzBZK0FTZzFENHAyY3puOUhnSTZlaXB6U1NWNTF1MW5K?=
 =?utf-8?B?emRBTG9SSW5OVy9xQ1dQa21PQldCbFVJU3R0cWhibW4vK2R1L2wranZUTGV1?=
 =?utf-8?B?bHZ3WnhaS3F5d0RrMzREZTJsMkg0bUdNclNtUndvY2JUWnJZZS85bjhwOENV?=
 =?utf-8?B?UzViRjBlWnRQT1VXcVNleDQ2K01sWWxyWmI2ZFZaV0FheC9hbG5iRGtyWVFi?=
 =?utf-8?B?YTBISTFFWUpmTURhSmgvZ2pxY2ZHdFEyek9jNjl6WDhUTjdSOHlaWVc0dFk2?=
 =?utf-8?B?NWRuUXZPNUVvcGlKTW9HMmtHRDBMVEd3b1U0YUdHRmpMeWpsb1R4blY5TEpl?=
 =?utf-8?B?dDZqa0o0V3FWSjMzY0NBb09mZUc5WXYzQjJzcThPbzRScWZBYk96aVZJbXVU?=
 =?utf-8?B?N2l4bmxmSWIvU2N6Ni9GRU9OazVFUFVLc1l2UVI4MEFPRk4zMWlLdzJTeVZE?=
 =?utf-8?B?Q0tZV0w4Z1pZVEtxdTE1L0haYkJCcC9EU2JXOERHdkMrNzdHbXZEaS9RSXBY?=
 =?utf-8?B?aERTMTQ0cWdVdTZTZzIzUTdUbklaRVNCV3VFSkhVL0Z1QzFBRERnOHhOb2xK?=
 =?utf-8?B?bDZaUUdraVhaeXpnQ1hzQnFMMUN5YlZMZS9KcFZpYTIwSkpWWjlQRW5WL051?=
 =?utf-8?B?c1pjWGt6UWkzRTlZdC9ObEg4dlNzbFVTSEpJYlkxOUdDK3Z2UDVqSmJ4VG9u?=
 =?utf-8?B?M0dtRkl4ZlJpRk9qb1VVR0hvVEdjNGRzKzlqZXNpbVNpTm8xSWcvQ1MvZ3Zw?=
 =?utf-8?B?NzNzQ1R4Y1JqcFU2QktoZVI4eitWazN5OWZIbmJ5UklvY050b3ZhUzRyeCt2?=
 =?utf-8?B?Z1FlRGVuUnBtc2ttWi9iVE5jWWpQRFlTT1dXQ0lGWHRVZVRacGd5eGlXUTM3?=
 =?utf-8?B?dkxiRVFRNklFY2xqelhML2d5RDRqZlVHU2pKeVlHYVBtYlJXUHhTNE5RejE3?=
 =?utf-8?B?eVZIcXE0RDZoanQ0SlpIMlRucEpTL1hZcDJWVUp2UTNNSGd2NUIxYmJRWFVt?=
 =?utf-8?B?cWFVT0Qwa0d5TkJYZEp4MVNLY0o4VkhDS08vOFlJYks1QVZVNTdQM3Z2SlY2?=
 =?utf-8?B?dTNEWEM0MWVqNEZLY0VZNGdqamdKRFlKUU1qZ1A3cXdlVFY2RUZLY3VZZWo2?=
 =?utf-8?B?Q2x2VlZ5RzA4YVN6NXFDbDQ5QlJSSjBGUVh0djdvbThsSFNmdEJkbHdHb2Fj?=
 =?utf-8?B?cnpLYUYrYWxLb1ptMGlkNWQvNHpDb0JSOUcvMkNqNE8vVGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:34:26.3031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22410313-bb84-4386-6a61-08dcf2075fc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

On 10/21/24 12:26 PM, Alice Ryhl wrote:
> On Mon, Oct 21, 2024 at 9:09 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 10/21/24 11:59 AM, Alice Ryhl wrote:
>>> On 10/21/24 8:41 PM, John Hubbard wrote:
>>>> On 10/21/24 11:37 AM, Miguel Ojeda wrote:
>>>>> On Mon, Oct 21, 2024 at 8:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>>>>
>>>>>> Is this another case of C and Rust using different words for things??
>>>>>> Wow. OK...
>>>>>
>>>>> I am not sure what you mean -- by BE I meant British English.
>>>>>
>>>>> See my other reply as well -- I just changed it anyway because Rust
>>>>> apparently uses "parentheses".
>>>>>
>>>>
>>>> Right. For spoken languages, that's simply preference, and I would not
>>>> try to impose anything on anyone there.
>>>>
>>>> But in this case, at least for C (and, from reading my Rust book(s), I
>>>> thought for Rust also), "parentheses" is a technical specification, and
>>>> we should prefer to be accurate:
>>>>
>>>>       parentheses: ()
>>>>       brackets:    []
>>>>
>>>> Yes?
>>> What word would you use to collectively talk about (), [], {}? In my native language they're all a kind of parenthesis.
>>>
>>
>> Good question. I've never attempted that when discussing programming
>> language details, because it hasn't come up, because it would be a
>> programming error in C to use one in place of the other. And it is
>> rare to refer to both cases in C.
>>
>> Rust so far seems to have the same distinction, although I am standing
>> by to be corrected as necessary, there! :)
>>
>> At a higher level of abstraction, though, perhaps "grouping" is a good
>> word.
> 
> Rust macros can use different types of brackets. For example, the
> `assert!(1 < 2)` macro uses round parenthesises, the `vec![1,2,3]`
> macro uses square parenthesises, and the `thread_local! { ... }` macro
> uses curly parenthesies. The round and square brackets are used for
> expression-like things, and the curlies are used for things that
> expand to top-level items such as global variables or functions.
> 
> Macros cannot use any other delimiter than those three. So e.g. <>
> wouldn't work.

That answers my implicit "are there any cases in which you would
want to collectively refer to all three types of...bracket?", yes.

For the original point, though, we are not in a Rust macro. Is it
actually allowable to use [] or {} here:

+    // Brackets around PAGE_SIZE-1 to avoid triggering overflow sanitizers in the wrong cases.
+    (addr + (PAGE_SIZE - 1)) & PAGE_MASK

? Is that why you were not seeing a difference between saying "brackets"
vs. "parentheses" there? If so, this would be yet another case of my
Rust newbie-ness being inflicted on you. :)


thanks,
-- 
John Hubbard


