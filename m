Return-Path: <linux-kernel+bounces-382941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A4B9B1544
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D5B1F226EC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD65616E87D;
	Sat, 26 Oct 2024 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REgNS7Mp"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA02CA8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922464; cv=none; b=mYXmypBq5Cnj6p7OkjQx56seIq0E/jP1CkeI3cURfLVoYzULMZ3MVJQSk8SS/o/gqtEhs6YPZOtoQE0k46e5HWUxYBWdoAcvGlAlv+cbt0QV2ewNw3KQZn4lVpcx6oqc5dX7ezq4UbVg6qvNHL7YEEKBkU+9jPCIt+cgaBY5DQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922464; c=relaxed/simple;
	bh=7JvFWgVmMfRj8QJwNhEkHE3aZfXZVob8aXaoiQRG/1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUEHzWrS7Q7r2mKRccPmwmLiBPo+KxtD2o4XwHFutcwoM+VrK7+WboJfKaJdGqeBpB+unv24uH2fUVUrIrCo2dMAivhI0P35jWokLs8kdYArKEp+GU7aLaI5CeC11ciOns1Je2BHyvT/XsWICMaoueigIv+fZ9uehKe60eQDPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REgNS7Mp; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso151575ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729922461; x=1730527261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+zM/o1HPfVNQxE5xJxVZGYmV9NlUYpQZjG/tkj+oJE=;
        b=REgNS7Mp8k9CaIw8c6r85QLrIyuZ8IyVG0L3NlYf1hK41Z79EYiG5S3xihEMVC8Pcj
         RbxYYuU1jiAMNcdAfWgmBqONCfNbzxEl/IeZPnZ1OyOW2zJovmQvdNTEjEGkMZvSl7kI
         Zz7M64LsNLx+1GIvMic5vK/5AMtMB5v9Ysoqgu07cnN/IYeBgu+tkyYyAitClLy/Fwa+
         gkEzKFMkPniOZaobD3VS4QOkWRmzmrGd9dbvy65NBlQ/F2CJBoMejZX0Ot7wtZffezl1
         WIugJF2GLEN1IVrH96PW+ghh7zxXyxOmMvEomUsab6EWQdTAjCYv6Q2II1WTFg9zax0/
         RpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729922461; x=1730527261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+zM/o1HPfVNQxE5xJxVZGYmV9NlUYpQZjG/tkj+oJE=;
        b=w1ewOW5cbuA4RyJSc8RhSl8mAbN2LHKLr43eEu4UXdhV+FnDUQVIB1dD0GwDTHUr0s
         hWOwGfmfuqKjYAu2D/HFHa1233VfmxFGg++6XM5PNErwgvPNXStHUP07/uBrSjPmngS2
         pALJe/GDcY56E2k85BOr8yQcY5oYS9FI5QkubPYx8piAFjPONQybdjbamp6/Yzvqic//
         Qc/kzFGbwHaGhBmYAKaf8LJeNsMuNFydTN0Oq1RldYaLiLawnjQ4hZaPw1avTuzyHys/
         XMUM2Jl+xrad0tmwWiB5WPrmHn0rzzJRu5s6ruafMi+2AvTw2da7bFTn4+uOuZwSQ6xM
         qlYw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8g+yOnTu12WPWprXPCgRBmQp7tcds3yjFskXZ14tvW0lZRIXUF8QbSpUn4yO8ax1nx+RGefgo4RSyKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSr9Nbbb4HNvwvwAP9gjtZSb8Te9SCkE3aVcuztGRZn1Dn7Grv
	u8UGQWXdtCoRrYXxNCi/fwuNN3HilG7SkGqEXuGPFzeDFtEGf0YlxHS7fBZLqLtbpjQRH5qSZGC
	oSsG2xjq42WoSBsrXGJIMh3i3OBCwfqJVoWnd
X-Google-Smtp-Source: AGHT+IF8XBaFLLBsLaAIhRDGMNkDGbjpTa9ux2fdc1a/xhLMT5aG7FYFFsHx2L0Ja+nE8hh+E7j8zwedqyui8XmvBfk=
X-Received: by 2002:a05:6e02:1c26:b0:3a2:6d54:33f1 with SMTP id
 e9e14a558f8ab-3a4ed2cf72dmr2086155ab.16.1729922461172; Fri, 25 Oct 2024
 23:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026055448.312247-1-irogers@google.com>
In-Reply-To: <20241026055448.312247-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Oct 2024 23:00:50 -0700
Message-ID: <CAP-5=fXLL1dB4MEfe7Z+fhp_RzC9DV91gBLBHjjywW-_RXmM-Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf cap: Add __NR_capget to arch/x86 unistd
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:54=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> As there are duplicated kernel headers in tools/include libc can pick
> up the wrong definitions. This was causing the wrong system call for
> capget in perf.
>
> Closes: https://lore.kernel.org/lkml/cc7d6bdf-1aeb-4179-9029-4baf50b59342=
@intel.com/
> Signed-off-by: Ian Rogers <irogers@google.com>

Forgot:
Fixes: e25ebda78e23 ("perf cap: Tidy up and improve capability testing")

Thanks,
Ian

> ---
>  tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
>  tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
>  tools/perf/util/cap.c                       | 10 +++-------
>  3 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86=
/include/uapi/asm/unistd_32.h
> index 9de35df1afc3..63182a023e9d 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_32.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
> @@ -11,6 +11,9 @@
>  #ifndef __NR_getpgid
>  #define __NR_getpgid 132
>  #endif
> +#ifndef __NR_capget
> +#define __NR_capget 184
> +#endif
>  #ifndef __NR_gettid
>  #define __NR_gettid 224
>  #endif
> diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86=
/include/uapi/asm/unistd_64.h
> index d0f2043d7132..77311e8d1b5d 100644
> --- a/tools/arch/x86/include/uapi/asm/unistd_64.h
> +++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
> @@ -11,6 +11,9 @@
>  #ifndef __NR_getpgid
>  #define __NR_getpgid 121
>  #endif
> +#ifndef __NR_capget
> +#define __NR_capget 125
> +#endif
>  #ifndef __NR_gettid
>  #define __NR_gettid 186
>  #endif
> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> index 7574a67651bc..69d9a2bcd40b 100644
> --- a/tools/perf/util/cap.c
> +++ b/tools/perf/util/cap.c
> @@ -7,13 +7,9 @@
>  #include "debug.h"
>  #include <errno.h>
>  #include <string.h>
> -#include <unistd.h>
>  #include <linux/capability.h>
>  #include <sys/syscall.h>
> -
> -#ifndef SYS_capget
> -#define SYS_capget 90
> -#endif
> +#include <unistd.h>
>
>  #define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
>
> @@ -21,9 +17,9 @@ bool perf_cap__capable(int cap, bool *used_root)
>  {
>         struct __user_cap_header_struct header =3D {
>                 .version =3D _LINUX_CAPABILITY_VERSION_3,
> -               .pid =3D getpid(),
> +               .pid =3D 0,
>         };
> -       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
> +       struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S] =3D=
 {};
>         __u32 cap_val;
>
>         *used_root =3D false;
> --
> 2.47.0.163.g1226f6d8fa-goog
>

