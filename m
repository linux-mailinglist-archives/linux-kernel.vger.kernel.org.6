Return-Path: <linux-kernel+bounces-572042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CAAA6C5C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AA11B62269
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D65233156;
	Fri, 21 Mar 2025 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N0zXqVmO"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB2233707
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595327; cv=fail; b=gu6ki/tHjD7rsPHj6c944r8kIOLzaQLj9J9vcfq+BBQgQOMynCIsOurmFjP2w2alPoarsSqkF2Ex02/BFBDdPHhJE5Rk3Ftw4NANrL8uh8hByncsDjLxsFw/5474XgC9mTjYS7fgAKikR/QarViZdW+4CMWQmlNOOf8XA9PHpg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595327; c=relaxed/simple;
	bh=Z72sw3mb4sHRC+9t+aDJThWwHgW16zfA6gRB83X14dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8lSQUzC60OrJ6bE+xL7lHqWiXsi9Fcvyn/T3osc2sw0U2Hn3RFxCZZaiAgRSphyvZLOABBfjnC+nL8O+p2OExEhvnwYJEeTBT/81NUCF8hNioo7QKOzGD1LMLCVgVqtBl3o2BKpY3ieb/zO5onWhV1IN8GXu3f6VIV76XXjU5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0zXqVmO; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWllI0BzgmXIi8o3cS7006Wy4WCpMNwf11Rb8oiuS7jjuiwzVwEyze72p/BC00+deYthNDt4v6hZb2W9YPt6X1EEkGd7Q0TH0sq/bFcRvd/fAH+07hMxZQ3ujIv+zTmmyuO21Xm7twL0iVUD5caPjbtZ33g74uUM97kdS8mCWvrftBt2CM8l4R9cKL+FqmaTupt9de2XXGaTSSHkQ9RKwPMYtKArPRZZWKZqgCTQptcnHnXNtxWbr6TA8HI2lcU6V0Qm2+qBN8hbXq7IAsK/C2t+gUTZoT/Xql3ZV2CeBs8slFMEyK6ql/lk4HVUdUJlllxtI0phbq3jWfM+DL/o0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhSJUJle1DXZV5qMiBGMdYFrlL1CcNiinK01hbZsu3A=;
 b=jAVxsnUiRX+2QFw/kuUqdjnfbg+Qswc42rFkHEhXK+TfWs5DLU+pd3HUIaNgP2ORxi7iUfkbUUE5jIWtWvfihW46OxkpJEQCVtIO6JZHDkFWIY46rWhuEhnvtdMls04H7ElFP3MXcVSrAhaFS74c+tCpX46cGg+2vL4e2qRGpoMoxmZyj/9KyI2WIrE1b3BfR8aQKamtl2TldAIvTfA742wJh4hwdiUBKUZnsg6lSk1YEgKhF0jfzZSywq9NeT80DCsO5Ip2vVompWcKvNtO0EVD0ArQ/du8Hu22EuHi17VS7rp3Oofsvmb3Ki6xuOmjCtu7hrYtsiUcwHMUZnN5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhSJUJle1DXZV5qMiBGMdYFrlL1CcNiinK01hbZsu3A=;
 b=N0zXqVmOagI1MbM2sOiSiiOG1rMuBUFUd+JzHaKEayyIB2A+885aplFHovM4xgOrMKuSRVVnguB2xksKFGKXSG2pZkmJ9sLpVQsCtjaZzkBGXWYjU9bhaZzKo7+0mdHcQsDUvgoK+ME/fTJa2qY1miFfu6luwbm1C+ppnkGhFZQTidA+3QIMDuuGysKRAjrrNMvpV1HN+2lrIijGXYMCjjsizPz/ovG8sizBbjN59zQWMhA9Ku6T1hL8XEoWYQokTfvOOIq84oUXXfGxy7YTVz+Sb5EmfHP7MOdCKb5Fh/lj6ePKesvFZXWyD8D6w5QRKDRX+pme7v4bbfXfbDIheQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:15:22 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:15:22 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
Date: Fri, 21 Mar 2025 23:10:49 +0100
Message-ID: <20250321221454.298202-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321221454.298202-1-arighi@nvidia.com>
References: <20250321221454.298202-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 139b53fe-30f4-4185-cb4e-08dd68c5df5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/axZoNG0K6Ey4onm4JK1qwFrSC7JED9B8KnLNNIHZwIU1lKt+XlcMT2r7ETy?=
 =?us-ascii?Q?9v4QRtwJXqUBrV73i4aOfVRJIaLvfxgyxreSjKKFROK/nHc5qJ1OmmuDv5FO?=
 =?us-ascii?Q?9Ii4zrsXQml8QztU+JTYX6h68sITQN8TKqeH5FGrAxhU35nRaXJYDsyh+oid?=
 =?us-ascii?Q?xUBBD+z2VhQ2lV0UtjmgPBpPm5JV9OjtRkLT3Zx8xIowSlb4UlfNyqelGvfs?=
 =?us-ascii?Q?SDfKQd8W0s/Uu0C/tPdLyFiXloSxvpQgmj4zd9GEIFKHAiov4TnQEE3Udkv7?=
 =?us-ascii?Q?QTNoQZIma4cQxLiLUeePIJO7e9WwPBia7U24wxyHeG9NvY+/QAoQR9wH2JHt?=
 =?us-ascii?Q?wNlDcefkb/Aj7uXQP0DMr3KWyJKCMD+PvfvSHDv/PeQEqNiCt2a1yIcCw5OO?=
 =?us-ascii?Q?NP/4nv8SN3HlE3kTSYuqGwa2iyQwx+KC79fB/3rMPMwac9YMrmGFrjaq2h21?=
 =?us-ascii?Q?H4PRPkcx5N9qcza6r9eDKMwjrxRrnOjWmLjg5BNwfoaLEMjrBhJE3buFm1QP?=
 =?us-ascii?Q?laHIynESn62kck3juz+K/5H2bD0RDv18RLuC0QXQcOo1E7+Jvw9ygpCvbrup?=
 =?us-ascii?Q?8vnA8VbPX2sHuwIE9EgaNk3iGTYv63HwmQEqFXfGZ1n2w3zQ/mXXHVsdijy0?=
 =?us-ascii?Q?1HdZpSdhpwW0qhDN7083/QKiMCTmd3tZpjd1FuvuW/acGgPaXWkT1h9/YHfn?=
 =?us-ascii?Q?S1y/yDpuLc0AvfL28CrSJy49pEsSphGHyRGCXu+fY4CjaPFoHvg670JDL38t?=
 =?us-ascii?Q?2ihV9sUL+GlcWO7GSg8FlyfD5IAE8FnTmNPb779sB81tq05dWwwyowGpoZRq?=
 =?us-ascii?Q?n3UyfEvbRD1qr6Dg4ucXtzKdOmUA7z01NRPdynrgI2slbXH4Yx5RihTKbzCp?=
 =?us-ascii?Q?X9fBeOJ7535cpLqU3LyKgRcBsWytuiPJc5zVCZOULBerJfNAjAoib4D0xAD0?=
 =?us-ascii?Q?FJlrvf2qqC180WT+PqHDhRcJoJqgAV1LFifE7haN8icBhljxqP6qF9v1BtQo?=
 =?us-ascii?Q?Wvg9wjTWb+W9dEEY4/9e+OmmH/RN3hkrQk3mU1pu0eSHC3arNU9EcH6oYLeL?=
 =?us-ascii?Q?4daHl9SLaFjGabLGFgRNilbOcchWUfEP0amMZUySJHxdVUrCoPAFItRcYGsh?=
 =?us-ascii?Q?7Mnq/Vu4/l/UX3o+XRqKnI2GSWoJzCuYP88FwyDgGqvkBkFDr1ESrXSqKwKh?=
 =?us-ascii?Q?/AXOf7rv5Q4UulMNnMEXmyZxTCStgh0qaq9QJA6XEgHDdYMftl1ZtrkgoKZK?=
 =?us-ascii?Q?IIwSvjNi8Ef8yGCC7l9PN6T8JLP4x2XkvpmdN4n1D+x3YQzUjuM6CcM3sZd7?=
 =?us-ascii?Q?BGGUbptA61dzE/UdhTJpZnW/V2xhih4rUDgaso/+ahMg/HJMD+/q8RoLpXzx?=
 =?us-ascii?Q?/RyJtqeGGb+LpEaXN91ONDGzmW/JDuYVAQEPeqPqKvc8zAZrnHwzn1CsSRFa?=
 =?us-ascii?Q?J/ZnjvZ5g3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UT0PuKrFt7oUTdIemcHGF4TuNptw/E+bq9VyOCGqkWPgFgwrwxA79V3910zk?=
 =?us-ascii?Q?V+HmK7rLky6ZkBfR9l61WHbonR6cvuuUwU89Gojj5wSM4csO0npPO5l/3dnD?=
 =?us-ascii?Q?KZhd3o3m0y5/3wIE/9MxeX74QyK8Pmzwq//hxSeG+rpjV6Yw+osIwZpOKXOc?=
 =?us-ascii?Q?EFE4SZqHfucnT2Ib1w/xVp16VNhPVeGupT0np17MFxcvCFCOtA59NLMqk4c3?=
 =?us-ascii?Q?9WI8KA4B2/TQKDUTKMcRuJ9KLDJ9viF+XjlkgsZActfke4kUEEXIBaTWuBP6?=
 =?us-ascii?Q?Uqrzj72UeyJALR85Qof/cz3xYFEDyxRs35IBpy7pcsDgINB6ayGehrvJ28CK?=
 =?us-ascii?Q?DKYRCislQzXelk7gBtYgr0xX/j/yjjVL3bbHGqv13yEY0mH7KO8pQFXE6/re?=
 =?us-ascii?Q?27Fo5xJRwILxghYqtnEa6XVVujPOkrTo3wVGkbaSna11Dc/YIigoaBsWZQjm?=
 =?us-ascii?Q?deSBCprofLPnjo6aQ9xvZxc3Kg0P++kMGnHVHA6Sa4djEUGiv/4GNOeXgEEQ?=
 =?us-ascii?Q?fC42q7Q9CoTysfouQvi2m9llXlFlmRzP0mnzllv4SATsoQpZSIRQwqDHf7XM?=
 =?us-ascii?Q?Vf0Mo2mDJgg9GY97gOXKX6NyuS/JR73mbY5b2RlAFhcoTXlrLn1lZsX6I1gR?=
 =?us-ascii?Q?xN3IJG1+tCky5reFMstcjFZ96sZZ5HYMP7swn3eBkacVSHWYPT+NTxZj4lH9?=
 =?us-ascii?Q?rEQix+rXfkbiIOObTKSx0Y+XIr34f6gYXR1vsIJO9hjUiqOWICn7OaXK5D+b?=
 =?us-ascii?Q?mC2woesrU2sEeWKWyruEPYj+4E1TtuC3muTh5UThRDq5JCqns/dsuZIPsUQf?=
 =?us-ascii?Q?vle7Y7zsvbEjTxmo/T21/biItLtR1Q0uv+U1IRIKT+LJHzD7M/+IgCtzWJlB?=
 =?us-ascii?Q?iGiMTipWgSfTyay5Rr0ZzdS1QiSq/OPYU2xE2rpRfoV6h/KH1MlQRzXVrnJ+?=
 =?us-ascii?Q?5AF8ufxJACkncs4ocIS+rV2la4e53Mmb56X2z+3k77ZraV2XxlQZDPDDnP9o?=
 =?us-ascii?Q?mXMv4EcFeQaYrWewOMoLTJIK6EAfbzhn0r96sXsDc/yetJurRgt7jYgaxgr5?=
 =?us-ascii?Q?SeFLW4dbulzaLwbpM5Tqg7RuL4M/aYDh6kwPAe0dtK0KY5OG4fKwxHvDKk2k?=
 =?us-ascii?Q?KdneLMnyNWCsrov9dAfhhcP/ZUo8fdKOROOxBaFFN+ZMEEln6RhtyYgByLTd?=
 =?us-ascii?Q?6OZ97W4z+0qeZiO4vN6eMx/Zjg2lytqanXtk7jpu+bcnVtxJptBScLml/IkI?=
 =?us-ascii?Q?OU/h/2ycLGiw6L1vsHEWIgdhzMgpcHsO3CNMZPSYPAL0zjs6f1X6ImT+GuPy?=
 =?us-ascii?Q?PE2SUra0cs3UQ1JbJH36ZD9N+omZT8OnYmyreA+6m3X6qIYSmZ8rJTwF10Q4?=
 =?us-ascii?Q?hgguCHcvN14jGvS1LzByWWE+5xegdKRNZz9aFhuG5i7f2Fi5AcgZifMyyWcY?=
 =?us-ascii?Q?bdbRNJ37RnmzlOsSrgcSw9fx8Fd4puOQJ8BVZFh3xW9p7Dr5KgMrxbDd0Gp8?=
 =?us-ascii?Q?z82EFDxFraL1Nj90vygpnV7aNmOdkettSe3kbejyWRcQZSRCiCsOHd5K2ZhI?=
 =?us-ascii?Q?P5IyowjG5aVqOVIuH3j+j7XdAKoaD2FGZnNT/rb5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139b53fe-30f4-4185-cb4e-08dd68c5df5f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:15:22.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4kJoG3o6BLl+Bn5rjqYkN7f4XT9yF/aVicjhukY/CVcbKj3MRe6v9jid3IcYpf7y12HPBAgr7APM5jBhEbzaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Many scx schedulers implement their own hard or soft-affinity rules
to support topology characteristics, such as heterogeneous architectures
(e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
specific properties (e.g., running certain tasks only in a subset of
CPUs).

Currently, there is no mechanism that allows to use the built-in idle
CPU selection policy to an arbitrary subset of CPUs. As a result,
schedulers often implement their own idle CPU selection policies, which
are typically similar to one another, leading to a lot of code
duplication.

To address this, modify scx_select_cpu_dfl() to accept an arbitrary
cpumask, that can be used by the BPF schedulers to apply the existent
built-in idle CPU selection policy to a subset of allowed CPUs.

With this concept the idle CPU selection policy becomes the following:
 - always prioritize CPUs from fully idle SMT cores (if SMT is enabled),
 - select the same CPU if it's idle and in the allowed CPUs,
 - select an idle CPU within the same LLC, if the LLC cpumask is a
   subset of the allowed CPUs,
 - select an idle CPU within the same node, if the node cpumask is a
   subset of the allowed CPUs,
 - select an idle CPU within the allowed CPUs.

This functionality will be exposed through a dedicated kfunc in a
separate patch.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 68 +++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 2dcd758681170..faed4f89f95e9 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -49,6 +49,7 @@ static struct scx_idle_cpus **scx_idle_node_masks;
 /*
  * Local per-CPU cpumasks (used to generate temporary idle cpumasks).
  */
+static DEFINE_PER_CPU(cpumask_var_t, local_idle_cpumask);
 static DEFINE_PER_CPU(cpumask_var_t, local_llc_idle_cpumask);
 static DEFINE_PER_CPU(cpumask_var_t, local_numa_idle_cpumask);
 
@@ -417,13 +418,15 @@ static inline bool task_affinity_all(const struct task_struct *p)
  *     branch prediction optimizations.
  *
  * 3. Pick a CPU within the same LLC (Last-Level Cache):
- *   - if the above conditions aren't met, pick a CPU that shares the same LLC
- *     to maintain cache locality.
+ *   - if the above conditions aren't met, pick a CPU that shares the same
+ *     LLC, if the LLC domain is a subset of @cpus_allowed, to maintain
+ *     cache locality.
  *
  * 4. Pick a CPU within the same NUMA node, if enabled:
- *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *   - choose a CPU from the same NUMA node, if the node cpumask is a
+ *     subset of @cpus_allowed, to reduce memory access latency.
  *
- * 5. Pick any idle CPU usable by the task.
+ * 5. Pick any idle CPU within the @cpus_allowed domain.
  *
  * Step 3 and 4 are performed only if the system has, respectively,
  * multiple LLCs / multiple NUMA nodes (see scx_selcpu_topo_llc and
@@ -442,9 +445,43 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		       const struct cpumask *cpus_allowed, u64 flags)
 {
 	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
-	int node = scx_cpu_node_if_enabled(prev_cpu);
+	const struct cpumask *allowed = p->cpus_ptr;
+	int node;
 	s32 cpu;
 
+	preempt_disable();
+
+	/*
+	 * Determine the subset of CPUs usable by @p within @cpus_allowed.
+	 */
+	if (cpus_allowed != p->cpus_ptr) {
+		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_idle_cpumask);
+
+		if (task_affinity_all(p)) {
+			allowed = cpus_allowed;
+		} else if (cpumask_and(local_cpus, cpus_allowed, p->cpus_ptr)) {
+			allowed = local_cpus;
+		} else {
+			cpu = -EBUSY;
+			goto out_enable;
+		}
+	}
+
+	/*
+	 * If @prev_cpu is not in the allowed domain, try to assign a new
+	 * arbitrary CPU usable by the task in the allowed domain.
+	 */
+	if (!cpumask_test_cpu(prev_cpu, allowed)) {
+		cpu = cpumask_any_and_distribute(p->cpus_ptr, allowed);
+		if (cpu < nr_cpu_ids) {
+			prev_cpu = cpu;
+		} else {
+			cpu = -EBUSY;
+			goto out_enable;
+		}
+	}
+	node = scx_cpu_node_if_enabled(prev_cpu);
+
 	/*
 	 * This is necessary to protect llc_cpus.
 	 */
@@ -453,14 +490,17 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	/*
 	 * Determine the subset of CPUs that the task can use in its
 	 * current LLC and node.
+	 *
+	 * If the task can run on all CPUs, use the node and LLC cpumasks
+	 * directly.
 	 */
 	if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa)) {
 		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
 		const struct cpumask *cpus = numa_span(prev_cpu);
 
-		if (cpus_allowed == p->cpus_ptr && task_affinity_all(p))
+		if (allowed == p->cpus_ptr && task_affinity_all(p))
 			numa_cpus = cpus;
-		else if (cpus && cpumask_and(local_cpus, cpus_allowed, cpus))
+		else if (cpus && cpumask_and(local_cpus, allowed, cpus))
 			numa_cpus = local_cpus;
 	}
 
@@ -468,9 +508,9 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
 		const struct cpumask *cpus = llc_span(prev_cpu);
 
-		if (cpus_allowed == p->cpus_ptr && task_affinity_all(p))
+		if (allowed == p->cpus_ptr && task_affinity_all(p))
 			llc_cpus = cpus;
-		else if (cpus && cpumask_and(local_cpus, cpus_allowed, cpus))
+		else if (cpus && cpumask_and(local_cpus, allowed, cpus))
 			llc_cpus = local_cpus;
 	}
 
@@ -509,7 +549,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, cpus_allowed))
+			if (cpumask_test_cpu(cpu, allowed))
 				goto out_unlock;
 		}
 	}
@@ -554,7 +594,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -602,12 +642,14 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
+	cpu = scx_pick_idle_cpu(allowed, node, flags);
 	if (cpu >= 0)
 		goto out_unlock;
 
 out_unlock:
 	rcu_read_unlock();
+out_enable:
+	preempt_enable();
 
 	return cpu;
 }
@@ -639,6 +681,8 @@ void scx_idle_init_masks(void)
 
 	/* Allocate local per-cpu idle cpumasks */
 	for_each_possible_cpu(i) {
+		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_idle_cpumask, i),
+					       GFP_KERNEL, cpu_to_node(i)));
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_llc_idle_cpumask, i),
 					       GFP_KERNEL, cpu_to_node(i)));
 		BUG_ON(!alloc_cpumask_var_node(&per_cpu(local_numa_idle_cpumask, i),
-- 
2.48.1


