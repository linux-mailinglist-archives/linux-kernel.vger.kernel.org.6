Return-Path: <linux-kernel+bounces-528682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAAA41A94
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E3A3ACCE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7FC256C69;
	Mon, 24 Feb 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPCsXcVf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dWOo6AWA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF824E4B0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392144; cv=none; b=tjUtRA3TJMX05zIddIHx30b8NV2V3F22BfsGo37ImrXaUAoKGTnvf9C7Jef6sLRFA1le6TZyCHqLCbVHKKrN5HjSqxns6ChA/XP65H2GmPWFsxht6QzXMFGldmUvZbMt0MYEceEmFzfVrjWVeZo8GMoHHujwfGDvXkg2P0xtjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392144; c=relaxed/simple;
	bh=nYZZhHJLGe1myZ2Y5eWN6i9XXZzDhbtyKF0ZgvRPPW4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VBQQzJjSIwxqgvU4jwesEGr9ocZvtUlUVHy5//jfx59yK68UNRNHBJ0zUMJZtb5p4H4HjcGlNQGvsHmkdnPYpwORvnWU2nSr+3+X1d+DluBRd0os+LiZfrkaYTCVZtN/P2aHc2+9juO52AzFmkfPNsG6wDS0Lk7U8U3bnzTA4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HPCsXcVf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dWOo6AWA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.672288753@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BbMg7HjWIRqHiwnyJ0qix1onrX11tdlxf6bBcAlKQxs=;
	b=HPCsXcVfeSjdU9dHObds7CWU+o9IjBsOj4Vl5lZQLwYS2Lnbt0skVj3dHnolrJMQWRZeA4
	hV/1/4YL7WJuzglgV7UdB86+oXjetdS6YFEqC6IjqFOKVgLn3XLH0xi2z9N1oCBFhYUyHp
	Y5oTu8lDbL+ekJ++DF5Emd4oUdBEstvkYsOSXwTSuk/3/eAYvHSHNNlQr6R4K188CAGnfB
	9HVAmUFrnQ+nkqDL+PTN2Ou50BRzjfyvjPtw/Ol0PtM2APeb7jU92FjHpOvh7HwyyWWIMU
	Sa0FyVbnyEedbiTqypqZs6KXg3TnA5jKVtrjtcoSS2tjEo2Clh2mlEPeUssUPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BbMg7HjWIRqHiwnyJ0qix1onrX11tdlxf6bBcAlKQxs=;
	b=dWOo6AWArJFlHDUJbRuBA93JZKoiXwubZH/RZBFYcnVHkha83zqK6v5jZmoC47y2/cb7yl
	74odQDthSOjvB3Dg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 11/11] selftests/timers/posix-timers: Add a test for exact
 allocation mode
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:41 +0100 (CET)

The exact timer ID allocation mode is used by CRIU to restore timers with a
given ID. Add a test case for it.

It's skipped on older kernels when the prctl() fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/timers/posix_timers.c |   68 +++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

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
@@ -599,14 +600,79 @@ static void check_overrun(int which, con
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
+static void check_timer_create_exact(void)
+{
+	int id, rid;
+
+	/* Allocate a timer for comparison after switch back from exact mode */
+	if (do_timer_create(&id) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(id))
+		fatal_error(NULL, "timer_delete()");
+
+	if (prctl(77, 1, 0, 0, 0)) {
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
+	rid = id + 8;
+	if (do_timer_create(&rid) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(rid))
+		fatal_error(NULL, "timer_delete()");
+
+	if (prctl(77, 0, 0, 0, 0))
+		fatal_error(NULL, "prctl()");
+
+	if (rid != id + 8) {
+		ksft_test_result_fail("check timer create exact %d != %d\n", rid, id + 8);
+		return;
+	}
+
+	/* Validate that it went back to normal mode */
+	if (do_timer_create(&rid) < 0)
+		fatal_error(NULL, "timer_create()");
+
+	if (do_timer_delete(rid))
+		fatal_error(NULL, "timer_delete()");
+
+	/* Same ID if linear mode is off, next ID if enabled */
+	if (rid == id || rid == id + 1)
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


