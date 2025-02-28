Return-Path: <linux-kernel+bounces-539562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB0A4A5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0D877A5968
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B753C1E0DC3;
	Fri, 28 Feb 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vjc+zr1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60571E0B96
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781452; cv=none; b=ZwOZAGSe/t0s5sQ8oUP0ldjmFfOP4tKI7wMPcXdXV4s+L83r44Pc4G6lYBAy5Bx21i5xIm0ArHZbyMFQtEkDIfo0XSS8N3ZyPW4M5gRNERly73nJ4wZ81tiysrt9A0wsQkItSYWu2pAVXY1Q3tJW2c8iJSx0aVHdbFo4p63A/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781452; c=relaxed/simple;
	bh=SMz5hMAzgWKP7lTvIai1pMYw2CR0WUilsImxdukqyKc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Xpfypbum4JfiGZB/FbwgK1nxgv7j2NSXxr44N//kOvMkP4Y83VeNnikUgsxD4Xqdzttr1H9HgEiGIe7b1Fb+DmL3R2TQMX4VgUO4BREIVByuXUGGvqW8RYC1UjzMn3HDJFeCj/vQ+8t2dnBDiYQr8G+jyCWIVDUBY/jeZ+O57lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vjc+zr1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a109984a5so2962944276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781449; x=1741386249; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Ck10qS4AIVni+TJE8pJGK1gpI9LtVGv/HWjv7OGFQ=;
        b=4vjc+zr13Dtlbxf+Nk/7DSapnrCHFwSJ8sbCYkZVgJnSRgvK+AjQAt0XR6V5bV1o/i
         f6TDU6wH3SJefurO7rLWlBwUUqT74VG0MsPULJEazYZbc8G1uzBNlWXUlEbbJhtpFGHe
         XsX7LO61+9z5y+OtJ3OikoJ04vtKEnkk5z7cXBB7xEGD5NsuRpRzc0x+8S/PJyR2cJIX
         gx+67HT+bc5afjJrtZZCb+u/cfOyAf2z4DWXYbtBdoQ2hkkn1Jqo+z7iLa1N2YNGZx2A
         +Yw75BN8Wvw3jNGvI76vRp1JNbXZGrkVNQDKqBYigBsi2LdE79TxLc9Xx9SrtBdK/z2W
         DPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781449; x=1741386249;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Ck10qS4AIVni+TJE8pJGK1gpI9LtVGv/HWjv7OGFQ=;
        b=gike3GviayNuK9dRY8g+BdEXHyBzfG3lLQ24YIhMxzbt5dl/GHj9KWtcaTUlGRiTdU
         vIfb3wgjO+9FYdxMsBU8c+/AcqT/8Kaqdxaz1ySGvnzWozBSXmxIQfQRiyrTeVZay6Mo
         OTg/5jGCy5cR5E1QNH0UtrofcQMnD1gKLpYN137bXN66Z3qNJIZnF8kn6GzcXvBulqnI
         69AhMIhMUeJ7eg8akXtfaAhkNFStWyi3nmVqioUhxZPbtWszYmNFS4siefZR7Rpm+hHp
         NGEvoHM4GoS834lupkNDzInCGp3CVJJgLacP5R0CnswY8mlRVLgQ6HOV3SYOYYyLjwpc
         sizw==
X-Forwarded-Encrypted: i=1; AJvYcCVtsr48EKHvckjDnLJzMK3xKEkLdr+yy0z9UzGEfzNoHIdyam+QfUbOJjSDi2fT/2FIdSs2+zJXywXolAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBvRmpQIol2abIc53ye60aV80B+OY0bJDY1JdYvRXhrs3Bug0m
	C+i1xcsDNhEIUeWOyMBhg+nRCYL4QFz/rx2FinHz1pBp5l0SXBjp2QMIlaJ+XlY94gzxiHSc2V7
	04oZKEQ==
X-Google-Smtp-Source: AGHT+IEfAgbSFD2GZxEPGDtfX9Wvdb3Knr+OFfhlJnykxtIBlfOzAQ+++VosFQ1ujFxqWDc9HGj4dSXR8grf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a25:a126:0:b0:e5b:1032:bc4f with SMTP id
 3f1490d57ef6-e60b2e8e35emr32930276.1.1740781449510; Fri, 28 Feb 2025 14:24:09
 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:05 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 08/11] perf python: Avoid duplicated code in get_tracepoint_field
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The code replicates computations done in evsel__tp_format, reuse
evsel__tp_format to simplify the python C code.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e244cc74f16d..7f2513ffe866 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -342,23 +342,14 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
 	const char *str = _PyUnicode_AsString(PyObject_Str(attr_name));
 	struct evsel *evsel = pevent->evsel;
+	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
 
-	if (!evsel->tp_format) {
-		struct tep_event *tp_format;
-
-		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
-		if (IS_ERR_OR_NULL(tp_format))
-			return NULL;
-
-		evsel->tp_format = tp_format;
-	}
-
-	field = tep_find_any_field(evsel->tp_format, str);
-	if (!field)
+	if (IS_ERR_OR_NULL(tp_format))
 		return NULL;
 
-	return tracepoint_field(pevent, field);
+	field = tep_find_any_field(tp_format, str);
+	return field ? tracepoint_field(pevent, field) : NULL;
 }
 #endif /* HAVE_LIBTRACEEVENT */
 
-- 
2.48.1.711.g2feabab25a-goog


