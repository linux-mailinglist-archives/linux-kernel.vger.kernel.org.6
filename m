Return-Path: <linux-kernel+bounces-560615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CBAA60719
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A868177EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33FD17579;
	Fri, 14 Mar 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eg4+5ige"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852422E339D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741916415; cv=fail; b=LY5ezBgai6z3M4z7bApT6pYCXDHYaEmWkB/Gze2MABjfxwCh1gVA1auwcEXIMQCy2AzRHKQBW1ILFHx8aaHLkE6qpy4zbanePTsQgdr/FbSddd03QGZE3/1IqbdCHl9+Gm0DccEI/yGWJ1OsB3ZfrrbG9GDLHs04l8WvaAhTvBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741916415; c=relaxed/simple;
	bh=jXoIyyBady9Z98MN9gCv1bxlLgOGWWiKc8NChIW5O1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wh86B5xN2ktuR6ITg2RCpz3OPa5Z/xF+BRpqCFPypQJQl1p/YYt1lS3wD41gpS4T5b2QMaUmd+Px0me1QN63IF7J2DcVAyufgIEHGdOZKBMqW5+XK+LMPOifB6WAAIIXICVave7boLPwD4mnVP/RYO0V3QE5c+P+iXcwYgjTG0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eg4+5ige; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnd1wjZmwHHK4GWVtMWczjvbrjFDolP/pZ5MWMTQ9YqcuAXfGowG/q3/5o/4U3pm8qi8bz8r7adAt7TepExYzgqUrmghnKlzJckIBkrivQLSbzk6alNBAERro+Rmo/nz5k8b+LhkblGHCj5DkX0+tahloB3P6KveyucAY8rxbCe1vvl6Dg7cg4cRzXg0CSWV5YLcWPlzO58VZfIFrQvLFTrjzpk4y8TkL4x2vYNsbmxh5E+Yl78s9T+yVzsNpSocCsYxY10hW0I6fTkhU7GFn7VDyI3Hfi1mmSnRrxcSTlp5fgT2ARJ42jvkZgAJIJvdFcJZph/08krDaPQphTqsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApgDJtCdlFciLaxI0hK6EnHulsVhpx92HE+I1n74dFM=;
 b=Uy4tSyQT5/rc9dEzxkVAV0+8rjsgxTcqiTEWuXz22NjvF9zULWN04yf1+q2Hi5z10yfxUZndaqaV+Q/PBylsmtxn+6mtT3DWaAGvOZPwtGwNMopmsGssrLkPrLdyk+2IfXywGXbjgLQ67IMbXYw5Z/249AkTHOqODOgB2XJ8tXSo0AWQdTP7QIu6FG9e5+44/cidpBztL4QiSYiObvZEeN26N08XelcQ2wS8hmYD8xCA4tfi/h7MVeu9IilXKRmErrIjHOUrEPdjJLn+iYtG4OuROsCA4AxMiMH3HdNCCaqDN1kFs4/oGXTr8SW/h8QdFvhw7NgEAvN8AZQMvfjvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApgDJtCdlFciLaxI0hK6EnHulsVhpx92HE+I1n74dFM=;
 b=Eg4+5igexyz7FvCKrMvQS8bRfwXEw0wTfWMHC8SjOKCJc+Ya4mY1R1YVjjR03YaZKqX8rhKNQvHATyacl/jKwZDJAEltM6OvXlrhu8aD9FfPRConIuA9Lw7PjmIQ5sS7XLPGucy4y/WFYLqFXfH4C3wGJAoLbQngb1ZU5ai6vzcoSKufaQjNoqEuI+emmrAHe5+JTrAd3UxFoEAv+wbFVw7ZEv1k2PX7WLOy9UlEFXCXbS94mLP5DrFqBYryOvDlYZwUiBSxSlcLbtdy6b4Oclx7KHKJysk6grv6K0+6bV1OLKhBXOnY8ZWh9ySENpasvS1jrrDm68bK33c8rd8NYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 01:40:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 01:40:05 +0000
From: Zi Yan <ziy@nvidia.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] mm: Move nth_page from folio_page into folio_next
Date: Thu, 13 Mar 2025 21:40:02 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <EBEF95E8-92ED-4381-A001-E7206FD0E1A7@nvidia.com>
In-Reply-To: <Z9OD5MsHZnzG4Smt@gondor.apana.org.au>
References: <Z9JhwhMIn4uhkHrI@gondor.apana.org.au>
 <Z9LOzj17FDFDw7JM@casper.infradead.org>
 <Z9OD5MsHZnzG4Smt@gondor.apana.org.au>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0717.namprd03.prod.outlook.com
 (2603:10b6:408:ef::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 544d62e8-a808-4986-4b98-08dd62992526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KSWArkhdgA6LvFMBmMuTJXERGweBWTr/mK9jr0VZA+1xXFpk5Pb0QpEU4WTb?=
 =?us-ascii?Q?SkmrREne7xmW2vStMNJf5r0W1ax1c4n7a7kb/vsMNtzSp8bqjJ/rMVD3bHKW?=
 =?us-ascii?Q?AdG0YO1YvFfvsC3bny/SKvjvkJspW8fXU3fN/s7MJlp2CVOvs5XNcGV4AdHS?=
 =?us-ascii?Q?IYT0zb20v0iEOdGH3QEwCYwjf7G8X/sO/FJw1e/uWY86RYZOeEtlUKJtClve?=
 =?us-ascii?Q?O6YWwAK947+yuwtThhwhMaX88Y0XQcLMgZKHG51o/yn8DK93CiSDVtcHRmJl?=
 =?us-ascii?Q?DgOsDKDWmuWSTZdqdI8qLi55ZtfgwfUnK9N++/E5HLoFPy9fbzuRZjPWF/9w?=
 =?us-ascii?Q?OmBAtQYoAYIRLcetjtoL2Lqd92dH15bs2Jz3LDudRZHp7USYFuVJowsxK583?=
 =?us-ascii?Q?d9OoO6OVRZbGCSBLDsweWtrXu02Yc6FLQponM3k/jjQcyvZ22eY7UZcGHSls?=
 =?us-ascii?Q?pkwcHeXesptM4V8yGuPhLQX84nSSfwbk3B/pTqqeMQcrpUuaPg0veuUMcw7R?=
 =?us-ascii?Q?O1f4HhnklAzZQ2fIHUTuhF+UpLdRMpXTOoX7+GisKUAAz4mu2jPrxeBKOM30?=
 =?us-ascii?Q?Z5GOmPIzcFP0R5ZMF3kHhy1VehG0R/I6ePFME5etLNa/VfVm8/+mC1Hn04Oo?=
 =?us-ascii?Q?XzqJzbHwz65mxFZZ4TNUxsxZ9X1j/U0mNG0ChZl2kH0hBMyYhu2+gFLUQZVt?=
 =?us-ascii?Q?QXig+ABDc4n89eiq3qcW00aWqeTe2rR52Y6EK9qMIh7u9GeWaE58dqoYODcJ?=
 =?us-ascii?Q?BsYrs89ImN2c9uJITlidQsiY4Bc2MKbALg4+Vtwhd++LmPylDrCNEFBN/Q5F?=
 =?us-ascii?Q?K/MK6ESFgcJ6cYt+gfimxe+rx0PMcmPToiCL9MQshCQzrAAwXj6gfTiUtBGK?=
 =?us-ascii?Q?HVV/DNbfhNqYnMeSpvUFGmBaySKwP9tFZgjF8v9c8iUMjOsXBMDvBKqbLTLy?=
 =?us-ascii?Q?76cxSfueIEaJgFasStFCxHG1kgXdt/9WZChH1bO0d0roQ4UMPYFUFu8ijwPe?=
 =?us-ascii?Q?6Fl2ZBeQD5aY18D/vCxnnNnJRPdKE+01obLx1FyHhu30P4oiCNETO9gXxA69?=
 =?us-ascii?Q?72xZXmScTABMDV801nu5TIUEQWniyfOEns+IykWfCpaAMmaFr6/Mly11NHZi?=
 =?us-ascii?Q?oYcygbzjGgOwoITJfCsVPfmHK9HAb1aRPyge5AsDwW0n8vN3EZUdiv7bGuG1?=
 =?us-ascii?Q?RYTfYrLrC5HDr1TwIxqOD/MJAqZLbqaU3Sxjapygq6fOlkBOauIe6bjUC1A7?=
 =?us-ascii?Q?hfnpThprLQF/9SPYpTCxvTL6Ihv7YgTn99B0ltyuOlC3EVCtl/oa37udSIbT?=
 =?us-ascii?Q?7Gp3pN142X+QbJykS+xLhVBf0sWEFnJcnipCb776Gc409oNaw5ha/FK+JrnY?=
 =?us-ascii?Q?BYUJDcYc2lOhKb4+WFNJCBsK/wo6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQySeMpGWAaOOKT00O1BYNQPXYCG8I7YqiKokzTE9j1D89ZKazOog4CXZr+e?=
 =?us-ascii?Q?+c+tavIjobCSjvBUqozE293RPjfJhMj+RzIPfSIDaqdBfRJyYrhbgUtBoJuG?=
 =?us-ascii?Q?3P4obx5ZOT2N6ZCfZOhyejEaDc6boGoKGgZNTrM5Y+GdLsFzPbJAbID083A9?=
 =?us-ascii?Q?fkp1tL594X4L+zhGe4r/jifxTS2JeXEQrS66Myj0OK1z4qa5jrVU8hj6U2qL?=
 =?us-ascii?Q?V6APITWj6pV/7W8+wCn/13bIEwY7TWhDC9v50qlOduqPdopKwTo/f+JDBHnX?=
 =?us-ascii?Q?rp5jy5mVNU6SFDFJHGaZrCy/Ofk1pgUzZl/nBrQdcZgq/mrzVCLpouHQNNir?=
 =?us-ascii?Q?+972tsldfT7RVaDcy2937wTwyXoyfrLsfO7HLoO9nr9lKaxxa667K8CtLbvk?=
 =?us-ascii?Q?KD2pTkJJagcSv2NiRGZas2UNKsd1Tj1H9gYNhSqtk8naB9UYDxdSkZvSVXpe?=
 =?us-ascii?Q?5rZwOkPwW8K3h3aGpqVNjSwQe/oUnEnvrOE3Txs/urdRvrFVijnSFrjeXA2v?=
 =?us-ascii?Q?0SAsiE1oPHpSgB8FcNl+txc7N6nWmHRXY3QnYTOvlGuekn2BPxfgAtjbjcAQ?=
 =?us-ascii?Q?g7WDoaY8LG4nsxD/9spVsyMLBKestktWuOa2mt+JvRvctrZyRxTrgm+xWQFh?=
 =?us-ascii?Q?AP6JLQD/7o8p8g4vURsXNme8zf4lSkbhvKYlT+HNfh1eNqCsfBKdefUikj6w?=
 =?us-ascii?Q?lr015q9fWnucoMXEXq4ghNvUrcVGw/ZO1flEnes8okb43z0rPhvD9qsFKFev?=
 =?us-ascii?Q?gBvna23hVGFKm1K1Tqzc+eQvfp07MeIxpr+mWkAvAqGpQWUPWN4JaMVgQOu7?=
 =?us-ascii?Q?j86NnStfVXP2EY0lkRomCji/esqMYqwHW4Ubf5P2H2IMzKAUNtuWdZqWm/eX?=
 =?us-ascii?Q?rq/xjHPMH5+2kXa/bku0SLyd0f3ybkTrtce+KEAlRZqArqwI9IOF2rvEU/oC?=
 =?us-ascii?Q?KG5pe1eEps9vOzQi76Pj/2LbWcanT5riEi3zNHLacXMtZK/uqzqGfso1IzBX?=
 =?us-ascii?Q?9Xa8ENR/dgswYgvjyYeNasC/D1YPWk7vjVZ+VpUD817PXryHKTBh2UKI4x4Z?=
 =?us-ascii?Q?v3mFPS5zjYcHCgk90BG1DsdITg+a60XtlkeEc5Mi3f8f7WHFXzQJ76dOnMeg?=
 =?us-ascii?Q?f9tmRQarplINsYyIFfKA0wZvYpqTzJXofHztmXm/wp7G1S5AB8n8ArZ58sN2?=
 =?us-ascii?Q?Qb9GVidcynGJpjY7PHgCqyTBGINDEzglOn8iMjVveSDu3XxiF19iCQAE199G?=
 =?us-ascii?Q?VIQC369arQTpQuWuWZge1ib6bPkU22I6XtDFWpTPaHgvS1HDuNPq8olVrCTU?=
 =?us-ascii?Q?8Zkp7x1eNXJ7MQskPmaw5KWuOanpD23jGJH4SzSg0hmxy83hieQYUp0WSPer?=
 =?us-ascii?Q?kgHbsF7IM4wFPQBDKEJkt+AAfT2CZxjA3AqiSTShaIyAdhnc/ArHkS9CTIHw?=
 =?us-ascii?Q?d9wg1+R/zwFLoUiv3hP42Jp/nvW6BsWXvLr3zfatved7Y9eOWUQPwA7uZG4v?=
 =?us-ascii?Q?LRMzLHewdDCdl5Wc5NbzKi476aulKMoTDrJijnddBB9HbJ2O0D7tAIqJCOk/?=
 =?us-ascii?Q?1YdYONBTs4Wj8VD979W/RqIpfFMPObD8kocqNCkj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544d62e8-a808-4986-4b98-08dd62992526
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 01:40:05.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwYCLOddQAkO7l0Hm6SGRFkhi+Vv2RR9izPQWLZUmGIXWCmCU3zFcCwVSerreDYE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957

On 13 Mar 2025, at 21:18, Herbert Xu wrote:

> On Thu, Mar 13, 2025 at 12:25:50PM +0000, Matthew Wilcox wrote:
>>
>> That isn't true.  HugeTLB can construct a folio which crosses a
>> contiguity boundary.
>
> Thanks.  So thea means we do need to use nth_page when iterating
> through a folio or a scatterlist generated from a folio.

When you know the folio is hugetlb with gigantic order. Folios
come out of buddy allocator are all within contiguity boundaries.
To be precise, the boundary here means a section boundary.

In addition, nth_page() is a trivial addition for SPARSEMEM_VMEMMAP
or FLATMEM. For SPARSEMEM && !SPARSEMEM_VMEMMAP, it needs to use
pfn for the calculation.

Best Regards,
Yan, Zi

