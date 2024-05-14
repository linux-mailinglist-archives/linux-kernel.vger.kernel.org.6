Return-Path: <linux-kernel+bounces-179006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3618C5A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F0E1F240A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FD41802B1;
	Tue, 14 May 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Jg3pbL0i"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29721802A2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707462; cv=none; b=SlceN8BfDtWg7mVFa9cIByKeJUUKQOW+s0UcR/55yH7Jp/J9RdXNfI0TiezbpFi2Ky+OP7JXrR6M7NsEMecfh8WEKyKSL2CbP1yQxEvp7NMwTar0WLzz/jHqhwO68vGtQAUkTMqekRAkXdQayXgu66aTqoPvme1sE5PcPuDC2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707462; c=relaxed/simple;
	bh=1+pUQhSplg1y4pCiDO05f9icbk19T6mlM8SfOOZhYcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhYm6rx9ei7iNKcN3kQj4ImzVh2iUDYir+5gfvK4OBLmczAg8eEGhqh3LJjOFNrwopR9s5MJaGbUlGL/KzYpA/71uBNRd3G29LqwhIj7xBrdIsawZETHskA458MToRWWuMUV+O0jyxq9kgah2CZgfYQ70scwsQG1dz2+P2bjVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Jg3pbL0i; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so2047481a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715707459; x=1716312259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm6je9rht4BjYmGJ1IuR6KKMw8nH5QLaou4Ka+z1F+s=;
        b=Jg3pbL0i/P9YURdqTXeca6QxLJzp8vYfA0s0U0HceELlGMtKtMprgc1SXjGP+3P59g
         U4zvSYaUOZzegMGqjGGpxnL3HS7NWtWJmX7WYvnaUoxutoY7enuHNtWPcrM7VqZuzmLl
         iaP0RBSlKNCw/BX3uuEla8OOMfJSED+NBIxbrX+JKd8YNf8Yh15rJzXQQhexNYXnTEwy
         expr9pbsAkqmIcEzVArJL5u6pQ4kwVVViPXJ0XiRpTMYryoh6k3Iq/AoaBeR2k89S39Q
         kk6NlgzBFND0dX6YBTNAIfafBlLxuD4V9r/grcP0oQYMnbWEQM02JxLx0dDeMlKaaSzl
         OwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707459; x=1716312259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm6je9rht4BjYmGJ1IuR6KKMw8nH5QLaou4Ka+z1F+s=;
        b=Z+xHudAZd1Pits3WIbE9wJfHeBAsoRaUWLMMLHHYMLSpjKMUWDncTMzmn4bdQppxqX
         D0rmFJw/r6ebNjEVdNJ8jIfi3SJe3h0RFAWz3Tf2oeIUMhTtJkj26V2HCRIXt75jad47
         okuiXum9ypdj2m7GHyS/DFtwBHF37cjQ0ZmkbbaqvC8oszKdQkFvYzal5we1dqyJ0OCi
         Mu4sFN91fqsEB7YWUkBIH+K+kRZpo+dY7UGUOiy0+tQjDm0gpoTyN7Iec2SX+HEl/wm1
         SEoEWiV1N6C1WzTZAb0gcEYjV341w73KbXzY8sYMNk75ruATv1XyFzi1btaLB7rtGMyG
         W5+g==
X-Forwarded-Encrypted: i=1; AJvYcCXpy3SkaFRMKjSnlAqXRJBIWvsrFQ0b8i+YTqf9KkZdO5dxOs0wuRcnnttERGFWUkLF9XRaNc/h1xSVw0FLyh5uRqF62Hmo4HHIsqaa
X-Gm-Message-State: AOJu0Yw86C1gpcO2C44oI2VKfWHC67y7ZFQDGGohbu/e5qkJDEZETOPx
	i2JvOV4s+zp1pIEXl7Pyn8M6eiaT4S+tHqpjNJ2LBu0JuAfOiORDSZ/K6rmIrR/hsqHY1Jmk8pp
	65XtA7V9rLfA9RcQT+2hi079R2RycsZ6S3sLJUw==
X-Google-Smtp-Source: AGHT+IF56JWIpkZ2/AL2ubyZfgA/2Uc3aQFZ5Ej57ui6rLBhQ10e6OWlyGWRPN5l4ez0BlwqzQ5aMzCSBobUR5m/tfc=
X-Received: by 2002:a05:6402:26cd:b0:572:3fac:e085 with SMTP id
 4fb4d7f45d1cf-573328e276amr15922880a12.13.1715707459179; Tue, 14 May 2024
 10:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-4-bjorn@kernel.org>
In-Reply-To: <20240514140446.538622-4-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 19:24:08 +0200
Message-ID: <CAHVXubj0Ly_Nm-J17bxuEn_1cUC_HxOMUxJ5dnfRB5CL6D0jeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] riscv: mm: Refactor create_linear_mapping_range()
 for memory hot add
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

On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Add a parameter to the direct map setup function, so it can be used in
> arch_add_memory() later.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c969427eab88..6f72b0b2b854 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1227,7 +1227,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  }
>
>  static void __meminit create_linear_mapping_range(phys_addr_t start, phy=
s_addr_t end,
> -                                                 uintptr_t fixed_map_siz=
e)
> +                                                 uintptr_t fixed_map_siz=
e, const pgprot_t *pgprot)
>  {
>         phys_addr_t pa;
>         uintptr_t va, map_size;
> @@ -1238,7 +1238,7 @@ static void __meminit create_linear_mapping_range(p=
hys_addr_t start, phys_addr_t
>                                             best_map_size(pa, va, end - p=
a);
>
>                 create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
> -                                  pgprot_from_va(va));
> +                                  pgprot ? *pgprot : pgprot_from_va(va))=
;
>         }
>  }
>
> @@ -1282,22 +1282,19 @@ static void __init create_linear_mapping_page_tab=
le(void)
>                 if (end >=3D __pa(PAGE_OFFSET) + memory_limit)
>                         end =3D __pa(PAGE_OFFSET) + memory_limit;
>
> -               create_linear_mapping_range(start, end, 0);
> +               create_linear_mapping_range(start, end, 0, NULL);
>         }
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -       create_linear_mapping_range(ktext_start, ktext_start + ktext_size=
, 0);
> -       create_linear_mapping_range(krodata_start,
> -                                   krodata_start + krodata_size, 0);
> +       create_linear_mapping_range(ktext_start, ktext_start + ktext_size=
, 0, NULL);
> +       create_linear_mapping_range(krodata_start, krodata_start + krodat=
a_size, 0, NULL);
>
>         memblock_clear_nomap(ktext_start,  ktext_size);
>         memblock_clear_nomap(krodata_start, krodata_size);
>  #endif
>
>  #ifdef CONFIG_KFENCE
> -       create_linear_mapping_range(kfence_pool,
> -                                   kfence_pool + KFENCE_POOL_SIZE,
> -                                   PAGE_SIZE);
> +       create_linear_mapping_range(kfence_pool, kfence_pool + KFENCE_POO=
L_SIZE, PAGE_SIZE, NULL);
>
>         memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
>  #endif
> --
> 2.40.1
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

