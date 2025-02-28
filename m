Return-Path: <linux-kernel+bounces-539363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242EA4A36C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E414C19C0248
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF14279335;
	Fri, 28 Feb 2025 20:01:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5327932A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772902; cv=none; b=p1uifela7Gd3gK3necj4OuMVkcOdYkMPM64tM5bMSX5/cyi7WpzaJRnSJR2QRSAAWuphnvuWP3VXJi0pTT2epUhGp/yhEpgaKFl1ekdk0aeA4FpFreeyjRvSIaSerxOQcDC3FOQblrTRMAtQrqbo3F6KoHQabJ7P5LyA1+guX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772902; c=relaxed/simple;
	bh=JW093qHbvRg22lWcZVjFoSM7nW7gbPU1cfiw8U9NZ68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/qTwO7CQpAXPRvjX6P5N83BdcC43o5c8vxn/3kyUiITUZf9CBAmVSsG9KlC7FG78bEK28+j1k4P2WtQhW5ByiihQ9wb3elR4iArjBBWzxCXyuJNtnu7/L8W/JTQBqKrL0j+C0MDXyFF5O6THG5wvFSV+MVyT3cTarYOYHWgzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5186F1A25;
	Fri, 28 Feb 2025 12:01:55 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17BFC3F5A1;
	Fri, 28 Feb 2025 12:01:36 -0800 (PST)
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
Subject: [PATCH v7 28/49] x86/resctrl: Handle throttle_mode for SMBA resources
Date: Fri, 28 Feb 2025 19:58:52 +0000
Message-Id: <20250228195913.24895-29-james.morse@arm.com>
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

Now that the visibility of throttle_mode is being managed by resctrl, it
should consider resources other than MBA that may have a throttle_mode.
SMBA is one such resource.

Extend thread_throttle_mode_init() to check SMBA for a throttle_mode.

Adding support for multiple resources means it is possible for a platform
with both MBA and SMBA, but an undefined throttle_mode on one of them
to make the file visible.

Add the 'undefined' case to rdt_thread_throttle_mode_show().

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v6:
 * Refer to thread_throttle_mode_init() in the commit message.

Changes since v5:
 * This change split out of the previous patch.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 +++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 58feba3feefd..5fc60c9ce28f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1188,10 +1188,19 @@ static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
 
-	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
+	switch (r->membw.throttle_mode) {
+	case THREAD_THROTTLE_PER_THREAD:
 		seq_puts(seq, "per-thread\n");
-	else
+		return 0;
+	case THREAD_THROTTLE_MAX:
 		seq_puts(seq, "max\n");
+		return 0;
+	case THREAD_THROTTLE_UNDEFINED:
+		seq_puts(seq, "undefined\n");
+		return 0;
+	}
+
+	WARN_ON_ONCE(1);
 
 	return 0;
 }
@@ -2066,12 +2075,24 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 
 static void thread_throttle_mode_init(void)
 {
-	struct rdt_resource *r_mba;
+	enum membw_throttle_mode throttle_mode = THREAD_THROTTLE_UNDEFINED;
+	struct rdt_resource *r_mba, *r_smba;
 
 	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-	if (r_mba->membw.throttle_mode != THREAD_THROTTLE_UNDEFINED)
-		resctrl_file_fflags_init("thread_throttle_mode",
-					 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
+	if (r_mba->alloc_capable &&
+	    r_mba->membw.throttle_mode != THREAD_THROTTLE_UNDEFINED)
+		throttle_mode = r_mba->membw.throttle_mode;
+
+	r_smba = resctrl_arch_get_resource(RDT_RESOURCE_SMBA);
+	if (r_smba->alloc_capable &&
+	    r_smba->membw.throttle_mode != THREAD_THROTTLE_UNDEFINED)
+		throttle_mode = r_smba->membw.throttle_mode;
+
+	if (throttle_mode == THREAD_THROTTLE_UNDEFINED)
+		return;
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 }
 
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
-- 
2.39.5


