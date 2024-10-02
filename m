Return-Path: <linux-kernel+bounces-347893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C5998E016
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B251B2B456
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD11D0B97;
	Wed,  2 Oct 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRwn083J"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12B1D0955
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884811; cv=none; b=uhrbNYc+0CsKYLlKaG7DKdyyrS5TXIvm3ZhkMpeQiKePDp5lAufhdOTrI0fKN0zVYsBhJVPae6MBYQJmT3gfqb1zOJHVlHYORsLtNHkpAoccMI3wwrN0mMM4nXp+aO6YIlJetJRbDnAYAvZdns4XDwR/+CikzPCn9PJcTEorawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884811; c=relaxed/simple;
	bh=v/b2tPL1RxG5FlBF/gSdRoeYkS8wyr9hTMsfg3oFjXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYimJGbaaU1+8b4sK5I3DLnqa7lbw59pvCWgsz5mi6bHLfV/f4atUWYvmYpRPsKYskWcghrgaEmZX6J0Z8LNiWOCkna3jkeRbXBpkbD9UikUCQV9r4S+ivY1yOMlxxpODRL7JueOiB9qvjKSSE25lpxzINcK+ol8YJPk50WwkSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRwn083J; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e03d17365bso9140b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727884809; x=1728489609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ugcP+XI8NwDswML2qKbmqUc0ZRLhImizzjcaJfjzZtU=;
        b=jRwn083JM71jDFiQXrZh1bgq+Li/dEy38PIl8bWxlA0Ze4sMPtIhJPxxd+xdodKEUH
         ee8ptt75wdwD75RQff/JVFHGn75DguyjDk+fkDl3iExH3qYKLWROlS9QY5aEjlKajXCc
         ot3tMSih0dgshsYg9BYg0q5jtKkgSoxkASi7N7VAoCYV+uXT4MCca7jIGjNqC1R58neZ
         vffKLnVNgzeDWC9ER3DH7eWKivQKJ7Mmx7O04Twpk+NBnDmV+YT6QttX11OZdoWf3zNc
         ngF12d/Cr23sE1j55uQ3TZ5m+0SjS6ozNOgpoabrnZIvVDu2maGegN8fhACOO20O4cXi
         xRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884809; x=1728489609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugcP+XI8NwDswML2qKbmqUc0ZRLhImizzjcaJfjzZtU=;
        b=Gd9bTbtNWBisqeqmJQ7Sl7HGfu40IMqqWfrMAn6tTEzxbq05vucqYtMo2nVr+zPhAK
         mhr7PdKWoyBRboMxpbMfH+5y3IlGrx8idqZacOqyMj2YLeMGU5BXF23OApG651B6tOv9
         LaPF/xFUgP6457rSzHNP9u9MoYUP5oKhxUHXVtTDRKzWLxE3f+axLyLotjlUUcAh88Vg
         TAnVifZds7926OEqUJV0Eimb91rTpWJQfpnCtwXFypOnIHcG2T+nowgO3XgiicEbkTQ7
         Ujak7wvJX7DmBl5IwxA08t0hTOWqH0DZWWUuo/rwIDr6gkDxIOKOM7rx7yWeJeNp6Xp+
         Tb/g==
X-Forwarded-Encrypted: i=1; AJvYcCWjFJp+UT76E7+aDFkkFS4sIdB2l6Evvk26CeVWhM6bHylEZMpOnB0cCu6oQrfOmq1DZjaDvvNR3UzAqwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyBj0UQm/35S/gl1G9ygxsNySbNMQmSOEV8HgpbOMWNWcwtTv
	bwjCPFjsVcyIRt5lyad+vucqiwdc2juqADGaYBSmPp/gFkpNdKoEg3+z/YKz74oF6zttB+gwKmN
	xlcwEhmDxqUhS4p0HaY8LGD2QZwekae09BDib
X-Google-Smtp-Source: AGHT+IFNHk8UqaK5NLTUrZ3xnRTfbvtrB9SP4euyHpOiVLkDHeUeErpFMUa2A4q0f7JulQxV2ShUy4BPfbcqbMZDeyo=
X-Received: by 2002:a05:6808:1295:b0:3e0:70d8:2f60 with SMTP id
 5614622812f47-3e3b416b395mr2872794b6e.32.1727884808371; Wed, 02 Oct 2024
 09:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927151438.2143936-1-snovitoll@gmail.com>
In-Reply-To: <20240927151438.2143936-1-snovitoll@gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 2 Oct 2024 17:59:32 +0200
Message-ID: <CANpmjNMAVFzqnCZhEity9cjiqQ9CVN1X7qeeeAp_6yKjwKo8iw@mail.gmail.com>
Subject: Re: [PATCH] mm: instrument copy_from/to_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 17:14, Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:
>
> Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault()
> with instrument_memcpy_before() for KASAN, KCSAN checks and
> instrument_memcpy_after() for KMSAN.

There's a fundamental problem with instrumenting
copy_from_kernel_nofault() - it's meant to be a non-faulting helper,
i.e. if it attempts to read arbitrary kernel addresses, that's not a
problem because it won't fault and BUG. These may be used in places
that probe random memory, and KASAN may say that some memory is
invalid and generate a report - but in reality that's not a problem.

In the Bugzilla bug, Andrey wrote:

> KASAN should check both arguments of copy_from/to_kernel_nofault() for accessibility when both are fault-safe.

I don't see this patch doing it, or at least it's not explained. By
looking at the code, I see that it does the instrument_memcpy_before()
right after pagefault_disable(), which tells me that KASAN or other
tools will complain if a page is not faulted in. These helpers are
meant to be usable like that - despite their inherent unsafety,
there's little that I see that KASAN can help with.

What _might_ be useful, is detecting copying faulted-in but
uninitialized memory to user space. So I think the only
instrumentation we want to retain is KMSAN instrumentation for the
copy_from_kernel_nofault() helper, and only if no fault was
encountered.

Instrumenting copy_to_kernel_nofault() may be helpful to catch memory
corruptions, but only if faulted-in memory was accessed.



> Tested on x86_64 and arm64 with CONFIG_KASAN_SW_TAGS.
> On arm64 with CONFIG_KASAN_HW_TAGS, kunit test currently fails.
> Need more clarification on it - currently, disabled in kunit test.
>
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  mm/kasan/kasan_test.c | 31 +++++++++++++++++++++++++++++++
>  mm/maccess.c          |  8 ++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 567d33b49..329d81518 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1944,6 +1944,36 @@ static void match_all_mem_tag(struct kunit *test)
>         kfree(ptr);
>  }
>
> +static void copy_from_to_kernel_nofault_oob(struct kunit *test)
> +{
> +       char *ptr;
> +       char buf[128];
> +       size_t size = sizeof(buf);
> +
> +       /* Not detecting fails currently with HW_TAGS */
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
> +
> +       ptr = kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       OPTIMIZER_HIDE_VAR(ptr);
> +
> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
> +               /* Check that the returned pointer is tagged. */
> +               KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
> +               KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +       }
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_from_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_from_kernel_nofault(ptr, &buf[0], size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(&buf[0], ptr, size));
> +       KUNIT_EXPECT_KASAN_FAIL(test,
> +               copy_to_kernel_nofault(ptr, &buf[0], size));
> +       kfree(ptr);
> +}
> +
>  static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -2017,6 +2047,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(match_all_not_assigned),
>         KUNIT_CASE(match_all_ptr_tag),
>         KUNIT_CASE(match_all_mem_tag),
> +       KUNIT_CASE(copy_from_to_kernel_nofault_oob),
>         {}
>  };
>
> diff --git a/mm/maccess.c b/mm/maccess.c
> index 518a25667..2c4251df4 100644
> --- a/mm/maccess.c
> +++ b/mm/maccess.c
> @@ -15,7 +15,7 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
>
>  #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)  \
>         while (len >= sizeof(type)) {                                   \
> -               __get_kernel_nofault(dst, src, type, err_label);                \
> +               __get_kernel_nofault(dst, src, type, err_label);        \
>                 dst += sizeof(type);                                    \
>                 src += sizeof(type);                                    \
>                 len -= sizeof(type);                                    \
> @@ -32,6 +32,7 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
>                 return -ERANGE;
>
>         pagefault_disable();
> +       instrument_memcpy_before(dst, src, size);
>         if (!(align & 7))
>                 copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
>         if (!(align & 3))
> @@ -39,6 +40,7 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
>         if (!(align & 1))
>                 copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
>         copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
> +       instrument_memcpy_after(dst, src, size, 0);
>         pagefault_enable();
>         return 0;
>  Efault:
> @@ -49,7 +51,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
>
>  #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)    \
>         while (len >= sizeof(type)) {                                   \
> -               __put_kernel_nofault(dst, src, type, err_label);                \
> +               __put_kernel_nofault(dst, src, type, err_label);        \
>                 dst += sizeof(type);                                    \
>                 src += sizeof(type);                                    \
>                 len -= sizeof(type);                                    \
> @@ -63,6 +65,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
>                 align = (unsigned long)dst | (unsigned long)src;
>
>         pagefault_disable();
> +       instrument_memcpy_before(dst, src, size);
>         if (!(align & 7))
>                 copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
>         if (!(align & 3))
> @@ -70,6 +73,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
>         if (!(align & 1))
>                 copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
>         copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
> +       instrument_memcpy_after(dst, src, size, 0);
>         pagefault_enable();
>         return 0;
>  Efault:
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20240927151438.2143936-1-snovitoll%40gmail.com.

