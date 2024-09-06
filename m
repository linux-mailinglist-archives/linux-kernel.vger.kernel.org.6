Return-Path: <linux-kernel+bounces-319299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642EB96FA41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534A6B22BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6C1D67BD;
	Fri,  6 Sep 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u6nxFC/0"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022077.outbound.protection.outlook.com [40.93.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA643AB3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645612; cv=fail; b=kjNcZatz9BZYx5hLSRzL29urvL5FpZkrfOWz/JKwNscELz8/Vqyjfp0c8dBNR4zanj9RegO+S5x5mh9PWVoXy1kT3hWn97FQ3jKwBzox7qvAHJ5rkcYkWVt1qWakRG6cc6TgPHlvSwFIKxK1R433cKpnLVvpjgmISnSt3XN3cf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645612; c=relaxed/simple;
	bh=fvPLxr7NtWq+48adF0+rNKcdY6V/z8vpn4vGWgzmxCg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NtHD1LlFRb//54iXBAnRyisecBvGgMnyZQ1c04+VMrRpPlRcjhtWrvYhlRhaQQzJFPP/3W9WB4O5/iSydOlluAF+I9L7QDkUFihvYTg+4Jj66g96hxjQvbjIRecinN/AodtvHM8HTPAI/fAhWEsQ3gG2f+LVSKVq3L8O0PHlUs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u6nxFC/0; arc=fail smtp.client-ip=40.93.195.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+YKa7u1GzjmNM2703Ob7xNtHm6XOroRTtAxzrT6d7W3Jf0GwGPi9LMyXJ9eZs+R6iKUElw2YZ81zkvaKwyQOXnxAp7SDgsgfuPkc4ZCuYWFa5soQ2BGFtbO51jNlRMma7GsPuy8Yr87u7pkLEs0aFESqQWohx2EcMtfrJGIjT1KN4laIAk3trmRrI4eGYgq+edioZMa5t5FKv2Fa6Ajnn9RcCUliPuksDsLZg7+iB/HW1dJ4dkemnVy3A/ap6TCne6qspNMBQkk4vcL29ZbTPZY7Fffg6lKYn872jNIOBn+hJmenvLfaqK8U3mcvL2wTMxEIaqE85vgo6ZGsRS11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hfMzbTuMCk2BcCguQ6lifNwEvSxz/uuz5HbU3VKr5A=;
 b=ubx1hkyrXzW9MzvfEaQlqSncZpcjedR2tKTekupEOBbgOHBAhkom/AbDPLOzKjARtg3i5KmXdA+949f4evo+F7GcvreCTlfkac4le6PIue4qm3Wbbv3NgBRjVUYjCpG3/RjYCAQOEAW3WKT8oJbeUpXnKGoS+F8C+hx+DnwDt7UAVEuKYbZNlk1eJoHKnPDToMPWdZ7sM5ICseXcTwrq1egS0kHIAZpW1WkjufTSvlr4Da2s8u5SRdt43lNgSkzTlK7lT0njyPQjdhvCgeQphBRLDfd1fqkRRkzXYkfXgHZOSk76If6DyZIiA8QueRVZukOYfUKuOZctIptqpzgktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hfMzbTuMCk2BcCguQ6lifNwEvSxz/uuz5HbU3VKr5A=;
 b=u6nxFC/0w4hZNOXtqkiBlNSdG+pM5Zx0Gi9gFWaacIM6pU3s323kcOamow7Z2bvDkfmRFChbVV5sOmymTxwg1ZE/S7B/5ZmasEAWN9rb15wOm97k/T3D78DEfMSUCtMIFO4vqORQVX/keq2qjH/q/Qr9Pm07zz+qFYuog25xTAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6561.prod.exchangelabs.com (2603:10b6:a03:362::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 18:00:04 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 18:00:03 +0000
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
Subject: [v3 PATCH 1/2] hugetlb: arm64: add mte support
Date: Fri,  6 Sep 2024 10:59:44 -0700
Message-ID: <20240906175945.3636193-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:610:e5::6) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 444664e6-a4ed-42f5-dbed-08dcce9dbbd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cl9uEdUoNIElHfS93p2NNRcWaq6AbWgLtFtu623Ph7/Fu97nT5dYEIPdCiDy?=
 =?us-ascii?Q?5rfCqz5Nupq0yYlPePOH/hololzzGFD+gm1piqF14CNfAQ5NEyQzRlfw0bVR?=
 =?us-ascii?Q?cLGQtWrNX+xxkKfAqJ0lWJA709Rb4Ai1EXIquuXtlMAU+aquXiZBW93Yur6m?=
 =?us-ascii?Q?NsfKtogjM/M7HLF2U1XegMjwzEPoeyD4QOmxhdr9GPaP9lyRI+CO8v3cCzrJ?=
 =?us-ascii?Q?odzhgm4EUtD1UHB1BkgWj8iRHK50mLMwU1EMREIr/lnmuvZoeTR/Oz7F1O+F?=
 =?us-ascii?Q?IbhzOkIZ28utwonz/dzHpU0xuYsedAX/qCTcQ1t8HZCG6WOENBQJxAyUy/TP?=
 =?us-ascii?Q?Q6zUNX7MU7UMFUE9Tax7H9HmPBHRIhsZlQbSqM8//10QQVButJwEOS/e96D0?=
 =?us-ascii?Q?Ygknao3jNTqg8vL1eCkknJmFeJMRiEzeVhovXyzJUTYXZ982d/+lbVhTYL57?=
 =?us-ascii?Q?TtkF8ipjTIv7urt2YDPhqxlBhvbFoxLzgIq/nW+ogEwRIF2YWkpyliDtUSrr?=
 =?us-ascii?Q?WrhJCoiJbEhyFimxLEZTNgT6ewkDoE0TsuhMPgS4g/sP1ddHqtna6XNrsQX1?=
 =?us-ascii?Q?RGnGqyI2Db0zmO+6JyYgYSiWHMSmhd1fqmrTJaL3BvCJ6hU0RKlYOiNi7Cey?=
 =?us-ascii?Q?Lac/jvB348d65ib/YEXmNKtI8aktb2h38lWBHAkqtZBFZkJOB405WneEUC1D?=
 =?us-ascii?Q?T+JLcMtZl+M6uYLWH5P68ykPPufa/5+1qPXMYo2A6tJQEf9nTeSMxSsyl0qE?=
 =?us-ascii?Q?mDCHxKrg6zg1biypuAOcylFFjUpqLYOOIlGQlzQ5lpJkM8qUXuaHbkNOzWOu?=
 =?us-ascii?Q?21fa60obJph0Drkv36RUG0Z1rM7F6zPuAdQndXNHLZH+oW0ZuJDAhlc03az1?=
 =?us-ascii?Q?33Rjm8sFst2efzHf30bp+b8LlT9kbDC4YgORBDOjmWs2iRYRvQq6hOg/sh+x?=
 =?us-ascii?Q?Qy0fSIZ1T5uzmY8Relvrr5lCTnH7jy2wAPEmWAweTfq4AgXs2wJy0Tr+8+h5?=
 =?us-ascii?Q?IbYaN18AZPwDCC8sUcqUl9/mZj05jqO5i3lwu67+Bcf21+4YvShXcaJKw8jc?=
 =?us-ascii?Q?1xTfH/bnwqzCGZDQNn2phccKSuzorYHmHF+ECGfuJHjT8jSMX9w+lO+AS77C?=
 =?us-ascii?Q?50OKQirWUFmlMWEiBeW39R+JuzP0BEUSAM2jsin3LrJ9UtlZzsPuhNESm6v1?=
 =?us-ascii?Q?JpjAwc5OfbHZpTQIKIuEZ4ZkuzFe7Eg4VWiocbMtcKlGNXqwMnyyXII3bB0s?=
 =?us-ascii?Q?zE6t88XvZc5CF9xXLQTSuM9GYRlXDxfPYCI78ZKVchgPA3W+Hat+vLG6MnxA?=
 =?us-ascii?Q?sWrUZOT0g45gOdQ7jVkWgjyZAjswTsKvz9QR8+lkRP1Hki7zF6M554SCb4gL?=
 =?us-ascii?Q?ML8OiwYsVFSPItdMOeAcFDqlXDixB++wPtqmBCaLZLGCEm1i2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J6glGUrqq82Qzk60n5X30RfMGWihMaWfwTcHfaNUeJuc3ua/Qs2IiKFQztG9?=
 =?us-ascii?Q?Z76eGGXSIuUPL3b0hjDuaL3DHBF3h+U1WVzTzPcs+ZxpG6uM+eilmFsbN5R1?=
 =?us-ascii?Q?gHqjqoOizpHIu9v0k7RpceElReWjjWpdfM5Y0DYIGZJdSacfG/HoRDy/0Hxd?=
 =?us-ascii?Q?6tG1I3vIFDf46nm9DMiDggmm48bisBpbek+b+QedwB2xJSK3XWCoJZ6q66OB?=
 =?us-ascii?Q?YiDQYxcjpQYgTjAjKDd7O3JZH5G1un05oJNVVl7PXJw0c1dPbqnJa5ctvYgk?=
 =?us-ascii?Q?j9WEn39UTmyMXnCBFBAiXkECHps49CwJD0r5gaoLnFvuvfnOcX/hfj+sIykp?=
 =?us-ascii?Q?g3Ryu6jF+3Jkfrw/f65uAnCCAjFzVxKyFkYtKseHkmOuHK4C+jIbE9rd0KOa?=
 =?us-ascii?Q?tUb6DOHhkk2NITGKnFJCXYvLT3uJLBASAgARlOWMBrtQi2+9LhEIevSyk9UH?=
 =?us-ascii?Q?+T4deUxtlf4y8ihRSLkNENiZs4Z0j1oq0Yz2M/sLoRw0/sSN2/6tOxlv8vi9?=
 =?us-ascii?Q?34Vk4wHmrkc2sJVwksDlowkOXlCN57Z1kF1qMaS1dLptN6lcW6S/eLjDr02u?=
 =?us-ascii?Q?1LwtZdrxrOseb5lfBsngo/8rNVN/ZE8Qa837kpH2tBkI2XtmnPLCdEr+erVI?=
 =?us-ascii?Q?X5ERLmPPWcTg59cWTXpxwsjJhjiGJA0P5Ef8ne31+1GZ+9q+UJLeP2LkmYfP?=
 =?us-ascii?Q?xRblN5Nt5CO9ObfezYrX7TmzNM3ii3LuEOIRQsJSJkluvrTfiX5znRuLrghS?=
 =?us-ascii?Q?WlXo4XGwtKZL4C7sBAPKQOihuTbNakuWFfrvc5njx00ukH57VI6eI33LMei8?=
 =?us-ascii?Q?cXZSz2UOlWQEIG4iVc945ERoO8X7uOw/0hBZFUk/aCQe/F2f23mjT9751koF?=
 =?us-ascii?Q?JsGB5fIsBc1F1B9bvDOmKe0IHyIilPy2xW/WD474/JaQh4RopU1LeO3bwgSb?=
 =?us-ascii?Q?l+21YNVKJCgAYhPEBDHtfYo4V235jNcf+pHvmhDjsnSDqW69aYc107hh6/qp?=
 =?us-ascii?Q?e57Zdoh4vw8N8fQHP0NQeF3hRf0HH7fS8cGqY9Yk8f6jcyUa1GPIWpE/Om2j?=
 =?us-ascii?Q?VDQyAsF/YxBUZvCAFwGYajoj247IIxKz1d1OZHa8pGvyec4DUY1jYJH6Yxzc?=
 =?us-ascii?Q?jV0rSTySS5wygjDZZCdGAo4qMZ+MR340dFF/+f6Ebe0hrBO6gaVHgX3RHo7G?=
 =?us-ascii?Q?EUFI9JQz3+XiBcvDCVln/TQ1fctQ1Hb7D5DWhR7LXktX061zm0Y8f06HTtLo?=
 =?us-ascii?Q?dBSwdbmF9IIbBBdElkXPhJBUGx7+iClkxPIKVzvpaTB71eyyS4aaTEoANKcN?=
 =?us-ascii?Q?McyN4IpujxUwYKY4Z78oethcmintWxRNkEJ7FEX4yzh/8A7uHU++k3FpxNUN?=
 =?us-ascii?Q?ysnQfUQtVuPUInH9nM3PmpLtbhBc6NjS5va1XrJ+idp+mpCx7wS0XAUEM1Ml?=
 =?us-ascii?Q?4CEVd082TYuoq5xqu0mV1Bui/+as0LkMsxFvKbzgLHebHKEWUU6jAIBqlNbO?=
 =?us-ascii?Q?QpocbwRkR4hnfh3NSzo/AVUDCG4jg2LNxkVYjimJLhh7VaKCV7jc87z641ld?=
 =?us-ascii?Q?Br6MnZf3aL11h3FeqzPnkN0kVVqIKyxvazdqQ7HYtzjNhBKLIdCDOwfX3yMh?=
 =?us-ascii?Q?Y+frD+noFUszxYwGqrCd0I0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444664e6-a4ed-42f5-dbed-08dcce9dbbd3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:00:03.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxUzZnjsb1T08PUhBRNIY4mwWohY9ygtlpmUI5CeOtNRKw/A+gYiWMRXgQIY3Dq+MhTchae+2+SwYSx93yBFZeOaGaATBzRJSAF6pizlRik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6561

Enable MTE support for hugetlb.

The MTE page flags will be set on the folio only.  When copying
hugetlb folio (for example, CoW), the tags for all subpages will be copied
when copying the first subpage.

When freeing hugetlb folio, the MTE flags will be cleared.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/hugetlb.h | 15 ++++++-
 arch/arm64/include/asm/mman.h    |  3 +-
 arch/arm64/include/asm/mte.h     | 67 ++++++++++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c    |  7 ++++
 arch/arm64/kernel/mte.c          | 25 +++++++++++-
 arch/arm64/kvm/guest.c           | 16 ++++++--
 arch/arm64/kvm/mmu.c             | 11 ++++++
 arch/arm64/mm/copypage.c         | 33 +++++++++++++---
 fs/hugetlbfs/inode.c             |  2 +-
 9 files changed, 166 insertions(+), 13 deletions(-)

v3: * Fixed the build error when !CONFIG_ARM64_MTE.
    * Incorporated the comment from David to have hugetlb folio
      specific APIs for manipulating the page flags.
    * Don't assume the first page is the head page since huge page copy
      can start from any subpage.
v2: * Reimplemented the patch to fix the comments from Catalin.
    * Added test cases (patch #2) per Catalin.

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 293f880865e8..06f621c5cece 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -11,6 +11,7 @@
 #define __ASM_HUGETLB_H
 
 #include <asm/cacheflush.h>
+#include <asm/mte.h>
 #include <asm/page.h>
 
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
@@ -18,9 +19,21 @@
 extern bool arch_hugetlb_migration_supported(struct hstate *h);
 #endif
 
+#ifdef CONFIG_ARM64_MTE
+#define CLEAR_FLAGS (BIT(PG_dcache_clean) | BIT(PG_mte_tagged) | \
+		     BIT(PG_mte_lock))
+#else
+#define CLEAR_FLAGS BIT(PG_dcache_clean)
+#endif
+
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
-	clear_bit(PG_dcache_clean, &folio->flags);
+	if (!system_supports_mte()) {
+		clear_bit(PG_dcache_clean, &folio->flags);
+		return;
+	}
+
+	folio->flags &= ~CLEAR_FLAGS;
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
index 0f84518632b4..cec9fb6fec3b 100644
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
+static inline void set_folio_hugetlb_mte_tagged(struct folio *folio)
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
+static inline bool folio_hugetlb_mte_tagged(struct folio *folio)
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
+static inline void set_folio_hugetlb_mte_tagged(struct folio *folio)
+{
+}
+
+static inline bool folio_hugetlb_mte_tagged(struct folio *folio)
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
index 02870beb271e..ebf81fffa79d 100644
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
+			    !folio_hugetlb_mte_tagged(folio))
+				continue;
+
 			if (!page_mte_tagged(page))
 				continue;
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 6174671be7c1..c8b13bf36fc6 100644
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
+		if (try_folio_hugetlb_mte_tagging(folio)) {
+			for (i = 0; i < nr; i++, page++)
+				mte_clear_page_tags(page_address(page));
+			set_folio_hugetlb_mte_tagged(folio);
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
+			WARN_ON_ONCE(!folio_hugetlb_mte_tagged(folio));
+		else
+			WARN_ON_ONCE(!page_mte_tagged(page));
 
 		/* limit access to the end of the page */
 		offset = offset_in_page(addr);
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 11098eb7eb44..c0f4c2acc503 100644
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
+			     folio_hugetlb_mte_tagged(folio)) ||
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
+				set_folio_hugetlb_mte_tagged(folio);
+			else
+				set_page_mte_tagged(page);
 
 			kvm_release_pfn_dirty(pfn);
 		}
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a509b63bd4dd..fc96becdc395 100644
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
+			set_folio_hugetlb_mte_tagged(folio);
+		}
+		return;
+	}
+
 	for (i = 0; i < nr_pages; i++, page++) {
 		if (try_page_mte_tagging(page)) {
 			mte_clear_page_tags(page_address(page));
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce0..5c8ef1a4a772 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -18,17 +18,40 @@ void copy_highpage(struct page *to, struct page *from)
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
+		if (folio_test_hugetlb(src) && folio_hugetlb_mte_tagged(src)) {
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
+			set_folio_hugetlb_mte_tagged(dst);
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


