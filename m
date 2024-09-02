Return-Path: <linux-kernel+bounces-311605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B6968B10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050E91F21522
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCB14A61B;
	Mon,  2 Sep 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y8PCkQd4"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B31CB514
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291041; cv=fail; b=GUfYHhbfDVcXqFKQKq7VCXixV6tbDudkOG5/ajTZNorlYA5KqKv4+3Y8a0jZcs4B+38gWhE0lsXMZisONge0uWT4VthD30eHQROtV8BWyenDwPOYWCg9ePas10KA7fpMWDvY9VO/RkbVuDXgBeFYjF1lpSL6/OGH/CfojQyGcno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291041; c=relaxed/simple;
	bh=Fj1hUqmt0XavqptQ5w2Pwd96nD3a/0FkArNYYf5dM/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQPvdXl4vitcrV0/YMn42Bib8Iprvm3LZFzCIt4jiHaHcK4KJYpUL4XNsqTxNBdfq0rNyHsAMeHZxVSA/v79JCK9nRPZQptPlaPrkGY4nyKDqsEG8wEpefvDJb/EERVTlvSH+QOZEJVc0woA+QSOpAjPBxumuC3YZ543866aT2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y8PCkQd4; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqYoay1PROu9boaNCW42xL7azZoNzCQjLVMm7k9SOKpNiNyoLNluMVTJXbOcmU4oI9b+6DyBgc2ANEikm6uaZSHH/JxXJAOSJBoP6faM5IFX+DI8aWsa1Tf1Y87nDh/tQYEvMqRKbqSdkB9Mt22zKZ9kLYptq4GRFVuBHI4RGH4ug6ooEcmIe/lC65DyMwmHf0nWbjhXi2mmD4TvzYctQP2qjFUizA/Gx20S2/8bJgZUXUcfltnl11TlOChE8CufVT6YzYFcT6MOw5n5D/pAYU3HTT6N3dRK5D5mJs5Vr3ATqfV1/qlKkUmx3qk47UoQZcg0D5KGuU3hdzMRKM/rIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXyJb8eYmRcvpNwf8kwYPP+wQ9/rEPjZefEUwbst+tM=;
 b=bHM64ct/1aqMwWU2WA3O1i08YQbZK/ufUY4O2vBSJfQZOgTvNlFH01KC/xoiNnroEROJ4zIkGKw+3nDW81WwsIhZxtIc5HqkvBoahyrMBu/bEvZlVkjN3Dd+iroeOq8GIZFbnyMwFt5PmYDhFksknkmjiwhU2cvw5QOqf4kk48sSBvdFb2OQji+WA2k7IDYNDB16j2cN8Dt+PWNsUsY5oGiF1OQU8HWs/PgPOTEC+O91NHlfFiBXOMj3Fj6jKCIgOxvfD6OJGPuCM+ur4nVp+QLPs0U9dJaMaebQRWP4lOwdzgjwOXrfdV6O3tjWL+3sMZEUJIFheQoCQi4kReXDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXyJb8eYmRcvpNwf8kwYPP+wQ9/rEPjZefEUwbst+tM=;
 b=Y8PCkQd4OlhEw+bKjsreSLyOoZEqEJWa7//hXOMltizW18bZCYVSjjYhxYTtexkNusKL4QaahZEop8EdBjCQqrCWR7tJAb0knKbzZ76XoUg5HU1oP+fG5RfNaugl0Ccyi3xg8xQLqyPCk6qjx2o144FyhrYEFel82uCcS3HU2X/BzoFZn+o80dCb+B4UR9bYFHd1/7OWg0mO4ulXrqXPzuwYIkd73yzCnz2PfiPvUenlWKrIsNhprIj4MFLV3hwlBvieCMv+YcYqhjjr05in4Fs6dUTEScmMJykE/XjAh0/7VHKJdLAtNqa4DBPLN4QKFNNxzC4ZMTO/V+m7tFxbeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 15:30:37 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 15:30:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] mm/page_isolation: remove migratetype from
 move_freepages_block_isolate()
Date: Mon, 02 Sep 2024 11:30:34 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <AAD39CDF-6AC3-432F-B5E1-5D8FD8DA7B42@nvidia.com>
In-Reply-To: <8f9f16e9-4d89-44ba-a244-9389233b5325@redhat.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
 <20240828202240.2809740-3-ziy@nvidia.com>
 <8f9f16e9-4d89-44ba-a244-9389233b5325@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7A8A1798-73B2-4C20-9094-3F389D94C2A5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: dd441a7c-9a01-4167-e0bd-08dccb643167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LNiJp6LmYtGkmGfB/GyP7/ZD+szsjKB40qIj2U7UVDr02/LCyWqsmZxACkKx?=
 =?us-ascii?Q?XIjjN5oK03ZgleeWEWxhSS5taMtMDGq2X65PlPrmzJc84P6KiZE+1KVFGKAu?=
 =?us-ascii?Q?O+Z6e+3I6lwA+reGDhOqsk3XPw6/yyTYzNJ7JvIeUocBbSQpwa9OJiipnMi4?=
 =?us-ascii?Q?dEPDrg7F/mDgNrcqGAEru4o+vsfWwO2i40CCOaBlbuMHe4rgrUDWJLGlo7kj?=
 =?us-ascii?Q?YD32VXtvsnAEKSlF5WgjCY2GlHPPE+Cymz2j+RpA8rFDfW4d0xB9rXkaLKXE?=
 =?us-ascii?Q?oQglRAOk2jOy/kjgS97Zvmaq1/F1XHCdmTPDg4sBwQ6IFXrewwU1AMRmai+/?=
 =?us-ascii?Q?YwNDW4oMUtDQPPzgsOrWwQq8LfLMV+vZRfWDrjSnLoENVlwmd8uAW2D7BMrK?=
 =?us-ascii?Q?Z1rlvIV5qgXjB1bqrZ8NNej60ol96/TUR1S+IaRCMPkiCWoWc7LZVgMXXltv?=
 =?us-ascii?Q?MsTRUY2fHcL3WwgenoOgE+qbmieWoDeN4sD3ClNyaUbUo1xuXYLkKqTaaPiU?=
 =?us-ascii?Q?FrpOYCX+IUAxiDFFUUl6bsFzBkQNXEMMDfOpmwXPlM/vMiaB2QUuDvpatQ4j?=
 =?us-ascii?Q?I508QOnSCHRbf3MTfKMrP9/1PBX2K1g/fSfmzNCxgPQH/yVVgA9zw4Y5eBeb?=
 =?us-ascii?Q?UXfkX4LtXR0eFJvVsDrstyH82qokrH6z6A9RWW8wFZIURecY6OLbiuRY07ZY?=
 =?us-ascii?Q?6xezXyz4lpp+MiEO32Iun+U7cuVySplf8pQx2mLr2COW0oFnJv29wpo9cmba?=
 =?us-ascii?Q?Qg+zw65Zxmu3/h5eKqQb0r3qDP2DLff6YREXbKLPYesYd5MDJg4H+CaGCGFT?=
 =?us-ascii?Q?EwMYkRiH69EbgFYN2SXh4Jay6vqNUM7MwTDkp5GKK0jf8r2cTLfVIZNVlSik?=
 =?us-ascii?Q?XP4rspYC49TyzY/UyQ/9BqDoIw9LmjnOsii+FAzICBEcEkTUDTK0kJjyG+vM?=
 =?us-ascii?Q?wcV1rX+BQaALEw2Wy+OceltK6tO8L2xeClFwTl31kfwU6D2HpeIrMn2em080?=
 =?us-ascii?Q?/67B73xMvSr7DCtHIHxvi6OtG7tL9Hi5O2RPZFSfOWGwFTPkuQoqnn6fFSrb?=
 =?us-ascii?Q?qPpnkIpqYOTM+9UgGR5m4x/z4ZzHPNysrDclYov6lm9LPjvBJXjESDe8wVRy?=
 =?us-ascii?Q?L4ieaguR/XtP9BkIh6hBeaU7jmLOme7cTCJQ4yBatWXLnUi5WYEg+vFpssca?=
 =?us-ascii?Q?srTgMFL6efXAKeAvqtU9vJ/AwhX9kkphnd5MtBm7/gdOS6FPVX7h6HjMY6CL?=
 =?us-ascii?Q?dNRVjtC0ostKXp3bDopLxMyUfGb/Pnpvm4WyRSRU1nqWvQRhA3EQl7gTOAgW?=
 =?us-ascii?Q?eRbcrkjD8CvPqqkLVlI0F6H5q0CX5l11SB6jtgd5YOV8Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WEx0LSVDqVfr+5e4LYgh69Haj/qO52WDf8x6MwtGRiDE/ur9JrEf5Ydsh7mX?=
 =?us-ascii?Q?Q0Lxo6MI7MpTPmf3nckhVExxNJASjgrzuSznMD82uHDm/LnyUkViNorClS2R?=
 =?us-ascii?Q?hrNfwMW+VB+ltqMIWVqq++HqV1tQdgJLKp1WpTq9SGknowZThDSl2WRfw5Pk?=
 =?us-ascii?Q?IYNYsqgT5OKG9rf4tJLecRly+playecpgq5ghP3qK938F7kbgJ+VT/WJYZ2e?=
 =?us-ascii?Q?gttC7YOwb0sr0XUNqSo3otV+hqAhnabYOUF/JNe9h0bV2wIwkBfHzahsk6mg?=
 =?us-ascii?Q?DyQMNu0qiK5AI8fHMoEPzQPXtHl4K4w9Cb2ndt+JuudXyrLxFz+tQnJjDklS?=
 =?us-ascii?Q?Caa2qr1f+8nmfCG/9GPCc7rAQDRNKBiR4pIdQFsfa9KuZY9RfYOsfraV/Zq7?=
 =?us-ascii?Q?ygYLH6PcipphhvsRxqXCnKezthCoOf5NOJEzVcOVQHxq0xyKOjcSofIHXf13?=
 =?us-ascii?Q?bv/iLr4xdhr5nzTfTJIQZJeUVTUJDM2Ez52OBjHvZNRzDzZK1aYnIEemew56?=
 =?us-ascii?Q?haZfm8sTPlJBI5qIlOltk+Y+HBEIcbimNz1sLkM5mXT2ipKNlrM47p2nYu8E?=
 =?us-ascii?Q?MhYY3Y7qbu/nz4ydyy/X/CVFibsD07sgd2AH9Xd4JmjBCKqU/XIpN3dMLDqc?=
 =?us-ascii?Q?j4JMKegjMEFnwCurXyZJNTLofWCSg9r+tfkr/Sk4di1pbgifoXk88rswt4hn?=
 =?us-ascii?Q?mGl+aUVDapDIPtyFeA146UZEfpPvGsEqwVX2bP87HroC+m971GslwZO3ZKkF?=
 =?us-ascii?Q?hT0mmBNzDauXVAgZm9PXa+G7iEnu5klMK5YI4u7A0J6dnuZZ2NIRv6pkqR3A?=
 =?us-ascii?Q?R/HJ1OmjYCi1QE6pV1HNH0s6VVYxqCyA/ENkz9MGQCH+u1BpuIVr6gWHzTVb?=
 =?us-ascii?Q?niNI8rd+RQ6lIsuRw/jdpxwyjUH+ef8DzukXSJY01BhyAaub/A+B6kWAZhaY?=
 =?us-ascii?Q?R6XV56R4TgAAfCfhxmDMaaMhhhrRpjstTHeaIE+H50myjxOZwip8UfXyr4qh?=
 =?us-ascii?Q?fxzQUCZKuORTKtkXNWU9Wm2vJps/GCOqTfgiiV3jgjo7LccVBdPHY7Fox7j4?=
 =?us-ascii?Q?fsRdeNWfqlDBbR9f/u8y0VYDhyMuyaloPOzFMEULYtB3pCtU58pjjCwbVjMy?=
 =?us-ascii?Q?9G1P3cXtVmKJosQCzLCrK7qULnAfQuCyi/KMZenlPRm10+KdbKjDuZdyXPEn?=
 =?us-ascii?Q?Msz1Npb3u2wmgR4sndA59SmLBCRCKyn0wNeRqbL6a+7E6HadiagrYZV177nt?=
 =?us-ascii?Q?CPBYbeL9G6ULhT5vadkoQkdpjlAP2b3lV5Hb9Ws3f7aJfBame0y5ZDebuSGd?=
 =?us-ascii?Q?MskPdfNts9WuMOgT6NQ/wXuchdDWbXGqE8jsdBIchftRDN0BfCNDmthTqycb?=
 =?us-ascii?Q?pBslCSTf3Gls2N/yDcNPN0+IVhCUu744iBt8B8n0tB0Ha6r8a8EzU+fIDwNT?=
 =?us-ascii?Q?+JhjX6Ys058XvCytnYNSRYsT9kb3hlR9uiWljIQhjCkhGUyloVK3VreaQ9YI?=
 =?us-ascii?Q?BS19+mzuldnzXs297D4sbSDGdfshlO/9APjYuAcIC2CjeiwCxWSTVBYLgHh8?=
 =?us-ascii?Q?lcgu298S0Gt2dxjgD/L6QcW+RLOYfQupeVXRqsZQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd441a7c-9a01-4167-e0bd-08dccb643167
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 15:30:36.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/K40AlpAX431Q6ksPz6w2UlS0OHC9TsHrfX8AqYTHECJBiSc5527k6D2bhky/UQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

--=_MailMate_7A8A1798-73B2-4C20-9094-3F389D94C2A5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2 Sep 2024, at 10:42, David Hildenbrand wrote:

> On 28.08.24 22:22, Zi Yan wrote:
>> Since migratetype is no longer overwritten during pageblock isolation,=

>> moving pageblocks to and from MIGRATE_ISOLATE do not need migratetype.=

>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/page-isolation.h |  3 +--
>>   mm/page_alloc.c                | 27 +++++++++++++++++++++------
>>   mm/page_isolation.c            | 19 +++++++++----------
>>   3 files changed, 31 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isola=
tion.h
>> index 11b8695115ea..6a62401410c3 100644
>> --- a/include/linux/page-isolation.h
>> +++ b/include/linux/page-isolation.h
>> @@ -35,8 +35,7 @@ static inline bool is_migrate_isolate(int migratetyp=
e)
>>    void set_pageblock_migratetype(struct page *page, int migratetype);=

>>  -bool move_freepages_block_isolate(struct zone *zone, struct page *pa=
ge,
>> -				  int migratetype);
>> +bool move_freepages_block_isolate(struct zone *zone, struct page *pag=
e);
>>    int start_isolate_page_range(unsigned long start_pfn, unsigned long=
 end_pfn,
>>   			     int migratetype, int flags, gfp_t gfp_flags);
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 4ea5cd1a07e2..dc7c36461953 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1764,10 +1764,12 @@ static unsigned long find_large_buddy(unsigned=
 long start_pfn)
>>    *
>>    * Returns %true if pages could be moved, %false otherwise.
>>    */
>> -bool move_freepages_block_isolate(struct zone *zone, struct page *pag=
e,
>> -				  int migratetype)
>> +bool move_freepages_block_isolate(struct zone *zone, struct page *pag=
e)
>>   {
>>   	unsigned long start_pfn, pfn;
>> +	bool is_block_isolated =3D get_pageblock_isolate(page);
>> +	int from_mt;
>
> I think we should have two functions, one that isolates, another one th=
at un-isolates. Or at least make the semantics not depend on the current =
state of the pageblock.
>
> bool pageblock_set_isolated_and_move_free_pages(struct zone *zone, stru=
ct page *page, bool isolated);
>
> vs.
>
> pageblock_isolate_and_move_free_pages()
> pageblock_unisolate_and_move_free_pages()

Sure. Will do.

--
Best Regards,
Yan, Zi

--=_MailMate_7A8A1798-73B2-4C20-9094-3F389D94C2A5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmbV2hoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU3FgP/3dxbIRNPFuguoc9+/wB21o+hp3bI7e/hEOC
TCn5hVFmoZ40uLcDtyE1f35jraNo52CVlCIv75g+4LZvzX4ZSTVX8IwZhmBy6LdO
TQdpJbMDTURg+2Sly8a8VabnBxoHLhGFRxDfvELTtVxrtqTR/mfeG6ObXcMpT5Ry
IzL811ZdYVu4FZqSZdB1mbY36P88FueBTl64SID00dPGfEyLnY/sxGfQ4MoqOl96
LPZ/5n0S/pXJwhwdjjcR19fV0WlkhdYzXN5/i1DhMXtMVCs1APmfAwxd25FUROwF
0tAxU1lvuPVvbNJeWfEVRE0T6nMPqePFi8f5y8ox2w1yIy4ESSe8Q65AbP/JzuUQ
lclKhwDKd/bkO//QZY6ZsU4r3gxwMOI/ziKJ6ENNAWuRMAkC4EuK/rql/HhQc/8Q
ZcprTKHCoRkUovJOtG6n4VYxW4eNc3XpO7CsPmW3mwnZ9QfDQ76lWzFobdjZ7mlV
cwpkKIHPfG4Qa1dg3uvIoeMLbdMPCPuixJuOtEbe7oO9nBjCemVVMjOKD8ZMKJoJ
UaL2fqJ1G3uHX9IDMdXbaCXvY7GoRJ5VCVoFem1O94v2MY3F9J3bQAucJkq/3jo+
iazOug5f3arxDrEz7YWUX8rCd1hipWgacD/v4+iLEYYSvDZElF8ZqieQn/QxpNaT
NP6s4HBp
=zNyj
-----END PGP SIGNATURE-----

--=_MailMate_7A8A1798-73B2-4C20-9094-3F389D94C2A5_=--

