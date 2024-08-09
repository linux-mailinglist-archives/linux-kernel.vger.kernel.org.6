Return-Path: <linux-kernel+bounces-280544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD14594CBFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D191F1C21C19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACEE16DC2D;
	Fri,  9 Aug 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/+pM1KQ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB062171
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191317; cv=none; b=uZPaE5JVrsROAZ2ZvAPAz7A+jjgLoMGKaSnWaiHzNHScS4RGyU7Q0jBaEOf2CtYncPYuDh2LJCY8zixdhtqcaF9UootbKPgnOvL+sdAUyxGdumtYekTkWEj9KGZ73gZK9MdThuUVuyKbXGbAWNZTxDjtIA5fI6/YEvvFV2/8WTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191317; c=relaxed/simple;
	bh=mht7Y3Q1bqg0pRZQxyXqf8ebDRpUDdz8Zsp+lTG2Cjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCbrCtZ8RNHN2k8w/cEgmUpN2scqvIb3r4bikxheLnqDGfhqYFjKEYZ6p926EIevnKLre81D//lpOwxcHjxtkQHyGqvz6iF9X0rbAF1x5Q2z0bMvqW5FlMSU4FKizKQe0/9E/FSMSpYRX+KZltewJzhZabihuW3353uXB5x1O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/+pM1KQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa7bso2147680a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723191313; x=1723796113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTY3OFn8xmWS9BaXbrM/9l+/iBTQNq3zaueVhWRUhf8=;
        b=Q/+pM1KQDy5peYIlx5OFKe1IqGSU2KsoYWgpZTTYntGFcNJlLw/cIZS4OqbDVu9wZp
         jB1WD/44nwgGAHRIsjHjZx9qvs9eI6awM25KNNCyckm0Vy0EDV2UlHHFujHe+kl2OL+m
         NsODFVB4aHJl1tHbbrcn5CZ1bSSLJucqtYp/mBT27s4c4y3RENKlvf8mu60mMAbBuiVL
         9gxiq60EfwFx6U9KYIgEFPPSLcNoiZCI5Ez1qZ39nxyYyh2lGP+JgMWRbF4Je0gaC91j
         5ab0bZbxevQWqzC3ChubTZgpeN5ems9Hsm+gj9uUa3QMlokTdXsgvMRsDMNk/gMHGi3u
         OmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723191313; x=1723796113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTY3OFn8xmWS9BaXbrM/9l+/iBTQNq3zaueVhWRUhf8=;
        b=IS9KIeBENLq+oSA7m8UmPKp9JxAIxGzWHQhnDn7P3F/1lm+qngYHACRi6R4knMoHgX
         9gy4uF+dDoT6alqtSxqo9NJhqDhLjnkBCNLsKXsBnO1KcOkwMddkO6n6Vb1VppDo373X
         S6rBHJoAeCikvEc5nTGyIJAjKJxpRHRi4T4xaqUYrIztlDnpEwr0KbDbLa1+4wd5outz
         Xoc5oL6jOCOYtlFeNht9L6FbpbE/4/8AOz4uZSNf/PXMyyS0Hhbd2O9Slpi5UqIOFyfZ
         GhD31ZHdIkYISFUGURuaFKyZSZUrsi+9vppCoi1B6kCPb1zgN8OaV+eF2vxDbYB3k7t0
         KEQQ==
X-Gm-Message-State: AOJu0Yy0VPzXdBwxTlekfiDgVQrs1EHZX6QX10MOQYDRgOHAfe57WF3i
	O5Su+qAQdq78t3/hblRpCSg19poTMWrIajJa9U8UFNLeXoHAu+2OzE6Vo43gEmMROOdMTeCedbQ
	85rswusaKwsjGNgeyGpLIZqDIzL4=
X-Google-Smtp-Source: AGHT+IGiPO5v32DWtLwQFdYePAJVXi0zCEhdLWuvX1iXJVCrV/J6gfKCgXG6r3xipl43sMqgS93Z6mJDlQIWL20n/9Q=
X-Received: by 2002:a17:907:e697:b0:a7a:a212:be4e with SMTP id
 a640c23a62f3a-a80aa5516cdmr63270466b.7.1723191312590; Fri, 09 Aug 2024
 01:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com> <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
 <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
 <CAJuCfpFXdx40UGRsXUYFgFGvEy-nM02f+TQ9nOPPepw6gbykmA@mail.gmail.com> <CAJuCfpH36sXvCaYL88nzi_8-Yr1tpxHuaLfCMqCac-zN6QHWmg@mail.gmail.com>
In-Reply-To: <CAJuCfpH36sXvCaYL88nzi_8-Yr1tpxHuaLfCMqCac-zN6QHWmg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 9 Aug 2024 10:14:58 +0200
Message-ID: <CAGudoHHB3PEQBbcmZwwLAUrNLUqwOt8fnantO--3mF19C1A+6g@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, pedro.falcato@gmail.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Thu, Aug 8, 2024 at 9:19=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Thu, Aug 8, 2024 at 1:04=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
> > >
> > > On Thu, Aug 8, 2024 at 9:39=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > >
> > > > On Thu, Aug 8, 2024 at 7:00=E2=80=AFPM Mateusz Guzik <mjguzik@gmail=
.com> wrote:
> > > > >
> > > > > ACHTUNG: this is more of a request for benchmarking than a patch
> > > > > proposal at this stage
> > > > >
> > > > > I was pointed at your patch which moved the vma lock to a separat=
e
> > > > > allocation [1]. The commit message does not say anything about ma=
king
> > > > > sure the object itself is allocated with proper alignment and I f=
ound
> > > > > that the cache creation lacks the HWCACHE_ALIGN flag, which may o=
r may
> > > > > not be the problem.
> > > > >
> > > > > I verified with a simple one-liner than on a stock kernel the vma=
s keep
> > > > > roaming around with a 16-byte alignment:
> > > > > # bpftrace -e 'kretprobe:vm_area_alloc  { @[retval & 0x3f] =3D co=
unt(); }'
> > > > > @[16]: 39
> > > > > @[0]: 46
> > > > > @[32]: 53
> > > > > @[48]: 56
> > > > >
> > > > > Note the stock vma lock cache also lacks the alignment flag. Whil=
e I
> > > > > have not verified experimentally, if they are also romaing it wou=
ld mean
> > > > > that 2 unrelated vmas can false-share locks. If the patch below i=
s a
> > > > > bust, the flag should probably be added to that one.
> > > > >
> > > > > The patch has slapped-around vma lock cache removal + HWALLOC for=
 the
> > > > > vma cache. I left a pointer to not change relative offsets betwee=
n
> > > > > current fields. I does compile without CONFIG_PER_VMA_LOCK.
> > > > >
> > > > > Vlastimil says you tested a case where the struct got bloated to =
256
> > > > > bytes, but the lock remained separate. It is unclear to me if thi=
s
> > > > > happened with allocations made with the HWCACHE_ALIGN flag though=
.
> > > > >
> > > > > There is 0 urgency on my end, but it would be nice if you could t=
ry
> > > > > this out with your test rig.
> > > >
> > > > Hi Mateusz,
> > > > Sure, I'll give it a spin but I'm not optimistic. Your code looks
> > > > almost identical to my latest attempt where I tried placing vm_lock
> > > > into different cachelines including a separate one and using
> > > > HWCACHE_ALIGN. And yet all my attempts showed regression.
> > > > Just FYI, the test I'm using is the pft-threads test from mmtests
> > > > suite. I'll post results today evening.
> > > > Thanks,
> > > > Suren.
> > >
> > > Ok, well maybe you did not leave the pointer in place? :)
> >
> > True, maybe that will make a difference. I'll let you know soon.
> >
> > >
> > > It is plausible the problem is on vs off cpu behavior of rwsems --
> > > there is a corner case where they neglect to spin. It is plausible
> > > perf goes down simply because there is less on cpu time.
> > >
> > > Thus you bench can you make sure to time(1)?
> >
> > Sure, will do once I'm home. Thanks for the hints!
>
> Unfortunately the same regression shows its ugly face:
>
> compare-mmtests.pl Hmean results:
> Hmean     faults/cpu-1    471264.4904 (   0.00%)   473085.6736 *   0.39%*
> Hmean     faults/cpu-4    434571.7116 (   0.00%)   431214.3974 *  -0.77%*
> Hmean     faults/cpu-7    407755.3217 (   0.00%)   395773.4052 *  -2.94%*
> Hmean     faults/cpu-12   335604.9251 (   0.00%)   285426.3358 * -14.95%*
> Hmean     faults/cpu-21   187588.9077 (   0.00%)   171227.7179 *  -8.72%*
> Hmean     faults/cpu-30   140875.7878 (   0.00%)   124120.3437 * -11.89%*
> Hmean     faults/cpu-48   106175.5493 (   0.00%)    93073.1499 * -12.34%*
> Hmean     faults/cpu-56    92585.2536 (   0.00%)    82837.4299 * -10.53%*
> Hmean     faults/sec-1    470924.4946 (   0.00%)   472730.9937 *   0.38%*
> Hmean     faults/sec-4   1714823.8198 (   0.00%)  1693226.7248 *  -1.26%*
> Hmean     faults/sec-7   2801395.1898 (   0.00%)  2717561.9417 *  -2.99%*
> Hmean     faults/sec-12  3934168.2690 (   0.00%)  3319710.7540 * -15.62%*
> Hmean     faults/sec-21  3736832.4592 (   0.00%)  3444687.9145 *  -7.82%*
> Hmean     faults/sec-30  3845187.2636 (   0.00%)  3403585.7064 * -11.48%*
> Hmean     faults/sec-48  4712317.7461 (   0.00%)  4180658.4710 * -11.28%*
> Hmean     faults/sec-56  4873233.9844 (   0.00%)  4423608.6568 *  -9.23%*
>
> This is the time(1) output with the baseline:
> 920.47user 7748.31system 18:30.85elapsed 780%CPU (0avgtext+0avgdata
> 26385096maxresident)k
> 140848inputs+19744outputs (66major+1583463207minor)pagefaults 0swaps
>
> This is the time(1) output with your change:
> 1025.73user 8618.74system 19:10.79elapsed 838%CPU (0avgtext+0avgdata
> 26385116maxresident)k
> 16584inputs+19512outputs (61major+1583468687minor)pagefaults 0swaps
>
> Maybe it has something to do with NUMA? The system I'm running has 2 NUMA=
 nodes:
>

hrmpf. final cheap stab I forgot to mention is that plausibly this is
all about the adjacent cacheline prefetcher.

google-fu temporarily fails me, but there was a one-liner to toggle
that on Linux. Worst case you can flip it in the BIOS

if that does not change anything, I'm going to grab a numa box of
similar scale to poke around myself, but I don't have an ETA

even so, do you have a handy one-liner to run the case with 56
threads? *maybe* comparing instructions which generate cache misses
before/after will explain what's up

> $ lscpu
> Architecture:             x86_64
>   CPU op-mode(s):         32-bit, 64-bit
>   Address sizes:          46 bits physical, 48 bits virtual
>   Byte Order:             Little Endian
> CPU(s):                   56
>   On-line CPU(s) list:    0-55
> Vendor ID:                GenuineIntel
>   Model name:             Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
>     CPU family:           6
>     Model:                79
>     Thread(s) per core:   2
>     Core(s) per socket:   14
>     Socket(s):            2
>     Stepping:             1
>     CPU max MHz:          3500.0000
>     CPU min MHz:          1200.0000
>     BogoMIPS:             5188.26
>     Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep
> mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht
> tm pbe syscall nx pdpe1gb rdtscp lm constant_ts
>                           c arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
> ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm p
>                           cid dca sse4_1 sse4_2 x2apic movbe popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
> cpuid_fault epb cat_l3 cdp_l3 pti intel_ppin ss
>                           bd ibrs ibpb stibp tpr_shadow flexpriority
> ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm cqm rdt_a rdseed adx smap intel_pt xsave
>                           opt cqm_llc cqm_occup_llc cqm_mbm_total
> cqm_mbm_local dtherm ida arat pln pts vnmi md_clear flush_l1d
> Virtualization features:
>   Virtualization:         VT-x
> Caches (sum of all):
>   L1d:                    896 KiB (28 instances)
>   L1i:                    896 KiB (28 instances)
>   L2:                     7 MiB (28 instances)
>   L3:                     70 MiB (2 instances)
> NUMA:
>   NUMA node(s):           2
>   NUMA node0 CPU(s):      0-13,28-41
>   NUMA node1 CPU(s):      14-27,42-55
>
> Any ideas?
>
>
>
>
>
>
>
>
> >
> > >
> > > For example with zsh I got:
> > > ./run-mmtests.sh --no-monitor --config configs/config-workload-pft-th=
reads
> > >
> > > 39.35s user 445.45s system 390% cpu 124.04s (2:04.04) total
> > >
> > > I verified with offcputime-bpfcc -K that indeed there is a bunch of
> > > pft going off cpu from down_read/down_write even at the modest scale
> > > this was running in my case.
> > >
> > > >
> > > > >
> > > > > 1: https://lore.kernel.org/all/20230227173632.3292573-34-surenb@g=
oogle.com/T/#u
> > > > >
> > > > > ---
> > > > >  include/linux/mm.h       | 18 +++++++--------
> > > > >  include/linux/mm_types.h | 10 ++++-----
> > > > >  kernel/fork.c            | 47 ++++------------------------------=
------
> > > > >  mm/userfaultfd.c         |  6 ++---
> > > > >  4 files changed, 19 insertions(+), 62 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > index 43b40334e9b2..6d8b668d3deb 100644
> > > > > --- a/include/linux/mm.h
> > > > > +++ b/include/linux/mm.h
> > > > > @@ -687,7 +687,7 @@ static inline bool vma_start_read(struct vm_a=
rea_struct *vma)
> > > > >         if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_=
mm->mm_lock_seq))
> > > > >                 return false;
> > > > >
> > > > > -       if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=
=3D 0))
> > > > > +       if (unlikely(down_read_trylock(&vma->vm_lock) =3D=3D 0))
> > > > >                 return false;
> > > > >
> > > > >         /*
> > > > > @@ -702,7 +702,7 @@ static inline bool vma_start_read(struct vm_a=
rea_struct *vma)
> > > > >          * This pairs with RELEASE semantics in vma_end_write_all=
().
> > > > >          */
> > > > >         if (unlikely(vma->vm_lock_seq =3D=3D smp_load_acquire(&vm=
a->vm_mm->mm_lock_seq))) {
> > > > > -               up_read(&vma->vm_lock->lock);
> > > > > +               up_read(&vma->vm_lock);
> > > > >                 return false;
> > > > >         }
> > > > >         return true;
> > > > > @@ -711,7 +711,7 @@ static inline bool vma_start_read(struct vm_a=
rea_struct *vma)
> > > > >  static inline void vma_end_read(struct vm_area_struct *vma)
> > > > >  {
> > > > >         rcu_read_lock(); /* keeps vma alive till the end of up_re=
ad */
> > > > > -       up_read(&vma->vm_lock->lock);
> > > > > +       up_read(&vma->vm_lock);
> > > > >         rcu_read_unlock();
> > > > >  }
> > > > >
> > > > > @@ -740,7 +740,7 @@ static inline void vma_start_write(struct vm_=
area_struct *vma)
> > > > >         if (__is_vma_write_locked(vma, &mm_lock_seq))
> > > > >                 return;
> > > > >
> > > > > -       down_write(&vma->vm_lock->lock);
> > > > > +       down_write(&vma->vm_lock);
> > > > >         /*
> > > > >          * We should use WRITE_ONCE() here because we can have co=
ncurrent reads
> > > > >          * from the early lockless pessimistic check in vma_start=
_read().
> > > > > @@ -748,7 +748,7 @@ static inline void vma_start_write(struct vm_=
area_struct *vma)
> > > > >          * we should use WRITE_ONCE() for cleanliness and to keep=
 KCSAN happy.
> > > > >          */
> > > > >         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> > > > > -       up_write(&vma->vm_lock->lock);
> > > > > +       up_write(&vma->vm_lock);
> > > > >  }
> > > > >
> > > > >  static inline void vma_assert_write_locked(struct vm_area_struct=
 *vma)
> > > > > @@ -760,7 +760,7 @@ static inline void vma_assert_write_locked(st=
ruct vm_area_struct *vma)
> > > > >
> > > > >  static inline void vma_assert_locked(struct vm_area_struct *vma)
> > > > >  {
> > > > > -       if (!rwsem_is_locked(&vma->vm_lock->lock))
> > > > > +       if (!rwsem_is_locked(&vma->vm_lock))
> > > > >                 vma_assert_write_locked(vma);
> > > > >  }
> > > > >
> > > > > @@ -827,10 +827,6 @@ static inline void assert_fault_locked(struc=
t vm_fault *vmf)
> > > > >
> > > > >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> > > > >
> > > > > -/*
> > > > > - * WARNING: vma_init does not initialize vma->vm_lock.
> > > > > - * Use vm_area_alloc()/vm_area_free() if vma needs locking.
> > > > > - */
> > > > >  static inline void vma_init(struct vm_area_struct *vma, struct m=
m_struct *mm)
> > > > >  {
> > > > >         memset(vma, 0, sizeof(*vma));
> > > > > @@ -839,6 +835,8 @@ static inline void vma_init(struct vm_area_st=
ruct *vma, struct mm_struct *mm)
> > > > >         INIT_LIST_HEAD(&vma->anon_vma_chain);
> > > > >         vma_mark_detached(vma, false);
> > > > >         vma_numab_state_init(vma);
> > > > > +       init_rwsem(&vma->vm_lock);
> > > > > +       vma->vm_lock_seq =3D -1;
> > > > >  }
> > > > >
> > > > >  /* Use when VMA is not part of the VMA tree and needs no locking=
 */
> > > > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > > > index 003619fab20e..caffdb4eeb94 100644
> > > > > --- a/include/linux/mm_types.h
> > > > > +++ b/include/linux/mm_types.h
> > > > > @@ -615,10 +615,6 @@ static inline struct anon_vma_name *anon_vma=
_name_alloc(const char *name)
> > > > >  }
> > > > >  #endif
> > > > >
> > > > > -struct vma_lock {
> > > > > -       struct rw_semaphore lock;
> > > > > -};
> > > > > -
> > > > >  struct vma_numab_state {
> > > > >         /*
> > > > >          * Initialised as time in 'jiffies' after which VMA
> > > > > @@ -716,8 +712,7 @@ struct vm_area_struct {
> > > > >          * slowpath.
> > > > >          */
> > > > >         int vm_lock_seq;
> > > > > -       /* Unstable RCU readers are allowed to read this. */
> > > > > -       struct vma_lock *vm_lock;
> > > > > +       void *vm_dummy;
> > > > >  #endif
> > > > >
> > > > >         /*
> > > > > @@ -770,6 +765,9 @@ struct vm_area_struct {
> > > > >         struct vma_numab_state *numab_state;    /* NUMA Balancing=
 state */
> > > > >  #endif
> > > > >         struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > > +       struct rw_semaphore vm_lock ____cacheline_aligned_in_smp;
> > > > > +#endif
> > > > >  } __randomize_layout;
> > > > >
> > > > >  #ifdef CONFIG_NUMA
> > > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > > index 92bfe56c9fed..eab04a24d5f1 100644
> > > > > --- a/kernel/fork.c
> > > > > +++ b/kernel/fork.c
> > > > > @@ -436,35 +436,6 @@ static struct kmem_cache *vm_area_cachep;
> > > > >  /* SLAB cache for mm_struct structures (tsk->mm) */
> > > > >  static struct kmem_cache *mm_cachep;
> > > > >
> > > > > -#ifdef CONFIG_PER_VMA_LOCK
> > > > > -
> > > > > -/* SLAB cache for vm_area_struct.lock */
> > > > > -static struct kmem_cache *vma_lock_cachep;
> > > > > -
> > > > > -static bool vma_lock_alloc(struct vm_area_struct *vma)
> > > > > -{
> > > > > -       vma->vm_lock =3D kmem_cache_alloc(vma_lock_cachep, GFP_KE=
RNEL);
> > > > > -       if (!vma->vm_lock)
> > > > > -               return false;
> > > > > -
> > > > > -       init_rwsem(&vma->vm_lock->lock);
> > > > > -       vma->vm_lock_seq =3D -1;
> > > > > -
> > > > > -       return true;
> > > > > -}
> > > > > -
> > > > > -static inline void vma_lock_free(struct vm_area_struct *vma)
> > > > > -{
> > > > > -       kmem_cache_free(vma_lock_cachep, vma->vm_lock);
> > > > > -}
> > > > > -
> > > > > -#else /* CONFIG_PER_VMA_LOCK */
> > > > > -
> > > > > -static inline bool vma_lock_alloc(struct vm_area_struct *vma) { =
return true; }
> > > > > -static inline void vma_lock_free(struct vm_area_struct *vma) {}
> > > > > -
> > > > > -#endif /* CONFIG_PER_VMA_LOCK */
> > > > > -
> > > > >  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
> > > > >  {
> > > > >         struct vm_area_struct *vma;
> > > > > @@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struct =
mm_struct *mm)
> > > > >                 return NULL;
> > > > >
> > > > >         vma_init(vma, mm);
> > > > > -       if (!vma_lock_alloc(vma)) {
> > > > > -               kmem_cache_free(vm_area_cachep, vma);
> > > > > -               return NULL;
> > > > > -       }
> > > > >
> > > > >         return vma;
> > > > >  }
> > > > > @@ -496,10 +463,8 @@ struct vm_area_struct *vm_area_dup(struct vm=
_area_struct *orig)
> > > > >          * will be reinitialized.
> > > > >          */
> > > > >         data_race(memcpy(new, orig, sizeof(*new)));
> > > > > -       if (!vma_lock_alloc(new)) {
> > > > > -               kmem_cache_free(vm_area_cachep, new);
> > > > > -               return NULL;
> > > > > -       }
> > > > > +       init_rwsem(&new->vm_lock);
> > > > > +       new->vm_lock_seq =3D -1;
> > > > >         INIT_LIST_HEAD(&new->anon_vma_chain);
> > > > >         vma_numab_state_init(new);
> > > > >         dup_anon_vma_name(orig, new);
> > > > > @@ -511,7 +476,6 @@ void __vm_area_free(struct vm_area_struct *vm=
a)
> > > > >  {
> > > > >         vma_numab_state_free(vma);
> > > > >         free_anon_vma_name(vma);
> > > > > -       vma_lock_free(vma);
> > > > >         kmem_cache_free(vm_area_cachep, vma);
> > > > >  }
> > > > >
> > > > > @@ -522,7 +486,7 @@ static void vm_area_free_rcu_cb(struct rcu_he=
ad *head)
> > > > >                                                   vm_rcu);
> > > > >
> > > > >         /* The vma should not be locked while being destroyed. */
> > > > > -       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
> > > > > +       VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock), vma);
> > > > >         __vm_area_free(vma);
> > > > >  }
> > > > >  #endif
> > > > > @@ -3192,10 +3156,7 @@ void __init proc_caches_init(void)
> > > > >                         SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUN=
T,
> > > > >                         NULL);
> > > > >
> > > > > -       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|=
SLAB_ACCOUNT);
> > > > > -#ifdef CONFIG_PER_VMA_LOCK
> > > > > -       vma_lock_cachep =3D KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_=
ACCOUNT);
> > > > > -#endif
> > > > > +       vm_area_cachep =3D KMEM_CACHE(vm_area_struct, SLAB_PANIC|=
SLAB_ACCOUNT|SLAB_HWCACHE_ALIGN);
> > > > >         mmap_init();
> > > > >         nsproxy_cache_init();
> > > > >  }
> > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > index 3b7715ecf292..e95ecb2063d2 100644
> > > > > --- a/mm/userfaultfd.c
> > > > > +++ b/mm/userfaultfd.c
> > > > > @@ -92,7 +92,7 @@ static struct vm_area_struct *uffd_lock_vma(str=
uct mm_struct *mm,
> > > > >                  * mmap_lock, which guarantees that nobody can lo=
ck the
> > > > >                  * vma for write (vma_start_write()) under us.
> > > > >                  */
> > > > > -               down_read(&vma->vm_lock->lock);
> > > > > +               down_read(&vma->vm_lock);
> > > > >         }
> > > > >
> > > > >         mmap_read_unlock(mm);
> > > > > @@ -1468,9 +1468,9 @@ static int uffd_move_lock(struct mm_struct =
*mm,
> > > > >                  * See comment in uffd_lock_vma() as to why not u=
sing
> > > > >                  * vma_start_read() here.
> > > > >                  */
> > > > > -               down_read(&(*dst_vmap)->vm_lock->lock);
> > > > > +               down_read(&(*dst_vmap)->vm_lock);
> > > > >                 if (*dst_vmap !=3D *src_vmap)
> > > > > -                       down_read_nested(&(*src_vmap)->vm_lock->l=
ock,
> > > > > +                       down_read_nested(&(*src_vmap)->vm_lock,
> > > > >                                          SINGLE_DEPTH_NESTING);
> > > > >         }
> > > > >         mmap_read_unlock(mm);
> > > > > --
> > > > > 2.43.0
> > > > >
> > >
> > >
> > >
> > > --
> > > Mateusz Guzik <mjguzik gmail.com>



--=20
Mateusz Guzik <mjguzik gmail.com>

