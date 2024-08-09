Return-Path: <linux-kernel+bounces-280769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E594CEEC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24231F22462
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1F1922F2;
	Fri,  9 Aug 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HTJcfpgr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF018FC6F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200350; cv=none; b=JvZnn3BhphB75WtyzAs0JxfU2pUD3Lo4AJZkgvODaQ4RUprwx4NQuZfH0FNyIdIRkAjl+69CB7JuZ6LIX/K3Wa3fefOFZHHhgsOZojB1+hH7Mj6CFFzwcYeLjHXhswvkucXZc+zcXMwbENqFLVYyMB4t8iFGXcGS/1HZllDtqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200350; c=relaxed/simple;
	bh=bq0X3F7+84wrde7oQSIRp0ErLI1U/SHe/k/8DiRIjvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1cH1LGyLTGPZOA9mG+Oy3GBYXmX50lllYNDG5gQptmTbsY+zNLKaXUddxFz4FQR9AYZfvpI8F9dzLYSa0sZXDlxuFweN1b/YWJnjPlk5Hdd/3Ru1yDbJlki0YoRcm9o8TQuwYZSUJmYFyTqPOm+7NCn/1eD+dTCwyDPY16qKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HTJcfpgr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42812945633so14409295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723200346; x=1723805146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzxrHFmWGtqzOqgWEvSFDQnzy0w/Qo4V5er+QVauCDE=;
        b=HTJcfpgrPW3pfqRLbnYFQN//vs9crlIDy7SpwA2OS/5pVrUK1Dv7iTXvI2EnSTk9E4
         4/bP3+sk4hktf/pwv6+MpRfpPUTafxsHXakqbWOxE2oTaEJjgFBMIqHOBAcl5RmcLKRD
         HbleVyIWoh/GqiU+Fdk7Mw3FYysy7/y4JCfh+AJbAVABGS1uFetLnhThRk86Q5RVeN5K
         vi5iUCEZ5Zy3mlbmuMAvpKszUOPPq1TSsXuujXfGLEadtQ7r289y/2q10RAbXH1fHmL1
         1KJWseBU1eOZGIzAQoLuu0MbbHqjJbU6ApOez08qI9dPj4y6QgM+A9pjZ1T8wrq6PUTI
         b22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723200346; x=1723805146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzxrHFmWGtqzOqgWEvSFDQnzy0w/Qo4V5er+QVauCDE=;
        b=h1EGB5e9YxkslSADUIIJFhzkeMX5m7JcrpyuYWkPpvvIeC3Q3iQuamSBrdvq5+JhX8
         wpKtsKAriVztdwVcEb2A2JD+VMCsU5q3UxbDlEhE3pNIBa8v5ijvGQ2qq8GIZTIV30XD
         ZE+etUs2KEpWtM0wksnJaihmedSyHJbzMkdNJO0NxWttb21kIPIVey6dXU/frzBzZxku
         GKHWH6cuC6cvlPhyBn3144YO4uQXByzeOr51zutjUaf9qCtFiW1wYkAIVB2VP6ooczR6
         1h7Cw0cEKgnFY546kAtuO+VY/2svDVE/ZX2PHnjpZSgZpWLqfdm3RSqCvTUioGW+hXae
         CBVw==
X-Forwarded-Encrypted: i=1; AJvYcCUdkmzMLfJLS48Qm5Wub4uhFlyjNj+8Uz0UWJB0tWwclGkagkccu2ReweiQhpKgYL+1d8fljdQ0sAmyVwQVNeY9zczRTq0mZTnbKhmk
X-Gm-Message-State: AOJu0Yww3tIGGCziieEXRq9PsstCV6wjw/QobHI8E55bkR1bIL0QyTNK
	oaUS/udkZQTgz9MBX8O+KcZWJ7+GAlKeMHQBSvRgKNnTQ5IfjeXvz2ksIFaEklA=
X-Google-Smtp-Source: AGHT+IGTWnbYNm46KGiEc3RpM2yPYUdIF1j0ICvZsTRkT1yptIJEg4Gduuq7V3fh2YBzEsWTL57gPA==
X-Received: by 2002:a5d:5692:0:b0:368:7583:54c7 with SMTP id ffacd0b85a97d-36d5dd8f8e8mr888621f8f.8.1723200346325;
        Fri, 09 Aug 2024 03:45:46 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716d2c1sm4879701f8f.40.2024.08.09.03.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 03:45:45 -0700 (PDT)
Message-ID: <eb2ed1b4-94cf-4d3d-b726-6ee0fa13ca9e@suse.com>
Date: Fri, 9 Aug 2024 13:45:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] x86/entry: Set FRED RSP0 on return to userspace
 instead of context switch
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, andrew.cooper3@citrix.com, seanjc@google.com
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-4-xin@zytor.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240807054722.682375-4-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7.08.24 г. 8:47 ч., Xin Li (Intel) wrote:
> FRED RSP0 is a per task constant pointing to top of its kernel stack
> for user level event delivery, and needs to be updated when a task is
> scheduled in.
> 
> Introduce a new TI flag TIF_LOAD_USER_STATES to track whether FRED RSP0
> needs to be loaded, and do the actual load of FRED RSP0 in
> arch_exit_to_user_mode_prepare() if the TI flag is set, thus to avoid a
> fair number of WRMSRs in both KVM and the kernel.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>   arch/x86/include/asm/entry-common.h | 5 +++++
>   arch/x86/include/asm/switch_to.h    | 3 +--
>   arch/x86/include/asm/thread_info.h  | 2 ++
>   arch/x86/kernel/cpu/cpuid-deps.c    | 1 -
>   4 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
> index 4c78b99060b5..ae365579efb3 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -51,6 +51,11 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>   		if (ti_work & _TIF_USER_RETURN_NOTIFY)
>   			fire_user_return_notifiers();
>   
> +		if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> +		    (ti_work & _TIF_LOAD_USER_STATES))
> +			wrmsrns(MSR_IA32_FRED_RSP0,
> +				(unsigned long)task_stack_page(current) + THREAD_SIZE);
> +
>   		if (unlikely(ti_work & _TIF_IO_BITMAP))
>   			tss_update_io_bitmap();
>   
> diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
> index c3bd0c0758c9..a31ea544cc0e 100644
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -71,8 +71,7 @@ static inline void update_task_stack(struct task_struct *task)
>   	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
>   #else
>   	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
> -		/* WRMSRNS is a baseline feature for FRED. */
> -		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_SIZE);
> +		set_thread_flag(TIF_LOAD_USER_STATES);
>   	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
>   		/* Xen PV enters the kernel on the thread stack. */
>   		load_sp0(task_top_of_stack(task));
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 12da7dfd5ef1..fb51904651c0 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -106,6 +106,7 @@ struct thread_info {
>   #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
>   #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
>   #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
> +#define TIF_LOAD_USER_STATES	30	/* Load user level states */

Wouldn't something along the l ines of TIF_LOAD_FRED_RSP be more 
descriptive, or it's expected that this flag can cover more state in the 
future?

>   
>   #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>   #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> @@ -128,6 +129,7 @@ struct thread_info {
>   #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
>   #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
>   #define _TIF_ADDR32		(1 << TIF_ADDR32)
> +#define _TIF_LOAD_USER_STATES	(1 << TIF_LOAD_USER_STATES)
>   
>   /* flags to check in __switch_to() */
>   #define _TIF_WORK_CTXSW_BASE					\
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index b7d9f530ae16..8bd84114c2d9 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -83,7 +83,6 @@ static const struct cpuid_dep cpuid_deps[] = {
>   	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
>   	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
>   	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
> -	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
>   	{}
>   };
>   

