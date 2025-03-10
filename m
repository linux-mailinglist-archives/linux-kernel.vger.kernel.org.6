Return-Path: <linux-kernel+bounces-553699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F5A58DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FB7188D093
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A2223321;
	Mon, 10 Mar 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBRyDsB4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCs0URcV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8DE1DA614
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594306; cv=none; b=Qz+YBYdqGDQQHq3CCNceUL3KvcFSnXnCnjabdm72+iB60x9MjM3Mbg9K9hMlukmVXl1i01OWWoDe9P1iJ3ipYLqmyzQJvOyCmghf+tbVvbKXGftlcyffau23VOePCVlZh5TqU7kGHXsCwNvnliDi+AGTEq0lW/keHt7c9bA1MBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594306; c=relaxed/simple;
	bh=cSYqlO6z2p29f9yjXzmdcJZw7Hd7C9aTnywCachRen4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZ0eDW2F/NofsmnIa8QDNoQNheA4SSY8dKQBCu6Kbk3oiL7gXQ4KCnZBvrph0+uDnNtn1ETf5K8kDYTBEcFU4WSTL5pG+pRjRFrwfVmYCMtidvOxI/l+ZKu0WPgdim2v4TuuAFmlV9TNpz/6kmKpbpYiNHUTfo57mE8g8YU27zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBRyDsB4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RCs0URcV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741594302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yirtwRw97GX5UcmnPATyeQrpvyHNyQqdOHfNHARqUbE=;
	b=jBRyDsB4LQBmBF3BFfmettgfOjrlQkDwX8COUQgimpCBXWmp5nvi1PL/MhfyXsZqNlKFbz
	ZjjPiqy0u1YSkdCWGTFyUxi/WzNsJLzThxRS1F3BHfsvdYM9+/PncV10yu1k28ErMecrxh
	g/rrkCF0Dbp6encH4od1zuLlao+LR3cOG03qZHzbzLE81LXtgYRkQ/7re+7MvcSk0S+AXA
	e7O1Jt0MZQxb0jX9f2tpqLY3DJruLvqBAIbPQOnDyB2aReF9LQSflKnKjkCE4GsB+oddMs
	qkFL+FPtkbdSkRB7av/wCzNip8jJgo0QReTlVNfbvqAC7jAn3UFGypSUmZf7hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741594302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yirtwRw97GX5UcmnPATyeQrpvyHNyQqdOHfNHARqUbE=;
	b=RCs0URcVlqIESYBrAVEBjeEnLzzw+vJ4Q3eqgRtuDBV+lU5kNEBRfyAOO8t38rQKDWUXf1
	QH3ROWRgCSY96cBw==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, Peter Zijlstra <peterz@infradead.org>, Cyrill
 Gorcunov <gorcunov@gmail.com>
Subject: [patch V3a 18/18] selftests/timers/posix-timers: Add a test for
 exact allocation mode
In-Reply-To: <20250308155624.590144807@linutronix.de>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.590144807@linutronix.de>
Date: Mon, 10 Mar 2025 09:11:42 +0100
Message-ID: <8734fl2tkx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The exact timer ID allocation mode is used by CRIU to restore timers with a
given ID. Add a test case for it.

It's skipped on older kernels when the prctl() fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3a: Fix #ifndef condition
V3: Use the PRCTL defines
V2: Adopt to the ID counter change in the exact mode case
---
 tools/testing/selftests/timers/posix_timers.c |   66 +++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -7,6 +7,7 @@
  * Kernel loop code stolen from Steven Rostedt <srostedt@redhat.com>
  */
 #define _GNU_SOURCE
+#include <sys/prctl.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <stdio.h>
@@ -599,14 +600,77 @@ static void check_overrun(int which, con
 			 "check_overrun %s\n", name);
 }
 
+#include <sys/syscall.h>
+
+static int do_timer_create(int *id)
+{
+	return syscall(__NR_timer_create, CLOCK_MONOTONIC, NULL, id);
+}
+
+static int do_timer_delete(int id)
+{
+	return syscall(__NR_timer_delete, id);
+}
+
+#ifndef PR_TIMER_CREATE_RESTORE_IDS
+# define PR_TIMER_CREATE_RESTORE_IDS		77
+# define PR_TIMER_CREATE_RESTORE_IDS_OFF	 0
+# define PR_TIMER_CREATE_RESTORE_IDS_ON		 1
+#endif
+
+static void check_timer_create_exact(void)
+{
+	int id;
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_ON, 0, 0, 0)) {
+		switch (errno) {
+		case EINVAL:
+			ksft_test_result_skip("check timer create exact, not supported\n");
+			return;
+		default:
+			ksft_test_result_skip("check timer create exact, errno = %d\n", errno);
+			return;
+		}
+	}
+
+	id = 8;
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (prctl(PR_TIMER_CREATE_RESTORE_IDS, PR_TIMER_CREATE_RESTORE_IDS_OFF, 0, 0, 0))
+		fatal_error(NULL, "prctl()");
+
+	if (id != 8) {
+		ksft_test_result_fail("check timer create exact %d != 8\n", id);
+		return;
+	}
+
+	/* Validate that it went back to normal mode and allocates ID 9 */
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (id == 9)
+		ksft_test_result_pass("check timer create exact\n");
+	else
+		ksft_test_result_fail("check timer create exact. Disabling failed.\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(18);
+	ksft_set_plan(19);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
+	check_timer_create_exact();
+
 	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
 	check_itimer(ITIMER_PROF, "ITIMER_PROF");
 	check_itimer(ITIMER_REAL, "ITIMER_REAL");

