Return-Path: <linux-kernel+bounces-401875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5C9C2075
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2A2B22289
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1C2206E9A;
	Fri,  8 Nov 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuN2EgCf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106D1EBA05
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079873; cv=none; b=a+FzL18zkqimmsHjvWmIo2Wgg+8YUzkL2FhT18q8YSSN8giKvn4SjZrwDKyplYO6L0PZ/+cb8ll1botU1O8oOc9nDbninxQvdyn+borqXCKtwQSmA6yd5UBkR9lKm/ICxI0zEnkyAYoVpURn76DyRyt4/Zmerba6/yFdYlqkwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079873; c=relaxed/simple;
	bh=DaHw04MWoXz/GITrSVYL8gk9DMpG3AIyQrtohO0vxsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nB2s8EWobP3igReWKLGLkGf3hUsLtZG5IwBWzSm5V6WfzkqXH/azbMDkxhShwajuqkPoQS59ot+BGxj5nmd5tIahrVAQJNybKGecnr4u1QZXh+I7keQWBzIjFzfzOZcC+8AD8T732++RlGfxQim++sMy7e/Hch7mgAjCgPk6fi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuN2EgCf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731079872; x=1762615872;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DaHw04MWoXz/GITrSVYL8gk9DMpG3AIyQrtohO0vxsg=;
  b=UuN2EgCf9pc29uFC0dfiv+YVAaKMxPvdbk793J4qrltA/0PmzEti3JV0
   UnBCrtzICINC3TW7hk1lfFx/Q+2ceYAuDm6L5mxGeR02oISu7tB2Cu8AY
   QMKiB9dLF/T6+QGMahvoHPH/WWO1XkorOcMw7xRtrKx7y8EnG6hEHAgR9
   ZzATKq8ZiryzE1MQR997EBlMHWN/gEUoFidFolhAp/2sSgIHr8LzmvcrL
   VoPPJ52FVONwaRir5i3CoOwwzJC9dHI3iyUfzeL/p1erhigWdI2et+hpD
   n21CPrElELk1IfQueLjiD13Y3r5e3x0ErNqtvEW4RBVkm+kmKbEBUSRnF
   w==;
X-CSE-ConnectionGUID: ZehKHAFQRwONLFb3i/dycg==
X-CSE-MsgGUID: CUveo1iwQkiBxctB51OjJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="33825838"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="33825838"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 07:31:11 -0800
X-CSE-ConnectionGUID: wuXLUK3hTwKxf6rY0ODtjw==
X-CSE-MsgGUID: LQmgTD/+S+6qFZIsOoF+bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="90429076"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 08 Nov 2024 07:31:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9D11F20F; Fri, 08 Nov 2024 17:31:06 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v5 1/1] x86/cpu: Make sure flag_is_changeable_p() is always being used
Date: Fri,  8 Nov 2024 17:30:10 +0200
Message-ID: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com>
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

While at it, fix the argument type to be unsigned long along with
the local variables, although it currently only runs in 32-bit cases.
Besides that, makes it return boolean instead of int. This induces
the change of the returning type of have_cpuid_p() to be boolean
as well.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v5: fixed type of the local vars (hpa), made it return bool (hpa)
v4: fixed the type of parameter (hpa)
v3: rewritten as suggested (Dave)
v2: marked both 32- and 64-bit cases

 arch/x86/include/asm/cpuid.h |  8 +++++---
 arch/x86/kernel/cpu/common.c | 39 +++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index ca4243318aad..239b9ba5c398 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_X86_CPUID_H
 #define _ASM_X86_CPUID_H
 
+#include <linux/types.h>
+
 #include <asm/string.h>
 
 struct cpuid_regs {
@@ -20,11 +22,11 @@ enum cpuid_regs_idx {
 };
 
 #ifdef CONFIG_X86_32
-extern int have_cpuid_p(void);
+bool have_cpuid_p(void);
 #else
-static inline int have_cpuid_p(void)
+static inline bool have_cpuid_p(void)
 {
-	return 1;
+	return true;
 }
 #endif
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a5f221ea5688..f361336416ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -276,21 +276,13 @@ static int __init x86_noinvpcid_setup(char *s)
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
-static inline int flag_is_changeable_p(u32 flag)
+static inline bool flag_is_changeable_p(unsigned long flag)
 {
-	u32 f1, f2;
+	unsigned long f1, f2;
+
+	if (!IS_ENABLED(CONFIG_X86_32))
+		return true;
 
 	/*
 	 * Cyrix and IDT cpus allow disabling of CPUID
@@ -313,11 +305,22 @@ static inline int flag_is_changeable_p(u32 flag)
 		      : "=&r" (f1), "=&r" (f2)
 		      : "ir" (flag));
 
-	return ((f1^f2) & flag) != 0;
+	return (f1 ^ f2) & flag;
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
-int have_cpuid_p(void)
+bool have_cpuid_p(void)
 {
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
@@ -349,10 +352,6 @@ static int __init x86_serial_nr_setup(char *s)
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
@@ -1088,7 +1087,6 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_32
 	int i;
 
 	/*
@@ -1109,7 +1107,6 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 				break;
 			}
 		}
-#endif
 }
 
 #define NO_SPECULATION		BIT(0)
-- 
2.43.0.rc1.1336.g36b5255a03ac


