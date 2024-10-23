Return-Path: <linux-kernel+bounces-378559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331E9AD242
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DAF281721
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B21CDA3B;
	Wed, 23 Oct 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQeu1mOv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AF1CBE8C;
	Wed, 23 Oct 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703581; cv=fail; b=PXdevjLFWbZGctwAUzoEt4mharKSe372XuDTCtvxZOKNj6HRhhwkzhPkWQUck1de3H83G8lsfgJ+s3ScWizSXEjWzD6jA0ZL+/bZngnFyxqmQ1yNJEL1so1QeFHXuD0FjY6whXyLbAgt5GnAiQ4kQE1DbOkH1PZ9zp13zvUQk00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703581; c=relaxed/simple;
	bh=b5wLiDMB8DV+BqYy8+lVONVMDJi/TmDqNZlxfryY4WM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XVBU4VsaP0GHwYQjxvwZ0wQr3OUu21uMkRYRe34WWMDnp+rEz/ksH2NvYNrwLAF40xcvHhr4qkZ0UiBh24dYp7mPeTah8QyJu6G/oQvHpNAjNIZWbX+RqMeKzLrL6rH8l9PAEotmsBZlwUj6alOmiM6weNEx6vyiQLxPPvGVEOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RQeu1mOv; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUyUjT3QRuqkbcRpkqia+pIEUmaCZVICMPMamqF1+8672lB0iUiI3FBJ2BoWAWC8Hh8hoSUrRxl9F+47AvTdawwdh9OLh/WVMUUe+B9JAqgtqmC932oX0v6+7GiN8LuswSPwVkMIK15Oph4QCMS4BQ7RQ2o5XQe1DCSpYQMlGZPqXkdokR9rARHQTCeT7iBDm49r/SQkK1DPToN/axg6oJV3B3Hx+os+XdwLc54pScMcQSsF6gE87bsQwcdwWsW1VCYFZGZW6SgwwTTlKZm6xNIojQYxqX/8FIfA+Ow81mBIK62wGajSx1dkQMCZ201QAIJcdDyn+hw7M9TKx0RAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzcAyqu/MVxyI5pW9uS4cxtAvGQBBEfvUnoTPh/5le8=;
 b=kskR23HULm1JtGAchubjFjIi266GZ9evIw8kICox6ScNon6wD3nPQ9OZdyIviVrBmykX5AIW2psOd0KMXDDgXEC3gVtTvrPK9VHuAQjUgUrw6urBXduseo/cnc2DKnYbTnM29QzD7au8A3o1AHihQGg3veSSrQFVeUtyxrh31Q4bNg9inbsmelBNgEk6RgaeySAldNHSQ/uANgcm2taDst2BR2W2ZUX/SXgGhGo/PhSr537xS9Ksey3QYlxUwKaQ2jTEk5NsJkB1E7G8syQ2Xbpg0tDEM2vGWK5vWi58I1EhW4Ziu9zRuIEgvwYGZSBYcwc4wnF+fFx+PG6p9DG2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzcAyqu/MVxyI5pW9uS4cxtAvGQBBEfvUnoTPh/5le8=;
 b=RQeu1mOvx94NdlWU/lPD3Xs/9lFypOQE9pgrDoZmmHYBG+10CKHq8KoqQO/V+IkGk/CoVWTPNpcipj855tx6PEDvBOFWjc8ya01YHag9mLyR6sv311nmXVAB9phdx9qGrZA7kmy1FSDvuJDr5mZTAyB6AoJLRjF2tAxghmoDylE0hYiFlH1QloR8HHwuWsoAIEqIlxczYMxPsJUCp279fNVamuBL+aat5Sx3pwIRQGIU6R7xGZOYJfokkMoeV/57lYlYRu/CaYkumeyPXFgNPUJH6yu23s18ZCeaiFmo5U6d9SjRS66VzcUeNingRYs5zMoi4pRrvVzzCAGPLAGjRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Wed, 23 Oct 2024 17:12:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 17:12:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: usamaarif642@gmail.com,
	baohua@kernel.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	david@redhat.com,
	hannes@cmpxchg.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	npache@redhat.com,
	riel@surriel.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	shakeel.butt@linux.dev,
	willy@infradead.org,
	yuzhao@google.com,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm: avoid VM_BUG_ON when try to map an anon large folio to zero page.
Date: Wed, 23 Oct 2024 13:12:36 -0400
Message-ID: <20241023171236.1122535-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::38) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 09557070-1230-40db-0c31-08dcf385f04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wG9m4RyiH4FS+YoApwSCuUPk4G3D5fvn2u6ow1gULrqYYf4roy7XYLNgS7hA?=
 =?us-ascii?Q?vLBULVbzN31KYnjOQU0QaIu0OHPf6PXXYDkkvjvuNx7cgEKrn8SjaQ2inVu3?=
 =?us-ascii?Q?y3uJ7hH9AURaLYJRf5kzYPCBetS8gOmiM1M6BBDpF3QqD1MFsK2JJjcE19BA?=
 =?us-ascii?Q?YLp5kZ3wxJj+1j7jQf3WDooxb10OKynpyWJFFLXNm0kwbb8YnBSMK+ZYWFR0?=
 =?us-ascii?Q?VxwwWuDu/KMx4dde3Q4dEoIzM6nkUCzVuhtoStsHlcUoJQMVwaoF24QPqyYi?=
 =?us-ascii?Q?J81q/Epe5F2YyuCTFjeicqTwtvE0rB2PpRn1GLerBO1VtK9jOcGGkXqnJkJc?=
 =?us-ascii?Q?JRwU/G1lQ1gBto46ocQn3eBF4Mu6t3r1i1oZulJhUO18sI73C3lavcr1kkhX?=
 =?us-ascii?Q?/JntYPPpMp6xM/x5r2C0ADqoCFR0QPALLMTA8sSGK/5duktDMW8chG+g1Pnq?=
 =?us-ascii?Q?KLAWh8dxF3H8Gmii3hiv8HQ5iBPhI774jDRHW5dBEJScnLuTa4VahzOGxXyE?=
 =?us-ascii?Q?BOjH88Znsl/jkua87T3wRTTrrdjptOnDb8adFWdB1pYfxvBrxltINJNJmnWy?=
 =?us-ascii?Q?cMyrm0MJvsvq2O0H71IjXFrX8Nyp+rRMSov+tiACbFQ39W2/f/PCASKGB35N?=
 =?us-ascii?Q?cFEKx2JSHo+Zu/kJiW+SBLeUe7JNTvqTeG+6uiY0g3CwwHHJMWfiNzJFuaPO?=
 =?us-ascii?Q?2REvNzvuH/MPWZVHsqmSyHJlWyqYQLD+5ySv8BmhlLMEzjKP5IbM8rbpuzyx?=
 =?us-ascii?Q?d1jIsaxFsy9ARwo9iNbH5DfJZaar+RD1v3SZjXNSj2oJxtrsHNpha+89TS6R?=
 =?us-ascii?Q?aN0tcZkf/j4NXbqSdrX5WuNje/pMlJzCSiNqDxyH9fmI/ik1yvLos4b076DT?=
 =?us-ascii?Q?HE+8OIMOLkd+4SPkoIj1cwkagHygZD0ZEJbvCVXy5XoRR63nVbz6y659xa/t?=
 =?us-ascii?Q?G3tPe7j7ce/jiE9xl6DsyaO4reXWPouAdoTKGWA5d8wYw5IuWA9m6zqJC7TZ?=
 =?us-ascii?Q?A+afKTPrR9q4bcU3HX8owYoTTDV2JOuXBo4098/wK44wOG2rphZiNnbg07pX?=
 =?us-ascii?Q?oyLJKS+Ox8ovaiNLNJf93o8Gkq5wWQ+/0oAxuCFiIkpkARlSObLyiSZGip7b?=
 =?us-ascii?Q?82UpXJfYBHpQKBAUEmcpUV3KAJzi2LjcwYgqNXweb5eRYcgK6Ldr9HC5+kEy?=
 =?us-ascii?Q?K2RPoDxXm2mxwVRqFCl7Yj3yXXqKOyFP4rmieDspr8v6kevY1tmcPlfHiaGP?=
 =?us-ascii?Q?UT4hgWmZyzKL9akdMfnlkQSIWExd8RaElFtMgPrRMbH8zYETF9s5YVL8ZNPn?=
 =?us-ascii?Q?gnfyH+xYkjJf6rbHfJfQ54e/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yxuk/8TjGbelmvLPrYG2F2N5eFduVx9a5CMwkmZftB1QbipxE+OTPYST0Rks?=
 =?us-ascii?Q?BXNG1Qz1Vrg+iAE9sHw8i+4XyzEoHCYT62YH81j72lw8r/UmXKJK74V1kOVn?=
 =?us-ascii?Q?DXiAId5egKcj74oYSl52DPq4cpE/0sImjMiK+c+QU2pqqDcXuQ5+Gf+OPaxw?=
 =?us-ascii?Q?eFa3cImGFYbPiSjK73Gakjda2cgpdERDzP51kWV412KzjWDgyH7el9DZuw47?=
 =?us-ascii?Q?1+wperPE/LFK8CzXzNh1oFqs4v3bsZFF7gD0TH50S8VwiEtfRsimTLajQaoH?=
 =?us-ascii?Q?oUyj8yBC0KAPRnysv2iDE2BXiSQIKfiSi5xWc0eT8FfMuGdgGzqVoTg3gxMs?=
 =?us-ascii?Q?fHoYyKUVcw6RaxetlqaLOCxYwUPAtO0BHe2Qun30U+8NdFDjElpPT6DXRBS5?=
 =?us-ascii?Q?/pBhHvPs2XtTGe8KqwmSqgohOyWjY7oB58uQQOkEdm209q8sNUTPMfq+MeC6?=
 =?us-ascii?Q?fTirJ7pxbFOZ3RV2WY6OvzqZlMrf3tvG33KDJY6Z6yhBQaVwOii/LhLXaG33?=
 =?us-ascii?Q?bS1vPzCsh4RGjuOEUnfPfVT5NU6l7qp9dsat8u/Id2LC5YhAzEOPMoRjIycP?=
 =?us-ascii?Q?ixVo4CuGgyUZfwPe/f3ieFKLHhn6UIluW4xbh8ypJZWmRUAGv1CWB2iJ65z+?=
 =?us-ascii?Q?t8owhF9I5vmpTWZZlPOCIbtFfimDckCBtG51MUpWCHqzdiow5vrA8+q45baQ?=
 =?us-ascii?Q?klN6nEndJbALko0xDlDuPVLT5P7u2y1MwlowhRWoGLxM4fswNJlYoYp9oA4o?=
 =?us-ascii?Q?nLteZa89QBnL6/cXG65L5eyxyp2pUd/sJ20eSNGpqG05AXc68EKZxTn6OnI6?=
 =?us-ascii?Q?6KiqPcnjc/mvwkpOHKmcYdtYNqM+K5V9r0peW77Cwu6JuRDxqNsTI4KE/hjF?=
 =?us-ascii?Q?7aR5pEsQl7RhCq47Nngh0mj2081tqW43Ij2M0isoAei+jEDxnd1o1GJEQ7OU?=
 =?us-ascii?Q?DusS9B0x/gTBYZvxYgfEWYySeg9zgmN9HwxKXPSmiioB06XdFjoRelArM9jk?=
 =?us-ascii?Q?9vz0JuMFuO1FsAI+vMnJRp+IjJlgpFyRTdD8hNGbwcIn1YWZ70SFp2d9Qrhx?=
 =?us-ascii?Q?/FoyHZ9+4SdTRdssiI77NJFUZlvItrx1621ssMEGQDctJnQfzwGnsBXT9Epv?=
 =?us-ascii?Q?/i2OcCQCWlou2cjSOeB04iueXGMUsv1BwxrICzZh019TfVw8Jv5ikP3tW0vr?=
 =?us-ascii?Q?1asDGsjA6m6iY90KZgedPawTjNKxswh00m2xDuKaWlM4Nm+AwMGofBujcfR2?=
 =?us-ascii?Q?aA7Kj0jr5kLHsMUoelIo76nMaHIcXOW8lVqJJtYD27x/HAzM5aiBJYH5jVCk?=
 =?us-ascii?Q?M8/M5cLXS/LED7VKqyE6NTYD/8iPuK2+a5+D29XtMRcWe8WncnCKSpGU3gM7?=
 =?us-ascii?Q?y8f+HxAYLTBqzsIAvZEvWzoqSkCxe2n7gI6TNL3EECVJ4Uk4Lkwp9WYuG2Jb?=
 =?us-ascii?Q?6NPE4kAO90tMpOrFTmhF2uMiHYwi4gMTcmsTMzNMMau2/ScU24h9lhm4tUjG?=
 =?us-ascii?Q?0ToSJ0uZ8v16p/+q1pCtdAd1+9qnE+tJc85G0sogHTBiWs/EXvPTE9Nkaqpr?=
 =?us-ascii?Q?LOb9OtuV7a+viyR+AoJvOnd/wrAFenXkbw3MJ86k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09557070-1230-40db-0c31-08dcf385f04a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:12:56.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKVrlc/pZ+eqKH48fxfTAZO2zINNEAp7SjIhXDK2b5ft0maJ/GSjyZLmarR0IfLt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171

An anonymous large folio can be split into non order-0 folios,
try_to_map_unused_to_zeropage() should not VM_BUG_ON compound pages but
just return false. This fixes the crash when splitting anonymous large
folios to non order-0 folios.

Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e950fd62607f..7ffdbe078aa7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -206,7 +206,8 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	pte_t newpte;
 	void *addr;
 
-	VM_BUG_ON_PAGE(PageCompound(page), page);
+	if (PageCompound(page))
+		return false;
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
-- 
2.45.2


