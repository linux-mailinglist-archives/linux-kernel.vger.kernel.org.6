Return-Path: <linux-kernel+bounces-539334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E300FA4A34D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68657189DD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD8230BF0;
	Fri, 28 Feb 2025 19:59:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE575230BD8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772768; cv=none; b=OZBuU6evbaIYs1qMouU5s+TwXvonTTspn7zQyp4LH80XTEqYZIbdw8JgqT3eB+MM74LTBxJtp92S5AlJ+F4YeIEgkFwAl9BR6950x16cP88Ka99N77GixXi81kSmilYnCn59kbr+Q/080ziWYuaOyL/MwTxlRsvG/r3XBgipTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772768; c=relaxed/simple;
	bh=XP0TI2PEn56nE5jleIDIw8MUKF5fyUaMl326n70er+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U385N7BZ7jkUK2erSGhwPMivLyY9UmqMxdQD0973mSw0Ayn9evz7gKCQCfwodQF6taPXvl9YL6iTxhNc0P9juPJAbMXCSw6G5lWHAUfHvI9k92mBr5jFw83OdUTYcEmbm5xxUSVaoEyoJtvijKC3VZQY0FcGx4eNVY2El1WqiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7119B1515;
	Fri, 28 Feb 2025 11:59:41 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 354F93F5A1;
	Fri, 28 Feb 2025 11:59:23 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
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
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com
Subject: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
Date: Fri, 28 Feb 2025 19:58:24 +0000
Message-Id: <20250228195913.24895-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v6?:
 * All the excitement is in patch 37, turns out there are two rmdir() paths
   that don't join up.
The last eight patches are new:
 * The python script has been replaced with the patch that it generates, see
   the bare branch below if you want to regenerate it.
 * There have been comments on the followup to the generated patch, those are
   included here - I suggest they be squashed into the generated patch.
 * This version includes some checkpatch linting from Dave.

---
This series renames functions and moves code around. With the
exception of invalid configurations for the configurable-events, there should
be no changes in behaviour caused by this series. It is now possible for
throttle_mode to report 'undefined', but no known platform will do this.

The driving pattern is to make things like struct rdtgroup private to resctrl.
Features like pseudo-lock aren't going to work on arm64, the ability to disable
it at compile time is added.

After this, I can start posting the MPAM driver to make use of resctrl on arm64.
(What's MPAM? See the cover letter of the first series. [1])

This series is based on v6.14-rc3 and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7
or for those who want to regnerate the patch that moves all the code:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare


As ever - bugs welcome,
Thanks,

James

[v6] https://lore.kernel.org/lkml/20250207181823.6378-1-james.morse@arm.com/
[v5] https://lore.kernel.org/r/20241004180347.19985-1-james.morse@arm.com
[v4] https://lore.kernel.org/all/20240802172853.22529-1-james.morse@arm.com/
[v3] https://lore.kernel.org/r/20240614150033.10454-1-james.morse@arm.com
[v2] https://lore.kernel.org/r/20240426150537.8094-1-Dave.Martin@arm.com
[v1] https://lore.kernel.org/r/20240321165106.31602-1-james.morse@arm.com
[1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

Amit Singh Tomar (1):
  x86/resctrl: Remove the limit on the number of CLOSID

Dave Martin (3):
  x86/resctrl: Squelch whitespace anomalies in resctrl core code
  x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in rdt_init_fs_context()
  x86/resctrl: Relax some asm #includes

James Morse (45):
  x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
    monitors
  x86/resctrl: Add a helper to avoid reaching into the arch code
    resource list
  x86/resctrl: Remove fflags from struct rdt_resource
  x86/resctrl: Use schema type to determine how to parse schema values
  x86/resctrl: Use schema type to determine the schema format string
  x86/resctrl: Remove data_width and the tabular format
  x86/resctrl: Add max_bw to struct resctrl_membw
  x86/resctrl: Generate default_ctrl instead of sharing it
  x86/resctrl: Add helper for setting CPU default properties
  x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
  x86/resctrl: Expose resctrl fs's init function to the rest of the
    kernel
  x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code
  x86/resctrl: Move resctrl types to a separate header
  x86/resctrl: Add an arch helper to reset one resource
  x86/resctrl: Move monitor exit work to a resctrl exit call
  x86/resctrl: Move monitor init work to a resctrl init call
  x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
  x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h
  x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
  x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
  x86/resctrl: Move mba_mbps_default_event init to filesystem code
  x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
  x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
  x86/resctrl: Allow an architecture to disable pseudo lock
  x86/resctrl: Make prefetch_disable_bits belong to the arch code
  x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
  x86/resctrl: Move RFTYPE flags to be managed by resctrl
  x86/resctrl: Handle throttle_mode for SMBA resources
  x86/resctrl: Move get_config_index() to a header
  x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their
    callers
  x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
  x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
  x86/resctrl: Drop __init/__exit on assorted symbols
  x86/resctrl: Move is_mba_sc() out of core.c
  x86/resctrl: Add end-marker to the resctrl_event_id enum
  x86/resctrl: Expand the width of dom_id by replacing mon_data_bits
  x86/resctrl: Remove a newline to avoid confusing the code move script
  x86/resctrl: Split trace.h
  fs/resctrl: Add boiler plate for external resctrl code
  x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
  x86,fs/resctrl: Move the resctrl filesystem code to live in
    /fs/resctrl
  x86,fs/resctrl: Remove duplicated trace header files
  fs/resctrl: Remove unnecessary includes
  fs/resctrl: Change internal.h's header guard macros
  x86,fs/resctrl: Move resctrl.rst to live under
    Documentation/filesystems

 Documentation/arch/x86/index.rst              |    1 -
 Documentation/filesystems/index.rst           |    1 +
 .../{arch/x86 => filesystems}/resctrl.rst     |    0
 MAINTAINERS                                   |    4 +-
 arch/Kconfig                                  |    8 +
 arch/x86/Kconfig                              |    6 +-
 arch/x86/include/asm/resctrl.h                |   43 +-
 arch/x86/kernel/cpu/resctrl/Makefile          |    8 +-
 arch/x86/kernel/cpu/resctrl/core.c            |  214 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  606 +--
 arch/x86/kernel/cpu/resctrl/internal.h        |  504 +-
 arch/x86/kernel/cpu/resctrl/monitor.c         |  863 +---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     | 1120 +----
 .../resctrl/{trace.h => pseudo_lock_trace.h}  |   26 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 4031 +--------------
 arch/x86/kernel/process_32.c                  |    2 +-
 arch/x86/kernel/process_64.c                  |    2 +-
 fs/Kconfig                                    |    1 +
 fs/Makefile                                   |    1 +
 fs/resctrl/Kconfig                            |   39 +
 fs/resctrl/Makefile                           |    6 +
 fs/resctrl/ctrlmondata.c                      |  660 +++
 fs/resctrl/internal.h                         |  435 ++
 fs/resctrl/monitor.c                          |  933 ++++
 fs/resctrl/monitor_trace.h                    |   33 +
 fs/resctrl/pseudo_lock.c                      | 1104 +++++
 fs/resctrl/rdtgroup.c                         | 4329 +++++++++++++++++
 include/linux/resctrl.h                       |  216 +-
 include/linux/resctrl_types.h                 |   59 +
 29 files changed, 7992 insertions(+), 7263 deletions(-)
 rename Documentation/{arch/x86 => filesystems}/resctrl.rst (100%)
 rename arch/x86/kernel/cpu/resctrl/{trace.h => pseudo_lock_trace.h} (56%)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/monitor_trace.h
 create mode 100644 fs/resctrl/pseudo_lock.c
 create mode 100644 fs/resctrl/rdtgroup.c
 create mode 100644 include/linux/resctrl_types.h

-- 
2.39.5


