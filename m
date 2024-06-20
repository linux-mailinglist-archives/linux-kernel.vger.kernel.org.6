Return-Path: <linux-kernel+bounces-221895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65090FA37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD1F1C215D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1AEC7;
	Thu, 20 Jun 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="gNgZmDIf"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8664C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718842863; cv=none; b=BFW+zowwSrlEK7GA/jhJyRhLutWUmiKrbJF23wFFP9b2PpbB0Dh64mtINcP0VqqIwDcYw2XGnxjZ9Emwdhh6dxZzFXMfBal+0UqNrL5gqFgAbpf9s/pfH44LIrwWbZYcrxac4K9tbLLTkjBTj4fOzV4v4zUKtbVSzG/ce8DWMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718842863; c=relaxed/simple;
	bh=hg0w2Q/1/o4rDmI6O4UDkNB5/buUYelBy63Xqycj6cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwI8nZDqU4sDmQxQ+JngvllZW+yiTveN+C1TFvWjsCA7WGHUPzaZCJfQvvcDfQQhdDk75/fMzTJn1lXEOigvMy1thNtbDjA3JltFA0geq/iP5XBT9Rn/q3seMpkbBAocBJE/d/pV3Bjb99UzpivdWrc8qdlwGVX0GbXlAvCIL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=gNgZmDIf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso3229831fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1718842859; x=1719447659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Re4TSnNjd/QPWIdV1Bt3N+f9/JFcgdjcGGLQawTbCY=;
        b=gNgZmDIfvBhIqtRQI0DGNNL1hJU0IF3oZTH05mQhv+IfE7avHGaOW0F+4OSjBaTh3H
         Y3mLq0eUggXSgMTsXwUvf64QgZAV2Zagxv8pJn6DT1m988EmA7uJ3/y9KnaO0Ynu8v3y
         1Entwl4n2KxCd5p9mpmNt7qMROwXUdCRYYlCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718842859; x=1719447659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Re4TSnNjd/QPWIdV1Bt3N+f9/JFcgdjcGGLQawTbCY=;
        b=F09E2KL3A/q1kQ4JKDrxXOv5CSD5T1rjJVydEA17JEdbDSlaqGHmCjQU6QqIOL4gKk
         FakYw1EiL1q871cGyhIbM10X/VSzQglw22R9bLhvxiaEF+QoHt7nMDcdBdOejw0RCCY+
         goyZ3/IWIzTbbxh8lIwFp7Gk+IC24wtCU0O0oMo45uum8piY+wHG2w8TD6hipHLHBfap
         2GEAedgHD2jHjXWq6w52GXr8P1HFgN4+n5ygLK3NTq3Z8VNFfxZXOGDIau0e++RKgsjk
         1cJleH2Dcgi0OmPbuFpIh4xBuC8aKTHOcJ37lUxUvSJFv631wE/LiQNT8+fcXbUxbjeC
         Nxmw==
X-Forwarded-Encrypted: i=1; AJvYcCXFxqs1b4ZY9eQsIHjMUoImfpsVocphXgkzfs/DZvbYZst40tlEVTqf+kr0dGA/5Mvm05riYIBmUh66engYwle5HWlVhD4zOljc7NN5
X-Gm-Message-State: AOJu0YwJzIEjpGFR5g5fLwbWd//42L1yhcHTInSrepPLGseSTYuDXcuD
	XyHD2Rx2h0hwGkUfuWByfo8z+aalyij4VNzp3N+te0PJFpZAzPeuDMFmwvfhmMjwSfkcFXY/LO6
	z+2NHC+t+8ufA8RzrNL4TxWHeOADXfcecKS1c
X-Google-Smtp-Source: AGHT+IF5zIQXKT1oiKzCaIZf68aBnxy+vHNuSIru3/IclRhGFEUeiDASGu3Fjf+TqB7dtc/XkCE+jns/7/NxCE9HIVY=
X-Received: by 2002:a2e:b1c2:0:b0:2ec:747:599f with SMTP id
 38308e7fff4ca-2ec3ceb6a17mr21955501fa.17.1718842858384; Wed, 19 Jun 2024
 17:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418014652.1143466-1-samuel.holland@sifive.com>
 <79087773-9115-4d4c-b566-028a21049d61@rivosinc.com> <4c4c70ed-3bff-471c-86ca-872d41380402@ghiti.fr>
 <db8c5502-e598-4695-ac13-5c381021e69e@ghiti.fr>
In-Reply-To: <db8c5502-e598-4695-ac13-5c381021e69e@ghiti.fr>
From: Atish Patra <atishp@atishpatra.org>
Date: Wed, 19 Jun 2024 17:20:46 -0700
Message-ID: <CAOnJCUKcWoJLUWCxxs_K1fJ7V7UeT2=t5+vxLvT9f+aGdin48Q@mail.gmail.com>
Subject: Re: [PATCH v2] perf: RISC-V: Check standard event availability
To: Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>
Cc: Atish Patra <atishp@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:48=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
> Hi Samuel, Atish,
>
> On 24/05/2024 22:00, Alexandre Ghiti wrote:
> > Hi Samuel,
> >
> > On 26/04/2024 17:38, Atish Patra wrote:
> >> On 4/17/24 18:46, Samuel Holland wrote:
> >>> The RISC-V SBI PMU specification defines several standard hardware an=
d
> >>> cache events. Currently, all of these events are exposed to userspace=
,
> >>> even when not actually implemented. They appear in the `perf list`
> >>> output, and commands like `perf stat` try to use them.
> >>>
> >>> This is more than just a cosmetic issue, because the PMU driver's .ad=
d
> >>> function fails for these events, which causes pmu_groups_sched_in() t=
o
> >>> prematurely stop scheduling in other (possibly valid) hardware events=
.
> >>>
> >>> Add logic to check which events are supported by the hardware (i.e. c=
an
> >>> be mapped to some counter), so only usable events are reported to
> >>> userspace. Since the kernel does not know the mapping between events
> >>> and
> >>> possible counters, this check must happen during boot, when no counte=
rs
> >>> are in use. Make the check asynchronous to minimize impact on boot
> >>> time.
> >>>
> >>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >>> ---
> >>> Before this patch:
> >>> $ perf list hw
> >>>
> >>> List of pre-defined events (to be used in -e or -M):
> >>>
> >>>    branch-instructions OR branches [Hardware event]
> >>>    branch-misses [Hardware event]
> >>>    bus-cycles [Hardware event]
> >>>    cache-misses [Hardware event]
> >>>    cache-references [Hardware event]
> >>>    cpu-cycles OR cycles [Hardware event]
> >>>    instructions [Hardware event]
> >>>    ref-cycles [Hardware event]
> >>>    stalled-cycles-backend OR idle-cycles-backend [Hardware event]
> >>>    stalled-cycles-frontend OR idle-cycles-frontend [Hardware event]
> >>>
> >>> $ perf stat -ddd true
> >>>
> >>>   Performance counter stats for 'true':
> >>>
> >>>                4.36 msec task-clock                       # 0.744
> >>> CPUs utilized
> >>>                   1      context-switches                 # 229.325
> >>> /sec
> >>>                   0      cpu-migrations                   # 0.000 /se=
c
> >>>                  38      page-faults                      # 8.714 K/s=
ec
> >>>           4,375,694      cycles                           # 1.003
> >>> GHz                         (60.64%)
> >>>             728,945      instructions                     # 0.17
> >>> insn per cycle
> >>>              79,199      branches                         # 18.162
> >>> M/sec
> >>>              17,709      branch-misses                    # 22.36%
> >>> of all branches
> >>>             181,734      L1-dcache-loads                  # 41.676
> >>> M/sec
> >>>               5,547      L1-dcache-load-misses            # 3.05% of
> >>> all L1-dcache accesses
> >>>       <not counted> LLC-loads (0.00%)
> >>>       <not counted> LLC-load-misses (0.00%)
> >>>       <not counted> L1-icache-loads (0.00%)
> >>>       <not counted> L1-icache-load-misses (0.00%)
> >>>       <not counted> dTLB-loads (0.00%)
> >>>       <not counted> dTLB-load-misses (0.00%)
> >>>       <not counted> iTLB-loads (0.00%)
> >>>       <not counted> iTLB-load-misses (0.00%)
> >>>       <not counted> L1-dcache-prefetches (0.00%)
> >>>       <not counted> L1-dcache-prefetch-misses (0.00%)
> >>>
> >>>         0.005860375 seconds time elapsed
> >>>
> >>>         0.000000000 seconds user
> >>>         0.010383000 seconds sys
> >>>
> >>> After this patch:
> >>> $ perf list hw
> >>>
> >>> List of pre-defined events (to be used in -e or -M):
> >>>
> >>>    branch-instructions OR branches [Hardware event]
> >>>    branch-misses [Hardware event]
> >>>    cache-misses [Hardware event]
> >>>    cache-references [Hardware event]
> >>>    cpu-cycles OR cycles [Hardware event]
> >>>    instructions [Hardware event]
> >>>
> >>> $ perf stat -ddd true
> >>>
> >>>   Performance counter stats for 'true':
> >>>
> >>>                5.16 msec task-clock                       # 0.848
> >>> CPUs utilized
> >>>                   1      context-switches                 # 193.817
> >>> /sec
> >>>                   0      cpu-migrations                   # 0.000 /se=
c
> >>>                  37      page-faults                      # 7.171 K/s=
ec
> >>>           5,183,625      cycles                           # 1.005 GHz
> >>>             961,696      instructions                     # 0.19
> >>> insn per cycle
> >>>              85,853      branches                         # 16.640
> >>> M/sec
> >>>              20,462      branch-misses                    # 23.83%
> >>> of all branches
> >>>             243,545      L1-dcache-loads                  # 47.203
> >>> M/sec
> >>>               5,974      L1-dcache-load-misses            # 2.45% of
> >>> all L1-dcache accesses
> >>>     <not supported>      LLC-loads
> >>>     <not supported>      LLC-load-misses
> >>>     <not supported>      L1-icache-loads
> >>>     <not supported>      L1-icache-load-misses
> >>>     <not supported>      dTLB-loads
> >>>              19,619      dTLB-load-misses
> >>>     <not supported>      iTLB-loads
> >>>               6,831      iTLB-load-misses
> >>>     <not supported>      L1-dcache-prefetches
> >>>     <not supported>      L1-dcache-prefetch-misses
> >>>
> >>>         0.006085625 seconds time elapsed
> >>>
> >>>         0.000000000 seconds user
> >>>         0.013022000 seconds sys
> >>>
> >>>
> >>> Changes in v2:
> >>>   - Move the event checking to a workqueue to make it asynchronous
> >>>   - Add more details to the commit message based on the v1 discussion
> >>>
> >>>   drivers/perf/riscv_pmu_sbi.c | 45
> >>> +++++++++++++++++++++++++++++++++---
> >>>   1 file changed, 42 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/perf/riscv_pmu_sbi.c
> >>> b/drivers/perf/riscv_pmu_sbi.c
> >>> index 8cbe6e5f9c39..c326954af066 100644
> >>> --- a/drivers/perf/riscv_pmu_sbi.c
> >>> +++ b/drivers/perf/riscv_pmu_sbi.c
> >>> @@ -20,6 +20,7 @@
> >>>   #include <linux/cpu_pm.h>
> >>>   #include <linux/sched/clock.h>
> >>>   #include <linux/soc/andes/irq.h>
> >>> +#include <linux/workqueue.h>
> >>>     #include <asm/errata_list.h>
> >>>   #include <asm/sbi.h>
> >>> @@ -109,7 +110,7 @@ struct sbi_pmu_event_data {
> >>>       };
> >>>   };
> >>>   -static const struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> >>> +static struct sbi_pmu_event_data pmu_hw_event_map[] =3D {
> >>>       [PERF_COUNT_HW_CPU_CYCLES]        =3D {.hw_gen_event =3D {
> >>>                               SBI_PMU_HW_CPU_CYCLES,
> >>>                               SBI_PMU_EVENT_TYPE_HW, 0}},
> >>> @@ -143,7 +144,7 @@ static const struct sbi_pmu_event_data
> >>> pmu_hw_event_map[] =3D {
> >>>   };
> >>>     #define C(x) PERF_COUNT_HW_CACHE_##x
> >>> -static const struct sbi_pmu_event_data
> >>> pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> >>> +static struct sbi_pmu_event_data
> >>> pmu_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> >>>   [PERF_COUNT_HW_CACHE_OP_MAX]
> >>>   [PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
> >>>       [C(L1D)] =3D {
> >>> @@ -288,6 +289,34 @@ static const struct sbi_pmu_event_data
> >>> pmu_cache_event_map[PERF_COUNT_HW_CACHE_M
> >>>       },
> >>>   };
> >>>   +static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
> >>> +{
> >>> +    struct sbiret ret;
> >>> +
> >>> +    ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
> >>> +            0, cmask, 0, edata->event_idx, 0, 0);
> >>> +    if (!ret.error) {
> >>> +        sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> >>> +              ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> >>> +    } else if (ret.error =3D=3D SBI_ERR_NOT_SUPPORTED) {
> >>> +        /* This event cannot be monitored by any counter */
> >>> +        edata->event_idx =3D -EINVAL;
> >>> +    }
> >>> +}
> >>> +
> >>> +static void pmu_sbi_check_std_events(struct work_struct *work)
> >>> +{
> >>> +    for (int i =3D 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
> >>> +        pmu_sbi_check_event(&pmu_hw_event_map[i]);
> >>> +
> >>> +    for (int i =3D 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
> >>> +        for (int j =3D 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j+=
+)
> >>> +            for (int k =3D 0; k <
> >>> ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
> >>> + pmu_sbi_check_event(&pmu_cache_event_map[i][j][k]);
> >>> +}
> >>> +
> >>> +static DECLARE_WORK(check_std_events_work, pmu_sbi_check_std_events)=
;
> >>> +
> >>>   static int pmu_sbi_ctr_get_width(int idx)
> >>>   {
> >>>       return pmu_ctr_list[idx].width;
> >>> @@ -473,6 +502,12 @@ static int pmu_sbi_event_map(struct perf_event
> >>> *event, u64 *econfig)
> >>>       u64 raw_config_val;
> >>>       int ret;
> >>>   +    /*
> >>> +     * Ensure we are finished checking standard hardware events for
> >>> +     * validity before allowing userspace to configure any events.
> >>> +     */
> >>> +    flush_work(&check_std_events_work);
> >>> +
> >>>       switch (type) {
> >>>       case PERF_TYPE_HARDWARE:
> >>>           if (config >=3D PERF_COUNT_HW_MAX)
> >>> @@ -634,7 +669,8 @@ static inline void pmu_sbi_stop_all(struct
> >>> riscv_pmu *pmu)
> >>>        * which may include counters that are not enabled yet.
> >>>        */
> >>>       sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
> >>> -          0, pmu->cmask, 0, 0, 0, 0);
> >>> +          0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
> >>> +
> >>
> >> Why is this required for this patch?
> >>
> >> If the intention is a generic improvement to reset mhpmevent at boot
> >> time, it should be separate patch.
> >>
> >>>   }
> >>>     static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
> >>> @@ -1108,6 +1144,9 @@ static int pmu_sbi_device_probe(struct
> >>> platform_device *pdev)
> >>>         register_sysctl("kernel", sbi_pmu_sysctl_table);
> >>>   +    /* Asynchronously check which standard events are available */
> >>> +    schedule_work(&check_std_events_work);
> >>> +
> >>>       return 0;
> >>>     out_unregister:
> >>
> >> Until we have the new SBI interface defined to optimize these SBI
> >> calls, we can use this individual call approach to fix the current
> >> issue.
> >>
> >> lgtm otherwise.
> >>
> >> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> >> Tested-by: Atish Patra <atishp@rivosinc.com>
> >
> >
> > Can you add a Fixes tag for this so that we can merge in 6.10-rcX?
> >
> > Thanks,
> >
> > Alex
>
>
> So I'd choose the following commit as a Fixes tag: e9991434596f
> ("RISC-V: Add perf platform driver based on SBI PMU extension")
>
> In addition, this patch does not apply cleanly on top of 6.10, the
> resolution I came up with is there
> https://github.com/linux-riscv/linux-riscv/pull/1043/commits/0a440d8b9e90=
117261f02f4d019359847c64cb38
>
> Can you guys check it's correct?
>

Looks okay to me. I will test it once again with the latest upstream.
As per my previous comment, I am still not sure if we need the
STOP_FLAG_RESET update in stop_all in this patch context[1].

@Samuel Holland : Let me know If you are busy with other things. I can
split the patch and send v3 if required.

[1] https://lore.kernel.org/linux-arm-kernel/79087773-9115-4d4c-b566-028a21=
049d61@rivosinc.com/T/#m75e4f6562338a0515464ebf60d35915f60edb71e

> Thanks,
>
> Alex
>
>
> >
> >
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish

