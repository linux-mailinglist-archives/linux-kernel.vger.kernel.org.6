Return-Path: <linux-kernel+bounces-552638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A366A57C26
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC7A189293D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F8021506A;
	Sat,  8 Mar 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BmRd+6W7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suClD5IW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9B215049
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452534; cv=none; b=HbL4VpFIWgcGsthvgoio+shqu/YKD2DtnGhVcZmfLN9QBX2qLjkLTzX1+JAajmWpjx4+y4EAnRxfaRScx1LgR2EZtaub4TdVXbKUoekAwmv5914NR8BVvd3UBSAiBvi3rQEX+iAbHj0Uj4cub+XSPt510skSCHOH/A+uk2JyFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452534; c=relaxed/simple;
	bh=JlMYreI1byil917wOP/FNFghM3ExAXRDvCqM7pZuLyQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mMD+QnXdEv9efqwD7kPwb2p9RY9mKM0EC06QNg/b5aQeNJrm28nQL3gV/Bf7GRJooisAXQw4Lk+I2JQjFpZyk777Gqz/ePQJdjAViPR86vn+gvwR3TWXS1KB7J1olou7EvsSw0YGdENmZ5lq+ruUyBhs36XYrTfP/JU5yM+cAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BmRd+6W7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suClD5IW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155624.590144807@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7wM4JqSDsBc0GGoxvDmULTCoxYPRMDLvcja00XnHjd0=;
	b=BmRd+6W7rTXukGk5lg6o8vRU1NtIL+Oet0dimnhTqj/yC5X7/V1cALMU9+4Uf2p23HdsW5
	5GTMUtf095HumeCWaW+UzUTtkz+Na/gYkWHkEnaaLzjk5AxITvCKXcONjEV14E9e1Ejgzj
	HnaFiVl1qjHMwyrA9K+aV2iQkdcAGqn2XkDxSVivgFzTR2gevv0a6sB3wbrAZ09BDUcM4K
	NimCmvIe3ZF4vRse1hVj36moXQxD87QKTCPM8BEiKeDLVfkPyb9nRPJNFyDd8Ti0z6IFwf
	pMi5rBis4GnLhDs7UHKBR7l2kIVZi+dEWD67LEgiOj0W2LANcE03xRqhDzpUIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7wM4JqSDsBc0GGoxvDmULTCoxYPRMDLvcja00XnHjd0=;
	b=suClD5IWwnHlbnPsxaJvI8FIeL6HZMI/QkVirfbPFBEupKebq+QdRuV1ObJxQVWGrwrG16
	z9fVwmt6UUBZQKBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 18/18] selftests/timers/posix-timers: Add a test for exact
 allocation mode
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:49 +0100 (CET)

The exact timer ID allocation mode is used by CRIU to restore timers with a
given ID. Add a test case for it.

It's skipped on older kernels when the prctl() fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
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
+#ifndef define PR_TIMER_CREATE_RESTORE_IDS
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


