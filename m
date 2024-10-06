Return-Path: <linux-kernel+bounces-352632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872359921B7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454FD281395
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764EB18A940;
	Sun,  6 Oct 2024 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb7WXZu4"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8C43AB3
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250538; cv=none; b=mQCh9+f2tHqU4bnQRMuW7AtOakLljTeSfsoVcKMPBtwxgcvqleLX07B1eooekgPr6WQXjQTGJvnB3eMRTPhgE0gRcLK0UxruwahxJGoYl7H0f2njXFpr/ICDEKO9zsf8pDLixoKpmONvnxe1Px2KoCqo7NcxTqy1UT9eopX2dmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250538; c=relaxed/simple;
	bh=icVhxF8E3MZ/MaKSgdXdhgbUPs5q5Q1GiptZD2M4/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAGeZdv2ItYO7C/J/TYRTCtSmDJ+WkYzQrEO9nQyCIKZxGHIkIGmWUce3ugkyAC88G7re/xW/cB3+gVeqnOoIxF3OVChyxTqox5Ql0oMP75L77xa3XQ7qRsGS/y+sUkx8SK0oH4BrzYFjnav50UuQBCu2St247TLOQEPHPzJgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb7WXZu4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cdac05af9so3665122f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728250534; x=1728855334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hIaW/3qHfbHhJFKr+CerQjJ+0l3T1+N5aMcLiWAgkBg=;
        b=Vb7WXZu4p5MEMWMoEt8Nj2dDqW9WXM/ObNqFMyvOcMMF/GZel5/4TkSVF2yGfY+blp
         S2KII7YJKnQMp7WEVDvr4rwwFBeY+LmSII4/hFngkT2yGbox1cSctdm72pgLeqSOwHqU
         gCFQiJ1YEZpZYqLuJuXeLcUCW6FQDNCG0HkjI4Y+r8VPNskH2MMXL5JgTo5/xCQcoNtR
         r2S1crTpBMvBv9QLxN6/VuyiYj/s158h/0aZ/slVO4GzmOwfSo5os6DTcturGmJR8OtG
         4Ab0/mrTYjdWzWloM9u7ub6W98QAj7iWkaA/eH2mwQslXe+tq166G2R6qvPgVz8Bdlqq
         FQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728250534; x=1728855334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIaW/3qHfbHhJFKr+CerQjJ+0l3T1+N5aMcLiWAgkBg=;
        b=dATgFhxAUWHWBfukpUU0iv3F1oz6j/38CJUhviktNKRKSvqJF/ApIUEeUzld462Boh
         oncG1dGeWlwMstoFlX/YNXN6tXG7b6rsKG71OR4WTp58LuPpBBuPT1FqNcyMDzoOZZXW
         wmFwU64uNpgS8PZ3dm6HZIro6oRzeSGQbIHTkvjxY+KSaSsm6xZBKzLsmU/wEJKFkCk1
         PNcnHY6oKKzKdsl7W9UXxLlHvdk2jfQhtUBCO7yi3eGEN3CaBj1P9yld2U2hpqyT53Nf
         vQ2Z6/JoPV643Ui18ILeQ9/xVzjWIY7DBHc79Zor63rNjnFLe9UIdcOKbWLG24jAiBuH
         1BBw==
X-Gm-Message-State: AOJu0YzWEeVdxNpN8N60SMIcc/pXV6x3a7vzLdfTkEip4a8ZGuDnOrFT
	xfPMfQvkpvXbADUnFZW67jECJbvmLEZGgrUWIN8cNt+WUfi2HAlQVye5Bw==
X-Google-Smtp-Source: AGHT+IFC3owJlKQ1IjCcn8QEvg7v3+qQtq4+YuRiCuPZoqjzfDvE/8HDCczYfMxCRf0ovNklXSs6xw==
X-Received: by 2002:adf:a39d:0:b0:374:bde8:66af with SMTP id ffacd0b85a97d-37d0eaea911mr8038844f8f.57.1728250533901;
        Sun, 06 Oct 2024 14:35:33 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:21cd:def0:a01d:d2aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1688a486sm4333055f8f.0.2024.10.06.14.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 14:35:32 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-kernel@vger.kernel.org
Cc: christian@brauner.io,
	oleg@redhat.com
Subject: [PATCH v6] pidfd: add ioctl to retrieve pid info
Date: Sun,  6 Oct 2024 22:33:23 +0100
Message-ID: <20241006213530.335087-1-luca.boccassi@gmail.com>
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
v6: use rcu_read_lock() when fetching cgroupid, use task_ppid_nr_ns() to
    get the ppid, return ESCHR if any of pid/tgid/ppid are 0 at the end
    of the call to avoid providing incomplete data, document what the
    callers should expect
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

 fs/pidfs.c                                    | 86 ++++++++++++++++++-
 include/uapi/linux/pidfd.h                    | 31 +++++++
 .../testing/selftests/pidfd/pidfd_open_test.c | 81 ++++++++++++++++-
 3 files changed, 194 insertions(+), 4 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7ffdc88dfb52..80ea186ed6bb 100644
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
@@ -114,6 +115,81 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
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
+		rcu_read_lock();
+		struct cgroup *cgrp = task_cgroup(task, pids_cgrp_id);
+		if (!cgrp)
+			return -ENODEV;
+		kinfo.cgroupid = cgroup_id(cgrp);
+		rcu_read_unlock();
+
+		kinfo.result_mask |= PIDFD_INFO_CGROUPID;
+	}
+#endif
+
+	/*
+	 * Copy pid/tgid last, to reduce the chances the information might be
+	 * stale. Note that it is not possible to ensure it will be valid as the
+	 * task might return as soon as the copy_to_user finishes, but that's ok
+	 * and userspace expects that might happen and can act accordingly, so
+	 * this is just best-effort. What we can do however is checking that all
+	 * the fields are set correctly, or return ESRCH to avoid providing
+	 * incomplete information. */
+
+	kinfo.ppid = task_ppid_nr_ns(task, NULL);
+	kinfo.tgid = task_tgid_vnr(task);
+	kinfo.pid = task_pid_vnr(task);
+
+	if (kinfo.pid == 0 || kinfo.tgid == 0 || (kinfo.ppid == 0 && kinfo.pid != 1))
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
@@ -121,13 +197,17 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
index 565fc0629fff..24b25cd52ab3 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -16,6 +16,36 @@
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
+	/*
+	 * The information contained in the following fields might be stale at the
+	 * time it is received, as the target process might have exited as soon as
+	 * the IOCTL was processed, and there is no way to avoid that. However, it
+	 * is guaranteed that if the call was successful, then the information was
+	 * correct and referred to the intended process at the time the work was
+	 * performed. */
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
@@ -28,5 +58,6 @@
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


