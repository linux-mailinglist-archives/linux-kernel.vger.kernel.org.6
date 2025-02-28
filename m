Return-Path: <linux-kernel+bounces-539370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC298A4A37A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B431B189D3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365E27D770;
	Fri, 28 Feb 2025 20:02:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303D27D76F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772927; cv=none; b=r36JSIo1E7gZ36I7uEpDAHi+BFv9BiFo6Hd7jbSb2v4aRXIITokhCBd1sH1dHuNQlcAMiw/scMMQHv86laYWCFaWXK6LIHBvsm8R41aCDnjEXCYSyTNhBxuOpxZue/H1vlyzdFJdJL2smMcMYX4RzDdSbwFH1yl00g86D47T07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772927; c=relaxed/simple;
	bh=nIAel4IC+OBCi4t3kfh5h/LB+twJJu0epNgSFto9LAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFSp9OwOkGVQhLDhZRODMA2I9Wr377bLQOLlkzmeorN6ywGqmGNHE3uL1GxoFUMJlao3rP3Ki13vsnvJ9RtCLTpaBhwnPr7ghBQKJaI/jXDkzlYty+dRFMMIDL5E6G96RWf38UDXn6tRUbSMrWptH8HD7MdukdWZGSUhzvqRD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82A6A1A25;
	Fri, 28 Feb 2025 12:02:20 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A9E73F5A1;
	Fri, 28 Feb 2025 12:02:01 -0800 (PST)
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
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 35/49] x86/resctrl: Move is_mba_sc() out of core.c
Date: Fri, 28 Feb 2025 19:58:59 +0000
Message-Id: <20250228195913.24895-36-james.morse@arm.com>
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

is_mba_sc() is defined in core.c, but has no callers there. It does
not access any architecture private structures.

Move this to rdtgroup.c where the majority of callers are. This makes
the move of the filesystem code to /fs/ cleaner.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 15 ---------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 579a6caf76e5..93b51d522bc7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -166,21 +166,6 @@ static inline void cache_alloc_hsw_probe(void)
 	rdt_alloc_capable = true;
 }
 
-bool is_mba_sc(struct rdt_resource *r)
-{
-	if (!r)
-		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-
-	/*
-	 * The software controller support is only applicable to MBA resource.
-	 * Make sure to check for resource type.
-	 */
-	if (r->rid != RDT_RESOURCE_MBA)
-		return false;
-
-	return r->membw.mba_sc;
-}
-
 /*
  * rdt_get_mb_table() - get a mapping of bandwidth(b/w) percentage values
  * exposed to user interface and the h/w understandable delay values.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3145079eb043..aecd3fa734cd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1521,6 +1521,21 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	return size;
 }
 
+bool is_mba_sc(struct rdt_resource *r)
+{
+	if (!r)
+		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+
+	/*
+	 * The software controller support is only applicable to MBA resource.
+	 * Make sure to check for resource type.
+	 */
+	if (r->rid != RDT_RESOURCE_MBA)
+		return false;
+
+	return r->membw.mba_sc;
+}
+
 /*
  * rdtgroup_size_show - Display size in bytes of allocated regions
  *
-- 
2.39.5


