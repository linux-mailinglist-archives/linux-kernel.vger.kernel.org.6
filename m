Return-Path: <linux-kernel+bounces-244518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD492A561
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB22283BEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE614263B;
	Mon,  8 Jul 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H56G5tDh"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814178C9D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451321; cv=none; b=M96NdhLqpWh3qAmqLAIJWQqa1bE0duuBrCAi2Iud8aVhdmxQQhXzUdhX5irsxDGBs/iv6mY1//I6hkARHEz9UPzMe23gXbI81FVP9HTA48bmeGDINBQYS8Wn9YtV0cSI3nJ+8iVGLijDbVB1I4blpcShbXnbdMLXF4YYl+MelyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451321; c=relaxed/simple;
	bh=ec9DRnZ6AXHntMvIKjk9tqd+ROrj/W7AUqVrHVmtpL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwTQ3RfntO15w3eVvSDSIc574LVUWTYbPrOWgLPgMjq93dKWUKWHzEYYrKouk/NTRQCizQA0gOIc5iZFV1tobjVYJhVOiYzTBGV9d8M33kIuiJ+J2Eg5fb8XyhPnLm22W0KDAOLLMj0Rdxoa4H+q1UNrXvGmc6IRFPFv7qgZvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H56G5tDh; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-380dacc983eso868875ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720451319; x=1721056119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlR/ZxnAxJSn5Q8IXWJoT32s9sznE6MlqMAy3EMPwdA=;
        b=H56G5tDhpCtPKYKT6xt30hn6La8ke4fdfznTvuPUF/yPm9UyESnhif+XtPuHnsEQIL
         m/k0QlZugnpBJZlGsKwUrLzVUdKzzqWwZu7BasCctz7PttgSsOOzPALwdJL/pEvYVfxR
         VAxrPYxeBQTf4jeQgGw7SnJ29c6VWDu+hwwvtytofA/S4d3xIIQjN8rUMhkn0aHkhiNX
         g45hnDQDTOX7hj6SP2LjQ6xAmwrUVcxo/2ArN06/kgd8iZJnrbE0/A/Jm18AwP5AjMba
         k1tij0H5wCJhW/Iu7lx0q9Kao9BuhWK/54nUrqxvmMQkNx4wvSVoHXi528s+x4acbocg
         nurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451319; x=1721056119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlR/ZxnAxJSn5Q8IXWJoT32s9sznE6MlqMAy3EMPwdA=;
        b=UAeSyZokEk59Ok81jkHrzJdxOpk1aRafty52N/ahZSQs9u+e/8InZVSP2NkXx+DmDy
         OPPs41XFec6+z9yC5qpS7i3lW0TBCCyk7bEFGfQ786lzWv1LlcMc0lu7CBQkX2mwrxWm
         /R2+dELTD2Kl0dDqFmQivJ2b7ko4w5zIKMYzNAmMNQpvKGhD1wDmA2NXeDkBLdPE2n0+
         oNjjn5EL6yLU/3tDPf4RdXuqlO7Ljc/WPHFvy/FdR/l19InipNCytHDojR7rhrqEPidi
         WiRz5ArDnmgFNoN+4G8A2VuSFX18KoXryAKMbhHSzBt0DTvXNl3Me4Z6frWwq9aWvSU5
         +kSw==
X-Forwarded-Encrypted: i=1; AJvYcCVF87cy0g6HrF6YJ4aF4Nl5VQDsglgmi52aWKFSfh4ipDTbZP1uEH+Coq9+NOj4LqFXhbUfrrYwysSN6o5ETHRNsCaRgAFgK2pjikdu
X-Gm-Message-State: AOJu0Ywixmgr4SFrQNkwB2zyx8cgcPAyDmdLuNwXkdiUeGwaHf30dqzd
	OIkkpV5fUWS7QMKHejsyBtsyG9Wm5Rt6Bbtqep8gLaUcP1dZvsKxqofZ+HYFix0+pVQT5D1AXn+
	PbMIthdKlURueGQoSJuwj6PaGLQIltEHLbkCd
X-Google-Smtp-Source: AGHT+IEzzZTS/j4gIIRy4epGbvww/dDzSNB0viSxystMhI0SyTqP23bqtsSRmtrJSmUZwz6t499tlZ7K6BFAoZ9q/6E=
X-Received: by 2002:a92:c24e:0:b0:375:d859:59cf with SMTP id
 e9e14a558f8ab-3834ebc274emr9943265ab.14.1720451318710; Mon, 08 Jul 2024
 08:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com> <20240708144204.839486-4-dapeng1.mi@linux.intel.com>
In-Reply-To: <20240708144204.839486-4-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jul 2024 08:08:26 -0700
Message-ID: <CAP-5=fVPb4JGR3RxfPBGrihrra8bFzdJfFt2iASSs2xHOy=U4g@mail.gmail.com>
Subject: Re: [Patch v2 3/5] perf x86/topdown: Don't move topdown metrics
 events when sorting events
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 12:40=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> when running below perf command, we say error is reported.
>
> perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sleep 1
>
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x400 (slots)
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   disabled                         1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 5
> ------------------------------------------------------------
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x8000 (topdown-retiring)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   freq                             1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
> sys_perf_event_open failed, error -22
>
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for=
 event (topdown-retiring).
>
> The reason of error is that the events are regrouped and
> topdown-retiring event is moved to closely after the slots event and
> topdown-retiring event needs to do the sampling, but Intel PMU driver
> doesn't support to sample topdown metrics events.
>
> For topdown metrics events, it just requires to be in a group which has
> slots event as leader. It doesn't require topdown metrics event must be
> closely after slots event. Thus it's a overkill to move topdown metrics
> event closely after slots event in events regrouping and furtherly cause
> the above issue.
>
> Thus delete the code that moving topdown metrics events to fix the
> issue.

I think this is wrong. The topdown events may not be in a group, such
cases can come from metrics due to grouping constraints, and so they
must be sorted together so that they may be gathered into a group to
avoid the perf event opens failing for ungrouped topdown events. I'm
not understanding what these patches are trying to do, if you want to
prioritize the event for leader sampling why not modify it to compare
first?

Thanks,
Ian

> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index 332e8907f43e..6046981d61cf 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -82,11 +82,6 @@ int arch_evlist__cmp(const struct evsel *lhs, const st=
ruct evsel *rhs)
>                         return -1;
>                 if (arch_is_topdown_slots(rhs))
>                         return 1;
> -               /* Followed by topdown events. */
> -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metr=
ics(rhs))
> -                       return -1;
> -               if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metr=
ics(rhs))
> -                       return 1;
>         }
>
>         /* Default ordering by insertion index. */
> --
> 2.40.1
>

