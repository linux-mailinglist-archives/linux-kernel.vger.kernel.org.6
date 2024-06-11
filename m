Return-Path: <linux-kernel+bounces-209564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20AE9037C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA11EB21C85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91D176ACD;
	Tue, 11 Jun 2024 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tURrsmZA"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA316F8F0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098196; cv=none; b=MzBIhZOcIfiwNxILq9iYAT1eqggsBPPRvjJmittMoi/Q1Ea0OO0JMtr5N9l6YJe5gyvdZrxt6faL6Xj5qL4mKFXppXJo2gxxppfSM5JY4tIcTWIehfsoMl69vUwwGqFGZiRs9V4O1fSxtnUo/k13s9jSqo11boidp+5DzYPswYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098196; c=relaxed/simple;
	bh=3Aoz75UnNeUnvxc1QOtRosq9IqKP7sN+gEDcX5YvvgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=in6d8CbvJuIlvIFt6kNxg5zEwSlQCDcZdSzEYk/iyqtBtnXm9h8XgnPWJ+g5CLGDi6jzrkVB4F4bOwOmKwU8uyvcjqSLVTo5866PzyRJb4Ykqmsdmczh835fM39iZF2TfRIvqoIjErKrbhRFrjPEUjlXWlOddJJPuQFGsmO+3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tURrsmZA; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80acfd81899so248457241.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718098194; x=1718702994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rt7Mipe8sWYGdIRzG0MkGoo+3Z/PRr0+fx5ZM1nCaw=;
        b=tURrsmZAWpKl1eZ+fV2RRmBzCEipcNwupSyOgTb7T3KOgWh1Jdp2VH/CnLC/Hr1oWd
         jWnPe33+SdptdeqqkebyAe9EqXq+jm8nRqQhscdoxwh4YgCzYJO/H7jHatmCxoBSBX3L
         1WI244myU+BrLnvquRqeYtdoHTTNJZm8hJO0MCq3GInu2Qjd/E+6+Ll0O2c0zkIQBAQZ
         PXDOz6kGnKfqORa3YjktjpFyYey49nxMZoS7tCSs5AEQZ+bi2oVjaeeZYbr4uzDQzcQT
         ZtkbjFapLBkCWWgKbpENFMUKWgyyuc/Vmr7sCLuoV6MffsCd+H2dCANaFAoFq/zf4Pha
         ffSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098194; x=1718702994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rt7Mipe8sWYGdIRzG0MkGoo+3Z/PRr0+fx5ZM1nCaw=;
        b=W4NiCIRh/wzeRXF3DBlaR/moILemxdCjRGzbY601XUsXWTjza8vvXcgp4smS/JBGyI
         VfZxsYA2dMgQoRmJo20Df+VXvieYR6Fa1DzVCxpT6j6uCm+NhH11ZvIMNiwsbBjggCpm
         TPbI53owBvdLjLivXIBUihHKe/3CKpaaoRjUHDYGye7Qjuru70EgSMmwC6dwos0KbI2z
         i2unqXvEDLvIRp7W6EE88aNp/Op96zDlrqbxCCQOBGCL91FBb79Jjfv6nZ7+GUd5A44Y
         xUGUGOqz42EdQ95gv9PkVid23xzjrbb2l+GNdmC20jciLzrP1Khh17V6VtIRYI/aIkRQ
         PwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy6kgNDermsAL58Bp7fmWy/BYzzWRO18DYWM/uBIFL+iXTZaVHKvDFxrkxHUI9Dqk0aN9InxG62mnyl/A0YFGe5VBP8YPK+/XlO/BN
X-Gm-Message-State: AOJu0Yw9PmXia2QOh86c2cB9eWlh1n32uKXb8x9nuNPhTc6fyjsUfxre
	qF/rUziEkfOSzaC/BySsbCpcbi7nLINrqSxkb02EmqWcpwwMBEozhh1fLKx6AU/AEBrmxMAkAJV
	Zs/BQPBaY3yaFGKyzTwd4/Q6uWDirp5eOCKkz
X-Google-Smtp-Source: AGHT+IFk2bf8NLM/Xp+BnEG73lHRwaU4NnL3zsrDQI8eIqEJLKxiVVxHVVEgxlseTLFTYxDEE5Ml744TLJd+OgpGFqA=
X-Received: by 2002:a05:6102:2373:b0:48c:3ed0:fc1f with SMTP id
 ada2fe7eead31-48c3ed0fe39mr7197711137.19.1718098194047; Tue, 11 Jun 2024
 02:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
In-Reply-To: <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
From: Marco Elver <elver@google.com>
Date: Tue, 11 Jun 2024 11:29:16 +0200
Message-ID: <CANpmjNPhpd45cmQ98WK+RAtsPhxa1cCSnasZ293Q5eYV8dt7eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kcov: add interrupt handling self test
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, glider@google.com, nogikh@google.com, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 09:50, Dmitry Vyukov <dvyukov@google.com> wrote:
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
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com

Reviewed-by: Marco Elver <elver@google.com>

> ---
>
> Changed since v1:
>  - renamed KCOV_TEST to KCOV_SELFTEST
>  - improved the config description
>  - loop for exactly 300ms in the test
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
>  kernel/kcov.c     | 31 +++++++++++++++++++++++++++++++
>  lib/Kconfig.debug |  8 ++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index c3124f6d5536..72a5bf55107f 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/hashtable.h>
>  #include <linux/init.h>
> +#include <linux/jiffies.h>
>  #include <linux/kmsan-checks.h>
>  #include <linux/mm.h>
>  #include <linux/preempt.h>
> @@ -1057,6 +1058,32 @@ u64 kcov_common_handle(void)
>  }
>  EXPORT_SYMBOL(kcov_common_handle);
>
> +#ifdef CONFIG_KCOV_SELFTEST
> +static void __init selftest(void)
> +{
> +       unsigned long start;
> +
> +       pr_err("running self test\n");
> +       /*
> +        * Test that interrupts don't produce spurious coverage.
> +        * The coverage callback filters out interrupt code, but only
> +        * after the handler updates preempt count. Some code periodically
> +        * leaks out of that section and leads to spurious coverage.
> +        * It's hard to call the actual interrupt handler directly,
> +        * so we just loop here for a bit waiting for a timer interrupt.
> +        * We set kcov_mode to enable tracing, but don't setup the area,
> +        * so any attempt to trace will crash. Note: we must not call any
> +        * potentially traced functions in this region.
> +        */
> +       start = jiffies;
> +       current->kcov_mode = KCOV_MODE_TRACE_PC;
> +       while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
> +               ;
> +       current->kcov_mode = 0;
> +       pr_err("done running self test\n");
> +}
> +#endif
> +
>  static int __init kcov_init(void)
>  {
>         int cpu;
> @@ -1076,6 +1103,10 @@ static int __init kcov_init(void)
>          */
>         debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
>
> +#ifdef CONFIG_KCOV_SELFTEST
> +       selftest();
> +#endif
> +
>         return 0;
>  }
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 59b6765d86b8..695a437a52d9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2171,6 +2171,14 @@ config KCOV_IRQ_AREA_SIZE
>           soft interrupts. This specifies the size of those areas in the
>           number of unsigned long words.
>
> +config KCOV_SELFTEST
> +       bool "Perform short selftests on boot"
> +       depends on KCOV
> +       help
> +         Run short KCOV coverage collection selftests on boot.
> +         On test failure, causes the kernel to panic. Recommended to be
> +         enabled, ensuring critical functionality works as intended.
> +
>  menuconfig RUNTIME_TESTING_MENU
>         bool "Runtime Testing"
>         default y
> --
> 2.45.2.505.gda0bf45e8d-goog
>

