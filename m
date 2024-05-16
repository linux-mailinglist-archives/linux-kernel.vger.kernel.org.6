Return-Path: <linux-kernel+bounces-181373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 023898C7B31
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF48B22427
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1516B156898;
	Thu, 16 May 2024 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOZ+7PC/"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394871553BD
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880861; cv=none; b=NH9UUtlN1wo8iEBtyOP2wAXcsrcB4V3DGzmP+0XUNGL0AHQSxE61U9g7e8VaQ47jpk7vn1bK67JMCaPKwCgbayRpmo76JdhqxjyOBv08q+z7vEdXdl3QphK6qvvlTCc3d2OnK4WtqptC9sfR7pKRfXT63lAfE8d9MNeCAoeXWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880861; c=relaxed/simple;
	bh=DQzUrR+dgEZ4KhK9ztnpAP2CVSJ041lYtvQDEgYT9OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qIhKerUt5/csUYCRzaJSQc5hx+/glkMnRVz+e0GYzNtZG7jP9MhF3rIKd0d+rMj58bqzx57t4Xg2rGpxnhHW49qb9OxaqMRTQ3IRVphQPab64SABoC7S+qgnJFuH1ZYA4wxbnUpH6MyLnVzEy8tGcU1KZK4rlv9jtSUyDGfVeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iOZ+7PC/; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36db863679bso6715ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715880858; x=1716485658; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5xOVdSKQxj3bC4Jw56jvdbDAorrHCwMBywGdman4qs=;
        b=iOZ+7PC/CpK9o+u00tUzrosnQbm/sm4DhuNKyk+8AUqz0k6gvAs9GslvPpMsJB+2RB
         RGT42GZixX6E5GN2yQRi6bCVjk+q0tMk6elqjjRPZDijZGV42pCBY4OkwvjTTlYGwS63
         4pEpK21zGvrJCPOguFFMNxz5fDfnlt4ssx3muFIxBDCjXwxjJyUcpbrJAhUla+6In2Kc
         FyUBu9Nw+tuRD2LezG8vUQajNWfToMms3hv9yGZqbaxRySlsXCFf0nRzk2nXRd78Z2wX
         NI0siX0P4XWtZZEsjWJlS9gH+R0Zh8n5guzAWspzSzGDVpbTbtziJWVsZYAt52qhq3EO
         WwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715880858; x=1716485658;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5xOVdSKQxj3bC4Jw56jvdbDAorrHCwMBywGdman4qs=;
        b=QcRJup/UVoWR1UgRUR2Gz+t2VTI4UO9puYeucNFveMTkUwvkfnCoHdU3vnfP5+wHmK
         ugDWvs8225z4pB6kIc5r6BkZPaspWXElXpxpMLLXySvtXSdwaWiU9c+vV88XJI0tBRHT
         TSNQacp9CMjrr76Zgj1KUns+wyd/y+nB2d4guxrNmL9HpIo4Y3dOywLAXlXynHziNbDU
         1N0ktjWKDdMWG5BOOIqV4GR9/gncwnXbXV+yE6Aal8ispl8J5REnP8obFXsbxJXLirCY
         DhiyJOmsnA1kDxRfxHnDTE0lth/WE658UCwnF4ZXyQhs/1zgw0szxOCtDGr8vl6+hK91
         ht4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3Cxf6YE5gvTNWp0ASNAh0DlmBgf4shfAQgjHAu9FSc+UHT63G2J83o1J/zsG7CLSeGyE0fkGwqNDzPTxSPA9hucfH68fm3mahVzV/
X-Gm-Message-State: AOJu0Yxy2kXIaehIpsywFP6pqZnHNEtTOPzxFc78fzIe9kdKyb6JkBql
	4t+9KS9ROWtsLDBwXRdpKYtytDH6QX9PVgUdI3WGByX8psjhkLcL3PRXo3Xmq+U41DIuF4vkktb
	HF1Oq/K5S5P6h8XpSx3gxyjF99ozCeU6T4H9Z
X-Google-Smtp-Source: AGHT+IGQfiUsjFLcKTTVRbucdev7xcxK41O6PPY41Ymebz78KF0cs/kiMpgHjzowJxdaXfyke4gY1fFYB8ZvXJz9acE=
X-Received: by 2002:a92:c264:0:b0:36d:959b:fb5e with SMTP id
 e9e14a558f8ab-36d959bfc0bmr11900255ab.21.1715880857923; Thu, 16 May 2024
 10:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com> <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
In-Reply-To: <CAP-5=fW8TA0KQOepQRuC_0mhyp6kHbPodh+6-uoVxsmC=09tTw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 10:34:06 -0700
Message-ID: <CAP-5=fUBJOaE3Tp1NP4Urdt-r_kHEaR00aTKxMrvfe_0fyPxYA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Use BPF filters for a "perf top -u" workaround
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 10:04=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, May 15, 2024 at 9:20=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Allow uid and gid to be terms in BPF filters by first breaking the
> > connection between filter terms and PERF_SAMPLE_xx values. Calculate
> > the uid and gid using the bpf_get_current_uid_gid helper, rather than
> > from a value in the sample. Allow filters to be passed to perf top, thi=
s allows:
> >
> > $ perf top -e cycles:P --filter "uid =3D=3D $(id -u)"
> >
> > to work as a "perf top -u" workaround, as "perf top -u" usually fails
> > due to processes/threads terminating between the /proc scan and the
> > perf_event_open.
>
> Fwiw, something I noticed playing around with this (my workload was
> `perf test -w noploop 100000` as different users) is that old samples
> appeared to linger around making terminated processes still appear in
> the top list. My guess is that there aren't other samples showing up
> and pushing the old sample events out of the ring buffers due to the
> filter. This can look quite odd and I don't know if we have a way to
> improve upon it, flush the ring buffers, histograms, etc. It appears
> to be a latent `perf top` issue that you could encounter on other low
> frequency events, but I thought I'd mention it anyway.

Some other thoughts:

 - It is kind of annoying with the --filter option (either on top or
record) that there first needs to be an event to filter on. It'd be
nice if we could just filter the default event.

 - Should "perf top --uid=3D1234" be removed or turned into  an alias
for '--filter "uid =3D=3D $(id -u)"' given the --uid option generally
doesn't work?

 - What should happen to the perf top --pid and --tid options, should
they be filters? Should they fallback on /proc scanning if there
aren't sufficient BPF permissions? The plumbing for that is going to
be messy.

 - There should probably be a way to filter on cgroups.

 - Does the user care that there are 3 kinds of filter that will work
differently? Could we break them apart to make it more explicit, I may
want tracepoint events with a BPF filter. How can we ensure 1 syntax
for the 3 kinds of filter.

 - Filtering on register values could be potentially interesting, for
example, sampling on memcpy-s where the length is over a threshold. We
have a register capture test:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/record.sh#n81
Perhaps the filter could look something like 'perf record -g -e
mem:$ADDRESS_OF_MEMCPY:x --filter "reg:rdx > 1024"' -  this makes me
think we need to make a more convenient way to specify memory
addresses as symbols.

Thanks,
Ian

>
> > Ian Rogers (3):
> >   perf bpf filter: Give terms their own enum
> >   perf bpf filter: Add uid and gid terms
> >   perf top: Allow filters on events
> >
> >  tools/perf/Documentation/perf-record.txt     |  2 +-
> >  tools/perf/Documentation/perf-top.txt        |  4 ++
> >  tools/perf/builtin-top.c                     |  9 +++
> >  tools/perf/util/bpf-filter.c                 | 55 ++++++++++++----
> >  tools/perf/util/bpf-filter.h                 |  5 +-
> >  tools/perf/util/bpf-filter.l                 | 66 +++++++++----------
> >  tools/perf/util/bpf-filter.y                 |  7 +-
> >  tools/perf/util/bpf_skel/sample-filter.h     | 27 +++++++-
> >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 67 +++++++++++++++-----
> >  9 files changed, 172 insertions(+), 70 deletions(-)
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >

