Return-Path: <linux-kernel+bounces-290565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659429555D1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0451F22E74
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915AE1442F2;
	Sat, 17 Aug 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLhnyFIu"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFA1422D2
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877110; cv=none; b=C0ssAjug6KjFjTloQiCnlvHaOHdpqcKh2fernckaQYtBisZKNDVMm9Q7nk0/kgvCQYfE+Ehwnu7nH+iVMSttPlBe5E2Of+NsZKNEkM5KAxoFepij8cMSkk7yijjXprjJ0I4jEuUij+h8H+sisNi8X1wNnX0ThMt6y16iDxLQSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877110; c=relaxed/simple;
	bh=0zxhIml3fB+ZAPhpBZe1OmJSjv1p7ZchaNoCdcZ96uU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IARQ70LTJiP/WxGAU6AxuXvHzaVNXH7B76EzJU+s7IIkQIOEqNBsiYStAslfrdjrRRZGen/hpNeQT5BYhLpfuZFTA/P0haaj5vY+aTWMaJyNJKlNIsuokiQLzcGV3vrQ998ol4Q1XqFpbEfKWTr3taZ9EIqoVROvxjMCPL3lCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLhnyFIu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e13cfd506b8so958071276.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723877108; x=1724481908; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGFdZ9DcdfWihKggJ77z6/NZRnt1NtgUjW3p1fvjlS8=;
        b=oLhnyFIur6uQ3j3wUWN89/hoy/IIY7d0aD7vjR1w7eYt0tHYTm7m6vQsXMogsOggar
         mvzU9lceDI2/5fheBTNdsLITOdz4R2+T3Bh/YCFda6gtmKFDMtcvrcn2NJ7wLWZiZXJx
         GQVOyUtpKQByj5T4J+hzYDCDSV3HWpEK85/Gg1fe+Wjl8W8zWxfFJX8xp/VAAMTdi3i2
         9b0gl4S8OweVyV/ngECfOz23FQFaxss7HHvD11CGA8DaVvuCBEUVA1UO8sGAaoF5hjGB
         4tTzt2scWpsruE0yUJy5PSP4Ipspik5T532h5djI6ZLJhrMDBr4phxHxZ5PbwXo73XMl
         1etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723877108; x=1724481908;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGFdZ9DcdfWihKggJ77z6/NZRnt1NtgUjW3p1fvjlS8=;
        b=T6GQWeJQeE8PFMhDjZ1xOcWFwvd2DjM+ruTOcH5Oah51Z5QOPhYjJgca7i2xwo/qqm
         Hr8xU2SotTDrf3p5bE5QW96AgMxFop9tAFaeUswouc15ToR9u+VHExwoCUSa1fuX//cR
         m6DgskyjduDd5xW1O+46FP3+IhyJsnUrAKQBeYQV3EhdpaCIslMTIsP84XtLQQtV8tP1
         KWfiQBGKdH1ZFmNoVQnpzPYfYjIfxbLjigBAm68WylutPRT9/ZN39I+o2JH66mGcMrO+
         8bfYkKPzFpaVBdjpVJwX74xtVqh2Z1GIJdq+0mZIZOiQGZw4jCzK3aa1VICJoXp/SuOB
         rmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzU1UtOxMv/eCelFr3iHJnWo0s20EKUhJFdx8Way6ud9UDPJL0OTWg+cmJcPW24oSOjegH5lRPRFbugUrQs8Wg3RRaUAeHqkMwDqao
X-Gm-Message-State: AOJu0YzTpYZszj138c9B0a2OqxGznf/petfLyo7HMaU3d4P1oH++yinQ
	hcViRyC5fQUz2Z18HeXZiWzwL/am9Qq6w44r5JdBO7zeAbkPpp7LyZfBhMrPo17oDo+FTBEPgJR
	nZLC8EA==
X-Google-Smtp-Source: AGHT+IG4wRBLH0MwXQQb6vBslDjy0fDjEZYGtNBW1YLAD/9o/ZBpj4yYUkV3n9X4DRweyz5BIO2a6MW5rzni
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:78c9:5e58:734f:c59f])
 (user=irogers job=sendgmr) by 2002:a25:8741:0:b0:e11:69f2:e39 with SMTP id
 3f1490d57ef6-e1180f6c6e6mr271670276.9.1723877108430; Fri, 16 Aug 2024
 23:45:08 -0700 (PDT)
Date: Fri, 16 Aug 2024 23:44:32 -0700
In-Reply-To: <20240817064442.2152089-1-irogers@google.com>
Message-Id: <20240817064442.2152089-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Subject: [PATCH v1 03/13] perf jit: Constify filename argument
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make it clearer the argument is just being used as a string.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jit.h     | 3 ++-
 tools/perf/util/jitdump.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/jit.h b/tools/perf/util/jit.h
index fb810e1b2de7..f4037203e9ec 100644
--- a/tools/perf/util/jit.h
+++ b/tools/perf/util/jit.h
@@ -5,7 +5,8 @@
 #include <data.h>
 
 int jit_process(struct perf_session *session, struct perf_data *output,
-		struct machine *machine, char *filename, pid_t pid, pid_t tid, u64 *nbytes);
+		struct machine *machine, const char *filename,
+		pid_t pid, pid_t tid, u64 *nbytes);
 
 int jit_inject_record(const char *filename);
 
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 5ce13653512b..346513e5e9b7 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -710,7 +710,7 @@ jit_process_dump(struct jit_buf_desc *jd)
 }
 
 static int
-jit_inject(struct jit_buf_desc *jd, char *path)
+jit_inject(struct jit_buf_desc *jd, const char *path)
 {
 	int ret;
 
@@ -737,7 +737,7 @@ jit_inject(struct jit_buf_desc *jd, char *path)
  * as captured in the RECORD_MMAP record
  */
 static int
-jit_detect(char *mmap_name, pid_t pid, struct nsinfo *nsi)
+jit_detect(const char *mmap_name, pid_t pid, struct nsinfo *nsi)
  {
 	char *p;
 	char *end = NULL;
@@ -821,7 +821,7 @@ int
 jit_process(struct perf_session *session,
 	    struct perf_data *output,
 	    struct machine *machine,
-	    char *filename,
+	    const char *filename,
 	    pid_t pid,
 	    pid_t tid,
 	    u64 *nbytes)
-- 
2.46.0.184.g6999bdac58-goog


