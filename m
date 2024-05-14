Return-Path: <linux-kernel+bounces-178261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E778C4B45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856CF1C2182C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0917721;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KN74O7cP"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB179D2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655088; cv=none; b=OGqM4QE1mW2nWdOBJRnfei/VTxwAHthbMO6jHWgYJ5hKsxxCpIowInVC1gQx5JNF/VqwgLFpF6LMcFL1K4j3aiRsBj7knuVZvXBS+ZVIgHBXMU8NNqbcVIT0yxA/TFgURyEr3zmfrdpiVylY8hrxZYb8ce77eYBO0kgqSqCXMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655088; c=relaxed/simple;
	bh=nLqnRzXuugsBdc7ewTgIC3l72dQ3bEBHuThmW6siqFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWtrrzceXBxHcHu9tysNP2zfsmf0GHxR76mFSaw8Os+ovhfp3GYnQ5POyWZactTrG7ICXeGeUuaDjORn+dT3AVvE1NdKcwxT/GLKJY+sEi4stYTHffsy6XhzXWSmz+3w/Co3uUY7iTwPww5YVEhpysoShDiRaTvQhAS+/8T6Kpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KN74O7cP; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43df9ac3ebcso1032661cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715655086; x=1716259886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIa3lnYqMtW+apSFSgewrwmz8iNQ0a0TRqIJ0PDkJcw=;
        b=KN74O7cPFbeYt+UN99m9jvNZhYPAHplEC9M2fk6jBn4VSyhWTgbzCFJoxdAp+HHz0e
         w9yAx6HNLkr7d1QeRlykobr+GDLYmN26ec4DX00/WLXv11LIymI37+3l+ZkAeaZ7Fgnp
         TELpPeZKQacH3NA/981PyLi4mTeyNdbIFMr955uqo0DF7PVKHOeVc10PR+HyVD4S7k0m
         tpFtnb/VKQfAN4AIRQN8vL037quEPNWoghj6piqhwc8Ec4etLmAl3WNknCdPYPRg4zpB
         BAGBtsCSIe9HudT/M+/0LEbM3IPFUdroj1q6y2q8kaJWheLqJMVvNiZ08TI1YGc8N13c
         IWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715655086; x=1716259886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIa3lnYqMtW+apSFSgewrwmz8iNQ0a0TRqIJ0PDkJcw=;
        b=sWKTc7VT6I24k1qyUFA5Q/vkjejHZoHR3JB7ZL4cNYrMdcxxW/Run7LS5SVCHH+VRG
         tLIA40QK5BlMIB03wTFdmq18EzRINRLLAmMEsxpKsH4mk8seZDMsaewrM/FijKNsvIrl
         ycfsLkLQlW/GvpYCWflVmjSNUipRU4COMNa8ZzrQ+r12VqEYEvVYFpZRdlKHbX0MkhKU
         pdxP1r6NkcimyHxOf+ozQCVMSMkm3uDPtVnDmlI9S/7fhsv0AG0Ibg8p61CVdfuEAOH6
         DtmsRFkCJvS5132/ylTkzTj6/oQ0z7dOm4OyqxD4j3sXAi2rycUB1A7f83Obj6eMPCC7
         fNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzHPtJPcRfKZZSpvG4SB9eDysUlKNGwrtqxSdBZ2EhWY1cbiZlEalvLC+F/6QBVwfJcYTeYM5yuq1XlXx9EHwjd8hrG70MdFCYgstH
X-Gm-Message-State: AOJu0YxAC7o2VQ3vBy2F0McEMHut/xaBhMKEEdG85iFzYZL8vmcEqIJf
	vSNedAj3+0JLlWg7WOoULUulKWDH9sYEsAOJGydAo7N7QqWh6+fCg9U4nt1CkL7ATJjuntdQ1GY
	8WPxUxig1rNH8/8NB0uMzLqe+xdRnMzfOxWPf
X-Google-Smtp-Source: AGHT+IGhtFEj9beqqIh4sXHHRvKxoIkelYN2KoaL9BfCJUD+o17rUm887vqMEGHGvEmtncn+5O6pMaj1JWVyLypUqX0=
X-Received: by 2002:a05:622a:40cc:b0:43b:70e:d677 with SMTP id
 d75a77b69052e-43e0a232178mr7454281cf.29.1715655083303; Mon, 13 May 2024
 19:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513212007.62904-1-leitao@debian.org>
In-Reply-To: <20240513212007.62904-1-leitao@debian.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 19:51:12 -0700
Message-ID: <CAP-5=fXimpTxhC0A+MDs8t9zn=hifHFxLChQm_QzJQtuHbztPg@mail.gmail.com>
Subject: Re: [PATCH v2] perf list: Fix the --no-desc option
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 2:20=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Currently, the --no-desc option in perf list isn't functioning as
> intended.
>
> This issue arises from the overwriting of struct option->desc with the
> opposite value of struct option->long_desc. Consequently, whatever
> parse_options() returns at struct option->desc gets overridden later,
> rendering the --desc or --no-desc arguments ineffective.
>
> To resolve this, set ->desc as true by default and allow parse_options()
> to adjust it accordingly. This adjustment will fix the --no-desc
> option while preserving the functionality of the other parameters.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
>
> v2:
>         * Do not print desc if long_desc is being printed, as identified
>           by Ian Rogers.
> ---
>  tools/perf/builtin-list.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index e27a1b1288c2..16186acdd301 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -149,7 +149,11 @@ static void default_print_event(void *ps, const char=
 *pmu_name, const char *topi
>         } else
>                 fputc('\n', fp);
>
> -       if (desc && print_state->desc) {
> +       if (long_desc && print_state->long_desc) {
> +               fprintf(fp, "%*s", 8, "[");
> +               wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> +               fprintf(fp, "]\n");
> +       } else if (desc && print_state->desc) {

I think we need the same fix also in default_print_metric, on an Intel
Tigerlake I see the description repeated like:
```
$ perf list --long-desc
..
Bad:
  tma_info_bad_spec_branch_misprediction_cost
       [Branch Misprediction Cost: Fraction of TMA slots wasted per
non-speculative branch
        misprediction (retired JEClear)]
       [Branch Misprediction Cost: Fraction of TMA slots wasted per
non-speculative branch
        misprediction (retired JEClear). Related metrics:
tma_branch_mispredicts,
        tma_info_bottleneck_mispredictions,tma_mispredicts_resteers]
  tma_info_bad_spec_ipmisp_cond_ntaken
       [Instructions per retired mispredicts for conditional non-taken
branches (lower number
        means higher occurrence rate)]
..
```

Thanks,
Ian

>                 char *desc_with_unit =3D NULL;
>                 int desc_len =3D -1;
>
> @@ -165,12 +169,6 @@ static void default_print_event(void *ps, const char=
 *pmu_name, const char *topi
>                 fprintf(fp, "]\n");
>                 free(desc_with_unit);
>         }
> -       long_desc =3D long_desc ?: desc;
> -       if (long_desc && print_state->long_desc) {
> -               fprintf(fp, "%*s", 8, "[");
> -               wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> -               fprintf(fp, "]\n");
> -       }
>
>         if (print_state->detailed && encoding_desc) {
>                 fprintf(fp, "%*s", 8, "");
> @@ -484,6 +482,7 @@ int cmd_list(int argc, const char **argv)
>         int i, ret =3D 0;
>         struct print_state default_ps =3D {
>                 .fp =3D stdout,
> +               .desc =3D true,
>         };
>         struct print_state json_ps =3D {
>                 .fp =3D stdout,
> @@ -556,7 +555,6 @@ int cmd_list(int argc, const char **argv)
>                 };
>                 ps =3D &json_ps;
>         } else {
> -               default_ps.desc =3D !default_ps.long_desc;
>                 default_ps.last_topic =3D strdup("");
>                 assert(default_ps.last_topic);
>                 default_ps.visited_metrics =3D strlist__new(NULL, NULL);
> --
> 2.43.0
>

