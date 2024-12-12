Return-Path: <linux-kernel+bounces-442806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A77E9EE234
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED06528411E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D3E20CCE2;
	Thu, 12 Dec 2024 09:03:02 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7220A5D1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994182; cv=none; b=tXCkLrP7I76k/cInULAItsEtowD9wBNQ27P0iWTOced//bIlmqNeynM7RtadhifNZ3qQFr56T1pDTQp8YVvAz2ZANcKhhkuLOdqX4vJ2Z8EsWQRbg61aJtq6kJbK61F2zGptt/O81ajLwgkRhiq2EklQ0hq1OZBymUIMB4EuM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994182; c=relaxed/simple;
	bh=AsOSLqkWwAHed/g5h3ppTJF/mVD/1GWu4hpb8S7jJ4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ooXNCIZp+pUwZa5sRXxU1IUJj6xjcu46Xtj0cEDD3VzEe37phbpcygzzgSGOSyxV7YyRaatJ+n0FFZ9U903HfdzFaCc++An4B5w43Um7x6AAGbVtdhvznUBT0YQ12EXyBjuqCnQTBF7EyBzOUjsBK/vtdUgLqJf9DznrgDf4XcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a086:deff:83e6:222b])
	by andre.telenet-ops.be with cmsmtp
	id nl2y2D00Q1T2bNC01l2yMk; Thu, 12 Dec 2024 10:02:58 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tLf5z-000pxc-JH;
	Thu, 12 Dec 2024 10:02:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tLf62-00DEb1-4u;
	Thu, 12 Dec 2024 10:02:58 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 resend] selftests: timers: clocksource-switch: Adapt progress to kselftest framework
Date: Thu, 12 Dec 2024 10:02:56 +0100
Message-Id: <7dd4b9ab6e43268846e250878ebf25ae6d3d01ce.1733994134.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adapting the test to the kselftest framework, a few printf() calls
indicating test progress were not updated.

Fix this by replacing these printf() calls by ksft_print_msg() calls.

Fixes: ce7d101750ff8450 ("selftests: timers: clocksource-switch: adapt to kselftest framework")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v2:
  - Add Reviewed-by.

When just running the test, the output looks like:

    # Validating clocksource arch_sys_counter
    TAP version 13
    1..12
    ok 1 CLOCK_REALTIME
    ...
    # Validating clocksource ffca0000.timer
    TAP version 13
    1..12
    ok 1 CLOCK_REALTIME
    ...

When redirecting the test output to a file, the progress prints are not
interspersed with the test output, but collated at the end:

    TAP version 13
    1..12
    ok 1 CLOCK_REALTIME
    ...
    TAP version 13
    1..12
    ok 1 CLOCK_REALTIME
    ...
    # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:6 error:0
    # Validating clocksource arch_sys_counter
    # Validating clocksource ffca0000.timer
    ...

This makes it hard to match the test results with the timer under test.
Is there a way to fix this?  The test does use fork().

Thanks!
---
 tools/testing/selftests/timers/clocksource-switch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index c5264594064c8516..83faa4e354e389c2 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -156,8 +156,8 @@ int main(int argc, char **argv)
 	/* Check everything is sane before we start switching asynchronously */
 	if (do_sanity_check) {
 		for (i = 0; i < count; i++) {
-			printf("Validating clocksource %s\n",
-				clocksource_list[i]);
+			ksft_print_msg("Validating clocksource %s\n",
+					clocksource_list[i]);
 			if (change_clocksource(clocksource_list[i])) {
 				status = -1;
 				goto out;
@@ -169,7 +169,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	printf("Running Asynchronous Switching Tests...\n");
+	ksft_print_msg("Running Asynchronous Switching Tests...\n");
 	pid = fork();
 	if (!pid)
 		return run_tests(runtime);
-- 
2.34.1


