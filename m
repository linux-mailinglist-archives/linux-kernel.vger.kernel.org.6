Return-Path: <linux-kernel+bounces-227806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 698059156BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C81C20ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761719F48E;
	Mon, 24 Jun 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jGLGV+2l"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0E19EECD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255220; cv=none; b=OUsAh3XGXEOquAGoeXp8wyA5sKBD2hWryIqXh/6lRKdnapWXUbAMjJTQQOOXTDkEdTwQan9K8pGr5qKDqpIWb3YWPfHGp8mz1YMRPYILkQULD5gVAKwiqXS0yryzBuRmlBpgnfDXI1ySm0t1yBaAp9kfTMG0WypD70RyNj2KS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255220; c=relaxed/simple;
	bh=eRSQA0pwHwWbeOEQb4vgE+IO6n5DeNPT0C/HCkBcWtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1Aab9Xy78n6SBfSefd5ZiC3REqzUthxdaKvGY/Dh9Gmv0MdNvWLJE4F7UtvtJXlLTydehQZWoaGt0nhOZD/Kh3vwAD79TGo9d2SjtHF+vp6964o6r4Xy83KMFUGKAdWT+hQSHaMuYEzgXiufu7InIFkudzonKSdGCjGs1S9JuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jGLGV+2l; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-701b0b0be38so3937929b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719255218; x=1719860018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQbN2rQgA6olZj0JfteLM0ziVhjxiFoIeKCLSUkcl1k=;
        b=jGLGV+2lcNqP3srfU8sHBGzePlQL4C1xheibO7ZqAzCqDxmyodrRNnLe3zUSwKMPdN
         8drv1Gy1B6bxW0Q9qcAb6HxnkNj9UWgN0hxKqsEcMDSVZjz+0PlZAVHVG1uagYa6ffC9
         G4WzqX8+js8PtuHk4e04PJbk6v2xmZ1GQSPALIrQYUMxltmvrVKdAjTBEpiCN1nvoAr7
         XUAjbyEsg2Lr0N9tE9fdxI67pYp7Uf1nPeCJcUP+kzErloPysvBSsv6FnIALKWH0TRvP
         ayr7x+C+UhOyCmNbdQIxdhiPjg/7MEXKpH5KACIT6VOiRE/zhwDIokUXla86+MLiw7WS
         Of0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255218; x=1719860018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQbN2rQgA6olZj0JfteLM0ziVhjxiFoIeKCLSUkcl1k=;
        b=PpnW6jdnmUafNMTnQbKH/4DV1VCxEC/VMzqWVO5by+2s+5FkRn2AmRU5oUV4oiWYoP
         r/M3zkSXrkGwin/g++AUWqoEYzQ+MqV3e74dC9vaXM5MjxmahnS7/KyDA2qalDIpTPfV
         RYx+eILLdG7HNOFMMbVfNMotW6PJKtu79qt13EKvRyCDpAgI6oTt5ALwDc87c9IASL1H
         0BN2hhnpQ6gQ0FVBxOw5Z8TIfut2GBSbXoOcgDDPb33HmPPjIyyJOtR/QwhY0cdlr5xO
         KrwlYYx0rZy8MYaLLbkNB5p3pBiKAw02sr22v2dV+LhwCc/k5BN0+LQnKB9NRiQzWDg2
         BVew==
X-Forwarded-Encrypted: i=1; AJvYcCWxIhso/B0WCsWVlmKuy6fDkbg6fKsJ0HC01Z0UunURKpLaWB1vphfgdP15v+f61XFg8iRzwMt+h7Um1n7pqDXf37ixZkn22s5VpnG2
X-Gm-Message-State: AOJu0YyxcBvTADhMzu+lwP3cNhoMQOAq4fuykVFYI3jW3Jfx6deTzmWY
	4cbiPymlRKqcOBDt8pQOJRxGaovo6TmJLAyNCdqjRQmewOKzvKoRrZMXOUWDMmQcc6f2DIZigsJ
	e
X-Google-Smtp-Source: AGHT+IHZRguXCheDd+Y6/VnLlaK1627YnvA3NtHYov2hpGd+KnVuRadwyUfxi8qJdw6f3yJJxUQChQ==
X-Received: by 2002:a05:6a00:2da0:b0:706:1edc:79af with SMTP id d2e1a72fcca58-706746b8ff7mr6028711b3a.22.1719255218044;
        Mon, 24 Jun 2024 11:53:38 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706953ca94dsm215462b3a.199.2024.06.24.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:53:37 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:53:36 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] riscv: remove asmlinkage from updated functions
Message-ID: <ZnnAsN9qW4Y9nL+/@ghost>
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-7-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616170553.2832-7-jszhang@kernel.org>

On Mon, Jun 17, 2024 at 01:05:53AM +0800, Jisheng Zhang wrote:
> Now that the callers of these functions have moved into C, they no longer
> need the asmlinkage annotation. Remove it

A couple of the functions here can be inlined as well now that they are
not called by assembly, this will allow the compiler to get rid of the
stack setup/tear down code and eliminate a handful of instructions. The
functions that can be inlined are riscv_v_context_nesting_start() and
do_irq().

- Charlie

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/asm-prototypes.h |  6 +++---
>  arch/riscv/kernel/traps.c               | 16 ++++++++--------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
> index 81a1f27fa54f..70b86a825922 100644
> --- a/arch/riscv/include/asm/asm-prototypes.h
> +++ b/arch/riscv/include/asm/asm-prototypes.h
> @@ -37,7 +37,7 @@ asmlinkage void riscv_v_context_nesting_end(struct pt_regs *regs);
>  
>  #endif /* CONFIG_RISCV_ISA_V */
>  
> -#define DECLARE_DO_ERROR_INFO(name)	asmlinkage void name(struct pt_regs *regs)
> +#define DECLARE_DO_ERROR_INFO(name)	void name(struct pt_regs *regs)
>  
>  DECLARE_DO_ERROR_INFO(do_trap_unknown);
>  DECLARE_DO_ERROR_INFO(do_trap_insn_misaligned);
> @@ -53,8 +53,8 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
>  DECLARE_DO_ERROR_INFO(do_trap_break);
>  
>  asmlinkage void handle_bad_stack(struct pt_regs *regs);
> -asmlinkage void do_page_fault(struct pt_regs *regs);
> -asmlinkage void do_irq(struct pt_regs *regs);
> +void do_page_fault(struct pt_regs *regs);
> +void do_irq(struct pt_regs *regs);
>  asmlinkage void do_traps(struct pt_regs *regs);
>  
>  #endif /* _ASM_RISCV_PROTOTYPES_H */
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index b44d4a8d4083..ddca8e74fb72 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -147,7 +147,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>  #define __trap_section noinstr
>  #endif
>  #define DO_ERROR_INFO(name, signo, code, str)					\
> -asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
> +__visible __trap_section void name(struct pt_regs *regs)			\
>  {										\
>  	if (user_mode(regs)) {							\
>  		irqentry_enter_from_user_mode(regs);				\
> @@ -167,7 +167,7 @@ DO_ERROR_INFO(do_trap_insn_misaligned,
>  DO_ERROR_INFO(do_trap_insn_fault,
>  	SIGSEGV, SEGV_ACCERR, "instruction access fault");
>  
> -asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
> +__visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
>  {
>  	bool handled;
>  
> @@ -198,7 +198,7 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
>  DO_ERROR_INFO(do_trap_load_fault,
>  	SIGSEGV, SEGV_ACCERR, "load access fault");
>  
> -asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
> +__visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> @@ -219,7 +219,7 @@ asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs
>  	}
>  }
>  
> -asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
> +__visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> @@ -294,7 +294,7 @@ void handle_break(struct pt_regs *regs)
>  		die(regs, "Kernel BUG");
>  }
>  
> -asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
> +__visible __trap_section void do_trap_break(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
>  		irqentry_enter_from_user_mode(regs);
> @@ -311,7 +311,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  	}
>  }
>  
> -asmlinkage __visible __trap_section  __no_stack_protector
> +__visible __trap_section  __no_stack_protector
>  void do_trap_ecall_u(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
> @@ -355,7 +355,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
>  }
>  
>  #ifdef CONFIG_MMU
> -asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
> +__visible noinstr void do_page_fault(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
>  
> @@ -378,7 +378,7 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
>  	irq_exit_rcu();
>  }
>  
> -asmlinkage void noinstr do_irq(struct pt_regs *regs)
> +void noinstr do_irq(struct pt_regs *regs)
>  {
>  	irqentry_state_t state = irqentry_enter(regs);
>  
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

