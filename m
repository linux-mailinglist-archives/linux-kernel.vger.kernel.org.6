Return-Path: <linux-kernel+bounces-203383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841F38FDA23
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083EE1F24F84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE19160873;
	Wed,  5 Jun 2024 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkXCARdR"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3CBA38
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717628540; cv=none; b=EEB5JMFlT/5J+d70UJITj8AfWFedYpLfcZsv6qfSubXQOjJzfIIOio2LqIgov5qcMpgBkuoz5A/W25lRo2PDz1gAoqyQxOBMRXJXwzpXXWTeuyGeR9sNY1rbByrTCSYJzWETinJVFItXTDiQVEQteYXFZsEo+DiKgzOwQ91qxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717628540; c=relaxed/simple;
	bh=wsdT4camzSvZhUF/B1XynaXHgieSNxYMOgyk9emZdZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQBwPy76pqUcePHLBT2Z0vZTPWNYWzETzMQ8JOqXXnisj5K/0IABCUtlHDhHwbxj6Im15QvJYasmqpRmL8NWq+33+A3UjwElv0AUzXgBgp92wuqlCuSnlq7/yeWLFOv/WHVwf1u4NpFlmcDDoRcYNXSAKkEK3QyvdiWKNMZKTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkXCARdR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4400cc0dad1so165531cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717628538; x=1718233338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slbwnXGSYEmdHJJA8IAz+G2cLcOPOkgj2LIkAFUCzU8=;
        b=mkXCARdR/J37Nnk9rqm47ie9xjo/2nfcFEOOdm2ejuazVtFpk4A/pTpLmqyDMZkCyn
         gj3ujgkRg78V3Qfdq4ac5Jfo43j0aSfZkCSAgRUuhhIOfIMc8ujRPpmIDjh+gandOdtu
         ykorVu1MVwA/XzQEa1Rdzbs1ZvePnf42bDnngPNzCQKgbYxFdBnOYGIc1q/GxZvM8rMB
         am+apXYuhD5MzDrsHAggt8w0Bu5bEQVyfWyVDiEOkZQlIWgPc1xxADjwG12DfnJ5wI+r
         rdj8cl0lq3fbt/uXDET1tRFB7oFhYwOSuQtZGu0lswnZ7F+D8mGY+wTY1JLaNTv6BffU
         WvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717628538; x=1718233338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slbwnXGSYEmdHJJA8IAz+G2cLcOPOkgj2LIkAFUCzU8=;
        b=I7rKf3bc4HYnvATtTLsmzYfaQ2LqVReuJivLSahRFoZadAPk7uK8ztI1msxgb8sD8c
         BlvcZSpm9Tsafhnt3aB2Z43P+Ae5YJUl/fD2q7eK99ZPqcHvAhcTT+KKbASj+AzpIZsN
         M9BGBdyih8+DKDgnM8gGP3mJV0TjapTn5H2aGsy9V2Pkjs7kAA5W26RxGacPd4rlOiI7
         XvmgZwA/55tv5yo5XbFSSPWdFyv1geIIQQ0mae/xMIJn1AYpcNuOI7OZHlLgkjKdUyVK
         p7jmCVjeGo3X3f45OIhOa2cxVV+buAvA5yPFyL76zZSeJEmU9GU+vJW4dhRfP3fRaPrQ
         JG5A==
X-Forwarded-Encrypted: i=1; AJvYcCUbGyaDOGCDHZ0J1VZLOqi6gqrdPXyHSQ27Gh8/D2BSDk4LUpYsvEWTt7JxtrPC1vVgiRuET8bcWcCDBmKMnKC3If4/+wFgpi3TFBkE
X-Gm-Message-State: AOJu0YzkVkDJSDU4FOHv7kHq+10J1QxbBXHdeBRJTWRR4i05WZKWXnzX
	MgFx+oBVXqqNDGk7JU6PesQy8uG0nrJQCJ11k0poDNzG6Alm4RBcv3lRnpWzg01t+wXJc2nNoaZ
	YJ0wDzKDzKYUiXDAMnzPKx1HmQNimZxdRHj8l
X-Google-Smtp-Source: AGHT+IFCS/YPDOUiIjjTysFsomfL3io8s6sNJgh0NFjDqwhPM0cnA5lSgUWfd6sJMTCGUuh9ma+4VRvmMYW933ugA/4=
X-Received: by 2002:a05:622a:1c17:b0:440:173b:b364 with SMTP id
 d75a77b69052e-44037268c57mr1263631cf.16.1717628537357; Wed, 05 Jun 2024
 16:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1> <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com> <Zld3dlJHjFMFG02v@x1>
 <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
 <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
 <aee9254e-81c1-464a-8a28-f971615baffc@arm.com> <CAP-5=fVynt-8cH6Jc5VyfBLBOqkF+v_7kknHdUPZBM1r3WwhTQ@mail.gmail.com>
 <ZlkC_Tm6kKIL3Phc@google.com> <CAM9d7ciTbHngfimDNsXS_adR7xg4ZHvSHzVhAzuQ6o-nQ2nsMQ@mail.gmail.com>
In-Reply-To: <CAM9d7ciTbHngfimDNsXS_adR7xg4ZHvSHzVhAzuQ6o-nQ2nsMQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Jun 2024 16:02:05 -0700
Message-ID: <CAP-5=fUq6jLCtjPNb0gngtR0cXopG+-mJ-+CnEOAXeG7VShh8A@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, May 30, 2024 at 3:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, May 30, 2024 at 06:46:08AM -0700, Ian Rogers wrote:
> > > On Thu, May 30, 2024 at 5:48=E2=80=AFAM James Clark <james.clark@arm.=
com> wrote:
> > > >
> > > > On 30/05/2024 06:35, Namhyung Kim wrote:
> > > > > It might not be a perfect solution but it could be a simple one.
> > > > > Ideally I think it'd be nice if the kernel exports more informati=
on
> > > > > about the PMUs like sampling and exclude capabilities.
> > > > > > Thanks,
> > > > > Namhyung
> > > >
> > > > That seems like a much better suggestion. Especially with the ever
> > > > expanding retry/fallback mechanism that can never really take into
> > > > account every combination of event attributes that can fail.
> > >
> > > I think this approach can work but we may break PMUs.
> > >
> > > Rather than use `is_core` on `struct pmu` we could have say a
> > > `supports_sampling` and we pass to parse_events an option to exclude
> > > any PMU that doesn't have that flag. Now obviously more than just cor=
e
> > > PMUs support sampling. All software PMUs, tracepoints, probes. We hav=
e
> > > an imprecise list of these in perf_pmu__is_software. So we can set
> > > supports_sampling for perf_pmu__is_software and is_core.
> >
> > Yep, we can do that if the kernel provides the info.  But before that
> > I think it's practical to skip uncore PMUs and hope other PMUs don't
> > have event aliases clashing with the legacy names. :)
> >
> > >
> > > I think the problem comes for things like the AMD IBS PMUs, intel_bts
> > > and intel_pt. Often these only support sampling but aren't core. Ther=
e
> > > may be IBM S390 PMUs or other vendor PMUs that are similar. If we can
> > > make a list of all these PMU names then we can use that to set
> > > supports_sampling and not break event parsing for these PMUs.
> > >
> > > The name list sounds somewhat impractical, let's say we lazily comput=
e
> > > the supports_sampling on a PMU. We need the sampling equivalent of
> > > is_event_supported:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/print-events.c?h=3Dperf-tools-next#n242
> > > is_event_supported has had bugs, look at the exclude_guest workaround
> > > for Apple PMUs. It also isn't clear to me how we choose the event
> > > config that we're going to probe to determine whether sampling works.
> > > The perf_event_open may reject the test because of a bad config and
> > > not because sampling isn't supported.
> > >
> > > So I think we can make the approach work if we had either:
> > > 1) a list of PMUs that support sampling,
> > > 2) a reliable "is_sampling_supported" test.
> > >
> > > I'm not sure of the advantages of doing (2) rather than just creating
> > > the set of evsels and ignoring those that fail to open. Ignoring
> > > evsels that fail to open seems more unlikely to break anything as the
> > > user is giving the events/config values for the PMUs they care about.
> >
> > Yep, that's also possible.  I'm ok if you want to go that direction.
>
> Hmm.. I thought about this again.  But it can be a problem if we ignore
> any failures as it can be a real error due to other reason - e.g. not
> supported configuration or other user mistakes.

Right, we have two not good choices:

1) Try to detect whether sampling is supported, but any test doing
this needs to guess at a configuration and we'll need to deflake this
on off platforms like those that don't allow things like exclude
guest.
2) Ignore failures, possibly hiding user errors.

I would prefer for (2) the errors were pr_err rather than pr_debug,
something the user can clean up by getting rid of warned about PMUs.
This will avoid hiding the error, but then on Neoverse cycles will
warn about the arm_dsu PMU's cycles event for exactly Linus' test
case. My understanding is that this is deemed a regression, hence
Arnaldo proposing pr_debug to hide it.

Thanks,
Ian

