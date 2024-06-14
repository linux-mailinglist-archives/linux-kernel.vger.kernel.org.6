Return-Path: <linux-kernel+bounces-215067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD7908E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805DB1C22702
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51F169AF8;
	Fri, 14 Jun 2024 15:01:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45450169AFD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377275; cv=none; b=R4dWFjoOiCrqJsO2px/+NIRlq8uGqiHbLPOOFkvvz7cM3P01SkdToi0dH+xzeCnOSf/oTyN6+HyTF8Wd2CSmzWWpCWnvg+8oEf2cnGHrifN77pOBReOYR9VNbhfKuRes9bBbVZ1l/HKHNTvqdlANkXKzfNx43QMj21K69N3y5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377275; c=relaxed/simple;
	bh=DogtMNNuGDoRVa4ZPRiH4Ilmpg5SKkCjqSLSfxc6uUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ia8Q8E9+aR8AQ/5pnRg7HJHeWJlZMieXiMl+bcZjd/1XPwJgzzMXd4SdNnYbPNSE0cgki582YJZHpiIld0/jB2PL92JIaY6f2eDWbamhAkV3GQ0cXEWKn3+AsIkE6KbhRpSvPHSEOl4VsBJRre2enpJtNIMbwKbQmYLsJY/4G6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADA3FFEC;
	Fri, 14 Jun 2024 08:01:36 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0717B3F5A1;
	Fri, 14 Jun 2024 08:01:08 -0700 (PDT)
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
Subject: [PATCH v3 01/38] x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no monitors
Date: Fri, 14 Jun 2024 14:59:56 +0000
Message-Id: <20240614150033.10454-2-james.morse@arm.com>
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

commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
searching closid_num_dirty_rmid") added logic that causes resctrl to
search for the CLOSID with the fewest dirty cache lines when creating a
new control group, if requested by the arch code. This depends on the
values read from the llc_occupancy counters. The logic is applicable to
architectures where the CLOSID effectively forms part of the monitoring
identifier and so do not allow complete freedom to choose an unused
monitoring identifier for a given CLOSID.

This support missed that some platforms may not have these counters.
This causes a NULL pointer dereference when creating a new control
group as the array was not allocated by dom_data_init().

As this feature isn't necessary on platforms that don't have cache
occupancy monitors, add this to the check that occurs when a new
control group is allocated.

The existing code is not selected by any upstream platform, it makes
no sense to backport this patch to stable.

Fixes: 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid")
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---
Changes since v1:
 * [Commit message only] Reword the first paragraph to make it clear
   that the issue being fixed wasn't directly associated with addition
   of a Kconfig option.  (Actually, the option is not in Kconfig yet,
   and gets added later in this series.)
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 02f213f1c51c..d02f4c97e40f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -149,7 +149,8 @@ static int closid_alloc(void)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
+	    is_llc_occupancy_enabled()) {
 		cleanest_closid = resctrl_find_cleanest_closid();
 		if (cleanest_closid < 0)
 			return cleanest_closid;
-- 
2.39.2


