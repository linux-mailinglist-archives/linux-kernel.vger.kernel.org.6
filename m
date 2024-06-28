Return-Path: <linux-kernel+bounces-234513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C791C784
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F49C1F21BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398179B84;
	Fri, 28 Jun 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CvZWN/Tx"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073CBA53
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607990; cv=fail; b=gsu8+XeX3AScPEDzIf2a4XM/wgW71zbZ6yE9s5WqNASby5bn/tthOiJscM81p1pKRb/wtG7jDVl0RjL58+BhSY5iMoStphDv9sIQKgM32TBFVzLVaHRv3zy0sB2tM7exQFJFdvZdylDObwdzg1VFx0vhmwgvYlwSTC98gzR/D5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607990; c=relaxed/simple;
	bh=5+l82lsnVnC65Zot5EYZ6CKn5gaSnV1h7ZDMSHBJkKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GmrkQNTtpRswk7s1Xafc2Hm5BIJT7ZigLtGdxXK26rWyqwFf8e3KVXD1fTg1aSWr3bEdjqy8FNM8lODMSFKVH2XobJ4PuGSb0Ut2IeLCZjQuB+j51x0NTAZ3UXtTisVuIcTOX0kWRXJTGz0LRRBtd9UHJWXrFFk/5m03VwwGR5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CvZWN/Tx; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr+f7AsyZVJrF3TWe7sPC/oUqQM6ovNU8XlzRxGKWEyL5cAHfQN6hSBJSq3Bg+1EM4kzWavsrgPLciIA50OLEwqJ+yXogThlVNcpNEeZ0Phr5NWqhkYYNyvfX6EYNtqSOt+fj5/AWeoH3kgCny7eryUPS7NDWVJIYl4LNff9S5tRyL+NAc4UsvY7XU95IzrD4Rmvrmg7/64YlgJ+oS8GEHXcmDeRXvkg4ysO7CLZftLIXmNa3TE0choMrUB+XmxR0DpxCcfMRcJ3Cz8Q7Pq582cfOYWnkQGa8JgO8S67KWoPUPIyjSVxQ+FuNKpC2EzobEwYkbMArfYNiv4Vv4Es5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BghsmzbdNSQ2+wJG3e4MYDXPAJ2gYT0jJnpCnv4itg=;
 b=QPgXi6YRvpTyzEcVPGKHHI1HdeFIm9pN0jbgTm4K0G1hP2vs7wFaV0najl8XMIlWihpNAooqBJnzMeW6Rd77dhshWJVgc4t8/15zBAAhgg+Fyw5ePCjNjrfCxAKGmq0oD9F3Vi1q8Ik8jvEQliJ+sL+s5+OFyioqEcLqptKMkoAR7ItubWNK0I9O+KTXUmmrJc0cTUNVJ0C1iMTpWFVkSh0b3N5N2m3lIkTmm3GYz1jnEgMqzrATaPgmN7UbMk3CtoaEUMxvgqBXNxwJsghz1UIiUNbPNdth6jBA9tXN1BvnNFKwnMPnL5sjfHmEfa9NLvnWsElE97N1zp3rJa49WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BghsmzbdNSQ2+wJG3e4MYDXPAJ2gYT0jJnpCnv4itg=;
 b=CvZWN/TxxkDbCoV+e4doTO6wnRz7WKE31D1p2NgOLJhFsh0j+xeNkSpBZd7Aa9u4pLQi+t8P3/6pxJAK4F6bbmv7/R3cBCKZUf+i74FxcEiTqf/9/RfxiqmBirtIBtCz7GiQ12aBHVDPFhuAEEpVOa5MIjuyIqOiNtvQi1oo2c8=
Received: from MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 28 Jun
 2024 20:53:05 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::be) by MN2PR05CA0054.outlook.office365.com
 (2603:10b6:208:236::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Fri, 28 Jun 2024 20:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 20:53:04 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 15:53:03 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <hpa@zytor.com>, <kirill.shutemov@linux.intel.com>,
	<rick.p.edgecombe@intel.com>, <mhklinux@outlook.com>, <peterx@redhat.com>,
	<jgross@suse.com>, <linux-kernel@vger.kernel.org>, <thomas.lendacky@amd.com>,
	<linux-coco@lists.linux.dev>, <jroedel@suse.de>
Subject: [PATCH] x86/mm: fix lookup_address() to handle physical memory holes in direct mapping
Date: Fri, 28 Jun 2024 20:52:29 +0000
Message-ID: <20240628205229.193800-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de944d5-0333-49b5-dd15-08dc97b44ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|32650700017|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWd7VAL5t18snwGzXmDl+4g3grO3Sw8PLnUOVcIaiiKGk0IOqIhphVezK6se?=
 =?us-ascii?Q?NXElst0pgXsbSIrWpoYF/jW1ENZsO+QY8dhEfNEDq4Ht0G7C+i1T5VFSDRY5?=
 =?us-ascii?Q?zaEHWtLJd7HKLrjRuWPrx8YqqF9sWPn98zO0moSlZNURedHQapMCYzi0XJ6J?=
 =?us-ascii?Q?0/boYTaXbu6zmIqF0RSD/H3tvXAY7kPmIWDxmR4o6A4AEcdnWJ/j9vRRruPk?=
 =?us-ascii?Q?u9Men05lJSwsqoCa9Ll22IcgzRZxcMksFh6v9BNtowFZ7qaNONhu34dZW1Ln?=
 =?us-ascii?Q?XIulkBg2KrG2jy2mA+z0dHjOXxPPdycwzIa/FR197WHwF4DL4SfZo7b0gVuK?=
 =?us-ascii?Q?FIs85Ul4wX8grzWYsWxTef8Q4xg1R1e/rA77gMpcROiHmIPmjMXmwEjlPlPH?=
 =?us-ascii?Q?S48Qi0mnX/+6o6qBnZSpp4sPI2EDE+2A6mYSMVo4j/Cyut74t9eWKyJuJIQw?=
 =?us-ascii?Q?byVwHRI+xEaVUEp19ZXhF6bnE3xi/InLtg24fodmotCIMYZH1uHNUzpLkFYd?=
 =?us-ascii?Q?ArYQ6eBiE3Uh4ipFSoTsMp3n9nHIgEFYObGKG06OeHPMgEQjoLdYwAEpW3ba?=
 =?us-ascii?Q?JBJTamTrlLwWtQVrcLh2GlSzE+gb9CS5eLKDlYnRnVQDW3n6y9N1Whlfqh11?=
 =?us-ascii?Q?emJyC3oFUOYK4k53tSYpWd2JSvBzh8Ttu1ZIo/wXuz8ab7Q9jKgpyK5e8igG?=
 =?us-ascii?Q?JssNBf2M/qQB7K7uN02SPPYyYEBmslGJ7KzS7SZ8hVlKpe7QExlRDGA6zjTM?=
 =?us-ascii?Q?+1E0hrABsMiINMsyh9oPbJ6Fgz9dWFNiomp0z8ZNiczC+VRaroHFKjtomZ8b?=
 =?us-ascii?Q?Y7FiRlVqRuIddTYuyLSsUVIuBOP2JQNpBNXcMiP3DVSUi1JRYk7FKAK3xTQT?=
 =?us-ascii?Q?p+F6GfZaZQad+xXeivDGYH7muauMwHpUJbwvLQqr8R4giilyfHVTUr+C1Lo3?=
 =?us-ascii?Q?pKCiY5p78CZG2G6ZlyC/PFjyw8DKOT6SXMG1rPLgVOrwJgqmJ4tPIZ+o3SEW?=
 =?us-ascii?Q?QbXRwUM1tMycrbOqOq7zJTyYi77aVhHQKKclBfSOFPZQZm/iXkecQJl5WExa?=
 =?us-ascii?Q?rKKxFxRP5CqPYXeiEx0tW2dYZtPTYEI3EEDGqAh4mEkUwzFyJ7iflV4xwF3t?=
 =?us-ascii?Q?99QBfJnLyGzdn+pADTROLqjwbWC5sQ14M5XscbQORGBKwhArshSV/f769EDL?=
 =?us-ascii?Q?80837BOlNciVE3qHqFPz9RDlan557+cDlKFo/KHH/KpaY3fDeXROo9NytGeP?=
 =?us-ascii?Q?BZ7l9Pih9VlH08k3J/6OgvH38eaZjwATMJTMwfn5b1NZS3VfxN0MLZox1Ssa?=
 =?us-ascii?Q?zNYlC84mFQMPbvbIVMOb8nYbxJ3nT4+/iQ8wtiEcAaRylomQAsApaCLZ460G?=
 =?us-ascii?Q?YHCBvorUaeAqoPwfWbpDHYdY7mJDqF2YFTGllKTF3+APOLIn90gJVUhwTvgX?=
 =?us-ascii?Q?PruTupvja1fht6BmiwEG0TtmoWPYm/4g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(32650700017)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 20:53:04.8724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de944d5-0333-49b5-dd15-08dc97b44ec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232

From: Ashish Kalra <ashish.kalra@amd.com>

lookup_address_in_pgd_attr() at pte level it is simply returning
pte_offset_kernel() and there does not seem to be a check for
returning NULL if pte_none().

Fix lookup_address_in_pgd_attr() to add check for pte_none()
after pte_offset_kernel() and return NULL if it is true.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/mm/pat/set_memory.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 443a97e515c0..be8b5bf3bc3f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -672,6 +672,7 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
+	pte_t *pte;
 
 	*level = PG_LEVEL_256T;
 	*nx = false;
@@ -717,7 +718,11 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 	*nx |= pmd_flags(*pmd) & _PAGE_NX;
 	*rw &= pmd_flags(*pmd) & _PAGE_RW;
 
-	return pte_offset_kernel(pmd, address);
+	pte = pte_offset_kernel(pmd, address);
+	if (pte_none(*pte))
+		return NULL;
+
+	return pte;
 }
 
 /*
-- 
2.34.1


