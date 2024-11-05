Return-Path: <linux-kernel+bounces-395847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EDD9BC3DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26669B212B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C218595B;
	Tue,  5 Nov 2024 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hnHhpIXl"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710A183098
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777392; cv=fail; b=TQTcQRI0fNqbmjYV15CtFYl8Hmbv3EnlZS6n/ouR4o/ws9rDYGp4QJ+7TNNt4isatDAPraLTtH+pNr9JLi+leUm5VIIvfWVSnG9bsMDKjIJ4EhesbKaH6ZqbU3JBDnolW7b9BcQxb1z2Z75p8ZN8tuHKAoTQTPSU4mz8rDn+R7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777392; c=relaxed/simple;
	bh=/tpyMS4ZKnI6eutZOemMQxrnc1K+MmrnOQ1S78VWJMw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gIXxjRl6ItiA2daIyEXLfnvjA3sgnNEpnQZrbkqd246EshvXvLQkxZzb3AnqCgT8UosiRt3ayrKk/g/GuMWd6v+sq2ndV/SZArkC9TAUqhMeS6VM283+gVt7FTM8uoXW79ghRclQrFmFvsIbLaq8Nx8P7Ss3ykF6ozDEl4Y//Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hnHhpIXl; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/zvktoqFZ5C4h/BtsAm5S/aMeYmr00Sz4rGGnz8cSmYN36jPjakdLx7FUgTMCg3Plp5JdDE4MHuv5iVWeWXjWTtckeQpLu8Y0PXcICxZQpZN5MDHp3Z0qbpPuJQ9XW2yYeQJILNDmqiqKU2sz0KLinVtFnOMIyeUW+naVD07kmW9NfqbmqT43i/5et2CXhOGYm9eeGgw/w+95TONf5VFaWndk5bG4CCijtRixFYTASqTzYmwdoQKE+dRsXGoz3fyoK5EBn351epJIKqrCkm81d+LsU6suKKB0zC3I37esbPAWLqUob0O+Gf35PG04dAEMcZLBINkMFeKHtU/rXanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TB+el21/Z9AImLWwVBF4Q1KVLs7X30NebPrQhdcVLo=;
 b=Sz86BjuYSkvi1wFET9vrvhQz+G5OA8V/rssIlPyVhWUvSW1l/ZyQIrvj1Wt8erNN99GdiDd4tsNDQlrD/sOw1F+U7gxtLA5XaWxMMS362JX3b/HCmGY3fsYO1HqLl+euEY9s4aGnWsIAxVpMtr6we+QH4GrF7/sI7a904W0BHLZHtqXfrcVMxvfTDmVD0NTIK5pN0d0CX9zcdIO1lAWnD9YN/xOVGPDLalm4FLFK5YaGuxC5bHJ2hsanofDiZ0ce6x0GPJbOmIxYGAOuM2LYgZaq2yJ8Htc4p52v7NN+SvCi+jKHuW9Px4PM9L0B30LU3kjKd+3S451k8XmSMi4m1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TB+el21/Z9AImLWwVBF4Q1KVLs7X30NebPrQhdcVLo=;
 b=hnHhpIXluA7kf0nlnSmzT1O9+nKRF5KJk1317GnL134ufxWDPDRlzb2lZh/qqV3x2CNkrjekLUtz2Msh0MkjOR/F0lbMr4MlYw4N+AXzA2CbMzdB8r+tG5XflzPzG6J4l3ctwHdVlMw/heh6q+bOKOHpwM8mfENLCQAygvXOXXNvZsBE9JvRljMj/XniZ/2PZ2ZjrdAUwjGgXMqLyXBTi4Zibt999YZy8o8CFRP3q8YLh6olDORrz6xqFIFdgeDHTzegAbFm0MGR+Dcxja5EudkInc2QIueo9rwT/3d1RnfJLb4rolkM05ups6EpVVCUX2WOqj9Q8wY70LBueXqw4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:29:47 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 03:29:46 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	linux-stable@vger.kernel.org
Subject: [PATCH v2 0/1] mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases
Date: Mon,  4 Nov 2024 19:29:43 -0800
Message-ID: <20241105032944.141488-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::18) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: f537af11-812a-4833-c3d4-08dcfd4a18e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s/A9e2D/2ZI7D5Shha2dibmo4APJkS/mkpAq3KG/4unVEKAtONe4WGOPAuql?=
 =?us-ascii?Q?AwOCtslcnUwIn3bD8p23KXSS01cfPUAHpGVJxugU55VJr5VaJ8Gr6cbO9uCd?=
 =?us-ascii?Q?3xShWO6cjNvILYJX9L0wynHMp3rnle/wRrEVfOVkjhxPc0X8L6i0jykONnSi?=
 =?us-ascii?Q?8Uo/Hz8SrfnPBv2FnksqltCedoxtVy3kKmPG0iCs0c5NR5u1wnCx2Eza9vEe?=
 =?us-ascii?Q?xULhA3JVOF4o3ZN6rMpShQX4Ut8Jtged1ROIvCbypucJtfZg/vwhbojsiXLP?=
 =?us-ascii?Q?Yq2jTSU3FE13hjrVUtH/J8ynS7XCAwXepusxJ5/1NXkSqnQUk2tsuuJJ3Fvt?=
 =?us-ascii?Q?ZZJhaFCutIorqCKV+AIGiNTYHMv4BIIupl0k7vRH37DYk32VUi3apyJBxqFj?=
 =?us-ascii?Q?jl+VxyU9mHxoVwLjfBkU2setOwR9QHLCz+2lFsS52NBENCXQBYLB/huyxVxs?=
 =?us-ascii?Q?5AJdkGkPuSPo+0EPZnyDm0vkICcMCkKZDwLigbOEp7DpIbMA4iCuPnQtahmS?=
 =?us-ascii?Q?EK6SjlDRZIWzQxU3ZSlkCIpj8qRC8MiJFsgNRqKoWQJCLbxZe/BfOadpNWqR?=
 =?us-ascii?Q?zrPCpiC6Qo5FwcL3+Ewjso1lEWYfqRVphFS8Ax3lE0oR8EupNzeBU6H61u6I?=
 =?us-ascii?Q?r3eDEwMhiVv4mrcXtqz2ApqnRhpl1EL+u9EhJLvJxG9cgxY8wSOjHQ7sIgNP?=
 =?us-ascii?Q?w153F0+JqMZddOtDSt9Gfe2Rm2RAAS6ah6trG257/Gq7dKZid1elCIiBPT3z?=
 =?us-ascii?Q?gVXnBJm+hVdRda+hLqOTjh6cpQ0TpRndj2g7FQGnSL20bYPKfKOQDa+f4T9O?=
 =?us-ascii?Q?KCIr166/OPE/WUKFvyLYPyrQU/8c+d9kOwzi4+xXoxAOB04pBEFxshqaZcQA?=
 =?us-ascii?Q?qvZfq/oRbtRbKU2DiHgfmHu9GaWL/r6xIqQEn/CC6v8RyERZ3gr0ce845IVm?=
 =?us-ascii?Q?tz417cmTqUfVynQSn9T8kxdjET5AiK9lCG4MF7Z3LteJKXpXIvKRg5XYWstk?=
 =?us-ascii?Q?OeLrUzdD3tgKmLVwiiiU1vFv4cB3UQi1xo9VLgya/C6A6jgRWVBYbnuB6wAk?=
 =?us-ascii?Q?gstfGZAm3CxuUJepmzHq6Dr95YFOAtT2nWWlmr3FYYTg3aeVuds6wf/9xSQQ?=
 =?us-ascii?Q?55JoXhxAiVx3oQnqZWys+2ytH/C6RFFB1+jKTnaiapsV/YpdhJj2TdsgmWEp?=
 =?us-ascii?Q?wkHBcX2JgjD7NjzBjGFV3ojpYgT8yNd95ofiyJJs6inYY6FYaTYVNBmYNGh+?=
 =?us-ascii?Q?ePgU1kdIPcKSAezW9WCx07h2f/B/n83RYDttMvyJ+Lhk1IkbPBLaI1K8GJpn?=
 =?us-ascii?Q?1zkehYJB+8rN/aVFGmRY+Tqt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Cnun3YOmj+WhgHwZhUs0c8GKdnKSQJs2FC+OYuHtYkSRxNz8AsV+Di278Sd?=
 =?us-ascii?Q?tSZZxINYn3b6oyE2wW9xD8yJG3ee+XfuLkQwkWWfcy7J1berpPlFLslM6L8e?=
 =?us-ascii?Q?yMWbCwNrVjuPykVZBJ5J+fUo5jQZKu+mGm+FbKM6NcjN5iYjjH8UpgGZFC4Z?=
 =?us-ascii?Q?/lugnTZgrBw4lPIep7Go1aNMdSlAzkU51QaJHzk+bLaFESB+EiSdE6/YqTpR?=
 =?us-ascii?Q?JnNhPyvMYRtQ00A+00eZoIn2FBtElGwZt5125yW2rj4Qd+gERHeOlJyhfZGt?=
 =?us-ascii?Q?qk3UOzPA826JEgqzGtRRago1p1XKO+sYYbdpJuRyXeX91nXxkiaSk+U8Lhfi?=
 =?us-ascii?Q?RmutAm0ZDFH/RyUTDsBFP+W562Xvb8fEBTZkAy2LNyF079g9LHgtF66IwLUQ?=
 =?us-ascii?Q?VbXXN50qt9fqxsYOOBnw8R9ga79XeN1j45oi23/tel/zfkYXK5hJus/PVy10?=
 =?us-ascii?Q?0TZAroxcwzp9NDYqqYVn/9+CSjlsD18dLpivqi/SJn6mgMZKvXYTEZ3KCO2W?=
 =?us-ascii?Q?YRqyTAa1LbM7TqzDhK+DBZaqK2fmRD8SxqRiansQVxfFpu7qPavj3XxR8OQz?=
 =?us-ascii?Q?SG+ai7gj51VkftmNFQlpud64YsRhAaEPdL3NyBZXXZhh/yR21BIG2EXAETEY?=
 =?us-ascii?Q?rELkqR9g0mbX94W5UPdTSEkR8vubPK/bclH0F/fHtRHphlco2BVAzUBt/YzC?=
 =?us-ascii?Q?xbMKvgGNd/vFxtO5Y7AFJoMDBrae1T+uOCvOSHUswmZZ6hvU9oMJ3oUKmT0f?=
 =?us-ascii?Q?RTFnhzg/pOAB25vKCiQHzAb/rFiSq8ai7bUnVI3H3BAFUxUTo/Dtiu98lTRt?=
 =?us-ascii?Q?wmbaAYIPonoM7Yits/pWeTyxPFXzczMwC3B2XhlOGKm6ZSShCkYRDkOX6SNU?=
 =?us-ascii?Q?crwy+K2/FCgkQLkFiYgfusycq4wq4okM8flI+vW2LQWxKjn7+ZJKOEZYDcMi?=
 =?us-ascii?Q?9SxP98h/dyKbldZiBMBRbLU/fUzqWUBmqXjfmMSonm08lHXfXby3UV6IHEAE?=
 =?us-ascii?Q?lW2eXEazdHyv1RvUqDCpUchHo4HC4hFOaUQmNMS8MMaY9vPyak2cIyyEnyib?=
 =?us-ascii?Q?iYZxWUUMhwfc/jffXyEUeoKs1x/xqxPTOmRGXaTnuEO8lNiZaTcea+BCHvJx?=
 =?us-ascii?Q?tmVsnFU3gB7Dsy++hPl3t0qCOMf93QmH1wYGlJz9qW93UABhvPQc8aTHa4T6?=
 =?us-ascii?Q?0hWjQ2YNfzEs9LJDSuPG23f727HjgU3AxC9pUgeUtqdikOukMyqOEdUYjR4n?=
 =?us-ascii?Q?ERR7ioGa6UrjNlRfHvj0uqyBcHJwZYtrE8ObFZkQlWW3oIxiBeZkfn7nWr72?=
 =?us-ascii?Q?SJOQqo1zFIeH7UJke/hu0EywzT4ejeUjGnqV5Z7ny9QssuFcevDsuXhhYt4l?=
 =?us-ascii?Q?M4rMacBbUYAjNGi1HygTt30ZcWiGIIJyzTTRPvUtjGJBIkDPaxBVJf93URSt?=
 =?us-ascii?Q?cPMfStsxGPrnWXMv7B2C4qBEOKJXjMymnWFm9ttbj0+2OH3Aza7Y7plJCOmf?=
 =?us-ascii?Q?nr3fjmQHkEUfnEBly/s4CUI/jMN+Wu7/kf0rOHynFHU/HM08XUm5PunMHvNX?=
 =?us-ascii?Q?4njFf9PdBUpB4lH4PK1hNVrLEkNQfftG3T8+9UP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f537af11-812a-4833-c3d4-08dcfd4a18e6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:29:46.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9r6VS1j7nSX+DYm3YU5kviMz4ZA+Z1n9XjWlA6an3mSkvcaCCD8yzwZcfKly3jnF1wQ4USDO4iSkbChGLWJXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

This applies to today's mm-hotfixes-unstable (only). In order to test
this, my earlier patch is a prequisite: commit 255231c75dcd ("mm/gup:
stop leaking pinned pages in low memory conditions").

Changes since v1 [1]:

1) Completely different implementation: instead of changing the
allocator from kmalloc() to kvmalloc(), just avoid allocations entirely.

Note that David's original suggestion [2] included something that I've
left out for now, mostly because it's a pre-existing question and
deserves its own patch. But also, I don't understand it yet, either.


[1] https://lore.kernel.org/20241030030116.670307-1-jhubbard@nvidia.com

[2] https://lore.kernel.org/8d9dc103-47c5-4719-971a-31efb091432a@redhat.com


thanks,
John Hubbard

Cc: David Hildenbrand <david@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: linux-stable@vger.kernel.org

John Hubbard (1):
  mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases

 mm/gup.c | 116 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 39 deletions(-)


base-commit: 0012ab094cad019afcd07bdfc28e2946537e715c
-- 
2.47.0


