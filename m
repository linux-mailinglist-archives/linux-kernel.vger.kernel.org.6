Return-Path: <linux-kernel+bounces-387789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BBE9B5604
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432F31F216E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138F20FAB3;
	Tue, 29 Oct 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMdwHvK4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D920FA9B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241924; cv=none; b=EoTbUGHYRrx13hw6gRpx/NyAnXy+/gbpR7h/menGb6VWxqUrbOjTcdIsjCu2WFB3HyPxvsYF+JKxZJ9SwqnR/Jnd7dbOMI5JXt/w+MTEpTrk0zHifUI6s6EQEKGB988/ZbS6MXqqCH2pJWYOsiASWiSbUM93wWw7jHk/cF0G+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241924; c=relaxed/simple;
	bh=RYBqniKAr0HDr9QavuDpVba3HWcJbNfezQsIwVzha5U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=p4GUxezGGWxT6VGMp5J8DAY+5rDJSkLBgUjMppU1dUg+wZlz77/0ctsBjyiSGILcWSFxb00iDSx42UuNlAw/xm29ReSuFsQZuOkOe9/H9C+P7ADpse63BPNdKAmYHaxWflkwUQ8W+WKCeoT294wxwKsC2rMakP1HRg0QGqLIj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMdwHvK4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290947f6f8so10658572276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241921; x=1730846721; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAPItomQeEHLPhkkwn1yLotANahBFAs02uwcMpYu9h4=;
        b=YMdwHvK4cu7zDl4efOaJaGJLGxdCtsvRB4kNMFppq9wv7PsSam6clvJtLwaeOHZZjB
         xnhjRUtWBseUotqpxRpP8oh8uYUETfWKKOA2w92Potm+JEAIn3HISz6ObitxePinJHeF
         YXUsB3clNhfyu1gjCy5ChyH/D3wa+PlMzIBxl7ueCOAqz8fSlPie3F9ootTEDAWquhDb
         GaxcA58mZ3evYhw7aC6oMDOBFSTY0nS1qXc1lkv//JMNhI9j1p7X+JSIHIVzVFgjA7eA
         11Z+b7Y9726vNBMJ5s6gZwakWNOHAoRVEuIUkaGpmomkve1+jargZl4SwAFPXCDgYWqA
         8djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241921; x=1730846721;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAPItomQeEHLPhkkwn1yLotANahBFAs02uwcMpYu9h4=;
        b=RQXWg7LZsBXTYeMVtEa3VxptvVxCkTgcZDXmxz8Fsika0MCyqDBtkNWyLUeJRt7b4W
         UVFU21K1Jr5hPJsIQm68TlnV9jbg5/GVGN35TXIRLjyo8+QJYBxuZAWhVPM7b3KcQXo2
         qfreAPjcp5OfX5/eynsDk6HuJwF4XMV+bIlcq8zqtha+kHL6FCLNRYFo1NWNuib02wLF
         AzhNL2gd9e/w+W++QNMKR2lgl/rP0+h4H+argsIKG9BCpzRnExnHmiVEcW3QdWxzEE9C
         BMkWnMnB8WMt0kWJMDGMFTUZnOy+SaUUTO2ZJ3L6TJcc4Tc0ZpNhPCK0i4vQ2ZqvGXIg
         R2NA==
X-Forwarded-Encrypted: i=1; AJvYcCV/rOYm+Kr9kf64LjCNtRB+fAkj7uFzqlnwcTwjddf/uQ3ggWg/kYDcKOPutK3Q4kR1rhKbWBPdOj8epxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkY+tdvdoNI0RQ1v/Tim+6sIuJ6s/1SkD9kLxfs8eGnqdQdih
	1fp9Nl2xmQBz/0Z/MJxXbL06DldBXWCy4fmnxpugl4jzcMmf9PMd+lknf1etkWhjtyw2q15DHBz
	BjSeIQg==
X-Google-Smtp-Source: AGHT+IHjq9xY7rwYPlkiyef9KSLjkmkqOtnvQiFEzFzKfn6tQMOtFng+3YAEfFlHM7RYYXpf4xW/4PrJmeHq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:6902:3297:b0:e2e:2e79:207c with SMTP
 id 3f1490d57ef6-e3087728d56mr12242276.0.1730241921523; Tue, 29 Oct 2024
 15:45:21 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:31 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 19/19] perf python: Correctly throw IndexError
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Correctly throw IndexError for out-of-bound accesses to evlist:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0, '/tmp/perf/python')
>>> import perf
>>> x=perf.parse_events('cycles')
>>> print(x)
evlist([cycles])
>>> x[2]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: Index out of range
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0d71ec673aa3..25114dcadd21 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1071,8 +1071,10 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	struct pyrf_evlist *pevlist = (void *)obj;
 	struct evsel *pos;
 
-	if (i >= pevlist->evlist.core.nr_entries)
+	if (i >= pevlist->evlist.core.nr_entries) {
+		PyErr_SetString(PyExc_IndexError, "Index out of range");
 		return NULL;
+	}
 
 	evlist__for_each_entry(&pevlist->evlist, pos) {
 		if (i-- == 0)
-- 
2.47.0.163.g1226f6d8fa-goog


