Return-Path: <linux-kernel+bounces-522701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04CA3CD92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9823B8781
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701D25E45E;
	Wed, 19 Feb 2025 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtL93sLa"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631441DC05F;
	Wed, 19 Feb 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007825; cv=none; b=qUdRMdWI27p7diqsyd3nJ+WSdSTj37XwJZo3dxANLyRGjvAOiR8k1DcvxQpYBTx4kHy3UpL7rrUK54wR31QrG6EDBg6h6Fp/IOT+jePJpDu0XSGwbGK2OHQJ2KKXJa6gG2DUsH+7E2JFx7dMFSOGmqm7j3Qk729OWLxA8hRG0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007825; c=relaxed/simple;
	bh=dkSLcuAkOEkjzmNl7oQGnI8+f2nzJX2wq4RcdSEzjgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZPRFDjk2gJy5J7Go11+rfPMJuFi0jQpQ1cSfEjIi92njDIq+0cCzA0RdjVgIgfxsscsC80HvddEwV2bemRMy7UMVeA+NVxN8WLVirw+mhAlXB1fX3b/0X6PjAfreoOlEd0GB2+SN2f2TeZiZXRVhXeTKOAV3W2kMGkZSmd7D8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtL93sLa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f2f391864so171348f8f.3;
        Wed, 19 Feb 2025 15:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007822; x=1740612622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1GGaSL1EMbBNY4X399BrJn+mN5UB9HBffE2l1nq9Fw=;
        b=TtL93sLaYODv/pSKjfKFJvBff21mvHhFT8WYY4N7RJYb1jSy0lPTy/nrRoYUuZBK3m
         /nElpdUeC3EgzOiQ4u1S8e4c+ZDY3wbQDnFxC+htBDf6jTiO/vAgTIk3gyzr7/g/X87K
         RBI1hOjdTYwtNGTLfTdp6xXjlhlQ1hmYMMw377uGkenCcG04Hr3wnfB6prc/PKxi6sqw
         h9vRfpEvtpHhiejmzkPArUlgLfX2O76KDLoKZBx86RnXj2wtUULZzqyCtuifrrZ+9Mun
         WXJGqY2fmmHXefAZ1tD6U3zmPSaYMi6aQRrmBJXfCw+UQJpz4v3tDYlrbVxTVlM+6peS
         PC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007822; x=1740612622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1GGaSL1EMbBNY4X399BrJn+mN5UB9HBffE2l1nq9Fw=;
        b=UjWj2fMZl2bx66IwU6nwv3F9gEXWUphVnCOsZiUajVWsPtbGloCVS7K1EkCt/hQIin
         KFsRh0KVC6XqprcmBYjUVV2yQqUUaISa0EbA2zayFrrdH7OJyIh5490KYapyuDgw+p6V
         +csk0iDBUTrPbyO3eUMuofdPkTsiL9izqTQs5JzF79kqHR4L7CQRd2XEujLjq1xD3X6W
         qOzs/p2WIJjigtS7fQxUjaaaMoP8TChNWiPniuci/OOqH+ylexH0kRJgA5S3VW98PsJX
         alpGH5hY4wqPCYwmhDHV7SjE8pw4fqIQl/4eNrquJL75nhW+kmmWpHJxN5U2RPHOfqFg
         381w==
X-Forwarded-Encrypted: i=1; AJvYcCUCVjSd8TK9ylpgYMIRY68yuivPjb/AGtpl/N5DRAqT10A/hLM9htGTu3p6HJ7nN6t0HRdUDRxN6gxdDoda@vger.kernel.org, AJvYcCUHPSOXJuCzg83jyLYSMl6zaENnb1bn6WTzgBKZI3Ip8ZJC33lobM28++ifyEFqQCfwFyi9RJ/uVDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLaGmeihuT1q6uiPUPzspDHcHlqbaczRnu9gaEoG1/BobxSqh
	nDItD0IS/0NdYhxV5lri/nkEBlTFEvbCc1cRlOPKiPZOH1G8pAMVFDHrYeGC38EGJiTOjoMg6Em
	XDPpUd8N4Lm3g6LbTXagKKNWPpcA=
X-Gm-Gg: ASbGncuirpmcXsYiMIBPPqIqCFj1e+ZSu6MmHCdC/ZE0GXIhbjqq6QCMXjWuKKNltow
	hvbT8DxQBviioICiRs1y1i/KqjpBZMC83RCL7KtdIF3wanCriQw/6iukw33LY0QlWRxo2dfOCmZ
	U=
X-Google-Smtp-Source: AGHT+IFk7eMZYpnIc8kUgdKFr2fq40k19PHjHMj5y4xTuWwCfW66IOFvng6dtc1UANKR7c5qhgSdUJXGtz5TZYpkBcc=
X-Received: by 2002:a05:6000:178b:b0:38f:443b:48f4 with SMTP id
 ffacd0b85a97d-38f587f3d8cmr4457835f8f.49.1740007821516; Wed, 19 Feb 2025
 15:30:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com> <b1a6cd99e98bf85adc9bdf063f359c136c1a5e78.1739866028.git.maciej.wieczor-retman@intel.com>
In-Reply-To: <b1a6cd99e98bf85adc9bdf063f359c136c1a5e78.1739866028.git.maciej.wieczor-retman@intel.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 20 Feb 2025 00:30:09 +0100
X-Gm-Features: AWEUYZmNqej25uGq8URgfmDzBpW2RyznVfstivturY56XWT9sQs1qkeZ-eNhhZk
Message-ID: <CA+fCnZdRHNaxf02DXMm3q+Ecwd4XiaVZ0X9P-sdFfy+9jBMO=w@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] kasan: sw_tags: Check kasan_flag_enabled at runtime
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 9:16=E2=80=AFAM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> From: Samuel Holland <samuel.holland@sifive.com>
>
> On RISC-V, the ISA extension required to dereference tagged pointers is
> optional, and the interface to enable pointer masking requires firmware
> support. Therefore, we must detect at runtime if sw_tags is usable on a
> given machine. Reuse the logic from hw_tags to dynamically enable KASAN.

Is this patch required on x86 as well? If so, I think it makes sense
to point it out here. And do the same in messages for other commits
that now mention RISC-V.


>
> This commit makes no functional change to the KASAN_HW_TAGS code path.
>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
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
> index 9a6927394b54..7f82af13b6a6 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -45,13 +45,6 @@ static enum kasan_arg kasan_arg __ro_after_init;
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
> @@ -259,9 +252,6 @@ void __init kasan_init_hw_tags(void)
>
>         kasan_init_tags();
>
> -       /* KASAN is now initialized, enable it. */
> -       static_branch_enable(&kasan_flag_enabled);
> -
>         pr_info("KernelAddressSanitizer initialized (hw-tags, mode=3D%s, =
vmalloc=3D%s, stacktrace=3D%s)\n",
>                 kasan_mode_info(),
>                 str_on_off(kasan_vmalloc_enabled()),
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
> 2.47.1
>

