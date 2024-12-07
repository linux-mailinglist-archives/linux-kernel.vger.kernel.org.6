Return-Path: <linux-kernel+bounces-436109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732729E8137
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB3D165967
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA91494DC;
	Sat,  7 Dec 2024 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OdEfi3rh"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5C17597
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591803; cv=fail; b=ZbeyzNbkQlm0zYi0lL8jQhfg0UpSpHFzJitmTOQVFfMy3k4dw5Bi6uDKyTEnKIkZWD+fKa0MZYPAwxlUczUmTAvDb3H/Kc7szrZOsCLv5TM9tdwht/9TZ8CA8XE0HQW7BO7UQAlxox4TBT4cXdD9UUmq15kDZcYbWiZDwws5bUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591803; c=relaxed/simple;
	bh=iGvYyDyZYk+CKcIeE63GCC+LgqZZNy7b7L9B8oZIWFI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NBketuaep4XkVn9ujwq++KKxeJ8CD40spadfkSEQL8b8dOX23GhMUbV+BODoMG5ORGSxzPZUIlo+FT5vAZKwBFX7Y4UO8m8O6J6g/ZvZ+7gXpNWWyIwqOXAMORngaXQsy49VRAllPwQ+6gQGqAbiVegF7p8mbeyRv3NdY6GA6+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OdEfi3rh; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNKRGA8XpcaoXgRWP6oHW4OqPpNHx3cmx/GOHcBz4zlz8xNwOuFbf5NSNEP3BcbEJ4RMalhb8CcxEL6f4oQbn6hcm3zeJwimEbsfnXrYpbFoWhPaTQ47KaXreoIrAWzCvblgJjLkAhp8OVxhXzv10J4yl4PZAroK2JykDOdI6grfvn1ix4AbFEIX3cR2uJEvJBTn6ryexHajoYLp7jHJn1JZ3Df4cjwSaJo1ZNWwHexvcVZn2Dj0L1TuQ2W2FYaRawAjVvEbFwDyn7txYznJlLlb/zECjlIQMnIJ6XRtG++B/MEmCHsXMEn9TLZzSKvnJP172q/imO901UJl8Jdh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrtZWxRzTQc7SESzKzF5aEtmFkHEZlyLbV8fyHJAHNY=;
 b=FIN1VuoxdYA6uGp/nOkIPk/oxNAWlOCuzneqgbvOY0RF/DIvAYsA/2C2Q49w6dxCf3MBIuXTi0RHMqGIU5suQ45D8OMUIuLjRBDaLMNSn8grjqkuMQLmq5N10HRtNngFwOSIU5zZdUKivJZq6uf3tj1dSGzsUZzOgTz10WJKwyJSD8fhr4hTi5Zj8E7TpFsr7jXsW2ZG5P4g18082Z2lNVyR+14bSIPSVtz8lWOGlyriK+BIB56z/O7Lo+g4ZjPtJkezkH0iHO+rV51i9V3n1rwVPjpR5shKpnFmlbAXnw00ekBHbdPsO0QgOwbo0vdOHljuw89SS42bbNh0TB1Sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrtZWxRzTQc7SESzKzF5aEtmFkHEZlyLbV8fyHJAHNY=;
 b=OdEfi3rhmtsEP08m+7Ns8je976oP6OctKdt9bhAxpGZDMBpInr1s4yDsu0RbGjsAPswNe+MET5RPfMAZW2Ig9vXqcFfNo/3WYpN923PQin5b02KoWZ8FEh4kQ9ags+jw1wdWV1mcQbSJJ0peN35duQA6I/N+23p030Jj/cgG0f6fKOCPAobtJcG4M00328v0O/sntHEFyhsiQgWHo/sK/SfCvNkT0C4NfYEUbuRUTDrh5Eg3QZHbCblUs8eOHwjtWaUdoGeSFdehStW+ltXiG3JYl7XfPmpY5XtT6UO2pdI7zVwpVGcz/lZQxt5Ql7QPpv6KbJSFZGlmxUyRXB5thA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Sat, 7 Dec 2024 17:16:36 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 17:16:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v4 1/2] Introduce cpu_icache_is_aliasing() across all architectures
Date: Sat,  7 Dec 2024 12:16:30 -0500
Message-ID: <20241207171631.2853336-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:408:e3::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: ce108cea-58a3-4d01-b940-08dd16e2e7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4BjkR/sC1yVHcitd95CYFvzqdhIUCPgUftjiyPKICTHalVrrSdl58OyHee5?=
 =?us-ascii?Q?j+9tuxJtEbz3GMXRYQPvDf2hovu3R7W8yEzV/oDietOp3iuVoViUY59QCf4D?=
 =?us-ascii?Q?hdZhlZZeYs0vHrHCPhQvTMHcH5MEPnFqzpaKGK7qWifmmwtuVDApsDsO1fOl?=
 =?us-ascii?Q?9QQxJbaOIFRNRWlTrHofpivJ5EaFt19KR0zySzfJ827GxmBsd6bffopLQVeG?=
 =?us-ascii?Q?PoY7kCDPRbCkgyCkziR6W6qeRKu8gOFUiNpWIvZcxybt60lGbc0MeaKDaQ9d?=
 =?us-ascii?Q?/IL7Kz2icVpHyFO474QFE8eUXTyPeL9aERIzibKVU1CDsRSmw72nLRmD2h+T?=
 =?us-ascii?Q?ZF47GkC4nCjESvUgSxlsG+El83qSAAFhpmtMKkZsqXVnY0UcQNuSnyPvunqS?=
 =?us-ascii?Q?x4o3e6vkNIyZ4oigaXYQURyahV/MsLfJRPgMAAUDq9tQVzgoO9fvEqmmc77z?=
 =?us-ascii?Q?N/8KfgwGiJvC31ab3zrZLx+wJ5yOIc6boXst4HYQfmNzDNDCCe/BZzw0pmH7?=
 =?us-ascii?Q?wFQ6Mn8fywnpDA4DjjHTVgVnyARANfIu2Qv3GUfg08CfAPUBqWbbr1Ou4ppd?=
 =?us-ascii?Q?n8y7IohzZArszZJXEXEoFZP6tClCe53d1oO3TBeVId8PkV/8/X84Ddj6ZdAJ?=
 =?us-ascii?Q?hf5D4N1ezD72eP9VN3X3ClZa9WZfUOx1lKZfwkeT2WkrklMRzqRT/ApyZ+FY?=
 =?us-ascii?Q?QEiE1DafeANZzlMcQFJEZMgFRn54ZCMY97WGuBq7n91eEaCURG9quwCTtTc2?=
 =?us-ascii?Q?JDXdU1ggjfUxijUx0k6ootkxIjoUkFnd3mIdsYtGCKM+NdtTf78cDf+r2bf2?=
 =?us-ascii?Q?0C6/zZqHdB6XDYJWlqe7LEShCrsNlfHX9qFoAQ+5AxtpO8cE8QfmhBYs69l9?=
 =?us-ascii?Q?H1lyFzwhVtbfkmN5AWsmIdjfJR0jX4QPm4q2466SMJQ8w22VnccxbMLy+koz?=
 =?us-ascii?Q?WxE1Ucmdy0vfz1boaUn783dZsNPhzHcI3EaXkbKCDDkK3uSseo7xBliCY7hm?=
 =?us-ascii?Q?xOj3SWeVcPt0303zvBnrAvrl98ZKi9PRpG3gyaIF/beI9WF9807+4fehQZdz?=
 =?us-ascii?Q?WscrmWiBLIm486SaJK+3qx8u1FQQkv/BQO4PI6780tIzaGXlgHdN2ucnDz64?=
 =?us-ascii?Q?9aiVC+u6TB3cQqmazbTlftwoFC+s1mbQGbprjGfiNQX8TLdcvRg9QTSoOPiM?=
 =?us-ascii?Q?266dzpS4ji9CPDlFcivWsMD+SsbXmxBqJaSygJd5xrHl8pohWzaEQDVLJUsb?=
 =?us-ascii?Q?42wOpyBnwLewvOSwHIKEN3GMlagRYEnuOBa1D1ermNIVoLw016Ia/Nvaz/gT?=
 =?us-ascii?Q?4jOOLD7clN6BYj7Jw1iZ0+8hwI8sXH11ucNE1S0PQDQopw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0o9me9pa9+3ZEPt6Z+aJfI/HmepJTephF3Opo0Ue1NW/WwqPx8qDH4WHlIV8?=
 =?us-ascii?Q?tFZ1FFCzJHpeCqJgYgRiZuw9Vm+ZxYX0h1dLnQ6FILRqNykKtPqOnepUMmEF?=
 =?us-ascii?Q?04QppS2gTzgNrd8eGud5SUWu0HLfOOCMimsdv2PKgnBIs32WJCEcqqcudOhj?=
 =?us-ascii?Q?Cuofx1WOWNkvqQo+5LjQrWIcassqY1CIP9WLq4meaVxx15FFOw4gtNuzR7iI?=
 =?us-ascii?Q?zoWHeif+JlrTa0Hu6ywJt4NV1T2eLUVewSwbT0OpE8xBVUoLV5ENVUGeKyTg?=
 =?us-ascii?Q?DXB+gLozPQbf3KBGAUZhRcISjRj50ztL6iuPvx6tBdsKNPn4ZlRF4NF1IHsK?=
 =?us-ascii?Q?lfkuOi4Qq3d/YZycpcC1n6zSjiAboSbZo6NS+fTXEmD7s2/ZtmX1jJiz/GYL?=
 =?us-ascii?Q?m8URPfbB7jVG9kaZSSt9kZiWv0+hhdP3za9V3MQe2SwRfEbfhRbEGcaWkcsO?=
 =?us-ascii?Q?aI8hgD5KuSb9iS6JDW/7AtQUCv/JxQQs4iSOzRAQaY8IhIsVMiAIhHvf2YD6?=
 =?us-ascii?Q?bURP6LQhmIjMC/ytamGOR9sUKlxBz3e4QR3frRg//MqxUMq/K9AfY+KEcj9F?=
 =?us-ascii?Q?C61UXdutZLwu+f4aLlZRLM0kihecIP+U4xLkdN4t72BPMZ2RaE93Zspms3cM?=
 =?us-ascii?Q?TtDe46VWtl6PmKFkXhN6g/yF6fJARqbZziwgb9TbjkMkumByhFOvwsC3erkN?=
 =?us-ascii?Q?eAgTP7YA0cu2zi0PV2jN7JYheMw1sdTGdtVOYfWtk42FbOiBkp4JjB4LuBHt?=
 =?us-ascii?Q?14IwzeZB05yjEoAMSplR1XLihfPeJGQN/yAdB74buZnyWcb7Pgxw3IZ/0/NK?=
 =?us-ascii?Q?gOWPMxD9P26BYBOrfhmJzwKlfjJWWhtnbgDCnUJCNSR+Otz4CT55bxBAK7Kn?=
 =?us-ascii?Q?l/Bqj8nzqy3H4/1uDho2FG31gNM2UhvMaT8W2Nx3tNkFf8U7YehtpLWLYXLD?=
 =?us-ascii?Q?EtxGHSLtKgUFxqG7rIwllC/p37iUps0XjfUCRID03lhsALBAqE7a6kb2ka9I?=
 =?us-ascii?Q?456aNO0lNOl+iEmHLC6BT+0ajAlUi5J1eSWcJKycRW83HqXM2+hWDi9h1JYE?=
 =?us-ascii?Q?Pdeynsx5sSWekkuN3wgh5QbQrM7STs38i3+Od0YeCrAfftYZlU5yZmMgleLq?=
 =?us-ascii?Q?ccEhco7/uiC14q4zVQlK4cr+zfprxMOSHCQNJJ+gPo05pZXHYziN8Bt3PeR6?=
 =?us-ascii?Q?4dW1M+lc+rlFAFEDjVKs7y49Wi17BZhe/krdJJzMGhwgsc6VbzYbUNq796h/?=
 =?us-ascii?Q?3Wzmwo5H1PQQAEgACUnPVnGhC8JA1eDHWtXivO7H1Lu9DVlxrqrk/do8Ovtd?=
 =?us-ascii?Q?9RX6xzQ39DnW3tnhQfO6+bv+ACmj8uTiYdZm78zKwzQPL5W7rv0mKIKXBQ8I?=
 =?us-ascii?Q?0ZC9eBT7TwBSnJJj0ZvGgsvuHSSdYUOSgHnG+uLzKcA99oRP8RM9lktHVu6l?=
 =?us-ascii?Q?gprBhz5PnPC00CVYaLo38qU+RlG5fMdf+ClDw5CUiFimDw9rdLy9H46dNdfM?=
 =?us-ascii?Q?s45ERKC4aa9tJQprNxdKKpMLLwKyhHE0F9ohBN4qqNf0R/COgqtEpr3xHcCS?=
 =?us-ascii?Q?AlS+QjHBk/yu55P68p0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce108cea-58a3-4d01-b940-08dd16e2e7dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:16:36.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQz3EqCFMlESmkdZIqHIbinp4PWkqyQQUZHb6LKP29wK7NgeGcecLEcxfVfU6cX5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449

In commit eacd0e950dc2 ("ARC: [mm] Lazy D-cache flush (non aliasing
VIPT)"), arc adds the need to flush dcache to make icache see the code
page change. This also requires special handling for
clear_user_(high)page(). Introduce cpu_icache_is_aliasing() to make
MM code query special clear_user_(high)page() easier. This will be used
by the following commit.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 arch/arc/Kconfig                 | 1 +
 arch/arc/include/asm/cachetype.h | 8 ++++++++
 include/linux/cacheinfo.h        | 6 ++++++
 3 files changed, 15 insertions(+)
 create mode 100644 arch/arc/include/asm/cachetype.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5b2488142041..e96935373796 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachetype.h
new file mode 100644
index 000000000000..acd3b6cb4bf5
--- /dev/null
+++ b/arch/arc/include/asm/cachetype.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ARC_CACHETYPE_H
+#define __ASM_ARC_CACHETYPE_H
+
+#define cpu_dcache_is_aliasing()	false
+#define cpu_icache_is_aliasing()	true
+
+#endif
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 108060612bb8..7ad736538649 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -155,8 +155,14 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 
 #ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
 #define cpu_dcache_is_aliasing()	false
+#define cpu_icache_is_aliasing()	cpu_dcache_is_aliasing()
 #else
 #include <asm/cachetype.h>
+
+#ifndef cpu_icache_is_aliasing
+#define cpu_icache_is_aliasing()	cpu_dcache_is_aliasing()
+#endif
+
 #endif
 
 #endif /* _LINUX_CACHEINFO_H */
-- 
2.45.2


