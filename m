Return-Path: <linux-kernel+bounces-206955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D38901086
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666A11C2161B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894BE556;
	Sat,  8 Jun 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciINLWv0"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FCC8D7
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836268; cv=none; b=s8MNW2Ngk971HTl0THO8HRy3QLRFxZgd4orqG0u3BQ7zq4zNRY6SFc5vBJTPl15dki39vq5vOmk00fw+ryN0IA2HSt/8tGXve8GfeJuyTZ8zlsqMkBBix4FGtJpFvGpdaa+wc1bLv/JmEhbk8viaiWbt9OyiZXiMspB9NDIYtTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836268; c=relaxed/simple;
	bh=wbvf3XBokP62Xf50gJbhepOeWe0gJnB8WdGvmFfS4Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFHXjsMjPBOEaKLM8t2wmLzv241xdJL915Q7WEX5Kcje3/C4GZ3syG1j2nuTeQler6aMbHytZQ3kIHwrODnUSWumTIdUFeinnfB7/aLn4C/Yx6gPpefuo1NIpS6digo8hblehYUlsHXwWS0vHyqELfb6VPpsohveDNFVC4g4NS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciINLWv0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4400cc0dad1so210241cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717836265; x=1718441065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJr2L1ue9+6d/s/gUQv1Enlai/mYe2gTRMUTyoq3j34=;
        b=ciINLWv0xNhHrEUbwxtLF4o1AnXKCL3Vr9t+/Yb3d4RXYm+0Qv3RgS2LalxW3Q0z+1
         00d6f1ZKCAaCY+pQXfVGR9JkwyrogsB3Xz/csDiPn44OD0CGf25k8a0Tqfp8R/qyDdTx
         zgC37lg9nIvOs5/8AOVlBO/QnvlrAI8VtO2v/nsNnhWcd7Ch+ufkBN6zpFbKbPmXqh5I
         byDFP+NhYhAmMoOJTQunblsZKzEsrYjL+6AQ+L+JmyKv0NXnwOgyAfcnyxIobt9qVW58
         LVjeuF5ypJIYFnAegqpehRoCeUUX2cQBP++r9Nlh1m6vc4Fn5a6TNeKtBp5253ej1zzg
         lNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717836265; x=1718441065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJr2L1ue9+6d/s/gUQv1Enlai/mYe2gTRMUTyoq3j34=;
        b=WyWZthTUwjTbDGJaBWhNqQN6lzYr7afuHt1t8UXg72oKbFPudFjcZel6NpFFQAaBhP
         z8deuEwUOAuELHSCO8XzlfwlS3+QpZNQD05TQP9vEUN49h+wgu4cFxVluwEyXElmp/OL
         ygkMOIoINgHZ57nld7xfh0uHSzACUiIyDgUD8HHI4xEgY5F5ikKp/sJDOBONh23mweeZ
         0MvezFGn5PkvI7deH2FGN5ZsTzdTIt5HaoBOLJO3fsz0lyuPimTant+qlw5NCTDv7E4d
         zr6s+U21zwGr9cJ3WbUove5iRwuSeYOP+DKXXT6OfBHc+D9cWTCoxRKOvv1WRN5uNk+c
         WfLA==
X-Forwarded-Encrypted: i=1; AJvYcCVtdi3QK+/8+W+FRrbeXcqKY4aobBmJWHNNoKtV0XqQHwJ9C81ii4ERiKuJ/L7NFrkA2gUtObDIrsCFJcuTVIEFiPMfCY4nqre4r2Iv
X-Gm-Message-State: AOJu0YzwC7qjhFjFhu8NGCaGnTSq4QrEWqKeplSoBeX+6gV6vanwMEgY
	ViUrF+E+itNp6bPkkFp8S72lkK/HETUoNPG49bqEH9N3cJk2m3Z3caCjuPUavThLqK6Drl6T/yv
	qAJ3yM8t8dzXEjPbRRvHIKBttmkMV3i+kevd9
X-Google-Smtp-Source: AGHT+IEP3cC5zqT/z4cA3/sDtFbndSgH1prfptNjeNo7+jeKnJQ4TFpH5ps4HYyErrArWJJTYGJtZY7d7YqfNdrjRak=
X-Received: by 2002:a05:622a:59c8:b0:43f:fc3d:8c27 with SMTP id
 d75a77b69052e-44057c2b2f2mr1102241cf.23.1717836264499; Sat, 08 Jun 2024
 01:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519190422.work.715-kees@kernel.org> <20240519191254.651865-2-keescook@chromium.org>
In-Reply-To: <20240519191254.651865-2-keescook@chromium.org>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Jun 2024 16:44:10 +0800
Message-ID: <CABVgOSn=tb=Lj9SxHuT4_9MTjjKVxsq-ikdXC4kGHO4CfKVmGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usercopy: Convert test_user_copy to KUnit test
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vitor Massaru Iha <vitor@massaru.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005ec7df061a5cec6c"

--0000000000005ec7df061a5cec6c
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 03:12, Kees Cook <keescook@chromium.org> wrote:
>
> Convert the runtime tests of hardened usercopy to standard KUnit tests.
>
> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

This fails here on i386:
>      # usercopy_test_invalid: EXPECTATION FAILED at lib/usercopy_kunit.c:278
>      Expected val_u64 == 0, but
>          val_u64 == -60129542144 (0xfffffff200000000)

It also seems to be hanging somewhere in usercopy_test_invalid on my
m68k/qemu setup:
./tools/testing/kunit/kunit.py run --build_dir=.kunit-m68k --arch m68k usercopy

Otherwise, it looks fine. Maybe it'd make sense to split some of the
tests up a bit more, but it's a matter of taste (and only really an
advantage for debugging hangs where more detailed progress is nice).

With those architecture-specific hangs either fixed, or documented (if
they're actual problems, not issues with the test), this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  MAINTAINERS                                |   1 +
>  lib/Kconfig.debug                          |  21 +-
>  lib/Makefile                               |   2 +-
>  lib/{test_user_copy.c => usercopy_kunit.c} | 252 ++++++++++-----------
>  4 files changed, 133 insertions(+), 143 deletions(-)
>  rename lib/{test_user_copy.c => usercopy_kunit.c} (52%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c121493f43d..73995b807e5a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11761,6 +11761,7 @@ F:      arch/*/configs/hardening.config
>  F:     include/linux/overflow.h
>  F:     include/linux/randomize_kstack.h
>  F:     kernel/configs/hardening.config
> +F:     lib/usercopy_kunit.c
>  F:     mm/usercopy.c
>  K:     \b(add|choose)_random_kstack_offset\b
>  K:     \b__check_(object_size|heap_object)\b
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c63a5fbf1f1c..fd974480aa45 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2460,18 +2460,6 @@ config TEST_VMALLOC
>
>           If unsure, say N.
>
> -config TEST_USER_COPY
> -       tristate "Test user/kernel boundary protections"
> -       depends on m
> -       help
> -         This builds the "test_user_copy" module that runs sanity checks
> -         on the copy_to/from_user infrastructure, making sure basic
> -         user/kernel boundary testing is working. If it fails to load,
> -         a regression has been detected in the user/kernel memory boundary
> -         protections.
> -
> -         If unsure, say N.
> -
>  config TEST_BPF
>         tristate "Test BPF filter functionality"
>         depends on m && NET
> @@ -2779,6 +2767,15 @@ config SIPHASH_KUNIT_TEST
>           This is intended to help people writing architecture-specific
>           optimized versions.  If unsure, say N.
>
> +config USERCOPY_KUNIT_TEST
> +       tristate "KUnit Test for user/kernel boundary protections"
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the "usercopy_kunit" module that runs sanity checks
> +         on the copy_to/from_user infrastructure, making sure basic
> +         user/kernel boundary testing is working.
> +

FYI: Checkpatch is whinging that this help text isn't detailed enough.
(I'm not sure what else you could add, though...)


>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index ffc6b2341b45..6287bd6be5d7 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -78,7 +78,6 @@ obj-$(CONFIG_TEST_LKM) += test_module.o
>  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
>  obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
>  obj-$(CONFIG_TEST_SORT) += test_sort.o
> -obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
>  obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
>  obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
> @@ -406,6 +405,7 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
>  obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
>  obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
>  obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
> +obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>
> diff --git a/lib/test_user_copy.c b/lib/usercopy_kunit.c
> similarity index 52%
> rename from lib/test_user_copy.c
> rename to lib/usercopy_kunit.c
> index 5ff04d8fe971..515df08b3190 100644
> --- a/lib/test_user_copy.c
> +++ b/lib/usercopy_kunit.c
> @@ -15,7 +15,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> -#include <linux/vmalloc.h>
> +#include <kunit/test.h>
>
>  /*
>   * Several 32-bit architectures support 64-bit {get,put}_user() calls.
> @@ -31,11 +31,17 @@
>  # define TEST_U64
>  #endif
>
> +struct usercopy_test_priv {
> +       char *kmem;
> +       char __user *umem;
> +       size_t size;
> +};
> +
>  #define test(condition, msg, ...)                                      \
>  ({                                                                     \
>         int cond = (condition);                                         \
>         if (cond)                                                       \
> -               pr_warn("[%d] " msg "\n", __LINE__, ##__VA_ARGS__);     \
> +               KUNIT_EXPECT_FALSE_MSG(test, cond, msg, ##__VA_ARGS__); \
>         cond;                                                           \
>  })
>
> @@ -44,13 +50,16 @@ static bool is_zeroed(void *from, size_t size)
>         return memchr_inv(from, 0x0, size) == NULL;
>  }
>
> -static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
> +/* Test usage of check_nonzero_user(). */
> +static void usercopy_test_check_nonzero_user(struct kunit *test)
>  {
> -       int ret = 0;
>         size_t start, end, i, zero_start, zero_end;
> +       struct usercopy_test_priv *priv = test->priv;
> +       char __user *umem = priv->umem;
> +       char *kmem = priv->kmem;
> +       size_t size = priv->size;
>
> -       if (test(size < 2 * PAGE_SIZE, "buffer too small"))
> -               return -EINVAL;
> +       KUNIT_ASSERT_GE_MSG(test, size, 2 * PAGE_SIZE, "buffer too small");
>
>         /*
>          * We want to cross a page boundary to exercise the code more
> @@ -84,8 +93,8 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
>         for (i = zero_end; i < size; i += 2)
>                 kmem[i] = 0xff;
>
> -       ret |= test(copy_to_user(umem, kmem, size),
> -                   "legitimate copy_to_user failed");
> +       KUNIT_EXPECT_EQ_MSG(test, copy_to_user(umem, kmem, size), 0,
> +               "legitimate copy_to_user failed");
>
>         for (start = 0; start <= size; start++) {
>                 for (end = start; end <= size; end++) {
> @@ -93,35 +102,32 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
>                         int retval = check_zeroed_user(umem + start, len);
>                         int expected = is_zeroed(kmem + start, len);
>
> -                       ret |= test(retval != expected,
> -                                   "check_nonzero_user(=%d) != memchr_inv(=%d) mismatch (start=%zu, end=%zu)",
> -                                   retval, expected, start, end);
> +                       KUNIT_EXPECT_EQ_MSG(test, retval, expected,
> +                               "check_nonzero_user(=%d) != memchr_inv(=%d) mismatch (start=%zu, end=%zu)",
> +                               retval, expected, start, end);
>                 }
>         }
> -
> -       return ret;
>  }
>
> -static int test_copy_struct_from_user(char *kmem, char __user *umem,
> -                                     size_t size)
> +/* Test usage of copy_struct_from_user(). */
> +static void usercopy_test_copy_struct_from_user(struct kunit *test)
>  {
> -       int ret = 0;
>         char *umem_src = NULL, *expected = NULL;
> +       struct usercopy_test_priv *priv = test->priv;
> +       char __user *umem = priv->umem;
> +       char *kmem = priv->kmem;
> +       size_t size = priv->size;
>         size_t ksize, usize;
>
> -       umem_src = kmalloc(size, GFP_KERNEL);
> -       ret = test(umem_src == NULL, "kmalloc failed");
> -       if (ret)
> -               goto out_free;
> +       umem_src = kunit_kmalloc(test, size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, umem_src);
>
> -       expected = kmalloc(size, GFP_KERNEL);
> -       ret = test(expected == NULL, "kmalloc failed");
> -       if (ret)
> -               goto out_free;
> +       expected = kunit_kmalloc(test, size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected);
>
>         /* Fill umem with a fixed byte pattern. */
>         memset(umem_src, 0x3e, size);
> -       ret |= test(copy_to_user(umem, umem_src, size),
> +       KUNIT_ASSERT_EQ_MSG(test, copy_to_user(umem, umem_src, size), 0,
>                     "legitimate copy_to_user failed");
>
>         /* Check basic case -- (usize == ksize). */
> @@ -131,9 +137,9 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
>         memcpy(expected, umem_src, ksize);
>
>         memset(kmem, 0x0, size);
> -       ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
> +       KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), 0,
>                     "copy_struct_from_user(usize == ksize) failed");
> -       ret |= test(memcmp(kmem, expected, ksize),
> +       KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem, expected, ksize), 0,
>                     "copy_struct_from_user(usize == ksize) gives unexpected copy");
>
>         /* Old userspace case -- (usize < ksize). */
> @@ -144,9 +150,9 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
>         memset(expected + usize, 0x0, ksize - usize);
>
>         memset(kmem, 0x0, size);
> -       ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
> +       KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), 0,
>                     "copy_struct_from_user(usize < ksize) failed");
> -       ret |= test(memcmp(kmem, expected, ksize),
> +       KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem, expected, ksize), 0,
>                     "copy_struct_from_user(usize < ksize) gives unexpected copy");
>
>         /* New userspace (-E2BIG) case -- (usize > ksize). */
> @@ -154,7 +160,7 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
>         usize = size;
>
>         memset(kmem, 0x0, size);
> -       ret |= test(copy_struct_from_user(kmem, ksize, umem, usize) != -E2BIG,
> +       KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), -E2BIG,
>                     "copy_struct_from_user(usize > ksize) didn't give E2BIG");
>
>         /* New userspace (success) case -- (usize > ksize). */
> @@ -162,78 +168,46 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
>         usize = size;
>
>         memcpy(expected, umem_src, ksize);
> -       ret |= test(clear_user(umem + ksize, usize - ksize),
> +       KUNIT_EXPECT_EQ_MSG(test, clear_user(umem + ksize, usize - ksize), 0,
>                     "legitimate clear_user failed");
>
>         memset(kmem, 0x0, size);
> -       ret |= test(copy_struct_from_user(kmem, ksize, umem, usize),
> +       KUNIT_EXPECT_EQ_MSG(test, copy_struct_from_user(kmem, ksize, umem, usize), 0,
>                     "copy_struct_from_user(usize > ksize) failed");
> -       ret |= test(memcmp(kmem, expected, ksize),
> +       KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem, expected, ksize), 0,
>                     "copy_struct_from_user(usize > ksize) gives unexpected copy");
> -
> -out_free:
> -       kfree(expected);
> -       kfree(umem_src);
> -       return ret;
>  }
>
> -static int __init test_user_copy_init(void)
> +/*
> + * Legitimate usage: none of these copies should fail.
> + */
> +static void usercopy_test_valid(struct kunit *test)
>  {
> -       int ret = 0;
> -       char *kmem;
> -       char __user *usermem;
> -       char *bad_usermem;
> -       unsigned long user_addr;
> -       u8 val_u8;
> -       u16 val_u16;
> -       u32 val_u32;
> -#ifdef TEST_U64
> -       u64 val_u64;
> -#endif
> -
> -       kmem = kmalloc(PAGE_SIZE * 2, GFP_KERNEL);
> -       if (!kmem)
> -               return -ENOMEM;
> -
> -       user_addr = vm_mmap(NULL, 0, PAGE_SIZE * 2,
> -                           PROT_READ | PROT_WRITE | PROT_EXEC,
> -                           MAP_ANONYMOUS | MAP_PRIVATE, 0);
> -       if (user_addr >= (unsigned long)(TASK_SIZE)) {
> -               pr_warn("Failed to allocate user memory\n");
> -               kfree(kmem);
> -               return -ENOMEM;
> -       }
> +       struct usercopy_test_priv *priv = test->priv;
> +       char __user *usermem = priv->umem;
> +       char *kmem = priv->kmem;
>
> -       usermem = (char __user *)user_addr;
> -       bad_usermem = (char *)user_addr;
> -
> -       /*
> -        * Legitimate usage: none of these copies should fail.
> -        */
>         memset(kmem, 0x3a, PAGE_SIZE * 2);
> -       ret |= test(copy_to_user(usermem, kmem, PAGE_SIZE),
> -                   "legitimate copy_to_user failed");
> +       KUNIT_EXPECT_EQ_MSG(test, 0, copy_to_user(usermem, kmem, PAGE_SIZE),
> +            "legitimate copy_to_user failed");
>         memset(kmem, 0x0, PAGE_SIZE);
> -       ret |= test(copy_from_user(kmem, usermem, PAGE_SIZE),
> -                   "legitimate copy_from_user failed");
> -       ret |= test(memcmp(kmem, kmem + PAGE_SIZE, PAGE_SIZE),
> -                   "legitimate usercopy failed to copy data");
> -
> -#define test_legit(size, check)                                                  \
> -       do {                                                              \
> -               val_##size = check;                                       \
> -               ret |= test(put_user(val_##size, (size __user *)usermem), \
> -                   "legitimate put_user (" #size ") failed");            \
> -               val_##size = 0;                                           \
> -               ret |= test(get_user(val_##size, (size __user *)usermem), \
> -                   "legitimate get_user (" #size ") failed");            \
> -               ret |= test(val_##size != check,                          \
> -                   "legitimate get_user (" #size ") failed to do copy"); \
> -               if (val_##size != check) {                                \
> -                       pr_info("0x%llx != 0x%llx\n",                     \
> -                               (unsigned long long)val_##size,           \
> -                               (unsigned long long)check);               \
> -               }                                                         \
> +       KUNIT_EXPECT_EQ_MSG(test, 0, copy_from_user(kmem, usermem, PAGE_SIZE),
> +            "legitimate copy_from_user failed");
> +       KUNIT_EXPECT_EQ_MSG(test, 0, memcmp(kmem, kmem + PAGE_SIZE, PAGE_SIZE),
> +            "legitimate usercopy failed to copy data");
> +
> +#define test_legit(size, check)                                                \
> +       do {                                                            \
> +               size val_##size = (check);                              \
> +               KUNIT_EXPECT_EQ_MSG(test, 0,                            \
> +                       put_user(val_##size, (size __user *)usermem),   \
> +                       "legitimate put_user (" #size ") failed");      \
> +               val_##size = 0;                                         \
> +               KUNIT_EXPECT_EQ_MSG(test, 0,                            \
> +                       get_user(val_##size, (size __user *)usermem),   \
> +                       "legitimate get_user (" #size ") failed");      \
> +               KUNIT_EXPECT_EQ_MSG(test, val_##size, check,            \
> +                       "legitimate get_user (" #size ") failed to do copy"); \
>         } while (0)
>
>         test_legit(u8,  0x5a);
> @@ -243,27 +217,29 @@ static int __init test_user_copy_init(void)
>         test_legit(u64, 0x5a5b5c5d6a6b6c6d);
>  #endif
>  #undef test_legit
> +}
>
> -       /* Test usage of check_nonzero_user(). */
> -       ret |= test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
> -       /* Test usage of copy_struct_from_user(). */
> -       ret |= test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
> -
> -       /*
> -        * Invalid usage: none of these copies should succeed.
> -        */
> +/*
> + * Invalid usage: none of these copies should succeed.
> + */
> +static void usercopy_test_invalid(struct kunit *test)
> +{
> +       struct usercopy_test_priv *priv = test->priv;
> +       char __user *usermem = priv->umem;
> +       char *bad_usermem = (char *)usermem;
> +       char *kmem = priv->kmem;
>
>         /* Prepare kernel memory with check values. */
>         memset(kmem, 0x5a, PAGE_SIZE);
>         memset(kmem + PAGE_SIZE, 0, PAGE_SIZE);
>
>         /* Reject kernel-to-kernel copies through copy_from_user(). */
> -       ret |= test(!copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
> -                                   PAGE_SIZE),
> +       KUNIT_EXPECT_NE_MSG(test, copy_from_user(kmem, (char __user *)(kmem + PAGE_SIZE),
> +                                                PAGE_SIZE), 0,
>                     "illegal all-kernel copy_from_user passed");
>
>         /* Destination half of buffer should have been zeroed. */
> -       ret |= test(memcmp(kmem + PAGE_SIZE, kmem, PAGE_SIZE),
> +       KUNIT_EXPECT_EQ_MSG(test, memcmp(kmem + PAGE_SIZE, kmem, PAGE_SIZE), 0,
>                     "zeroing failure for illegal all-kernel copy_from_user");
>
>  #if 0
> @@ -273,29 +249,25 @@ static int __init test_user_copy_init(void)
>          * to be tested in LKDTM instead, since this test module does not
>          * expect to explode.
>          */
> -       ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
> -                                   PAGE_SIZE),
> +       KUNIT_EXPECT_NE_MSG(test, copy_from_user(bad_usermem, (char __user *)kmem,
> +                                                PAGE_SIZE), 0,
>                     "illegal reversed copy_from_user passed");
>  #endif
> -       ret |= test(!copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
> -                                 PAGE_SIZE),
> +       KUNIT_EXPECT_NE_MSG(test, copy_to_user((char __user *)kmem, kmem + PAGE_SIZE,
> +                                              PAGE_SIZE), 0,
>                     "illegal all-kernel copy_to_user passed");
> -       ret |= test(!copy_to_user((char __user *)kmem, bad_usermem,
> -                                 PAGE_SIZE),
> +       KUNIT_EXPECT_NE_MSG(test, copy_to_user((char __user *)kmem, bad_usermem,
> +                                              PAGE_SIZE), 0,
>                     "illegal reversed copy_to_user passed");
>
>  #define test_illegal(size, check)                                          \
>         do {                                                                \
> -               val_##size = (check);                                       \
> -               ret |= test(!get_user(val_##size, (size __user *)kmem),     \
> +               size val_##size = (check);                                          \
> +               KUNIT_EXPECT_NE_MSG(test, get_user(val_##size, (size __user *)kmem), 0, \
>                     "illegal get_user (" #size ") passed");                 \
> -               ret |= test(val_##size != (size)0,                          \
> +               KUNIT_EXPECT_EQ_MSG(test, val_##size, 0,                    \
>                     "zeroing failure for illegal get_user (" #size ")");    \
> -               if (val_##size != (size)0) {                                \
> -                       pr_info("0x%llx != 0\n",                            \
> -                               (unsigned long long)val_##size);            \
> -               }                                                           \
> -               ret |= test(!put_user(val_##size, (size __user *)kmem),     \
> +               KUNIT_EXPECT_NE_MSG(test, put_user(val_##size, (size __user *)kmem), 0, \
>                     "illegal put_user (" #size ") passed");                 \
>         } while (0)
>
> @@ -306,26 +278,46 @@ static int __init test_user_copy_init(void)
>         test_illegal(u64, 0x5a5b5c5d6a6b6c6d);
>  #endif
>  #undef test_illegal
> +}
>
> -       vm_munmap(user_addr, PAGE_SIZE * 2);
> -       kfree(kmem);
> +static int usercopy_test_init(struct kunit *test)
> +{
> +       struct usercopy_test_priv *priv;
> +       unsigned long user_addr;
>
> -       if (ret == 0) {
> -               pr_info("tests passed.\n");
> -               return 0;
> -       }
> +       priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +       test->priv = priv;
> +       priv->size = PAGE_SIZE * 2;
>
> -       return -EINVAL;
> -}
> +       priv->kmem = kunit_kmalloc(test, priv->size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->kmem);
>
> -module_init(test_user_copy_init);
> +       user_addr = kunit_vm_mmap(test, NULL, 0, priv->size,
> +                           PROT_READ | PROT_WRITE | PROT_EXEC,
> +                           MAP_ANONYMOUS | MAP_PRIVATE, 0);
> +       KUNIT_ASSERT_LT_MSG(test, user_addr, (unsigned long)TASK_SIZE,
> +               "Failed to allocate user memory");
> +       priv->umem = (char __user *)user_addr;
>
> -static void __exit test_user_copy_exit(void)
> -{
> -       pr_info("unloaded.\n");
> +       return 0;
>  }
>
> -module_exit(test_user_copy_exit);
> -
> +static struct kunit_case usercopy_test_cases[] = {
> +       KUNIT_CASE(usercopy_test_valid),
> +       KUNIT_CASE(usercopy_test_invalid),
> +       KUNIT_CASE(usercopy_test_check_nonzero_user),
> +       KUNIT_CASE(usercopy_test_copy_struct_from_user),
> +       {}
> +};
> +
> +static struct kunit_suite usercopy_test_suite = {
> +       .name = "usercopy",
> +       .init = usercopy_test_init,
> +       .test_cases = usercopy_test_cases,
> +};
> +
> +kunit_test_suites(&usercopy_test_suite);
>  MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
>  MODULE_LICENSE("GPL");
> --
> 2.34.1
>

--0000000000005ec7df061a5cec6c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIJ+Q83bXmCaX/jxmuSzNeFrDekY59+z1hrmOlcXL1CCgMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwODA4NDQyNVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBSIH6M
qhu42KoRwnr9OlCi7BaS0uppKe/jxodUgYt8dR3pz9rNd4rIPOA1xqNyDL3tj4iI+dgOYyAuKigZ
lT4MJsCPLD7+6q2T55hK6XbDh4v9LcXOeFUNyWbRsu3xnpfNBssfmqfqXrJNiI578Fghr6gSwD3D
btHkYwYAX56pQaQdJIqIhpLVUokC95H3Hn2En5cStrvlPEn1aH0eT66edXyVs4NnC6hb528ylgAG
MP9DH045GFSj4jdHGOp+bsfz6nMisvwxmtvDsUhJNWp9yPUCkgXnSMKGlF+fC9m7+kXjEP5DqdZh
j+fI1PeH/iqAfSg2uHc/zpFefms623nk
--0000000000005ec7df061a5cec6c--

