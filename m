Return-Path: <linux-kernel+bounces-340845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76D987872
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4366B29B22
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3156118452C;
	Thu, 26 Sep 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+SQBwt0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E387181310
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372190; cv=none; b=IndtdCWg6DM3G5fzZVRHxbP/bU+dHzNKxSeOHqyohG0oJxGB6xVDfbgzfLMmMdRJb5EwV+kr/R4AllNjX+B0bfaOuVbSiPhdinQsm+oSfHzUOjdqMhUYeeMX6J2TbsiAMVWpqxoR/yM1tux8HS+jHl7jXbQTdWG1QqdZVJYF6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372190; c=relaxed/simple;
	bh=qbqs/VtYLAHCycbx4vi5LsbINYh1rKMwgZIZNf+A82Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mr4SKww19DgyhCWNpQ4e7Q3UIGSkwNb9t7BSxuD9gN4GBflIbqVpX8PH/27Oluw7no8zulORIj2ZYa3bPJ3xjqoOesU/GHD03523XcGmlNd8fw4i4m2BhUSJfh4DGnuNGjPAQQDjPyt6pUuBpaVeLEaj5hbaxCc03uodnCOFHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+SQBwt0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2261adfdeso12979267b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372188; x=1727976988; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3phwsESgNJAD/gtYgEfjCS2iNNfK4v5IWyCQ1BF22U=;
        b=n+SQBwt0zg2e2EJmWyRJNGTac6GP3aJQPMK+djbEKTsNEl32w8PUjttE6XB03MB52Z
         v857Q7sWQZwXMkTFLA7fixRIPnBXrCy8Fh8d8uz0pJyUSRnnTsDzlGyBFlft7ZvNK5iz
         dVxsEU9O7XAeeNSHluDGtmqz/OVEmwrMWtGssprqGlxk64CYRE6utTL9EbjvaRUe8v5t
         rwnvBwOnEP4rVmMw+pzs/eDrQ5hQUoyY/w48LVXPawn4mkGLWkHHzY3PkRg/EipGlZvK
         bndllz9DHbeOLm2L6GrxaiACAwn8adqzn85qAw8semMEW4XqusSVxVGylVU3Kqz147I3
         9p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372188; x=1727976988;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3phwsESgNJAD/gtYgEfjCS2iNNfK4v5IWyCQ1BF22U=;
        b=s+CxqE/80o/8Fbgnq6yi2tF2K9keyyTsgOMBpC1krJdfZSE/yfY/dy3w8/f0IB3hRV
         WDxHw8XcKVxHxX2jOJCPQOyr1jPj2DEtLYCCpZLa4VncpP9o5jvE1rCk1gVXODcS/4Tp
         DllFsnhEdn9nWGf36lYTDTDmrN7wwn5lrPiv9VLd30iVh25q373X1nZ+C+JuRhsiYw+i
         gUGrl4C/2TfQa3AlDqNuKW0r66+BR2YdzUISiXKucSLrGk+uOraXLhz6h4QzpWSJBQOa
         gpC4B+EUo/j9dDvMV+xy/ZiQSfhFyc32qMNAvGM8viAFAIhYCyfcwWCXRFxGxcwxyF+I
         Jh1g==
X-Forwarded-Encrypted: i=1; AJvYcCUg88GNZ1cFg+1Lak02V9/Ve73Vg+3qQah6fez8QIIeIRdVV9MGVitnhDl6DSVu1dpQ+vi5TbsmlwLA8ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJRAtoCeuXpQPsEcrnKF/7Fsge3OOWHj9W6tTUMKw7fWP26vO
	bE9QuFiNbNikHgdTc0sWvq02yttYroPA7YreU/hHnXqC/xbEm97Ng7wxp6EWs9RHZIl9JnCTyDx
	suW5CWQ==
X-Google-Smtp-Source: AGHT+IENGkB1Fu9MiFrm2Rau858bJwo6nKsMX5S+m/q2KN3wYJTLbrV0xtxHf15FckIrJ4ISm7FtJs3Q+xml
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:504:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e2604c8fd7emr141276.11.1727372188130; Thu, 26 Sep 2024 10:36:28
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:51 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 8d2cecb87e88..7b4239e8b08b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -473,7 +473,7 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.46.1.824.gd892dcdcdd-goog


