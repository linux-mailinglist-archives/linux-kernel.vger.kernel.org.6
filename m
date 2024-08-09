Return-Path: <linux-kernel+bounces-281083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE5F94D2D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187DC28250C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6338198A2F;
	Fri,  9 Aug 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4ppzYCu"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588219306F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215607; cv=none; b=DIXn+M03KzOCz4g0b7HAkpze0s9rBDmozr5B3xVHXf7QVoqjwnZQML1D4iVI4ALOp8eS3lXmRub3pLDWprbPheY233EXBCOCECbhtAZqZu9msJ8GESq3dveKsw9NgmeUd19ji5hMuFqSTNeh3DeJ3msZundpJIzypIDtK/suGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215607; c=relaxed/simple;
	bh=NG+OyY7N1YAHHr9E+SoeyIeqVKoHFXqAcQpeb9adPBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev6IYGh6noLXU1t2p5XHDNkajvwso8O4BhRO5v/TvxEqWEU9srPspfAD+eJPebglnyM2JhXIfphC8B6nczAeiJHouT6hzxZuGkFyguwFgZ6kEDQkCZeFhgpw7LEpREiIAo8ooiXBvvE7kJwBIRBlOS8y3bVQUwMWJ0G62Z9F5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4ppzYCu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-699d8dc6744so19720137b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723215603; x=1723820403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FzaQlKMY+XgcJFar+qm/IXeUetuX7JtYfUfmsTE1X4=;
        b=q4ppzYCuKQ6zGZrlt934EOQC4W1zG9kV38+S7LzdWDFYPm+4glju8oH+5JlOMeBCWR
         aO/e8iLGe7youOxq6TT46W4vPfLY78D0S3SUXd8itwzlsNHJfWhNOsH+25BXLJ0GIoT3
         TC8ZGZs8OQnal1xMOlKeX2XPm2qM9oUu/bk1IqlB8xcIfJa+2gSGxLsSY8csnzXrY4je
         8aGxYuxiA2lCJ84kxpTBqrQTtRfLTHQnXbgU/Tr5a/G5xxWCnUWa5lYq5VIEt15EAdw/
         Ip2Ur46TH5RfvWlrh8ZlVfi4/BJjQ/woDWkWWwGDNUaT4UaU6DiMqDScsodpfRjFCgyI
         hE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723215603; x=1723820403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FzaQlKMY+XgcJFar+qm/IXeUetuX7JtYfUfmsTE1X4=;
        b=ajlzt9t/1wa68ZzQpVwOTmNCcl1gLL9lbfAqy1AlTqindvykBlp51d6PnznWIDzk7i
         MhuNolbwBG5hZW7WQ/V4KW4IjGQlamYP6H1d39ciVAIv+4rk3eDc6GOiYqNJeteo6Qet
         NXD4uKK8S3AE1EPUPdOOarNzEqX3xI7L1yu5Z64NF3ywc+wVkHzEtcxH1kGtPFMlUE1t
         0CgAtszR3QcUHG9Yd4Z1h1omSE3ZN3SKM89XHxQATwVOYWhhAghO3bqmL8twvD4KfClh
         focuasfYq2e42bdFV2bcJsXKfOyXdq52u1UlKiIDFKb2MhOlX4gMFUI1bFq0oq/Uha+V
         5uQw==
X-Gm-Message-State: AOJu0YxsPLbkFghN1IMQIUX8jTiV/7733DKgV5NuhB+Xzbl2zUy9Ob8T
	WclvmMZ9nl/Mpl73LCzee0dBhga24VlOTT2Nto/f+XGYr3//Nyyxx9m3FlKj22n9+gny/ranQA6
	Y2sEoC8wjAsh16cqqFvy1AM4CTrLVOwFvOEy0
X-Google-Smtp-Source: AGHT+IEx+ei7jaw8xhbw2dlJdDH29KCP5OpcrSckGDNpzYTyBfQJGheMK+/AA6uTe8q+rnAn3nOpTaWI6gItjATmIfk=
X-Received: by 2002:a05:690c:2706:b0:697:7c82:e7c with SMTP id
 00721157ae682-69edc903b3cmr10040977b3.9.1723215602746; Fri, 09 Aug 2024
 08:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com> <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
 <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
 <CAJuCfpFXdx40UGRsXUYFgFGvEy-nM02f+TQ9nOPPepw6gbykmA@mail.gmail.com>
 <CAJuCfpH36sXvCaYL88nzi_8-Yr1tpxHuaLfCMqCac-zN6QHWmg@mail.gmail.com> <CAGudoHHB3PEQBbcmZwwLAUrNLUqwOt8fnantO--3mF19C1A+6g@mail.gmail.com>
In-Reply-To: <CAGudoHHB3PEQBbcmZwwLAUrNLUqwOt8fnantO--3mF19C1A+6g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 9 Aug 2024 14:59:49 +0000
Message-ID: <CAJuCfpF4CAzuX_YWfqpjK6xJmF3GguTC8cFoKkgY=VqNRBuSpA@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, pedro.falcato@gmail.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 8:15=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Fri, Aug 9, 2024 at 5:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Thu, Aug 8, 2024 at 9:19=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > >
> > > On Thu, Aug 8, 2024 at 1:04=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> > > >
> > > > On Thu, Aug 8, 2024 at 9:39=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > > >
> > > > > On Thu, Aug 8, 2024 at 7:00=E2=80=AFPM Mateusz Guzik <mjguzik@gma=
il.com> wrote:
> > > > > >
> > > > > > ACHTUNG: this is more of a request for benchmarking than a patc=
h
> > > > > > proposal at this stage
> > > > > >
> > > > > > I was pointed at your patch which moved the vma lock to a separ=
ate
> > > > > > allocation [1]. The commit message does not say anything about =
making
> > > > > > sure the object itself is allocated with proper alignment and I=
 found
> > > > > > that the cache creation lacks the HWCACHE_ALIGN flag, which may=
 or may
> > > > > > not be the problem.
> > > > > >
> > > > > > I verified with a simple one-liner than on a stock kernel the v=
mas keep
> > > > > > roaming around with a 16-byte alignment:
> > > > > > # bpftrace -e 'kretprobe:vm_area_alloc  { @[retval & 0x3f] =3D =
count(); }'
> > > > > > @[16]: 39
> > > > > > @[0]: 46
> > > > > > @[32]: 53
> > > > > > @[48]: 56
> > > > > >
> > > > > > Note the stock vma lock cache also lacks the alignment flag. Wh=
ile I
> > > > > > have not verified experimentally, if they are also romaing it w=
ould mean
> > > > > > that 2 unrelated vmas can false-share locks. If the patch below=
 is a
> > > > > > bust, the flag should probably be added to that one.
> > > > > >
> > > > > > The patch has slapped-around vma lock cache removal + HWALLOC f=
or the
> > > > > > vma cache. I left a pointer to not change relative offsets betw=
een
> > > > > > current fields. I does compile without CONFIG_PER_VMA_LOCK.
> > > > > >
> > > > > > Vlastimil says you tested a case where the struct got bloated t=
o 256
> > > > > > bytes, but the lock remained separate. It is unclear to me if t=
his
> > > > > > happened with allocations made with the HWCACHE_ALIGN flag thou=
gh.
> > > > > >
> > > > > > There is 0 urgency on my end, but it would be nice if you could=
 try
> > > > > > this out with your test rig.
> > > > >
> > > > > Hi Mateusz,
> > > > > Sure, I'll give it a spin but I'm not optimistic. Your code looks
> > > > > almost identical to my latest attempt where I tried placing vm_lo=
ck
> > > > > into different cachelines including a separate one and using
> > > > > HWCACHE_ALIGN. And yet all my attempts showed regression.
> > > > > Just FYI, the test I'm using is the pft-threads test from mmtests
> > > > > suite. I'll post results today evening.
> > > > > Thanks,
> > > > > Suren.
> > > >
> > > > Ok, well maybe you did not leave the pointer in place? :)
> > >
> > > True, maybe that will make a difference. I'll let you know soon.
> > >
> > > >
> > > > It is plausible the problem is on vs off cpu behavior of rwsems --
> > > > there is a corner case where they neglect to spin. It is plausible
> > > > perf goes down simply because there is less on cpu time.
> > > >
> > > > Thus you bench can you make sure to time(1)?
> > >
> > > Sure, will do once I'm home. Thanks for the hints!
> >
> > Unfortunately the same regression shows its ugly face:
> >
> > compare-mmtests.pl Hmean results:
> > Hmean     faults/cpu-1    471264.4904 (   0.00%)   473085.6736 *   0.39=
%*
> > Hmean     faults/cpu-4    434571.7116 (   0.00%)   431214.3974 *  -0.77=
%*
> > Hmean     faults/cpu-7    407755.3217 (   0.00%)   395773.4052 *  -2.94=
%*
> > Hmean     faults/cpu-12   335604.9251 (   0.00%)   285426.3358 * -14.95=
%*
> > Hmean     faults/cpu-21   187588.9077 (   0.00%)   171227.7179 *  -8.72=
%*
> > Hmean     faults/cpu-30   140875.7878 (   0.00%)   124120.3437 * -11.89=
%*
> > Hmean     faults/cpu-48   106175.5493 (   0.00%)    93073.1499 * -12.34=
%*
> > Hmean     faults/cpu-56    92585.2536 (   0.00%)    82837.4299 * -10.53=
%*
> > Hmean     faults/sec-1    470924.4946 (   0.00%)   472730.9937 *   0.38=
%*
> > Hmean     faults/sec-4   1714823.8198 (   0.00%)  1693226.7248 *  -1.26=
%*
> > Hmean     faults/sec-7   2801395.1898 (   0.00%)  2717561.9417 *  -2.99=
%*
> > Hmean     faults/sec-12  3934168.2690 (   0.00%)  3319710.7540 * -15.62=
%*
> > Hmean     faults/sec-21  3736832.4592 (   0.00%)  3444687.9145 *  -7.82=
%*
> > Hmean     faults/sec-30  3845187.2636 (   0.00%)  3403585.7064 * -11.48=
%*
> > Hmean     faults/sec-48  4712317.7461 (   0.00%)  4180658.4710 * -11.28=
%*
> > Hmean     faults/sec-56  4873233.9844 (   0.00%)  4423608.6568 *  -9.23=
%*
> >
> > This is the time(1) output with the baseline:
> > 920.47user 7748.31system 18:30.85elapsed 780%CPU (0avgtext+0avgdata
> > 26385096maxresident)k
> > 140848inputs+19744outputs (66major+1583463207minor)pagefaults 0swaps
> >
> > This is the time(1) output with your change:
> > 1025.73user 8618.74system 19:10.79elapsed 838%CPU (0avgtext+0avgdata
> > 26385116maxresident)k
> > 16584inputs+19512outputs (61major+1583468687minor)pagefaults 0swaps
> >
> > Maybe it has something to do with NUMA? The system I'm running has 2 NU=
MA nodes:
> >
>
> hrmpf. final cheap stab I forgot to mention is that plausibly this is
> all about the adjacent cacheline prefetcher.
>
> google-fu temporarily fails me, but there was a one-liner to toggle
> that on Linux. Worst case you can flip it in the BIOS

Is "L2 Adjacent Cache Line Prefetcher" described in
https://www.intel.com/content/dam/develop/external/us/en/documents/335592-s=
dm-vol-4.pdf
the feature you are referring to? Searching through some discussions
looks like I'll need MSR tools to enable/disable it:
https://mirrors.edge.kernel.org/pub/linux/utils/cpu/msr-tools/. I'll
try poking with it over the weekend and see what happens.

> if that does not change anything, I'm going to grab a numa box of
> similar scale to poke around myself, but I don't have an ETA
>
> even so, do you have a handy one-liner to run the case with 56
> threads?

Never tried restricting to only 56 threads before but I assume that
changing lines in configs/config-workload-pft-threads:
export PFT_MIN_CLIENTS=3D1
export PFT_MAX_CLIENTS=3D$NUMCPUS
to
export PFT_MIN_CLIENTS=3D$NUMCPUS
export PFT_MAX_CLIENTS=3D$NUMCPUS

should do the trick. If it doesn't I'll ask Mel.

> *maybe* comparing instructions which generate cache misses
> before/after will explain what's up

Any instructions/docs on how to capture this info?
Thanks,
Suren.

>
> > $ lscpu
> > Architecture:             x86_64
> >   CPU op-mode(s):         32-bit, 64-bit
> >   Address sizes:          46 bits physical, 48 bits virtual
> >   Byte Order:             Little Endian
> > CPU(s):                   56
> >   On-line CPU(s) list:    0-55
> > Vendor ID:                GenuineIntel
> >   Model name:             Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
> >     CPU family:           6
> >     Model:                79
> >     Thread(s) per core:   2
> >     Core(s) per socket:   14
> >     Socket(s):            2
> >     Stepping:             1
> >     CPU max MHz:          3500.0000
> >     CPU min MHz:          1200.0000
> >     BogoMIPS:             5188.26
> >     Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep
> > mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
> > tm pbe syscall nx pdpe1gb rdtscp lm constant_ts
> >                           c arch_perfmon pebs bts rep_good nopl
> > xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
> > ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm p
> >                           cid dca sse4_1 sse4_2 x2apic movbe popcnt
> > tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
> > cpuid_fault epb cat_l3 cdp_l3 pti intel_ppin ss
> >                           bd ibrs ibpb stibp tpr_shadow flexpriority
> > ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> > invpcid rtm cqm rdt_a rdseed adx smap intel_pt xsave
> >                           opt cqm_llc cqm_occup_llc cqm_mbm_total
> > cqm_mbm_local dtherm ida arat pln pts vnmi md_clear flush_l1d
> > Virtualization features:
> >   Virtualization:         VT-x
> > Caches (sum of all):
> >   L1d:                    896 KiB (28 instances)
> >   L1i:                    896 KiB (28 instances)
> >   L2:                     7 MiB (28 instances)
> >   L3:                     70 MiB (2 instances)
> > NUMA:
> >   NUMA node(s):           2
> >   NUMA node0 CPU(s):      0-13,28-41
> >   NUMA node1 CPU(s):      14-27,42-55
> >
> > Any ideas?
> >
> >
> >
> >
> >
> >
> >
> >
> > >
> > > >
> > > > For example with zsh I got:
> > > > ./run-mmtests.sh --no-monitor --config configs/config-workload-pft-=
threads
> > > >
> > > > 39.35s user 445.45s system 390% cpu 124.04s (2:04.04) total
> > > >
> > > > I verified with offcputime-bpfcc -K that indeed there is a bunch of
> > > > pft going off cpu from down_read/down_write even at the modest scal=
e
> > > > this was running in my case.
> > > >
> > > > >
> > > > > >
> > > > > > 1: https://lore.kernel.org/all/20230227173632.3292573-34-surenb=
@google.com/T/#u
> > > > > >
> > > > > > ---
> > > > > >  include/linux/mm.h       | 18 +++++++--------
> > > > > >  include/linux/mm_types.h | 10 ++++-----
> > > > > >  kernel/fork.c            | 47 ++++----------------------------=
--------
> > > > > >  mm/userfaultfd.c         |  6 ++---
> > > > > >  4 files changed, 19 insertions(+), 62 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > index 43b40334e9b2..6d8b668d3deb 100644
> > > > > > --- a/include/linux/mm.h
> > > > > > +++ b/include/linux/mm.h
> > > > > > @@ -687,7 +687,7 @@ static inline bool vma_start_read(struct vm=
_area_struct *vma)
> > > > > >         if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->v=
m_mm->mm_lock_seq))
> > > > > >                 return false;
> > > > > >
> > > > > > -       if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=
=3D 0))
> > > > > > +       if (unlikely(down_read_trylock(&vma->vm_lock) =3D=3D 0)=
)
> > > > > >                 return false;
> > > > > >
> > > > > >         /*
> > > > > > @@ -702,7 +702,7 @@ static inline bool vma_start_read(struct vm=
_area_struct *vma)
> > > > > >          * This pairs with RELEASE semantics in vma_end_write_a=
ll().
> > > > > >          */
> > > > > >         if (unlikely(vma->vm_lock_seq =3D=3D smp_load_acquire(&=
vma->vm_mm->mm_lock_seq))) {
> > > > > > -               up_read(&vma->vm_lock->lock);
> > > > > > +               up_read(&vma->vm_lock);
> > > > > >                 return false;
> > > > > >         }
> > > > > >         return true;
> > > > > > @@ -711,7 +711,7 @@ static inline bool vma_start_read(struct vm=
_area_struct *vma)
> > > > > >  static inline void vma_end_read(struct vm_area_struct *vma)
> > > > > >  {
> > > > > >         rcu_read_lock(); /* keeps vma alive till the end of up_=
read */
> > > > > > -       up_read(&vma->vm_lock->lock);
> > > > > > +       up_read(&vma->vm_lock);
> > > > > >         rcu_read_unlock();
> > > > > >  }
> > > > > >
> > > > > > @@ -740,7 +740,7 @@ static inline void vma_start_write(struct v=
m_area_struct *vma)
> > > > > >         if (__is_vma_write_locked(vma, &mm_lock_seq))
> > > > > >                 return;
> > > > > >
> > > > > > -       down_write(&vma->vm_lock->lock);
> > > > > > +       down_write(&vma->vm_lock);
> > > > > >         /*
> > > > > >          * We should use WRITE_ONCE() here because we can have =
concurrent reads
> > > > > >          * from the early lockless pessimistic check in vma_sta=
rt_read().
> > > > > > @@ -748,7 +748,7 @@ static inline void vma_start_write(struct v=
m_area_struct *vma)
> > > > > >          * we should use WRITE_ONCE() for cleanliness and to ke=
ep KCSAN happy.
> > > > > >          */
> > > > > >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > > > > > -       up_write(&vma->vm_lock->lock);
> > > > > > +       up_write(&vma->vm_lock);
> > > > > >  }
> > > > > >
> > > > > >  static inline void vma_assert_write_locked(struct vm_area_stru=
ct *vma)
> > > > > > @@ -760,7 +760,7 @@ static inline void vma_assert_write_locked(=
struct vm_area_struct *vma)
> > > > > >
> > > > > >  static inline void vma_assert_locked(struct vm_area_struct *vm=
a)
> > > > > >  {
> > > > > > -       if (!rwsem_is_locked(&vma->vm_lock->lock))
> > > > > > +       if (!rwsem_is_locked(&vma->vm_lock))
> > > > > >                 vma_assert_write_locked(vma);
> > > > > >  }
> > > > > >
> > > > > > @@ -827,10 +827,6 @@ static inline void assert_fault_locked(str=
uct vm_fault *vmf)
> > > > > >
> > > > > >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> > > > > >
> > > > > > -/*
> > > > > > - * WARNING: vma_init does not initialize vma->vm_lock.
> > > > > > - * Use vm_area_alloc()/vm_area_free() if vma needs locking.
> > > > > > - */
> > > > > >  static inline void vma_init(struct vm_area_struct *vma, struct=
 mm_struct *mm)
> > > > > >  {
> > > > > >         memset(vma, 0, sizeof(*vma));
> > > > > > @@ -839,6 +835,8 @@ static inline void vma_init(struct vm_area_=
struct *vma, struct mm_struct *mm)
> > > > > >         INIT_LIST_HEAD(&vma->anon_vma_chain);
> > > > > >         vma_mark_detached(vma, false);
> > > > > >         vma_numab_state_init(vma);
> > > > > > +       init_rwsem(&vma->vm_lock);
> > > > > > +       vma->vm_lock_seq =3D -1;
> > > > > >  }
> > > > > >
> > > > > >  /* Use when VMA is not part of the VMA tree and needs no locki=
ng */
> > > > > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.=
h
> > > > > > index 003619fab20e..caffdb4eeb94 100644
> > > > > > --- a/include/linux/mm_types.h
> > > > > > +++ b/include/linux/mm_types.h
> > > > > > @@ -615,10 +615,6 @@ static inline struct anon_vma_name *anon_v=
ma_name_alloc(const char *name)
> > > > > >  }
> > > > > >  #endif
> > > > > >
> > > > > > -struct vma_lock {
> > > > > > -       struct rw_semaphore lock;
> > > > > > -};
> > > > > > -
> > > > > >  struct vma_numab_state {
> > > > > >         /*
> > > > > >          * Initialised as time in 'jiffies' after which VMA
> > > > > > @@ -716,8 +712,7 @@ struct vm_area_struct {
> > > > > >          * slowpath.
> > > > > >          */
> > > > > >         int vm_lock_seq;
> > > > > > -       /* Unstable RCU readers are allowed to read this. */
> > > > > > -       struct vma_lock *vm_lock;
> > > > > > +       void *vm_dummy;
> > > > > >  #endif
> > > > > >
> > > > > >         /*
> > > > > > @@ -770,6 +765,9 @@ struct vm_area_struct {
> > > > > >         struct vma_numab_state *numab_state;    /* NUMA Balanci=
ng state */
> > > > > >  #endif
> > > > > >         struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > > +       struct rw_semaphore vm_lock ____cacheline_aligned_in_sm=
p;
> > > > > > +#endif
> > > > > >  } __randomize_layout;
> > > > > >
> > > > > >  #ifdef CONFIG_NUMA
> > > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > > index 92bfe56c9fed..eab04a24d5f1 100644
> > > > > > --- a/kernel/fork.c
> > > > > > +++ b/kernel/fork.c
> > > > > > @@ -436,35 +436,6 @@ static struct kmem_cache *vm_area_cachep;
> > > > > >  /* SLAB cache for mm_struct structures (tsk->mm) */
> > > > > >  static struct kmem_cache *mm_cachep;
> > > > > >
> > > > > > -#ifdef CONFIG_PER_VMA_LOCK
> > > > > > -
> > > > > > -/* SLAB cache for vm_area_struct.lock */
> > > > > > -static struct kmem_cache *vma_lock_cachep;
> > > > > > -
> > > > > > -static bool vma_lock_alloc(struct vm_area_struct *vma)
> > > > > > -{
> > > > > > -       vma->vm_lock =3D kmem_cache_alloc(vma_lock_cachep, GFP_=
KERNEL);
> > > > > > -       if (!vma->vm_lock)
> > > > > > -               return false;
> > > > > > -
> > > > > > -       init_rwsem(&vma->vm_lock->lock);
> > > > > > -       vma->vm_lock_seq =3D -1;
> > > > > > -
> > > > > > -       return true;
> > > > > > -}
> > > > > > -
> > > > > > -static inline void vma_lock_free(struct vm_area_struct *vma)
> > > > > > -{
> > > > > > -       kmem_cache_free(vma_lock_cachep, vma->vm_lock);
> > > > > > -}
> > > > > > -
> > > > > > -#else /* CONFIG_PER_VMA_LOCK */
> > > > > > -
> > > > > > -static inline bool vma_lock_alloc(struct vm_area_struct *vma) =
{ return true; }
> > > > > > -static inline void vma_lock_free(struct vm_area_struct *vma) {=
}
> > > > > > -
> > > > > > -#endif /* CONFIG_PER_VMA_LOCK */
> > > > > > -
> > > > > >  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> > > > > >  {
> > > > > >         struct vm_area_struct *vma;
> > > > > > @@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struc=
t mm_struct *mm)
> > > > > >                 return NULL;
> > > > > >
> > > > > >         vma_init(vma, mm);
> > > > > > -       if (!vma_lock_alloc(vma)) {
> > > > > > -               kmem_cache_free(vm_area_cachep, vma);
> > > > > > -               return NULL;
> > > > > > -       }
> > > > > >
> > > > > >         return vma;
> > > > > >  }
> > > > > > @@ -496,10 +463,8 @@ struct vm_area_struct *vm_area_dup(struct =
vm_area_struct *orig)
> > > > > >          * will be reinitialized.
> > > > > >          */
> > > > > >         data_race(memcpy(new, orig, sizeof(*new)));
> > > > > > -       if (!vma_lock_alloc(new)) {
> > > > > > -               kmem_cache_free(vm_area_cachep, new);
> > > > > > -               return NULL;
> > > > > > -       }
> > > > > > +       init_rwsem(&new->vm_lock);
> > > > > > +       new->vm_lock_seq =3D -1;
> > > > > >         INIT_LIST_HEAD(&new->anon_vma_chain);
> > > > > >         vma_numab_state_init(new);
> > > > > >         dup_anon_vma_name(orig, new);
> > > > > > @@ -511,7 +476,6 @@ void __vm_area_free(struct vm_area_struct *=
vma)
> > > > > >  {
> > > > > >         vma_numab_state_free(vma);
> > > > > >         free_anon_vma_name(vma);
> > > > > > -       vma_lock_free(vma);
> > > > > >         kmem_cache_free(vm_area_cachep, vma);
> > > > > >  }
> > > > > >
> > > > > > @@ -522,7 +486,7 @@ static void vm_area_free_rcu_cb(struct rcu_=
head *head)
> > > > > >                                                   vm_rcu);
> > > > > >
> > > > > >         /* The vma should not be locked while being destroyed. =
*/
> > > > > > -       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma=
);
> > > > > > +       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock), vma);
> > > > > >         __vm_area_free(vma);
> > > > > >  }
> > > > > >  #endif
> > > > > > @@ -3192,10 +3156,7 @@ void __init proc_caches_init(void)
> > > > > >                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCO=
UNT,
> > > > > >                         NULL);
> > > > > >
> > > > > > -       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANI=
C|SLAB_ACCOUNT);
> > > > > > -#ifdef CONFIG_PER_VMA_LOCK
> > > > > > -       vma_lock_cachep =3D KMEM_CACHE(vma_lock, SLAB_PANIC|SLA=
B_ACCOUNT);
> > > > > > -#endif
> > > > > > +       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANI=
C|SLAB_ACCOUNT|SLAB_HWCACHE_ALIGN);
> > > > > >         mmap_init();
> > > > > >         nsproxy_cache_init();
> > > > > >  }
> > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > index 3b7715ecf292..e95ecb2063d2 100644
> > > > > > --- a/mm/userfaultfd.c
> > > > > > +++ b/mm/userfaultfd.c
> > > > > > @@ -92,7 +92,7 @@ static struct vm_area_struct *uffd_lock_vma(s=
truct mm_struct *mm,
> > > > > >                  * mmap_lock, which guarantees that nobody can =
lock the
> > > > > >                  * vma for write (vma_start_write()) under us.
> > > > > >                  */
> > > > > > -               down_read(&vma->vm_lock->lock);
> > > > > > +               down_read(&vma->vm_lock);
> > > > > >         }
> > > > > >
> > > > > >         mmap_read_unlock(mm);
> > > > > > @@ -1468,9 +1468,9 @@ static int uffd_move_lock(struct mm_struc=
t *mm,
> > > > > >                  * See comment in uffd_lock_vma() as to why not=
 using
> > > > > >                  * vma_start_read() here.
> > > > > >                  */
> > > > > > -               down_read(&(*dst_vmap)->vm_lock->lock);
> > > > > > +               down_read(&(*dst_vmap)->vm_lock);
> > > > > >                 if (*dst_vmap !=3D *src_vmap)
> > > > > > -                       down_read_nested(&(*src_vmap)->vm_lock-=
>lock,
> > > > > > +                       down_read_nested(&(*src_vmap)->vm_lock,
> > > > > >                                          SINGLE_DEPTH_NESTING);
> > > > > >         }
> > > > > >         mmap_read_unlock(mm);
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Mateusz Guzik <mjguzik gmail.com>
>
>
>
> --
> Mateusz Guzik <mjguzik gmail.com>

