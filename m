Return-Path: <linux-kernel+bounces-429788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD39E2484
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D2B287D64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9441F7071;
	Tue,  3 Dec 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K8J7du0m"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85B1EE001
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240973; cv=fail; b=te5aiyt+EnG1tqDW0j4PRQ0UZ7DZRr7eNYVstPEXIdPHZWfbAnU/df+69DNN0B1nehZMk4PbohC6YbOl97wh9tdlE7fM/vSmZ5vn87mlbSx6X6gjHts+O8cpxEpo3EzTOP1j+OtDTPRQOULlnrW0X4NIT+KlJ9DLMqynObtYvjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240973; c=relaxed/simple;
	bh=NG5Kx4VHG2xyrPjGpBRnI6qUStTQHRH9iico8nM5aVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g6czcTSwlDyhRlPdeXuan0AkvepiMx+DtitKxRXprxS+kjZBc1xXnivP9RKF6sJ2xq6EOiz7WUQoyMOGwY5z9WL93ZsgCIY4AT7JJWp3isPr1p+j1dlzNkGH8tfmbkne7psIs036ngRQLUT0TRKkNXL5spRXyytCeJKru0WsUYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K8J7du0m; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUTvh45tQmlMp72UX2jZKJ4PKK6RprD/YaJZa8JJ6MaNMLiEnanma06CamkUpc6VXyZaMakNKBxXo63ktgaG2uWR9ybQ3y93aDl23TZMYO6W5PrmaZx7TEPshJqbYjozyTcLPj6+S6ZMnovvOQdYlfvX3xzwSLNKVTqECD2M38dMUeguH4z4quHQxDPaZxYkWSijLfDSW0IREnLMgVo124llEDlJb40rO+VmMAxjICitBtwEcENJBhJtWJrTKFzSpw0a0Ju9RKokogKginVErIv95Xbjn+sSlUlWe2M8aujXjfCne+FGxQwud/KN7o5ywFZIX92i5/fommDDYSpVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rATCwxkVNw6/+V9GekMiw/ImfPsrQPvyUt/fQvP0vmc=;
 b=EjfszUE7kqbFG4kVe6ya7LrBkECcLTL9/vAOy0+Fkg/3Pg4spAyDe86YcHSk0myrg4W57DQImpHkeTjvMiaeApPl3nAoodzsb5O08jPl1yLdAyUqQcWQ5dZDBKfEbYGmjO/ymQPyMsm/RmO+QB2v5j+J1StqPZzc0YXDygxJZCvvrTKtGaoZNVLLCmc4cfkau530zOS8VVyb50ESVi2Zc4+PhMHuofo1Ia/OKk5oiNXI/CIlfOcf6gd24M9qbkUW85aAa99G5GSWJX6PgYusiVHP5o3tevXkeFqZZ8ZsjsxJypTbUZieqyVYj+c6PMKPh4BHQ6ihrE/dZVXOllXXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rATCwxkVNw6/+V9GekMiw/ImfPsrQPvyUt/fQvP0vmc=;
 b=K8J7du0mTYLBOqPRHGuCyKLjeWoV8zy/ktd1/CoZSoJG0Gjnixfwl7qEYHbofqOXFykzc6x/sFGaT51ugeHJZsK2jKdAEd7ouTI2rv0W5i7DERqUveH3gjt4eWqE4AScKlKDoKzE69HsWIW2uUZ00FAVUsnhV3O/e+5NJkVjHRj+IA82OiVNQNe3G5wKm03Dg71rZIfAAv3S2fAF//nIeLc12cFVGqEQ0BnAKxq4Ae2i55pGnJlqeSUP6K1aE37Q1JbQ3QvLensIctAYt62KVCT0E1T1zfCGZcg6zUUjemb/pSz48xUF3IBAmJuRNoTh8GJrTYwigq/qFeITgzwAdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 15:49:25 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:49:25 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 sched_ext/for-6.13] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Tue,  3 Dec 2024 16:36:09 +0100
Message-ID: <20241203154917.123419-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e2c0f1-7a96-4acc-6dda-08dd13b21033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QG+lqog3D4O9nNinbECZGwGPrmTojUR/K+zuVZLvxz1oPcwG+8moCJpV1wam?=
 =?us-ascii?Q?YPtze6T8+RqpLQ8h2EUW44HwoSZ6WpFZDHUnBorodZxEF3d1Qhtjx0pNIoLy?=
 =?us-ascii?Q?XS0BLKhccpcXYtztVtNYkYPPnTmZSlk/7o8OshyCHHlFUw8GkhqPkxOxcCur?=
 =?us-ascii?Q?zjXSNakEtUIAbi+YyRxW2uuG0IF2irg5SQXrwRwDZtkmMpXXwjiqPGsgseUq?=
 =?us-ascii?Q?46bSL/30QkNYTrOg/SvqhLO+58jX249KSDi4wrqD9zhO9mMx0gIG9yZmhM1I?=
 =?us-ascii?Q?0GAWErfSNLIuHwvnjGoWw3CXqQA70029ACWVT16LpI+nNTwqdLQ9dLiA9wBG?=
 =?us-ascii?Q?MNJ6UtfH1I4exogm6bFoG3jt9QlcD/zvTaMFGf08/6gybLxfLfUCdVDBxIvj?=
 =?us-ascii?Q?s0QwLLWnY/fIWhJmWX57WDjDZBtJTtKRxoHORTQu7U0ZSb5RcW16a4LP+7lp?=
 =?us-ascii?Q?Fximv1XsFiVk9QnofCMXLcdaJVLexZwyQr9WWMSClkusMZ0O3tHdot6GUQV6?=
 =?us-ascii?Q?OLPEPLSsnXoN4xcBmp4vXa232V791pi6jbfup+D4PvavUVADvgQX/kx3Rmgg?=
 =?us-ascii?Q?fhjU2WGmPcWScRcG706i5ZNIuCFITgSYkXwlSrNb5pTGNBmU42Zk6P2rpvEv?=
 =?us-ascii?Q?xnr5IfMaxzDEPmV9F2c2gell3OI1G150jR4AThF+k/CpbIfhKg6fvVvki7V+?=
 =?us-ascii?Q?CvxB1T5Ss6GUsRF+QW4dE4wpgYozyZoLuzXrZ41YIVQelmAdT3+oE5YqskLG?=
 =?us-ascii?Q?w0q/SV7/oaehBRAcA58Bjw8swYpZOUVu4aFT2FIdUm3/zPTT33++w7M3apch?=
 =?us-ascii?Q?e2LEeLyYB1bc+GoalTAEGXNaIYuUgIe78hChJUfvUwNcdkRyt/8NjumKfTrg?=
 =?us-ascii?Q?fTR5j1OOTtm+IsDWA4rylOzvpBQvp2qT5I9XdnqumHst5IDB0EJMtPW82kJc?=
 =?us-ascii?Q?KWpT/lhbP8p6ylHgCU1jSies10Z2NrwiCFXnqNsOnQATJ5tNjurzsdcJ8W0X?=
 =?us-ascii?Q?pxQHY2d+lB29FvHyLF4hIwlDQExEYQ1UURQ3mAEzMdrtL0KMVaUu2+0rqUMH?=
 =?us-ascii?Q?YZxKB78g4SB4j+Shn2xoAk+0JWAo17yjz7TYv2Svc8zIcQffhxNmOneQRrO9?=
 =?us-ascii?Q?qidR9FaWDSAi65CSAeNlbksJL5anm7oZ/DCzMWyPD1EYSQopmO+7n2AotBow?=
 =?us-ascii?Q?I4q7qyL75kw/uAV7k6jhIfRBOm6NpK3IuaZOP81Lqcch1zJBtsv4nTzHeFmg?=
 =?us-ascii?Q?DbPCSSbKEjLl3GWDFtQYcjlnIBd38x6kCy9aeuflRlPrk+5i2MlHNxCBIjE/?=
 =?us-ascii?Q?Lqyym0pXNTFAhyjtsdXR0r3ilt9jq/T6GdjwjIqJWgmOOOb7l/A8mDlt+tbS?=
 =?us-ascii?Q?S7nrttc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nwK14JjpKNJmL2Y1g8pSdvQWrAd4zMnfSQ3aShdVcung2J1oigswi3tnUa0g?=
 =?us-ascii?Q?0jbHhfFQ7bprwnD0/l6Sr1Du2+CskaECdvCm9zMSoWzgTuyq7oF921f2nPJe?=
 =?us-ascii?Q?D3xXabKjokQCafPIvs4w5tuPkgLteU8Jp+RyukF17BfFbBb+3QEE6nHsQNzI?=
 =?us-ascii?Q?+B5pkXDOx6WdUG4/J6l3D7VJpXGlm383ivMY/g+FZ39g5YNprQMr7f1EfHzP?=
 =?us-ascii?Q?Vleei3TsjLO0ONVu9kyyBT2og2wqXjC4QjPh+gaX3egx21nDH7xqpLcUO4t2?=
 =?us-ascii?Q?rADaaPuZlHRANg1Ti680ireOKwwdbJzObcZAhVxYsR6DyFkSDtbF0VNQb9fV?=
 =?us-ascii?Q?nRWyS3BgPvXP1CvFMOi6fxIyQKef1g77bvQinPYTF894UyzNqntUe/DM9H11?=
 =?us-ascii?Q?lR1KxZC7f+QAL7hH62zOR6yRS76eE2bVlwHuDa9cFXvhyABmgcge8sKJoKOO?=
 =?us-ascii?Q?fKvoBPwzPNskA+5oF/4z3mRMX7BXXvQA+j5oBaOTEgelk8VVBG4YMn8ygZiB?=
 =?us-ascii?Q?vDVx2zE+IrN5+XxHz4C0KU77TeFUVF49oMwg2NjXqHDXe9GMK2IyITRBneI/?=
 =?us-ascii?Q?2HKnwaPQg4pj/SzKgEVGq6piS1aVIRHykmpTuMNZHPxeMgl4P2GLpvCzjP2l?=
 =?us-ascii?Q?0v8/rg9md6COYpEwpQk20c84Wa7yO4ugTNsgZI80JkfzvQvB696eoA7VAy/U?=
 =?us-ascii?Q?R8Xg4c87EgofHn5kiGwVuQEZhEIZ/my24V0fXaO4BtVcdekINoSLN5arfdTO?=
 =?us-ascii?Q?cfjZo4+9EftfWrn7wYIC9jWHxsMWiouRcG+wjGzw+xMVVTNVeHYvkLQA+wJj?=
 =?us-ascii?Q?GRUNkZNRePUjfAgrn1c5GR84Do5/lt5jH9AL/iUxLeSeXwEx8zlw4eCKbhP8?=
 =?us-ascii?Q?i+UPMIX+UaNCjfO0mAEujTBHaCoHXktnDla/7a3yXTOxiJHewg+bvDPpNQgZ?=
 =?us-ascii?Q?sM+FWcZugKNvmnq3P3c0hZdF5Clr3VcBjYXT/FDc6gCa0wLf/kTWAiiienaa?=
 =?us-ascii?Q?Tp/Dqq2NbDeG7K0gDdlNderbeVeTo72yPsTakbiegVACmMvs31PPafTAUaDZ?=
 =?us-ascii?Q?BBEGmytBtJq7oYJWZIFzcICG+HgDApBI/oFfzjUixsCsCgdyjBUr3zMXggPa?=
 =?us-ascii?Q?CPm1NEwo8MTHPfKl4wLZdG83XGJnitatLdKbCR6/BUoJUiDIA44qpJuwXRZY?=
 =?us-ascii?Q?MWJ2DVEcKDljuGT9yxfVNb/7z11C3iJDR2zfN4M9F5yXAwMp3kDZ0k53YHLq?=
 =?us-ascii?Q?FCTG1Cg6EqWZjl7yvVOtvdl1R5rC0O3nNO95y05SradOmlpn5zqGb4E7cDzN?=
 =?us-ascii?Q?Phqfwo6JVNEkZkv06NDNpPVrVlLeBnIxh1QMx+GuDb2NL6NMWhcsqqKz/qoZ?=
 =?us-ascii?Q?SRrvF7mnXXC3yGf5yYaByVEv/N1HVskHealF+IVrQbS0XNuOMjP4ubDcX8/1?=
 =?us-ascii?Q?XrmJfHu59F85+lamgBbgEyVTO7/YqMADBufMcwUVKDu0g7tkLNPNmxJrCuhZ?=
 =?us-ascii?Q?d6TIKaZohcWNSUZ1/aU06SU4me2qvgWYoln0YrCP5b4o5iXUqkTlXalEUKKA?=
 =?us-ascii?Q?80hbqL1oBzNPmPsZ+FUNmAuxO71823poIgfFyX20?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e2c0f1-7a96-4acc-6dda-08dd13b21033
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:49:25.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8gLHnSej9qvrKmYaCef8KQ5f6mXg/rl7roehtNgCliK3hjrqKBFWgmA5DKC7becgy82fsQM9vGYY28M0cWrhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

= Overview =

As discussed during the sched_ext office hours, using a global cpumask
to keep track of the idle CPUs can be inefficient and it may not scale
really well on large NUMA systems.

Therefore, split the idle cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on such large systems.

Scalability issues seem to be more noticeable on Intel Sapphire Rapids
dual-socket architectures.

= Test =

Hardware:
 - System: DGX B200
    - CPUs: 224 SMT threads (112 physical cores)
    - Processor: INTEL(R) XEON(R) PLATINUM 8570
    - 2 NUMA nodes

Scheduler:
 - scx_simple [1] (so that we can focus at the built-in idle selection
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

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

ChangeLog v2 -> v3:
  - introduce for_each_online_node_wrap()
  - re-introduce cpumask_intersects() in test_and_clear_cpu_idle() (to
    reduce memory writes / cache coherence pressure)
  - get rid of the redundant scx_selcpu_topo_numa logic
  [test results are pretty much identical, so I haven't updated them from v2]

ChangeLog v1 -> v2:
  - renamed for_each_node_mask|state_from() -> for_each_node_mask|state_wrap()
  - misc cpumask optimizations (thanks to Yury)

Andrea Righi (3):
      nodemask: Introduce for_each_node_mask_wrap/for_each_node_state_wrap()
      sched_ext: Introduce per-NUMA idle cpumasks
      sched_ext: get rid of the scx_selcpu_topo_numa logic

 include/linux/nodemask.h |  14 ++++
 kernel/sched/ext.c       | 200 ++++++++++++++++++++++++++---------------------
 2 files changed, 124 insertions(+), 90 deletions(-)

