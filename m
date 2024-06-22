Return-Path: <linux-kernel+bounces-225486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3F991311F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E362829F5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF27EC4;
	Sat, 22 Jun 2024 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eNM4Ie+Q"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4233385
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719015338; cv=none; b=m0kxso5onvJ8CH5/1gPRnJ/hrrj6wtcLJvexydqiMTGzX4SdVeUaIsKr2q+B/oL8vihgyFXoBTruc6t/W1PN3sZz1OQmnM+goIEsASfjn5cOEI8hpBQjPVR1K3omBSpKx5pMx3JNe79KBJfn0BAkWA19zvglCy9BT3JLTDJLUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719015338; c=relaxed/simple;
	bh=42Gk9ltosHEs3RAIIv2aCgBgUVzrXuTeoBaW5r4lUTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbWhOwjqhX8pV5DiAaL/knk26Nk9GD59t/Ql8hifx0ThayaI+JKBbL4EM+2pDh01npcO3s0MC1Cus90BJiarLCWy2NAbBIAGx2CXm778X7910DseKrCWCRPo9E1GN+IMT944RWbPqucJl9UlwYIQ8gOfOFFRKT+8BODJqr0xsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eNM4Ie+Q; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b51409093aso8813016d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719015334; x=1719620134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZHfc77+AsBI7ZIvrtDn0Ug3Hq+I59HmK7jqskjzb04=;
        b=eNM4Ie+QL7myth39FV7xGExc0VY6/f8raLWHCvEw2UJWV0eZMTF8PnOwdQm6ahT2x/
         QPrF6UEo7RGmw503+UnmBc/PFyomGKf8o3ny+csTQd0yDPAY0e4ufy8wW4I+1jME+Kzn
         eSL0wrLuimGiIyIAr5tHeYBBFtZXLYcqoIrPH84kA5nGpaCDh3f/K6h0o3Jip8UYKxy7
         qQpoTBqQmv2m1662c8TowS+dUdpViAHPEKRBNm8zpwLo15A8GSHCo9C59ZfSqmpoj3R3
         zLN/UL28oZKN7PCXC156ShB1luSGXHT3PTexzZ7Pdlt5KEwogRBHrZZsPXp6qYJc+Xsn
         ANig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719015334; x=1719620134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZHfc77+AsBI7ZIvrtDn0Ug3Hq+I59HmK7jqskjzb04=;
        b=Pg4Xokm2qwLN1la1zzUYKQPryfNC0Jg6Z93v4FB4xKZ0TJOJyNR9I22A2lHIsqZU7E
         9KAlLRbtBmrAysNyegckpgM9MGpLsxDp08f8wRn0a2BDHjsKZPwWyj/GYagZtDaaEI2Y
         CEFi3yy1wga605UWSecg+o44RjGVJUcekWLIaF/E624H3KDEedy8wd53JWOZBIKQ4E/x
         vZt6cLPq7g+QMr+bsrj2LbaHUOwppGYjQ7yguDa4flTcKptVcfo9aiGKsFi+DkHeAb08
         hvtdYFd11S8fNRdf2MBcW4Hc91GMi6+9Efi4RYS6jfDX+lLS360Wi7Z9h6OMxEs0ZC3G
         zTqw==
X-Forwarded-Encrypted: i=1; AJvYcCUUKJ+GP4NDMyRRh4lix4JMzVJgG+YxXv0npSb+3NzW3yw0VGZq2RAvPykrYtb4xAhBcAAjrCIDLN/ZBntyyfTLkyT3IQtS3FS3kJtV
X-Gm-Message-State: AOJu0Yz7PKut5SgFsjRpP/Imvx/P4eoiSemZ25/OVPo4f+hayFvjcdfn
	dsHyPke/4fO+7YyLDgfOdQo0d3cEYkUftwjgNcjJcHLRnmOy5sBE9Ib+IvzFxoA=
X-Google-Smtp-Source: AGHT+IEtfCy5irRgq406mdhqbxVK6tZ1eMVhw9yVZQWpU9YbH61bgxHPSLSuJD0F7ka6qLXmDGQySQ==
X-Received: by 2002:ad4:4dce:0:b0:6b4:fbec:952f with SMTP id 6a1803df08f44-6b501e45db7mr110916156d6.25.1719015334476;
        Fri, 21 Jun 2024 17:15:34 -0700 (PDT)
Received: from ghost ([50.236.12.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed181fcsm13145516d6.39.2024.06.21.17.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 17:15:34 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:15:29 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Anton Blanchard <antonb@tenstorrent.com>,
	Cyril Bur <cyrilbur@tenstorrent.com>
Subject: Re: [PATCH 1/6] riscv: Improve exception and system call latency
Message-ID: <ZnYXoSDCeQK0Lcz8@ghost>
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616170553.2832-2-jszhang@kernel.org>

On Mon, Jun 17, 2024 at 01:05:48AM +0800, Jisheng Zhang wrote:
> From: Anton Blanchard <antonb@tenstorrent.com>
> 
> Many CPUs implement return address branch prediction as a stack. The
> RISCV architecture refers to this as a return address stack (RAS). If
> this gets corrupted then the CPU will mispredict at least one but
> potentally many function returns.
> 
> There are two issues with the current RISCV exception code:
> 
> - We are using the alternate link stack (x5/t0) for the indirect branch
>   which makes the hardware think this is a function return. This will
>   corrupt the RAS.
> 
> - We modify the return address of handle_exception to point to
>   ret_from_exception. This will also corrupt the RAS.
> 
> Testing the null system call latency before and after the patch:
> 
> Visionfive2 (StarFive JH7110 / U74)
> baseline: 189.87 ns
> patched:  176.76 ns
> 
> Lichee pi 4a (T-Head TH1520 / C910)
> baseline: 666.58 ns
> patched:  636.90 ns
> 
> Just over 7% on the U74 and just over 4% on the C910.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>

Do you need to sign this off since you're sending this Jisheng?

> ---
>  arch/riscv/kernel/entry.S      | 17 ++++++++++-------
>  arch/riscv/kernel/stacktrace.c |  4 ++--
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 68a24cf9481a..c933460ed3e9 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -88,7 +88,6 @@ SYM_CODE_START(handle_exception)
>  	call riscv_v_context_nesting_start
>  #endif
>  	move a0, sp /* pt_regs */
> -	la ra, ret_from_exception
>  
>  	/*
>  	 * MSB of cause differentiates between
> @@ -97,7 +96,8 @@ SYM_CODE_START(handle_exception)
>  	bge s4, zero, 1f
>  
>  	/* Handle interrupts */
> -	tail do_irq
> +	call do_irq
> +	j ret_from_exception
>  1:
>  	/* Handle other exceptions */
>  	slli t0, s4, RISCV_LGPTR
> @@ -105,11 +105,14 @@ SYM_CODE_START(handle_exception)
>  	la t2, excp_vect_table_end
>  	add t0, t1, t0
>  	/* Check if exception code lies within bounds */
> -	bgeu t0, t2, 1f
> -	REG_L t0, 0(t0)
> -	jr t0
> -1:
> -	tail do_trap_unknown
> +	bgeu t0, t2, 3f
> +	REG_L t1, 0(t0)
> +2:	jalr t1
> +	j ret_from_exception
> +3:
> +

The whitespace is odd here, but nonetheless:

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> +	la t1, do_trap_unknown
> +	j 2b
>  SYM_CODE_END(handle_exception)
>  ASM_NOKPROBE(handle_exception)
>  
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 528ec7cc9a62..5eb3d135b717 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -16,7 +16,7 @@
>  
>  #ifdef CONFIG_FRAME_POINTER
>  
> -extern asmlinkage void ret_from_exception(void);
> +extern asmlinkage void handle_exception(void);
>  
>  static inline int fp_is_valid(unsigned long fp, unsigned long sp)
>  {
> @@ -70,7 +70,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			fp = frame->fp;
>  			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
>  						   &frame->ra);
> -			if (pc == (unsigned long)ret_from_exception) {
> +			if (pc == (unsigned long)handle_exception) {
>  				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
>  					break;
>  
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

