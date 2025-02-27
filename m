Return-Path: <linux-kernel+bounces-535699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE8A4762A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E47A35ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC502165F1;
	Thu, 27 Feb 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TZ61ZIpB"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672264A1A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639538; cv=none; b=aD63hxagkrsfuWrnVr9C6slSRv1VHgN5OuJB0eObu2oHqe8sWmvgNQmcMybv4ti4LUa+j24z4oXBuOeYPtDj2xLo/Wad/KxGM40MViOO7LCVG0D5D1jsCQth76fAfLwpt9/YuJOc0/d+URnFi/h90K4QOd+dJ57kkTS6WKaWjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639538; c=relaxed/simple;
	bh=f5F+05FWg7QH9vbkrSNw7cHzta28XzeRdqo1QWrj6K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1DwKmVoR/xQ8MgOyL0lrxG/nLTyEFEROkWf9pb4LJY2WVIzBBrYJIsyzI9oNLn4mjyKMd84Gh22hdaFaoElEifxYf//H3NfZ/vfqJ/QbU/nkPtHdNc6yq76Ag9sspI82O8B1febaUhQCGqUH/4kBSF06W937guWAVVY7cw4jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TZ61ZIpB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2234daaf269so13556965ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740639535; x=1741244335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfruRsY+T9lOEc8HQldVsXeT9YnNdxrpdhBm7o5Zvg8=;
        b=TZ61ZIpBRr4HvzWbMXeltj85/VIZ+Sx/jO/yYLLm0cnk5HInpJN/Hr1qmMcawAoS0p
         weWsaulZiSJSdF7GLKfP6espF525pZe0aibkmzRE3NVXWLGbv8fGlTbuoB5CCXtjc1Ij
         OjJ3YO1pzqA8J/2fpX2ewTYWc1HhTUQGvsUjlkLN746hswXPsCf7sOqXeFpWum2nGTbH
         xYmHNdQ3jfWC6ki546TkFYBP38wipg2i7QZtmbzD/Z5LIb7YGYkGfZJGxzZUsGxWfhOE
         WNZW93ADvPlj+BQDEd2mPFO2qtTr+ffAll+6I9Nbwz97JzOCrSotSETNcu4AQdofhCxx
         ebhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639535; x=1741244335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MfruRsY+T9lOEc8HQldVsXeT9YnNdxrpdhBm7o5Zvg8=;
        b=h96Dns9iDUCkcGqMnXLgC4tbJKn8EY27N1Vr2PYee6bvZyEG08aeL/LY1PeuQTpZc9
         1bhuMAoU2jqNuE23laOIHQbGBfsmiBbM+AVRcqPomWxyuwlHLg0iWloVRG2efdC9wnnK
         RGm7kO7KOLqa+uTeZddzDJ2ft8yt1YaHtqReylpTRgcyAJiqp/K07azoA1WhjYtf5Te9
         sScVgCgEUebaM6A0CjBTfZhm5PFx1x7DqNJZlR2SzMwoj5sNhxs6rIQ6Vy0FlL7AOhYC
         3ayf4uNeFeQToTdd7g5uNrIM1LWjA1RQRdQqV+o7bsg/B+88ysKAfrfUtJ6N54QalTYg
         dByg==
X-Forwarded-Encrypted: i=1; AJvYcCWxpgA95xVaXZ3uxkFe4MuiIYZWxnQav/DuYPh57coSLSj7kAuixQB0cAAMTgXhW3xrZ07KwN2L8NxbJ+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5tt+gcsx6LymcmlsJ1IjqlBca/4TdjJdkckHMg6l4NReAMuI
	Ixj7qAfovgoeB9Y2d67OYqrC7AKRjlb910B7u3qxfUNXE/n+6LHMtk7SVieT4yGgzxstXJ6jxM1
	C738=
X-Gm-Gg: ASbGncvt+Qv3MTw113/JIsb+1f1wmwPzoAwFRXlE61sWn56b/r7bkNVURQw52ZwiFuC
	8ywMpmWy2whNhlcz8jQteKNTrr/N7xorYuQ+KAtcWkyz5zJ9JstBt8if3AnexMVlNQQyXasNaYM
	L0c073jUljZktLULkhA108tj5GKwGBOGjYmqSmXd+fN89pXBR7ICtA4cS5HqfkahyZEF8Mq1a34
	+N3BszFE+jAkA1puMR40x3Sk1ITd3P5v4dXrvpxlcR/qsrIC/mcRSIk9jelYFPNoQCpcEJhTzYg
	lUCM2wTKMsEH+dZenhzXKjX/Zjs4DoKYRj1cjwhn1UybcllK/A==
X-Google-Smtp-Source: AGHT+IGUjTn00KPpX5mYfIBAiaODZc50JFY37y/Z4PuASFcLngKFz8EgyB5ISCL6z4hnVmppA/jlzA==
X-Received: by 2002:a17:903:1984:b0:223:4b88:77ff with SMTP id d9443c01a7336-2234b887eb6mr25466455ad.6.1740639535586;
        Wed, 26 Feb 2025 22:58:55 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050d7c1sm7272975ad.198.2025.02.26.22.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 22:58:55 -0800 (PST)
Message-ID: <6281ffc9-398e-44b9-a95c-2527004e09b7@bytedance.com>
Date: Thu, 27 Feb 2025 14:58:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_PT_RECLAIM
To: Johannes Weiner <hannes@cmpxchg.org>, peterz@infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250226183013.GB1042@cmpxchg.org>
 <a77923d3-ce26-4e29-bb98-b908ce2355c2@bytedance.com>
 <20250227060820.GC110982@cmpxchg.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250227060820.GC110982@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 2/27/25 2:08 PM, Johannes Weiner wrote:
> On Thu, Feb 27, 2025 at 11:04:51AM +0800, Qi Zheng wrote:
>> Hi Johannes,
>>
>> On 2/27/25 2:30 AM, Johannes Weiner wrote:
>>> Does PT_RECLAIM need to be configurable by the user?
>>
>> The PT_RECLAIM will select MMU_GATHER_RCU_TABLE_FREE, but not all archs
>> support MMU_GATHER_RCU_TABLE_FREE, and even before Rik's a37259732a7dc
>> ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional"), x86 only
>> supports MMU_GATHER_RCU_TABLE_FREE in the case of PARAVIRT.
>>
>> Therefore, PT_RECLAIM also implies the meaning of enabling
>> MMU_GATHER_RCU_TABLE_FREE, so I made it user-configurable. And I just
>> thought that as a new feature, it would be better to give users the
>> ability to turn it on and off.
> 
> New *features*, yes - something that has a significant enough cost
> that clearly not all users want to pay for the benefits.

Got it.

> 
> But it's hard to imagine anybody would WANT to keep the page tables
> around if they madvised away all the pages inside of them. It's a
> great optimization, what would be a reason to opt out?

OK, now I think it makes sense to change it to 'def_bool y'.

> 
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 2761098dbc1a..99383c93db33 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1309,16 +1309,9 @@ config ARCH_SUPPORTS_PT_RECLAIM
>>>    	def_bool n
>>>    
>>>    config PT_RECLAIM
>>> -	bool "reclaim empty user page table pages"
>>> -	default y
>>> +	def_bool y
>>>    	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>>    	select MMU_GATHER_RCU_TABLE_FREE
>>> -	help
>>> -	  Try to reclaim empty user page table pages in paths other than munmap
>>> -	  and exit_mmap path.
>>> -
>>> -	  Note: now only empty user PTE page table pages will be reclaimed.
>>> -
>>
>> Maybe keep the help information?
> 
> I don't find it very helpful :( Which "other paths?" It doesn't
> explain any pros and cons, and why anybody might choose to enable or
> disable it. The Note repeats what's in the sentence before it.

Sorry about that. :(

> 
> Maybe I'm missing something. Could this not just be an #ifdef block
> inside mm/madvise.c, instead of living inside a new file with two new
> config symbols?
> 
> #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> ...
> #endif
> 
> Is there an arch-specific feature that it requires besides
> MMU_GATHER_RCU_TABLE_FREE such that only x86 supports it now?

No, it only needs MMU_GATHER_RCU_TABLE_FREE.

> 
> And why *does* it require MMU_GATHER_RCU_TABLE_FREE?

Because in the madvise(MADV_DONTNEED) path, mmu_gather has been used
to batch flush tlb and free physical pages. It is a better choice to
free PTE pages in this ways as well.

And because PT_RECLAIM needs rcu, we need MMU_GATHER_RCU_TABLE_FREE to
make pte_free_tlb() free PTE pages through rcu. Of course, we also need
to modify __tlb_remove_table_one() to make it use rcu as well.

> 
> Documentation/mm/process_addrs.rst explains why you need rcu, but
> there is free_pte_defer() that THP was using long before x86 needed
> MMU_GATHER_RCU_TABLE_FREE. It seems to me if you could use that, this
> feature would also work fine on architectures that do not generally
> need RCU for flush & frees otherwise. So is the main issue that there

As mentioned above, we want to flush & frees in batches, so we don't
use pte_free_defer().

> just isn't an explicitly deferred variant of pte_free_tlb()?

The pte_free_defer() seems to have been adapted to all archs, so I
wonder if all archs can support MMU_GATHER_RCU_TABLE_FREE, so that
pte_free_tlb() will always use rcu to free PTE pages.

Maybe I missed something.

+Peter.

> 
> If so, this is a fairly non-obvious dependency that should be
> documented. It would help somebody trying to port this to a !RCU
> mmu_gather arch.
> 
> And I apologize if all this was discussed before. But if it was, the
> conclusions should be in the changelog or in code comments. This is a
> very delicate synchronization scheme that I think deserves explicit
> documentation somewhere.


