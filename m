Return-Path: <linux-kernel+bounces-327246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719A9772D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDD9283AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7097E1BFE12;
	Thu, 12 Sep 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cfW79OGY"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022137.outbound.protection.outlook.com [40.93.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F418BB86
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173710; cv=fail; b=WCY7ObbeyHrp974D4Xl4xy/pPZu1lO5zouvlX2kk+4fNxKzlRowiE6kz6qKmQkXzdAx2gJxyFF51ByJfgyU/jdq9W50EgOIyVVPGhSJykMwm3dr4fRefiy256suLOLG04LE7/sjJo/af893BDGMHFWcOBg1+/qVRYLh7/iqiQ+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173710; c=relaxed/simple;
	bh=sXmrIwUQD9Js2i+7NszY6AFuVUelhKRjCp0v4ciyNTw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uVEH+qPqCNJ+oIPq5RbIE3pETJjXXNjVe7kZtVNuWHJWlf+AlbWKoA8vagjjtcQHTRA/zTADFQdjZWsYvUBrH+T8vU4nPSp+gLXJ5+z+ggoRuUdHAeHLZOWrBkhUdDyjOAe66UEIwPjww1VKu0G/iUlGc+jGn2REeNHilkxAH14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cfW79OGY; arc=fail smtp.client-ip=40.93.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzcCqdibmi8LYSlZkl+vh0SUUs2OX5ifwqwjQU7oyK2xp8F3ZeQxtiGsHcwUhnW5fR34IIRdryjKq7a8ik47XiLy4R/wZoauFZvjJNqnBO9722ZQJ4e3z/LiTLuuxloR+Tr6n8GMnRZi7QAUTjAnwmP9cziF6PBagYmiqv84rjpORuAxrp8yU+ZBdTil/WzcyiUrdwWii2Y+quhQdxqpd1CeUDqArwv4yBboM4r4wqMlS4clsWRqvZI6RGKn8+auMGriq+MJ6xHknxrz9KbRXYV0Yr88XQzE7EmPB1hDurPxOLz5qeypbywrTju5hXWpdz/sabhjcvV9sumMcxRs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dneYPSdL4kP0HiWqY714LZp4M6R402gIr+ydgNGo/0M=;
 b=XMHZZzO6O7EMRSOag014IM0n28x/aGKgN22C/zt0sbv62uruPzpDJI5rzb2sUJNp8DPBMtNmYnx2dqhCIYv1LNrfXfTbgOjT7Y035h+wJeTGGcyTGjjYk1CXStAW6623/b+VGeu7UQXMLqZwthHr1HuMGj/Y0LXrmQxdn2PqDhi1GsFtlGDLwOa+uyww8eF2foxb9OZ9auE4FPSd2oSXUxHK7V2vhOoJoQt4cDKNumNfOUTjiDwhJXO9eGw1bIpAK9g/QpxKeUo1wkU93cNWwmOWzGPZA/7Xhl8wZ4YPuHEygM2N7/xu8/11vXt0XAyP0f88xvyjqPfc5kKD/c2Wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dneYPSdL4kP0HiWqY714LZp4M6R402gIr+ydgNGo/0M=;
 b=cfW79OGYY233FMjHXgOMtyX1UT3DXDGKMxZje3yv+rR9mxAAYKDP0X6zQJDlVv/e6YtOJoU3+rYLiuDitWHjv+S3eGXXd/uYmEk1fMU2VnIF/4iDy/cqtcxZ6evCrdLPCS6LWa+YGJAGhM5uin/ahO76kX4PLQxz8RSwPQprSO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA6PR01MB8853.prod.exchangelabs.com (2603:10b6:806:42b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Thu, 12 Sep 2024 20:41:44 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 20:41:43 +0000
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
Subject: [v4 PATCH 1/2] hugetlb: arm64: add mte support
Date: Thu, 12 Sep 2024 13:41:28 -0700
Message-ID: <20240912204129.1432995-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:610:77::6) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA6PR01MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c337b75-4246-40a3-3a4d-08dcd36b4fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXL+TTWj9HLgPYvdU1Gb5aqBWBcpcd54h2UiAUjrpydi61JjFvGSiND9PqCc?=
 =?us-ascii?Q?aZl2HWQdLlUwZYXTEpyTVMzcgA1W0Wkym0ZIbQQ+WyqUb1WtHmRxvLxJZVEO?=
 =?us-ascii?Q?zduhbapc+Zquv9jtUayrlzt1nSTgdSBAQMjGadyNaI4/xUQdQvvmHDkcpjRq?=
 =?us-ascii?Q?s+CrZwMoQuqIHtPnRMui7e4UiNyV780ajlgOOliDGmUIjnK6YajNO5MNMqLu?=
 =?us-ascii?Q?+Dhr1o2htzCyiEh45ln8qz9QJb8vAvlD/dNkliuttSSpBgN5bZqyvAoCkdDw?=
 =?us-ascii?Q?8NxpKiOn2KCtyaOsD1gdP0NNkWPoEtd3Sz17TKZK2IcI4n6PqJkn+sPKLw95?=
 =?us-ascii?Q?sAJiIzqrYW+TAXxXn56R9BPGrJT6eAdyd8cTUzczeK+Ee3V4JMtZY10ma9F6?=
 =?us-ascii?Q?+ZhjanmzQc6eB31zRh2KgWNQVFPi4Qj4q0D7zSUY61BsCT3Uy4yTYTOBLZGj?=
 =?us-ascii?Q?hkCfe7STMrXYeokAjLbUr7SbMYC1FEe8aWi4XSLJMymabD6SP8Zj4AQvPNxx?=
 =?us-ascii?Q?g54k6qwatBawUwEx1xU7Uh5YZyiE87PmGFngjalchfaH2vyBQ3RiEtJRfzp9?=
 =?us-ascii?Q?svaB/+L84rjgeBN82ZNntVuomnPMAOtCgjUsp+YN6NiOYQdXQNQNol64uCVM?=
 =?us-ascii?Q?agI8VcjroJVIAfDmjOR+nSWjhHGoG0WHt0BREjYHCt4nPSM47SMvjVvAuGEE?=
 =?us-ascii?Q?dLKwggNObySs5YDZPddfsmiTnY9yaRdVddXbpGWJSSBFuQNRtlW6Hd3h1pVB?=
 =?us-ascii?Q?DiWur3qKYOyzocQGi3NhkO2Do1bAPVMP0+9fufrSUKQ5q0EetJvcLzlGJyQl?=
 =?us-ascii?Q?FMm5kHOSqTL3zEHBTvJrKUfGoFwOooI7qN+gr2EkNjH2TlChLJ6F7T/9PbBT?=
 =?us-ascii?Q?VAIihE20S27X2jU5P5RIVwvBAGuM7qNjv7A8IWzJ2X8J3tV4jCYzCgn3y4XT?=
 =?us-ascii?Q?7r7I9L9T+Ylg5KiOkAmcTxnRqcSPHGIMLgvxfNfzi/uP//3ak5LsfxSSMhQz?=
 =?us-ascii?Q?JxB4S0mrX4KfhG6YWr/cjQtetqSpBYvxSqknW4lGt92EVevYU+kBiuYlchFy?=
 =?us-ascii?Q?IgtmmbB6wIZrcxiRuJqNQ4nPJ+lXDJQOy470UxaDfWiru720s5nuVNwc9l8b?=
 =?us-ascii?Q?9IfK6PgQjD/iSxzsNkUPr/8bF2TMNfk/sAanHNV4O23Vl2IMKgA409s/j2Hd?=
 =?us-ascii?Q?iIzcIaepRHj0f9NR9X0l68GheWuYeyibcBOpLAr1bWn1ZxvQYZQ4JuN7hZ8L?=
 =?us-ascii?Q?SrJzxGbQcg6bOZZM/BpOZFXeRy6hvEsW317hxl96KRVJs+onaBU872rsSPI/?=
 =?us-ascii?Q?PjX1x8F1t/zyVIvai2TyYj1EjL4wA+CI6fdgfNPKccUPj5SX1mB7W6ph9rAk?=
 =?us-ascii?Q?zLvQ8bdQAsRF36kpV5KDrMp/lFVt4xNFr6tF9jIeIhn1Ihd9HA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MsJh0X7LBq2XvWASUtLVAvhDpkuue/+K843P4fW6NxINRzm8JJu1eQJoLBxU?=
 =?us-ascii?Q?+co0hGxQSzrxqEd7jiSjqhHUrDFaVmKcMNG4JoayHK3GdNnNhT6xdLk0MN9z?=
 =?us-ascii?Q?3ddgHPfoTXfiZRsQoQTGlGecGU57yNbg6HBVwSbWcR6OOa8sz0F0TeEGaPX9?=
 =?us-ascii?Q?Lt2Qtyd4eyjtqkTsNwXuqTMwNPaxXqF3Gj7ahtGXg3Mlvty1QxQd7Nan+6JC?=
 =?us-ascii?Q?ug+wKSbbdFGRC3XgCy1xmQ7FF5jvJcBKYkYZgW90cIpEaHNik9Xabr8ofD9D?=
 =?us-ascii?Q?dsCRGUXyx620Sju/uhz7YXIOTGiR5Y84GNRBm3yByzP0Qsaq2YA9oF/nsZJj?=
 =?us-ascii?Q?xS/MDS+aK9ICegTopWUaXbMBdyqvoJ2QkB+Voh0xtqgkPTZ2a3BPucL1vcsg?=
 =?us-ascii?Q?LW3PBnZmnRfLKoFItdTLOYJAwZtJKo7HmpR6jaAUoknIWnCL4c/442SDPsHg?=
 =?us-ascii?Q?Gw7Su9Txv9aE/vMy0NE+xnK1L+DjZjuvk3bHGrzvyC7kG9IgEt1sFsqmNjcO?=
 =?us-ascii?Q?s/6s8plpbvUqpuUFo8YNHIJsKbB6Glo/Rgi3GKaycUNMWQFYNGkSULi0LcnL?=
 =?us-ascii?Q?DmLIvDIvD7gAN0hKoygbNdNVPfvzPOG1TD8k4wEC9EZXGlG/8vqDwjkld+AY?=
 =?us-ascii?Q?0+XK+V6zV/ONFz4ZEzW4DZuizCVlgukTYv7W7ovq1DrDmrV78chyK5TvfqOd?=
 =?us-ascii?Q?4KZXQ1fL3BEHdI/6Yb3XIdugYpYhBMvtGhNjtfqf/a0IbnLNprQHsyU81Un7?=
 =?us-ascii?Q?mD9V0Hf+gvBOBtH3pXxydpt/UY8EjeYXMvPvudtbv2OoP4WGnGMrX/+ZGLag?=
 =?us-ascii?Q?RFnrMBf93VKr78p0WocYgsWmXFo/JTQ3xtkfu67W0xvMFUHwx41E7HwuSrfo?=
 =?us-ascii?Q?z8K4zW6ilXMwYmwzvGEj9skcZ7uoHDILl1cq0izrW0CzqSvoLzBs9IrI/gSD?=
 =?us-ascii?Q?TgfYC+RPPUIZrvpjHuIExuYiWVI9q3MkDjFlZupY73CCv4V04GRGVb6C9cMu?=
 =?us-ascii?Q?W/HnUIPpfTnDOsmZRuv2d4qYWYeJBHlARqJ9dEgtbT4IxnlCpUVNcKsUIxrC?=
 =?us-ascii?Q?RpWgXo85ELw+CRu1/VJY4Agh76TUqel+tkmclQkScGDyl0DpSYtPaUjoU1VG?=
 =?us-ascii?Q?iWkqFYrNyUnfqadfsLWsJB/pQS4RBeQ9v/NpYGofCcjh5wbyceOQvW7LvqSc?=
 =?us-ascii?Q?yptOdxJvwLmVcvZwg2ypxs5+LhneIEhmpR4q/k63g07d4xiwupG8vwDeCnKW?=
 =?us-ascii?Q?946aOcRMTUsg5a012+lPfYhiYg2We9MRXJI7QtszpbkMEojZlQJyiFhO1Wci?=
 =?us-ascii?Q?IoLWPKNIit0Dd4PBvSMXubDfDlIjf8QdfdV9PBnoxfbifht/iAZmshszERxM?=
 =?us-ascii?Q?lAFRSXkc9pi8jSYBubv9AsOVgUEwkG8g/9LeZvIu0wiJPG7KRDiJ7UtrLAhG?=
 =?us-ascii?Q?kIbzKW2YlaCbgvZLp3peXot+Hzz/e0pahiTRn4aEuziM7Rp0T0KSGO4TF5Ad?=
 =?us-ascii?Q?S3fxdcOk42Ww0esI25f3+QM3KWQoQNSrcAJgp4dtx7SUKUBflEizf1KQPlM6?=
 =?us-ascii?Q?HpOLE8qhEnCMYXHFa7SOo4FhtqGMFuyPFxZyWmE8BTo58gTnjkfeLgkaqaYm?=
 =?us-ascii?Q?tqkP1hJiFJQ6zzklrAZKm14=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c337b75-4246-40a3-3a4d-08dcd36b4fd9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 20:41:43.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dB2o83Fvu/IuIliSNzuAU9cN2vfepPRtSi6lcqN2/vP2vNKJVCDXT6PcrGwngwAxDubXO2BziIR3O/Q0YyOgPyzl2hnUqY8+gYWYdAMatYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8853

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
 arch/arm64/mm/copypage.c         | 34 +++++++++++++---
 fs/hugetlbfs/inode.c             |  2 +-
 9 files changed, 162 insertions(+), 12 deletions(-)

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
index 0f84518632b4..af8b92840d54 100644
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
+static inline bool try_folio_hugetlb_mte_tagging(struct folio *folio)
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
+static inline bool try_folio_hugetlb_mte_tagging(struct folio *folio)
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
index 6174671be7c1..4337acc63d2f 100644
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
+		if (try_folio_hugetlb_mte_tagging(folio)) {
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
index 11098eb7eb44..d7e161ca67e6 100644
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
+				try_folio_hugetlb_mte_tagging(folio);
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
index a509b63bd4dd..8eeb4f6969de 100644
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
+		if (try_folio_hugetlb_mte_tagging(folio)) {
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
index a7bb20055ce0..c8687ccc2633 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -18,17 +18,41 @@ void copy_highpage(struct page *to, struct page *from)
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
-		/* It's a new page, shouldn't have been tagged yet */
-		WARN_ON_ONCE(!try_page_mte_tagging(to));
-		mte_copy_page_tags(kto, kfrom);
-		set_page_mte_tagged(to);
+	if (system_supports_mte()) {
+		if (folio_test_hugetlb(src) &&
+		    folio_test_hugetlb_mte_tagged(src)) {
+			if (!try_folio_hugetlb_mte_tagging(dst))
+				return;
+
+			/*
+			 * Populate tags for all subpages.
+			 *
+			 * Don't assume the first page is head page since
+			 * huge page copy may start from any subpage.
+			 */
+			nr_pages = folio_nr_pages(src);
+			for (i = 0; i < nr_pages; i++) {
+				kfrom = page_address(folio_page(src, i));
+				kto = page_address(folio_page(dst, i));
+				mte_copy_page_tags(kto, kfrom);
+			}
+			folio_set_hugetlb_mte_tagged(dst);
+		} else if (page_mte_tagged(from)) {
+			/* It's a new page, shouldn't have been tagged yet */
+			WARN_ON_ONCE(!try_page_mte_tagging(to));
+
+			mte_copy_page_tags(kto, kfrom);
+			set_page_mte_tagged(to);
+		}
 	}
 }
 EXPORT_SYMBOL(copy_highpage);
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


