Return-Path: <linux-kernel+bounces-448967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA89F47CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FE71886285
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5791DED70;
	Tue, 17 Dec 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzxwU4jT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB11DF251
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428539; cv=fail; b=kWWEn1zJYRbYMcYdCMP6F8xIg9M8rqmC26mJP4AwH4729jVf4uMi4IIQJ2WJBKiZbTvJ8cxQCqcKO38OeOTH8giQ3ksJI/1uZfOt2aicHhYXXMwjI2f+1RyXpZAVnlCyex/qYyunjJln5HZAOr5hnNXohv1eS9dmszej7muAP1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428539; c=relaxed/simple;
	bh=26jAsmo4gfBAUHA74XA3B9Fi1CpbodmHMrmphx256+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvobwwR49I+0RUM3GNJttwQ5ChAnYe4Qk/AQweXl95EGI8QB9pmGMWoP4aZlzOaoEPPazheYoQhgG2XRb3dSlBpH3A2c/z6kPlwKM+yRzq8iSq+8aiamc33TLmVrJe8lt20TX3y3Byabjm8b93ViZfzqCPWroWNLZEWwUFa325U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzxwU4jT; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q04Jpvx236Zfs6KiUIlsKPNkHv1iopX2bUACatmEBinQfpjN7JGrYGdd7Fs7Cpqol+NlAZeiywtUlreTMKhtzckV9g8w6B2qIB8iejlrHDnhT3z77DztX/70R8FvyBd0I+ubCxAU6YgnO+ukZt/VP+W/Ui0oqEF9mGf2ql109sxZR1DrDy1lYGnZmzsRa4zpelN7zA6+TwY1mXB0GJCW7tDwi+I0sPebc+TsY6hLjeOrzZckUQb7xduyntg5EKfNosYYk4+RmLvF9iZQUpxXGO+7idbCApxM9uwynW+ki9MUyMsuWZMop3sKqq5feJq6If6rEQ5O+DRvcV9UVGXU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B2js7uS8uGAj8Sq3cUWzGTwp2fnczcb+uSAd7VpbTM=;
 b=WtVAuyRBkqNySVzIhtiEvUb7AW8LwBTlr+M9sCR8GF3Ua/0kKAJZ1WSNxet++NkrdDI4u/l406U5YEAkkft4EHzoz7u+0Nct33LP4uZVyQKT4A7z7ef9x/a9prMzBuyKdLjc6guxOWpWdWjsA0IH1TR3fyq5/WgU/PpwVjrhGSNPG8Un8YG1B087dsfBT7sycTQag8xO6GpAjhMZYxug0RbtL7jNyhX6BXkx90N6c9mEfuNuq4DXJdzoWnYAVOMInUCVYnzH4oPylqnvAQmIT7qdiyRPEvPsQiayNqvIgOMEqhmMicvyGDNqKW5h+c7guXaPINh+97lASjD3GoOHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B2js7uS8uGAj8Sq3cUWzGTwp2fnczcb+uSAd7VpbTM=;
 b=lzxwU4jTgXqlwT4bR2gneQMuiLtZqOGq4dWC+hRATQI8Va7HzTfHTVMa24tbH5owzOsKVHZi2CP4+ROeit4yog0+Rz0mv07uNlR5dZGMJemablpDMpJf+3hysRrqJWkymnnrwGgPJOHd2SRG9dj19KRpCFdZYDYotVNYpxnYCzWKICtHD5hu1j137NyYAq7YyRArJvl9mAhFKqP3+eS/jS/bWpuZS92SfZoRiDFgWUYlr0Oej0hfX5fJEREEgrgePBvMCQan78rNkJFNlhNBfm6+YZv9VGxyh/7ISDMvxkKJuED0oIOyCaOgna7Q2O33Ln48jTvCdgrc3v0X/oLZKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:42:15 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:42:15 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] sched/topology: introduce for_each_numa_hop_node() / sched_numa_hop_node()
Date: Tue, 17 Dec 2024 10:32:26 +0100
Message-ID: <20241217094156.577262-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217094156.577262-1-arighi@nvidia.com>
References: <20241217094156.577262-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e37f83-9abe-4bce-d723-08dd1e7f170f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ldIf3CsEJtT2Ryq60onzy57JVJQkMoWb8Uerh8kpaUSZRtWfEz+yTa+f+wz/?=
 =?us-ascii?Q?0U8VPcbZmvk1k5MNnxl8NWEEbj8rdMW2Vn7OABuwr4QzfKAjs2q1/aSB4Hqs?=
 =?us-ascii?Q?ZEOfK4DRbhrj9lwAZi3fhzxiXlYZ7GbN2coHBvlSofpkFPul1Gygi3WjWfcB?=
 =?us-ascii?Q?KjpS6nxfaAYiKLwZPwWfQMtVJ7x04LNdGIcFrqFmI6NZzVSLIDZoklFT9oNR?=
 =?us-ascii?Q?ZkGuR2yrjI7ywQuCDB0gBg5sZYS3c1h8mU8WlfgMsWCfgV9X6GEWdv2oSFsD?=
 =?us-ascii?Q?1Jd2Unpa7k+tjQCDIglo9mfAvHvaU9jZ3tnkUYMkYDCU9kH+5192VxIMMwPx?=
 =?us-ascii?Q?Xxisa0hTiULuPKPwSyqn5OgoOmkfaaTp/mJYvlWvOaFCHkase4R3LeE6z4oB?=
 =?us-ascii?Q?QPALBU9M/99h7eNnmbyCc7juGwgBykqfMojNA9uLEk5Sr51wMtYCq/tbaIxd?=
 =?us-ascii?Q?cZbzcUAPmgnEaYcLdLVfxEwEdQ+VBGmF2GhqtofFfn0paLzeogdcoQzaJbML?=
 =?us-ascii?Q?zZgR6uqFh/18aFCHoyFWWzUysdnpzZ3PO45995cgIUp1msU1MQmqckJU8Cmh?=
 =?us-ascii?Q?FIzrUtXJsyxonOjAaUrpyKXihQxK9PQ7SPbMDQ8MfXsoyXBju2ALlY6l4Hll?=
 =?us-ascii?Q?0HGdF9lzIx2b7uZuX8XO+aZ+UQUGglt0Jit3scmwL3TDMnTyI8aIy4lwVI/o?=
 =?us-ascii?Q?V1sOY6DDWnxqD9gz/Iv2Hes8u0YdfvH45Vb7Y87rMm/DkMFyRjn3Z4EzEVH4?=
 =?us-ascii?Q?/xbT5JpBhj3offK9ri8RaUpUw3NO2LNl7Q2EVoJKWh7ix9C7W+XJIIB+yNRG?=
 =?us-ascii?Q?IGDNVZnf1krMUMM7KhmFh57AUNqZ0hG7RfGAL6db1LEddDkzz5eKj3KQ43Ko?=
 =?us-ascii?Q?hcuBwmQVfBE7jXHsBcHHErDkvfF4PgyO+tmTot9NJ8W8L9zbEgOwpzsTpRUG?=
 =?us-ascii?Q?Ui+7oA+AdS/1ocLMb75urD9WeJjvm1/X8FYem2joIhoi9u6Ly3+N6vgt90SW?=
 =?us-ascii?Q?uoPlhuT51gE32hd74tZ0bN8ByILkEBOHDxGxDQlDUuHIM+x6p2/dl+Li3hqH?=
 =?us-ascii?Q?K9M21MDaiRz+0kRqf9a0X0VyrspFk+Fx1qA9A707aj9CAj8UsZp1dqSCxE2f?=
 =?us-ascii?Q?xIsY4XQtx7YNpmtDL6BkgddWxqP1oRxnItyYB4mSW1dEd2hVBsYRlmEgH1Ag?=
 =?us-ascii?Q?hjXtUV0t4Ft2bD2Of3EjiU5fFoUlQbul/OCipE8qy2lGaqNccNbMbq+L0PAS?=
 =?us-ascii?Q?bpP/UAOhiQO5aSopVrdEI4I+jyBRh0iR8pYYujN9yVUmIddWo6+WEHfaNFab?=
 =?us-ascii?Q?yqd5BipkiPHUkyLTV3HYZUhjp+oN7JC46Hkbe9WHqZjKtE56fH3DohDZIVyn?=
 =?us-ascii?Q?GLc6HRyIlDhO1tJbAZURnuh6IEEI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eH9JAm7ZOvqvQVgBf5pzESwVfMTsqxsndHAxxgfQBZKl5jTWv814S32Q/DYc?=
 =?us-ascii?Q?kw+7Ym7i5sUDH8a5o08aOIxw7VmUVGj9eKUoRdWhE7EKYXLFyzhvsN3Pq/Xy?=
 =?us-ascii?Q?kcIxO/Ww6YIp2OLU/Cy488W3YV7j2jhXUFjRRBWt+IhMhsegP7ASbeD/Bp6Q?=
 =?us-ascii?Q?8Dr8IYMwEEOAcDIoSyw8G5UVDXC4hx3EF47wFl86YJaGix5Ytl65a/lTad+g?=
 =?us-ascii?Q?fFg7VeOLNUKB324Fyo38t0wrqkWm/viV+aZSF6Bdng7au7x9GBt7DJgXI6md?=
 =?us-ascii?Q?RahqQHiWLNg76A4qwvflOb+riBVduuRwvSmmKND3jP+iOL+Y+J+dCiXsbHJd?=
 =?us-ascii?Q?oAk691mMwri8gbNKJDUWM5JJlYdZY63axsmJdMzllTllf9rhKUO0Y1OMb4ve?=
 =?us-ascii?Q?x8LQElx2ue2FgsrdedK3uw6KnuedIfUuNtF4Ecbd98iYmL93vpbnolEkzgfi?=
 =?us-ascii?Q?7VDCd1CeGMy9y2xMjeWI9Bx3Niu+NkOWniMn2tMhe4vF3UgR7D9QcYtZL45m?=
 =?us-ascii?Q?Q3NR12Cze4kjdvCu2mc+LKtz325vv7bSaNvTMh3UsfZoojvv3KXNl3jUViQ9?=
 =?us-ascii?Q?eh/6NVphO9v2P8wrmo/swq9EOxMCtNp7hXzAenW4rukE0VExa1O/lBUQgcOc?=
 =?us-ascii?Q?8+gd0qwWm2c6D7jEwoeLCZUZW8xAdjzSEF1jkh7fx++EdJxg72OZzScnsfNS?=
 =?us-ascii?Q?zk9NCm+TnRhEvWDv4XZrt1zX/X/OVqA3/0XFLInS3kca9G2Rs8xIe3Vd5HTA?=
 =?us-ascii?Q?Ak6B/2CMBsFnQAKJqf9a+ofEkjkWG5zltX90fpMT8wxtDdI2nPPerc1JRq8A?=
 =?us-ascii?Q?i/bTPKD2e93bwzXMXpXx2L8RLiAe++uJ1zNbfDsxG+FuaBSENOzMpPivXSX8?=
 =?us-ascii?Q?X/4lMO+fCojJW4htuqsZabc6PxfLnok0TYRy/bW117+Dgo90LOpePntxSQ9i?=
 =?us-ascii?Q?tsENRG7s4EOWn47EGz0ph1vLj5/R+7ux0CY66RH2iP9mIBzQ12VrqBpaJS+n?=
 =?us-ascii?Q?HqMnnaGJ4jNtzWNsW6jf5pIIIiufpQF9ip5xJUL3A0gGjGnjVF9u7AgK513d?=
 =?us-ascii?Q?UGvm/8ML1S+KSGjrPDyKQK6wWSPtsMughYKsU2p4zn9UMTFtg4ij+3DN8iSF?=
 =?us-ascii?Q?vwphzyFF1ZhG74VAktxqglUcU8qgyJ4qKHNjyaPbmYAnnCT9dB+XR8C+Kk0V?=
 =?us-ascii?Q?itag2zgN2FYQedCBeE7PfyHuyzsqGm3ziGmiimq6c/gNztgI7fPr1kgB0Kbl?=
 =?us-ascii?Q?Nj/XOy45vurb38Bv1DL4VxW21mvYf+z/PklSYZEm+cnldxV2QCorWxF8Y3J3?=
 =?us-ascii?Q?WU7Ri4/WCO7n4i4HYqMw/7PZnlQgnZTdbrALMEw3MVLrB4lHWgh0KqiDAJDY?=
 =?us-ascii?Q?HGFOzWegkaGMXEOmFR7g9hIlmYBvKXlnpW8okuPNhvTpj7cjUR25zzEeu+I6?=
 =?us-ascii?Q?rEpuYE9vRHDUKCdwK9FK2CzlFLh3oAZ5/Mh56evoo0buyWtMR1rlIGV5dr+B?=
 =?us-ascii?Q?ytjdZBehx0pNHrq4v/fOwmoMwMuh2YbnUxkhageu0tzZCT3grWiW3w3KnCPJ?=
 =?us-ascii?Q?jEQTltvIw67ZF4W3/F+8uO/ZEEA41t5CIfIjBxSN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e37f83-9abe-4bce-d723-08dd1e7f170f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:42:15.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRiPNBMD/a1ceCcUjlMHDxb/B7qkXHExJhFZBh47q3+fmVUSGEXnI7f4a0DM2w1WeDn2MS3ioVPLowpi9fZgVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

Introduce for_each_numa_hop_node() and sched_numa_hop_node() to iterate
over node IDs in order of increasing NUMA distance from a given starting
node.

These iterator functions are similar to for_each_numa_hop_mask() and
sched_numa_hop_mask(), but instead of providing a cpumask at each
iteration, they provide a node ID.

Example usage:

  nodemask_t hop_nodes = NODE_MASK_NONE;
  int start = cpu_to_node(smp_processor_id());

  for_each_numa_hop_node(node, start, hop_nodes, N_ONLINE)
  	pr_info("node (%d, %d) -> \n",
  		 start, node, node_distance(start, node);

Simulating the following NUMA topology in virtme-ng:

 $ numactl -H
 available: 4 nodes (0-3)
 node 0 cpus: 0 1
 node 0 size: 1006 MB
 node 0 free: 928 MB
 node 1 cpus: 2 3
 node 1 size: 1007 MB
 node 1 free: 986 MB
 node 2 cpus: 4 5
 node 2 size: 889 MB
 node 2 free: 862 MB
 node 3 cpus: 6 7
 node 3 size: 1006 MB
 node 3 free: 983 MB
 node distances:
 node     0    1    2    3
    0:   10   51   31   41
    1:   51   10   21   61
    2:   31   21   10   11
    3:   41   61   11   10

The output of the example above (on node 0) is the following:

 [   84.953644] node (0, 0) -> 10
 [   84.953712] node (0, 2) -> 31
 [   84.953764] node (0, 3) -> 41
 [   84.953817] node (0, 1) -> 51

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/topology.h | 28 ++++++++++++++++++++++-
 kernel/sched/topology.c  | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 52f5850730b3..d9014d90580d 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -248,12 +248,18 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
 #ifdef CONFIG_NUMA
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node);
 extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
-#else
+extern int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state);
+#else /* !CONFIG_NUMA */
 static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
 	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
 }
 
+static inline int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
+{
+	return NUMA_NO_NODE;
+}
+
 static inline const struct cpumask *
 sched_numa_hop_mask(unsigned int node, unsigned int hops)
 {
@@ -261,6 +267,26 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_numa_hop_node - iterate over NUMA nodes at increasing hop distances
+ *                          from a given starting node.
+ * @__node: the iteration variable, representing the current NUMA node.
+ * @__start: the NUMA node to start the iteration from.
+ * @__hop_nodes: a nodemask_t to track the visited nodes.
+ * @__state: state of NUMA nodes to iterate.
+ *
+ * Requires rcu_lock to be held.
+ *
+ * This macro iterates over NUMA nodes in increasing distance from
+ * @start_node.
+ *
+ * Yields NUMA_NO_NODE when all the nodes have been visited.
+ */
+#define for_each_numa_hop_node(__node, __start, __hop_nodes, __state)		\
+	for (int __node = __start;						\
+	     __node != NUMA_NO_NODE;						\
+	     __node = sched_numa_hop_node(&(__hop_nodes), __start, __state))
+
 /**
  * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
  *                          from a given node.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..8e77c235ad9a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2185,6 +2185,55 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 }
 EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
 
+/**
+ * sched_numa_hop_node - Find the NUMA node at the closest hop distance
+ *                       from node @start.
+ *
+ * @hop_nodes: a pointer to a nodemask_t representing the visited nodes.
+ * @start: the NUMA node to start the hop search from.
+ * @state: the node state to filter nodes by.
+ *
+ * This function iterates over all NUMA nodes in the given state and
+ * calculates the hop distance to the starting node. It returns the NUMA
+ * node that is the closest in terms of hop distance
+ * that has not already been considered (not set in @hop_nodes). If the
+ * node is found, it is marked as considered in the @hop_nodes bitmask.
+ *
+ * The function checks if the node is not the start node and ensures it is
+ * not already part of the hop_nodes set. It then computes the distance to
+ * the start node using the node_distance() function. The closest node is
+ * chosen based on the minimum distance.
+ *
+ * Returns the NUMA node ID closest in terms of hop distance from the
+ * @start node, or NUMA_NO_NODE if no node is found (or all nodes have been
+ * visited).
+ */
+int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
+{
+	int dist, n, min_node, min_dist;
+
+	if (state >= NR_NODE_STATES)
+		return NUMA_NO_NODE;
+
+	min_node = NUMA_NO_NODE;
+	min_dist = INT_MAX;
+
+	for_each_node_state(n, state) {
+		if (n == start || node_isset(n, *hop_nodes))
+			continue;
+		dist = node_distance(start, n);
+		if (dist < min_dist) {
+			min_dist = dist;
+			min_node = n;
+		}
+	}
+	if (min_node != NUMA_NO_NODE)
+		node_set(min_node, *hop_nodes);
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(sched_numa_hop_node);
+
 /**
  * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away from
  *                         @node
-- 
2.47.1


