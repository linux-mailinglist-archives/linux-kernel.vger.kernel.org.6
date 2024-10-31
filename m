Return-Path: <linux-kernel+bounces-391400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2C9B862B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DD31F222B5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2171E284F;
	Thu, 31 Oct 2024 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSQQ8lIu"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0719F430
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414402; cv=none; b=AGPQ/sDK+zUQpmGwzxH3ZXnAFguWbHDMQCDK9hGG2H95lHNOEeLy79smzk6FVBnOn34tj/eehZY9M0DJvSRGNORmUv0vHl7iN6gOzt4MV3pSY0ub+tZnCQ1bIwkh5QElGVnoEPSNDrCtG/aNHQG0IURVTEXVgn5ZtJ5flKt7csI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414402; c=relaxed/simple;
	bh=GUzGbrHWB5mVpuujsPRSEUbl4D4r8eQq3oJIcZ5G0OY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mtXENFnFo21ZlkUNPz/03N8NePE9qczeeUSMD3B59yRbB/PRCvmJhNKNLOmCLXGtBFqJX7xHZnZW9BZeux3vYkpTrNC8PuofuCQN4TrWlNbRYDZwZXUdOLY4b7nLMClxxMDeFRJKNZ42yel1I9+LzyLDjwS6O2ggIcZneLYqqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSQQ8lIu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20e67b82aa3so13528415ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414396; x=1731019196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmHPXqbr+V94Cj75rx8E20Ytlg71UGBeuyaaieI1cEM=;
        b=bSQQ8lIu1NMuF99VxzcZV2aQMr2Z2yfU8s+RT/4tyZJInGNx63GynLDg1DcROtHOZj
         Da+YrYOHyoXm/P0p6LLtpHVOw6xAZL4Jnfn5dJ14/rgAxsCFv7LHQGO+PRcWD8nVdksl
         6460JUgzT4odWNabux80l2JKHsa22NLdGlw2P39RodsjrP6t9wZgNmlA8KR0CPGngmY2
         5ipJu5eeASLVudu7ARm2/XV+D3bIErRQUWNvqcJlYh37X+Onl+N21ufQszcZneE07aMT
         wz/IiVhHYnOCfoPv+bfUCdXFOi8Ff+kzeFmXGLxiqC3zroVh1oq7WOAnoeCKAZfg0qUZ
         k4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414396; x=1731019196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmHPXqbr+V94Cj75rx8E20Ytlg71UGBeuyaaieI1cEM=;
        b=Gwb4LOCLtD0DJLUFHTDRtW4MlhN6OoeBR0C1mNCvfSqOwmINWeeQtes9lA2ex3m9vr
         8qNowv81lOqQc3dq6onUDq7IxDeLwnvtmQiy0Lg72LpipGMAQ/gcSR12+/NMz8WprBDT
         Z/GQxL3PGvtOI55CzF9Ru6xBpSpL1lcsRL5N7ob2hXfaUyRO2v/+oE0ESc3L/JMG8WY2
         M2xB2tn6AsBkgcFt4k1+x+PT4xHmJgIb5vNvCkFZXfBKAaFoeEhlLVStBvdNEauD2MNi
         zYeqpBpbryxJ3GW6R+70GIVB+RyZ8EXUB2zSTZOboSfOXCd7XFJmpY8OHxnCKk5a1r6l
         1Ygw==
X-Gm-Message-State: AOJu0YxV4F9EDhfsfLpN2uXRpXdq9ypaBObmMKAqj494aqErItp9j3UE
	nnnLbkQF5U72EC8ENHRJT2ag5Y53fa0W8Z4nQ6IuidwU9f5XOzJFfR3T0FUWwFKBkDvq/wN/YaM
	KRt2bbQnGuIDw2Is5vtMl0shvvZPzBSQkiY06226senFi9uGig4lgDtDDWuhw/qxLFGWLTFxGi7
	VSbgePsAsjmFE4UpfYh5KxLcnDtKCH1rPedeRJak/K
X-Google-Smtp-Source: AGHT+IHcwCE9yLFtMhUPOaOa7htLJB9lwLWpIrFC+ZH3Cz7gR1rZQXoHcrxLR5iE/JVP7KGgtKOn1yVdytQ=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:ce7])
 (user=ctshao job=sendgmr) by 2002:a17:902:fa07:b0:20c:8dff:b4f9 with SMTP id
 d9443c01a7336-210f74d6e36mr398135ad.4.1730414395507; Thu, 31 Oct 2024
 15:39:55 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:39:45 +0000
In-Reply-To: <20241031223948.4179222-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031223948.4179222-3-ctshao@google.com>
Subject: [PATCH 3/3] perf evsel: Find process with busy PMUs for EBUSY
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
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
index 9a5b6a6f8d2e5..d2f7c19e023ec 100644
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
+				u32 perf_event_type = PERF_TYPE_MAX;
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
+				    perf_event_type == PERF_TYPE_MAX) {
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


