Return-Path: <linux-kernel+bounces-215104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488B2908E35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE3B28C994
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883E16B73A;
	Fri, 14 Jun 2024 15:03:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C831AED4A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377391; cv=none; b=qijghPjpZeAGf+AgqGVUe7MmDaRqeqkrDdSJ71ucx0mYOjFiEYMSH5p0J09xf8qJTI9W/8awmSfgNDAS3SfnaK0kakmJu1Kvy0kYNhrKXxJdxsf9sz4wP2YcLdTc1AhShZeS9Bgmaenrs1g7tnBKYM8l1U/2WDKR2qfbvMjAadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377391; c=relaxed/simple;
	bh=K5JaMyZRH36SiFbunPVulUnBXNUXUHjn03nm5LCoJS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mml27sMJ8gJ+fWxluTZjVzMCG4vn3po/wupyUAD+QPdsEclAgBgjeQBvZt16lK0++wrOtIL6TWXZrSrRIWo9loBThpEQ+SvT6FrdQ1e61WXs3QGAsg5xYpiL7E8our3yJ4veiXbLzLOtOMPuaAfMQRPepBy6Je61h0fKKvIHKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4F1C1C0A;
	Fri, 14 Jun 2024 08:03:33 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 045003F8A4;
	Fri, 14 Jun 2024 08:03:05 -0700 (PDT)
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
Subject: [PATCH v3 36/38] fs/resctrl: Add boiler plate for external resctrl code
Date: Fri, 14 Jun 2024 15:00:31 +0000
Message-Id: <20240614150033.10454-37-james.morse@arm.com>
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

Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
for the common parts of the resctrl interface and make X86_CPU_RESCTRL
depend on this.

Adding an include of asm/resctrl.h to linux/resctrl.h allows some
of the files to switch over to using this header instead.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
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
 arch/x86/Kconfig                          |  5 ++--
 arch/x86/kernel/cpu/resctrl/internal.h    |  3 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 fs/Kconfig                                |  1 +
 fs/Makefile                               |  1 +
 fs/resctrl/Kconfig                        | 36 +++++++++++++++++++++++
 fs/resctrl/Makefile                       |  3 ++
 fs/resctrl/ctrlmondata.c                  |  0
 fs/resctrl/internal.h                     |  0
 fs/resctrl/monitor.c                      |  0
 fs/resctrl/pseudo_lock.c                  |  0
 fs/resctrl/rdtgroup.c                     |  0
 fs/resctrl/trace.h                        |  0
 include/linux/resctrl.h                   |  4 +++
 18 files changed, 61 insertions(+), 7 deletions(-)
 create mode 100644 fs/resctrl/Kconfig
 create mode 100644 fs/resctrl/Makefile
 create mode 100644 fs/resctrl/ctrlmondata.c
 create mode 100644 fs/resctrl/internal.h
 create mode 100644 fs/resctrl/monitor.c
 create mode 100644 fs/resctrl/pseudo_lock.c
 create mode 100644 fs/resctrl/rdtgroup.c
 create mode 100644 fs/resctrl/trace.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 441b039068d8..64195c298baf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18859,6 +18859,7 @@ S:	Supported
 F:	Documentation/arch/x86/resctrl*
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
+F:	fs/resctrl/
 F:	include/linux/resctrl*.h
 F:	tools/testing/selftests/resctrl/
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..4156604dd926 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1431,6 +1431,14 @@ config STRICT_MODULE_RWX
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
index 446984277b45..e4dd4097e10f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -490,8 +490,9 @@ config X86_MPPARSE
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
index bad103f20663..6f6785a31efe 100644
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
index 145bd05eafa5..a1539edb25fa 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -17,11 +17,11 @@
 
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/resctrl.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
-#include <asm/resctrl.h>
 
 #include "internal.h"
 #include "trace.h"
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index c096fa106b80..97e901009c91 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -19,12 +19,12 @@
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
index 969c454b67f1..c7cbd30ac0f2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -19,6 +19,7 @@
 #include <linux/fs_parser.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
+#include <linux/resctrl.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
 #include <linux/sched/signal.h>
@@ -29,7 +30,6 @@
 
 #include <uapi/linux/magic.h>
 
-#include <asm/resctrl.h>
 #include "internal.h"
 
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..d8a36383b6dc 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -331,6 +331,7 @@ source "fs/omfs/Kconfig"
 source "fs/hpfs/Kconfig"
 source "fs/qnx4/Kconfig"
 source "fs/qnx6/Kconfig"
+source "fs/resctrl/Kconfig"
 source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 6ecc9b0a53f2..da6e2d028722 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
new file mode 100644
index 000000000000..a5fbda54d32f
--- /dev/null
+++ b/fs/resctrl/Kconfig
@@ -0,0 +1,36 @@
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
+	  If unsure, it is safe to say N.
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
index 000000000000..ee8c4463317a
--- /dev/null
+++ b/fs/resctrl/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
+obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/fs/resctrl/trace.h b/fs/resctrl/trace.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 31ae6d9a224e..268e17276412 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -8,6 +8,10 @@
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


