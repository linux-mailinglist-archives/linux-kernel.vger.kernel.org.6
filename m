Return-Path: <linux-kernel+bounces-269569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9794346B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18847281506
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC01BD01F;
	Wed, 31 Jul 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZsexg4C"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51341BC076
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444619; cv=none; b=fpCZFnLqI0cSuyKmiBfs2PNrRPYBPIvPjh0keQ/Y0pksVpgWsXS/YUw7pqA/4Z/TuhmlbwDxVOzBYOoQYPilnNuk6iQA9UzI7Oh80i5Y+OEEN6EcJMIVAaQMmylfJCY804E1zThFM0PLGUvD66DUE2tz/wMGVSus2L53TPV3opQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444619; c=relaxed/simple;
	bh=aeQFg7Nie54KUl+2pRWiwd5tkZ0vPPGJFczYBYpW2Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A96o/CF7zr+8w6TrzsjhxsifngfvAc2+EsXGUmG27r2sa8HeW85UVpHoEGO8kn6eluzCSmzV6FFuzKWk+NL1qdzeqpRgannycT52vD/smvfYas9FGTx3k17CyBGxdu+ZobnBsc0QxZbnnx55kzkkjWH0QcN5Sxon9QCumSL0PrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZsexg4C; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd9e70b592so41147295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722444617; x=1723049417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ilntfWN3lYs3FB6Bjia0MpTA7Dk1xr92j1aQrq++ytk=;
        b=YZsexg4CMp2XPAPG8w2T8aZk/wnhg9ko3Q/1iB4YOjL37zNRE9cE/kV55QKVgvNfGL
         mECpwwPmkLENXASpAvgmNJib+5Irnu/4lMk3u2rcl3BlRF6Xz5IN4JbifPwChk5u7AFG
         3ItMPiyHQpi68jhETBRyq9N5z5h3v4SUHKJ3yhzYip/uqwLm87T6TP5loJf/KYITiCtv
         Zx5Ef1tWLGOPHIjMCxhbrInqT1jEbpfnjEcqbIvTYeBgaYIuxDmQVE+PZKXXpzzNGIy2
         AQ4HLV0987pj5JAUCZp0qAWoUbHEur+ZaVTJiyNEdWvNb1TS5rg5GUC+xV8C52vfmgS+
         efIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444617; x=1723049417;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilntfWN3lYs3FB6Bjia0MpTA7Dk1xr92j1aQrq++ytk=;
        b=luXGcm7l7jcSAgWa5oPEkhpdfon7KQU5JndYsTJ/mMk1Sd8JScB5vySTViHZVjYQyH
         0EuoDkgAVbqdYYO2kvvmnrrommnBnXJ+s/y7jd7ktBKta3Djna09GGPNB41R9Z2lejHZ
         JbCtksA+QyF1kk6cwc0JBnUZ1uneLtHvZqf7Zz0nPLVyTZau67JUMmUl7MzSQ1J1kycW
         QU5IXz5Sz0cNF16uI5ZnwWWrd9hT9UDdnfd4i9np/yg/O+ql2xQz/eb3PrFIFwdthwJ2
         4Uar+DGrUPJKC/HRp1kdSzGzFJAqLUaBrrkbxGi9XKo/jgxeVd9pdtSEDRWihsBfTNUl
         mcWg==
X-Forwarded-Encrypted: i=1; AJvYcCXwMBWFuLLZ0tnMm9JrW2qGiJ7b85UoosMmzwkeoRE2YnSDkQesjIQv0V5ZvT7iQt12HXpyGiBA3vxGGwFnAJGzwq/6ufegUeuOWWPy
X-Gm-Message-State: AOJu0YxyuW60q84osQNpgoE5iOuXCzWIiDAJEymuVuRBVO6yUwmTjnJD
	pabAxIOKQhJBZONOmiaEYyjmtqluRPLA+r1IFUJJuS+Lm9zD4pfH
X-Google-Smtp-Source: AGHT+IFVpsDi5I170GS4IJ76iFXlXoTvvaZLGl1wssADD0IBJ4+ASwr+0iiZPGVAvdZYAyT1b+VobQ==
X-Received: by 2002:a17:902:ec8b:b0:1fd:9c2d:2ef1 with SMTP id d9443c01a7336-1ff0485bb83mr154919185ad.53.1722444617161;
        Wed, 31 Jul 2024 09:50:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff0fead748sm79512925ad.74.2024.07.31.09.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:50:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <12868d4c-2c03-4193-83d5-56fbe5584950@roeck-us.net>
Date: Wed, 31 Jul 2024 09:50:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
References: <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240731163105.GG33588@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 09:31, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 09:17:44AM -0700, Linus Torvalds wrote:
>> On Wed, 31 Jul 2024 at 08:55, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> Right, so Thomas found that i386-pti fails to map the entire entry text.
>>> Specifically pti_clone_pgtable() hard relies -- and does not verify --
>>> that the start address is aligned to the given granularity.
>>>
>>> Now, i386 does not align __entry_text_start, and so the termination
>>> condition goes sideways and pte_clone_entry() does not always work right
>>> and it becomes a games of code layout roulette.
>>
>> Lovely.
> 
> :-)
> 
> This fixes the alignment assumptions and makes it all go again.
> 

Confirmed.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
> index 2e69abf4f852..bfdf5f45b137 100644
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -374,14 +374,14 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>   			 */
>   			*target_pmd = *pmd;
>   
> -			addr += PMD_SIZE;
> +			addr = round_up(addr + 1, PMD_SIZE);
>   
>   		} else if (level == PTI_CLONE_PTE) {
>   
>   			/* Walk the page-table down to the pte level */
>   			pte = pte_offset_kernel(pmd, addr);
>   			if (pte_none(*pte)) {
> -				addr += PAGE_SIZE;
> +				addr = round_up(addr + 1, PAGE_SIZE);
>   				continue;
>   			}
>   
> @@ -401,7 +401,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>   			/* Clone the PTE */
>   			*target_pte = *pte;
>   
> -			addr += PAGE_SIZE;
> +			addr = round_up(addr + 1, PAGE_SIZE);
>   
>   		} else {
>   			BUG();


