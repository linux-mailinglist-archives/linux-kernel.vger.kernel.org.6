Return-Path: <linux-kernel+bounces-330743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C26F97A3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5081C271A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE5415AACA;
	Mon, 16 Sep 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FROTD1lj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93462193401
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495119; cv=none; b=XLCQtjz2oy9GZL3GBlwXRLOGmN3eaOWk3jJsx6EC4Xl+lwE3DZ3n8U5IcAmOfjUtejKLcvSSeWxkCgFupU+Ts5mcVZL311GZS2mU2HQl9REopNr6rPtc4hli0RxAy6ciJ4r5U4sWGlGaeaNB+Txw+VD/V4awGA1mRHeo8X7gdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495119; c=relaxed/simple;
	bh=dTvkJQEBjfJBUyrVZVrGWbpyuBvUrffdGllEAiZzKVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBO/h0Zd0ps0BZzAeSAo8sFNS8il0Uz/VrUKMztecMlLbEcbdbtGsaVfPOsG9sSDq6aYRGJNe46LvDZ24DCa6XRdZh/sqb/fGdQ6Mg0jE7+X4560vB5FN3M7ugB68sUgKSP7gD9xQ36ZnNtRnyMW6vroQ5hT8YKlLgHC9spc4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FROTD1lj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso34592955e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495116; x=1727099916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/Q4dm5nWNN2kHtmEV1dKoCfXKla/YrO0a8mdji6DIM=;
        b=FROTD1ljg4dmaZKS39RnKpYRjH0Zem8GJlBm0U4mcI6woySF9xnX9/sad6nY4nVTad
         zi3zwfGUWkQvZsNUOim1h0rr+a7Wr7RXgcUeahxGBbOO2S5N6Hrl4OandsrxIG7WFabv
         skpPfwrb0EWym1D5a+t7PbGhpTjevu4iXLEh0RJtZ3poyb9bP1fYdqtwgho/nN0svrkE
         SEY7flvQ/wfn3v92PBwN58TgZiAqLZN5sRMA1RCERG3TBEHtUG2dznoyH5LCXV4yEGnA
         /PGtHZ/QT2c/tUdiUNiTflPsfiNy2y5ru5L9FJAy63IjCb6XXgOKHiZoqStzr+ga/NSV
         mb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495116; x=1727099916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/Q4dm5nWNN2kHtmEV1dKoCfXKla/YrO0a8mdji6DIM=;
        b=qVtVb4jv1mBYVm52uWCpairO2SZl7RyAAJotTa13NCUCBgdFDMfvrX9HCoJEgM0wpE
         n37fpJEoPrYgfvKeRLknlSFYESD1ILKnAk7sCAX6zKQdjEUkXawWL4NqiqLWQjNUJLNc
         D5PXc65MzUzkUJhSJj/JClms/L4+IKvQkvTjNnbjhebo5CmqsWtyXBvX2uYZoDxt1SAf
         HDKz5d02Ql+H8EscYF8TPMXXe1jzXg4wDXXJeKlReR2ekEjA7ONBTtsFeoXNVDMcvk7P
         GaCNPfBFJNkr0wE1qU3PBubGZ076vniqjWrc52LoYMyZKm8xtyrPESmCqPiXLqPQiFVC
         JJfA==
X-Forwarded-Encrypted: i=1; AJvYcCUCh2hpvRFUJnk7vKNPTapqar/evwour5bJld2xPW6CYWKEy7uhsyhivhNxKlq8BgGxeDQB8wydk+qtek0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4OBxufFrYrYWPyMftuNENCtNxS9/UGFZLlP3pNLDR4yCdFpa
	4itNmxO+L4PlKPVF1OcaoYFrIl9YCIvSM027J1eLEWsnzm5RMkZ3uzGgzj6LZEs=
X-Google-Smtp-Source: AGHT+IFPjvdUr8a7pxtzlAcmP5XIdfDCWxcSeusMeAXrmeyVykL1AMAIIFJJfQRTYkSyTcytvjxS6w==
X-Received: by 2002:a05:600c:474c:b0:42b:ac80:52ea with SMTP id 5b1f17b1804b1-42cdb5097fcmr124703765e9.6.1726495115549;
        Mon, 16 Sep 2024 06:58:35 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:35 -0700 (PDT)
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
Subject: [PATCH v3 3/7] perf scripting python: Add function to get a config value
Date: Mon, 16 Sep 2024 14:57:34 +0100
Message-Id: <20240916135743.1490403-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
References: <20240916135743.1490403-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This can be used to get config values like which objdump Perf uses for
disassembly.

Reviewed-by: Leo Yan <leo.yan@arm.com>
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


