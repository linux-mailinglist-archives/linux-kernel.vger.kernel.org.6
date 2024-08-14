Return-Path: <linux-kernel+bounces-286819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1CF951F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A61282733
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345ED1B8E83;
	Wed, 14 Aug 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrPRtdlM"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1C1B86E0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651442; cv=none; b=hNZYW7mgkCrJVipIFhNrQzqaD5HV/+H7hVgkL/+9Cl34971rEoP2b+zB2BdDfhsjgSxD31cpIhY6Xdfd0Lmknk9jK6lttgK4YpDTzHMjHQgaFn9W8kqljpAcopXNL6UIjBgrNazn6q5FWR4W4ex/7+ZyyNQmdv/1rSqO0LYvzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651442; c=relaxed/simple;
	bh=cgVvlYHzOokE9n6B8mPzUMU7UjOjC7BQjqpz2EtY0PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF6rkoq7bx7x4y99g3sokmkeFkq1p/YtBwBPawsAxaOTDVEt+tHl0Qvsd1vCIgUZe3pBqvhPtildtqNiw0uiZ3SDMadzwLN/4NcDLFP+2grShpVtSOuxGuGJ/cEYaGhQ7plL8oFGXZwHTSEOjHBtB5yG7zqQJGHYU8sv9wtCeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrPRtdlM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so34400f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651439; x=1724256239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnVAjE8y+xk4uzYKyeuMufgQpUYFTpPW67lHJ8a/9Vo=;
        b=BrPRtdlMc6NTtcuLOr7P9K+6TS4orlRTpWFOc0AYyMLYuDPAPyMP39cKyTFZwZmaH1
         Bgol3Ju2o0K9Vu2X7jFfD69WSlpCvc1jzXW6kiJ91W9ccMqoTIgvqKuMtF1WC9C1VIlv
         nYwD+OlhUabtho8k3pWSad5ixoQw6nfvKcb3ojVHh33mjyawwXVccTXs7TW2JTUX+tSK
         8qVOygVotDZWF4RCRRkeg60sghhqg9W56cZ1Mne+BsKUkSmmMGpAc5c3CVJjbUecCxIe
         14SqmT0I9o1Kk3tHkPmID4xAglRcZhLwNlQFS7mJRGe1BIHM7uFsCfxmsrUTOr+lHWrS
         smpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651439; x=1724256239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnVAjE8y+xk4uzYKyeuMufgQpUYFTpPW67lHJ8a/9Vo=;
        b=P6k5+ZxInAS8Rz2xKuU4I2psoUDuH7v2hPhFYmv3ToV3vGA5PAjnmR359gSxlYIxMg
         +9qWDC2vE+8yA+S6phdtZh0tb5c/ieFXkA7ZrS0qmnP3EuxGjqB3L2BAmY9I9+JZMVIg
         qXxM1VRig31xBK/vXSetf/+vi62YybLlZAMNVfifiwuuF2Ck7iC5Z0dRIahFgN6XIXCL
         d6YejdLLje/SNH4E7aR8+CHF4HGLDwppB+QcpOtcplMpzxpULzehLEr3NcOZNUBV0ltb
         8aTu5xgfJYz5G8B63bQ8Q+ncsaqTbXLu1UsTm4KyKiALbbZ/lPdFST46ZLGtYFmjrTjG
         3njg==
X-Forwarded-Encrypted: i=1; AJvYcCXNwJNR61sD1vfHNf9dQWO62Y4SmpnhfrrVBvntNsxgcDVSPvMS561tFofs3k1fmcjaFgDH6AV3sS/wdt9C4eNTZHQYhIWPHGF8DaWy
X-Gm-Message-State: AOJu0YzS8EBjw2Em2sqIWVMaIWg5dNc+xqvxl/nuP0rJjLZbYwnGxUgU
	rdKna5C9C5P3ShzTUoA0qI+8Y2dme5xHmu6UfqSl/v95/DXML5Ko7zLhYvYEyklxQEaW4KQycr1
	zhKX0ie+wjIzFw6/OfCJXxiMhURU=
X-Google-Smtp-Source: AGHT+IG96LhAw8wrgerj/6cLpq6rZugdU6Z19efxBYeTunxRdokjJ/CnGMzl4ifk+lDafce3fGBmhHooKWiIky2kX/w=
X-Received: by 2002:a05:6000:1542:b0:368:7f4f:9ead with SMTP id
 ffacd0b85a97d-3717775b981mr2772783f8f.7.1723651438898; Wed, 14 Aug 2024
 09:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814085618.968833-1-samuel.holland@sifive.com> <20240814085618.968833-3-samuel.holland@sifive.com>
In-Reply-To: <20240814085618.968833-3-samuel.holland@sifive.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Aug 2024 18:03:48 +0200
Message-ID: <CA+fCnZdqCSeSNeB+OpWFTPiTY0BguZKkWexiiELYt8TRqw4Vvw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] kasan: sw_tags: Check kasan_flag_enabled at runtime
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
> On RISC-V, the ISA extension required to dereference tagged pointers is
> optional, and the interface to enable pointer masking requires firmware
> support. Therefore, we must detect at runtime if sw_tags is usable on a
> given machine. Reuse the logic from hw_tags to dynamically enable KASAN.
>
> This commit makes no functional change to the KASAN_HW_TAGS code path.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  include/linux/kasan-enabled.h | 15 +++++----------
>  mm/kasan/hw_tags.c            | 10 ----------
>  mm/kasan/tags.c               | 10 ++++++++++
>  3 files changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.=
h
> index 6f612d69ea0c..648bda9495b7 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -4,7 +4,7 @@
>
>  #include <linux/static_key.h>
>
> -#ifdef CONFIG_KASAN_HW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>
> @@ -13,23 +13,18 @@ static __always_inline bool kasan_enabled(void)
>         return static_branch_likely(&kasan_flag_enabled);
>  }
>
> -static inline bool kasan_hw_tags_enabled(void)
> -{
> -       return kasan_enabled();
> -}
> -
> -#else /* CONFIG_KASAN_HW_TAGS */
> +#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>
>  static inline bool kasan_enabled(void)
>  {
>         return IS_ENABLED(CONFIG_KASAN);
>  }
>
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> +
>  static inline bool kasan_hw_tags_enabled(void)
>  {
> -       return false;
> +       return IS_ENABLED(CONFIG_KASAN_HW_TAGS) && kasan_enabled();
>  }
>
> -#endif /* CONFIG_KASAN_HW_TAGS */
> -
>  #endif /* LINUX_KASAN_ENABLED_H */
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9958ebc15d38..c3beeb94efa5 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -43,13 +43,6 @@ static enum kasan_arg kasan_arg __ro_after_init;
>  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>  static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
>
> -/*
> - * Whether KASAN is enabled at all.
> - * The value remains false until KASAN is initialized by kasan_init_hw_t=
ags().
> - */
> -DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> -EXPORT_SYMBOL(kasan_flag_enabled);
> -
>  /*
>   * Whether the selected mode is synchronous, asynchronous, or asymmetric=
.
>   * Defaults to KASAN_MODE_SYNC.
> @@ -257,9 +250,6 @@ void __init kasan_init_hw_tags(void)
>
>         kasan_init_tags();
>
> -       /* KASAN is now initialized, enable it. */
> -       static_branch_enable(&kasan_flag_enabled);
> -
>         pr_info("KernelAddressSanitizer initialized (hw-tags, mode=3D%s, =
vmalloc=3D%s, stacktrace=3D%s)\n",
>                 kasan_mode_info(),
>                 kasan_vmalloc_enabled() ? "on" : "off",
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index d65d48b85f90..c111d98961ed 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -32,6 +32,13 @@ enum kasan_arg_stacktrace {
>
>  static enum kasan_arg_stacktrace kasan_arg_stacktrace __initdata;
>
> +/*
> + * Whether KASAN is enabled at all.
> + * The value remains false until KASAN is initialized by kasan_init_tags=
().
> + */
> +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +EXPORT_SYMBOL(kasan_flag_enabled);
> +
>  /* Whether to collect alloc/free stack traces. */
>  DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
>
> @@ -92,6 +99,9 @@ void __init kasan_init_tags(void)
>                 if (WARN_ON(!stack_ring.entries))
>                         static_branch_disable(&kasan_flag_stacktrace);
>         }
> +
> +       /* KASAN is now initialized, enable it. */
> +       static_branch_enable(&kasan_flag_enabled);
>  }
>
>  static void save_stack_info(struct kmem_cache *cache, void *object,
> --
> 2.45.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

