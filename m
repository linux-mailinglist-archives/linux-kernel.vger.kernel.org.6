Return-Path: <linux-kernel+bounces-436096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C73F9E8117
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55728281B0D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA914A08E;
	Sat,  7 Dec 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZHnwWI8t"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6723288DB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733590519; cv=fail; b=ExDxYFItEIbiekP+BCggVVif1ZijJyrh5b/6wwDW9GqDU0mQtmlgbao7C25DOu620ZJuKBSFYVGa4iKqvr8WwIm1yHGn65+LaSKCgtz7lAkhOsGlL/e4oDqGHVubbtsfi3Ah6sQ641SEsQ/QSvpARIkGlJnWuirR1UX0Eew678Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733590519; c=relaxed/simple;
	bh=yf2Z392RN3cseJ0PkFeeelB000N0aeUIFW5qGYjFA6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnHFpWV7DWdn0WfLyDJflEsfHViuZKUD60b6yp0+lHpuGQA1A6lJpP70DyBo8BXP/atrzSjaOw9CVoX+Djp4bYvjcPC6yrdZGq04ywtZ550KqzD4mqI/y4ksmluNUyQ6HxvtuOuV+460F6W7KspSYeeVNMP3blXhzrBUBbSY2VE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZHnwWI8t; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRDU83OkNRVGutl0w4MmMFptf8/NmNjBGb6n6fli3OL+8O3msTsRQoYxsWMYO2eUd53+GjyxfIjpQX/i5bH0NEpcaEDdTEjqlksmGas9hCw/R44UKA6lsZRtyvcIvIBG/5mebMOIpHaIEN9Kud5v8l2AkD/2GirOPzsrHBeAow+WxKSsfxRY8qjy5232K8aPDPhwnoGPDtQi1O9yYpKdIpdZi7+mqSGGUEvZyx1dj9CdOA081zU524KYPYYcPFWTDDbGfxEHpliWfwX75BSuzOUrjTp7tGlMtFFtUWg6+zYgQ6lTjaYZ+Dbda0SBigvEQUODCmwdtQvW0C0qwU0i1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFymnYIwzybc1lYwKoXrwnk6I4MsTHm/oq5M30dD9SA=;
 b=WfMpszucI8OD2QLMmQdUCjyXD6UzoDuurnWr3Rihe7bXuEqWIc6VX/5z1XcieWIp9aeajr8BmNaZeK/JeboBJzYV4LRdWtcFCYFTT4o3FvfFcwxhoGkLfRdezl2pcy8b2W2Hnc2jY7V3hGXzHcj4YA1RU1ZLOd7Nbezqw92Yvczw0MMFebhU3/6tO3gPaKOWIiqc1MpmCustJX66oFoPUcuz2W316krF0kxIKYNcciXS3/VERFJ6WorrIHsJ6BWtUznFjrzMpKj7Jlu8hL0Ij1jPzgNWpst/yGKHxHLQHjhX8FGCJ8Hmvdjxqc4HkZz93NN9t6hD/2qDsYaBQ+vj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFymnYIwzybc1lYwKoXrwnk6I4MsTHm/oq5M30dD9SA=;
 b=ZHnwWI8tw1GAvxMP1xppA733jAVQ/gm7+QTbrBOk9AAEu3RFUJmu0Ci7l5bUTiLaVNC2nj1PFEj/+q5ggig//LBcVaZ5z8mxw23mvtCskNZtEm87TSvyCZafausfSp7GDK6AY0Toduw1S6l0lDKuxt09MhwbcJARaqP2d5RVChhK/ZC30071acM9qEJf2tvgsTdRjlr6FaaYBgd0ePsCCV1DMprDhK0Uf0t3e8jbDC2VEvwjTrtqtqW/+VuRKEBHMbcjxbT+Yw+cKe9eumOzrTdG8VF3AIoTVJIqvt3d1BBVOR9B/tUD4ktTWEHhrvz/9WcMg53VmWtKDFKg+fZjyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Sat, 7 Dec 2024 16:55:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 16:55:11 +0000
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
	Zi Yan <ziy@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/2] mm: use clear_user_(high)page() for arch with special user folio handling
Date: Sat,  7 Dec 2024 11:55:04 -0500
Message-ID: <20241207165504.2852058-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241207165504.2852058-1-ziy@nvidia.com>
References: <20241207165504.2852058-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: af7466e2-8880-4c69-543e-08dd16dfe97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zlI+7oHK89o3KMZqk96F14Hc8k8mwdZvpKJKp98yRmJQ6CXx3fLNmldTzaXi?=
 =?us-ascii?Q?yxIOAxf7nqOSofZdMr6gLAkpz1eiddHwP5WxVzidt/FFNLSXdlz8ioLaYMgy?=
 =?us-ascii?Q?c82v0JaoWWt901yVJG/lyhNAHigPVHXnOe/Sc8zwr/GmM9ZUri+t/rzcMZu6?=
 =?us-ascii?Q?HhNDhaJJ4Gjlzkg3mScWkqTP68MJt6De3VhPO177r/Ebxd0ZQDbK36jaBiEB?=
 =?us-ascii?Q?OUcyuCDKSyj9cXv83c0plxdpUM8+dTM/WV5fbL3p+f0xw1oag98M7PxHawTF?=
 =?us-ascii?Q?K8DYI9eIhjWWnJXHTSH52cCe5FuCGTu4rsTfsKZMVg9LmAqcIyIbwH2p+NGB?=
 =?us-ascii?Q?twt/jcPulvFK3KOS6j2KeYpFFTJYcoYIMu4lOFGjkLoP7qje3HY68Lpe+Vxf?=
 =?us-ascii?Q?AcUhF+7GER72jrKk41opT3rcv1vanoY6to0G1jzaiI4On9SVkG39s0lcrmAn?=
 =?us-ascii?Q?cdIXYByYgINVVKNuxr/F6WjJ/VY+hg98cYj1DVn4zL+wElCpebeS6Ks+91Rj?=
 =?us-ascii?Q?/qTpMUYIHPlJnpp/5M2qToMIW2o5Eo16jg6t/3OevTjGvrEzPmySQYfazMRA?=
 =?us-ascii?Q?+kRnM4X1iZdlTtblXf371CXXuTu0KNxxU3tYOXaoZJM4FAEVDe1/FU9h978W?=
 =?us-ascii?Q?JuCbjK5P0Jgp5Y5LfMglgo8Zjdrdwt3MACCDQaLwZUjMTevCyDmx+i/UHYqS?=
 =?us-ascii?Q?KjeHEIzhv6+Qsuc/LPLHAFP7l1h0eiEm7ULUXqAuZndkw6EGxpI6GE03JQiO?=
 =?us-ascii?Q?8/vr6A9oJnigltzuXOALHEXaS8kZHkPKnTxbEsyot63gs4BdjvaC/JVbNUcs?=
 =?us-ascii?Q?BJCyL3JzrJ77riEmWOvcI6EqRUJpRk3GFZuX1+tt4YtQDdtifjukj5nXyW9t?=
 =?us-ascii?Q?DDBVnSSgz+9yYmO+LO0XeFhWFJeyHz37w1vVujBpnJS3BgqVgSde0IyZ3m5L?=
 =?us-ascii?Q?BYbZwKttzVHd+GU2CfXavp74swRlXVTCnOsRapMEyLJYM955Y+gGAC7Wnkr2?=
 =?us-ascii?Q?HywyWX+ZVChTed0igEIUTVfWaOvwGep5yDVN/xp1aSr2L7yZir9wepmTyRQD?=
 =?us-ascii?Q?/rPCpSu1z4rlnDRRPQgSNul1rlf1YPPbUrHPZv+8eCbjD/CkD2gWOXL5mr1v?=
 =?us-ascii?Q?CMbb3lVQsbM0X/cGqS0u1tDH0TdJ1Tvp1D08FqLn/p6GsiXuXwY/Qnwsv0lP?=
 =?us-ascii?Q?6lmBMY3+4/fAqq/2QJG5arrBgx4qhFYPrj1BdpFIhXjDBV+rXCdo/wULzUZ8?=
 =?us-ascii?Q?S1iY1BSipq9k1uOFEupgRifdx1Io679fPMoG69gVqtUVJdn20wNJO1SxRFTI?=
 =?us-ascii?Q?vEle5QICDx5lgVcLuFAG41GIdWbBG51Mhl4ix0aIMwdtj2z9PMEqwpNIFMKD?=
 =?us-ascii?Q?J2Q6BSY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRZIhenbTdBVJSHcopmStKGcc4DeMe+3FUunW6jBSAHcJ3XTKWrcFZCxtyxa?=
 =?us-ascii?Q?jehpGEVv8hpsZ5VbritZGDseP92+6zJurde9e+CndBCSnPmvm4jWAAOxCDf/?=
 =?us-ascii?Q?fOoXZQGShgsrh9DKWrxJGA/+y9LbNqETez8HawkH6xblFOTogfjWFsnoHR41?=
 =?us-ascii?Q?NOsKyaW3rR9xIfR/LhoosMwcvYCSyozvOpQIbQYuXryPQPf5a9XihbJAMlYl?=
 =?us-ascii?Q?hvbvgo8ScLTNFUUTpyA8GNg4VxR+q8+7ePTusJyhcPqpr0OxSn5VpG1kCTbs?=
 =?us-ascii?Q?ojovuxaTF8QsUctIf208b0FiUxBVZN6auHULJcxu/hbzR+1dWpghVqBHue7l?=
 =?us-ascii?Q?ZnbgoDuWTjxP2Pc/nlgRLqXCix9GpVb0kB617m6Pf/VMtYBZqENobFz25g25?=
 =?us-ascii?Q?oVz3tt+2JQ/avBcVPkrZVP3+lEaI+zW4JlBYQ99dC6m5N5GRNjR+/FsX3gQ6?=
 =?us-ascii?Q?Ct7DihuJPk3T+BhwwCdk5c0VC0HOLA3b1V+rd821UCsFgJzirCq8duaxLvV3?=
 =?us-ascii?Q?Z+J/l9BKL5X/tywuxNCYp/kdb3lKeH4/W16WRgeSlTsA2dQ7anxRM2fkm/ni?=
 =?us-ascii?Q?i4O05InPo9UdX+nVmefNVMavaQFsU02Mjc/gwWqVl09EUyzm3w2QCIhSD8pe?=
 =?us-ascii?Q?+ImZo8cE4ih7pMWkiJOqCp+Nx2tMQ8rKAkmE6W5rL+EaAgJxEwmJP7nbTEyX?=
 =?us-ascii?Q?qcHT5jQINkvTb8dwNFAAHFXLoQyTXjGfkY6BFTU1yTmk05GaYYsUsBrGShgZ?=
 =?us-ascii?Q?7MVnXlK6rTIHC6DQ8zv2yjRO+eevFA9hvU4zwuGs6ulssD8jp2OWvhs6Pzqg?=
 =?us-ascii?Q?VM1YcXa2+UxRH1fmADOj7xV1kDI33UIHr2D1+niCNkw89Nmql8F/kXRXYL+E?=
 =?us-ascii?Q?++G75G8uP/ItYsJ3T0vP4i0F1S/WmV5u7m/cI4l+0ZCQ7DQme8ph1KNFKt8c?=
 =?us-ascii?Q?UQKZq3eMDS1P/84j0j8jH8qVkboDVP7uuEtIFtGJWnm6cKg02Po/1LlYHyrW?=
 =?us-ascii?Q?LIAEc0dY8rIuGriCVcu4Db7xIyIGzCtjMrZd4nAUMnFiVCZQdZb+2C9qeyFR?=
 =?us-ascii?Q?X8eYqrNVgYKqYqfVJsPZftHuymPb9tBGw5VlxGpHIDxTyphFe3O4yakEhkqB?=
 =?us-ascii?Q?pMxG7Vyj9SZG2ZEk5lUtgF2cai1Mk35CNgdOO/QWtD6DadiOmz7wI2G/DfQC?=
 =?us-ascii?Q?+8T2QSuC4xsdYolpJsY+yWR2x7KfuPOekC/s6LdsIwotaRMyXpR/siHEa0bi?=
 =?us-ascii?Q?OtNHxR9oTIHCHIdZ5ezG/ulU7amHOzHpDv8WSzCvtzP0tlQSigWa53gEmvw0?=
 =?us-ascii?Q?hxrKOWm/0dKZvwpBLxUo85/mv0zIvFSjqg5qfPJf1WDNRyya08a5UwD8ZOb/?=
 =?us-ascii?Q?Zztxa56wH2JBG8ghQtr6WbHifPoLUdRv3t3W9KCMUXcY6AIsDBqhVg3F0CSy?=
 =?us-ascii?Q?Ueic5PHDh3fiCbv5toJIMb+7nAgqNtqpaslT8AZOEaz4dUnitp6h5Nr9jQ7B?=
 =?us-ascii?Q?IlbOWx11CMAn5n8qtco4c9KH1Y7e/xm3xvUr/VdwuzTD5eU4I/5r90dCH1fx?=
 =?us-ascii?Q?RLu5Oa/hD0K5NX62S875vqcJrLpyR5xO8+jw9aXF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7466e2-8880-4c69-543e-08dd16dfe97e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 16:55:10.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJPdy7woxaLIwUhFOFwDNMQwlkScUHWjgGUAfWRhYEoV3vNRimhLVbBi0A1iPnpQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

For architectures setting cpu_dcache_is_aliasing() to true, which require
flushing dcache, and arc setting cpu_icache_is_aliasing() to true changes
folio->flags to make icache coherent to dcache after clearing a user
folio, __GFP_ZERO using only clear_page() is not enough to zero user
folios and clear_user_(high)page() must be used. Otherwise, user data
will be corrupted.

Fix it by always clearing user folios with clear_user_(high)page() when
cpu_dcache_is_aliasing() is true or cpu_icache_is_aliasing() is true.
Rename alloc_zeroed() to alloc_need_zeroing() and invert the logic to
clarify its intend.

Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with init_on_alloc=1")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=HsfgKQeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/highmem.h |  8 +++++++-
 include/linux/mm.h      | 18 ++++++++++++++++++
 mm/huge_memory.c        |  9 +++++----
 mm/internal.h           |  6 ------
 mm/memory.c             | 10 +++++-----
 5 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6e452bd8e7e3..d9beb8371daa 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -224,7 +224,13 @@ static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr);
+	struct folio *folio;
+
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
+	if (folio && alloc_need_zeroing())
+		clear_user_highpage(&folio->page, vaddr);
+
+	return folio;
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c39c4945946c..72d644cc8d9d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <linux/cacheinfo.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -4175,6 +4176,23 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
 }
 #endif
 
+/*
+ * alloc_need_zeroing checks if a user folio from page allocator needs to be
+ * zeroed or not.
+ */
+static inline bool alloc_need_zeroing(void)
+{
+	/*
+	 * for user folios, arch with cache aliasing requires cache flush and
+	 * arc changes folio->flags to make icache coherent with dcache, so
+	 * always return false to make caller use
+	 * clear_user_page()/clear_user_highpage()
+	 */
+	return (cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()) ||
+	       !static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
+				   &init_on_alloc);
+}
+
 int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee335d96fc39..107130a5413a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1176,11 +1176,12 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	folio_throttle_swaprate(folio, gfp);
 
        /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used),
-	* folio_zero_user() is used to make sure that the page corresponding
-	* to the faulting address will be hot in the cache after zeroing.
+	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
+	* or user folios require special handling, folio_zero_user() is used to
+	* make sure that the page corresponding to the faulting address will be
+	* hot in the cache after zeroing.
 	*/
-	if (!alloc_zeroed())
+	if (alloc_need_zeroing())
 		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
diff --git a/mm/internal.h b/mm/internal.h
index cb8d8e8e3ffa..3bd08bafad04 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1285,12 +1285,6 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 	       pmd_t *pmd, bool write);
 
-static inline bool alloc_zeroed(void)
-{
-	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
-			&init_on_alloc);
-}
-
 /*
  * Parses a string with mem suffixes into its order. Useful to parse kernel
  * parameters.
diff --git a/mm/memory.c b/mm/memory.c
index 75c2dfd04f72..cf1611791856 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4733,12 +4733,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 			folio_throttle_swaprate(folio, gfp);
 			/*
 			 * When a folio is not zeroed during allocation
-			 * (__GFP_ZERO not used), folio_zero_user() is used
-			 * to make sure that the page corresponding to the
-			 * faulting address will be hot in the cache after
-			 * zeroing.
+			 * (__GFP_ZERO not used) or user folios require special
+			 * handling, folio_zero_user() is used to make sure
+			 * that the page corresponding to the faulting address
+			 * will be hot in the cache after zeroing.
 			 */
-			if (!alloc_zeroed())
+			if (alloc_need_zeroing())
 				folio_zero_user(folio, vmf->address);
 			return folio;
 		}
-- 
2.45.2


