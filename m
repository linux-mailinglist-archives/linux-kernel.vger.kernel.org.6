Return-Path: <linux-kernel+bounces-447607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C749F34D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1390C169567
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B2E14F125;
	Mon, 16 Dec 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GYA1mccX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877614D2A7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363773; cv=none; b=ThpCb+ZVaHVmqIgG27lPqzI3OBC0f46icZYbrhoUo1iKwClK6hYBydievuXQgz3TRvuhtb3lyblWDztIGHOlcJlxfQd42esyoOYBFOVbq++gf21A4GnfIBkC4f2qj9FHmxKwlJHgxS2yxenqTsyi299ETHmsl06GwucH6oTOZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363773; c=relaxed/simple;
	bh=7J1z7zGKi8qDpBcj9GbdI/Ps2EFAVijpo5S7dkYA/fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX/o9GycMoYwW7++NIG0bQ1i5yG/PEC/SZK3xaCfum0d0pno4AiApIdp05pl+DWbl5OXIpr1QewZM6rI7+8RO2MaqUr/XPaT6i8545KlY/lBZ9GAuUioZcmd0EyNBWPf1Ol0hpx8m+Ip+oG9c7+ZizCkbin0PKyPVFVk2gIBuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GYA1mccX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso3587340f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734363770; x=1734968570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRPpIX6x1X6PfLdkN5XTWPSEZi3D2nzydsb0ntGYnfo=;
        b=GYA1mccXFfekYw5yFClwS2HBNyxCiYDs7aGMHR6JJtTR+w6kK7DSrpa7cbd2WFAvug
         XVOzE/aVwfwq4Kye3mkH3c+sxonBYti+LUSE0um66rOP7TWWeyyqNz7srvvAtOkgx2Ii
         OBKXTnZIJpoy4sAmY1u3V6WItj+lzMoI1oYYfAEsXkiODIrNe3uPceLCeQXzeW2ljast
         i5khxTfkXSZwokgLdkYDa4+Iba5YKzznaFLl1nYgETimLSz+//nPX2aMJE0gOwOWycLo
         eZSMVBoQKX8K9TVyg+822LsEkKDQfRG66q5EZ3OXVhSjvb3HoTSseFyQ2HeXc4+rNCJI
         RwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734363770; x=1734968570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRPpIX6x1X6PfLdkN5XTWPSEZi3D2nzydsb0ntGYnfo=;
        b=QUxUNa1SgibNsHNYVhO5kAI/7f3EfEas8JZ3ln36joz9Mlj2ONuCtM2xLvtQ7P/sCE
         8Cp/ff62883ekc+Mu/h28lF7RaTfoj/8MHgdjKzu8kRXDdHGl1uhmmCuFUDhwK2YFa6J
         fUoMumr2VQEAJNCLxQQJ1kzI2ZPl4S5zYrb2hpDNPGLZ5kYmPM8GVjeJ7tdEqaJRKVmU
         un75tBYNxmtioykZDu2AZLZYKiJVFzHpD7WwFFFH4Ghm8YV/D84fz6GK52RkmkZ5Bi4/
         PDK8NyCqW6cMUHNb8GkY38hO239/EbOyJKQsuNHrZfgGFRcV+pVPioBmgyzH+Cmt40fq
         4QzA==
X-Forwarded-Encrypted: i=1; AJvYcCWb/XbZyTP5VeVBY3jEwUlaXfSvW1+2uFnyTKWpGRpS0rAs8hzZssdapkzHSp8ORqahlbFYIaksXUHseF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNC6PAkQB+lEMg/wNgeOhWH403STZs84mJZb7F97QxZF8WEb8
	hGfMI9c42aXdguoFGI3s7wEVtTH3QBfJP+clrV3d55XyfrAftvuHdU3YDGEM3Ms=
X-Gm-Gg: ASbGncshTTf6oVLXl5seyIIqthIE+bleYJACkp2KT+yl/Ge/tLgf3UqSGoIhYRRh4SQ
	faqrT8la2A1T6V5/gtUq49jVbUxHQ/ZRofsx6/RZp7wTwujHMKLWz3IWUz7D3VcbOdhfBYtdNXj
	8wrx6bLjupZrL+UDIXPXOqjkcUYpDXf1GQ1j9VrHrFgV9CtucWbFvsb6inpxBqoqIuF+1oeAzzi
	01v8Tk06U9M6CFTTLFo4hfmeZWWHKYsCQCpGrpt4oVCbpBqE+rweYSsGtJW0YYajmBdwMZr+d94
	tgMKNXR8OQ==
X-Google-Smtp-Source: AGHT+IGHTCJNG0wofm8YQHMVhU6jNcr410dOUPkItU01CIE2mfswJ1fwu09e8a9C94aWhKnGcE9L0g==
X-Received: by 2002:a5d:6da4:0:b0:385:fa33:29ed with SMTP id ffacd0b85a97d-3888e0f4553mr10445190f8f.47.1734363769937;
        Mon, 16 Dec 2024 07:42:49 -0800 (PST)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801b9ebsm8461313f8f.63.2024.12.16.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:42:49 -0800 (PST)
Date: Mon, 16 Dec 2024 16:42:48 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com, 
	conor@kernel.org, leobras@redhat.com, alexghiti@rivosinc.com, 
	christoph.muellner@vrull.eu, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	parri.andrea@gmail.com, ericchancf@google.com, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: Implement smp_cond_load8/16() with Zawrs
Message-ID: <20241216-2d9b35cb1911106971a54356@orel>
References: <20241216032253.685728-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216032253.685728-1-guoren@kernel.org>

On Sun, Dec 15, 2024 at 10:22:53PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> RISC-V code uses the queued spinlock implementation, which calls
> the macros smp_cond_load_acquire for one byte. So, complement the
> implementation of byte and halfword versions.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 38 +++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 4cadc56220fe..2bd42a11ff8f 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -365,16 +365,48 @@ static __always_inline void __cmpwait(volatile void *ptr,
>  {
>  	unsigned long tmp;
>  
> +	u32 *__ptr32b;
> +	ulong __s, __val, __mask;
> +
>  	asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop",
>  			     0, RISCV_ISA_EXT_ZAWRS, 1)
>  		 : : : : no_zawrs);
>  
>  	switch (size) {
>  	case 1:
> -		fallthrough;
> +		__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
> +		__s = ((ulong)(ptr) & 0x3) * BITS_PER_BYTE;
> +		__val = val << __s;
> +		__mask = 0xf << __s;

This mask should be 0xff and the mask below should be 0xffff.

> +
> +		asm volatile(
> +		"	lr.w	%0, %1\n"
> +		"	and	%0, %0, %3\n"
> +		"	xor	%0, %0, %2\n"
> +		"	bnez	%0, 1f\n"
> +			ZAWRS_WRS_NTO "\n"
> +		"1:"
> +		: "=&r" (tmp), "+A" (*(__ptr32b))
> +		: "r" (__val), "r" (__mask)
> +		: "memory");
> +		break;
>  	case 2:
> -		/* RISC-V doesn't have lr instructions on byte and half-word. */
> -		goto no_zawrs;
> +		__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
> +		__s = ((ulong)(ptr) & 0x2) * BITS_PER_BYTE;
> +		__val = val << __s;
> +		__mask = 0xff << __s;
> +
> +		asm volatile(
> +		"	lr.w	%0, %1\n"
> +		"	and	%0, %0, %3\n"
> +		"	xor	%0, %0, %2\n"
> +		"	bnez	%0, 1f\n"
> +			ZAWRS_WRS_NTO "\n"
> +		"1:"
> +		: "=&r" (tmp), "+A" (*(__ptr32b))
> +		: "r" (__val), "r" (__mask)
> +		: "memory");
> +		break;
>  	case 4:
>  		asm volatile(
>  		"	lr.w	%0, %1\n"
> -- 
> 2.40.1
>

Thanks,
drew

