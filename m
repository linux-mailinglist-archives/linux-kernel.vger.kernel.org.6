Return-Path: <linux-kernel+bounces-311310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9896876A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A991B212E3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746519E97A;
	Mon,  2 Sep 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DkH0goj1"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF2819E96F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279950; cv=fail; b=Pb26vXs+APf6hK3e6KaQrnPWPOkmWwVycUoPKas+NXwt8gJGTjeyoL8FKuotv2iPbXw7++JJPJwa+h8U2Zxq486xwrh/xFaQYi+Dql+f1jvOMCqgWSttIp5JApHswMLxlbk5+4smWRRRisC7Lj5EAgqfAXIUj4kfUPngPXA9BYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279950; c=relaxed/simple;
	bh=cnbq8WPPYCYfhmmR3IXNWmHJNutToV9IrjCBR2ll80w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VcTDn1z5Vsvhj1yP5U7EZ2ATyVfaFgZxXu06JXQxyl7tKP16qrHws58AO/lwz81F1PaVr6sCAItbRPQNZNZx3MA11ktLoFKjxHOsyB0+eone7Ut86k3PU6WCnee+kFf+kwCAsehUhP6QlDqicd/68WW0kxkExWYoq2QSIUiOAqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DkH0goj1; arc=fail smtp.client-ip=40.107.117.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LArwxC3lrZg2RZSCRQIfmcZ8y+bINJFU8z/6iR+BLo+7u7XzQfJUR5U/tfQDXCEGbGLoKqg228ChYo0HTdj6kyy94Z0EZ2d7Zx6hWCReeITaIGbjeC1X03rYQXoSp5mrkgRWxZWFiC+c3PodAQLmjPqKKGRztH6V+Di0Ax2WMmTQ2VYPZIETyrC5UdxEDd0SuMjFqGvbiZ3NlxidI20MR4f24OZxzq0R8sW2nAWb41ByuvXxVyx0ljxB/MoDfIbvEEL16soyUif09Wza56ZfRLC/49r7YtgKoNVaeK84soZhfDvVM0+0Gp3DayZVXHH6ZpvK9YVnCI73F7Y7sHF5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hRT0pOvO7lfpsm388L41+nqwAtGmQPubJztREzsfdE=;
 b=gxWcABEmDEJBpE0r+TE1z2ihumEpEuuJ1HSeOpUcF3vH5aHP5EwHBlynFObxnE8Io/LX3F3Kk8qYIom93X40M9mxF1lOooRolxiAYKDMsEO0n6mFxTpOnmm4nqlLwC2ZP586LvX2eT2hlYLUoaTqRrkdBv3MTE6YhOEQktbKF3POSf79o6WMQsJK3FQeKNtYCA0Y0z/IeJYx9THsmYpp5GzwGp73o5ipe2xNxWOWJz/0R/s4N8Ii1jsC2Iv8WdiWuG48m4wG6WPJAncc8V/h+5IBoqTTOunBxnMkXm2MAmlubvgBEZYRurLXayogRQvrEFH8Yz0lOT/RGyKg7TqZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hRT0pOvO7lfpsm388L41+nqwAtGmQPubJztREzsfdE=;
 b=DkH0goj1sDq/yEjGZ/wFxdsRzuVzeJeaBsjqZ1+2haOnEM9NFdU3KwHMkYNXRJJ65YSGMWgux0XSE3Aaxs98TGjt8pUaTMIz8nLMQEoo7MDb8yXn3cNYAoSW+OnowYRy4N9D/SMliq+mPf0/EcHt4VsWxPaYZQDQKfwk2nw77WBxVGiXsyDGvJWYoGWV9avHh/ijXySqqQMPPmbaJGUsGpmPJYOAw7HKDrzodck6+0fAEQ+IW24PDTcZO5TgaqOZrcIoZF3UHYuitmmuh+cMJbIT32/DH8Bn1ccYV9tuIEdvaRonqSwPCmi3aoE5nGuZALfnBKPn5YtxircxuqC0Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB6427.apcprd06.prod.outlook.com (2603:1096:820:f6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Mon, 2 Sep 2024 12:25:42 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 12:25:42 +0000
From: Rong Qianfeng <rongqianfeng@vivo.com>
To: vbabka@suse.cz,
	mgorman@techsingularity.net,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Rong Qianfeng <rongqianfeng@vivo.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH] mm: Skip the reserved bootmem for compaction
Date: Mon,  2 Sep 2024 20:24:43 +0800
Message-Id: <20240902122445.11805-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: b09874d4-0431-49c3-9857-08dccb4a5cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e71+JnNfaP+Ws2kB7Qyyay57KiVMLT6wFDrtLGzBHXtIPLRfKXcJ+u5wzhiL?=
 =?us-ascii?Q?pvH7FAMQkzH0+k7S3k4yOVxqk5n01EQSCx7ttyNhm0pm4YMh09MKqcCKN5ix?=
 =?us-ascii?Q?fF3K+qyOnFuPE8Fy9qU8yslc2HKkPOInM0iC67pgf3r7katiTsqnDxZNClWU?=
 =?us-ascii?Q?7Cf8qOYNPDUGHW5xebIlxoO15dMsDk/SNxbX2Og2mAugeNEcJQep+jjxSyt4?=
 =?us-ascii?Q?AQbl5k61V18g/iDV+XNIQAA706kvaSF5zwdB9ZeecNlvLptV1h33/1Mn2y3/?=
 =?us-ascii?Q?zuSJBDxB+A0g4rkunEToHfKKYcC0BUn2ZPZAGJ3/RCwJjIyxJFfm7J7HwNp9?=
 =?us-ascii?Q?3t+OQ3F+TbliPNhhrZqCut5ZnRr2ZM1P7wPDUDDM2ammdFShn6/jrQLMC4+V?=
 =?us-ascii?Q?/g66pb6Le29SKOnDzSzR0PMQFCP8q1W47rzgYufrFzTWQL8dmjRv8sAfxKYB?=
 =?us-ascii?Q?fHLwjUYx8UQS7xobz1z+qY23LuUAZUxC6smXeE+D5K7hHIwlfrK5ZEz4bzY7?=
 =?us-ascii?Q?1MltmN/ERE1JSwGjU1i5x//xwNclXf5NCcp+SX7IwlvyZgsUCO65cDch+EYR?=
 =?us-ascii?Q?bSaIVetPYsYKDhXxbFZ3ltsKk+kqBrk8BkQJQ/OcKDo+LhXSsZJMOtMvIBr8?=
 =?us-ascii?Q?drOaJVjKJK3QO2TDWoyZgGEBjWmPzZd6wKsaUCG1vXsHZHwgdRn9jJ8Z2DWs?=
 =?us-ascii?Q?rf3+Vha4Mwk1CvDr8ZB1q3FK+BRtPFKxpCkxCoEfFW4zNq5t5tM7iY3ZA8Jn?=
 =?us-ascii?Q?9zxz5hCX3Jd6bAJML231/VlaKeYr5Rm+8p7ij0ujp/+vqbTvs2g4o4pmn/Uu?=
 =?us-ascii?Q?qKcHmyO3qD0IvcAnG51AV8tmSRRj14uPIlOgJ7UOK9fIGEmVwGCkWuv0lWOu?=
 =?us-ascii?Q?QYMPIjO8MA7Sf35WB1e2CfffFI/uORHK5hB/HEQMkmDHucSpLLvGHMA25gP+?=
 =?us-ascii?Q?jxigKM6mHfyfKgsJLl7jaT78S/xHWVAwQZJNp5j+tFDGtJh/ZV3SRLPKiF5n?=
 =?us-ascii?Q?AYlQZjSEN/HHAK6oIXX4f215g+M4J9lm7/fHBcgKIPXqCBxwjxGyyeoWvhgw?=
 =?us-ascii?Q?wtyrAD1e7n656rQuLeRn97Fri7I2Zl8GoniS5RcD0Ujh9l0+aiZdsIVaYB9d?=
 =?us-ascii?Q?U4UQTZDH1Oh8aUpxgGajtVg+poAx1xNWD4H1Swyty2bcnzgw7r6Mli6aXiF9?=
 =?us-ascii?Q?8KW/u/hDADfw7/v1+RyvUbdLYJq2w58OVXAK43DPkIX1UbDFKIZAj63SmPz8?=
 =?us-ascii?Q?aPEuWxdJY2VYOrxs36GPammhImPVbPcDbrlwW8F3GYFxRmalV1MXkuiPc7ev?=
 =?us-ascii?Q?n3GeHfYRsplQaFLu48b3DtIPiDKM22Sd1e1pyAn6THvaLIOjXQvawpzlS5uL?=
 =?us-ascii?Q?Os4PNtyS4AusrH1HAYdN6hNqZFfVpbpc4iUX4+uL+gD8WPpU5YpubfI5/U9n?=
 =?us-ascii?Q?GrJqrLwCBYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3EOMbUD0eofrSqtHf8WOYBqCV1hLMf3BQNDBNUfAQQ7jtUk7K0hILaVh1i/d?=
 =?us-ascii?Q?1btV/fKLHG/us715kS0AK3zoC/a8K72EZUQpK//bW3cYbDfgtkhXzumiSVOO?=
 =?us-ascii?Q?JbxeHdFoiitaWCQkdTcpTBPmC8qOWRh3OEMhefxl4+MODVz8io/NJGeuh6n2?=
 =?us-ascii?Q?wQuk/kTsO5Rc+jInW9dmXqO95X3VnG8bl8TjXfVfbxLiSIbA35Jl3PYJ9lug?=
 =?us-ascii?Q?F8WVJ/ou+w/J3tvMSpOQhlgyDXISmoniJ4LRpf6jXFPeW8GCW0cFga2TqT1X?=
 =?us-ascii?Q?m5758Z/nVaq4kkLShMGIHHpp04imeHdwWZH+IgZOX8B/PoZ8N1p96ke0uJwG?=
 =?us-ascii?Q?SR7YuNTXz6IQoAB7wlKnoV10Q3br+NW+NyVFD7lia3SryLWLUjTi1CR2jRlh?=
 =?us-ascii?Q?ln9SM9Z74xKbCST1zrUB+ahAWCVTo/uYb5znY6acelXWZW5KLe6SNFKVlCLk?=
 =?us-ascii?Q?c/msOWmZ8RFDJ4MIdp65T/TJi0j3WBaUwFYJTtY3btGr2b2Ff0ZXaZworej7?=
 =?us-ascii?Q?BRD8f4/AIyFWwfYEfcV90cm5lklQMBOxZ0FwgpMTV6Il22bY/HjIKH89SlMn?=
 =?us-ascii?Q?3R5tYNj0qIFDYavyCj/kjV+dgZq1z8pubaskpu65jFqEZUtfXSm9SXo/RFQW?=
 =?us-ascii?Q?ulwWCIaXOPOQOY/1dh52NbhvwB4k0y6hHrxGEtH8sX2f7gb/alICugll1XDq?=
 =?us-ascii?Q?Xs9TyoEEaejhz4ezbgryvcY3A318L2ibCS7G5z1HtqlQ1A9p/hBAhGXOR04M?=
 =?us-ascii?Q?epZe2qJAvIf66cGJ4BbyBrZmRh1MrWVBTvySh9ePLiGyQ70951MFwEw5Zd6b?=
 =?us-ascii?Q?nGF+Y0ZcWsQPlZmztaU+jKFRDU30soiLtVTw6myR0BKF2CuvzvpBbKs+YVvm?=
 =?us-ascii?Q?n1gX7bez60x9dUGuGmIEWEpWi58zhd6t9dJCv6D18FVhw0pLsaGAlqOnvn6n?=
 =?us-ascii?Q?q3Wo+d3tEqUrExgk7Obelu5KxSLyFrI5uckI4scLdORbyymR85blcfh9NTtQ?=
 =?us-ascii?Q?UqDppcj358dwFM1FIWHwVxvv+UbqLYxULWZ4wNTRYLas6Y3HgsEpMsGvzo1U?=
 =?us-ascii?Q?Cu7cuXoVnI2urbmedKbiZLZFmaPtIu5dqcv5oG40Xo75fmY739pK7C0iWo3m?=
 =?us-ascii?Q?9dQFZW5qnRCQ+xOHDlc8/vN9+ADJHhRenpIesAxaSqK5IkkT1D+Oc/prAM8S?=
 =?us-ascii?Q?er8tWH/xdUf4CIiBPKYBvn7c9T7D23J8gUkyuXipN4I8dZ/d8qlFsnxuESFw?=
 =?us-ascii?Q?dzVt115+K49qGoSKKNC+FE/xYF2vm01gsu6yddHntkpkDg86tCvP80vdqLMG?=
 =?us-ascii?Q?gmI66y9rrQnU8rk/6d57Z0N5QeMY78v+0PFXi7USsXNPvm3u5WzT0pYKbSos?=
 =?us-ascii?Q?UEJYnDr2CyCfVyH49nTgNVQER3OVRuR2m2FsKXt+qUWF1Z2SCZTXetuXG3Wu?=
 =?us-ascii?Q?4K8Qcr9b0O2TTIFtEwuE9H77F8BiP0scImUoXbpurqq+u/WH0rBpYRFYac4K?=
 =?us-ascii?Q?H1IVidoHlb+G2tSasawcMfGD8IzhIf9/gZWP5UY9XRs98xzRnONQzd+3c8Wm?=
 =?us-ascii?Q?f4T8o2gWhq2VHHPNxD3oNvymQwxZC9tMV6AGYsWb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09874d4-0431-49c3-9857-08dccb4a5cad
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 12:25:42.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTQuU3/ofMVUs2VJXyzQc1bewcESO1J74qiRl22WH3Br//mCPgSDyubp5Coj54kKryarWiXea42V3sSLJWrcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6427

Reserved pages are basically non-lru pages. This kind of memory can't be=0D
used as migration sources and targets, skip it can bring some performance=0D
benefits.=0D
=0D
Because some drivers may also use PG_reserved, we just set PB_migrate_skip=
=0D
for those clustered reserved bootmem during memory initialization.=0D

Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
---
 include/linux/pageblock-flags.h | 13 +++++++++++
 mm/compaction.c                 | 40 +++++++++++++++++++++++++++++++++
 mm/mm_init.c                    | 14 ++++++++++++
 mm/page_alloc.c                 |  7 ++++++
 4 files changed, 74 insertions(+)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flag=
s.h
index fc6b9c87cb0a..63c5b0c69c1a 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -86,6 +86,11 @@ void set_pfnblock_flags_mask(struct page *page,
 	set_pfnblock_flags_mask(page, (1 << PB_migrate_skip),	\
 			page_to_pfn(page),			\
 			(1 << PB_migrate_skip))
+
+extern void set_pageblock_skip_range(unsigned long start_pfn,
+				     unsigned long end_pfn);
+extern void clear_pageblock_skip_range(unsigned long start_pfn,
+				       unsigned long end_pfn);
 #else
 static inline bool get_pageblock_skip(struct page *page)
 {
@@ -97,6 +102,14 @@ static inline void clear_pageblock_skip(struct page *pa=
ge)
 static inline void set_pageblock_skip(struct page *page)
 {
 }
+static inline void set_pageblock_skip_range(unsigned long start_pfn,
+					    unsigned long end_pfn)
+{
+}
+static inline void clear_pageblock_skip_range(unsigned long start_pfn,
+					      unsigned long end_pfn)
+{
+}
 #endif /* CONFIG_COMPACTION */
=20
 #endif	/* PAGEBLOCK_FLAGS_H */
diff --git a/mm/compaction.c b/mm/compaction.c
index f2af4493a878..7861588b34f3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -286,6 +286,46 @@ static unsigned long skip_offline_sections_reverse(uns=
igned long start_pfn)
 }
 #endif
=20
+/*
+ * This function is currently used to set PB_migrate_skip for the reserved
+ * bootmem which can't be used as migration sources and targets(except CMA=
).
+ */
+void set_pageblock_skip_range(unsigned long start_pfn,
+			      unsigned long end_pfn)
+{
+	unsigned long pfn;
+
+	start_pfn =3D ALIGN(start_pfn, pageblock_nr_pages);
+	end_pfn =3D ALIGN_DOWN(end_pfn, pageblock_nr_pages);
+
+	for (pfn =3D start_pfn; pfn < end_pfn;
+				pfn +=3D pageblock_nr_pages) {
+		if (pfn_valid(pfn)) {
+			struct page *page =3D pfn_to_page(pfn);
+
+			set_pageblock_skip(page);
+		}
+	}
+}
+
+void clear_pageblock_skip_range(unsigned long start_pfn,
+				unsigned long end_pfn)
+{
+	unsigned long pfn;
+
+	start_pfn =3D ALIGN_DOWN(start_pfn, pageblock_nr_pages);
+	end_pfn =3D ALIGN(end_pfn, pageblock_nr_pages);
+
+	for (pfn =3D start_pfn; pfn < end_pfn;
+				pfn +=3D pageblock_nr_pages) {
+		if (pfn_valid(pfn)) {
+			struct page *page =3D pfn_to_page(pfn);
+
+			clear_pageblock_skip(page);
+		}
+	}
+}
+
 /*
  * Compound pages of >=3D pageblock_order should consistently be skipped u=
ntil
  * released. It is always pointless to compact pages of such order (if the=
y are
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607aaf19..8b7dc8e00bf1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -768,6 +768,13 @@ void __meminit reserve_bootmem_region(phys_addr_t star=
t,
 			__SetPageReserved(page);
 		}
 	}
+
+	/*
+	 * Set PB_migrate_skip for reserved region. for cma memory
+	 * and the memory released by free_reserved_area(), we will
+	 * clear PB_migrate_skip when they are initialized.
+	 */
+	set_pageblock_skip_range(start_pfn, end_pfn);
 }
=20
 /* If zone is ZONE_MOVABLE but memory is mirrored, it is an overlapped ini=
t */
@@ -2236,6 +2243,13 @@ void __init init_cma_reserved_pageblock(struct page =
*page)
 		set_page_count(p, 0);
 	} while (++p, --i);
=20
+	/*
+	 * We set the PB_migrate_skip in
+	 * reserve_bootmem_region() for cma
+	 * memory, clear it now.
+	 */
+	clear_pageblock_skip(page);
+
 	set_pageblock_migratetype(page, MIGRATE_CMA);
 	set_page_refcounted(page);
 	/* pages were reserved and not allocated */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b98f9bb28234..a7729dac0198 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5887,6 +5887,13 @@ unsigned long free_reserved_area(void *start, void *=
end, int poison, const char
 	if (pages && s)
 		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
=20
+	/*
+	 * Clear PB_migrate_skip if the memory have released
+	 * to the buddy system.
+	 */
+	clear_pageblock_skip_range(page_to_pfn(virt_to_page(start)),
+				   page_to_pfn(virt_to_page(end)));
+
 	return pages;
 }
=20
--=20
2.39.0


