Return-Path: <linux-kernel+bounces-564576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F95CA657AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9564D16CCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057551922D3;
	Mon, 17 Mar 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4SGblc43"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0219048F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227843; cv=none; b=fYpY4uuJTuRptlaJhrUi2CgS6Bpb+n8ErxgqAJRptpG6Qsf+zNmjeKHaOwQec9Gzg9M3r4rXWEI5EXId2KFOheYzkGpYk+SWn8dGPSNz8lTeQjLA7G586CNdiSzgoFj97CCpMrj6J0DzezApHOtiCmgaDbPgFiDp9u+4exLEdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227843; c=relaxed/simple;
	bh=h1HX52WVSfCd/vFf8OXw8LFNOMMTKRgfja2DL2tQ7ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwozATXXCNE0RoruYYJYfA7/GoFrsKwkgeB4bOzU4htFHK5XGrt5h06o4Ld0p8EH5BdnpSg7qfs8cC+DJJVyPblAx2Wf+1+m1S6DMZk2Fc3ZWycFSOWP/PCvKz7MqHPMiouaiFoHRLGOB082VONznnzqtSNNrstswYMoLvm+hOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4SGblc43; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-225489a0ae6so42205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742227840; x=1742832640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DvKgDiFuVPnQfg+ceHEVlgMkuHE4w+BuHOV13uh3LU=;
        b=4SGblc43thxAGEUsTA3KNeyxqD15gzRe4pnDYMza8Wevuc30p0b1u0P86w4Le/+Hnq
         Y6y6aQXa9o8KV8jpbRlHPmy6Om2TQUNLACR7lJajfu6zVZm7FqtRledM/GOVlA9e/Gui
         45jTWI1Uwidt27yf/03gXtjoxgX2MP2E3ioG79OKsZGHq6ZTRGB9iPqtxPzzZ/+SAG93
         s/p4BlaClR/fGKwD2SJsl5ge3HM2MzxCWlvUL6Nu6emSS409K1qRELWVNbbMuhr98/x4
         ZHcVge676rd6qAgomfjTm1J2IidAFDaVcAwAUbozzYqMUPrfVcz9g20mlZNSwMLHdcR6
         ZJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227840; x=1742832640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DvKgDiFuVPnQfg+ceHEVlgMkuHE4w+BuHOV13uh3LU=;
        b=INWptEWm7668VY2uNH5hgABT0Kw3X4hwr2a9WXVSwzlw8hYPSqJ7x7KkcLXhArzhef
         h5iEXPHRE99ZwccWxTkU+eko4rccFV2Q5rjOAT4QiLnud5lU81++R4BnKvlCpNQvA2en
         PVyOgvRYsE4tn5I4p/mRjxdyMPrKiJ6UK2fn6t/P2/899unJp0h2Wt6cXG4lls3VN6GF
         Z51vWeqlzr1Aj8Itxi1XalDmvfxU3SD00q570tZWVhUN3gA4A/AJyCPNb4oJEhoWppyO
         wzb4jplWJl5hM6sGBC6aiT9YAitw8KPuaAydhPdJ86r4e4LPacwSjevhUC2eLA8a7qns
         FhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVteFdMEWGbAHk/+yFRWOtVrmjXiSYzOHVHGXviIFOQsBcEnhrXFcXN/y/iOiwy9nZAKYodyfvK/yKL1R4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhq8CgPqf31I3PSaRjVbWjaxcfEOYeySJzDEawoI/H59B6KxY4
	sEeeN5sNEveLFhU5XSHlY4OJdj91QOkGVcd41PFYn4NQ7PYx5doHc8Xrj4XKgzeFzVCMcIqgDZC
	e/7pfypiJdPRj+wn1Vzkpa16FRAQOI7/i0HmgUzCtQot81CcG1Oqv
X-Gm-Gg: ASbGnctiPMTQnjpwXle8hbG3c5uYXs2oKM6m4n4p33xe/s7/hQR/CEx++1M7Klua6WU
	hYwaHpcVTjTuI4HTidpvAk9wi/bQN7fKwUi90gCypez6Mjh6RCI8Jw8ERD/trrcit7SfE8EZ9+/
	9PDj6auZ4hdnb9Vt1CCUqswh3YcnNryO8/diUpGbbo44JgkwBE9BF8Wc6twYoqcoJb5Q==
X-Google-Smtp-Source: AGHT+IGeAR+kboapMmrI0SfAf9umNYS8qxnTewPO2Hiig9OJgjhMXcEEJe7y4RMtQNgysDaOlB2OxIDqA72esNDwUIU=
X-Received: by 2002:a17:903:41cc:b0:223:37ec:63be with SMTP id
 d9443c01a7336-225f3c14de3mr4520955ad.4.1742227840351; Mon, 17 Mar 2025
 09:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzpfAUi8zeiFOp@x1>
In-Reply-To: <Z1mzpfAUi8zeiFOp@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 09:10:29 -0700
X-Gm-Features: AQ5f1JrEeD3OpKfZTGEdcDO24vz4DHfLcO2IC__rF2ZvyedwJ7qT6NXJ2L6tJ3Q
Message-ID: <CAP-5=fWqpcwc021enM8uMChSgCRB+UW_6z7+=pdsQG9msLJsbw@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] tools build: Remove the libunwind feature tests
 from the ones detected when test-all.o builds
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 7:45=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> We have a tools/build/feature/test-all.c that has the most common set of
> features that perf uses and are expected to have its development files
> available when building perf.
>
> When we made libwunwind opt-in we forgot to remove them from the list of
> features that are assumed to be available when test-all.c builds, remove
> them.
>
> Before this patch:
>
>   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=3D/tmp/b feature-=
dump ; grep feature-libunwind-aarch64=3D /tmp/b/FEATURE-DUMP
>   feature-libunwind-aarch64=3D1
>   $
>
> Even tho this not being test built and those header files being
> available:
>
>   $ head -5 tools/build/feature/test-libunwind-aarch64.c
>   // SPDX-License-Identifier: GPL-2.0
>   #include <libunwind-aarch64.h>
>   #include <stdlib.h>
>
>   extern int UNW_OBJ(dwarf_search_unwind_table) (unw_addr_space_t as,
>   $
>
> After this patch:
>
>   $ grep feature-libunwind- /tmp/b/FEATURE-DUMP
>   $
>
> Now an audit on what is being enabled when test-all.c builds will be
> performed.
>
> Fixes: 176c9d1e6a06f2fa ("tools features: Don't check for libunwind devel=
 files by default")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sorry for the delay on this.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/build/Makefile.feature | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index b2884bc23775e986..9cde51104c2d70ec 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -90,13 +90,6 @@ FEATURE_TESTS_EXTRA :=3D                  \
>           libbfd-liberty                 \
>           libbfd-liberty-z               \
>           libopencsd                     \
> -         libunwind-x86                  \
> -         libunwind-x86_64               \
> -         libunwind-arm                  \
> -         libunwind-aarch64              \
> -         libunwind-debug-frame          \
> -         libunwind-debug-frame-arm      \
> -         libunwind-debug-frame-aarch64  \
>           cxx                            \
>           llvm                           \
>           clang                          \
> --
> 2.47.0
>

