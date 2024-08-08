Return-Path: <linux-kernel+bounces-278714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F98594B3F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F221C21634
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B086A13AA38;
	Thu,  8 Aug 2024 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvUwIEuv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD682C7E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075374; cv=none; b=r1EYDImFBquZsnLcWUY9DAvYpp+tcVm7PzzmA2/O1AUGVqZnKKYkXhuGtdhV/NlzmyvsOe4VJAiZY2KYDkumzoL3HzfeDsUPbGHGzeHxeK1I7QYSQ175YFUUT0kYjE9IHBU4mJWyXJzGOV54vo+rZV33Z5mdhLrhtP5gZeSVqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075374; c=relaxed/simple;
	bh=3+Kn955AYId0KQIPdPIYzztmFtSGtJgc46WB2uePXkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTPdbPspHksoQ0okNnbGJsGMZV5BL3aJXGLy2F0DYFzMQcjVFBT7psUd/6+mQSsKihaiitApDZLKreJWsWec6BwdZDsOf/GhYN5RhHpyELJHPVSlBj+yHdxImrOdxHsr+asBvqQoBTg9W7WwV/LsDGVbrDgAzN0vdYbGCa7zJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvUwIEuv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723075372; x=1754611372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3+Kn955AYId0KQIPdPIYzztmFtSGtJgc46WB2uePXkU=;
  b=AvUwIEuvkTnrtooJShGhrCsQiz6ob4Ql/gBx27XwXKQaK2G3LecSLWGd
   gLQlOTsAvK+VEhufKE+PoXhaQm9giq4yYTLZm4yZkuAdAHAgRLJBtWPqc
   5wUW36WJ/D/TS+ee84b0O4YxO/glYS18BMCcF4HcXFqipNjY1yLHFiuu1
   97AjegJQYf1pMmZ3uyiaF2y128EVqWGNK6pq3s4DXwb3j55zLEM9kE5oj
   XopWzvaaB/OJg7Rt46bHVfqWsJ1NiUE+FhhZ+nQipyX99Vr3QEbt2JOjR
   7sGmVWlb9XySJ2O0kB30iNI+b7H1swWlfx8Qg8YJ4DHPs1d3DwNtDHCuT
   w==;
X-CSE-ConnectionGUID: S31tY7l/Q5aZitjpeo9ajQ==
X-CSE-MsgGUID: 8+PECxyCT+a25rSVXPOWkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="24937441"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="24937441"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 17:02:51 -0700
X-CSE-ConnectionGUID: 07ydlc1ARqqHP9a7HqErsQ==
X-CSE-MsgGUID: EzaaAXi0Q+SaL0pD1DdeJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56952386"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 17:02:51 -0700
From: Andi Kleen <ak@linux.intel.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5] x86/mtrr: Check if fixed MTRRs exist before saving them
Date: Wed,  7 Aug 2024 17:02:44 -0700
Message-ID: <20240808000244.946864-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTRRs have an obsolete fixed variant for fine grained caching control
of the 640K-1MB region that uses separate MSRs. This fixed variant has
a separate capability bit in the MTRR capability MSR, however all x86
CPUs which have MTRR generally had this separate bit set.

The code to save MTRRs forgets to check the capability bit before
accessing the fixed MTRR MSRs.  This results in a #GP on a system that
does not support the fixed MTRR capability. The #GP is harmless because
the RDMSR fault is handled and harmless, but results in a WARN_ON printout
that looks scary to the user.

Found by testing Linux on a setup without fixed MTRRs.

Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before booting an AP")
Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Add Fixes tag and expand description.
v3: Expand description
v4: Expand description
v5: Change description
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 767bf1c71aad..2a2fc14955cd 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -609,7 +609,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
-- 
2.45.2


