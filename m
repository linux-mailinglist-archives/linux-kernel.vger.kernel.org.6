Return-Path: <linux-kernel+bounces-539558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F668A4A5D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED8B176D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCB41DF984;
	Fri, 28 Feb 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBpFtRv8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAEB1DF747
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781443; cv=none; b=adop6VNKeRxbjNiL8Y3fLNPYJXte8gFOtAMPcSvnoCJR+Dsee2Tc75Kr2GtDj1NLzfJHxj+C+SOFqSP0gnQqLp00Y6rIwwPO62u/4X/TX6JriK4yeaftf5vw0kC38R+OjrMreD1rWD1lp2x+/oJKjqbzSH7HcDzlFjnRSYv+D+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781443; c=relaxed/simple;
	bh=yPSgF/Erg7nRVre+x5Jz1gkXcw2ww+rcY64bedQyBeo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=HCVq4c2LJxZFoGNyGD+RMyXYTNaZSsEAo375JS+BW7221PGeC3Fr+nBNSIq8S1vogAmtZGRFKzi2eFVwz2S0vKFt/ikozkOoZ3LwYIvsEgZfbvAd72Ug2SVCQjTLSTSzY5I7HrU/2u8yPoMRecsTPWsE7uCH7ZshN/AnjE2PDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBpFtRv8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2bdb560ecso37496967b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781440; x=1741386240; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRqlQ5/wrup7zltecqprA1SHOUOVYQRpzhsxUmWzkao=;
        b=aBpFtRv8oY7yXEVjyoNb64mwugQuQienTuggR1er+tcWIHCYFRCWyoDaKzdC71iO0l
         tiMzTspA/I73JR9dPEpLdy6R4+NBEbP2qK1xSIXJ1E4wU28x6gQM7AoyEUmKYQXeDAbj
         PHLlMQabRXeZJJwa8JxHR/BeE2U3/FkIeP+L1qEWyPHmp7jjA4d4ftrA6TUgss/iDs7Z
         wDyEx7emTReeICv19lAQrVxWk7RfuaGXVLf8dZinu3zZBkd9a5dnY9ovdrghmEZR5i6J
         KfWwWRiAP47P3hKTKUPFk3EhazYNiFIiW1veuU3RNPrYlMnLSKp8w/N2T9m7Tq/bqpzL
         RKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781440; x=1741386240;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRqlQ5/wrup7zltecqprA1SHOUOVYQRpzhsxUmWzkao=;
        b=TMVvE/9RH2iC7TcR53HtMVfRyrk3knWCaCNI/6yfe4Rkf+vJ3Atr98HPcrLZd63OQy
         9s+MEZThdhmYnarKmrzBSpvGpSCKKrkn8wrHFxg+1DCeOlH3lZts256Dy+xE3bJajb9T
         dybLharkvgrjD6DHtyYmmjKB/nhYU9oS3/xOxVmQ4OGUfsY4hulvvbmqhYnzyjuTamtC
         QY7eWFhEtzFapQnLmX5315ZnAL/aSph2MSgcst8pl7a8+0HBLT3qPpYSYLUmnQkj/p5f
         oZe9Dkqvjni9NF9RvCjRA37+Gr0vooORqK0WJwJghb5CnoZ0YB8X/8Eg7R1mOutBo+V1
         zI4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4jE4+rNuyEg12t5qhK3jXmfQj0DO+wuH41tZZPyo7A25OIcvz4l+tNNMB9qMf3y3ZbKqWqbYwNnW4Ckg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjpXRysdSAu5dy4q381f7r81AwjHa7bUchev4KXEPIHyTMrfc
	KNYEwM+cw9gvle5gcMVv8sTwcOo+nQg2OAlrsRVdChwa1kUfoSoTzox4dXDPoAG9/SFF3H8zxnR
	VZOA0jw==
X-Google-Smtp-Source: AGHT+IFcqOiYt0+71v9S4XyEHFuM+CO4XG+qN8q+YtwMhGrGlLxJrG5VKdr4sB09eQOhiDBfxPmzyBgBIHRd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:528a:b0:6fb:78b2:8b70 with SMTP
 id 00721157ae682-6fd4a10fda2mr5924717b3.7.1740781440633; Fri, 28 Feb 2025
 14:24:00 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:01 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 04/11] perf python: Add evlist enable and disable methods
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

By default the evsels from parse_events will be disabled. Add access
to the evlist functions so they can be enabled/disabled.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e2b9032c1311..0cf81cfcfafb 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1028,6 +1028,20 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
 	return Py_None;
 }
 
+static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
+{
+	evlist__disable(&pevlist->evlist);
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
+{
+	evlist__enable(&pevlist->evlist);
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
 static PyMethodDef pyrf_evlist__methods[] = {
 	{
 		.ml_name  = "mmap",
@@ -1065,6 +1079,18 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("reads an event.")
 	},
+	{
+		.ml_name  = "disable",
+		.ml_meth  = (PyCFunction)pyrf_evlist__disable,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Disable the evsels in the evlist.")
+	},
+	{
+		.ml_name  = "enable",
+		.ml_meth  = (PyCFunction)pyrf_evlist__enable,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Enable the evsels in the evlist.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.48.1.711.g2feabab25a-goog


