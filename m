Return-Path: <linux-kernel+bounces-434412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612D9E666F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259F828240A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5FA1D90BD;
	Fri,  6 Dec 2024 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqV5UwmR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA51D63D7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460052; cv=none; b=ceehHBQdi27JnfunF8a3cBptBiL1esWYogNsUPEv016NF5NPfzZY+EvllNgb0Y++5mHte+ATGFflQu1e83dYKziGh+aiqzNM2Ywqe4oPKkA7tCmmZ0zhBHadbg3XE1KqblQyJzB2IFC3fIYR+neriXStz9WLAnxLz40cP1TQR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460052; c=relaxed/simple;
	bh=tL5UcvcaUuHSFNHf+2eJphHFXMLILMHZEi5NFaOiUOk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WdIWjqn2TdyS2rN/IXnrW00cQq2FyPtiBVIjRbyhJ6kZWWC6ucYx2ymV0QWCcWGj418Uq+CWoNiwWMHlA6hL0c3k0EeXYBU+GhYW8pMjbSHzeBNWQzUqodedx0VRtnP9eG8s1nioNkiPZguh/yJswrwp6ekYj7wYj8XO/Rlc3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqV5UwmR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef6e33c182so16792937b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460050; x=1734064850; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxKOwJDxb0nbB94Cpeqs1MqiCtTfBA0AAYbHAMWSNGo=;
        b=RqV5UwmRQyRrrvxjZCab6+A9fzd/cWzjS65qnhe24N7iR3AZDihfOcdA+gv/IuI0Ju
         OaLErCYYVdVDVoCPoEfcWWQnb0LtGpz6bj/Jt3DDlB+lEWyNsum3vqrDlOle1faZtJPm
         O2DTd3+5dlxBKa4ucZzZ8YLFp+Cq9sEMjkImkqefcD9fssOBAAWKoIS++NVvpfHCKrhY
         TZ0f8wDvJHtZKGHU7J9uQigWNX8ArxJLUva2daHQV+TCsdp2WbEPQcycafMIux+lhGx+
         pBku6+m0PjECwDz18qpSYHIVfYuOpZYqsu4ZF4WhZdPTZrbv/KUu913D4oyiox3Ooucl
         /R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460050; x=1734064850;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxKOwJDxb0nbB94Cpeqs1MqiCtTfBA0AAYbHAMWSNGo=;
        b=Vp9/pvlRJt60fwJopfovgu5+2jIBvfgy5ku2uTOrgGjgZLZ0klfF5Tw5pgmH7UpQbj
         XdlgUuNmUMa6Gt/FQRhSSJRXqKyoSGSFcw9K1Z9cu2DeJENNcbaI6Vl5bomyp6P2ktzr
         T51UuuYCL0MVOOrXplKGZ7mJpxA0TTsjTUafCDKV/pHE5ysrS+/Oix+2cUaPn978+iOd
         NIMKF0SV8zhPBc5bDKoHNnYFzfW1/KDkh2KicBA0ALr2BbDQ4xgzlrKkHvyMy/7oUPBc
         ZxzfEMtDYrQlrBCcYn1iaJD+H3QGj5x5usMEpuEIbzD7tEUUnRhDbXBiSW1gkIJKMgBX
         ym2A==
X-Forwarded-Encrypted: i=1; AJvYcCXKgbel1Dw0w+sK74HzZTTnaDkh7c0/MtpqlExZA5zGIOIdcLT0Xf8TvKbFkUFbr8nj9/s/IS0ZVJeqUDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8IrSMUSMhVNucxYdKsMEruTpe1kgy1t8PZSCMX/50KGO5oxM
	Jz3cEDamp/veWPNdY5AXpg335bi+Arpv6PmqYjorIXqX7KqE+SRhPJ13bD8Bw8W4CqoacgKYm33
	rjexqNg==
X-Google-Smtp-Source: AGHT+IEITj0IZXGOHRW2OjbGAsUtPzL7lWINzqsu/4f+Dqz6jJr8cNOz1t9vJB6+EjMUbfKp4lW+UCKDWNZf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a05:690c:4782:b0:6ef:5e7a:aa72 with SMTP
 id 00721157ae682-6efe3cb751bmr8277b3.8.1733460049675; Thu, 05 Dec 2024
 20:40:49 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:32 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 5/8] perf pmu: Remove use of perf_cpu_map__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove use of a FILE and switch to reading a string that is then
passed to perf_cpu_map__new. Being able to remove perf_cpu_map__read
avoids duplicated parsing logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 08a9d0bd9301..891c905d08a1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 #include <dirent.h>
 #include <api/fs/fs.h>
+#include <api/io.h>
 #include <locale.h>
 #include <fnmatch.h>
 #include <math.h>
@@ -748,26 +749,35 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias, int err_loc, struct lis
  * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
  * may have a "cpus" file.
  */
-static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name, bool is_core)
+static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *pmu_name, bool is_core)
 {
-	struct perf_cpu_map *cpus;
 	const char *templates[] = {
 		"cpumask",
 		"cpus",
 		NULL
 	};
 	const char **template;
-	char pmu_name[PATH_MAX];
-	struct perf_pmu pmu = {.name = pmu_name};
-	FILE *file;
 
-	strlcpy(pmu_name, name, sizeof(pmu_name));
 	for (template = templates; *template; template++) {
-		file = perf_pmu__open_file_at(&pmu, dirfd, *template);
-		if (!file)
+		struct io io;
+		char buf[128];
+		char *cpumask = NULL;
+		size_t cpumask_len;
+		ssize_t ret;
+		struct perf_cpu_map *cpus;
+
+		io.fd = perf_pmu__pathname_fd(dirfd, pmu_name, *template, O_RDONLY);
+		if (io.fd < 0)
 			continue;
-		cpus = perf_cpu_map__read(file);
-		fclose(file);
+
+		io__init(&io, io.fd, buf, sizeof(buf));
+		ret = io__getline(&io, &cpumask, &cpumask_len);
+		close(io.fd);
+		if (ret < 0)
+			continue;
+
+		cpus = perf_cpu_map__new(cpumask);
+		free(cpumask);
 		if (cpus)
 			return cpus;
 	}
-- 
2.47.0.338.g60cca15819-goog


