Return-Path: <linux-kernel+bounces-211469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE7690521F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2D5285292
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2C16F29D;
	Wed, 12 Jun 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c+5bzZ15"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23654152DF1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194228; cv=none; b=RzAllrRLY6ah1PUBedQ+/+C7OfzZpP8Ds3HrfwaBpGlK5TGPkRV2VQJ6UjunzbMBgGcxoyofh/7q3ENq3dlT9eyXz0aiHyUsf4t8JSFr5C51/qcoeSdZ4pZK3spJlRjZiCzfvTcJhq6vc00oRui+bWzn18evo/R7dLejRoyD08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194228; c=relaxed/simple;
	bh=nE4553TxyitFOBDLcCTTvnCeXYTTa0XYRR7Q8BQg9JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfTwYcMCJPUwLfnVoB3I1hWW5Fm11j4dZgN+g2Ygu1YgJQZ7paMeF8M+mN0l/Wr/xgaN2FyTFXKzTrgcLm6x8oXSyZ0k5zCpEKSPCN7tVDE2matjz+RdFmb8X/rWm+Ie6IhFNzoEYDJ7ydY/mgEXrXKleyK81fdmounjl2LJfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c+5bzZ15; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so33881725e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718194224; x=1718799024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1E6gKaYfsGolM4dsZnb6DX/G/+das4ShQn/qg2O/U=;
        b=c+5bzZ15T9c1mP1Pu+xaPmRsDxIJFIGXOsC+ntY3wUu3H9s66nlEv7hn48vwvKL9PA
         R0dKMPsy3BeQCoMvhDyEqd5Aa/aV+zHWPE8o0zUCYIOW6BaORGlHrqx72FpwiVsxHPdN
         42y0Obi3sydW+FYUakWbrZBbrW3vFy0OR8jgmCM5dfkub9RsOB2/LlumN3Yzfv5hqbrJ
         SJwwYqyCbceid4pV5Axea4OE6OBYeacClRFjCVGx1cRgRFcRUBgta2zYoobkwlbboBlO
         anWA9rYn14M0hUA5YnqbsHGUovWEgeQQS6UByuP1gLf+hZ1lJaP4YmxrK8q15PZrj9a/
         3I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718194224; x=1718799024;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl1E6gKaYfsGolM4dsZnb6DX/G/+das4ShQn/qg2O/U=;
        b=kEDbMrH7wTtXRrjc8StrLBv9LnebZm8czh20EbBsGwER1O9Jwx7SvGEZBch4BtErnI
         sCHEnSi/GkgS0OEd3tX+rnHAVpgChptuYAsQu55MGwWy3adLMW1kDJa/mV2wsKnKlmtO
         Pt+51q8WP73xBat/4cQvuM5xlPiccgBjPYQOn0GRrXJKXapsIEX6mJBCs7l8SABqAdO8
         TqRrJJkkx+5ipAFGrYJzk113LTegIax1LDiqwi0b5amh7fb4badNraZ6FsL68K4SH5xr
         tdWJeJTlmOFBxg4c6ceEkFFygDBSaS/eTLD6NogeKqNs7Cd13GbA39SAAAnYq2ajNphO
         zykw==
X-Forwarded-Encrypted: i=1; AJvYcCUuGEMF0OS2noXzrPxGS8JwnAmrQYxCRfUQW8AhyXZun3Us2xoe68UDggdfrF5J51zCBEV6GHMLxN7MHvat6qIFpwjtaHpYN6dIHHsN
X-Gm-Message-State: AOJu0YwA+PkbFYWOzmQQ7sOVF2ShEGQtluNG5UQ2ZHodl97R/wxhF6cm
	QnYDRMc3lO34rG/NvevDRYX3kTW7SWcnxAl8Qowuv1VCbtHoS+WyM+ssUHVlxTI=
X-Google-Smtp-Source: AGHT+IGGKvFvAX2vsyi3iCxH0IVdZ+RZyQGv87uHYkT/9vnp4Qg0weBEeK0OIcuDUpXL8dTTvAYelw==
X-Received: by 2002:a05:600c:3108:b0:421:7f23:8c5c with SMTP id 5b1f17b1804b1-422866c0c13mr16496455e9.28.1718194224388;
        Wed, 12 Jun 2024 05:10:24 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0c8f5373sm13444819f8f.6.2024.06.12.05.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 05:10:24 -0700 (PDT)
Message-ID: <6eb5c1b2-64d2-42fd-81c9-97c1ae65713f@suse.com>
Date: Wed, 12 Jun 2024 15:10:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Baoquan He <bhe@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <5d7dca1e-5889-4440-b3a0-48610f11200e@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <5d7dca1e-5889-4440-b3a0-48610f11200e@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3.06.24 г. 17:43 ч., H. Peter Anvin wrote:
> On 5/29/24 03:47, Nikolay Borisov wrote:
>>>
>>> diff --git a/arch/x86/kernel/relocate_kernel_64.S 
>>> b/arch/x86/kernel/relocate_kernel_64.S
>>> index 56cab1bb25f5..085eef5c3904 100644
>>> --- a/arch/x86/kernel/relocate_kernel_64.S
>>> +++ b/arch/x86/kernel/relocate_kernel_64.S
>>> @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>>>        */
>>>       movl    $X86_CR4_PAE, %eax
>>>       testq    $X86_CR4_LA57, %r13
>>> -    jz    1f
>>> +    jz    .Lno_la57
>>>       orl    $X86_CR4_LA57, %eax
>>> -1:
>>> +.Lno_la57:
>>> +
>>>       movq    %rax, %cr4
>>>       jmp 1f
>>
>> That jmp 1f becomes redundant now as it simply jumps 1 line below.
>>
> 
> Uh... am I the only person to notice that ALL that is needed here is:
> 
>      andl $(X86_CR4_PAE|X86_CR4_LA57), %r13d
>      movq %r13, %rax
> 
> ... since %r13 is dead afterwards, and PAE *will* have been set in %r13 
> already?
> 
> I don't believe that this specific jmp is actually needed -- there are 
> several more synchronizing jumps later -- but it doesn't hurt.
> 
> However, if the effort is for improving the readability, it might be 
> worthwhile to encapsulate the "jmp 1f; 1:" as a macro, e.g. "SYNC_CODE".


The preceding move to CR4 is itself a serializing instruction, no?

> 
>      -hpa

