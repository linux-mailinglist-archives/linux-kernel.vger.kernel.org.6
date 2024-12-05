Return-Path: <linux-kernel+bounces-432423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE499E4B06
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22D118801CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84E179A3;
	Thu,  5 Dec 2024 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Arg/tCuF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDCCA6F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357934; cv=fail; b=tkvZWcAsCbfYdkprs4bElH6Uj474cxhT2TNm3Gb/+eyRdofTIKfbsfKP0qmXkc00XQgLWpmCjut/53nRJln0leSQQGIctbGDEB/o4v/H0+6toSOtCRLnPAdepRJvcWsCLxJTA0kcUomoajOp4nu48yUmX+qZGeQ7SkrpOE0HkA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357934; c=relaxed/simple;
	bh=cGT4fU8ZELI6rDiz2bB+XD87OGIznaDgdG1+uz51mnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kspT6GH9ij4xeueaKEY6g0MF8gMYlKzJATI0Z1NDise2V47HcH3Y/Kd1pwSKwz/20YjPg1MnkJQSQAp4+3DnLkB2dbxxV/x20unTB4uJhKFv2XfLFnMffciXD6Y6CuzLbbpGysjnTIVnzHfxA73R+rLwPYdGjp+OtKlyptj13Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Arg/tCuF; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYAxkO5X1ZpCnVGef2IYXN355Vc51xdVwFcK2UlggAckh9Nlc979K3crexg9mhP44hl5SZMlitAg+vJFIZwIUn3tC92EIdoZWHMiMSvmQmfMq9esw2vFrgJd0geKWlU9Z/GU7WwcqP0vA9w9NVm3r3cFIPC93dIHMcq1OPuM8mTo18HE/+ob1/bjFpdl7+TgCKFNGWUWo/KpIauQClBX9ko6CEqGWszR8KoRNVeExk2IzOfreqdvthRhLYjIq2kxBImGCElbjf4A8HcPP4hKstOp5w9Pjl3ZJ7Y0aQNSNuExtYf+V3MNMzk47lj6Nyr8hWvYxTxpJZNoQHivEuDIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3FI5qHRFlXzJea8dxSObFOP35mYmvtNR3JUb0l4oa0=;
 b=yOdDw4ZUpPXfPA9z9Bo1QrWKIyLY40csLJKk9wbYTA3VggaIiYxAXd3dPHUSASuXnqvbu6F2h2B5ib/zPVNHT348kaREIU0gOACEGDsNPot89If/7Xzgmio/ZEwI44JvY86ehaNu+3WblNfg6iO9BbsD+yUEKTE9Pcc8BLmFQIXqS4L9DHTx/e9FKfh88uGm2XKdk9GqANoNs5YP1DmcKdvyeFUZtdA3lNF1vYr4vXphpYs5TYg7GvEh3ccJas320T/NdlGZaChEUI2f8oFOqTL/+XjJjBVGMEy7CU8wlAngQ2WPeP1FB4pRkNd5NNIHNin0hlyjhsbArK0PaBVV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3FI5qHRFlXzJea8dxSObFOP35mYmvtNR3JUb0l4oa0=;
 b=Arg/tCuFbFCM8LjwI1hy42LgmlnpJC96nx+vYnN/SqZ8WtMrJ5uEJvVAnrwWFa/Qz7s+gtTDBWh9JTU6cg1M6lBdJLLdS+AE2//aBR0RX4i+XSwgqs8BQyM3E+d4yF87IMvr7DRqlT15PtGak04ClyXsnYYPOak2evBZCBeCVJiY2lj19HsBLN08AiM2vupbqmqomHjj4sJzPpZdEwnVyVR9owQxgIwFVmLXHfTolPJGQpSn2jJdlAHKG4us7g/Q/WlYg+yhFv8SD4J0YsNhRiNtpgYMxEDYNBkE57KnXvcTI7aSTAQnz7oi5jHX/a5pfdBphJ1SBfkrqjWCVUF4fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:45 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:45 +0000
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
Subject: [PATCH RESEND v3 2/9] mm/huge_memory: move folio split common code to __folio_split()
Date: Wed,  4 Dec 2024 19:18:32 -0500
Message-ID: <20241205001839.2582020-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:408:ea::33) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f1fb4d-54d1-4876-80c8-08dd14c26200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1QolBZRmmAEHgGrtorOG8B6yOOdrb/VPCJazNbulkZaYXmPCGu94LXY+R+Cw?=
 =?us-ascii?Q?VWOCkJJ1JjMEm2ub4jbEZYe9y+2e6uxlIs/k5pytUl8Dg1P9chelq0zC+tAl?=
 =?us-ascii?Q?J9+iq4PTQ/9qNQ1KFGylwL+Vuu55aqwuQn0GANb2XxkyU6o6car7QQhGI+0P?=
 =?us-ascii?Q?7tfj1D4ky6SqZf14JAis0KIvSUz88uggHjmi7qSYGA5mBsA/iP603T8J8MwA?=
 =?us-ascii?Q?AzL3Lk2hMZ89hhoo9g5JVqCcTKva+NI5XCey6hM75ya+Z+uLK4CTpG586iHM?=
 =?us-ascii?Q?AIWXfLS4bZbhkHzwf0FxZ82bZ0ovBRYyPhA8ETf5XDiEkNc6HFvcvjP24SMf?=
 =?us-ascii?Q?buzJ77Ri+u5O06dtSyROvA5D0Ag1Sppwv4OqguWle+d7cUeKS+6MpqFNNaBq?=
 =?us-ascii?Q?5qFkv7f13ljFbIBYT+kR3HitYcN5r2LzsqkIZi0RdPgJD0zmDcl46W8sb2N+?=
 =?us-ascii?Q?5iM84+oJdPIqB71dvtUj+DnmJkv1GtEpu83wDoveTQBoH8zqUL78atE+Wstg?=
 =?us-ascii?Q?RhVz45ha7J0spEMQWg4uRyUmnpBN7wkr2rDS2ZSBaPO2DGfP0ITgx46/3Zz9?=
 =?us-ascii?Q?KKFUWpQ+UwPFquOjw6vgOvDDa1bJBuYzwIRVS0X27gZwfPeOnOaxP+WHeJ+7?=
 =?us-ascii?Q?QHDVQ3GIxk5m8kMwveyF3FAg8r9jFbqKPPAdEEhkm2ambpjpXtQU7+GmnMZq?=
 =?us-ascii?Q?R5vsqLiq4v8a2xuMYJfgaVGUlk546b2rDZLcexJoW98gDEZOnyxYQw2E8VOv?=
 =?us-ascii?Q?VaounTr1frDS8H1X1NkFAxrKAplNaPrP+6wWgELJgkzvibZJqjDtnIzed4L5?=
 =?us-ascii?Q?TbMqQPAg29APw9gU3QY2xpw0b8Hws68RuRyhOQrk+8uOaawAzid1sb99BC8l?=
 =?us-ascii?Q?MUepQcdG4cnrBCAFdX8JjXGig36pOYiEiCXQAbymtdbN6JhFprIID6UJgjm9?=
 =?us-ascii?Q?x/SYnp/nWy3WNh/1FhQaZNX3SJOxC9EA4pa2L1/Y7wWbyNUzE8xNAxfIsauA?=
 =?us-ascii?Q?mcF+QqEFRqDc8PyrtOTOydqOAVCwHgWGMc1Pekeqcz9HL5hnIe7V3qgegGeL?=
 =?us-ascii?Q?sCYRuESSOPdvDSZ+8X9RZTcbobYiZrv7ijRWW9Debzeb8v4fd0usP/aHBTok?=
 =?us-ascii?Q?q+o6/m6Mg6DpLMIoKScGO+/BasAL2st7cyXq5G+4TtvjPfyZRD0PxqDuH7NU?=
 =?us-ascii?Q?G6jv1k91qHKWdRmpOdzXQL4pxOPJxdJnKekxwcPFIboI0TLJTiSqmtpwymCC?=
 =?us-ascii?Q?1Y5vutiz1RDOGRA8ZWuDkaKmoI3uAQcIYaCF9JsNfg+gnOe9ML1x9BQ39r0r?=
 =?us-ascii?Q?7EJen4Ba23jdeEWk/aCkD8dYLHRENgC6Sht7/8Wkye2nTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Jf/1vSd6GO9UXzUD44HeU7v16p5gBh1Dbf0E4ug2pAtGfeZHlPvwGudrDQ/?=
 =?us-ascii?Q?9FkMXpdEzx1d7zONNHtoiFHgJbvYBnpfJSmTpaGP8lNR143rlONjFZVym0L4?=
 =?us-ascii?Q?JOLGbl7tVOkNQf1x61LztEbtOEZDyL5PPOkW0jxRRJzWKOTt4t9RuYFJ+CCW?=
 =?us-ascii?Q?e6vaWvYy1/0wfQ/DOWsXpVZ/43HG2Mw4x+FrAC3GiJZ6y+fDOCEaxGn4sdlh?=
 =?us-ascii?Q?7Lm0DjVsi6Qfc9P9Qv04nXVrfHKwzUysCl8ESJljbzK0xom7YGC5I2a4k+0p?=
 =?us-ascii?Q?wDSZVEqPGFwcpXT0SzF0QC8W3EsE3u3QRPNFf0xpXCRWJR4h8vnqmFP57Z6i?=
 =?us-ascii?Q?ahCHjH7hBtWOa3JQoMRrqi94KA99Twpt8QaMlRcBTB+Q7cL+l0Jo9oY1JVzZ?=
 =?us-ascii?Q?iEMjEcKl4nKib3aPPg7bf2hzSkaVtK1+xsnWPFM9dum6rpmM6O1a47CDKSL/?=
 =?us-ascii?Q?RTgmqrDPjn9dT2ax/6VW23RYtwkUbFGdkE+/8ZBKzzdrPDML0cVYKPC1K4fJ?=
 =?us-ascii?Q?iwRqCxBelRcaE21vnu9n+jr0lm7vGN+8ZS5s8dLhF5p+fnMFP55BEk41YvC9?=
 =?us-ascii?Q?GSmJIcf8ecxBeYQs9lV/hovpJLXv++1ZIFBOnOqwG/mz/dJAut7+matmHpZ8?=
 =?us-ascii?Q?5Gt4u3ToUP/2XKxCYlL6EX+jIUCzZMFqR/yFrwh4hRdAv9fALjUm8YRLYm0A?=
 =?us-ascii?Q?cQdxyCg7gJzRkkXehqQa0Ndf7nMGQOy+q9ZKIn6cn8GhDyPq8UMvTbJHpMdZ?=
 =?us-ascii?Q?L4dyupZlpGzGnbSVzNnmkMHiSxTxUA/2C0QDWsBxl90l1DAnvMkYzwVQjJhy?=
 =?us-ascii?Q?o09xV1uKbch3ghCueMNFLQj25+Q5QFiCGJvwZqO9JbUcStkk+VX/iUGMSAJj?=
 =?us-ascii?Q?a04YL4GatSy8P6cK/sQMdgFQHOvZjr4G6YsHI1ozxBMp0dG4KDcH1z4fUTMq?=
 =?us-ascii?Q?cqI7KCZ96vpcmjDT8k2whBQdb7wad2RUDIkN49l8cRSAf4BBg0lipqsRz5s1?=
 =?us-ascii?Q?9XM0Oc9mwQOsbGARZXrTrencS2T+IrWU5GqpBTlkKqMWGjp1UQ3l2HD8RcMX?=
 =?us-ascii?Q?z/wGOwOD2/ZHPJdcycEUbfPjyzMoMH/C9Z/u3bLB4H1BzBtaMVRL6pefZ1R1?=
 =?us-ascii?Q?WzioJpeTnJeKa7xB4y8OYTQdrnSoJwYQvanXXMOtWvjL1r19q72oahj/DLm1?=
 =?us-ascii?Q?bik0g4ZvioCJm3PaUdnjX1CaV16qy6NXZtxX5fNVm3QJuxcYnFkmI8M+pdd1?=
 =?us-ascii?Q?dCOw+fg5XfRJGgcbGQBIMJ2GcCDAMJ1VnHk9Ug11l9nDlZ5M29qtrlvXPEdu?=
 =?us-ascii?Q?9QRI1szOQKRnjKALuG5AqNYB1EZWCzU0mJVh61oYJEF/Ev0xhCytKqry37Ej?=
 =?us-ascii?Q?AxdbexMhO+JnZmW4p+hWqMILzOVHeSbh+I2bmrcYjGhHZrvNy8Yc3+7ifR6/?=
 =?us-ascii?Q?up2UFAWwpx//vzizXU6T1CM0/XwaB5DyV7BeDj1VhfF47lbwWRCyOuLsx0ai?=
 =?us-ascii?Q?WK6HTL5Dr2zq8zKTBX8LqhTqNGe0Y6jDe3o8Q/NjozCGcy3riRXxPim+XBdN?=
 =?us-ascii?Q?d1a9eYH2v6e3yxug4LCEsTBZcbR8LNsDIFfnsVhE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f1fb4d-54d1-4876-80c8-08dd14c26200
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:45.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIhU24BY9d6ANMjCa8XUQ9wvRdxYxMQ/vVBeV6i3VAKXVLyk6k+Ts555wfi0eDzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0cde13286bb0..e928082be3b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3730,57 +3730,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-/*
- * This function splits a large folio into smaller folios of order @new_order.
- * @page can point to any page of the large folio to split. The split operation
- * does not change the position of @page.
- *
- * Prerequisites:
- *
- * 1) The caller must hold a reference on the @page's owning folio, also known
- *    as the large folio.
- *
- * 2) The large folio must be locked.
- *
- * 3) The folio must not be pinned. Any unexpected folio references, including
- *    GUP pins, will result in the folio not getting split; instead, the caller
- *    will receive an -EAGAIN.
- *
- * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
- *    supported for non-file-backed folios, because folio->_deferred_list, which
- *    is used by partially mapped folios, is stored in subpage 2, but an order-1
- *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
- *    since they do not use _deferred_list.
- *
- * After splitting, the caller's folio reference will be transferred to @page,
- * resulting in a raised refcount of @page after this call. The other pages may
- * be freed if they are not mapped.
- *
- * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
- *
- * Pages in @new_order will inherit the mapping, flags, and so on from the
- * huge page.
- *
- * Returns 0 if the huge page was split successfully.
- *
- * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
- * the folio was concurrently removed from the page cache.
- *
- * Returns -EBUSY when trying to split the huge zeropage, if the folio is
- * under writeback, if fs-specific folio metadata cannot currently be
- * released, or if some unexpected race happened (e.g., anon VMA disappeared,
- * truncation).
- *
- * Callers should ensure that the order respects the address space mapping
- * min-order if one is set for non-anonymous folios.
- *
- * Returns -EINVAL when trying to split to an order that is incompatible
- * with the folio. Splitting to order 0 is compatible with all folios.
- */
-int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-				     unsigned int new_order)
+static int __folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
 {
-	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
@@ -3996,6 +3948,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+/*
+ * This function splits a large folio into smaller folios of order @new_order.
+ * @page can point to any page of the large folio to split. The split operation
+ * does not change the position of @page.
+ *
+ * Prerequisites:
+ *
+ * 1) The caller must hold a reference on the @page's owning folio, also known
+ *    as the large folio.
+ *
+ * 2) The large folio must be locked.
+ *
+ * 3) The folio must not be pinned. Any unexpected folio references, including
+ *    GUP pins, will result in the folio not getting split; instead, the caller
+ *    will receive an -EAGAIN.
+ *
+ * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
+ *    supported for non-file-backed folios, because folio->_deferred_list, which
+ *    is used by partially mapped folios, is stored in subpage 2, but an order-1
+ *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
+ *    since they do not use _deferred_list.
+ *
+ * After splitting, the caller's folio reference will be transferred to @page,
+ * resulting in a raised refcount of @page after this call. The other pages may
+ * be freed if they are not mapped.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * Pages in @new_order will inherit the mapping, flags, and so on from the
+ * huge page.
+ *
+ * Returns 0 if the huge page was split successfully.
+ *
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
+ * the folio was concurrently removed from the page cache.
+ *
+ * Returns -EBUSY when trying to split the huge zeropage, if the folio is
+ * under writeback, if fs-specific folio metadata cannot currently be
+ * released, or if some unexpected race happened (e.g., anon VMA disappeared,
+ * truncation).
+ *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
+ * Returns -EINVAL when trying to split to an order that is incompatible
+ * with the folio. Splitting to order 0 is compatible with all folios.
+ */
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+				     unsigned int new_order)
+{
+	struct folio *folio = page_folio(page);
+
+	return __folio_split(folio, new_order, page, list);
+}
+
 int min_order_for_split(struct folio *folio)
 {
 	if (folio_test_anon(folio))
-- 
2.45.2


