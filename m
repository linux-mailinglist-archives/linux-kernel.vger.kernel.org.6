Return-Path: <linux-kernel+bounces-208565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEDF9026E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250271C20DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1541474AD;
	Mon, 10 Jun 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1R5/nSMI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2oJg0rd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7E14387C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037737; cv=none; b=DE8zkKqqW8XZBZa0AYYTGL386ZBdRt1jCSRAjRfUJQgTbifEZT+qnRkGiVWqtzNZSbks45r0Tba8ASKZFQO1M/2XTYo9GQYIY7U6Jtr6qIgYZre7bnxq0+AC9JP5wEGMumibj+kwqWsQ10rLfKooSve37goEGMJ5Jc1+1yVM0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037737; c=relaxed/simple;
	bh=vz+fAlWfBudifV6kxVCQAtsMqb+wBrh8FfCHN8/yRLk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Um4eIeBgKkdhrtUzxSTE2wUpMbiQdcIfPAw5NLgX834Jjr0TkBZGzR+I+EyY0jH5JZfjrTNCY7NLWtjTphMLgovnIow+cx9+1ps3uT9Bw5kCD6a/wzuKMkcUM2iXRlPPHmd7ydDXdY9h8vYGcp4wRaHUuDXSrdnzvqOZ+p7eoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1R5/nSMI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2oJg0rd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164025.515974472@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DncafhmcWT8Rsehj8z94B5VTVvkoj9TI/ZrdPNRUKUQ=;
	b=1R5/nSMIRuckNX9bWe7xHc4IaYhBPsCbrUPss0L3TLRiU3+Q+XB4MHyBkC+7l/C9NlfCdg
	FmQSrc1M0GJp9gnK0K9K2khAnYLNSk93DckMsz+0EvOSNXzKl6YF8XNFhdIjMe1gklZHt3
	EMuAXdDI8L+oEzjJ+xR2m/VM25OZ/w/TKGbJiy+OHZkeOkLNjyWNyiLOfx7kYjUHKB5jfv
	Eb/T1Qz+BDVqZipJZOu1Cy4xh6dtMftUs79Ghd21Ut2LWJdXCtYDsIli+lvrkqfb8jc7AV
	cK5CzhkvvGF0ChUPSwpxjWr6Kv6URWBHX7706K7cqhtESR/05fvx3uAzoaPaDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DncafhmcWT8Rsehj8z94B5VTVvkoj9TI/ZrdPNRUKUQ=;
	b=C2oJg0rdH6UpfKG6Kd6MCr2UYlfNCfoSXnrm7IlTOJrMzKFJwwXkzZAGX7lSqF4dy/I6+7
	r/VU06M9Uj9+/BAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V3 01/51] selftests/timers/posix_timers: Simplify error
 handling
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:06 +0200 (CEST)

No point in returning to main() on fatal errors. Just exit right away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |  151 ++++++++------------------
 1 file changed, 52 insertions(+), 99 deletions(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -10,6 +10,7 @@
 #include <sys/time.h>
 #include <stdio.h>
 #include <signal.h>
+#include <string.h>
 #include <unistd.h>
 #include <time.h>
 #include <pthread.h>
@@ -19,6 +20,20 @@
 #define DELAY 2
 #define USECS_PER_SEC 1000000
 
+static void __fatal_error(const char *test, const char *name, const char *what)
+{
+	char buf[64];
+
+	strerror_r(errno, buf, sizeof(buf));
+
+	if (name && strlen(name))
+		ksft_exit_fail_msg("%s %s %s %s\n", test, name, what, buf);
+	else
+		ksft_exit_fail_msg("%s %s %s\n", test, what, buf);
+}
+
+#define fatal_error(name, what)	__fatal_error(__func__, name, what)
+
 static volatile int done;
 
 /* Busy loop in userspace to elapse ITIMER_VIRTUAL */
@@ -74,24 +89,13 @@ static int check_diff(struct timeval sta
 	return 0;
 }
 
-static int check_itimer(int which)
+static void check_itimer(int which, const char *name)
 {
-	const char *name;
-	int err;
 	struct timeval start, end;
 	struct itimerval val = {
 		.it_value.tv_sec = DELAY,
 	};
 
-	if (which == ITIMER_VIRTUAL)
-		name = "ITIMER_VIRTUAL";
-	else if (which == ITIMER_PROF)
-		name = "ITIMER_PROF";
-	else if (which == ITIMER_REAL)
-		name = "ITIMER_REAL";
-	else
-		return -1;
-
 	done = 0;
 
 	if (which == ITIMER_VIRTUAL)
@@ -101,17 +105,11 @@ static int check_itimer(int which)
 	else if (which == ITIMER_REAL)
 		signal(SIGALRM, sig_handler);
 
-	err = gettimeofday(&start, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&start, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
 
-	err = setitimer(which, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (setitimer(which, &val, NULL) < 0)
+		fatal_error(name, "setitimer()");
 
 	if (which == ITIMER_VIRTUAL)
 		user_loop();
@@ -120,68 +118,41 @@ static int check_itimer(int which)
 	else if (which == ITIMER_REAL)
 		idle_loop();
 
-	err = gettimeofday(&end, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&end, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
 
 	ksft_test_result(check_diff(start, end) == 0, "%s\n", name);
-
-	return 0;
 }
 
-static int check_timer_create(int which)
+static void check_timer_create(int which, const char *name)
 {
-	const char *type;
-	int err;
-	timer_t id;
 	struct timeval start, end;
 	struct itimerspec val = {
 		.it_value.tv_sec = DELAY,
 	};
-
-	if (which == CLOCK_THREAD_CPUTIME_ID) {
-		type = "thread";
-	} else if (which == CLOCK_PROCESS_CPUTIME_ID) {
-		type = "process";
-	} else {
-		ksft_print_msg("Unknown timer_create() type %d\n", which);
-		return -1;
-	}
+	timer_t id;
 
 	done = 0;
-	err = timer_create(which, NULL, &id);
-	if (err < 0) {
-		ksft_perror("Can't create timer");
-		return -1;
-	}
-	signal(SIGALRM, sig_handler);
 
-	err = gettimeofday(&start, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (timer_create(which, NULL, &id) < 0)
+		fatal_error(name, "timer_create()");
 
-	err = timer_settime(id, 0, &val, NULL);
-	if (err < 0) {
-		ksft_perror("Can't set timer");
-		return -1;
-	}
+	if (signal(SIGALRM, sig_handler) == SIG_ERR)
+		fatal_error(name, "signal()");
+
+	if (gettimeofday(&start, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
+
+	if (timer_settime(id, 0, &val, NULL) < 0)
+		fatal_error(name, "timer_settime()");
 
 	user_loop();
 
-	err = gettimeofday(&end, NULL);
-	if (err < 0) {
-		ksft_perror("Can't call gettimeofday()");
-		return -1;
-	}
+	if (gettimeofday(&end, NULL) < 0)
+		fatal_error(name, "gettimeofday()");
 
 	ksft_test_result(check_diff(start, end) == 0,
-			 "timer_create() per %s\n", type);
-
-	return 0;
+			 "timer_create() per %s\n", name);
 }
 
 static pthread_t ctd_thread;
@@ -209,15 +180,14 @@ static void *ctd_thread_func(void *arg)
 
 	ctd_count = 100;
 	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
-		return "Can't create timer\n";
+		fatal_error(NULL, "timer_create()");
 	if (timer_settime(id, 0, &val, NULL))
-		return "Can't set timer\n";
-
+		fatal_error(NULL, "timer_settime()");
 	while (ctd_count > 0 && !ctd_failed)
 		;
 
 	if (timer_delete(id))
-		return "Can't delete timer\n";
+		fatal_error(NULL, "timer_delete()");
 
 	return NULL;
 }
@@ -225,19 +195,16 @@ static void *ctd_thread_func(void *arg)
 /*
  * Test that only the running thread receives the timer signal.
  */
-static int check_timer_distribution(void)
+static void check_timer_distribution(void)
 {
-	const char *errmsg;
-
-	signal(SIGALRM, ctd_sighandler);
+	if (signal(SIGALRM, ctd_sighandler) == SIG_ERR)
+		fatal_error(NULL, "signal()");
 
-	errmsg = "Can't create thread\n";
 	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
-		goto err;
+		fatal_error(NULL, "pthread_create()");
 
-	errmsg = "Can't join thread\n";
-	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
-		goto err;
+	if (pthread_join(ctd_thread, NULL))
+		fatal_error(NULL, "pthread_join()");
 
 	if (!ctd_failed)
 		ksft_test_result_pass("check signal distribution\n");
@@ -245,10 +212,6 @@ static int check_timer_distribution(void
 		ksft_test_result_fail("check signal distribution\n");
 	else
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
-	return 0;
-err:
-	ksft_print_msg("%s", errmsg);
-	return -1;
 }
 
 int main(int argc, char **argv)
@@ -259,17 +222,10 @@ int main(int argc, char **argv)
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
-	if (check_itimer(ITIMER_VIRTUAL) < 0)
-		ksft_exit_fail();
-
-	if (check_itimer(ITIMER_PROF) < 0)
-		ksft_exit_fail();
-
-	if (check_itimer(ITIMER_REAL) < 0)
-		ksft_exit_fail();
-
-	if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
-		ksft_exit_fail();
+	check_itimer(ITIMER_VIRTUAL, "ITIMER_VIRTUAL");
+	check_itimer(ITIMER_PROF, "ITIMER_PROF");
+	check_itimer(ITIMER_REAL, "ITIMER_REAL");
+	check_timer_create(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	/*
 	 * It's unfortunately hard to reliably test a timer expiration
@@ -280,11 +236,8 @@ int main(int argc, char **argv)
 	 * to ensure true parallelism. So test only one thread until we
 	 * find a better solution.
 	 */
-	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
-		ksft_exit_fail();
-
-	if (check_timer_distribution() < 0)
-		ksft_exit_fail();
+	check_timer_create(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_timer_distribution();
 
 	ksft_finished();
 }


