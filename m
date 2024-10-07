Return-Path: <linux-kernel+bounces-354004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 410AC993607
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3450B227BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438EA1DE2A6;
	Mon,  7 Oct 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PfrOBNpQ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD91DC054
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325409; cv=fail; b=YCJ+HAI2EGw6WQB23FknKt9BqXCInfxfx3/3Hc5eBEt+ezkJjkREN1D5OKc81MQ24QFNxbUqfX95waI6xkpXHvbVg7hhq91TwxnU+7nUUr/KBk1DzzpMjkqCUDHaZB0uNv4ph/YYbOUBiFfxeNgW/KukIZBJzlRmckLwkx7rvj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325409; c=relaxed/simple;
	bh=t8O07/0RBJFuMYygWfy4T4mnoJ5twpZwDsq4hIKSOjM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BhPv5zhP8nDGOxbncv101atiIQVIJaVr5sb4gDmm+SNRVL8ayCc8tsAryZkQKrlAFXNwGwNS5RIqn+1e5U0M6eIptV/c81VQAT4OeqMR26g/ZhKxkFon3GyySs7FIGOTOLGPeqN52UmvuQrlomDGfYrs/U+jahoclJOsJ4bX7ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PfrOBNpQ; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P004mnEjH+9cxAPQGy442KKEYjHYFGZh3QNOEUsadzmgaIPZTcnSnnTDTjG2h7Hj+kHuKa+j6yfMoN4CDmEYtdxK0hHb9S+bE6CHXjikFkvV+hFr4iO9umhu9Km+qIx2KUbOD7QNSC4Ss8sQjglJARa1/Jvi8eXZbJZ7P2cf2/pibna9NpcjbhOuJ8p2xAK6YaJhrs5zzAo7ePMAyILEDjxGJCNNwIS3yWTMo2j9tKORg9z3E5TPvpSAVuEsEFZ5WQB1/GfTyWaD+u2gleKX7P90orVjimPxGp1oK5xbdSHvXMG1TKCVhNW/q2MNzQ+B47MPt+9wVY/kfYguQ3bl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y+kO1QZm3er56og+QcjjxCV8PiYzkNX1GkmotgyUcg=;
 b=o83PmJetBvcgBiQQwd6JhIB6fOIEtGPSdsuHANntWBLszgGtjc01Dm4hFW8O3T1JHiwqjPLLIECHri4d43fhwR8gl/Bt3v2T4eWvrRE9NQ2UDRufKa0KYx4KLYU01mEs4PHbJpciawqVU+Q/88DqHDcHs0b/t1PwCrwr123WUImqjmr/l8aFUtnpyaZv69ulsxRBvgdxWnsQ3VrgpR3eIlvEnHQzgVV/HfoclJ3m0X4TNSzHZ0q1mGOdO4l79rew8sTu6uzC1vAnZk3umrqGjJ6vdELyvEQQ3oAyBZ8SMr7aF4wjMVCFvid7RVq4OHPNgps7wMaoKz+C/VgscB+n/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y+kO1QZm3er56og+QcjjxCV8PiYzkNX1GkmotgyUcg=;
 b=PfrOBNpQeMJmxPs9ukLsy81hA/DeWZfGiyYcca99YvJcUkT+0uQs1z7Hiz713KjBLycfoi59gc8XAEFZKLJDMvbV97y+1/LgpmavNydmYMecddZTxNhh3WSPyjavX8stCOlKt+Izn1/afMH10w5ICRQcNMl37F1qJotgZnyB1Itpz22dppm3sxJk+4olbeIQpa2YsNyKbaZMwbpeJpKX6iumclmdhvdXnPS+IWtCw8BGAv2965TUZmIC3AZmQP+jBC1LQECaTZ9MiAcG5yeKa51LRijKfNZp7uzh7SvLnHnPpcPVeVwQDu6OSpBFK1NYVlLy60+RtMlF8Psm1ly1eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) by
 IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 18:23:22 +0000
Received: from DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::c45e:51b0:e1ec:1a32]) by DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::c45e:51b0:e1ec:1a32%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 18:23:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH] mm: avoid clearing user movable page twice with init_on_alloc=1
Date: Mon,  7 Oct 2024 14:23:15 -0400
Message-ID: <20241007182315.401167-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:208:335::15) To DS7PR12MB8324.namprd12.prod.outlook.com
 (2603:10b6:8:ec::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8324:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 8975a458-8b35-44a3-6fc5-08dce6fd2019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ljWL2+Q88RHy09kStUzT44bavVb/WMNDHGczQjSd28YZNTbF9XjFeWg2U+iI?=
 =?us-ascii?Q?EibJImPF6BLbjHn0A2PDUNgme/yAYzLn3ojYQV2LgPaC7LthyKwEMQkdS/Wv?=
 =?us-ascii?Q?2CwYZ3KYWYjU+/24ThE4N93yhvW9+EBrrTz3HqKip8DELqpcvVbG/Hoo8EMf?=
 =?us-ascii?Q?4uRqYmyrSU+Kez6qUAZwvVL13hF40iw42/whHgjMgsWZzkES24XhZf7g6WSC?=
 =?us-ascii?Q?Y8m5d/TwrbygegbuPZu4IxDS2HSlEYCOG/oIt/zhg3Up+dQw7k7Z1AKta+mQ?=
 =?us-ascii?Q?/m/19G6pNP7Y7k5fqYn45TP21QFXuK/pl437uhVtPqwN4gLk6vKh4eka+EVL?=
 =?us-ascii?Q?Ic02EN8nip40KuPPgtABtZqteNqNqq6brvBCtiDihunMoDBcs++zxX/2VeQu?=
 =?us-ascii?Q?a+XI+h4GhPcD1P3U/FRXF6nP+vNRmBAOGWZ3y4xf5hGhV7g1eV/qffdZjZJr?=
 =?us-ascii?Q?9NHm/ZIqneOvTVznb9X3h09uYcYWpA7kqZlksCGPezeK24SKqBcS7KCvWM2X?=
 =?us-ascii?Q?Lbd+7JeLX5M4gY+/PrCXGXEwAFYsoCc1CLI1Y4WxB83tpjk11/czVeJ58tB4?=
 =?us-ascii?Q?D7nFdljCqFdz4MIFC07mp8DJmOlUHwvZigghSHZflW/etvIL4mhN4+trOW3y?=
 =?us-ascii?Q?3u4YIyaX2RgIfi+Bbsi3gWyFLUHTApKwu09o+FZzcC+mZjwiO5G6QU1a2795?=
 =?us-ascii?Q?OfbjRoleMSp2UVFlYsj2Ohq8T0hxmvBpVD+1jIqBKAW08ubuos5rn2itjZYN?=
 =?us-ascii?Q?DvOAv1RRwWyO6BEJR0oXebo9IfsLTM+nJiMjNTQBKcr00QwIrZg162BAbJer?=
 =?us-ascii?Q?/fcEOEW0eCkhqcXGvkMuaqoemz77glqjyweskcMUUt0vSKLr/mjPAlrNrYLa?=
 =?us-ascii?Q?ZyW0bOrwMFQ7jX2h5G83BJdhopLvNrbSYDF8WqjOTt3AVGxPIMfKHDKV83OM?=
 =?us-ascii?Q?AVQj2liA82T+bwl1Frb0vKYk1w9/POWOwtSk9P3Hz79i+76YT1go209eFBBu?=
 =?us-ascii?Q?BNdP02zsehZ3M1p+Ivljd4qSapQEbcqyAsSos8mMRGCsZHFu0DAI0HvXrgH+?=
 =?us-ascii?Q?5IJeLJji2SazS5etP5ypEf1F0qcufQuoKTWE4YhNNEEzp/p+CxYCuQMyA4oh?=
 =?us-ascii?Q?QTkaQjqak72lmUhK1tdKdwF0iFdFBd09yvKa8xPd+V3gEkbFyNx2Bul9VbLD?=
 =?us-ascii?Q?apeq9MdmisCnmvXHlqa5AUBnU3aA7zoQEC3//bTOaAqGubntINLZpSnTwwMm?=
 =?us-ascii?Q?4750tUNe6FifOMC79WexeqaM+UnHxL3vR68w0zK6iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/69p5ZOYzD25u8pIhA3PRIGJ1yR93m1snk8cOuCAPyh0XSqlE/obwFRXP4t?=
 =?us-ascii?Q?HhS1MKeLAUXIbGTM0iJPFyVCeGAhjTUMx6h3pfs5/Mub471nHAAObY3FS/Lb?=
 =?us-ascii?Q?LT2ADEbAoJmSjMRohk/MGs8l9SOx5RR+fuXYjMzPTjroAqW0Y0B7HeBqFoGe?=
 =?us-ascii?Q?35SF2eCzXz6lunZrpVBpedMQ9tmIG6cad7CuqOe2BLdkfnIq5REhLGzD70Sd?=
 =?us-ascii?Q?wntTK1Yzg8rEa1pR8ijjbNeJa0cdGr81ePnUANdyntPqcrkAhdWAPBsdOfIA?=
 =?us-ascii?Q?yECy/DrOpy100kQ97oOhF26Tr17J7EMQ8rI2D+Hye/zKij91cIr/kUuqtlNR?=
 =?us-ascii?Q?YaM5+Psr3z5GGpFBWyvSYUCCX0FX9+V4fghZ5BIVbUzfqUWBia8x5JnHGKJG?=
 =?us-ascii?Q?hFh6F7/btSj98SsD5/D6liFycLyAbJAT5tyy2FUHMNRimTgCDqupGRVscysm?=
 =?us-ascii?Q?N1TuwI6LuTVgs9U9v0CgdmmXxKOE4VDMN7MITBmFWBO7p8XQ6thwCANcJfpM?=
 =?us-ascii?Q?e1EgW97fwE3nEHWHhc4AzhWtSirEnqNgPzHh16/434a1lTKA0Lc6p0NBsRAC?=
 =?us-ascii?Q?QmiY4qePUIUgotiZ75SktPRDEd3jLBnvtGZ+G35sA+55eX4Pj3luDAFHu/nD?=
 =?us-ascii?Q?cX56cc44SrgUJo9Jady/LR6vR2H+Dhu3jO5SzJ3P5PUlMuDd0+AnJCs+QbOM?=
 =?us-ascii?Q?TqltuEKqBzr4RRheZtzopepaCnGKXp0CXtojz+dIagH9qgS9la+BLzZEwEFB?=
 =?us-ascii?Q?SKmJb6uC7dn5QGtKOFWpeRfdSOmOlpX4YICocYmBZ8kUnnZnoTT0YyPti3ui?=
 =?us-ascii?Q?//WF0+j58IZ9WWux5uZJUfJVNDXSU9n5PN4utGFZQXylnK9+qqbyQ8Iefljq?=
 =?us-ascii?Q?P5PUZ8GUXIwgk+5PjW0qLHNIaZUblhW5qB86j5gIjghgVqMp78CUSvIrOZIP?=
 =?us-ascii?Q?MTS5TiY9ysNIrVjaXnyBVos5ig4hTRMoYMj2TEtUXtyveF9MPKxjY8lU+/Vb?=
 =?us-ascii?Q?7KP7BKE5Mil9qaEm1/zFsCLmi/Hzh5xbJG7ST+c+eZdSQLWL2qXsihN4JX0r?=
 =?us-ascii?Q?92WFZVbJNGqAe/qi28x2TAnm1c2NAqiPWXtCEdqT6+SJPOQjleVcMzV7tjms?=
 =?us-ascii?Q?HTWy3rAx87GU/15E9difNQFz26qjeYkIhvnb5r52VV7ti/oXkRHj1PmlqaGl?=
 =?us-ascii?Q?K4yL72AS0FpveUZPb0ao8Wi5tDWK0jS1S5LPK/pFW0HZ+tssyzcsgV1EiXJv?=
 =?us-ascii?Q?4aAqjq0j1b6p41x8rS/N7hrl3MNHG44BTLcYAlDG1fxsTODoIGd6qhHFQ9pe?=
 =?us-ascii?Q?iWYz9MVLvPppakx0ugUB2HdTSKpg0iiJxHYRoINQ1kB1mPSvzdb9vr43bS8O?=
 =?us-ascii?Q?VlvZR4cudWnTKE8jjxVg3V39YmK8tA6a9bEifiRvEGcvGcu5550+JVbeLA74?=
 =?us-ascii?Q?5m1Vq35O92VqMjsDcXKdmdQvo0Jhk/zVQ2kF3ZzTlHmR37x18tKB7dsV9Sy6?=
 =?us-ascii?Q?YFOxmHRaooA6qXnEKZpmbCUulpFJng7DvFWtEsSKlaWiRfm+hPcNUSFeRnNs?=
 =?us-ascii?Q?N8wHfj4jGIXdENIkHuU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8975a458-8b35-44a3-6fc5-08dce6fd2019
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 18:23:22.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kezHw6G8GADw78BQbAAuj7qGSf+AZacdAqCvVfDzCYsGki2Rcv0GYpFc1gZM0byN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257

Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
init_on_free=1 boot options") forces allocated page to be cleared in
post_alloc_hook() when init_on_alloc=1.

For non PMD folios, if arch does not define
vma_alloc_zeroed_movable_folio(), the default implementation again clears
the page return from the buddy allocator. So the page is cleared twice.
Fix it by passing __GFP_ZERO instead to avoid double page clearing.
At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
define their own vma_alloc_zeroed_movable_folio().

For PMD folios, folio_zero_user() is called to clear the folio again.
Fix it by calling folio_zero_user() only if init_on_alloc is set.
All arch are impacted.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/highmem.h | 14 ++------------
 mm/huge_memory.c        |  4 +++-
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 930a591b9b61..4b15224842e1 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -220,18 +220,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
  * Return: A folio containing one allocated and zeroed page or NULL if
  * we are out of memory.
  */
-static inline
-struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
-				   unsigned long vaddr)
-{
-	struct folio *folio;
-
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
-	if (folio)
-		clear_user_highpage(&folio->page, vaddr);
-
-	return folio;
-}
+#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
+	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)
 #endif
 
 static inline void clear_highpage(struct page *page)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a7b05f4c2a5e..ff746151896f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1177,7 +1177,9 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		goto release;
 	}
 
-	folio_zero_user(folio, vmf->address);
+	if (!static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				&init_on_alloc))
+		folio_zero_user(folio, vmf->address);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * folio_zero_user writes become visible before the set_pmd_at()
-- 
2.45.2


