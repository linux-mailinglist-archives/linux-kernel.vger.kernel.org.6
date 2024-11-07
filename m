Return-Path: <linux-kernel+bounces-400222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE39C0A91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A41B22C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A0C2144CD;
	Thu,  7 Nov 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8zVS9q5"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638F21502E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995056; cv=none; b=nEUd7tbXp1Z/2ZrKm5vPfXvW7xK1l0bYO3yXoeeHc4LadeJL77TchdRgqMu/wYPIbvi8wKbD/AyO4r3tX0IGn4Y6ZZ1/jlR6MaYfW0kmkAty9smCcG8WYRl36LBxDwigq3wrPE87j6Kng7MsthqBxrptmcPltB1TXvF1NNnTb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995056; c=relaxed/simple;
	bh=dkho66LvqDZBbZAtS2Bh1yyXAiAU3nt7Z/Ca6INmHfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N66QOw7kRFfk7U9MZGr8vyPsbbdStZXQf71sCnk/pMvERwCKUMRK6A5Pe5gYoHUPvhHvhbIpbq+ch9Pe/EC5SbQFX9RvNstNbJ0H0hQeNGKGd6cQq9c7n3/quVHzdhpKseSuRsG+oSsG9Dm5Wwl9DsDeR0x0qgO4opc36tyW1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8zVS9q5; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4608dddaa35so363541cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730995053; x=1731599853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+7ho61/oAoiWQbCyZG6AJoc8iLMZGuZ9+96uL2SaXc=;
        b=r8zVS9q5gHrNbDktJcNrGrCqjiNGPjXAVNPYPINKICUp9P0hewoH2L4ICLjHkdM69r
         TAA/tDCvrWodu6H9Bri0vqa9b7zQEQEOMr+TGn+P65LwxYamkTnv+xvFuEyqTNqyuvVV
         TXz2cPwxd4m0LsrxSfs5nievL+1DTFsDrukhug+cmdN3cv7Cs0A+3MU9/VhS1KkFQ/8p
         Of7b8rzY/ip6OL/ekMzstz3QDrzlUAcrsRXnkaxYVu/GRcoyydHtxAUYYLtEW3VBo3at
         GQFvm1NXSeHYk5LXg4wfvnBvUrJisJH2w9AdY44muNrzG5o7bNrHq4d8+ZIShIUjqnXN
         pCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995053; x=1731599853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+7ho61/oAoiWQbCyZG6AJoc8iLMZGuZ9+96uL2SaXc=;
        b=B2QFTfoYO8WhQqWpRqy+0AMfbNZDwdj8fvCE8E5zyz5PCn248EQQY1qEehJUMrlAbk
         Xd5efG4AimhF5FzM2Zy5OtDG8mP8rwRkZ6neKdW74NeWVWfPRZV0HnFDZyLMYtYEEuJH
         8EcldcEeU5Xv1Wnn4IivUnjmn/cRDUeYex/D8mhPTHaO8FQobyM3Tq91ZLFqnBapClOM
         Xb6nIKqI1u7waZV9/HVLot1B5u0024HhVl/tHoxXjJUTT1LUY/30TXTeICyQrqafXU37
         7VySUkMf5gfKujBxs+HoBCx6kFZEfPqZMLntKgK8GN7RvSxfC66rSi49zER9fa2ury9C
         gEQg==
X-Forwarded-Encrypted: i=1; AJvYcCXe9gZWLv5AMlp2J4zAZOMutxMnoYRWLxJeQzl313BIGXsTr/ZvRsD9OkhDC4lbgcq2HwcXmDKJuDS7Ekg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJwia/LWFzDpQLofob4Zen0Q6rDRPUKEeKDeoKy0/k/2JWXlb
	/Fp7dDpvASZNzIdpLaaxDhpVJdNBbrR0Zy2FySTqyN85WG6beBviLeQDRcP83v/Hbpc5Wy+IJlX
	kgGr90VNyNNT+rehp+DDlTzxbl8CWX80MQjJ8
X-Gm-Gg: ASbGncsCGPWZMyOltx1tyoMUcfeR44CB+8kwgYzPGRD2Iiez8DS+8kmCW20kHg8rdk6
	RyFGn2YTe6TPl94AiUlwdkNn6q9Q8UPeSv/yoF0bFEYeoDdvkMJvhzaJozY5S4hY=
X-Google-Smtp-Source: AGHT+IHVKHBvB2cCzxWI5DhXsQxE1wxEcC6cL+BUBfk+cOX40yCQNgt2BOrt/ugueoPHNZE5j5DaoRIma6XSWf55aH0=
X-Received: by 2002:a05:622a:4e8f:b0:460:3f4a:40a1 with SMTP id
 d75a77b69052e-462fa5a3211mr4869671cf.13.1730995053179; Thu, 07 Nov 2024
 07:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com> <20241107082807.ipb7xzqvs24tto2e@hippo>
In-Reply-To: <20241107082807.ipb7xzqvs24tto2e@hippo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Nov 2024 07:57:21 -0800
Message-ID: <CAP-5=fXn3GSR88=UVqZ6zxsuv6s+ZBMGY1A0U8D-_oU4sm10kQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Refactor cpuid and metric table lookup code
To: Xu Yang <xu.yang_2@nxp.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ben Zong-You Xie <ben717@andestech.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 1:05=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Hi Ian Rogers,
>
> On Wed, Nov 06, 2024 at 11:15:53PM -0800, Ian Rogers wrote:
> > Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> > lookup:
> > https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.ya=
ng_2@nxp.com/
> > These patches remove a lot of the logic relating CPUIDs to PMUs so
> > that the PMU isn't part of the question when finding a metric table.
> > For time reasons, it doesn't go as far as allowing system metrics
> > without a metric table as a metric table is needed for metrics to
> > refer to other metrics, and the refactoring of that resolution is a
> > hassle.
> >
> > Ian Rogers (7):
> >   perf header: Move is_cpu_online to numa bench
> >   perf header: Refactor get_cpuid to take a CPU for ARM
> >   perf arm64 header: Use cpu argument in get_cpuid
> >   perf header: Avoid transitive PMU includes
> >   perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
> >   perf jevents: Add map_for_cpu
> >   perf pmu: Move pmu_metrics_table__find and remove ARM override
> >
> >  tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
> >  tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
> >  tools/perf/arch/arm64/util/pmu.c         | 20 ------
> >  tools/perf/arch/loongarch/util/header.c  |  4 +-
> >  tools/perf/arch/powerpc/util/header.c    |  4 +-
> >  tools/perf/arch/riscv/util/header.c      |  4 +-
> >  tools/perf/arch/s390/util/header.c       |  6 +-
> >  tools/perf/arch/x86/util/auxtrace.c      |  3 +-
> >  tools/perf/arch/x86/util/header.c        |  5 +-
> >  tools/perf/bench/numa.c                  | 51 +++++++++++++++
>
> Meet error when build perf tool:
>
>   CC      util/levenshtein.o
>   CC      tests/mem.o
>   CC      util/mmap.o
> bench/numa.c: In function =E2=80=98is_cpu_online=E2=80=99:
> bench/numa.c:550:21: error: storage size of =E2=80=98statbuf=E2=80=99 isn=
=E2=80=99t known
>   550 |         struct stat statbuf;
>       |                     ^~~~~~~
> bench/numa.c:554:13: error: implicit declaration of function =E2=80=98sta=
t=E2=80=99; did you mean =E2=80=98strcat=E2=80=99? [-Werror=3Dimplicit-func=
tion-declaration]
>   554 |         if (stat(buf, &statbuf) !=3D 0)
>       |             ^~~~
>       |             strcat
> bench/numa.c:578:13: error: implicit declaration of function =E2=80=98sys=
fs__read_str=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   578 |         if (sysfs__read_str(buf, &str, &strlen) < 0)
>       |             ^~~~~~~~~~~~~~~
> bench/numa.c:550:21: error: unused variable =E2=80=98statbuf=E2=80=99 [-W=
error=3Dunused-variable]
>   550 |         struct stat statbuf;
>       |                     ^~~~~~~
>   CC      tests/cpumap.o
>   CC      tests/stat.o
>
> After remove these errors, my issue is disappeared.

Thanks, I'll fix this in v2. I'll also add your patch to the front for
the sake of backport fixing. If you could provide tags for my changes
it would be appreciated.

Thanks,
Ian

