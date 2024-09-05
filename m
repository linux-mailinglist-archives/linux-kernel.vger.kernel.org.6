Return-Path: <linux-kernel+bounces-316872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B1796D669
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B7E1F24DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88374199234;
	Thu,  5 Sep 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gh9h0dtP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17187198E89
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533486; cv=none; b=AretDcPbwnpb0WYi5EjzMASNVMnMhdfPsRKBc1p3wzjbzeyBGpCkL2DaiuSNumOR8NMyePQmshPI3i9H4iho839EndjtvW6xsNzRmg6Jaw8iangOWXAJrXuOWTxYqgN94DFJH22LI2Wpy+fUd6k845TM/EspHI7HhskCC1kIqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533486; c=relaxed/simple;
	bh=HzVLxxNDCC58aJIsJSeqkv1E21FxH0Gn8OwOLut/Kr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h01OYDzXEAq4I36Q4OGOY7r4lB2tsqlEMSZSAuxYGmJknQj7l3CQ1NWZUzSHRtHfu5XBScecPAi2zM8CBu32jy9jR0pJukYihuxDbWNhZlGU9RTWH1R2zjYOIxquwSl+tXEOxAWT7UbpVuKUB9xVeHI140vVQ0t2nzMKfk3Fcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gh9h0dtP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso4680325e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533483; x=1726138283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGGfB6w3kWS1PGl7UZ8XD03PjQ67uo73eIy0DvIbGgM=;
        b=Gh9h0dtPpqjKb8Ch+M8Ae9q62yIuoqDKVeQPPQ5S1DH/EvvIcHv1Nmb+kV4sBDcajb
         /y9anpK1fCrxIDaJfz9JQ4lcCK7XLIqHMJtKyj/nljNE1LsNYbpha0mw7BySeV1yN3/R
         L2sHPPOoS3kZoh7kurg2+tmsO0Vgy47MfU2GFNBQPiKxY0F0Ppt9bzM9vtTyCzM4vVDs
         Y4eIEXSht1I6ckMhYsKfFpVZkb3Z+adlSYh2bsUvmbl+4I6niLg6v/9hBOHdR+3Co/Jj
         zww7jgNj2VVYL65PKhrOJ+/b4pjyen1oids+qiXkXBC1zjoXNfzN0fiUL4OKEAXian11
         ndTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533483; x=1726138283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGGfB6w3kWS1PGl7UZ8XD03PjQ67uo73eIy0DvIbGgM=;
        b=tEmysQulpCK6SWrnCBfP1g5tCdt09EQ6NHVxeQKFcTS5Sp8kOQWNIAMCSKfo57IvtV
         CtOyGo849uFEqgAX/3GMdCt8XSoIyn5euo4Gk6H43YDUMgG3otdLMVVxOj/fmY8vSZZ7
         5oBk34g2/0uk3FX3RpeLjCXVsNuq3u3mJwteIxUj8/PqM9zR1T0dCofZhgjWrGJvp09x
         xMv9lvTglt0aAKho8O6zsDxsMpbJRB0N6BGncPgObt71ZmX3ESpe5lmaMd9pQsxhGDT+
         iW5p9M8FFW7Ml0F9dxDKdNNL3u7eDjML/m1c8biOJt8/PS5Bbqe1wnC5//f/tceLLE0w
         dlQA==
X-Forwarded-Encrypted: i=1; AJvYcCVgPJQSWrOD7T79MtFfch+UwdLLH8/hWKHsJvztWsU03kroU6os4uJ9FLiUmOaQJj/y8M9pHaCCjth8Rms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBqFagXqU8NLSgoBfm1KrhifJo8e5XdORkKqUWLy/Pod+hjj9
	3HjU8Vo+GO7jp1o4WWKDVr9H8E4tbrY8jfqknmCx3BvTaAjMW+0qjB5J1VNRl9Y=
X-Google-Smtp-Source: AGHT+IEL1yvO9/AmK9ifjqYg7iMQs4H/ox7GyqpcdtMyB1K5iTwls0MsnKmwOXtbuu/kXAMOTl2r5Q==
X-Received: by 2002:a05:600c:241:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-42c8e41bef0mr47718195e9.0.1725533483317;
        Thu, 05 Sep 2024 03:51:23 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:22 -0700 (PDT)
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
Subject: [PATCH 4/8] perf scripting python: Add function to get a config value
Date: Thu,  5 Sep 2024 11:50:35 +0100
Message-Id: <20240905105043.160225-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905105043.160225-1-james.clark@linaro.org>
References: <20240905105043.160225-1-james.clark@linaro.org>
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


