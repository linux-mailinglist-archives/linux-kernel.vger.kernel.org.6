Return-Path: <linux-kernel+bounces-404469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E19C440E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B2A2837B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D71A0B15;
	Mon, 11 Nov 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pj/pRGa"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCB01A3AAD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347256; cv=none; b=lrxYn86/NSan3B0g+VRtH5wVn2kmCxexByYyG8Juok3xxBLEHImYsFoJ/dEPytV2i1hr7glypYFl1hFWHQcWag0t6ApHH7C4/a8fB5uQJmKCjS5DP1cv4G12giQgcb5d2evOh3ld9LVs1sN2zEOkYqGGFWjLZRXygOlEV7QIZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347256; c=relaxed/simple;
	bh=LE4Pt9cDN+mPi0rq/vGTx+/1llTRbJQ8Uh5GS/cdGsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/yY9L8z0dPD7/AGR2UQhtLzqpXq3SbklMDZycKF6bxk+pCruxOxx4T0RpfaSsLYuTe6UG6wT9GqXBb+59Oq6gTL71HqqxeDqa+ch72ujQKd1GOpYXe+VaLWhPw6lw1NTVTDdheautHadeImGKDnYxVKfcoOEFGOVEbx8AffJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pj/pRGa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c8ac50b79so3355ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731347254; x=1731952054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0bhILX+QfiTRbLpbbX/P6GiCbt7or8G8zQuLrB55xU=;
        b=0pj/pRGazjIIL2Znyk1/gG2qTfLX69p+NsFcdW3d++Aofqpns8kbeHpC3AycfWVC1z
         T50nQew7dwMsmBb40oMGGWBsgnHW22RuAfze4DBp/KgkVDzFTZlFn5V5u7O+cYmURzgV
         4iSV5e8LknVYJ4mpdCJi5EicujD0VywVFfiS3Xocf3qQHOXd7AfazL5my/0XIJpiN/PI
         iHqJxckiNM/O+osV90cs7Tt59wxpwrBtbzeGgQ52vYxXM8ibKQnXCJ1HzY+81yqCbBMj
         dUhyj2m0WkSgVD6AmX7peuo3M9heFS+4agLlzUvfpRfjdzpN7D8+uxFN9FbtFOUN27XY
         asoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347254; x=1731952054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0bhILX+QfiTRbLpbbX/P6GiCbt7or8G8zQuLrB55xU=;
        b=K3xYQyLj6Ytt49v9BvN9sG5Pxc8WlWTfp3YmntHqTo6DEuIQZR+mMChBp3+WtwjiYd
         ewISXCJZKxQnPkSjsjnvCdUn7pdYMIZyofpOCVq4y8pYDHt7GycNoD+Y09funutAYS97
         q/u3T2BEWCYK1mUHMVC32TeZ8AQrM3VnWyH5Ep2bPcwBVN95TewEEGWPb/VYoziiL56q
         J/ZzpRPHgGzcOCQJqYUCSkxMLclTvyFKyibA1xpqWucq21twLJZufOfZCOyzOKH4HFsC
         +2ZrFS2/mnERkaiyDOK0kGawhD9g5uD+1OkxOD1o9MlgPeQ7hOi8GKdwgNjUWT4YwYZq
         lLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdWwwcMlX/40xwr9LyFypjRzkem/FLw2bVfoeGkLCZTvt+1Qtwp8yfZrKpdxnGAweRjNwGeuO07+nmhTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZQffi7dJsmGekckjC3dtyASrQRIp5qlJYfLfBSSZ2/5Gbbp2
	gJo5aG5FQdY/T2o2njReUUQd7K6q582pnPOkgV1Qh0d+wt1TTFlvAYkm7EtnX5s3x3a7McYtlUf
	jRRuJ63zHcbIDXU/KUxd9SB2JKHdFpE5Qc2BS
X-Gm-Gg: ASbGncvUuYKiA03hYPg7R6RQO/Ejxm5TKqnF1qDEXP89tgVy8R7dwzvIPYr+0Cjya1y
	LGpQIBYjEpYdSnUwqCz0I5LVU4kBDa20XdLCQxlhi8DVBsNh5niYFemvkMU76FPY=
X-Google-Smtp-Source: AGHT+IHg98IxDQvCtTAMTUm/W8qnUIEB9mqJCWc7RotJMAqFrSkHNFTD09B7/aSmRwi59/tkqCbTxEP1dnetucZd08I=
X-Received: by 2002:a17:902:d4cb:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-2118dea0992mr4463185ad.6.1731347252304; Mon, 11 Nov 2024
 09:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-5-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-5-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:47:21 -0800
Message-ID: <CAP-5=fV8_DxYxKy4A71z0gb82u8W+8qGXvVDSEW2A1GOfSf=oA@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] perf record --off-cpu: Preparation of off-cpu
 BPF program
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Set the perf_event map in BPF for dumping off-cpu samples.
>
> Set the offcpu_thresh to specify the threshold.
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_off_cpu.c          | 20 ++++++++++++++++++++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c |  2 ++
>  2 files changed, 22 insertions(+)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index 558c5e5c2dc3..cfe5b17393e9 100644
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
> @@ -73,6 +74,23 @@ static void off_cpu_start(void *arg)
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
> @@ -261,6 +279,8 @@ int off_cpu_prepare(struct evlist *evlist, struct tar=
get *target,
>                 }
>         }
>
> +       skel->bss->offcpu_thresh =3D opts->off_cpu_thresh * 1000;
> +
>         err =3D off_cpu_bpf__attach(skel);
>         if (err) {
>                 pr_err("Failed to attach off-cpu BPF skeleton\n");
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf=
_skel/off_cpu.bpf.c
> index c152116df72f..dc6acafb9353 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -97,6 +97,8 @@ const volatile bool uses_cgroup_v1 =3D false;
>
>  int perf_subsys_id =3D -1;
>
> +__u64 offcpu_thresh;

nit: would be nice to include the unit in the variable name, ie
offcpu_thresh_us.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> --
> 2.43.0
>

