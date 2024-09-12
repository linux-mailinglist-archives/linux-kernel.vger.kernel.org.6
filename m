Return-Path: <linux-kernel+bounces-326826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D28976D75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CA028DADD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB31BBBDC;
	Thu, 12 Sep 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltLCRag6"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741D1BDAB8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153965; cv=none; b=cVbpvJ0xy9e4M9sgMhmhXOGCTipJnU2NQpJyx373onibpvFi5mJUWNxqRkURCmaUVFBS+PB7wozQBoLcK3xTyQNIOvwfvfHcSOHtnEXWO2kM98UjgHhSXtPmOMRyRkY2YyeKV/lfvx4T6tkUlEOphT7DAPEHR7qpsM3HMX/0Kj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153965; c=relaxed/simple;
	bh=HzVLxxNDCC58aJIsJSeqkv1E21FxH0Gn8OwOLut/Kr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IcwGOjPpAUhOk8Vd4gSWm9M/x+wvIXqIYlfWdYlnwzfWgm2Rh5LGPCScn0EL7YUmKCny0XwA4xM17/zL+ZN5MPfwc44Zj8gIDh8JixnycLlwn++IjP+Kd3Bu3S3NXuO0EjghaMv0Z1MeaiYP0r+PdAVqk69zy3O36A2CI8trWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltLCRag6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so10289025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153962; x=1726758762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGGfB6w3kWS1PGl7UZ8XD03PjQ67uo73eIy0DvIbGgM=;
        b=ltLCRag65QQgrxT0EZksyH6zpTHcQSouOON6PbB2rm3gPI0eUGordxuJoLyzLadJSL
         /PnI3zbnNzZ7OGGb3AVSC13EPnSWJHcugXSg6wH96gunJZ05LBm7fBOdrdMDTm5oa9ED
         34Z0GXK/WB1VQEJKaG5ESY9z+CMu6X2CjMTVBo48FLe2eKXdx96A0wYfHQ/UXyI4lVxf
         V78e5MrJKjCTe3YNzWVK/zhSku1Nv6FKfH48ytj00pg+yKwiwRTqx+FNKvAK5jLGCNvy
         3ViQhxE2horxwnMNWMyAa+BK6znBILNlfuj4b2bSjEA5wpfZOs0Nj4Wz62i3hqKYQ5F0
         1gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153962; x=1726758762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGGfB6w3kWS1PGl7UZ8XD03PjQ67uo73eIy0DvIbGgM=;
        b=whSqqiiEEQiYlu8uoM27m7lxtCENDq+9qZiIY6YYur2/N3E9rLTMejfyQs96pP+qR/
         bCAMQQJA6tCoAt0Or+Sks1umTTmZC7FH8rJ99jB09m/qGVs3brAbAk4kz5/TZwwXHAOb
         Ubn8ikpv8127y0QMmUL5MtyHp+1csJt94D28kE5zz7EA9DQBn98Rn1SDs5vpGZBHSqlw
         YX619ZUgesTymJ8+od6mxB1Q5xQ3frdYlBzyfNFs+IbgHZ7fBYQk69LRGV9qODgYj7ru
         EyTweieli444ppp/3PrVzx3A5zqzn1rzqRRmFIiP1PUgrR7iA+kw+Zk92gwerlLjpLGF
         iXnw==
X-Forwarded-Encrypted: i=1; AJvYcCV5qP+SnRJIwBoQCRzYgB5WPcX3F3/RIXsvpI4/07Da10Uoxx1PZqY/XM7kOxsneErDOzZaA7v7vn3zJx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuS/oDiQjkvS9qmtju/keYCDbZcPL5GEfay+WpufQhLNRtbkSv
	brBa7BWxaeFEgv/CmgkfEDNLi2h3cx9mA+S9+M1ZU6fJn7JaW7ObsZIsORhua94=
X-Google-Smtp-Source: AGHT+IHHXQ3L4ph9W3/LKP4w6PXlKUgz1FmPRZxqdPxBCXFwutCTMRNnHYk9J1u/W+htrP1UYDcjqA==
X-Received: by 2002:a05:600c:35c1:b0:42c:bfb1:766e with SMTP id 5b1f17b1804b1-42cdb55006fmr26068025e9.21.1726153962042;
        Thu, 12 Sep 2024 08:12:42 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:12:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] perf scripting python: Add function to get a config value
Date: Thu, 12 Sep 2024 16:11:34 +0100
Message-Id: <20240912151143.1264483-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912151143.1264483-1-james.clark@linaro.org>
References: <20240912151143.1264483-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This can be used to get config values like which objdump Perf uses for
disassembly.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/Documentation/perf-script-python.txt |  2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  | 11 ++++++++++
 tools/perf/util/config.c                      | 22 +++++++++++++++++++
 tools/perf/util/config.h                      |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 13e37e9385ee..27a1cac6fe76 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -624,7 +624,7 @@ as perf_trace_context.perf_script_context .
  perf_set_itrace_options(context, itrace_options) - set --itrace options if they have not been set already
  perf_sample_srcline(context) - returns source_file_name, line_number
  perf_sample_srccode(context) - returns source_file_name, line_number, source_line
-
+ perf_config_get(config_name) - returns the value of the named config item, or None if unset
 
 Util.py Module
 ~~~~~~~~~~~~~~
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 3954bd1587ce..01f54d6724a5 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -12,6 +12,7 @@
 #define PY_SSIZE_T_CLEAN
 
 #include <Python.h>
+#include "../../../util/config.h"
 #include "../../../util/trace-event.h"
 #include "../../../util/event.h"
 #include "../../../util/symbol.h"
@@ -182,6 +183,15 @@ static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
 	return perf_sample_src(obj, args, true);
 }
 
+static PyObject *__perf_config_get(PyObject *obj, PyObject *args)
+{
+	const char *config_name;
+
+	if (!PyArg_ParseTuple(args, "s", &config_name))
+		return NULL;
+	return Py_BuildValue("s", perf_config_get(config_name));
+}
+
 static PyMethodDef ContextMethods[] = {
 #ifdef HAVE_LIBTRACEEVENT
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
@@ -199,6 +209,7 @@ static PyMethodDef ContextMethods[] = {
 	  METH_VARARGS,	"Get source file name and line number."},
 	{ "perf_sample_srccode", perf_sample_srccode,
 	  METH_VARARGS,	"Get source file name, line number and line."},
+	{ "perf_config_get", __perf_config_get, METH_VARARGS, "Get perf config entry"},
 	{ NULL, NULL, 0, NULL}
 };
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 7a650de0db83..68f9407ca74b 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -912,6 +912,7 @@ void set_buildid_dir(const char *dir)
 struct perf_config_scan_data {
 	const char *name;
 	const char *fmt;
+	const char *value;
 	va_list args;
 	int ret;
 };
@@ -939,3 +940,24 @@ int perf_config_scan(const char *name, const char *fmt, ...)
 
 	return d.ret;
 }
+
+static int perf_config_get_cb(const char *var, const char *value, void *data)
+{
+	struct perf_config_scan_data *d = data;
+
+	if (!strcmp(var, d->name))
+		d->value = value;
+
+	return 0;
+}
+
+const char *perf_config_get(const char *name)
+{
+	struct perf_config_scan_data d = {
+		.name = name,
+		.value = NULL,
+	};
+
+	perf_config(perf_config_get_cb, &d);
+	return d.value;
+}
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index 2e5e808928a5..9971313d61c1 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -30,6 +30,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 int perf_default_config(const char *, const char *, void *);
 int perf_config(config_fn_t fn, void *);
 int perf_config_scan(const char *name, const char *fmt, ...) __scanf(2, 3);
+const char *perf_config_get(const char *name);
 int perf_config_set(struct perf_config_set *set,
 		    config_fn_t fn, void *data);
 int perf_config_int(int *dest, const char *, const char *);
-- 
2.34.1


