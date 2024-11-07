Return-Path: <linux-kernel+bounces-399745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348569C03B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C8F283E8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8BE1F4723;
	Thu,  7 Nov 2024 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN9hs7cx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB71EF0AD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978301; cv=none; b=Zb7dUo1j+tVbaZeA7NAyeu3dlZJ7dtjnv9XzciI9bXqtUu/OE8+VV2VFY5EjpIUpUb8/rfbWM4dErLI7sJWlABF/QU3oJdtH4JMjugD4FzFOR8WdjhEY0Qi6E6W51j9Vid2MOasT/v8CtEw1tH4nIAXNgqiD0OedLI3nAntniTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978301; c=relaxed/simple;
	bh=/hqIxR2eh2JD/Nxu9SVoRZslqCCpsKD4JNXRw4d4e3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qR+qjcp7+lnYZ3oFNKNlUCu4Gbj+bn7Xn+CDuZkxpZknOlIzK+xa9jjS1atg3jxtEETl8F+54iWDlPiP0rleHWfy5wSE7F+lw00PUGGctFrkN2gEkxD62jZJMqvJk1GFUyaWDejgFRmn6oaOp7lwGDO33sJKLAQcWmM7x068YdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN9hs7cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1059DC4CED7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730978301;
	bh=/hqIxR2eh2JD/Nxu9SVoRZslqCCpsKD4JNXRw4d4e3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rN9hs7cxJhIx0kl7aBEo9LeSkOgDa1dlE1GWTMHEXea64n0hlwtKuiH3AnBGPBNND
	 GPHLeZoJPvSOtmiGVfppKWk2jdwIiMYrNS5P7sDBJw2pqPvATczBiTxl1ibKUJ/3Mw
	 +UlRquCcjypkmtPORkml2eaSeStX42eO0/y1kIhM3l3zC8POMqNP+450BxcGPza9wU
	 Hi7LXFS9GvngW38/OH7XutKeqyNGaWyqCv0Dc7QiB1PB3ey0l9rbwFQUwk90ARwQ7Z
	 4wY3OqlrI9YMpmoEeUc7Bg/OccFvCMJAYUZVZCpOwB6NCRKk84u553+gqXu41UUq4D
	 L6qhEQEfQwCSg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ec86a67feso136046266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:18:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3jhTsPek6Ar20uIKkCaoFJyBKqAqm715a7O7a/ttKSm9NMvkVPC7KtCYfUrepgJ47W9RSptnR51aeATs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCzsoQkpcMeXuJXhNz4EJhBk1zddeSn2yExDAeRmpPL0ybW8p
	l55TTSjn5alzCugVg0VfLOdK8aK4R7ZlmvfTXNpwDziQ3zHkAAup3DxgAfMmdN+lOz9//qe7MLa
	XDXxbcPi/LkRazUXPcHc4KrC3qfM=
X-Google-Smtp-Source: AGHT+IFodDnflsXg3T0GcW++921aFywCMhsMu1LhQ2VTtzeya+EdeGkNP7P5g5Sq5NSC7AMnxbADYUIAQPopeJjYL1A=
X-Received: by 2002:a17:907:7f9f:b0:a9a:be:37f8 with SMTP id
 a640c23a62f3a-a9de61675a4mr4574762266b.43.1730978299549; Thu, 07 Nov 2024
 03:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105122945.21886-1-wangkanglong@loongson.cn>
In-Reply-To: <20241105122945.21886-1-wangkanglong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 7 Nov 2024 19:18:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5vreDWbcVfL8+AEAiNdDG_AwQ5Ydwh3-XZe1WY=MmxqQ@mail.gmail.com>
Message-ID: <CAAhV-H5vreDWbcVfL8+AEAiNdDG_AwQ5Ydwh3-XZe1WY=MmxqQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add DMW2 shadow mapping in KASAN
To: Kanglong Wang <wangkanglong@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued, thanks.

Huacai

On Tue, Nov 5, 2024 at 8:30=E2=80=AFPM Kanglong Wang <wangkanglong@loongson=
.cn> wrote:
>
> Currently,the kernel couldn't boot when both CONFIG_ARCH_IOREMAP,
> CONFIG_ARCH_WRITECOMBINE and KASAN are enabled. Because the DMW2 is used
> by kernel now which is configured as 0xa000000000000000, the KASAN has
> no segment mapping. This patch fix this issue.
>
> Solution: Add the relevant definitions for DMW2 in KASAN.
>
> Fixes: 8e02c3b782ec ("LoongArch: Add writecombine support for DMW-based i=
oremap()")
> Signed-off-by: Kanglong Wang <wangkanglong@loongson.cn>
> ---
>  arch/loongarch/include/asm/kasan.h | 11 ++++++++++-
>  arch/loongarch/mm/kasan_init.c     |  5 +++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/=
asm/kasan.h
> index c6bce5fbff57..2636a1160bae 100644
> --- a/arch/loongarch/include/asm/kasan.h
> +++ b/arch/loongarch/include/asm/kasan.h
> @@ -25,6 +25,7 @@
>  /* 64-bit segment value. */
>  #define XKPRANGE_UC_SEG                (0x8000)
>  #define XKPRANGE_CC_SEG                (0x9000)
> +#define XKPRANGE_WC_SEG                (0xa000)
>  #define XKVRANGE_VC_SEG                (0xffff)
>
>  /* Cached */
> @@ -41,10 +42,17 @@
>  #define XKPRANGE_UC_SHADOW_SIZE                (XKPRANGE_UC_SIZE >> KASA=
N_SHADOW_SCALE_SHIFT)
>  #define XKPRANGE_UC_SHADOW_END         (XKPRANGE_UC_KASAN_OFFSET + XKPRA=
NGE_UC_SHADOW_SIZE)
>
> +/* Weak-ordered UnCached */
> +#define XKPRANGE_WC_START              WRITECOMBINE_BASE
> +#define XKPRANGE_WC_SIZE               XRANGE_SIZE
> +#define XKPRANGE_WC_KASAN_OFFSET       XKPRANGE_UC_SHADOW_END
> +#define XKPRANGE_WC_SHADOW_SIZE                (XKPRANGE_WC_SIZE >> KASA=
N_SHADOW_SCALE_SHIFT)
> +#define XKPRANGE_WC_SHADOW_END         (XKPRANGE_WC_KASAN_OFFSET + XKPRA=
NGE_WC_SHADOW_SIZE)
> +
>  /* VMALLOC (Cached or UnCached)  */
>  #define XKVRANGE_VC_START              MODULES_VADDR
>  #define XKVRANGE_VC_SIZE               round_up(KFENCE_AREA_END - MODULE=
S_VADDR + 1, PGDIR_SIZE)
> -#define XKVRANGE_VC_KASAN_OFFSET       XKPRANGE_UC_SHADOW_END
> +#define XKVRANGE_VC_KASAN_OFFSET       XKPRANGE_WC_SHADOW_END
>  #define XKVRANGE_VC_SHADOW_SIZE                (XKVRANGE_VC_SIZE >> KASA=
N_SHADOW_SCALE_SHIFT)
>  #define XKVRANGE_VC_SHADOW_END         (XKVRANGE_VC_KASAN_OFFSET + XKVRA=
NGE_VC_SHADOW_SIZE)
>
> @@ -55,6 +63,7 @@
>
>  #define XKPRANGE_CC_SHADOW_OFFSET      (KASAN_SHADOW_START + XKPRANGE_CC=
_KASAN_OFFSET)
>  #define XKPRANGE_UC_SHADOW_OFFSET      (KASAN_SHADOW_START + XKPRANGE_UC=
_KASAN_OFFSET)
> +#define XKPRANGE_WC_SHADOW_OFFSET      (KASAN_SHADOW_START + XKPRANGE_WC=
_KASAN_OFFSET)
>  #define XKVRANGE_VC_SHADOW_OFFSET      (KASAN_SHADOW_START + XKVRANGE_VC=
_KASAN_OFFSET)
>
>  extern bool kasan_early_stage;
> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_ini=
t.c
> index 427d6b1aec09..0babfab73448 100644
> --- a/arch/loongarch/mm/kasan_init.c
> +++ b/arch/loongarch/mm/kasan_init.c
> @@ -55,6 +55,9 @@ void *kasan_mem_to_shadow(const void *addr)
>                 case XKPRANGE_UC_SEG:
>                         offset =3D XKPRANGE_UC_SHADOW_OFFSET;
>                         break;
> +               case XKPRANGE_WC_SEG:
> +                       offset =3D XKPRANGE_WC_SHADOW_OFFSET;
> +                       break;
>                 case XKVRANGE_VC_SEG:
>                         offset =3D XKVRANGE_VC_SHADOW_OFFSET;
>                         break;
> @@ -79,6 +82,8 @@ const void *kasan_shadow_to_mem(const void *shadow_addr=
)
>
>         if (addr >=3D XKVRANGE_VC_SHADOW_OFFSET)
>                 return (void *)(((addr - XKVRANGE_VC_SHADOW_OFFSET) << KA=
SAN_SHADOW_SCALE_SHIFT) + XKVRANGE_VC_START);
> +       else if (addr >=3D XKPRANGE_WC_SHADOW_OFFSET)
> +               return (void *)(((addr - XKPRANGE_WC_SHADOW_OFFSET) << KA=
SAN_SHADOW_SCALE_SHIFT) + XKPRANGE_WC_START);
>         else if (addr >=3D XKPRANGE_UC_SHADOW_OFFSET)
>                 return (void *)(((addr - XKPRANGE_UC_SHADOW_OFFSET) << KA=
SAN_SHADOW_SCALE_SHIFT) + XKPRANGE_UC_START);
>         else if (addr >=3D XKPRANGE_CC_SHADOW_OFFSET)
> --
> 2.20.1
>

