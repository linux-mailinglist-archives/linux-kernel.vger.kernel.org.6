Return-Path: <linux-kernel+bounces-350898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B9990ABC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BC61C23C80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AA32216A0;
	Fri,  4 Oct 2024 18:07:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D841E32B4
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065230; cv=none; b=gZPpdPuUFxBafYaaL/pt3CNjGcFoDW9AnXWWb09K6IScrwYqI4y7lkGzpACVumW9BhgqAN9wOhLeVAKE1FfXXMREE6EU4wLKSrShGRGMEDNo7xmZvv+A/QWiRugiZNb/3CG/gl8jLGTigiUXo7zSwp2ADe+KSauvehq9qSHGVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065230; c=relaxed/simple;
	bh=5hrkVVp2lWn2w89gJ+7pJadb+EmEHBsgZR4KaiB3/lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwaYdgHCuI9NdiUXDX0Vv8sioMIAWQlg+we+xqfQxBVzB7A1MNPe1nLLWOOlPPhDDwRUefv2jX1MZgIrcivs/yQB/Q3wSGP9J2ryvsCPIq8FW/1o2hhPTWv3X/tfeK8eQDaarb9ZqkTj+76TjAvWPeVax3M70pZvxqUPyHpfrdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C07E1063;
	Fri,  4 Oct 2024 11:07:37 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5163F58B;
	Fri,  4 Oct 2024 11:07:04 -0700 (PDT)
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
	Dave Martin <Dave.Martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 38/40] fs/resctrl: Add boiler plate for external resctrl code
Date: Fri,  4 Oct 2024 18:03:45 +0000
Message-Id: <20241004180347.19985-39-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
for the common parts of the resctrl interface and make X86_CPU_RESCTRL
select this.

Adding an include of asm/resctrl.h to linux/resctrl.h allows the
/fs/resctrl files to switch over to using this header instead.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v4:
 * Tweaking of the commit message.

Changes since v3:
 * Reworded 'if unsure say N' from the Kconfig text, the user doesn't have
   the choice anyway at this point.
 * Added PWD to monitor.o's CFLAGS for the ftrace rube-goldberg build machine.
 * Added split trace files.

Changes since v2:
 * Dropped KERNFS dependency from arch side Kconfig.
 * Added empty trace.h file.
 * Merged asm->linux includes from Dave's patch to decouple those
   patches from this series.

Changes since v1:
 * Rename new file psuedo_lock.c to pseudo_lock.c, to match the name
   of the original file (and to be less surprising).

 * [Whitespace only] Under RESCTRL_FS in fs/resctrl/Kconfig, delete
   alignment space in orphaned select ... if (which has nothing to line
   up with any more).

 * [Whitespace only] Reflow and re-tab Kconfig additions.
---
 MAINTAINERS                               |  1 +
 arch/Kconfig                              |  8 +++++
 arch/x86/Kconfig                          |  5 +--
 arch/x86/kernel/cpu/resctrl/internal.h    |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 fs/Kconfig                                |  1 +
 fs/Makefile                               |  1 +
 fs/resctrl/Kconfig                        | 37 +++++++++++++++++++++++
 fs/resctrl/Makefile                       |  6 ++++
 fs/resctrl/ctrlmondata.c                  |  0
 fs/resctrl/internal.h                     |  0
 fs/resctrl/monitor.c                      |  0
 fs/resctrl/monitor_trace.h                |  0
 fs/resctrl/pseudo_lock.c                  |  0
 fs/resctrl/pseudo_lock_trace.h            |  0
 fs/resctrl/rdtgroup.c                     |  0
 include/linux/resctrl.h                   |  4 +++
 19 files changed, 65 insertions(+), 7 deletions(-)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/monitor_trace.h
 create mode 100644 fs/resctrl/pseudo_lock.c
 create mode 100644 fs/resctrl/pseudo_lock_trace.h
 create mode 100644 fs/resctrl/rdtgroup.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fd5a1621c026..f4a785a44c83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19468,6 +19468,7 @@ S:	Supported
 F:	Documentation/arch/x86/resctrl*
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
+F:	fs/resctrl/
 F:	include/linux/resctrl*.h
 F:	tools/testing/selftests/resctrl/
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 98157b38f5cf..55865b903d9d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1456,6 +1456,14 @@ config STRICT_MODULE_RWX
 config ARCH_HAS_PHYS_TO_DMA
 	bool
 
+config ARCH_HAS_CPU_RESCTRL
+	bool
+	help
+	  An architecture selects this option to indicate that the necessary
+	  hooks are provided to support the common memory system usage
+	  monitoring and control interfaces provided by the 'resctrl'
+	  filesystem (see RESCTRL_FS).
+
 config HAVE_ARCH_COMPILER_H
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 47ff2589fbce..dd6a4b19d5b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -496,8 +496,9 @@ config X86_MPPARSE
 config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
-	select KERNFS
-	select PROC_CPU_RESCTRL		if PROC_FS
+	depends on MISC_FILESYSTEMS
+	select ARCH_HAS_CPU_RESCTRL
+	select RESCTRL_FS
 	select RESCTRL_FS_PSEUDO_LOCK
 	help
 	  Enable x86 CPU resource control support.
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4b7e370e71ac..973fddf7e9a3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -7,10 +7,9 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
+#include <linux/resctrl.h>
 #include <linux/tick.h>
 
-#include <asm/resctrl.h>
-
 #define L3_QOS_CDP_ENABLE		0x01ULL
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b7662782ea59..9ae709ba5744 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -19,11 +19,11 @@
 
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/resctrl.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
-#include <asm/resctrl.h>
 
 #include "internal.h"
 
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 60ed5be212e1..3d3a0d952cbd 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -18,12 +18,12 @@
 #include <linux/mman.h>
 #include <linux/perf_event.h>
 #include <linux/pm_qos.h>
+#include <linux/resctrl.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_device_id.h>
-#include <asm/resctrl.h>
 #include <asm/perf_event.h>
 
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9696bdcc39f2..5a47e223830c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -18,6 +18,7 @@
 #include <linux/fs_parser.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
+#include <linux/resctrl.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
 #include <linux/sched/signal.h>
@@ -28,7 +29,6 @@
 
 #include <uapi/linux/magic.h>
 
-#include <asm/resctrl.h>
 #include "internal.h"
 
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
diff --git a/fs/Kconfig b/fs/Kconfig
index 949895cff872..2069e49e8099 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -335,6 +335,7 @@ source "fs/omfs/Kconfig"
 source "fs/hpfs/Kconfig"
 source "fs/qnx4/Kconfig"
 source "fs/qnx6/Kconfig"
+source "fs/resctrl/Kconfig"
 source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 61679fd587b7..619a102f81d7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
 obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
+obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
new file mode 100644
index 000000000000..3a3a75dad40d
--- /dev/null
+++ b/fs/resctrl/Kconfig
@@ -0,0 +1,37 @@
+config RESCTRL_FS
+	bool "CPU Resource Control Filesystem (resctrl)"
+	depends on ARCH_HAS_CPU_RESCTRL
+	select KERNFS
+	select PROC_CPU_RESCTRL if PROC_FS
+	help
+	  Some architectures provide hardware facilities to group tasks and
+	  monitor and control their usage of memory system resources such as
+	  caches and memory bandwidth.  Examples of such facilities include
+	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
+	  Platform Quality of Service (AMD QoS).
+
+	  If your system has the necessary support and you want to be able to
+	  assign tasks to groups and manipulate the associated resource
+	  monitors and controls from userspace, say Y here to get a mountable
+	  'resctrl' filesystem that lets you do just that.
+
+	  If nothing mounts or prods the 'resctrl' filesystem, resource
+	  controls and monitors are left in a quiescent, permissive state.
+
+	  On architectures where this can be disabled independently, it is
+	  safe to say N.
+
+	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
+
+config RESCTRL_FS_PSEUDO_LOCK
+	bool
+	help
+	  Software mechanism to pin data in a cache portion using
+	  micro-architecture specific knowledge.
+
+config RESCTRL_RMID_DEPENDS_ON_CLOSID
+	bool
+	help
+	  Enable by the architecture when the RMID values depend on the CLOSID.
+	  This causes the closid allocator to search for CLOSID with clean
+	  RMID.
diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
new file mode 100644
index 000000000000..e67f34d2236a
--- /dev/null
+++ b/fs/resctrl/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
+obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
+
+# To allow define_trace.h's recursive include:
+CFLAGS_monitor.o = -I$(src)
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/monitor_trace.h b/fs/resctrl/monitor_trace.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/pseudo_lock_trace.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 39303a0a398a..6b64bfa45673 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -9,6 +9,10 @@
 #include <linux/pid.h>
 #include <linux/resctrl_types.h>
 
+#ifdef CONFIG_ARCH_HAS_CPU_RESCTRL
+#include <asm/resctrl.h>
+#endif
+
 /* CLOSID, RMID value used by the default control group */
 #define RESCTRL_RESERVED_CLOSID		0
 #define RESCTRL_RESERVED_RMID		0
-- 
2.39.2


