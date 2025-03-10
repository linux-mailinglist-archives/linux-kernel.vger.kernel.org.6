Return-Path: <linux-kernel+bounces-555136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE653A5A5EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC363AEFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C22B1DE3A3;
	Mon, 10 Mar 2025 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ/khdXe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CDF1D6DBF;
	Mon, 10 Mar 2025 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641342; cv=none; b=mJYCHlFlkI7eAFVPvOrQlImcaY94auyRPSLtsqoPIIBWdngf+dP4q0dMlGurk81kVXkauCPayczVQeYRTNTHWA/4zHo89us6OAQERfdgfw0ik3T4gIlm31FueCvCzjxkG4Sza4QFCZ0/t9HArRyzp9hctdRVQ6Ac6YDizzWOS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641342; c=relaxed/simple;
	bh=RCueCySRgRCdwQaMcCPgJhZIgjDNJsgcqfuiOG8fTnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/16EZYlzVY+TmTzvI86AMs2XelQ9ivlKyGF8u/Kmy47ENI2PNKM5LMXTvQqh/HpHOaq0m0FzfM2RMxqv3jauqfflLm4X6BKd6XaGWynOEVm6h5yjeGcRm4P9C+183f7m/3WeYvLj6zl9d7sT9bD/ICmm8sunzw/Zbpyw6DXd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ/khdXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A351EC4CEE5;
	Mon, 10 Mar 2025 21:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741641342;
	bh=RCueCySRgRCdwQaMcCPgJhZIgjDNJsgcqfuiOG8fTnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZ/khdXe4pcopTnerXS5SBGICHgIJmgfsx/8ptZbJHjg+5fd0++3/EUFngVvvWaoG
	 qVNpwJVm8jcSOmN99lgKUFoy03KU38WuF7n1ADdu3plPTSLEkRqubfUf2Xug/VAX45
	 NEnY52C9SuJUFUNyrwjkcogkUqMebhs1mn/QEoFfLzby0Ab5/zkGV4IJgmx5fi+w8K
	 MvPcadXPRV5DykkG0IsMvx+xvsdvmmLWHBY3W+yDyLoJx7mMNNxRR/3cOyUl7SQAJ8
	 fkyqHisQlBr9J4nJ7tR5/oF75P2L/avNAztkc/Pc4X/WlQJg6h8q+4nRsZD+enIxLc
	 dUdQbmFN8AkIQ==
Date: Mon, 10 Mar 2025 18:15:39 -0300
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
Message-ID: <Z89We45bGpeJvO9C@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-12-irogers@google.com>

On Fri, Feb 28, 2025 at 02:23:08PM -0800, Ian Rogers wrote:
> Rather than manually configuring an evsel, switch to using
> parse_events for greater commonality with the rest of the perf code.
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Now will all in place I'm trying to test it and I am getting some
strange results:

root@number:/home/acme/git/perf-tools-next# tools/perf/python/tracepoint.py
<SNIP lots of seemingly ok lines>
time 78318710956557 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x1 ==> next_comm=swapper/14 next_pid=0 next_prio=120
time 78318720082300 prev_comm=swapper/16 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=kworker/u112:8 next_pid=1752774 next_prio=120
time 78318706232435 prev_comm=kworker/u112:17 prev_pid=1551246 prev_prio=120 prev_state=0x80 ==> next_comm=swapper/21 next_pid=0 next_prio=120
time 78318708202121 prev_comm=sudo prev_pid=3133818 prev_prio=120 prev_state=0x2 ==> next_comm=swapper/25 next_pid=0 next_prio=120
time 78318748346989 prev_comm=swapper/26 prev_pid=0 prev_prio=120 prev_state=0x0 ==> next_comm=gnome-terminal- next_pid=3551 next_prio=120
Traceback (most recent call last):
  File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 47, in <module>
    main()
  File "/home/acme/git/perf-tools-next/tools/perf/python/tracepoint.py", line 42, in main
    event.next_comm,
    ^^^^^^^^^^^^^^^
AttributeError: 'perf.sample_event' object has no attribute 'next_comm'
root@number:/home/acme/git/perf-tools-next# 

But it shouldn't get there as there is this check:

            if not isinstance(event, perf.sample_event):
                continue


:-\

Trying to debug that...

- Arnaldo


