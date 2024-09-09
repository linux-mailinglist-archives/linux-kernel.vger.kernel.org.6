Return-Path: <linux-kernel+bounces-321185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3B97159C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0684285703
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA31B530C;
	Mon,  9 Sep 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ayps4srQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03DB17ADE2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878735; cv=none; b=mrwzK3Aan/6zEHXMLZe/9BZwsxH16RA95iuMtu2SmuSbKGXMbMT+PmnPIj64mmtgxp/FpsLeDgix6iWQpvt8KI3Qg1mii9SFOv4lzaizfW/aUULY+yXrAJ8rDW2EzuursZYbZRh2RfhlZrZTD4P7UgkoFVmgv3C1fY+SFqzMX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878735; c=relaxed/simple;
	bh=I4jBDu7bbHU5vhaVExsEmo+DYKKNPuweIyRX/I6E2gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ce6rHbczlsEkX6WgSp041saVnH6UTvvaxDMkoYVao5EZHRlz3MIyPO+7ySap2UwEFj0JGdf+XhEIPerBk80VaQkA3+OW6a8fqC/mJnKY3LsGrB+exP/iOWVEzVz89DYj+Ka+9JmD350A9PpAJNdAnjUYS4iQayEAbT9yjRiIUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ayps4srQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725878734; x=1757414734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I4jBDu7bbHU5vhaVExsEmo+DYKKNPuweIyRX/I6E2gQ=;
  b=Ayps4srQ51jja1ls7/+Jqle5P8Q2qyOXPOTuUb7twn1s4F//a3EEzeaT
   NplNXLPCRymsfXkmS3N/tUycKW5Dm3L7h1+O4Ymr3McknchjaSqFzNf4z
   SVAXTqHEh8OhXKtRSqk+CkyuYm5pBm9FTzq9OT1WWOtQdm3KY/o/g4mNe
   ZgEOtDrdHZnwoMdq2p28iqaf5LIBGnczKPJNE/HEdjw3vMdrAKi2YVHL1
   Hn+m1TxPMVWFNbGIEQ2Juyqmrd5/1BR+FTp2mUd5OD7u/Xn0RlnzYuy41
   f3RMAeYbGNYLanVXhkbe8W9Y3i0pHqH7TluOWBPp79yXhBdtXJ/8n3l5V
   g==;
X-CSE-ConnectionGUID: MnqOriwcQzKeNaZaLXA30Q==
X-CSE-MsgGUID: 3l0EoCBtR/Gv1IKGF6/uew==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24367112"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24367112"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:45:09 -0700
X-CSE-ConnectionGUID: gglwnsRKTkuWG+IQQAepQg==
X-CSE-MsgGUID: 8NCJnZicS2qbjwBwZ0zcBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66622602"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 09 Sep 2024 03:44:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 38267321; Mon, 09 Sep 2024 13:44:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH v1 1/1] x86/reboot: KVM: Guard nmi_shootdown_cpus_on_restart() with ifdeffery
Date: Mon,  9 Sep 2024 13:44:38 +0300
Message-ID: <20240909104439.926125-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nmi_shootdown_cpus_on_restart() in some cases may be not used.
This, in particular, prevents kernel builds with clang, `make W=1`
and CONFIG_WERROR=y:

arch/x86/kernel/reboot.c:957:20: error: unused function 'nmi_shootdown_cpus_on_restart' [-Werror,-Wunused-function]
  957 | static inline void nmi_shootdown_cpus_on_restart(void)
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by guarging the definitions with the respective KVM ifdeffery.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/reboot.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0e0a4cf6b5eb..627fe86b4fcb 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -528,9 +528,9 @@ static inline void kb_wait(void)
 	}
 }
 
+#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 static inline void nmi_shootdown_cpus_on_restart(void);
 
-#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 /* RCU-protected callback to disable virtualization prior to reboot. */
 static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
 
@@ -954,12 +954,6 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	 */
 }
 
-static inline void nmi_shootdown_cpus_on_restart(void)
-{
-	if (!crash_ipi_issued)
-		nmi_shootdown_cpus(NULL);
-}
-
 /*
  * Check if the crash dumping IPI got issued and if so, call its callback
  * directly. This function is used when we have already been in NMI handler.
@@ -987,9 +981,19 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	/* No other CPUs to shoot down */
 }
 
-static inline void nmi_shootdown_cpus_on_restart(void) { }
-
 void run_crash_ipi_callback(struct pt_regs *regs)
 {
 }
 #endif
+
+#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
+#if defined(CONFIG_SMP)
+static inline void nmi_shootdown_cpus_on_restart(void)
+{
+	if (!crash_ipi_issued)
+		nmi_shootdown_cpus(NULL);
+}
+#else /* !CONFIG_SMP */
+static inline void nmi_shootdown_cpus_on_restart(void) { }
+#endif /* !CONFIG_SMP */
+#endif
-- 
2.43.0.rc1.1336.g36b5255a03ac


