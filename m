Return-Path: <linux-kernel+bounces-233262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD191B4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8FA1F220EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C600F1F959;
	Fri, 28 Jun 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlwxHoJ/"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654C182DB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540622; cv=none; b=aMUA+I2tWKra6wjAekq1Af0jYoux0goW+c0M9eLbuLUusrKLck2ehHj+Ly6vv/BELg+hq9XMKmNXvz1IgIsno3hH22FizyJSg4m5MY7swYqE1hUKTr8SfEcfim91RdwdkWlPYnC1IDApBTO0P5Y0T1lD1maPY5anCqAmsyl9XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540622; c=relaxed/simple;
	bh=NTB8v1mptXdowZfN1SyzFsAL03+UwPmvXEHLEadFgWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H542k7T6om3w+FAeiHExPNsPFOkhr7LVbZwenx7Ey3lCjIm6NWjYGT+wk5b1EZIB64ObHiqclOf0rGMtKMHGgwmENkk7Oms2ftb0kb7l4Hdc2WvaZBbl6/k+Mq4UfpJSMe50MhTVGvtHpYVxDcL/wbXcvZKBzLI2Qj3L6BhjfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlwxHoJ/; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-376282b0e2bso1888025ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719540620; x=1720145420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRvuIq7O+LkudhOSygi6ppC8FZ2ycfIcb8xGEgTwFqM=;
        b=KlwxHoJ/WHC61/mdNfNhDk2Kk7VUDosdaqAmTrg+kZh4DFSfyyah5U+VqOja5nim+A
         2y4uxRiDn9/VCjHr1vgCMMGAVQBjq62uHpdX4N50ieNcJqt7bB0dEY0n2RVVfDQzTZeL
         t6N2wIe86zxUrDdGyG4BdZ5dKiMW0IpnyLkQJToimZvMzriPhEVWf7QcUG54vI1F8wiZ
         IcY6Q4dCw3p468oN0RjUNXuZqy2U9OwPfz2qUj2tlAR33h/FppSfTbiVYHp72C6eev6G
         r+Jlg+wbJHegeEke0CzhQFbtz0QR1FjmnfisYYIevoE4pNmCR7hFhQ+qdpBdviMWxtnZ
         cB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719540620; x=1720145420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRvuIq7O+LkudhOSygi6ppC8FZ2ycfIcb8xGEgTwFqM=;
        b=XzvrS3nSF60f+TnHR1RzzPbH/hse4YyXdmDvX+MeJ8PznQHgU+87KGlMYsJ91nkqb6
         bEBfMYHmw1cULkWM/f9FegxvZd/tFShKSk/5vd61kEDMOxjp6Nv77zliYOoGs3nYppjd
         eXSqL+NryiiztOSUFQSzDLWa3wqD9jN6UClVKlZSfNQBaKYjfWnY3Fr6s+BqEOwQWtgu
         cYrfa8m0JfA6NdQEm7NR9P1ap977EDlki9jLMyv/y5W7pPJRYOMRxG+DxHMkeq3/EOFV
         lXQ914ryK5ZFAuCu5Qjf4jav+Ka09hQ9l/W/1pFjHWF2SeVlKIqELOC9GE+aMFB7mQZD
         yxBg==
X-Gm-Message-State: AOJu0Yz4G9YoE13QViTHDZkhyEnsutnE7h6DgaMnGkTJ/x0Lbz2EKx2W
	N/JfICovPEI4au3IPqAcL9QopSxnVfvO16VsR2j0AnG4AkOYP7zfPc8+woKBcH1auH0F2W+7bwv
	UOw==
X-Google-Smtp-Source: AGHT+IEK8XeMsZ5PeqOyB+VsJflLL5d+I2ytQoXmhvG71Iow5Q8w2shKEM1miFtDbjDVDn1oIwhVSEbhBMo=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6e02:20e8:b0:379:2f26:c50a with SMTP id
 e9e14a558f8ab-3792f26c73bmr3764075ab.4.1719540619980; Thu, 27 Jun 2024
 19:10:19 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:10:13 +0000
In-Reply-To: <20240628021014.231976-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628021014.231976-1-avagin@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628021014.231976-4-avagin@google.com>
Subject: [PATCH 3/4] selftests/seccomp: add test for NOTIF_RECV and unused filters
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new test case to check that SECCOMP_IOCTL_NOTIF_RECV returns when all
tasks have gone.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 783ebce8c4de..390781d7c951 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3954,6 +3954,60 @@ TEST(user_notification_filter_empty)
 	EXPECT_GT((pollfd.revents & POLLHUP) ?: 0, 0);
 }
 
+TEST(user_ioctl_notification_filter_empty)
+{
+	pid_t pid;
+	long ret;
+	int status, p[2];
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+	struct seccomp_notif req = {};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	if (__NR_clone3 < 0)
+		SKIP(return, "Test not built with clone3 support");
+
+	ASSERT_EQ(0, pipe(p));
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int listener;
+
+		listener = user_notif_syscall(__NR_mknodat, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (listener < 0)
+			_exit(EXIT_FAILURE);
+
+		if (dup2(listener, 200) != 200)
+			_exit(EXIT_FAILURE);
+		close(p[1]);
+		close(listener);
+		sleep(1);
+
+		_exit(EXIT_SUCCESS);
+	}
+	if (read(p[0], &status, 1) != 0)
+		_exit(EXIT_SUCCESS);
+	close(p[0]);
+	/*
+	 * The seccomp filter has become unused so we should be notified once
+	 * the kernel gets around to cleaning up task struct.
+	 */
+	EXPECT_EQ(ioctl(200, SECCOMP_IOCTL_NOTIF_RECV, &req), -1);
+	EXPECT_EQ(errno, ENOENT);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 static void *do_thread(void *data)
 {
 	return NULL;
-- 
2.45.2.803.g4e1b14247a-goog


