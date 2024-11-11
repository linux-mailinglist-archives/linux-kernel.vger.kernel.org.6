Return-Path: <linux-kernel+bounces-404459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BB79C43ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A381F216E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D141AA1DC;
	Mon, 11 Nov 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFy7uowh"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCB1A76BC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346900; cv=none; b=kQ6hLQuhaCFAiR8TWNrYhmePuneq8Jvaq9ddtvh/YChJbZ+QpTukna4+vWS5TsorADiznzL8sUOMZjNrJRKV2gpq5hR2/wz5M3CnFhtc6tcJqy73+sKv+IyCUobmDuUYT64Zat+78FMzbWxSIUdN4mZSpzV6pHV5duieU/PoyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346900; c=relaxed/simple;
	bh=j767+Q1r37SUH2n615lZg0OOIFpm90KEXiFOwlHbyOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGK2xfuUvvzHMs32D+2vKJU3bMXh0+Do0dk4yOYW4UV5ztsERhT2pRD7OWiGexYtqHvlkjB2MxctzNZ7IPHb7MMVUqftWEhlS6K5JAiYQH53EDJ5lfHGZiaX/LiJrSYdcYhdUe8YjTxs5P6p4vFOdSoYoobIS05BKBOzn9SNOm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFy7uowh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460969c49f2so2571cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731346898; x=1731951698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eIWyin90eSMWDk2KIoYfMdKN5d2WbTrGD/3InglUdw=;
        b=DFy7uowhrkj1q+nlR8CLXPmUDQuqPb8UrYyDo5FcUQpRRxPQfKGuduMra21MquFHeC
         myNtnwqwGFY6Pn8unZZ+sz3Mwym95Yz3y5he8BktyHbf99ARUxlZlMf8p0rutJXW/+Lu
         foGZN0SKOgneC7pKmQcIkddaq//uL/7JscLek4tCnGYO50GhDP0rhay7SALpIG9FHuBq
         AEPF2C8xf8VlADxTyoKzhov4+s6L/HeMFsSR5OZXySg1kInlRk+8nnVS5K1T963nlaLN
         ZIGRK56AqJEEdZh3sUXRQ5L0KUkFyAi7pG8Z0y7TXUTkUAnnmY1riiDLa7X/Rk84pwP2
         NIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346898; x=1731951698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eIWyin90eSMWDk2KIoYfMdKN5d2WbTrGD/3InglUdw=;
        b=kwSBy6htYKqMf2Nqc9ldxJjbCGFFgktuKwcQ96GK18Jw6W2UjJCG2pc+VjnGPHCUsN
         XQ56/0om/+BQe6PdT/62TSQjB8yQ+5zyU5gaGTbIy+YpF66Uqgg4U/rYS0+DjBPjZc3r
         5ofAWB96g1cAIDk8KGHN0QVz0EjBVVwvB13aMOSBUqRgigCSyIwRGRGdWUZbBiAKvyKg
         EBuebwQPfKigprdlXFQBTtQMuofV4Av5dtJJzBm3JWOtWeIcjjioL8Lozj68hXmg3n1A
         gcoTXDenEL0Zhh9tOfScelLieoR/FXtYMpwv8YPjF8MWSicY/fQOxRlxh2vaeFqVViwD
         J7LA==
X-Forwarded-Encrypted: i=1; AJvYcCWz3RDmeHNjRh9P2RX3Kizw83CnA58fjS1QtHQ8l6gexWNd71UYx47BQrddgicCx/h4GdClrWRPe111kSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4xLd/i/pPgDWEsW2lm0CwM278r8gdu/SqM8hwQFBHCENmoqU
	JEg8gbkUaihodi44SAUS6TlgsmD1nDrf848jeS6UzwltzBHZWZ/y8+tMlkCAswI3Vmw1MPI9kB8
	khxcTIy5qWdqxfrjVxbBAQUIzoGhrxu+Wm3qf
X-Gm-Gg: ASbGncsA7yp0gkCTLPYL4F+IPgw8rET5FtYsgjPLuyg/a1Fm2KZdWyQ80mYBgGUnfUP
	TksG/AfZXJQOXf8/EOtOd0o77s303r6b9P+8xa05K+zuEvmMALdXcnOx1AW+9eEw=
X-Google-Smtp-Source: AGHT+IFXHqqr9T9fYqBjdk/y4XDoYoQXljKGYDZzdrbYdE3NEYkwRL0/DPAPhGpQprT/9y8WY5pCe2FdqGVr6tBHEcs=
X-Received: by 2002:a05:622a:1454:b0:45f:9b3:c7d4 with SMTP id
 d75a77b69052e-46316965e68mr5312121cf.6.1731346897791; Mon, 11 Nov 2024
 09:41:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-3-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-3-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:41:26 -0800
Message-ID: <CAP-5=fUXvpgZ-bkCYjYaTu0OOkqETx+TStKJOupx1y5woS8PWw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] perf evsel: Expose evsel__is_offcpu_event() for
 future use
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>

Not sure if no commit message body is okay. Otherwise:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c | 2 +-
>  tools/perf/util/evsel.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f780e30aa259..695f831b463d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1193,7 +1193,7 @@ static void evsel__set_default_freq_period(struct r=
ecord_opts *opts,
>         }
>  }
>
> -static bool evsel__is_offcpu_event(struct evsel *evsel)
> +bool evsel__is_offcpu_event(struct evsel *evsel)
>  {
>         return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCP=
U_EVENT);
>  }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 04934a7af174..7f68004507d8 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -554,4 +554,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
>  void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evse=
l,
>                                 const char *config_name, u64 val);
>
> +bool evsel__is_offcpu_event(struct evsel *evsel);
> +
>  #endif /* __PERF_EVSEL_H */
> --
> 2.43.0
>

