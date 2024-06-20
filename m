Return-Path: <linux-kernel+bounces-222265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C390FEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71FD2832F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03051990A8;
	Thu, 20 Jun 2024 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDp2fqA6"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091F3CF65
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872614; cv=none; b=rCv3/1pkH9CybE4ORIS8DNXsJYBY3J0KXxtJE3RxsVWQD/wwXYZEoNHfUycX+0LdOKXIsk2vJlrHl5PT5/qPLVyON/WH8uB0d02ombqMj+VXLks0QYq5eqINUZNRhjXK9A2FRFCKf/RaaO725qNxsmY3kM144rlgebFyhG5sUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872614; c=relaxed/simple;
	bh=gThRgA+KYC5GB8/QMnZsGnppNwIjDv7ifk09VTYI/e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5OwK7TF4sQeJqtTXb/5bcbHRGoRnSysHKtJ4AWQZv5GTVGlXlwuZKBUgiJjWK95i9sCpxyhxDIWGj0csCL9dtMTMe/f+YmXCQC85+QqSW2c481UxrzlVr8sSGx8EhnOqhzBUu/Pq21xX+l3DnuJPdASHRiza/tS+C7gACfspw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDp2fqA6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4434fd275aaso2704041cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718872611; x=1719477411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OUYcIAPu8Sr/lzFQuuddP6LocZmaVvpQ1N05tgsbXo=;
        b=mDp2fqA67B5SeRvojKMA6ld+w7F4NgXSmoLXY3ykDVCuzWa8IK2xH8blxrJFyNUcIj
         nQoE4lcEXSN3FyolpQZSxAjCs4Q2STezxFzvF5KgGE07shXk1smCEGNX+FmAkmYS3o6C
         mgl+kgnLyvywhLHH/TeZWm5VUwAdElHb7UpoCcEteNxIvoviIDuUecf0gYEw3mIx++fO
         1fIEL6WB3GtcAFcY4rZ34tViPuqM94syz9Necn9np2DNTEhKwZsgFO5PBpfJBwDP2+iA
         Yi8QYiyuXh4B85vdRgyD6pH5AgbBVJ4NUCh26EAUulYynLcWYFqoar6A7K8jdhiBIn4Z
         Lk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872611; x=1719477411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OUYcIAPu8Sr/lzFQuuddP6LocZmaVvpQ1N05tgsbXo=;
        b=VAkgXwNB7l2ezD3iJl1ql4FDLvEgY2ht4mOHqlqbZDE0NYCqpgNpbsN7xuBhZfWTSK
         R9h3dwVuFtV+SYVk8N9XOCD4pSwuYyjTKBTxBXBDVQ9wAVrskI+qxpkuMsSkSkaQIvWB
         BQnSRPZODhTh1rxhTJXGjgmz9qs7h8K+2EWyFeyk9r7Pk8Vmdz3FP2DLxbPBLsUJqbEg
         RIpAmeETRJ5gxybEOvjIKhwxDKEDjZQi3D7U4WR+sTPS6BPCvZvZKYY2KiLSWbcH24mD
         Am4OeSpYNIGG0ME66+P0RR5wimy/ZEx9wyreqzLQsPVbIwLt4RhMIxp5xpE7U1/V590f
         lAdA==
X-Forwarded-Encrypted: i=1; AJvYcCWW1G8ZcFcjojCo7vYrmJPZSG3bAmKxmBbIHq7aI00iutr6WltnBgRFJY2GvZ5jKid5NtgtHqlmsGkN7AW6eoh7tOY1JwPNWhb5UDn/
X-Gm-Message-State: AOJu0YwGtiOMJCronAJwiGBOtxYOeR4P2Bv6QsSeV86o6ljG140c4LXE
	vZqSBP5D/S2Ag/RXr6QgwuG281jq9GfhU8BFJ0OUt4+BY8d81fF61ddeSxpLJ7wcxeAHFL4Z7XE
	FJT/hiwRgBIzLi9utAhkKvAs7qIsprJAkWnXj
X-Google-Smtp-Source: AGHT+IErmEp1x0YBOZTZJdlWJwFXEfsRyPhDcy8wmEVW3hTA6/SyMHr3il2LMbLMxYtDvHsm6Ik4jSDo32quxqAzw+g=
X-Received: by 2002:a05:6214:4a42:b0:6b4:f761:f0b8 with SMTP id
 6a1803df08f44-6b501dff5a9mr45755846d6.8.1718872610557; Thu, 20 Jun 2024
 01:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619154530.163232-1-iii@linux.ibm.com> <20240619154530.163232-34-iii@linux.ibm.com>
In-Reply-To: <20240619154530.163232-34-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 20 Jun 2024 10:36:12 +0200
Message-ID: <CAG_fn=V8Tt28LE9FtoYkos=5XG4zP_tDP1mF1COfEhAMg2ULqQ@mail.gmail.com>
Subject: Re: [PATCH v5 33/37] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:45=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> put_user() uses inline assembly with precise constraints, so Clang is
> in principle capable of instrumenting it automatically. Unfortunately,
> one of the constraints contains a dereferenced user pointer, and Clang
> does not currently distinguish user and kernel pointers. Therefore
> KMSAN attempts to access shadow for user pointers, which is not a right
> thing to do.

By the way, how does this problem manifest?
I was expecting KMSAN to generate dummy shadow accesses in this case,
and reading/writing 1-8 bytes from dummy shadow shouldn't be a
problem.

(On the other hand, not inlining the get_user/put_user functions is
probably still faster than retrieving the dummy shadow, so I'm fine
either way)

>
> An obvious fix to add __no_sanitize_memory to __put_user_fn() does not
> work, since it's __always_inline. And __always_inline cannot be removed
> due to the __put_user_bad() trick.
>
> A different obvious fix of using the "a" instead of the "+Q" constraint
> degrades the code quality, which is very important here, since it's a
> hot path.
>
> Instead, repurpose the __put_user_asm() macro to define
> __put_user_{char,short,int,long}_noinstr() functions and mark them with
> __no_sanitize_memory. For the non-KMSAN builds make them
> __always_inline in order to keep the generated code quality. Also
> define __put_user_{char,short,int,long}() functions, which call the
> aforementioned ones and which *are* instrumented, because they call
> KMSAN hooks, which may be implemented as macros.
>
> The same applies to get_user() as well.
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/uaccess.h | 111 +++++++++++++++++++++++---------
>  1 file changed, 79 insertions(+), 32 deletions(-)
>
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uacc=
ess.h
> index 81ae8a98e7ec..70f0edc00c2a 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -78,13 +78,24 @@ union oac {
>
>  int __noreturn __put_user_bad(void);
>
> -#define __put_user_asm(to, from, size)                                 \
> -({                                                                     \
> +#ifdef CONFIG_KMSAN
> +#define get_put_user_noinstr_attributes \
> +       noinline __maybe_unused __no_sanitize_memory
> +#else
> +#define get_put_user_noinstr_attributes __always_inline
> +#endif
> +
> +#define DEFINE_PUT_USER(type)                                          \
> +static get_put_user_noinstr_attributes int                             \
> +__put_user_##type##_noinstr(unsigned type __user *to,                  \
> +                           unsigned type *from,                        \
> +                           unsigned long size)                         \
> +{                                                                      \
>         union oac __oac_spec =3D {                                       =
 \
>                 .oac1.as =3D PSW_BITS_AS_SECONDARY,                      =
 \
>                 .oac1.a =3D 1,                                           =
 \
>         };                                                              \
> -       int __rc;                                                       \
> +       int rc;                                                         \
>                                                                         \
>         asm volatile(                                                   \
>                 "       lr      0,%[spec]\n"                            \
> @@ -93,12 +104,28 @@ int __noreturn __put_user_bad(void);
>                 "2:\n"                                                  \
>                 EX_TABLE_UA_STORE(0b, 2b, %[rc])                        \
>                 EX_TABLE_UA_STORE(1b, 2b, %[rc])                        \
> -               : [rc] "=3D&d" (__rc), [_to] "+Q" (*(to))                =
 \
> +               : [rc] "=3D&d" (rc), [_to] "+Q" (*(to))                  =
 \
>                 : [_size] "d" (size), [_from] "Q" (*(from)),            \
>                   [spec] "d" (__oac_spec.val)                           \
>                 : "cc", "0");                                           \
> -       __rc;                                                           \
> -})
> +       return rc;                                                      \
> +}                                                                      \
> +                                                                       \
> +static __always_inline int                                             \
> +__put_user_##type(unsigned type __user *to, unsigned type *from,       \
> +                 unsigned long size)                                   \
> +{                                                                      \
> +       int rc;                                                         \
> +                                                                       \
> +       rc =3D __put_user_##type##_noinstr(to, from, size);              =
 \
> +       instrument_put_user(*from, to, size);                           \
> +       return rc;                                                      \
> +}
> +
> +DEFINE_PUT_USER(char);
> +DEFINE_PUT_USER(short);
> +DEFINE_PUT_USER(int);
> +DEFINE_PUT_USER(long);
>
>  static __always_inline int __put_user_fn(void *x, void __user *ptr, unsi=
gned long size)
>  {
> @@ -106,24 +133,24 @@ static __always_inline int __put_user_fn(void *x, v=
oid __user *ptr, unsigned lon
>
>         switch (size) {
>         case 1:
> -               rc =3D __put_user_asm((unsigned char __user *)ptr,
> -                                   (unsigned char *)x,
> -                                   size);
> +               rc =3D __put_user_char((unsigned char __user *)ptr,
> +                                    (unsigned char *)x,
> +                                    size);
>                 break;
>         case 2:
> -               rc =3D __put_user_asm((unsigned short __user *)ptr,
> -                                   (unsigned short *)x,
> -                                   size);
> +               rc =3D __put_user_short((unsigned short __user *)ptr,
> +                                     (unsigned short *)x,
> +                                     size);
>                 break;
>         case 4:
> -               rc =3D __put_user_asm((unsigned int __user *)ptr,
> +               rc =3D __put_user_int((unsigned int __user *)ptr,
>                                     (unsigned int *)x,
>                                     size);
>                 break;
>         case 8:
> -               rc =3D __put_user_asm((unsigned long __user *)ptr,
> -                                   (unsigned long *)x,
> -                                   size);
> +               rc =3D __put_user_long((unsigned long __user *)ptr,
> +                                    (unsigned long *)x,
> +                                    size);
>                 break;
>         default:
>                 __put_user_bad();
> @@ -134,13 +161,17 @@ static __always_inline int __put_user_fn(void *x, v=
oid __user *ptr, unsigned lon
>
>  int __noreturn __get_user_bad(void);
>
> -#define __get_user_asm(to, from, size)                                 \
> -({                                                                     \
> +#define DEFINE_GET_USER(type)                                          \
> +static get_put_user_noinstr_attributes int                             \
> +__get_user_##type##_noinstr(unsigned type *to,                         \
> +                           unsigned type __user *from,                 \
> +                           unsigned long size)                         \
> +{                                                                      \
>         union oac __oac_spec =3D {                                       =
 \
>                 .oac2.as =3D PSW_BITS_AS_SECONDARY,                      =
 \
>                 .oac2.a =3D 1,                                           =
 \
>         };                                                              \
> -       int __rc;                                                       \
> +       int rc;                                                         \
>                                                                         \
>         asm volatile(                                                   \
>                 "       lr      0,%[spec]\n"                            \
> @@ -149,13 +180,29 @@ int __noreturn __get_user_bad(void);
>                 "2:\n"                                                  \
>                 EX_TABLE_UA_LOAD_MEM(0b, 2b, %[rc], %[_to], %[_ksize])  \
>                 EX_TABLE_UA_LOAD_MEM(1b, 2b, %[rc], %[_to], %[_ksize])  \
> -               : [rc] "=3D&d" (__rc), "=3DQ" (*(to))                    =
   \
> +               : [rc] "=3D&d" (rc), "=3DQ" (*(to))                      =
   \
>                 : [_size] "d" (size), [_from] "Q" (*(from)),            \
>                   [spec] "d" (__oac_spec.val), [_to] "a" (to),          \
>                   [_ksize] "K" (size)                                   \
>                 : "cc", "0");                                           \
> -       __rc;                                                           \
> -})
> +       return rc;                                                      \
> +}                                                                      \
> +                                                                       \
> +static __always_inline int                                             \
> +__get_user_##type(unsigned type *to, unsigned type __user *from,       \
> +                 unsigned long size)                                   \
> +{                                                                      \
> +       int rc;                                                         \
> +                                                                       \
> +       rc =3D __get_user_##type##_noinstr(to, from, size);              =
 \
> +       instrument_get_user(*to);                                       \
> +       return rc;                                                      \
> +}
> +
> +DEFINE_GET_USER(char);
> +DEFINE_GET_USER(short);
> +DEFINE_GET_USER(int);
> +DEFINE_GET_USER(long);
>
>  static __always_inline int __get_user_fn(void *x, const void __user *ptr=
, unsigned long size)
>  {
> @@ -163,24 +210,24 @@ static __always_inline int __get_user_fn(void *x, c=
onst void __user *ptr, unsign
>
>         switch (size) {
>         case 1:
> -               rc =3D __get_user_asm((unsigned char *)x,
> -                                   (unsigned char __user *)ptr,
> -                                   size);
> +               rc =3D __get_user_char((unsigned char *)x,
> +                                    (unsigned char __user *)ptr,
> +                                    size);
>                 break;
>         case 2:
> -               rc =3D __get_user_asm((unsigned short *)x,
> -                                   (unsigned short __user *)ptr,
> -                                   size);
> +               rc =3D __get_user_short((unsigned short *)x,
> +                                     (unsigned short __user *)ptr,
> +                                     size);
>                 break;
>         case 4:
> -               rc =3D __get_user_asm((unsigned int *)x,
> +               rc =3D __get_user_int((unsigned int *)x,
>                                     (unsigned int __user *)ptr,
>                                     size);
>                 break;
>         case 8:
> -               rc =3D __get_user_asm((unsigned long *)x,
> -                                   (unsigned long __user *)ptr,
> -                                   size);
> +               rc =3D __get_user_long((unsigned long *)x,
> +                                    (unsigned long __user *)ptr,
> +                                    size);
>                 break;
>         default:
>                 __get_user_bad();
> --
> 2.45.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20240619154530.163232-34-iii%40linux.ibm.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

