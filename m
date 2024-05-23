Return-Path: <linux-kernel+bounces-187889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C9E8CDA16
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEFB283397
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC7763E6;
	Thu, 23 May 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a4tS3Ipj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129357E586
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489604; cv=none; b=fuHpC7PsRDYsSdEIND9KNc+UVw2zBRlRruV4v1fg46wV2oG0ShJ0DwIBBPX01mZABT0Fc9gMSWfmltzYpQw4sq7mANMljmYQcuzSzxwKoIgzQC3OBd6ro+GGTa0xha76YCAZE4zL/O9z/SUijrc6zW5t4+N4vrhc24jqTKRjWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489604; c=relaxed/simple;
	bh=yRsCEoicgaKzohe9lKyCvRJ8ywpHXjW4YO2bnP2lO30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDd4OsC+Rk++38CLAMrAotDIZ5EyBhNgs4vOxxIUPGgYJ6+X5k2V5WX92rNmqneIo9e5rrwZad+TbvVcECZ7jCcga4JzshUlcf/2XJe42y/u6E/wNdS5N/cFeRr0Bs8lALXPJAvF1wrYEJrSAN0IAvCaMFCUAJ/mHJvPU6ozWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a4tS3Ipj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57851608e72so107488a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716489600; x=1717094400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPNsSdDaQu0NIT3u7mvtcXRasJFxRX07JUknJPwEvjQ=;
        b=a4tS3IpjbyL6c2JGaNh2OvEtlug7cUCRkt9+3j0UJjwrPQImmOIdK7U4DNNVlpb7f7
         Pr2hObXjEjYOLD6Dv8mlR9ZJwDVrX1Upm/jWSSnOqqcU/sORPy9lj32xYCXn6spuVDaq
         J5he9Yzb2SfwvRKo6V8wh2/D70uVuDepjmo/jdwUeCapBoXPEmPliFgzyE0CHzSxF9PT
         WqX+5sawNJDwPeEZEY0q5Oyor9V+fOzgbMyUDpF9XBoagCkT1weOCs/yn9lIkGgNLxDE
         pgbY1pT+KCxExIUdIrEgM8MbzKwMn/b53Y8oT5U+OHJXKt+XIFZyYnBOJDvVZqNg/O4n
         N24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489600; x=1717094400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPNsSdDaQu0NIT3u7mvtcXRasJFxRX07JUknJPwEvjQ=;
        b=JWCRCDQsAvZhrzXKREYgVtzIHbibiN2dVd32lG2ewyWWhgOVI/D613ksYVoLpTlHMB
         CU6r+8yOOTsWVviDRneKXbZTs7QwwytqZxgRE75LcMFD9sl387jYIVFU0S75G2HFWlsB
         atLG+W9YhAD3Q0NUfc2vtMoXRsuy6p++vdiPCEz0IKGoILUtyw2z8aj2C97U9C/U2MYe
         n8hdT4V9kBctbyqPQea/RIZpriG8jpBp/0eKzxcq7KIQQGV3EvVNHElCIsFzYtbAIA0o
         RBzibpdBgFRGyznNf3tcj3jPLjTSDBKCYXjKD5T0DSmnL7EIKDfgVyBuXdFTgqLg1GSN
         Pnlg==
X-Forwarded-Encrypted: i=1; AJvYcCX5vr7M2X8JUUodvHJMVclGk6/Uc/IN9HPNK1tI1VJa9qeyxayEJXK45JDX0KFodnS3za+kZ8gdErLZ4GBaBejZPs1fB1vHmrTYINQC
X-Gm-Message-State: AOJu0YxkEsbB1AUCXaQB5mZZkXjnHKupRxDCAe4GaLVvSHRUAbl+81ni
	KUf8iP5dODlvRF3rkrruKYxVdQWy8Q+3qU6/lPtjixlFDd/OAx/D+1WLBGDfAco=
X-Google-Smtp-Source: AGHT+IFM7nm2N0VSaiUAIdHdhDX4MAHlidFK15butLgqOhVX08TvLNZIrl9+UlWMHnQ9lqjE99W5qw==
X-Received: by 2002:a17:906:e52:b0:a59:cb29:3fb8 with SMTP id a640c23a62f3a-a62641a392fmr12916666b.1.1716489600370;
        Thu, 23 May 2024 11:40:00 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d9dsm1973152566b.132.2024.05.23.11.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:40:00 -0700 (PDT)
Message-ID: <ec8b5d13-3034-4255-ace3-cf1564646da9@suse.com>
Date: Thu, 23 May 2024 20:39:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/paravirt: Disable virt spinlock when
 CONFIG_PARAVIRT_SPINLOCKS disabled
To: Dave Hansen <dave.hansen@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240516130244.893573-1-yu.c.chen@intel.com>
 <7b8d1dd6-3913-45fe-941e-aac2c15916dc@intel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <7b8d1dd6-3913-45fe-941e-aac2c15916dc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.05.24 18:30, Dave Hansen wrote:
> On 5/16/24 06:02, Chen Yu wrote:
>> Performance drop is reported when running encode/decode workload and
>> BenchSEE cache sub-workload.
>> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
>> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
>> is disabled the virt_spin_lock_key is set to true on bare-metal.
>> The qspinlock degenerates to test-and-set spinlock, which decrease the
>> performance on bare-metal.
>>
>> Fix this by disabling virt_spin_lock_key if CONFIG_PARAVIRT_SPINLOCKS
>> is not set, or it is on bare-metal.
> 
> This is missing some background:
> 
> The kernel can change spinlock behavior when running as a guest.  But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> The static key is always enabled by default (run in guest mode) and
> should be disabled for bare metal (and in some guests that want native
> behavior).
> 
> ... then describe the regression and the fix
> 
>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>> index 5358d43886ad..ee51c0949ed8 100644
>> --- a/arch/x86/kernel/paravirt.c
>> +++ b/arch/x86/kernel/paravirt.c
>> @@ -55,7 +55,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>   
>>   void __init native_pv_lock_init(void)
>>   {
>> -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
>> +	if (!IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) ||
>>   	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>   		static_branch_disable(&virt_spin_lock_key);
>>   }
> This gets used at a single site:
> 
>          if (pv_enabled())
>                  goto pv_queue;
> 
>          if (virt_spin_lock(lock))
>                  return;
> 
> which is logically:
> 
> 	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS))
> 		goto ...; // don't look at virt_spin_lock_key
> 
> 	if (virt_spin_lock_key)
> 		return; // On virt, but non-paravirt.  Did Test-and-Set
> 			// spinlock.
> 
> So I _think_ Arnd was trying to optimize native_pv_lock_init() away when
> it's going to get skipped over anyway by the 'goto'.
> 
> But this took me at least 30 minutes of scratching my head and trying to
> untangle the whole thing.  It's all far too subtle for my taste, and all
> of that to save a few bytes of init text in a configuration that's
> probably not even used very often (PARAVIRT=y, but PARAVIRT_SPINLOCKS=n).
> 
> Let's just keep it simple.  How about the attached patch?

Simple indeed. The attachment is empty. :-p


Juergen

