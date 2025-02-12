Return-Path: <linux-kernel+bounces-511043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22BA32505
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46511695A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C351720A5C4;
	Wed, 12 Feb 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ic35O9f4"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6120ADC0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359880; cv=none; b=kV2KMs4ZYqCDHvOEoMH0r/ixHg3+s2l+REqEpq5911oh7zil3mySTNp3AIAiQyi/WMO3qcC7uZF/HbeKm2YPFvFDNoB4/1AsGHysUJCtH+it0kevoL1bauIR8GQ4Y51r4bIUkMX0q1ymOFyUPLEwUWsKDOXlKku3aigKkmjqBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359880; c=relaxed/simple;
	bh=dh73zP50g2qNnS+6TtUABndLepp3KzTJG8J60l4L04s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQH+zOgGlkZsyHWUOtqqpz61TWa/ubVQYiUZeJYljd5nPdacbYLtaeZLa8PyjugLSDdHQI8UgqzY3BQdSBc9FJHBorI2yLDbPtD9WV0lsaQyqpMuylVIYx1OUp3hLFhey6fR11RlH1hEJ4C0TCyEfIsYsY8LQmIJkqF66WItfk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ic35O9f4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f441791e40so9155681a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739359877; x=1739964677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7rEBrHtcjfEoUuHQWiZbj092Ws2ECaqqUNMQHsEcu0U=;
        b=Ic35O9f4eMd4jz+6YZDPpSwgM/TvsSmMhp10rJOBC9ucwBzn0cuRcYujf27weFAlq9
         hsmsWVCCab2PAy1j+K/8F1YdWY8FjWsTVhhUEYgOasAWVA5ui+s4tBmTDPkFbIPHbE++
         D6CehnkWKbtvJwQf0kmxJCwvR99MdKo9OF/hRPxoh4cQ2l889EH189S90EJC0Y5srGvA
         YWplg70Zxyytb0/kZLL12/rj1rKF3etcxZ63JGZDJMEGXM++K/Cn/VeBtT/HxHX2scVZ
         gYsPhH/gYcGMq6fabPLGA5k7dVH1y4S5qA2+nsDrTcx1q9IkUe1HDAz1TwwqA6Inyh6n
         ajEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359877; x=1739964677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rEBrHtcjfEoUuHQWiZbj092Ws2ECaqqUNMQHsEcu0U=;
        b=CAESgUNOG1Bh3rC/AD5d6avhJv/eoxzqvBoJNM9T/Fkm8J8/lX8noISoTlU1syX6JM
         WHFWOYKqJs9bkCajTHg+iZAWnUKbMRYBoHOkCsqowJLmFmIlLA0j4hkdn3zXK4Bxif5i
         8ijC+FGp4zov4zqGuViAi33HF0UPLdDRf3ik3OTVFyITT3QxGBbg4XV6tYVM3Lx70nxB
         Oq8RuDzF5rgel8M8sdJ7XGKYRwoWjZN2DwLMbPTY4vNa38f15FqEe1yfdfSukWzSEQQz
         7XtuAUEvB47FExyYtp2+ku1bXqTSIPukVReyeFN46sdBmeF2bX2pTCbibihpOqKQKuik
         QvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFyBA2Dpnds1VqBzKB1PbIJPig8rUyq889uUVkPxplyIEo0VAgMUdA2Sr01W0K+jsR8ZKHrmI0pHja5tU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj95OdGq3xOvVeT2uRlreRTUkFNNPg+K4Juk4C3F8HPt+ofhRm
	b+DgzDLcDwFqSLyO5H4qq0yl7EgC/cs7BEe8+rJyTv5oyapx/qvsm5mRoxi7uCaRwF4gdik5t2z
	CAsbnwF4ECE2K8mhED0VNPBhlwc+5EoKcgKlC
X-Gm-Gg: ASbGncs4c6jnrrHF032r61nrYLjBqx7l34P9BJAu3AdFVO+gWNu2hzqXEHV1Tm63ck6
	IMyoaxI7Rg/uI2bvHjzIHV8AQaPpXQYo1MW9U8WfXpEpNPO+pVU09L2OcG+hEzWMMK4QRoXuX+M
	CMVoHNgqPtcQ1T/2j02iLF5YvlyGon
X-Google-Smtp-Source: AGHT+IGcpZpmBAcL6L1AYaPmfmCLBduxOA2TZ/XEFd8Ll4gx+1LVkEazKGesxL9aH78JZBBNLpJZ69BXw6iiOF1/NHQ=
X-Received: by 2002:a17:90a:c88e:b0:2fa:20f4:d277 with SMTP id
 98e67ed59e1d1-2fbf5c59edamr4556439a91.24.1739359877300; Wed, 12 Feb 2025
 03:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210042612.978247-1-longman@redhat.com> <20250210042612.978247-4-longman@redhat.com>
 <Z6w4UlCQa_g1OHlN@Mac.home>
In-Reply-To: <Z6w4UlCQa_g1OHlN@Mac.home>
From: Marco Elver <elver@google.com>
Date: Wed, 12 Feb 2025 12:30:41 +0100
X-Gm-Features: AWEUYZlid8tnSI_M5CNmo_NAFEKRRgGapbh7_REdPcYQ5nNgIjsLxmmVx436lXA
Message-ID: <CANpmjNNDArwBVcxAAAytw-KjJ0NazCPAUM0qBzjsu4bR6Kv1QA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] locking/lockdep: Disable KASAN instrumentation of lockdep.c
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 06:57, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> [Cc KASAN]
>
> A Reviewed-by or Acked-by from KASAN would be nice, thanks!
>
> Regards,
> Boqun
>
> On Sun, Feb 09, 2025 at 11:26:12PM -0500, Waiman Long wrote:
> > Both KASAN and LOCKDEP are commonly enabled in building a debug kernel.
> > Each of them can significantly slow down the speed of a debug kernel.
> > Enabling KASAN instrumentation of the LOCKDEP code will further slow
> > thing down.
> >
> > Since LOCKDEP is a high overhead debugging tool, it will never get
> > enabled in a production kernel. The LOCKDEP code is also pretty mature
> > and is unlikely to get major changes. There is also a possibility of
> > recursion similar to KCSAN.
> >
> > To evaluate the performance impact of disabling KASAN instrumentation
> > of lockdep.c, the time to do a parallel build of the Linux defconfig
> > kernel was used as the benchmark. Two x86-64 systems (Skylake & Zen 2)
> > and an arm64 system were used as test beds. Two sets of non-RT and RT
> > kernels with similar configurations except mainly CONFIG_PREEMPT_RT
> > were used for evaulation.
> >
> > For the Skylake system:
> >
> >   Kernel                      Run time            Sys time
> >   ------                      --------            --------
> >   Non-debug kernel (baseline) 0m47.642s             4m19.811s
> >   Debug kernel                        2m11.108s (x2.8)     38m20.467s (x8.9)
> >   Debug kernel (patched)      1m49.602s (x2.3)     31m28.501s (x7.3)
> >   Debug kernel
> >   (patched + mitigations=off)         1m30.988s (x1.9)     26m41.993s (x6.2)
> >
> >   RT kernel (baseline)                0m54.871s             7m15.340s
> >   RT debug kernel             6m07.151s (x6.7)    135m47.428s (x18.7)
> >   RT debug kernel (patched)   3m42.434s (x4.1)     74m51.636s (x10.3)
> >   RT debug kernel
> >   (patched + mitigations=off)         2m40.383s (x2.9)     57m54.369s (x8.0)
> >
> > For the Zen 2 system:
> >
> >   Kernel                      Run time            Sys time
> >   ------                      --------            --------
> >   Non-debug kernel (baseline) 1m42.806s            39m48.714s
> >   Debug kernel                        4m04.524s (x2.4)    125m35.904s (x3.2)
> >   Debug kernel (patched)      3m56.241s (x2.3)    127m22.378s (x3.2)
> >   Debug kernel
> >   (patched + mitigations=off)         2m38.157s (x1.5)     92m35.680s (x2.3)
> >
> >   RT kernel (baseline)                 1m51.500s           14m56.322s
> >   RT debug kernel             16m04.962s (x8.7)   244m36.463s (x16.4)
> >   RT debug kernel (patched)    9m09.073s (x4.9)   129m28.439s (x8.7)
> >   RT debug kernel
> >   (patched + mitigations=off)          3m31.662s (x1.9)    51m01.391s (x3.4)
> >
> > For the arm64 system:
> >
> >   Kernel                      Run time            Sys time
> >   ------                      --------            --------
> >   Non-debug kernel (baseline) 1m56.844s             8m47.150s
> >   Debug kernel                        3m54.774s (x2.0)     92m30.098s (x10.5)
> >   Debug kernel (patched)      3m32.429s (x1.8)     77m40.779s (x8.8)
> >
> >   RT kernel (baseline)                 4m01.641s           18m16.777s
> >   RT debug kernel             19m32.977s (x4.9)   304m23.965s (x16.7)
> >   RT debug kernel (patched)   16m28.354s (x4.1)   234m18.149s (x12.8)
> >
> > Turning the mitigations off doesn't seems to have any noticeable impact
> > on the performance of the arm64 system. So the mitigation=off entries
> > aren't included.
> >
> > For the x86 CPUs, cpu mitigations has a much bigger impact on
> > performance, especially the RT debug kernel. The SRSO mitigation in
> > Zen 2 has an especially big impact on the debug kernel. It is also the
> > majority of the slowdown with mitigations on. It is because the patched
> > ret instruction slows down function returns. A lot of helper functions
> > that are normally compiled out or inlined may become real function
> > calls in the debug kernel. The KASAN instrumentation inserts a lot
> > of __asan_loadX*() and __kasan_check_read() function calls to memory
> > access portion of the code. The lockdep's __lock_acquire() function,
> > for instance, has 66 __asan_loadX*() and 6 __kasan_check_read() calls
> > added with KASAN instrumentation. Of course, the actual numbers may vary
> > depending on the compiler used and the exact version of the lockdep code.

For completeness-sake, we'd also have to compare with
CONFIG_KASAN_INLINE=y, which gets rid of the __asan_ calls (not the
explicit __kasan_ checks). But I leave it up to you - I'm aware it
results in slow-downs, too. ;-)

> > With the newly added rtmutex and lockdep lock events, the relevant
> > event counts for the test runs with the Skylake system were:
> >
> >   Event type          Debug kernel    RT debug kernel
> >   ----------          ------------    ---------------
> >   lockdep_acquire     1,968,663,277   5,425,313,953
> >   rtlock_slowlock          -            401,701,156
> >   rtmutex_slowlock         -                139,672
> >
> > The __lock_acquire() calls in the RT debug kernel are x2.8 times of the
> > non-RT debug kernel with the same workload. Since the __lock_acquire()
> > function is a big hitter in term of performance slowdown, this makes
> > the RT debug kernel much slower than the non-RT one. The average lock
> > nesting depth is likely to be higher in the RT debug kernel too leading
> > to longer execution time in the __lock_acquire() function.
> >
> > As the small advantage of enabling KASAN instrumentation to catch
> > potential memory access error in the lockdep debugging tool is probably
> > not worth the drawback of further slowing down a debug kernel, disable
> > KASAN instrumentation in the lockdep code to allow the debug kernels
> > to regain some performance back, especially for the RT debug kernels.

It's not about catching a bug in the lockdep code, but rather guard
against bugs in code that allocated the storage for some
synchronization object. Since lockdep state is embedded in each
synchronization object, lockdep checking code may be passed a
reference to garbage data, e.g. on use-after-free (or even
out-of-bounds if there's an array of sync objects). In that case, all
bets are off and lockdep may produce random false reports. Sure the
system is already in a bad state at that point, but it's going to make
debugging much harder.

Our approach has always been to ensure that as soon as there's an
error state detected it's reported as soon as we can, before it
results in random failure as execution continues (e.g. bad lock
reports).

To guard against that, I would propose adding carefully placed
kasan_check_byte() in lockdep code.

