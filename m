Return-Path: <linux-kernel+bounces-206364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2DA900863
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732C41C2248F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EE11953AA;
	Fri,  7 Jun 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdZFikWO"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF215B133
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773276; cv=none; b=MToVlUV4AUmhb6mi232J7IGLczz2bcKDrPnNVa1mDbt4U2l6j7vYPcc5hKa3Uvqjj55S8G7rfIw8FhYh2dVzP/VrXv7y8NHRQzhbZrCgVFY43X3ISJzywKg8bmT38UFORSsVwMPVQtYOHJ7z/y5Wuc7gO+6cBMM0fM5Zqhpx24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773276; c=relaxed/simple;
	bh=YNvEbYqDIOeQJ9EYeosxPjIWgCnYmm6K3MKS+7KrJ8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BeSQTHpCzmhJrZRCGrqPGGr71hTT0bfQ9HdOrQcCAIDpZ4H/gN6+oV+XeR03tYNXmt/BkleyuCC0Cj3KHeD/7Fi7oJk7nEroJIGBWOTutLPDZuC851QFvaD+jqdcGGY12StmQaKVecR2ws2LwByukQc9JwgNQPSPUfVQuK7iWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdZFikWO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42165f6645fso7376385e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717773272; x=1718378072; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JN0e5P7VFDOR5oAxAAgFP2WrNug79RTU2V3y/YlwPng=;
        b=BdZFikWO7wrA5KVl/Q1rjWYA7hp55PSDuvNu5SQCqzq7jf6R0KmUSZybf6vuU3age9
         glNOV7sJ8e/r+Y3ktaNvvSo/He3IrO0+ZFST4pypdJc0Ib1XF+Pn2I+JSQOXlbiF5ELn
         Njaf4xtkuUU3FykZr9BhLy/PpbRARjaU0Kdk3LEyTbDSh2aawYCVdxz0oLCFu5HqLmpI
         pYyavddHtdBcTGXUg6yPnzDbIKfU5SU471bPfZPqlJhGMwH32fyXkMpCqJXktyZxs7Rp
         abIzJmqUIWPy6XhWU0foGPdYgQ73AAmkawyatlr8CO5UwTOjjKEwAf8EtnUQ5JuTQkIq
         tOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717773272; x=1718378072;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JN0e5P7VFDOR5oAxAAgFP2WrNug79RTU2V3y/YlwPng=;
        b=eTRYq73No1Rc0ladAmz3DP+uBWMDwA06TUPkZu72KvbqGqS5K7wSOWgP8KPXv08M3f
         Nc48NwjTCx6LawXIAxfrT6KL3G8zICy1Tndn7IowyrqYAxKHF9DVs1ke3Vbev6eAOvlA
         CjbaJm5DV3EtD7H9a3wu+PjqCBzO0vCs7GS2gcDwAqAQbZXTAjwd57bUC56pyZYoXmqT
         zwjtmTyfisEwJMGsY5egP397oYD8HG60MUHnjRJy/fuRl/te96djAVhyfvBT1kU7hOay
         WF7HQxv8JTjj5s4IBKhtQd47bzvphe8HQhWhfv7JQbPSdZOM9uDJkl+7PyFVCXyOOxTc
         Dz6w==
X-Gm-Message-State: AOJu0YzMpaK15WC4Gc78Ga5gZgrrakxu+e+fSD9BPj9hwTmfnF+FUGzS
	n/7LNO+UceVzD3RQVWy03wIa0iTu1w4+ZVUMv6557APj+kOT+JMczC+l
X-Google-Smtp-Source: AGHT+IGl969oowyESJ6gy7Xl+3jZ5Ug8ZQffJojcyoV0efokZca38DbbT+mNsyWTlZCbiO3QsMs2oQ==
X-Received: by 2002:a05:6000:ecf:b0:35f:f3e:e7a9 with SMTP id ffacd0b85a97d-35f0f3ee8ccmr98890f8f.6.1717773272107;
        Fri, 07 Jun 2024 08:14:32 -0700 (PDT)
Received: from p183 ([46.53.249.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d6990csm4187371f8f.58.2024.06.07.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 08:14:31 -0700 (PDT)
Date: Fri, 7 Jun 2024 18:14:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: test "Kthread:" field
Message-ID: <818c4c41-8668-4566-97a9-7254abf819ee@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

/proc/${pid}/status got Kthread field recently.

Test that userspace program is not reported as kernel thread.

Test that kernel thread is reported as kernel thread.
Use kthreadd with pid 2 for this.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore               |    2 
 tools/testing/selftests/proc/Makefile                 |    2 
 tools/testing/selftests/proc/proc-2-is-kthread.c      |   53 ++++++++++++++++++
 tools/testing/selftests/proc/proc-self-isnt-kthread.c |   37 ++++++++++++
 4 files changed, 94 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -2,6 +2,7 @@
 /fd-001-lookup
 /fd-002-posix-eq
 /fd-003-kthread
+/proc-2-is-kthread
 /proc-fsconfig-hidepid
 /proc-loadavg-001
 /proc-multiple-procfs
@@ -9,6 +10,7 @@
 /proc-pid-vm
 /proc-self-map-files-001
 /proc-self-map-files-002
+/proc-self-isnt-kthread
 /proc-self-syscall
 /proc-self-wchan
 /proc-subset-pid
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -7,11 +7,13 @@ TEST_GEN_PROGS :=
 TEST_GEN_PROGS += fd-001-lookup
 TEST_GEN_PROGS += fd-002-posix-eq
 TEST_GEN_PROGS += fd-003-kthread
+TEST_GEN_PROGS += proc-2-is-kthread
 TEST_GEN_PROGS += proc-loadavg-001
 TEST_GEN_PROGS += proc-empty-vm
 TEST_GEN_PROGS += proc-pid-vm
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
+TEST_GEN_PROGS += proc-self-isnt-kthread
 TEST_GEN_PROGS += proc-self-syscall
 TEST_GEN_PROGS += proc-self-wchan
 TEST_GEN_PROGS += proc-subset-pid
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-2-is-kthread.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (c) 2024 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/* Test that kernel thread is reported as such. */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(void)
+{
+	/*
+	 * The following solutions don't really work:
+	 *
+	 * 1) jit kernel module which creates kernel thread:
+	 * test becomes arch-specific,
+	 * problems with mandatory module signing,
+	 * problems with lockdown mode,
+	 * doesn't work with CONFIG_MODULES=n at all,
+	 * kthread creation API is formally unstable internal kernel API,
+	 * need a mechanism to report test kernel thread's PID back,
+	 *
+	 * 2) ksoftirqd/0 and kswapd0 look like stable enough kernel threads,
+	 * but their PIDs are unstable.
+	 *
+	 * Check against kthreadd which always seem to exist under pid 2.
+	 */
+	int fd = open("/proc/2/status", O_RDONLY);
+	assert(fd >= 0);
+
+	char buf[4096];
+	ssize_t rv = read(fd, buf, sizeof(buf));
+	assert(0 <= rv && rv < sizeof(buf));
+	buf[rv] = '\0';
+
+	assert(strstr(buf, "Kthread:\t1\n"));
+
+	return 0;
+}
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-self-isnt-kthread.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2024 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/* Test that userspace program is not kernel thread. */
+#undef NDEBUG
+#include <assert.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(void)
+{
+	int fd = open("/proc/self/status", O_RDONLY);
+	assert(fd >= 0);
+
+	char buf[4096];
+	ssize_t rv = read(fd, buf, sizeof(buf));
+	assert(0 <= rv && rv < sizeof(buf));
+	buf[rv] = '\0';
+
+	/* This test is very much not kernel thread. */
+	assert(strstr(buf, "Kthread:\t0\n"));
+
+	return 0;
+}

