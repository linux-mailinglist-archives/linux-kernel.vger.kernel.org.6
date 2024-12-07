Return-Path: <linux-kernel+bounces-436200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF309E8269
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477E618849E1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628C156227;
	Sat,  7 Dec 2024 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STxraUYN"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3E22C6CD
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609019; cv=none; b=cN4hO5nQ707kWGFFXO9OTnqll1LBh13sWB2ggzezjb9Af6u6dUMPfcPOy4L93GCnTtQDbM3uIukAeY2K8i+XGSVkESBlFZuOY1SZy/vrbB6RQ43u+wSwb1UqA3NuZD8vaddxR4uI2sYL0HJUF6AJfD2KMzDJooJoWNGOMtoT1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609019; c=relaxed/simple;
	bh=DLMCPcW4Z42j5XmP38Wco9cHRLEgDx43rTErTM6m47w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIY3rBDDmOcEOeMA1ojOiABMo24MgVxJn90FdUvMhT2EAqX7r5W06k1RNR1UGPDSojyOkdAuNJEa06AyNkzssuDXwBFrM4gWhSEbTYiIKDJqm2D98/s0LCrpMG67EOQpaGuCG34xpS6Fbtq/Rxd0l7vx/qYTlpJNnVcBvWAN51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STxraUYN; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4afd68271b6so409916137.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733609015; x=1734213815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIFxuOOTGkDnFbXhmO1flaaC4HzgHWDKSPocxmXWias=;
        b=STxraUYN8QaCAKxalJC7RdL8dLNF+KsXf2QuZzGNZtH4wXRZcY7bUnCaesgPPhjMLW
         qwXEXrig9sFggrobL5CQubhdnv4yBv0X2U7Cwyo5kVa0u7gxzGd9dWaeKwUSsO3SciK6
         PM0ojj0cFK1aj/b+YMUmTH1zJXxVnTfmo+D1UafhsCTZdfi8MGABysrnYNw8kIRIIo4m
         CtPDiYQzmZH7WNePn6d+7kXCRiBW3w0VT3bTZovzuEuHi18dd/QX2lgGs3m1PzONX/po
         vlJF6fqgBqTsOgG91iHpZUy/+9A0Rqabq0yekx2aCigAwLtgoKMR0kV5Zb25HIhnAAZX
         P7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609015; x=1734213815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIFxuOOTGkDnFbXhmO1flaaC4HzgHWDKSPocxmXWias=;
        b=oF1Gg5qsh63hfiWWTxAfoSn6HgjhkihSWb5jeREvXEAGvHww4/dDP53XO3DyXjQixW
         et7o9cHqXjS3TQ0mKuipxjwxfyBbqV2b2Zj4bkjZjXOc4F6mTKjXGl45XKQT38MIIH/O
         7xXWsh7zXGNUvAX2+HyW44qEyIqeV3acKyBZDMoh4CS3mGsF7iuf7krh3pYG2MXUxqSI
         EQMjcyOS320L7PO9x3hc1ZIkoJMTH6WGe5AiVNe2mOq6Ut3YEchmqzNQcGAzHZh+fIk9
         /sJG9TXQSbsK8dGRO/8e0YdXbPcZ4ILOT5TAAFcRnHLhmUIHF/8V40O2ir+801UtEN2M
         LTJw==
X-Forwarded-Encrypted: i=1; AJvYcCXjesHhEvYjvOaiiD7852zzkLCpoiJYAj4hVpu4qpyQDLTSFZX4pqcT2bi5lRv9HVoOfjecS+w3n355y+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWIaQeWgGho3BX4k9xADao9QhmCYO6LXcDyntwWk9l4XhFSSJ
	hKllLtVQIjqR2sCXOxSuWCbeGNiBRIfxRH5mctKcS6vnb2jE8ZgnFG6d2q+b32hw1kXNWefmnKM
	qt5iJKBxbZpH3fKIfpGW71BOGeYGTjN2iTbvm
X-Gm-Gg: ASbGncujLGxTElzBvnho8zUJnZUDxe8JiiCB/lmRC0mtrsd9/e6qSjLaZpLkptLJc39
	fAaVnXcVSTzdYDfzg3C8hv0THrlZ+cgSIEUXfb8sFwAFoH8IJ1q6heBOYiuqpJbiH
X-Google-Smtp-Source: AGHT+IEQEpS3JV+7Tlz8RWPHAgF7l9LurCYUPbwDtC1HhY6Q1C5bTVHwmM2S6KdUCVEgZpCaJsLmi6me8DTvozZh3BQ=
X-Received: by 2002:a05:6102:1608:b0:4ad:497a:268d with SMTP id
 ada2fe7eead31-4afcab15e00mr7814377137.19.1733609014558; Sat, 07 Dec 2024
 14:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
 <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com> <315752c5-6129-4c8b-bf8c-0cc26f0ad5c5@redhat.com>
 <CAPYmKFuAKNw86auGUHBOpJDTK4=UFC6z4QMJWO6qn3BWczbuYw@mail.gmail.com>
 <CAKbZUD27ZiA+xX56_FG1WOnaFjEB2LFC0-qgPwf3pXdgErfKtA@mail.gmail.com> <CAPYmKFtvYFmE9qpp=Gyqdjc8nNnr-OPT3X+UittqTPCqzz6XPw@mail.gmail.com>
In-Reply-To: <CAPYmKFtvYFmE9qpp=Gyqdjc8nNnr-OPT3X+UittqTPCqzz6XPw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 7 Dec 2024 15:02:57 -0700
Message-ID: <CAOUHufaJ3ix7Prv7UkHzzgz5Hq7UW9T5AZFHdWKgzBW_2hYdLw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 00/21] riscv: Introduce 64K base page
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ardb@kernel.org, anup@brainfault.org, atishp@atishpatra.org, 
	xieyongji@bytedance.com, lihangjing@bytedance.com, 
	punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 1:03=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> wr=
ote:
>
> Hi Pedro,
>
> On Sat, Dec 7, 2024 at 2:49=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
> >
> > On Fri, Dec 6, 2024 at 1:42=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com=
> wrote:
> > >
> > > Hi David,
> > >
> > > On Fri, Dec 6, 2024 at 6:13=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> > > >
> > > > On 06.12.24 03:00, Zi Yan wrote:
> > > > > On 5 Dec 2024, at 5:37, Xu Lu wrote:
> > > > >
> > > > >> This patch series attempts to break through the limitation of MM=
U and
> > > > >> supports larger base page on RISC-V, which only supports 4K page=
 size
> > > > >> now. The key idea is to always manage and allocate memory at a
> > > > >> granularity of 64K and use SVNAPOT to accelerate address transla=
tion.
> > > > >> This is the second version and the detailed introduction can be =
found
> > > > >> in [1].
> > > > >>
> > > > >> Changes from v1:
> > > > >> - Rebase on v6.12.
> > > > >>
> > > > >> - Adjust the page table entry shift to reduce page table memory =
usage.
> > > > >>      For example, in SV39, the traditional va behaves as:
> > > > >>
> > > > >>      ----------------------------------------------
> > > > >>      | pgd index | pmd index | pte index | offset |
> > > > >>      ----------------------------------------------
> > > > >>      | 38     30 | 29     21 | 20     12 | 11   0 |
> > > > >>      ----------------------------------------------
> > > > >>
> > > > >>      When we choose 64K as basic software page, va now behaves a=
s:
> > > > >>
> > > > >>      ----------------------------------------------
> > > > >>      | pgd index | pmd index | pte index | offset |
> > > > >>      ----------------------------------------------
> > > > >>      | 38     34 | 33     25 | 24     16 | 15   0 |
> > > > >>      ----------------------------------------------
> > > > >>
> > > > >> - Fix some bugs in v1.
> > > > >>
> > > > >> Thanks in advance for comments.
> > > > >>
> > > > >> [1] https://lwn.net/Articles/952722/
> > > > >
> > > > > This looks very interesting. Can you cc me and linux-mm@kvack.org
> > > > > in the future? Thanks.
> > > > >
> > > > > Have you thought about doing it for ARM64 4KB as well? ARM64=E2=
=80=99s contig PTE
> > > > > should have similar effect of RISC-V=E2=80=99s SVNAPOT, right?
> > > >
> > > > What is the real benefit over 4k + large folios/mTHP?
> > > >
> > > > 64K comes with the problem of internal fragmentation: for example, =
a
> > > > page table that only occupies 4k of memory suddenly consumes 64K; q=
uite
> > > > a downside.
> > >
> > > The original idea comes from the performance benefits we achieved on
> > > the ARM 64K kernel. We run several real world applications on the ARM
> > > Ampere Altra platform and found these apps' performance based on the
> > > 64K page kernel is significantly higher than that on the 4K page
> > > kernel:
> > > For Redis, the throughput has increased by 250% and latency has
> > > decreased by 70%.
> > > For Mysql, the throughput has increased by 16.9% and latency has
> > > decreased by 14.5%.
> > > For our own newsql database, throughput has increased by 16.5% and
> > > latency has decreased by 13.8%.
> > >
> > > Also, we have compared the performance between 64K and 4k + large
> > > folios/mTHP on ARM Neoverse-N2. The result shows considerable
> > > performance improvement on 64K kernel for both speccpu and lmbench,
> > > even when 4K kernel enables THP and ARM64_CONTPTE:
> > > For speccpu benchmark, 64K kernel without any huge pages optimization
> > > can still achieve 4.17% higher score than 4K kernel with transparent
> > > huge pages as well as CONTPTE optimization.
> > > For lmbench, 64K kernel achieves 75.98% lower memory mapping
> > > latency(16MB) than 4K kernel with transparent huge pages and CONTPTE
> > > optimization, 84.34% higher map read open2close bandwidth(16MB), and
> > > 10.71% lower random load latency(16MB).
> > > Interestingly, sometimes kernel with transparent pages support have
> > > poorer performance for both 4K and 64K (for example, mmap read
> > > bandwidth bench). We assume this is due to the overhead of huge pages=
'
> > > combination and collapse.
> > > Also, if you check the full result, you will find that usually the
> > > larger the memory size used for testing is, the better the performanc=
e
> > > of 64k kernel is (compared to 4K kernel). Unless the memory size lies
> > > in a range where 4K kernel can apply 2MB huge pages while 64K kernel
> > > can't.
> > > In summary, for performance sensitive applications which require
> > > higher bandwidth and lower latency, sometimes 4K pages with huge page=
s
> > > may not be the best choice and 64k page can achieve better results.
> > > The test environment and result is attached.
> > >
> > > As RISC-V has no native 64K MMU support, we introduce a software
> > > implementation and accelerate it via Svnapot. Of course, there will b=
e
> > > some extra overhead compared with native 64K MMU. Thus, we are also
> > > trying to persuade the RISC-V community to support the extension of
> > > native 64K MMU [1]. Please join us if you are interested.
> > >
> >
> > Ok, so you... didn't test this on riscv? And you're basing this
> > patchset off of a native 64KiB page size kernel being faster than 4KiB
> > + CONTPTE? I don't see how that makes sense?
>
> Sorry for the misleading. I didn't intend to use ARM data to support
> this patch, just to explain the idea source. We do prefer 64K MMU for
> the performance improvement it brought to real applications and
> benchmarks.

This breaks ABI, doesn't it? Not only userspace needs to be recompiled
with 64KB alignment, it also needs not to assume 4KB base page size.

> And since RISC-V does not support it yet, we internally
> use this patch as a transitional solution for RISC-V.

Distros need to support this as well. Otherwise it's a tech island.
Also why RV? It can be a generic feature which can apply to other
archs like x86, right? See "page clustering" [1][2].

[1] https://lwn.net/Articles/23785/
[2] https://lore.kernel.org/linux-mm/Pine.LNX.4.21.0107051737340.1577-10000=
0@localhost.localdomain/

> And if native
> 64k MMU is available, this patch can be canceled.

Why 64KB? Why not 32KB or 128KB? In general, the less dependency on
h/w, the better. Ideally, *if* we want to consider this, it should be
a s/w feature applicable to all (or most of) archs.


> The only usage of
> this patch I can think of then is to make the kernel support more page
> sizes than MMU, as long as Svnapot supports the corresponding size.
>
> We will try to release the performance data in the next version. There
> have been more issues with applications and OS adaptation:) So this
> version is still an RFC.
>
> >
> > /me is confused
> >
> > How many of these PAGE_SIZE wins are related to e.g userspace basing
> > its buffer sizes (or whatever) off of the system page size? Where
> > exactly are you gaining time versus the CONTPTE stuff?
> > I think MM in general would be better off if we were more transparent
> > with regard to CONTPTE and page sizes instead of hand waving with
> > "hardware page size !=3D software page size", which is such a *checks
> > notes* 4.4BSD idea... :) At the very least, this patchset seems to go
> > against all the work on better supporting large folios and CONTPTE.
>
> By the way, the core modification of this patch is turning pte
> structure to an array of 16 entries to map a 64K page and accelerating
> it via Svnapot. I think it is all about architectural pte and has
> little impact on pages or folios. Please remind me if anything is
> missed and I will try to fix it.
>
> >
> > --
> > Pedro
>
> Thanks,
>
> Xu Lu
>

