Return-Path: <linux-kernel+bounces-174155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D868C0AF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321241C20C61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD71494B9;
	Thu,  9 May 2024 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9lvic1W"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FE1494AD
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232690; cv=none; b=koCfyIYnc6t9Iqs/S1YMGFBzjkAXvbqpqVYoGRGJlqx20UmOGEKqaPsvIMNQrZw4V4OtsXBfhGauK4dZLLTcnmx6Kq9PHc4tx21UwJ12Tb7zVJK53mKI3xaO3lKz5BTjB6mWUw6wWrJV6yqqqsEsIYNDi3rOiWbjn3CfNleQzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232690; c=relaxed/simple;
	bh=pTEExq5eYMtvhoUpicI957vBqyqltPGfA+Tl2tQLAcs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=s6pXTt+/M9yvCT6kl9ELAMgfQge3+UDp6Q9NYmpq6Y9M9qxNmaKkPag7+hy1wU8TO6TXXWtwq9If52qTEhHDFucTClxl159XPRHLCMYjv3Glf/OhdoS0WnmLR7aWwqaCbl70c1NTYMchaB0w6DQepNbMp7Kg/Um3cGhDP1mIfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9lvic1W; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59d580f61so912313276.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715232688; x=1715837488; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s5aJbLYHe6GqC/mebjTDicObCEBB4J8UKwRZUPYrQKM=;
        b=k9lvic1WVExRqjvzs0Q5uAR/g8NeZ3rt681E/9Ofi/6BOSSJmAbT4xZs+A6zy0NkMS
         fK1NsOsx/JWur+39Uwqn4zylRHtdBC1exPcI1nqG6jIvwcwv0oO1SRfdAtjvZxc15hkj
         CV+fA1RrPDFhBp7YBe7vUThILrHbZItiES5RKf2TGGgdv0XlvgomZfmAbgBmxMwIs2nb
         jyErxe33BRLzxrtvfW1RkCA4dp0p94V3j6xR7cRr8cvu5JZvSk56JwAC2s6KySNTOsmg
         2wytWwW2TUz9FJ1els29nL/AExpRk31NlReSkCSO+HtkdCu3bUmGAsaxPWbUEUftVHL4
         U3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232688; x=1715837488;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5aJbLYHe6GqC/mebjTDicObCEBB4J8UKwRZUPYrQKM=;
        b=ZxqEnyZu4DhP9zvJ56C5ka1PP5O7JLnrqOCmONNC7nQWDqGi0Afy0f1gbsUt3ZiC2v
         mysRTgUt18tPLb6JNfcjSov2Hv/Irc3fvE4rNihjqtepqX8wuzjEm+jM0+MXbtUqpBIC
         Awz5EAff131ya1Z/ZjKT1k+5EmHdaRhnpWjuHEoKZAGcDGLs/k56RTVJNX3F8pZ/u3Yo
         3dE5HQJ0fgpvVcFFnqJHTOwd4kxRzu9AX7gkCYVZJrcRKb2WRqJRXMkynnYuAGGX31cH
         2Z3hFUzkz8TfHQhxJPH7qliYLPzk6NcNll+QKAtoGyRUWNlnn93KTk4lfemFB/5yI22E
         O0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXii6n2mhbUcxpLK1Jpp89Uiar4dH+BLkJB/p7jWr6hPSSV+NjuC/Ac9OZ8lOJ1h1ONW5NEn/fHqVkvJthnoGa3YXLmmr0/OqAxs4sh
X-Gm-Message-State: AOJu0YxQYD4xGlpbsrGF7u7GORTLQ6szkETGRqGzOq30rS9bq6g84gSM
	CG/4dGBFvFmXeYzhhhzNljgBEm1mxY6J0I59FroYwGWxvURCKxqsYnwDHzGruELxb7ANVAtUDTw
	1t1Q5QA==
X-Google-Smtp-Source: AGHT+IGMmqrphMvD9VLuxJoc4Pax2f9fdE3/23sT3qktgwrSIK8nZxvg7UwlBEM4ZnP0aJgflzMDAhAM20Fd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3887:270c:55a5:15aa])
 (user=irogers job=sendgmr) by 2002:a05:6902:1025:b0:de5:9e4b:fbb with SMTP id
 3f1490d57ef6-debb9d85224mr1445450276.6.1715232688300; Wed, 08 May 2024
 22:31:28 -0700 (PDT)
Date: Wed,  8 May 2024 22:31:23 -0700
Message-Id: <20240509053123.1918093-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] perf lock: Avoid memory leaks from strdup
From: Ian Rogers <irogers@google.com>
To: zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Leak sanitizer complains about the strdup-ed arguments not being freed
and given cmd_record doesn't modify the given strings, remove the
strdups.

Original discussion in this patch:
https://lore.kernel.org/lkml/20240430184156.1824083-1-irogers@google.com/

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 230461280e45..7007d26fe654 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2275,23 +2275,13 @@ static int __cmd_record(int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = strdup(record_args[i]);
+		rec_argv[i] = record_args[i];
 
 	for (j = 0; j < nr_tracepoints; j++) {
-		const char *ev_name;
-
-		if (has_lock_stat)
-			ev_name = strdup(lock_tracepoints[j].name);
-		else
-			ev_name = strdup(contention_tracepoints[j].name);
-
-		if (!ev_name) {
-			free(rec_argv);
-			return -ENOMEM;
-		}
-
 		rec_argv[i++] = "-e";
-		rec_argv[i++] = ev_name;
+		rec_argv[i++] = has_lock_stat
+			? lock_tracepoints[j].name
+			: contention_tracepoints[j].name;
 	}
 
 	for (j = 0; j < nr_callgraph_args; j++, i++)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


