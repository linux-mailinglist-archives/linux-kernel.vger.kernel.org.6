Return-Path: <linux-kernel+bounces-390618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD99A9B7C53
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA4C1F21CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7445C1991CB;
	Thu, 31 Oct 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rt8rUhlI"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424E193417
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383483; cv=fail; b=ONTevK9h3Z9TvCQOsmI0tyfmdy0WTY3KBnI5yz51VQ3oOTeEjDkFCnR0jKHv/tvobfDBHuE3o25MVk2mJSWDlNZcLhgLFmhNeWkdgaQ6jefEfv/H0T/CPO1Vi693i4P9hCU9AWs8GQjWVgGDv2wHZF7P9PgN7vWbOrKd1vSHLNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383483; c=relaxed/simple;
	bh=bh0WbC+mpMBR/z67CCYOacNVNTzkB8ABNafZCLaFqrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fsRDNvmCmR0Gc3Y81PL6XoSv8veXLmNdYfaADvgFMG2RQIqd3eclkjCpXtdUaa7CReOWHMf7hG1y9FbaCF9l5Or++6kh3QZgPMDYq3QRMBoXFZtdDue+GIVkxE3hUy/TWrJn4TPS/pb134GEgOPwSUDMGvMWwQtWJMseHDD35xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rt8rUhlI; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snTOlVhbkfhmLMZYxrSHFozSsxmjFJHE+kpRv9+Q4BNIglNNACP44XCKxYovGuwMkoeNIF9GjEBpq3BYBO6xJx4oKjAwR0d3Gf9ICWqa0ByQKUfCDI1EVnBH9S6oGrqwWtq+BMlLmEJWoQ28uLVxs46C9yCgaY+35Kjroze04lQNq1LUWk68x2G8fl5Ncgrr1KEuSTOjeQhbhlmhk5r1YvzqZVlpwKzB34RrPY81Qp//xr6kOD/xvmvfv2Ab6ehb/UJyMOMFe4BIqIMi0i95l1x7d2QN9BZWC1s83aOTbaqOH18Ih9uX1EUK9CSw2t/5dWp+fDxD8kCqdvny781qZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMt4v0wP7b9+gty92xOHJ7HURFSPP0N56vboIhM9U/I=;
 b=j6Xs7sZDc023jwzW7NVwzFZi4LlXS3uOeNIwkwr4zqZ2xNweHd87rPIQtbAkeE2YntWj+JhOBv1SPmYwO/VRNtDdcD9wK104uM9apPnHGzHogpOE8XEqXGhRPtRxmpHBOBC6C8+wr+ZIB21IPb5PgjTxT0zJofcNROBLmn9s0oWjoUdpaGitQ9eRR+L17AKqqY88l1sRO+OEFCb+yMUMXEBFB1zfMyTqcQPpYfbo4Hz1t/zTrPVgQ1N5eNg/MnhTIsIPj4sXJabcB9ecEKQmT6V3UOVgXJrMzJ7LCMPdAcwxIPQ/ABosEE8eksnuidDOM9xo5HAbeh+MH018By+gLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMt4v0wP7b9+gty92xOHJ7HURFSPP0N56vboIhM9U/I=;
 b=rt8rUhlId/W1l47o5V9CMH5ghweU5f3gHcV5YIVZ2XOnaSDzSspzmrQLeRBflXUVPb8cZfEybjQI7L585kh0zqToTLR0ARq7Qa+VY6mp+o90C6pdVbJ14GCLvLULGXDHXoPhmlOe4Dq9hnJQ3GRfrNLtvHG3XidH/ct0yZt7fsiAJmGrVxXfxztUnREujW1A/9s+VViJnWBQYqTNf0eTsAJUjfYYCJ+xWxeC4j1KYlTU6Dlj/KyUsduAkqY6lhxCyjfURddM9ssejQ5PoMmpXed8bnZEklXhF1zgWW3g2Httd4x65r/SR1KcOaIbaVtACm9/SzaHYdehkJH/Wn7NSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 14:04:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 14:04:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] mm/huge_memory: buddy allocator like folio_split()
Date: Thu, 31 Oct 2024 10:04:31 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <753EF6CA-C358-4D23-AC35-2ABBB61D0FC0@nvidia.com>
In-Reply-To: <cqh3exrkag2mbdeluranstvakkzxjpu34kkjs77feuvexoevop@nlyq2otyygr2>
References: <20241028180932.1319265-1-ziy@nvidia.com>
 <20241028180932.1319265-2-ziy@nvidia.com>
 <cqh3exrkag2mbdeluranstvakkzxjpu34kkjs77feuvexoevop@nlyq2otyygr2>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:52c::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e60be2-bf02-4622-7a5c-08dcf9b4f245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jviJScZnsT7BjRtmvQv4zbfrKvzjxLaXQt2UgZEb4cRSVuZHk+v7m/Od84+E?=
 =?us-ascii?Q?zvsJ5ID2RgzFZnkTyFXN2mggnp0Nr5EcntpWreZQn2T7gEbzyLBmFIzdx2ek?=
 =?us-ascii?Q?OaZk3Rc9LcDE+VMZvaMpe9MrMdHHB+o3IGa0R2uuXuEPuQyrJYTxvb0HDxg/?=
 =?us-ascii?Q?ub+0yHnCLvBCxeuAemE36lW1oPmyd/rpoRnTmc1abcaIrbfmadpVxvBuoO8N?=
 =?us-ascii?Q?7W5XAMCn0ym9Q+kNwhx/FW085EWS65lqfBzijYoykfaJYBDCVBwDZTbBY5MC?=
 =?us-ascii?Q?+3TyaSy1upejQFuXLiuvm4KcsMQVowELdfyWeYF70PDOvROe/aq5+y29wWi9?=
 =?us-ascii?Q?bxwpfG6jGnvu1SDCRjOSWqdhCNP68D4X9ATUgEMEOZKofb6tWTgGV1gJ4igC?=
 =?us-ascii?Q?BADl7WpXDuHnB553iuuHkr5SL3Vil4b/lEgY1xodytzR2+REU1uuGoCR2qm4?=
 =?us-ascii?Q?Cvo9vob1janHlkNEVvdcKK1p1FwDx/4Qg6LJWM/lrm+UNYHx00wY+aL6gQSv?=
 =?us-ascii?Q?lGvPXBqkuyS0qi9kRxq8U1kmCHqdG6RWgW6sYeqFXtBC0Jzz2nBtfpDUYRDU?=
 =?us-ascii?Q?1Q27OzPC+/TgaewXLcH8PDMuAq2cTu4vOJwUifiFg0do+BSPtkESznZOp41w?=
 =?us-ascii?Q?qv9pSOhYzln4nh6QhaqJ6QglCP94VkAi2pXaRV858/JlhxQkVtRsWQtGc1sa?=
 =?us-ascii?Q?j0VvOV9lnbgWYb3LeFezRFgSUz49LzpzWCkXwzGUQ7Ax7by0tyN+6egGXXsG?=
 =?us-ascii?Q?xfjUdjKJqQ30LYiklmUzPWxIrRzKOZcMi5L4QdVRhB7D/OVRVpvjZvksB+KW?=
 =?us-ascii?Q?mjJdpHi480hGX3OOYKf29f3jor/O7ZzUAjlxR/a58/3M9rKPQaisaF+nKwRY?=
 =?us-ascii?Q?616fyHc0VDIl6jaQg2HhHCs/vnfusQPup4laKvB6YUkmIQ9XlAALF9kRVmCU?=
 =?us-ascii?Q?7cNAYqocmZ/k4HQPqWd/vh1G/EJOh11tgTFJ36/rj83UGUqIGC4rAc7hrZTq?=
 =?us-ascii?Q?K4KuYDIfUiSEa/B1oGGrnxQxhstVqaIjBGFGjOQiOYff4rkK0hcbg3uAbVof?=
 =?us-ascii?Q?Ze7QZW/PZ5HzBQHeG9UK8mqp7KoEjtT5vn8lD1aDonFgcChIYQpkCPv875tf?=
 =?us-ascii?Q?mNnVcCf+p/ojd/nnpvjepgtahBKW3RTgvLuA9CP8n2WGijZS37OseDkBN9FC?=
 =?us-ascii?Q?tz3Al4WXB3r/iKdFdfOsNO+S47mMRuKCtI6dJ5SFni4LQ7w+yB2MtGTxl518?=
 =?us-ascii?Q?zJxKRsYKGzIY0bz6agWNhhenDip0PfDL20MpHAefyuWFkc/jbxaQ3Q3ZtcJ/?=
 =?us-ascii?Q?sykbP6r7HpTqfddpua7iIeQY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vb1iwyt94qqIsRBMLF/N834G7nbK/5nlljJO4DPjq4N/BB1RU5txm5iRp/jl?=
 =?us-ascii?Q?+/fGX9Oyq5DP/s2Pm4qZPk/f1ou712FcLekjoO7O80wpPpn0VRE2doLU0B8r?=
 =?us-ascii?Q?bWO/S12FjWussMUSyEmK558O33lPuUMJGJJ4A3ZZ4e//rdjhy0ahrGhDc30t?=
 =?us-ascii?Q?IpeiuYNNhKjLXxVzwveS7mT1w+875Cw71/aY4yrmE58ssRea9zk1+M8iMimT?=
 =?us-ascii?Q?PACgjhy2StEZjjIPy+8hPhGga4xH4FXAVFXqh0ni9J+NWj++E7Ea7ttRyjri?=
 =?us-ascii?Q?p3a7EQWG/ZDvlKx/CxkWHTTzg9f3jiuB2S3gL1KFnK7qLcpT1xE2aCcx+LIN?=
 =?us-ascii?Q?PofNvDv2kFNOxGiRmr8Dvl+A9mDdTbL9ovHGrepSkHGsqhwxfNBMYdsIfkuY?=
 =?us-ascii?Q?e1evZDScUCFEvmQxkiFn1kySxmgFY+SliVOKyrcFa5dIEN0m44Q+gAtGs2TS?=
 =?us-ascii?Q?XcOGOSeOXuuS4AUgde96FpRK+KW2Bc0DGCbxp2cB3f7IuZOJOZ8NQvj9HGAb?=
 =?us-ascii?Q?qzauS3eLAU39V2fFvx3aTOQ4xrd4HlbOepbjvA+tk0hGXGBXuMqX0DVN+FKZ?=
 =?us-ascii?Q?M+nlC6CoPJLia3H2ewHFj3aojUzbevDuceC3/MEgtNgMWlHOmXnywQFSfaNK?=
 =?us-ascii?Q?vBw0oaphKvzGPq3uJxHje7gazijosv0U17+n+E8jYiKjgkm8aSPuHH2fimm6?=
 =?us-ascii?Q?XfpCzWq5gxJdDaTUOUJvc/is/QMX680YCbB9e5GIU+kUgeLXgVF04fm8kxNO?=
 =?us-ascii?Q?CFxJvVzRtsh/Bx2lEhf+D0LvUcYG+v0LxmTScaYfUTj4aPb59n8WTcyISPgL?=
 =?us-ascii?Q?zM8owy2u9sMgwaWA4a+BMkkzn5bJGIS3hvhjafjGf9E4bWhz5BY6QQG9i5+I?=
 =?us-ascii?Q?v4DSNUe80cqApofSBQMM/e+smHmbDxnT6s6AN0UiwQdMKbDN3VqWYSUBgYMM?=
 =?us-ascii?Q?sCkXTj3/5cQY9iHh+EOXAbWVh8IMLxPALlx4CFxL1p9F03yjUXTC0sYSsCz5?=
 =?us-ascii?Q?DTJ2DS/fDugsWk63tytQW96VtvPi65zUJ4kkm1L3gOGHKIC2Mb1AO7TeHvD9?=
 =?us-ascii?Q?b3bsnxUSnX5efXj9iP8+uWhDN5fL1OO6zGthupJMRgZecXc06oDP8thtNCTZ?=
 =?us-ascii?Q?pqVFxSregOTyN2n90B3MhbbPb/wVvCBw+zxQQqIjLIZ/D9eAKvnTrnnaaLoe?=
 =?us-ascii?Q?NoEq5n0rdmg98zzM4qeahGktggga0XJkuwJ0ljbK56Z0Hrfvr7lU3msIFFuE?=
 =?us-ascii?Q?QZ3KG+Uvfuu9gWdQN3vCec331vL6VTSkWB33l/s4LUiOGbkDGii0Z0ob3jvS?=
 =?us-ascii?Q?IkQ8XTPXR+pLPCMuVjBEsMWjUcCDvpn3pchvn6rUg3SoybcaYv5/Na7JSIZq?=
 =?us-ascii?Q?ips3dh36ecQDB3DiV14etoN8fmdTB/RP20NYyuLWJ7xlFnqzrM+iEvEIzcRR?=
 =?us-ascii?Q?JX3VDeddDZgNQXDhxWiOmH+JlyEH0nDSDsAbB4TBvg4joMzCfpdmlxGWw5PV?=
 =?us-ascii?Q?J2g5tPXry65JQv5wOl9uRgT6f48Yo64vvbB4QRF7Gn4yWLon0Gm2zaa1TAvG?=
 =?us-ascii?Q?BBynGnmMvCqbxHxMcBz7llwP1WjjBezWSd+Sl1+P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e60be2-bf02-4622-7a5c-08dcf9b4f245
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 14:04:33.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFC9p7HiDZLvOqku3FdsAYqprpR1pP01gVrbwaXrMqvEGzDEX/49yZDhHHh8BFQp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

On 31 Oct 2024, at 6:14, Kirill A . Shutemov wrote:

> On Mon, Oct 28, 2024 at 02:09:30PM -0400, Zi Yan wrote:
>>  mm/huge_memory.c | 604 +++++++++++++++++++++++++++++-----------------=
-
>>  1 file changed, 372 insertions(+), 232 deletions(-)
>
> The patch is really hard to follow. Could you split it into multiple
> smaller patches?

How about these patches instead of this one?

1. add folio_split() backend code, including __folio_split_without_mappin=
g() and __split_folio_to_order();
2. change split_huge_page_to_list_to_order() to use the backend code in 1=
;
3. add folio_split();
4. remove __split_huge_page() and __split_huge_page_tail().

Best Regards,
Yan, Zi

