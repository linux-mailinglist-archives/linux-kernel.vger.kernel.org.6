Return-Path: <linux-kernel+bounces-529101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076FFA41FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C62189688B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3CB23373E;
	Mon, 24 Feb 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="bWV07lq5"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D01E487
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401680; cv=fail; b=CTtC39Ocyig2Q14KFYFG0KVRikZ9K5RVpkJjZ+rTBSo8XdAT6zbdrAa9EkCc6sMyX77ZVIhN/W3CefQ09Uvk85qC6L/Vif3GOxCnovakuEXUndfB7FxLqNZUDBMgMzzFvzeV4uY63y3HydXArGaZ0BevKuzkfR2TWUhKA/1r68I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401680; c=relaxed/simple;
	bh=A1B2hFxan6iGNOpUSkJh3OlBCiyowpHQFxufo57f51M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qFNchuULOpJ4HdFtmVOnY9NiiQovruZYZ+fmU1hnfKxeC7O1VRQpg4Uc+WBbw0wkjKOtId70PAeHcnkx18HCpED398DMJxfi9bziWT51HZtbEXaDkhUbzeChYmjuQsQ8vbSpfnLH1Ncfo9Rn7PTAoGof/K6JKC3kewxpyqJ2Z0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=bWV07lq5; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkJxROB/LP3UcB3hLPYC+PpsAlWmVTvKevj0RQbUW6pM4V4xI+GxDv4cS9YxAhaJkLtTYYpzlg+C8qYcAQeUSRJdYZ4qdCKXo2aTqSjgeJEssAytBzuMWhYdveqSoFiryPicPdi/jArb30/GyFym66K6hcf7hnB9J8s3zEj0Cr9cbsXyrfPPDSHKAlU9hUK5q1stMuOx8e8JVMJWiDdIQV6f1sAqilk8IFtQsao2QFnpI++LeHzVxUysPHHiiUPypUJ8bhgVeKx6ojNpb/+LfQfvzzRxt3adPKpy49koxFJ52QoIYeEfDgNn0B/aTH25XyWHzyXzFlSygHETYRPUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVEPURwwOBxGSqMPKvzIvTIQyl3gkckHrAFmeSkvpY0=;
 b=cyPYHDsVNh6TgbgRkxxXWwZyA24hbNp41U77YUDFqLaF76SQbsxGIycGZcwz2GGbz6H2h8v4gF6Jxy3CRqMORS77C4ddBYz4Szq6ZDLRrtuxf93CFfbaXFrGNHjKSU5lCCCjedmVoCpr5m5F9lb3qJIWl5k2KoF9TjT96Qzdlf2U68ZE+qcA8hKiwIx2VfJyIzLF54RlKfud6KuNB9wEnJsHVwKMDNr87uaTJyOshaAzVO0KTuokv8coYdfRtGExUFtgzg9U1ns+nP4JWHiGTDg6kWU2idsXLofvaYTBnVfvw4Uq71+kfkq6ZDwZ5dJ36Fcxg/A+7YTHtL4ePwd27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVEPURwwOBxGSqMPKvzIvTIQyl3gkckHrAFmeSkvpY0=;
 b=bWV07lq5dOnzItOK4LEUhk92n67AYmVgLcEP2pqKoF7dVSioERKT++8AEVDuVSBkMhTnSDfmr9ebG3J84TFlqv+mOcyFiiMSGiHBCDqJtmMMwAGW519YzZuJWtBxEDrx9iDdpOj+dDGC0o0y5LHs3bbN4Dl5ralIJa7X/t+q+Gw=
Received: from DU2PR04CA0196.eurprd04.prod.outlook.com (2603:10a6:10:28d::21)
 by VI1PR07MB10115.eurprd07.prod.outlook.com (2603:10a6:800:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 12:54:31 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::81) by DU2PR04CA0196.outlook.office365.com
 (2603:10a6:10:28d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 12:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 12:54:30 +0000
Received: from N9W6SW14.arri.de (10.30.5.17) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 24 Feb
 2025 13:54:30 +0100
From: Christian Eggers <ceggers@arri.de>
To: Russell King <linux@armlinux.org.uk>, Yuntao Liu <liuyuntao12@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Arnd Bergmann
	<arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Nathan Chancellor <nathan@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	"kernel test robot" <lkp@intel.com>
Subject: [PATCH v2 1/2] ARM: substitute OVERLAY description in linker script
Date: Mon, 24 Feb 2025 13:54:13 +0100
Message-ID: <20250224125414.2184-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8D:EE_|VI1PR07MB10115:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d52550-3d93-4ab9-5f0e-08dd54d2612c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ft8YrhvYj4C5/EQqAuCpbdiyUQxiQIQArQ6Ym31KAl458lX9YyB8LhIiNiCR?=
 =?us-ascii?Q?+rDac5zjPEw1SCBX/7HsKHCdKk2PUWW3Vyg0Hss+q84k6IXzx6OKKwgE3HQM?=
 =?us-ascii?Q?/8Izcky9HI9mntXg02gj+MbdK2YahqMFDHlc+c3Hx6pWCqgptbFxQ7kHCRVZ?=
 =?us-ascii?Q?clmUvT9+QyCMxltWRGdaiVcP7mlPgzlrJ2ksPjCKvSYRo+BWp/+2tnyHapmY?=
 =?us-ascii?Q?x+z08y/IWs743fcEh0U9WZH+slUbPDEf8WW/vRUnX52sWABIAXIIcZotM3Oa?=
 =?us-ascii?Q?gU1tj8oNnu9virslbLJNyyWpPr7dHWhlsP9ipaJXw8by7cRzwtRMrQC3Od48?=
 =?us-ascii?Q?wRTeYZpZh0FeN3gZ5J9j98MxkLi3/uy6T97EKLImMJv/qTVl6faNsywTvgG/?=
 =?us-ascii?Q?Zpw1aKhIZG6VMJwXJ/XbSEl+wt39N+a1sdZ2uoJucbmm4I5ooETx1Xq1O6TL?=
 =?us-ascii?Q?+Ez13nDvoiMfQLsIb6Gifpn2/HO7cmwqtQfW2pqq5yNgLOAl6pdfRqJyKOrh?=
 =?us-ascii?Q?boWXg22UJwj7J0eAyKzNm2s20nNcOwcSkrpeaLhrxFprgyiHLmOA37/gZHLL?=
 =?us-ascii?Q?l3YdW3GCuzJrmf04fMyc/qbnTT545QSLCBXdxMuGe2UCVZjqdDlYpQEVzEo0?=
 =?us-ascii?Q?M4w2POraqiablGUisb6jFN2CGWx9B/NpAI6lWJsXZgmTZmht3kERbXotK4GS?=
 =?us-ascii?Q?hwX+x7FlTHOp++7qISSMViIatSpvEYy4Wd2+FAlsgVltVS1BMtBRkDT2bsGj?=
 =?us-ascii?Q?Tt5wWhi7V5QyAOUN2i2fIcnj8huIJfUv3HTDN4UA3G10vxVF0VHXth+DAjSx?=
 =?us-ascii?Q?vs5H3Tt9ZOIihcIGti2vMTfG+y/HfI+hhgKbbZjGJFRe8k2zyYsJZy9n2IZ5?=
 =?us-ascii?Q?gZHw65K14/333JxtlTlJVtdcsOwnNLXaZdZMDomNVLKhjsXzKXV1uptkqR7n?=
 =?us-ascii?Q?Lb1MMcfOat2wJvKio/uGfgHi3l0f7t3JCOxuZXtL8J/NU9vwlFDqryHQb08F?=
 =?us-ascii?Q?9LO2CGyg/bhv4g22cu+Y9LgT2ozjZF+EjoPgHIw9OkwYomcIA8JE96wcA42x?=
 =?us-ascii?Q?izRrNSn6Mo6truv7AYDggKHVn0uIl5j0rDD3wmmWVc5xVzJIkIe3dRMrTzEh?=
 =?us-ascii?Q?Oq5mc0vSzaA7d+B7HPWOGIzFEbYm5glryWH9ak4zRFbJMwb+yC8yLeTVfrs7?=
 =?us-ascii?Q?FVftm/0LrUiBRjxcELR75cnBSAnpgSQESxlUhtP4z6B3wuIz8yZpQDdvKuDY?=
 =?us-ascii?Q?bkw3Q5NcIjJEJU2Y0hZvvJGqa04YoyZxGp+luEQeWH89prX8xQ+Z5o1jC98K?=
 =?us-ascii?Q?SZ5o36MAYsIw/Ak2XbndOZ3nposBY555UmKMhpFFHKOzvs+Gww8u4Rmxojf3?=
 =?us-ascii?Q?fG9gJN/dvIHAyLvF2GmJCe6I7uARFaze2uZP806FWnnrNT7Hp0T5kjIr8tsV?=
 =?us-ascii?Q?3MeM8VRWBQY=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:54:30.6016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d52550-3d93-4ab9-5f0e-08dd54d2612c
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10115

If linker garbage collection is active, we must ensure that the vectors
are not removed during linking (by using the KEEP keyword).  But it
seems that the LLD linker doesn't support using the KEEP() keyword
within an overlay description.

The GNU linker manual shows an alternative way to accomplish the same
result without using the overlay statement:

https://sourceware.org/binutils/docs/ld/Overlay-Description.html

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502222158.UhwuvDZv-lkp@intel.com/
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
v2:
- added this patch as the kernel test robot complained when
  using the LLD linker:
  https://lore.kernel.org/all/202502222158.UhwuvDZv-lkp@intel.com/

 arch/arm/include/asm/vmlinux.lds.h | 21 +++++++++++++--------
 arch/arm/kernel/vmlinux-xip.lds.S  |  2 ++
 arch/arm/kernel/vmlinux.lds.S      |  2 ++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index d60f6e83a9f7..7ba309f826f9 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -31,7 +31,7 @@
  * https://github.com/ClangBuiltLinux/linux/issues/1609
  */
 #ifdef CONFIG_LD_IS_LLD
-#define NOCROSSREFS
+#define NOCROSSREFS(...)
 #endif
 
 /* Set start/end symbol names to the LMA for the section */
@@ -123,16 +123,19 @@
  */
 #define ARM_VECTORS							\
 	__vectors_lma = .;						\
-	OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {		\
-		.vectors {						\
+	/* Note: The LLD linker seems not to support marking input */	\
+	/* sections with KEEP() inside a OVERLAY statement */		\
+	.vectors 0xffff0000 : AT (__vectors_lma) {			\
 			*(.vectors)					\
-		}							\
-		.vectors.bhb.loop8 {					\
+	}								\
+	.vectors.bhb.loop8 0xffff0000 : AT (__vectors_lma +		\
+		SIZEOF(.vectors)) {					\
 			*(.vectors.bhb.loop8)				\
-		}							\
-		.vectors.bhb.bpiall {					\
+	}								\
+	.vectors.bhb.bpiall 0xffff0000 : AT (__vectors_lma +		\
+		SIZEOF(.vectors) +					\
+		SIZEOF(.vectors.bhb.loop8)) {				\
 			*(.vectors.bhb.bpiall)				\
-		}							\
 	}								\
 	ARM_LMA(__vectors, .vectors);					\
 	ARM_LMA(__vectors_bhb_loop8, .vectors.bhb.loop8);		\
@@ -150,6 +153,8 @@
 									\
 	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
 
+#define ARM_NOCROSSREFS NOCROSSREFS(.vectors .vectors.bhb.loop8 .vectors.bhb.bpiall)
+
 #define ARM_TCM								\
 	__itcm_start = ALIGN(4);					\
 	.text_itcm ITCM_OFFSET : AT(__itcm_start - LOAD_OFFSET) {	\
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 5eddb75a7174..496d609c24c8 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -159,6 +159,8 @@ SECTIONS
 	ARM_ASSERTS
 }
 
+ARM_NOCROSSREFS
+
 /*
  * These must never be empty
  * If you have to comment these two assert statements out, your
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index de373c6c2ae8..514a030b7d5f 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -158,6 +158,8 @@ SECTIONS
 	ARM_ASSERTS
 }
 
+ARM_NOCROSSREFS
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 /*
  * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
-- 
2.43.0


