Return-Path: <linux-kernel+bounces-286821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29417951F61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509B91C20E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540471B9B2C;
	Wed, 14 Aug 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlxEJuVo"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016351B86D2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651458; cv=none; b=u9PSOCPenmyZ/2fGKOOIxUVK5Oz2OAiefyrhICgPtJaPFL81lqSwbivsigyHmhqbhNZexC0hZMs6yA7fdSuhxv2jZ3iLNG5o+YRC0AZ8S3/nTjj3BREKXt4tWd5fj0KKA/dUnG3dhtD8bPeFWeWBi9qoJ/VioCvyDp1MYT22yH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651458; c=relaxed/simple;
	bh=PDMVunQ3YpiXJYBSD85MkpDHv+K8uf5nCKFDXtwOTpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8HfHXVER1ZXjcFM9eeB0/rVf3LzcC5PXTFEuk/pf4jHqlexEHRNArXeeFXKOwrn1RNLdaBLT6wjlmwUrajwB3RlRLHipg45bXfEa/3xYPtq43OoYl/TbfxG/AotjFYhELQrabE29HFWVZHSNXvcOQKpY7lyJ563RprnYBULnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlxEJuVo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42803bbf842so67298865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651455; x=1724256255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YUv+UEK7DbXaXmZeHJkOXNJ/5IGPTcl3OKytRpyoA0=;
        b=AlxEJuVoXNL+7cjjCchKEZfXsmwZa6HlF6YDFAbsYeOVkgRHkAQICaq48Xnp02dSEB
         mSpe//dhGaF4g2nSmiXmPgEzcC3b7O3gkIaPQrge/+udWPjBNV7Z/vzMYUwvJODBRl3t
         fvca5F9ntruvEqX390J5Br2RoW9vw6cXEKUMkgVkaqEivfCXbJHRWnWXukgvd8VBDTPB
         0hQ0CDU6tjr41whbkXF34pTiUhUjQEIocceYsRbqP9CTygFoUoD+vtrxdnaIwVxXqE9Y
         l7lSDCrkCeMVAje4xBfMn1yCmUMJIBda84q7ZXgWDAwgFijJ4ogSE56HrknIunlN5dTK
         p0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651455; x=1724256255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YUv+UEK7DbXaXmZeHJkOXNJ/5IGPTcl3OKytRpyoA0=;
        b=fIT/1cZ5Vw99T3jmhEFd665ptYXZLVhNFE/iS2HtJYSTv5zqKKdsYEJzLyhMSZN4M7
         QfFv1ZxOUlXiedzKGQDE31PE4Zk4SHOzWCD304xcsW/SWz2NYG+wKOXQ18gc/o/9hqLQ
         tCiewd6UF2Ny+ERox8c3SCPf/Nk8fKLUe/6kIyqAWL4IfVGbJp7blBkOKrdSNkzfZavq
         DBe9bIoy9umfm3AnAbQEw1Ksh4WKholxsvOMWUkdAt039LXnVIMsiVCQazwqn91I/QjP
         0a2I93zP3a94kDUrgBGWM2TH4uosH0bIH/8mSwccHAwCkWmuXKNE17B5gqdSd7NsFtEk
         K6bA==
X-Forwarded-Encrypted: i=1; AJvYcCVEXsXitEHnGjCG1erXfg05AdMc1kO0SyDUZot08uojOWl15zxPJSq3JN2gXSZtMViRYl9jeai78zX2zxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26np3qVy7+8opvm86eTNrVEIYjiWjUzK/AYy5ZyIilTtHnJek
	S9vujr33jKBM4end8iuEdECZvrYY5QPO/VWNTfDeMEg4bYmP3MfW7cqBgQK87nBYOlXfVzEfBZY
	PdBUj7q+iTCoT6+MNbNMRe5BaZGI=
X-Google-Smtp-Source: AGHT+IHieo20VqQV/NrE6RTDvC7T1ETRDy8XNxidtBA8vAjYT38DsBpFNCl6GoRE46mrcwlVyuYfQfB7LOR98Ajqch0=
X-Received: by 2002:a05:600c:3b88:b0:426:5520:b835 with SMTP id
 5b1f17b1804b1-429dd22f28cmr29544235e9.5.1723651455149; Wed, 14 Aug 2024
 09:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814085618.968833-1-samuel.holland@sifive.com> <20240814085618.968833-8-samuel.holland@sifive.com>
In-Reply-To: <20240814085618.968833-8-samuel.holland@sifive.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Aug 2024 18:04:04 +0200
Message-ID: <CA+fCnZeHmfeQHDMFqELnPA-LNhWoKwxAKEPsEEBDCdoD9SEHwg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] kasan: sw_tags: Support runtime stack tagging
 control for RISC-V
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:56=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This allows the kernel to boot on systems without pointer masking
> support when stack tagging is enabled.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

But see a nit below.

> ---
>
>  mm/kasan/kasan.h       | 2 ++
>  mm/kasan/sw_tags.c     | 9 +++++++++
>  scripts/Makefile.kasan | 5 +++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index fb2b9ac0659a..01e945cb111d 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -630,6 +630,8 @@ void *__asan_memset(void *addr, int c, ssize_t len);
>  void *__asan_memmove(void *dest, const void *src, ssize_t len);
>  void *__asan_memcpy(void *dest, const void *src, ssize_t len);
>
> +u8 __hwasan_generate_tag(void);
> +
>  void __hwasan_load1_noabort(void *);
>  void __hwasan_store1_noabort(void *);
>  void __hwasan_load2_noabort(void *);
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 220b5d4c6876..32435d33583a 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -70,6 +70,15 @@ u8 kasan_random_tag(void)
>         return (u8)(state % (KASAN_TAG_MAX + 1));
>  }
>
> +u8 __hwasan_generate_tag(void)
> +{
> +       if (!kasan_enabled())
> +               return KASAN_TAG_KERNEL;
> +
> +       return kasan_random_tag();
> +}
> +EXPORT_SYMBOL(__hwasan_generate_tag);
> +
>  bool kasan_check_range(const void *addr, size_t size, bool write,
>                         unsigned long ret_ip)
>  {
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 390658a2d5b7..f64c1aca3e97 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -73,6 +73,11 @@ ifeq ($(call clang-min-version, 150000)$(call gcc-min-=
version, 130000),y)
>  CFLAGS_KASAN +=3D $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=3D1=
)
>  endif
>
> +# RISC-V requires dynamically determining if stack tagging can be enable=
d.
> +ifdef CONFIG_RISCV
> +CFLAGS_KASAN +=3D $(call cc-param,hwasan-generate-tags-with-calls=3D1)

Let's indent this line by 1 tab (I already sent a patch that fixes
indentation in the other parts of this Makefile [1]).

[1] https://lore.kernel.org/linux-mm/20240813224027.84503-1-andrey.konovalo=
v@linux.dev/T/#u


> +endif
> +
>  endif # CONFIG_KASAN_SW_TAGS
>
>  export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE
> --
> 2.45.1
>

