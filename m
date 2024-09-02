Return-Path: <linux-kernel+bounces-311610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB2968B23
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB0B1C2217C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F911A3036;
	Mon,  2 Sep 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USb95rMP"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F111A3040
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291269; cv=fail; b=hyFY9oik0ShucDzpJmqyqkKhVVWng+XHeMCRLFKZ9dOXzVR7vdod955XIpPsZAANL/ggTuSeX92QkpnLzu6BBhD2DDmXB7ghvzA8x0VKl5fj6IbHEdsU4wSKluZ2mHpqf2M9BSlp8D6OzBMrG9qxKnRnscD6NAYdYOsfFxz0TrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291269; c=relaxed/simple;
	bh=VV6MRt/asQrFejt24h5nCTENY+w3b+n5qkO4GKvN02k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=icNIpfS8clHIheoaCjBhu9AphMXg0JiBr5n8p6Y1SbWTR0F6fZuCTeoc3Ohh1Dq7bOzk26BEaltwoF1edCzBCvgWP63OwavOq53OzlSdAOI1PNEqcr4cturbWgA9xuq+FG/P3k7kOyyLWibbdX4g2fDLvw/9/4Pkr2+1TYp/3HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=USb95rMP; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ay8INMKp11vCq2Isadwz1ZME0nSF8lXhkEcquIwwWA3aUuFwMuS6N2+WZ+M9X/t1evk92LZ4Y2GzO9HwbH8qTZkA6obXFsPzfmwOYy7cgGCM/f09n2zY6c3ELUz40bBMFSO0DIJMfeDo2YvJNBi1KHrhC7WQ4ggxAgni65rRqO0Gaad5c5hHVUGf8M7ZSgE9czfv8c5pgDOsj2jV4J4qj4O6F+P99D3S09+H6hN1cUJ0IzyJ8OGA8OziuMhV11tQC5adlPZPk8GT8OXJbNjenVY0aqidVlEaI8xydmxbz8rlvfKpkrKIhKzjbfv445lpe488WpRYEful0gTxUCSsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo3VVlobYAnsEgqqy3OYDpCkrRcbecSZAYfT22JTwic=;
 b=w3VP2I7BGVR5MDkL+RAQo2/R92Niih81Hc9GrYzo22udn0coOuqqCpeZ6wyYWYcu3QpF/KSiL5CmKXP2IKYZVTN+K2BSVX/0IErPO1uUhzWZw7Nj2hy8XznGmtu55lPdh0LZ5D8CKAydSqsTZMecM/rYlSDldWvTxvo0+lJO+Do7A6ZWzHxyEg7AMLY97v6X1abl5fN3MHEP1ZVN0+GZmpkMjWsI2uMurH+GAXWoasjiL+JaFpdeTGilYVInDCVvnc5HgVcWHa4S/EdNifG5AKf1SIg6nww1dTQAiB5c5ExUEuUxZIN+/E9vNyiqpieCDS0KML+L1djm/EPUZ7ww9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo3VVlobYAnsEgqqy3OYDpCkrRcbecSZAYfT22JTwic=;
 b=USb95rMPwNIwRKQd9HbI5DkelMlO9Wt0I4d9Q1OO+0ffAiUjeq3yKUQbM1RYlPOHzJGqeNUEMnWSKX+o2MZEpRq/2/dilxqO2qy6RRssk4YlyGVk5O1gtxpn5+GiA23SsZdtVi9CTchRenex910jM5kEHiN5cP7ghGQIenXZKSUze3TOQ3CaPgScrxSVDkis+0v/dIfpwHAswFC0zRUaxQ7JHc9YeqL5buDASZF9duqBV03wfKHy9CiK/r2F0gr+CEn1AnZ930XAwmxSdBa/6Hp8ZBheV21Q/4dxTK8oYFIWsit6OyAKkFIskm9FdZlxEvWk7zLdc9+IQSkXdrLeJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 15:34:24 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 15:34:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] mm/page_isolation: remove migratetype parameter
 from more functions.
Date: Mon, 02 Sep 2024 11:34:22 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <E48CFE6F-05A8-4D12-84D0-2B6F7484974E@nvidia.com>
In-Reply-To: <a43c866f-b281-49d3-b503-f5f86dadd306@redhat.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-5-ziy@nvidia.com>
 <a43c866f-b281-49d3-b503-f5f86dadd306@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0345FC7D-70E7-40F1-8EBB-0DC6E361E0C6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a036a3f-b8ec-4c47-61a3-08dccb64b941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LWbWVIYjtUqTeTwBE7ms+AK10HqFWwa8pxN2BiJvbF/pKkjB3AvuIvWy2j9w?=
 =?us-ascii?Q?3VJIX+zJuLmqtLRZrgmBr69AFNO4FXf8M5vDZlvOBJknza6cVCnfetANwbuA?=
 =?us-ascii?Q?KeJX6Jpux/rWpj0+4lPBSixIEaAv//BrPh5x1/cDVrcgTDfm50bPHJ5E+WEV?=
 =?us-ascii?Q?AMUA4y/VQ+oEfjwMr9ju3F5dgEm+eBG3c8uRaFI8KFG0RG3x0Qxy6bFIJK9U?=
 =?us-ascii?Q?qMLv3A9f1dpburlX9/Z26Xe3BfDs5m+M3196A1D+ebr2D5Yw6jsVaG10jZBW?=
 =?us-ascii?Q?K6gcNaBKmeEsYj0bR44NdS00nI2d2e1k4SKEuF+xo+8UDqsLjo4zkZ7TPDAM?=
 =?us-ascii?Q?cMTZyWt93vIrZAzGHnetZBuHWYjQ/EmARUV48ilxYYpuOp8+sfYrP0bjobMF?=
 =?us-ascii?Q?XSb8lSs2/5J8yLOWEsCqI+vavA3l81RdpMmn5PnQRb/OqLJRsGNcFSIz9YQY?=
 =?us-ascii?Q?1ppYor1Hl5YLjEfjIhgWPP6J2z3HMF//Nfc7T6z3zYbFP/6KRP3HBKos+Cfd?=
 =?us-ascii?Q?tB2jmd5y/W8b1SJ9z6/jmevTfvXEBriVb0BO4d5TCVOdCL7v4t9wDIa9x9aC?=
 =?us-ascii?Q?HmyNDNNfYKUs8l7FAMtAvJIw2iKmBsmM/oi9e2h0keVx+aqTdIxsF7JOcqc1?=
 =?us-ascii?Q?Hy7yjHRW/xlSOxRkjmoIvw8rgvu2QrqOxJHxJDIEzzzsyx7iMiH0X4ipFAv5?=
 =?us-ascii?Q?7IQKubDmDmqrMfBysgoxwV1BjsbsIPjtBB/tDxh4GfkyFhKZWlnNcVT93Vk7?=
 =?us-ascii?Q?jrku91tj8Py7QCPyB8H2OdKXNPZBv1uLQk34Q6YoueT2IZuPQZCP9W/Jxnhm?=
 =?us-ascii?Q?hUJ+qODSsFzswhdDSC/U51OwRIr17UNdwxsT+s5I8oDu8kTVsvPrkoA7JuXz?=
 =?us-ascii?Q?2Ob/T1UedsRlrKFM4td0ghfS+cwUk5oJ0cHN8oRZ5IUpCkJjbMY9qjBvPOmR?=
 =?us-ascii?Q?SpDTI2Rk/yiGBrysnSAd+TgkkKTx/n4jsObMtMcmCAjB539VZiFQgaOMGFL4?=
 =?us-ascii?Q?tvxt+qicphusEyW7+b/0SSlu2zYtYrPiXXhvEBdO66IABRhw3Egbe3uC9++S?=
 =?us-ascii?Q?cpdlagyEpxnzsI8SXrFTuEDw2j0hrxsKyIFgJXu3X0p7Ez3+kMY6jolTg9pG?=
 =?us-ascii?Q?2b1frGA1VuqZvuExwpK61/ZNff5ahu8sCg/NOzlu7vN+XU6Oevv0e4xAMsu7?=
 =?us-ascii?Q?TaDsmb2SQG59sXpSu9/ubKZdgzlOladmDUIzDG3oqmNxkPmBOb9Q8/dzoUBo?=
 =?us-ascii?Q?i1VSqwJ49Dz7F3qnPPdw5eVW0XHRDUHdc+IGUMD3e/RjsxE/lMDdKmZ6ccLg?=
 =?us-ascii?Q?aFGTRRz51Cnrz04Wf3uCwBYXpJRhv/wwgculCECF67LGGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2f9f2WERdZiFoSoAPTLtSlZXfY7hIak74JP5KdNB2p92EauSZ/+obui0FwI?=
 =?us-ascii?Q?hRYLp/HWB59fw4g9+1a7NZtMC4x0y1CEM1yh6438tK1blfiRwXy0CqYcTHgI?=
 =?us-ascii?Q?cGhqcPEKwNbV7/3cyfbWVWe37hetrQgeZPgvquJffSuxobkEurwekVdtfymm?=
 =?us-ascii?Q?wNGZGZIUqnUTMLiOi+7hIViJQWh42f0ZXOzUw6AVEVgEw0uIZKszrr/bfdEB?=
 =?us-ascii?Q?Axdq6PCKUocAng6XoRcHMnYHAEca9cx9sLvlace8eZKHqlgkf/Qb5hDWaoU9?=
 =?us-ascii?Q?tGt3joVJh/a+XNnHw1SWMdBjXX9Eb+4SFbUBvexhJEPPb7Gwb362kEe9RJF2?=
 =?us-ascii?Q?jW+lRaA9tWsp7lTVrGeYbAJ6pe2F0oC5O+XqCoLjl37b4V+xe87hxXPuxLPN?=
 =?us-ascii?Q?twOc7gHyVwWz0s0fkXouKHeSulGF6ZDe3tS9APT0vPOZOq9Amy/nPhpBPz1l?=
 =?us-ascii?Q?ciDBZ5q+wexoheLai6RGnzT0hlSn/gD4rrsAK2ZCpfDOpYHFazchOE9du94z?=
 =?us-ascii?Q?2QQ9nhaMDUR/IHIu2v6L7kD4bJik6hRo/uMvw2a3bq3M9PmpqtAmpQhfVbXa?=
 =?us-ascii?Q?xjQU/uAM5ebgsdvY1sKJ0fjMx5kPGq9rpG1ecSNtvM86t8M+ZqMPXg97KtTS?=
 =?us-ascii?Q?tsEq86XW00mCb0zHHiVzfeG5b2z99tQ5WpgRzW7itLJ+A22VQmw06kvZOlgY?=
 =?us-ascii?Q?YUSHTOZCCbJHKb81yBsqCYrFY2kMse5KdaS8KaSf6Wv00Ee9vf03leO+dtRV?=
 =?us-ascii?Q?s0Xq0KPa7MmmZ/sux7D38EEOM7GDYqSKnl75v48++56uvM2HiApKFr8W5jW3?=
 =?us-ascii?Q?qgiOJX2XoTNw5qXe+hHg3Z5kjufmJtTakpOrnConv1Dbch39BC79Z+bga2vY?=
 =?us-ascii?Q?nKHow0qP4z8b0kGR5qR/rxykjkEdg7FS0bJ7gjUgleqj9D1TpBN4FAj8+WMz?=
 =?us-ascii?Q?/UWe+BafFtpeMWNwkldohlvzcITt62jbOLW/mdSSNZE5+obvVHbUFuMcO11W?=
 =?us-ascii?Q?2XV/hEtWcxMEMVswBkG8im0dxAm8u1eSI9VcI0VrMiP07TxJAJyVkNWXUvXA?=
 =?us-ascii?Q?esybPfPtJwpQuTKpLvh2MWVCdD58TT2hVeGUHtROMvUz8nHOjfwloBYSP96x?=
 =?us-ascii?Q?2yOLwX7cRBU0Ujm92EeYDq264ppSIoJNdUKhlksbR7Xi2xbyMohCMxy6dBTz?=
 =?us-ascii?Q?3+X3bZQefc8cZSEGV7qUoOIn7t6NtFwfQUC8YCFJtXq5vKIz7AIrrwWZzI/X?=
 =?us-ascii?Q?GWrZXOGyd7XD7g3mXAjV/bX4neUtON3uC6X+RQKuahxwTKxslcORZ46LxJ6D?=
 =?us-ascii?Q?93ZTp37sbPPoe9Q4Pt1Dx8YBX1TwS7FnibS1O8UrRQQFT7aFs2Ma+ptTK7Fw?=
 =?us-ascii?Q?nuurnseZdREZmk7Hg6owVqvClUBIBcyC83SBlnSYqAAmTMMp3nM6RULvn4Bg?=
 =?us-ascii?Q?o/3kX9m+Bmzr9p0j2Z1IIOrW55IMCxEMiKPU4k6UQ6azf1uvCsTW2mxJVj+S?=
 =?us-ascii?Q?9DevDI0xontCh/JRBj384KQ4a+RXmhNgGzdwWCNSeGmZQtjaepAO68gSH4gw?=
 =?us-ascii?Q?/SPLTwdLw2t0ziTMPE/ePnKtgBDo0lZX1yLy+1Gl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a036a3f-b8ec-4c47-61a3-08dccb64b941
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 15:34:24.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ/a59SvvGqz/bCsmyJegIxo4Q1M8yJjdomCy9mlvzELO+pyo5P1mhHnuQjQdtFe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

--=_MailMate_0345FC7D-70E7-40F1-8EBB-0DC6E361E0C6_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2 Sep 2024, at 5:06, David Hildenbrand wrote:

> On 28.08.24 22:22, Zi Yan wrote:
>> migratetype is no longer overwritten during pageblock isolation,
>> start_isolate_page_range(), has_unmovable_pages(), and
>> set_migratetype_isolate() no longer need which migratetype to restore
>> during isolation failure. For has_unmoable_pages(), it needs to know i=
f
>> the isolation is for CMA allocation, so adding CMA_ALLOCATION to isola=
tion
>> flags to provide the information.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/page-isolation.h |  3 ++-
>>   mm/memory_hotplug.c            |  1 -
>>   mm/page_alloc.c                |  4 +++-
>>   mm/page_isolation.c            | 27 +++++++++++----------------
>>   4 files changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isola=
tion.h
>> index c2a1bd621561..e94117101b6c 100644
>> --- a/include/linux/page-isolation.h
>> +++ b/include/linux/page-isolation.h
>> @@ -32,13 +32,14 @@ static inline bool is_migrate_isolate(int migratet=
ype)
>>    #define MEMORY_OFFLINE	0x1
>>   #define REPORT_FAILURE	0x2
>> +#define CMA_ALLOCATION	0x4
>>    void set_pageblock_migratetype(struct page *page, int migratetype);=

>>    bool move_freepages_block_isolate(struct zone *zone, struct page *p=
age);
>>    int start_isolate_page_range(unsigned long start_pfn, unsigned long=
 end_pfn,
>> -			     int migratetype, int flags, gfp_t gfp_flags);
>> +			     int flags, gfp_t gfp_flags);
>>    void undo_isolate_page_range(unsigned long start_pfn, unsigned long=
 end_pfn);
>>  diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 4265272faf4c..fe0b71e0f307 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1993,7 +1993,6 @@ int offline_pages(unsigned long start_pfn, unsig=
ned long nr_pages,
>>    	/* set above range as isolated */
>>   	ret =3D start_isolate_page_range(start_pfn, end_pfn,
>> -				       MIGRATE_MOVABLE,
>>   				       MEMORY_OFFLINE | REPORT_FAILURE,
>>   				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>>   	if (ret) {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 4d06932ba69a..c60bb95d7e65 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6607,7 +6607,9 @@ int alloc_contig_range_noprof(unsigned long star=
t, unsigned long end,
>>   	 * put back to page allocator so that buddy can use them.
>>   	 */
>>  -	ret =3D start_isolate_page_range(start, end, migratetype, 0, gfp_ma=
sk);
>> +	ret =3D start_isolate_page_range(start, end,
>> +			migratetype =3D=3D MIGRATE_CMA ? CMA_ALLOCATION : 0,
>
> Can we have flags for alloc_contig_range() instead of passing in a (wei=
rd) migratetype?
>
> Then, we should make sure that we warn if we try a CMA allocation on an=
y pageblock that is not of type CMA.

Sure. I will expose the existing isolation flags (MEMORY_OFFLINE, REPORT_=
FAILURE,
and CMA_ALLOCATION) as alloc_contig_range() parameter to replace migratet=
ype one.

>
> I'm trying to remember what happens if we try offlining a memory region=
 that is of type MIGRATE_CMA right now ... I remember that we fail it. We=
 should make sure that is still the case, otherwise we could seriously br=
eak something.

Yes, that fails. That is why I added CMA_ALLOCATION, which is used in
has_unmovable_pages() for this situation.


--
Best Regards,
Yan, Zi

--=_MailMate_0345FC7D-70E7-40F1-8EBB-0DC6E361E0C6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmbV2v4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUFGwP/3FjAEde+wl8QXit+oSkk7U2tbktuiMmeSKi
ytcuFK9hWhVb4aTyRSP4tBuwsjIK7ZnhSEgrdPQqVa9GNVe9Ggdx/KSbFsLtfAvn
2ozTfGWE/vXQi9sjyst4DrkwT/0f1XuXndyVqfOAjZyXEMML6RTuXvx9fXjC8CpM
VbvNX4Ba4vFYHrLA0FJvRi2j+9gQlpvIT3watZe3htMMu8HsLhEG0svK14uFoKBJ
kcOAYf8FBhgz/tOjSmgcTyTm3gHF0AKMR458M0Z+GPxUE+1OwcFqmfxHIgb321De
JlKr3TJ/zCponL03fZ4YBZy6Cdnd7MjW2tM2u+PFccAT6g+Fhoq1zturZvPnn+SZ
BmQEBO74CyUsHqV6ys9WE82FLPvFh+DKD27BX8uN+q66K+FeDBWtAe9bwX6kGOCv
JcCBz2+1o6pEOMZTdqN20KO8Uwz1vye2qWJob0b70tNeaA6cNTiPXX48rDmvHep3
Oh5BLfpQJwWNjqZZHP+6fIkgpbCHnyXD1NHDNswJGw4vUz1iJ7hRlfvLidXT8V1G
zz3+EAn2W/xIgUWSgdV1AR9/maBFsD4mVjxmggyLwEDmYrBMzusxkGudSn6w1Mx3
jgyVrOLLNQx592KiyFoTxgcb1ABg1u/iKLPNPU/kulbqVALyF1CePbUCCfAek00Y
QEN/xCqh
=8G/V
-----END PGP SIGNATURE-----

--=_MailMate_0345FC7D-70E7-40F1-8EBB-0DC6E361E0C6_=--

