Return-Path: <linux-kernel+bounces-537108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0155A4881A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002A01693BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868F26F47D;
	Thu, 27 Feb 2025 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKvFxEzq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778026F450
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681918; cv=none; b=RlJKkTmn2j1AxKnhMV4uNSHtNKfYYU8bND2umLPipRIcC7qmTpnpDR/jQvubFJqYGgEMspQImzcAJpKn9L9oCIk3S9MYy1QURHQjIEyKUXqTAGPZHDOjS5C39VvmKAkYoJleIH/wlFFB6zFFuGl4hjqnEfrZXi2+CHsPaYihVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681918; c=relaxed/simple;
	bh=gxC4YpulTjL4LyXhFMns9rIvzhJlui2aMfofQzc2VGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9alKDl/WWxGMejvsw70lBe3Gu2HWA9RLwM9TxR2BG1AqUahSc/0p0B0XhY2+3zMrIFwpzEQSwFdeR/dBTjdMcqJeYibaxast3uyHC8hA7B7JNlffk8G952Pk2SuTeGO3B1sWCyaF+p9G87GG9wjE/wzM6JDutldfBQrNAOSrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKvFxEzq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681917; x=1772217917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gxC4YpulTjL4LyXhFMns9rIvzhJlui2aMfofQzc2VGA=;
  b=RKvFxEzqZ1oKzq13b/wo2MSSHxGkAQso1gbfVAFzHYIYTLIqY+ESE+J9
   lo8N2tsoKpwh/emqETfFoncdvvfIQCR7I6DDuTxtzumv7l/1PcRS96TnY
   9Z6ok8UE4AUKc6i93nKZB6WQazDI4XvBZpOTPojGsKgFy0Phvs3DQy6jn
   IHQubkLj/NAbOtT6HxN2zmacqO4yYsrfRsv4JLXf5b9mxImPigkDxUcM9
   7r2db+H/fj0/z9cMi4rQ7UY9jq/PkGb81i5L7JeENH0IkFtJmqgVI0zcX
   eZM+YP3nfMTkv02dODljUnq9r0aJT3RekjA+YeNK/kXxz6WCzZTjubSdf
   w==;
X-CSE-ConnectionGUID: Xf3AT+PnT2GyIPo0/VdN4A==
X-CSE-MsgGUID: mdBPoQZHR3GJpksg+LCBlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720925"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720925"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:16 -0800
X-CSE-ConnectionGUID: wfJMc+3LS82MOF+1S9p++A==
X-CSE-MsgGUID: OfFZEz4oT+Whyw4Bl0hvkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767455"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:15 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 11/11] selftests/x86/apx: Add APX test
Date: Thu, 27 Feb 2025 10:44:56 -0800
Message-ID: <20250227184502.10288-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227184502.10288-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extended general-purpose registers for APX may contain random data,
which is currently assumed by the xstate testing framework. This allows
the testing of the new userspace feature using the common test code.

Invoke the test entry function from apx.c after enumerating the
state component and adding it to the support list

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
The patch depends on the selftest xstate series, which was just merged
into the x86/fpu branch:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/fpu

Here is the original series posting:
  https://lore.kernel.org/lkml/20250226010731.2456-1-chang.seok.bae@intel.com/
---
 tools/testing/selftests/x86/Makefile |  3 ++-
 tools/testing/selftests/x86/apx.c    | 10 ++++++++++
 tools/testing/selftests/x86/xstate.c |  3 ++-
 tools/testing/selftests/x86/xstate.h |  1 +
 4 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/x86/apx.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 28422c32cc8f..f703fcfe9f7c 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -19,7 +19,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx lam test_shadow_stack avx
+			corrupt_xstate_header amx lam test_shadow_stack avx apx
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -136,3 +136,4 @@ $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/avx_64: CFLAGS += -mno-avx -mno-avx512f
 $(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
 $(OUTPUT)/avx_64: EXTRA_FILES += xstate.c
+$(OUTPUT)/apx_64: EXTRA_FILES += xstate.c
diff --git a/tools/testing/selftests/x86/apx.c b/tools/testing/selftests/x86/apx.c
new file mode 100644
index 000000000000..d9c8d41b8c5a
--- /dev/null
+++ b/tools/testing/selftests/x86/apx.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include "xstate.h"
+
+int main(void)
+{
+	test_xstate(XFEATURE_APX);
+}
diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
index 23c1d6c964ea..97fe4bd8bc77 100644
--- a/tools/testing/selftests/x86/xstate.c
+++ b/tools/testing/selftests/x86/xstate.c
@@ -31,7 +31,8 @@
 	 (1 << XFEATURE_OPMASK)	|	\
 	 (1 << XFEATURE_ZMM_Hi256) |	\
 	 (1 << XFEATURE_Hi16_ZMM) |	\
-	 (1 << XFEATURE_XTILEDATA))
+	 (1 << XFEATURE_XTILEDATA) |	\
+	 (1 << XFEATURE_APX))
 
 static inline uint64_t xgetbv(uint32_t index)
 {
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
index 42af36ec852f..f3c25193a3be 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -33,6 +33,7 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_16,
 	XFEATURE_XTILECFG,
 	XFEATURE_XTILEDATA,
+	XFEATURE_APX,
 
 	XFEATURE_MAX,
 };
-- 
2.45.2


