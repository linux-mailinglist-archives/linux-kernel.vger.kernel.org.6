Return-Path: <linux-kernel+bounces-379373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DED7C9ADDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0161C21B98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210601B2191;
	Thu, 24 Oct 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eck84fS4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399A1B0F2B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755224; cv=none; b=WJABeC2AIyIhBK03tHSovhNT4EmOdpuqxaQIeMRopoQZmXYgHPRQ9yO0Otre+mvlHwcVxc7bHlyvnJV+SppYuGKm0yBU/+z4cao5sqLuxu6Skp7NmxIRVZ9CuJ9J5zM/oA3pMlf31LGwT+6LjSpoL7vVhcm53CutTNXHA9hGiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755224; c=relaxed/simple;
	bh=6/uo9WKPPestWRkUgwt62AoatZhqYZAbu5e4hou0/hQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uF20L4kROXdmqc6TxHMD+J8GNCiNbwIphha1B9y9gwCGojJUA1w+xYcj2VC9d1W6mWYatnUMVCrYarX+0ESKZ2Yib9tyMfOBRpxclkSc2Fm0IdAHNs9nCoCQ2WFqSojnh5UxSWlJM7A0PrtPeyp5EmVlejcYMMphZRT8PDdSzA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eck84fS4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc60660dso1159216276.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755221; x=1730360021; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kvdOK9w8weA25EuFrzrtnTE25b0PHQYq3wUq/HkXk0=;
        b=eck84fS4vVSlGAP0esBAjZMgo93AAlneIJ8NwzKv4t2YeTSM7h8dw2tKO/Nu1lH90J
         MXhQd6i54EGUsR3tJVXrrQe1jKKKu3cyEJW7tdOIcFDljSjgtl/GxlvFlj55ICn+lTmZ
         6cdX5QDUoeU/tX8B705osNc3sr9cvuLALUonIixegeMCb7pFqt6jR15xYkOErPNfkzov
         ln33ates0tPdnodsa8iMN8ha8mg82ZcCQ5gLTH8HjoPnrIcKSe0TJxNnnyNE9yORnPL0
         wUKy6GDix9tkKwkUKwXizF8oD8xjFNwhl4q3RKvrTti64fg2CfgqYfbbbDwvomj2e/IF
         93uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755221; x=1730360021;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kvdOK9w8weA25EuFrzrtnTE25b0PHQYq3wUq/HkXk0=;
        b=m7rjHBn0p5gArf8/U93QK5k30vFrWnsJk11MOU7xLrk5SvAiCSBszgXRVkQw5kV1zo
         Qst6lDOw0IIX9mx7neXFm79sjGQawQ9nawBJq/3Wwk96erCUf/Q8Hc7LOcYf2N+c4DpF
         2bco+JhXGzytKs5wydpprFJrLoIxE4Dh5FN7A9ye2KwNK/18tI6G7gJmwFiqwc9sdsA+
         rt+oyAXTqNDTYlM16NOZcVCXZso1ajC94JjCbONUFD01Ty5CZtZXjMCqiKgVTel7h7Et
         o9+QexUoDua4DYBscVAgGcfBLeg8CR9tswmo6Y9cdTBL9hUSFc8kYySmssZXqUiA8sOQ
         bVbA==
X-Forwarded-Encrypted: i=1; AJvYcCXT09XtDvw5sEdC9/YUjoOxJYo05CzCUumAMImmHyaVH9V4/i+p+/5u6soIYvJtQFQMvQX6meUDkYhOSAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WCwoWnMGnlSjwMQTygyKzt1B0zKnGVlZLCIwEtQVcyLF+BuX
	l0pOdduPhjyUF4PrNRkZ5XcpOoj7iXRybNyIoh2RvuEjxj3S50VgwlHMtg4jlaknf8SW9t+dS9s
	WJr7IFA==
X-Google-Smtp-Source: AGHT+IHvVhoLjSV/7Ehy0wg8Ell26mA87x4lSc80f2KbQivA+THZc1RcttmFOtpSuGHAWG7IOxNGowTUFmWT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a25:26cc:0:b0:e29:7587:66db with SMTP id
 3f1490d57ef6-e2f22f26112mr4178276.2.1729755221368; Thu, 24 Oct 2024 00:33:41
 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:20 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 06/10] perf test: Add a signal handler around running a test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a signal handler around running a test. If a signal occurs during
the test a siglongjmp unwinds the stack and output is flushed. The
global run_test_jmp_buf is either unique per forked child or not
shared during sequential execution.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0e8f877f4b1f..8a720ddb0396 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <poll.h>
 #include <unistd.h>
+#include <setjmp.h>
 #include <string.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -229,16 +230,41 @@ struct child_test {
 	int subtest;
 };
 
+static jmp_buf run_test_jmp_buf;
+
+static void child_test_sig_handler(int sig)
+{
+	siglongjmp(run_test_jmp_buf, sig);
+}
+
 static int run_test_child(struct child_process *process)
 {
-	struct child_test *child = container_of(process, struct child_test, process);
+	const int signals[] = {
+		SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGINT, SIGPIPE, SIGQUIT, SIGSEGV, SIGTERM,
+	};
+	static struct child_test *child;
 	int err;
 
+	err = sigsetjmp(run_test_jmp_buf, 1);
+	if (err) {
+		fprintf(stderr, "\n---- unexpected signal (%d) ----\n", err);
+		err = err > 0 ? -err : -1;
+		goto err_out;
+	}
+
+	child = container_of(process, struct child_test, process);
+	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
+		signal(signals[i], child_test_sig_handler);
+
 	pr_debug("--- start ---\n");
 	pr_debug("test child forked, pid %d\n", getpid());
 	err = test_function(child->test, child->subtest)(child->test, child->subtest);
 	pr_debug("---- end(%d) ----\n", err);
+
+err_out:
 	fflush(NULL);
+	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
+		signal(signals[i], SIG_DFL);
 	return -err;
 }
 
-- 
2.47.0.163.g1226f6d8fa-goog


