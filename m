Return-Path: <linux-kernel+bounces-435436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921749E77A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341DB18827E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DEE2206BD;
	Fri,  6 Dec 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NDvMjLKW"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ACC220683
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506974; cv=fail; b=bXds5MgVCT/fp8KaZ0sLJwC9Hg4vhTr1s6hxjNWAjzkXz8Dcw8n9wJeXn33C3wP3EX5Pjw0QEfv5mlF387+eHZHnFyhqBamUhPCxkSjbL371cDnbzZ1H1tbNXVMtX+YZORzJlScWffKRXdg5rIewnEVv2DlBQtgB3MFpuoXyH8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506974; c=relaxed/simple;
	bh=4TgCzAy357rEtRXQ+qluAoITrva3Nuh2mChxrB20zkI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YVeTXeoLO6jSXQgiBaFN9gq1voi36/iBDAzp53qhNYS/ILmK1TIJQ6iSpQxioehtBMAk/+xRP4BKwtFKT4DntJLQUuhLKLvuUG0r75G8vwuuD0vZ+2P78paNbnIlvNxGWRJUG7HBJ5u9y0CR/BDLU38f/mnO07vWQ+VW9aGBzZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NDvMjLKW; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlyfb/xJZHdHhmUN8boAUFFdCLl/gZmBxelSmRynm5kKbrqwG1vPVBIexETCMSjAipM0KIJ4+ny4mFBQMgHFRSvuWTvw5gvW9seKk+IXgCuLhX5AV4oUULG+ed/Eq90gguFZ9UamYOsyIKlca1IezJrxQ31FITtyK1iL79dLKdYiuIQJt/SRuyxPM9DHRqoqANeqMl+I6Idk9q0dLbERbBb0zMpbLuJw3+FBdYtAKp+Ug84I9uM11tw7ultcFi4+54ICyxjid9qVxDjeX9QKiHPKylXEuVcH6A00EFCzXbtQ9y2pqB0mVqCCBia6DzPLJNTT5oi+Eqb54S3sYSGZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0UP29TnbMqQy7tNeeZzVu2uyr3inJUGKk0FzecqmBQ=;
 b=EQsTeHT2VrJesO4kZQMaJnb6FFIGVvjfbF415WfA10fbn9tSpdW3k7l5PeI3RRhPQxkw/mzdlog0OUcSPMTa8/jIYg8R+thXdo+sPige5s4u3IVg3Q2fRq8xuLCu0MiTEOb70CVunlzS1Y+oLYi8PY14PI5UfOYeEy+gpyzVQw65Lj9gG0NIIyqnKdRTIlUsfbp3pQqTfjjuOXG4DcTyyR7D1b1UcA91mBhv9QOuM9H+bJEShhj/iY4Uz+t5vcwC3qgCVXmqAKAXvyup47mWF0ITBp942vJSGlOvmvJ7rrxl6ZLlB4QNL+pllWqy5QhsnK8+JL5xN+NU61osN92dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0UP29TnbMqQy7tNeeZzVu2uyr3inJUGKk0FzecqmBQ=;
 b=NDvMjLKWpxIHn/ZmK7GHdzPHXmbsXYrc5ecHqtqHaoMyCNnkibbMLkFE6nzyQjSUvn+frKzRlSizXkC1E+F9lK6ZnQh7wa5hw2/OX2INwBqLEb2UAI5x2uJKrvzht6cHtlwdQKQYk1eoJ8As5HPyIODLw4Vv5xD2daLk/8oLCxfpqwblaE4oghtFM4VCfDx1ZftqbHcufft3JzLXh6o77o5S6vbLRNTxMnHzFcmFx9LhwRNhor/dpW/wpXu3cJmaAKoRQLmlPH4nW1ESC5u7p4HzrS1TQrL65w/HPXtWY44oTrymBI61sfqdimk9K1NNvQ9l1XfXOgGJmoL8rF5U0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 17:42:49 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 17:42:49 +0000
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
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] mm: use clear_user_(high)page() for arch with special user folio handling
Date: Fri,  6 Dec 2024 12:42:46 -0500
Message-ID: <20241206174246.2799715-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:208:2be::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: f13e8c92-b75c-4bdd-bd29-08dd161d66e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GmmyV2g9pMdkd6xQbR3bqxapEBacXRfTQf5Xv1dpsYmtQzNjztujaxPf9rH1?=
 =?us-ascii?Q?k5ALzSKh2BIQGa1rCrIxoTRwUuvKm0xgure8xzsP3+LdgT3YAxiEllFz1uEp?=
 =?us-ascii?Q?ftx107uZh8Xks2h1jje78s2jtzys2wUBFoxqjLZ1q0trr4bWj6C1KWUmdiKx?=
 =?us-ascii?Q?sI9FtA7If5bD9620Xp5Td7mgYUmyI/7LWRO56dsVCRC9blatheV9vcmqHjMW?=
 =?us-ascii?Q?nxJ5/e4xnpg1nOfKj0Ujgc1QrVVjInwFQhBp9AJ1UbOiIdTXgjB50QxqtElM?=
 =?us-ascii?Q?fvcziszsa4SaMRGrSltWYTyLTMFfjz1nB2l3W15o8SEoCdFBAyC28q0wFjXM?=
 =?us-ascii?Q?WyIlIKq1j2/VfcZEy2H5VRJ96nPrTwK3pDEltvvYnsCZ5/EpNCv0iiVRhCtb?=
 =?us-ascii?Q?x2DL0hTh7SBg4JZvI36bWpzKINZAKQrY6QWatS1oUAV83cuq27Rsk+mTZcP+?=
 =?us-ascii?Q?TACI1yBi4sOR3rUUs67xyfQJvzvtq8maCNTWlnu3tjAWXXOeYBS6H6FBWon1?=
 =?us-ascii?Q?lMAuvUojqDus8sg5IbbnFTXnA6CLQrLvWilAoIVy2QUvKYTDUD6wtk9/JQ/8?=
 =?us-ascii?Q?j96J5xWEZm3ppHFfzAh59lJnYgFbIb3MYr19QKISNXOAV0cSPLNSpirqAxOv?=
 =?us-ascii?Q?dglN3h+kkd2ZEWYCIYvFJMdww+ewGvpW+SOrVMevmrciPtk3XmrMJQ23bwFC?=
 =?us-ascii?Q?xl+4uF0AIUiWFVIIz17Qo6bYqMe6vJaE9XTswYoOu/vxUzwa9Ymuj5NM8q+w?=
 =?us-ascii?Q?o5wA2URxThJvD0NxmxcE3xjS9OoEbuVrwG1pdZcbo8J5+1nQ6SFY3wh/L7e2?=
 =?us-ascii?Q?py4nDV44e1P4gNyOQrOR5fdWVSTCld3Xjt6KikoZP6qMlZdfTWH0/XZPeA0K?=
 =?us-ascii?Q?OCaFZ3XSozI8CfL/Fy9RR1oThzH6s9h5/t7xo+7bKyKm5E8HKmJnlC/BZ8SX?=
 =?us-ascii?Q?ybK2Gj15P0nF6ZbAmmJi8ILOaTCfliIi0jwXkEtUxTuR9Hq3pi0Fz2khUpLf?=
 =?us-ascii?Q?v6K8y4kJq4uJX5OxqMFz4KD7mY3Yze3bBvFHxkJ12jAxwFcMhMSjFaITc7WY?=
 =?us-ascii?Q?OreFlPnTqve/jNHtE/2twMxLK2kZofI4jfcQxFlLUz45nKTcKTR421otZYGG?=
 =?us-ascii?Q?4SDbIdqG/z/8JKmKgJ8GPQQxqQzl4N/7Czf88BNrKjJBP25cKzeYj5f740YX?=
 =?us-ascii?Q?jdGo+uO3yNPBtqSExSDjVwlf9jwhtcKItZt83Gd0WacRKBcf1lMgU6fr/xMI?=
 =?us-ascii?Q?oZWIpGUsNj5S+3ilq2KkhC8dBbhltG0/GvW4WnHef/SBxESJOz0aIwI1ftUX?=
 =?us-ascii?Q?tIFRkjonUNJnSAQ7KYaXR07sEtXjqrhUD9fd29rhnhoU6NM77Zgyn3yM3TXb?=
 =?us-ascii?Q?FUnceQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JIRb59N9e5S8tq2MXRMFRUnEEQdHTpzsXhcLv9N1G54ex1dUht7mQhzMBhAw?=
 =?us-ascii?Q?ZPbt0opHTwSHrzhczFwJhSc4fHdnwWeCcI7q7HyeJk9GZtAvBAKcTA/Td067?=
 =?us-ascii?Q?tUY6ycrixmvfL+Rw8Syg3qTWdG5hKdfi2wcHCWzYPLQYW7Y2V3N/o92xqMjx?=
 =?us-ascii?Q?lhv9WVr965XZM+P9PW5Tya/9aL0ZnZFlgymqVnZy9Rxz1Si7Ld0DssubBWaY?=
 =?us-ascii?Q?rlyu1EvPlnBiOlFBdSABmRXKy1NqLKiuCViDaaWwbh1y1yxapfqgkfpqZG4l?=
 =?us-ascii?Q?3p7vuRaJURG2rJEZAC/y+oebb2tWe53yIZot1q0xBd32libX8arhDMyrIP6O?=
 =?us-ascii?Q?26PRApjDPpkTs1C8p/TNlpHqs84Gue6EvoJg6KDDMNp5piqukI6ZCjK6KLr8?=
 =?us-ascii?Q?nM389N9uPx8cKcXSXk1wCUzLFq0+q0+ZEi+zGRkCVN+kkCBBpMZTnS8Lky7X?=
 =?us-ascii?Q?Nvd2ysjkmeQhlVAFXmybvIXuf5R+EXQjYFUgONBpwUjG5RgdocwHJ7mPWgH0?=
 =?us-ascii?Q?jJ2mNUt6LhMb7ecUTguxKsrA8JQjxe+ilJPxxy8G6zD8x8rfwFMONGeF6xvn?=
 =?us-ascii?Q?3MbacOK5IlXScWjSOGzsnI9ZptTp7c21XkaU3SiVeKnALgsPfD/Y3mZk8+3a?=
 =?us-ascii?Q?m/tJpF/KBduD12XIXwuQS0iovCVEhz7kky8HRGWL/5Qf7YQotcaDVkf37eBT?=
 =?us-ascii?Q?hinFDgSVDS5jELJfSmR0k02kX8IBjxSU+frfgXvrf4SQW9gnZucm69dqdY2u?=
 =?us-ascii?Q?YTgwDhWxm6IwuSGV0nobepDN90a9AFlcCEJZ59GAxoWfK1wJFaPiilg4Bs1B?=
 =?us-ascii?Q?hHZREPgrjQS6v/GWJANLRAwhCLUMdDvgRTpPoSdUL9KIwhURQ0+csHuDTO0k?=
 =?us-ascii?Q?4/UaejN0PHHXmbIHkCfNPjt9K56+sS+Fgv0AQ/8WVGXrv0yNhEH8uZz/x6yc?=
 =?us-ascii?Q?KDIVvJIxQTI2hMCR9tcG4bs3Wog54AWLZ9+EL07TRuNjGKPftWKcmrNO99oc?=
 =?us-ascii?Q?eA8Tv1dQ7fmG1o8zb0xzCe/9+Yr4Mei89qNxUYYoSrzpcUDytKWpIHPrTw1K?=
 =?us-ascii?Q?1iY2C0Ry8GZJixnwv4cR9BHAmreCqSCg1ASPnLDQpqaDawiZKZTgGmFe+eTD?=
 =?us-ascii?Q?1tS4a3aCWcpddl1sDqVpOGf2XBcSi307efHnFKkN72eDdSjRGik1Vba7Is7u?=
 =?us-ascii?Q?k8SmuV2EsNH/NAhHC26IcrAVICcj3yjnDvUQCaVuavWDn6/5nvI6iTTZCQRI?=
 =?us-ascii?Q?/6nm7cxEd0+Yj0ujF8kZCs7c2YIohaf3COydvCmfxihbswHwg8ioueVMp0Um?=
 =?us-ascii?Q?RI5Lb5/us3kR0TWssVaF0rnrA5VI7JFSE+xmHT+d01GGKBDWzsOqu36/FHqg?=
 =?us-ascii?Q?If2NwGAysJJFS1hxKav8B/AvQs6ZNxszkvJBlKL5EplcIZ4jx9aVodWeEvk0?=
 =?us-ascii?Q?BldJD/znvMcS+iGUIQmi1DchwphHvk2ycN8ESx1uOPBVhNMkRsqhRYI4CJiC?=
 =?us-ascii?Q?jsP5aXQxbEJFxraHz6XMNwTwupwo9/C7Sv7ZkJDzbn3tz/R3O07By/p2tSlh?=
 =?us-ascii?Q?UaoBotPkRo4J5Oh5efSmcR3Ws8mrTId0fyCGLNtN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13e8c92-b75c-4bdd-bd29-08dd161d66e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 17:42:49.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7REVsa9/1wA8xXN7i3Kp6+8cKx/kEkxTaiMR4ITr7o03cm30963kT3y3XDQ+1ki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

For architectures setting cpu_dcache_is_aliasing() to true, which require
flushing cache, and arc, which changes folio->flags after clearing a user
folio, __GFP_ZERO using only clear_page() is not enough to zero user
folios and clear_user_(high)page() must be used. Otherwise, user data
will be corrupted.

Fix it by always clearing user folios with clear_user_(high)page() when
cpu_dcache_is_aliasing() is true or architecture is arc. Rename
alloc_zeroed() to alloc_need_zeroing() and invert the logic to clarify its
intend.

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
index c39c4945946c..ca8df5871213 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <linux/cacheinfo.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -4175,6 +4176,22 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
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
+	 * arc changes folio->flags, so always return false to make caller use
+	 * clear_user_page()/clear_user_highpage()
+	 */
+	return (cpu_dcache_is_aliasing() || IS_ENABLED(CONFIG_ARC)) ||
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


