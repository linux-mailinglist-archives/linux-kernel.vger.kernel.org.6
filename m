Return-Path: <linux-kernel+bounces-517078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AEAA37BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7993AC292
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F318801A;
	Mon, 17 Feb 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ps4gzYvH"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75B178372
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775713; cv=none; b=H8ZKITXdT9d2u+JB3vvjzLSSJ6BsFrhuzYm47+9HDjVoRXI6tvCxJjg2FTcc2SBij5I1RK9+AqS63spXiOfQJvgvZ8fNQX186V+LeDU2jrG5Ts2MWn7p3wXkh8Qnzmi03B3+Mp2GJ/6kUgUF95qD/rjQLNKA33dNKlJECRP6Qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775713; c=relaxed/simple;
	bh=7r4qKklENyXgmD6E9tdOwGRFPxJqo1t1y7v4KhLhWfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRQJxx74Hmvm+GkuBXHoMbAmSSOlGSjckqg/8oY66bQu/KQuT+HzMrafRRdtHz4QaCApfccSOh31WjhPR4zSuXNVOziAYQOenykZuGy2AK1aICa9XxuRCiVS8uKn/UxJT0JjyXWcGoURff7pzJWU1UpOjFic4MzTSzfo1caWMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ps4gzYvH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e989edb6so74166665ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739775711; x=1740380511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u49MZ7ckUjks0G4rUJJF3Jdne3nRn7VDLa3q0SficI4=;
        b=ps4gzYvH3F+T++8bq5spR0D4mU9HduNNqSUtBYykKd4L86gv4v1wf/taEEslyw8y9L
         tyeQ7a7erOoeRcX25l70FdjkSbh9me7xkpAXwPVCASljvsTRXEDcLyhuQNtZmVeNozDY
         XDYOtHwELiJTi9ln8GNFQtgl15lv/TJ/L/3l9MHf+we280+6WI1MBYQYdzS58Aw7Ysgw
         UkdmqruFGbGq3v5y1OcFZjZxV9eR/eAvkcAuUKSwfwMvhNbPBmrWN4RxQ3u+IdW8VQEU
         fPB6sSKbcSTDFrc7SL/BwzYKVCvmT5d0FpC2VwXwJ7ZEYAibg0Zz7b5BzE7RMmiPOpFk
         EA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739775711; x=1740380511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u49MZ7ckUjks0G4rUJJF3Jdne3nRn7VDLa3q0SficI4=;
        b=GIjjI9/mBFsGFnQYSONaDGJ/XwSNzotNiuwsEi3VHSlEZ0WP+DS65yiyxtd3pvCxT+
         O+7OLab48mmF8vPWtdlcz8QhrX4thc/caMEqlEW/vplyxuRh+dCQKN+Lmxq9Ablnv8hk
         TvtH9ReBxidGAdImQW+PCmWsm71JKkZBlRFwC/FzWOsvl2RA67PZf8Iahom/CXcolEcU
         XicuUOeEIlbuRMACgFhcT/lWioSryA7/4KBOAs32SYKTK0Xkm8EFObGPI37fiiDBvICE
         REgzeWweLrXj061l2lAuYYbMCFxGCP271UaqUvFyC3zXRb5ZRCGmiFmCzwU7ddBKyndQ
         3A2w==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ld8B7pvNGBSkY8GrvwQtjs7nJH3TRRI1T9boVxtZppw+WNVr7+O7JxmqUe9Wttdd28R7dtNOO7rKuKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOmAdwUai5PK1h9A6ZNOpwDMd6kEU593B+eb8onszcY0ZpG2J
	Dgt3ML1rBirnfL3cr68NrlsWpmoKmgdpw7mEF5hsklO0Z/b2kGsV2MZGATp+E7u9TllZ32XxtoZ
	p2oKWJuVZLXqEnAsWEQxMAMXPXGfKdxn/s3lc
X-Gm-Gg: ASbGnctYYU9W7n1vb9jQAbkg5iopFqMPKNmYD0ZwMTIpXl9qjDJg55qkea6zkdoBzrP
	R4NAwiGl59Z7VQ9iE3p1cCYiIVyzjCXoRuT0acsBBCY+CaqR6Hiu3IS9z/vl+iG+LbaPCuf+JdX
	dxcJxfqmHOKYpZ0i5ZAQJgdFNasll8
X-Google-Smtp-Source: AGHT+IFWeRyJtkvClRvrsWaquwaeI1lrqbnBhDHjEWuXWIRcFBofwpVQo+CUyulA1nqe9sELux2HQzrj7rguLgLFLu8=
X-Received: by 2002:a17:902:fc4e:b0:21f:71b4:d2aa with SMTP id
 d9443c01a7336-22103efeebcmr156092895ad.5.1739775711051; Sun, 16 Feb 2025
 23:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213200228.1993588-1-longman@redhat.com> <20250213200228.1993588-4-longman@redhat.com>
In-Reply-To: <20250213200228.1993588-4-longman@redhat.com>
From: Marco Elver <elver@google.com>
Date: Mon, 17 Feb 2025 08:00:00 +0100
X-Gm-Features: AWEUYZmwE5--6gxi63zdBnPmPq2kP11LV4_YCuAvaNLPtiVGpigxkVLu7uW9PZs
Message-ID: <CANpmjNPRZNTX2BKufHU16ybfcCvDaJmOSgihP7d0r9bgNZtGaQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/lockdep: Disable KASAN instrumentation of lockdep.c
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 21:02, Waiman Long <longman@redhat.com> wrote:
>
> Both KASAN and LOCKDEP are commonly enabled in building a debug kernel.
> Each of them can significantly slow down the speed of a debug kernel.
> Enabling KASAN instrumentation of the LOCKDEP code will further slow
> thing down.
>
> Since LOCKDEP is a high overhead debugging tool, it will never get
> enabled in a production kernel. The LOCKDEP code is also pretty mature
> and is unlikely to get major changes. There is also a possibility of
> recursion similar to KCSAN.
>
> To evaluate the performance impact of disabling KASAN instrumentation
> of lockdep.c, the time to do a parallel build of the Linux defconfig
> kernel was used as the benchmark. Two x86-64 systems (Skylake & Zen 2)
> and an arm64 system were used as test beds. Two sets of non-RT and RT
> kernels with similar configurations except mainly CONFIG_PREEMPT_RT
> were used for evaulation.
>
> For the Skylake system:
>
>   Kernel                        Run time            Sys time
>   ------                        --------            --------
>   Non-debug kernel (baseline)   0m47.642s             4m19.811s
>
>   [CONFIG_KASAN_INLINE=y]
>   Debug kernel                  2m11.108s (x2.8)     38m20.467s (x8.9)
>   Debug kernel (patched)        1m49.602s (x2.3)     31m28.501s (x7.3)
>   Debug kernel
>   (patched + mitigations=off)   1m30.988s (x1.9)     26m41.993s (x6.2)
>
>   RT kernel (baseline)          0m54.871s             7m15.340s
>
>   [CONFIG_KASAN_INLINE=n]
>   RT debug kernel               6m07.151s (x6.7)    135m47.428s (x18.7)
>   RT debug kernel (patched)     3m42.434s (x4.1)     74m51.636s (x10.3)
>   RT debug kernel
>   (patched + mitigations=off)   2m40.383s (x2.9)     57m54.369s (x8.0)
>
>   [CONFIG_KASAN_INLINE=y]
>   RT debug kernel               3m22.155s (x3.7)     77m53.018s (x10.7)
>   RT debug kernel (patched)     2m36.700s (x2.9)     54m31.195s (x7.5)
>   RT debug kernel
>   (patched + mitigations=off)   2m06.110s (x2.3)     45m49.493s (x6.3)
>
> For the Zen 2 system:
>
>   Kernel                        Run time            Sys time
>   ------                        --------            --------
>   Non-debug kernel (baseline)   1m42.806s            39m48.714s
>
>   [CONFIG_KASAN_INLINE=y]
>   Debug kernel                  4m04.524s (x2.4)    125m35.904s (x3.2)
>   Debug kernel (patched)        3m56.241s (x2.3)    127m22.378s (x3.2)
>   Debug kernel
>   (patched + mitigations=off)   2m38.157s (x1.5)     92m35.680s (x2.3)
>
>   RT kernel (baseline)           1m51.500s           14m56.322s
>
>   [CONFIG_KASAN_INLINE=n]
>   RT debug kernel               16m04.962s (x8.7)   244m36.463s (x16.4)
>   RT debug kernel (patched)      9m09.073s (x4.9)   129m28.439s (x8.7)
>   RT debug kernel
>   (patched + mitigations=off)    3m31.662s (x1.9)    51m01.391s (x3.4)
>
> For the arm64 system:
>
>   Kernel                        Run time            Sys time
>   ------                        --------            --------
>   Non-debug kernel (baseline)   1m56.844s             8m47.150s
>   Debug kernel                  3m54.774s (x2.0)     92m30.098s (x10.5)
>   Debug kernel (patched)        3m32.429s (x1.8)     77m40.779s (x8.8)
>
>   RT kernel (baseline)           4m01.641s           18m16.777s
>
>   [CONFIG_KASAN_INLINE=n]
>   RT debug kernel               19m32.977s (x4.9)   304m23.965s (x16.7)
>   RT debug kernel (patched)     16m28.354s (x4.1)   234m18.149s (x12.8)
>
> Turning the mitigations off doesn't seems to have any noticeable impact
> on the performance of the arm64 system. So the mitigation=off entries
> aren't included.
>
> For the x86 CPUs, cpu mitigations has a much bigger
> impact on performance, especially the RT debug kernel with
> CONFIG_KASAN_INLINE=n. The SRSO mitigation in Zen 2 has an especially
> big impact on the debug kernel. It is also the majority of the slowdown
> with mitigations on. It is because the patched ret instruction slows
> down function returns. A lot of helper functions that are normally
> compiled out or inlined may become real function calls in the debug
> kernel.
>
> With CONFIG_KASAN_INLINE=n, the KASAN instrumentation inserts a
> lot of __asan_loadX*() and __kasan_check_read() function calls to memory
> access portion of the code. The lockdep's __lock_acquire() function,
> for instance, has 66 __asan_loadX*() and 6 __kasan_check_read() calls
> added with KASAN instrumentation. Of course, the actual numbers may vary
> depending on the compiler used and the exact version of the lockdep code.
>
> With the Skylake test system, the parallel kernel build times reduction
> of the RT debug kernel with this patch are:
>
>  CONFIG_KASAN_INLINE=n: -37%
>  CONFIG_KASAN_INLINE=y: -22%
>
> The time reduction is less with CONFIG_KASAN_INLINE=y, but it is still
> significant.
>
> Setting CONFIG_KASAN_INLINE=y can result in a significant performance
> improvement. The major drawback is a significant increase in the size
> of kernel text. In the case of vmlinux, its text size increases from
> 45997948 to 67606807. That is a 47% size increase (about 21 Mbytes). The
> size increase of other kernel modules should be similar.
>
> With the newly added rtmutex and lockdep lock events, the relevant
> event counts for the test runs with the Skylake system were:
>
>   Event type            Debug kernel    RT debug kernel
>   ----------            ------------    ---------------
>   lockdep_acquire       1,968,663,277   5,425,313,953
>   rtlock_slowlock            -            401,701,156
>   rtmutex_slowlock           -                139,672
>
> The __lock_acquire() calls in the RT debug kernel are x2.8 times of the
> non-RT debug kernel with the same workload. Since the __lock_acquire()
> function is a big hitter in term of performance slowdown, this makes
> the RT debug kernel much slower than the non-RT one. The average lock
> nesting depth is likely to be higher in the RT debug kernel too leading
> to longer execution time in the __lock_acquire() function.
>
> As the small advantage of enabling KASAN instrumentation to catch
> potential memory access error in the lockdep debugging tool is probably
> not worth the drawback of further slowing down a debug kernel, disable
> KASAN instrumentation in the lockdep code to allow the debug kernels
> to regain some performance back, especially for the RT debug kernels.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/locking/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index 0db4093d17b8..a114949eeed5 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -5,7 +5,8 @@ KCOV_INSTRUMENT         := n
>
>  obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
>
> -# Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
> +# Avoid recursion lockdep -> sanitizer -> ... -> lockdep & improve performance.
> +KASAN_SANITIZE_lockdep.o := n
>  KCSAN_SANITIZE_lockdep.o := n
>
>  ifdef CONFIG_FUNCTION_TRACER
> --
> 2.48.1
>

