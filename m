Return-Path: <linux-kernel+bounces-390649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54539B7CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A79282469
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227351A072A;
	Thu, 31 Oct 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dg9zAN0n"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D819EED6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384764; cv=none; b=jR/c7PW9Kdz/tCp90ErYDF1yRYD2E3gnglUb3Z9mcQ960UUXsuB6N0fyAy9ZPqVNQx5utO2U1P+2xlQBkcBPoPc5psCZSaFuBhZ44ncohuyGQoiibhLuup9hoHYloLvebSa4TyJ+PNpCMBdd0E9FIcMMoVCpLb1V8O7DRH5QjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384764; c=relaxed/simple;
	bh=krgETbtVQ1xeQzZ+9Nfrve4+C2nlGc1mpljdJXrCb8w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pNsoeIFk+5HC9tm+5Ms8rP6/aboVGG2in1ck/gKwHuykV4PtO4mU31vCK5x+Bl/z/9TSvG/TBoaOSOEkDAPjU6Mgf2uJZcR0GhlW8p3/QOnwmTAjpap0z6kWt5iH1jB8+Ebivn3rGTfrAhHCA7iQ/OZvoswxjcwfCf2M6zQcgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dg9zAN0n; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso5785005e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730384760; x=1730989560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3eEcyZAd6yeG9YGtoYvjJsNp+XLOIdWAdFSpFZ843xA=;
        b=Dg9zAN0ncJhM0ycep5gvoDQT/Y8s5dkHANLG6j1Z1oVVF9f7xc9BY43Ue+93t4vfHn
         S6pMGU2zyXkw1/dIl3FhZevwGtefVnE9ZEubQK/Hotomt1+rPRP/s2fgShBXeZV4yyOk
         8iV9/9OEHVcwf0JLNho3rX+5uIe5t8DbfhT2UgFRGlysblM86Mi1n7oreatEGOscDlxC
         GzZqngvC6JxQkV8Kz887cx8OJnogT8K9SW0m0hlz38t1CtzrQK80U4DpA1W+hmuoLF/k
         /CPtOQhjWGjufGaBbJkbidsq4+ABqU6dfXfvjT22tdDUCGrP17dYlFPgQePd47QIwf4i
         OJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384760; x=1730989560;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eEcyZAd6yeG9YGtoYvjJsNp+XLOIdWAdFSpFZ843xA=;
        b=o3aUl2Rwb4CEFaqu5CJsy5wUYa3wisTmlQIgMFuDSS4sxA3qUkIoBCwKN0xZ62Rn8Q
         62DKbnvOny07tC9OyKabz/bPi5QphJGt032rq6rswtImbo+nbB0wCzEXMtQYgGxQmEAW
         UftzLrvOawKS9e01JXiszwReL7q1u+8p1U+eF5w6DtdFjmFdklIwsOUaeeca+UmgPgqz
         ETH0f1VU73FRYnAUkgfFu5mBkoeYj3Q8hV80mWwH4xoUgAJbG/bAXXFcjk3KWrjOAp1B
         w8JFCgjkMey5VSr6S90DzORRuQG6NRrWDY8+NbKGuXVMSALXWa1+DZ8ZfclUJrWp1tnP
         N/wg==
X-Forwarded-Encrypted: i=1; AJvYcCV4/MZnFxlfW6Ia939xFzNpDYig0JuEE6h7o9R8ZWxrB5Z/90GHQZZ9C3c7uKKXnLQhl/hQdGE32lPSqKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lmA3BlMKRWUXWvJrg28e+TwkEmrs70NAMe6xe4EKSY3+/GRK
	WrilejM9q4I8KiPBMf/FJzt5IOVW3ax2lC73w+ax2Bcbc6igeE8YP51RU5ePjEVmr3fjxN5j3R4
	GTpIl+UVMNmyAY4Ex0fmwRQ==
X-Google-Smtp-Source: AGHT+IHE303QxRNggAhR40WXBDN97f7SsBXZAGpm5u4v+FhD/f6plXtsoe9qAGzfyQVuBhAt5kD/nULRU+PC4pUkUA==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:ce0])
 (user=peternewman job=sendgmr) by 2002:a05:600c:3b92:b0:42e:6ad4:e411 with
 SMTP id 5b1f17b1804b1-4327dbd91d6mr600185e9.1.1730384760545; Thu, 31 Oct 2024
 07:26:00 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:25:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241031142553.3963058-1-peternewman@google.com>
Subject: [PATCH 1/2] selftests/resctrl: fastcat for benchmarking counter reads
From: Peter Newman <peternewman@google.com>
To: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
	James Morse <james.morse@arm.com>, Martin Kletzander <nert.pinx@gmail.com>, 
	Shaopeng Tan <tan.shaopeng@fujitsu.com>, linux-kernel@vger.kernel.org, eranian@google.com, 
	Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch is provided for reference and not intended for submission.

This test program is used to evaluate the cost of reading resctrl
counters. It is essentially a drop-in replacement for cat, allowing
presumably small files, like resctrl nodes, to be read repeatedly using
pread(). In contrast, repeated invocations of cat would open and close
the counter files, which is an order of magnitude more costly than the
actual counter file read operations.

For example, the steps below were used to determine the cost of reading
a large number of local or remote counters on a dual-socket AMD Zen2:

Bind to a CPU in L3 domain 6:

 # taskset -c 25 bash

Record the setup cost for the groups /sys/fs/resctrl/mon_groups/*:

 # cd /sys/fs/resctrl
 # FASTCAT_READ_COUNT=0 perf stat -r 1000 /tmp/fastcat mon_groups/*/mon_data/mon_L3_06/mbm_*

Measure local read cost:

 # perf stat -r 1000 /tmp/fastcat mon_groups/*/mon_data/mon_L3_06/mbm_*

Measure remote read cost:

 # perf stat -r 1000 /tmp/fastcat mon_groups/*/mon_data/mon_L3_07/mbm_*

Signed-off-by: Peter Newman <peternewman@google.com>
---
 tools/testing/selftests/resctrl/.gitignore |  1 +
 tools/testing/selftests/resctrl/Makefile   |  6 ++-
 tools/testing/selftests/resctrl/fastcat.c  | 63 ++++++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/fastcat.c

diff --git a/tools/testing/selftests/resctrl/.gitignore b/tools/testing/selftests/resctrl/.gitignore
index ab68442b6bc8d..11a40e331f4ad 100644
--- a/tools/testing/selftests/resctrl/.gitignore
+++ b/tools/testing/selftests/resctrl/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 resctrl_tests
+fastcat
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index f408bd6bfc3d4..c5ec1e8289390 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -3,10 +3,12 @@
 CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := resctrl_tests
+TEST_GEN_PROGS := resctrl_tests fastcat
 
 LOCAL_HDRS += $(wildcard *.h)
 
 include ../lib.mk
 
-$(OUTPUT)/resctrl_tests: $(wildcard *.c)
+$(OUTPUT)/resctrl_tests: cache.c cat_test.c cmt_test.c fill_buf.c mba_test.c mbm_test.c resctrlfs.c resctrl_tests.c resctrl_val.c
+
+$(OUTPUT)/fastcat: fastcat.c
diff --git a/tools/testing/selftests/resctrl/fastcat.c b/tools/testing/selftests/resctrl/fastcat.c
new file mode 100644
index 0000000000000..ac7a56f82a7c2
--- /dev/null
+++ b/tools/testing/selftests/resctrl/fastcat.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	int nfiles = argc - 1;
+	char *nread_str;
+	int nread;
+	int *fds;
+	int i, j;
+
+	nread_str = getenv("FASTCAT_READ_COUNT");
+	if (!nread_str)
+		nread = 1;
+	else
+		nread = atoi(nread_str);
+
+	if (nfiles < 1)
+		exit(1);
+
+	fds = malloc(sizeof(*fds) * (argc));
+	if (!fds) {
+		perror("malloc");
+		exit(1);
+	}
+
+	printf("opening %d files\n", nfiles);
+
+	for (i = 1; i < argc; i++) {
+		fds[i - 1] = open(argv[i], O_RDONLY);
+		if (fds[i - 1] < 0) {
+			perror(argv[i]);
+			exit(1);
+		}
+	}
+
+	printf("reading %d files %d times\n", nfiles, nread);
+
+	for (j = 0; j < nread; j++) {
+		for (i = 0; i < nfiles; i++) {
+			// Assumed to be large enough for any output of
+			// mbm_*_bytes
+			char buf[40];
+			ssize_t r;
+
+			r = pread(fds[i], buf, sizeof(buf), 0);
+			if (r < 0) {
+				perror(argv[i + 1]);
+				exit(1);
+			}
+		}
+	}
+
+	printf("closing %d files\n", nfiles);
+	for (i = 0; i < nfiles; i++)
+		close(fds[i]);
+
+	return 0;
+}

base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
-- 
2.47.0.199.ga7371fff76-goog


