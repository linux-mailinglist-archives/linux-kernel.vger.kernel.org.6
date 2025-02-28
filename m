Return-Path: <linux-kernel+bounces-539564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46848A4A5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693FC3BB5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657911E2310;
	Fri, 28 Feb 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYxO0cH2"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418031E1A23
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781456; cv=none; b=PMfraEMHZspx8NWpZw7Kjz1mQcAJroASA1nQNR04iPcTm6ZYQ6HFoZriv7VGsD1gpxbBlq5TleGJOk+GgCZUrVN00ryTWWS3DHAiRWQl/4JW/ffbvFADHf31sLQ5aqNkg70a2VDVWjlKrdyD79tgkZnxQ1GYz8ylCC6a7N08e9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781456; c=relaxed/simple;
	bh=jARGiuOKFpE7ttUiyi3nXCy1dRKbqXYHUbF5NHjb0bQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=hXgez61mbVIDWaQv5QgWPBzBPqVE56USxfJXAgC2axeDqjNuGiQTECVxxizlP1wK06kpKttdwlb+PihyJwDU4c9CcRaIybFbWQVLuYC5JOQvxgZHfvwIhjUT6BcNyjjCA6Xoz3pm7uYTJVf2m7N86XtodJClhjzvjybHzzw/zaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYxO0cH2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f788a1de55so34660217b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781454; x=1741386254; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=enmPSmBHYN1yp2Q+rHUZdMzy5YlY4bNvK33F83dFzQM=;
        b=PYxO0cH264RH1PhhlGubyv9U+IHcFdJGk9690ga/wLCIWccjmucqtnvWOCok5aRTTC
         /vaeW3mhGYNttXgjocC98Gv/geClz5zMufi+wqKRfMGVsv0YaEAj60fs7wPxL+osIDFO
         HAqNPM89T4WOC/OkXhSDRlqknWAfzeDMgmO106gFVJgFupZSTCvUFGbonXVrDZod3hfG
         h8HXzW6Ttetkl0Mi4S1TCuFRrAKLLRkFeoZ9oW0+VPLQGmIq47vdGfq2Byds30JRqzys
         sB+4tSTnH1w+JSQESQaZkwaEGYOA66ezFrGNw18he5M25plmjmzOiifIP+fm+4e05T9x
         jSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781454; x=1741386254;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enmPSmBHYN1yp2Q+rHUZdMzy5YlY4bNvK33F83dFzQM=;
        b=vGyxEVeEoavSfEKrt54evKgzdvisSQaHnzvzwk8jwtQM8uYwFhxEfgc31xAHj8Opus
         O+echUUvYa7s5h/CG0McIYfFFTwXQVzyTIIBPmHD6nqGuH0OOvFNXh8mrNsE1HjJHLlP
         xEDPTZa54Y4W5iKnpj5doaqmTKzJaelLwJwa/frb5GD+bO08CNuu4IxzNX6BmLjAQCPK
         kWPRk21HudLWf3gX4/dr1ckiBDZaF457XvyracU/XoR2o2zKr9dKjcOBcp2INPTbW8Vy
         HZjk37L+WUc5gXNu8f/HaSmiEp21+dpILjI7R+hWHTUQUR4wGFqYNFDFl5GDafxKwmFY
         I0/A==
X-Forwarded-Encrypted: i=1; AJvYcCW+pK7aFSZF0k4Jp+AlOWb3As+KbvUS4UCcahMzreImxfUDIeXehAvPwGmt/Na5uQoA6oxxqwhY2PDxNFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5stBrFtC/Jwjm28JizgEf5LOAHpURY5QDejmsy5C7vbQ7a1y
	xapXYJon08SW0GQdHmmgyoJMhlfpHjLSwyu/5krzU4rTC67N8iR0lbVBlwuySHwKM/JnGJGhGo5
	tJzVXxg==
X-Google-Smtp-Source: AGHT+IF5Ht5Zx7YaRV6uVmPiWZ2hPFfsxIko0UkgE1lrkUhapRpqms48maTlHe7yM9CQdUCAckPuCsM5tclE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:6e10:b0:6fb:51bb:bb6 with SMTP id
 00721157ae682-6fd4a0f3ac6mr4933897b3.3.1740781454138; Fri, 28 Feb 2025
 14:24:14 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:07 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 10/11] perf python: Add evlist.config to set up record options
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

Add access to evlist__config that is used to configure an evlist with
record options.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c55c8392bc07..69ec2ad60d98 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -9,10 +9,12 @@
 #include <event-parse.h>
 #endif
 #include <perf/mmap.h>
+#include "callchain.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "event.h"
 #include "print_binary.h"
+#include "record.h"
 #include "strbuf.h"
 #include "thread_map.h"
 #include "trace-event.h"
@@ -1052,6 +1054,31 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 	return Py_None;
 }
 
+static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
+{
+	struct record_opts opts = {
+		.sample_time	     = true,
+		.mmap_pages	     = UINT_MAX,
+		.user_freq	     = UINT_MAX,
+		.user_interval	     = ULLONG_MAX,
+		.freq		     = 4000,
+		.target		     = {
+			.uses_mmap   = true,
+			.default_per_cpu = true,
+		},
+		.nr_threads_synthesize = 1,
+		.ctl_fd              = -1,
+		.ctl_fd_ack          = -1,
+		.no_buffering        = true,
+		.no_inherit          = true,
+	};
+	struct evlist *evlist = &pevlist->evlist;
+
+	evlist__config(evlist, &opts, &callchain_param);
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
 static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
 {
 	evlist__disable(&pevlist->evlist);
@@ -1109,6 +1136,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("reads an event.")
 	},
+	{
+		.ml_name  = "config",
+		.ml_meth  = (PyCFunction)pyrf_evlist__config,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Apply default record options to the evlist.")
+	},
 	{
 		.ml_name  = "disable",
 		.ml_meth  = (PyCFunction)pyrf_evlist__disable,
-- 
2.48.1.711.g2feabab25a-goog


