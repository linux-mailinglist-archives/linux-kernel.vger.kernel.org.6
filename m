Return-Path: <linux-kernel+bounces-539560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB263A4A5D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79760176EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F21E0084;
	Fri, 28 Feb 2025 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGEtrz0w"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404731DFE0F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781447; cv=none; b=Oec+sF1QIv6Dz8sUrks8dqlUAQOWuzhsz3ZO8Y3m9U6A57I8xtVvkZrHK5wIoOpKX1/h0nBGiMorQUlbiBHG5dPrE6Kx5HOMWACeyOYKNpy32AFMHJg4QXTjDwYQCVaPGSwTnA/ACcByOBUvMLhZfuPKepsT/Ka3Owq+4J9JVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781447; c=relaxed/simple;
	bh=c20W4Lu/yCFUCIff1Ju7FoRwzLs1VC3M4seD1jUrq3E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=aSFkn5thGSt8caw66wlPYIZSkoHnMA4x7zVu7wFFxeP3PnQ8Ulmp2cctGWuijz6On272DhwnEN7RA07xjJVGKbwZgah2aJwJVOPeRUT/usUsTSufv1x1yiFIWop+Bndv5cIuFx8vfrQceeMqjCCBW9l6/RFMSmbc6yN2ZCWXmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGEtrz0w; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fcfa304ef4so40514457b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781445; x=1741386245; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUsOhiF32RtA3rdS/vMtgZcfTtdyvQ+DyGJcYbuYksQ=;
        b=hGEtrz0wEox6rzvuO6NpBDVqctkakMf1cHnYjdbymY13S1De23RW5kyCd2RRR5prpI
         BD4jhAVQQa3cPF8NE1Zb3ERsesmbIjmsTJaLw2WW4WoCxYgKPBggzO/E4QsLVxqlYKq9
         BUkO7+6swLDpE4bl/aLNl51D0KrjnePMPeOsThVKdWU9Jlefy1+2d35kIS1zIDjzlc4g
         5/1H7c4KszCNoztpgabDIYQmNBZ6b/mc0od7INWWuLyYDmKknQZM+rNZcsCayJ2RD/xr
         8JcjytiFPcTVlAHidc8sTYZiu8s9h+s+IpSW+a2e1iszEpTEBmw2Qfs7WG0/f83jQKHg
         1S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781445; x=1741386245;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUsOhiF32RtA3rdS/vMtgZcfTtdyvQ+DyGJcYbuYksQ=;
        b=PunxrGYX8/s+x4cKV4yA8ZYlwVW/C8ElgJAck8xR2sM5zhG0JVF9ouOSbg8xTjomOC
         +LMBVmBrYZotO9DbNCch7ZW7S1zBAtHdO/k7q0VEcH4vi3fIEkm+yxtc2akYFG/NXLLy
         k1UQ/mu9pdCwivjdivbLOB6ZDWs6ua3Wnuo6mjvmXZpE+IKqxGr/yCuFXqjbTK/q3YBG
         LoQajfxEw5Ex0SQNwb3YJ4kdL2woHT83yYOGpgFscGqiMV6G/G7BIqz9m+LTG8DMQWoh
         JaUKDvXfHBi2LE0Y5JnvCC+TsF0yD9Sv30C4gkoCFDYoB02WZD9Yf2Eu1iJ5lG9g12iR
         kHHw==
X-Forwarded-Encrypted: i=1; AJvYcCVnhnTfOiW8PKljfhV/y7G97KcM7HOcS1+2ZmJdLGgzgtBghmVrTG4Va3z6j3+1brKrucRroHJu8r+z2aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+rxwlDkCov7H+f9pRdWgI7/VKGAHQn4dTd8kegQiokiM9pu/
	OEFxoqAbUBlGzOpx+TSjIIwaIBK8eUT308Ae6C0XP6LH/KTleiUQ1JG0Sbi/QqnhwPAB7J/q2NG
	XlKqorQ==
X-Google-Smtp-Source: AGHT+IHfd7GrwJfhb+MWua2bx3vtIpV6EB15tYflsFx+umvkBji+DSYZmokYAdQCo0ENr+WPX3hvXcndIKmZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:5c16:b0:6f9:d2ce:45e4 with SMTP
 id 00721157ae682-6fd394641c2mr11001607b3.1.1740781445317; Fri, 28 Feb 2025
 14:24:05 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:03 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 06/11] perf python: Add optional cpus and threads arguments
 to parse_events
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

Used for the evlist initialization.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b600b6379b4e..4a3015e7dc83 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1339,12 +1339,18 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 	struct evlist evlist = {};
 	struct parse_events_error err;
 	PyObject *result;
+	PyObject *pcpus = NULL, *pthreads = NULL;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
 
-	if (!PyArg_ParseTuple(args, "s", &input))
+	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
 		return NULL;
 
+	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+
 	parse_events_error__init(&err);
-	evlist__init(&evlist, NULL, NULL);
+	evlist__init(&evlist, cpus, threads);
 	if (parse_events(&evlist, input, &err)) {
 		parse_events_error__print(&err, input);
 		PyErr_SetFromErrno(PyExc_OSError);
-- 
2.48.1.711.g2feabab25a-goog


