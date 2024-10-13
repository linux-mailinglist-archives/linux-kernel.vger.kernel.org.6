Return-Path: <linux-kernel+bounces-362950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0E99BBA5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD35C1F215D5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4314A619;
	Sun, 13 Oct 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISvtbXNz"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10737F48C;
	Sun, 13 Oct 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851152; cv=none; b=fgdTWVKqq3MqRwL8rYDPPxTUhgxA89EGO8YEAMLXYVy4gOa6cdp5Dipeza3H0DaO2Mn6pSyxVEslK6NoDzRhh8i8i3zC9pELB9M1suwlEIAmo3LY0hBaQH8vqjP9yxnaQkkv6fJ1YNCMrovepahELhsq3BIV+9AUdLrP+RkjD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851152; c=relaxed/simple;
	bh=oLcbHOWTR+AMbqOHSLKd41Mc+wHeXem3FC6YWNH1cgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZTvXHjaHVgYFGyY3dsjFabyHx7lPke9jQNzHVYSZ5uErZf3bjsbgKnVqPReyx7U2NeDJ47dNKr0U8zSY1yFNKriuy6og3FOFYYHpTnoS/glq6S1fmkTV9PVvdg132GM+ohcuhU8zU95ehOR3kA3zP3qAIrB91t6aTG1E76yc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISvtbXNz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so1867358f8f.2;
        Sun, 13 Oct 2024 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728851149; x=1729455949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5zRtO73AocajQx7Xa+tWyH6u9NWSUZX7hX+fOXXues=;
        b=ISvtbXNzwNKFWHVmVApE2wCKXbu7Zeifgq8aFC4Ke/x+4ckNEOn7fizD3Ga6Qaah5u
         pCpKH+rGh2KQSKUNTUVT+cDZU6sE5kS3PQvmyCtI+OY8dIhZs2dwopVvv8e36PIZ9/lp
         Br66VL7mnlMSk5pqqhqS/LwI7ACvyscs3/efAFcncMDch34c8EP6RYXOr+8rB0Qjfe0h
         VKzfmecTYa0m9LqrUN04lukJJuUpBbQPEiH+Yd5yn2ZMpXTMd+Zxp/xME0nIoziU2jdK
         6NqMVAe9jkLjNs/n7+nlIbdh6D0GPrKqfkdK6ea+drENTBxLGNCxiE94IbjtMIjWXMOn
         RuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728851149; x=1729455949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5zRtO73AocajQx7Xa+tWyH6u9NWSUZX7hX+fOXXues=;
        b=CP+rQZXBbClMP0w42JVbaG3Tf4E+Ts8U5PejvWRRitNHtZjiB1B1If0YNaHhGNGcsQ
         Jb6/lbCSK3/53x7ALtAp5Xlgq0PDQcCcs3qE1mswLiC9UV+7jm7u7eQoXT/2hMepJXW/
         U3ojIXVQNX3z8opoH/GpJ7dCGMh4ftHoJ3tt7MGlurZrHOr257H/2Le/Z9gtclACLguw
         02mcdac4I88kwi2g/UNmSZjKKp/+KAbZS48NkcTimuXKy4M/ELHMdEn6zLlu1lQYCnPy
         +V6ELt4A+xea1AhnnzPNxYiGihjvQyVr5mCfvD9r0utUq2GPxurvqZe67y7ugh1ALce6
         zvhA==
X-Forwarded-Encrypted: i=1; AJvYcCUb/fhxRwpYG/9RSlOEWqfiQMel6cwYc6N6Pg3stpIUFNSbd7g9FRmGypH08UYyjs2ketZFozB1ajo=@vger.kernel.org, AJvYcCVa9j2mdUM3oeaKuWHuXZGmVezs6KpDOyCZPgepWmY6q9EzpWaVkQUMcTZnBIjj8rTDaXaKHj6Knchpa624@vger.kernel.org, AJvYcCXiS8JZ2P/4iqW2YcDr8ZhdqTAtzXtvMKwnwNVUN7nb+BhDeDfHLP0GTIqVi44m1BwJLl3uUSy2qVD6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5GFS429IJEpYHGZzyNJ+Ys+4mQuy5JcHbz8YD4qTQgw2PpzQ
	KuTV31x5onEWPg1HxkHEpJnrLJwvZ5+l9qDKWKwmOpPx84Wu3/dJqnSTabdPlttEk9LNz+Cup7R
	fX9nZmJbNkTcGos4u/qj6lDSgUyU=
X-Google-Smtp-Source: AGHT+IEjZMjl50s/lfMm6uwfkL1WmKWSGOg222nFhzF18Y0Ijdn+/ZeiBOf5r4n2hq3PNHRlc/xh9hik8x6HqBx/5Rc=
X-Received: by 2002:adf:b351:0:b0:37d:354e:946a with SMTP id
 ffacd0b85a97d-37d552d8d62mr6067449f8f.50.1728851148978; Sun, 13 Oct 2024
 13:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZfL2LHP7rBqCK5ZbsYu-jJ+2YbV4f0ijjDd_gQGiivNWg@mail.gmail.com>
 <20241013182016.3074875-1-snovitoll@gmail.com>
In-Reply-To: <20241013182016.3074875-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 22:25:37 +0200
Message-ID: <CA+fCnZcyrGf5TBdkaG4M+r9ViKDwdCHZg12HUeeoTV3UNZnwBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kasan: migrate copy_user_test to kunit
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: 2023002089@link.tyut.edu.cn, akpm@linux-foundation.org, alexs@kernel.org, 
	corbet@lwn.net, dvyukov@google.com, elver@google.com, glider@google.com, 
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	siyanteng@loongson.cn, vincenzo.frascino@arm.com, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 8:19=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> Migrate the copy_user_test to the KUnit framework to verify out-of-bound
> detection via KASAN reports in copy_from_user(), copy_to_user() and
> their static functions.
>
> This is the last migrated test in kasan_test_module.c, therefore delete
> the file.
>
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes v2 -> v3:
> - added a long string in usermem for strncpy_from_user. Suggested by Andr=
ey.
> ---
>  mm/kasan/Makefile            |  2 -
>  mm/kasan/kasan_test_c.c      | 47 +++++++++++++++++++++
>  mm/kasan/kasan_test_module.c | 81 ------------------------------------
>  3 files changed, 47 insertions(+), 83 deletions(-)
>  delete mode 100644 mm/kasan/kasan_test_module.c
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index b88543e5c0c..1a958e7c8a4 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -46,7 +46,6 @@ endif
>
>  CFLAGS_kasan_test_c.o :=3D $(CFLAGS_KASAN_TEST)
>  RUSTFLAGS_kasan_test_rust.o :=3D $(RUSTFLAGS_KASAN)
> -CFLAGS_kasan_test_module.o :=3D $(CFLAGS_KASAN_TEST)
>
>  obj-y :=3D common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) +=3D init.o generic.o report_generic.o shado=
w.o quarantine.o
> @@ -59,4 +58,3 @@ ifdef CONFIG_RUST
>  endif
>
>  obj-$(CONFIG_KASAN_KUNIT_TEST) +=3D kasan_test.o
> -obj-$(CONFIG_KASAN_MODULE_TEST) +=3D kasan_test_module.o
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9..382bc64e42d 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1954,6 +1954,52 @@ static void rust_uaf(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, kasan_test_rust_uaf());
>  }
>
> +static void copy_user_test_oob(struct kunit *test)
> +{
> +       char *kmem;
> +       char __user *usermem;
> +       unsigned long useraddr;
> +       size_t size =3D 128 - KASAN_GRANULE_SIZE;
> +       int __maybe_unused unused;
> +
> +       kmem =3D kunit_kmalloc(test, size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kmem);
> +
> +       useraddr =3D kunit_vm_mmap(test, NULL, 0, PAGE_SIZE,
> +                                       PROT_READ | PROT_WRITE | PROT_EXE=
C,
> +                                       MAP_ANONYMOUS | MAP_PRIVATE, 0);
> +       KUNIT_ASSERT_NE_MSG(test, useraddr, 0,
> +               "Could not create userspace mm");
> +       KUNIT_ASSERT_LT_MSG(test, useraddr, (unsigned long)TASK_SIZE,
> +               "Failed to allocate user memory");
> +
> +       OPTIMIZER_HIDE_VAR(size);
> +       usermem =3D (char __user *)useraddr;
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               unused =3D copy_from_user(kmem, usermem, size + 1));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               unused =3D copy_to_user(usermem, kmem, size + 1));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               unused =3D __copy_from_user(kmem, usermem, size + 1));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               unused =3D __copy_to_user(usermem, kmem, size + 1));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               unused =3D __copy_from_user_inatomic(kmem, usermem, size =
+ 1));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               unused =3D __copy_to_user_inatomic(usermem, kmem, size + =
1));
> +
> +       /*
> +       * Prepare a long string in usermem to avoid the strncpy_from_user=
 test
> +       * bailing out on '\0' before it reaches out-of-bounds.
> +       */
> +       memset(kmem, 'a', size);
> +       KUNIT_EXPECT_EQ(test, copy_to_user(usermem, kmem, size), 0);
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               unused =3D strncpy_from_user(kmem, usermem, size + 1));
> +}
> +
>  static struct kunit_case kasan_kunit_test_cases[] =3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -2028,6 +2074,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(match_all_ptr_tag),
>         KUNIT_CASE(match_all_mem_tag),
>         KUNIT_CASE(rust_uaf),
> +       KUNIT_CASE(copy_user_test_oob),
>         {}
>  };
>
> diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
> deleted file mode 100644
> index 27ec22767e4..00000000000
> --- a/mm/kasan/kasan_test_module.c
> +++ /dev/null
> @@ -1,81 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *
> - * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> - * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
> - */
> -
> -#define pr_fmt(fmt) "kasan: test: " fmt
> -
> -#include <linux/mman.h>
> -#include <linux/module.h>
> -#include <linux/printk.h>
> -#include <linux/slab.h>
> -#include <linux/uaccess.h>
> -
> -#include "kasan.h"
> -
> -static noinline void __init copy_user_test(void)
> -{
> -       char *kmem;
> -       char __user *usermem;
> -       size_t size =3D 128 - KASAN_GRANULE_SIZE;
> -       int __maybe_unused unused;
> -
> -       kmem =3D kmalloc(size, GFP_KERNEL);
> -       if (!kmem)
> -               return;
> -
> -       usermem =3D (char __user *)vm_mmap(NULL, 0, PAGE_SIZE,
> -                           PROT_READ | PROT_WRITE | PROT_EXEC,
> -                           MAP_ANONYMOUS | MAP_PRIVATE, 0);
> -       if (IS_ERR(usermem)) {
> -               pr_err("Failed to allocate user memory\n");
> -               kfree(kmem);
> -               return;
> -       }
> -
> -       OPTIMIZER_HIDE_VAR(size);
> -
> -       pr_info("out-of-bounds in copy_from_user()\n");
> -       unused =3D copy_from_user(kmem, usermem, size + 1);
> -
> -       pr_info("out-of-bounds in copy_to_user()\n");
> -       unused =3D copy_to_user(usermem, kmem, size + 1);
> -
> -       pr_info("out-of-bounds in __copy_from_user()\n");
> -       unused =3D __copy_from_user(kmem, usermem, size + 1);
> -
> -       pr_info("out-of-bounds in __copy_to_user()\n");
> -       unused =3D __copy_to_user(usermem, kmem, size + 1);
> -
> -       pr_info("out-of-bounds in __copy_from_user_inatomic()\n");
> -       unused =3D __copy_from_user_inatomic(kmem, usermem, size + 1);
> -
> -       pr_info("out-of-bounds in __copy_to_user_inatomic()\n");
> -       unused =3D __copy_to_user_inatomic(usermem, kmem, size + 1);
> -
> -       pr_info("out-of-bounds in strncpy_from_user()\n");
> -       unused =3D strncpy_from_user(kmem, usermem, size + 1);
> -
> -       vm_munmap((unsigned long)usermem, PAGE_SIZE);
> -       kfree(kmem);
> -}
> -
> -static int __init kasan_test_module_init(void)
> -{
> -       /*
> -        * Temporarily enable multi-shot mode. Otherwise, KASAN would onl=
y
> -        * report the first detected bug and panic the kernel if panic_on=
_warn
> -        * is enabled.
> -        */
> -       bool multishot =3D kasan_save_enable_multi_shot();
> -
> -       copy_user_test();
> -
> -       kasan_restore_multi_shot(multishot);
> -       return -EAGAIN;
> -}
> -
> -module_init(kasan_test_module_init);
> -MODULE_LICENSE("GPL");
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

However, I didn't get a cover letter for v3.

Normally, when sending a new version of a patch series, you need to
resend all patches with the new version tag (even if not all of them
were changed).

Since you didn't resend them all, as it seems, at this point, I would
recommend to resend the whole v3 series tagged as [PATCH RESEND v3].

Thank you!

