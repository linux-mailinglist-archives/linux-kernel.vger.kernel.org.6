Return-Path: <linux-kernel+bounces-174639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A037C8C1209
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF091B21CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1116F270;
	Thu,  9 May 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NnFiAWv8"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C0383BD
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268772; cv=none; b=nV7LkH5LnVSGCheXQOcHxJocK3gAFqJzRMLy4LBOZ6cxj7gjKciX9kGDTBDGiLGQaNgltwArGswmjqUcCwhtbszSwS61hVWVZhJmBPvrBUmsZg2n6Qg3iYj99Gz0sHBlCf3s/6bAe3Btl+E6pIce/J7Gx2hfkT1Zm/TzKl5D/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268772; c=relaxed/simple;
	bh=o7MEDhlQNTPIH9LLO9fztAGkTXiQChzvwN+jqtL5L9A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BL90Ukp5LiayrcSxWExEjRXXiGuyO98tV9mwO2oo0C6Y2cRErHluCsc4xBW+zuaC0h6/3ETjOyUgOYX/gs6I/QdvWzHohDxlN7dtxk8R6haj4ikZRWvim4n+0Xu+Dau+aaC6SUq5zUHh3rUcdcufo1hiI9Y61KJ8pA+zaxmb4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NnFiAWv8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54be7066bso1545796276.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715268769; x=1715873569; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+/cYEMUxODwz/noTI6gGdDYW4oBmyIjB0W+r47BpRI4=;
        b=NnFiAWv8efV4fDFGVr84MAm5x86ZXekNSlanwIH0oqSqMjoAoSMPMrI9HDt8kZlX+T
         SwcKC/cQ+O2Wmciwtfk8oRryD9tUDmp8ydPEkoQFGndHSArtf7Lh7XxrE7g4pCny/UNJ
         tKP/qto8Wllx7IOvv/X067ZWCU2z+qnuXbucz2iH3Pyo8puO0K25GCVM1S5m0u2MKED4
         3427Mo9x0tgK7h3d3Pt8PmkRNBd9HbF7R1v1b2f9v50Ba66+Kixds73VqYGI6hXPzQp1
         JGcQYYsbgpvLsNhvbNOx+y2Cf2YbJKbfUUQClurkiFWdI8su9J0ty4UWg7+O/Q+CIfux
         238Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715268769; x=1715873569;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/cYEMUxODwz/noTI6gGdDYW4oBmyIjB0W+r47BpRI4=;
        b=lupAyIaLMSwkhLsAyzsyRtToproCPj27t9HVQgzEVwd5zlqksNhuhZjRqXxj30JObF
         P0KPnK6K8j+CcE3Eise4ONiMwqX8Bf2lWNVpQ45Fde4Eg3SkjHkW/6DO/+bLn9aPyGo/
         gTWRTziSL2oGWjFhDlqd0Nrdtfc03b7CoNn5sQUtdwr2xnhXxcuB+tIyo1lGPuHujI+2
         8Be26Sm/031m8XIol4+89nwVA7IaMHM8s6DQsZeX5EQB3boF6YBRhtg3A/pxCV7sr1tI
         5XUo8VkhKF7yhN37D54xwO6BQU2gm+Iltt+XNrsFuOMEFEje333Sc3AgjeqcPYViu8Ga
         Kr/w==
X-Forwarded-Encrypted: i=1; AJvYcCU52jBpzeOMqVW9EqzzVaBVu4N4yT4jfrwYGymuKIsd1Y7VNzF4Cvue+3w/Al2LCyEtNWG53jCJ5p8a/ciMQWr2CiydPn7qGL2/o91m
X-Gm-Message-State: AOJu0YwjMAZt5rE6xWoVabVipc0HJDiivEo9r9g8/5xC9BK4JXncddUj
	MI2BUPxvDbcfGTf9B3d9A2o7QzHJqsdwlXt0jfPXOgWw4SJzntlK8ez+rF/DKdJ3UdV7XkrTEeu
	F63DCBQ==
X-Google-Smtp-Source: AGHT+IH+4WDISdYsAzUTh0Y4jQsf8mQHe9DnkKKFRps/z5pC0eKBNtlRfYGrKq1ROxdjrTq7ef1QXRKWEPRx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3887:270c:55a5:15aa])
 (user=irogers job=sendgmr) by 2002:a05:6902:c05:b0:de5:2325:72ac with SMTP id
 3f1490d57ef6-debb9d0ff72mr1731605276.6.1715268769503; Thu, 09 May 2024
 08:32:49 -0700 (PDT)
Date: Thu,  9 May 2024 08:32:45 -0700
Message-Id: <20240509153245.1990426-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2] perf tracepoint: Don't scan all tracepoints to test if one exists
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In is_valid_tracepoint, rather than scanning
"/sys/kernel/tracing/events/*/*" skipping any path where
"/sys/kernel/tracing/events/*/*/id" doesn't exist, and then testing if
"*:*" matches the tracepoint name, just use the given tracepoint name
replace the ':' with '/' and see if the id file exists. This turns a
nested directory search into a single file available test.

Rather than return 1 for valid and 0 for invalid, return true and
false.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Fix potential uninitialized use on memory allocation failure path.
---
 tools/perf/util/tracepoint.c | 56 ++++++++++++++----------------------
 tools/perf/util/tracepoint.h |  3 +-
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
index 92dd8b455b90..bb06d10fbe37 100644
--- a/tools/perf/util/tracepoint.c
+++ b/tools/perf/util/tracepoint.c
@@ -4,10 +4,12 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/param.h>
 #include <unistd.h>
 
 #include <api/fs/tracing_path.h>
+#include "fncache.h"
 
 int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
 {
@@ -26,39 +28,25 @@ int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
 /*
  * Check whether event is in <debugfs_mount_point>/tracing/events
  */
-int is_valid_tracepoint(const char *event_string)
+bool is_valid_tracepoint(const char *event_string)
 {
-	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_dirent, *evt_dirent;
-	char evt_path[MAXPATHLEN];
-	char *dir_path;
-
-	sys_dir = tracing_events__opendir();
-	if (!sys_dir)
-		return 0;
-
-	for_each_subsystem(sys_dir, sys_dirent) {
-		dir_path = get_events_file(sys_dirent->d_name);
-		if (!dir_path)
-			continue;
-		evt_dir = opendir(dir_path);
-		if (!evt_dir)
-			goto next;
-
-		for_each_event(dir_path, evt_dir, evt_dirent) {
-			snprintf(evt_path, MAXPATHLEN, "%s:%s",
-				 sys_dirent->d_name, evt_dirent->d_name);
-			if (!strcmp(evt_path, event_string)) {
-				closedir(evt_dir);
-				put_events_file(dir_path);
-				closedir(sys_dir);
-				return 1;
-			}
-		}
-		closedir(evt_dir);
-next:
-		put_events_file(dir_path);
-	}
-	closedir(sys_dir);
-	return 0;
+	char *dst, *path = malloc(strlen(event_string) + 4); /* Space for "/id\0". */
+	const char *src;
+	bool have_file = false; /* Conservatively return false if memory allocation failed. */
+
+	if (!path)
+		return false;
+
+	/* Copy event_string replacing the ':' with '/'. */
+	for (src = event_string, dst = path; *src; src++, dst++)
+		*dst = (*src == ':') ? '/' : *src;
+	/* Add "/id\0". */
+	memcpy(dst, "/id", 4);
+
+	dst = get_events_file(path);
+	if (dst)
+		have_file = file_available(dst);
+	free(dst);
+	free(path);
+	return have_file;
 }
diff --git a/tools/perf/util/tracepoint.h b/tools/perf/util/tracepoint.h
index c4a110fe87d7..65ccb01fc312 100644
--- a/tools/perf/util/tracepoint.h
+++ b/tools/perf/util/tracepoint.h
@@ -4,6 +4,7 @@
 
 #include <dirent.h>
 #include <string.h>
+#include <stdbool.h>
 
 int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
 
@@ -20,6 +21,6 @@ int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
 		    (strcmp(sys_dirent->d_name, ".")) &&	\
 		    (strcmp(sys_dirent->d_name, "..")))
 
-int is_valid_tracepoint(const char *event_string);
+bool is_valid_tracepoint(const char *event_string);
 
 #endif /* __PERF_TRACEPOINT_H */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


