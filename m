Return-Path: <linux-kernel+bounces-519806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B7A3A22B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329831898C43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0B26F47E;
	Tue, 18 Feb 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0i7Kor5K"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3526F447
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894707; cv=none; b=PiPbHXa1W3xJMNSySSEr+pZu71k7gsSIp6AHSqv3GWh7vnbDXxzPOfTnP0kxjTlYdMyQ/mCDFSbURbAUGJ2mzq+oTCKKJW2BjmXJ6S/YPIniuUdK70nVT8fcOYiI+lQEuJn3+xGvJYQVjx/SiQogJJDnrV5zTbyWzcpqeJxvhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894707; c=relaxed/simple;
	bh=+86Ks27emKBEUdAR/yquXOZ5pX01/bsLm7oyTQMlGko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdFN3NxEd+53KRWx1da2XLovNjJcIkzZWaPoD2KHmrEIrahDXMwChyainN0J/BHkh4obeLp/frmCuWPIgCAE8RH3aqlXh2apLfA5HcMNuaG1uqk/QX3HxyeSszl9LfwVc4a+ZCibeADRGf0EQ7tQjzD2+rCi6YyiixyqadNntZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0i7Kor5K; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-545314fc413so1820329e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739894704; x=1740499504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1PhhXFGFFLjKCOlfG2U0IWT7jUTa2le5EkO7OmJarM=;
        b=0i7Kor5K1IXp7NSUtc0DLvxiSs5NLBZZ4tWHD/7KzUqWmQaq5zT4q2RVM/tYyXBopr
         OpEYSOQiV4Iw8e3VJ2MskqYQuncnjDdHSMKFprNTPM+n0ypUH+ao0QMgwTSPlsm55RYm
         +uv88zG4k4cMvowcjfqNVthS8tTKUMvZ0AK/l5xg7zb8zMAQYA7NHC++OzIPST+UPsX7
         9CaN14VK/3Dg3Ls1G2MxB15dw/HQ8dwR/3FYtZJARvIvCahSP03Rl1+LlIR8j5MdGmmm
         FpDMZ+YKUy/0tpiujsj0irlxia50BOtpdq+budDKFbM68eSy3BG+Njvlbpl5QX+2kvTY
         JC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894704; x=1740499504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1PhhXFGFFLjKCOlfG2U0IWT7jUTa2le5EkO7OmJarM=;
        b=aNxU14sdkxnTS9pUGuBZtkKSrImceB9u3XtWqNYHEoAjb2kEv/zjXOBN0ou0zLGLCq
         I53B1R4+83mksGid7C/eZRDab3Rokf6tWZpKuxrCTrkFJIpyZbnM0DKZOGpR1K4fNvPR
         58geYedRW5vShY54lW+SMQPVkwnyyHhS8MRO6ElUNONtB9LxE77xSRle9+TbG5g6xOMP
         fplho4JMbmBIMuHyuG2r8Q8E0ieof9OCpnws42EeZekGq2nRdX6tf0FaxdT3U+6t43XD
         pOTGjbDc7qBq59MSBr/QiTYkSSORC+e3nk0YWJICcLB4D6uKe6BUPqLQqFAOkYdN+CG3
         b6ag==
X-Forwarded-Encrypted: i=1; AJvYcCVNy8ANURmUcj28PDdi1YVHQC7NfCDUCQ13SWxGEytqEXoh21c1i5HTcfQjEqA8g+H86im7Jmyi8/GY6zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZVLuFXxXPi2byZFp/jUNrOrzBynH4iqt3ZyhlalUbs5e3bR5
	JYsYns/Zs2EwsDyMbCjq79U1R8ToZn2CDr87UnPX5/1Nq0ozHDq/7ngjBYrno1pOedfdIJW52ji
	Bl/6/SA==
X-Google-Smtp-Source: AGHT+IFQ5r0iX9btAy5iAzFYlowkpYrALsekY1SW7hZ60mqrsvMAnxluXmZE8RUjYs8fdVUXLOQUP62cXnRH
X-Received: from ejchw12.prod.google.com ([2002:a17:907:a0cc:b0:abb:a168:b6d9])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6512:238a:b0:545:4d1:64c0
 with SMTP id 2adb3069b0e04-5452fe63376mr5840413e87.27.1739894703816; Tue, 18
 Feb 2025 08:05:03 -0800 (PST)
Date: Tue, 18 Feb 2025 17:04:36 +0100
In-Reply-To: <cover.1739894594.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739894594.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <5e105b1382cd43d05f1d3a80958e4f50f32144c8.1739894594.git.dvyukov@google.com>
Subject: [PATCH 3/3] selftests: Extend syscall_user_dispatch test to check
 allowed range
From: Dmitry Vyukov <dvyukov@google.com>
To: krisman@collabora.com, tglx@linutronix.de, luto@kernel.org, 
	peterz@infradead.org, keescook@chromium.org, gregory.price@memverge.com
Cc: Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test that ensures that PR_SET_SYSCALL_USER_DISPATCH respects
the specified allowed PC range. The test includes both a continuous
range and a wrap-around range.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Gregory Price <gregory.price@memverge.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org
---
 .../syscall_user_dispatch/sud_test.c          | 79 +++++++++++--------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b0969925ec64c..fa40e46e6d3e9 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -10,6 +10,7 @@
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
 #include <signal.h>
+#include <stdbool.h>
 
 #include <asm/unistd.h>
 #include "../kselftest_harness.h"
@@ -110,31 +111,15 @@ TEST(bad_prctl_param)
 	/* PR_SYS_DISPATCH_ON */
 	op = PR_SYS_DISPATCH_ON;
 
-	/* Dispatcher region is bad (offset > 0 && len == 0) */
-	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
-	EXPECT_EQ(EINVAL, errno);
-	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));
-	EXPECT_EQ(EINVAL, errno);
+	/* All ranges are allowed */
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x1, 0x0, &sel));
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, -1L, 0x0, &sel));
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel));
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel));
 
 	/* Invalid selector */
 	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0x0, 0x1, (void *) -1));
 	EXPECT_EQ(EFAULT, errno);
-
-	/*
-	 * Dispatcher range overflows unsigned long
-	 */
-	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 1, -1L, &sel));
-	EXPECT_EQ(EINVAL, errno) {
-		TH_LOG("Should reject bad syscall range");
-	}
-
-	/*
-	 * Allowed range overflows usigned long
-	 */
-	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel));
-	EXPECT_EQ(EINVAL, errno) {
-		TH_LOG("Should reject bad syscall range");
-	}
 }
 
 /*
@@ -145,11 +130,13 @@ char glob_sel;
 int nr_syscalls_emulated;
 int si_code;
 int si_errno;
+unsigned long syscall_addr;
 
 static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 {
 	si_code = info->si_code;
 	si_errno = info->si_errno;
+	syscall_addr = (unsigned long)info->si_call_addr;
 
 	if (info->si_syscall == MAGIC_SYSCALL_1)
 		nr_syscalls_emulated++;
@@ -172,26 +159,29 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 #endif
 }
 
-TEST(dispatch_and_return)
+int setup_sigsys_handler(void)
 {
-	long ret;
 	struct sigaction act;
 	sigset_t mask;
 
-	glob_sel = 0;
-	nr_syscalls_emulated = 0;
-	si_code = 0;
-	si_errno = 0;
-
 	memset(&act, 0, sizeof(act));
 	sigemptyset(&mask);
-
 	act.sa_sigaction = handle_sigsys;
 	act.sa_flags = SA_SIGINFO;
 	act.sa_mask = mask;
+	return sigaction(SIGSYS, &act, NULL);
+}
 
-	ret = sigaction(SIGSYS, &act, NULL);
-	ASSERT_EQ(0, ret);
+TEST(dispatch_and_return)
+{
+	long ret;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+	si_errno = 0;
+
+	ASSERT_EQ(0, setup_sigsys_handler());
 
 	/* Make sure selector is good prior to prctl. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
@@ -321,4 +311,31 @@ TEST(direct_dispatch_range)
 	}
 }
 
+bool test_range(unsigned long offset, unsigned long length)
+{
+	nr_syscalls_emulated = 0;
+	if (prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, offset, length, &glob_sel))
+		return false;
+	SYSCALL_DISPATCH_ON(glob_sel);
+	return syscall(MAGIC_SYSCALL_1) == MAGIC_SYSCALL_1 && nr_syscalls_emulated == 1;
+}
+
+TEST(dispatch_range)
+{
+	ASSERT_EQ(0, setup_sigsys_handler());
+	ASSERT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel));
+	SYSCALL_DISPATCH_ON(glob_sel);
+	ASSERT_EQ(MAGIC_SYSCALL_1, syscall(MAGIC_SYSCALL_1));
+	TH_LOG("syscall_addr=0x%lx", syscall_addr);
+	EXPECT_FALSE(test_range(syscall_addr, 1));
+	EXPECT_FALSE(test_range(syscall_addr-100, 200));
+	EXPECT_TRUE(test_range(syscall_addr+1, 100));
+	EXPECT_TRUE(test_range(syscall_addr-100, 100));
+	/* Wrap-around tests for everything except for a single PC. */
+	EXPECT_TRUE(test_range(syscall_addr+1, -1));
+	EXPECT_FALSE(test_range(syscall_addr, -1));
+	EXPECT_FALSE(test_range(syscall_addr+2, -1));
+	SYSCALL_DISPATCH_OFF(glob_sel);
+}
+
 TEST_HARNESS_MAIN
-- 
2.48.1.601.g30ceb7b040-goog


