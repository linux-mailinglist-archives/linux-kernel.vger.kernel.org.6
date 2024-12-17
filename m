Return-Path: <linux-kernel+bounces-449219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B219F4BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE717A58E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D801F3D41;
	Tue, 17 Dec 2024 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kV618UnT"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF61E8823
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440630; cv=none; b=SSXKb0mwNboq0ZgRJ8b8oCgL01QguJn/cnUiTPyG/wV7sO8xvWsSCj1TSw3uuXLp4ijbZWber8/y+59gfrFqy2ODQ/j5fkdE8gVIaGh6PyGcuz0A10TCnVvPi7fiTUunFOpW0L2fPma9FRL4lsUJqPR6V63Mn3orhB9/j1SsRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440630; c=relaxed/simple;
	bh=0ab1Fum3tY21d/wjpdGyxWe7Ee3RlTAj5HcwPjPO9e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trgInOCtZ4gmmhb4HmqQkP0m1juHb10OHnu6Q2ohfewVIEKSDXog9luqRdAjlz5H/izEXsj01I99G3/8eVSkJZQfRYmb/T+KQOI5GN3qfdJivzRLp9GS+U03zr4x1+uVtVF5hFH76AC94Cc9u++yX50Aj8V22xLEeNV7vn2qZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kV618UnT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so3637490f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734440627; x=1735045427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAzrzlkr4RB37/qzrBgJi3C0ocxC7xm6ioWJHZHQAZY=;
        b=kV618UnT+IO9KIfWna5bDQngNGfdXDqzf+1Qdr0mJKmDdBhOUcadG86DCNewtAHA1W
         6KEx0V9hCifKK4QrIR+Ye7mp/Lol2SP5nJ2WPuxOqQRHeX4sLVmtAEhk0efkNMlKVW1Y
         UlWWQan3ZNnFHE5dmX1qrLdCOgW2CE66lK23fw4yoiRr8Fkg/Z52XKJtp6d7tLh/d2ti
         v2jgXSYQoFLn3tEE7mNiwxbTm6l61v7vr93H3l4vgmwLCOmTYkyQzeIKLW6Si+jAQg5q
         rQCYPlBFwgwEE89Zs4ozKMq3noFfIgU1GzCDGVaYy/TH90eUU702mvhrBHHPl9KF1rlY
         f74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440627; x=1735045427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAzrzlkr4RB37/qzrBgJi3C0ocxC7xm6ioWJHZHQAZY=;
        b=oUv7iHiAgZ988Z/T/4U7bnMcIlIvujdboxJTaKw4SKiDbAi0XOslmcpIGtdhgux+KD
         zs46RDZuWT3JbgSoHGwjnqGI/LhcXRZhXUfb12VRxYd9YgSglTPlE7ClXFQcPiVtzz2J
         BhaoxZ42m4aF1iSvZclZKb41aLuwHpIn3LXG5hnfXbllpT7mj+a8bRk+hU47tX4Ft3wh
         tGisdsrOurpOnMr9ouznpAuO7WglVshbZ9CKELIVgHEsouGZZvkYqwbS4Bu8WajcbCWC
         rn/4pZCnYkE3MSmOdiqKJHQ1aJZJiG4V236SsoX7QH0m/Jg25HoDOSg3qtSQdYyYQV4r
         cQEw==
X-Forwarded-Encrypted: i=1; AJvYcCW96Btl4J/ww7d6RNe00wN5VgUIvckPnJ6Q+TO5/CiW84cgRzsqmtYRE5a5Rz3CjpazhX7OM0nLxs2iDqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy838P+NEOK2sdfvhFZjYZkyjYpVOuD7O8KjPMg6IMbXbUA08rQ
	1foin3EFZakF3HiUjrmbQNczzX68JeIRIbpuNKJv7jLOKmAwhXPA9nFOsjC55AA=
X-Gm-Gg: ASbGnct8Cjhm/vRxBXty9uB4QANxw/4SRVLse1zdOQglOSpgA4dIA91yd86Gij4pcvu
	BKyo2zgkTD2WJJrRvxRTClq1mBHwBd2EzjyE9qMDx/iI0RrgE2xBsLOGyR2gX0FFD2gZMKWh+pm
	VW2XfPR0Yd/1uBg5grZknbBG0h3nR3Ap8f/09BTjcQLfVFhgUR3v1i7F/7J6Xe1pmv5u6K74+W6
	AIM50GKE8ziWPsk6nx6YZWOsfwC5N0MA/c929VuEo78COBXolo1jV0ec4mqjAx7/bzPaWa/q+qA
	hc8nh8nWkF9M5m7HCEQP9+ybXNmTTq6w/fUYWULmsg==
X-Google-Smtp-Source: AGHT+IEKS6vZ3lyCphldOOnSEThLUJVSEi8gV34bIF+zP4H4VepebemaK38GszXC3GUeu3p2D/6jgw==
X-Received: by 2002:a05:6000:1848:b0:385:e30a:394e with SMTP id ffacd0b85a97d-38880ac2114mr14939098f8f.3.1734440626301;
        Tue, 17 Dec 2024 05:03:46 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060679sm10987341f8f.105.2024.12.17.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:03:45 -0800 (PST)
Date: Tue, 17 Dec 2024 14:03:44 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com, 
	conor@kernel.org, leobras@redhat.com, alexghiti@rivosinc.com, 
	christoph.muellner@vrull.eu, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	parri.andrea@gmail.com, ericchancf@google.com, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] riscv: Implement smp_cond_load8/16() with Zawrs
Message-ID: <20241217-aba8759654f30826104e5da0@orel>
References: <20241217013910.1039923-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217013910.1039923-1-guoren@kernel.org>

On Mon, Dec 16, 2024 at 08:39:10PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> RISC-V code uses the queued spinlock implementation, which calls
> the macros smp_cond_load_acquire for one byte. So, complement the
> implementation of byte and halfword versions.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Andrew Jones <ajones@ventanamicro.com>
> ---
> Changes in V2:
>  - Fixup mask typo (0xf -> 0xff, 0xff -> 0xffff) by Andrew.
> ---
>  arch/riscv/include/asm/cmpxchg.h | 38 +++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 4cadc56220fe..aa4410beb065 100644
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
>  	case 2:
> -		/* RISC-V doesn't have lr instructions on byte and half-word. */
> -		goto no_zawrs;
> +		__ptr32b = (u32 *)((ulong)(ptr) & ~0x3);
> +		__s = ((ulong)(ptr) & 0x2) * BITS_PER_BYTE;
> +		__val = val << __s;
> +		__mask = 0xffff << __s;
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

