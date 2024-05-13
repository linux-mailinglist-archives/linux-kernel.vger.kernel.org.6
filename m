Return-Path: <linux-kernel+bounces-178090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE68C488F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0751C21D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3481AC7;
	Mon, 13 May 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qde6JNI5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6980BE3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633984; cv=none; b=Lq/Di+3pWFArdMhAftPblxUNjdFWhu+rap0sJqTOWFw7sez6Nx4b9lv6wG7u/7djYq+tF2tk0Nf2oehUq9lCiDUZVKBkLI+EYR0XE4v8OYrgTi3e5zy+rPGBUrEU6kVaSyMNqU6vd/ecIQQJU55fk7DlfuvCKBCSntveG3S5/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633984; c=relaxed/simple;
	bh=4wo2azftFf1AIjEsDAwA4hFFTnEjmQzUBAW7KDvwLWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuRnzThS9XABvjbLX2qzLce5KyALpKuJwKzjn1I7M7ck8G/OrmZh2QPix3WkBXC34WqTgp5Ha/wuX1D03FdrqqhwgjKMC1x0v/ML0BPTAyuOM47Vqwp5IbCsmBGi3smseait1ITL/MMpWKRya+FwBV4L8hp94Dw8CHQhyQ1G+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qde6JNI5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eed90a926fso357145ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715633982; x=1716238782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fxgwVwfcFfwC3FeF4jyUDShyy0fu5SAPtgvle3ae2Y=;
        b=Qde6JNI5l75mLlMq0h4/tKtqSsacECJW7j6biT0K4JsxzRZBjg45dv+9dIHvbdrePW
         5WUMfHBCj0j00LN7qTPn5BDsf500uP0DdJh1ETC8CmNRalyVRHRkb9q6MrhH5RbO6VXb
         kOzXYz6ZN3/J7nhlBqwiqtQsgLDSnLOcdSayw70mna7e/wJs2kSJ2eOvC8U8n3em6hjr
         ducaUsVwX2M3W0vG+x/0Sy9OgXglvz5cekIBePumy6y9BmXZiGUFZyrmSo/W3cbKdHy9
         917GCy10/jiPe/mKv4zXlw3XXoAJfGL3DlQJy0U+rK7qmH2f7WKCA+ONiEOVUgyHD9Wg
         l/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715633982; x=1716238782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fxgwVwfcFfwC3FeF4jyUDShyy0fu5SAPtgvle3ae2Y=;
        b=U57RNcthapyjs/yq43DopSV5r4Bm/Oy2H2qB5GdRRKhw1UJvzqXr54H2r+LtFzKLtr
         uzKXULBk1w4zMQ+tfr7v/0okKHsGqx0q1mONdv4Y6BKWlYx4Oxm0igyp/PrQxrnbzy2y
         Egjy9dvfKKfdqVbu3uztWlqj25DR+gCTnG6yTmRJ9IEqKPIwi2wMHveP77lUtYfxrtze
         4j5USY+GT2M5vdGd/aEvFFPIhS+uB9n52hNTGGlA4Ntfd0pR26oDmlbVSU82CQJTW4Jp
         ggIwcCPmQzKeU2WyV4P1MF/OOtm4P5JYCnvSzdh0lmRPnWrB2JS0dpGXKyPFS45VXEyE
         XG7A==
X-Forwarded-Encrypted: i=1; AJvYcCVVndkVtB5Vl+qV85dkJzdGqG6RXHLiLu4hVK4T71npV5BDnxWkfusWvSZoFy63FPnv7qWmECyjRjJolsXMBM1yBfOI5n8T7HcQb/F8
X-Gm-Message-State: AOJu0YxGcbDbYxNC4g92nbMH+dQrurgddxxKmiHrrjrtI0FI5xEtRGN1
	zmKGb+sg/nUtKp6ZqHV8nkM980q7RSk3ovkoHCdmDmz7h2WTElLnHlYtN5/orSLUstDWa6pr5oe
	IweZuIxMMTs0oTTC3+vCbkXZTCnDqqdddErcF
X-Google-Smtp-Source: AGHT+IFTHeolzNMwmRJZtjMWXv5w5XuqCfwQMRNtovnU9kL/RTox7SZOsW7vxxFy5Elp/HRnGtmLFVsv3Er7sGo9+6U=
X-Received: by 2002:a17:902:d4c6:b0:1e8:88b2:17cd with SMTP id
 d9443c01a7336-1f05f651484mr4698595ad.12.1715633981812; Mon, 13 May 2024
 13:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508133518.3204221-1-leitao@debian.org> <Zj-WE1aG7ihtevG3@x1>
 <CAP-5=fXXYVgb4rnftaiTZTEniGOr5NnpfXJFNqX96GXP6=oTiA@mail.gmail.com>
 <Zj-qIbUN2XFBnvP8@x1> <ZkJI6Q6KVKlzDgSQ@gmail.com> <CAP-5=fU=tG9Gk+OfO3TVfBONTc35oksNqi3xm6Y_hjc0oOK=dw@mail.gmail.com>
 <ZkJ70SOeVPsLRuS1@gmail.com>
In-Reply-To: <ZkJ70SOeVPsLRuS1@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 13:59:30 -0700
Message-ID: <CAP-5=fX+HinGA9LX73XsvxCTqMwn+DRUzO4OxgrhzTz_fxOM6g@mail.gmail.com>
Subject: Re: [PATCH] perf list: Fix the --no-desc option
To: Breno Leitao <leitao@debian.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 1:45=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Mon, May 13, 2024 at 10:13:01AM -0700, Ian Rogers wrote:
> > On Mon, May 13, 2024 at 10:08=E2=80=AFAM Breno Leitao <leitao@debian.or=
g> wrote:
> > > On Sat, May 11, 2024 at 02:25:53PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > Thanks for asking the question, I'm dropping the patch, Breno, can =
you
> > > > try again?
> > >
> > > Sure, let me think about it and send a v2.
> >
> > Thanks Breno! My bug, thanks for digging into this.
>
> How about something like this:

Looks good, could you send as a v2 and I can test.

Thanks,
Ian

> Author: Breno Leitao <leitao@debian.org>
> Date:   Wed May 8 06:35:17 2024 -0700
>
>     perf list: Fix the --no-desc option
>
>     Currently, the --no-desc option in perf list isn't functioning as
>     intended.
>
>     This issue arises from the overwriting of struct option->desc with th=
e
>     opposite value of struct option->long_desc. Consequently, whatever
>     parse_options() returns at struct option->desc gets overridden later,
>     rendering the --desc or --no-desc arguments ineffective.
>
>     To resolve this, set ->desc as true by default and allow parse_option=
s()
>     to adjust it accordingly. This adjustment will fix the --no-desc
>     option while preserving the functionality of the other parameters.
>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
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

