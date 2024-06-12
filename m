Return-Path: <linux-kernel+bounces-211439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1927E9051A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90AA61F22529
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063B16F260;
	Wed, 12 Jun 2024 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePrY1PSU"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41216C872
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193134; cv=none; b=bMVme2K8aRZ6F0lvYDXltze7jjxaSU9FE2ibkKs5HkLlybxGZGz20nRYrRY30dGOZyMa1mpYVo3M8XlkxAVziwawPXFxf2M1JYXXqMpETUKqf/ZeWVDLjFrjD/gMJ6jPTKhs+xhxFXUYlZOXm20DhZl84ylmY0Gr0xr2nKE6JaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193134; c=relaxed/simple;
	bh=7LD66xSINsodhZwvGnWbhgzSoyQkiGmOvbl8gmj8k74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bkc764Npb9bkk7LjGWxcBF/HFLWXQOr1f9W3vhbNDpcKP56/U5SBSDbF7YL0lhzus5XJq5aMpSTQcqz8gwYV+vf+9WYIX20Dypo6DQ5UiTUIxM2YwRkBJ44N2acSm6gs9ouXrH8ApGWH3OVm8+yHTXJfZ6yR/b2jJ/BuF3sHTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePrY1PSU; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3748a9fa84fso127845ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718193132; x=1718797932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDVeyfDKY20hrMZkPuumvahLgkbZ8XPx+xCcPCGoUlg=;
        b=ePrY1PSULnehCzJdymZiHOBvcxokV7audVCkbGWr43nPF2gU8yNI0se7qGOzyEOjhF
         g5n6YykUyrdBHXE1uCALmuff+3DtgSORUmC/SGZq6yTA77xT2LVnBW/6MuALdgzwnoGV
         PTzXdBnTyvJ8pT50fnz3MXdzmvWhcOw1Js6V45mUC2aLaYBHCYQJwfc3MsJhqa+RQeaN
         x82AA3KALYSRcqBPxPojF+xaNFOc8NNlct+jIJ20L0DS0tmj9pfrZUECLmSjWmBgUtFc
         6PlMoJ/kRFrcT2sGbK72o3ZbnHIPPyyhiEYzhL1SEq8f9fE5uAvfqtecwbfufjcePKCw
         I1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193132; x=1718797932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDVeyfDKY20hrMZkPuumvahLgkbZ8XPx+xCcPCGoUlg=;
        b=YBVHLaDdaqJjnDHfZujmLOS9Pm+k9QOLSTVCOlGuB4N97Q0qbHwJjO7tSmdOniTFza
         uDwEh5uFpk08pHWMEthiJc1JqHY2NSss26wZ2f+uWSrQXZP8IZuBkHEZGtkB4zOfNH+6
         TtYcsOtjKplXOHsTW7+erYZ2CxizBk7/oJrREgH94iKn3Z8pgRySLKUkGD70A76Swl8B
         qxZYt3+9tg0DDpm2I93vQanBd5gD2lCw/hY1mynBPc+8/pWWMHfj1tCFHZa2/SJYeI0+
         3sGw7dHNiHtpM9HUFpo3ydiGLRE4hf+j81LPFLCuTz2/yBavYm3zHd5D5De/ORKNCaxd
         jhmA==
X-Forwarded-Encrypted: i=1; AJvYcCUnXMYDKA1dhH8T7KMy8FjN1RLYrSAdtjRUTHYAFEJiOP9JGmYu3Gc2K2a5Iy+5gxJ8lvjIvyq+EVPOSH+O5ouQKzGi0imZUwTQeCAS
X-Gm-Message-State: AOJu0YxHceXHBawm3RsF+hEyLPH4EtWmPiDOFgRCL2E97wyWnWmT96hx
	d/lv56X9dooiThQeMlKYsETWj0eElwvEhv/lFjxfKYFNiw6N0Mok9XMwpDXeELLCQo5sbqUFldv
	+Tv/pCUMF5UJYwnuYvY3vPHdNHo8tAtw+PUVj
X-Google-Smtp-Source: AGHT+IE89xTmZD7j7eQRxBBnlT8TqLZ55txucZmJnqJJq5kOu47qog8PEr5hK2uyKYXe4HWIQ8krODHQ97o4tQ4XXuM=
X-Received: by 2002:a05:6e02:3f82:b0:374:984c:5c8d with SMTP id
 e9e14a558f8ab-375cb51be3amr3078965ab.16.1718193131991; Wed, 12 Jun 2024
 04:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607065343.695369-1-irogers@google.com> <cc4ac58b-6a0b-1d72-f881-a60b43d5c229@huawei.com>
In-Reply-To: <cc4ac58b-6a0b-1d72-f881-a60b43d5c229@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Jun 2024 04:52:00 -0700
Message-ID: <CAP-5=fWNDkOpnYF=5v1aQkVDrDWsmw+zYX1pjS8hoiYVgZsRGA@mail.gmail.com>
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline cpus
To: Yicong Yang <yangyicong@huawei.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:16=E2=80=AFAM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> Hi Ian,
>
> On 2024/6/7 14:53, Ian Rogers wrote:
> > When PMUs have a cpu map in the 'cpus' or 'cpumask' file, perf will
> > try to open events on those CPUs. ARM doesn't remove offline CPUs
> > meaning taking a CPU offline will cause perf commands to fail unless a
> > CPU map is passed on the command line.
> >
> > More context in:
> > https://lore.kernel.org/lkml/20240603092812.46616-1-yangyicong@huawei.c=
om/
> >
> > Reported-by: Yicong Yang <yangyicong@huawei.com>
> > Closes: https://lore.kernel.org/lkml/20240603092812.46616-2-yangyicong@=
huawei.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Tested worked for this case:
>
> [root@localhost tmp]# echo 0 > /sys/devices/system/cpu/cpu1/online
> [root@localhost tmp]# /home/yang/perf_static stat -e armv8_pmuv3_0/cpu_cy=
cles/ --timeout 100
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for e=
vent (armv8_pmuv3_0/cpu_cycles/).
> /bin/dmesg | grep -i perf may provide additional information.
>
> [root@localhost tmp]# /tmp/perf_Ian stat -e armv8_pmuv3_0/cpu_cycles/ --t=
imeout 100
>
>  Performance counter stats for 'system wide':
>
>           54994604      armv8_pmuv3_0/cpu_cycles/
>
>        0.176079800 seconds time elapsed
>
> So:
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>
> But still wondering why isn't it better to move this into pmu_cpumask() a=
s does in
> the previous patch? Yes currently this is a arm specific issue, but we ca=
nnot handle
> the case if later PMU doesn't update the cpus/cpumask either :)

Thanks Yicong. To the greatest extent possible I'm trying to avoid
unnecessary code during event parsing. On x86 there isn't a PMU that
has the buggy behavior of showing offline CPUs in the cpumask, so
computing the online CPUs and doing the intersection there is pure
overhead. The online CPUs calculation is either going to read a file
or probe via sysconf. The fallback sysconf probing may fail and can't
handle arbitrary holes in the CPU map (like in your example). So I'm
concerned about the overhead of doing this in pmu_cpumask and the
ability for it to break non-ARM platforms. I think the right
conservative thing to do is to just have the buggy cpumask fix for ARM
and work toward fixing the PMU drivers so potentially in the future we
can remove the fix there. Something I'd like to see is greater PMU
driver testing and detecting bugs, like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/pmu.c?h=3Dperf-tools-next#n285

Thanks,
Ian

> > ---
> >  tools/perf/arch/arm/util/pmu.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/=
pmu.c
> > index 8b7cb68ba1a8..6b544edbd3f6 100644
> > --- a/tools/perf/arch/arm/util/pmu.c
> > +++ b/tools/perf/arch/arm/util/pmu.c
> > @@ -11,12 +11,15 @@
> >
> >  #include "arm-spe.h"
> >  #include "hisi-ptt.h"
> > +#include "../../../util/cpumap.h"
> >  #include "../../../util/pmu.h"
> >  #include "../../../util/cs-etm.h"
> >  #include "../../arm64/util/mem-events.h"
> >
> > -void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> > +void perf_pmu__arch_init(struct perf_pmu *pmu)
> >  {
> > +     struct perf_cpu_map *intersect;
> > +
> >  #ifdef HAVE_AUXTRACE_SUPPORT
> >       if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
> >               /* add ETM default config here */
> > @@ -33,6 +36,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe=
_unused)
> >               pmu->selectable =3D true;
> >  #endif
> >       }
> > -
> >  #endif
> > +     /* Workaround some ARM PMU's failing to correctly set CPU maps fo=
r online processors. */
> > +     intersect =3D perf_cpu_map__intersect(cpu_map__online(), pmu->cpu=
s);
> > +     perf_cpu_map__put(pmu->cpus);
> > +     pmu->cpus =3D intersect;
> >  }
> >

