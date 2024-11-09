Return-Path: <linux-kernel+bounces-402692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECFF9C2A8E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C28C1F22121
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2381547E2;
	Sat,  9 Nov 2024 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMtbyEBP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92614F9CF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133124; cv=none; b=HIok2Pl3T7BcnUFtvrgpbGEs3eFGGjwjzMDR9ewvQbkzNLuCt+NiL82eI76ICNqySiMQ0SV1vD9Re5gwfjSw5rtePEXg2f4ev4QOmtceNaNxydyXKaX/dYYCNt0cODxXSS0gUmodbNQVIDy6RvTyas328Z/JIUaaq2WzsyEdkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133124; c=relaxed/simple;
	bh=1KD3qfASQAWB+cYLT7zEMIy73hp9Uzy5o9ptaOoxOOI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=l3KXI9YapC4Vm8iGtODaZGg21OJxAtjaOCTZsrDQKUOYOh5wOrpDuMerO8cd6vMvpejFZOd4iz36pSJpVm32RsmXxWKQ1TlfBHe7VSc7X7kQNWwgiDkktM40ZRwtohokGESPgfP9p9sU3zuDYCnSLK8xEA4wC9FqdflZRaei+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMtbyEBP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a238068so52951177b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133122; x=1731737922; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UL0YJWtaGtLk38A4PwPckFN98loHPl8Fal+YozKgQvE=;
        b=FMtbyEBPDyUpQxCE7L7yXC1QwYV0NT/isgd4xMpvsiqe7XXsi7A9ua7kqNxgCMxDs/
         wC4/6OUVNQYij0x9EL+oKU26bFNdci5rqT2hxKUdbBhjlYeKp3G7lZRlVBQuOqAqG4Df
         qD/P2p4zn6aFrhXd3ljS05c4TORUl0ibYeDDZvZWm8RQrX7px1wTzBugyo116S5x26e/
         WmPyeDN3b3PSXoNutfmUFyiF0KtksiF0x7gcEEFtWQNEokgFtRLiCnj16WeCdP7rrUxZ
         xoGxjhxXB4W7IR3tjwwtSLrV6cCa/E6KMekBCCxxml1K1di1kxz7ToS8WawisUkgGD+C
         XxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133122; x=1731737922;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL0YJWtaGtLk38A4PwPckFN98loHPl8Fal+YozKgQvE=;
        b=dJtzUESNTrsVs0k4KUBNoYR/Jgr4eAopbsddBYQGfroOYQzXX5ZGHoB722N0R1kxEW
         uKWcJepvqflrIqot9UQMbedZKXcNFyW+Sjz2qcjbDA7Tktql1245Kmiz4jALLt37xwKN
         KsHV0n8rHSiNbiFa9phnER7oXB3quU0zJKdMoJeePHFEoo4YPQsAtZhXRZ/2GIEbVyLQ
         93qPKDeXiTBxYfoPktAKIIpVrfHCEqjk4ET3iQu+hfwW7VkpEREsofOwqw5V0JPXLyTW
         Ua8HQ7HLL+RHBzUJKzCZ2Y/wmv+uSeV5tBuw8bKFBaU8C9sc3fj3BYaXYPsdGNRf3Abu
         Cs9w==
X-Forwarded-Encrypted: i=1; AJvYcCX7FlZkNwEyrvZ50qW6PsM6Nl04TSphJI+eFPjuU97HehZ2x0QNSL0IGVs1FS0ivEVE1kxKRuN8I7jHgFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPlPm7oLXeb6zmEVRsrJF15i1CIOywzNMtfXFdNnSeBV4Rmjo
	OgWpmOIvdlru/IWLrfoTZIGhszRWa/If1f+XFSuH7d3IleZkbUx6ZmYOZh7hLl4G7Yz0br0wJcP
	TgvfKrA==
X-Google-Smtp-Source: AGHT+IFV5YgKbuTWNs3EdWbrO21Ryr+az9efGuM2U4bETysi56ys4TKKig1sDrsdjWBgktyLOxZNXpz9xixH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a05:690c:6d13:b0:6e3:cb96:f577 with SMTP
 id 00721157ae682-6eaddfe2f28mr665497b3.8.1731133122256; Fri, 08 Nov 2024
 22:18:42 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:56 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 09/22] perf script: Move script_spec code to trace-event-scripting.c
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The script_spec code is referenced in util/trace-event-scripting but
the list was in builtin-script, accessed via a function that required
a stub function in python.c. Move all the logic to
trace-event-scripting, with lookup and foreach functions exposed for
builtin-script's benefit.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c             | 67 +---------------------
 tools/perf/util/python.c                |  5 --
 tools/perf/util/trace-event-scripting.c | 75 +++++++++++++++++++++++++
 tools/perf/util/trace-event.h           |  3 +-
 4 files changed, 80 insertions(+), 70 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 62e851fdf5ca..11c0ee8c1afc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2956,79 +2956,18 @@ static int __cmd_script(struct perf_script *script)
 	return ret;
 }
 
-struct script_spec {
-	struct list_head	node;
-	struct scripting_ops	*ops;
-	char			spec[];
-};
-
-static LIST_HEAD(script_specs);
-
-static struct script_spec *script_spec__new(const char *spec,
-					    struct scripting_ops *ops)
+static int list_available_languages_cb(struct scripting_ops *ops, const char *spec)
 {
-	struct script_spec *s = malloc(sizeof(*s) + strlen(spec) + 1);
-
-	if (s != NULL) {
-		strcpy(s->spec, spec);
-		s->ops = ops;
-	}
-
-	return s;
-}
-
-static void script_spec__add(struct script_spec *s)
-{
-	list_add_tail(&s->node, &script_specs);
-}
-
-static struct script_spec *script_spec__find(const char *spec)
-{
-	struct script_spec *s;
-
-	list_for_each_entry(s, &script_specs, node)
-		if (strcasecmp(s->spec, spec) == 0)
-			return s;
-	return NULL;
-}
-
-int script_spec_register(const char *spec, struct scripting_ops *ops)
-{
-	struct script_spec *s;
-
-	s = script_spec__find(spec);
-	if (s)
-		return -1;
-
-	s = script_spec__new(spec, ops);
-	if (!s)
-		return -1;
-	else
-		script_spec__add(s);
-
+	fprintf(stderr, "  %-42s [%s]\n", spec, ops->name);
 	return 0;
 }
 
-static struct scripting_ops *script_spec__lookup(const char *spec)
-{
-	struct script_spec *s = script_spec__find(spec);
-	if (!s)
-		return NULL;
-
-	return s->ops;
-}
-
 static void list_available_languages(void)
 {
-	struct script_spec *s;
-
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Scripting language extensions (used in "
 		"perf script -s [spec:]script.[spec]):\n\n");
-
-	list_for_each_entry(s, &script_specs, node)
-		fprintf(stderr, "  %-42s [%s]\n", s->spec, s->ops->name);
-
+	script_spec__for_each(&list_available_languages_cb);
 	fprintf(stderr, "\n");
 }
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0fa8e27769be..3d938fe2de6a 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1305,11 +1305,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-int script_spec_register(const char *spec __maybe_unused, struct scripting_ops *ops __maybe_unused)
-{
-	return -1;
-}
-
 arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
 {
 	return NULL;
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 8abb7a7b6888..ad62d8e5a368 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -24,6 +24,81 @@ unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
 struct scripting_context *scripting_context;
 
+struct script_spec {
+	struct list_head	node;
+	struct scripting_ops	*ops;
+	char			spec[];
+};
+
+static LIST_HEAD(script_specs);
+
+static struct script_spec *script_spec__new(const char *spec,
+					    struct scripting_ops *ops)
+{
+	struct script_spec *s = malloc(sizeof(*s) + strlen(spec) + 1);
+
+	if (s != NULL) {
+		strcpy(s->spec, spec);
+		s->ops = ops;
+	}
+
+	return s;
+}
+
+static void script_spec__add(struct script_spec *s)
+{
+	list_add_tail(&s->node, &script_specs);
+}
+
+static struct script_spec *script_spec__find(const char *spec)
+{
+	struct script_spec *s;
+
+	list_for_each_entry(s, &script_specs, node)
+		if (strcasecmp(s->spec, spec) == 0)
+			return s;
+	return NULL;
+}
+
+static int script_spec_register(const char *spec, struct scripting_ops *ops)
+{
+	struct script_spec *s;
+
+	s = script_spec__find(spec);
+	if (s)
+		return -1;
+
+	s = script_spec__new(spec, ops);
+	if (!s)
+		return -1;
+
+	script_spec__add(s);
+	return 0;
+}
+
+struct scripting_ops *script_spec__lookup(const char *spec)
+{
+	struct script_spec *s = script_spec__find(spec);
+
+	if (!s)
+		return NULL;
+
+	return s->ops;
+}
+
+int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec))
+{
+	struct script_spec *s;
+	int ret = 0;
+
+	list_for_each_entry(s, &script_specs, node) {
+		ret = cb(s->ops, s->spec);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 void scripting_context__update(struct scripting_context *c,
 			       union perf_event *event,
 			       struct perf_sample *sample,
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 0e5133f1b910..0520dd269374 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -113,7 +113,8 @@ struct scripting_ops {
 
 extern unsigned int scripting_max_stack;
 
-int script_spec_register(const char *spec, struct scripting_ops *ops);
+struct scripting_ops *script_spec__lookup(const char *spec);
+int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 		       struct machine *machine);
-- 
2.47.0.277.g8800431eea-goog


