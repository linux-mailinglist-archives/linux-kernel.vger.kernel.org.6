Return-Path: <linux-kernel+bounces-252372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6720931252
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A9C1F23962
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59AA188CA5;
	Mon, 15 Jul 2024 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr8Jdhvk"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D57187337
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039615; cv=none; b=TbWcCcY0QLSgY0NO7MeE2LNTcHE90+pzyEiJ4oDWRRug4ZjhhN2vX1XRq6aZ13BqyHrVLFpr8tbIkvF27bJxMSZ79sY2+zK02CuOwu9Otj/Ja7b1jSttplM5hok6VTVPDGRcWdIz7otPQywyKj8vpmkpG7rjEMRYLHuzd1C8wMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039615; c=relaxed/simple;
	bh=VmKjlf4638fqgVSXxVnb7/72Yz7f5M5rz55b7V5QKt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGu/Sq7dq0jeBVqC36lFPL+MMBpCigkknjW4bIjYggolYGplYAly05e0TEjZ15u3EQlIwWb+owkkEcDSw9ff42cUHStQXs1C326fFWITGoVtA2gLgK7lyiAo2ipU/yCs2S7kDEC10G2+fXzAMm2j8gsVES+r8suYyoZR2M/ZP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr8Jdhvk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b5ecafbf88so21429886d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721039612; x=1721644412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgWH3GB/DAeIpSaaXOjbN7zelfltAU3Di1e0ALczFW8=;
        b=hr8JdhvkH74nk9SDqXmO3px/UvKQw7SkCrr4nHl6rFTzFZRa7L9GLExDITgmo47ZKN
         mkCyA7mMx3WJJ2gn03+6zjmxrVPB6K/eD9AjTMS2wUU+AOAqdTUTa+WHK0Dmal/hQUN8
         /8aPeQrqJeCqd1FdouYva/sZmm7BCeG6+xKur9iNf8uarVeErhLy3TK76xCvjirmURge
         NR9xkeqN9Iy1fUpu5YFMfa2K8oAJ7WuCW2FGL+wSzNeMNOYKdrO9DSRkbOJ3p7p1fDJx
         bnB7zpkI5CCTtkLMbpmo1GK5gcW8asM/LFrftk4obo80eS3QLjDoVYlRQYpZhviSMvse
         AVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039612; x=1721644412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgWH3GB/DAeIpSaaXOjbN7zelfltAU3Di1e0ALczFW8=;
        b=EazxQZvFS+lpMYyYoLVXytsJgXjpYJ6wN4fd1HxTh6BuZuuD00KXVc5NyuFvJ9wnjR
         rANhq/pnysIl0fRvkYkItvdsSUHDXRv8sh+k6PF530psmCoi1CVMnd2wQ6h4aswLS5JP
         3pPXE2nQlAyQzi0lPvaStd8kN/TrsGK0pAspaOn6CqQ6SJh1vVZO9bIrgBqQDv1G/9Pb
         qbZxUsQsg7PlXfovXbN5pPB3OwZdAgDkbCFc534ok8CUyejzX20Jy3G+63kQQz8N6OHy
         UQSQaiW3i73YUYTMl7CbgHq+F1MBbe6GRsoCVyTiq1JxmId6031CCE3Jy9nofkMV0Fq1
         Xu/A==
X-Forwarded-Encrypted: i=1; AJvYcCXc7RF7dQupoe4P0iql1o5p4zdWphw1zHVA0qukFVkhesOmrznJlOn8+P9n/YXkJeCodH5WbsjtTZrK7EQPMhO0iOtJxpU4SfA/rOvr
X-Gm-Message-State: AOJu0Yw5sZ+HmUAlNDvRYrPgCde7Jo2UivlnEcwjAeNEKutJymiSEtnb
	PXcfRzJu34KzUST9rj/IMGzY35ws0ifsARaNCij9wVDqa9lLdKcRdpV5hLhC4sxC+Z4xmrojDFY
	FZhhCXGwaB1Wa3IBJp8w1q9SdAYA=
X-Google-Smtp-Source: AGHT+IFU3dWIlgrB4RZ2/cSOhRKzhGkmmPoMDLrKRhaZTGkOtDJebUyM3zDg/H/uanKHcC0MK8HZEpIF4vRVCitx37k=
X-Received: by 2002:a05:6214:1d2c:b0:6b5:e06b:4025 with SMTP id
 6a1803df08f44-6b61bce174bmr225845466d6.25.1721039611776; Mon, 15 Jul 2024
 03:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOpXEOwh6r0Fo_5hgXET6gGHTUxTdE1aDkp_K0ga8BwGSDMX+A@mail.gmail.com>
 <ZpRjDDKGq1F4cSBr@archie.me> <20240715095411.GY27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715095411.GY27299@noisy.programming.kicks-ass.net>
From: =?UTF-8?B?U2hpLVd1LCBMb++8iEdtYWls77yJ?= <shiwulo@gmail.com>
Date: Mon, 15 Jul 2024 18:33:20 +0800
Message-ID: <CAOpXEOzisJO2kN+qwVRcT5z+jQdSAtL2mpzyH1Q+PcXYvFQDJQ@mail.gmail.com>
Subject: Re: A new spinlock for multicore (>16) platform
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, 
	"ccu_cs_oslab@googlegroups.com" <ccu_cs_oslab@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Peter Zijlstra,
To address the issues you mentioned, here are my explanations:

1. We currently use a bitArray to solve the time complexity problem
during unlock (https://www.cs.ccu.edu.tw/~shiwulo/nxt+sh-RON.pdf). If
the number of processors reaches thousands, a two-layer bitArray can
be used. The first layer bitArray records whether any group of cores
wants to enter the critical section, while the second layer bitArray
records which cores within that group want to enter the critical
section. After traversing a second layer bitArray, the first layer
bitArray determines the next second layer bitArray to be traversed.

2. Core-to-core transfer speed can be measured using code. In our
paper, the core-to-core transfer speeds were measured using our code.
There are already some websites providing information on core-to-core
transfer speeds, such as:
https://chipsandcheese.com/2023/11/07/core-to-core-latency-data-on-large-sy=
stems/.

3. Redesigning data structures to achieve higher performance is the
best approach, but not every problem can be solved with better data
structures. For example, many spinlocks are still used within the
current Linux kernel.

4. We have published the code on GitHub
(https://github.com/shiwulo/ron-osdi2023). This link is also available
on the first page of our paper. We did not apply for the USENIX
AVAILABLE badge because we believe that while our code is open, it is
not yet good enough.


shiwu

Peter Zijlstra <peterz@infradead.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:54=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Mon, Jul 15, 2024 at 06:45:16AM +0700, Bagas Sanjaya wrote:
> > On Mon, Jul 15, 2024 at 01:07:40AM +0800, Shi-Wu, Lo=EF=BC=88Gmail=EF=
=BC=89 wrote:
> > > Dear Linux Contributors,
>
> > >    A detailed introduction to this method can be found in the followi=
ng paper:
> > > https://www.usenix.org/conference/osdi23/presentation/lo
>
> So if I understand this right, the algorithm basically boils down to a
> circular path and unlock will iterate this path looking for the next CPU
> waiting.
>
> The worst case wait-time is one full circle of the rotor, which is
> bounded, so that's good.
>
> The immediate problem however is that O(n) iteration on unlock, given
> Linux runs on many big machines with 1e3 order of CPUs, which would be
> quite terrible on low to medium contention.
>
> You mention in Future work, to alleviate this unlock issue by switching
> to a linked-list, whereby unlock would then become O(1). The problem
> then becomes lock() needs to an insertion-sort, which needs to know the
> rotor position (eg. current lock owner).
>
> I don't think that is a much easier proposition -- notably uncontended
> fast path doesn't (want) to track the rotor position, and in the worst
> case you're still iterating 1e3 order CPUs.
>
> Hierachical rotors come to mind, but complexity -- is it warranted?
>
> > > Our laboratory is currently developing a system that can apply the
> > > same optimization strategy to all multi-core processors. Below is our
> > > plan.
> > >
> > > The New Method and Its Compatibility with qspinlock:
> > > 1. The default algorithm in the Linux kernel remains qspinlock.
> > > 2. A new file is created in /proc/routing_path, where a shortest path
> > > can be input, for example:
> > > sudo echo 1,2,3,4,16,17,18,19,5,6,7,8,11,12,13,14 > /proc/routing_pat=
h
> > > 3. After inputting the shortest path, the kernel switches to using th=
e
> > > RON algorithm.
>
> This is quite horrendous. If you cannot compute the OWCR from the
> provided topology (CPUID on x86) 'nobody' is going to be using this.
>
> Additionally, what locks are so contended that this gives a significant
> performance gain, and can't we better rework the locking rather than the
> lock implementation to alleviate this problem.
>
> Eg. the futex hash lock is an oft cited example, but something like:
>
>   https://lkml.kernel.org/r/20230721105744.434742902@infradead.org
>
> can significantly reduce this.
>
> That is, in general is helps more to reduce lock contention rather than
> to optimize the contention behaviour.
>
> So which locks do you see sufficient contention on to make this
> worthwhile and how much do you gain by doing this?
>
> Additionally, per the paper there are Linux patches (albeit for rather
> old kernel versions), why aren't those included?
>
>


--=20
=E7=BE=85=E7=BF=92=E4=BA=94
=E4=B8=AD=E6=AD=A3=E5=A4=A7=E5=AD=B8=E8=B3=87=E5=B7=A5=E7=B3=BB=EF=BC=8C=E5=
=89=AF=E6=95=99=E6=8E=88
=E9=9B=BB=E8=A9=B1=EF=BC=9A(05)2720411=E8=BD=8933116
=E5=82=B3=E7=9C=9F=EF=BC=9A(05)2720859

