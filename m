Return-Path: <linux-kernel+bounces-566897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3EAA67E08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D64188D7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEE41EEA20;
	Tue, 18 Mar 2025 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="LyRP2TpZ"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25581E52D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329934; cv=none; b=Uj2IUlBZCjQJIoYIsT0qgimnVhLQCbN8IrpDdnE1Fz1DhTP3KfcKTuPXLwrc++6aR3Ueqx+0HeN0m+HWpSexwUE2PQ6Vz2x80yIcZSKzVqPOC2cacJtGT1rmZm0T08uhHgK1CYJApmSHlSFLHSzE0FH9WrzsNibCo/2W1J2FCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329934; c=relaxed/simple;
	bh=R/oAJ7ukd7zqNnKlsYzwQr97Nx+Hou85GSXYQDebBXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKTg6O+nsYoDEDv5y/P6VMju5bth3wVwSSUFz5oR5JeWFjnPPuLiRbEk02Ntvk9AtX3d71f7tD9i19zmkXMMmNdMMzhK7dDX0E0cRdh/Y4aGxeULjzOi19jMDh8mvgIaUpNM2j2dXKOAiWe+swiM1xJk1QBDwvyDNjSrc5SpKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=LyRP2TpZ; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:6351:0:640:b430:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id ED9B160BDD;
	Tue, 18 Mar 2025 23:30:07 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b407::1:6] (unknown [2a02:6b8:b081:b407::1:6])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id kTPfWB6Fba60-wfoEZFQx;
	Tue, 18 Mar 2025 23:30:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1742329807;
	bh=H1eXSfzvDZPMjoikNchtb9s6aEqvxsRmv0op5li+P38=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=LyRP2TpZUZaMyWNF/yiGADln8XiZ35Jh4ynGN0YMfQgWKlLAO2c12Elir3WGADfXg
	 mxRNYDsLaiHci8WzC08dmobmlVWy8L1Qgiow8ckj+MG7z23IEvWhXH3K/JXw0mBSlZ
	 uBBwPn5xFxZXu0aNTE2T3YoLxgTFKJnNZtLsGAaI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <577f712d-4ac3-481f-8bfa-3d667516f338@yandex-team.ru>
Date: Tue, 18 Mar 2025 23:29:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4] x86/split_lock: fix delayed detection enabling
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 den-plotnikov@yandex-team.ru, gpiccoli@igalia.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
References: <20250115131704.132609-1-davydov-max@yandex-team.ru>
 <Z73JRsuderQIW1HT@gmail.com>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <Z73JRsuderQIW1HT@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/25/25 16:44, Ingo Molnar wrote:
> 
> * Maksim Davydov <davydov-max@yandex-team.ru> wrote:
> 
>> If the warn mode with disabled mitigation mode is used, then on each
>> CPU where the split lock occurred detection will be disabled in order to
>> make progress and delayed work will be scheduled, which then will enable
>> detection back. Now it turns out that all CPUs use one global delayed
>> work structure. This leads to the fact that if a split lock occurs on
>> several CPUs at the same time (within 2 jiffies), only one CPU will
>> schedule delayed work, but the rest will not. The return value of
>> schedule_delayed_work_on() would have shown this, but it is not checked
>> in the code.
>>
>> A diagram that can help to understand the bug reproduction:
>> https://lore.kernel.org/all/2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru/
>>
>> In order to fix the warn mode with disabled mitigation mode, delayed work
>> has to be a per-CPU.
>>
>> v4 -> v3:
>> * rebased the patch onto the latest master
>>
>> v3 -> v2:
>> * place and time of the per-CPU structure initialization were changed.
>>    initcall doesn't seem to be a good place for it, so deferred
>>    initialization is used.
>>
>> Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
>> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
>> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>> ---
>>   arch/x86/kernel/cpu/bus_lock.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
>> index 704e9241b964..b72235c8db3e 100644
>> --- a/arch/x86/kernel/cpu/bus_lock.c
>> +++ b/arch/x86/kernel/cpu/bus_lock.c
>> @@ -192,7 +192,13 @@ static void __split_lock_reenable(struct work_struct *work)
>>   {
>>   	sld_update_msr(true);
>>   }
>> -static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
>> +/*
>> + * In order for each CPU to schedule itself delayed work independently of the
>> + * others, delayed work struct should be per-CPU. This is not required when
>> + * sysctl_sld_mitigate is enabled because of the semaphore, that limits
>> + * the number of simultaneously scheduled delayed works to 1.
>> + */
>> +static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
>>   
>>   /*
>>    * If a CPU goes offline with pending delayed work to re-enable split lock
>> @@ -213,7 +219,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
>>   
>>   static void split_lock_warn(unsigned long ip)
>>   {
>> -	struct delayed_work *work;
>> +	struct delayed_work *work = NULL;
>>   	int cpu;
>>   
>>   	if (!current->reported_split_lock)
>> @@ -235,11 +241,17 @@ static void split_lock_warn(unsigned long ip)
>>   		if (down_interruptible(&buslock_sem) == -EINTR)
>>   			return;
>>   		work = &sl_reenable_unlock;
>> -	} else {
>> -		work = &sl_reenable;
>>   	}
>>   
>>   	cpu = get_cpu();
>> +
>> +	if (!work) {
>> +		work = this_cpu_ptr(&sl_reenable);
>> +		/* Deferred initialization of per-CPU struct */
>> +		if (!work->work.func)
>> +			INIT_DELAYED_WORK(work, __split_lock_reenable);
> 
> The INIT_DELAYED_WORK() call shouldn't be done here, but in some sort
> of init function. The control flow is complicated enough already.
> 
> Also, this_cpu_ptr() isn't necessary, we already have 'cpu' as the
> current CPU. per_cpu() ought to be enough.
> 

Sorry for replying late

I fixed these issues in the new version
https://lore.kernel.org/lkml/20250318144911.10455-1-davydov-max@yandex-team.ru/


> Thanks,
> 
> 	Ingo

-- 
Best regards,
Maksim Davydov

