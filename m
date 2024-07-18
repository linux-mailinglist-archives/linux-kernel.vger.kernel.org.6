Return-Path: <linux-kernel+bounces-256599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66B9350EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013631F228B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5848144D3E;
	Thu, 18 Jul 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fH9Q7jub"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756814430A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321633; cv=none; b=ksa2dRhUy4SMy8TEDJIbMqKR6cdnBfjMOoc+UFF4/BYk+jpOkUnMtWSE3Wtf9Uavmj6cQjG7Tj2xwUQRBrQ0Ei/E2I2cTtbAVLzS2oS3/HfwEAE9GuA0IL6r36Ql4y98smYqf+uRwD8Hi6ysoXH+piz0W6HFfPzSCMUCkETUYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321633; c=relaxed/simple;
	bh=vInHxOUpkqrGYsaG/py3NaAKtWS74DcT2BcOxRpawGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMJYEiAA6SkptP+Ac9THkdJuBg+xkCzaFapkK5HXHxJsgU41u5qFvllCp8Fq2MBK0YK9Y/qrq5F4tnDDxX7pgxKldBfV81JQhgXDh7bonG0B0PsyM/7mHmVBjt/RUvWMrb1WDhsdknwjapLqcbPCC3rdEA7MC3dpkgzmME0H/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fH9Q7jub; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-808a8c90f5bso31965039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721321631; x=1721926431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9zJZZ9bWEPMAlkC/QkLHGli62aQv2OdpuoT4H3F0l2Y=;
        b=fH9Q7jubu9pttrJr3gDgLWdMqd6B4/r0CfLDqSy2C++4NAYUnaWi94IyNeWwJ41S/l
         /ZQX7iTAHlm0DvA3b2P4WKQ5Po6A7QdLJyoaxOSeLnfPgS/+bP6nIFGqb9Jguh+atylp
         ZBF8RG8N4LUx0+et8Hrsl+jtI3Ddo6b7YHq7CNti9Evq+8PfCTOeFaI0doLq5DvI7gkL
         62EdfKH+L3sVP0NNJRKPMKx19smiu//FpQzjHdlpb5Y82ZqqC4xf8J5WvG97/XP/Vcfh
         jiWAqnIMasX9veo7y6uA7mU86M/Bw8OOfFQWLjkIeg2DLDfjM0W6gqpzdhyuW0XQIkuX
         FQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321631; x=1721926431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zJZZ9bWEPMAlkC/QkLHGli62aQv2OdpuoT4H3F0l2Y=;
        b=VE9SJE8hO1Kbd1FW0TDXFrq686P+5puCr4fe36rUN5iXkkp2coeBUUBF4OM9CtqWKl
         zarzrJYgPsI1Dz9kiXWZrl8tCR1vKhARXH6GUiJGPbdRaixYX976ngUQ3tIH3kJIYiOz
         BNelRvx4kmHWwi7RmbeWk1CtMIxAO/XMIWiygthYqSj/fhjEP2NTkH/dZOURp4choBSh
         7zbklzqucLwJFZp+vHABXa/Y5p4LBdsEKQI5zbX5T0SVUvcL0mj0Qi1BLHR7OP6HV0Gn
         F1urBC2eXA0cJpUuPW98LD0I20wQjmS91a1pJZ7Dy35pttrrKf5O1CTsMh61cZfP4Y46
         144A==
X-Gm-Message-State: AOJu0Yw8IblQbPGZv5uWKde5VVF6wQ0Go6Vgbxq9lCdvxwopAFerLN2S
	HEX22bNmIhbgZkWwIjYJPbRnNT7TCsFjsZTJlR0U2UdU4eAlCRsDyeS8l8CY+CE=
X-Google-Smtp-Source: AGHT+IFngzTW8EHtTFvx7omE0v/qG3WhmjLl/7uA05MsoNd2N82RVXCmEyfoWoRu19pmQ31JPxhJiA==
X-Received: by 2002:a05:6602:1605:b0:7f9:beb8:7952 with SMTP id ca18e2360f4ac-81711e19b10mr820491439f.13.1721321630783;
        Thu, 18 Jul 2024 09:53:50 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210f24b6fsm1606088173.94.2024.07.18.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 09:53:50 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:53:49 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org
Subject: Re: [PATCH 1/2] riscv: perf: add guest vs host distinction
Message-ID: <20240718-e689be134be5b958b1eec65a@orel>
References: <cover.1721271251.git.zhouquan@iscas.ac.cn>
 <8e2d2f60fc30d64b6c69b38184a1b640c7b30003.1721271251.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e2d2f60fc30d64b6c69b38184a1b640c7b30003.1721271251.git.zhouquan@iscas.ac.cn>

On Thu, Jul 18, 2024 at 07:23:41PM GMT, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Introduce basic guest support in perf, enabling it to distinguish
> between PMU interrupts in the host or guest, and collect
> fundamental information.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/perf_event.h |  7 ++++++
>  arch/riscv/kernel/perf_callchain.c  | 38 +++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index 665bbc9b2f84..5866d028aee5 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -8,13 +8,20 @@
>  #ifndef _ASM_RISCV_PERF_EVENT_H
>  #define _ASM_RISCV_PERF_EVENT_H
>  
> +#ifdef CONFIG_PERF_EVENTS
>  #include <linux/perf_event.h>
>  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
>  
> +extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
> +extern unsigned long perf_misc_flags(struct pt_regs *regs);
> +#define perf_misc_flags(regs) perf_misc_flags(regs)
> +
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \

Arm has this outside the #ifdef CONFIG_PERF_EVENTS, but it doesn't
look like it should be.

>  	(regs)->epc = (__ip); \
>  	(regs)->s0 = (unsigned long) __builtin_frame_address(0); \
>  	(regs)->sp = current_stack_pointer; \
>  	(regs)->status = SR_PP; \
>  }
> +#endif
> +
>  #endif /* _ASM_RISCV_PERF_EVENT_H */
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index 3348a61de7d9..c673dc6d9bd2 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -58,6 +58,11 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  {
>  	unsigned long fp = 0;
>  
> +	if (perf_guest_state()) {
> +		/* TODO: We don't support guest os callchain now */
> +		return;
> +	}
> +
>  	fp = regs->s0;
>  	perf_callchain_store(entry, regs->epc);
>  
> @@ -74,5 +79,38 @@ static bool fill_callchain(void *entry, unsigned long pc)
>  void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
>  			   struct pt_regs *regs)
>  {
> +	if (perf_guest_state()) {
> +		/* TODO: We don't support guest os callchain now */
> +		return;
> +	}
> +
>  	walk_stackframe(NULL, regs, fill_callchain, entry);
>  }
> +
> +unsigned long perf_instruction_pointer(struct pt_regs *regs)
> +{
> +	if (perf_guest_state())
> +		return perf_guest_get_ip();
> +
> +	return instruction_pointer(regs);
> +}
> +
> +unsigned long perf_misc_flags(struct pt_regs *regs)
> +{
> +	unsigned int guest_state = perf_guest_state();
> +	int misc = 0;

Should use unsigned long for misc.

> +
> +	if (guest_state) {
> +		if (guest_state & PERF_GUEST_USER)
> +			misc |= PERF_RECORD_MISC_GUEST_USER;
> +		else
> +			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
> +	} else {
> +		if (user_mode(regs))
> +			misc |= PERF_RECORD_MISC_USER;
> +		else
> +			misc |= PERF_RECORD_MISC_KERNEL;
> +	}
> +
> +	return misc;
> +}
> -- 
> 2.34.1
>

Thanks,
drew

