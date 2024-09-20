Return-Path: <linux-kernel+bounces-334678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2450D97DA8E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D491928220C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECE1188CB3;
	Fri, 20 Sep 2024 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu+kaBBQ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DA18893D
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726871203; cv=none; b=KhL8Xzf/x7gfm7K0U6m/fwzCVjs9SSvOCKL/z4qN78kUhYhOetJwyzTisBYUn03vG+OfusXjKcSNMERiMbpId0ccLyAuiPhjxuWr7Xdv6zHlNME46qivyqwvyC+bZ1fkNn/QwRmb28l87/7cIt4SP8BmftlCnLBaPBMIz1m3++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726871203; c=relaxed/simple;
	bh=NyN6OuXBYTEc1AHaBPpxE1sXzVoyBc/QZa/MlyQQ7P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLjwBavIL1C+HnLFlOo/O+DHUD03VmCyERuEEMQEkfsgEyhgbcaosQpX3RMy6iHmEsJjGdIgQzqw4krs/StigPccWx5N6Ja2gDL15LDSuneFq3NZuHYu/BRW4rwb3h6enKTUfGBnZm4VzzoQTXQA9S676287ss9gFJ4CqMnddvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu+kaBBQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso22897585e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726871200; x=1727476000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ne01jFW0K4x6QCPtZYjHKYV4ojmW2zokGbfexor1Lk=;
        b=cu+kaBBQU5FUSS0Gz5lk2cvlvoWmWnEzr+cmEiy0gUVKq5pqNt/UwAaBWTJpR0FfLG
         Yr9M7KxKhbWC5n59iWxRIaKd8wGlecYNXRnEALhUmcOU/SLCs5fPFnoeJiR+nIhX6+d0
         E0qBpWV/P1CCfl+24IO8roqSr6Frr3VOG0AGogeBN9Urw+WBexPrUcgjQW2Jx17AZ0jT
         mGQTPm1QrN/69VtMgRWTanngWO0fYf7791qX+Ckyi3uorcI/3zB9G5peE/KNKcSTQ38e
         87lpP6xetjefS3olUiRQJyIRP5/tMmEERoiXa1nMwTu5HpkWRxzVKrp1coKlHUX/aOtG
         uOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726871200; x=1727476000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ne01jFW0K4x6QCPtZYjHKYV4ojmW2zokGbfexor1Lk=;
        b=K/d2r06tTw0ZYjD2cmkPymJ2DL99o9FeMIu+DpOfwNw8PPVIKzslW/o2JJAmZkE8YG
         PBikotEppyEvXNQhFWBOUsSOvsTx+iPjNGh3AeHwneZSULnCzbLYHW2TC0NvrYQmf0an
         uSFA2pyemSg2m4FR4Sjd5EgP2QvNjwmRtFjd2BYF1rICbAr225dJGWXHqcPTq1KsWUeC
         hufkJVSTCSJx0YDukezD6iZElBQm0bL7WHd82Xd4iXDDmkxUgP5yWhtV44vqcOtan4OO
         VpQ7jWsE/BOSb8xLzafW5XOS6db3k4YASmDMbk9X55ZEsRnYmfU2c/mys/L2JmcAGCf+
         EvrA==
X-Forwarded-Encrypted: i=1; AJvYcCV6/SF0kldK3bI40NTv9jQcbWhtVsH8uvu5kUtfWgRVt2NEIXwEtMm+kPlAZPBmPGG7c5QJdjMtOkHqkQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHAValWEP4S5DpFMnInoipfBl1Gv76EVlg0dDsXSkT5CVgEVEp
	LNIVu3jigg2eCaEIKoUS7FMYMULaUOhYZFGnrBRigjnqBzGl6pT3CAbFel1z72AQKi/mklYF85C
	8dey7L7JFhqotLPTaoSCNFkfnGY0=
X-Google-Smtp-Source: AGHT+IGElvKgczn6kPm0WwE0PeEKj1lfNfAGYM3aS2UkIKa5wrYRbxGC0QHQBO9/w60FVQ0/Y1gdWbsOGy0QRBm+W9A=
X-Received: by 2002:a05:600c:1c87:b0:42c:af2a:dcf4 with SMTP id
 5b1f17b1804b1-42e7c1a3283mr24646825e9.27.1726871200155; Fri, 20 Sep 2024
 15:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZfg2E7Hk2Sc-=Z4XnENm9KUtmAZ6378YgeJg6xriMQXpA@mail.gmail.com>
 <20240919105750.901303-1-snovitoll@gmail.com>
In-Reply-To: <20240919105750.901303-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 21 Sep 2024 00:26:28 +0200
Message-ID: <CA+fCnZeiVRiO76h+RR+uKkWNNGGNsVt_yRGGod+fmC8O519T+g@mail.gmail.com>
Subject: Re: [PATCH v3] mm: x86: instrument __get/__put_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, 
	glider@google.com, hpa@zytor.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	ryabinin.a.a@gmail.com, tglx@linutronix.de, vincenzo.frascino@arm.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 12:57=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> On Wed, Sep 18, 2024 at 8:15=E2=80=AFPM Andrey Konovalov <andreyknvl@gmai=
l.com> wrote:
> > You still have the same problem here.
> >
> > What I meant is:
> >
> > char *ptr;
> > char buf[128 - KASAN_GRANULE_SIZE];
> > size_t size =3D sizeof(buf);
> >
> > ptr =3D kmalloc(size, GFP_KERNEL);
> > KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> >
> > KUNIT_EXPECT_KASAN_FAIL(...);
> > ...
> >
> > kfree(ptr);
>
> Thanks for catching this! I've turned kunit test into OOB instead of UAF.
> ---
> v3: changed kunit test from UAF to OOB case and git commit message.
> ---
> Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault(),
> strncpy_from_kernel_nofault() where __put_kernel_nofault, __get_kernel_no=
fault
> macros are used.
>
> __get_kernel_nofault needs instrument_memcpy_before() which handles
> KASAN, KCSAN checks for src, dst address, whereas for __put_kernel_nofaul=
t
> macro, instrument_write() check should be enough as it's validated via
> kmsan_copy_to_user() in instrument_put_user().
>
> __get_user_size was appended with instrument_get_user() for KMSAN check i=
n
> commit 888f84a6da4d("x86: asm: instrument usercopy in get_user() and
> put_user()") but only for CONFIG_CC_HAS_ASM_GOTO_OUTPUT.
>
> copy_from_to_kernel_nofault_oob() kunit test triggers 4 KASAN OOB bug rep=
orts
> as expected for each copy_from/to_kernel_nofault call.

"as expected for each" =3D> "as expected, one for each"

>
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  arch/x86/include/asm/uaccess.h |  4 ++++
>  mm/kasan/kasan_test.c          | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 3a7755c1a441..87fb59071e8c 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -353,6 +353,7 @@ do {                                                 =
                       \
>         default:                                                        \
>                 (x) =3D __get_user_bad();                                =
 \
>         }                                                               \
> +       instrument_get_user(x);                                         \
>  } while (0)
>
>  #define __get_user_asm(x, addr, err, itype)                            \
> @@ -620,6 +621,7 @@ do {                                                 =
                       \
>
>  #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>  #define __get_kernel_nofault(dst, src, type, err_label)                 =
       \
> +       instrument_memcpy_before(dst, src, sizeof(type));               \
>         __get_user_size(*((type *)(dst)), (__force type __user *)(src), \
>                         sizeof(type), err_label)
>  #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> @@ -627,6 +629,7 @@ do {                                                 =
                       \
>  do {                                                                   \
>         int __kr_err;                                                   \
>                                                                         \
> +       instrument_memcpy_before(dst, src, sizeof(type));               \
>         __get_user_size(*((type *)(dst)), (__force type __user *)(src), \
>                         sizeof(type), __kr_err);                        \
>         if (unlikely(__kr_err))                                         \
> @@ -635,6 +638,7 @@ do {                                                 =
                       \
>  #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>
>  #define __put_kernel_nofault(dst, src, type, err_label)                 =
       \
> +       instrument_write(dst, sizeof(type));                            \
>         __put_user_size(*((type *)(src)), (__force type __user *)(dst), \
>                         sizeof(type), err_label)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 7b32be2a3cf0..d13f1a514750 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -1899,6 +1899,26 @@ static void match_all_mem_tag(struct kunit *test)
>         kfree(ptr);
>  }
>
> +static void copy_from_to_kernel_nofault_oob(struct kunit *test)
> +{
> +       char *ptr;
> +       char buf[128];
> +       size_t size =3D sizeof(buf);
> +
> +       ptr =3D kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
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
>  static struct kunit_case kasan_kunit_test_cases[] =3D {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -1971,6 +1991,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(match_all_not_assigned),
>         KUNIT_CASE(match_all_ptr_tag),
>         KUNIT_CASE(match_all_mem_tag),
> +       KUNIT_CASE(copy_from_to_kernel_nofault_oob),
>         {}
>  };

The test looks good to me now.

But you need to send the patch as a standalone email, without
combining it with the response to my comment.

Thanks!

