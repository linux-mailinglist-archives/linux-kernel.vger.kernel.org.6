Return-Path: <linux-kernel+bounces-435942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D09E7ED9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36B51886EBE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E1136345;
	Sat,  7 Dec 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZS8+6rOr"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DB10E0
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558610; cv=none; b=fwmyu2xbU3VWkc2GAh8J1Zfn+6b3z421sgEAH5xOC0nYSON35p8Oz56bHy/TSuI8u00xY1pXKMdoYHr91EkWKnz0nLH2u/U0d574WAXxihlLmvnaad8CHpcrV0+IPQW9N9TPnzTLSpBQDgnhwGENnSAMbetbWXvq6IAVdtD3ZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558610; c=relaxed/simple;
	bh=t0D2EDjDe8suspfkQUUjdN8q/dXdq5vVEsy/YtXmYT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYcFzXklIfYoHeQD2c+7gj7xBOEtCqQaS5E31NLZ6v7T4moMmbq47l4A/RgCyCacFDCxSfByNMqSBDKGiPVYU4nchNpYTi6Uh+DJaXJGe0z6oo2AUQuQh0x1FFIMIEc9qNK9juVGAiYjAar0LbqyBt6PRthUA8ybCzNaDGF9YvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZS8+6rOr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso2078419a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 00:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733558607; x=1734163407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDUJfhQEwThVj3l12vGRVX0Pvt/LPPYQM+5JRuWaSRM=;
        b=ZS8+6rOrJd97Z1XWdpIPlo83sMB5kWUYRoum5phL7OtOAScSoJhSsGsU4u8H2U/w1S
         ceUodAsHNgcThmFqh6FIbDUSJAi3wBNnkXckVnmJicfLs0w/Nwp7tu9qaIfUw2nKEcye
         1M+7aEelNWAOfk19/X78vDRDEscVh+/nLQgAH3xK7WJWYY24wa/6KtCLl+3jDFvXV650
         ZvTSHQiqS+zp3OBSlAdfeBRMhu3TQ6NkNX4KJMwW3J9OyvID3mbAKH9EQYRnRQbNhEAC
         7b49UBQZxnYqaGXEk8oh5aV/PQZW3Mq3po+PnHBL9XNQUQMsd919PC2WQJGZrfULXbPf
         aVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733558607; x=1734163407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDUJfhQEwThVj3l12vGRVX0Pvt/LPPYQM+5JRuWaSRM=;
        b=WyEIaPMxi+WVkacjNCynKvcAtUXSQ39GaUuKfP6YHbZiNtoRp2bYqeTZxc7gqc6yMx
         m/w5csYTKWoHQ0OarQFeMRSXLpQjdWIQ4oHnilLei7cULQcytEDRpEDZfL3wgqqakkQO
         1Or+scrT16PNValTzMJyDnglOFlvHM+NY+xBbYM21nIKIinY+pYHhucwRAmbxgUCUmc8
         dEZS6G+m9wgQoWMbNbiAfOU/LSggh2fvg0Unaso7bF2lvtIjxPpeJkNWzZkXycSyuH3I
         bCnfnN4kKwFN364x3snWSXEucq2hR2aB29Xk8nsd38DY9GoZ6H5EhHheHlDbCL2a8s1p
         Soag==
X-Forwarded-Encrypted: i=1; AJvYcCWsRHwYIL3+IgRw+dLG+qyxTkfvWC9NLcIzst9wrLREf5HLCmWWjvcsqVGVyhErWqJvWUTtda7DlLfYsNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPE/Aq5RF2Q2XhPTnS1jnGgDyleIE9RwZvxMzkZbXcOJnoMhRl
	dh0ZqSdMrxMmTJtyp9EwI/7hT4ix3r9B1Fy9PmCEIoGwGAufg5UXotR7WVlXp+eIw9/tty025sE
	t9h7RG0UMtNfmwp+wHEkS8eNFsKgoUierlssQjXx+hYWbOUeZwAokMQ==
X-Gm-Gg: ASbGncs6caxyQecKSMcQD8YQcTGE5iz0NTd7ygvuz73GBuXU8OKPblufe1GTLpI0gCh
	ZEnafFMbpAk/yMsFCI5MbSZU7noVNAFyNtw==
X-Google-Smtp-Source: AGHT+IHcu94k1jRETR3BaF5fuRy6SP6WomFWoYn2yTNFMTKyEMNckr0xNnbkNH/kStFnM2Y/znXINnSK9kfyVAXT61E=
X-Received: by 2002:a17:90b:5292:b0:2ee:49c4:4a7c with SMTP id
 98e67ed59e1d1-2ef6a6bdb76mr8824607a91.18.1733558607363; Sat, 07 Dec 2024
 00:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
 <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com> <315752c5-6129-4c8b-bf8c-0cc26f0ad5c5@redhat.com>
 <CAPYmKFuAKNw86auGUHBOpJDTK4=UFC6z4QMJWO6qn3BWczbuYw@mail.gmail.com> <CAKbZUD27ZiA+xX56_FG1WOnaFjEB2LFC0-qgPwf3pXdgErfKtA@mail.gmail.com>
In-Reply-To: <CAKbZUD27ZiA+xX56_FG1WOnaFjEB2LFC0-qgPwf3pXdgErfKtA@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Sat, 7 Dec 2024 16:03:16 +0800
Message-ID: <CAPYmKFtvYFmE9qpp=Gyqdjc8nNnr-OPT3X+UittqTPCqzz6XPw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 00/21] riscv: Introduce 64K base page
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	anup@brainfault.org, atishp@atishpatra.org, xieyongji@bytedance.com, 
	lihangjing@bytedance.com, punit.agrawal@bytedance.com, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro,

On Sat, Dec 7, 2024 at 2:49=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Fri, Dec 6, 2024 at 1:42=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> =
wrote:
> >
> > Hi David,
> >
> > On Fri, Dec 6, 2024 at 6:13=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> > >
> > > On 06.12.24 03:00, Zi Yan wrote:
> > > > On 5 Dec 2024, at 5:37, Xu Lu wrote:
> > > >
> > > >> This patch series attempts to break through the limitation of MMU =
and
> > > >> supports larger base page on RISC-V, which only supports 4K page s=
ize
> > > >> now. The key idea is to always manage and allocate memory at a
> > > >> granularity of 64K and use SVNAPOT to accelerate address translati=
on.
> > > >> This is the second version and the detailed introduction can be fo=
und
> > > >> in [1].
> > > >>
> > > >> Changes from v1:
> > > >> - Rebase on v6.12.
> > > >>
> > > >> - Adjust the page table entry shift to reduce page table memory us=
age.
> > > >>      For example, in SV39, the traditional va behaves as:
> > > >>
> > > >>      ----------------------------------------------
> > > >>      | pgd index | pmd index | pte index | offset |
> > > >>      ----------------------------------------------
> > > >>      | 38     30 | 29     21 | 20     12 | 11   0 |
> > > >>      ----------------------------------------------
> > > >>
> > > >>      When we choose 64K as basic software page, va now behaves as:
> > > >>
> > > >>      ----------------------------------------------
> > > >>      | pgd index | pmd index | pte index | offset |
> > > >>      ----------------------------------------------
> > > >>      | 38     34 | 33     25 | 24     16 | 15   0 |
> > > >>      ----------------------------------------------
> > > >>
> > > >> - Fix some bugs in v1.
> > > >>
> > > >> Thanks in advance for comments.
> > > >>
> > > >> [1] https://lwn.net/Articles/952722/
> > > >
> > > > This looks very interesting. Can you cc me and linux-mm@kvack.org
> > > > in the future? Thanks.
> > > >
> > > > Have you thought about doing it for ARM64 4KB as well? ARM64=E2=80=
=99s contig PTE
> > > > should have similar effect of RISC-V=E2=80=99s SVNAPOT, right?
> > >
> > > What is the real benefit over 4k + large folios/mTHP?
> > >
> > > 64K comes with the problem of internal fragmentation: for example, a
> > > page table that only occupies 4k of memory suddenly consumes 64K; qui=
te
> > > a downside.
> >
> > The original idea comes from the performance benefits we achieved on
> > the ARM 64K kernel. We run several real world applications on the ARM
> > Ampere Altra platform and found these apps' performance based on the
> > 64K page kernel is significantly higher than that on the 4K page
> > kernel:
> > For Redis, the throughput has increased by 250% and latency has
> > decreased by 70%.
> > For Mysql, the throughput has increased by 16.9% and latency has
> > decreased by 14.5%.
> > For our own newsql database, throughput has increased by 16.5% and
> > latency has decreased by 13.8%.
> >
> > Also, we have compared the performance between 64K and 4k + large
> > folios/mTHP on ARM Neoverse-N2. The result shows considerable
> > performance improvement on 64K kernel for both speccpu and lmbench,
> > even when 4K kernel enables THP and ARM64_CONTPTE:
> > For speccpu benchmark, 64K kernel without any huge pages optimization
> > can still achieve 4.17% higher score than 4K kernel with transparent
> > huge pages as well as CONTPTE optimization.
> > For lmbench, 64K kernel achieves 75.98% lower memory mapping
> > latency(16MB) than 4K kernel with transparent huge pages and CONTPTE
> > optimization, 84.34% higher map read open2close bandwidth(16MB), and
> > 10.71% lower random load latency(16MB).
> > Interestingly, sometimes kernel with transparent pages support have
> > poorer performance for both 4K and 64K (for example, mmap read
> > bandwidth bench). We assume this is due to the overhead of huge pages'
> > combination and collapse.
> > Also, if you check the full result, you will find that usually the
> > larger the memory size used for testing is, the better the performance
> > of 64k kernel is (compared to 4K kernel). Unless the memory size lies
> > in a range where 4K kernel can apply 2MB huge pages while 64K kernel
> > can't.
> > In summary, for performance sensitive applications which require
> > higher bandwidth and lower latency, sometimes 4K pages with huge pages
> > may not be the best choice and 64k page can achieve better results.
> > The test environment and result is attached.
> >
> > As RISC-V has no native 64K MMU support, we introduce a software
> > implementation and accelerate it via Svnapot. Of course, there will be
> > some extra overhead compared with native 64K MMU. Thus, we are also
> > trying to persuade the RISC-V community to support the extension of
> > native 64K MMU [1]. Please join us if you are interested.
> >
>
> Ok, so you... didn't test this on riscv? And you're basing this
> patchset off of a native 64KiB page size kernel being faster than 4KiB
> + CONTPTE? I don't see how that makes sense?

Sorry for the misleading. I didn't intend to use ARM data to support
this patch, just to explain the idea source. We do prefer 64K MMU for
the performance improvement it brought to real applications and
benchmarks. And since RISC-V does not support it yet, we internally
use this patch as a transitional solution for RISC-V. And if native
64k MMU is available, this patch can be canceled. The only usage of
this patch I can think of then is to make the kernel support more page
sizes than MMU, as long as Svnapot supports the corresponding size.

We will try to release the performance data in the next version. There
have been more issues with applications and OS adaptation:) So this
version is still an RFC.

>
> /me is confused
>
> How many of these PAGE_SIZE wins are related to e.g userspace basing
> its buffer sizes (or whatever) off of the system page size? Where
> exactly are you gaining time versus the CONTPTE stuff?
> I think MM in general would be better off if we were more transparent
> with regard to CONTPTE and page sizes instead of hand waving with
> "hardware page size !=3D software page size", which is such a *checks
> notes* 4.4BSD idea... :) At the very least, this patchset seems to go
> against all the work on better supporting large folios and CONTPTE.

By the way, the core modification of this patch is turning pte
structure to an array of 16 entries to map a 64K page and accelerating
it via Svnapot. I think it is all about architectural pte and has
little impact on pages or folios. Please remind me if anything is
missed and I will try to fix it.

>
> --
> Pedro

Thanks,

Xu Lu

