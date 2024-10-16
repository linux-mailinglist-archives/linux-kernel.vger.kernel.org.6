Return-Path: <linux-kernel+bounces-368606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 454EA9A122F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A788DB21249
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6EE1925B0;
	Wed, 16 Oct 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFojFKTT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7D2141A1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105216; cv=none; b=sl3vM3BGZPdmRNmZan3gvbP6lLPiBU4X7SFZlt6DGQ67Wz8OhssvTZBHAofmfWoiy/EJRlmaKAf3RPim/lqHGP034GkDqF5GsgllF7KBMzLiEBX8Vd4QTM0OC4axYwvudFZ4lxWHgxOoWdUMyYhKaLZAngHtY9oGzX84XM6cXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105216; c=relaxed/simple;
	bh=YiUPcFzffWyNLYA+8FWdtxkS29XrLMr0gAQw3As/6sc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YEylGs8qHVXavvpLo8f/j4a1OkcuVn5pAXGS5MgkvQwXuYL8W1Xoxm1ScKgjV+apuK0fctch7rlyg+OQcB13d1ZJ6YB8929VY342uJvnNSdkE3AOGHLADP8kpY7VOKcPdKile1EqUqU+ktW7mFhZrY81VdVd9jpzENwiAJYri+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFojFKTT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35d1d8c82so4037267b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729105212; x=1729710012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h4jjSM+ORlT3LjodZYnx5ObwICh1BMY0UwPD2hawNIk=;
        b=pFojFKTTXijq4Cv1novJi9+ajpcR+H8Q1syFh7BcYKD0kpBGcASVYetmSTgWUZwJgl
         oifsmX/18lQEwRiZkamqbAjCdQrHGDZMHHN3dKzkilXYvtomn+myL1hQm+E6HFstaBLh
         YEnEWMub59SSFuQifds/hmgHEW73aIvmHouUq4aMWBdmjtYDjem7WQ06qQwwkBjAv3Y4
         3z/+QGMqbFf+z3xQeFWHGd93pqHSqr2XzZBpZszuHD4pGo+AJ4CRVe7rnI565qWMFtpw
         Db2EgAfOcMMQOBcasNZuT7BRxC/fTFa34WcwiG7UVZeBPG45R8DNhbF7bzTyT9etd2tT
         LpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105212; x=1729710012;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4jjSM+ORlT3LjodZYnx5ObwICh1BMY0UwPD2hawNIk=;
        b=YQ/M4pCSBaJlktUtS966ftisl9t1c1fP3N/1WFWKYewykraCo9reTK87rohcK/MQcx
         v8AMaU6Z0FH6egImPdwgoqW739GOvLL65CK+JYufaCCBlJptJVvI4wtdkoMQV5BnDFqb
         QbjpqCcpPHgOZ91MTZnx20MOWNtJisALBdAjlVl3HsDtaOBlcaDxd6+c0WBoXw8N8Ci7
         aB38OzSqQaairB+TZ//sDiGB+ijwWzOGE1ron+H6sjaIkB1QajpPLWlFNk+kmr7XGG/j
         pVpSiGBxmB+GDKMfFw5DY3AcYmzKjd4OL9quRxQ1Cl62ncsiCrFz9b5Q995pwzmj8Awa
         /2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUBtLmOE9msRKEUfFYJ8JAFLBspaSb7kMt8Na51utRTqMsRozL7FYrHhHx0mcyCslQidl9g0ILKCY/GLhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6toD849cIFNB0TnhT3TsS1V2m6pFTS4E7kugN8BqA7aJiHVo
	nsbwI6ApIozLBQn/SZPXbL+roE9fOa27Kh0OUnBfn3ZVWtJc2sd/RnNFb0ld9Sc8f/LQTx4TA0m
	CFHWQFw==
X-Google-Smtp-Source: AGHT+IEOPZW7aXJcAd9af4VdSY0ecDTuw98miWo2+E7cKeDPdGZBkIG1FmVZ2rfbL34eNz+ajcIcTDq5okT5
X-Received: from bjg.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:415])
 (user=bgeffon job=sendgmr) by 2002:a05:690c:2b08:b0:6d5:df94:b7ec with SMTP
 id 00721157ae682-6e3d3f787ddmr550497b3.1.1729105212629; Wed, 16 Oct 2024
 12:00:12 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:00:09 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241016190009.866615-1-bgeffon@google.com>
Subject: [PATCH] perf tools: sched-pipe bench: add (-n) nonblocking benchmark
From: Brian Geffon <bgeffon@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

The -n mode will benchmark pipes in a non-blocking mode using
epoll_wait.

This specific mode was added to demonstrate the broken sync nature
of epoll: https://lore.kernel.org/lkml/20240426-zupfen-jahrzehnt-5be786bcdf04@brauner

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 tools/perf/bench/sched-pipe.c | 43 +++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 3af6d3c55aba..e2562677df96 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -23,6 +23,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <assert.h>
+#include <sys/epoll.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <sys/syscall.h>
@@ -34,6 +35,8 @@ struct thread_data {
 	int			nr;
 	int			pipe_read;
 	int			pipe_write;
+	struct epoll_event      epoll_ev;
+	int			epoll_fd;
 	bool			cgroup_failed;
 	pthread_t		pthread;
 };
@@ -44,6 +47,7 @@ static	int			loops = LOOPS_DEFAULT;
 /* Use processes by default: */
 static bool			threaded;
 
+static bool			nonblocking;
 static char			*cgrp_names[2];
 static struct cgroup		*cgrps[2];
 
@@ -81,6 +85,7 @@ static int parse_two_cgroups(const struct option *opt __maybe_unused,
 }
 
 static const struct option options[] = {
+	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
 	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
 	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
 	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
@@ -165,11 +170,25 @@ static void exit_cgroup(int nr)
 	free(cgrp_names[nr]);
 }
 
+static inline int read_pipe(struct thread_data *td)
+{
+	int ret, m;
+retry:
+	if (nonblocking) {
+		ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
+		if (ret < 0)
+			return ret;
+	}
+	ret = read(td->pipe_read, &m, sizeof(int));
+	if (nonblocking && ret < 0 && errno == EWOULDBLOCK)
+		goto retry;
+	return ret;
+}
+
 static void *worker_thread(void *__tdata)
 {
 	struct thread_data *td = __tdata;
-	int m = 0, i;
-	int ret;
+	int i, ret, m = 0;
 
 	ret = enter_cgroup(td->nr);
 	if (ret < 0) {
@@ -177,16 +196,23 @@ static void *worker_thread(void *__tdata)
 		return NULL;
 	}
 
+	if (nonblocking) {
+		td->epoll_ev.events = EPOLLIN;
+		td->epoll_fd = epoll_create(1);
+		BUG_ON(td->epoll_fd < 0);
+		BUG_ON(epoll_ctl(td->epoll_fd, EPOLL_CTL_ADD, td->pipe_read, &td->epoll_ev) < 0);
+	}
+
 	for (i = 0; i < loops; i++) {
 		if (!td->nr) {
-			ret = read(td->pipe_read, &m, sizeof(int));
+			ret = read_pipe(td);
 			BUG_ON(ret != sizeof(int));
 			ret = write(td->pipe_write, &m, sizeof(int));
 			BUG_ON(ret != sizeof(int));
 		} else {
 			ret = write(td->pipe_write, &m, sizeof(int));
 			BUG_ON(ret != sizeof(int));
-			ret = read(td->pipe_read, &m, sizeof(int));
+			ret = read_pipe(td);
 			BUG_ON(ret != sizeof(int));
 		}
 	}
@@ -209,13 +235,16 @@ int bench_sched_pipe(int argc, const char **argv)
 	 * discarding returned value of read(), write()
 	 * causes error in building environment for perf
 	 */
-	int __maybe_unused ret, wait_stat;
+	int __maybe_unused ret, wait_stat, flags = 0;
 	pid_t pid, retpid __maybe_unused;
 
 	argc = parse_options(argc, argv, options, bench_sched_pipe_usage, 0);
 
-	BUG_ON(pipe(pipe_1));
-	BUG_ON(pipe(pipe_2));
+	if (nonblocking)
+		flags |= O_NONBLOCK;
+
+	BUG_ON(pipe2(pipe_1, flags));
+	BUG_ON(pipe2(pipe_2, flags));
 
 	gettimeofday(&start, NULL);
 
-- 
2.47.0.rc1.288.g06298d1525-goog


