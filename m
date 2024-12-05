Return-Path: <linux-kernel+bounces-432826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4691C9E50BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1808B1882FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821B1DA602;
	Thu,  5 Dec 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CKpzL5Ir"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B21D89F7
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389583; cv=none; b=fotN1FN4Dzt9HNTMvb02gkjAnjCpdHh0w7V5nqMq0S2kI6RoXPVo/a/3Icii9WgypuVEPh/Aqk3JatK1onnrrP2Eq9vki9oYdKCNbPRejCx8u6vYIJPopVhfyV57hPSer6Pb5IMhlM8hln9aAmn8+ouYRlehQg1GzBx3IDH2/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389583; c=relaxed/simple;
	bh=5XQ1HXYwbTTZdTWh2utJMKfmU8iPPThgBP2pbSMhge4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1QvNJfdO5RhQ09hdP+ngx2ljzcpTHIQQWMFuwpD9Q0nBhMiJUSkvqR0jH9E8GTDs6haiCHV3umnn9SsECSnZ/G3RiKKdMgqGEERC4CZ7xC5v3naOXEKl5cTBYTMPdUHjuDCjsW1Qvr99rIM0ajlNqXHqB309BdWaDe9iKeZe00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CKpzL5Ir; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a1639637so7359965e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733389580; x=1733994380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2t7W4OrRjFhEWmecg84hD7xOx3YqRZ5sVEwAFgCNS2o=;
        b=CKpzL5IrX0eIk0XVzZ8UGfVYS83tv0biAwoyaTHfbfYUYxGJiS5xbMGxd6R/prvi2q
         FKps1xaqQYTLemjXnz1/cg9KBvdAPKiFSbl9I0FU2cFb1O87Xrqn4hOz706YYuGg94c2
         WmaZr1SVx343iBUPWVkkAnqB6kAJD+OHQG5N2nutrZaqPsGLg/ZCTs3NE5fdwMPVCRJp
         wgGb2levSUdUpFSwEJlhRrRC8NFcUS+8nYm6NgcZZJt2nAGCp1Hgq5JF1Hg5D3srXcao
         kz3gy1W/FjqXLxS95y4SyNs2FbP1pBJt2FY69Im0rNGwT1oQRM9pbCndHFT6ucDZqoSi
         /atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389580; x=1733994380;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2t7W4OrRjFhEWmecg84hD7xOx3YqRZ5sVEwAFgCNS2o=;
        b=uIIdp8+u8FZwMcMNvySogvUPw13q7fAGMXiMfL2qnfEn7mCmhTYD+tg43GqbsQxmSH
         7YO1kHEH7ys7Qh1nbFLVJUQPq+40N+Q3wyUo/DS5JhxuIuYffB3IQbQVhYW7N4zxr5oG
         HlcvssXdSSDpoVbIUzaWvNQN1xOc288bZuCBA0E3iau8tZIzvEWBfs3CxhIdFgg48DOd
         LCAomdW4sd9Xn/XBqcpz8lfVjWjZArNz8rlGv3J8oKpPIK+Dk5NGpU1SzRd7KcWM0bfS
         ig4q0Lbny9ZYTcVaAAg1cxo0F3pb0HWUw0T6U3VnrXLoWUA0fxiNlMeNWnLPqxp3XHAO
         ffvA==
X-Gm-Message-State: AOJu0YyQ8Wef/50cQg0Ivk4jMkHAR/IJD0uCnb6SgPVbzEav+dKgA7fG
	P5peD8LHVsjGGgj8EbRaxalWuHuFg6ZOYsQIX2syKoSBtYz6sIap5ctVE+g9Z/h8PflCCmF4dxx
	0
X-Gm-Gg: ASbGnctIe89sY9hYU8wxJdkSbbnNPwIpqTZgULpVp8r1yB0saMz4uekmBtP/q+hNyCm
	cVyXgrrzVMKamL5epXfu6b9cU5yMS+yXQMbpS7UyWy1JmA7jUE8dMvN2YsA/E/DIpNKib4/uRsj
	grIbw63sdg43HsmOZShD+Py8Jn0J/AdPu1dBlMvx4GJoj6ehxegN9BWdqigv+e5DtKg/0kztO4w
	SDAzdiO/a6Tz49j/kpkqlE04AXWoWucwuWRy8voT/4989stZcjd3VY9gEM+GOJMNshktVDmigg=
X-Google-Smtp-Source: AGHT+IE1W5whVS1H/s6P2CDbG6g4KdyVwl+f7pWy6cAjeTZPQLXiw15uiJrpsamNn8FKlX2vxkufWw==
X-Received: by 2002:a05:600c:3b24:b0:431:3933:1d30 with SMTP id 5b1f17b1804b1-434d346df9amr69721745e9.5.1733389579936;
        Thu, 05 Dec 2024 01:06:19 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113508sm16760695e9.35.2024.12.05.01.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:06:19 -0800 (PST)
Message-ID: <62539c75-8f4e-4e12-bcb4-55c46cdf646d@suse.com>
Date: Thu, 5 Dec 2024 11:06:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 08/23] x86/virt/tdx: Use all system memory when
 initializing TDX module as TDX memory
To: Mike Rapoport <rppt@kernel.org>, Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
 peterz@infradead.org, tony.luck@intel.com, tglx@linutronix.de, bp@alien8.de,
 mingo@redhat.com, hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
 rafael@kernel.org, david@redhat.com, dan.j.williams@intel.com,
 len.brown@intel.com, ak@linux.intel.com, isaku.yamahata@intel.com,
 ying.huang@intel.com, chao.gao@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, bagasdotme@gmail.com,
 sagis@google.com, imammedo@redhat.com
References: <cover.1699527082.git.kai.huang@intel.com>
 <87e19d1931e33bfaece5b79602cfbd517df891f1.1699527082.git.kai.huang@intel.com>
 <Z1Fc8g47vfpz9EVW@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <Z1Fc8g47vfpz9EVW@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5.12.24 г. 9:57 ч., Mike Rapoport wrote:
> Hi,
> 
> I've been auditing for_each_mem_pfn_range() users and it's usage in TDX is
> dubious for me.
> 
> On Fri, Nov 10, 2023 at 12:55:45AM +1300, Kai Huang wrote:
>>
>> As TDX-usable memory is a fixed configuration, take a snapshot of the
>> memory configuration from memblocks at the time of module initialization
>> (memblocks are modified on memory hotplug).  This snapshot is used to
> 
> AFAUI this could happen long after free_initmem() which discards all
> memblock data on x86.
 > >> enable TDX support for *this* memory configuration only.  Use a memory
>> hotplug notifier to ensure that no other RAM can be added outside of
>> this configuration.
>   
> ...
> 
>> +/*
>> + * Ensure that all memblock memory regions are convertible to TDX
>> + * memory.  Once this has been established, stash the memblock
>> + * ranges off in a secondary structure because memblock is modified
>> + * in memory hotplug while TDX memory regions are fixed.
>> + */
>> +static int build_tdx_memlist(struct list_head *tmb_list)
>> +{
>> +	unsigned long start_pfn, end_pfn;
>> +	int i, ret;
>> +
>> +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
> 
> Unles ARCH_KEEP_MEMBLOCK is defined this won't work after free_initmem()

TDX_HOST actually selects ARCH_KEEP_MEMBLOCK:

   6 config INTEL_TDX_HOST 

    5         bool "Intel Trust Domain Extensions (TDX) host support" 

    4         depends on CPU_SUP_INTEL 

    3         depends on X86_64 

    2         depends on KVM_INTEL 

    1         depends on X86_X2APIC 

1980         select ARCH_KEEP_MEMBLOCK 

    1         depends on CONTIG_ALLOC 

    2         depends on !KEXEC_CORE 

    3         depends on X86_MCE


<snip>


