Return-Path: <linux-kernel+bounces-536968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F50A48671
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829CA18841FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67C1DDC0B;
	Thu, 27 Feb 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4adwljok"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689E1A3178
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676819; cv=none; b=SA8GyE1xPs1nNgoaXejymda2C3CP0GmJ+Ov+Hhl+mmrJiTXjq+KnmTmt+hf1nHkgyb5uIHVv+MzyEiGRjC3OCgFczy9RmfqI0qIeiDUw4BLGQ8xp4HcxRUAj6Wuz5kHAXQ3Hd3uAabyWdEFCC0OqSp318RgMZRzAuHgX9Q1a3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676819; c=relaxed/simple;
	bh=FNuFdGFmxVDIbxqbjjO/bdKtmO+AEtCtsWpJhY1AABg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Evmb4v5cjqHxHdmZXnfuge8QZq7NCB3e3iUh1A+Hko7peRtzMJtMNRHlPJjbnM2smh1uhg2B5qE45dIpKsKwG+OylZH74iJpgGdUhOOXC7fnxfJM3+wF0Cd+VDyZQvPTSDVVG3yBg7/JEg9J5So1I9st+irKd+1/3Xd6g0PrPzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4adwljok; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2234bf13b47so23431605ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740676816; x=1741281616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNMA4trWnehuMgsqPa3chlXCB6mGTInwBrgSw5o5+p8=;
        b=4adwljokrC9RQ3PdxqWpEiJuKyYVDj3pWdgFWbkwnvY/pODNOh/oIvqp7oynaEheYt
         pDtxxNJkApbQOEWQOJr/QFMUP6cqTUo/G1aQnedVbSSDp8B+RBjLs7fSijAY0uoq1GD+
         U8zrwncu4r4O+IJjwLzCuKnR4q2yopvK9imsgpj7fCQVeLs96Ra/jOAdyBBoT5vEodkE
         Xf+/rTqqKgf8ITykiTosCvbSaGWoh8mMDJYRtU05WO3znO3Fx4zrtiyDpchlQIxjnHxI
         8tE8pHmSOmunx+6Oo3LKoIb85hjnjB++K+VGAEJEwZJbxsnfdrBGzmliXQMWvFZ+fDsO
         xQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676816; x=1741281616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNMA4trWnehuMgsqPa3chlXCB6mGTInwBrgSw5o5+p8=;
        b=nddE2dWzHUhAEnPpLDoW1LMNU3aoYDHyUJYLzf5CQYr4Q5nGdTOb4IWm3J7xRv603U
         k7ZKjES+s4VN65NV+kN0eC2lYN92XF4LQc8t2VWt3iPsxlaYRG7iuJz6mOK2SYvrqRWs
         uIqkCthSpJ/rcQvmxyS9hhwVbfc8ic8TZfg6eeeb38/s0VpiWdu+Dmb4OGcoy1GKTiV/
         zppHr7CvYDz+sRrXNxtVqLDsg7T+YalCU5pNGX/pMMY/uXIis3yoGugT2wvxfCBk/cop
         H/CKGQ2DokWUksOWS1u9awse2OUA1Z908GTDOqodOK4oxkku5SK1F8FPkJ7PSqbpxLEK
         27Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWau7nU32uVgAvr7ILMkDmCT5AQboMOmZo9xU3hvcCXUGWqWcFolhrP5z+ihAcGRwIUczuCu1ixBEoNUi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQuODPop4qXmft4clTOvTEX3jHkkzDPADNqWIveYjaTQ5p03LE
	0wPrEiuqQMR9jCLq/6MKuLefPl8+Wrg2M8E+ObJ/6IumKyW9FfdmLfJTUzarqFyKySjb5LXl/ua
	pXg==
X-Google-Smtp-Source: AGHT+IE1PsZJy5ZgwT+4gbnQZXY1CnCPk9dS3lO75sAQsyNz+eP7hhJlun0UE9on2aTeYx2OnaI1rpNPfbc=
X-Received: from pfld12.prod.google.com ([2002:a05:6a00:198c:b0:732:7e28:8f7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:807:b0:732:a24:734b
 with SMTP id d2e1a72fcca58-734ac3f3a92mr271052b3a.15.1740676816019; Thu, 27
 Feb 2025 09:20:16 -0800 (PST)
Date: Thu, 27 Feb 2025 09:20:14 -0800
In-Reply-To: <1fe17606-d696-43f3-b80d-253b6aa80da7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227011321.3229622-1-seanjc@google.com> <20250227011321.3229622-4-seanjc@google.com>
 <095fe2d0-5ce4-4e0f-8f1b-6f7d14a20342@amd.com> <1fe17606-d696-43f3-b80d-253b6aa80da7@amd.com>
Message-ID: <Z8CezusUHEzOCYBF@google.com>
Subject: Re: [PATCH v2 3/5] KVM: SVM: Manually context switch DEBUGCTL if LBR
 virtualization is disabled
From: Sean Christopherson <seanjc@google.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, whanos@sergal.fun
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Ravi Bangoria wrote:
> > Somewhat related but independent: CPU automatically clears DEBUGCTL[BTF]
> > on #DB exception. So, when DEBUGCTL is save/restored by KVM (i.e. when
> > LBR virtualization is disabled), it's KVM's responsibility to clear
> > DEBUGCTL[BTF].
> 
> Found this with below KUT test.
> 
> (I wasn't sure whether I should send a separate series for kernel fix + KUT
> patch, or you can squash kernel fix in your patch and I shall send only KUT
> patch. So for now, sending it as a reply here.)

Actualy, I'll post this along with some other cleanups to the test, and a fix
for Intel if needed (it _should_ pass on Intel).  All the open-coded EFLAGS.TF
literals can be replaced, and clobbering arithmetic flags with SS is really, really,
gross.

> ---
> diff --git a/x86/debug.c b/x86/debug.c
> index f493567c..2d204c63 100644
> --- a/x86/debug.c
> +++ b/x86/debug.c
> @@ -409,6 +409,45 @@ static noinline unsigned long singlestep_with_sti_hlt(void)
>  	return start_rip;
>  }
>  
> +static noinline unsigned long __run_basic_block_ss_test(void)
> +{
> +	unsigned long start_rip;
> +
> +	wrmsr(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_BTF);
> +
> +	asm volatile(
> +		"pushf\n\t"
> +		"pop %%rax\n\t"
> +		"or $(1<<8),%%rax\n\t"
> +		"push %%rax\n\t"
> +		"popf\n\t"
> +		"1: nop\n\t"
> +		"jmp 2f\n\t"
> +		"nop\n\t"
> +		"2: lea 1b(%%rip), %0\n\t"
> +		: "=r" (start_rip) : : "rax"
> +	);
> +
> +	return start_rip;
> +}
> +
> +static void run_basic_block_ss_test(void)
> +{
> +	unsigned long jmp_target;
> +	unsigned long debugctl;
> +
> +	write_dr6(0);
> +	jmp_target = __run_basic_block_ss_test() + 4;
> +
> +	report(is_single_step_db(dr6[0]) && db_addr[0] == jmp_target,
> +	       "Basic Block Single-step #DB: 0x%lx == 0x%lx", db_addr[0],
> +	       jmp_target);
> +
> +	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
> +	/* CPU should automatically clear DEBUGCTL[BTF] on #DB exception */
> +	report(debugctl == 0, "DebugCtl[BTF] reset post #DB. 0x%lx", debugctl);
> +}
> +
>  int main(int ac, char **av)
>  {
>  	unsigned long cr4;
> @@ -475,6 +514,12 @@ int main(int ac, char **av)
>  	run_ss_db_test(singlestep_with_movss_blocking_and_dr7_gd);
>  	run_ss_db_test(singlestep_with_sti_hlt);
>  
> +	/* Seems DEBUGCTL[BTF] is not supported on Intel. Run it only on AMD */
> +	if (this_cpu_has(X86_FEATURE_SVM)) {
> +		n = 0;
> +		run_basic_block_ss_test();
> +	}
> +
>  	n = 0;
>  	write_dr1((void *)&value);
>  	write_dr6(DR6_BS);
> ---
> 
> Thanks,
> Ravi

