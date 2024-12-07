Return-Path: <linux-kernel+bounces-436095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6049E8116
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F3518840EF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7C84644E;
	Sat,  7 Dec 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V47MbQOW"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8A3FF1
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733590517; cv=fail; b=Ylr21JFj2aw+tyiKihhUtZmsmLp50gFneOCzQ8T6IqkZjJl2CuIvDfSnugOcEue2KPB3ERgXD/WzlNgaAk9hC8TKmbg6XJG1P7E9k6H91IWoIcQArh0JzOB/chkVAxKURThB4aBtw5QZzLjbpdmkqotSqLi/l/4jZx0UR8cCnbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733590517; c=relaxed/simple;
	bh=uSXPJFUDzGMEvlWPxzMhTo8KbnJLD/G2naC0WMQnMpE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PKI4KeN+O/E2AXkEfPKhRr2hLqqHv5KgbhavV/UMevb/7DMZ8ofX4mRIXfp1kqp3S5nBIGrdO6xmOwDkbNZKlmROBSNk3UC35ANoVycAbvH+UfaR09hlFN4j2fqdZN3zGuthlkK7ajXPRInqFiTg23KEZeBHGBqHzhXUD5FIDko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V47MbQOW; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g43+6FPxTHKH97biJc+nvbm8RzTsofVNLdC0RqBlh6FbW66qQeuZRRygGmHdtA23h16ZUMiu4czPC+10ZEgUjkV1mjeTK5JCXKNG5ZAjBSNoIJVZUfWG2nNvKOWZ91XBpYGN52oFJJOpLiKh8hHbfPs9nZ69a1lfRqUBCP/yFDNKqIc4vlUn4AHcB9MqnQNb8pMO+tOx7aa6de9kPJp3jpdJpp5Oy6B+dCUzmPDFQHP4RlaQOcvPxJw5DRV1LDWska+BUA7mwPwad6P8j9+fdEpLE/IIcDcoeGehyNuKETAKqaj5H5ZBlK7DmFmJruzOV0G0EqhAY4nCdbmOaOYVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91j+UUl+idUfk8C4PcBDPsKC/XMGlAuu8q1FPv8PRf8=;
 b=mLP93/Rhg/Iw04TxgHAFwfJ7RHBRbWW0HZMw3oag6OfgxYmPxh5SpSvi2UdeOcOkYVLPGpVa/Vkc9L+5OU/MCx1AbqIV+zcrXgRgJ6XPILqGMqIIzmrUrcmjBU5sStWcBmRXIZX5jskhP4JCNpLDzIxH7TuMGyceufnRjJB6emzwfZHzj3cBZKR9/HknAYX/Zrm4z1f2WM6LhNKQuT+FhA1cocobANGEZ+T3GFQ7kH9fUMxJuEwpNREKx9jXbr6iQFY0i+h2v4KepBwDUwFZL154KKJtvB0tMv2K7PQsioDvfoL7JSPGqJyIc+GkR7PooBOaVe8yDcRqqM8JYebgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91j+UUl+idUfk8C4PcBDPsKC/XMGlAuu8q1FPv8PRf8=;
 b=V47MbQOWyasGPmL8ayyfFSyb8+RHXMhO30Qn5mT9Ec0HHsT88G6DM9p5THbIkXJt+L/fHnD1QxglxnPehW2oXuCg+7/jy12JW9QBdDCaYLqJaGZoA9wwKhBiX5Nx1i/TlD9xS9J5R9mMQL7aqyFrG7wR2Dnr9rcGfqbqNXxAIdGr+mGt5/dlRZHxEdnH1u1ezE8MRwxBIAqYHnQoHsWU8F1rkWKR1CdeKzes27fcQZ3QQ6J+vvAGTzeAb4qgSeGcd7tjFDMOm01td2R7YgNHYBJva2nNBEjh5F8wZWaeGKuqoNxM26wRESbUbh2jou5actS7h+f0lJLAtgfvPuK+xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Sat, 7 Dec 2024 16:55:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 16:55:09 +0000
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
Subject: [PATCH v3 1/2] Introduce cpu_icache_is_aliasing() across all architectures
Date: Sat,  7 Dec 2024 11:55:03 -0500
Message-ID: <20241207165504.2852058-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: e3886f22-a212-4934-d62c-08dd16dfe8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M1tUwmlTVXyR8rf5YZ1qPQGr9tPtkknJ2OAc0QV/OJlTju0MFWf47c3TXPQD?=
 =?us-ascii?Q?gX9b496zkigK+5C8Kvlkcrr9b43EhW79oH/VKPUCSAw75RUfcCLDK02+f+S6?=
 =?us-ascii?Q?I55up0bFnZt8AGLXYSiKJJ2YUAuxF3XuXjSQUAgjj6x0ZNgWqzudmWuUBv23?=
 =?us-ascii?Q?iLiTEZmVUGJqzSQTBUsj0ppoaajJWq1SJS7V4qObykfADektQXolGOHRUjl4?=
 =?us-ascii?Q?9X/yx2Bu4UINEJvhk4hwdXyBWixxLOqKQde4kDip6LpX8F+vR37ErTKsGz0w?=
 =?us-ascii?Q?uU+ip75TBeZf9ZpqIqzixbAqJ6j6kIflt/T/MvwErbpcIVEFksj7Cp6vbKVl?=
 =?us-ascii?Q?dLC/1OsBgPALVnQ6JevYY6LIpQyvieL1+1F/nguohcTTMpvuv7u6Z3gBQR37?=
 =?us-ascii?Q?yyeP3zNnWD4vBR6B6ySNhgD5v5eeO/pvDRl7cmsvpFhryW8eVCHaaBkCvmep?=
 =?us-ascii?Q?vxbGI9b5r0q0qL2FlviheNWfUkX/ZGfEF0/OXBsQz5h2uHVabqLfcEOd70c6?=
 =?us-ascii?Q?i2+TnPdL8NunoTAdvvPaiQ827pButoqoy1Sh0Xw8zcZy6JqxcxdVWDxoDMyB?=
 =?us-ascii?Q?UxIg9emCQp6i/lf2zjrcR2wJW4MXCKRRu8CqTtbsyez30dndj5xoFHB4H1Vc?=
 =?us-ascii?Q?Gj1Xxr2lkm2UwTsq4SLBTPKY8FYCY+sbZXcR/B81/vRobcYDzOBrMuwnwoVG?=
 =?us-ascii?Q?/KYUfdAjz3958mARjXl/F7mj/BaYe8/Gr/nABlD3715+862A363U+7rIKcca?=
 =?us-ascii?Q?BVxurdMN5Zsp5qvsku91xRx3GbH8ozyDmGqOHBI023rBe2f9MKPqH/3ypZAu?=
 =?us-ascii?Q?qrl49MkaOauO5iYKeK75JkMZjKXVGdDrlQlTAFbcrzcroctCdNYIEgRGCg96?=
 =?us-ascii?Q?/HAtatmfQTFBL97jlDvoYyle83YNlZD4fSsELAWNJ/MRNryVUaJhqmvs0DnV?=
 =?us-ascii?Q?Sos74VGUYHBqEutIf/t/r8FlIAfa2GvMBD9fdtSNJ7cVjpvbsBFckU52j5LF?=
 =?us-ascii?Q?FxE3ZDypW7LvkTTnCnRw4ePH0p0suTo2zuT6q0oZZ08cIfi0mJ2BB1MqCeEP?=
 =?us-ascii?Q?1NcDRkeVDz4mQVu+KFA8kVoMDDwjlImgA1t6xVDME2/vifRnE9vYkH6P5dAq?=
 =?us-ascii?Q?VcAQ9qJWxsOHyqjua01EBJYfDbN+kwW6FL0ae7x7A1sznf7Kn5sbXXjKKoRX?=
 =?us-ascii?Q?9R7PvIVsqxeHc6Z1DLe+229cZSCcZpZ642cxTm44+IDUPPmiZT/RVQgiNmDt?=
 =?us-ascii?Q?4tOtvJnBodYy3lNLZcgVfy3GKfCC+mQ1uDlD7H0SuDGXPRjgZ9Cd2gmGZ/w5?=
 =?us-ascii?Q?/VZfv4XA4h7qVaeCnCKS36FZMFgH2MQr0jLtq6rjl5CwDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ai+mS0QPDU/qlmtVMKrtIkkXNm5shfJRKSaF17U2nBw4ynq4HjekfoChoxcA?=
 =?us-ascii?Q?C8F4NZR85ATCf8YbbRlVerNf8lmshYUtvr1umyIdfqpZxvgqZIRIgpMJ+o9/?=
 =?us-ascii?Q?eS3YAhOZEn/K3uyeWWSMiRmaLQTqpklamKMqQiccQnw6z4zp6FtIH48kTcN6?=
 =?us-ascii?Q?RCczZi4ui+dRqdO8D1kmM0b2QwxnitIGZcAllZarTtvDpzAUvSs13Ez2HdEw?=
 =?us-ascii?Q?hxMT4Hm90Y/Pv+oulHwd+wTV6LM5ErVZH8fH4Tsh6/9of5HIE+yPVUhblPNE?=
 =?us-ascii?Q?pLfrUajS3VApAQ2RK7eRaFiYbytoQ4quHIFMjKwSUu8Ngz04LO9cfWmh7Huu?=
 =?us-ascii?Q?we5lT0K9tjOZnuzwdGJjxTi4+DQtr7j0i/U0q7RYHovRx68pfCYZ9T6p3mmL?=
 =?us-ascii?Q?k0deyqm3z5xqrE1BcK7WN6/KOObziqVE/G5ma6i0gRLnJKLxpYqID6KkOntL?=
 =?us-ascii?Q?WSuSfFhiOLz68FmKJ0xJqUdi5WdBGvUoz3DUv7ra7umLUkv7rTsTkzEyWVLa?=
 =?us-ascii?Q?tQIPu1z5ovAye3TlNMzPdElfA43sMXf11ATAzVlIhiV05WWe/YjtCAi2bc/e?=
 =?us-ascii?Q?ghT91lvX34brCrWYgmVarJqg/999MCkUSoJW8PSytpK9WiQXijcYJtdE+/fS?=
 =?us-ascii?Q?E1i1qKQ5Yog1G4hPU9TRkBKeOvoUhexp2Cefj87dRybCnJgwnSit3OkplS7N?=
 =?us-ascii?Q?CIjPY7F3wPy0AD5Z4PQHaI/TrKUE58JQIXaLLX4OmUgj8k+dR/a4315GUZ8m?=
 =?us-ascii?Q?zgK6aaWHQVIWUea8s3GnmtCVZoTcqNIurDmfXd0ov+UQ3lReWTFLXnyovCK2?=
 =?us-ascii?Q?Fb73rWu6ZnvOA4ZH0lJooKrWbB7Kb4VtUgMgqNqQUk6SX63vIv6L+/htfEIs?=
 =?us-ascii?Q?4bTr1Y4DwV22awGtzNRiVnM3dzpc4kHUcBX0/R7HmQo71tCHG31wkXcQr6RN?=
 =?us-ascii?Q?5NnhqNVZxnp1zMnxTdvTNNt78XGJRnm4cJ+xAtulGlydRcKMRuO5NT+f56Wn?=
 =?us-ascii?Q?L3/tBC/v2sdHBwFjLCu9NkFg39nrbMdkrQLGBTBgrjmNFixmtAuDP6GBHpJU?=
 =?us-ascii?Q?rY9zM44WMTYT98NK32QuNS19rARIjFdiMPORUbQmbbvz+e9QVMZ567pQIGQY?=
 =?us-ascii?Q?VkJJBp5FJ5KVblzBticvbDFHYgziUR2s8dQZeCX8e2T0jQ+z3Ju/npWl752O?=
 =?us-ascii?Q?swBNDQqKjXDq+hBP7ity+xo9pVeEIwrOz+hQjMtHkIBfg9JipTEt70HJa18+?=
 =?us-ascii?Q?Or+g7snQzympo70+geHgb/Pz01IiEmiNxuNuJT5YVbI7E6QBBk/HMB7dY/79?=
 =?us-ascii?Q?WEM53c268kcTDFF5+dWqwKptUikJrG7PsbUm/1n6QucJ6iFF3xqzP+V38/b2?=
 =?us-ascii?Q?sX9LkiL87Yc6Z2pa0I+1+VZQ0/c9mEQLcxkWj98SWztjtM3cKXUZ5co1gQ75?=
 =?us-ascii?Q?1qFqBV+GMrqQGzsqwRQM+zl6VBWbg+xycja9vrTbGWKCYzywRX+NqZv3vaI/?=
 =?us-ascii?Q?kZPxdmyoyEFmcHQl0gQ9YlTPlQzD0feURJNRR/36LwcYMc9uiztcGYv5Hz54?=
 =?us-ascii?Q?wehcucyCJPdHMd0RH9u5zakQYqNkB/4n33AGkVm0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3886f22-a212-4934-d62c-08dd16dfe8b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 16:55:09.4966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbnLDO/X15uEFtsOEmAxTDXDBsGj+9RVqOXbXeJNabl05NAnhsQJSTeqLDavq6nn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

In commit eacd0e950dc2 ("ARC: [mm] Lazy D-cache flush (non aliasing
VIPT)"), arc adds the need to flush dcache to make icache see the code
page change. This also requires special handling for
clear_user_(high)page(). Introduce cpu_icache_is_aliasing() to make
MM code query special clear_user_(high)page() easier. This will be used
by the following commit.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
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


