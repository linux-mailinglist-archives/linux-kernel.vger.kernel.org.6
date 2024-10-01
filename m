Return-Path: <linux-kernel+bounces-345247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB298B397
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206DC281252
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453111BCA04;
	Tue,  1 Oct 2024 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juoDUpam"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6E71BC9ED
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760224; cv=none; b=gFgLqSWwSTMREW4y5jGp4189laZ9O8Z1AgLM+DUzZBi5jHq52Zt/kpowf74bJ2jBeUXUC7cpKLcS3p2jWbZPgQEFO9nJCjM8Ckzzi5R6dGMpe1o/KYMBCaxWgjAUUT4zSPCBJu+2vQ2wf+NI168DxI7q/xv2ZK8HcgNTPmK7XcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760224; c=relaxed/simple;
	bh=HlaJPf1DpkhIcVfUnD58FBwEx20zYRsFkrETe/cFLkU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uePK62omdFfQKf+k3up/KoZnn3uQpxpn3HhVq89akNOyELasIWtb4sdSv5+bt67mEQlKmua3oqo9LNclhzqmmOzJQ5Z35uoNpr8Xm8AmCS0UA2gSG+LNOoHDebR328Kz1o+q4b2N8IuxL7SS2YBB98ploYaNNOooAtfCwEAWW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=juoDUpam; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2364f45a4so55041587b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760222; x=1728365022; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSpyv/AFjmfCtapMZ23chCRHMXjbu/7COuZjKrd4Qfk=;
        b=juoDUpamF7UF6rFT9yyark8XE+ageMESuAvoescAbFB2MNgcBEPj0ZBf4MZsbLgxaj
         IHR/IHrmCtYsAhT1xtzVZv9I+T4nitjiLsaOeBZPXc87vdNL8nv4aLppobokcqGCIANI
         c1nNnIOKZb+jiUwOxVOarYsBWp7yNpCW4og864bwsd4QzOrMlqspMe9x8+JuC8QV7oXp
         35naNd0a47FgkZNq15jxTjr+3uEPeVAujIIvPw+zcfz9lLP9R6JQaJcbW2f1NoJVXHN4
         bq5je00m5VZ2pmGiSBjxFsCLbBUngGIPlifZX1UMSS/Uyb6x8dKQzK8THhAIV/jrzSqM
         lyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760222; x=1728365022;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSpyv/AFjmfCtapMZ23chCRHMXjbu/7COuZjKrd4Qfk=;
        b=QI5QxNo3uSQARp4T6x/PVWgLvBP+KtVo7+VLyrxgmB3ocXZrJtEcJT1tY6LyAVLN7a
         0pXXS0gZcThYw24Ekph/ZVEyVhaE95/PSaVwk/fBU3WtbUbLLnnVMAVArX1Ytz5Eac4m
         sLSQtvlh6V4SQGIyVxEsJbAwbZ+CeFcOY8KY8UX8uy0ozRFtkYZl12iANRDxgO9/MMMj
         wB6am+MikNIAb43lpVAx99eRMpwDWYV45BJ+nlnEh2KSOpMrjWstYDr9KJdQ8tHYRVdd
         r8e2nxvX4ySXju+GfwkV8GVU5RbHaF0PMzh9aOrIDa79s0fF6rjf/Qa2ZnfUt4No8uW8
         LQOA==
X-Forwarded-Encrypted: i=1; AJvYcCWagS1kNC4pweRcQRiXFbuEWwzbFN8eIZbvMCfqgIAslJQMWWOQa2mOtZq8f87xzS2qOrEcOSegqKbWlRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSmimmr/5Mf5wk9sz0fw9PfPUTQp90CXz2iENaXv6KPBjNZLy
	OQIySyqYNwYVuRQvDYz5ggKxxGdTQUKKpQvBhIW7Bq1vNQXx7fYywvf1CRZ5PuQmWo+7+AAGL7R
	xPpJWQw==
X-Google-Smtp-Source: AGHT+IHVW0m7mS9IM+OEPcKA7PRFyrcmcKWvkbN5Gk4Zr0KfEbqS7bbdaJzOmzXtgquqf7+Qzi0FPyxKe+AE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a05:690c:3005:b0:6e2:120b:be57 with SMTP
 id 00721157ae682-6e247604e65mr2217147b3.5.1727760222250; Mon, 30 Sep 2024
 22:23:42 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:27 -0700
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
Message-Id: <20241001052327.7052-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001052327.7052-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 4/4] perf test: Skip not fail syscall tp fields test when
 insufficient permissions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up return value to be TEST_* rather than unspecific integer. Add
test case skip reason. Skip test if EACCES comes back from
evsel__newtp.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/openat-syscall-tp-fields.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 888df8eca981..3943da441979 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -40,7 +40,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	int flags = O_RDONLY | O_DIRECTORY;
 	struct evlist *evlist = evlist__new();
 	struct evsel *evsel;
-	int err = -1, i, nr_events = 0, nr_polls = 0;
+	int ret = TEST_FAIL, err, i, nr_events = 0, nr_polls = 0;
 	char sbuf[STRERR_BUFSIZE];
 
 	if (evlist == NULL) {
@@ -51,6 +51,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	evsel = evsel__newtp("syscalls", "sys_enter_openat");
 	if (IS_ERR(evsel)) {
 		pr_debug("%s: evsel__newtp\n", __func__);
+		ret = PTR_ERR(evsel) == -EACCES ? TEST_SKIP : TEST_FAIL;
 		goto out_delete_evlist;
 	}
 
@@ -138,11 +139,21 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 		}
 	}
 out_ok:
-	err = 0;
+	ret = TEST_OK;
 out_delete_evlist:
 	evlist__delete(evlist);
 out:
-	return err;
+	return ret;
 }
 
-DEFINE_SUITE("syscalls:sys_enter_openat event fields", syscall_openat_tp_fields);
+static struct test_case tests__syscall_openat_tp_fields[] = {
+	TEST_CASE_REASON("syscalls:sys_enter_openat event fields",
+			 syscall_openat_tp_fields,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__syscall_openat_tp_fields = {
+	.desc = "syscalls:sys_enter_openat event fields",
+	.test_cases = tests__syscall_openat_tp_fields,
+};
-- 
2.46.1.824.gd892dcdcdd-goog


