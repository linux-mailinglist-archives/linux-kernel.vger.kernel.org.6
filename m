Return-Path: <linux-kernel+bounces-389859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2AD9B722E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038252854D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC4153BE8;
	Thu, 31 Oct 2024 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tl3VYr0V"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513251547E3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339047; cv=none; b=XF8KlVX/UfAR1AwtWpenWv6EH+i98Z8UQx+1FuSFLFq8pHqrUh+Os707HKzbsg03mi1hOrqNaaZNmK7Iz51Lc92VOD9LuIYac8elG8nDoR3ppiqe3lot16kdUpyCscof2UX43F9+Cz1252r9prJ08vNjoWuAXyVF7RJLJX4M8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339047; c=relaxed/simple;
	bh=RYBqniKAr0HDr9QavuDpVba3HWcJbNfezQsIwVzha5U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZVm9mD4Hhf9W7MVKVYUBVKUCX0p1yEsz+vffYnxniIQLfG+hELNXX6eksvJ0sv8zvvNh3r+CHU/KK81/woR5DirqKveF5ZV6BVxy3EAF23i5Dg53gW5fvfV1CCzInSWiZBS8Hy7NFWFeeLLXFRXRLdntYqRPtXNw76Lt+O3/UgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tl3VYr0V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so1017177276.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339044; x=1730943844; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAPItomQeEHLPhkkwn1yLotANahBFAs02uwcMpYu9h4=;
        b=tl3VYr0VG/z41np86ByXhPDaDNrJDPucKRf1t3DWIePa5TRdoidlpmMvanCKZ46Zmu
         Ibd3NK5u24IJ3LyHQU3t2h13DivgdANPjzPwON0i5W+08Vr6zddoV9JmHr8K10FDns5r
         27Z+u0oB4i0RguEjNwlU7pPRZceYcvftfGisVcaJwT1BrUk+sFkOxOJVhnp1NCyXtAam
         EgtS79ctM8kfA4SLIS301zoz7NiYoiCb7JdcMcfXKhpr9PLOFzPQXQ5g9cV2kQ7+0pU0
         lxCjtlPzpxb1oEnOmkzhqO2F5QDLyCGEsddyxZNLw+AbwnBQHfXCCN3pbbgzrQGjXum3
         7VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339044; x=1730943844;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAPItomQeEHLPhkkwn1yLotANahBFAs02uwcMpYu9h4=;
        b=rPFCNzMuVz0EwRrw+GIGdHHyaLq37LRERsGlBzMkaS8TMtqFxtAC4/LTZqFIfhv04r
         5lpJM+5t7kELqbjUVdPxyCgTnEKa+P34PE+guioVGgKgs0VZGWpJMEXJWVN2lk5R7NNd
         d917uDm3SUSY2JoDtYKhJAiWB+wWvFCp6DpQo3cTgerLDdRNs9M0R5VnaTbf2QZKTN36
         HbblXwMpmapE7EOxXo960XAERnH5+dvqWUtCGubIEKp9DhLXKLawvIL/ZnCmMhSoiz9p
         7IH8cr+clPpugVIm3qX2eLNOzgBmKr66w1y3oxMSAfGE5A0On9Xp3crU8GnlISdK6hfG
         b0kA==
X-Forwarded-Encrypted: i=1; AJvYcCXECYhdBKwjSioWzdg1PuIZdCJaCYRKsYxtTgM9ourraYb6+Y3fp//WrMymg8RMvbnlzu3ATmeyupC0SaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpAtOCfYrC1jXSoLdzsI4yfpEkXP0Qzo8zIarEMxcGWMCPljt
	/dTrHs8IqznwpOpCHkxnQds2sqfVxJWSl5Z+xT54R709ooEtaNbosTw5uJ0YQGDRln2kHjizopH
	MbPGP0w==
X-Google-Smtp-Source: AGHT+IEkY0kwA61fgb8QWJVjudJLWMNOihPx9Kn6+kS+DP+smb+Lv/r7Eh0Y0JtgYpuC8tIFBhpKYAanEiLV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a25:308a:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e3087a704f3mr11572276.5.1730339044365; Wed, 30 Oct 2024 18:44:04
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:52 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 21/21] perf python: Correctly throw IndexError
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
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


