Return-Path: <linux-kernel+bounces-347696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB198DB5A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665851C2295C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EDB1D2B07;
	Wed,  2 Oct 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzIbxPYh"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE41D1E7C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879127; cv=none; b=Btt8wqCWcPIvVR026BbIBU85zS7IBQGJc/I2eRDJQ9R7pGAiM+kKOF9NiOoH/UuEezsxNX0Wi02zbGvgaAcdsYgNdrKs/zOchht7ihPzWz8iAZxMmk501U4UFoCjpXX1uhvlMfYJp2kRrrQEBwQ3vvJRq1BOnVf9VvnmhlX4irU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879127; c=relaxed/simple;
	bh=MfWKONjYwC3OKiVBJ6AediRI94amSIV0Sf4FWHOdMC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDXQnBaHMpaovuE6lOhy90wsYNyP3DhaB4PuuxyF8XbDJQGkydgMhkx7qzBSYTka0vxCf9ea6dmDjW4CvRfr+Jyn5aB4Ql0WHLc+dtbcCFsYoZkXv8Eu8ZkuuAUna7PXQX7CZrsj8vPsPjPOxMdUWxYdxM4WGi09EFl1tf50kzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzIbxPYh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccc597b96so4375975f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727879124; x=1728483924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEy78MMGgfUgieJiJ7qUZCA/YMtxmSzIAj+f0T4zCgI=;
        b=jzIbxPYh1QJ4b3i8EB+Q5jlFbtAz8v4wgytDeHaeLPL5PTbT05+5yngkGNEmCn0SI3
         cZfpRn51BF2aB++rrCLHoqidScFw6VlwihG1vok3mvNezuUWzch71J1RH1RoPsysiAfc
         sdsJdStrmv8VSsmpWFoRBReu32e4fZw310iD2ZULOnK7tnnaDNTBN1867nMtzJnVKPsr
         Ce6pYOUMV3SD0eqNE0p3ARHUTJVIJKq4Cl9LcV8q+zXORjzQaxM1ZOWHvKJgXkRg5WAD
         bLADkStWWPBjEeVL3/EZ/K5/ZWJnwESKwIIx6yhI7tmVaeHqkSn7232XWKtQ1gjiW6ZW
         PRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879124; x=1728483924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEy78MMGgfUgieJiJ7qUZCA/YMtxmSzIAj+f0T4zCgI=;
        b=eXIzV+djaH1iY3eSvPd9LMlp6x+C2Gd6klIw5nmkQB03WrUqZz+Uyb99+0aVFg4091
         uiPex38dS0umU1Fyk4aEmjcCowglPKCVlhLh7zeqrvz5LxjeR8bK4yyECC6Ra/180tgP
         oNU0g6F7CEv4L7UQmy0O0+pPIDodQ6fhvvcH8cuqx+tX/vq4waSFPDCOgJTxKTRUish6
         2NaiG6n20lT0uIPCQ9RASPADvytKddoLZcAiDk5BgXTUCo6SwRcVTgx0UfXv+cwb9tKx
         hCoeGqzR6KPOtj0LP04h055YOpPLL9/woCG5B4nD1wUc0ppz5mFCeHR8KyY9xSBrJbK9
         u3Hw==
X-Gm-Message-State: AOJu0YxM419av+FU7vJnKOePJsdjopivi9kFR2ySRgCEyxB3MBfVKd8D
	dzcG0VBw0vn5N+DZFj4vKxSJYzpCVoW7KVtGQXGCgC2/lQMi8C66IvlCAg==
X-Google-Smtp-Source: AGHT+IGXxa7dZf4AH4XxNaUU7v7mLjt2MXKi6abm+vUi0Qqn/vg9UfgFGbe6Rp+iAMPpzhtwJJrOZA==
X-Received: by 2002:adf:e784:0:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-37cfba078a4mr2615283f8f.41.1727879123410;
        Wed, 02 Oct 2024 07:25:23 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e5c8:48db:20cf:1413])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d348sm14099310f8f.8.2024.10.02.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:25:22 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-kernel@vger.kernel.org
Cc: christian@brauner.io,
	paul@paul-moore.com
Subject: [PATCH] pidfd: add ioctl to retrieve pid info
Date: Wed,  2 Oct 2024 15:24:33 +0100
Message-ID: <20241002142516.110567-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

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
exposing: pid, uid, gid, groupid, security label (the latter was
requested by the LSM maintainer).

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 fs/pidfs.c                                    | 61 ++++++++++++++++++-
 include/uapi/linux/pidfd.h                    | 17 ++++++
 .../testing/selftests/pidfd/pidfd_open_test.c | 50 ++++++++++++++-
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7ffdc88dfb52..dd386d37309c 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -114,6 +114,62 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
+static long pidfd_info(struct task_struct *task, struct pid *pid, unsigned long arg)
+{
+	struct pidfd_info uinfo = {}, info = {};
+
+	if (copy_from_user(&uinfo, (struct pidfd_info *)arg, sizeof(struct pidfd_info)))
+		return -EFAULT;
+	if (uinfo.size > sizeof(struct pidfd_info))
+		return -E2BIG;
+	if (uinfo.size < sizeof(struct pidfd_info))
+		return -EINVAL; /* First version, no smaller struct possible */
+
+	if (uinfo.request_mask & ~(PIDFD_INFO_PID | PIDFD_INFO_CREDS | PIDFD_INFO_CGROUPID | PIDFD_INFO_SECURITY_CONTEXT))
+		return -EINVAL;
+
+	memcpy(&info, &uinfo, uinfo.size);
+
+	if (uinfo.request_mask & PIDFD_INFO_PID)
+		info.pid = pid_nr_ns(pid, task_active_pid_ns(task));
+
+	if (uinfo.request_mask & PIDFD_INFO_CREDS) {
+		const struct cred *c = get_task_cred(task);
+		if (!c)
+			return -ESRCH;
+
+		info.uid = from_kuid_munged(current_user_ns(), c->uid);
+		info.gid = from_kgid_munged(current_user_ns(), c->gid);
+	}
+
+	if (uinfo.request_mask & PIDFD_INFO_CGROUPID) {
+		struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
+		if (!cgrp)
+			return -ENODEV;
+
+		info.cgroupid = cgroup_id(cgrp);
+	}
+
+	if (uinfo.request_mask & PIDFD_INFO_SECURITY_CONTEXT) {
+		char *secctx;
+		u32 secid, secctx_len;
+		const struct cred *c = get_task_cred(task);
+		if (!c)
+			return -ESRCH;
+
+		security_cred_getsecid(c, &secid);
+		if (security_secid_to_secctx(secid, &secctx, &secctx_len))
+			return -EFAULT;
+
+		memcpy(info.security_context, secctx, min_t(u32, secctx_len, NAME_MAX-1));
+	}
+
+	if (copy_to_user((void __user *)arg, &info, uinfo.size))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct task_struct *task __free(put_task) = NULL;
@@ -121,13 +177,16 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct pid *pid = pidfd_pid(file);
 	struct ns_common *ns_common = NULL;
 
-	if (arg)
+	if (!!arg != (cmd == PIDFD_GET_INFO))
 		return -EINVAL;
 
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task)
 		return -ESRCH;
 
+	if (cmd == PIDFD_GET_INFO)
+		return pidfd_info(task, pid, arg);
+
 	scoped_guard(task_lock, task) {
 		nsp = task->nsproxy;
 		if (nsp)
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..bfd0965e01f3 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -16,6 +16,22 @@
 #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
 #define PIDFD_SIGNAL_PROCESS_GROUP	(1UL << 2)
 
+/* Flags for pidfd_info. */
+#define PIDFD_INFO_PID	    	        (1UL << 0)
+#define PIDFD_INFO_CREDS	            (1UL << 1)
+#define PIDFD_INFO_CGROUPID	            (1UL << 2)
+#define PIDFD_INFO_SECURITY_CONTEXT	    (1UL << 3)
+
+struct pidfd_info {
+        __u64 request_mask;
+        __u32 size;
+        uint pid;
+        uint uid;
+        uint gid;
+        __u64 cgroupid;
+        char security_context[NAME_MAX];
+} __packed;
+
 #define PIDFS_IOCTL_MAGIC 0xFF
 
 #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
@@ -28,5 +44,6 @@
 #define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
+#define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
 
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index c62564c264b1..929588c7e0f0 100644
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
@@ -21,6 +22,28 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
+#ifndef PIDFS_IOCTL_MAGIC
+#define PIDFS_IOCTL_MAGIC 0xFF
+#endif
+
+#ifndef PIDFD_GET_INFO
+#define PIDFD_GET_INFO _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
+#define PIDFD_INFO_PID                  (1UL << 0)
+#define PIDFD_INFO_CREDS                (1UL << 1)
+#define PIDFD_INFO_CGROUPID	            (1UL << 2)
+#define PIDFD_INFO_SECURITY_CONTEXT	    (1UL << 3)
+
+struct pidfd_info {
+        __u64 request_mask;
+        __u32 size;
+        uint pid;
+        uint uid;
+        uint gid;
+        __u64 cgroupid;
+        char security_context[NAME_MAX];
+} __attribute__((__packed__));
+#endif
+
 static int safe_int(const char *numstr, int *converted)
 {
 	char *err = NULL;
@@ -120,10 +143,14 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
 
 int main(int argc, char **argv)
 {
+	struct pidfd_info info = {
+		.size = sizeof(struct pidfd_info),
+		.request_mask = PIDFD_INFO_PID | PIDFD_INFO_CREDS | PIDFD_INFO_CGROUPID,
+	};
 	int pidfd = -1, ret = 1;
 	pid_t pid;
 
-	ksft_set_plan(3);
+	ksft_set_plan(4);
 
 	pidfd = sys_pidfd_open(-1, 0);
 	if (pidfd >= 0) {
@@ -153,6 +180,27 @@ int main(int argc, char **argv)
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
+	if (info.uid != getuid()) {
+		ksft_print_msg("uid %d does not match uid from info %d\n",
+			       getuid(), info.uid);
+		goto on_error;
+	}
+	if (info.gid != getgid()) {
+		ksft_print_msg("gid %d does not match gid from info %d\n",
+			       getgid(), info.gid);
+		goto on_error;
+	}
+	ksft_test_result_pass("get info from pidfd test: passed\n");
+
 	ret = 0;
 
 on_error:
-- 
2.45.2


