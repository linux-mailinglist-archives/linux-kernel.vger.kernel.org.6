Return-Path: <linux-kernel+bounces-518112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE7A38A18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2448188670C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F254226176;
	Mon, 17 Feb 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3aTHIqW"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2F225A2B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811201; cv=none; b=LdZbI48lrd01lQ3ZiVJSSTcRfe+OIflcdk5hMKy05rRBSOBf6XlMzSBRe4W+101l3S9GiFwAakrMJjgyV7Q4D+ma2JvDb9c6PLpT+WhoNY6BmlM39ZNcubQpfQ0Ej2oQx/2ydlEekltSNxjTO6YTsi3bekiQpK+hXaI9gPdnsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811201; c=relaxed/simple;
	bh=f7y8j9pjG5uEYkCajsPl00jyXw2irwRUdNnVNb3JUvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFWji20xBZ547CS3+heV1IIXjuWzwU84qTgnhco00AuhTRNNM5muQ0YP1+toS76jroNY3cRvHL4l0ggI+lB6iKcNoE1u8ViWBZ9pfk3AMBnFZDoJJIyfvm+saHqMdg3Ez22WD0NPaIAddhVcLe2DY/2cc7q5sRSUOymbxrB2RGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3aTHIqW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f3ea6207cso1254609f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739811198; x=1740415998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvdJf21GoegasY6n8lXzZm394g3OkhBN6ZsY04z9+Pw=;
        b=F3aTHIqWIcWPzdhAmTSRxL4cR+627QCbqQd83OmK2Oz9jswsUWLRPAdVUhvblzIzY0
         ZEcgDBwcMgCK1jOh24CubyD9/ShkOJjNQrMTkS0y2aXkVldHibX+X4Q9sWBPVex7zIU8
         yegZIJvt+c4adJbG9OjQzT3ttjS+vUByHXshmqtRCBcp3frNzwPA0+dXDTYtIqnZZl7D
         jpD/xjkghK2loX+zy/h70z0DJbTfyBNZh9D+RLXqnWKzQH+izoLAsn1LJLxhiUfAk2C+
         KPEU7MkfP52UOJlOsl1sP49y15xYgAWgWgr8MEJ2G9WuGo/xjGwZ/XI7d82qa8MbhLj+
         QQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811198; x=1740415998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvdJf21GoegasY6n8lXzZm394g3OkhBN6ZsY04z9+Pw=;
        b=MjmhkmD6dEaXiuGj2Kc3V29GcYUBS9AQWafR24mtBtlCHrvGe8HHt3YHvtOAHgyOMY
         JDl81MXskHBLSYeVBzN7/MpjNY6WvayjmVKXUp2sX/qyuj2L1GsWwJZeZDOGO59xGI6w
         fziBb4xPvg8bAwzZ+yffF9LCJCQjGCYS9iKRo8Y8/TVfOBCSplPSbwU4l36ckDMGClCg
         fyaI1jvt2wYBWYPxNA4yJyg5y+ndyzRZM5jWH427tYkqE0XxdSFl9TvPjw2LU/wa37T1
         QAzfx7SsRbdvxGE6eeC+HB+AJhhjgUeNE1tGB9S/OeXAk9Vup4zQGbBwFvOvIaGhzl1l
         KPuA==
X-Forwarded-Encrypted: i=1; AJvYcCVUwg8rb7fwFunVUvHUQ4p2qoJQuzcHoZ7M99gag6pB3eG9nph6/B+biHJFhYp2co1BiMZY+YR7Dmp3jX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKoxHiFR1gCoMvKu/hcqLE0CbzXcxZzPa9JYbQWEw6TB9FEw0R
	FmA1N8n7Vk85+YwhmLZOUgeCsNdT/WMOoDg91D9h+jqLdvJ21p++qN0DbrNmw58LO9vc2BnpJy0
	SSbgSAb86WzLvHkS7Tf72jLs2kGY=
X-Gm-Gg: ASbGnctNWv0oE9c5/sBr1X1XepxJMVtaN6K3MmbTlMmoXgxUr/LH1uSA/Xxwa9Zkezv
	W+MsyzpxHWabpk/YXCNOo1iLfj6TaYMhf/Q0T1ByWWgPVZMNvkiqdIe5IKhWZ338kUJHf6RlGlh
	k=
X-Google-Smtp-Source: AGHT+IEUDyJuTzoW1Vhnk9hbjUpfzVVHeaWdhiqE+Kz6rVm/f00EQCCVsi6mY0QmMAC1+qGyfSTWvQ9gy/v+1u135fA=
X-Received: by 2002:a05:6000:1a88:b0:38f:3471:71c8 with SMTP id
 ffacd0b85a97d-38f34717a8cmr10059788f8f.3.1739811197535; Mon, 17 Feb 2025
 08:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213200228.1993588-1-longman@redhat.com> <20250213200228.1993588-4-longman@redhat.com>
In-Reply-To: <20250213200228.1993588-4-longman@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 17:53:06 +0100
X-Gm-Features: AWEUYZmYEqdFvZotG9KZbJIqLDLclnjk8BpXBPWYIm83Fr2d3AreoXDFZwNNHf4
Message-ID: <CA+fCnZfaCGhZiHPm1wRMLv7oPsvZ-_dvR33mgYEtLY_ss+g4DQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/lockdep: Disable KASAN instrumentation of lockdep.c
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 9:02=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
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
>   [CONFIG_KASAN_INLINE=3Dy]
>   Debug kernel                  2m11.108s (x2.8)     38m20.467s (x8.9)
>   Debug kernel (patched)        1m49.602s (x2.3)     31m28.501s (x7.3)
>   Debug kernel
>   (patched + mitigations=3Doff)   1m30.988s (x1.9)     26m41.993s (x6.2)
>
>   RT kernel (baseline)          0m54.871s             7m15.340s
>
>   [CONFIG_KASAN_INLINE=3Dn]
>   RT debug kernel               6m07.151s (x6.7)    135m47.428s (x18.7)
>   RT debug kernel (patched)     3m42.434s (x4.1)     74m51.636s (x10.3)
>   RT debug kernel
>   (patched + mitigations=3Doff)   2m40.383s (x2.9)     57m54.369s (x8.0)
>
>   [CONFIG_KASAN_INLINE=3Dy]
>   RT debug kernel               3m22.155s (x3.7)     77m53.018s (x10.7)
>   RT debug kernel (patched)     2m36.700s (x2.9)     54m31.195s (x7.5)
>   RT debug kernel
>   (patched + mitigations=3Doff)   2m06.110s (x2.3)     45m49.493s (x6.3)
>
> For the Zen 2 system:
>
>   Kernel                        Run time            Sys time
>   ------                        --------            --------
>   Non-debug kernel (baseline)   1m42.806s            39m48.714s
>
>   [CONFIG_KASAN_INLINE=3Dy]
>   Debug kernel                  4m04.524s (x2.4)    125m35.904s (x3.2)
>   Debug kernel (patched)        3m56.241s (x2.3)    127m22.378s (x3.2)
>   Debug kernel
>   (patched + mitigations=3Doff)   2m38.157s (x1.5)     92m35.680s (x2.3)
>
>   RT kernel (baseline)           1m51.500s           14m56.322s
>
>   [CONFIG_KASAN_INLINE=3Dn]
>   RT debug kernel               16m04.962s (x8.7)   244m36.463s (x16.4)
>   RT debug kernel (patched)      9m09.073s (x4.9)   129m28.439s (x8.7)
>   RT debug kernel
>   (patched + mitigations=3Doff)    3m31.662s (x1.9)    51m01.391s (x3.4)
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
>   [CONFIG_KASAN_INLINE=3Dn]
>   RT debug kernel               19m32.977s (x4.9)   304m23.965s (x16.7)
>   RT debug kernel (patched)     16m28.354s (x4.1)   234m18.149s (x12.8)
>
> Turning the mitigations off doesn't seems to have any noticeable impact
> on the performance of the arm64 system. So the mitigation=3Doff entries
> aren't included.
>
> For the x86 CPUs, cpu mitigations has a much bigger
> impact on performance, especially the RT debug kernel with
> CONFIG_KASAN_INLINE=3Dn. The SRSO mitigation in Zen 2 has an especially
> big impact on the debug kernel. It is also the majority of the slowdown
> with mitigations on. It is because the patched ret instruction slows
> down function returns. A lot of helper functions that are normally
> compiled out or inlined may become real function calls in the debug
> kernel.
>
> With CONFIG_KASAN_INLINE=3Dn, the KASAN instrumentation inserts a
> lot of __asan_loadX*() and __kasan_check_read() function calls to memory
> access portion of the code. The lockdep's __lock_acquire() function,
> for instance, has 66 __asan_loadX*() and 6 __kasan_check_read() calls
> added with KASAN instrumentation. Of course, the actual numbers may vary
> depending on the compiler used and the exact version of the lockdep code.
>
> With the Skylake test system, the parallel kernel build times reduction
> of the RT debug kernel with this patch are:
>
>  CONFIG_KASAN_INLINE=3Dn: -37%
>  CONFIG_KASAN_INLINE=3Dy: -22%
>
> The time reduction is less with CONFIG_KASAN_INLINE=3Dy, but it is still
> significant.
>
> Setting CONFIG_KASAN_INLINE=3Dy can result in a significant performance
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
> ---
>  kernel/locking/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index 0db4093d17b8..a114949eeed5 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -5,7 +5,8 @@ KCOV_INSTRUMENT         :=3D n
>
>  obj-y +=3D mutex.o semaphore.o rwsem.o percpu-rwsem.o
>
> -# Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
> +# Avoid recursion lockdep -> sanitizer -> ... -> lockdep & improve perfo=
rmance.
> +KASAN_SANITIZE_lockdep.o :=3D n
>  KCSAN_SANITIZE_lockdep.o :=3D n
>
>  ifdef CONFIG_FUNCTION_TRACER
> --
> 2.48.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

