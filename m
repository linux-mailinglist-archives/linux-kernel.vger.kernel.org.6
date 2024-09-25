Return-Path: <linux-kernel+bounces-337928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C81C98511D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B3B285129
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752401494BB;
	Wed, 25 Sep 2024 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wr2d1QD7"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63007647
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232827; cv=none; b=GokNlag0wQbHBbwBxUJHHZ23sGa4/PfnbYDn7OQKETv5WZoVRMUablyPe7tE9jj5jTpept4EaeVYWL4h+EhTeMDd3V9MZ0lW/gGjwHBJaxov7uUcTk/5nRxp8JscSaIFhtkhyHcazAtMXyzJq3zgv51Y4usZjFyTZkreNd7TBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232827; c=relaxed/simple;
	bh=BVtIXoNPDtV9b5W6sPXiJg1yRfY97j9WW4x1rZIkUl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUU/NGcU28biPtHHdA0i+T2BGoQrdDmsSxK1//3f6BH211uM2jq312W5M+AHMS5SGdFTzotrSTQGzfbqxb1eulgb9nP+2hIDGKFPgZrV8K6AdQIh4qJHiddviPQKmv0SgHA0PV4YzcKxLyuG6bFajG5irC74FtkkcspGdFR2IZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wr2d1QD7; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso162245ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727232825; x=1727837625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE1g72vjBXIZmoO6mhWph28xLfHkuapm11FZBuAO5AI=;
        b=wr2d1QD7W0vmvSi4JsetTY54FC8Am17nOmojdrt6bw0slC9gr1Xx7V83aNXRsIuUnS
         ewM27wmvkau/TN+E1XsQ93IGqQ5SMRIErSEVBE693+eH5NHJJDcxJwAzfboLPzxRLomO
         3CD/imx+5Hq4Zm73RHTIbOO/Vv6Jvk40PpzGDIL1UpKMffaCd3PlFBf1MDqa2SwwWomp
         iCi+cYmmtJE7GxB/IWaFM4uWTOpZSNGZDnO8USvjG+FubWKFI4r4qJCwpz9nC4b8Ycx+
         LNS5e256t+u2f/pksfO5GCq4O7CWEp3HDPLTR7T0y8lfTooq3i+465Bsdf2C0op3HhcG
         DeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727232825; x=1727837625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE1g72vjBXIZmoO6mhWph28xLfHkuapm11FZBuAO5AI=;
        b=UAL7hbdtGcC36UOW5qQ5gaDvCWYg/d1XBUqGYzAxzhxWiqWkuRurxDTPTF7nBRfsYG
         ICeNB9l6IH4SRVLYetSAKKdOdw224+voKN9R+CnrsDMGr9pEWuO1GH7l0/qblYgH4GBS
         B69hWNWf7TAaDmJ950ExPIkib0t1C54UGt3W8QxzMIqbll+Pa2fA9HkRw5MJJeIBt/GJ
         JxCVqX9YJA1k7u/XdazaRUcxIP9oanmvP8E9sNcnpCG+e0kd4DNsmuWanrPxuZSJ9bo4
         bzYwNeexuXhqd0uVJIVCfcvS44jaKEzwcuEhjoUrofAvlEHBK7nB+MLRy7jX3kCoD5Gn
         dhiA==
X-Forwarded-Encrypted: i=1; AJvYcCUVT2ZLqTvjVS8A/fL/zgkweZz0aZJkcAQXsNMfE6mzEVQ4wp+SWj5p31t9HIHWMgV0Sv0ZTGXNTLC3bBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiODa6DUK5GOj6FjoL2Lu8HAotC9nSdLqn58aBtImjfRZuwty
	ss4LMVhGylgAv5vgAplVCn/tZdbNeQRnLooHJPww4M2RZCX0DL3We7BfVC1uZPOC98WUPsL7S3J
	MpHvps2sdKDgyvLDrD4jDxqrlkJhuVIYwL19AsPCxywIADn1fepkQ
X-Google-Smtp-Source: AGHT+IGJNRvXMheaYYSlz8koI7fjyKUqOJDPrsq5nBwd12Ueg6+wlFPg6nMTlf7E8hVRQG0iV0eh1Ij+pDV1gkK7Odk=
X-Received: by 2002:a92:ca4a:0:b0:375:bb49:930d with SMTP id
 e9e14a558f8ab-3a2703b9839mr1313935ab.23.1727232824968; Tue, 24 Sep 2024
 19:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-2-howardchu95@gmail.com> <ZrQBbMiIt1NCvxbY@google.com>
 <CAH0uvojQORE2WJziQ4Ru8vsZzr6OLsnn3HOVRkWHW4VFzpKkEg@mail.gmail.com>
In-Reply-To: <CAH0uvojQORE2WJziQ4Ru8vsZzr6OLsnn3HOVRkWHW4VFzpKkEg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Sep 2024 19:53:31 -0700
Message-ID: <CAP-5=fUtcWzGV3n6igzs+eq8dEw2WYsnp8hNeKSUF+6yhZQMcw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] perf evsel: Set BPF output to system-wide
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:58=E2=80=AFPM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello,
>
> The event does open, but bpf_perf_event_output() in BPF will return
> -95(-EOPNOTSUPP), so no output. I think this EOPNOTSUPP is not in
> bpf_trace.c's __bpf_perf_event_output(), but in perf_event's
> perf_event_output() called by BPF.
>
>           <idle>-0       [001] d..4. 154921.079230: bpf_trace_printk: err=
 -95
>
> This is also a bug in perf trace -p <PID>.
>
> Thanks,
> Howard
>
> On Thu, Aug 8, 2024 at 7:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > On Wed, Aug 07, 2024 at 11:38:35PM +0800, Howard Chu wrote:
> > > pid =3D -1 for bpf-output event.
> > >
> > > This makes perf record -p <PID> --off-cpu work. Otherwise bpf-output
> > > cannot be collected.
> >
> > I don't understand why it's necessary.  Why isn't it collected?
> > Is it the kernel to reject the BPF output event to open?
> >
> > Thanks,
> > Namhyung
> >
> > >
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > ---
> > >  tools/perf/util/evsel.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index bc603193c477..b961467133cf 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2282,6 +2282,10 @@ static int evsel__open_cpu(struct evsel *evsel=
, struct perf_cpu_map *cpus,
> > >
> > >                       test_attr__ready();
> > >
> > > +                     /* BPF output event can only be system-wide */
> > > +                     if (evsel__is_bpf_output(evsel))
> > > +                             pid =3D -1;

This matches with libbpf:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/bpf/libbpf.c#n11967

Thanks,
Ian

> > > +
> > >                       /* Debug message used by test scripts */
> > >                       pr_debug2_peo("sys_perf_event_open: pid %d  cpu=
 %d  group_fd %d  flags %#lx",
> > >                               pid, perf_cpu_map__cpu(cpus, idx).cpu, =
group_fd, evsel->open_flags);
> > > --
> > > 2.45.2
> > >

