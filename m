Return-Path: <linux-kernel+bounces-570518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F6A6B1B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560E64881B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E58B22AE6D;
	Thu, 20 Mar 2025 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWXDP28R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCA21D018
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514077; cv=none; b=mEWYjw0xJqhVkcT8/POkcAL7g/m6UjIjjGSYycelIU8/gjw8AZbGSpBRZ6T4kVgYjH+4lsECbplgy5ycOAff/MLNcuLhcg2YVCrFjX+dUsaSg/+z9vEbHQJ26OQW2yxt5cUIcqtDADaqAl+Dz4i3rE+VdWxbVEDa7p+luUhHoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514077; c=relaxed/simple;
	bh=S25TJROssnqp2lMFYbL4/rzVWT/EIZe1MtkkxmZ/usQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZLZ/++HdvEOze7trkFRmCeAjCc1LFLYcG6aw6ybPlxQSU7zAieubFPMnAYBdouncqVgOaFYrzyhFSb935nhXiT4cdAWUiFn4Fj/K7lyvnYjtOUQNnUYZ94RQuxrP+rxisyGeC0NUwbwNKcqdRXLDduNqYGhU4qleNoYrMF61r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWXDP28R; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514074; x=1774050074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S25TJROssnqp2lMFYbL4/rzVWT/EIZe1MtkkxmZ/usQ=;
  b=ZWXDP28RZ65GN6+Gm4FzKaaJ4saE4t1e+Lfj6t/uyP9PsTQpWhF5Jjbv
   32TPboOGgjFEjrlgnwJhHagq+Sjuu2/N8PlskCnpaNfVS5PVbaOxqi+v5
   BaOgNf69R9XlU1H/DIrRj/hxVnU/tqSnzRMNQHrG+GfIfvm83/8QehDM2
   wo658yG3mYZTFDx1zUj8Vo1DEUEu5IvSz+yh/uWDJudA3jDeTjfUgbGlM
   nAOAdad6DgDYyQtB9L6ez//x7H54NB04tsCt2GAeKzkS8AgFSpethYImr
   AHBA7pbZsWps6TDewhggRERbErb+kmb6c6CRaclobU+3Tx9vSS14GAFci
   w==;
X-CSE-ConnectionGUID: zBDs6mXeQkO8jdJtTw5B8w==
X-CSE-MsgGUID: iV/JvQasRA2btureVPE0NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54439132"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54439132"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:41:14 -0700
X-CSE-ConnectionGUID: dDYs4R5RROyRWYCc4qHVew==
X-CSE-MsgGUID: qMx5O+BWSracB8OjAOaKhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123418008"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2025 16:41:14 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 1/6] x86/microcode: Introduce staging step to reduce late-loading time
Date: Thu, 20 Mar 2025 16:40:53 -0700
Message-ID: <20250320234104.8288-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234104.8288-1-chang.seok.bae@intel.com>
References: <20250320234104.8288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As microcode patch sizes continue to grow, late-loading latency spikes
can lead to timeouts and disruptions in running workloads. This trend of
increasing patch sizes is expected to continue, so a foundational
solution is needed to address the issue.

To mitigate the problem, a new staging feature is introduced. This option
processes most of the microcode update (excluding activation) on a
non-critical path, allowing CPUs to remain operational during the
majority of the update. By offloading work from the critical path,
staging can significantly reduces latency spikes.

Integrate staging as a preparatory step in late-loading. Introduce a new
callback for staging, which is invoked at the beginning of
load_late_stop_cpus(), before CPUs enter the rendezvous phase.

Staging follows an opportunistic model:

  *  If successful, it reduces CPU rendezvous time
  *  Even though it fails, the process falls back to the legacy path to
     finish the loading process but with potentially higher latency.

Extend struct microcode_ops to incorporate staging properties, which will
be implemented in the vendor code separately.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V1 -> V2:
- Move invocation inside of load_late_stop_cpus() (Boris)
- Add more note about staging (Dave)

RFC-V1 -> V1:
- Rename the function name to the do_something() style (Boris).

Note:

Now the invocation is placed as part of the late-loading core function
following Boris' comment on the last posting [1], which I think can keep
the main late-loading logic simple from load_late_locked().

There was some brief discussion about the necessity of enforcing staging
as mandatory [2]. But it was not clearly justified yet, so I thought it
still makes sense to exclude such policy discussions out of this series.

[1] https://lore.kernel.org/lkml/20250218113634.GGZ7RwwkrrXADX0eRo@fat_crate.local/
[2] https://lore.kernel.org/lkml/526df712-6091-4b04-97d5-9007789dc750@intel.com/
---
 arch/x86/kernel/cpu/microcode/core.c     | 11 +++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b3658d11e7b6..c4aff44a7ffc 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -541,6 +541,17 @@ static int load_late_stop_cpus(bool is_safe)
 		pr_err("You should switch to early loading, if possible.\n");
 	}
 
+	/*
+	 * Pre-load the microcode image into a staging device. This
+	 * process is preemptible and does not require stopping CPUs.
+	 * Successful staging simplifies the subsequent late-loading
+	 * process, reducing rendezvous time.
+	 *
+	 * Even if the transfer fails, the update will proceed as usual.
+	 */
+	if (microcode_ops->use_staging)
+		microcode_ops->stage_microcode();
+
 	atomic_set(&late_cpus_in, num_online_cpus());
 	atomic_set(&offline_in_nmi, 0);
 	loops_per_usec = loops_per_jiffy / (TICK_NSEC / 1000);
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 5df621752fef..4b983b4cddbd 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,10 +31,12 @@ struct microcode_ops {
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
 	enum ucode_state	(*apply_microcode)(int cpu);
+	void			(*stage_microcode)(void);
 	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
 	void			(*finalize_late_load)(int result);
 	unsigned int		nmi_safe	: 1,
-				use_nmi		: 1;
+				use_nmi		: 1,
+				use_staging	: 1;
 };
 
 struct early_load_data {
-- 
2.45.2


