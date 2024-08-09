Return-Path: <linux-kernel+bounces-281495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F359094D77B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3CA1C21700
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BA15FCEA;
	Fri,  9 Aug 2024 19:40:02 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522E3381AD
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232401; cv=none; b=tPSlwJlBjfgnhqDS9SmivKxKN1UlzykRrelzjmnGl/zAGB6/M+FsYX8v2Z9AolFTdYo5JcbtVVQ/Ktb+RV3gwMACY103ZT9urCM0Ybt1mkJ5MR3cDd/dQO5tMlZ6Rm8HwEkF8zHgIJzFxsFhdxwlizSN+PNY2cu3ZjMVxdrEya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232401; c=relaxed/simple;
	bh=AwapjTFFhp3dFbRVbLgG7aYAQRlwvpNz0qSnFdm9RMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXmaXtcU2HC4v1nwYbC9lQmUlbkByc02CfH2UO7/Vc5q9EqhxBsm082O/uiigjPTbnVqIvhrRUkADbd6CKvU25OFeC7D85K9FgsvIYqkYaSs3aQllvPjD/z2fgD88lJOqakqnw1NJKreeO4dAYMM1+8CSVhrc8I/IbVJqcSYKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so1809520a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232399; x=1723837199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1Qn8YPFxnx8TAiNeYXz9KAEVqW09rM5irsn7sT330Q=;
        b=EHSq7ztES53cDh0p2Y4tamcZJXo0I/jSx5b05GoTP0ACfctU3kAMcCcTQ2M4fOHKSw
         RW4PmdTwM6dcsxggLOgDSCeRtVGSMRjhLWB79PPxuR9VPJ7vXHiNyhoVVgMwzJ0VHycJ
         KdVT6V5qHaIrzVQCNwxQQ9zdgTFXHAU5q80bYzsvCgGRgYxQDdMcZ1fmnW48Ef8DQOpK
         nYkbO9C0GbPgDGprP5zjb3hu10tMgNTQhvFIGtX/MD1FXD8cXUxu94kcRpYlTuwZpwii
         tmvAwvHsuUV0IOsQ9JfpNcSO6+shF5QUhFbyHv4WZ8vl8bk7l7HuvZHsfffpBv25NFwT
         BARw==
X-Forwarded-Encrypted: i=1; AJvYcCVhhC6TeEDyp6jp52wKSOsPywS/ZPL2qb8tVFdy/U24JuIVWdn3kCqPcH/uI9QiJ7D4JaiBeaH3iNGTFwP/aUfkK0AWcwO3/s0yKuu7
X-Gm-Message-State: AOJu0YxeERlJgPVDxo1p8640+K64FavcjAqIdYOGuupuEKoU+0ipbHhj
	sCk5aJGkNnNMYtaLyWsMaTlJHlrMbD+PnHq0YBOfdoYqUtcqpMW8wwO22zhXsr8vvLd4yJj+WsP
	15EltUpX1MjNreBtyVuWdfVVJvv4=
X-Google-Smtp-Source: AGHT+IHZLD1Vl+hkAFqTypDM6YJhE/E932sfrVijCNlr1tRNMPomekkC3cYsV2TX/JFvjKl+AWLLfVccvRNLfasKCLw=
X-Received: by 2002:a17:90b:14a:b0:2c9:7ebd:b957 with SMTP id
 98e67ed59e1d1-2d1e7fc6036mr2696515a91.11.1723232399325; Fri, 09 Aug 2024
 12:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrYsDYh2VVmh3GMw@x1>
In-Reply-To: <ZrYsDYh2VVmh3GMw@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 9 Aug 2024 12:39:47 -0700
Message-ID: <CAM9d7ciushSwEfj7yW4rtDEJBTcCB991V4cswwFEL+cv6QF2pg@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf debuginfo: Fix the build with !HAVE_DWARF_SUPPORT
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 7:47=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> In that case we have a set of placeholder functions, one of them uses a
> 'Dwarf_Addr' type that is not present as it is defined in the missing
> DWARF libraries, so provide a placeholder typedef for that as well.
>
> The build error before this patch, a static build out of 'make -C tools/p=
erf build-test':
>
>   In file included from util/annotate.c:28:
>   util/debuginfo.h:44:46: error: unknown type name =E2=80=98Dwarf_Addr=E2=
=80=99
>      44 |                                              Dwarf_Addr *offs _=
_maybe_unused,
>         |                                              ^~~~~~~~~~
>   make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build=
:106: util/annotate.o] Error 1
>   make[6]: *** Waiting for unfinished jobs....
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

> ---
>
> I have this in perf-tools-next.

Thanks,
Namhyung

>
> ---
>  tools/perf/util/debuginfo.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
> index 4d65b8c605fc5445..ad6422c3f8ca3ef6 100644
> --- a/tools/perf/util/debuginfo.h
> +++ b/tools/perf/util/debuginfo.h
> @@ -40,6 +40,8 @@ static inline void debuginfo__delete(struct debuginfo *=
dbg __maybe_unused)
>  {
>  }
>
> +typedef void Dwarf_Addr;
> +
>  static inline int debuginfo__get_text_offset(struct debuginfo *dbg __may=
be_unused,
>                                              Dwarf_Addr *offs __maybe_unu=
sed,
>                                              bool adjust_offset __maybe_u=
nused)
> --
> 2.45.2
>

