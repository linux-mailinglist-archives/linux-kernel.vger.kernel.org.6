Return-Path: <linux-kernel+bounces-515468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F7A3652D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F1F3AD7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76425268C69;
	Fri, 14 Feb 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lqq6RSQG"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E01EA91
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556271; cv=fail; b=UseBdXxzhYTKvwgCnF4h/QV2OhsEK6oWhhDzTsv5o6iUFE5qCG8oUC2uPxsJYT2MgqhTf+BW1nlvu9nlm50LhKdvYu0UKNWcHKr/Tz/5Rx29f5FWfAvDneTPAAzhSJ7vfKQqnz7HxobeWuLVUMOiwpuGbBSv42hse86HJOqBWkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556271; c=relaxed/simple;
	bh=x7r51Bh6hZN/A47aitO0UgYhKY/ASRXD1Y8ba8Xn1Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5c34U1+XtQH7MIBx9TlapvAFhdxQ7etheGm/yX5A8QhH5DvFKs5hrmzmAuIGDBcWi/Sj+SQ8qXWHPZ3WrtZ7FiZ9CeWtuDrrazDINagGOcY/8n8Op2VsywtHEWaP5ucDaD6wpCXCeVK3N6rHJLSRkK66jRFH0Fe1wPKqApDsxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lqq6RSQG; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0pn5au7lBFXVQdqGo1SLHuixU0WQToFNMA4CxxrnjcyB7VuwXbkzcexNDpzbMWB1nSQCsc67r8pXv/oBp8Ondm8rBLdPrnwXwZn++RcqhNoElkIW8FAG1SHjc1N++lcC1qThUz87hyYUNlbMA8EaISchlEkJLjecYf65QZC1pzUfqkUcW2Wf30KEEMMQcLL/ZeWiTRKLxZzKcRJH25vTxZXee21nMWCFxPhP5QNBaQGdYOu/jFj3N2lgaZ4c/lCW/aN6AzFp3aZh9RlaACYQUr1slV0Gx5vNLTzB8F5L8zsjAzE9Xs5Nu2rtqF9l7bLFpbLIKUfWHTNXBHWgw06tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdPXNmgtetZDftGepBxqeRRgENy4Ih4XmHDWAr66kJE=;
 b=W7fKZFdaRVXdteI/n3vEXQ13F+Aq7iBz9woHAeFmQdrYx9DfkFF+GWA2b5TbTEozhcEJnwdVGjclHu6ayKii7MlIOL6vJy9B4HNMto5WxaXNHDvsInDkO22H9JJJFPzGw8idRbxwKmsXH+2B7zVkbqfXm16QF1aYjJ9hYZY2zfDDMvvn/+o9rSX6qmkGZFkzMm3jip6PrTbsvFy3JsGS2q1ZhyPrxEf2V+IuEc+5pAmCdKjJo4xTjK6RQtR5HRJ9Cq4KnDmcFyQXlOtNhqaokaziQ0FmVx8b9ujrZ3368tKNZ6riXC12XdNRT7kML9DZcr/AX2sMsXlMe1CfOOtTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdPXNmgtetZDftGepBxqeRRgENy4Ih4XmHDWAr66kJE=;
 b=Lqq6RSQG/abuZUaY75YBHYuI4xADjv0yuKMJ5t0N+KjB1TTxtSj7+LPGZat1xVvdo/XOM1ryrYqy9vTTIEqHnBxh9bMOXBFs3Csn3/Xn7/LntLGP2kZZp0jd4zx1s2OxCASfpAyWvldMqMIv+v0v/zZzBtFJlPgXbGntkNLiaXevWYlWO8WJQKexknHJW22CdvJKNz+YyOnCbooa9XuaOjlkgX1MkK5aEH4FRHVVzCCUe441JZjqsdgE8TCVdlgDE0O68C/bfJrIy3k50bNV9natPahDNwFWfCRSMnqggw0WYSw9YOoCVK1JDUoU2L+Uf0c5CMtgnc7FJG5ZZcH7wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.17; Fri, 14 Feb 2025 18:04:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 18:04:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm/page_isolation: remove migratetype from
 move_freepages_block_isolate()
Date: Fri, 14 Feb 2025 13:04:20 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <2DBBFC75-07A5-4D31-A6CE-887095AC6C75@nvidia.com>
In-Reply-To: <20250214172032.GA241035@cmpxchg.org>
References: <20250214154215.717537-1-ziy@nvidia.com>
 <20250214154215.717537-3-ziy@nvidia.com>
 <20250214172032.GA241035@cmpxchg.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e0d728-7c68-4c70-7c75-08dd4d22051a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vQHIhKFxn3ZICWcghQI2T5OFtLdSTmLpbBgdBBXkX6WTYIj1CTp2XMJdM90p?=
 =?us-ascii?Q?OILK1JEyBx1Dv4JHunCF++626o0kHBsx5IUgOnEfU0zD0wKE4xZZc33bpb1/?=
 =?us-ascii?Q?b5Jhm8Eir3DWTwR7f1BDBM9uYX4eK6HUyK/SA6vtXQ5CVleWAY+EaSS1V1R4?=
 =?us-ascii?Q?Waxyam9MgmBPDvyKK+oLenGY7o7Xyx/AEAgkpvgEkaWCMpQWb3aqhqj+gQ+R?=
 =?us-ascii?Q?Z+/WgXN6pMaiAATtYya+/HoFIhie0yOQnOgo5te2VjEhCi/cPazQ2dzAJvah?=
 =?us-ascii?Q?G2M0Kc7GofK0tnvzcuwiyU6hND16jr9desos4kZ532WcSp+lUthegxgYcI1j?=
 =?us-ascii?Q?iHZnwHARCGsdpzDuwSUJTCBrM9oBg4w2qW+nBLl8mHvf7kOxvwVy5xiwgtKu?=
 =?us-ascii?Q?nBAZSfPwE7bnWRV0YrrJx6A/skFbb+NQtjwam4NXKAIR5/qEcrZGAavUsK+p?=
 =?us-ascii?Q?7S4IKzWeNpTdMno3GjguZNz3dDwZbV4zarMU7iWRaWHdzKiN+Ivyh7VUIt5c?=
 =?us-ascii?Q?T5UsDpDsNBRe3X77ALrns54gB2cEK6U7BRJC///lg64IxRp9vXcOBXwutAVC?=
 =?us-ascii?Q?X35FkUOvqIHCHc1vx5dIFAnn+rTgwjYTzPqycfC04EmiIUoi+JmLKeuf7HFe?=
 =?us-ascii?Q?F/C1NFjaKEjuAtI6fjKEBYJ7MDcF6r/C/YxWzMJS5/UsNVZy/5DodjuUWBf6?=
 =?us-ascii?Q?CCnFn55otG8dXknqBTnRq1SRi2XBcBzhHyR7kbLebgpf7pSXTYrbv7ZKltHF?=
 =?us-ascii?Q?Wa8Yf+U9j0DEQFQIZyVCSOnmY01RG2RWFjg9v1I5Kc1MqukJKGXodTJlqLLD?=
 =?us-ascii?Q?3LZz781wx2QxFOq/JFX4sEUixHh24TOmdCzSlzTbW9Je71OSeSuAxR4zCpxk?=
 =?us-ascii?Q?v/cwTfI110Dy1toKdFQ8WyD4EoDEqo1v4LbtwDUQdMJBW35IZAoGQ6QttxWd?=
 =?us-ascii?Q?E7pg8WFW6oaMiG70mMRD3g7EAhI5x+VQ80vK4/NUE4cWnvcsWe130R6MW/EG?=
 =?us-ascii?Q?smnXCLdXXotyf65YgR+v0zut4KGBDX84laAYGyaAgd3NcYovIwu115RqbP3t?=
 =?us-ascii?Q?6Af5ZUKnhKgLjb0QKjWCYrRG6MRGL/xpuxdjzxClUI3a07LJx8mVISmtphQe?=
 =?us-ascii?Q?AERWgGPFeyhOqU7rMUI0yWVnisP/ft/Y8692K8xVB43YUpoXDSBVc2Nh0dvO?=
 =?us-ascii?Q?TWlofyXl6OX2+ShPLXFeng/+bK3MqFqqPjTA/ITpORtAwfbmOdQOwAWztKF0?=
 =?us-ascii?Q?6DETUnQRbbrA01r+sIyYjSswEr58Zn1/FwRHtD3x5B9VMX28GyqpMiX2HxtF?=
 =?us-ascii?Q?gP7FmmMZCE4Dlc5djphg3mL8rlhsSglqeTK5UTxA1xjDmKh1HwHelZwQw+V8?=
 =?us-ascii?Q?5cV8FReX+y/MBCXA5bzpc0D7T0jT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7BbTGW57FM8fRZmyj4hpTqmUfOJYG0Qej7Yomzr93H4LdjGt2mgKJOEL+Gw?=
 =?us-ascii?Q?mn6xsP570YUv2gN89OAlEk6/rwvdhZGrhdWJuDQc4v2zHouqe7cnuO8fOck1?=
 =?us-ascii?Q?SiiNHYPPpBhASInA+1PPEllHBZLNAtGmGLXR8yxX3trFe/09Mi2FlZjdVnpE?=
 =?us-ascii?Q?S04nAPSYvA/uVmNFp/zARDdACrD2HvJaHWTRgzA9nyyJZHXmak7oZbQQapeI?=
 =?us-ascii?Q?bM+ZKyDNShryIfSfLVzOnPt7xr2IRr+uP8hzqg6BnnIfOslj3dhRPyO/vPk+?=
 =?us-ascii?Q?e0Q8W0csrq2vOud28sRQsq5PFjiUPSbsMbplqzORYq4F9CPqbiGzOY2WkKPx?=
 =?us-ascii?Q?cawyB9b8WG9rtl7GNsxAa4vMeCH5ypcXWYuIGGhy+tDD20cJe3+fWsZt4+KK?=
 =?us-ascii?Q?4JIiDyb8kiAJAGaTg/h76SoTHtn46U7Mc06674pN6dsf8aXjePH8KP97f71i?=
 =?us-ascii?Q?b+4Lg5u4o2gPam9a8WfBU8BV+FG+3M4Z0L0vBZe2n+8vxv6VDKecIdoFRiRL?=
 =?us-ascii?Q?WLMkp9CE2vOPfz+WPZs1YoGdjzK55oKGDusK7BjeIMkpNmUDVygJ2Y9Xq3X5?=
 =?us-ascii?Q?Y4r3VKO0lmOoOhNqbvAsqrv33jG+NxxIoSqSpLPS8+luZAgDPGjYTrrKxXSO?=
 =?us-ascii?Q?33n5V1A/v6V0wZzIBJXHRhjMZqKFWRtXymMqu02hSEyTVgkVSchAbB9F1PwA?=
 =?us-ascii?Q?HoPsA771Gfzy/SFXjjnkyQ8Jz/iNgsoG9MI7dhKdUyVISj1JNJz1Mo6Zihub?=
 =?us-ascii?Q?4mFbsWhevq8mCjFhF9q01yKNCoB5fJujo8vSKonPFIPKRaISHNk4GG+pWhcJ?=
 =?us-ascii?Q?ye2eMM8SsSyPySah5+89j3omcJR+Ji1Xaqa19SVBLnLuqrOLM16UoYvDiqLP?=
 =?us-ascii?Q?PWuzHoFZ6OOQ9FQnLUDoF0cWEZyHloVn/nYCMBgMOZMyOFFAo0uz7+gwinew?=
 =?us-ascii?Q?Cay9GrxPAAgN+WbP1HiyrJD9npbRNGMmnuyr5jpLUK4q3k+pQ7riSez4sDTG?=
 =?us-ascii?Q?GV1Nc4Wf5w2amhM2/UY1eR01akKG80xCxZqsn8snlCqPgbKs19q9e5c26Q2b?=
 =?us-ascii?Q?Snt2oHOSaNgluXMFOPYBZy0SmcTBONxlR1XySYRi1ld42AiqIXYFrs6yeuYe?=
 =?us-ascii?Q?EBwyjIldYmGV3OYVir+dRC4dpa0Ghz6GdOSpAYoXAJKClr2r/nwG2S2hI3fP?=
 =?us-ascii?Q?XFHQdRq2yfUELSWHe9/QyJaCZL6Yb/I14BwUE4uhcmfX8kKu18CsBcyqeDw+?=
 =?us-ascii?Q?wLJK0KYTCqIgUqAwB9PBkkN1h0Oxg14FBsjRD9dY8FIdqmihSSq6W25TkIsM?=
 =?us-ascii?Q?kvEMre5hyn/7GK/cXZtwl4lVn6BKbe4AD7W/sqetzegxZKBM1THALq3VWXb8?=
 =?us-ascii?Q?+o7LPo5KecCCL3J/kb3+n/uILgCbBTONCSnb53J9t3/NtbbwJZ0FN+ORYHUv?=
 =?us-ascii?Q?E7r/jF9OqEhMdnpJojacrbOBfurg2XmBTOcVLOZ2Fi3HqpaNvrwQxCCk+uUa?=
 =?us-ascii?Q?kL1Zd/2yX2MR4enBSrtaxm+XrK6YVhNyvqG/o/ruP5OimGcDQ19ZMZdmOUx6?=
 =?us-ascii?Q?sQAClOauE56rpmioatVIdS82JjokqONp515YEdUb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e0d728-7c68-4c70-7c75-08dd4d22051a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:04:26.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2XuNuY15ir5nUlX1ccXbYDp7NG5RgfiEAdlP9Yr/dmEtdiUQKujD1yEa5kpI9JI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

On 14 Feb 2025, at 12:20, Johannes Weiner wrote:

> On Fri, Feb 14, 2025 at 10:42:13AM -0500, Zi Yan wrote:
>> Since migratetype is no longer overwritten during pageblock isolation,=

>> moving pageblocks to and from MIGRATE_ISOLATE do not need migratetype.=

>>
>> Rename move_freepages_block_isolate() to share common code and add
>> pageblock_isolate_and_move_free_pages() and
>> pageblock_unisolate_and_move_free_pages() to be explicit about the pag=
e
>> isolation operations.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/page-isolation.h |  4 +--
>>  mm/page_alloc.c                | 48 +++++++++++++++++++++++++++------=
-
>>  mm/page_isolation.c            | 21 +++++++--------
>>  3 files changed, 51 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isola=
tion.h
>> index 51797dc39cbc..28c56f423e34 100644
>> --- a/include/linux/page-isolation.h
>> +++ b/include/linux/page-isolation.h
>> @@ -27,8 +27,8 @@ static inline bool is_migrate_isolate(int migratetyp=
e)
>>
>>  void set_pageblock_migratetype(struct page *page, int migratetype);
>>
>> -bool move_freepages_block_isolate(struct zone *zone, struct page *pag=
e,
>> -				  int migratetype);
>> +bool pageblock_isolate_and_move_free_pages(struct zone *zone, struct =
page *page);
>> +bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struc=
t page *page);
>>
>>  int start_isolate_page_range(unsigned long start_pfn, unsigned long e=
nd_pfn,
>>  			     int migratetype, int flags);
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index f17f4acc38c6..9bba5b1c4f1d 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1848,10 +1848,10 @@ static unsigned long find_large_buddy(unsigned=
 long start_pfn)
>>  }
>>
>>  /**
>> - * move_freepages_block_isolate - move free pages in block for page i=
solation
>> + * __move_freepages_for_page_isolation - move free pages in block for=
 page isolation
>>   * @zone: the zone
>>   * @page: the pageblock page
>> - * @migratetype: migratetype to set on the pageblock
>> + * @isolate_pageblock to isolate the given pageblock or unisolate it
>>   *
>>   * This is similar to move_freepages_block(), but handles the special=

>>   * case encountered in page isolation, where the block of interest
>> @@ -1866,10 +1866,15 @@ static unsigned long find_large_buddy(unsigned=
 long start_pfn)
>>   *
>>   * Returns %true if pages could be moved, %false otherwise.
>>   */
>> -bool move_freepages_block_isolate(struct zone *zone, struct page *pag=
e,
>> -				  int migratetype)
>> +static bool __move_freepages_for_page_isolation(struct zone *zone,
>> +		struct page *page, bool isolate_pageblock)
>
> I'm biased, but I think the old name is fine.
>
> bool isolate?

OK. Will use the old name and bool isolate.
>
>>  {
>>  	unsigned long start_pfn, pfn;
>> +	int from_mt;
>> +	int to_mt;
>> +
>> +	if (isolate_pageblock =3D=3D get_pageblock_isolate(page))
>> +		return false;
>>
>>  	if (!prep_move_freepages_block(zone, page, &start_pfn, NULL, NULL))
>>  		return false;
>> @@ -1886,7 +1891,10 @@ bool move_freepages_block_isolate(struct zone *=
zone, struct page *page,
>>
>>  		del_page_from_free_list(buddy, zone, order,
>>  					get_pfnblock_migratetype(buddy, pfn));
>> -		set_pageblock_migratetype(page, migratetype);
>> +		if (isolate_pageblock)
>> +			set_pageblock_isolate(page);
>> +		else
>> +			clear_pageblock_isolate(page);
>
> Since this pattern repeats, maybe create a toggle function that does th=
is?
>
> 		set_pfnblock_flags_mask(page, (isolate << PB_migrate_isolate),
> 					page_to_pfn(page),
> 					(1 << PB_migrate_isolate));

Sure.

>
>>  		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
>>  		return true;
>>  	}
>> @@ -1897,16 +1905,38 @@ bool move_freepages_block_isolate(struct zone =
*zone, struct page *page,
>>
>>  		del_page_from_free_list(page, zone, order,
>>  					get_pfnblock_migratetype(page, pfn));
>> -		set_pageblock_migratetype(page, migratetype);
>> +		if (isolate_pageblock)
>> +			set_pageblock_isolate(page);
>> +		else
>> +			clear_pageblock_isolate(page);
>>  		split_large_buddy(zone, page, pfn, order, FPI_NONE);
>>  		return true;
>>  	}
>>  move:
>> -	__move_freepages_block(zone, start_pfn,
>> -			       get_pfnblock_migratetype(page, start_pfn),
>> -			       migratetype);
>> +	if (isolate_pageblock) {
>> +		from_mt =3D __get_pfnblock_flags_mask(page, page_to_pfn(page),
>> +				MIGRATETYPE_MASK);
>> +		to_mt =3D MIGRATE_ISOLATE;
>> +	} else {
>> +		from_mt =3D MIGRATE_ISOLATE;
>> +		to_mt =3D __get_pfnblock_flags_mask(page, page_to_pfn(page),
>> +				MIGRATETYPE_MASK);
>> +	}
>> +
>> +	__move_freepages_block(zone, start_pfn, from_mt, to_mt);
>>  	return true;
>
> Keeping both MIGRATE_ISOLATE and PB_migrate_isolate encoding the same
> state is fragile. At least in the pfnblock bitmask, there should only
> be one bit encoding this.
>
> Obviously, there are many places in the allocator that care about
> freelist destination: they want MIGRATE_ISOLATE if the bit is set, and
> the "actual" type otherwise.
>
> I think what should work is decoupling enum migratetype from the
> pageblock bits, and then have a parsing layer on top like this:
>
> enum migratetype {
> 	MIGRATE_UNMOVABLE,
> 	...
> 	MIGRATE_TYPE_BITS,
> 	MIGRATE_ISOLATE =3D MIGRATE_TYPE_BITS,
> 	MIGRATE_TYPES
> };
>
> #define PB_migratetype_bits MIGRATE_TYPE_BITS
>
> static enum migratetype get_pageblock_migratetype()
> {
> 	flags =3D get_pfnblock_flags_mask(..., MIGRATETYPE_MASK | (1 << PB_mig=
rate_isolate));
> 	if (flags & (1 << PB_migrate_isolate))
> 		return MIGRATE_ISOLATE;
> 	return flags;
> }
I had something similar in RFC and change to current implementation
to hide the details. But that is fragile like you said. I will try
your approach in the next version.

Thank you for the reviews. :)

Best Regards,
Yan, Zi

