Return-Path: <linux-kernel+bounces-272898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBBA94626C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F442841DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA3E15C13B;
	Fri,  2 Aug 2024 17:29:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C159136327
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619749; cv=none; b=LaSjwnbUw9QSNjSGTS1KKJhx6UOo0taUM8QzfDDMjEhnLscQQLnqw3yG/xgQuBVQlNu5ZuWcJCrpd8MqsKLGNWlIuY13ix+xrjwZvoUofoqh50ZPVWp3ivwJq7PPiOZrW9PtY+wG9SdwO+cL23XN7ykoBAv7C9tF5OGSgGIhXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619749; c=relaxed/simple;
	bh=4B/5yuTgIwoLj5ysDmAqSjUaDu5uk78cOyFA8E4f/H0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R5qHH3Lth/x7j6h28+NDX+kqVbUg1orkqnyJZ8O7a5bTgLgHGZCO5Az5kzs4bvMUiJkqTY8FyEXl0Kbz7UELxNtuhQPOGP60ydBDJluPHMg/570I9oq6QkIy15oH3nQrATZYq++RoVy/+ttinpMcUNHd0FZexU2pIYnOiGVPxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 596291007;
	Fri,  2 Aug 2024 10:29:32 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72D0E3F64C;
	Fri,  2 Aug 2024 10:29:01 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v4 00/39] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
Date: Fri,  2 Aug 2024 17:28:14 +0000
Message-Id: <20240802172853.22529-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3?
The behaviour round fflags has changed to remove more static properties of the
schema that the arch code had to set, and to generate the 'its a cache' flags
from the resource type.
The trace file is now split in two, one file moves the other doesn't.
Otherwise changes are noted on each patch.

~

This is the final series that allows other architectures to implement resctrl.
The final patch to move the code has been omited, but can be generated using
the python script at the end of the series.
The final move is a bit of a monster. I don't expect that to get merged as part
of this series - we should wait for it to make less impact on other series.

Otherwise this series renames functions and moves code around. With the
exception of invalid configurations for the configurable-events, there should
be no changes in behaviour caused by this series.

The driving pattern is to make things like struct rdtgroup private to resctrl.
Features like pseudo-lock aren't going to work on arm64, the ability to disable
it at compile time is added.

After this, I can start posting the MPAM driver to make use of resctrl on arm64.
(What's MPAM? See the cover letter of the first series. [1])

This series is based on v6.11-rc1 and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v4

As ever - bugs welcome,
Thanks,

James

[v3] https://lore.kernel.org/r/20240614150033.10454-1-james.morse@arm.com
[v2] https://lore.kernel.org/r/20240426150537.8094-1-Dave.Martin@arm.com
[v1] https://lore.kernel.org/r/20240321165106.31602-1-james.morse@arm.com
[1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

James Morse (39):
  x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
    monitors
  x86/resctrl: Add a helper to avoid reaching into the arch code
    resource list
  x86/resctrl: Remove fflags from struct rdt_resource
  x86/resctrl: Use schema type to determine how to parse schema values
  x86/resctrl: Use schema type to determine the schema format string
  x86/resctrl: Move data_width to be a schema property
  x86/resctrl: Add max_bw to struct resctrl_membw
  x86/resctrl: Generate default_ctrl instead of sharing it
  x86/resctrl: Add helper for setting CPU default properties
  x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
  x86/resctrl: Export resctrl fs's init function
  x86/resctrl: Wrap resctrl_arch_find_domain() around rdt_find_domain()
  x86/resctrl: Move resctrl types to a separate header
  x86/resctrl: Add a resctrl helper to reset all the resources
  x86/resctrl: Move monitor exit work to a resctrl exit call
  x86/resctrl: Move monitor init work to a resctrl init call
  x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
  x86/resctrl: Export the is_mbm_*_enabled() helpers to asm/resctrl.h
  x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
  x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
  x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
  x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
  x86/resctrl: Allow an architecture to disable pseudo lock
  x86/resctrl: Make prefetch_disable_bits belong to the arch code
  x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
  x86/resctrl: Move thread_throttle_mode_init() to be managed by resctrl
  x86/resctrl: Move get_config_index() to a header
  x86/resctrl: Claim get_{mon,ctrl}_domain_from_cpu() helpers for
    resctrl
  x86/resctrl: Describe resctrl's bitmap size assumptions
  x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
  x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
  x86/resctrl: Drop __init/__exit on assorted symbols
  x86/resctrl: Move is_mba_sc() out of core.c
  x86/resctrl: Add end-marker to the resctrl_event_id enum
  x86/resctrl: Remove a newline to avoid confusing the code move script
  x86/resctrl: Split trace.h
  fs/resctrl: Add boiler plate for external resctrl code
  x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
  x86/resctrl: Add python script to move resctrl code to /fs/resctrl

 MAINTAINERS                                   |   2 +
 arch/Kconfig                                  |   8 +
 arch/x86/Kconfig                              |  12 +-
 arch/x86/include/asm/resctrl.h                |  45 +-
 arch/x86/kernel/cpu/resctrl/Makefile          |   8 +-
 arch/x86/kernel/cpu/resctrl/core.c            | 174 ++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  67 +-
 arch/x86/kernel/cpu/resctrl/internal.h        | 215 +----
 arch/x86/kernel/cpu/resctrl/monitor.c         | 104 ++-
 arch/x86/kernel/cpu/resctrl/monitor_trace.h   |  31 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  60 +-
 .../resctrl/{trace.h => pseudo_lock_trace.h}  |  24 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 276 +++++--
 arch/x86/kernel/process_32.c                  |   2 +-
 arch/x86/kernel/process_64.c                  |   2 +-
 fs/Kconfig                                    |   1 +
 fs/Makefile                                   |   1 +
 fs/resctrl/Kconfig                            |  37 +
 fs/resctrl/Makefile                           |   6 +
 fs/resctrl/ctrlmondata.c                      |   0
 fs/resctrl/internal.h                         |   0
 fs/resctrl/monitor.c                          |   0
 fs/resctrl/monitor_trace.h                    |   0
 fs/resctrl/pseudo_lock.c                      |   0
 fs/resctrl/pseudo_lock_trace.h                |   0
 fs/resctrl/rdtgroup.c                         |   0
 include/linux/resctrl.h                       | 244 +++++-
 include/linux/resctrl_types.h                 |  59 ++
 resctrl_copy_pasta.py                         | 779 ++++++++++++++++++
 29 files changed, 1655 insertions(+), 502 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/resctrl/monitor_trace.h
 rename arch/x86/kernel/cpu/resctrl/{trace.h => pseudo_lock_trace.h} (56%)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/monitor_trace.h
 create mode 100644 fs/resctrl/pseudo_lock.c
 create mode 100644 fs/resctrl/pseudo_lock_trace.h
 create mode 100644 fs/resctrl/rdtgroup.c
 create mode 100644 include/linux/resctrl_types.h
 create mode 100644 resctrl_copy_pasta.py

-- 
2.39.2


