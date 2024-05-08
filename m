Return-Path: <linux-kernel+bounces-172669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9DD8BF515
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665C7284FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B33225D9;
	Wed,  8 May 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3XEOkwvE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07651AAA5
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140402; cv=none; b=DyB9RGCCyCAK8rfP3a8tPpFNmIcJZ+NL58jmN3hjuuYzj/txggiC9utTrxF3Eqk4YeFCVxyOcrAMRsYIMngmGHdT4ICCCjOGewV7ZFyU04T2kJOhWG7hmZLDo4XZPTzmLNs2dwVzV6qy0RrJFqd+k5m4Ki3Vd2iUp4cB8uoUDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140402; c=relaxed/simple;
	bh=PkE9IXfyXZEZClS9BF4vcd5Nh75l4NFqr0xzo5i+yl8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fNi7I/Hs6KnnS107QHeNUO5JniEQsDrb5mErC23N5QCgkruenePlQKhcANRpl6ExRh0lNlq3Twt19pFqx9BknAdVgrX3MN7tuTZnC6FEGXI9cGBAC8dq8LyhFQrlNI+uXrQx78RTRiMhZWWKI18y3cWreFcY2m0s1I2hB9YC7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3XEOkwvE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be25000a4so79091187b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 20:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715140400; x=1715745200; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9iBFcMYRLjKmNtSCKVfZQuec+4vBM7qEYaLGnQMh1Q=;
        b=3XEOkwvEZuu8BWnxgUf9tbmWEEV7zqlQkXMWj0609iuJc22PdaMlbNUjOEoOalQJik
         LCZ7vvbIDAi+CxoN9dm3pEYj486FGS8u7kfUxVDnjceuLnD0bF20rlI6IrGS0VjNfGSZ
         Wnm7u5hz5oUbG2Bl0PLM4XG5O9LJtt+2aXsFVsKk2zpCBhVuu+pmToCrL4brUEVhJwzG
         Sbti/bIy4wnoY3B54A20hsJkmVGF/51GKkKwsHMA6c/7c/DMIrmWU7cqioldqMDET1CL
         Xxk6z0fe1mncODy1IcPOS0p+i+Pue5HP4TnCczVQM26cFeUG0lCZm/2Z/2DkQgFilvEh
         XHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140400; x=1715745200;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9iBFcMYRLjKmNtSCKVfZQuec+4vBM7qEYaLGnQMh1Q=;
        b=TWn1gifimmPwnRUEzO+jcIWwlu/dBkwqzCxmeMSB25MFiTnGqdBmzmWLT/jlo13eUo
         gY3GGaFtmsQWyMiz0dUyX0ffRHicSKmuVJ6EPDVprJUElSK1wCG+JgjP6bWfVWG5REpS
         ZHPeaFlMoFsR8/RknUiqEK1I0awOWjZBtZi5xMPTVp+1xRwtaHPykGNXKKzlMkXmCy+t
         cbwaMxSqB/9ms6sW2Ip/mkYrjbe0RHKvgROsNbV5egahETRM00rjYL89kYsVl6oQ300Q
         5Ui0Lbmji0yx1ZV23QJoCkXgxgwPMdN2WZHaoOIdF1+vIzlhUCB/ZyOt/WK1mHfe4gGC
         AIjg==
X-Forwarded-Encrypted: i=1; AJvYcCWTLDBWQKCC3Cp3YAHZkECQlwkPfSbm26lTaeLa43OCzzQokFuiHFyqIfqenazW+/5re2BoQLjsvrOelg8rEkvGGpiI+NtW5qM8uFfE
X-Gm-Message-State: AOJu0YyUi3r/P0nkhvYghvwghzOGLjOBTJKXozHEfdSAcIqYkRvpDDHw
	Rbj2iPtAETVASq6OPXp+0VgCu+YgMX1j4onLcvtkoYU1jO9i5MBxTy2Q/yCqzBzKgFI+v7lwkz/
	HM2+97A==
X-Google-Smtp-Source: AGHT+IEbnEA/r7BoFjsBedSpafR2wTGgrqS1AfAn8vl+1v8boeuvJ0jCqkgJ+FlT5VbqFtGmUa+pyGS+jfPj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:56f9:40dc:113f:ba3])
 (user=irogers job=sendgmr) by 2002:a81:4807:0:b0:61b:e1f6:2098 with SMTP id
 00721157ae682-62085a6966emr4506397b3.3.1715140399912; Tue, 07 May 2024
 20:53:19 -0700 (PDT)
Date: Tue,  7 May 2024 20:53:01 -0700
In-Reply-To: <20240508035301.1554434-1-irogers@google.com>
Message-Id: <20240508035301.1554434-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 4/4] perf thread: Fixes to thread__new
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Freeing the thread on failure won't work with reference count
checking, use thread__delete. Don't allocate the comm_str, use a stack
allocation instead.

Fixes: f6005cafebab ("perf thread: Add reference count checking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0a473112f881..87c59aa9fe38 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -39,12 +39,13 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 
 struct thread *thread__new(pid_t pid, pid_t tid)
 {
-	char *comm_str;
-	struct comm *comm;
 	RC_STRUCT(thread) *_thread = zalloc(sizeof(*_thread));
 	struct thread *thread;
 
 	if (ADD_RC_CHK(thread, _thread) != NULL) {
+		struct comm *comm;
+		char comm_str[32];
+
 		thread__set_pid(thread, pid);
 		thread__set_tid(thread, tid);
 		thread__set_ppid(thread, -1);
@@ -56,13 +57,8 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		init_rwsem(thread__namespaces_lock(thread));
 		init_rwsem(thread__comm_lock(thread));
 
-		comm_str = malloc(32);
-		if (!comm_str)
-			goto err_thread;
-
-		snprintf(comm_str, 32, ":%d", tid);
+		snprintf(comm_str, sizeof(comm_str), ":%d", tid);
 		comm = comm__new(comm_str, 0, false);
-		free(comm_str);
 		if (!comm)
 			goto err_thread;
 
@@ -76,7 +72,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 	return thread;
 
 err_thread:
-	free(thread);
+	thread__delete(thread);
 	return NULL;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


