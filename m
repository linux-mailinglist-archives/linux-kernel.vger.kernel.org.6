Return-Path: <linux-kernel+bounces-449410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EE9F4E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6391C16327E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A21F8687;
	Tue, 17 Dec 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QtclZHkI"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D21F5408
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447290; cv=none; b=G8s30WpTZkdGG4n/S0/E/W9qDSPqnifVyNgvwP1LlVWwrgMTUIWzUY1UuKGx9KYUbmtfWaep3fygHgQrAmpCNEuOpSoOoXTyNy9n86MykkQpil0FtmEUWbCVbuy6tOKNehCv54uyJEQBi7cJ8qtVK5i+C6VeGybKmYCpfrPP3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447290; c=relaxed/simple;
	bh=lsyY2ZzrgyQTzPyVTwEgIPA3SsYRNw7fl6QcSiuVfI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1Jct6PIQJ4ojCM1hS9+S6TN1ASJ/NHNsu20DXRkKxwhX3eDUBmdAmUTq/oM/KJeDCE1UBQ+AMyOHKeaHVMIg8emelIHiuEGTJnAlqwmyj3zO3faR0D14Nadp+3coe92Ds4VRpl6/l12zs76BZLRjO2CBNLKJ+kyqoT9tLgTjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=QtclZHkI; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f69e:0:640:3ef4:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 15B0F60E11;
	Tue, 17 Dec 2024 17:54:36 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8011:f00:a4fd:77e3:5bd0:8910] (unknown [2a02:6bf:8011:f00:a4fd:77e3:5bd0:8910])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4sRxc61Ia8c0-uuT4LfFF;
	Tue, 17 Dec 2024 17:54:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1734447275;
	bh=/+XucK4AaxXoTBUUCvuP3OBxAsE6X/iRLAVG9i3p5WY=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=QtclZHkIzIoabU88kKx+adv2FOE7gfFHIx5itnNKSEeuNS0siXNlRyd7Sv1Ok56QQ
	 qC3Za06LlD+FrTHb3jhLVTq2kHwHjV8IYGhKF2m2N7l9LWhEJrd99VVm/HKT/O0Yij
	 FfscCBUsypQvHfs7oEy/RiD3p0a/M8jEn5F9c0LU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <ccded2ba-0306-466f-b04f-2237827635ba@yandex-team.ru>
Date: Tue, 17 Dec 2024 17:54:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/split_lock: fix delayed detection enabling
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: den-plotnikov@yandex-team.ru, gpiccoli@igalia.com, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com
References: <20241125221147.932377-1-davydov-max@yandex-team.ru>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <20241125221147.932377-1-davydov-max@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
Ping

On 11/26/24 01:11, Maksim Davydov wrote:
> If the warn mode with disabled mitigation mode is used, then on each
> CPU where the split lock occurred detection will be disabled in order to
> make progress and delayed work will be scheduled, which then will enable
> detection back. Now it turns out that all CPUs use one global delayed
> work structure. This leads to the fact that if a split lock occurs on
> several CPUs at the same time (within 2 jiffies), only one CPU will
> schedule delayed work, but the rest will not. The return value of
> schedule_delayed_work_on() would have shown this, but it is not checked
> in the code.
> 
> A diagram that can help to understand the bug reproduction:
> https://lore.kernel.org/all/2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru/
> 
> In order to fix the warn mode with disabled mitigation mode, delayed work
> has to be a per-CPU.
> 
> v4 -> v3:
> * rebased the patch onto the latest master
> 
> v3 -> v2:
> * place and time of the per-CPU structure initialization were changed.
>    initcall doesn't seem to be a good place for it, so deferred
>    initialization is used.
> 
> Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> ---
>   arch/x86/kernel/cpu/bus_lock.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
> index 704e9241b964..b72235c8db3e 100644
> --- a/arch/x86/kernel/cpu/bus_lock.c
> +++ b/arch/x86/kernel/cpu/bus_lock.c
> @@ -192,7 +192,13 @@ static void __split_lock_reenable(struct work_struct *work)
>   {
>   	sld_update_msr(true);
>   }
> -static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
> +/*
> + * In order for each CPU to schedule itself delayed work independently of the
> + * others, delayed work struct should be per-CPU. This is not required when
> + * sysctl_sld_mitigate is enabled because of the semaphore, that limits
> + * the number of simultaneously scheduled delayed works to 1.
> + */
> +static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
>   
>   /*
>    * If a CPU goes offline with pending delayed work to re-enable split lock
> @@ -213,7 +219,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
>   
>   static void split_lock_warn(unsigned long ip)
>   {
> -	struct delayed_work *work;
> +	struct delayed_work *work = NULL;
>   	int cpu;
>   
>   	if (!current->reported_split_lock)
> @@ -235,11 +241,17 @@ static void split_lock_warn(unsigned long ip)
>   		if (down_interruptible(&buslock_sem) == -EINTR)
>   			return;
>   		work = &sl_reenable_unlock;
> -	} else {
> -		work = &sl_reenable;
>   	}
>   
>   	cpu = get_cpu();
> +
> +	if (!work) {
> +		work = this_cpu_ptr(&sl_reenable);
> +		/* Deferred initialization of per-CPU struct */
> +		if (!work->work.func)
> +			INIT_DELAYED_WORK(work, __split_lock_reenable);
> +	}
> +
>   	schedule_delayed_work_on(cpu, work, 2);
>   
>   	/* Disable split lock detection on this CPU to make progress */

-- 
Best regards,
Maksim Davydov

