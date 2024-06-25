Return-Path: <linux-kernel+bounces-228906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1C916878
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB861C23321
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946C4158D86;
	Tue, 25 Jun 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edeErynV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED51667D8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320312; cv=none; b=PtEgx/pUe1lCgVoskgmxncNDGEXg50aosu7Y3RvJj4Y7AfqMsr114c9ByO/UuLBZoDv5F+nAKC3byQzT63gJf0xhpGLU34adhBArYD3ZIukjsUi5bRTKs2+KId0aKBK4DXpt0iUh6xLgYtnYZcQQHHz3VcdtkEmaDKmeGBS3NWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320312; c=relaxed/simple;
	bh=lLBI95b/xIjiHUrUedLhxc47SmekXuJZpctGOrGOIck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t9lobyCL8puNRl7QVXPHBlXU3AcK1K+iKbMSR0H0XZ1KzePzNlB7/b2Rkis0/nXJHjigIP/x5sZnfKfNvitdg4U/+Nfwd4h3M3UgLWqWy+c4Gd8WwcVLKcrNdmd1dTDgQfk1/Qx0pN2xpy5yE94j0393xvpAltRTac6zw6NsY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edeErynV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719320310; x=1750856310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lLBI95b/xIjiHUrUedLhxc47SmekXuJZpctGOrGOIck=;
  b=edeErynVyfj/Xm4/1FT0xX3y3hVOM7PlzhEApssYo5fYHdDWyNV/r4JP
   xqHhXXWjfgwZPWkKz5pCXBG7wgmwwa6KN5gtQWXimiPUACbh9mBWzqgjP
   ZuO+Hc2OTl0HqODDn8pEkhzZUKa9hhBLsbK/zFpH3sBh2gX4xFbaefM7s
   DHC/RRELOBKuNBZjiK8+L3Q7qIqC3AMZLc7vRaac84lRS9FDuY/hyvAqh
   oWPKVKvyNQedcCo72mUqLbqE+hW6qDoF5Ngv/GoGSqQEPdhqzOvX0m4Yf
   1VR0I2ettObku9fivetB7kIaCUzBTinlhZJ1o0xMz1Hz5w4si9E54Oa08
   g==;
X-CSE-ConnectionGUID: lHx/vABST+GCYHvEOjGWEA==
X-CSE-MsgGUID: QQckDzaQSLmJG1TMK+8kWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="27740951"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="27740951"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 05:57:23 -0700
X-CSE-ConnectionGUID: cHAiU3zlSF2FGKA1LyGN7Q==
X-CSE-MsgGUID: YCEvZPAyQ5eXsMIhy/BhRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="74402237"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orviesa002.jf.intel.com with ESMTP; 25 Jun 2024 05:57:20 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Prem Nath Dey <prem.nath.dey@intel.com>,
	Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
Date: Tue, 25 Jun 2024 20:54:03 +0800
Message-Id: <20240625125403.187110-1-yu.c.chen@intel.com>
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

Set the default value of virt_spin_lock_key to false. If booting in a VM,
enable this key. Later during the VM initialization, if other
high-efficient spinlock is preferred(paravirt-spinlock eg), the
virt_spin_lock_key is disabled accordingly. The relation is described as
below:

X86_FEATURE_HYPERVISOR         Y    Y    Y     N
CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
PV spinlock                    Y    N    N     Y/N

virt_spin_lock_key             N    N    Y     N

Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2._v3:
  Change the default value of virt_spin_lock_key from true to false.
  Enable this key when it is in the VM, and disable it when needed.
  This makes the code more readable. (Nikolay Borisov)
  Dropped Reviewed-by because the code has been changed.
v1->v2:
  Refine the commit log per Dave's suggestion.
  Simplify the fix by directly disabling the virt_spin_lock_key on bare metal.
  Collect Reviewed-by from Juergen.
---
 arch/x86/include/asm/qspinlock.h | 4 ++--
 arch/x86/kernel/paravirt.c       | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index a053c1293975..a32bd2aabdf9 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -66,13 +66,13 @@ static inline bool vcpu_is_preempted(long cpu)
 
 #ifdef CONFIG_PARAVIRT
 /*
- * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
+ * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
  *
  * Native (and PV wanting native due to vCPU pinning) should disable this key.
  * It is done in this backwards fashion to only have a single direction change,
  * which removes ordering between native_pv_spin_init() and HV setup.
  */
-DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 /*
  * Shortcut for the queued_spin_lock_slowpath() function that allows
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43886ad..fec381533555 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
 
-DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
-	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		static_branch_disable(&virt_spin_lock_key);
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_branch_enable(&virt_spin_lock_key);
 }
 
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-- 
2.25.1


