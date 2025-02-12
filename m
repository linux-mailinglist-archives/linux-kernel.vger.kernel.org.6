Return-Path: <linux-kernel+bounces-510535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C6A31E60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124473A9272
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71901FBC8D;
	Wed, 12 Feb 2025 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktlAct3w"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CE1F4289
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339864; cv=none; b=AroCWMD8KegCNA1eo/p4et7tUTZ+UXOvio7CKjdE7EetqBeV2HE3XhQ/V79BBrRaldnBAX/SDhSWn2sF0Wcdke8Y1KJKML9bq2fG4rk3vq45rIriparo+BqDrjEE1gNAgRynoU4lkJMruYpVVAShwtx3MHGGGcXklCvB+w6p64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339864; c=relaxed/simple;
	bh=+ljeOKg+vaYlNz/DEM53EgmuUWkjsU95Xj969c6QTpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYi8FGVmEovIPZ/BoI/3Iete+S58pxvAamXNEZ5scno1hGrO/SN/4kv90wPYPXtA1vmROmqHxL3v5uXm6LWUkShcW8dB7HAsUk9pDuh5nuFa01zGgNOlGFEiR8i+rkSZZJJXMgYLDFyJGTTdeW6ZMh/QgTxNKqHCjNp1+CBaDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktlAct3w; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e46af00c9fso13292566d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739339861; x=1739944661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBCiVpUQxmyhbDltoFsuEwDS/2Q9oN0bzv5AHCnlEZs=;
        b=ktlAct3wXn5v9E1aE9E1NTDCftxEuXv9D4ifIQnVRORjU+sMEMmo4Y/UrxgWmtQX3Y
         EC91EPDVD7mGyqO6T13GGTmEKgIkrsvN9CFsE7LwP0SQ1CB+RKCABNrkLi1WpzdfN75g
         on2JR0mddX3g4eYMHHPoARrBo5QOhQ4Rb5UqxXii90eGBeyMh8wTfFI0QIXIYSmlkmQw
         fm7wFEKYPyb+gyeF97j/xa08g+oyHh+ZN43n08RyLJ+jUzGihNvRWEU6V/ifm7WOEZC3
         N+FA7RYqNLwzrYVHIhE80IiIlsz/aKZP2U+Ka6c2cGPecbYb3MWxWwOifIx/TMELaNFk
         Fl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739339861; x=1739944661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBCiVpUQxmyhbDltoFsuEwDS/2Q9oN0bzv5AHCnlEZs=;
        b=gzTwdQm9QZWe9qfChm97GFm4Wh1Gn7EKCTKSmGi+V8JKlwWrA3wBLa8A/qyc8hI9ts
         W+cEg0chgp7Dc7wcSQlxR/0LWLryLbWbZBODvUK3ohtEfuf3YM1Kmmb+5Exd3RvR4qVz
         gAsROPtPw3fjsaFCLUMhyL32qRDLyQUyoAX8gMNp4Sd3LUlKsCB9Ad+Z2vmqq+JEk3Dp
         46WTqLGITcfiandxmpFJMGW4VuA8u9RDfFeaDW+9CONNCd2qVbQ1xpgDnF1iLUl/Klri
         vzLJjQ/n/T9dMK0nAnhTvTGDTOIs4aic7xtvfBIhBfm7sYJLq7N0s8pXp9p3qM7A1xaj
         VmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYl0hR/dCBRrOWtvwlZzbZKCYq1/Ji3kZUcvo95/5yAYTPQvm4LI/7L/EAjcsZr0sAdlJjHehdmiwKtsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhg9LZKySqwlDm9mrbtT3d+s0a78tHAIg5ZOpNSDo4Z8gC2gL3
	JUdbPA6hT5akItPYt+6xQGGv8Cs0hIZZqWBT8DOGD9KhFkuZUUrC
X-Gm-Gg: ASbGncspIAXV4wTWbGEd3AcY6gkqFNQX6fKIGei8RUq50PUBAug2/xxj+2FXiFJOUd6
	+43RA9WYGT26Jzyj/iE/G5eTdFDw5mPUNKeQrMZp4ntzMVhrXrikypD3XZ+9zJEex8gF5Hql6v7
	XU7/MCUwrm7Y5WPqHkrZxyYWLV6S9wqlbBwfld3qDVWVhkKHXaoqAVekWNpQ4JDztV0KOxAVCl1
	p3pfKi0CAo9Z1jMwgNSbzgENPDWsAojzZR89OGKhAP7osQIOHHhovU6UK/zuoglYCeldCeB+H9W
	0IF61T5kNblu+PHznS9/i/BZ8NOu+P9mDuGHpsExWtF22W2i0SsWiBYJN1cFTKIvEF0OE6vK5R/
	1LmfyEA==
X-Google-Smtp-Source: AGHT+IFhzlL1ozld4WYVoMIA1Lxyh579DeZbGlywqzrTE0bbbFKnhSKPj80hMK219aiHoPH7m87xWQ==
X-Received: by 2002:a05:6214:d6e:b0:6d8:8b9d:1502 with SMTP id 6a1803df08f44-6e46edaba55mr33637816d6.30.1739339860920;
        Tue, 11 Feb 2025 21:57:40 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e4556d153asm50548926d6.13.2025.02.11.21.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 21:57:40 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18B591200043;
	Wed, 12 Feb 2025 00:57:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 12 Feb 2025 00:57:40 -0500
X-ME-Sender: <xms:UzisZ8Xk12b_23q3PfWvWu3GQlRksxhDz5jbkBmlLuF1WlJNH5zPfg>
    <xme:UzisZwmCB8WxgfYLOrLDjv2fF2AixKcxr7t-0gTEgIyO6BAYB2jHswYIvbn3BcJC7
    IBntUNogXJ7odJjlg>
X-ME-Received: <xmr:UzisZwbMskjtY7BNyxxiItZfxNcLDJsjZn-Li7TP7ocos8hM2C-Y7NTJ5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlrdguvggrtg
    honhesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhigrsghinhhinhdrrgdrrgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehglhhiuggvrhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtoheprghnughrvgihkhhnvhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughvhi
    hukhhovhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:UzisZ7Wu2SUeaPL_YS52-7TJH82ULURBqq5nAyQwBrVTdaOJZxPsPg>
    <xmx:VDisZ2nFxfFZwKAhJiUg3Flu0hOoWzyTVRNq2qzSuZ1pePoJccypGA>
    <xmx:VDisZwcARCzB61ftBWyMmbKEpl8lYq9S2fdchTOhStIDMvd4CbBjrg>
    <xmx:VDisZ4HeC3yOM-032aEndsvwEF19VCk_K2RkkHmYUPo6ECd0yflUlA>
    <xmx:VDisZ8lvkoDyjrSj8HldPRqLrtN4lZj6JJmENSpnyX0S3tsn4WZxDGwL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 00:57:39 -0500 (EST)
Date: Tue, 11 Feb 2025 21:57:38 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 3/3] locking/lockdep: Disable KASAN instrumentation of
 lockdep.c
Message-ID: <Z6w4UlCQa_g1OHlN@Mac.home>
References: <20250210042612.978247-1-longman@redhat.com>
 <20250210042612.978247-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210042612.978247-4-longman@redhat.com>

[Cc KASAN]

A Reviewed-by or Acked-by from KASAN would be nice, thanks!

Regards,
Boqun

On Sun, Feb 09, 2025 at 11:26:12PM -0500, Waiman Long wrote:
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
>   Kernel			Run time	    Sys time
>   ------			--------	    --------
>   Non-debug kernel (baseline)	0m47.642s	      4m19.811s
>   Debug kernel			2m11.108s (x2.8)     38m20.467s (x8.9)
>   Debug kernel (patched)	1m49.602s (x2.3)     31m28.501s (x7.3)
>   Debug kernel
>   (patched + mitigations=off) 	1m30.988s (x1.9)     26m41.993s (x6.2)
> 
>   RT kernel (baseline)		0m54.871s	      7m15.340s
>   RT debug kernel		6m07.151s (x6.7)    135m47.428s (x18.7)
>   RT debug kernel (patched)	3m42.434s (x4.1)     74m51.636s (x10.3)
>   RT debug kernel
>   (patched + mitigations=off) 	2m40.383s (x2.9)     57m54.369s (x8.0)
> 
> For the Zen 2 system:
> 
>   Kernel			Run time	    Sys time
>   ------			--------	    --------
>   Non-debug kernel (baseline)	1m42.806s	     39m48.714s
>   Debug kernel			4m04.524s (x2.4)    125m35.904s (x3.2)
>   Debug kernel (patched)	3m56.241s (x2.3)    127m22.378s (x3.2)
>   Debug kernel
>   (patched + mitigations=off) 	2m38.157s (x1.5)     92m35.680s (x2.3)
> 
>   RT kernel (baseline)		 1m51.500s	     14m56.322s
>   RT debug kernel		16m04.962s (x8.7)   244m36.463s (x16.4)
>   RT debug kernel (patched)	 9m09.073s (x4.9)   129m28.439s (x8.7)
>   RT debug kernel
>   (patched + mitigations=off) 	 3m31.662s (x1.9)    51m01.391s (x3.4)
> 
> For the arm64 system:
> 
>   Kernel			Run time	    Sys time
>   ------			--------	    --------
>   Non-debug kernel (baseline)	1m56.844s	      8m47.150s
>   Debug kernel			3m54.774s (x2.0)     92m30.098s (x10.5)
>   Debug kernel (patched)	3m32.429s (x1.8)     77m40.779s (x8.8)
> 
>   RT kernel (baseline)		 4m01.641s	     18m16.777s
>   RT debug kernel		19m32.977s (x4.9)   304m23.965s (x16.7)
>   RT debug kernel (patched)	16m28.354s (x4.1)   234m18.149s (x12.8)
> 
> Turning the mitigations off doesn't seems to have any noticeable impact
> on the performance of the arm64 system. So the mitigation=off entries
> aren't included.
> 
> For the x86 CPUs, cpu mitigations has a much bigger impact on
> performance, especially the RT debug kernel. The SRSO mitigation in
> Zen 2 has an especially big impact on the debug kernel. It is also the
> majority of the slowdown with mitigations on. It is because the patched
> ret instruction slows down function returns. A lot of helper functions
> that are normally compiled out or inlined may become real function
> calls in the debug kernel. The KASAN instrumentation inserts a lot
> of __asan_loadX*() and __kasan_check_read() function calls to memory
> access portion of the code. The lockdep's __lock_acquire() function,
> for instance, has 66 __asan_loadX*() and 6 __kasan_check_read() calls
> added with KASAN instrumentation. Of course, the actual numbers may vary
> depending on the compiler used and the exact version of the lockdep code.
> 
> With the newly added rtmutex and lockdep lock events, the relevant
> event counts for the test runs with the Skylake system were:
> 
>   Event type		Debug kernel	RT debug kernel
>   ----------		------------	---------------
>   lockdep_acquire	1,968,663,277	5,425,313,953
>   rtlock_slowlock	     -		  401,701,156
>   rtmutex_slowlock	     -		      139,672
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
> @@ -5,7 +5,8 @@ KCOV_INSTRUMENT		:= n
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

