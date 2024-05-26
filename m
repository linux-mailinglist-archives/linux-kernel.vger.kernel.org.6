Return-Path: <linux-kernel+bounces-189585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE428CF26F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0110B20EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 02:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721E1392;
	Sun, 26 May 2024 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2IPv/pc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC44A0F
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716688930; cv=none; b=ktBhB8DKHayl7VzpxGT/RWAKwJEHhKoD90t9jNMWiH6yZJtzuX+KDFWboThx+JRhZD5uGrSRtWV47y1qH5xobuoyQ7OYHyEWKFryzOrg80Pr/qy7aCUwNyulEq4GESeUIgcRuV4Jkz5GiXb/qIHYYFfJEvvq3GqnAgJSg83XDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716688930; c=relaxed/simple;
	bh=wySTrCiWbxv3d5CkP0WjwDn7rMNpNEwftP0j7quJ8LM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DlvGKdfHNeuAP0eM+p3Fzzg8HVx8/KiUCLr4ojW20c7ndFaANm2O8C1Rnb0yyiTrOATpfpXmplIeXajL91tkwxtsaluJrfOTQGOPVraDXLWobF2mhSX8gY6AgnjB2nuB34EhpbysdzdZdhZAIgg+MqfYPtVPGSIcAsjIRi9f5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2IPv/pc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716688928; x=1748224928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wySTrCiWbxv3d5CkP0WjwDn7rMNpNEwftP0j7quJ8LM=;
  b=n2IPv/pcJzeFPUbZCgsSqVVdRRkNDvJsp9xilbc9mjIr1ULQNVGguITT
   KvotSGozl+JS0uGWZaKVZ5NcgZt21ti4b/VgvXd/aDfq8v8l0SdvQYpdR
   vgpzLMa1EXevvhqp21++lZKLvyeYKiHPZLuAIOnt73z8D8gpIzNfF9ZUe
   uU6iv09rdpiKppnz/4WoSDuse11ic85u8If2rZcfgVwF83zLtXt5CQFL/
   JvTMGWHiixzqd24E0qFWcW7WzbNIeomTvQNcqXp0uYcuHWYY4KhCGuFOA
   Q7Pwiuld+T9RFvxeUezWrYSbMRkPPX6KqTuo3OTkjkFoIbOA7hG3Y/wTA
   A==;
X-CSE-ConnectionGUID: iKKG1ii/QUuuZi2UzgI0lg==
X-CSE-MsgGUID: aDqswrwAT8KdgAfQ1hrycQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="23633421"
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="23633421"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 19:02:08 -0700
X-CSE-ConnectionGUID: /iF1cy3dSnCmVTft7XP+Vw==
X-CSE-MsgGUID: PPmQzdpWQ2WRWRTggtGsow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,189,1712646000"; 
   d="scan'208";a="39375802"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orviesa004.jf.intel.com with ESMTP; 25 May 2024 19:02:04 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Prem Nath Dey <prem.nath.dey@intel.com>,
	Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: [PATCH v2] x86/paravirt: Disable virt spinlock on bare metal
Date: Sun, 26 May 2024 09:58:47 +0800
Message-Id: <20240526015847.14142-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel can change spinlock behavior when running as a guest. But
this guest-friendly behavior causes performance problems on bare metal.
So there's a 'virt_spin_lock_key' static key to switch between the two
modes.

The static key is always enabled by default (run in guest mode) and
should be disabled for bare metal (and in some guests that want native
behavior).

Performance drop is reported when running encode/decode workload and
BenchSEE cache sub-workload.
Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
is disabled the virt_spin_lock_key is incorrectly set to true on bare
metal. The qspinlock degenerates to test-and-set spinlock, which
decrease the performance on bare metal.

Fix this by disabling virt_spin_lock_key if it is on bare metal,
regardless of CONFIG_PARAVIRT_SPINLOCKS.

Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v1->v2:
  Refine the commit log per Dave's suggestion.
  Simplify the fix by directly disabling the virt_spin_lock_key on bare metal.
  Collect Reviewed-by from Juergen.
---
 arch/x86/kernel/paravirt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43886ad..c193c9e60a1b 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -55,8 +55,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
-	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
 
-- 
2.25.1


