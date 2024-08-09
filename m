Return-Path: <linux-kernel+bounces-280972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655694D180
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A6A283A7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6791DFEF;
	Fri,  9 Aug 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQqu9iwF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B918F2F8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211113; cv=fail; b=qzEd/YnwpfO2ntCv4N5VfcRfjugpJq1y6u3OG4QIpWpC3h9OLvcHxGEHK9faTieHxjrvxKHMtaqI9PaBFPY+N1wxnMuSYyemzRBLhDdg3bBcdJFLgAbcUv3ObyeFiGghzgWOp0xD9llyCRoMtgl5KTo/AXXt1PNE18zcIDGjJ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211113; c=relaxed/simple;
	bh=JyZwXZ39PxOSUHSbsRD3E4kkCbNzlgMUMCAqS/pZftc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ei0yOolGnhLOZfMusQuLAzxBywn/12UzI1huonezCRp9ii9tsrPnzhAhpUzXsG2SZuhRywmV2YU6lTJcIC/vjuyto9q1RAXbchfZji3rArp7ZE6C86UfvdpzPHujamVMG7kkABh038PCPRm+PSesaZT9mBy3P07aErLGJo8nUzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQqu9iwF; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okLWDu2ek7878GHRJU6Zf81I2Roy94VIYdgUNgAn2rW9EJXRC7on1heISkdfb/tXG/IOezl/tp6YU/5PLVXMtCoLNK/CACcinMLM3jlK7tf1lA5LKut8/8KbBeRj3K64eouMNTzMg6OYiVB5yqEp7oZ4mReYWuf8m8jBx+vhPAOcMoWeR4W5Ect00Q0n8A4KLvzDd7K3hTloTxXxmhuj9Oh6+76jBCsPRfevClv0wJgJDZJfB3eJB2GCMZzaM+SDQ5/NKp7xzaXN3+dwxRD9WZoM7OtYBQjEgGoVA/O+6am9JpkXfx1pjLLyVo0ziktqRh9w6JcGOLpVj3W+5ak6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvnbZeuLHTHpSug6cb+x+Y/tB9okijkgpTT7Nrwnscw=;
 b=bALG/HNvvYAuMJmRjjrK63paPSe6JuDuayBC3QTMvTTeIDb0S1DI3XimGUhYbKjgg6sZ7X5rtwz73Mz6KPkdqc8zqx34cjJx+yaAsu+3Z6I1a+z7q2Cgur7EwKafT862Msn2zUuhDbZGyU64k1mBSDA6xWLopI+CDJvx1fK2W6V7+ZpvbMtScGAs0YqUYHnN/9UTf65vr1M9TH8ZaTfxBKLy3r8kyrFc/Sp3tsnag5H86tJVzhKVCk6n8F2BXzVfr/dqMIMINQ9yVa2u99X6kWqHzzj1i3mxc9msU7g8VzWzoOWhHBkzy75zDUHucuTRBwFLbVMQaks1OQQcXlbGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvnbZeuLHTHpSug6cb+x+Y/tB9okijkgpTT7Nrwnscw=;
 b=EQqu9iwFlmvzwPjG1F5rld1DtqA04EePGQl5nDYS/JWvZu+PoXk27Bq6zo7ahuabppvgHnl7nsvQ5YF79jg27Etw954eiGh9wILVBkl3kXywOkDkeNdgOPN3jUxpuDL5dr1tL13CZMJElaZYQooAijunNeeNSQoXtCMagSIyHO77XMB8OzGxqCu499yxLD7ATczVwceeRUaEzAGZcQPv/G7MP4l7fYfT8wy7od3SvEZtNmI7PM3qnOSk8jkLLnLy9UT2VGukAR/SgqE2KxO7ojSvxWjVoR3WmyqsJa5F6ty7wcJq43wP+k+2mhDMExvRw8HV4oF0zRwC7/5jmzaNyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 13:45:06 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 13:45:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm/numa: do_numa_page() do_huge_pmd_numa_page() code clean up.
Date: Fri,  9 Aug 2024 09:45:02 -0400
Message-ID: <20240809134502.1504111-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0319.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::24) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed59a1a-b0d5-44e0-5614-08dcb8797a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ns77psbo74IUTlVj/5VTwkR/zbNDnQF32MTp14rcgtk/BossuhTmFdsDAd0n?=
 =?us-ascii?Q?KXu/G+fFTHVFLjexRWd6ri2eKa3So+ds3jQgT7QJw2t986MVfbddPrDxMEH5?=
 =?us-ascii?Q?CuGopq0MDQpRMt18hZF9eclF/iGu8qLC1rF3Rm/OEV0nAKiDeP8ADxvn/iI4?=
 =?us-ascii?Q?YLF5Fq+WPq9Y72qttiBCCwa11/XhxGXMeesMFuE+a9D2eHwlaFk/SjkSpPsf?=
 =?us-ascii?Q?8QdSV63UocXr9Km+oIQPDLWeDAbd4qrAy3+H2P4/F96jfKBdwQ5IPw7Vl12y?=
 =?us-ascii?Q?a0Z++uki44zAMJ1jRrCUGP7KsOTBiHGY3Rd026XmylnSp4LURq54y8GWPtij?=
 =?us-ascii?Q?1pkcWs3e6Nl3idR6TfDqWV6arK47s2gWhiznuFWhM75iUvwPvVu/njqGugoc?=
 =?us-ascii?Q?YsFtuKk4D+5YMWGy26YJewRzraiLvR4fQGraj4knQZ40COLJYWdVQAWOuJob?=
 =?us-ascii?Q?RVDqbtwlUhXgA1rOduWJgAOav9RAYJxKUQuf89uMHZQIhYUVjNDlOY3AERoD?=
 =?us-ascii?Q?kAoPehH7O+yXy+SobqaRR1QKfe6xB3fUA1cZKmAc4UdCGSF1GPesdvlYuZ5Q?=
 =?us-ascii?Q?Zlu0YuwRvp9qu7lQerlOR3DJqvh5tWOCmIJpbfMs/ymyN4CzlXQu/cpCUab4?=
 =?us-ascii?Q?emQfr1xwbolGYWWHnqfMICHCjp2dCrDrkZRFxh61lz1w3K2k8zdQ5RyVoRxT?=
 =?us-ascii?Q?C7RFAKhuydNBJPwrTIZAt6RVocEXUkZHkQIS+dUICXZXD/n4zpLmICLP46r9?=
 =?us-ascii?Q?C1O8sbQ4DEZjmVubKMmlfeCjNfE0q4AhvilanDUW+iemPQXuoTV4RlLcbUEW?=
 =?us-ascii?Q?Ld/xDKDwUOluC/NLaUWTGYjeN3qXsf+XQuNBAbT9JTfZyPD5u5u9Llo/E2+P?=
 =?us-ascii?Q?b/e3Va9OHD5Mx9lp0oFG+w0V2Bgq29piOKpfmlqwb6vyP7msZWpGRmkebFAC?=
 =?us-ascii?Q?ZHkoWcm6s++K9vG3ZgBJxjar84On1goAJ74oJvRHfYRCUF7OZEtAecKPWbhz?=
 =?us-ascii?Q?wa2mDLLUM3d/m4F+ybUmj8j1lbZoCKsi+AjiozZITZ11Cb+bRYmTIqI9lyub?=
 =?us-ascii?Q?6QEEAmUZu3FEj/BvcgnqghABkJSjeteQGVeiY6MzT1+qZFEDr+xW/wN0iVq8?=
 =?us-ascii?Q?q/fFqnDpB1tm0gukwr8Ww9UQb+b/z3VV9tgCw5XoSEwSwGTlKi9poGx/llnH?=
 =?us-ascii?Q?j7Bj4IHYJOfSdNgYax/S4QXzW19tFUdIVLrwwOSv2Nz7ktFfNuRFP2INuR+4?=
 =?us-ascii?Q?F4QGlRFmsUfuorHBBVj6yJX/FC6QK3SvXDvRifTQA0yFublzKl9kE5SMHUij?=
 =?us-ascii?Q?7ljnzToCTXB+qdOaEWfidI6isytovufFFWa06n8Hkojmhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iwHgmIBbJhmNWb3H0r70b0TUPfaB5oSAvklkvwfk4/LmTeY33C12HowsDaho?=
 =?us-ascii?Q?o4BmiHF/V8KtS+NzN+UDWttzC/5CuPaIj30ywD0EABbkEZKjqz1s32BRjmOd?=
 =?us-ascii?Q?PIkP6qHGcPIwrbUKoztUXktdYgu3BH38VjfLLUPnxoMZg7Dham9nedA1PqdG?=
 =?us-ascii?Q?7y+MMQKJ3YWTYpHpDIos8i2Pt7xqxMvnhEBfB1LQHmaOn7jSXwXRqw0fpe04?=
 =?us-ascii?Q?E70SUqCPgv/1TXDIwq1TmJikPxODtYRygaAgHcZkfxKvPA9oZCUMLjTiPaKA?=
 =?us-ascii?Q?jf8e9CWSmVCuTzIa1gmoGR9Ic7h4ZxhrjTNTtxjbP43/yC/DXU1K2U9dnp5b?=
 =?us-ascii?Q?Ng4hur3vltapmJfkyuFaGlmglJsob5MIbPdr3nWTwwT5HL/zVIcwP09C/arf?=
 =?us-ascii?Q?G0NaheDJEIquXcEXjW0+X4N9AfWDa9An/EevZibTmxGLCDXyiwQ9woPUasCl?=
 =?us-ascii?Q?mDdTdouOVbGQFvh+m6kwgAvNyT9qEC3JYSUfQFumpY8xzwH750MHeC7CUfkO?=
 =?us-ascii?Q?yMEbnXXkgn1T/bHujWLpn5jXAD2upPbJYL7IrXy1vVSjPIOXYexmRMU9VelQ?=
 =?us-ascii?Q?25k/vRGki14fAW4gG6O+b7eURkA64eY6po29sBtwT10ITFcSIXFMhh0R20sG?=
 =?us-ascii?Q?RltYKC1Zy7DwNLbNe7LyWBQX1rEdM2k9eQ9oK7ecuwJJ+Jw21d34ioaK3klu?=
 =?us-ascii?Q?ckAPuH9Niaq/U5RQUyHkO7L7bxGBoDcnYFMczS6SfYJZ6dxiNduNNiLvPry/?=
 =?us-ascii?Q?e8PPvATJMZxTgZAyXnGWtYGhW86e9R3UihA2BTaT4Axfn53EQkV1gOD2PO/t?=
 =?us-ascii?Q?wvyiwnPEoZ3qwEPrAnhnfGL25zZEUqcy+kzv83Kbq/ZwLDrY3NFpE9ch9fF7?=
 =?us-ascii?Q?l2xiQ6nvb1qcmEDFAQqPV2oRSTuy28rhAbZ70QG1acNW5s6rdjLcjHil4Dnj?=
 =?us-ascii?Q?ziDtwed+G0FRpF+eKRTLXkLEp0nakbsIws1D6NPuR5yMKjUI/1NNm36cZbjk?=
 =?us-ascii?Q?W7qvrDh99IJ89wYQHSVLsyaIy483PJLfVwFgAUBCwHL0cOij9uygiHaNIdBc?=
 =?us-ascii?Q?31vQMCz576LSp2zVmDXZyUZRr1wrcYqFrlDPLWreHVLIxSALqjOTEItbn2lL?=
 =?us-ascii?Q?e82qUkCL4hDiIBXeGk2C5sr9OXL1wk4sqK0SVryj+0jQgM5LHz06u0kaev3T?=
 =?us-ascii?Q?z8a+lg4z+pMw245Z741LGfLt78K6Ryv+nyQWOvlVOVxNhUOyNysQhQyMeGIv?=
 =?us-ascii?Q?2dlQEiITx6byN6mxH5OyS5PkQ7lP/G7wJdjR2r6TnckiUyNgi3aFTQxNSy9x?=
 =?us-ascii?Q?NBAJaKVoEf1pKKNg3HXnkaJbWY6xowTmQAREAW2xC1qTXVdy5mtXUJNFDbSF?=
 =?us-ascii?Q?zV/qw/RCCy5E+Ns1AbOp2pbwpUQ/iE2FB9rOZ/z5sB4i8Iiv441LUtU6IKq7?=
 =?us-ascii?Q?hKLhlTn+tzL2OFOR5pYlpMzS+D4BFwb6Yfn0qc3Hpwe0m8fmG7GpPmf0mIAO?=
 =?us-ascii?Q?cO/fr+vr4i8XK10B+J6B3MGxw+628yKWLRxOjDKzyrFHZyey5jSZogxzX4zX?=
 =?us-ascii?Q?7b8UMSsASwxyxoj99TyLx9ZK9VEX6rTtyWVRhlQ7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed59a1a-b0d5-44e0-5614-08dcb8797a7c
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 13:45:06.6443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JChmzHLM5iNVUqaDZanzS/qLkq1Z/YBJew8TRai8xg2kaJ3IolkoC0vZovrbhfp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650

Remove unnecessary else branch to reduce code indentation.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 13 ++++++-------
 mm/memory.c      | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 14f314bfce10..f2fd3aabb67b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1719,15 +1719,14 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		nid = target_nid;
 		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
 		return 0;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-		if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
-			spin_unlock(vmf->ptl);
-			return 0;
-		}
 	}
 
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
 out_map:
 	/* Restore the PMD */
 	pmd = pmd_modify(pmdp_get(vmf->pmd), vma->vm_page_prot);
diff --git a/mm/memory.c b/mm/memory.c
index dd993fb3f654..e4f27c0696cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5528,16 +5528,16 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_MIGRATED;
 		task_numa_fault(last_cpupid, nid, nr_pages, flags);
 		return 0;
-	} else {
-		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					       vmf->address, &vmf->ptl);
-		if (unlikely(!vmf->pte))
-			return 0;
-		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return 0;
-		}
+	}
+
+	flags |= TNF_MIGRATE_FAIL;
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	if (unlikely(!vmf->pte))
+		return 0;
+	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
 	}
 out_map:
 	/*
-- 
2.43.0


