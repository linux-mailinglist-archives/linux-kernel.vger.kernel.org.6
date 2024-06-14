Return-Path: <linux-kernel+bounces-215079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52479908E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECA1281A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14D19DF51;
	Fri, 14 Jun 2024 15:01:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772F519D070
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377314; cv=none; b=tL+1WE9Iwk4rtT+fH8vNqJvjS9RoZdnr7CXZrkx0A6PR65DY2s61hAamjK7K7vZcL4oFsX3l9x8YWljQOke8leETONRgcKs3Ka24XaWv8yHRwhz8tx4Nr0+q6gJeHp4roZD/ydXpZhkNPiXqw7uURGksX3Z9EPFht0lLcYIZmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377314; c=relaxed/simple;
	bh=ix8Ivv41v6D7Y6VgbL8qWUxWQEz5pSNmbDr+IFesDuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDMpWEWTxJMlfxfAErzMvOWWTpzPQf6Lug/oyU1vAA6aUZBeZ2UQlO/JudDOX033svZEbhDpGF8YTnan36D9cqXNhGhP+T0Qq8QN1uMHkIJalj5ngXfJj2Ytlv6giF5g2XEIT9AWpD20EG9fxW7QJPtPZVlN4DvpJbp8QpkL/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 822D21762;
	Fri, 14 Jun 2024 08:02:16 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D03353F5A1;
	Fri, 14 Jun 2024 08:01:48 -0700 (PDT)
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
	Dave Martin <dave.martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v3 13/38] x86/resctrl: Move resctrl types to a separate header
Date: Fri, 14 Jun 2024 15:00:08 +0000
Message-Id: <20240614150033.10454-14-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240614150033.10454-1-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
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

The definition of enum resctrl_event_id is need to allow the architecture
code to define resctrl_arch_event_is_free_running(),
resctrl_arch_set_cdp_enabled(), resctrl_arch_mon_ctx_alloc() and
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
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v2:
 * Added to the commit message why each of these things is necessary.
 * Moved the enum resctrl_conf_type back to resctrl.h - this week arm's
   CDP emulation code gets away without this...

Changes since v1:
 * [Commit message only] Rewrite commit message to clarify the the
   rationale for refactoring the headers in this way.
---
 MAINTAINERS                            |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 24 ------------
 include/linux/resctrl.h                | 21 +---------
 include/linux/resctrl_types.h          | 54 ++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/resctrl_types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..441b039068d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18859,6 +18859,7 @@ S:	Supported
 F:	Documentation/arch/x86/resctrl*
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
+F:	include/linux/resctrl*.h
 F:	tools/testing/selftests/resctrl/
 
 READ-COPY UPDATE (RCU)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 54aba0b6b7d2..7ede340b1301 100644
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
index 5f1d578371ab..02b745f9c4c4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
+#include <linux/resctrl_types.h>
 
 /* CLOSID, RMID value used by the default control group */
 #define RESCTRL_RESERVED_CLOSID		0
@@ -36,28 +37,8 @@ enum resctrl_conf_type {
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
index 000000000000..51c51a1aabfb
--- /dev/null
+++ b/include/linux/resctrl_types.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Arm Ltd.
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
2.39.2


