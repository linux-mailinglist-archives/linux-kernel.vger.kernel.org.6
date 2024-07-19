Return-Path: <linux-kernel+bounces-257670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E1A937D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2F51C213A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996DF1482FC;
	Fri, 19 Jul 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwgcI3PG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBE4696
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721420351; cv=fail; b=NxAXAFnnn/1p10MURODw5/6IL2AkqGMNY5Kk50T0gUvQte8Tsg/B1vFncTPhb9XjlL4Wm6Lt4hU369bu1rPktGRdL0grRUCLlAeHX2JuUwf9DmD0Ja/E+wMYz0hwW1cYEk9JcLltZor3fxMrxr0WnJCRnny/Lg/Gl4EZwi2Umh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721420351; c=relaxed/simple;
	bh=E6Y4EUd5hXB1s0kdyNBG1hsriOVc2ifn5WwRu5+GHz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaogGdGOGIOwlcbSTwMI0jRJr+iC7npPVb4N9AD32ckkxbtDasrvGIS+QL25QqgrS7kbf+3FoiwMNXvfeKBH9RKPoscW21LdUEO65rhOtyuqDhOzXWzDn2W/bVTx4+CFg3ae2Rlp3wReZkLj3LManCgNeWLKm7P7WuKT6jAEMAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwgcI3PG; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a++R2t6a2cylB9ILCt57NIag6ISdWiU0iW6BNGv7hfzOzmj10mPc3PAwYTEpJtSWwVDSXYcmc5lULgsJ3EQMLx+SHYa2poV1cmE3dnkcwqNgc8sHCtahqmlCZcL+wuans4drz/cwMQ08kux9AaRDNujKGBhu3C7i72HH4DA3kMbHAL0QNmw8YWO8pWtZ67wGAFJQjSQnoTUy/gLq25QKlzyCHnSVm6J8jINqjeeZN2wNdQmHmOUmWljBEwlMdw6X/sJSo3+EvL8HHo58pddFekN1wUYE86IcqMPs6D/VTcgpxHSS6SYX1Udgz1aWMTMfyU3NuZTbcSm4Ylon4pqeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiiQINkT0aVnu4rvbj5qxaENOSjP+sW/vBoCPfKJW2o=;
 b=ytxtM/LwKC/BJI3ndtMV+Pe4JptwUlhhCSrgBMmCRXoEtDsVTScRgruez1sd/PaCze43+1PtKCoFcQ2JyLjtcpDlyqCBhxIH/HC37rMVS9cZhiEeYIIMxOD4S/FHuN4PP4NjayZBCjldw2N7Xi1dI71LwHfUkx66EqI5Df0ZFOC6pkWjMJ/dyTsB11DxGD0IZTkTBr93g6gVMn0TiATYhXxc5YEZfmiVXY1ebhYG73QWnpqEApChKwpAwztBO4muLH8dwrM1PzWhXvxspzIFw9g3CcRuAGEZymhqTJb27tdF2rTIofmPg1jpw3MwvaTu9Ld4LciaTiy6WlSRbz+hSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiiQINkT0aVnu4rvbj5qxaENOSjP+sW/vBoCPfKJW2o=;
 b=hwgcI3PGPFlA/a4WquWlutwhVg60fbLXOaX59iEqPvh1t7goalblQoGUy4hzlFjcas77pwMbpAfx1gK2TifABswpsVJrat4SpT8KbtC5MT/gbunp3QIJ2DegZ6H7U29xzOL7qsb+HE0IirXCCIS8naHxW7u+fX+E4nbH6Ko1RhsqmzKWr/tVwVdeyVu2wX7VzU36H5rH8/zVnJAFmcy5TpPKfhx0VRnShVe0/ti5RG+cr2YO7BVrgw7VJMbelnYRLUVaxO9Ijdwx6zS9xWnMWzf6MWEdEdnN9/3si4J1dCyxjdkugwz7LIBMmqg1DFEVLJigYxLR0d7voGwSGXko4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Fri, 19 Jul 2024 20:19:07 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 20:19:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
Date: Fri, 19 Jul 2024 16:19:04 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <735B3DEE-5C4A-43BD-B003-17F4B1F0DC98@nvidia.com>
In-Reply-To: <87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-4-zi.yan@sent.com>
 <87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1D2EDF33-5E8B-493C-AD1C-63A53F326647_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8b3040-8176-4b5d-0f0b-08dca8300aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ivzpx5WqNvKMCJ3bBVU0fTPoy3OkursyBQvyDdlr+wxbaELU3MBVDPNGdF+G?=
 =?us-ascii?Q?UriHc33ZIvnZLtAJACvIz3eV+5xAT3Rhv0ViUOTyG30YJzaB9PG+LJfK8xe6?=
 =?us-ascii?Q?BltUhfg+jqtRoSuXzTmocS2sqsuH9OtqCuR7wgP9NFU5uRjFVZT9uYQFGe3E?=
 =?us-ascii?Q?uiHzLUj4TsVwmE605JTutPwMDeVyMO+CQrXIXmeT+Pn0/apS09SIlR1RZkFJ?=
 =?us-ascii?Q?v46mVp/bDO4zMCseAvpoNUJ/Z+BlXeGs+GOPNvB/khh/50763Ce6TAK3wzP5?=
 =?us-ascii?Q?yh8+LKeTdj1hpG+62qms3gxCr5HU5QL7T4PdNnGTpOCGyaY3gf/lE2K3NIQE?=
 =?us-ascii?Q?mU1z+rJZ4IAIbEOOSlyQeo6Sb1LRdxm1xoPJuwKu2qvKonGC7UvZvfQEq4Xz?=
 =?us-ascii?Q?cZe3ErmuWniTWfTjw+9xjaE0hKlEotR0seRdWOoGZAUbshTlg2JlfbvCdRzm?=
 =?us-ascii?Q?nc586hjiboSGYBpLtyDx+PUuRx8I5emb096WiTULdx6N2lA372D3v2jNIogT?=
 =?us-ascii?Q?TFkLk+szcKT3RyQAe2Uv5XwKIqWhwgDL6W5uatji++LysqbG6pUSqD7FsJx0?=
 =?us-ascii?Q?5RmE75T1nVUBAp8fuOG/asF/BMxwyuip0vYouwxwstFzGuwkiyBA9GZYw6VV?=
 =?us-ascii?Q?LDMgLRNtXNf4hu8wqfkIaXBCnzln/ihopewgGqt1WLTSjuv/FIGMQD9G4Igc?=
 =?us-ascii?Q?q+T5N2xs6+Ha3leBIUvKWPQcvlYLXJikhdBsWZ8t3sZaIwtb/8tsvoK6NhdS?=
 =?us-ascii?Q?ASsGffNrdCjKdArJeUavcQLWlhAYkH5huZ4FiqAjQvIimnKVxz5cp/9+rhFA?=
 =?us-ascii?Q?ZIhBNBdB+Yp8ckOGrPhtG/x6C4iLg2ydWcVprBXv4tUIV94lI2BXuVaf8/6E?=
 =?us-ascii?Q?DTu8QsZdh9QEuzpGW/SmXVRu7BX2ji49/3uJhq/j3qXJJ5idzPuOvB7FsUqC?=
 =?us-ascii?Q?k2lP9CCPcj+MMNKVycZOvCPKsT3oQxHyH0i3+S90Cq54Glt/LHFxhcDBzu71?=
 =?us-ascii?Q?V1VS967bYymwYSCmEYuzORWUlxqm+i90kzZUJd2hJwFg7y9cHeje9P8LEClE?=
 =?us-ascii?Q?auB3SAJlb0eFi1FxOLPxB5p1H+sG3jCtv33omKbo+k8/x/XL99Ti5jOW/yRC?=
 =?us-ascii?Q?D/nMHZy66YdonlzoPOMvN+ySFNoOjpYqeOXdHGSKvvS3Kw5ysOJJPWfabVPR?=
 =?us-ascii?Q?l5x4UzePUQmZjG3yMi1/0B6dqFsm+G29s3jjAAdXkF36kIHYHCATi/IvFf9z?=
 =?us-ascii?Q?bOOiFUPUGNVwN3O5r2hZoi0NvE1LDLXtIpD9uTcwwy+yJoY4SYZPpoPjrzqV?=
 =?us-ascii?Q?IEHHiSvBxE/FChPz4IKlnhPe8lqQ0x9iBukyCTt6Injnuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9zT2Ft1BNteqwUUayb95Q0fzO/hwdGJ9yZXKrXZro/h+rgm+Y96OVe13ArC2?=
 =?us-ascii?Q?WQGnUlXyUZTRmdj80jaQWvZ1TR3DwirbUDSfNRq6xDYTRRlryBKtpwyTj3u7?=
 =?us-ascii?Q?6WmjFwzPbDE9aswgrlMmnu7zNY47L/CeV9YWWx3Q+VfdfuPpbcmWc28Cx6uQ?=
 =?us-ascii?Q?82MmUrkJALBxKKUZT2P7agrzqk2JYfrpNtIQqQusVDtGQeDHE4p5Nk6Nj1eT?=
 =?us-ascii?Q?/POCyyn303V0oEXv4KUhOqknaZmY86WoECf6bqxA/ZNkbrzlzEAj5ahuUXDH?=
 =?us-ascii?Q?C9EUFJ3rBjLCUsSJEsedqLH0gFg8RFyxvuaQ2845W7eUSxURSIwxhbm87C13?=
 =?us-ascii?Q?7MQtuZ/uRZhJnanoWZFo9fzYX1EAQ97A7u3+jKJmw28rvcrqYRuX71FOckw8?=
 =?us-ascii?Q?Y5OgcsT2ppwGZdCayNrWwRC2wn6rRTsZ6S7xSuL3mMoI/AO2Sjv75/BrAoZF?=
 =?us-ascii?Q?2uEpX9ChIALJQ+aSJ0SSGIyr98mzmZyPx2p2l7jHX3gzF48QVLX+aC+rwGgl?=
 =?us-ascii?Q?YNhZRV2JEubH7yBKwkSxXjJdsZ+jlUuuG2k0mcPNHgsvJzFqKoBdthDQu86K?=
 =?us-ascii?Q?q8AfodrMMja0bwmK/unfDt5w39i5bAIBKF9EQIhMEv54DRppNl58ZyF5EQcJ?=
 =?us-ascii?Q?q4iBaQ2xiiTy4aIzpGxJAN6DmTjXLEHIGR44HRA4qJ2qv4LGLB/2CQR9gzQn?=
 =?us-ascii?Q?v4qsndSgAzK2EMDbsTAirFp+euEQY2zZdK/4KgZv1+gMIjqmfwLPWq/t+I+Z?=
 =?us-ascii?Q?tolr8l2jRpJ+xDOzvNILCUVyRISyUF2yKh2qBYhtKwNU01S4NHZnlvH75I4x?=
 =?us-ascii?Q?TdQGhUru0iVNuOaZ/BfYCLAdqeCqWzYvUkRm0RDvtWqyF13OuY7UaFzlH6VD?=
 =?us-ascii?Q?umxyk5KoKYFxcM2dpZJ+jQqrb6OcAQTOnEHH2NWl7wN7/xkMAYZkBu4uAFUf?=
 =?us-ascii?Q?yEB3p5gK2UXhL+RBZITdtBV5zjPykA41vWYS+M5yQjjrTlEsNLVUcT0YgrtP?=
 =?us-ascii?Q?elToi/6jVAfeVx0Etw9cBPV9JihSlLnQkJ9N5xE0MTarcxb+YblSK/uGnPnH?=
 =?us-ascii?Q?Yz39lB+AlVIi0fRUegfXqxlLb+yeZmhzSRKmD5fRydbEKy+0l/Uy2b4sZbua?=
 =?us-ascii?Q?jFvFEj5rZ3rPneMusOQp4GV22SVVUrKA9mHAwgl1kF+mpq280ecp+FC8HDQp?=
 =?us-ascii?Q?Rc8ER229utexQtP+ODRunYU/7Gi0RBPkm+yLBuYSYnVCljY+4zo67sROu7i0?=
 =?us-ascii?Q?XQ3dG8b+lSVFdJIphde0kUYlyK7hwW2f7ZPyVOFl1SFQRgneDPsMtS0fAR3u?=
 =?us-ascii?Q?xIN4PW2ZA1SAJOcqpX7wp84HSXZ1gmWIx0rhv/wUMnSNoE2hQYZHdO/rgwJy?=
 =?us-ascii?Q?YBO9kJtvn02l1Un4v4LmQhTl+mZbibQB86N9EJvt8wKve51L4ZN86xrTkVr8?=
 =?us-ascii?Q?+N0PGOAylr4ARNpgDniSx127nwyxNreGvwrnD0Utk0SJJtuEuQplxzqAZWAZ?=
 =?us-ascii?Q?h7O8G/tj/+b304q89iVu6WtnDYH8eDNlS79wlGqrsKQzOXozVJRkOU4NHt7Q?=
 =?us-ascii?Q?VfXXY5aluQFzpz1uhE4lcrs7r6RWpmX2gcNZGAnt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8b3040-8176-4b5d-0f0b-08dca8300aad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 20:19:07.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqaEAPmT/VKZ1TeKf7LCnKdcGQYekNVvkAYAEcJjD0w90NwRYtR6i8YNwDcZbyMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018

--=_MailMate_1D2EDF33-5E8B-493C-AD1C-63A53F326647_=
Content-Type: text/plain

On 18 Jul 2024, at 4:36, Huang, Ying wrote:

> Zi Yan <zi.yan@sent.com> writes:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
>> reduce redundancy, move common code to numa_migrate_prep() and rename
>> the function to numa_migrate_check() to reflect its functionality.
>>
>> There is some code difference between do_numa_page() and
>> do_huge_pmd_numa_page() before the code move:
>>
>> 1. do_huge_pmd_numa_page() did not check shared folios to set TNF_SHARED.
>> 2. do_huge_pmd_numa_page() did not check and skip zone device folios.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c | 28 ++++++-----------
>>  mm/internal.h    |  5 +--
>>  mm/memory.c      | 81 +++++++++++++++++++++++-------------------------
>>  3 files changed, 52 insertions(+), 62 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 8c11d6da4b36..66d67d13e0dc 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>  	pmd_t pmd;
>>  	struct folio *folio;
>>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> -	int nid = NUMA_NO_NODE;
>> -	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
>> +	int target_nid = NUMA_NO_NODE;
>> +	int last_cpupid = (-1 & LAST_CPUPID_MASK);
>>  	bool writable = false;
>> -	int flags = 0;
>> +	int flags = 0, nr_pages;
>>
>>  	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>> @@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>  		writable = true;
>>
>>  	folio = vm_normal_folio_pmd(vma, haddr, pmd);
>> -	if (!folio)
>> +	if (!folio || folio_is_zone_device(folio))
>
> This change appears unrelated.  Can we put it in a separate patch?
>
> IIUC, this isn't necessary even in do_numa_page()?  Because in
> change_pte_range(), folio_is_zone_device() has been checked already.
> But It doesn't hurt too.
>
>>  		goto out_map;
>>
>> -	/* See similar comment in do_numa_page for explanation */
>> -	if (!writable)
>> -		flags |= TNF_NO_GROUP;
>> +	nr_pages = folio_nr_pages(folio);
>>
>> -	nid = folio_nid(folio);
>> -	/*
>> -	 * For memory tiering mode, cpupid of slow memory page is used
>> -	 * to record page access time.  So use default value.
>> -	 */
>> -	if (folio_has_cpupid(folio))
>> -		last_cpupid = folio_last_cpupid(folio);
>> -	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>> +	target_nid = numa_migrate_check(folio, vmf, haddr, writable,
>> +			&flags, &last_cpupid);
>>  	if (target_nid == NUMA_NO_NODE)
>>  		goto out_map;
>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> @@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>
>>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>  		flags |= TNF_MIGRATED;
>> -		nid = target_nid;
>>  	} else {
>> +		target_nid = NUMA_NO_NODE;
>>  		flags |= TNF_MIGRATE_FAIL;
>>  		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>  		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>> @@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>  	}
>>
>>  out:
>> -	if (nid != NUMA_NO_NODE)
>> -		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
>> +	if (target_nid != NUMA_NO_NODE)
>> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
>
> This appears a behavior change.  IIUC, there are 2 possible issues.
>
> 1) if migrate_misplaced_folio() fails, folio_nid() should be used as
> nid.  "target_nid" as variable name here is confusing, because
> folio_nid() is needed in fact.
>
> 2) if !pmd_same(), task_numa_fault() should be skipped.  The original
> code is buggy.
>
> Similar issues for do_numa_page().
>
> If my understanding were correct, we should implement a separate patch
> to fix 2) above.  And that may need to be backported.

Hmm, the original code seems OK after I checked the implementation.
There are two possible !pte_same()/!pmd_same() locations:
1) at the beginning of do_numa_page() and do_huge_pmd_numa_page() and the faulted
PTE/PMD changed before the folio can be checked, task_numa_fault() should not be
called.

2) when migrate_misplaced_folio() failed and the PTE/PMD changed, but the folio
has been determined and checked. task_numa_fault() should be called even if
!pte_same()/!pmd_same(),

Let me know if I get this wrong. Thanks.


Best Regards,
Yan, Zi

--=_MailMate_1D2EDF33-5E8B-493C-AD1C-63A53F326647_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaayjkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKMb8QAIDdvipth6umDE/fVdBXbD7pnzm/W/ySAJlH
vhhfg5kiFOGJhcKX2HAH7AwcuUarO4zEp73NIWlQ7CiC3jJdrkeJ7mZ5dCJWXue3
owzqx3suCqz6f7YO6Z3LnKrcauoWxz9EXpem1FDi/waTdsX5uVf/w7shDJxRP1XH
T2o5nogsad2FdY4Go9o82cou99YlT78shmQhSStxwSVX+nUB2D7C5teCFYr1falh
J0fK3PrBCutySvT2Sm79tr7AYiae7FXYm/4YOqF2ERbZFJ/JiC+wX7EMs74CRF1S
pLUE/HFsiPOVw5gEt7QAM3v/THUP8K2Zwy/X6EGBpHNEncUu4zNgrPG6031tAqAA
xybkFHFCn+ET1+5Q/6kc6hwdV8OK9m8Ck0nKL6z6q2s4wfeTTzd7b1l2ykMRq4PX
jPPMdZyo56bjg+bCjg9aU9acE+Aysxx0QZIZZIEeaDiPk4y4KWq56m3KXvEw/e4k
PfERSoXQFQcrxobqYBbZAapkVn0w7THmoJziGNw/FjI1MXtsVR1bKCwdnLEWhyS4
Qju5oDrqDwe7BGH5JuLDEILeGwDaA/bRi4/Ge0MKLxd4nqUephUn8NMvKvu0/OwL
4mflnKrWenTOa45pMGJvNegsZTLl95B1okC8jIsRpMX0sgXanijEp2y+uMJjO+Gt
kB27XgYK
=xjU3
-----END PGP SIGNATURE-----

--=_MailMate_1D2EDF33-5E8B-493C-AD1C-63A53F326647_=--

