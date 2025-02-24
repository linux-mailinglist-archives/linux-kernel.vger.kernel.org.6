Return-Path: <linux-kernel+bounces-528441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0BBA417B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AB016F389
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CCD21D3F1;
	Mon, 24 Feb 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdKiKKOE"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCB21D3EE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386745; cv=none; b=S1iFET/Y9sgWlGKSDkM+D1Julq11sVn0UjiQwdg5ofarCrPKdNqhfl+Z2wf/RN7IHZ6JTo+vafLNGnXNHQepu0pWJeteT5MCIL/17L4w7/8S5sR/89la/a4NTJwciIqcYGwnGE6KLsDAcmFvLW9Ey34JO6Kyhn3vZ2WBUlVzsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386745; c=relaxed/simple;
	bh=JqtxjAmqxeL0t1hyw/R5nXgv4I20bWPazwl6fujlIAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dV6CiueTykH5Mx00rFXtlyeedncWuua4H08GaYbjr67aosI0kvBNA4PuhFbMKjZbNDq8K15iUGJRrmOp6glCWBsYbOzs6eFGwG2cmsgurypeyP785n3kkYicJcmsCqxvfIKCqk+nvbuNrPtEm63+55MGjvL5WSluSMu1XGuXCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdKiKKOE; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abb87e3a3c9so448049466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740386742; x=1740991542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQF+iGReGP9xasU6LwNX6rJHJvus8x0KQVBFP1lU99o=;
        b=mdKiKKOExEcRjNoO/HP8XERRmev69XmLygISob61OBu9VxNDRlohGSc+r8UoR67TRY
         KlnYi6o0hKbNPEA6Lad9noTiiUMfip1HtWOroz8PGvkRFngGHVTj+DCrzI/fZLRHFVsw
         f07V1OfyOWCpbnL2oEoQv5HXMtAv4qcAn9xIGVGLGwLogfFwv+Zz1IIW0BVqRX1+QRby
         E/hcfSJwrM24zq3YA0ir5nBE5asCfBJmwGt9Zckp7/KGRSnFZCL6vtg9Aq0CYZdTfELS
         bQxCyDQuCXFF9Ak7d7ozvSoOFhBeEitdgxGxZJdyWBdkHbFtywJkYBCsGMHuf3b5tpi6
         TORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386742; x=1740991542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQF+iGReGP9xasU6LwNX6rJHJvus8x0KQVBFP1lU99o=;
        b=IR8ahkeT84mTYCSa+MvIoa1pMfeFRLIYUxlv4GIjC0ScT08ewOHWiqQQEhOXinKHQo
         lyPBN72rr5788SVDZnJ0vaEbXMqNrZ55oj3g9XV3qDMqjgWHRYz+J6f0nRri5twvqo74
         sUDmGqEmtFoTx3xSr4/xVrz87ld+WUcHFUvxSU31nffLycWdX9PGdDmaQTOu6435sio2
         Iyqw4TbUqs47E043WoaJiFIH6fHGtt8xdwAXKTQbOgPdf6N8lX9GxRNdvJ896CxhMlrM
         33KmfyjlXUpn4rVRqlE32XtO3Wk3CplD5ZyTtJAYQT5QHtXAVLOdbbfr3UDm6NYo6XBs
         oU5A==
X-Forwarded-Encrypted: i=1; AJvYcCWrMYD9v31h7H1Ol9NBQPhJZ/pNGjUgPgvVBuJKUwKcXmGmNLvOEtiG7RHh39nqFZJwxxtdl3Y5zEBOxsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGr8mXwtVXj8ECjmuGA5CsQMgsCumpMmv2lXqw2CnGSOl+Fg4
	vMYG5Le21Kl8TAOU+xzf0jjT+3sTQVOOKVKlN8sBQbQrMOV6U9SpbdauWzmNH5KIEd+o8rnmuzt
	LVINHAQ==
X-Google-Smtp-Source: AGHT+IHMFPc32xzyLN0MXMpMgNHSUKOvg8vmD2KmV10tV25PoTdfS/durnCaw/m++9k3552XpAhboaQR5z+3
X-Received: from ejcrx14.prod.google.com ([2002:a17:906:8e0e:b0:abb:8131:986b])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:2801:b0:abc:ca9:45af
 with SMTP id a640c23a62f3a-abc0ca94fb1mr978372666b.18.1740386741815; Mon, 24
 Feb 2025 00:45:41 -0800 (PST)
Date: Mon, 24 Feb 2025 09:45:27 +0100
In-Reply-To: <cover.1740386567.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740386567.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <0804b17f1163640eb830de487ab5fc222829e778.1740386567.git.dvyukov@google.com>
Subject: [PATCH v2 3/3] selftests: Extend syscall_user_dispatch test to check
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
Changes in v2:
 - add tests for 0-sized range
 - change range setup in the test to be fatal
---
 .../syscall_user_dispatch/sud_test.c          | 85 ++++++++++++-------
 1 file changed, 54 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b0969925ec64c..302089ccd103c 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -10,6 +10,8 @@
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
 #include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
 
 #include <asm/unistd.h>
 #include "../kselftest_harness.h"
@@ -110,31 +112,15 @@ TEST(bad_prctl_param)
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
@@ -145,11 +131,13 @@ char glob_sel;
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
@@ -172,26 +160,29 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
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
@@ -321,4 +312,36 @@ TEST(direct_dispatch_range)
 	}
 }
 
+bool test_range(unsigned long offset, unsigned long length)
+{
+	nr_syscalls_emulated = 0;
+	SYSCALL_DISPATCH_OFF(glob_sel);
+	if (prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, offset, length, &glob_sel))
+		abort();
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
+	/* 0-size range does not match anything. */
+	EXPECT_TRUE(test_range(syscall_addr-1, 0));
+	EXPECT_TRUE(test_range(syscall_addr, 0));
+	EXPECT_TRUE(test_range(syscall_addr+1, 0));
+	SYSCALL_DISPATCH_OFF(glob_sel);
+}
+
 TEST_HARNESS_MAIN
-- 
2.48.1.601.g30ceb7b040-goog


