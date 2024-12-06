Return-Path: <linux-kernel+bounces-435375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F839E76B6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157A42833F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4051F63F0;
	Fri,  6 Dec 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ef00w610"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7601FFC58
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504912; cv=fail; b=Uv9uGvtm2sUOd+mSVx86AzvcxQ1tYzBUDsr2qZL1mPb1z+4FDbqUf9Q5tmycAj5zM+1ejbSdC4ORDm78gtahB4/FMUpnY+OOLHTLujFzZ9xecKJaIXSKd+rFfSVBbl1NB8i3dbQG3wcHZ9fC20h7DwEQHYIg/FuzUMvtx0s9PTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504912; c=relaxed/simple;
	bh=dzqv1zbEGTToad85Zam20Nqs8nVBCpjtlUKJnR0g34U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7tGhDxVNcg014jh/hayIcCkLYfsVU1h0hSNifgIBRK5TQ/vTsmW6qHo30eoJeESS5q+QyUdRcfpxPgSN2665SvCzTD5rCjrC5KtwGC2ZCbby2R79Vq4mrMRKAGiNWt9Hp3yFGUZ9O2JhOrYAPQD+RT7+di9QtPTNRHSACnqrs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ef00w610; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8dgXghDFe7QIZ+R1WWpMewV93Uiw6aXslttKJjmypypajEmXXX8scCWG8v7fxSJEccjJU4PoO5Ep644dypgoqAQP3w/0sorRZTTLPnh5SMfXItM5AZ39xxfjfzfExRJtInrtOS0kTiIP7EHB20IQ8kL6b/j9b7q1tqA9zsM8f8bubfnK+6c7whc0BAsvKx7UKgExIiLy0/oCKNqzBwUBtHuv+kS+0c0DJrL3AJwoZaVQNBRrnv75ZNjKdoGlIzcy+BqMDdDr5RCoGDZZEhpzbRGh/KOuQ5C6Zqd+lVi9SEUHCZ2JdcTr1IkjKId6lIYFB6DnIziWvYe74o87RTOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzqv1zbEGTToad85Zam20Nqs8nVBCpjtlUKJnR0g34U=;
 b=fbuznfZezBABvHadpybproSqQNnYC6wIi9QLpWSSXODP+DGPyHekhqnKnnxLjWh/cKR3zDDWy9HLX6t2CvidGiShICHRG1jpJLiefxsHNUkQv0wjGLyeQblLIp/BeBN0pqb87FT29OdhhVaoZRbotGuXpxaeZIXG0vrcHVAeiIGK4ijQuMMz7EyxkJXSb15538CBBmjBZRClNAUIIhnzkrZuuzaBmxXHdDhiMJZLhPPRMwsLExuayAD3FdulHrOO0N0UwL1yInh90Yom60YuYMxec4b04AxQ6gRsWJ6cmXwfPcsizTfDu0Y+NRnfsIuSRSol+TOmEtju4IVKRU5nyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzqv1zbEGTToad85Zam20Nqs8nVBCpjtlUKJnR0g34U=;
 b=ef00w6105NqvNBAbSSZGAcjVdPtRrdbUnaVkE7VhgE+ju/oafWpwO+yhS0crYCoJjNkVhUQh1dw6WBr7rshbfOpfLdJiy36+XX9jAKPfR/egggASk3U+WuTUtYRNK4NyDHSgHnd9Lsbs9Z9JSskyoZHdrJ4u23pv8jo0ruuNcxIy5pw45Tru9fVrKRBkOsU8HIbVdU+etOe+Ir6iG0V9hOtktTPXg1ILHvhsAyXQiIMq4moMbXDMxIrB7tA8zvjugWMGp+GYKmAJBAkmGBqlShOjqJlYSGcLcQN3FPgWPzcY2AxcXvYbdG2XCLjsnQ3Cxp9YGIup6NMALkIf8NJAGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Fri, 6 Dec 2024 17:08:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 17:08:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Vlastimil Babka <vbabka@suse.cz>,
 David Hildenbrand <david@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Alexander Potapenko <glider@google.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Vineet Gupta <vgupta@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] mm: use clear_user_(high)page() for arch with special
 user folio handling
Date: Fri, 06 Dec 2024 12:08:21 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <78D4C1B5-3EE7-47F0-A7A2-F1ACFE71CED0@nvidia.com>
In-Reply-To: <Z1Mpfofz45bFawSq@casper.infradead.org>
References: <20241206141938.2750393-1-ziy@nvidia.com>
 <Z1Mpfofz45bFawSq@casper.infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0371.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 082fe65c-5ce5-4d7a-c0ac-08dd16189799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tLOgD9eKOWmPvVV0mDz7AUoCrzvv6TQmmPyY9fW4/xnHcoUHnGiPO8ays7I9?=
 =?us-ascii?Q?WZSN5QLamiYEXRSzVgAos65d+HSOsB8JW3GtpiEdOk/21/nv1xEH72yFvInd?=
 =?us-ascii?Q?fHCb9y/zAqHOGMhy+sPzcWGPtq+p428OHI0XslXBL6IZMvRzI/foLYVjEDlA?=
 =?us-ascii?Q?uA/KKLOnZPfYitwsuYXeBMOo+dOhuFeRpcbGN7NrFNi98VQOcOoiJRfYE+e2?=
 =?us-ascii?Q?OEELdhoCf1siiDpqaPAG+44w3xLwupOCR4NtWSam4Wl4IJbbAqk5u6uGdqBu?=
 =?us-ascii?Q?IsdADR+/+7Q6KwCiHwnx4g8PQyED+guAT1QuAZyomfmLaLVR8b2rty4DJzje?=
 =?us-ascii?Q?9GI9lxWmDj3hAign047eoWIpkaypXU/2s8W2q+OD3vb94L8x9UVumGBcOree?=
 =?us-ascii?Q?ewn3vs+QkAkHOp45uBBR0ksbfpZPOoJwl0Nxc3A9oSQsB5DJrlgJy0XPgBr6?=
 =?us-ascii?Q?rory0x1v/3TdNP30ZhYt2FY9Ft3byf4C/TeAzQzLgG9ron1zh7MRz7FFsqU7?=
 =?us-ascii?Q?+zR8dxXQB60xAzG1WamBrctQEozsuDNMpOg6JYFouNFCHE62QRT8V4ocCna9?=
 =?us-ascii?Q?mT5XCQP7ZhKHwt9dBsMFVnc32aRtXyed95YewgpPo805qijsT65PN/ztyAcg?=
 =?us-ascii?Q?K02AsFJy9/q11y795mr3bVbEBRkD+uTwMfO+nJXSXZUYTglZpffQNSNo/nCE?=
 =?us-ascii?Q?AYaFCaSOs7BsNmHiBhZfoF/+sETpXt+yH5ybR5LZ/FCzm0pR8CPo+w5zKldE?=
 =?us-ascii?Q?9L06L/ZmlHjtHjcG1XRHFzmqBqNNWBSP/wWYb8IUl0lh60UlT9/9FQ0neXAO?=
 =?us-ascii?Q?/2xbaa4L0qFevT8XxQB3Xk5iDqLQZcDSQmWipYY1Gxvcn0N1dGoAy4Nsr4W/?=
 =?us-ascii?Q?U2MR5EFzR3ea9FAGazQOR9Lw/3eAjzCeCZR1MHsIxIH5FQDrgk2qMaualTBr?=
 =?us-ascii?Q?l8i/hVgxx/f04c3WOiJIaXkG3gqD6xCbbD0X2NVH+mOD0QrE+ZC4He/V1VSx?=
 =?us-ascii?Q?NdC0oxBj3lUMLrHPeALNNc+ZRpBvostPSpcgMP77SzIHsEncTmOX16TgZnAO?=
 =?us-ascii?Q?boY4NOvSBYiO93qoxyW2SaBrmeAN5SCu1VVybYVtQGM5x8GR+bvzUoqo3wGo?=
 =?us-ascii?Q?K6+p7kXjmpSBgY567IZkYk3ia+GSi4XmRWTQopnr+vAXHaddJnpO2ewBBHd3?=
 =?us-ascii?Q?0RgIkX3MIc+5A5M8gZ2JpjCgSadOB31M2+xqVDUIs1r3ybCnZsaO5nDdsg9h?=
 =?us-ascii?Q?v/jKxA0U+UxviYw0fFDtr8Lk+QEviHFLPXyYiBQLhgbDTfG0mnF4mPzwtP7W?=
 =?us-ascii?Q?kpQcECY8d6LOf/G+dgcP7EWQVVssYylszISQHiyaalenEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZDPsvGyHjCACyK3qoTrPTOJo7rDJZSJEn7g64app7s39J8qj3gZ2p5dVWYU?=
 =?us-ascii?Q?1p3vajQoi/dQbkh3/L1z1Tj/pp+IcB3KefWvfV2pWK3tmtVUtBW+hxd00Qdx?=
 =?us-ascii?Q?bnZLLQGL+GTcTi9glBQHwis51IaXjRLFbiY1xe+5EzgvcyOAHVXzpfFF4AUB?=
 =?us-ascii?Q?UN7VaYP7H/umCvT4ZkyEinRuvoyTDuSULeytHmYx4qowWGGk4737XA7ShW57?=
 =?us-ascii?Q?yqbfVwSYj5z/8W2j4sq27WBCk9T5if7yonGQ0wT3moSFSXxhAn4HS2udKdbS?=
 =?us-ascii?Q?VItWt2sN1tNCrs5DhQTZqOQFvHeqgiz72StCvRXgwu7bFPlaJe514I+Q0/ud?=
 =?us-ascii?Q?uz4BfzJUtMIJpvqUDBO5lZlLl0i5nchbPp9c7ZqELe/kGKuO9+AhmoxfG4ao?=
 =?us-ascii?Q?s3BvwyO2BXe/C2yEDPWUbA8b2EkbowWACDPjiiM4C7Ha8O5FU0OLa+rncBkM?=
 =?us-ascii?Q?SeQHrVCrBm2CH9kiGR3YL+TWAXN4GuWDCme3CXBpPChminehchNKVjAWyS4R?=
 =?us-ascii?Q?JpC8sjiZa0VEeh9R2/biL4Km/QNGqzDmoXXoSc33KH+tFr7IrHdvMxZG0emy?=
 =?us-ascii?Q?diVe6Fxg2q0T+vavpjUgNmh2izbBa15mFbdr9vmkEWnmDKrEsqDwfazzthkC?=
 =?us-ascii?Q?bZDhHy71Jn2T/rnZ9FcKDXxe/G+/sK+vKf1YVdVeUHmLQ/svQu4A+IHYoftc?=
 =?us-ascii?Q?XdNVcNrsYCkrplbBEOfa766S9eJUPWb3okMPpK19kkkwkPCE/giOhS9x2qjq?=
 =?us-ascii?Q?sDZB95KHY6jE9hfsKKx+mwns0LXQvOPzvlITy7T+YIzxPVWFkVAh/TPLF4px?=
 =?us-ascii?Q?1cGNWE3z4hp2PiwAUQElSQ7cnABQHmeLHqtknGKdBPBB1oeUWXuFs3lVsX7H?=
 =?us-ascii?Q?kM5xqt5JJZ4yOLax9eBgD9CLAuq5Z/7eMRy6qphvzwz5J/JUcKrf9GV8ztpM?=
 =?us-ascii?Q?YDzkGdctu0kcxpbQQrOcs0yAlFFO4hGuOeuFJCdb18VgD+JTkRVTRs0t4m5H?=
 =?us-ascii?Q?FnrgLhGCZGFE00VPigVgGK3udMbfg1AIC6mOQ5yf600TvbmOrVRx6dYRKzsd?=
 =?us-ascii?Q?oJpyhX7fa/jhX5cjkg4K+NIa3cb5xLlL+I+p/XwKwd1OjKR0nGRsnEpI0PF8?=
 =?us-ascii?Q?Y98qfUJr4l4UcMvB+7wYNQouFfA+DOtFH11rYs7mlfQ8G38+d2m0mXZzeJsd?=
 =?us-ascii?Q?YpDTvLx0Xzi1vYAUvqtkeblGd3ofYNsWbkW4wx8rWEtbTeZ57Wdob0wnuwLT?=
 =?us-ascii?Q?sZs+wuTzJfYjewiOMV/L0LqkYEjh9shSxFxQd1uZL75qIrvDyDYA11nZ4V14?=
 =?us-ascii?Q?DMAkuK9tW5q4p61PQfa64cJXYZHCzZCz3RJFfcZN8fUzo78y76Me8nP2qO9b?=
 =?us-ascii?Q?cc1KjUsQVSbtEtMcumEvGX+yLFOTH/4balA9u6PMpvESOlUdCjW5ry39qBvq?=
 =?us-ascii?Q?N9wJS8HFM/HIN0kKaMirU0FkitamS7MJGk4eg9RPkijRBgEUon7oJAQvLROb?=
 =?us-ascii?Q?QgD5P7AaOr/XvMk3FI2iwuL9xAv3sny7GemTBMAOnRWKAER9KpjGB4A8nPQC?=
 =?us-ascii?Q?zIxfUWt2YDSbd5/7TYTC/eiqOlOvI6OaTjpP+K1R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082fe65c-5ce5-4d7a-c0ac-08dd16189799
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 17:08:23.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3nCMz3KNen/YCikIO2fQDiOTUW25gYXtr/kDRHP5t+bid6jNgw5xrBNnV4CDgU9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123

On 6 Dec 2024, at 11:42, Matthew Wilcox wrote:

> On Fri, Dec 06, 2024 at 09:19:38AM -0500, Zi Yan wrote:
>> For architectures setting ARCH_HAS_CPU_CACHE_ALIASING, which requires
>> flushing cache and arc, which sets folio->flags after clearing a user
>> folio
>
> I think arc just has some legacy code left that needs to be ripped out.
> See commit d5272aaa8257 which took away ARCH_HAS_CPU_CACHE_ALIASING
> from arc.

The PG_dc_clean bit seems not to be related to cache aliasing.
See commit eacd0e950dc2 ("ARC: [mm] Lazy D-cache flush (non aliasing VIPT)")

>
> Looking at 8690bbcf3b70, I wonder if you want to use
> cpu_dcache_is_aliasing() here?

Yeah, this is more precise. Will use this in my next version. Thanks.

Best Regards,
Yan, Zi

