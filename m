Return-Path: <linux-kernel+bounces-542684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AE8A4CC65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94A93AA7B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDB2356DC;
	Mon,  3 Mar 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAUR+DwR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037E1DDA3C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032150; cv=none; b=rNXKJHryatL0p4GfmsRJSkhUgxgqNztYZqe/Icw9pIfrUunBS/jFMaO5zt2EZcKcFsLTCBUTf8dsuZtLP1qB3Z8Jp7erDSqDNWJfGfNLEvKBshkGRGkonYthm0TGhWhSTSMg+G4w8lEfJ9wvW9QGn0Q6DYzcqC2XsObwosPv9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032150; c=relaxed/simple;
	bh=/0ngzQtMnbW5Of4zFlh4yOH6BKkIsaKt9jM90aTRXpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdk0DQpLk/uiI8RYcsU6zRk+GgoXjwzgEOzdV1s1TrkHfv7ul43sYQ93Dr2d7YPjLaOdzie5OcjO7WV+3Wy9miq7WJpDoiYvUDEKic3Af6Ek7XXgESB9B4svqvv/YTKNTqCaShyatVxgZBZPA5/1LCaKYit7D5eet318Edq0rxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kAUR+DwR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2233622fdffso92992655ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741032148; x=1741636948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y/4/pd1k6dHTWvdS5kPevXrcIKWux8yVsmsyCQC0NE=;
        b=kAUR+DwRhrfQtXY+UfA9F7F4/tUHWTrwUFFZHPztmKytpMCXfy5/kblnEt+42lMddS
         hus2t8MUnY33JVew8xTwhqS11BAd7ZiZMUQUG/79LyHK+cWZHgQPTOnXgFrcs8zqfUpc
         TQ94bhwf8/gOsGwpvfgi8NIKyAfm/JM0dQfUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032148; x=1741636948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y/4/pd1k6dHTWvdS5kPevXrcIKWux8yVsmsyCQC0NE=;
        b=iBcaOs/I3hbQhJDw0urZfUuBs8m6Asv4jvprK5UDGz0pPpwHyOIedWh/O5SBJcNMec
         vqXlzFaV3yKBUFABUhH+fknL07miDL8sW1Me0JvW1oxIK0ibtEyw22LaHEtN1gOq+AOX
         hZpP1IydrmRsmkbL4UbvoMIhcI3L5aT0PkD6qfdbTnCsUGC0ZMERyIgFtP7hJVJbHTOT
         BSrpDURS3gDAIlc2a7TdUESFHRh6ROgyOuQ7Yzk4n/GE8Kuo1Uo0ixL4YR9z322Df8Q1
         RmhO9zrcS9O4FWi+Dg+SibbTzOaLd1h9vkEXZtOBeXLXBsul99FzIE7i3GJsreviZsjY
         bPBA==
X-Forwarded-Encrypted: i=1; AJvYcCXiumjMJLs01aKSBogxIMw+C70/r9pa5wPhSm5VnpTwXURJiWtdm0dVDwL4Sp55J/xzmaWfMgwkR5Z0mw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRWM+sa+38VHtvtkaDTspta3JG4XTcQyM0a8a+nz4X9f83zIu1
	ZR5CDd5/tdmXDLbPkEsrnshfbHXIHe/4df1JWQsk9UzvKMbOnit08YHz9hJ2JA==
X-Gm-Gg: ASbGncs1OXBg+1DmAaF5XBevpNtN3KPYAbaSmq3HXYtWmpuUJV3PGvYVEMAalIZKxuv
	CKQwsZohDML0WCcEhA/EHJxhMLv90JV4ssmF2/9ZMV3oZlcYLdpDtaFV9B3I4etaZU2PiC//dXJ
	DHLuzzwZAQ2Kl4vLEjw9CErEudsiTgBhS8qcDxyhvLVdCwLnH5PGvrglChC6Zp7X8Yhoa5VXl0b
	YcT6VQTWfVY0RHYoHP2fkyCflg66+J/EXk/pOQtPkO4i5RSGk8VrIcmJHRKWXiZwkMMNsnDm+yY
	ck6HB9YtQL74BHe1ogmGuZPjUhO5nD/Vm3vdta157tBtXCk6FibFfledqROyCQI9kiuimETGnnZ
	aF6lPDw+w406PZ8hYlXgF6O5REk/SEwg=
X-Google-Smtp-Source: AGHT+IHegT8hbV9Z9yYIqmC3KTe9PJwBJ6oCiv6zYuQs75m5txHhScRzpeb1cwpadUzfBOJOdsswzQ==
X-Received: by 2002:a17:902:ea0c:b0:21f:74ec:1ff0 with SMTP id d9443c01a7336-22369258a3emr249021355ad.32.1741032147852;
        Mon, 03 Mar 2025 12:02:27 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc4b4sm81233875ad.171.2025.03.03.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:02:27 -0800 (PST)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v16 1/3] lsm, selinux: Add setup_report permission to binder
Date: Mon,  3 Mar 2025 12:02:10 -0800
Message-ID: <20250303200212.3294679-2-dualli@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303200212.3294679-1-dualli@chromium.org>
References: <20250303200212.3294679-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thiébaud Weksteen <tweek@google.com>

Introduce a new permission "setup_report" to the "binder" class.
This persmission controls the ability to set up the binder generic
netlink driver to report certain binder transactions.

Signed-off-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: Li Li <dualli@google.com>
---
 include/linux/lsm_hook_defs.h       |  1 +
 include/linux/security.h            |  6 ++++++
 security/security.c                 | 13 +++++++++++++
 security/selinux/hooks.c            |  7 +++++++
 security/selinux/include/classmap.h |  3 ++-
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2bf909fa3394..395528de689f 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -33,6 +33,7 @@ LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
 LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 	 const struct cred *to, const struct file *file)
+LSM_HOOK(int, 0, binder_setup_report, const struct cred *to)
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1545d515a66b..b3c01254023e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -338,6 +338,7 @@ int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to);
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file);
+int security_binder_setup_report(const struct cred *to);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(const struct task_struct *target,
@@ -657,6 +658,11 @@ static inline int security_binder_transfer_file(const struct cred *from,
 	return 0;
 }
 
+static inline int security_binder_setup_report(const struct cred *to)
+{
+	return 0;
+}
+
 static inline int security_ptrace_access_check(struct task_struct *child,
 					     unsigned int mode)
 {
diff --git a/security/security.c b/security/security.c
index 8aa839232c73..382e3bbab215 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1043,6 +1043,19 @@ int security_binder_transfer_file(const struct cred *from,
 	return call_int_hook(binder_transfer_file, from, to, file);
 }
 
+/**
+ * security_binder_setup_report() - Check if process allowed to set up binder reports.
+ * @to: receiving process
+ *
+ * Check whether @to is allowed to set up binder reports.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_binder_setup_report(const struct cred *to)
+{
+	return call_int_hook(binder_setup_report, to);
+}
+
 /**
  * security_ptrace_access_check() - Check if tracing is allowed
  * @child: target process
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0d958f38ff9f..2fafa8feafdf 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2092,6 +2092,12 @@ static int selinux_binder_transfer_file(const struct cred *from,
 			    &ad);
 }
 
+static int selinux_binder_setup_report(const struct cred *to)
+{
+	return avc_has_perm(current_sid(), cred_sid(to), SECCLASS_BINDER,
+			    BINDER__SETUP_REPORT, NULL);
+}
+
 static int selinux_ptrace_access_check(struct task_struct *child,
 				       unsigned int mode)
 {
@@ -7217,6 +7223,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
 	LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
+	LSM_HOOK_INIT(binder_setup_report, selinux_binder_setup_report),
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 04a9b480885e..156741f1ca3f 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -135,7 +135,8 @@ const struct security_class_mapping secclass_map[] = {
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket", { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ "binder",
-	  { "impersonate", "call", "set_context_mgr", "transfer", NULL } },
+	  { "impersonate", "call", "set_context_mgr", "transfer",
+	    "setup_report", NULL } },
 	{ "cap_userns", { COMMON_CAP_PERMS, NULL } },
 	{ "cap2_userns", { COMMON_CAP2_PERMS, NULL } },
 	{ "sctp_socket",
-- 
2.48.1.711.g2feabab25a-goog


