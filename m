Return-Path: <linux-kernel+bounces-403949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0469C3D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBAF282AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02DE189B8C;
	Mon, 11 Nov 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="F9FNnlmX"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011062.outbound.protection.outlook.com [52.101.129.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F6189B83
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324147; cv=fail; b=DIupZKKu+Z2VABFaAhTD11CfDsDFH2lTognOdlqtLZxSU+Ffrua1rAWBJJsZetA/oj0CXyF8JUVPv4Ol7+m4CfaIO4OV33XDCeUK4CN9vWRgtR7Ki0yBcXxrjZ6kgO8i+9cXNQ0BukFRayBPBda+3JhWyb7p+8ePaXwHowyb4eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324147; c=relaxed/simple;
	bh=LbQcLWJg9BgyNuvWxYTVPaIStQl7an8L23TS1iiS8jc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FDgvrn2wRcHFBbIAm+YB23265TIG6VaL/n1cmnSNxfCEY4N/yDsXTh6pRmt1KkiyOFZ+n2D2eM2QmWyUCSOo2/EofGibUWvU6ALQQnxTC8gMlAEWuevCqfNWcs7NNedFIU6HpeFvdJD87T9zdHsj9KxjUhd5lkRYuqy+Ctd3WTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=F9FNnlmX; arc=fail smtp.client-ip=52.101.129.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvTaBHZEIKd/TpOgxzjsJfQbE36ZwjrWfO8SlFPDFtQNmLoKM3P9bTSdWpBcwqVBfVjqah/KWp6W01W4DOV6rUvU23m+UY8KgcOPcwuj1jWwx/WDP/QcOh6ugtTGHUSmfMhEFF5/5tsyAcfhAGrKThiWA6uMBnmzGlXB+fIwGuRCx16qXQ7gNg/p1qTbeohRRiSAEehdec+aOiN2hYObf1l6qlDV1t3vL1jQAby2xnjnYiDW5kOblQjIMUcKJrID1kiIGtOY5EfsmxERahcamiDqHnMQlW7zuaYpaqKMTUmPt/aeGLeZr+2Rcwm5IU6LVqB487NvxjQgr0RKvm3S5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JJFm3F8A1X8ClWmZbRRWYXEnQxhHXzfHyd4lsvd4jc=;
 b=J3IA6CplCePTIrmpGxY9tf0/8tZzEB0wOge8jU4eqHwegUWWlppU+nK1WPG747ZswIBVq3DKafrdDTJx7MmAwnUI7dtrmKkFPeFwZGKlqdo1nWGEEMfgtzRYx8YZoDY4JGvObOKbhUfoGhPSIFlGYlhgx5pT4KmhPQWuzFc3dpbaztRCr46YC1VrehDbuVdc2Pq+tsIiTzaDJUkN0mFlKhV17G7CqRErDroicqhqF6eYakrg4u6Fd2Gxnv1ObMNuGse/BlaIUzp9vLQ2qepFKjgfqW6rOQ6jBW4OR2kbvAQKIeZjtdo762MD6ktkJwdCT7RVxXwq369i53CCRoeJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JJFm3F8A1X8ClWmZbRRWYXEnQxhHXzfHyd4lsvd4jc=;
 b=F9FNnlmXZrp/Bmr/HLkxVTmoB814vpgddQQQgb4JhrL2G8ZTwa/4pR9qwyEGlrIBKYY32gVYPba8tD0No7o7KeNI/G+VNJS0SSiM5+RBvRNG0kTlUYC8ObGvArVLFQMxgPvaAvjCLVToUMDaD2D0ByB995+iRAZ7cZKAGjRIK9PezU5n5E4rQu0ZmoJ+dqdtPcQ7QC+PGnkBE/Q9H6Lq3S0ypH0gDAeJR8v3EqUq54Ae3L+8CtxFpxMTxjt0zYiNGKQOn+/xXWlBwNQS3Y51AT4Xj/oK04sf/Pe25/cy5l1WWAbOsCENXT0Xvr+lkRpz2wP6tRMiB73U74FBHDXWKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by KL1PR06MB6348.apcprd06.prod.outlook.com (2603:1096:820:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Mon, 11 Nov
 2024 11:22:20 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Mon, 11 Nov 2024
 11:22:19 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH v4] erofs: free pclusters if no cached folio attached
Date: Mon, 11 Nov 2024 04:38:42 -0700
Message-Id: <20241111113842.469080-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|KL1PR06MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: d53c79a7-0fac-49e3-cfe1-08dd02431b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTx5Ix4LCETNnDzHwS65go5wohUviSaJPTv/24pQbphlfQ+hGXMNw5AajpsA?=
 =?us-ascii?Q?ZL+SIEiJzqbBtBtsCY/5AQbBXeDyJxtOo/Q6d0pjgB+XoqZ4uj/AkEBMyYDP?=
 =?us-ascii?Q?8tAltW8EhH9GhKeHnQNWtX2YBmvG0ARjKopaFwhnJAc+OCjyNWMVm9swDMMn?=
 =?us-ascii?Q?MmPMlNGQnerVNfHSYB5rBrXhRaFBwAAvedL07Tgp0yvGYJ2kBZU0LRsoKYR7?=
 =?us-ascii?Q?VnwlpFx0n0Uip/1LDw35NZUmchVd3AXBJG32jXYWTyKkaLZgahTyUoDGondN?=
 =?us-ascii?Q?squkqaKlViNWngzBXP+pJfmhUjE8yJuPPIZIyIlV5/mM9NU2ec/HI5/ea7Ky?=
 =?us-ascii?Q?D1STTG1mmwjXiQMD0aR3BHnHtKTHVFQ9xlamd9aoRH8IvLDm4ycDig1OzfNv?=
 =?us-ascii?Q?+ezLl+UxWwms8pJVV5WTGTBSLDxQINvH7+m5dctOjmofzqsACw3KKO+t2q9B?=
 =?us-ascii?Q?eyaDiyWPNW/t3dELMcJpEWJ4uebB+lMCS6fipNKl4HEKC3JuIvYYHf/AdIRu?=
 =?us-ascii?Q?VTdwnpC75YpPAd2stCcrc70JDyvVwGsXzfG/6pKmmzmApN0Lgql0nOx0qu1C?=
 =?us-ascii?Q?72ydxynPH9ESqMQ4PkgELGJgzMfHfgPnak5BjAdhEC9PJMm4n6ZCQvxyVD4w?=
 =?us-ascii?Q?x5vqKHSZYIjB6sIj9qJl6GLzHR88PyNb/nylkKUr1nKYBWreQnSK6FsyFPs2?=
 =?us-ascii?Q?yNeVA8NhVp2pGhJzUt4s35tIaD8LTZBHzMzqy0ZtXquO2/ZcB6t9prp3QaZm?=
 =?us-ascii?Q?MpYh1UcsFkFb7x6ZdbdJKwU4JfBvxTU/QsOyED+NwGW+zMgB/4Y78/6DpNPn?=
 =?us-ascii?Q?O+qDf64qUnHtP1g1AYtbdJRmg/OIqdwpn8GqGLwY+bG5RWMkg1/3XP2cgpXk?=
 =?us-ascii?Q?AATeMr5DTD3a/C0vXnpOswRG0fWnQnVsraqabvvur8nvFxIx1dHUb6SPUSz5?=
 =?us-ascii?Q?idIlAMo0nZwnqBu4hNg+AW8babPm5VtHguWcvPpu1kKysLRAq1foF1Ri1s0i?=
 =?us-ascii?Q?gDGj+aOKyHG5cJqpiYQ2qr2Qu0AhZmZWebnseJKvSr1ur3wBElvp2S9xiGY9?=
 =?us-ascii?Q?xk5hsOFsc2tWcAKceec3Tk55eRtkEXp03ipiNe54RBFeBa4R/JobAZfk47Ul?=
 =?us-ascii?Q?YTYvUTD/wkDXKfUdw53Hkll4dKwyzTwWoi4ikr7ikH+CdU435kZa2oWZg7SE?=
 =?us-ascii?Q?tvX7N9MRgGEorDx09EpljC2uyxz91O1TmUvM2qPPC8zZlScRmXbI23UKjBc5?=
 =?us-ascii?Q?HXjMX+tluAP/4L5pXdPEJ6hR65wyup+kae2ZnSswOdGTED2Zc3JaSuVxT3PL?=
 =?us-ascii?Q?mSSNevRCytoiI4USL17AnNZTLs08xb7Uo4247Ny0IolWO+GxgAaeza2H6rQx?=
 =?us-ascii?Q?r+LMVwImizZKyPBUDf7D11gd3QzJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6jXLGVsEUY4Qs82Fa3iAhQq55UqS6sSWYZcrc4GLrEbk64kOqIvOYvasNB5C?=
 =?us-ascii?Q?mkpHkhBBUH/mWFgtgprayV54nc0zD8jZ0VKVQmP5y2MrzOJALiQwqNIQ3z3o?=
 =?us-ascii?Q?mk+oLIgkbjld/bQN4Gh73lQtkhWpf57lODHoNlS4Qnjc9soe3a/VlpiBF4Kr?=
 =?us-ascii?Q?QoQy0WrOGmwVjGjh2+IRcH3jmRH4au++Kyjyzxhp6ccabp9jbspGKvYU24rO?=
 =?us-ascii?Q?nhxCtwi6kcQplSzF0e8qCd+Uh61DE8Y93rzP/yua87ekEt3h741owPNUXga2?=
 =?us-ascii?Q?7fU0goAtqvgIG0RzQyG+rXCOsW42VDcPlyIeuFuFKkT2d6yrb6XLYQCvx5Sa?=
 =?us-ascii?Q?X9L5Y7MPBbEcoXJojKucUxp8Gp0VkF5gVyhcGjer8cNod9xAKRli8Rlk1fJ6?=
 =?us-ascii?Q?8DfCxv3qrKRD98Pxm2du4n2d6PhBNQWp+YynR6GBVtILtCMiNFEy9y88O/t6?=
 =?us-ascii?Q?X2vNhcr8Q0CxLkzKi46kTw5dloOciLxNuM43nLkx4+/ilbw77A6ykqsQ2XXU?=
 =?us-ascii?Q?pjFCMKXJuG1WV+ttOh+IxHXPpwSuKuIdztHfFmKXTwK0Nt7CW9DtgF7TvaSS?=
 =?us-ascii?Q?IVyl19e4DtswZnosbgc5obgS0lKq5l2MVusVWH/rYkPnRNdEFkQFxtM/QXpK?=
 =?us-ascii?Q?EQHx/pGzCISOUFbw2smMsmmO/DRXigPgoDshcWEKADZzBtvahWnTYgxgoUlQ?=
 =?us-ascii?Q?dAux/vyU13DdUr+TsmbcqxqlPL1tlDZOaXyxTe68xLtP09O7v5WWnK9ojNEn?=
 =?us-ascii?Q?HFQd55c54SZ45GaoWtM7vH2VtJBdp7ABTV0+X3MBcgNQv90TOX2mwZdELXu2?=
 =?us-ascii?Q?Aqsp54sO5MQau++jKuWyhK4ZeOM68EJ3LwRfAJZY8W8F4/0qkxQhtti7fDcu?=
 =?us-ascii?Q?hTudj0zzLgiUB5PSrSMwazM7JknQHJW473Rc6s7V4aYBaKaOKJOZctyguAJ2?=
 =?us-ascii?Q?GDmYLpg2xwnm3Z+KJmyYwAKVi2xB2b26ERbea+3P9TlLtOBGqdSMn1Q2j5uW?=
 =?us-ascii?Q?B3TBIQTehLCFSP71w5Dqq2vouQctIISozEZKXG4Oy4yu8hgkIu7e1NYVvhwo?=
 =?us-ascii?Q?b9bXlhf2TXxhmn1r+YVwa8vKjj6mhEGNeFyF0H7+O/b1O8o4egrXCKmv4v6I?=
 =?us-ascii?Q?v/BZi27xusD1pK5Lxy2cvEAvHAGYCCQyceNBp4h4FnJoR82KW9F2FsMj2sEP?=
 =?us-ascii?Q?pmUbVv/nmPaeFXdRPLs8St3rYzIckIZcteBmezQ5duhf7THPvkVtducCTIN/?=
 =?us-ascii?Q?VQfp4g69L7OpN8xrsJP+SKGD5QRz0jjyR7xnCa3Q06sbSHADVQe6mTOp/yHk?=
 =?us-ascii?Q?s2eux0QAUNhImJC5I+R6vKvT2NP+mZ/U865YSIGz6oc39TBImAxDFpzV2B/O?=
 =?us-ascii?Q?nWeXNuXoq6gR8ESXid7vcmvceuoHAZl198A02krnbDgZ1CEyvQlUzBV4nrdw?=
 =?us-ascii?Q?ZprNPr4SHkFlxfolE/ZNn7nDagWoVZtZYKW2B7qQ8NQLXG5wIrmf10lLia12?=
 =?us-ascii?Q?JpIhYDSMWR+rjtN6udIUJpdzcwRTzm5lhqnHr8OAPrXZnFW10Yg9wL0YTBng?=
 =?us-ascii?Q?EvOVu8h/99OGUu+/nwSsGvtIxx2K72SINJ6WxsF4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53c79a7-0fac-49e3-cfe1-08dd02431b24
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:22:19.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCjgDiuwJNQxUNXJAjNgS3+DsF0jIC1OtgW6jwdrads3/f+RR+bx7u4pfJYde6ZtvtMQO2yM0GKHJGhXbNXQJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6348

Once a pcluster is fully decompressed and there are no attached cached
folios, its corresponding `struct z_erofs_pcluster` will be freed. This
will significantly reduce the frequency of calls to erofs_shrink_scan()
and the memory allocated for `struct z_erofs_pcluster`.

The tables below show approximately a 96% reduction in the calls to
erofs_shrink_scan() and in the memory allocated for `struct
z_erofs_pcluster` after applying this patch. The results were obtained
by performing a test to copy a 4.1GB partition on ARM64 Android devices
running the 6.6 kernel with an 8-core CPU and 12GB of memory.

1. The reduction in calls to erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (times) |   11390   |   390    | -96.57% |
+-----------------+-----------+----------+---------+

2. The reduction in memory released by erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (Byte)  | 133612656 | 4434552  | -96.68% |
+-----------------+-----------+----------+---------+

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v3 -> v4:
 - modify the patch as Gao Xiang suggested in v3.

v2 -> v3:
 - rename erofs_prepare_to_release_pcluster() to __erofs_try_to_release_pcluster()
 - use trylock in z_erofs_put_pcluster() instead of erofs_try_to_release_pcluster()

v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
change since v1:
 - rebase this patch on "sunset z_erofs_workgroup` series
 - remove check on pcl->partial and get rid of `be->try_free`
 - update test results base on 6.6 kernel 
---
 fs/erofs/zdata.c | 54 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6b73a2307460..d2338bd99811 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -885,14 +885,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 					  struct z_erofs_pcluster *pcl)
 {
-	int free = false;
-
-	spin_lock(&pcl->lockref.lock);
 	if (pcl->lockref.count)
-		goto out;
+		return false;
 
 	/*
 	 * Note that all cached folios should be detached before deleted from
@@ -900,7 +897,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * orphan old pcluster when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the pcluster is freezed, but in order
@@ -909,8 +906,16 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
 
 	lockref_mark_dead(&pcl->lockref);
-	free = true;
-out:
+	return true;
+}
+
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct z_erofs_pcluster *pcl)
+{
+	bool free;
+
+	spin_lock(&pcl->lockref.lock);
+	free = __erofs_try_to_release_pcluster(sbi, pcl);
 	spin_unlock(&pcl->lockref.lock);
 	if (free) {
 		atomic_long_dec(&erofs_global_shrink_cnt);
@@ -942,16 +947,25 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 	return freed;
 }
 
-static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
+		struct z_erofs_pcluster *pcl, bool try_free)
 {
+	bool free = false;
+
 	if (lockref_put_or_lock(&pcl->lockref))
 		return;
 
 	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
-	if (pcl->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--pcl->lockref.count;
+	if (--pcl->lockref.count == 0) {
+		if (try_free && xa_trylock(&sbi->managed_pslots)) {
+			free = __erofs_try_to_release_pcluster(sbi, pcl);
+			xa_unlock(&sbi->managed_pslots);
+		}
+		atomic_long_add(!free, &erofs_global_shrink_cnt);
+	}
 	spin_unlock(&pcl->lockref.lock);
+	if (free)
+		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
@@ -972,7 +986,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		z_erofs_put_pcluster(pcl);
+		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
 
 	fe->pcl = NULL;
 }
@@ -1274,6 +1288,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
+	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1332,8 +1347,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		for (i = 0; i < pclusterpages; ++i) {
 			page = be->compressed_pages[i];
 			if (!page ||
-			    erofs_folio_is_managed(sbi, page_folio(page)))
+			    erofs_folio_is_managed(sbi, page_folio(page))) {
+				try_free = false;
 				continue;
+			}
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
@@ -1379,6 +1396,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	/* pcluster lock MUST be taken before the following line */
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
 	mutex_unlock(&pcl->lock);
+
+	if (z_erofs_is_inline_pcluster(pcl))
+		z_erofs_free_pcluster(pcl);
+	else
+		z_erofs_put_pcluster(sbi, pcl, try_free);
 	return err;
 }
 
@@ -1401,10 +1423,6 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		owned = READ_ONCE(be.pcl->next);
 
 		err = z_erofs_decompress_pcluster(&be, err) ?: err;
-		if (z_erofs_is_inline_pcluster(be.pcl))
-			z_erofs_free_pcluster(be.pcl);
-		else
-			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
-- 
2.34.1


