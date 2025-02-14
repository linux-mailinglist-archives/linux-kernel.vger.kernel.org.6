Return-Path: <linux-kernel+bounces-515228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4BAA3620A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2993B06D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D8267392;
	Fri, 14 Feb 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ci7u2Hfi"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415E2676C4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547760; cv=fail; b=j+HYMFBwxBAB2UNEUQMS9rhRcYXwpW5hIfLpgpEq0WTVvFcBFXosJABK4yMTnc0rbLSefp857OMyMYp4kSpDFkQpBOZcj7BaEDsp6L5vfCixagIXhGZFZcBFLYZJ3OA+JV/Nsm5SvWvynhYDe6KGNB+zbJ/HLZtzNMq/IuOxCos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547760; c=relaxed/simple;
	bh=lql8Nei02dbfEeakg5TomEwC5pnQFgdTeOZLMQYZoJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxABmj2OPHTXcSxll9doFRvVuYP1IG7yjQA/dFp70SUzjD2Gof2H9fgveq+u20gruE3i6HJk2AMrtVPt28zh+JPdoLDVoGEZ8wIYlJhNTHvgdyiBDts55+QxtxyETbVxK3IUm2Elx9NR+gGhvXfQbdTIwAHl0m3Rwp0UPHCvNaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ci7u2Hfi; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F219jN1nSLrc1ewgQmsWreXnS0qN07dXRH19/5kh3heFFKcHHZoXLOU9dIUn8c1716TgZ4zO+hmF1PZrmit4C/8N4Wef6x2jhYQBIVDGhumSMxDDGTyCCj1+3RnVSOHF6T93RiREU3E9LZzCbQGkfzd8keAFFj2f4Zx67/A9ZNMxoTkulrPzRnStZvGSskQmWBNoQg5//DSpG5z4TXKAc/MkLqar4LwZV9wv6eyIoy1YmcvkAhYjmEVD72RvPzWqQa6t7vwXxWl12mmmOaSFrSf/bWoKZnPum2PIv8DmIUfWi7sZMw/i9POjR2e5n5N4NqatQF9EliVCRDGBwtHWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntTrZU1dkPj7e+9hvcpJN+E38Z6MlqNiYO8Xs1Kokdo=;
 b=ow1DoD1FFbHMtagz00BMUYfOLOi3uItDcVFXjJsidRllqdNM3O9LSLtTM+2Y49VCbUr6u+0SbkJ4/oe32nnztTC23PtbS/HHxvoRS8hmGswAQzxqbjHnSpgnAzAxpL4EQbTdbuhQencXisrV5zZhO0mymzj5mvmyaTipb+e0ibKJFtK4vvnmY//vc0DAU/PnEOCVlS+DYQbTacUIs44msoEU2WpxqXuAE51m1rRS3Ns2EetJcyQ3G8oe60I37jbZS79b6AQpUsHIUjvGTnATrLwuXcCWsQ+6TcDepHk/7Rz7EhwYYvvjyRTSu3h6GW2Nd37C+pS9Nk+6DY4jszWJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntTrZU1dkPj7e+9hvcpJN+E38Z6MlqNiYO8Xs1Kokdo=;
 b=ci7u2HfiNm2fxTyUfcpBLspb4NMwuFfn53FmMoOa3cVp9Wur2WB+k91jjAKhcAIFRp+TIYm90NOcAVIJeMPFuisz9ocVquRxUTYSzgAcw+7oaZkF7ksteoHMSVhTu5ro2C0Lrc/wkpVlXLttrapKeiiFKxr4cr3X9MAvvpVSgVMhyLYuoNWssP6ekaXbBk8gGEUyWM0kxjhkZACfW0vV0oUX9g8vpoxTtxo5XdDajp+AxZFqgw+QM0GeecAQNp3Nu0wvPxucb7R0bqjv7w7wED2GXgjD75YvHQy5HW1wq1viQVMAJVP00k3ZX5QS+5tguC+EWItVYsTbqT3eOdo7xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.14; Fri, 14 Feb 2025 15:42:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 15:42:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 4/4] mm/page_isolation: remove migratetype parameter from more functions.
Date: Fri, 14 Feb 2025 10:42:15 -0500
Message-ID: <20250214154215.717537-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214154215.717537-1-ziy@nvidia.com>
References: <20250214154215.717537-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ddc0d3-dbc7-415b-9a3f-08dd4d0e3003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKiLafgzEcxGasXX4WJ+T58N+Vkq1lE/8UsAx/yRrlTL3dl4e1FnTOmIX3Nt?=
 =?us-ascii?Q?pO5DbrkBls1yDKhahmdZllkP4+RhFU1abYTqx30hOGhUeYORA7h12cqWCmIy?=
 =?us-ascii?Q?YKeZ0zkIHlSUOW4Df9aMB/sDMiY4yQPvCl0F/CwAshegbB0mmcF5UfoersUe?=
 =?us-ascii?Q?64TxE2NjBkC8CcvWL/9rD/czkt2Pslc6rK5+eAOYL0C14otlnjERpN/oDs0y?=
 =?us-ascii?Q?pRQgppqgzWlja63ibMV0TRjpDt/hITcD+AmOHUFoZ+bJ0FRC3oRlOWYiQZar?=
 =?us-ascii?Q?3U4ZqACq8c15b83cRVZhDJ4i1Lyv/h3kBrQN9bWhovE2tN6CFDTDM+1r9L0/?=
 =?us-ascii?Q?M4R0FsxaUZyW9maEcxzaXmRfEWQQOEU2bP/tZ388Sgj0rLACuzSXvVwFbOrC?=
 =?us-ascii?Q?BBWd6CrtBvZEZFHRZcT67Oe+v/1XocY6GfehvdRm9Z+9bg1sUEFkAnlho1FS?=
 =?us-ascii?Q?jhfIe5FzSWNPfIF86474h5enYI86yECDRMafqJen2V1L0nH91af2zemTKrG1?=
 =?us-ascii?Q?1x6Agl2cSOvxfTq4oadML7k7seBWsEchfZjHC4lNhgZoBbaVrQDnvEREtglC?=
 =?us-ascii?Q?Nbmf174H8nYCR8609K8Q13CqAmEHJBV9K5yLBYavHU9NhzT94NQzeHW0XcAP?=
 =?us-ascii?Q?hzY8VQvCTUO5GZoHDgosiSCq88XcVEl0IbcKAeNFrBNxDm++/PW+ongBqTSQ?=
 =?us-ascii?Q?nx5fmmrVksKIwMuXvE93qOByb7WFNwt/XlAq96bPvXova1Y1Q242SRrwa+HR?=
 =?us-ascii?Q?froSSeCvhRmERsv7vqljmVSIqp05U28uHDn8Qmx0atMcF3+8wV/KUsy1msO2?=
 =?us-ascii?Q?Ng5im03tHIqVDVRMHC23iHpbmMTJjzzEeP4CJPaeHRH5HZ28mxjZ54sXZ0MM?=
 =?us-ascii?Q?C+13anoUM+o+9dZjbj9Uo87aTpNF4AqGGWtBgB/wZpscSOwmd4tpPwHxl0CS?=
 =?us-ascii?Q?G9m1Etl9mcvhmPTweSTSBLlF0nLv9MKTt9JmGhj+wbfKazEqTga/os4za6hN?=
 =?us-ascii?Q?BN1PntAcItESMgwcVt7YdzOBtq4AIXBD3tvSW79TxQiV23kdwrtnZOe8i8gX?=
 =?us-ascii?Q?EF/D7CwtSxPnpPuFcMQbHqQNCpPtYPQnnrZ8hZQtJZTbHotj954w0pC+o3uw?=
 =?us-ascii?Q?2OSijBGgeoLQwLFAkyk/S7IAdq08+2+za0hL2K/6+ZtgDVLaPPGYC4SvaxJX?=
 =?us-ascii?Q?Lmgi2Z69zHk9iUETFSRt6KizAPNHbanWcMgO+r3vzHr6miBJfWfe2gSWo4WQ?=
 =?us-ascii?Q?90FI5CepQUlMEhwkUxjWVuS5T70cd7ghEnRF664hWeEvzb99ooaCAb6n2/hk?=
 =?us-ascii?Q?T7Of3CXRWKyx9C9ZTM5GOluEn7mX/BgeLygKLGKK1ladu2sb6WNICG6lcQBV?=
 =?us-ascii?Q?QIdXWFxNF3es8V+tCNL2U1CLqrt8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83bCZOOujte+2mhOpmxOhjB2UFeIGjxK4z1r2PtjFBIromFRQssIdZn4YpEt?=
 =?us-ascii?Q?qKEPwTw4DHHRHy/d2n29feDVlegCM9j0Q1pbZEqAcx5uAuLWDIrYQBAqQaSk?=
 =?us-ascii?Q?/vKJbJbuMDmkXQgVc0Y7fqYzVRz0y4FJIP3zXjTGtQl8YgVuKGcvLPlPyuLd?=
 =?us-ascii?Q?62558SEzLfXtz+j2DuL68vAR6V/ESq7wy+i3zAE98zRIjDka+0LtQY3B1z9g?=
 =?us-ascii?Q?qXsmz/URC3l8elrkHFwhysreC1c4zFgUuyEeugibK/4ueDrsWVGdy9zQ6TUt?=
 =?us-ascii?Q?V7RDnSvWzQtnBtmRgcKeKpA4gIlsUN0O1jKgB935LDfptuH/jNOX/dzGktp/?=
 =?us-ascii?Q?0Y5dRCzpEskp1EH2b56+5akm9TjU6g99cfZRkKDkLh0RIQDbAuh9a8srYpxh?=
 =?us-ascii?Q?jO+9egpLG0Hlkl5uuAjWRRjey97qANQDI2C4XvXafxipS4kRnH0zGA2xf+xk?=
 =?us-ascii?Q?/W2a+j6+ZzPoVP5bEglisoMKSdXCohC+4pqN5YUqIV00IAGh+BC/FnQnkz7y?=
 =?us-ascii?Q?848v0gNe0RvJE3Bs0MmFrKRdj/Jwlhwpv6h//uUqe5z9scpBEwki9NI9mru2?=
 =?us-ascii?Q?0x7LGCY0c0ZeCXEwoUwAtUblh89Q/cpjZy4heQlNMZVmFGaFQZjjpe+N8w0q?=
 =?us-ascii?Q?AU8BmC66YXksSo9t4v3vcXmJzyg0TAIWvMIda/pg3YvqIgvoqrTKDkz43oJi?=
 =?us-ascii?Q?ZnWJqnNCxCv7phF7uF1gPkKGcn+O1o4TGSSAR/c0NNE2geR3o28TrUE0Gcpk?=
 =?us-ascii?Q?AUuLa4Q215gn772OxrCIcQMppApPKSaVs5WmXUcc8DOW7TU0ulzCMilJwmbf?=
 =?us-ascii?Q?aJQZUloTBwJVelTaICg1EvWeXEXRgz7gh5PtHBgSHed4+suSHsBdxxY9vam9?=
 =?us-ascii?Q?hml/E8z003iXPBJakkh56X6EnYkDuIJnQtjr34j4iGUvR8/xmaygWJfA+kro?=
 =?us-ascii?Q?vk2A23VzlNMqpNZuq2J2N1IPIBSM8V3556rcURSWb+qpm80XvXg6FCeZXnm/?=
 =?us-ascii?Q?uxyr6VHSuE5j2+6jBlOdhXyUH1VOfCl87DW4P+STuyvLrUeFRdAcynFXPhNA?=
 =?us-ascii?Q?BeVARPB+mv5nRoVQzuoC2HHx/Yz42M5oJrKsu9ux4XjUhedvHi7VS5s30Exx?=
 =?us-ascii?Q?Y+/JRigRholeE6kbqSGjmdAQDJEdI/UBjM1GIvg9cj0A3+Xc12vhZh7QAiwT?=
 =?us-ascii?Q?5q9Tls2jLFAbBICwizLCVim+sLF0xd7n2wCuLc+P6/UrHP8OWuB8o1rAflN6?=
 =?us-ascii?Q?GJilRwTl0LlqcM5bfooGfQfDfNKLz+QzpTplHD8MBU9JWrOpplF3Jg8erUfW?=
 =?us-ascii?Q?SRCuLazV1OSubFE2Rmq0WxOzUNDjrYCbWpNQ8NKU+aVsUOpfkhp58rel1KEc?=
 =?us-ascii?Q?D23opXai2gPFly6rMsEMleKjhUih49ig5V667THV1Gex/Mb3p9pE4LwywXjW?=
 =?us-ascii?Q?fpzjwD1u1FomJ5/3uqA/6XNmGReH5jy2UAha+kYUt+gHLxTLb7Ti9tNPm+Jn?=
 =?us-ascii?Q?D3lA6deuJlsFQM7FeDDApFqq6ajO1bwMneoMZ0TLnuNJ6ZVJkH5k604bcVt/?=
 =?us-ascii?Q?deTpiDVO6oAd56nD2CeHMT3WYyoJcj/XwnZkXoha?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ddc0d3-dbc7-415b-9a3f-08dd4d0e3003
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:42:28.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGNxs7rnmp4Sv+oUppsNiziBhZjeVp+CAmRh0pVL/LDCn0yEJFfHlCJlJsja8EVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

migratetype is no longer overwritten during pageblock isolation,
start_isolate_page_range(), has_unmovable_pages(), and
set_migratetype_isolate() no longer need which migratetype to restore
during isolation failure.

For has_unmoable_pages(), it needs to know if the isolation is for CMA
allocation, so adding CMA_ALLOCATION to isolation flags to provide the
information.

alloc_contig_range() no longer needs migratetype. Replace it with
a newly defined acr_flags_t to tell if an allocation is for CMA. So does
__alloc_contig_migrate_range().

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c    |  3 +--
 include/linux/gfp.h            |  6 +++++-
 include/linux/page-isolation.h | 15 +++++++++++---
 include/trace/events/kmem.h    | 14 +++++++------
 mm/cma.c                       |  2 +-
 mm/memory_hotplug.c            |  1 -
 mm/page_alloc.c                | 33 +++++++++++++++----------------
 mm/page_isolation.c            | 36 ++++++++++++----------------------
 8 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 8a294b9cbcf6..160c681028d2 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1243,8 +1243,7 @@ static int virtio_mem_fake_offline(struct virtio_mem *vm, unsigned long pfn,
 		if (atomic_read(&vm->config_changed))
 			return -EAGAIN;
 
-		rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
-					GFP_KERNEL);
+		rc = alloc_contig_range(pfn, pfn + nr_pages, 0, GFP_KERNEL);
 		if (rc == -ENOMEM)
 			/* whoops, out of memory */
 			return rc;
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6bb1a5a7a4ae..ff1965561d48 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -400,9 +400,13 @@ static inline bool gfp_compaction_allowed(gfp_t gfp_mask)
 extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
 
 #ifdef CONFIG_CONTIG_ALLOC
+
+typedef unsigned int __bitwise acr_flags_t;
+#define ACR_CMA		((__force acr_flags_t)BIT(0))	// allocate for CMA
+
 /* The below functions must be run on a range from a single zone. */
 extern int alloc_contig_range_noprof(unsigned long start, unsigned long end,
-			      unsigned migratetype, gfp_t gfp_mask);
+			      acr_flags_t alloc_flags, gfp_t gfp_mask);
 #define alloc_contig_range(...)			alloc_hooks(alloc_contig_range_noprof(__VA_ARGS__))
 
 extern struct page *alloc_contig_pages_noprof(unsigned long nr_pages, gfp_t gfp_mask,
diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index b8b44d3aacd4..709a807202e9 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -22,8 +22,17 @@ static inline bool is_migrate_isolate(int migratetype)
 }
 #endif
 
-#define MEMORY_OFFLINE	0x1
-#define REPORT_FAILURE	0x2
+/*
+ * Isolation flags:
+ * MEMORY_OFFLINE - isolate to offline (!allocate) memory e.g., skip over
+ *		    PageHWPoison() pages and PageOffline() pages.
+ * REPORT_FAILURE - report details about the failure to isolate the range
+ * CMA_ALLOCATION - isolate for CMA allocations
+ */
+typedef unsigned int __bitwise isol_flags_t;
+#define MEMORY_OFFLINE		((__force isol_flags_t)BIT(0))
+#define REPORT_FAILURE		((__force isol_flags_t)BIT(1))
+#define CMA_ALLOCATION		((__force isol_flags_t)BIT(2))
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
 
@@ -31,7 +40,7 @@ bool pageblock_isolate_and_move_free_pages(struct zone *zone, struct page *page)
 bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *page);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype, int flags);
+			     isol_flags_t flags);
 
 void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn);
 
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index b37eb0a7060f..a29471d33566 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -304,6 +304,7 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+#ifdef CONFIG_CONTIG_ALLOC
 TRACE_EVENT(mm_alloc_contig_migrate_range_info,
 
 	TP_PROTO(unsigned long start,
@@ -311,9 +312,9 @@ TRACE_EVENT(mm_alloc_contig_migrate_range_info,
 		 unsigned long nr_migrated,
 		 unsigned long nr_reclaimed,
 		 unsigned long nr_mapped,
-		 int migratetype),
+		 acr_flags_t alloc_flags),
 
-	TP_ARGS(start, end, nr_migrated, nr_reclaimed, nr_mapped, migratetype),
+	TP_ARGS(start, end, nr_migrated, nr_reclaimed, nr_mapped, alloc_flags),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, start)
@@ -321,7 +322,7 @@ TRACE_EVENT(mm_alloc_contig_migrate_range_info,
 		__field(unsigned long, nr_migrated)
 		__field(unsigned long, nr_reclaimed)
 		__field(unsigned long, nr_mapped)
-		__field(int, migratetype)
+		__field(acr_flags_t, alloc_flags)
 	),
 
 	TP_fast_assign(
@@ -330,17 +331,18 @@ TRACE_EVENT(mm_alloc_contig_migrate_range_info,
 		__entry->nr_migrated = nr_migrated;
 		__entry->nr_reclaimed = nr_reclaimed;
 		__entry->nr_mapped = nr_mapped;
-		__entry->migratetype = migratetype;
+		__entry->alloc_flags = alloc_flags;
 	),
 
-	TP_printk("start=0x%lx end=0x%lx migratetype=%d nr_migrated=%lu nr_reclaimed=%lu nr_mapped=%lu",
+	TP_printk("start=0x%lx end=0x%lx alloc_flags=%d nr_migrated=%lu nr_reclaimed=%lu nr_mapped=%lu",
 		  __entry->start,
 		  __entry->end,
-		  __entry->migratetype,
+		  __entry->alloc_flags,
 		  __entry->nr_migrated,
 		  __entry->nr_reclaimed,
 		  __entry->nr_mapped)
 );
+#endif
 
 /*
  * Required for uniquely and securely identifying mm in rss_stat tracepoint.
diff --git a/mm/cma.c b/mm/cma.c
index de5bc0c81fc2..e4ad8a5f8bde 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -461,7 +461,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma_mutex);
-		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
+		ret = alloc_contig_range(pfn, pfn + count, ACR_CMA, gfp);
 		mutex_unlock(&cma_mutex);
 		if (ret == 0) {
 			page = pfn_to_page(pfn);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fb2216f267d8..b69fb43c5ac7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2018,7 +2018,6 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
-				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
 		reason = "failure to isolate range";
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4b251aa35b73..3a9328f7b2e7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1913,14 +1913,15 @@ static bool __move_freepages_for_page_isolation(struct zone *zone,
 		return true;
 	}
 move:
+	/* use MIGRATETYPE_NO_ISO_MASK to get the non-isolate migratetype */
 	if (isolate_pageblock) {
-		from_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
-				MIGRATETYPE_MASK);
+		from_mt = get_pfnblock_flags_mask(page, page_to_pfn(page),
+				MIGRATETYPE_NO_ISO_MASK);
 		to_mt = MIGRATE_ISOLATE;
 	} else {
 		from_mt = MIGRATE_ISOLATE;
-		to_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
-				MIGRATETYPE_MASK);
+		to_mt = get_pfnblock_flags_mask(page, page_to_pfn(page),
+				MIGRATETYPE_NO_ISO_MASK);
 	}
 
 	__move_freepages_block(zone, start_pfn, from_mt, to_mt);
@@ -6382,11 +6383,12 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
 
 /*
  * [start, end) must belong to a single zone.
- * @migratetype: using migratetype to filter the type of migration in
+ * @alloc_flags: using acr_flags_t to filter the type of migration in
  *		trace_mm_alloc_contig_migrate_range_info.
  */
-static int __alloc_contig_migrate_range(struct compact_control *cc,
-		unsigned long start, unsigned long end, int migratetype)
+int __alloc_contig_migrate_range(struct compact_control *cc,
+					unsigned long start, unsigned long end,
+					acr_flags_t alloc_flags)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned int nr_reclaimed;
@@ -6458,7 +6460,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		putback_movable_pages(&cc->migratepages);
 	}
 
-	trace_mm_alloc_contig_migrate_range_info(start, end, migratetype,
+	trace_mm_alloc_contig_migrate_range_info(start, end, alloc_flags,
 						 total_migrated,
 						 total_reclaimed,
 						 total_mapped);
@@ -6529,10 +6531,7 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
  * @end:	one-past-the-last PFN to allocate
- * @migratetype:	migratetype of the underlying pageblocks (either
- *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
- *			in range must have the same migratetype and it must
- *			be either of the two.
+ * @alloc_flags:	allocation information
  * @gfp_mask:	GFP mask. Node/zone/placement hints are ignored; only some
  *		action and reclaim modifiers are supported. Reclaim modifiers
  *		control allocation behavior during compaction/migration/reclaim.
@@ -6549,7 +6548,7 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
  * need to be freed with free_contig_range().
  */
 int alloc_contig_range_noprof(unsigned long start, unsigned long end,
-		       unsigned migratetype, gfp_t gfp_mask)
+			acr_flags_t alloc_flags, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
 	int ret = 0;
@@ -6590,7 +6589,8 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(start, end, migratetype, 0);
+	ret = start_isolate_page_range(start, end,
+			(alloc_flags & ACR_CMA) ? CMA_ALLOCATION : 0);
 	if (ret)
 		goto done;
 
@@ -6606,7 +6606,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	 * allocated.  So, if we fall through be sure to clear ret so that
 	 * -EBUSY is not accidentally used or returned to caller.
 	 */
-	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
+	ret = __alloc_contig_migrate_range(&cc, start, end, alloc_flags);
 	if (ret && ret != -EBUSY)
 		goto done;
 
@@ -6683,8 +6683,7 @@ static int __alloc_contig_pages(unsigned long start_pfn,
 {
 	unsigned long end_pfn = start_pfn + nr_pages;
 
-	return alloc_contig_range_noprof(start_pfn, end_pfn, MIGRATE_MOVABLE,
-				   gfp_mask);
+	return alloc_contig_range_noprof(start_pfn, end_pfn, 0, gfp_mask);
 }
 
 static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 095cb2152fae..c39b51e96186 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -31,7 +31,7 @@
  *
  */
 static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long end_pfn,
-				int migratetype, int flags)
+				isol_flags_t flags)
 {
 	struct page *page = pfn_to_page(start_pfn);
 	struct zone *zone = page_zone(page);
@@ -46,7 +46,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 		 * isolate CMA pageblocks even when they are not movable in fact
 		 * so consider them movable here.
 		 */
-		if (is_migrate_cma(migratetype))
+		if (flags & CMA_ALLOCATION)
 			return NULL;
 
 		return page;
@@ -151,7 +151,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
  * present in [start_pfn, end_pfn). The pageblock must intersect with
  * [start_pfn, end_pfn).
  */
-static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
+static int set_migratetype_isolate(struct page *page, isol_flags_t isol_flags,
 			unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct zone *zone = page_zone(page);
@@ -186,7 +186,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 				  end_pfn);
 
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
-			migratetype, isol_flags);
+			isol_flags);
 	if (!unmovable) {
 		if (!pageblock_isolate_and_move_free_pages(zone, page)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
@@ -296,7 +296,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * @isolate_before:	isolate the pageblock before the boundary_pfn
  * @skip_isolation:	the flag to skip the pageblock isolation in second
  *			isolate_single_pageblock()
- * @migratetype:	migrate type to set in error recovery.
  *
  * Free and in-use pages can be as big as MAX_PAGE_ORDER and contain more than one
  * pageblock. When not all pageblocks within a page are isolated at the same
@@ -311,8 +310,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * either. The function handles this by splitting the free page or migrating
  * the in-use page then splitting the free page.
  */
-static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
-		bool isolate_before, bool skip_isolation, int migratetype)
+static int isolate_single_pageblock(unsigned long boundary_pfn, isol_flags_t flags,
+			bool isolate_before, bool skip_isolation)
 {
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
@@ -338,11 +337,9 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				      zone->zone_start_pfn);
 
 	if (skip_isolation) {
-		int mt __maybe_unused = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
-
-		VM_BUG_ON(!is_migrate_isolate(mt));
+		VM_BUG_ON(!get_pageblock_isolate(pfn_to_page(isolate_pageblock)));
 	} else {
-		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), migratetype,
+		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock),
 				flags, isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
 
 		if (ret)
@@ -441,14 +438,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  * start_isolate_page_range() - mark page range MIGRATE_ISOLATE
  * @start_pfn:		The first PFN of the range to be isolated.
  * @end_pfn:		The last PFN of the range to be isolated.
- * @migratetype:	Migrate type to set in error recovery.
- * @flags:		The following flags are allowed (they can be combined in
- *			a bit mask)
- *			MEMORY_OFFLINE - isolate to offline (!allocate) memory
- *					 e.g., skip over PageHWPoison() pages
- *					 and PageOffline() pages.
- *			REPORT_FAILURE - report details about the failure to
- *			isolate the range
+ * @flags:		isolation flags
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
  * the range will never be allocated. Any free pages and pages freed in the
@@ -481,7 +471,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype, int flags)
+			     isol_flags_t flags)
 {
 	unsigned long pfn;
 	struct page *page;
@@ -493,7 +483,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 
 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
 	ret = isolate_single_pageblock(isolate_start, flags, false,
-			skip_isolation, migratetype);
+			skip_isolation);
 	if (ret)
 		return ret;
 
@@ -502,7 +492,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
 	ret = isolate_single_pageblock(isolate_end, flags, true,
-			skip_isolation, migratetype);
+			skip_isolation);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start));
 		return ret;
@@ -513,7 +503,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	     pfn < isolate_end - pageblock_nr_pages;
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
-		if (page && set_migratetype_isolate(page, migratetype, flags,
+		if (page && set_migratetype_isolate(page, flags,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(isolate_start, pfn);
 			unset_migratetype_isolate(
-- 
2.47.2


