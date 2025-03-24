Return-Path: <linux-kernel+bounces-574549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 000EDA6E6A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA5E174E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC51F03DC;
	Mon, 24 Mar 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykaDy1Vh"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590D1EE7B1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855701; cv=none; b=qMd7j98YWe5igCSy3dfXAHuh6ATFKcTs6S5m5IBx4F9vaSBqhiYYSX+AyvMJSTZOeTlb80tMFpeBYnpcXqR7DfdmSYhiv7LOy1dk6NnEW4+Ag4jpXnsFd0S8qz4pgznS17HD69vXCLKFJ+PVViwTXWKdqZV1aaf5RgOR1obG17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855701; c=relaxed/simple;
	bh=yBzhhPVypfmeolNblUD88KPAtlHzfIA0bxATlPMR4zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rA3syQVw7J82xPlaO1wkP1frs3ivGnNlVXmrmG2w0iI7S6ZYo+4RbhZLZQfOq26wiKkW+DkqskqhWdr0fM3jVHDcRw5Pe2R2iUUc7YPLPMBKakkWnJdxrkiFnA3kKs3WHUNx9m42XHu+JSNzN9PhAWlOHZ4Y7wVPtHa96wtX6s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykaDy1Vh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224192ff68bso74876925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855699; x=1743460499; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElJ2vHXmu+8BFmjOSMBFYzJE6czzTLhTmjrbpJ1kYko=;
        b=ykaDy1VhbUZN5jwCY3X0ew5+6grU3HbZLlGeD7jID8qiN646gdjR9vb5gX++P2OUuI
         iNdIik32nOmpS5b3XCiiZGzKS71NcxZT5RNcgtvpJqPwaxTdeg075h9+B7clN9EKRxa4
         WwCJriKxdI8zcgJAN2CVPrbnKnXPgfx+S1kr0bEQvnQJNhXx8qRsXcen+bXUvLJ8Tmds
         taQP8XS0gClI4fuo+9IF3BRp95R1tzjliFU8ZZl9CrMTMSiXNovB4wLqCcGZI8BIXakV
         pyerDqVeahoVwtaW06iZxyxuuamsDVz+JD4BhWn974s+EXTT3PkIAepwOgtsT6rPzJiF
         dgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855699; x=1743460499;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElJ2vHXmu+8BFmjOSMBFYzJE6czzTLhTmjrbpJ1kYko=;
        b=dCcciMZOiqkriYMIGIXRVoGYoz3psijYWycxvc+QqTUDGzJ5Lt8p3WTU0n7GM/FQUd
         LW3Tz/EgIfXFN8KEzgcFvXURENw2HBjnbHckY7mDGn7ntQYU21hd9hYeEeUkFgWV4r0n
         rDK8KIDiJkMIbTWvTglTeHTDZn+mvexU5rFzShNk/Yi4Idm964pV8bYamQa94FVtaraC
         6RDuYgJ4bQT0sR9mw6BCT6b2tgxiay5EggaRYDT7Z9fMCIC8dFCy9yiHA+zkuqm1SbeR
         vui6014iXT+48OrnP2qapK6nubRMp9YykRq5PsXPGsNdFUM7o6vNfYM1pke36VOlUp+Q
         vgZA==
X-Forwarded-Encrypted: i=1; AJvYcCUAXHEKiR7csJ1r82p+GPd2JsrAI2ebP7N9SpaG3x4RGkTksAaA8LkTEv9jrvwbcvhI6FXhKS3yE+ZLoTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7uV2/ix58xuWyxetkTqrSToyGrfjtoB3ZAh8YWq287sX6H9yC
	H8lhXmARZUJtCS+uhrbDAuwBd/CCRFt0QLA77PZLZs6Je7Wz+Zvzq5hHTCCsWIsjD/44B0JN4Qu
	AhqqOgQ==
X-Google-Smtp-Source: AGHT+IEnNH3RKdFoCflDCnsGBhUKHdODz4nzYGEOJhKeyuWPq9Up7F1CddDsmGctnCkl6aL4xQ9/GS6elFAD
X-Received: from pfun23.prod.google.com ([2002:a05:6a00:7d7:b0:736:a134:94ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230e:b0:223:5645:8e26
 with SMTP id d9443c01a7336-22780d7fb17mr179400475ad.20.1742855698710; Mon, 24
 Mar 2025 15:34:58 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:39 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-2-irogers@google.com>
Subject: [PATCH v1 01/14] perf intel-tpebs: Simplify tpebs_cmd
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No need to dynamically allocate when there is 1. tpebs_pid duplicates
tpebs_cmd.pid, so remove. Use 0 as the uninitialized value (PID == 0
is reserved for the kernel) rather than -1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 55 ++++++++++++-----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2c421b475b3b..fb28aa211a63 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -27,11 +27,10 @@
 #define PERF_DATA		"-"
 
 bool tpebs_recording;
-static pid_t tpebs_pid = -1;
 static size_t tpebs_event_size;
 static LIST_HEAD(tpebs_results);
 static pthread_t tpebs_reader_thread;
-static struct child_process *tpebs_cmd;
+static struct child_process tpebs_cmd;
 
 struct tpebs_retire_lat {
 	struct list_head nd;
@@ -82,16 +81,6 @@ static int get_perf_record_args(const char **record_argv, char buf[],
 	return 0;
 }
 
-static int prepare_run_command(const char **argv)
-{
-	tpebs_cmd = zalloc(sizeof(struct child_process));
-	if (!tpebs_cmd)
-		return -ENOMEM;
-	tpebs_cmd->argv = argv;
-	tpebs_cmd->out = -1;
-	return 0;
-}
-
 static int start_perf_record(int control_fd[], int ack_fd[],
 				const char *cpumap_buf)
 {
@@ -109,10 +98,10 @@ static int start_perf_record(int control_fd[], int ack_fd[],
 	if (ret)
 		goto out;
 
-	ret = prepare_run_command(record_argv);
-	if (ret)
-		goto out;
-	ret = start_command(tpebs_cmd);
+	assert(tpebs_cmd.pid == 0);
+	tpebs_cmd.argv = record_argv;
+	tpebs_cmd.out = -1;
+	ret = start_command(&tpebs_cmd);
 out:
 	free(record_argv);
 	return ret;
@@ -155,14 +144,13 @@ static int process_feature_event(struct perf_session *session,
 	return 0;
 }
 
-static void *__sample_reader(void *arg)
+static void *__sample_reader(void *arg __maybe_unused)
 {
-	struct child_process *child = arg;
 	struct perf_session *session;
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = PERF_DATA,
-		.file.fd = child->out,
+		.file.fd = tpebs_cmd.out,
 	};
 	struct perf_tool tool;
 
@@ -188,12 +176,12 @@ static int tpebs_stop(void)
 	int ret = 0;
 
 	/* Like tpebs_start, we should only run tpebs_end once. */
-	if (tpebs_pid != -1) {
-		kill(tpebs_cmd->pid, SIGTERM);
-		tpebs_pid = -1;
+	if (tpebs_cmd.pid != 0) {
+		kill(tpebs_cmd.pid, SIGTERM);
 		pthread_join(tpebs_reader_thread, NULL);
-		close(tpebs_cmd->out);
-		ret = finish_command(tpebs_cmd);
+		close(tpebs_cmd.out);
+		ret = finish_command(&tpebs_cmd);
+		tpebs_cmd.pid = 0;
 		if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
 			ret = 0;
 	}
@@ -218,7 +206,7 @@ int tpebs_start(struct evlist *evsel_list)
 	 * We should only run tpebs_start when tpebs_recording is enabled.
 	 * And we should only run it once with all the required events.
 	 */
-	if (tpebs_pid != -1 || !tpebs_recording)
+	if (tpebs_cmd.pid != 0 || !tpebs_recording)
 		return 0;
 
 	cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf, sizeof(cpumap_buf));
@@ -283,10 +271,11 @@ int tpebs_start(struct evlist *evsel_list)
 		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
 		if (ret)
 			goto out;
-		tpebs_pid = tpebs_cmd->pid;
-		if (pthread_create(&tpebs_reader_thread, NULL, __sample_reader, tpebs_cmd)) {
-			kill(tpebs_cmd->pid, SIGTERM);
-			close(tpebs_cmd->out);
+
+		if (pthread_create(&tpebs_reader_thread, /*attr=*/NULL, __sample_reader,
+				   /*arg=*/NULL)) {
+			kill(tpebs_cmd.pid, SIGTERM);
+			close(tpebs_cmd.out);
 			pr_err("Could not create thread to process sample data.\n");
 			ret = -1;
 			goto out;
@@ -415,18 +404,10 @@ void tpebs_delete(void)
 {
 	struct tpebs_retire_lat *r, *rtmp;
 
-	if (tpebs_pid == -1)
-		return;
-
 	tpebs_stop();
 
 	list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
 		list_del_init(&r->nd);
 		tpebs_retire_lat__delete(r);
 	}
-
-	if (tpebs_cmd) {
-		free(tpebs_cmd);
-		tpebs_cmd = NULL;
-	}
 }
-- 
2.49.0.395.g12beb8f557-goog


