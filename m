Return-Path: <linux-kernel+bounces-257381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80C937939
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2711C20945
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA5CBA20;
	Fri, 19 Jul 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T/Phr9kD"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F5EB669
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399609; cv=none; b=D6vAZbkWJLpRlSJ0O5MV5Azizi+SAlzi7UZC8b4gITj2sWOgAx9PeozKfpHvNMLA0zVKtVs5siwUx/QRjqWQYClb9KH2UrAYBhk7fStwDrVGSSH/I7zPxYDHddTGYkuxRspnz/rOILurOjkEaFd3kqIAYb0lwsKloerpUoxDkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399609; c=relaxed/simple;
	bh=YcZ8QPiu7uiqWdffMqLUuBGBDFcAbUri0b/RUxYwi6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVXX3lqNjNlUZaP/ztblK4z3jqgThX1HiPOAXIys5M+2wZAqKKcN+/mV7CK/QpJZLgC5emhVQirVzpPdCxg1bERtUnqhV5d/WuBT1E67t3NJ15CJ2ThCLX5G5CVpgwFx8KxAejaPZs99IsKPvS0XlrJpGg+zEzJ9FFF3y6a32Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=T/Phr9kD; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-80767b21543so84843039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721399607; x=1722004407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+5kSwJTva1eAns96uDyGpry7vA7DpXDv3rx/8QGIlU=;
        b=T/Phr9kDTg1kKP6fszObKHjXLewUFMrB5la1TfrSDRtFq9MM/hNRT1sFxFZgO26fWj
         p9sSqBVeOmFd/66OU89B61YbHfiiXnoEH7bvQ/pa+/cZT2ny7/9K1XUsHBLvR8yEh2S/
         O20oe9l1pnM9hzozWPhVJugWmxXpoOY57hFfYmGTI30rZuT3sIBISsxbsk8cM9TwqdXE
         0dyC65I60/O22LEqllIkHMuVpZt1a4xt08AejxY1uW0P3UjFaw6mB8Xc7oaLGBYb+peA
         AGEnQAqnpFaHD4PgZ/d41GbSckdqPgZqaEpp+SVcvkRJFJ/QP74ydp29MAKTFdoxs4Vn
         UVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721399607; x=1722004407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+5kSwJTva1eAns96uDyGpry7vA7DpXDv3rx/8QGIlU=;
        b=W09YqoCV+X10lWPVm2F2uUT08Dr3seaNKMthxPdILINOOpmT14tE77NKJeuDy37jdW
         s+cb0wn3wd7CXsAukoqhQUofkpTrz5ryLE/hI+uE0d0iuuJAYbQC/OwhhKblpFz46ZMw
         /iZUKZ1XXqJH/evhl+0ki7SBY2aF19qSSfglyFKN0ptOZE58FvvX3IxjY4nwX32YZ/tD
         vevM8eI8JSJ7ZAHSMIAEi6NyiEeSQQtJ7J9YG7F1epb0F3kFRZj7YrgiibvEnTOZJmU5
         CIKyk9/9fxllfopuTJVAmLqxRPS9leUUZr5A9YpFCNZp37FG85j+SGzkqgm47RPk2fKy
         0IsA==
X-Forwarded-Encrypted: i=1; AJvYcCVSuOwTXbfRvUNhzMjqJygFce1KQo1dV41+HTL3J3kTENj1qS/HnSi2CGo+Jx26lFnSDBzoWbeukCZM+Tn/V3SrLZ5Qo9n28agZs09h
X-Gm-Message-State: AOJu0Yws3Pc74NUJ1ssKtp+Tt1gTtgEBm/bE9F1P50Z9FWwCa1POkeC7
	Sln+WBCWt134QS5WVX1v/9lfwKAAbRd9TDkx6BrcWSQOQOlo5gEgO6FqbCxcwJ0=
X-Google-Smtp-Source: AGHT+IGBIH81UeXN6SlFXOdu4MLJzOYbz3k9slkbrwqR2dQNfRDz53dI22h9/1Fj7vJIqKpGwZawNQ==
X-Received: by 2002:a05:6602:1503:b0:804:fd88:3b08 with SMTP id ca18e2360f4ac-81710cc8de6mr1099772539f.10.1721399601959;
        Fri, 19 Jul 2024 07:33:21 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2343d3230sm340001173.133.2024.07.19.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:32:30 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:32:13 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, akpm@linux-foundation.org, 
	surenb@google.com, peterx@redhat.com, alexghiti@rivosinc.com, willy@infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv/mm/fault: add show_pte() before die()
Message-ID: <20240719-92015016b960e7153e97b39d@orel>
References: <20240718020935.12803-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718020935.12803-1-cuiyunhui@bytedance.com>

On Thu, Jul 18, 2024 at 10:09:35AM GMT, Yunhui Cui wrote:
> When the kernel displays "Unable to handle kernel paging request at
> virtual address", we would like to confirm the status of the virtual
> address in the page table. So add show_pte() before die().
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/mm/fault.c | 47 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 90d4ba36d1d0..dfe3ce38e16b 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -22,6 +22,52 @@
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

arm64 show_pte starts with a summary line where the pgtable type (swapper
vs. user), number of VA bits, and physical address of the pgd are
displayed. Should we add that too?

Thanks,
drew

> +	pgdp = pgd_offset(mm, addr);
> +	pgd = READ_ONCE(*pgdp);
> +	pr_alert("[%016lx] pgd=%016lx", addr, pgd_val(pgd));
> +	if (pgd_none(pgd) || pgd_bad(pgd))
> +		goto out;
> +
> +	p4dp = p4d_offset(pgdp, addr);
> +	p4d = READ_ONCE(*p4dp);
> +	pr_cont(", p4d=%016lx", p4d_val(p4d));
> +	if (p4d_none(p4d) || p4d_bad(p4d))
> +		goto out;
> +
> +	pudp = pud_offset(p4dp, addr);
> +	pud = READ_ONCE(*pudp);
> +	pr_cont(", pud=%016lx", pud_val(pud));
> +	if (pud_none(pud) || pud_bad(pud))
> +		goto out;
> +
> +	pmdp = pmd_offset(pudp, addr);
> +	pmd = READ_ONCE(*pmdp);
> +	pr_cont(", pmd=%016lx", pmd_val(pmd));
> +	if (pmd_none(pmd) || pmd_bad(pmd))
> +		goto out;
> +
> +	ptep = pte_offset_map(pmdp, addr);
> +	if (!ptep)
> +		goto out;
> +
> +	pte = READ_ONCE(*ptep);
> +	pr_cont(", pte=%016lx", pte_val(pte));
> +	pte_unmap(ptep);
> +out:
> +	pr_cont("\n");
> +}
> +
>  static void die_kernel_fault(const char *msg, unsigned long addr,
>  		struct pt_regs *regs)
>  {
> @@ -31,6 +77,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
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
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

