Return-Path: <linux-kernel+bounces-192214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D151C8D1A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420A4B27F51
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD3E16C87B;
	Tue, 28 May 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKoWSqJf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018B16C85E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896738; cv=none; b=Nw0yhsDmrpKzDOgklpZ747NPKYnckovhEA6Ek2O0cjIMcSs1pe0mOj07qs2RM/65SJeV4oqCJaWU8CNmWQDjL4Enxp4Yo+n/w+6R+B+WdhPwG4oQ5ca5ilfLfdIOWsbVtyDDaycKlA9CWXUjXtz1ImmEAXhq8dIvizPntwZaylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896738; c=relaxed/simple;
	bh=0/xV4LdFkajcn56LDZkrLi7f4puJVzOTzZj2Rq2qAd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c94gNdvMaYWi173eDYygvpZZj9b2JdciiLDTASct0v6IYtY408Hxi9MJdHr5e8rJ6JOUJ5xle96ySO68xIf2U9lwJVzpwwhDG6rWxAjpVx79cBUP1UejZN8fAC6ZvkpWk3s5FoUaeUGjr83xsJFFXwBMu6jcu2Z13ZhAoKxRJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKoWSqJf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716896735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rMfCZO8g2vfGsqH1SK9rU/F4CmTOiXAI1AfElosqsKo=;
	b=aKoWSqJf94X2vCDryMbzLfZhY/NB5yLs63yvVqSJWNxNGFgYdYLRcGqCk56wrd755D2dU+
	fwLge2XJQ8zvn7eYK3bcsjk3Dx5oTC/dCFzqrIirX+/E8aV3zzTr/s++GjR7DKmZ7xSZZS
	b/AqkeDpPKLoo+8UKs4e4z9ZDNB+92s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-etJcTkoMMJuAw7lIc9lwCw-1; Tue, 28 May 2024 07:45:31 -0400
X-MC-Unique: etJcTkoMMJuAw7lIc9lwCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77806801948;
	Tue, 28 May 2024 11:45:30 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.224.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AEAA6C15BB1;
	Tue, 28 May 2024 11:45:27 +0000 (UTC)
Date: Tue, 28 May 2024 13:45:25 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: add a shortcut for metrics
Message-ID: <20240528114525.GA449511@alecto.usersys.redhat.com>
References: <20240527101519.356342-1-asavkov@redhat.com>
 <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1>
 <ZlTCvelaGVb6lCia@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlTCvelaGVb6lCia@x1>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Mon, May 27, 2024 at 02:28:29PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > > > Add -M/--metrics option to perf-record providing a shortcut to record
> > > > metrics and metricgroups. This option mirrors the one in perf-stat.
>
> > > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Signed-off-by: Artem Savkov <asavkov@redhat.com>
>
> > > Not building for me, I needed to add the rblist.h header and also I
> > > think we need to use metricgroup__rblist_init(&mevents), right?
>
> > Argh, that is a static function, it seems we trigger it by having
> > nr_entries = 0, so the following should do the trick:
>
> >   struct rblist mevents = { .nr_entries = 0, }
>
> > So that we don't depend on the compiler zeroing that field, which for
> > local variables it should not.
>
> How did you test this?
>
> I'm trying:
>
> perf list metric
>
> pick a metric then:
>
> perf record -M tma_core_bound
>
> And it gets in a long loop doing perf_event_open() calls...

[snip]

> (gdb) bt
> #0  0x00007ffff6f21804 in close () from /lib64/libc.so.6
> #1  0x000000000061fbd2 in perf_evsel__close_fd_cpu (evsel=0xdab470, cpu_map_idx=6) at evsel.c:188
> #2  0x000000000061fc22 in perf_evsel__close_fd (evsel=0xdab470) at evsel.c:197
> #3  0x000000000061fc9b in perf_evsel__close (evsel=0xdab470) at evsel.c:211
> #4  0x00000000004e0b5f in evlist.reset_weak_group ()
> #5  0x0000000000423bb9 in __cmd_record.constprop.0 ()
> #6  0x00000000004276c5 in cmd_record ()
> #7  0x00000000004c4579 in run_builtin ()
> #8  0x00000000004c4889 in handle_internal_command ()
> #9  0x0000000000410e57 in main ()
> (gdb) c
> Continuing.
> ^C
> Program received signal SIGINT, Interrupt.
> 0x00007ffff6f21804 in close () from /lib64/libc.so.6
> (gdb)
>
> So you should investigate this further.

I tried a bunch of random metrics from perf list but didn't hit this.

It spins forever in evlist__for_each_entry() loop in record__open() with
the same error:

        Weak group for TOPDOWN.SLOTS/5 failed

Looks like the culprit is one of those unsupported metrics, will
investigate.

> The idea, from my notes, was to be able to have extra columns in 'perf
> report' with things like IPC and other metrics, probably not all metrics
> will apply. We need to find a way to find out which ones are OK for that
> purpose, for instance:
>
> Opening: cpu_core/topdown-bad-spec/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu_core)
>   size                             136
>   config                           0x8100 (topdown-bad-spec)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   freq                             1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off PERF_FORMAT_LOST support
> Opening: cpu_core/topdown-bad-spec/

Is it just metrics containing unsupported events that need to be skipped
or there are other cases that wouldn't make much sense? If the latter
maybe it will be easier to just tag the ones that are supported (or not) in
pmu-events?

--
 Artem


