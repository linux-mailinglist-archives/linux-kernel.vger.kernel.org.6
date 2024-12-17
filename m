Return-Path: <linux-kernel+bounces-449199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A44C9F4B63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012EB16C844
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5A1F4272;
	Tue, 17 Dec 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U4p3IuiQ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAA1F4262
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440418; cv=fail; b=nOn4ITjZqZyj48cqE5Vi1+DV3tJg8jDN2OeKWJcS54w5EZja7X/fNOb9Ds8vSyU7txucy1VxPDY/q1DKrK21qMQDPEmaHHshD2rXmyA0iFkPfH0LR357F+B3WaznY4k9j8Diqq447ZG0W27S68zz63OZJu2ordDct431R2YGSvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440418; c=relaxed/simple;
	bh=O5c1NJdyHRsQU9YXtrhEHA1L34Poy3z1Ma5mxNZ5Hg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nX8N4tdMCslTgJk6Y410GJjVh4WAOwpgioDXk/NZxnj/RQGBYj+dDVwc+Xf3CX5q56kHEH4I/X316b3YPUI6CmNYOXxVuDw/f4l4UzDqA5fJkC4zuUvlVKPRO4shBTuAQno4L/K8zDdC0lpxNC0oqly8Jh40ngWhZCrGDKwy+W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U4p3IuiQ; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFqTobZ6RzOMn7fuIIZ18Mv/Ipm1EWvl3V2Zvy9KkosCerIhtWoeI6EVRbza6WmdRzjeEwXo8AHZbsNcKfyA/aEnphGAG4u1e2hwc30CdwjWtwXoxjq9ROtMbSQcFWSfT69rJMhR6K9EvF0dNlgulmbjmp6/OHjptl5DyK8aOF0M2DnPz3r9akb/sIZ4L2TyQ0XstGFHGfMoSOILkhpUgKpTZsR/5mTUlKWXOyeOnrz6KyTi1F2i3S3FzyOR5nEtKvAyWq4fW/HinH684ZZXqMOlEKpuU5zaN/AeTHgz9xyJt1m5e4Cy0IGiE/3bDXHZuLkvuT/28HD6jmKtTXIZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53kY3OVylBGM6aQ/K2P1h4Q0V0LKln3+T8cidjLhYsM=;
 b=Fnl0+VP8/dDMWlXqx0rB3VFcRde2uFK13nEhpHW1jGcWjoQNIUr4mst2IgZzfS3zbVOa7rvT/UbUXMamrB+84lqgUkkFEN8blQ95cW0vyRfj1tZ3+MH7pjhaIDrFsH83gepKN2D29gWXw446A4GUaqQv1VJgpMlFax5C24xI6mLbkry+NLWt4VFRTq8l8fO4PmOSXLHTp4anfSSDA7KDooEQxeW3Ik7j6tStBuzAEgtnht8r+d37Tk4KtxkrefD1f0g+3D0kb+IXm18QFgC2hP/lVm7Qr5JGvrDCTMAuPD/qmcga9NzphrdL8KNXIMIydZ5LT7MspAZ0OJQjt21eGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53kY3OVylBGM6aQ/K2P1h4Q0V0LKln3+T8cidjLhYsM=;
 b=U4p3IuiQwpXPf5taUbj1cqnF3G3LK36mlIHJmnEYx8cj5fP5woNVw3TrQT+WCby/Ufkv+cE55WOMB2EW/7TIyieqpycpYfz1uourzGPpR0k7Dew6XYuvhgi+MnvCwxTLlTNZpNkg2beND9L2xI93u7dikeDQfxwWG8qcUlTKLlpH8uvPMRapIVPgl1KZfLG12nWvhpyd7xDegw+PxLYBFOpFg16SYw++6wAQJfOxmBlbFYQ/BIOlrySpzbGEuby+uJhHkwwrkgNIhxnW8b5lt+80bKhSbgPhLYjHaNpgjFl8/r6zFlDTpHxlDtWrY6T3G2Vhvv2zvnx59QpgxpRo1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Tue, 17 Dec 2024 13:00:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 13:00:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Dev Jain <dev.jain@arm.com>,
 akpm@linux-foundation.org, david@redhat.com, kirill.shutemov@linux.intel.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 jglisse@google.com, surenb@google.com, vishal.moola@gmail.com,
 zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com,
 21cnbao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/12] khugepaged: Generalize alloc_charge_folio()
Date: Tue, 17 Dec 2024 08:00:07 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <AD21C68F-C9BD-4562-B093-06B8493C8143@nvidia.com>
In-Reply-To: <ae19e5ef-82d5-44e1-96fe-18a2a16faac1@arm.com>
References: <20241216165105.56185-1-dev.jain@arm.com>
 <20241216165105.56185-3-dev.jain@arm.com>
 <Z2D7YctQaFW_iwei@casper.infradead.org>
 <ae19e5ef-82d5-44e1-96fe-18a2a16faac1@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dea9d65-260c-4c1c-34f0-08dd1e9abee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWRjlcTB8d1G8Fd5cbAzGbC3Bc7UStudMHG8nItSSMR/39Dvp+c5xOzLT61z?=
 =?us-ascii?Q?+EzmhKoSrT22v+dNaeRjlGXWvcFB54+gNcUUWNVJD3E+VkSK5Rdn+3xor4LF?=
 =?us-ascii?Q?++S1LMmLIdTx3UNETPQyG+RlmaS3yEj7u1O18undjcC0EkqHfn5G/W2BQRvU?=
 =?us-ascii?Q?qRbHkScT0EgvOQZE83LRWSAcdtCzvo+RGgddj45kmm44HsqjwvGeH+68fcwM?=
 =?us-ascii?Q?3TGMDoE4Qp3Z69C3GPNoH3f3+xxuHrek0iFBFBp70DTfamSSeLM/Iup+iiO0?=
 =?us-ascii?Q?AQeebaP394Xqf7MFZHsHHHQmwduyUpmkjBf/JTklpytQTyWFherzGVtpwBRl?=
 =?us-ascii?Q?AWAp8xL3uS0XMPn+QqXp11QZqh5J46fpbgwl3g3UjCepGD1l+wDByuxna4xX?=
 =?us-ascii?Q?1WJzmStxu5J9Pm2IlGTHOJSqSm4C2nsKXoHr9smjk7wpzFoA9lO5yYQtFaa+?=
 =?us-ascii?Q?7LIlXyjl/hjaER00Ja3mU7ovmlaf0qEr81fiAtelPGVgMOwZo/osCqCCiImq?=
 =?us-ascii?Q?dvz5iCe9Xxka+dZjdaxyxn4B3ou6TcspSkxslGpY07pyYUeOphHs1DQXZDq5?=
 =?us-ascii?Q?4Wh2Jlbwca9i8tEfnQRS+NwmVQ1F8YfgJZ729NRiyTFeX8rKN0tox1rYxRVW?=
 =?us-ascii?Q?Rik2qGPdvjtV7ASmitZMemCzLe3ByJBJt5/ANbd+HSOyevJrN2A9xVjhvePM?=
 =?us-ascii?Q?/SPJCOqlWPjIjm0erc7S/LTYCKd2YJ1yUThx4v7ujJ4QgK/WoIkjhrbEx5X1?=
 =?us-ascii?Q?d4DA26b7IWX7SAlM5BGBFX3iltfWWoILxpbsp6WUMn4lcAkV2XtGaKYOQV6L?=
 =?us-ascii?Q?Tu7+D5KFK4HrkVhckfwYMkJZ3UukGVQ7HKcf9Mu3o9yDpM5xcovaZC/q6HZD?=
 =?us-ascii?Q?NlBGO7V+15Sm86s1+lVOyFMZ4RizvjoVmjGww//K82zvCvh/y0PDt5W3Y3r3?=
 =?us-ascii?Q?vn9MHBmwbOQ9lY5pv5Tt/B/2/iqxuE8uANoxxNWgCdWxQRUTIVQAJ/WXrq1W?=
 =?us-ascii?Q?F+ZcMw+fyImym/7V2G/vDukzs8iklT09ranUOQccuSErqTCuSBGfRbFk/OWD?=
 =?us-ascii?Q?XuEdvkJyntyF1+8CBFrlXOinQEMbktW/RPEblEB8mB2n+AK/ygRXfL5CAz6H?=
 =?us-ascii?Q?JwpoHdF0iEr6utc9sSlpW7Ifu5A5R9GwzLDGcjRZ5cQFlTYsdCb7GEIqpqHS?=
 =?us-ascii?Q?UrYn+6tquLicRPN3Y9VX7sFJGKc1+3IBE2DdKZJ/FC+08TR5+vp5LqLhwovq?=
 =?us-ascii?Q?5Yuw7+8EeX2IQDnLELRaqLUv2NS1qWnIk+wQIapV5tUzvRdAN+g+KuoTp/Zt?=
 =?us-ascii?Q?5eIioqatCuqlfvuXeePVmQZOxH9nZ82OhIs4dr1Hv+CFvpbKANfRrOtAr2xR?=
 =?us-ascii?Q?SfvL1/XnH9Y7Snr6/c3v7YDw3LS5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vSpuhvM2JSW/6vu9MU0dfuM2fNh61OZtULSZwvU8dGIy0EL9lPMb/s5PKb3N?=
 =?us-ascii?Q?ku79CyoRCCApGHqT0Er0DY1wzi1/cqqlwBuQ3hh2UCOT1qDfAhUPG8pEeUyu?=
 =?us-ascii?Q?Cl+0o299MwMkzzGUQ1swYHE9UBc6/hALWaRuLA2WOW900Rp9mhDfDegAz0MN?=
 =?us-ascii?Q?ZpKeuRh3M/1ZZfWdhTWfq7Emgja6ynVmPpd4C/RrJF3GPFAQGT9AWBR0mE5Y?=
 =?us-ascii?Q?1pbTyBTK4ho1lyOjNUp4OpgQnh4IHQYM7doob0P6ZGLXcY9294aMtoSeW6ac?=
 =?us-ascii?Q?1mjcjYL6k8wQMlmxgjCGhZgYQjA1IVwmnXnV6Qbifpxnq2zXdX1E1sdUxV7y?=
 =?us-ascii?Q?Vs7AvUm7qmV6OsuTIvF7t0GuLgF0EiBzGvFJqXWUka/06I/6DpUlVvVMKGsy?=
 =?us-ascii?Q?KcD7T4PWUYjDBpQj3Fr+YSE/jxLS5bxJseiQTF9arioVmFh3X9ovI4chh3W0?=
 =?us-ascii?Q?rRP+Oe8i6uEHLTs7mXJh/FWWZDP6IZniN8FWXNAGY2/LIUJHWDxuW4WrIJij?=
 =?us-ascii?Q?BJiS80MJGNmKJ61UwuuW4h9pYx/MVDFFYZl0MslQs19VMZ/0A7D40lEdKItl?=
 =?us-ascii?Q?mjkGh/+XtO2J574TuhOJsDpDh2O6FZgLlv5B276Tu3G/jfeP/ODOLSxYbgyD?=
 =?us-ascii?Q?6OBab3wkqkQZw2HQH1H7PXp+g01O4vM2NT5cwxlLL/Lw3XWZgxdWISF9xu0H?=
 =?us-ascii?Q?TQskfXMGx7JoqHlALsud7wwGzG/JczeFc74m1B5UFKrk0GwRaDQE/XHgg8Vr?=
 =?us-ascii?Q?LkUe/S5UT7Ih1UaaGxM/pU0MbOusB5QnsayvXlAF8fvkLw1pOvBwoz68C8bz?=
 =?us-ascii?Q?uLJWaHUioPqxLoPhM9oU9nxFqA62hDGGsFPAJQF1w5Ca3KbMETX5gexwZihc?=
 =?us-ascii?Q?5pPUdcgp7hQQZ/fKoqqVp98bnyGIxJdSbskyxuZbaziCbZCTseccByWyVLBG?=
 =?us-ascii?Q?FbHC/P40KW0NnH3rPv1IEizHGUYvFewBFiwbStzg56/HOXVCT1ilae+79a6D?=
 =?us-ascii?Q?cAaS52WeXC2SDVHDltp+yS+4ZaE73Upc6Aq7aFd9aB+EmzUkBf8e1uKBAWEd?=
 =?us-ascii?Q?MdnxXYPw3XfrQQUt1Qi3hFuKNss5R2d0nLOq5KdQjNdcuFJclhSIsl2GwwaQ?=
 =?us-ascii?Q?h3wO1Y/TsL3WK3N1xvtC4/cJcQudl7mnxNn9AmeD7UvwNdHqk17Lb/wJEC8/?=
 =?us-ascii?Q?TCktie884aQsIU0nqdwn1fthAK6xxecVk0Im6JuJcn+w4772WRFDc/bhdUDI?=
 =?us-ascii?Q?ktIIyF/P0+OVQfavc6lzTM6l0NP7SwfyFkTrLXUFk/5PUKKabQyQIHGO4auJ?=
 =?us-ascii?Q?a3JVF9cFp5EXfzrec5MbbCHr9xWayTRlfBhNbFpJ2kY1Z3vvTC3iemqg3IOB?=
 =?us-ascii?Q?LVChalEY4EZ3hYuBLu0sl/7YFmK3NPgf/mNxMgDp14nAjm9Q1a9TV7Ksfon0?=
 =?us-ascii?Q?DLQVvu5vMXc5JDdDjIj/sprooT8cMu8mQlhY6lxSLpPf0BxdCkv5+aT5QRuS?=
 =?us-ascii?Q?pZ0oBelqeJPDR2k7v2RstzBa8pA8csbgpbOX8+yIeHWz4rYA5oRLXLkkso+8?=
 =?us-ascii?Q?b3R2oVu2DhC0le2ufn4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dea9d65-260c-4c1c-34f0-08dd1e9abee8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 13:00:13.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWJEW05ExCLiUxTg0ZFSfAX+karRR5zGiXDtZgjAy6u4UiLg1I6hBp9qdNLfQSbk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355

On 17 Dec 2024, at 2:09, Ryan Roberts wrote:

> On 17/12/2024 04:17, Matthew Wilcox wrote:
>> On Mon, Dec 16, 2024 at 10:20:55PM +0530, Dev Jain wrote:
>>>  static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>>> -			      struct collapse_control *cc)
>>> +			      int order, struct collapse_control *cc)
>>
>> unsigned, surely?
>
> I'm obviously feeling argumentative this morning...
>
> There are plenty of examples of order being signed and unsigned in the code
> base... it's a mess. Certainly the mTHP changes up to now have opted for
> (signed) int. And get_order(), which I would assume to the authority, returns
> (signed) int.
>
> Personally I prefer int for small positive integers; it's more compact. But if
> we're trying to establish a pattern to use unsigned int for all new uses of
> order, that fine too, let's just document it somewhere?

If unsigned is used, I wonder how to handle
for (unsigned order = 9; order >= 0; order--) case. We will need a signed order to
make this work, right?

--
Best Regards,
Yan, Zi

