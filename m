Return-Path: <linux-kernel+bounces-556991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9831FA5D206
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F15D3B187D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565D7264A8B;
	Tue, 11 Mar 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaGYGjg8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229922173D;
	Tue, 11 Mar 2025 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729969; cv=none; b=jSqJCWlJGJNPi3TfGKAbig++/FT0hi1i5ERjIOHyasyHpFO1aGj+J7oxB+ntBBUZE1dkbf01MB4jnA1CtS+N+Vic79P9HjCyZVHdpeaHFLJyOqBYlRGEW1p1gEmq58RX5OznDFLXqcRLnkW1Zu76Wc2d6mcZ1KHSYZduVGnpjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729969; c=relaxed/simple;
	bh=MOV87rZE6+Cwwc8OY6K0omKTZlAmiEV8PvgwcHfQ2ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRCFBI6cMY4e7ZomorZs5VPMCEo+vP20z+N4siOmo2/02OyQHWTmn0PjTQJbuY6XcF1kcJbYWBuYGZwX98JZWasVNT17Mca0zg/ktMZyki0HZcDGI5ZQxkN1drjOy1HgVrnclnxX0kxxYt9T4cxUHwC6AJdo2khb7TZDS9HjI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaGYGjg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91155C4CEE9;
	Tue, 11 Mar 2025 21:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741729969;
	bh=MOV87rZE6+Cwwc8OY6K0omKTZlAmiEV8PvgwcHfQ2ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaGYGjg8Y4+x2gaLazWCyeYO0N/iLUvVKsnn6a+aJcpd47wyLRmGjwix1uiEbMtaS
	 mee/Cut/a0OVgioArN62DrQNJItRi57GK8RBIsDmc+GXzJISfHffYsGCCvXoLGsTAW
	 oXFg5vBBSGIUQeYnz+H3kBZnCG48lJnO+sz6RINuU3sZsIOK6X7dZDB5IqHyz2ha41
	 cJWHhqFKL63YgQ7qefHli/6YCATjBhHz3mC6revK3tu3TSH6IBJuKd1cKDoKZRf96b
	 rAuBK8XUc+8bZcKeZp3BKQagpV0puQzAjUI5HVhyQJB+weXXqLB93ENHQJXTK8KiKA
	 WTCL30qAxUbSw==
Date: Tue, 11 Mar 2025 18:52:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 11/11] perf python tracepoint: Switch to using
 parse_events
Message-ID: <Z9CwrQTEJoT_rRNA@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-12-irogers@google.com>
 <Z89We45bGpeJvO9C@x1>
 <Z89WvaIVyF7klGp6@x1>
 <CAP-5=fXzva636zCZR2isdfrjT6mM3o42C+oGWNkGieqGVajfHA@mail.gmail.com>
 <Z89ZYVgL_bT3ampz@x1>
 <Z9BXdbWnX19ua5Mr@x1>
 <Z9BtpXnqSUYKr1TK@x1>
 <Z9CFwbXSGnGLn0lA@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9CFwbXSGnGLn0lA@x1>

On Tue, Mar 11, 2025 at 03:49:37PM -0300, Arnaldo Carvalho de Melo wrote:
> So it seems to be something just in the python binding, as perf trace
> seems to handle it well:
> 
>  ( field 'prev_comm' ret=0x7f7c31f65110, raw_size=68 )  ( field 'prev_pid' ret=0x7f7c23b1bed0, raw_size=68 )  ( field 'prev_prio' ret=0x7f7c239c0030, raw_size=68 )  ( field 'prev_state' ret=0x7f7c239c0250, raw_size=68 ) time 14771421785867 prev_comm= prev_pid=1919907691 prev_prio=796026219 prev_state=0x303a32313175 ==>
>  ( XXX '��' len=16, raw_size=68)  ( field 'next_comm' ret=(nil), raw_size=68 ) Traceback (most recent call last):
>   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 51, in <module>
>     main()
>   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 46, in main
>     event.next_comm,
>     ^^^^^^^^^^^^^^^
> AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
> root@number:/home/acme/git/perf-tools-next# cat /proc/125355/comm
> kworker/u112:0-i915
> root@number:/home/acme/git/perf-tools-next# 
> root@number:/home/acme/git/perf-tools-next# 
> root@number:/home/acme/git/perf-tools-next# perf trace -e sched:sched_switch -p 125355
>      0.000 sched:sched_switch(prev_comm: "kworker/u112:0", prev_pid: 125355 (kworker/u112:0-), prev_prio: 120, prev_state: 128, next_comm: "swapper/6", next_prio: 120)
> ^Croot@number:/home/acme/git/perf-tools-next#
> 
> I.e. it chops up the prev_comm size to what is specified in the
> tracepoint format.
> 
> And that sample->raw_size is the same accross the sched:sched_switch
> raw_datas (seemingly suboptimal, most are less than 16 bytes, but
> probably its not guaranteed that the \0 will be there, so copy all the
> 16 bytes).
> 
> Now to try to figure out why simply using PyUnicode_FromStringAndSize
> doesn't work...

Didn't manage to make progress on this, I spent more time than I
expected as I think this could be some sort of canary on some coal mine,
but with the patch below, that gives up and just avoids touching the
COMM fields and don't switch from string to bytearray in the binding, it
runs forever, this is just a data point in case somebody wants to
pursue.

That flipping from string to not string based on just one entry not
being acceptable is questionable, and I think it should go away, but why
when COMM fields are bigger what is alloted to them in the tracepoint
ends up tripping up just the python binding is something I couldn't
grasp in today's session.

Namhyung, this is something open, but not caused by Ian's patchset, for
which I give my:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

In addition to the tags I provided patch by patch.

- Arnaldo

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 38b2b6d11f64566a..965b50afbdafeeb2 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -33,15 +33,12 @@ def main():
             if not isinstance(event, perf.sample_event):
                 continue
 
-            print("time %u prev_comm=%s prev_pid=%d prev_prio=%d prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
-                   event.sample_time,
-                   event.prev_comm,
-                   event.prev_pid,
-                   event.prev_prio,
-                   event.prev_state,
-                   event.next_comm,
-                   event.next_pid,
-                   event.next_prio))
+            try:
+                print("time %u prev_comm=%s prev_pid=%d prev_prio=%d prev_state=0x%x ==> next_comm=%s next_pid=%d next_prio=%d" % (
+                       event.sample_time, event.prev_comm, event.prev_pid, event.prev_prio, event.prev_state, event.next_comm, event.next_pid, event.next_prio))
+            except:
+                print("time %u prev_pid=%d prev_prio=%d prev_state=0x%x ==> next_pid=%d next_prio=%d" % (
+                       event.sample_time, event.prev_pid, event.prev_prio, event.prev_state, event.next_pid, event.next_prio))
 
 if __name__ == '__main__':
     main()
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6c5bb5e8893998ae..3eb77bd270077cb3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -318,13 +318,10 @@ tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 			if (tep_field_is_relative(field->flags))
 				offset += field->offset + field->size;
 		}
-		if (field->flags & TEP_FIELD_IS_STRING &&
-		    is_printable_array(data + offset, len)) {
+		if (field->flags & TEP_FIELD_IS_STRING)
 			ret = PyUnicode_FromString((char *)data + offset);
-		} else {
+		else
 			ret = PyByteArray_FromStringAndSize((const char *) data + offset, len);
-			field->flags &= ~TEP_FIELD_IS_STRING;
-		}
 	} else {
 		val = tep_read_number(pevent, data + field->offset,
 				      field->size);

