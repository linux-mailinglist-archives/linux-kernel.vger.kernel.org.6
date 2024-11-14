Return-Path: <linux-kernel+bounces-409593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D245E9C8EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556901F20FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6518C35C;
	Thu, 14 Nov 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/uIc2Pu"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F518C018
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599535; cv=none; b=L2eCTuY95qXtf7lE+/3v6V+LLUGx1zPd8LTVppMFZMCiuaZh4sGiX0x+ZcqgcMVF4gQUq0Om/pP7Uowdvkf5LJ9MiY1/tnNzxB0YzDONJx5VwMZ9PFHzjEtBGsioo+K1Y3KkdsdG95iER5EkjIpe8f4mw1tpO7U0ATXzTeE795I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599535; c=relaxed/simple;
	bh=v1RiomMiWVqeQ0xSIyrfA4rsENMHKQjxihGO/VInIns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2gVW7qztQI7H1zabgtVN6CcTt1woROlLwmWWxa6FRhxlqek9G9/swVUUpxxET53ZEehCc7RcaUX16uVUQZunGOoO1kKRyTjfgroqgAwjBeZJkqR+Z7bZHfKGS9zRmZgpOg6YwCLUG44LerA4A9jSyeRifoxr7E3tSkL+BSxss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/uIc2Pu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso170225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731599532; x=1732204332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktgKdwX1j+4Opkivi2DSjE8sDLzSzC2KukaMkHYqosU=;
        b=n/uIc2Pu6r/An4+qHX9t3Epor5bPFhvMcohHxnZf3E9AJ2Rg+QHyVSx7LCbhrwtB+x
         r1A5fH2Te7jHlnodjykwyoOoaRet/i+jC+K8DHBKmAD0Hi6C9xpCLaWRGVqAhS5/lfHT
         8tc4EF/2iA5GVcZYc+RpPj/u8+P+WVoxtoYHFW3ygrCtYdt0q+q184OdY1ijc7QQrvrN
         t8xdnuz0ZR2bvjh7Q9yVZyhslQ8irTkolG0v/aDZtfOSrrPNpou8ilMJMOXMD4Cd5UGR
         s6r60LdS8I1jZ4tdBK1B7AL97aBbRP0Tqb/jFHfcWcPYoMG5GTPR28YJqKvTQkiEAsXi
         aASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599532; x=1732204332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktgKdwX1j+4Opkivi2DSjE8sDLzSzC2KukaMkHYqosU=;
        b=a4rzg5QHX3dPmnhxe63jxJx9NOQw1pclfhO8d4sT+AGK42ctVJ9O6KWGQgo9aWV85a
         hAtz1EFwxUoiVNkEucYY5aIs1KNKeXedUqnVeOZK/vhAhsgBVg36fFz2d6gBgLTjzCcm
         +cyqZLzhGVaiRuW8+q0Ql0RyTEX+MwEI5+7ebXu4RK5ZquCIdyl60//6kjF9Dpzw3Ef7
         VEO7CPXy1Y2gVBSDtIXakTZBSQKkuNPMixPzmEeFA+xgFm512dr0xkDjtoO0qIFE0wlM
         OxMmpQjx2q6TskdJSns1Rb3DF2X46E2Nlg70ceN4rIRHVx/90dK98V9d8YAubKfmUn8H
         o9DQ==
X-Gm-Message-State: AOJu0YzYz7kOnO1ZYW8YSfiPbZBLsWvvWHZVXyRYZi8SColUqRaUDLKx
	4UFU37WyLvCzZFPcZt598K4E7Do8IX9RWC80Mr4cv4icZlDac7zMusDONQLEaArYgIsKi59sJPY
	qFgrZtE50RB4qPF5Lf0/4UF+Q0CI4ZqepSDGPIr9S0YnM4v0K1xhA
X-Gm-Gg: ASbGncsusVLFN/RnKN+/GrQ97Jfbpu/EY++H5Xs/hS4fHzQGM6WzrTJpdaSmVFN3ADp
	GErknqBNRDvbb07X+VupE4LwojNOA8yEKnhF31m7rMocRhA324vD2ozYgdE2Z/GQ=
X-Google-Smtp-Source: AGHT+IE8ou8Ygo56/ExTa5P+XtsMh75yKL6Jwd6AM/SdzEaQiK9oNtsAvUaqrHkm2YT+XDF+hFAsSS+8xs5Ra6Kd4hA=
X-Received: by 2002:a05:6e02:219b:b0:3a6:f43d:a24e with SMTP id
 e9e14a558f8ab-3a71e6e2cb2mr4141345ab.10.1731599532040; Thu, 14 Nov 2024
 07:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-3-ctshao@google.com>
In-Reply-To: <20241106003007.2112584-3-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Nov 2024 07:51:59 -0800
Message-ID: <CAP-5=fUk7ZSpHwwN98_YVFbKxGQSSbe+kLsCTiuS6mKkS+c3tA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf evsel: Find process with busy PMUs for EBUSY
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> It parses fdinfo with PMU type, comparing with the event which failed to
> open, and report the processes causing EBUSY error.
>
> Testing cycles and intel_pt//
>
>   $ ./perf stat -e cycles &
>   [1] 55569
>   $ ./perf stat -e intel_pt// &
>   [2] 55683
>   $ ./perf stat -e intel_pt//
>   Error:
>   The PMU intel_pt counters are busy and in use by another process.
>   Possible processes:
>   55683 ./perf stat -e intel_pt//
>
> Only perf with intel_pt was reported.

I think this looks really nice!

> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Change-Id: Ic51a36ea3b2fd245663d7db78f35496bb4199d73
> ---
>  tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d001ecfa26bf7..5400b795d9233 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3286,7 +3286,8 @@ static bool find_process(const char *name)
>         return ret ? false : true;
>  }
>
> -static int dump_perf_event_processes(char *msg, size_t size)
> +static int dump_perf_event_processes(const struct perf_event_attr *faile=
d_attr,
> +                                    char *msg, size_t size)
>  {
>         DIR *proc_dir;
>         struct dirent *proc_entry;
> @@ -3327,29 +3328,61 @@ static int dump_perf_event_processes(char *msg, s=
ize_t size)
>                                 continue;
>                         /* Take care as readlink doesn't null terminate t=
he string. */
>                         if (!strncmp(buf, "anon_inode:[perf_event]", link=
_size)) {
> -                               int cmdline_fd;
> -                               ssize_t cmdline_size;
> -
> -                               scnprintf(buf, sizeof(buf), "%s/cmdline",=
 proc_entry->d_name);
> -                               cmdline_fd =3D openat(dirfd(proc_dir), bu=
f, O_RDONLY);
> -                               if (cmdline_fd =3D=3D -1)
> -                                       continue;
> -                               cmdline_size =3D read(cmdline_fd, buf, si=
zeof(buf) - 1);
> -                               close(cmdline_fd);
> -                               if (cmdline_size < 0)
> +                               int fdinfo_fd;
> +                               ssize_t fdinfo_size;
> +                               char *line;
> +                               u32 perf_event_type =3D UINT32_MAX;
> +
> +                               /* Let's check the PMU type reserved by t=
his process */
> +                               scnprintf(buf, sizeof(buf), "%s/fdinfo/%s=
",
> +                                         proc_entry->d_name, fd_entry->d=
_name);
> +                               fdinfo_fd =3D openat(dirfd(proc_dir), buf=
, O_RDONLY);
> +                               fdinfo_size =3D read(fdinfo_fd, buf, size=
of(buf) - 1);
> +                               if (fdinfo_size < 0)
>                                         continue;
> -                               buf[cmdline_size] =3D '\0';
> -                               for (ssize_t i =3D 0; i < cmdline_size; i=
++) {
> -                                       if (buf[i] =3D=3D '\0')
> -                                               buf[i] =3D ' ';
> +                               buf[fdinfo_size] =3D '\0';
> +
> +                               line =3D strtok(buf, "\n");
> +                               while (line !=3D NULL) {
> +                                       if (sscanf(line,
> +                                                  "perf_event_attr.type:=
\t%u",
> +                                                  &perf_event_type) =3D=
=3D 1)
> +                                               break;
> +                                       line =3D strtok(NULL, "\n");
>                                 }
>
> -                               if (printed =3D=3D 0)
> -                                       printed +=3D scnprintf(msg, size,=
 "Possible processes:\n");
> -
> -                               printed +=3D scnprintf(msg + printed, siz=
e - printed,
> -                                               "%s %s\n", proc_entry->d_=
name, buf);
> -                               break;
> +                               /* Report the process which reserves the =
conflicted PMU. */
> +                               /* If fdinfo does not contain PMU type, r=
eport it too. */
> +                               if (perf_event_type =3D=3D failed_attr->t=
ype ||
> +                                   perf_event_type =3D=3D UINT32_MAX) {
> +                                       int cmdline_fd;
> +                                       ssize_t cmdline_size;
> +
> +                                       scnprintf(buf, sizeof(buf),
> +                                                 "%s/cmdline",
> +                                                 proc_entry->d_name);
> +                                       cmdline_fd =3D openat(dirfd(proc_=
dir), buf, O_RDONLY);
> +                                       if (cmdline_fd =3D=3D -1)
> +                                               continue;
> +                                       cmdline_size =3D read(cmdline_fd,=
 buf, sizeof(buf) - 1);
> +                                       close(cmdline_fd);
> +                                       if (cmdline_size < 0)
> +                                               continue;
> +                                       buf[cmdline_size] =3D '\0';
> +                                       for (ssize_t i =3D 0; i < cmdline=
_size; i++) {
> +                                               if (buf[i] =3D=3D '\0')
> +                                                       buf[i] =3D ' ';
> +                                       }
> +
> +                                       if (printed =3D=3D 0)
> +                                               printed +=3D scnprintf(
> +                                                       msg, size,
> +                                                       "Possible process=
es:\n");
> +
> +                                       printed +=3D scnprintf(msg + prin=
ted, size - printed,
> +                                                       "%s %s\n", proc_e=
ntry->d_name, buf);
> +                                       break;
> +                               }
>                         }
>                 }
>                 closedir(fd_dir);
> @@ -3458,7 +3491,9 @@ int evsel__open_strerror(struct evsel *evsel, struc=
t target *target,
>                         msg, size,
>                         "The PMU %s counters are busy and in use by anoth=
er process.\n",
>                         evsel->pmu ? evsel->pmu->name : "");
> -               return printed + dump_perf_event_processes(msg + printed,=
 size - printed);
> +               return printed + dump_perf_event_processes(&evsel->core.a=
ttr,
> +                                                          msg + printed,
> +                                                          size - printed=
);
>                 break;
>         case EINVAL:
>                 if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_=
SIZE && perf_missing_features.code_page_size)
> --
> 2.47.0.199.ga7371fff76-goog
>

