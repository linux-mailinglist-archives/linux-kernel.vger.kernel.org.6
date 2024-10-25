Return-Path: <linux-kernel+bounces-380846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0269AF6DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1446B2180C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72674BED;
	Fri, 25 Oct 2024 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysz7CIpE"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8BAD21
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820025; cv=none; b=oKQrUx/xpznberW5cSe04lQHCfK93kVyTQFoK4FgtQ0z0/hRreEP2NyJ/m+jf8P+nnO634VZOEPMgLBnT9nxPWZP7CJs+IKcWrdR2F7KB+CkALxRwbD0ulVTsZxAQZ02LV4Z6XMZ4JCNT99+hm8qnFCW0ODvdilFzAtkGqMhrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820025; c=relaxed/simple;
	bh=yfXRCuTBbO7ILCp0mViWAG2EamNskJK83Pg0+IDCHqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6PLyhV0JqMZnqDZasG/BZH6Qj9d/RMghOAyifUMn4MfIIlMlZBBRjEvq+wjyQtF9IWBClgSIBF+jyFvuq64pNZw+yawcIhvXMd81bATAFklPdU22YNTrvavLIPYTdXnMa7zsj75EbWB9eqzbYKW0mOt+K2HLvNkUnAwKBn+544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysz7CIpE; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso78965ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729820021; x=1730424821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSYBIcr4y82BeOInHq0e4g3hka0K6uwliKC68YXbQzU=;
        b=ysz7CIpEYzsqp6zvMJOXnV3iQRpEmJ1LKL9xvSVUgCLJJSrl/VehYDBDBD7l6HGfMU
         X/0laO5hl1sN81rZ8li7LZe8r889qKrAJibgB852853eN/k06rvXt/9oHxKKEsqKNL2P
         iIDUNqQ3JS1RuK5Sr1cpjmOlUPr0jwbGq/Y/sc4rELOFQ67TcYA96xsAW/E4ZUPv3P/S
         N3TyjuPfpzFaH5Q6Lu2PxKBreSra4dADVbdwgDM3b2SsZ2r6+hiIYtp3qLT9EWAq4dq2
         no3gLJwZniYQ7v5jieaz/D/4ckM8ZOdhxY8GyvbT13FS+HMbZfjq8G/4mJ3A3xxSN4RJ
         YTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729820021; x=1730424821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSYBIcr4y82BeOInHq0e4g3hka0K6uwliKC68YXbQzU=;
        b=reJNwWMHHt4HmBf6qwNjXFHM113ypBOxv38nN7HrwkcJZ+l0MkBr2uf1io4bQ5qYij
         8en0tKS42wSYOOotJcn5AbYUvO0hC5P7Cn1+cotUS+K0GFLqnTNs8dh/vNCoEqXIcwH5
         V2xt8arPlRc3QbDEbrxS1HbCdOxcwCnBo5+Kl1oMRFFY9WNatZ+aTlcK7dLE8ea5WDKf
         wDhQjKExUG7uhL4ONjZnD+fbQI3v8oRvjIVBD5ZmB7RxBl7P9NGE2u8ZcALXKuCSzo3G
         zBRbnQMTx90EED3oE19wC8tHPS6rqPaP/LRDvcrJ+ycoiUN1Sl8sMXfdvdZ4FPmBKi5f
         oILg==
X-Forwarded-Encrypted: i=1; AJvYcCXAic2qPKt5j8xeLkYIeFdR8tDtOxKmE9Lif+rJwg0IWX0Zkaoay/+kWjqGI72uNhLxaO7Iwj1EHYHBTpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zDtiG5ilWeGNDXY+bwrirKPMCngGW7Xxsb++SBS9PRtO0QXT
	xKpD9zh08RtBkoACW1kdS8MlnyDHSkWs3db8i/HJsQzQU0NcGS0YSwjUxvBCactJ14G1qRuvoV5
	InzCGuLCL9xxBokvdaxVmRayhq2shHqdI5O25
X-Google-Smtp-Source: AGHT+IEBuoygHKzTEiQPNh9kYQFxgxLuYiZzba9ROK33E0EsPlHJqXLEPqve3H8ybbhcCPeZHI6oCfQXzqlsk/MKakQ=
X-Received: by 2002:a05:6e02:1c0c:b0:39f:3778:c896 with SMTP id
 e9e14a558f8ab-3a4e5b4f817mr933145ab.5.1729820021072; Thu, 24 Oct 2024
 18:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022180623.463131-1-irogers@google.com> <Zxm5w6wXLxpbERZx@google.com>
 <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com> <Zxp4mbzsFyO5nUh7@google.com>
In-Reply-To: <Zxp4mbzsFyO5nUh7@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Oct 2024 18:33:27 -0700
Message-ID: <CAP-5=fWP-T57-Bb60eixhgO3m7f_v3y-tWmV=ypuR52iNSAQvQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Hwmon PMUs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 24, 2024 at 12:07:46AM -0700, Ian Rogers wrote:
> > On Wed, Oct 23, 2024 at 8:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, Oct 22, 2024 at 11:06:18AM -0700, Ian Rogers wrote:
> > > > Following the convention of the tool PMU, create a hwmon PMU that
> > > > exposes hwmon data for reading. For example, the following shows
> > > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > > frequency:
> > > > ```
> > > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_onl=
ine/ -M UNCORE_FREQ -I 1000
> > > >      1.001153138              52.00 'C   temp_cpu
> > > >      1.001153138              2,588 rpm  fan1
> > > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > > >      1.001153138                  8      tool/num_cpus_online/
> > > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET          =
       #     1.08 UNCORE_FREQ
> > > >      1.001153138      1,012,773,595      duration_time
> > > > ...
> > > > ```
> > > >
> > > > Additional data on the hwmon events is in perf list:
> > > > ```
> > > > $ perf list
> > > > ...
> > > > hwmon:
> > > > ...
> > > >   temp_core_0 OR temp2
> > > >        [Temperature in unit coretemp named Core 0. crit=3D100'C,max=
=3D100'C crit_alarm=3D0'C. Unit:
> > > >         hwmon_coretemp]
> > > > ...
> > > > ```
> > > >
> > > > v6: Add string.h #include for issue reported by kernel test robot.
> > > > v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
> > > > v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
> > > >     the update to perf_pmu to use it. Try to make source of literal
> > > >     strings clearer via named #defines. Fix a number of GCC warning=
s.
> > > > v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
> > > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > > >
> > > > Ian Rogers (5):
> > > >   tools api io: Ensure line_len_out is always initialized
> > > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysf=
s
> > > >   perf pmu: Add calls enabling the hwmon_pmu
> > > >   perf test: Add hwmon "PMU" test
> > > >   perf docs: Document tool and hwmon events
> > >
> > > I think the patch 2 can be easily splitted into core and other parts
> > > like dealing with aliases and units.  I believe it'd be helpful for
> > > others (like me) to understand how it works.
> > >
> > > Please take a look at 'perf/hwmon-pmu' branch in:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf=
.git
> >
> > Thanks Namhyung but I'm not really seeing this making anything simpler
> > and I can see significant new bugs. Your new patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git=
/commit/?h=3Dperf/hwmon-pmu&id=3D85c78b5bf71fb3e67ae815f7b2d044648fa08391
> > Has taken about 40% out of patch 2, but done so by splitting function
> > declarations from their definitions, enum declarations from any use,
>
> Yeah, it's just because I was lazy and you can split header files too
> (and please do so).
>
> > etc. It also adds in code like:
> >
> > snprintf(buf, sizeof(buf), "%s_input", evsel->name);
> >
> > but this would be a strange thing to do. The evsel->name is rewritten
> > by fallback logic, so cycles may become cycles:u if kernel profiling
>
> I know it doesn't work but just want to highlight how it's supposed to
> work.  Eventually what we need is a correct file name.  In fact, I think
> it'd work if we can pass a correct event name probably like:
>
>   perf stat -e hwmon5/name=3Dfan1/ true

But this isn't what the term name and evsel's name are for. They are
to allow you to do:
```
$ perf stat -e cycles/name=3Dfoobar/ true

Performance counter stats for 'true':

        1,126,942      foobar

      0.001681805 seconds time elapsed

      0.001757000 seconds user
      0.000000000 seconds sys
```
Why would you do this in code, change a fundamental of evsel behavior,
then just to delete it in the next patch?

> > is restricted. This is why we have metric-id in the evsel as we cannot
> > rely on the evsel->name not mutating when looking up events for the
> > sake of metrics. Using the name as part of a sysfs filename lookup
> > doesn't make sense to me as now the evsel fallback logic can break a
> > hwmon event. In the original patch the code was:
>
> The fallback logic is used only if the kernel returns an error.  Thus
> it'd be fine as long as it correctly finds the sysfs filename.  But it's
> not used in the final code and the change is a simple one-liner.

But it's not. It's changing what evsel->name means to be an event
encoding. How does reverse config to name lookup work in this model?
How does the normal use of the name term work?

> >
> > snprintf(buf, sizeof(buf), "%s%d_input", hwmon_type_strs[key.type], key=
.num);
> >
> > where those two values are constants and key.type and key.num both
> > values embedded in the config value the evsel fallback logic won't
> > change. But bringing in the code that does that basically brings in
> > all of the rest of patch 2.
>
> Right, that's why I did that way.
>
> >
> > So the patch is adding a PMU that looks broken, so rather than
> > simplifying things it just creates a broken intermediate state and
> > should that be fixed for the benefit of bisects?
>
> Actually it's not broken since it's not enabled yet. :)
>
>
> > It also complicates understanding as the declarations of functions and
> > enums have kernel-doc, but now the definitions of enums and functions
> > are split apart. For me, to understand the code I'd want to squash the
> > patches back together again so I could see a declaration with its
> > definition.
>
> Yep, please move the declarations to the patch 3.

So I think moving the enum declarations into one patch is okay. But as
the enum values have no bearing on hardware constants, or something
outside of the code that uses them it smells strange to me. Ultimately
this is going to do little to the lines of code count but damage
readability. I'm not sure why we're doing this given the kernel model
for adding a driver is to add it as a large chunk. For example, here
is adding the intel PT driver:
https://lore.kernel.org/all/1422614392-114498-1-git-send-email-alexander.sh=
ishkin@linux.intel.com/T/#u

Thanks,
Ian

