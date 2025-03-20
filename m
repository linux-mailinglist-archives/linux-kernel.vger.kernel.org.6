Return-Path: <linux-kernel+bounces-570534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557EAA6B1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8B14A2F07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7CF22B5B1;
	Thu, 20 Mar 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2xjhYi7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF422DF87
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514211; cv=none; b=uAUH56axXukzfbfMjs56vu6l1B7sHl2Fszsea6vhG3XT5qJ1q7fQKsN64uHA6HGL8FIw/z2XIWQlTyThTdnMu6bRYveLG+0WPBzojVRtSXcumfFHttqDC/oXmJ9aRQ2E6PtdacRaYZi2ZKjA9wCSh4OYIkdbIhx16b1Olccczyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514211; c=relaxed/simple;
	bh=M2VFfp1v80QZbwwejYrXXquMhO8yZWbF/M5k970bKvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esUVX+jQnPejnE+4ZF7jtPB8x/nv37sF3qTWm2iRT+dvQzcisaJBeCgr0AeUarDYpB32Z13AGfJdyw5n53WIOe3eJ64UqqGAzuJveQXJwL9535P67mAr1iVb+3+02xnAhqykkQbiKoa2T7vTkmYR98eIGI7XuLvnqU8PzNW8k9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2xjhYi7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514209; x=1774050209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M2VFfp1v80QZbwwejYrXXquMhO8yZWbF/M5k970bKvA=;
  b=W2xjhYi7kLZ71mQhxI2ni5xL1L5w8uztc+v47PHUws46Pp2Q7HcIk6Ii
   /Q2FfE7iKH+22Q5GMD/dnQCmnCqPlnO9x70bMDVY5WJje41KFPM3dzCBp
   Pxcq5LOxQjAWlkFdCWdabmmOXBLEwLdIbYftCBl5Qkp0Lpse/agXPb4tB
   b6hfN6Id4evxtAT/sw04VFVAOFqmG9uUHFyrY6ZIFZQ6f86bBm7Q7aKJQ
   k2klUxBgi7r9RVIOZbauyuLpdSyAAdww4PSzJCQvrnOeCGIw6MYgIy/Ff
   v8DmK0APQBwCq5KfXFRUs7+9LolfB6uVFJWXDrb5zwdaaJiYzW1Jv9Swb
   w==;
X-CSE-ConnectionGUID: vhnqpJo5QWyT3JF3PgYPiQ==
X-CSE-MsgGUID: GAN7w1FwRiiOVaS9qo83Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502620"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502620"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:29 -0700
X-CSE-ConnectionGUID: UQ+ZVJQuTyK5P6/ajFN2ow==
X-CSE-MsgGUID: bm0KlM2NTNSoMysijyAMYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122963028"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:28 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 9/9] selftests/x86/apx: Add APX test
Date: Thu, 20 Mar 2025 16:43:00 -0700
Message-ID: <20250320234301.8342-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234301.8342-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250320234301.8342-1-chang.seok.bae@intel.com>
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
into the x86/fpu branch as of now:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/fpu

Here is the original series posting for the record:
  https://lore.kernel.org/lkml/20250226010731.2456-1-chang.seok.bae@intel.com/
---
 tools/testing/selftests/x86/Makefile |  3 ++-
 tools/testing/selftests/x86/apx.c    | 10 ++++++++++
 tools/testing/selftests/x86/xstate.c |  3 ++-
 tools/testing/selftests/x86/xstate.h |  2 ++
 4 files changed, 16 insertions(+), 2 deletions(-)
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
index 42af36ec852f..e91e3092b5d2 100644
--- a/tools/testing/selftests/x86/xstate.h
+++ b/tools/testing/selftests/x86/xstate.h
@@ -33,6 +33,7 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_16,
 	XFEATURE_XTILECFG,
 	XFEATURE_XTILEDATA,
+	XFEATURE_APX,
 
 	XFEATURE_MAX,
 };
@@ -59,6 +60,7 @@ static const char *xfeature_names[] =
 	"unknown xstate feature",
 	"AMX Tile config",
 	"AMX Tile data",
+	"APX registers",
 	"unknown xstate feature",
 };
 
-- 
2.45.2


