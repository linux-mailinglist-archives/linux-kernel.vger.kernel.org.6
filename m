Return-Path: <linux-kernel+bounces-185434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB88CB4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E3AB22843
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F94F1494D8;
	Tue, 21 May 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTXXRmiI"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5751C4F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324533; cv=none; b=Ff259n7jdWDav305Q/PoW+LcmVWI9AscEui9zS7tZiz9kYVDvCaX4LQ0vcuceydxYE8W93WcchAwHgTA5b4P2PldKJcb3u6uml7MaItbS4KH5d7/VzqFWo4p3QhGeJvrh3kiNZQ8oLUNRkBKH5d/x2b3ofCb5EzfE2HFaIbIyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324533; c=relaxed/simple;
	bh=zoeQCvO1cRJzL/0Yu+xIM/DGcmlB3cnncHRAUkEZY6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LzcwNErCy/DOWZ5FQuBZB1KUmSyUfBh5Wn+HLt+ksCm9zaQR0GYIt8KH1wIlV/I+9dOPSROg68FUEAhue2IpJyP+EueogdxvEXMK1Cbyy8VObzX8/fMjgdc2LrqSzwpeQreBCathpfkhcPNkQYNeFWPrqk696oBpRrD7OMzNbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTXXRmiI; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36db330403fso38585ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716324531; x=1716929331; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czb7Rq/i1FIT5qiIInLs95ShTM5SmEfdEJP+bwh5pxs=;
        b=jTXXRmiIraaVewM3Bsg65ySWQE6Rsmf6beP+W2PFzkaD2j5yUtM2ZBKqS11YfZneQN
         YEf8VFmyZXXKjDpae88EuJz85TjJCaRPf3C8qBU2E6m2kZm+qfEA7LO4jeasQOjNr5Qi
         ncfAHXMBOLFqlR6ZRMzXYI6MdXEly1Ml0cCMogBrRx4lOBjv/qYffND0n4gdL6ieZOW2
         SRRBf7ciiBbaAxWYkzI5Vkl2nxJjDO/+ejt0SahjTg/IwCVyFMS2qONpbNdZhwkOEcNr
         lNx1lznqTgkI/luTtzjhjhJtGlswZWCnovDuZhbarm4cbQB33EWoe8y47Hc2rnPg0GPY
         0AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324531; x=1716929331;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czb7Rq/i1FIT5qiIInLs95ShTM5SmEfdEJP+bwh5pxs=;
        b=Q604KbkxgeAGX0BuUJX+wCxtQJANJpCNVF4eu/aDrPegCqDGvfOYo4v9g9x1ph0DQw
         kTb/Izhf9H+hzEBz89en5N50sl9cOo/XU0sFgNCGKQPHTL8FvX/K/SwwTBMc9CH7K4HI
         l6vnhx+EoWnlhLJ83PhHUaaJsvgY6s6lu5hSJ5bwv4Hi/U+o9bTrYMVRNxiU/WQ8VOnc
         wHhTSIoRFdWlf28JwSL4q8HRtG7qZu6UeaK/d3acwh3vHNSCctWh95oWExTIkZwUdI7W
         aAyB2KfgkRYTO5YtJMr21JtVjAcj+KEI3eLM7S2cDbB8n8d7Ov1zZ/BRvynOiN3cUYjn
         C7YA==
X-Forwarded-Encrypted: i=1; AJvYcCVlbZUgblbV/G+MWNeyd1bKSJA/M6wbhiUoZdHNRaaQz9htpMW0qjkzxiWhe7N2fFwdoDW6GNylkL+m61BUWXFQYNQvXhYkLKslixkZ
X-Gm-Message-State: AOJu0YyoWG1CXrX6hCczxyvwlXlO4t/0wHPazbgln0prn08ZU2dC4U3d
	A35pTRibWI3FDeeE7GsAbOHmgDYP0f+M4wzxBnTzWv/lJfebOGOIm6DN82n0u5tBKzrXlbOt3JR
	ruKgrOKe9roE/DtLTji8e41ATZXJnCFdJhs+U
X-Google-Smtp-Source: AGHT+IHFs+YEyZTQ1wDxhhN1iMih67PzsakBzeF9WW5YMyLTbdJsOKUCKWr8AmBmZYMLilSKqeIi5t5RtLPeQ2fkQDE=
X-Received: by 2002:a05:6e02:1fc1:b0:36b:ca1:239b with SMTP id
 e9e14a558f8ab-371d8aaf329mr751495ab.28.1716324531096; Tue, 21 May 2024
 13:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com> <CAP-5=fW_Ri1yOfq2QS1_NOV0+kNm+n+Vv03v3FjfbRet4Ztn7Q@mail.gmail.com>
In-Reply-To: <CAP-5=fW_Ri1yOfq2QS1_NOV0+kNm+n+Vv03v3FjfbRet4Ztn7Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 21 May 2024 13:48:39 -0700
Message-ID: <CAP-5=fVc+hvww9YAX2-UfQTJyFn7qM_7aoSwZ6SvgZoveMBAdw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Event parsing fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 9:48=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, May 9, 2024 at 10:38=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > For the default events, parse from strings rather than use pre-cooked
> > perf_event_attr. This fixes non-x86 heterogeneous CPUs where legacy
> > hardware events wouldn't be opened for all PMUs. v2 was previously
> > just patch 3 but it is extended in v3 to incorporate related fixes.
> >
> > When a sysfs/json event is used in preference to a legacy event, allow
> > evsel__match to still function using a saved hardware config
> > number. This fixes hard coded metrics in stat-shadow for events like
> > "instructions" on Intel that have a sysfs file.
> >
> > Fix/improve uniquifying event names fixing the test "102: perf stat
> > metrics (shadow stat) test:" that was broken by a formatting issue
> > when the sysfs instructions event was used.
> >
> > Having evsel->pmu_name and evsel->pmu->name is confusing, get rid of
> > the former. Fix/improve evsel__sys_has_perf_metrics in the process.
> >
> > Ian Rogers (5):
> >   perf evsel: Add alternate_hw_config and use in evsel__match
> >   perf stat: Uniquify event name improvements
> >   perf stat: Remove evlist__add_default_attrs use strings
> >   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
> >   perf evsel: Remove pmu_name
>
> Hopefully the first 3 patches here can be a priority given the fixes.

Testing:
https://lore.kernel.org/lkml/20240521192614.3937942-1-acme@kernel.org/
  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git
tags/perf-tools-for-v6.10-1-2024-05-21

I see this failure:
```
102: perf stat metrics (shadow stat) test:
--- start ---
test child forked, pid 785992
IPC is different: 1.31 !=3D   (2725291544 / 2085879817)
---- end(-1) ----
```
Which is addressed in the first 3 patches here.

Thanks,
Ian

> Thanks,
> Ian
>
> >  tools/perf/arch/x86/util/evlist.c |  74 +-------
> >  tools/perf/arch/x86/util/evsel.c  |  35 +++-
> >  tools/perf/builtin-diff.c         |   6 +-
> >  tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
> >  tools/perf/tests/parse-events.c   |   2 +-
> >  tools/perf/util/evlist.c          |  46 +----
> >  tools/perf/util/evlist.h          |  12 --
> >  tools/perf/util/evsel.c           |  28 ++-
> >  tools/perf/util/evsel.h           |  22 +--
> >  tools/perf/util/metricgroup.c     |   4 +-
> >  tools/perf/util/parse-events.c    |  52 ++++--
> >  tools/perf/util/parse-events.h    |   6 +
> >  tools/perf/util/pmu.c             |   6 +-
> >  tools/perf/util/pmu.h             |   2 +-
> >  tools/perf/util/stat-display.c    | 101 ++++++++---
> >  tools/perf/util/stat-shadow.c     |  14 +-
> >  tools/perf/util/stat.c            |   2 +-
> >  17 files changed, 305 insertions(+), 398 deletions(-)
> >
> > --
> > 2.45.0.118.g7fe29c98d7-goog
> >

