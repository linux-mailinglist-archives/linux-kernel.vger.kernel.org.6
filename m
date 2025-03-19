Return-Path: <linux-kernel+bounces-568668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8602AA69927
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9038A0948
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACF1212FBD;
	Wed, 19 Mar 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="REd7jNs8"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD92135AD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412205; cv=fail; b=ry+tCLriuH5193vQndYT+6eVCEJCkVLFOtwPFaP8w4i9MxRg3IFgh/26I4lVySevCRNFFvUTpSd/Ac5iApL3lIJMnlLkTDXb4kt0QjLNDZxj8wcbRBCYzLpb1SQCXRVYvSA+vA6CnTI7QYM1RAqbXjybHeiWyjrVd50rt6iZ19A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412205; c=relaxed/simple;
	bh=09FRraZaxIQjrsfRmvAb1GVaTFpjltkNmF4E/S6+9Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYSqM/polXkFZss0Gai+2Lf4sWzNTXsWGTAuysxqcTRHUzcwL/eNRcYUStpgz7WoQhncyDQhdPAXYxwcIHO+kL80b3G/wPm7YQUV7v7t1G8z2Kn6qzgAOAB2Ds3KnWcnLG2X/B3VKSmHk2VMYUCqU5m9E0VQ+1oy24XGFYLFkB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=REd7jNs8; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBJqvH37che25yt2cYzIZGRPrKVkMD1fXZuQl8GsY04kK97ha0rgH0mSuGDAl7/RllrcuHawYedsbP/sMQfZYdqywovqqNYfRdqcSq3AThpLRuCoiKC/Y3+vDchjIJ1mOkBBjNdaVd8gHDObb5M26peo+xv4q2ffX2kkMG90E0WWuNnOMCkctxIIFYiiszeoZLjSNhehJRCyF6indTtWUbmKfgPUFPJ6o3d5yGPTMgFKyJcmM8e2qN6nYTA9950O6wAkf6iSirIOcmK3+wcvvZKSfowNl+lvaEN0ZSvjvJNFK0fEMOH7GHpSrdCzkm92u8lOOo1o9Vzyx81n1eNAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZyoWMY8GPkC6c+QiCnwrogSvPL8DBaC1BvGNUgqyIg=;
 b=DZ7ssxCoLNeb3/tiZQ3uD8g/PGjEbrOQZWrelCnLeGp4CI0d43aQNazRwJ1jLsZ3qScSEon7wKS+rq7+yymV0m55QJlfEbzrl0cJj7itt9lP+tBbIZew9Iw4Erb8EszE01ZY3mDbJGKmy7Shlg4lOtMu1oK+DH5v0ZjEmR88DCuRalsowOlyL2OMirxdcIyF37HHJ8WL7Hl48T9zqRUYkNY8vdEAEUWVSAaZyfHxR8LBiNS9rbtGrMmJrcJP094TAjqTCHbbgNSWJpa2dGHybZKLCR7+IdVXcybya1bx3wGhGx0fmLad/1RCQopRv6bIoTKsijx26fO76tVfTlwyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZyoWMY8GPkC6c+QiCnwrogSvPL8DBaC1BvGNUgqyIg=;
 b=REd7jNs8gHGP2mKaPvk8TYELAzgTvhFxbCAHUnwRWxPXWfx+JDYGIa4+Bh4ugqs6e6YvIl7esWQML58gL7fVcu7vvc9P42DIhc8IQ/2q0NDNwbPii5Xk01shvIvoXzM5NWjKSDvTfSmpOSGCeFZcHOpR/O6DHGLl2PgWl4TuItg=
Received: from CYXPR02CA0026.namprd02.prod.outlook.com (2603:10b6:930:cc::9)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:23:18 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::c) by CYXPR02CA0026.outlook.office365.com
 (2603:10b6:930:cc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Wed,
 19 Mar 2025 19:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:23:18 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:23:09 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <baolin.wang@linux.alibaba.com>,
	<bharata@amd.com>, <david@redhat.com>, <gregory.price@memverge.com>,
	<honggyu.kim@sk.com>, <jane.chu@oracle.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mel.gorman@gmail.com>,
	<Michael.Day@amd.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>,
	<wangkefeng.wang@huawei.com>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <anannara@amd.com>, <wei.huang2@amd.com>,
	<Jonathan.Cameron@huawei.com>, <hyeonggon.yoo@sk.com>, <byungchul@sk.com>
Subject: [PATCH RFC V2 1/9] mm/migrate: factor out code in move_to_new_folio() and migrate_folio_move()
Date: Wed, 19 Mar 2025 19:22:04 +0000
Message-ID: <20250319192211.10092-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192211.10092-1-shivankg@amd.com>
References: <20250319192211.10092-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd7a6a9-10d7-4d68-f27a-08dd671b8106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dt0tl2cnY7vDBfpDdyeL2xwnBUyZT4Je/1hE2mS3nxOgahtC1f64Myv/XqTU?=
 =?us-ascii?Q?txL5ZhxVQrSdvu6i+KD2rsVI0FSrGiorB78wJocLI9i6P2r7RlhPPVOfibUu?=
 =?us-ascii?Q?ftRbYAkXiVQqx1XD0u5tjuR/P5SsZnDjLWVou7tPo+/Mn9luVlSDbzMcvp3F?=
 =?us-ascii?Q?ag2x+Lc2H3CV3WXSfDwmYHEmPEC8T/qSpQnjh638rxvBMLENyW+jEryQIJ7j?=
 =?us-ascii?Q?cwOawQ0BJafk9p8TpzbxH2iwEgxNSshf1sN6KC8xBU9zUmJLIbf3H8UlZOr0?=
 =?us-ascii?Q?E4rU2AV+xy6LFhbKTpsqQTNqv2XARZ3iQMOZ44TfXFOfICS+XYei7zW4Eras?=
 =?us-ascii?Q?gwNCwKZOkLH8EpZ9egV4tMQ4s3+ME8Dg2j/zDz4bmhqbu0xjaAJkyh7FVfhm?=
 =?us-ascii?Q?7RlZAiaZI3aFP1eUwzuaW/3PliAPS0bswbZ0pQrYaJobsn460B9kH1bdnfFX?=
 =?us-ascii?Q?Pfr+SfewDL0UdOwpcPtz86Imu8EtZljDsZlU6070Mwq0YY/z6hUqtB7oh764?=
 =?us-ascii?Q?Yc2x3FDSnYacerxHDL7XbH5bmA6b8Xdjqjzjuru8jkPGZb4uSoLfumYaGobM?=
 =?us-ascii?Q?xo4QbFuEse3CA5LJ1O6KB/k8sWdxiA1JXb2ZCgr0sTG6r4sYCpMhsu6O7FsJ?=
 =?us-ascii?Q?DEXRGoGfQL7EiaUIXX65y3J+p7JwFPGdoZZCwgfca0sLG8Wul8YBb5S5vJYv?=
 =?us-ascii?Q?UD28gTk6KHCQqUffQx/NhFVsT13swKG0FxHjaDdngXtdVbjyc392z7dgZoIH?=
 =?us-ascii?Q?09GzL6tuTzcFMliyXaPYBE5bENRT8dCkk2oI0NbaYG/qh+EFcZfwi85a1GWv?=
 =?us-ascii?Q?Ah4PsftL5ybVEtoH0m/Fw0/1G+jJTIB8gVSGGSih7hs1N6Zd/rpSDhNgb7jR?=
 =?us-ascii?Q?Fodyasd8vpYkdW11s9rnHi0K2x/QusLg//xGecTOB4qKBoXWK1kIfuQBWoxz?=
 =?us-ascii?Q?k1nQtuEvMv1HbX5UGmi705NLw39MNhrz7kMgzIqnkR/QJvyTc3kiL7oiEDXh?=
 =?us-ascii?Q?tONcITOyIg4G/Y08iyL4GOire3cw9MHvEp3RfLKyh1av3MQU1G60uQO/xj75?=
 =?us-ascii?Q?Rv4/W9jP8izvxZuVPRxJ1/WFwm64DIJ6dqeL5iPd05hvXzAaF6hWSUj4jkoy?=
 =?us-ascii?Q?+SmRtlItJ/hQZAs49hWULIcxkgUowB5cFBr2S6w7nW2NBpMJ4owGVmWGGbu/?=
 =?us-ascii?Q?d6iM291EGnRwvyjQSeTE6z3wsEXiI7st6/bP5QpS9AIX5M3y9XSQ35NPG6uL?=
 =?us-ascii?Q?YkUYjzRTIYQcU+Kw5Gkj764R6ddZKnTDzMObCHgpHS0gvKhvmHIh00xCtlB3?=
 =?us-ascii?Q?5owofGBAoIXoydI+WWXESkY5qg5aTmJ1cHIL3HKl0FRJhKsuousg35JwYNSA?=
 =?us-ascii?Q?QDBAyZistjtvZYTyH9jJGoFVEYTqmLLiNDwg6JEDBP/aOJ9bP9Mf6U2p4YO7?=
 =?us-ascii?Q?hX9BApM9s1DCV9elrOrhrWmKgh5AstjAnRNSO6r6x2DGjJiK/JSM3JXSG+yO?=
 =?us-ascii?Q?IoVxfdqY0Y17Ql8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:23:18.1410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd7a6a9-10d7-4d68-f27a-08dd671b8106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993

From: Zi Yan <ziy@nvidia.com>

No function change is intended. The factored out code will be reused in
an upcoming batched folio move function.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/migrate.c | 101 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 36 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c8..ce7ddc56e878 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1014,18 +1014,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
 	return migrate_folio(mapping, dst, src, mode);
 }
 
-/*
- * Move a page to a newly allocated page
- * The page is locked and all ptes have been successfully removed.
- *
- * The new page will have replaced the old page if this function
- * is successful.
- *
- * Return value:
- *   < 0 - error code
- *  MIGRATEPAGE_SUCCESS - success
- */
-static int move_to_new_folio(struct folio *dst, struct folio *src,
+static int _move_to_new_folio_prep(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
 {
 	int rc = -EAGAIN;
@@ -1072,7 +1061,13 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
 				!folio_test_isolated(src));
 	}
+out:
+	return rc;
+}
 
+static void _move_to_new_folio_finalize(struct folio *dst, struct folio *src,
+				int rc)
+{
 	/*
 	 * When successful, old pagecache src->mapping must be cleared before
 	 * src is freed; but stats require that PageAnon be left as PageAnon.
@@ -1099,7 +1094,29 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 		if (likely(!folio_is_zone_device(dst)))
 			flush_dcache_folio(dst);
 	}
-out:
+}
+
+
+/*
+ * Move a page to a newly allocated page
+ * The page is locked and all ptes have been successfully removed.
+ *
+ * The new page will have replaced the old page if this function
+ * is successful.
+ *
+ * Return value:
+ *   < 0 - error code
+ *  MIGRATEPAGE_SUCCESS - success
+ */
+static int move_to_new_folio(struct folio *dst, struct folio *src,
+				enum migrate_mode mode)
+{
+	int rc;
+
+	rc = _move_to_new_folio_prep(dst, src, mode);
+
+	_move_to_new_folio_finalize(dst, src, rc);
+
 	return rc;
 }
 
@@ -1341,29 +1358,9 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	return rc;
 }
 
-/* Migrate the folio to the newly allocated folio in dst. */
-static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
-			      struct folio *src, struct folio *dst,
-			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
+static void _migrate_folio_move_finalize1(struct folio *src, struct folio *dst,
+					  int old_page_state)
 {
-	int rc;
-	int old_page_state = 0;
-	struct anon_vma *anon_vma = NULL;
-	bool is_lru = !__folio_test_movable(src);
-	struct list_head *prev;
-
-	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
-	prev = dst->lru.prev;
-	list_del(&dst->lru);
-
-	rc = move_to_new_folio(dst, src, mode);
-	if (rc)
-		goto out;
-
-	if (unlikely(!is_lru))
-		goto out_unlock_both;
-
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
 	 * turns out to be an mlocked page, remove_migration_ptes() will
@@ -1379,8 +1376,12 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 
 	if (old_page_state & PAGE_WAS_MAPPED)
 		remove_migration_ptes(src, dst, 0);
+}
 
-out_unlock_both:
+static void _migrate_folio_move_finalize2(struct folio *src, struct folio *dst,
+					  enum migrate_reason reason,
+					  struct anon_vma *anon_vma)
+{
 	folio_unlock(dst);
 	set_page_owner_migrate_reason(&dst->page, reason);
 	/*
@@ -1400,6 +1401,34 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
 	migrate_folio_done(src, reason);
+}
+
+/* Migrate the folio to the newly allocated folio in dst. */
+static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
+			      struct folio *src, struct folio *dst,
+			      enum migrate_mode mode, enum migrate_reason reason,
+			      struct list_head *ret)
+{
+	int rc;
+	int old_page_state = 0;
+	struct anon_vma *anon_vma = NULL;
+	bool is_lru = !__folio_test_movable(src);
+	struct list_head *prev;
+
+	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
+	prev = dst->lru.prev;
+	list_del(&dst->lru);
+
+	rc = move_to_new_folio(dst, src, mode);
+	if (rc)
+		goto out;
+
+	if (unlikely(!is_lru))
+		goto out_unlock_both;
+
+	_migrate_folio_move_finalize1(src, dst, old_page_state);
+out_unlock_both:
+	_migrate_folio_move_finalize2(src, dst, reason, anon_vma);
 
 	return rc;
 out:
-- 
2.34.1


