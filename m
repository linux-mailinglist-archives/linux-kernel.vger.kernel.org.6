Return-Path: <linux-kernel+bounces-556729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4223A5CE02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9430C3B46F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF22620E5;
	Tue, 11 Mar 2025 18:39:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612BE156F3C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718387; cv=none; b=QKIj7+1HTj014LG8UgPJsDQD82rVgf/x+G+ByP0MLotfTExqhKkJvHTk/td3JhWiznE9c+6jlKUwvTBF1mp77A9rXzUxIQBTADT/y3wS6bFMt/JkopG2WNXEne3PWjn1WO6miE0hIDYTv50yOhtQJf6lGFeDW6EedRa6YBSm7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718387; c=relaxed/simple;
	bh=wUHa8y5xBU2lhWCwVY8ZLhXNqNYcpKCcl3LWaRKPQl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oNBKkAgbAemSu0d4svttJppH+eCfbBOhnaWwPj6UJ2M8vWprUj985NxiHQQLP+yc5CFbzzhKg2cPN5GqOoRVXd7kVTgkYHnzotFIKzZo6Sp89XM9X9QtzVF76LzlXdYZKsKx12AtKP9BtWLMeEdlH+FZaKaA1vwAw83ydcBA7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFAE11515;
	Tue, 11 Mar 2025 11:39:56 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8732D3F694;
	Tue, 11 Mar 2025 11:39:42 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 00/30] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
Date: Tue, 11 Mar 2025 18:36:45 +0000
Message-Id: <20250311183715.16445-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v7?:
 * Series split to the first 30 patches, requested by Boris.
 * Fixed stale function names, definitions/declartions and typos.
 * Dropped the use of the default ctrlval helper in cache_alloc_hsw_probe()

As ever, changes are noted on each patch.
---
This series renames functions and moves code around. With the
exception of invalid configurations for the configurable-events, there should
be no changes in behaviour caused by this series. It is now possible for
throttle_mode to report 'undefined', but no known platform will do this.

The driving pattern is to make things like struct rdtgroup private to resctrl.
Features like pseudo-lock aren't going to work on arm64, the ability to disable
it at compile time is added.

All this is to allow the filesystem portions of resctrl to be moved to live in /fs/,
which allows resctrl to be supported by other architecture, such as arm64's MPAM.
(What's MPAM? See the cover letter of the first series. [1])

This series is based on v6.14-rc3 and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v8_for_boris

As ever - bugs welcome,
Thanks,

James

[v7] https://lore.kernel.org/lkml/20250228195913.24895-1-james.morse@arm.com
[v6] https://lore.kernel.org/lkml/20250207181823.6378-1-james.morse@arm.com/
[v5] https://lore.kernel.org/r/20241004180347.19985-1-james.morse@arm.com
[v4] https://lore.kernel.org/all/20240802172853.22529-1-james.morse@arm.com/
[v3] https://lore.kernel.org/r/20240614150033.10454-1-james.morse@arm.com
[v2] https://lore.kernel.org/r/20240426150537.8094-1-Dave.Martin@arm.com
[v1] https://lore.kernel.org/r/20240321165106.31602-1-james.morse@arm.com
[1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

James Morse (30):
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

 MAINTAINERS                               |   1 +
 arch/x86/Kconfig                          |   7 +
 arch/x86/include/asm/resctrl.h            |  36 ++-
 arch/x86/kernel/cpu/resctrl/Makefile      |   5 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 181 ++++----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  93 ++++---
 arch/x86/kernel/cpu/resctrl/internal.h    | 201 ++++-----------
 arch/x86/kernel/cpu/resctrl/monitor.c     | 119 ++++++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  55 +++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 284 ++++++++++++++++------
 include/linux/resctrl.h                   | 212 ++++++++++++++--
 include/linux/resctrl_types.h             |  54 ++++
 12 files changed, 769 insertions(+), 479 deletions(-)
 create mode 100644 include/linux/resctrl_types.h

-- 
2.39.5


