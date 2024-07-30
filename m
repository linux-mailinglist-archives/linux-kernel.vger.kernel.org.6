Return-Path: <linux-kernel+bounces-266618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B520694036B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3985D1F247C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA76C2E3;
	Tue, 30 Jul 2024 01:21:59 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AA8C11
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302518; cv=none; b=C1fXG5KNXOtcL/hN2N49FBVdPvhAKekv/o/xc+td3ibo55evPB6QJhwx2gDEyCfDCeCUuFqtlz2CyaHkWQgjyh3cXLSv3IwhlYtIOspOh71qZ2PIyHBF5fGYkDLbgeM4VhyIqfElnSjlZz/SnGTy9dQ0hBIwTMQkFwwfO/44KvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302518; c=relaxed/simple;
	bh=ojieYQM0bouMWUeYdriS9obZZHTpZ91pfRWN04+lcrk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nxzk2e8rQoqDuLvadEHKvlRoAIz7ulGbuQ+1lmoDkl+MaruBnAt/koJpk/86DJEyi0oDinxFOHoKI4LJ5BsV8Vavj3sK5kjhEO4953FYeF5/GW5hYxF7CHmEPqpFZ5PdFGyu1Yya4AOATcv4/+7HyT5Ao84fTo68NdKgPOpYWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxrOowQKhm9RIEAA--.14453S3;
	Tue, 30 Jul 2024 09:21:52 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAxysUqQKhm2q8FAA--.27716S3;
	Tue, 30 Jul 2024 09:21:48 +0800 (CST)
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Nikolay Borisov <nik.borisov@suse.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <08d75c12-215e-3781-ed89-b1ed5c1e39c8@loongson.cn>
Date: Tue, 30 Jul 2024 09:21:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240729065236.407758-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxysUqQKhm2q8FAA--.27716S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GFW5KrWDurWkArW3CFyxCrX_yoW7WrWfpF
	W7J3saqF4xWFW0v39ruw4DuryUAws2kr17Wr4UuryDXan8Wr9Iqr4ktw1Yv3W2gan7Za9Y
	qF10q3sru34DZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2pVbDUUUU

Chenyu,

Sorry to bother you, I am porting pv spinlock to LoongArch platform, I 
do not know the history about function virt_spin_lock().

When CONFIG_PARAVIRT_SPINLOCKS is enabled, there is pv_enabled() before
virt_spin_lock(), it seems that virt_spin_lock is never called in this 
condition.
         if (pv_enabled())
                 goto pv_queue;

         if (virt_spin_lock(lock))
                 return;

When CONFIG_PARAVIRT_SPINLOCKS is disabled, there is no pv qspinlock 
compiled, so what is the usage about function virt_spin_lock()?  Is it
to switch spinlock method from test-set spinlock to qspinlock?  why is 
there such requirement for spinlock switching method?

Regards
Bibo Mao


On 2024/7/29 下午2:52, Chen Yu wrote:
> The kernel can change spinlock behavior when running as a guest. But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> In current code, the static key is always enabled by default when
> running in guest mode. The key is disabled for bare metal (and in
> some guests that want native behavior).
> 
> Large performance regression is reported when running encode/decode
> workload and BenchSEE cache sub-workload on the bare metal.
> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> is disabled, the virt_spin_lock_key is incorrectly set to true on bare
> metal. The qspinlock degenerates to test-and-set spinlock, which
> decrease the performance on bare metal.
> 
> Set the default value of virt_spin_lock_key to false. If booting in
> a VM, enable this key. Later during the VM initialization, if other
> high-efficient spinlock is detected(paravirt-spinlock eg), the
> virt_spin_lock_key is disabled. According to the description above,
> the final effect will be as followed:
> 
> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> PV spinlock                    Y    N    N     Y/N
> 
> virt_spin_lock_key             N    N    Y     N
> 
> To summarize, the virt_spin_lock_key is disabled on the bare metal
> no matter what other condidtion is. And the virt_spin_lock_key is
> also disabled when other spinlock mechanism is detected in the VM
> guest.
> 
> Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
> Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3->v4:
>    Refine the commit log.
>    Added Reviewed-by tag from Nikolay.
> v2->v3:
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
> -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> -		static_branch_disable(&virt_spin_lock_key);
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		static_branch_enable(&virt_spin_lock_key);
>   }
>   
>   static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
> 


