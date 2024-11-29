Return-Path: <linux-kernel+bounces-425864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC799DEBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB09BB21E38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6122D1A0BC3;
	Fri, 29 Nov 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tN5tq9qR"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74E1A00D1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903973; cv=fail; b=MHzpD0EirxNizAYFlbBqaHPgR37OQTlApu2ki/4fvFQbCgmrNbPLFsDFCW9qsFhXm2Dt2yH1s3T1ZyqIGGb6bp0Z/5nkavSDz9EmqZCfxNALWUCur6W+JCfAvYnPMvxrU5MdC4Kr51faj4GJ/JuML4mWnXcPRKvz5RusGwoefCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903973; c=relaxed/simple;
	bh=00MtEZnV5BNDYGDbN6efKYMNEn8WLyRuXsgj2mystac=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JFd5tFDuk9lL2jXf/R2ePSAWcKyA+3wQhSZO4sB6vs09af6A+tIRLCFubAzVDF5TaMPnse4Osj7B1/pzlBu6zENpmJy50zpfbwaMPPKQa4HuTTmVXLDG8ZZ/CHiMRnDXIusZoNuHLNz8a3i8wRzipJ2Airky4hFCO/iuZa8ym8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tN5tq9qR; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKAy9Oqsfx8HTAfy4hTQNJHoi9JGmTRH/+M7owtr7cXdLnUAQ54c/joCE7WohxzsHl4E1DpaM9zf4FIvCVz/XbGwqei2WJi3SaULEmByfp99aREfKCfxwtTvV/8i4Y8HEl8Kt+vltQaCD5WpOYBDnLfTLMFfM7MVsjSnGhIboqiILraWoDiOVZhivVfea9CrIJTDe5/gMVVdY5oC03eYeOZwHJ/XVrY8Mqnirs7JBzUSu5OlHKwbn4nm2qeNlFCeZK9jh20Ns1FGdTFAxlXMtiKM/xFpuy0mdZWiY9dt0MiLrGRcl9EFl1/kjJJ+olZI4bSPq9RNW63rTDm2b4mTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6+RevA6g9jFjtdxcoopLrG7ACZmqgvql/FdvVDMcWY=;
 b=HCWG9OhvDG0B5hE9/dS0Uj1Ec8zIvQssMI6ePh7VC3/V0xVAdmYIcCEIb7H7OCq38u+2bq7mJxNjobQlPhwCh77L3YYZ/0bvCxfZ9+HoWZWkvrzfLapNCyqFvqa0bsYuIiW89x46nhav6ZYFNcsKE4W7TyQqwN/ItgeLuT3e/EgELFaKj1N3MXmCaKUunx0PBxym3TY47CHTe/12J+OSLEri0xvwdguOwwXcggz41i/7mwlqm8ylZCisRv1I9aBV5rc7jBBsRIQP9efNQEEn9n4aNp6oaTb7qtOadUgQLGkxwf3DXJuGCbbUN9v2N3zpIG6KHT8U5ASGeEzcQtUXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6+RevA6g9jFjtdxcoopLrG7ACZmqgvql/FdvVDMcWY=;
 b=tN5tq9qRKwjYkgvswOkleHShgqSGimNnbI5EvYyqR0OvZgMNgjMu0HdlffM5ro5UkvsI8bpP0eU3RyMAe4TIPGZWTPzByDioY0EpuYeRxhWwEQwd+fk4USiwDupQkZMzWQjEuVzUUcOgz1Wwp+3Z2GWDJs0AYq/gG5K2/T/DOl+eJDMlQQ9wj6Z/lfGzgL2J5jwNzBSHir+303lqhBCN7RevogQTAns07saMgKaGveAyuiV6eHEPZlW2eFxth3FWU6fOvJotXE0aM1izvTapS0psAKUCLRDdO4lsTz3h9J+Mk9UU/D8sDLFx9CI9kjzNO4rO6011g1YPk8tVFzRJxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 18:12:47 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 18:12:46 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-6.13] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Fri, 29 Nov 2024 18:54:30 +0100
Message-ID: <20241129181230.69213-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 03447d53-041d-4796-86bf-08dd10a16d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0rCUc9xph/M4YoZBTUyo7w74awG08DgWMmBzQiPNQfPd376gfGkuWRQODWcq?=
 =?us-ascii?Q?B5x0ZAalcCLjZodiq4hQweMWLw5TQp46RjlGPkjDRKMOpqhWK1xJfqWXEeCK?=
 =?us-ascii?Q?AOiShbpJAGoX0vK6R4IArhE7GMgZOSHwZpY3cSAW7YMmCRnm+0mNzjuWjx12?=
 =?us-ascii?Q?N1FOzNvKp+25847sFQuv//hBFJ4ITaPh9mDVdH6Z56Gc4I1i2Ti6zc86ssZ+?=
 =?us-ascii?Q?tZiCeDk4qFKUvYqA2zAmop4JVrgcdcEhARz7DT7ivLCNiJZ7K7fuPUeIcWz4?=
 =?us-ascii?Q?6pf2Q+BDWPWfY2+q5wGWmkxR/u4zmKmCNvC5ejq8XtUl9ltu3MqMEX8msQgY?=
 =?us-ascii?Q?0DgnEy+PH16fi0xqIaTdzzWBGPuZtmSBLnKmFuE61/ODXLVoZgVSIAvWC8QK?=
 =?us-ascii?Q?JmjED9LCuylWxS6mK8dIXAdZ69bJORBi5WBzdKVEdsKWQ/lXutcADyGZ/rSQ?=
 =?us-ascii?Q?+1ZfCX4ZGPDem9VpyBcMuGubra8fmkFBqEXb5ZQLiIi/2+Ekk1BfQt5jsuUs?=
 =?us-ascii?Q?QKXYvDYy9SZ1pTgbYsi5GJQ9/tjt7LjDyLfyq1vQvM7dXbTarI1Nwu4fXGgO?=
 =?us-ascii?Q?AxiPFEF/zpKC7hFyF9XbT2+WJK78HfgN31rfZoSLolUk4TdqtdtH6tCey/VI?=
 =?us-ascii?Q?JZb0/f4RUd/c54OacRDq7GkJvVBl7R0Q7/CSBy6gSfy70YOrxX+ZK6+50ww9?=
 =?us-ascii?Q?naUXl0qxOaXl3IlmK6VgazxUrPjCWHEAPW3foLLBH47MELhewYU3WXy09zoZ?=
 =?us-ascii?Q?DntFSoA5/7oiGPVGA47CCuDq6u2UDWIwGhPiJBpsFwS31M8YGcq7MtUuDVWC?=
 =?us-ascii?Q?0CvObdtFiLae/kSzZxUwlcBTuNbaI5BYuTQnwmghjKahYIey0oLlCqVMRyB1?=
 =?us-ascii?Q?7GI5eH3y8DTOpkQGBMrjKCAhyheMR4gf40/q/HgMpf4FZ/o41ZAOtnFKKnM4?=
 =?us-ascii?Q?Ya6zyB+kvHw+Q4zj6ZjyV15nOoi0L099Vobf04vUChhTojpW/IPOrH3XI1WV?=
 =?us-ascii?Q?uxWZ+kmS8NvNEoi0dyCggJWXwZjXBPPnUprT+uD2Qto1jAjz5N6mf1+X7K6P?=
 =?us-ascii?Q?nSUvfksT+R21fFe8xs84ibVdwovLFD32jpy+XuqMYET6AYFGnmYh7HlmJars?=
 =?us-ascii?Q?ZOScwYPLdRPB3fqk+gq/9NFUvR+9GbvxE7CKrO0KKH+dr672n+gHZk2XNTk2?=
 =?us-ascii?Q?l/FlSZCIpRwpGGcb+p01rup2bW3vC4IYq4eivNOmklSdlclGAo/Qm1ivf0K6?=
 =?us-ascii?Q?cWKF6WbKQbMNhCNdLGMXkPqaYXEN88Q4qvsn94GsdqNLg+hYYSvONjQzTaN5?=
 =?us-ascii?Q?wzj2Di7u6fI5BUCdLaztwS6/pWmpDuB/nM1Z2Qz5lwgKDLNsJoLx+V8Ygcf2?=
 =?us-ascii?Q?oAgmIRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K67qtTjw3wg+s0x3LAj/TGyEMK6Wp3xO3oc0+GxznvtDXn+Xihzh+POTUxFM?=
 =?us-ascii?Q?hzOGPUcOmGGwP4GrI5MtwADe/wbZykpfUSQSha4poOHOIYNzI42QgFY7yv+A?=
 =?us-ascii?Q?fd5LvnBA5qU+BhcWVq5TIUf8h/5n3fFSx2uf52KEjJVpTStFGPrfBvcIFyyK?=
 =?us-ascii?Q?TmpzBA4a/6rC77vwIxQq3wh7wGJkd4KHBJeFqxRp+5aWeMVm9chihF1OcHmC?=
 =?us-ascii?Q?QMqjl0zqcdNE9LnvyKHhqgfvin1rjJpJ/qtTO3ALTYiyhWRmuwB35fwwtBNn?=
 =?us-ascii?Q?jNB7GN08UuiLhBbFJqYCCSDOSFG39LvwC21vXmvrD6PBeIz7oSwnzqz4kzSd?=
 =?us-ascii?Q?kWidOAUlYDFKgd0r9KFV15QEZPEFTmPrclx21RMCBrfRhnJ+V2ROGCB9Vvs8?=
 =?us-ascii?Q?bZBipi+k9NsboRscF/y3nTYG0yTkVMYcucSx4JldxxldJC8FtcL+Znc06hQQ?=
 =?us-ascii?Q?g1h20Zr1etCnsEA8pAKuMeX1Hx0azn9cK8WWWAiWecpdZ6eq0+buoWpb6v+J?=
 =?us-ascii?Q?dxCfXNlnU8ZZ32WKb9EWfOYOi+OuYLImX6SmMfvGaHadx4etzslVJiCqUWZc?=
 =?us-ascii?Q?dKEPZagv/MfTjfMWJq6trVSENtGc2yEtmqm1Y5FPzU58KXjAOv1TBFz7sCzp?=
 =?us-ascii?Q?oFgXsaNrF6g8DqI2Rz1kwj9PZzo7H8hJloSTRLCHHcfrspN3Od0/WvJIKwBe?=
 =?us-ascii?Q?RwZlkdDdHDrGKIdkEpWFj8K6MR32pg6+Scas7eVuIH97G8xu6wBrUiWX8iO+?=
 =?us-ascii?Q?6ExO4j4XrdX3uCeH/xzNQIy0Qyk9UO6/RZa/ruY5SXT20f3gpshe2rvW+cer?=
 =?us-ascii?Q?8We8IpMhG0ZW6CWgU4d7Mt6WiN4MLH1vzOdOSSLdAufvJ7nWE61vyLYuavZV?=
 =?us-ascii?Q?L/ANUd1GkOp8G/7xseBeaM9gIK1RC1Y69Ajm3K/bzknwDW72kRUdvH7AdryV?=
 =?us-ascii?Q?Qyv9trDH6oFkq+aIr4fO0Us1fx2I1wrnXRMQhxxRU26gJOfMNaxwmCsC8Q2o?=
 =?us-ascii?Q?Wv2330XFQIyYIenhyy3qrbPu0+0dWtu6agUoOafycQS2eRFxYa+Cc9/LggYU?=
 =?us-ascii?Q?3NWn7okyka9s7SxSj1rmeLcfkGyMMpLbh3PY6eOVjnt9GBMjeBnbawe0tu3Y?=
 =?us-ascii?Q?viJfVP5utZ9/YvM6wWO+h2nksNADvNxiR6uWGjVJYp3D/8OoxW9hbhR0Azqg?=
 =?us-ascii?Q?Zt6hZn5idkOYpNi/bvLSOZVCNY9Z51aoo3J7E4y4i+qBCmrOj4PijyYfdLuM?=
 =?us-ascii?Q?pu5/p1dJLqJMyfnXoB4tqxh472DCxfrqSlTceugg8XoNRHrnAFaMqdp5FoVq?=
 =?us-ascii?Q?ynlZfvCMkvujzluZnOAe0usLUlS8R8cPHLjj8kSyOuuMJl64lauThNZXbtdV?=
 =?us-ascii?Q?uUsMLSyeeHEACUGczJmx0fM5EIBMgBRI/ObijdNfGhDmqukCNIJgVcNQQaOm?=
 =?us-ascii?Q?nXERTm0OVCe2VVJ8wDD2IyaqW8t1QMwkAE9iEDESS7Lwl6xwPGQbp3ic7qqY?=
 =?us-ascii?Q?H/vbGPwv9I5FTVbnKyc40D2aroW2OKkauSW5fQsWjkL0ZkmlqywQQWhpf+5h?=
 =?us-ascii?Q?No62ujdukbITtkyIy25M/gDixdjj9O/7AlHRNgKJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03447d53-041d-4796-86bf-08dd10a16d3a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 18:12:46.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBoWIGb/djRVTw/hWYfDN89aVQx+9S5zxlB1bRN4gh7Zm76fNZwAPflrOA8jvWDF4QVCiC17NTROa4LdArbgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

= Overview =

As discussed during the sched_ext office hours, using a global cpumask
to keep track of the idle CPUs can be inefficient and it may not scale
really well on large NUMA systems.

Therefore, split the idle cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on such large systems.

Scalability issues seem to be more noticeable on Intel Sapphire Rapids
dual-socket architectures. However, benefits can also be observed on AMD
systems with a sufficient number of NUMA nodes, see for example [1].

= Test =

Hardware:
 - System: DGX B200
    - CPUs: 224 SMT threads (112 physical cores)
    - Processor: INTEL(R) XEON(R) PLATINUM 8570
    - 2 NUMA nodes

Scheduler:
 - scx_simple [2] (so that we can focus at the built-in idle selection
   policy and not at the scheduling policy itself)

Test:
 - Run a parallel kernel build `make -j $(nproc)` and measure the average
   elapsed time over 10 runs:

          avg time | stdev
          ---------+------
 before:   52.431s | 2.895
  after:   50.342s | 2.895

= Conclusion =

Splitting the global cpumask into multiple per-NUMA cpumasks helped to
achieve a speedup of approximately +4% with this particular architecture
and test case.

I've repeated the same test on a DGX-1 (40 physical cores, Intel Xeon
E5-2698 v4 @ 2.20GHz, 2 NUMA nodes) and I didn't observe any measurable
difference.

In general, on smaller systems, I haven't noticed any measurable
regressions or improvements with the same test (parallel kernel build)
and scheduler (scx_simple).

NOTE: splitting the global cpumask into multiple cpumasks may increase
the overhead of scx_bpf_pick_idle_cpu() or ops.select_cpu() (for
schedulers relying on the built-in CPU idle selection policy) in
presence of multiple NUMA nodes, particularly under high system load,
since we may have to access multiple cpumasks to find an idle CPU.

However, this increased overhead seems to be highly compensated by a
lower overhead when updating the idle state (__scx_update_idle()) and by
the fact that CPUs are more likely operating within their local idle
cpumask, reducing the stress on the cache coherency protocol.

= References =

[1] https://github.com/sched-ext/scx/issues/998
[2] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

ChangeLog v1 -> v2:
  - renamed for_each_node_mask|state_from() -> for_each_node_mask|state_wrap()
  - misc cpumask optimizations (thanks to Yury)

Andrea Righi (2):
      nodemask: Introduce for_each_node_mask_wrap/for_each_node_state_wrap()
      sched_ext: Introduce per-NUMA idle cpumasks

 include/linux/nodemask.h |  13 ++++++
 kernel/sched/ext.c       | 115 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 92 insertions(+), 36 deletions(-)

