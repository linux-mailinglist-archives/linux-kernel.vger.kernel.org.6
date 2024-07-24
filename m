Return-Path: <linux-kernel+bounces-260994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0990D93B14D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A981C233C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4DB1598EE;
	Wed, 24 Jul 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s0vQVOpe"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8E158D66
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826094; cv=fail; b=OMk1ymtBWj7JOlZ/KyDh0VdSfXeGfmTW4b+3gtjY2gEjWqCVhXoa1e9GIr7tgTwTc6i7it+UigW2gKNgdKJ3vVL/2vag7gPHRq7319R49hwoxxsltUIujyzwXATZsTXq8EDKtluoYSModmhivlVZvUUMBmwvSYnsFdv4yL6PzaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826094; c=relaxed/simple;
	bh=THC5hz5JzXz4sahAczdf2zYLeTEAVprhp4QtLuCbubs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MhvF+U/3iVOIycpkAsHAWnGF1sqSbx1KF0W6huji0OseuI07oS0Rn2HEaigLxndL+0GaR9e68lVhLfpaRUN24PORvtJDDkdYkGeVWAOySMINTWVb8id13CZJ43aAGCXiqO7mRurSUApmny6rwyr0SsMCQG43sp3ezu2qqaURYgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s0vQVOpe; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTXQPqJNxFxP6o17/mkav4CxxEShfcrWQuM9qYsOm6BRvtQKC26A64WhWXRQ05/Cisnhalb4r9h/8g6KXGbZVnyY3c4IzpFLVTebne0tThpBP5HafW6v2K1CIJOlOBY41ihYt5HXjMjOa4gHRxUt/wj85A5V55s2dgZ+jPMcG3YRa+UBMRJu6JrMW2D1ff/M5+teKIGYDXJ2M/zgNrrco0EZa5ypnfTH3RMCSuyxXhpcYgJFG0f3bdkIVqmst3afh6mV75jSAvwwswCgOSmAix6K5Jak0poEQdq2/jEQuqyXCls9GHPxE+3UEbMewM/CRCgNJBj6MYZzntsJb7kodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FetlK/722fVi6ZVNeIZFKwGEKahpMrmor89WHb8Wxko=;
 b=POdlAqhXttN4PRJRPmH5IxnikKN4/itPBOkPYZB+6f/rQp7j2od+bTXwxqDp8XAoggdbMgcAT4vvwu+yuh5i4LI8Eg8I30iOoHOR5YOsYtnK8FzxeSMbQywSVthT+Lud41f6RF/7HhQtxOqW7jUESzwc/eIkMwgAvO/5Mn+Qvua+W//e+YAlOxAR/+0g2Jk+OZsnDl2YDTrJv4bBDFqVkO5gfHyO43Tg+JccoY+RTUWBuctv5d7HtiM5AdeU5vUrgvwTIBRT7MhErzM2Q3fIzsWIfnMHjquHte/BtUA5b+3od9/v3ElJdZR1GLGDFQpfq0MI0JoY6MZHH15EP7z8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FetlK/722fVi6ZVNeIZFKwGEKahpMrmor89WHb8Wxko=;
 b=s0vQVOpedj38HyNtjrjdCuIwlXmgFVUn+DRELWIoHNSIVmF4a7CLnAKq0ooPoPMZFs9ZdUe4UShITheGTsx4Q7ED4FbO/XpJGbNbmhxY3ZZ/z6YynrUAdUkbz77rvjY7kzEo9M0qdgkPkL9/dbVEhc5Diy3P4xz44VIJeYRPmpDTWciBZYF9vYj6s69WOqQxk0DlIc+Atwc29dQakDrXnaCUggslUi4rzjWpFJRKJHyVqWQi3NFcbHMaA+47+fLg5VffYq4eT3QFKEm/pTW1bKJ3MC5EjjV7cqs4mSHlE4oTkQ3LtQ8/y+VIChHnQ7sBDk6Qs18VjrYW4eMvuaByzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 13:01:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 13:01:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 3/3] memory tiering: count PGPROMOTE_SUCCESS when mem tiering is enabled.
Date: Wed, 24 Jul 2024 09:01:15 -0400
Message-ID: <20240724130115.793641-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724130115.793641-1-ziy@nvidia.com>
References: <20240724130115.793641-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da80656-9e10-43cc-8961-08dcabe0b79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnTThk9tzg2CzTQwcX0JG8vwlbLhvLKjoRcJsBF9KM8hFvuwrWGLZ4SEiIHf?=
 =?us-ascii?Q?Qb1+2MSu1zm7rBG4lUd5d1omzx1w1P3f0RihwIXRR6si/gbh9iAB8iFImALD?=
 =?us-ascii?Q?q1HQnl6fM+JEhz7zXCJQOgllnH6AvFq6zdIL0SP1Bs/n1IzqmTneupGbD06W?=
 =?us-ascii?Q?oweb0fB+cBKlMHWsj7WBcoZNzaU3Huue3jWfrnVJK2Z+yHHhIVe+Cd9iE79X?=
 =?us-ascii?Q?Q8KJeKsLEWkTv5pujwBPdMnq8sxrnjsoXQVJsGvgwLnQvuODWxWYA1ieZFnC?=
 =?us-ascii?Q?YWnjK40g3//QqQo2GocCNZKIPrNp4+LESPPtmxKehvA3AE6GrMi453hAlils?=
 =?us-ascii?Q?RT1DyKrDbKhseIQ/7hQzN/6FUdkByMwXA7Z14ZzSANIIlF5IT7kG/vkmp9AZ?=
 =?us-ascii?Q?4oVSPJ6MeJ5nO/7JTKZBQ8qWYJQ4nq657fK4HImK+bgrWKYMvV6Ajeujumrj?=
 =?us-ascii?Q?tdeHZBut6mXT5300NpT0pnsFXczWvqpb5WJmK7dejsbijRPZ8dvHmZJ02cBv?=
 =?us-ascii?Q?EE57iJafUqFEZuEf/GgspEtv17Fv8WUvjMdzwXynpGVf71ysuT+OGpXw68eW?=
 =?us-ascii?Q?rZ4tP8MxRqIEDIKHgLoZ7nQT1JC4bIulz1J6NFQe/w8cWNIEeuVSZtEkXRzw?=
 =?us-ascii?Q?uHnOEA3wAsSpJxLkIn86FGoPIbUCnqyf0KwaH9p2EUXgagdhrqRdI8/Yq0to?=
 =?us-ascii?Q?9lNluTbLxV/l3jpBk8b8zW0ohZsEbErKJxZ/4VVM1oIsPIYs3etr1LVBEV/D?=
 =?us-ascii?Q?/W3pszYb8kybkvqZk1mVrgJneuYocivXzQLtccHqdQ1tt0o9CqA8JifmoD77?=
 =?us-ascii?Q?3qSO5SAjgDGAF/KpvSOueMl6ujS0x46Xpm1Gac5XDwZTwDRrvdEh1bIJx9EO?=
 =?us-ascii?Q?kyOqq5fqLO05DOM3nrCocJ+H+NzAwa21tEnYAuA/XuZGUOrtiqwuBdT9rgGk?=
 =?us-ascii?Q?hnRpGPbCmEnXXBmYnW3CAk/BFp0zrtrMSSkEnXantDFvX1MBQw4ZbkGuZBHb?=
 =?us-ascii?Q?cxCdOhBpG5mqwCi2/EZFwWeNrFhDMahd0E3JfrZDHgJq4QC/RD9atob151OL?=
 =?us-ascii?Q?wcefrAzIz2G/I8sORAMft4FKtIT3ODKtXSLG8/+hFuOPTzfIWPXTnz10mDgi?=
 =?us-ascii?Q?XEthc2TYC+9FrrPObO/egv8QDHNAYsaS4oIXAQyLsmJKhcHJ3UHN81QcIvo7?=
 =?us-ascii?Q?RbWEj3QuavjHI0Cz39pBM1rtXOS/REFh8j1vhPSdEQ8oEpxGMWE4RyGvizSd?=
 =?us-ascii?Q?GtJzny3DzcayRgCgL7TVrPqvfmYqV5FG7jwbvzQqBnVtAowXUYEcH5gGnsoq?=
 =?us-ascii?Q?EBdaDd7HckIscUhS8mCozr7mV265ncBUakRYT8iQIFf1DxvauCEnSZthXtXT?=
 =?us-ascii?Q?7hQY6qo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zzQ1yI72LD6yMPbozV0+u377efR9JRHC/i/T5QGO6ERNk25V2cqhGmWPLuvv?=
 =?us-ascii?Q?YvbwrlODVPXdgypVFy8HfDGdtk/g8+35Ir3DZb0QRXz5K4PB/VPkBhjd6n3F?=
 =?us-ascii?Q?P23v+X/LdEN+gRh11sdYfIAJ5AxOhkEmPfGSQ36O2vLVhTFRzWyQMG8AOjBJ?=
 =?us-ascii?Q?fCGZ62CpAikNF+PAmXt7ykn0dyyWwv8EbuiXwSe1iOWf/DnjeUsBVHrZb8XF?=
 =?us-ascii?Q?ywYeWYfhzUN8tYVGlyT8hjiKhKNafyOFShXCArrTmFIrQWfUq2wQwvO17dME?=
 =?us-ascii?Q?WNKxt7GuXAAci2eMox2Dq6esra6eFH8/yiob28yZRRzNhokiGdi73YbH2Vx9?=
 =?us-ascii?Q?MDTv8QCAHdQEaI+4N8Pq3pu2lOmPNbvjv5i9j43K2L0C4H4Gwe1t6G+pU6pV?=
 =?us-ascii?Q?Iu/kYaNFUQoEJbOxWcEqpFc4Ag4bVmkmWcR4ji6sDkchAGKubcDfrBqZNp/E?=
 =?us-ascii?Q?lTGCiAaV9+n3nAMNEYPKrCgGprlTZ43Q7VUhMv4yeb5F3VXfD0NPZb/LgYjl?=
 =?us-ascii?Q?7U4wC1H3y/SxP/ET8QWdYKJ4gHdQTi3ZRB9Snbm6lKUebtMahYo4KE/aaXls?=
 =?us-ascii?Q?7OfRXPH0/G7tnrmhP9zW6IKPWew19GRl8Sqcv5sjkmqCy58CgT5VIg0foUN4?=
 =?us-ascii?Q?GLrBGQyvuNLqo19vXNK/mIp1/4VJBcvNCPjFbeMXLjCSQ2VsFhkhGbRk97iC?=
 =?us-ascii?Q?VMrscbeEJw3il/LSIr98PAUHDh+0/q+Eqv35OD0RlFVnaTIGDeF4VLG89QVa?=
 =?us-ascii?Q?uohqu2qHffLhXDDG714oUyF7WbmFh77uvZLOd2kg6JBLk8sBY1bbY60XPgIj?=
 =?us-ascii?Q?qXoSKmJXl6xmrPTBkA19m8pg3b6EUVvXT6pnH3I8Fwiz5F5gkr7/+7FYKSou?=
 =?us-ascii?Q?nLg66T0QUKQb91KcK91f+e/rwfZfxlPakVZEwEH9OhFtMuYjCbVtzMtMdTD7?=
 =?us-ascii?Q?Ph67ZQrMTmip+9wms7/+QSN7nCNOkuSiGGK/0hVnQq7+oklAbh1+w2grAGBG?=
 =?us-ascii?Q?lshaVfxdWFDFEiZo7847kWLOQnf+h+Q/wZapjg3Dg/5Gz4U6Na3IIEYNiIYN?=
 =?us-ascii?Q?YRFFlVDOc97Rb7GKxm/Wu8dbc3rOnl6na5ayLs669lyEWaM/0lAGsRRCfN7f?=
 =?us-ascii?Q?+wmef9Tn/qvMa87rB4+AW6BJ7njyDDnL6wU8Yh1p8gjr10CwvxpQMzK/YNUQ?=
 =?us-ascii?Q?HkggxTp9AZmRu8ibSqisUZswNih3SyziRWHphMuesNg3tSV69jI1slXp9A1s?=
 =?us-ascii?Q?yGD5KTVfFXrA6B3st2s/niGpSPWRNbCPhQJq7Th1XwbyPdRliVpq9v+1DgxT?=
 =?us-ascii?Q?tsVZnnV4j5QXNbZaTWRudcJQccYduLcc/3us9ZDhDrzCqimdUvEMw4Vak5RN?=
 =?us-ascii?Q?urBV0BtpZe5eLe2ruBUBzPOZwdIOS8du/tYweWHYWK95BnzOjO0YhE6zWAZ+?=
 =?us-ascii?Q?IySZLIj0L0xK2OMerRHi2LgrBnRTHFbchlrNicZJzIPrmRluPpbOT4Fzx6G6?=
 =?us-ascii?Q?ehT7/P1C555WNCMu1eObd8NjKovtnMk1QSpDvVIBNTU6yB8Hg2VMi+8UQwgJ?=
 =?us-ascii?Q?qQTf/krJP4Pe9t/ybcU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da80656-9e10-43cc-8961-08dcabe0b79c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 13:01:22.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F75X5XeByluzv5oykT1mLdYpXLwtwhry+BFd7ffSyE7sQMuCoBXyX0c8saSm6aoV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

memory tiering can be enabled/disabled at runtime and
sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used to check
it. In migrate_misplaced_folio(), the check is missing when
PGPROMOTE_SUCCESS is incremented. Add the missing check.

Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com/
Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e7296c0fb5d5..826afb82ca56 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 		putback_movable_pages(&migratepages);
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
-		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
+		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
+		    && !node_is_toptier(folio_nid(folio))
+		    && node_is_toptier(node))
 			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
 					    nr_succeeded);
 	}
-- 
2.43.0


