Return-Path: <linux-kernel+bounces-262565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CDB93C8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568EE1F22914
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FF4204E;
	Thu, 25 Jul 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TbJENut9"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2050.outbound.protection.outlook.com [40.92.23.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9F1C6BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721935744; cv=fail; b=cN4ZJvvjYYNsztCJy9OztfzUq359NXe+NljoTgxE9+hGHHz6n34BDlSpMOA795p5119vyxA1aLGR6b2qHy0MemNbamVUNTI+0iXCyHlpc/sn80QBQBU5iBZnk8C1mZ7KoGjTbC18oz+rga3D0jpGBAeDaf5ChCdGG1pd+u7LKA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721935744; c=relaxed/simple;
	bh=jYjUgKNqbxfSDW4PGEGNC0Ffp6E6HknzDs58NeKot4E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ToU9f3X+kW/iGM4GG0vkMR+rTtgQbekLvHdi8fCTBCe3+Q2Qabmpx+oVmCXOGIluW60ib2p5wcfwTWAlW9SSdIeG5Pzu+vCHAtdKR65jCVGz2e6c2nN1JRmFqh58t284IScjLWsxa2/udQ2DYcBwHDy701AF6oKrlFa9ONGU4iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TbJENut9; arc=fail smtp.client-ip=40.92.23.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZ9nQSVXOskvfuf+E/eOvaf5sF0jcwNJ5W+1CH2+wIHFDbWNm3KzmGObPkCNFaHljCNJmXl4yfK/5c6D7v3M36tRajAcaF2VzH7YSovhunke4aJahowl8U4w5sdP/VZerDCfLaxmyLaxa8+MwgknWlrK8iamGFIvZ83NgvDZ28lEFXGoniqPn9AfrMvUX6OOV3MXDg3k/mNEH8/dtr1E/mScbvzbG6Ri2cRvlNupwOe2JcnbpiGESrRPFRFsoftp0VGdpzZSVie/FZre/eqfcIPmJxDlilKLvpvadudIlukCwNSf384aFDkta+c/J3SWRtwiB8aTyWq3NRitBcJi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJY2avQfHK37SRGxbD+pqod82QyYhpSTQfULkPvIIUQ=;
 b=PEwQsDY8oa/EdBff1/2HMLXcuz07P31NAESqrsiEGqQgkxl3I+9oPPuNxaS7stqzpXjCjnFLflREf6XljXoQV9ScV43uI0aQbT8uPatopeAlHfDlNKa/+MvQOf9SU+XkCHhcvg6XuH4ZvFIVFb5K1eUaxxgCah9Q3nA0/xgeJT/ncnC60zIIQw8iM63jWc3ljiEBOqLaUqKb0RGhfVHXL0lKoMZbEWci+0097sR2kowLh1JYhJGXPWE39dFmkH3TPy0a9J5/c1FMcfQ6OSqqYAZ/jITHDu6dsJ2/qXEjeJZLXfFW0eFxYDzfpeuXUA4kkMdmzpa7/7fI1jwXLhH1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJY2avQfHK37SRGxbD+pqod82QyYhpSTQfULkPvIIUQ=;
 b=TbJENut9vnHtN4OVXxK22jn9xm/QnwXganEAremLuBF1AtaZCLMc9yDRdvWp4eKG7Ob2JEAH8ZvrBXmq4aD8Htanv+KbTKN1DMIujuOgcXEqNDyMAuNX5ZoHlqcPNUqcHXwE1VmtFxxSvyeJx9oATQaJmeBBOn0x4CzsYnckBx8YTJ9kccVvWIvFLetmKJWf30TJGPBy+6jyhbmkUGnuzeLabm4Gn2aKWNsyCknJmSBH9IYQyzIECnR3P6SxN3/kBJXee8Xvo47BluqWW2cjkEDaJIJ/szidcOAhDiWv6Co71fOuGA9zQ/Ps3ZYspbIl9Fv47PXFIspwh1EhHQSl+w==
Received: from PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2fc::11)
 by DM4P223MB0543.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:a7::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Thu, 25 Jul 2024 19:29:00 +0000
Received: from PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM
 ([fe80::9c9e:3eec:db55:6a5]) by PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM
 ([fe80::9c9e:3eec:db55:6a5%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 19:29:00 +0000
From: Steven Davis <goldside000@outlook.com>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH] mm: Capitalize letters for readability
Date: Thu, 25 Jul 2024 15:28:29 -0400
Message-ID:
 <PH7P223MB1039C0F7DAC6FFB32F61DE48F7AB2@PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nJfdNTdby/ytfaKLLMRkFISA+cm8Si5Y]
X-ClientProxiedBy: BN9PR03CA0706.namprd03.prod.outlook.com
 (2603:10b6:408:ef::21) To PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2fc::11)
X-Microsoft-Original-Message-ID:
 <20240725192829.1677-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7P223MB1039:EE_|DM4P223MB0543:EE_
X-MS-Office365-Filtering-Correlation-Id: bf680a1d-c5ae-494c-ec19-08dcace00749
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599006|461199028|19110799003|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	9DWtEdMAarlLcnwgZYiGCaHdPbxv2m+ydq3zTgTMYwu8z+/EY20iICmyx5Zkn4qMf+LP2eEHw8cfxaplYpn8fhkXvSXkNOganGdPqE+Dmf4fozDabtWzT7i1vRM2MQ4jT8Se8ApM4K0uwwLYxqELgpTbQcQ2V0EeNEv9yszGNYMPkVfyc2JPYf6+eOwgOURW3mfN36ue8qx5x6EjKAUxr5byg2lw7wZCpFn0NVnjsS1wDZZqbOwat+QtOSKL7UwCJCYRq87KksxggNcjxjFNTAj01fSVDnWMEoMots8tuSfwG3snWYOjK6yDrOnPQUPQy/HSdWK0ash3XCEPlq1jHTzaTLWtDGAfzjVF6/YlVaRmRcZKMpbZe5MKB7Nmo4laJLeYrr2g3+Hh5it7y/MHr09aUKOFuczCSTrBkGVa9O4XFPP8wzgHLynWj0NatG8YP4Aj0+frV2Zevky6ABxOSdq/2q48Qtl0ToIjopnL6LR/3CFmzQ1eDTgs2RGyIcVtdjs2dSMky+6TsQtXeS6+oyHzipelkLP/taNztVgoj5wsFKWmy3kl5YmmET6SAFpBqjdNq2TsuNsl40lgulIspv/LD3hcoazPb3dr3lc9MMsCkoDoFyLo1RBC7+ADkEsCGX11zdXOMiOqFQUgj0Dexo4c7FA8fHNcWduAX/hLK+ac7AWoLVWg03cXdVBb/LLeTT1ZD0QAtM2xgjry55qzfQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VzIm3QY7z3ukH/TtlvMRpoLRTWf4c4qDN7i6C8SnF8R1P5U9aqBUfNrF/o/T?=
 =?us-ascii?Q?tWpF1YTXq7aGMcda3+HRGMZU/ZXiTd+s0UUAyS4NzuGrkr1wQ6uA9TuQfPZM?=
 =?us-ascii?Q?eIbBEiJMBhJfMhp7VztOfgr1oPl9VSXLLoA+QzTOrjLWBxIDi5zM/I8P712m?=
 =?us-ascii?Q?PaoVhs+LM6OB23AUyD3kcJ7VU2wn7ylFOf1Sz4WBzv9N+8UH7Slz97e9VRhN?=
 =?us-ascii?Q?wgJCQpASMT1THEeHB03UXavuH/6OSiEr50cVpogGSb41IRHIEHdw5UBwgnpT?=
 =?us-ascii?Q?ZLVbbEHQA1GE+nWynjMcDDgk/QilW2nu9BHaajyGVPRXsXvjE/DVphwlzUin?=
 =?us-ascii?Q?0MSESi5MryO7g/F0bG2MMTHyfDDaU6a7B0Ac25HnOyTgLfTP1Uo5QBzqhnPE?=
 =?us-ascii?Q?qy7GE2e1L4FeVYmD8jXHBOLNJNUsvmcjAmn/9p3fjLdntIRHzx+v6RXM42ac?=
 =?us-ascii?Q?4luojgMJT9tXO76LHb7L+MVz2cdjQRnJ3JbOLomaZxfGdCUnLw4MekmGnY0O?=
 =?us-ascii?Q?b9sTRlPe0beq05Mf1RpDzjchSEP/Yil2ZHpumF6bYu71a+14aJm7cZW79esm?=
 =?us-ascii?Q?90RqpS1ShmxfbJnHOOV0lI4rVa14nnELDZDyvQ7lxn051BLsS2TzZGFVrjZq?=
 =?us-ascii?Q?84iPgBja++MKiHxpOKqTtRRBhFPbTlhkJJhP+ttrZE/SWzj0FxRcJPonBFuP?=
 =?us-ascii?Q?iTra79K6fy2QEgYqeNj+arcg5+IT+p5teC9yveuxuULAKXBCzHJUMQ0zPBfc?=
 =?us-ascii?Q?dq7S2qAUVoLpgUp9+TplJ8M86jmgIe87ciL++hYV7MApnGzFLXTWvquk5Xt1?=
 =?us-ascii?Q?ERN/mTyRuEkxbF1lsqEXzgaRND2W8YkgEsduyGnxCig5fGssh4DNZX8E2DUe?=
 =?us-ascii?Q?O19BYcenAYgIihBxVWHfuAfRtvz0xU17F1mptbJ+dBRWrnLgHos5ZXQTXY0E?=
 =?us-ascii?Q?4R3RG5F1CLxml/rSuuG2x7uhBdLY1Vl6Yz9HstBmtIEWHN8lW6NLgUCX6JOF?=
 =?us-ascii?Q?SnMdIdhtmjXmFsz+f+iIvYpIkJFKvEAQQMw9MDlsqvGl4eaZR1tSw+ZiSf9h?=
 =?us-ascii?Q?NakdZxL+ApGeL7QNBw98fpYhsLRYMfoQ6m2VVKvIyvmxEDAh4O3BHEqcefsF?=
 =?us-ascii?Q?YNZBhU0+51MuVfAfwW2pDuvRKdeqzip1HpppqZTZm+my9vhDRcjFKcPoSxLy?=
 =?us-ascii?Q?fRsDc9aVtHPs+aN7FoFp4i7jxYnsZbdfO/XR3crU5sZIq4vHtQxoLwpj98U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf680a1d-c5ae-494c-ec19-08dcace00749
X-MS-Exchange-CrossTenant-AuthSource: PH7P223MB1039.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 19:28:59.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4P223MB0543

This patch capitalizes the first letters of error and
debug messages to enhance readability. This is important
for adhering to the style of other error messages in the
kernel, and making it easier and clearer to read the 
messages upon the (likely dark) terminal.
 
Signed-off-by: Steven Davis <goldside000@outlook.com>
---
 mm/execmem.c | 2 +-
 mm/vmalloc.c | 2 +-
 mm/zpool.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 0c4b36bc6d10..ce4334087b1b 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -40,7 +40,7 @@ static void *__execmem_alloc(struct execmem_range *range, size_t size)
 	}
 
 	if (!p) {
-		pr_warn_ratelimited("execmem: unable to allocate memory\n");
+		pr_warn_ratelimited("execmem: Unable to allocate memory\n");
 		return NULL;
 	}
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..131b05aef593 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -108,7 +108,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		if (!pte_none(ptep_get(pte))) {
 			if (pfn_valid(pfn)) {
 				page = pfn_to_page(pfn);
-				dump_page(page, "remapping already mapped page");
+				dump_page(page, "Remapping already mapped page");
 			}
 			BUG();
 		}
diff --git a/mm/zpool.c b/mm/zpool.c
index b9fda1fa857d..3c766a1d065b 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -198,7 +198,7 @@ struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp)
  */
 void zpool_destroy_pool(struct zpool *zpool)
 {
-	pr_debug("destroying pool type %s\n", zpool->driver->type);
+	pr_debug("Destroying pool type %s\n", zpool->driver->type);
 
 	zpool->driver->destroy(zpool->pool);
 	zpool_put_driver(zpool->driver);
-- 
2.45.2


