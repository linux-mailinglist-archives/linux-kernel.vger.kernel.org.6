Return-Path: <linux-kernel+bounces-538847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758BA49DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFBF3BDBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2106D18CC1D;
	Fri, 28 Feb 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sScYgAa/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA6187859
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757365; cv=fail; b=VfIdt3lPLHNN4bHWKWKuSL5okUhChAdOYPDxJbpRkwGnR6BoMDTZYDgXW94d/uL/EbYwVEbqXi1PDln4QGbd+lAyiGmLrOzq5CgowSslnS5J/Gsk4tD4bzwlf5jtgIKjZxh10YM57E51aq4uE/qWUOiapYdtiYA2dtSAA7qAHTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757365; c=relaxed/simple;
	bh=t8/6y2UgjDihnks8c4BP1ZVZxxeI1hpASa9Zr4eTx6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pJd106+ZrlnFmiNWHEuFKOgAo7QOJkYiDiZK5dhMYXRBlSQs5/OOxHIqbXyVh6EJy1s3SZ+8D/OY9EMOHRXvg4012igq0gHaBNMKm2ssEYZ5MM67a62skaOdlitadb4/iFaWKElmwPgovQdA+7ER7xVzKF+kjW5hdQMBxnVVG+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sScYgAa/; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBeGs712zjhrnniMmztRqM5T3d0hSv8Z/S/8rsmBRVrokfztV2pA8/Y0GARO4a3Z85RORxswihcrngtuqtT1AvV3kkapzyK3R16n8YuA5ePsFfBaxB/YPjjMTSloCCUFS0Mz5v2zrjK0Z7KzrT78yZ9EukI35lyhwpPaXWqa84ous0zH57HMqdOLm7GmelZh2vqt+d5Tcip+5hdNBCe3loQp3xVMLp9DoZF/LWZZ7plk+v+8lei8O64EeYWIz2jtf3OPPNasV66kvZ9AmWWx3El4Jf72Uz6q6uiPsuiveB5APmszj5cYqNgLVrlReu5kwSLI4pxeAkXwxetzXd4o2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs9HLOqUPbxBaeylFXuGaeB0vXRptZpOPf7bbvnmrMc=;
 b=t0es2EFih6dLBgJjJGX4S7TVrkozVY4kYOpjcvOxXrC19oZyIeIR2IcC/sCSWDePmvYVxd2qMRw/9llb4VFkQ4vpXules0DTktoyxb0R3324Tbk9iD06EArD2OLd2zBkAcB+tz7y/meP1pr4I/587G4UtTjuH506Pqlaqd3JkBnLffAW1HRQ0mCJJXxqyIlvzYRegxfvpkQKvZTJqiZ78X/c9W5CpVRHm7abZ1moI/fj10SxYs+dKeqsj+BAm2JPAV/VyDJtoIyXz1B6ETpcFHYTYNH9b6TsTpduAucgwcL5/06RMzEkbhbsj0GiW8LT1jdH7ej1Ef0uKRjyT1lWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs9HLOqUPbxBaeylFXuGaeB0vXRptZpOPf7bbvnmrMc=;
 b=sScYgAa/adkG3adJqyJFm4LN3MyL8Bn8Ye0U+/StTApqya0Lv8DH54DcDklN3JXMWo8cjnVeUXKGxvvtl3N178h+F2/bTPHctc7V/eBlqJwMjvVnTSG7S7i9BN5i+5a7BX/1CCXSd0gF/vklhiuWk3W3cU9ISgd9is3XY+psT4INffQFfvg+2p/LwqGe3o+/NsvXTYEmtbbd75x9QoImOISKPc4jJKFv2+UnjJhWDpDkdYV+Z0gUSxPL+mvQj6SLs8AcPZArG8NmsqtOzMqgNIpADF1XRuyVDcq/IA/YQZqP3IV8LkT/WZYkc2Xk1jZsAFkoVxxPlBssR+IjANkK1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 15:42:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:42:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: Liu Shixin <liushixin2@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm/migrate: fix shmem xarray update during migration
Date: Fri, 28 Feb 2025 10:42:19 -0500
Message-ID: <20250228154219.2214149-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0021.prod.exchangelabs.com
 (2603:10b6:207:18::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6de3a9-ae3c-4da9-8b63-08dd580e86a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dTytMWCkC5UZ/RpegoO1o8C21TSbGZ9/X7ap89BUZoq8k5b9Lfhon3rB3p0g?=
 =?us-ascii?Q?XzaKtnCRYsOp0zBhqbZ58faA/kvWSjGmXTWb/IMe6E7WRKEx8rCnzFhsm7s/?=
 =?us-ascii?Q?EfVANnPY3n8tXUpPHAA4fS9q6+CGfhqLEMYU4+v6mHsABL8VBgg6ScjxVPLl?=
 =?us-ascii?Q?SvisSKjBSV5k7oiuvpbxunJ+YLupDQ7LT2gr1wpV5E0ASdRaumY96D8ED/JJ?=
 =?us-ascii?Q?+oBdhUF45gn8E8BLf5rFeLy7i6TiXwBNsUY1ikdmZ0tqo7/E7sBwTdedTAuf?=
 =?us-ascii?Q?lunfTmcWfdUU3wZhewDM30cxuFY7HsDuWtDQWtvYJXOqp42aLje1KdsiiRzA?=
 =?us-ascii?Q?d/MkKdeZmI4FZQnyQYpCTbmL7pXQed8wo7GW7xWLo6P9gE7DC79JpUMektcH?=
 =?us-ascii?Q?VAiVG0WLGPTShv3uo+bC4ro2lVz1bvwAGG/GsnDlDTksPhffRAo1/4wpZuq0?=
 =?us-ascii?Q?3ht7Y2o1NhhY6nuVhim3srXDm0zjjtOniD7WN0s+JADwHhlRjomqxYigltLj?=
 =?us-ascii?Q?TDep18JpLWFQSi9GRiwFxvFrovdj1R8GN2PS5XX1JajGpY0I0gu5Lz7ntyQi?=
 =?us-ascii?Q?nu1yr5cctpjIkJ4iKfMamOOS7HZcS4dweXs7O7hn3OFG/ZrNn6ynTLmVcXBc?=
 =?us-ascii?Q?f4+0Hy3Jak8x76hLIhv/Zss5zq9ssDgIdTe0KarXyBWlL6DEIOLwgFnbUePu?=
 =?us-ascii?Q?eJ3d60JY0ZhZRNTygC1YcANuELvEEiHh/2pP/mm3KNedYJMJ9YmsRRtqUjaU?=
 =?us-ascii?Q?W8nDsvaIV640l9jIXzNLbOxpNE1XNgKO917s7WYlxJh0X06aNE517MOzGdF6?=
 =?us-ascii?Q?Wqdr6mJofE2C4o5XKS1NbSDlXVObFFZV6ILfZkb9pXHcWXaBPSpbODfVwjnm?=
 =?us-ascii?Q?95rUt/AJP8PGBDSuhs0lV/UXzx9J95+WGzJNKTXv2iYAxr9uCKGy5K0AlLYw?=
 =?us-ascii?Q?Nc5PdYvK+tSIS2eTojQk08I7MK+0GUcT+Vc54jEmnePtxKqSoH6hSxpwHwbU?=
 =?us-ascii?Q?LdUL50O7w7n/Rm0iOXMRwoOPkORgblOTz0JE+EJ3Cylpe+FFWqn7kWgpDBj9?=
 =?us-ascii?Q?UAzRaIJ9+1bDyLuOxwJL0pPD5sXAJE0KVU2wGNbIwZAD5PcTHlmsO64qw7as?=
 =?us-ascii?Q?q3bgD8hkMjWR0jioZKesdf4rdTz14pW7V22vM9605OjULhnxShInuKoc5eDu?=
 =?us-ascii?Q?lD2J+RQhOan+IGGbdkDVzX/iDQu1IxMGRo3JV7UVGcq4mMDOrKCtLvAiv40L?=
 =?us-ascii?Q?tIGSm87QBbonVV1iN7cMPMyVM8AxK6GPTM9yV89n7/9hFO8W5saPmDHfdIMS?=
 =?us-ascii?Q?BVJ7zU12GKV1nPc44UO7uNJvg9TD9nauSTPGWaZ7xPnbyjh3jwiQJn+ugcEb?=
 =?us-ascii?Q?x4aPT0iPCv5dGrZVeQxJ+Y5jvXpr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVvrGjxM7jnkE3Yafvsz7yYpGan2E2Pg4pnV/PVNhBOK5q8FWc5ZCUzzPy5V?=
 =?us-ascii?Q?GYOyxm39FxXTOBYj8I74iUkjPRLu3kSfNf/Dx6FLh0j5REDww+8G3QqlxsbG?=
 =?us-ascii?Q?qVdDYC6DVX32O3IaGoVJOIHIHsY0tLy0z0uoxFW8ezdpuwf4+HSiC2iO/SM2?=
 =?us-ascii?Q?SUSR5fTPSIazTwGTFKTpr5W9aMD9Vg5f42JPtraz6oq9P07XtiLLk0XyM/u2?=
 =?us-ascii?Q?KAc+S+ghESA5nEIeRxF3hDdXZ0Wxr/UM0BnqNdZ83uAzcJDCmLcha7KO3qgc?=
 =?us-ascii?Q?+7uDCnbieUmg28WFlvxHnk6MDenZe74yG81tVq03YoNePx0UYee0Z+g7J8jK?=
 =?us-ascii?Q?KRsqk4IWHxZO6jjj7Looniviba1cxifEjm8Ds8jjDiAeVtWvq29j1vk/Yroo?=
 =?us-ascii?Q?OhrAHtJ+30fNn6FImZyvU2N/VUunwNv6fuCnuv+rBRGRovQq6x2p/1boqkx9?=
 =?us-ascii?Q?ogmD2DM6PT5evrMFTXjT59iXtSCbBgdUBrADgZ1t6zW2e8aeStM78FpPTe3Z?=
 =?us-ascii?Q?qEOQgjsX/iegM1E/r11XRvisZIbIcZOjH7bZDRP8/gM7F8aiDRpv00jWGyNx?=
 =?us-ascii?Q?kf2ljltwAmDg12ahSwiVWw6fdH5krJBoDWjiv1t3CwCgS4UHqtZnLXIa641Y?=
 =?us-ascii?Q?9zxRpyzVSYQxTCq3HZSfIq/2adKJbo8EXZwD259MEbN6Sq1cuoQBMRFvAzgW?=
 =?us-ascii?Q?uggZiAn+V62CjftL4dVf5x1VKr+nvlvD4CHxKxikh7eIktaNwHZSPuvg8RxQ?=
 =?us-ascii?Q?Fk5qcpo/z6OB/RUatgsI4Ed3uFUutcp1G13RhLmm6OUhzOEQ+kQu0p9zNzuN?=
 =?us-ascii?Q?F9HFFHa5BgxOnZ2ibn78ynj23wnbdMy5C0RSQYtnjXhBcvfKipTJv9UJHR1b?=
 =?us-ascii?Q?aLRHtb6Mllvp2tH/WgLpemwB5SNcivV/TTjxelfQ7zd6GMi+xyORM6v1FWlY?=
 =?us-ascii?Q?Jin2x65UvCRfGgS+LLk/YnjRPl5vQVUUYhL8PwJfBU8OCIeKfihWSRpUbDLQ?=
 =?us-ascii?Q?NI1ab4w4OM1OXGM/BsdKIINZigPtwI1t9jEPVFafUrM/YV1h0Rsujih7REoA?=
 =?us-ascii?Q?C+XtBg7PDKX5KHD/YcMnZbxb+TvRC0Uw5jXjbHnTfFlf8IoWKUtLniEawB9y?=
 =?us-ascii?Q?avJvrC5qQVdcNm4LwzhxJ6GtNGG91Ppik0iu4aYz+Yblt2E0RTvA105X9zSm?=
 =?us-ascii?Q?HsIUOf+ipVDDlOinxqqZWahVMPndOZuBF7lrj3O3LV+s53TLruL3JfhhgUGo?=
 =?us-ascii?Q?xmqkJJ5tN0VhX6Ps/BEs042xQvvn8KA8thHQt61T1W2vp4cd1+s7/y/BGt3N?=
 =?us-ascii?Q?WZZCKiOiJmfXi3szzhzJR/Lq0DzoFLT7+4BShDXjWgm2tB/WJPFkyF0BEbF5?=
 =?us-ascii?Q?an55lre9W0W/6XgxqQ5LOP4BrZ80mpKzMnba+Hp2CDNim9BW1sPuhKXQ4SJa?=
 =?us-ascii?Q?quhVIXyteUtZQIW1LRwdrplL+q6JMxFyYHi/1Ba6D39eTWrWpARvR4OnGJhZ?=
 =?us-ascii?Q?j6w99a/KelIqXV45t5Fi3C4c+gy7QRSBeij7uIdfGCJ0imDQgspMqGyU2iqi?=
 =?us-ascii?Q?EfIS0OrG9jCpDc8TEMrD+pfbrL5s2KRdRXb8DdXV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6de3a9-ae3c-4da9-8b63-08dd580e86a6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:42:36.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvYw3HlHQZIiN+/DNPr2qWX8QjsribGNoIHNogUPlL8N/Zj3pNaDVkKSHRiJQhli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224

Pagecache uses multi-index entries for large folio, so does shmem. Only
swap cache still stores multiple entries for a single large folio.
Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
fixed swap cache but got shmem wrong by storing multiple entries for
a large shmem folio. Fix it by storing a single entry for a shmem
folio.

Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
Reported-by: Liu Shixin <liushixin2@huawei.com>
Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 365c6daa8d1b..9db26f5527a8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -44,6 +44,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
+#include <linux/shmem_fs.h>
 
 #include <asm/tlbflush.h>
 
@@ -524,7 +525,11 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 			folio_set_swapcache(newfolio);
 			newfolio->private = folio_get_private(folio);
 		}
-		entries = nr;
+		/* shmem uses high-order entry */
+		if (shmem_mapping(mapping))
+			entries = 1;
+		else
+			entries = nr;
 	} else {
 		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 		entries = 1;
-- 
2.47.2


