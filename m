Return-Path: <linux-kernel+bounces-181337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99C8C7AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33701F21947
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A979D0;
	Thu, 16 May 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2eidObp"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2F4A3D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878043; cv=none; b=eFGsa9IRPWZxgJcpNqW12jlsnY6+hilyZ1PtKYYxjZGsM3dea0Sz96fBim1BOSnfuFVzsDF7aWSsa6nNIdamEXeUwF9lWdLJb5Krtdz1Z1LKlkaICx8nQoAeGL+DNiQ47f45kBlqFQNZCtKL4mhw84iXroh+rRPBOYmIYHgL9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878043; c=relaxed/simple;
	bh=S48554Y+x9qw+f50PylKDzjC0r83xfnteAkQWTUhdpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSibM+CDfkMEOmgZ4z5FdTTVa7oNvt3sh7EPVmvDsfVqGzuYh4hWwTFD4DckS0exUxROsfLLjpz4UfKXbaaopBBvGL4DCLupesxU5GsGxbsLCWCweakJ3GwA1n2aX/NJhnd3lSuTp1hhZBqq/T2ogbJOZmJIbYTlpTsdzwXxqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2eidObp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec76185c0fso2155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715878040; x=1716482840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFEJ/AR8pzNNotMkKubv8JaMk08b8Pi6V4aOhZOXlNM=;
        b=t2eidObpIbvji6ZTVepDg4Fm9nvAwxDCGE2p76QTOMlHPfHFqYiCNGyO+Mr4uID75q
         uJmbfTZHwrvemN9HxcQqjHynZc8h7+PFeHWv0vIJgNybsmbLz+arei4PINWVaNMkH3go
         Gq+ZAvQT5JbhBYWrEtPXhuQxVrfZo9i90jcMm0u6uMA+Fd+ZQLDknfkbsfMdayAueHea
         2fiv1H2fvyojLMQ110zdSreQFBzzSw49gOjshS14YG6BtNJ4Zdx4fgBSYEF4c7njbPtv
         rXUfoul9xpzJkMyePnlWTgtiyB0FulVXCKYPjqwwDBzI+xX1ELYYQzENmlRDe9L8SB40
         eBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715878040; x=1716482840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFEJ/AR8pzNNotMkKubv8JaMk08b8Pi6V4aOhZOXlNM=;
        b=LcLQMjkIdwFY6E4vkr4b1UnO+2H6lbghJGc/eUCT7pcUGJ7fCQ/81uZv46xS2s2WsW
         de74fBTXWynsjyFuyXATbpK52UbDboNb3fVBHVlKUddxxDpg4jUDejmKxiXY4rAJGs8Y
         k6kWW7qJO+C02r6aH79VEh9CDZ2+CrScO0Y9DCxm+PBgoDa4BzWUkSZfwKf+KeWx12AU
         AE2mXp2itQzDTfbMVwbRl2qK98Pi85EDn3WD3ckZZjb2BDJBfrrEoAcuwvi4lpPrEEWd
         3FGB6G7luEFCW1rzb0+8nIPEndWeqlNFummvzbX6qNYfitglBmJN9CJ1bN4EHEwtwaKX
         9AKg==
X-Forwarded-Encrypted: i=1; AJvYcCXfR23mcUPZ4TvH2ioHyKOnlRZYYedeLiyj7cpdF/XOfsRwlDJwoXnP5jDNmgtYYUilXU6SZE5+MD6MI5K4s8BEKemAK3I6YPmLD7BY
X-Gm-Message-State: AOJu0Yx4JDS+0Zm6jiQ/rhQdaxzHxPIG5vw3Y5ZtYvGxcsCNUkjrkxzS
	KWIDG/EPprE8Aw7ryEXAUqGvR2c+4f8geDSiXHDh8pUQeb1APBtU6enxIPxeUXZ+7BYfrlluylQ
	eblY9n1Dro0S7JyC/hELAJExkTljNOIP+8i0Y
X-Google-Smtp-Source: AGHT+IFBic9+UPmjG4SdJi5jE45J66ZqwBAVXDHZ3nTQLUNWjZo5jDH79YE3Zcgf2fBd6/uNZXXmfb6q6fhH1dt/sAk=
X-Received: by 2002:a17:902:d590:b0:1f0:9738:d52e with SMTP id
 d9443c01a7336-1f09738d7a9mr3599535ad.2.1715878039953; Thu, 16 May 2024
 09:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-6-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-6-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:47:01 -0700
Message-ID: <CAP-5=fVjpGKbQjadD0Wz11fw3OvkdTkj+YVgkgzNojnR4EpHiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 5/7] perf stat: Add retire latency print functions
 to print out at the very end of print out
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add print out functions so that users could read retire latency values.
>
> Example output:
>
>  Performance counter stats for 'system wide':
>
>             25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %  tm=
a_split_stores
>         28,365,080      CPU_CLK_UNHALTED.THREAD
>              24.00      MEM_INST_RETIRED.SPLIT_STORES:R  #       96      =
  4
>
>        2.054365083 seconds time elapsed
>
> This output of retire latency data is in format:
>  <val> <event-name:R> # <sum> <count>.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

My usual complaint that I hate the stat-display spaghetti code. We
keep putting more spaghetti on the plate and this change does this
too. In the evsel approach:
https://lore.kernel.org/lkml/20240428053616.1125891-1-irogers@google.com/
retirement latency events just update the counts for the event and so
we don't need to special case tpebs events like this. I'd prefer we
went that route. My reviewed-by no longer stands.

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 69 ++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index bfc1d705f437..b9c3978cc99c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -21,6 +21,7 @@
>  #include "iostat.h"
>  #include "pmu.h"
>  #include "pmus.h"
> +#include "intel-tpebs.h"
>
>  #define CNTR_NOT_SUPPORTED     "<not supported>"
>  #define CNTR_NOT_COUNTED       "<not counted>"
> @@ -34,6 +35,7 @@
>  #define COMM_LEN     16
>  #define PID_LEN       7
>  #define CPUS_LEN      4
> +#define RETIRE_LEN    8
>
>  static int aggr_header_lens[] =3D {
>         [AGGR_CORE]     =3D 18,
> @@ -426,6 +428,71 @@ static void print_metric_std(struct perf_stat_config=
 *config,
>         fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
>  }
>
> +static void print_retire_lat_std(struct perf_stat_config *config,
> +                                struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       bool newline =3D os->newline;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               if (newline)
> +                       do_new_line_std(config, os);
> +               fprintf(out, "%'*.2f ", COUNTS_LEN, t->val);
> +               /* For print alignment */
> +               fprintf(out, "%-*s ", config->unit_width, "");
> +               fprintf(out, "%-*s", EVNAME_LEN, t->tpebs_name);
> +               fprintf(out, " # ");
> +               fprintf(out, "%*d %*ld\n", RETIRE_LEN, t->sum,
> +                        RETIRE_LEN, t->count);
> +       }
> +}
> +
> +static void print_retire_lat_csv(struct perf_stat_config *config,
> +                                struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +       const char *sep =3D config->csv_sep;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep, t->=
tpebs_name, sep,
> +                       t->count, sep, t->sum);
> +       }
> +}
> +
> +static void print_retire_lat_json(struct perf_stat_config *config,
> +                                 struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +
> +       fprintf(out, "{");
> +       list_for_each_entry(t, retire_lats, nd) {
> +               fprintf(out, "\"retire_latency-value\" : \"%f\", ", t->va=
l);
> +               fprintf(out, "\"name\" : \"%s\"", t->tpebs_name);
> +               fprintf(out, "\"sample-counts\" : \"%ld\"", t->count);
> +               fprintf(out, "\"retire_latency-sum\" : \"%d\"", t->sum);
> +       }
> +       fprintf(out, "}");
> +}
> +
> +static void print_retire_lat(struct perf_stat_config *config,
> +                            struct outstate *os)
> +{
> +       if (!&config->tpebs_results)
> +               return;
> +       if (config->json_output)
> +               print_retire_lat_json(config, os);
> +       else if (config->csv_output)
> +               print_retire_lat_csv(config, os);
> +       else
> +               print_retire_lat_std(config, os);
> +}
> +
>  static void new_line_csv(struct perf_stat_config *config, void *ctx)
>  {
>         struct outstate *os =3D ctx;
> @@ -1609,6 +1676,8 @@ void evlist__print_counters(struct evlist *evlist, =
struct perf_stat_config *conf
>                 break;
>         }
>
> +       print_retire_lat(config, &os);
> +
>         print_footer(config);
>
>         fflush(config->output);
> --
> 2.43.0
>

