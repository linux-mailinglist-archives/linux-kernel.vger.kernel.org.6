Return-Path: <linux-kernel+bounces-272288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A029459AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FFC28231F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119F1C2305;
	Fri,  2 Aug 2024 08:13:58 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB015AD9C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586437; cv=none; b=mXZLPJ90wn3OYFsZezGkTM09IV9wW0mUlXDyXigmldJ7V0DxDCV/zEXRO9GWau2oZOHo9g3R7cb4xrOygIywVwfRWzOQSiMWW9TP5TttidHXM7aujdOVm48aT0Vumf9QIIf4YYjNm53a56tD9LKVhMN5Wrxcc1WrTtAFzYp1AjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586437; c=relaxed/simple;
	bh=S3QFd9Kl1nKch5VJRX3/dqGnujPwpLW4bRmtw0FjPGw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cFvFgIug5aX1jn/IC39vnAhVLsKOEcwOzyAJyzLkPHLvxB5INfCnrtPOPIgtpENHo0Vdj0wOdZaVDZhAJG1poxRD1UKeRa+YDL+ZIioOUDoahV6JZFeuNB8VOxL05K2rQf4o6MuoSmcxrPF3g2SPMgdrEvsR0TpmNcxWFRB7QME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxqOlBlaxmV18GAA--.20847S3;
	Fri, 02 Aug 2024 16:13:53 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAxRuQ9laxmfmsLAA--.55973S3;
	Fri, 02 Aug 2024 16:13:51 +0800 (CST)
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
To: Chen Yu <yu.c.chen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
 <4d31e1b4-2113-c557-b60a-3a45b2840f26@loongson.cn>
 <ZqueWhX6lqS+1vwg@chenyu5-mobl2>
 <a3c4b603-fc8d-bfa4-7e5d-0b2d8043131b@loongson.cn>
 <ZqyRG7LNx0RMD98e@chenyu5-mobl2>
From: maobibo <maobibo@loongson.cn>
Message-ID: <c543a2e1-a4ea-5f81-cc3f-6bd0185c7461@loongson.cn>
Date: Fri, 2 Aug 2024 16:13:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZqyRG7LNx0RMD98e@chenyu5-mobl2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxRuQ9laxmfmsLAA--.55973S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JFWfZw15GFyrXrWxtw47trc_yoW7ArW5pr
	W7J3Z3KF1kXr4FvwnFvr4vvryjy39Fkw1DXr15W34rJa90vrnIqF4kt3yY9a12qrn7ta97
	tF4UXrZxZa4DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDU
	UUU


Hi Chenyu,
On 2024/8/2 下午3:56, Chen Yu wrote:
> On 2024-08-02 at 09:27:32 +0800, maobibo wrote:
>> Hi Chenyu,
>>
>> On 2024/8/1 下午10:40, Chen Yu wrote:
>>> Hi Bibo,
>>>
>>> On 2024-08-01 at 16:00:19 +0800, maobibo wrote:
>>>> Chenyu,
>>>>
>>>> I do not know much about x86, just give some comments(probably incorrected)
>>>> from the code.
>>>>
>>>> On 2024/7/29 下午2:52, Chen Yu wrote:
>>>>> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
>>>>> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
>>>>> PV spinlock                    Y    N    N     Y/N
>>>>>
>>>>> virt_spin_lock_key             N    N    Y     N
>>>>>
>>>>> -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>>>> +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>>
>>>> @@ -87,7 +87,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
>>>>    {
>>>>           int val;
>>>>
>>>> -       if (!static_branch_likely(&virt_spin_lock_key))
>>>> +       if (!static_branch_unlikely(&virt_spin_lock_key))
>>>>                   return false;
>>>>
>>>> Do we need change it with static_branch_unlikely() if value of key is false
>>>> by fault?
>>>
>>> My understanding is that, firstly, whether it is likely() or unlikely()
>>> depends on the 'expected' value of the key, rather than its default
>>> initialized value. The compiler can arrange the if 'jump' condition to
>>> avoid the overhead of branch jump(to keep the instruction pipeline)
>>> as much as possible. Secondly, before this patch, the 'expected' value
>>> of virt_spin_lock_key is 'true', so I'm not sure if we should change
>>> its behavior. Although it seems that in most VM guest, with para-virt
>>> spinlock enabled, this key should be false at most time, but just in
>>> case of any regression...
>> yes, it does not inflect the result, it is a trivial thing and depends on
>> personal like or dislike.
>>
>>>
>>>>>     /*
>>>>>      * Shortcut for the queued_spin_lock_slowpath() function that allows
>>>>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>>>>> index 5358d43886ad..fec381533555 100644
>>>>> --- a/arch/x86/kernel/paravirt.c
>>>>> +++ b/arch/x86/kernel/paravirt.c
>>>>> @@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
>>>>>     DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
>>>>>     #endif
>>>>> -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>>>> +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
>>>>>     void __init native_pv_lock_init(void)
>>>>>     {
>>>>> -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
>>>>> -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>>>> -		static_branch_disable(&virt_spin_lock_key);
>>>>> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>>>> +		static_branch_enable(&virt_spin_lock_key);
>>>>>     }
>>>>
>>>>   From my point, the sentence static_branch_disable(&virt_spin_lock_key) can
>>>> be removed in file arch/x86/xen/spinlock.c and arch/x86/kernel/kvm.c, since
>>>> function native_smp_prepare_boot_cpu() is already called by
>>>> xen_smp_prepare_boot_cpu() and kvm_smp_prepare_boot_cpu().
>>>>
>>>
>>> The key is enabled by native_smp_prepare_boot_cpu() for VM guest as
>>> the initial value(default to true). And later either arch/x86/xen/spinlock.c
>>> or arch/x86/kernel/kvm.c disable this key in a on-demand manner.
>> I understand that you only care about host machine and do not want to change
>> behavior of VM. Only that from the view of VM, there are two conditions such
>> as:
>>
>> 1. If option CONFIG_PARAVIRT_SPINLOCKS is disabled, virt_spin_lock_key is
>> disabled with your patch. VM will use test-set spinlock rather than
>> qspinlock to avoid the over-preemption of native qspinlock, just the same
>> with commit 2aa79af64263. And it is the same for all the hypervisor types.
>>
>> 2. If option CONFIG_PARAVIRT_SPINLOCKS is enable, pv spinlock cannot be used
>> because some reasons, such as host hypervisor has no KVM_FEATURE_PV_UNHALT
>> feature or nopvspin kernel parameter is added. The behavior to use test-set
>> spinlock or native qspinlock is different on different hypervisor types.
>>
>> Even on KVM hypervisor, if KVM_FEATURE_PV_UNHALT is not supported, test-set
>> spinlock will be used on VM; For nopvspin kernel parameter, native spinlock
>> is used on VM. What is the rule for this? :)
>>
> 
> If CONFIG_PARAVIRT_SPINLOCKS is enabled, the test-set spinlock has nothing to do
> with the lock path, because if pv_enabled() is true, it will skip the
IIRC, if CONFIG_PARAVIRT_SPINLOCKS is enabled, there is two qspinlock 
path: native_queued_spin_lock_slowpath() and 
__pv_queued_spin_lock_slowpath(). pv_enabled is false for native 
qspinlock path native_queued_spin_lock_slowpath(), test-set spinlock can 
be used in function native_queued_spin_lock_slowpath(). pv_enabled() is 
true only for function __pv_queued_spin_lock_slowpath().

> test-set spinlock and go to pv_queue section. If for some reason the pv spinlock
> can not be used because KVM_FEATURE_PV_UNHALT is not supported, it will fall into
> the default qpinlock without pv-qspinlock(no pv_wait hook because it is NULL).
yes, if pv spinlock cannot be used, native_queued_spin_lock_slowpath() 
will be called for spin_lock_slowpath, then there will be native 
qspinlock and test-test spinlock.

Regards
Bibo Mao
> 
> thanks,
> Chenyu
> 


