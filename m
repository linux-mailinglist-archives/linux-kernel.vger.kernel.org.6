Return-Path: <linux-kernel+bounces-307040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F44964727
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198AD1C22D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750631AE85B;
	Thu, 29 Aug 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k61X5c2r"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CF19005B;
	Thu, 29 Aug 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939297; cv=none; b=fnE64bPC6xNjTrGj8MLTTRJ4+Wt7NqM8cIXj2aB9/eBTXt5n/bVAkLkVBW9oMN83MLAIgIiUv8YkSm3kguaDkCe3ipvsKP3KayIMEJ7z6QIxPztrKEigMfjt83jcAWcXuQfyBm+UwGhOVw615IA5//Wtx4Ewj60oh3tlyiWB8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939297; c=relaxed/simple;
	bh=bMd2+0+v0C0vkmvZ0a7gm12/MK8cw71SBn03PAdEUug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7DJD6jgFscx7APGEdeEQYrpPTJLHgLI7B16HeO53gSIJz+YlYuL78CBO1ThQ+YlzCwiOz0SoWVvTKjdnsphsdRmsRQDTnUWrBlo6wMdtkWftn4FrxwJSjdRdbHC707zddrS0bCpVog4SrvedS1Q184B6tO+pIbTJpVzrtjTaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k61X5c2r; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5f9d68805so350579eaf.3;
        Thu, 29 Aug 2024 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724939295; x=1725544095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fij7bmUZ1BwtygZobmPkPFaBK/SFCbQ/kLne1FVouMA=;
        b=k61X5c2rvs8K5UvKAvgH4VejKek9yM4p4frWdj2yth6Vt8L6IRq1l3nz34hw8x2K3B
         HZU7iUWDAH4rhR0EiFdszrxK5vHMb2aSfHrXpdn3WAJDaJAVgdiYdtVYSV84Gtwa5pJ4
         U4xKb3YvXvT2x2hPAQuNeOmklDzm0Y/3KWZZHdMuhsYWSoySIhaLwkqnJ9BCHv9fO+Yb
         6wHA5QPFke6e0Y4CseYkwBxq0dc6e87QDw56pkR5YBiGsEtljM19ULU6t4QNzjwSPCwQ
         UH6Ih8PFt7M1PZs+daku1pzDndf1FiPhfa5iSnm1ybj4fysQYtzr4jiBZlWYYNgzecK/
         zP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939295; x=1725544095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fij7bmUZ1BwtygZobmPkPFaBK/SFCbQ/kLne1FVouMA=;
        b=X23h2Vr33wpgA/AE/GkkJpyg0AbgBVTQkuVo+llDGwzoHXP0wy3sdMJwdA5gzlluV2
         yyAYf4dIZRzABdNIN6j7M7F9H6LB2E3W8GWlvZtOWQAzxHw2GvHY55SaQisW/ak2P7nJ
         SAURXw4kCYgkOIc2ohJDnvuJmZmh6iY+KzMoN2Fytf/4D4OCcowXVOXfqUSSN+I2gQ4+
         FgDGhazVfTwSitSUbsWjxNH/x9sRUGdZ1JgOeOVbsBu0cb+bhmb44AfranDJIkS/VryC
         ut37X88Xq8sLHS6fHpM0fP/LPmRLbJUxYckDqOU4MiEPC9gsA+jHrBYBlAuFCZsW5odg
         G3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv/XhwPxgCXJhk+yUM1jmImf45qRlreQD2DpwI8lFDwzk6g1JJQoqa2j0TljiQ4goFvryqJXXiM0syy0cF@vger.kernel.org, AJvYcCXUBAdwzS9Cb5bJ4yvM4YLjlolFfcXKdV0MdI2twWysDnkJt01Ns8VvTM9OnXeit55zvh7fsp0KaJaw@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPBjqZIN/TqBFx0X4KMXVCY+BFbPcjmlg90mkzFNdEuGgaw1e
	BHML3O0glwySrDPyegYStArsLbAdH6DyLYReOiHv25TnWQyX63Sv
X-Google-Smtp-Source: AGHT+IGCpp26qT5ACYfhkp4StVnu7Amwf484YTNlNSrglEKytGqqjoOG91Qqwhfb8r2kOPo+eK2/Zw==
X-Received: by 2002:a05:6359:4c10:b0:1a5:6b71:dde6 with SMTP id e5c5f4694b2df-1b603bebb88mr396283355d.3.1724939294686;
        Thu, 29 Aug 2024 06:48:14 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e66d8f4sm1236270a12.0.2024.08.29.06.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 06:48:14 -0700 (PDT)
Message-ID: <18007fe0-cc5d-4887-ab41-ed4cf8217b60@gmail.com>
Date: Thu, 29 Aug 2024 21:48:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/3] irqchip/apple-aic: Only access IPI sysregs
 when use_fast_ipi is true
Content-Language: en-MW
To: Thomas Gleixner <tglx@linutronix.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20240829110436.46052-1-towinchenmi@gmail.com>
 <20240829110436.46052-3-towinchenmi@gmail.com> <87zfova32u.ffs@tglx>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <87zfova32u.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/8/2024 21:08, Thomas Gleixner wrote:
> On Thu, Aug 29 2024 at 19:02, Nick Chan wrote:
>> Starting from the A11 (T8015) SoC, Apple introuced system registers for
>> fast IPI and UNCORE PMC control. These sysregs do not exist on earlier
>> A7-A10 SoCs and trying to access them results in an instant crash.
>>
>> Restrict sysreg access within the AIC driver to configurations where
>> use_fast_ipi is true to allow AIC to function properly on A7-A10 SoCs.
> 
> use_fast_ipi is an implementation detail and does not mean anything
> here. It's sufficient to say:
> 
>    Only access system registers on SoCs which provide them.
> 
> Hmm?
Seems like a good idea. Will be in v2. Though if the commit message
is that generic, do you think it's correct to squash the third patch
into this commit? It is also preventing sysreg access on SoC that
do not provide them.

> 
>> While at it, remove the IPI-always-ack path on aic_handle_fiq.
> 
> It's not while at it. It's part of handling this correctly.
In v2 it will be mentioned as as part of the sysreg access restriction.

> 
>> If we are able to reach there, we are on an IPI-capable system and
>> should be using one of the IPI-capable compatibles, anyway.
> 
> 'we' can't reach that code ever.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
Acked. In v2 the commit message will not impersonate the code anymore.

> 
> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> 
> This Signed-off-by chain is invalid. If Konrad authored the patch then
> you need to have a 'From: Konrad ...' line at the top of the change log.
> 
> If you worked together on this then this needs a Co-developed-by
> tag. See Documentation/process/...
This patch was entirely made by Konrad, but now that changes are requested,
it will be a Co-developed-by in v2.

> 
>>  
>> -	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
>> -		if (static_branch_likely(&use_fast_ipi)) {
>> -			aic_handle_ipi(regs);
>> -		} else {
>> -			pr_err_ratelimited("Fast IPI fired. Acking.\n");
>> -			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> -		}
>> +	if (static_branch_likely(&use_fast_ipi) &&
>> +	    (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING)) {
>> +		aic_handle_ipi(regs);
>>  	}
>>  
>>  	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
>> @@ -574,8 +571,9 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
>>  					  AIC_FIQ_HWIRQ(irq));
>>  	}
>>  
>> -	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
>> -			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>> +	if (static_branch_likely(&use_fast_ipi) &&
>> +	    (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ) &&
>> +	    (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>>  		/* Same story with uncore PMCs */
>>  		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>>  		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> @@ -811,7 +809,8 @@ static int aic_init_cpu(unsigned int cpu)
>>  	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
>>  
>>  	/* Pending Fast IPI FIQs */
>> -	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>> +	if (static_branch_likely(&use_fast_ipi))
>> +		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
>>  
>>  	/* Timer FIQs */
>>  	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
>> @@ -832,8 +831,9 @@ static int aic_init_cpu(unsigned int cpu)
>>  			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
>>  
>>  	/* Uncore PMC FIQ */
>> -	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> -			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
>> +	if (static_branch_likely(&use_fast_ipi))
>> +		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
>> +				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> 
> Please see the bracket rules in the tip maintainers doc.
Acked. Brackets will be added to function references in commit message
of v2.

> 
> Thanks,
> 
>         tglx

Nick Chan

