Return-Path: <linux-kernel+bounces-428170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1969E0AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CF5281FF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E51DE3AB;
	Mon,  2 Dec 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPdiDbpw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135F1DE3A7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163966; cv=fail; b=FNX52c5vLOoDC2CAZ8wTsyksN81RIbTyVssLF5byJ1X9AUfDRPc+ZxpKmyofC+hyL07TyI5+FRDnY3kKhxV1irIIoyi/N2/091w2skLAvbGb3LAD23n8FAcKjummL9Cbq8FwDn/LVVioPIDpkWzrnpPmlLd5DuZuh0eGpMxH+b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163966; c=relaxed/simple;
	bh=oT2CuFIPdot0ysO2wyqNrLYwgS0OsBD36ZmV03ytxds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/6af/tYI6dOw6KAXWN6I9HXYUU5P5egFDqUxBbsRyFumlQjKM67izXSXTVp+CXQkzmqU7MmmubAjitU9wLGiy1SOb9utFG+kaxRXHxQh8zk6fIKFuyaC6oIiK8jAFhptzPPmBpA3z/wK4UtPE4gwZdN61Ek0E2ruEMpPFi7OqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPdiDbpw; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv2jsl+vMZRT1kZj0HMMgH+s13yfsEhQuO+u9kRo8yqBA0Ca2FUutwwb9VYVHI+ll2+4FjmPO8WkJEAm+nIzu0uagVaX/KjYt+q20Lv8nFUOX+DMyc76aJruV+6+pYLIGLjMGsdSGiM8EZjC2/Sep5XKAZGIwIV6OeKAFyJOd5z+ZLB1gbPDjP3SGcpZ7DlClZeQHt3QI9ubN61YTTw9AIDP3djT8AgZ7iWuXKn6aTTvAPURfgNjcbdnyIR8v9PZxzsab9dVhKVSD+e7rZQKhXmnnw9ZgjdW7FTRJMXKdHJDhDrsen5JNajSeYdmRX3jU+KJddfai3BQAnKK1BHIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJwNF+jI0EN8g2OtGDrh7ERgWTFTrEf1l2dvL/4MWHY=;
 b=jlY0DzqruJlQ2eKpyboqziC43zOz6SqS1p8mbu+7uBPFtpeJGNgbX3dYGlX5uRt98A50o+oNJO5PbeKxZG0670eFtbGCiXmJZF3SqQYq+zxxK/fUt9DCgwKT9I1eEAetfeW828VqajIpimIUhTfKZ7oW55+2LYgaj1Vgr+qS+mWeA/eukotgt5KcgFcaNoMIR0GIikvqaEaKq071tUwP3Szoc9uRdYFVJWGPCQqUVoi+rZnuDXuiwDWv5BoGShGfM/obbcpffbYbf7MeCoEUQz5hENd4oLv/CjO7pSLzeyB2iLmPoUiZz1VS3WGT4cCpH4vXEIJ6yOBoOolhxC1k+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJwNF+jI0EN8g2OtGDrh7ERgWTFTrEf1l2dvL/4MWHY=;
 b=KPdiDbpwra7OohL5e4c07/Ph0S8OsEZ9XuMHETn7QBga7kV4s6CPKr4lwRnYltwb1M8h+601zlitZr9TtjKN5P7u2tp5H/MUrCDMbhFAws6qG9ljZvoPFQU/j3MBwnEcYe2t94eDqiaXTNvjnZW2ePYI6Id/faIpKXcjjZRCZEiqb8F7ppnNIsYfPqiLgA9A51ujjZ9jI9AWwwJL50rDE7JA8yTzWoPLuTv7uHlZuMKwAqzVAjEIqt5gA4VpX0bMxn3Fa2kHGme4C82Zszv1ggb9jr2KCSCp4NA7zNQk20xN6aWJxd7vd3NGdCvKIfnQwJU+AY+cMX9yTNNRL8oMJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 18:26:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:26:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v1 4/6] mm/page_alloc: sort out the alloc_contig_range()
 gfp flags mess
Date: Mon, 02 Dec 2024 13:25:57 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <64714AE8-4B62-4863-99D9-55C78294E2B2@nvidia.com>
In-Reply-To: <20241202125812.561028-5-david@redhat.com>
References: <20241202125812.561028-1-david@redhat.com>
 <20241202125812.561028-5-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:208:238::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: c53d18e5-5525-4e76-1dc1-08dd12fec5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GGdNOwRzcJSPTqle4cQKOKAMxq0KwLGVQW3UpeAu3rjXnyCGvEXeFcTTjRBE?=
 =?us-ascii?Q?uD/AJLo3pzWvMrCHtoxbFjKUjLzO/DO7kX9PDCC5kERObMb62FbT3N+VIJuN?=
 =?us-ascii?Q?aT9u7QnbAFNAA/b41KOsyYbFAsBq+dS2/p50GytvsxPI/vrg/Y1If3IJgfJ8?=
 =?us-ascii?Q?nDjtOREabDa8ACs5s/NzsIeVf9jMysfMYl8CVCXeSvNuI38IkN+CatMzoAKk?=
 =?us-ascii?Q?Uem5JT4sS/jaypqhvcKyIGSayUapZSjaBkoVeqqLkJDrhU6xQ2AsF2pDiMZw?=
 =?us-ascii?Q?cT/cQUA4XLat7TgOIqUbjkuMae9yMIzxR/3+e6GIfqQ0M/y7OmhJpEIvzFa5?=
 =?us-ascii?Q?T5tpq7C9qqUUaTiiV0NKXbj9BD6kt13QmWbf9oP0hBl1f/ybF4LF6q8ZKKCP?=
 =?us-ascii?Q?lEO+E29mK3JC+w3q44bq5FNNjySKyl6JTyKONMZ9VG4yhko7/bYaDS2hRwXb?=
 =?us-ascii?Q?1W3SJil9g93v/ZWzKlfZauM9904J3eslXUuLlQAHRBZ4B0YaFgNWINld6YwA?=
 =?us-ascii?Q?FA44qh2BoGS1qdzBOPTSncFhx1MlPfnGZYVvEbdScpvvUKxSAwlN5DK/APWV?=
 =?us-ascii?Q?DP/7pOC8EkrxNBsYvNhTYjfDcSR7Yie2B+zZ7DtoARqeJI+h6YOO6TVc/WyA?=
 =?us-ascii?Q?NubBJr54uF7jTOry0nsJqAv6W3VrXl9745T/XjaDabqIy3iTmS9goVE83yYu?=
 =?us-ascii?Q?ZYAKwOythwfts5uZNl+ABar3fZTf3WgvLNGsHOelHBLoUJ6Tsk1FwmRWWg5f?=
 =?us-ascii?Q?f5dCAluM8MiPKWLrhQvmrotnP2CeC9kwzZye6k6ozc0a4DEP4z8uC7Fx8Urv?=
 =?us-ascii?Q?T+Z79H7ncqUafqVnJCt1pOtmeWFRO25zABWUKTJTZcLjS64m7zOgl56I13cJ?=
 =?us-ascii?Q?tZqy4O+50qKlOp9Et8ygry2rBY2/4YoFJRuQ3ppYmMqSGeBcFNmfMn7/Sfdm?=
 =?us-ascii?Q?HRb2PnIwxODLmTUVsEwrZk0zWVs/w2HvGM9AN+DBq0XuONHL3UQrKHXcqnwh?=
 =?us-ascii?Q?kM/Pe94SbAFKtMNhqG0bOm9QLoXe94BWP5yuDlgi1ForITaEzXHG4xdTuBIn?=
 =?us-ascii?Q?L/c9N8oZqQzABX46sD9LYxvYAV6CdoHfvatHcFQWW5C/FJxSYzEwVGXxcuUz?=
 =?us-ascii?Q?REonDOxTxqweajVHMfR8LzuLLbZQkwGSP8Cz3wQH785bShB6t8Itdm8d78dr?=
 =?us-ascii?Q?DAH+PBUVuUsR381Fj/BMqpfG8xZK77YEvQkodsfVX2ozHbrGrgU3VBxOscV8?=
 =?us-ascii?Q?eUyUBP/eWbfMa13H3Nqr3BLzY+C4PmQSFcQslayvwiFMA/sl8gj9zyhlVc2i?=
 =?us-ascii?Q?lUml5UZSm43t1zKzNqFP1byu9p89NDFkRYZ4TAOTBmscHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tk/r4x7rGFGh4AbRhNQf8eQD/GYc0Z3uYulQDPH8E+F6iEORUYhFDYC0Qva0?=
 =?us-ascii?Q?nEyuBWf2LReGTdkyL0SUD5Mv0HY2ddh2tBDQLs3qkx1tUFTjmCdLbNaI4Z0J?=
 =?us-ascii?Q?KUcxgcu9sHA1d7GUS846FsC5VMKw16UYg6/MM4odGl6UedEpIWhc6ly52tvG?=
 =?us-ascii?Q?shEGJgWQzXam3wxakxvFygGIbfZtb82n6SCjJiNLxJkZIuGW6jWxbsRn7pgd?=
 =?us-ascii?Q?7elVcEnRAV6YQe+3Utfx1IExUY7NYW9QcwWy0OwSorCvvJajdA+urFBWR64A?=
 =?us-ascii?Q?VwANCjQjG8cgrj9mu9z2w15vKkqotfNPiE7x77f/zsgSGZEFKPacW9U/Anpw?=
 =?us-ascii?Q?qDHIhA409LbkWIIBTCkRf6x+i9c50HzwbGPSOrKAY8gyTOkvR8vvvXaFQ1ai?=
 =?us-ascii?Q?BUjuF3HtQzgPyAImvZ95vkN0BohMUwItIWQZ4l4YzF4E+/ACbQbIQq6rZwU4?=
 =?us-ascii?Q?mpMwZqtKMfIxlkWIECxLgdtqB2jXpB6pnEJgkZYT0uPu0CWSAYChd21tJtmL?=
 =?us-ascii?Q?Euj50qoe6+Bs657+jPTU30F1FQJWPehPs8ZXPkMNM03R1dmw0id2IIsG551x?=
 =?us-ascii?Q?q0YAkniEvZIdkxBy5w/8FsyGitZ47iOr0/uHIqluVDZ3kPJSrHCKRk35ICF2?=
 =?us-ascii?Q?FxjGFEMYKI7nHKu2p3QMIk+fYB2HDFGvCNLJVlnAnOGhhoAVkPWqBjowTG8h?=
 =?us-ascii?Q?TTRKJcMb6uN8/+vwP774U+0Z2A/5Bmu8nupd2xUx0eqz427ovOxiqjT8m21B?=
 =?us-ascii?Q?zE8835MkjGmoJmwmO9X+xDI3ACbGkayXRtDR3jN5888i8MZtvobE/W5lKIq6?=
 =?us-ascii?Q?NxDR+/TvM6m68VWIoHCc7jmmNG7IzCqgK/DodH2hfbXc20No1HfQO+QVU8Ct?=
 =?us-ascii?Q?r5erQRBBJ2Zr1XwJzoqluTxVwR/b2ZVSLfqZ1wO89AyhxQBLEF6iZW/3du3e?=
 =?us-ascii?Q?YgnS8SXAAVPPaxU1XI0BhO7tqQMUdo7LY9k2k4K00fVf953r0BmjoZjp5nGc?=
 =?us-ascii?Q?IWKjqbaa9Pe7Dy9cLfMBTZT2AXpiNIWW9hPp+WRt1leLh6R0nliZ8kghH4yn?=
 =?us-ascii?Q?CJxGCJ5oFPBgqumBuh1bGFXBv8fCZu/pHzwYW/A7IQhH7NTdRSscfEp0TVqx?=
 =?us-ascii?Q?bQ391JoQJDHH37uYkzHW0oSTsNR7UbnNjwd1anWzJ0t+kWiRGDqZbrMWZUiT?=
 =?us-ascii?Q?lzA3uqeJ0bHsOT5dIihJD0Wunwr3mHlkluMkyparZyKzFX3rjfwVCw46q+aO?=
 =?us-ascii?Q?jsP/1GXFhHtJpYWh+aYLD18N0jss9iL9O3hq4jKhivR6xztU32Kk9ARAtNbr?=
 =?us-ascii?Q?XjXJtYeGvqY4PwxIf3nJxjuP8O6mXqcyD11Nv8wUE3bvCj2y+H1aZzT+NGwU?=
 =?us-ascii?Q?jNLQtXKQCWrtigEts/6lDz8m6eGKIiyRvSJFXyCbGX+Ov5x0HAHk6JlkJGdW?=
 =?us-ascii?Q?siCdu9ZB4fuEvTWUWLMI1NwPVnAvOswR25HyFZer01Gfe9s2OzL1XMLZ0ACz?=
 =?us-ascii?Q?5P75iTnHsvzibkoer3/AnzTKcg12XzexcuFaglATT58NRWZ2vIQZRulLa0T5?=
 =?us-ascii?Q?yhZoMwj1w1kZXKw30X18yddlDf5UJ6vpcHXRcklH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d18e5-5525-4e76-1dc1-08dd12fec5ec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:26:00.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx1vVEkYhwhXGa/EdRRh5PS4QKbSlKuklCXuLIiG+PUGuAYEbSU0q09e+oYPaUtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481

On 2 Dec 2024, at 7:58, David Hildenbrand wrote:

> It's all a bit complicated for alloc_contig_range(). For example, we don't
> support many flags, so let's start bailing out on unsupported
> ones -- ignoring the placement hints, as we are already given the range
> to allocate.
>
> While we currently set cc.gfp_mask, in __alloc_contig_migrate_range() we
> simply create yet another GFP mask whereby we ignore the reclaim flags
> specify by the caller. That looks very inconsistent.
>
> Let's clean it up, constructing the gfp flags used for
> compaction/migration exactly once. Update the documentation of the
> gfp_mask parameter for alloc_contig_range() and alloc_contig_pages().
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

