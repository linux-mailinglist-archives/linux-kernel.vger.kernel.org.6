Return-Path: <linux-kernel+bounces-257969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20E93818E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD03281DDF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A687512F365;
	Sat, 20 Jul 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QRXiq741"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1374127E18
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721483243; cv=fail; b=FNIKE5PTf6D8cxaFk5G3y6Uy9uUpCJd24+dvTG2achqrHIxo0CzxKFB1uB8Jgu2iZeae5l/muwGPSP8INRI2rnuJdV/9gEXGNAV91Bl3Fw3QG6EkTrQQZV6xJ4GEWhBPhh31LLmM+ycXjzLz50Ci/2Sc7gWny9dT9aqOsOHhW+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721483243; c=relaxed/simple;
	bh=PNd2LAxQHk4yqQdPdMZahprdKfuflJ4jDpJ7vD2WMdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keA319f2ZJEgM/DBFw6G65bU+JdTmpmPsT1y4bTT9o3vw1+c2NVuKeENZNL0mQhN3oMqSA/1MmQDrnOWic1inP1EGNrCUfdSzPODCFKytXuXbjXsW7eDloP+sVBnqU2TAdqTn76A8M/5jb/UA+LtEltWM9ufm58Blwig6Lkoe28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QRXiq741; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDojQMLVOp84IwAEG+sJVB4lXE1HIaUgBlYMRKrfWbMb/CIh3kGuvIbnlzG3je8jG1sZ83SmSv2x9IG+wKJZ4Mf1QXv6fqbHAKN4Mzs5ag38c84Td6p/KWN31+XUk8RzJ/j38I/ZoqYsMr0xHAIL3kVkZSJTOj9KlDkJ6sGyf3d/Fg5EHPnUS7EDH+CYVrE48eTj2r0ZP7NPMC+obotbT4cnax5sNVabdGtxBDaOOJIfvFESutn+Hm+qDoyrYeVhPLQfk7m1L9oyrE5LMzy3+jv/+5YoLPitZi2iOllovECa227zJ+26cqj7EJChj8ReuNa15eNcTIxW0+FdfWkz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJSRuxUpJ0c7q/kOL+nqTajaEraLI4zPSYkug+tdfFI=;
 b=IbRDOiK8MG6XJn0lGUuoCjBDh5fm2ddyxxzUL1/nxdiPuESFEfPlNu6Fkx9CMPZsIqoOsipS/HpA/2lJWqVHTBj+XpnBPiFiPs0hmHXOqI2WEqWxCmKWiTpAsbpCCYb2/sDakIRK12Q76u1Hb2EnTF2rK/dTcRi17aR4PDMu+9gTNOl+u9xfLAtKYH7ETxTCWlFdB6Q9JWZpfeHlFS/buWOO9ldmmz4SOgKVnT0QfHYVue9F++DgYdJ6KwBzsDUjdSP4ZX/UfQBNiQwwe6hrsp1bYkH7deTTTHW75KgSjqvxuLE+DDUU4bUazC2YaWBIuBIJulz/I4TForRMrp/c9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJSRuxUpJ0c7q/kOL+nqTajaEraLI4zPSYkug+tdfFI=;
 b=QRXiq741CATncaOezuXeiytO9cQtY51bvFn+Pp0m35bnk945SfByWu7apoJtEq2p+AVFbyjTXrbNI/Z86GArU/wyW3Jbt0aD+hDR/hG1MjxSheCxX0duC2epYc2nmbvgeLp+57kt98uROhb4hjAKpSa7ScTBreG/Hjd8lS+2XR0hrndZ1hj3rv2I4LGcVEnzj+wAFq0C90FlOwJU25O5wjT/opx4leGTjNSWoo+zv+mnt7QWkJ/78TFMhbpnKVfsWPB+j4AvxWTNMTowRPGNVM/5OrktmpmKwZYxY0tDoYMKzxvDpJKOlrMNS9VbyEe/o0tl6CeiCY0ftQXc0y1kMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Sat, 20 Jul 2024 13:47:18 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Sat, 20 Jul 2024
 13:47:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memory tiering: introduce folio_has_cpupid() check
Date: Sat, 20 Jul 2024 09:47:15 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <C1584B11-84DA-4BF8-9FA2-75867B709F7A@nvidia.com>
In-Reply-To: <da7eff7c-ba42-4152-9186-14021befe5f1@huawei.com>
References: <20240719144306.258018-1-ziy@nvidia.com>
 <20240719144306.258018-2-ziy@nvidia.com>
 <da7eff7c-ba42-4152-9186-14021befe5f1@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B22E1B63-E394-4D7D-931E-F60CE5EE4993_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR1501CA0029.namprd15.prod.outlook.com
 (2603:10b6:207:17::42) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 397a8d63-800d-4c92-bd8f-08dca8c2786c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zTGMMonBLd7BsOgxmxk9otUOxyWRJNHRlQqZ/mJG0eA9al6aAV1jQDi/ahg7?=
 =?us-ascii?Q?OGFx0kIKYlCSrL2ZBfa9+zN8u6qW5Ipw8a6d/uMUlcg7lIlLVT+mtwDqzLEB?=
 =?us-ascii?Q?gxjUpDKQ3RiQKXfNRO3JdTANYq3Xwo5XVSWtG0v5rnp6IL3JYVg92koNOhai?=
 =?us-ascii?Q?rhO8afuo6eFDXVOmyQRhlnaTWq4YPNWrfvPj/05EzqLEmRODQQI6cnnJhd9T?=
 =?us-ascii?Q?kqYOK7mg0+9nIxqXzxmtz0qi8kZQwvVj6GsgGFgZwMsAuvqEFbaz4Ved2kyU?=
 =?us-ascii?Q?+RQCtkPs2kNgCbDTFnsxOQtqwzwJf/KnRME7Y6dZg5slk7I/qjnHn7YZ4KYS?=
 =?us-ascii?Q?Peko1GB1SZC05kftzIeR2Kpr5N8KlSRIRPsxWwUadRSj0LEbbSLWtvBNNWYl?=
 =?us-ascii?Q?ZmQwGD5flteN9i1HCOiKG8F/WclrdGUu1Oal8HwTN3OJcdKQ1Ojypsw3TfNw?=
 =?us-ascii?Q?8Hxch45GSSY78Zuau7bZO2z2LAX2KcymFHTw7omrGA9zkSWiJb0ElyRM6drj?=
 =?us-ascii?Q?LIS0JVtvGwZnsvriMHG3+OfAGozSxTU9MJCgFfVXPL3s+GUKQ/ufX5Y0Feuq?=
 =?us-ascii?Q?0bE/x1NbUV1ZwP/KRBVzyctRxAheuCyAiePcb5TDDVI3fFwdeD0tW666qb8C?=
 =?us-ascii?Q?Z1ilMgjvt52pJx9GKq4CDuJhONwQxTcTUfFZ7c38QvXLIh/4p9nIMFXEevlm?=
 =?us-ascii?Q?8xCMP7ChYad9tUTELMltEDW7v7vz3wWWKLVcSOU5DqbAhPugAKzMLqOROkma?=
 =?us-ascii?Q?QdnU4UrJpDyeApf4LgMo9zBR8T38SL5tcSqRGqAzs3POutcLsF48YVhij3X1?=
 =?us-ascii?Q?s0Yz26SwhilgUfIvUjtbO7j6AvQkkqxMzXiQGuhWH95w63mw4qiC58f9whO8?=
 =?us-ascii?Q?KwVPw83g0eutAQIf6PNphmNkKEBQ+ADL5FnDFN0vv7OsaYt1BZU88Uov0gad?=
 =?us-ascii?Q?KfkGXgNC6iWG8WPVDNWsmAFcjEUIrU6SB2wHYK+M0mNxp2jfvKhS9+4gGzvn?=
 =?us-ascii?Q?0fyBKBNNM7V5+ZaT2b8KRniL/nfZ0Oe4Iij/m6aguR9aYDsSDKcux+69deY0?=
 =?us-ascii?Q?s7T3ryaG6ITaIc7/9qK5McW1eLMvlQyXPpBZH8ABGpU23M3V3AD3uIuIUU/V?=
 =?us-ascii?Q?OT8p9xIsgqcPTyv9kjwy+qPR6bKNEntAKCRKCPNHcZO/af1ODMgn3jchiQv2?=
 =?us-ascii?Q?+EGNshsWcsbNG9Ti1Q8LOUS7yiZgn7yVa+08I/1ugtfqodlqucrKMlivGScS?=
 =?us-ascii?Q?1hjJhvNdgETSNtO4MZFxQaMvVI7Fg72lqSvsPT5fKKIvc25G44n3oTnTL9Ts?=
 =?us-ascii?Q?fLo0HEO4CodXElYgAZAQcualhMduOIyBq5fAagzZOFLhzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nEhVOUFNP74//6SCcoodEYiiJ4WF3mE9z84O/mdf55SKuV7cTVYyH0wn4GQ?=
 =?us-ascii?Q?0aeaw6nLhROXp3Y2bx3RZ+gEPAu8GVRQq0QTWzCSP1Elx4hpadAE32DaKBRH?=
 =?us-ascii?Q?HbcLi9mKvVxBjie1aMfOQ4Roe/41JAQkVZqPRiVvms1cRDxNn7zXmMaJd1HQ?=
 =?us-ascii?Q?sSa3ENSC+Jfhh31cfSWud3F3B1qVxPzLiDdxBpSuRSPspgx95hihk4Cie3oz?=
 =?us-ascii?Q?nfRbpMeABdiY4EWDvjvEm3xnpojsPlheq8rp1Dl6iqjCrwzOP6pb4ROQn2Tp?=
 =?us-ascii?Q?sguDmvMwkdkp629pQuJGdzz8HnTiX5/Nb9DP+4spgG1tT0Y3c0qAW5gULfVT?=
 =?us-ascii?Q?73MC2rMtpubfGtgaNB4wrX5dSPXGdu6cAxZptGIxmX4/6g56lTizfaxh7Rrb?=
 =?us-ascii?Q?a/xymnTLvhhQrR1uXcQpQGwh+3ePEpwGZerop30FSUqpZ7dk9BwYZ2mRRU3N?=
 =?us-ascii?Q?RAu+6vLYK0+FoPHtOEuXm1IzbmM59xFNQRbDUOKryoa10Vzl9MSU57Jz+MMu?=
 =?us-ascii?Q?eF1uTe46EP9qGARKwKj7DG6RC7/POOMOeNlv2aeobO2mwg3fMFCUSJ9UO21u?=
 =?us-ascii?Q?VjfZnEiUQTl+3yhKTE9NgDGRcr5ov4Q7mb/lxdteuP5z/wMUTkmxiOVOed0l?=
 =?us-ascii?Q?lAL6nrkyzzt5zbJROvhliPFn/OFdmMwOmtBjqd1dctcNpNcYiQV5CeuL4RFU?=
 =?us-ascii?Q?XSyKND1JeGtK7MepDmYEpd/9tYFhIHxdWaowpmOEE0MEdZQJXo7q6r3/ypkD?=
 =?us-ascii?Q?0lwOvkiusEeGqefWn/6hgyUEPZ+O+lts34XpOi31aH/3jjVoXqmZXFhI5BD+?=
 =?us-ascii?Q?jt7pkbzusqEBu2G/9RtX01lQpoRagJ8V9OT/6+D8zEge55fX1/W0GLg7xJrk?=
 =?us-ascii?Q?N9Ve0l5Gd8VasUWBlE/sSiASS6HzWwrgjTcJNMvLeQNf1dL/D1tKQlMUiILy?=
 =?us-ascii?Q?sSXlWIa4e7M6t2JNAjlmHVMBbqhkiNr6IASBXlEcbgrMs6mqD5Q7yMXr6Z0R?=
 =?us-ascii?Q?AQuglPVDIfJcbyUPwukTOzfnOpNz18mIpdKJfHPgQP2/p9ts3V2p8NUSyIXc?=
 =?us-ascii?Q?lYeDLXxfZ9Sk8BrVmUt1MWu4sx9TJwBVLgBNDQ2CnHTd6StRHP5pOxK2tOzl?=
 =?us-ascii?Q?1/bkAek1j1AM0DCQWSv8EsrUFbErBYZxUKHDMrutg3Z+rxwEiYAmVu/Li6iY?=
 =?us-ascii?Q?MAt9b6ft0Z0UE8s94p2pwLO7ElExx1NstACMuQbgp1zIMhyw6/mJ7RLZHGEj?=
 =?us-ascii?Q?osJj1oLk1V+aRBvzPJy9hhVnygNp72ZZZUFEakUMC2tDdoXly+ddq2J6NgvM?=
 =?us-ascii?Q?EOUm3aUHbmw9QvHA++LWlRBleoGw37vLq8bZJr9nkYvUDAGBIYVpFhzWB17c?=
 =?us-ascii?Q?wYi0534lKotbCOP+D0L4HKoEj+VIrLRniY/JmGKp6SVZuMTm28pUwQxSp8oO?=
 =?us-ascii?Q?EsT1zF4rs+6EIlc7kGWbtswC4qSZ6Pw+heL2QI7LgDmTpYUjF09uTKj+4NJO?=
 =?us-ascii?Q?u/hySz88bV7UAD5g+neAEw+0usMXyU8BZBk7NWXQcR35ev571b4FczmGG2XY?=
 =?us-ascii?Q?nLdDWN0NaROqmxzcxXA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397a8d63-800d-4c92-bd8f-08dca8c2786c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 13:47:17.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn3GK1FoR+o201SHoZRpUGzM0I9/DsD0tzqtNuT0BWICETqJvY/85J73sk7OVt2C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280

--=_MailMate_B22E1B63-E394-4D7D-931E-F60CE5EE4993_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 Jul 2024, at 3:50, Kefeng Wang wrote:

> On 2024/7/19 22:43, Zi Yan wrote:
>> Instead of open coded check for if memory tiering mode is on and a fol=
io
>> is in the top tier memory, use a function to encapsulate the check.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> ---
>>   include/linux/memory-tiers.h |  8 ++++++++
>>   kernel/sched/fair.c          |  3 +--
>>   mm/huge_memory.c             |  6 ++----
>>   mm/memory-tiers.c            | 17 +++++++++++++++++
>>   mm/memory.c                  |  3 +--
>>   mm/mprotect.c                |  3 +--
>>   6 files changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers=
=2Eh
>> index 0dc0cf2863e2..10c127d461c4 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -73,6 +73,10 @@ static inline bool node_is_toptier(int node)
>>   }
>>   #endif
>>  +
>> +bool folio_has_cpupid(struct folio *folio);
>> +
>> +
>>   #else
>>    #define numa_demotion_enabled	false
>> @@ -151,5 +155,9 @@ static inline struct memory_dev_type *mt_find_allo=
c_memory_type(int adist,
>>   static inline void mt_put_memory_types(struct list_head *memory_type=
s)
>>   {
>>   }
>> +static inline bool folio_has_cpupid(struct folio *folio)
>> +{
>> +	return true;
>> +}
>
> Maybe better to move into mm.h since most folio_foo_cpupid()s are there=
?
Sounds good to me. Will do that in the next version.

--
Best Regards,
Yan, Zi

--=_MailMate_B22E1B63-E394-4D7D-931E-F60CE5EE4993_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmabv+QPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUjfEP/0Al71BThjiboicL9jQAhwZF40c0nILZNRHF
LwpHMGlELt1L8nK5c/SG6hAv6yXm21T1x6WOpdlOo/F27WgfNQNPykdHR3XhuhiH
DGRWEYd5WBPXY9nG1K4xxfIpusi4dUTvTP6OtXZrQFVtzE7oTn/o4BqnYVQ5p6r6
n4IUXkNFRBpULJ4c8Pw1K4zWIGXqEZL8Awau8tGPT74dzmhEpD7vaof1o3kd7Wat
CIRJ+sJPdRHVh5JP5L3PimvKsF6XnwQpxj9zodQBYyqGixNIl7SyFTRn4ykKKcZv
+4Wv6PGwcQw/WcVGrAH6fGfHb25LffsP5HnjGbvhoUJrS/EYq0/evM0v+52TU24M
FLp0CpINCDB9KCoZfZrPoAPADbGUOxKyU1VnadAlMXTFnVveYaYhzYBX5DWgvYKn
a94V3buIAzoeZ/jH5VoWkLllbzDV+8kT+Yl6kb3gvDjYvp4LPFx8y9z858XObg7C
7vfcI8turC9FnTeMwnzPxH1q7p+/K87KA3BU+kygnZ9ImXHtsKuHGqSTbqm0N5Bx
wm5xfCcEQLsNLsD7IniAtvqZeS9AtNNGdRkEWj2sq95Lp2Me1t1G3sG7UScvHqgO
H8jGPLWn5l7UaR4OKdY1gfHTs2ONrceye4eNI9Il/jQPU8b38DXZAP8XFjZriTc4
jLtIC5co
=G33I
-----END PGP SIGNATURE-----

--=_MailMate_B22E1B63-E394-4D7D-931E-F60CE5EE4993_=--

