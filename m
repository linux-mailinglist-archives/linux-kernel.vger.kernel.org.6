Return-Path: <linux-kernel+bounces-392951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79DF9B9A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A687D2820AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023021E282A;
	Fri,  1 Nov 2024 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzQo/aXk"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECD1E8822
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495897; cv=none; b=eAiSoS3IWACGLV8dNM2oaozaUheej5OMwf2cMdUy6bdjAjT8cgNRCaku+kFnij0FVpcLg/oqXVb8Pu7nLTebOpkIWPQ3FYH1oC/zFkpGkmdYh+i/13ZzKg48cgfvLYgGyYzH85X8WYHAaleusDsu5OIAhQ+7VOF71u3ZYMLYeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495897; c=relaxed/simple;
	bh=IjlLFEUYu2zjf+fcVluS0a24eBoaE0MG36505ysGUqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f5yxOLyy4j7vpC9zkQ7KYUcQDZyEiarl33neemydYI7NwhFTW3WN32a3F3eLV+BTDDhqvtQO0JTuT6Mxm5VyYbPlPTS+TR7mjFEZ62+ITVDSQXR23z0ouCfy6eF9TRofzxyEXtK4eJv0Xxh6ojSrq0jJEHxXoTT6BSl0vBDzdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzQo/aXk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20c9fe994daso28345045ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730495895; x=1731100695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZTH0w/ifPPJsyd/kMb3fQD+p1V9r2cvzE6mOf+DuGg=;
        b=EzQo/aXk5XSL/N4LSHagfWH8BVV8c7c8zJPnWKZzn+fowygJQ91gIMoTHxLwnB1xwy
         hUiUtDeoASHrJbyvdz8y3Wx6ITmGDgOyvWU0MINPnN34Ej9VXMdxdM8FIYj3WHQuKSyg
         Cl5m4V1cw63EU9o49m4yJMLGf5OKlbQFPIyH5ZojhQWtwo7NlsciRCX4xbBhEKOe5s8M
         /r3Fmfh8uJVO1d4RFTTwSPrJnqsjDyoP9Jr1ZB9v7AAHgnIU+8HrScjlCGaU5OjWlYKi
         YnlWcvqu3+QnmoMkCrgsDsx92vIPIKN7+EVD0cucVloCKQZQxpoD0hE4S1Xr88s4T0B5
         q3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730495895; x=1731100695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZTH0w/ifPPJsyd/kMb3fQD+p1V9r2cvzE6mOf+DuGg=;
        b=FPyKHs+2VL1ulOL1j2Mr4i4Ok/4b2qvf8i1Wx20VSmz1CCner//3x531Ueh+J4y5HV
         Thz5CQs4LnW37655llcs44K9hbHYAz1kMZQFaZKljaHVsnIw5OwFm5F9TH03BVS5W+rk
         aPIjqAn3RU0DMOH3bcyIh3a1KqFjc3Z+eteffWI6Rrib3VKU6YLEXl5hRAOLNhhbiWxj
         dIPEVondSoL42VtnWpVyIl1gxu5khorNjmBzcg5/dlNhKyxh1kcAJmz+7f7ww9miEMaI
         A51H72aX4pxx1w2HklA5A5p91e5So4XNnux65GXadTgSCNQqPo7qA6iTp4RMRySgvsyR
         CKAA==
X-Gm-Message-State: AOJu0YzCFZ3+gJ1pemt2q06PayS9MqAvIh85+YjOKTL45hjyeebvt1Hq
	bYtF1J89T4JfFp5BBfObWtjqPfUEt39bzli9hTmpT7IX7cQF65UAHFnMiwNNgV2rK/qzPT6secO
	r3sVtMnpE+apDJtpjEYtCsQTQWiDLqdyBV37WlkL6oUIoHhR5p6bBCPmgMHXcdwTkyrS75NZWPG
	miS+tFNwKGxDixxXWvE4OpPlh3eQ7zJ+UQBEaEE1SW
X-Google-Smtp-Source: AGHT+IH8SMMRpwqDbQyjVHL8zK9hCyMKiVkv6uc/MEaeZSiljJNEqIYG7jaEu4cPgFY0YzqebjIY2XPUD1E=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a17:902:f681:b0:20c:6f7e:2cb4 with SMTP id
 d9443c01a7336-210f748d4e6mr1813385ad.1.1730495893790; Fri, 01 Nov 2024
 14:18:13 -0700 (PDT)
Date: Fri,  1 Nov 2024 21:17:57 +0000
In-Reply-To: <20241101211757.824743-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101211757.824743-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101211757.824743-3-ctshao@google.com>
Subject: [PATCH v2 3/3] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It parses fdinfo with PMU type, comparing with the event which failed to
open, and report the processes causing EBUSY error.

```
Testing cycles and intel_pt//
$ ./perf stat -e cycles &
[1] 55569
$ ./perf stat -e intel_pt// &
[2] 55683
$ ./perf stat -e intel_pt//
Error:
The PMU intel_pt counters are busy and in use by another process.
Possible processes:
55683 ./perf stat -e intel_pt//
```
Only perf with intel_pt was reported.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9a5b6a6f8d2e5..dfcb801d8921a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3286,7 +3286,8 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }

-static int dump_perf_event_processes(char *msg, size_t size)
+static int dump_perf_event_processes(const struct perf_event_attr *failed_attr,
+				     char *msg, size_t size)
 {
 	DIR *proc_dir;
 	struct dirent *proc_entry;
@@ -3327,29 +3328,61 @@ static int dump_perf_event_processes(char *msg, size_t size)
 				continue;
 			/* Take care as readlink doesn't null terminate the string. */
 			if (!strncmp(path, "anon_inode:[perf_event]", link_size)) {
-				int cmdline_fd;
-				ssize_t cmdline_size;
-
-				scnprintf(path, sizeof(path), "%s/cmdline", proc_entry->d_name);
-				cmdline_fd = openat(dirfd(proc_dir), path, O_RDONLY);
-				if (cmdline_fd == -1)
-					continue;
-				cmdline_size = read(cmdline_fd, path, sizeof(path) - 1);
-				close(cmdline_fd);
-				if (cmdline_size < 0)
+				int fdinfo_fd;
+				ssize_t fdinfo_size;
+				char *line;
+				u32 perf_event_type = INT_MAX;
+
+				/* Let's check the PMU type reserved by this process */
+				scnprintf(path, sizeof(path), "%s/fdinfo/%s",
+					  proc_entry->d_name, fd_entry->d_name);
+				fdinfo_fd = openat(dirfd(proc_dir), path, O_RDONLY);
+				fdinfo_size = read(fdinfo_fd, path, sizeof(path) - 1);
+				if (fdinfo_size < 0)
 					continue;
-				path[cmdline_size] = '\0';
-				for (ssize_t i = 0; i < cmdline_size; i++) {
-					if (path[i] == '\0')
-						path[i] = ' ';
+				path[fdinfo_size] = '\0';
+
+				line = strtok(path, "\n");
+				while (line != NULL) {
+					if (sscanf(line,
+						   "perf_event-attr.type:\t%u",
+						   &perf_event_type) == 1)
+						break;
+					line = strtok(NULL, "\n");
 				}

-				if (printed == 0)
-					printed += scnprintf(msg, size, "Possible processes:\n");
-
-				printed += scnprintf(msg + printed, size - printed,
-						"%s %s\n", proc_entry->d_name, path);
-				break;
+				/* Report the process which reserves the conflicted PMU. */
+				/* If fdinfo does not contain PMU type, report it too. */
+				if (perf_event_type == failed_attr->type ||
+				    perf_event_type == INT_MAX) {
+					int cmdline_fd;
+					ssize_t cmdline_size;
+
+					scnprintf(path, sizeof(path),
+						  "%s/cmdline",
+						  proc_entry->d_name);
+					cmdline_fd = openat(dirfd(proc_dir), path, O_RDONLY);
+					if (cmdline_fd == -1)
+						continue;
+					cmdline_size = read(cmdline_fd, path, sizeof(path) - 1);
+					close(cmdline_fd);
+					if (cmdline_size < 0)
+						continue;
+					path[cmdline_size] = '\0';
+					for (ssize_t i = 0; i < cmdline_size; i++) {
+						if (path[i] == '\0')
+							path[i] = ' ';
+					}
+
+					if (printed == 0)
+						printed += scnprintf(
+							msg, size,
+							"Possible processes:\n");
+
+					printed += scnprintf(msg + printed, size - printed,
+							"%s %s\n", proc_entry->d_name, path);
+					break;
+				}
 			}
 		}
 		closedir(fd_dir);
@@ -3458,7 +3491,9 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			msg, size,
 			"The PMU %s counters are busy and in use by another process.\n",
 			evsel->pmu ? evsel->pmu->name : "");
-		return printed + dump_perf_event_processes(msg + printed, size - printed);
+		return printed + dump_perf_event_processes(&evsel->core.attr,
+							   msg + printed,
+							   size - printed);
 		break;
 	case EINVAL:
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
--
2.47.0.163.g1226f6d8fa-goog


