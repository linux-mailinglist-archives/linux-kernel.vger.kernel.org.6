Return-Path: <linux-kernel+bounces-266288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCCF93FDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EEE283288
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0610617CA1A;
	Mon, 29 Jul 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRzbzYYV"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5456157E6C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278746; cv=none; b=CIHQ1hx+6JNrPYnwd8BxEuW4hO5C3i76CtyMNhVJwd0mClnSH1XfKWH1+/UGtBzlsQalOR1un85rAsPlD3c5cWxS1qWLkwPdrsffFXEDEtRNASMfbGSMqOBJiAgfaWa+fIgI0JkAy/RiSUenp27xRes9EwVUIlIwR777pVma+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278746; c=relaxed/simple;
	bh=yhMZoKMpgSkhDcS0CFUJlLnkR/cq+2BQz16AEvGllsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWR5b1p/LH0ANzbHBfauEZFhXPJLlJoY6bL7cY1Rsfcab9UoNwusqmp2ECiUJ9jPXvSmTixpjRDyMZ0ZuL4J9WKFEZYhply3HSku/hEdxtxoMwb5AFFX4+tag23SmyeLShh0hDNZKJxAOOWjC50nuAXRESXOKruopm/qR3CTc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRzbzYYV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fed726aefcso22115ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722278744; x=1722883544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkKTflLVLlbpVg5QG3fQq0R+V1cEF+vDcwgomBzv0M4=;
        b=DRzbzYYVIr9D91t9nldEIKj2v0XOQDQ11Y8BY4rPAZAuw0Lo8v8jhkHCZaolkk1jRw
         WasBK2+NbP6LHLudYgRUm9spVDW9X/b1o5lWb24XCz1VarcIx6ghrd1BDqqgU3sWeZ35
         xNDDAiLYIUM5ElugDDzLi5vD8spinhHichA7uZgGpfSeBzN9LMMOgQ7jNjnZ44uc9ut3
         Wr+s77reD6CFVTgCHOuNJK5JokN3URrNki5deLT6Tlc+Rsbe0vAeU6Umc2l8hLlrw/Eo
         OpXQ18xaYHjfolplRqRrC0QZ9i0fMlnEpFX9oxcdmVwZVDHIoEHFG9hyGAwwMQbesmgB
         0AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278744; x=1722883544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkKTflLVLlbpVg5QG3fQq0R+V1cEF+vDcwgomBzv0M4=;
        b=erzKDvXvl2fRgzsMfli9hFuc9b/N3wN50PzUdHmySkao4QiHZBFO9xjAOnw28PTMLs
         EJnB8UligvrgmTCahUBCHNWNiaEiVIyt9pX/i03bBUnEzFPo9PVXUO363fb29HIofEus
         jfDpOfkSvdfnZXyR9qJSkvny4QBtsF2NnRsB/B10u30YCYEw8uBG4/D2ktXyLxKF7p98
         jY9u+g1/BnROCT00ubkDm/qHNxl4rY000Y7V+SQq24nlv013RlBjxf6fz6RYwlC9Me3c
         OfvyzTJedVmv0sWMYkCbENannVz+a4bkvQXi/BgBN7EkNAE6qdEvqZFHn6tPIrRn59xM
         h9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPlVaBGhqB5ef1MOdy4x9/gRlXIJ//qijfe9phTTysUCs/i0HifILATl/HsegLj7xVfbFSUeZHwXjYgWsF1b44A8xdyUBAEpChhSB3
X-Gm-Message-State: AOJu0YzngELzzpyIBBXkyMjbgWeQIBAfIEK6rTrOUC06XvSMMg5ddpZU
	33OXtuHS8x7HVSIbEGL99iFp5/9N9VQPHuZtOoNDOsVK9wJPcRs6qvXSySHloFQxIDEPZDrDbDs
	512VCEvzUNtnD2aG8EuT7IUoid3V9AWHyr8yu
X-Google-Smtp-Source: AGHT+IHZEorhI2JheufYETqwCJCum+FQju6o8ub0bKteE/XOlJbrIxbdu7ZbQUbCI0NR5mjvwgK5UgS6B16hFju30qg=
X-Received: by 2002:a17:902:f644:b0:1fb:1006:980f with SMTP id
 d9443c01a7336-1ff34cea480mr980955ad.16.1722278744056; Mon, 29 Jul 2024
 11:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729004127.238611-1-namhyung@kernel.org>
In-Reply-To: <20240729004127.238611-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 11:45:32 -0700
Message-ID: <CAP-5=fUj4FWUvV1xD0aCA=jycBj76RABdWRbH9=5DCZPFHOMwA@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf ftrace: Add 'profile' subcommand (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 5:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This is an attempt to extend perf ftrace command to show a kernel functio=
n
> profile using the function_graph tracer.  This is useful to see detailed
> info like total, average, max time (in usec) and number of calls for each
> function.
>
>   $ sudo perf ftrace profile -- sync | head
>   # Total (us)   Avg (us)   Max (us)      Count   Function
>       7638.372   7638.372   7638.372          1   __do_sys_sync
>       7638.059   7638.059   7638.059          1   ksys_sync
>       5893.959   1964.653   3747.963          3   iterate_supers
>       5214.181    579.353   1688.752          9   schedule
>       3585.773     44.269   3537.329         81   sync_inodes_one_sb
>       3566.179     44.027   3537.078         81   sync_inodes_sb
>       1976.901    247.113   1968.070          8   filemap_fdatawait_keep_=
errors
>       1974.367    246.796   1967.895          8   __filemap_fdatawait_ran=
ge
>       1935.407     37.219   1157.627         52   folio_wait_writeback
>
> While the kernel also provides the similar functionality IIRC under
> CONFIG_FUNCTION_PROFILER, it's often not enabled on disto kernels so I
> implemented it in user space.
>
> Also it can support function filters like 'perf ftrace trace' so users
> can focus on some target functions and change the buffer size if needed.
>
>   $ sudo perf ftrace profile -h
>
>    Usage: perf ftrace [<options>] [<command>]
>       or: perf ftrace [<options>] -- [<command>] [<options>]
>       or: perf ftrace {trace|latency|profile} [<options>] [<command>]
>       or: perf ftrace {trace|latency|profile} [<options>] -- [<command>] =
[<options>]
>
>       -a, --all-cpus        System-wide collection from all CPUs
>       -C, --cpu <cpu>       List of cpus to monitor
>       -G, --graph-funcs <func>
>                             Trace given functions using function_graph tr=
acer
>       -g, --nograph-funcs <func>
>                             Set nograph filter on given functions
>       -m, --buffer-size <size>
>                             Size of per cpu buffer, needs to use a B, K, =
M or G suffix.
>       -N, --notrace-funcs <func>
>                             Do not trace given functions
>       -p, --pid <pid>       Trace on existing process id
>       -s, --sort <key>      Sort result by key: total (default), avg, max=
, count, name.
>       -T, --trace-funcs <func>
>                             Trace given functions using function tracer
>       -v, --verbose         Be more verbose
>           --tid <tid>       Trace on existing thread id (exclusive to --p=
id)
>
>
> The code is also available in 'perf/ftrace-profile-v1' branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung

Lgtm, need to think about (rebase, etc) wrt the libcap change I sent
but otherwise:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung Kim (4):
>   perf ftrace: Add 'tail' option to --graph-opts
>   perf ftrace: Factor out check_ftrace_capable()
>   perf ftrace: Add 'profile' command
>   perf ftrace: Add -s/--sort option to profile sub-command
>
>  tools/perf/Documentation/perf-ftrace.txt |  48 ++-
>  tools/perf/builtin-ftrace.c              | 439 +++++++++++++++++++++--
>  tools/perf/util/ftrace.h                 |   3 +
>  3 files changed, 463 insertions(+), 27 deletions(-)
>
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>

