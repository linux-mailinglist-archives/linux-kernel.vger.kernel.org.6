Return-Path: <linux-kernel+bounces-188338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FD8CE0BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B201F22961
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF96EB55;
	Fri, 24 May 2024 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BcI/BiZP"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF379C2
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716529620; cv=none; b=F967/ot7mmFW9XzagCTlzj0Njab3XBam4DMfRKFo/24jzPWDCsJf5d5Ln4840yGBtiGEkdfHGm/LFF/Sm5LmQqYYMz/+nMOgQrPJA9IXJZAM29r4yazZGxqP7HsRSGEvIinYvBkLmfeDu8IaBZGbf+q2iSqo1Dy7/4iOQd/jVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716529620; c=relaxed/simple;
	bh=1DIOq43eTni5xhJN8jtr6RRUFYcuq4+SJJ6O4Vz5yH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjxT4VNeJyfIhHhQE2gObcO5F4YrcL40uEk6YqhjTQRXevY3XBal/wSxVv8DLx/5iY3cNbJvAX4DfQXtICpYP/giqs6iTXtIBDH4bXsqmOfoqR2xbZUDdFNXoKTkqabpW56UMKBHrV/tdsLqMZ57kJJAAW8c5WYqbo7MkOGsrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BcI/BiZP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-578517cab9eso522436a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716529617; x=1717134417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVfoXBklPPjvFUj6/UBgo/e5/IuWsV9MVKXB2Yr1nR0=;
        b=BcI/BiZPrGI/6CecBHyAZf6/1IS+/6xmBCdeEg0wzdvfYGFoROuXL9qybPVpu1v4IT
         Q3tGHb+PFaigVms83Vgsa8+tPgPEZ/qRplMXMN67zS2OqndhE862hUR0kThbe404FCRT
         WeB+foCA/jO0RclYEeDhwMo95wt9+2vqHYx6T+6KWKgZ6dVaYpt4en5exUoKfKOVI71C
         UXimXCn2Wz4Ani7OiytZNZpQf2kbDeLh9D+2QE42E93BPGPEm7ULrU8sOsUg/9Ry7vH+
         suqTGICSp+ruCk7lPeIs9ivl1nfr1M5m4r8xIXbYvHAOxvlWVEI2JUvni3YPkJl3FGzI
         3EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716529617; x=1717134417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVfoXBklPPjvFUj6/UBgo/e5/IuWsV9MVKXB2Yr1nR0=;
        b=cLUETtoTULInyHiYOPS6XtmYW1i+rFjE9xvEj2jGyL5boDaD52OFw9v2l0skWdpCFO
         AxaCSWGDOOUr9g1jLbu1eKKOBazjNmiYhIlvmQ9/4BfxPmhegXZk4NyeoQjlZ8U19rFT
         KaSeUFLKjNVSPXyxFn6MGIYLfjbpOOE/XxS/t/hDpcjyEs0qKIpaHQ0mtYXWYdBRkaUM
         LOLkddB0yqFUGUdNV0gRUg90sKFwxV7aMgui4qdSVdZtB+oXg7SQLMDOEfUxltpcrxyH
         le6aeI1BnKZezOXwYsNsnuSbM8Stu8sM1CDrjQal6Q4Tq1RAh2ZOt+k6Odt+jG2kCVM7
         OtNg==
X-Forwarded-Encrypted: i=1; AJvYcCUc4g5MngoEZ4ILEKqEo0QWy22tDliKFZZpsKxSVBSywTq3nCTNPUuVcWcs6IJ4USBktHjV5eSwLjIGZAKN4lb/ilklLZBnAevUZyZJ
X-Gm-Message-State: AOJu0Yy6OV+N7LTVVedI8RuoSW17U0eFDsPsHR2vpWTe1eCKRp47Y8f0
	fF26j9yfpzCyaxc704FN/D6G3/LAh5tm5HJExH0NiPfy7oUbU4r/7tUqROdjCBI=
X-Google-Smtp-Source: AGHT+IF7akJNnbPZpRl4yGoq2VbtsDCcTkXOq0cDwdRLpwzNDoiIq/YBDRr/pQQyNqONiIZtTspWXA==
X-Received: by 2002:a50:c04c:0:b0:578:5cd3:20b8 with SMTP id 4fb4d7f45d1cf-5785cd32a7fmr282897a12.5.1716529616842;
        Thu, 23 May 2024 22:46:56 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524b5898sm972899a12.82.2024.05.23.22.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 22:46:56 -0700 (PDT)
Message-ID: <92f93c2a-e555-4a70-893c-66345f149aa6@suse.com>
Date: Fri, 24 May 2024 07:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
To: "Huang, Kai" <kai.huang@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Hansen, Dave" <dave.hansen@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org"
 <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
 <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
 <f7edef9c-5eb5-4664-a193-3bb063674742@intel.com>
 <f02d9ebb-a2b3-4cb3-871b-34324d374d01@suse.com>
 <4b3adb59-50ea-419e-ad02-e19e8ca20dee@intel.com>
 <c7319c0614c9a644fa1f9b349bf654834b615543.camel@intel.com>
 <e2d844ad-182a-4fc0-a06a-d609c9cbef74@suse.com>
 <2e07ebc774bf176ebfab40e6ba8bc14ae6a94e0c.camel@intel.com>
 <a9bbb31e6660343e95d3351febc6e3b9661a7944.camel@intel.com>
 <c188878d-ff67-45da-a963-e643bfb927a8@suse.com>
 <cc57bb62-be80-4c97-a8f8-5cd0548c3c11@intel.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <cc57bb62-be80-4c97-a8f8-5cd0548c3c11@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.05.24 00:34, Huang, Kai wrote:
> 
> 
> On 24/05/2024 12:43 am, Jürgen Groß wrote:
>> On 23.05.24 14:26, Huang, Kai wrote:
>>> On Thu, 2024-05-23 at 10:30 +0000, Huang, Kai wrote:
>>>> On Thu, 2024-05-23 at 07:56 +0200, Jürgen Groß wrote:
>>>>> On 20.05.24 13:54, Huang, Kai wrote:
>>>>>> On Fri, 2024-05-17 at 09:48 -0700, Dave Hansen wrote:
>>>>>>> On 5/17/24 08:58, Juergen Gross wrote:
>>>>>>>> On 17.05.24 17:52, Dave Hansen wrote:
>>>>>>> ..
>>>>>>>>> Once we have the specific TDX module version, we can go ask the folks
>>>>>>>>> who write it if there were any RBP clobbering bugs.
>>>>>>>>
>>>>>>>> Okay, how to get the TDX module version?
>>>>>>>
>>>>>>> You need something like this:
>>>>>>>
>>>>>>>> https://lore.kernel.org/all/20231012134136.1310650-1-yi.sun@intel.com/
>>>>>>
>>>>>> This one prints TDX version info in the TDX guest, but not host.
>>>>>>
>>>>>> The attached diff prints the TDX version (something like below) during
>>>>>> module initialization, and should meet Juergen's needs for temporary use:
>>>>>>
>>>>>> [  113.543538] virt/tdx: module verson: major 1, minor 5, internal 0
>>>>>>
>>>>>>>
>>>>>>> .. and yeah, this needs to be upstream.
>>>>>>>
>>>>>>
>>>>>>   From this thread I think it makes sense to add code to the TDX host code
>>>>>> to print the TDX version during module initialization.  I'll start to work
>>>>>> on this.
>>>>>>
>>>>>> One thing is from the spec TDX has "4 versions": major, minor, update,
>>>>>> internal.  They are all 16-bit, and the overall version can be written in:
>>>>>>
>>>>>>     <Major>.<Minor>.<Update>.<Internal>, e.g., 1.5.05.01
>>>>>>
>>>>>> (see TDX module 1.5 API spec, section 3.3.2 "TDX Module Version".)
>>>>>>
>>>>>> The attached diff only prints major, minor and internal, but leaves the
>>>>>> update out because I believe it is for module runtime update (yet to
>>>>>> confirm).
>>>>>>
>>>>>> Given there are 4 versions, I think it makes sense to implement reading
>>>>>> them based on this patchset ...
>>>>>>
>>>>>> https://lore.kernel.org/kvm/6940c326-bfca-4c67-badf-ab5c086bf492@intel.com/T/
>>>>>>
>>>>>> ... which extends the global metadata reading code to support any
>>>>>> arbitrary struct and all element sizes (although all 4 versions are 16-
>>>>>> bit)?
>>>>>
>>>>> With that I got:
>>>>>
>>>>> [   29.328484] virt/tdx: module verson: major 1, minor 5, internal 0
>>>>>
>>>>>
>>>>
>>>> Let me check TDX module guys on this and get back to you.
>>>
>>> Hi Jurgen,
>>>
>>> I was told the module starting with "1.5.06." has NO_RBP_MOD support.
>>>
>>> And I think I was wrong about the <update> part of the version, and we
>>> need that to determine the third part of the module version.
>>>
>>> I was also told the 1.5.06 module hasn't been released to public yet, so I
>>> guess your module doesn't support it.
>>>
>>> I did another patch (attached) to check NO_RBP_MOD and reject module
>>> initialization if it is not supported, and print out module version:
>>>
>>> [  146.566641] virt/tdx: NO_RBP_MOD feature is not supported
>>> [  146.572797] virt/tdx: module verson: 1.5.0.0
>>> [  146.577731] virt/tdx: module initialization failed (-22)
>>>
>>> You can have another try to verify at your side, if that helps.
>>>
>>
>> [   29.362806] virt/tdx: 4071192 KB allocated for PAMT
>> [   29.362828] virt/tdx: module verson: 1.5.1.0
>> [   29.362830] virt/tdx: module initialized
> 
> Seems your module supports NO_RBP_MOD.
> 
> This feature is per-VM and also requires to be explicitly opt-in when creating 
> the guest.  Could you check in your code whether the setup_tdparams() function 
> has below code?
> 
>      td_params->exec_controls = TDX_CONTROL_FLAG_NO_RBP_MOD;

I can confirm that it does have that.


Juergen

