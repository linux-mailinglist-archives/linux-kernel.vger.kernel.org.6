Return-Path: <linux-kernel+bounces-382483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A49B0EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB651C21D69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598CD216209;
	Fri, 25 Oct 2024 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFipmsPE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1B215C49
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884079; cv=none; b=IWN5Xvf+XWEg6XYEpnJwxUyleowb/Kd6FeN20vYUOf5RIJRbb+beg9Ffg8rWXhgCsj8ph/ug6RgejUe/D9jJbjm0406mdL+WILOVLzHk5b3J0jBu/+3A1sE7WTt+NGEoAuw5Mq48tIT8LaeJAKkgqxVIWEqWoCuiW4JnjUSeQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884079; c=relaxed/simple;
	bh=k1wh2zeNE6tcCQX3Z6B3EqKklNoAQpiPb5SUkLK5tUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UHMf5prf7AventuPXPcuw8xg38RE9/+T1itdmHKwiGQuRUwdzY9UfbVRqej6beXwUNnMNE0+qoFlFWs8ZD1KbcDkBAF6XGQ/slNI6Mi6Vk+cVHV43x9ecc1yR/XHboq0Yyqskny6jwE7GrR1FuhaVBUXEjEFtgR65dq+Y28jWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFipmsPE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so29981837b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884076; x=1730488876; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emVhY31H9kbevrWQVBQDFf3nVCs1KfHQ+C3lVsleo+E=;
        b=yFipmsPECKKbS9PTRthvi3omimis4iNVlWnyHxfePLTv4tAY7yJWueTM0CGSX2NWZt
         e7cbe1+1sJ3HX7mD08Hz3PlRgKgo9YniC9ekx//rGD9sqn/9DyPRh2S6FUco7a348ajP
         fbXhCzSQ8YuOKiiz3K5O3CetUOFRDDH8Pj1fyDMA6E/CMRlh/xMp/nPTJC5ybFS47RPD
         Gp8dWBF9HQcgj/IVZOQvm+RsgoAKlklep9Xt9vn3ROwABRgEMWUitR4Hjix3T/ciascZ
         1qwTwns457veWJMXqavBMtUYe8i7pEoKHyYJBsxBVNlY2MrFHwloqCqKe4YkjEWSV2iJ
         Te8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884076; x=1730488876;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emVhY31H9kbevrWQVBQDFf3nVCs1KfHQ+C3lVsleo+E=;
        b=tZHEarJmBsBGjipa3N7HXGpeJAAVr+xmvy39Y/0+2FJbpaeyeurJ0GtaQoXD4WnuWb
         FzCsAGCidLL/6G5CYrE87G6b8ypoEgJjClRVyAG5VDv2cJ123CFAGYzSrxBDFmLJnFZM
         p7ZKGA94BX0FSEu9DtYpRuiIOa/QulRuntu70zeThahUktXizc8Zg5Uw4qnLjzGg4zg0
         y1BUo040fO+zsI4vgxwIoeR6kl2sm/ok07L1G83t3H1NmTviSR2mOcSFdX1r0+oJp+60
         KprQYPbPi1G3yvMTC1skARHluPf8TVhpN3XpMuPA+7xv1oVRLxteV2jR8dRIDwOA3R6o
         3ewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnKVTLEbyp3I46cqpNrInTrlYoWeScrEcDmwTTeUDbDfJBJvAZLdjV0l97PvBP3wnooYkI2QhD8wiwR/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYp459qqR79sjdRwkT9wi6LpZ+mbDlpxbLQ4qKjgoxGcS6MGM
	HKPuHj/f9XXYOKfJrDNqt60idAdVankK3rId51SApfvP4Ctc3ZyY6wZ1k2B6lgtw8GnTamWSRUU
	gQl4sdg==
X-Google-Smtp-Source: AGHT+IGBzSOg56Jmx0yqjJEBlMrue4ovHwcwxVIozmLEkd8y4k4vblAGd88JBuecj3LXmWaCDO2P+HJrpGro
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:480a:b0:6e2:ac0a:8982 with SMTP
 id 00721157ae682-6e842e351demr3044157b3.0.1729884076619; Fri, 25 Oct 2024
 12:21:16 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:00 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 01/10] tools subcmd: Add non-waitpid check_if_command_finished()
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
2.47.0.163.g1226f6d8fa-goog


