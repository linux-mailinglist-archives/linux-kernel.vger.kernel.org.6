Return-Path: <linux-kernel+bounces-408046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E113A9C7A12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5167BB2D664
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE26200B88;
	Wed, 13 Nov 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTxSIWbY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF641F77A2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517420; cv=none; b=OeHC+33rzWD7645GC/W2Yq64FoWzVkjrGF0EuuNCAeS2daGTS54tqrQhECMDElMC849tNm37dGZ9TbKYUw/zy7+jQ+Wx8SYbXxGox+76shRVqnXfAxALAOwm9iNVDF76rhmZLsdDcyE6/c+nHoXDiVV1OG9TxvsBA/V3fgCRycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517420; c=relaxed/simple;
	bh=OlzrsPB5XUVoPdY5ssfM2l467Cry902eTgjhS9HpyC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoVDAa9WfQqE6lxBnGP4HQ4JN8h5FSC/c6CnaNcgYsh11lRsREYvjM0Dd+YCuhg0Z5T7xKZm0bjT5dTgsjwuWKMFylq2vvOQAt03NJ4Zu6/2DoY3TblSe2YU881k9PbNgnG0lh5tB2ydKdDlEtg41+lEj4x4bUHrQv3tv77Bhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTxSIWbY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca03687fdso212135ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731517419; x=1732122219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3wYcPiFXtftpRGxF/6Zf/umDLx3ClZ8Ekl/dsjeYmQ=;
        b=kTxSIWbY5ozNhZ8YLwoG7jV0TF5Fak1IPI5T8ROcfLcqf4F5jGjlUAw41R+a+25sUu
         hcoxOq+BV1o4+i2alpgLjBeY9E+UrCfmfEvuQFQlxFDlcAV5iAxdDDtk3AfiJgsnUkAJ
         1viiYzN0g80nhIKtlHcAO4SHoOzJ+jeT626eCaqNVPWAQ3ZUZmxSW+z2dlfGH/hpMCt1
         vCz8p2yFv/XLrrTW9rm/i+piIOH0DkNktkT1j1BjPsfsYKvPY+FM8aOAz3v1D0Uo/MLn
         VL5cOOQUwyDNvs2xEMCc/H4lxh4+Kedp9JH/ataVFWdPjVJmJPQDKTNqZhhsqw5xpFaz
         0eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517419; x=1732122219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3wYcPiFXtftpRGxF/6Zf/umDLx3ClZ8Ekl/dsjeYmQ=;
        b=iHFoFFNirGr6aKFWsTbu26VX7mCPJ5vg+dLzKYCnaCVT0J9e5NjUdajrDAiUGSf82k
         gOq6+clYQLInHI1JTjXF6NAToefydpEEgHfPPRwGTx6rzisrE9MbvsBtcgiXeu/ht09l
         MEB5odJ8+RfzuadfyTFzzzqZ5rx4wObv8AME3XMzuf+gJM0Brok8Uq4QP+YEUdIlvXGG
         eGQ0SHatrgexJ0HCre1USF8e1fcBL9DSS4qhA3cqbSJKrBSUT85IrEFiPdcJH8mNWz1v
         aTWGMwQ4kB/T0mO1BweLTkYxymCTeIsAGzxhmg3zPvZ0v6cXsTK23AAm7NbgI/LQLYzk
         PsRA==
X-Forwarded-Encrypted: i=1; AJvYcCW4rKBH+x8L6YbVxWQ+/V1zjasiVY+2xRrEfZlYASXvcwxz7FsGIk+JWmN8+JWS5CQv5toV7TuRoXrrsR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3sHuiozIzI9gzv9VfGicN2OQEz8nsancjvP6/OhuhEBhgO5z
	O/VxdsYMRRJZLWhFnwMNKy7Bk7XRtKPm4o74003CELQJytqfw3M+d2hlEMli2PJkXvE9M69t7ES
	iQAhPV7b0BXfgH181vhNG7Q4+wJm0MYRNoagohIWtinkeHATsx3Id
X-Gm-Gg: ASbGncs4lOnVspuZikhi3hsV91g919SfCiKLqxBbtYSGI8HbT6TOe0NYnrMIa8yyGet
	GFGyIfFvLrw2Jd5EWSt+RJne65xC2BjBm3LgnoURfsLu/MhUo2he23dD5+IfEmg==
X-Google-Smtp-Source: AGHT+IHZ1dDlMsr6QQHILrv6ztAYxxRD5ko2gvdn7UqEsuvtnR6ku5j9xZxhm6G/igNtDYCuWusICqVWF7QhmfutHNQ=
X-Received: by 2002:a17:903:2449:b0:20b:81bb:4a81 with SMTP id
 d9443c01a7336-211b70725d1mr2524865ad.7.1731517417070; Wed, 13 Nov 2024
 09:03:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113002818.3578645-1-howardchu95@gmail.com> <20241113002818.3578645-5-howardchu95@gmail.com>
In-Reply-To: <20241113002818.3578645-5-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Nov 2024 09:03:25 -0800
Message-ID: <CAP-5=fXPCgXyp3w478M9UrqVmneg1mvsabSJb55R+-xPYaUFuw@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] perf record --off-cpu: Preparation of off-cpu
 BPF program
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:28=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Set the perf_event map in BPF for dumping off-cpu samples.
>
> Set the offcpu_thresh to specify the threshold.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-5-howardchu95@gmai=
l.com
> [ Added some missing iteration variables to off_cpu_config() and fixed up
>   a manually edited patch hunk line boundary line ]
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/bpf_off_cpu.c          | 25 +++++++++++++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 11 +++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index 558c5e5c2dc3..61729a65b529 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -13,6 +13,7 @@
>  #include "util/cgroup.h"
>  #include "util/strlist.h"
>  #include <bpf/bpf.h>
> +#include <internal/xyarray.h>
>
>  #include "bpf_skel/off_cpu.skel.h"
>
> @@ -60,6 +61,9 @@ static int off_cpu_config(struct evlist *evlist)
>  static void off_cpu_start(void *arg)
>  {
>         struct evlist *evlist =3D arg;
> +       struct evsel *evsel;
> +       struct perf_cpu pcpu;
> +       int i;
>
>         /* update task filter for the given workload */
>         if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> @@ -73,6 +77,25 @@ static void off_cpu_start(void *arg)
>                 bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
>         }
>
> +       /* update BPF perf_event map */
> +       evsel =3D evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
> +       if (evsel =3D=3D NULL) {
> +               pr_err("%s evsel not found\n", OFFCPU_EVENT);
> +               return;
> +       }
> +
> +       perf_cpu_map__for_each_cpu(pcpu, i, evsel->core.cpus) {
> +               int err;
> +
> +               err =3D bpf_map__update_elem(skel->maps.offcpu_output, &p=
cpu.cpu, sizeof(__u32),
> +                                          xyarray__entry(evsel->core.fd,=
 i, 0),
> +                                          sizeof(__u32), BPF_ANY);
> +               if (err) {
> +                       pr_err("Failed to update perf event map for direc=
t off-cpu dumping\n");
> +                       return;
> +               }
> +       }
> +
>         skel->bss->enabled =3D 1;
>  }
>
> @@ -261,6 +284,8 @@ int off_cpu_prepare(struct evlist *evlist, struct tar=
get *target,
>                 }
>         }
>
> +       skel->bss->offcpu_thresh_ns =3D opts->off_cpu_thresh_us * 1000;

Thanks for the suffixes, readability++.

Ian

> +
>         err =3D off_cpu_bpf__attach(skel);
>         if (err) {
>                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf=
_skel/off_cpu.bpf.c
> index c152116df72f..c87132e01eb3 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -18,6 +18,8 @@
>  #define MAX_STACKS   32
>  #define MAX_ENTRIES  102400
>
> +#define MAX_CPUS  4096
> +
>  struct tstamp_data {
>         __u32 stack_id;
>         __u32 state;
> @@ -39,6 +41,13 @@ struct {
>         __uint(max_entries, MAX_ENTRIES);
>  } stacks SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(__u32));
> +       __uint(max_entries, MAX_CPUS);
> +} offcpu_output SEC(".maps");
> +
>  struct {
>         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>         __uint(map_flags, BPF_F_NO_PREALLOC);
> @@ -97,6 +106,8 @@ const volatile bool uses_cgroup_v1 =3D false;
>
>  int perf_subsys_id =3D -1;
>
> +__u64 offcpu_thresh_ns;
> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> --
> 2.43.0
>

