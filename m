Return-Path: <linux-kernel+bounces-219568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B190D4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EEC1C2148D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1766116B3B8;
	Tue, 18 Jun 2024 14:02:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116FA16DC13
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719335; cv=none; b=RDPuknXCN4v0JplYps0L/97I7HKa26Wu1co7wVvAR7V3MVHsy/B16CCF3AP+BVMEMdZDb8mrfheuGghmqgGGtUoJrkrNlSwzrDXOiIHkqr2kZUHKCCoG7i7Ha36g1a3a09qVVyu06v6ybeM1drMB9s8Jt0U/G42izZFh+feIEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719335; c=relaxed/simple;
	bh=SxOBJJqyZpXNmD01GyQFkSfg8fr2KyuHVVdyRSegJU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d2MMMXdZUcFhMbFHDRcVS9iL7Iscd2oNNGepHibzeUosR7qFJvOIbtCGzx6Wtxe9UlnZD+Dk3AeUhI4AAkMxBXGKK6gLYplzAU1GM6psDWKHfPY70w1ZW+9cl9WOZthIrwcEElrVc8RPnB5H8UtNwH1Zg1YfYiargU7OnBUcMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A05CCDA7;
	Tue, 18 Jun 2024 07:02:36 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 813213F6A8;
	Tue, 18 Jun 2024 07:02:08 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2] x86/resctrl: Don't try to free nonexistent RMIDs
Date: Tue, 18 Jun 2024 15:01:52 +0100
Message-Id: <20240618140152.83154-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by
index") adds logic to map individual monitoring groups into a
global index space used for tracking allocated RMIDs.

Attempts to free the default RMID are ignored in free_rmid(),
and this works fine on x86.

With arm64 MPAM, there is a latent bug here however: on platforms
with no monitors exposed through resctrl, each control group still
gets a different monitoring group ID as seen by the hardware, since
the CLOSID always forms part of the monitoring group ID.  This
means that when removing a control group, the code may try to free
this group's default monitoring group RMID for real.  If there are
no monitors however, the RMID tracking table rmid_ptrs[] would be a
waste of memory and is never allocated, leading to a splat when
free_rmid() tries to dereference the table.

One option would be to treat RMID 0 as special for every CLOSID,
but this would be ugly since we still want to do bookkeeping for
these monitoring group IDs when there are monitors present in the
hardware.

Instead, add a gating check of resctrl_arch_mon_capable() in
free_rmid(), and just do nothing if the hardware doesn't have
monitors.

This fix mirrors the gating checks already present in
mkdir_rdt_prepare_rmid_alloc() and elsewhere.

No functional change on x86.

Fixes: 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by index")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

---

Based on v6.10-rc3.

Tested on x86 (But so far for the monitors-present case.
Testing on Atom would be appreciated.)

Tested on arm64 for the no-monitors case.

Changes since v1:

 * Typo fixes and rewording in commit message; slurp maintainer tags.

(no code changes)
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2345e6836593..366f496ca3ce 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -519,7 +519,8 @@ void free_rmid(u32 closid, u32 rmid)
 	 * allows architectures that ignore the closid parameter to avoid an
 	 * unnecessary check.
 	 */
-	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+	if (!resctrl_arch_mon_capable() ||
+	    idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
 						RESCTRL_RESERVED_RMID))
 		return;
 

base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.34.1


