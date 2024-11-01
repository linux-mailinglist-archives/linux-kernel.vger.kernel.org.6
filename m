Return-Path: <linux-kernel+bounces-392971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187999B9A45
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23452836BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE71E32C0;
	Fri,  1 Nov 2024 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ws2TgT7E"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE441AA7BF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496921; cv=none; b=hqQCItQRrFbcuYe0wDNdb7BElC/7RRCYZ8/ckkfaHLdWP9RXOumDElJewRvzlL6r0cmJUCWzA0Wi6b8OvqspakVPhWKsdsNp7ZJLypY88tZ9auqrqgTkLs+uXAvpu9WGz979hTyY0f0NBf5nzZA3dnIAcNyO3MiaoELrIhokmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496921; c=relaxed/simple;
	bh=iAtlnNYv7ddBkzoo285HKCq8JF8/550T2wV5/ppqRh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPh83rVpGIkwTyQABNnjXblPZ8M1EBFU9Y7vD2HY9kuYPdbIb/S3PEviZsjecNJwrGHuzy7zWE+dQ3App8roqb5BtAg48JF2in9ZH2dey32PdfX8dVYN6lu9HvyrfxYY6U/ZBEfBVzv2Jfusbk5Ui1ACMfjaf1MldL65T9qXecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ws2TgT7E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so20241165e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730496917; x=1731101717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+65Y2NCKC4lIw4rf9pvYdLOAMJ1Scft6tR58NwbTjU=;
        b=ws2TgT7EMzlbX/ITb4l9N/JhcpPhPGU7l6e/vlpYKtSmk/6PwOafVtF81O1oDTeYgy
         7qlMPBU1NKb40Kvu2j/29lQ3ikN6FbERb1YATsZH3xORNTyfSUxj6QM2cqfWtpIsMtfS
         CMb82nvlml/F1s5zsps4F2SHUpmuif8HlDrl58waogwYc/Cu8hojLvm8eXsWuoeh5yX6
         BTKresKWCC5i4HrfoJ1ei6yIucHnfCOMsCBZtsGxLL1SUDgKngkHrtGsSbGLrdpdXlNd
         bRrtNK8jqJ8U55Uaplh1e0jmdiVxtSyqHPIs/RX9ifM4JGgSPkQGlPgf5XagrFadr9Ae
         H9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730496917; x=1731101717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+65Y2NCKC4lIw4rf9pvYdLOAMJ1Scft6tR58NwbTjU=;
        b=WvK4Ve+nDrEaLUc6+mOdsZEW5UgBI1WXCm3pdD1QKTqwB30b7yduKO/SyYBF20uESy
         Vwl56y84d92++EiuigZtSeHRUs0jBINoJ/F4LN1S0OZCN/zJt+EE4DXETwtMaAo06zxJ
         8ivLPhXONOE2LMI0zb9CnB/wlAnc/T/CUe4SM1st6oT8LatnGSSSbj4jkDbopgcsVSjK
         qoPNsnl01qooDVoPSCx7EN6fGB7COu3xKzLMnCO4e9YS1OrLvodWHul/S07hxyOYLhw+
         EbR+DE0Iy/AuorhTOBT2otz3PDOIQnTraX6dftH2wIDhkKMCCBVUD+doC0lipzt5PIaJ
         CRtA==
X-Gm-Message-State: AOJu0YyhEdcQkXDAg2tiKOR/saTqZYTLalRg5mOwKVxcRPl1w+yDQZ3y
	V503+Ak82Q4K8yUpQiDNPujTYUyw3N0zsE2ICDDdOuqwkebYIB37fdEDDqL8AhK9RlGqP4VhVUh
	V/EcM+D3r3/ck02npz4MQIb4V0mNneyGmYAHRBYS/vsuqgfnbc1fOJ5M=
X-Google-Smtp-Source: AGHT+IGkbbqGXw0V3xTbgDeQ9QZsxXjKmrWWjvIYx9ncxnhWztMgotPhlhoOHlUGO2GeuG9yJYjWEQ9pX2NbK2O2s74=
X-Received: by 2002:adf:a2d2:0:b0:37d:4647:154e with SMTP id
 ffacd0b85a97d-380610f264fmr16499427f8f.9.1730496916610; Fri, 01 Nov 2024
 14:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101211757.824743-1-ctshao@google.com> <20241101211757.824743-3-ctshao@google.com>
In-Reply-To: <20241101211757.824743-3-ctshao@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 1 Nov 2024 14:35:04 -0700
Message-ID: <CAJpZYjV+sTTG8XWp6+mEh3wKoW+odbSSSAroGOXLq=xfbAhRUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf evsel: Find process with busy PMUs for EBUSY
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 2:18=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
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
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/util/evsel.c | 79 +++++++++++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9a5b6a6f8d2e5..dfcb801d8921a 100644
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
> +                               u32 perf_event_type =3D INT_MAX;

This is a typo, it should be `UINT32_MAX`. I will fix this in v3,
along with other potential fixes after review.

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
> +                                   perf_event_type =3D=3D INT_MAX) {
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

