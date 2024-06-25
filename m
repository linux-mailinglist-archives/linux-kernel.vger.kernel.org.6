Return-Path: <linux-kernel+bounces-228968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82D4916932
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B55D280F38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1715FA8F;
	Tue, 25 Jun 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xfc12/bV"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B71815ECE5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322938; cv=none; b=lPRSziKHDMhMgEXKHWjQZigeN6ff35J2lYjH++YeTi96VPWSi3iq0gJxBRT+wU10iHJ3K0TIpYAZ/cnbM5oLfWGBEBGgmtCR5lXEt9IDzQI3b2zQxiSztV4th4Vf1nyTZhbQes/F0zQ6lbQbsD9zYD0DkFZFgfpwooJYXE3v9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322938; c=relaxed/simple;
	bh=kCWUIGs9OZe3ZSPUsdL0AZKlZk6a6lOvSF+HkD/n7YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFTQFJdOh0Srrel8t/t6GGNr8MEJvRABneFh7hYDNs3i/aMjPc/vGvfLWjiE+pcAZ0jP6rj+OheiZ1VoIDmxJrHOnHZcDI8ex49hQjuXs7V+zX4aoeFPVPyGgAyx8MhjLLRPP0Guz7Tfnq5GSIguEnl6N7VEUF6v2p72rV95hXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xfc12/bV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36701e6c6e8so309671f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719322933; x=1719927733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrBw1ViXI8PKGjD0P3Qbt3rk/F/dAyXw362A2nW4GkE=;
        b=Xfc12/bVU3Gvc3mIPA+RiLJoycWvQlFicTKaWhjOv7MYOwKoa0FYSLEmtZY2SGI4bM
         55I9qGy0BlX/q+0Y5+VpJp7q0XehSuiNpbReILF+o3EKzrcNxD+DyJl/fnjgxG3yCAN9
         RjwALHPF5hfVcLZNUdyxlgMGPjqy9/B1D28FiV6sFR0tyP6pOjitz+DkNvcaZCDuOoJl
         gYKMFPlIXNp5jVCjEKyWoIUnPnmKOdjX18W85lXlT8nyXAhMXZLBqHqomiTtk1jLSXea
         Oy7LYO75bVCruobFzNlTP7e4eTiaNbi1lE7ii7J2a7eEAO1Xn9FLOSiybJjb5CRx474y
         Y4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322933; x=1719927733;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrBw1ViXI8PKGjD0P3Qbt3rk/F/dAyXw362A2nW4GkE=;
        b=TLjUMw0pcaSRv2E7eYPYx+icU22YkC2a5OjOtn19Y7veUC1xGyM1Z779/j35DsRcSu
         ErIimSvZPHbXvrIzbxSUEPyvcR9sDHPejvOvknsvkkAefOEJG7V/bZiE3LSr9oVmcNEi
         y+GkKLP58s4ke49mtBMHPglBrueLooki4PCfuZW4I6pHZBUcFLls3ilkQ3crC788SsMM
         Ih2WzxUeTBJNpxKY/0IewCrBwXs8Aagj9fvltjv6TV/t1YPwpCm5tuzKYncE3G2L3F7L
         WX1hay5u4JWqdSzTG0uMXSNk0Sn12T+ZvCFS+uOfR0trtoaOHdN6zE+6YtLnj3LNY0bI
         +WAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNyTVMBug/I6fhulQ8e6SI/YbWnJIXlAB3EUT/p2O830U3POMYVpQdyexpHTwI3SxSfBmobR+1PMz2rxvOSZkthjrLpEcOHj2bjy60
X-Gm-Message-State: AOJu0Yxt6TDsXWyNG/Ar99RrF9xX+fDhmRTAVMucm8bNFnNFnqbWCMhd
	wwF1fO1D80EuRYDE0fCMa7Svi8e887QtadoUwBa3u/+wreazxDRzGNi0lVVf4xI=
X-Google-Smtp-Source: AGHT+IGfxVH8cZhLOCvXgvPNcvNOE8ex439nMaaAuCPU2WaO9XCX6Uc4t/p/Ojo8lUWJHTo7ui6OzA==
X-Received: by 2002:adf:f6d0:0:b0:35f:231e:ef87 with SMTP id ffacd0b85a97d-366e7a3634fmr6303452f8f.29.1719322933410;
        Tue, 25 Jun 2024 06:42:13 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada0f8csm12930687f8f.115.2024.06.25.06.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 06:42:12 -0700 (PDT)
Message-ID: <224793a4-da57-4621-ac29-7eac35c2da08@suse.com>
Date: Tue, 25 Jun 2024 16:42:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Chen Yu <yu.chen.surf@gmail.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240625125403.187110-1-yu.c.chen@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240625125403.187110-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.06.24 г. 15:54 ч., Chen Yu wrote:
> The kernel can change spinlock behavior when running as a guest. But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> The static key is always enabled by default (run in guest mode) and
> should be disabled for bare metal (and in some guests that want native
> behavior).
> 
> Performance drop is reported when running encode/decode workload and
> BenchSEE cache sub-workload.
> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> is disabled the virt_spin_lock_key is incorrectly set to true on bare
> metal. The qspinlock degenerates to test-and-set spinlock, which
> decrease the performance on bare metal.
> 
> Set the default value of virt_spin_lock_key to false. If booting in a VM,
> enable this key. Later during the VM initialization, if other
> high-efficient spinlock is preferred(paravirt-spinlock eg), the
> virt_spin_lock_key is disabled accordingly. The relation is described as
> below:
> 
> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> PV spinlock                    Y    N    N     Y/N
> 
> virt_spin_lock_key             N    N    Y     N
> 
> Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
> Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2._v3:
>    Change the default value of virt_spin_lock_key from true to false.
>    Enable this key when it is in the VM, and disable it when needed.
>    This makes the code more readable. (Nikolay Borisov)
>    Dropped Reviewed-by because the code has been changed.
> v1->v2:
>    Refine the commit log per Dave's suggestion.
>    Simplify the fix by directly disabling the virt_spin_lock_key on bare metal.
>    Collect Reviewed-by from Juergen.
> ---
>   arch/x86/include/asm/qspinlock.h | 4 ++--
>   arch/x86/kernel/paravirt.c       | 7 +++----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index a053c1293975..a32bd2aabdf9 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -66,13 +66,13 @@ static inline bool vcpu_is_preempted(long cpu)
>   
>   #ifdef CONFIG_PARAVIRT
>   /*
> - * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
> + * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
>    *
>    * Native (and PV wanting native due to vCPU pinning) should disable this key.
>    * It is done in this backwards fashion to only have a single direction change,
>    * which removes ordering between native_pv_spin_init() and HV setup.
>    */
> -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
>   
>   /*
>    * Shortcut for the queued_spin_lock_slowpath() function that allows
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 5358d43886ad..fec381533555 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
>   DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
>   #endif
>   
> -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>   
>   void __init native_pv_lock_init(void)
>   {
> -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&

Actually now shouldn't the CONFIG_PARAVIRT_SPINLOCKS check be retained? 
Otherwise we'll have the virtspinlock enabled even if we are a guest but 
CONFIG_PARAVIRT_SPINLOCKS is disabled, no ?

> -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> -		static_branch_disable(&virt_spin_lock_key);
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		static_branch_enable(&virt_spin_lock_key);
>   }
>   
>   static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)

