Return-Path: <linux-kernel+bounces-259964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0A93A08A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321B21F230FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74815219E;
	Tue, 23 Jul 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n76fygKG"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1427381B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738234; cv=none; b=eIoHYmXrclXkzv2/xiaEPsh1ye9mh6qN0dGfdcAYa6d9/KW9R65NehA2RJScFTEe7s3UOVpIrl/DUNgIEco9wjJ9og/0ntMX6d57AWSD5is4TFdklJ2H7MMuCCtUSf5muA0OwmtnusjDym854Q7T9fCeYsFMRkfzgdJAXgup8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738234; c=relaxed/simple;
	bh=QTQImLo9rFpB1tHfY+kDtBW/jVdWzRo2shcpC9Oegsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFxgoeWg1ZQS9MynvjFCdB/apfkuIRX36vxyNDanzFJCJ0Jc1lroEt4XLaeRR/eahFN3C07OgLc7lvLJB+QSZTZrMiSfWOv9s/IstOvUSydvSBxX4Mkwc7zX08nGf50UUST7lj5S2tELlhn9KfeP/cAtGpMwEjfWy0pQTze6w88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n76fygKG; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7035d5eec5aso2735131a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721738231; x=1722343031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1PK/7EFDuzvwfgAoJnV5Sv6CmA0hzzCT8PA3TVv11TQ=;
        b=n76fygKGFEH7OK5HYp152fHil/DtQXLX7AWKl+oYc0znpOx69XRral59LbuxOKUvxG
         h+q0Om8t2E8wrPNwEprfYTa08olk4LED4xZ+/XK3aVraFFC0pZOhA3e8iyUMol8NDAsB
         P1AQkIreyiHmjbq4qJGeuFcz0lZk0QpEhV6MI1Qbi+tiNd2q3x+n8Fo2o91u0VmbmxNd
         U0pia2iM1stMpSzRE/Ge6rIqAaAPB3aOZ3ODRsHEW4XOUfEOcaFoGfq5SQn4MOFXCM9T
         nEmEu10aUKCxzP3b7cpRakvS6FejYUL5UIoreVjDccptDMwNKnBgG4GE1Qf4wUJ5SGXu
         FgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721738231; x=1722343031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PK/7EFDuzvwfgAoJnV5Sv6CmA0hzzCT8PA3TVv11TQ=;
        b=hOHQZR+XSpy5Tc6EXhgTqn6bpxsT6oG3fmHnQLFSFrmjDpjtbq/qReXbtE1r8C+lLb
         98NSj9gbdpiDBs23E4j0N5Sz33PIRSheAYyX7BL2iL+9DyEESfrEhZuz3U2WX0iqGKlq
         lM6Lr1G2TQ8cUZ7IXFHts9kKOWaizR/mM+uIwiTRLtNOljeF+IUjF4v+wkDV94f+mXsM
         Om5zZ06KqM1sN/bO6s+kfPk4UNxuSV/HfhI40LGfXUIkuSu/vcepRR8Y2IRuNrum+ibF
         L4xbaaWo33b/Ia6pki3l/9fYEs3p53Ud/9sTf7ncE75HOOpl1xuyjfenBdDT9R/JAMzh
         4mRw==
X-Forwarded-Encrypted: i=1; AJvYcCViBWboxqufRhWf1QWS9/1Iug0Wv4Gke2DDVwsbbfWrGuzS0Nm9LpE2hQDTpEHIb8GtsFLDsS7Rz3CvE2OYQA+/CfK1z9hPLmnq53eu
X-Gm-Message-State: AOJu0YyLvxdZwR3u0Y+TVbzHp9mB6s85M0hVMuKgtMb3H4+YfO1MGcZ3
	RJW2Bc2vEHkLSc/B9HbcJv4Co9VOUgpbv3xHSRggSkwRgTOPQYKyNzVuzbw10W1Ei1D/alK7KPD
	HH+iT+Ja7lvKKqDk4BQcVmtv5BeuHyT0LClPv9w==
X-Google-Smtp-Source: AGHT+IGnQkB4dy1+XaxZaGC5cn9k/k/gqgs8XKEYWBSg3ze2AGNRxBxtP0Z90SRSbaXxF6TSdzpnrlfaIXPF8JuG5cY=
X-Received: by 2002:a05:6870:fb8e:b0:260:e83b:cc13 with SMTP id
 586e51a60fabf-261214e4a6cmr10019744fac.28.1721738230798; Tue, 23 Jul 2024
 05:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722101202.26915-1-james.clark@linaro.org> <20240722101202.26915-8-james.clark@linaro.org>
In-Reply-To: <20240722101202.26915-8-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 23 Jul 2024 13:36:59 +0100
Message-ID: <CAJ9a7VgPLpx3K9GVydDWhWSxLfsmeXEXntqA60S6ot12Kcefjw@mail.gmail.com>
Subject: Re: [PATCH v6 07/17] perf: cs-etm: Print queue number in raw trace dump
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 11:13, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> Now that we have overlapping trace IDs it's also useful to know what the
> queue number is to be able to distinguish the source of the trace so
> print it inline. Hide it behind the -v option because it might not be
> obvious to users what the queue number is.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  2 +-
>  tools/perf/util/cs-etm.c                        | 13 ++++++++++---
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index d49c3e9c7c21..b78ef0262135 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -41,7 +41,7 @@ const u32 INSTR_PER_NS = 10;
>
>  struct cs_etm_decoder {
>         void *data;
> -       void (*packet_printer)(const char *msg);
> +       void (*packet_printer)(const char *msg, void *data);
>         bool suppress_printing;
>         dcd_tree_handle_t dcd_tree;
>         cs_etm_mem_cb_type mem_access;
> @@ -202,7 +202,7 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
>         const struct cs_etm_decoder *decoder = p_context;
>
>         if (p_context && str_len && !decoder->suppress_printing)
> -               decoder->packet_printer(msg);
> +               decoder->packet_printer(msg, decoder->data);
>  }
>
>  static int
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 272c2efe78ee..12c782fa6db2 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -60,7 +60,7 @@ struct cs_etm_trace_params {
>
>  struct cs_etm_decoder_params {
>         int operation;
> -       void (*packet_printer)(const char *msg);
> +       void (*packet_printer)(const char *msg, void *data);
>         cs_etm_mem_cb_type mem_acc_cb;
>         bool formatted;
>         bool fsyncs;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index b11b0cae608e..6298a5c7a651 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -762,15 +762,22 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>         }
>  }
>
> -static void cs_etm__packet_dump(const char *pkt_string)
> +static void cs_etm__packet_dump(const char *pkt_string, void *data)
>  {
>         const char *color = PERF_COLOR_BLUE;
>         int len = strlen(pkt_string);
> +       struct cs_etm_queue *etmq = data;
> +       char queue_nr[64];
> +
> +       if (verbose)
> +               snprintf(queue_nr, sizeof(queue_nr), "Qnr:%d; ", etmq->queue_nr);
> +       else
> +               queue_nr[0] = '\0';
>
>         if (len && (pkt_string[len-1] == '\n'))
> -               color_fprintf(stdout, color, "  %s", pkt_string);
> +               color_fprintf(stdout, color, "  %s%s", queue_nr, pkt_string);
>         else
> -               color_fprintf(stdout, color, "  %s\n", pkt_string);
> +               color_fprintf(stdout, color, "  %s%s\n", queue_nr, pkt_string);
>
>         fflush(stdout);
>  }
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

