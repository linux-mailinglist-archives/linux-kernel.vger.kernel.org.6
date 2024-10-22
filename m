Return-Path: <linux-kernel+bounces-376726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5309AB529
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E336B23E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97D1C9EBA;
	Tue, 22 Oct 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkATsuC4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1761C9DEB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618289; cv=none; b=J5KaKTtR6fYIdEIb/lWE7243lgslnlwK6gZh4najleWkmHGEpXePUHZpoBe1MV85Z2oGG3cWiPF4mGRnDvI6nRyt+Pq4g5Rl0rHMyn6Wf7Rj/DR+a6arZSyvySCnsAkneC8SpuWkre1zCJuXhlRpm7K9KDdZciD5/j6WmM4hEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618289; c=relaxed/simple;
	bh=uf+pqZIq59zWUrhBXlbY8/wph3KVNlWL4TVWGoXzUW4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=knS6i3MS9/dxbPGUaowPguGQWnl2yWRVTdAFXUHIqLWkgstUzjRMEz4ZUB/5PrbvAYFI+KXfM06uKSG1ih8g5jilhjlbbfw1OH14qZBtaaspHkexZvXV2vsxuMMZggubFQpfxaSwYPnQ1I28EOhu+rfFZV8yzz8DfbI2b1VYkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkATsuC4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7e0093018so15528987b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618287; x=1730223087; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RCKTfa55Bgazupu7nQwlQJBbYx0nTCBpL94lBi/7F4=;
        b=wkATsuC4dwNJxwGu0MHucKw42b6iqQ+QYNdG0nVfmsI2ZowDc9+1JK2MhqHQtBH+NP
         9+p+gPl03ngmSjW0b9rJXgFk67JGUcWkDvJBNWidYtORk1i1vybqDXaK6JysctB3p6f3
         7QhIPrbPvB/56OCkiTnig+t6BUD4HWsjphmnnTN/NJ0H+T9qE82h3QyIEjB8u4wDRvXv
         TmQQzzLY1LoimL7k62XqxZdvVuYe1DJdcQnUWug3TnoxaZBbgRHfY5Ao2eh66lQJA7C8
         b6hmgTVTezXrRsPkaTjMMlOKuHgCtF8d2II8PcVUjaeD3Bqfa+RmFImFK/uhx+r6fYiu
         ZW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618287; x=1730223087;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RCKTfa55Bgazupu7nQwlQJBbYx0nTCBpL94lBi/7F4=;
        b=IZRFJKPvniafW2agCirsJPb1FBqFdHai/Um+kjAFprAsjprQIISnmzcICDVvfL3evA
         b/Dw6M0ZTotN0R+gu7kWEr3WSMC2AYY1+2jgpfhn/DcZ1Guxhh8kzYXbB7HAueol/zZu
         9WBQH0opam41xKPP8o256bmDSkszaH0Nh7Jq10T+GavTjK/x9dlVi/RZjBx2uN/ZIwhl
         PBUGJozMIujGXyvY6yAY0GCugeij+QeGdnlJxAC2dy7GiE5/8gTnQGc2f7H5ZErZJnDF
         muB1VYmfMaVQ2fKYdvxbNOPIlROO/KyYR9PjVDI5rIlf/ZL6tkT0vK8llrqSx7NtNt8k
         zwng==
X-Forwarded-Encrypted: i=1; AJvYcCVM8XuwtwjhEIOJTVu+hSNoa1sD6LVSjIWJUCWMK2lUFxv9dmdO2I5obKzrgU89oxB0yXiBjMHKdgstVD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUK6O/bGFv0qO0uNPLwvhi81uXQhAOYC70ZtAwKa9vYJtnLS5
	X58xthZXzKthKBhTZkupFvlJxPlIKwso1Yw3O2UBp+Ept5A0f44y5EHHlpCJbOb/BE9o6yA2EFu
	6rRAkRw==
X-Google-Smtp-Source: AGHT+IELK1cabkM9jyDLWipM07rBPcwjibrm8lK+0QxhvWjalP/V3OW1tr82/CblTbowpRmugUTYhUZLFi7Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:d350:0:b0:e28:fc1b:66bb with SMTP id
 3f1490d57ef6-e2bb158a800mr8674276.6.1729618286412; Tue, 22 Oct 2024 10:31:26
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:14 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 16/16] perf python: Add parse_events function
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

Add basic parse_events function that takes a string and returns an
evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6e2ff0076daa..ec37f887db43 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1201,6 +1201,30 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 #endif // HAVE_LIBTRACEEVENT
 }
 
+static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
+{
+	const char *input;
+	struct pyrf_evlist *pevlist;
+	struct parse_events_error err;
+
+	if (!PyArg_ParseTuple(args, "s", &input))
+		return NULL;
+
+	pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
+	if (!pevlist)
+		return NULL;
+
+	parse_events_error__init(&err);
+	memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
+	evlist__init(&pevlist->evlist, NULL, NULL);
+	if (parse_events(&pevlist->evlist, input, &err)) {
+		parse_events_error__print(&err, input);
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	return (PyObject *)pevlist;
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1208,6 +1232,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("Get tracepoint config.")
 	},
+	{
+		.ml_name  = "parse_events",
+		.ml_meth  = (PyCFunction) pyrf__parse_events,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.47.0.163.g1226f6d8fa-goog


