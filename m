Return-Path: <linux-kernel+bounces-539380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A0A4A38F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99589189DEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D0A28136B;
	Fri, 28 Feb 2025 20:02:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5D230BFB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772966; cv=none; b=QMw3icZ4d2b2jITLtRQORIEl267D/5qN8dN9Qs4/BHYvDWdRlw2NWSJTf8wKyjc9ZG6DVpKzJU/JSxc+bRxLmxzLYGOXUfjeiI1+WZzUVlc7W6XUjODFpKEGYYBgpAXJDkr/AUhNKc8Km6TbDrsN4g3ejcI8oPnGqD/0D/4MBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772966; c=relaxed/simple;
	bh=ZMX5Zvy5YEto7Jx9ofhDbojgjf7BubhiR7oupZ9BQgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAIUIiXbZ8Wag9xjKGNny48lik2csctbSoqxaHkt7Jfx0WoFK5ufxkYO7V2EvFB4CVcyzhDY2LEKZ4Yo4HqS5FlcBYs77i3imkafuhU8B22uJ2VXLPKB43+FEzynxkjTuFhgWK1MxlUzzzCHAly52+75c0e7+ibfZqRg5u8N+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 088E719F0;
	Fri, 28 Feb 2025 12:03:00 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEE193F5A1;
	Fri, 28 Feb 2025 12:02:41 -0800 (PST)
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
Subject: [PATCH v7 46/49] x86,fs/resctrl: Remove duplicated trace header files
Date: Fri, 28 Feb 2025 19:59:10 +0000
Message-Id: <20250228195913.24895-47-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
References: <20250228195913.24895-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The copy-pasting python script harmlessly creates some empty trace
point header files. Remove them.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/monitor.c       |  4 ----
 arch/x86/kernel/cpu/resctrl/monitor_trace.h | 17 -----------------
 fs/resctrl/pseudo_lock.c                    |  4 ----
 fs/resctrl/pseudo_lock_trace.h              | 17 -----------------
 4 files changed, 42 deletions(-)
 delete mode 100644 arch/x86/kernel/cpu/resctrl/monitor_trace.h
 delete mode 100644 fs/resctrl/pseudo_lock_trace.h

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1809e3fe6ef3..800e52845b1d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -27,10 +27,6 @@
 
 #include "internal.h"
 
-#define CREATE_TRACE_POINTS
-
-#include "monitor_trace.h"
-
 /*
  * Global boolean for rdt_monitor which is true if any
  * resource monitoring is enabled.
diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
deleted file mode 100644
index b5a142dd0f0e..000000000000
--- a/arch/x86/kernel/cpu/resctrl/monitor_trace.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM resctrl
-
-#if !defined(_FS_RESCTRL_MONITOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _FS_RESCTRL_MONITOR_TRACE_H
-
-#include <linux/tracepoint.h>
-
-#endif /* _FS_RESCTRL_MONITOR_TRACE_H */
-
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
-
-#define TRACE_INCLUDE_FILE monitor_trace
-
-#include <trace/define_trace.h>
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 03243c2ad764..d26cc1a2a84a 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -30,10 +30,6 @@
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
 #include "internal.h"
 
-#define CREATE_TRACE_POINTS
-
-#include "pseudo_lock_trace.h"
-
 /*
  * Major number assigned to and shared by all devices exposing
  * pseudo-locked regions.
diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/pseudo_lock_trace.h
deleted file mode 100644
index 7a6a1983953a..000000000000
--- a/fs/resctrl/pseudo_lock_trace.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM resctrl
-
-#if !defined(_X86_RESCTRL_PSEUDO_LOCK_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _X86_RESCTRL_PSEUDO_LOCK_TRACE_H
-
-#include <linux/tracepoint.h>
-
-#endif /* _X86_RESCTRL_PSEUDO_LOCK_TRACE_H */
-
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
-
-#define TRACE_INCLUDE_FILE pseudo_lock_trace
-
-#include <trace/define_trace.h>
-- 
2.39.5


