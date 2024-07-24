Return-Path: <linux-kernel+bounces-261378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB5593B688
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27421C22B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD41216A395;
	Wed, 24 Jul 2024 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="GMLtglCU"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010070.outbound.protection.outlook.com [52.101.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B716ABF3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845184; cv=fail; b=lHsR3I2nyFqs2XLCGXipetQkF8h8ssvKLnUWdmuVLVpJuodZwmZ2zDtOsIg4x6RkY3IPlUgHeCpIQqrQ1HLFeSTTAO9tpDZCUvGggONFbDtESqLC90KcmfbNkNHXnoJpEEoErEB2zz7nlDPU4GmzeqdqU1UK012EkmyVSLsvbAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845184; c=relaxed/simple;
	bh=Rwnq7j1+jNre1IHBnDoFS+XwXyV09MPKwqTfcCzIuOQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NLYFVSjX9OjD2zgt6qSXfKmRTajGEUkhp1bBgauyIreDv8IosuhkriVIMCy3W1zbTPMZ20ntQZHuPYff4VSDAQMnXBgF25ZAoYENjN6DbxdswShWeWmhWKns45HVvZw3SC5WaE8y6oeEfg9zSCBiq0oulJwMxFfm11P9fmKh/Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=GMLtglCU; arc=fail smtp.client-ip=52.101.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaIlin7A0MXxFYAhy2Mp3Mly1gXM3vF/BX2TuAozZwImBSU0ZuHn+YoqrQo+SbMV0ThCGYtXujY//Kn0x49qQJOgti5S7yw8GB5dQA79uGVhi8CdkM3aXBl1zWpwL8lV2Tqb2uZn10bH+826myeDiw99PytgNaa5956G5fCzPnwjb4ArLUbRl5VcfEKY+unB4dfQos/i8xqDKRZxRjeHNwR6+gU6c4gVLRk8u9wJFQocitrTZ//OPXq7GdveYSnYwpMZqRAnDZBqEjbXQ3VuzfQGNGhHwN5Ps++BBZhpNBkLGhByVCG3VVq5Y7nlpo4eX9llgUzqqHEtE9wjv8b/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1hvv6l6sPmJh55CzdkxaTUmd0k2dAxtpiFWX07CLTg=;
 b=K0PiJI0c57jcZhjUlfa6ko0Q7zRr7BAuPdZqDMPSvC30EgAv6GGiopfjTQtFJ79JRLqSdCFs2YQ9FUAHw+Y/MxtkQ0iX7Yj0UCngksX1vot3qP63nsVAMJ5XyZAglgf0jT8Ny2s8ByyopoIr1RlnsAuPXGqDRTLMi4UDQhrdZjKyCDFCn3nkQvsk6PXHRdjnGwcYExrhi2DQ7kPVoiz3jgGNXCDT44r87GdOPxOSsfn2DCu5KX9u/n7zJmSYvf4i80BF4nTUrCvAuwWuPOPlah8s5BjZgXujJicb6vSGgEPFYAMgbGDMzcSNyyGRKV3JgJ3TCTffGcPhhF1dqT874A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1hvv6l6sPmJh55CzdkxaTUmd0k2dAxtpiFWX07CLTg=;
 b=GMLtglCUsCHEFXj2o5bei+j7uPYli+hcHJLCET62P9ZG7rlJDUJnpYmxbg69v++Uvg16ceITfLOzVPQToqiAMeSj5z0p2+u0D3Gm2DPUSd4Vk0JVUoF+NR6iDxgxlqctG7cUjOGfK7VTBIeXF/PWynobs/e+2I57JAdl6NcodjE=
Received: from KL1PR0401CA0026.apcprd04.prod.outlook.com (2603:1096:820:e::13)
 by SEYPR02MB6460.apcprd02.prod.outlook.com (2603:1096:101:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 18:19:36 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::4c) by KL1PR0401CA0026.outlook.office365.com
 (2603:1096:820:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 24 Jul 2024 18:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 18:19:35 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 02:19:34 +0800
From: <hailong.liu@oppo.com>
To: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
	<urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
	<lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
	<mhocko@suse.com>
CC: Hailong.Liu <hailong.liu@oppo.com>, Barry Song <21cnbao@gmail.com>,
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1] mm/vmalloc: fix incorrect __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order fallback to order0
Date: Thu, 25 Jul 2024 02:19:12 +0800
Message-ID: <20240724181916.31776-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SEYPR02MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac32c98-091e-4e0c-9d30-08dcac0d2c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwO9aj0wDnauoAeo09mnb+eftJsQzgsE6z7VZAYEWjAEPLW0JseqK0ppOnwB?=
 =?us-ascii?Q?ZRHRMMUZ1PLTmCziiC4W4xi9Ah6u75+G+Roo5VQjh9TUhDuz46Q1v9gc8tYW?=
 =?us-ascii?Q?4B1zBRr9Rp/RKK97hvMm3SC+4wAzk/XndysxBVQTeqLpnWjp3nqgGfMnFBtH?=
 =?us-ascii?Q?KVzzfyubNPI9qLxZhB8lA3TvziyaViHVNrtGj6FBfH0cyAmgZ+JFP5taAurQ?=
 =?us-ascii?Q?0IVTwz6vRDL4hpLQpE8Hy9pK77OaU6LArOVipxUFWVjjDIOq6cEKYRT43TB7?=
 =?us-ascii?Q?cOROqE6EunX6T8UZrzUk1v3S+FLsLT4DUS3F0f2zDMDF1SiuBjK4sohB7Ubl?=
 =?us-ascii?Q?Fbqxr4tBxZpNqvwEySGmaqDSANU5YQyK4IHALF/C/IdRPAwHwMm6VO0OyjcL?=
 =?us-ascii?Q?xVJF+YWUkdslPxoab12JjP0UR+/6OjrNq92PFNTyyfyytpifchIDt8uJBIue?=
 =?us-ascii?Q?fKqpk+EeP0yujEzjp11Sx8BI5fsmP/pMQaXt0jmOzzKSldcxqFHUFciHlOMR?=
 =?us-ascii?Q?z5GlG+cfLk+d/cx4aqDkgifMELLmH5TJRl9ZF80YIifv7wtlA3j6QdE93fyo?=
 =?us-ascii?Q?NmVnTxxHFzmXbDTVxw39Ybhg7WpZLFXOJZZvVSXrkLJYcivjiRw3R2XKunCD?=
 =?us-ascii?Q?uvjYSPqzXA0qnVkSr3Cdb1OOyM8qMHx4boWBYGmdRmjwxpwMca2PHHQholj/?=
 =?us-ascii?Q?bimcYB7d7AynyH9jB6gyRNQ0ElVxMTT6eWnbC5YtI/JlfXqjEdm/AJdAFbcj?=
 =?us-ascii?Q?x37459BRRoxT2abeo8sDO4BYcv0EjAMAkZt4TTWJrUFIcWycFj4ld4KrGQ0w?=
 =?us-ascii?Q?2LoY9YoR8RcSCjqYig763kl74PJHA4qlDo1V7Egm4UvX0x1YuhrjrC/0eOIN?=
 =?us-ascii?Q?DLzSuk9jvwiUzT0kDC9g201+FIDnIFxXT7S9/pMrs6b6cnYXe8ZlwYH7wHny?=
 =?us-ascii?Q?R6ZdDoXFyey9s1utLNPi8DHDdpYQc0Hc3dYyXz8XtSAGaGPuF5KgEm7qk2Vc?=
 =?us-ascii?Q?5Tgyeh+ogtrBFMzBEOiicDHHF1FBdUHfD/VHZbgITmJzpBrTyQ7tzNONO2Li?=
 =?us-ascii?Q?VHqgZRlTZgJFUPnXVzSdXDM0v7+M+rQ8oJD6fR+KaFlTORDmhX8rSORb6YRh?=
 =?us-ascii?Q?Rbokw4XuW9/xwVtZSap57RFa2lgrmBe/bQXnu0clQ5LqkGuiJCS4TffnIjnK?=
 =?us-ascii?Q?BbxwLnVHAt6mLtgl2IsGal4z8Cc6hpUmP5bXtNoY6opm6K5CCVHgCXRqqm1u?=
 =?us-ascii?Q?vkVaTzzRei/qISLt0eHWB3r7Pe5fsxuzzi1IfBO4wDWnnEJwgXmaYQ3gh630?=
 =?us-ascii?Q?1X0GYOxOx23oKZduZte74yndGehKjAtWeFEUSsWD1lmXU7a9otSIuIqCWv+9?=
 =?us-ascii?Q?2rM1tojbPGFwx/3BlSK0pVUr5QwhOvAFoQWsg1VR8upk9vIyywk4AAz/kdjV?=
 =?us-ascii?Q?EHm7vt8a4cZhC5zDQQIuZ94zM1aFed5v?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:19:35.2764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac32c98-091e-4e0c-9d30-08dcac0d2c1b
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6460

From: "Hailong.Liu" <hailong.liu@oppo.com>

The scenario where the issue occurs is as follows:
CONFIG: vmap_allow_huge = true && 2M is for PMD_SIZE
kvmalloc(2M)
    __vmalloc_node_range(vm_flags=VM_ALLOW_HUGE_VMAP)
        vm_area_alloc_pages(order=9) --->allocs order9 failed and fallback to order0
                                        and phys_addr is aligned with PMD_SIZE
            vmap_pages_range
                vmap_pages_range_noflush
                    __vmap_pages_range_noflush(page_shift = 21) ----> incorrect vmap *huge* here

Fix it by introducing VM_AREA_ALLOC_PAGES_FALLBACK in page->private if fallback to 0.
Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")

CC: Barry Song <21cnbao@gmail.com>
Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
---
 mm/vmalloc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 03c78fae06f3..b35dfd3eeee3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -75,6 +75,8 @@ early_param("nohugevmalloc", set_nohugevmalloc);
 static const bool vmap_allow_huge = false;
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
 
+#define VM_AREA_ALLOC_PAGES_FALLBACK 0x1
+
 bool is_vmalloc_addr(const void *x)
 {
 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
@@ -604,8 +606,13 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 	WARN_ON(page_shift < PAGE_SHIFT);
 
 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
-			page_shift == PAGE_SHIFT)
-		return vmap_small_pages_range_noflush(addr, end, prot, pages);
+			page_shift == PAGE_SHIFT ||
+			page_private(pages[0]) == VM_AREA_ALLOC_PAGES_FALLBACK) {
+		int ret = vmap_small_pages_range_noflush(addr, end, prot, pages);
+
+		set_page_private(pages[0], 0);
+		return ret;
+	}
 
 	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
 		int err;
@@ -3583,6 +3590,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 
 			/* fall back to the zero order allocations */
 			alloc_gfp |= __GFP_NOFAIL;
+			fallback = true;
 			order = 0;
 			continue;
 		}
@@ -3608,6 +3616,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		cond_resched();
 		nr_allocated += 1U << order;
 	}
+	if (nr_allocated && fallback)
+		set_page_private(pages[0], VM_AREA_ALLOC_PAGES_FALLBACK);
 
 	return nr_allocated;
 }
-- 
2.34.1


