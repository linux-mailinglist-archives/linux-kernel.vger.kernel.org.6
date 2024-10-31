Return-Path: <linux-kernel+bounces-389909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6A39B72C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAA42867C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6812C465;
	Thu, 31 Oct 2024 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F94QVdwi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8041C77
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730344358; cv=none; b=PLQFXvPJOB5m055qJRrYKzQg3e9xXg7x47nAAnPQqkBq1yxN44YqDRBl6x0QGQu87sfyBTowWySQ+DrHzkkDXQCoRPBpjF/395x/CQisg8QUN8xOFzuNfzPUHQmOuwc7VkeSfZLx0i8/klg2SdDTyUNTeSig0TsAAzCYZdIUSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730344358; c=relaxed/simple;
	bh=j6xVxsXnS8lP99lTBzS55EovZHLuyMKgWEoe4QtbIZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZSIo/jCJP+3cRBAl4m3aBWbACZ+BLUjX1oAtbiAafG1LQ6Y5DK4hBHXt3TWVNS/exAxE08zsXFKfyVr7U+rdt81poUJHQArI+pRvcukhdoblRA0SXjJdZ33XzKZsMTuNFjdXDYpM3Rn3uW3u6ECjzZCq3PuiwOeuULjFmcipOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F94QVdwi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730344354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTcn/fPUEPCVIhM9W+KJ9dVkd6Xp9RZ6Mf0OP58hRpo=;
	b=F94QVdwi8KGb3GjGyaVX5GzkEYvoJHm9bs1VnSzLAQZabcsihvGDsOIfhz5TmJbTPItLFX
	Ldo6ApBhkquAXapvyDuaQ0lPmDMlu+rbSEWEvZBif/GU2wTUgTlafthXNK3YKDggvP8EX5
	tgFWOnOQdnLkT6TSuPwPBZX+xk+tl+w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-gwFHiVdMOG6vJfJ_lqbb3w-1; Wed, 30 Oct 2024 23:12:33 -0400
X-MC-Unique: gwFHiVdMOG6vJfJ_lqbb3w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e3be80e9f3so1395349a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730344351; x=1730949151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTcn/fPUEPCVIhM9W+KJ9dVkd6Xp9RZ6Mf0OP58hRpo=;
        b=SspapJWkzaY4ciqyHHwvhNY2S9X50bwahFvnTT9TOOzAVTOFvEe+PMXmbNYQcf8J+W
         nIsZ8PKEEvLyG9Jeeed5teWS009XwdaXzegfF0o8ikHkWvUQD13YLmfEPWz+D0qqKF5/
         KvKHBsmVc45CPirHF6Xril4Wm2UQIuSCQWxJfkCixD0+bBWUy8u3hTZfbXi/BE81dE5O
         HE9vr7x55uTJnTQStoG5pG8+XMxfoXdDZJ6ULJ05PDaxQZ9i5i0JxMrpvAeJn3m+8Atl
         vlDJ+10pBFo7+BjjRfyoj6ZBZzpWOm4mYwM3xKyNEsQ4qNRK/Fv2yBvNlg9R87T0SkUF
         oW+w==
X-Forwarded-Encrypted: i=1; AJvYcCXclncpifOvSwjg1m4GW+I8Fqly2uCied5g+7eoyoZZYrGc7ktE4xO/mQ+3sWiYjumCRozdPwZ2qBYUc9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUF5/FL4E3ThaXA795mODNLtRCcNB/+ORNB05AEdDg4uvGENy2
	7UirVgWT3uuekbU07ErdqTxg95wEf1Bnt5rm/fJhf0pLK8gcAS1HKdEO3ZmKIszDTEe1D47X5PI
	e4lAQarH7YS8OZwS+DPvLzXePKWck17zSgbcc8U9luWrtyGHAJ+X5T/HCsVP47MJdoTRk9jRe
X-Received: by 2002:a17:90b:1844:b0:2da:6e46:ad48 with SMTP id 98e67ed59e1d1-2e93e058c03mr1465099a91.1.1730344351452;
        Wed, 30 Oct 2024 20:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDUOe3x7LQ/M3/+26G2FoLgVX0MJvm1eLjlAsEfhteoWB6OmAuc6Y5WFI5zoL8xr+mEBaiOg==
X-Received: by 2002:a17:90b:1844:b0:2da:6e46:ad48 with SMTP id 98e67ed59e1d1-2e93e058c03mr1465078a91.1.1730344351060;
        Wed, 30 Oct 2024 20:12:31 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92c53868bsm1709608a91.1.2024.10.30.20.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 20:12:30 -0700 (PDT)
Message-ID: <2e94df8e-ab9b-4214-86d0-e9efaa40aaf8@redhat.com>
Date: Thu, 31 Oct 2024 13:12:25 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
To: Jeremy Linton <jeremy.linton@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: steven.price@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, sami.mujawar@arm.com, linux-kernel@vger.kernel.org
References: <20241029141114.7207-1-jeremy.linton@arm.com>
 <32211eb5-eed5-4c71-b62a-362d32e1af47@redhat.com>
 <b62b9ba4-eaf9-4533-9a97-7d5e2929b1e8@arm.com>
 <98b47e47-9014-45d1-86c7-4b78ff36bf54@redhat.com>
 <86b2aef1-8926-47c8-8a33-9f02e3dd7d72@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <86b2aef1-8926-47c8-8a33-9f02e3dd7d72@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jeremy

On 10/31/24 12:08 PM, Jeremy Linton wrote:
> On 10/30/24 5:48 PM, Gavin Shan wrote:
>> On 10/31/24 1:16 AM, Jeremy Linton wrote:
>>> On 10/29/24 7:23 PM, Gavin Shan wrote:
>>>> On 10/30/24 12:11 AM, Jeremy Linton wrote:
>>>>> The TSM module provides both guest identification as well as
>>>>> attestation when a guest is run in CCA mode. Lets assure by creating a
>>>>> dummy platform device that the module is automatically loaded during
>>>>> boot. Once it is in place it can be used earlier in the boot process
>>>>> to say decrypt a LUKS rootfs.
>>>>>
>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>> ---
>>>>>   arch/arm64/include/asm/rsi.h                    |  2 ++
>>>>>   arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>>>>>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  7 +++++++
>>>>>   3 files changed, 24 insertions(+)
>>>>>
>>>>
>>>> I don't understand how the TSM module is automatically loaded and arm_cca_guest_init()
>>>> is triggered because of the newly introduced platform device. Could you please provide
>>>> more details? Apart from it, some nick-picks as below.
>>>
>>> I think your asking how the module boilerplate here works, AKA how the standard uevent/udev/modalias/kmod stuff works? The short version is that the platform bus uevents an add device with a modalias and userspace udev + kmod finds matching modules, and their dependencies, and loads them which triggers the module_init() calls.
>>>
>>> The suse folks have a detailed description of how this works:
>>> https://doc.opensuse.org/documentation/leap/reference/html/book- reference/cha-udev.html#sec-udev-kernel
>>>
>>> So, this is a fairly common misuse of the platform bus, in this case to avoid needing a HWCAP. Assuring the module exists in the initrd will then result in it being loaded along any other modules required for the rootfs pivot.
>>>
>>>
>>
>> Thanks for the explanation and details. The module won't be automatically loaded if
>> udev daemon isn't in place or the DEV_ADD event is ignored for whatever reasons. For
>> example the corresponding ACTION for DEV_ADD of this particular device is null in the
>> udev rules. So it's not guranteed that the module can be automatically loaded until udev
>> is in place and udev rules have been configured properly. It's a best- effort attempt
>> if I don't miss anything.
> 
> This functionality has been standard in all but the most deeply enmbedded linux systems for a couple decades now (AFAIK). The platform and modalias logic should largely just work everywhere that its appropriate to be building this as a module. And to be clear that is without updating any of the existing rules.
> 

Right, it's also what I understood. What I requested is just to mention it
in the change log if you agree, something like below. With this, the change
log looks complete to me.

"The TSM module will be loaded by udev daemon after it receives the device addition event."

>>
>> Could you please update the change log to mention the automatic module loading depends
>> on udev and its rules? In this way, readers will know it's a best-effort attempt at least.
>>

Thanks,
Gavin


