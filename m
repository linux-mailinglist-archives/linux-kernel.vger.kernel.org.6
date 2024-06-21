Return-Path: <linux-kernel+bounces-223757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 200B69117D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C8FB2103C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F715C9;
	Fri, 21 Jun 2024 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zCMvXKjG"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02528625
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718931828; cv=none; b=L49XzrsdtQrqgtoda9dty2LwckWWNH+Wm9TGm5xemexEnAXszq2iTmIwn2tIPlGx4xOmRGG7v8iC61l1oS8xYtF7svKjgG/SGB1vUG4AoQ6RiwAqcKAQCVtAem1/4a5cJBiHu3T2DWiFt9rTTBdmz2Vxixvp80As7NR5f6aIk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718931828; c=relaxed/simple;
	bh=F59EqtuW5khvkB0+BXMWVfsZkm7n4ZLH60tLs4QrbkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcwWXFdhAd3GzZCyH3R6KJSLJJdV/zJYl42BldtT88T5CCtKqmwrIQJcpOd6KPh6IRFT9q+fUT8TrpXnFbaUEEZ96GdjZsexPxXGVTc6eLvttYZePBmSzLcd5w/OySiYdG5W3WCu3PA57/XffQfFGKvE1Vdb/m1fo5guS517jxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zCMvXKjG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6da06ba24so11232215ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718931825; x=1719536625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1haH7YBDu+P173UfNQ13ypdZ+PVdQ4InMnIfKHy+Oc=;
        b=zCMvXKjGuOrLecVoyDqRr1JtIX9zt0zTQ6cimZW0aXrO05XhL+eiH1Ugi66N26hCif
         9iUBVhI5nLKOSLerPkU5FIKt3ISUPQvDUyndP2rcOBSRhCQyt/PBP/QYNedsv0eH9FhB
         D8Kf6fzL6SxoSUQFunCRr/GXfSIDXghIlLiKcrjDpiy75/mSOuE/fbzMulialXp1EsUF
         Zgxb7dPVgY4rAZu3Z0pjrF8aWYLegKDgTcRR/JVEtUCaredDj33DzarvH9c+p7nlpfCf
         pvUOZcDb8/+j03e49c0ibx5GAEwOO7QjeH440xg+YEQYcFBPS3fNEPDUcd4aJ6klcJ96
         K88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718931825; x=1719536625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1haH7YBDu+P173UfNQ13ypdZ+PVdQ4InMnIfKHy+Oc=;
        b=Mv9Q+KFVM6nTwCOb9Q+loz0FVFvCl6vHL6xsPwnsgBEluBbxoub24P0ZTSzCAYdguX
         //zsNYalOZXD8/Q8oiM7hW+U4jcXweGZHhJ7CtgdsIz+t7eyB07hmTXEE3FfO2zeIDyp
         Q1POOGZQE+yX0kk56NdywoBVSYtCacd73mN0X64muG07hrAHF/D3xqkSgCUkSuPcrmJ7
         JAk3BiOWdX87YbvFhdFlvTkUpTfVaEbdY4KRcLwBPlXfs/BztPvM90MK/GmXnw7Rg2k/
         Ob20l1qxzZwjgrowbagNP+NRRpL4vSVQoMhv4eaj8s8s1xFFA2agCU2QG8OfHXwrtQWr
         kRVA==
X-Forwarded-Encrypted: i=1; AJvYcCWVHLK1OEfzgOvaGXhkgTHYVcgQEGYnVeYHeEwHvoa66lCLhmRXtSD/D3rfeYU8DV1NO3IrjCgHKjbJ8+LvdMRwXbiz7/mIAS5GfpXJ
X-Gm-Message-State: AOJu0Yxq1kHPZt0RsbxRnODjCV19hK4hSrpnqGafsN9Htbfc2ZdDG12d
	sa3yJJl3NWJUcpsFNvSpoULjTsktUR9YGVNLqzkgq9l2Mdfkm1/CNQL30M6Uszo=
X-Google-Smtp-Source: AGHT+IGu8qLWME7uH03Xg6l6zR9dVoABsK411ijDXY+wd3PmxDALgviUPmuQn9akpQ/LqS6WroNeCg==
X-Received: by 2002:a17:902:da8e:b0:1f7:6ed:7389 with SMTP id d9443c01a7336-1f9aa4802a7mr84132235ad.66.1718931825123;
        Thu, 20 Jun 2024 18:03:45 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c6ca7sm2390805ad.177.2024.06.20.18.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 18:03:44 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:03:42 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com, akpm@linux-foundation.org, bhe@redhat.com,
	rppt@kernel.org, dawei.li@shingroup.cn, jszhang@kernel.org,
	namcao@linutronix.de, chenjiahao16@huawei.com, bjorn@rivosinc.com,
	vishal.moola@gmail.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cmdline: Add support for 'memmap' parameter
Message-ID: <ZnTRbptoowL+1GOP@ghost>
References: <20240618120842.15159-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618120842.15159-1-cuiyunhui@bytedance.com>

On Tue, Jun 18, 2024 at 08:08:42PM +0800, Yunhui Cui wrote:
> Implement support for parsing 'memmap' kernel command line parameter.
> 
> This patch covers parsing of the following two formats for 'memmap'
> parameter values:
> 
> - nn[KMG]@ss[KMG]
> - nn[KMG]$ss[KMG]
> 
> ([KMG] = K M or G (kilo, mega, giga))
> 
> These two allowed formats for parameter value are already documented
> in file kernel-parameters.txt in Documentation/admin-guide folder.
> Some architectures already support them, but Mips did not prior to

Copy-paste from a Mips patch? Should say riscv :)

It looks like this code is duplicated from xtensa and is effectively the
same as mips. Can this code be placed in a generic file so that the code
can be shared between mips, riscv, and xtensa -- maybe a new config that
gets selected by mips/riscv/xtensa?

- Charlie

> this patch.
> 
> Excerpt from Documentation/admin-guide/kernel-parameters.txt:
> 
> memmap=nn[KMG]@ss[KMG]
> [KNL] Force usage of a specific region of memory.
> Region of memory to be used is from ss to ss+nn.
> 
> memmap=nn[KMG]$ss[KMG]
> Mark specific memory as reserved.
> Region of memory to be reserved is from ss to ss+nn.
> Example: Exclude memory from 0x18690000-0x1869ffff
> memmap=64K$0x18690000
> or
> memmap=0x10000$0x18690000
> 
> There is no need to update this documentation file with respect to
> this patch.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/mm/init.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e3405e4b99af..7be7ec3092ad 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -208,6 +208,56 @@ static int __init early_mem(char *p)
>  }
>  early_param("mem", early_mem);
>  
> +static void __init parse_memmap_one(char *p)
> +{
> +	char *oldp;
> +	unsigned long start_at, mem_size;
> +
> +	if (!p)
> +		return;
> +
> +	oldp = p;
> +	mem_size = memparse(p, &p);
> +	if (p == oldp)
> +		return;
> +
> +	switch (*p) {
> +	case '@':
> +		start_at = memparse(p + 1, &p);
> +		memblock_add(start_at, mem_size);
> +		break;
> +
> +	case '$':
> +		start_at = memparse(p + 1, &p);
> +		memblock_reserve(start_at, mem_size);
> +		break;
> +
> +	case 0:
> +		memblock_reserve(mem_size, -mem_size);
> +		break;
> +
> +	default:
> +		pr_warn("Unrecognized memmap syntax: %s\n", p);
> +		break;
> +	}
> +}
> +
> +static int __init parse_memmap_opt(char *str)
> +{
> +	while (str) {
> +		char *k = strchr(str, ',');
> +
> +		if (k)
> +			*k++ = 0;
> +
> +		parse_memmap_one(str);
> +		str = k;
> +	}
> +
> +	return 0;
> +}
> +early_param("memmap", parse_memmap_opt);
> +
>  static void __init setup_bootmem(void)
>  {
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

