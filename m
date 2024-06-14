Return-Path: <linux-kernel+bounces-215021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B01908D59
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38BD1C211B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC05BA41;
	Fri, 14 Jun 2024 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WGR6UkhT"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99F944D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375216; cv=fail; b=IM7ysRqbBdaRtogy+DAOV/k1jpB0gGEi+IXBo4bwkZP1sO/oPM6VvPb3wHxFuIbHkUuDBgZLFfK9o7bdADiYIo8ymbVHrwdSz31k6Dbc0XJjs+eIO/9CYxxhHR16q3mhWOXiNPPtNFOe8p3ZDPed80fNsjl9dVj6Jiq/SpqIuts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375216; c=relaxed/simple;
	bh=/uLHIbXn3XuNKH2+LyZlyHlEh/We0CTGiOvstM87eAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jyKlMmvZQHNygWNy2R/K+ZYrHAhEAttbdr2wxBFHg4GMYbHz92lN6J6Ap6W5KFijwOzSse/az3KEBgSYUvG0RPNy3tJ3kbubBfakn2BJVt8gC7uAi2pAcssINp+SokEViW4zK+93Kft5L0r16LsvUmDxxzyYUI8mVdggDOMq4IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WGR6UkhT; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQMEKwFXttGoiIsD1ZxCQLxSuZnIutmLy+b4InPYXyYuEge9csRW8BpzIK7mrTXpvX4YkDuWNyD3Kw8DDpBlfVcL3T0dQlDKeQ3/6t2Ak0nEuClJ4sMpjk1YQLs7r1KNsFmnOmntRBjM1znMTsuWUrZEeItHslXEt5vstlODoFwCoinKx53b1H712YSElFsfpXpN4h7G1Z64G2e/D/nJrayLIL/EqxnxlCvyD7HDg3DwoWm55wwwUpJfOHVlOHXhhBvZz2O39bOBStNWpIpwpQJLo+JypV+yLnKqNVrcYODvh1OU7xvI3be/9lRud3zZoWvf02FrCQKHF0JcknTs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRqoibAGCklo9AfCSd+usjngOwVE57rJcqXqb9fQmYs=;
 b=n1XgykIErJ7rIjQw5sB6qJ7xsdDWNNQ7/5ckaQ46UKFOwEE7i0daxb+RYsXnWD/aEBiysfiI/p9pcr3S0KroOtD2cbNtwhBbY2b7kGZgcKbn5ig4hj6xlcR960AEcnUmy5ikJrpoUbgSLlGxuNM3NwaFwj+G3KrRILkozTTcNAHxswf+bTvieJBv9iUm7YJ7jvYdnTJQZ64nPJIpx/BGviLG+4lQNAYG8Vbh5oIa4JGxAhXwRPOqwC9gk0XxYyZdJttSQfCGoODeLEmPjpBQhooXmXGJ022KNwP28GLG5zOPnQo+BzWAg4wy1vTYG8r/o1NoC/qjLsIP8HBhtQwxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRqoibAGCklo9AfCSd+usjngOwVE57rJcqXqb9fQmYs=;
 b=WGR6UkhTcsG6cvFGuM5F97lNaImJOStAoSUVpvUtL0PScFPUB7yLsN/fT/rh/MbtQuIW+sufjjXrHUTS/+VyGPXcIggxGzaPsMm1sJlx9k30ovJcY/jKC5Vw8X9MEcuIrZpQLNBxrETMi7Liat+wgKfruNKS6WrcccJ6F6iCZXd3dlGkOSsBDduYXRrAA+Mba414U03tmWzZEyfmRzLvv07tKXyuien63qQowBYVQZCLdLBzReA+ZC09hLzSBH5yiX6kJox5zN9q8BXSOcCeu0USdT0YFZ6wLk9B4bYegC6GBxh2awyJ04VUqiYSrqDHCXlqW8GXPQmFKctrgeenzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 14:26:50 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c%5]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 14:26:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 baolin.wang@linux.alibaba.com, maskray@google.com, ryan.roberts@arm.com,
 david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
Date: Fri, 14 Jun 2024 10:26:48 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <222F10CF-99B0-41F5-AB59-5E65F38B4AEF@nvidia.com>
In-Reply-To: <20240614015138.31461-3-ioworker0@gmail.com>
References: <20240614015138.31461-1-ioworker0@gmail.com>
 <20240614015138.31461-3-ioworker0@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_804F2C4A-14A9-4226-9676-1C8812973241_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 7962248e-2b9e-4b90-3dc8-08dc8c7e07d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A6bYxlCJbkh1zZdZjRRPHG7g9Omz9nckgb2DK93hfI7t4im2/T7uDhv8B5jv?=
 =?us-ascii?Q?+EzGPsuYq5/iCuYQQr/CLiUxcvvXqjE7LDM1GFVb7n+fk0Hhj25xPNcB+vHl?=
 =?us-ascii?Q?DDr4zH0DVAXtrsyhsZ/9BU7mmUYGsm07eacdtVpA8MsrjVUA5IUXmMrYYR8U?=
 =?us-ascii?Q?l1DY94TCki9M2JNOwyag13M5x87tQQOQ4ucRxxBsVbrfw7PNmWxM5XoKQSal?=
 =?us-ascii?Q?glGHK0s5U10dSg++Yk7lStPosaity80J8LGFR8zm86AcH5eZXMmGTXBWN9nP?=
 =?us-ascii?Q?Z5pHt7TB6D7uIRwj46II4rKeIrlz2uWooaEUYhcxDWSVyEX7keA6Y3dTPq1K?=
 =?us-ascii?Q?8RpEDT19qa1CUhmd5g8YaesQDtGioAwTFtPMoa7LYbaKBnaQGe8YDD3Nu+3C?=
 =?us-ascii?Q?FBisiQFUgRY7xoWyIkj646xa4hfyB1ihg211YRW8P+KbUmquC6U1Jr/XcXPJ?=
 =?us-ascii?Q?3Ebo2gisf/tH5tyeoGSMgb/XI/7/1WMdSeShe3YZ3VkptKmaBhiEB/Spn7ZJ?=
 =?us-ascii?Q?nnz1MV+hmQjt1dewx3qxzTQysC8gN+9+h8nOtdtCUAvy+UF4vAW3lbpgXR3a?=
 =?us-ascii?Q?saiwCDQBo0+XSF6FWnhQbGubdZK+MnAeanOonPJ3/Pq+ffbtmKR1FLE/qX+d?=
 =?us-ascii?Q?Wn0yiEnJ9R1CRISIlL1DkfYJCmgwr2rPoygv/qhyVBNq7YiiDCGyGEG9KDji?=
 =?us-ascii?Q?YsOoY6iHE7ewx+Vq3aZjp9476Ga/zBEpZCkPheFIcOJ2HX3hgV9Ll9RWmLkA?=
 =?us-ascii?Q?YbkcUmGCUzdMhZHcYrWvRM9sHBCEnnfAVTQuzpX+dBv/M1wtQbYC5gT4oCY/?=
 =?us-ascii?Q?ii+dkSg5p49qw7PrIOEf/bkt0+MlAvgKvpNuByz0HsdMmzwd7ZntxFho//S4?=
 =?us-ascii?Q?R4xVpTsaRQyineHFpNGwdQxesq1WPP+fTngFpRK4tsIzGKfOgCH2ZTRofUyS?=
 =?us-ascii?Q?DmMcCxLPYmjqvkMct8Lt1wdzkD6tbmx/bbhxESjFfiLCYnsk9wJJFe9vUMDh?=
 =?us-ascii?Q?3n+tUzSlBAbRnmVivcq8tbIxI3xh0hwiTXQE4Rugkemo1c2nz/+KMz7HYz7u?=
 =?us-ascii?Q?NhCi60orKzIBrETaRa7TD5+ZWxJ4s9jnfRhHSrOdUkQVVz9FpP8l38uji9qA?=
 =?us-ascii?Q?0hV9yR5aCeRr+TUjGGhIVNo0jEIPrxOaoaL1MJVQJ7YoE7l9N3qtkzYg22oL?=
 =?us-ascii?Q?dbS6XvGC1y4rG3BnMc3MnapOJHvacwiFEecd95SAh+9oqMEJQt1rYfoZIOHt?=
 =?us-ascii?Q?Qa1Wp1WkZD6P4yMkOUibiVy2R/rGtyrfIGrk9edpINXEW4j9ToUFmdSgxtw9?=
 =?us-ascii?Q?pxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6jeNnbahx8Wf7xQ4MYfqFotyaC8ih/W1js1V4T4zMUAHCmN8JJJM07xSRKp?=
 =?us-ascii?Q?dfrr0/B2l+Veig4Ba9HwGci71wODvyYgk9s0kqJcS9vKG5shJpEK2aexiPuG?=
 =?us-ascii?Q?yAad0oAYaMPGiFIYxYA2nfiFFmHEwD/4pI8JQNJA3OQT2F3JRDFwWr8S4f/6?=
 =?us-ascii?Q?cQZ/9X+WHAL6x85aRyQlfhdGEQhRcvLzuhQWndCYVRfBX3iD3VL3Qn3sxy7s?=
 =?us-ascii?Q?O2B9UznLxuWj9mHXoIMZ0YT+pqqzsFOTW6N42hBIGE6x8qK2sQ+ksDdCy1Wl?=
 =?us-ascii?Q?h/3lbC0G+xWDJpdFKP7TcUrMeiKEOOs58lozql+59SU7JWzK04RWkZW6bOQH?=
 =?us-ascii?Q?OuMBiufWwLvh4xDdEzUDyqYdl3PSqBaCw2gyXf6dzWmZ+S4IvgrVhsWrOswm?=
 =?us-ascii?Q?nB/2qx2YS79d2QgIZa/NMlNB8rg9ilCe86n/Av+RWaFAc2DXmPPp/Sv515Jz?=
 =?us-ascii?Q?80/oQx4RdVdzS7/FH9WZ4d0JRu5aAEuCBHznAw7YZF23Mo4M6CwCtVemyw3k?=
 =?us-ascii?Q?RCFMBsyMZOYuz3fwx7IbDNqlDKuxSgedLoldiGJRp//8694izMXjYlm7Zwpi?=
 =?us-ascii?Q?xB7MSS8DzX6UBalpdZ30o/34Y2pwvfpEI7EMC6HwYwiG5a1u29cu9mRVwHn3?=
 =?us-ascii?Q?KfITF0iN5eIhgqZHRs3R7dNsOixXLZfttLLo9H/A4cgd8xQfCqmfmoKRMm/x?=
 =?us-ascii?Q?kXUajdNN27O/iDllq4ruZ2v/0HKUv5KngNgXMhwAK/S8lswNcEfeVU9KMglr?=
 =?us-ascii?Q?2fzYleE2w55Z6kSLd1xoNE+TvMxsM/POC+W+QABN2PJyQups3xYQY1o9MsEr?=
 =?us-ascii?Q?vS+HipANNIa/FFrY71BTpWxTTdIJ1m+JtW8L5kGRvpN6+bNy2GhdkYl7XaOM?=
 =?us-ascii?Q?wHN07JE64q0RHh5oAFh8F+gcJhIFelDRAsj/Zh0EKrTcETbwZsZh4qJO1L0z?=
 =?us-ascii?Q?MaUSwSMvXO1xfj11nibRG2sjoqFo9dZDi7od/H2XUoLEu1vNHEBl6r7Jvx85?=
 =?us-ascii?Q?VfCN8Z22HU/dhe3mxIQVOeJq9zcXH4FSLOjbzdMq2AUwebbb2D058vKiU0Zs?=
 =?us-ascii?Q?Ldi4ZUxRbK1uAlkWOkKVHGH8umtdASAaTWlaW/uPRLPvThXaOX+gBzRymEZT?=
 =?us-ascii?Q?0P1TOKpJfOgWhenzJGFYHluDYmz9tYKWn8wEzW4MGlNgX9OvkE65uPd40nc+?=
 =?us-ascii?Q?gsNf6J0PE63Lbz6uCvgZ9pykiUCBe72rYYCno3A61x29AWtJU775GPbGxwRq?=
 =?us-ascii?Q?vR0mqOglVaOoIwh1cffZs5iTRs52m5sJUvisNCxjGHZBCdpoDYugNmWQRcNp?=
 =?us-ascii?Q?ppO+QZ6KxNWfx8v/3DM+9Fr1SI2XJ0AtpQeND0YPRlr9TS0flRjAMrEA4G0h?=
 =?us-ascii?Q?W6KSgfZ7y/wKF38Ot8NArdTE1XIgrgOM0Do1r7T/tWd2YThdKx8JHNpsJ5lC?=
 =?us-ascii?Q?70McO60ovPTQLGrvB5npnwl6MB30OGvhcufRTJziyLNVwBgxqWHGvY32cCiV?=
 =?us-ascii?Q?pX4L0ubWXYaJirAgU5iaYva+qQENB8ifpHrW5ksD5WykUZSO5A0L8unrNugj?=
 =?us-ascii?Q?s9Et+B77XwIgWYGI/8A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7962248e-2b9e-4b90-3dc8-08dc8c7e07d7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 14:26:50.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y50mV1oMIf3Vb4SvQzewgR0WZR3VN/uYCfndpBw5xCSzFvIcOVK5ORR9A1TcSJs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419

--=_MailMate_804F2C4A-14A9-4226-9676-1C8812973241_=
Content-Type: text/plain

On 13 Jun 2024, at 21:51, Lance Yang wrote:

> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> folios, start the pagewalk first, then call split_huge_pmd_address() to
> split the folio.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/huge_mm.h |  6 ++++++
>  include/linux/rmap.h    | 24 +++++++++++++++++++++++
>  mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------
>  mm/rmap.c               | 21 +++++++++++++++------
>  4 files changed, 67 insertions(+), 26 deletions(-)

Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_804F2C4A-14A9-4226-9676-1C8812973241_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZsUygPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUNhgP/256qATpO3Ri5XBH/RdCGCZijAXj09peBSMf
Y4gzdLJ+AV/v0T2u0pivFif+a14vTkGktvABHuLYraIAQY59gWrgvTUVQbgXpm6j
Zr6bkHz23IwmR84C2PYgIpJPgZAAjJEMqTHT4inRE8BfLOKgvtTUENE3Yee+bPEl
kEIWVO3+0Cxm+TkQKfmgO2SJgl6vKx92dcB1xToAZsHsI6LPtLoGpxLoaQ3Gky1Z
MemJYyc34PoJV6fgUqD2RmZYELwrkSAy+vVlz2mDVIDJlILD738VeI6ALVwMjF0H
T665BNi5JPCM3EZkSNr30UL7fYJwcazBrqqqevu7/kXIwKpuNyEsH4wYjCNZnVUE
9KLMhAbo0OOrV3oUWdkKn2Fzd9lJUYXrthGkMkBdYb+w9+FxywE2t5LgPQwdAp4L
0gI42IodAFfP+MihVw/NLmvNf/kmZyC9lhvy/6a/THRyna+7D5OZEV75DCjvew2B
uLbg6ocSdGf8Jxw/hb+Ko36hJcwjI3vYdWyY700CBPAzh/WFLB+tjZ159Ld9BKvl
FcEJ9/l5TNZ57C8qNEPzW8ur/Xg58OciZLU39XX3R+dgclUsXA4IXNvPHNUEa8Nw
g/RtmgrpSrq/cGKfpNZz+xewM9JFXuITUi21+GBKgfra0oDyipEuDL6EZfEvZpgG
4HEp5Enb
=NcT4
-----END PGP SIGNATURE-----

--=_MailMate_804F2C4A-14A9-4226-9676-1C8812973241_=--

