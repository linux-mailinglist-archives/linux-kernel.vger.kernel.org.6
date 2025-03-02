Return-Path: <linux-kernel+bounces-540809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04839A4B539
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B074316A6F7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA751EEA35;
	Sun,  2 Mar 2025 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SZ61vA7R"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344681DB933
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740953353; cv=fail; b=TwxHjcnKSC5S0m/bhyED4FSCzObNIhGd09q92as8piAD5i5mHwfXPMTH+bIkFPB48iMNS0peYIlp99omCag+4wcmMnLPSlh8P2cc+93vHESx9xa8N7WgLi1CPTNdJx3RQBeBBVBLAVpp7zugW3wKIWwETTpo1mDwRBksz3pc3VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740953353; c=relaxed/simple;
	bh=bByVcMN5aYjiTRQ7FI+kn2cigonDRELt88aepnEHc74=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KjIFaAfFu7LG4nEtCh4huJW3aj5WjEXfTGyEcInZta5s4dG+Wf8SgpUdEFDSIfhuU+/RNgdLU4c4zsfE+XL1Z5kGiSehWLHc0crJGrz6okIfWVOCizgplZXTGDxLxhlexgT+lokpHnXWRraMCH59TteTGDr3BLhKMNK1q4US2c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SZ61vA7R; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twKRcLqq+Yzh3Yzf02oVr11C4T1cAm3kcw5MCjd/UEHnvkPzpk4a5ItUIGv2nA/BghFDIGjxzisbdhrCUK1U7ICA21jyKIFdIGRK9gv28NWKJEVGgGIdXxLSb6dVvfFYYOaZwXUg0APPQ+WoxBbtgxGKyCJtC/EIv09WRRM/y7W49ZD8aWsaD7qWDQmUaGUGchbmfzuB4xVeRpQNqr7Rje/+DBsNN6Sy/70AdwzX5N3MqoLwd62ZawpmTCHm9r1glScy7XvrFHQmT5nw+WzrA/xIDtemgiVEGhbHFvlHkPEXVXoDcIIq3QkZV1cq/B3seaCMzHM2iA1mShWPmxYv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXfVH66K9TQhSPr+LezfAV05o9iM4tFGOPjIow972wY=;
 b=ZVV/qfzVHLFec9rApKLDOwKS9AxxPAYEOlx2BZk7GX9NZJjjUs8T0JO8wq/mHB0OmIQPvtU7A/vOhkxwnp5vSEXG8zYK64jqDGOX26DXQGjLzmgWRFRWn3N5qS78OjeedwVeK1hcDTg9LMxvTpOkPdOt7d7M9BbQLeKTZsyhmiBBUUCqO+2NHeD7rREqNsOTxYq2ct08tsOpqrzTesJOpmudxMQ3vgWNhCy7SUVd1JWIen0rJNFqNMHq1CfAEnzg5bbeMb/82xttiXNG4cqzvP0TXf9Sdie6NKGfgitKUd+nIyF7PPE9FyvfnPRKiej3PQ0cGmeTA02xL8v3exk+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXfVH66K9TQhSPr+LezfAV05o9iM4tFGOPjIow972wY=;
 b=SZ61vA7RuN9vddrYKi5XSY94sZaxNL+UQZwTLeVPXFxe7yQEBOD/0+P4Fc46YO+W4waKn/tyBU308Vv2Tcqk09Tt5/DRr2N2a6Sokiydm90oSJf9w23AdyqIAJgALYEsIGXlxXLGiliVZg2HFrRKIzwgkrjN37XHJ70dM+6ieT5dJXbmWoVDwNcjhS+/a012hXK2NeuhFWnqh+U3BD3HUyqSMmE83AlZo1EVtNYsxmsoaYuVxiaz727sYtTAdGmJvoZgyd1ctbSOF00jGTFm34wXnP4B8YPQ9fzyGtFpeLa5wUDpk5EFL9ZCpk1VjbKm3Ex6gabyLHHrCYR32pD0PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 2 Mar
 2025 22:09:09 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 22:09:08 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
Date: Sun,  2 Mar 2025 23:09:03 +0100
Message-ID: <20250302220903.54001-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 798b34a8-4872-4f6a-61c4-08dd59d6da69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dGDeZxHOkvq/PhTjgIespZIH1evJVU/b7zGn2aExWzCjSidUcmfY2KdagsfS?=
 =?us-ascii?Q?B5tLH5ajJ1HyntgkytPnpfOsCtI1Ydy6E/OYY2Zp5omq89gA1F0CjDsk+eCN?=
 =?us-ascii?Q?bYFJRsDbqTwJuAt1I8Gm+TPjmtNNamySnq7pLte/zXJqOgCW/0+vn4O20xw9?=
 =?us-ascii?Q?gzBXgXikCaRBALcpSFiIGiI/RKQTf+2BR7HEJyXslGlK8QEkPL0jZ1S/0mQR?=
 =?us-ascii?Q?AqGGxx7WWyVYCR8VrmwgDUGuP8MxmY9w7HUdwqdenTBW2HSbd37xkRYW1/Co?=
 =?us-ascii?Q?AX2Bc7g/BHWSRc6YRn9E6Mu1uvNDih0K9Stz9VCxAwvCJ7b+NfR9E3ucpUYf?=
 =?us-ascii?Q?yo9Je7yO1p34lVfu9OXdJVO6I5nPc2RcjhX4BrGAPXWYYgU33L2hm8S3ciyG?=
 =?us-ascii?Q?VATNgcVbR/71Kp+Srz5Sb4s12DJ+lf2u5wZ25JETc9/eDBNmNPyRRwaIoEFJ?=
 =?us-ascii?Q?M4YSgEHuLGTlaWnID40Sd5q0DDiiEnWJE61zS8KN7AAoWFzooyzTAqnwMQm+?=
 =?us-ascii?Q?s7gf32lhRWk4lnLuSJoLj4mADCnPjlRnOeinDYprpK3GALQ2+QcmdlDFqAt9?=
 =?us-ascii?Q?2+akggkoy6u1ZgPcQF3S4Jnw8yIuTNuu9JrYl620HyNC2smT+fiQPtIg9Q4w?=
 =?us-ascii?Q?RgTa8S2+2FNHYqo2FVtdUyukmtZliqNxZvGksxl+WRpRT/bun2AEV9DK7IF2?=
 =?us-ascii?Q?7MJ8NouyhQqPQFHbSv+3HNkLWRVfaMqUK/j53JoGOZaBUZg5ZNagQumF0zg4?=
 =?us-ascii?Q?wSvlrH0deD5WdtZEl0UVgPf2CgRxhqAC1BeyGNtH0plADhbJQuqlQ4PaIiGC?=
 =?us-ascii?Q?VFj/J1Qd8N2i7Kupexub6ITBgzwOwa0eIKJksM0uviJ+mngkA6SokOSyBd5E?=
 =?us-ascii?Q?6Fe47zOWXggMubj5nhALNlIEtveanf9LEf3NiaCXtDFD//uDfjUBa8ToWOdr?=
 =?us-ascii?Q?pthbSgscaASsVnp58TrU4TIeYxJ7flHL43nWgtE2t5casglXwT8k5uZRuQBO?=
 =?us-ascii?Q?APhbPtyJuV00OhcgZR1KvyYOeYZFakTCcCQzhHczA3OsgTihNKyg6HgIAiwi?=
 =?us-ascii?Q?YgOgupF8otagcTnjTFSf+/UHK6lDZq7GPgLoQDuQhhQYARerf5p/9U/upzHB?=
 =?us-ascii?Q?eg7gznzyuFDnc+GwO+5pvVmXXhh5axixAQTWRAgFrUu55hntct63wunEBCgI?=
 =?us-ascii?Q?q/fA7lzJwr/7r5/D36Cm5ZKk8twevR0x4S+g7n73XulELKWwPSCxSDAl6u0W?=
 =?us-ascii?Q?Kzp5RwfHjfcxup8ljVQ29s1vCwnHrmPqRhu7qe9n7HW4bR3RJmHNeNogO9fO?=
 =?us-ascii?Q?KYJk+lrHqUbW9r4QkbTcbHFWC2mYMxuau3KOOBnKYNbB+xf8wPqmNc2vMHG3?=
 =?us-ascii?Q?zDtcEqvyGwzpKaTlayRKdoLoi0p/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UTMyZxMa43nQl1Ksa5zlD3dnPUb9lajLK1TAv1znLm4sEzsK0BA4IdxhMzz?=
 =?us-ascii?Q?yqISAJ/cL1aIjnzfcsbVq0gjVRUyLG7Ks0PIWiKVJe0UsJW211ZwcJltkLlk?=
 =?us-ascii?Q?W2F3q5rChCx4S+ImWzU6AShbyPHOT8xJR3JPPGinhpQ/od4MiJ+1ohBx0Yc3?=
 =?us-ascii?Q?+ooFI3vvpde7W8syABJPyEW679POIu2qSM4b3z3RzHrWnOXsAIHKXYyG1O6G?=
 =?us-ascii?Q?dwpuGFIkp9f2yBjcXRs14ikJYrYciPFfMtdoUaVRJLqcrrMzO3YihWBvaaYD?=
 =?us-ascii?Q?H8JTLE6zisMhwcNFFb4ZHnT6Pc5Vtj3WUZeNDMJlbL5lP9w0K2gTZYnU0Uyy?=
 =?us-ascii?Q?KASrqUQCGT6VAZkOYnJdobyvLgsgfGV0kNk/CMK/VEX1D8iU49LRZP1JpI4E?=
 =?us-ascii?Q?9R0NwvoOrIRuqYYII6zIL8V5am9wAz2GM6ohU+1u0M6mChm/1K7hmEoIZH64?=
 =?us-ascii?Q?lu6j9XMXTQ12Hpo6a2FIT02pGDwkgXvRnVwrJFcTPU5TfdtBFEW0nHovhA6+?=
 =?us-ascii?Q?kfPZEWv8lkjgt8daLN5b6glidIHoS7KzxrO7oCQXtuReRPzVIXzpfhYl/0o4?=
 =?us-ascii?Q?PpZW70dzT0mZz/OEAfM/iT9OlfW4Oxqwy8UVYXr2bVXw0NLKrq5J8N5NY6G0?=
 =?us-ascii?Q?MmUl/wxFQEYZKhbvFEOYWthZZV/KoXxc3pRYfU4TkEi5WiaKaenxXpX25jTG?=
 =?us-ascii?Q?or8g/w2SyLPMpW+DY7Va9xW6ZEa/BFTIrWLaAxGTmrzA/whj/vUxxH50bFaU?=
 =?us-ascii?Q?My0EifYWG6VuqXLGFnKycNuFJ6HE9Mky+OHeetRkHrbzpv0HPhpqHHK2eRLM?=
 =?us-ascii?Q?KIIXCStMTV9aelsSt0Z8OYigtrRLGOP4Uo2qIc+CMnrUXyvaSmj/neIGn5pX?=
 =?us-ascii?Q?wU22YFetcdWOe+BuVxyJqqiOunK7piJBSLZEFTe1FEjOtvaG981umwrgFXFN?=
 =?us-ascii?Q?yDNruUm/yZnr0lHd5K6F63qHUSGURzXTvHbD2y+0Zg2tH2ktPD54xeB92OWB?=
 =?us-ascii?Q?UNwtHzTCsXVGpWAjGcUfxMGB7l2FjaVLlWTeAQNbr43UsacOshQaRwEYM5rI?=
 =?us-ascii?Q?d0FQiI6xr1J51+BpN6BDTFGiTmT/D1Z7Vw/SPQlzMznEkMaQVKUIkJtFBNF4?=
 =?us-ascii?Q?gcXOtiUkgnO6Hj3z3hXi54ytQlVoHVpS98cLKwh7tM/YpfMeeBMD193TwRfT?=
 =?us-ascii?Q?7tL1HDqBRY/yTYa3BfAw/2mhXfRfDYWFut0do7+X6ETiNGxH1KATESEQ60dY?=
 =?us-ascii?Q?vC4prylEKffqXtckuvO+jUzd/O4mc9B+TeajenS/DLFVwLgFx4Vr0HqroHEW?=
 =?us-ascii?Q?1k39Re7xC9DaQCdYkbzuLaVvA7ZZfZRL4sUZEZHWOwt+PyuBTEU19xJwmBRI?=
 =?us-ascii?Q?gZyUo5wwt/aCdsaadKcybxgzXdg3JxJVctd8K79l+Yun907N0EtJfni0UnCY?=
 =?us-ascii?Q?N5/goeDBVHH6+oZjbocWLRmJYndTle2KoHvkaN8eXgy2ZO0HgBN29sqrjeSw?=
 =?us-ascii?Q?Wm0UgLDAqdA/CA0u53siUC4mWGJSOSL9zOduUvP39vFIY6Rj5BydXIn0uIFo?=
 =?us-ascii?Q?qpl3fHryi7u6SZ5wuFUkpZ/jTnJkvNo7jX4jrWF2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798b34a8-4872-4f6a-61c4-08dd59d6da69
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 22:09:08.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0neddGNNEY3xMcDr7o9sHRzfwvTyi5F5uv50K12lqUlnG236PbOJFZlUYcE2Tn7l+RWU/5+QdduHm27EuKvIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

If a BPF scheduler provides an invalid CPU (outside the nr_cpu_ids
range) as prev_cpu to scx_bpf_select_cpu_dfl() it can cause a kernel
crash.

To prevent this, validate prev_cpu in scx_bpf_select_cpu_dfl() and
trigger an scx error if an invalid CPU is specified.

Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0f1da199cfc7c..88b2ea58ff942 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6422,6 +6422,11 @@ static bool check_builtin_idle_enabled(void)
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
+	if (!ops_cpu_valid(prev_cpu, NULL)) {
+		prev_cpu = cpumask_any(p->cpus_ptr);
+		goto prev_cpu;
+	}
+
 	if (!check_builtin_idle_enabled())
 		goto prev_cpu;
 
-- 
2.48.1


