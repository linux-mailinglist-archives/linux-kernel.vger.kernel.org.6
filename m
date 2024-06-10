Return-Path: <linux-kernel+bounces-208568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC59026E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A571CB21C78
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353814C5BE;
	Mon, 10 Jun 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bvhOmmGk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="54xHgEiE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B581474B9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037740; cv=none; b=awrs9MijhTrQW/Vbbc6OtMZEm+kFiwU+R3m+KT0APLoFWlUdmTWr/K5BLhLkyHMziOhc55DhSHtcd01NjYgrJor1/NGOGl9oLPfKObl+ZdQPUrlzgEofLELV6GdWU76y85rfpIePpFlDg8OmFz9XfYNNYmMpNRlJZ2uF2O5L2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037740; c=relaxed/simple;
	bh=Qw6a6vr3job2BPNhi3+9A2NeMwWriv1M9zdK8XeX/E8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hiZQJvA0lV7aXgJCEWZMCoK8s3xVXk8YYEgL49GWwUNlmbf02bcD9lzZrm6M2sU3Xa++BAKnnSgEzfl9jXUvabhmMVYinbawZ7fTP1jrImBRfsay/5ntPIzWNqaz2pRzUyqj2QjLd7DJQLRPWJKHqTUhpdZjJLL1pvjrQ8R/g58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bvhOmmGk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=54xHgEiE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164025.770458477@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7n8Tw6w2v5Y162ZsOpKlDwSopUc0/cD/VnEumBQN9lE=;
	b=bvhOmmGkK5yGsZZv+PH4sh94JC14KGR+imMTHgyuHuNvk/GI8R5d3X734tdrTOvUsAs8RH
	5FH4dxdMRdo1VIVSXoUImREQCti9+rYHlTKJeYaHnnVbUIN1iPcJqFPJMePZ7iGphkRtPO
	yElJGm7TMRmyVTdQp30R1TDARAqMXhaRP2WptHSd6UMzKMlVN9mqmfIHx9u8S6gaysEiDV
	YfsSYzXLaiBp7A7IpyZfmlI4ehGaGEthPclcAJZEG0PZoGK3JPRXwBMLgP0ZFlNML3gZQS
	7ynGXXl+/70NMnoDviFFevsMXdJfiSEMwhT+XEiJFxb8zHO+iRu03YpBdjL2Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7n8Tw6w2v5Y162ZsOpKlDwSopUc0/cD/VnEumBQN9lE=;
	b=54xHgEiEfEPgGVu+cv242Ke+UqUqvtMChDKDI8HmYZQOcy2xIiOaFI8MbnRVc7ekb5/U7a
	IrTCdoiHv4D3fcAA==
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
Subject: [patch V3 05/51] selftests/timers/posix-timers: Validate
 timer_gettime()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:11 +0200 (CEST)

timer_gettime() must return the correct expiry time for interval timers
even when the timer is not armed, which is the case when a signal is
pending but blocked.

Works correctly for regular posix timers, but not for posix CPU timers.

Add a selftest to validate the fixes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   58 +++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -487,10 +487,63 @@ static void check_sigev_none(int which,
 			 "check_sigev_none %s\n", name);
 }
 
+static void check_gettime(int which, const char *name)
+{
+	struct itimerspec its, prev;
+	struct timespec start, now;
+	struct sigevent sev;
+	timer_t timerid;
+	int wraps = 0;
+	sigset_t set;
+
+	/* Block the signal */
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	if (sigprocmask(SIG_BLOCK, &set, NULL))
+		fatal_error(name, "sigprocmask(SIG_BLOCK)");
+
+	memset(&sev, 0, sizeof(sev));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR1;
+
+	if (timer_create(which, &sev, &timerid))
+		fatal_error(name, "timer_create()");
+
+	/* Start the timer to expire in 100ms and 100ms intervals */
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 100000000;
+	its.it_interval.tv_sec = 0;
+	its.it_interval.tv_nsec = 100000000;
+	if (timer_settime(timerid, 0, &its, NULL))
+		fatal_error(name, "timer_settime()");
+
+	if (timer_gettime(timerid, &prev))
+		fatal_error(name, "timer_gettime()");
+
+	if (clock_gettime(which, &start))
+		fatal_error(name, "clock_gettime()");
+
+	do {
+		if (clock_gettime(which, &now))
+			fatal_error(name, "clock_gettime()");
+		if (timer_gettime(timerid, &its))
+			fatal_error(name, "timer_gettime()");
+		if (its.it_value.tv_nsec > prev.it_value.tv_nsec)
+			wraps++;
+		prev = its;
+
+	} while (calcdiff_ns(now, start) < NSECS_PER_SEC);
+
+	if (timer_delete(timerid))
+		fatal_error(name, "timer_delete()");
+
+	ksft_test_result(wraps > 1, "check_gettime %s\n", name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(12);
+	ksft_set_plan(15);
 
 	ksft_print_msg("Testing posix timers. False negative may happen on CPU execution \n");
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
@@ -518,6 +571,9 @@ int main(int argc, char **argv)
 	check_delete();
 	check_sigev_none(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
 	check_sigev_none(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_gettime(CLOCK_MONOTONIC, "CLOCK_MONOTONIC");
+	check_gettime(CLOCK_PROCESS_CPUTIME_ID, "CLOCK_PROCESS_CPUTIME_ID");
+	check_gettime(CLOCK_THREAD_CPUTIME_ID, "CLOCK_THREAD_CPUTIME_ID");
 
 	ksft_finished();
 }


