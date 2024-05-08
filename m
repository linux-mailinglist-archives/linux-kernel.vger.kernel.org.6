Return-Path: <linux-kernel+bounces-173824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B68C0603
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CE4B22C95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C4D13174E;
	Wed,  8 May 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDcUjMP0"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB1131748
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202312; cv=none; b=HoBVua02Umyu/7sX5Tf7i9nhiEGYtUuFI2U++rFozV88D/yfOj0QvvsHE3jM0tR6flLM0mQCQ1GYvFRD4cv/2dNsYrTnprrIvHxpUPg8t2Nm10spQdeMMPL22slWensx2eKlrsXXfLGxVGdqTvMwk2hQlEca9+TfRc1ifH1bIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202312; c=relaxed/simple;
	bh=acPOrt5ygOuLSWdIDxURBep5aeWaEbWmyC8ArTfUIzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeMv9SwtoDcCycIUs+sPORZOqFIkoDlkprUfwoR9anfdjkFjsvPomsNusNqnsiA3S66zyp3jEK4bWjCbsbUYGIAMbrMdSJGHhJ62jwvM4mpVa9/c1VHS/LxRoxoGVdO1MyomXTiYuKlFz+07p/I/q/vXgOoCsft5G9EgZP57X54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDcUjMP0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43d55133609so27271cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715202310; x=1715807110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TacJSNF5BN2EAxFL9AKWhV4ZHViuaAA6IA2uXpBpZ4A=;
        b=UDcUjMP059S0qfM8G0gPAy0b6NzzBjUSPK9O4x/hS2yTDamtlet9OEsRRdvhk3FmEq
         3yQlh2UEMHQj+VktSu1KtOJAWCDPOAqppk9+MYj3VYYIrvXf+JpEDp72HPT+wH7uFq/t
         Lfir/poV2aZp/tNF4qINkQUO9R8nVDQlSbCJ6/MLTkVAkfz8YZxTqE36PKZEFT3ky2Ny
         xFuPxEpkmjt1wlLi4/9Atjxz8tvq1nPsfuPc9a6Prl4HpeD0df9H4fk+hTRTSRgM5bwI
         /SxTZp7qjsoB/lHqz3r62E3dgbeCCheyYQAzvwHAMYzfYxwLDGW8vuZW0dqviEp1usGg
         CGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715202310; x=1715807110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TacJSNF5BN2EAxFL9AKWhV4ZHViuaAA6IA2uXpBpZ4A=;
        b=jZY4Jd8CPUD9lW/zRK9Shwh129ojNfWruE619xwU50SIPhcg7UvVPLwhIuh+HYlypo
         N5S/aU0tULelTPulKG65iH5aToVz8jDZ98StnGps9mzit4sBNZtwbqVG0RFr5MLC6bGw
         9B0opN1h0bbjcu3k0xPFi9hYgEx2PAoXSugCMEIPu6Fr9Nn1RvGMZYZWoIxxqI2BJ9UP
         mAuZWep06YlklNBKGXFgpIeUyZSXEDDaos5Jejmo/qcdOelUEbqBo8MqgeXhg/2W/3MI
         KJA8sqIC+Hx6rC5Nb+Stw7rEmkmK5uCsMwjiscpzEXNympQGs88I3k7JNmS0fLigdMfs
         MvTA==
X-Forwarded-Encrypted: i=1; AJvYcCXnEMguPxjp84NjJhXttQcNh159/juht4luWDUk+vqimpvq3+Se+f/ihmmPPRLhtx6z2XhhFBFnpJTE5WEi7IGuLTm4z1a6VcpPz7tW
X-Gm-Message-State: AOJu0YyruKCqhaeaoIsP1NqYmO90m73Aa0LFZiffsuw2SRk/1w1Wk4a8
	u1SbpO0F2P9JbASoRA7No77NIyLGmWFy/qj0WAzyLntmKiQlH36MtE7rvhR1O5ohcgswE4M65iM
	sAuZX/o/I9fNbT3ITtATJ5XyUvanc1AdiRIVp
X-Google-Smtp-Source: AGHT+IFvobua1lHMqFYihk7ouDMB2WgA/Rvw6k0MPR3M7p9JACNrEdSUwgrBMtK4o63XOSjNDnEJWOts6YT31OesJMU=
X-Received: by 2002:ac8:6f1b:0:b0:43c:de95:6258 with SMTP id
 d75a77b69052e-43defba092bmr1126521cf.18.1715202309981; Wed, 08 May 2024
 14:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508141458.439017-1-james.clark@arm.com>
In-Reply-To: <20240508141458.439017-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 14:04:58 -0700
Message-ID: <CAP-5=fWMbLDmT8=h_He7+9V+ntTdg1+5hmSTm87VJsTy2m3Bag@mail.gmail.com>
Subject: Re: [PATCH] perf dwarf-aux: Fix build with HAVE_DWARF_CFI_SUPPORT
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, leo.yan@linux.dev, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 7:15=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> check_allowed_ops() is used from both HAVE_DWARF_GETLOCATIONS_SUPPORT
> and HAVE_DWARF_CFI_SUPPORT sections, so move it into the right place so
> that it's available when either are defined. This shows up when doing
> a static cross compile for arm64:
>
>   $ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- LDFLAGS=3D"-stat=
ic" \
>     EXTRA_PERFLIBS=3D"-lexpat"
>
>   util/dwarf-aux.c:1723:6: error: implicit declaration of function 'check=
_allowed_ops'
>
> Fixes: 55442cc2f22d ("perf dwarf-aux: Check allowed DWARF Ops")
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>
(eye-balled to see the #if problem exists and this is the correct fix)

Thanks,
Ian

> ---
>  tools/perf/util/dwarf-aux.c | 56 ++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index c0a492e65388..c9584563cd56 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1215,6 +1215,34 @@ static int offset_from_dwarf_op(Dwarf_Op *op)
>         }
>         return -1;
>  }
> +
> +static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
> +{
> +       /* The first op is checked separately */
> +       ops++;
> +       nops--;
> +
> +       /*
> +        * It needs to make sure if the location expression matches to th=
e given
> +        * register and offset exactly.  Thus it rejects any complex expr=
essions
> +        * and only allows a few of selected operators that doesn't chang=
e the
> +        * location.
> +        */
> +       while (nops) {
> +               switch (ops->atom) {
> +               case DW_OP_stack_value:
> +               case DW_OP_deref_size:
> +               case DW_OP_deref:
> +               case DW_OP_piece:
> +                       break;
> +               default:
> +                       return false;
> +               }
> +               ops++;
> +               nops--;
> +       }
> +       return true;
> +}
>  #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
>
>  #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
> @@ -1395,34 +1423,6 @@ static bool match_var_offset(Dwarf_Die *die_mem, s=
truct find_var_data *data,
>         return true;
>  }
>
> -static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
> -{
> -       /* The first op is checked separately */
> -       ops++;
> -       nops--;
> -
> -       /*
> -        * It needs to make sure if the location expression matches to th=
e given
> -        * register and offset exactly.  Thus it rejects any complex expr=
essions
> -        * and only allows a few of selected operators that doesn't chang=
e the
> -        * location.
> -        */
> -       while (nops) {
> -               switch (ops->atom) {
> -               case DW_OP_stack_value:
> -               case DW_OP_deref_size:
> -               case DW_OP_deref:
> -               case DW_OP_piece:
> -                       break;
> -               default:
> -                       return false;
> -               }
> -               ops++;
> -               nops--;
> -       }
> -       return true;
> -}
> -
>  /* Only checks direct child DIEs in the given scope. */
>  static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
>  {
> --
> 2.34.1
>

