Return-Path: <linux-kernel+bounces-273076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440F946451
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EECB1F2263D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977F1ABED6;
	Fri,  2 Aug 2024 20:25:41 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4333DF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630341; cv=none; b=CCFbgLN/wRdS8EgCfnWoagzGQ/BYYCU1Dst6c2KH9NLl6Y7YDcMRaR/W4ZoefLBuVlNCzsE31tm8diqyLG5kR7Pr6FtDOSvzuXJkfCpvYogbecevnNPBviRT9zI7ZN953jp/R0e36ashAQ5uCDr9CMnU2ztkumLbCNZQC2Lztsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630341; c=relaxed/simple;
	bh=+w4kIC7pIo4Gr0ZCzJ6euiGf4d6irZhSTcxllngOcnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/m22AqO1r24AJsXaHibSbqnZKmqrtf0G8knfIjbGIj4/roJ23eci2pUnmzZyM+FszlOFLOX04WR/emwVni5w+V5oLu/m5GsrCBNN4AMyC/T0WbTrSFaK96/x3lO1t+pbq6M8Tbc+sG+DeAcWJZ1NPsPjJu2anmhhV9UTHOCD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so6380805a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722630339; x=1723235139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4FYSJVQaMo9sADAucgBelHCdtkbS+soqnokCFgFgKI=;
        b=G/ZVadY5Mmf1yhcv7kZAVCWmS9tjvdd1vMIUo10AVLwUP1VgFPQfHILDt4U5yHNZeH
         97eDlJu9THMHeJcQWa7encEoEAQ/rLawrPwUdnGgQZMEQWjRVX2Y+unL/D+iu/ZU4wnN
         fT0MGOFqPR01WUQdw3MNuGgIERTBadVKkTbYBDhkdouTNyAzckej02RN09H0ndEQ1/kw
         +3YQli8Ib4Bhm6H2yyRGlT7ylTjnPmh5aSBs6n04wsELg6ZdYk4BF9Lm09YjVrXPb2EC
         xwYbVboiO0F8cogwDA05t2N3LgLjEMUDLqLcCOrD3C/VM02ll8VaFraooZEO7bZ9IFX4
         dhoA==
X-Forwarded-Encrypted: i=1; AJvYcCV5hZA9QEx0dno/qJCsDmErfvMADq4xsTq95t+6bFtPdaG1AAMca9IOc3c63sLwj9LwXdLVIfj2fJzjOfymxiJGxpHUzLC82Cdv5yfj
X-Gm-Message-State: AOJu0Yy5x3YlsqLOG29PPKBPVXx+yTLzJgjxXWY+5rzrqzVt8av8xbok
	y19qy5C1TlQ09G78sGmrEEdtnm0rMLWpgRBbFi+xPv6gVaIrqeww/RS8di6l3V+y2XnN0vohPFF
	oHh7wuizxSeTMDO/UgWFGJ0LDNWc=
X-Google-Smtp-Source: AGHT+IFYtSL03Uo4pHtQ29sjzNEnmhmA9sj4hm16yI8d0ld0k148tuK815LC4BJO2P/+dsyPp6XNn73VxjPU2KES+JE=
X-Received: by 2002:a17:90a:bb94:b0:2c9:a151:44fb with SMTP id
 98e67ed59e1d1-2cff94655efmr5842207a91.22.1722630338669; Fri, 02 Aug 2024
 13:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703200356.852727-1-kan.liang@linux.intel.com> <20240703200356.852727-2-kan.liang@linux.intel.com>
In-Reply-To: <20240703200356.852727-2-kan.liang@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 2 Aug 2024 13:25:27 -0700
Message-ID: <CAM9d7cj1hs-Y9RYPEi050hXYRJ-4Y62KvKb1hf_oPfaa+Y3LLg@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf report: Fix --total-cycles --stdio output error
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, adrian.hunter@intel.com, 
	ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:03=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The --total-cycles may output wrong information with the --stdio.
>
> For example,
>   perf record -e "{cycles,instructions}",cache-misses -b sleep 1
>   perf report --total-cycles --stdio
>
> The total cycles output of {cycles,instructions} and cache-misses are
> almost the same.
>
>  # Samples: 938  of events 'anon group { cycles, instructions }'
>  # Event count (approx.): 938
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>  # ...............  ..............  ...........  ..........
>   ..................................................>
>  #
>            11.19%            2.6K        0.10%          21
>                           [perf_iterate_ctx+48 -> >
>             5.79%            1.4K        0.45%          97
>             [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
>             5.11%            1.2K        0.33%          71
>                              [native_write_msr+0 ->>
>
>  # Samples: 293  of event 'cache-misses'
>  # Event count (approx.): 293
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>                                                   [>
>  # ...............  ..............  ...........  ..........
>    ..................................................>
>  #
>            11.19%            2.6K        0.13%          21
>                           [perf_iterate_ctx+48 -> >
>             5.79%            1.4K        0.59%          97
> [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
>             5.11%            1.2K        0.43%          71
>                              [native_write_msr+0 ->>
>
> With the symbol_conf.event_group, the perf report should only report the
> block information of the leader event in a group.
> However, the current implementation retrieves the next event's block
> information, rather than the next group leader's block information.
>
> Make sure the index is updated even if the event is skipped.
>
> With the patch,
>
>  # Samples: 293  of event 'cache-misses'
>  # Event count (approx.): 293
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>                                                   [>
>  # ...............  ..............  ...........  ..........
>    ..................................................>
>  #
>            37.98%            9.0K        4.05%         299
>    [perf_event_addr_filters_exec+0 -> perf_event_a>
>            11.19%            2.6K        0.28%          21
>                           [perf_iterate_ctx+48 -> >
>             5.79%            1.4K        1.32%          97
> [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
>
> Fixes: 6f7164fa231a ("perf report: Sort by sampled cycles percent per blo=
ck for stdio")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-report.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 9718770facb5..b9f22c5321da 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -565,6 +565,7 @@ static int evlist__tty_browse_hists(struct evlist *ev=
list, struct report *rep, c
>                 struct hists *hists =3D evsel__hists(pos);
>                 const char *evname =3D evsel__name(pos);
>
> +               i++;
>                 if (symbol_conf.event_group && !evsel__is_group_leader(po=
s))
>                         continue;
>
> @@ -574,7 +575,7 @@ static int evlist__tty_browse_hists(struct evlist *ev=
list, struct report *rep, c
>                 hists__fprintf_nr_sample_events(hists, rep, evname, stdou=
t);
>
>                 if (rep->total_cycles_mode) {
> -                       report__browse_block_hists(&rep->block_reports[i+=
+].hist,
> +                       report__browse_block_hists(&rep->block_reports[i =
- 1].hist,
>                                                    rep->min_percent, pos,=
 NULL);
>                         continue;
>                 }
> --
> 2.38.1
>

