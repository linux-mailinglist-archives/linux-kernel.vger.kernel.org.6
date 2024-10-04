Return-Path: <linux-kernel+bounces-351361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0D4991005
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF3A284D36
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B51E0E05;
	Fri,  4 Oct 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZkxIVZu"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7831E0DDA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071282; cv=none; b=efZrFTofxb2FqymC8cudvvx1dt9YEnug10GrRpBf4K2V7Hm+8ytexj4Wbbjylf97BGkJtj6mE7L9S+7FCja19MBiEB2jh8n+/h8GUwq3Cwluv9xnOdPU0wB28Y63s3oJv2Eq1dXe1V8GTebqwTnpql5vOe3J7jAWO3+fw4wMfLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071282; c=relaxed/simple;
	bh=VY/hRY8i9++4TS9FUJxR8tGWUYC/CJStwEAyhlk+Em4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNHmkmLJfgiHwrgicxGXoBa6kG+3QQCbt/AILxSn4AzAt17pFHA0MC8416a9FYwEqeajAOfNGV3YGDoa32THJQHa3raR077YfWOR/jkYpxbX8dcrv/Yb19s9KpNjR1mN0ftxyMALP4sOwrZUHvvPGqfW2x7siFog5i1IljNvUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZkxIVZu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso21924645e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728071279; x=1728676079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7UznPqTvN7fqfKJJRYWFcLZq36QxAU7mZZHzGCL2ja0=;
        b=eZkxIVZudcQsZ+odGIk0F+RWzgsZwqeoomJBSJwqMfA5yW2G/vE2l703jTA72lhKWa
         zZRKit3+sYcmV3jxJ5nCdqchtW26PmtAou16CiCq0i4FFLghX34QlNJVshNJ2iJ2kMp9
         e5hyFjag4TXdeVq3DVUawg+iGh6s40YWFAtfSVxSP76zagmLv0aOuaDaIEgpLo9YOSjn
         65WWMGnu6XE9yyEYqhWbGQrZK3v5/h9WNowRfIcJA2AREfO3PdDJfgCcbwIPP25uDWc8
         RHMVWAofgsH9kkKpq8f6m9E0abOkOtIHgVKWYuoD3TcLVr9mQ2XvfTVEBmvfRvHhX3hs
         aa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728071279; x=1728676079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UznPqTvN7fqfKJJRYWFcLZq36QxAU7mZZHzGCL2ja0=;
        b=QE7gkNNZn1PEsWMV97bLViQNIt3wveDt2gOs+JfkYJ9go0RWQEMlZOtWWLJcdzyGDJ
         bNRwV8VcWPUsHt9BUonVbIrMbrTsFq/ahFPb6C0miSzBEudPH2hgosf15kR+wLRfZ6lw
         kJuCgwp5pL2+yPFPo5O+tZ4AU05u8UGhSMomxgrkdH/jS6g31vbBTpJbZQHHTg2vCjGM
         wHsAPwG8+vV4HXLJUihKYDqlRJbta6syAoIFSM3SzPUcpuQSUSr3mIjnBiSoJLKwNGqV
         9QXTGPmjBpN9teWMVJ4aFiaN2BCgteJ2fp08cMFYh9QmnTt617is3YCHzgbtJGi6ZWnb
         CiQw==
X-Gm-Message-State: AOJu0Ywd6jyhsAbcSst+PZLCK5efLMerlAmc0scWD7oSvh0+vgVHXVXD
	ARfR1NoWSUzkqsZp+vPRMWky/wpCv/xfeUTCCj82A+EHsgPynBHPxGT04Q==
X-Google-Smtp-Source: AGHT+IFpnQAIJjL0w+k/3Ji8xBHfaLwd1U1g6lJBNDs19YI0NW67s4CTS4DLKdxJVEAdSAExQDmImg==
X-Received: by 2002:a05:600c:350c:b0:42c:b750:19ce with SMTP id 5b1f17b1804b1-42f85aa33bemr28276615e9.1.1728071278383;
        Fri, 04 Oct 2024 12:47:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:a3f4:1a10:8066:7b14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b445d2sm22665945e9.36.2024.10.04.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 12:47:57 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-kernel@vger.kernel.org
Cc: christian@brauner.io
Subject: [PATCH v4] pidfd: add ioctl to retrieve pid info
Date: Fri,  4 Oct 2024 20:47:03 +0100
Message-ID: <20241004194751.215507-1-luca.boccassi@gmail.com>
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
v4: fix arg check in pidfd_ioctl() by moving it after the new call
v3: switch from pid_vnr() to task_pid_vnr()
v2: Apply comments from Christian, apart from the one about pid namespaces
    as I need additional hints on how to implement it.
    Drop the security_context string as it is not the appropriate
    metadata to give userspace these days.

 fs/pidfs.c                                    | 70 +++++++++++++++-
 include/uapi/linux/pidfd.h                    | 24 ++++++
 .../testing/selftests/pidfd/pidfd_open_test.c | 81 ++++++++++++++++++-
 3 files changed, 171 insertions(+), 4 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7ffdc88dfb52..9ef63c1053d4 100644
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
@@ -114,6 +115,65 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
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
+	if (request_mask & PIDFD_INFO_CGROUPID) {
+		struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
+		if (!cgrp)
+			return -ENODEV;
+
+		kinfo.cgroupid = cgroup_id(cgrp);
+		kinfo.result_mask |= PIDFD_INFO_CGROUPID;
+	}
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
@@ -121,13 +181,17 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
-- 
2.45.2


