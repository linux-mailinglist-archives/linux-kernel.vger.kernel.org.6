Return-Path: <linux-kernel+bounces-435122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9E9E6FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281551885381
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737961FCF55;
	Fri,  6 Dec 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t13ZB2n6"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67F421A0B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494803; cv=fail; b=PKvb6sFaP0GI5ik5T/GlaK9tG1gmZykjKoeugScQ5/XlN9b20OEYDANM3Gsz2/GVwIu98g00Hk58N6ATJXMRp7dkh5SDAMaBaAubYGnN3Mou6CtRvVODbkO14zfmltegvxdsU5XMBzrm67+ZdCHZW52JLfO+ADgSOCofI8Fr94s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494803; c=relaxed/simple;
	bh=l2gm7bkYKlISbrpdIvTFJB2YyE+Dcs+89i1wTK9UWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AZJk+qTC/z91EQyDHOoUFSSZoxzxhKl9xTWXLhsfD8+/6ffRRjb745V8hnwQ+w55HwyeXpwTWZv1p5Z9ECQsM3XhJ/JNr4c+XcVc1neugQmLiD+JiRBWs0EFodSZfD9H9uOIKr1uQrx14F/c035RIogM/yl2fJk20EfxhNYpnHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t13ZB2n6; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inztBfE66z5ffmSA4m3eFSP9XNbhBOzvU2Emb0wY05tjTv01zfL567M//ImwrGCu8xOEfXg7OBkTSXueQfbTOT97IPmuEvR3DJMs1KOe3jYRlJ2ns0731kCleJXvMmyUjWBpN+VIVFUK/jC1tb5xBBh6uV3aZDBvPborY4clJkoX/GmgfYmdzTQkQy2jj7zhCUvi7y36eVujbNqNxBJLD9fnBYVUgAdVkSbbhiwBrgO2/lrdAXLaHpuTOu1Dp/v+Rolhgd5H99OpXv5xaQ0X+iRMTe9GGfwiWVnS3qDFXzS7+w5SIqCsSR5sY2n1f7iJLk87p5Vx8YxvCHDEMVo+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH/1z1D1la75uGl+GAjbHsZC5L78NRLB7tYMdFUSxKA=;
 b=W6Hzyw5B5SMoWLfBA8ooVi/WTKJT0B2XivizcqKlS/Sefzjt7w6pZKFcZghzlevrhSDS7O48y0HLDN5gFCJ1K027r5Ax5zdYqn8kRyM+xx+U3demGaZlQ7/7T5R55G8VQf1EBKuBXQcE8HdVWuVxUzEqnf7dG1VJOzqrdkkQVcWCbgXcb+JuvMFl8MXBLcFn+TTUmzXWg2EkJA/E38j2OhjOUsStkbVRGLQxCr29caf9dZo2xsiJLf1h9PqFC2vZP5pGFScj0rsbyofLHJ7YRkAQRh7eKGQA+ILSeyR1NhYjr7RuQLnGghipbqFYTv2v2wRaZM6vGTi2nJl0FVoFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH/1z1D1la75uGl+GAjbHsZC5L78NRLB7tYMdFUSxKA=;
 b=t13ZB2n6QetsoCMBcTgBlaL2pF4pLHMt/Gzeggut/OGaHz7ijkMlRt7e6Bx5cepGkoKeXACc6YB9bLq70aaZ09XrfcavKpguL7YudVUmnvY62QuG+BUsyT2ppuS8M8i+Gv7foKvwuNBEGY8UBK3gjlxozvjJnfqkeEoXVolDnXVkpJ2uCuptq0f+9k3HEpLWH6TZBoMCRDGBPWOv5c2kgNTbCmiNeRSZ17bPR8B7q0sWI53Ix/iCXS7r/V4hCe4n1nL+0Axz0dji49PXEeNxbAjTGJf87w9FatIpjuFQwy2xWOs3j3vbuxY4qnsLiP74ZtaKWDDRR/go/ejoERGTEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Fri, 6 Dec 2024 14:19:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 14:19:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mm: use clear_user_(high)page() for arch with special user folio handling
Date: Fri,  6 Dec 2024 09:19:38 -0500
Message-ID: <20241206141938.2750393-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: fffdb609-1176-4c33-f70e-08dd16010e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FigxMTUc7R5W0HGY1m+xGzjSRThIRmDmub0SJca6woG8i/0IYSvjZpV5qsAX?=
 =?us-ascii?Q?6CmUfxZT7z/YoMom+XJi73/FvKY1t/vz+IwUzi6qVEquJwTRCC0t51Hq44Wu?=
 =?us-ascii?Q?xu9Hj7q+Kv55yp7IppYxRLrU2m/h89nUGgwe+7X7GjtA4WbAO5H6n3TLW9fz?=
 =?us-ascii?Q?ioYr8H7OWbUsi8O6Z+l5IQqQHIbqKIYvLVnqgXI+ipKaF4V7XU8abFJabCjG?=
 =?us-ascii?Q?nDbQf5ASbHpB8tkaFJ0yPAYIdtL2HygBycePIbUz2W2ZDYSlJgsxdMhyM8hn?=
 =?us-ascii?Q?XzpaVwHzOGuC8OhlSudtDUyvz57JqI7DEpa8eE3Sy9Nt5RjobPP90LhKb23f?=
 =?us-ascii?Q?x7xwHBNbFxXy7eGNxMe1UHQyovOEjECzF3ifSHsQ0HRr3pQYspK/0Gd4BI5I?=
 =?us-ascii?Q?iJNfH+muJmfkQAQtYJv/0Fud4XWTqTVh2DggiYmDcZkAotvbraQ2KtX1nA00?=
 =?us-ascii?Q?s717gJ+dSV/qZlZ0V7noOAWwf2Egzo8HoAGuYDLbAiX7BZQ6eMHNwEJns/FM?=
 =?us-ascii?Q?WUwY6YcaRNj704eTmNhYQxoHAnxsiWy4a7t8lfl/lx3QSrwMtmgQZeK5D9l7?=
 =?us-ascii?Q?rtljNgmIP8O1v73Bk3rAdmPTqCKzabuBTXDMNY70Q+hbAXOm2oPN9dOiEykf?=
 =?us-ascii?Q?RqNLfl3sXLp5BMT4SLW1N4NQOxOr+eP/76+uorfM7PVrZfAXf6aU6r7Lynka?=
 =?us-ascii?Q?c/wq/pXq9NFqDzHIJ6SOjbSTO9RujiD45erz8PJp2KX6UB2hrUU55SVKIRfE?=
 =?us-ascii?Q?ujO65lI0hDeF6iiw6w6BsZW8vkQARUCKSucdmCVV753QFku9/k8TKQPFInqA?=
 =?us-ascii?Q?zuQUZYMjd25LLfg6Fj1YpLETjXDm1joYln05VPF44H0E3FSgmiBVrohM0fqh?=
 =?us-ascii?Q?JdUrBoqlrD7uK4qCGPHnA0qMmM9ijyrxphCJOgIDOSGQh0e30KW3cUyk1KdV?=
 =?us-ascii?Q?cU7WSk7WaVZkgTROyiZ2nMWomQwaVhhNz7kNq2cwJURuRB6fi1aNmWWc8nmk?=
 =?us-ascii?Q?QPnXAkbryImjUJe4A4i2o76VfkIZXTF5fRbtlSg3ewTAGcygUFDYKOKxC5Qd?=
 =?us-ascii?Q?wkE5gN8KDVQpEWXVezRLPZLuUL+5K5fmvxrKTQHo/xLhocsmxbmWcYZBfXpA?=
 =?us-ascii?Q?qjib2MDgGy0od0YOUsXk2wd50p/GaI9/LflO/cLyyFBuoPGDu8dqa9eT/gGM?=
 =?us-ascii?Q?/k0Dz/oKmyf9/Gn6JKHG3rFGBPZ/gJp6XnIaHidesRAjkVeXdAnWRLoZ8h8d?=
 =?us-ascii?Q?ttb917ut8O58mA2ZY4baQaeRMKOh3tQG99+sLOLfuIjdQWPByHF3PWpRQ8TO?=
 =?us-ascii?Q?h82XacgFQbMV1EKyMVD5XGeWhECLhE8Pzn021sKzCnsCE67iJ6wAdES080KJ?=
 =?us-ascii?Q?3zm2XIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAgoiQN8kg7r4mn84jYKblgSEeU8hXR70nj+xFLDJ91OTITLdGZDihC25/i9?=
 =?us-ascii?Q?39JD+u0SaZKCNjXJ0ImO4kt984hi8rFSBGfJRbOHL4+tMSDPSSACP0JblhMy?=
 =?us-ascii?Q?ArJmMmCxqnyNCjGfcc7Qhk/3P3GdJ/LRw8ChlQbBDM+mf4iwENs5Tzxr+Wpa?=
 =?us-ascii?Q?P4JulpK2rckybhjdqYH225bcJH6GKPL9Uekx/tz/8bnlqRhWXoQPl8Y0Bp6U?=
 =?us-ascii?Q?8BHaeOj6HJzZP0NVZ6hs2w6WjyFVGij0BMQLqNcCQWL7khXXA4o10bkOgR9R?=
 =?us-ascii?Q?9typKeCkeuTuyMRVd0H6IptK8U1EC0OctxWyhj0pKKar+nBIMYgFJW3/Hckl?=
 =?us-ascii?Q?Qm4rbaHo/BvkGgiz5PsTFbp5BvOn1iNH1B7qNUcNyybwX9BTj3dXGYxmpLOo?=
 =?us-ascii?Q?h37lfUUtqKyk8ysqyNu5nbnkpdG49YrZTcLg27gYgGmAK8pH2BRYy5JdCYC1?=
 =?us-ascii?Q?Kjp9aZ7Wjz2viwcf+bnmab43KBeyRd127J5+veEeYWhS1o657v3hahjwgaNH?=
 =?us-ascii?Q?hTxWU07nyzhbMOAlAcUlLrhVAzoGvIypIhHXSeelkOJ/4Py9MMKIcZV1IHva?=
 =?us-ascii?Q?xvrh5YT8mzgSx/o/twwVBxfedHUmWo4rpFMaryAkXsYIWg4l+/6kXhzOlAuj?=
 =?us-ascii?Q?RmI0ozDoqhNpRYTmQ0v8XmKMXy+qw4v/1PFxgomqjNuqtYVbvq1W8GCXo7w7?=
 =?us-ascii?Q?D9NXVTujS04c4vRWDYvmO8ORGWK8mUYUu0yc1RsIf8BPMhG2uAwfFR6Rvzvn?=
 =?us-ascii?Q?ts+A+ICXmgGf3syQaev++s53jClP+y44wRnIBaA+P+u12bCpgtGqph5chWY6?=
 =?us-ascii?Q?VH5Kg8vTiOXmcUx1ohcHFT8RGmcG2EyGxTsNj4RJ2lkp9ZsRt7+aPDhwsFmp?=
 =?us-ascii?Q?X+kqbApeZ19mpS1yCp+Gngha+pA5JTK2xuZ6eC6F3xKAqAZT9T4njehbQDed?=
 =?us-ascii?Q?jxkCIxPBUyw3Q/NN6Vawnj7QeJV85wK3ddEfWkrA7aTdIn+QIFgd/OFhfnij?=
 =?us-ascii?Q?jtB3FlBW0bU8CNg5yZexLwKKAzEIDyIdHPbCAyBmHYrJ7shN7pZ51HS1mH/f?=
 =?us-ascii?Q?WHoyz9Ey7pLaMap5gHkMVW3vpxJYFUaQfUdWtmFW9dL3CoaMRNwFV4MT1jAg?=
 =?us-ascii?Q?GQ6y3hQdOsWD8lIKN0Ea74hAkLArEIWa8s8OkQBXwX4VtDTFItpIhzeYth8x?=
 =?us-ascii?Q?7fX5v96L7tFGJuNg015RCKTYEEeGmYVTNkDYSd25v4LJaS9aRxDTK602JX38?=
 =?us-ascii?Q?HiGxnQ+rQoE9bPWEFQO70ibcswItyURWdz5NrjedVV52PkTg3ox0OvkToXed?=
 =?us-ascii?Q?dZYhwTIp8b9KWCwp5TwNd+oTcc5wFF+Ich+or9MZwhCL1O3Gz6/BTTP2R70c?=
 =?us-ascii?Q?a4mKMTEQr2fsoC3ew+lqLh7P+6meWsJkZuUzAuy3AtF7y14vAd+bzyAfUQfA?=
 =?us-ascii?Q?XfpnMTmaU9Quq25F8/oUiNhJgyu029TavpKhiOpQAP8uCdP+7Df6F2P1wZht?=
 =?us-ascii?Q?D4Y7LT9gldXvRohyDOtUsZ7+VUX2gMuz9i2oTsf8CYDPk2155TeHAyITdd50?=
 =?us-ascii?Q?Yf8iiBqvVaTW0Urh4ZaR1Zfu2D0kz8M/1sgFQ7x4DOuFG3B2ks+xW4E1Bc21?=
 =?us-ascii?Q?R3DBHuZz6n2z6AdQO5eWdxeenJHVc1aKmZ6qk1pH1iYa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffdb609-1176-4c33-f70e-08dd16010e03
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 14:19:54.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES0W/0Au4pZlILiirpIlCWyGGhAAuOgjaSAANAYkbIWYVgu2erGlhGgjnNE+UY0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

For architectures setting ARCH_HAS_CPU_CACHE_ALIASING, which requires
flushing cache and arc, which sets folio->flags after clearing a user
folio, __GFP_ZERO, which uses only clear_page(), is not enough to zero
user folios and clear_user_(high)page() must be used. Otherwise, user data
will be corrupted.

Fix it by always clearing user folios with clear_user_(high)page() for
CONFIG_ARCH_HAS_CPU_CACHE_ALIASING || CONFIG_ARC. Rename alloc_zeroed()
to alloc_need_zeroing() and invert the logic to clarify its intend.

Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with init_on_alloc=1")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=HsfgKQeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/highmem.h |  8 +++++++-
 include/linux/mm.h      | 17 +++++++++++++++++
 mm/huge_memory.c        |  9 +++++----
 mm/internal.h           |  6 ------
 mm/memory.c             | 10 +++++-----
 5 files changed, 34 insertions(+), 16 deletions(-)

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
index c39c4945946c..6ac0308c4380 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4175,6 +4175,23 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
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
+	 * arc sets folio->flags, so always return false to make caller use
+	 * clear_user_page()/clear_user_highpage()
+	 */
+	return (IS_ENABLED(CONFIG_ARCH_HAS_CPU_CACHE_ALIASING) ||
+		IS_ENABLED(CONFIG_ARC)) ||
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


