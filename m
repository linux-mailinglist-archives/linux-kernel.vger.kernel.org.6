Return-Path: <linux-kernel+bounces-417344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89D9D52D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF62281FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DCF1C1F3A;
	Thu, 21 Nov 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A3/06sLp"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709D1D47A3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215163; cv=fail; b=DTdZWJWhJ/Bd9Uc8bSeP5jcA/2eC0dMu4a3eJMKdW7NgcmKgmm0WAI4v9vSe3TRyTfaCGxT6B7Rm4Dy3XL6Z3J5TpQDjmbc5oHC0/oTAOmuWH+xLOK2Yg/zSP0lraNKdHjolUPMlP/Dq+f4LSxSzP2RzgTqP2x8kVUTigrxyPvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215163; c=relaxed/simple;
	bh=Yy+A9Yr+hnITc6YKDbfa/rAKJzyPwCc8S+VelwsesI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPm1suV2wqrOzBqAff1RHQmBg9UReollwri6TLBg6hm6oPfJp802LHsXlXgL2RvbevIOHQo25krxVchtflamqbs0/7GBGjwgj0VQ1IuV4KQlxoUaYxtcK6GL5aTo68UwGb5mNc7sYvHZzo96/OWmwhCSC3w1/u3to347R1Cb2lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A3/06sLp; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmALoBOBwuJXwFsYxXtrj73eSaJGhhqIl2AYd+2rgOzBP4h4IlOaHyzWAZn0nRciR06JQna9VourxylGHurVQG/iTkuG5OAc+NN5tV58WNt4fP7v8lq+m0af232zZc8B40Hd57cEKD1T06y4N4YBh5ZiUEDAXcyQ0mYwwKIArD1rCxSu9XEHmhekh11rubT1Wtyza7T/42LPBTIViamTwW6yX3PUnlyMYV++XjSeTkI9D/Fmjp5Hmfe2cMfvrHYxo2kJuM2JXyB9atmlRjq+ag1ziXuOf70rmfiMANFawEnwIxb+t8tF3UYaBdYCBOjsQhZdj/6RKCen2/oANTgE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0CJZaAm63MVG5+J1rG+OLe2VO73aCelqREx4pG3Mto=;
 b=CyDgbN6NBjRA+3XW5/dxRMm9HxKHqPr1lL38M+W+u/0aUNia9sjn15dZQbXcIHP5sSCvoVrv5bz08hwBqaodTEMfPZLbYTulj5BhgK/Y9xLdV/Lbclw7GT9fKmHh2G2yp0Cj5CFwAXQykSf++FNv9zt5Y/quKertnsm9rkQzn5phpPNh2MxiJHfZzqEyWmALIXSu+PkzPf/7+5wNNR0TXP5QX2qKnr6QkJ51NE1VcpgjWnqVhSTyvHuphNs6yBXycaxnLc40Huugv+gkSMyNDNP3LpUb0PUgkPVgYO8yqKD9JyJPY3PKhBwNF17lmkljtRhVmOHYaHAFvNLPlC4AlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0CJZaAm63MVG5+J1rG+OLe2VO73aCelqREx4pG3Mto=;
 b=A3/06sLpINui42nZaVyXDbXMQj/U/ejC4kqDlDn2M5x5nCq1a1GkhtQolfHg2vw7q7fvDQfIKlA+lJzfwrGpyLf4Z4ebhd0gvVJcfjDE32kPwgeXBd0DBhgcMed6khQT8K3FxhwfKXWFM4qFvJmFgQIggGcX9r6tuiEmZdC267MNaIjBDW/gZ58pUHJm243dYrnrSUnlcRTZAZX3IzX/s/OQNPdxl71CcNyeM9duiFbJYQOcAr5eUHrgEhO5jvgG5bXUHp9Esl/HdjrH9HaLc5RFSMOfTSLlDTDgj2/zrB9UH2UeC479sQQPO8xsHA9Fd6vIqOQtZqAF+TalWxIXaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:34 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:34 +0000
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
Subject: [PATCH v3 2/9] mm/huge_memory: move folio split common code to __folio_split()
Date: Thu, 21 Nov 2024 13:52:13 -0500
Message-ID: <20241121185220.2271520-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121185220.2271520-1-ziy@nvidia.com>
References: <20241121185220.2271520-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 270fb2ca-224e-4c6f-a130-08dd0a5da8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IsXydhsNooxn9h5at1A1xmgeswTKANPPvUdk/r69MEhU7lyRShEWJPAPL9MI?=
 =?us-ascii?Q?XRbM8/pFEhZYV4rBVz6O0gDwwGHhGmmXSrSeZBxRaK4JfTNp8uCPwQptOmqx?=
 =?us-ascii?Q?fJVCLEPbwoZnrH9FLVky0aHMXafQB22uPQvp2aCIhEsnZ+dia3suSKaEQzbo?=
 =?us-ascii?Q?StNsoU56sMYif9X0wXsBPkTQ0KbmFNUuJLNwPM7kpkowDdfI1RFmFi+EZ3Xx?=
 =?us-ascii?Q?J54tpSAoXH7q39JFQtZVs+HojuyuJmltS5CyFce8726vapaXiQ/aFU6zrIFP?=
 =?us-ascii?Q?2WmbEecYMU8kFlv+hLYE0lKYjr6XdAsBHZDGOP4wEZB6Un+4PMzoeqnZ5Sff?=
 =?us-ascii?Q?OwR5n+arpQ00NyjufE9m2UsWtspaqg6UalobiaFXce+YiueATp/lFSB/0jeG?=
 =?us-ascii?Q?fhmRbMz/9ZUtvF2aZJezbVIQdsQjQU7CJLaDg5R4c1xOTF7glbNp8U948T6R?=
 =?us-ascii?Q?hkbOW7R+jidprcDiwYVHnxRutqt6rt3DIDvqFltwOcXQp6EVKJWW/WMDGKUS?=
 =?us-ascii?Q?zSBUauwPdeyMpdjZk/qQ2ry3/czQ2U/tB/7PGwM9kFqMRMYHFEp5jYHykuE3?=
 =?us-ascii?Q?tljTiIZezexb0JXVIZ9cElAHB49ankNON07cwCgiZ1Bd3dpbYaa/H9Cnv6So?=
 =?us-ascii?Q?uyxu2u75cqfP/1lAeokjsR8WZ3hf+dHeNTr+pAwXl93I7ARGXbFo7/kXwJhM?=
 =?us-ascii?Q?C6HIJdpjWNH8L0F6VdU5TsuBUERFGZsX26BL+O49W9Dcq9c5Qqv0b+4kdM+l?=
 =?us-ascii?Q?JNontc4DQNdvpJCpvKCFOvEpeObqyfMCl8Lks0acFj64i+utZHOvFtC8CjRO?=
 =?us-ascii?Q?Ob1NoATaDTL+spyZ1Uzk56km3z2EneDMJ+GrWSexqyjb/5uWLYb3C/fk2wJK?=
 =?us-ascii?Q?BxBrtXHRoaX+6LpEsL6Oc05a42Vnd2slabY7nwGleteRNQ4m1MCiOALzkhBn?=
 =?us-ascii?Q?8Gbf0phAil2SaRsfkT8ehKX28ig9nc8FWlsbn3mP2nfioxkMKtpj3anxNpVg?=
 =?us-ascii?Q?tVdKKK0wiPmIYHgvKy30SRWBUwjFqJfqE/Zx2ZgMkQWhOYoNUWd7AYL1gXPo?=
 =?us-ascii?Q?3/w68GAZaAB/ilBNdoYc05WA0NcMgeThxpgusLcwHOHR9l+42g+zWEcdkMXq?=
 =?us-ascii?Q?B5CMPJBwL9OUXKbBLC3YRU6xWxuQu7soBlu+iHPkY6ksFoxGitDhD/L0IoCe?=
 =?us-ascii?Q?G9dPjHm0mzzQi9cHNhMX3ktRHnUpdq8oX3/2l+8h6SDkwjkQH2oKN/6BKBAf?=
 =?us-ascii?Q?d2CIH+4JAi4+V8mjEziuP20Jaqlb96gP98NzAEKnKPDSRHrhy38jdODI7o0e?=
 =?us-ascii?Q?/2wZWwcX4BA+xpFF2A3qOKC2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLxyvPAbo0JHzTWkFI0Eut8ThgF0klLBl8Q7ymJ0EYGo+wEexjomTgidppq3?=
 =?us-ascii?Q?/Xg/JHsyiAqS6QbhlDuBO07IedEaKOZe4a77G/Iq6GS3uI95hW9mevBy6mHY?=
 =?us-ascii?Q?M5jxxCVXhTHGPKlYabdVmv5zc0ktx9CjYKn/RlESiRpX3fV4+i6kcIk2J603?=
 =?us-ascii?Q?2BG0AKrI4aPpehK31uuEv5usnF2TACSxiNvFASpn9kmaNIklxh8wjFGU5ZF4?=
 =?us-ascii?Q?8bhV87ofxBQ2RImAaI+iV0xhWdjQHRMgGMDwvzlSrcuFrmm8/OHOxi7CgJww?=
 =?us-ascii?Q?aGJX9xdUfB+X06ZqBfRNAxDZpJJ3Le9/+3G6iy/X+mzJOmZjQxovt060Xm28?=
 =?us-ascii?Q?phIwoMr6eVZiG2c5Bf77fRysDDFwihX70UczFIXTIQNpBlHhibJuhQQ42bIh?=
 =?us-ascii?Q?CC8qQB4hkjoDUxx2RfvPKWk5j0vm3xpKQNbhux09sOBNfaV9II8mBkYzUucX?=
 =?us-ascii?Q?berPGM1xZbjGzTcHzt0xGVURDf2S6inhts55mObfb/TRYMBpggRJ0ro8TzlM?=
 =?us-ascii?Q?+znNpqXzlenH1C9q+NA6xUAnEroEeiSkHI+f9srzs+PLvXGaz5l1wk1L31er?=
 =?us-ascii?Q?wPlRQySI4rAUXiqoYlDHkc09cnoG9GaH/HQNyI3irZjMxRZ8kKaEd19puz2I?=
 =?us-ascii?Q?Ps2KUi/zw+RMqNk0Ip4TIjmWrruQdB3pYEt9CWghvcxDtRlw8W/cx+lXkbtH?=
 =?us-ascii?Q?P4iTwKTy1fpjDX9CduTMN3JsLtsFZJzI50XZ9WsDfi5/KJPVl4x0GVTZkUsf?=
 =?us-ascii?Q?bzxpiUQNIR2JfzRm/nXQ069ufRC59HMahmGcqsMXrJAhggeYsW/0lhGwr66c?=
 =?us-ascii?Q?qDws1+NVIEIW1uM3mMlwaZIAzjTReW42K4pr9y/XnJTtguK2Xplfref4sFl7?=
 =?us-ascii?Q?pFDIQD6gD2kt+HOPp9AOsNCTbHO6QXZj2MN8QcLRRoagZTNkmBkV74z2lpq5?=
 =?us-ascii?Q?rIadTD/CxFvJHsURZb/O/fl0DAAK+lvBh98yxh1jjVUqrOojuiuupTuOX/ph?=
 =?us-ascii?Q?VmHQwVtbwR9tQ/iykiitesMFBpR4848d+COb0Q1JqVOfhmjwvH4I7RQ7nwat?=
 =?us-ascii?Q?TndYYaCT5M3NblnIid55PmgnogwYK6VVID2VjmQGhiFW6xS0nS6P+l/NWYU4?=
 =?us-ascii?Q?K8JLfaBvHx+of6k6SP41xleqcEXlnYLz/yKQteRx1mQLlGRtidsyouEqTMkA?=
 =?us-ascii?Q?vSlYPvnxGHUsWsXRkp+KrjFcN+N4oH3CNTeNIQAHgmE4XRAgm+6bN/2tEGq/?=
 =?us-ascii?Q?k3D12Ts5L/xrDfxxVa+kVh6Yg1lgLTof/s2u2uZh6TlDRhlWgEO+peJl+6Rb?=
 =?us-ascii?Q?ZiTxbGg88tHPi2/OWQoFBDaXLSjrJkuHDBhoGIlr9y69bzf/vNwqUYG+GHw1?=
 =?us-ascii?Q?08hYy8rV4DzfmaR8lhhwkLGH+yDZOX5nfvfaRsvJkXqn+qe+7TfUzGDISrAH?=
 =?us-ascii?Q?wpe6M26QD/1OTinY/6q1Lf+5cpxWx3bkKCaVZbflXIUMkTlu1Z51WFQcavoA?=
 =?us-ascii?Q?K9TwP+We3MGusewqhK8H/d7cMaRnankNiKPzJHV6w8stnaCcmMrISnVBY7iG?=
 =?us-ascii?Q?Qy0rklZOE/N+0RNFiOWsS6SwSI98PC2sIN/Y2xvt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270fb2ca-224e-4c6f-a130-08dd0a5da8ea
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:33.9765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owOOkHLeKAoXCOvfnwkVxHK6+w0sXl5ofZ28Ieg0zUKY54Nwr/UWzIkpfXfZ0w+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5ebacb08996c..65dd2a383e29 100644
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


