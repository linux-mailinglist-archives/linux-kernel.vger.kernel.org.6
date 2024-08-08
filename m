Return-Path: <linux-kernel+bounces-280213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B0B94C73B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD79B28718B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA82B15F3EF;
	Thu,  8 Aug 2024 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ME1rIXie"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304915F3E2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158809; cv=fail; b=I+lSu+EZrRz3nRxYw1MEIUIHp/pwCNut7zrbYG4ONWOSZskrloCyEvttyIewmErEqBy3SIwwgpmy5lge/lp4nUCnGFW9uvCcXLydGD+HLky0zVMiW4LFm5n6wWx6/6iwDRf/nOc6MwLs06gTUFJyWzLXUn26LWXUw/8a77RPmF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158809; c=relaxed/simple;
	bh=K+zSAXjQJGGJNIO/jD/59r1AQNghbgwxhUdeIXtZzIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7j4sAMYjVd8r7r4jilplZwP8o2EXDJw9sdg1x5EXDu1Ri6EfpC9UsE/pijAylW/Kx9bmcR5uTxJd+vxaWDNpFdQfQskT35WctvpbO3qHya03wwRb3kX+Tdzy0q/9eC30DAitFq3q6o6Bm8xlvGNC36URoBzcMrRTPq1b2HofDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ME1rIXie; arc=fail smtp.client-ip=40.107.102.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jn5SVs3ZoSBDQIVg5fxY0z7BUugmdCZ0mLDAXL+CvwL5gxABlMz/hbmjUEBGu/32x6mkpbkOHweqbSWirFL5P7lfK+lGz9oc6VFpNTpi2S387W3H0FSahkF+hfecicDAi5GDWeCbEFK7xDJx5N/FJf4WQV8hUynhtF5NRTSR6NmiJdULMCtIEM/05vZvDEvAgdqwfzKyjIyCcGrHpiJg38GPo8E2kmI5mHSRCoUekcspVq+QXsaIyU9X5JP8YqtGl3k22vHoFCUkMFPL3gzKD9/mUuR6XMEL5R7z3VqDl59SxpN2AbqpEiFM5yKd3UFN3U/bpByOLel4l3LwzGrmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JyYlgH3YjnnxYVeqZMsNiFu9t+BKr2AbxXIeGvWzgo=;
 b=yOjOYTaU26sPpxYvoM1MOqsipRzmye02lHGK9dbVfVVp3cESjiA+OSmVQeceaAbfYtiC1N3uFa6U532+ANgXlhxhxPePTquW1mCdNZN4CV8fq5sQuqIEDNC8mWPIyPUud7+skYxrYwPkkvITZ/mKMh0e4McJDVRdIQ/70rSTNCJNbIEquHsYB+lDNspA9UY6tINHcaMk+3PWF2Jx4g8txdNu5s+fdw6GLNPO8NN4VFDUqGxoIn82hmktB2e37CH6DiByO7oRDHkOzs54JK67Mf74K1QOowEy+A2DjajR1oK2d/WPnxOM18jNt47mLWknT5Y5x4cobyajkbHPqnh66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JyYlgH3YjnnxYVeqZMsNiFu9t+BKr2AbxXIeGvWzgo=;
 b=ME1rIXiepM70orL8+d+gKH4CmfXJDSzMNx4y90A3k3iHy+rRZ7mkBanjsljtLSuR6Rc3yEY3WvJD6rBv/2yIoPQ9SFJ2TddAyM/3nKyj9S5uzACTeKn4zK733bN9ujF/kJ2NZYpzH5nUMHlcG/fLiMQFEvSknJzR57QVuJoY57FtUwmil1u7hHZTZGIUJiC0NXA+7A9TbxnRCXsVuBZntqm/kfZVeQ9zNgqEegMbjBG/4KCFRBYmDolkP6aY2yvqDxJOq7XjiZPBw8VbmxTqLT2pUF6QJqA/IBexJp5DyWSRsh2P/yzzJdZI8iScUqHxgDBvDGtFQeJUviEjEMqROw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 23:13:22 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 23:13:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/migrate: move common code to numa_migrate_check
 (was numa_migrate_prep)
Date: Thu, 08 Aug 2024 19:13:20 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <9AAAC209-3CAB-4985-B805-373DF9830E89@nvidia.com>
In-Reply-To: <4CC95A65-A183-4D7B-A52E-5AAFB56625E1@nvidia.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <20240807184730.1266736-2-ziy@nvidia.com>
 <8734nf1wil.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4CC95A65-A183-4D7B-A52E-5AAFB56625E1@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3FFA3433-E37D-454E-89FE-190AC6F770BC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0448.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::33) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: f31eda8a-1885-4fb8-e6cb-08dcb7ffb2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0M5os8wLecYTUR60lzLDycr1Y3w7SdqSSgLDeGqLwrCLSQF9t1Gt67r7FeX?=
 =?us-ascii?Q?L4yn6r07PtMkOhSPybXvgf5HdCUS14UPJc7sWcQgIpinAVD8HRwVjGUaYitQ?=
 =?us-ascii?Q?HuZL5QK2ymG88RDLM68GvO8T/Ba4wuoY7b2QdEnIrDjTWjNQ85JjxEPv180C?=
 =?us-ascii?Q?rPbXLOcABmBnhyoZegyR/Ez/TdVvUBlFwq9Hxg57CF/CWWqVPstkFHiEchF4?=
 =?us-ascii?Q?3/Vzha7XoqV/I9039v8btfC4hA3+hoNQBGw6Qq8bn+Ea6WbPQp1d4sVV11nT?=
 =?us-ascii?Q?x5eAjYCp/l8RsSsXiIRCet7TzqlvV6csrUvNnpFUViV9qvePna88ofHK7vSt?=
 =?us-ascii?Q?tfZmMvP1QVbjJSUprL/IzutTiELRDlna7aDJhA685Dcu4G2e9SkLVxhaADSf?=
 =?us-ascii?Q?bHmq4UAAhYd+aXJ/hX+QpdNQp4YOOoMwvdfvfNxnBGAieMS203y+MS+E9rvd?=
 =?us-ascii?Q?546CeK4ADt/pOdD3swEE9dR/kXJxjxFwogpP6nVSMCowZoIl1hU+WOqWbeMm?=
 =?us-ascii?Q?Iaugp/jHBbDTU+8C40/JCGP3lum9E0JTKGK0BLeBXm0nvXBuIvYkQL3qoizW?=
 =?us-ascii?Q?AP0t20aGt60gOCFgkv1DxJdo/aAVLTsyIZrHOdJZEj+XcPs5gmsk3An9iy08?=
 =?us-ascii?Q?gELXCmcaIRAxXwBxZ7ILKZ6AtY+vCfuEmrSbOlxguP3oPNo96CNqLlijm984?=
 =?us-ascii?Q?x2YXXeD7GI5rklUf5R3J6RPvMnQtewheAy60cRzzTBg1gzYwmWPf5Qr5Ys+a?=
 =?us-ascii?Q?XZpGLXNiTX7eMFi/ozL8909ttn3P5bM901w539/gNIBBnbYf7zcwaRRqfOOt?=
 =?us-ascii?Q?nqF4TpwVXBIg4mbvtT0TtBdOIdXD5Q8a6LMSdO+sIcsHMUCv6RFYiRFR6EUi?=
 =?us-ascii?Q?pajNmji+JYfWKcUwAvb5IGYPCW4O0cKBbb8bV/PtlGI1Y2m9i7mL1FTU4ENF?=
 =?us-ascii?Q?sOseVwkO+6KLB9C3nm7gA3cBkKbFeQ+1/WQASA3uHkPKVn1mOQr/2Kk/XShm?=
 =?us-ascii?Q?w6poUptl7OSMsEp+7UTOOKk3BDogkBq6v5+xXd/VMzW9tpB21AdZv5Dug0Vz?=
 =?us-ascii?Q?dpvwBPiSRrxwGsp/Mew0U7ZN0ujgjZNYf7JKWz1/S4KctXPazh/YJgULHpI2?=
 =?us-ascii?Q?QlCOfRPJ3Z1Qfi5vMtCg7gzG5P5OMPKVEzB6D/OFb6k5urrGlJ/YBMnGm5Rm?=
 =?us-ascii?Q?8Lct6IUaXwxvJVNG1K6c2eindHGnLnLOhKQ93DJgz3F2NcMTOdBm2E3Wkvvx?=
 =?us-ascii?Q?8YvAYg/BlUMtgrCFurEqrkOjSkTnxs+86c3dOV7fTiD0etAknXTypA7DuJrs?=
 =?us-ascii?Q?udiAMbQA9xI0ktsad//gNTiCkzjqW47P9/WthcJJMyj2KQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mES9yvCNU7fIZ6eLmJhQ5cmcXpaxzfKapHjajWFaEVR5kZK9Y1D9purhd6bz?=
 =?us-ascii?Q?KOvQufaGyETRtg1k1zx5QvMoVbi4jyOb/dCbzf6PKD7yTe0zY5JVBq3rTgq8?=
 =?us-ascii?Q?yEUkCFSqxqFVn7wUPWHr+AlE25STiECAL7/YCJCa5fcyti+3iCyR8XMKQCI4?=
 =?us-ascii?Q?Mfvg5+cNOqMqP2I5RxPrNLxZlSypKUJ3A5k5WVsLekop1LuPWezRMbJuL0d8?=
 =?us-ascii?Q?4znKaxTWG5aCF7/MtAcXe/oocLIWB4xy7ueF9lnpcgNDyE8I1PP+tFkFDkJY?=
 =?us-ascii?Q?6yB364oo1voahPFuTDzasx4R1sg4lTjymcGGmSiAY1JYZnZLCsjpufsVrZ10?=
 =?us-ascii?Q?uEsEmuaDiEp4QqdFd/jJ9rYNyDZ8C40ahCUetj8w6NT4913CNN+vmAgfCU7Y?=
 =?us-ascii?Q?B5UDJENJOdMXvKvUoFZEetM5yjN2ZT8vs/uLMREhubxL4kdQNbJt+NXFV6zX?=
 =?us-ascii?Q?XMlLjp++D7OkK8ym2U+sLl5P9UoiJ/Q7jQ3oeMsWUciNLjC3ZfpzzOyyWUwH?=
 =?us-ascii?Q?FbNAc8S2igAO/MjYcCEqevzMDJoqD8DQxc7Hyc3Y6CdKMQLZej3fgB4VYTjR?=
 =?us-ascii?Q?i6yPGqcMFqqyL3f1s8DQLRru7EgZlCzz4KFbUqjZ74v/uJWupDaZ3507m9Dr?=
 =?us-ascii?Q?hI32ufSF0oCcAJxToCSa580Sy+Bk7YEQRKcjC9kHT+35TWHviKpN0yRJtY3w?=
 =?us-ascii?Q?ogWTUwmQl4TZocXEtIw2FOixvHucYWLJSHklu+HP2A8SLGG48UAvkpnsyhWf?=
 =?us-ascii?Q?NKqMgFX7dgkBfAoXhdgDvF35mapwZTYX8hVdHLj0LzzKYhUAcvcs3Tly73LZ?=
 =?us-ascii?Q?/QXYQPgatEhCrO8kUkMUwi8soHbhrhFhKmY2BNiGXLzhgFkeYyNxc+iDaKmW?=
 =?us-ascii?Q?0cCQ0wxqc5ESE+yAJvqruF8t8APbIHDggxrj1eBvk4nWjuPBmK73DScckcJ9?=
 =?us-ascii?Q?gxbag3sTgT6EEcUZZqMC3FyCTlI1ccKMe+23BdMMuZud98dZC4B+5Db87dza?=
 =?us-ascii?Q?z5PcD8BQT+h+yEakxaKhPMIA+G53NmmnAoAgdI1wnJSQajcfqMDfGwlOPbIn?=
 =?us-ascii?Q?VgrbmMOyT2vT27Hzp1M/cIEwJNwLsttDhwgWoJvmIZoAWCe2eU5hI06zdcWL?=
 =?us-ascii?Q?p0WaGrdmpWhn1UGYwkh0Ybzl81U3GR8HzohgSw21P1vt1oTkiocL05ljD35j?=
 =?us-ascii?Q?7QlCsPhQni6xy0AGk9yYSJtFavHRXrli2WwQSTzy1mRuayw9qKd0WpO3/CK+?=
 =?us-ascii?Q?jbty8YQDt9YgKXxxT8tvrmR51+XHr0cwO7HZ4zQfxICbKU6gIb05WWaSrWr/?=
 =?us-ascii?Q?i8s8NtoFo7p9dG6OMDa53P56zyBB7SqqEywbbX7yFVpENP3zP/iBYr962HnB?=
 =?us-ascii?Q?t7hN2uw2gHBkg4AYfRa8ofxdjgMIFvEehIEtf3CYlCD3e4UWLG0XkLKe9e9W?=
 =?us-ascii?Q?DkfKRNPWbFz5dIJviOS/Z1naFyebddljW+O1AQeZiQD4nf/ngpWa1SXjjVmg?=
 =?us-ascii?Q?LHhzi+w0gQjSh37cosTlmjHA4qIfkNA3Y9RYIDFLi6rO8D1SxxozB5Ag3wu1?=
 =?us-ascii?Q?AvEdgu4SUSvBWyta6Pc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31eda8a-1885-4fb8-e6cb-08dcb7ffb2d3
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 23:13:22.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30EKKqYO7mFsfAK9ypCEoH/rSClCaAaREOl6+yF3MC2saT2yNSWtaj93Ub9CnMTF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

--=_MailMate_3FFA3433-E37D-454E-89FE-190AC6F770BC_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_A9BF1003-460E-40C4-9D38-ECDAB0F61BB4_="


--=_MailMate_A9BF1003-460E-40C4-9D38-ECDAB0F61BB4_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Aug 2024, at 10:59, Zi Yan wrote:

> On 8 Aug 2024, at 0:14, Huang, Ying wrote:
>
>> Zi Yan <ziy@nvidia.com> writes:
>>
>>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code=
=2E To
>>> reduce redundancy, move common code to numa_migrate_prep() and rename=

>>> the function to numa_migrate_check() to reflect its functionality.
>>>
>>> Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHAR=
ED
>>> flag.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/huge_memory.c | 14 ++-------
>>>  mm/internal.h    |  5 ++--
>>>  mm/memory.c      | 76 ++++++++++++++++++++++++----------------------=
--
>>>  3 files changed, 44 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index a3c018f2b554..9b312cae6775 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1699,18 +1699,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fa=
ult *vmf)
>>>  	if (!folio)
>>>  		goto out_map;
>>>
>>> -	/* See similar comment in do_numa_page for explanation */
>>> -	if (!writable)
>>> -		flags |=3D TNF_NO_GROUP;
>>> -
>>>  	nid =3D folio_nid(folio);
>>
>> NITPICK: It appears that we can remove "nid" local variable.
>
> I thought about it, but
>
> 1. if folio is NULL from vm_normal_folio_pmd(), nid remains NUMA_NO_NOD=
E,
> 2. if migration succeeds, nid is changed to target_nid,
> 3. if migration fails, nid is the folio node id,
>
> all three are consumed by if (nid !=3D NUMA_NO_NODE) before task_numa_f=
ault().
>
> I will give it a try in next version and see if I can remove it.
>
>>
>>> -	/*
>>> -	 * For memory tiering mode, cpupid of slow memory page is used
>>> -	 * to record page access time.  So use default value.
>>> -	 */
>>> -	if (!folio_use_access_time(folio))
>>> -		last_cpupid =3D folio_last_cpupid(folio);
>>> -	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>> +
>>> +	target_nid =3D numa_migrate_check(folio, vmf, haddr, &flags, writab=
le,
>>> +					&last_cpupid);
>>>  	if (target_nid =3D=3D NUMA_NO_NODE)
>>>  		goto out_map;
>>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 52f7fc4e8ac3..fb16e18c9761 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -1191,8 +1191,9 @@ void vunmap_range_noflush(unsigned long start, =
unsigned long end);
>>>
>>>  void __vunmap_range_noflush(unsigned long start, unsigned long end);=

>>>
>>> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>>> -		      unsigned long addr, int page_nid, int *flags);
>>> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
>>> +		      unsigned long addr, int *flags, bool writable,
>>> +		      int *last_cpupid);
>>>
>>>  void free_zone_device_folio(struct folio *folio);
>>>  int migrate_device_coherent_page(struct page *page);
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 503d493263df..b093df652c11 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -5368,16 +5368,43 @@ static vm_fault_t do_fault(struct vm_fault *v=
mf)
>>>  	return ret;
>>>  }
>>>
>>> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>>> -		      unsigned long addr, int page_nid, int *flags)
>>> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
>>> +		      unsigned long addr, int *flags,
>>> +		      bool writable, int *last_cpupid)
>>>  {
>>>  	struct vm_area_struct *vma =3D vmf->vma;
>>>
>>> +	/*
>>> +	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt a=
s
>>> +	 * much anyway since they can be in shared cache state. This misses=

>>> +	 * the case where a mapping is writable but the process never write=
s
>>> +	 * to it but pte_write gets cleared during protection updates and
>>> +	 * pte_dirty has unpredictable behaviour between PTE scan updates,
>>> +	 * background writeback, dirty balancing and application behaviour.=

>>> +	 */
>>> +	if (!writable)
>>> +		*flags |=3D TNF_NO_GROUP;
>>> +
>>> +	/*
>>> +	 * Flag if the folio is shared between multiple address spaces. Thi=
s
>>> +	 * is later used when determining whether to group tasks together
>>> +	 */
>>> +	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED=
))
>>> +		*flags |=3D TNF_SHARED;
>>> +	/*
>>> +	 * For memory tiering mode, cpupid of slow memory page is used
>>> +	 * to record page access time.  So use default value.
>>> +	 */
>>> +	if (folio_use_access_time(folio))
>>> +		*last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>> +	else
>>> +		*last_cpupid =3D folio_last_cpupid(folio);
>>> +
>>>  	/* Record the current PID acceesing VMA */
>>>  	vma_set_access_pid_bit(vma);
>>>
>>>  	count_vm_numa_event(NUMA_HINT_FAULTS);
>>> -	if (page_nid =3D=3D numa_node_id()) {
>>> +	if (folio_nid(folio) =3D=3D numa_node_id()) {
>>>  		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
>>>  		*flags |=3D TNF_FAULT_LOCAL;
>>>  	}
>>> @@ -5442,13 +5469,13 @@ static void numa_rebuild_large_mapping(struct=
 vm_fault *vmf, struct vm_area_stru
>>>  static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>  {
>>>  	struct vm_area_struct *vma =3D vmf->vma;
>>> +	pte_t old_pte =3D vmf->orig_pte;
>>
>> The usage of old_pte is different from other use cases.  Where,
>>
>> old_pte =3D *pte;
>> check old_pte and orig_pte
>> generate new_pte from old_pte
>> set new_pte
>>
>> We have used this before in do_numa_page(), but not do that now.  But =
I
>> still think that it's better to follow the convention partly if
>> possible.  This makes code easier to be read.  I notices that we don't=

>> follow it in do_huge_pmd_numa_page(), we may change that?
>
> Sure, since I am trying to make do_numa_page() and do_huge_pmd_numa_pag=
e()
> use the same pattern.
>
>>
>>> +	pte_t pte;
>>>  	struct folio *folio =3D NULL;
>>>  	int nid =3D NUMA_NO_NODE;
>>>  	bool writable =3D false, ignore_writable =3D false;
>>>  	bool pte_write_upgrade =3D vma_wants_manual_pte_write_upgrade(vma);=

>>> -	int last_cpupid;
>>> -	int target_nid;
>>> -	pte_t pte, old_pte;
>>> +	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>
>> Because we will initialize last_cpupid in numa_migrate_check(), we don=
't
>> need to initialize it here?
>
> Will remove it.
>
> Thanks for the review.

I attached my fixup and updated patch 2.

Let me know how it looks.

--
Best Regards,
Yan, Zi

--=_MailMate_A9BF1003-460E-40C4-9D38-ECDAB0F61BB4_=
Content-Disposition: attachment;
 filename=0001-mm-migrate-move-common-code-to-numa_migrate_check-wa.patch
Content-ID: <B4774C6F-5E15-40E1-972A-6F83CBC52D96@nvidia.com>
Content-Type: text/plain;
 name=0001-mm-migrate-move-common-code-to-numa_migrate_check-wa.patch
Content-Transfer-Encoding: quoted-printable

=46rom 9d2f9fc7a3e7d21af820c91aa239b6a2511d7840 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 8 Aug 2024 11:17:03 -0400
Subject: [PATCH] mm/migrate: move common code to numa_migrate_check (was
 numa_migrate_prep)

do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To=

reduce redundancy, move common code to numa_migrate_prep() and rename
the function to numa_migrate_check() to reflect its functionality.

Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHARED
flag.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 29 +++++++++-------------
 mm/internal.h    |  5 ++--
 mm/memory.c      | 63 +++++++++++++++++++++++++-----------------------
 3 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4e4364a17e6d..96a52e71d167 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1669,22 +1669,23 @@ static inline bool can_change_pmd_writable(struct=
 vm_area_struct *vma,
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
-	pmd_t oldpmd =3D vmf->orig_pmd;
-	pmd_t pmd;
 	struct folio *folio;
 	unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
 	int nid =3D NUMA_NO_NODE;
-	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
+	int target_nid, last_cpupid;
+	pmd_t pmd, old_pmd;
 	bool writable =3D false;
 	int flags =3D 0;
 =

 	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
-	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+	old_pmd =3D pmdp_get(vmf->pmd);
+
+	if (unlikely(!pmd_same(old_pmd, vmf->orig_pmd))) {
 		spin_unlock(vmf->ptl);
 		return 0;
 	}
 =

-	pmd =3D pmd_modify(oldpmd, vma->vm_page_prot);
+	pmd =3D pmd_modify(old_pmd, vma->vm_page_prot);
 =

 	/*
 	 * Detect now whether the PMD could be writable; this information
@@ -1699,18 +1700,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault =
*vmf)
 	if (!folio)
 		goto out_map;
 =

-	/* See similar comment in do_numa_page for explanation */
-	if (!writable)
-		flags |=3D TNF_NO_GROUP;
-
 	nid =3D folio_nid(folio);
-	/*
-	 * For memory tiering mode, cpupid of slow memory page is used
-	 * to record page access time.  So use default value.
-	 */
-	if (!folio_use_access_time(folio))
-		last_cpupid =3D folio_last_cpupid(folio);
-	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
+
+	target_nid =3D numa_migrate_check(folio, vmf, haddr, &flags, writable,
+					&last_cpupid);
 	if (target_nid =3D=3D NUMA_NO_NODE)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
@@ -1728,7 +1721,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 	} else {
 		flags |=3D TNF_MIGRATE_FAIL;
 		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+		if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
 			spin_unlock(vmf->ptl);
 			return 0;
 		}
@@ -1736,7 +1729,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 =

 out_map:
 	/* Restore the PMD */
-	pmd =3D pmd_modify(oldpmd, vma->vm_page_prot);
+	pmd =3D pmd_modify(pmdp_get(vmf->pmd), vma->vm_page_prot);
 	pmd =3D pmd_mkyoung(pmd);
 	if (writable)
 		pmd =3D pmd_mkwrite(pmd, vma);
diff --git a/mm/internal.h b/mm/internal.h
index 52f7fc4e8ac3..fb16e18c9761 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1191,8 +1191,9 @@ void vunmap_range_noflush(unsigned long start, unsi=
gned long end);
 =

 void __vunmap_range_noflush(unsigned long start, unsigned long end);
 =

-int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
-		      unsigned long addr, int page_nid, int *flags);
+int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
+		      unsigned long addr, int *flags, bool writable,
+		      int *last_cpupid);
 =

 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index d9b1dff9dc57..3441f60d54ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5368,16 +5368,43 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	return ret;
 }
 =

-int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
-		      unsigned long addr, int page_nid, int *flags)
+int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
+		      unsigned long addr, int *flags,
+		      bool writable, int *last_cpupid)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
 =

+	/*
+	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
+	 * much anyway since they can be in shared cache state. This misses
+	 * the case where a mapping is writable but the process never writes
+	 * to it but pte_write gets cleared during protection updates and
+	 * pte_dirty has unpredictable behaviour between PTE scan updates,
+	 * background writeback, dirty balancing and application behaviour.
+	 */
+	if (!writable)
+		*flags |=3D TNF_NO_GROUP;
+
+	/*
+	 * Flag if the folio is shared between multiple address spaces. This
+	 * is later used when determining whether to group tasks together
+	 */
+	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
+		*flags |=3D TNF_SHARED;
+	/*
+	 * For memory tiering mode, cpupid of slow memory page is used
+	 * to record page access time.  So use default value.
+	 */
+	if (folio_use_access_time(folio))
+		*last_cpupid =3D (-1 & LAST_CPUPID_MASK);
+	else
+		*last_cpupid =3D folio_last_cpupid(folio);
+
 	/* Record the current PID acceesing VMA */
 	vma_set_access_pid_bit(vma);
 =

 	count_vm_numa_event(NUMA_HINT_FAULTS);
-	if (page_nid =3D=3D numa_node_id()) {
+	if (folio_nid(folio) =3D=3D numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
 		*flags |=3D TNF_FAULT_LOCAL;
 	}
@@ -5479,35 +5506,11 @@ static vm_fault_t do_numa_page(struct vm_fault *v=
mf)
 	if (!folio || folio_is_zone_device(folio))
 		goto out_map;
 =

-	/*
-	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
-	 * much anyway since they can be in shared cache state. This misses
-	 * the case where a mapping is writable but the process never writes
-	 * to it but pte_write gets cleared during protection updates and
-	 * pte_dirty has unpredictable behaviour between PTE scan updates,
-	 * background writeback, dirty balancing and application behaviour.
-	 */
-	if (!writable)
-		flags |=3D TNF_NO_GROUP;
-
-	/*
-	 * Flag if the folio is shared between multiple address spaces. This
-	 * is later used when determining whether to group tasks together
-	 */
-	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
-		flags |=3D TNF_SHARED;
-
 	nid =3D folio_nid(folio);
 	nr_pages =3D folio_nr_pages(folio);
-	/*
-	 * For memory tiering mode, cpupid of slow memory page is used
-	 * to record page access time.  So use default value.
-	 */
-	if (folio_use_access_time(folio))
-		last_cpupid =3D (-1 & LAST_CPUPID_MASK);
-	else
-		last_cpupid =3D folio_last_cpupid(folio);
-	target_nid =3D numa_migrate_prep(folio, vmf, vmf->address, nid, &flags)=
;
+
+	target_nid =3D numa_migrate_check(folio, vmf, vmf->address, &flags,
+					writable, &last_cpupid);
 	if (target_nid =3D=3D NUMA_NO_NODE)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
-- =

2.43.0


--=_MailMate_A9BF1003-460E-40C4-9D38-ECDAB0F61BB4_=
Content-Disposition: attachment; filename=patch2_fixup.patch
Content-ID: <87516286-5954-481D-AE62-8E328A6951BE@nvidia.com>
Content-Type: text/plain; name=patch2_fixup.patch
Content-Transfer-Encoding: quoted-printable

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5610289865a7..96a52e71d167 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1669,22 +1669,23 @@ static inline bool can_change_pmd_writable(struct=
 vm_area_struct *vma,
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
-	pmd_t oldpmd =3D vmf->orig_pmd;
-	pmd_t pmd;
 	struct folio *folio;
 	unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
 	int nid =3D NUMA_NO_NODE;
-	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
+	int target_nid, last_cpupid;
+	pmd_t pmd, old_pmd;
 	bool writable =3D false;
 	int flags =3D 0;
 =

 	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
-	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+	old_pmd =3D pmdp_get(vmf->pmd);
+
+	if (unlikely(!pmd_same(old_pmd, vmf->orig_pmd))) {
 		spin_unlock(vmf->ptl);
 		return 0;
 	}
 =

-	pmd =3D pmd_modify(oldpmd, vma->vm_page_prot);
+	pmd =3D pmd_modify(old_pmd, vma->vm_page_prot);
 =

 	/*
 	 * Detect now whether the PMD could be writable; this information
@@ -1720,7 +1721,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 	} else {
 		flags |=3D TNF_MIGRATE_FAIL;
 		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
+		if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
 			spin_unlock(vmf->ptl);
 			return 0;
 		}
@@ -1728,7 +1729,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 =

 out_map:
 	/* Restore the PMD */
-	pmd =3D pmd_modify(oldpmd, vma->vm_page_prot);
+	pmd =3D pmd_modify(pmdp_get(vmf->pmd), vma->vm_page_prot);
 	pmd =3D pmd_mkyoung(pmd);
 	if (writable)
 		pmd =3D pmd_mkwrite(pmd, vma);
diff --git a/mm/memory.c b/mm/memory.c
index f186a8d8c992..3441f60d54ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5469,13 +5469,13 @@ static void numa_rebuild_large_mapping(struct vm_=
fault *vmf, struct vm_area_stru
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
-	pte_t old_pte =3D vmf->orig_pte;
-	pte_t pte;
 	struct folio *folio =3D NULL;
 	int nid =3D NUMA_NO_NODE;
 	bool writable =3D false, ignore_writable =3D false;
 	bool pte_write_upgrade =3D vma_wants_manual_pte_write_upgrade(vma);
-	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
+	int last_cpupid;
+	int target_nid;
+	pte_t pte, old_pte;
 	int flags =3D 0, nr_pages;
 =

 	/*
@@ -5483,7 +5483,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vm=
f)
 	 * table lock, that its contents have not changed during fault handling=
=2E
 	 */
 	spin_lock(vmf->ptl);
-	if (unlikely(!pte_same(old_pte, ptep_get(vmf->pte)))) {
+	/* Read the live PTE from the page tables: */
+	old_pte =3D ptep_get(vmf->pte);
+
+	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return 0;
 	}
@@ -5530,7 +5533,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
 					       vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
-		if (unlikely(!pte_same(old_pte, ptep_get(vmf->pte)))) {
+		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return 0;
 		}

--=_MailMate_A9BF1003-460E-40C4-9D38-ECDAB0F61BB4_=--

--=_MailMate_3FFA3433-E37D-454E-89FE-190AC6F770BC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAma1URAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUwToP/ihhj0YoqGi5C3xmWMbpV6UF0gNxJPE2oIQm
XQdX8wKoa3w53X0WFNMtEw6vkxUBFyQL+0c+AQpqVaIh7eQFirqAKOsfz7vSc5gc
wgwohF7vKOlx7fduBFmGpWxGzIEJiUimhQ+lzQaMwDaM5izT6aJNzADf5qFDj6XF
DzC+N5+rtyVTIR8TkztF6CxygKr0SJWgKigWMhhxGgQhOG5Mrmij51DzbQkuwvGT
M4xM9CiJtmgLtuxe+DMaEoQAxu6EA8SfC1XfML9gGKEC93foIf134L9Y8Aq/EDXU
1S8SsoEoOLgepcwCSOIb70KMCB6a9zFii89u/Or/4BJSwHOWjl6OVIHsMvqiaf4a
KLrJA1+qr+iQLZJhz0Wb0ou36OkWtHCgJ2t35gRlQnHATO/bkQ0icmdoBx0jMuDP
jZAFnCaZj+nn3Y/jBkB0Eqa/rS4Ylcq2pL2G6ssw7zDlVVIweSTh4LWOiPyhYTf3
WvJ5/BlGQI7mgxGAjNeQN+NqkwLUAha1CBooDX/NPOUyQlCW0ix2NOosLelZfwJ+
wcImLHWjG/Se9PiANxnWEXMaz8VChKp0e7bgBGdw7mzXsRk0HIoG3TBzZLpFTe96
jzozrjcqAu5XdlFHNEu6vZMmhbRD61qaWDnhSJljq2aaEpnllYA0oAs7pY6QruY+
P4ZZcLFw
=rcJz
-----END PGP SIGNATURE-----

--=_MailMate_3FFA3433-E37D-454E-89FE-190AC6F770BC_=--

