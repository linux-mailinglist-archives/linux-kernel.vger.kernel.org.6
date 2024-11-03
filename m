Return-Path: <linux-kernel+bounces-393687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8833E9BA404
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6331C21070
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E779320B;
	Sun,  3 Nov 2024 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3DvIwoD"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828470812
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609972; cv=none; b=VS9WjKbZGX1J2XaQrGCHVSMKm+dcpCOPR3tDkZ4XyBATeC791PMNncj7JTyTgcWKo3IW6RwGG1au7je4g6SqMQk6/Bn8A6lI+30OmxuXWYQnATJBB8FT/FCthPTTrXnHDo1zMLrnyabgPF3XaFBr87yuEe7nwasU1r3urtlGyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609972; c=relaxed/simple;
	bh=CVRfBxqyVboxDlXOvDCdkmeqxkb0nfVb9iagkfDWGZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sExB1BV+kSr61RY8ECRhuLMXYAUGs0wX+TBlBJYfaSX33hlztNMJ82ecABaG6AIxoGdsMFyEBiOVji6Vwbltsz1RnY5m/8RhPNO5QIfEywfQ7dXa4TuLd5cvLmo/QQNlwpvr3hSgd61L/Y813AXt1iF+vUpHhZZg+MBzakANKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3DvIwoD; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso366015ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 21:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730609970; x=1731214770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A9sz3MB+zVbjeZOy9mWAXJ1yDGla5ge8ekzfLCZ0e4=;
        b=h3DvIwoDIGqi3IBmwDNl4x0mKnVS/q0maCH5zo6jLqq7U2hnSW/x27Byh/59RuIzDc
         Pk2z3AIRsgyh5NQU6qbHE//4g6pc6egcXnVKCI3CA3c0BugALJ7OSB9GW2oNNcewbNct
         aZNVOJyhReCifU2hbeMdTfHXKbmAU9Nx8mzG10yTfD/6cb0HovJocBULDQPuAj6snE6G
         5xzT+ed4gW2ifYofNWyYM+/JOQj/MnKy/GFod+QSj6ocw1As/0KHAM+iVv3ya90P/Uv0
         qsT1+8ZdUjtPFHdxgUX39AgepqWBrv2NZpSGuOrG4xBXcXIxTipRtYJKXV9s+9LdqzWS
         RcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730609970; x=1731214770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A9sz3MB+zVbjeZOy9mWAXJ1yDGla5ge8ekzfLCZ0e4=;
        b=VDhhOF5XJiyQ7jPedUPF2cJKto0905MWsBsLSCabhA8W9l4qFJLbX8clGgzOIkBQjg
         VmpJ3SUtIajzxyBR4U3azuyJOmHUbhaVQBdcqo745FCDjaY/1HPj2jcvgdpiXL2JOPic
         OR5D7u6giQE4nm0HJaxBPyNR9WAZuMZDypEUmRakHnoxpqRIEM7A7LoNqzn5gZnc6XQd
         auGAY+VE/qUus6J5+ic6Qgm2+t/Orz1WvtTb7ZYLIr4gyDKHwq1jRWlcOTlYactv6BHp
         1i7/mcBDA3CRpRZH16vS1/0fdNo/0jM6rAEVpn94/H7RZJB8r++W6qvWI343dX9qxJa+
         pNAg==
X-Forwarded-Encrypted: i=1; AJvYcCXXhDlrLMs2lgoMHcYYwmbMq7kyVh6n7wJFWnprVRZddrX50ykH2WUSsQuZJktLsN4Y5bRAabb0SOFhZgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBL0GgAr/NgpH7mqMLkmOOmVh+MVjl3m3acGIDuEREEi5b+Va3
	kJ+GH2pK7P1h19o/Uswrf0A7oCKFmDNihwD3OG4ku/P45q8Oq1f1/q2Eu8xUcIo/MiqQaAB5nDt
	UROW0fhZhBlpvG/24Y+/hE64Cc/1PXM5J2Ld/
X-Gm-Gg: ASbGncuy+x2cvgoVi6YnCoDFMTx2nlrpuBjbXQCPSjHKdkJfB3NeJ5C0Lt/mPnVp5B1
	yt4grD7gG6oQteND7M46JuB/hfnM/BL/W
X-Google-Smtp-Source: AGHT+IFNAoSxkRhIGQStGyhrMj2HwETDDsgRcV7KeIqZb9YSfrd8l85BJE4VDOmORtTAjNipWvlZ8MW6X80ezvT2sC8=
X-Received: by 2002:a05:6e02:1d1c:b0:39f:83dd:5672 with SMTP id
 e9e14a558f8ab-3a6bdd00d23mr3152865ab.16.1730609970366; Sat, 02 Nov 2024
 21:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102231702.2262258-1-namhyung@kernel.org>
In-Reply-To: <20241102231702.2262258-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 2 Nov 2024 21:59:18 -0700
Message-ID: <CAP-5=fXVAVJD_KZb6wqnisO+cdnwQtz5JHvUULrXhynVGsVJHQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix ftrace test with regex patterns
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 4:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> During the parallel testing, I've noticed some ftrace test failures.  It
> seems the regex pattern checks 100 msec of nanosleep with the error
> range of 10 msec.  But sometimes it's affected by other processes and
> resulted in more time in the syscall.
>
> The following output shows that it took more than 120 msec and failed.
> Let's update the regex pattern so that it can allow more drifts.
>
>   perf ftrace profile test
>   # Total (us)   Avg (us)   Max (us)      Count   Function
>     121279.500 121279.500 121279.500          1   __x64_sys_clock_nanosle=
ep
>     121278.400 121278.400 121278.400          1   common_nsleep
>     121277.800 121277.800 121277.800          1   hrtimer_nanosleep
>     121277.100 121277.100 121277.100          1   do_nanosleep
>     341760.289  56960.048 121273.400          6   schedule
>        176.200     25.171     31.616          7   scheduler_tick
>          0.923      0.923      0.923          1   native_smp_send_resched=
ule
>     345522.360  69104.472 345320.600          5   __x64_sys_execve
>     345486.585  69097.317 345312.700          5   do_execveat_common.isra=
.0
>     340730.300 340730.300 340730.300          1   bprm_execve
>          1.758      0.879      0.883          2   sched_mm_cid_before_exe=
cve
>          1.112      1.112      1.112          1   sched_mm_cid_after_exec=
ve
>   ---- end(-1) ----
>    81: perf ftrace tests                                               : =
FAILED!
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/ftrace.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ft=
race.sh
> index a6ee740f0d7eca07..11010711efa193b3 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -72,7 +72,7 @@ test_ftrace_profile() {
>      grep sleep "${output}"
>      grep schedule "${output}"
>      grep execve "${output}"
> -    time_re=3D"[[:space:]]+10[[:digit:]]{4}\.[[:digit:]]{3}"
> +    time_re=3D"[[:space:]]+1[[:digit:]]{5}\.[[:digit:]]{3}"
>      # 100283.000 100283.000 100283.000          1   __x64_sys_clock_nano=
sleep
>      # Check for one *clock_nanosleep line with a Count of just 1 that ta=
kes a bit more than 0.1 seconds
>      # Strip the _x64_sys part to work with other architectures
> --
> 2.47.0.163.g1226f6d8fa-goog
>

