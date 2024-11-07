Return-Path: <linux-kernel+bounces-400473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175409C0E16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443821C226FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16652101B0;
	Thu,  7 Nov 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrz+FwxY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192D16419
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005532; cv=none; b=iASTGv73OdPjTKSqvfHeOBhTpJD4/L+CQPzyXzhPgAqNhQSvV+kAVgbGjonWX2HNj2ahZIqMfkiX+iLinmsP1rHfi+MGQkj3gXnIXveXWId/0/UaLgAO6RvOljFjgkzPH5SV1MMHbYyMOqXSDDugRs27T3HOxG1pyhPFz0Go3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005532; c=relaxed/simple;
	bh=5waiBhM4WgYuhJy35YT7HAoT0amIFBAEf40b0y5+l1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeg+QYsElG+XlCgsSizMUTB44gzSBmhy4gqf2Ub/IpQRkDHVOzbrsczDACSZAsILvjSCZ3d8WFT9RwIf5sEzg6aN8Ese3d0DEtgFpYhoNn4kF8zqAfbv3Uuwit+4mfohZcipLzYDywSjsV/wMPl0cGq2XyxOKW8+qQwGCluCmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrz+FwxY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8ac50b79so17935ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731005530; x=1731610330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eBN8ymnBc8p9QxnxQVe7atvkFMrTJybu6XE4oODfEs=;
        b=hrz+FwxYGYN82LQZbxjuKZUX8SjvAhdIDbIrCMhFmO362zqqrZEmVp7StxM0l0t3PG
         W3M4Rv7SUc/gXRbAqOaMe8mGPWJ3gl8jdgh0CmaYhQjgfBYvNaN0kBbQc3KXG7gAm5lc
         QPnoux262PhYvhER4WR8NmKDhk0uoMyY+iL+LRnC8SnSTJXMyIX7z4n9WELGleyGTJUJ
         UcTbWFIn4om72ZYsEFKvULEcsJK8FS0/r9dtS0XgS9PTQhGbMJtoCBv00VdW+B3gbWur
         gEAE968x28ebHSxUDYtPNXm2niMUO38jt7r0Os9GY5CFKpjiSIUCQVtUxJAWPpvJU+Yx
         Oqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731005530; x=1731610330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eBN8ymnBc8p9QxnxQVe7atvkFMrTJybu6XE4oODfEs=;
        b=PSRxN3iYrHx7eetOW+xGain20UUGjY3WzEoByi9gbOZTv/SpGjWmUGdTDILMI90hx/
         sy3x9XWo53UrkIkm5hMunKjwz5MEUbOmru2VumYnZiJDzr7LoiIKWUWQlm+xpceATXN7
         IJBxG/P2FmWVU8srF9GReoXRe1f8u9/rUE3HXfxDrMhkZAKa+ajcoYMIQRol74+a1t4m
         ZiemsWzO7VKz0F2WvTqlHyuP1DUXaWAvqRkiswEMjCM3JKMET5WtwUvXVDxoNYieyklA
         jvQRsTQRSjlUA8KMRDLirAiBAiqVLALx5gT7W4m04zS1fbI3f1i2lCP0r4YZu0lF0vfe
         VczQ==
X-Gm-Message-State: AOJu0YyB4h9kKTtEezFOeUmyUEkHVqBvJXohoTHfjQj60aiU17B9e5WW
	79ioVgcTRov/ynpmK1Y5gya0wP4n03FaN6r4lT5YGT8MrViP7VH8rAsWlWyLrt9hyaBZ7flWEOL
	oAugfP/vc99LpLAsJmHTsZh2LRzXHi44JBKSj
X-Gm-Gg: ASbGncugZ+nJaLDtqGv+A3ce86CW9Bf6m6L6MjgnQKgMMlQEm4wkPaOR2PyVZIl3cHF
	u+/EUcVW+sI5L1NQtclv/340P/UDvwvpt0EIkD1QljZu6U1LvGr4EwH4avpwTqaE=
X-Google-Smtp-Source: AGHT+IGvx7KFsyMX5+AYcMaGovXO3S3lUt1B/FRKeJuNVZEWZxKDX6Uv2YyfvW7lg1pESwLCE/Oq1UyOTpc16+leygo=
X-Received: by 2002:a17:903:41ce:b0:205:60ef:18af with SMTP id
 d9443c01a7336-211749d3e94mr3901475ad.29.1731005529781; Thu, 07 Nov 2024
 10:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com>
In-Reply-To: <20241026121758.143259-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Nov 2024 10:51:58 -0800
Message-ID: <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Atish Patra <atishp@rivosinc.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> At the RISC-V summit the topic of avoiding event data being in the
> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> events being the priority when no PMU is provided so that legacy
> events maybe supported via json. Originally Mark Rutland also
> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> M? processors, but James Clark more recently tested this and believes
> the driver issues there may not have existed or have been resolved. In
> any case, it is inconsistent that with a PMU event names avoid legacy
> encodings, but when wildcarding PMUs (ie without a PMU with the event
> name) the legacy encodings have priority.
>
> The patch doing this work was reverted in a v6.10 release candidate
> as, even though the patch was posted for weeks and had been on
> linux-next for weeks without issue, Linus was in the habit of using
> explicit legacy events with unsupported precision options on his
> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> where ARM decided to call the events bus_cycles and cycles, the latter
> being also a legacy event name. ARM haven't renamed the cycles event
> to a more consistent cpu_cycles and avoided the problem. With these
> changes the problematic event will now be skipped, a large warning
> produced, and perf record will continue for the other PMU events. This
> solution was proposed by Arnaldo.
>
> Two minor changes have been added to help with the error message and
> to work around issues occurring with "perf stat metrics (shadow stat)
> test".
>
> The patches have only been tested on my x86 non-hybrid laptop.

Hi Atish and James,

Could I get your tags for this series?

The patches were originally motivated by wanting to make the behavior
of events parsed like "cycles" match that of "cpu/cycles/", the PMU is
wildcarded to "cpu" in the first case. This was divergent because of
ARM we switched from preferring legacy (type =3D PERF_TYPE_HARDWARE,
config =3D PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=3D<core PMU's
type>, config=3D<encoding from event>) when a PMU name was given. This
aligns with RISC-V wanting to use json encodings to avoid complexity
in the PMU driver.

James, could you show the neoverse with the cmn PMU behavior for perf
record of "cycles:pp" due to sensitivities there.

Thanks,
Ian




> Ian Rogers (4):
>   perf evsel: Add pmu_name helper
>   perf stat: Fix find_stat for mixed legacy/non-legacy events
>   perf record: Skip don't fail for events that don't open
>   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>     legacy"
>
>  tools/perf/builtin-record.c    | 22 +++++++---
>  tools/perf/util/evsel.c        | 10 +++++
>  tools/perf/util/evsel.h        |  1 +
>  tools/perf/util/parse-events.c | 26 +++++++++---
>  tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
>  tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
>  tools/perf/util/pmus.c         | 20 +++++++--
>  tools/perf/util/stat-shadow.c  |  3 +-
>  8 files changed, 145 insertions(+), 73 deletions(-)
>
> --
> 2.47.0.163.g1226f6d8fa-goog
>

