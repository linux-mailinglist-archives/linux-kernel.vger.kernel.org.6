Return-Path: <linux-kernel+bounces-178894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD328C592C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD131F220E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033E17EBBB;
	Tue, 14 May 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xW20aY2U"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44917EB87
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702277; cv=none; b=pwjKiRsSHayd6jGeLNong3jRjQRPH3R1nTt2mnm4fvnr+BXXewUFMI4epDLiBnE6dqnH5+D10a/4lAqBqTEcrpsd2dHxkPuD1n4Pkwr98Me3M69D8YIJZYCSW1zaYJbNO1CqoTvvJp7XPq4bF09i1vtKhWewMlGBMb45K5rpUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702277; c=relaxed/simple;
	bh=ZRZC+ewraM3sNSDTKtcy7um+e8MQrAqS8SrqujW4WhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWMa9H1KeYu0J/a1cwJhHZptjeEgKVPN6tKQT1sm0Dfnbl4p39WhWHXGCNgsTLUAlPtzmoZU7c6uEVvWUGX4wXQSACViiKLmiBxPQ79fV3+EdJwQSsoQzMgS8Mv/Cdl5YcqiJCQzL9atOCKy+011Crp0ZnOd255KZZf8hOyPcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xW20aY2U; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a5f81af4so38032166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715702274; x=1716307074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YVPz8d9fNN7RmoGRWLz27p194UlG1xw9/YZRFhtwc4=;
        b=xW20aY2UMsvxrBPkt986JEiCpm1gV+mEGMVBfoOfSwm1uZO2zIntzm5bTLxKmlidA+
         IFFWPVqFdikhrKWBRucD542Bu33KlNMHpGZKHwPE7mDL8Z+J2Zf8HCGOO3ouYUhDkYuG
         20f5GUTc7m06wdZis9Id+ezJIMLKqmiCtuUqI3Lx+IIf+hdWUK+XMEJ3bD+o3wJmmHDe
         M9Lj92mYIGpfEEyGT6/vQ35P7y/d0F9zmer/YxXaVksiprS5ry0h/Kt9Eesif6gQXjJL
         n3cPeEJR7hcn6Xq/sGtm4yYtskrCumFjT+9agE4D8xzXAdngt854g2wRRu1LJc8xinD1
         pBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702274; x=1716307074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YVPz8d9fNN7RmoGRWLz27p194UlG1xw9/YZRFhtwc4=;
        b=rS0xTxH2eZuYGqt85zx85EDFrsKoC8gcFRlrMVrA3S+79nugaqi1RHHRHqE1oIjb9J
         04mmL9ApgLQi08QlhZSqZu+NRMzfKqxSJ4Mb7OflHom35sJMrPzuSWsLpVbbNDMAUC5h
         NvATHIzUDW4q5REs1b8kY5OfoZRytyME7u1S/PVZZSNiuSMKi2w2mOE40/AVo/bPBhrX
         yVPZmUgZmPnfcqzFdMXMAwXFvhgwo45lGcb5kLAaO2va4GVgxRED/7Rj5eZBaf8hjRSU
         8BtOzxYjTK5UHXfTAG+JM8ATvVbU/Yj61uTbyJm7KMdnk7miuJysIlbrO+GVKlagHG9x
         KipQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuPvDftzp/K+1vY3C0w3fsI7doS5Sh2lABxD35r33YNSMnrwjPECxB1msa+ec131wR0WxHjBSINHXs9PoNfI4f+iVwiEW6Lwke2c5c
X-Gm-Message-State: AOJu0YxQvOOiIBXLNle9nJqKjU/ZM/pM6mPsKjIN55wZeWOHz+ycS57f
	GIPddwHBh+w2FTLlYoB5Z1tkdHjPfV3ZtaU2dhLsRt+Dawz6e5FfxpVaZU/0sXwYJTi86Sum7Ir
	ajuHWVTbRQf2pevo5dwA9HK2jbAehmD4xy6IQ0A==
X-Google-Smtp-Source: AGHT+IGpm9BtgF2gQRgKdtEpvWTCkNaf/J7ULsUq4SiDnv5BQvS5Vo6yygT4W4ORsVjJhPMMfM/u6EKEY/mm3nAcHd8=
X-Received: by 2002:a17:907:9705:b0:a5a:7cd3:b2e7 with SMTP id
 a640c23a62f3a-a5a7cd3b463mr311306266b.11.1715702273691; Tue, 14 May 2024
 08:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-2-bjorn@kernel.org>
In-Reply-To: <20240514140446.538622-2-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 17:57:42 +0200
Message-ID: <CAHVXubhfsvDZrw_Cvg8AnEm00P0TQvrSOV_jVSBRckmJLp6EFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] riscv: mm: Pre-allocate vmemmap/direct map PGD entries
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The RISC-V port copies the PGD table from init_mm/swapper_pg_dir to
> all userland page tables, which means that if the PGD level table is
> changed, other page tables has to be updated as well.
>
> Instead of having the PGD changes ripple out to all tables, the
> synchronization can be avoided by pre-allocating the PGD entries/pages
> at boot, avoiding the synchronization all together.
>
> This is currently done for the bpf/modules, and vmalloc PGD regions.
> Extend this scheme for the PGD regions touched by memory hotplugging.
>
> Prepare the RISC-V port for memory hotplug by pre-allocate
> vmemmap/direct map entries at the PGD level. This will roughly waste
> ~128 worth of 4K pages when memory hotplugging is enabled in the
> kernel configuration.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/include/asm/kasan.h | 4 ++--
>  arch/riscv/mm/init.c           | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasa=
n.h
> index 0b85e363e778..e6a0071bdb56 100644
> --- a/arch/riscv/include/asm/kasan.h
> +++ b/arch/riscv/include/asm/kasan.h
> @@ -6,8 +6,6 @@
>
>  #ifndef __ASSEMBLY__
>
> -#ifdef CONFIG_KASAN
> -
>  /*
>   * The following comment was copied from arm64:
>   * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
> @@ -34,6 +32,8 @@
>   */
>  #define KASAN_SHADOW_START     ((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) &=
 PGDIR_MASK)
>  #define KASAN_SHADOW_END       MODULES_LOWEST_VADDR
> +
> +#ifdef CONFIG_KASAN
>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>
>  void kasan_init(void);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2574f6a3b0e7..5b8cdfafb52a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -27,6 +27,7 @@
>
>  #include <asm/fixmap.h>
>  #include <asm/io.h>
> +#include <asm/kasan.h>
>  #include <asm/numa.h>
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
> @@ -1488,10 +1489,16 @@ static void __init preallocate_pgd_pages_range(un=
signed long start, unsigned lon
>         panic("Failed to pre-allocate %s pages for %s area\n", lvl, area)=
;
>  }
>
> +#define PAGE_END KASAN_SHADOW_START
> +
>  void __init pgtable_cache_init(void)
>  {
>         preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc"=
);
>         if (IS_ENABLED(CONFIG_MODULES))
>                 preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "=
bpf/modules");
> +       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
> +               preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "=
vmemmap");
> +               preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "direc=
t map");
> +       }
>  }
>  #endif
> --
> 2.40.1
>

As you asked, with
https://lore.kernel.org/linux-riscv/20240514133614.87813-1-alexghiti@rivosi=
nc.com/T/#u,
you will be able to remove the usage of KASAN_SHADOW_START.

But anyhow, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

