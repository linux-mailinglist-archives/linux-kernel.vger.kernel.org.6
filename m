Return-Path: <linux-kernel+bounces-269526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE779433D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925AA2862CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2991BBBE7;
	Wed, 31 Jul 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF82LNfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2191BB6B2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441936; cv=none; b=R+QHn2wQYYN2Tgnfm/1d/NIa3J5jqLzUmMZtpzwA9b5d6Oz+O/vxdd34bV4WiiYnCXeCh10tfl6OxTZSzueSpcNSY6hhcb7qXyG2FoHIzrcH/xOkTJg6Rmt8b8InWJXqEf+QO7TKUmHldynMXcGUwsptraNoKy4QGYkBCtvaL3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441936; c=relaxed/simple;
	bh=U10/q7arjnd/q6yYhxXbpLqgDRSYgVYrCtJHqjc/j80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrHP7MZ49w8bW6GVIjSu1YOaOtIWgfmF4Q+J9k4twpCuFJrdeRO3xCVk7W5Fia8uIMk302lLzUF7HkoidVZFl31Y2csbcduOUh/msIB33XfakQkQYVyvsH6bhNhbS47aUp2Xn4SU3/Oxq6pjHXV4DqCbOvHbE00kjlfnG04nkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF82LNfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3678C116B1;
	Wed, 31 Jul 2024 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722441935;
	bh=U10/q7arjnd/q6yYhxXbpLqgDRSYgVYrCtJHqjc/j80=;
	h=From:To:Cc:Subject:Date:From;
	b=fF82LNfIMTdVxYgELzUgEMVH2Llw7ne/XZB52q7c2Jd7maRrCnaDx8uwMH3T40NoN
	 SzT6l1EjO7AHjH+0Akcj0HBxT2e4iHXRKNqa6rrhin+PASDY50DLK1iBI7LDQvBGe5
	 56lKfU+JchhItfRXP/NAUZ9fWRMXwfBTbypHgxUp29eoonzpEOvfEGN+4gffe4Wg8t
	 WuCD5pnJv4HFJDvlfxxjfKLVQw8XmkbBYmVaoytnI/jsArx5l9HLUoB9xvMyAiCumd
	 HE4h2zbPv7uywLyQqa+UBus5vOEDb3xFtse6qBA8krM3zftTbGyn7sG+ABXPOjgdPH
	 bBY27WwSgvWag==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: Ananth Narayan <ananth.narayan@amd.com>,
	Jon Grimm <Jon.Grimm@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] Documentation/srso: Document a method for checking safe RET operates properly
Date: Wed, 31 Jul 2024 18:05:31 +0200
Message-ID: <20240731160531.28640-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add a method to quickly verify whether safe RET operates properly on
a given system using perf tool.

Also, add a selftest which does the same thing.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/admin-guide/hw-vuln/srso.rst | 69 +++++++++++++++++++++
 tools/testing/selftests/x86/Makefile       |  2 +-
 tools/testing/selftests/x86/srso.c         | 70 ++++++++++++++++++++++
 3 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/srso.c

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index 4bd3ce3ba171..2ad1c05b8c88 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -158,3 +158,72 @@ poisoned BTB entry and using that safe one for all function returns.
 In older Zen1 and Zen2, this is accomplished using a reinterpretation
 technique similar to Retbleed one: srso_untrain_ret() and
 srso_safe_ret().
+
+Checking the safe RET mitigation actually works
+-----------------------------------------------
+
+In case one wants to validate whether the SRSO safe RET mitigation works
+on a kernel, one could use two performance counters
+
+* PMC_0xc8 - Count of RET/RET lw retired
+* PMC_0xc9 - Count of RET/RET lw retired mispredicted
+
+and compare the number of RETs retired properly vs those retired
+mispredicted, in kernel mode. Another way of specifying those events
+is::
+
+        # perf list ex_ret_near_ret
+
+        List of pre-defined events (to be used in -e or -M):
+
+        core:
+          ex_ret_near_ret
+               [Retired Near Returns]
+          ex_ret_near_ret_mispred
+               [Retired Near Returns Mispredicted]
+
+Either the command using the event mnemonics::
+
+        # perf stat -e ex_ret_near_ret:k -e ex_ret_near_ret_mispred:k sleep 10s
+
+or using the raw PMC numbers::
+
+        # perf stat -e cpu/event=0xc8,umask=0/k -e cpu/event=0xc9,umask=0/k sleep 10s
+
+should give the same amount. I.e., every RET retired should be
+mispredicted::
+
+        [root@brent: ~/kernel/linux/tools/perf> ./perf stat -e cpu/event=0xc8,umask=0/k -e cpu/event=0xc9,umask=0/k sleep 10s
+
+         Performance counter stats for 'sleep 10s':
+
+                   137,167      cpu/event=0xc8,umask=0/k
+                   137,173      cpu/event=0xc9,umask=0/k
+
+              10.004110303 seconds time elapsed
+
+               0.000000000 seconds user
+               0.004462000 seconds sys
+
+vs the case when the mitigation is disabled (spec_rstack_overflow=off)
+or not functioning properly, showing usually a lot smaller number of
+mispredicted retired RETs vs the overall count of retired RETs during
+a workload::
+
+       [root@brent: ~/kernel/linux/tools/perf> ./perf stat -e cpu/event=0xc8,umask=0/k -e cpu/event=0xc9,umask=0/k sleep 10s
+
+        Performance counter stats for 'sleep 10s':
+
+                  201,627      cpu/event=0xc8,umask=0/k
+                    4,074      cpu/event=0xc9,umask=0/k
+
+             10.003267252 seconds time elapsed
+
+              0.002729000 seconds user
+              0.000000000 seconds sys
+
+Also, there is a selftest which performs the above, go to
+tools/testing/selftests/x86/ and do::
+
+        make srso
+        ./srso
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5c8757a25998..d51249f14e2f 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -77,7 +77,7 @@ all_32: $(BINARIES_32)
 
 all_64: $(BINARIES_64)
 
-EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
+EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64) srso
 
 $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
 	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $< $(EXTRA_FILES) -lrt -ldl -lm
diff --git a/tools/testing/selftests/x86/srso.c b/tools/testing/selftests/x86/srso.c
new file mode 100644
index 000000000000..1dcc49faf5a2
--- /dev/null
+++ b/tools/testing/selftests/x86/srso.c
@@ -0,0 +1,70 @@
+#include <linux/perf_event.h>
+#include <cpuid.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+int main(void)
+{
+	struct perf_event_attr ret_attr, mret_attr;
+	long long count_rets, count_rets_mispred;
+	int rrets_fd, mrrets_fd;
+	unsigned int cpuid1_eax, b, c, d;
+
+	__cpuid(1, cpuid1_eax, b, c, d);
+
+	if (cpuid1_eax < 0x00800f00 ||
+	    cpuid1_eax > 0x00afffff) {
+		fprintf(stderr, "This needs to run on a Zen[1-4] machine (CPUID(1).EAX: 0x%x). Exiting...\n", cpuid1_eax);
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&ret_attr, 0, sizeof(struct perf_event_attr));
+	memset(&mret_attr, 0, sizeof(struct perf_event_attr));
+
+	ret_attr.type = mret_attr.type = PERF_TYPE_RAW;
+	ret_attr.size = mret_attr.size = sizeof(struct perf_event_attr);
+	ret_attr.config = 0xc8;
+	mret_attr.config = 0xc9;
+	ret_attr.disabled = mret_attr.disabled = 1;
+	ret_attr.exclude_user = mret_attr.exclude_user = 1;
+	ret_attr.exclude_hv = mret_attr.exclude_hv = 1;
+
+	rrets_fd = syscall(SYS_perf_event_open, &ret_attr, 0, -1, -1, 0);
+	if (rrets_fd == -1) {
+		perror("opening retired RETs fd");
+		exit(EXIT_FAILURE);
+	}
+
+	mrrets_fd = syscall(SYS_perf_event_open, &mret_attr, 0, -1 , -1, 0);
+	if (mrrets_fd == -1) {
+		perror("opening retired mispredicted RETs fd");
+		exit(EXIT_FAILURE);
+	}
+
+	ioctl(rrets_fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(mrrets_fd, PERF_EVENT_IOC_RESET, 0);
+
+	ioctl(rrets_fd, PERF_EVENT_IOC_ENABLE, 0);
+	ioctl(mrrets_fd, PERF_EVENT_IOC_ENABLE, 0);
+
+	printf("Sleeping for 10 seconds\n");
+	sleep(10);
+
+	ioctl(rrets_fd, PERF_EVENT_IOC_DISABLE, 0);
+	ioctl(mrrets_fd, PERF_EVENT_IOC_DISABLE, 0);
+
+	read(rrets_fd, &count_rets, sizeof(long long));
+	read(mrrets_fd, &count_rets_mispred, sizeof(long long));
+
+	printf("RETs: (%lld retired <-> %lld mispredicted)\n",
+		count_rets, count_rets_mispred);
+	printf("SRSO Safe-RET mitigation works correctly if both counts are almost equal.\n");
+
+	return 0;
+}
+
-- 
2.43.0


