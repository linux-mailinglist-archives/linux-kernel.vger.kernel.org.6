Return-Path: <linux-kernel+bounces-362861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C899BA41
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E0228196F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25291474AF;
	Sun, 13 Oct 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbAtrL3B"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31E231CB0;
	Sun, 13 Oct 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728835359; cv=none; b=cbnDRef6kyTQWgMSM5y3p34bPuuuZCKuO8ZKGTSK7TSj6xXIM+9WUFPXHqCX0x5zFjyxyENM8bKA4Q/19Y/EuzHPdnpTxg+7jzcqqIBjy8m9SeiH+2lLQeOZY3iDSLiOuX1ka3igdsK/qc9MKFkDnFmR1KjUu6ojcjOcWUWaZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728835359; c=relaxed/simple;
	bh=V45V4N/QzUYyBQSdbr93pmUopgs+XHg5mrbeLKfSCPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDgBQ2vZaibxMc7/8IJk0ucehUzaHBBHT/CCIiLI7f5Q24A8OZ4fIS0i/OF0ZoAPanjffoqHwnWEl+YAImon6gv3SQ+8EmAFEQtXWfmp+vY+WCIcH7iu0uqquPfkQ/SPPeXZ+JsjcmcNIrtfZ/pDDbgn+kydBuJCM03ENsNT5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbAtrL3B; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so899380f8f.0;
        Sun, 13 Oct 2024 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728835356; x=1729440156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtZxueZi13H6/At0/KFVJVek0RE4B8mMqip4J0nMs5M=;
        b=JbAtrL3BNDtxDMyd5y5trI/lSe1dQTtUNfCOjwn0E+jbFJhTcOXCBYs0ATANZ9u16s
         aLe2b9hOVUsW5+8Ilu1EOXw1V+imvR3SGfdR87+rq+7Bz3ty9SZCGGjw88Jh8kA65+pw
         44aZNunz6dOiz4d1YtOWBj8qam3qRYL39+apNHUli+ox4BC4E4NpelVhW/aPTnD6ap/F
         aF3Q4VAoJz9+6iNbxpFkE3su1WExGR9a4QEKkh0l3EOudqathHJPwL1kx0vKw9gs2nOY
         eUKWGwqG7oEA0v/jgc9Hesx2wvB+CFNcFPXOiE1ypQW6jhJwG1FalV6upalvCzvx88lX
         ZMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728835356; x=1729440156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtZxueZi13H6/At0/KFVJVek0RE4B8mMqip4J0nMs5M=;
        b=hJHN+4Rf8Qxpsgv/44q1QGC1VlzvpULsqR9LR0/jcqT3DDLzbM8ugqIR5r4O2EQTMc
         Zo9tz7E4Uz+l6tHcEDJjKSre8Exaxc0gEKPiM6gASjJYVEDWQ9YHFNvKSsmyS2aq0O/L
         sqeq6wF9awLlchrI9oUHyYddA3ut8aXH0ZiMFCtOAT6CTVJhCQDW/vFpaNBQvCExX0XM
         kKvioxwOBAcGhM+o1hnHosgkTlzI4fy3bZkWcK2C6FPeHPTLCvGGan0pc5Ad6+ZWAnqf
         OlqCbx6enq/JYaw+gcw2i4nuiEhKaLgSadab9epZDu/X/4phGt4XnItnSrOAdT7GR6h0
         W1qA==
X-Forwarded-Encrypted: i=1; AJvYcCUEQZLZFzEJ0MjpH20UATVRvnF3f0764CalvnX2q/M27PbsFO/W7h70gzAVhrLIjXp2u5RmJ6hAqSU10j0B@vger.kernel.org, AJvYcCVSI/ZaPYL00g2T3dX3CDJ/2IfTZPcdKdTLYw7/sjfClrnRDvf3Sx9H1nSSWfRYyAGLqsus5zQ6T/+7@vger.kernel.org, AJvYcCXuLKh2N01AfUEURRdascwc3QdIfqeu7WolVili8Eu/AQDevHHSXaWl0oVcG1LDrpO7vo/bNRu6tGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+W/6MPm73u401R6P//X4nyr75msArKVDj95b8tuidO9lWGFO
	g4QO7cFsND6Tgo6XqrJhVyTUToSjY2chRsGwkLyvkJvXL5H/lZnzGAvb4y2MRulA1CttnT6nl75
	onR3NoHgNhduV1EpcSLz5guTMniI=
X-Google-Smtp-Source: AGHT+IEGwD3FDjvSsOlE0IwPOiIWB1PKck6HQr/37VKoILCE1zt5hsWeGBJiNCRcNstMehR9GGkP7NyKNIxim68N5wA=
X-Received: by 2002:a05:6000:4f0:b0:37d:5103:e41d with SMTP id
 ffacd0b85a97d-37d5529f022mr6528622f8f.39.1728835356135; Sun, 13 Oct 2024
 09:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
 <20241013130211.3067196-1-snovitoll@gmail.com> <20241013130211.3067196-3-snovitoll@gmail.com>
In-Reply-To: <20241013130211.3067196-3-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 18:02:24 +0200
Message-ID: <CA+fCnZfL2LHP7rBqCK5ZbsYu-jJ+2YbV4f0ijjDd_gQGiivNWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kasan: migrate copy_user_test to kunit
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, dvyukov@google.com, glider@google.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, elver@google.com, 
	corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn, 
	2023002089@link.tyut.edu.cn, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 3:02=E2=80=AFPM Sabyrzhan Tasbolatov
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
>  mm/kasan/Makefile            |  2 -
>  mm/kasan/kasan_test_c.c      | 39 +++++++++++++++++
>  mm/kasan/kasan_test_module.c | 81 ------------------------------------
>  3 files changed, 39 insertions(+), 83 deletions(-)
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
> index a181e4780d9..e71a16d0dfb 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -1954,6 +1954,44 @@ static void rust_uaf(struct kunit *test)
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

Here, add:

+
+       /*
+        * Prepare a long string in usermem to avoid the strncpy_from_user =
test
+        * bailing out on '\0' before it reaches out-of-bounds.
+        */
+       memset(kmem, 'a', size);
+       KUNIT_EXPECT_EQ(test, copy_to_user(usermem, kmem, size), 0);
+

This fixes the last test.


> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               unused =3D strncpy_from_user(kmem, usermem, size + 1));
> +}
> +
>  static struct kunit_case kasan_kunit_test_cases[] =3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -2028,6 +2066,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
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

