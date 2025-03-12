Return-Path: <linux-kernel+bounces-557257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB4A5D5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AD018964FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0FF1DE4E5;
	Wed, 12 Mar 2025 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="afT6LRLA"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2084.outbound.protection.outlook.com [40.107.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C478C9C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760135; cv=fail; b=oA5TDs4u5CUQirsSjvaeJi/gEhShCBreZyeKqawdnr/rRcMpTN/h75c2p+dP+bocE1LbKHpY90nrb3fUjlL4vG7GB0C7TeR67Dm2NpPUHiZtFi00eBllHbkrDl1xNghHstcPnAV1H3JBVtfw88JwKmPDbO4XYjlv3jM33tbTZD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760135; c=relaxed/simple;
	bh=OdWMkd9HpRFTXwX3zn39Sg59Ky28qM+wdqWoYgAVJ/0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bZjK/EqL3/Okq8appng22boiBuDfLpOXRsNBw61jptBPli5Hw4y6Dws9yJZCkCwDr67pPAjUvoxTiMZCRXkYWu3MtXgIGYehhRWpaoB/MmJA/T3vdllKENutDtrjtwUx3YqIWIc4lJMM9XnxbDLCCkOrnR3P2StbIb0i2b0io3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=afT6LRLA; arc=fail smtp.client-ip=40.107.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imDQs1zRSZdayzDzY9CHOqEONFgIf7XRdcGvr8vCb6JDvzJYkajvZZXQjlTNhvvGZMC2bnk6qdAcc3Tczi9oUKyIfjNu6GElbe+MKdKs5jD8gRFNjzWKRZglw7/XKo6GblheTP686emE7isaQgRLhvq+SpE0NM5mfWXYi5DwmHxvmeF3kFzeSsROTzu1H33XSWG5tiRWsvSVQlAMih/jy6Adp+b4qZSVav5X34ZNyExNcK1N0bW8/jsUYSfopMDO2XU1m0jNOJUa9R3305bmgbYrIW4FqzPpxQ1FEjsw8jh7Hws6vpSA6wPnWWkCfMu5ChlXvUMyqqFEgRclV/s49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1Ta+4nadU/IzGq3CoVb8kLCJv+JpgVC9Mb0LBeeeqM=;
 b=QVyIDwrwGj6W3s9yxc/Ocly77vOK8PC2ztEZ0Ce8ymuabYzKOjK1pOrmFBwC+r/MQXC2CUo9MwMTILRIPcPnFQ+VIdMvuAquLeyOFMVUDFvA0aaXPlulFl+053Sj7MyX7yJMP9szfOPLr27Y63hhar9fbCi+KdGwRhsaKoc/msHh0okq/xPBMr8e5zVqcnccA4DF+AB3HyuitRLgadVp7aCOmjhC84yOclox10u41/Mhxbu5iVDTgBiU5ARep4zWEgNG7rFPXBd7J2FgBA3uJlmej0qa2CkMe95nbTEdGvmdQpgr5RlHbL97B7T1qD/3O61YHLNKxdPCxFIpjvkyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Ta+4nadU/IzGq3CoVb8kLCJv+JpgVC9Mb0LBeeeqM=;
 b=afT6LRLAo3cI34nRDGA8i1QYvQjD8yL6OncOUjxbQ4PcBKKU15WgGGtam9J0ykIrW4u94UDc0zL1HGJ9lqBp/3g5jRAr2nNL0lJTmjYIFDXqJV3G7e75rubxeuA3nAig37q+J67zRXLFbJsf6CaKsbnTQ5Lz+aWuU9vq/iJWZqbNR2GSBKip6uS/OG0YfWfJYYh926eAqQ/BsxebsE5yQf7ruPRagCi3Q3jIu/a9WGn6Y4XGlTyWBkv+CMYji2tRwvR8tYZBpRGkn6rUJj/x04Jf8+ADTWlhpSMhROWMkEec7wX1sKwPT4m44TLuwMkWwdY5VRDBXbbGLzk/2TyAkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SE1PPFA7A817EB8.apcprd06.prod.outlook.com (2603:1096:108:1::424) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:15:26 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:15:25 +0000
From: Huan Yang <link@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Christoph Hellwig <hch@lst.de>,
	Huan Yang <link@vivo.com>,
	Bingbu Cao <bingbu.cao@linux.intel.com>
Subject: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Date: Wed, 12 Mar 2025 14:15:12 +0800
Message-ID: <20250312061513.1126496-1-link@vivo.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:404:e2::13) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SE1PPFA7A817EB8:EE_
X-MS-Office365-Filtering-Correlation-Id: ce612d59-78b5-4616-4fc8-08dd612d4740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZUCbgrRu1CuUbZdLL7b0uRJGSFjVxGqqeloAxTDs6VjGHou654RWFoHqxZE?=
 =?us-ascii?Q?7Rvh1AQqthi6LGFU9cRTirwCKIPmjCVujqWbFzwWLLyDCTSF1V1h8Zl8proy?=
 =?us-ascii?Q?SPuxMYPhSFG1dKN7yKT4TqwxUJMMF0yufj6aMUPm+eTHQmHQJA5J+QF1W/Oe?=
 =?us-ascii?Q?AdE1GXV6gJET3RUJ39zl6Sl+Q2Vs9/uNIskgK2sr+uOYNn9LuBAED/jDC8Hz?=
 =?us-ascii?Q?ldEpPiXp7o3iKtkh2SN4EoKvJY2kjS1J87NujgX0S3KUPJ3r2WLUB14M9o1X?=
 =?us-ascii?Q?/iTjMy6W36wpCutac87LkNSita81WSDN4UrBHQd82+uRKBefLJjJItm95EVa?=
 =?us-ascii?Q?/juBOwtviSempEUqExINdtV07QlDbk7RmVxGrXBvSW/izN68Ty6jBvM2lfpp?=
 =?us-ascii?Q?U8WiooJiHcmFxZZ/XU/vVbj1xRqJGblcUi0OeTgtea3E0xjCHIK3ImbqBtPF?=
 =?us-ascii?Q?7gOsvJiLAhqyY8ARkB0vQAGNd6Jmi1dd5AR8EeH+eTwHtwKmzahEzCsak8YZ?=
 =?us-ascii?Q?+od70546ku7Cg+b8vokvpFnhu5catcqOE37e5u14hXvHAL/CeC4MCoxLPi6v?=
 =?us-ascii?Q?8fmjL2MlBWSJjo8haVu/jB1uBKL1/VjJu1WE05/x6N1kyM2LQQFqxy6BmaYl?=
 =?us-ascii?Q?hY/h+HKe3BBW+lxbUF043kmTc1akHe0HsSzT3I14wxMmPB4pIvu2tlBphLZi?=
 =?us-ascii?Q?5yZHlAGXnWxsMqrpSUSfeqBbYVxk5uvp7DK8v6+E0L/THI63zG5e/cPPqiSf?=
 =?us-ascii?Q?KtMHLjr5DlLyGgYXDJGrpMF5NyRR37zG8d3ozobZS6w2dmLKaf/kOMW94KDt?=
 =?us-ascii?Q?ps2vKkyNUid6OTmM4vJe0AB8CGl6GyIVWxc08+iODCwKD/ZyfW0U7/OhR/q9?=
 =?us-ascii?Q?ll9x3Iz98jf5brJaoFA6yLuug8Jxhz3aQdX7QuxKW7WW9gIW1ARprZGticFN?=
 =?us-ascii?Q?cljFdeRTc+AEKh6pH7WWX+6YmRrI+xtMGT3IwnGE1CjqpOOreJ7RA6tNSIUp?=
 =?us-ascii?Q?PxuhcnyiPPwBa4MOaKX7/9k9diCt6AzMwl5xL8jqcih9A24ndq0JEoYfSU+Z?=
 =?us-ascii?Q?y3b9B6nw1fWVTJ3bYi+ZKssiiWiCzm6U5R7y2FLFOnHvCtIkjclrPq/p9+i+?=
 =?us-ascii?Q?gqRB6DELUkgcjAiMbr6wke4uiN/4JTDYZO1mf9V9VTV0EEPFZQQjccUxcJtO?=
 =?us-ascii?Q?Ob753oeXaiVMHFiQrMNdgIt4whAWF7y+8j6Kp/ogJtZih/Is4LOOdh0tg7D0?=
 =?us-ascii?Q?tbaMCemuWjlHATXv0mBjUioxEXEWX/L+1DXS6GEKH79AL8b7xntFGtvEuYxR?=
 =?us-ascii?Q?OppF+bAdP1vbHMlzXKCI1aDoUW7ktnypd48yFdCMBJ3qoRufkGgTKV51v6V7?=
 =?us-ascii?Q?bh/n6i4zroSE/b1ShqoUKsquW+eJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PlqayNrlchJfS9jvZve8wERI/Lj2zj/h4eRbiozPjSRWHaXW7dtyTDvM6/IE?=
 =?us-ascii?Q?Mql71QGAC7hEgq2ORk+VcOMkDSPmgWPIX/uhQwBhJL7Wq9uiCu6CVpUVreDY?=
 =?us-ascii?Q?uz760N7O+Lk/wOzvdlzSm3KMGODVxN+/3QLGf7ZrpkPLR+54rFReXSsXXQOU?=
 =?us-ascii?Q?/DrCj20C17P66lNPqnOXxqYJr0erAJ5kxx56XBz7DBOD6zNDw34k0DuSd+Dp?=
 =?us-ascii?Q?XI6rfy5VR4uNYuKs4jqSDtY0pdSCQYNQMC+UymMvJuKFC9PbuGWcYsPpnZVa?=
 =?us-ascii?Q?k6KjcxGVHhKCyqmmsRWcr6sg1iWSkqkKlmOY8lL0UzmfogjOXNjK7IPe0QT1?=
 =?us-ascii?Q?1i88Mgm3bH6wr9XN7/COEDVelJX6VjXy2rJW2UOp0n2TqZxmqmeHpPi0+Xqr?=
 =?us-ascii?Q?rUI0/kXeB9mnzKMWWysuEWJZ5h8tn0MClKvkxVl9EbFjF5nfYdeTUz2kULvk?=
 =?us-ascii?Q?rETpGUvhxbWkhp7jPIYXJLt6U9JbjHEfezSapqU7DM4+hiYRHvRxM+jbyIIG?=
 =?us-ascii?Q?iqZ48PpRgrVd2ACVNtoAaKpsTNmEk2eZmSVel72uDmHDyFNPCrtTin4iI/tD?=
 =?us-ascii?Q?d5Ky6z0XzU9CWloumNze2WTOc5Wrg4fAjdWufIdt2+rQl4tpLTXoXV0nVP9S?=
 =?us-ascii?Q?MXaKvUwbgKioj6bIEyplXtujiFgaCQgwAle2cdFIxD47NYIcf1fh4x7FK0iS?=
 =?us-ascii?Q?8buQjRZ3k2wAJ5l1qcA3ni9VosUIHVdGcmfk/lqbR1LHFG2hSL5eADT16hR8?=
 =?us-ascii?Q?os+LqbBR42WOq+v36ZWIuCdqGwsGBS7GjOwQ+IhQOBRbe3sHvDz3wRH5Vurp?=
 =?us-ascii?Q?jUCTShemeeWC24p1sRyjWkfCU7Vc+1WYQAqmLIsVpbg6maCGFJ45oB9jpcOw?=
 =?us-ascii?Q?1NC37t+gE/ZMBbLtgOXnd4bE6olWUiLgHzCS5SIbju6Dlhxj3PLjhVGPSRkh?=
 =?us-ascii?Q?3gQjtKLZbQlhR/yFJr1ekV9Z9RhbW0Zi/tss/d5Wq8BZAl6s4//aDBDgnx4U?=
 =?us-ascii?Q?m7bgGKMB1TyVSX7RXQd6+Fq3oHKIs6BaCBiZ6OxaQrcv3entPkKGFxmbM+mo?=
 =?us-ascii?Q?DkxV+iYzu47HYAFwevuCU+jPn6TSGLMZSB3KHedEpLzPs6KbW4fsPimmgxwU?=
 =?us-ascii?Q?qlqQNx9bMoWNYIWHG6BZJ6jyMY1Jxj98/IRFGzjPbPalam+TvXnH/Ff6QyXG?=
 =?us-ascii?Q?WzTBN4og9LzO7ysouo06cOiZGYmIp+g79GNQEiUWtUfT+1tTH1Pfm8c6RNQ5?=
 =?us-ascii?Q?OSI2z+ER+tmxmIHvx307uSOb1npjtO9C+qEiZSnqi6s1KaSHoaPqQ0iQq5kF?=
 =?us-ascii?Q?8b61d55dW7KatX1r0xzgzerkxts56sJhkaRPClPoBkyG1hx0XLbKwW+eHCAH?=
 =?us-ascii?Q?6DF451WxxDrywcyr9ZzSpHLfxagd9M17oB6nj74G8Lh8uS9Hbk4p/Wp6RxKb?=
 =?us-ascii?Q?Y7YFl/1s17VBuPIxxiGH40HVgfVr641BYQzzXcj6n/fcjAJ0XoKeVK3JOjMB?=
 =?us-ascii?Q?09FnADhzTqw+7BW8XbWJfZ1zN1XTeHxFP/Ga5tb5bPDrGS6dr89Eiu2S0nLS?=
 =?us-ascii?Q?YSABopb83/0kDrwd6bsjLt50nookiKDljr/V2Xyw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce612d59-78b5-4616-4fc8-08dd612d4740
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 06:15:25.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIkZIhLXWvpsCxMdvm3HGw5ksGyxZO0uqZj8WCvzNxiVaT96uU1zecK4Adwf4TiFazVM0+tXUGXPxm+ssQcyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFA7A817EB8

When invoke vmap_pfns, it call vmap_pfn_apply to set pfn into pte.
It check pfn is valid, if true then warn and return.

This is a mischeck, actually we need set a valid pfn into pte, not an
invalid pfn.

This patch fix it.

Signed-off-by: Huan Yang <link@vivo.com>
Reported-by: Bingbu Cao <bingbu.cao@linux.intel.com>
Closes: https://lore.kernel.org/dri-devel/eb7e0137-3508-4287-98c4-816c5fd98e10@vivo.com/T/#mbda4f64a3532b32e061f4e8763bc8e307bea3ca8
Fixes: b3f78e749865 ("mm: vmalloc must set pte via arch code")

---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 044af7088359..ebadb8ceeba7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3488,7 +3488,7 @@ static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
 	unsigned long pfn = data->pfns[data->idx];
 	pte_t ptent;
 
-	if (WARN_ON_ONCE(pfn_valid(pfn)))
+	if (WARN_ON_ONCE(!pfn_valid(pfn)))
 		return -EINVAL;
 
 	ptent = pte_mkspecial(pfn_pte(pfn, data->prot));
-- 
2.39.0


