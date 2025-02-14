Return-Path: <linux-kernel+bounces-515224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77EA36204
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC627189328D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09057266F19;
	Fri, 14 Feb 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Efn4KlxN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE41266F01
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547749; cv=fail; b=AdVT5hbBqcjLOs/rsP6LPPGtizUrlhoy5W+SeverCQ4HfdxBfR5DOCGVCckuXL/XMR38U4VfZEDJkNasm4NX5QIGzBbSptReuYPCcIB65gkjnx3CLHnzKWzG/X4Cs0sAXTc6veKeoeuLCbSmsf3SopbFPFVXLR0bgjhqED5kFDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547749; c=relaxed/simple;
	bh=NyzKCEEXo8ytf7vmWr6ixCM2/6VtRyMxP9js1S52rDs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TgFNJO5egfd39DpXR9KBImWll6FNOf153HPTCOzKx/GLTw4Z/VoxMcWOO32vm2ybL63PIq9lGu9mivEvjH7BjgaLIHIjaTZOm2tytZ5uTmDfQtse28/fPH8Ngn/mN/GqFjqo3Q4C2RNIpG/WmlLWllz19ATqL3YBz1UhvtmGahM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Efn4KlxN; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAlLKEETq8AJ7RSxwOKC3fkA2CMHm2U8Ddkw9t4H5zXvgK5sDXWRiVI/MyCLxcvuv6Hf2Go+R4VI1mvEQDxYi+OZsPKnsD/EgF6Fe0fo+M785Rd0MUFA4brwHGi1AbyX+TcFhejv3nXPw1/oQbdk+soFkhk8pnutD8umhDejpEAe7LUcs9u9DxnevUy6uqIXfSFE+88PuV3oeNnq+RPAx5Bn6pgSM3oL6tfzmPk0niXdMNH3+BPJJhvV/vnutagdhhZJovo3mwvq1NO1yfjWcAc6ryONsCbCt9JvLM1z5eNH/H4kwpX/NJJMXqjeRC0e9DTCmINh3EkTILBYk3yccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlA3cFZdEXtrsC0PjbObJxBPZ26KdwF0auVLorp7Jck=;
 b=yhhMakOuwrTj0QQezsT+fwZXt9T8cDnmYw/iFrigrfdijn/ka5DFqlHdErn0GNHr6cFvE8W2v6bm4qsVqJV1Eh18xqgzeXyIuGmnlWXuVOw9FLUZaHJpQ/3/7IDrhx0FRFJfpxtzrH/BKjDTXLbxC1fpY+m+71Lok/F6ykeIM9vAlmLLZ4owmjZwWeEOqSD/SY8IrkfENP27HaNTeRNdkXXCXEALayAI2Esfb2YBYI7Sk6BIDEOWln9mvQRR+S3NDjLpNHszNgkXSqXXvL/zR50jRBwYD7QsBN35WkrPtWu8GtVxZbtZGbvE00q23wTgyxQSe/ypdol+EHBD+Q7Q6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlA3cFZdEXtrsC0PjbObJxBPZ26KdwF0auVLorp7Jck=;
 b=Efn4KlxNDL70yfaBoGPso2OuLgyK4QpRwbHh1s+NivKTOLWSKoBiQDcTvdG3FrDoTn3MyZFtJimekuxuuVdqgk950PP+iL8+OH4yq8WRk55xsYM859FHB8b4+OrC98DnNY1RSe3sJblIKDnXoM6t4CbQA+K0HtXtmLtlF15jQt4MvDG7PGpSarK54NGwfxeI/mgtnQyJU9QvKtvR8IqQaUtQenpaV3rkvfyYprqNq/6jDepeS24pUSHDxsv0XrgwNwijoP++cHcVvOTBjCWmWg/SDG55zxFRiFZRwkR5+rE/IRSiNNiCa7fb7LNofMdnXh3JDKZiXfu7SEDSQubwlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.14; Fri, 14 Feb 2025 15:42:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 15:42:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 0/4] Make MIGRATE_ISOLATE a standalone bit
Date: Fri, 14 Feb 2025 10:42:11 -0500
Message-ID: <20250214154215.717537-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:208:52d::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 28354c4f-d7cf-432a-21c6-08dd4d0e2c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lC1rNUBHhuVVtZnB3+0/5pwKU5YFT4gz+DdiAMeqS2yTr5+0r3VxjXFK266B?=
 =?us-ascii?Q?UX8GMc+7nfKLDT2Ug9/wp09FFtoTHhtT9QJ1yY4dSelCOzvnJg2HQR4mh9Jd?=
 =?us-ascii?Q?RTifBeHnCXbNZT1H39T/956sIfFw5xNsatiz0k3PoNV/ei5E8F59jWH46s1D?=
 =?us-ascii?Q?SYqFYPuvl5R98dPmjQFBbiBNKpruXtBQJb9jCljEHq9aJxLfWLauW4Bs7ZWl?=
 =?us-ascii?Q?W3jT4G+vCPuhXpDdnm4f5jUeGGxFChDV0XG7AhWM7cNCvSIvOj2RaXVaFKPf?=
 =?us-ascii?Q?yO+LOZvrUXeCx9sJOZ9TKjs3eP+1WszRgJFTD1EbMIWh81V/WUW8aZ4LQal+?=
 =?us-ascii?Q?jiGIaFh2xYB9RuWqAelb+yAiD3nkPPA759fr1YycAua4DOVR3M5TlKaFbJzY?=
 =?us-ascii?Q?W87heWE6hubhbIu0rPNkF43n8fXbP1yva9l36O4yTnF/DZSI4O2mqfnDNJ6B?=
 =?us-ascii?Q?L0QVAot1fmifbx62QUJDN0rgGcOvtguoVi1NkV46AjonLz8AccJCPYnbmrb7?=
 =?us-ascii?Q?RMqEenJoASgUHzc4eWl2unMOHaQHs/OL2Og6kwFQwyo3VODHF8qipo3GeZrB?=
 =?us-ascii?Q?p5WRwLSDz/+tbbbVM3GZT38PgFjFJMsF9MB3y7dwvzOjIrpbDd5RxM4f+TrV?=
 =?us-ascii?Q?Zr/eZT5Qmk8ol1gmoF9oL3uAWZz4CjjADTzCt0x7JmNXLYZrpJhEh4l3VH3R?=
 =?us-ascii?Q?p6pbAc4QKsekN3BiSZFNacwcK54MYQ7G63zHmk+5dDNXf9LM7HL/qpN5R9xi?=
 =?us-ascii?Q?q7GcxhIvtB6qGSSDCGFETrqXuA39InftZ0DKZ4GHz9mC9xxn3hjH1l3pnueS?=
 =?us-ascii?Q?AbcEKEU/oV3lsvJyyKhiybW0l5xS7ped/fiRTIrZSoVn1WY/L7ESObYuRrjU?=
 =?us-ascii?Q?NOpcOFWRM5qfVax3GLulp+8+41KYQ3tPyg/404EmpykH8kWnW0peLgxWIi52?=
 =?us-ascii?Q?tNrW4xjLDgfxK2HsBdEkeyy3isUUzOPjgXlDwawFXHZdX6FR2nQv4bkGD8Z3?=
 =?us-ascii?Q?I4JjgWwIVe0jvXvqHxu0mKJO/7ZyH17ASPCmjeiSOZOZ7RTB7fY2p+VDojAI?=
 =?us-ascii?Q?Klx9CLBzSTF+1V/KUKPgOmrJk69aG61h7Xz64f4lS0bfpKRODRZlnJAlJ2BI?=
 =?us-ascii?Q?wv+XexplKQip74EKfv1pSvEJvMCS770yCZZYPOuIyr7Z4f6Ni3NEaPmcMOFa?=
 =?us-ascii?Q?4xmI+IcBTJAGLUptRuBNP8rgHMU1fujUZK7A9QXoK8AvIMQKQ/MzfW7pF0ll?=
 =?us-ascii?Q?QW9TDFjox/x9Kfpgr3G8hAIO1FelCY/pa5XHDor0bwMRsV80Jr1aBSGnJmd5?=
 =?us-ascii?Q?ArCgmpJzYhT5xv5c8f3EaHHJo2sLsPcgAM7cg1IvznsArQW79eRyilemx2fh?=
 =?us-ascii?Q?VQ+UFv4LXjP4QU7EcAmfXeL2XrZx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/12nIk4dMWGxJufNb1CCkdJxhNR2kMbhODAgUuFKiILlysM7zy2hGBYnDyGL?=
 =?us-ascii?Q?v8MRrXWi2UTDLt+IMQt8iFWBDaWCAFxtEI+cbb1LAVYbQylKpYWX6fACeasB?=
 =?us-ascii?Q?pqUkH/PMaBalb9OLUDiGzKTdzdyzJiX1/q1hqZxjiA7t9BxcGaBlekX57+CD?=
 =?us-ascii?Q?shJSkSXEqk57P9pVw+60aMqO1NT668PTIVWtQTYcaoDtvfnEUkE3ZV64NoOh?=
 =?us-ascii?Q?orNBapsx+mvf0a0HBBth305ADLvYCvYtA4yROQhEfJBa81rYFZbe8qpr5t2E?=
 =?us-ascii?Q?BHKlWAbBofG3DLyMI2p1mSUGohsmUyQDECdYbA6cncMqEe1QNUCB10TQkmwZ?=
 =?us-ascii?Q?5kdH9EYtQSSZrhGovbbvSf/CRKos1o7PO7YL1KOyfUcU20VvrfxdKPEGwLSK?=
 =?us-ascii?Q?sFoBc5vtqjCwjMsHMz1lKJ1NeaEM9UskAiF8akssmkocOjO+3XEajI/EywNC?=
 =?us-ascii?Q?BFBbxTcKsV0SM+N5PTHDmAU6Z0nO+SUx3lE/GfiA0yYzpn4vuIXvJ1zwl0x+?=
 =?us-ascii?Q?jfQiO+udJ4ShQbPycBrGcRYhVOrxDdTZzeg+g/4ZsuURIBFHPO3rg0z3zwHx?=
 =?us-ascii?Q?iGqO/g/fQoQk/mjEf1m9ANPsE+8cdqdjYVF1poAXU4NZ07o09PEzHErpKfXX?=
 =?us-ascii?Q?jOOveBxUwNTRlzFQWSXKD84BXcB7CfqogzN7AUQY5mpjFfDYiRln8gwUFE2A?=
 =?us-ascii?Q?9dxYbTN+bwBsu6WF3+uSikyDi1VaUXKsvJzb6IWUH4Lmz8q4e3s9QuwrlVHe?=
 =?us-ascii?Q?N072mpdeePpWhwHxNSiLrXxLchHqVW6Ol4tXzfU3wxgFXFrmX4PqwKlHk/p8?=
 =?us-ascii?Q?vNEMne/TR8gizeFVsqb5JChAO1IvtayyQwVPe8yjJPkGHpcJ5cPfH5hy4sHE?=
 =?us-ascii?Q?Qnug0lZVFKGfRBk9USKd7Eh7bWt8dEInkLLlAA2pfCI9YQkqOZh5taH5bQeM?=
 =?us-ascii?Q?zmZMz411ydE32qlhI7UhlFnwM52JpsN8MQMfP3lmKJ3XqJyyHnElVlfWhQPb?=
 =?us-ascii?Q?c1UpVlRpIlymjbsKBTpNt8cG62XpN3LI8GDlA2JCoVbP39jreZU2Yo9yJRou?=
 =?us-ascii?Q?Fqy8/EnfenZhucXPxzfi1ykUvxzJ2MJhYwnu9j51Ii+3pwc3v/tDVDsU+ayB?=
 =?us-ascii?Q?CXiGcOi8aZNMFTuamo6YpMny6VWCIYzvRtMoy3RG8NieFKMSmIYGuw3GRwHB?=
 =?us-ascii?Q?CAcE/xkCsaPk/sMtvrXvcEhlMTM4glFsvoJ3ry1953Cp34XjS4VKuXt7uqvm?=
 =?us-ascii?Q?+36Yp/r8AQZGIh4/3SKpgKsUyjlVdD/PqKP5iQY5yKylZWpWtd2owyed6+34?=
 =?us-ascii?Q?u6PHU1GigpUcNiZaOeT93TsLQLDWE1zAopKTLjxsiA0pYi4pM6TITZbe6g/I?=
 =?us-ascii?Q?P5f9SeOHKCDsLjl8ulpjcBibbFNlAbz+MAAUMXPR0Jq+ZQJjvsA7AiBIolX8?=
 =?us-ascii?Q?O/ewkjZD6Sn0aGrTEiZlug8PDFAtRpyiW75JIxpv8pRtn1DfVnTfloDwmKxC?=
 =?us-ascii?Q?N9kz1IZ2nwpt06X89aaGpH1jDB9uRH6dw961Nfs8th8xK8UliRYWJKnyNDLd?=
 =?us-ascii?Q?wSR0pBRAUyyoiqH2tur5alp4Tf8b9ZyNcKWdntgX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28354c4f-d7cf-432a-21c6-08dd4d0e2c95
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:42:23.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/sy7sLM0j5xCUTRxnI0UmirUugfPGSXGojxFBZS2Nfb2pM/PRQvyQwUWXshRweZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Hi all,

This patchset moves MIGRATE_ISOLATE to a standalone bit to avoid
being overwritten during pageblock isolation process. Currently,
MIGRATE_ISOLATE is part of enum migratetype (in include/linux/mmzone.h),
thus, setting a pageblock to MIGRATE_ISOLATE overwrites its original
migratetype. This causes pageblock migratetype loss during
alloc_contig_range() and memory offline, especially when the process
fails due to a failed pageblock isolation and the code tries to undo the
finished pageblock isolations.

It is on top of mm-everything-2025-02-13-23-42.

In terms of performance for changing pageblock types, no performance
change is observed:

1. I used perf to collect stats of offlining and onlining all memory of a
200GB VM 10 times and see that set_pfnblock_flags_mask() takes about
0.13% of the whole process with and without this patchset across 3 runs.

2. I used perf to collect stats of dd from /dev/zero to a 200GB tmpfs file
and find get_pfnblock_flags_mask() takes about 0.30% of the process with and
without this patchset across 3 runs.


Design
===

Pageblock flags are read in words to achieve good performance and existing
pageblock flags take 4 bits per pageblock. To avoid a substantial change
to the pageblock flag code, pageblock flag bits are expanded to use 8
and MIGRATE_ISOLATE is moved to use the last bit (bit 7).

It might look like the pageblock flags have doubled the overhead, but in
reality, the overhead is only 1 byte per 2MB/4MB (based on pageblock config),
or 0.0000476 %.


Any comment and/or suggestion is welcome. Thanks.

Zi Yan (4):
  mm/page_isolation: make page isolation a standalone bit.
  mm/page_isolation: remove migratetype from
    move_freepages_block_isolate()
  mm/page_isolation: remove migratetype from undo_isolate_page_range()
  mm/page_isolation: remove migratetype parameter from more functions.

 drivers/virtio/virtio_mem.c     |  3 +-
 include/linux/gfp.h             |  6 ++-
 include/linux/mmzone.h          | 18 +++++--
 include/linux/page-isolation.h  | 24 ++++++---
 include/linux/pageblock-flags.h | 33 +++++++++++-
 include/trace/events/kmem.h     | 14 ++---
 mm/cma.c                        |  2 +-
 mm/memory_hotplug.c             |  5 +-
 mm/page_alloc.c                 | 96 ++++++++++++++++++++++++---------
 mm/page_isolation.c             | 66 +++++++++--------------
 10 files changed, 175 insertions(+), 92 deletions(-)

-- 
2.47.2


