Return-Path: <linux-kernel+bounces-512166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FA5A334FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE393A2D71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298EA139CE3;
	Thu, 13 Feb 2025 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5A/qtvP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624201372;
	Thu, 13 Feb 2025 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411579; cv=none; b=V92ldh3PK1KSwfQ+8VHgKrKOGN5MzXo5OVAVC3+eE1q8qkhmfcoOVaJK9ZfwHjpHKG3XRArn7DoSMVRXKjM0YoZiLDGpzZBfm1DWB2D/ytKa/hrB6hW8djD0HKiSVLUHlXa04SwX74cnXy3xaT+Tup8t7fnGI13sW4nqurqEatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411579; c=relaxed/simple;
	bh=O+C671ymDmEMJt123LPm2eweZoLi2ovomf7uDNqov3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPw3hwcKHIMzQbSyaGhLoJr1mSvVwXSIFq3mTTdr633SWgZHF9d6MweWt5XWCUmSt9vBq8yTzGsLfdCxjFsKDk0j34hjRnTE4lcIRWwFW729DVSMy0pAuhdZNvlyl4aJ1cqXQJWaBfrP2mWloFdcmHRuSRbM5IYNMJUZDcTPwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5A/qtvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDB0C4CEDF;
	Thu, 13 Feb 2025 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411578;
	bh=O+C671ymDmEMJt123LPm2eweZoLi2ovomf7uDNqov3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5A/qtvPJd2Zgnb2ql0fE7dLoTKTx1Vf2lIEDH1iLwJlqgBVz5tY8llJzS1VKIMMF
	 dcpTjX+LYtpMZy5FI3adHRUGVEMkxRcj1ou0lOLqSwjNXViTrLjUnNIYQWd/GbOnpx
	 22/LLUvtTDM9RXdLx0nuSpJXk1WpBx/gAhQQgtO55RnB8IVTmfzf6tjMrx7zPdEIKk
	 DchJHydx3JPXAI60Enz5SJbhk3IYXYmN8BegYQpz6NBIFmJlJskifkPLdDhyXJKApz
	 vzMm6PwY2+5YxRn7DyzUGYqxcDXCghdkW5+yeFZrBCj4SdyRVII+B6FqtaiXnspdv3
	 dVQK3vvpncY+g==
Date: Wed, 12 Feb 2025 17:52:55 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z61Qd7NG4k8DDvc6@google.com>
References: <20250206000137.2026034-1-namhyung@kernel.org>
 <Z60NFEAf2C8cL8Xh@x1>
 <Z60Ndm8VVI4Ao31U@x1>
 <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
 <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>

On Wed, Feb 12, 2025 at 02:10:42PM -0800, Ian Rogers wrote:
> On Wed, Feb 12, 2025 at 1:59 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 1:07 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 10:05:27PM +0100, Arnaldo Carvalho de Melo wrote:
> > > > On Wed, Feb 05, 2025 at 04:01:37PM -0800, Namhyung Kim wrote:
> > > > > Sometimes we need to analyze the data in process level but current sort
> > > > > keys only work on thread level.  Let's add 'tgid' sort key for that as
> > > > > 'pid' is already taken for thread.
> > > > >
> > > > > This will look mostly the same, but it only uses tgid instead of tid.
> > > > > Here's an example of a process with two threads (thloop).
> > > > >
> > > > >   $ perf record -- perf test -w thloop
> > > >
> > > > Unrelated, but when building perf with DEBUG=1 and trying to test the
> > > > above I noticed:
> > > >
> > > > root@number:~# perf record -- perf test -w thloop
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.404 MB perf.data (7968 samples) ]
> > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > > > Aborted (core dumped)
> > > > root@number:~# perf record -- perf test -w offcpu
> > > > [ perf record: Woken up 1 times to write data ]
> > > > [ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
> > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > > > Aborted (core dumped)
> > > > root@number:~#
> > > >
> > > > I have:
> > > >
> > > > ⬢ [acme@toolbox perf-tools-next]$ git log --oneline perf-tools-next/perf-tools-next..
> > > > 9de1ed6fa3b73cb1 (HEAD -> perf-tools-next) perf report: Add 'tgid' sort key
> > > > 23e98ede2a353530 perf trace: Add --summary-mode option
> > > > e6d6104625a3790b perf tools: Get rid of now-unused rb_resort.h
> > > > 173ec14e72ef4ed7 perf trace: Convert syscall_stats to hashmap
> > > > 66edfb5d404e743d perf trace: Allocate syscall stats only if summary is on
> > > > ca6637e1ea08e6f4 perf parse-events filter: Use evsel__find_pmu()
> > > > bd1ac4a678f7f2c8 perf bench evlist-open-close: Reduce scope of 2 variables
> > > > cd59081880e89df8 perf test: Add direct off-cpu test
> > > > 56cbd794c0c46ba9 perf record --off-cpu: Add --off-cpu-thresh option
> > > > 28d9b19c5455556f perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
> > > > 2bc05b02743b50a7 perf script: Display off-cpu samples correctly
> > > > bfa457a621596947 perf record --off-cpu: Disable perf_event's callchain collection
> > > > eca732cc42d20266 perf evsel: Assemble offcpu samples
> > > > 74ce50e40c569e90 perf record --off-cpu: Dump off-cpu samples in BPF
> > > > e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF program
> > > > 0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
> > > > efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future use
> > > > ⬢ [acme@toolbox perf-tools-next]$
> > > >
> > > > locally, that is the stuff I've been testing lately, doubt it is related
> > > > to these patches, I'll investigate later, have to go AFK, so FWIW as a
> > > > heads up.
> > >
> > > Had time to extract this, now going really AFK:
> > >
> > > [New Thread 0x7fffdf24c6c0 (LWP 580622)]
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.403 MB perf.data (7948 samples) ]
> > > [Thread 0x7fffdf24c6c0 (LWP 580622) exited]
> > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
> > >
> > > Thread 1 "perf" received signal SIGABRT, Aborted.
> > > Downloading 4.06 K source file /usr/src/debug/glibc-2.39-37.fc40.x86_64/nptl/pthread_kill.c
> > > __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > > 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
> > > (gdb) bt
> > > #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > > #1  0x00007ffff6ea80a3 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:78
> > > #2  0x00007ffff6e4ef1e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> > > #3  0x00007ffff6e36902 in __GI_abort () at abort.c:79
> > > #4  0x00007ffff6e3681e in __assert_fail_base (fmt=0x7ffff6fc3bb8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x7bef08 "map__end(prev) <= map__end(map)",
> > >     file=file@entry=0x7bedf8 "util/maps.c", line=line@entry=95, function=function@entry=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:96
> > > #5  0x00007ffff6e47047 in __assert_fail (assertion=0x7bef08 "map__end(prev) <= map__end(map)", file=0x7bedf8 "util/maps.c", line=95,
> > >     function=0x7bf1c0 <__PRETTY_FUNCTION__.6> "check_invariants") at assert.c:105
> > > #6  0x00000000006347a1 in check_invariants (maps=0xf987e0) at util/maps.c:95
> > > #7  0x0000000000635ae2 in maps__remove (maps=0xf987e0, map=0xf98a80) at util/maps.c:538
> > > #8  0x000000000062afd2 in machine__destroy_kernel_maps (machine=0xf98178) at util/machine.c:1176
> > > #9  0x000000000062b32b in machines__destroy_kernel_maps (machines=0xf98178) at util/machine.c:1238
> > > #10 0x00000000006388af in perf_session__destroy_kernel_maps (session=0xf97f60) at util/session.c:105
> > > #11 0x0000000000638df0 in perf_session__delete (session=0xf97f60) at util/session.c:248
> > > #12 0x0000000000431f18 in __cmd_record (rec=0xecace0 <record>, argc=4, argv=0x7fffffffde60) at builtin-record.c:2888
> > > #13 0x00000000004351fb in cmd_record (argc=4, argv=0x7fffffffde60) at builtin-record.c:4286
> > > #14 0x00000000004bd4d4 in run_builtin (p=0xecddc0 <commands+288>, argc=6, argv=0x7fffffffde60) at perf.c:351
> > > #15 0x00000000004bd77b in handle_internal_command (argc=6, argv=0x7fffffffde60) at perf.c:404
> > > #16 0x00000000004bd8d4 in run_argv (argcp=0x7fffffffdc4c, argv=0x7fffffffdc40) at perf.c:448
> > > #17 0x00000000004bdc1d in main (argc=6, argv=0x7fffffffde60) at perf.c:556
> > > (gdb)
> >
> > So my guess would be that something modified a map and broke the
> > invariants of the maps_by_addresss/maps_by_name. It should be possible
> > to add more check_invariants to work out where this happens.
> >
> > Thanks,
> > Ian
> 
> I also suspect this is a regression. If you could bisect to find the
> cause then the fix is probably to not modify a map but clone it,
> change it and then reinsert it into the maps - the insert is called
> maps__fixup_overlap_and_insert so that maps don't overlap one another
> like the invariant check is detecting. Fwiw, in the older rbtree code,
> invariant breakages like this would be silently ignored, so we may
> have a latent bug :-(

Sorry, I also cannot reproduce it on my machine.  But I think it's
unrelated to this change since you saw it during record.  It'd be nice
if you could bisect.

And I think I forgot to call thread__put() for the leader thread. :)
Will update in v2.

Thanks,
Namhyung


