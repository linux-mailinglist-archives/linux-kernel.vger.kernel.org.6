Return-Path: <linux-kernel+bounces-388073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93D69B5A26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277D3B22258
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6A19259A;
	Wed, 30 Oct 2024 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UtTfJl4z"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB79454
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730257291; cv=fail; b=KwZmZ0K6Q8luLz0nW0h39YqAdj5MHQl9SyxAaSQL9hymeWhDGynRADZM0Kjx8GCXEB3NMujfwliKQxUbMk6Fi6sEmsnjMLHAwciIzGx2QRh43qHXSCHyvdj+aWh6WwHGzJGGBeU92XiSxyZhhXGeadHrwXN2quM7LfTnnxc65fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730257291; c=relaxed/simple;
	bh=Lr581pLFgp/MiYAPVCyGUBJPvsazJbSRcq4lgLWZOpo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ebPiANA2+0cDuq0XFiwT9eI/81P5AvTJmC1nDge8l5+K1F9031nPmxfFWGLGII34OZ4gpG/6YCBHdlanjO2AZ7eYUAN1I18vVrt07KPzXIbHOYXbWoQekJk5ttWe77VaRSIo8HLLltut1mWM4c3ZNScEnPZTDfqSJ7mzwJV4BU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UtTfJl4z; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERFq5HpELdEvFeHRkX1fDaaKNPWxSKGgwfzd84nXVGV2jBLsfhpwtCVrSyT1fYJlFBN+Yw5fnlFfZNBgW9DIiEXm9qX6j/AhokSGMeJ67Rz8lZXreB+diOaYsWSkackRBI1IWU7tdEZnkMpozHNKGH4OERnzHiP7ejJufDoA/bExY2H3hFtx4dbN63uheHqq/cgy5yErco2H+JJ0G+HQ6c+rZk3yynlabqZ/aWscykiaE8wZ62G20ir2/oKQdAO/QVziNKWejdjCOg4GliE3DjBdTv7IQoWRFm8eKv3PCzqaV25XjqFQe7g5KoUn9lm0HbL3EJN/scca/dm3wh5uaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL08yHeylUs0GdLn4moveH2FIqZLD6DzHQASfZmcSMI=;
 b=Hpuw1SS/xPhhZnujEaps5q94NJXqecOvNVmmNpEFR+MAcHVtIp6CyWzclX2c97yIPF/tFgYsrzNjYJ2RdJN6MvKRXgAO2onxYzrNdeBBNslUcSPMGyiclyIiwFtt4T3q/5U+S4sKjMhyiyXdLxj+y17YnWW3hDwRUkJpj+2ojqhhVp43v20/obYg5oMyETXitDXIEbUwAz+TAtUGngkGuBbAhZVJ3mYulL9EDY6jTVOOTrjY7zml3ZEWq5nXbT5bUa3Ei4t0FnKDlKAywoFrSP8NF9iWF3q1qM1TR7J/61e+jLpqTkkVLZ6KFBCZ8VjgxMweTThcR2ZE638iiShfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL08yHeylUs0GdLn4moveH2FIqZLD6DzHQASfZmcSMI=;
 b=UtTfJl4zfJaWbjcu+JRiFN9IG+Ouaac6cIi7V4tvkBoFU3gm8rvFkmBGbeV+Ki5223MDgfZl7gNPwG8Cf9BDPUiHUgVCCHz3CnDIIkl1bdi4E9dqxAt2LgxQdmE/kDp0AIePInjioqEbdSpI53OBKWvskXJGPbJPp1R3tsc3VN/kNuoXQJFnKC/HInyrSzMx7YnO2m4sD1MESy5pgNmnzq0QShmMzWSGEnWClCuqmiaxpZFr9Jes3sPb7Bp3AWs0mpT18R7UZGV2wuw2WjH+5YgxO+Wtm1Vuoj17rf+P9poJxYxaFCIKyqruo/rFzlLY427Rv7wxMHyn6XckN4safQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) by
 BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Wed, 30 Oct 2024 03:01:21 +0000
Received: from DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579]) by DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579%7]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 03:01:21 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	linux-stable@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm/gup: restore the ability to pin more than 2GB at a time
Date: Tue, 29 Oct 2024 20:01:16 -0700
Message-ID: <20241030030116.670307-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To DM8PR12MB5462.namprd12.prod.outlook.com
 (2603:10b6:8:24::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec510dd-ab0c-4fa5-bf06-08dcf88f2215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xR9eDEcT7XaNy+WoTkkK24SUpfbEIo2CQBmVMF9Qa+rEtepBlsCUnh/xxwhq?=
 =?us-ascii?Q?dsTZThIWdpE2PCwbodxFTN7bWLOwbdxzuUxpMeGxID9fq2H+j2xoSAV4Rhmo?=
 =?us-ascii?Q?+QaSAnx4n4UHuNhWtvJARAESfFyIJK2bLl8sKKolup08pkis8PJZZqj54+Lv?=
 =?us-ascii?Q?/dN/ks6WAmb5j16clQqVSZ8ve2Y6hYghm3laQdbxv0knUKqamXg5BCatmGn4?=
 =?us-ascii?Q?iDIrMuLA+A4B26QFF3krV4NthM66PRwtxtLqV/ANAfzVZn5HxA+YKRrTiKKZ?=
 =?us-ascii?Q?mEY/N/I25FSzJVCX0M6jNDSO8yi0ygJ8F4uDGsCACHKYzsmmDCDTh9m64cjW?=
 =?us-ascii?Q?aItmybIZd1/YoSwM/95I8Lw3Qdq2ZK0wxoNzw3LNaSB3HsIkKq9Pl8Kqt9RR?=
 =?us-ascii?Q?CPwYqmx/F0sp0auceyTQ0jqXNZTghk1E9FaFH+O5mvmdBOY4G/LwUEJ3YBSj?=
 =?us-ascii?Q?JwMf1okHrI0TnKSAxRqzXxSKCcteLVJ0enNl8sqlDd9dKV/djfr6qfmUiyKx?=
 =?us-ascii?Q?eYg2JAhdSRAM7rA6Vdpel0aXP3Ta45UsFZAvi5HwHJb5BxU20b+yK4XeGR8s?=
 =?us-ascii?Q?S3Lals0oNl8Sov8yvU4mJqXoCFSMDMBTtPqROI8WX8++dI5TYjyfb1psEZkU?=
 =?us-ascii?Q?e6u2Tgn0X811fgjG2woPUaYA0cD1p+83L+oCJIoBsO7RSTw9RUqVVwZNRG8L?=
 =?us-ascii?Q?TIU1AM1yVJR20oub/N/iqUwoqVJ3eft5H3t1dfK6OlgVGz0t5rlRBNhIBPsD?=
 =?us-ascii?Q?tQ2sJKkhrguA2+nXI3B8J90n/A9rIMdAqaSVBq4lyWYj8t1Xxdlmv361pEZY?=
 =?us-ascii?Q?mhT4pXOzGBm9vWnslxuNHFWqz8rg81uHymFNxupQ+TwZIdvqJUhMxdXzbMb+?=
 =?us-ascii?Q?MiLiTTGvWU7rWdPRqRlRKqoyLSVjKPrk99P8bXZ+gKX9AlMkT77OpTWnBYZg?=
 =?us-ascii?Q?sIUEGnD09/FlhrAeT1dyUTfHBa3rzYwd5O8xf72fBuiRWpdD9zTX87/w1UDM?=
 =?us-ascii?Q?mSRrYVj0ImE6o6S5i5xdhyItpEWkZqj0Hs3200V58S+tpRXh4jn6CLFbEAuF?=
 =?us-ascii?Q?k4no8kxXfjSYLTVOa0F5dCnTKjLOu+d0PqeEaDXoarB4xn7Xhf5C2hb0Cuww?=
 =?us-ascii?Q?pNz0ouO3JPzx06PXDxT8uSNwOXuQVq/irq2dPvNw/gebM3mPC3BySK/nq8uF?=
 =?us-ascii?Q?f6n8sYmD86SQ/kY2RswcuRK5XwSN+2mcLRx7Ctf7DSnW8ODe9vtb288zOMIS?=
 =?us-ascii?Q?Fp4+OpKEEM+sRFhJvWqym8+ngZC/+13huf1mmPlXqN5NdFao1yMrnxTNVn1y?=
 =?us-ascii?Q?gyaDN8hxqhIox+7aMqBKmBuo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5WEi9BEgNdVC4mFlr4SEQ4mKEuVKmEM3fsKlemR2Ov8tXpvDGXnQoTd2Y6h?=
 =?us-ascii?Q?JD8WC4SdtQ1QPwCaiV1dlFwGgj4rD0R2QCBTHBhyk7RZ7FAlCJ8yYWbsmrJq?=
 =?us-ascii?Q?nUxgt4eZnimatMD7Bl260VucjMpYIxZS6fLHA8BwhXwvht3B6yk0NJjR22YD?=
 =?us-ascii?Q?YbVDnQuhTpAqz0WKrYH74+C4Ry0Vag+gHdlZ3pgidPVGkm9FSI9nvNxAj7yL?=
 =?us-ascii?Q?74kB3W62XeRgsqPJowTte62lyl6qFyUMuTTQfJe1pc2hYSUoc0NfjEuxgZ2f?=
 =?us-ascii?Q?DuNUV9woYkaW4zpEvZay1fPb56928+OUlqunCA3lLGT7j3PeyXTLrUfrYYlv?=
 =?us-ascii?Q?VvKur+pm6/+9QZGQ92a8NW47M1we5yxIWkyuQMvl/vrvMRVbt9SH0MMAe9er?=
 =?us-ascii?Q?EtXH7R8TZqPfNgmRqh0rTGIhyhSyCDj8MfQZS1fvUGNFRUObn/li64iYaE+O?=
 =?us-ascii?Q?GuBGiIZqCwaQzU2ZR6W8lIt5SbCjnVTlAUdUyZOJ5PJiA4cCf4VwgNDcLeIS?=
 =?us-ascii?Q?J5JmCt7RMP+nW4wJevz5IdOdUME+3EJtvoRo5KpukVzNsRDIyiISvzQESZrc?=
 =?us-ascii?Q?5Vf5sfzZLfvEZwMAVkrfzhfdPqB+fL39uJqrqhO4Ok2/7F/l7uOx13AFVeQX?=
 =?us-ascii?Q?tNZCG20dySyTgsd0rrmmsAWeOci5ssfyD7V0VjqLHE6s0U30B6mSKDMgu3Q5?=
 =?us-ascii?Q?bluSEhkBphYlO3d1by9AmSIC+QSHCY5msnsHnlf/GNa8FsTTYAP1Kx3Rce29?=
 =?us-ascii?Q?bl08kwXMHHwfjIne6jvMBDJIIL0eLaU7Iva6e2CkcdBbTygdeRVx7tNWzcsE?=
 =?us-ascii?Q?3+x4AF5s5aNjLVOHpocuE+nMwO5z6JQ1WmRcTq8RQa9l+oBYk5CLYyR665oV?=
 =?us-ascii?Q?N2X48F6dBuords0w5DPOXRwSzWXdmi1kLzYl07pDZQpFvdDRUShXE0cH+UEQ?=
 =?us-ascii?Q?0kzd0dNyhTxMsYikqaM6xsW+t+BIOMW0+YTO3faLZ/zu+G84qZgQ6d6p7v6O?=
 =?us-ascii?Q?DZ6ezx4qc3f2WpKa4WQOrmBvdEuB4BUpMzkrz1QMFWUPYbEAhat3jBtjA0rR?=
 =?us-ascii?Q?udsyl9BgEOUE7WOzLiWXCRfbkYav3z69GReQEyfZkO051sFooxLPxf/a7SNT?=
 =?us-ascii?Q?Kv6zLAXeQ347WMTYVusbeu6wVFJGJfGg+IHT66yaUNPII6qcfOahokL69qN/?=
 =?us-ascii?Q?iospmv2Dm0GmwZ4X6E/lmXU/UAzuU3yQ2rzuGWHmX2BTHG6sxixNO+QTdNfA?=
 =?us-ascii?Q?Teqtn9RBmy8brH1Fr7d+4uBsEAl/X6vAtXRh5n+PllmLYt99OJ+/iOn64Cle?=
 =?us-ascii?Q?4G57ARmuycUHJJqiMxbJbS/LlhuMKBrmMj7MTt+DVjxMthso/0IV6Jq3RQl4?=
 =?us-ascii?Q?SjQrNNDHXT6BRShD87UEEyb6/OjXQu1tfzxdoMpfUKpB+JBwEcVPeOo3JxZ4?=
 =?us-ascii?Q?c6n30KPT3pWDx7aRyqC4e+aZL1hYNqstAd6Q1zxfRRETAYk7m7BxOiIWF7mJ?=
 =?us-ascii?Q?1cTmL8oZfI3Ngnp3QgKqusMbODf/1NkluAQo79xkhzVjIeEBPu068As4nXqP?=
 =?us-ascii?Q?NZVAs/soZkX2UXOq0JutubZ+RNJlODFL+7iK8wf9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec510dd-ab0c-4fa5-bf06-08dcf88f2215
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 03:01:21.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G3jj0OMARuzViLxc4tnJqKAU/VbrOZLahOzhuMtVAcATlg7oao5/g/fwekJai3zAYiPsnu7jO97XWia7SSn4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463

commit 53ba78de064b ("mm/gup: introduce
check_and_migrate_movable_folios()") created a new constraint on the
pin_user_pages*() API family: a potentially large allocation must now
occur, internally.

A user-visible consequence has now appeared: user space can no longer
pin more than 2GB of memory anymore on x86_64. That's because, on a 4KB
PAGE_SIZE system, when user space tries to (indirectly, via a device
driver that calls pin_user_pages()) pin 2GB, this requires an allocation
of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
kmalloc().

Fix this (restore the original behavior), by using replacing
kmalloc_array() with kvmalloc_array(), which falls back to vmalloc() for
larger allocations.

Fixes: 53ba78de064b ("mm/gup: introduce check_and_migrate_movable_folios()")
Cc: linux-stable@vger.kernel.org

Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

This applies to mm-hotfixes-unstable (only), because it relies on my
earlier patch to this exact same location: commit 255231c75dcd mm/gup:
stop leaking pinned pages in low memory conditions.

thanks,
John Hubbard

 mm/gup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 4637dab7b54f..346186788a49 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -21,6 +21,7 @@
 #include <linux/pagevec.h>
 #include <linux/sched/mm.h>
 #include <linux/shmem_fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -2439,7 +2440,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	struct folio **folios;
 	long i, ret;
 
-	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
+	folios = kvmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
 	if (!folios) {
 		unpin_user_pages(pages, nr_pages);
 		return -ENOMEM;
@@ -2450,7 +2451,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 
 	ret = check_and_migrate_movable_folios(nr_pages, folios);
 
-	kfree(folios);
+	kvfree(folios);
 	return ret;
 }
 #else

base-commit: b70a32bbebeae216a3e846e01965880b309ca173
-- 
2.47.0


