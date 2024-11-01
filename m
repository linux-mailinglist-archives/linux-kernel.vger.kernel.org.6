Return-Path: <linux-kernel+bounces-391803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AABC9B8BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12471F22817
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB471494C9;
	Fri,  1 Nov 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gYYkADr7"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCF5D8F0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445279; cv=fail; b=KSjxs5SwE5yAgJFY2iuS0Z7rGnLidtUXLnPS3mtlDiBJdmYzY2SIwQOUMvFXXraNuzgePDq50MvYlbkoQNITbGp6PJGwMbA5d3kT2AF9XooEcMziYHAeUYykyGJheggc4+xaTWb7Y5XHOI68egEosT3iW3jUTIDSVbqlYYlBg3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445279; c=relaxed/simple;
	bh=w37/TfrVx5E1VQ9mHPf/eZm85CipjS4hQo5758WaD+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pMNICs5VSBdnI7GedzzNChGQoBgELRzROf3LEAshvJKTMIge1aus9KwbuHnQL3puxo6ngCw+ta+GGWqDSLnCR06DW+LE+Lvax8O7oXHFYJFc+tU4R381lIDwdPgxVGoX1vRLuhUk7aHleSZY5j0j+F42lm9RWTtpp/PC14wLvLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gYYkADr7; arc=fail smtp.client-ip=40.107.100.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLxA74oaCVKwi3C+bgGBwZzXBNtV7XuBgxXrQQaWdw07wUTyOk7ACPXmmk4lNRvYkgXK9LmRRx+0ihxjJ3ASmnBTvll++AJ5HNBP3VJq+jg7MBjbDi+iedRskcb5a9tEl/SsNSMBY1xxBXq4TsSuZFtTGiK2qtqDADSjwq7Sg2vXLNkjCzI5HFhPlBETavFoSMZxRIf/Xn79s+b4GayjjmZp2DyvrQtfdQeXUmpdnWFiCP3Nd1SOETb3El+pvP3pWZqB9eEMus8JCaZqCUVuPTyqScs/Epbil+aHa7ECUm1utd4rSyf0rpryKJJSeUlTOW2gILw1MRk3F0J690h69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktLReD6tYjeMCJKpTiEmA3iBkEtoA/C7FqrgqH7ZQHE=;
 b=Fm+CJmVXPzOdh3OXMyDmSSiFVzW0yQz70Rwy+qAOxbyAFrjm25IjvvVGPFSninZf6HgyKrwdo8aT9GUmzu2yjNrPFOx47fGKJ7HpI1oWkpkTKCQZfD02aUMMyh7TrCw0ZwoKcpiqfx7rTMzPPS4d9N3928Y0T1poraPmqed8oD4T5UX/LCcQGHxpkhxGkGHJVtr5MBT9gH6Jb9oQFzLE+zeepTX2WwSfgjzbNyYO48JCAca2OvknnKeog+u5TWm+dluJqIpQKpCseI4TYBZHXu4bth36p6o0ZsfX0hYZF9DRrud7nHvzXdc6SJa1S+IvaH56BbRojrhx4QmCQDPcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktLReD6tYjeMCJKpTiEmA3iBkEtoA/C7FqrgqH7ZQHE=;
 b=gYYkADr7ghzGaJ+2oLEfgDodCLWamem90p7bM5UUpvXLHjg20+JuLVVuYZx6Zf/zhqybRRwynRTLXk7EhRIAYz1apd3aZijG/aJ6UxHX9sgz4jCTsQ7LOgj2jadOb/5w36SrkMGzaLAggI6Gy2HbHa/8VPFQeLpMHZQaHflq5bE=
Received: from BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) by
 CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.23; Fri, 1 Nov 2024 07:14:32 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::7b) by BL0PR0102CA0065.outlook.office365.com
 (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Fri, 1 Nov 2024 07:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 07:14:31 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 02:14:25 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <shivankg@amd.com>
Subject: [PATCH] mm: use vma_policy() to get vm_policy
Date: Fri, 1 Nov 2024 07:13:50 +0000
Message-ID: <20241101071350.402878-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db6e976-2950-4a37-6b28-08dcfa44d527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2qcMKscPsdJoSPJuTMl716D8OMr0Yqwki9IxtCqCM6sjPyLo3u8wS/kLWMOl?=
 =?us-ascii?Q?8CKEHp1vPx+bbCAxLOWzqYzTnx99pQ+FuUgIkFvZcmcKR19t3DYu7po1PUUB?=
 =?us-ascii?Q?meLzgAWbXqR9RzsA3UNHnELmQocoQKFvWjBKMMQbhYU9NwUsFwdn9WF8GUm6?=
 =?us-ascii?Q?Yrrdm+iIAaAdzQ+VC/b4U3xfyGBfF81Hf3xdCgBwsCi75prtmj5S+iQ1Ox1L?=
 =?us-ascii?Q?CiJT94Yw7HiK9nrXNWMH9VeMmZNyGgOIvVSGQfgXA5JMJNRBMPtqMUYzhdko?=
 =?us-ascii?Q?XTo4eq8yVL5iDZlFLK8r1QRc3+BToSSQ/A0yaEtdnd7HkVwwFtsAk9yDpH/u?=
 =?us-ascii?Q?GUluu76TvqENE562I8NHlM+8iAtqXoYbPz7DE64orC3HzVZigHeVDOkwKL/l?=
 =?us-ascii?Q?yzW5AUTHNzbyR+oI6Qr8jYtX6BxepvuAL7v0uE6Ce4Zc1mUX/F9YZz/0D6OZ?=
 =?us-ascii?Q?QTLQEt0qC9X6TR4FoDehXkVptvJ0dSeIRhmjC1bd/iTmuaK4AoLBnbDFTKm8?=
 =?us-ascii?Q?BBzvSjBJ50NyiDaXoO19O7rYE17grhALjJg6UG/67RRZcNLODqmwCwr13HWj?=
 =?us-ascii?Q?+NlH78l1KPWkeumlmcggYNxtXT0N0dOpLBoZ95BBb2zYaXyO6xE+QqSOfGb+?=
 =?us-ascii?Q?BnoDqcD0BUXSzL1ilO3nuOVy2y1PwUQEoWgJXXksk4KFjJnbY/K1q7AYet5n?=
 =?us-ascii?Q?aNym8QgpNiotCpVgYZmb/hn86RdWNrPGgVRicpSLIjWnsC0/iB+krcrxVDVj?=
 =?us-ascii?Q?J+9N7oneoMOXONWaTP5VFQzmp97KeJMaGFO0kwSuVit0QJ/PhkGnxoVbhLRO?=
 =?us-ascii?Q?ZAbbY2dXSNvgEhUKUW3cfh/Li1Vuvxm7TlhL+UAtnMoGoHbG7uYNOqTHlOG/?=
 =?us-ascii?Q?SjL33vhw4mAylFc3uFjpkXu15c0dtaLZKMH7iM4sPeq5zYCcxfEfKkTGNaec?=
 =?us-ascii?Q?XtvWjnInK1ySTL1O7XgX4fqwjvIQYvc1RowvroriKRIN0kK7+vrwSpy3ZLN3?=
 =?us-ascii?Q?+rNd5xRCG59r2oBbpDdet/8/UWUT2CzuoHTuySCBEB/PFRvhm4trEXyaqbg8?=
 =?us-ascii?Q?zN3nOEFLm2CrpzuFLDFxedCa3mgotO7jcBGR8i9mgozcynTBmLRbYhiaQvyh?=
 =?us-ascii?Q?3d+fHdR7BSEuXJIx8BNnkHs1pQx2gYv8gJMiOLBimsqPJglqZQp+HVa6DKNx?=
 =?us-ascii?Q?Cdsi7rsIBFyeoF91gqRST1tJT56+BRsJuijBE5WNz3eC1Cwi6lvuqDJGazYd?=
 =?us-ascii?Q?9tCvDdhWKt7jHiOnPY8ViOCcvoDyA+wM48r4VpJvduo4zRXfOU/EuprqcOI5?=
 =?us-ascii?Q?FVhcCzJ/jjpNS9sRMZNDZWo9htnSUpEfZpKoGbuDc874YQV24oQ9QeAHV0xk?=
 =?us-ascii?Q?nHNinb4HwsfeM/GhJ7ruq5r6RC40y3YtmVZlH0o/ibsieGyl8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 07:14:31.9837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db6e976-2950-4a37-6b28-08dcfa44d527
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

Instead of accessing vma->vm_policy directly, use vma_policy() like
other places for consistency.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 ipc/shm.c      |  2 +-
 mm/mempolicy.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 99564c870084..ebd45e48b0d4 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -577,7 +577,7 @@ static struct mempolicy *shm_get_policy(struct vm_area_struct *vma,
 					unsigned long addr, pgoff_t *ilx)
 {
 	struct shm_file_data *sfd = shm_file_data(vma->vm_file);
-	struct mempolicy *mpol = vma->vm_policy;
+	struct mempolicy *mpol = vma_policy(vma);
 
 	if (sfd->vm_ops->get_policy)
 		mpol = sfd->vm_ops->get_policy(vma, addr, ilx);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b646fab3e45e..7ccbeb9966f0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -420,7 +420,7 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
 		vma_start_write(vma);
-		mpol_rebind_policy(vma->vm_policy, new);
+		mpol_rebind_policy(vma_policy(vma), new);
 	}
 	mmap_write_unlock(mm);
 }
@@ -805,8 +805,8 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 			goto err_out;
 	}
 
-	old = vma->vm_policy;
-	vma->vm_policy = new; /* protected by mmap_lock */
+	old = vma_policy(vma);
+	vma_policy(vma) = new; /* protected by mmap_lock */
 	mpol_put(old);
 
 	return 0;
@@ -830,7 +830,7 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vmstart = vma->vm_start;
 	}
 
-	if (mpol_equal(vma->vm_policy, new_pol)) {
+	if (mpol_equal(vma_policy(vma), new_pol)) {
 		*prev = vma;
 		return 0;
 	}
@@ -1797,7 +1797,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 {
 	*ilx = 0;
 	return (vma->vm_ops && vma->vm_ops->get_policy) ?
-		vma->vm_ops->get_policy(vma, addr, ilx) : vma->vm_policy;
+		vma->vm_ops->get_policy(vma, addr, ilx) : vma_policy(vma);
 }
 
 /*
@@ -1847,7 +1847,7 @@ bool vma_policy_mof(struct vm_area_struct *vma)
 		return ret;
 	}
 
-	pol = vma->vm_policy;
+	pol = vma_policy(vma);
 	if (!pol)
 		pol = get_task_policy(current);
 
@@ -2559,11 +2559,11 @@ unsigned long alloc_pages_bulk_array_mempolicy_noprof(gfp_t gfp,
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
-	struct mempolicy *pol = mpol_dup(src->vm_policy);
+	struct mempolicy *pol = mpol_dup(vma_policy(src));
 
 	if (IS_ERR(pol))
 		return PTR_ERR(pol);
-	dst->vm_policy = pol;
+	vma_policy(dst) = pol;
 	return 0;
 }
 
-- 
2.34.1


