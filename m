Return-Path: <linux-kernel+bounces-448966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA69F47CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756EC18854B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E35B1DE8B9;
	Tue, 17 Dec 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2rpmejb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61181DC19F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428534; cv=fail; b=jd7R/bFdVvAqGTPHKCqTrEqi9yr1RMLXhZJnQBE3Ex4jhvkjsBHTCBXoOGeaK8WqMxmu63cmb7JqVp1IFJew1IXbaiXZBMka5iH3meA3mdJwILGM4FArl8IMASu8zXBY2LuCoDRUvtcgI2NwCtrarINfvMbDVzBKPUiPtBmWp7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428534; c=relaxed/simple;
	bh=BCfpPrHbPjiwcu3dKRcfdIFyV/+m1pNUUCTj3dKrlD8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jjffC4ZTKUHVsRgx+hjYSmaqQz+V7OEHW/V8iDvGo1NR8c5xMHh1MvBGi+KRVrxmcdWZLERoVQhtAT4M+Ysz5dqmyy3hYqSP5HNXEYlCi12Iz+NC8HAd+BR/wUsNrUG4KqDhL00E6SWlxpEkC+sEDT1t/B78Ffi2bAYDHug0P4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i2rpmejb; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYu6jyJMOOxWvmVQHSvNAkkxf77ZjRpoDY0KlAXRld4vTCVI1QaTUhYOYVQCtjwQuIQz0ulniyc/ggq11xCQs8ZOiyXuYBiXMxdpe+Pgqz77HP1iOsJOQlmJ4oeUhI9LlOr0SuhE7plGMQhOF6sc5I55PmFYNtg7hPoNi0AVpqWTLBJ1YGgVNUcN5w3yJMLh2cawH2Tusukd2Gkm1SfgEujz/KRq2HiYfZ5uvVKZzru3I+6VBLIfP45ffWahOBX+5MMx0pbmQ0ICXLD8VjBZ3tk2fPvnZcIVLBfFn9Vsmpkw1/4cmZo+A/IezaDSh6AGeo1yWmyk7Sx1qScNkUaPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqkCKSlj/ziihqSywYE7aH5wCioI0eNjWps5ftBYEoM=;
 b=sCBZUxrdBawv5SPB+5QzqRyl1LewPJ0n0w8lBPGk0ROhveWejQTkoWp2ghXMdMtV0aC+jwUhba0j0zgbiNDCdfc8GbzqmdCwgX1GFW5RuONY2QrmRbvvTdWbxtAWlaDIyCO9FPfhH71aU21x74C4ukoa+bMtg91CqpCVF/WDlxDfz5HmJoRlG+W75o822JK+rg5O/b4MK0FgmONsi3Fm0YRzEIfKEQN6LiBCL3ZkdUva8i/Ao6SFZuerTG/rqs4SzyHM4bjDai0FYZiqEHTRE0hk7B/sFmOMFmef95fHFYKiuSDSf6TeX0U7FJzGK/m04YQgphVoy8/Rx/nf1LK1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqkCKSlj/ziihqSywYE7aH5wCioI0eNjWps5ftBYEoM=;
 b=i2rpmejbJxkk8i8uYaHJezomfpFhGGzhmqwO8w3B4BzURbOo1BWB9a2lmVIDyJKZAb9UQt8d8Te+XiVamzbC7cU5fFm4WPtXfQgoMJonIX6julUutPUvvDAc9h+qfyD+KtQXvo1ooslWH81qgSCRtPDc9RvZ42uHZ7YdELjU3IjAQ6HzGZjHjPlcE/ZSvh2VvZB6faox6Jj33dc7GenNngwhG2CZhr/FY7Tfh76wzXVWUgV69yfQNGf2wKIg9Vh48LAXDfWwlMmw9FJduKebGVF8BNC+8rwv/fFNfRCeDgCez4MZ0Dn4k9/pBggz0cS7djxCx1rfS6GsQj6yeLmOnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:42:10 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:42:10 +0000
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
Subject: [PATCHSET v7 sched_ext/for-6.14] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Tue, 17 Dec 2024 10:32:25 +0100
Message-ID: <20241217094156.577262-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 272d752f-1f7f-4eac-c360-08dd1e7f13f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l+zUlY0SlG47lN37t2C4Qk8DN9KOzictOs1yBSlk7KqRJc4EO4mkEyy3XeWL?=
 =?us-ascii?Q?sWT7EaRFlRJ+oY0gPUMv3G/+Q4RoRHqOVA5eOGkiOyuITeZVHXM+RExvw1IG?=
 =?us-ascii?Q?i4GjxSsFZCd3YZTBHqGx6cUVKe6pPl6lEojpKMz4l8kztZVQ6IB5O6TLENXC?=
 =?us-ascii?Q?FdxZW4oSKNDN5Mmnahw2AVw4maDCYz+lA2e4db72Kn74tTEj3U25lW4sGSlz?=
 =?us-ascii?Q?haZiBuT/PfUdt0JZEz0Aq5PKwrN6msWQOsfM1dyMpFyz/GgVnhJscd5TJSRO?=
 =?us-ascii?Q?7+WwppJznzn0jPI2OQPNolzbITZYpfDZprNfZ/ssyfRDjMTBtqRD0FzUUNQ6?=
 =?us-ascii?Q?bfKcjcEzdnwEzW3CoU6lacMoNUsIyQON4TT3Y3pPPHREm/yhjoA+2kEBY9rw?=
 =?us-ascii?Q?TYwH46fvAGgOejL2Qy6eRwUqhm5b6yEM11ANJhkfwpoCA9tp6XmwuAUeRB5P?=
 =?us-ascii?Q?HIL/pDfH0/sQGCYJdNdBQ4qzEQCqTb54nu4W+qjV2FnBRDs/g/CQ7yZGngWc?=
 =?us-ascii?Q?LEYVfPShS4/Rkr7CVBTkqSqhBifIXR9Rhl+x8At7HPI8bPeHWE6eiX4INvdq?=
 =?us-ascii?Q?C/cCJP33hW9veJLPukM6JgUp0uKWAt9iO3Y+YLpoffwo+KD41GfHYmmjQgGj?=
 =?us-ascii?Q?/aPJ0fmgg8Wt1TDhwMHpB9IhjiaCmZKFEcjZYZ1FBhUYuJgcswSxL3T/uhdJ?=
 =?us-ascii?Q?N4Cn5cIY2i8mbo80XrAA5h14RgA5cZbOmGVhIb5ckN2KjlFn82YH6Y2452zz?=
 =?us-ascii?Q?Q7uV0UDXmuqNhGfvwAIx4qeCKd4ZGzARAZl320xH4K2gNndF/L7BuXvxijdI?=
 =?us-ascii?Q?wRYX8h4uLWng3IpsQxQzwQJyZQBKxjxBPCXLYBkM4z3yvkZJBSZF/vch3gBe?=
 =?us-ascii?Q?211san8W11pOdKVqkr73sjM5X5M4UNGMDj9bUWyvdYkQ2Wl+Nbbyk5gIy3mY?=
 =?us-ascii?Q?rjQYkBjai5K9XkKO+Xeth8BF+abNgMsQlw0OTsH5dybyUplHhL3uDHaF/GnT?=
 =?us-ascii?Q?uHRi2ZxoLzg7s+ieqRXCy+gN2D69FKFl96gCzcJpBoTspdg7FSWk4eNeR58K?=
 =?us-ascii?Q?rgvadzY2pKQkNVJfsVKi52PgXRZGNP0SDKF07Vxif9cq0z5XQ/GeKUpUFb/Q?=
 =?us-ascii?Q?4D2y9sM12TcS8akj3D3FtnRswffStmzFGeokFnbcCmiDr8nvsc7sTFnn7T4+?=
 =?us-ascii?Q?wpcOMn+d9r4zAF3wlt7ENH+3x8CLUwP9Stb4Zg3kGgG1qyEueePFyUyShVAK?=
 =?us-ascii?Q?Q3U9GW0ZrpiDO4kEPm6MzlOLFl/VCLlTMo24hEMnynPiRxpAH7i7BfSYchzW?=
 =?us-ascii?Q?oaGNlGMLmhq6cvUvSTQhRfCat7ZeIBIVBwTyavhHkO0Oi3ze79SKaK3FqJ6+?=
 =?us-ascii?Q?MRKKEOlUF5vawMD8amiG920wsOvc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QUOvw0YxiFSauE3tqRy4vBna8nG8PCdY988HYYDQzDn0UYu/hYYWpWtN2MsY?=
 =?us-ascii?Q?ticZZT8wq+EbJTCUnaoMkwEs7sK/XRUDKvQ8hUaOTW5ITr4WSTySzyicqaKO?=
 =?us-ascii?Q?pQQ4tf3DU+J9gdLTxGdUHGyn2/75IcQ90fqpOr2XjNjw544P6Qakj4Du9/ya?=
 =?us-ascii?Q?G5YIQxFCGJlGpFCCKNkhAdkOkCzqAR0vlxR5D0HeNSybG6wLHNGjPf+Un8NU?=
 =?us-ascii?Q?yxcrmCh/O7vYZh7K8JWPaSQbYE0ptuw9gnma6Ukeq6R8JoMhYGp5k+h40FRS?=
 =?us-ascii?Q?DCqZnALOGUfYKTiDquo2CxPXWcXWBLx0k7Kuwz6GKTohCDcfzxkFyUswcGW5?=
 =?us-ascii?Q?psQmyRI/VF4z7Y2huaxTF8Q5U0KNeHtDaUCGt+MLW9O0upvJyqvNg8uZ+bRT?=
 =?us-ascii?Q?AsC396prSiKyxpxZxDl1hGs+nOYTDBzQYiMncbSGXASjVQEaTzaYDAP4R2u6?=
 =?us-ascii?Q?vXO3JAKf0Bjmklo5H9zwja9H6zBe6OT5PLsMovfYz6bxuQ7IKUBXcIEoktSA?=
 =?us-ascii?Q?F3+LV/xnriZFrNPOfwuZS13rdsygW37wiNhZarOo5kydewfSdKgSzGHrwFSu?=
 =?us-ascii?Q?dg3DA2d0AJRRdmsnC4V+YMJ8n3Xe7AzeChQr7asjU5bhGntLQHbWTmkTLakL?=
 =?us-ascii?Q?T6D05mQoNUCah5UdNOMbpLGMntT/eIHtAo3P85TAcZ3WDUXtP2sq3ZajxQbn?=
 =?us-ascii?Q?vndtDxuvI6tBRwRa5y37bIb5xLKQBb6Am5DCElzkG86/s2l1DLj/Cyr8Objh?=
 =?us-ascii?Q?Wj+siNbQUir25r9XqCwhZ5DlgrNXZsEQgKXkXjtvIzvVgYZWpoGbz4yG/+Q4?=
 =?us-ascii?Q?TpNNaFydL1UxtywMtXKlGtcE9R/U04huR2QVSoc/C9NlCg4MU5U3U+mRFKgr?=
 =?us-ascii?Q?3j9efyDD4O49PlSV+yj/OgwWGcwYoiRheJOynxHoUp6z4qf4bShf0mVjF/jS?=
 =?us-ascii?Q?8IBKU4ZTrcPerGJJdS/MK1c3z79/8f7g+qhUTdbmzXyCACq+rvYqJJTNxQW3?=
 =?us-ascii?Q?Vsc1w/Ptu5E4yD4i+WuvWLOCt8S0NhdXNNm8m/1a+EjWpljNM03Y8GXo8+Et?=
 =?us-ascii?Q?u6P9vmOvlnR15AJb657oqhG2zeHTfphncz9SebhIxnS/pfaMkWzlghV5LTdO?=
 =?us-ascii?Q?1pyTneORSU8krsGdqm4MXGNF5vYgbqpx4QFURB2AaoWMQOSZEyfszfAefPXh?=
 =?us-ascii?Q?cColibD0s1qNt+NmJAOKIfpzQ7ksh6uAK5scAiILbePFzOBB1zCYwnbkV+Vj?=
 =?us-ascii?Q?CAA3uhu71llmpRrCsymyv2cWPFK1Fr6VIBphJKXRvZ6oKj9/iVc31jJ2o/Le?=
 =?us-ascii?Q?UKIqbYfK36Yv+J80x9oPByNc9De5p3I9LQPN09KSpemnmAqrniHR/DfwVD0W?=
 =?us-ascii?Q?rjolHnnB0R1Tlh7zsCT5jr45ZhY48LShmNda08Lc4qo+AuUF9ZHFEnwjiQCJ?=
 =?us-ascii?Q?jo7M6adfjO19gQ9JBcYEn7ghGyBkP3JUiaRd3JzvTV6apacLKCu3L3KZwAqW?=
 =?us-ascii?Q?xqFtF92wJEje+O/WQaFAIUGGSBZ+MKI17b8l3drXJ2cMEhFMfVm1lWuusBFM?=
 =?us-ascii?Q?ZDUf/9Rb/zzHeTYD8GBGngNFxSipJE2FcVnBaadP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272d752f-1f7f-4eac-c360-08dd1e7f13f2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:42:10.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWwW84ZcoxDHuubx9qm9BavQrZIR/Yw5EASyLiZDrrQbAORQ3GQ1Kqycmxr0lS7jFR+LEX9iXXB66S39aodQLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

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

ChangeLog v6 -> v7:
 - addressed some issues based on Yury's review (thanks!)
 - introduced a new iterator to navigate the NUMA nodes in order of
   increasing distance

ChangeLog v5 -> v6:
 - refactor patch set to introduce SCX_OPS_NODE_BUILTIN_IDLE before
   the per-node cpumasks
 - move idle CPU selection policy to a separate file (ext_idle.c)
   (no functional change, just some code shuffling)

ChangeLog v4 -> v5:
 - introduce new scx_bpf_cpu_to_node() kfunc
 - provide __COMPAT_*() helpers for the new kfunc's

ChangeLog v3 -> v4:
 - introduce SCX_OPS_NODE_BUILTIN_IDLE to select multiple per-node
   cpumasks or single flat cpumask
 - introduce new kfuncs to access per-node idle cpumasks information
 - use for_each_numa_hop_mask() to traverse NUMA nodes in increasing
   distance
 - dropped nodemask helpers (not needed anymore)
 - rebase to sched_ext/for-6.14

ChangeLog v2 -> v3:
  - introduce for_each_online_node_wrap()
  - re-introduce cpumask_intersects() in test_and_clear_cpu_idle() (to
    reduce memory writes / cache coherence pressure)
  - get rid of the redundant scx_selcpu_topo_numa logic
  [test results are pretty much identical, so I haven't updated them from v2]

ChangeLog v1 -> v2:
  - renamed for_each_node_mask|state_from() -> for_each_node_mask|state_wrap()
  - misc cpumask optimizations (thanks to Yury)

Andrea Righi (6):
      sched/topology: introduce for_each_numa_hop_node() / sched_numa_hop_node()
      sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
      sched_ext: Introduce per-node idle cpumasks
      sched_ext: Get rid of the scx_selcpu_topo_numa logic
      sched_ext: Introduce NUMA aware idle cpu kfunc helpers
      sched_ext: Move built-in idle CPU selection policy to a separate file

 MAINTAINERS                              |   1 +
 include/linux/topology.h                 |  28 +-
 kernel/sched/ext.c                       | 742 ++-------------------------
 kernel/sched/ext_idle.c                  | 835 +++++++++++++++++++++++++++++++
 kernel/sched/topology.c                  |  49 ++
 tools/sched_ext/include/scx/common.bpf.h |   4 +
 tools/sched_ext/include/scx/compat.bpf.h |  19 +
 7 files changed, 984 insertions(+), 694 deletions(-)
 create mode 100644 kernel/sched/ext_idle.c

