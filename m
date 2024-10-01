Return-Path: <linux-kernel+bounces-346320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8698C31E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052B81F246E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F31CCB39;
	Tue,  1 Oct 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kF74BxWc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59E1CB510
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799061; cv=none; b=CvZkrlUVKTTveoIoy98dT9VjZ9qXgzfFS9LouOrgsPkAIakZEbpqZ5eZOuRDQBShEeI5wdKw61uTnUt1iG0vuFALO/wpxyvZExINI++9L64SAtVAfP0oQP9Vx4JKRwRwaLDRooKT7IadQFo/Yq80DwZOqlOgKC9NNbAH5bRR35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799061; c=relaxed/simple;
	bh=ET7LCZjp+V8sCzKXv4bUaKBKMigRm+R+exMxJAqpbpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srXrYa9tGDPTqRhdGq7BAje609O3P9w535JlgQvMxr+tfSNzQCrJgdmCtgT/0t1dhghbSm2epoUb3z88nMdHv3Q3foxtEB2cV9WKrQDQf/Ux3yJj/znDroE3+/zn6Ce9vbWpaOyQbsIkoLEkuiW4MvaI6MPAe+i0vRUCH3w+9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kF74BxWc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727799060; x=1759335060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ET7LCZjp+V8sCzKXv4bUaKBKMigRm+R+exMxJAqpbpk=;
  b=kF74BxWcGg8jQqdfawueK18noreFEhDyR6gof9Xb2lCclsb4xE0KDHKM
   IpCjJ6XwH2R3QfgCcYYayhwmB390ap1zmLLjw1jAi1BvNUV/OnbAvAJnR
   OkUFUU5Dc/V+jNmeo+IInyCOIrKIDZI1hzx/FCi/djVyPTcmvs2HVJ7s2
   2pav684QFtbTNq+rgUxuyT91ErJFg/CURrUI4CYtopeibYdC1wMr2xHCy
   jMTL0N1b9BMlaQ9WXXF8WoCPqq1DatMhE2/Mz+F+FII2ca0PzpscZKCd0
   HUROfaqS4vNRO0I/RlRIN9YJSMUyKiH1iOUkZZMjU+iqyVKjR4sgPdBXh
   Q==;
X-CSE-ConnectionGUID: wRNcPDZnR9qyU88/N9nbxA==
X-CSE-MsgGUID: KeWzqHmDRgKRhErTZ74YeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37539377"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37539377"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:10:59 -0700
X-CSE-ConnectionGUID: CxthUq3XSveLt2iQHoO5Pg==
X-CSE-MsgGUID: r8cJ5EpzTQCZSNbT+o+4ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78585980"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.136.21])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 09:11:00 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC 2/7] x86/microcode: Introduce staging option to reduce late-loading latency
Date: Tue,  1 Oct 2024 09:10:37 -0700
Message-Id: <20241001161042.465584-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001161042.465584-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As microcode patch sizes continue to grow, the latency during
late-loading can spike, leading to timeouts and interruptions in running
workloads. This trend of increasing patch sizes is expected to continue,
so a foundational solution is needed to address the issue.

To mitigate the problem, a new staging feature is introduced. This option
processes most of the microcode update (excluding activation) on a
non-critical path, allowing CPUs to remain operational during the
majority of the update. By moving most of the work off the critical path,
the latency spike can be significantly reduced.

Integrate the staging process as an additional step in the late-loading
flow. Introduce a new callback for staging, which is invoked after the
microcode patch image is prepared but before entering the CPU rendezvous
for triggering the update.

Staging follows an opportunistic model: it is attempted when available.
If successful, it reduces CPU rendezvous time; if not, the process falls
back to the legacy loading, potentially exposing the system to higher
latency.

Extend struct microcode_ops to incorporate staging properties, which will
be updated in the vendor code from subsequent patches.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Whether staging should be mandatory is a policy decision that is beyond
the scope of this patch at the moment. For now, the focus is on
establishing a basic flow, with the intention of attracting focused
reviews, while deferring the discussion on staging policy later.

In terms of the flow, an alternative approach could be to integrate
staging as part of microcode preparation on the vendor code side.
However, this was deemed too implicit, as staging involves loading and
validating the microcode image, which differs from typical microcode file
handling.
---
 arch/x86/kernel/cpu/microcode/core.c     | 12 ++++++++++--
 arch/x86/kernel/cpu/microcode/internal.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b3658d11e7b6..4ddb5ba42f3f 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -676,19 +676,27 @@ static bool setup_cpus(void)
 
 static int load_late_locked(void)
 {
+	bool is_safe = false;
+
 	if (!setup_cpus())
 		return -EBUSY;
 
 	switch (microcode_ops->request_microcode_fw(0, &microcode_pdev->dev)) {
 	case UCODE_NEW:
-		return load_late_stop_cpus(false);
+		break;
 	case UCODE_NEW_SAFE:
-		return load_late_stop_cpus(true);
+		is_safe = true;
+		break;
 	case UCODE_NFOUND:
 		return -ENOENT;
 	default:
 		return -EBADFD;
 	}
+
+	if (microcode_ops->use_staging)
+		microcode_ops->staging_microcode();
+
+	return load_late_stop_cpus(is_safe);
 }
 
 static ssize_t reload_store(struct device *dev,
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 21776c529fa9..cb58e83e4934 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,10 +31,12 @@ struct microcode_ops {
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
 	enum ucode_state	(*apply_microcode)(int cpu);
+	void			(*staging_microcode)(void);
 	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
 	void			(*finalize_late_load)(int result);
 	unsigned int		nmi_safe	: 1,
-				use_nmi		: 1;
+				use_nmi		: 1,
+				use_staging	: 1;
 };
 
 struct early_load_data {
-- 
2.43.0


