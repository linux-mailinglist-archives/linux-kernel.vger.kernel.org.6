Return-Path: <linux-kernel+bounces-195191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA258D48AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D1E1F24BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D31474CA;
	Thu, 30 May 2024 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OKwOr0OP"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9346F316
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061731; cv=none; b=RTSDL73JsKOC7fuYNk4khz/kqz8TZI+FTnYdCTuedLXeJrUq6/5Y+fjdhXVWiIdFKMV8gof9lMoYovtOUEHC92K5TCvl7R7CFwDIGhRrf6yjpDbxP6Ea/jPCEYtblFEwzZCVH+nrI3lwLwU3cukYSQQ36CvrtCuhOdDZNCDz4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061731; c=relaxed/simple;
	bh=fjkXIremmoZmlou8OGomK4d7XuR+f9e1/ohh3sWxQWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+c5lR5ducTld5uY+mi+1EVVw1nlt8PX9UHDRv14+poPy2U0iIVFU5ITj28Xfqdto10hDgW92vfYjwFFJ5hRIr1HVW6z+34BDrDFMaJabML6B4l+bY2QaSdECzxsY3m0VxROkBpE0u9nPpq1CfKfXqiLDHZNIxAgYJMNxNMGfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=fail smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OKwOr0OP; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24ca21014ccso326797fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717061727; x=1717666527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIKK60Me9RhDM5LPzOVIbg3hAvv72+j6Tp3QihasYZ0=;
        b=OKwOr0OPhgIovH6ETpTz4mJfPB19eY2jLtiFdOh1RQVmqNHOMVqoM7UMGVC39Fy1m9
         Mlw1QZF6fG1OayhLymZyu6PGY2vpzas8LrsWfnvUwYw/8oN6OBueJCHYTR1dYeybBSjp
         ++ugn405rm1bDlPletv2oLVXjl/I2GB69KrRW+qv+imMfQlh/pDdq7Siwxi3y/vTp4IM
         3f64Cj7/Kphj/s/6E+UO/wVq0BZepc+cpHmaTbyl6PxfkgnhuIHeCkvSnmCsrNy9XbIl
         8fCZfM+6Du8TfdwvazLd1qC8VYA0yViDz+MjPtDxWAv0p0BYzLabjZToD7JsqqcN+K2K
         +ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717061727; x=1717666527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIKK60Me9RhDM5LPzOVIbg3hAvv72+j6Tp3QihasYZ0=;
        b=Md0h3eb0AHX+LN94aum9zlvPwOdyN9WQNPNnjxDvvr5l8fjrRu0bFMRFBBtfmtw6vu
         fda8m5Ui9YuruLU0ZAeZ8qZpq1E09BmOYqDnMAD0sLfZwrqaE4C6ZDTot6s6seo8eUDj
         k16pkiq0dUvrkppD8k6p9Qga7wgHEFh2RHhCGl59DDzwevFRe4KVgZ0r242Va2VkTFW6
         +bbXe6e0j4GHBt5SCQ1cM18iA3WUbqnaFmvtizOcgK9c4ILRDqTSmmu2xxq5atN7SYcV
         N9U86G5Y97DG3X7nKnSHnLZ5aLzEMqMQsCTjuTkh6FbjJMsjNoxViwMvz6xbmfQ7X7Dt
         jtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4LrAnSsvn2Vj4mKgyHKVOiVxkthH1ansv5dTj6IcNxu0lD74z6vOUkxVa6/0Chm164G/oMwfJNYXIqwxG/pyq7Tpho4scv2pwKAdG
X-Gm-Message-State: AOJu0Yy8ykR60jwZjkRMxWOHUIn38LDK2tIhQ3cgRISx2KwLhUY5YqsV
	dZxvp1xp7rw0+ai1DYoMUuTEAF3bu/Ul7U/zF3PKAhuivfue52RnhmJfpPulEVbblEPqDscvxXZ
	1O/CctFhkKzxP3zw7lcDetJAeGY6ny6Ryg1iviA==
X-Google-Smtp-Source: AGHT+IGQo/4+Bcec7GR4w4t9VuGgDnfgRuIzi4gbmVB9EXNZxFk4++tYC42KZVEUtna/+lcQBmHO84N93cneyoHhbbs=
X-Received: by 2002:a05:6871:3329:b0:24c:ac96:ac78 with SMTP id
 586e51a60fabf-25060de9e8amr1722957fac.44.1717061727430; Thu, 30 May 2024
 02:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131155929.169961-1-alexghiti@rivosinc.com> <20240131155929.169961-5-alexghiti@rivosinc.com>
In-Reply-To: <20240131155929.169961-5-alexghiti@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 30 May 2024 17:35:16 +0800
Message-ID: <CAEEQ3wnmCr5NTEFo3wTN_zWse2DPkE6ieVUk_=Vv7A-UzDCCvQ@mail.gmail.com>
Subject: Re: [External] [PATCH RFC/RFT v2 4/4] riscv: Stop emitting preventive
 sfence.vma for new userspace mappings with Svvptc
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>, Dylan Jhong <dylan@andestech.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, Feb 1, 2024 at 12:04=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
com> wrote:
>
> The preventive sfence.vma were emitted because new mappings must be made
> visible to the page table walker but Svvptc guarantees that xRET act as
> a fence, so no need to sfence.vma for the uarchs that implement this
> extension.
>
> This allows to drastically reduce the number of sfence.vma emitted:
>
> * Ubuntu boot to login:
> Before: ~630k sfence.vma
> After:  ~200k sfence.vma
>
> * ltp - mmapstress01
> Before: ~45k
> After:  ~6.3k
>
> * lmbench - lat_pagefault
> Before: ~665k
> After:   832 (!)
>
> * lmbench - lat_mmap
> Before: ~546k
> After:   718 (!)
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 16 +++++++++++++++-
>  arch/riscv/mm/pgtable.c          | 13 +++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 0c94260b5d0c..50986e4c4601 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -473,6 +473,9 @@ static inline void update_mmu_cache_range(struct vm_f=
ault *vmf,
>                 struct vm_area_struct *vma, unsigned long address,
>                 pte_t *ptep, unsigned int nr)
>  {
> +       asm_volatile_goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA=
_EXT_SVVPTC, 1)
> +                         : : : : svvptc);
> +
>         /*
>          * The kernel assumes that TLBs don't cache invalid entries, but
>          * in RISC-V, SFENCE.VMA specifies an ordering constraint, not a
> @@ -482,12 +485,23 @@ static inline void update_mmu_cache_range(struct vm=
_fault *vmf,
>          */
>         while (nr--)
>                 local_flush_tlb_page(address + nr * PAGE_SIZE);
> +
> +svvptc:
> +       /*
> +        * Svvptc guarantees that xRET act as a fence, so when the uarch =
does
> +        * not cache invalid entries, we don't have to do anything.
> +        */
> +       ;
>  }

From the perspective of RISC-V arch, the logic of this patch is
reasonable. The code of mm comm submodule may be missing
update_mmu_cache_range(), for example: there is no flush TLB in
remap_pte_range() after updating pte.
I will send a patch to mm/ to fix this problem next.


Thanks,
Yunhui

