Return-Path: <linux-kernel+bounces-556743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F70A5CE12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6A517D84B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57446263F30;
	Tue, 11 Mar 2025 18:41:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920E264F93
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718459; cv=none; b=Mw+gOEuGtAOzj4Mf7+6Wr2kkr3lyTTO5IrnUzfHsnNDDM/XJOd6zjd/8RTLohqwjdYYIP2bL5j2O4TBGIZShrhYlbnu8qleVZZLSiJfn0zxZigs1JksLj1hk4EBra/kYsXqpbXyI6KnC0h9jXivptrpX4y5D1P865LcNQv60A1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718459; c=relaxed/simple;
	bh=616hTUR6IFZ3lVm4uiCHm6fQ4taBBoJ3UxwHzfB59l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j6keD+PWRorn0goNm/gooGh4BrT0DxmUgCvWdm5yzz1Mugk7uzIMsqqUnNdg3OBBsfkX6vd3z6gL+YtIm8HTOs5Bxx93N5iIyBU7QMulr1IIz8FXgMviZIv6WCkEJfjICZWlDz7t4nJXkNkKj5rPAXPh8k51qb/fBNBW0JeTJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1551C1515;
	Tue, 11 Mar 2025 11:41:08 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9183C3F694;
	Tue, 11 Mar 2025 11:40:53 -0700 (PDT)
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
	fenghuay@nvidia.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8:for-boris 13/30] x86/resctrl: Move resctrl types to a separate header
Date: Tue, 11 Mar 2025 18:36:58 +0000
Message-Id: <20250311183715.16445-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250311183715.16445-1-james.morse@arm.com>
References: <20250311183715.16445-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When resctrl is fully factored into core and per-arch code, each arch
will need to use some resctrl common definitions in order to define its
own specializations and helpers.  Following conventional practice, it
would be desirable to put the dependent arch definitions in an
<asm/resctrl.h> header that is included by the common <linux/resctrl.h>
header.  However, this can make it awkward to avoid a circular
dependency between <linux/resctrl.h> and the arch header.

To avoid such dependencies, move the affected common types and
constants into a new header that does not need to depend on
<linux/resctrl.h> or on the arch headers.

The same logic applies to the monitor-configuration defines, move these
too.

Some kind of enumeration for events is needed between the filesystem
and architecture code. Take the x86 definition as its convenient for
x86.

The definition of enum resctrl_event_id is needed to allow the
architecture code to define resctrl_arch_mon_ctx_alloc() and
resctrl_arch_mon_ctx_free().

The definition of enum resctrl_res_level is needed to allow the
architecture code to define resctrl_arch_set_cdp_enabled() and
resctrl_arch_get_cdp_enabled().

The bits for mbm_local_bytes_config et al are ABI, and must be the same
on all architectures. These are documented in
Documentation/arch/x86/resctrl.rst

The maintainers entry for these headers was missed when resctrl.h was
created. Add a wildcard entry to match both resctrl.h and
resctrl_types.h.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v6:
 * Used a different year in the boiler-plate copyright notice.

Change since v3:
 * Added header include.
 * Corrected lists in the commit message.

Changes since v2:
 * Added to the commit message why each of these things is necessary.
 * Moved the enum resctrl_conf_type back to resctrl.h - this week arm's
   CDP emulation code gets away without this...

Changes since v1:
 * [Commit message only] Rewrite commit message to clarify the the
   rationale for refactoring the headers in this way.
---
 MAINTAINERS                            |  1 +
 arch/x86/include/asm/resctrl.h         |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 24 ------------
 include/linux/resctrl.h                | 21 +---------
 include/linux/resctrl_types.h          | 54 ++++++++++++++++++++++++++
 5 files changed, 57 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/resctrl_types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..3487ac429a9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19881,6 +19881,7 @@ S:	Supported
 F:	Documentation/arch/x86/resctrl*
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
+F:	include/linux/resctrl*.h
 F:	tools/testing/selftests/resctrl/
 
 READ-COPY UPDATE (RCU)
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 6908cd0e6e40..52f2326e2b1e 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -6,6 +6,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
+#include <linux/resctrl_types.h>
 #include <linux/sched.h>
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index da73404183da..5f3713fb2eaf 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -32,30 +32,6 @@
  */
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
-/* Reads to Local DRAM Memory */
-#define READS_TO_LOCAL_MEM		BIT(0)
-
-/* Reads to Remote DRAM Memory */
-#define READS_TO_REMOTE_MEM		BIT(1)
-
-/* Non-Temporal Writes to Local Memory */
-#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
-
-/* Non-Temporal Writes to Remote Memory */
-#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
-
-/* Reads to Local Memory the system identifies as "Slow Memory" */
-#define READS_TO_LOCAL_S_MEM		BIT(4)
-
-/* Reads to Remote Memory the system identifies as "Slow Memory" */
-#define READS_TO_REMOTE_S_MEM		BIT(5)
-
-/* Dirty Victims to All Types of Memory */
-#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
-
-/* Max event bits supported */
-#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
-
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 93d9a435f035..326f7ba220e7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
+#include <linux/resctrl_types.h>
 
 /* CLOSID, RMID value used by the default control group */
 #define RESCTRL_RESERVED_CLOSID		0
@@ -37,28 +38,8 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
-enum resctrl_res_level {
-	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L2,
-	RDT_RESOURCE_MBA,
-	RDT_RESOURCE_SMBA,
-
-	/* Must be the last */
-	RDT_NUM_RESOURCES,
-};
-
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
-/*
- * Event IDs, the values match those used to program IA32_QM_EVTSEL before
- * reading IA32_QM_CTR on RDT systems.
- */
-enum resctrl_event_id {
-	QOS_L3_OCCUP_EVENT_ID		= 0x01,
-	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
-	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
-};
-
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
new file mode 100644
index 000000000000..f26450b3326b
--- /dev/null
+++ b/include/linux/resctrl_types.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Arm Ltd.
+ * Based on arch/x86/kernel/cpu/resctrl/internal.h
+ */
+
+#ifndef __LINUX_RESCTRL_TYPES_H
+#define __LINUX_RESCTRL_TYPES_H
+
+/* Reads to Local DRAM Memory */
+#define READS_TO_LOCAL_MEM		BIT(0)
+
+/* Reads to Remote DRAM Memory */
+#define READS_TO_REMOTE_MEM		BIT(1)
+
+/* Non-Temporal Writes to Local Memory */
+#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
+
+/* Non-Temporal Writes to Remote Memory */
+#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
+
+/* Reads to Local Memory the system identifies as "Slow Memory" */
+#define READS_TO_LOCAL_S_MEM		BIT(4)
+
+/* Reads to Remote Memory the system identifies as "Slow Memory" */
+#define READS_TO_REMOTE_S_MEM		BIT(5)
+
+/* Dirty Victims to All Types of Memory */
+#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
+
+/* Max event bits supported */
+#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
+
+enum resctrl_res_level {
+	RDT_RESOURCE_L3,
+	RDT_RESOURCE_L2,
+	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
+
+	/* Must be the last */
+	RDT_NUM_RESOURCES,
+};
+
+/*
+ * Event IDs, the values match those used to program IA32_QM_EVTSEL before
+ * reading IA32_QM_CTR on RDT systems.
+ */
+enum resctrl_event_id {
+	QOS_L3_OCCUP_EVENT_ID		= 0x01,
+	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
+	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
+};
+
+#endif /* __LINUX_RESCTRL_TYPES_H */
-- 
2.39.5


