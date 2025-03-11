Return-Path: <linux-kernel+bounces-556757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3FA5CE20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885507AAC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE948266B4F;
	Tue, 11 Mar 2025 18:41:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C1E266588
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718511; cv=none; b=SKMh/KSlTp46LDbZnR3hMr+G476MaG1jjC5u3Ex6dqpQF/xg6nMNuoaJnk9115opx6DgirhidzblAO1vsQXv7URhFCDrdt0sUcj9Anu97tqNSgrlEFdgHW45hBqja2n/G+npvfz/hCywpxu0SQF8SitZkhII0oTH5ivAWAkkPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718511; c=relaxed/simple;
	bh=hSk8lB0mxQLdff/yB0fkodC5DIeCq8cy48atAAOobwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZ9NTZ8jAUhusXsvDWwOlqAJCwVCdfPDX8iCJLAdB5Home+OCo1YrOfT5sm2BIMFq1RU9O8P6qCmZk0cEmshWDkHLHRkGSkgOn8T9Adu1d8+Ub+cZ3hc4Die2Em615IbKGEoEBv4c/F2mRuJLSkY2oHr7Elr4IHCIfKuQ2TmCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EF881713;
	Tue, 11 Mar 2025 11:42:00 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B59233F694;
	Tue, 11 Mar 2025 11:41:45 -0700 (PDT)
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
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v8:for-boris 27/30] x86/resctrl: Move RFTYPE flags to be managed by resctrl
Date: Tue, 11 Mar 2025 18:37:12 +0000
Message-Id: <20250311183715.16445-28-james.morse@arm.com>
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

resctrl_file_fflags_init() is called from the architecture specific code
to make the 'thread_throttle_mode' file visible. The architecture specific
code has already set the membw.throttle_mode in the rdt_resource.

This forces the RFTYPE flags used by resctrl to be exposed to the
architecture specific code.

This doesn't need to be specific to the architecture, the throttle_mode
can be used by resctrl to determine if the 'thread_throttle_mode' file
should be visible. This allows the RFTYPE flags to be private to resctrl.

Add thread_throttle_mode_init(), and use it to call
resctrl_file_fflags_init() from resctrl_init(). This avoids
publishing an extra function between the architecture and filesystem
code.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v6:
 * Refer to resctrl_init() in the commit message.
 * Remove a space.

Changes since v5:
 * Added checking for SMBA.
 * Added printing of undefined to rdt_thread_throttle_mode_show().
 * Major juggling around commit 2937f9c361f7 ("x86/resctrl: Introduce resctrl_file_fflags_init() to initialize fflags")
 * Dropped tags, split patch
---
 arch/x86/kernel/cpu/resctrl/core.c     |  3 ---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b9b74f53b8ee..e590dd347fa7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -227,9 +227,6 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
 
-	resctrl_file_fflags_init("thread_throttle_mode",
-				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
-
 	r->alloc_capable = true;
 
 	return true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e59271515a46..58feba3feefd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2064,6 +2064,16 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
+static void thread_throttle_mode_init(void)
+{
+	struct rdt_resource *r_mba;
+
+	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+	if (r_mba->membw.throttle_mode != THREAD_THROTTLE_UNDEFINED)
+		resctrl_file_fflags_init("thread_throttle_mode",
+					 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
+}
+
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
@@ -4277,6 +4287,8 @@ int __init resctrl_init(void)
 
 	rdtgroup_setup_default();
 
+	thread_throttle_mode_init();
+
 	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;
-- 
2.39.5


