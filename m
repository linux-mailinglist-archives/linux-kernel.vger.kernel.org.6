Return-Path: <linux-kernel+bounces-260992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D893B14B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C38B23C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F9158D85;
	Wed, 24 Jul 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N/yMKW7b"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3779158A3F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826090; cv=fail; b=qT07NXUUgk3dM2pUSrmRfzfTxYz1lDgm6svV68UEsBpquaA/rMQ5nHNASL71K8wzrorC1B2TC/oB7kya/a/j6p4lTwkPrQtIH8Z5PsF1gMagl50e1S2P4+F4Z9/u0Dm3hICfGMiYDAi153/w1ixzqERHVMbZPnVvjciXeD7HOlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826090; c=relaxed/simple;
	bh=/P3Mss5OuBYNuZFXvkPIIQ67Ns+N3JdioRaCDzQ5qKc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a82hO9bLpd/KTWn1ZXmeFSf07dO13iTrJoHGxfOq2WjKSHm3IMFF7VpzqZgVhZWkG7p8DKpjZ2RoKrbPnxG6HZVE9XGEBr9w+ZDqPt6OPME12ch28zO0FcayM9R0hip3aTzyXz+ZsVC5olczQH9kLAqtPLd679ndIYXP3uIC1x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N/yMKW7b; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPsYWs43dzfm/dNBrWO8EgDukV/2YSc90rtX6i7xcBNRdrzmvMulK5CRv8OG+w/lBmVOEjLVY8U3yXnu9qBUNVcFuo2+Cb+gqaY/A2yu7rLHlfoMbZwaDeP496vp/VsWC1ThIoZVcVU/L8ScQiqN/y0KDUw9ZeGEKJcfz8dFp3RxFUwsnIvaG+kBjIN6VI0BunBkov9oC/HYUQIMP8za5OdFNu2o1EzJs6IBLxDrNUO5fVRCRMzZsLxevi7kvkb5KWPbbHl0GH8XONh33h6UgJ+bw+mhrEikDsqYDPmiZKA6/xMMA2rzNi0Vu53uRYDioSu2M1K/FMe1qawpqKt8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMID4ESwDtEXPhHLauGyWaXLbkAmfGD6JSMebw5MYTw=;
 b=OE3dI0FYwDBCBG8GasM76RYiNcHG0UoHPAQ57ZK1DhOZ3vnKdY9Mj7Kmlybx376j05a8E3stGd7nnQg60Wtnz71cxPipMxy88Vp4GYhbiFq9fXZeFBCmmo1Pnm0o7hapjApMIKEXCQTDuS8ZccqrhJjS3lqyIoYmdzlR58ebEiafe8byNQSABokeWyxoaqHYhm2Q6hF5ec4NaaZXL6jZKQ5RiCsYa9Qb+KFXXqfOnw67QaQQ7s5pLK9NTA9WZZb2H+oJW+jP1bowZZUdJnTyvA5PjdHf+s1AaD8D5DWsYX91al7KidiCOY+4JmCXrGVrVkAN9O+v6sSmuSjDBdZptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMID4ESwDtEXPhHLauGyWaXLbkAmfGD6JSMebw5MYTw=;
 b=N/yMKW7biKs9JIvMHKKMwk1YvOZEKe+DEGQCD8aNPsGbDYnbXdXV4XI2Lu1saVauF680qI7gqjKFyqilnD+AUXt9N0kk9yuj5XpTcYlbLh82KpfMy8x++4n2Orf3oOl0cG8P74FD8105UGuN98eMO33nalIAxJRHIl/HDbEAT42v6YlG4fMao9MDWNaPsFdb0ToJZxLRX0XPMFl/mMNCVclPXTifkY86HQ+qiGmYGVR8MUMvB7hNNgeDCqUTsMAExrRViSbCg79YGu85IwkWy0ip8oTJqu6RCFchDVTMWZV6RndhZjEelVpS1w5qKOsr4VvP/IJag2ctpSSW9BUFpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 13:01:18 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 13:01:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 0/3] Various memory tiering fixes
Date: Wed, 24 Jul 2024 09:01:12 -0400
Message-ID: <20240724130115.793641-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a38941-70c6-4e71-f039-08dcabe0b532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/OmZGJYfHs/aSJpzPeyYCpS/sVgmkn95ylG8j31nCrf57yVmPR+Q8+gxSb1h?=
 =?us-ascii?Q?XkEfRvCdT5S+cwrv6ECCgiGPGhRIJZ9qkIbL0rjpKHJwqOL63r7xbViUBhf2?=
 =?us-ascii?Q?fYsBNiQ44bq8iO5Sjyn0+GCiwCIBz7AfEAtpp3uqp9T6l0K7yyvzSp+TUUTt?=
 =?us-ascii?Q?CS3zodfoMQB54n4g+TZq7QE1YvZIGlz5RHqbyDuPhM+VaqgqqeLdRctP37RA?=
 =?us-ascii?Q?NpCJp7iaew8N/CIrkLQpD3pYnTKJzi/tOO2h2dBvuvPA02K4eKBQIgMyXToW?=
 =?us-ascii?Q?9g9EEgX3PdU66XLh549ZWI1ttydEbDfYDXq5iBM9Vz/t//b7vRhNYSicq58H?=
 =?us-ascii?Q?CrHsNBHlkfzif2hMaABvXeKxP4kfLKubi3b3F0uiJhiTlJ1O3ylf5rFjlePF?=
 =?us-ascii?Q?uMaRQLT3HIUACu22LDp5Kc/r3vgE+4/UmdsCBQtNjL7pm4tCjEruzpNYbFqU?=
 =?us-ascii?Q?E4TK+21QZh6Oj2R41rhHKzv6X6c9cx+OTEH0i4dQ7EduPuW5SrD4O5ZFtDUd?=
 =?us-ascii?Q?S4vtY6NBgFCni8bmy6ltYl0Dgs6fTuMKy27UVdp0dZW4zW+3rt48KosgvTzW?=
 =?us-ascii?Q?rWZVk/b989c+b81vTMj4NZYUWQR5tSbGUgWxL6HmCuwVsSv+sPQSO4MEbFan?=
 =?us-ascii?Q?RnjaMO72gCBI7Kr6/JePOYXYWh8c1onF/onw79zfe8rwtOisxNQ5BQhx57YQ?=
 =?us-ascii?Q?DTxEwWrg4waJKy3ZA4/PWOu+rhrJKhc13E7b8g3UbIHVCqqN7r7XMzFkl6jD?=
 =?us-ascii?Q?NGjeT9KXrLhk16QouVpKifiTEsdxHoB7RTgz5OITKIQezsHnWPtHFMV4op2q?=
 =?us-ascii?Q?owKukdbAQA+qTQoRjcZqRdS7FRFmTvBfC+xXF/beva+JfyUZPi4uWN2edIFd?=
 =?us-ascii?Q?ygQMEYndsRua9uN/yrUHuGge25mNC9tvRs8JMLH1CpZqxBs3nEizdWe4bw4p?=
 =?us-ascii?Q?MCO/IDJ9SucKNTEpY3CCzQD4jJj/JM0VOrx7oWq6egnoMb58k9uSGfNunVGK?=
 =?us-ascii?Q?CT9PM4rTRAzvm7Sr5pIIa8b6nEfjd8tXothdPWQJB+GTNvB09LuqULPxTxQI?=
 =?us-ascii?Q?Nwabk8zoqOheIwo1m1HdLpkWi2PQQcESM3ql0XMbyStj3P/ZMmGxX1TaoxcR?=
 =?us-ascii?Q?hShgAhOcvnNfWHRxgIpo+5MlT1Us4Ata4UkYx8EJLZ1Sr6JbPak/6nS4ymA/?=
 =?us-ascii?Q?m8kywh5qy6WZjr4eQOIHClxt9jC7v5ATnukcjJFKQBxDKWicu2Y9WA4sSZRk?=
 =?us-ascii?Q?n0ZVlwyre7o2KL0vrqxtLC9NqEPcQsGyh7CvDa+JPFYrBf0wR5Xi1ZW0Q8cD?=
 =?us-ascii?Q?5owLFRZsoOFqJY8VnGpUYd+tBHNeEtJvles8ncujTFZfLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjD5iBc+52yZD0MjW5CaHD5zncArNPwSIScQlu4tzpZrIJotOHYpseCsKe4B?=
 =?us-ascii?Q?z+xfY7nljZTEIYVDiKyIUFbIDbsS6wqHb+DzsGAMoMsKe7zbwCMoxTWjZXtB?=
 =?us-ascii?Q?V75F9pd7vYiPmRkH6E1eLuPI/AFcSilry+JVBLsTvVekP0sV2AVrDveyDoG9?=
 =?us-ascii?Q?x197QjBzVX1O8RMEh/e0uANtmOKrWXc9i0NFEEddOir7uc3+F3J/xuqpwwF3?=
 =?us-ascii?Q?gneQgi/hluaBDX3i9Qm9GAMm3zbJoLgT3KrAfQ9H9XvlcqzXAQ/zdH2h+C2r?=
 =?us-ascii?Q?ykfQwgPQLjpPNHuKQDZq8lDfXOKRuHIy/C7gtCbe97TtyJ8Qww8IqwFhaxSa?=
 =?us-ascii?Q?LC/p5zCHeopUXH7r3EjVgrdKLiDs9Lwa27njplbCHuB5K7aeq9KmGCvdTAja?=
 =?us-ascii?Q?Ac0Wmy2JzRCAQFSkCuzIplpTbCDRGQGZUrRBAAyIdsUaZzN8NVJRpM9teJXf?=
 =?us-ascii?Q?BFes5rsOZRG/W/D/TTzplksyN+/Zq6dRSjMCQiC2A95znP1NiQF+Pk6diTow?=
 =?us-ascii?Q?ql0yeaix7B2NX/8KopnQnbnSMQgQ6AAEl8FTuPhvipu5eqhKvNVjBIK0TywX?=
 =?us-ascii?Q?ItqjAqaswgPmQ6/D0OIWhqRWjHEwiIKphojqUssy8heqT2lKT3Y1epsvYnLi?=
 =?us-ascii?Q?FeW8D7DCRVioQkPS31yl1GnAR+9ZhDUxQAsxOSYSpx5NN8dhwYO9WtNeVI2d?=
 =?us-ascii?Q?J4rAPNjvwxdxdCaQ6Z1NVnV0RXWitgh2nesGejIqCTIBRWmgiQrYsX9AB0Q3?=
 =?us-ascii?Q?sjzgHjjfjDgu2nOUZKhA7l1RULX56LRv4Ec9UJlIjN/kYvTGV8AlcDQOtHgg?=
 =?us-ascii?Q?dx+KBhvSKU0jZZ73E3z+EQGJXiJffvR0usVHxyZ38yX1LpkBkLcMIFecTqEZ?=
 =?us-ascii?Q?YZmnTGCLCeCX9xqjKixj2vAJ6PBbDGbjaelJ8r6kOTXH/GkB4rmoFkCrzC37?=
 =?us-ascii?Q?lH7yhsYrKDhj4Z00aOiGIo/KoA97gZyO5NDpInulauxRoe98tWyXrBHxgdML?=
 =?us-ascii?Q?5E01jO9Y0WXA6xwMx9+QKG9L49eoTXK52xd7lWds3onBZXzXMPygoiywP01T?=
 =?us-ascii?Q?o7F4C8pCdn7ihdr0JiHjGnspzhntIbNlAMzdbGkpAR/+4CygWPaBfiBnv8r3?=
 =?us-ascii?Q?QJBNWbFsswWUrSSEWxrhmnL1Jm9EIiBM4UWbgGjnuUoY7OzMr2LycvO0uKSY?=
 =?us-ascii?Q?YVw7gNVEh/VAZpz9yvmFwBio0vPZ1Zda+DcGLaHGPNKe4f7it3UkslbsyB9U?=
 =?us-ascii?Q?XhL0lFffr/MvLE5DuQYKxmIHqAikM7uJLFYrBjzTF86FSVsFJ2i2Uf4JXU7Z?=
 =?us-ascii?Q?l1xlAWpcpZ+8QRoZrpr5z4nXc+iCSXbDcF3Furfe/AoVMRJ4scOQKHUe5vSL?=
 =?us-ascii?Q?s1HrlxuRzQXBmtRurPXt6yiEJdA1+iXnFTKvPFw5Bnz8umDTpDFr4o5f7Vs3?=
 =?us-ascii?Q?JbnqtG1NhTFA7vBpXjCWbZju+UVw4tal7WK5y+bLR5gEX/MI9AALXLg3F3FX?=
 =?us-ascii?Q?rvvJgYBe7CurdZITNwQONjI7tJ9nvHblkfAKHXI3y9qbsNeZ5ap+ugfNs8Fv?=
 =?us-ascii?Q?DlceV0l0afHmYqS+Sd0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a38941-70c6-4e71-f039-08dcabe0b532
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 13:01:18.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytpoV9MUbYnsmBrtthyTjY4aHN7vjbxJbHlMUz6W7lAFwS4w6vHLL7gZZED1nyNJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

Changelog
===

From v2:
1. Renamed folio_has_cpupid() to folio_use_access_time() and reverse the
code logic, since folio_has_cpupid() = !folio_use_access_time().
2. Wrapped folio_use_access_time() with CONFIG_NUMA_BALANCING to avoid the
function redefinition compilation error.

From v1:
1. Added a memory tiering runtime check in migrate_misplaced_folio() to
correct PGPROMOTE_SUCCESS counting.
2. Moved folio_has_cpupid() from memory-tiers.h to mm.h.

From RFC:
1. Added Reported-by and Closes flags to first patch

Zi Yan (3):
  memory tiering: read last_cpupid correctly in do_huge_pmd_numa_page()
  memory tiering: introduce folio_use_access_time() check
  memory tiering: count PGPROMOTE_SUCCESS when mem tiering is enabled.

 include/linux/mm.h  |  6 ++++++
 kernel/sched/fair.c |  3 +--
 mm/huge_memory.c    |  5 ++---
 mm/memory-tiers.c   | 19 +++++++++++++++++++
 mm/memory.c         |  3 +--
 mm/migrate.c        |  4 +++-
 mm/mprotect.c       |  3 +--
 7 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.43.0


