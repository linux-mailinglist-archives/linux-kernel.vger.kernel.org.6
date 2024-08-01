Return-Path: <linux-kernel+bounces-271672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2979945171
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D8CB22D66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20D1B4C39;
	Thu,  1 Aug 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dT7XNEeJ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE713D617
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533246; cv=none; b=LvlFIJvgjZZlKq9oyae4vo3S9EVZ39mtMIe9YluPUXDrAr1zNhiEZz0Oj3qtai77ElSo45Z5fFEKvMNRQuUJvHa8YTS98yH88k1BiITJLWZAdqYjKkHwfZvHvwwxDVRadcFCbPGGczuX347tUbYbTopw2KZtWEJ1BLly6BjH6t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533246; c=relaxed/simple;
	bh=SKTikEQiPWenoi6jsn9PESQsQpi1Q5M5JeYBJDwQhL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnVPgZ79qTKgcvk8TFryfnFknE471seGoXuuO037TH9A+csd7QKgxBRNkG/mwSBDVBR7fCE3QXmQixYXxEJY5QG1wkMca+UvOWdx0WeV31/5ZZd30Tg1R00rJSCXAnmp3G3IU/x2vjqmsOgwBZAlGuX6405vPAgAtXqv3KIslfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dT7XNEeJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so4987013a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722533243; x=1723138043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqfEz+HJ51esTeFjGcuq9d9pgxM3+keTReLtTqI2sYw=;
        b=dT7XNEeJNZz1ElaYNzHLYO0vJK+PcDaHT2e0jOCwu0sR6YYqV4NDyxKqrY9MGX3YMb
         Im8x/lCn521dWPOegCXLBh8fzioQeczXViIr4sezS+TkBEvesCulGBMrEdVoygBPbGIA
         XOF37FyTGS14MlfFQ4JsIZbsTiQe8mz8rKwUsyHQItXjIQjD4t+sSLfaAZqqTVDMdcg2
         xoXeaOfWPlRfWEEM9MCAa2OFKgfYnbYPeafpbUa7Z+62/joa5jyL4tqTLkKmmkD/N0/L
         aIt3io+i/vIXWmGOapd+znNbNOUmoVaW2QYpZz/MVefwdU0HxRo0onqeTSQ7LEtTEHBZ
         KpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533243; x=1723138043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqfEz+HJ51esTeFjGcuq9d9pgxM3+keTReLtTqI2sYw=;
        b=Wo9DcoeosSNlx+szMUgfhqMDuNmcVMf2QICyp1r9Z8QTmBcl9GqSB7BrYoGUjU/Bg5
         c+IoymS/75QMb7+ZSTuY6Tt6gCtiJx3JSvVAWRGMrhGLT8b4gbI1+dB8r0VpguySLb03
         F+n9roW/xayyuBJQ7thXZFKYYDpqkS+YZibH6OT5dmola05zPWod7shN7vD1y0p9afDj
         fpnpdXZAqZhOkcgY6HCSl8+8vJ5KVn/o4V+yUg2B2fZp1ZlugPgsPI345lg6A+PVny7i
         sPvk0GsMT91YQnMbjSMhBqEk8GXOwKu03XF8VcTGs4Up4rSasMylUNtTbaPPMcDZ0izK
         3tew==
X-Gm-Message-State: AOJu0YybjtSGVOmmQhIcswq7f3t6U/rHIQa7Cfh6tQq0Fg0HgK3rb811
	8uMunEt1/rkof2YNFLNPTdGM4WYCtErYUo2b1oJp8AGP0YvSPLwpDQIvKCl/3s8=
X-Google-Smtp-Source: AGHT+IEBSL6psp8uqwX7WC0XSgw8iBQcOzO0q+abKTudQIxbfRflqktoR6lOfpGvOhqrMQh2mFtLog==
X-Received: by 2002:a17:90a:c70c:b0:2c9:7803:1cf6 with SMTP id 98e67ed59e1d1-2cff94478a8mr1104445a91.20.1722533242940;
        Thu, 01 Aug 2024 10:27:22 -0700 (PDT)
Received: from ghost ([2601:647:6700:2d90:35dc:9596:26a6:873f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf69a58sm206667a91.4.2024.08.01.10.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:27:22 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:27:20 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] cpumask: de-duplicate assign_cpu() API
Message-ID: <ZqvFeJVy4BpwcOjm@ghost>
References: <20240731195355.97488-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731195355.97488-1-yury.norov@gmail.com>

On Wed, Jul 31, 2024 at 12:53:54PM -0700, Yury Norov wrote:
> We've got cpumask_assign_cpu() function and assign_cpu() macro, both
> doing the same thing. We need to drop one to avoid unneeded duplicatioon.
> 
> Now that underlying assign_bit() implemented as a macro, it would make
> sense to keep assign_cpu() which is also implemented as a macro, in sake
> of unification.
> 
> This patch also removes __cpumask_assign_cpu() as the function is
> unused.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/riscv/mm/cacheflush.c |  2 +-
>  include/linux/cpumask.h    | 16 ----------------
>  2 files changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index a03c994eed3b..fa136627ccaa 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -171,7 +171,7 @@ static void set_icache_stale_mask(void)
>  	stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
>  
>  	cpumask_setall(mask);
> -	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
> +	assign_cpu(smp_processor_id(), mask, stale_cpu);
>  }
>  #endif
>  
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 801a7e524113..f896c6ffa78e 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -534,22 +534,6 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
>  	__clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
>  }
>  
> -/**
> - * cpumask_assign_cpu - assign a cpu in a cpumask
> - * @cpu: cpu number (< nr_cpu_ids)
> - * @dstp: the cpumask pointer
> - * @bool: the value to assign
> - */
> -static __always_inline void cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
> -{
> -	assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
> -}
> -
> -static __always_inline void __cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
> -{
> -	__assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
> -}

This deletion is the wrong way around. cpumask_assign_cpu already
existed when assign_cpu was added. cpumask_assign_cpu uses the same
naming convention as all of the other cpumask functions, so it is
inconsistent with the other defines in this file to drop the "cpumask"
prefix.

__cpumask_assign_cpu is not currently used but all of the other cpumask
functions have a "__" alternative so that's why I added it.

- Charlie

> -
>  /**
>   * cpumask_test_cpu - test for a cpu in a cpumask
>   * @cpu: cpu number (< nr_cpu_ids)
> -- 

> 2.43.0
> 

