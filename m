Return-Path: <linux-kernel+bounces-322695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE999972C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2C41F2314B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEDB1862B8;
	Tue, 10 Sep 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LffjfOAa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C614A4C3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957845; cv=none; b=u80XHyd1G8csyHPev+agESMFppNI0UyXZcAXEO0UX/F+shXP3x+Md3m65KxPqIVH3143qm/A4MgkBjhvGuoNuPRaSC4tjTQP+/V4IanV/9iXZRhfhpsWD13SxwyouH53YhDQznkdF7pSUEqrx33f3VdW5upovTpCGdDnNzBgznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957845; c=relaxed/simple;
	bh=qqlizFQaM14OE2fhleEMqA9GnZPbB0rWThRND9fodLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FiYq0Pwb3z/d5RCtwv+IVbPWbojFNshlaRKpOYsf/VwahIDmJDm3G5IDcidIlzTDzvhuQ766vUXmghkFcaqFtjZmh1dZ7g9rDrvsrUJC2oHDOoHgqlq+g3xBByxorYI73TnkJ81KjhwgvREi8bcc8KzsIbRLOBSKXvRNrK4Mykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LffjfOAa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725957844; x=1757493844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qqlizFQaM14OE2fhleEMqA9GnZPbB0rWThRND9fodLg=;
  b=LffjfOAaAJ6Ehc1QCARPI6HGVruii+4BCB8n40cIXqNHv3nxa6aZEFON
   ZLusXtiXpnmxma9KaMSTvmat2x9Gs9+bPVnZQ8e3qjwPI7GU8SRE6Oznq
   xQFFrBvLHAio+w60Qi1By859LO+0/lVqcktrtY23xZnODqPACurplvVZH
   0bgXIVPrIC6+oMnj0IzqgWhNhC/bqO7XFKo2Q6ymgNgiD2LtX1Vdo7aou
   HkIToiWTgd0ycMp25s4WzDrcCDEAcmZuemc8kFI3oPbIs5Hi720Qr1ry7
   403+SlBoy2IUBH0fzPDw5L+J8eAWNoDbdLfZKiTMXXGOkB4vTe29VGxRR
   w==;
X-CSE-ConnectionGUID: kdkE5by3QqCZZB5HjHPTnw==
X-CSE-MsgGUID: a4DleFGETHm7RZpfQSV1nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24565909"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24565909"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 01:44:02 -0700
X-CSE-ConnectionGUID: 9kN+kNqCQ3aNTCFWPFjFfg==
X-CSE-MsgGUID: IBZPnqfzRXSfgoJq+aAamA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="67252448"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 10 Sep 2024 01:43:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A1BF3408; Tue, 10 Sep 2024 11:43:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v3 1/1] x86/cpu: Make sure flag_is_changeable_p() is always being used
Date: Tue, 10 Sep 2024 11:42:42 +0300
Message-ID: <20240910084356.1518209-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When flag_is_changeable_p() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

arch/x86/kernel/cpu/common.c:351:19: error: unused function 'flag_is_changeable_p' [-Werror,-Wunused-function]
  351 | static inline int flag_is_changeable_p(u32 flag)
      |                   ^~~~~~~~~~~~~~~~~~~~

Fix this by moving core around to make sure flag_is_changeable_p() is
always being used.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: rewritten as suggested (Dave)
v2: marked both 32- and 64-bit cases

 arch/x86/kernel/cpu/common.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..5525afa6e888 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -275,22 +275,14 @@ static int __init x86_noinvpcid_setup(char *s)
 }
 early_param("noinvpcid", x86_noinvpcid_setup);
 
-#ifdef CONFIG_X86_32
-static int cachesize_override = -1;
-static int disable_x86_serial_nr = 1;
-
-static int __init cachesize_setup(char *str)
-{
-	get_option(&str, &cachesize_override);
-	return 1;
-}
-__setup("cachesize=", cachesize_setup);
-
 /* Standard macro to see if a specific flag is changeable */
 static inline int flag_is_changeable_p(u32 flag)
 {
 	u32 f1, f2;
 
+	if (!IS_ENABLED(CONFIG_X86_32))
+		return 1;
+
 	/*
 	 * Cyrix and IDT cpus allow disabling of CPUID
 	 * so the code below may return different results
@@ -315,6 +307,17 @@ static inline int flag_is_changeable_p(u32 flag)
 	return ((f1^f2) & flag) != 0;
 }
 
+#ifdef CONFIG_X86_32
+static int cachesize_override = -1;
+static int disable_x86_serial_nr = 1;
+
+static int __init cachesize_setup(char *str)
+{
+	get_option(&str, &cachesize_override);
+	return 1;
+}
+__setup("cachesize=", cachesize_setup);
+
 /* Probe for the CPUID instruction */
 int have_cpuid_p(void)
 {
@@ -348,10 +351,6 @@ static int __init x86_serial_nr_setup(char *s)
 }
 __setup("serialnumber", x86_serial_nr_setup);
 #else
-static inline int flag_is_changeable_p(u32 flag)
-{
-	return 1;
-}
 static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 {
 }
@@ -1087,7 +1086,6 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_32
 	int i;
 
 	/*
@@ -1108,7 +1106,6 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 				break;
 			}
 		}
-#endif
 }
 
 #define NO_SPECULATION		BIT(0)
-- 
2.43.0.rc1.1336.g36b5255a03ac


