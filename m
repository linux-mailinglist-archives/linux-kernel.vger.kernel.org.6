Return-Path: <linux-kernel+bounces-362640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A483F99B788
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202A31F21EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991E514F102;
	Sat, 12 Oct 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2YkF9ws"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037079B8E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728773190; cv=none; b=g6zsaMahFi3Fkjinn+YjtbZGQ2Om3Gkf5tzDCcK211PbScgTy5NzH9NTtqQxIGCjj7UuMBidePiBCQAPxTV8hBr3JBI4rWzYrbtxnEpoGTE3e0o4sBsq0cmxZL2hUu0iYP06smPyemiKaLiTbeGr2ZnWi3fqlrSAFSLBn+/2Fik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728773190; c=relaxed/simple;
	bh=kyRvRNB2QcMxgJ2NMSTOtLIP32wk56QeHyflBQ5vHKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DR/yP7rI6FEprc3XR5bmksw7cdXn1nKFyTESaShYKfplNQ0TxzEtelcMc0HDvMiNR/ibRfep1qIY6mQlrZ3xNGOQr6XyhtetpqHxH2FUTD8SbUxVcgEaMyJdXO3VRhHuDFkIWbNyn3Uc5FqMlz2OGcLSxs6qhj1gtIsHVKR26B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2YkF9ws; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43117917eb9so26110375e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728773186; x=1729377986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/aqTd2ota1+xNkB76pwMkxv208Q7EfGMyB/sMwBaR8=;
        b=Q2YkF9wsEXZVNVBatfTg01NoU93NGclxnA/nw6rijow6TJA/LdFq2bHz5iClr9Tuzn
         emZzP3nAxZtvTtpFg6GnyyIzISLqcxcqaM2H7BAVrmB1uL+3oA5gPx23pDe+EAi77VhJ
         PAVoghFnmh0ihIhmEPuetbFtuuP08c27N+5Z22AQr8yO9tykeK2To/haM6oRr+GaOCkf
         MnZCHAbklBnZ584ikJagh2aVl9WSSXUQ9UZHexQXb4I2hGNZJFUrn4nvh8CJoebpUHJW
         I8Ppk1md4vxsOGQMP4sQOq7L//9mI3UuYjz/7JESQ1IG2IsY8JRmiRccoLBZpwtrPrAh
         JndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728773186; x=1729377986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/aqTd2ota1+xNkB76pwMkxv208Q7EfGMyB/sMwBaR8=;
        b=X0RbOZkgfGhgy42OWoaGambBQl+giSy4+eG0ilR4I6k2UI5yHYRZzVy2BRK8HJjnsK
         cjbBWH/xlsN+M/6UHJW70v6wdlnKTmswFUXOznvoaKsamGPMsRh4x5fWSLehrP36mJqq
         cQRIgxyK7uW1kJziEoDabXjvr+I7nhMQHBtt7S/gvILXar6OUycX9x0Br6S0m4J3n36f
         HtnRTDHzSNdM2xS2PhUOWEld3UuW+g1uslcInO0gaWY/XLcieE5A67o5gjQk9LN7ucVH
         /yfrjL5oaRjIti/AC3CFGH5hyuOEf/HadrCA58cHiNtzRClbzSwn8nUHZTEUQiY04+GP
         jCbw==
X-Forwarded-Encrypted: i=1; AJvYcCWzq1/OSpFUGz3QhQ0OYGCjru5uJDzHaevnlZkpbyhJuN7HOwEmQfxwwO9qhL+UW180m8vVHPMM1m/Ybdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLswsxaiitSjOYcEH9mjJopoVPrKU61P0UoKtNqVU2tq1Vd6oH
	ndv0866NcL7/IF2a0Ezp9jIrclr7fdHlb2/LrPC4k/iST9mVOvjLBafyjT9ngxbVAMSkCTViNXP
	tVws2D7l6U5/tOF+ZZKDfLqjrf8Q=
X-Google-Smtp-Source: AGHT+IFQDhsjoczFd/HucVui8g/n7We+1fcmDmWmgWcowZra5er+x4uBhnF+NUqnwkjOSaJepHJ/ID6CosAmrKJzyow=
X-Received: by 2002:a05:600c:3589:b0:42c:b55f:f7c with SMTP id
 5b1f17b1804b1-4311dee58dfmr52756185e9.15.1728773186082; Sat, 12 Oct 2024
 15:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011071657.3032690-1-snovitoll@gmail.com>
In-Reply-To: <20241011071657.3032690-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 00:46:15 +0200
Message-ID: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: migrate copy_user_test to kunit
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:16=E2=80=AFAM Sabyrzhan Tasbolatov
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

I think we better put both kasan_check_write and check_object_size
into do_strncpy_from_user, as the latter is now (post 2865baf54077)
called from two different places.

Also, please put this change into a separate commit with a Fixes:
2865baf54077 tag.

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

Please also remove the corresponding entries from mm/kasan/Makefile
and lib/Kconfig.kasan and update Documentation/dev-tools/kasan.rst.


> --
> 2.34.1
>

