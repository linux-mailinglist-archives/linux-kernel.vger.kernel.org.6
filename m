Return-Path: <linux-kernel+bounces-355816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1D995781
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531171C25BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE05212644;
	Tue,  8 Oct 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iA7pBZk4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5613541B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414962; cv=none; b=bKv2KAFaZJ2mX94Id/13eKDbTqG8+WzCHueGTWmukYfAi3ucNvliugEAXfQPVqjid1ROiEEvVHerx2TspwRA967bFVbGNcO5YYMH7/E6xRN49Aq7Y6/TMK9wHEiF1dhtMM50/fFduTnfQGIGJm4hxguSCLDyH2J3I/amwwAaFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414962; c=relaxed/simple;
	bh=TxBO9VR/XnPErLZzuLD3zeVVWu30037Kl7xHFMJLT4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYmMJGwaYWitvtpXo/UkusCd80PjI9wmv6rNbtyxoC63SveQdK5HbGYkNBvWAbk+GqAmTGz0dElEU3rq7OJGhQVfTFxoGXvV7jxfQQaLABHooOp5wwuUYAvM6/x1e2DyH5dVZJedRRRyaSRWIMlCbpn+Cm9Vv9QRYCxhodupkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iA7pBZk4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728414962; x=1759950962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TxBO9VR/XnPErLZzuLD3zeVVWu30037Kl7xHFMJLT4U=;
  b=iA7pBZk4it8b973hOj1VPg0/aM+RgmWpy68Wu60/VtuXkoybIYMViNAG
   HFGLvb5SDynbeSGeZe9zJ1lCc+KZ9B+5vAkj35YT4696kYPsa0cPpN+he
   YOKh6Akz2fkclcfaelrbwT2Eoxkut/uUBR+Xig/92/g1tYqX6oAv/3awQ
   bjod1evHawolsSVQr0fYO4dQ/BFSpAtZZQT9NHUY90QA0+tFdsIdyjofb
   +LBO8prmrcyzApLPPhwdLb/BI/R5nHmMjVK16yQT5hhLUsI/VmGZb8uDj
   y4kPsLSH2JUUImXFG2DWXks4FUTydjKWQ6xb61tIsQC7+cuJa2vL4i3/B
   Q==;
X-CSE-ConnectionGUID: X+MogFkGT9aC4tIuaxIBPg==
X-CSE-MsgGUID: VDIIQOQITiClH4cX1U2ajQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38216010"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38216010"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 12:16:01 -0700
X-CSE-ConnectionGUID: EqO+XfN9RnG0gMv1b1EVuQ==
X-CSE-MsgGUID: IuMbrWGESd+l96IMpYNy2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106793393"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 08 Oct 2024 12:15:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D684426B; Tue, 08 Oct 2024 22:15:56 +0300 (EEST)
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
Subject: [PATCH v2 1/1] x86/reboot: KVM: Guard nmi_shootdown_cpus_on_restart() with ifdeffery
Date: Tue,  8 Oct 2024 22:14:40 +0300
Message-ID: <20241008191555.2336659-1-andriy.shevchenko@linux.intel.com>
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
v1: suggested by Dave Hansen
v2: rebased on top of the latest changes in the file
 arch/x86/kernel/reboot.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 615922838c51..67551c474203 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -528,9 +528,9 @@ static inline void kb_wait(void)
 	}
 }
 
+#if IS_ENABLED(CONFIG_KVM_X86)
 static inline void nmi_shootdown_cpus_on_restart(void);
 
-#if IS_ENABLED(CONFIG_KVM_X86)
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
+#if IS_ENABLED(CONFIG_KVM_X86)
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


