Return-Path: <linux-kernel+bounces-440811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28D9EC498
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D04D1684C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570B41AAE33;
	Wed, 11 Dec 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwtGqHqQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4B5661
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897318; cv=none; b=pSXWZHa6cXSs+ItBJau4Mtz1nvjbKHiPkEVoFIcgvL5SoJwEbuc95FHhDO3uZUrd9iDIX3J/hWXznFBWU9Hym3jQ2CHXbBxrXtCdePsDumpmrmxpPMGbFSaRWrCSbXDRy0e9fPO4inZUv3/33dsAITN7cZKECl6Gvo0rAdu5lQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897318; c=relaxed/simple;
	bh=SR7tUhFz20rFGvCtXyCBGl6PkDO5QGcxCL2Tb+J1ZXU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=KDw88bce1LGI9mENP3+EP6w54hQsxe7R7ETMs8X00TZff/IUeRFP/VnEaZmkAm+P8ZmFzV55GFsgpF5rnRNVnB6sv5I+qMPL/t4THboPlP49KI2uwbuY1+wo6q574KUAXxh0pk/qb4WX4+nisHVLj9AYNeQbIjAWTtYWGCqq/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwtGqHqQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef7c67eeb8so65009137b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733897316; x=1734502116; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sVIJ7sBKo29N5wK7CyxC4hRD95JOXO3JOEqr1gB0IYk=;
        b=LwtGqHqQ4PFB/tjAwmcGnoUUNqOem4O5dYuWIlXj6lVDmBLi0rE2rJ1znBAgzRTbil
         jUyE36V+MO1tU1dh6Dh6OqvrqUknQzvirGP+NgeaTJ94zueANaH9WF6GKdanu9eOi8VF
         Fu1az8mwniWhoqHt2srrYXHEQBgvNr5SmRBux05wgLIieSInN3isf1/pMQ5ml/kBMhKq
         VFcYa6DjaPiqcM93VQ9ZQ980H56GxCQ/exAkUNC0018SbeA7FZiCPIAdmk5IZ5kR81MB
         WKDmLW7pN/tBPJR8dnDLxF9VhiFnClJZnolMNGCrdQq0iokvWeCjFMw2Cp898EKe18WG
         kN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733897316; x=1734502116;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVIJ7sBKo29N5wK7CyxC4hRD95JOXO3JOEqr1gB0IYk=;
        b=ee/TOxqxCWnIdgiAc8kPJ8GqK4XSsozc3ZNU8EiQQ3UyjQ00wO9avGYWTq0d9AYXdF
         lJ4LQCtplsHrkhtBOLA3CzHC7BG78sQxZfa7G6WKWLipBeLVsrGch+9J4JIrzj8NdmCe
         qfffebuVpxJDp2B+6Ur82w0VjaFVf/r7t960QkMmV5j9bEaDNjSbW+R9zmn5c8SRgO33
         kQmF8gksqKAI1Xyui7Ho0veKjUSgX6WLn2ogMw7ycFRGxWz4x07m+UHEWKf/1PysCQLM
         aJ7wc+fNCO691mQ7w6zHn8Emr8/hvSj07A2dD4Fns+T/756nuptC9ob3b6ktu8mFYigA
         j0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1HbYitBYm/z2FoDdQaUgmI4wHZtwZ0iVZOLMpi3sXakOVdMQw8rrVwGvUi/oodATeGQMrJ404wYsDPeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInaFRrWZFdfAj7YVgeqVHvRxVZTlnAV2Sa3hQZVAkdBr5WLkg
	Lx2E4FapGvJhVEzX8/1jJgJMQqgTWRp4mJcKhk3Linlp7dG9PHyxNkoGbXJC/BwZAgXjWGpuwpN
	tl0vN0w==
X-Google-Smtp-Source: AGHT+IEW56OWfH6NsKL9sVm6xNi8SxTWO/fPoh2yVzTYOxbd6gTdRTysJ/4fgv1WowUp1ZgbH6LcrPg6/iB3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:bbed:4ddc:59bf:36b8])
 (user=irogers job=sendgmr) by 2002:a05:690c:4589:b0:6ea:decd:84e with SMTP id
 00721157ae682-6f14804410cmr10597b3.5.1733897316361; Tue, 10 Dec 2024 22:08:36
 -0800 (PST)
Date: Tue, 10 Dec 2024 22:08:31 -0800
Message-Id: <20241211060831.806539-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1] perf inject: Fix use without initialization of local variables
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Local variables were missing initialization and command line
processing didn't provide default values.

Fixes: 64eed019f3fc ("perf inject: Lazy build-id mmap2 event insertion")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d6989195a061..11e49cafa3af 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2367,10 +2367,10 @@ int cmd_inject(int argc, const char **argv)
 	};
 	int ret;
 	const char *known_build_ids = NULL;
-	bool build_ids;
-	bool build_id_all;
-	bool mmap2_build_ids;
-	bool mmap2_build_id_all;
+	bool build_ids = false;
+	bool build_id_all = false;
+	bool mmap2_build_ids = false;
+	bool mmap2_build_id_all = false;
 
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &build_ids,
-- 
2.47.1.613.gc27f4b7a9f-goog


