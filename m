Return-Path: <linux-kernel+bounces-174205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E68C0BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F906284635
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F186642;
	Thu,  9 May 2024 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5vao0v+"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AA7C0AB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237010; cv=none; b=BSYJoCz5ZIKk0CpLNPALaukEwfcViosoeS8B8tEZx96gycEPpTNyWWBg9+6LekVnigF2kj3VbQJ8LUDQEH+iC9RMcsQx4NfU0bkv1lYTdS1kwXU+aT6qLfuDii8yugEXRY/ea+E/RrmDJXHrc/qDsrq3Q924sY5wRENqlWbzP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237010; c=relaxed/simple;
	bh=/g14F37mirIOBKpZB7OIDBv6ttQWhutX0fPcpDZNFYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDcjqDUcvkRLRitVXJ7I/FRPDjnHzVvLOOewMI8qVyCNO+TIIpCcBE/D3kt6edne/X3TkCX0uJ4GqVni1RAYimBmCE22xKEaiT96PzOc4fE/YdOV3t0NS9osWQsYgF5KHgpnVeIwC/cYly0rtP60dEVuATFGRIT3qEwZxZLx/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5vao0v+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-439b1c72676so232341cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715237007; x=1715841807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sfpm2g40k/3k+p/MIEAhjjOe3D3qfwBHw4FyzeD3fNs=;
        b=W5vao0v+PFFJIUhTvJbBFx2EBc114KA9sro3DSmWhKwvg7TKnrPHz+f1TWESQrygpz
         lKRZmkBdb8us/lDCihFMbxKdIFLRGyt0A7LfmERc3fwxn14PDYDxhK5dZqQBjUSMjk0B
         BxGNZwnRtxJE1NVMeTTvyQvFlQejbLM4WEAexDS2kypl7sDQK5qpqXvz9WmV7+8khMGj
         Q1MTwuzffnQIRC5iUNPiY0jHUjnf8pBQf44kgdjT/3xTUez8pHjldEedH6bYtG+aheZa
         fyxlXtZpldc/HAlkdfH02YBYDWbxV0f9hwTDhDTJPUY1UQTwX9PWe+BJ6O0v5gcEjJ+7
         VFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237007; x=1715841807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sfpm2g40k/3k+p/MIEAhjjOe3D3qfwBHw4FyzeD3fNs=;
        b=U9KeF3Jkk0FkjbTe8y/tF2VfyBseI7gQFA82X4iXoiCxbHnH5tJhZ5MtK5f9Ft1egI
         LHBYDpp8JdUSkaunjuf8jUApf0KuXTmaxZek/hVKmy8FhWGNSrZK+IL7wRuLnkC4xwqZ
         qnMoW4A7ug8FjGzoYallrohi2MkgF5RjO4sJP3/ZzpaN8sXtV7NdrMUDZ5DHpU2Qfr3j
         3BowIWHUgn4bHXacvkiRDZ96ou5ogOTX3CXuyhSjmtzbHpecwXknthQCOPw3T5FH5JiN
         j7NrjeUyP9ddk/pHqleOKJsr56VhjenKSMFYCdp0/X28uQdBHJNvLerg8etessJAfwWf
         4aEg==
X-Forwarded-Encrypted: i=1; AJvYcCWhr0ojpLaCBQssQaJVsTtVmoe4oq4q3TKAEtPN5dHR5ZtGf3PNf73GO1J6KJriTnZyL1hH/K1hhbaNzriASjwlfCfbPem2w7VjJ++e
X-Gm-Message-State: AOJu0Yza4SN42yfgsalscF7ZKK+zZ6Fwz+krMszMLPmeuc/jwYyIGio/
	yYPGafJgNXCxCW/FqVssBBOAhl33wCihZTR/tf++57Ri9i17MshyFc/3WoYc18AXyk5DBjDcRWV
	D9A14NBNVlNLTA2mh5QjVEeThZUIx9VdzTLXy
X-Google-Smtp-Source: AGHT+IGsUj70NyQXF2GEHvVoFbL0ZskwScPPIR/RezSyT5OTXl14Rd1FF+kOEXGundYuUuqa/z6LaxOUxKhBAp7MLTo=
X-Received: by 2002:ac8:6f1b:0:b0:43d:e001:69bc with SMTP id
 d75a77b69052e-43df44f9033mr1699781cf.17.1715237006642; Wed, 08 May 2024
 23:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjpBnkL2wO3QJa5W@x1>
In-Reply-To: <ZjpBnkL2wO3QJa5W@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 23:43:15 -0700
Message-ID: <CAP-5=fX3c60v=7dt+Nryd5KqvKMU8EXz-jJAvJ=p=S_N6hJjUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf probe: Use zfree() to avoid possibly accessing
 dangling pointers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 7:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> When freeing a->b it is good practice to set a->b to NULL using
> zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
> pointer is kept somewhere, we can more quickly cause a segfault if some
> code tries to use a->b.
>
> Convert one such case in the 'perf probe' codebase.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 019fef8da6a8e60f..003a3bcebfdfc2d1 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -325,7 +325,7 @@ static void cleanup_params(void)
>         for (i =3D 0; i < params->nevents; i++)
>                 clear_perf_probe_event(params->events + i);
>         line_range__clear(&params->line_range);
> -       free(params->target);
> +       zfree(&params->target);
>         strfilter__delete(params->filter);
>         nsinfo__put(params->nsi);
>         zfree(&params);

The change is fine but params is freed here, so the potential to read
"->target" is small.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> 2.44.0
>

