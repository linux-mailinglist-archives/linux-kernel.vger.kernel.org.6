Return-Path: <linux-kernel+bounces-529591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFEA42842
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C027A24D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888B2638AC;
	Mon, 24 Feb 2025 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4K6WTiN"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98226136C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415773; cv=fail; b=X2uPzw7DGvP4rfrjaMe1W24wuxbmR7gmKM6mtDHkZG9Zeh9fOtygkqrCf53QQFczXrednmr9GcTn0W5zkq9XcSDq6fFM3FCown59ZVBA6ioBGoTFuQwjy8r43neoQk9yjoQLZYwkpFqRj1k0biSVRFHHcTsfxBE5fnOiscEFpSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415773; c=relaxed/simple;
	bh=NS85qwbZbHCrOK5tyB89dzKOwNY4njtbFYEGiw+sM0w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e6jPDQX1cIguelHPUZxTOYozOYRsVFRkyOePTX+RMjLCUbhbZHnFBEAl17AAB9C6dyVdC0R70QVnOhY5e/ddyrU27JoK4VA7PUIC0VFMguYSb1l2nFik1PbXq5uxwWoSWbtPhxSwBung6FvPOJ0Yg7ioH838pP7Fnk3ODfqncN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4K6WTiN; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8gdRGbk6Qrh+Qco7MPBikTJbMCTknCGfqqJR7j33YD3hXVSXoAvt/Y4ZTUiZcDJXYi9F/4YpFoz8q++JYEb2wEfZ8z1+rKhfSMH83JAbsjyM3ppAzS+4LuR8N1xDxGyWs704kIK1nZ1zt6c4TFXnXf+Y2mVls1JsNH4fRmQoo73sJMpO9TpFqRlaj7lArEqV9MpUhN/K3hRysQ/Cil3dL+252R7noJBrwNwYTlE9VjJpIhsTxOPsS0Fn1NGs7bfH1u1L7AzAtb3Dv8a3BEaUOPcfgrBxieEKP+Kn21dtYMHCz9e0gZxEIMdYybWtGrdYQy6aV6/YAL70IIzdkkTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCHhoYT+zfPq9D03vhsCkvWTMo3cTKrheNMTvdToCyM=;
 b=r73FWUXy69NN9IdFyyvN5tZ9tTHzuZlC37RIdTLUloaSofq10D7eeh0qqpTi5+XQvyNMMOGuwW/gw9lZCATNocvD1Z+8sily8AEd7CDu+WftsBt0rc6/VmEkBwQIDYvrKfuSrPRyFlc6a9aG7zA+ofSyyV5dp5iRQnGR/8hPK5e2zMTfjZo/jQbLuNDDQ549NUvd/2che48hlCovL/beNtVlSn/Mjqp8E6F2UcvLx7cPIa6kgWeXuBjw2780YPlOp5xCB0qvH38JO47muJtpVqnXDfX7qL0CFAbgsbPaKghr+8RcVDS1smXanoG3igyFgyRqEdNypE76QCSjmiwJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCHhoYT+zfPq9D03vhsCkvWTMo3cTKrheNMTvdToCyM=;
 b=L4K6WTiN2LMufAkM/z48BOgbUMKPjFcVVcfdd4UabwQ208J79GxAFKYJ8b3qgUQSRO4MvKKCDG4oLvI7Urw09C+cRX/81Btc9OEteiZWWCWKC3mm5ycU74Jneivxo+cTf8eyvH04VRzwbL9uKS+csoieLGRO5WZOtVNQlfduG4CNGYlZ1gvxo3E1d9ddzB+M1uq1Q4Vu2c55RQWQc+EE5CYTU+hc/dyHwWFE1zu5t+9/JfxOFpbtSFRN+uTr4sb3kAbfhvl3IRumRGd8rhzAAVr+6N+HHgf9qzGq7j3Dze1tGy/0CYrZN8JNpj6tehz71D9CEgTPHAC2Uy5nDeZ2/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 16:49:28 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:49:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15] sched_ext: idle: Introduce scx_bpf_nr_node_ids()
Date: Mon, 24 Feb 2025 17:49:21 +0100
Message-ID: <20250224164921.214455-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: d4097a7a-b5f4-4b39-8c27-08dd54f3341a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0xHSh4B8vhDrMJ8R9bRUg3s/00K4CxGD2SVnQqk3/wFi23qLbaRy/kS+9siS?=
 =?us-ascii?Q?LYHc48wb/SQpaB7e3GgO1+ldoBsCp37W+PVHMNetHD7lzAuyT0vNDLc6Keih?=
 =?us-ascii?Q?a9c3hlFKJcJxzDIE9WxD6W2O+qUsP16BQeELnWN1Xkhm5K5WAMuHtpyqLArQ?=
 =?us-ascii?Q?SFnKjs5KVjme6h3qehljYNWKrEPl86md7BudejoR5HPJR5EL0S4BZ75Ch3Me?=
 =?us-ascii?Q?CEmSYiP9rJILWhA7bXcpC5K5XuVNlOxGZjXrdV0B5/UaT4NivmBxOSqA1Nym?=
 =?us-ascii?Q?U0GZM+hzYAq4FEDzoucGx9ENJO0M+RXHz+ojhX/n6MND7kmfwE91dlZAqAyM?=
 =?us-ascii?Q?b9qWOz15+aHoYY7cZXctsZxzWtonZtsPg/Gv6P4RnM7gujO9KC1YBaV/trgQ?=
 =?us-ascii?Q?04NJ5WHwqL2mDd+AH0aXjzOkadWhLBgwFOmQlL4ThjExZlvnv1nVkMMhgyOp?=
 =?us-ascii?Q?seAdP6cWA+7q3RoXrj91Ze657EHuZ/wDVgsZZsQGCxfpHlfWB5vHoTg5+VWI?=
 =?us-ascii?Q?iBzcgSFivBLwhHxKedJU8Y9pYtRvKiYZxBIvKbTNyu9XU/rPCCdbtHa0HuQt?=
 =?us-ascii?Q?q3px7IgoQ9Txut8VRsrqI8uCWjuNZTafMsXov6hUm9XVj2ZLuOi7vkqsI8FQ?=
 =?us-ascii?Q?uAr2gk43GKjPhCkTwz4aBkH1vQtOWlnUDhH2arnzO4CoeJkiJRUwgMBn1F95?=
 =?us-ascii?Q?K5LnacPSwu+IRFRKs7LStdyA2l0Yjm/zln1tKXs80r8+9o/l49/Zos7AX9AH?=
 =?us-ascii?Q?jMAQrxOEVvihrCE4we+mqmZp3F6sPJ4p9IIpB287GxbR3OR5pYgC/sRju2zZ?=
 =?us-ascii?Q?8kRQDHZx3CgQJdMdMFv9Ccco4Jwmf2PGkCyM9CuMmTPFvhpiWxQ/zsaWy2El?=
 =?us-ascii?Q?HGrUv5uM9TM59krpqTnXyp0524qZQ5OqnN4+YcfB65MEpWec6PyTu3+5zEtN?=
 =?us-ascii?Q?gj9ZhPOlb9/RzaQzrdVpAqKs4PpYFxSbGXOlBUT83wIMU9QvSFfPEnTxtKCx?=
 =?us-ascii?Q?+GsV/waclKwIRfvRwoQVAb5ecQ1GmuSrBLsFaK+a5kdJQsUQuslcM+yhlM45?=
 =?us-ascii?Q?vt4M9i/0GnZyFq2mrWy9LL4SypqxiYPnBEgTtjWH1DQiCFwmFDIzo2FB6N/j?=
 =?us-ascii?Q?dGYUUQXzOFlZMdR0mGeWD+bWhcZ4OqIaWfy1hRh2EaaXoh4mFX+lef8oBYsS?=
 =?us-ascii?Q?QlEINCkRM5mTimPTo01pUZUg1SmMZ7+jl9T+mp4IDFWhYzTt55adPlKQQcTq?=
 =?us-ascii?Q?yQkPFovFHSDLpE7epSm3bZmaPTI6S8IUejIERD6k37yeDrAEnJJH6edVCizv?=
 =?us-ascii?Q?99GKzeX6RHOlfBunonB8Qe6gjrHM979loMyWGlAB3tyJi+fCxr6VdfrKqyWR?=
 =?us-ascii?Q?L8B/Zpnajsia6+7P66YLdcDZzwnk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IrQIZcKIOm9OggeXdsw3+yt8HR9otunwv45N+C8pg5rXo3ufP9Le7TEXZu8N?=
 =?us-ascii?Q?dWiaXkjwlId+5iU9Bpiutt2/WvwU/Qim11lx0gBhQI7yvSpQ77RK1JmIWzpq?=
 =?us-ascii?Q?gkddnakhu1ibn6ij64r7TKX4BZIrNBgu/bh6vuO/HHhiNqTtfR349lsisCQP?=
 =?us-ascii?Q?sDv+KR0NsNlS+qDUCng40JlN7zXt0EwPdglaoBjcJwNAqOKqaT1AAjCfTv6r?=
 =?us-ascii?Q?g/Tk2AZ44N5g5l8OcPwyCV/PD5WVy4Hr//MKC4qZk+7xF96S1SV36XmsCgw7?=
 =?us-ascii?Q?WmPy2fjknTuPh4IBcSEYdW3EIbLrGDSEde7gY3KwldglYKlXgOqW/7/LazJN?=
 =?us-ascii?Q?f4IjWRoVpVo/UAWe3KLSiUJ7/+UIf89wnjj2viojfg94dPm5jZxxEDZhXP/T?=
 =?us-ascii?Q?ip1hpWAUBaLDaGWAG71b/CkrQ7LWHEZjU2TT++JboOP1bEawAn0kIz1rmQG3?=
 =?us-ascii?Q?i+CKMCMDg9sQ0jA+aF65pxg6J8oVSb3Iab9Z9aFTMSvdTDXXzAfevimx7ZSQ?=
 =?us-ascii?Q?KxaorJWAthEKgHzmhDDXRmfG+IwYSJIT6DOM9d0Q/bC8IzztytQ8NGj4b13D?=
 =?us-ascii?Q?9bbHL+gwnbYinxDZ6z63k6DJmwdhOhpE71ykRJDiv9fE2PT1fkCi5U01U+Hy?=
 =?us-ascii?Q?OV1K4RHR6PKAxHpGrnL4BK3jmqQacsnUj0COO6aOEsmv2dwmPKQwwHpNqUx8?=
 =?us-ascii?Q?UcSj76dXuBoIFUSbsPtXBXfWgkuEgwRQi0e9iT0FOowFA4TfujHD8OZIm5Y9?=
 =?us-ascii?Q?uTnVANn9/yjN9DVo7xdLVYIiWGcgKRW0+FCmOABEAxVkX+M0zHhJyFL5r6dP?=
 =?us-ascii?Q?bqyAeyf0HSHGq6n/Y9gRBvUm/QCsUA/T0QGY1R0nlPj5bUVBNRc1YFNiGfGI?=
 =?us-ascii?Q?nOEhw+Fb48Vy0reyAAh2ZL/Sx0qThBkoQZPTJfdK4AfNs++IpDajPogi6y0S?=
 =?us-ascii?Q?qmVJzz9c+zbXOn091KV3kPcV5X1uUndEAJ1LceURmWVlrke8l5CsCKPuZZsh?=
 =?us-ascii?Q?OtlQfNg/e+6CR59TOmq5nXjVjk/ByhON8V6Yn3MGL3D3H5vvKfjOF/zm7UAa?=
 =?us-ascii?Q?bhyF49XKh9BxnaPXQKhB5yUkqiy+NtujkTkDYNvyPJhalml+hmGtmrjbsq8z?=
 =?us-ascii?Q?/CylpvUP/NsKv8CkcszHc9lJKAkUMDHeemBEZnFNmYlPhj/OigT7mBZy3ghD?=
 =?us-ascii?Q?3DeIJT+GJpQ0JIDKCgaKvhx+wbQTIcl/4YHNsSnQVfqOjJgA5Y2GqzYb4nj0?=
 =?us-ascii?Q?4JEWta16cQQsoPXt+wVThfOrS/UFag7kZSqviLOrK6x+WzWSYBIY4VYUIp50?=
 =?us-ascii?Q?zHf+lmYL1LG0CuxV+16oZLtbncd12ygw9agFj3bHwn+fvatUglomAebQjp/J?=
 =?us-ascii?Q?oskEDAKM55poli+OALRqVON5BH/hXLfwwuNAjzEULM/Sg+nLxRJ9LYTZXXtC?=
 =?us-ascii?Q?iboDL/1nxdk6ZZFwY1UiFoAvg2wrUahEW43GSfPub01x4fQJFkuh60A2zLjc?=
 =?us-ascii?Q?mw/ykF3Xep+A8pcqL9BmJKIKrcK2uWMT6y3XrpbD0IFYN0nb5OTZDeoyOfJb?=
 =?us-ascii?Q?dLODlv6M/SMGK9NrcQ//a5Q7jpnjvIKUoflOfLUe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4097a7a-b5f4-4b39-8c27-08dd54f3341a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:49:28.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZB5ETJrtoy28lv4yTN748xbkuYVjCMj9EAHeFt7DkifIAjp1e3VK0Yyw3+/MtYtnAXz2UK05LSXQHRIt9FM9IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

Similarly to scx_bpf_cpu_ids(), introduce a new kfunc scx_bpf_nr_node_ids()
to expose the maximum number of NUMA nodes in the system.

BFP schedulers can use this information together with the new node-aware
kfuncs, for example to create per-node DSQs, validate node IDs, etc.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 11 +++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 95603db36f043..74b247c36b3df 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7113,6 +7113,16 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
 	}
 }
 
+/**
+ * scx_bpf_nr_node_ids - Return the number of possible node IDs
+ *
+ * All valid node IDs in the system are smaller than the returned value.
+ */
+__bpf_kfunc u32 scx_bpf_nr_node_ids(void)
+{
+	return nr_node_ids;
+}
+
 /**
  * scx_bpf_nr_cpu_ids - Return the number of possible CPU IDs
  *
@@ -7325,6 +7335,7 @@ BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
+BTF_ID_FLAGS(func, scx_bpf_nr_node_ids)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index ca7cc4108b45f..0e55877590901 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -70,6 +70,7 @@ void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym
 u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
 u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
 void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
+u32 scx_bpf_nr_node_ids(void) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
 int scx_bpf_cpu_node(s32 cpu) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 5a9bcdb52e797..266f94fe479b7 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -189,6 +189,10 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
  *
  * Preserve the following __COMPAT_scx_*_node macros until v6.17.
  */
+#define __COMPAT_scx_bpf_nr_node_ids()						\
+	(bpf_ksym_exists(scx_bpf_nr_node_ids) ?					\
+	 scx_bpf_nr_node_ids() : 1U)
+
 #define __COMPAT_scx_bpf_cpu_node(cpu)						\
 	(bpf_ksym_exists(scx_bpf_cpu_node) ?					\
 	 scx_bpf_cpu_node(cpu) : 0)
-- 
2.48.1


