Return-Path: <linux-kernel+bounces-176959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9576F8C37D6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D41F2110C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD814F1F2;
	Sun, 12 May 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTlMsFb0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C804E1B3;
	Sun, 12 May 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536495; cv=none; b=M6+sjdLtxQUS2N3Gb/eR1tI+6/wbDJAI6lDYj8m8wuJOllPvt6gXUp9MbWgYWQLLCOnjmFjbiupx1RXq5O1Qd0w8UhK1lZeP15Ym/WVUiyU2QdHo1gwxuAoX3dG5E7W+Jiw0jH8GX5G65bRSis3LDpheSuJA8OYLyChfp4+fHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536495; c=relaxed/simple;
	bh=wn4E+v2uyDN2dJZ65gqOpdl2NzXUMC4+oaqV2sgaxMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dOzJKn/WZw2xa8eqZdc2jrKvW3tpCJXaIulIn//flfYBD1VwsPqKHKZunDSm+G4IvcppncXSdLzudAFVcNfDXfIOTTP0kPvL5UiXMzzBFoD6Bss34zWxk2mJ/CY08l7jzzZ8aKMn80+Lj2vTf8eFnFZsZnEGtXFdpw7Kho/1UjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTlMsFb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669BFC116B1;
	Sun, 12 May 2024 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715536494;
	bh=wn4E+v2uyDN2dJZ65gqOpdl2NzXUMC4+oaqV2sgaxMQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OTlMsFb07J7Kek0jx31uOxnF3kXRcl71aI+y6ROkhib7yEyAJ7s3V1pEI9hDqWK5v
	 k+fvKNdg0099e6KBC9RY66Pr5kgPqsk+D8N27og9RzkYDrNJ83ltrVvL6RsvGS750H
	 aHcII+y2n7oaeiP8QSf15Wli7Vz8b90uYwDRj0La/axdtjeOWbn0NpQ7Wq0J8u+ayf
	 59GQTV6aW0NR3YBpfn7naiHIgfL0Az2EoOjktcnDiIfD7+jzO7+MTIWOQC0O+5/CZi
	 9ew+VYvDcrYYSgjnV88qe1vJLZYy9O0OML29cE09wGA1iaS4afc7hoB5y/5Ea7+5jU
	 JkdQd+J7F9Mvw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>
Subject: [RFC PATCH v4 0/5] DAMON based tiered memory management for CXL memory
Date: Sun, 12 May 2024 10:54:42 -0700
Message-Id: <20240512175447.75943-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
posted at [1].

It says there is no implementation of the demote/promote DAMOS action
are made.  This RFC is about its implementation for physical address
space.

Changes from RFC v3
(https://lore.kernel.org/20240405060858.2818-1-honggyu.kim@sk.com):
  0. updated from v3 and posted by SJ on behalf of Hunggyu under his
     approval.
  1. Do not reuse damon_pa_pageout() and drop 'enum migration_mode'
  2. Drop vmstat change
  3. Drop unnecessary page reference check

Changes from RFC v2:
  1. Rename DAMOS_{PROMOTE,DEMOTE} actions to DAMOS_MIGRATE_{HOT,COLD}.
  2. Create 'target_nid' to set the migration target node instead of
     depending on node distance based information.
  3. Instead of having page level access check in this patch series,
     delegate the job to a new DAMOS filter type YOUNG[2].
  4. Introduce vmstat counters "damon_migrate_{hot,cold}".
  5. Rebase from v6.7 to v6.8.

Changes from RFC:
  1. Move most of implementation from mm/vmscan.c to mm/damon/paddr.c.
  2. Simplify some functions of vmscan.c and used in paddr.c, but need
     to be reviewed more in depth.
  3. Refactor most functions for common usage for both promote and
     demote actions and introduce an enum migration_mode for its control.
  4. Add "target_nid" sysfs knob for migration destination node for both
     promote and demote actions.
  5. Move DAMOS_PROMOTE before DAMOS_DEMOTE and move then even above
     DAMOS_STAT.

Introduction
============

With the advent of CXL/PCIe attached DRAM, which will be called simply
as CXL memory in this cover letter, some systems are becoming more
heterogeneous having memory systems with different latency and bandwidth
characteristics.  They are usually handled as different NUMA nodes in
separate memory tiers and CXL memory is used as slow tiers because of
its protocol overhead compared to local DRAM.

In this kind of systems, we need to be careful placing memory pages on
proper NUMA nodes based on the memory access frequency.  Otherwise, some
frequently accessed pages might reside on slow tiers and it makes
performance degradation unexpectedly.  Moreover, the memory access
patterns can be changed at runtime.

To handle this problem, we need a way to monitor the memory access
patterns and migrate pages based on their access temperature.  The
DAMON(Data Access MONitor) framework and its DAMOS(DAMON-based Operation
Schemes) can be useful features for monitoring and migrating pages.
DAMOS provides multiple actions based on DAMON monitoring results and it
can be used for proactive reclaim, which means swapping cold pages out
with DAMOS_PAGEOUT action, but it doesn't support migration actions such
as demotion and promotion between tiered memory nodes.

This series supports two new DAMOS actions; DAMOS_MIGRATE_HOT for
promotion from slow tiers and DAMOS_MIGRATE_COLD for demotion from fast
tiers.  This prevents hot pages from being stuck on slow tiers, which
makes performance degradation and cold pages can be proactively demoted
to slow tiers so that the system can increase the chance to allocate
more hot pages to fast tiers.

The DAMON provides various tuning knobs but we found that the proactive
demotion for cold pages is especially useful when the system is running
out of memory on its fast tier nodes.

Our evaluation result shows that it reduces the performance slowdown
compared to the default memory policy from 17~18% to 4~5% when the
system runs under high memory pressure on its fast tier DRAM nodes.

DAMON configuration
===================

The specific DAMON configuration doesn't have to be in the scope of this
patch series, but some rough idea is better to be shared to explain the
evaluation result.

The DAMON provides many knobs for fine tuning but its configuration file
is generated by HMSDK[3].  It includes gen_config.py script that
generates a json file with the full config of DAMON knobs and it creates
multiple kdamonds for each NUMA node when the DAMON is enabled so that
it can run hot/cold based migration for tiered memory.

Evaluation Workload
===================

The performance evaluation is done with redis[4], which is a widely used
in-memory database and the memory access patterns are generated via
YCSB[5].  We have measured two different workloads with zipfian and
latest distributions but their configs are slightly modified to make
memory usage higher and execution time longer for better evaluation.

The idea of evaluation using these migrate_{hot,cold} actions covers
system-wide memory management rather than partitioning hot/cold pages of
a single workload.  The default memory allocation policy creates pages
to the fast tier DRAM node first, then allocates newly created pages to
the slow tier CXL node when the DRAM node has insufficient free space.
Once the page allocation is done then those pages never move between
NUMA nodes.  It's not true when using numa balancing, but it is not the
scope of this DAMON based tiered memory management support.

If the working set of redis can be fit fully into the DRAM node, then
the redis will access the fast DRAM only.  Since the performance of DRAM
only is faster than partially accessing CXL memory in slow tiers, this
environment is not useful to evaluate this patch series.

To make pages of redis be distributed across fast DRAM node and slow
CXL node to evaluate our migrate_{hot,cold} actions, we pre-allocate
some cold memory externally using mmap and memset before launching
redis-server.  We assumed that there are enough amount of cold memory in
datacenters as TMO[6] and TPP[7] papers mentioned.

The evaluation sequence is as follows.

1. Turn on DAMON with DAMOS_MIGRATE_COLD action for DRAM node and
   DAMOS_MIGRATE_HOT action for CXL node.  It demotes cold pages on DRAM
   node and promotes hot pages on CXL node in a regular interval.
2. Allocate a huge block of cold memory by calling mmap and memset at
   the fast tier DRAM node, then make the process sleep to make the fast
   tier has insufficient space for redis-server.
3. Launch redis-server and load prebaked snapshot image, dump.rdb.  The
   redis-server consumes 52GB of anon pages and 33GB of file pages, but
   due to the cold memory allocated at 2, it fails allocating the entire
   memory of redis-server on the fast tier DRAM node so it partially
   allocates the remaining on the slow tier CXL node.  The ratio of
   DRAM:CXL depends on the size of the pre-allocated cold memory.
4. Run YCSB to make zipfian or latest distribution of memory accesses to
   redis-server, then measure its execution time when it's completed.
5. Repeat 4 over 50 times to measure the average execution time for each
   run.
6. Increase the cold memory size then repeat goes to 2.

For each test at 4 took about a minute so repeating it 50 times almost
took about 1 hour for each test with a specific cold memory from 440GB
to 500GB in 10GB increments for each evaluation.  So it took about more
than 10 hours for both zipfian and latest workloads to get the entire
evaluation results.  Repeating the same test set multiple times doesn't
show much difference so I think it might be enough to make the result
reliable.

Evaluation Results
==================

All the result values are normalized to DRAM-only execution time because
the workload cannot be faster than DRAM-only unless the workload hits
the peak bandwidth but our redis test doesn't go beyond the bandwidth
limit.

So the DRAM-only execution time is the ideal result without affected by
the gap between DRAM and CXL performance difference.  The NUMA node
environment is as follows.

  node0 - local DRAM, 512GB with a CPU socket (fast tier)
  node1 - disabled
  node2 - CXL DRAM, 96GB, no CPU attached (slow tier)

The following is the result of generating zipfian distribution to
redis-server and the numbers are averaged by 50 times of execution.

  1. YCSB zipfian distribution read only workload
  memory pressure with cold memory on node0 with 512GB of local DRAM.
  =============+================================================+=========
               |       cold memory occupied by mmap and memset  |
               |   0G  440G  450G  460G  470G  480G  490G  500G |
  =============+================================================+=========
  Execution time normalized to DRAM-only values                 | GEOMEAN
  -------------+------------------------------------------------+---------
  DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
  CXL-only     | 1.22     -     -     -     -     -     -     - | 1.22
  default      |    -  1.12  1.13  1.14  1.16  1.19  1.21  1.21 | 1.17
  DAMON tiered |    -  1.04  1.03  1.04  1.06  1.05  1.05  1.05 | 1.05
  =============+================================================+=========
  CXL usage of redis-server in GB                               | AVERAGE
  -------------+------------------------------------------------+---------
  DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
  default      |    -  20.4  27.0  33.1  39.5  45.6  50.5  50.3 | 38.1
  DAMON tiered |    -   0.1   0.3   0.8   0.6   0.7   1.3   0.9 |  0.7
  =============+================================================+=========

Each test result is based on the exeuction environment as follows.

  DRAM-only   : redis-server uses only local DRAM memory.
  CXL-only    : redis-server uses only CXL memory.
  default     : default memory policy(MPOL_DEFAULT).
                numa balancing disabled.
  DAMON tiered: DAMON enabled with DAMOS_MIGRATE_COLD for DRAM nodes and
                DAMOS_MIGRATE_HOT for CXL nodes.

The above result shows the "default" execution time goes up as the size
of cold memory is increased from 440G to 500G because the more cold
memory used, the more CXL memory is used for the target redis workload
and this makes the execution time increase.

However, "DAMON tiered" result shows less slowdown because the
DAMOS_MIGRATE_COLD action at DRAM node proactively demotes pre-allocated
cold memory to CXL node and this free space at DRAM increases more
chance to allocate hot or warm pages of redis-server to fast DRAM node.
Moreover, DAMOS_MIGRATE_HOT action at CXL node also promotes hot pages
of redis-server to DRAM node actively.

As a result, it makes more memory of redis-server stay in DRAM node
compared to "default" memory policy and this makes the performance
improvement.

The following result of latest distribution workload shows similar data.

  2. YCSB latest distribution read only workload
  memory pressure with cold memory on node0 with 512GB of local DRAM.
  =============+================================================+=========
               |       cold memory occupied by mmap and memset  |
               |   0G  440G  450G  460G  470G  480G  490G  500G |
  =============+================================================+=========
  Execution time normalized to DRAM-only values                 | GEOMEAN
  -------------+------------------------------------------------+---------
  DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
  CXL-only     | 1.18     -     -     -     -     -     -     - | 1.18
  default      |    -  1.18  1.19  1.18  1.18  1.17  1.19  1.18 | 1.18
  DAMON tiered |    -  1.04  1.04  1.04  1.05  1.04  1.05  1.05 | 1.04
  =============+================================================+=========
  CXL usage of redis-server in GB                               | AVERAGE
  -------------+------------------------------------------------+---------
  DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
  default      |    -  20.5  27.1  33.2  39.5  45.5  50.4  50.5 | 38.1
  DAMON tiered |    -   0.2   0.4   0.7   1.6   1.2   1.1   3.4 |  1.2
  =============+================================================+=========

In summary of both results, our evaluation shows that "DAMON tiered"
memory management reduces the performance slowdown compared to the
"default" memory policy from 17~18% to 4~5% when the system runs with
high memory pressure on its fast tier DRAM nodes.

Having these DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD actions can make
tiered memory systems run more efficiently under high memory pressures.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>

[1] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org
[2] https://lore.kernel.org/damon/20240311204545.47097-1-sj@kernel.org
[3] https://github.com/skhynix/hmsdk
[4] https://github.com/redis/redis/tree/7.0.0
[5] https://github.com/brianfrankcooper/YCSB/tree/0.17.0
[6] https://dl.acm.org/doi/10.1145/3503222.3507731
[7] https://dl.acm.org/doi/10.1145/3582016.3582063

Honggyu Kim (3):
  mm: make alloc_demote_folio externally invokable for migration
  mm/migrate: add MR_DAMON to migrate_reason
  mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion

Hyeongtak Ji (2):
  mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
  mm/damon/paddr: introduce DAMOS_MIGRATE_HOT action for promotion

 include/linux/damon.h          |  15 +++-
 include/linux/migrate_mode.h   |   1 +
 include/trace/events/migrate.h |   3 +-
 mm/damon/core.c                |   5 +-
 mm/damon/dbgfs.c               |   2 +-
 mm/damon/lru_sort.c            |   3 +-
 mm/damon/paddr.c               | 157 +++++++++++++++++++++++++++++++++
 mm/damon/reclaim.c             |   3 +-
 mm/damon/sysfs-schemes.c       |  35 +++++++-
 mm/internal.h                  |   1 +
 mm/vmscan.c                    |   3 +-
 11 files changed, 219 insertions(+), 9 deletions(-)


base-commit: edc60852c99779574e0748bcf766560db67eb423
-- 
2.39.2


