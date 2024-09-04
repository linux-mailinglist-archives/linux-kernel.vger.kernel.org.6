Return-Path: <linux-kernel+bounces-315201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44A96BF22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC1D1F21A51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132F1DC051;
	Wed,  4 Sep 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tg4G98Tu"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685B1DC040
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458029; cv=fail; b=tWIOK3BPjwdp/A+VveFUrbRWxEb/+WzBqNvT24BPTSvTIILOCRk2MBxKxSzCnn+nI+/kqHVqDliOH1P3F6kcCBk6N8vrvK0VRzu783mEX6iQTsMz6LFL86zFTL+rejcVWZsrIS6pIW0sYAcCcSNTEv69CnlrYShFIWObTsGWK1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458029; c=relaxed/simple;
	bh=CFlVLhto/KkqsNpQc2+rdUDUwhsZk5+TJfLNBFCMiVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5AW6/qL4tQvfTzAjmHkeVdBR9r4nCuiAR68mBkttlJ3v2PUwkXyXlARCNF4eau02u0sCuyD9kyi24huB4IGHWvT81mFHCwqinVdFg1+p8yxqqU3ssNErInNz0G/ub5fqpNqC05/v+sj6Pmm500SynYu2/v9tLQ012oafmI1+ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tg4G98Tu; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFadK0klr7nh1D8hWJAZFOR70KhrFN9mx02szeX3HCgDceC6LjSqiY098pEnGnoBsk7qwuy+stIsrUuK1eWSy/DoTtzqth90DL8Jkvevw7mkQQBX7OfRLL3ToLeWH931KJwFWGy4E0J7eDfoqIBUf9Rp4GnfBZ3Y+yK1mWebPT/gEdPfTVSa/jun/fKpscHyXuIlVfv7GySUkXjwPqO/CynZzhp/DLW1rtG2Q/nZbyQ0N+QlMnEVSDu7HPargMrjhK2ujv8VYlsydaXGpNdN3/I7p08iBFafnlese1sgtFlmVvtydYNmt9fqfFnLh/cmASuS7BxeGF+mt60DaZxjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR436Vf/Nyo3K+aC/fW9a70QFyLUU/7YfE3s8GgODc8=;
 b=GZzooPYnxjmKuxusu913f4Z/rJfkSY1LZgOCmgID9qvapdwjyjH5kNRfVQmY+A0W7AS11oNJwe7NnxKDxJqE3yXWaHwhdNc6TF+LXFA+u3x2jNNKCcTWRAVoZXsVJr1G6aLB77atk7nvjkXmVY49iQV8ED4CtCtlNFOPoiDQqCQkOuw/mUT+9La0oiiaO82Yt2uoK/d8Ku+3FOGJgVdv7noEqoJiMsFHVMBto9/IULfYTDpMaHZ3I/igw1yppRTJYaZXF2VhBHDA1Mcg1j3Fb5/Z/UCIN3rCw2RST7/cJ9+9n0Iks/oYYgAo7nIYHfEHHYNk7a8A1qXNYvo1AhFQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR436Vf/Nyo3K+aC/fW9a70QFyLUU/7YfE3s8GgODc8=;
 b=tg4G98TuaL7nAQhYcBV27lTwGDwoA+oEOTXY3SmIQqO/R42LYBjx6ely/P/iOOm14vvXjxoUcs2FHFEAar7XGn0/3l0TsW2ypHk5f7uKhClYEJsWl1LHfA6PnUBmknR/hAk3LnKk/yp6Y1xK+0AYOnNQi5WLvq8IU+/1msiOcCNRZKpsZTJh5bEmvHok3sjHbPiGZ1ADRNxZZxo+PSk8VijEzqtt+vr4O9nzIZsXig09swZO04gDayA8CzEvVdMbQQed3rbgw59D0QVeCY0q5IipQKh0B+p/5W8ruq3l+M6lnUZ+BtfgYwuCVbmtP4Tcb2/gF0ZtZ8bndpuT4GZJug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:53:43 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:53:43 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] mm/page_isolation: remove migratetype parameter
 from more functions.
Date: Wed, 04 Sep 2024 09:53:40 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <96ECF76E-1F8E-47DB-A228-3A85AEA29C7A@nvidia.com>
In-Reply-To: <1c33a814-db9b-49c4-b465-5b94b04531a7@redhat.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-5-ziy@nvidia.com>
 <a43c866f-b281-49d3-b503-f5f86dadd306@redhat.com>
 <E48CFE6F-05A8-4D12-84D0-2B6F7484974E@nvidia.com>
 <dff8fa34-9099-46f9-b39a-1a986af2b022@redhat.com>
 <BDD48C59-0C42-4B1E-A4F3-FF97744FCF6D@nvidia.com>
 <1c33a814-db9b-49c4-b465-5b94b04531a7@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6DCA7402-E5D6-42CF-AE74-46658C80F84C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN0PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:408:ea::21) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee472b9-e359-458b-5d82-08dccce8fd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fm0lwhLYfCQNRN1UVARthfw8EjBXj8lw/1J+1jkjTbMa2cyOvMV/2CbjHFkI?=
 =?us-ascii?Q?oDiyVeAGEy5PD7rcN5N+FA5jNkvzgb86XHq1jls7564tzW1dhSAKxB1NG6d5?=
 =?us-ascii?Q?z6feXE+ZIO/k+JU0JtDpvjqwQy47Ys9e137X55Yq/+59lUzxejTatpA/xCkg?=
 =?us-ascii?Q?q9pmxNiV09oYpjhKvHImuOrUoWABMLktD9wDIp5eieibF8STiwSMA4mGm8/F?=
 =?us-ascii?Q?MU24UouBcMdDhUbsnZcRHihp8n1W2CLwGs22OHOfBLq5fgzPnl9makYhIAIS?=
 =?us-ascii?Q?pdmVniNasL94oHS4oaZWMk+zNuCVRADMz3KPdbFjAuo77nnDq9H6IRZO0BqP?=
 =?us-ascii?Q?qKicdc/eK8aA/lcwAprg8B4rsk14/3cnDuOlepAqQqtzpip2gkRjTqIedGnC?=
 =?us-ascii?Q?3Qxgos2CtlZ0nbt6gbm3Zjv0Fpvgp8tbnpw/L+GQ7285wxwK8jPAU4uhMUh4?=
 =?us-ascii?Q?DnaRtL9BcfZoH7LkNYRgmT2tlPsPijhgTthDiy/o3A9mWjeVwO1kQjIkUdf9?=
 =?us-ascii?Q?s6mY5+3+cxuYIUj6AzPM7ONW+/tQbePvDgmE39cimyQDRN+AEa7ZJeA7hq3t?=
 =?us-ascii?Q?YdTXZi65LYDLUgoUwPQFegA/Q7S+s4GEmwYXPXMTIdU5tpeTjNk23UNU0PcS?=
 =?us-ascii?Q?RxYW01ay7F42pXzFaEmcHYBcn4hqQCRTaKfvxHnSq05iziFbPHjLJT7LNr7c?=
 =?us-ascii?Q?+ngRyUOHyAmos1L/4moOxOIH7fTpQh0t3SDOFMI7uCCg7rYskyVfNoD0ivNw?=
 =?us-ascii?Q?I4h9ONBAoqDYnLYJp7EVtpYoT3fuClwn9Kd1dFMdrEzQjcXvmF5vKOHihHTs?=
 =?us-ascii?Q?DvsflBrKlnZ5oZKcJsrqPDo2UTa1mtT3QeyhrvEK9siB385JPPKn9mCOGRKU?=
 =?us-ascii?Q?yDssn5U9LSaEN7/JRgrK/zCcWPqM73caXd56rURGR4TyJhTZMreN2TQU4aWQ?=
 =?us-ascii?Q?t0BYvgR/tRaHUuSkHfD0Ypv4Ow4uko6oH0Jgvu2LDlEG9Grfr1g/JFguK2dh?=
 =?us-ascii?Q?TgsEpOEjMsOS77+wLyCVjFyv9rBXjD26HS8YVdHnbW+Illt7rKeu0hxK3o7s?=
 =?us-ascii?Q?MVMW/u9EQarA4g2nCBBGFsJuNvGx8iggFL51Ob9mwmK7rdMjirHUx+XdlcvK?=
 =?us-ascii?Q?vZkfkfUvdo1HebZY5jvTUYJU7l2mlaZgEnnqIvD2AYIxiTU+QnHFmeSzDdQf?=
 =?us-ascii?Q?yTOQrVZ0mi4Rw2JbnRwYDawlRml8pItdWTWSF7nANe9by8Dzx/g3Fbm8rnHE?=
 =?us-ascii?Q?tq6wfirpXmVd3x8DSuFkfB/el7U5QVlhOMU86bpUvZT84Mw+JgaV89oTuNpn?=
 =?us-ascii?Q?qT2D8KjqyQBEZKKK9NK36jBoBwQsQDt7aYcxUb0SZVDmVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prwCtFtZfDlOJmmq9CU0GDoItPz45q3wC5gyXiSdINNCoTFyGMtCERNpsDVb?=
 =?us-ascii?Q?GSRcewZq0RXrAgPmqMBt2+dtjv/uWdcbHde6ADBFm6AocTGeCGVgCpK5M4IQ?=
 =?us-ascii?Q?Pf+C9sYiilo8mU+t1La4Ghsp7gTqqdcXJwc4gTyZ6iwuyK9llzs8urSknw5i?=
 =?us-ascii?Q?FiFvA2Gichdb2KlLatgcKYoda9s9Tlj+bnNpp6oGVvZmC4rHRZpCic+Q+2BJ?=
 =?us-ascii?Q?nG6487rk9PjiFl4z7j+Ma/wPHJ30p+TRauWyPLCxfNxzTWjsT7w1u+Kp7yQL?=
 =?us-ascii?Q?pHqseS40DUbW1EZDdHcKfYjpGTtNTEQCoMGRzOWFCQE5Jy9wVelqalpvH9ZM?=
 =?us-ascii?Q?XZYl9aUE+TuRsWQyI/lluZvccKql2WFJv/Y6O6CHjZ12QzHdAUvm4KFxblPl?=
 =?us-ascii?Q?hMsu8+FTqz0z43kAiGnPioLkDcwezjAILbCKD5sBwRzeibV8evVkjrR1cBc/?=
 =?us-ascii?Q?WU8s4EL1TY8WD1hxabTM/aKQ2Vs+ABB7xu+Zm1ZDnawKKj1CYovs2VbJ/fnj?=
 =?us-ascii?Q?XhLyYRQBH6bh7CF/BaIkUEVN23zsIyVIZKDNI4hJP8JxLO9g2o8j8kjaixdH?=
 =?us-ascii?Q?0QqeuFjshJevx9AGdWNCFIk1H+wlW0AWSGyG+p0q9qyeGMgrucmKnR7vwGTQ?=
 =?us-ascii?Q?2tF/XZZMckV1yfgvGEeBKxd2N9xA5MvJkoWWIZIiR1Xl7IPLfmQimhERLw6d?=
 =?us-ascii?Q?phlj2loVkXPt98e2/tAAQoQQ46UsugO19ODEML1ai6c10Nvj8XjUSJRPK5Xf?=
 =?us-ascii?Q?/5YoBjXZAbluWNd1HeQOt/9JjuRl7I58H0XOP/glwjnyZwj3m6ViXQ69lNGX?=
 =?us-ascii?Q?/tvkv/whmzA7HiyvbfH5zRNI4jEkUG/G4roLVTZb9CuEYUplKF3EVnyJg0wQ?=
 =?us-ascii?Q?74G/eOiFhk17JPFl74anKrPbVHyzXyi8Hzd8pwEIEuqFokeSC9pkQdL8l0Ir?=
 =?us-ascii?Q?JxT1uC7TQ28O/jC7Ocqmq6NUu2KqIdNy+tY7jBWbGpv1LMg1qY6YIJyHmrmB?=
 =?us-ascii?Q?ayoSoyOgJ0B9wDDfUjoyFbovom4AUgXoF6HyJVd439LGcCopbsHwGsbnlpoA?=
 =?us-ascii?Q?gM/yoKRBzaFMsyfFR/HMFtZlvV1RVuG3dUmB2U+ZiC6sBo/VdVM00dRkAxl+?=
 =?us-ascii?Q?MiOmxD8CcVHmdhlJ8rm3GR9M2NZurOmUNL2cVywASf0wAbjzpezqQgIhisIq?=
 =?us-ascii?Q?vkGG0Y9lq13M/7VvZsMFUbkUJy3q4qM7gDSOv37jarB6QvBg8wE9cYvkAskh?=
 =?us-ascii?Q?snXoOnR29mxIG8OTo6iFYU8JxMccNflYVNPdlHHMq1ELL1P0cJKLvFO20UBk?=
 =?us-ascii?Q?wFXMP6QO7WKeSy4yNin0FA44JQd9OQwxO7x7Fufidj0LkFLnYP5uBv+jrlGH?=
 =?us-ascii?Q?XZBDXKA+7vJdUZ+7uZIS0gD6PhNPs7hpJiLisNpf32FD5T+tHXSJlIXs9dKi?=
 =?us-ascii?Q?P/1BQawCNpb8kX1zbcvNUgAxGFHB79TcU0H+VkaNJtguJYRkbA6u6E4PVFcE?=
 =?us-ascii?Q?5giVVazyy6Bhudyhrv06OW1+D+l3IzLDP300+z7PvxIYVBuH7M8mn05xx+z9?=
 =?us-ascii?Q?PRSGH0mh2ww1udBfX3jR8JlRZf2H4dxtsTFeKkjX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee472b9-e359-458b-5d82-08dccce8fd29
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:53:43.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyIoEpBSWK9c2iNVDRErK8QJoLS5+0Fbye3EiYiPyb6kv/2KRrG3kJemfWZZoG/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

--=_MailMate_6DCA7402-E5D6-42CF-AE74-46658C80F84C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Sep 2024, at 4:50, David Hildenbrand wrote:

> On 04.09.24 04:02, Zi Yan wrote:
>> On 2 Sep 2024, at 12:42, David Hildenbrand wrote:
>>
>>> On 02.09.24 17:34, Zi Yan wrote:
>>>> On 2 Sep 2024, at 5:06, David Hildenbrand wrote:
>>>>
>>>>> On 28.08.24 22:22, Zi Yan wrote:
>>>>>> migratetype is no longer overwritten during pageblock isolation,
>>>>>> start_isolate_page_range(), has_unmovable_pages(), and
>>>>>> set_migratetype_isolate() no longer need which migratetype to rest=
ore
>>>>>> during isolation failure. For has_unmoable_pages(), it needs to kn=
ow if
>>>>>> the isolation is for CMA allocation, so adding CMA_ALLOCATION to i=
solation
>>>>>> flags to provide the information.
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> ---
>>>>>>     include/linux/page-isolation.h |  3 ++-
>>>>>>     mm/memory_hotplug.c            |  1 -
>>>>>>     mm/page_alloc.c                |  4 +++-
>>>>>>     mm/page_isolation.c            | 27 +++++++++++---------------=
-
>>>>>>     4 files changed, 16 insertions(+), 19 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/page-isolation.h b/include/linux/page-i=
solation.h
>>>>>> index c2a1bd621561..e94117101b6c 100644
>>>>>> --- a/include/linux/page-isolation.h
>>>>>> +++ b/include/linux/page-isolation.h
>>>>>> @@ -32,13 +32,14 @@ static inline bool is_migrate_isolate(int migr=
atetype)
>>>>>>      #define MEMORY_OFFLINE	0x1
>>>>>>     #define REPORT_FAILURE	0x2
>>>>>> +#define CMA_ALLOCATION	0x4
>>>>>>      void set_pageblock_migratetype(struct page *page, int migrate=
type);
>>>>>>      bool move_freepages_block_isolate(struct zone *zone, struct p=
age *page);
>>>>>>      int start_isolate_page_range(unsigned long start_pfn, unsigne=
d long end_pfn,
>>>>>> -			     int migratetype, int flags, gfp_t gfp_flags);
>>>>>> +			     int flags, gfp_t gfp_flags);
>>>>>>      void undo_isolate_page_range(unsigned long start_pfn, unsigne=
d long end_pfn);
>>>>>>    diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>>>> index 4265272faf4c..fe0b71e0f307 100644
>>>>>> --- a/mm/memory_hotplug.c
>>>>>> +++ b/mm/memory_hotplug.c
>>>>>> @@ -1993,7 +1993,6 @@ int offline_pages(unsigned long start_pfn, u=
nsigned long nr_pages,
>>>>>>      	/* set above range as isolated */
>>>>>>     	ret =3D start_isolate_page_range(start_pfn, end_pfn,
>>>>>> -				       MIGRATE_MOVABLE,
>>>>>>     				       MEMORY_OFFLINE | REPORT_FAILURE,
>>>>>>     				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>>>>>>     	if (ret) {
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 4d06932ba69a..c60bb95d7e65 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -6607,7 +6607,9 @@ int alloc_contig_range_noprof(unsigned long =
start, unsigned long end,
>>>>>>     	 * put back to page allocator so that buddy can use them.
>>>>>>     	 */
>>>>>>    -	ret =3D start_isolate_page_range(start, end, migratetype, 0, =
gfp_mask);
>>>>>> +	ret =3D start_isolate_page_range(start, end,
>>>>>> +			migratetype =3D=3D MIGRATE_CMA ? CMA_ALLOCATION : 0,
>>>>>
>>>>> Can we have flags for alloc_contig_range() instead of passing in a =
(weird) migratetype?
>>>>>
>>>>> Then, we should make sure that we warn if we try a CMA allocation o=
n any pageblock that is not of type CMA.
>>>>
>>>> Sure. I will expose the existing isolation flags (MEMORY_OFFLINE, RE=
PORT_FAILURE,
>>>> and CMA_ALLOCATION) as alloc_contig_range() parameter to replace mig=
ratetype one.
>>>>
>>>
>>> Maybe we want some proper, distinct alloc_contig_range() falgs "acr_f=
lags_t". Might be cleanest, to express anything that doesn't fall into th=
e gfp_t flag category.
>>>
>>> Exposing MEMORY_OFFLINE feels wrong, for example.
>>
>> OK, it seems that I mixed up of start_isolate_page_range() flags with
>> alloc_contig_range() flags. Let me clarify them below.
>>
>> For start_isolate_page_range(), memory offline calls it separately and=

>> needs MEMORY_OFFLINE and REPORT_FAILURE; CMA allocation uses it via
>> alloc_contig_range() and needs a flag (like CMA_ALLOCATION) for its
>> own checks.
>>
>> BTW, it seems to me that MEMORY_OFFLINE and REPORT_FAILURE can be merg=
ed,
>> since they are always used together. Let me know if you disagree.
>
> I think there was a discussion about possibly using REPORT_FAILURE in o=
ther cases, but I agree that we might just merge them at this point.
>
>>
>> For alloc_contig_range(), migratetype parameter is what you are talkin=
g about
>> above. There are two callers: cma_alloc() and alloc_contig_pages().
>> The acr_flags_t is basically a caller id. Something like?
>> enum acr_flags_t {
>> 	ACR_CMA_ALLOC,
>> 	ACR_CONTIG_PAGES,
>> };
>
> I'd do something like:
>
> typedef unsigned int __bitwise acr_flags_t;
>
> #define ACR_CMA		((__force acr_flags_t)BIT(0))
>
> No need for "ACR_CONTIG_PAGES", it's implicit if the CMA flag is not se=
t.

Got it. Will use this in the next version.
>
>
>>
>> And ACR_CMA_ALLOC needs to be translated to CMA_ALLOCATION when
>> start_isolate_page_range() is called.
>
> Yes.
>
>>
>> BTW, after removing migratetype parameter from alloc_contig_range(),
>> the tracepoint in __alloc_contig_migrate_range() needs to be changed t=
o
>> use acr_flags_t, since I do not think we want to convert acr_flags_t
>> back to migratetype.
>
> Sure, feel free to modify these tracepoints as it suits you.

Thanks. :)

--
Best Regards,
Yan, Zi

--=_MailMate_6DCA7402-E5D6-42CF-AE74-46658C80F84C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmbYZmQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU0asQAJCvFEz8GrsNIJH9AggNDTU70mzRxlrgCqnQ
/lbsX0DLp8fjASVMFXRrEcjsQHJR06I/v/i8SR5QybpqMxN3NCAbnQOzFdRZS2oa
cHB/vCyFJpCYtz4vZMmsAoc0x7lHB50IpEIIQTrijDJPsVCFV9/OGw+o9KTmyPwR
qwfHML/yfIacfSpfmansYK4hWDs2I8vVfglhy+mbC9kgFB0Ag+PshJsDRPS+wtzo
0vWXso3GxKeFC1SZ45j7cy78rRoT4u8RORveu+GMoaXvQm1u1TnOHuMC1MMGhcKo
Ei8EmL/Ejrk9WTw2UPDKzwl3ZzqQQD/xoaL5TVx1ET9IKGfQNIMncsah2TVf43wA
pgEACcciuIjxiNZdM5kyuLhClP0MtH48IcwcoZS+hn8fUVnRn7Cu37Odm3BuTHZ2
mwo604m3mb40GfA2qBR7H+ZOLqAbiyQv/oZyhD21Ih2neZT9lLSoM65lAR6EpAHD
aSoBrs4trtjr2rW2mLBvAa2S/gIm8OQSsEQRXAqCUnTkB2Dn7Bi7dvLGnA2CgCv9
R0o3nJzjZeI2AvntoHboGdqviSqU2Opmp9LiGGHeNFoonI6G2f7kJVnKyZA+bzhL
gsAMVzSnhLfDLaB7WjCdsB4sBKdENSwLGKe/PkoVvtUvwqRisJozRZr2n0x7Apcd
YowjceLa
=tsoM
-----END PGP SIGNATURE-----

--=_MailMate_6DCA7402-E5D6-42CF-AE74-46658C80F84C_=--

