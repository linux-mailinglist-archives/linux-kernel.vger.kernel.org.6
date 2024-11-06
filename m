Return-Path: <linux-kernel+bounces-397676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D109BDEE5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68353283C94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3150191F89;
	Wed,  6 Nov 2024 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU3n6RHy"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFC824A3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874788; cv=none; b=RxBHAMw8HdmhcNv59ixCz7AoZeRAlQ+8YKA88vTi3dD6jSyNIZHURoLAQ2/rH8MXjYJ7G7tQGnSDkXcJjBW0xk9Lft3xCNMjRNACrPofDyE6hL6SGssUUlykDpK+m0fcF3vd8/Mq7gZToMBJvUl5lsZaAA7aTiItWk3Mcqz9bJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874788; c=relaxed/simple;
	bh=+GBnktoLtaQ0PsHoKatcLeAvlhZOn5X3QRD40Mz6FFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTkRBWqc2yR8Lf624ZRNyUY8sqKQdL3E6cJmsH/umvLezvxRehaybsL8oM71lF/OY63SHfioXljUs9NjmDGv8d9PcLQ6SwnrY3iuBqT4lJV3z7zxC4MZPDIAIsGXGrIQlnYTWjaC5kS/ioHK7ps9U06vhz6b9NNLgvk2pe65EII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU3n6RHy; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e604425aa0so3432842b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730874786; x=1731479586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ep9vB5JcSq75Q0rxA1MByd+Tqpe2bHUEQqu4CN5eEpE=;
        b=YU3n6RHyFoKt6lkWEF8rGjfusrbZmKRTDz6j9uncYsGtVzFjiqkbPGqk7qur3/T9rg
         PMymsTtOwd0WzhwR9MhM5B2/AhZG1X+0LkRnMtmC6xeymqWSz0QTiKdGCUTTMJp8Zqpi
         Li2I0uIMEMKPw6AkqOBqaOe5YvHgPpeS+iXZBzj1HdXq0gSmlrh+f46cWu/6QrzmFDvp
         f9ZtZD3KmN7SQYD4JFVbOeVq9RkRJGMvoc4TLbTRJipGFfGclK24urjsFwom+xFzRN/v
         ddyLEWJNtdb0Dj4w16XvdMQQrt/oouqKT7PomP4Lnc0W8CnJDqx+VTEbEsyfcqRyDS8v
         MzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730874786; x=1731479586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ep9vB5JcSq75Q0rxA1MByd+Tqpe2bHUEQqu4CN5eEpE=;
        b=uVFutJhf7mE5YfgZXHQP6ugviu05I8+AFJDHaL+0hG5wC8oVLBDhvAWyTqyUU74udR
         7N0xK+X+LELPOfPlXWulPtZnD+dPgrAIcOq4ORwkS3kJQK/Un1xZMLH7VwpIkZVeDDt/
         EddATujYMS+TuqkjVItI6PqTFSHBtNr8+vf6DP+zg84B1Pi6o2pEQYE+mPuB2yZHCfmc
         6GuFheF/GXBgl5Sfk4+5adAlWFA1H2WSdPeMx8NGXWWDVgU2oNhYUcSpaYwCB6P+qkBZ
         xDt6QXQRgrTefBVielOstymk+Wg4QCTU2KT6Cb51bJjKvcLRdBqKFT8ZVTMdBJALLTQB
         23oA==
X-Forwarded-Encrypted: i=1; AJvYcCUHdVLZ7Whtz5ZQKKq8X1Atss/rHeC8JbYAhdr3knzmv1HpVsHGHI2+o9b82ngObfpCx1FmQqqtTOdbvrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsI4rdn/0Z7ifi3tslQOeN89Ivx1VffTARqhdBokZjw0z8H9j
	VFRFvudA/9sadzdLES+D4be09CEphWHojK7pldalqAIGuCSXlEkniL43rJOr4QGkO+UPTSEG8nj
	M/HXUQohJspF/dM2Cn9Ddbfy4PNI=
X-Google-Smtp-Source: AGHT+IFOKZfUn7pYVwMgqCTC9LcSqnZVclpzyVHyqZt1XS7Kxu5crLN19wMDQo58VzaFs+8VGh45/GqUda6J3wWSsuw=
X-Received: by 2002:a05:6808:1527:b0:3e5:f141:bad with SMTP id
 5614622812f47-3e638480bd8mr34003447b6e.24.1730874785791; Tue, 05 Nov 2024
 22:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-2-zhangchunyan@iscas.ac.cn> <bedac8d9-4ba4-427c-9323-edcdbd7876ee@ghiti.fr>
In-Reply-To: <bedac8d9-4ba4-427c-9323-edcdbd7876ee@ghiti.fr>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 6 Nov 2024 14:32:29 +0800
Message-ID: <CAAfSe-u9L21e=x6i3oX2qCKSLLQw8p8fyuJwnLTijdHx_A-gnQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V4 1/3] riscv: mm: Prepare for reusing PTE RSW bit(9)
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Tue, 5 Nov 2024 at 20:45, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi Chunyan,
>
> On 30/08/2024 03:10, Chunyan Zhang wrote:
> > The PTE bit(9) on RISC-V is reserved for software, it is used by DEVMAP
> > now which has to be disabled if we want to use bit(9) for other features,
> > since there's no more free PTE bit on RISC-V now.
> >
> > So to make ARCH_HAS_PTE_DEVMAP selectable, this patch uses it as
> > the build condition of devmap definitions.
> >
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> >   arch/riscv/include/asm/pgtable-64.h   | 2 +-
> >   arch/riscv/include/asm/pgtable-bits.h | 6 ++++++
> >   2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> > index 0897dd99ab8d..babb8d2b0f0b 100644
> > --- a/arch/riscv/include/asm/pgtable-64.h
> > +++ b/arch/riscv/include/asm/pgtable-64.h
> > @@ -398,7 +398,7 @@ static inline struct page *pgd_page(pgd_t pgd)
> >   #define p4d_offset p4d_offset
> >   p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
> >
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_ARCH_HAS_PTE_DEVMAP)
> >   static inline int pte_devmap(pte_t pte);
> >   static inline pte_t pmd_pte(pmd_t pmd);
> >
> > diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> > index a8f5205cea54..5bcc73430829 100644
> > --- a/arch/riscv/include/asm/pgtable-bits.h
> > +++ b/arch/riscv/include/asm/pgtable-bits.h
> > @@ -19,7 +19,13 @@
> >   #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
> >
> >   #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
> > +
> > +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
> >   #define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
> > +#else
> > +#define _PAGE_DEVMAP 0
> > +#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> > +
> >   #define _PAGE_TABLE     _PAGE_PRESENT
> >
> >   /*
>
>
> There is a small inconsistency in our code: pte_devmap() is protected by
> a #ifdef but pte_mkdevmap() is not, I guess that's why you had to define

pte_devmap() is defined in include/linux/mm.h as well, we have to use
#ifdef to avoid compile error since we will change the
CONFIG_ARCH_HAS_PTE_DEVMAP to be selectable on riscv.

> _PAGE_DEVMAP if !CONFIG_ARCH_HAS_PTE_DEVMAP.
>
> I'd be in favor of removing the #ifdef around pte_devmap() too.

So we cannot remove the #ifdef here, the compiler would report
redefinition errors if CONFIG_ARCH_HAS_PTE_DEVMAP is not selected.

Thanks for the review,
Chunyan

