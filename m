Return-Path: <linux-kernel+bounces-370966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6B39A347C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C4B1F244BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BC3184528;
	Fri, 18 Oct 2024 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlKinVhF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7C16A956
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230453; cv=none; b=oq12r6kqV9GwO7MojKPlhaNOs9FnGYiRUpXEnUjGKZaHyd39YKa5SuTOiINgUHtybXoMEhN01J8mbT0jG/F0/U7NUxU6ngXg06p/ylcP6ClFnZ82buysy7O90jKFaBqZEEJI3btzP9nHs9GAEREbbgQkB+S0Rs4pA8Z1S0T2ijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230453; c=relaxed/simple;
	bh=YP95DtVxXZ3m+MQlhugoobD6ADZipWZQ6/Y1bwP+wc8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a/jDN9qTP7Kd0mloH5YTYRvQFmcHIXUEDq2k/bpEq5Mmkc7gVta9F+42C3LBl7q0PA4YXyTqIk5GZ86KmZRMyLhevibEWxKljwdCoTWzCIz7A9ERprcW5IzQ0KuNonjFuPxFAFKogf9miYqwO3ZLRs12kEmQgVtJXcNSmDEPhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlKinVhF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38fabff35so33154167b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230451; x=1729835251; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGsyk1AzrV7bGd+qNQRt08SgX/qTGBP7C2TEAC3B6es=;
        b=zlKinVhFKOmSqIT7P8RYozj3VJj3LiNFEYoUKQtApo0Kblp9xxzF+Abk+l2eb8Ue/m
         of6SRwkEIgilJfH5BEcLxA6f1nNMwCkFQNyDT3nOFLXr3GpwPwrwNBPYcX0M9FxH936x
         OocpEATgGgzcqh+duxRleXO+/g+HdGZGv7hGibq9CtoCmQnBIrWUSsdt54BMGT/IQDgT
         zirHdgIUfGYKSmbMqslnpp4J8vz3caqPZPjnAmMtdKpKHIR+RPTkN1oyKBx+/WdOwEgz
         G7cMcJRkAMntd8mDmjPtq2L6JW9M15HFt9U86pjxKf1gw8cUEdahWUGJmOdn1GI1qsos
         fKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230451; x=1729835251;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGsyk1AzrV7bGd+qNQRt08SgX/qTGBP7C2TEAC3B6es=;
        b=Ov/wEaQWavB0eEC7St56gsRglY7FDCvBVoa8dDE7IfdPP0YIvRcXnGUvqbiI247jka
         jM577J7T6iX8skfSv2EpxXvIjTDBp4OIXwQBhDm1YRVhNUEukS2pgqH47N82Ucu9dAEM
         uKNZeA35s1dq/tQUAPOr6l9n7oFG87uNq6EeLHU38XvORc/+4hyjhPVAbWghDbLnu35C
         O2TuacofA/BQXW1OBX6vewKViKOXj3YGenIg3oLBZIE13NyQ9LD0/Sw+18zhfVqhH7CD
         x7GjqPmWxZj55u//AUhgQZEm6mkH86xNK5MIziY5klmQn52V1LG1tJuOlm64dlkyQlQX
         RLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBliUy+ErfisYORYyCtZHRs6acF/F0sxx7FLq8DPoNB+2bsf/l0FTd0tVX89JgNnyrLXOGWS/snFbIGvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0is8rwrhBWHSJsmvFCCu3OYE+iGZHtNnYfWjABBXCMaovbv2
	OEV4ycPpQewKMMlv6Y0QRDuYXd6GZbpFgFd24cyKngWZZIRZWwzrEU2oAAXcMX9xx7DBoMkdOWJ
	qEVOF6Q==
X-Google-Smtp-Source: AGHT+IElZxi4gKlHpKHuQcILQunGIrccEF/5kNieA5pjiK5bJX7QyzdVU789CKgaouu+VvSlRqh+Z8wc5LlT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a05:690c:368d:b0:6e2:12e5:356f with SMTP
 id 00721157ae682-6e5bfd21dbbmr472747b3.3.1729230450809; Thu, 17 Oct 2024
 22:47:30 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:11 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 1/9] tools subcmd: Add non-waitpid check_if_command_finished()
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

Using waitpid can cause stdout/stderr of the child process to be
lost. Use Linux's /prod/<pid>/status file to determine if the process
has reached the zombie state. Use the 'status' file rather than 'stat'
to avoid issues around skipping the process name.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/run-command.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 4e3a557a2f37..0a764c25c384 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -2,6 +2,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <ctype.h>
 #include <fcntl.h>
 #include <string.h>
 #include <linux/string.h>
@@ -217,8 +218,40 @@ static int wait_or_whine(struct child_process *cmd, bool block)
 
 int check_if_command_finished(struct child_process *cmd)
 {
+#ifdef __linux__
+	char filename[FILENAME_MAX + 12];
+	char status_line[256];
+	FILE *status_file;
+
+	/*
+	 * Check by reading /proc/<pid>/status as calling waitpid causes
+	 * stdout/stderr to be closed and data lost.
+	 */
+	sprintf(filename, "/proc/%d/status", cmd->pid);
+	status_file = fopen(filename, "r");
+	if (status_file == NULL) {
+		/* Open failed assume finish_command was called. */
+		return true;
+	}
+	while (fgets(status_line, sizeof(status_line), status_file) != NULL) {
+		char *p;
+
+		if (strncmp(status_line, "State:", 6))
+			continue;
+
+		fclose(status_file);
+		p = status_line + 6;
+		while (isspace(*p))
+			p++;
+		return *p == 'Z' ? 1 : 0;
+	}
+	/* Read failed assume finish_command was called. */
+	fclose(status_file);
+	return 1;
+#else
 	wait_or_whine(cmd, /*block=*/false);
 	return cmd->finished;
+#endif
 }
 
 int finish_command(struct child_process *cmd)
-- 
2.47.0.105.g07ac214952-goog


