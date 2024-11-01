Return-Path: <linux-kernel+bounces-392512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97299B950E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1E71C21487
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C541CB325;
	Fri,  1 Nov 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1JzijNhV"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBAA1C9DD3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477696; cv=none; b=RW1xsSkVz4yBYSs9cNKA1eUDmPyK4Xw508FQto9Wr2LtsyHvkHh5UUi1yODSPpSpehV4/9mg97umZpE6TtLfgYyzYyBWov35rnYRgwHNjt+/is2ZlHeZqXYzqtr1jzAZ3zRKDXEi0Z1fVa2lkoemZghY9Y4OILb0mAGjCA0ys2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477696; c=relaxed/simple;
	bh=Q4HHY2posorEN43Zk+qr1vkvydWOZqryApP128PSLxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mN59/nyUOpmlmSwPg17Jc/y62VPwBpnwLroZxVKT++zif5V+DxNa/xbegT7n7tCvacEZJ2QJ5qQxhUv9jr/I4hvolo2u5aiY8UIkNfcniVc/G8LPPalNynSCKnlcjEGTguZWxs1QDyTRrWVxRftyzjYcE/aOsWXzhAtEUXv14C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1JzijNhV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460969c49f2so189801cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730477692; x=1731082492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/bvWGIfLos8RTWfXU+4sIp5PZkctcrHA8Z1wWrA2h0=;
        b=1JzijNhV+8jaewxdkp91QmmSdTMrogY6c8hQc6iaHhCDxxziuHXb6al5qgSu4CgY0G
         p98iYLYy2gbweJ2eAe2wB6jYLIbb6Oq5lIJe8CqvVOZz22s3P5FuTHn8JLwkiUg3h944
         dXJLec2ip315vkGh1Zj0PlayuX+kOkaUohtAthwoHskccmZSAC22ZHgNeUfn/ADXb7Dl
         WJKAi5mZ06wf6ZLDEbA4IYVSTS+GfWPuKqaklK2zZ02D0KSNpR3nS2895SOwv/R0kurf
         v2zNplr6QAr0GXpG+rsLBVvjowIM5BlZ42Cbnv4vE/yuAfG4IlUm049JvJ/8GW6R8Z/4
         GyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730477692; x=1731082492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/bvWGIfLos8RTWfXU+4sIp5PZkctcrHA8Z1wWrA2h0=;
        b=OTv3XuGzOdTnzgNAqfV2eg9z+1NjDzJSAv7jeelqVoQdpdSz932DZ7m+1QZ0eWlG2x
         oh/NoihPeiE5wreJXdFM08FQqeQ2o8pDWIK29nEXasdLT0VUCz5ICpyijqozhxRdDhAf
         ejIXz8PfQzZH20yXbtvY5iKpQJ5S5RwQ/HhC8GQg0923iy/QXOlD9KIL8V1k8BhYew88
         pw1NK6e7ExhXAqImL7W7KN4pvrXr5PeWoX3cvfBNKmRMIV2QTpLxmwQ/ueNw85QE0gVv
         Rg7UAj0sAC2NLR4/K3y69R4fGxPidzQ09L6ILLcvn/vpgr3L/OqZk5fINNaAeMrj3RTG
         f7JA==
X-Gm-Message-State: AOJu0YxxblzvFPnsycwiOudmZhGeTXQWzuuHBCK8AJ8BZIlKzPiQxkiH
	7zQsK91nDm9O234ERquLxBdHfW6vGFHsCk6SnoWyrCiMR5OJ9Dg0VaOdeUWyVAxoQYPnpoqRfev
	r9ltvg9QWHByEsYUKaqe8BzidfX2cl87q6Ycl
X-Gm-Gg: ASbGncv3FPglV7+VCNnOdSpb8xKPOctxEPMNetmFfSkhF/9VLBFmVC8xm4NmUBzQX8U
	FCfH+wvhxwKnd0Kop2XabtR4pohJ3H7W4
X-Google-Smtp-Source: AGHT+IGcT+6kYghy8Gzvr0PfgmI3dMLivdh2KLwcIrsSZ/V/A6dYxtTy+x+MNdSHAokiVA07vBFBCkfOxdd1z092Vu0=
X-Received: by 2002:ac8:5746:0:b0:461:66f2:2c21 with SMTP id
 d75a77b69052e-462ad1c3593mr5815161cf.13.1730477692134; Fri, 01 Nov 2024
 09:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com> <20241031223948.4179222-3-ctshao@google.com>
In-Reply-To: <20241031223948.4179222-3-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Nov 2024 09:14:40 -0700
Message-ID: <CAP-5=fUZ_tXR7nqQjkNHgGbJ4dMLdOf0umR=y_hf9xJuCbfgfw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf evsel: Find process with busy PMUs for EBUSY
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> It parses fdinfo with PMU type, comparing with the event which failed to
> open, and report the processes causing EBUSY error.
>
> ```
> Testing cycles and intel_pt//
> $ ./perf stat -e cycles &
> [1] 55569
> $ ./perf stat -e intel_pt// &
> [2] 55683
> $ ./perf stat -e intel_pt//
> Error:
> The PMU intel_pt counters are busy and in use by another process.
> Possible processes:
> 55683 ./perf stat -e intel_pt//
> ```
> Only perf with intel_pt was reported.

I think this is a very nice addition. It is a shame there is a race
with the existing process exiting, between the perf_event_open and the
/proc scanning. A PMU may return EBUSY just because say perf list is
probing features on the PMU so we probably have some extra retries for
EBUSY too.

> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9a5b6a6f8d2e5..d2f7c19e023ec 100644
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
>                         if (!strncmp(path, "anon_inode:[perf_event]", lin=
k_size)) {
> -                               int cmdline_fd;
> -                               ssize_t cmdline_size;
> -
> -                               scnprintf(path, sizeof(path), "%s/cmdline=
", proc_entry->d_name);
> -                               cmdline_fd =3D openat(dirfd(proc_dir), pa=
th, O_RDONLY);
> -                               if (cmdline_fd =3D=3D -1)
> -                                       continue;
> -                               cmdline_size =3D read(cmdline_fd, path, s=
izeof(path) - 1);
> -                               close(cmdline_fd);
> -                               if (cmdline_size < 0)
> +                               int fdinfo_fd;
> +                               ssize_t fdinfo_size;
> +                               char *line;
> +                               u32 perf_event_type =3D PERF_TYPE_MAX;

PERF_TYPE_MAX is beyond the pre-defined perf PMU types at 6 but PMU
drivers loaded by the kernel may use this number - I think task-clock
may use this PMU type number but it shouldn't return EBUSY. Anyway, I
think -1 would be a better marker to use here and in the corresponding
check below.

Thanks,
Ian

> +
> +                               /* Let's check the PMU type reserved by t=
his process */
> +                               scnprintf(path, sizeof(path), "%s/fdinfo/=
%s",
> +                                         proc_entry->d_name, fd_entry->d=
_name);
> +                               fdinfo_fd =3D openat(dirfd(proc_dir), pat=
h, O_RDONLY);
> +                               fdinfo_size =3D read(fdinfo_fd, path, siz=
eof(path) - 1);
> +                               if (fdinfo_size < 0)
>                                         continue;
> -                               path[cmdline_size] =3D '\0';
> -                               for (ssize_t i =3D 0; i < cmdline_size; i=
++) {
> -                                       if (path[i] =3D=3D '\0')
> -                                               path[i] =3D ' ';
> +                               path[fdinfo_size] =3D '\0';
> +
> +                               line =3D strtok(path, "\n");
> +                               while (line !=3D NULL) {
> +                                       if (sscanf(line,
> +                                                  "perf_event-attr.type:=
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
name, path);
> -                               break;
> +                               /* Report the process which reserves the =
conflicted PMU. */
> +                               /* If fdinfo does not contain PMU type, r=
eport it too. */
> +                               if (perf_event_type =3D=3D failed_attr->t=
ype ||
> +                                   perf_event_type =3D=3D PERF_TYPE_MAX)=
 {
> +                                       int cmdline_fd;
> +                                       ssize_t cmdline_size;
> +
> +                                       scnprintf(path, sizeof(path),
> +                                                 "%s/cmdline",
> +                                                 proc_entry->d_name);
> +                                       cmdline_fd =3D openat(dirfd(proc_=
dir), path, O_RDONLY);
> +                                       if (cmdline_fd =3D=3D -1)
> +                                               continue;
> +                                       cmdline_size =3D read(cmdline_fd,=
 path, sizeof(path) - 1);
> +                                       close(cmdline_fd);
> +                                       if (cmdline_size < 0)
> +                                               continue;
> +                                       path[cmdline_size] =3D '\0';
> +                                       for (ssize_t i =3D 0; i < cmdline=
_size; i++) {
> +                                               if (path[i] =3D=3D '\0')
> +                                                       path[i] =3D ' ';
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
ntry->d_name, path);
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
> 2.47.0.163.g1226f6d8fa-goog
>

