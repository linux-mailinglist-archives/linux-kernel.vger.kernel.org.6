Return-Path: <linux-kernel+bounces-568302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1998FA69359
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DAB7A865B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91C1D63E3;
	Wed, 19 Mar 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZcesKens"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510711D5162
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398065; cv=none; b=UFdfMN2WOkuoYQrjB4RBbizUX6/5BHZrEJf1H3uR/cYVkoRIOpF2hqYddMg74i2yWjyZ/BNYt4TsWypRl8Y3KQZWpUrW4Z1EYOEbaFHDM1MgvBJ9gNYjUPgFSth1+sAYM5k8AI485fPGS7JKBjJMEj85leqvDPnfNBlGHoB1tuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398065; c=relaxed/simple;
	bh=euhzxAcsa73HCMGqXYqF6lj+RKd5O6xHJAkh/9JGCvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUJ7Tve10aW1yL55qzqFiTxUYfCOZRjDUKDyQz52S92pufL853ZnmsVgBr19OgSXcqYQJpaLSZ6sVwHuqCdfJ/HnAlk9gb40mamqMkzMyTrdCKf9fs29zgfYOHGclZ9Tnd+2+QC6L2/cZLTGFRtGcEmZAvzLqDqeZbUu+7X4nEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZcesKens; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so47307615e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742398061; x=1743002861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgxY2KZtIrmQRpExe3D1+RTeBDiOjEYNGghBrLG3UzU=;
        b=ZcesKens/7Zl1OU6NXgF44SWcIiLXK0gBaUNPset5LrD9e6/T8HHYOfIy98gRZ90x9
         L9/K51nj0UIPXPrYnVpYbR0hwrsZu3b7zBUgvsuvGOuda25sunnPwr6y2QmSQYuSBBFI
         3RL481luYyd+wzj+q2d1s1lRGp4hg/5IDQb/o7eEDYpgiD+mW4H29loZAv9QeV7UHr9j
         rzVdpioKGxwc+iHBCS2CGonnDfKlY9x+z/OoYnKi32rF0lTJg+iMm/7LsHpRhlzo03kY
         WZ89dOuN8UN8o03Spza4+9Kg3xohaWVLW48e0Xa7VaaFmAR5/0nkrBR3om1a5QKNgVee
         1IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398061; x=1743002861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgxY2KZtIrmQRpExe3D1+RTeBDiOjEYNGghBrLG3UzU=;
        b=wRjAGs1/0CFXlvuA/zBufmxN9ItozJxDNLofAiEj3jusGCJ0LxRaGD1+GDVzluNpZP
         7cx8Kk39Hau07l9kgL1Avp8iAjR7+527SQG0mvhHVd0Xm7CudtgGPma3p2pCGyU1EiwP
         B2ZhDLRiCSkGa8NjmLH0IBGQvPBtfF9disWW6VQbtlDDjUcFpZrnYSBvNxsn9sM8w/NP
         FDiP6FsF4iMKZxFX3cf2p+8Jz6654zrYt4EWVazZ6MQEXHkelkXTzXpD4SOlsgPV0aeu
         2pJOet0X6JxKRtzGILoApdeaW38YMx/q5cOXxJUdBcXir/QnOxxpPYxgbxBnrlt8tyQ/
         toSw==
X-Forwarded-Encrypted: i=1; AJvYcCXBqpitNJVJnVXziIRIJuqMzOIePwmfeYrVI79PWs1sBCQURjenI7rZoM0vAl1OzeJUAGIdnVlNdedYCq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq36WmcW7cw5hZBCABQYyWR2xefVdxiXWvjoQA93osDOhCp3m+
	xUH8nK868THRV3fohUOzpqfViSlkEKl92vlif6uti3u9iuI0k4ltI0s6K1fAaAA=
X-Gm-Gg: ASbGncsRx18JfUj082goD0110QXDcQVaS874V/bz39N5PtQ/0Y3jgsJdHA86HDR6+Iu
	1yS5g2welXnFTPV/6pnNMa2R7eUnqFc4j8Xe70NueX4gJFH3cMAXisfR/v0kwqaG3aRcugPktt5
	fjFsGw1Q8Tr0NUzzsKyA6q/A2KdGDDeIvByHhO9N4PG4zT5Q/rm0GXv+p7KB+Wsth31FfmKRtoF
	1KyOqnJFNrw6GQ+8sLIu7JBHqBpcv+su7mDzwqcriEzDcqk5efJbmjqLTEMWbgt/wWpgDUBhCqS
	05eNgORBooRbPXVWFcvF/vTbZ3Husl+9
X-Google-Smtp-Source: AGHT+IFeAXnl0WTivUPXfKcPs3cJUq9v6gC9hg13Hq54tpqSOLgPB+ibA2L8ZApJrBJf1YYPrQEiJw==
X-Received: by 2002:a05:600c:5250:b0:43c:fc0c:7f33 with SMTP id 5b1f17b1804b1-43d43781e4emr30994685e9.2.1742398061429;
        Wed, 19 Mar 2025 08:27:41 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f855efsm21731865e9.34.2025.03.19.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:27:40 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:27:39 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ben Dooks <ben.dooks@codethink.co.uk>, Pasha Bouzarjomehri <pasha@rivosinc.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] riscv: Move nop definition to insn-def.h
Message-ID: <20250319-3bf29b05bf02bfdaa32b261c@orel>
References: <20250318-runtime_const_riscv-v9-0-ddd3534d3e8e@rivosinc.com>
 <20250318-runtime_const_riscv-v9-1-ddd3534d3e8e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-runtime_const_riscv-v9-1-ddd3534d3e8e@rivosinc.com>

On Tue, Mar 18, 2025 at 05:38:45PM -0700, Charlie Jenkins wrote:
> We have duplicated the definition of the nop instruction in ftrace.h and
> in jump_label.c. Move this definition into the generic file insn-def.h
> so that they can share the definition with each other and with future
> files.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/ftrace.h   | 1 -
>  arch/riscv/include/asm/insn-def.h | 2 ++
>  arch/riscv/kernel/ftrace.c        | 6 +++---
>  arch/riscv/kernel/jump_label.c    | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..b7f361a50f6445d02a0d88eef5547ee27c1fb52e 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -79,7 +79,6 @@ struct dyn_arch_ftrace {
>  #define AUIPC_RA		(0x00000097)
>  #define JALR_T0			(0x000282e7)
>  #define AUIPC_T0		(0x00000297)
> -#define NOP4			(0x00000013)
>  
>  #define to_jalr_t0(offset)						\
>  	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> index 9a913010cdd93cdfdd93f467e7880e20cce0dd2b..0a1fc5134f29da190554c59f8cee3b5374c9aa2d 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -200,4 +200,6 @@
>  #define ZAWRS_WRS_NTO	".4byte 0x00d00073"
>  #define ZAWRS_WRS_STO	".4byte 0x01d00073"
>  
> +#define RISCV_INSN_NOP4	0x00000013U

This should be _AC(0x00000013, U), but since this is the first of its kind
(all other defines are of the form ".4byte ..." -- either explicitly, like
the ones above, or through the INSN_* macros), then it feels like it
either doesn't belong here at all or that we should provide it and a
".4byte ..." version.

Thanks,
drew

> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 3524db5e4fa014a4594465f849d898a030bfb7b8..674dcdfae7a149c339f1e791adb450535f22991b 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -36,7 +36,7 @@ static int ftrace_check_current_call(unsigned long hook_pos,
>  				     unsigned int *expected)
>  {
>  	unsigned int replaced[2];
> -	unsigned int nops[2] = {NOP4, NOP4};
> +	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
>  
>  	/* we expect nops at the hook position */
>  	if (!expected)
> @@ -68,7 +68,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>  				bool enable, bool ra)
>  {
>  	unsigned int call[2];
> -	unsigned int nops[2] = {NOP4, NOP4};
> +	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
>  
>  	if (ra)
>  		make_call_ra(hook_pos, target, call);
> @@ -97,7 +97,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  		    unsigned long addr)
>  {
> -	unsigned int nops[2] = {NOP4, NOP4};
> +	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
>  
>  	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
>  		return -EPERM;
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> index 654ed159c830b3d5e34ac58bf367107066eb73a1..b4c1a6a3fbd28533552036194f27ed206bea305d 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -11,8 +11,8 @@
>  #include <asm/bug.h>
>  #include <asm/cacheflush.h>
>  #include <asm/text-patching.h>
> +#include <asm/insn-def.h>
>  
> -#define RISCV_INSN_NOP 0x00000013U
>  #define RISCV_INSN_JAL 0x0000006fU
>  
>  bool arch_jump_label_transform_queue(struct jump_entry *entry,
> @@ -33,7 +33,7 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
>  			(((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
>  			(((u32)offset & GENMASK(20, 20)) << (31 - 20));
>  	} else {
> -		insn = RISCV_INSN_NOP;
> +		insn = RISCV_INSN_NOP4;
>  	}
>  
>  	if (early_boot_irqs_disabled) {
> 
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

