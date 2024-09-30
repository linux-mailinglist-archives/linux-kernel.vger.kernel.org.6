Return-Path: <linux-kernel+bounces-344534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0366C98AAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4031C22E28
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A19198853;
	Mon, 30 Sep 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmppZikH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E4195FFA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716680; cv=none; b=ksTlhc7yOrIwCtNli74gm5OkDqBqYTWeVyPF6Omi39MST84fB+et3t1HF963OvOZwU4cC7y97a4hcuML3NzRQJtPx/Qbs11QjQZgYmKQwfqPIYeo+nqhnHHM3O5gd3vVVZkSv721GRhjWUTyzv60Qhq+CxuLLfMFz7XPRms/j6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716680; c=relaxed/simple;
	bh=NvPBwyfXuKXWiV7WztrR3/MoDQYRIo2q+HCemDNtZBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqngfEoIAlMlaA5Mt6zs+vQ/w8co7PGvdpAfsg1W+6R/pNVt3fnEaMcSCoyVI3WVrFeTV9Gd9AG12lFI9n2ozuG0py4UI72Z8lN/6kDhAh8PN0u3Dq1UhXzyBHK6oMis7ibRIyti5AThuHNmvYHSMMl9BPejwxMiGG4tmXiR4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmppZikH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727716675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XelBiNVf3qEnPLGuRSPY0Kckuvuub64gIAfIBwRaWcM=;
	b=GmppZikHlRKAAHlIDk8WKa7riXUTjPAoisR8cOCAHESEw6sxeN65bVbHJWGr+SXbJ0wSm8
	Iy7fxyzGo7uB1GaMfMELQhyafW+wGMla+GWoXkYZAVNJ4t14pXO1nsX0tKE73xB9KwqNJq
	ERkqwz3c3JwUkbNEt/eelYMaDHLc2I0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-4mf0UNDtP5O3Qq-aLDXuVg-1; Mon, 30 Sep 2024 13:17:53 -0400
X-MC-Unique: 4mf0UNDtP5O3Qq-aLDXuVg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso28533665e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716672; x=1728321472;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XelBiNVf3qEnPLGuRSPY0Kckuvuub64gIAfIBwRaWcM=;
        b=ntJUHJ59rfaBRm8dADWF1pdDuUuaURgf3GgbzPrfVDu5IWnYl2ZnT7uxuru2zebxnF
         pYFh/3klF+zDktlhaqpL+eCbx6+dsW1tcO/cKCZcvFcqIaHy41CNzROdgfVcvwWoDAM3
         2dQm1JuB4ZcgpAlYv7MYaUHqlshonKUYZTulI9c4BTZG5H/4h5vrawG88OHJrKAGuiZi
         fwtZXqrha0MwJp+eNdLBDnwSmu+pK36uUm5vBxcsoaPvECdo/NAaEe+nyVFHIQ1ZmwUE
         FrriWEafgFgjdwm9MPtGYo04RYCXTq5oMI6SXEwZOo48Uq3ViccTeic6wU5mUW7fTXyK
         hkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoTVIi6MbLMw9yGHz+rafSykFjA9xeSYKPPHtfZqTs4yZoNTSKWJ1xiwzmKoaLeD0iOz93RdRoA8mjxVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrbkY6+BNmkRuRnYLUW4eB2wjBNTQs7Csb/zF0HG/bvq3D8y4b
	NswDLo/9DABjcnDsXUntPZzaEC8Bz8yXDej2/ko3QCstJL2/0EtOwhY2CdMd1QId6TZTkBl3mqq
	i2h1flMw51BSiKruEtW5qyIcyNyuNsugWrB7S9xw91OM6DJ0Jak8ywAYpJnzgow==
X-Received: by 2002:a05:600c:4515:b0:428:10ec:e5ca with SMTP id 5b1f17b1804b1-42f584160b6mr94431715e9.14.1727716672055;
        Mon, 30 Sep 2024 10:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU2xwDc0Ap4WXKeAzUiUdjfNfK9b2yJ4SYTzwEhkrbpYdpY4QjKEvH4BAcgpH1AioHmiJTlg==
X-Received: by 2002:a05:600c:4515:b0:428:10ec:e5ca with SMTP id 5b1f17b1804b1-42f584160b6mr94431555e9.14.1727716671636;
        Mon, 30 Sep 2024 10:17:51 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.43.71])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f57e13944sm109836835e9.30.2024.09.30.10.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:17:51 -0700 (PDT)
Message-ID: <34b68d1e-7982-48e0-8d8a-5d3e0737ab42@redhat.com>
Date: Mon, 30 Sep 2024 19:17:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] KVM/x86 changes for Linux 6.12
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240928153302.92406-1-pbonzini@redhat.com>
 <CAHk-=wiQ2m+zkBUhb1m=m6S-H1syAgWmCHzit9=5y7XsriKFvw@mail.gmail.com>
 <a402dec0-c8f5-4f10-be5d-8d7263789ba1@redhat.com>
 <ZvrXbRLzAThvpoj4@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZvrXbRLzAThvpoj4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/24 18:53, Sean Christopherson wrote:
> On Mon, Sep 30, 2024, Paolo Bonzini wrote:
>> On Sun, Sep 29, 2024 at 7:36 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> The culprit is commit 590b09b1d88e ("KVM: x86: Register "emergency
>>> disable" callbacks when virt is enabled"), and the reason seems to be
>>> this:
>>>
>>>    #if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
>>>    void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback);
>>>    ...
>>>
>>> ie if you have a config with KVM enabled, but neither KVM_INTEL nor
>>> KVM_AMD set, you don't get that callback thing.
>>>
>>> The fix may be something like the attached.
>>
>> Yeah, there was an attempt in commit 6d55a94222db ("x86/reboot:
>> Unconditionally define cpu_emergency_virt_cb typedef") but that only
>> covers the headers and the !CONFIG_KVM case; not the !CONFIG_KVM_INTEL
>> && !CONFIG_KVM_AMD one that you stumbled upon.
>>
>> Your fix is not wrong, but there's no point in compiling kvm.ko if
>> nobody is using it.
>>
>> This is what I'll test more and submit:
>>
>> ------------------ 8< ------------------
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH] KVM: x86: leave kvm.ko out of the build if no vendor module is requested
>> kvm.ko is nothing but library code shared by kvm-intel.ko and kvm-amd.ko.
>> It provides no functionality on its own and it is unnecessary unless one
>> of the vendor-specific module is compiled.  In particular, /dev/kvm is
>> not created until one of kvm-intel.ko or kvm-amd.ko is loaded.
>> Use CONFIG_KVM to decide if it is built-in or a module, but use the
>> vendor-specific modules for the actual decision on whether to build it.
>> This also fixes a build failure when CONFIG_KVM_INTEL and CONFIG_KVM_AMD
>> are both disabled.  The cpu_emergency_register_virt_callback() function
>> is called from kvm.ko, but it is only defined if at least one of
>> CONFIG_KVM_INTEL and CONFIG_KVM_AMD is provided.
>>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>> index 4287a8071a3a..aee054a91031 100644
>> --- a/arch/x86/kvm/Kconfig
>> +++ b/arch/x86/kvm/Kconfig
>> @@ -17,8 +17,8 @@ menuconfig VIRTUALIZATION
>>   if VIRTUALIZATION
>> -config KVM
>> -	tristate "Kernel-based Virtual Machine (KVM) support"
>> +config KVM_X86_COMMON
>> +	def_tristate KVM if KVM_INTEL || KVM_AMD
>>   	depends on HIGH_RES_TIMERS
>>   	depends on X86_LOCAL_APIC
>>   	select KVM_COMMON
>> @@ -46,6 +47,9 @@ config KVM
>>   	select KVM_GENERIC_HARDWARE_ENABLING
>>   	select KVM_GENERIC_PRE_FAULT_MEMORY
>>   	select KVM_WERROR if WERROR
>> +
>> +config KVM
>> +	tristate "Kernel-based Virtual Machine (KVM) support"
> 
> I like the idea, but allowing users to select KVM=m|y but not building any parts
> of KVM seems like it will lead to confusion.  What if we hide KVM entirely, and
> autoselect m/y/n based on the vendor modules?  AFAICT, this behaves as expected.

Showing the KVM option is useful anyway as a grouping for other options 
(e.g. SW-protected VMs, Xen, etc.).  I can play with reordering 
everything and using "select" to group these options, but I doubt it
will be better/more user-friendly than the above minimal change.

And also...

> Not having documentation for kvm.ko is unfortunate, but explaining how kvm.ko
> interacts with kvm-{amd,intel}.ko probably belongs in Documentation/virt/kvm/?
> anyways.

... documentation changes can wait for 6.13 anyway, unlike fixing
the build (even if in a rare config that would mostly be hit by
randconfig).

> If you haven't already, can you also kill off KVM_COMMON?  The only usage is in
> scripts/gdb/linux/constants.py.in, to print Intel's posted interrupt IRQs in
> scripts/gdb/linux/interrupts.py, which is quite ridiculous.

Sure.

Paolo


