Return-Path: <linux-kernel+bounces-186892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BD38CCA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB61E2827ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA27B645;
	Thu, 23 May 2024 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ODVpdtn"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392726AAD
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428758; cv=none; b=CqUjKGjmIVHWsJwhoIkm35vBFYpRNtCyp0g00y/1X820Il7egSPk8DsUSrEvUpUCJMPH+GALKlct/+pwZPVC1QcNVKpDCKvWXIJkZ0DFmc/TwMVkdEEY/JoBxpst/OVOyk1RRO124ekkbvSftp+YNL34RgdZqxy+TVOLbTVgVss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428758; c=relaxed/simple;
	bh=2S6WaDA16P3nNEFVc4XPd5L9qqvHkgJjG7hZLrjRid8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EZBu/6YQ72BFb1LNKgsPXLA5Cf4+mQJW9WAbESbjU7prZriu8Z+GeScQU/JttVk6BwZzAHIaW/C2MS7K9uyGdIJwmTENZQq9jHL80cWT4VO2WQyy1dbeyB9iDZU0gH4Yj1IytSigntTuwJhrH3atYHD0mX2G9535rlsiJYr8k5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ODVpdtn; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7e17a8bed9eso100107439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716428756; x=1717033556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1vR6mjHSHfrdNH20F11UDXUiGSe7CBzDx3Qfe5mwFA=;
        b=2ODVpdtnCEW/DRBUAF2ArUEz5ToG3iKhmd9vImoiMyES5uYVS6LWtA70m99LwKv6Yg
         wWe5jx1KN7n3MiY16z/NmXKUP0GSWPTtNWXN9TnlsZHo4zrrrZJa9jl359RIGWSSfXKr
         sG8LdQUnTPIavzivFPihAFtVU5PhkIOoG7ozWlFFkP/DhZ6V2lmuUdMQiv6bVQv4+Aiw
         XQ4/kN2bq1fpfEr9mz/dZi2y6vXEL5mcjZQZf19lYFpZ6AGPDQHQo/7lsKD4U7zSZGpQ
         IbM0CL+psv/86hab3ew0FfPTS5gZ8gX7AFTDlNa4e+q51LmTRxMXDNMZOXAh9vVN1Idk
         C+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716428756; x=1717033556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1vR6mjHSHfrdNH20F11UDXUiGSe7CBzDx3Qfe5mwFA=;
        b=OXvEWU8AsJZu2Bc+XVHYsmHF/EMID67PMnSoksqHJi7R8xaMQvhavW6aE+tzKPmSp1
         1xcpA1QHrfYFXiKJxPrLcf0BRA5CPTxmVoOk8bvXWAAtcYY0SychnmrdYgTzKcg7EBXk
         sbFkATDsv9C5Up0YVdbzKqrJb5i9bp2daSF8Ket+KtyxQS+vtiGFWx7uiAQ7fn4WBCGU
         UEsvZupYn+aMTstLtq4/yQSLTHGgZmaVtRKLNsWeIB1dDwCTGyMQYkEZsqwOGtCNIKGC
         MsX/uL/SwPrkuUt8CVMmMJh5T9SOxCi4Xg/sGbY4dtaZpot2TnBAmtS09GLp93coAf4/
         LdBg==
X-Gm-Message-State: AOJu0Yz3snD3AvmeL9Nu+YNAmgesDvAO2f85mNCnic/af/Jb5fW/Q9Su
	rY49RVCy8icGMdeBhfCXnvbaQGA/tx7V/8a9TCblifmwGK7cvhs3y1GX/hvK+MA9r1X74lhc/M2
	QQQ==
X-Google-Smtp-Source: AGHT+IEbODWv9K2tpzg8xHV4V5D+WdJthqOhAYDkCC1u0RF5N4DiseepW/GU7rlhdv4cPVzNESRkk6f8OD8=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6638:2c0a:b0:48a:37e1:a543 with SMTP id
 8926c6da1cb9f-4afe3db6b82mr56219173.6.1716428756452; Wed, 22 May 2024
 18:45:56 -0700 (PDT)
Date: Thu, 23 May 2024 01:45:40 +0000
In-Reply-To: <20240523014540.372255-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240523014540.372255-1-avagin@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523014540.372255-4-avagin@google.com>
Subject: [PATCH 3/3] selftests/seccomp: add test for NOTIF_RECV and unused filters
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andrei Vagin <avagin@google.com>, Jens Axboe <axboe@kernel.dk>
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
2.45.1.288.g0e0cd299f1-goog


