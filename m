Return-Path: <linux-kernel+bounces-309744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A0966FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331541C213DB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ECB16DEB4;
	Sat, 31 Aug 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTYqouWs"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BEF178398
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087879; cv=none; b=ahBFw/XpxzzQDGVmpML7ykbgiwy2ZyrR/Afc2Hb9xRcPC4N0zwYoYZOeUfa+pJQayl6uNLABwXyt6lNorOyjQw32Cu+Z9l9tmHd0SEPbamtLX66I3RykHSHtEePHqFSvBgaGDR5otIMMv0tvqbjeWPF7Fj3ENQjeOdr1sW7SFfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087879; c=relaxed/simple;
	bh=neE8KUj5swSBbTAvkEmb7HlGQpVC/JyPFNunQxVwu/U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DK2u6Mw7mjkOlucFn5zC7z3oGL0NlpFb22GA+TUauLrI16SW9DwDLg/gVPoHR5c6S4HFRC8bbnmCnwnwB+gp5QH3c8QQhJAT6qtIDYRGPdf0Z+zQtXUUfe+B+cITrxvff3UewXlTTojyc5QMjRCvUBPfOH+zCpUxIkkPgo5LWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTYqouWs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a6d328eacso3653589276.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087877; x=1725692677; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMHouUPm/pUbpqXHpAwu3f/Ggg/o8qY6+an2XmPnD00=;
        b=bTYqouWsvhPu/wRbjJDDrLM9vx9g9U/ljPv/SCltgoZKaAKi9laHtmCY+8CDdKyD4q
         XHWJirKM6rruYrjRN21+5Hspl5xvaj3LBov1vfCJf56i5mXwFtqS+7occ5upO0oS23N8
         mvz3bQ8eORRS44ip3EGyxG6JCTYBMshOkeYeiVLPEIcdOy6xAGDI0K7hTFCQVeBEuNcG
         i6OEMlglaoj3p1jmRuPGkA4bwYnHmICnib5Qit2pr4VkY9onSo0EIxDwzFa0F48cyTKc
         kKFN6MGYqVpDChUF2O1i0P1dN27rTISoK8kNH2JMXXh6w+zHA91chg2V0Sdjp/t0KwhY
         Efhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087877; x=1725692677;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMHouUPm/pUbpqXHpAwu3f/Ggg/o8qY6+an2XmPnD00=;
        b=rKsD8daAFZJ7hQoXSZ1nXXpM+iMK9rbC7QHuXBER5lVFlQYHlYcLPVf2tR6n4kjrO2
         galbXN5hsvxAonoeTJ0wwHiIbQfFcaeY/ytSxoSeDBcQYWq5x0DrJQls8+CjeEsIdcT+
         euuAhxmvyGcfdEZA82EYXVaaU/DTC8C+GvcoEQdM4XNQE4OGkcVf5Ktia0TtryEIjU1R
         KURcOF9CCJK9Wt8RjTKWaaHrIGD8CpWUewjz+C0HAzdrQkjvvDqDdCr4dUU/6VBdZC7d
         848SpwW5lTYyxuXMwybSldrN/lF+Dh+K9yEoInFCySNVnwVvaFOmBA44kHd5gyz+mRHl
         BZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCW+8Gljxlj8GjlfYsdg5KmDFif003lMqbgu012+WwVRK8kLxNMSaA/xXWyHs8GZe2Q81r5h87bwjZvbsXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkz9OSseWHqBs/xeCwxfvsei1HsfaqvWcutdkKo2HSiVzW/zZY
	7n7+ZGrWhAh/7RkZmJ0NmZSvc2MkBqCW27MosLFdVfj6g6pDaUvfswxSDojbr6DJfzurCRZAQCI
	zRR961w==
X-Google-Smtp-Source: AGHT+IEQRxwFyMDSw6Mj2d4DGqVL/glGW1ecwaCsu3ve2y6MdyDP3o6KRg8tCHoQeSLhIeD+/Ar8hkGrgI+x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a5b:1:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e1a7a176b02mr7463276.8.1725087877533; Sat, 31 Aug 2024 00:04:37
 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:14 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 5/6] perf parse-events: Vary default_breakpoint_len on i386
 and arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On arm64 the breakpoint length should be 4-bytes but 8-bytes is
tolerated as perf passes that as sizeof(long). Just pass the correct
value.

On i386 the sizeof(long) check in the kernel needs to match the
kernel's long size. Check using an environment (uname checks) whether
4 or 8 bytes needs to be passed. Cache the value in a static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index dfb951bb184b..c7fe8b4167d7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -8,6 +8,7 @@
 #include <sys/ioctl.h>
 #include <sys/param.h>
 #include "term.h"
+#include "env.h"
 #include "evlist.h"
 #include "evsel.h"
 #include <subcmd/parse-options.h>
@@ -672,7 +673,22 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 
 int default_breakpoint_len(void)
 {
+#if defined(__i386__)
+	static int len;
+
+	if (len == 0) {
+		struct perf_env env = {};
+
+		perf_env__init(&env);
+		len = perf_env__kernel_is_64_bit(&env) ? sizeof(u64) : sizeof(long);
+		perf_env__exit(&env);
+	}
+	return len;
+#elif defined(__aarch64__)
+	return 4;
+#else
 	return sizeof(long);
+#endif
 }
 
 static int
-- 
2.46.0.469.g59c65b2a67-goog


