Return-Path: <linux-kernel+bounces-539563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC5A4A5D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A50177114
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355601E1A20;
	Fri, 28 Feb 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cySwLqlk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDED1E0E14
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781454; cv=none; b=I54/1Xnd9XWKGRDnUOV1WWjjpwSE9behYBHbtvVpfE3/V9s2NXjCQoxipP4QmYQI7YzxQeT7uExic00Hh91JF5/bQbhaVLqwT+hA5E5KYk1ETh2hGNM3OIUOA2pR8JC7lGXpgYUGx9+o+LgKVmgj9w5lmOZnToXaeJfqvfTrENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781454; c=relaxed/simple;
	bh=wrht3Ck1Kuq4sobgfeJPBu1XYS24mA6fKpUErZdwyt0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=EMHSSEpBiBnS5HN1nv5uWA/KOuswOZIeU1FTrf/KjBOJwNjHhTPwtZHqgSgmNBfeTfcgQZgQ4mDd9lhG5EYBhhaNU3R21p218isfG7I2GWJpGczHbUzUelXAZDGx14aAypnhzY4aOw5w265pfPlJoLU8e7lo1wNG1ZFGvKyadHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cySwLqlk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fd409170c7so23177157b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781452; x=1741386252; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlh6ybn/t9Eio4NDtMpr3RQAX90AF4f82uyAhhltD3A=;
        b=cySwLqlkj5aew/DtHv/aObb7sGos68TjBzav8F25UXieR/XsnETPEhp5QoqV3yn/8Z
         4pxg89LFuJRD3ZLA+udxJ4JLMzjyW/99AMdznwXj5j252zQ8OcQohrlima8yZKD1wfeW
         Cf2rMFCmMZ/ao7eELjUYnlQ0o4JOh1k/J9AGSp6S8Zw6Skdoz9M1aWgMhMRhx0w2CeM2
         Xd9GH10DoTkiWtZakUuvFYGNwi0N7M8iaymVzMWfRhnVHBe425Jw15yGTvSkdktTFX/y
         obJu/TszoQK5vUPInX/xq0Ldlv4an88fOdY2Cy5xlYrJf/3J+qHN3LOGJLHkKJhCdR2Y
         C+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781452; x=1741386252;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlh6ybn/t9Eio4NDtMpr3RQAX90AF4f82uyAhhltD3A=;
        b=fTJBiilHPI+dI9wCC/zFY+BNeUxTrXi3OzqM25YyXGZiXrfIa3LwVouZaul3SceIZv
         EhSJlOMJeMgWzXqPIaYRttQgvIAHkC6augSmYV/M6NJbGDpps4Ctgi/H42dY9bdqTvYT
         zQxk7sXu3uvtf+HWS8p0d2DTBdd7LtKPhMgwg8lqDnPPedcnXvG9l4POd/dRx4xl9g/q
         ynXKE9VX3+mppYTqfKlOyW2V3Q0Dr7fyWumtvruyUn9RNV8UxZ4WbsZEAS7HsKXzom3p
         8cdbKc6DcBbLt7Pw5vNe62AjDhJscD9LzLLBzeIiwXWD2qpKNn4AJCxQFMDEkLLxLqNh
         215w==
X-Forwarded-Encrypted: i=1; AJvYcCWAqmQpho1LG+lOfAnwhY3hrih4LdAg2PxEQclcEciZ6gVT3O+vze4tTpg1Dbugx/Dl3qOlvHMXBjHl3v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqwUuCWyUWqG/QfGQVLTTzUlbJ5LC7MEOL93KiV2Jb4SfheyA
	fC9yRgFmIJtYgMbSx+QE/ouhJ5IEtW2LatNFOZxFpQWtKV0ZT3zCCQuQ6LVFzGtuiKe+oHUINOx
	KxF4qDg==
X-Google-Smtp-Source: AGHT+IGS9PUiVd2wbpTmw0ubEIttIIVjgmvg2lVbKCLsqMOnkXdig84FL8BYfckMna/3eucCQ4JlVoCn2p+F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:c18:b0:6fb:8461:e7f4 with SMTP id
 00721157ae682-6fd4a0d3b59mr3420887b3.3.1740781451797; Fri, 28 Feb 2025
 14:24:11 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:06 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 09/11] perf python: Add evlist all_cpus accessor
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

Add a means to get the reference counted all_cpus CPU map from an
evlist in its python form.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 7f2513ffe866..c55c8392bc07 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -874,6 +874,16 @@ static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
 	Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
 }
 
+static PyObject *pyrf_evlist__all_cpus(struct pyrf_evlist *pevlist)
+{
+	struct pyrf_cpu_map *pcpu_map = PyObject_New(struct pyrf_cpu_map, &pyrf_cpu_map__type);
+
+	if (pcpu_map)
+		pcpu_map->cpus = perf_cpu_map__get(pevlist->evlist.core.all_cpus);
+
+	return (PyObject *)pcpu_map;
+}
+
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
@@ -1057,6 +1067,12 @@ static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
 }
 
 static PyMethodDef pyrf_evlist__methods[] = {
+	{
+		.ml_name  = "all_cpus",
+		.ml_meth  = (PyCFunction)pyrf_evlist__all_cpus,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("CPU map union of all evsel CPU maps.")
+	},
 	{
 		.ml_name  = "mmap",
 		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
-- 
2.48.1.711.g2feabab25a-goog


