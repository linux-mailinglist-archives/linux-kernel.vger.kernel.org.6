Return-Path: <linux-kernel+bounces-299144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25995D0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612071C2262F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0D188A03;
	Fri, 23 Aug 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BnHfmEsl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279A188904
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425342; cv=fail; b=RicCIe3kpcecq+NvWDry8Xq447CA+squl5eXzP8WJxkyJElXYcHiAKK0NJ8w67K/cmKijv0pNYCISwf3bCTAXUHB66xod9JygmCs7yBBBRIDZ7KK+ZmuKZqicTz7tYQZ9rxxBhr/Mfe+nhMRIWa2EJ2C3OzK9NFgUhzBKp+9HQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425342; c=relaxed/simple;
	bh=ERoEXoRbls9hVR7TtWpD05Tgt+B2iQe74x3uvxplmNw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nN043nAKh4OEUi2v/veFbZs/OY2e4r5S4UKJoGiGnq1d23JTEYs/egODtSDhEGwla/mcPMB6uOrKOW4kv8KzqEp48kPm/Dmp6aKELM0ZBRechjHN4kmdE1bQR0n4l+Xaa1wulPHlZ2isdovR+fVXGqQlJAChcyoNs8cpmvacD88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BnHfmEsl; arc=fail smtp.client-ip=40.107.215.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqs5ovMAK44EK2tbepQhHrOM0G91iSHIQWyvuSh8UQxBB65JMqiGTAHVGgWgrbn3H/uEkwRV+8hc6YUTiJKtzwgBXl80PazaFzOAHL1iuXu2EVZ2t0bF59VdgYNPfHncq+Xm6MH1eagItwOfEoCzoUla2S2q0NDeoWoBUfXT+WBujEe6chY758g+cD1dS6l9hgzp1j6g+9VJ1bVrNqiFNFIFFvvYQPCdUh0wJrPC+3gbk/iJ3XzbAfNiS8J57yxZoP4mCNlCldbYf8vBdDJ6rOQxw7EHnwCxrmYt1h8CGdI1Sb7pMcmdd0v2eSJkI0NGKfauiTAqBbtUaZHMeMrWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNEg2GC57LLqhzMbirfeDKLwUKK/mTP5oA0snNrE9N8=;
 b=u7cQYH3XiVKEGGAjWGXCWN7fZjSJwXSV2NkwLld9FQZCq6jKkIP093BxuiPz3DS+A43NzXqMsXWhyXI504WhdpNpk09IxAaYun4e2lRlew6PrSX7Sx68hlelFfyDQTnNM5JglaGWrqWyj1wdDrBURZkmecFs+san8hwFZIOMDsNZaGRe/A2rPcJgZM9yRCwlyKSuBLoAIndKNCAqyscppYRfhdrk/MaXk91eg5mhJ8QWRauNZ1IUtssNvvV/HP3sbC30D52triEmdKZnLi6FXQUx4QwEFyRRH9dJ3gw4y6kcClGaJPXqG/nVKcL4GeK/C/lXgFlO2BLPOuLeeVmFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNEg2GC57LLqhzMbirfeDKLwUKK/mTP5oA0snNrE9N8=;
 b=BnHfmEslLYHhPDxim93VaUuqZxxIjBiGPo5VXhF16PQY7Pbk1iQQH0wZM0T4meknL4k7x+Gtyu4uYPizLwHCVIVD3TsalgC9Co/zJiuppiRI7+XIYk3OOhIgaelReg2GU/p8kuJkXTxzsDqrzwzv2S/lvk1NS4J4TYpE/u9JBkt3DXnj57dOZa8n5PSmf/zaT7TA3/+i4lWZkkTXfyE14N9308RGStysSaL1ljoB/kMw9JsWTybsSnEL/9OYlNHhu0K9uwcefFUsctcVR531eJcf4CXGlQurptsKyHH3waQctKLDqkzkCDGkhxdQYLQN+m5z1TRvhVCgfZKNhNoKaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by OSQPR06MB7249.apcprd06.prod.outlook.com (2603:1096:604:291::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Fri, 23 Aug
 2024 15:02:15 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 15:02:15 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oe-lkp@lists.linux.dev,
	lkp@intel.com
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
Date: Fri, 23 Aug 2024 23:02:06 +0800
Message-ID: <20240823150206.565-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|OSQPR06MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f642d9-2836-4aaa-c341-08dcc3849303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PO0zVZ8fJq5IqpHg3cmrr8qzCGKizJ9twffAr7uWu/IJ3hkBF73wV1yASv9n?=
 =?us-ascii?Q?Je9ktPKE7+yP/OueNH5cWC2I5/goFr/J3Xhu6j6Ht7PimEWjF47GWjzUIsfF?=
 =?us-ascii?Q?e0DTB2CqE0vKeeE8LH8G396tW+mu9QWxCnoTd3VE8PGQX20s2tA86u6irB5J?=
 =?us-ascii?Q?Cw0mGcYBIdeJS7LNwZoY2sy9AMVANGyzgl3qSESzi5VVPe7elPn7nKjg/EB2?=
 =?us-ascii?Q?druq32JCmFU/CqLYi9O0rbedqEC45/Su+CcMJvgQII5wW3hho0DYX51DpBzi?=
 =?us-ascii?Q?kRz16IoEsQRw0r76iWJMxvgq8wvDGlxO+zscN3vE0tB1ToiS7l3I1JyfjJ2X?=
 =?us-ascii?Q?itcXUl7OAv0Tw3sVxwUXhDf8qAaS1MdwkqEpxj9Wvwz/6XLnPn8NT9bvfxFc?=
 =?us-ascii?Q?wSR9lzKnzirZf5d+iUDFChx4I6JaXf7Im2SkW6AN4JAoUEQ8EGGbvQnuYKmU?=
 =?us-ascii?Q?otDCEGDXqo/8ERBJpL60HjCJOOIgNFAwo7yuSOmDLowHoTIgxBDkiOufv/+7?=
 =?us-ascii?Q?mdBVMutuB9MeMC81sHfGCuDhdcrXVb1iznGSrvWiSYkk60BnsaaaThtOZThu?=
 =?us-ascii?Q?+ZkebI7r8e+wQhGzD9W0xqFKdxB13sYFz1c4akJ/Zsmx2DWkgjFrHTns5zb2?=
 =?us-ascii?Q?+fmFyyPoxbpvAkN5tUt9pmpzAkrCGddgqtakNfOcKPyor5t29qbwSBfJxiFj?=
 =?us-ascii?Q?hAa+Nv+LsqWedg+/C5pGofUU/nfHVx4uzxDo1Z2emNEYjxm6zpggkw/d6Amb?=
 =?us-ascii?Q?gNZwYRDoAkTNf2RKODrRWeX8BGfz7PuxDR0sqz6w/7GL60tOTzgLzONTSsfB?=
 =?us-ascii?Q?IkoaZTzCN+uFUnl0hFEIjIPitsB6z7NNvNGXV8qxzmzAmZ5znxIFAQy1qvJU?=
 =?us-ascii?Q?PVdJpAlskN9lr7ig90Nkxe6OR5oe8Euu85rYiO3wyrVv40Ul7azmgEz8PFRk?=
 =?us-ascii?Q?YYYLAaPAmAK4ouZCJejxx0vG6ZNr5dOxRcGNABfm6btD41tYdQWU+8o7Z4PF?=
 =?us-ascii?Q?5MUGOjk5vrLLCRWvp5XOoJlIGHVNmvfpv85Czecgw2/zWAlk/gxyt9SPU/ye?=
 =?us-ascii?Q?s6pmn6hqRc85rCvkUdsF2VrVKUP0XXt28guYvy5ZDxu4wnNae3TtnX8d7NsB?=
 =?us-ascii?Q?1zh2gkrfWP20x6iNAMJrqgDsKBcL9DhebM8fA4szOlfe1j19yKjObb7uISwr?=
 =?us-ascii?Q?NkHPsWx0pHa6N2hJf9UXdSgYiXMyIvKDCJT+2CP+RRKYa8KU+wyfcxvouNLu?=
 =?us-ascii?Q?aVWe154xjPthcpScMkfdD8uQrRC1ar9KDJo0f+8dsb9bTGbxWfQNVZ/JbNDB?=
 =?us-ascii?Q?ZWyxTto/r/M7ivEAAmG/YSx3PZ/F8LRQdoCr0DsaW4CNLO1ObOarwxLAYyZz?=
 =?us-ascii?Q?XId5QbE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQRhXZet/gNRoVAGyRJBl7zS5xOH9NpSDgyZHk+Tr/ZSpkSLHcF7FRuITg1v?=
 =?us-ascii?Q?VPS81Ypu42MS3IPil/R0SbQjktb4mdAGzGMC8xAkR4KdVJZJDLBkvPtYptZ3?=
 =?us-ascii?Q?T7vX6AQJNyiGJ96GxWp7XoUVcH01O79pkkffW3uCF9KVelbHzQv1OuoYkTXc?=
 =?us-ascii?Q?AipZ1uL9SIxPiwAmzpCWg1GQA8Szb82s9iQMfQG6G/nCbpCUouQapY/iPq9T?=
 =?us-ascii?Q?fuT8PSMpP7d6o8GHjBXYZF5ofqXTZGpKzJ82aa4p3O/zIjIOquQcuVHJ8jhN?=
 =?us-ascii?Q?7hPhRAsXDj2pXlZixaHR+w/k3V/o/6izf8BuBEy+U2A42rkaWDqjcNAOqF3h?=
 =?us-ascii?Q?8xIa4TZPezj9n4aq5oQ0Be5XbKxp6U9aN+mFRCbVYTAqK2474oDT5a7H1kjC?=
 =?us-ascii?Q?0tAb/TKSf+r3vL9OBstSIbCI/utRv8IM+mY8gPl4pJYna/fGz+H3sJmXmkWJ?=
 =?us-ascii?Q?gh/msBaylhayUbfQsNiviocgr+cdXv3gAqX7oxQIj0XV1ZMQNxl3oCMUWU34?=
 =?us-ascii?Q?/N8rQOLNNVzD9XDaWIKfPj7JA0vmoOsqItpcc8ZEaoEcwHF4ITCITjJJiOLQ?=
 =?us-ascii?Q?CMcG46DCWRI2cKfOtUgfBapIc2VQ47nqDSHsQkHnn2Y/Z+wR5jiCOJluZto5?=
 =?us-ascii?Q?w0NEvULVffDNafLLwZ0Sc2D8WgPTtzndg7UM9x2Kifs8drAFpsUeNqgfIl8O?=
 =?us-ascii?Q?ruvYdQQIbOoPiytHBTnC0tgTuHxOlc6DfRk59K3CTj7qS/0Z2GzVNIPntKjR?=
 =?us-ascii?Q?9mlZ2j7myT04fliINUfc3p2W7MFAcnm73F6NONo4dEiHnigpkaic7ry6hRK8?=
 =?us-ascii?Q?/NB+n3N6SFUsNL4Q18Fe2I8PuZgnkuvTD60O/Qbqc0ZgspOuFqwUoGJwxII5?=
 =?us-ascii?Q?oR3nwlfhoE0PWfETjccMqPgd3fDQHBkh5wuoWmtzuIOeyJfNjeciLSIQyFtm?=
 =?us-ascii?Q?LpmUg5M8Zw4GsDEMvq+TdFudPE+p4ecuSgfPYrtG58nkrNOPOPWJsM0DWivO?=
 =?us-ascii?Q?2QXiTJLzc4b/qOuOTdh8kAWBgyh5E0NVuDiFhQHhdLkJ2Un8S61W0EVBktoW?=
 =?us-ascii?Q?U3Dxgzhu6PtGZFoR4El9XKHwji5Kk1y6KVXlBtJeBrAnTi+JIST+BG+qP0/p?=
 =?us-ascii?Q?OE3xNeReb/3PNAae/Lf3POIiLl68Nv2kgmX4nThcVp1D1NpTKm7F2UT0hHpQ?=
 =?us-ascii?Q?lmFsTMhQQI9PVfmIpfRmcIqFvQLkFdBlUxGOYEquQ4Y+ERcsOeqzVuc6sIwp?=
 =?us-ascii?Q?xCkcB/PjDB2eRwjhk1BBdNWW6CTZxcgYsvxnz3Kygm5Fuv/R+ticTyaZYmsJ?=
 =?us-ascii?Q?ANVJoFNO5cb5F18G9k8rlEfM9f2VjanJlDSrcTniRU1AWJZm2XjqALib6Cw3?=
 =?us-ascii?Q?pIbi7mEiRkslFdNQtl2T2ZJ9q3fRAD3HdOiz7a4m4u5+xnaXNp0tBnZ0QxXi?=
 =?us-ascii?Q?RW3rXu7CT2yTkgQsthFNJXUR/AxW+n22RhRNGhn2l2Z2jx2eVa1MLzOACs9I?=
 =?us-ascii?Q?c5Z+NO59dHW3wPLG/WtsIOU3A3vLhjOVDM7Q76oYnbCv9pLhl5QIh47fof4M?=
 =?us-ascii?Q?5nyez399tmD8bPwpldL/+JjdYTW8YOP6dFvZkQuo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f642d9-2836-4aaa-c341-08dcc3849303
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 15:02:15.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0zpP2yOZ9gcVRCufYVLBqq1HIKJpydzwWxWXISiNUaE4uht0EiW64wn9BJ8boP8GCNR/oZV2/VI5wZFvabkiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7249

After CoWed by do_wp_page, the vma established a new mapping relationship
with the CoWed folio instead of the non-CoWed folio. However, regarding
the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
not same, the avc binding relationship between them will no longer be
needed, so it is issue for the avc binding relationship still existing
between them.

This patch will remove the avc binding relationship between vma and the
non-CoWed folio's anon_vma, which each has their own independent
anon_vma. It can also alleviates rmap overhead simultaneously.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

-v2:
 * Solve the kernel test robot noticed "WARNING"
   Reported-by: kernel test robot <oliver.sang@intel.com>
   Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
 * Update comments to more accurately describe this patch.

-v1:
 https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
 
 include/linux/rmap.h |  1 +
 mm/memory.c          |  8 +++++++
 mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 91b5935e8485..8607d28a3146
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/memory.c b/mm/memory.c
index 93c0c25433d0..4c89cb1cb73e
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * old page will be flushed before it can be reused.
 			 */
 			folio_remove_rmap_pte(old_folio, vmf->page, vma);
+
+			/*
+			 * If the new_folio's anon_vma is different from the
+			 * old_folio's anon_vma, the avc binding relationship
+			 * between vma and the old_folio's anon_vma is removed,
+			 * avoiding rmap redundant overhead.
+			 */
+			folio_remove_anon_avc(old_folio, vma);
 		}
 
 		/* Free the old page.. */
diff --git a/mm/rmap.c b/mm/rmap.c
index 1103a536e474..56fc16fcf2a9
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_remove_anon_avc - remove the avc binding relationship between
+ * folio and vma with different anon_vmas.
+ * @folio:	The folio with anon_vma to remove the binded avc from
+ * @vma:	The vm area to remove the binded avc with folio's anon_vma
+ *
+ * The caller is currently used for CoWed scene.
+ */
+void folio_remove_anon_avc(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = folio_anon_vma(folio);
+	pgoff_t pgoff_start, pgoff_end;
+	struct anon_vma_chain *avc;
+
+	/*
+	 * Ensure that the vma's anon_vma and the folio's
+	 * anon_vma exist and are not same.
+	 */
+	if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
+	    anon_vma == vma->anon_vma)
+		return;
+
+	pgoff_start = folio_pgoff(folio);
+	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
+
+	if (!anon_vma_trylock_write(anon_vma))
+		return;
+
+	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
+			pgoff_start, pgoff_end) {
+		/*
+		 * Find the avc associated with vma from the folio's
+		 * anon_vma and remove it.
+		 */
+		if (avc->vma == vma) {
+			anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
+			/*
+			 * When removing the avc with anon_vma that is
+			 * different from the parent anon_vma from parent
+			 * anon_vma->rb_root, the parent num_children
+			 * count value is needed to reduce one.
+			 */
+			anon_vma->num_children--;
+
+			list_del(&avc->same_vma);
+			anon_vma_chain_free(avc);
+			break;
+		}
+	}
+	anon_vma_unlock_write(anon_vma);
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
-- 
2.39.0


