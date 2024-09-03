Return-Path: <linux-kernel+bounces-313682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE1596A899
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606F11C20A53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268381D5CCB;
	Tue,  3 Sep 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXlMWqtN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AD1D223A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396015; cv=none; b=YiZGO1ua6cjMrt8NIqe3pnLPiwVj6RZ0U8RAR+7aLWLqYPWFmVdFH5QJOT+x5OpGgDjW9tpo4TTtmDduBWjWTdvt2f6UvdR9ZejEEo018gJu44idQkM3T8HCcbodEOzEX4TmGG6GNmWSwUsB4oREYQYUNzg3a8tLQRJ47nvKym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396015; c=relaxed/simple;
	bh=cCmLjf308k6OsUJLrInpoUdAeJs7fWLaNbFSDImA684=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pfxuq/Tl83IofHNlgcNmCIwb/tc973F/4reHD7GR37Ewu9dkudYwNxWW+OYJ41qa/ayO/EhWMVzEns5Ey3C2oPqVcrqSflJA414qhDCbvCcOKr1dG0CT7njSEhnlpA+nArxsRJNuChl4kxehLtiJrT7VOU24SfHJYqLJ7YWp/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXlMWqtN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b47ff8a5c4so111015497b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725396013; x=1726000813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gr0+wD1hQSkgsAJy15LgXOqT17mmHStoYkWLI3kOh1E=;
        b=cXlMWqtNbG9zhOlXPMihLtpr5nhe4BzDkxU9LdrLlY1lJCr5OIn0+6jSm8HZYY0422
         Br8c7ZwVzdtkU5vc7xEMh+Uh3naN2azLlpctk0/S4hwGt4Ut65eRRds71TI5BXPDi6ea
         3xD8Mo86RI6INjS0rO/lIO39LC3qV6iWyRMHlhzxhQ0Hz+LvpJXKMytpZEPMf3gFn+TH
         lyhBgfRDmDieONFeHqF8G4purijtXERbF6JprBf+nfcK4KxSYUwp66JR0mPrQ1lD+b//
         35o9b355/bl34igrZgd3sfVVgW5v5dmERdrjO2hVyj2b8O9jJQtHLMw9gJ7q1uiBkiSv
         W55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725396013; x=1726000813;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gr0+wD1hQSkgsAJy15LgXOqT17mmHStoYkWLI3kOh1E=;
        b=tm6k5/NJFW4xDsJ9LpbpHTqkpW03DmuTZq6YbT+q8EyGkkd5bmeUibgAO5ycqFvYeB
         Vz0xW0qvcU6JpNa/EV+s0hBvPYk9F7VPO9Zw0MX84sxCNW+/m8LrA4i6NlW4ICli9FUK
         1QR3RNtJaYAaMLOT5aIPAVm5c9aWcME7rUlfYiSTeHadi9aSoAk2Zx6NZ4tqiqcfAcwp
         IHILJgoXjag1m+0Dn7n83lFT4lW7nySbuBURM4S0Kn2Q44yBP3+6GpxOGJjspi776cFG
         6HksRW7sRN8c02krkrE7o0jE0LaKIpHKu6t3sqdX5MAH2tm8gPlu5LvSKABwuSOQOOx3
         tFcA==
X-Gm-Message-State: AOJu0YwcJjHGAiag+StHkSWzA//hxRPkCJw1o9cFh76Pa6lyl+5tWWTv
	W1Afryi1NI5PJw/zwC6Al+m0+5MDS96BYq3iNHbzDTu6fp1RmPlS5pAZ0oFW3oY3EaOnnJTLF6J
	s+A==
X-Google-Smtp-Source: AGHT+IFl6cBrYkda8nNgdZrTivfv3zjTpKUU2f25L9umrr7vatGI4GPL+9fg9hOyModMI6oj7rvGWFpN3Tw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:4888:b0:6ad:e9c1:fc4f with SMTP id
 00721157ae682-6d40f922d32mr317297b3.5.1725396012716; Tue, 03 Sep 2024
 13:40:12 -0700 (PDT)
Date: Tue,  3 Sep 2024 20:39:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240903203915.3383774-1-edliaw@google.com>
Subject: [PATCH RESEND] selftests/futex: Order calls in futex_requeue
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Shuah Khan <shuah@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Davidlohr Bueso <dbueso@suse.de>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Similar to fbf4dec70277 ("selftests/futex: Order calls to
futex_lock_pi"), which fixed a flake in futex_lock_pi due to racing
between the parent and child threads.

The same issue can occur in the futex_requeue test, because it expects
waiterfn to make progress to futex_wait before the parent starts to
requeue. This is mitigated by the parent sleeping for WAKE_WAIT_US, but
it still fails occasionally. This can be reproduced by adding a sleep in
the waiterfn before futex_wait:

TAP version 13
1..2
not ok 1 futex_requeue simple returned: 0
not ok 2 futex_requeue simple returned: 0
not ok 3 futex_requeue many returned: 0
not ok 4 futex_requeue many returned: 0

Instead, replace the sleep with barriers to make the sequencing
explicit.

Fixes: 7cb5dd8e2c8c ("selftests: futex: Add futex compare requeue test")
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../selftests/futex/functional/futex_requeue.c       | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 51485be6eb2f..8f7d3e8bf32a 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -12,9 +12,9 @@
 
 #define TEST_NAME "futex-requeue"
 #define timeout_ns  30000000
-#define WAKE_WAIT_US 10000
 
 volatile futex_t *f1;
+static pthread_barrier_t barrier;
 
 void usage(char *prog)
 {
@@ -32,6 +32,8 @@ void *waiterfn(void *arg)
 	to.tv_sec = 0;
 	to.tv_nsec = timeout_ns;
 
+	pthread_barrier_wait(&barrier);
+
 	if (futex_wait(f1, *f1, &to, 0))
 		printf("waiter failed errno %d\n", errno);
 
@@ -70,13 +72,15 @@ int main(int argc, char *argv[])
 	ksft_print_msg("%s: Test futex_requeue\n",
 		       basename(argv[0]));
 
+	pthread_barrier_init(&barrier, NULL, 2);
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
 	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
 		error("pthread_create failed\n", errno);
 
-	usleep(WAKE_WAIT_US);
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_destroy(&barrier);
 
 	info("Requeuing 1 futex from f1 to f2\n");
 	res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
@@ -99,6 +103,7 @@ int main(int argc, char *argv[])
 		ksft_test_result_pass("futex_requeue simple succeeds\n");
 	}
 
+	pthread_barrier_init(&barrier, NULL, 11);
 
 	/*
 	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
@@ -109,7 +114,8 @@ int main(int argc, char *argv[])
 			error("pthread_create failed\n", errno);
 	}
 
-	usleep(WAKE_WAIT_US);
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_destroy(&barrier);
 
 	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
 	res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
-- 
2.46.0.469.g59c65b2a67-goog


