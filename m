Return-Path: <linux-kernel+bounces-195597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D958D4F08
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD65287A57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB75839E4;
	Thu, 30 May 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IVhT6Y7U"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002313212C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082785; cv=none; b=iVUaWKITLxWbcVRVIiS8xHrLogYb8LbuJy8PHzm3HnL7oKVE42Jl6oamstSUGxVONG4PiDaexPKWU7k8qQMnsSbfxk5Fy50MLkG7JAokxawXxQviksQZ+b6BOGse3G9+Lp95n0mW/5XA2LXt4RSrmDy33WJ8omgXLk9UntUS1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082785; c=relaxed/simple;
	bh=HsHUzub0lSnVn0gJzJ62v1Lo3pYfUjxINEn/xRpZA1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7UaS/BIZKduFyyTuK9dVHsZKtLRd86X8zePVOz9PgDYwOvPFxDpSnDudWRmTZPZ3D67/2Mwd3Ou0cRbsrkf3LJrxj22MUp2hGhkWMcqqSnPo/VjUrNQ9nE9wK+Yy8pSIfjDq9NNB1G9YAzLMTdLsS6LTPZLReInZ73tdDHk99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IVhT6Y7U; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a2ed9af7dso239130a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717082782; x=1717687582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qK1eODKr+VZ1mrDwGWRLYcMsvv09/V4hpP4+d6jQWaE=;
        b=IVhT6Y7U/l/ZLWy6ekEuwSmJF/hdRxqaGsHskAfpFeVl5xDvVk+jEtzpYzCak+YvCr
         jxitQ7eLgDdy6HFmShdOLTnmWwOdh7o8BupBbK8C9kBlRgxluIa6RScl7jpzGm8howxJ
         6e1vaCcLX41hOVIKse6eOLlfKv+I+w6zyGGoSR92DNtx8FYpEocmRt7Bl3kcSEXSqlYn
         QhGPqjgMNOVKmKo9m8uTX+KnGEvj3SesRgEDxrkINrCozrJ6o4py26G6Ay/Y5nMd9IW8
         Px/2lhNlzgnPquZmD2RmZQhpB/QU+Hb/owLTEiZjvf/pepSAcIIm+WvC/5xvGwe8GMDX
         9ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082782; x=1717687582;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qK1eODKr+VZ1mrDwGWRLYcMsvv09/V4hpP4+d6jQWaE=;
        b=BqjQV0khFULDNa8bA6834sCKTdndv74DjLQLFMoUQyyK5mvfqDKvehYT3IFkHZt/UQ
         EOhw8Cb1HWUEWzyvsbMRmRwL/PpXKN7pxxDsiZSwpIni4M+kLXncojqhgO3AVTdL9PjU
         lyisGpMNy0YHJ4q9qzMfsGr3fIp6v8bjzOyqQ86amkIpsps2g5y4lWDWXM+v5sRhbq+6
         CxqkddCs+UGgGo3lz+5oNxF8+ZeoNKFQvPKG7h8CaCTlaj0Q0M1i9hDjAFJ4iDVZLqcj
         1XpG8obc2SjAS0Cd0eGRJTiuyCWMrj4wTHfCueIhio7d1lR/kxMls5NQAsgsvt13vDOZ
         dsHw==
X-Forwarded-Encrypted: i=1; AJvYcCVld86tz5rbbF9YllkKyo73rHVzTQSJbKGTO9nX5TpfzsRNoCl8viNlI142uClZ70ETVExyGLRSFBNBHoW/Tl37pzBkiy5RCGRtqsdc
X-Gm-Message-State: AOJu0Yyq1ARV7ffrITbsgMnGDYh2Y5hbNUtczRylPjUXrhW84yFqXYFT
	IwVS77CaD6b/TGfkPixoxFpq+N1jjTyQClnjmDR9g+2bBYGI5eAa9l2gNWMO0Co=
X-Google-Smtp-Source: AGHT+IEGJs5iV6eowXaXUOY1I4Kqd8HU+3A8SA2bF/WmOFUpd4Db6ocMdV5zunNQPrP0uHwh5JzBDg==
X-Received: by 2002:a17:907:9495:b0:a59:cc9b:d6f8 with SMTP id a640c23a62f3a-a65e8e797f5mr310825966b.39.1717082781615;
        Thu, 30 May 2024 08:26:21 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:a23:f1c3:862a:5eac? ([2a10:bac0:b000:5de0:a23:f1c3:862a:5eac])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f969sm827690066b.101.2024.05.30.08.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 08:26:21 -0700 (PDT)
Message-ID: <ca6c512a-c9cd-4210-bd71-c72c729c95a9@suse.com>
Date: Thu, 30 May 2024 18:26:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86: Remove the prefetch() specific implementation on
 x86_64
To: Youling Tang <youling.tang@linux.dev>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Mateusz Guzik <mjguzik@gmail.com>, Youling Tang <tangyouling@kylinos.cn>
References: <20240529032059.899347-1-youling.tang@linux.dev>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240529032059.899347-1-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29.05.24 г. 6:20 ч., Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> After commit ab483570a13b ("x86 & generic: change to __builtin_prefetch()"),
> x86_64 directly uses __builtin_prefetch() without the specific implementation
> of prefetch(). Also, x86_64 use a generic definition until commit ae2e15eb3b6c
> ("x86: unify prefetch operations"). So remove it.


So this patch just ensures the x86-specific prefetch() implementation is 
defined only for 32bit case, otherwise we have it defined for the 64bit 
case as well but effectively it's not used since ARCH_HAS_PREFETCH is 
not defined for 64bit, meaning in the 64bit case prefetch() is still 
defined to __builtint_prefetch in include/linux/prefetch.h.


In essence this is a purely cosmetic cleanup , am I right?


I compiled a file that utilizes prefetch with and without your patch and 
the generated assembly is identical.


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   arch/x86/include/asm/processor.h | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index cb4f6c513c48..44371bdcc59d 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -599,9 +599,6 @@ extern char			ignore_fpu_irq;
>   #ifdef CONFIG_X86_32
>   # define BASE_PREFETCH		""
>   # define ARCH_HAS_PREFETCH
> -#else
> -# define BASE_PREFETCH		"prefetcht0 %1"
> -#endif
>   
>   /*
>    * Prefetch instructions for Pentium III (+) and AMD Athlon (+)
> @@ -616,6 +613,10 @@ static inline void prefetch(const void *x)
>   			  "m" (*(const char *)x));
>   }
>   
> +#else
> +# define BASE_PREFETCH		"prefetcht0 %1"
> +#endif
> +
>   /*
>    * 3dnow prefetch to get an exclusive cache line.
>    * Useful for spinlocks to avoid one state transition in the

