Return-Path: <linux-kernel+bounces-259219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209E9392D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB27282805
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339F16EBE2;
	Mon, 22 Jul 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WTi4lnEs"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C428370
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667358; cv=none; b=fcrq6fOOKYIEfxSAGoiGchkxu8uQ5FcmrxmEjRk3gRhv98KKzyd6CYCfN44+MWw4sImjpZJkFOGlK8TUASXO2TBXUYvrVDX5cK6FtZXYsKlnEGZIYbaUUYmdwFAPSMT8OQlI+R+dtE6vG1qUB6+aDXmRv9WaLxvPyaDk9Skn3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667358; c=relaxed/simple;
	bh=EJtmWGLIOeUPIssOnX8nd/7iDUgtONlIt/2w99VfCk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPV9yoTsQX+cMTeWgCVH+ti0xTEPEXtzoC3fFuAtZfrswmDvdLVKzvwIVcy35a9zTdZEQC6no9j+8GthNXoKyQVIyT/+hWWggFBd2qM6c/lVwnCRQmhMXcLYrWYmb+ogzcJbAK7iTU+X3af6IUqidiGxooGx8bKNylSUFc7Af7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WTi4lnEs; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f684710ff5so131478639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721667356; x=1722272156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJpVkFcz3oaAIdPa6wr9FjtOTD92km5BRGfQ47Tp1rg=;
        b=WTi4lnEsAGs212Y0Lv2ipwqoVyUIDqCPOCHZIEFN4j4swYSshF3aj3T3E1rEDO2Hno
         cFaxihqUtv9sXQiXPBX8UrR79hGvEdHh5DK/OUwUuMe46fMLjJo1YL5hZeuhw7UvFnvb
         HwoxtMGR5WGHbAk5zVFlLdENzEyiBLbzLZJ8bxLQO63ozIOvqY1YAYeyikO7DzRviocq
         RNOy7E7b6NLdGnbKSiKbLoWHG7itvvnUm/0FBmjHVOQLLkIndItFO8tr7MwwyK+3Gkm/
         avApG7IVuJ5QlVOWF6nFyBEmI1b508reHh86uYsG3c2XPDwHot9UdUQn8ULwA8qfjx1c
         tDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721667356; x=1722272156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJpVkFcz3oaAIdPa6wr9FjtOTD92km5BRGfQ47Tp1rg=;
        b=clCReLxdeIJUqILWgLCDZ3XGPXe6VvfRrZhghyXAuQz/V6+9dOA6fsGq19uOSbkivx
         TOGH8vnXMMU9wDl+F774d6Lff85L0BZGS6MZpvdv62I1phLAdTPZliGb9OHRZQ8OhU4H
         kjT6WWdnz4Zsngno8BjNEpwYnlz31claOabL6lt7EhPlpbbMLruYkvbXv8kCpnn6bxN1
         BEZvMQjkyTteQI0tnbGl+8+syjv3kl/pBFZCA412WwoAT1BkbHS60Erjz8JmK68PiczT
         Tl1PFb/a2zLS5C7f1euNHQbYvMtk7c3I6eTUrdjE5TWhIxG3pqwQAibpyBkBrSuN4CMC
         2gBA==
X-Forwarded-Encrypted: i=1; AJvYcCW1c81pJeH0upZnz4IleuSO3R9MrCQoYg4a9k2VfVcRrk2pugL2/88w2p/fh05rvWcTfFdguNkr0yMAsGbv4iRuOhEq2ILCp1iiKKWH
X-Gm-Message-State: AOJu0YyXZuTkDHQ7HFuOk+yB5fMxUaZ3+o4VFlW3a+8DV6V8x9eVTUWi
	ue2DVrU4d8CnXJa7U5Sh9hdYnXiHaPTfGiNQjZ5QX5p8wOgiVVyD6KC9M0VDB5c=
X-Google-Smtp-Source: AGHT+IF6DZcN4m8qC/kqVtmMb4RhqugcHjLxIwZZ8uE+ZCC+rM98YEmL0kMFn4CSRlFeKKenBvE4TQ==
X-Received: by 2002:a05:6602:27d2:b0:7fa:244c:bfe9 with SMTP id ca18e2360f4ac-81ab6a10342mr675109439f.1.1721667355857;
        Mon, 22 Jul 2024 09:55:55 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-819aba10e3bsm253873339f.7.2024.07.22.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 09:55:55 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:55:54 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org, 
	surenb@google.com, peterx@redhat.com, alexghiti@rivosinc.com, willy@infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv/mm/fault: add show_pte() before die()
Message-ID: <20240722-a0d01590ba9ec0e0cc18ac74@orel>
References: <20240722042037.27934-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722042037.27934-1-cuiyunhui@bytedance.com>

On Mon, Jul 22, 2024 at 12:20:37PM GMT, Yunhui Cui wrote:
> When the kernel displays "Unable to handle kernel paging request at
> virtual address", we would like to confirm the status of the virtual
> address in the page table. So add show_pte() before die().
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/fault.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 5224f3733802..666d282a8bf4 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -22,6 +22,58 @@
>  
>  #include "../kernel/head.h"
>  
> +static void show_pte(unsigned long addr)
> +{
> +	pgd_t *pgdp, pgd;
> +	p4d_t *p4dp, p4d;
> +	pud_t *pudp, pud;
> +	pmd_t *pmdp, pmd;
> +	pte_t *ptep, pte;
> +	struct mm_struct *mm = current->mm;
> +
> +	if (!mm)
> +		mm = &init_mm;
> +
> +	pr_alert("Current %s pgtable: %luK pagesize, %d-bit VAs, pgdp=0x%016lx\n",
> +		 current->comm, PAGE_SIZE/SZ_1K, VA_BITS,
> +		 (mm == &init_mm ? __pa_symbol(mm->pgd) :
> +		 (unsigned long)virt_to_phys(mm->pgd)));

nit: unnecessary () around the ternary.

> +
> +	pgdp = pgd_offset(mm, addr);
> +	pgd = pgdp_get(pgdp);
> +	pr_alert("[%016lx] pgd=%016lx", addr, pgd_val(pgd));
> +	if (pgd_none(pgd) || pgd_bad(pgd) || pgd_leaf(pgd))
> +		goto out;
> +
> +	p4dp = p4d_offset(pgdp, addr);
> +	p4d = p4dp_get(p4dp);
> +	pr_cont(", p4d=%016lx", p4d_val(p4d));
> +	if (p4d_none(p4d) || p4d_bad(p4d) || p4d_leaf(p4d))
> +		goto out;
> +
> +	pudp = pud_offset(p4dp, addr);
> +	pud = pudp_get(pudp);
> +	pr_cont(", pud=%016lx", pud_val(pud));
> +	if (pud_none(pud) || pud_bad(pud) || pud_leaf(pud))
> +		goto out;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	pmd = pmdp_get(pmdp);
> +	pr_cont(", pmd=%016lx", pmd_val(pmd));
> +	if (pmd_none(pmd) || pmd_bad(pmd) || pmd_leaf(pmd))
> +		goto out;
> +
> +	ptep = pte_offset_map(pmdp, addr);
> +	if (!ptep)
> +		goto out;
> +
> +	pte = ptep_get(ptep);
> +	pr_cont(", pte=%016lx", pte_val(pte));
> +	pte_unmap(ptep);
> +out:
> +	pr_cont("\n");
> +}
> +
>  static void die_kernel_fault(const char *msg, unsigned long addr,
>  		struct pt_regs *regs)
>  {
> @@ -31,6 +83,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>  		addr);
>  
>  	bust_spinlocks(0);
> +	show_pte(addr);
>  	die(regs, "Oops");
>  	make_task_dead(SIGKILL);
>  }
> -- 
> 2.39.2
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

