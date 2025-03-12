Return-Path: <linux-kernel+bounces-558406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB333A5E572
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EA73BB991
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B041F03DA;
	Wed, 12 Mar 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJU+/v1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4061EE7DC;
	Wed, 12 Mar 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811526; cv=none; b=YLIWHXAr1TkELHQvAwOHZARBTn4e6wrZx3/AhzM08MQnwsQkpFlmZQBYEwTnzeGHmDV7WrSDDfT2peaa3gESi1U8obgweBGK2yNBx/DgREfKc1DRRZWue+wkdArTw0yiWzp3O/qkF4HQk3WZJk/hvLGdi7axl05h+1ZCRvymWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811526; c=relaxed/simple;
	bh=20bLofz6XYDiF+WRvCaqj1miiQ3b25v70W+ducKHHJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbAMm8MfNXhTEen4U6G4Tb26+bGRzwsMN3Qt6vPbhbq784Y9e43ATC1WI59nwbjT2/JPuvbAqqMhVcavmFoJlRAYLaN3hLCi8OKz4jcYjU6FaIS3WqW/qJ9ETIzI9bTEiurobvJLQoAGc8ZHd8lVE8cTKQeVMMAJIUkx+Y+K3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJU+/v1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4BDC4CEEA;
	Wed, 12 Mar 2025 20:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811525;
	bh=20bLofz6XYDiF+WRvCaqj1miiQ3b25v70W+ducKHHJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJU+/v1kytfiFs6Ol7fQm8y3b48tctAUE1dE+Co/Kjk/oX1nhT93412MFr6vY4x0O
	 2p2+6DTCb1RauYDHYUQIHUn0r1F7Yj+/oeJaQ2XKZR7Oc/HsS3AM8PRelMOt4MLhmq
	 iRuV6Z9yT+PhX/svASibKsFt9/9PIO6587k77X8sUz/DtNS+snEeTmS5oKX/xChC7l
	 yfFTgz4I1WchZ3STf/0jMiArZ8HZHWVTIqoCJkn9fUWLwr8kPewBAZDikG91NsLqWx
	 3ffIND1Fl5BXsZT9zfIm0PcR9sCoiIcAUeVfzMjYxN7/MckNma7e3+s4Fu0w95mlLW
	 nYt3Y512xVP7g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/6] perf python: Don't keep a raw_data pointer to consumed ring buffer space
Date: Wed, 12 Mar 2025 17:31:40 -0300
Message-ID: <20250312203141.285263-6-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
References: <20250312203141.285263-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When processing tracepoints the perf python binding was parsing the
event before calling perf_mmap__consume(&md->core) in
pyrf_evlist__read_on_cpu().

But part of this event parsing was to set the perf_sample->raw_data
pointer to the payload of the event, which then could be overwritten by
other event before tracepoint fields were asked for via event.prev_comm
in a python program, for instance.

This also happened with other fields, but strings were were problems
were surfacing, as there is UTF-8 validation for the potentially garbled
data.

This ended up showing up as (with some added debugging messages):

  ( field 'prev_comm' ret=0x7f7c31f65110, raw_size=68 )  ( field 'prev_pid' ret=0x7f7c23b1bed0, raw_size=68 )  ( field 'prev_prio' ret=0x7f7c239c0030, raw_size=68 )  ( field 'prev_state' ret=0x7f7c239c0250, raw_size=68 ) time 14771421785867 prev_comm= prev_pid=1919907691 prev_prio=796026219 prev_state=0x303a32313175 ==>
  ( XXX '��' len=16, raw_size=68)  ( field 'next_comm' ret=(nil), raw_size=68 ) Traceback (most recent call last):
   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 51, in <module>
     main()
   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 46, in main
     event.next_comm,
     ^^^^^^^^^^^^^^^
  AttributeError: 'perf.sample_event' object has no attribute 'next_comm'

When event.next_comm was asked for, the PyUnicode_FromString() python
API would fail and that tracepoint field wouldn't be available, stopping
the tools/perf/python/tracepoint.py test tool.

But, since we already do a copy of the whole event in pyrf_event__new,
just use it and while at it remove what was done in in e8968e654191390a
("perf python: Fix pyrf_evlist__read_on_cpu event consuming") because we
don't really need to wait for parsing the sample before declaring the
event as consumed.

This copy is questionable as is now, as it limits the maximum event +
sample_type and tracepoint payload to sizeof(union perf_event), this all
has been "working" because 'struct perf_event_mmap2', the largest entry
in 'union perf_event' is:

  $ pahole -C perf_event ~/bin/perf | grep mmap2
	struct perf_record_mmap2   mmap2;              /*     0  4168 */
  $

Fixes: bae57e3825a3dded ("perf python: Add support to resolve tracepoint fields")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 31a877a8eb8fbf09..6a03341e17881337 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1019,11 +1019,9 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 
 		pevent->evsel = evsel;
 
-		err = evsel__parse_sample(evsel, event, &pevent->sample);
-
-		/* Consume the even only after we parsed it out. */
 		perf_mmap__consume(&md->core);
 
+		err = evsel__parse_sample(evsel, &pevent->event, &pevent->sample);
 		if (err) {
 			Py_DECREF(pyevent);
 			return PyErr_Format(PyExc_OSError,
-- 
2.48.1


