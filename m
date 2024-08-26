Return-Path: <linux-kernel+bounces-300846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE595E930
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1DF28117E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6380BEC;
	Mon, 26 Aug 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="apSnpYR5"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010049.outbound.protection.outlook.com [52.101.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5B4A28
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654491; cv=fail; b=tmScy+y0rz/RvmaOEhT6GRY+C+bFdnRx88QaopKDMrPCtz+lPH/1l4rrrrcG8VapTD4GXc76eykSNBB0piTRY+/GU9snqZg5nZWG6N1hvid5t9ZbmUyY+PTEHLWAtR08cFSG0TBYIn5XNQmJVRa1AOHiEuWTn/FTI8RJAWXXJaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654491; c=relaxed/simple;
	bh=97l+/8v5TYkY0pfIIz8IKplEFkGcVSL2VEePBmvR+U0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Zs/+pVcKWsrjRq2xFlxGtrNJE86PeGK6Y0E8bZTnAf4IQkUGwcV2qLtdxac2P7KwHklqGEpXOB2F7tYDM0GafWCKRbg1T+q+Cblc3aIL9P5/lrZCnbRMZNrNRctyYamQv8/sB1BgQqOCw+8Exlr/3aGzxaiuSXUOkBjp4Y1wM+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=apSnpYR5; arc=fail smtp.client-ip=52.101.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tv+DYQ7yO8sKumOizaTopFx7VLEClygBfD6d26qFXiI63PjGZJKG48CX5tvvy7aLlbQBDoa2C/4e2ET+zb5+63r1EAS3LQITmb9uzAjvNKfqBpvSO/RnYxBW/p1nrAWhQwhlQpeqIxZeTuOnkKDVn+EGmaK1FfNSxCC4XqmINtkLesSFHpho8EuuvRxxBj+6Xu48NqrnCDb9bboYE0S6gT+Qs5FyFmOdk6fosti2kcdOySIeTVjtOzsO1zPztCCBP6rjF6/PRXPhBQfXcJyuxdhKXeZ0/r065Pg2QHJWqTCFqqEUpsg1BIwBUuPofug/RXsRMUlvFuoyqhksbCby+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCk9RWMqjGElVQDWcnIaKv+aBGIjFY1dUGc0J7gz900=;
 b=jZRqAUUY2VvF4XfSyJy8NjyhnLqN8w7EWv7ecR71M52M6AaG2bymmMjZ//j1HZsCbH+l3+QL9LL5QPcixn1zCM3R48f5zRsvdKdRtje2kGkOlkZicY0i+EZSDTxIMfIVye7P4uy/xPPk3qdQKzAPin75jE0vsInrjgKz/Hq1W0nw315EN1H6AKZMhL4N31GINte8dCZryaXmXsgP86Nv+aLz6EwOimF2IDiZKW+7i0YwJL3vgSHuTaXwWMSYl8d7dNGccsK9jlPar8tbX8NDL8wHtYeLGmlvQ5+IT4CIFnPzmypETeRk6Db8zkrL6W8Gmk+jN2j3CWMg72vH999Diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCk9RWMqjGElVQDWcnIaKv+aBGIjFY1dUGc0J7gz900=;
 b=apSnpYR5rlRFk5O1GZMa/yVNYi6o5FVpMEnJSC/g8ytEqI0ox66WRvFbFQVQ0KCBAL4cGADnCSmw+9NwH/auTK2eO9hIY97ioMvFr1YDUBe5FnmBplJKcj025q6km5bgVMoZGRezXX0nONdtUbs9P3bopb03MZw1hmguMo5cvKTJwJ7xJEnEtvxUh5opcJDkepE0SK28cM31p328gKEUsimuDooD6e6KnvJeDvadEg8BgSI6F87yz7IEpmTfOtPU1RraFdZzvQMqJ7Pm7SR0dULFueyja7FW3tjjh3yYyGxGG0Nf3daPobny9q1W5Rjr5R6YLEBYlMhRuWCpFV4axw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SG2PR06MB4986.apcprd06.prod.outlook.com (2603:1096:4:1c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Mon, 26 Aug
 2024 06:41:24 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:41:23 +0000
From: Huan Yang <link@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH] mm: page_alloc: simpify page del and expand
Date: Mon, 26 Aug 2024 14:40:48 +0800
Message-ID: <20240826064048.187790-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SG2PR06MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb13d8c-448f-4fe8-21bf-08dcc59a1a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O931kxG3RfGzthNHBluYetZXzv7XQ01OX/FeJPQlc4svRMyPzJKuePxyIIxK?=
 =?us-ascii?Q?9wr3IMFryfBlGbcCH+5X0s9aQBl+KF5K54DZR6UbhzEQV/D6ngYDEkrtzVQw?=
 =?us-ascii?Q?wEWDlVd1szPwPUMMR9hdzOO0V4h3jTlGunROvX0SyFslqrA5oQ/oex/fQ/by?=
 =?us-ascii?Q?g6w2kyAEMuqJJdjVTihvQtFeQmTIQNnjX8rrL0wB8WrdhD3C3j1ZUq4coScr?=
 =?us-ascii?Q?yTcuQ72bvSKsuS4HBMUcf67MvfB1PrU5gPcqlro0F3zc6jvFrCU0RmyHqntn?=
 =?us-ascii?Q?FO3X0Sg67a8sx5wpFlZLm2/R5zGj8VoH6s8Or4uYTdpEhz8m+1AHzDEEvLYY?=
 =?us-ascii?Q?I3HcMDDPY7elbjFqUfeO/UUYY3Zqq/tImVCycP8nuNKJYGNp6KRN9LRIORay?=
 =?us-ascii?Q?58xyWEbB4gjEFHnsT0vWA6Yb7LGjG5bx8J8bLfM11eC4SxrQ1yTZXnksKFYY?=
 =?us-ascii?Q?SVWdV2QzAXR106NjOtqKDYLwPSmiMCzFBowp0LnNLgF84Uo0Onf/hEELm4ql?=
 =?us-ascii?Q?csZNwMsXFRav8BziRA5NmCcFfTlV2u2/0u3y2lNkqVvi9mVGnO5ct8YACj+g?=
 =?us-ascii?Q?EDwuyQnOeWCnCFYNNPPuqKeA/n52XgzB4dVW1xXeDxNmeeCHfZRFTfPPajey?=
 =?us-ascii?Q?sp7DEiak1KFWxrgbwEF4hYHpP1ZN77vYy5A/DuiSAIIA19fGvsOk6fhPBVwI?=
 =?us-ascii?Q?WXgxcDG9psrCWK6h7cz1iTiOTzIVvKqVjzQhgCXqJKidZH+Nl79hDF2ttHkS?=
 =?us-ascii?Q?hWMNEOI5EVEkkcn6AcSyJwWEd9NoAZXbz8UiAIJfdTuw/LzKR13kj5SX58o4?=
 =?us-ascii?Q?//uVjiNa3SuZIvuOj0o+HjTATfzbj0WNkUMC0IEmxNqJuob/a4eQlH844bcF?=
 =?us-ascii?Q?2gdBrWM8/UGu7YpF//FQc8ftFHtA5jLfq74bnSxXDGR7d+H2FnCWAtS3h0xl?=
 =?us-ascii?Q?9uFqst/czl4fOQMdF4SYK+bZREKtPw11PpHoTcup+ER6UnhGlm4bwdKxs7wg?=
 =?us-ascii?Q?6eF1z0IyAi34goeTmNh1K1Hm1aUJMrcHxJWPcxASGV6zAovM/0AtsF1RGX5d?=
 =?us-ascii?Q?QuaVKreapynNh8RzT6iEMucUJRl/99zLTIv//hyPqAryLovwTooq/mCibxAr?=
 =?us-ascii?Q?av5hjZJNQ+0iLK4s2HOJfn61cbnuARx+5Go7SB+t2X9nZl3pMzpisvVU4u8c?=
 =?us-ascii?Q?FOlDjJwJhJBsll2gWr6+jjthu/1iyHwvBZw0TrALFpQ/U9Y9ImU8R3mK6ec0?=
 =?us-ascii?Q?q9D+5VdG6WSYRWFg3/pCmTrsuyYd4+cje2WG9rfdEowlnhDtDwqcl3RGye1m?=
 =?us-ascii?Q?pv3+oZYR40EKqKU0P4Uiar5GTR/ImJtt+ss9YgLwOyB+1QvzU+xgnAo6Ouoo?=
 =?us-ascii?Q?7KDJdn5bHm4NU2L7oHESqlSywTxPHxWCDNr6vaafQStoS0URyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PAz+JULD5E0UJquB6ubjxYalpA09fo5JgpKwCVi23Vtw4qMwVqErCWxOd+HK?=
 =?us-ascii?Q?6YtmqklhN9ElX/PJsyG9fPlXSFGqc6oSU6IU2vs2c3Gy0Ri3hp1Q9ppRQ4UG?=
 =?us-ascii?Q?G3skj2eE2PVK/jemQiNWmH4feaJ0SO10Ic63QeP5La7ZmAUroPcIC5c43b9E?=
 =?us-ascii?Q?Zz0DtWQKYOw/T2TX7MngSoWFOMwasQoo3zXUATDXFPRZl/+/UKJ/bQ8wOjfE?=
 =?us-ascii?Q?n+R4KSWaTbAE0ah0cwJDqqmmpwnD0Ci8qXOueOL8OslWkIBGYKvECbCrnmRH?=
 =?us-ascii?Q?f62YkXhHAKn+q7Pzd7dZzrNvm0YoD+UEmvAuV44OgeJ1WVFHcmwXb6pdUeTJ?=
 =?us-ascii?Q?UnmuUR/zj2TEVAFpi2mOoBucBVuWmSkGtWCAUVM7rx+n23beM7/2c02Qlv/G?=
 =?us-ascii?Q?Q33pywy8JhrvQTS9VE+oklPJC1ZtHd7+lKTZo4sGzNBZoDEawB7Q9HLBiTN0?=
 =?us-ascii?Q?5Ul+oXnlZBkv7xAUY3CetfYIcz1OrgtfPHn5zGW0cK6/KAl7/kivvqXHMrz1?=
 =?us-ascii?Q?tHdP/O3eTVNHCX822mpSKgcB3jLrFKXsHG8uTfZUTrCWpsvQRFfXn5y1Libo?=
 =?us-ascii?Q?JdNGoJmpymmStWuoHByA+/462l3j8BW1RLmPrNTgiSj7d7V4uMsrpr1y+QkT?=
 =?us-ascii?Q?0uneb9+UFRR+mTuW35F3R6PYSt/MXS3V2fqnlJb5/RYc8AVCTxeYppdFFnj/?=
 =?us-ascii?Q?rK5XP1R1L4C+q7Kl2SalOIuyUlOqMLe7M9j+TPwbyp/b6uCHo3nc9FJRf4uM?=
 =?us-ascii?Q?jaKSYZIkfQRVjXcq8FqSFLB6epTiYEtXanj2JpcFjl/JW7cupcfo3iFoPrxE?=
 =?us-ascii?Q?dXc7patumizZp4opQo6uyr+EFXhqq4gNuX1PZKhmzZMRYaQ8m6N781F6yhqw?=
 =?us-ascii?Q?ZBVcNo98zOlzI5B7ztV0NAKYNoiqvA2bsyGWkPloKkgKxmzrNvJnHRyoOp2x?=
 =?us-ascii?Q?F5WNnhR7SeSZ1BAU85tsHuMkt0qzAI1jwJnl28Bgp4qqDGrBb3fVajFHcPwx?=
 =?us-ascii?Q?5GfcJNC9Hj0bpuUxsnWxF2JUL93EvmDhJ1cjs1HydU8ffwUJKz2TyVUM8E0V?=
 =?us-ascii?Q?fYxSXeD2nNeIZRCsl79IGhsCRK+0b02jDRzXORAzAsSLdZJBNeA2loLif7Uq?=
 =?us-ascii?Q?mA2j7qYOZ0mNKL291S1waSawiVsrckB788TKdLrz3oB5yNaCh27TavnDl7o6?=
 =?us-ascii?Q?TD8MjUnqT4V9mHk6iGxysjk/Bx30Yd9pH1iR474A1RH/xceItBQ17rOOe1mq?=
 =?us-ascii?Q?mlsRBfMX9xaMCmkVNBqlYuzQCc2jUJouCAYUgoIUfpc4DJX2KTU3j9ozFngb?=
 =?us-ascii?Q?uwfw3PFTqFqkWLIgCRN9xpjgL9qop2YhsMza2TT3DNI/OkJUhcsBrR0QAQcM?=
 =?us-ascii?Q?svVzkK6DsE3ULAYR59Yn0WbuQ40xmLeStcZ3R3Q2Q7/wlED6Gv0ncfiVqi3r?=
 =?us-ascii?Q?2hhs4P2oQHA1GhFbOFmSqI+Yiif6zWyUd5Cl/UENAzW+XdoMFwtAIL3URfVH?=
 =?us-ascii?Q?69uJUhHaHPFwthHoLeefKEKDYClnxtiXwemiwErjFdhNWGlyIk4KJa1dVM61?=
 =?us-ascii?Q?L9N4dMIhH9fibsjCu2COUTRJpkxvDoQQCX+WcVBw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb13d8c-448f-4fe8-21bf-08dcc59a1a17
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:41:23.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD8IUgfNW2u6CYfbeHloLkHOkAHW3KwCo/O2/b1P3o/7Xu8ZR3OghVMAugmXbu8cc7lwSvys6bunPkgeZ9LSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4986

When page del from buddy and need expand, it will account free_pages
in zone's migratetype.

The current way is to subtract the page number of the current order
when deleting, and then add it back when expanding.

This is unnecessary, as when migrating the same type, we can directly
record the difference between the high-order pages and the expand
added, and then subtract it directly.

This patch merge that, only when del and expand done, then account
free_pages.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/page_alloc.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 023132f66d29..900b0947c6e1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1363,11 +1363,11 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  *
  * -- nyc
  */
-static inline void expand(struct zone *zone, struct page *page,
-	int low, int high, int migratetype)
+static inline unsigned int expand(struct zone *zone, struct page *page, int low,
+				  int high, int migratetype)
 {
-	unsigned long size = 1 << high;
-	unsigned long nr_added = 0;
+	unsigned int size = 1 << high;
+	unsigned int nr_added = 0;
 
 	while (high > low) {
 		high--;
@@ -1387,7 +1387,19 @@ static inline void expand(struct zone *zone, struct page *page,
 		set_buddy_order(&page[size], high);
 		nr_added += size;
 	}
-	account_freepages(zone, nr_added, migratetype);
+
+	return nr_added;
+}
+
+static __always_inline void page_del_and_expand(struct zone *zone,
+						struct page *page, int low,
+						int high, int migratetype)
+{
+	int nr_pages = 1 << high;
+
+	__del_page_from_free_list(page, zone, high, migratetype);
+	nr_pages -= expand(zone, page, low, high, migratetype);
+	account_freepages(zone, -nr_pages, migratetype);
 }
 
 static void check_new_page_bad(struct page *page)
@@ -1557,8 +1569,9 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
 			continue;
-		del_page_from_free_list(page, zone, current_order, migratetype);
-		expand(zone, page, order, current_order, migratetype);
+
+		page_del_and_expand(zone, page, order, current_order,
+				    migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
 				pcp_allowed_order(order) &&
 				migratetype < MIGRATE_PCPTYPES);
@@ -1888,9 +1901,12 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
+		unsigned int nr_added;
+
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
-		expand(zone, page, order, current_order, start_type);
+		nr_added = expand(zone, page, order, current_order, start_type);
+		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
 
@@ -1943,8 +1959,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	}
 
 single_page:
-	del_page_from_free_list(page, zone, current_order, block_type);
-	expand(zone, page, order, current_order, block_type);
+	page_del_and_expand(zone, page, order, current_order, block_type);
 	return page;
 }
 
-- 
2.45.2


