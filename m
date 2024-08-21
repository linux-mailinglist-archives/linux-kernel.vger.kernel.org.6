Return-Path: <linux-kernel+bounces-296050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46A795A4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372921F23B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632F1B3B0E;
	Wed, 21 Aug 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="CUEdeyvw"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26311D131A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724266098; cv=fail; b=SE9ed+GOK/F/PFGUK40Dg3jgLBg7VBhOEOgNqqO3szk8nvIoYjElgQ5NdS4VhjIUeP1q2lw/B+3qQTeeMcy/Nlfz05hU3VgN5IMGd0+t1FoVyOwCTq1MsRl3rt9zHdJhEOHXZmy7cTngtfQIOcTgwHt1zq7Mq5pWB6gBA94KPTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724266098; c=relaxed/simple;
	bh=o1+GBk/fIo47O0qbuGUhYT5QV1Hph9O+K+WxVe5mw1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Phn+m+KPejutcBevZ9UvHLzDSf7TwM8zas8GBiMPKZqVcZfyhal2bsBzd/96VGDzRAwk6HT10+XTWre0RkSOpTv63I22VTrx9Ywi2sICrOnBwFWfU/aL4W39I4bnU25A743fHEwEOmxK6TFuIDARuCkPPlko9eauhTO5d0Ke81s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=CUEdeyvw; arc=fail smtp.client-ip=40.107.237.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/x1fQUQS1VXMj5pbKSFJlXeLmiVU8lfla20fI2PE6KaFc5H+yuHtJrU17mhH5E6nQCvsFEusPma5tQJuQI2rW+X6DpmIc0Cwlpds/DymrXY6b0yu3M1W/eIdh9EKvlOyMoR/ZYRMVcDomZawW3H792OOkICql2JjFMSklIKvVCeqPUQZ6++pDEynBcx/zwWJ0H8ZnxiWJ3YjhRJXk9a0xqRpNzbxTrjFhWu3m9DVYlIuklgST6BcRpHiLlAQsxGJO1Y7MdHdtAv9ZAInRLMah8AHwcKpwyRjM0TNGriEMA90lnWXjC1vFFcy5eBYLH2JyI36bdS/L3KiIAHiuNq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVvb6nZgquVREbBjdKN5R8e0jFSK4GKpisDwZuRPDiU=;
 b=shSbkq491/9LQrOgUKzYDFLlDfKEStVYPLmRlhyyTc7hwDfqaqEIdvOURnaHJFeW2ILO3ZVvyIK4iqlT8JPAAJF21xfP55itoFF/EtfpiYCtZ+M8GRL+053Y9Gx48SRJEaQuu5e4gybRrhFuwX/z6U43qHJvopqPS0F0u3/c69ouJ3DNkqGxEhcEVBg+RjctTmmMfWFUFEHEeUCf6nne1OfZp+mCPnYr2bnPoDAes9j9kyEVOe1BxW1iDJ7UaYu3QmIYrtFnbJn/zYIwbsinIuzVqgn0kt49ILj3xwhEPVHRjaRpEcB7YYRzDIg0OpSz2Sfhad2LgjMIEw9DxNAtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVvb6nZgquVREbBjdKN5R8e0jFSK4GKpisDwZuRPDiU=;
 b=CUEdeyvwnGRP85LrpsS1uwUJb27V6aWhqb9MAErg4sWmAho1UjUBB2j0S7rgmLtvz8l7ylukmc9/tOBH1SVnaWjQmL+qaJ8z6qfAWo9FlxVqLE+nYMi/v9JVxzgyo1khDCUGPPpX6ApBDeH7v9APCbfACQ85dcZFOsBAZwkvLe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6146.prod.exchangelabs.com (2603:10b6:303:7c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.16; Wed, 21 Aug 2024 18:48:09 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 18:48:09 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/2] hugetlb: arm64: add mte support
Date: Wed, 21 Aug 2024 11:47:51 -0700
Message-ID: <20240821184752.3535276-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 773244a4-5578-4d65-1c84-08dcc211ccb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YPSuqrxLEi3PkwHJq9veBlSfDZL8e6dddlB/coiwlvP9KW5iJ20yHRp+HQ5I?=
 =?us-ascii?Q?+/BNtTbkk5pmSEdwO62udRYeqTp4Uz329gADmfh7U5l3IT+brcHNChEpyWlU?=
 =?us-ascii?Q?SbW66RRJESkZjKFz6AyaQG4EfbKqSTMQ4YGTEiiUCKilMgMuUhoNd3cIgHOW?=
 =?us-ascii?Q?9tfmRWH6otFGAAXyLwpyEN5EVjaReR5v+svV3IB3Umb89HYdeN8c+1iVDLze?=
 =?us-ascii?Q?99duP8KoGYO+LRbNtjWW9ddnk5R06MIa8q7OXw/N2V/TDkdp7EY3rC/4sovV?=
 =?us-ascii?Q?acKNI8hebE2cFxzE7ZEC8euu1fYruiN9bieo1uJ1Q6BPYSTh6t0NZqyDyb0N?=
 =?us-ascii?Q?3E5qhch3OwHBp5KK3iyFXqAUWzuUY7Ssp/XPflfzQ+/TO9PrITg2Ht5hO8XA?=
 =?us-ascii?Q?YX7SgXXp+0g4qBVTSESn/2MVkxgnBKE+o+Dg/QBrpHxCX5Gx/nHVU7lC8MTo?=
 =?us-ascii?Q?0uYrJyVCYS/bJosrfhSATOWryP3CpF98bXSwHM34wmw8Cn79OCP9mKDDQwwf?=
 =?us-ascii?Q?3JH9nQ4U4Dk4wYHjDpwCygqF6ToG3tUCacqUYx6EoKzHh5T8KRdDQ27ipj2h?=
 =?us-ascii?Q?mpnjBJZUy8JxlgsXrAlO2nu6jlKvdvarWGkAM1FwPN2EeLinvNEjT5z5/D3a?=
 =?us-ascii?Q?WL1oHQWEaSwdTC15cmXgJUhzPhSROFtQL2o85pZGvn8k0X+YK7Cj23SqS/9x?=
 =?us-ascii?Q?cKMpAlglj445EpmpNNYLjXFcL3TfkPjm4cWSHRNTn4yqGUY6iCS5S6JoiAld?=
 =?us-ascii?Q?gPS56gzwhcjNyaneFL/F2JT0OzLjihpjciJqPGIc6wmign/F5IWvgZhSOLt5?=
 =?us-ascii?Q?s30qTSF4A9Yd8O4G5E7Nr1OUl5NrUO/wGa7AtJvSUZfxC0DNmugI5R2xVlB8?=
 =?us-ascii?Q?W3LVbT85OLZQVGjNezVO+nvGLDg63WPBX+nL9S1I6aEop3GFJfMNkefOCMpH?=
 =?us-ascii?Q?4NUbdqqOid0WVMFVfLE92HI0YZJc9VDqOtbXDvfH2jT+Oej7mynx4sDXYSJA?=
 =?us-ascii?Q?gfwAf+/hoQH9E5Efi1jcJ9jR6jrYGX2dCfypylWGmrl/UAI8XB67uwbABtGu?=
 =?us-ascii?Q?lzF8eXjaR7hQtgu3KJjZiPxV9e6s/ErHUCMhFkUohH3ll5oZUMSGe806gff5?=
 =?us-ascii?Q?ErQoiYt0J9mAlJwMoNKjZlGCCwPQhdg5vA1yDH/x0CRA/UrL1zYTuUKEN9wh?=
 =?us-ascii?Q?RODTVGkmp3IevqS1UnSZsMGY6XMXvAxqPhimAlr3LqXR6diX3D/tzi1dh85P?=
 =?us-ascii?Q?vjRZso7ygU0HwB1BJuZGIcCbnNHtW6dbeKhi0X5JBMgPenjYtxtQb9j5Q534?=
 =?us-ascii?Q?07HjX//BsypkfBNxZhyahKvnXvRThmIguYyFjkQhbirj+HHyIweZ3nhEZck0?=
 =?us-ascii?Q?WGnESvTz7TygPMzKG7bV6S5gP0ib5t7+cYSz26ttCmODamslUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L1bn8roE01kBp7oT6n2k3He0ih/SM0/qNoJMwQdQRPn7MUw1jwuS39/6Dunw?=
 =?us-ascii?Q?sHUs+VF+H8g/6MFdfFeOMwTDh+SjAY/cI2WRoPmdG50pax8jMhu7Co0KDspd?=
 =?us-ascii?Q?Z0NNPvo+BEgoVXff1+Inf+3fpwKQpiswSkTZgTTc9ViSTKcCyRooxim6eIqW?=
 =?us-ascii?Q?j/QmHeEnO/83COPuVTHntlIL8bgPmteKld9B75Nx3imsypvRqVQpAyN1jtDz?=
 =?us-ascii?Q?a+0PYJJF5I42UN53t1UyRs4gjXQX5f6P5cvbU+No4AZ199ZiEopDIRdThVga?=
 =?us-ascii?Q?NJxu6AhBgM7NEdl7XoBgoG230qsdisATketwBJUOUbmVb7cc1SXec3USoncI?=
 =?us-ascii?Q?zAdAEV6LbKluOBv854zuieDWYX7Yo/yPiPmmogtWOVyZO5dyL2U6u/9sreAg?=
 =?us-ascii?Q?FpSMNWRl1H0QqTpy1FQLR93VgTOgDsKHtgCekabqzI+s0wRBS8XGyqDsiOB/?=
 =?us-ascii?Q?6R3RJBvmnTT/rtrs6Vc457yckl7zw5PVolXm4u/DzEUjqRrFCHJlAypCRkUy?=
 =?us-ascii?Q?k8PlUG0PLuWpL9h0cgvSYF3dQP+kptWllksVwFKLwz9100Mt3/3hL/r2I2qR?=
 =?us-ascii?Q?0NRfeTyoUwJsWdHKJXcQh83DV8Efy9SDMovoGrs3aOwVxBBq/kFHmo0oJDJY?=
 =?us-ascii?Q?7ez0gyMuX3iJXFD0V6wn4mFdi0ANlD2HVbWHstzMlyoZEo6z6akO7Th7jr3b?=
 =?us-ascii?Q?/HhD8KRyNe4sXnM8FltRdzy7OgHllTTdiBUUB55nv/2oQQ9s3lqgeCsqUR0+?=
 =?us-ascii?Q?LM9bnuky223epkSb+sS1yiq4HoiWZTRwiXxGXCV457026YmK0vGTQZpBh5N4?=
 =?us-ascii?Q?cT3lQBYVwBirq4nRbUBttiIwRQ/9dAKPz/P0321dwxUtzH3tbnqgSQ84xc5E?=
 =?us-ascii?Q?/73mEAXr8p4MCg9KbB6v/CTWHJqx6bmi5MJqQIuofe5Ll1ymmHF+/MSp8x/T?=
 =?us-ascii?Q?QUT/UaUkx+iYCtOxDviCJPs3cdBcFPMR5WK0xaVVhRmI1uai84YFLEqAaHu6?=
 =?us-ascii?Q?YW3FShGa/lyyfGjTS80l/enVukX1i2WYkDJ0eM+TOZE9MLsZkRnNruStxH7S?=
 =?us-ascii?Q?RxtXt/WQbrhMANqBbyawYcA/RtKHBZg2U6Be1i0unaoJ9vPAtCKuBgnzweSg?=
 =?us-ascii?Q?Pzm/lHYJqV7ZUK8NjyVTEsNU2Rq6tvnlt053jNCqMfhIoeRAWRVYfeFyCoWc?=
 =?us-ascii?Q?H6JEFrwEpY+TwZGw5snmJrQ3YxwMtLPIbdJ9VKLYbT/CwcnT+Y37KP6JlLHg?=
 =?us-ascii?Q?7BNKeJ6Gx4j8mkxdxASiCnxT3SM5gY5FlSFYqyyJxN7ARTu802sdIMqu5sB0?=
 =?us-ascii?Q?fpPsun/sxnVrfUSeVKbCtEBtSS46cp95lDcJtqre/PY3oVb4sG98MVGr/GgG?=
 =?us-ascii?Q?4GgPNyxD+sBItxmNv6+05qZ9jLMorebcRXvCeain6DKpqgy8HUUCxGbgKQdy?=
 =?us-ascii?Q?nF3CtLczk1Fvqq/nyDjawGKs73DQ3nbkDS0AmliYAftF8FsZM5k8SZxCkun6?=
 =?us-ascii?Q?+ZuJ4uNQo7kl6pWKkEkCEffE8lBdB6XhOxztvwQf5E23IjPMs7H2kr03knRh?=
 =?us-ascii?Q?GnYsbr0whaqiPCfWeAV+zla2A5QLF+zYwdfJAyaQNC07TfEy4ysLSQ2HNUBD?=
 =?us-ascii?Q?0FGtxVWonjInF/RxVYs7Hbw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773244a4-5578-4d65-1c84-08dcc211ccb4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:48:09.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5OZcN1fljJz1h29MEZB8orP+mcUIJ9pO7Ex9gQVXpNN1dBnrN41iM7CZ4nYoG4aMrzbMCkdEwxiPTqp/yJjEklH+J7EUvqHGSDXYVFHdEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6146

Enable MTE support for hugetlb.

The MTE page flags will be set on the head page only.  When copying
hugetlb folio, the tags for all tail pages will be copied when copying
head page.

When freeing hugetlb folio, the MTE flags will be cleared.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/hugetlb.h | 11 ++++++++++-
 arch/arm64/include/asm/mman.h    |  3 ++-
 arch/arm64/kernel/hibernate.c    |  7 +++++++
 arch/arm64/kernel/mte.c          | 25 +++++++++++++++++++++++--
 arch/arm64/kvm/guest.c           | 16 +++++++++++++---
 arch/arm64/kvm/mmu.c             | 11 +++++++++++
 arch/arm64/mm/copypage.c         | 25 +++++++++++++++++++++++--
 fs/hugetlbfs/inode.c             |  2 +-
 8 files changed, 90 insertions(+), 10 deletions(-)

v2: * Reimplemented the patch to fix the comments from Catalin.
    * Added test cases (patch #2) per Catalin.

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 293f880865e8..00a1f75d40ee 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -11,6 +11,7 @@
 #define __ASM_HUGETLB_H
 
 #include <asm/cacheflush.h>
+#include <asm/mte.h>
 #include <asm/page.h>
 
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
@@ -20,7 +21,15 @@ extern bool arch_hugetlb_migration_supported(struct hstate *h);
 
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
-	clear_bit(PG_dcache_clean, &folio->flags);
+	const unsigned long clear_flags = BIT(PG_dcache_clean) |
+		BIT(PG_mte_tagged) | BIT(PG_mte_lock);
+
+	if (!system_supports_mte()) {
+		clear_bit(PG_dcache_clean, &folio->flags);
+		return;
+	}
+
+	folio->flags &= ~clear_flags;
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
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 02870beb271e..722e76f29141 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -266,10 +266,17 @@ static int swsusp_mte_save_tags(void)
 		max_zone_pfn = zone_end_pfn(zone);
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
 			struct page *page = pfn_to_online_page(pfn);
+			struct folio *folio;
 
 			if (!page)
 				continue;
 
+			folio = page_folio(page);
+
+			if (folio_test_hugetlb(folio) &&
+			    !page_mte_tagged(&folio->page))
+				continue;
+
 			if (!page_mte_tagged(page))
 				continue;
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 6174671be7c1..b21f706018f7 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -38,7 +38,22 @@ EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 void mte_sync_tags(pte_t pte, unsigned int nr_pages)
 {
 	struct page *page = pte_page(pte);
-	unsigned int i;
+	struct folio *folio = page_folio(page);
+	unsigned long i;
+
+	if (folio_test_hugetlb(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+		/* Hugetlb MTE flags are set for head page only */
+		if (try_page_mte_tagging(&folio->page)) {
+			for (i = 0; i < nr; i++, page++)
+				mte_clear_page_tags(page_address(page));
+			set_page_mte_tagged(&folio->page);
+		}
+
+		smp_wmb();
+
+		return;
+	}
 
 	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
@@ -410,6 +425,7 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 		void *maddr;
 		struct page *page = get_user_page_vma_remote(mm, addr,
 							     gup_flags, &vma);
+		struct folio *folio;
 
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
@@ -428,7 +444,12 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
 			put_page(page);
 			break;
 		}
-		WARN_ON_ONCE(!page_mte_tagged(page));
+
+		folio = page_folio(page);
+		if (folio_test_hugetlb(folio))
+			WARN_ON_ONCE(!page_mte_tagged(&folio->page));
+		else
+			WARN_ON_ONCE(!page_mte_tagged(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 11098eb7eb44..77e181d96e97 100644
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
+			if (page_mte_tagged(page) ||
+			    (folio_test_hugetlb(folio) &&
+			     page_mte_tagged(&folio->page)))
 				num_tags = mte_copy_tags_to_user(tags, maddr,
 							MTE_GRANULES_PER_PAGE);
 			else
@@ -1079,14 +1083,20 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 			 * __set_ptes() in the VMM but still overriding the
 			 * tags, hence ignoring the return value.
 			 */
-			try_page_mte_tagging(page);
+			if (folio_test_hugetlb(folio))
+				try_page_mte_tagging(&folio->page);
+			else
+				try_page_mte_tagging(page);
 			num_tags = mte_copy_tags_from_user(maddr, tags,
 							MTE_GRANULES_PER_PAGE);
 
 			/* uaccess failed, don't leave stale tags */
 			if (num_tags != MTE_GRANULES_PER_PAGE)
 				mte_clear_page_tags(maddr);
-			set_page_mte_tagged(page);
+			if (folio_test_hugetlb(folio))
+				set_page_mte_tagged(&folio->page);
+			else
+				set_page_mte_tagged(page);
 
 			kvm_release_pfn_dirty(pfn);
 		}
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 6981b1bc0946..1fa51ac4e3f4 100644
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
+		if (try_page_mte_tagging(&folio->page)) {
+			for (i = 0; i < nr_pages; i++, page++)
+				mte_clear_page_tags(page_address(page));
+			set_page_mte_tagged(&folio->page);
+		}
+		return;
+	}
+
 	for (i = 0; i < nr_pages; i++, page++) {
 		if (try_page_mte_tagging(page)) {
 			mte_clear_page_tags(page_address(page));
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce0..0f3b07d4a5cf 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -18,6 +18,9 @@ void copy_highpage(struct page *to, struct page *from)
 {
 	void *kto = page_address(to);
 	void *kfrom = page_address(from);
+	struct folio *src = page_folio(from);
+	struct folio *dst = page_folio(to);
+	unsigned int i, nr_pages;
 
 	copy_page(kto, kfrom);
 
@@ -27,8 +30,26 @@ void copy_highpage(struct page *to, struct page *from)
 	if (system_supports_mte() && page_mte_tagged(from)) {
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
-		mte_copy_page_tags(kto, kfrom);
-		set_page_mte_tagged(to);
+
+		/* Populate tags for all subpages if hugetlb */
+		if (folio_test_hugetlb(src)) {
+			/*
+			 * MTE page flag is just set on the head page of
+			 * hugetlb. If from has MTE flag set, it must be the
+			 * head page.
+			 */
+			VM_BUG_ON(!PageHead(from));
+			nr_pages = folio_nr_pages(src);
+			for (i = 0; i < nr_pages; i++, to++, from++) {
+				kto = page_address(to);
+				kfrom = page_address(from);
+				mte_copy_page_tags(kto, kfrom);
+			}
+			set_page_mte_tagged(&dst->page);
+		} else {
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


