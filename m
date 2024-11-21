Return-Path: <linux-kernel+bounces-417348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FF29D52DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFCF1F2286E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E31DDA33;
	Thu, 21 Nov 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJ7Nz+xU"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0121DC198
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215172; cv=fail; b=bXTkkLih1DWXBPX4ULL7XrvSWCo8nFLAKIM5h4Y7TOELWLfqwbP60YhYtFfV3Wj8AJFfC2V0X0uGGDyLMWMfpvz/TckOMrhWEXFkRIz80H0qmQ9X0rnV9GFOycbOJhhGEm2AqB/WiU1JKsyZGrkABSBKBL0CQ6EJDYIxQoHG5ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215172; c=relaxed/simple;
	bh=cW9a5BFaXQQLUR3sLPN73HGWNa8JFsuKtvliBlqoTU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CuLMifE6XXwG05RsWdwTpXbB8jOX33ggM1nbHurH3ulbzGRXcQ3dAHhHPB420KZ2PMUSHqhrbSemBQgF+zN3tYvcMEZ8CtaQos8gt2V4qg+h4WdCKkxkO/Rg1lQRDDoopxhyD+pPw+k0gYi/5MysIYn0cTQh6mNDuDiEAT46UyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJ7Nz+xU; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBYEWv1U6iriFRV53KtW7ek0eauOkf+ahrA1fbEHfMuDS2byVjfy/Qb43DD/6RqrTI6im6qyOnIoZJHUAXThZSaP+rkVYm+im6pg9XEKQ4vdTN0vS28ivjkCMBLEc+gMOC6pRt8c6fLxD2oPCOE6bYec3RW4UkGUxYKnNmC+wrGViiX9+kcGQH4AJSCAq15pfZjOxAhehpVa3/ntsI6xJ+6dwRHvWSVzmRTzop/E+WeLuf3MJfWDBGFlcvL4jHeXVnvEUawjfvBnr43uNxuQHJNlQNlljOJr2tIDphRIyj/AmhVt/l9q+C9x5lvfh9WuFomoHCIi9K5EDzHBvEmSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCK0ahHP2aeqKyUHb8ITfSzvvy9IFw+4Pn/KCUxa/mU=;
 b=MI3JA6yGoHixd6fPSmAkQ2zqFHDON+6oiqoQq1gzNh2mk7MWqDDoYKGRY/mEWPofn2P4JCVlLji31aFWGnX8jmt/WKqaan8l1n7uIC8/dPIQR3siFwvuqfiW7+kfIVvhfLy8geomgYp7ggCw7WYFh19cPYZRMevVMaVl9hwFlMlp8we7SKnagqPJLfHuVETpXPO3kX1WnLyH9qWtS3X3R8zT13bO2CMy2CKBoQ4W/gcYusx8c5120OD2HVMACcuFag5Pv5Ejx0ReaL/ufTLEqqH5X6N9Aaqi4TP+1Qx6b9wEAk6syS0KiOC6FDGYfLFL//los+d76GPMwTxAn0OHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCK0ahHP2aeqKyUHb8ITfSzvvy9IFw+4Pn/KCUxa/mU=;
 b=FJ7Nz+xUreBOOJl9EjB6lJR/DUGjcsN99GoAtjuABAK4TJ2sckkxpeNeWbkKlVK53N/gIiDmZ8cXWZ/xzLEg1b+b+ekIPI+8icVsBSIa+RdmCiX9ibZxmqw3hkIqR+ax+Hhk+SC1fx59J37lDaHUcv2YlLAG0QjpdhBVKU/iA/XTDN3Zjhg6YHx+sqbVRGLwljLLSHCYvbIgkwotG7kHvolkkwsloxWgNlHfcEVzQobrZcjIWkCc4VaIamXePujZWDKmhWjR6RCmGH3XpR5zxcl/jo7wqzJNLIwJlylP46ux7U3jwawsrPay+2eeOrOFkXlvMry8LYFsfwgs+TbFVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:39 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 6/9] mm/truncate: use folio_split() for truncate operation.
Date: Thu, 21 Nov 2024 13:52:17 -0500
Message-ID: <20241121185220.2271520-7-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121185220.2271520-1-ziy@nvidia.com>
References: <20241121185220.2271520-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::13) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a62e1d-4ab9-493a-619a-08dd0a5dab7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Edd1Sjel1NqMjTX5gjFo0dMqOeTyVVmQ8/u8jK2GpY+lSvxnI3g45RoGwi6A?=
 =?us-ascii?Q?q0DUh4IUpbOFymEB0zF/3HfXpWmiN7IjUdQnePkDddkHkVXo5ngTRfJCwImr?=
 =?us-ascii?Q?tHUMsB11wIWZ09/jQDKXKvr2LEByu8hiK8WhnU0d2SmmFt1BCSz4K9W79tsD?=
 =?us-ascii?Q?digrcaK4V6luA1jy97PmTxWEZVndrc6qqSnKC9PohNgeoeikhRKgDf4/+nTP?=
 =?us-ascii?Q?BuSRd+n6c75H5DGMgjaz/oVx4prK5WaSpixyFO5QAwR2Be6B8xIDZX8xPO29?=
 =?us-ascii?Q?NYbZcTrk9vYPPA4b9HwzpTHyhSOWgDDroZjSAPJ/4BX+ECSacud3fWkrQbTV?=
 =?us-ascii?Q?UNaI3P02hi7vE0eak6hF3f/OUFd6mOwiRHAuc//YidDe/LufjJQyDV4T1oMu?=
 =?us-ascii?Q?xx9oJcisIAfdoz9phlNTEd5PauaNXZ8+mBBWnKZr4/qlRW4uRyv0haRFKbAY?=
 =?us-ascii?Q?1w/oUsE0cVakHKqNRAATszDnztik4sEHMmbpC3Nj+ypox8KEl+J07x1lB2f1?=
 =?us-ascii?Q?sRTVy9HW23E0fcCFPtlI2xSHSbZPHyz2k0938TT1W2EL+QiQxv3JLkLdU4gd?=
 =?us-ascii?Q?SqchuW5YpmsTGBfCBnGFOIjJXZ+71zkcJV+QLfMSxO2AsJ8lqndZAoTf0h4w?=
 =?us-ascii?Q?fywdbGbzfltF4mTqeRlFvj84XxaMHK/vLmUuRzj9HrEwEhGF/5Sn8mVlp6ba?=
 =?us-ascii?Q?yYTFl3bJFpsTgA+e/3nfHHapycqBGZSTbYKDNyqT0XRP1k4DVP0NzeqrirDC?=
 =?us-ascii?Q?rqemY3jDWV5WjM263jMAbb8ctKKcFdmE/I4kNxFQOzpYdYB2wyItsl4WDsjN?=
 =?us-ascii?Q?WxBoZxXv1sNPBDq4WGMx/pi/N6atCJwrGoe/CMZ34auTKRJWZXJjLow6byxM?=
 =?us-ascii?Q?4YQRBrWlltTyoy6S8hM3cOU/mUVKFWvmXXvI8GCJZkwvXFn8EB2KDZyYeggy?=
 =?us-ascii?Q?gyDAMHHYUzLnJ1edwjBUPBIp9VRajv1PjAgY9u/YoU51RZA4SytkGd4UD4Yb?=
 =?us-ascii?Q?p5lDe7dvUJxl+Xob8tszV1cZ4abvhlM4s7weMRLl/vDu/o0f+8qStEHwQlF+?=
 =?us-ascii?Q?pPj9BlS82kwya5ihgTUb5PdhGRCL5p7IhLWANCiRX0uLcaoCY/NoXfAiGPXd?=
 =?us-ascii?Q?t2YSR8JdYQdGNDC+R4nfYX3QQZOZQch8RjsYOqBKFR/HygBJbrZImjjDb1ui?=
 =?us-ascii?Q?rG6pgRpS5oC3cqcVU6vea0FkJfzzfRBL0yDGS4VRyq8IFULZYbamM8tvz5KD?=
 =?us-ascii?Q?jBTphBstzrC/ERLyI5xyk1EUHcPiALZ9NZZtdHLTYMgPuPB9fZ6pArYI3+Rg?=
 =?us-ascii?Q?FQpW4QP+bHDW57HrEINT8a1z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0NoFIYX1dAlIuQMaEyOPzhf0ILAHlQZLzDtPx6ISrDqshcWvWsO2w43J317K?=
 =?us-ascii?Q?PhKjVtcjL8BkYzl+7bi5PAjw3CuSMOeUuCGKcULBkTStHF1Q6Y1snp0QRgzM?=
 =?us-ascii?Q?ivnK1RMbWuFlXZRGaz3wEyN2Hw+8uzSxkryQzaPc5qalrOowuse+mmiF3lv0?=
 =?us-ascii?Q?46rd9NKkgCSRCeWJulDX+sWrJVgFs7V6P4vAqNyyCFvGlC+0Gwkclx53FOYK?=
 =?us-ascii?Q?OaX4f/VVZGZ9Y0H5icUhR/Zyp8NFSwywPIJwTx9qrhYdyHHVYit+DwTnKR0v?=
 =?us-ascii?Q?ECeIV8YVDm8wbHNgFbPPYbLOhBr8vK1x4ALCqPTIGj+yDRdF1O6JEFlqx9t0?=
 =?us-ascii?Q?sAFzreka2mCBjGRfd3ZprTx1HQM0XY7nYzvWXP0QlDE9LHf+cKq23PJLUJdY?=
 =?us-ascii?Q?8uV6I0IxcJW5JNfPY7hjQ8VyvdGTosErwL8ykjTHX+bjqeCfuloFd+CiFkWW?=
 =?us-ascii?Q?FeBKIAtxmheQ2Gx076H/LUB+RQBjUq62OIE+6pfDzB3YP0Wudgo8v40ycuCn?=
 =?us-ascii?Q?S3HJd5Jt/H9vKGyREVPVUbVJfUE+WaT349Aa17S2UGQ5aN/sKdsT36ZfhveW?=
 =?us-ascii?Q?KiaAxj1bD+aZf0CjfbNs2A5tfF3/iCSNeIsMJXNpa+tCfwJs2w9y6s6SCUN0?=
 =?us-ascii?Q?ZPg3ThyE0fNVcUJOdNfFaG/NC94AAeGT2L6qMtweu4eZl7EqlAb0iQKSsk//?=
 =?us-ascii?Q?e0ZHaUcwvWDcA5AlPczXB7g5Zzvx3U9fVK33TRArRx/b9JXL3L/XbNRE4b+M?=
 =?us-ascii?Q?iAYF9HKcaL4K/UKvq/KiVN4VzKZ0372CEpOLu1OBfhwOvn6FAURaupFIE755?=
 =?us-ascii?Q?Z9kn6gACDXGScDA/u+zwt/kTdszsrRq9TJBgOejab1tNNYH9J6LYUiurYI9w?=
 =?us-ascii?Q?N5+Eu5K6dkYnNbywxujD6ceBA1nXOfhvt/raKOCHRAg1G9XHr3una/sa+iIp?=
 =?us-ascii?Q?PnJjhDeOOy1qXwZp8nUlN5j1m5ZC/ynw61PS5oYOIRfiGgozeUvE7ivoZyhq?=
 =?us-ascii?Q?HB5D2k4imjyP+JwMuqCnl+Ol1sbY+lRMbCPYU3s8NEsPPg+SxJLZizbMoK9C?=
 =?us-ascii?Q?/K7/ZW/1y7i13I5t3Usm80wUnz1DOL8fAWh9xGOrR0B5UeQrTtF+Yxofj7UC?=
 =?us-ascii?Q?hPZj31apH/pDBToE95vnNqlXAkA92dNWQtMrGKs8cRGVNqvgEqpswMHUCgjE?=
 =?us-ascii?Q?kTdtY+bsNYbZiAAcXTnsDmVORRKUNLE778yIa0FTJ5ZWrQ+IpRQ4GSkiClXq?=
 =?us-ascii?Q?h/1YLb4MGNZ1HWRl9Gc+0VDs7Z89ZQh5r7eI9eMuZHpmxuNWQnm8l9X+BT2Y?=
 =?us-ascii?Q?88l0Czo5E6S03+kUB3s/vssTqfWlXaNdKObSurB/tp5YQvR74kg7tLNJV7t5?=
 =?us-ascii?Q?Am007UP4Hn2gGR8EoAMNhQAsB0EUr6wjWCpqHMwE+JpWPbv2HUOwWVUHjiB0?=
 =?us-ascii?Q?kx3WABcvaIS7NFVZQZmgkcvIcETus0qNBL1oTFu2YFhnULoD1+OEjVj5sjQi?=
 =?us-ascii?Q?OtjCVkq+HqLokiqn51s6CiO4XyssTdwQ4BR0Kvym2l+yuMC1wxrpAkd+Vwb8?=
 =?us-ascii?Q?UFQYbA1sHz8g5/UvvH4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a62e1d-4ab9-493a-619a-08dd0a5dab7f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:38.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Oxh8ANGuq3V2Z2UnNkciWxbMkuGLQRjbAGLlavFBY1yBWro59Awwo0yOl0qBNv4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

Instead of splitting the large folio uniformly during truncation, use
buddy allocator like split at the start of truncation range to minimize
the number of resulting folios.

For example, to truncate a order-4 folio
[0, 1, 2, 3, 4, 5, ..., 15]
between [3, 10] (inclusive), folio_split() splits the folio to
[0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
[8..15] is kept with zeros in [8..10].

It is possible to further do a folio_split() at 10, so more resulting
folios can be dropped. But it is left as future possible optimization
if needed.

Another possible optimization is to make folio_split() to split a folio
based on a given range, like [3..10] above. But that complicates
folio_split(), so it will investigated when necessary.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 18 ++++++++++++++++++
 mm/truncate.c           |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b94c2e8ee918..29accb5d93b8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -339,6 +339,18 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+static inline int split_folio_at(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -531,6 +543,12 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
 	return 0;
 }
 
+static inline int split_folio_at(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/truncate.c b/mm/truncate.c
index e5151703ba04..dbd81c21b460 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -179,6 +179,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	long in_folio_offset;
 
 	if (pos < start)
 		offset = start - pos;
@@ -208,7 +209,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+
+	in_folio_offset = PAGE_ALIGN_DOWN(offset) / PAGE_SIZE;
+	if (split_folio_at(folio, folio_page(folio, in_folio_offset), NULL) == 0)
 		return true;
 	if (folio_test_dirty(folio))
 		return false;
-- 
2.45.2


