Return-Path: <linux-kernel+bounces-207573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52F901907
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 02:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD61F21BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 00:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B01B3FF1;
	Mon, 10 Jun 2024 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWiVSvC3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF715CE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717979978; cv=none; b=ZuhIY1LbrAUAhX51ODTNkEeoUg1NbTCPCZoADIK4WrRhMZKN9rMHefRtQuYAlharYaklITNo3cypUvkkh6hkyqloa0IJYnqoPK7MZ+3QfSicoF2JSUASpVwZ4cY7uG+R2epnyUg+p7c4AcPPGx7izJWq3qctx2Hii/ea3bwoYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717979978; c=relaxed/simple;
	bh=KrgBmWQXmMI5ZHOl1JgRcgR4CFvwj+D+f1AyQNCY1ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WERo0o21nELDtUu1EYTsKCwPv/IGJ0p4ju4TBgJBEXzPgHmDbZiOs04Xx6vNOoHvdPx1MUJCdlc36MOhNPvFWBADSpXcD/x7ec6OOogz2yhesxtH411/+LPx0+gMAt4NuCGDgNlK27Gzmx3rtcCF1BTRWz6GOZNGBo1O1x0peBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWiVSvC3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717979977; x=1749515977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KrgBmWQXmMI5ZHOl1JgRcgR4CFvwj+D+f1AyQNCY1ys=;
  b=iWiVSvC3CMWTGMRwAjtL/LqoEd8NkY6injUh9I7N8j6hD0gatf1C7/0n
   hSb8Jfd3JzVyL1rqsy4B0seExMTaH5gjceBa1myTCfSTU/MhEFJPxdE5X
   /YKW3dPAPMovU86S1NNpH8U3cLNHtAKETkujntclYwxPeeZ6iNG6OPo0s
   9c8BtGb7Tw93FePv65el27Oe8+R36WuCoItCaE9haxSgpnlr4+lvyZ2ej
   LOmGCNS4fuzYXPua/BhSSbM8ks57DTu5b54qWUfr7+yledjKi/SjNjOEG
   o+3ImQbHGFvn6Qo2lXhTX2fQ7Vvne/vuJoxPvP+h96aC2RZFagzg7G/er
   g==;
X-CSE-ConnectionGUID: QQpEXxpXR+SBMxA5/MSHKA==
X-CSE-MsgGUID: YkX/8Cm8Qr2HEQ1hmD5wag==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="37154962"
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="37154962"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 17:39:35 -0700
X-CSE-ConnectionGUID: JaP/M0FfTe+VNnklssA+cw==
X-CSE-MsgGUID: BHrBrcuFTY6GWYbyn2sMVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="38829877"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 17:39:36 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 1/4] cpu: Move CPU hotplug function declarations into their own header
Date: Sun,  9 Jun 2024 17:39:24 -0700
Message-ID: <20240610003927.341707-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610003927.341707-1-tony.luck@intel.com>
References: <20240610003927.341707-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid upcoming #include hell when <linux/cachinfo.h> wants to use
lockdep_assert_cpus_held() and creates a #include loop that would
break the build for arch/riscv.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/cpu.h       | 33 +--------------------------
 include/linux/cpuhplock.h | 47 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/cpuhplock.h

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 861c3bfc5f17..a8926d0a28cd 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -18,6 +18,7 @@
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cpuhplock.h>
 #include <linux/cpu_smt.h>
 
 struct device;
@@ -132,38 +133,6 @@ static inline int add_cpu(unsigned int cpu) { return 0;}
 #endif /* CONFIG_SMP */
 extern const struct bus_type cpu_subsys;
 
-extern int lockdep_is_cpus_held(void);
-
-#ifdef CONFIG_HOTPLUG_CPU
-extern void cpus_write_lock(void);
-extern void cpus_write_unlock(void);
-extern void cpus_read_lock(void);
-extern void cpus_read_unlock(void);
-extern int  cpus_read_trylock(void);
-extern void lockdep_assert_cpus_held(void);
-extern void cpu_hotplug_disable(void);
-extern void cpu_hotplug_enable(void);
-void clear_tasks_mm_cpumask(int cpu);
-int remove_cpu(unsigned int cpu);
-int cpu_device_down(struct device *dev);
-extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
-
-#else /* CONFIG_HOTPLUG_CPU */
-
-static inline void cpus_write_lock(void) { }
-static inline void cpus_write_unlock(void) { }
-static inline void cpus_read_lock(void) { }
-static inline void cpus_read_unlock(void) { }
-static inline int  cpus_read_trylock(void) { return true; }
-static inline void lockdep_assert_cpus_held(void) { }
-static inline void cpu_hotplug_disable(void) { }
-static inline void cpu_hotplug_enable(void) { }
-static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
-static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
-#endif	/* !CONFIG_HOTPLUG_CPU */
-
-DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
-
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
 extern void thaw_secondary_cpus(void);
diff --git a/include/linux/cpuhplock.h b/include/linux/cpuhplock.h
new file mode 100644
index 000000000000..d42d2434dab6
--- /dev/null
+++ b/include/linux/cpuhplock.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * include/linux/cpuhplock.h - cpu hotplug locking
+ *
+ * Locking functions for CPU hot plug.
+ */
+#ifndef _LINUX_CPUHPLOCK_H_
+#define _LINUX_CPUHPLOCK_H_
+
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+
+struct device;
+
+extern int lockdep_is_cpus_held(void);
+
+#ifdef CONFIG_HOTPLUG_CPU
+extern void cpus_write_lock(void);
+extern void cpus_write_unlock(void);
+extern void cpus_read_lock(void);
+extern void cpus_read_unlock(void);
+extern int  cpus_read_trylock(void);
+extern void lockdep_assert_cpus_held(void);
+extern void cpu_hotplug_disable(void);
+extern void cpu_hotplug_enable(void);
+void clear_tasks_mm_cpumask(int cpu);
+int remove_cpu(unsigned int cpu);
+int cpu_device_down(struct device *dev);
+extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
+
+#else /* CONFIG_HOTPLUG_CPU */
+
+static inline void cpus_write_lock(void) { }
+static inline void cpus_write_unlock(void) { }
+static inline void cpus_read_lock(void) { }
+static inline void cpus_read_unlock(void) { }
+static inline int  cpus_read_trylock(void) { return true; }
+static inline void lockdep_assert_cpus_held(void) { }
+static inline void cpu_hotplug_disable(void) { }
+static inline void cpu_hotplug_enable(void) { }
+static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
+static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
+#endif	/* !CONFIG_HOTPLUG_CPU */
+
+DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
+
+#endif /* _LINUX_CPUHPLOCK_H_ */
-- 
2.45.0


