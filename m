Return-Path: <linux-kernel+bounces-416118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068509D406E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908481F24DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024C21514F8;
	Wed, 20 Nov 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+ng+ijR"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B814A4C6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121201; cv=fail; b=nmV/tK2ff5zAAYLPpBYOEqyu3D+ax3ILZUdFEwpuToFOjhdiQLPdxFHpajqWqtzrsQHDA9V6KLh4gIoLbpe30bQTLmRlM8XI9oENCgEqyDellbMLOBmF/i5dxnmu5PMgtubF8/IFM1b9MS5efKjA8n04o58+klGtgH14Mrnrc1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121201; c=relaxed/simple;
	bh=AEP/xRGIBTCthCB9l5oNxPGVOgYtI/4GiZ4ptymiluE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k0DoGdGeG0/KOz2Q7+y6OIh4+1fQ/RcYAYapAC6yePbKL5Mf8FNWdSUEkuF4RraLfbCRHpbd9L4xAVrH+bNiTlxHNyKrCiHTUKIwZ4zQyOmzaT5N8CqKIypADQ9SEZ16myGQdqf3tlF4MFNIGoXcEvDIAsvBsWsW5o1kPzCKSpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+ng+ijR; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD+7w/Yw0kbj2KeYNby8PCmEF6rbsrw9esZkzQErpbuHcwVcdFrx33e0zdDi+AQjsriUcyzYXCgMnqs6CYRHNCdM+7cF+tAuN2zDo8HcQIpKY+PWmf80Gi7+u9w+h5/sZUF1d+1Mg0T6lt7170YUclHTm7GugY3LQAtRpELOPf5PoacBz0C36j1FHH8vy/C+cxYf738atSADqxbzg266UrVzUxgC0lr1/9tQmzEoatHjrPUmtgw6mnmj80+iGCCZQXQgxD36n8BZ+JE9aTV2dGngwUAX/7rKxdkf28SW0Pw+jLkTlUufo/KeGhrn8Rrt9uQ1wCdlihppwYKaHS2MZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCSWHN/gssUDCtZmvVF6fRKrZ8yE4RmJc7Ou+reQdMw=;
 b=MEK+cPkXxQawCwUitisRY6B7hSks6SzV/QKUFdwO/cQZUcNSonyK9Uto2NLwsL4zk8kSevpxwSK05hlgAP10ZVYxkbDflMMOzTErQ7EAUdsUBjW5R9LkM7KLa1fSFQB1l6iJFYTfEzXIzJPL9lWNoJsKR9r9qptLuDWBcAAfZ5IO/x6h1RaP1Pti/9WtYo/yoDm+S2uISVTVuLe7ux0nf6Ga9+A4/NR+8+aGub77MMz47XZAjHnh9tA9f/fMppHJo7tbTvSohai9fQk1mbLSWD1dG2m1IX2YOpWFdCsL3Y+lkZ8xFDZRySy6VN9e6dWDVHwak28qcY4yncm5CKqT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCSWHN/gssUDCtZmvVF6fRKrZ8yE4RmJc7Ou+reQdMw=;
 b=V+ng+ijRdPICR8F2U8Y3LCdjRG7b3Bwp9tS5Fsk6HkTLC9XIKzjli0S8ogRuUC9MzdlMUBNJIijQWHp+3LNz90vNeN+oAhBaDp8Z/cL1k4jPPRWdKHlJoSE4gv6UsO8Dtz3lLQqNhVk4j8flEt7WZKrj9RouznduYmhCjPemRIN6RUp7vQdExmqg3gB5UNWa/+xkeayyOZCKVPxwYSlt/AeiccYCou9SkNAwF5Uz6SpZnSTgx+/zA/iL0hdnrvQ9fNzyBoRnjkJIkEhXJ5UBWnLAQSs7qVudtp69SG9dAATxqSRrNYlVHcMhNS15kg0f9jM7OXteoW95jbXxNwButw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Wed, 20 Nov 2024 16:46:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 16:46:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Date: Wed, 20 Nov 2024 11:46:31 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <E0353116-F4D7-4039-B89F-35B7F7C9C2B6@nvidia.com>
In-Reply-To: <393367d3-eb69-4255-a7aa-dcbcbe7a403e@redhat.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
 <00721702-78FF-4690-8EAA-31C367FA9FC0@nvidia.com>
 <1a77f16b-d637-40b4-bf47-a8236729a0ca@redhat.com>
 <57A6BDB9-119B-4C1F-8715-2584046A5EA8@nvidia.com>
 <833078e4-3661-451a-bc11-3cb60a302946@redhat.com>
 <e46ab5c6-8b95-4d2f-b820-14659c615e81@redhat.com>
 <16391A0B-4E3C-4F3E-8904-9034DC87DC52@nvidia.com>
 <393367d3-eb69-4255-a7aa-dcbcbe7a403e@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL6PEPF00013DF6.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:a) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1dddfc-0425-4c1b-fa22-08dd0982e3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FyJE8qpuZ8YsfdLrrEarEMvJtHpGEdmzc3Rdtan3/es5CFxZKiiWNlUuXhgn?=
 =?us-ascii?Q?zAxvAl+9F2HKSlkWTPRiOF4xTU4a/D8crdNa9yIJheJKVjFQzdHvCUqer23Q?=
 =?us-ascii?Q?InFCZLi1UeuEIiAihNWr5jL5Yw1aST0KVEmZDoM+lQhpJmpw5DMSqfKBq9ru?=
 =?us-ascii?Q?VzdLByCYf2jn5pVxSdK6UCZCvZN7MYZQCVwo7HMDRwnubiE2FtQoEq1vAAVn?=
 =?us-ascii?Q?KX16WG0OUirRZOvMuM+UU1J7LNTnRvdBnhE7UYl/ldcUGbjIgpoesHf81JJ0?=
 =?us-ascii?Q?Q2xCAr1DoRcBNn/WneBecOazspuG0t6djbHVMMvfFfpEeniUx186bsNWr99u?=
 =?us-ascii?Q?B9rpM6oCqvpB7Ce96kYa5Fb3UxDabXLQ5w8Br5rCJWrqps4iB2fcaTzSVxYQ?=
 =?us-ascii?Q?XnYsTcfVoVF1DNjxjYleGPyrr90qy/fyf/WOiR3U10CqCAciYoMT5YD4R/wN?=
 =?us-ascii?Q?9BamYt0pgEuy1niIxre/GN6MnfeCDGxfqzNKhgrqw6pYQdmwOvYSqetZeA2N?=
 =?us-ascii?Q?ZmUtDcJ+lwMS2PtZOGXsrm3iY+BJEc39fHiIChCw+k7JWxvW+VoZ2uZeE79S?=
 =?us-ascii?Q?Gns7sfdEDb0cMvWFWBmaSbilmnxrTZWduelGHaZjZ4dr6kp5tgBarwUCeYbi?=
 =?us-ascii?Q?ngSE/hjCCkHLIV/M6dkG60UdHYqbpmb/6AMICFe0EFSUBWSGz1Y/PSH3Cn/Z?=
 =?us-ascii?Q?RT5SrZ0i6CnGrZ65CDIBjwgt6T5wxeUOVwSw++8v6KW8t2j9TAojIJYiBh5+?=
 =?us-ascii?Q?bKoydC3uG/81/KsYaORc9HC9I0GyRDd/OQUG7GofQccJIJlvdfiE1kZRW/j6?=
 =?us-ascii?Q?F/eJM0nwNX7YJZKJoM8DHAX1apOkRd0Ge8zbv9B1L51wY57CqF3Tir07BWrp?=
 =?us-ascii?Q?e9uBPt11/JcZDCoU5iQDjlGupUlg3w66tO0KyAu8d/yyofA/qrVVXbHraD4g?=
 =?us-ascii?Q?uO1MrCxUpkl8lBm0RfaLQ5PzJ+U/4qkGLLXGaBF9q1fbAO873u95I0miXA6s?=
 =?us-ascii?Q?ONJzKzqo7zkvWlw3P8H6amVGD6BtSWqr1bzZjNKT0ImFGzIAgMz0LS+G60mj?=
 =?us-ascii?Q?rN3o3S0gMeavEsdGRvSzpT6wy1qLd6MZVSEb0oi6eJlSSo8HnsCer1ASs8IG?=
 =?us-ascii?Q?R973D4mek46lSOPYgSwkJQoWvsKl2oJjXu1nUpZp/2Lzszdj7E1kAaInfZsr?=
 =?us-ascii?Q?eLi2B9n0p5dsJOzkD/ddefSCuGTpzRA73SchqGrxqn/KbyUvJew8xJTOJBg8?=
 =?us-ascii?Q?jEja+mnElx/Np2tErCtgkNmwkTI37QlCl6vAZBgaKVUyeAqX1xo42J4hJlZy?=
 =?us-ascii?Q?lnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zmP2uo6Vt5O6qIOXp8w7yz8FyUW/9qAvYrbJmmqrPkHyIEgOxoqEJLZNgKe0?=
 =?us-ascii?Q?+jgHtSawrXXGTLDfFf93y/LcKl41FZM5S6cCW4pamTABA0R0W48D5ge7js+v?=
 =?us-ascii?Q?CN08IrADWgu7r+mSMz69tyVNOLFRVoX3k1z0bWhKfQ3la45nAjvPNeDDH9Hr?=
 =?us-ascii?Q?t1gSW/aod4dj2ilIjbbJ0kDlJuUd0B4Uew52cKpgA/k+q11c5F/0SKIUT8g9?=
 =?us-ascii?Q?B+b1LdM27Pv65GTVzBcX0B4kKE+qBQD7HO6eSVOccmfgVnWy3NkENAWsD+G1?=
 =?us-ascii?Q?yi42M7ZAyCDSSiXQvMxnQI9W6Z8NV+HIHo8f8+GlAUdYmDAmVNlhkSvy0e3W?=
 =?us-ascii?Q?wNwPnwC4i7nR3vEZcbpC0ARtgwJL1qOl1rE8/5jibkUGDetVhgiS9+ClzYMa?=
 =?us-ascii?Q?/5rm6Mp+XR8u+ytEWaaP4Jj1uHiOojO+yXQGWeD04vudWJl95Y4/gtSeMz8o?=
 =?us-ascii?Q?aOSHuuLRX6Uqh0jLnLVgJeYIycqsyS+5QNBbfvs7L3Y72TEzLCeVy7dOQVhW?=
 =?us-ascii?Q?Ol80pddg+cLiXel/Wbrb6wy+8r/dt9j5MnYJ73XLBqznLPgJU4UWKIbahrn+?=
 =?us-ascii?Q?xDqd+MNe40tKOh88pp7NBdbBx4G+/8eUN8Na6g7KO92S1wHE0yZg3JNCfsGQ?=
 =?us-ascii?Q?OsUKo5wIk44DGOHwYGaY+BRV4qzfJIY+8vQg859IJ5q0XedAHL9UVXITXHrd?=
 =?us-ascii?Q?OQ6l2ppYRlRW1k/PJdUjXZvBrEtZ/2EjAzcx4/fuP0zfnb1uFy/SZ55suk91?=
 =?us-ascii?Q?xGlcsczpU6wi93OWelc1o9na9pqGA9RIYQt6QbGLz5wZYYWJzJ3vd1lWpwRD?=
 =?us-ascii?Q?xEgYyaNBZz0lSQoonuuX+uq98ZApgyEbrX3No1toly0jMM/D3MK5SdPAuek6?=
 =?us-ascii?Q?ubvMcDPGFhCBjwYv8t+Uyxnr7c9uXlLhG1q9kMLOiMJZNViF8LCXhAojVbI+?=
 =?us-ascii?Q?57uFHwiwplxJiBnyiQaupfEa0Kz3kUz+3iE7gf3/aA6CJM56mETZJDD2pv7a?=
 =?us-ascii?Q?2vyZjce/rW0k1dGZvQL0sFyoih39mqfOHOmWpulDBZ5eezB0FBi3sbr/wR7T?=
 =?us-ascii?Q?uTr0HNsFy6+4Vvh8FpUZ5mY9N44zcQxlhtThDiko05Tqa9mfghRFj4UlTcHb?=
 =?us-ascii?Q?qVg1xwTjRoqq9LwZtuPuQOZ31LzBeU2CEDB8vpgnIs7m/SCiRgmNMKrLxmD0?=
 =?us-ascii?Q?ILWX+MiNe4QsN809NZEeHZ+BTJuBqhoENXGUKVup6cl9ncf9w1MEZgu/bIT4?=
 =?us-ascii?Q?ALYjhstXbUDj10e1+vZRoizjKL6ZRjaX1Sed42YrjunlP7bfu/60s/tIMRDP?=
 =?us-ascii?Q?WkxrwOkItXycV3m1khwJcFFXJhT+YglqSXStkHvnjrm6UzOY87ZCe+mdJ1l7?=
 =?us-ascii?Q?mZXIUamaIAx6Fl90mDgUVAXX9mrJP5td5DGv6PHHBsyhIoVODiH/KAPFAZSn?=
 =?us-ascii?Q?tVcQg5NwtJ04VVGaKwvrAfL3W4i97IFWn7nTnrPOzfAZ6xAL/Qxno6aXzW7r?=
 =?us-ascii?Q?cLYgniIqDXGnG0MeHBcBus2rKInGbp2h2SbF3++uuO+UR22ESwFQriHkY0I6?=
 =?us-ascii?Q?Mv5O++eNGRBC8q0QCDbBdZ1A6Q/1OXsKK+bF8WsM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1dddfc-0425-4c1b-fa22-08dd0982e3cf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:46:33.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbjhNoy6nWvAQRPqbX+1DVvilTfj5L2RFHUsg0EGYYLDXAc1+l1cFZBtpyT3XIAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

On 20 Nov 2024, at 11:13, David Hildenbrand wrote:

> On 20.11.24 16:55, Zi Yan wrote:
>> On 19 Nov 2024, at 11:52, David Hildenbrand wrote:
>>
>>> On 19.11.24 17:49, David Hildenbrand wrote:
>>>> On 19.11.24 17:41, Zi Yan wrote:
>>>>> On 19 Nov 2024, at 11:31, David Hildenbrand wrote:
>>>>>
>>>>>> On 19.11.24 17:12, Zi Yan wrote:
>>>>>>> On 19 Nov 2024, at 10:29, David Hildenbrand wrote:
>>>>>>>
>>>>>>>>> +/* Split a multi-block free page into its individual pageblock=
s. */
>>>>>>>>> +static void split_large_buddy(struct zone *zone, struct page *=
page,
>>>>>>>>> +			      unsigned long pfn, int order, fpi_t fpi)
>>>>>>>>> +{
>>>>>>>>> +	unsigned long end =3D pfn + (1 << order);
>>>>>>>>> +
>>>>>>>>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>>>>>>>> +	/* Caller removed page from freelist, buddy info cleared! */
>>>>>>>>> +	VM_WARN_ON_ONCE(PageBuddy(page));
>>>>>>>>> +
>>>>>>>>> +	if (order > pageblock_order)
>>>>>>>>> +		order =3D pageblock_order;
>>>>>>>>> +
>>>>>>>>> +	while (pfn !=3D end) {
>>>>>>>>> +		int mt =3D get_pfnblock_migratetype(page, pfn);
>>>>>>>>> +
>>>>>>>>> +		__free_one_page(page, pfn, zone, order, mt, fpi);
>>>>>>>>> +		pfn +=3D 1 << order;
>>>>>>>>> +		page =3D pfn_to_page(pfn);
>>>>>>>>> +	}
>>>>>>>>> +}
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> stumbling over this while digging through the code ....
>>>>>>>>
>>>>>>>>> +
>>>>>>>>>       static void free_one_page(struct zone *zone, struct page =
*page,
>>>>>>>>>       			  unsigned long pfn, unsigned int order,
>>>>>>>>>       			  fpi_t fpi_flags)
>>>>>>>>>       {
>>>>>>>>>       	unsigned long flags;
>>>>>>>>> -	int migratetype;
>>>>>>>>>        	spin_lock_irqsave(&zone->lock, flags);
>>>>>>>>> -	migratetype =3D get_pfnblock_migratetype(page, pfn);
>>>>>>>>> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flag=
s);
>>>>>>>>
>>>>>>>> This change is rather undesired:
>>>>>>>>
>>>>>>>> via __free_pages_core()->__free_pages_ok() we can easily end up =
here with order=3DMAX_PAGE_ORDER.
>>>>>>>
>>>>>>> Do you have a concrete example? PMD THP on x86_64 is pageblock_or=
der.
>>>>>>> We do not have PMD level mTHP yet. Any other possible source?
>>>>>>>
>>>>>>>>
>>>>>>>> What your new code will do is split this perfectly reasonable MA=
X_PAGE_ORDER chunk via split_large_buddy() into pageblock-sized chunks, a=
nd let the buddy merging logic undo our unnecessary splitting.
>>>>>>>>
>>>>>>>> Is there a way to avoid this and just process the whole MAX_PAGE=
_ORDER chunk like we used to?
>>>>>>>
>>>>>>> Probably split_large_buddy() can check the migratetypes of the to=
-be-freed
>>>>>>> page, if order > pageblock_order. If all migratetypes are the sam=
e, the page
>>>>>>> can be freed at MAX_PAGE_ORDER, otherwise pageblock_order.
>>>>>>
>>>>>> Thinking about this: why do we care about the migratetype?
>>>>>>
>>>>>> We only have to fallback to pageblocks if any pageblock is "MIGRAT=
E_ISOLATE" (and maybe MIGRATE_CMA), but not all. Otherwise, we can just i=
gnore the migratetype (or rather overwrite it)
>>>>>
>>>>> There are VM_WARN_ONCEs around *_free_list() operations to make sur=
e
>>>>> page migratetype matches the migratetype of the list it is on. Igno=
ring
>>>>> migratetype would trigger these WARNs. Overwriting it would work bu=
t
>>>>> free page migratetype accounting needs to be taken care of.
>>>>>
>>>>> An implicit reason is that __free_one_page() does not support >MAX_=
PAGE_ORDER
>>>>> and gigantic hugetlb folios are freed via free_one_page(), where
>>>>> split_large_buddy() is used to work around the limitation.
>>>>
>>>> Yes, I saw that change. But that can be easily identified cased by
>>>> unlikely(order > MAX_PAGE_ORDER) to handle that rare case in a speci=
al way.
>>>>
>>>>    > > For the two memory init cases you mentioned in the other emai=
l,
>>>> maybe a new
>>>>> fpi flag to make free_one_page() use __free_one_page() for them,
>>>>> since migratetypes should be the same across MAX_PAGE_ORDER range t=
here, right?
>>>>
>>>> In the context of alloc_frozen_range()/free_frozen_range() I want to=

>>>> free MAX_PAGE_ORDER chunks when possible, and not have some odd logi=
c in
>>>> the freeing path undo some of that effort.
>>>
>>> Adding a pointer to that discussion:
>>>
>>> https://lkml.kernel.org/r/ZzZdnuZBf-xgiwD2@casper.infradead.org
>>
>> Thanks.
>>
>> So you are thinking about something like this:
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index b6958333054d..3d3341dc1ad1 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1254,7 +1254,12 @@ static void free_one_page(struct zone *zone, st=
ruct page *page,
>>   	unsigned long flags;
>>
>>   	spin_lock_irqsave(&zone->lock, flags);
>> -	split_large_buddy(zone, page, pfn, order, fpi_flags);
>> +	if (unlikely(order > MAX_PAGE_ORDER))
>> +		split_large_buddy(zone, page, pfn, order, fpi_flags);> +	else {
>> +		int migratetype =3D get_pfnblock_migratetype(page, pfn);
>> +		__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>> +	}
>>   	spin_unlock_irqrestore(&zone->lock, flags);
>>
>>   	__count_vm_events(PGFREE, 1 << order);
>>
>
> Something in that direction, but likely something like:
>
> if (likely(order <=3D pageblock_order)) {
> 	int migratetype =3D get_pfnblock_migratetype(page, pfn);
> 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
> } else if (order <=3D MAX_PAGE_ORDER) {
> 	/* We might have to split when some pageblocks differ. */
> 	maybe_split_large_buddy(zone, page, pfn, order, fpi_flags);
> } else {
> 	/* The buddy works in max MAX_PAGE_ORDER chunks. */
> 	for /* each MAX_PAGE_ORDER chunk */
> 		maybe_split_large_buddy(zone, page, pfn, MAX_PAGE_ORDER, fpi_flags);
> 		pfn +=3D MAX_ORDER_NR_PAGES;
> 		page =3D ...
> 	}	=

> }
>
> Whereby maybe_split_large_buddy would check if it has to do anything wi=
th the
> pageblocks, or whether it can just call __free_one_page(order). It woul=
d only
> accept order <=3D
>
> In the future with free_frozen_pages(), the last else case would vanish=
=2E
>
>>
>> Is it possible to have a MAX_PAGE_ORDER hugetlb folio? If no, we are g=
ood.
>
> Hm, I wouldn't rule it out. To be future proof, we'd likely should add =
a
> way to handle it. Shouldn't be too hard and expensive: simply read all
> pageblock migratetypes.
>
> I wonder if there are configs (no page isolation?) where we don't have =
to
> check anything.

CONFIG_CONTIG_ALLOC? CONFIG_MEMORY_ISOLATION seems too much.

>
>> If yes, alloc_contig_range() can change the migratetype of one of half=
 that folio
>> and during migration phase, that folio will be freed via __free_one_pa=
ge()
>> and causing migratetype mismatch.
>
> Can you remind me how that happens?

There is a MAX_PAGE_ORDER hugetlb folio across two pageblocks and
alloc_contig_range() wants to get a range that overlaps with first pagebl=
ock
of that hugetlb folio. All pageblocks are marked as isolated first during=

start_isolate_page_range(), then __alloc_contig_migrate_range() isolates
and migrates the hugetlb folio. During migration, the original hugetlb
folio is freed and since it is MAX_PAGE_ORDER and based on my code above,=

it is freed via __free_one_page() with two different migratetypes.

But with your maybe_split_large_buddy(), it would work.

>
> Likely, we isolate a single pageblock, and shortly after we free a larg=
er
> page that covers multiple pageblocks? So this could affect other
> alloc_contig_range() users as well, I assume?



Best Regards,
Yan, Zi

