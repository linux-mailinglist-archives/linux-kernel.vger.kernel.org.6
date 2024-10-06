Return-Path: <linux-kernel+bounces-352437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F183991F27
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D34C1C20DA6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670E138490;
	Sun,  6 Oct 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqcY0WKI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3481F94A
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226662; cv=none; b=EbV18Uc/molrLZr22NV441rJwi8x2lVLxNgaAtQaBWwvUZRc33LdzGRMF7Pg2mEy+XKzITwvkaEgispc4wnWPA8MUza6qsPnOal5zvpU9COjvBN1rQo31IIZgw4JBIHhKoJ5gQRf+j9nCBBdEMs5mh+Av9klKNRe/iqQg6yPHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226662; c=relaxed/simple;
	bh=EkHoYNfLwld1krGtj2AcJOMfnYdz0xJ11kkx6o9ntx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRxq6qHNRtjbE/0IGFbVGu6CHNajiNJBFmk8V0Qln6najIeCjOnDFV9Wb75zcn7qRhVBJ5e6iMlVACormStepB2JjamJRdIBIlQeMvf8gXOUQSL8BhVgcyZsiO2xCAI4DNCUipJAseyr+xg/bc5dmg+uN7Zhqgh04A5PvZsRnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqcY0WKI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so35570855e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728226658; x=1728831458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oCJgVQBVNvZMStAu3upbnnf0xMOZVZO95G8yMRFEyo=;
        b=NqcY0WKIR0vPNAvEZO0wZsDsyL05YDpaZlikX/0xHRPTkN9KOlVCpVEjRAFnLl0ToV
         We06uB9lLgZXe5wT0B+pP5frbm3incIghE8VYUqvlS2xkn7JWcX4r/HDvq/STsIP1erK
         4dhZ8DCPDFv0/mGPC8EIMx2nIGTj5qEBbHPNRNLedtS/20Ddum7SUSV2wxLbuP20NipN
         FHvRbOxnKbWHED1+6KmAARBXoiRBQ7R2tEDNU9+tG0gLZXkCkUh+jxsHlqFB/ZT1Yjhe
         YbEri8keYNOievuWM2ecHLA+iGd+LQhiA/a1Ir6f2nBVJr/zobUxtlBa9WSNUMGY89Gr
         vHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226658; x=1728831458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oCJgVQBVNvZMStAu3upbnnf0xMOZVZO95G8yMRFEyo=;
        b=sYneaivEHmiSmze5gNbTn69TNstMM7qerzFJWaIZ43HtdeGArU2tInRycqpYWrZrZZ
         BKq6Uirso5N07tU3Hbks+UNrVKS8sodZXzm9hWwkdyrsgjgCdhOxqauIbR0MXHrfW1DQ
         l7bT1HbLI+c50jqwpE7cg+spxJjs/utqHq5cL/c1mL3etJCNB9TcjdAcH6oUIjibYGJj
         0kpKyXwGkbucZsUqg7o3XKwce70nAVWxLtgUfwCQrKfoWih9Te6xLKWN48SWVA8JOaty
         H18olJuk+1+ijfpcJC/Qz+b4qN/KV4fX40VUvgT6zjREYubyUo13m/E76SYE2xvrIoOR
         zkpQ==
X-Gm-Message-State: AOJu0YxJnz+4onujqqTRJZWXy7uC28LZp6MEcGfKpZCmTg44maedVAZd
	KxUpYh/Kq4QqUw5fFO4YSdG3cP11sCSwBZmpAEGtOt2clqm8DGC3bVeNkw==
X-Google-Smtp-Source: AGHT+IFA5oJd4iVDXtJqxfXlBc2uajc7+b/3RTtZjPewGHaVP0fF2Yz/gJ44nz511m2aR6Hs1CqrFQ==
X-Received: by 2002:a05:600c:68d9:b0:42f:512f:fafc with SMTP id 5b1f17b1804b1-42f8947de8dmr51357725e9.29.1728226657954;
        Sun, 06 Oct 2024 07:57:37 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:21cd:def0:a01d:d2aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8d133a4bsm35372385e9.5.2024.10.06.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 07:57:36 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-kernel@vger.kernel.org
Cc: christian@brauner.io,
	oleg@redhat.com
Subject: [PATCH v5] pidfd: add ioctl to retrieve pid info
Date: Sun,  6 Oct 2024 15:54:55 +0100
Message-ID: <20241006145727.291401-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <luca.boccassi@gmail.com>

A common pattern when using pid fds is having to get information
about the process, which currently requires /proc being mounted,
resolving the fd to a pid, and then do manual string parsing of
/proc/N/status and friends. This needs to be reimplemented over
and over in all userspace projects (e.g.: I have reimplemented
resolving in systemd, dbus, dbus-daemon, polkit so far), and
requires additional care in checking that the fd is still valid
after having parsed the data, to avoid races.

Having a programmatic API that can be used directly removes all
these requirements, including having /proc mounted.

As discussed at LPC24, add an ioctl with an extensible struct
so that more parameters can be added later if needed. Start with
returning pid/tgid/ppid and creds unconditionally, and cgroupid
optionally.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
v5: check again that the task hasn't exited immediately before copying
    the result out to userspace, to ensure we are not returning stale data
    add an ifdef around the cgroup structs usage to fix build errors when
    the feature is disabled
v4: fix arg check in pidfd_ioctl() by moving it after the new call
v3: switch from pid_vnr() to task_pid_vnr()
v2: Apply comments from Christian, apart from the one about pid namespaces
    as I need additional hints on how to implement it.
    Drop the security_context string as it is not the appropriate
    metadata to give userspace these days.

 fs/pidfs.c                                    | 78 +++++++++++++++++-
 include/uapi/linux/pidfd.h                    | 24 ++++++
 .../testing/selftests/pidfd/pidfd_open_test.c | 81 ++++++++++++++++++-
 3 files changed, 179 insertions(+), 4 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7ffdc88dfb52..47868c3baf5f 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -2,6 +2,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/cgroup.h>
 #include <linux/magic.h>
 #include <linux/mount.h>
 #include <linux/pid.h>
@@ -114,6 +115,73 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
+static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
+{
+	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
+	size_t usize = _IOC_SIZE(cmd);
+	struct pidfd_info kinfo = {};
+	struct user_namespace *user_ns;
+	const struct cred *c;
+	__u64 request_mask;
+
+	if (!uinfo)
+		return -EINVAL;
+	if (usize < sizeof(struct pidfd_info))
+		return -EINVAL; /* First version, no smaller struct possible */
+
+	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
+		return -EFAULT;
+
+	c = get_task_cred(task);
+	if (!c)
+		return -ESRCH;
+
+	/* Unconditionally return identifiers and credentials, the rest only on request */
+
+	kinfo.pid = task_pid_vnr(task);
+	kinfo.tgid = task_tgid_vnr(task);
+	kinfo.ppid = task_ppid_nr_ns(task, task_active_pid_ns(task));
+
+	user_ns = current_user_ns();
+	kinfo.ruid = from_kuid_munged(user_ns, c->uid);
+	kinfo.rgid = from_kgid_munged(user_ns, c->gid);
+	kinfo.euid = from_kuid_munged(user_ns, c->euid);
+	kinfo.egid = from_kgid_munged(user_ns, c->egid);
+	kinfo.suid = from_kuid_munged(user_ns, c->suid);
+	kinfo.sgid = from_kgid_munged(user_ns, c->sgid);
+	kinfo.fsuid = from_kuid_munged(user_ns, c->fsuid);
+	kinfo.fsgid = from_kgid_munged(user_ns, c->fsgid);
+
+#ifdef CONFIG_CGROUPS
+	if (request_mask & PIDFD_INFO_CGROUPID) {
+		struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
+		if (!cgrp)
+			return -ENODEV;
+
+		kinfo.cgroupid = cgroup_id(cgrp);
+		kinfo.result_mask |= PIDFD_INFO_CGROUPID;
+	}
+#endif
+
+	/*
+	 * One last check before returning: the task might have exited while we
+	 * were fetching all the data, so check again to be safe. */
+	if (task_pid_vnr(task) == 0)
+		return -ESRCH;
+
+	/*
+	 * If userspace and the kernel have the same struct size it can just
+	 * be copied. If userspace provides an older struct, only the bits that
+	 * userspace knows about will be copied. If userspace provides a new
+	 * struct, only the bits that the kernel knows about will be copied and
+	 * the size value will be set to the size the kernel knows about.
+	 */
+	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct task_struct *task __free(put_task) = NULL;
@@ -121,13 +189,17 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct pid *pid = pidfd_pid(file);
 	struct ns_common *ns_common = NULL;
 
-	if (arg)
-		return -EINVAL;
-
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task)
 		return -ESRCH;
 
+	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
+	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
+		return pidfd_info(task, cmd, arg);
+
+	if (arg)
+		return -EINVAL;
+
 	scoped_guard(task_lock, task) {
 		nsp = task->nsproxy;
 		if (nsp)
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..f278db1a3fe8 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -16,6 +16,29 @@
 #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
 #define PIDFD_SIGNAL_PROCESS_GROUP	(1UL << 2)
 
+/* Flags for pidfd_info. */
+#define PIDFD_INFO_CGROUPID		(1UL << 0)
+
+struct pidfd_info {
+	/* Let userspace request expensive stuff explictly. */
+	__u64 request_mask;
+	/* And let the kernel indicate whether it knows about it. */
+	__u64 result_mask;
+	__u64 cgroupid;
+	__u32 pid;
+	__u32 tgid;
+	__u32 ppid;
+	__u32 ruid;
+	__u32 rgid;
+	__u32 euid;
+	__u32 egid;
+	__u32 suid;
+	__u32 sgid;
+	__u32 fsuid;
+	__u32 fsgid;
+	__u32 spare0[1];
+};
+
 #define PIDFS_IOCTL_MAGIC 0xFF
 
 #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
@@ -28,5 +51,6 @@
 #define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
+#define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
 
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index c62564c264b1..30c50a8ae10b 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/wait.h>
@@ -21,6 +22,35 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
+#ifndef PIDFS_IOCTL_MAGIC
+#define PIDFS_IOCTL_MAGIC 0xFF
+#endif
+
+#ifndef PIDFD_GET_INFO
+#define PIDFD_GET_INFO _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
+#define PIDFD_INFO_CGROUPID		(1UL << 0)
+
+struct pidfd_info {
+	/* Let userspace request expensive stuff explictly. */
+	__u64 request_mask;
+	/* And let the kernel indicate whether it knows about it. */
+	__u64 result_mask;
+	__u64 cgroupid;
+	__u32 pid;
+	__u32 tgid;
+	__u32 ppid;
+	__u32 ruid;
+	__u32 rgid;
+	__u32 euid;
+	__u32 egid;
+	__u32 suid;
+	__u32 sgid;
+	__u32 fsuid;
+	__u32 fsgid;
+	__u32 spare0[1];
+};
+#endif
+
 static int safe_int(const char *numstr, int *converted)
 {
 	char *err = NULL;
@@ -120,10 +150,13 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
 
 int main(int argc, char **argv)
 {
+	struct pidfd_info info = {
+		.request_mask = PIDFD_INFO_CGROUPID,
+	};
 	int pidfd = -1, ret = 1;
 	pid_t pid;
 
-	ksft_set_plan(3);
+	ksft_set_plan(4);
 
 	pidfd = sys_pidfd_open(-1, 0);
 	if (pidfd >= 0) {
@@ -153,6 +186,52 @@ int main(int argc, char **argv)
 	pid = get_pid_from_fdinfo_file(pidfd, "Pid:", sizeof("Pid:") - 1);
 	ksft_print_msg("pidfd %d refers to process with pid %d\n", pidfd, pid);
 
+	if (ioctl(pidfd, PIDFD_GET_INFO, &info) < 0) {
+		ksft_print_msg("%s - failed to get info from pidfd\n", strerror(errno));
+		goto on_error;
+	}
+	if (info.pid != pid) {
+		ksft_print_msg("pid from fdinfo file %d does not match pid from ioctl %d\n",
+			       pid, info.pid);
+		goto on_error;
+	}
+	if (info.ppid != getppid()) {
+		ksft_print_msg("ppid %d does not match ppid from ioctl %d\n",
+			       pid, info.pid);
+		goto on_error;
+	}
+	if (info.ruid != getuid()) {
+		ksft_print_msg("uid %d does not match uid from ioctl %d\n",
+			       getuid(), info.ruid);
+		goto on_error;
+	}
+	if (info.rgid != getgid()) {
+		ksft_print_msg("gid %d does not match gid from ioctl %d\n",
+			       getgid(), info.rgid);
+		goto on_error;
+	}
+	if (info.euid != geteuid()) {
+		ksft_print_msg("euid %d does not match euid from ioctl %d\n",
+			       geteuid(), info.euid);
+		goto on_error;
+	}
+	if (info.egid != getegid()) {
+		ksft_print_msg("egid %d does not match egid from ioctl %d\n",
+			       getegid(), info.egid);
+		goto on_error;
+	}
+	if (info.suid != geteuid()) {
+		ksft_print_msg("suid %d does not match suid from ioctl %d\n",
+			       geteuid(), info.suid);
+		goto on_error;
+	}
+	if (info.sgid != getegid()) {
+		ksft_print_msg("sgid %d does not match sgid from ioctl %d\n",
+			       getegid(), info.sgid);
+		goto on_error;
+	}
+	ksft_test_result_pass("get info from pidfd test: passed\n");
+
 	ret = 0;
 
 on_error:

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
prerequisite-patch-id: 45816348e644743f5a8bb09432fdbf6f2178a1c9
prerequisite-patch-id: 73310122c17be3fb2d53df26a9a0cb0beb5bb944
prerequisite-patch-id: 780fb5316cd3fd1bc110acb73985e82bc650dc46
prerequisite-patch-id: a4c617e4f5cc53939d7eaa5e35910f36ac181f2e
prerequisite-patch-id: cb4ea39b845078ff57ab562c58f22cc7e86a8690
-- 
2.45.2


