Return-Path: <linux-kernel+bounces-176235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A718C2BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E6D1F25802
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD3F13B5B0;
	Fri, 10 May 2024 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oc5KTpO+"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E9495E5
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376455; cv=none; b=V/pF4koF/MT0zWgmoAqfFAVGoY7UcAWZ4vw6bouCG3nzKnIKOYCSA7lDLlCR0Ru/rvwvPpYCtoVeMnv7IBFbE5Z8pqIc7uB7/HuLNcNRleoUWvV0vXNP/FmhcXf23IAGI036g29HR8P1EIpbENm2+6C6WArNIBqNCoQvdrXGj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376455; c=relaxed/simple;
	bh=lvG54KOtblTtm/Gtue2giqL/wNiwZJbkby5y11Swbwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZZaIqzosv94zq6YIRxqZV8vkgWpqbYZ86rWGg8IMCQUS/P9rmpnKso7YcxAmx2JoUKbrx87Dp/pq5GGgC0oAPl6JlgasdnmG/7Wnit+Ya+qTwTOP8so2zzygm/F0tehFO1yE10hKBQMKhuG42Z2d51JgxurKITv6EYVv0J4wao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oc5KTpO+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43dfe020675so136721cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715376452; x=1715981252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMIqC4lMOuMBFP7thYu5aGC3mPK/U3Jb/uL/qezic2U=;
        b=Oc5KTpO+6mFg4e3qHbMvYCx6B9xrS+E7ZMZa6yHBBDWE65wC67Afhck6rTPCfwhwhX
         VauIMizFvB546lrSAhlZQa2n83l1R7Yim4FRsv4cDzBI1POhjgGAcHq8Bg055FwPgd+D
         8B2jpBy9YYUOPqYJWkHD7EU8bMWkAT7WLyEx0hivOYJ5MKo6zse3ciFRaXp34QVfqg4o
         FySmBubx7AREjWDQVuYoCJMkvVQm91VYxv1hhwzNfxHiJBHlKpAZLkF32eXSenqRcIVB
         BvfJRzgBxwH7Gi22XB4hgqf8hCR2poprS9OVkKdskavUdBip/C8R36PDbReBdnmRuZbg
         ViVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376452; x=1715981252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMIqC4lMOuMBFP7thYu5aGC3mPK/U3Jb/uL/qezic2U=;
        b=V1UlLYczlPheLpBEqsgb/l2E7vQj4IluFbqUHzPeFxjAKpcxQ+sZd7x/5MUF52Yqd2
         q0INBD43WyNcaByObarCMDnYzFh1EieaBtbshxxnEpalqQI43Ajq7HXygEluUPwot7v1
         31SG1e1DMln2oh2MKLG95X2Zjz5A4Qohpeijai2ZnD/Twj26mEWU12RjY8wiXiMd+Ybd
         3j8OWwiottMGbunzDJstPah5FVCN1WKD46WBys4ydpgQKdkDZEC9H2tmDZof6A9gqx1F
         RDYapbqTO472k8B1SRol4jKIKxTSy/teDz9e6+GTVMxRzEQJ9YML9pspRQ9L90ylU+nl
         sxww==
X-Forwarded-Encrypted: i=1; AJvYcCXvBh3SUiryoJgY2SGMpsyq6pbr/OoPxiXVuzNVD+Xss7N0umqAhlxPruTrcFuBwfHXruNrL16+cAeCA3xHPyPUtyuMXkVb/Q88s5A5
X-Gm-Message-State: AOJu0YwG/3Zi2cTP1IKjAfeqjKUWfTkH1Q8TQWgkXZ4OWkbOJm/511+F
	wldclwCGOQTD2+trjS0lo0bt4fwDWMYGtaYk69ayGlFcpuKk0yu9DZKeCFI9qKRT38biooxHi+5
	xrdftXW2SfzLFazzceLi7W9t5RxAwlNvDSHbz
X-Google-Smtp-Source: AGHT+IEjb0okTB4Al5CD9PyKlA38q7krTdd+xmQxhBlLYBzsV/NL2v4IqQlh601MgcnDJfiufJcxMBxLXl3KVVIDFHI=
X-Received: by 2002:a05:622a:4184:b0:43d:e294:3075 with SMTP id
 d75a77b69052e-43e0a21da9cmr206801cf.7.1715376452341; Fri, 10 May 2024
 14:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM9d7ci6Y98hkiN1+=Q=YgLQLL-GN+pTxQ1JjqA+Q1EMEi52+g@mail.gmail.com>
 <20240510210452.2449944-1-namhyung@kernel.org>
In-Reply-To: <20240510210452.2449944-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 14:27:20 -0700
Message-ID: <CAP-5=fUXPP1eu2dsDjFaZY62yZitNj7y=RfGDinQYx4uqDic6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf annotate: Fix segfault on sample histogram
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> A symbol can have no samples, then accessing annotated_source->samples
> hashmap will get a segfault.
>
> Fixes: a3f7768bcf48 ("perf annotate: Fix memory leak in annotated_source"=
)
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/annotate.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 541988cf6e19..1451caf25e77 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -113,10 +113,11 @@ static __maybe_unused void annotated_source__delete=
(struct annotated_source *src
>         if (src =3D=3D NULL)
>                 return;
>
> -       hashmap__for_each_entry(src->samples, cur, bkt)
> -               zfree(&cur->pvalue);
> -
> -       hashmap__free(src->samples);
> +       if (src->samples) {
> +               hashmap__for_each_entry(src->samples, cur, bkt)
> +                       zfree(&cur->pvalue);
> +               hashmap__free(src->samples);
> +       }
>         zfree(&src->histograms);
>         free(src);
>  }
> --
> 2.45.0.118.g7fe29c98d7-goog
>

