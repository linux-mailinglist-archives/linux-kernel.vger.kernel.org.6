Return-Path: <linux-kernel+bounces-566563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4BDA679D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9523A7F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB328210192;
	Tue, 18 Mar 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ltJeuoVh"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF520E6F6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315838; cv=none; b=nt3ODCEUKH2xJKpIIa+bl4Z/mxOGfh6yBqpDfkvk4hmLms/pzmU+67ggk2VrvTC2OtwKGzrkl+3qLJluItBqMwuOSZzgumMOn3S1JlL1oe/eSunRwnl6HcxOxgyJs25+klMYGsFM18M5pwKulb1Vz77/8rXyvJ17f5Is3QNZZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315838; c=relaxed/simple;
	bh=4eT1odMzMnZPwJJSc0XgEk7lC+8F9q03wpNoipGla5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjV2hv4bxY3F/QEBmU+oGHTNMxzjOfSuZ/qBYhl13a9kJ0nqjjGz+VdK0FMx3elJRu4oVNJvgg7t3V/zsoTG2Bn3JC+2kSPcxEBACt5qDc8eJfKGiIb7N7LqhAF/vBVxUo7MF8/6JNQB2u+AWnWn5PQal8UKcM/c/ZetsNM2SjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ltJeuoVh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so2925ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742315835; x=1742920635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2z69ehu9MYLofoS0JeQiQ0e/VE3ytjfb/z77xAUlFQ=;
        b=ltJeuoVh0zi4JNdzW9UUjzGPslste3/5VtDEvY1a6kUE35DkascYD+89tdH/vVkckq
         Dt/RB9zlcb1/AndZIK4am9uZjT2xXzDdtgI7I9GGrEhjuBiJJYepk8pPCT8WS6iKDA61
         a4og5lTkRpgwfwToUnwi3gH2YFEtY0SMikH2Z+EoQpOyvFHvBKFgDjjHTOHpp2r+Crmp
         tK8rvSh4L2cVOzQP6XsJzLWR2fAjnv5iAo4siLfwz5XmAowdyMhGZaHVdJc6DAxof9uJ
         TTfq37b1M/nHCU9H1PyF8X+vLDwTnkhX6K6n5Q+dal17VvTH3iE6pWCd/buwl1Iid2Nq
         4ZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315835; x=1742920635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2z69ehu9MYLofoS0JeQiQ0e/VE3ytjfb/z77xAUlFQ=;
        b=XJ23/dx+54plTVxy63HjZhUp19mb5SJbviqXPKj2oeME+k1L6nF15TPGFlVbChAc9u
         ku7HATth9/equSETashboRIw/O+c2Io8MdSdNdSEO5tUdYYTV3bAsSmuMYBTY97ZN5Ea
         2/m4Z0RVuXNHu6RuTfXgDmyNOinxq1vIp/PlPy3Bbcs4KdOaXNqvtCdI2XQ2wTz2pxms
         A2ylyN/DBwSZr6bLDq2KJeyAjuhUe+nQanEEeeSlUX4IOQegvTp5lgDXvFYCb7xf69NK
         RSA00vqSJ2BiTxl3GoASKjrq/Mp/VCPq3fi1s+YkT/atQjOBo7QKhzSYxA5fULIORfG+
         TnWQ==
X-Gm-Message-State: AOJu0Yz9lIZjolqdLdwn/djZjUjGjuDJQSUw/F4zkC27S3tL5FPAXuTP
	ZPUwVM2C3N0MOMn3aTGXHe1bs1k/6v8hEP1ODUjlzbhUevbA2tSt4KoN+VLbs7Gk8B7Cx3OMcKm
	ktGv7YTn//JBYrJE60iWNDJX5QfdzzhAQE2/E
X-Gm-Gg: ASbGncvaglPMZkLi6b5UWtTc171yb8T3P6GUmAPkxgLf7IAHRb0jNXAeje1LFINy3ah
	p9Ucp8+phvj733F7LLxlCcSdqiiCkt1YWM9K5LCrqT8ekW38NHPrNcRpOr/umqWBAgi+ZrSiAzR
	fQt4h1fBJaSE4cK2cMQaB5GpH5D6nnXoIDAZPEM+izRzHIaK2hKMzPll5GcT4CFQ==
X-Google-Smtp-Source: AGHT+IHnSw39H849L234BIkDc47Eq7xhSFTxT3N4fuR1hmpWc455Btyp/vc6iE1Wb2xmRZNsrCL1ynYjk4f8BKIAoHA=
X-Received: by 2002:a17:903:228a:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-226357c807cmr2082025ad.15.1742315834907; Tue, 18 Mar 2025
 09:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318095132.1502654-1-tmricht@linux.ibm.com> <20250318095132.1502654-3-tmricht@linux.ibm.com>
In-Reply-To: <20250318095132.1502654-3-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Mar 2025 09:37:02 -0700
X-Gm-Features: AQ5f1JpT8DCKBYPXcNNrpUEYFo_khI7jP_G1lI4QozhZPAilFvW_a6UuYt0iing
Message-ID: <CAP-5=fXAhsDkQXVCvb5xrjLVpYG-typR23_NXwgwPDjaJS0pqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/bench: Double free of dynamic allocated memory
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	acme@redhat.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:52=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On s390 z/VM the command 'perf bench internals pmu-scan'
> dumps core, as can be seen:
>
> Output before:
>  # ./perf bench internals pmu-scan
>  # Running 'internals/pmu-scan' benchmark:
>  Computing performance of sysfs PMU event scan for 100 times
>  perf: /root/linux/tools/include/linux/refcount.h:131:
>         refcount_sub_and_test: Assertion `!(new > val)' failed.
>  Aborted (core dumped)
>  #
>
> The root cause is in
>
> perf_pmus__scan()
> +--> perf_pmu__create_placeholder_core_pmu()
>      +--> cpu_map__online()
>
> cpu_map__online() has a static variable
>
>     static struct perf_cpu_map *online;
>
>     if (!online)
>         online =3D perf_cpu_map__new_online_cpus();
>
>     return online;
>
> which is allocated once when entered for the first time.
>
> However perf_pmu__create_placeholder_core_pmu() is actually called
> two times.
> First time:
>    run_pmu_scan()
>    +--> save_result()
>         +---> perf_pmus__scan_core()
>               +--> pmu_read_sysfs()
>                    +--> perf_pmu__create_placeholder_core_pmu()
>         ...
>         +--> perf_pmus__destroy()
>
> Second time:
>     run_pmu_scan()
>     +--> perf_pmus__scan()
>          +--> pmu_read_sysfs()
>               +--> perf_pmu__create_placeholder_core_pmu()
>         ...
>         +--> perf_pmus__destroy()
>
> The second time the already allocated memory pointed to by variable
> 'online' is returned. However in between the first and second call
> of perf_pmu__create_placeholder_core_pmu()
> function save_result() also frees all PMUs:
>
> save_result()
> +--> perf_pmus__destroy()
>      +--> perf_pmu__delete()
>           +--> perf_cpu_map__put()
>                +--> cpu_map__delete()
>
> cpu_map__delete() deletes the perf_cpu_map pointed to by variable
> online, but this static variable is not set to NULL. In the second
> invocation of perf_pmu__create_placeholder_core_pmu() the same
> memory locattion stored in variable online is returned.
>
> Later on run_pmu_scan() calls perf_pmus__destroy() again and then
> cpu_map__delete() frees the PMU "cpu->cpus" a second time causing
> the core dump.
>
> Avoid core dump and always allocate the online CPUs.
>
> Output after:
>  # ./perf bench internals pmu-scan
>  # Running 'internals/pmu-scan' benchmark:
>  Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 7.970 usec (+- 0.147 usec)
>   Average PMU scanning took: 60.415 usec (+- 3.986 usec)
>  #
>
> Background: s390 z/VM system do not support PMUs for sampling and
> counting. In this case dummy events are created by the perf tool
> and the PMUs "tool" and "fake" are created and freed.
>
> Fixes: a0c41caebab2f ("perf pmu: Add CPU map for "cpu" PMUs")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Thanks Thomas, the proposed fix breaks address sanitizer as there are
missing puts on the freshly allocated cpu maps. I think a better fix
would be to "get" the cpu map to increment the reference count rather
than to keep re-reading the online CPUs. In either case we need the
puts on the user side.

Ian

> ---
>  tools/perf/util/cpumap.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 5c329ad614e9..ab9e7a266af9 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -691,12 +691,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *ma=
p, char *buf, size_t size)
>
>  struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
>  {
> -       static struct perf_cpu_map *online;
> -
> -       if (!online)
> -               online =3D perf_cpu_map__new_online_cpus(); /* from /sys/=
devices/system/cpu/online */
> -
> -       return online;
> +       return perf_cpu_map__new_online_cpus(); /* from /sys/devices/syst=
em/cpu/online */
>  }
>
>  bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_c=
pu_id *b)
> --
> 2.48.1
>

