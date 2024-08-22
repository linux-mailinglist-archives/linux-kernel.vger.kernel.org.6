Return-Path: <linux-kernel+bounces-298065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6695C17D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 01:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170EA284E87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC361D1F6D;
	Thu, 22 Aug 2024 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Md+6yKIL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F71D0DFF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369237; cv=none; b=aIkeHS5M5tDuuAH27qmrzTY+WI3CczdNzdCa8BXFyuQOnWC1ZLvs6PUFIwhE4JfQjX0rbhOi5+N/x8V16qKDU1/SZCYMkQm8Ts5g731hItX3KLIe3St8kfuXPmZ55xbqOJqf3xhUHFJssfE+A97eAa6yN5cm7IuMMx1hUgEJGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369237; c=relaxed/simple;
	bh=Egwy9hybB6x9w7JJMCbClhbFUJdrUwmrFCIS7VcEce0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ueamwP4pB+LMroufO+ozbJ07jcimWyw7UNaEYzh5NTNRIssQjWYf/Eim1RwlPRxmzEfHhOFpicI6UEvlitY0nHHtqXsguegqml3fbw4IDgoLG1Tb/daP0MmKGR0u3DuWzCb0MFQ2or6/+2SaNzzXCZ0Xlc3EtwkHGwOI3T4XDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Md+6yKIL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e178e745c49so1672601276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724369234; x=1724974034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnLx+0iU61LzYD3h0xQcqP5Ih66Md4VDgKsUo14Lf3E=;
        b=Md+6yKILvWkic2kdHlJLoJCZblSZGs3IpuU08YB6XNCopZXqWL/Yg4hM4k2XWIlNY5
         RAgA9ewPRsQhKduzI1A7zsdIliBxiKrxkLOHb7zWNYix4ACbbsgk4NS+fHbkaqznCpd7
         t/MGLrMEWVT3PRuD+oY4rq/G1fSYDS0vsTQWWpkGrW+foZLdrNkFvnzOIno5xZ4r89pj
         bZv/T/Eig+woyx5u3Rxjc5ZJBSjjZHz+XLlafaY37x0xE7jZzzppxCr7RGsuGHAr5Ntb
         kapVYKHznTVxqT+0blNnJsN5ZFIMeF0GrZqdYHcUqxuYsrGm3h0Jw7hQ2PkvE62qhUM5
         Abcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724369234; x=1724974034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnLx+0iU61LzYD3h0xQcqP5Ih66Md4VDgKsUo14Lf3E=;
        b=uugspWso2BrHWh/lOTfVTKfz4ewbFipsuvLJg2tSsXXvEaGPWShGt7IVDpP+BcEerF
         I6nMwnCG0yhkTc3bOZWaaniJLh8NDUWXnR//xckF136l0hiJYsB9M2JOnAwv+3WxzKaO
         1XipkE1fiz3pvNoGXqUXbUiUNv5WeOmr9S/QyOjgdMtoIlu0Z66pfUEA/yekaM8JUpna
         hU0ZFOrjuIsRnBQEegeKMpAylAdJ8VdjIm6rHaGkglzEH00j1e2Kf+mL2VokdIssBg88
         3wG8PhssJ1v51S0Y3ypotp8BNSrqkW810RIG9xH7QHCJ96xITdySJZSODZp6eTTPNBoZ
         W8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXqC8K+H/2aH4byULgC/h/0PkLTMQ2NChMoo75a+7MSpWsu5/uHM7xhjjiNIA2gpNU/xJTOYbWeiiaGoEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeGuxzu/CqupQK1eBUa/jc9NmQM4VRqT/eMuMHlCkIZHB0um9i
	qDmo65C75lUhb02F9rxrDKQogd8N7uusi7MdcEwmwQ+6NqGY+zmxvrBw8dZw2zdx7yjw6pTLtSN
	/3g==
X-Google-Smtp-Source: AGHT+IElSAlI6s3smFamDaezE5icBKCGAry+0iIK7L7uIrAXJ1G+6bxPsNLWqzK7Li9sC4VyeR0PXN53VeU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:92:0:b0:e11:7039:ff92 with SMTP id
 3f1490d57ef6-e17a8666f19mr695276.11.1724369234549; Thu, 22 Aug 2024 16:27:14
 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:27:13 -0700
In-Reply-To: <20240822202226.862398-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822202226.862398-1-sohil.mehta@intel.com>
Message-ID: <ZsfJUT0AWFhoONWf@google.com>
Subject: Re: [RFC PATCH] x86/cpufeature: Add feature dependency checks
From: Sean Christopherson <seanjc@google.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Eric Biggers <ebiggers@google.com>, Xin Li <xin3.li@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 22, 2024, Sohil Mehta wrote:
> Currently, the cpuid-deps[] table is only exercised when a particular
> feature gets explicitly disabled and clear_cpu_cap() is called. However,
> some of these listed dependencies might already be missing during boot.
> Unexpected failures can occur when the kernel tries to use such a
> feature.
> 
> Therefore, add boot time checks for missing feature dependencies and
> disable any feature whose dependencies are not met.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> Arguably, this situation should only happen on broken hardware and it may not
> make sense to add such a check to the kernel. OTOH, this can be viewed as a
> safety mechanism to make failures more graceful on such configurations in real
> or virtual environments.

And goofy Kconfigs.   But yeah, lack of any meaningful fallout is why my version
didn't go anywhere.

https://lore.kernel.org/all/20221203003745.1475584-2-seanjc@google.com

> I feel since we already have the cpuid-deps[] table and the incremental changes
> are small, this patch might be a useful addition.
> 
> Also, if this check seems worthwhile, would it be useful to combine and rewrite
> it with filter_cpuid_features() since it tries to do something similar?
> ---
> 
>  arch/x86/include/asm/cpufeature.h |  1 +
>  arch/x86/kernel/cpu/common.c      |  4 ++++
>  arch/x86/kernel/cpu/cpuid-deps.c  | 10 ++++++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index 0b9611da6c53..347ef04f65ef 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -148,6 +148,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>  
>  extern void setup_clear_cpu_cap(unsigned int bit);
>  extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
> +extern void filter_feature_dependencies(struct cpuinfo_x86 *c);
>  
>  #define setup_force_cpu_cap(bit) do {			\
>  							\
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index d4e539d4e158..6b725dbd8db7 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1602,6 +1602,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  
>  		c->cpu_index = 0;
>  		filter_cpuid_features(c, false);
> +		filter_feature_dependencies(c);
>  
>  		if (this_cpu->c_bsp_init)
>  			this_cpu->c_bsp_init(c);
> @@ -1854,6 +1855,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	/* Filter out anything that depends on CPUID levels we don't have */
>  	filter_cpuid_features(c, true);
>  
> +	/* Filter out features that don't have their dependencies met */
> +	filter_feature_dependencies(c);
> +
>  	/* If the model name is still unset, do table lookup. */
>  	if (!c->x86_model_id[0]) {
>  		const char *p;
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index b7d9f530ae16..88b34a97278a 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -147,3 +147,13 @@ void setup_clear_cpu_cap(unsigned int feature)
>  {
>  	do_clear_cpu_cap(NULL, feature);
>  }
> +
> +void filter_feature_dependencies(struct cpuinfo_x86 *c)
> +{
> +	const struct cpuid_dep *d;
> +
> +	for (d = cpuid_deps; d->feature; d++) {
> +		if (boot_cpu_has(d->feature) && !boot_cpu_has(d->depends))

I don't think checking boot_cpu_has() is correct, it's entirely possible for a CPU
to have divergent features from the boot CPU, e.g. if a feature is dependent on
BIOS enabling (or disabling) and BIOS messed up.

> +			do_clear_cpu_cap(c, d->feature);
> +	}
> +}
> -- 
> 2.34.1
> 

