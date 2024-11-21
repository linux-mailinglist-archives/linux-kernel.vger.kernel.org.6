Return-Path: <linux-kernel+bounces-417341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90B39D52D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9DDB22CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359101C232B;
	Thu, 21 Nov 2024 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qpMsJ5T8"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A973139597
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215158; cv=fail; b=NfdATNDUjlVImYEtM7V0L36pzVHCxDDSBzL0/oWDiTCUVZ2yJeZEZSVJ5nWzorv7fLPZCczIIOfW30j3jFdiBAialtIbz5zhL5X4m4ESx110ERwfUj3KYlgX+EoKEu4iHByADuJIoEEj81asfxLJZYXb08myRdlrgAtZQF/dr6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215158; c=relaxed/simple;
	bh=rQBeSIocqs7+slHhTdCQx0+6U54IroeMv+3voVcjyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GOQEwZcMAn/sWnPXAMj78vVKfP2t7EIf2KIS7B+6C/k5V9FLftCk2xYSX4fT0/QHdcdW3aX959X2t5cF5hsskBiCmwyy36pzDFAtQJ9oS8UnaIVsSV7iXn6Ejv4Gsn4p9conOWypoW8yYdh5XAzPNrVx3y4k9DBMLg9+qUVMelQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qpMsJ5T8; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xhv/3On/8Lj26N+4NIlLVr1ydm77/GSUa7QheXglqFoLd8/v+U5E1wDyk3e9D98Y3B9oC0q9hbPST7lEDTvK3ck42f+yo7FwKGDo4TepKsLZ4RN3OY0oc1M7lPOTOyQt0Nc8lpYYWnA+QdxVqfZVfDOXRUUNW+tVuuw7HG4X359fjiXNExZ1iD3aS0YgJaca6lT6O66Gf9asduyV3ASwSn3iNxyHBcQAlH+lL9vuxp1BZucvEgFtlNtZ7TEWVBh95UXGJ1jzn//xBuDlB8MvtuKS0Jo5Q36DFQl4JiAjrPfqR8kJ2H3aWRvihrd0VPeUW7FKQ04BRtbxuZYRp+Yw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPaL1BrpBVSQ1ifQHLL+0E7K61676uydazJGadIovFQ=;
 b=vbLoSGYQNc3KyBMFFlQOLm3tq+r3deih2wFj+VMfWHEfHebbADq/RflQ7tPX095oFI5vLHMTO7Bf2bxsfdH6dTJYwlWoAIumTvaodrz3z06obkC3lsy6nkS1yX5Y6Lkblfzd8mQOwDKS7pSgg68MCRCSfTgOjSuUK/fKZwzCW3LHTmdnr2janM/yb0P0ir4x7XSJEbf9xu8fJgKrQd+zdS2+dJTDqFHJqO4KwIY/5QRcVFYU1ZDx4m8UiV1EmXlcayH7IqXSoy9GrPE+0c4e5L+S5ncissBYEMxB8/HAs1O23rzciBe2o/zqtOpHq3s2ugmu/Q1rhhLrwp2uQFnP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPaL1BrpBVSQ1ifQHLL+0E7K61676uydazJGadIovFQ=;
 b=qpMsJ5T8KhBvhU8Ub4cmnn8X7KdN+4l2eSXWXFJvuOs+RO2yC73DRSElwt7YiYp37MSeEsgCCxaNyW1Fy7Tmvz/mbGzR8J+/F/YwJXEy0PKD8vcwSc6CJzt5bRnmnTsl5MPIdhlFpduID9gCD0wNQko10Fyay259uUWq7BpxoS6txySR+ER9MEXNdMTu8LIarRh3mMT5Mb3QKHraiCYIKi641D3WsBFoHfPjEiuGcPX8Nok9XCR4XxRY+zeMDBeWJFlVtg9iKB6bn5KpaCTu+ry+3L8cRORBe4S4r8xnm/xGd7Jr5Grnc3091ByabLo3zLIXlCsCDhAE0oS3/DuvsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 18:52:32 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 18:52:31 +0000
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
Subject: [PATCH v3 0/9] Buddy allocator like folio split
Date: Thu, 21 Nov 2024 13:52:11 -0500
Message-ID: <20241121185220.2271520-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-Office365-Filtering-Correlation-Id: 11d302f6-36cf-423f-79b2-08dd0a5da7b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p5GIRQkMINhXElfWrRyyQhGroGTGp7z+V17tu7fFFU9roCYcmscffJVDSilO?=
 =?us-ascii?Q?iWTH3Ut2Na+d0Nt45guc150BnWxhVsuhx1Wb80iE6ZOhH9O1dkt2f4AG3Msz?=
 =?us-ascii?Q?KLOzZ9fpGLPY0Qm/05rvXz4nhpigBU9XSfbnnobTg6tG6pW5to6EvIvPOHxC?=
 =?us-ascii?Q?NPfgEDfPktdWcrj8OLPlfmouRqPb1KqulR7zYISWbcYXZVEmqgsZ3r/sxlxY?=
 =?us-ascii?Q?UML18Dhg4un+lzlvd0L/j/BWVBLbdv4i8DivaB6rPtpQw4WSAPBRdcLKstYm?=
 =?us-ascii?Q?IsWsAowYKOL+ItP84UhwPpo4QgtBkmTzTHawpEywvDskicPqWCwotDbP3YFs?=
 =?us-ascii?Q?7VkJbJh0ZORzYeJE2ifEEVpLFUi7kGlOlj7GgjuLxdbhcf+Fvok+zbZKzg1+?=
 =?us-ascii?Q?IjT0GhR2W0dx0GEgS6InooMYG/MnVKVamNSRMC7iGe7FIOk9i+KaGmJjhYja?=
 =?us-ascii?Q?ja1cVt8HTdrH3xPb6sLakZuhXrwxlUGkhLbRZ+JBJ397DLuZAnA2cwl3Cdse?=
 =?us-ascii?Q?1OKhRocuPa4TnEU0RGKxygftOBt6yiBDO3WaF914DVTXP1ywnQ52YYJqSUPy?=
 =?us-ascii?Q?XLjDZ18Xad80jUzEMHgEJOXVfDwNe8lwoFtDjBpNpMJsYKTrJeFZoeXNo+xz?=
 =?us-ascii?Q?xexMtXbPW/GKsnlN/HWWShR+TMpL0rvZ2fKceBA447V8Alj7MKYjo8o1Z0SJ?=
 =?us-ascii?Q?yspJyydMJQ5D9yTTGavcrXt7jOIIgM0X/OcUdxhK/kE43kqDhx6E/ICzIXPL?=
 =?us-ascii?Q?ITCKnXyDK/+OkwpPztkwrUnR7zKjWWuAkK37JArnNdg0FKR5CtXQ41iVeRle?=
 =?us-ascii?Q?HTrpDsqELS4UbrCUkDzyteQowaM/Erw7/GeJVVmCgI0TqQjcvTxSgMT7Tkd6?=
 =?us-ascii?Q?aE6yXfMzxMIkiT6xvDMGF02JPJPbW1cEkt9ePbWhmY6fIh4W7jgDCTVFYPjE?=
 =?us-ascii?Q?iyc7CZdOF8+D3/6TPB6D23J5BUAYP3QkdRr2xfkzcFuKOpTppn4/6S3lKcC/?=
 =?us-ascii?Q?EJQcsOU4olTmrZhA4QAWqJ/ZPgOMRe4oTXtOs7saxVqk4xyqeM5tPpyhGHb3?=
 =?us-ascii?Q?1dJWHcA9bQIQz9I6pHIWsR0k9JFAmXPhq8n0ISSFJTEDyhvFbeCTRhcTPoOF?=
 =?us-ascii?Q?HFoPD1wVrOcletZS6zZMWtexs5HoWnxNpn1YEZ/rdO4EG4UszCBuegY9EB3z?=
 =?us-ascii?Q?lz/6x5x+UN+nLEtDeRfO9i56db6Jx+IURy18Ok0Dd4UGFmA+AnOY0csfp3+L?=
 =?us-ascii?Q?VRKmbO/5p2cPLfaMCJPM+58bUH1VBYjWEnVCGcexenBKRrAtXDz4DDDolaSB?=
 =?us-ascii?Q?wuo8Z5vHVvF8qfYttgQa8WtL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L70oThoqVYYmsoGiQmdVvue2yCXTfO0edycUFHcVeXNycQ6vGSJ0YCWW1WlY?=
 =?us-ascii?Q?/Dfvi1TVxgmbpjBg9GHaT4aY9GYJ8jHbxX1MbUBt0D7Gv/xasFjOcZm+U5x/?=
 =?us-ascii?Q?V1Vu1ZawT6I+h6PJdvFVI941pcD0M7ETsQs6+LQShXWVMXCFmUgLcTwT84CN?=
 =?us-ascii?Q?Yj2/LAeYqN2+EExqs65gYVSsqTo1ObgSLrYU0aIsINIcOfedNi7Z48irAMH3?=
 =?us-ascii?Q?hqLu+AV6FN5Y8Sx2WSsktxKfKRpKtnY5qdbcEgzK/pqbTPGAKkMnQX91tHGv?=
 =?us-ascii?Q?iVtNybpjpvZcy//XnAvxPjE91c+xh5VyzRg3iesVz6dMubYio4R+p/C6s+HP?=
 =?us-ascii?Q?u8hdCAazNPsD1rbxwq9gf4D6fPkqJHMFh2w0h+DQc4Ld+vD9E8f3hUutw5RN?=
 =?us-ascii?Q?uEKhUvQgRjUQWu94wOvDzgebfSe+3guyYCLpEN4WvuEDlGzLvs/w3W3k1gbA?=
 =?us-ascii?Q?ju3Dv1VA00HCoZU82phtWYgND+PTpOMLp8Rm0lFwCpwfokJ8RGZk4lJsHsby?=
 =?us-ascii?Q?+hmIhdMF6uzs03FlU3FV1wbJxdHY5yzUzWtn75+o4OPpM4v2ZW9w+/DwTgbz?=
 =?us-ascii?Q?anHVYHCOnrSdob+h98zr2kOZAyGyxZT/g7084afPXp/v22FSyt3E/n0I3dpJ?=
 =?us-ascii?Q?UR6sFSPw47KGpx79DU/uL0Jshre0hqJ1dwb02WBxOvjddcM5RWsncPDEjfM1?=
 =?us-ascii?Q?55g/tVubeUfEYx8d8byA4bMGusnlSWoXNZio6hNP9bbBn7kc70Y6JtjxweMv?=
 =?us-ascii?Q?87GdylEC1i2kJaX5N5LmhDux3tPBsJw/heHJgedyl9GLayPhB+NdSxWtRpo5?=
 =?us-ascii?Q?k2SYH+aLDj7FWyl3IxqQnGcnVYHlPyNnrZi/bspzugnLfbTMHjADr5558ToE?=
 =?us-ascii?Q?mmQMLOb+pUtQig46W1LSvm1LIT3JKch6ghmn32QuABC3LvwEVx5JiDW6/kK7?=
 =?us-ascii?Q?qiMKTNV5RewG4/Lw57TBsGnyIw0z1rmCxVJRRu5U46ecAbskjXE63COel67s?=
 =?us-ascii?Q?M3nNOkiWZd4QNRWz9Vew4Ur/LE60cVe0jajbvCtURH+lNxuyGsELkz611uEw?=
 =?us-ascii?Q?qqSjo8IEnkTg9DfmFJv6mKzYXTaUUni1dlKkAuXFN9YPoMtwGBNXKOOGPcxb?=
 =?us-ascii?Q?P9/dnCHpnUD3YsejRKddszZUXnYVRn80m2/aELH96iJsJsYlC/7bdAay7m0n?=
 =?us-ascii?Q?B26rLi2OkPMzPdQ/UIS0pUpNnhzpA+fyGCcy5fwnR6To/6i3WaNr1VosZUC7?=
 =?us-ascii?Q?UFdTaVnBAS8xIzioY+lQ+Nm6FYi+RR7z2oSWAV5GKPkviXa9+YeUpGSUtyHd?=
 =?us-ascii?Q?4vcox1aMMMmFvMNkjoM9K6RNiX9ziQemnPpbUT18o0nhX2fUTK/CfSscvnwp?=
 =?us-ascii?Q?Y8AabMcZ+3mXNvNCywr7S6cv1GaEcitTOItie2JNIy4KqQ2kQ6vPWeB0PBX1?=
 =?us-ascii?Q?rlhLKCy/qmZkLv7/jtPBTbhZ8xyfpOXpfGCVQscUcX5O4l9q4tifM7gws227?=
 =?us-ascii?Q?xJsfcTjkAtLdOpgxg8qGZ29Kec0GAJJwHQMUjkzLVQNXX+fBCUQbeGZXdtTD?=
 =?us-ascii?Q?3IaxR489GNqf89ydDP8gFz09l/ScUqe1PdBDR9/F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d302f6-36cf-423f-79b2-08dd0a5da7b3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:52:31.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PgXtTurZvnsIWXZVB53RRwtidJtlX6Sfm3Rp+agN2k4TmG4bs3r2GYmt4W+/0OG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

Hi all

This patchset adds a new buddy allocator like large folio split to the total
number of resulting folios, the amount of memory needed for multi-index xarray
split, and keep more large folios after a split. It is on top of
mm-everything-2024-11-16-23-36.


Instead of duplicating existing split_huge_page*() code, __folio_split()
is introduced as the shared backend code for both
split_huge_page_to_list_to_order() and folio_split(). __folio_split()
can support both uniform split and buddy allocator like split. All
existing split_huge_page*() users can be gradually converted to use
folio_split() if possible. In this patchset, I converted
truncate_inode_partial_folio() to use folio_split().

THP tests in selftesting passed for split_huge_page*() runs and I also
tested folio_split() for anon large folio, pagecache folio, and
truncate.

Changelog
===
From V2[3]:
1. Incorporated all the feedback from Kirill[4].
2. Used GFP_NOWAIT for xas_nomem().
3. Tested the code path when xas_nomem() fails.
4. Added selftests for folio_split().
5. Fixed no THP config build error.

From V1[2]:
1. Split the original patch 1 into multiple ones for easy review (per
   Kirill).
2. Added xas_destroy() to avoid memory leak.
3. Fixed nr_dropped not used error (per kernel test robot).
4. Added proper error handling when xas_nomem() fails to allocate memory
   for xas_split() during buddy allocator like split.

From RFC[1]:
1. Merged backend code of split_huge_page_to_list_to_order() and
   folio_split(). The same code is used for both uniform split and buddy
   allocator like split.
2. Use xas_nomem() instead of xas_split_alloc() for folio_split().
3. folio_split() now leaves the first after-split folio unlocked,
   instead of the one containing the given page, since
   the caller of truncate_inode_partial_folio() locks and unlocks the
   first folio.
4. Extended split_huge_page debugfs to use folio_split().
5. Added truncate_inode_partial_folio() as first user of folio_split().


Design
===

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

The split process is similar to existing approach:
1. Unmap all page mappings (split PMD mappings if exist);
2. Split meta data like memcg, page owner, page alloc tag;
3. Copy meta data in struct folio to sub pages, but instead of spliting
   the whole folio into multiple smaller ones with the same order in a
   shot, this approach splits the folio iteratively. Taking the example
   above, this approach first splits the original order-9 into two order-8,
   then splits left part of order-8 to two order-7 and so on;
4. Post-process split folios, like write mapping->i_pages for pagecache,
   adjust folio refcounts, add split folios to corresponding list;
5. Remap split folios
6. Unlock split folios.


__folio_split_without_mapping() and __split_folio_to_order() replace
__split_huge_page() and __split_huge_page_tail() respectively.
__folio_split_without_mapping() uses different approaches to perform
uniform split and buddy allocator like split:
1. uniform split: one single call to __split_folio_to_order() is used to
   uniformly split the given folio. All resulting folios are put back to
   the list after split. The folio containing the given page is left to
   caller to unlock and others are unlocked.

2. buddy allocator like split: old_order - new_order calls to
   __split_folio_to_order() are used to split the given folio at order N to
   order N-1. After each call, the target folio is changed to the one
   containing the page, which is given via folio_split() parameters.
   After each call, folios not containing the page are put back to the list.
   The folio containing the page is put back to the list when its order
   is new_order. All folios are unlocked except the first folio, which
   is left to caller to unlock.


Patch Overview
===
1. Patch 1 added __folio_split_without_mapping() and
   __split_folio_to_order() to prepare for moving to new backend split
   code.

2. Patch 2 replaced __split_huge_page() with
   __folio_split_without_mapping() in split_huge_page_to_list_to_order().

3. Patch 3 added new folio_split().

4. Patch 4 removed __split_huge_page() and __split_huge_page_tail().

5. Patch 5 added a new in_folio_offset to split_huge_page debugfs for
   folio_split() test.

6. Patch 6 used folio_split() for truncate operation.

7. Patch 7-9 fixed split_huge_page selftests and added folio_split()
   tests.


Any comments and/or suggestions are welcome. Thanks.

[1] https://lore.kernel.org/linux-mm/20241008223748.555845-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20241028180932.1319265-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20241101150357.1752726-1-ziy@nvidia.com/
[4] https://lore.kernel.org/linux-mm/e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2/


Zi Yan (9):
  mm/huge_memory: add two new (not yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface.
  mm/truncate: use folio_split() for truncate operation.
  selftests/mm: use selftests framework to print test result.
  selftests/mm: add tests for splitting pmd THPs to all lower orders.
  selftests/mm: add tests for folio_split(), buddy allocator like split.

 include/linux/huge_mm.h                       |  18 +
 mm/huge_memory.c                              | 693 ++++++++++++------
 mm/truncate.c                                 |   5 +-
 .../selftests/mm/split_huge_page_test.c       |  70 +-
 4 files changed, 511 insertions(+), 275 deletions(-)

-- 
2.45.2


