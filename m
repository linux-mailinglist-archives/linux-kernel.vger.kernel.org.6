Return-Path: <linux-kernel+bounces-399313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456099BFD55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDF02835AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF8185B5F;
	Thu,  7 Nov 2024 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9KkeQ90"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60ECDF59
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953224; cv=fail; b=bi57dr3yWUUD+zkrmsNZzy/Jz4ASTA1fejgGnS8ayBMJxSA6CquhI9XlmOfNT0jYOFWpJpT5vHv9PwDjKgxjjMC3cp13WQjlQX0FCPV8PcxhClnv9OTYQaTjWA1I59pC9x5bn5K0qX7238o4pmb2dbF9Vi/nBXWGt3ZPXoq7WDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953224; c=relaxed/simple;
	bh=XbdkEciTAuEGpWPuzfwmorjBYR9N0U1nu5oXRgrB1RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rvqM7uKHNkw9/7B2XQjZ1dn+ZfP0hHa9RQ+kzVa+c7ksAXfthRZkHYm4jzhaO8ahb+TKkdls5O2f0ExAsGdVsyQ3e/6znJ/NhGpFRnCaGe7ZITUYLztdY6fatyz4eJgg7xvp9ggsMqWnWpwuC90SzF6bD9i1r4HprLvXBx9WSo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9KkeQ90; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9rpqOZ8Htlk/gLOYw9Xv/1U9sXYAqpoMM3UMmkn9DpsBp9RRV3BZpd+Rf6pECvyEzfr8ZqNVsZ61AK+Bu3Em4rkqXIh8if7dGz2/LuGHaRVTVScYn4qzuIzxXoIqCZFifzI8BIVDMNHJoYiBYpPh1Xo7cuR+FsdTjo6HiMMWDhqC/rwymID9MKebHzDEvfa/euTdLzHAFCNWUm7EdwUrPcjYyhWEDRMk1a97LCz8L23IHxVlnVbP4mEYfCILTQ0G2h97rLP0cRXXLDQqtel8ylfOIRFtrZl0Th1UXG1LfO9w/9kRrk4V2S7lPG0FyRSxHyarGr+odTJ5shy/t1ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYHlVg/9BZGSy+US5GNFt+Ox82N7m8Ot/aRdoatYCEI=;
 b=pO6s5iV1B5SclVoNz3Neh5k2JanwIwkYGqfQ4XP4Z1zCUeD861Q8/d8SpG1evNercs+BycDGm/AQkaCPHHSaNzih7p4sB3nqSIeVjg/8Zkfmo8jjYGYRu423rHhKv6VBOHeCl01LhR312PlicqrHlbkYGbGfdNS09GCRlXaqeOdQlvElsMp4CDonwj8C3Bu7wxV6w6s5RWagKj+CpUvEYT25OCdw+zZ4ftvjY/So4IyIj/dEgwuwVHc/ybIqIxOD61iR945SwAoUD7gIaHMi7AFSUgcoE0SDhfB6NZHAFuWIDqWFb3qQOW8UvpcvPdWbl88f+SzVHDZibgWhsrf1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYHlVg/9BZGSy+US5GNFt+Ox82N7m8Ot/aRdoatYCEI=;
 b=n9KkeQ901bP0i+DTDk6gmVTfVvMxmzTmr45b0XateZC/3qUcfW0GO+pWhFX0nfdXde6ajJo2v2pQ+CxaAYrm/NkfmemxPX0Hst1vqwJfVsqlP4wBHkRykPegfB1wremzz9cW8jSb1XZkcYn2PUXGxnNT4LN3gJKGRlUaQ+qI4sCc3gU/VYUxLAq6zUsZEGguDfLlCF3bE713D/O28BtrTVKUMgD0T/tFVf+mhpRKVD45e8FSk7/aP4alR5RJFrMyFMiKIs7T+rt2i8FLvt85hhsJoKe31oG51l+PKQbeW27CehfAImIuGiq/xicUv8xV84iWtAwSI0HLZdhkqNjYrg==
Received: from MN2PR16CA0059.namprd16.prod.outlook.com (2603:10b6:208:234::28)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 04:20:19 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::f9) by MN2PR16CA0059.outlook.office365.com
 (2603:10b6:208:234::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 04:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 04:20:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 20:20:07 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 20:20:06 -0800
Message-ID: <c1587c7f-9155-45be-bd62-1e36c0dd6923@nvidia.com>
Date: Wed, 6 Nov 2024 20:20:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] [PATCH] mm/gup: avoid an unnecessary allocation
 call for FOLL_LONGTERM cases
To: Oscar Salvador <osalvador@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, David Hildenbrand
	<david@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Dave Airlie
	<airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Xu <peterx@redhat.com>, Arnd Bergmann
	<arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dongwon Kim
	<dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>, Junxiao Chang
	<junxiao.chang@intel.com>, Mike Kravetz <mike.kravetz@oracle.com>,
	<linux-stable@vger.kernel.org>
References: <20241105032944.141488-1-jhubbard@nvidia.com>
 <20241105032944.141488-2-jhubbard@nvidia.com>
 <Zys1luxxLWwy0yXh@localhost.localdomain>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Zys1luxxLWwy0yXh@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DS0PR12MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a95eff-157b-4710-4f53-08dcfee37d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emxSb0tnVjF2cjNtdHB3YXBRZGtkUm9XTXZCeitvYzVJVitkUnAxUFp0eitI?=
 =?utf-8?B?U21yN1Zjci9KTVBXUXMrdS92R1h2LzJ2QWN2RXMvdHpkYXFxUWJWM3ZpNHZk?=
 =?utf-8?B?T01wOEVtTmx3SG12MTg5OWZLZVVNSzZENDBQNElESm5qNjR6YzZ1NFlpd0hT?=
 =?utf-8?B?NWlrVkxSYmk2SFNGbFBNTjRlK0J2MlBXTHR0ejN2ZEpNSUNIY2RxWThCaGlk?=
 =?utf-8?B?QitvMndLRHpYTy9wWXM3c3p2V3VTa211WWloQ3Y4YWlibFBGRkJXQW9IYkJw?=
 =?utf-8?B?S2tTUjJCWHRWOHhSUEZEY3NKRlB1THhyMkIyOHdmblhiTUhpcnM4aXFhN0Rw?=
 =?utf-8?B?MXBUeDZtMHZaNXRSYnV1bnNIUVgrUTd5bHZUaXBtYXNON2poY2JEMlJXSkRS?=
 =?utf-8?B?aERzSEF2WnkzaS93QW5OYWFJcitLbEhpeXlYV1VhSmd6Q2ZpbzFvdW1ORGxB?=
 =?utf-8?B?M2JSNWNrL0lGYWFPdkR6UHNCcVM0V29CQ21zMFE3OG9UMHJBTElFaitWbkV3?=
 =?utf-8?B?VENCNjY5Kzh5b2hGa2lNNXFkOXhlbEN2bHR5TnVQb2laYTNPTEsyQVorV0JG?=
 =?utf-8?B?YXZUQUg5V1B4QnVkU3JTZnlWem0waGRXUndpbDE2cnNtN2Q2RGxIRTk1Nm5p?=
 =?utf-8?B?R2U1b2dCV2grMVNLOEUxRUZQS2VMVWx4WUhZVnZmNWZsOFhPNUREMDU2SUNp?=
 =?utf-8?B?Y3lucXp4VU96STBmNWp3QUttWjlOQ2FaM21HVE1ZM3owNHI3VjJxeWFRbUoy?=
 =?utf-8?B?K1ZNQjViWENuOGNweDdGdzhrU1poQmR3bWNEbkgzc2ZVM0wwVGlkOCtFeEM0?=
 =?utf-8?B?WjFyUTFKbkh5NFliWlVrc1FnbTYzM1E3dEJEWjA3elVJN0hoUVVyczZNN3lp?=
 =?utf-8?B?SXJnNkJ0MVhVbDhLV1lGQWQxdVRPaG9NN295Y204NUIzdlVISStERzkzUW1h?=
 =?utf-8?B?R2c1bWlSSTR6N0NGQ3pMd0NLRTdqSEM1d3Jndmk0U29Ya3hyRWhHb2JoTVpv?=
 =?utf-8?B?SDhLTHZsUTJrb3MzTXZQNU9NblJ5R1hpbmJQZmNpcWFvTXZlaVdxZ3E4Zkwz?=
 =?utf-8?B?cWV5OVdIWnZDUGwxaVkxWkQ3SDlHSEFxYXAvTFRLU1UrUjNTbm1tTGh6WHI3?=
 =?utf-8?B?NXZPTVdham1Wa2Y3UHloNmpKNDdVYzY2MHBHcThEU0ZEcjRlTmQ4Mk1maitW?=
 =?utf-8?B?elRHbVM3ZTJKNGVySkpSYWpaME5BcjJ4TTcrSWI4YTA1S2dibVJPbXJhZGg1?=
 =?utf-8?B?VEdlb0tLbWRLWXZldnF3L1pDZ1NqYWwwZDhpcXZNazZxUEdpK3ppcEtSU21o?=
 =?utf-8?B?L1VnYmM5N1M3dDJFK0RxSGx3T3YyaGVYaGpaL2tDR0FJMkpWOTNjQ2FCTmh2?=
 =?utf-8?B?ODlUMWlVU0NtZDZLSWhmSUZYZHlWMDVIejRMMkhNKzhwMEpnTGcvTkd2WHBD?=
 =?utf-8?B?QktjZTBmdG4yYWk2L3M4UTJTK3hjb1VveUxnZlg5eE41Ukdsb05keUVzR0py?=
 =?utf-8?B?eldlODl5T25rTWNxNDBkWStoZk1talhEaExZYXVWN0dVOENwR1RQM1hDTVBD?=
 =?utf-8?B?aTB3d2ZDeGNEOWlKSThvNFRDak9GZEw2eTFpSVhYcmVWcEpXeEZRclpPSnBp?=
 =?utf-8?B?QUN4blJPNU9rNjBwbmwwdVNyNnVGbVZvSTh0aFVDOHlTOWZhQlQ4THFDazFj?=
 =?utf-8?B?M1krSC9peFhaM0xDUVVlUkZOVjAyUXFKSURjWkN5eGpkZEptT3JWZXEvUndU?=
 =?utf-8?B?bmRCWVZQYlpyaWJrNnkvRDZiOEc3dEVTT2M4cHBZR1VrdkcyTmlmVlhuQUg4?=
 =?utf-8?B?azFTYTRwZWFBekk4OTlQK29HN2dDR2EzTDBHUVVUb0QzazdFK3BqYzZ6MVgv?=
 =?utf-8?B?RU1qcW92d1F1QlgwcGdwV3JSRVcrcFZNaHVFQTlMVGJkWGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 04:20:18.9872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a95eff-157b-4710-4f53-08dcfee37d3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653

On 11/6/24 1:23 AM, Oscar Salvador wrote:
> On Mon, Nov 04, 2024 at 07:29:44PM -0800, John Hubbard wrote:
...
> Hi John, thanks for doing this.
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks for the review!

> 
> Nit below:
> 
...
>> @@ -2363,8 +2399,8 @@ static int migrate_longterm_unpinnable_folios(
>>   		 * calling folio_isolate_lru() which takes a reference so the
>>   		 * folio won't be freed if it's migrating.
>>   		 */
>> -		unpin_folio(folios[i]);
>> -		folios[i] = NULL;
>> +		unpin_folio(pofs_get_folio(pofs, i));
> 
> We already retrieved the folio before, cannot we just bypass
> pofs_get_folio() here?
> 

Yes, you are right. Andrew, can we please add this fixup on top of the commits
in today's mm-hotfixes-unstable (or, let me know if you'd prefer a v3 instead):


diff --git a/mm/gup.c b/mm/gup.c
index 0a22f7def83c..ad0c8922dac3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2399,7 +2399,7 @@ migrate_longterm_unpinnable_folios(struct list_head *movable_folio_list,
  		 * calling folio_isolate_lru() which takes a reference so the
  		 * folio won't be freed if it's migrating.
  		 */
-		unpin_folio(pofs_get_folio(pofs, i));
+		unpin_folio(folio);
  		pofs_clear_entry(pofs, i);
  	}
  


thanks,
-- 
John Hubbard


