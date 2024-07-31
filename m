Return-Path: <linux-kernel+bounces-269522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497599433C3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87071F25D27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ADA1BBBF4;
	Wed, 31 Jul 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fahv2gaa"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C41773A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441537; cv=none; b=WrqLj9XfI8e2bHeeqVI9e93mZpLxvINf2lmYImc/uQmtu0YsRbytgNiXAfsrN79uCSi4DC+MeXC40QTpLzxEgKasLPGBziUjEX3qSDODXElOpR0Y+PbOJ+nxENzXQ0f995lc5gs3X4AODyPCQBUf+A4I2I7ZgVMqK5Kv4ccMutU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441537; c=relaxed/simple;
	bh=HMYEQltRZ8Tw+WKokvRCPrxZb0HKX0yrf0ddXvi96Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir3cOCXINxjeQutqsG/7r5idnSGvDnK7x9Pcz45qk3yzUZW0hAH7Aci2dNSCr+Vx+ayXyx40XSzO4cOy0L+EG34tXCAbimVHfQnYUoR8DhscXebyUoyZAJbpf+58iikdFVRDYJ3IY2CBgzBfzT/Ny1tegAAYZ5ZCZwVgoTSyZf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fahv2gaa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd7509397bso203325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722441535; x=1723046335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAhdp5zpySe0+FB5jDx9UjZEWAHh/7EBv/tXoOqBR90=;
        b=Fahv2gaaNSqNOzJfF0+Fl8SJQFS0sWpNlYUU+euX8+BlPidPVPRcRxUb0VuN2Tll9K
         3g0N7Pm9Scqd6O25E9dDXNWw+z7SR61+sBCkua43S0XYu1odwcnMpc+5oUB3QGfUj1Li
         CB6dYAE5Ji4c/7Fegv5BnZV1IOZ6xu496vS/6IZ7KiFaNlVCxvcT2K1C5RjlGenbpF1H
         hGdWTKvY53h3m1JERktMNc4TxRubF9H8Qklx1hrKK5c2KN3lTbFijzvytZ6vm5zjuIad
         78vUTd5LiS25FF9QS3YAKckQDQr1tyL/PHdE7rfpsr6QTeVGALE0BLE7yVUhaMjrblBK
         txoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441535; x=1723046335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAhdp5zpySe0+FB5jDx9UjZEWAHh/7EBv/tXoOqBR90=;
        b=nfASerxhpeD/Zh0EcQlYpE7x18TUsE6P9xGXFIM0mes2mAA0uL3a4cC/QW30t+Kix2
         UGTc22tCbXBdXU+qMAU/nDZ+8q45p3mlABHnXCQ16iA1VZ/lEZUDvPOis7mk3vnRpqdF
         N40wth8bheAVr9tXyaZP2KNN4is22TfhUi7QRxKOryJfjkcQwBoe0ZJp5IF5B2Ib5Fq0
         6AsChDbihumzjwvRjuYna4IFloyLluJhIyZcQxEjlnyI/Tih4TJ2DeztGsVzq9KFNYj/
         bwVjUe+IWDJIBhAQmwsmBE/Uw0cRinP6qObuZBozKuHU0o/9WwztfQZgjlZQwVo40lPA
         tj/w==
X-Forwarded-Encrypted: i=1; AJvYcCXeIOkL2txjRrvqXkugcS8lRHm4t8YPLJr27bdMay1kKHV5F9zuzSj0gg8GgPuRKqtZsvQ6rmnAvdp0fES05K07osxZpQsaz+vkMjaq
X-Gm-Message-State: AOJu0YyI2qLI8WegH0hoMsnJdj80BMqWQDRWmydoVDpicMZ6UGBMWKXl
	bqvHt+QsAfJhUKNMEnCYOcD59CHzl6TTMyuBn9AMQ41do/fjA/EWixM6XEQmxvH8E3pFoPEHRuP
	gIJMPzAoru8vBJgDdsIk2xEchQcq83u4iuR4/
X-Google-Smtp-Source: AGHT+IGMppatA2gCc9t440JBtXjRkJbktHUaH/U7LYdlrJiclQaIDtvsOz+rN1EUSUYMsorHuenPRwk2uXi43KbY4ts=
X-Received: by 2002:a17:903:120d:b0:1f7:1c96:d2e8 with SMTP id
 d9443c01a7336-1ff417d4905mr3381625ad.10.1722441534719; Wed, 31 Jul 2024
 08:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191744.3097329-1-irogers@google.com> <20240730191744.3097329-3-irogers@google.com>
 <Zqo5vVdrkhL5NHJK@x1> <CAP-5=fXyOfPya+TrKVaFhCK3rNY=AuLZLG67ith5YHf_XXVdNg@mail.gmail.com>
 <ZqpZWywTe2j3U9Pl@x1> <ZqpcRIzzBb5KC6Zb@x1>
In-Reply-To: <ZqpcRIzzBb5KC6Zb@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 08:58:43 -0700
Message-ID: <CAP-5=fVm5FkLDOLk4cbD9K6VPZ088f3Yk3bG8LT79E_OLLN4Lw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:46=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 12:33:50PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Jul 31, 2024 at 07:08:18AM -0700, Ian Rogers wrote:
> > > On Wed, Jul 31, 2024 at 6:18=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 30, 2024 at 12:17:44PM -0700, Ian Rogers wrote:
> > > > > empty-pmu-events.c exists so that builds may occur without python
> > > > > being installed on a system. Manually updating empty-pmu-events.c=
 to
> > > > > be in sync with jevents.py is a pain, let's use jevents.py to gen=
erate
> > > > > empty-pmu-events.c.
> > > >
> > > > What am I missing here?
> > > >
> > > > If it exists so that we can build on a system without python how ca=
n we
> > > > use python to generate it?
> > > >
> > > > Now having python in the system is a requirement and thus we don't =
need
> > > > empty-pmu-events.c anymore?
> > > >
> > > > Can you guys please clarify that?
> > >
> > > The requirement for python hasn't changed.
> > >
> > > Case 1: no python or NO_JEVENTS=3D1
> > > Build happens using empty-pmu-events.c that is checked in, no python
> > > is required.
> > >
> > > Case 2: python
> > > pmu-events.c is created by jevents.py (requiring python) and then bui=
lt.
> > > This change adds a step where the empty-pmu-events.c is created using
> > > jevents.py and that file is diffed against the checked in version.
> > > This stops the checked in empty-pmu-events.c diverging if changes are
> > > made to jevents.py. If the diff causes the build to fail then you jus=
t
> > > copy the diff empty-pmu-events.c over the checked in one.
> >
> > I'll try and add your explanation to the log message, thanks for
> > clarifying it!
>
> So, with it in place I'm now noticing:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PW=
D)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> =E2=AC=A2[acme@toolbox perf-tools-next]$ alias m=3D'rm -rf ~/libexec/perf=
-core/ ; make -k CORESIGHT=3D1 O=3D/tmp/build/$(basename $PWD)/ -C tools/pe=
rf install-bin && perf test python'
> =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> <SNIP>
>   GEN     /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
>   MKDIR   /tmp/build/perf-tools-next/arch/x86/util/
>   CC      /tmp/build/perf-tools-next/util/annotate.o
>   CC      /tmp/build/perf-tools-next/arch/x86/util/tsc.o
>   CC      /tmp/build/perf-tools-next/arch/x86/tests/hybrid.o
>   CC      /tmp/build/perf-tools-next/util/block-info.o
>   CC      /tmp/build/perf-tools-next/arch/x86/tests/intel-pt-test.o
>   CC      /tmp/build/perf-tools-next/arch/x86/util/pmu.o
>   MKDIR   /tmp/build/perf-tools-next/ui/browsers/
>   CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
>   CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
>   CC      /tmp/build/perf-tools-next/util/block-range.o
>   TEST    /tmp/build/perf-tools-next/pmu-events/empty-pmu-events.log
> --- pmu-events/empty-pmu-events.c       2024-07-31 12:44:14.355042296 -03=
00
> +++ /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c       2=
024-07-31 12:45:35.048682785 -0300
> @@ -380,7 +380,7 @@
>                          continue;
>
>                  ret =3D pmu_events_table__for_each_event_pmu(table, tabl=
e_pmu, fn, data);
> -                if (pmu || ret)
> +                if (ret)

Right, you need to copy:
 /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
to
tools/perf/pmu-events/empty-pmu-events.c
to fix this.

This change has happened as you are testing with:
https://lore.kernel.org/lkml/20240716132951.1748662-1-kan.liang@linux.intel=
.com/
which isn't in the git repo yet (therefore, I can't make a patch set
on it). The change is WAI as it is telling you empty-pmu-events.c has
become stale and needs Kan's fix applying to it.

Thanks,
Ian


>                          return ret;
>          }
>          return 0;
>   CC      /tmp/build/perf-tools-next/tests/openat-syscall.o
> make[3]: *** [pmu-events/Build:42: /tmp/build/perf-tools-next/pmu-events/=
empty-pmu-events.log] Error 1
> make[3]: *** Deleting file '/tmp/build/perf-tools-next/pmu-events/empty-p=
mu-events.log'
> make[2]: *** [Makefile.perf:763: /tmp/build/perf-tools-next/pmu-events/pm=
u-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf-tools-next/arch/x86/util/kvm-stat.o
> <SNIP>

