Return-Path: <linux-kernel+bounces-259262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE9939333
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991671C21677
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030616EB59;
	Mon, 22 Jul 2024 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oixHRNUy"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B231401B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669367; cv=fail; b=EbTkPM5X174J1pm0Xwda2H6WD925MfK1wEpU/992bD0fiBS4Mbt160H5l3uLqOr7U2rw1wWQJy5kG/eQHqiftDFDGa9f0cDSnpNTEaeH4oz20ibZZN/Y+/gePj+xouo9yaLZsFnpFwCe2Gc9dOOsyOVX+H/Pwatv0TL8gpxA+yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669367; c=relaxed/simple;
	bh=AisZ4w6suWTtHop1H+qjXbrut40kS1y0a1gInvjHPE0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IW3ea2p2O0WtsnFa13CYqTUou3o79bY+4yoYGUPlOFV+tcQb7jVTOMryLKx6kU+6X/togZMY1Fss6two982aepqoIub5TZkJfkB7A7+anmMWqyU5F8IMIhAyFdQgEwWEFSyljef54wc5nc21Onh3DDyi58bSf7AUTaeqL+Ys8iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oixHRNUy; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI2TQ9WSkW+wpvcuCMnkx7hAYfWnnHxMKCFberp7VBQTfRWyfYnw7K39KS6GsE3ewxo6qNe2FMPyrpKjI1pJ4QM5Vb0Q0xPEMrlrdHh6O8wshQU29Omlp5BsJDqabx1ev6OF/V75Dw7pajSjAdHxlQ1CefbXQ+dtbEKFXJdtPGIiwvXZ3G6PFi8ovpQbVNNEf8IkIxAWA8Q/LL7YQxE4GVtVXVakeo+LIG0KVXH0SZIBtSDZXSYOvRP+R2PTNlttiiZx/0tw268LaWo91fePZkEfP1SmIFYZrpxcHl/DkoVqK0HTmGrmebpDY0HX5DLJ11d8UodvOCkyf1L8qGxCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8Gzw7y7sG97NEPUr6qENMLG1Y85frlPpN/bV4VSYFs=;
 b=AW5d3PRlWA4H4YnVIvJsJzlH5N6rnimKHBy68p5gtQGa/OtZocqatjH/LV57HjO1WOKTcZVCe4/9U5ZWbd7GeEC+D1DcLxfY7qUi18WHNArVlbFPCdpEalj2fWRcBdbBnbLmdDXIdAMQWFWUKW89dpmNbf38JFUDelUu+nQe/mIFoe3blkGy7xgE3Qbv0BiEGWj3bSJN+uK+MNpmqo92HdySs8Cbc6AbB/Lyl/FOZ09XteC+2bb4TykltV6vS3dRTKbkWlm1QThQj1gIqtPYvUA7i5SuWfbpxdPffWjvCIra4A0WN72LaC0svi8ghC2FJHUrPtvrMidyWrNUgWsNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8Gzw7y7sG97NEPUr6qENMLG1Y85frlPpN/bV4VSYFs=;
 b=oixHRNUyxtYJ8ZiT3DOVxm/ogEioAThIPzfNa8rkP0bdnMG2LaJMXcBCJJsrW6yf/U6A6ml0PSu3KUQpf4Fwg49ASVCjWMrYugfhATZ7GNDkcBLqieM55tXTYIcerk4iLA/zc+wp6WPkqnsj2DyOZMdfliWH6OpbnmWYOt8TSrFzJYBCQE+WtfUjQCw4KmE+mhg4oCJ1SyBnvxobjRmlhAxOoFZRZpYjr4gy71jk8Ef/qvhy8u2Ok0e1iucspoSGcM30Xam2qGinngvgdlmxAx3g1hdGLruc29spLp2z9Rm4Mf6//3qOV7PGSOYYSwW3RC32aD9MpmLLOOUo+FhAmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 17:29:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Mon, 22 Jul 2024
 17:29:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 1/3] memory tiering: read last_cpupid correctly in do_huge_pmd_numa_page()
Date: Mon, 22 Jul 2024 13:29:15 -0400
Message-ID: <20240722172917.503370-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:208:329::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 48175789-c3b4-4923-7a53-08dcaa73d35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ifPb+0xJDLfklnWWQRko1xOMmmsPe6+01/9ocyQWCtVdsSMS8zD5yL7GR5s+?=
 =?us-ascii?Q?f/sHtUpUhAy5iytsNm6iIRL08u7y5MspDZnoT480DG7GfZUGZ5UrjDVOFgyS?=
 =?us-ascii?Q?uGTBh29KrXLYahOiqZ28hH9lBWxXvrpuot2y5+L7BW6mu9B+MM/yvGnTVqNl?=
 =?us-ascii?Q?IbN/r0Qt7uNmJPm/+3FPAVsCF/72/u4EQnjCXiYxwejzdV349v293PypP1qp?=
 =?us-ascii?Q?jNPLoaUe8eccg7J2OQ7N6Md6+UuaL/evVje3dSgktG8DzO3tCBb4pbQCf8z8?=
 =?us-ascii?Q?iodmmMHwuo2eDyAD8a7ZlRCbDZuhaKjwf9mzGMSRhWNETGl3XqlUZLATOqL3?=
 =?us-ascii?Q?lc70iYKoWMeLePNQPpmUejeP2iW9D7njG5yUt8zrKlL3aFx9i6iqUniXDQjn?=
 =?us-ascii?Q?DjXhqc2UU8T4awlMwdckkLErdXA7oYdDHjgQ/qJgVwqSqXaaAwQ4pSdJ6rEe?=
 =?us-ascii?Q?+uWHD2kmAYkOEYTQK5Lg8LQVuymVw2+9TM4pZSGa8do/t4r2+vVsqC0qjaEr?=
 =?us-ascii?Q?I/B6H0Yi2p3jaNTbjBGNiTtkl/p1Gv5TmjdNjEq6q26VlOGqjDd6GzHbkuZm?=
 =?us-ascii?Q?KZDPyEOrgcpRXEao3UEkuz9bZ2O5RrWny2pr/nS2GWf1aTdyE/h0yRGQwkUG?=
 =?us-ascii?Q?FXZq3026hgmDfyPPdwjjI2vlAJkPTVd0rVTDiOS/bZp9Hq6eOj0Sk0ByYbhb?=
 =?us-ascii?Q?MueGBNw8Tr2xcrqySJpM60zWIAse07hgH+U/2FTik2/Y7rnMVARGR5T86Nus?=
 =?us-ascii?Q?GMdZAwC9biUUjXJxCrJ0r3jK9EcgW4JseWF5oeX1CZAJQv+wcvzT2xJLhz8k?=
 =?us-ascii?Q?YkSUsKZEFdd5DSjvxzTXEo9nXQVNHODGR+4PLxmh3xZ70gJLV0OdkAKJMFH5?=
 =?us-ascii?Q?+axU4XaUh1DonYItk+jBIdcXm0TqW7MiMNA1AzCAS+kR3QY07AcKQDvUB0g+?=
 =?us-ascii?Q?+jsyboy9kvWXdySTZ9uu1gkzqWjOoYYqHeT96v/Zhjip1einlEH34t6y81fv?=
 =?us-ascii?Q?+H8g2gqeEV2NUrqrZ1/Ujn2iknQ9Lto0qLQSPZeSot2j4qNJcMuKwt0VtIFq?=
 =?us-ascii?Q?0vron7XDimgpgIUa8q0CrdLE7gUVqK3SLYpwJjNlsWO+Orac9NgB+5AmGkWr?=
 =?us-ascii?Q?MyEh2LwXCIobvq937KqFfG5U2ZsI+D2ywm0BprFrVNfjL879USw8phjSrfLI?=
 =?us-ascii?Q?p8fWD3+pGfDCN9jORkXRu4RmgBLdOMZXsg4uhR1G5Q1OP5FwjggjGgw2nDVC?=
 =?us-ascii?Q?9FkxZxNrq08Mh/IaN+DxmluTvmqLA1oMfLcFaucv23IvHJhVJ29SRynO9Z58?=
 =?us-ascii?Q?renFtP3ssxo4ZAU33A3zLKbQNeIFzTJc3hKmeZuK3enr1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tpwmDIS3jChw8UwWoWF08Uq2KmBjly6fuiRcb5rGpzBC21t/SIQWFAT3fHvC?=
 =?us-ascii?Q?6j0Ud0IwRIrxK0Ll8lAV/XMrmD7rDnKQYcaGYq930vmrQLRXgvpzphrMScBr?=
 =?us-ascii?Q?ODK/OBPqWJ8ncR5AwbIK7+1TwoCrBh0s6Z7c2md52Drix+Ik89ac2nlTGMhF?=
 =?us-ascii?Q?eu1l9D4dhf2jqztR0RxRosQx8mz49Mn/GKXUY7wNmqFSfq0rlrc3nf2GqrZf?=
 =?us-ascii?Q?YzWlmciEQoyO2pRJCit1TUisLNSyYoqMe1nktNUxH93WRAvYf+a3oxqCODAy?=
 =?us-ascii?Q?gnuvH5XtjlYC/MqAwXzLRSKOr4MWuCRqFfs6yDXPxTU44xQskdP+r/tm3jdp?=
 =?us-ascii?Q?UcpzGi4EROLLrPcca9Fq3pm8h2PCM0c/2IceR6WyiT9oo2tC+tEezzqXPJ0J?=
 =?us-ascii?Q?ooF1mWGgBCtHO+t0Obn/8bNuAjyiLbrYxOAJglXoIIOr+8Y0LL1OIfZt1+IG?=
 =?us-ascii?Q?LyKCfMQGML7J55FvsW9w5LEtDhl24yj/QJqOs/OzzyxD5Qb2+bQ/glVFL/aN?=
 =?us-ascii?Q?PzbQD8QeoyCBYp0TZ+hCQ08GFr+u5FOdzRiorafDuNpM75XbB3vhkufP19ql?=
 =?us-ascii?Q?cKMV+9jhaWDBfUDBMyWayTikCFjjrgHpLjPyIOaIjLGKnCG72CEy6UPR3LyA?=
 =?us-ascii?Q?iiT7x8JuuQLVfpEXUFZjIKx8x/CmRMASGN2jov1dfsDku03KIi+JEDTajqs7?=
 =?us-ascii?Q?g1jVH6B6LZbkI09Ie+zTVhAnMJLxyDiZIFKW+HKMKgshLxgpr0+458HtMRZn?=
 =?us-ascii?Q?B/Sa/GjbH9jCcOn6VKlqiao4y/pdIQpaxqJDFBAwmnTZAhp3eEnkdVU3FgfY?=
 =?us-ascii?Q?6x42Zf2NDoL9bstOzUOaieXdsgOIlAHhaVh9UzSGfAjV+U2o54A5jnnRnUe1?=
 =?us-ascii?Q?Cx3Vb/6+whsofI/p5ZvaF/2tRz49rS3gmEmJ60qjdv9PGftRFzpSamHcEKL+?=
 =?us-ascii?Q?lqYZxQlBUZ71ADa+H2uOsygBg/ePv1e71E0a2CrvQVLTAFdnR8TVUroH+WPX?=
 =?us-ascii?Q?XVHeeiMLIDO5u5kEsD/Y+sxlceZhXjEklbaL9oGxkDeKBbd8GODA4N4qUn7G?=
 =?us-ascii?Q?eNuGbLX62se4mJMAVvmviOIvEaV99eXM192iqkda9N5hK15n7iM+PlCk/UrK?=
 =?us-ascii?Q?oRwjFzwsK/OElkYcd0qqOQy30IeTAdTFamjyQ9XO3wArcP5CFp/45JoV/Erp?=
 =?us-ascii?Q?6cFj+C0ESp/K/DAgAIMblYT65Rsp5dayWuFMeBK73IoAr9x7m4Gh5lwloquh?=
 =?us-ascii?Q?Gqe2Iwrwbb6WD2jwGEd5030nxyLxunQFyHLXhNq6eFFEsl22fj2SEjgumTX+?=
 =?us-ascii?Q?w0r6q7Pg937b4h4Ls1ObbBQqs/u9CoRIlmcK/pJ2eP0FqDtQ3CEloFBezgb7?=
 =?us-ascii?Q?Qso32thcsncXG5QtYcsPS7OR6EiTEb46ZWL/xKh21gDyIQrvXWz0udU4AqJM?=
 =?us-ascii?Q?0u0wixQxomn1jL2zNosM3ikRE95e+i0AdMymhRKxLfrvwnLo/kMD2LFvd3zw?=
 =?us-ascii?Q?hZj+GM9P5EensiunoB/O6vtFIKN0unPNQBQOVJ3Zxbdvh3g54XlRa8gM2ddd?=
 =?us-ascii?Q?qKJfdo1wniOEADCQkHs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48175789-c3b4-4923-7a53-08dcaa73d35d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 17:29:22.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loKXtc20IkCMCkoNVdshOPqDOrFWX+DE28F7ruoiYfQa5NUoRvHPY6DmISLukdl4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

last_cpupid is only available when memory tiering is off or the folio
is in toptier node. Complete the check to read last_cpupid when it is
available.

Before the fix, the default last_cpupid will be used even if memory
tiering mode is turned off at runtime instead of the actual value. This
can prevent task_numa_fault() from getting right numa fault stats, but
should not cause any crash. User might see performance changes after the
fix.

Reported-by: David Hildenbrand <david@redhat.com>
Closes: https://lore.kernel.org/linux-mm/9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com/
Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f4be468e06a4..825317aee88e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1712,7 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (node_is_toptier(nid))
+	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+	    node_is_toptier(nid))
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE)
-- 
2.43.0


