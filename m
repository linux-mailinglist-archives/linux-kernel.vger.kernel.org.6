Return-Path: <linux-kernel+bounces-577106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A6BA7186C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9782A188E51B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D961F2B82;
	Wed, 26 Mar 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QK3NxM+L"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BBD1A5B88
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999062; cv=none; b=G4t23LD27hhwD5ylmszPRCACbRuqNNdG4K6ZwhRrqi0TGjKY3/3+HOc7MrhCEO3Gmjd2l9K7Vwq89YMePSbnh/tFbQf8iXf71zxxX62tYepmqQQqE1SRJrH6rgWbIRsAdtktQHs6ErYW5Jhy0GWsZN/W7xXPBxG2yuvhJhVzM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999062; c=relaxed/simple;
	bh=LPYTFJLkVUz93ptjFs/WmCXExh3Nde3M4ahTLdn2bjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XN6puXSrafcTJ5r6q76aWDOHHemQaaI0HRGw47VHhWweU9XGj7a2y/yQ5Rj/Yio4viCu4hGdnGxEhPmewLes5NvfmXJFVwRsKA7+O6bcvbmY6Bo/cBi92SIy98JUOBFiJD8usxjV1hOI3y5hLte+UmHgnBJA+wq6z5ypaWTcE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QK3NxM+L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jMnqwnKFeunkNFt2xA902escEge7LjBq+yD8v//V6S4=; b=QK3NxM+L8hY5loEuRFMnINQ7nQ
	pSdpzFlRSRA1/KhyK290WhDGv4aJnouPOFloJrej2srPkW7zXnET1KWmYLbUF3602qS5E17+VmF+B
	3rxUugDIBIsAKzwPOgeKUyrM5jggzWIL7nHolh4+7MS+HQ824L7UavTw1QbF56NxOa5Eq7LNmQre8
	GlDsRRFLSJcg8/3eoaJ8Ion7H15fGhSVG9y+39OQ0SlcfBF0miY/jVIuCL4yhhEy6b/NPq+mqpies
	W4JUMBPHLBDu9MKFFzbTCwnvg0IXiDChIdpv4ScsexT07PEYhcLZXs8ocjmaXar1e3/vjgnFsvga2
	FaFwGtog==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRfq-000000005rh-3ZZ7;
	Wed, 26 Mar 2025 14:24:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1txRfq-00000001A9U-2chY;
	Wed, 26 Mar 2025 14:24:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v9 4/4] selftests/kexec: Add x86_64 selftest for kexec-jump and exception handling
Date: Wed, 26 Mar 2025 14:16:04 +0000
Message-ID: <20250326142404.256980-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326142404.256980-1-dwmw2@infradead.org>
References: <20250326142404.256980-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Add a self test which exercises both the kexec-jump facility, and the
kexec exception handling.

Invoke a trivial payload which just does an int3 and returns,
flip-flopping its entry point for the next invocation between two
implementations of the same thing.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kexec/Makefile        |  7 ++
 .../testing/selftests/kexec/test_kexec_jump.c | 72 +++++++++++++++++++
 .../selftests/kexec/test_kexec_jump.sh        | 42 +++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 tools/testing/selftests/kexec/test_kexec_jump.c
 create mode 100755 tools/testing/selftests/kexec/test_kexec_jump.sh

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 67fe7a46cb62..e3000ccb9a5d 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -8,6 +8,13 @@ ifeq ($(ARCH_PROCESSED),$(filter $(ARCH_PROCESSED),x86 ppc64le))
 TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 TEST_FILES := kexec_common_lib.sh
 
+include ../../../scripts/Makefile.arch
+
+ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
+TEST_PROGS += test_kexec_jump.sh
+test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
+endif
+
 include ../lib.mk
 
 endif
diff --git a/tools/testing/selftests/kexec/test_kexec_jump.c b/tools/testing/selftests/kexec/test_kexec_jump.c
new file mode 100644
index 000000000000..fbce287866f5
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_jump.c
@@ -0,0 +1,72 @@
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/kexec.h>
+#include <linux/reboot.h>
+#include <sys/reboot.h>
+#include <sys/syscall.h>
+
+asm(
+    "  .code64\n"
+    "  .data\n"
+    "purgatory_start:\n"
+
+    // Trigger kexec debug exception handling
+    "  int3\n"
+
+    // Set load address for next time
+    "  leaq purgatory_start_b(%rip), %r11\n"
+    "  movq %r11, 8(%rsp)\n"
+
+    // Back to Linux
+    "  ret\n"
+
+    // Same again
+    "purgatory_start_b:\n"
+
+    // Trigger kexec debug exception handling
+    "  int3\n"
+
+    // Set load address for next time
+    "  leaq purgatory_start(%rip), %r11\n"
+    "  movq %r11, 8(%rsp)\n"
+
+    // Back to Linux
+    "  ret\n"
+
+    "purgatory_end:\n"
+    ".previous"
+);
+extern char purgatory_start[], purgatory_end[];
+
+int main (void)
+{
+        struct kexec_segment segment = {};
+	int ret;
+
+	segment.buf = purgatory_start;
+	segment.bufsz = purgatory_end - purgatory_start;
+	segment.mem = (void *)0x400000;
+	segment.memsz = 0x1000;
+	ret = syscall(__NR_kexec_load, 0x400000, 1, &segment, KEXEC_PRESERVE_CONTEXT);
+	if (ret) {
+		perror("kexec_load");
+		exit(1);
+	}
+
+	ret = syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC);
+	if (ret) {
+		perror("kexec reboot");
+		exit(1);
+	}
+
+	ret = syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC);
+	if (ret) {
+		perror("kexec reboot");
+		exit(1);
+	}
+	printf("Success\n");
+	return 0;
+}
+
diff --git a/tools/testing/selftests/kexec/test_kexec_jump.sh b/tools/testing/selftests/kexec/test_kexec_jump.sh
new file mode 100755
index 000000000000..6ae977054ba2
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_jump.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Prevent loading a kernel image via the kexec_load syscall when
+# signatures are required.  (Dependent on CONFIG_IMA_ARCH_POLICY.)
+
+TEST="$0"
+. ./kexec_common_lib.sh
+
+# kexec requires root privileges
+require_root_privileges
+
+# get the kernel config
+get_kconfig
+
+kconfig_enabled "CONFIG_KEXEC_JUMP=y" "kexec_jump is enabled"
+if [ $? -eq 0 ]; then
+	log_skip "kexec_jump is not enabled"
+fi
+
+kconfig_enabled "CONFIG_IMA_APPRAISE=y" "IMA enabled"
+ima_appraise=$?
+
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"IMA architecture specific policy enabled"
+arch_policy=$?
+
+get_secureboot_mode
+secureboot=$?
+
+if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
+    log_skip "Secure boot and CONFIG_IMA_ARCH_POLICY are enabled"
+fi
+
+./test_kexec_jump
+if [ $? -eq 0 ]; then
+    log_pass "kexec_jump succeeded"
+else
+    # The more likely failure mode if anything went wrong is that the
+    # kernel just crashes. But if we get back here, sure, whine anyway.
+    log_fail "kexec_jump failed"
+fi
-- 
2.48.1


