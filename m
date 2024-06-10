Return-Path: <linux-kernel+bounces-208570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3699026EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09370282CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20E14D70A;
	Mon, 10 Jun 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z0W7zjV3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRFWhPWJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA7147C6E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037740; cv=none; b=dPWG1+Pql865kxNYNcSy/XdSq/ZPn/xYQoUCijeoh9B7y1A5RrP22BmI2g37bOxm4yN/KYK7XIuy7JK847aHhRE09kGUsk5M/9dKPjJSq4Dv1N2C3beYHTyzM44nc1PQfiBGFBh1d0N80sVEKyIoXewtEAEbK3uTQvmpeSo3TKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037740; c=relaxed/simple;
	bh=dFadCdHIj/hoRcxQcT8VgvmC98onMotQm8AlW+HXtsQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OGYpuSnxgJX2i63mac7IZOHI+XQQpIUbgR/uIryDY9s4BxlSF3s4sn2qIvguR/CfH6klD3GPnMj+CHOlsRRNCtIYMpGeO5LJnVAtl64IVp7HUi/BRKza22NcV1MDnmRp5RDnugk+Mk9bfvvbmMnKofcKNvjkbviUU1Ia4nHsOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z0W7zjV3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRFWhPWJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164025.706799004@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wBuqBPrJ78lfRZ7AX91zzV87OtbmlXth39hEp1fmaS0=;
	b=z0W7zjV3SoeueiMAK1PqkaS4nh7M77goZqu6u98QpNYvKRwrawvr2IEZYJ5w2slKAFDWtI
	Toz7vhOIL0uslByig/UIVbfs61G9zDkU+ckZS+7bYM8qThD/tJ+O0fBVnEggCwzV1sYA+l
	GND2JktPuxWAmL/9lpeQhyJxIeTyfYlR29rjBrdXy3/CVUUe5BYs4MSZRWIAPLeVCVoPuU
	egbm9n8uRl3yo4TqdWCt1TVlZ1CaMWmh8AHVswjl+T8EfMj5vuJ5N+jlHzbaw5/bUuRASh
	VOkzydFgoQ3ul0r8kljb0eubFFoyWwrRc6iHn4mJrq2kW4NsQjMc/KCNzmbBJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wBuqBPrJ78lfRZ7AX91zzV87OtbmlXth39hEp1fmaS0=;
	b=JRFWhPWJQ3Mnz25QlCOKArAHswe37JgDMOVj00ac0fSwopU+AFjoE/2D3YJy8jzFgQ/RkR
	Y533diIUSXFCicAQ==
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
Subject: [patch V3 04/51] selftests/timers/posix-timers: Validate SIGEV_NONE
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:10 +0200 (CEST)

Posix timers with a delivery mode of SIGEV_NONE deliver no signals but the
remaining expiry time must be readable via timer_gettime() for both one
shot and interval timers.

That's implemented correctly for regular posix timers but broken for posix
CPU timers.

Add a self test so the fixes can be verified.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   53 +++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -11,6 +11,7 @@
 #include <sys/types.h>
 #include <stdio.h>
 #include <signal.h>
+#include <stdint.h>
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
@@ -20,6 +21,7 @@
 
 #define DELAY 2
 #define USECS_PER_SEC 1000000
+#define NSECS_PER_SEC 1000000000
 
 static void __fatal_error(const char *test, const char *name, const char *what)
 {
@@ -438,10 +440,57 @@ static void check_delete(void)
 	ksft_test_result(!tsig.signals, "check_delete\n");
 }
 
+static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
+{
+	int64_t diff;
+
+	diff = NSECS_PER_SEC * (int64_t)((int) t1.tv_sec - (int) t2.tv_sec);
+	diff += ((int) t1.tv_nsec - (int) t2.tv_nsec);
+	return diff;
+}
+
+static void check_sigev_none(int which, const char *name)
+{
+	struct timespec start, now;
+	struct itimerspec its;
+	struct sigevent sev;
+	timer_t timerid;
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_NONE;
+
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	timer_settime(timerid, 0, &its, NULL);
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	if (timer_gettime(timerid, &its))
+		fatal_error(name, "timer_gettime()");
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(its.it_value.tv_sec || its.it_value.tv_nsec,
+			 "check_sigev_none %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(10);
+	ksft_set_plan(12);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -467,6 +516,8 @@ int main(int argc, char **argv)
 	check_sig_ign(1);
 	check_rearm();
 	check_delete();
+	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
 
 	ksft_finished();
 }


