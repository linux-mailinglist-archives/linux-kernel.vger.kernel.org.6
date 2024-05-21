Return-Path: <linux-kernel+bounces-185071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09A8CB025
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF43285A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B217F7C5;
	Tue, 21 May 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDdLV31M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45C535B7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300840; cv=none; b=u42rB8IMVeLqs4hRgtE3XT5CBTMY+CjmelNFy1ivNdgh2QFy9KctXWbrv6Mpe52TlPgtFdUjc7tT/b3pnBWqKjf+ESKeF3AfPSW+ARTy6OCtNQ+k4svNI10ZTsHY00cfQ1vSUHLRMz6ZPzEDmLktGRzHfb66O2kSYRQ4y4oXwMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300840; c=relaxed/simple;
	bh=IfBzG6Jslwq80j1PaUKC/nbk7dw2f5dLPW+Dn8TzDk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H941EX4qqaF8cc/mIGdNfdS1T6fX5KhsayxLBymZLtJ1ND2PepXexdHmqKMILxDHYh6mSNtQ9QphlT6cNXnPqxjC6unnY0x11NDk0jv5leAO3MXMeTt2ngg4qGLG/cFaq3dvhwi9QI3Dajr/0FQp9FdFluy+XRtH/Y7bnv2OxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDdLV31M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09770C2BD11;
	Tue, 21 May 2024 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300840;
	bh=IfBzG6Jslwq80j1PaUKC/nbk7dw2f5dLPW+Dn8TzDk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rDdLV31M/Rnssi32k8I78G80H12gj4bfX7j9DaXPEN1aX9BUsimWeZ3+kOnXz4pfR
	 KQthzpqNHet08+kfxxXHnZeMmeKBMbvK1UQpJukKPcYVOKTUE6xasKg+9d3p8/MaAh
	 qqcoqfuEt0DTPChsVyUvpCpLlnZBSWbAFQKsLWtXGaYOopGv5mnPuPiULVt90bwASL
	 8y0h+7Ann3k0lAFjAhqmVCAcWb879VbULQ0qQ2LqMezYPJIwWtlCSEw+3Ify3QQ1Lh
	 nDZjCDP/b3nGxujpdhnSLcI/76WZC0/20AtQ3lCE5861wlb213399eLa/lrT0ly4Lb
	 Q9qh9GAbQp5rQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, Oscar
 Salvador <osalvador@suse.de>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andrew
 Bresticker <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 9/9] riscv: mm: Add support for ZONE_DEVICE
In-Reply-To: <CAHVXubirHPj1pZhU7sFxFTzBWz_Psf5uts9y3Dji-a03nb=_iw@mail.gmail.com>
References: <20240521114830.841660-1-bjorn@kernel.org>
 <20240521114830.841660-10-bjorn@kernel.org>
 <CAHVXubirHPj1pZhU7sFxFTzBWz_Psf5uts9y3Dji-a03nb=_iw@mail.gmail.com>
Date: Tue, 21 May 2024 16:13:57 +0200
Message-ID: <87pltfdzh6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> On Tue, May 21, 2024 at 1:49=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> ZONE_DEVICE pages need DEVMAP PTEs support to function
>> (ARCH_HAS_PTE_DEVMAP). Claim another RSW (reserved for software) bit
>> in the PTE for DEVMAP mark, add the corresponding helpers, and enable
>> ARCH_HAS_PTE_DEVMAP for riscv64.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig                    |  1 +
>>  arch/riscv/include/asm/pgtable-64.h   | 20 ++++++++++++++++++++
>>  arch/riscv/include/asm/pgtable-bits.h |  1 +
>>  arch/riscv/include/asm/pgtable.h      | 17 +++++++++++++++++
>>  4 files changed, 39 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 2724dc2af29f..0b74698c63c7 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -36,6 +36,7 @@ config RISCV
>>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>         select ARCH_HAS_PMEM_API
>>         select ARCH_HAS_PREPARE_SYNC_CORE_CMD
>> +       select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>>         select ARCH_HAS_PTE_SPECIAL
>>         select ARCH_HAS_SET_DIRECT_MAP if MMU
>>         select ARCH_HAS_SET_MEMORY if MMU
>> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/as=
m/pgtable-64.h
>> index 221a5c1ee287..c67a9bbfd010 100644
>> --- a/arch/riscv/include/asm/pgtable-64.h
>> +++ b/arch/riscv/include/asm/pgtable-64.h
>> @@ -400,4 +400,24 @@ static inline struct page *pgd_page(pgd_t pgd)
>>  #define p4d_offset p4d_offset
>>  p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
>>
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static inline int pte_devmap(pte_t pte);
>> +static inline pte_t pmd_pte(pmd_t pmd);
>> +
>> +static inline int pmd_devmap(pmd_t pmd)
>> +{
>> +       return pte_devmap(pmd_pte(pmd));
>> +}
>> +
>> +static inline int pud_devmap(pud_t pud)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline int pgd_devmap(pgd_t pgd)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
>>  #endif /* _ASM_RISCV_PGTABLE_64_H */
>> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/=
asm/pgtable-bits.h
>> index 179bd4afece4..a8f5205cea54 100644
>> --- a/arch/riscv/include/asm/pgtable-bits.h
>> +++ b/arch/riscv/include/asm/pgtable-bits.h
>> @@ -19,6 +19,7 @@
>>  #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
>>
>>  #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
>> +#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
>>  #define _PAGE_TABLE     _PAGE_PRESENT
>>
>>  /*
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/p=
gtable.h
>> index 7933f493db71..02fadc276064 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -387,6 +387,13 @@ static inline int pte_special(pte_t pte)
>>         return pte_val(pte) & _PAGE_SPECIAL;
>>  }
>>
>> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
>> +static inline int pte_devmap(pte_t pte)
>> +{
>> +       return pte_val(pte) & _PAGE_DEVMAP;
>> +}
>> +#endif
>
> Not sure you need the #ifdef here.

W/o it 32b builds break (!defined(CONFIG_ARCH_HAS_PTE_DEVMAP) will have
a default implementation).. Maybe it's cleaner just to use that instead?

>> +
>>  /* static inline pte_t pte_rdprotect(pte_t pte) */
>>
>>  static inline pte_t pte_wrprotect(pte_t pte)
>> @@ -428,6 +435,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
>>         return __pte(pte_val(pte) | _PAGE_SPECIAL);
>>  }
>>
>> +static inline pte_t pte_mkdevmap(pte_t pte)
>> +{
>> +       return __pte(pte_val(pte) | _PAGE_DEVMAP);
>> +}
>> +
>>  static inline pte_t pte_mkhuge(pte_t pte)
>>  {
>>         return pte;
>> @@ -711,6 +723,11 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
>>         return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
>>  }
>>
>> +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>> +{
>> +       return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
>> +}
>> +
>>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>                                 pmd_t *pmdp, pmd_t pmd)
>>  {
>> --
>> 2.40.1
>>
>
> Otherwise, you can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thank you!


Bj=C3=B6rn

