Return-Path: <linux-kernel+bounces-328731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE19787F8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BC61C249B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030B13774B;
	Fri, 13 Sep 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QNSN83Fn"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020122.outbound.protection.outlook.com [52.101.193.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F784DE4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252467; cv=fail; b=DVvvd6QKGN9fPeah5ARer0yF1kw3QpOJh+PZbtIhbjZGiqzQoCoqC6GR1KKgu9+8GYxCAnMjFh5nT6pkaNzpoc1w8utSLtFqs6MjbssPPjbxS7c55oZtyOnspp6QqKodiiK3ntcAfVEiUSwvcBpVWVHS9nyneaU/zaRoUjmq2ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252467; c=relaxed/simple;
	bh=msyGU8hXLchj71KrjUNp5tM5EZlMMDQIq+YKqr4TsxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ur0X65NG1F5wn2iAx1lMgHss7E3wx8XAD07RAMdM7I+/AjiNnkOpFbqNztMcNCUL8PeQg8jG9xMYG/byL4k+T9EWt83kdqm8vWEtcKFkA8q5OxffRXozAoel9mN2sn+uxTYw9vEShhl45yTIF8eDRMJZPDyRb4Jfp/OuNJT/EpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QNSN83Fn; arc=fail smtp.client-ip=52.101.193.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLV7980ltA1o8LMbF0gMA60LKOowSOhL9FTOVRMkNdLL472wHYPtYX3FvQE8pmJXY3FwgYZsqD8ukoFYo/k/RzgFxnLji6uzhXrJErDiah658iTk8wAbXYdG/Y9eswzIuc2Fqn6S8Oxt9dhC46xEdXi+6h4nGOsGHriw/QrELQB5DlAYh24/Ahx8CAM9AAdovmDG7SR1htL1CWNt1W0lLjxt2WrHlEjWhMmXkBYn8imML7/U8TpHbw3Di7kqBgYGy+lupic3Cu6NG+Q3fGCh9jpj454Q0bWNtB4gCJXJv61JKuSf3PLUR9oeYY0HBlI4dViFmaUDoFRI9VnU2fyrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SooXbUCPnTkC08Zv/X8+JmCRDZ6femqvNucmjqXycx0=;
 b=P2guJPhm1+zFhSz6uLs7bfCT/X+tlSgOO1VGHaYJLCP6AyD9iaHDMjvUA4EPPM3jvBqY5rxLEz7U/IyjXYd96qpAlwJog7bX19tjUk4EPlYhrYeYzQeIP5wha3AAI3DLbImyK1U2wwg2Q2iRwhB951a/KJy8fEN7mnbcC9gnCkLSj/OkFzwMKFd1DUpwoVwrxmd9Sw3e3g8YtMwChrx8TeS8P07qKE3jb4TgQtKs9oWomgLc0V4ap3/clB3LZYZPcZloG8AdqVjHzwH9z5baRn0m8sA8xgBPBwXil9YtN96sPVGJSdZcBycOFFCHD7sMCd2JZkaEWNwz8JIqzk2fkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SooXbUCPnTkC08Zv/X8+JmCRDZ6femqvNucmjqXycx0=;
 b=QNSN83FnHlaKcm5M3H2gulrJOPSpylA9qPRakAwce63uwvtKZsrNskr0UMHu/ErNCTi0GF2CbHpydpm5zM/OhRwsMSH66cmPEG7fbdt9cE0q0KsiSaUSarae61UUjx0SFKqdv9vwP+Ij4glmcPa6bRnzyiIfQnDkwkYS5v1EnVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6114.prod.exchangelabs.com (2603:10b6:303:79::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.18; Fri, 13 Sep 2024 18:34:19 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 18:34:19 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	muchun.song@linux.dev,
	david@redhat.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [v5 PATCH 1/2] hugetlb: arm64: add mte support
Date: Fri, 13 Sep 2024 11:34:03 -0700
Message-ID: <20240913183404.3517556-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:610:11a::7) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dfbfe4-04d4-483d-4126-08dcd422adf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lY+R9VRNbTO0H8imWR8HYSRCLLZgXgFmWOIefTuPPikgcCIITN1DG2eVXfIX?=
 =?us-ascii?Q?n4Csbv8YVOQPnsrlCwnDCMtkIIWNeS+pXmkdBhuMjg9WDmjnljPpBseCcfeK?=
 =?us-ascii?Q?uo9F1EFQh9OaHGKEL4CTb/lHVwhaNflovrzDnSLOoRhgrUARyhmyrvS1efJc?=
 =?us-ascii?Q?1nPjP6XQJUqp55R7id3yUbJKuI8NFWMjwOCL1PcLh832XLwL3Whbow28tQ1Y?=
 =?us-ascii?Q?7mLy4NS01HpaNSAsF/cqDcWafumRHmLSFr/tus2QRvGVGyWAtRG7W+YbPyZq?=
 =?us-ascii?Q?Wuhhse9cdOE+bU6shuL00UFmpi1mn+WxAkUXudFLlRVdCJjeujVY6sOMq0jF?=
 =?us-ascii?Q?o8iy9hf0d6JQSrL38di8yaVN5+tLjhwyQ9ZM139+zZSTkHYZCJXeYkN6JckH?=
 =?us-ascii?Q?SP2zTDwJM22A9d7jTmuEsCRygyWrznUlf/t8zl1AiVjLMZf8lF5bub9gctiG?=
 =?us-ascii?Q?9NZ4ZjU+3DigZme78+zO1U5bMpu/FtxFGHKYzgJVWIdUH5b83gDlMd4X5lmm?=
 =?us-ascii?Q?iJo314IQk8oDMHyI4dotrLIod0nNzWnJVIu5DGV6h1fmwDkXAvhgZ02baX2d?=
 =?us-ascii?Q?lqU/j64EvLjM5WX+tHwk4XTR4CDin4z0+2ti1ojRRn2q9Lel9KPQT7evCQix?=
 =?us-ascii?Q?vCopZQ+lel/D/NsXDNNfvjIcZED093MB7dtloek6z8vhVMRJ3Bjc5P/xVdS0?=
 =?us-ascii?Q?b7pPFbM1ecD7CuK2pn1o468gIEgYBAm3z/hGDhmSn2WKoAgVBkcL081sUcer?=
 =?us-ascii?Q?/3cVEsYZnp14crxQslvnMWMQQ4Sd/HGwBG6CLEjyFWCb1U1qRXrnsy1RaHLl?=
 =?us-ascii?Q?uu3gMror/nUrMamyN0rdZnIK4icUaU3XMB2CJuDr1D6abUvcK39r2pfUNawC?=
 =?us-ascii?Q?ENzeYIxu1Hf8pLOV7DpkvUc+TKB2CqV83P0ZDQHHPaJVMN0cSlaFw6YbdHcm?=
 =?us-ascii?Q?AvHlDTHxpRFoCH8GjySw+fs+s5jEjzznUa6td0g0bH16dPVDOBCWrc5QHRlz?=
 =?us-ascii?Q?3RErCdWGUfIvppYAEDS3rVYt3a/BihqlReNf/JJdkJvBgHSQMg9o8VzzF9hY?=
 =?us-ascii?Q?J3lt2TbkqlQES/TQJroir1Aop0pDuKa6Q5qKXyrv5k1EaZVoWptC77WECt+k?=
 =?us-ascii?Q?27Wux9ZKO3Cerhpkzp+6bfvkXyMLnKQUiYBnWckEf5RyM0Pks4IjTbukx97A?=
 =?us-ascii?Q?1WtVA3XNfsiFGfiun7q2JPKZtkYFPA1xCtu3a9k/8LmsNdx7EE/EViyRGbXm?=
 =?us-ascii?Q?q/Uu0mADxImKP3wOe7HOpk318/ljxWrVUs2cbuJdK3srIEsZ5s1OMFjIIRLo?=
 =?us-ascii?Q?UNJvlpsydCtLcfsEsao6IVoNezE2m7sfg8JzlBAuC7zVX4L2gDwh8G1Herh6?=
 =?us-ascii?Q?7q58SWUwrhNX5V8vg+8AghSxEgp3GEkRmDRADvGDGbm3tGOuwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQVaaa/agv/PHNCmOGwVa61TKkuywM9LJH+2XTrs7QepWFc/joenzk5e+mrG?=
 =?us-ascii?Q?OC7iH97Pq+JZmTXpSuDxgQ98s/rTqogjEfEMURpj9IAhE0yaEtsJMuaKOnni?=
 =?us-ascii?Q?zpuTP0r8HV05TEGDfVMpX8wPkSuP0FW2Gb5/IkpOGwWwuRZTnjA9FJR1z4Ug?=
 =?us-ascii?Q?D155yct601lXaYZOQEDjhtW3rpa/qVrsk0McxHz87QrfpNhu7kLknjPB7l0P?=
 =?us-ascii?Q?rGbLGKHEEhGxxAcCLZXBvdRPWFjy7LGAfXn90N9qPY+PECpWbxPnC2tdYpbY?=
 =?us-ascii?Q?vY+0Rx+mn0cgwnze/oxw7NIdnnsrqBqLZWLfJwM6rs7+0Zb98ZrxZOVm17R6?=
 =?us-ascii?Q?GJCLcB382XPMGOl7LXk8UY47QEzWRtJaQVEOBN1GNLu4cNKnKx0hBxKTn+xY?=
 =?us-ascii?Q?zzT9DquUdJT4LY+eBJM3HINXH3N0zQtLcQLp1q8bw4giiZepXR4EqWcn6NpU?=
 =?us-ascii?Q?fQekp+g9eqd2+bC02eJlUi867mjZxRbDNNEU78vzXaefbh0KhdIK3HYyfS2H?=
 =?us-ascii?Q?Fz2Iwc8wsW2PA8RNppH6dPQawUQIFlKksquIo5X2hGT1jAVuU0mbXyF1akyA?=
 =?us-ascii?Q?RCZTPvHnz2T2w8xmUAjBPGieCmaAcpC0V9I7MjSZHi5lWA6Zi0w6AYS0yGBo?=
 =?us-ascii?Q?tmTBQ7Al37pJ22S8ptRRzwj5/w92L0HixqIvKU2wDMvP57VW9oPcd2yWfVaW?=
 =?us-ascii?Q?sGQ7l3ExIZsZWXfZPdDlxdHd4tIHwshrt/FoxvfOy0BRc05CXVXX7tmhgHXr?=
 =?us-ascii?Q?wGI0sQdsHYg/KGoh5PtPaI2s1QpcR0TzJPVuN0+h2L92aM4Yv7y+jq+tiD12?=
 =?us-ascii?Q?aWwZgUf5uyWrYY1NRbI65hJk/QmIu037hFCvnmZKKt/mzH8hmMgWCMKFMwQg?=
 =?us-ascii?Q?vN72JuKBX9Qk8DpV8zlX0bdfQvkekUb6U3dvE71E1QpEDOf3ZohphH7CaPcu?=
 =?us-ascii?Q?g2ljdgI/uUtDjIQFcIWJw90Yr0Wuxu+MvUt+M0T9wkQNIsCRD5sI2RFRvzhT?=
 =?us-ascii?Q?Mx05VsG3bS7Plh5isA6dEp8SFG9PX4rI0i593ssfMbsUPkXwtmiiIviDAbfl?=
 =?us-ascii?Q?g94c5FDlSpmtzgiWjxErk345NoObjAMrNtuFPqJW2kS3JcbBEJ1WHfPlWD2S?=
 =?us-ascii?Q?nKgTm0F1Svfp6Y2mYo0kpqp4wsuSC/DHc1BORIGpsbon3hNSNwqDzTfovzTd?=
 =?us-ascii?Q?Fh8h7yTFzI7HUy47+/+FPwA64244UqI3oFgHtUqOH6t1sQNzpAeuyAH6iTpj?=
 =?us-ascii?Q?vuzlW9QGXLVTNsqPfRpOA9uRdRvu1uaQX9iGwHqqR6KbtCPlV7kc/pi2L8qS?=
 =?us-ascii?Q?LtgNBPchwRGo7mncu5ZA+2yg9OxBoYiMOZlXmWKhAMdOG6p1TDH5EpoRQD3Y?=
 =?us-ascii?Q?26dzO6kawzIveKQloTINJWQIggBcyrSLyF6TBOY3F+wjcG+HsssYkziSU+Sz?=
 =?us-ascii?Q?RBNphn54Ho/y42tYGfRrl1IszN03/WEOQek2ny1AvoTSvZ3WkQ+Xi3qgpb+9?=
 =?us-ascii?Q?gtPJDvy1w2BhmIwZ1fPIM4Pt8W0zk/VCfzriQnrjX4/pRvnZf+uXRdC2AsMO?=
 =?us-ascii?Q?U4kJ2hhz/04cY97rF6bBN+8fps2A6EobotGz2QxzyS33jblGYNEH563hsiKs?=
 =?us-ascii?Q?9YbiNq0RopM6E+Xcgxg0NVc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dfbfe4-04d4-483d-4126-08dcd422adf6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 18:34:19.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urS81oeCZzi0z2xX8aasiFHupMDH6cwJMLhsEZkXuPXiNO/ud2ZvN6aUGJS37itqm09wvk8d5hXEfObEHF4tQIioYe6k+E/E/ZR08aEDtLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6114

Enable MTE support for hugetlb.

The MTE page flags will be set on the folio only.  When copying
hugetlb folio (for example, CoW), the tags for all subpages will be copied
when copying the first subpage.

When freeing hugetlb folio, the MTE flags will be cleared.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/hugetlb.h |  8 ++++
 arch/arm64/include/asm/mman.h    |  3 +-
 arch/arm64/include/asm/mte.h     | 67 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c    |  6 +++
 arch/arm64/kernel/mte.c          | 27 ++++++++++++-
 arch/arm64/kvm/guest.c           | 16 ++++++--
 arch/arm64/kvm/mmu.c             | 11 ++++++
 arch/arm64/mm/copypage.c         | 27 ++++++++++++-
 fs/hugetlbfs/inode.c             |  2 +-
 9 files changed, 159 insertions(+), 8 deletions(-)

v5: * Indentation fix and renaming per Catalin.
v4: * Fixed the comment from David.
v3: * Fixed the build error when !CONFIG_ARM64_MTE.
    * Incorporated the comment from David to have hugetlb folio
      specific APIs for manipulating the page flags.
    * Don't assume the first page is the head page since huge page copy
      can start from any subpage.
v2: * Reimplemented the patch to fix the comments from Catalin.
    * Added test cases (patch #2) per Catalin.

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 293f880865e8..c6dff3e69539 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -11,6 +11,7 @@
 #define __ASM_HUGETLB_H
 
 #include <asm/cacheflush.h>
+#include <asm/mte.h>
 #include <asm/page.h>
 
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
@@ -21,6 +22,13 @@ extern bool arch_hugetlb_migration_supported(struct hstate *h);
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
 	clear_bit(PG_dcache_clean, &folio->flags);
+
+#ifdef CONFIG_ARM64_MTE
+	if (system_supports_mte()) {
+		clear_bit(PG_mte_tagged, &folio->flags);
+		clear_bit(PG_mte_lock, &folio->flags);
+	}
+#endif
 }
 #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
 
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..304dfc499e68 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -28,7 +28,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 	 * backed by tags-capable memory. The vm_flags may be overridden by a
 	 * filesystem supporting MTE (RAM-based).
 	 */
-	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
+	if (system_supports_mte() &&
+	    (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
 		return VM_MTE_ALLOWED;
 
 	return 0;
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 0f84518632b4..03dc43636aba 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -41,6 +41,8 @@ void mte_free_tag_storage(char *storage);
 
 static inline void set_page_mte_tagged(struct page *page)
 {
+	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
+
 	/*
 	 * Ensure that the tags written prior to this function are visible
 	 * before the page flags update.
@@ -51,6 +53,8 @@ static inline void set_page_mte_tagged(struct page *page)
 
 static inline bool page_mte_tagged(struct page *page)
 {
+	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
+
 	bool ret = test_bit(PG_mte_tagged, &page->flags);
 
 	/*
@@ -76,6 +80,8 @@ static inline bool page_mte_tagged(struct page *page)
  */
 static inline bool try_page_mte_tagging(struct page *page)
 {
+	VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
+
 	if (!test_and_set_bit(PG_mte_lock, &page->flags))
 		return true;
 
@@ -157,6 +163,67 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
 
 #endif /* CONFIG_ARM64_MTE */
 
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_ARM64_MTE)
+static inline void folio_set_hugetlb_mte_tagged(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
+
+	/*
+	 * Ensure that the tags written prior to this function are visible
+	 * before the folio flags update.
+	 */
+	smp_wmb();
+	set_bit(PG_mte_tagged, &folio->flags);
+
+}
+
+static inline bool folio_test_hugetlb_mte_tagged(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
+
+	bool ret = test_bit(PG_mte_tagged, &folio->flags);
+
+	/*
+	 * If the folio is tagged, ensure ordering with a likely subsequent
+	 * read of the tags.
+	 */
+	if (ret)
+		smp_rmb();
+	return ret;
+}
+
+static inline bool folio_try_hugetlb_mte_tagging(struct folio *folio)
+{
+	VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
+
+	if (!test_and_set_bit(PG_mte_lock, &folio->flags))
+		return true;
+
+	/*
+	 * The tags are either being initialised or may have been initialised
+	 * already. Check if the PG_mte_tagged flag has been set or wait
+	 * otherwise.
+	 */
+	smp_cond_load_acquire(&folio->flags, VAL & (1UL << PG_mte_tagged));
+
+	return false;
+}
+#else
+static inline void folio_set_hugetlb_mte_tagged(struct folio *folio)
+{
+}
+
+static inline bool folio_test_hugetlb_mte_tagged(struct folio *folio)
+{
+	return false;
+}
+
+static inline bool folio_try_hugetlb_mte_tagging(struct folio *folio)
+{
+	return false;
+}
+#endif
+
 static inline void mte_disable_tco_entry(struct task_struct *task)
 {
 	if (!system_supports_mte())
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 02870beb271e..74626d5cdf1d 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -266,9 +266,15 @@ static int swsusp_mte_save_tags(void)
 		max_zone_pfn = zone_end_pfn(zone);
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
 			struct page *page = pfn_to_online_page(pfn);
+			struct folio *folio;
 
 			if (!page)
 				continue;
+			folio = page_folio(page);
+
+			if (folio_test_hugetlb(folio) &&
+			    !folio_test_hugetlb_mte_tagged(folio))
+				continue;
 
 			if (!page_mte_tagged(page))
 				continue;
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 6174671be7c1..2fbfd27ff5f2 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -38,7 +38,24 @@ EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 void mte_sync_tags(pte_t pte, unsigned int nr_pages)
 {
 	struct page *page = pte_page(pte);
-	unsigned int i;
+	struct folio *folio = page_folio(page);
+	unsigned long i;
+
+	if (folio_test_hugetlb(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+
+		/* Hugetlb MTE flags are set for head page only */
+		if (folio_try_hugetlb_mte_tagging(folio)) {
+			for (i = 0; i < nr; i++, page++)
+				mte_clear_page_tags(page_address(page));
+			folio_set_hugetlb_mte_tagged(folio);
+		}
+
+		/* ensure the tags are visible before the PTE is set */
+		smp_wmb();
+
+		return;
+	}
 
 	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
@@ -410,6 +427,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		void *maddr;
 		struct page *page = get_user_page_vma_remote(mm, addr,
 							     gup_flags, &vma);
+		struct folio *folio;
 
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
@@ -428,7 +446,12 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
-		WARN_ON_ONCE(!page_mte_tagged(page));
+
+		folio = page_folio(page);
+		if (folio_test_hugetlb(folio))
+			WARN_ON_ONCE(!folio_test_hugetlb_mte_tagged(folio));
+		else
+			WARN_ON_ONCE(!page_mte_tagged(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 11098eb7eb44..ed9b3f31f3ab 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1050,6 +1050,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 		void *maddr;
 		unsigned long num_tags;
 		struct page *page;
+		struct folio *folio;
 
 		if (is_error_noslot_pfn(pfn)) {
 			ret = -EFAULT;
@@ -1062,10 +1063,13 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			ret = -EFAULT;
 			goto out;
 		}
+		folio = page_folio(page);
 		maddr = page_address(page);
 
 		if (!write) {
-			if (page_mte_tagged(page))
+			if ((folio_test_hugetlb(folio) &&
+			     folio_test_hugetlb_mte_tagged(folio)) ||
+			     page_mte_tagged(page))
 				num_tags = mte_copy_tags_to_user(tags, maddr,
 							MTE_GRANULES_PER_PAGE);
 			else
@@ -1079,14 +1083,20 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			 * __set_ptes() in the VMM but still overriding the
 			 * tags, hence ignoring the return value.
 			 */
-			try_page_mte_tagging(page);
+			if (folio_test_hugetlb(folio))
+				folio_try_hugetlb_mte_tagging(folio);
+			else
+				try_page_mte_tagging(page);
 			num_tags = mte_copy_tags_from_user(maddr, tags,
 							MTE_GRANULES_PER_PAGE);
 
 			/* uaccess failed, don't leave stale tags */
 			if (num_tags != MTE_GRANULES_PER_PAGE)
 				mte_clear_page_tags(maddr);
-			set_page_mte_tagged(page);
+			if (folio_test_hugetlb(folio))
+				folio_set_hugetlb_mte_tagged(folio);
+			else
+				set_page_mte_tagged(page);
 
 			kvm_release_pfn_dirty(pfn);
 		}
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a509b63bd4dd..962449f9ac2f 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1401,10 +1401,21 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 {
 	unsigned long i, nr_pages = size >> PAGE_SHIFT;
 	struct page *page = pfn_to_page(pfn);
+	struct folio *folio = page_folio(page);
 
 	if (!kvm_has_mte(kvm))
 		return;
 
+	if (folio_test_hugetlb(folio)) {
+		/* Hugetlb has MTE flags set on head page only */
+		if (folio_try_hugetlb_mte_tagging(folio)) {
+			for (i = 0; i < nr_pages; i++, page++)
+				mte_clear_page_tags(page_address(page));
+			folio_set_hugetlb_mte_tagged(folio);
+		}
+		return;
+	}
+
 	for (i = 0; i < nr_pages; i++, page++) {
 		if (try_page_mte_tagging(page)) {
 			mte_clear_page_tags(page_address(page));
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce0..87b3f1a25535 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -18,15 +18,40 @@ void copy_highpage(struct page *to, struct page *from)
 {
 	void *kto = page_address(to);
 	void *kfrom = page_address(from);
+	struct folio *src = page_folio(from);
+	struct folio *dst = page_folio(to);
+	unsigned int i, nr_pages;
 
 	copy_page(kto, kfrom);
 
 	if (kasan_hw_tags_enabled())
 		page_kasan_tag_reset(to);
 
-	if (system_supports_mte() && page_mte_tagged(from)) {
+	if (!system_supports_mte())
+		return;
+
+	if (folio_test_hugetlb(src) &&
+	    folio_test_hugetlb_mte_tagged(src)) {
+		if (!folio_try_hugetlb_mte_tagging(dst))
+			return;
+
+		/*
+		 * Populate tags for all subpages.
+		 *
+		 * Don't assume the first page is head page since
+		 * huge page copy may start from any subpage.
+		 */
+		nr_pages = folio_nr_pages(src);
+		for (i = 0; i < nr_pages; i++) {
+			kfrom = page_address(folio_page(src, i));
+			kto = page_address(folio_page(dst, i));
+			mte_copy_page_tags(kto, kfrom);
+		}
+		folio_set_hugetlb_mte_tagged(dst);
+	} else if (page_mte_tagged(from)) {
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
+
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);
 	}
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f6cff356796..f944e8e7126b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
+	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	ret = seal_check_write(info->seals, vma);
-- 
2.41.0


