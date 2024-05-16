Return-Path: <linux-kernel+bounces-181560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA38C7DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1B1283136
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028A157A58;
	Thu, 16 May 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oi7lDsma"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487E514D719
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715890537; cv=none; b=nUlwtQ6e7Sb9i0pQtfbAd30QIO0l92YLoiatUjfUER0L4CCYI6Pc+ZYOT65MAQXhK7PqsdQhUYt9KAuLHxTlmDaa79eM69sfWQWDH+mddh6T47XT+jNM2NeBnmW3MmpzHYkPZtqmk6h3ja9zimRkLx38z2NPP+108BvZfynXpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715890537; c=relaxed/simple;
	bh=Qt7XCwY8p/9Zk/BtJHJFIPCntxonj2BQEpo1pQ9p04w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmlAxirOwpiyxyHZeLiFtCYxX19kvmJ2eSBRj56iX+pe/okffwRU4bVxjosnZ4v0gs7BmEY9mm7eRy55/ppzCMgNOS+G4wapOr+K/LEhaNVjRF6E68JcphcB+7Zul5tLMZ/Hd+i1AbdoBOH2QkKHmNHPvf27Q3vkRx10lTFkx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oi7lDsma; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43dfe020675so126861cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715890535; x=1716495335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMwj4gir20V16kzbSN+f5cWTPG9oHd0AnWI9F1gYeHw=;
        b=oi7lDsmaG+TvtHANdh6GIWkVzRk641YCN/m9B7XIOZreuL/hp/2lMxUcQyP+LDPNyZ
         20XIsPC0kAXMXVSayf9cMZz9rmvdRYe+M6H8LfoC5HzCaDqd1dOsa39VdDdiFHK1wk3E
         mN4RxonF9lePq/0n8xbHyK1J+PS7ZWcAIvHgwUC1IJ73uEaSTA/XXB7Y/9lwGtun8Qge
         MmLqZavRTbBJoVg0HsxiK60h/QAErgjXI/ClvnOqnVabfsd5ejDbItGtbirg5i/qzoh9
         wb9fkijfld9S6Xm6G9Jz5LWIJwrgm0V8dFcRmvmnrIlq4kty7iKhQxSo2v9+9LXzPB1I
         iUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715890535; x=1716495335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMwj4gir20V16kzbSN+f5cWTPG9oHd0AnWI9F1gYeHw=;
        b=I8P2t2RZ/2pvvVM3yJ0KerEjtCmTc6qtqKgOxk2AD8eXU88p7umqRzh+b32hW/zxIi
         dxWhiEi5nbyz2Xm5744mV8fajARCxDFmsM6yB1hAFfu55x7PTmsNoikrYJ4RBJb4wNra
         SpEfSPZ1pIZCyEiJD+cbdLMGmoW9roBndlDLsLohZydEdRS5JeHMzmfcB10ifO1EI+Lx
         fnNUKFzxmgGdHKnzzE0Bp8CL7sFAqIr8vQaoCEIfwlyASp0Wnx69YooQZ4CZDscErsCv
         UvNHaHu3NhwX/jSc8JFG25f1HzJA8ylan+yelk+RtsmbmHCqCKapX75yfXvsTvwKEe4f
         Gh8A==
X-Forwarded-Encrypted: i=1; AJvYcCXLv0QfqF60wdRQUtQZk1tgAS0RrZWLqmhFbW8YdnFnzMUZ6z1RojcgcgGoAN6qOWahxYCg7LqONVtkvQuoGLVYTFpGPvRwzuJd2G2A
X-Gm-Message-State: AOJu0Yy2SvPzg0SZwSbKuQ6RFO01SdYVLa4u3HTO5lzrM/660ms0z29l
	EFbKlNzye97YGGdwoIui4o/c6Clj7FCcLglTDj55/3sVaLys/Hx/jrk++1J9DVQT0pmepBNzpCe
	6VNfJwM1pMhcdzr8p9JFBSAX4HxQ5IOVRUaDf
X-Google-Smtp-Source: AGHT+IH6yp4o5lX31QO6woiYNeHL2qzRI8CzXLf0rXFD+zfnxhrqKEMKd5yId/lQeNGrZSF7XBRt6vcBXNvytdKtU2U=
X-Received: by 2002:a05:622a:838b:b0:43a:aa3f:917a with SMTP id
 d75a77b69052e-43e442e044cmr382311cf.27.1715890535057; Thu, 16 May 2024
 13:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516131544.2885917-1-leitao@debian.org>
In-Reply-To: <20240516131544.2885917-1-leitao@debian.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 13:15:23 -0700
Message-ID: <CAP-5=fUaUGJ-09N-u39YyZgJOnj_WE91-hUc8dv+tf7ozA3K2Q@mail.gmail.com>
Subject: Re: [PATCH v3] perf list: Fix the --no-desc option
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

On Thu, May 16, 2024 at 6:18=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
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
> v3:
>         * Applied the same logic to default_print_metric() and
>           json_print_event() functions, as identified by Ian Rogers.

I don't think we should change the json behavior. We're generating a
dictionary and the consumer of the dictionary isn't obligated to read
all of it. I tested the non-json output and it all looks good.

Thanks,
Ian

> v2:
>         * Do not print desc if long_desc is being printed, as identified
>           by Ian Rogers.
>
> ---
>  tools/perf/builtin-list.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 02bf608d585e..8a0e123587f3 100644
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
> @@ -243,15 +241,14 @@ static void default_print_metric(void *ps,
>         }
>         fprintf(fp, "  %s\n", name);
>
> -       if (desc && print_state->desc) {
> -               fprintf(fp, "%*s", 8, "[");
> -               wordwrap(fp, desc, 8, pager_get_columns(), 0);
> -               fprintf(fp, "]\n");
> -       }
>         if (long_desc && print_state->long_desc) {
>                 fprintf(fp, "%*s", 8, "[");
>                 wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
>                 fprintf(fp, "]\n");
> +       } else if (desc && print_state->desc) {
> +               fprintf(fp, "%*s", 8, "[");
> +               wordwrap(fp, desc, 8, pager_get_columns(), 0);
> +               fprintf(fp, "]\n");
>         }
>         if (expr && print_state->detailed) {
>                 fprintf(fp, "%*s", 8, "[");
> @@ -395,17 +392,16 @@ static void json_print_event(void *ps, const char *=
pmu_name, const char *topic,
>                                    deprecated ? "1" : "0");
>                 need_sep =3D true;
>         }
> -       if (desc) {
> -               fix_escape_fprintf(fp, &buf, "%s\t\"BriefDescription\": \=
"%S\"",
> -                                  need_sep ? ",\n" : "",
> -                                  desc);
> -               need_sep =3D true;
> -       }
>         if (long_desc) {
>                 fix_escape_fprintf(fp, &buf, "%s\t\"PublicDescription\": =
\"%S\"",
>                                    need_sep ? ",\n" : "",
>                                    long_desc);
>                 need_sep =3D true;
> +       } else if (desc) {
> +               fix_escape_fprintf(fp, &buf, "%s\t\"BriefDescription\": \=
"%S\"",
> +                                  need_sep ? ",\n" : "",
> +                                  desc);
> +               need_sep =3D true;
>         }
>         if (encoding_desc) {
>                 fix_escape_fprintf(fp, &buf, "%s\t\"Encoding\": \"%S\"",
> @@ -491,6 +487,7 @@ int cmd_list(int argc, const char **argv)
>         int i, ret =3D 0;
>         struct print_state default_ps =3D {
>                 .fp =3D stdout,
> +               .desc =3D true,
>         };
>         struct print_state json_ps =3D {
>                 .fp =3D stdout,
> @@ -563,7 +560,6 @@ int cmd_list(int argc, const char **argv)
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

