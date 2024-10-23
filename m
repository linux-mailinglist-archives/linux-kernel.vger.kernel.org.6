Return-Path: <linux-kernel+bounces-378535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04E39AD205
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C204F1C25ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315F1D1E94;
	Wed, 23 Oct 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iwy3XiH0"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DEB1CF2A1;
	Wed, 23 Oct 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702520; cv=fail; b=pPYF+psqMzl2KPZM/dgzGhH0AfujXYzqACGUpI+1FrfqiGnEL+Qav9XUgna2wlolpjxTduVH3rnmCVnFQh4+oOOuWJ3wr40cfgRcpdCgUS8ksaQtyPaEOuLzCCHYaIMeX2fA+WiR1w6I3eydaI7CXaSi594qGvZtfdL7iLjoTus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702520; c=relaxed/simple;
	bh=Eq6QDO2bZ6tBPkjuMJ8csTYUvtnhHC4mwsWt0pm45Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDJSBbzgKbk/k7spZ9Wft1xSZWjnxk3igg2vUPjm0QiltT0AjqbOKCPvgCecSqYNnE30aicpVH7j7i3P109HzRITPUdGIRYS8UEbY53tptqJFADnwR+E+iTjWwmTymxJiULynumqSXjscFDXSRDffo44iHpDBxuJ7NKxaRnxXKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iwy3XiH0; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWOJjW/qt5p4hOGNHFw6wRiTIPyEhfd5DkplB/moalLhDvcRq5wW7Yl3DPbbtVUnJNzz3R6Vh/lo34qbP0TNrvMkG490/OHO/Igte/VYHQarx/Y9lDOlpPT0wjL8DP4Od3FIhSGyEh1K2aOp2mGf2R+CKST4nhokFMTogE1KC13vp/uyZ1BBF01OPLDOqH9N0F9mKBDifAB7lZcGloK7sz4WtUAZ9QvAISXStJqjRVK6z8z6pW+wcR8bKk5Re81UsKMM3dAflewBsU6H90AT4D4pU7MvhjI46/p0gJWZ6hmv4SKOwi7d85RCyEFtWdRuqwDqDK+Pw3DdUxCSrl99fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oSpYmuh7BI7sqCNhQmegyqK84eGviU90P3dsEEvGVg=;
 b=K4AfUmVAAZjdfrNlypQe5T7uFBwfjUWwzw5x5WNYSvW+nokQWHPnjgMIxWvE5Y+R/bTQ+77rHs2w8HQj0uoMpFqNV4/uSYA8t7r1Q9nrPhqBdeDdstZLdPoMit6s3H5jC7oxpenUWjuwpZXIG31hhxidOXeLzxZ762EKADZba6etkdQzdBpzzv6MlNd19vUUp/omXOjTa+rk5TtaQZd0bf5uH0KpaGScrqp0lfqFzrpnxi0VokxJ/I46wk4uCqxj8tvCh15DVGeHdPXL/Q1q7fiFTV+sGUN/eGS7/SMm1edCw+HrtpFaXX8MXxulkE19MnfJN2ls9VMPxrQjsolAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oSpYmuh7BI7sqCNhQmegyqK84eGviU90P3dsEEvGVg=;
 b=Iwy3XiH00RWwBG5os6413JkYOCeR+4fLrxPKD2TIGHTkk2T8PMIwq1KknYOFVjfih0rAoklRAbFrowJaAPxl3NuPB88Jcfu9VJXkJ+bNW+edElVQur9XgnScc4cRy1jXDNBGeNVZ7q7oXb3CWQztK0u71JmMKKctiWuXrkkEATDgSBkEFFJaE5prFwrS3+EXJgeTihOH6ZoEtMIHdU+D4DvJVzKvcbbY4sSR5dtQ5QIE8qR9vJ3DPTXXVFqrwb2G33uIXkEMuuw2Oe8EXHjZbWNaysaIBcFaXL6Ix3IkgoqYlxKXZe1gUCOAHcxhbEXw0tLh3qgpgGk9GLGCCWRlzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 16:55:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 16:55:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: yuzhao@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, david@redhat.com, npache@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
Date: Wed, 23 Oct 2024 12:55:12 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <84B216E2-238F-4BB3-8015-3BADC48F5F43@nvidia.com>
In-Reply-To: <27d04537-ebda-4462-b008-878390d4b211@gmail.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-3-usamaarif642@gmail.com>
 <4B7449C4-D2B8-4285-973C-97178C09CE7E@nvidia.com>
 <27d04537-ebda-4462-b008-878390d4b211@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BC814CCE-22FE-4FED-BCC5-E9F36F03855E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0252.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6f4668-35ee-4d91-6f9a-08dcf38377c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mpaJDGQ2ddVfqXaFCAKIEMIsiJRmvK3LyF5dzaZUvo7Ff0tl6dF5oWl4CR9A?=
 =?us-ascii?Q?Xh71EWd0l7lV+wtjfe5vJOFLVdMi78B+QLqHAtCs1cWv/45pUcIWHaVAWa0o?=
 =?us-ascii?Q?NenT4czv1roBbieHU6QxkHPNJFsuV2tyD805xyQf7mOipbzJUTSndNtTqhPz?=
 =?us-ascii?Q?F6xaYpRns0tzGkv5Cq2UkMrtX69vt4dRjOjQvN/zP1RWG/1TayYrwWdjc5Y8?=
 =?us-ascii?Q?nIzJENl18SG/wjSijBsJOZwp/kThKh3iHIah7vf+zZXM0/5D6z0cuRckLQTH?=
 =?us-ascii?Q?YNNeCPGXTXkPEoArGKGW/le31gi426kOhluvdHnp4RHoz+1tQjaV3CznFv0D?=
 =?us-ascii?Q?S11zAHvwxqdOnkvH58AWuE5DxPE7fWbzwu8Zy0MuahT9Uz1d+iRo3/G4Lh2A?=
 =?us-ascii?Q?zm50ucKGlFCQlow9KPem5J2Xxl4qAW/N+efmYbPfQDz8HPdH81SWivAlbvhs?=
 =?us-ascii?Q?tSMx8fITgpf2oK8Z8espbEMJHTeXW15QlLYiBOzgkTzl+i0Fs6TiYKpA3xjT?=
 =?us-ascii?Q?t156SyCJvP8c6TwDKIKdVP2ci1U0pTIMCNKCmVjuM+ADtVrUtRhcnFbpl4dm?=
 =?us-ascii?Q?eo2BceaQCZVd0Ly0CcUvwyrMSjpedG9lSgEQxFngeXxOPUDiX4CH92m7FIi8?=
 =?us-ascii?Q?vawYABZ/MorrnR4MnhTNzBKtsqpOkhQTAJAMxUnz7i84zV7TA6tMWu7cX9jz?=
 =?us-ascii?Q?pHLCr9cLyPF7paklcftCFPuuj566jqXRbnfCo5baMcVa5j2SzetHJrBHEdvS?=
 =?us-ascii?Q?Ej/e8EN3CCrYMAIoGaBbevuvmenLYtZ9gQxKcWp5jluM1CWFRjXBUSlySYAX?=
 =?us-ascii?Q?L41q/5VBf+Q5lhHkqoEbXNVUpK+CYKvF2isgdXE5TfLKfGeZNQ3uEtFhP9GR?=
 =?us-ascii?Q?IdrRkIXZnd5KPmIfeuqs3i9gbX73kmlmCLr8UHP6o4j9h6/UqfaN3M6iE48O?=
 =?us-ascii?Q?TIr9JHL9p/ideGPe2u/5OCJZWc85RcqoAc6kQZp3dOoJIcjOn5y0G6cUbZ6s?=
 =?us-ascii?Q?VjZW2Nw/RDmAU181gto4NG/HmPfYOK1GEQ9eTR3iUF+/581GllS3Rwnphb/l?=
 =?us-ascii?Q?sJH7hwkZ8UAki+KI5EVDFRxE2/UqFNhjMQc4bi1UzY7EYkWfQ/SeO3P/yxmY?=
 =?us-ascii?Q?wDZyNy4dxY1nmmTPhTaAE0T9AgY60tcorXcqpD0R2/psaNJYE3WK00U3GUe3?=
 =?us-ascii?Q?ERzXGfSXTKI9TyS86HXS1lqMEkljEr6LSx1LsWhEsoNcmkOai/5fLOCHvzB1?=
 =?us-ascii?Q?0fEsFcEN/L2fkpIo0CGc0LZwzgGiyt7Gv9dB36oR1zCJOAYy3eDnIR5dYqxd?=
 =?us-ascii?Q?b+m0nElpj6O0N6rKqKOoxYlc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?svpJJf0g//ldq5Ulq9P0jlYpHg2swwG6yik85HAroeIY60mCMZYhChhI9Xnh?=
 =?us-ascii?Q?BMW+zoVo0p4Ntuh6TuxL2BkguVt+8dSxXSqYrm5G7QSUR2swfYyT/N8sCfoS?=
 =?us-ascii?Q?LJsppLz65gg+NiQ1kj7y4hz7SLkP/SYFSYyFYY5g5vKxrNX5BMTCTmSnqolK?=
 =?us-ascii?Q?tCR44OuHAIB8cZwZTSNpmlkVIPt0OpLAmOZMsLq4ZwQHNDh8kvNndq95DIAl?=
 =?us-ascii?Q?o4j1VNChsiiAgavljsqeHZiP+Yy4YObpooNkHJoXmjC2XMWEsze7Dv/3Yq7a?=
 =?us-ascii?Q?0gmGPvRLq+e0hsfLRbSe7f2jAh6fZEPZbPE3cxePGZvv+ZN/Ruuag6Zw1L+V?=
 =?us-ascii?Q?aTqxFGUpvNJai41wclKAyG7JxzGmBCscKCCXRls1Qeu74QMNpMwOnSwt2tHp?=
 =?us-ascii?Q?1648L9N0ArVkmPGFEGri7dMI/O6NZ5hFr3l2eh4luH6Vx4rLTy3AxRMperZa?=
 =?us-ascii?Q?2sDNa61uMsoE1vtApRraZtRIBtQzEnzCC+UbcgWJI4sOpYoRGbbAryc+IdM+?=
 =?us-ascii?Q?vzMv86TJ0o+l2BR4xI5zo9X/Pk8Xuu+vek1OwD+aMZzphukDVh4EFMauN9RP?=
 =?us-ascii?Q?lz+N0kwnrizbrij+4H/OMWrUfoTzGBHWQYtIt5hIxPovg7ywyAK/OH/220DW?=
 =?us-ascii?Q?as3fUGn/1LOZLItMoaKs1m1u1Xv8T4UaGLF/aVdbryzLsN48P2zjiOUQYKQ0?=
 =?us-ascii?Q?2QKOeuafrmogRl/4EWK+kw9GktUlp20Z4lGJz3AuBLxtfiFWUR9i1L7zTi5f?=
 =?us-ascii?Q?olOFST8l1fIxILct8QU4EIG70V/scp828XQO9xqI7f8FcSiKZKgL4d1DMoux?=
 =?us-ascii?Q?mfSfnvbd/5K7qHTbeGkOPBDyS+b69wydZVYGGcPJu0swu65tv/ILHs5+JzwT?=
 =?us-ascii?Q?iimfKIdtLNJ62uEpsNr9afU5VRMM9werXvjb8HxmwuMe5S4+BCdjKAaHJ2ax?=
 =?us-ascii?Q?VGzhI+NtT2csDtPq9Kaw0ofmeozc6m3YwtVdKbB/3Q92aG/PK8oFTFrRhO0m?=
 =?us-ascii?Q?7Cf8mJRdakUb1T04g0Yom5i+kBjTxaRiovIYGsrCsZG7T07w2y+fMA6D5VfJ?=
 =?us-ascii?Q?L8+DY7SsjMT9eHY4kQO2DmiahbeJ/QRwhVfiSk82tG/quGGmrboprJOCD0ey?=
 =?us-ascii?Q?gpFzItYO0pqXpmIlxYfFwD5RZ3crHwL0T5dzhZuykV4gnPLWW4SOy6LxTEKP?=
 =?us-ascii?Q?SlwYBRI9JuHAo91KukLmkcBaFKmWI1t2JLU95ENIfhkYtpAfgmyVRfU+yCq5?=
 =?us-ascii?Q?V9WXQngacJP21dqY0eMT6PPrYUGYiMw14EJNPTW+qh5CMSiKVZMrpOYTSFEZ?=
 =?us-ascii?Q?fsjfKSrzD7WhHr0CytAhumPa3VLF4WK7J/US2qFiuJp6W+VkwvhUnvtDJve/?=
 =?us-ascii?Q?0ED0U1yh9aE4BDoIzisloOBi42uOQaqS/NFTGon1HBaYCWvbVFmqYGYaoiH6?=
 =?us-ascii?Q?aowYYRmGzCOwPtQCmYM210soKyVSnb4JG1yLcyYNjDoPNeejn6S/Och3b9mH?=
 =?us-ascii?Q?/uERf5JWmJlk8pwaILYQMtf8hIKWRE5TI0IQuelbhaiX/df+pzr39+q/mhcc?=
 =?us-ascii?Q?F5CLBUiwQZw0QnqV2LyHXHJA1zWSgmd3OXcq10aw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6f4668-35ee-4d91-6f9a-08dcf38377c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:55:15.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KahIHPSsbA79D80mZA8EgFenkeY2oqHvV6K42rdCnIx6NFzCWpV8SaDJdlJYbdvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468

--=_MailMate_BC814CCE-22FE-4FED-BCC5-E9F36F03855E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 23 Oct 2024, at 12:50, Usama Arif wrote:

> On 23/10/2024 17:21, Zi Yan wrote:
>> On 30 Aug 2024, at 6:03, Usama Arif wrote:
>>
>>> From: Yu Zhao <yuzhao@google.com>
>>>
>>> Here being unused means containing only zeros and inaccessible to
>>> userspace. When splitting an isolated thp under reclaim or migration,=

>>> the unused subpages can be mapped to the shared zeropage, hence savin=
g
>>> memory. This is particularly helpful when the internal
>>> fragmentation of a thp is high, i.e. it has many untouched subpages.
>>>
>>> This is also a prerequisite for THP low utilization shrinker which wi=
ll
>>> be introduced in later patches, where underutilized THPs are split, a=
nd
>>> the zero-filled pages are freed saving memory.
>>>
>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>> Tested-by: Shuang Zhai <zhais@google.com>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> ---
>>>  include/linux/rmap.h |  7 ++++-
>>>  mm/huge_memory.c     |  8 ++---
>>>  mm/migrate.c         | 72 ++++++++++++++++++++++++++++++++++++++----=
--
>>>  mm/migrate_device.c  |  4 +--
>>>  4 files changed, 75 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index 91b5935e8485..d5e93e44322e 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -745,7 +745,12 @@ int folio_mkclean(struct folio *);
>>>  int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgo=
ff_t pgoff,
>>>  		      struct vm_area_struct *vma);
>>>
>>> -void remove_migration_ptes(struct folio *src, struct folio *dst, boo=
l locked);
>>> +enum rmp_flags {
>>> +	RMP_LOCKED		=3D 1 << 0,
>>> +	RMP_USE_SHARED_ZEROPAGE	=3D 1 << 1,
>>> +};
>>> +
>>> +void remove_migration_ptes(struct folio *src, struct folio *dst, int=
 flags);
>>>
>>>  /*
>>>   * rmap_walk_control: To control rmap traversing for specific needs
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 0c48806ccb9a..af60684e7c70 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3020,7 +3020,7 @@ bool unmap_huge_pmd_locked(struct vm_area_struc=
t *vma, unsigned long addr,
>>>  	return false;
>>>  }
>>>
>>> -static void remap_page(struct folio *folio, unsigned long nr)
>>> +static void remap_page(struct folio *folio, unsigned long nr, int fl=
ags)
>>>  {
>>>  	int i =3D 0;
>>>
>>> @@ -3028,7 +3028,7 @@ static void remap_page(struct folio *folio, uns=
igned long nr)
>>>  	if (!folio_test_anon(folio))
>>>  		return;
>>>  	for (;;) {
>>> -		remove_migration_ptes(folio, folio, true);
>>> +		remove_migration_ptes(folio, folio, RMP_LOCKED | flags);
>>>  		i +=3D folio_nr_pages(folio);
>>>  		if (i >=3D nr)
>>>  			break;
>>> @@ -3240,7 +3240,7 @@ static void __split_huge_page(struct page *page=
, struct list_head *list,
>>>
>>>  	if (nr_dropped)
>>>  		shmem_uncharge(folio->mapping->host, nr_dropped);
>>> -	remap_page(folio, nr);
>>> +	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0)=
;
>>>
>>>  	/*
>>>  	 * set page to its compound_head when split to non order-0 pages, s=
o
>>> @@ -3542,7 +3542,7 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
>>>  		if (mapping)
>>>  			xas_unlock(&xas);
>>>  		local_irq_enable();
>>> -		remap_page(folio, folio_nr_pages(folio));
>>> +		remap_page(folio, folio_nr_pages(folio), 0);
>>>  		ret =3D -EAGAIN;
>>>  	}
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 6f9c62c746be..d039863e014b 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -204,13 +204,57 @@ bool isolate_folio_to_list(struct folio *folio,=
 struct list_head *list)
>>>  	return true;
>>>  }
>>>
>>> +static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_wal=
k *pvmw,
>>> +					  struct folio *folio,
>>> +					  unsigned long idx)
>>> +{
>>> +	struct page *page =3D folio_page(folio, idx);
>>> +	bool contains_data;
>>> +	pte_t newpte;
>>> +	void *addr;
>>> +
>>> +	VM_BUG_ON_PAGE(PageCompound(page), page);
>>
>> This should be:
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index e950fd62607f..7ffdbe078aa7 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -206,7 +206,8 @@ static bool try_to_map_unused_to_zeropage(struct p=
age_vma_mapped_walk *pvmw,
>>         pte_t newpte;
>>         void *addr;
>>
>> -       VM_BUG_ON_PAGE(PageCompound(page), page);
>> +       if (PageCompound(page))
>> +               return false;
>>         VM_BUG_ON_PAGE(!PageAnon(page), page);
>>         VM_BUG_ON_PAGE(!PageLocked(page), page);
>>         VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
>>
>> Otherwise, splitting anonymous large folios to non order-0 ones just
>> triggers this BUG_ON.
>>
>
> That makes sense, would you like to send the fix?
>
> Adding Yu Zhao to "To" incase he has any objections.
>
Sure, will do.

Best Regards,
Yan, Zi

--=_MailMate_BC814CCE-22FE-4FED-BCC5-E9F36F03855E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcZKnAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK4x8P+QGvmJELSyd04SJIxizivA1c3NwWAMhdRjHx
IsO1cUxE2iXUJuqWPIGGSwwvE/NfoxL1LBZ2YEXPkoKLiElsJfdRkZi3Evg6mTzc
NxOJwUXi4U0En6tkhg+cp0dmh8yoh/hhERypW4wal8jua7je/5mfYi+AintROrHI
MNbbp0GJZmtwhEjRkNZttlJMX5SWFJ2/M4wQ9B/VK8TINvMx14iB4h8QOCQNGfsK
X+i6nvVjE/QeBy8D5Qti4neNrAau5tNW1PVmeme8NyI2w/u907u1yqHa8qAn4yzL
pafnzMwNHfLqpa5P3et0SL2rQ43wgB7cTJNLotLciRF8uVafPOxkn8bz5gdZmU53
+uVSaBeYq/k48pGcyHd5B9uxvDpslS5AE9dbEa6bg+8IlicIJadUmIFU90TpraSp
coIWKj9auFmnCx1vem6AzkaeY6XA5N9gP2qNO0s5kSzL37wRv17Bfkq23xK+5Nyy
b1YDQswSJrX21iVi5BvSrKDscm8ltLiWWsUmd78LDiadLFc2L2OLgbkYsy0/xJLB
frOglfOm+tXtOyywcHQaUN1lFf9HvvnJRancxmsb0sa5S5PgyBT3yvZvWGnQWvC6
XTKUdq1r6iYMM6pfNP6Ynx1EdKFJaHkEP/Cz2dRAwBaglqOGz50Pjbj0CGTjfxLc
2wNEM5oj
=UU98
-----END PGP SIGNATURE-----

--=_MailMate_BC814CCE-22FE-4FED-BCC5-E9F36F03855E_=--

