Return-Path: <linux-kernel+bounces-286820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD8951F60
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C6E1C20F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329B1B29C3;
	Wed, 14 Aug 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3aRydHf"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72D1B86E0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651449; cv=none; b=cPEZZK2D+0Y/7AAEEI2CQ2Eno4cJlPUUUXGyALRakgA4nfiM4FxFidhWuK9yz11TmTfNJ8cBGdKbFTf9X9EDV3OGPeJmc/BTRPnv1ll+nEUlcfK1ke7lxRBT0T5HBt+d0phqCApNr3bGw72CDTTyByMZGWGKCO/yDihyiFOlIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651449; c=relaxed/simple;
	bh=yI2M+LsYVM/MrDDyC9GdFfJSLyvrxhK/KtKomKmnDjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkmbIfidURdsz06ZBOot5Ks8npDOMaE4iQ5eONb6gbTGSrWnJ6/OEYce8SJASB8b5OGJOT43afZcRRqw9KvleWTNgS1ejVmZc/N/zHXtKqkN5XoTo0siULhZcx53YmoM9xv3we53+zL2vZ1Nn/pFVvjYJO9+tChTKDhz5ecrqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3aRydHf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36bcc168cdaso55605f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651446; x=1724256246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsVwGbt3gTQjJ2udr1fi33WHUjrTh7/T/FVKigzrowA=;
        b=e3aRydHfuZI/DRvZBQ7mbiRPiNrchLqMvwwOOdVYNiHpaWlhuTQG36a08vESUChkhC
         kTFQZrn+WB5ofx1m4YMRsb6P143TiTMwHa2Sv7fAiEVipNU+Tq7J0oxzxq5x2Y6Zx4zJ
         s4FtZiUYSlHdwcgzADuLvyTnstI9aG9Udy7RN0qu7ZVAW9U0p0Zh+ubeFUpKltTIQjTe
         JD+Q2qpVkfxhxxsgn5Scc0WpxFFMuvWwUr/jk63vzQCsT2kGBqAPBmAlxtR4GijyGCrV
         1BrQiiazXvI0RdnNjPpImIIPECG32JQiwRQy5A/OHBZQFMvCNdZ6yxwF1AC1t+qs24ti
         Nq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651446; x=1724256246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsVwGbt3gTQjJ2udr1fi33WHUjrTh7/T/FVKigzrowA=;
        b=We1CsOLk8dOMldoRnhdRDIXVlscvTD8V6dzf+iEZi/NwONsmkRuGjwDZvQDvpx1xLu
         NYrbcNMwUfDoIRjMaxu9jPrweTIP4zIideP4KOotuzSf6Nu1u7fpdSR2wy8HMBq6X4+z
         nnH9LDlx1zGz5QgERaoQLWdbE8H84F3wUMZEh1tt4XXwtjKb5P+i4g49/u0bNW3Kv06+
         w56tPtCwOxK66Ii1rL6Y7tmMzJ07lzRCMm5pQ9HApxCpmDaOMLl52+Tw0euJ1lZvnITP
         by8N3jW2i5KZmv9ox2g/HA4mXVAvBG8dRjw8sgrpcIvHfu9yeSWF/AT6xM5jRarGyMLE
         X2jA==
X-Forwarded-Encrypted: i=1; AJvYcCXipkgc7R4BimmmtX7Np23FzuRv8AfuOnvzWAt2YVAWnXPOIxVwWDqADrZfCoSsIZz2GJ/aCuVZWWOp/Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKBWzpG4gIt4BIR9xwTXtqU6sJUcpEHIHt3HM+/6k7ka8Bo/d
	gFjxB2tbWRwbVQotDj+jGTRewksKjIReWwENUydRB8FHPrxwTHHmgJdf+oiit6zq4tY4pHLijTu
	Y/LPmWgsfBfVcixUq2en8+3i4w5k=
X-Google-Smtp-Source: AGHT+IH3WGBZYGGMMeBMLZ8/7pbU5/zXCItnDtUaC7+sJAFb2TCPZKtdU4opFOuQ2YIOepRuhBu4BNdTmycC72rMS98=
X-Received: by 2002:adf:cc09:0:b0:36b:d3eb:17a5 with SMTP id
 ffacd0b85a97d-3717778d7cfmr2725194f8f.36.1723651445910; Wed, 14 Aug 2024
 09:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814085618.968833-1-samuel.holland@sifive.com> <20240814085618.968833-4-samuel.holland@sifive.com>
In-Reply-To: <20240814085618.968833-4-samuel.holland@sifive.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 14 Aug 2024 18:03:54 +0200
Message-ID: <CA+fCnZf3U9u1dHBjecT=ZMYHp0OKv00HwObDcpAFwGXF58Vedg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] kasan: sw_tags: Support tag widths less than 8 bits
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
> Allow architectures to override KASAN_TAG_KERNEL in asm/kasan.h. This
> is needed on RISC-V, which supports 57-bit virtual addresses and 7-bit
> pointer tags. For consistency, move the arm64 MTE definition of
> KASAN_TAG_MIN to asm/kasan.h, since it is also architecture-dependent;
> RISC-V's equivalent extension is expected to support 7-bit hardware
> memory tags.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/arm64/include/asm/kasan.h   |  6 ++++--
>  arch/arm64/include/asm/uaccess.h |  1 +
>  include/linux/kasan-tags.h       | 13 ++++++++-----
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasa=
n.h
> index e1b57c13f8a4..4ab419df8b93 100644
> --- a/arch/arm64/include/asm/kasan.h
> +++ b/arch/arm64/include/asm/kasan.h
> @@ -6,8 +6,10 @@
>
>  #include <linux/linkage.h>
>  #include <asm/memory.h>
> -#include <asm/mte-kasan.h>
> -#include <asm/pgtable-types.h>
> +
> +#ifdef CONFIG_KASAN_HW_TAGS
> +#define KASAN_TAG_MIN                  0xF0 /* minimum value for random =
tags */
> +#endif
>
>  #define arch_kasan_set_tag(addr, tag)  __tag_set(addr, tag)
>  #define arch_kasan_reset_tag(addr)     __tag_reset(addr)
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/ua=
ccess.h
> index 28f665e0975a..56a09f412272 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -22,6 +22,7 @@
>  #include <asm/cpufeature.h>
>  #include <asm/mmu.h>
>  #include <asm/mte.h>
> +#include <asm/mte-kasan.h>
>  #include <asm/ptrace.h>
>  #include <asm/memory.h>
>  #include <asm/extable.h>
> diff --git a/include/linux/kasan-tags.h b/include/linux/kasan-tags.h
> index 4f85f562512c..e07c896f95d3 100644
> --- a/include/linux/kasan-tags.h
> +++ b/include/linux/kasan-tags.h
> @@ -2,13 +2,16 @@
>  #ifndef _LINUX_KASAN_TAGS_H
>  #define _LINUX_KASAN_TAGS_H
>
> +#include <asm/kasan.h>
> +
> +#ifndef KASAN_TAG_KERNEL
>  #define KASAN_TAG_KERNEL       0xFF /* native kernel pointers tag */
> -#define KASAN_TAG_INVALID      0xFE /* inaccessible memory tag */
> -#define KASAN_TAG_MAX          0xFD /* maximum value for random tags */
> +#endif
> +
> +#define KASAN_TAG_INVALID      (KASAN_TAG_KERNEL - 1) /* inaccessible me=
mory tag */
> +#define KASAN_TAG_MAX          (KASAN_TAG_KERNEL - 2) /* maximum value f=
or random tags */
>
> -#ifdef CONFIG_KASAN_HW_TAGS
> -#define KASAN_TAG_MIN          0xF0 /* minimum value for random tags */
> -#else
> +#ifndef KASAN_TAG_MIN
>  #define KASAN_TAG_MIN          0x00 /* minimum value for random tags */
>  #endif
>
> --
> 2.45.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

