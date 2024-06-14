Return-Path: <linux-kernel+bounces-215066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B79908E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7B01C22869
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1C2167DAA;
	Fri, 14 Jun 2024 15:00:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C6C167278
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377256; cv=none; b=iXGu/cNsYyY1Z6lHibX0u66d6kkioA6PwnKmfutWf6DiBDt63oTTixDIRyuiHOHaRVtO0sHll9Ol8d9+Kp/5u6tO8hWZwNn+xVJyJ7vY0GBW8HiATvX1cFwJeCPxWgQZIfiwI3d+Lqfgte3H8padQcMuLu5tnuVCpExNf8eSzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377256; c=relaxed/simple;
	bh=1JhGMByyYSK2TSVRG8Znz6V98dxIE0s2bzuRTpobqNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jp3sIgfY5FQnEBULsAhT/tJWYfMxQoufdjW7F/QUvu4YUXq/R/oQhTHEqNepJxQTq3JWQNTE5X6bpOkAlTE8WSaKLtUG2kR0/4fI04CxrtUe4MI4zTCkNQHb/kyisQl1suH3MliRuTbUsHlg0yLkVzYvVE2zyDqXPQhaXj4MclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C6CAFEC;
	Fri, 14 Jun 2024 08:01:17 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E35483F5A1;
	Fri, 14 Jun 2024 08:00:49 -0700 (PDT)
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
Subject: [PATCH v3 00/38] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
Date: Fri, 14 Jun 2024 14:59:55 +0000
Message-Id: <20240614150033.10454-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2?
Patches 3+13 have been merged, then split into six patches that also bring
the format string and a few other parameters into the struct resctrl_schema.
This makes for a cleaner arch/fs split.

Dave's checkpatch fixes to existing code have been broken out into a separate
series to be posted shortly. The asm->linux changes got merged into the patch that
makes this possible.

~

This is the final series that allows other architectures to implement resctrl.
The final patch to move the code has been ommited, but can be generated using
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

This series is based on v6.10-rc1 and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v3

As ever - bugs welcome,
Thanks,

James

[v2] https://lore.kernel.org/r/20240426150537.8094-1-Dave.Martin@arm.com
[v1] https://lore.kernel.org/r/20240321165106.31602-1-james.morse@arm.com
[1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

James Morse (38):
  x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
    monitors
  x86/resctrl: Add a helper to avoid reaching into the arch code
    resource list
  x86/resctrl: Add a schema format enum and use this for fflags
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
  x86/resctrl: Move monitor exit work to a restrl exit call
  x86/resctrl: Move monitor init work to a resctrl init call
  x86/resctrl: Stop using the for_each_*_rdt_resource() walkers
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
  x86/resctrl: Claim get_domain_from_cpu() for resctrl
  x86/resctrl: Describe resctrl's bitmap size assumptions
  x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
  x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
  x86/resctrl: Drop __init/__exit on assorted symbols
  x86/resctrl: Move is_mba_sc() out of core.c
  x86/resctrl: Add end-marker to the resctrl_event_id enum
  x86/resctrl: Remove a newline to avoid confusing the code move script
  fs/resctrl: Add boiler plate for external resctrl code
  x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
  x86/resctrl: Add python script to move resctrl code to /fs/resctrl

 MAINTAINERS                               |   2 +
 arch/Kconfig                              |   8 +
 arch/x86/Kconfig                          |  12 +-
 arch/x86/include/asm/resctrl.h            |  45 +-
 arch/x86/kernel/cpu/resctrl/Makefile      |   5 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 158 ++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  67 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 185 ++----
 arch/x86/kernel/cpu/resctrl/monitor.c     |  88 +--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  65 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 288 +++++---
 arch/x86/kernel/process_32.c              |   2 +-
 arch/x86/kernel/process_64.c              |   2 +-
 fs/Kconfig                                |   1 +
 fs/Makefile                               |   1 +
 fs/resctrl/Kconfig                        |  36 +
 fs/resctrl/Makefile                       |   3 +
 fs/resctrl/ctrlmondata.c                  |   0
 fs/resctrl/internal.h                     |   0
 fs/resctrl/monitor.c                      |   0
 fs/resctrl/pseudo_lock.c                  |   0
 fs/resctrl/rdtgroup.c                     |   0
 fs/resctrl/trace.h                        |   0
 include/linux/resctrl.h                   | 193 +++++-
 include/linux/resctrl_types.h             |  59 ++
 resctrl_copy_pasta.py                     | 766 ++++++++++++++++++++++
 26 files changed, 1546 insertions(+), 440 deletions(-)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/pseudo_lock.c
 create mode 100644 fs/resctrl/rdtgroup.c
 create mode 100644 fs/resctrl/trace.h
 create mode 100644 include/linux/resctrl_types.h
 create mode 100644 resctrl_copy_pasta.py

-- 
2.39.2


