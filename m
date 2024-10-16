Return-Path: <linux-kernel+bounces-367626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6A9A049C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCD51F268CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085222036E7;
	Wed, 16 Oct 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dJLer9UG"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E311865E2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068549; cv=none; b=ZIhOaiFWM8z3Xh8b85sGgzJMrXHXiz+MN2y+J9SXrGRUSS/cvdJ/3OXbR4A+JyX4Nsg32hv1BnPX68nNBCeJg226LMY0cud0D1UVoBfqTTb6qg0MMftH1VU0z0TlGvrtgpgn8jN13r7skWPxC0IzOxpIpeAuWmhtgXsKnMTz1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068549; c=relaxed/simple;
	bh=JNdecXlVBjpt105dLJ8bY6z8Z1Yc45TzZ+/TfYyxcMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRAaDw57Ob3F+puKLDe0g+wlOoT7u96Kd377A53UipFoWsv4bl4VIiWENjP27g97DaglTWgG8TSByi7bKlQgaqx+tF0YCb7TynisAKtYzr0i1YN7+olv4WX3R4qeUm6eusE6pb67T2Kv9wxteBgAL6Iu+d0DVzQ2A77Nnd8uDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dJLer9UG; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7180ab89c58so69168a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1729068547; x=1729673347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhbVQyfRkW94fc9SRqBIvGYEHn8LmJMPO3GJTuoNbLk=;
        b=dJLer9UGV7iWkmsfaTffqfX/1nCc0fT/tA7UBR47czI3K4LlMMipkNbC8QceEzU7OR
         JIhqEka6j1wZLbuYTk8OX15+EaNXQnpY3EMXRBOU/azJGaxmfQrM+Kg9z30wnR3IKSHd
         8YHMQPjm/coi/IxwnYUTas7QKP2vQyisBaGX3NtFva9492V+gaNjkm+z99Gz6qKdPhjP
         xCi732KWdCcXHRvjz+mQyw1birp9WDMHkkxicRGdRh5juAywbl0NguBZeRSgQDewG1pj
         pePvYMzsIHaryA772JYFvSYCNlJIhdDhy7pF4UHRVlKY8Hl3L4QaGu1EuPferpLUef5Q
         XpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068547; x=1729673347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhbVQyfRkW94fc9SRqBIvGYEHn8LmJMPO3GJTuoNbLk=;
        b=tPxRan1vjvxbQNtSJBkfxlriopcf8IpqwFb4CeI0lrAqFH+Cu5ES+lKcN2P2ICIbP2
         TE5zfHFAzalg+qsBWuRPU/4Oe6QclAZyHfEGtmUPKiauS+RXI9Ap9ytswgXAqWqkyocJ
         2wWB1eQE9vuVuyZ4CudKeA913ZmOpF+YhMIVct3lIqW5LXbKWhzq5G8+s/o38ek6YFin
         ZuQXcGmbeUiKqJuArptmsxerLP1HRH2y2BcuO2J+VF5hAsG7hQ0Fbn5dQ/DCQr/SBdyU
         ApkJ/MPuUdV/I2diLFmWZcwBFgZ5fjdDkXWOIgJCc/Y+t9kLM9qgx9H9dwNzTtQjGzF6
         v7cA==
X-Forwarded-Encrypted: i=1; AJvYcCVh6qW1OBoA/WSmonndAOeH+hCEf0shSOZ6Jsu2iTIx222Lp61l+LWUemFCWitbaymSJki3J3S5b0CGUmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lTfz2b7ealyyNL3JxF0a+vtVVdRI02HQZnLzpn5AIL0CzSic
	azgd2URFBvn8KYoqvXCwNQuqgnMS2gKLKQ4xTxmbpmGMYSdhxdXX3xKSYnuhS/A=
X-Google-Smtp-Source: AGHT+IHX6rhmfA7N9aepcCXGWg+aLVBjn3PwoP8vJv4Eo4/lvnu7ZU5x91ThivPntsl/7ggjwaAxNw==
X-Received: by 2002:a05:6830:63cb:b0:710:f38a:191c with SMTP id 46e09a7af769-717d6411af5mr16721457a34.11.1729068546855;
        Wed, 16 Oct 2024 01:49:06 -0700 (PDT)
Received: from sunil-laptop ([106.51.192.229])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eb4eee7f3csm651965eaf.47.2024.10.16.01.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:49:05 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:18:55 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
	conor.dooley@microchip.com, rafael.j.wysocki@intel.com,
	haibo1.xu@intel.com, jeeheng.sia@starfivetech.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: ACPI: fix early_ioremap to early_memremap
Message-ID: <Zw9991h7QtX2S__m@sunil-laptop>
References: <20241014130141.86426-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130141.86426-1-cuiyunhui@bytedance.com>

On Mon, Oct 14, 2024 at 09:01:41PM +0800, Yunhui Cui wrote:
> When SVPBMT is enabled, __acpi_map_table() will directly access the
> data in DDR through the IO attribute, rather than through hardware
> cache consistency, resulting in incorrect data in the obtained ACPI
> table.
> 
> The log: ACPI: [ACPI:0x18] Invalid zero length.
> 
> We do not assume whether the bootloader flushes or not. We should
> access in a cacheable way instead of maintaining cache consistency
> by software.
> 
> Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in different address space")
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 6e0d333f57e5..2fd29695a788 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
>  	if (!size)
>  		return NULL;
>  
> -	return early_ioremap(phys, size);
> +	return early_memremap(phys, size);
>  }
>  
>  void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
> @@ -218,7 +218,7 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
>  	if (!map || !size)
>  		return;
>  
> -	early_iounmap(map, size);
> +	early_memunmap(map, size);
>  }
>  
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil

