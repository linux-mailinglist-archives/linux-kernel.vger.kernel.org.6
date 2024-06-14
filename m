Return-Path: <linux-kernel+bounces-215093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB72908E29
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE04B22CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E85F1AC233;
	Fri, 14 Jun 2024 15:02:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F121ABCDD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377357; cv=none; b=LI08VoodzMG/Wb7B9BWsMInEzLTL0ygBCm1y/GYDOvSmUUpYG/Um8qxQc3b0bIWSL699oT9/jlqDo1vt15wCpnI3dGxEaNr93tocIAANpXHCv9Iwwm2SWOlqGZxM5INrzu9oEp8jkV7yiR1gB/o7z+ZOGo9oObKmhltXn2HM8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377357; c=relaxed/simple;
	bh=omziNzHijkOyj01fYhlhEwiTI8o/1ez5Ryf18lfS+wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E44N02EfORNTXcyrSrrVvobRWMhF/2YVBjM212IibkmLf4uGq1pK56ipxnbbNZSTgSg2fxCFqwzHV2qafJ3cyTKLXGW6vP22Bma8NFm3k/9/k4BPXqA9Vy4bCi7wlis5tLpcxjOI98HgPxsAY6Ua9ad34PphDk9IwG+UubBc9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8206E1BB0;
	Fri, 14 Jun 2024 08:03:00 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D04CB3F5A1;
	Fri, 14 Jun 2024 08:02:32 -0700 (PDT)
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
Subject: [PATCH v3 26/38] x86/resctrl: Move thread_throttle_mode_init() to be managed by resctrl
Date: Fri, 14 Jun 2024 15:00:21 +0000
Message-Id: <20240614150033.10454-27-james.morse@arm.com>
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

thread_throttle_mode_init() is called from the architecture specific code
to make the 'thread_throttle_mode' file visible. The architecture specific
code has already set the membw.throttle_mode in the rdt_resource.

This doesn't need to be specific to the architecture, the throttle_mode
can be used by resctrl to determine if the 'thread_throttle_mode' file
should be visible.

Call thread_throttle_mode_init() from resctrl_setup(), check the
membw.throttle_mode on the MBA resource. This avoids publishing an
extra function between the architecture and filesystem code.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 1 -
 arch/x86/kernel/cpu/resctrl/internal.h | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 9 ++++++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 252201eefdd0..d932e03f129f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -222,7 +222,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 38d3aab9b684..fc837d144894 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -480,7 +480,6 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init thread_throttle_mode_init(void);
 void mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7957edcfc97d..8066d0e51a73 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2055,10 +2055,15 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-void __init thread_throttle_mode_init(void)
+static void __init thread_throttle_mode_init(void)
 {
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	struct rftype *rft;
 
+	if (!r->alloc_capable ||
+	    r->membw.throttle_mode == THREAD_THROTTLE_UNDEFINED)
+		return;
+
 	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
 	if (!rft)
 		return;
@@ -4200,6 +4205,8 @@ int __init resctrl_init(void)
 
 	rdtgroup_setup_default();
 
+	thread_throttle_mode_init();
+
 	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;
-- 
2.39.2


