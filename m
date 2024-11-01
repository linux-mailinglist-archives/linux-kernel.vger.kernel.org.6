Return-Path: <linux-kernel+bounces-392969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA69B9A42
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF6FB2167B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA41E32B4;
	Fri,  1 Nov 2024 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOz6apRs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EC487BE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496774; cv=none; b=sl56alHd+QbHNLK/yGjh2RZ3Ocl7iWcXn0F1tOgs99Pg7DNXg0Fnz3aSLAO+QP3fWZ/Kh6D3KQSVzwM5hykjXXhDnGyD9i5dXFMrlcUd1wt4D0AX8R3TSKCzl7WWxfM2dYLW0koDcCHjeJr89a8nAWG77LTr7J84qolH54Zjx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496774; c=relaxed/simple;
	bh=RO7H6FnuXlMoVMfwCSzCeZRq31R5RY8UoGqMN8opIYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTukZZnRRj7X0/r/8rDJp64Cw6p6CpDKn15BOMJKA+MaEifcNA3l2f5myXc6AAzMNrTXjuUVSbXRPXH6Pv+krqQ27fULD/g+qCWIuXrspwH7eNIJ4DD0keucVt/xLf1REvYUfKr42mytyvx2MgpYQakAsUWopE36b+7ENZZ0egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOz6apRs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315abed18aso19818945e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730496771; x=1731101571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpwwxpppNvjOyJOrDhxHP1G8PA3ihaRLLkyxpy3yS4Q=;
        b=vOz6apRsCtA2F1JeWzomfBhWxna19xOGIfH4wEKB//TpTnkg84mCzeMe7HOPyvBvBv
         KnxXS0KJCX3IlQaS4ScgDlaz53WIldcYLAGYxq5rxLC0WKfc2lJqOLYk7rakNeLzc7Aj
         kwSDIrbVL5VOgnhFcJ5xq7EeRwTCHxzAqGRB6pYgiwh+3XMv24ZIKK2f71G1NsmlbbtM
         yNVc/CyexwyEpmqi+34mpmvj4nA7Hwb9607qK9pXQxrRN2Q+NwE9mXwvyWVDr5OFcjy2
         3ZxTFbLTDJJA9QKG4J5SWkuBJs4ng/9qDtLgtblUJg1xN94nLR9cO+6Pu/8mcliW/gLq
         G1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730496771; x=1731101571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpwwxpppNvjOyJOrDhxHP1G8PA3ihaRLLkyxpy3yS4Q=;
        b=ubxp6rYXeE2SVMhsBQvJAvHEgREmUfrYGat1bnABvMXYh9O8WpigVbqQxqEGWyV3Sc
         lp9bSJ4LfuKkJbm1/xb4fC9+yz6Ohny1+UrCWn98x3cKYYjuifV9FQEpMQHh9wcZdVhh
         sMDiPRy7q07o9CtLpfTt8wtvviXhTv2BqOXWgS2993HRj2sZzQGKYnKAnX8k6MT0Hy+Z
         st1rZ8b/TrIV6ZAyaLE9BqpVOaTzr+LzqSzyZqkObeGsJAOVLVnp0D1N9DOgqokn5KRC
         hzkfCk2Gen3eLsTjTrI/k9voqWXp5Z8nTpBIBo32RHrDeggDrSoVDYs7cvSHdxnsx07z
         dO0A==
X-Gm-Message-State: AOJu0Yynlf1LD0pzdfo744y9Pbpc+Vhviuhxmz2aUKlGXUEQyCOswaF4
	0RM0TgcaN7zN2nbhvM3o6Yw/y1Xat+EKAUCJGdvplWGcp6YZo6UpGZJvDjASRN7HGSxuwKwt8h+
	N47p/fKPIxjk1m0pmIB9Oq1MY1XyyAh3kjC6p
X-Google-Smtp-Source: AGHT+IGTribpmlI6cHIOxW9BpccAVsQ3pKjcOQkdKAttr4fRpULIEuy5rijHGkYJuj/75Bjtal2OA5YTxFlVletiV+0=
X-Received: by 2002:a05:600c:4f8e:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-432832449ccmr39199425e9.8.1730496771003; Fri, 01 Nov 2024
 14:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com> <20241031223948.4179222-3-ctshao@google.com>
 <CAP-5=fUZ_tXR7nqQjkNHgGbJ4dMLdOf0umR=y_hf9xJuCbfgfw@mail.gmail.com>
In-Reply-To: <CAP-5=fUZ_tXR7nqQjkNHgGbJ4dMLdOf0umR=y_hf9xJuCbfgfw@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 1 Nov 2024 14:32:39 -0700
Message-ID: <CAJpZYjXY4R=t1Wn2bkjEuThyCAC8_HTZ6JwtWPuQEs=weshbGQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf evsel: Find process with busy PMUs for EBUSY
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your review! Here is the link to the v2 patch with
fixes: https://lore.kernel.org/all/20241101211757.824743-3-ctshao@google.co=
m/

On Fri, Nov 1, 2024 at 9:14=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Oct 31, 2024 at 3:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > It parses fdinfo with PMU type, comparing with the event which failed t=
o
> > open, and report the processes causing EBUSY error.
> >
> > ```
> > Testing cycles and intel_pt//
> > $ ./perf stat -e cycles &
> > [1] 55569
> > $ ./perf stat -e intel_pt// &
> > [2] 55683
> > $ ./perf stat -e intel_pt//
> > Error:
> > The PMU intel_pt counters are busy and in use by another process.
> > Possible processes:
> > 55683 ./perf stat -e intel_pt//
> > ```
> > Only perf with intel_pt was reported.
>
> I think this is a very nice addition. It is a shame there is a race
> with the existing process exiting, between the perf_event_open and the
> /proc scanning. A PMU may return EBUSY just because say perf list is
> probing features on the PMU so we probably have some extra retries for
> EBUSY too.
>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
> >  1 file changed, 57 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 9a5b6a6f8d2e5..d2f7c19e023ec 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3286,7 +3286,8 @@ static bool find_process(const char *name)
> >         return ret ? false : true;
> >  }
> >
> > -static int dump_perf_event_processes(char *msg, size_t size)
> > +static int dump_perf_event_processes(const struct perf_event_attr *fai=
led_attr,
> > +                                    char *msg, size_t size)
> >  {
> >         DIR *proc_dir;
> >         struct dirent *proc_entry;
> > @@ -3327,29 +3328,61 @@ static int dump_perf_event_processes(char *msg,=
 size_t size)
> >                                 continue;
> >                         /* Take care as readlink doesn't null terminate=
 the string. */
> >                         if (!strncmp(path, "anon_inode:[perf_event]", l=
ink_size)) {
> > -                               int cmdline_fd;
> > -                               ssize_t cmdline_size;
> > -
> > -                               scnprintf(path, sizeof(path), "%s/cmdli=
ne", proc_entry->d_name);
> > -                               cmdline_fd =3D openat(dirfd(proc_dir), =
path, O_RDONLY);
> > -                               if (cmdline_fd =3D=3D -1)
> > -                                       continue;
> > -                               cmdline_size =3D read(cmdline_fd, path,=
 sizeof(path) - 1);
> > -                               close(cmdline_fd);
> > -                               if (cmdline_size < 0)
> > +                               int fdinfo_fd;
> > +                               ssize_t fdinfo_size;
> > +                               char *line;
> > +                               u32 perf_event_type =3D PERF_TYPE_MAX;
>
> PERF_TYPE_MAX is beyond the pre-defined perf PMU types at 6 but PMU
> drivers loaded by the kernel may use this number - I think task-clock
> may use this PMU type number but it shouldn't return EBUSY. Anyway, I
> think -1 would be a better marker to use here and in the corresponding
> check below.
>
> Thanks,
> Ian

In this case I am using UINT32_MAX instead to avoid the overflow. If
kernel would still use this value, I can make it u64 or add a variable
`found` instead.

>
> > +
> > +                               /* Let's check the PMU type reserved by=
 this process */
> > +                               scnprintf(path, sizeof(path), "%s/fdinf=
o/%s",
> > +                                         proc_entry->d_name, fd_entry-=
>d_name);
> > +                               fdinfo_fd =3D openat(dirfd(proc_dir), p=
ath, O_RDONLY);
> > +                               fdinfo_size =3D read(fdinfo_fd, path, s=
izeof(path) - 1);
> > +                               if (fdinfo_size < 0)
> >                                         continue;
> > -                               path[cmdline_size] =3D '\0';
> > -                               for (ssize_t i =3D 0; i < cmdline_size;=
 i++) {
> > -                                       if (path[i] =3D=3D '\0')
> > -                                               path[i] =3D ' ';
> > +                               path[fdinfo_size] =3D '\0';
> > +
> > +                               line =3D strtok(path, "\n");
> > +                               while (line !=3D NULL) {
> > +                                       if (sscanf(line,
> > +                                                  "perf_event-attr.typ=
e:\t%u",
> > +                                                  &perf_event_type) =
=3D=3D 1)
> > +                                               break;
> > +                                       line =3D strtok(NULL, "\n");
> >                                 }
> >
> > -                               if (printed =3D=3D 0)
> > -                                       printed +=3D scnprintf(msg, siz=
e, "Possible processes:\n");
> > -
> > -                               printed +=3D scnprintf(msg + printed, s=
ize - printed,
> > -                                               "%s %s\n", proc_entry->=
d_name, path);
> > -                               break;
> > +                               /* Report the process which reserves th=
e conflicted PMU. */
> > +                               /* If fdinfo does not contain PMU type,=
 report it too. */
> > +                               if (perf_event_type =3D=3D failed_attr-=
>type ||
> > +                                   perf_event_type =3D=3D PERF_TYPE_MA=
X) {
> > +                                       int cmdline_fd;
> > +                                       ssize_t cmdline_size;
> > +
> > +                                       scnprintf(path, sizeof(path),
> > +                                                 "%s/cmdline",
> > +                                                 proc_entry->d_name);
> > +                                       cmdline_fd =3D openat(dirfd(pro=
c_dir), path, O_RDONLY);
> > +                                       if (cmdline_fd =3D=3D -1)
> > +                                               continue;
> > +                                       cmdline_size =3D read(cmdline_f=
d, path, sizeof(path) - 1);
> > +                                       close(cmdline_fd);
> > +                                       if (cmdline_size < 0)
> > +                                               continue;
> > +                                       path[cmdline_size] =3D '\0';
> > +                                       for (ssize_t i =3D 0; i < cmdli=
ne_size; i++) {
> > +                                               if (path[i] =3D=3D '\0'=
)
> > +                                                       path[i] =3D ' '=
;
> > +                                       }
> > +
> > +                                       if (printed =3D=3D 0)
> > +                                               printed +=3D scnprintf(
> > +                                                       msg, size,
> > +                                                       "Possible proce=
sses:\n");
> > +
> > +                                       printed +=3D scnprintf(msg + pr=
inted, size - printed,
> > +                                                       "%s %s\n", proc=
_entry->d_name, path);
> > +                                       break;
> > +                               }
> >                         }
> >                 }
> >                 closedir(fd_dir);
> > @@ -3458,7 +3491,9 @@ int evsel__open_strerror(struct evsel *evsel, str=
uct target *target,
> >                         msg, size,
> >                         "The PMU %s counters are busy and in use by ano=
ther process.\n",
> >                         evsel->pmu ? evsel->pmu->name : "");
> > -               return printed + dump_perf_event_processes(msg + printe=
d, size - printed);
> > +               return printed + dump_perf_event_processes(&evsel->core=
.attr,
> > +                                                          msg + printe=
d,
> > +                                                          size - print=
ed);
> >                 break;
> >         case EINVAL:
> >                 if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAG=
E_SIZE && perf_missing_features.code_page_size)
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >

