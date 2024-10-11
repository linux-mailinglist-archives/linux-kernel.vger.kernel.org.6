Return-Path: <linux-kernel+bounces-360797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BA999FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968452836DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A807020C48D;
	Fri, 11 Oct 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzZxbQQn"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D620C46C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637933; cv=none; b=kp6CArs2Bu8EssHzQBTOfWOlG3p+BEw5P87hfUP8/W2WuqicNM9HzW5Sftu/DBG/YvSEvhmlCfKOs5J1012FElkZxARDsWfGNL18XgNe6R18toPvn/ocMXyUrPr68hyr6kxK6/4SaPvtwmJzJAurTpF7DPqV9yba0qj6ClKaPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637933; c=relaxed/simple;
	bh=zoNAhQlQKyp4qyLDY6MVk4SFvB8zQsUoKwkh1MlTQaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzvMb1aNhePQMnhDrlPYE5ARhr79g21AeMl5/yYfBCDOTH2OCqIZZHutNh4kowVK/+EJvAsUMUWgP1V4YbOn4PRQ9S/Og4P9IP3cTHzY4fYQ7AAXMJ+tW0B4XeXV4AwqcS+PoXh0dxQBZolo4j3BJ54Q92ECIxnFM3qZf9iK0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzZxbQQn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso2326982a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728637930; x=1729242730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmyCPxp3PGxPiT0sfsdtuyO7wyt4DIIzCTNUesZj7zE=;
        b=UzZxbQQn493vLv+2YVxLmM/9ZlBf7BBpPGiFEXud0mI7vOGhDRYcxFWoQZOQcnQ5uj
         Ud+7+ZfDjtBvw3QaBXkRC4pQMLqurMhQq/TwQu30qIbdjxMzj/G+6uRpB5Ds58GDIxCw
         4AkaLTWfSfU27p/HtAS5h+DZY5whNKcXfLpUexHDyvuQccbs/4++aqvoaIQ66ZSaOH8c
         AtS57e3cylDCTKTL3xRKDm9X9n8cwxovcCgIVBmjYiPyhvyRpKyo6N1B491jrvESvhbl
         pTEMPmJ1Ci+oBVnadJLkTIDJBpIKClPC6qM9yL4qB7xd2P+s1lyCJcGEgBezYVUnAmPr
         tY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637930; x=1729242730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmyCPxp3PGxPiT0sfsdtuyO7wyt4DIIzCTNUesZj7zE=;
        b=vzdoZxlnno0jdVzJB0ncFjK0WfhMlT8uPYrj3iscBNQ3WZ60wOj1iwsiVaXX6K03kZ
         Ay3fkKRjZw2RQrgzsYjNQxzJMuSO73ipFLpITOIdNjuy4gAxVIwsf1dEd3mRU3yk17iQ
         XXSA6zajT96mLCd8bKMDwMn475Yw5oVLW0WDi16vKcccPPrIOvNH3HIzLbSxKi0yrdVg
         pf1hBWRHLdz6qAvNK2ttKSHwwEI30dXzD0R9J5ZwUW0XHSLc/2lttVPzbHBe5fJJOho1
         tlQyM4aBP1++m/50vMbqgvELjyQsUf8ylp3l5OqJ1TVj4H5PaSzYlJZ31aSDi2gnstkq
         DYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi9T5rMKTgiYxodgPOiMmtzgI6EJmNWE14qZluw7eWRnp2PsCnjMZRwrKIVkzesDhlbc8pI2cgkd/eVpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywce43G13CNsaUvIeSVJw5NgOtpGhgCSM8jo3XYngwb2IA0BfEY
	zYIWtS96ueszpIfq0F/gtZLgOkSztFZTnhMK+eE6y2btI5GLWfOoEKlOExi5SrBM2dCEEtDGNvL
	ekRIaPBO1/JYPrqO/8xg+tLXTATQ=
X-Google-Smtp-Source: AGHT+IG0Yn93AQOLk2HwbzKdyQ3pYfcAnV3otQB/93fZdfhLm21bUI4QJczTHMUdNmcHwu3+iAhjmuwrikTPshdYSLw=
X-Received: by 2002:a05:6402:350b:b0:5c5:cbfd:b3a8 with SMTP id
 4fb4d7f45d1cf-5c948c87a44mr1077977a12.1.1728637930115; Fri, 11 Oct 2024
 02:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011071657.3032690-1-snovitoll@gmail.com>
In-Reply-To: <20241011071657.3032690-1-snovitoll@gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Fri, 11 Oct 2024 14:13:01 +0500
Message-ID: <CACzwLxj21h7nCcS2-KA_q7ybe+5pxH0uCDwu64q_9pPsydneWQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: migrate copy_user_test to kunit
To: akpm@linux-foundation.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com
Cc: glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:16=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> Migrate the copy_user_test to the KUnit framework to verify out-of-bound
> detection via KASAN reports in copy_from_user(), copy_to_user() and
> their static functions.
>
> This is the last migrated test in kasan_test_module.c, therefore delete
> the file.
>
> In order to detect OOB access in strncpy_from_user(), we need to move
> kasan_check_write() to the function beginning to cover
> if (can_do_masked_user_access()) {...} branch as well.
>
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D212205
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  lib/strncpy_from_user.c      |  3 +-
>  mm/kasan/kasan_test_c.c      | 39 +++++++++++++++++
>  mm/kasan/kasan_test_module.c | 81 ------------------------------------
>  3 files changed, 41 insertions(+), 82 deletions(-)
>  delete mode 100644 mm/kasan/kasan_test_module.c
>
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 989a12a67872..55c33e4f3c70 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -120,6 +120,8 @@ long strncpy_from_user(char *dst, const char __user *=
src, long count)
>         if (unlikely(count <=3D 0))
>                 return 0;
>
> +       kasan_check_write(dst, count);
> +
>         if (can_do_masked_user_access()) {
>                 long retval;
>
> @@ -142,7 +144,6 @@ long strncpy_from_user(char *dst, const char __user *=
src, long count)
>                 if (max > count)
>                         max =3D count;
>
> -               kasan_check_write(dst, count);
>                 check_object_size(dst, count, false);
>                 if (user_read_access_begin(src, max)) {
>                         retval =3D do_strncpy_from_user(dst, src, count, =
max);
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index a181e4780d9d..e71a16d0dfb9 100644
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
> index 27ec22767e42..000000000000
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

This has been tested on:
- x86_64 with CONFIG_KASAN_GENERIC
- arm64 with CONFIG_KASAN_SW_TAGS
- arm64 with CONFIG_KASAN_HW_TAGS

- arm64 SW_TAGS has 1 failing test which is in the mainline,
will try to address it in different patch, not related to changes in this P=
R:
[    9.480716]     # vmalloc_percpu: EXPECTATION FAILED at
mm/kasan/kasan_test_c.c:1830
[    9.480716]     Expected (u8)(__u8)((u64)(c_ptr) >> 56) < (u8)0xFF, but
[    9.480716]         (u8)(__u8)((u64)(c_ptr) >> 56) =3D=3D 255 (0xff)
[    9.480716]         (u8)0xFF =3D=3D 255 (0xff)
[    9.481936]     # vmalloc_percpu: EXPECTATION FAILED at
mm/kasan/kasan_test_c.c:1830
[    9.481936]     Expected (u8)(__u8)((u64)(c_ptr) >> 56) < (u8)0xFF, but
[    9.481936]         (u8)(__u8)((u64)(c_ptr) >> 56) =3D=3D 255 (0xff)
[    9.481936]         (u8)0xFF =3D=3D 255 (0xff)

Here is my full console log of arm64-sw.log:
https://gist.githubusercontent.com/novitoll/7ab93edca1f7d71925735075e84fc2e=
c/raw/6ef05758bcc396cd2f5796a5bcb5e41a091224cf/arm64-sw.log

- arm64 HW_TAGS has 1 failing test related to new changes
and AFAIU, it's known issue related to HW_TAGS:

[ 11.167324] # copy_user_test_oob: EXPECTATION FAILED at
mm/kasan/kasan_test_c.c:1992
[ 11.167324] KASAN failure expected in "unused =3D
strncpy_from_user(kmem, usermem, size + 1)", but none occurred

Here is the console log of arm64-hw.log:
https://gist.github.com/novitoll/7ab93edca1f7d71925735075e84fc2ec#file-arm6=
4-hw-log-L11208

