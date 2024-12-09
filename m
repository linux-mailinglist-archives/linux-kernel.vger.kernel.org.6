Return-Path: <linux-kernel+bounces-436701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F8A9E89B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6445280E25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A8154C08;
	Mon,  9 Dec 2024 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AJ5nRYUd"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213274068
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715412; cv=none; b=QYzAPbjghWIabtEMJCTgjvPq53kDJHf3I7XLldCORKlQ/Bm+eUvdkEWKQg2KV7vFkL0m+MXG4ZrO9ZCBZg8uJGG86RNyxafynsVdCE6VdL06D6VcF06YagUYWvH3bGgEq7OH1vfZXK+VRSA2VXU2dw3d2njJ17vOY8aaeEtNwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715412; c=relaxed/simple;
	bh=Djt9RN1cmP3HA703xXgeWIX3ptTdD4TAS4xxwmE4pi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MA+zDeirT+HDExYtmOc+ANs4NJnqXV0HVVqnvFOeyaU9zJYnbfYS211wyjwZfHSCwMqC+IXwI0BJWVcgmOkSVAAWwDNatbaFWhzr3cpQmwnAmxSe/x8lNIOvz1qL4OnUjqR2zefhvVIBR93l8rVk+FUKbyJvQ/txJ1DpcrF9W7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AJ5nRYUd; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso3733839a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 19:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733715409; x=1734320209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ6LtrcCk6208JGAAeJNyDPfi0uTT0z6gEVCVdLKwRU=;
        b=AJ5nRYUd+hNSkxrYMVvHPUgo51EuHtqi1USxBJSdqtxq1Oi5g2QTzMBxusRqu7znwP
         sR3snGWfyuDxGtLJ8geTU9N7mjxjEA1mUK6WeTn+DLbO57kUKHgwGpFEHwNmbd+jm8ZQ
         TT0NtkMXNX7tpEt7wisc2IvXg+XTe52Rp6WO3Fns8xSG+hE3YU6Nwhw0MxdCBDCzcsjd
         WASOkmeiQZfq5BKOhfJ0+/widpg0rSrxGwrw5Mz5SI/n3SsyWcg53el6af2dFqycyhfg
         A/zoAVeToYW51phfOn8eFhJdMDzVkb+NbL4yawmlFwpFZ0qef5iinpy8HigM6YaIzNem
         SW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733715409; x=1734320209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZ6LtrcCk6208JGAAeJNyDPfi0uTT0z6gEVCVdLKwRU=;
        b=iphF7O0GZGT3NhCDoKv9DaWM/K5zKPetMttZoKsswhoJyDF7bIqwOTXw2DZoIVPv33
         FvYI1LLTI/0RGcshWNdf8bt/Nza8O628fM9+POTLQvA+1x7wdQq1u5U5OW5nVX1AeHn5
         mlt48Qq6IUT3pcT8uLmNWCCue+HX2i4HhchRFnSjPzpP+7BLOFFm1ijWzOaZs0qwP6gL
         ekju6Wq1z5oWCcn7SaMsuwYZSFuyKy0tZb97Kmt7QfgN36RYs/btMC0BAnSS+4r3LE0X
         HoPQfQEMA5FaXPEqDKAB9LQEyhaGBT/V/+raAS7A64eNOr/62hbujFM/91LcfeZJAFGi
         RG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1HELAT2P6xWU2UmMgNytpqAzlLioQlsVM6NbKwn86wlSeiyBte+S3rWCYiPWX4fQjEnDKsN5/817hV8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KeCvzyj7N5deUb3rhbVX07cfmmOh6eJmJF9bqXsC/IZ+/U7m
	ZhoahZVpYAtRaRLbYg8ODuz22LkfnwFDZd3M9AiigzaDdK1xIkPBR5vJZFS+ScwOz9i4fC/OoU1
	QtiTDMAaN0v/za30+PoJW0KpLibwcLdd4RXKRIg==
X-Gm-Gg: ASbGncv25KCr7lTX0P4YtwMpzCKrS4cJicYl4R1wFhwejicCASdUlaAzuSmbzWRjXAW
	bdaETYLk3cL3QInIUJoLs0QzfGEysIhnRAjcgc+6THhn2
X-Google-Smtp-Source: AGHT+IHemNqPPOXWoalJSPyvc278UNYChTi9JXYXkEEffZvQ/Sif7NZehOOzQlnzg7kGcnTF6WYURzIyIMvRNK0wydA=
X-Received: by 2002:a17:90b:364a:b0:2ef:89a5:b8f1 with SMTP id
 98e67ed59e1d1-2ef89a5ba3emr11140681a91.7.1733715409038; Sun, 08 Dec 2024
 19:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
 <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com> <315752c5-6129-4c8b-bf8c-0cc26f0ad5c5@redhat.com>
 <CAPYmKFuAKNw86auGUHBOpJDTK4=UFC6z4QMJWO6qn3BWczbuYw@mail.gmail.com>
 <CAKbZUD27ZiA+xX56_FG1WOnaFjEB2LFC0-qgPwf3pXdgErfKtA@mail.gmail.com>
 <CAPYmKFtvYFmE9qpp=Gyqdjc8nNnr-OPT3X+UittqTPCqzz6XPw@mail.gmail.com> <CAOUHufaJ3ix7Prv7UkHzzgz5Hq7UW9T5AZFHdWKgzBW_2hYdLw@mail.gmail.com>
In-Reply-To: <CAOUHufaJ3ix7Prv7UkHzzgz5Hq7UW9T5AZFHdWKgzBW_2hYdLw@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 9 Dec 2024 11:36:38 +0800
Message-ID: <CAPYmKFvcg1MC_yuqV+YsKjOg0VhTs5Dkx3bZVax7m7AMdFh0-Q@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 00/21] riscv: Introduce 64K base page
To: Yu Zhao <yuzhao@google.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ardb@kernel.org, anup@brainfault.org, atishp@atishpatra.org, 
	xieyongji@bytedance.com, lihangjing@bytedance.com, 
	punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yu Zhao,

On Sun, Dec 8, 2024 at 6:03=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Sat, Dec 7, 2024 at 1:03=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> =
wrote:
> >
> > Hi Pedro,
> >
> > On Sat, Dec 7, 2024 at 2:49=E2=80=AFAM Pedro Falcato <pedro.falcato@gma=
il.com> wrote:
> > >
> > > On Fri, Dec 6, 2024 at 1:42=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.c=
om> wrote:
> > > >
> > > > Hi David,
> > > >
> > > > On Fri, Dec 6, 2024 at 6:13=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> > > > >
> > > > > On 06.12.24 03:00, Zi Yan wrote:
> > > > > > On 5 Dec 2024, at 5:37, Xu Lu wrote:
> > > > > >
> > > > > >> This patch series attempts to break through the limitation of =
MMU and
> > > > > >> supports larger base page on RISC-V, which only supports 4K pa=
ge size
> > > > > >> now. The key idea is to always manage and allocate memory at a
> > > > > >> granularity of 64K and use SVNAPOT to accelerate address trans=
lation.
> > > > > >> This is the second version and the detailed introduction can b=
e found
> > > > > >> in [1].
> > > > > >>
> > > > > >> Changes from v1:
> > > > > >> - Rebase on v6.12.
> > > > > >>
> > > > > >> - Adjust the page table entry shift to reduce page table memor=
y usage.
> > > > > >>      For example, in SV39, the traditional va behaves as:
> > > > > >>
> > > > > >>      ----------------------------------------------
> > > > > >>      | pgd index | pmd index | pte index | offset |
> > > > > >>      ----------------------------------------------
> > > > > >>      | 38     30 | 29     21 | 20     12 | 11   0 |
> > > > > >>      ----------------------------------------------
> > > > > >>
> > > > > >>      When we choose 64K as basic software page, va now behaves=
 as:
> > > > > >>
> > > > > >>      ----------------------------------------------
> > > > > >>      | pgd index | pmd index | pte index | offset |
> > > > > >>      ----------------------------------------------
> > > > > >>      | 38     34 | 33     25 | 24     16 | 15   0 |
> > > > > >>      ----------------------------------------------
> > > > > >>
> > > > > >> - Fix some bugs in v1.
> > > > > >>
> > > > > >> Thanks in advance for comments.
> > > > > >>
> > > > > >> [1] https://lwn.net/Articles/952722/
> > > > > >
> > > > > > This looks very interesting. Can you cc me and linux-mm@kvack.o=
rg
> > > > > > in the future? Thanks.
> > > > > >
> > > > > > Have you thought about doing it for ARM64 4KB as well? ARM64=E2=
=80=99s contig PTE
> > > > > > should have similar effect of RISC-V=E2=80=99s SVNAPOT, right?
> > > > >
> > > > > What is the real benefit over 4k + large folios/mTHP?
> > > > >
> > > > > 64K comes with the problem of internal fragmentation: for example=
, a
> > > > > page table that only occupies 4k of memory suddenly consumes 64K;=
 quite
> > > > > a downside.
> > > >
> > > > The original idea comes from the performance benefits we achieved o=
n
> > > > the ARM 64K kernel. We run several real world applications on the A=
RM
> > > > Ampere Altra platform and found these apps' performance based on th=
e
> > > > 64K page kernel is significantly higher than that on the 4K page
> > > > kernel:
> > > > For Redis, the throughput has increased by 250% and latency has
> > > > decreased by 70%.
> > > > For Mysql, the throughput has increased by 16.9% and latency has
> > > > decreased by 14.5%.
> > > > For our own newsql database, throughput has increased by 16.5% and
> > > > latency has decreased by 13.8%.
> > > >
> > > > Also, we have compared the performance between 64K and 4k + large
> > > > folios/mTHP on ARM Neoverse-N2. The result shows considerable
> > > > performance improvement on 64K kernel for both speccpu and lmbench,
> > > > even when 4K kernel enables THP and ARM64_CONTPTE:
> > > > For speccpu benchmark, 64K kernel without any huge pages optimizati=
on
> > > > can still achieve 4.17% higher score than 4K kernel with transparen=
t
> > > > huge pages as well as CONTPTE optimization.
> > > > For lmbench, 64K kernel achieves 75.98% lower memory mapping
> > > > latency(16MB) than 4K kernel with transparent huge pages and CONTPT=
E
> > > > optimization, 84.34% higher map read open2close bandwidth(16MB), an=
d
> > > > 10.71% lower random load latency(16MB).
> > > > Interestingly, sometimes kernel with transparent pages support have
> > > > poorer performance for both 4K and 64K (for example, mmap read
> > > > bandwidth bench). We assume this is due to the overhead of huge pag=
es'
> > > > combination and collapse.
> > > > Also, if you check the full result, you will find that usually the
> > > > larger the memory size used for testing is, the better the performa=
nce
> > > > of 64k kernel is (compared to 4K kernel). Unless the memory size li=
es
> > > > in a range where 4K kernel can apply 2MB huge pages while 64K kerne=
l
> > > > can't.
> > > > In summary, for performance sensitive applications which require
> > > > higher bandwidth and lower latency, sometimes 4K pages with huge pa=
ges
> > > > may not be the best choice and 64k page can achieve better results.
> > > > The test environment and result is attached.
> > > >
> > > > As RISC-V has no native 64K MMU support, we introduce a software
> > > > implementation and accelerate it via Svnapot. Of course, there will=
 be
> > > > some extra overhead compared with native 64K MMU. Thus, we are also
> > > > trying to persuade the RISC-V community to support the extension of
> > > > native 64K MMU [1]. Please join us if you are interested.
> > > >
> > >
> > > Ok, so you... didn't test this on riscv? And you're basing this
> > > patchset off of a native 64KiB page size kernel being faster than 4Ki=
B
> > > + CONTPTE? I don't see how that makes sense?
> >
> > Sorry for the misleading. I didn't intend to use ARM data to support
> > this patch, just to explain the idea source. We do prefer 64K MMU for
> > the performance improvement it brought to real applications and
> > benchmarks.
>
> This breaks ABI, doesn't it? Not only userspace needs to be recompiled
> with 64KB alignment, it also needs not to assume 4KB base page size.

Yes, it does.

>
> > And since RISC-V does not support it yet, we internally
> > use this patch as a transitional solution for RISC-V.
>
> Distros need to support this as well. Otherwise it's a tech island.
> Also why RV? It can be a generic feature which can apply to other
> archs like x86, right? See "page clustering" [1][2].
>
> [1] https://lwn.net/Articles/23785/
> [2] https://lore.kernel.org/linux-mm/Pine.LNX.4.21.0107051737340.1577-100=
000@localhost.localdomain/
>
> > And if native
> > 64k MMU is available, this patch can be canceled.
>
> Why 64KB? Why not 32KB or 128KB? In general, the less dependency on
> h/w, the better. Ideally, *if* we want to consider this, it should be
> a s/w feature applicable to all (or most of) archs.

We chose RISC-V because of internal business needs, and chose 64k
because of the benefits we have achieved on ARM 64k.

It is a pretty ambitious goal to apply such a feature to all
architectures. We are very glad to do so and request more assistance
if everyone thinks it is better. But for now, perhaps it is a better
choice to try it on RV first? After all, not all architectures support
features like Svnapot or CONTPTE. Of course, for architectures not
supporting Svnapot, applying a bigger page size can still achieve less
metadata memory overhead and less page faults.

We are pleased to see that similar things have already been considered
before. We give the most respect to William Lee Irwin and Hugh Dickins
and hope they can continue on this work. We will cc them in the future
emails.

Best Regards,

Xu Lu

>
>
> > The only usage of
> > this patch I can think of then is to make the kernel support more page
> > sizes than MMU, as long as Svnapot supports the corresponding size.
> >
> > We will try to release the performance data in the next version. There
> > have been more issues with applications and OS adaptation:) So this
> > version is still an RFC.
> >
> > >
> > > /me is confused
> > >
> > > How many of these PAGE_SIZE wins are related to e.g userspace basing
> > > its buffer sizes (or whatever) off of the system page size? Where
> > > exactly are you gaining time versus the CONTPTE stuff?
> > > I think MM in general would be better off if we were more transparent
> > > with regard to CONTPTE and page sizes instead of hand waving with
> > > "hardware page size !=3D software page size", which is such a *checks
> > > notes* 4.4BSD idea... :) At the very least, this patchset seems to go
> > > against all the work on better supporting large folios and CONTPTE.
> >
> > By the way, the core modification of this patch is turning pte
> > structure to an array of 16 entries to map a 64K page and accelerating
> > it via Svnapot. I think it is all about architectural pte and has
> > little impact on pages or folios. Please remind me if anything is
> > missed and I will try to fix it.
> >
> > >
> > > --
> > > Pedro
> >
> > Thanks,
> >
> > Xu Lu
> >

