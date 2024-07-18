Return-Path: <linux-kernel+bounces-256418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1B934E22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99601B23220
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0907B13DDC7;
	Thu, 18 Jul 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQjBDo4s"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE713D265
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309126; cv=none; b=aiUly/Ojb7Whh2Iz5fxiVnFX6+6rAgej1ib8e8bvt7996ChLUnokEMuDa6jhp3Q811AlWdvdsbsB8g6zseLqYAN7nW7S+rIoJmGvq2f2BMAgGsVHTzYAUuytzA4NQ53ngbgt6HMiKStFzcEFDi++I6Ho021qC1gIf6TFu7014Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309126; c=relaxed/simple;
	bh=S5dkrZMYBtJRxu8uD8VPJpkEyyYra5z4jh+F0jFEWbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfRmh8VvL3dYHlB0CmV8hOknFyRm8MqJseYVIOI66/oFhDqhsPI4/c1McNknr/zj+XRJlSStyZx9X0gwhTBaIm7+uSXQxQ8pqkJPeLp79OyjZ+6RNlLHOCxNFfsJyg7R42DewwrjWMdGz0l0zSiLbc91klLy3OUB7z0m/IE7OHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQjBDo4s; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25d6dd59170so391418fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309124; x=1721913924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vir5nuwGazUP8EA8QzwI5PQf4dQjth2jy2roymqp4Nw=;
        b=CQjBDo4syy8HqtaJiqdYfD7P6xrvfO8f+R07qRTedRr3Zfr7rHUs6FHaraCwncDzup
         09ynVjXBSg/H3D8lmdRMbISYqDH7dsANnAQ+mWHnQnSERqKKPuHZq/dTOH9ShLZsILWI
         bS6bBMIwOenwmH7UZ/UtXycc3u8NmdPwCV2dm9eRU5uQsdSzqMqUDtRItcbCU/6SZD1a
         gpXNrjmpScWH81LdCR/s894EP4kJVL+i6boTK7sVuXC+rwEEwKrGipmYayxpcGfAnErM
         Iv03BOuw+d0nDwL42kneSNbq39lbUnKx82gcjyczoJSNh55Q2A68fr4D8I6Zk2WwrleB
         E3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309124; x=1721913924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vir5nuwGazUP8EA8QzwI5PQf4dQjth2jy2roymqp4Nw=;
        b=Ap1SJTQI+BOw0ew39dAjnzzztHOIRYp2/H6nhNB8FAfUxr40Az1ixdCeHMVpo5Mebs
         5Dpo1UjToyhGSkYaMkqyycn0p9EtHn0ie91Esvz15Q6IAwMobqwWKoPyJFcPQn9FFVzL
         Jj8O2r/47Silvqbz2f7uqA5q/9w90uIyigljNkVrMFjOcjGJeYtxG1S0LSpiSmWZZX/Z
         nk9PDVStVvN5/oi8lrf6RZLx9cxyn03d5WhWLL/1LA8qlinWwM1XZQ6Kc0zZIzLqRWkj
         0ANIq9yxKewZLQQ4GRIJCvKtobTCPY62SOVTpHkdXQGwBl+x6d8ma8Rfr0VJ/kA0uLNF
         e16A==
X-Forwarded-Encrypted: i=1; AJvYcCU5dqVLtVciEYPWbyRBd3Xydg83MD/yABEU4NHQxIqPR7toJikU6Gmear16FEks12NLzBO2GazrUNQ+Efzt0OO2xdUeSXRRxiU9fbv/
X-Gm-Message-State: AOJu0YyEseR8OfgttNtQRB6ZR5eu4FudGXztpctzD7s2T+pJKmlmA8vn
	yXCdg7K28C2/iPjPM1v4StFPHJvho7CmMhGgK7XtjsqlH2Bjv9QzRu0xGxnKIlPqrhjLaVFFPcX
	vWiany/mTMS2ks7dXxD1yfmaDuCsDw0F0doOQlQ==
X-Google-Smtp-Source: AGHT+IEPkgjGJn18JYE974ykVld89iuuCfjj4jWKBJklPyYHI5h+O2RZ3oJBBiisTG2ZSOhOgPHN1XUGr6CrzMpV6u8=
X-Received: by 2002:a05:6870:2308:b0:25d:e3d:b441 with SMTP id
 586e51a60fabf-260d921d6f1mr4069222fac.40.1721309123785; Thu, 18 Jul 2024
 06:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-8-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-8-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:25:12 +0100
Message-ID: <CAJ9a7VjH+3LFJvSHkKUD_hJjxnpk3zyJ3ohFL6J6rgyquqyj=Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] perf: cs-etm: Print queue number in raw trace dump
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

Hi James

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> Now that we have overlapping trace IDs it's also useful to know what the
> queue number is to be able to distinguish the source of the trace so
> print it inline.
>

Not sure queue number is meaningful to anyone other than someone
debugging the etm decode in perf. Perhaps cpu number?

Moreover - other additional debugging in the trace output is
controlled with build options.
See:-
Makefile.config ->  ifdef CSTRACE_RAW,
thence:-
#ifdef CS_DEBUG_RAW in cs-etm-decoder.c

which adds in the raw byte data from the trace dump.

Could we make this addtional info dependent on either the standard
DEBUG macro, or an additional build macro.



> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 2 +-
>  tools/perf/util/cs-etm.c                        | 7 ++++---
>  3 files changed, 7 insertions(+), 6 deletions(-)
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
> index 87e983da19be..49fadf46f42b 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -762,15 +762,16 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>         }
>  }
>
> -static void cs_etm__packet_dump(const char *pkt_string)
> +static void cs_etm__packet_dump(const char *pkt_string, void *data)
>  {
>         const char *color = PERF_COLOR_BLUE;
>         int len = strlen(pkt_string);
> +       struct cs_etm_queue *etmq = data;
>
>         if (len && (pkt_string[len-1] == '\n'))
> -               color_fprintf(stdout, color, "  %s", pkt_string);
> +               color_fprintf(stdout, color, "  Qnr:%d; %s", etmq->queue_nr, pkt_string);
>         else
> -               color_fprintf(stdout, color, "  %s\n", pkt_string);
> +               color_fprintf(stdout, color, "  Qnr:%d; %s\n", etmq->queue_nr, pkt_string);
>
>         fflush(stdout);
>  }
> --
> 2.34.1
>

Mike
--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

