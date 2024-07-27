Return-Path: <linux-kernel+bounces-263937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9500893DCCE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7032840A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A761FA1;
	Sat, 27 Jul 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgeNMJar"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A691FB5
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722042377; cv=none; b=ALLno/08TMlLQQlKp00s8VhNqqgUwU2scb+O4nMXmCccMuSnahWaFO1qK9cw2TBsS1qU2fw/1PddCJWMlXTqTMj+ks2Y2yy5nl+8CbouelsTR67q5SinSGnWmGlJb6mCqKgvueijmQd9H/3yBZBHJlMBiPzxauqc+otXqd2GaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722042377; c=relaxed/simple;
	bh=gcgp+0VUxL/N6w07L12j6ZfPLZjAO0Qbsll7QHmuZWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzFgS/KoR7WKr5EiAKZBAu0lP7SS/kJ+vLRlXrt1h+joCEjRJ0VAOgmz6/hSqrcA/XR+n//PG4Vs6Kdsg68+HpVVCOg+bgYPq7ztZdEz/YF3ZZ+Pz/3kZ4G4frZ5Mz7kyOQ2/lup26GSlvGjXTAMZ5yp9d3SQHPM/EE9p9gFtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MgeNMJar; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fdc70e695so12161cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722042374; x=1722647174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPINqv4n39FCWR15bg2XF7DRlxlEHS9DD9AsVvk5lFQ=;
        b=MgeNMJarLdW6t8me3HsHl39U5cYyoC1ne3wfSrKQreIhnW2CZLU75mqNG1ewkj6ypU
         YtO727IbCjF4/PdMsNbQuj9ormBb3AEmt69FX5gvcZ55XLvkJahDVYlrmDdyC3SEVWDf
         jX4wDH7by4EkjNQTKVbKA7LOYV5H+q7fo7lQew227HKGjHIlY8ic9870VzsJ2jDrLKLR
         UWalZphD8USYFPaccO5l2aohv9PrwT1Ar6fm0y4xKjZf7RZqQkPRqlgdKkMwgGY54jCa
         fOX/Q7BqgL7jRMYjuFQ+I21Z/nEmmtuGadKk3XC0ImhMoseWJX3tg3qYgOqRTU9DkjxS
         vXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722042374; x=1722647174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPINqv4n39FCWR15bg2XF7DRlxlEHS9DD9AsVvk5lFQ=;
        b=dEZ+WpJIMOCNBL3ePTgIpwByjGPqhlR2JmmGb+zWtaFP6cN+0BgwCM0hKQwujbxChJ
         BLwdqXj8l/aoYt5GHzrm+1JWiFrXEOIq9QUR0U2LXxbKeZPrG9gdG/Ad8K59ewbkWm/e
         dvs6Lork/Pig8OlM7gNv/kY/TMm2j0CChtDPo4eYmyAkW8lAgb9niwvGVfnPHyYqbviv
         4+hsjUo8SJpwgGccFBYBvSe4/ZqliiWGOfmDpRcb7vb3/H/iw6IjqZo4ZYBYaaLNKnTG
         d7miEbCcKTbUEcxTDzlqGGloeIE87KetUPAkWuepbUneOrNbLKW6FR78FGple+bT4+8u
         JSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/k7fv9vNKTC+AEEj3Qn9wjl1G7/xlZo6423TKAwr8IimWncGXm8I6gIx/4OS2rFGBcam9lK3/HzRLbL6rel/eGyhp9gFfH3oLtnOv
X-Gm-Message-State: AOJu0YyDsO1qVSM7El2miCCVa+QEXLNy2X2rT+tEnsg9lqjtBmH9KM5e
	5uh8NoUbaLj3wLipKQCnD4Y1i+n9XioBK09dJcNNT+WTnqN8V4L8QrZfQZhw7aWAXdluMhWTrF3
	lAng7Enw8zMMNm2oToHD0c6JYQaltVGxDaAfppWMnyynq70kRzo96Vw4=
X-Google-Smtp-Source: AGHT+IHZ7xTPjHGWGA1qV8CfGoE4ZEEM9GNsVQ/qYffXSw8ac1Ksfocr2B5Z4jTDnEBMK+X/ZN01DoaJFgn/oJTMvgA=
X-Received: by 2002:a05:622a:1827:b0:447:d225:6e3a with SMTP id
 d75a77b69052e-44ff3a710c8mr5943171cf.4.1722042374372; Fri, 26 Jul 2024
 18:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726102826.787004-1-howardchu95@gmail.com>
In-Reply-To: <20240726102826.787004-1-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jul 2024 18:06:03 -0700
Message-ID: <CAP-5=fWyN7SBfNPHgCqDdPta7XN5jyBm4JuNyS5QkAS9Xz0iCA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Dump off-cpu samples directly
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 3:28=E2=80=AFAM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=3D207323
>
> Currently, off-cpu samples are dumped when perf record is exiting. This
> results in off-cpu samples being after the regular samples. This patch
> series makes possible dumping off-cpu samples on-the-fly, directly into
> perf ring buffer. And it dispatches those samples to the correct format
> for perf.data consumers.
>
> Changes in v3:
>  - Add off-cpu-thresh argument
>  - Process direct off-cpu samples in post
>
> Changes in v2:
>  - Remove unnecessary comments.
>  - Rename function off_cpu_change_type to off_cpu_prepare_parse
>
> Before:
> ```
>      migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  fff=
fffff90d2e8aa record_times+0xa ([kernel.kallsyms])
>             perf  770116 [001] 27981.041375:          1    cycles:P:  fff=
fffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
>             perf  770116 [001] 27981.041377:          1    cycles:P:  fff=
fffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
>             perf  770116 [001] 27981.041379:      51611    cycles:P:  fff=
fffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
>      migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  fff=
fffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
>      migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  fff=
fffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])
>
> sshd  708098 [000] 18446744069.414584:     286392 offcpu-time:
>             79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
>             585690935cca [unknown] (/usr/bin/sshd)
> ```
>
> After:
> ```
>             perf  774767 [003] 28178.033444:        497           cycles:=
P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
>             perf  774767 [003] 28178.033445:     399440           cycles:=
P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
>          swapper       0 [001] 28178.036639:  376650973           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>          swapper       0 [003] 28178.182921:  348779378           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>     blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time-direc=
t:
>             7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
>             7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
>             7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
>             7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
>             7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
>             7fff24e862d8 [unknown] ([unknown])
>
>
>     blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time-direc=
t:
>             7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
>             7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
>             7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-=
2.0.so.0.8000.2)
>             7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.=
0.8000.2)
>             7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
>             7fff24e862d8 [unknown] ([unknown])
>
>
>          swapper       0 [000] 28178.463253:  195945410           cycles:=
P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
>      dbus-broker     412 [002] 28178.464855:  376737008           cycles:=
P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
> ```
>
> Howard Chu (5):
>   perf record off-cpu: Add direct off-cpu event
>   perf record off-cpu: Dumping samples in BPF
>   perf record off-cpu: processing of embedded sample
>   perf record off-cpu: save embedded sample type
>   perf record off-cpu: Add direct off-cpu test

This worked nicely on some tests with me. I'm not sure about
separating offcpu-time and offcpu-time-direct rather than the just 1
event. I also immediately set --off-cpu-thresh=3D1 so maybe milliseconds
should be microseconds, and the default shouldn't be to not use the
direct samples.

Thanks,
Ian

>  tools/perf/builtin-record.c             |   2 +
>  tools/perf/builtin-script.c             |   2 +-
>  tools/perf/tests/builtin-test.c         |   1 +
>  tools/perf/tests/shell/record_offcpu.sh |  29 +++++
>  tools/perf/tests/tests.h                |   1 +
>  tools/perf/tests/workloads/Build        |   1 +
>  tools/perf/tests/workloads/offcpu.c     |  16 +++
>  tools/perf/util/bpf_off_cpu.c           |  53 ++++++++-
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 143 ++++++++++++++++++++++++
>  tools/perf/util/evsel.c                 |  16 ++-
>  tools/perf/util/evsel.h                 |  13 +++
>  tools/perf/util/header.c                |  12 ++
>  tools/perf/util/off_cpu.h               |   1 +
>  tools/perf/util/record.h                |   1 +
>  tools/perf/util/session.c               |  23 +++-
>  15 files changed, 309 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/tests/workloads/offcpu.c
>
> --
> 2.45.2
>

