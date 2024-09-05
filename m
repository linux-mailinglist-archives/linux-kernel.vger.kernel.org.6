Return-Path: <linux-kernel+bounces-317619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19396E123
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EFD1F24F97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA91A42DB;
	Thu,  5 Sep 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TN/U1ppe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420EB19CCFC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557545; cv=none; b=gUaQamBkcrZNXXb/GcJvGL4y9mxMspdeNDeTWtiQ7mdH4bZRvHCzuYbNEe/QsdC92OQmaNgTTaCBSG4h6BvuW5B0+JNgjG8iBQw2nB323WOGpQfXxedfG3pIRmKt9i3+GGj+W9u97nEnM2XGL2WQdOnSWIxigWSCPCiuU0UXRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557545; c=relaxed/simple;
	bh=E9JNNYrKeDcVb+V2+6qDgy4oDKCiXT4wTm1jLXev99Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eq4ffrdbShqkHTek8XKK6IUewTdazH5I5Dd1i1t98P/BV49YOZpBSqZqLexPrtbFB0bTpJRHAlCFS9/n8frcHpiXiRg1JX2/salqoow0917ZyxpG4QimUTC+LWaXbfK013BB1017uFgBjXTY4W0KYSYJt0R+1oLvfRH/kQDHAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=TN/U1ppe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40676C4CEC3;
	Thu,  5 Sep 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TN/U1ppe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725557542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02CKnOIEn3lKah0jL3h+96k4GwxXO5HBYvFKPHV3Ups=;
	b=TN/U1ppe9SPhTT34p4mThxbOt/KnB6Sr2YVgSLVsMG+i9D6Ymd6TulQpn33PuY8kCQ3V4m
	mqaAx+pENRvyiSUA9Oqv/Kev1BOWz7V2o+sr75HYGrHhSkqj/5K+QsOF9L7J4kAtP0yZje
	AJ1x/coyVtrIuUJw3nU6EGftWIJbm/8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e0eb1edd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 17:32:22 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	christophe.leroy@csgroup.eu,
	adhemerval.zanella@linaro.org,
	xry111@xry111.site
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] selftests: vDSO: ensure vgetrandom works in a time namespace
Date: Thu,  5 Sep 2024 19:31:39 +0200
Message-ID: <20240905173220.2243959-1-Jason@zx2c4.com>
In-Reply-To: <ZtnnZMa_Yi-UwhHT@zx2c4.com>
References: <ZtnnZMa_Yi-UwhHT@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After verifying that vDSO getrandom does work, which ensures that the
RNG is initialized, test to see if it also works inside of a time
namespace. This is important to test, because the vvar pages get
swizzled around there. If the arch code isn't careful, the RNG will
appear uninitialized inside of a time namespace.

Because broken code implies that the RNG appears initialized, test that
everything works by issuing a call to vgetrandom from a fork in a time
namespace, and use ptrace to ensure that the actual syscall vgetrandom
doesn't get called. If it doesn't get called, then the test succeeds.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 .../selftests/vDSO/vdso_test_getrandom.c      | 41 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 8866b65a4605..dfda5061f454 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -16,8 +16,11 @@
 #include <sys/mman.h>
 #include <sys/random.h>
 #include <sys/syscall.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
 #include <sys/types.h>
 #include <linux/random.h>
+#include <linux/ptrace.h>
 
 #include "../kselftest.h"
 #include "parse_vdso.h"
@@ -239,9 +242,10 @@ static void fill(void)
 static void kselftest(void)
 {
 	uint8_t weird_size[1263];
+	pid_t child;
 
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 
 	for (size_t i = 0; i < 1000; ++i) {
 		ssize_t ret = vgetrandom(weird_size, sizeof(weird_size), 0);
@@ -250,6 +254,41 @@ static void kselftest(void)
 	}
 
 	ksft_test_result_pass("getrandom: PASS\n");
+
+	assert(unshare(CLONE_NEWUSER) == 0 && unshare(CLONE_NEWTIME) == 0);
+	child = fork();
+	assert(child >= 0);
+	if (!child) {
+		vgetrandom_init();
+		child = getpid();
+		assert(ptrace(PTRACE_TRACEME, 0, NULL, NULL) == 0);
+		assert(kill(child, SIGSTOP) == 0);
+		assert(vgetrandom(weird_size, sizeof(weird_size), 0) == sizeof(weird_size));
+		_exit(0);
+	}
+	for (;;) {
+		struct ptrace_syscall_info info = { 0 };
+		int status, ret;
+		assert(waitpid(child, &status, 0) >= 0);
+		if (WIFEXITED(status)) {
+			if (WEXITSTATUS(status) != 0)
+				exit(KSFT_FAIL);
+			break;
+		}
+		assert(WIFSTOPPED(status));
+		if (WSTOPSIG(status) == SIGSTOP)
+			assert(ptrace(PTRACE_SETOPTIONS, child, 0, PTRACE_O_TRACESYSGOOD) == 0);
+		else if (WSTOPSIG(status) == SIGTRAP | 0x80) {
+			assert(ptrace(PTRACE_GET_SYSCALL_INFO, child, sizeof(info), &info) > 0);
+			if (info.entry.nr == __NR_getrandom &&
+			    (info.entry.args[0] == (uintptr_t)&weird_size && info.entry.args[1] == sizeof(weird_size)))
+				exit(KSFT_FAIL);
+		}
+		assert(ptrace(PTRACE_SYSCALL, child, 0, 0) == 0);
+	}
+
+	ksft_test_result_pass("getrandom timens: PASS\n");
+
 	exit(KSFT_PASS);
 }
 
-- 
2.46.0


