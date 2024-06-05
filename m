Return-Path: <linux-kernel+bounces-202055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8478FC743
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200D31F23604
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2D18FC63;
	Wed,  5 Jun 2024 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hNg7iC3f"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0AF1946AD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578623; cv=none; b=P3DMW3E7P+r+6queRTmlxSARV4US0JTseX18Dn7vQXKZU//KwIbkKQWVyD7xWr+Y3qOK5ldOWoYO1uoAuKkMerydE/wLqNocrzKAAiifWmskFQfCJlyb1+EQS0ywsyZ8Ayo9YoLsHLZ1S/n86g8iKFf9W6yVm6pwbBN36MXn+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578623; c=relaxed/simple;
	bh=yOTih9G7ODIXRlcYjTZvkMP34cadVP1nlM064A0eWpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsbqOueHsgMPVzNhAmLkBAZdgG5CUpIwd6hVmEyLjChx88S4DG8UlxRswOP54dgk2219mJCo/1hGFNbv2tcPugBnrxrogUVwaaFu7c+5Xw8t2g038NJ5biMhG4JOnjVs3GAebrhWbZAX2pw8z7kbhTcPNFuRxQslEp7xLpZ/yE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hNg7iC3f; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4eb007a9f6fso1921881e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717578621; x=1718183421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ1LMuTl325yqFl+4iAqYp0VklW2VR3/7tD6PNuEdA4=;
        b=hNg7iC3fq2imkpyeM40nZmuGhFilSgc5WaoQRrGDK/3P+LxsKsRw3hJcAQm2c4ZUd7
         94GSEc5EctE4VMWy0pNickLMHsi6lp3MLgHC/q1v9WnnD9qdBLR/1X1gLfUuQyERSVex
         GSRG71GDO15rdGaW/n5Cv5tt3z83/KuFGv+nTlfA2PIaKZo8Cw6Ru+3UDv2GIP5+cx9a
         4bVWQjyJ08JdXstSR/lyWcqZMljV8LUK6sE+w7NNBHFHnS+sCC/v0ukST29C277F+EPq
         FrQ31V4ZLlijA/sBkZG0c94mi/SrLkTInR7PCsZvNpFgqgkFpWzGMb3dWUX9g4KaYrQP
         cJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578621; x=1718183421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ1LMuTl325yqFl+4iAqYp0VklW2VR3/7tD6PNuEdA4=;
        b=Skneij5jM0St7OooNsDljD9O3G0hV4FSTwySuNNHPwigxcjwV4gc+M0SanHNeILosa
         li14P94tV0Tg9KfjTo2GEW6rSz1AQ0H6BdCMGdWq4HpFn4XGXwhxnYSkB80lQayOEN+1
         5AqQysOlMaflFRuZBpjm5kD8nO2fw5xATyNCMH0IQn7R5sYhEs6RBnBVphXihiREfqj7
         RBBaJGvB+iIVWMX/gyG3xLlX1CWbbxACkB0wZYYIuVNFallVpPOQmIzCap682To3808+
         3WSN1xwZuM7i61qk4hgMAq6qN8vehoymD2rlZXkrggFWMuqbSB0TvdofmYqKVTYzLuvL
         TIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3xUgo/OmmGV8MdTBRCJXCMzRFWBT189M7IYhAlxehVXcia2PPT/HpWyNJ1eJlAqDxZddMxMQL2m9tU1rqGshHGTJGIA2hbwTr0eaI
X-Gm-Message-State: AOJu0Yyfo6k1Z1ZDIxdrYVuYpGT1oTbRN1dG/TBYr4Mt7m6wvWEVWevs
	v5R7gZ2zaD2IWir7LiuDJiica6EWky0dke6OiDXqtVnLphntQIXD1vGDkwiM9hZIAmfz/sMwyJd
	ZZ5lVD29OjT/3iZTw1ezqT+Od89w/LpSgf8ZL
X-Google-Smtp-Source: AGHT+IEUJUblhHZpnwUXuDZTcOrFBeT9DdI8vZ3SYE4lvNmMcdSVszzHeOT0Pnn/1j4l5naZmVT5x33tPBl8O+7I48s=
X-Received: by 2002:a05:6122:134:b0:4e4:eb50:fd57 with SMTP id
 71dfb90a1353d-4eb3a432441mr2162001e0c.9.1717578619332; Wed, 05 Jun 2024
 02:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <80972769ad2ebebc7ab0c39bd48f31ce080f0394.1717507310.git.dvyukov@google.com>
In-Reply-To: <80972769ad2ebebc7ab0c39bd48f31ce080f0394.1717507310.git.dvyukov@google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 5 Jun 2024 11:09:40 +0200
Message-ID: <CANpmjNO4PX94DSVn_ndjsNqzr3Dw5Lc_nVUEu4oc6RK-iny16g@mail.gmail.com>
Subject: Re: [PATCH 2/4] kcov: add interrupt handling self test
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, glider@google.com, nogikh@google.com, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 15:45, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Add a boot self test that can catch sprious coverage from interrupts.
> The coverage callback filters out interrupt code, but only after the
> handler updates preempt count. Some code periodically leaks out
> of that section and leads to spurious coverage.
> Add a best-effort (but simple) test that is likely to catch such bugs.
> If the test is enabled on CI systems that use KCOV, they should catch
> any issues fast.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
>
> ---
>
> In my local testing w/o the previous fix,
> it immidiatly produced the following splat:
>
> kcov: running selftest
> BUG: TASK stack guard page was hit at ffffc90000147ff8
> Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
> ...
>  kvm_set_cpu_l1tf_flush_l1d+0x5/0x20
>  sysvec_call_function+0x15/0xb0
>  asm_sysvec_call_function+0x1a/0x20
>  kcov_init+0xe4/0x130
>  do_one_initcall+0xbc/0x470
>  kernel_init_freeable+0x4fc/0x930
>  kernel_init+0x1c/0x2b0
> ---
>  kernel/kcov.c     | 28 ++++++++++++++++++++++++++++
>  lib/Kconfig.debug |  9 +++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c3124f6d5536..04136f80042f 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -1057,6 +1057,30 @@ u64 kcov_common_handle(void)
>  }
>  EXPORT_SYMBOL(kcov_common_handle);
>
> +#ifdef CONFIG_KCOV_TEST
> +static void __init selftest(void)
> +{
> +       volatile int i;
> +
> +       pr_err("running self test\n");
> +       /*
> +        * Test that interrupts don't produce spurious coverage.
> +        * The coverage callback filters out interrupt code, but only
> +        * after the handler updates preempt count. Some code periodically
> +        * leaks out of that section and leads to spurious coverage.
> +        * It's hard to call the actual interrupt handler directly,
> +        * so we just loop here for ~400 ms waiting for a timer interrupt.

Where do the 400 ms come from? I only see that it loops a long time,
but that the timing is entirely dependent on how fast the CPU executes
the loop.

> +        * We set kcov_mode to enable tracing, but don't setup the area,
> +        * so any attempt to trace will crash.
> +        */
> +       current->kcov_mode = KCOV_MODE_TRACE_PC;
> +       for (i = 0; i < (1 << 28); i++)
> +               ;

Can't you check jiffies, and e.g. check that actual ~100-500ms have elapsed?

timeout = jiffies + msecs_to_jiffies(300);
while (!time_after(jiffies, timeout)) {
  cpu_relax();
}

> +       current->kcov_mode = 0;
> +       pr_err("done running self test\n");
> +}
> +#endif
> +
>  static int __init kcov_init(void)
>  {
>         int cpu;
> @@ -1076,6 +1100,10 @@ static int __init kcov_init(void)
>          */
>         debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
>
> +#ifdef CONFIG_KCOV_TEST
> +       selftest();
> +#endif
> +
>         return 0;
>  }
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 59b6765d86b8..79836a15b6cb 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2171,6 +2171,15 @@ config KCOV_IRQ_AREA_SIZE
>           soft interrupts. This specifies the size of those areas in the
>           number of unsigned long words.
>
> +config KCOV_TEST

s/TEST/SELFTEST/

It may be confused with a longer standalone test.

> +       bool "Test CONFIG_KCOV feature"

Maybe "Perform short selftests on boot" (similar to CONFIG_KCSAN_SELFTEST).

> +       depends on KCOV
> +       help
> +         Sanity check for KCOV coverage collection.
> +         Runs built-in self test on boot to detect some common issues.
> +
> +         If unsure, say N.
> +
>  menuconfig RUNTIME_TESTING_MENU
>         bool "Runtime Testing"
>         default y
> --
> 2.45.1.467.gbab1589fc0-goog
>

