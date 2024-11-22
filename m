Return-Path: <linux-kernel+bounces-418278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDCE9D5FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D075F282239
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F471DF745;
	Fri, 22 Nov 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E9RFd7aS"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591E1DED6D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732281932; cv=none; b=at8V7z3lpFj0EMWZHjpCJ+iFZKj7kbD0NOwCPyMMlsetjnEVoxtTa6P18WaWaWOwBFXiU+O8ADvra3WowyzGmfl7LgbQ2YZ2ObkReP23QLWLqY5HIvRAMRB5edhbBY+pJ0JEzI3JikJ9N0vIZRpqpIJ0dBDq+JFA5w7IXa16eRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732281932; c=relaxed/simple;
	bh=izLxW5KDYqiJfGTZ/g1W/LiggnMtbi0ghUZlMQtmR1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWv8bn4G+9YEqaHPPLjcFx6ARTj6QU4sG5wc9uVJP5jUCB+k3WnIIHdJMJtE1bp9hhYBYYuX+b4GWoD1qt3bKHK7ouGVMt+blZIG2odPtu7wTu3qWJJkSZEcL649/lmSEFDxLujr8mMyGh8iTHXH73RmNCqzB22dfYWKTIrC2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E9RFd7aS; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DEEC83F5BA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732281922;
	bh=oLNrfajBeE9leucyFKA/eCxRIvLKVmI84Y5JLBPsmjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=E9RFd7aSfPwgHA6gAv7GWIalXhLLC0p7IZJDm/+bFRc5ABR0ynvUyChlQa9bRMxau
	 xdgVnrjU04g9EpX7oquevm1NSv8veGqYSC9M9DXuxhQOpsEPWcVD/5inIlYjnYI8XI
	 gQvyMjVXbIcyoypcbpH4OOCFm9unjriHUT4rM6KqStgvVS4pGhDCq9YkSlQHLw+Mda
	 nxwhQ6aBz1brPRJ8swRlSlSSoREzqwJDUBIgLJYn0X5X/EmZydhYjM0VvGpVdrLRSm
	 mzO6r6jNqn8nVw9m5VK0A6RHDP3/8+ahE/cxNOetzHPs+sct4RGquVctzNxODQeR2w
	 0hwSUrMamxu7w==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5cfca7e901cso1283650a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732281922; x=1732886722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLNrfajBeE9leucyFKA/eCxRIvLKVmI84Y5JLBPsmjU=;
        b=k3p/7exC2joh3mgrCUWlj2zEVE/EqgsKwoOUIHtQHzj8m8vaH07iu/1ICMRg5SPgj0
         3Zr69kMjmXz7pSfNvqAhQvMsTHZEebuzixcg76QFl6tiJa/1U1Fgf0BuPE+f51uVzjZL
         MsA4yAoSZuRKEYdOmu2jD6nc2CImIvIWEWM3g0hK9qBPa97/qUvMDDZUbCov5HPgP+Fl
         Vxaxd8L5SMTXm9rqXuVBP77ohn7x0ncHCYcqmSIp26TLaWIrq62KKcMaylPnDmOzNoxo
         Vf06zSrBWm/NRttXJvGne2cgPJ/N/usL77J14sq+qvhLIgWlxyds9yWZ3qOdMIDB1LYB
         XZrA==
X-Forwarded-Encrypted: i=1; AJvYcCU/sQzNJbgqBK+0iC5cqQLY9PrK8vEmvTY0Iujzs6/WT+hJkFNtePMN+zasakrp+sdM0WwClIsKUd8ZBKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DEVGP1N/rrYkz6WpHL4wFzRZ6I91qSOmYM9eTv9fWI/z5R0Z
	qI9Ip7VeoWs/5kVBbiiPfjC6w6xH1F22mJ6oFDjjuzW8hRH2DA2qx4yfG9Wq7fDHARgbiFLD5v6
	2DsUF+dlqLUPJWf+kVMVxehAeIIdM91L46pEXyH8tKHRQEAsjDJPu82B42o6ZXIfMtQJt2NmWt3
	YX4w==
X-Gm-Gg: ASbGncsp7Rcx8V0tbo+tGaJKs46EK6iANiC6myQuCiBL8YVit5+6xlVFqnbsjURxrJ4
	/3wWadDJFB/MASYtSWUW3UnhcEs6KWT7VrQYB26zGXCdxdyZ7rbjvbT2Q4KHimlK1gui1bOK4bJ
	1tiqPRDp5XV8vq0z3oLqwk0NICt870Xgj3CvZ4FIm4P0ijwp9CCp2rb3DEGbqWeESYMMpEqU7RI
	U2RA9OpnXn1Dv90if61PqLQA5/ZaTVelY9JM8qeUqV4k15Hu18Ql+Py8ZbHH+UI4xArXkp6lnCK
	qA==
X-Received: by 2002:a05:6402:1ed2:b0:5cf:e13b:eec1 with SMTP id 4fb4d7f45d1cf-5d0205a80cfmr2611732a12.3.1732281922413;
        Fri, 22 Nov 2024 05:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuxF3WddHjzjQlsM/za3500l/l6I3723FEypfnEOsPPd8tj0JuNFkidPor3dfw8EnrZlxsPw==
X-Received: by 2002:a05:6402:1ed2:b0:5cf:e13b:eec1 with SMTP id 4fb4d7f45d1cf-5d0205a80cfmr2611706a12.3.1732281921974;
        Fri, 22 Nov 2024 05:25:21 -0800 (PST)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d02939a593sm403453a12.88.2024.11.22.05.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:25:21 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: stgraber@stgraber.org,
	tycho@tycho.pizza,
	cyphar@cyphar.com,
	yun.zhou@windriver.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH v2 2/2] tests/pid_namespace: add pid_max tests
Date: Fri, 22 Nov 2024 14:24:59 +0100
Message-ID: <20241122132459.135120-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com>
References: <20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <christian.brauner@ubuntu.com>

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 .../selftests/pid_namespace/.gitignore        |   1 +
 .../testing/selftests/pid_namespace/Makefile  |   2 +-
 .../testing/selftests/pid_namespace/pid_max.c | 358 ++++++++++++++++++
 3 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/pid_namespace/pid_max.c

diff --git a/tools/testing/selftests/pid_namespace/.gitignore b/tools/testing/selftests/pid_namespace/.gitignore
index 93ab9d7e5b7e..5118f0f3edf4 100644
--- a/tools/testing/selftests/pid_namespace/.gitignore
+++ b/tools/testing/selftests/pid_namespace/.gitignore
@@ -1 +1,2 @@
+pid_max
 regression_enomem
diff --git a/tools/testing/selftests/pid_namespace/Makefile b/tools/testing/selftests/pid_namespace/Makefile
index 9286a1d22cd3..b972f55d07ae 100644
--- a/tools/testing/selftests/pid_namespace/Makefile
+++ b/tools/testing/selftests/pid_namespace/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -g $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS = regression_enomem
+TEST_GEN_PROGS = regression_enomem pid_max
 
 LOCAL_HDRS += $(selfdir)/pidfd/pidfd.h
 
diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
new file mode 100644
index 000000000000..51c414faabb0
--- /dev/null
+++ b/tools/testing/selftests/pid_namespace/pid_max.c
@@ -0,0 +1,358 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/wait.h>
+
+#include "../kselftest_harness.h"
+#include "../pidfd/pidfd.h"
+
+#define __STACK_SIZE (8 * 1024 * 1024)
+static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
+{
+	char *stack;
+	pid_t ret;
+
+	stack = malloc(__STACK_SIZE);
+	if (!stack)
+		return -ENOMEM;
+
+#ifdef __ia64__
+	ret = __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg);
+#else
+	ret = clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg);
+#endif
+	free(stack);
+	return ret;
+}
+
+static int pid_max_cb(void *data)
+{
+	int fd, ret;
+	pid_t pid;
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return -1;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return -1;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return -1;
+	}
+
+	ret = write(fd, "500", sizeof("500") - 1);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return -1;
+	}
+
+	for (int i = 0; i < 501; i++) {
+		pid = fork();
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
+		wait_for_pid(pid);
+		if (pid > 500) {
+			fprintf(stderr, "Managed to create pid number beyond limit\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int pid_max_nested_inner(void *data)
+{
+	int fret = -1;
+	pid_t pids[2];
+	int fd, i, ret;
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return fret;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return fret;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return fret;
+	}
+
+	ret = write(fd, "500", sizeof("500") - 1);
+	close(fd);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return fret;
+	}
+
+	pids[0] = fork();
+	if (pids[0] < 0) {
+		fprintf(stderr, "Failed to create first new process\n");
+		return fret;
+	}
+
+	if (pids[0] == 0)
+		exit(EXIT_SUCCESS);
+
+	pids[1] = fork();
+	wait_for_pid(pids[0]);
+	if (pids[1] >= 0) {
+		if (pids[1] == 0)
+			exit(EXIT_SUCCESS);
+		wait_for_pid(pids[1]);
+
+		fprintf(stderr, "Managed to create process even though ancestor pid namespace had a limit\n");
+		return fret;
+	}
+
+	/* Now make sure that we wrap pids at 400. */
+	for (i = 0; i < 510; i++) {
+		pid_t pid;
+
+		pid = fork();
+		if (pid < 0)
+			return fret;
+
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
+
+		wait_for_pid(pid);
+		if (pid >= 500) {
+			fprintf(stderr, "Managed to create process with pid %d beyond configured limit\n", pid);
+			return fret;
+		}
+	}
+
+	return 0;
+}
+
+static int pid_max_nested_outer(void *data)
+{
+	int fret = -1, nr_procs = 400;
+	pid_t pids[1000];
+	int fd, i, ret;
+	pid_t pid;
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return fret;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return fret;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return fret;
+	}
+
+	ret = write(fd, "400", sizeof("400") - 1);
+	close(fd);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return fret;
+	}
+
+	/*
+	 * Create 397 processes. This leaves room for do_clone() (398) and
+	 * one more 399. So creating another process needs to fail.
+	 */
+	for (nr_procs = 0; nr_procs < 396; nr_procs++) {
+		pid = fork();
+		if (pid < 0)
+			goto reap;
+
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
+
+		pids[nr_procs] = pid;
+	}
+
+	pid = do_clone(pid_max_nested_inner, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	if (pid < 0) {
+		fprintf(stderr, "%m - Failed to clone nested pidns\n");
+		goto reap;
+	}
+
+	if (wait_for_pid(pid)) {
+		fprintf(stderr, "%m - Nested pid_max failed\n");
+		goto reap;
+	}
+
+	fret = 0;
+
+reap:
+	for (int i = 0; i < nr_procs; i++)
+		wait_for_pid(pids[i]);
+
+	return fret;
+}
+
+static int pid_max_nested_limit_inner(void *data)
+{
+	int fret = -1, nr_procs = 400;
+	int fd, ret;
+	pid_t pid;
+	pid_t pids[1000];
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return fret;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return fret;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return fret;
+	}
+
+	ret = write(fd, "500", sizeof("500") - 1);
+	close(fd);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return fret;
+	}
+
+	for (nr_procs = 0; nr_procs < 500; nr_procs++) {
+		pid = fork();
+		if (pid < 0)
+			break;
+
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
+
+		pids[nr_procs] = pid;
+	}
+
+	if (nr_procs >= 400) {
+		fprintf(stderr, "Managed to create processes beyond the configured outer limit\n");
+		goto reap;
+	}
+
+	fret = 0;
+
+reap:
+	for (int i = 0; i < nr_procs; i++)
+		wait_for_pid(pids[i]);
+
+	return fret;
+}
+
+static int pid_max_nested_limit_outer(void *data)
+{
+	int fd, ret;
+	pid_t pid;
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
+		return -1;
+	}
+
+	umount2("/proc", MNT_DETACH);
+
+	ret = mount("proc", "/proc", "proc", 0, NULL);
+	if (ret) {
+		fprintf(stderr, "%m - Failed to mount proc\n");
+		return -1;
+	}
+
+	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
+	if (fd < 0) {
+		fprintf(stderr, "%m - Failed to open pid_max\n");
+		return -1;
+	}
+
+	ret = write(fd, "400", sizeof("400") - 1);
+	close(fd);
+	if (ret < 0) {
+		fprintf(stderr, "%m - Failed to write pid_max\n");
+		return -1;
+	}
+
+	pid = do_clone(pid_max_nested_limit_inner, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	if (pid < 0) {
+		fprintf(stderr, "%m - Failed to clone nested pidns\n");
+		return -1;
+	}
+
+	if (wait_for_pid(pid)) {
+		fprintf(stderr, "%m - Nested pid_max failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+TEST(pid_max_simple)
+{
+	pid_t pid;
+
+
+	pid = do_clone(pid_max_cb, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	ASSERT_GT(pid, 0);
+	ASSERT_EQ(0, wait_for_pid(pid));
+}
+
+TEST(pid_max_nested_limit)
+{
+	pid_t pid;
+
+	pid = do_clone(pid_max_nested_limit_outer, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	ASSERT_GT(pid, 0);
+	ASSERT_EQ(0, wait_for_pid(pid));
+}
+
+TEST(pid_max_nested)
+{
+	pid_t pid;
+
+	pid = do_clone(pid_max_nested_outer, NULL, CLONE_NEWPID | CLONE_NEWNS);
+	ASSERT_GT(pid, 0);
+	ASSERT_EQ(0, wait_for_pid(pid));
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0


