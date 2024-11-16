Return-Path: <linux-kernel+bounces-411860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD549D0083
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68449B24A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52EB192D67;
	Sat, 16 Nov 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrQ6FJYG"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF0A47
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731782267; cv=none; b=qqrbQtJFI9AQIYSfP3yYFcQwRC7JSuZ+6YiCd6isegI3FxKlP8hglmqFoFbv7tL6PY0rANpPP95+xFrmmLmpiDpX4yLBawLVDIGtTncURtZ7p4EAFTB96/n9Lix36XeVV/iFYDE4goP4k38tdv8ZyUz2IIxlYySgruPgu9ULkkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731782267; c=relaxed/simple;
	bh=EuVvZndbJbLCbkw/jVWTOrqaNxG+iFovwa0e+HK6+zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfgGTheYK7a0MKfuyegNwmZZY13dKF57Zbm2YpI+TJ/bZvW8gQP4c1fcl+phoelNEl2MrHLIHxaxoPydl1QHlXfGIErcF4PrRKi7Az55sFGDWT8c1JBeiadPSdW2/QjbPFUurXiJlCuoZY+975shkqUdROtxu2oGA4YtQs+Bdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrQ6FJYG; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a761c7c496so2835ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731782265; x=1732387065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct7dWEryvMDfH1sRvyaI/rpEKv5TjVF/tJVlscy8fBM=;
        b=UrQ6FJYGgRToACPJ6w0SQ1BQ6YGfFNplAmLP0uzBM68nt3Lp6cI/NbixWCNZsi2Eep
         Jv6jrP+RYGqZpy0s6luDy9fjut6y09y9b88htSuzKnPAvau01avwzBGfj4Fco9TU5Riq
         BAsu8G1cieYOPQAwZ/pfZ35uzcZB5wbQ1ubSCTbUHHYlinEyhRaBGAOHHZLY+6ewxqk6
         cBlLWlFmXSXd5ASxmkMHwndwKmPZUCVyA2svsaXil4wrFYPHnzIS8M6rJsoSq61fNZj2
         o4xdmeVNGNa6dtFlWpJA4o7LEYscjIaMiCDUAV9ZBO/ta42K+5Q4H/D3P71AaIlaH22M
         bWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731782265; x=1732387065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct7dWEryvMDfH1sRvyaI/rpEKv5TjVF/tJVlscy8fBM=;
        b=hQPKVhsGt1nUaL9iNp/pMEQLh83e76Dw7J55ODBUpk+RipyXlWAyvTHveCbVusvfCC
         kxg0D7divF5Trd5uxyBF426x7oaDWkRausl4ps64/OL+wIkSTizWXQG0cj7iIyJt3HUA
         7QU/dHXQuFWY0Chxq3rx/AKhCtL/7yYtl5tyKrASLQVgZg6KrcKpE9oeRjj9kUZPJdCv
         4i85aLEXFnKQ8ZdK63q4TTmfENXBjMAA6MBwSMF3BdyePdsocQ9IwL+vRjCOXDvVIzk9
         t3VyD/a6HK3/iUUK5qHe+7ew9WtMfS4OoIkOrDJ62e0nzss246eWVbJmhjVuY2iR9R5s
         tfDg==
X-Forwarded-Encrypted: i=1; AJvYcCWjcgl+FG/rxHr7slmxb1YuIWNBPN1l9K6QhUTcNB31a6gIS1fBSHK+l7AxJ6FFF6Vdv4uJ4IrJ1LmxWX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYnCd5bUh9ZX+VM9EbykW2NjGk8gwmgVKslJfN2lI7IBFV8bx
	0ONxVoOxCxn4dB10nW9hRSMGuWACsFfc1BprA1RZPh9RE6cQrNGKC0jxN9F2I8Xc0bw7K+is4Mv
	qaoSh3L+ZjbEBSoSAzQVEViq+8cQs9Szpb4ds
X-Gm-Gg: ASbGncspxqq93sB9OkjqWz1mtqA5jrXT8IBq2+uIKI3za+Px1ChofRNqMmmCsivKPvB
	CCVZ9U54Q6iIVHs4yrOHm9jaUAsWKHpUF
X-Google-Smtp-Source: AGHT+IFaZTQ5zPAocYt8kqY+sKAsQpnFpg4ANEp9NJJsjwgwEVw/Id0rLAsqpRi6pgxDSGeB1E51/3JmCjaS+FESOdw=
X-Received: by 2002:a05:6e02:b4c:b0:3a6:f215:c5aa with SMTP id
 e9e14a558f8ab-3a750c61f8emr2428345ab.14.1731782264632; Sat, 16 Nov 2024
 10:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116155850.113129-1-linux@treblig.org>
In-Reply-To: <20241116155850.113129-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 16 Nov 2024 10:37:32 -0800
Message-ID: <CAP-5=fXqig=qHAa26d5-8pHPCtS0ZyCNs4FJGr4c4BSjFe+-eg@mail.gmail.com>
Subject: Re: [PATCH] perf util: Remove kernel version deadcode
To: linux@treblig.org
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 7:58=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> fetch_kernel_version() has been unused since Ian's 2013
> commit 3d6dfae88917 ("perf parse-events: Remove BPF event support")
>
> Remove it, and it's helpers.
> I noticed there are a bunch of kernel-version macros that are also
> unused nearby.
> Also remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/util.c | 85 ------------------------------------------
>  tools/perf/util/util.h |  8 ----
>  2 files changed, 93 deletions(-)
>
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 9d55a13787ce..855aac5150a0 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -336,91 +336,6 @@ bool perf_event_paranoid_check(int max_level)
>         return perf_event_paranoid() <=3D max_level;
>  }
>
> -static int
> -fetch_ubuntu_kernel_version(unsigned int *puint)
> -{
> -       ssize_t len;
> -       size_t line_len =3D 0;
> -       char *ptr, *line =3D NULL;
> -       int version, patchlevel, sublevel, err;
> -       FILE *vsig;
> -
> -       if (!puint)
> -               return 0;
> -
> -       vsig =3D fopen("/proc/version_signature", "r");
> -       if (!vsig) {
> -               pr_debug("Open /proc/version_signature failed: %s\n",
> -                        strerror(errno));
> -               return -1;
> -       }
> -
> -       len =3D getline(&line, &line_len, vsig);
> -       fclose(vsig);
> -       err =3D -1;
> -       if (len <=3D 0) {
> -               pr_debug("Reading from /proc/version_signature failed: %s=
\n",
> -                        strerror(errno));
> -               goto errout;
> -       }
> -
> -       ptr =3D strrchr(line, ' ');
> -       if (!ptr) {
> -               pr_debug("Parsing /proc/version_signature failed: %s\n", =
line);
> -               goto errout;
> -       }
> -
> -       err =3D sscanf(ptr + 1, "%d.%d.%d",
> -                    &version, &patchlevel, &sublevel);
> -       if (err !=3D 3) {
> -               pr_debug("Unable to get kernel version from /proc/version=
_signature '%s'\n",
> -                        line);
> -               goto errout;
> -       }
> -
> -       *puint =3D (version << 16) + (patchlevel << 8) + sublevel;
> -       err =3D 0;
> -errout:
> -       free(line);
> -       return err;
> -}
> -
> -int
> -fetch_kernel_version(unsigned int *puint, char *str,
> -                    size_t str_size)
> -{
> -       struct utsname utsname;
> -       int version, patchlevel, sublevel, err;
> -       bool int_ver_ready =3D false;
> -
> -       if (access("/proc/version_signature", R_OK) =3D=3D 0)
> -               if (!fetch_ubuntu_kernel_version(puint))
> -                       int_ver_ready =3D true;
> -
> -       if (uname(&utsname))
> -               return -1;
> -
> -       if (str && str_size) {
> -               strncpy(str, utsname.release, str_size);
> -               str[str_size - 1] =3D '\0';
> -       }
> -
> -       if (!puint || int_ver_ready)
> -               return 0;
> -
> -       err =3D sscanf(utsname.release, "%d.%d.%d",
> -                    &version, &patchlevel, &sublevel);
> -
> -       if (err !=3D 3) {
> -               pr_debug("Unable to get kernel version from uname '%s'\n"=
,
> -                        utsname.release);
> -               return -1;
> -       }
> -
> -       *puint =3D (version << 16) + (patchlevel << 8) + sublevel;
> -       return 0;
> -}
> -
>  int perf_tip(char **strp, const char *dirpath)
>  {
>         struct strlist *tips;
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 9966c21aaf04..b5e7becfc803 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -43,14 +43,6 @@ int sysctl__max_stack(void);
>
>  bool sysctl__nmi_watchdog_enabled(void);
>
> -int fetch_kernel_version(unsigned int *puint,
> -                        char *str, size_t str_sz);
> -#define KVER_VERSION(x)                (((x) >> 16) & 0xff)
> -#define KVER_PATCHLEVEL(x)     (((x) >> 8) & 0xff)
> -#define KVER_SUBLEVEL(x)       ((x) & 0xff)
> -#define KVER_FMT       "%d.%d.%d"
> -#define KVER_PARAM(x)  KVER_VERSION(x), KVER_PATCHLEVEL(x), KVER_SUBLEVE=
L(x)
> -
>  int perf_tip(char **strp, const char *dirpath);
>
>  #ifndef HAVE_SCHED_GETCPU_SUPPORT
> --
> 2.47.0
>

