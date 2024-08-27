Return-Path: <linux-kernel+bounces-302607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B249600D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCEF1F22D48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993E13CABC;
	Tue, 27 Aug 2024 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IllUf02X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7A374CB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735382; cv=none; b=sxPmGcy3x7wUviW0kQnMkK8Uwu0UVQe4bC/+CCV7ixPsGno2tBH3OBo7I+ygp7ByIs/owxe/01d3vZ/CMewFLYIhrvbbyME/BaTctTn3B83xgXNPJonrJZxk2B4O9Bo+VehR7CfUCg15sluJnGdy49uuTHV3L93ghNIj6Dl5NKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735382; c=relaxed/simple;
	bh=77vrI8QF6pQcPHd+P8e88yX25IUCKQzDSU9AalQ85S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=c9FUP9HYOkiDP4Bf0g9C9PmcSepNLNreQ9EpDlHrCc6zghxshyagVb6ViEN2cv9p/MAV14Y8onmrSysyl2gF/yTBou28jt8ju11E8PKNkQUghESmKdPF10d4MgvT1dC8lDP3ZJtwXFv8jJllHDki22BvQ3enHacPMfY9wCQwEIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IllUf02X; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724735381; x=1756271381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=77vrI8QF6pQcPHd+P8e88yX25IUCKQzDSU9AalQ85S4=;
  b=IllUf02XGrZK8vWh+gfYwlziGn11S2f8imO+DU8q4gDNI5O8ib+mcLwh
   8MNwZ1kEclB2q7+lMn3WtLjNdnj8pmk0XxMWCocwwQxeTTaqYnR5cNv19
   +M96IurJKVVAwpAC/tMD7jLhMN2ufM8QFc8kJzrOn1XUBZmtuPW0pTYoK
   pD3ckrZ8VZizXE4gU6jbv5iKfVfVwktTkrMSy9UZXFXrIVexMGZvdm3XJ
   TmRtp4yMxLlxKtfWEANitJNq0R7ewfq0UQaOguPo1ZDhB2ozixz5/x1CO
   0Ilh1DGcnN4SQ4fO1K4RYvoQUvZSDgTpyyA+2jrEwvxk2VUC9+OkwvtdP
   g==;
X-CSE-ConnectionGUID: ZSqB5L9rRmW5mCWAnr3Lvg==
X-CSE-MsgGUID: eFXvJG46R12qeigclDjYLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="13230476"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="13230476"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 22:09:38 -0700
X-CSE-ConnectionGUID: Xns2i46TTq2or46uFithiw==
X-CSE-MsgGUID: rBqynKrUT6uu9nrS+VFhhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62703859"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP; 26 Aug 2024 22:09:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] cacheinfo: Allocate memory for memory if not done from the primary CPU
Date: Mon, 26 Aug 2024 22:16:33 -0700
Message-Id: <20240827051635.9114-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
adds functionality that architectures can use to optionally allocate and
build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
arch specific early level initializer") lets secondary CPUs correct (and
reallocate memory) cacheinfo data if needed.

If the early build functionality is not used and cacheinfo does not need
correction, memory for cacheinfo is never allocated. x86 does not use the
early build functionality. Consequently, during the cacheinfo CPU hotplug
callback, last_level_cache_is_valid() attempts to dereference a NULL
pointer:

     BUG: kernel NULL pointer dereference, address: 0000000000000100
     #PF: supervisor read access in kernel mode
     #PF: error_code(0x0000) - not present page
     PGD 0 P4D 0
     Oops: 0000 [#1] PREEPMT SMP NOPTI
     CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
     RIP: 0010: last_level_cache_is_valid+0x95/0xe0a

Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
not done earlier.

Reviewed-by: Radu Rendec <rrendec@redhat.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Andreas Herrmann <aherrmann@suse.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Cc: Radu Rendec <rrendec@redhat.com>
Cc: Pierre Gondois <Pierre.Gondois@arm.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org # 6.3+
---
The motivation for commit 5944ce092b97 was to prevent a BUG splat in
PREEMPT_RT kernels during memory allocation. This splat is not observed on
x86 because the memory allocation for cacheinfo happens in
detect_cache_attributes() from the cacheinfo CPU hotplug callback.

The dereference of a NULL pointer is not observed today because
cache_leaves(cpu) is zero until after init_cache_level() is called (also
during the CPU hotplug callback). A subsequent changeset will set the
number of cache leaves earlier and the NULL-pointer dereference will be
observed.
---
Changes since v4:
 * None

Changes since v3:
 * Added Reviewed-by tag from Radu and Sudeep. Thanks!

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 drivers/base/cacheinfo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 77f2e0f91589..0332148691f9 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -554,7 +554,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
 	 */
 	ci_cacheinfo(cpu)->early_ci_levels = false;
 
-	if (cache_leaves(cpu) <= early_leaves)
+	/*
+	 * Some architectures (e.g., x86) do not use early initialization.
+	 * Allocate memory now in such case.
+	 */
+	if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
 		return 0;
 
 	kfree(per_cpu_cacheinfo(cpu));
-- 
2.34.1


