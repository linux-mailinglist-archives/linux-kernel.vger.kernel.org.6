Return-Path: <linux-kernel+bounces-549960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2BCA55911
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86F7189A0CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F182702B8;
	Thu,  6 Mar 2025 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="k2rIq0Vc"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020100.outbound.protection.outlook.com [52.101.46.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80218FDD8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297809; cv=fail; b=qO7zjZtpZvFy14ZX8+6pE3ZZV7PjaNmKjBkN1a+pt7mf2wYAb6ZxjxQG0Bx8GnXNq+Vs3mkFI/0qg/vjo+kYX5aV4mF7bOkBWQGDaDQ4VlaVUrklbuUCHiUMscbFkW7MaRpLx8hxb2dgoSRIf7Y/qIpSRrFuM3bkX9WcRQ2ip00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297809; c=relaxed/simple;
	bh=4wgKoPXHNojq+XgLPSDxs9C16kuBDmGNm9RY++HX0R0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FpiynFrwkMFOyTf3jmXzGps96KUsA/i8TepQzq31KjsoTeuQHLa68+huDQ247mLtaQrlTnUh07FA4mJlxZNs3HXLmDiilhgZaa+ai2oeCqIc8DQEjLVQxl26d6AF5ztsWu1gIQ8ADlELZ+ia87LZ4cihbxsmIaAjLC+/FuFOERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=k2rIq0Vc; arc=fail smtp.client-ip=52.101.46.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixRCuitLuoTRDt/l+l8yA7k1yamcXJBQpsH3JJOHmyuUXmMhmywTgKMtOjJ66CYZbUTeHMlHn+qrmkJ4KY6bZ2ATwzl4g9QzJwCAHYKd1F82cxzs597RX9YsCrv4bCthnmCev1dK24JHsdbsf0kJtoRMISGOqdDt8LC5QU+IyCdlfbVbJtMQS14h/B3DlYWaGA809Q6hWnpof+FnZ4r2HJyADQbnYY7ooyXE898i20odMbzZoCfHAzYvPSDRZ2Acys945PIyo0Rpiw+av/wibyFotVfhU7qmwalfB9uu86cbxqwTLC+2UUqyXcKxknmfX0HFlSUz+jl2/PRimkIZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TBkLf7pYhVulBWnbhXYgn+prMAvjn84aZKC/dpgd0U=;
 b=lv7xnUx15yDgs4wOH2EXdFCnpk2S1l4tmAjRXQzMb7/9TZNNPBbNAgBJiAklP2UmUL5wMc5Uusoi4takxpE1RsIOB9NsqM7gu9+Exike9lq0yNvRamsZW5j3myiJ4eKrHaN2aYEyhWl0T3uit8DHsPB9bfZSBIjbHivrW3Tki6yMTTDRPPyfR+0WgeNtXlxhLfbnOvcljpCR9knSOt7oLYOGAHezKJPUwXOEmsB1RxV9PN/90MswSt8xTXpkcZRZ03Xjer5osH+OtpPtZjWoMzVHu1f2a9ym/JL8obc2BWhAerb+dE2MGOOXxjOZBfbDDHLPTA0Z4gU+Am+kTuMhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TBkLf7pYhVulBWnbhXYgn+prMAvjn84aZKC/dpgd0U=;
 b=k2rIq0VcIkktKCvlbMaKiJGlu+JbO/vzBpDf2BommVbWOkZPQx+rdFRFQ3VsZr0fMcgzO9rfZ0x6SJyFYEDPM1WpYQcM0ATY7Yspug0QZ9koVRUw60sDqequVEcjX4m3XvEeBbeQIEykF6QEQ4v/6VGJ/OZpVvmXNBBJVqPftw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 21:50:03 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:50:02 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	oliver.sang@intel.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: vma: skip anonymous vma when inserting vma to file rmap tree
Date: Thu,  6 Mar 2025 13:49:48 -0800
Message-ID: <20250306214948.2939043-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::15) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: b09eea70-a34f-4955-9809-08dd5cf8d96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7oH2BVqe5jk4rVUJ564D005PijSfzomyJdUaBbEXUP7pQWO8UsXFRwPPtPK?=
 =?us-ascii?Q?hHE9bjofduARbgCPG+UrMTSXQ6a9+anX+JRUtF56rRMRUXaZ/lWo41Fy7FFC?=
 =?us-ascii?Q?7i4uSOAUEg2vWW5r00XcIgBsGconTjBDkS7qms9o3vZGbVJ2yfkD4By7FFCS?=
 =?us-ascii?Q?7XUGJ7uT8X4XqhWyrIUzHrLkl77oqpCwxMSRmKt/1MOJIDli7GtHmru2PWZJ?=
 =?us-ascii?Q?KwCw6OGsf/TUeGAX3aCMQrgOw69XBTcLWnIGodNzNnQgyhGjP/UiLqqtWTaF?=
 =?us-ascii?Q?uga+BP1wc1ajBQrB3HCWRDmuS2Dm/2sJq8AnLKI3lEry7FcitvrdiZiPEHm5?=
 =?us-ascii?Q?sp5zawQn6AZfW+vzQ2va0Y/96vaV16ONnM4Dq50OxTyNwKDDKiSTfjemZLSy?=
 =?us-ascii?Q?4axIiLx6qEb7ukqaWhT7/qTnWasQuFQ2tW+K1tDDyAPDYpJPtiA/1dTWApwJ?=
 =?us-ascii?Q?sGwviXmwgoZj+mqjTQpGvLVFp+2mna2sisLPZ1nSAkQE/ml18ZjhdpH0Gr+H?=
 =?us-ascii?Q?YTmlYwEvcfDKqjtmlggri3zWHXQR88oNweXuByg3Vw5IieDmDerv0KYGfWyD?=
 =?us-ascii?Q?p7M3xwGR3x5LWsrCn1Te5bj8o+SzvM853nFcKXeODLhjSAskJLO3+E781J0P?=
 =?us-ascii?Q?fEOd54gfwZqVusVomnyC0JCJx0xuRnFUt7nmRVgDYuf/7ymcoeZ6xxYVn/pG?=
 =?us-ascii?Q?XqcOzqCf2OJgqoYvqjjjlJNPdHvebZscR9kaN9rArMo9iRMVoxmlDKR9Z1pL?=
 =?us-ascii?Q?x/tS7073kGtQXSHFosm2E3f9ZwlBnDwr2j2PCGtmcPafgCYN/e+FY55S7/vC?=
 =?us-ascii?Q?XWqya99O7JgR+xRB6XrdjZST93/YMjANQmyx5tL450E8SLJclfzbIH7kd8Pm?=
 =?us-ascii?Q?rt78JKiCQW0DOHC6NE8BZdSTPcSBC4cWHOENfeNOMh4ZAWecUD/jypLkdLAI?=
 =?us-ascii?Q?khMAMpi9dCilKi7NSUq53qJOUTN5nX7UmL0kUg2rvxMW7wG9awHuXfvBwX1U?=
 =?us-ascii?Q?vQ79Lm0oa8U1vHeQOlAS9/vjki7GIvBbG57U6ApSU9DjpJQpe60TEzNu52t6?=
 =?us-ascii?Q?T2mR3AAXhETzKNxecULbbFDeeOtrLZucZyHmQNvbkMIyXlWi7licrQ7M+gZF?=
 =?us-ascii?Q?purAvPHNLijAldxCIb62562HrrLlW790SI8g11Vxige1vHPJs/J5y+nLbwe9?=
 =?us-ascii?Q?M5upefzVobdfkYua+vgQepH0kvna1c1FDfkN2d1I0OqfG81XzAhYIXeAwznL?=
 =?us-ascii?Q?A4dIpCT93cLROyAIR8cee9BY/GEA/7B4NzVAgVGX0zaNDhsgjblcrceA7STa?=
 =?us-ascii?Q?opRZLDFhJINve2Ylc1u98iyyMmCIWZBBFVJ+YqHVe1cPfT7GyX0wnGvoOtQd?=
 =?us-ascii?Q?8MDEYBDUpHuiEeqQL8VgJdiSpZndqkb8cZ+iJXBTINvNBM/4eoVGdjc2th5N?=
 =?us-ascii?Q?mYqeRxobhvqgZKb9wfFB4OLzcV2JTXmj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hFFSTV7HtcbIRdFUTbOmxRgTnJvOBqF10yFV5RdUa2+meqSJiHD6mwIEuTyz?=
 =?us-ascii?Q?jefuL6qbqjan2452ODq0ENIFoXbF9au65yKJZh2zvu3Ln9dlSH5216tepR9K?=
 =?us-ascii?Q?NFWngazmSp/421H1YjAMlMmVJ0b8xJyw6zFsMKAehillPSpXri8IvbeZOsFc?=
 =?us-ascii?Q?oRxPO4uHDfn6gvKmRSy0KiyXeLesatOUb89LNAFYKkZ9Zu6AFqKSz4mvjc1l?=
 =?us-ascii?Q?5y+s9Zr+F8EGNO1zRPZDb2UISoi5ai7TC6QkB0CBakjq/fP5uUOnhMfouzXj?=
 =?us-ascii?Q?XqnOJMFDmOECnUiBOaNxlMKc/5YYoSaiuqbvPupbrF8iRrcYlJV63NfcxtuT?=
 =?us-ascii?Q?9Jlf1RYBUmDnb9CM4VAdeVt318H6o1nLcQMy50hYZAynifkPltNbW3WGaj4z?=
 =?us-ascii?Q?NfMfC7dSSynXAlFZI+SLEgv0EBFbaDc+imondRBXH9iMgPvsOKaOTq/Fx/wr?=
 =?us-ascii?Q?Cce5l/PDYzcF7wlTaWI0iq3szzl6ozfPbw9lleUE+TZKIVuycAPOkG9LxHzb?=
 =?us-ascii?Q?ac1VVSD980yo65Ehy30L36kiWbTRZo5va0HrvWYMM9pe6VyDXho2hMQMC1jB?=
 =?us-ascii?Q?CC4UoxMqmLomP51qWhCoxPfjQ4J7FneBBn+WQRMNdohIhBTOG/ufy8MBCEH+?=
 =?us-ascii?Q?aQpFMNBDlhHyAr26k42MYjfkZOojTPfryRaS3P8ND9PPy4IRpjPSxDfJ87WA?=
 =?us-ascii?Q?L72Y/CTo3ZyvHeUW1AG0mq9QgHQE9UyDLDi2Jf6R2rxo2yYITW5ta5M3JXoR?=
 =?us-ascii?Q?cmUT3AQ5XQx+01a+mKN+TCcAc8vA0V61409mAjfRt70UO3a6Mv60o2Ojip5Q?=
 =?us-ascii?Q?BGNGrgphpY1lQf4KJdClEDlMWeWU2OjePSadCUsMiLpiV8AjiBbJAxE2klYe?=
 =?us-ascii?Q?GuYNPwytduRTElgj7BLhuiLnjEfdKvAWGNlRVK4UM8Z/JnvsI0fWOWU/xTeQ?=
 =?us-ascii?Q?gFtgkjLdOpajonmEmJnybbyfIHqHsbLAHEgmSb+axBbWvLDQrK+xTB4T67iA?=
 =?us-ascii?Q?6sBJAbRDA8E0MIIKURHRBYjnzDpBHqDqE0hXCpg/MyVeVhuFiGGzCAUvXP5S?=
 =?us-ascii?Q?TGhu3VCqEo2zucYX6U17EiT+9AzE+LXwIvu4x0d00D2Igg+CuHc9M16aEJ2G?=
 =?us-ascii?Q?VB70Z3YLqGRwSHRIH217876+gguPRDdhnzE+AAosuRsGdW12P2yg7pHPO6ML?=
 =?us-ascii?Q?v7gyvzbjdcIJBNs58QhvzSK1VHKOowwDkzBp2ZLOXFJ/OD59Af1xyhM4GKvD?=
 =?us-ascii?Q?scrudkTdbHiZWZs46ndAKhzf4lneNMOYFJ78uTMNSb49HSb+LIg2VR72ssfg?=
 =?us-ascii?Q?/BiS6GOacpT8KiZBTVR9Mq9lMAAVsSUfvC4wRsT6PftNPFwqVuzqAhqDzd5s?=
 =?us-ascii?Q?KmuZIK8Hy3roBkcY+P7z/1L0xMWCU0c5znu+9hhIX5K4CL5ZgPIsuluEFlYR?=
 =?us-ascii?Q?bL6Ae2Z/KU08hi+7dOwdDRT0Yc+9QBp0dM9JFhXdyQ9BXVTsdstKa/dfxJSu?=
 =?us-ascii?Q?9Ost1cQvBNi7HnfiDEclvlPAM76RFtvSxBCtdsJpOpJmTnhE2jKkSlK2R7i6?=
 =?us-ascii?Q?B41v8di6XfOp1h9s9A5EZCpkZovEsyB9uApsAm7lN20TcNUINjmi7SKy1JL1?=
 =?us-ascii?Q?fHdz44INr3FUie0xqzECrvY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09eea70-a34f-4955-9809-08dd5cf8d96e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:50:02.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvM4InqV+eia8LFFEF5Iv88vJNAXmvKRtA2dW42HtNEpPefUtfBoig+wE9pY/rh1bq9pUFh5BAIerWDMRxJPILj3xre1LoGe/U8uu3ekAGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7091

LKP reported 800% performance improvement for small-allocs benchmark
from vm-scalability [1] with patch ("/dev/zero: make private mapping
full anonymous mapping") [2], but the patch was nack'ed since it changes
the output of smaps somewhat.

The profiling shows one of the major sources of the performance
improvement is the less contention to i_mmap_rwsem.

The small-allocs benchmark creates a lot of 40K size memory maps by
mmap'ing private /dev/zero then triggers page fault on the mappings.
When creating private mapping for /dev/zero, the anonymous VMA is
created, but it has valid vm_file.  Kernel basically assumes anonymous
VMAs should have NULL vm_file, for example, mmap inserts VMA to the file
rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
will be inserted to the file rmap tree, this resulted in the contention
to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
to insert it to file rmap tree.

Skip anonymous VMA for this case.  Over 400% performance improvement was
reported [3].

It is not on par with the 800% improvement from the original patch.  It is
because page fault handler needs to access some members of struct file
if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
the same cacheline with file refcount.  When mmap'ing a file the file
refcount is inc'ed and dec'ed, this caused bad cache false sharing
problem.  The further debug showed checking whether the VMA is anonymous
or not can alleviate the problem.  But I'm not sure whether it is the
best way to handle it, maybe we should consider shuffle the layout of
struct file.

However it sounds rare that real life applications would create that
many maps with mmap'ing private /dev/zero and share the same struct
file, so the cache false sharing problem may be not that bad.  But
i_mmap_rwsem contention problem seems more real since all /dev/zero
private mappings even from different applications share the same struct
address_space so the same i_mmap_rwsem.

[1] https://lore.kernel.org/linux-mm/202501281038.617c6b60-lkp@intel.com/
[2] https://lore.kernel.org/linux-mm/20250113223033.4054534-1-yang@os.amperecomputing.com/
[3] https://lore.kernel.org/linux-mm/Z6RshwXCWhAGoMOK@xsang-OptiPlex-9020/#t

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 mm/vma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index c7abef5177cc..f4cf85c32b7a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1648,6 +1648,9 @@ static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
 			       struct vm_area_struct *vma)
 {
+	if (vma_is_anonymous(vma))
+		return;
+
 	if (vma->vm_file == NULL)
 		return;
 
@@ -1671,8 +1674,12 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
  */
 void unlink_file_vma(struct vm_area_struct *vma)
 {
-	struct file *file = vma->vm_file;
+	struct file *file;
+
+	if (vma_is_anonymous(vma))
+		return;
 
+	file = vma->vm_file;
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 
@@ -1684,9 +1691,13 @@ void unlink_file_vma(struct vm_area_struct *vma)
 
 void vma_link_file(struct vm_area_struct *vma)
 {
-	struct file *file = vma->vm_file;
+	struct file *file;
 	struct address_space *mapping;
 
+	if (vma_is_anonymous(vma))
+		return;
+
+	file = vma->vm_file;
 	if (file) {
 		mapping = file->f_mapping;
 		i_mmap_lock_write(mapping);
-- 
2.47.0


