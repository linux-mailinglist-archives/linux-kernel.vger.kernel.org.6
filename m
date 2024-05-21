Return-Path: <linux-kernel+bounces-185027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6708CAF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D401C21E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00167EEF3;
	Tue, 21 May 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dfj+0KFO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836B71B48
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298888; cv=none; b=fhzg5YOdLTJeKtM9KmMbAY2xpCydeBY0qTVNPl/cXFsaNYmxaaHRjmS5bd+Z/If6gcwozF1Buj6Z5zIvFfEq63MELjHjzzyPcd08RBOnqn+cDQhB+stEaD6S6s5bAOLdCDuzK7kwOgrfn8dWfp1zCOMSLAmCWPJt0xwLsSHmYzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298888; c=relaxed/simple;
	bh=N1+Z7lTXO2rp04BsKfbKtrj2Ok1QKv8CGiazBoT7hjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWvJaqOgV7/fsVmlRK1GseLMGVB1/fKZ50+boTbiF9diZCEwxxb3Hv+obJEcyxVxYVa7A8V/kk7BJ79rjS+bwA9ZSlpt9Qa41hMKg8nCnDdAvMsWczmBS/+mdWgmNI11+fVOO8GDy9tvlOlFOFFy+OOTNQkoLgrrbKEcnp0MnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dfj+0KFO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-420180b5922so43054615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 06:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716298884; x=1716903684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+1xsVOenBqGRXV+vq+cVu4jiCpn+H/2Flnt09jmSX0=;
        b=dfj+0KFOBqahPShKj/hA21fyV9XrVjLvgfRVwafdsEmYaECQBt2vkPbVfUzZMNFrfN
         4oDZ/5gJJXSHtn2tqD78/9zpRyrdjJQ8863DJkm9Q80XS8LIwf6NFIKohjcfFSXfPdAP
         9Ji2kDH2czyCnji022nN/dxrufm4zq3JtYny1vYlrqGoqMkvh42wl8vTMtBztCy9sXHK
         zNHyrSogzA40Qb1vgdKiZvVFpwn4rtru+7pPCz5hBQSFYY+adxsRhc6Zwrc51CY/n0Ho
         R4ePUNliXvksP7B2gNFk8z00JcaFOEMwdmOIviQK+DBBak8AL1BF3Ef9hz9IRfrM+qoK
         D+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716298884; x=1716903684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+1xsVOenBqGRXV+vq+cVu4jiCpn+H/2Flnt09jmSX0=;
        b=rJX0Ki4ZrfQtaYrZMIrIfIewmrjKCiNV6JsqwEQMJr1ICEpQTaeBQLSySitR88fZ/3
         p1JGWIA3P7u5hMGBA7fCKZ0az7G3vNfpWpB4MX3Oy6GGAYtmkVeNHVZjIwhpBIZI8ryz
         9V8JGE+DERxyBL122ekM1HsZNixHMqU4BQYiPLTR5jEVvE48KG7zh9FHDK9VQrVgNZWw
         r0MiEHXlBjjqT+exhh6DcKSxVLo9GzC3rqSc4zrHhjB/Ym6LQqCx05nqqG4YDHEd9qRt
         //i2GZQCp9bSXsT3Apci94hmMsdy4iuris+UQM1ragMKq6CFaS4PRMVbUsXKIsTP1BUK
         C6AA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Zf+sqPA2TpWzHQJ/hT/nb2XRv8RvTcWQHUxeZjNlVWKnNgdanfF79win6oS7UhYq6XONVxGIz+rrWFQuAAv4sFBRk6Bs/cYRvgll
X-Gm-Message-State: AOJu0YyTwJhg9n+5Md2F22HvZbB90U2uc/n5xdHr1gKZljlawgdS+9aH
	xj5rtdVqEV1DGxGuTUuz9LLMfZJsT/dAQsdWyYL/GDAj2DqPBU8wRHqM72VLx2jPEIUz2kiAjNy
	16pBXpTE/pTuDR9r/zNrHEorHSUFV9VDnIynNsg==
X-Google-Smtp-Source: AGHT+IEHsbdyc9+JywKTd0t0PpMsBEzeUY13uoyr7VftCkfS7u3Z4jvNXqxJorAsuGUNCeaWmG6E1b/MXJC0vpgD+7A=
X-Received: by 2002:a05:600c:5601:b0:41a:adc3:f777 with SMTP id
 5b1f17b1804b1-41feaa38ec7mr320385465e9.16.1716298884332; Tue, 21 May 2024
 06:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-10-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-10-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 15:41:13 +0200
Message-ID: <CAHVXubirHPj1pZhU7sFxFTzBWz_Psf5uts9y3Dji-a03nb=_iw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] riscv: mm: Add support for ZONE_DEVICE
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:49=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> ZONE_DEVICE pages need DEVMAP PTEs support to function
> (ARCH_HAS_PTE_DEVMAP). Claim another RSW (reserved for software) bit
> in the PTE for DEVMAP mark, add the corresponding helpers, and enable
> ARCH_HAS_PTE_DEVMAP for riscv64.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig                    |  1 +
>  arch/riscv/include/asm/pgtable-64.h   | 20 ++++++++++++++++++++
>  arch/riscv/include/asm/pgtable-bits.h |  1 +
>  arch/riscv/include/asm/pgtable.h      | 17 +++++++++++++++++
>  4 files changed, 39 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2724dc2af29f..0b74698c63c7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -36,6 +36,7 @@ config RISCV
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_PMEM_API
>         select ARCH_HAS_PREPARE_SYNC_CORE_CMD
> +       select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>         select ARCH_HAS_PTE_SPECIAL
>         select ARCH_HAS_SET_DIRECT_MAP if MMU
>         select ARCH_HAS_SET_MEMORY if MMU
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index 221a5c1ee287..c67a9bbfd010 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -400,4 +400,24 @@ static inline struct page *pgd_page(pgd_t pgd)
>  #define p4d_offset p4d_offset
>  p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline int pte_devmap(pte_t pte);
> +static inline pte_t pmd_pte(pmd_t pmd);
> +
> +static inline int pmd_devmap(pmd_t pmd)
> +{
> +       return pte_devmap(pmd_pte(pmd));
> +}
> +
> +static inline int pud_devmap(pud_t pud)
> +{
> +       return 0;
> +}
> +
> +static inline int pgd_devmap(pgd_t pgd)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif /* _ASM_RISCV_PGTABLE_64_H */
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/a=
sm/pgtable-bits.h
> index 179bd4afece4..a8f5205cea54 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -19,6 +19,7 @@
>  #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
>
>  #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
> +#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
>  #define _PAGE_TABLE     _PAGE_PRESENT
>
>  /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 7933f493db71..02fadc276064 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -387,6 +387,13 @@ static inline int pte_special(pte_t pte)
>         return pte_val(pte) & _PAGE_SPECIAL;
>  }
>
> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
> +static inline int pte_devmap(pte_t pte)
> +{
> +       return pte_val(pte) & _PAGE_DEVMAP;
> +}
> +#endif

Not sure you need the #ifdef here.

> +
>  /* static inline pte_t pte_rdprotect(pte_t pte) */
>
>  static inline pte_t pte_wrprotect(pte_t pte)
> @@ -428,6 +435,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
>         return __pte(pte_val(pte) | _PAGE_SPECIAL);
>  }
>
> +static inline pte_t pte_mkdevmap(pte_t pte)
> +{
> +       return __pte(pte_val(pte) | _PAGE_DEVMAP);
> +}
> +
>  static inline pte_t pte_mkhuge(pte_t pte)
>  {
>         return pte;
> @@ -711,6 +723,11 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
>         return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
>  }
>
> +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
> +}
> +
>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>                                 pmd_t *pmdp, pmd_t pmd)
>  {
> --
> 2.40.1
>

Otherwise, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

