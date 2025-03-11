Return-Path: <linux-kernel+bounces-556420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE5A5C7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5313BC1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70B25E804;
	Tue, 11 Mar 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVwr5I0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C581A5BA4;
	Tue, 11 Mar 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707129; cv=none; b=YlGQ7bAwhsK4plNqy/feDqMw7CsyOAMBqZOD9MYFH27xwfVPPIW9RZ++rQtUWRqHMGiw1wjJVT8QL7e5qk9w9IRyPQLKRxXr2bGjyh/J7keKOmc45teKzCv88QMP22haSO9TcTep2SlGD6asvYFnLl69TRfz4Ta84aIaqRIA2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707129; c=relaxed/simple;
	bh=XSzGoUU2DaCednX0FwOULdKUbQbWd5loQ7tAM92Ih1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2QbnimYM089GvGgYskt9UuvOk87SCGEhseNEIj/bcu6IZfCx0tC9MOK1jW3YHuJCvpatOGWZHdwBXdJZ3qh/NjZwYXHL0GLPpTn/VAqVOZKvqZz7cPyOCMuil/H27J5ySjYkcFAWUse4XBD5+OGZ1m3av0W9JN99zQsMs48VHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVwr5I0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F62AC4CEEA;
	Tue, 11 Mar 2025 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741707128;
	bh=XSzGoUU2DaCednX0FwOULdKUbQbWd5loQ7tAM92Ih1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVwr5I0Er+lCb110bnzY6YJBd6Tv5Y8Rx8m2J8aWZv+Qk4lmQkXA3A5ZFKSWB2Ey8
	 49kHfeeVtAzoX7svWTgsHdIkjN5YOH1iJDW76PdrxYcpWadHMy3j3eJCdL8WJlLE4C
	 Nw8PabxQw4LDqIrWqJYTZzbl8DfweCHILllDwhAsxbbhyro/P1umEYx5pZm6PoA4mB
	 CTYBt7L8iJEMlnEl4hev3r0if3XZonjYplHvSxiVcIV0l5BjkhA7j65Z5pGtK6LH5Y
	 RT6al/ePYUnOSrVDDZ0txeEAtOEtQRwh0qkrxRkG9TlQU0yvYT9BnnLD+jogbgcCcj
	 TPTZI6RLKetVQ==
Date: Tue, 11 Mar 2025 12:32:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <Z9BXdbWnX19ua5Mr@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-12-irogers@google.com>
 <Z89We45bGpeJvO9C@x1>
 <Z89WvaIVyF7klGp6@x1>
 <CAP-5=fXzva636zCZR2isdfrjT6mM3o42C+oGWNkGieqGVajfHA@mail.gmail.com>
 <Z89ZYVgL_bT3ampz@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z89ZYVgL_bT3ampz@x1>

On Mon, Mar 10, 2025 at 06:28:01PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Mar 10, 2025 at 02:17:59PM -0700, Ian Rogers wrote:
> > On Mon, Mar 10, 2025 at 2:16 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Mar 10, 2025 at 06:15:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> > > > > Rather than manually configuring an evsel, switch to using
> > > > > parse_events for greater commonality with the rest of the perf code.
> > > > >
> > > > > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Now will all in place I'm trying to test it and I am getting some
> > > > strange results:
> > > >
> > > > root@number:/home/acme/git/perf-tools-next# tools/perf/python/tracepoint.py
> > > > <SNIP lots of seemingly ok lines>
> > > > time 78318710956557 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/14 next_pid=0 next_prio=120
> > > > time 78318720082300 prev_comm=swapper/16 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=kworker/u112:8 next_pid=1752774 next_prio=120
> > > > time 78318706232435 prev_comm=kworker/u112:17 prev_pid=1551246 prev_prio=120 prev_state=0x80 ==> next_comm=swapper/21 next_pid=0 next_prio=120
> > > > time 78318708202121 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x2 ==> next_comm=swapper/25 next_pid=0 next_prio=120
> > > > time 78318748346989 prev_comm=swapper/26 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=gnome-terminal- next_pid=3551 next_prio=120
> > > > Traceback (most recent call last):
> > > >   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 47, in <module>
> > > >     main()
> > > >   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 42, in main
> > > >     event.next_comm,
> > > >     ^^^^^^^^^^^^^^^
> > > > AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
> > > > root@number:/home/acme/git/perf-tools-next#
> > > >
> > > > But it shouldn't get there as there is this check:
> > > >
> > > >             if not isinstance(event, perf.sample_event):
> > > >                 continue
> > > >
> > > >
> > > > :-\
> > > >
> > > > Trying to debug that...
> > >
> > > And it doesn't seem related to your series, I checked and v6.13 has the
> > > same problem, I nuked the build dir, etc.
> > 
> > Right. I'd seen the same issue.
> 
> time 79411977132102 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x2 ==> next_comm=swapper/12 next_pid=0 next_prio=120
> { type: sample }
> time 79411977200343 prev_comm=kworker/u112:17 prev_pid=1551246 prev_prio=120 prev_state=0x80 ==> next_comm=swapper/16 next_pid=0 next_prio=120
> { type: sample }
> time 79411964535268 prev_comm=kworker/u112:14 prev_pid=810939 prev_prio=120 prev_state=0x80 ==> next_comm=swapper/17 next_pid=0 next_prio=120
> { type: sample }
> time 79411964746511 prev_comm=swapper/18 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=kworker/u112:12 next_pid=2109251 next_prio=120
> { type: sample }
> Traceback (most recent call last):
>   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 48, in <module>
>     main()
>   File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 43, in main
>     event.next_comm,
>     ^^^^^^^^^^^^^^^
> AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
> root@number:/home/acme/git/perf-tools-next#
> 
> And it says it is a sample... 
> 
> Well, ran out of time, will try later or early tomorrow, will also try
> to review the syscalltbl series and Howard's off cpu profiling.

Its some sort of corruption, I added printing the sample_* fields and
then up to the field before next_comm:

time 2462907120158 prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=0x0 ==>
next_comm=gnome-terminal- next_pid=3646 next_prio=120
ip 0 pid=0 tid=0 cpu=12
time 2462916970223 prev_comm=swapper/12 prev_pid=0 prev_prio=120 prev_state=0x0 ==>
next_comm=gnome-terminal- next_pid=3646 next_prio=120
ip 0 pid=0 tid=0 cpu=14
time 2462902120635 prev_comm= prev_pid=1919907691 prev_prio=796026219 prev_state=0x323a32313175 ==>
Traceback (most recent call last):
  File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 51, in <module>
    main()
  File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 46, in main
    event.next_comm,
    ^^^^^^^^^^^^^^^
AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
root@number:/home/acme/git/perf-tools-next# 

See the empty prev_comm, bogus pref_pid, ditto for prev_state and
pref_prio and then it simple doesn't have that next_comm...

Also I noticed that in tracepoint_field() (tools/perf/util/python.c) we
can get the string tracepoint fields as a bytearray or as a string,
ahere:

                if (field->flags & TEP_FIELD_IS_STRING &&
                    is_printable_array(data + offset, len)) {
                        ret = PyUnicode_FromString((char *)data + offset);
                } else {
                        ret = PyByteArray_FromStringAndSize((const char *) data + offset, len);
                        field->flags &= ~TEP_FIELD_IS_STRING;
                }


For some reason in sessions where bytearrays are returned, and all comes
as bytearrays, the problem is not noticed.

But when it comes as a string it breaks after a short time, /me
scratches head...

- Arnaldo

