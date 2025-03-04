Return-Path: <linux-kernel+bounces-545678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70801A4F00E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9F188BCAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BA27815A;
	Tue,  4 Mar 2025 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="l95yYa9U"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D0277021
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126854; cv=fail; b=mC5tYwLeIXc1s9W8TnkqvmgP/jBVWlA9Mml9rfVGc3UwEbhT8VGyYO8nAlNIxIhWAlt/tuKTs/2kR4xh0Tp83iCtXsSzacyvoq4bQZdymc875QViTKzSpFlXblWK0HtxxANUyG/occ24nSaUn2dmmhivqEqfbmgvxEJG1pvgMZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126854; c=relaxed/simple;
	bh=MwBNOoMi49SwVBX1lc9vJQWTgUM+jk5LJSMfM3iHis4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nUwSZgjUWkKBIotWZ9EqRK/k4Nq6pTEsRpRv2ICR4FqesTmdcQ1DC54HrsHNM0FSrFaXd3UDJ2KHZ+1M9DHYJcUHAj73ZwDEUQF1C9JrHj4i+WzcMEojXQ+M0f1efvIOz8BgOImHkhVuPCjflL+1KvSY81YV8cPmhjsDi+LhyNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=l95yYa9U; arc=fail smtp.client-ip=52.101.85.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctmcsDz28ZWlzGRlPG96/CbChrHM1mmH9vKyvMLxESysPWp5Zof2rbngbx81HEDEH0CwoTSCD+T3SLUsZkpw/eLtoo9fz5aJ/sUGv03URB89Patnaladj/iCtHc64Mxo7/Qd42Qb/3Od0mWeIAeqjALi9dAiR/elDsrizDI5B1R4oe/+Ya1qBpEkFKaZQwNba0aP7HsguTJDugZGxGCbSDnbwinkjMoIMo+oW5tC+Wa6r+DavohzLGmOeRb7ps1CVGpnHG00+y0D+NfRAC8BOMYoaAOYEJj6EATxtGZePmEpAZIVi4ydqpI0zm5zvs7W49AQqtc+KhH1SagCOkm82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc8S2OTbZME42pyY8V87xNGR1wOTsn5d4wbfYh2jm/s=;
 b=YLxBFJsJVcBCWonl06ZSNwIr7pCuNBey+JcFZMAeYTEtI+afJ1Zgp767YTcANKiuUr014W7tliMtyZ8m99UNYw7r3Egh9vyR1RzXLesYIj2Bk5xASRw/KQnjRcS+iTYTzLgQiWheActcxpZ+6AHybn/kmdLKQKX33KhbrbebBU0tCltQ88y//A6svmLBeqqtABFNeKvKEtIw1p/UNqVYFAmHfJ9HiUQ2zpkfqJLHuyO+wImCb2AeE5BbY0fhA6y/ZJeZWub0JNT8i8H3kuA5RYsEWwq9hx8Tvz0F0bj5OLCwR2lW6/USdAUv9X3EkyjW2rVhAUuXVYgNGOA5RlyxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc8S2OTbZME42pyY8V87xNGR1wOTsn5d4wbfYh2jm/s=;
 b=l95yYa9UaEDL7PgaSRZE6SzqrXnVcNVdFBfek0Y2GcSPLHw7mTP6NBB0bcNeywTyqiafUUeN+M4osf8TOJY3o0JUqPATfCypKjVpyUemmbr1BykbjwgD1Z9vG68lwJRcdN0ZsK4IM19973OnJCudEsR9iTpbJKthSqhMwBZnpm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB7931.prod.exchangelabs.com (2603:10b6:510:275::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.26; Tue, 4 Mar 2025 22:20:48 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 22:20:48 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	Miko.Lenczewski@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH 3/6] arm64: mm: make __create_pgd_mapping() and helpers non-void
Date: Tue,  4 Mar 2025 14:19:28 -0800
Message-ID: <20250304222018.615808-4-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304222018.615808-1-yang@os.amperecomputing.com>
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ca7119-25e7-400d-f34e-08dd5b6ad0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WmpGZg1mjm2zsnrtHGa1zMKDmaPY8t489ZRZT0AUaVcylGUMneQRI+uYuEq5?=
 =?us-ascii?Q?Ch/rLFwiblQxK0IQnudleXP5h9drxL9s9OKUlaoiIHOl+J2AGqhBEm5yBAY5?=
 =?us-ascii?Q?rwgheAe4wY5zp7W7uxhOQE+hP748C1RFTY83Q6q9tA/NkrICvi0J/CqSkpAh?=
 =?us-ascii?Q?KLtQ/OmvTMDSncHJG7J3J2n3Va8wl+VELdYEpqB4q7FECFtP8bTmQO7rrLiz?=
 =?us-ascii?Q?X6NCupaAaFiA2s+dNJIKdkBrzKPR2zVcX012p9I+XtLfA4cFX9NJmNu8crPf?=
 =?us-ascii?Q?EN0GrZwmYoJtp2GKFL8nSByJZGBTH2jT14W/F/bXEkdPvwugm9dh1RwHDQad?=
 =?us-ascii?Q?Akq5k7eHkuGZnv+6oxMSu55clpr0w2kiNs8pbpr3fudnG0a484UQYDjOhIhR?=
 =?us-ascii?Q?Y8a+HN4vd4Sy0QUXE/TVrK5NHK7eEaqRrtCXBwrbqN6E6L6taTL/Oh5uzyDh?=
 =?us-ascii?Q?lf/1cCWlw8Dz9D8k6A2ZIhf9E3XiRsgrMDVwuRoTjXGIPrqitfmuunwR79iR?=
 =?us-ascii?Q?OeGcfc2VSXIhZKWBBOWWlrXGHpDjngE/+b3+Q1IpmbXD52SagXKAmnKF1zkN?=
 =?us-ascii?Q?Py4jXHAJspc0oYyNbRxq4eO2JzvvTlgw8sLJ/gDD9pxapQXYp6SsIbQeYT4e?=
 =?us-ascii?Q?krBKIuySkTFc/04HLS6GG9ptwT3+3AwNvPLTvvKQps1KXDOYDhovZ2QDe1na?=
 =?us-ascii?Q?4Url6cWdI/6c+7hRfZwiM3ggwatI0HDqlVVRYt9XYQZB6Z8IFCYGjCNeyKBg?=
 =?us-ascii?Q?RM5T6XeHbW9qKfp6Qpu6d+PAEBCc7GyMzXF2yuUq8/TgiYW0fdLyGn17Quut?=
 =?us-ascii?Q?IyGL3DfG5ZiD6c+fwH0iKNkSbcs92F+K9IoJlbbBz3vT/RKcuxd28XgCzXYO?=
 =?us-ascii?Q?7H6fKEjVPw2aETVvGvtF5POgJEZ+atCyz2k8LzRc3vwNyLTiS6jMnXtCSb5j?=
 =?us-ascii?Q?tIJZntcl2u2v7qBJ0m4tILP1e2a0xLWCEK5zSH1Z5hel0qit2dAtvNwp/AbX?=
 =?us-ascii?Q?fHLcYHqfbIcFWMAlX1INeFxc/32sWwqi/N2cgIFhn54dYwy0nIhNBOfG7h2F?=
 =?us-ascii?Q?XaNOlNzzgKip8COmYTahyATCDshqMWpl3kfLX6BQjh4PMnHInSqjkuXQrPnx?=
 =?us-ascii?Q?9SeOzhs3as0wXeLF519vk2deH80fLwJO8lJwhRrP6ZWXHdE6gKtWy7WHeNBm?=
 =?us-ascii?Q?ZcYuIIGNf+TZ4u9GT64Gv0vAffPCEB8yz/MYtNZXD8U1ofUkBJzSh8yUyc1z?=
 =?us-ascii?Q?vYKbiqSjh301rqYKVw2wVmaiaQ9vsrZdX0fFnvrz3ol1LudiqsMd0d6auSuh?=
 =?us-ascii?Q?zggMh370m0wez00gOHjhHTQmf6pJ4DNQbpRZmxPyMaBJMiYLiEXTBX81LsqM?=
 =?us-ascii?Q?0F2DBZRh13JfAbuBdG16vTnnbY84sBygN3OOkP5o/GW2lvtnJ3YPbEk2iUM6?=
 =?us-ascii?Q?QM66r/RQabo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qgFq6QhRBOQ6J8oeEpGXvr17hwGbtmGHd9Mo2VtoWXQCTwCose8yfu5dPhPP?=
 =?us-ascii?Q?7w+H9a3FRFVOebkwe/XCYNySLhOATkEyl63HjWK/gFIsrMQ1fpfDg03Vd5cT?=
 =?us-ascii?Q?g8Vro333AxSQOERswn+QUmORVWEWBTllgSlES8MrAjWr67idMcGAy1kxqRuE?=
 =?us-ascii?Q?0p+12CYScxrgUvHhVCztOJszFsWjWv6uNh6uK9swBYcx+vfOFrRRo4LS3C9y?=
 =?us-ascii?Q?KILtS0UNCOL/8URjtc6riPkq5UUSUv0lMwXnzfrSQeBmF3/3WI89DxB9tMfE?=
 =?us-ascii?Q?uaZ8O7APffqR45utWDuNFzBR+bV78ypo4PpNmhQDundAQMmon6AwOH5XVxCy?=
 =?us-ascii?Q?33y5zEOo2L3QL8kpw2ua3hJy6JlVLU9PMOS5qta5nOFt423ezdYBtHrd6gxh?=
 =?us-ascii?Q?GtUva/dSFVhD+vtfZPWMOQw2T0gjI14sgcAZHaeAMJ1BEs6pWHVYHjaPEj9d?=
 =?us-ascii?Q?ZVf8xM/UG69xKZZZ9izBocQlEwBrbb+4RLqxmPKIl7E0xy4fx13tskOcvW7F?=
 =?us-ascii?Q?MsNtVoeHroDC0XeouDQF8koGMak09XNLyQZ9lsHTGNWjKwLZbd1P8RjMnraY?=
 =?us-ascii?Q?KQaAW7dbSifDMrGQKe7JX3+FW8dEh4ZEn6/iHeH+MPyiofhjrvebhoBh48I5?=
 =?us-ascii?Q?oIAJ5hFwg8tuNVOjws8NyYflMj06vQSLUJ4nuXapWxOa/smJdjroPIHd0Yw0?=
 =?us-ascii?Q?WZSBrpE7XgQHthqWUpSdaqMCXZsqSUqFksPQ3kP3715Jq+o42kzdnkXHH98j?=
 =?us-ascii?Q?gmmkyZPMJ7+0QOLWIGa9tFxqq5CA0pxnu+4mtsZteH0nQFoPWqDqW/2u/+Id?=
 =?us-ascii?Q?lzPk5m0dc4m7njWL9wLj1VWJdvbRLzEOJ7wVpZR9A1hPObkz8GPuQx6MqJua?=
 =?us-ascii?Q?6yaTyPlAAMgoF7xwBz5fiSLIhnDg0EEenmRjNaq1HppsCnNhrXUqgHvnwGFz?=
 =?us-ascii?Q?KLt/V/Jz5KLr99bEj4aijuVyy+k9eiPbxl58wqeBseyFkI1HxIJzwstSAUfd?=
 =?us-ascii?Q?xVO9Zigvtpm+NPRCL30Pl7lOSSp978UkIK4RPAgau76TqFlcMt758ChalX+Y?=
 =?us-ascii?Q?4C1EumGKrypzq65wh+uF9iOpH/jE/wOtOvzQe0t8vNfCA4tNEZjSxwU+4N3N?=
 =?us-ascii?Q?WOjqUy/ZhKEjtB4yFBpvVXVOmCMCd4EErAGUd7ibn7kN6IyQ3cVGuouNInYc?=
 =?us-ascii?Q?NGYdBEwkHTdU1VPW6dq1FfgJ2Y0UKrOrRkweJd9z2hnf6VjgW1/L1Rb+mhov?=
 =?us-ascii?Q?g9l6TseByEh8fYwhUAIEVxVz2WCb2gh6edsVvH93W3Nd0yy+D68PGe+x9gcZ?=
 =?us-ascii?Q?RKe2hxOc8pc2WVtnCV94/GFOaMWkCijC30HnWeJtFh/2qfIWvAjwKowZazKN?=
 =?us-ascii?Q?JuYW1cO4IYE1VMvIG9fZXgnalYqTsNV7rcp5HGXr0HhgIqQpQ93MqLnXQQfh?=
 =?us-ascii?Q?zAwv/wd2uBiz5+2DUrTooMIvpz/juagGfevKnqaNb690rliq5r+3TN1ZHpEG?=
 =?us-ascii?Q?m31/LpzoiOisaM/Z8cefcbj4dwPHZZ3fR6dJHd0zCKAGd5gTiAfUECCa0WGV?=
 =?us-ascii?Q?0/Oi9ZQkzcm8lBAfDb+X1b0peuPuzw3v3sPi9gSyOOh2NIM2nHryScueVPtC?=
 =?us-ascii?Q?Au6zt/MQ5LqSc2ni0yaIEkE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ca7119-25e7-400d-f34e-08dd5b6ad0bd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 22:20:48.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC7AaB4426Opvqc210fk/En2zA+SU+jw5I90ZbzMdiFSN71dOIOt6b3J9FAEGuj34O/67gt+2zprkHjszE2W5kzlSguvJzURS3E8CRyi0w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7931

The later patch will enhance __create_pgd_mapping() and related helpers
to split kernel linear mapping, it requires have return value.  So make
__create_pgd_mapping() and helpers non-void functions.

And move the BUG_ON() out of page table alloc helper since failing
splitting kernel linear mapping is not fatal and can be handled by the
callers in the later patch.  Have BUG_ON() after
__create_pgd_mapping_locked() returns to keep the current callers behavior
intact.

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/mm/mmu.c | 127 ++++++++++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b4df5bc5b1b8..dccf0877285b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -189,11 +189,11 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
 }
 
-static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
-				unsigned long end, phys_addr_t phys,
-				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(int),
-				int flags)
+static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
+			       unsigned long end, phys_addr_t phys,
+			       pgprot_t prot,
+			       phys_addr_t (*pgtable_alloc)(int),
+			       int flags)
 {
 	unsigned long next;
 	pmd_t pmd = READ_ONCE(*pmdp);
@@ -208,6 +208,8 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 			pmdval |= PMD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pte_phys = pgtable_alloc(PAGE_SHIFT);
+		if (!pte_phys)
+			return -ENOMEM;
 		ptep = pte_set_fixmap(pte_phys);
 		init_clear_pgtable(ptep);
 		ptep += pte_index(addr);
@@ -239,13 +241,16 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	 * walker.
 	 */
 	pte_clear_fixmap();
+
+	return 0;
 }
 
-static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
-		     phys_addr_t phys, pgprot_t prot,
-		     phys_addr_t (*pgtable_alloc)(int), int flags)
+static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
+		    phys_addr_t phys, pgprot_t prot,
+		    phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
+	int ret = 0;
 
 	do {
 		pmd_t old_pmd = READ_ONCE(*pmdp);
@@ -264,22 +269,27 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			BUG_ON(!pgattr_change_is_safe(pmd_val(old_pmd),
 						      READ_ONCE(pmd_val(*pmdp))));
 		} else {
-			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
+			ret = alloc_init_cont_pte(pmdp, addr, next, phys, prot,
 					    pgtable_alloc, flags);
+			if (ret)
+				break;
 
 			BUG_ON(pmd_val(old_pmd) != 0 &&
 			       pmd_val(old_pmd) != READ_ONCE(pmd_val(*pmdp)));
 		}
 		phys += next - addr;
 	} while (pmdp++, addr = next, addr != end);
+
+	return ret;
 }
 
-static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
-				unsigned long end, phys_addr_t phys,
-				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(int), int flags)
+static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
+			       unsigned long end, phys_addr_t phys,
+			       pgprot_t prot,
+			       phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
+	int ret = 0;
 	pud_t pud = READ_ONCE(*pudp);
 	pmd_t *pmdp;
 
@@ -295,6 +305,8 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 			pudval |= PUD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pmd_phys = pgtable_alloc(PMD_SHIFT);
+		if (!pmd_phys)
+			return -ENOMEM;
 		pmdp = pmd_set_fixmap(pmd_phys);
 		init_clear_pgtable(pmdp);
 		pmdp += pmd_index(addr);
@@ -314,21 +326,26 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 		    (flags & NO_CONT_MAPPINGS) == 0)
 			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
 
-		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
+		ret = init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
+		if (ret)
+			break;
 
 		pmdp += pmd_index(next) - pmd_index(addr);
 		phys += next - addr;
 	} while (addr = next, addr != end);
 
 	pmd_clear_fixmap();
+
+	return ret;
 }
 
-static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
-			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(int),
-			   int flags)
+static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
+			  phys_addr_t phys, pgprot_t prot,
+			  phys_addr_t (*pgtable_alloc)(int),
+			  int flags)
 {
 	unsigned long next;
+	int ret = 0;
 	p4d_t p4d = READ_ONCE(*p4dp);
 	pud_t *pudp;
 
@@ -340,6 +357,8 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 			p4dval |= P4D_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pud_phys = pgtable_alloc(PUD_SHIFT);
+		if (!pud_phys)
+			return -ENOMEM;
 		pudp = pud_set_fixmap(pud_phys);
 		init_clear_pgtable(pudp);
 		pudp += pud_index(addr);
@@ -369,8 +388,10 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
 						      READ_ONCE(pud_val(*pudp))));
 		} else {
-			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
+			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
 					    pgtable_alloc, flags);
+			if (ret)
+				break;
 
 			BUG_ON(pud_val(old_pud) != 0 &&
 			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
@@ -379,14 +400,17 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 	} while (pudp++, addr = next, addr != end);
 
 	pud_clear_fixmap();
+
+	return ret;
 }
 
-static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
-			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(int),
-			   int flags)
+static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
+			  phys_addr_t phys, pgprot_t prot,
+			  phys_addr_t (*pgtable_alloc)(int),
+			  int flags)
 {
 	unsigned long next;
+	int ret = 0;
 	pgd_t pgd = READ_ONCE(*pgdp);
 	p4d_t *p4dp;
 
@@ -398,6 +422,8 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			pgdval |= PGD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		p4d_phys = pgtable_alloc(P4D_SHIFT);
+		if (!p4d_phys)
+			return -ENOMEM;
 		p4dp = p4d_set_fixmap(p4d_phys);
 		init_clear_pgtable(p4dp);
 		p4dp += p4d_index(addr);
@@ -412,8 +438,10 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 
 		next = p4d_addr_end(addr, end);
 
-		alloc_init_pud(p4dp, addr, next, phys, prot,
+		ret = alloc_init_pud(p4dp, addr, next, phys, prot,
 			       pgtable_alloc, flags);
+		if (ret)
+			break;
 
 		BUG_ON(p4d_val(old_p4d) != 0 &&
 		       p4d_val(old_p4d) != READ_ONCE(p4d_val(*p4dp)));
@@ -422,23 +450,26 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	} while (p4dp++, addr = next, addr != end);
 
 	p4d_clear_fixmap();
+
+	return ret;
 }
 
-static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
-					unsigned long virt, phys_addr_t size,
-					pgprot_t prot,
-					phys_addr_t (*pgtable_alloc)(int),
-					int flags)
+static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
+				       unsigned long virt, phys_addr_t size,
+				       pgprot_t prot,
+				       phys_addr_t (*pgtable_alloc)(int),
+				       int flags)
 {
 	unsigned long addr, end, next;
 	pgd_t *pgdp = pgd_offset_pgd(pgdir, virt);
+	int ret = 0;
 
 	/*
 	 * If the virtual and physical address don't have the same offset
 	 * within a page, we cannot map the region as the caller expects.
 	 */
 	if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
-		return;
+		return -EINVAL;
 
 	phys &= PAGE_MASK;
 	addr = virt & PAGE_MASK;
@@ -446,29 +477,38 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
+		ret = alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
 			       flags);
+		if (ret)
+			break;
 		phys += next - addr;
 	} while (pgdp++, addr = next, addr != end);
+
+	return ret;
 }
 
-static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
-				 unsigned long virt, phys_addr_t size,
-				 pgprot_t prot,
-				 phys_addr_t (*pgtable_alloc)(int),
-				 int flags)
+static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
+				unsigned long virt, phys_addr_t size,
+				pgprot_t prot,
+				phys_addr_t (*pgtable_alloc)(int),
+				int flags)
 {
+	int ret;
+
 	mutex_lock(&fixmap_lock);
-	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
+	ret = __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
 				    pgtable_alloc, flags);
+	BUG_ON(ret);
 	mutex_unlock(&fixmap_lock);
+
+	return ret;
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 extern __alias(__create_pgd_mapping_locked)
-void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
-			     phys_addr_t size, pgprot_t prot,
-			     phys_addr_t (*pgtable_alloc)(int), int flags);
+int create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
+			    phys_addr_t size, pgprot_t prot,
+			    phys_addr_t (*pgtable_alloc)(int), int flags);
 #endif
 
 static phys_addr_t __pgd_pgtable_alloc(int shift)
@@ -476,13 +516,17 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
 	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
 	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);
 
-	BUG_ON(!ptr);
+	if (!ptr)
+		return 0;
+
 	return __pa(ptr);
 }
 
 static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	phys_addr_t pa = __pgd_pgtable_alloc(shift);
+	if (!pa)
+		goto out;
 	struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
 
 	/*
@@ -498,6 +542,7 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 	else if (shift == PMD_SHIFT)
 		BUG_ON(!pagetable_pmd_ctor(ptdesc));
 
+out:
 	return pa;
 }
 
-- 
2.47.1


